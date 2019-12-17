Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CB1238AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 22:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfLQVcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 16:32:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46628 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfLQVcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:32:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so9122829qke.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MJ9AYtjnUx+Aj3kikL503Ta5UVTMYTDPsZItljjnEbI=;
        b=FPjKYNxplN3i5LCXHaVlu03rxZdwNQbCQCUi7+n4UdqFf1Jv/HU8RpuR7pupHZJJiL
         v7Vzk8MokpoyJVAcxRr7m2NG2o6nvLoJi/uwkv3nVGeV21I3OqSSLDkApga6d2PUJ3bm
         AH7BvLEKDMa4h4/IsWBbmx1bp1+INj4dk3O/RomSGR0RGidt0//sPAxBq/6HEMR7w/df
         9yFD1qEltKjCtXdmxK3LU+5oW9B9uwD5GRE3tpcagNCX1TXQV7dzKVsCPQ3TZlbspw39
         lHz9R6EsBCOh3q3esJClgOWmdGJ5Gjlh6YsRzat5AxRqxWcHiw/LwBKu3TIfs0/UW7qg
         8HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJ9AYtjnUx+Aj3kikL503Ta5UVTMYTDPsZItljjnEbI=;
        b=kwZTy7484R9NLVDL8LEXiSTsMNIlShW2m+C7GbqeDT3E9jVZ3XknywYdaoUcZ2oj2i
         DimNfFpZy5jKHT6xKhAYhhYmsW4oy7atxnjPGSlEa7qq/dtY1FDOfNBln2Vp0MCP19oA
         5yQVio4s+4qVtZNQRSPpOwdtl38isNALvDssIt3LGTeap56giHPRyrMmyIWQmbNYKDA+
         /0RiLCGuGpTiD/W6aFap5N+iW7cb0Fka/ZV5eBzuxfCa3+hlICSuDUoibd/3BeijGoPW
         laD2rZzxh94HSlXU0B6gWW0KH9S2dLWncVv1nG+A9OHevRL7naRX/BM7LjbtIMF4g7hV
         RfJQ==
X-Gm-Message-State: APjAAAWG5S7XttTRpcwN/T8ki3vE61drzAbQbg2oY8tIILi+NrmayodR
        gaRHgrhRB1qMjxKW22cFapgSmfJCw1/ELg==
X-Google-Smtp-Source: APXvYqyLNb0jX9m0TWQue4nTkRwcbIcf3iZuvNBWoSrsDEyTOp6ourDKEndV97nY7xZj/IE3Ej8OWQ==
X-Received: by 2002:a37:514:: with SMTP id 20mr18189qkf.321.1576618326442;
        Tue, 17 Dec 2019 13:32:06 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j15sm39256qtn.37.2019.12.17.13.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 13:32:05 -0800 (PST)
Subject: Re: [PATCH v6 24/28] btrfs: enable relocation in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-25-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <83984f9c-4f37-4a04-daea-8169959dc09d@toxicpanda.com>
Date:   Tue, 17 Dec 2019 16:32:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-25-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> To serialize allocation and submit_bio, we introduced mutex around them. As
> a result, preallocation must be completely disabled to avoid a deadlock.
> 
> Since current relocation process relies on preallocation to move file data
> extents, it must be handled in another way. In HMZONED mode, we just
> truncate the inode to the size that we wanted to pre-allocate. Then, we
> flush dirty pages on the file before finishing relocation process.
> run_delalloc_hmzoned() will handle all the allocation and submit IOs to
> the underlying layers.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/relocation.c | 39 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d897a8e5e430..2d17b7566df4 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3159,6 +3159,34 @@ int prealloc_file_extent_cluster(struct inode *inode,
>   	if (ret)
>   		goto out;
>   
> +	/*
> +	 * In HMZONED, we cannot preallocate the file region. Instead,
> +	 * we dirty and fiemap_write the region.
> +	 */
> +
> +	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED)) {
> +		struct btrfs_root *root = BTRFS_I(inode)->root;
> +		struct btrfs_trans_handle *trans;
> +
> +		end = cluster->end - offset + 1;
> +		trans = btrfs_start_transaction(root, 1);
> +		if (IS_ERR(trans))
> +			return PTR_ERR(trans);
> +
> +		inode->i_ctime = current_time(inode);
> +		i_size_write(inode, end);
> +		btrfs_ordered_update_i_size(inode, end, NULL);
> +		ret = btrfs_update_inode(trans, root, inode);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			btrfs_end_transaction(trans);
> +			return ret;
> +		}
> +		ret = btrfs_end_transaction(trans);
> +
> +		goto out;
> +	}
> +

Why are we arbitrarily extending the i_size here?  If we don't need prealloc we 
don't need to jack up the i_size either.

>   	cur_offset = prealloc_start;
>   	while (nr < cluster->nr) {
>   		start = cluster->boundary[nr] - offset;
> @@ -3346,6 +3374,10 @@ static int relocate_file_extent_cluster(struct inode *inode,
>   		btrfs_throttle(fs_info);
>   	}
>   	WARN_ON(nr != cluster->nr);
> +	if (btrfs_fs_incompat(fs_info, HMZONED) && !ret) {
> +		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
> +		WARN_ON(ret);

Do not WAR_ON() when this could happen due to IO errors.  Thanks,

Josef
