Return-Path: <linux-fsdevel+bounces-21167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564458FFD8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 09:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EED28A1B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EC51527BA;
	Fri,  7 Jun 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDF2+yqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0C15A869;
	Fri,  7 Jun 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746725; cv=none; b=IL8uv2+iUq23eNlatHu7XdUd1/I26aWX7V7i1iQTqb+6wrzUL55uK0qqCFYIoNtnGQvSihMbt3ODdI8m4P3AxpOqZ7nhVdnXZh+dfFGC+fmwjoqsfpQ3BMmnj8c1mLBpQiDeJcv5Ta3BXPih+RmK0OHkUF6PlGyio7GXlVc64J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746725; c=relaxed/simple;
	bh=gn/fI6h9C1pAG5/3ooyTbLTKOd+/BUZX7VYHZhXdeNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spCS9AVxT5ip2Uxcu10CrJO/viGEdIAw+QTGgQbNNG7mOiFUTQLcp5eZyfJRaW7kc3TZDdwyO9fIUwLwxi84iOKgHH0DaA9asZ+fOcYW5DRHMu6eG2xpNVhRL/iYP/FZUY03X1EVUOMPxWqeZ3X3X4nU9wuf/An5Nf+7ej1fzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDF2+yqQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dca73095aso1604422f8f.0;
        Fri, 07 Jun 2024 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717746722; x=1718351522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhX0elXnOul8qpEh6FTKOxypSbbABlDAy/thil42Oyk=;
        b=BDF2+yqQefzkk6kphjzXQDZe+qzK9k3JvU6y60F5UyYAJUpGYYuabm2X/H231a5xeS
         7uvS+9yNbhpWOdYr65XR4v5eSdkkSFgct5Jc3Sqimv/b0EhbRiQXJytj58u3RUB99G1s
         OJc/A51mwb/Ff4nYyc/fM6uDGXnKZrdSHf3FzF9TZRGS1U/P0rPyRrHM59sBeFOfgWsF
         +N3pt4jlg8pseflT5WAdU2Kb5P50X2wBCINC12zVJVPEVVxs4wOCqaFGWPugUycXm251
         byFBSJVwXGvL497tpez+wltFzdEQbRGWR+SQOUwPIFb9Sixh+vFYbNelmq3zjwJa9FKO
         DXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717746722; x=1718351522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhX0elXnOul8qpEh6FTKOxypSbbABlDAy/thil42Oyk=;
        b=ZtlsMcUsVDYh0TNYvVG3hI37NKiEpVzkscojKwiJayOZ46zOg3lAe0odw99kaiAbXY
         FOvjovvU/I4zqlFhuAuFeWqq8o33zHa8//IXqfQO8Z5Ajfino4peLLBUO9HGAfKdGBFF
         KapkZbZgU9oNo07QxxZ3Ulm6ro4Ria4AvvDqCmebgLJemYHqCvxgrB5ocXKd0jWQjPzO
         /lu+5WIVBNhqAJr9wydxFdyWUXMVHjauVirM0wrFu9sC4LHPgAWbTnafvRD76rquGKtU
         x6mD3DhmDJZrRBXmIYAEaJfuUyjUXybHBS64FZE/Rc3CNL6yjQptwlJab8mZuAnoFJoz
         hGfg==
X-Forwarded-Encrypted: i=1; AJvYcCVSVzbs9lvXeYJmF70wO1UQXe/+xnGROpvBvdmumK/+QgGgSZeRUnwJzvpXwt1GqSDcdKpefbPI6r7W1WAwI+qOTRugkE8y3a6jx47ICdV8zT6ksxS2odm24gSCaopf7iLg8vGXGxUimovqmg==
X-Gm-Message-State: AOJu0YwAgJZZ20c80539YxzArh1sfLZ4rR25gl4/vVHWB5/E1EF1oYfT
	vdZ3qtU8ynWkxtoC7+U1pN7yTTp3x5CiJq0n88J9xXn2qyQaTIjurC3vpQ==
X-Google-Smtp-Source: AGHT+IFg9iF/oTWeOXiIFEiNK+m4SDlsgwxzKh0cyRGOKLbgNfPK0aCpqzfgXTRg5OoGuvepK+081w==
X-Received: by 2002:a05:6000:45:b0:34d:837a:9d08 with SMTP id ffacd0b85a97d-35efedfaf0dmr1296688f8f.61.1717746721955;
        Fri, 07 Jun 2024 00:52:01 -0700 (PDT)
Received: from f (cst-prg-5-143.cust.vodafone.cz. [46.135.5.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc169fsm3393990f8f.94.2024.06.07.00.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 00:52:01 -0700 (PDT)
Date: Fri, 7 Jun 2024 09:51:51 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Message-ID: <bujynmx7n32tzl2xro7vz6zddt5p7lf5ultnaljaz2p2ler64c@acr7jih3wad7>
References: <20240606140515.216424-1-mjguzik@gmail.com>
 <ZmJqyrgPXXjY2Iem@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmJqyrgPXXjY2Iem@dread.disaster.area>

On Fri, Jun 07, 2024 at 12:04:58PM +1000, Dave Chinner wrote:
> On Thu, Jun 06, 2024 at 04:05:15PM +0200, Mateusz Guzik wrote:
> > Instantiating a new inode normally takes the global inode hash lock
> > twice:
> > 1. once to check if it happens to already be present
> > 2. once to add it to the hash
> > 
> > The back-to-back lock/unlock pattern is known to degrade performance
> > significantly, which is further exacerbated if the hash is heavily
> > populated (long chains to walk, extending hold time). Arguably hash
> > sizing and hashing algo need to be revisited, but that's beyond the
> > scope of this patch.
> > 
> > A long term fix would introduce fine-grained locking, this was attempted
> > in [1], but that patchset was already posted several times and appears
> > stalled.
> 
> Why not just pick up those patches and drive them to completion?
> 

Time constraints on my end aside.

From your own e-mail [1] last year problems are:

> - A lack of recent validation against ext4, btrfs and other
> filesystems.
> - the loss of lockdep coverage by moving to bit locks
> - it breaks CONFIG_PREEMPT_RT=y because we nest other spinlocks
>   inside the inode_hash_lock and we can't do that if we convert the
>   inode hash to bit locks because RT makes spinlocks sleeping locks.
> - There's been additions for lockless RCU inode hash lookups from
>   AFS and ext4 in weird, uncommon corner cases and I have no idea
>   how to validate they still work correctly with hash-bl. I suspect
>   they should just go away with hash-bl, but....

> There's more, but these are the big ones.

I did see the lockdep and preempt_rt problem were patched up in a later
iteration ([2]).

What we both agree on is that the patchset adds enough complexity that
it needs solid justification. I assumed one was there on your end when
you posted it.

For that entire patchset I don't have one. I can however justify the
comparatively trivial thing I posted in this thread.

That aside if I had to make the entire thing scale I would approach
things differently, most notably in terms of locking granularity. Per
your own statement things can be made to look great in microbenchmarks,
but that does not necessarily mean they help. A lot of it is a tradeoff
and making everything per-cpu for this particular problem may be taking
it too far.

For the inode hash it may be the old hack of having a lock array would
do it more than well enough -- say 32 locks (or some other number
dependent on hash size) each covering a dedicated subset. This very
plausibly would scale well enough even in a microbenchmark with a high
core count. Also note having regular spinlocks there would would retain
all lockdep and whatnot coverage, while having smaller memory footprint
than the variant coming in [2] which adds regular spinlocks for each
bucket.

In a similar spirit I'm not convinced per-cpu lists for super blocks are
warranted either. Instead, some number per numa domain or core count,
with backing area allocated from respective domain would probably do the
trick well enough. Even if per-cpu granularity is needed, a mere array
allocation as seen in the dlist patch warrants adjustment:
+	dlist->heads = kcalloc(nr_cpu_ids, sizeof(struct dlock_list_head),
+			       GFP_KERNEL);

that is it should alloc separate arrays per domain, but then everything
else has to be adjusted to also know which array to index into. Maybe it
should use the alloc_percpu machinery.

All that said, if someone(tm) wants to pick up your patchset and even
commit it the way it is right now I'm not going to protest anything.

I don't have time nor justification to do full work My Way(tm).

I did have time to hack up the initial rcu lookup, which imo does not
require much to justify inclusion and does help the case I'm interested
in.

[1] https://lore.kernel.org/linux-fsdevel/ZUautmLUcRyUqZZ+@dread.disaster.area/
[2] https://lore.kernel.org/linux-fsdevel/20231206060629.2827226-11-david@fromorbit.com/

