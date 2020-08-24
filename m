Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3296E2509FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 22:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHXUa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 16:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHXUa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:30:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29661C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 13:30:55 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v1so4460648qvn.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7F5yeAJVZaUbpuBUqNk5OdFniuSN7bl4J4c2+t3bWAk=;
        b=E5NfFSK4/q1Q0nTU/eGzgCX/V23x9LAfwDIy6XlB91z58sGURuizUYs9Wh/gsJkULw
         sImf0WVU1SrSFBDQVpZMyVtjALj09jhkaE2bOeyzQo0PEpZvuoeGewoPSO77SZDJdPm2
         TK8083D+pbtxlytylUD40a67pKCsSGr66yAEszF3qoHfiFs/IIsl1JGAIMZ7PVosS5T4
         fEUY8fR/OCOFncLLdCZV27ebJiDRFdYE7bWg5TUso76iOQGiiTHyjD12cDVJ+7cGMizi
         Yxxnwb6TSpPXz0P5Xd9E78AsZYZHSgWLFLXC2MHRZ9RRnM2Zb37OLJjgfvsM1QNXgppy
         QmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7F5yeAJVZaUbpuBUqNk5OdFniuSN7bl4J4c2+t3bWAk=;
        b=ZycvyQTavsCl2DUe/y4n3BdJeXbJosLDvSgtDl04KdXjF9WYnqgGJy7RJwJ3fEtd9t
         V+0cdi6u7x5GqqtKYS1/OIVav0LGUONpigmALBm3GvicrftltG3kXrxDepj+7V1GflKe
         drkHiMWPwUikIL/4Ertx6aH/1eorCIKMb920CjoAabHVYpMEb5S2/06ZZGStcIkSLPWD
         TFOYVdcuyg3HEzcmsPLfjN0FgVvi6aqykPzTRPl2B5DECjOhRF9qp0UduxHtot0HWn8I
         MkdheCEGyHyrKjYQGCpMaHZ0q+T4TbhMbX5zepHLplNBCtisoGVaYzLRL4ZVFqiF+CA4
         iTNw==
X-Gm-Message-State: AOAM5316wsY7u/xK9gY7CzAVagc0quezg5TB6a66Ble+J4FFKaTdAGZc
        8HSEh46XQgyjDwstPNTAL/NKCg==
X-Google-Smtp-Source: ABdhPJxY5TAoYucdNMqxjw7Il+TKuQJrUqIBrBsaY+3xiLC2oNlMq3wdZaJPqa2wUyYhWkqXbr3Gbw==
X-Received: by 2002:a05:6214:542:: with SMTP id ci2mr6189227qvb.7.1598301054399;
        Mon, 24 Aug 2020 13:30:54 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m30sm12516959qtm.46.2020.08.24.13.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 13:30:53 -0700 (PDT)
Subject: Re: [PATCH v5 9/9] btrfs: implement RWF_ENCODED writes
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597993855.git.osandov@osandov.com>
 <07a61c2f9a07497c165c05106dd0f9ced5bbc4fc.1597993855.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <83d564d8-234c-a2b5-e261-80ea3b96f6d1@toxicpanda.com>
Date:   Mon, 24 Aug 2020 16:30:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <07a61c2f9a07497c165c05106dd0f9ced5bbc4fc.1597993855.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 3:38 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The implementation resembles direct I/O: we have to flush any ordered
> extents, invalidate the page cache, and do the io tree/delalloc/extent
> map/ordered extent dance. From there, we can reuse the compression code
> with a minor modification to distinguish the write from writeback. This
> also creates inline extents when possible.
> 
> Now that read and write are implemented, this also sets the
> FMODE_ENCODED_IO flag in btrfs_file_open().
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   fs/btrfs/compression.c  |   7 +-
>   fs/btrfs/compression.h  |   6 +-
>   fs/btrfs/ctree.h        |   2 +
>   fs/btrfs/file.c         |  40 +++++--
>   fs/btrfs/inode.c        | 246 +++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/ordered-data.c |  12 +-
>   fs/btrfs/ordered-data.h |   2 +
>   7 files changed, 298 insertions(+), 17 deletions(-)
> 

<snip>

> +
> +	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode), disk_num_bytes);
> +	if (ret)
> +		goto out_unlock;
> +	ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved, start,
> +					num_bytes);
> +	if (ret)
> +		goto out_free_data_space;
> +	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), num_bytes,
> +					      disk_num_bytes);
> +	if (ret)
> +		goto out_qgroup_free_data;

This can just be btrfs_delalloc_reserve_space() and that way the error handling 
is much cleaner.

<snip>
> +
> +out_free_reserved:
> +	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> +	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
> +out_delalloc_release:
> +	btrfs_delalloc_release_extents(BTRFS_I(inode), num_bytes);
> +	btrfs_delalloc_release_metadata(BTRFS_I(inode), disk_num_bytes,
> +					ret < 0);

Likewise this can all just be btrfs_free_reserved_data_space().  Thanks,

Josef
