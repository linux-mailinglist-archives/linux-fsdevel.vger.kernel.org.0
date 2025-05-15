Return-Path: <linux-fsdevel+bounces-49159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89539AB8A82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA267A967F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C842D2135A0;
	Thu, 15 May 2025 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qRwOy3ik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DA18FC91
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322591; cv=none; b=Hya7YjPXG/TveDS2t85/3p9tdSAqzyEyQiWL4UuGxazjWth0wYwWFiIE4xYviYaiaAWlJuPb+NoozwcQuK39UPPQzBBkArIi3TnxjOdUFoOzJsZy1K/mGmcIDuvM9/4bigbCVddUfJmLrqj4PD2Brh0n+lL1cCzWdQQQ8mhe2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322591; c=relaxed/simple;
	bh=iX/hfsdNbDs75dPnMzxI/Jp2NbdgDm9MIxeRjNIMuJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTz1cPaWCaOrj27AYl5oI57eW6niv5lT1LYQuXbCe0wlFupKmoe/rBFpQJnWy09nAoDayqWMyrDmrVfuzahER9K4A8GNp6bT0tEgaw19GAs4Sys2ROzESpXjyYIqng490FipQG/9/M3d7vDrGtFD1eqeZm1QkRi+zO0INAu3CEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qRwOy3ik; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-477282401b3so12070361cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747322588; x=1747927388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qtlNrN60AyNV/W51eFIs+y/ua/z2ZSiWEQSXpmuVGZQ=;
        b=qRwOy3ik+MwFLqlIVPace3f6yIwxsseSdJ/6NxFLzv+Ak3282WDPc2X2r+dwEHV5Og
         6F/r92fBFgd4gQRpo4BOgrFOjr56EbHGSY3jcqYknbkRnDeNDfFv44RDWkACAzF1VBnB
         GCKa4wCTWuevgwR9niI/5HUgau+GdHduS4OCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747322588; x=1747927388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtlNrN60AyNV/W51eFIs+y/ua/z2ZSiWEQSXpmuVGZQ=;
        b=e9IEASz1hz/OTMoZhy3nR5Oy+JOVOUSOWKYpm82RTyTNCSkkmyvNqzJEvOJt75tjmw
         2eUhURQmxbSeXqr7m7uKcOtbzAn4vt9U//AhdJRkXcXqeIHdQetXjuAjxESyvv3lR2E1
         22qNJSo114Sdr85Jp1YWKg1C12+Vqw2mnisbmqYptf9vN0It2iaiNPq78QtfWbZwESc9
         LeJ9A3vcZdjmPUl/UODZyhco2mxHUOuhZO40nJQgKBbgw5PYSRTFzySDyxrM96Zdugg9
         HKV8/1P0Od6Yrz2kcb/BrxNDAcg6850pngkevL/T8/XAE5eYXlgXGmZ93X8BvHCVdakZ
         boXQ==
X-Gm-Message-State: AOJu0YzTBgVYz55zh1IYsQPZymvG0crJajxK/7wl+PoCkfUpLL2L9jvL
	TdPpfvT1tUArn+jSdF5z2sy4RuXB0LZ6V2+EXh1+uNWDs/AM5XPno+8EkeyljIDN1p9J+CRfBYD
	Eg4nuObNkvijds5LSZW0SylLDml6Dse0JeqtLqw==
X-Gm-Gg: ASbGncu50hQ0EptYJJoZRR/7c69AXbg8myG5bycz6/mo+rOi0ntluArZfra43A7qVZN
	Rs26p5664qrHvpPDEzA1drqU0WxSw+lk9B6uIAj7JmKlMPW4LZPtvUZ3HsjwD1MiGGkXxoCBQrV
	jjeB0sxLCEqUoGGv4v6+irIezGC+UdJmM=
X-Google-Smtp-Source: AGHT+IE+6fPN/G6kUSfVQcY7KxD6pEaZVKhAbKZtgdYGY1uJaeMTT9BlyrDA23fQBKOC3oN4zHZvU1Q36Zx5VULCEYc=
X-Received: by 2002:a05:622a:550f:b0:494:a4bc:3b4d with SMTP id
 d75a77b69052e-494a4bc3e86mr55479401cf.18.1747322588216; Thu, 15 May 2025
 08:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <vmjjaofrxvwfkse7gybj5r4mj2mbg345ganq3ydbzllees7oi2@uomtwdvj6xcd> <CAJfpegs-umW78v6WzX-4_2DkMLzdoFX=BY5Jp7P+QR+m62TEiw@mail.gmail.com>
In-Reply-To: <CAJfpegs-umW78v6WzX-4_2DkMLzdoFX=BY5Jp7P+QR+m62TEiw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 May 2025 17:22:57 +0200
X-Gm-Features: AX0GCFuDV9SMKIemzPWZeNWwo2edr51FeRrGAc-YGNzkI-f2qI7lEJXskuv3X88
Message-ID: <CAJfpegsWWFqQriC5k859=AYK3C0ingNZ2_KpoMFKMpXkucKEYQ@mail.gmail.com>
Subject: Re: Machine lockup with large d_invalidate()
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 17:15, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 15 May 2025 at 16:57, Jan Kara <jack@suse.cz> wrote:
> >
> > Hello,
> >
> > we have a customer who is mounting over NFS a directory (let's call it
> > hugedir) with many files (there are several millions dentries on d_children
> > list). Now when they do 'mv hugedir hugedir.bak; mkdir hugedir' on the
> > server, which invalidates NFS cache of this directory, NFS clients get
> > stuck in d_invalidate() for hours (until the customer lost patience).
> >
> > Now I don't want to discuss here sanity or efficiency of this application
> > architecture but I'm sharing the opinion that it shouldn't take hours to
> > invalidate couple million dentries. Analysis of the crashdump revealed that
> > d_invalidate() can have O(n^2) complexity with the number of dentries it is
> > invalidating which leads to impractical times to invalidate large numbers
> > of dentries. What happens is the following:
> >
> > There are several processes accessing the hugedir directory - about 16 in
> > the case I was inspecting. When the directory changes on the server all
> > these 16 processes quickly enter d_invalidate() -> shrink_dcache_parent()
>
> First thing d_invalidate() does is check if the dentry is unhashed and
> return if so, unhash it otherwise.   So only d_invalidate() that won
> the race for d_lock is going to invoke shink_dcache_parent() the
> others will return immediately.
>
> What am I missing?

It's it's an old kernel (<4.18) it might be missing commit
ff17fa561a04 ("d_invalidate(): unhash immediately")

Thanks,
Miklos

