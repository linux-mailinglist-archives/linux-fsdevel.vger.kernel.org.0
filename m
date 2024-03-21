Return-Path: <linux-fsdevel+bounces-14963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419588584F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 12:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C90FB21895
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 11:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2C58AAB;
	Thu, 21 Mar 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WqUzvvEO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NG6NW3oW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WqUzvvEO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NG6NW3oW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88305820E;
	Thu, 21 Mar 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020465; cv=none; b=XvKFomoqh8p4O0+LaKqo1HRJI2PPcA+O1ZR6c+5NTMtQGym6q/SanNNAuNlE/Cu0Ygh9JXkY45KFJYF1htKgJwfBhWKOaRtrV4Fi21OY20msN0OD6BkTe/EXAZKLV+3hdtvs4Nt/fqyTKEkF9qwQBHa9vqICqc//Gqe283F52CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020465; c=relaxed/simple;
	bh=gB1khvqThJugrZAMR9+Tp52RV1RDh5wqdtq4vWHAfjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOj6ajGcwQjE0a5rduTzDKcyz7fMJztmTJBfdAT11aC1hH1zZ7e4htGOsvjMTXpk4P2vHRG+vDxLBE2kJaPG7y/mtp42ciwnt19a+bnuVkJ9td8+poIZ+v4Yb6amDMUU23+HuovBJEOBeRTuihEdSVdDq1BeDysAMeFSDTIxtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WqUzvvEO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NG6NW3oW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WqUzvvEO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NG6NW3oW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFF4B5CD08;
	Thu, 21 Mar 2024 11:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711020461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMgoBh1vE8S5gkLWpLfCktSF4v+G/pTz2VTTYHeyljw=;
	b=WqUzvvEO9CiFO3CgkWuWHG0Uj2DmYtt+xTSuqltXPQl2VdEA1f2LLNxcCSPB3UBS/vF7GX
	YWBMmulQUllHzjNEm6OZzR1sn8GC1AgQxHceeiBBKB8Be2TpmAYWA0Uf8ik1WRfmkfQ8PX
	HKIZsH+JxI7R8//eBsrAWM7BDcSfRyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711020461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMgoBh1vE8S5gkLWpLfCktSF4v+G/pTz2VTTYHeyljw=;
	b=NG6NW3oW1Mu47wZ5L9NBXERdB0/xfhfcKSE9K2sOrI9LpwRggX9FySXx6Py7/sxT05ttej
	1ypmnmwNu1WncGBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711020461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMgoBh1vE8S5gkLWpLfCktSF4v+G/pTz2VTTYHeyljw=;
	b=WqUzvvEO9CiFO3CgkWuWHG0Uj2DmYtt+xTSuqltXPQl2VdEA1f2LLNxcCSPB3UBS/vF7GX
	YWBMmulQUllHzjNEm6OZzR1sn8GC1AgQxHceeiBBKB8Be2TpmAYWA0Uf8ik1WRfmkfQ8PX
	HKIZsH+JxI7R8//eBsrAWM7BDcSfRyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711020461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMgoBh1vE8S5gkLWpLfCktSF4v+G/pTz2VTTYHeyljw=;
	b=NG6NW3oW1Mu47wZ5L9NBXERdB0/xfhfcKSE9K2sOrI9LpwRggX9FySXx6Py7/sxT05ttej
	1ypmnmwNu1WncGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5670136AD;
	Thu, 21 Mar 2024 11:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eTZDLK0Z/GXqMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Mar 2024 11:27:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D7A2A080F; Thu, 21 Mar 2024 12:27:37 +0100 (CET)
Date: Thu, 21 Mar 2024 12:27:37 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz, brauner@kernel.org,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240321112737.33xuxfttrahtvbej@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WqUzvvEO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NG6NW3oW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: BFF4B5CD08
X-Spam-Flag: NO

Hello!

On Tue 19-03-24 16:26:19, Yu Kuai wrote:
> 在 2024/03/19 7:22, Christoph Hellwig 写道:
> > On Mon, Mar 18, 2024 at 03:19:03PM +0800, Yu Kuai wrote:
> > > I come up with an ideal:
> > > 
> > > While opening the block_device the first time, store the generated new
> > > file in "bd_inode->i_private". And release it after the last opener
> > > close the block_device.
> > > 
> > > The advantages are:
> > >   - multiple openers can share the same bdev_file;
> > >   - raw block device ops can use the bdev_file as well, and there is no
> > > need to distinguish iomap/buffer_head for raw block_device;
> > > 
> > > Please let me know what do you think?
> > 
> > That does sound very reasonable to me.
> > 
> I just implement the ideal with following patch(not fully tested, just
> boot and some blktests)

So I was looking into this and I'm not sure I 100% understand the problem.
I understand that the inode you get e.g. in blkdev_get_block(),
blkdev_iomap_begin() etc. may be an arbitrary filesystem block device
inode. But why can't you use I_BDEV(inode->i_mapping->host) to get to the
block device instead of your file_bdev(inode->i_private)? I don't see any
advantage in stashing away that special bdev_file into inode->i_private but
perhaps I'm missing something...

								Honza

> diff --git a/block/fops.c b/block/fops.c
> index 4037ae72a919..059f6c7d3c09 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -382,7 +382,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb,
> struct iov_iter *iter)
>  static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t
> length,
>                 unsigned int flags, struct iomap *iomap, struct iomap
> *srcmap)
>  {
> -       struct block_device *bdev = I_BDEV(inode);
> +       struct block_device *bdev = file_bdev(inode->i_private);
>         loff_t isize = i_size_read(inode);
> 
>         iomap->bdev = bdev;
> @@ -404,7 +404,7 @@ static const struct iomap_ops blkdev_iomap_ops = {
>  static int blkdev_get_block(struct inode *inode, sector_t iblock,
>                 struct buffer_head *bh, int create)
>  {
> -       bh->b_bdev = I_BDEV(inode);
> +       bh->b_bdev = file_bdev(inode->i_private);
>         bh->b_blocknr = iblock;
>         set_buffer_mapped(bh);
>         return 0;
> @@ -598,6 +598,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
> 
>  static int blkdev_open(struct inode *inode, struct file *filp)
>  {
> +       struct file *bdev_file;
>         struct block_device *bdev;
>         blk_mode_t mode;
>         int ret;
> @@ -614,9 +615,28 @@ static int blkdev_open(struct inode *inode, struct file
> *filp)
>         if (!bdev)
>                 return -ENXIO;
> 
> +       bdev_file = alloc_and_init_bdev_file(bdev,
> +                       BLK_OPEN_READ | BLK_OPEN_WRITE, NULL);
> +       if (IS_ERR(bdev_file)) {
> +               blkdev_put_no_open(bdev);
> +               return PTR_ERR(bdev_file);
> +       }
> +
> +       bdev_file->private_data = ERR_PTR(-EINVAL);
> +       get_bdev_file(bdev, bdev_file);
>         ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
> -       if (ret)
> +       if (ret) {
> +               put_bdev_file(bdev);
>                 blkdev_put_no_open(bdev);
> +       } else {
> +               filp->f_flags |= O_LARGEFILE;
> +               filp->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
> +               if (bdev_nowait(bdev))
> +                       filp->f_mode |= FMODE_NOWAIT;
> +               filp->f_mapping = bdev_mapping(bdev);
> +               filp->f_wb_err =
> filemap_sample_wb_err(bdev_file->f_mapping);
> +       }
> +
>         return ret;
>  }
> 
> > .
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

