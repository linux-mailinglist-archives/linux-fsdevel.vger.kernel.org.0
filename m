Return-Path: <linux-fsdevel+bounces-8932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577B83C76E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366FB1C208FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BCF74E13;
	Thu, 25 Jan 2024 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7IBRCSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440586EB62
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198699; cv=none; b=Re6j7uF1eQIxhCe9/9mqHxfKUt9SmkVdUImUN1EbWE2Skzyqo+4ogKHfFINfmn+mrJjNFWg4GpgE7tyqkdVW1lMr7uhIinynAYaFLAMKNHoqMT1ksskPYIhA2rzAi8o3p5qOohfvks6wC55cuGCoy3zvuZKDpZ+I0HSG7v+lD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198699; c=relaxed/simple;
	bh=rGQAlVw7L+CcLVlduxZoey+YDk6+fyOq3ImOif5SK0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgBby1/YIYycHcXv3lqmnuwcP49W9iJlwUpZevUwcD53bvJ5BeZht7ANndqmQDmPrBmICJ+QMU+TtU1C1jnB53oz4euU7fPvFuLFnZkqJUOma04Js3C05Bwa0HWsINS9n5sUiX+LbE/bk8M8wrbaF9Ao2Ufvax2PxELjrIyE2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7IBRCSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E1CC43390;
	Thu, 25 Jan 2024 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706198697;
	bh=rGQAlVw7L+CcLVlduxZoey+YDk6+fyOq3ImOif5SK0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7IBRCSUXc4oFPNnsuViE4k38TifKr2ojRY/eDapBADzcGZsyYa1PjXVqeld3CPxI
	 RZCKdvWX6kvFDH94ytBvHreBWng0dNx/qVle9AE1e6gz/xTAEeatM00M3CQ84NmaEo
	 whHCPSCE/GO7juq4HSXWqCHiDaGwASYRYhvQd+RxcsKRUA3o4bY2RGXai3b5BJ4ZcL
	 OyvNqZa/cFzLVp9baWfujPDGCR0+6ZdZ60cNI2gywXIwlgIdCYR8i3ks7bT/Arx/2E
	 jHRgf/eQUZRdZ4GgBRzuDQTprQI5MqFCO8o7+L3dxova84NLjMx9KB8g5Axf3pp9Dq
	 Lo8toiD3WeINw==
From: cem@kernel.org
To: jack@suze.cz
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] Rename searched_dir->sd_dir to sd_isdir
Date: Thu, 25 Jan 2024 17:04:33 +0100
Message-ID: <20240125160447.1136023-2-cem@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125160447.1136023-1-cem@kernel.org>
References: <20240125160447.1136023-1-cem@kernel.org>
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


