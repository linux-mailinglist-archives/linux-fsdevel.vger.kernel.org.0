Return-Path: <linux-fsdevel+bounces-22491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D89180F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DC91C21593
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2728181BA5;
	Wed, 26 Jun 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpD6ZpKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4D171AD;
	Wed, 26 Jun 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405123; cv=none; b=CS6st0j9POUjbxW0JXkOUmJoMI5wTdnkH0bBVdZf+ETo8v2US0QIzMyCMGOpCvgYy2+b+MsEa3czU4c16srfce9dVbm9p4z8fbLNV5cCuSIapOTCm5eivOUOvEl+74Ext2AxqLe0nvZXeOyviHHoMH85ccGnvZQwreU4VKAFDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405123; c=relaxed/simple;
	bh=mc/ZYbx1LwXPN/DM65SBf0NUloG3DhGylqQgVaBcn9g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LxE4Ex5Dxj0UPFrzEWPn6hoxoRXBsD6jeqz+boRSGlJdw25+bA8p0fUGKcNvJexFM+3bu22g3MYxlQ99gIJwvgb2nor6zSCe7cuNll+w9/jB1Ii2WInWEwUpYZzRly6uFLKQZRNflsKJi1FlLLmeigQ4+ZA4IYd2dMuYQRfjOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpD6ZpKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C21C2BD10;
	Wed, 26 Jun 2024 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719405122;
	bh=mc/ZYbx1LwXPN/DM65SBf0NUloG3DhGylqQgVaBcn9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PpD6ZpKMa22oJXnc5CzpHrMIdkiw7/YZz1clqYsll/D6PeVQU3wuvM38FF9MxpJ/E
	 PGtfU7hGckDZxUSsxPakXzyhUdY3+U7vCMl6JUroMbpkZ+0Sk9BvPBKzXH28yXtdva
	 wCcVFDD0JFOrjflRvW6XyODgg0Dl+rHC1z7ROKEPYe3nQAJft3lUoUBmrL9Bndska8
	 FQ1897/y+TWw0308uQVzjiM6xIqGvL0dyDJAyOEpFbqPsBHTgutljd5GakEH/ZK1Uq
	 CMjKA27CKH4LRXjHcTcfBIKrgXvhC+9F6OHUb+zgcf5aHeZEx28wVfmXLJ8OOl4V2p
	 fFpd4rsrceshw==
Date: Wed, 26 Jun 2024 21:31:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Takaya Saeki <takayas@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Junichi Uekawa <uekawa@chromium.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
Message-Id: <20240626213157.e2d1b916bcb28d97620043d1@kernel.org>
In-Reply-To: <20240620161903.3176859-1-takayas@chromium.org>
References: <20240620161903.3176859-1-takayas@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 16:19:03 +0000
Takaya Saeki <takayas@chromium.org> wrote:

> To allow precise tracking of page caches accessed, add new tracepoints
> that trigger when a process actually accesses them.
> 
> The ureadahead program used by ChromeOS traces the disk access of
> programs as they start up at boot up. It uses mincore(2) or the
> 'mm_filemap_add_to_page_cache' trace event to accomplish this. It stores
> this information in a "pack" file and on subsequent boots, it will read
> the pack file and call readahead(2) on the information so that disk
> storage can be loaded into RAM before the applications actually need it.
> 
> A problem we see is that due to the kernel's readahead algorithm that
> can aggressively pull in more data than needed (to try and accomplish
> the same goal) and this data is also recorded. The end result is that
> the pack file contains a lot of pages on disk that are never actually
> used. Calling readahead(2) on these unused pages can slow down the
> system boot up times.
> 
> To solve this, add 3 new trace events, get_pages, map_pages, and fault.
> These will be used to trace the pages are not only pulled in from disk,
> but are actually used by the application. Only those pages will be
> stored in the pack file, and this helps out the performance of boot up.
> 
> With the combination of these 3 new trace events and
> mm_filemap_add_to_page_cache, we observed a reduction in the pack file
> by 7.3% - 20% on ChromeOS varying by device.
> 

This looks good to me from the trace-event point of view.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Takaya Saeki <takayas@chromium.org>
> ---
> Changelog between v2 and v1
> - Fix a file offset type usage by casting pgoff_t to loff_t
> - Fixed format string of dev and inode
> 
>  include/trace/events/filemap.h | 84 ++++++++++++++++++++++++++++++++++
>  mm/filemap.c                   |  4 ++
>  2 files changed, 88 insertions(+)
> 
> V1:https://lore.kernel.org/all/20240618093656.1944210-1-takayas@chromium.org/
> 
> diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
> index 46c89c1e460c..3a94bd633bf0 100644
> --- a/include/trace/events/filemap.h
> +++ b/include/trace/events/filemap.h
> @@ -56,6 +56,90 @@ DEFINE_EVENT(mm_filemap_op_page_cache, mm_filemap_add_to_page_cache,
>  	TP_ARGS(folio)
>  	);
>  
> +DECLARE_EVENT_CLASS(mm_filemap_op_page_cache_range,
> +
> +	TP_PROTO(
> +		struct address_space *mapping,
> +		pgoff_t index,
> +		pgoff_t last_index
> +	),
> +
> +	TP_ARGS(mapping, index, last_index),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, i_ino)
> +		__field(dev_t, s_dev)
> +		__field(unsigned long, index)
> +		__field(unsigned long, last_index)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->i_ino = mapping->host->i_ino;
> +		if (mapping->host->i_sb)
> +			__entry->s_dev =
> +				mapping->host->i_sb->s_dev;
> +		else
> +			__entry->s_dev = mapping->host->i_rdev;
> +		__entry->index = index;
> +		__entry->last_index = last_index;
> +	),
> +
> +	TP_printk(
> +		"dev=%d:%d ino=%lx ofs=%lld max_ofs=%lld",
> +		MAJOR(__entry->s_dev),
> +		MINOR(__entry->s_dev), __entry->i_ino,
> +		((loff_t)__entry->index) << PAGE_SHIFT,
> +		((loff_t)__entry->last_index) << PAGE_SHIFT
> +	)
> +);
> +
> +DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_get_pages,
> +	TP_PROTO(
> +		struct address_space *mapping,
> +		pgoff_t index,
> +		pgoff_t last_index
> +	),
> +	TP_ARGS(mapping, index, last_index)
> +);
> +
> +DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_map_pages,
> +	TP_PROTO(
> +		struct address_space *mapping,
> +		pgoff_t index,
> +		pgoff_t last_index
> +	),
> +	TP_ARGS(mapping, index, last_index)
> +);
> +
> +TRACE_EVENT(mm_filemap_fault,
> +	TP_PROTO(struct address_space *mapping, pgoff_t index),
> +
> +	TP_ARGS(mapping, index),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, i_ino)
> +		__field(dev_t, s_dev)
> +		__field(unsigned long, index)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->i_ino = mapping->host->i_ino;
> +		if (mapping->host->i_sb)
> +			__entry->s_dev =
> +				mapping->host->i_sb->s_dev;
> +		else
> +			__entry->s_dev = mapping->host->i_rdev;
> +		__entry->index = index;
> +	),
> +
> +	TP_printk(
> +		"dev=%d:%d ino=%lx ofs=%lld",
> +		MAJOR(__entry->s_dev),
> +		MINOR(__entry->s_dev), __entry->i_ino,
> +		((loff_t)__entry->index) << PAGE_SHIFT
> +	)
> +);
> +
>  TRACE_EVENT(filemap_set_wb_err,
>  		TP_PROTO(struct address_space *mapping, errseq_t eseq),
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 876cc64aadd7..39f9d7fb3d2c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2556,6 +2556,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  			goto err;
>  	}
>  
> +	trace_mm_filemap_get_pages(mapping, index, last_index);
>  	return 0;
>  err:
>  	if (err < 0)
> @@ -3286,6 +3287,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	if (unlikely(index >= max_idx))
>  		return VM_FAULT_SIGBUS;
>  
> +	trace_mm_filemap_fault(mapping, index);
> +
>  	/*
>  	 * Do we have something in the page cache already?
>  	 */
> @@ -3652,6 +3655,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
>  	add_mm_counter(vma->vm_mm, folio_type, rss);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> +	trace_mm_filemap_map_pages(mapping, start_pgoff, end_pgoff);
>  out:
>  	rcu_read_unlock();
>  
> -- 
> 2.45.2.627.g7a2c4fd464-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

