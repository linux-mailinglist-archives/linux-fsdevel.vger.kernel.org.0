Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378A44300E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Oct 2021 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbhJPHmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Oct 2021 03:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbhJPHmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:42:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B080CC061765;
        Sat, 16 Oct 2021 00:40:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n8so51503793lfk.6;
        Sat, 16 Oct 2021 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yeYbTALLt+81wu8WFfyKx0a33Kod/SnDLZRAl1Frm5U=;
        b=cVnZ6+l+2XB64KtPGPsew2EuurYnsOpcBevvm/IVGVDWp/Lr378D4lUZAb7Ldqn1aU
         Nechfd+nevnKJt8FFrjsUkhQRsZN4OdAe+y/4UgENJDxkcBm3bvvsqVp0+i7kz/ncskC
         VTNCGAMRL2zXauGox8hUYH0e6cLX9YNzHMmZx68OgeqDdd/IPTSNwVgM/hhe43XfbD/A
         Rsr2ngeAq8MwLS8wYqIQpA7q0jGrbmoIHsnPPXNshCS3yofpN7y1D6hLbuTi/3aHu8Hg
         WHPyyYAgwzwuGQtuqb861mn1fmCGJ4Gxolg4kHeKn8eV14e/nwAYLFHNCnrx2jzkQiPm
         sdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yeYbTALLt+81wu8WFfyKx0a33Kod/SnDLZRAl1Frm5U=;
        b=1huJ5oysI05xJ1aHtwvlAGyBBPx/KuQAWKBT2mbRy2s/c41Q02EyXPqdoYas7YhLiw
         aZbl36IYg9/w54HDTlWv4uwV92L/19zz/n+atRnkd5JmwAh2kzomA4aCed4ye4XkwNfx
         WSvvvAgkB150U5+i7Eleh8RUEYD9u6cQzCrK4rStxxrWjDru8KdQqpcNhWPGLiUUTwg+
         wFdr2niwD0jSxq5jXhK6t+Vyn/l4eCZUNNNBvs0UsPCami3Ng9vjevcxUAMLmUYIxA3I
         zf7WZo/4dERpFEWwK9wv8SsuuczE/In0WD4P7RWskmZW1k6qwQKdX2O4YuO2x5Jzxjn8
         gCMQ==
X-Gm-Message-State: AOAM532mdIbON8UzZvjWjFYsfzqBlgByhpATVexRGrMZcPUC8hVnqM5c
        KdHF7iq0yktmgbV/ThcmIrV6DO5XAhPEQA==
X-Google-Smtp-Source: ABdhPJz42JllLibAuMU4PSsWo9d4pmXBI6FidoZzBNe3/Oe9MjVOfwHK8qKnrFH4pZzBziLDXJNmxQ==
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr9019031lfe.224.1634370011048;
        Sat, 16 Oct 2021 00:40:11 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id a19sm827633ljb.3.2021.10.16.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 00:40:10 -0700 (PDT)
Date:   Sat, 16 Oct 2021 10:40:08 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 20/30] ntfs3: use bdev_nr_bytes instead of open coding it
Message-ID: <20211016074008.o6wl7uy3vsrz4v3b@kari-VirtualBox>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-21-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-21-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:33PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ntfs3/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 55bbc9200a10e..7ed2cb5e8b1d9 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -918,7 +918,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
>  	int err;
>  	struct ntfs_sb_info *sbi;
>  	struct block_device *bdev = sb->s_bdev;
> -	struct inode *bd_inode = bdev->bd_inode;

Linus merged latest ntfs3 stuff and this temp variable is not anymore in
upstream. So this patch will conflict. Just so that you know.

>  	struct request_queue *rq = bdev_get_queue(bdev);
>  	struct inode *inode = NULL;
>  	struct ntfs_inode *ni;
> @@ -967,7 +966,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	/* Parse boot. */
>  	err = ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
> -				  bd_inode->i_size);
> +				  bdev_nr_bytes(bdev));
>  	if (err)
>  		goto out;
>  
> -- 
> 2.30.2
> 
> 
