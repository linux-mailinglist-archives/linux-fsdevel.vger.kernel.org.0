Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00D5777396
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjHJJAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHJJAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:00:49 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0D92115
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 02:00:48 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79b191089a3so195110241.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1691658047; x=1692262847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxV+g6cPuWZGz1us/p/P3KzaSA95f9jXZ60+ia8kzG4=;
        b=NZtQXyZavyKjXJQlLCbLMp8JQx4Bv6vfUlOxfmeTF7HXbqEybjwKBO0L5ZZ/BxqmGd
         mzt0Ne7r3nJ3mRWcONk65SCwIoTpSuNvReJVwRHPsaXct5B834tiu8jHUjWc4eR8b/+u
         JTqTSYw7DwsoR2TBoOpaWDG8gR/R8eqGGMpm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658047; x=1692262847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxV+g6cPuWZGz1us/p/P3KzaSA95f9jXZ60+ia8kzG4=;
        b=IRceTza+0qscY5qhs4bgpuWhbB9nSZiQI3LSSeP5s9Qh14GY2+Ve90mPwxHlD3SZf5
         HQ6zdNAX4B12lP3sv8zFZ+x5Z3YTsMxPL8s1qKeXviJrk+TzeyFn3TKd6V+FCtfPjhGR
         r8exStaGyB5yBtkvkrkOBHdwQdHumjLXHhphwGDTVgBc/w3TcQq7HIhxqGsb/DGYtSsz
         ikMGuupvXY28PNxbPQVSDfoqOTiVKS1zR2CDEdS4r+AlLeg/CCSCArTAErPRZ8oS8ocN
         wBimM641/hBNHN9v97R9u5yUA6+CL/dCVttyLf8i5m5TXkXojG9dv6+wNWL/hOeJ9M8Y
         zLyw==
X-Gm-Message-State: AOJu0YxGx9AWEuV2WbrN5LwkLG05vK0Yn1StbJGPnEg5p6TLHlCwHwsC
        gXAUVlqojbuvZxhnDlicFjU8euQR0vkKo60yFuI=
X-Google-Smtp-Source: AGHT+IE7qwq6W9dMp9jYpbuNuY+FW2lZK7aXPCfjfJmPodbQRRlJpyd8iTgCZqA/OnGdWV3shelY2w==
X-Received: by 2002:a05:6102:3bca:b0:443:7935:6eb5 with SMTP id a10-20020a0561023bca00b0044379356eb5mr1089841vsv.15.1691658047256;
        Thu, 10 Aug 2023 02:00:47 -0700 (PDT)
Received: from localhost (fwdproxy-frc-020.fbsv.net. [2a03:2880:21ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id 207-20020a250bd8000000b00d1e6e93e8f5sm249600ybl.51.2023.08.10.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:00:46 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/3] fs: Allow user to lock mount attributes with mount_setattr
Date:   Thu, 10 Aug 2023 02:00:43 -0700
Message-Id: <20230810090044.1252084-2-sargun@sargun.me>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230810090044.1252084-1-sargun@sargun.me>
References: <20230810090044.1252084-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We support locking certain mount attributes in the kernel. This API
isn't directly exposed to users. Right now, users can lock mount
attributes by going through the process of creating a new user
namespaces, and when the mounts are copied to the "lower privilege"
domain, they're locked. The mount can be reopened, and passed around
as a "locked mount".

Locked mounts are useful, for example, in container execution without
user namespaces, where you may want to expose some host data as read
only without allowing the container to remount the mount as mutable.

The API currently requires that the given privilege is taken away
while or before locking the flag in the less privileged position.
This could be relaxed in the future, where the user is allowed to
remount the mount as read only, but once they do, they cannot make
it read only again.

Right now, this allows for all flags that are lockable via the
userns unshare trick to be locked, other than the atime related
ones. This is because the semantics of what the "less privileged"
position is around the atime flags is unclear.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/namespace.c             | 40 +++++++++++++++++++++++++++++++++++---
 include/uapi/linux/mount.h |  2 ++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 54847db5b819..5396e544ac84 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -78,6 +78,7 @@ static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 struct mount_kattr {
 	unsigned int attr_set;
 	unsigned int attr_clr;
+	unsigned int attr_lock;
 	unsigned int propagation;
 	unsigned int lookup_flags;
 	bool recurse;
@@ -3608,6 +3609,9 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 
 #define MOUNT_SETATTR_PROPAGATION_FLAGS \
 	(MS_UNBINDABLE | MS_PRIVATE | MS_SLAVE | MS_SHARED)
+#define MOUNT_SETATTR_VALID_LOCK_FLAGS					       \
+	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV |	       \
+	 MOUNT_ATTR_NOEXEC)
 
 static unsigned int attr_flags_to_mnt_flags(u64 attr_flags)
 {
@@ -3629,6 +3633,22 @@ static unsigned int attr_flags_to_mnt_flags(u64 attr_flags)
 	return mnt_flags;
 }
 
+static unsigned int attr_flags_to_mnt_lock_flags(u64 attr_flags)
+{
+	unsigned int mnt_flags = 0;
+
+	if (attr_flags & MOUNT_ATTR_RDONLY)
+		mnt_flags |= MNT_LOCK_READONLY;
+	if (attr_flags & MOUNT_ATTR_NOSUID)
+		mnt_flags |= MNT_LOCK_NOSUID;
+	if (attr_flags & MOUNT_ATTR_NODEV)
+		mnt_flags |= MNT_LOCK_NODEV;
+	if (attr_flags & MOUNT_ATTR_NOEXEC)
+		mnt_flags |= MNT_LOCK_NOEXEC;
+
+	return mnt_flags;
+}
+
 /*
  * Create a kernel mount representation for a new, prepared superblock
  * (specified by fs_fd) and attach to an open_tree-like file descriptor.
@@ -4037,11 +4057,18 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 	int err;
 
 	for (m = mnt; m; m = next_mnt(m, mnt)) {
-		if (!can_change_locked_flags(m, recalc_flags(kattr, m))) {
+		int new_mount_flags = recalc_flags(kattr, m);
+
+		if (!can_change_locked_flags(m, new_mount_flags)) {
 			err = -EPERM;
 			break;
 		}
 
+		if ((new_mount_flags & kattr->attr_lock) != kattr->attr_lock) {
+			err = -EINVAL;
+			break;
+		}
+
 		err = can_idmap_mount(kattr, m);
 		if (err)
 			break;
@@ -4278,8 +4305,14 @@ static int build_mount_kattr(const struct mount_attr *attr, size_t usize,
 	if ((attr->attr_set | attr->attr_clr) & ~MOUNT_SETATTR_VALID_FLAGS)
 		return -EINVAL;
 
+	if (attr->attr_lock & ~MOUNT_SETATTR_VALID_LOCK_FLAGS)
+		return -EINVAL;
+
 	kattr->attr_set = attr_flags_to_mnt_flags(attr->attr_set);
 	kattr->attr_clr = attr_flags_to_mnt_flags(attr->attr_clr);
+	kattr->attr_lock = attr_flags_to_mnt_flags(attr->attr_lock);
+	kattr->attr_set |= attr_flags_to_mnt_lock_flags(attr->attr_lock);
+
 
 	/*
 	 * Since the MOUNT_ATTR_<atime> values are an enum, not a bitmap,
@@ -4337,7 +4370,7 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	struct mount_attr attr;
 	struct mount_kattr kattr;
 
-	BUILD_BUG_ON(sizeof(struct mount_attr) != MOUNT_ATTR_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct mount_attr) != MOUNT_ATTR_SIZE_VER1);
 
 	if (flags & ~(AT_EMPTY_PATH |
 		      AT_RECURSIVE |
@@ -4360,7 +4393,8 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	/* Don't bother walking through the mounts if this is a nop. */
 	if (attr.attr_set == 0 &&
 	    attr.attr_clr == 0 &&
-	    attr.propagation == 0)
+	    attr.propagation == 0 &&
+	    attr.attr_lock == 0)
 		return 0;
 
 	err = build_mount_kattr(&attr, usize, &kattr, flags);
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 4d93967f8aea..de667c4f852d 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -131,9 +131,11 @@ struct mount_attr {
 	__u64 attr_clr;
 	__u64 propagation;
 	__u64 userns_fd;
+	__u64 attr_lock;
 };
 
 /* List of all mount_attr versions. */
 #define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
+#define MOUNT_ATTR_SIZE_VER1	40
 
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.39.3

