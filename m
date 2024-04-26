Return-Path: <linux-fsdevel+bounces-17937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732858B3FCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A48128460B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD37E10942;
	Fri, 26 Apr 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7vbH2n2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DACBA46;
	Fri, 26 Apr 2024 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157879; cv=none; b=npecwVZy3wFqWvp4HgVrrogd4tQfM9cuXLcYXLTHWSH1sqh4bDe4pl2c+4nRytvw6FCCTcY8ZYMXi/fe3kzwn2Aay48CH99EWIViWnOZb3HWRErowtdZcVgxmOwD+voXYIt97oKB7IIhqjTsYNIRpZwPT8mvp7AuYHdA5V4MeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157879; c=relaxed/simple;
	bh=rNVa04kArCIAetrdCMzvBzNCXbO4LufTQuhgBwzMN2A=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=Ct1NuVroOJhRpA6W5lxzIVmvq4Vdd9fmyw6Y4j7uV5pvqrQ0UOiAKZdGbfijKP5c33TqneC9+8w7ona3bepxA2POXqkDl0iYa594GdKK9SFVCp531qOjhWsTThbAxwXCYpgS0QK+3VVPLPRFuSXT5n4eECHE2bh6dqmIdiJd/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7vbH2n2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so1864487a91.0;
        Fri, 26 Apr 2024 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714157877; x=1714762677; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zMQHwS2IWvwWEUAkWLQhsI0HjGCJs2THY8Gfq/B4iP0=;
        b=I7vbH2n22vmx/5L7zysOz/I+V2T4xuet+hP5ygqYA6UyhEkno/Um3qoM1jeK0tU0PB
         qqT+FpMzcEiBCb4141k3oAVcnpkZI0Q06ZAcWm+69oMLgyaf1A2PpsqxGV9qipT8ERqJ
         dwadLKj5XUyJzSH7id6N4WblFyhIwrwW+uZLkeXEtWIVXCBHB3sE0pY1b4jMF6lfMOCo
         yF/hJGthCLD2QgYGWcZBth3iMV/bRiSb0u0ecwUeT45Dah/lnu9BC5vunr1wQXCoBgfX
         jQFHqcjMo3RUXsULiZBmLWHVNnckg58tevZaLweCuWiTTs015yZJ0u7wTWvGS/3Ynu8B
         r2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714157877; x=1714762677;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMQHwS2IWvwWEUAkWLQhsI0HjGCJs2THY8Gfq/B4iP0=;
        b=hRfFqLRec4CduJZxxAeSMndXh5lyedfJZhHoNYLsZjZD/MSy/JRqoJWnRuw9e0W344
         6Y2SdXg+/uOhu9Rv42/0qhkfCeCKvoCjLqbKvxu90AlUinGkyUevp3JRQI5TQFzZhsBw
         ne3jxt9lwHVZ53mjtyipzKjxnBMK8Z77ETiE+BbJjJqEJMad7EAXK/4T6GJPyPwaQWJy
         ar/zocUvjQ5Erim5lPD8mna+u1WcuWgTpkjWgTK0bmA5ainOWtk5H1a517GR2y5pzmgB
         lmBQRmR2A1Psbhvp/pNP84SKPy5jglnPkQtPCNNOG4mP/535lxZEBEX9lFK+WsLGzTbV
         jq/A==
X-Forwarded-Encrypted: i=1; AJvYcCUWV/q0ipHN4G/y6qUMYPcGji1IEgWQGsS+Z8HmFUa7f0mQDItZIzXjey933LiiNuZB0Km4Sm9GlIx5lGPII3Bnt5G7JupCZgCM+9/w3N8kK+FqsjAwj9G26EfV9zfJs2sagRVkGXXpdQJjptDomYjqkF1Jkn7knQSzd5rgdzRzx+PjW+o=
X-Gm-Message-State: AOJu0YyGpX0RyFejbds/n48/SCp7ZTgW+mplBbLttL85PN1p2Zm04pi1
	/3PXbNaXzXZPofATrS1XpOR4VkRBr0vGXUCEB5kg4oGruTUPhetw
X-Google-Smtp-Source: AGHT+IF9PGpZRE8U8i4G952ehS98LOX602bLhI8I+Mu4qSNbrmD0k9sASHjp/HTWif54iTfy7lTuXQ==
X-Received: by 2002:a17:90b:124e:b0:2a7:8674:a0c8 with SMTP id gx14-20020a17090b124e00b002a78674a0c8mr711232pjb.1.1714157876905;
        Fri, 26 Apr 2024 11:57:56 -0700 (PDT)
Received: from dw-tp ([171.76.87.172])
        by smtp.gmail.com with ESMTPSA id k5-20020a6568c5000000b005f7ba54e499sm11919883pgt.87.2024.04.26.11.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:57:56 -0700 (PDT)
Date: Sat, 27 Apr 2024 00:27:52 +0530
Message-Id: <871q6symrz.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 7/7] iomap: Optimize data access patterns for filesystems with indirect mappings
In-Reply-To: <Zivu0gzb4aiazSNu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Apr 26, 2024 at 11:25:25PM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> > The approach I suggested was to initialise read_bytes_pending to
>> > folio_size() at the start.  Then subtract off blocksize for each
>> > uptodate block, whether you find it already uptodate, or as the
>> > completion handler runs.
>> >
>> > Is there a reason that doesn't work?
>> 
>> That is what this patch series does right. The current patch does work
>> as far as my testing goes.
>> 
>> For e.g. This is what initializes the r_b_p for the first time when
>> ifs->r_b_p is 0.
>> 
>> +		loff_t to_read = min_t(loff_t, iter->len - offset,
>> +			folio_size(folio) - offset_in_folio(folio, orig_pos));
>> <..>
>> +		if (!ifs->read_bytes_pending)
>> +			ifs->read_bytes_pending = to_read;
>> 
>> 
>> Then this is where we subtract r_b_p for blocks which are uptodate.
>> +		padjust = pos - orig_pos;
>> +		ifs->read_bytes_pending -= padjust;
>> 
>> 
>> This is when we adjust r_b_p when we directly zero the folio.
>>  	if (iomap_block_needs_zeroing(iter, pos)) {
>> +		if (ifs) {
>> +			spin_lock_irq(&ifs->state_lock);
>> +			ifs->read_bytes_pending -= plen;
>> +			if (!ifs->read_bytes_pending)
>> +				rbp_finished = true;
>> +			spin_unlock_irq(&ifs->state_lock);
>> +		}
>> 
>> But as you see this requires surgery throughout read paths. What if
>> we add a state flag to ifs only for BH_BOUNDARY. Maybe that could
>> result in a more simplified approach?
>> Because all we require is to know whether the folio should be unlocked
>> or not at the time of completion. 
>> 
>> Do you think we should try that part or you think the current approach
>> looks ok?
>
> You've really made life hard for yourself.  I had something more like
> this in mind.  I may have missed a few places that need to be changed,
> but this should update read_bytes_pending everwhere that we set bits
> in the uptodate bitmap, so it should be right?

Please correct me if I am wrong.

>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 41c8f0c68ef5..f87ca8ee4d19 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -79,6 +79,7 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>  	if (ifs) {
>  		spin_lock_irqsave(&ifs->state_lock, flags);
>  		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> +		ifs->read_bytes_pending -= len;
>  		spin_unlock_irqrestore(&ifs->state_lock, flags);
>  	}

iomap_set_range_uptodate() gets called from ->write_begin() and
->write_end() too. So what we are saying is we are updating
the state of read_bytes_pending even though we are not in
->read_folio() or ->readahead() call?

>  
> @@ -208,6 +209,8 @@ static struct iomap_folio_state *ifs_alloc(struct inode *inode,
>  	spin_lock_init(&ifs->state_lock);
>  	if (folio_test_uptodate(folio))
>  		bitmap_set(ifs->state, 0, nr_blocks);
> +	else
> +		ifs->read_bytes_pending = folio_size(folio);

We might not come till here during ->read_folio -> ifs_alloc(). Since we
might have a cached ifs which was allocated during write to this folio.

But unless you are saying that during writes, we would have set
ifs->r_b_p to folio_size() and when the read call happens, we use
the same value of the cached ifs.
Ok, I see. I was mostly focusing on updating ifs->r_b_p value only when
the reads bytes are actually pending during ->read_folio() or
->readahead() and not updating r_b_p during writes.

...One small problem which I see with this approach is - we might have
some non-zero value in ifs->r_b_p when ifs_free() gets called and it
might give a warning of non-zero ifs->r_b_p, because we updated
ifs->r_b_p during writes to a non-zero value, but the reads
never happend. Then during a call to ->release_folio, it will complain
of a non-zero ifs->r_b_p.


>  	if (folio_test_dirty(folio))
>  		bitmap_set(ifs->state, nr_blocks, nr_blocks);
>  	folio_attach_private(folio, ifs);
> @@ -396,12 +399,6 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	}
>  
>  	ctx->cur_folio_in_bio = true;
> -	if (ifs) {
> -		spin_lock_irq(&ifs->state_lock);
> -		ifs->read_bytes_pending += plen;
> -		spin_unlock_irq(&ifs->state_lock);
> -	}
> -
>  	sector = iomap_sector(iomap, pos);
>  	if (!ctx->bio ||
>  	    bio_end_sector(ctx->bio) != sector ||

-ritesh

