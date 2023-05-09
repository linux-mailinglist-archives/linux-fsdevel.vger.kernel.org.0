Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130956FCE70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 21:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjEITTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 15:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEITTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 15:19:25 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B1C4239
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 12:19:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7575fc62c7aso377850585a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683659961; x=1686251961;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ncIdxq+s6e7PHgHqdU6MtN0Ghm+TIz8m0btjprVaInQ=;
        b=yqgd4aRsRKTcq8htOIadwJl/9OwA1DDCIIcBjMRTcXJ8Ue1QsW2oVWXylY69hy9qmm
         LDzVq0u/zdCFedu1dsWjKQlM53+b4YXmaC8GBdqFMDnTEuhRuRnotcJH4RMUuejyYgv+
         H9cwm4u3jJg1jqnNsQ2NgCIRwERhNw6Ud5LeEnXJEZ0c5QYUhPziTf6xI2KHiSdoWsto
         O3StfRrMGDoMqtmbctJ+3eB43KhfD1hShm2SbBNQ5ULSDkTuwUwlrf4dOYmC7AW81H3K
         QONqXW/6jFzP88UyJ3cpgf+e7pnpD6ikqPPy21xzUCJ8yFEujmlj6+7ul1zTj9HG+Ipp
         j0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683659961; x=1686251961;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncIdxq+s6e7PHgHqdU6MtN0Ghm+TIz8m0btjprVaInQ=;
        b=XB9YX9Xd3VNWhW2FCFU185jbU/X0vZqK5Eb5CeI0SGvYZqOOv7o/EbB/14S1Wnmdwd
         /YpDp6isIIReaWM0c7U86OV5ddB3Tq0xYjGDFN9wXAOsVJ7uwDH1EYRgcZ8IvWZfaifE
         t/JuQYcM5tVmxZ2EPpAS4xs+wWeQCgr+FELmT3+cXUAjsNbEfalPhDr2hf3uRqqRvV+k
         LvtbF9sJtoLMU3aPQU1dphxGDwIhMXHWYVCvSSk7Fah/lUS4lkkhQTbBW7PhI8ovbTys
         3K2yI9YTdQiMFVTwNF0jumJBzUYRQlERvgugOdkQLR32cNO0GB2CVmbar+MdJZADJcMh
         nU5w==
X-Gm-Message-State: AC+VfDyAysCxHDC2XK929/g3+WRibZYlioXWcGIy4WTufbKBAj1Ik3G1
        xOqoAQ72pRYTAbGnInqsX7bHOg==
X-Google-Smtp-Source: ACHHUZ7dEwDVwNDnKLlFr1kt52j6G7sN6LzdN0IYwishxAudW8Ajtwwq1oce8EAghBtXgS+CHbMqKA==
X-Received: by 2002:ac8:5c50:0:b0:3ef:25ad:27fb with SMTP id j16-20020ac85c50000000b003ef25ad27fbmr25568244qtj.30.1683659960948;
        Tue, 09 May 2023 12:19:20 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id g11-20020a05620a13cb00b007456b51ee13sm3476717qkl.16.2023.05.09.12.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:19:20 -0700 (PDT)
Date:   Tue, 9 May 2023 15:19:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
Message-ID: <20230509191918.GB18828@cmpxchg.org>
References: <20230506160415.2992089-1-willy@infradead.org>
 <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 06, 2023 at 10:04:48AM -0700, Linus Torvalds wrote:
> On Sat, May 6, 2023 at 9:35 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And yes, the simplest fix for the "wrong test" would be to just add a
> > new "out_nofolio" error case after "out_retry", and use that.
> >
> > However, even that seems wrong, because the return value for that path
> > is the wrong one.
> 
> Actually, my suggested patch is _also_ wrong.
> 
> The problem is that we do need to return VM_FAULT_RETRY to let the
> caller know that we released the mmap_lock.
> 
> And once we return VM_FAULT_RETRY, the other error bits don't even matter.
> 
> So while I think the *right* thing to do is to return VM_FAULT_OOM |
> VM_FAULT_RETRY, that doesn't actually end up working, because if
> VM_FAULT_RETRY is set, the caller will know that "yes, mmap_lock was
> dropped", but the callers will also just ignore the other bits and
> unconditionally retry.
> 
> How very very annoying.
> 
> This was introduced several years ago by commit 6b4c9f446981
> ("filemap: drop the mmap_sem for all blocking operations").
> 
> Looking at that, we have at least one other similar error case wrong
> too: the "page_not_uptodate" case carefully checks for IO errors and
> retries only if there was no error (or for the AOP_TRUNCATED_PAGE)
> case.
> 
> For an actual IO error on page reading, it returns VM_FAULT_SIGBUS.
> 
> Except - again - for that "if (fpin) goto out_retry" case, which will
> just return VM_FAULT_RETRY and retry the fault.
> 
> I do not believe that retrying the fault is the right thing to do when
> we ran out of memory, or when we had an IO error, and I do not think
> it was intentional that the error handling was changed.

This is a while ago and the code has changed quite a bit since, so
bear with me.

Originally, we only ever did a maximum of two tries: one where the
lock might be dropped to kick off IO, then a synchronous one. IIRC the
thinking at the time was that events like OOMs and IO failures are
rare enough that doing the retry anyway (even if somewhat pointless)
and reacting to the issue then (if it persisted) was a tradeoff to
keep the retry logic simple.

Since 4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times") we
don't clear FAULT_FLAG_ALLOW_RETRY anymore though, and we might see
more than one loop. At least outside the page cache. So I agree it
makes sense to look at the return value more carefully and act on
errors more timely in the arch handler.

Draft patch below. It survives a boot and a will-it-scale smoke test,
but I haven't put it through the grinder yet.

One thing that gave me pause is this comment:

	/*
	 * If we need to retry the mmap_lock has already been released,
	 * and if there is a fatal signal pending there is no guarantee
	 * that we made any progress. Handle this case first.
	 */

I think it made sense when it was added in 26178ec11ef3 ("x86: mm:
consolidate VM_FAULT_RETRY handling"). But after 39678191cd89
("x86/mm: use helper fault_signal_pending()") it's in a misleading
location, since the signal handling is above it.

So I'm removing it, but please let me know if I missed something.

---
 arch/x86/mm/fault.c | 40 +++++++++++++++++++++++-----------------
 mm/filemap.c        | 18 +++++++++++-------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e4399983c50c..f1d242be723f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1456,20 +1456,15 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 
 	/*
-	 * If we need to retry the mmap_lock has already been released,
-	 * and if there is a fatal signal pending there is no guarantee
-	 * that we made any progress. Handle this case first.
+	 * If we need to retry the mmap_lock has already been released.
 	 */
-	if (unlikely(fault & VM_FAULT_RETRY)) {
-		flags |= FAULT_FLAG_TRIED;
-		goto retry;
-	}
+	if (likely(!(fault & VM_FAULT_RETRY)))
+		mmap_read_unlock(mm);
 
-	mmap_read_unlock(mm);
 #ifdef CONFIG_PER_VMA_LOCK
 done:
 #endif
-	if (likely(!(fault & VM_FAULT_ERROR)))
+	if (likely(!(fault & (VM_FAULT_ERROR|VM_FAULT_RETRY))))
 		return;
 
 	if (fatal_signal_pending(current) && !user_mode(regs)) {
@@ -1493,15 +1488,26 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 * oom-killed):
 		 */
 		pagefault_out_of_memory();
-	} else {
-		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
-			     VM_FAULT_HWPOISON_LARGE))
-			do_sigbus(regs, error_code, address, fault);
-		else if (fault & VM_FAULT_SIGSEGV)
-			bad_area_nosemaphore(regs, error_code, address);
-		else
-			BUG();
+		return;
+	}
+
+	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
+		     VM_FAULT_HWPOISON_LARGE)) {
+		do_sigbus(regs, error_code, address, fault);
+		return;
 	}
+
+	if (fault & VM_FAULT_SIGSEGV) {
+		bad_area_nosemaphore(regs, error_code, address);
+		return;
+	}
+
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
+	}
+
+	BUG();
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index b4c9bd368b7e..f97ca5045c19 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3290,10 +3290,11 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 					  FGP_CREAT|FGP_FOR_MMAP,
 					  vmf->gfp_mask);
 		if (IS_ERR(folio)) {
+			ret = VM_FAULT_OOM;
 			if (fpin)
 				goto out_retry;
 			filemap_invalidate_unlock_shared(mapping);
-			return VM_FAULT_OOM;
+			return ret;
 		}
 	}
 
@@ -3362,15 +3363,18 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
-	if (fpin)
-		goto out_retry;
 	folio_put(folio);
-
-	if (!error || error == AOP_TRUNCATED_PAGE)
+	folio = NULL;
+	if (!error || error == AOP_TRUNCATED_PAGE) {
+		if (fpin)
+			goto out_retry;
 		goto retry_find;
+	}
+	ret = VM_FAULT_SIGBUS;
+	if (fpin)
+		goto out_retry;
 	filemap_invalidate_unlock_shared(mapping);
-
-	return VM_FAULT_SIGBUS;
+	return ret;
 
 out_retry:
 	/*
-- 
2.40.1
