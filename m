Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB358577F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jul 2022 02:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiG3ADU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 20:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3ADT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 20:03:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ACE43311
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 17:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jZTXnZCkES6wzSPyhtcYp7hetRxIybqtgcazoIDp/uE=; b=ZdO2h0EsQ5Hb22jUa14hvNqxNf
        5VDikyIuaTHoOPtn1Fj0R/6F2IMDWGMySlmNzfJM8zNnxjSPVqExON+MTd2k7TPxWim6hYLLlAwMJ
        xGGzj/f6ix8ABjXl/8xF0o1EhhZb2jKgqCOCMeq/GkTTnI46w0gabmxOmyE3MkxKGzuEoZEHHGALf
        MDQUt1l1OXfYZGf5jNY/x+LUGX41tqduOK9Mb+240BQKOLpVv15HUC24V//sxEC2gn0eMUWqMe8WV
        YX+uX5AkOPYLmg+3ZJlrNdluybtjdE91b/z3beJ8ZHEj8qb2B1MbYEB07eId2X2HXTwU4Lb0AJthG
        DVdOA9Iw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oHZwo-00HCy0-Lx;
        Sat, 30 Jul 2022 00:03:14 +0000
Date:   Sat, 30 Jul 2022 01:03:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 9/44] new iov_iter flavour - ITER_UBUF
Message-ID: <YuR1QsxRId9TUV8o@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-9-viro@zeniv.linux.org.uk>
 <YuJc/gfGDj4loOqt@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <YuQXE+MBAHVhdWW3@ZenIV>
 <YuRNTTCgc+dp2TD6@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuRNTTCgc+dp2TD6@tuxmaker.boeblingen.de.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 11:12:45PM +0200, Alexander Gordeev wrote:
> On Fri, Jul 29, 2022 at 06:21:23PM +0100, Al Viro wrote:
> > > Hi Al,
> > > 
> > > This changes causes sendfile09 LTP testcase fail in linux-next
> > > (up to next-20220727) on s390. In fact, not this change exactly,
> > > but rather 92d4d18eecb9 ("new iov_iter flavour - ITER_UBUF") -
> > > which differs from what is posted here.
> > > 
> > > AFAICT page_cache_pipe_buf_confirm() encounters !PageUptodate()
> > > and !page->mapping page and returns -ENODATA.
> > > 
> > > I am going to narrow the testcase and get more details, but please
> > > let me know if I am missing something.
> > 
> > Grrr....
> > 
> > -               } else if (iter_is_iovec(to)) {
> > +               } else if (!user_backed_iter(to)) {
> > 
> > in mm/shmem.c.  Spot the typo...
> > 
> > Could you check if replacing that line with
> > 		} else if (user_backed_iter(to)) {
> > 
> > fixes the breakage?
> 
> Yes, it does! So just to be sure - this is the fix:

FWIW, there'd been another braino, caught by test from Hugh Dickins;
this one in ITER_PIPE: allocate buffers as we go in copy-to-pipe primitives

Incremental follows; folded and pushed out.

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 642841ce7595..939078ffbfb5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -469,7 +469,7 @@ static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 		struct page *page = append_pipe(i, n, &off);
 		chunk = min_t(size_t, n, PAGE_SIZE - off);
 		if (!page)
-			break;
+			return bytes - n;
 		memcpy_to_page(page, off, addr, chunk);
 		addr += chunk;
 	}
@@ -774,7 +774,7 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 		char *p;
 
 		if (!page)
-			break;
+			return bytes - n;
 		chunk = min_t(size_t, n, PAGE_SIZE - off);
 		p = kmap_local_page(page);
 		memset(p + off, 0, chunk);
diff --git a/mm/shmem.c b/mm/shmem.c
index 6b83f3971795..6c8a84a1fbbb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2603,7 +2603,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			ret = copy_page_to_iter(page, offset, nr, to);
 			put_page(page);
 
-		} else if (!user_backed_iter(to)) {
+		} else if (user_backed_iter(to)) {
 			/*
 			 * Copy to user tends to be so well optimized, but
 			 * clear_user() not so much, that it is noticeably
