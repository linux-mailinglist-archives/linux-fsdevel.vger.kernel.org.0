Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AB136CEE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 00:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhD0Wxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 18:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239373AbhD0Wxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:53:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F4C06138D
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:52:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u3-20020a2509430000b02904e7f1a30cffso39410614ybm.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WF9F3v0DTQrGhMQixNFSEHJ4K48zSV5jue/NqesrNqw=;
        b=E0rIUMeWAgoXEpCSgGFacuFM+ZLoAqWK7X4u5Xdgp+31PQA56XOa/QGxtgDLfgqrvC
         fr65eCoJ4hgjT9GAidrf06HXEtn9lSMolBwlNj048rZQVvrKH9YfsUU1ugb3m9oRNh8m
         4RC9F9WnRcm39mYHDuCLvgGZ2oHStv2UTB/8crxk7MzT8treUGVHoVfJoYLCpDZ8TDZ4
         6QwRE+oATYg5O1bFgPNt+nxv6gKrGrEqpxWkvwFrM9CwXBDQfmtfYIz+zGcdSoAI+Ump
         rf9KbzeE1cMzuP/ldh5eNn8qw967pwi8MhrMX3npQf0JNsMoZbitUZ/LU1YHNQWWcQTj
         dN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WF9F3v0DTQrGhMQixNFSEHJ4K48zSV5jue/NqesrNqw=;
        b=qR6EZhTDybBdvQ4dP/e4RInkg8nAyc2YbP6S5xIGBG1hjWG+1SUVf1F/Wr+8cNEeDb
         CB13V241oi8iQ34LvF4sDH9c4jyBmm0M1e42+H9kkn4TgXJW4QauZ+DorGkrQWxIJC1V
         /7owVYHoaF6fZcDllmFWYg9tSid1o4a/OAVkdMp4EC/FYuOr4aTFr/P5tou3CmhxqQ/w
         icrkylmoa+TxMZ94BWtEMoO8Y4y7R3zFOmmOVn5sr1JLbFDV33n/1FKNMVp3cB7JSU38
         Fow6ir8sIa2CBE5fIJk8HhT1Rm5BsocK108iJvLf+2aFxM1uE6G7uWgasNSgNAVyyox5
         F3vA==
X-Gm-Message-State: AOAM530DQ4rXK6/n7j8RUia4OBCxWOqxLFf0JVVxRAyD+D93ePOfwjuK
        t+/jld/h/rT9CA0T2+NhNenuDnKHjgC5hwpyeTu6
X-Google-Smtp-Source: ABdhPJx42SaZU/ckRJAWYZl+sBHBU4dxsBNXvauQrfUBhzIQvOpfUGF4aSkEw6m+v1AIMYKQT6bT7EELye6lYtqQgWNZ
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a25:e803:: with SMTP id
 k3mr35760658ybd.268.1619563977590; Tue, 27 Apr 2021 15:52:57 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:39 -0700
In-Reply-To: <20210427225244.4326-1-axelrasmussen@google.com>
Message-Id: <20210427225244.4326-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 05/10] userfaultfd/shmem: advertise shmem minor fault support
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
2.31.1.498.g6c1eba8ee3d-goog

