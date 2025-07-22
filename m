Return-Path: <linux-fsdevel+bounces-55732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E6FB0E432
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B83A1C809BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D59283FE7;
	Tue, 22 Jul 2025 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcT/6oKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20CB288D2;
	Tue, 22 Jul 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212491; cv=none; b=lJOsGTYTl9bZo5KrNZinEuY2rXrEYKXcONX0IppU13lNptLvwOvZETHXrfym+U4qplxn84mUpbd5VSEC/8Yhj76ETC7offTSjXYDb5xj1LTgY0i08TdkdyDAqziwO66iOdGkZK2w2rFlPXo4MYhPmhvby6Gr3FuQi3O4IJuj4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212491; c=relaxed/simple;
	bh=MyqIt6rk/PV2TRVOLsVg2jvW+LtJ2TwtlUin/5eBT6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3EVTp1rV2LoqrrZJMnYcdXZF2QN56yOmbMijOe13LnRNlWK/qpBBSIET3l5hEXV3hspPG/v9t0qmv3lLoOquskVX8aMpoLsLK17XC5XYkMBSkhQTNz2NJyIdht1nZTRnZGf3Phh0AFNI1t5EWswoWcniA/e+RkxjyjMcEJDtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcT/6oKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F38C4CEF4;
	Tue, 22 Jul 2025 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212490;
	bh=MyqIt6rk/PV2TRVOLsVg2jvW+LtJ2TwtlUin/5eBT6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcT/6oKQW4YW2qYGqIkLlGkKk2kjAGI/sqLybJK+5+hb19nXNbi4V5BA5VNlan6y7
	 iN0DplNqKbFFPLp7dRWos7fQGmup8EMxMZyyMfgEXUSH0896xhrh9l5tfELZQNCd/B
	 kiYvJ0reqG989Rf8TYNje82D4uknt2tVgWWbqaqmzj9C/5geB9FUzXX7jyMdQFIEWX
	 mB59m2bH9KQ4HtnqQ9js0SCcoj/WF0gaKZbU/dO7OzRwyiYdR2mIcA0BRG6haWQBVR
	 aVDBiMIOP1FovphkKPz0pLEWmd6oXbnaGgXowTbJ1nd24cPZiy+QbPui+qgxM83MQS
	 +njq6dX5MqKgA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v3 06/13] ceph: move fscrypt to filesystem inode
Date: Tue, 22 Jul 2025 21:27:24 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-6-bdc1033420a0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=brauner@kernel.org; h=from:subject:message-id; bh=MyqIt6rk/PV2TRVOLsVg2jvW+LtJ2TwtlUin/5eBT6k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5OdG6NpPilkzkHp0F/rso/9W6TaN0l4z+z/f9Puy fxjd1Th7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIpwMjw8xjPPbMHnrHSm94 Le/u2p5V/zz/R+MhH7XuEy/mOrkUtzH8s/zIdmqaX4/A5BNnPhi93q1QLWzNKfxS8UJxQ9iBbS9 5WAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ceph/super.c       | 4 ++++
 include/linux/netfs.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 2b8438d8a324..540b32e746de 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1039,6 +1039,10 @@ void ceph_umount_begin(struct super_block *sb)
 }
 
 static const struct super_operations ceph_super_ops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt = offsetof(struct ceph_inode_info, netfs.i_fscrypt_info) -
+		     offsetof(struct ceph_inode_info, netfs.inode),
+#endif
 	.alloc_inode	= ceph_alloc_inode,
 	.free_inode	= ceph_free_inode,
 	.write_inode    = ceph_write_inode,
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 065c17385e53..fda1321da861 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -57,6 +57,9 @@ typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error);
  */
 struct netfs_inode {
 	struct inode		inode;		/* The VFS inode */
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_fscrypt_info;
+#endif
 	const struct netfs_request_ops *ops;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	struct fscache_cookie	*cache;
@@ -503,6 +506,9 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 		ctx->zero_point = ctx->remote_i_size;
 		mapping_set_release_always(ctx->inode.i_mapping);
 	}
+#ifdef CONFIG_FS_ENCRYPTION
+	ctx->i_fscrypt_info = NULL;
+#endif
 }
 
 /**

-- 
2.47.2


