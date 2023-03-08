Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B142C6B14F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 23:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCHWUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 17:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjCHWTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:19:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958096F17
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 14:19:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e195-20020a25e7cc000000b00a1e59ba7ed9so133966ybh.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 14:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678313989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSBFx52RvXhjtM1Ms4suwV92HKajMqVhV7t5r8e9JsE=;
        b=eDQwE03ssVefKuCHB5TW/9cRNCO3i1U9pzf4Ycjg91bvG1agIDtj0QTDE2eFmvjKVx
         fxVClPeOZeCKq1qpEHM10j3+vzTxm44vqdZdGCiDVrHAvZXHmxYM4g8g7ee6/gIHO4RV
         03sVypQgd6aKkvssDe9MhchkPxSpvN6scQQTzDvldztsTNuwXJ25oes+JdaaWvEgW/vh
         Ks2aJ38BOoW1g1SD7qNi3QXAOQ0/ZHcfW8uPrpQnxFE88qQ6reh6KQ7yHElvT2u7uvjc
         Kakf4FsYCP6sbS07URRagbKBCEzMwfQV1R7J01ZCBx0pl/NWDzpaG7SW0ucedJET5wuC
         9P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSBFx52RvXhjtM1Ms4suwV92HKajMqVhV7t5r8e9JsE=;
        b=Iz73D9h8NixY2XlGUFCUwZDF9agpK6jq/BMAQFgkMM3EGXGKrp1RE0paQrxjWExGmQ
         zSJGuKrMjihUi2uQXGn60dr/QIVqxtrRAeZ7hFCXyEgijeGNSuIewuKe3AExn3ChJpRl
         vRHicslY27pWgf7EecNUaHtkY+aMrePVxZreVAHSZJsUa4cEsKnqnerxzz4OfomQtiYK
         jrcjUz1pEuuAzz8YJf2TCJkiSZRGyEcZ367ctG9tT7Ig8uZuAq2o1PHVD4BGLa5i2Ts7
         A6tw/OynOeJJhglNfv3uprxKy5o9a+3nzWTHq3eAKSTeOmgKz8+Bh7ZnEQJjZZIXR444
         Tr6Q==
X-Gm-Message-State: AO0yUKXsHz5ejS2+xM/H5R4Kl8f5wHS6VKvysq1QqdKDr+HcJhsk1aoc
        ZG0ThBue1R77LHKhK6dTvcg8/BHSLjk6g+KzaBXp
X-Google-Smtp-Source: AK7set/Y8V4CBFECi0ndhD/iIYsa8Ih564aUc0de91ZFzdsRCTCZqdn0UCRIo/zFP9QU38jh/ZHPKYk13T3u2uxCOIk3
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:96cb:1c04:7322:78a4])
 (user=axelrasmussen job=sendgmr) by 2002:a81:ad5a:0:b0:536:4d58:54b2 with
 SMTP id l26-20020a81ad5a000000b005364d5854b2mr13032103ywk.4.1678313988783;
 Wed, 08 Mar 2023 14:19:48 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:19:32 -0800
In-Reply-To: <20230308221932.1548827-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230308221932.1548827-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230308221932.1548827-5-axelrasmussen@google.com>
Subject: [PATCH v4 4/4] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to
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

This was motivated by testing HugeTLB HGM [1], and in particular its
interaction with userfaultfd features. Existing userfaultfd code
supports using WP and MINOR modes together (i.e. you can register an
area with both enabled), but without this CONTINUE flag the combination
is in practice unusable.

So, add an analogous UFFDIO_CONTINUE_MODE_WP, which does the same thing
as UFFDIO_COPY_MODE_WP, but for *minor* faults.

Update the selftest to do some very basic exercising of the new flag.

[1]: https://patchwork.kernel.org/project/linux-mm/cover/20230218002819.1486479-1-jthoughton@google.com/

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                         | 8 ++++++--
 include/linux/userfaultfd_k.h            | 3 ++-
 include/uapi/linux/userfaultfd.h         | 7 +++++++
 mm/userfaultfd.c                         | 5 +++--
 tools/testing/selftests/mm/userfaultfd.c | 4 ++++
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 56e54e50414e..664019381e04 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1878,6 +1878,7 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	struct uffdio_continue uffdio_continue;
 	struct uffdio_continue __user *user_uffdio_continue;
 	struct userfaultfd_wake_range range;
+	uffd_flags_t flags = 0;
 
 	user_uffdio_continue = (struct uffdio_continue __user *)arg;
 
@@ -1902,13 +1903,16 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	    uffdio_continue.range.start) {
 		goto out;
 	}
-	if (uffdio_continue.mode & ~UFFDIO_CONTINUE_MODE_DONTWAKE)
+	if (uffdio_continue.mode & ~(UFFDIO_CONTINUE_MODE_DONTWAKE |
+				     UFFDIO_CONTINUE_MODE_WP))
 		goto out;
+	if (uffdio_continue.mode & UFFDIO_CONTINUE_MODE_WP)
+		flags |= MFILL_ATOMIC_WP;
 
 	if (mmget_not_zero(ctx->mm)) {
 		ret = mfill_atomic_continue(ctx->mm, uffdio_continue.range.start,
 					    uffdio_continue.range.len,
-					    &ctx->mmap_changing);
+					    &ctx->mmap_changing, flags);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 4d7425684171..9499cfcf83fa 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -82,7 +82,8 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 				     unsigned long len,
 				     atomic_t *mmap_changing);
 extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
-				     unsigned long len, atomic_t *mmap_changing);
+				     unsigned long len, atomic_t *mmap_changing,
+				     uffd_flags_t flags);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
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
index dd807924446f..2f64e0a9b234 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -693,10 +693,11 @@ ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long start,
 }
 
 ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
-			      unsigned long len, atomic_t *mmap_changing)
+			      unsigned long len, atomic_t *mmap_changing,
+			      uffd_flags_t flags)
 {
 	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
-			    uffd_flags_set_mode(0, MFILL_ATOMIC_CONTINUE));
+			    uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTINUE));
 }
 
 long uffd_wp_range(struct vm_area_struct *dst_vma,
diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 7f22844ed704..41c1f9abc481 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
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
2.40.0.rc1.284.g88254d51c5-goog

