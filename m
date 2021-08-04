Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C96E3DFCD9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 10:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhHDI2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbhHDI2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:28:48 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B287C06179B
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Aug 2021 01:28:36 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id g6so747458qvj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=SJ2ofhqIP5yg8wFYW3H98xh0sTyZWIb8UKLy27YOElY=;
        b=k+oQ7MbnPh7jBpOUC7EsDMpV38QX19cwe4C85+B9qILlXkZSNS8hvtB6gAB1LYREcm
         ljERWYRIRU+17oh455TM2moKmldVBJv03EppubSuEZoHT4E2udS8orFinBWu/A3OtF7k
         XOU0rpj52v9BNHs6pDY7pWRAhZqYP2yj+50HYiply6v1plJQlwJ2rddrX4D/UYJUeH7U
         IJOAT7YNmRdFW7W0ThZ0NojZR686n6KuhcYONzyVJhUj7tmCaGDUvcHrJ0zLRZeMOo1t
         sJ3mTYkOkgawGxTVRMNRA4ftT3zDMMOIB8EDtV+pJQB/86/GRgVj0GbqczagNaArMBIu
         rm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=SJ2ofhqIP5yg8wFYW3H98xh0sTyZWIb8UKLy27YOElY=;
        b=P9OSXY3ncMraVA4TKv8Sa3MjbqIXOs0PJt9Fz9QcuPlZa2aretmasslq4omVe88wCS
         qRCI3Q9Kl6mqSECbqfE+uQdURCVNyk52BUt/LoHPsk8QrJVaY4RnxSn2zVtJU311YaQv
         Pl3KRRHJAXF4GWqzVWQT3+oSMYOF+lzMHZxbvWrbRLJDauybWENTnk4wG+rGDrrlf/ZJ
         ZEDjx2GUCu8uxCZv2qlTI3kFZtRyYuvo5cUbH2FfD/yyr+W+DUU68bDHRxMtXSjzh7xp
         8KAJJbNwcy2EpLYmefAwe/wbwrcwqaPbn49rjhz9Tb9Wudo2j3xLr6dk4un23VHOHJbj
         soGA==
X-Gm-Message-State: AOAM533DqIQLYSgPkXPObnUzRvFaoSNcli9DNVdJYc1guj5LlCTS4ZY1
        A+Sv/meu6JUt4dugyAEIWiSdKA==
X-Google-Smtp-Source: ABdhPJz/cw1r8E/5Ib+MNljWXsCPw1e6Y5EJGl4Bqx0w0vCtfXsHxUNEK7swwPIkMnc2KrISA5dqXg==
X-Received: by 2002:a0c:ed25:: with SMTP id u5mr24628515qvq.56.1628065714889;
        Wed, 04 Aug 2021 01:28:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c18sm569797qtb.61.2021.08.04.01.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 01:28:34 -0700 (PDT)
Date:   Wed, 4 Aug 2021 01:28:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 06/16] huge tmpfs: shmem_is_huge(vma, inode, index)
In-Reply-To: <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com>
Message-ID: <8baad8b2-8f7a-2589-ce21-4135a59c5dc6@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com> <e7374d7e-4773-aba1-763-8fa2c953f917@google.com>
 <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2 Aug 2021, Yang Shi wrote:
> On Sat, Jul 31, 2021 at 10:22 PM Hugh Dickins <hughd@google.com> wrote:
> > On Fri, 30 Jul 2021, Yang Shi wrote:
> > > On Fri, Jul 30, 2021 at 12:42 AM Hugh Dickins <hughd@google.com> wrote:
> > > >
> > > > Extend shmem_huge_enabled(vma) to shmem_is_huge(vma, inode, index), so
> > > > that a consistent set of checks can be applied, even when the inode is
> > > > accessed through read/write syscalls (with NULL vma) instead of mmaps
> > > > (the index argument is seldom of interest, but required by mount option
> > > > "huge=within_size").  Clean up and rearrange the checks a little.
> > > >
> > > > This then replaces the checks which shmem_fault() and shmem_getpage_gfp()
> > > > were making, and eliminates the SGP_HUGE and SGP_NOHUGE modes: while it's
> > > > still true that khugepaged's collapse_file() at that point wants a small
> > > > page, the race that might allocate it a huge page is too unlikely to be
> > > > worth optimizing against (we are there *because* there was at least one
> > > > small page in the way), and handled by a later PageTransCompound check.
> > >
> > > Yes, it seems too unlikely. But if it happens the PageTransCompound
> > > check may be not good enough since the page allocated by
> > > shmem_getpage() may be charged to wrong memcg (root memcg). And it
> > > won't be replaced by a newly allocated huge page so the wrong charge
> > > can't be undone.
> >
> > Good point on the memcg charge: I hadn't thought of that.  Of course
> > it's not specific to SGP_CACHE versus SGP_NOHUGE (this patch), but I
> > admit that a huge mischarge is hugely worse than a small mischarge.
> 
> The small page could be collapsed to a huge page sooner or later, so
> the mischarge may be transient. But huge page can't be replaced.

You're right, if all goes well, the mischarged small page could be
collapsed to a correctly charged huge page sooner or later (but all
may not go well), whereas the mischarged huge page is stuck there.

> 
> >
> > We could fix it by making shmem_getpage_gfp() non-static, and pointing
> > to the vma (hence its mm, hence its memcg) here, couldn't we?  Easily
> > done, but I don't really want to make shmem_getpage_gfp() public just
> > for this, for two reasons.
> >
> > One is that the huge race it just so unlikely; and a mischarge to root
> > is not the end of the world, so long as it's not reproducible.  It can
> > only happen on the very first page of the huge extent, and the prior
> 
> OK, if so the mischarge is not as bad as what I thought in the first place.
> 
> > "Stop if extent has been truncated" check makes sure there was one
> > entry in the extent at that point: so the race with hole-punch can only
> > occur after we xas_unlock_irq(&xas) immediately before shmem_getpage()
> > looks up the page in the tree (and I say hole-punch not truncate,
> > because shmem_getpage()'s i_size check will reject when truncated).
> > I don't doubt that it could happen, but stand by not optimizing against.
> 
> I agree the race is so unlikely and it may be not worth optimizing
> against it right now, but a note or a comment may be worth.

Thanks, but despite us agreeing that the race is too unlikely to be worth
optimizing against, it does still nag at me ever since you questioned it:
silly, but I can't quite be convinced by my own dismissals.

I do still want to get rid of SGP_HUGE and SGP_NOHUGE, clearing up those
huge allocation decisions remains the intention; but now think to add
SGP_NOALLOC for collapse_file() in place of SGP_NOHUGE or SGP_CACHE -
to rule out that possibility of mischarge after racing hole-punch,
no matter whether it's huge or small.  If any such race occurs,
collapse_file() should just give up.

This being the "Stupid me" SGP_READ idea, except that of course would
not work: because half the point of that block in collapse_file() is
to initialize the !Uptodate pages, whereas SGP_READ avoids doing so.

There is, of course, the danger that in fixing this unlikely mischarge,
I've got the code wrong and am introducing a bug: here's what a 17/16
would look like, though it will be better inserted early.  I got sick
of all the "if (page "s, and was glad of the opportunity to fix that
outdated "bring it back from swap" comment - swap got done above.

What do you think? Should I add this in or leave it out?

Thanks,
Hugh

--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -108,6 +108,7 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 /* Flag allocation requirements to shmem_getpage */
 enum sgp_type {
 	SGP_READ,	/* don't exceed i_size, don't allocate page */
+	SGP_NOALLOC,	/* like SGP_READ, but do use fallocated page */
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
 	SGP_WRITE,	/* may exceed i_size, may allocate !Uptodate page */
 	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1721,7 +1721,7 @@ static void collapse_file(struct mm_struct *mm,
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_getpage(mapping->host, index, &page,
-						  SGP_CACHE)) {
+						  SGP_NOALLOC)) {
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1903,26 +1903,27 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		return error;
 	}
 
-	if (page)
+	if (page) {
 		hindex = page->index;
-	if (page && sgp == SGP_WRITE)
-		mark_page_accessed(page);
-
-	/* fallocated page? */
-	if (page && !PageUptodate(page)) {
+		if (sgp == SGP_WRITE)
+			mark_page_accessed(page);
+		if (PageUptodate(page))
+			goto out;
+		/* fallocated page */
 		if (sgp != SGP_READ)
 			goto clear;
 		unlock_page(page);
 		put_page(page);
-		page = NULL;
-		hindex = index;
 	}
-	if (page || sgp == SGP_READ)
-		goto out;
+
+	*pagep = NULL;
+	if (sgp == SGP_READ)
+		return 0;
+	if (sgp == SGP_NOALLOC)
+		return -ENOENT;
 
 	/*
-	 * Fast cache lookup did not find it:
-	 * bring it back from swap or allocate.
+	 * Fast cache lookup and swap lookup did not find it: allocate.
 	 */
 
 	if (vma && userfaultfd_missing(vma)) {
