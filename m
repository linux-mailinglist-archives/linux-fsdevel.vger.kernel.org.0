Return-Path: <linux-fsdevel+bounces-37272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB59F04AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 07:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB80284941
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 06:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0372C18C01D;
	Fri, 13 Dec 2024 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YuqKY98v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451A185B56;
	Fri, 13 Dec 2024 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070381; cv=none; b=F7nyQdwZ4agKc+oi+hm96/JZhRh4C+uWF8IfTcbf8uvF2rkJyL3hZlMRFMjGSpHjeRiIs9Sxf3uLkgSlEiDAXXweqIgkf4tklik2FcYjKlJQzeFa/LSYmsn3XVbOLVCphfkoS/vFujbAA7k7U3rcncBxjrdSkrcyyBlYF3tzuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070381; c=relaxed/simple;
	bh=LGUSNx9HwLE78RpMydIHtfddwBvh+b8NnonJ223QaFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdMPR1Ix8LNL9G72DhBE3L6/EQjW8RKA+2b7Cw2ggpAN+fAuVkKT1Q5u/Hhw8L7l8Pl+0bzqvOqewKwjKp74GAiVzOpMhhaUEnOCz85FSyty58al6863/37sC2AkilSyI3b07bf1uESsZusL5I6P++E9dh0h9a5cjD20f78ab1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YuqKY98v; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734070369; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OMF8uXbZ/IeLfhBi6aXh2FshojNwRAvQ2cThwJdSi28=;
	b=YuqKY98vtYYDuIhF/Zr1dqjptHZ0qtzYtSRjl/yxlRzUWvpN60yAgTJbSGSL4wJH9w0vbzyOYUoKxy5UTxycSsSdqavusJ3H4pccy12+c2PN7sAjOaGahRtD2lMyLUu9rODreL4ZnGpDrUl9+JWi1Bp9A57c+PqHuyWu9NcgvQQ=
Received: from 30.74.144.152(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLNyEWR_1734070368 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 14:12:48 +0800
Message-ID: <1f8b523e-d68f-4382-8b1e-2475eb47ae81@linux.alibaba.com>
Date: Fri, 13 Dec 2024 14:12:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] Xarray: Do not return sibling entries from
 xas_find_marked()
To: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241213122523.12764-1-shikemeng@huaweicloud.com>
 <20241213122523.12764-2-shikemeng@huaweicloud.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241213122523.12764-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/13 20:25, Kemeng Shi wrote:
> Similar to issue fixed in commit cbc02854331ed ("XArray: Do not return
> sibling entries from xa_load()"), we may return sibling entries from
> xas_find_marked as following:
>      Thread A:               Thread B:
>                              xa_store_range(xa, entry, 6, 7, gfp);
> 			    xa_set_mark(xa, 6, mark)
>      XA_STATE(xas, xa, 6);
>      xas_find_marked(&xas, 7, mark);
>      offset = xas_find_chunk(xas, advance, mark);
>      [offset is 6 which points to a valid entry]
>                              xa_store_range(xa, entry, 4, 7, gfp);
>      entry = xa_entry(xa, node, 6);
>      [entry is a sibling of 4]
>      if (!xa_is_node(entry))
>          return entry;
> 
> Skip sibling entry like xas_find() does to protect caller from seeing
> sibling entry from xas_find_marked() or caller may use sibling entry
> as a valid entry and crash the kernel.
> 
> Besides, load_race() test is modified to catch mentioned issue and modified
> load_race() only passes after this fix is merged.
> 
> Here is an example how this bug could be triggerred in tmpfs which
> enables large folio in mapping:
> Let's take a look at involved racer:
> 1. How pages could be created and dirtied in shmem file.
> write
>   ksys_write
>    vfs_write
>     new_sync_write
>      shmem_file_write_iter
>       generic_perform_write
>        shmem_write_begin
>         shmem_get_folio
>          shmem_allowable_huge_orders
>          shmem_alloc_and_add_folios
>          shmem_alloc_folio
>          __folio_set_locked
>          shmem_add_to_page_cache
>           XA_STATE_ORDER(..., index, order)
>           xax_store()
>        shmem_write_end
>         folio_mark_dirty()
> 
> 2. How dirty pages could be deleted in shmem file.
> ioctl
>   do_vfs_ioctl
>    file_ioctl
>     ioctl_preallocate
>      vfs_fallocate
>       shmem_fallocate
>        shmem_truncate_range
>         shmem_undo_range
>          truncate_inode_folio
>           filemap_remove_folio
>            page_cache_delete
>             xas_store(&xas, NULL);
> 
> 3. How dirty pages could be lockless searched
> sync_file_range
>   ksys_sync_file_range
>    __filemap_fdatawrite_range
>     filemap_fdatawrite_wbc

Seems not a good example, IIUC, tmpfs doesn't support writeback 
(mapping_can_writeback() will return false), right?

>      do_writepages
>       writeback_use_writepage
>        writeback_iter
>         writeback_get_folio
>          filemap_get_folios_tag
>           find_get_entry
>            folio = xas_find_marked()
>            folio_try_get(folio)
> 


