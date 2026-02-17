Return-Path: <linux-fsdevel+bounces-77418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO7CEmDilGlqIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:49:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ED3150F8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4C9B3027056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4492FE05D;
	Tue, 17 Feb 2026 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idLSOABQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95732FDC28;
	Tue, 17 Feb 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364901; cv=none; b=GN/QtEVK7RPWjjVxqpWvZPLA1paaBUWjECsAPIyZ4e2af1dMjMLfzYpcKCDF8riM/8wtfbLnXPrUcnQLmH30LaFnpAImuhi6kA5T/ea43HBKDW1x34fYD/eyltZ/f5D2ELw0n8246AyZxaoBu7/6eom6pVyDyFPoaRfeElRrOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364901; c=relaxed/simple;
	bh=vMwcFjIcGpJSP1R7CJ3+GJLH0fb47GKNB/gZZTxZOPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T562YaT7z6I8wYyrxR6tlkrQNBSfQI1wU6g0a6oSKZv5khzbzMN+ttCziPTv1xOr8NC8G8r+e6HfBjHntjMxXucSYVLETIO4flX6ktU9C98JwfAOP8niEHXglcMmwMWeqhUOci3cfGZrZHCQJ0aZX3/VBLsE1T81Mj/BrvkwpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idLSOABQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F218DC19423;
	Tue, 17 Feb 2026 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364901;
	bh=vMwcFjIcGpJSP1R7CJ3+GJLH0fb47GKNB/gZZTxZOPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idLSOABQJzxwgf7fSXF7i3xb3OWAVUQQAO7mKfNqDlyxbddu91Ex8n1RXhR45Sjlk
	 77IW5IxtxnYjQvuzcVCpf/ri37++BvKyNcAAnsFD6yxP+raSPmmGtBnxw22a18z/no
	 NMMyjNex9bMqIkKF6EK/mNxvPnRrNaOIx2cOU6hMDRE8ol9Eu5mkmNFMtwSaBSvoyG
	 3Cu9yzzWLFI19U0CjAAnkTE//gCmltE8VQNGqLdTQZZ1s+nrmR7/9dyN9DuOfWv0Dv
	 2xDXoTxpMDpOA3iCpmWicTnGJYaAXm0ZCsqDtsQa+BG6QXQ2vt1W59hBYrxnecdiow
	 7YSPFci0eoMMg==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v8 14/17] isofs: Implement fileattr_get for case sensitivity
Date: Tue, 17 Feb 2026 16:47:38 -0500
Message-ID: <20260217214741.1928576-15-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217214741.1928576-1-cel@kernel.org>
References: <20260217214741.1928576-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77418-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: E6ED3150F8E
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need a way to query whether a
filesystem handles filenames in a case-sensitive manner so
they can provide correct semantics to remote clients. Without
this information, NFS exports of ISO 9660 filesystems cannot
properly advertise their filename case behavior.

Implement isofs_fileattr_get() to report ISO 9660 case handling
behavior via the FS_XFLAG_CASEFOLD flag. The 'check=r' (relaxed)
mount option enables case-insensitive lookups, and this setting
determines the value reported. By default, Joliet extensions
operate in relaxed mode while plain ISO 9660 uses strict
(case-sensitive) mode. All ISO 9660 variants are case-preserving,
meaning filenames are stored exactly as they appear on the disc.

The callback is registered only on isofs_dir_inode_operations
because isofs has no custom inode_operations for regular
files, and symlinks use the generic page_symlink_inode_operations.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/isofs/dir.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 2ca16c3fe5ef..225124eefa46 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/filelock.h>
 #include "isofs.h"
+#include <linux/fileattr.h>
 
 int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
 {
@@ -267,6 +268,19 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 	return result;
 }
 
+static int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct isofs_sb_info *sbi = ISOFS_SB(dentry->d_sb);
+
+	/*
+	 * FS_XFLAG_CASEFOLD indicates case-insensitive lookups.
+	 * When check=r (relaxed) is set, lookups ignore case.
+	 */
+	if (sbi->s_check == 'r')
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	return 0;
+}
+
 const struct file_operations isofs_dir_operations =
 {
 	.llseek = generic_file_llseek,
@@ -281,6 +295,7 @@ const struct file_operations isofs_dir_operations =
 const struct inode_operations isofs_dir_inode_operations =
 {
 	.lookup = isofs_lookup,
+	.fileattr_get = isofs_fileattr_get,
 };
 
 
-- 
2.53.0


