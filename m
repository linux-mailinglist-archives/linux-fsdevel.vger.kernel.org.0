Return-Path: <linux-fsdevel+bounces-61500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D71EDB5893B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C53544E2666
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC41DE3C0;
	Tue, 16 Sep 2025 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/XswTmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231991A9B58;
	Tue, 16 Sep 2025 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982370; cv=none; b=QnzLgOX+ohKgz1l651vfZMxYRBKsuCK1L8sHUKebbgzjrvWMV4EM3gzEGLuLLMvd+cTK/PLkN+WIl3YjlSoeQwG02Wj0Ae8P7j/upRgxJFJzWcbbblfPQDuQUM1pS0FWoSHWMs9XoM6owd5hAKNvJlnYvDzE/Jl07WRo62VV7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982370; c=relaxed/simple;
	bh=2fE97xvSQaNBbffbIV4Cd+y4RkxcMg4bgnzvv1Qtq1M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRqmbi75AONchtOhptjFgdeci+cdamJNml2Whj0WeO6RISipfvGpmKH0veTSM18hsnG7aKwXuykwnwFoi8AuvndAFhC+Lt6xY1uNRIsMHhqkBUkGr8FketGs5SVlWyAn3HPFrzlEdDQqqDvqz1JFTaLf6Y0SKIFcoh5ur+wtveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/XswTmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC6DC4CEF1;
	Tue, 16 Sep 2025 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982369;
	bh=2fE97xvSQaNBbffbIV4Cd+y4RkxcMg4bgnzvv1Qtq1M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=X/XswTmhz9PMhy0rKKCUa+gW/nme4kUhVwarV97dP71NxRpsJK2AbxTJBVp6eMQFT
	 0MuntXuazvFcWQS1vYWY7vTfOmVuXVUh7bQSLQK/pycB3oSsmr1UL1a3WFSIU6AYEX
	 wh+h1lFTx3UDhnZch6ecs0OphGLM85Y4D+KFmbAWopZelDmgohEES2MMg6TKivDgzz
	 7ZPmdtY9TF0hlxRLclr+u4+GvTnCEgzFsBTIQZdQbxyUzXLWFJHvi2YY2FH/SSNWW7
	 QCRj1N8GrHlk4rhC9LdnFWp5ydrZAJYvmnx/E6Rl1vGmDKw98H2PTyFrn6Bwb9gUY9
	 frx3J0ketf5Ew==
Date: Mon, 15 Sep 2025 17:26:09 -0700
Subject: [PATCH 8/8] fuse: enable FUSE_SYNCFS for all fuseblk servers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150199.381990.15729961810179681221.stgit@frogsfrogsfrogs>
In-Reply-To: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Turn on syncfs for all fuseblk servers so that the ones in the know can
flush cached intermediate data and logs to disk.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/inode.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 55db991bb6b8c1..869d8a87bfb628 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1824,6 +1824,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		    !sb_set_blocksize(sb, PAGE_SIZE))
 			goto err;
 #endif
+		fc->sync_fs = 1;
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;


