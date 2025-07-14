Return-Path: <linux-fsdevel+bounces-54897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AB2B04AFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 00:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2636E3B6749
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 22:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ADA27780E;
	Mon, 14 Jul 2025 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC7J3Xn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB022E3FA;
	Mon, 14 Jul 2025 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533335; cv=none; b=hCZ3bx3ETrKbaKYSVWATGmjzccVv7lKmMMYD61f/pQZIrxha+dTWwGbDk8rcPBN/secybyQIMLFQih3ZqJ2d+pHPQdgoR8uTJj5jnN3axR6XeG3Xss+/N1Fn2Y2S4QLPlw8d8V9Ue06KHn/FIUBRyCj1rLPIZ2bfCvGSypSR3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533335; c=relaxed/simple;
	bh=mCGqSvO96GNTrlQhZgG2zQIiLUg+WWEq3WuU7DOz20s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUU5lAGSMmumPKG+VmqOuhLL3XyGyaCUeBaHN0wlyYtqdsdFGkpHOLOzXbx8/dj9ghruTxF7Mr9s7ChmuoHb5f/NIXRUWvGHLbJd/LOrxm5vOKAmATDMaMuXMLrBKPnKPRjfV6XgNe2CEBNIm9gLeDY/kikHiaHncEIwdpKopS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC7J3Xn/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso5355003e87.0;
        Mon, 14 Jul 2025 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752533332; x=1753138132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T92uQF0Sbtu86irFu+lw6khoAaH7Wb2TKMFFWqJI07I=;
        b=XC7J3Xn/MsewEl3BWwMplsLQxmmhOsR7oAuEHe2dydr+Y1LBAxwZ+DxhGqLTb90cXG
         LR8WZw9NOKRn5cACBKMYJIksFNG75p8+K813ycCNyNBIN/l2mfA+iKzDUicHXoYG0Oaj
         3Xr6tRRw51Il/HG2oT9HGkVGeHsO5cNJ95cqNgBFFWxyjfowNJ69F69lgs3BJMaLnU4j
         nWAx7QMFmsdqFHUT3Zu8bLWd14YjEee04OU3DsgJbVoU8cN2fpHcJjVawFh6pSZiIZ5Q
         S35hLRjRgIu8DUL39UQp0gnO1fiZBUNK8AhHoV2AtI1y26qwbT3Dz3/ZnfxWPc8Hkdp3
         c2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533332; x=1753138132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T92uQF0Sbtu86irFu+lw6khoAaH7Wb2TKMFFWqJI07I=;
        b=AxKuuZrGtisygygydNVhnzIG3DFVDE4uff1kR/TfVW1u+oZrI4arOhLpza2HMmXRlP
         6rzlFzeKsx3G31BO5Ow8mwo77QkNiCrpiL/nmp6gfm08JKR0QBBnLJGCNI32kEQa1BRX
         13XPC+yigfkSWZdKoSVQ0ojazxaUtrYDrAccUnjOL45McneXQR/pEYVGG8yaERJJsWU8
         +z3CIZmEOdlqV8SSrDyVgB9JOOIcspasJ2LqshqiOHFuv/uj1Ux+lai5t0CrEXEvVo7Q
         Ff+Xu00iOx4mX8+vH6tl+YvVHSBEV6XwVdvbxVlkHYtbT3TwCtgOoAcU8Of5F3pLtVak
         RMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1YNW0XLNekdq4Y85X2TBvO0vAza/CHs6xwoJM2xL0elHeEAs/Y5jDVE8Z6ZTZRqk9TWg6zJkIrbf2OLbd@vger.kernel.org, AJvYcCVsS6ZeWUBiWbMdZymX3CTtyI2L8lBIj9+Omlq4uEBNAKjw/ExsGkijeO5waA+E8HWTHUikCTY/L9OLIXZX@vger.kernel.org
X-Gm-Message-State: AOJu0YwLuhRR1jB5PdVYK7TAt2xoW7V9qseeWcj7VwGd2iL4nAuB301h
	UpsS/cZLlLA/R3NdcRcSwW8NA6WVhS2a5AuCZt6XFefPTUwntlPI08iG
X-Gm-Gg: ASbGncs0b7251QGGKXAMlmZxnOarW8+cZlzldOc5/LIc8CfHzZniYj3ibb/XRae4i3R
	d8HfLs6s1GHy+XloihwmPKdS0sTw1wuvOJr1ZA0eIms7SA4BSHGV2H8hK5xtytVcYB6Uaev4zhy
	d/izxDY7G1BGUQKqqfnB6lcsW/ndEVyNGNLFEEjpu48DjDRh5TxncrBLZjf/5sm1L5D3MMWSntP
	nHhjoj/D8AeJDDhJv6TnQdWxkrMievZo/cO7TPvku9tELM92poDKJjOOjKdXUz9tMNrDbj0M9VO
	Y2E1QFgDhgy/U8npJY0uAAio1/FOhAS5fOgunVTeKw1Dd4lCoK2FkTQK+TXDkvI8TQsxZ/OzHcU
	iYAmnHB9ceKNKdvR9aL4qwbqSHRqj1e9Vlvkjoks/DdZMY7oc
X-Google-Smtp-Source: AGHT+IGBUSppvNFOdCzI9M0WJqy9nhMbI/cp4rl4D8ZljJ9yckzvVxpPP3lre5cM+jmiZNJbUr8xUw==
X-Received: by 2002:a05:6512:2316:b0:553:35ad:2f2d with SMTP id 2adb3069b0e04-55a044cc87bmr4115868e87.18.1752533331307;
        Mon, 14 Jul 2025 15:48:51 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55943b8c5absm2085832e87.257.2025.07.14.15.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:48:50 -0700 (PDT)
Date: Tue, 15 Jul 2025 00:48:50 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Youling Tang <youling.tang@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, chizhiling@163.com, 
	Youling Tang <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
Message-ID: <7weonxk3sdq4ysipns5mnv2lmqlb5froca3cblv7ndkv3gzsf7@ncs2qp22tg55>
References: <20250711055509.91587-1-youling.tang@linux.dev>
 <yru7qf5gvyzccq5ohhpylvxug5lr5tf54omspbjh4sm6pcdb2r@fpjgj2pxw7va>
 <20250714154355.e27c812d71b5968bdd83764c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714154355.e27c812d71b5968bdd83764c@linux-foundation.org>

On 2025-07-14 15:43:55 -0700, Andrew Morton wrote:
> On Tue, 15 Jul 2025 00:34:12 +0200 Klara Modin <klarasmodin@gmail.com> wrote:
> 
> > iocb->ki_pos is loff_t (long long) while pgoff_t is unsigned long and
> > this overflow seems to happen in practice, resulting in last_index being
> > before index.
> > 
> > The following diff resolves the issue for me:
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 3c071307f40e..d2902be0b845 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2585,8 +2585,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
> >  	int err = 0;
> >  
> >  	/* "last_index" is the index of the folio beyond the end of the read */
> > -	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
> > -	last_index >>= PAGE_SHIFT;
> > +	last_index = round_up(iocb->ki_pos + count,
> > +			mapping_min_folio_nrbytes(mapping)) >> PAGE_SHIFT;
> >  retry:
> >  	if (fatal_signal_pending(current))
> >  		return -EINTR;
> 
> Looks good, thanks.  I added your signed-off-by (which I trust is OK?)
> and queued this up.

Thanks, that's fine:
Signed-off-by: Klara Modin <klarasmodin@gmail.com>

