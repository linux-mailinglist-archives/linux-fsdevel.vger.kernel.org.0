Return-Path: <linux-fsdevel+bounces-78180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOrACjjmnGlxMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEDC17FD81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5595430E6C83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9837FF69;
	Mon, 23 Feb 2026 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfSGv3dq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A2A2EA151;
	Mon, 23 Feb 2026 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890187; cv=none; b=Jd+UUOqFVI2nnt9ps0CMyEbcwLW2c072vSA5zlUxygDDrUjaayFqTLbT7viTkh2BcGZkskx6pc7EjSPWOR0ObbZGXbi5Dh/CYBckWFTmVIncRAsbOiqM+gD4s6W33ZYfxtzp7S6hkAzCEy+OZ6wbde186DTyDXwlFgnzIR94qdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890187; c=relaxed/simple;
	bh=7dPNRxOSe/7H+Da9oHvOVM3RG/GaWVBgFEe5Zm6sKSs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGOFPIF1+qZ5ZW9cXbKHzsXtLzn49xj8KMr8rnI4E9xM4OpUSXIXNgy8CDwFjcClLkcN3RYUs7peFr5akzD0UYHUVCQKRf/TbjslprH/G25r55PueOsCUAhKMo1rMF1Dkj7vyPeKNByl4gjhi/fqqRoIyo+0lSCA790ni1BoBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfSGv3dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDC3C116C6;
	Mon, 23 Feb 2026 23:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890187;
	bh=7dPNRxOSe/7H+Da9oHvOVM3RG/GaWVBgFEe5Zm6sKSs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TfSGv3dqudX0Sc1DsXhRntRwrrRiOmcrBYa7dn6zNFHPRtSXKGpa3Sj5vaI2tZBIL
	 J5pF3XuSxIZwD01ezkzdZjhMEIan763ejv49zS7gYcBmueNFkzeNDXFv57IFYt0NzT
	 Y6HPDOzakPgJxqMnb7j2WMmzLUuWNFgVPkTNiWllREpOcoeebeV+eoSxapsM5NDFEL
	 g7//Kykwd4TASsL/RHBYWLrmlO6UPwy3MWwx0ALLrfHxPG6gk+uXZy6lNpt6yed/OA
	 QARgorzjGNlrpEbAse6wud85QPHgAyCVBp1MOBw/5mWnYAL6vmier9XbkkzMGYpooH
	 a/AmHYXFI74IQ==
Date: Mon, 23 Feb 2026 15:43:06 -0800
Subject: [PATCH 07/10] fuse2fs: add tracing for retrieving timestamps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745306.3944028.16378672825168795763.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
References: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78180-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FEDC17FD81
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracing for retrieving timestamps so we can debug the weird
behavior.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9b536fe77dda37..b11ffec3603bf9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1946,9 +1946,11 @@ static void *op_init(struct fuse_conn_info *conn,
 	return ff;
 }
 
-static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
+static int fuse2fs_stat(struct fuse2fs *ff, ext2_ino_t ino,
+			struct stat *statbuf)
 {
 	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
 	dev_t fakedev = 0;
 	errcode_t err;
 	int ret = 0;
@@ -1987,6 +1989,13 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 #else
 	statbuf->st_ctime = tv.tv_sec;
 #endif
+
+	dbg_printf(ff, "%s: ino=%d atime=%lld.%ld mtime=%lld.%ld ctime=%lld.%ld\n",
+		   __func__, ino,
+		   (long long int)statbuf->st_atim.tv_sec, statbuf->st_atim.tv_nsec,
+		   (long long int)statbuf->st_mtim.tv_sec, statbuf->st_mtim.tv_nsec,
+		   (long long int)statbuf->st_ctim.tv_sec, statbuf->st_ctim.tv_nsec);
+
 	if (LINUX_S_ISCHR(inode.i_mode) ||
 	    LINUX_S_ISBLK(inode.i_mode)) {
 		if (inode.i_block[0])
@@ -2033,16 +2042,15 @@ static int op_getattr(const char *path, struct stat *statbuf,
 		      struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
-	ext2_filsys fs;
 	ext2_ino_t ino;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
-	fs = fuse2fs_start(ff);
+	fuse2fs_start(ff);
 	ret = fuse2fs_file_ino(ff, path, fi, &ino);
 	if (ret)
 		goto out;
-	ret = stat_inode(fs, ino, statbuf);
+	ret = fuse2fs_stat(ff, ino, statbuf);
 out:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -3832,7 +3840,7 @@ static int fuse2fs_file_uses_iomap(struct fuse2fs *ff, ext2_ino_t ino)
 	if (!fuse2fs_iomap_enabled(ff))
 		return 0;
 
-	ret = stat_inode(ff->fs, ino, &statbuf);
+	ret = fuse2fs_stat(ff, ino, &statbuf);
 	if (ret)
 		return ret;
 
@@ -4741,7 +4749,7 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 			(unsigned long long)i->dirpos);
 
 	if (i->flags == FUSE_READDIR_PLUS) {
-		ret = stat_inode(i->fs, dirent->inode, &stat);
+		ret = fuse2fs_stat(i->ff, dirent->inode, &stat);
 		if (ret)
 			return DIRENT_ABORT;
 	}


