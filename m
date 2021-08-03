Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E73DF6AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 22:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhHCU7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 16:59:30 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:60866 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhHCU73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:59:29 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB1TC-006YXJ-2M; Tue, 03 Aug 2021 20:57:02 +0000
Date:   Tue, 3 Aug 2021 20:57:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v5 03/12] Turn fault_in_pages_{readable,writeable} into
 fault_in_{readable,writeable}
Message-ID: <YQmtnuqDwBIBf4N+@zeniv-ca.linux.org.uk>
References: <20210803191818.993968-1-agruenba@redhat.com>
 <20210803191818.993968-4-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803191818.993968-4-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:18:09PM +0200, Andreas Gruenbacher wrote:
> Turn fault_in_pages_{readable,writeable} into versions that return the number
> of bytes faulted in instead of returning a non-zero value when any of the
> requested pages couldn't be faulted in.  This supports the existing users that
> require all pages to be faulted in, but also new users that are happy if any
> pages can be faulted in.
> 
> Neither of these functions is entirely trivial and it doesn't seem useful to
> inline them, so move them to mm/gup.c.
> 
> Rename the functions to fault_in_{readable,writeable} to make sure that code
> that uses them can be fixed instead of breaking silently.

Sigh...  We'd already discussed that; it's bloody pointless.  Making short
fault-in return success - absolutely.  Reporting exact number of bytes is
not going to be of any use to callers.

Please, don't.
