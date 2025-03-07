Return-Path: <linux-fsdevel+bounces-43490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18E2A57511
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E307A7757
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 22:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ED12580C8;
	Fri,  7 Mar 2025 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2TIeNlL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E847E9;
	Fri,  7 Mar 2025 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387404; cv=none; b=qXHLWzFefrd+IjzSf7Rf95Qslh61cUvyC368FW5F3sqd0P2z9SoI8u0xiqb9JqbC9GWK4PqHvpkppPIfITeH8ndhynZYvCbqz2VOV+KPb6GafwUmgDAZVEqrYFSWC0mYzlBsOJDsWtKUSsIqsgvxNW4qsZM+gcLuaz8fpWLlQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387404; c=relaxed/simple;
	bh=SpRi4bW9b7f2WOAmR4QL3sXdG09NLH85WA9+lbQk0Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jydoNj8B0PdRvmztKAkYTMila5cXWyS6C2qZupAfx1X6mtwQcSenz+219QNCIqFNgtY96lBUVkhs7ibixq6GEAuff1NpKV+SuUUTu8eG2URfdO4AAOt7M7pyP/Rlj0t0Rub1mBzJ75DVSizYLhZqbZUFVQeU5xTiGv/+dcU5YOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2TIeNlL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so2350220a12.3;
        Fri, 07 Mar 2025 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741387401; x=1741992201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGJDZD2iZLfw/9kPMmyPtBM6Rn/+J3bPJlTz0L3sgKY=;
        b=D2TIeNlL7pTna8SyzE1iVZ3/v9u2U+vk2J7f1YHqapLHEsQPCRjZ7ij3ZLVYiW+f2J
         Ys8oBzIG7RE/v1pMAvkE8I4S99xVALXte3SAw/U7tti0a2dVrlMTBe6ERv/QKIYtx8E6
         ef7xnwGoMXIw+BEAnN1ULIpOW5/Omq+nN4x6ic6BjQZrEFyk7ZlOmFNKSrbJFJzSXwz5
         19lVBzKq5LYlxD1C0OsKblK6n67MFKbqSb2y6bAALJL2OgpHW8rcvlTftax4BC+X6i4I
         fcS9UwguZXTPdFYEaNLyShdkuR7jnkGQDX3qmxkAgXthnFjZqia+wtIHOPub4hC7zG0n
         8L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741387401; x=1741992201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGJDZD2iZLfw/9kPMmyPtBM6Rn/+J3bPJlTz0L3sgKY=;
        b=bS1ieY2xluM0oFRU3t8Kt2gGQitG4YRU3fge6eQDiNlZN+Fu4cnb4lhKn6l9nEavpW
         yRV7CZjjrSTSn8MWQ8wuz9liP1yD+KVG78Za2musef21EUYiapEQrEmWgBBqRds9qrB/
         5I3nZsQsl+KC+Fcdk1DeO1BM9QVBbzJCqQvUvjMTPSixVAHcePDRcoz/UUIZEGcsMyho
         TN3pZJC/WmoupgATnFsDFWlTehIkmHeSRPha94okDtTr53Nxpve/H5JX6q9c2ufJt6yL
         PLvFU0zajFbtinU4ximfE7mL3C0XC6WmULmXblznxBT0abByWH4PUVM4F27BfAy6fuTu
         q/0A==
X-Forwarded-Encrypted: i=1; AJvYcCVSIVY7c5QXAn7uhmepAxG4lUiP5ENH6CJgjTOnS0idlCU/cRuy96RNW6hP4dDD3897TD/rzcTaX3C86saO@vger.kernel.org, AJvYcCWKI5C3dfaOV6eXx7DS+0+vlj4JNlwk+5wrwGw17UabOr29vcf+g14gHGa4JdUYygHsJBF/VXXT1z9i1FDT@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmpF8WouFLvppryleozaSlZUh+wsQWDu/TsHzQwhDA+3+jxUs
	N5wO3HOoQ9HJwboobB7dTaMphNbeQUiXNzxssGrl8XHmkyPqWq5JjS5vhw==
X-Gm-Gg: ASbGnct8oU2vQfplr5I7bXPcSlIqgeCXmgvkSleHUIXIkP/gNuaYfhALdcWkIuO1m02
	hj2Qw4kqLl0IoT2GJydJjw+p16yN065CcZ8luf7zmH51WvR/hR6iLG7RFJzUxvfQr7pQvIE86pA
	pRv/7gnXGQFk3eT7cW+tnz0D9cUFxZ/dg8DwUUfKKyav8EOFkCXZG3ZRsJ95bBjKZEoUDeY+Y8A
	TzkFapYSE6r2wzghd0y+OO/Etg0mCbyXb+8sU5jiRvs3wlUsNBev4CG9Wdy4DGwP6zicnY+ZIlI
	5njUQUDsSpsnsrICbIe/KR52N8vl69E8haEJLOUWgc8wLDwKpWgb+N6K2S4E
X-Google-Smtp-Source: AGHT+IGqOCxNFn8sRBQioaDAX8QiHOdR5qvp9BopGimBKxwXyrgCDutjsxmFS4qGRe946P8Y104ehQ==
X-Received: by 2002:a05:6402:4310:b0:5e5:c1c4:c2ca with SMTP id 4fb4d7f45d1cf-5e5e24eb43fmr5955245a12.29.1741387401001;
        Fri, 07 Mar 2025 14:43:21 -0800 (PST)
Received: from f (cst-prg-95-226.cust.vodafone.cz. [46.135.95.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733f8aasm3094900a12.5.2025.03.07.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:43:20 -0800 (PST)
Date: Fri, 7 Mar 2025 23:43:13 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	David Howells <dhowells@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/pipe.c: simplify tmp_page handling
Message-ID: <aznlwadluqn3hpkmoe5zhsrpsybsif5wagoouhmevjwndigado@k4lbztlu23wf>
References: <20250307221004.1115255-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307221004.1115255-1-linux@rasmusvillemoes.dk>

On Fri, Mar 07, 2025 at 11:10:04PM +0100, Rasmus Villemoes wrote:
> Assigning the newly allocated page to pipe->tmp_page, only to
> unconditionally clear ->tmp_page a little later, seems somewhat odd.
> 
> It made sense prior to commit a194dfe6e6f6 ("pipe: Rearrange sequence
> in pipe_write() to preallocate slot"), when a user copy was done
> between the allocation and the buf->page = page assignment, and a
> failure there would then just leave the pipe's one-element page cache
> populated. Now, the same purpose is served by the page being inserted
> as a size-0 buffer, and the next write attempting to merge with that
> buffer.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  fs/pipe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 4d0799e4e719..097400cce241 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -508,13 +508,14 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  			struct page *page = pipe->tmp_page;
>  			int copied;
>  
> -			if (!page) {
> +			if (page) {
> +				pipe->tmp_page = NULL;
> +			} else {
>  				page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
>  				if (unlikely(!page)) {
>  					ret = ret ? : -ENOMEM;
>  					break;
>  				}
> -				pipe->tmp_page = page;
>  			}
>  
>  			/* Allocate a slot in the ring in advance and attach an
> @@ -534,7 +535,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  				buf->flags = PIPE_BUF_FLAG_PACKET;
>  			else
>  				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
> -			pipe->tmp_page = NULL;
>  
>  			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
>  			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {

This bit got reworked in https://lore.kernel.org/all/20250303230409.452687-3-mjguzik@gmail.com/

I see it is in -next, merged from https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.15.pipe

