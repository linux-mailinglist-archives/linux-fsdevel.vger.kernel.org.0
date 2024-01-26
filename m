Return-Path: <linux-fsdevel+bounces-9085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F683E0FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A971F23595
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02374208CA;
	Fri, 26 Jan 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw0kgYg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28F208B8
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292152; cv=none; b=mWiicJWRXHlzM8FJDCiWKMpTOVWhFj4VhoOfvYGIxfb/VVv6LDkKEzQukE7Cl++l4lDv+2ObFxVEAAXMnWx3lI76R2p+TiiU3wgS4lEOng693TfaY9cSmpJCpY5n/RTDwwUXuVjKVLgXgO2PcQ7E3l9pAy/scZegLSSsPD0hdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292152; c=relaxed/simple;
	bh=rGQAlVw7L+CcLVlduxZoey+YDk6+fyOq3ImOif5SK0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFi47LuErg790j4xTbhyu+seHoS8P7IEPJJHOy6fVjHAhHfoTC2fyRVy0CLpz3R9q4ODrhPWvKHCuXm4uBUbAQyNxzoaIMAzGwT33XiFpOnuNn0siONXlxyUHq0gaAiN/Gbtr45MQylSUpsemN1WjcjGtbGxVh8M4fUu2O7+gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw0kgYg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081AAC433C7;
	Fri, 26 Jan 2024 18:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706292151;
	bh=rGQAlVw7L+CcLVlduxZoey+YDk6+fyOq3ImOif5SK0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw0kgYg0DUpZQvb8bQUNKSaZ83Pkwtsrb51yNW52DUUSlclwY9qobK/YYyBmIrjJO
	 ZKHG1xbWveZOU4NUS+id/OvOROBB4sjVLCN+KWbo7+4Un/ZSP1nLZG9ji6fE2huvtl
	 Q8MaVVkYwR/pbl/UEyEROn6gDz88LlMoBkiCZgk2M/E1luOz2V2GKefRZ6I49CQniX
	 hjXFs2tyljqBddZzD4U/iBFgLhhqpGSIyrF7zHqLr0RJRV85MO32TR770mRbESgwBO
	 gmT8GCzUJQNPfG9tV38ZfbqlxHY5B4cIjSZpyq5L58098cbdrTUi9F7arBfZvNEvjt
	 Lxb7kwKJf4V5A==
From: cem@kernel.org
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] Rename searched_dir->sd_dir to sd_isdir
Date: Fri, 26 Jan 2024 19:02:09 +0100
Message-ID: <20240126180225.1210841-2-cem@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126180225.1210841-1-cem@kernel.org>
References: <20240126180225.1210841-1-cem@kernel.org>
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


