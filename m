Return-Path: <linux-fsdevel+bounces-17891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73108B374C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 14:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11923B22840
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D063146A6D;
	Fri, 26 Apr 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCRwoqPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC91FC4;
	Fri, 26 Apr 2024 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134704; cv=none; b=dx3eE5CG07U1SSvGJVqNxdTdR6Uns9LvqiCpTHIirHJjx/jpZL4ZPOResOsVZi3KOkbVDyIKqL53ewGP1OS17sFdu+BXEM0uZ2nEKKzl6erkXFtrrUzBnPNz+/6LZCQ/u0Q9mRFy7qcvzjixiG1n8r6OORxl4jLdLu73p5gEAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134704; c=relaxed/simple;
	bh=YiNnz+/Lu7XW/l9qCAF8dwwGvrtUSUSbywiQs82oG18=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=lM5PnyrOBDXGr+P+XoJmXSs+Zy41VZEE0JmxUBprkYOxaZQqu1P1w3pcw0mxV/TlCb3p03S1EF7D149qfOg/QOv/F5dq/VzULJNWMqB/2qUPw24ooohqM1A50RUzj3IWZez14wTQa4ITlRAorljMu0mmpuN4e7XEOnCj0+xBM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCRwoqPL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1327986a12.3;
        Fri, 26 Apr 2024 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714134702; x=1714739502; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J8Us4I6GJMAPX/prvPDNnLBblFA4s8DcYEpyh+B6ghE=;
        b=cCRwoqPL7Dve9jDUK7qOCpaweiPea3vNWqq2sLSojR1+IEgtuc2aVyrHfuN3b6I7H7
         6D3nNzPqLQlktC2Hhyi0pLPGkCMSoVuhm0frjKrC65JOmqu2TtffWVppBONENAHNOn1A
         wx3ECT9hdFyykm5tFAbCL6ANBANlg1Jl7MPV7Nlq+w93RaH8fziR/1R1W1ZsZmA/KXD0
         MuZJw+PbhNQBLAsVlWrN/l1g7dwbnd6SMqod05UOqqeHEju9o1Dkgyjq26FBy2Wp8prz
         QLcgst5gO29Cd5TQEVibXRmNGzMLFoqFfdFc0VDqCxC94dODYsI75VD5XpHDPYTFxz3X
         B2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714134702; x=1714739502;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8Us4I6GJMAPX/prvPDNnLBblFA4s8DcYEpyh+B6ghE=;
        b=CxNeMqBaTdfh8+vNeKioiuMKtiiie5RtPxBFKBmJNI57cwpwkM0NO/++hH4CXvflp8
         rLYGJQxqFps/PtDhf8yMrnxQMncSeSmgRZhJFlMipFux8SqbWHB+A/fHN9ixZU08Eu12
         SJBVfwKfcxBxmkswqwLOSeNuXebY9U6fgoc3PtUayydeJr4mW0HHxB+QdglMsKDhGWAn
         DTlb5uVCDfx4lisX3cLAjZGMqFOsxPtw22I2a0Ry2RlJnrQCebKKQOKPH8ATACJ9ByUm
         TIONfgYqDg9LGKhhvAxFGvxNxe02x4IC+o5dA1F8bdMYZBBmkb+CcdN9BnG2Zl0eT995
         1Kvw==
X-Forwarded-Encrypted: i=1; AJvYcCU3IzSrr3828JN8KFWmtgCg8poeTAiyRNbP5x1dTC1HCyNKVe3mFAR6XueymLUd34EMS9mw2AZs9ZiXjyEJ0scISNrUkC3AaAtoYSOeyTsjfUURXA+0YtluISFdoSKFjKfqiuw4/k9bFw==
X-Gm-Message-State: AOJu0YyyKgB9lW8ReQqBTo+ftBYpu9m4y+qukX1cb+kknhbeaKQcdq5Y
	R4KElvxj+XNtjp1LI6v4DlF3lsKTNcCVnzcYC56/JuSuS1EMLkQe
X-Google-Smtp-Source: AGHT+IEyOzmKwpDmulsfDNoUUZ4lLr23Xmfs3rqvSkEEanKKcGelrlV3zG53JyLe5jufdjgg9tzgjw==
X-Received: by 2002:a17:90b:489:b0:2a4:f53d:e6bc with SMTP id bh9-20020a17090b048900b002a4f53de6bcmr2579977pjb.15.1714134702100;
        Fri, 26 Apr 2024 05:31:42 -0700 (PDT)
Received: from dw-tp ([171.76.87.172])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090ac00400b002a3a154b974sm14510942pjt.55.2024.04.26.05.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 05:31:39 -0700 (PDT)
Date: Fri, 26 Apr 2024 18:01:33 +0530
Message-Id: <87frv8nw4a.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, yi.zhang@huaweicloud.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before inserting delalloc block
In-Reply-To: <20240410142948.2817554-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> From: Zhang Yi <yi.zhang@huawei.com>
>
> Now we lookup extent status entry without holding the i_data_sem before
> inserting delalloc block, it works fine in buffered write path and
> because it holds i_rwsem and folio lock, and the mmap path holds folio
> lock, so the found extent locklessly couldn't be modified concurrently.
> But it could be raced by fallocate since it allocate block whitout
> holding i_rwsem and folio lock.
>
> ext4_page_mkwrite()             ext4_fallocate()
>  block_page_mkwrite()
>   ext4_da_map_blocks()
>    //find hole in extent status tree
>                                  ext4_alloc_file_blocks()
>                                   ext4_map_blocks()
>                                    //allocate block and unwritten extent
>    ext4_insert_delayed_block()
>     ext4_da_reserve_space()
>      //reserve one more block
>     ext4_es_insert_delayed_block()
>      //drop unwritten extent and add delayed extent by mistake
>
> Then, the delalloc extent is wrong until writeback, the one more
> reserved block can't be release any more and trigger below warning:
>
>  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
>
> Hold i_data_sem in write mode directly can fix the problem, but it's
> expansive, we should keep the lockless check and check the extent again
> once we need to add an new delalloc block.

Hi Zhang, 

It's a nice finding. I was wondering if this was caught in any of the
xfstests?

I have reworded some of the commit message, feel free to use it if you
think this version is better. The use of which path uses which locks was
a bit confusing in the original commit message.

<reworded from your original commit msg>

ext4_da_map_blocks(), first looks up the extent status tree for any
extent entry with i_data_sem held in read mode. It then unlocks
i_data_sem, if it can't find an entry and take this lock in write
mode for inserting a new da entry.

This is ok between -
1. ext4 buffered-write path v/s ext4_page_mkwrite(), because of the
folio lock
2. ext4 buffered write path v/s ext4 fallocate because of the inode
lock.

But this can race between ext4_page_mkwrite() & ext4 fallocate path - 

 ext4_page_mkwrite()             ext4_fallocate()
  block_page_mkwrite()
   ext4_da_map_blocks()
    //find hole in extent status tree
                                  ext4_alloc_file_blocks()
                                   ext4_map_blocks()
                                    //allocate block and unwritten extent
    ext4_insert_delayed_block()
     ext4_da_reserve_space()
      //reserve one more block
     ext4_es_insert_delayed_block()
      //drop unwritten extent and add delayed extent by mistake

Then, the delalloc extent is wrong until writeback and the extra
reserved block can't be released any more and it triggers below warning:

  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!

This patch fixes the problem by looking up extent status tree again
while the i_data_sem is held in write mode. If it still can't find
any entry, then we insert a new da entry into the extent status tree.

>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6a41172c06e1..118b0497a954 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1737,6 +1737,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  		if (ext4_es_is_hole(&es))
>  			goto add_delayed;
>  
> +found:
>  		/*
>  		 * Delayed extent could be allocated by fallocate.
>  		 * So we need to check it.
> @@ -1781,6 +1782,24 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  
>  add_delayed:
>  	down_write(&EXT4_I(inode)->i_data_sem);
> +	/*
> +	 * Lookup extents tree again under i_data_sem, make sure this
> +	 * inserting delalloc range haven't been delayed or allocated
> +	 * whitout holding i_rwsem and folio lock.
> +	 */

page fault path (ext4_page_mkwrite does not take i_rwsem) and fallocate
path (no folio lock) can race. Make sure we lookup the extent status
tree here again while i_data_sem is held in write mode, before inserting
a new da entry in the extent status tree.


> +	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
> +		if (!ext4_es_is_hole(&es)) {
> +			up_write(&EXT4_I(inode)->i_data_sem);
> +			goto found;
> +		}
> +	} else if (!ext4_has_inline_data(inode)) {
> +		retval = ext4_map_query_blocks(NULL, inode, map);
> +		if (retval) {
> +			up_write(&EXT4_I(inode)->i_data_sem);
> +			return retval;
> +		}
> +	}
> +
>  	retval = ext4_insert_delayed_block(inode, map->m_lblk);
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  	if (retval)
> -- 
> 2.39.2

