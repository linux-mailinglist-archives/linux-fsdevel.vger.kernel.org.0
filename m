Return-Path: <linux-fsdevel+bounces-55804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30094B0F0AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B017BADF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB72DCBE2;
	Wed, 23 Jul 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuuCSZ4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288B28CF6D;
	Wed, 23 Jul 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268292; cv=none; b=RfLGtgmhsc/sRmTrpZPwDUT6hMHd2ZLenqyQ8qdsLdD088o2Xl1feXrlXOmD/uT8/fNw82ObnekP1ITx5O4dSJ205jEGm4SH07LHXYllW6ieWdmDefE3qWrWRuyy11D8SJbt/M2B2Woo21l5xp6sa6VUKmt1j8Mlqh/VdrKl/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268292; c=relaxed/simple;
	bh=NhtNkYuXwHStDWdtuie9A4k+kGKIDhnpql4SKQqfQCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qwj90vi4LDyVkl+ousQCCoqXJhvq0gnluF2XSQ8XcCQpXtNKiccm80x2jJu1pfVgp4f5sKJhrWqJlS3N0u3VRcNH2UkRmEtH0YIb1dj2Vf/BY1iTgZEiH0o47+ics47T1p1vmVuJ8nNx8qa3oRfhuXF/WMpPpOY8iN0KKi4J6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuuCSZ4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11991C4CEF7;
	Wed, 23 Jul 2025 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268291;
	bh=NhtNkYuXwHStDWdtuie9A4k+kGKIDhnpql4SKQqfQCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BuuCSZ4Nop347Onr8/80NaJNjf5lHy6V4wzVOgGKQabIqTZalatc4H30q1mtMxCQV
	 rBAbb6RVVIFmueZfjvhGORrcnfXjXZ53QG0of396AXN4uupfq9oii/BaaA3PI3Ntoh
	 kLljDZtVd82UPVo32uV1Yl6amI0QXl2I+1AxCB46+qKHI8s/zVcuZt9OqEauJZTJOh
	 TtckaKBC2IFk4c29zbBI26Ba8ZbjakRM2jZjQ1sMV+oQcs1sa9VUz2cMlFaOE6Msfr
	 HPRHJYdVsreDTVlQ1Y9yiDXvQaSvLzfi1oJtrJnDFNDBDzYFLoXmRz+P3KuijgzW9n
	 zMhN3pJJKs52Q==
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
Subject: [PATCH v4 03/15] ext4: move fscrypt to filesystem inode
Date: Wed, 23 Jul 2025 12:57:41 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-3-c8e11488a0e6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=brauner@kernel.org; h=from:subject:message-id; bh=NhtNkYuXwHStDWdtuie9A4k+kGKIDhnpql4SKQqfQCw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNA0FJmtseTRDqNLR06b5bhqXgqViL45e5HE/Zc3D hZUG65W6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIoSLDH87MBJEVR97yGVmW 8dl9uMfU8SWky/Cy0y3Vn50vL27teMvIsLNk3uMbOs4TFWW/nuP/K3NejuNP6nNV108fXzExL3M LYwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/crypto.c | 4 ++++
 fs/ext4/ext4.h   | 4 ++++
 fs/ext4/super.c  | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 0a056d97e640..9837cbfa9159 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -227,6 +227,10 @@ static bool ext4_has_stable_inodes(struct super_block *sb)
 }
 
 const struct fscrypt_operations ext4_cryptops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.inode_info_offs	= offsetof(struct ext4_inode_info, i_crypt_info) -
+				  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.needs_bounce_pages	= 1,
 	.has_32bit_inodes	= 1,
 	.supports_subblock_data_units = 1,
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18373de980f2..75209a09b19f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1197,6 +1197,10 @@ struct ext4_inode_info {
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_crypt_info;
+#endif
 };
 
 /*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..47c450c68a3b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1412,6 +1412,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	spin_lock_init(&ei->i_fc_lock);
+#ifdef CONFIG_FS_ENCRYPTION
+	ei->i_crypt_info = NULL;
+#endif
 	return &ei->vfs_inode;
 }
 

-- 
2.47.2


