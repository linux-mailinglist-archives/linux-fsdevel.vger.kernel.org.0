Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493F19C760
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 04:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfHZCsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 22:48:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35910 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHZCsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 22:48:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i253e-0002O9-As; Mon, 26 Aug 2019 02:48:38 +0000
Date:   Mon, 26 Aug 2019 03:48:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: broken userland ABI in configfs binary attributes
Message-ID: <20190826024838.GN1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	In commit 03607ace807b (configfs: implement binary attributes)
we have serious trouble:

+* Binary attributes, which are somewhat similar to sysfs binary attributes,
+but with a few slight changes to semantics.  The PAGE_SIZE limitation does not
+apply, but the whole binary item must fit in single kernel vmalloc'ed buffer.
+The write(2) calls from user space are buffered, and the attributes'
+write_bin_attribute method will be invoked on the final close, therefore it is
+imperative for user-space to check the return code of close(2) in order to
+verify that the operation finished successfully.

	This is completely broken.  ->release() is too late to return any errors -
they won't reach the caller of close(2).  ->flush() _is_ called early enough to
pass return value to userland, but it's called every time descriptor is removed
from descriptor table.  IOW, if userland e.g. python code from hell has written
some data to the attribute in question, then called a function that has ended
up calling something in some misbegotten library that spawned a child, had it
run and waited for it to exit, your ->flush() will be called twice.  Which is
fine for something like NFS sending the dirty data to server and checking that
there's nothing left, but not for this kind of "gather data, then commit the
entire thing at once" kind of interfaces.

	AFAICS, there's only one user in the tree right now (acpi/table/*/aml);
no idea what drives the userland side.

	We might be able to paper over that mess by doing what /dev/st does -
checking that file_count(file) == 1 in ->flush() instance and doing commit
there in such case.  It's not entirely reliable, though, and it's definitely
not something I'd like to see spreading.

	Folks, please don't do that kind of userland ABIs; that kind of
implicit commit on the final close is OK only if there's no error to
report (e.g. if all checks can be done at write() time).  Otherwise it's
an invitation for trouble.

	And *ANYTHING* that tries to return an error from ->release() is
very suspicious, no matter what.  Again, in ->release() it's too late
to return an error.
