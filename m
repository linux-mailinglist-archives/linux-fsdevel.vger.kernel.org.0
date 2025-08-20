Return-Path: <linux-fsdevel+bounces-58357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCEFB2D204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 04:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D906E1C42639
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 02:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9FD27702A;
	Wed, 20 Aug 2025 02:38:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D76A17B506
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657506; cv=none; b=hMq/sClHeG8gdsjF2WWzYj/d+o9leedzZyMdCl4FIKYmdycpwvUV7EcMe4vTltbEzQrl9uo5rb2AQP0DKIBNJT0V/kdRMKf1tauuQlZavG51vvhRnZFfWY+nj6u+4CxXczuPtUvM2KJPmRMSRoTdGND5N8e+b1mz9zsHBBurwhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657506; c=relaxed/simple;
	bh=RlKLSOD6NL2OMhwy9DnOwhiBbUx9D5l58hN4u0XHlEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL29yOtnK524CLCKP/q35XwGfLTgqoRXH1GkexQx9M1e2B8Al5IRzJJ3rpy6P0RU/Xenjmn9SxKUWkYEu3Poi3quRMuCyqHYmIa/Q1Dswd+T5FzBiAEK+1jK1PnXZDbcpM79ojVf4O4C3I583n7guZLTcqQCNHCkfqIN4zwhyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ff2a3738;
	Wed, 20 Aug 2025 10:38:18 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: brauner@kernel.org,
	djwong@kernel.org,
	joannelkoong@gmail.com,
	kernel-team@meta.com,
	linux-fsdevel@vger.kernel.org,
	luochunsheng@ustc.edu
Subject: Re: [PATCH v3 1/2] fuse: reflect cached blocksize if blocksize was changed
Date: Wed, 20 Aug 2025 10:38:17 +0800
Message-ID: <20250820023817.1085-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJfpegvXHBTvRHoC3u3iDRzs5LpMPQq0+L6cWdGye545qv15FQ@mail.gmail.com>
References: <CAJfpegvXHBTvRHoC3u3iDRzs5LpMPQq0+L6cWdGye545qv15FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98c5576dfb03a2kunm7ebf162143a982
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHx1KVkNPTR5NHxpNT0pMTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVUtZBg
	++

On Tue, 19 Aug 2025 16:43:05 Miklos wrote:

> On Mon, 18 Aug 2025 at 10:32, Chunsheng Luo <luochunsheng@ustc.edu> wrote:
> >
> > On Fri, 15 Aug 2025 11:25:38 Joanne Koong wrote:
> > >diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > >index ec248d13c8bf..1647eb7ca6fa 100644
> > >--- a/fs/fuse/fuse_i.h
> > >+++ b/fs/fuse/fuse_i.h
> > >@@ -210,6 +210,12 @@ struct fuse_inode {
> > >        /** Reference to backing file in passthrough mode */
> > >        struct fuse_backing *fb;
> > > #endif
> > >+
> > >+       /*
> > >+        * The underlying inode->i_blkbits value will not be modified,
> > >+        * so preserve the blocksize specified by the server.
> > >+        */
> > >+       u8 cached_i_blkbits;
> > > };
> >
> > Does the `cached_i_blkbits` member also need to be initialized in the
> > `fuse_alloc_inode` function like `orig_ino`?
> >
> > And I am also confused, why does `orig_ino` need to be initialized in
> > `fuse_alloc_inode`, but the `orig_i_mode` member does not need it?
> 
> Strictly speaking neither one needs initialization, since these
> shouldn't be accessed until the in-core inode is set up in lookup or
> create.
> 
> But having random values in there is not nice, so I prefer having
> everything initialized in fuse_alloc_inode().  See patch below
> (whitespace damage(TM) by gmail).
> 
> Thanks,
> Miklos
> 

Understood. Thanks for the explanation. The below patch looks good to me.

Thanks. 
Chunsheng Luo

> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 19fc58cb84dc..9d26a5bc394d 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -101,14 +101,11 @@ static struct inode *fuse_alloc_inode(struct
> super_block *sb)
>         if (!fi)
>                 return NULL;
> 
> -       fi->i_time = 0;
> +       /* Initialize private data (i.e. everything except fi->inode) */
> +       BUILD_BUG_ON(offsetof(struct fuse_inode, inode) != 0);
> +       memset((void *) fi + sizeof(fi->inode), 0, sizeof(*fi) -
> sizeof(fi->inode));
> +
>         fi->inval_mask = ~0;
> -       fi->nodeid = 0;
> -       fi->nlookup = 0;
> -       fi->attr_version = 0;
> -       fi->orig_ino = 0;
> -       fi->state = 0;
> -       fi->submount_lookup = NULL;
>         mutex_init(&fi->mutex);
>         spin_lock_init(&fi->lock);
>         fi->forget = fuse_alloc_forget();
> 

