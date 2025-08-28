Return-Path: <linux-fsdevel+bounces-59452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20145B38F78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 02:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C627A1C22656
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5141DDF7;
	Thu, 28 Aug 2025 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k7YCxuoN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C487123CB;
	Thu, 28 Aug 2025 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339279; cv=none; b=RN2w/y+j4nIMgVcMMOcBsms5xxSdOyNX5T/n4VOcVONRG3OeF9VZHMzhfkBC3i70XoIHSqLjArUgUbu2v3EyrErqJ3UjQzqGQHDZv2QTb70hbXAT4/gaTSopi/7CBoqLI9g4HQVyL7AfxroYh8BhgEF/tpIEuD9h8ChrC/UD5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339279; c=relaxed/simple;
	bh=MZuvWIXyZs8HE4XqfKH5BwoOr3wG7uac9NqYESy7e6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKG80uB1DSF49DtJ9bkP65TAwCyQybMRdAiensAO636AbvelgWNVApwnbsDL6lzEcKP58MwLPJC52nbLRrr3ZSCatOnITktB4o92sfF1XxG1yIx7Q2/RkN7l21PA5tVZfijoHzmeHuJBTq8CL9dsQOptBNaYVDnXVNV79fgHbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k7YCxuoN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EQCDyLwiOEobu8Wv0JiCXwwBA8SeJQj4HkdYwqakD3w=; b=k7YCxuoNsi+CmaLfnSw5e8ou0R
	CG21gvN+8txPQWDogcPu832KPjhXC/4gZfjoLd3XzZHzQ0XwgQVCfsiQKhzCSd6aVXqltu1xlbGOD
	HziYNEXGpbYjzDCThJl6dS3u4u7Ok3/fMnHtiIqX9RSPzKOIYH9Zqatanf8cYQ8Q77SL3wSWScKnO
	I+xY5osGnepg1YXCW2/HzTRSvzm54JTVnws3zHOTQ7vkjPkN1k9+Rus6eIktdsBp+6yE0XxiNMX1h
	Tv8PHOe5We6iG4iuVA0tnACs6F6g/FnvQYINud9do90MbyfClb6m+fyS9ANMm1Wn9YjQasoRBPYPb
	F7HZea5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urQ4n-0000000CeHh-3OB4;
	Thu, 28 Aug 2025 00:01:13 +0000
Date: Thu, 28 Aug 2025 01:01:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] do_nfs4_mount(): switch to vfs_parse_fs_string()
Message-ID: <20250828000113.GB3011378@ZenIV>
References: <20250828000001.GY39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828000001.GY39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs4super.c | 44 +++++++++++---------------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index b29a26923ce0..5ec9c83f1ef0 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -149,21 +149,9 @@ static int do_nfs4_mount(struct nfs_server *server,
 	struct fs_context *root_fc;
 	struct vfsmount *root_mnt;
 	struct dentry *dentry;
-	size_t len;
+	char *source;
 	int ret;
 
-	struct fs_parameter param = {
-		.key	= "source",
-		.type	= fs_value_is_string,
-		.dirfd	= -1,
-	};
-
-	struct fs_parameter param_fsc = {
-		.key	= "fsc",
-		.type	= fs_value_is_string,
-		.dirfd	= -1,
-	};
-
 	if (IS_ERR(server))
 		return PTR_ERR(server);
 
@@ -181,15 +169,7 @@ static int do_nfs4_mount(struct nfs_server *server,
 	root_ctx->server = server;
 
 	if (ctx->fscache_uniq) {
-		len = strlen(ctx->fscache_uniq);
-		param_fsc.size = len;
-		param_fsc.string = kmemdup_nul(ctx->fscache_uniq, len, GFP_KERNEL);
-		if (param_fsc.string == NULL) {
-			put_fs_context(root_fc);
-			return -ENOMEM;
-		}
-		ret = vfs_parse_fs_param(root_fc, &param_fsc);
-		kfree(param_fsc.string);
+		ret = vfs_parse_fs_string(root_fc, "fsc", ctx->fscache_uniq);
 		if (ret < 0) {
 			put_fs_context(root_fc);
 			return ret;
@@ -197,20 +177,18 @@ static int do_nfs4_mount(struct nfs_server *server,
 	}
 	/* We leave export_path unset as it's not used to find the root. */
 
-	len = strlen(hostname) + 5;
-	param.string = kmalloc(len, GFP_KERNEL);
-	if (param.string == NULL) {
-		put_fs_context(root_fc);
-		return -ENOMEM;
-	}
-
 	/* Does hostname needs to be enclosed in brackets? */
 	if (strchr(hostname, ':'))
-		param.size = snprintf(param.string, len, "[%s]:/", hostname);
+		source = kasprintf(GFP_KERNEL, "[%s]:/", hostname);
 	else
-		param.size = snprintf(param.string, len, "%s:/", hostname);
-	ret = vfs_parse_fs_param(root_fc, &param);
-	kfree(param.string);
+		source = kasprintf(GFP_KERNEL, "%s:/", hostname);
+
+	if (!source) {
+		put_fs_context(root_fc);
+		return -ENOMEM;
+	}
+	ret = vfs_parse_fs_string(root_fc, "source", source);
+	kfree(source);
 	if (ret < 0) {
 		put_fs_context(root_fc);
 		return ret;
-- 
2.47.2


