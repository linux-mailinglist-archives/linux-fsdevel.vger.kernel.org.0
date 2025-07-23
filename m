Return-Path: <linux-fsdevel+bounces-55807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B19B0F090
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09121C84AD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4828003A;
	Wed, 23 Jul 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6eFs8uR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D42BE02F;
	Wed, 23 Jul 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268302; cv=none; b=i7jmHZnFDiihIYLz0g/2Kel6xmBCIvremxRciDiefIbZsLMXgFdrR4OPU+tQAEv72mVHEuMC51+fCv84WZB+yqtThubQ6sU0EeDS2HRXkmw/K1U6ccuPmObWxpkxeLCQEXcqUFb50g8+tQbglYEM/Ik+HLezL1c/r/2VZsMNz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268302; c=relaxed/simple;
	bh=VFpnLxTNG09VO56kHcLceJGwGQblOlophWm0LlFia4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDmNwX/sK1l7Xh96omkAEudKXgFcb9dG7nHvpXD+6RcrIvcRyhcZXclAx9t9RzGt5HquYmKwaT1HBg4rK/h4WD0cVOM+n1oX+zukoJMLtaDkKLopVMIR4bvIhmcVof5DRBAFbdPblHB/MYEO+X3sJwDQf1zX2sx0azUhxmHGSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6eFs8uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DE3C4CEE7;
	Wed, 23 Jul 2025 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268301;
	bh=VFpnLxTNG09VO56kHcLceJGwGQblOlophWm0LlFia4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6eFs8uRD3AKDDmE/aouPV05V/XuePBRiv6vx0xqPhUl+Q/+Rhtr0D+XLTO8ipngh
	 2V7SFl5e28TubWZbnlejtDOUOv8UMjmpskRcEVIoP57am15PAjKlKRkgyshSVTU3aV
	 PcA2TR3tArBxa/DmNIygP14Py2D3LREXsJf2fT5bADeGwMH3rHn10wDROh+fkxylan
	 7fNhYNox+qoc6reX7pfuGsxOsB2WyNfCwfVxYrZoKFwaAByvisel5QKK/s5O9+x9Xg
	 5WRUy0v+JwdiDuu+pAOGS6MyQ+MQg++qDwt8Ek2JyBVqejagEZelJ9yqD2Jw0/bwtt
	 Hj+0BNrBjftZg==
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
Subject: [PATCH v4 06/15] ceph: move fscrypt to filesystem inode
Date: Wed, 23 Jul 2025 12:57:44 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-6-c8e11488a0e6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2607; i=brauner@kernel.org; h=from:subject:message-id; bh=VFpnLxTNG09VO56kHcLceJGwGQblOlophWm0LlFia4c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNCqm2WoMuGkak3MLS/zEw7LEvVrLcOu+b5iDed3v SaXesu6o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJlVgz/MwSzNuU8rk2Qszde O+fxZ4a48oCT6ibvxXhrk/ZV6OkVMDLsSF4wacFHQ+fNu9ZpZITHC0Xz9b/6M7fxmcnK1O7QB++ 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ceph/crypto.c      | 4 ++++
 fs/ceph/inode.c       | 1 +
 fs/ceph/super.h       | 1 +
 include/linux/netfs.h | 7 +++++++
 4 files changed, 13 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 3b3c4d8d401e..9be1fb3f7b35 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -133,6 +133,10 @@ static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
 }
 
 static struct fscrypt_operations ceph_fscrypt_ops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.inode_info_offs	= offsetof(struct ceph_inode_info, i_crypt_info) -
+				  offsetof(struct ceph_inode_info, netfs),
+#endif
 	.needs_bounce_pages	= 1,
 	.get_context		= ceph_crypt_get_context,
 	.set_context		= ceph_crypt_set_context,
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 06cd2963e41e..73dd882ad018 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -665,6 +665,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_work_mask = 0;
 	memset(&ci->i_btime, '\0', sizeof(ci->i_btime));
 #ifdef CONFIG_FS_ENCRYPTION
+	ci->i_crypt_info = NULL;
 	ci->fscrypt_auth = NULL;
 	ci->fscrypt_auth_len = 0;
 #endif
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bb0db0cc8003..d55e20d61e22 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -463,6 +463,7 @@ struct ceph_inode_info {
 	unsigned long  i_work_mask;
 
 #ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_crypt_info;
 	u32 fscrypt_auth_len;
 	u32 fscrypt_file_len;
 	u8 *fscrypt_auth;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 065c17385e53..66f9ae1995e4 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -73,6 +73,13 @@ struct netfs_inode {
 #define NETFS_ICTX_SINGLE_NO_UPLOAD 4		/* Monolithic payload, cache but no upload */
 };
 
+/*
+ * struct inode must be the first member so we can easily calculate offsets for
+ * e.g., fscrypt or fsverity when embedded in filesystem specific inodes.
+ */
+static_assert(__same_type(((struct netfs_inode *)NULL)->inode, struct inode));
+static_assert(offsetof(struct netfs_inode, inode) == 0);
+
 /*
  * A netfs group - for instance a ceph snap.  This is marked on dirty pages and
  * pages marked with a group must be flushed before they can be written under

-- 
2.47.2


