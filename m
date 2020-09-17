Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB526E471
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgIQQpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 12:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgIQQoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:44:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A69C06174A;
        Thu, 17 Sep 2020 09:44:43 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIx1M-000VUC-TD; Thu, 17 Sep 2020 16:44:33 +0000
Date:   Thu, 17 Sep 2020 17:44:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@redhat.com>
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: slab-out-of-bounds in iov_iter_revert()
Message-ID: <20200917164432.GU3421308@ZenIV.linux.org.uk>
References: <20200911215903.GA16973@lca.pw>
 <20200911235511.GB3421308@ZenIV.linux.org.uk>
 <87ded87d232d9cf87c9c64495bf9190be0e0b6e8.camel@redhat.com>
 <20200917020440.GQ3421308@ZenIV.linux.org.uk>
 <20200917021439.GA31009@ZenIV.linux.org.uk>
 <e815399a4a123aa7cc096a55055f103874db1e75.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e815399a4a123aa7cc096a55055f103874db1e75.camel@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:10:27AM -0400, Qian Cai wrote:

> [   81.942909]  generic_file_read_iter+0x23b/0x4b0
> [   81.942918]  fuse_file_read_iter+0x280/0x4e0 [fuse]
> [   81.942931]  ? fuse_direct_IO+0xd30/0xd30 [fuse]
> [   81.942949]  ? _raw_spin_lock_irqsave+0x80/0xe0
> [   81.942957]  ? timerqueue_add+0x15e/0x280
> [   81.942960]  ? _raw_spin_lock_irqsave+0x80/0xe0
> [   81.942966]  new_sync_read+0x3b7/0x620
> [   81.942968]  ? __ia32_sys_llseek+0x2e0/0x2e0

Interesting...  Basic logics in there:
	->direct_IO() might consume more (on iov_iter_get_pages()
and friends) than it actually reads.  We want to revert the
excess.  Suppose by the time we call ->direct_IO() we had
N bytes already consumed and C bytes left.  We expect that
after ->direct_IO() returns K, we have C' bytes left, N + (C - C')
consumed and N + K out of those actually read.  So we revert by
C - K - C'.  You end up trying to revert beyond the beginning.

	Use of iov_iter_truncate() is problematic here, since it
changes the amount of data left without having consumed anything.
Basically, it changes the position of end, and the logics in the
caller expects that to remain unchanged.  iov_iter_reexpand() use
should restore the position of end.

	How much IO does it take to trigger that on your reproducer?
