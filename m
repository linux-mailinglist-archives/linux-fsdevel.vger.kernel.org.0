Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC10B432B4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 03:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhJSBGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 21:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSBGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 21:06:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A58C06161C;
        Mon, 18 Oct 2021 18:04:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so3607526lfa.9;
        Mon, 18 Oct 2021 18:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HZB3VynRj4BSJ+DoffwFLiPJvzPYXkayF1wJVNoXqZo=;
        b=qa7Rg2/+uz+UIDCny84Tw5bep3SlaUI84n/FAaUaxIzAubmeoa1ydJFT64PdI4Dc2i
         AgPnjhE+kBzSH4MdsJeGrFG4f0xqH2HBhd6pbyQr8O8l98NNiVXw+7LLIlFbcV+xxCqf
         RA02zj7IDRlPmKt2XOaxe9T0CtUPo6hRSub6+1M9syuYXVu4HWpZ0mdRM4b+vfFK8OI9
         lTRtKN80UFv+SDfLWbeeA+TcDubhn33n9WeCF3bZ9pFOuoi5rOJVIPb1Sykzu+pmiRnV
         qHPYjU4GPUjtfi/yhGpy4ABO9h9df+GLOdeLNWFNTfyVWJ/R/s+xiv91lAtBOCzSytMJ
         pKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HZB3VynRj4BSJ+DoffwFLiPJvzPYXkayF1wJVNoXqZo=;
        b=f/rmWlpawhtZOPU9HDTdtyCwrb1+SPRjg0R/Vpb39hAE7SEp2KSwaAI/pecP3intm5
         HjyxBLMa/+usWFBt8nmfh8/6KaMl+mS67ElvXXqmEav4suiRI+Ykv4IVkpY+Gt0gP1yP
         eP/5Wh0lmTstCKs3W0JFu+JK4Ld0i3BIPrrxCBic/WQWfOaNDH/73evsWY6aPckqgDop
         ikGhB20xqi6i5tAk1ZwRqfz7aROkrb1D5zQwZ32ZkfI1TLa8/AiPoD++EMahx5jVYrq6
         Jsh1l25PclxpWLexHVwoQMlq++ISs30LmLYvhGwJjV3w2f1X1nee4VuF0WSt3Ca5Rb+y
         hDhw==
X-Gm-Message-State: AOAM531Znok5UQDii88R/iFyx6NDHNcgH7f2fDY4ZiCiSQq1YJ7Gl39T
        9R8rMztxXNRyX2qVRG7Enh5SH/9wDN23KQ==
X-Google-Smtp-Source: ABdhPJzDOI1VPK7ec+9Wvn2TGhELLqlWyRvZ5Uhqz00hPtHEbJZTBFS39lW+J2SjR0uuodKRx0F6pg==
X-Received: by 2002:a05:6512:1284:: with SMTP id u4mr3097377lfs.614.1634605459500;
        Mon, 18 Oct 2021 18:04:19 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id f10sm1533239lfs.56.2021.10.18.18.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 18:04:18 -0700 (PDT)
Date:   Tue, 19 Oct 2021 04:04:16 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>,
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
Subject: Re: don't use ->bd_inode to access the block device size v3
Message-ID: <20211019010416.vgecxu6wnvwi7fii@kari-VirtualBox>
References: <20211018101130.1838532-1-hch@lst.de>
 <4a8c3a39-9cd3-5b2f-6d0f-a16e689755e6@kernel.dk>
 <20211018171843.GA3338@lst.de>
 <2f5dcf79-8419-45ff-c27c-68d43242ccfe@kernel.dk>
 <20211018174901.GA3990@lst.de>
 <e0784f3e-46c8-c90c-870b-60cc2ed7a2da@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0784f3e-46c8-c90c-870b-60cc2ed7a2da@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:53:08AM -0600, Jens Axboe wrote:

snip..

> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 7b0326661a1e..a967b3fb3c71 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -236,14 +236,14 @@ static inline sector_t get_start_sect(struct block_device *bdev)
>  	return bdev->bd_start_sect;
>  }
>  
> -static inline loff_t bdev_nr_bytes(struct block_device *bdev)
> +static inline sector_t bdev_nr_sectors(struct block_device *bdev)
>  {
> -	return i_size_read(bdev->bd_inode);
> +	return bdev->bd_nr_sectors;
>  }
>  
> -static inline sector_t bdev_nr_sectors(struct block_device *bdev)
> +static inline loff_t bdev_nr_bytes(struct block_device *bdev)
>  {
> -	return bdev_nr_bytes(bdev) >> SECTOR_SHIFT;
> +	return bdev_nr_setors(bdev) << SECTOR_SHIFT;

setors -> sectors

>  }
>  
>  static inline sector_t get_capacity(struct gendisk *disk)
> 
> -- 
> Jens Axboe
> 
