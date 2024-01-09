Return-Path: <linux-fsdevel+bounces-7611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D188828757
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2371F2569F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4BA39852;
	Tue,  9 Jan 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvvRmYp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64D39846
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 13:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55458C43390;
	Tue,  9 Jan 2024 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704808020;
	bh=rGQAlVw7L+CcLVlduxZoey+YDk6+fyOq3ImOif5SK0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvvRmYp9HsyNrh8rU37+L6eaEM15X9XSZiPAWSrd6nu5dexelpV53gxDCMEC6XNkx
	 DxF3Q7M1kwYJQVcjzcbDrD9JeEG7BhP75BaTm2o6ngCL+wywt2UhNq3DigEcWDKOIi
	 bwtsJHdoawAw5SFPWT+aRO6Wd6dtumWkBFoQOtQ/r0GCwrw+OJgWd+p93acVkOG6Sv
	 gYw+/4sPwhza0Ng8kCx78Prw9T81pCHSIGHh9T3VuGtwZ8y9VAlftZY+atp4RA4yLz
	 VO2teAriuGKAipvS4k10YW/ULkEC5SYZpWJ6yYAFsm2RTssb6bJ/hrF4P/abiW+uXE
	 AidtWDbWsrmDg==
From: cem@kernel.org
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] Rename searched_dir->sd_dir to sd_isdir
Date: Tue,  9 Jan 2024 14:46:03 +0100
Message-ID: <20240109134651.869887-2-cem@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109134651.869887-1-cem@kernel.org>
References: <20240109134651.869887-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

The field holds information if we are searching a directory mountpoint or a
device, rename the field to something more meaningful.

We could switch it to bool, but it seems pointless to include a whole header
just for it, so keep the int type.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 quotasys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/quotasys.c b/quotasys.c
index 3f50e32..9af9932 100644
--- a/quotasys.c
+++ b/quotasys.c
@@ -1223,7 +1223,7 @@ int kern_quota_on(struct mount_entry *mnt, int type, int fmt)
  */
 
 struct searched_dir {
-	int sd_dir;		/* Is searched dir mountpoint or in fact device? */
+	int sd_isdir;		/* Is searched dir mountpoint or in fact device? */
 	dev_t sd_dev;		/* Device mountpoint lies on */
 	ino_t sd_ino;		/* Inode number of mountpoint */
 	const char *sd_name;	/* Name of given dir/device */
@@ -1454,7 +1454,7 @@ static int process_dirs(int dcnt, char **dirs, int flags)
 					errstr(_("Cannot stat() given mountpoint %s: %s\nSkipping...\n"), dirs[i], strerror(errno));
 					continue;
 				}
-			check_dirs[check_dirs_cnt].sd_dir = S_ISDIR(st.st_mode);
+			check_dirs[check_dirs_cnt].sd_isdir = S_ISDIR(st.st_mode);
 			if (S_ISDIR(st.st_mode)) {
 				const char *realmnt = dirs[i];
 
@@ -1538,7 +1538,7 @@ restart:
 		return 0;
 	sd = check_dirs + act_checked;
 	for (i = 0; i < mnt_entries_cnt; i++) {
-		if (sd->sd_dir) {
+		if (sd->sd_isdir) {
 			if (sd->sd_dev == mnt_entries[i].me_dev && sd->sd_ino == mnt_entries[i].me_ino)
 				break;
 		}
-- 
2.43.0


