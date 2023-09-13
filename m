Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98D279ECB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbjIMPXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 11:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbjIMPXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E81B1BCF
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694618566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTfXorS8NWDW0bcx6yY89gzPkWn52B0igCnyNn6sVfo=;
        b=hUwYiu3fXxQF3ugbyB4IvfQ1V8mhdNurUQHuZCn6anxCwl00oKMbvRD04U4A5JapjBgsw7
        pX5A6I6flzkBB1fuwqcYDLvobONIpb0PxB5+MnQRbsQVF+kAJWwA2YDHtr3NIT/HES1vIL
        4KKoCC6jV7jGA6adb3cvIFqsXPgCN+g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Ob666BhJPdW-Gb4t_sEyjA-1; Wed, 13 Sep 2023 11:22:45 -0400
X-MC-Unique: Ob666BhJPdW-Gb4t_sEyjA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9aa20a75780so266352566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 08:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618563; x=1695223363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTfXorS8NWDW0bcx6yY89gzPkWn52B0igCnyNn6sVfo=;
        b=BloofdhCeyYcmDWITIoohM9E1Yg5/+Jo0bkITfh2SO+aD75j16uSpDCuJ5FnXxbjQN
         SR0NhEwaV+VZpzpC1oNKNd/Vb2cHcKn1PowsZwXaajhQtgmj/WtudR762cDqODZuAp1o
         ynPD6hsVOl0UpHbmkGxxGQj9idOyngItQjLkFw/FxkBpHJ+EPJiwguNv+VSlHo28EOWv
         3Egs9Wd/0+Ugp/OHi8wnGiQrJevKRuno0WKHk1ZBhrb3sTbUEQbbTiu3AA6kelQPX2fr
         IhiB1HaS8pdxZIz0Oa4Suxal5loY9Aj11dhVTkEEm1vv7P0eF7jVSc77jC88JwLwzTGi
         1wCQ==
X-Gm-Message-State: AOJu0YwBfqAqtM6XbDBC3eXZSp7AO205xL9iiEtrRHLRP1N4mpZf8D+H
        q5vlVX0LiIOgZa8xYUBW9+KMthPEMfbPYFaiz8glYJ1QOFHcEbCKZpza5Uz+Q3/Em7nImpVDAiI
        NiX7tbFx1IQN/QN4q1zpddMXphb3AdluLFji3OqzFxqOnXG9YOQLWwwDJxX2M2deBlSw63JmAPl
        HnQF+V3Hq3pA==
X-Received: by 2002:a17:906:8a4a:b0:9a2:1e03:1573 with SMTP id gx10-20020a1709068a4a00b009a21e031573mr2203461ejc.65.1694618563295;
        Wed, 13 Sep 2023 08:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPav7CS9OAXNz5wCBb3Ckycl9EWcatp0ojEQPYZQSdhbugHLMMEeHnm8tMl75k1c+1hzp+Ig==
X-Received: by 2002:a17:906:8a4a:b0:9a2:1e03:1573 with SMTP id gx10-20020a1709068a4a00b009a21e031573mr2203439ejc.65.1694618562971;
        Wed, 13 Sep 2023 08:22:42 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (79-120-253-96.pool.digikabel.hu. [79.120.253.96])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906a09200b0099b8234a9fesm8640663ejy.1.2023.09.13.08.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:22:41 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [RFC PATCH 1/3] add unique mount ID
Date:   Wed, 13 Sep 2023 17:22:34 +0200
Message-ID: <20230913152238.905247-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913152238.905247-1-mszeredi@redhat.com>
References: <20230913152238.905247-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a mount is released then it's mnt_id can immediately be reused.  This is
bad news for user interfaces that want to uniquely identify a mount.

Implementing a unique mount ID is trivial (use a 64bit counter).
Unfortunately userspace assumes 32bit size and would overflow after the
counter reaches 2^32.

Introduce a new 64bit ID alongside the old one.  Allow new interfaces to
work on both the old and new IDs by starting the counter from 2^32.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h                | 3 ++-
 fs/namespace.c            | 4 ++++
 fs/stat.c                 | 9 +++++++--
 include/uapi/linux/stat.h | 1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 130c07c2f8d2..a14f762b3f29 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -72,7 +72,8 @@ struct mount {
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
 #endif
-	int mnt_id;			/* mount identifier */
+	int mnt_id;			/* mount identifier, reused */
+	u64 mnt_id_unique;		/* mount ID unique until reboot */
 	int mnt_group_id;		/* peer group identifier */
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..de47c5f66e17 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -68,6 +68,9 @@ static u64 event;
 static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
+/* Don't allow confusion with mount ID allocated wit IDA */
+static atomic64_t mnt_id_ctr = ATOMIC64_INIT(1ULL << 32);
+
 static struct hlist_head *mount_hashtable __read_mostly;
 static struct hlist_head *mountpoint_hashtable __read_mostly;
 static struct kmem_cache *mnt_cache __read_mostly;
@@ -131,6 +134,7 @@ static int mnt_alloc_id(struct mount *mnt)
 	if (res < 0)
 		return res;
 	mnt->mnt_id = res;
+	mnt->mnt_id_unique = atomic64_inc_return(&mnt_id_ctr);
 	return 0;
 }
 
diff --git a/fs/stat.c b/fs/stat.c
index 6822ac77aec2..46d901b6b2de 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -280,8 +280,13 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
 
-	stat->mnt_id = real_mount(path.mnt)->mnt_id;
-	stat->result_mask |= STATX_MNT_ID;
+	if (request_mask & STATX_MNT_ID_UNIQUE) {
+		stat->mnt_id = real_mount(path.mnt)->mnt_id_unique;
+		stat->result_mask |= STATX_MNT_ID_UNIQUE;
+	} else {
+		stat->mnt_id = real_mount(path.mnt)->mnt_id;
+		stat->result_mask |= STATX_MNT_ID;
+	}
 
 	if (path.mnt->mnt_root == path.dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7cab2c65d3d7..2f2ee82d5517 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -154,6 +154,7 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.41.0

