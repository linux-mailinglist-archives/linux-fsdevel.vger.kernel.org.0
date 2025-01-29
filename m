Return-Path: <linux-fsdevel+bounces-40353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31AEA226D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 00:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2EB3A6E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 23:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07D1DE3C9;
	Wed, 29 Jan 2025 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZh83Top"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF9C19D898
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192847; cv=none; b=UnQTRQuwallLS4EL6wKaGI30ANzf+U/0+KYGDw+hMhsJfmFEGQl+3pEQgh9ff29bB9d/mr3Pu4G1UEthZX3WjdjbQyjiGumlzwFZgeBuctWMEFjLlc+W/TqUBzqDNbR4Io+ZrGW+BnLvHqiNCfjDfXHJ0Qpa8r5aC5swJdz3Br4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192847; c=relaxed/simple;
	bh=lp1S2UEzuPgR93/FsTP8aGAopmV7Np/IryQX4ELnQgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpG06XlVMMO5BN4CdUkU4tkq+f8O9EolZxyiNUSm02nrvTHB+0wLiDa41iQhM70uaO0StBP7uDyp2YczTyEOo9TaxSiShkZHePGLdViSiIhJ2hFaiaqqd9QMEKVkJSITycU5y9tzVbGtq7EDCfU/Mfy6AwnwKz3r7+WosAOvW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZh83Top; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A122DC4CED1;
	Wed, 29 Jan 2025 23:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192846;
	bh=lp1S2UEzuPgR93/FsTP8aGAopmV7Np/IryQX4ELnQgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iZh83TopFHygjRUjOAsTL5nwvE4cgOX9WCTm/Vx4WayFgzR5/ugU8v0wSP74ydhAk
	 wofbj0xFKdSR6OKZGbcdXN6RMP5CqKbEsw70fguOLTy3UPHH0f28Eu+pb60SNi7VTe
	 4Fp5FxCcIXPw52XZiBLPMVWI7zSlpcmu7ndnmweuQnzk4Q8AO4yG6pOMvbHyNB39l2
	 su+911jVP67Q+ETVYtQWI7MRHWy9CU+enKL2We5b/RQgHKftOTaNTKo35uHaW9SR9P
	 97sDuOljJ6YuX3rx/IqqiV3/2W8BgDPLEQmuLJ6CXCUcXe65xWe/OOfRoxiwPH0BpJ
	 Qxajj8or6REWA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Jan 2025 00:19:54 +0100
Subject: [PATCH 4/4] samples/vfs: add STATMOUNT_MNT_{G,U}IDMAP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-work-mnt_idmap-statmount-v1-4-d4ced5874e14@kernel.org>
References: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
In-Reply-To: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3480; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lp1S2UEzuPgR93/FsTP8aGAopmV7Np/IryQX4ELnQgc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2n44qedLLNMCf+ajr/6uYFMrz7v0cZpkzWlmvjOdS
 9Qm/Qm62FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARiS+MDAs0Ljdd9yqWS5oU
 aZiad8GfW+WYUXL+r9ybgsXMk3K2OjL8M4/6PP15inRHX+paH6HaFVnHOk90frXdEdcktF+S8cN
 tHgA=
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


