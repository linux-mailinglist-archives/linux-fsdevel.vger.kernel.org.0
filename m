Return-Path: <linux-fsdevel+bounces-66036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF21C17AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D1FC4F0778
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594982D6E52;
	Wed, 29 Oct 2025 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkGfBqVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181D258ED8;
	Wed, 29 Oct 2025 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699229; cv=none; b=fJVTpKzG9L5R8MDxsz3k1oVAyiZy27eozduIwmUNXDYsWHVVVveDqjJxJ18rt0G4Wxf5Cm0WbTP4fUw1IePjG3yFoO+Xt3t1CcQ/CVeIbLqxnQ21CsBLdWNvwYmgTjMbDiNuGLOvXbnnJnI+cF+ai0bNgKFRl2vuDDuMwUiEFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699229; c=relaxed/simple;
	bh=7UyKwmQWCYOx4e5AlpdWMfU2fJHRvGky24j+s8UyFBQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2jLZ032F85bXoYhh+JUCylyXX8dJfKZGLvs/hLSFephRoptIGMb3atdZHRb0ki1FzgkxQdwjiA6sxlAzasdI05KTRRBeD0/HHfYeDlHHB5sRaggxWALraVgGOOJKyj30zLBJf4r8Xz98PpBNhT+hQ5CtKO25r1A48C2yp9L7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkGfBqVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8082DC4CEE7;
	Wed, 29 Oct 2025 00:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699229;
	bh=7UyKwmQWCYOx4e5AlpdWMfU2fJHRvGky24j+s8UyFBQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PkGfBqVq+7EGXPbbaGIwY3bNmUuAjcTBHhRIWdwsTlqaviKCDmrZQoUYnb66bfHCf
	 IRLKaDfCA0GxknyFGafDhPjWShQapGytRLAW4faqW8zlk+4MLLaPSvffQAcZ0bYNN6
	 8fcvnN2QvYN4AvVr8qNVksCS6qc5YuUQnWOCGRuKQgf9ze9ZQeZmN9WL1+dQkVzhoT
	 qM+Rl8GX6Do+wI92XokVwiJPHR+ESi7c3ycd4+sxPP29rgkJZsA7hAAlvn9kunBs1U
	 fG+YK2l4bw4NNaRWBFGnpwrLF19ZPg+Ole5y44F0gAoNS3h2tu8E31pazykyoeDaAh
	 +zVeZWbY70UiA==
Date: Tue, 28 Oct 2025 17:53:49 -0700
Subject: [PATCH 3/3] fuse: allow setting of root nodeid
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811312.1426070.16457653864288378906.stgit@frogsfrogsfrogs>
In-Reply-To: <176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs>
References: <176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs>
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
index 4157dba6cba27c..b599e467146d33 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -626,6 +626,7 @@ struct fuse_fs_context {
 	int fd;
 	struct file *file;
 	unsigned int rootmode;
+	u64 root_nodeid;
 	kuid_t user_id;
 	kgid_t group_id;
 	bool is_bdev:1;
@@ -639,6 +640,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool root_nodeid_present:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5f0c7032e691a6..955c1b23b1f9cb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -802,6 +802,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ROOT_NODEID,
 	OPT_ERR
 };
 
@@ -816,6 +817,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u64	("root_nodeid",		OPT_ROOT_NODEID),
 	{}
 };
 
@@ -911,6 +913,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
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
@@ -946,6 +953,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 			seq_printf(m, ",max_read=%u", fc->max_read);
 		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
+		if (fc->root_nodeid && fc->root_nodeid != FUSE_ROOT_ID)
+			seq_printf(m, ",root_nodeid=%llu", fc->root_nodeid);
 	}
 #ifdef CONFIG_FUSE_DAX
 	if (fc->dax_mode == FUSE_DAX_ALWAYS)
@@ -2002,6 +2011,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_flags |= SB_POSIXACL;
 
 	fc->default_permissions = ctx->default_permissions;
+	if (ctx->root_nodeid_present)
+		fc->root_nodeid = ctx->root_nodeid;
 	fc->allow_other = ctx->allow_other;
 	fc->user_id = ctx->user_id;
 	fc->group_id = ctx->group_id;


