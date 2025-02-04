Return-Path: <linux-fsdevel+bounces-40724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AFDA27032
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D826164F93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A1E20C037;
	Tue,  4 Feb 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCp8yBAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF620C033
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668493; cv=none; b=qYSrlZOYQwNZ14EcaXn4e4vVw/4OOxvlQIYQ1ga0QfKNloZK5yxcULzKAFw5mErl3ont1h29LR+yj+/SqB1tkzSJ1DWOUiV06d9HpfiF8r36t/fQdQiuBqVuF2ACInRzF30P0JjIKYy9+7ImU07i+lZIeEN+FZv+GX9dKAVgSTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668493; c=relaxed/simple;
	bh=lp1S2UEzuPgR93/FsTP8aGAopmV7Np/IryQX4ELnQgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LutLrGAnrqQ1t1c7l9CeElgcWf4HJdEKyP5qCc9CUZuJNApeRWQfBt56ZTwkGCbKgQFHISiMl9yRCrM5Sm87fjJROl76a/UjkMCrwLVVDW99b5vLrwQRq/5xQWOIuvVwYQhS6BQU0Ayh73+uhUK3/Dogysz4dImuS/y4V4cg6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCp8yBAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4644BC4CEE6;
	Tue,  4 Feb 2025 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668493;
	bh=lp1S2UEzuPgR93/FsTP8aGAopmV7Np/IryQX4ELnQgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YCp8yBAVy6u/ovcR0nuahW9a8g0ZPwC+fkZm483GmxEzOMb6K49okx9EJzBxv1z5P
	 jCsBEJBKJev4vl9yP+BFVLReiXpZqSFEeQNXmwyGwQaF5HrVgSlHCUZW1hV1x7bGQ+
	 WBNEiWFnbXKNkQIxmwykYzCc1EG5JJxV0Q9jyKe9EZmUuQhqft2EVHb58sCCw748vT
	 c8i1o6xdnoq3snCAJJ/nabsDM0Vulq4nuq+HwQ7+M08fR6bngiMCg0sozK7LgaUh/l
	 Tj7yWgArBm2z3JU23A0tfnctvaS5ks/qcxRt112GEFHGRa5hWraUvg8b0nNZV0AcPz
	 qktisrLXDrwig==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Feb 2025 12:27:49 +0100
Subject: [PATCH v2 4/4] samples/vfs: add STATMOUNT_MNT_{G,U}IDMAP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-work-mnt_idmap-statmount-v2-4-007720f39f2e@kernel.org>
References: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
In-Reply-To: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3480; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lp1S2UEzuPgR93/FsTP8aGAopmV7Np/IryQX4ELnQgc=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGeh+cCiaTuZEZyEUrZ/HKaaTur6ELQ8UsXHY9tsJxVULW2wA
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmeh+cAACgkQkcYbwGV43KIpBQD/YrdI
 fpbhsrITzbW30QTu1RhU3L8N0EM/yLxzwmh97skA/0Zk1hxNzBYHrwUbU53Hji2Kd4WZItdmcLe
 VpDrSu3gC
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Illustrate how to use STATMOUNT_MNT_{G,U}IDMAP.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 samples/vfs/samples-vfs.h          | 14 +++++++++++++-
 samples/vfs/test-list-all-mounts.c | 26 ++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/samples/vfs/samples-vfs.h b/samples/vfs/samples-vfs.h
index 103e1e7c4cec..a7ff4e79e8e6 100644
--- a/samples/vfs/samples-vfs.h
+++ b/samples/vfs/samples-vfs.h
@@ -42,7 +42,11 @@ struct statmount {
 	__u32 opt_array;	/* [str] Array of nul terminated fs options */
 	__u32 opt_sec_num;	/* Number of security options */
 	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
-	__u64 __spare2[46];
+	__u32 mnt_uidmap_num;	/* Number of uid mappings */
+	__u32 mnt_uidmap;	/* [str] Array of uid mappings */
+	__u32 mnt_gidmap_num;	/* Number of gid mappings */
+	__u32 mnt_gidmap;	/* [str] Array of gid mappings */
+	__u64 __spare2[44];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -158,6 +162,14 @@ struct mnt_ns_info {
 #define STATX_MNT_ID_UNIQUE 0x00004000U /* Want/got extended stx_mount_id */
 #endif
 
+#ifndef STATMOUNT_MNT_UIDMAP
+#define STATMOUNT_MNT_UIDMAP		0x00001000U	/* Want/got uidmap... */
+#endif
+
+#ifndef STATMOUNT_MNT_GIDMAP
+#define STATMOUNT_MNT_GIDMAP		0x00002000U	/* Want/got gidmap... */
+#endif
+
 #ifndef MOUNT_ATTR_RDONLY
 #define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
 #endif
diff --git a/samples/vfs/test-list-all-mounts.c b/samples/vfs/test-list-all-mounts.c
index ce272ded8a79..bb3b83d8f1d7 100644
--- a/samples/vfs/test-list-all-mounts.c
+++ b/samples/vfs/test-list-all-mounts.c
@@ -128,14 +128,16 @@ int main(int argc, char *argv[])
 					      STATMOUNT_MNT_POINT |
 					      STATMOUNT_MNT_NS_ID |
 					      STATMOUNT_MNT_OPTS |
-					      STATMOUNT_FS_TYPE, 0);
+					      STATMOUNT_FS_TYPE |
+					      STATMOUNT_MNT_UIDMAP |
+					      STATMOUNT_MNT_GIDMAP, 0);
 			if (!stmnt) {
 				printf("Failed to statmount(%" PRIu64 ") in mount namespace(%" PRIu64 ")\n",
 				       (uint64_t)last_mnt_id, (uint64_t)info.mnt_ns_id);
 				continue;
 			}
 
-			printf("mnt_id:\t\t%" PRIu64 "\nmnt_parent_id:\t%" PRIu64 "\nfs_type:\t%s\nmnt_root:\t%s\nmnt_point:\t%s\nmnt_opts:\t%s\n\n",
+			printf("mnt_id:\t\t%" PRIu64 "\nmnt_parent_id:\t%" PRIu64 "\nfs_type:\t%s\nmnt_root:\t%s\nmnt_point:\t%s\nmnt_opts:\t%s\n",
 			       (uint64_t)stmnt->mnt_id,
 			       (uint64_t)stmnt->mnt_parent_id,
 			       (stmnt->mask & STATMOUNT_FS_TYPE)   ? stmnt->str + stmnt->fs_type   : "",
@@ -143,6 +145,26 @@ int main(int argc, char *argv[])
 			       (stmnt->mask & STATMOUNT_MNT_POINT) ? stmnt->str + stmnt->mnt_point : "",
 			       (stmnt->mask & STATMOUNT_MNT_OPTS)  ? stmnt->str + stmnt->mnt_opts  : "");
 
+			if (stmnt->mask & STATMOUNT_MNT_UIDMAP) {
+				const char *idmap = stmnt->str + stmnt->mnt_uidmap;
+
+				for (size_t idx = 0; idx < stmnt->mnt_uidmap_num; idx++) {
+					printf("mnt_uidmap[%lu]:\t%s\n", idx, idmap);
+					idmap += strlen(idmap) + 1;
+				}
+			}
+
+			if (stmnt->mask & STATMOUNT_MNT_GIDMAP) {
+				const char *idmap = stmnt->str + stmnt->mnt_gidmap;
+
+				for (size_t idx = 0; idx < stmnt->mnt_gidmap_num; idx++) {
+					printf("mnt_gidmap[%lu]:\t%s\n", idx, idmap);
+					idmap += strlen(idmap) + 1;
+				}
+			}
+
+			printf("\n");
+
 			free(stmnt);
 		}
 	}

-- 
2.47.2


