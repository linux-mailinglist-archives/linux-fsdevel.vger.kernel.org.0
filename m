Return-Path: <linux-fsdevel+bounces-78089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Nr4HIHhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3217F44F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D0F131A67A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4578737F744;
	Mon, 23 Feb 2026 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFHZ9WfN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5065372B45;
	Mon, 23 Feb 2026 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888778; cv=none; b=BQ/T7VysI/b/KYCt23aUNKdX2jEAvyrQaJwzsikGfdYt9dZFDprifcLfl5sKm/N+c5sFF9ecjS2AoWNTthzgKI+ubUDCtBkhIjic9yul9WSIwggCuuYS8TgjW1roHL7OD0qKkwAVA2XdpOW54SRpoXlU1xh28tG2Ytf5rC9JIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888778; c=relaxed/simple;
	bh=glkRfAk3p/on97oWX8K2cSFUpLJR22r1Yi6cfiEDtyQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsFLyliWSOSrmPIIKH1Ta65mlfk7LK01OAg6xLbFdTYM9lPu1kWo3NC8FwEGjz7Wt4RtrwaO84/9MiBCg4U2lT+xrT8C8bzwF0cII6hfgG5C1neJdNLU7EmnRsh8nhIi7tlntUkfW01qz5gmx7dp/u0SAYk+NPKjQrk09fNuy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFHZ9WfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9C0C116C6;
	Mon, 23 Feb 2026 23:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888778;
	bh=glkRfAk3p/on97oWX8K2cSFUpLJR22r1Yi6cfiEDtyQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tFHZ9WfNNVdVwuF4jZxhGELcS/LY4pQ0zNEqPxIHcfjqJx8lBiXzh8L9A7E8KXrSA
	 AaMzpTmE/Gd0sm3M2ZkUZ5c9CQVTqvgpAqLf+d4mNOENmyJHiUkq8bcueJDeCvBzRK
	 XHY3tvPU3O9AETDzK5CjMH1sfG2DMTb3pCJ+AYp1pDkNwjB866rlkse4nvU7dVmpU+
	 u+BpeeO3dwpgGap5WMxIBkLlOxF3xj+zW4KzjIxmWU44sDE6xST0jhGiIrb6V72tl6
	 bzF/n7Uixfl/aFwZslfRdGoTFWIk2yCGWcS7S0fArwIPHXXgv1ynFaQlN4QdSogADu
	 5sC1XThoSlZ5A==
Date: Mon, 23 Feb 2026 15:19:38 -0800
Subject: [PATCH 6/9] fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735654.3937167.2184848671221581607.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78089-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: CCC3217F44F
X-Rspamd-Action: no action

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
index 6c05321e32f136..069afade99d44f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2473,6 +2473,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	struct inode *inode = d_inode(entry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct file *file = (attr->ia_valid & ATTR_FILE) ? attr->ia_file : NULL;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -2481,15 +2482,19 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
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


