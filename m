Return-Path: <linux-fsdevel+bounces-78088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ISjGuLgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:21:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D13C617F32A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1F25301A6A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9637F73D;
	Mon, 23 Feb 2026 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz+sKMdq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581353783C9;
	Mon, 23 Feb 2026 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888763; cv=none; b=Irs3YkhX8zDbzNHyiB0Hs3K4GqFoVN4XAUh1Ks23NbJ+tIItvYcPOBvfcCHzi0wEq5H4Hg6t89lTlUHxVRKXL4h0D6r7tTn5rOPc3ocMr7JFTcbJScuwbUVlBu1xh2IFlNxyRhaD+b6ZSGp5QiMKCSuiU/HE5E/w2CLidIL5RM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888763; c=relaxed/simple;
	bh=57beRrAEUMjrd2jfWlJUVSp3fkPlG1nrc6i5+AA4vro=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qs2+nd3z8rqk9JlayTMPXjE7+hagyh8szz8R4si012HBBvXroFyKunFxKV8CFGYhYJSI7uQCQA9BAis4TAfQMeOH90N82hwruSlrFlUOTgxhOVVMEEU3Ziq95W+TMuaaitzETPph9JTjGCMYbUjQptJd8eoLhOAxXuNk/lGXplw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz+sKMdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A96C116C6;
	Mon, 23 Feb 2026 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888762;
	bh=57beRrAEUMjrd2jfWlJUVSp3fkPlG1nrc6i5+AA4vro=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kz+sKMdqz6hM24lsKw39JKVxA4m0jttRalxWPhiP3y5VstQv9cOuW6bxh70PCXjFh
	 kvjdztBs/j8B3YEliYOXa0hlR0BDtDWhY0g4BlKX+vkGA8wKA12B8jjNz0sl4iX8cI
	 lrnW1HVb1eadCsUfYNociyA3xdQyAHYYWP0q+rI9RxDkPuIvHfoApsKrEeK47WLcuk
	 6eG7j6geD8ckXYXPqWDLkeSCFMDXg+jEmYDxIaACvF6/kWk2JSTS2NR99YgFajm5fh
	 kyoUiit+7rhD3PY723gIW9wUn+QwK8FGRoWJv/0ddJSBImF6GlWjiLswtmovjEYSKq
	 5J/Wh0rfcw5xw==
Date: Mon, 23 Feb 2026 15:19:22 -0800
Subject: [PATCH 5/9] fuse: cache atime when in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735633.3937167.14586216055435646231.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
References: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78088-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D13C617F32A
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

When we're running in iomap mode, allow the kernel to cache the access
timestamp to further reduce the number of roundtrips to the fuse server.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c        |    5 +++++
 fs/fuse/fuse_iomap.c |    6 ++++++
 fs/fuse/inode.c      |   11 ++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 10543873f1a611..6c05321e32f136 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2232,6 +2232,11 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 		inarg.ctime = inode_get_ctime_sec(inode);
 		inarg.ctimensec = inode_get_ctime_nsec(inode);
 	}
+	if (fuse_inode_has_iomap(inode)) {
+		inarg.valid |= FATTR_ATIME;
+		inarg.atime = inode_get_atime_sec(inode);
+		inarg.atimensec = inode_get_atime_nsec(inode);
+	}
 	if (ff) {
 		inarg.valid |= FATTR_FH;
 		inarg.fh = ff->fh;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 65c8e06fdd653a..9599efcf1c2593 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1164,6 +1164,12 @@ void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 	if (attr->flags & FUSE_ATTR_ATOMIC)
 		fuse_inode_set_atomic(inode);
 
+	/*
+	 * iomap caches atime too, so we must load it from the fuse server
+	 * at instantiation time.
+	 */
+	inode_set_atime(inode, attr->atime, attr->atimensec);
+
 	trace_fuse_iomap_init_inode(inode);
 }
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7fcadbfe87a593..1fedfb57a22514 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -266,7 +266,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	attr->mtimensec = min_t(u32, attr->mtimensec, NSEC_PER_SEC - 1);
 	attr->ctimensec = min_t(u32, attr->ctimensec, NSEC_PER_SEC - 1);
 
-	inode_set_atime(inode, attr->atime, attr->atimensec);
+	if (!(cache_mask & STATX_ATIME))
+		inode_set_atime(inode, attr->atime, attr->atimensec);
 	/* mtime from server may be stale due to local buffered write */
 	if (!(cache_mask & STATX_MTIME)) {
 		inode_set_mtime(inode, attr->mtime, attr->mtimensec);
@@ -331,8 +332,12 @@ u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (S_ISREG(inode->i_mode) &&
-	    (fuse_inode_has_iomap(inode) || fc->writeback_cache))
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	if (fuse_inode_has_iomap(inode))
+		return STATX_MTIME | STATX_CTIME | STATX_ATIME | STATX_SIZE;
+	if (fc->writeback_cache)
 		return STATX_MTIME | STATX_CTIME | STATX_SIZE;
 
 	return 0;


