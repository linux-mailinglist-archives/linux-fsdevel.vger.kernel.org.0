Return-Path: <linux-fsdevel+bounces-58564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C653B2EAA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 029EA4E45C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D20218827;
	Thu, 21 Aug 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0AA1opt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDD1A9FAD;
	Thu, 21 Aug 2025 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739475; cv=none; b=Li6TLhDsInbzBuM0C8Nk+qa4v+OqKUPmRkbxrd+pXAhdFO70vpFiyfgq5LQcWRz66mCIUu9BS46EDs9+Fss6xiZ6en5maYX5LzFfiey3wShtpgXS8xuIOy4RKha6S8Xmfyirhn0PBj+SlhZTlGVcdXXboM9XIAb6X31T0NEDhg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739475; c=relaxed/simple;
	bh=qfW4Kowl6Di2mWWZ+BEr4xq74a5o094guJIGXEOg1X8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpXWY7R8Ki+3+4pQPJRsGlYkmqEwV32xkLp5/6yyXqgxj+OkKVS7qtcHvHfzH/5pFDlBgFmTdh38oC9SK15h6QpZP/d1UwcXr8hMSZI6erc9QRawGERmRYyEDOiXWyZY/3y+AtqZBpKMWqFEJd2cumYxYpcIAQGJj3p6eomOz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0AA1opt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B26C4CEE7;
	Thu, 21 Aug 2025 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739474;
	bh=qfW4Kowl6Di2mWWZ+BEr4xq74a5o094guJIGXEOg1X8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=o0AA1opt4Bm7HDV0G/wt0LNWaaXSiq/mTWgjpWreaC9NGfc1mnynmkQDSO2itZzEy
	 3G4SpLrUupJEvzwSravj9a+JgLScwgGQFC3iPEnyCDVOGX+g76v23xbAB7oLiqQbk/
	 6zEx99bQnjUOrGiC0m6gHcQ0+oiIKgEyXqEAdv8SNZpX/eOSjTosL0Fa/hyjPo0mI6
	 JJX8TgF/Q0QXJDF7lMAOxc50qmahd3UetiVwPdhjo/fY4pRrtdAP2IHiRUUGJhgO3+
	 zQ37vkdCzceDebF9N9Eq6Mqf/n4/C0Y7VP8einAsDFGEpIaY/R4bQXbnTLW2IEaeFR
	 OAimYw/TCJ5LA==
Date: Wed, 20 Aug 2025 18:24:34 -0700
Subject: [PATCH 5/6] fuse2fs: increase inode cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714775.23206.4282203876180299148.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714661.23206.877359205706511372.stgit@frogsfrogsfrogs>
References: <175573714661.23206.877359205706511372.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Increase the internal inode cache size.  Does this improve performance
any?

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    4 ++++
 misc/fuse4fs.c |    4 ++++
 2 files changed, 8 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index d3ac5f7b6627cd..0c310443b1504b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1141,6 +1141,10 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 		return err;
 	}
 
+	err = ext2fs_create_inode_cache(ff->fs, 1024);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 85d73a9088d237..186a3188acfa59 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -1302,6 +1302,10 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	err = ext2fs_create_inode_cache(ff->fs, 1024);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;


