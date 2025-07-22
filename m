Return-Path: <linux-fsdevel+bounces-55736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A62B0E43A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEA156428E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9628504F;
	Tue, 22 Jul 2025 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7ze+0GJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D272836BF;
	Tue, 22 Jul 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212503; cv=none; b=CYPhymhFawFNMOD/EPdw2CgybxI6nJkVPsbM0e+L9gcU62/kRUdtfg0RUoL+5dLGr/Lb1Qf7EV2zlWEdG1ZOIcWSusSaxDeMVPrcLfY01e8dDKG52KhcC0d4vGrmY5SSQyC9z1TUUy7ow4gGU0lNJVlaYcHGOh1TBaDPjGBmcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212503; c=relaxed/simple;
	bh=T4Bh1+M0kTwcxjlZ+MeS54DK/wzPNVuF32wPtrfe0WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOCrsAOQxYRXMgTXHziswOm+Z/yqHI0N/WeOuyZd41Qpx4nXyZ/emHo4YBsY2TR+gSwIJzAc2rrgjfNWbzJDbj++RDdnIAEcyb1CPnF2o/Hho3Fp/qq7uFbLVsFe+l+pxk3Jmho3Sk05z6A3c1sWRNj5A/x626tnKGeP7kl4cic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7ze+0GJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF04C4CEF7;
	Tue, 22 Jul 2025 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212502;
	bh=T4Bh1+M0kTwcxjlZ+MeS54DK/wzPNVuF32wPtrfe0WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7ze+0GJF0ZOkVqnSMP2u7Gl0CZl4KEudz+JKMzlvGTPo4R4jVpY2wSD9J6ueLQHP
	 avLvGguOaeKxxc33GDFO4AI0gLs3Dl4KEh2R10UcW9flBSW6UQeXAALR1rwNOEkWU7
	 /a/gpKAU9RCpLxN5ZEF1ByfmIvLoc/9yuKAzOqqDYMziYIatfcDYNEtcEdi+qdULSs
	 KY/+br+S51jAZ3Jt7OrjGZE4/9CRpqsUs9z9AEgGk1B8yeoQftVSG2vMjlFfKOWVVZ
	 s61p6UMh73j6Zh5wvocqiqOurBycp3fu3EtI80dt2fv6/RYSHAPcE0QyctmGmtAtV+
	 5JWp/rdbAHsGg==
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
Subject: [PATCH v3 10/13] btrfs: move fsverity to filesystem inode
Date: Tue, 22 Jul 2025 21:27:28 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-10-bdc1033420a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=brauner@kernel.org; h=from:subject:message-id; bh=T4Bh1+M0kTwcxjlZ+MeS54DK/wzPNVuF32wPtrfe0WA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5PLm12rMO35+cuXrl0+wvOjQvv/W8PHcaaH+eoFJ U+W87Jad5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk+ktGhskHfotZ19/2ljhm s/jqvOeHXOud9SfL3rd0ezlZqv9k7jFGhs8hjyrX+7UU9PQ+vpCysa5uxpaXwdJF1z6t3D2x7vm tF/wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fsverity data pointer into the filesystem's private inode and
record the offset from the embedded struct inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/btrfs_inode.h | 3 +++
 fs/btrfs/inode.c       | 3 +++
 fs/btrfs/super.c       | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a79fa0726f1d..10852d13fa00 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -339,6 +339,9 @@ struct btrfs_inode {
 
 	struct rw_semaphore i_mmap_lock;
 	struct inode vfs_inode;
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info *i_fsverity_info;
+#endif
 };
 
 static inline u64 btrfs_get_first_dir_index_to_log(const struct btrfs_inode *inode)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c0c778243bf1..ff0e0bde221a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7873,6 +7873,9 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	init_rwsem(&ei->i_mmap_lock);
+#ifdef CONFIG_FS_VERITY
+	ei->i_fsverity_info = NULL;
+#endif
 
 	return inode;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a0c65adce1ab..e5def2ce85d9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2395,6 +2395,10 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 }
 
 static const struct super_operations btrfs_super_ops = {
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct btrfs_inode, i_fsverity_info) -
+			  offsetof(struct btrfs_inode, vfs_inode),
+#endif
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
 	.put_super	= btrfs_put_super,

-- 
2.47.2


