Return-Path: <linux-fsdevel+bounces-58459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76DEB2E9D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C135E40C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A81E5B70;
	Thu, 21 Aug 2025 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awkp/cwI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68508C2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737832; cv=none; b=F6yV9xw4FMYkhgItiqb3P4h5h/4+f8in/PpNQqGWL+FOSYnIFpYjUUbPVpmOO9oRsd1x11YYNUNvAtZor87gwVnR52z0YI6CrdzG2qK7LTeGC5fMNXXMaVvJxulsrQGBYwZVeALkBfzZ9mwT18EXJjxZkCdogLGJtzmPXn14DfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737832; c=relaxed/simple;
	bh=EAzIxjwVGEHOvzIHp8XzmsSuRRUlB4BSX0qLH+e6k4o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bybcCUZ5CT2DK3MICc/fyIqUeBoGEIvCkABB/5TGOus1lqwuA/CgDL/1Wj+qQv57M2/6QVt35dU8rM544nvGYzN2Vys5hyf/BaZvIwMKDMhMcl9mM3lU69BuJNX/RvvI5tDrHkuo2WKrZNKiXt18AjlhFDApWofvAJJCGamaI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awkp/cwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3F7C4CEE7;
	Thu, 21 Aug 2025 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737832;
	bh=EAzIxjwVGEHOvzIHp8XzmsSuRRUlB4BSX0qLH+e6k4o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=awkp/cwIuVD/KzkpmQ8J/qI0TGmHi+rM93CLfYoVOYZsj1yGzVdhtVDyWPdtlihJQ
	 lsY4dT/rYuneKsdcvBIZYJzkCXG/9lwwnX18D8IjtFApNJ6ZWFPatCq38FQcZtPqyB
	 UXb8HvehzZI1tOxDZFIhIF/aTfNfv52DejKWJPtySVbZQ89r/WeR51NtXeTnU2zFUH
	 pLe99Hi7PcZgipFcjP3/9bo6yEIpkKDoJKyztg231WMugVzyfr5bTeeb0hiBx/St89
	 8VM4XMW9Mp0Fq9NLe9ZDXLlYZkhwpNuCnwb9fM5pek1G1rWXspa9IGfUXWarbwWfFQ
	 EqiYrL/9pfrtg==
Date: Wed, 20 Aug 2025 17:57:11 -0700
Subject: [PATCH 18/23] fuse: allow setting of root nodeid
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709503.17510.4666526707195481622.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Provide a new mount option so that fuse servers can actually set the
root nodeid.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    2 ++
 fs/fuse/inode.c  |   11 +++++++++++
 2 files changed, 13 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 66cf8dcf9216e7..a81138da1e55f6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -601,6 +601,7 @@ struct fuse_fs_context {
 	int fd;
 	struct file *file;
 	unsigned int rootmode;
+	u64 root_nodeid;
 	kuid_t user_id;
 	kgid_t group_id;
 	bool is_bdev:1;
@@ -614,6 +615,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool root_nodeid_present:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f2d519c0f737e6..18dc9492d19174 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -785,6 +785,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ROOT_NODEID,
 	OPT_ERR
 };
 
@@ -799,6 +800,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u64	("root_nodeid",		OPT_ROOT_NODEID),
 	{}
 };
 
@@ -894,6 +896,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
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
@@ -929,6 +936,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 			seq_printf(m, ",max_read=%u", fc->max_read);
 		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
+		if (fc->root_nodeid && fc->root_nodeid != FUSE_ROOT_ID)
+			seq_printf(m, ",root_nodeid=%llu", fc->root_nodeid);
 	}
 #ifdef CONFIG_FUSE_DAX
 	if (fc->dax_mode == FUSE_DAX_ALWAYS)
@@ -1879,6 +1888,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_flags |= SB_POSIXACL;
 
 	fc->default_permissions = ctx->default_permissions;
+	if (ctx->root_nodeid_present)
+		fc->root_nodeid = ctx->root_nodeid;
 	fc->allow_other = ctx->allow_other;
 	fc->user_id = ctx->user_id;
 	fc->group_id = ctx->group_id;


