Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3CF3D5A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhGZNCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 09:02:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhGZNBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:01:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9478321F4E;
        Mon, 26 Jul 2021 13:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627306898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuJpj4RY+TJ18SAvpwbivBU6Y6bI+MfWHlwgs6zyLaQ=;
        b=T4S8bua84ntZ4sXcJAuvF9mrep+MSEhGDno6dqZ9M1P98E3/w99HX0H6KzcGE2Bdj6HKiZ
        ji/A9EKQFckeDxDvpopyU5ULnNTA4j+P6SKHQuGa4IeHwssc6r1Dp3r3PP9XdIgAM6e5g4
        OOodBSFWWv+zJjpyV9glKPvtmmrsEtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627306898;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuJpj4RY+TJ18SAvpwbivBU6Y6bI+MfWHlwgs6zyLaQ=;
        b=kOYsXIupjhcURsqQOIfm1w07Pz2PDbZLHzfFEcX4PJSDB44xU6xj3fJDHXLFdOVdqjajej
        TTc06Rnnk6E0eaCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 87680A3B89;
        Mon, 26 Jul 2021 13:41:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 660071E3B13; Mon, 26 Jul 2021 15:41:38 +0200 (CEST)
Date:   Mon, 26 Jul 2021 15:41:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] ext2: use iomap_fiemap to implement ->fiemap
Message-ID: <20210726134138.GE20621@quack2.suse.cz>
References: <20210720133341.405438-1-hch@lst.de>
 <20210720133341.405438-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720133341.405438-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-07-21 15:33:39, Christoph Hellwig wrote:
> Switch from generic_block_fiemap to use the iomap version.  The only
> interesting part is that ext2_get_blocks gets confused when being
> asked for overly long ranges, so copy over the limit to the inode
> size from generic_block_fiemap into ext2_fiemap.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. I'm a bit wondering about the problem with long ranges... I
guess these are larger than s_maxbytes, aren't they? Anyway the solution
you've picked makes sense to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/inode.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 3e9a04770f49..04f0def0f5eb 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -855,8 +855,14 @@ const struct iomap_ops ext2_iomap_ops = {
>  int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		u64 start, u64 len)
>  {
> -	return generic_block_fiemap(inode, fieinfo, start, len,
> -				    ext2_get_block);
> +	int ret;
> +
> +	inode_lock(inode);
> +	len = min_t(u64, len, i_size_read(inode));
> +	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
> +	inode_unlock(inode);
> +
> +	return ret;
>  }
>  
>  static int ext2_writepage(struct page *page, struct writeback_control *wbc)
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
