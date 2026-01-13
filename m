Return-Path: <linux-fsdevel+bounces-73415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DADFD18765
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C8B3063F7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20ED38BDA4;
	Tue, 13 Jan 2026 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chvwwTZN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="luxNOiwl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71538BDCA
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303343; cv=none; b=XFnmvMnXocAT4sWzsZQxcYylq74VV1gX6muDkcLSrhE04BLJ5IidvARcxaMl0zZ3yPsBNukRT1BSTe7AQHFnrug9kEFdxTzSmHaYAm0ZrWp8SIfy9lmpxo2pMSBIEG4Sz89uf/mxaaqP7McV4jqnYwS2oCWbekyFtR19AMK0nWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303343; c=relaxed/simple;
	bh=bGU+byuWxoKQcS0Xj3pE6Dx3kVaO+LSqxEQBS0FaCho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhRvf+Wn6w1oXkjmOszCUCdZ+mL94YH5H39KMZfGlTMrlVqvtYMijTomP3MK2IfFOvqREey2NqQ2L8Kp2h1X4gWcLYQKv0m1FyAo4Z0zjGZTeXuhhutk5OZWzWikyyX6qi12+XSwsriEG/mhF0HPllSVxlZVTgBQD8bzgrQ57O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chvwwTZN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=luxNOiwl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768303339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FM5vgtgxBBy+mCIHGqrkC14i392iYSrQOYRpquRMkP0=;
	b=chvwwTZNy8C6sZU0K6O8g0NwHo/kBJHWYTzdbfYOd7oomI7FmscpurtrOpu+Bh31BQ4RLn
	wZ7z3UtN+dmzAE3w8L9LX9xfi27hwnvqJxOSFPk4Rp/SV61JgNyL69Ly1uXsviG4mz30l0
	BikTbA7y4L2e30M/FK5Zh+lPS5lEWh8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-lenxboq9OsqKlvryUGRJIA-1; Tue, 13 Jan 2026 06:22:16 -0500
X-MC-Unique: lenxboq9OsqKlvryUGRJIA-1
X-Mimecast-MFC-AGG-ID: lenxboq9OsqKlvryUGRJIA_1768303335
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso49548505e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 03:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768303335; x=1768908135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FM5vgtgxBBy+mCIHGqrkC14i392iYSrQOYRpquRMkP0=;
        b=luxNOiwlIweRGXc+kTLyqp0GNfqOJbmZkKKvFfZA2X81LCrN067pJzfT/kPFHGNJQK
         ohzD3zjMDEgDeN75AGvQLjVvlAI7PR7x8QLgCpLzK/vB1ZXKR/bVGn019eMFJVJrDelE
         WUK0EaqKZDoti/SZh+h1JaXIxekLn0stySE7mybESZPcN+A/SJI9JO0ddjO/Zi4wQgIU
         6PQ7D3s+e3CEZx6GmNfqg47XAXxpjU87QKZUNon8DUNOrlu6s9E0qD2Y9BjyHMI6wx++
         5BnbB/BITmHpFWqOpzNNuG5piGmNyshaaoqce2IyTbzZCuy62P/lPfX3EjpXlNdCZ1ZO
         ShVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303335; x=1768908135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FM5vgtgxBBy+mCIHGqrkC14i392iYSrQOYRpquRMkP0=;
        b=R22L5bttoId7jlZowo9PQJh5GYKzo69xNEStiYgWAQImuO1ENRAPszg5SKYzvdmPCm
         Q54SfAWd8upz+RW/+Efgke10bkJnighQD+tKOFEkYy8alNDaQycjwY2/zC2yQysNatqQ
         iwWIvqfiwizxZNexeCOoY0xZxzkptaB5dKtcl0l7L6D0gWuFxTEAZVLFzZWWnxHaxEvB
         /NeIqoseWIcJFJ+ame/gVW9YdTcyieLCjSc+NlahznS82VvsTVCfyGQlPJnLxsv94eP9
         BgMG8WLtClAAGz/+g59capM2rM602EM9xicDZCv9VAxYFnqkhDKmPUc2qybhnhFOvrjx
         4KTA==
X-Forwarded-Encrypted: i=1; AJvYcCXJZENHAAkZzkDA2qVBFv6IQVHbXDjpPOEHS3+VlHa0F8mHlGw1b/YmCPOSHmxir3EBqL8MKcyB6tYdCPDu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xV4mWRLS4riFteTkvwZdatLeemb9rj8mw9KTIcKPRl3TbjrT
	bBXHXo1hM9ljHyy5WakfckEe/RC6dnqBZQBFRhJjlcu845zxSAi2jhL77O3MKnfU1+prJYKgC4a
	wILyOOvH7ugzf5kywbemqAEck5IIPUUWz3Wi4MjRSJ8oWDIHduYMeozHRy+fsYTxoUw==
X-Gm-Gg: AY/fxX4q+E3FuhvhgvFsjML5/7+iOu7vvPGoXnF1aFNEajIQu6t1s+JDtSdPoSs1cpw
	d6RwkzmyBCSxQ56BSBwxZn0avCi2bCFFJZbbiuJXENAGzWrAD9RaZCfmjmOvedm+ncCXE9lJYvj
	wZ38Kaxxjq5LirDZqkLAFOBZgAAsQpo17sUKjekX8NhKhL8TUwNyetxmEXQU4vryObXqfVHlY0m
	/7A/X7Nb7KoXk/Wv7Yoq4RqoJvWCzS+mPdM6897Dy1jB2DmjJ+ji+GZKIweA3SYbcjDfp7yshd9
	Fhm0qPlc2N4LnpBpr519kAbfGQYlNYJzP9gJimh19gBemXb2n0FxobjKKmZYG+V1V/yvYeu21Bc
	=
X-Received: by 2002:a05:600c:45d3:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-47d84b21188mr256772155e9.12.1768303335108;
        Tue, 13 Jan 2026 03:22:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGECcWxkFiiho9xlJ0D1CGOKm8pe8jEYN9Y3nhBbyrWbiKdDM0WvmxiXd/9pHeU2AaRVbQriA==
X-Received: by 2002:a05:600c:45d3:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-47d84b21188mr256771605e9.12.1768303334401;
        Tue, 13 Jan 2026 03:22:14 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47eda0e59cesm12968085e9.8.2026.01.13.03.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 03:22:14 -0800 (PST)
Date: Tue, 13 Jan 2026 12:22:13 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	djwong@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 10/22] xfs: disable direct read path for fs-verity
 files
Message-ID: <5pr72dlwyxeel5tfi55wbe4ill2bjltbqih7kypt6mg3lpzcgj@36h6uwaa4fyj>
References: <cover.1768229271.patch-series@thinky>
 <6rsqoybslyv6cguyk4usq5k2noetozrj3k67ygv5ko5fc57lvn@zv67vcnds7ts>
 <20260113082039.GE30809@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082039.GE30809@lst.de>

On 2026-01-13 09:20:39, Christoph Hellwig wrote:
> On Mon, Jan 12, 2026 at 03:51:03PM +0100, Andrey Albershteyn wrote:
> >  	if (IS_DAX(inode))
> >  		ret = xfs_file_dax_read(iocb, to);
> > -	else if (iocb->ki_flags & IOCB_DIRECT)
> > +	else if ((iocb->ki_flags & IOCB_DIRECT) && !fsverity_active(inode))
> >  		ret = xfs_file_dio_read(iocb, to);
> > -	else
> > +	else {
> > +		/*
> > +		 * In case fs-verity is enabled, we also fallback to the
> > +		 * buffered read from the direct read path. Therefore,
> > +		 * IOCB_DIRECT is set and need to be cleared (see
> > +		 * generic_file_read_iter())
> > +		 */
> > +		iocb->ki_flags &= ~IOCB_DIRECT;
> >  		ret = xfs_file_buffered_read(iocb, to);
> > +	}
> 
> I think this might actuall be easier as:
> 
> 	if (fsverity_active(inode))
> 		iocb->ki_flags &= ~IOCB_DIRECT;
> 
> 	...
> 	<existing if/else>
> 

sure, thanks!

-- 
- Andrey


