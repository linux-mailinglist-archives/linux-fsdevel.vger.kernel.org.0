Return-Path: <linux-fsdevel+bounces-78172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ3xNXrmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5102017FE19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2933D3069C5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC837F8DF;
	Mon, 23 Feb 2026 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itp1GHwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92537FF55;
	Mon, 23 Feb 2026 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890077; cv=none; b=h8tUK3uZab2TtHpQfk6+q6Tqfo+Ji5wKfsbmE2cyM8GnlmIvyJfn7GUHglYg/gAGRESBHK0aAA5m+o/M6feNj9od3SIyn6aaelhjTJ619TQv14HNmcgAMQtrEWm/sjKBJhfHMHV88ichFG1+XTLM9D838h+wpWfYW9UqGYPYBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890077; c=relaxed/simple;
	bh=notneqwy1X3OeXRkObOFxlBBPaGqCxXcZE/KfW8DCYE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKgscPBVVfX0Zyw2RX7tnvEcyUM6Dt3b2KQZ3YjJcOyd0sxJ1bGaNCH6vpGJ+I2sVz+s4bHzGWCXMqzR81Xh6vjCMe+o5FJYgICZyf7rFT/cI6xbvykkbqd/sM4FzmBOBqbP6iIgfSH7yu8KJffiU7SVHXszOqvruD/OE6Rioe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itp1GHwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D2CC19424;
	Mon, 23 Feb 2026 23:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890077;
	bh=notneqwy1X3OeXRkObOFxlBBPaGqCxXcZE/KfW8DCYE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=itp1GHwrVUYI0CPa7+umd9sQYry6gFRkvNqUx5ICcn7wIGgB6QV1aoxd758WG+yoJ
	 93XMMaZQQcOBQ/qZj3j7EcsQY31CknS4dJE49GXrLurjrDn9GNqlWx6b+B6/HR4Zoa
	 B8xilMeoR5Uh5weOsHQ7aVwuctI21Y+8yRaQYhLACiwMjw/IlMabJH4kMdgFbzdOci
	 Gswn9o/2zSAPnrPzhBRM46qCiSXEZ8y4S3lcVo6LOLFX3Er+qKmSPE7CZk89ny0eTi
	 AsCK84h/12dmwtTGF7Ftnjt+xR+GB/9vvGkfFXyxYwgeoLR4rKsN8Xmz5v8tffTFVP
	 33sal+N4kDNAg==
Date: Mon, 23 Feb 2026 15:41:16 -0800
Subject: [PATCH 1/1] fuse4fs: don't use inode number translation when possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744984.3943927.9096434421214899658.stgit@frogsfrogsfrogs>
In-Reply-To: <177188744965.3943927.10298806606780785317.stgit@frogsfrogsfrogs>
References: <177188744965.3943927.10298806606780785317.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78172-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 5102017FE19
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Prior to the integration of iomap into fuse, the fuse client (aka the
kernel) required that the root directory have an inumber of
FUSE_ROOT_ID, which is 1.  However, the ext2 filesystem defines the root
inode number to be EXT2_ROOT_INO, which is 2.  This dissonance means
that we have to have translator functions, and that any access to
inumber 1 (the ext2 badblocks file) will instead redirect to the root
directory.

That's horrible.  Use the new mount option to set the root directory
nodeid to EXT2_ROOT_INO so that we don't need this translation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 170accabfd9fd6..bebc2410af382e 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -273,6 +273,7 @@ struct fuse4fs {
 	int directio;
 	int acl;
 	int dirsync;
+	int translate_inums;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -345,17 +346,19 @@ struct fuse4fs {
 #define FUSE4FS_CHECK_CONTEXT_INIT(req) \
 	__FUSE4FS_CHECK_CONTEXT((req), abort(), abort())
 
-static inline void fuse4fs_ino_from_fuse(ext2_ino_t *inop, fuse_ino_t fino)
+static inline void fuse4fs_ino_from_fuse(const struct fuse4fs *ff,
+					 ext2_ino_t *inop, fuse_ino_t fino)
 {
-	if (fino == FUSE_ROOT_ID)
+	if (ff->translate_inums && fino == FUSE_ROOT_ID)
 		*inop = EXT2_ROOT_INO;
 	else
 		*inop = fino;
 }
 
-static inline void fuse4fs_ino_to_fuse(fuse_ino_t *finop, ext2_ino_t ino)
+static inline void fuse4fs_ino_to_fuse(const struct fuse4fs *ff,
+				       fuse_ino_t *finop, ext2_ino_t ino)
 {
-	if (ino == EXT2_ROOT_INO)
+	if (ff->translate_inums && ino == EXT2_ROOT_INO)
 		*finop = FUSE_ROOT_ID;
 	else
 		*finop = ino;
@@ -371,7 +374,7 @@ static inline void fuse4fs_ino_to_fuse(fuse_ino_t *finop, ext2_ino_t ino)
 			fuse_reply_err((req), EIO); \
 			return; \
 		} \
-		fuse4fs_ino_from_fuse(ext2_inop, fuse_ino); \
+		fuse4fs_ino_from_fuse(fuse4fs_get(req), ext2_inop, fuse_ino); \
 	} while (0)
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
@@ -2124,7 +2127,7 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 			statbuf->st_rdev = inodep->i_block[1];
 	}
 
-	fuse4fs_ino_to_fuse(&entry->ino, ino);
+	fuse4fs_ino_to_fuse(ff, &entry->ino, ino);
 	entry->generation = inodep->i_generation;
 	entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
 	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
@@ -7793,6 +7796,20 @@ static void fuse4fs_compute_libfuse_args(struct fuse4fs *ff,
  "-oallow_other,default_permissions,suid,dev");
 	}
 
+	if (fuse4fs_can_iomap(ff)) {
+		/*
+		 * The root_nodeid mount option was added when iomap support
+		 * was added to fuse.  This enables us to control the root
+		 * nodeid in the kernel, which enables a 1:1 translation of
+		 * ext2 to kernel inumbers.
+		 */
+		snprintf(extra_args, BUFSIZ, "-oroot_nodeid=%d",
+			 EXT2_ROOT_INO);
+		fuse_opt_add_arg(args, extra_args);
+		ff->translate_inums = 0;
+	}
+
+
 	if (ff->debug) {
 		int	i;
 
@@ -7998,6 +8015,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_LOOPDEV
 		.loop_fd = -1,
 #endif
+		.translate_inums = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;


