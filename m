Return-Path: <linux-fsdevel+bounces-34655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F99C7356
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FE01F22B61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2FC136326;
	Wed, 13 Nov 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGlIaTQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01596487B0;
	Wed, 13 Nov 2024 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507475; cv=none; b=XhZA3hvts80OfSly2UB9tX6BcLBWeKSWtSlEmLi5dYuRVo2QBoIP3UpiWJAqKTMibhWxzgx76kSsYcG7ZgkEFmk7URPpkK8xcgM4uOxkIYlzeu/FDJYB/eFBvNH/f6gf0ATgnfX5bR0GnaDeRKMLB0e1/4LIZFDgQiuN8lVP67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507475; c=relaxed/simple;
	bh=MjNKBxoaSsUUHCGD7dGsak+NKtkylFsf5hAYv3N+K4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R3nfdcj+dnHLbvnm+FTxaRE+sAH2olLI6E6lVYnOH4r6qnH2fAgN9eoj9pPlWhOcJaeW3MnEXqej93JspbBvyb2G642ZZzYG3QNokE+1+qHwkiBSh+8/7lp4JmXhwSAU6ToMYu9LHbrmykL1itcEwuKp8siOKfgVfDk+VK0LMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGlIaTQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B598C4CEC3;
	Wed, 13 Nov 2024 14:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731507474;
	bh=MjNKBxoaSsUUHCGD7dGsak+NKtkylFsf5hAYv3N+K4g=;
	h=From:Date:Subject:To:Cc:From;
	b=SGlIaTQvBtx/sXF8rirQQzavj+a1j39or/S3RaoqAPgFByJrQIHddN+rLr6ZL8WiD
	 FJMNDmaYMnD1gRn9PS/QKXtRGazlTX52fjGOFuxBOTCbH9bw2brpg0PbSBr9ue9cRS
	 B8fFbpa/oUIchI8MXLhGAbQbYjhz326TIkkCZUgiQKpjBsbPy3Mw0xjTSR47MQt7Es
	 fVthHlV8AbMi4DH+yHpeapmleM9NIvHthoOnrQWjrxg9wUyhVsFQ58vCK+nRflD/YB
	 ua3oZHvqDlyc82fiyHK4WgihEEqZQ43omYfamOsxVpnVshqI/vYSRvO0e+MQtdGQeD
	 eBxdxC+mbrjkg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 13 Nov 2024 09:17:51 -0500
Subject: [PATCH RFC] fs: reduce pointer chasing in is_mgtime() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-mgtime-v1-1-84e256980e11@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA61NGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Nj3dz0kszcVF3LxMQU8yRLg2Qzk0QloOKCotS0zAqwQdFKQW7OSrG
 1tQB5RMU+XQAAAA==
X-Change-ID: 20241113-mgtime-9aad7b90c64a
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2333; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MjNKBxoaSsUUHCGD7dGsak+NKtkylFsf5hAYv3N+K4g=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnNLURd1z1nUZvlsJfsz43G6htbQO90/KX3Pj7y
 yCMjzN7YpiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzS1EQAKCRAADmhBGVaC
 FcD+D/kByHQBdD8iSL30VR00S+ZLJTEWmE6nb/TA5jNm56V23ww8umdiE4kpaRUYHirCdgGndw2
 svYU6Axl3hU3Ty49VDk+518XMeIgyjvMy9L+I6AZJLiDYDmJSAnQfp+SaK2iLi0ZSYuB1nXXUz+
 jRTkQAvUvDF/FjTKs9oTz5DPhazcFhI2dLX4xOYs+su4X/NFqmsS+Esg1Z0280HttNiMB05vPOj
 0b88xotYYCBVEd8JdulkmodSpJadiXOZ1LSwyT2Wmnk4WhAujy9TP6Yk1T+CDEv35p+YiiRcjC9
 DrX7AiuBB0H6Z8278APThbCuzMsgX5RA2G20+fwFkr2MmF1IYeE/GGMBzKMTTjjUY4NUB0BMXxo
 N/+ohOWTIuc3Xoo+1KUQrRebeh9CJIwIOi0UjtKQSzZrsQCFnHTDxk+XCE8V7KrExoAxLabWni4
 YuzDkhOEGGXKpz485mwQzNX0fAMssjKGVUZ8cdKmjNCD1C9NQC5dTIkVlQ12nvMybuovY582BtD
 /6LBxbKRwf5TnbPne8vkZW93dmIEu8cOX0wQPWLJ6jM9DurbOHzItfdTzbnq/3xIcaCszsUvxN8
 LJSwIzPPicPxzowJ5yzyHn9FzaaFtcrmZTiOm2TiQp0qLUhh7n/h1Kp44XF/i2FzZw2Hh2xEiIs
 yu/dmx1zzORGEUA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The is_mgtime test checks whether the FS_MGTIME flag is set in the
fstype. To get there from the inode though, we have to dereference 3
pointers.

Add a new IOP_MGTIME flag, and have inode_init_always() set that flag
when the fstype flag is set. Then, make is_mgtime test for IOP_MGTIME
instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I had always had a little concern around the amount of pointer chasing
in this helper. Given the discussion around Josef's fsnotify patches, I
figured I'd draft up a patch to cut that down.

Sending this as an RFC since we're getting close to the end of the merge
window and I haven't done any performance testing with this.  I think
it's a reasonable thing to consider doing though, given how hot the
write() codepaths can be.
---
 fs/inode.c         | 2 ++
 include/linux/fs.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 838be0b49a63bd8d5700db0e6103c47e251793c3..70a2f8c717e063752a0b87c6eb27cde7a18d6879 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -243,6 +243,8 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	inode->i_opflags = 0;
 	if (sb->s_xattr)
 		inode->i_opflags |= IOP_XATTR;
+	if (sb->s_type->fs_flags & FS_MGTIME)
+		inode->i_opflags |= IOP_MGTIME;
 	i_uid_write(inode, 0);
 	i_gid_write(inode, 0);
 	atomic_set(&inode->i_writecount, 0);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index aa37083436096df9969d2f63f6ec4d1dc8b260d2..d32c6f6298b17c44ff22d922516028da31cec14d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -623,6 +623,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_NOFOLLOW	0x0004
 #define IOP_XATTR	0x0008
 #define IOP_DEFAULT_READLINK	0x0010
+#define IOP_MGTIME	0x0020
 
 /*
  * Keep mostly read-only and often accessed (especially for
@@ -2581,7 +2582,7 @@ struct file_system_type {
  */
 static inline bool is_mgtime(const struct inode *inode)
 {
-	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
+	return inode->i_opflags & IOP_MGTIME;
 }
 
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,

---
base-commit: 80ce1b3dc72ceab16a967e2aa222c5cc06ad6042
change-id: 20241113-mgtime-9aad7b90c64a

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


