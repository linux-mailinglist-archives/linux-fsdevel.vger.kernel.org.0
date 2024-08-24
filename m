Return-Path: <linux-fsdevel+bounces-27020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EDE95DB8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 06:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE351C2109C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC314A639;
	Sat, 24 Aug 2024 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4kAOOgT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735535894;
	Sat, 24 Aug 2024 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724475268; cv=none; b=e4ZzsPhLLHm25N3+5YDwdTMghm6w56scWGbzLROZEwk4awET50/wHf41bsGu0YZOmpWRn/bUL2Hzvg8HoqE4haZgmvx4AoerjS3Ri+NiwmRh7S9eJhtUvNw76MRKzGNUnLFX0J4g5Ecs6YoKmyNNM4umB4ko6bXwKkgcIs9Ifs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724475268; c=relaxed/simple;
	bh=wXpKTZUdoyvJvNJnOIQkfolt/f0qWFXnVsW6rLNH3Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rsh4DE6PDgrGA9Z/owDqb9ICM8IAuw2np1vxwJrxSSMN14ZocSThTIxqgXQaohFXlM7x02vr8O17z8Z9Dxee5BmA3jQfCtgAeM4/6/+AJ1iZL9inHFlyhmBKxEgCrEUW22LoB3Yn+v5nP/zBdSAmFMcTLLikJ3LrptPbQKK5K5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4kAOOgT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7d26c2297eso326798966b.2;
        Fri, 23 Aug 2024 21:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724475265; x=1725080065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0agvCFPVlt6qRkbLAkGcHDtqfGgeeJqNkqtO9Zw9IuE=;
        b=l4kAOOgTg7VvaDTZZ8F90zBJS1a3gsgUMpPMDipJ2/TYRYQib80C4EwjeDFpTe2MRD
         AT9fNN2Nx0hBQqN4PBjYWJD8iSsycYhaj5+LzTdhrhxbbMWcn59Rv/Qmf3PTmUtuEW1E
         EuzSe3YYuXnKMKkMzgZ5k91nnM/xNPtJ0xsTTcZh02NxaD6YiSGR1RaInFuBGmZzEXCT
         hs3YmLjN5fbAKZS0Rw/H6Bd1HUU9+sm+9KlWOVgtZ5JaDoeybvxADiinlYy36rQba32z
         A00Cq8ZZmTNtCiP8yQYnk0bipFnmVJ5/JcwsvHbVGcjONJ7fUzeL/lmRmzYPUWT9jET7
         duSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724475265; x=1725080065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0agvCFPVlt6qRkbLAkGcHDtqfGgeeJqNkqtO9Zw9IuE=;
        b=qVdpiVyJeeuEsil/ZyKVD9oVLowILq3QOcILj0nASMPM7wrC7cqnPocQpQ6PuYYFL2
         THIgEYnPScG/QhFacHvYbTdDqjPAo8LsvxCl06Sq6logYd9kYsQdjmd5peNSUL2rUp/a
         g0PBq8vydB4E0hTz2FaNIsCBeVUsEZntEbxinb3Xs0eo+kgeMBFqoOeGdkvFxM4GIhYZ
         pT8PTRvbqlmrbd/zBvrL8rKhdBo3hH3MiwVa/Jaj3W1aVlChu1AYcczmdL+K8MHrMnKs
         0RVgYa9CMD5yp5mg6i2VEpvxvWzHCArsqPdPUxRjLxdxGkx3IEs+hMvGwexpHBgRL9Oi
         Xcng==
X-Forwarded-Encrypted: i=1; AJvYcCWn7X4r0EQXn4nyydBUNH2eAopu2QfCMybCJiKn4bTn+89+ks76Tq/ii8PX4Kv7IFzdTxwL2qPR@vger.kernel.org, AJvYcCWyVs3CMR8nnIeD9G1dzH7yVprn2bbAi/6TYWS0lVQaMm0tSn4UUvVa5hrkx2tCpzmndV30jr5DSCyb/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOw3RwZ/y89MjOw1HUC5zW87WdQC7cOmsgCQozMvP5Qrsojwz
	LMBx3r1KYUtdCkmm1nQ7KaL8sJpVfwXDbHAIzWZJFrXlTxEMNR0RZ37qr3VX
X-Google-Smtp-Source: AGHT+IEMcnudO1npIFPBPydVgGxHsU4qAj/nzx8TFAksV2cts2W7KPO++590xK54FO+Us3Kq8nB8Eg==
X-Received: by 2002:a17:907:7d89:b0:a83:94bd:d913 with SMTP id a640c23a62f3a-a86a516542emr313380266b.10.1724475264194;
        Fri, 23 Aug 2024 21:54:24 -0700 (PDT)
Received: from f (cst-prg-86-203.cust.vodafone.cz. [46.135.86.203])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f29a568sm349807166b.53.2024.08.23.21.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 21:54:23 -0700 (PDT)
Date: Sat, 24 Aug 2024 06:54:13 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, david@fromorbit.com, 
	zhuyifei1999@gmail.com, syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] vfs: fix race between evice_inodes() and
 find_inode()&iput()
Message-ID: <rvorqwxqlpray26yi3epqpxjiijr77nvle3ts5glvwitebrl6e@vcvqfk2bf6sj>
References: <20240823130730.658881-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823130730.658881-1-sunjunchao2870@gmail.com>

On Fri, Aug 23, 2024 at 09:07:30PM +0800, Julian Sun wrote:
> Hi, all
> 
> Recently I noticed a bug[1] in btrfs, after digged it into
> and I believe it'a race in vfs.
> 
> Let's assume there's a inode (ie ino 261) with i_count 1 is
> called by iput(), and there's a concurrent thread calling
> generic_shutdown_super().
> 
> cpu0:                              cpu1:
> iput() // i_count is 1
>   ->spin_lock(inode)
>   ->dec i_count to 0
>   ->iput_final()                    generic_shutdown_super()
>     ->__inode_add_lru()               ->evict_inodes()
>       // cause some reason[2]           ->if (atomic_read(inode->i_count)) continue;
>       // return before                  // inode 261 passed the above check
>       // list_lru_add_obj()             // and then schedule out
>    ->spin_unlock()
> // note here: the inode 261
> // was still at sb list and hash list,
> // and I_FREEING|I_WILL_FREE was not been set
> 
> btrfs_iget()
>   // after some function calls
>   ->find_inode()
>     // found the above inode 261
>     ->spin_lock(inode)
>    // check I_FREEING|I_WILL_FREE
>    // and passed
>       ->__iget()
>     ->spin_unlock(inode)                // schedule back
>                                         ->spin_lock(inode)
>                                         // check (I_NEW|I_FREEING|I_WILL_FREE) flags,
>                                         // passed and set I_FREEING
> iput()                                  ->spin_unlock(inode)
>   ->spin_lock(inode)			  ->evict()
>   // dec i_count to 0
>   ->iput_final()
>     ->spin_unlock()
>     ->evict()
> 
> Now, we have two threads simultaneously evicting
> the same inode, which may trigger the BUG(inode->i_state & I_CLEAR)
> statement both within clear_inode() and iput().
> 
> To fix the bug, recheck the inode->i_count after holding i_lock.
> Because in the most scenarios, the first check is valid, and
> the overhead of spin_lock() can be reduced.
> 
> If there is any misunderstanding, please let me know, thanks.
> 
> [1]: https://lore.kernel.org/linux-btrfs/000000000000eabe1d0619c48986@google.com/
> [2]: The reason might be 1. SB_ACTIVE was removed or 2. mapping_shrinkable()
> return false when I reproduced the bug.
> 
> Reported-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
> CC: stable@vger.kernel.org
> Fixes: 63997e98a3be ("split invalidate_inodes()")
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 3a41f83a4ba5..011f630777d0 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -723,6 +723,10 @@ void evict_inodes(struct super_block *sb)
>  			continue;
>  
>  		spin_lock(&inode->i_lock);
> +		if (atomic_read(&inode->i_count)) {
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
>  		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;

This looks correct to me, albeit I would argue the commit message is
overly verbose making it harder to understand the gist of the problem:
evict_inodes() fails to re-check i_count after acquiring the spin lock,
while the flags blocking 0->1 i_count transisions are not set yet,
making it possible to race against such transition.

The real remark I have here is that evict_inodes(), modulo the bug, is
identical to invalidate_inodes(). Perhaps a separate patch (*not* for
stable) to whack it would be prudent?

