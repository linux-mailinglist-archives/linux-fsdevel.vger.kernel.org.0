Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF14240D0A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 02:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhIPANE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 20:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhIPAND (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:13:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAAF260FA0;
        Thu, 16 Sep 2021 00:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751103;
        bh=DrgS4qNdxQm5KxNgrDvFQ1kvve7TdWHpwz0i4Kn4wgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQzzFyCvUbMAwYtKX/rOcqmlS9FnmfWLjqEh0Ok037HZFwO1u82Qzqc5MkeNQDlf9
         IS5BcQ7J26sIfJa86IlrU9z3fc1Pn8JlMymPqm36R0T6XsGAh3ZNbjlxqicDpU7sSl
         JczVkDGZl5QHltKEkKRHnjf2l73s/To4m3d5sKtE+qeqxqTBcGoYSZ5T2zngbRh4+5
         jUhz8wsQCDabTFAtO/ha87VkLqq/2fAU8yxC4oP3L2yEWokIicfARHKhcMSGS6L47h
         uH3tNVh+RQQbsoaCSTyUbEkEBi6MrBms4srOK3YXUSRSpZDggD5fUdydpQTZLcJjgU
         CkzYT0pbvb6rg==
Date:   Wed, 15 Sep 2021 17:11:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     hch@lst.de, linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        rgoldwyn@suse.de, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v9 4/8] fsdax: Convert dax_iomap_zero to iter model
Message-ID: <20210916001143.GC34830@magnolia>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
 <20210915104501.4146910-5-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915104501.4146910-5-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 06:44:57PM +0800, Shiyang Ruan wrote:
> Let dax_iomap_zero() support iter model.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Oops, I guess we forgot this one when we did the iter conversion last
cycle. :(

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c               | 3 ++-
>  fs/iomap/buffered-io.c | 3 +--
>  include/linux/dax.h    | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 41c93929f20b..4f346e25e488 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1209,8 +1209,9 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>  
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +s64 dax_iomap_zero(struct iomap_iter *iter, loff_t pos, u64 length)
>  {
> +	const struct iomap *iomap = &iter->iomap;
>  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  	pgoff_t pgoff;
>  	long rc, id;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9cc5798423d1..84a861d3b3e0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -889,7 +889,6 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
> -	struct iomap *iomap = &iter->iomap;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
> @@ -903,7 +902,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		s64 bytes;
>  
>  		if (IS_DAX(iter->inode))
> -			bytes = dax_iomap_zero(pos, length, iomap);
> +			bytes = dax_iomap_zero(iter, pos, length);
>  		else
>  			bytes = __iomap_zero_iter(iter, pos, length);
>  		if (bytes < 0)
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 2619d94c308d..642de7ef1a10 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -13,6 +13,7 @@ typedef unsigned long dax_entry_t;
>  
>  struct iomap_ops;
>  struct iomap;
> +struct iomap_iter;
>  struct dax_device;
>  struct dax_operations {
>  	/*
> @@ -210,7 +211,7 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
> +s64 dax_iomap_zero(struct iomap_iter *iter, loff_t pos, u64 length);
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
> -- 
> 2.33.0
> 
> 
> 
