Return-Path: <linux-fsdevel+bounces-61544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82379B589C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51055483669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FED1A5B92;
	Tue, 16 Sep 2025 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxswhUs/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6413D521;
	Tue, 16 Sep 2025 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983057; cv=none; b=M06YGogYR39Pp/92cb9af6npgJEJjAsvqySAgMzPQYX75Rq8Or+M1ro38e3GGrjfaAGU8kac9wYamjGGK9DprWnAZF3JxN6X/YsRcT7JyWyzg/UHP92YKwxJkazjlmTThXvxocwl0Lv78m0syDs9XYcSAGZq4giMtwK9Jb/N1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983057; c=relaxed/simple;
	bh=f/zKD1CikgrK1K87ch/1WvFU/7p6K/HfJojdvbuMQi0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOSPeNFCdzD0jej/LuLVpsm8leeEqL5IkNvmxP6WqdLdUvmgTR30KeidEihvVRb+OPygAFFSRqH4cjIJkwrh3imhcawphIKiRBo9gFJTtvPM6MNUBUBNfk0Cw+u72BJBudS6dWpiaMdIXqLuYmLfdG3kkvf5+763rE2h5+ICygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxswhUs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BC5C4CEF1;
	Tue, 16 Sep 2025 00:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983057;
	bh=f/zKD1CikgrK1K87ch/1WvFU/7p6K/HfJojdvbuMQi0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mxswhUs/HGY8Sw8keVWB9e04hCj9HI1IRCYs9F8mLcCjH/UW170vR9mpAfXa6emnc
	 TSdy3RtGhyWD9JREbMnVIq2mkdFAS0f5K4aiMGVkZpdVK3AA6m3LZDKhFiJLT+WZKP
	 ouZtae5zvWQXcWyPCzMj843n4oHc7fWh4zzH5jeN8BkvkRQ2yn7VVeX+nHQCzS/Qrp
	 LJ/efG1wKcTVyUuZ+x+gD4KqevBuRFThdZdXxLadf70LvShwqjSoi6PzKdB+Q8V9rU
	 RsTFRHmlQGNkTDj/TCrqVsQ6aHBIQyP75B/ql7sqXH2al0CzEt6q4J+6CGOvPH8fsG
	 FzZ70yIlUOB0A==
Date: Mon, 15 Sep 2025 17:37:37 -0700
Subject: [PATCH 6/9] fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152567.383971.2162547009769364672.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
References: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Let the kernel handle killing the suid/sgid bits because the
write/falloc/truncate/chown code already does this, and we don't have to
worry about external modifications that are only visible to the fuse
server (i.e. we're not a cluster fs).

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 8247e5196fd0b2..2e1837b2363e83 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2268,6 +2268,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	struct inode *inode = d_inode(entry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct file *file = (attr->ia_valid & ATTR_FILE) ? attr->ia_file : NULL;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -2276,15 +2277,19 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!fuse_allow_current_process(get_fuse_conn(inode)))
 		return -EACCES;
 
-	if (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID)) {
+	if (!is_iomap &&
+	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
 		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
 				    ATTR_MODE);
 
 		/*
 		 * The only sane way to reliably kill suid/sgid is to do it in
-		 * the userspace filesystem
+		 * the userspace filesystem if this isn't an iomap file.  For
+		 * iomap filesystems we let the kernel kill the setuid/setgid
+		 * bits.
 		 *
-		 * This should be done on write(), truncate() and chown().
+		 * This should be done on write(), truncate(), chown(), and
+		 * fallocate().
 		 */
 		if (!fc->handle_killpriv && !fc->handle_killpriv_v2) {
 			/*


