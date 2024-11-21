Return-Path: <linux-fsdevel+bounces-35486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003BE9D5576
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 23:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757EE1F23AEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 22:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A451DC1B7;
	Thu, 21 Nov 2024 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lnOy2h+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD41CEAB8
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228083; cv=none; b=UwtTzisaLiIDJMd7OhNwD5S6FkBi/AD/RsLkGH17CZPzGW7aZW6VCNAITB5bIabmofs/w/mDTXWJLhfWQ9pP6BJW1MQ4HpZGK5RAEfsTJzkAMAvM1k5AHZ9XVczkABxCFy//qQ9EU+A1IEJj/mcovnIUWtk5MesrsSS1GnHyw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228083; c=relaxed/simple;
	bh=3Ddf0ptq7AhGVQ1MIQ3AbFy8Hg/PZF1oUE2uUgKlOIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl588icFPSrfSTgjmB+06lgzu48rpZMcVFRhe/s51fHE6pViIQnMu2jlzt4CNMlnNXk3ncADiELbJinfKPg8eB9gl123JaWLMru598THNzUM1vLR+ygZgWBZdW+8Yfa/W4ojwe9yM3MjJxOhsvnzxN7odN46LG9u8B1W56djM78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lnOy2h+X; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eed41d2b12so9755967b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 14:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732228081; x=1732832881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONqLi4pSEc8Jt6PMueV1OM+2vzCEZq1SJbK/qfA9rM0=;
        b=lnOy2h+XZ2hk9gAkfWaJihgbGyb8Qk8nOpS3D9bYg4coUpuPDDCFRmVmAmTsp8nZAf
         awyYqP1Wgrg/pi7R++zqTf0N5/kEKTqSVoNZeHXyOYSUb7PssOCXX9Pn1BzgEQa1w0Jt
         0tx3uTC3VZODDEwBfe++EQa4SmisYCj/iLSE1xySSrSGkJzcASv6zM3D6sFtmE/E+K7t
         sPAqNUj5Q6gyN8EIAVsyI62IC/kxUqJ+viWPQOrJP7gkr/YFpst4B8KoXHgiQipYMVRQ
         7J6Ta6xNIVnWY/mR3rRhSOHW8bXuRf/WyRbF2ug4sso2nByfNQzlGKGmqiaNbgrCTS6p
         16rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732228081; x=1732832881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONqLi4pSEc8Jt6PMueV1OM+2vzCEZq1SJbK/qfA9rM0=;
        b=bi2AZcnGjX8DPP4ZSum48HvQnk4ACAgQ7JfRMqBkRdcTC8WEhkvhsbvA/7A8XwuEeh
         doienNjqQKC6Himsa77hUJ8YBltC+iNM+sVJfSjfApxJaM+1AE7SvX/7aqpkLmKhPfcA
         r4shaEoEYBd6h8IZf86cUw+0R7PnvSmkrnEXBJrg27RBwX3XWV99/YYyxhbwZdh5ldbb
         P84TW2sSuiXHOqlIh0AEa1VEZ3yVQaxgKBUo3o6OxrFW1YFpxcsfEoUx5ki3gOKDkUqk
         KkT46spMSO6H/72kohf1WP3117G3tUOREk08aDwXaGrcANTOfvob/uWDYrwfAPUD3bAF
         g2rg==
X-Forwarded-Encrypted: i=1; AJvYcCUSSaz8Y/VyHtxY1vZy7ZD8xEHkH3a2ZuMVywHHXs+g2luFbirLmTkF9uYvfXIZw5QqC7e+yICOxYOJjbIw@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZI93jh1ZIfMR7EYrkydmn9f1hx9uNqLRwgSSwR7sTsPB+tB6
	BgKnOoujOF0tYs4tomh86kF/tk8mlpofyefwXd+CAx3st7cZxDyIXWDiwTcuexA=
X-Gm-Gg: ASbGncvrHcS6jMf7/EZvTXG69DeCUAXxbUMQhxWg++znFi5oIaCJj+mZyiaCOmOXNXU
	1nDHkuusZLJmhdGp4EZCHgHKI9UebFzYAnt30EkJlRmbN66LpGtdMalh7E1sHAtXImKxoftGr/9
	AN2nvprka06y1pHtNRkzsQl56X+VnYjNlMR078BE7Bt7Bqpt+rVyT4cnKf6JLPg23Zkot7MJleb
	x2ch1DTsg6zpfSULgQg6/IcEV6Owp9NQKuwAm5Xqy2ZLRjsye3g8rXFdT5WJc0l37ymcy/38+hI
	gfdLZleaaJQ=
X-Google-Smtp-Source: AGHT+IEPMDla9InbNxqGs1pJ9IZItdme4llVA1vvXlQiUIFtdyOMUh9HEEmrqNRKmTIgfv+6grwVQw==
X-Received: by 2002:a05:690c:6912:b0:6ee:5104:f43a with SMTP id 00721157ae682-6eecd31f605mr49052157b3.20.1732228080882;
        Thu, 21 Nov 2024 14:28:00 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee2c3410bsm737937b3.40.2024.11.21.14.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:27:59 -0800 (PST)
Date: Thu, 21 Nov 2024 17:27:58 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 01/12] fuse: support copying large folios
Message-ID: <20241121222758.GB1974911@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-2-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:47PM -0800, Joanne Koong wrote:
> Currently, all folios associated with fuse are one page size. As part of
> the work to enable large folios, this commit adds support for copying
> to/from folios larger than one page size.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c | 89 +++++++++++++++++++++++----------------------------
>  1 file changed, 40 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 29fc61a072ba..9914cc1243f4 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -703,7 +703,7 @@ struct fuse_copy_state {
>  	struct page *pg;
>  	unsigned len;
>  	unsigned offset;
> -	unsigned move_pages:1;
> +	unsigned move_folios:1;
>  };
>  
>  static void fuse_copy_init(struct fuse_copy_state *cs, int write,
> @@ -836,10 +836,10 @@ static int fuse_check_folio(struct folio *folio)
>  	return 0;
>  }
>  
> -static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
> +static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop)
>  {
>  	int err;
> -	struct folio *oldfolio = page_folio(*pagep);
> +	struct folio *oldfolio = *foliop;
>  	struct folio *newfolio;
>  	struct pipe_buffer *buf = cs->pipebufs;
>  
> @@ -860,7 +860,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
>  	cs->pipebufs++;
>  	cs->nr_segs--;
>  
> -	if (cs->len != PAGE_SIZE)
> +	if (cs->len != folio_size(oldfolio))
>  		goto out_fallback;
>  
>  	if (!pipe_buf_try_steal(cs->pipe, buf))
> @@ -906,7 +906,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
>  	if (test_bit(FR_ABORTED, &cs->req->flags))
>  		err = -ENOENT;
>  	else
> -		*pagep = &newfolio->page;
> +		*foliop = newfolio;
>  	spin_unlock(&cs->req->waitq.lock);
>  
>  	if (err) {
> @@ -939,8 +939,8 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
>  	goto out_put_old;
>  }
>  
> -static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
> -			 unsigned offset, unsigned count)
> +static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
> +			  unsigned offset, unsigned count)
>  {
>  	struct pipe_buffer *buf;
>  	int err;
> @@ -948,17 +948,17 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
>  	if (cs->nr_segs >= cs->pipe->max_usage)
>  		return -EIO;
>  
> -	get_page(page);
> +	folio_get(folio);
>  	err = unlock_request(cs->req);
>  	if (err) {
> -		put_page(page);
> +		folio_put(folio);
>  		return err;
>  	}
>  
>  	fuse_copy_finish(cs);
>  
>  	buf = cs->pipebufs;
> -	buf->page = page;
> +	buf->page = &folio->page;
>  	buf->offset = offset;
>  	buf->len = count;
>  
> @@ -970,20 +970,24 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
>  }
>  
>  /*
> - * Copy a page in the request to/from the userspace buffer.  Must be
> + * Copy a folio in the request to/from the userspace buffer.  Must be
>   * done atomically
>   */
> -static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
> -			  unsigned offset, unsigned count, int zeroing)
> +static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
> +			   unsigned offset, unsigned count, int zeroing)
>  {
>  	int err;
> -	struct page *page = *pagep;
> +	struct folio *folio = *foliop;
> +	size_t size = folio_size(folio);
>  
> -	if (page && zeroing && count < PAGE_SIZE)
> -		clear_highpage(page);
> +	if (folio && zeroing && count < size) {
> +		void *kaddr = kmap_local_folio(folio, 0);
> +		memset(kaddr, 0, size);
> +		kunmap_local(kaddr);

There's a folio_zero_range() that can be used here instead of this, but be sure
you get it right, I definitely did it wrong recently and I think Jan had to fix
my mistake.  Thanks,

Josef

