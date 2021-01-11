Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0612F1AD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 17:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbhAKQXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 11:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388683AbhAKQXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:23:18 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B586AC061786
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 08:22:37 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id f26so1002qka.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 08:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jNgCe5aPwhe7LslnB1c2MSpXSm3IftHJ0k/qhj0STvc=;
        b=WwMXJAxnfCEWFq5XUPxbNzp4mSx5H39RzvNU3JHpTWghR/AcD/cR1JgAqwbWAqVqtM
         GMkLKeGaeZfIQAjHZCoNR558UCL9nfT/Yn0SoGKecgyxYWKBFVgvO3zQxmRKQDg35lVV
         +MuRlT/M7xgK5T1VG7MnT4Ks2raHoRiZHSW/8CPu/bjngC+G4XGaZf9ic+ib53Ko989h
         fgx4WQK9nGmVoxWMDP3EHlITH2F1TLr2hdVFQVhIahWX7sAgMuGKO9J/4imR6Gh25v/W
         sMA8ksLpHIHmnBqAQTx3/YNQlAEtadcGaRxiM5mRWrQKeGHpeE0lPiwZqCXpJ0LAzwSr
         +bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jNgCe5aPwhe7LslnB1c2MSpXSm3IftHJ0k/qhj0STvc=;
        b=eZU7qFTrNiAcDXvssVsLqi922KFZz41bJM5uybtbI59Fs5UPfzLSaPtIfLWhyRjpu4
         F0cTtc3fQ8C9132tpWxs9ZEI7hds4FSWyLfQgy0+iL/z+cdLreLKmVfZBH4o7Rbi58SR
         Jobt3DhepBEQLn6KJhQ4eY/c0q1FiEkZd0gjgKw39KjQfahVaAK40tqldgK+9RmD0hsG
         UOdLhIPX1Np0hIJJGsxvEcwgA2g1iD3XYHqUpkC5xlnpEKobKnMKOD9h9cExA2vP32el
         Iz8upohc6vJxTcdckipwwl/TRwbkA5L0xN5yqE50OC+hU3kK253O0QmmCDrBKAzMif6j
         TzxA==
X-Gm-Message-State: AOAM532f949rX7EKNI40cl6nKcp3kxnScTWF09tgo/MA1ZqwOxVFG9St
        QJ2PF6/VH/VxHS1WHSNd58UDqA==
X-Google-Smtp-Source: ABdhPJyF+K/aY6Lg+FBfOiz4wnydbdIs7udCrtCglgOh5M3yehDQMMKM/cGCxtvtsgSnuT7m+kdLWg==
X-Received: by 2002:a05:620a:b02:: with SMTP id t2mr21405qkg.427.1610382156861;
        Mon, 11 Jan 2021 08:22:36 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 8sm133662qkr.28.2021.01.11.08.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 08:22:36 -0800 (PST)
Subject: Re: [PATCH v11 19/40] btrfs: extract page adding function
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <a442f64e5fd84a823993e81f81f29287cd4ec274.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <429b0dc8-d02e-40e1-6d86-ad3788c3beba@toxicpanda.com>
Date:   Mon, 11 Jan 2021 11:22:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a442f64e5fd84a823993e81f81f29287cd4ec274.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This commit extract page adding to bio part from submit_extent_page(). The
> page is added only when bio_flags are the same, contiguous and the added
> page fits in the same stripe as pages in the bio.
> 
> Condition checkings are reordered to allow early return to avoid possibly
> heavy btrfs_bio_fits_in_stripe() calling.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/extent_io.c | 56 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 129d571a5c1a..2f070a9e5b22 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3061,6 +3061,44 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
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

Just a nit, you're missing @return here, the commit flags caught this, I'd 
recommend adding our commit flags to your local repo so you can preemptively 
catch these sort of things

https://github.com/btrfs/btrfs-workflow/blob/master/patch-submission.md

under the "Git config options" section.  If you have to respin you can add it 
then.  Thanks,

Josef
