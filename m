Return-Path: <linux-fsdevel+bounces-78083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBbyGjPgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:18:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B09B17F209
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B9A8302E76D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578D437F731;
	Mon, 23 Feb 2026 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKg/8tzC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89172749CF;
	Mon, 23 Feb 2026 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888684; cv=none; b=eu7RtG2lRT47VQ51Lbl8z8RzvIelfz4HqOiP3VltLPJitxt2qRYFLM8WEuE4YybzsU0v/z1ld13ZT8jaQuWtoIbpa5P4sLjGY5oQE4mrBvjzdXddve651tek/u1C41sISs1aGa4NAxd9ZSiPpjtUW+Wk69iQmDF1d6iQ0y6/vTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888684; c=relaxed/simple;
	bh=gEIB5XUaDwKx+tWKs1WOsFgdcT409WwvfZ90jmD6VPw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mm+e4jjJNy1LyN02WAC0ZY2QVfBIiL2jdbkSYXNfqP1qs6Wy97VGWY1ZNvwqjq7ad8ma+yvyBMEa98s4hnaYg6OdaIx2PoCLFKT7Koww4wWpHTXpXB4LIbeiyXrJzpc2Dfa8yNKo84xZt0ejkQPTIbhK9zuno80elRJiwof301g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKg/8tzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B95C116C6;
	Mon, 23 Feb 2026 23:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888684;
	bh=gEIB5XUaDwKx+tWKs1WOsFgdcT409WwvfZ90jmD6VPw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OKg/8tzCDgbPmTcMKIYUM2TXN1kzWH8GtkjoxHiQiYV19lgUsfVp15X9qIozoX3mt
	 9v8/tSoQRV+TiBfgnCa80XMFbKAQb3eaZFkw4ePzCQ6iR3jJJuI4A27OPUWJqBHaQS
	 k0Bz+4Y9lmk6uX0C3xKzsVNtGvAcUwdozC2nvnwIWP6lbzAdSMaFLXWd7iPAycY0qh
	 VTB9OKOZmCm+xTv84FRdU6EAO499ZiuyN7WFK9mDAvznDkL5IdLc92joffUMiZukT8
	 am2wKvK6VB9IbhJZii73zRKkZaBv1asGwvg5GphMGREs0yW4g8MLcHViTxTmhS98jt
	 LNEVVY46LC7Tg==
Date: Mon, 23 Feb 2026 15:18:04 -0800
Subject: [PATCH 3/3] fuse: allow setting of root nodeid
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735245.3936993.9021145342853834207.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735166.3936993.12658858435281080344.stgit@frogsfrogsfrogs>
References: <177188735166.3936993.12658858435281080344.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78083-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1B09B17F209
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Provide a new mount option so that fuse servers can actually set the
root nodeid.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    2 ++
 fs/fuse/inode.c  |   11 +++++++++++
 2 files changed, 13 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fc0e352e2e8f9b..884f29533d0206 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -636,6 +636,7 @@ struct fuse_fs_context {
 	int fd;
 	struct file *file;
 	unsigned int rootmode;
+	u64 root_nodeid;
 	kuid_t user_id;
 	kgid_t group_id;
 	bool is_bdev:1;
@@ -649,6 +650,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool root_nodeid_present:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a679bce3b178c..9185b3b922559a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -813,6 +813,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ROOT_NODEID,
 	OPT_ERR
 };
 
@@ -827,6 +828,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u64	("root_nodeid",		OPT_ROOT_NODEID),
 	{}
 };
 
@@ -922,6 +924,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_ROOT_NODEID:
+		ctx->root_nodeid = result.uint_64;
+		ctx->root_nodeid_present = true;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -957,6 +964,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 			seq_printf(m, ",max_read=%u", fc->max_read);
 		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
+		if (fc->root_nodeid && fc->root_nodeid != FUSE_ROOT_ID)
+			seq_printf(m, ",root_nodeid=%llu", fc->root_nodeid);
 	}
 #ifdef CONFIG_FUSE_DAX
 	if (fc->dax_mode == FUSE_DAX_ALWAYS)
@@ -2005,6 +2014,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_flags |= SB_POSIXACL;
 
 	fc->default_permissions = ctx->default_permissions;
+	if (ctx->root_nodeid_present)
+		fc->root_nodeid = ctx->root_nodeid;
 	fc->allow_other = ctx->allow_other;
 	fc->user_id = ctx->user_id;
 	fc->group_id = ctx->group_id;


