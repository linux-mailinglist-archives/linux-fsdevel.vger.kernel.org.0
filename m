Return-Path: <linux-fsdevel+bounces-78165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAx3CTflnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:39:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F38BF17FB4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CC3F3035BC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A437FF53;
	Mon, 23 Feb 2026 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2211xIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A537F8D1;
	Mon, 23 Feb 2026 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889968; cv=none; b=rnoRGShVS/IQJ0WUAj2Hg+iHGzsMmd/ppYh1x2pHgI/FDWCPA3rzoP7S89xeYk+7AmglgPMIMMot7DDODaLQ28EKoE7X8uKV55gfq4qGdpnOhkpHrcPusg6+vedgrUyfjyRQpAACE7JAf7es7XlXvunh+XwGTLwCUnYANSH6xZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889968; c=relaxed/simple;
	bh=eNOHxBliJByOYkRBh5aohvrAWVa1bQuZTiTm+T1g4Pk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxPchjybmP4Owef61BtMd51PXN1YHcaG9/1gwxkNbR/uC0Kok2EWay82WJDRk1olA7GV4Oq1FwR2abX60JKvP/UzqlNvaAD2dOGOD9useVYgNOg0ZGsPc+sGN5SlSTv1wxFLix0F68QjnsUvP/AM//yGfFV2WwNxbaLMmU6xpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2211xIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D5EC116C6;
	Mon, 23 Feb 2026 23:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889968;
	bh=eNOHxBliJByOYkRBh5aohvrAWVa1bQuZTiTm+T1g4Pk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=L2211xIOaWE71Ths1fFF2T8SNI8d1Ir5WdJBU51Vwbb73zvO3uLIvocLOparqeMQj
	 sz5ni/i2zd3NVZE7/vhcv5pOoIu8Deb/0Id2oEknSq7pF2PvjMojTsnoJRX81/r5mc
	 TjUlkZgIsCLgjoLs8t1Jd5Cn3MzSxuZkMufRnIAAK1kSIwRTydqWhVJTSIF62PoWln
	 QdyeLOZRqz8kduN+RZHIkTXo6xs6BJkIkx3EPvi2dE0rElBNUpTuMfo5iSGfJPlQ6Q
	 Ah14/CeNKZZbTqb+xLEeAfE/xIzaRKu63Ye96+7v1y82udH+VmK/IV3QoZZKqv+SSH
	 Kq0U60KE0SdbQ==
Date: Mon, 23 Feb 2026 15:39:27 -0800
Subject: [PATCH 13/19] fuse2fs: set iomap-related inode flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744715.3943178.17863278029246864273.stgit@frogsfrogsfrogs>
In-Reply-To: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
References: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78165-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F38BF17FB4D
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Set FUSE_IFLAG_* when we do a getattr, so that all files will have iomap
enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   46 +++++++++++++++++++++++++++++++++++-----------
 misc/fuse2fs.c    |   20 ++++++++++++++++++++
 2 files changed, 55 insertions(+), 11 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 59c8d7de7e4533..395f2fcd067633 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2043,6 +2043,7 @@ static void op_init(void *userdata, struct fuse_conn_info *conn)
 
 struct fuse4fs_stat {
 	struct fuse_entry_param	entry;
+	unsigned int iflags;
 };
 
 static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
@@ -2108,9 +2109,29 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 	entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
 	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
 
+	fstat->iflags = 0;
+#ifdef HAVE_FUSE_IOMAP
+	if (fuse4fs_iomap_enabled(ff))
+		fstat->iflags |= FUSE_IFLAG_IOMAP | FUSE_IFLAG_EXCLUSIVE;
+#endif
+
 	return 0;
 }
 
+#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 99)
+#define fuse_reply_entry_iflags(req, entry, iflags) \
+	fuse_reply_entry((req), (entry))
+
+#define fuse_reply_attr_iflags(req, entry, iflags, timeout) \
+	fuse_reply_attr((req), (entry), (timeout))
+
+#define fuse_add_direntry_plus_iflags(req, buf, sz, name, iflags, entry, dirpos) \
+	fuse_add_direntry_plus((req), (buf), (sz), (name), (entry), (dirpos))
+
+#define fuse_reply_create_iflags(req, entry, iflags, fp) \
+	fuse_reply_create((req), (entry), (fp))
+#endif
+
 static void op_lookup(fuse_req_t req, fuse_ino_t fino, const char *name)
 {
 	struct fuse4fs_stat fstat;
@@ -2141,7 +2162,7 @@ static void op_lookup(fuse_req_t req, fuse_ino_t fino, const char *name)
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_entry(req, &fstat.entry);
+		fuse_reply_entry_iflags(req, &fstat.entry, fstat.iflags);
 }
 
 static void op_getattr(fuse_req_t req, fuse_ino_t fino,
@@ -2161,8 +2182,8 @@ static void op_getattr(fuse_req_t req, fuse_ino_t fino,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_attr(req, &fstat.entry.attr,
-				fstat.entry.attr_timeout);
+		fuse_reply_attr_iflags(req, &fstat.entry.attr, fstat.iflags,
+				       fstat.entry.attr_timeout);
 }
 
 static void op_readlink(fuse_req_t req, fuse_ino_t fino)
@@ -2440,7 +2461,7 @@ static void fuse4fs_reply_entry(fuse_req_t req, ext2_ino_t ino,
 		return;
 	}
 
-	fuse_reply_entry(req, &fstat.entry);
+	fuse_reply_entry_iflags(req, &fstat.entry, fstat.iflags);
 }
 
 static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
@@ -4768,10 +4789,13 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	namebuf[dirent->name_len & 0xFF] = 0;
 
 	if (i->readdirplus) {
-		entrysize = fuse_add_direntry_plus(i->req, i->buf + i->bufused,
-						   i->bufsz - i->bufused,
-						   namebuf, &fstat.entry,
-						   i->dirpos);
+		entrysize = fuse_add_direntry_plus_iflags(i->req,
+							  i->buf + i->bufused,
+							  i->bufsz - i->bufused,
+							  namebuf,
+							  fstat.iflags,
+							  &fstat.entry,
+							  i->dirpos);
 	} else {
 		entrysize = fuse_add_direntry(i->req, i->buf + i->bufused,
 					      i->bufsz - i->bufused, namebuf,
@@ -4996,7 +5020,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_create(req, &fstat.entry, fp);
+		fuse_reply_create_iflags(req, &fstat.entry, fstat.iflags, fp);
 }
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
@@ -5195,8 +5219,8 @@ static void op_setattr(fuse_req_t req, fuse_ino_t fino, struct stat *attr,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_attr(req, &fstat.entry.attr,
-				fstat.entry.attr_timeout);
+		fuse_reply_attr_iflags(req, &fstat.entry.attr, fstat.iflags,
+				       fstat.entry.attr_timeout);
 }
 
 #define FUSE4FS_MODIFIABLE_IFLAGS \
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5651b9633c5bb6..ed1b3068f22931 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1978,6 +1978,23 @@ static int op_getattr(const char *path, struct stat *statbuf,
 	return ret;
 }
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+static int op_getattr_iflags(const char *path, struct stat *statbuf,
+			     unsigned int *iflags, struct fuse_file_info *fi)
+{
+	int ret = op_getattr(path, statbuf, fi);
+
+	if (ret)
+		return ret;
+
+	if (fuse_fs_can_enable_iomap(statbuf))
+		*iflags |= FUSE_IFLAG_IOMAP | FUSE_IFLAG_EXCLUSIVE;
+
+	return 0;
+}
+#endif
+
+
 static int op_readlink(const char *path, char *buf, size_t len)
 {
 	struct fuse2fs *ff = fuse2fs_get();
@@ -6664,6 +6681,9 @@ static struct fuse_operations fs_ops = {
 #ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+	.getattr_iflags = op_getattr_iflags,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,


