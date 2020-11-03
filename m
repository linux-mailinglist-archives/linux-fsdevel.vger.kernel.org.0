Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71502A4889
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKCOrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgKCOpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:45:41 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAB3C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:45:40 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so14862211qkf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=acx1EKinqTQzg1gTQ/aclm89N3SLLibIPDLvZWE1PtI=;
        b=L4h0xMcTzd+NF2hL70xrh88PrKeUpmo2pyh+hxeCdIDOKuFe728ZYNNrAxf3TLszHI
         ecVPmoC62YlPVmTQ/9KdDMdrUk4/yIhrHYWh3rmhBqjMbs3WnJzGFlUrmZfytXCevkgn
         7fTtAxmLvCi6HWp6mDX2EUcEsImliV0D5T18p8GLpHDr4fGzKBD7hLqFT1GzLWkYbgTz
         hg2Nj2o8Db/GA0ErfKkwFRmpQa7tz068JAeqfGbskJfd1bpuOQqIMnW0aBObyEVl0EDf
         qlKe0IyOIX0DE+mOiztudJlRgJylFKJJ786mgJcij6sV//7Yxhfjw/5RGTC4LPH32xp9
         23Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=acx1EKinqTQzg1gTQ/aclm89N3SLLibIPDLvZWE1PtI=;
        b=OVjjcTT5R3J+XPlV5m3D+VI//Z6k1Xm7D8yAa9+Q7hEirxfBYL7L5TYgSOCk9Qy50M
         SHTSTCTDqR8geWRdFnzWxSNI5pVR4qwH0NBYO4vVDGQB7GPXbFUCny+8FdosjgTif6t8
         VlZHuTzq6I3ON6HdJM2X8FP7P9HTRv9z4DXAr3E5xjjkcL3o0A9qEqtcy0x4A6Ip2SSm
         m5oa7zHCglSPXOdVeqH+DKVxg+mNRuwm7f4eu6KpnyA26C1GAwr/P+F4niVJUDwWwFzP
         2PEk677o1st6FHFjSSZMedJzV6zUnr0WlSZmEt7gQyocwwY7/Di+dlxinPVFRKjinZWD
         jJSQ==
X-Gm-Message-State: AOAM532AH+FRQL9b0r2kRJFqBSnU89Wj37nyVx4bthJ7wO3sT8i+7oiP
        8HH5bHeOCuLl4UM4sdXF+wbQXB536XqoJ1ee
X-Google-Smtp-Source: ABdhPJyoydsxT+XEr+Ctz1uul/Nhvge/2PHjO289vjn0i8n2dQjgqbrS68O9iExA7CVG4aevjseUzg==
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr19708892qkj.211.1604414738875;
        Tue, 03 Nov 2020 06:45:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x22sm9552937qkn.125.2020.11.03.06.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:45:38 -0800 (PST)
Subject: Re: [PATCH v9 20/41] btrfs: extract page adding function
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <da2dba415cc94f271f0693b30296d9cc4f583f03.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9ca75255-4b2e-a5b0-b16d-2be9cea415f4@toxicpanda.com>
Date:   Tue, 3 Nov 2020 09:45:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <da2dba415cc94f271f0693b30296d9cc4f583f03.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This commit extract page adding to bio part from submit_extent_page(). The
> page is added only when bio_flags are the same, contiguous and the added
> page fits in the same stripe as pages in the bio.
> 
> Condition checkings are reordered to allow early return to avoid possibly
> heavy btrfs_bio_fits_in_stripe() calling.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e91c504fe973..17285048fb5a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3012,6 +3012,43 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
>   	return bio;
>   }
>   
> +/**
> + * btrfs_bio_add_page	-	attempt to add a page to bio
> + * @bio:	destination bio
> + * @page:	page to add to the bio
> + * @logical:	offset of the new bio or to check whether we are adding
> + *              a contiguous page to the previous one
> + * @pg_offset:	starting offset in the page
> + * @size:	portion of page that we want to write
> + * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
> + * @bio_flags:	flags of the current bio to see if we can merge them
> + *
> + * Attempt to add a page to bio considering stripe alignment etc. Return
> + * true if successfully page added. Otherwise, return false.
> + */
> +bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
> +			unsigned int size, unsigned int pg_offset,
> +			unsigned long prev_bio_flags, unsigned long bio_flags)

This should be static, once you change that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
