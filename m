Return-Path: <linux-fsdevel+bounces-55387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4725B0987C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889361C465BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15E247284;
	Thu, 17 Jul 2025 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN2G1ymn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2A23FC4C;
	Thu, 17 Jul 2025 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795924; cv=none; b=RSYa7wFx0aeI0QZnPeoFT3iGp2+KwC8r7LxlEeIzEirtTmY/pqScugplqWDfy1UPygeaCjWvSU4KIbhDqR3qgGwaCpFgQ++D/kq+0NgXcNGFOKHMus42puNHhbeQ6CfB1a7lTlDMlCckp/NtCHqAMJQ1vpSf3lai139s7Ocluqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795924; c=relaxed/simple;
	bh=iwLkr4oHges3cdhq/4LZpn9dEqVs5lsdu0XWOG1DYco=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q91/+pnSpRsqUuzHS/hXBSVVSB05RzQmkhDbjzIXQKeK0oh9wFEOaMVS/hQ8zNbbjx/lXPbnSiRy1YGsOQfCcRuVv85tJFTtobS1sAOPYMDte+1c3l1MDrJ+xKXUrrkv0p59iE+q0qtjFpEZkT4bsxGBUsD0r/O6k7VRDivi88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN2G1ymn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75957C4CEE3;
	Thu, 17 Jul 2025 23:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795923;
	bh=iwLkr4oHges3cdhq/4LZpn9dEqVs5lsdu0XWOG1DYco=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PN2G1ymn1dv22oBkYVcLxi4F6iJsKrLaoVSR+F5q+qR2R3yd7RytO78mrNJQVVN9d
	 lAtCXbKSLBU96TXmoPHo3JDUHVMg07enzQhpoMioLOaiTarleHwu6Y1sAvbUgRUEjE
	 NIgrepcc0qqTRW9KY+x0LiRnOT2DfW4Zjr0Z11H2/BXNCNrYLewMWn7RIRgoXVxIZe
	 /PdMsga+o9p2trieWdJY18bLWd8J5rFzuq8DGyG1GG9X4VcAfno2nQRmMADmlQfvGI
	 xo6xHMetfbDQ4Juo7u7czNibxd7J6YilEYzwxXAzMMwoJVEIEz3WhjfbezocYv/7Lb
	 Cz6AW7UhyCFKw==
Date: Thu, 17 Jul 2025 16:45:23 -0700
Subject: [PATCH 1/1] fuse2fs: enable caching of iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461563.716336.4159682025419490591.stgit@frogsfrogsfrogs>
In-Reply-To: <175279461545.716336.14157351878342981972.stgit@frogsfrogsfrogs>
References: <175279461545.716336.14157351878342981972.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Cache the iomaps we generate in the kernel for better performance.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index d0478af036a25e..f863042a4db074 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5505,6 +5505,7 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
 	struct ext2_inode_large inode;
 	ext2_filsys fs;
 	errcode_t err;
@@ -5560,6 +5561,24 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		}
 	}
 
+	/*
+	 * Cache the mapping in the kernel so that we can reuse them for
+	 * subsequent IO.  Note that we have to return NULL mappings to the
+	 * kernel to prompt it to re-try the cache.
+	 */
+	write_iomap->type = FUSE_IOMAP_TYPE_NULL;
+	err = fuse_lowlevel_notify_iomap_upsert(se, nodeid, attr_ino,
+						read_iomap, write_iomap);
+	if (err) {
+		ret = translate_error(fs, attr_ino, err);
+		goto out_unlock;
+	}
+
+	/* Null out the read mapping to encourage a retry. */
+	read_iomap->type = FUSE_IOMAP_TYPE_NULL;
+	read_iomap->dev = FUSE_IOMAP_DEV_NULL;
+	read_iomap->addr = FUSE_IOMAP_NULL_ADDR;
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;


