Return-Path: <linux-fsdevel+bounces-42533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B475CA42EF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D206C3A7942
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D0204C2A;
	Mon, 24 Feb 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HyhaoUfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F31DC99C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432059; cv=none; b=uWDmwYJea/J58JcCQMJ/quIo3qFge7mQpWtdI3T4KwAF8ZA5hjTXJ1MsbKwqez0sMTLZySQbBIVWB2GSBGG1CdeEvq027SYq2BG8jQcTziMqzYqoMpbj2e6ofLnsycOgdAIC1UVa8E/fCZ5OrHWDpdDxSJT/5JOZ2YBbMCISNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432059; c=relaxed/simple;
	bh=MXpyfipa9ZOWs0nG+khW69rGRkx3F6l7QUpOX9mEDS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RueYfCU6QejbengWOjZvII35KdjEDvLLEeyxJJu/PnUniaGqs3S626lzRjAfhOA7GNpZxJXJbmbJxhpM6zxTaj6G/eWz1BK/K71mQHSLsfr0jBZzzbPrOQcMrhhiqlXH4Cjvj+sZG132YU/oSl7fcQDs9ruIjXojDcImM5mz050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HyhaoUfR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+1rnL5aSvb2B+IFEwMZXLhjXwKraJlB9LoT01doRm0Q=; b=HyhaoUfRQZOrnZqr8IuxJa/wSI
	3vbgsc6nC8c/obwgRjczLrvpmUnzSnbYd5Lfg9RxJZp7ywJ28obuFzeQV/yDeHkNUVLONcySvjkq6
	8uzeWJkcXY3rAKPbfaOOraCoNYCncwCh2JvhFpvyAvGbN6CCA4EB6Ss0T58+gRF8KWXUheDnVzZK+
	nJjIRaBwuN3RBC3ceCU25eJEseunPB10KZcqNfUS7K+npvBp/3SmL063l5z0buJzbbCALQT3MO38e
	LEfgUMtTQ/8Uy4fTY8nUYBvjsrlhCjwG5f+zdeoSsGeynUR8LcwCYB1W22YzkUj3plzvTlMC37cix
	2h/gZHDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsj-00000007Mzn-49vB;
	Mon, 24 Feb 2025 21:20:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 21/21] afs dynroot: use DCACHE_DONTCACHE
Date: Mon, 24 Feb 2025 21:20:51 +0000
Message-ID: <20250224212051.1756517-21-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/afs/dynroot.c | 1 -
 fs/afs/super.c   | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d8bf52f77d93..2fad2987a6dc 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -211,7 +211,6 @@ const struct inode_operations afs_dynroot_inode_operations = {
 };
 
 const struct dentry_operations afs_dynroot_dentry_operations = {
-	.d_delete	= always_delete_dentry,
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,
 };
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 13d0414a1ddb..b48f524c1cb6 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -488,6 +488,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 
 	if (as->dyn_root) {
 		set_default_d_op(sb, &afs_dynroot_dentry_operations);
+		sb->s_d_flags |= DCACHE_DONTCACHE;
 		ret = afs_dynroot_populate(sb);
 		if (ret < 0)
 			goto error;
-- 
2.39.5


