Return-Path: <linux-fsdevel+bounces-58130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469DBB29C6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4E47AE9B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE243019A5;
	Mon, 18 Aug 2025 08:37:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190292798E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506267; cv=none; b=RAJShU/FzDryGswnJckf+BHjs1IGeyAj6Olm7PN/D3GIlR85lb3HZNnIDjCf2mgwxZ1CfTSDGZIJik6997k68ghtRABIX0cS+Ev5+0BGy0LXwIX8rld2y6ix1SmSarwc8vNm613equQhBfGOkvnUGyGWDr2rCI2onm9fPixUpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506267; c=relaxed/simple;
	bh=CMSIv6MLrH+JmMqbkwSd9Tcbf7ROBtXWyLxc8LBc2U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLYXf4D9E3uMf7SLRw5JozTYvwhcNPdJhw1ol/Y3U2G5KTFSHkDrO9D/6FO1/F8yd8TsSOHJw14IlS4Fj+MT2lIJxQeI90lknmxM03r83PyyZpOq3iSaHTdN3skPN/mKe6AL7CSknSC2GFohonW24pek80MCLzOAdFQVwGWmhtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.35])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fb8052d2;
	Mon, 18 Aug 2025 16:32:25 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: joannelkoong@gmail.com
Cc: brauner@kernel.org,
	djwong@kernel.org,
	kernel-team@meta.com,
	linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu
Subject: Re: [PATCH v3 1/2] fuse: reflect cached blocksize if blocksize was changed
Date: Mon, 18 Aug 2025 16:32:24 +0800
Message-ID: <20250818083224.229-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815182539.556868-2-joannelkoong@gmail.com>
References: <20250815182539.556868-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98bc4eeabf03a2kunmcf685d3f36042d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHhoeVkJCTh5PGUhCShkYGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhOWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

On Fri, 15 Aug 2025 11:25:38 Joanne Koong wrote:
>diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>index ec248d13c8bf..1647eb7ca6fa 100644
>--- a/fs/fuse/fuse_i.h
>+++ b/fs/fuse/fuse_i.h
>@@ -210,6 +210,12 @@ struct fuse_inode {
>        /** Reference to backing file in passthrough mode */
>        struct fuse_backing *fb;
> #endif
>+
>+       /*
>+        * The underlying inode->i_blkbits value will not be modified,
>+        * so preserve the blocksize specified by the server.
>+        */
>+       u8 cached_i_blkbits;
> };

Does the `cached_i_blkbits` member also need to be initialized in the
`fuse_alloc_inode` function like `orig_ino`? 

And I am also confused, why does `orig_ino` need to be initialized in
`fuse_alloc_inode`, but the `orig_i_mode` member does not need it?

Thanks
Chunsheng Luo

