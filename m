Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C826A0051
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 01:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjBWA61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 19:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjBWA6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:58:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4119233EE
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:58:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536d63d17dbso81428837b3.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVEpDKkiPqP2+7hkSYLnKAL7x6oJXvVC4LelYs0FclU=;
        b=RIsIvNHWqJlFjwGMxEpMMi8c9SD1LMWqPwMba6tqRkM8zClhElkzYY/Bg5r4ntdJti
         6n+mzOX9cd2MKENxQtWRykO75RdzCnVvPvYyWcrKXpBeKpu2Cm2FFbOZqNNSeZnvoG9i
         t3N91/Ye2+2U4U3pZ1Oz6pwUBBJ7WaYEsatrwBR+v5BFNtR6iNiXRs0UHnrsG5p3YjWp
         GozkMA5yhgcHWljPBoH9ZRTR74W3zmNKMUKjL5WUHmSzzRo28t1AeHLg02vpqyEGvapK
         gjBJuSccU8cXw8LlIzu/vOCk5xpFwCq5vyCjLykVjGFoDKwQbB8T+AiowCpNiC5FvQZe
         hRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVEpDKkiPqP2+7hkSYLnKAL7x6oJXvVC4LelYs0FclU=;
        b=YX8mPbVY7tJjDYNwjOo1q86xn4MKSlgbSd+EYXsdZJscA2e75v9n/zRflAYlFY2qt7
         6OxA5FPOmu9mFEOcfgPRNXWkISRsFTe+4MFdUiiVDi1ylfk6AWErUjXYeGjeF26fMpVK
         iR0g69OtpxHwyZv2IVDKCXObg9djusTgOaLav2jUJ82baANax6mpyLUDDI5MD49BJnj8
         pxw3izzIRDe3Y+GJBWyYri2tRkJABiwkR6pN+UvledD1TyRo/OL2bSh37zj/CcjCar9Y
         3qgbXYU2Oy+i5GAGiNSzMYMjTsTdPEaylyn+Z37U/dFNX5zPsjJogjZKNhBP/Pd+XZ+k
         uTgA==
X-Gm-Message-State: AO0yUKU5mToSqj3Fjzwsx7vKVXWez2PWR8puSRJm+ipnHyT6kGuYKVi9
        jbiuW4HVicrkCDj+7DWtgrfOyT+i9Xn4/Tf3SKtF
X-Google-Smtp-Source: AK7set+TIJO70qFBQWJ2Mupda48bbmNTk3KYnmOour0IdK8ZN/UCPOHlLBM/9Hnk8mqw4mTZzFG6dK5NY8KDR5Bbda2m
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:3e99:dd9e:9db9:449c])
 (user=axelrasmussen job=sendgmr) by 2002:a81:b714:0:b0:52f:23f5:4079 with
 SMTP id v20-20020a81b714000000b0052f23f54079mr1366675ywh.4.1677113891031;
 Wed, 22 Feb 2023 16:58:11 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:57:54 -0800
In-Reply-To: <20230223005754.2700663-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230223005754.2700663-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230223005754.2700663-6-axelrasmussen@google.com>
Subject: [PATCH v2 5/5] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to
 install WP PTEs
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UFFDIO_COPY already has UFFDIO_COPY_MODE_WP, so when installing a new
PTE to resolve a missing fault, one can install a write-protected one.
This is useful when using UFFDIO_REGISTER_MODE_{MISSING,WP} in
combination.

So, add an analogous UFFDIO_CONTINUE_MODE_WP, which does the same thing
but for *minor* faults.

Update the selftest to do some very basic exercising of the new flag.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                         | 8 ++++++--
 include/linux/userfaultfd_k.h            | 2 +-
 include/uapi/linux/userfaultfd.h         | 7 +++++++
 mm/userfaultfd.c                         | 5 +++--
 tools/testing/selftests/vm/userfaultfd.c | 4 ++++
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f43d8b0ae47b..5ce4502737a1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1871,6 +1871,7 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	struct uffdio_continue uffdio_continue;
 	struct uffdio_continue __user *user_uffdio_continue;
 	struct uffdio_range range;
+	int flags = 0;
 
 	user_uffdio_continue = (struct uffdio_continue __user *)arg;
 
@@ -1893,12 +1894,15 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	/* double check for wraparound just in case. */
 	if (range.start + range.len <= range.start)
 		goto out;
-	if (uffdio_continue.mode & ~UFFDIO_CONTINUE_MODE_DONTWAKE)
+	if (uffdio_continue.mode & ~(UFFDIO_CONTINUE_MODE_DONTWAKE |
+				     UFFDIO_CONTINUE_MODE_WP))
 		goto out;
+	if (uffdio_continue.mode & UFFDIO_CONTINUE_MODE_WP)
+		flags |= MFILL_ATOMIC_WP;
 
 	if (mmget_not_zero(ctx->mm)) {
 		ret = mfill_atomic_continue(ctx->mm, &range,
-					    &ctx->mmap_changing);
+					    &ctx->mmap_changing, flags);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 3cf87f019db3..1e1229430f56 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -67,7 +67,7 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 				     atomic_t *mmap_changing);
 extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm,
 				     const struct uffdio_range *dst,
-				    atomic_t *mmap_changing);
+				    atomic_t *mmap_changing, int flags);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       const struct uffdio_range *range,
 			       bool enable_wp, atomic_t *mmap_changing);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 005e5e306266..14059a0861bf 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -297,6 +297,13 @@ struct uffdio_writeprotect {
 struct uffdio_continue {
 	struct uffdio_range range;
 #define UFFDIO_CONTINUE_MODE_DONTWAKE		((__u64)1<<0)
+	/*
+	 * UFFDIO_CONTINUE_MODE_WP will map the page write protected on
+	 * the fly.  UFFDIO_CONTINUE_MODE_WP is available only if the
+	 * write protected ioctl is implemented for the range
+	 * according to the uffdio_register.ioctls.
+	 */
+#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)
 	__u64 mode;
 
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ebbba2b9f687..03f388aaa405 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -706,10 +706,11 @@ ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 
 ssize_t mfill_atomic_continue(struct mm_struct *dst_mm,
 			      const struct uffdio_range *dst,
-			      atomic_t *mmap_changing)
+			      atomic_t *mmap_changing,
+			      int flags)
 {
 	return mfill_atomic(dst_mm, 0, dst,
-			    mmap_changing, MFILL_ATOMIC_CONTINUE);
+			    mmap_changing, flags | MFILL_ATOMIC_CONTINUE);
 }
 
 void uffd_wp_range(struct vm_area_struct *dst_vma,
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 7f22844ed704..41c1f9abc481 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -585,6 +585,8 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 	req.range.start = start;
 	req.range.len = len;
 	req.mode = 0;
+	if (test_uffdio_wp)
+		req.mode |= UFFDIO_CONTINUE_MODE_WP;
 
 	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
 		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
@@ -1332,6 +1334,8 @@ static int userfaultfd_minor_test(void)
 	uffdio_register.range.start = (unsigned long)area_dst_alias;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
+	if (test_uffdio_wp)
+		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		err("register failure");
 
-- 
2.39.2.637.g21b0678d19-goog

