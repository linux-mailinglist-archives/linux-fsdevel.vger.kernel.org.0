Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA32A30BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgKBRCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgKBRCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:02:05 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8FC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 09:02:05 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id b11so6422934qvr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SbL5FocLNkTRmWqA4q3jxjT0btO9zlqWVbryPohUtgk=;
        b=TmXk96eI6gArmi7QvCieyQ3qvE5/YbAAWc2NL26GbrGmioMgWCAOwlehl5zRABt6aT
         r55h2qm9+G/fJ3/kGt5mhstenLzbMf9jkobcd/K4VxtxTwm7RQns4L4+G15igadp8B2q
         HgalpOIm9kapDGCB9CHwj9JEMcSav1gxj5wRMF0KkKK+R+PoDyJn+88VQ7NesqhAC5j2
         1WaAaxNNIdVEB22NnaDvg5KMCDvNUUnBEdSTFhIPtVYrWq3Wl/gpPLvVQ6hvpf/ftf9a
         vLDupLSamq7PaShZdK20EHOza95hrpg8E02nDXHcZCzUpPT4FT4zkWdbr5gHPPB1X+ys
         kMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SbL5FocLNkTRmWqA4q3jxjT0btO9zlqWVbryPohUtgk=;
        b=VD6RBN20hKbX1shDuIaoCHCjzIgiud1uEg5AYLhEFRgRPiSTkScZfDYVNkP+spvmZQ
         dRwl7EXBTxSiRZPwNcSRuiZnZ9rucp9sVI0kZwnjPY2zqzhnCN/819p+FhaUaNUmb2cG
         Uu2lQaqHLar+61pmjQNT7YMEt4r2BRxtUShP+IPkXePNMzuGpa83D65AHpqV1Jq9f6s+
         fAiPgiVnmmU75cJZ96wjQZF6Z3UBlEHwkyfApQfGoTNV5TYfekkR40PTQ7qk85QX3a1Q
         0Xgs/s4IsYej38ahvYnzULEvfX4NTI93i1j1Wq93tyxclLr52FKu98mjKrH+uGSB0xar
         aW0g==
X-Gm-Message-State: AOAM531qcbZc+XR1cWeKV+h26GXRSGmvZzIFaaMrZDv14kG3CMJRO3Eu
        E6AaU/CO/S8XpT/40rydZfPaCL6obNzC6Q==
X-Google-Smtp-Source: ABdhPJwSTMKECFT4KP1Y3NTLQZ3rVKH9me6nQwpVZjqUiPqtluTQszOXhx7CXl8TEU8ap+WNYng2fA==
X-Received: by 2002:a05:6214:12b4:: with SMTP id w20mr16303827qvu.12.1604336524398;
        Mon, 02 Nov 2020 09:02:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d9::116a? ([2620:10d:c091:480::1:f39e])
        by smtp.gmail.com with ESMTPSA id r16sm8343352qkm.1.2020.11.02.09.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 09:02:03 -0800 (PST)
Subject: Re: [PATCH v9 07/41] btrfs: disallow space_cache in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <f0a4ae9168940bf1756f89a140cabedb8972e0d1.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4a2f90c0-e595-1a0f-5373-80517f9b9843@toxicpanda.com>
Date:   Mon, 2 Nov 2020 12:02:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <f0a4ae9168940bf1756f89a140cabedb8972e0d1.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> As updates to the space cache v1 are in-place, the space cache cannot be
> located over sequential zones and there is no guarantees that the device
> will have enough conventional zones to store this cache. Resolve this
> problem by disabling completely the space cache v1.  This does not
> introduces any problems with sequential block groups: all the free space is
> located after the allocation pointer and no free space before the pointer.
> There is no need to have such cache.
> 
> Note: we can technically use free-space-tree (space cache v2) on ZONED
> mode. But, since ZONED mode now always allocate extents in a block group
> sequentially regardless of underlying device zone type, it's no use to
> enable and maintain the tree.
> 
> For the same reason, NODATACOW is also disabled.
> 
> Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
> INODE_MAP_CACHE inode.
> 
> In summary, ZONED will disable:
> 
> | Disabled features | Reason                                              |
> |-------------------+-----------------------------------------------------|
> | RAID/Dup          | Cannot handle two zone append writes to different   |
> |                   | zones                                               |
> |-------------------+-----------------------------------------------------|
> | space_cache (v1)  | In-place updating                                   |
> | NODATACOW         | In-place updating                                   |
> |-------------------+-----------------------------------------------------|
> | fallocate         | Reserved extent will be a write hole                |
> | INODE_MAP_CACHE   | Need pre-allocation. (and will be deprecated?)      |
> |-------------------+-----------------------------------------------------|
> | MIXED_BG          | Allocated metadata region will be write holes for   |
> |                   | data writes                                         |
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/super.c | 12 ++++++++++--
>   fs/btrfs/zoned.c | 18 ++++++++++++++++++
>   fs/btrfs/zoned.h |  5 +++++
>   3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3312fe08168f..9064ca62b0a0 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -525,8 +525,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   	cache_gen = btrfs_super_cache_generation(info->super_copy);
>   	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
>   		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> -	else if (cache_gen)
> -		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
> +	else if (cache_gen) {
> +		if (btrfs_is_zoned(info)) {
> +			btrfs_info(info,
> +			"clearring existing space cache in ZONED mode");

'clearing', and then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
