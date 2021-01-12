Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A182F3AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406872AbhALToa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405457AbhALToa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:44:30 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC55FC061795
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:43:49 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id b9so2434610qtr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Q62QXC5y0HE8nzu56q5hevoJqXwOwpIeAtXw+tv8sQ=;
        b=sRvVQkDSCVAKt6BuRKri3i7+E7fsdMx/bx4KDU4N4qV13+lZ7Qd6GTSVI1VBQ4Eq/f
         UZ0o9ROCUluwNFmN0pHuYBKGCANsfprgRJ7Vhjo679UGaiNoyk8YlPELBQuur6YbadZU
         g/oQpr3bIyy1S6GAEFfKbgeoARw/uDAMvC7pnpXs2bOY/CqUs9AYPXLlnuAJfn374+Fz
         8BQjDRh33CUtQHLUOzcfrazTnq9ENVcEMVw9qRHqeViZ+mtLuMs5VZbjYWpgMudOPgSy
         XvAQ5qJ5reqo5CEIs+b9xJ6+YM/Bwe5c7aJEiRgUF5hM8rCCpCxzV/M+xR6wv2Rr8Kyu
         2vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Q62QXC5y0HE8nzu56q5hevoJqXwOwpIeAtXw+tv8sQ=;
        b=bg8Z1fsK4HQa+PlejnAF2rsXzSeXxunapot44Ar0buaPkg58XvyNQQKRWE5+Pv0MLf
         N/xBAzYQBDjFhJyRxCMm11Qe7EOKc1Mbm1A1UXTrmvy6jBlQklDlaGJWi+lJXirU6Ycn
         beUDrt9ugJFCNHk81cSM/CMW16JhAKmRxIVeHYS+FsDeytWcI+8OK136OtX/qxBDAp+N
         2hal+1yBRG1Z2I5zMvTh1w43XGwv8umT/h5W8pJifvQhMM9ATavh3A9mkhEPukMQczdZ
         gEAaYjrfYXavHDWYrhFPh1zg1FIqtRyXFSDCojeDTLiKfjJjfguGjOY/S9+uAA31WGoh
         yuCQ==
X-Gm-Message-State: AOAM533tI2gSWodfASHHrvNKWWR2CcEf2JDGUHTRtXXW7/LI7obyJlHn
        qbZqWBvjVW++FuSgc7G0WCbEjw==
X-Google-Smtp-Source: ABdhPJyiWnKE8RUIu+9PVFiFmiHPrAduaqpL0KVN88/T1oUfj2iVfZk94RheacLr15C5RTzFwBoL/Q==
X-Received: by 2002:aed:3b75:: with SMTP id q50mr635372qte.185.1610480629048;
        Tue, 12 Jan 2021 11:43:49 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q70sm1903502qka.107.2021.01.12.11.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:43:48 -0800 (PST)
Subject: Re: [PATCH v11 35/40] btrfs: enable relocation in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <b0c32d2a62cd3e61c605a2eee0ad706929a1e3a8.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b352a3da-5560-dd9e-5aba-73de4193475c@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:43:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b0c32d2a62cd3e61c605a2eee0ad706929a1e3a8.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> To serialize allocation and submit_bio, we introduced mutex around them. As
> a result, preallocation must be completely disabled to avoid a deadlock.
> 
> Since current relocation process relies on preallocation to move file data
> extents, it must be handled in another way. In ZONED mode, we just truncate
> the inode to the size that we wanted to pre-allocate. Then, we flush dirty
> pages on the file before finishing relocation process.
> run_delalloc_zoned() will handle all the allocation and submit IOs to the
> underlying layers.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/relocation.c | 35 +++++++++++++++++++++++++++++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 30a80669647f..94c72bea6a43 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2553,6 +2553,32 @@ static noinline_for_stack int prealloc_file_extent_cluster(
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * In ZONED mode, we cannot preallocate the file region. Instead, we
> +	 * dirty and fiemap_write the region.
> +	 */
> +

nit: extra newline.

otherwise you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
