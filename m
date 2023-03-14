Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0036BA227
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjCNWPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjCNWOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:14:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8C657D3F
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:14:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-540e3b152a3so121205067b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678831993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pTQknU0yyvhsrgkZGBBdxk3ve6H2jxjb5KB6cR7GsY=;
        b=R5pck/04mfxPmIVBB9o4uaUAo15/ZfMIMU4zBBeiy60dN3PkzfG+pL2Jk8ShQx/wnT
         tu1lgw8s51UeJbNP7Jq1JSaDKFmENaAF8z1goiVAAzBIHtPHaXkByRIiol+yJE5/YgnQ
         hW5qdRTIt9H9xpPdA02kwFo7Rk+Ynt1+wYVf34T5VMzeBtBNZvPPA5O3aC3D91D0RNtm
         mSJ+v1/gDC92H9jo4qw/x0rtVNP40bPesp90xC2s/8DWp1y16hh7VG0pXJdfZGwPx2Bb
         3g6PFtXcDzEpd66sHf07DdrXtn5FXRMWyPg2Jsy3ULZKlqOp9KCEKjeIRXmZa8Bhn/E3
         nxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pTQknU0yyvhsrgkZGBBdxk3ve6H2jxjb5KB6cR7GsY=;
        b=YZxCHIpvGVwaHqvQimKMl2vmqAAEg3a9oLBwSzk20O/GeB0ykWnJ9prmKS9WrlK7nW
         pPsSOVSMGoNXqnC71N+hp1CoZ3R94HfkMIv/AEImEPYlp3/QrFoEXKujcFCiJrRU6AX8
         LqAX2BfZRf+MnyCIqa2D/736ptvqBTYP8OXOCP7zy5BsUWvtnd3mYiTJVDiY9xbIsSru
         4Q06E/lsS3n9mOf7seOquSxoV4vo4zsLZsdT5Ya/2IAmxiHrtwjErmEvwKGgKr4c2S5P
         qx0nhDJ0pNahUVvmog3AcQSwgtBNZII7FrDk501RpiMzuPTDJCC0KffzfLNaaqhVD7/C
         PhJw==
X-Gm-Message-State: AO0yUKUxYQwrq2y2pioeu0QmyMrHs1MzZneHBd95Ku2IAtc8ljF9usXN
        p2vYMUGdqCjOsoTwyJIvgg4QWZ13SySW/6mFWo/w
X-Google-Smtp-Source: AK7set+CfovE4o2SVuha7KE903+E9XdVfmvAi2JH8R4Sr+s1e8IgI0cxifkuT5NnCB1X9zPcFkujhBDANx40mexrV28r
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:21ce:bab3:17ec:2276])
 (user=axelrasmussen job=sendgmr) by 2002:a81:ac52:0:b0:541:9b2b:8240 with
 SMTP id z18-20020a81ac52000000b005419b2b8240mr6114708ywj.6.1678831992903;
 Tue, 14 Mar 2023 15:13:12 -0700 (PDT)
Date:   Tue, 14 Mar 2023 15:12:50 -0700
In-Reply-To: <20230314221250.682452-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230314221250.682452-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230314221250.682452-5-axelrasmussen@google.com>
Subject: [PATCH v5 4/4] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to
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

Update Documentation/ to describe how these flags are used (neither the
COPY nor the new CONTINUE versions of this mode flag were described
there before).

[1]: https://patchwork.kernel.org/project/linux-mm/cover/20230218002819.1486479-1-jthoughton@google.com/

Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 8 ++++++++
 fs/userfaultfd.c                             | 8 ++++++--
 include/linux/userfaultfd_k.h                | 3 ++-
 include/uapi/linux/userfaultfd.h             | 7 +++++++
 mm/userfaultfd.c                             | 5 +++--
 tools/testing/selftests/mm/userfaultfd.c     | 4 ++++
 6 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 7dc823b56ca4..0ce400f8da93 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -219,6 +219,14 @@ former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
 you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
 used.
 
+When using ``UFFDIO_REGISTER_MODE_WP`` in combination with either
+``UFFDIO_REGISTER_MODE_MISSING`` or ``UFFDIO_REGISTER_MODE_MINOR``, when
+resolving missing / minor faults with ``UFFDIO_COPY`` or ``UFFDIO_CONTINUE``
+respectively, it may be desirable for the new page / mapping to be
+write-protected (so future writes will also result in a WP fault). These ioctls
+support a mode flag (``UFFDIO_COPY_MODE_WP`` or ``UFFDIO_CONTINUE_MODE_WP``
+respectively) to configure the mapping this way.
+
 QEMU/KVM
 ========
 
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
index a948d92154f5..fd6d7d80b6ea 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -83,7 +83,8 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
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
index 9202c1fc79ba..048beb5d0edd 100644
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

