Return-Path: <linux-fsdevel+bounces-78174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOUmIKHmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2ED17FE5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76DC230F9C7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813037FF5B;
	Mon, 23 Feb 2026 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdhH5a6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15237F8DA;
	Mon, 23 Feb 2026 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890109; cv=none; b=fN9/3CE6VfmDz3vkASPGgL5Bf1UU+HCy1vnMaIaYU27h2WBn8FPev9JaAial9t8CmtDAOVIVKcheXpjD9fRH9h+d88vHXmqm9XuxUvvjY2B1Spg+o6BI+/5uOo68sidP0u0pK0YeRQ1yCidvkfLqE7aOM2mpv7V/sfxv47jXqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890109; c=relaxed/simple;
	bh=gcieDKYXwTRyZuRpNCDSCjey5EzxB3X5vefqgoEinvU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJwhd2bjHCFxNWaJ4m0ikzYzCiY3m6beaxzGarnRU4IRWZaUwGT1IJZhNAtkzyqQcZG4oSvBYMA6+6IIVRB9gQf6aleJsp8Q1qPJXB9z0X5VSRLl8qRNV2ABlDSvvbPJ3FqMDvThTXsjj5NFkQNkeh/+zsDHJmZe3t1t+MyPHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdhH5a6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FC5C19421;
	Mon, 23 Feb 2026 23:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890108;
	bh=gcieDKYXwTRyZuRpNCDSCjey5EzxB3X5vefqgoEinvU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YdhH5a6dcYmVBrGzHLE/J1fNjVwZPjcAGukxORZzQbD6iTxi+TJ65VdrzWMXSLob4
	 nP8oWYAnB0ZXTeROlnXtUKw9fkAtRAG/68iotEcYiz6txcao9qD0NevpDduL3P4uVn
	 b8ENQXD1Y38P86N5WvPlrUEO3rrAdsvxdGP+cPOwt0zSYpvjPVB1cyVd+1WToWmABX
	 6cERmsRH7eu367TXvhK5QRKmtJzCYT6SNGq0HFsBZeAT2RFkiYZ32Jd9z4bAUbggl9
	 Irf+G+4+hnB7asbsUOWBA1PUI7BUPmoRFC14chYOiYveUN6U7kOWDqyUPodW1KvlmR
	 5IWlAmd8/C3Og==
Date: Mon, 23 Feb 2026 15:41:48 -0800
Subject: [PATCH 02/10] fuse2fs: skip permission checking on utimens when iomap
 is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745216.3944028.15549582531631012376.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78174-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C2ED17FE5C
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

When iomap is enabled, the kernel is in charge of enforcing permissions
checks on timestamp updates for files.  We needn't do that in userspace
anymore.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   11 +++++++----
 misc/fuse2fs.c    |   11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 428e4cb404cb45..b7ee336b5e4546 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -5276,13 +5276,16 @@ static int fuse4fs_utimens(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	/*
 	 * ext4 allows timestamp updates of append-only files but only if we're
-	 * setting to current time
+	 * setting to current time.  If iomap is enabled, the kernel does the
+	 * permission checking for timestamp updates; skip the access check.
 	 */
 	if (aact == TA_NOW && mact == TA_NOW)
 		access |= A_OK;
-	ret = fuse4fs_inum_access(ff, ctxt, ino, access);
-	if (ret)
-		return ret;
+	if (!fuse4fs_iomap_enabled(ff)) {
+		ret = fuse4fs_inum_access(ff, ctxt, ino, access);
+		if (ret)
+			return ret;
+	}
 
 	if (aact != TA_OMIT)
 		EXT4_INODE_SET_XTIME(i_atime, &atime, inode);
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 3cb875d0d29481..473a9124016712 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4930,13 +4930,16 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 
 	/*
 	 * ext4 allows timestamp updates of append-only files but only if we're
-	 * setting to current time
+	 * setting to current time.  If iomap is enabled, the kernel does the
+	 * permission checking for timestamp updates; skip the access check.
 	 */
 	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
 		access |= A_OK;
-	ret = check_inum_access(ff, ino, access);
-	if (ret)
-		goto out;
+	if (!fuse2fs_iomap_enabled(ff)) {
+		ret = check_inum_access(ff, ino, access);
+		if (ret)
+			goto out;
+	}
 
 	err = fuse2fs_read_inode(fs, ino, &inode);
 	if (err) {


