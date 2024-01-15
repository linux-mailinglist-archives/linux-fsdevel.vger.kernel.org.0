Return-Path: <linux-fsdevel+bounces-8019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F081C82E385
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 00:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55ED21F210BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EEE1DA38;
	Mon, 15 Jan 2024 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwwgbvgq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A261DA2F;
	Mon, 15 Jan 2024 23:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62ADC433C7;
	Mon, 15 Jan 2024 23:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361135;
	bh=YK6VyuQzOI9wmAvuOxrLnF2nxyYKwf2VdorqgLdYVRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwwgbvgqXXmPCBlx5CZ2g3x7Wmp6ufyOG0Drv/EDBY4a9wxG+H2juSRV9shkKjwjL
	 m9XgjWsxxDkNSAUrHspAo5LptSL2KRYf94BkDAVARvBl/ZtVdZHmkXAk4U2FLkNuEV
	 TQyulQ0JeqZfhnbDO7B9R01BpJl+v3gBlLJb+qukIAigY1di74KBOR+lncPX8lqGC7
	 eQsc7N4wZg+KW5mEmDgnDLEfyAdbzNWYG933HgqoOr6tuJlkX8OaR8yC12aOmGyuRq
	 wyX3WLWA82uaAiOuCfTiS3GqZKKuTxRXbk+JRa7fFHhV+c29ifHdECm8kpPz6FvHyA
	 ECWWOKNxFf72A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Ian Kent <raven@themaw.net>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/14] add unique mount ID
Date: Mon, 15 Jan 2024 18:24:35 -0500
Message-ID: <20240115232501.208889-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232501.208889-1-sashal@kernel.org>
References: <20240115232501.208889-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 98d2b43081972abeb5bb5a087bc3e3197531c46e ]

If a mount is released then its mnt_id can immediately be reused.  This is
bad news for user interfaces that want to uniquely identify a mount.

Implementing a unique mount ID is trivial (use a 64bit counter).
Unfortunately userspace assumes 32bit size and would overflow after the
counter reaches 2^32.

Introduce a new 64bit ID alongside the old one.  Initialize the counter to
2^32, this guarantees that the old and new IDs are never mixed up.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Link: https://lore.kernel.org/r/20231025140205.3586473-2-mszeredi@redhat.com
Reviewed-by: Ian Kent <raven@themaw.net>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index e157efc54023..e02bc5f41c7b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -68,6 +68,9 @@ static u64 event;
 static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
+/* Don't allow confusion with old 32bit mount ID */
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
index 5375be5f97cc..e2a124a2d5f3 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -247,8 +247,13 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 
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
2.43.0


