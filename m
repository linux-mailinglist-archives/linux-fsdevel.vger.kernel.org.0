Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2194371F43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhECSJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 14:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhECSIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 14:08:49 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CDEC061347
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 11:07:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id x6-20020a0cda060000b02901c4b3f7d3d9so5586843qvj.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rLicbgjBW9z9eKVcQKp4wHRRLj2JzrLl40NiB/ljX8M=;
        b=dYQbKoRMU91hOrSaWBLxUpTQ05+ZNfEo4S7tV4qClTWooCDGneergtpY8tZcI1BeJI
         p7UfIOb8j3uR/uAa9q8apWqtTdzN4eBG7l9w+JZzDYVvVL2ASJrPke57fAPMEYTbG2C4
         ERRpFY0fjyF+GYSCPN9PK1DEf5KFkY2NBN83AazVqyRCWDvahiveuMsHe5fgjDew4TOj
         dC81tnwmnFaEYCEAwYH+M3YmqOjN7jNU+SND9kXKVx1GFSpkFTiBrhVvuwcemQgfWDDd
         YHuVEWNXez6FTpwpAMYamSg5JI28GO4eDmoPjy66uTbUhczB7zLfdC2un3/a+fpgilm0
         YWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rLicbgjBW9z9eKVcQKp4wHRRLj2JzrLl40NiB/ljX8M=;
        b=ezTOwpuLbqeS7DR7KP0kzmvrHGaVfSWM7/B/v3kAEYnnBJ5ilHRjmmhdbEZlYRqXCG
         VFTMbP8JtBeijnO2i59qksHeCBpsxOpAA7xS0dyWEPipxqno3mjdXC2irwUCtoazIuUn
         6jT9S2seoAPz3Sa5d+B8ZtMy73b7AY38rjwWwtCpuiMpxTmeeWF/tvK7XZO0JqEkxxq+
         FuQDXqrCv1/fq6Hb6d/319hAgrmNoff5QLp/Z7q+9s8FQ1t2q86+5sU33SyzNSgiOmEg
         mkpSG+pTjWNAypDxM+9RbnbeSfK234hdHa+bXuwN14oOee5rFvv14uwX7LMUjKRGeaOS
         kKKw==
X-Gm-Message-State: AOAM533GWXpNggaOToRXKXidL2LKqu+f45d6zK6McRzEaWcCqjMEq/WW
        iHBYDnjnL1Z8Ra+qRjM7BajVy2btEa9ZLCO/1Pmy
X-Google-Smtp-Source: ABdhPJy1xqLPQr/XdBSNr2qNlen7wPq5zImtLkaKsKj5y77xMMSUpDG+ZJHsvmvO9ip76I57W6uNh5GMDPom3sfr5b8/
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4441:: with SMTP id
 l1mr20459035qvt.1.1620065272357; Mon, 03 May 2021 11:07:52 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:32 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 05/10] userfaultfd/shmem: advertise shmem minor fault support
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the feature is fully implemented (the faulting path hooks exist
so userspace is notified, and the ioctl to resolve such faults is
available), advertise this as a supported feature.

Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 3 ++-
 fs/userfaultfd.c                             | 3 ++-
 include/uapi/linux/userfaultfd.h             | 7 ++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 3aa38e8b8361..6528036093e1 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -77,7 +77,8 @@ events, except page fault notifications, may be generated:
 
 - ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports
   ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory
-  areas.
+  areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
+  support for shmem virtual memory areas.
 
 The userland application should set the feature flags it intends to use
 when invoking the ``UFFDIO_API`` ioctl, to request that those features be
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 468556fb04a9..9f3b8684cf3c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1940,7 +1940,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS;
+	uffdio_api.features &=
+		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index bafbeb1a2624..159a74e9564f 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -31,7 +31,8 @@
 			   UFFD_FEATURE_MISSING_SHMEM |		\
 			   UFFD_FEATURE_SIGBUS |		\
 			   UFFD_FEATURE_THREAD_ID |		\
-			   UFFD_FEATURE_MINOR_HUGETLBFS)
+			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
+			   UFFD_FEATURE_MINOR_SHMEM)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -185,6 +186,9 @@ struct uffdio_api {
 	 * UFFD_FEATURE_MINOR_HUGETLBFS indicates that minor faults
 	 * can be intercepted (via REGISTER_MODE_MINOR) for
 	 * hugetlbfs-backed pages.
+	 *
+	 * UFFD_FEATURE_MINOR_SHMEM indicates the same support as
+	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for shmem-backed pages instead.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -196,6 +200,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_SIGBUS			(1<<7)
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
 #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
+#define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 	__u64 features;
 
 	__u64 ioctls;
-- 
2.31.1.527.g47e6f16901-goog

