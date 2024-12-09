Return-Path: <linux-fsdevel+bounces-36726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00E9E8B89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 07:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDFB2818EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A6D171652;
	Mon,  9 Dec 2024 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD5Q8BpB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5F14E2CF
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725995; cv=none; b=flDOYxcN02vmkr7foDbMSTV7kaRZbtfA1HlHFmKBa/TTPWRV5dBrFKXIpxyjOz2pZAF9DK+l/7dhIe7ZPH3TFszjHJdOZJ6QmV7fF+bqV1bWIZtkc7/MWmnAHY2X+UiDSZoMT0HWsO8NOm/I3uz6hvz+bIjBIV74xzkMrJ0xMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725995; c=relaxed/simple;
	bh=v5lqSpaik8NNl/iCzLIGkpDML++bCHAXy3UgahCcrEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfpPAwUp1xM+Z5hlkschvP9FE3omn8tZgLCFT0gg03Ho75mSppUpayvOtYrsfebXREUnWWdT6nrPU5TBMAvgn0LAOlS6URdNFeRLYriVtMgZ9eHKc8bc5T37yHrR2Yd1MGMLv7Iritl6Eq3Hk+D3ln+kzcybX5CarqIucnybyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD5Q8BpB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a68480164so531859966b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2024 22:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733725991; x=1734330791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOk+oIrlKS7EPSal9AooL3XoldFT+tr0Q8LxBWhuiKg=;
        b=KD5Q8BpBrW572RWLWlxuSgUfx9EtsB+lvbKb2Zh4nfAVMj+HMNSzagQW30Cbcn3DkF
         xh7hfyWLF7CFFO60dDqyXef3RSeYQH8HvjeRgFgnOwhqDGYWtVO0lc+mFK7ZYO1BQT1+
         RItN3Xt8QNEGjM6r+CaC+w0K0kfyhvLyOulshAYPpVJaW8KzriRqeceKsfMBXCnRZrEN
         OjoRGR+XfbZ7wG6NiTjQAFRucXStHlTtTgq/b1JEgojzuraawwb6owjzArXMEZ50CXIf
         V4z++TqwQ7D7atRaL9izchlkvFK/jJ81TGn8XWY9h+vgIdQPAv4fUk17QWTaLYFQe1Fk
         1Lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733725991; x=1734330791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOk+oIrlKS7EPSal9AooL3XoldFT+tr0Q8LxBWhuiKg=;
        b=Tf5cC4unLSzP3Z+qpEE4fifwfxmPCcL8CqGCmwsbF692TcpAw9uG/I1saGeiOjQs4O
         il950KHU8bwgowDte0/hZfeeOgcvf9V1FSQNaZfPSipSw6i7rSXhiWsKbu8Qtwa7Fp8N
         8lEoAjcDo8I+Dw+zDtm0NSKoa+0eXDqQRlV8vdNBF3FBpXsCPkY5t0Q/K1i/6W2IxJ9Q
         Xx4Or21aLvmIJlLMFUOBSddguVhvD/L8jjpPx4Q6kj3KsO3lTNBvYX+1HogFiY24qXFF
         5aMzV9rnsAeElEmzj73emH2aNxDuTTD458oVYAvUV/ALl60EzNrMjMkT77OXsA6xPt1F
         6+nw==
X-Gm-Message-State: AOJu0Ywy3VQ44/4XaTZRDpXB/iJpFKb2Z+sEyUT+jXb+m2dK/yIBRgsU
	DcdI4saaaG1lRGslo7SOj7ibRraxZXD6kf227871/GYHD1zt8b4W
X-Gm-Gg: ASbGncsTwf5KjZGvr/YvZVbTkDWRQSTgDQEIuQkqh2ld7xZ5M1fY+oeV32mLZuidSsG
	BSfw4+R3epv3FVl10reSTyIH0WljSFt6THPQL3CvKcoIMcQVW0nqIj1FPN7PqyRLQC5WVZ0I7yy
	EKxtk9FiAAtHoxYHtAtlZAXY60XKVh+zjbFU58pH7kM9+oMlgR9+O+6Q1sYWldVe/nRw809BX+8
	ENOISL/5z2oEjw6JPODjASUyLcnn33RSmvVQ6iIWbjF/3GP7vYsFXiAUM2/tCEKrw==
X-Google-Smtp-Source: AGHT+IEREtB790RTuKm4qw/wGq328tdKHyj6YFrN2iB4XxoAWMJGb9uKtBmbSt73AxOubWs7qjzZ/A==
X-Received: by 2002:a17:907:784e:b0:aa6:800a:1294 with SMTP id a640c23a62f3a-aa6800a1b9cmr334462666b.11.1733725991300;
        Sun, 08 Dec 2024 22:33:11 -0800 (PST)
Received: from f (cst-prg-82-171.cust.vodafone.cz. [46.135.82.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6701b08c2sm241537766b.124.2024.12.08.22.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:33:10 -0800 (PST)
Date: Mon, 9 Dec 2024 07:33:00 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <gopibqjep5lcxs2zdwdenw4ynd4dd5jyhok7cpxdinu6h6c53n@zalbyoznwzfb>
References: <20241209035251.GV3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209035251.GV3387508@ZenIV>

On Mon, Dec 09, 2024 at 03:52:51AM +0000, Al Viro wrote:
> There's a bunch of places where we are accessing dentry names without
> sufficient protection and where locking environment is not predictable
> enough to fix the things that way; take_dentry_name_snapshot() is
> one variant of solution.  It does, however, have a problem - copying
> is cheap, but bouncing ->d_lock may be nasty on seriously shared dentries.
> 
> How about the following (completely untested)?
> 
> Use ->d_seq instead of grabbing ->d_lock; in case of shortname dentries
> that avoids any stores to shared data objects and in case of long names
> we are down to (unavoidable) atomic_inc on the external_name refcount.
>     
> Makes the thing safer as well - the areas where ->d_seq is held odd are
> all nested inside the areas where ->d_lock is held, and the latter are
> much more numerous.

Is there a problem retaining the lock acquire if things fail?

As in maybe loop 2-3 times, but eventually take the lock to guarantee forward
progress.

I don't think there is a *real* workload where this would be a problem,
but with core counts seen today one may be able to purposefuly introduce
stalls when running this.

>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b4d5e9e1e43d..78fd7e2a3011 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -329,16 +329,34 @@ static inline int dname_external(const struct dentry *dentry)
>  
>  void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
>  {
> -	spin_lock(&dentry->d_lock);
> +	unsigned seq;
> +
> +	rcu_read_lock();
> +retry:
> +	seq = read_seqcount_begin(&dentry->d_seq);
>  	name->name = dentry->d_name;
> -	if (unlikely(dname_external(dentry))) {
> -		atomic_inc(&external_name(dentry)->u.count);
> -	} else {
> -		memcpy(name->inline_name, dentry->d_iname,
> -		       dentry->d_name.len + 1);
> +	if (read_seqcount_retry(&dentry->d_seq, seq))
> +		goto retry;
> +	// ->name and ->len are at least consistent with each other, so if
> +	// ->name points to dentry->d_iname, ->len is below DNAME_INLINE_LEN
> +	if (likely(name->name.name == dentry->d_iname)) {
> +		memcpy(name->inline_name, dentry->d_iname, name->name.len + 1);
>  		name->name.name = name->inline_name;
> +		if (read_seqcount_retry(&dentry->d_seq, seq))
> +			goto retry;
> +	} else {
> +		struct external_name *p;
> +		p = container_of(name->name.name, struct external_name, name[0]);
> +		// get a valid reference
> +		if (unlikely(!atomic_inc_not_zero(&p->u.count)))
> +			goto retry;
> +		if (read_seqcount_retry(&dentry->d_seq, seq)) {
> +			if (unlikely(atomic_dec_and_test(&p->u.count)))
> +				kfree_rcu(p, u.head);
> +			goto retry;
> +		}
>  	}
> -	spin_unlock(&dentry->d_lock);
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(take_dentry_name_snapshot);
>  

