Return-Path: <linux-fsdevel+bounces-66130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED567C17D9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545361A28330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F25E2D839E;
	Wed, 29 Oct 2025 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF2pxkxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984135972;
	Wed, 29 Oct 2025 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700701; cv=none; b=j9F7p0/myWUTbLt/KR4UnssX4BGi+Wvs9dgbhdTujT0RWKD6Xf6UAbJPo3B7aWEK1mEmuvdfhsX1UMfGQNa+WEoXrwHM4M0J11WXOpYF94iEqpda+Z6FeUWVHN/aByOJUZeRdJsC5Izl7QnzY0P34a88Uy9kXuQ3giqk6ZjNPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700701; c=relaxed/simple;
	bh=cTU9FORMQnH6gvy1t7IJWE6cyfeaqdKd939TxgBeHkU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xtonkx0uU1zuGMZU8a+p03yiUjTAI8DLfkOCNfrl+AQDJbOYUC7CAmLvlHcqiJaHDjSqS9kvmNoRO0+iEpbVym1SvlFLOY1FkIqVNtp3Xanx/6MSNWEIDdmAsOc8DBgpo3MyRsVDEEDDfz06I2/Mz92ID3tJ/2DKoW9GgRwcA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rF2pxkxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D0FC4CEE7;
	Wed, 29 Oct 2025 01:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700701;
	bh=cTU9FORMQnH6gvy1t7IJWE6cyfeaqdKd939TxgBeHkU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rF2pxkxLnpV4WtWeKZy5W/rsRnHFf9raOoMrJsNTcFo6EOwdSGuCQ7r6u6900jx3c
	 owju2b58uJsItgubGdkSSdvmxTwKXWFYbDnD9up+0rtAiDAIH6fTyDxfFBSioYd74B
	 CttHizQz9Oc5SMUzN1PzprvEfmPWnhoXlNr3E59tS+nvi925E7HgB0ZDBlNTWaMTe6
	 zl390NEKdUxBVqIF60TCLr1NCnhsGWWomrxj2c0g8vRupaT0+p3pjPqz4GvHuQqbvD
	 DE3xNfapbHMJ8YZo84FMoVMeKkyEAQPuVA2ofQpxdOFabGMfK4OZo7689LZEuxofPF
	 cIMmpVtP7X2aA==
Date: Tue, 28 Oct 2025 18:18:20 -0700
Subject: [PATCH 5/6] fuse2fs: increase inode cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818853.1431012.6002866162788023254.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818736.1431012.5858175697736904225.stgit@frogsfrogsfrogs>
References: <176169818736.1431012.5858175697736904225.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |    4 ++++
 misc/fuse2fs.c    |    4 ++++
 2 files changed, 8 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index e000fc4195ab59..503cc43c155979 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1687,6 +1687,10 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	err = ext2fs_create_inode_cache(ff->fs, 1024);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fb31183d4cd895..3c9fd2489bb94b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1515,6 +1515,10 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
 
+	err = ext2fs_create_inode_cache(ff->fs, 1024);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;


