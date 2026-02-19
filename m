Return-Path: <linux-fsdevel+bounces-77672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDgUFhqplmmTiQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:09:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3CC15C51A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7175300CFD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1132E6CCB;
	Thu, 19 Feb 2026 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPU1RqJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED402E541E;
	Thu, 19 Feb 2026 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771481362; cv=none; b=HHqTvCOLIbIxLkGbqffHaVN7daAKhDB9oQg9u/ZJZxKE8jlzOOW6uJgao4tSZXY3A102REpbJoxbItHo6hpXeFh4kCNisO41whXekZzYtOaCc7VPuRoME34CTbWjK6WAbklF2nuoW4W98UAb8fgPCKbh9Ap+AxUUIcyjLhgxaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771481362; c=relaxed/simple;
	bh=CbkgLJEewH+PqoJTmcEDVABEcGBweyYNzhHk54Ll3m4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK3MOyntJK74MtC3tjPHdMpZ+dThpGy93yT9C0w3b7GDxACDiuNNqzeQ0s0lzgtX7jdJ0rcj3PLKvItQynh4yzNP0/wsyewpz14bpcw2YygFnmkab9iIAQt6kXYh6iik676jyWLqEpVzSJ92c02KI4gwMaXSFSlxVbMeCp8WRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPU1RqJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD45C4CEF7;
	Thu, 19 Feb 2026 06:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771481362;
	bh=CbkgLJEewH+PqoJTmcEDVABEcGBweyYNzhHk54Ll3m4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RPU1RqJJfy8w90RK+sIqOjB4clxWeEdkgpl9Idu10PeKjznn5uIQq/DUvB+otBGRz
	 W+9rFW6fxLE07Q2ZJ/2zMXVAFtzq5qKej9Ogz88iLYvJ0Gg+0uVzr4RPAJyh94JCWi
	 o29akhLq5b3ijBJFVCjtF2rREMQN4ngYYK1riyxw7oSxcXYUTKhCLSJ8qm2AwCzv5m
	 DKFNHdNqGDynVmZwwi5tfXEvtw+5ST8nfYPB0Y9/Qh4FlKtKzUlbCRNGsTSf0aWfCL
	 QSj07+pU06Q8vSH3HZ0FBo2aB5rwlGjnMfsoFKs7r+t2dE2/kgXdpkHpC3JZD1HiJ7
	 VgQTsNoppNv/Q==
Date: Wed, 18 Feb 2026 22:09:21 -0800
Subject: [PATCH 1/2] fsnotify: drop unused helper
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: amir73il@gmail.com, jack@suse.cz, brauner@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <177148129543.716249.980530449513340111.stgit@frogsfrogsfrogs>
In-Reply-To: <177148129514.716249.10889194125495783768.stgit@frogsfrogsfrogs>
References: <177148129514.716249.10889194125495783768.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77672-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E3CC15C51A
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Remove this helper now that all users have been converted to
fserror_report_metadata as of 7.0-rc1.

Cc: jack@suse.cz
Cc: amir73il@gmail.com
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/linux/fsnotify.h |   13 -------------
 1 file changed, 13 deletions(-)


diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 28a9cb13fbfa38..079c18bcdbde68 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -495,19 +495,6 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 		fsnotify_dentry(dentry, mask);
 }
 
-static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
-				    int error)
-{
-	struct fs_error_report report = {
-		.error = error,
-		.inode = inode,
-		.sb = sb,
-	};
-
-	return fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR,
-			NULL, NULL, NULL, 0);
-}
-
 static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct vfsmount *mnt)
 {
 	fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);


