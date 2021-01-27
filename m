Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9930524D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 06:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhA0Fpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 00:45:50 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:51323 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbhA0EYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:24:25 -0500
Received: by mail-pj1-f41.google.com with SMTP id a20so509801pjs.1;
        Tue, 26 Jan 2021 20:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SqJGalSs1T4thlqe2OFRuAUiTlK96f+fmHA7i8AXayU=;
        b=Nq8JpzzF4IzRv1ITuncjt2EaXqfUzPVuSAXYybacagRYRF7MzePOq98SCSkIsi5dt0
         w824wmmodQbwJrh5Eoaht5F3NXNip/WnNq5GKYAmTKRruVyY6k0+MHbavICboj1A+hiR
         xSu9yEzzz+wPZybmjtzVs6uG+GrJ1KUl5fTHUJGC+gU9YdyOx/6FJxndmh+F5NVtk6Hg
         rr8F93iFLCRqs66qKg4ALxC6p3XeDpNnFIoKsHiG7LID5l125zOf44GcLXKnN4mnL21H
         NVvIB1tkabdh3SBSa+gwmLLccf2Kt+Nm0G6APmq5MvSniVn3l54UNTVx8O0jLMXzupNR
         Q3dw==
X-Gm-Message-State: AOAM5312GXsZDznGgzhE3pLdgupgSBF5X38iWYbB6OPYGmF0vZ94yohf
        u6cYiflyzwi3i6lTHf5C640bATUWLUc=
X-Google-Smtp-Source: ABdhPJzFNH5Dqxe8SiWihU4s2H6Z7gRdvzVkrtcCEKkSc5zXtT3KUmo4kthCwpYwhUjDkvkufzvMsQ==
X-Received: by 2002:a17:902:9a4a:b029:dc:435c:70ad with SMTP id x10-20020a1709029a4ab02900dc435c70admr9189452plv.77.1611721424555;
        Tue, 26 Jan 2021 20:23:44 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:e9ac:ddc0:dd32:c413? ([2601:647:4000:d7:e9ac:ddc0:dd32:c413])
        by smtp.gmail.com with ESMTPSA id w7sm572818pfb.62.2021.01.26.20.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 20:23:43 -0800 (PST)
Subject: Re: [PATCH] Revert "block: simplify set_init_blocksize" to regain
 lost performance
To:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210126195907.2273494-1-maxtram95@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d3effbdc-12c2-c6aa-98ba-7bde006fc4e1@acm.org>
Date:   Tue, 26 Jan 2021 20:23:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126195907.2273494-1-maxtram95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 11:59 AM, Maxim Mikityanskiy wrote:
> The cited commit introduced a serious regression with SATA write speed,
> as found by bisecting. This patch reverts this commit, which restores
> write speed back to the values observed before this commit.
> 
> The performance tests were done on a Helios4 NAS (2nd batch) with 4 HDDs
> (WD8003FFBX) using dd (bs=1M count=2000). "Direct" is a test with a
> single HDD, the rest are different RAID levels built over the first
> partitions of 4 HDDs. Test results are in MB/s, R is read, W is write.
> 
>                 | Direct | RAID0 | RAID10 f2 | RAID10 n2 | RAID6
> ----------------+--------+-------+-----------+-----------+--------
> 9011495c9466    | R:256  | R:313 | R:276     | R:313     | R:323
> (before faulty) | W:254  | W:253 | W:195     | W:204     | W:117
> ----------------+--------+-------+-----------+-----------+--------
> 5ff9f19231a0    | R:257  | R:398 | R:312     | R:344     | R:391
> (faulty commit) | W:154  | W:122 | W:67.7    | W:66.6    | W:67.2
> ----------------+--------+-------+-----------+-----------+--------
> 5.10.10         | R:256  | R:401 | R:312     | R:356     | R:375
> unpatched       | W:149  | W:123 | W:64      | W:64.1    | W:61.5
> ----------------+--------+-------+-----------+-----------+--------
> 5.10.10         | R:255  | R:396 | R:312     | R:340     | R:393
> patched         | W:247  | W:274 | W:220     | W:225     | W:121
> 
> Applying this patch doesn't hurt read performance, while improves the
> write speed by 1.5x - 3.5x (more impact on RAID tests). The write speed
> is restored back to the state before the faulty commit, and even a bit
> higher in RAID tests (which aren't HDD-bound on this device) - that is
> likely related to other optimizations done between the faulty commit and
> 5.10.10 which also improved the read speed.
> 
> Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> Fixes: 5ff9f19231a0 ("block: simplify set_init_blocksize")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/block_dev.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 3b8963e228a1..235b5042672e 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -130,7 +130,15 @@ EXPORT_SYMBOL(truncate_bdev_range);
>  
>  static void set_init_blocksize(struct block_device *bdev)
>  {
> -	bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +	unsigned int bsize = bdev_logical_block_size(bdev);
> +	loff_t size = i_size_read(bdev->bd_inode);
> +
> +	while (bsize < PAGE_SIZE) {
> +		if (size & bsize)
> +			break;
> +		bsize <<= 1;
> +	}
> +	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
>  }
>  
>  int set_blocksize(struct block_device *bdev, int size)

How can this patch affect write speed? I haven't found any calls of
set_init_blocksize() in the I/O path. Did I perhaps overlook something?

Bart.


