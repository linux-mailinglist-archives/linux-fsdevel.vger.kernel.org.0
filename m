Return-Path: <linux-fsdevel+bounces-26739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6395B81A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8831F22A19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92781CBE96;
	Thu, 22 Aug 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZZa9f1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813A1C9EA9
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336094; cv=none; b=GwEkeGzsQMJ3y23wq7GWoML6b/ZTt7UVjBGLuBPc9LPBRd2nbUpp9id2lDp0xW7e2y4E+6retiopm2657Rpy8BeQWFFnvHoGRL25gcYwxnIHKhodl+oZBu0ptyaJJ1e0zKDXL/ySlePLx71jBZs/f2tEV7UTY94nR0kc+JFs/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336094; c=relaxed/simple;
	bh=ATd+UQYAmuNiL/lyQdGPVyVOibxPMvZX63RWsxDEi4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6Yg1aqeWwJe8gCNWtvbMVRzwzgNnRx2JOu8EnhTxOMQ2MawO+1i+7KwAfH+UUXquQ9fCVCW3zK3QyR6L9L30nx+6SiEOEiN67jzZVdSNqbCsa9gmxkwYhCfIRfGOs5rWFFWxYgOVXS/COk9raPrGj5nXqc6J+E4u6csFjK66K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZZa9f1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F185C32782;
	Thu, 22 Aug 2024 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724336093;
	bh=ATd+UQYAmuNiL/lyQdGPVyVOibxPMvZX63RWsxDEi4o=;
	h=From:To:Cc:Subject:Date:From;
	b=tZZa9f1ge+c38Bo2SLRaLjfxEfStGw7WoDzkyRrQrs6qeFGjDd3Q2wfj8gke3amJ1
	 vm4dL+k0tEl6QEbCmQp8UIMN6zPxrBXHA3a6jxK25Iq6B7ogOBK+R3v41C6YJcLpBu
	 QrDs5uGcKZGCM10z6a7lbcBiXpYbSo358+UNU0gCRha8q4309fgkrSYUV1mElKdNV+
	 jzDvzIltshQ4z+AtzObw4S2zLq4EyTwJJ+gi1gammWlNWGLgxG2DAUNeig3KnbKD1z
	 CiYEqyZv2FBt91LaB50OsMpxRjKlo11E5KmPbOKsOXu/9qsh8u7SUAWHnTPNKrwe5D
	 f4mEtBMlvYP+w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: switch f_iocb_flags and f_version
Date: Thu, 22 Aug 2024 16:14:46 +0200
Message-ID: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; i=brauner@kernel.org; h=from:subject:message-id; bh=ATd+UQYAmuNiL/lyQdGPVyVOibxPMvZX63RWsxDEi4o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQdd79WkPaJ9TPfn20Hr+ep3Jd4l18gF6y7dLpepEWFO ZsDdztfRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETm5TL8Ytr+WtRrhtS3QiH/ 1j9XW1dl9czz4i/lUgxutNq95PGvU4wM7R8Xvjrfwa/xkX3d0sZnvF8MGrXLi+01eNcZMMozPVL gBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that we shrank struct file by 24 bytes we still have a 4 byte hole.
Move f_version into the union and f_iocb_flags out of the union to fill
that hole and shrink struct file by another 4 bytes. This brings struct
file to 200 bytes down from 232 bytes.

I've tried to audit all codepaths that use f_version and none of them
rely on it in file->f_op->release() and never have since commit
1da177e4c3f4 ("Linux-2.6.12-rc2").

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
struct file {
        union {
                struct callback_head f_task_work;        /*     0    16 */
                struct llist_node  f_llist;              /*     0     8 */
                u64                f_version;            /*     0     8 */
        };                                               /*     0    16 */
        spinlock_t                 f_lock;               /*    16     4 */
        fmode_t                    f_mode;               /*    20     4 */
        atomic_long_t              f_count;              /*    24     8 */
        struct mutex               f_pos_lock;           /*    32    32 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        loff_t                     f_pos;                /*    64     8 */
        unsigned int               f_flags;              /*    72     4 */
        unsigned int               f_iocb_flags;         /*    76     4 */
        struct fown_struct *       f_owner;              /*    80     8 */
        const struct cred  *       f_cred;               /*    88     8 */
        struct file_ra_state       f_ra;                 /*    96    32 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct path                f_path;               /*   128    16 */
        struct inode *             f_inode;              /*   144     8 */
        const struct file_operations  * f_op;            /*   152     8 */
        void *                     f_security;           /*   160     8 */
        void *                     private_data;         /*   168     8 */
        struct hlist_head *        f_ep;                 /*   176     8 */
        struct address_space *     f_mapping;            /*   184     8 */
        /* --- cacheline 3 boundary (192 bytes) --- */
        errseq_t                   f_wb_err;             /*   192     4 */
        errseq_t                   f_sb_err;             /*   196     4 */

        /* size: 200, cachelines: 4, members: 20 */
        /* last cacheline: 8 bytes */
};
---
 include/linux/fs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7eb4f706d59f..7a2994405e8e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -998,9 +998,8 @@ struct file {
 		struct callback_head 	f_task_work;
 		/* fput() must use workqueue (most kernel threads). */
 		struct llist_node	f_llist;
-		unsigned int 		f_iocb_flags;
+		u64			f_version;
 	};
-
 	/*
 	 * Protects f_ep, f_flags.
 	 * Must not be taken from IRQ context.
@@ -1011,6 +1010,7 @@ struct file {
 	struct mutex		f_pos_lock;
 	loff_t			f_pos;
 	unsigned int		f_flags;
+	unsigned int 		f_iocb_flags;
 	struct fown_struct	*f_owner;
 	const struct cred	*f_cred;
 	struct file_ra_state	f_ra;
@@ -1018,7 +1018,6 @@ struct file {
 	struct inode		*f_inode;	/* cached value */
 	const struct file_operations	*f_op;
 
-	u64			f_version;
 #ifdef CONFIG_SECURITY
 	void			*f_security;
 #endif
-- 
2.43.0


