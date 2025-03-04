Return-Path: <linux-fsdevel+bounces-43048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674AAA4D58E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CDE1734B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA81F9A83;
	Tue,  4 Mar 2025 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR29q8ge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3581F9413;
	Tue,  4 Mar 2025 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075188; cv=none; b=E+co3fLwwlH2NNjgpS7YUJ8Oj5DIge4EbhVZu5M4YjQVCC9B+2e6nYGAgmIRoDpIIIgO1RFtBTGRdt9fMHIqHFgkf78hVrxDT2uJvZD2KDWmn1CXmjYSw4S9X0WdSFxsf47FWbgj8rMsoj80+xVrAhi68A96hNn0azUZWfq96Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075188; c=relaxed/simple;
	bh=Cu4z4tJcKQnioK5oBCWV59p1bBfRBmR9sh8lkmQoAZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUXD0bUgAHKLqrFuL3bNAQRhDim0BisXWinHgAcAZdg9ok2ZtvfJUXIlT8hgL9W53ZJYDlCKeMBqmjORrkPn9q0ltfQ2THvSkzotuJQzPP8XAupaxqhyUqobnkTWSW5zY8JO/ol/UnKoJiWNC2w+WgrlcWOzCwEyYgJVBjEqM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR29q8ge; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471fabc5bf5so24870121cf.3;
        Mon, 03 Mar 2025 23:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741075186; x=1741679986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aV334ikN5dUEF1FAOBcx+MylSK4OZXxof9bYGpg/Ok=;
        b=GR29q8geLWfOns2hVVJFCjQhI+FGIS/xgwPnzFTau9ayJqdwf1QBlmkwYTCjI3h8Xt
         zNJ8GgcuzsOC6qrQnjirzcSdsRaSbk6eTcPGB2rPQRE1sHIc3EKNPin76iuCQKwN+AUj
         gzDdoU/khCWlPeRc5qTU3viPU1rr5tkOZFkISSTLq7saV605DemEM3fgxj+gVd8iXAPW
         OM06NZG++BRUBVyDAFJTinoC39qHA7+bLeK28URXL0o1OosQwwN4O0s96tdRhLSaY9Q6
         B7GZQbJk1V7m3fQXUPFM43tHR5B/L+3EyJYPIKA8lKdAP/dqhV6V2RgqRY0UcxZ8os8n
         rl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075186; x=1741679986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aV334ikN5dUEF1FAOBcx+MylSK4OZXxof9bYGpg/Ok=;
        b=pigatJrUAYkino9Yw00ATm8iFDQabdz+kvDu7WiAeM9fCMNtlMcgKjgipIYW2U8OWN
         GM8+N4C8FviTQTHLDEVqh+Y5iRiF1Y1Gp9FAEI5wkxB3grvi3m+6PO8xLWDEfKCJLGeD
         CpvxknG0yWFzAtcy10nAG8zw4zq2KuR6DW+PqPjcA262HiY0Kte8SRNXXVBis+aZPtuB
         C6E9dcWvAFTWrEg6JIsHPRLA+YT119eg+7A9ftCvxnnHK6eQZ23FRGTI9vFpkMJNp1mK
         I38800AfsT/BnVzjydGs9EqwXS9BsN8R7dypgMmv6KHMHqBBGdY4VxRIcWWhKo51qlH2
         OPPw==
X-Forwarded-Encrypted: i=1; AJvYcCXXirjT1TonsEkxm7Z+wY7+EpTTU6c2mipFZlkzQSBCl5YeunLDw8bggeq9BRab6S133hdMe2BJJFwZgVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEh+aAJqi+Av3TcmA4J+Amc3uKjvo9UV/z9hkilBBpSzwjI4d
	7nFcPYsqY8ayRDHT2Nf9mGTFdqMZQ8If7sDOmMC3pgnu0CFK9Kf5
X-Gm-Gg: ASbGnctbBBlLK9AC7aaN6/CN58FeZeTSsu56/IM0X5KyY5Ow2fQ1yqPDRLdhghJVqpA
	6kgUEMyk4RbgQrNwlOq/NH5CmTrsAueMa0rHCREtm7YuqFEtxS3nC2n7pRrAxqk8GRJNHXY3I18
	WNz54YWp3o4dXE6LmxKQv4S2/7zOvHYROFOwhIlscRogUr4r/EaZ2XUhEVpkpgRoIwxFt4BGo8d
	VI/qHQfUqeuAV5ESy1taCt8OXBYLnvSn8F/flq3AyHHuJGEdhyA6gzrTFV78ArqAXi8lrOxnve3
	/+GlSFHkfWAvuYrPhthhuHoDx+NKVeC4+x52PPoDMBMpqg==
X-Google-Smtp-Source: AGHT+IHIYoa+cieyOOJgxd5EL3wyq699sPw+C+GlH+7h85SoD+RTkabVF3VG6HjUXFBPykg/6gEcuA==
X-Received: by 2002:a05:622a:20a:b0:471:8d66:cd68 with SMTP id d75a77b69052e-474bc0554ddmr212901451cf.3.1741075185773;
        Mon, 03 Mar 2025 23:59:45 -0800 (PST)
Received: from iman-pc.home ([184.148.73.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a1f02sm70183901cf.11.2025.03.03.23.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:59:45 -0800 (PST)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: jack@suse.cz,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH] inotify: disallow watches on unsupported filesystems
Date: Tue,  4 Mar 2025 03:00:44 -0500
Message-ID: <20250304080044.7623-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

currently, inotify_add_watch() allows adding watches on filesystems
where inotify does not work correctly, without returning an explicit
error. This behavior is misleading and can cause confusion for users
expecting inotify to work on a certain filesystem.

This patch explicitly rejects inotify usage on filesystems where it
is known to be unreliable, such as sysfs, procfs, overlayfs, 9p, fuse,
and others.

By returning -EOPNOTSUPP, the limitation is made explicit, preventing
users from making incorrect assumptions about inotify behavior.

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index b372fb2c56bd..9b96438f4d46 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -87,6 +87,13 @@ static const struct ctl_table inotify_table[] = {
 	},
 };
 
+static const unsigned long unwatchable_fs[] = {
+	PROC_SUPER_MAGIC,      SYSFS_MAGIC,	  TRACEFS_MAGIC,
+	DEBUGFS_MAGIC,	      CGROUP_SUPER_MAGIC, SECURITYFS_MAGIC,
+	RAMFS_MAGIC,	      DEVPTS_SUPER_MAGIC, BPF_FS_MAGIC,
+	OVERLAYFS_SUPER_MAGIC, FUSE_SUPER_MAGIC,   NFS_SUPER_MAGIC
+};
+
 static void __init inotify_sysctls_init(void)
 {
 	register_sysctl("fs/inotify", inotify_table);
@@ -690,6 +697,14 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 }
 
 
+static inline bool is_unwatchable_fs(struct inode *inode)
+{
+	for (int i = 0; i < ARRAY_SIZE(unwatchable_fs); i++)
+		if (inode->i_sb->s_magic == unwatchable_fs[i])
+			return true;
+	return false;
+}
+
 /* inotify syscalls */
 static int do_inotify_init(int flags)
 {
@@ -777,6 +792,13 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	inode = path.dentry->d_inode;
 	group = fd_file(f)->private_data;
 
+	/* ensure that inotify is only used on supported filesystems */
+	if (is_unwatchable_fs(inode)) {
+		pr_debug("%s: inotify is not supported on filesystem with s_magic=0x%lx\n",
+				__func__, inode->i_sb->s_magic);
+		return -EOPNOTSUPP;
+	}
+
 	/* create/update an inode mark */
 	ret = inotify_update_watch(group, inode, mask);
 	path_put(&path);
-- 
2.48.1


