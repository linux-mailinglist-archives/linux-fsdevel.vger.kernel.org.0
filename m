Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF8E2A32D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgKBSXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgKBSXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:23:05 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532BC061A04
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:23:03 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 140so12356836qko.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZTddkQKg3PP0jnvm8tADaXMJ6TIznKy62utI4HdR0ig=;
        b=lFBFIPiJv/YHTVIE2FCOJ4VFF3MiSD3ShLtwJbsVIhcYQGBr/apOEqEbl8Z7mT3f6e
         +J1aIIZptxe51VmN0GZWe2jtUGZIh9DRyaG7qwIERPuGaMoPQiI7UEXGVz/JbEeX02Zj
         Ram8TdIVQrHhRwBubWcQ2m8FkenpEhe3gpTfkJaVlLcz9wwvzV2Xl9dmGzT2LwzPxyo5
         JG8+1gkT76SSqAp5PIQeJ6YdIOogiKfr9IHCPKG56BECqRT+ZBjqc06Q7s1Zj4PRbZNq
         H6vVHpPgxj0cttqJQ9BaBGSygav++b6XLgy5lVDBVXG3P8kCU/hT5PRGgB+mAupXxXvz
         oBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZTddkQKg3PP0jnvm8tADaXMJ6TIznKy62utI4HdR0ig=;
        b=MTHAouCkdIq2DpKIcUzjFIwc+ED72nsZZuKHTV6K0HfhhlGedB062LRv8OpurAxjxK
         PmCPRGNAbA1St7P6YInQ3kpDDlWPEAHJffpkt6MhRW7fcnQloXPSX8lPSd8N9i3Cxx9e
         u0A9NWR9bJA+gts3xDnw105UWLvEF0EEDIDV5HFKWlRVXGpSK++nabbjKl4Gd4NTicVp
         ss05GZXEGlMlTYwPJniEgwkDv7IUKcLQPmVwZ4QuW69eTCPE1TF4aOYUkW9MNGiebB11
         hZA5GQqAHuwBE1FgreouP3wUy/u20ErG6vbTZQEGerK3wb8K1feFDzpcJGHw7Bzrigps
         SVWA==
X-Gm-Message-State: AOAM533RKIoyCEcwRLY4HWR2hYkXVyS8wuCLClbin0t5ioDIANnRxBHj
        yG1EKXx5JrszYy9lPbCrOZWLA2thrigWUGSS
X-Google-Smtp-Source: ABdhPJzgFRF3Pqlep5Jciq/siMF5i6FYrptlP4ljluqUtfpnDBLrVhwNjjHUPVVEvileax8XXn1FqQ==
X-Received: by 2002:a05:620a:4141:: with SMTP id k1mr16676918qko.60.1604341378316;
        Mon, 02 Nov 2020 10:22:58 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x6sm8296660qto.48.2020.11.02.10.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 10:22:57 -0800 (PST)
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0485861e-40d4-a736-fc26-fc6fdb435baa@toxicpanda.com>
Date:   Mon, 2 Nov 2020 13:22:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> Superblock (and its copies) is the only data structure in btrfs which has a
> fixed location on a device. Since we cannot overwrite in a sequential write
> required zone, we cannot place superblock in the zone. One easy solution is
> limiting superblock and copies to be placed only in conventional zones.
> However, this method has two downsides: one is reduced number of superblock
> copies. The location of the second copy of superblock is 256GB, which is in
> a sequential write required zone on typical devices in the market today.
> So, the number of superblock and copies is limited to be two.  Second
> downside is that we cannot support devices which have no conventional zones
> at all.
> 
> To solve these two problems, we employ superblock log writing. It uses two
> zones as a circular buffer to write updated superblocks. Once the first
> zone is filled up, start writing into the second buffer. Then, when the
> both zones are filled up and before start writing to the first zone again,
> it reset the first zone.
> 
> We can determine the position of the latest superblock by reading write
> pointer information from a device. One corner case is when the both zones
> are full. For this situation, we read out the last superblock of each
> zone, and compare them to determine which zone is older.
> 
> The following zones are reserved as the circular buffer on ZONED btrfs.
> 
> - The primary superblock: zones 0 and 1
> - The first copy: zones 16 and 17
> - The second copy: zones 1024 or zone at 256GB which is minimum, and next
>    to it
> 
> If these reserved zones are conventional, superblock is written fixed at
> the start of the zone without logging.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/block-group.c |   9 ++
>   fs/btrfs/disk-io.c     |  41 +++++-
>   fs/btrfs/scrub.c       |   3 +
>   fs/btrfs/volumes.c     |  21 ++-
>   fs/btrfs/zoned.c       | 311 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/zoned.h       |  40 ++++++
>   6 files changed, 413 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c0f1d6818df7..e989c66aa764 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1723,6 +1723,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>   static int exclude_super_stripes(struct btrfs_block_group *cache)
>   {
>   	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	bool zoned = btrfs_is_zoned(fs_info);
>   	u64 bytenr;
>   	u64 *logical;
>   	int stripe_len;
> @@ -1744,6 +1745,14 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
>   		if (ret)
>   			return ret;
>   
> +		/* shouldn't have super stripes in sequential zones */
> +		if (zoned && nr) {
> +			btrfs_err(fs_info,
> +				  "Zoned btrfs's block group %llu should not have super blocks",
> +				  cache->start);
> +			return -EUCLEAN;
> +		}
> +

I'm very confused about this check, namely how you've been able to test without 
it blowing up, which makes me feel like I'm missing something.

We _always_ call exclude_super_stripes(), and we're simply looking up the bytenr 
for that block, which appears to not do anything special for zoned.  This should 
be looking up and failing whenever it looks for super stripes far enough out. 
How are you not failing here everytime you mount the fs?  Thanks,

Josef
