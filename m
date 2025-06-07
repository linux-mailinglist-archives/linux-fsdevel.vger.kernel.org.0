Return-Path: <linux-fsdevel+bounces-50896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD3AD0B7D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 08:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256357A6696
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 06:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E797A25A322;
	Sat,  7 Jun 2025 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="XlSgTddv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0F23F41A
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749278420; cv=none; b=odBnWqaNslPQuCqeG9Gx4rpQtc0fuY/5kN5C84NM0s9IVbzd8YIY9HlUX7VKOEdpUFBymNy2dEE0xphbgFBa3aUfJXWR+Pbz9C9ttPGvERzQsTlvepEzrlTb2viHRyjvL6uHyT5obV+NYULXDtsMItV2pqSFP5XRhcYM8zt900o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749278420; c=relaxed/simple;
	bh=8xK9cYLtkyMChjhj6zDEoAbzPlavCj2F/8VVwgmH0dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BaCT1fgbeMy6kDyagxLKg+FEp14Gi3qrLPk8S6105CsPazuxrfZb5T+U7e1bAAjQG1ju63zipRUHwFa/mMJQLsPiO9XQH41r9IE7YwtRHEuL59DnlEggXEpC94/MfkCmB7k0kydol78Eev9kRZlfqh/7DG/Bi4h0oCKpOaKA83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=XlSgTddv; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5574hP4W027576
	for <linux-fsdevel@vger.kernel.org>; Sat, 7 Jun 2025 02:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=AsCYG8CkIIPZbMRBimL2n8U8A9q+7pGknJ/irwioCr4=;
 b=XlSgTddvA0Q4Gv1nwjggTtrLVvK4UOBDaL6hYkxLNrNc2JfxL9xK13KJUOsfdizihaMS
 hvePSAfJ+DdfkwHZiXPnDvFHEQTJs+RHfSMYXtd34fh7kaUlxZ52WQAxOOfsKFGuNEcP
 i86YKjNQPklHiIgXAhpTC1R37IAXG7GI0BW5AtfPwlgoHcHaKjJfcbIHvdKH1kmsc07l
 wYzoeetg2LRvLaMTqf2b9HSay/h04s1Kct6tLAxXRyPkri+/4l/uo1ZUObxOMXkLiXuc
 vtPP6zvtRvdHTKQiuwiXfq5uIVaHUahA8U0WFFB02PZcdnI9AyBVPhNpTwaZiUF9hLnZ yw== 
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4743n0mb0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 02:40:10 -0400
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5750ca8b2so396307085a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 23:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749278410; x=1749883210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsCYG8CkIIPZbMRBimL2n8U8A9q+7pGknJ/irwioCr4=;
        b=v9XeTfwHmwi60JSgPKwTTl5LFsExcaQTCriV0amT4nJaiDXICWojOSiXxnFekvN2RC
         lg6ypJmewfy0IuOv3YjQHQl20O97PGCmIVoCikNSLg/WW5SraNqqmD8NcDsu0yanSbq7
         B7YkQjSlj8iT+ir0pUKFrhxd7NVsdtdCA6m8KWCELGejK0j9+wy4pihdmohKQggc/Uz4
         DKWpBmwIN1jvMbBu/g4kCi00vIlad5DIy1H40mkeab+WUMlQATjkkw3Cw3+NgVeNaeTL
         P3InB9oREfLwkx3wKC4k2WevsU8jluG6NchzOgfc4Uh9u1vgQV4tNNWva8UaC2Z0FtMy
         hEOw==
X-Forwarded-Encrypted: i=1; AJvYcCUyy8mNClr6bLm3SOhSQg0oisDiYjOYJOaaxXkFuAB59ObBhOmNBEr1M5yEt7TiLIOlM0P0d580j3NxwSj4@vger.kernel.org
X-Gm-Message-State: AOJu0YxvsNmNAXI8tGS6KZwso0yW5tKoVK1f04MMO4S2b64cTXpqaOnm
	lHDQub9WSjlbHmCvMX0Ib1w8fiT7UyZKZUGXiHs2wB5ogqVBPOcl/YKeBsTjdsvuLma2yRQq4iJ
	k7RDPzC9jZl7x9fWHRsYgC3mRXUkku0vnc0guBGIQ8eJcPrpyUQvjssHuAXnMB0eAbdGhGVg=
X-Gm-Gg: ASbGncvGm7d9Xfm2z9ImT6g3VuKbxwG3SOWb+2O0NbGpFYa/BqNyC5Rx5UTxhAgTPpf
	p/Z5pnB3cK/X+jDVcXZXIWD9RTtmxcIlTPnZUzt7FsNYVDghB7XNqL6kJ+b8puypyz6/waMQEAW
	D3fU6S0ihgzbXFQiD6Ow/lQXIQ2I7vSYej8HRvNEzt6/+y9fko9aNf8kjL6+ukRUQyuR8CFWdDH
	gOq4MFRVFCT++2gtE+KRV/kqkv9GNwZok6TDxMFtdWbRkBQ9TPvDcwNGpA5qaMEyiLyjbCiuJzZ
	b0M2lyPUVfKx9hDH/bRoYorcwg9ZyVUVQmYsOuvV99NURmpqamvPWgAXtz7bf7Vw83oZ
X-Received: by 2002:a05:620a:4406:b0:7c5:4711:dc56 with SMTP id af79cd13be357-7d2298fb49amr1059098985a.48.1749278409885;
        Fri, 06 Jun 2025 23:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2auxeh6j8sDgORgohwuvlEu1znKeOCk52yB8TwnyaKsXohV1V87jQgHvUs+w5vQE4vIOb1g==
X-Received: by 2002:a05:620a:4406:b0:7c5:4711:dc56 with SMTP id af79cd13be357-7d2298fb49amr1059095785a.48.1749278409369;
        Fri, 06 Jun 2025 23:40:09 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ac95e5sm24461256d6.43.2025.06.06.23.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 23:40:08 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Jun 2025 02:40:01 -0400
Subject: [PATCH v2 2/4] userfaultfd: remove (VM_)BUG_ON()s
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-uffd-fixes-v2-2-339dafe9a2fe@columbia.edu>
References: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
In-Reply-To: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749278406; l=12862;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8xK9cYLtkyMChjhj6zDEoAbzPlavCj2F/8VVwgmH0dc=;
 b=S+N7HEkuX1EXoPaYFwQEbrEidF/LHDXVIh0PjyFqrHyCQ7+XyLIIN+W4PRgPVwS7zx5ao/6Nq
 2qTTxiB7gZCC0wWB3XOuTAoBcOGOEbzdJ6UnChfrt2PylWcXxKiDuIX
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDA0NyBTYWx0ZWRfX5afOJ5QiCfXe BtcXU6Lr5kTXzHAWxMGM1po8j9UnzPTw1fo5ASIl1/bnMKT4vpzMOTfVLwOszsSYW0xTpeoLqQy LYVwtiYsZRFV/sQnXHuxv0fWSu2qg4Lpvb9yJ0/v08Ave07ZxdaBpEiZDrX9h6gy5PkVDrks5Oj
 AdLydZS8EO+lmNZIgK2hsvACRS6rSQcOUER7ZhOmVjR191R5vqMy44zJ8t35b44V8a+vZZWfNk/ xVl91BU/4b8F4VETSkDGPT94h6tQ3Y7qkz7y6N7e5E9pyEKH/bojjIsV5ftSkGBomJh1f9XtFlL NzsYfwu6nunZ4knwAh7/yE4QFytL6RTVLHN6HauGQOeFA9s9+ExrfZuTprl1eej9+jdMiCag3u7 lKIJRxpv
X-Proofpoint-ORIG-GUID: -hqRpIvAexIpDtJKx5pFmLxjH06PoyYs
X-Proofpoint-GUID: -hqRpIvAexIpDtJKx5pFmLxjH06PoyYs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=10 mlxscore=0 lowpriorityscore=10
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506070047

BUG_ON() is deprecated [1]. Convert all the BUG_ON()s and VM_BUG_ON()s
to use VM_WARN_ON_ONCE().

While at it, also convert the WARN_ON_ONCE()s in move_pages() to use
VM_WARN_ON_ONCE(), as the relevant conditions are already checked in
validate_range() in move_pages()'s caller.

[1] https://www.kernel.org/doc/html/v6.15/process/coding-style.html#use-warn-rather-than-bug

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/userfaultfd.c | 59 +++++++++++++++++++++++++-------------------------
 mm/userfaultfd.c | 66 +++++++++++++++++++++++++++-----------------------------
 2 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 22f4bf956ba1..80c95c712266 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -165,14 +165,14 @@ static void userfaultfd_ctx_get(struct userfaultfd_ctx *ctx)
 static void userfaultfd_ctx_put(struct userfaultfd_ctx *ctx)
 {
 	if (refcount_dec_and_test(&ctx->refcount)) {
-		VM_BUG_ON(spin_is_locked(&ctx->fault_pending_wqh.lock));
-		VM_BUG_ON(waitqueue_active(&ctx->fault_pending_wqh));
-		VM_BUG_ON(spin_is_locked(&ctx->fault_wqh.lock));
-		VM_BUG_ON(waitqueue_active(&ctx->fault_wqh));
-		VM_BUG_ON(spin_is_locked(&ctx->event_wqh.lock));
-		VM_BUG_ON(waitqueue_active(&ctx->event_wqh));
-		VM_BUG_ON(spin_is_locked(&ctx->fd_wqh.lock));
-		VM_BUG_ON(waitqueue_active(&ctx->fd_wqh));
+		VM_WARN_ON_ONCE(spin_is_locked(&ctx->fault_pending_wqh.lock));
+		VM_WARN_ON_ONCE(waitqueue_active(&ctx->fault_pending_wqh));
+		VM_WARN_ON_ONCE(spin_is_locked(&ctx->fault_wqh.lock));
+		VM_WARN_ON_ONCE(waitqueue_active(&ctx->fault_wqh));
+		VM_WARN_ON_ONCE(spin_is_locked(&ctx->event_wqh.lock));
+		VM_WARN_ON_ONCE(waitqueue_active(&ctx->event_wqh));
+		VM_WARN_ON_ONCE(spin_is_locked(&ctx->fd_wqh.lock));
+		VM_WARN_ON_ONCE(waitqueue_active(&ctx->fd_wqh));
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
 	}
@@ -383,12 +383,12 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	if (!ctx)
 		goto out;
 
-	BUG_ON(ctx->mm != mm);
+	VM_WARN_ON_ONCE(ctx->mm != mm);
 
 	/* Any unrecognized flag is a bug. */
-	VM_BUG_ON(reason & ~__VM_UFFD_FLAGS);
+	VM_WARN_ON_ONCE(reason & ~__VM_UFFD_FLAGS);
 	/* 0 or > 1 flags set is a bug; we expect exactly 1. */
-	VM_BUG_ON(!reason || (reason & (reason - 1)));
+	VM_WARN_ON_ONCE(!reason || (reason & (reason - 1)));
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
@@ -411,12 +411,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 		 * to be sure not to return SIGBUS erroneously on
 		 * nowait invocations.
 		 */
-		BUG_ON(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
+		VM_WARN_ON_ONCE(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
 #ifdef CONFIG_DEBUG_VM
 		if (printk_ratelimit()) {
-			printk(KERN_WARNING
-			       "FAULT_FLAG_ALLOW_RETRY missing %x\n",
-			       vmf->flags);
+			pr_warn("FAULT_FLAG_ALLOW_RETRY missing %x\n",
+				vmf->flags);
 			dump_stack();
 		}
 #endif
@@ -602,7 +601,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 	 */
 out:
 	atomic_dec(&ctx->mmap_changing);
-	VM_BUG_ON(atomic_read(&ctx->mmap_changing) < 0);
+	VM_WARN_ON_ONCE(atomic_read(&ctx->mmap_changing) < 0);
 	userfaultfd_ctx_put(ctx);
 }
 
@@ -710,7 +709,7 @@ void dup_userfaultfd_fail(struct list_head *fcs)
 		struct userfaultfd_ctx *ctx = fctx->new;
 
 		atomic_dec(&octx->mmap_changing);
-		VM_BUG_ON(atomic_read(&octx->mmap_changing) < 0);
+		VM_WARN_ON_ONCE(atomic_read(&octx->mmap_changing) < 0);
 		userfaultfd_ctx_put(octx);
 		userfaultfd_ctx_put(ctx);
 
@@ -1317,8 +1316,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	do {
 		cond_resched();
 
-		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
-		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
+		VM_WARN_ON_ONCE(!!cur->vm_userfaultfd_ctx.ctx ^
+				!!(cur->vm_flags & __VM_UFFD_FLAGS));
 
 		/* check not compatible vmas */
 		ret = -EINVAL;
@@ -1372,7 +1371,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 		found = true;
 	} for_each_vma_range(vmi, cur, end);
-	BUG_ON(!found);
+	VM_WARN_ON_ONCE(!found);
 
 	ret = userfaultfd_register_range(ctx, vma, vm_flags, start, end,
 					 wp_async);
@@ -1464,8 +1463,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	do {
 		cond_resched();
 
-		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
-		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
+		VM_WARN_ON_ONCE(!!cur->vm_userfaultfd_ctx.ctx ^
+				!!(cur->vm_flags & __VM_UFFD_FLAGS));
 
 		/*
 		 * Check not compatible vmas, not strictly required
@@ -1479,7 +1478,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 		found = true;
 	} for_each_vma_range(vmi, cur, end);
-	BUG_ON(!found);
+	VM_WARN_ON_ONCE(!found);
 
 	vma_iter_set(&vmi, start);
 	prev = vma_prev(&vmi);
@@ -1490,7 +1489,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async));
+		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vma->vm_flags, wp_async));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
@@ -1564,7 +1563,7 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
 	 * len == 0 means wake all and we don't want to wake all here,
 	 * so check it again to be sure.
 	 */
-	VM_BUG_ON(!range.len);
+	VM_WARN_ON_ONCE(!range.len);
 
 	wake_userfault(ctx, &range);
 	ret = 0;
@@ -1621,7 +1620,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 		return -EFAULT;
 	if (ret < 0)
 		goto out;
-	BUG_ON(!ret);
+	VM_WARN_ON_ONCE(!ret);
 	/* len == 0 would wake all */
 	range.len = ret;
 	if (!(uffdio_copy.mode & UFFDIO_COPY_MODE_DONTWAKE)) {
@@ -1676,7 +1675,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 	if (ret < 0)
 		goto out;
 	/* len == 0 would wake all */
-	BUG_ON(!ret);
+	VM_WARN_ON_ONCE(!ret);
 	range.len = ret;
 	if (!(uffdio_zeropage.mode & UFFDIO_ZEROPAGE_MODE_DONTWAKE)) {
 		range.start = uffdio_zeropage.range.start;
@@ -1788,7 +1787,7 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 		goto out;
 
 	/* len == 0 would wake all */
-	BUG_ON(!ret);
+	VM_WARN_ON_ONCE(!ret);
 	range.len = ret;
 	if (!(uffdio_continue.mode & UFFDIO_CONTINUE_MODE_DONTWAKE)) {
 		range.start = uffdio_continue.range.start;
@@ -1845,7 +1844,7 @@ static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long
 		goto out;
 
 	/* len == 0 would wake all */
-	BUG_ON(!ret);
+	VM_WARN_ON_ONCE(!ret);
 	range.len = ret;
 	if (!(uffdio_poison.mode & UFFDIO_POISON_MODE_DONTWAKE)) {
 		range.start = uffdio_poison.range.start;
@@ -2106,7 +2105,7 @@ static int new_userfaultfd(int flags)
 	struct file *file;
 	int fd;
 
-	BUG_ON(!current->mm);
+	VM_WARN_ON_ONCE(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
 	BUILD_BUG_ON(UFFD_USER_MODE_ONLY & UFFD_SHARED_FCNTL_FLAGS);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bc473ad21202..41e67ded5a6e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -561,7 +561,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	}
 
 	while (src_addr < src_start + len) {
-		BUG_ON(dst_addr >= dst_start + len);
+		VM_WARN_ON_ONCE(dst_addr >= dst_start + len);
 
 		/*
 		 * Serialize via vma_lock and hugetlb_fault_mutex.
@@ -602,7 +602,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		if (unlikely(err == -ENOENT)) {
 			up_read(&ctx->map_changing_lock);
 			uffd_mfill_unlock(dst_vma);
-			BUG_ON(!folio);
+			VM_WARN_ON_ONCE(!folio);
 
 			err = copy_folio_from_user(folio,
 						   (const void __user *)src_addr, true);
@@ -614,7 +614,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			dst_vma = NULL;
 			goto retry;
 		} else
-			BUG_ON(folio);
+			VM_WARN_ON_ONCE(folio);
 
 		if (!err) {
 			dst_addr += vma_hpagesize;
@@ -635,9 +635,9 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 out:
 	if (folio)
 		folio_put(folio);
-	BUG_ON(copied < 0);
-	BUG_ON(err > 0);
-	BUG_ON(!copied && !err);
+	VM_WARN_ON_ONCE(copied < 0);
+	VM_WARN_ON_ONCE(err > 0);
+	VM_WARN_ON_ONCE(!copied && !err);
 	return copied ? copied : err;
 }
 #else /* !CONFIG_HUGETLB_PAGE */
@@ -711,12 +711,12 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	/*
 	 * Sanitize the command parameters:
 	 */
-	BUG_ON(dst_start & ~PAGE_MASK);
-	BUG_ON(len & ~PAGE_MASK);
+	VM_WARN_ON_ONCE(dst_start & ~PAGE_MASK);
+	VM_WARN_ON_ONCE(len & ~PAGE_MASK);
 
 	/* Does the address range wrap, or is the span zero-sized? */
-	BUG_ON(src_start + len <= src_start);
-	BUG_ON(dst_start + len <= dst_start);
+	VM_WARN_ON_ONCE(src_start + len <= src_start);
+	VM_WARN_ON_ONCE(dst_start + len <= dst_start);
 
 	src_addr = src_start;
 	dst_addr = dst_start;
@@ -775,7 +775,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	while (src_addr < src_start + len) {
 		pmd_t dst_pmdval;
 
-		BUG_ON(dst_addr >= dst_start + len);
+		VM_WARN_ON_ONCE(dst_addr >= dst_start + len);
 
 		dst_pmd = mm_alloc_pmd(dst_mm, dst_addr);
 		if (unlikely(!dst_pmd)) {
@@ -818,7 +818,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 
 			up_read(&ctx->map_changing_lock);
 			uffd_mfill_unlock(dst_vma);
-			BUG_ON(!folio);
+			VM_WARN_ON_ONCE(!folio);
 
 			kaddr = kmap_local_folio(folio, 0);
 			err = copy_from_user(kaddr,
@@ -832,7 +832,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			flush_dcache_folio(folio);
 			goto retry;
 		} else
-			BUG_ON(folio);
+			VM_WARN_ON_ONCE(folio);
 
 		if (!err) {
 			dst_addr += PAGE_SIZE;
@@ -852,9 +852,9 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 out:
 	if (folio)
 		folio_put(folio);
-	BUG_ON(copied < 0);
-	BUG_ON(err > 0);
-	BUG_ON(!copied && !err);
+	VM_WARN_ON_ONCE(copied < 0);
+	VM_WARN_ON_ONCE(err > 0);
+	VM_WARN_ON_ONCE(!copied && !err);
 	return copied ? copied : err;
 }
 
@@ -940,11 +940,11 @@ int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
 	/*
 	 * Sanitize the command parameters:
 	 */
-	BUG_ON(start & ~PAGE_MASK);
-	BUG_ON(len & ~PAGE_MASK);
+	VM_WARN_ON_ONCE(start & ~PAGE_MASK);
+	VM_WARN_ON_ONCE(len & ~PAGE_MASK);
 
 	/* Does the address range wrap, or is the span zero-sized? */
-	BUG_ON(start + len <= start);
+	VM_WARN_ON_ONCE(start + len <= start);
 
 	mmap_read_lock(dst_mm);
 
@@ -1709,15 +1709,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	ssize_t moved = 0;
 
 	/* Sanitize the command parameters. */
-	if (WARN_ON_ONCE(src_start & ~PAGE_MASK) ||
-	    WARN_ON_ONCE(dst_start & ~PAGE_MASK) ||
-	    WARN_ON_ONCE(len & ~PAGE_MASK))
-		goto out;
+	VM_WARN_ON_ONCE(src_start & ~PAGE_MASK);
+	VM_WARN_ON_ONCE(dst_start & ~PAGE_MASK);
+	VM_WARN_ON_ONCE(len & ~PAGE_MASK);
 
 	/* Does the address range wrap, or is the span zero-sized? */
-	if (WARN_ON_ONCE(src_start + len <= src_start) ||
-	    WARN_ON_ONCE(dst_start + len <= dst_start))
-		goto out;
+	VM_WARN_ON_ONCE(src_start + len < src_start);
+	VM_WARN_ON_ONCE(dst_start + len < dst_start);
 
 	err = uffd_move_lock(mm, dst_start, src_start, &dst_vma, &src_vma);
 	if (err)
@@ -1867,9 +1865,9 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	up_read(&ctx->map_changing_lock);
 	uffd_move_unlock(dst_vma, src_vma);
 out:
-	VM_WARN_ON(moved < 0);
-	VM_WARN_ON(err > 0);
-	VM_WARN_ON(!moved && !err);
+	VM_WARN_ON_ONCE(moved < 0);
+	VM_WARN_ON_ONCE(err > 0);
+	VM_WARN_ON_ONCE(!moved && !err);
 	return moved ? moved : err;
 }
 
@@ -1956,9 +1954,9 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
-		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
-		       vma->vm_userfaultfd_ctx.ctx != ctx);
+		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
+		VM_WARN_ON_ONCE(vma->vm_userfaultfd_ctx.ctx &&
+				vma->vm_userfaultfd_ctx.ctx != ctx);
 		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		/*
@@ -2035,8 +2033,8 @@ void userfaultfd_release_all(struct mm_struct *mm,
 	prev = NULL;
 	for_each_vma(vmi, vma) {
 		cond_resched();
-		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
-		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
+		VM_WARN_ON_ONCE(!!vma->vm_userfaultfd_ctx.ctx ^
+				!!(vma->vm_flags & __VM_UFFD_FLAGS));
 		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
 			prev = vma;
 			continue;

-- 
2.39.5


