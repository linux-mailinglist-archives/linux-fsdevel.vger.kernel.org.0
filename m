Return-Path: <linux-fsdevel+bounces-7767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30E82A66E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 04:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81169283B97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6E1866;
	Thu, 11 Jan 2024 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MWF2Dpq7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74415A1;
	Thu, 11 Jan 2024 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=k1Ho/05+osX5yBSt3dsuOnnijSKuAo5CebqXC420Q7U=; b=MWF2Dpq7Y6wltSXPDDINajcI5z
	GhKGOIHtn/iLM+LJ31ocb50G/zGRv9WgoBOdPN1TOs8JykLCj8Gl9i6djrIYjtQqas8MjVYXPV0Aq
	GV3HqHmZZEknI5KXH+mzG2SSyiJ8KsqyI7C03URgKjcGhZ9XT7UpQkKhJKP00wIP9cqBM4sbORtNc
	xpXLLhh7oo2SJfj8gMZuYuCq47n0a8Hbj7Dcsg1AkLcRT4fFe9YZYapYiTpSWeIhmSs226DK/EE4K
	DThCQgo5w0AKIpDk9oU4dL36zaeM2RIC3A+ZmqRgriedyiHl+T7jCwTkruDtW9jHj1Oif59TTPvUp
	9u/kWvSQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNleL-00FbcJ-1o;
	Thu, 11 Jan 2024 03:22:33 +0000
Message-ID: <55680bae-966a-4a31-85f9-9ca516b80145@infradead.org>
Date: Wed, 10 Jan 2024 19:22:33 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] buffer: Add kernel-doc for try_to_free_buffers()
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240109143357.2375046-1-willy@infradead.org>
 <20240109143357.2375046-4-willy@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240109143357.2375046-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/9/24 06:33, Matthew Wilcox (Oracle) wrote:
> The documentation for this function has become separated from it over
> time; move it to the right place and turn it into kernel-doc.  Mild
> editing of the content to make it more about what the function does, and
> less about how it does it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/buffer.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 071f01b28c90..25861241657f 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2864,26 +2864,6 @@ int sync_dirty_buffer(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(sync_dirty_buffer);
>  
> -/*
> - * try_to_free_buffers() checks if all the buffers on this particular folio
> - * are unused, and releases them if so.
> - *
> - * Exclusion against try_to_free_buffers may be obtained by either
> - * locking the folio or by holding its mapping's i_private_lock.
> - *
> - * If the folio is dirty but all the buffers are clean then we need to
> - * be sure to mark the folio clean as well.  This is because the folio
> - * may be against a block device, and a later reattachment of buffers
> - * to a dirty folio will set *all* buffers dirty.  Which would corrupt
> - * filesystem data on the same device.
> - *
> - * The same applies to regular filesystem folios: if all the buffers are
> - * clean then we set the folio clean and proceed.  To do that, we require
> - * total exclusion from block_dirty_folio().  That is obtained with
> - * i_private_lock.
> - *
> - * try_to_free_buffers() is non-blocking.
> - */
>  static inline int buffer_busy(struct buffer_head *bh)
>  {
>  	return atomic_read(&bh->b_count) |
> @@ -2917,6 +2897,30 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
>  	return false;
>  }
>  
> +/**
> + * try_to_free_buffers: Release buffers attached to this folio.

preferably s/_buffers: /_buffers - /

> + * @folio: The folio.
> + *
> + * If any buffers are in use (dirty, under writeback, elevated refcount),
> + * no buffers will be freed.
> + *
> + * If the folio is dirty but all the buffers are clean then we need to
> + * be sure to mark the folio clean as well.  This is because the folio
> + * may be against a block device, and a later reattachment of buffers
> + * to a dirty folio will set *all* buffers dirty.  Which would corrupt
> + * filesystem data on the same device.
> + *
> + * The same applies to regular filesystem folios: if all the buffers are
> + * clean then we set the folio clean and proceed.  To do that, we require
> + * total exclusion from block_dirty_folio().  That is obtained with
> + * i_private_lock.
> + *
> + * Exclusion against try_to_free_buffers may be obtained by either
> + * locking the folio or by holding its mapping's i_private_lock.
> + *
> + * Context: Process context.  @folio must be locked.  Will not sleep.
> + * Return: true if all buffers attached to this folio were freed.
> + */
>  bool try_to_free_buffers(struct folio *folio)
>  {
>  	struct address_space * const mapping = folio->mapping;

-- 
#Randy

