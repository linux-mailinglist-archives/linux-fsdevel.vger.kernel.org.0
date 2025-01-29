Return-Path: <linux-fsdevel+bounces-40352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB516A226D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 00:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1AB7A2F86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 23:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577EF1E3793;
	Wed, 29 Jan 2025 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV7Y9Bmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74381B4F02
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192844; cv=none; b=J6qiNmHVyGAGwOszet6ZEv9Fjt+sXSLkiN5P8REETvPnVNZmqOD5aAb93FWnSo+82Ovb013H7rqJ3Wd5odE6YM+U8uCmZM669CCHWSn4zcKyBLORv5NfwQin6KOyBAxT58bHdMVs0vh/46i5qy8BPDDwl0F1CxBwhF3Y/l6gaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192844; c=relaxed/simple;
	bh=vDzcH+jxvipj5mOU7vGgaaam7ebEwSwPJMT1JIlWZV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rc/3ogtcFWEAZsNFZ06pAPIB16TiLG4I+IkiR2gGvcAzErbV2ovbaI2SVBqjWDTu1e3B5KoOeWD9DldDYri8lZEgXKpwfzOQ62y6eVET78gD8mt8lhsnmHlcc+bU1DwCPBgCTGV+zLVLYZQic7e7z/UTAbTCI+U/hZ2OkwgAUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV7Y9Bmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D46C4CEE4;
	Wed, 29 Jan 2025 23:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192844;
	bh=vDzcH+jxvipj5mOU7vGgaaam7ebEwSwPJMT1JIlWZV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FV7Y9Bmm2FT3ezSWq2BJVa0UJwpYQu5a53wa1xgE8Doipg/yn7JeLGRQXuz9uEpoz
	 F7SMZWD3A2ZbBQefKjNwb4nVnIoF5RKmSPpLLbOHo6mXYeKzpXzfk48FsEkhi5/ui6
	 QyOU1Lmv8viV2TvOXxt97OtHpC4t3zbO3hIPVQIseWVHmf8h+XK5B1p0SF/5D0koHl
	 tkyXDhByDuWWrQt4jAJGaBfytehu8fHzqEM8kKBEOPyxfI84rjdf1p2cZYA6aT7YA1
	 gNSqDrhL9sf0xKGarUvYzZP8Jx9ByKyXRmkdPJ8N0Hs7oObOHdLh861YDHJYuHlvQ+
	 BdyaLBoRvQr2w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Jan 2025 00:19:53 +0100
Subject: [PATCH 3/4] samples/vfs: check whether flag was raised
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-work-mnt_idmap-statmount-v1-3-d4ced5874e14@kernel.org>
References: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
In-Reply-To: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vDzcH+jxvipj5mOU7vGgaaam7ebEwSwPJMT1JIlWZV4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2n64+be6XdqOX9Mv8lQ+4nVLOfAyKjZveaXv2Tefq
 172FfrodJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEeDUjw5GsriXfmtrmfv5z
 fXNIfX3vpx15l9pzj+2Z2e7ab6gwJZThn/1VkfTf+owP1EStNisrzX1449TlA64VSS80Wv6EXX3
 FzwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

For string options the kernel will raise the corresponding flag only if
the string isn't empty. So check for the flag.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 samples/vfs/test-list-all-mounts.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/samples/vfs/test-list-all-mounts.c b/samples/vfs/test-list-all-mounts.c
index 1a02ea4593e3..ce272ded8a79 100644
--- a/samples/vfs/test-list-all-mounts.c
+++ b/samples/vfs/test-list-all-mounts.c
@@ -138,10 +138,11 @@ int main(int argc, char *argv[])
 			printf("mnt_id:\t\t%" PRIu64 "\nmnt_parent_id:\t%" PRIu64 "\nfs_type:\t%s\nmnt_root:\t%s\nmnt_point:\t%s\nmnt_opts:\t%s\n\n",
 			       (uint64_t)stmnt->mnt_id,
 			       (uint64_t)stmnt->mnt_parent_id,
-			       stmnt->str + stmnt->fs_type,
-			       stmnt->str + stmnt->mnt_root,
-			       stmnt->str + stmnt->mnt_point,
-			       stmnt->str + stmnt->mnt_opts);
+			       (stmnt->mask & STATMOUNT_FS_TYPE)   ? stmnt->str + stmnt->fs_type   : "",
+			       (stmnt->mask & STATMOUNT_MNT_ROOT)  ? stmnt->str + stmnt->mnt_root  : "",
+			       (stmnt->mask & STATMOUNT_MNT_POINT) ? stmnt->str + stmnt->mnt_point : "",
+			       (stmnt->mask & STATMOUNT_MNT_OPTS)  ? stmnt->str + stmnt->mnt_opts  : "");
+
 			free(stmnt);
 		}
 	}

-- 
2.47.2


