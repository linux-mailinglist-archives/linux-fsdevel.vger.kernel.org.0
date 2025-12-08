Return-Path: <linux-fsdevel+bounces-70968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23309CACE5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 11:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35883058A7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4B63112BB;
	Mon,  8 Dec 2025 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LYvaMf7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3812C3245
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765190285; cv=none; b=h7/dyEWVCu3JXMY5LlWglrscJ18KhaWKztdEy9DnNT0RqFDA/iLR/QWhIoiSSPRSed/N6u7747NDDTeSuXbtrOw01nuvvrpIjPSFZxjrN4xCvk5p6cei9qpfEEI7vvrzoRzEZr3iPZO/paZSFA+HXOF18JkpgHrAcIxBVOjDbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765190285; c=relaxed/simple;
	bh=Xvvt8aKdidrti/qa89kFkr6EkHjNN1pen1zb3pQqB4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJtpC1BsU3JEBaVPp1IXluplKvhYKGQwf31P9nL1yfHKcmOUJPEWTAbNuAwLEX5lFOhPJy6WFV9fn986xGS2H55k52L/F9bXC8HW2/LhRPVv2fBx3VDysbrk3wnsDIw9pi1+uGyPXS1mV44X1SXa5Fzk9RdsnGreD43a/NAUAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LYvaMf7Y; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-882475d8851so47302986d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 02:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1765190280; x=1765795080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lZo8B9ULqod5NnS4ElHd54HKG220+4mWWIm9CYg8r2g=;
        b=LYvaMf7YFYcJjcKerC2SgATcM/W1v5sUEWvasiB6eMrHPLaebDFk1NBUUi4JZEN3as
         VUw0xNpHxleCtWrktI5CUAKsFRshLOcBpxRF2DwW2CWoCmdaWc6TV4pGhCYFa5Cxd+pn
         W+uVvMYZBFiSZfvuQ8aasVswRxtIVYecqVrbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765190280; x=1765795080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZo8B9ULqod5NnS4ElHd54HKG220+4mWWIm9CYg8r2g=;
        b=OtqCXQ6V5eVt1/srHBQGyLwtrqO2CcfZH8VStazBFRKLceybTVexpBxNfvgz80OAiQ
         UxstmfAJgKZk/JDdy/g3Uamej9knStKFKm+29ro4jPkRIFdYUnbrCTFhJWl6AOXW0F4V
         O23sJXW8sfZQ+3HxuJozNn7kvHdq6a227RK0xE5UeJRGEq9C5qBNuo+eccBEusPAL4Qq
         U3kILHxcDf1EZsmQPS0U7mjTDKxJMqZ+hYT9TLERScSHUgm3whVI46Xfund5V7SOAsiR
         6X0nYLq56tbfgL4djxV5h9JCMcl2mxkAFIAj7LbL9baV4oL9A+rYqFC8jDsqwepQEiE2
         YhUA==
X-Forwarded-Encrypted: i=1; AJvYcCV7bxn86iV9Nbkl18pWKxkOjAe46YGmUHS4Qp/9NQe1dwd22f4aA7a0pHeP68wg9hp9oMWCQA1ZJHuNPYQA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VfZyV5w8ee01rhmFPQqN/LVul2YHuuYUU26fTfC4epjITDfG
	qozcyDnrwiTzCQv88APHEzLH2WQ+Jsl190Ur/2mGuusFG6vU6IJnrToHqpsEA0aDKNxXE8/Ld8a
	ZQbAr7FhqFjmGwVDdf+Wv+kO844XH3QeoOT653a+IyhfB0D7UsZbzhqQ=
X-Gm-Gg: ASbGncvR1w7PPbJvQhVSp63dEFKhcV2mJ4hS91o8BBTCj4Qw6NHJYT7VFRIMq8phBEK
	UDSH5YRw6+VIlnnfv9ND2XaBZBSGWpMLQZbXglBCcnp9MYedpQFncZp7bbtb6kaAh2kr+OGHZzt
	h4zAr+/uDH7pxyEtmUMJ7aNY6+rfKSQlXKiwB6TFNeOv2sPdkziFgrL16l1gsjY2SdFVdl30B+I
	/hJp8iGT6QPrS1t1EKo2Dc5jDgE9jSZ862t+lTaDSik1A4jYg0XVOVBH1hz23+GrqevtwZchPTY
	Nvx3HA==
X-Google-Smtp-Source: AGHT+IH94LlwYr2MFSyVR0eLC2QTrQehcD5Z16OdTi2V0mzUQn+OPTF2in3P8sEYNasRzJm8yaxBrg/HmF+L9dcLGeA=
X-Received: by 2002:ac8:7f92:0:b0:4ee:18e7:c4de with SMTP id
 d75a77b69052e-4f03ff21864mr111081001cf.78.1765190280241; Mon, 08 Dec 2025
 02:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV> <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV> <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
 <20251206035403.GR1712166@ZenIV> <20251206042242.GS1712166@ZenIV>
In-Reply-To: <20251206042242.GS1712166@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 8 Dec 2025 11:37:48 +0100
X-Gm-Features: AQt7F2pJ6xxoGZFzQN2bUbCjl7yWmAbff_gnzdrNr9tIYZ5RK3rHaUcbj67WI7c
Message-ID: <CAJfpegvpy+6PR36LNFJ7rEmXQugJZ3U=gjERbXnGjFvjUCfdPA@mail.gmail.com>
Subject: Re: [GIT PULL] fuse update for 6.19
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Dec 2025 at 05:22, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Dec 06, 2025 at 03:54:03AM +0000, Al Viro wrote:
> > On Fri, Dec 05, 2025 at 07:29:13PM -0800, Linus Torvalds wrote:
> > > On Fri, 5 Dec 2025 at 18:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > Sure, ->d_prune() would take it out of the rbtree, but what if it hits
> > >
> > > Ahh.
> > >
> > > Maybe increase the d_count before releasing that rbtree lock?
> > >
> > > Or yeah, maybe moving it to d_release. Miklos?
> >
> > Moving it to ->d_release() would be my preference, TBH.  Then
> > we could simply dget() the sucker under the lock and follow
> > that with existing dput_to_list() after dropping the lock...
>
> s/dget/grab ->d_lock, increment ->d_count if not negative,
> drop ->d_lock/ - we need to deal with the possibility of
> the victim just going into __dentry_kill() as we find it.
>
> And yes, it would be better off with something like
> lockref_get_if_zero(struct lockref *lockref)
> {
>         bool retval = false;
>         CMPXCHG_LOOP(
>                 new.count++;
>                 if (old_count != 0)
>                         return false;
>         ,
>                 return true;
>         );
>         spin_lock(&lockref->lock);
>         if (lockref->count == 0)
>                 lockref->count = 1;
>                 retval = true;
>         }
>         spin_unlock(&lockref->lock);
>         return retval;
> }
>
> with
>                 while (node) {
>                         fd = rb_entry(node, struct fuse_dentry, node);
>                         if (!time_after64(get_jiffies_64(), fd->time))
>                                 break;
>                         rb_erase(&fd->node, &dentry_hash[i].tree);
>                         RB_CLEAR_NODE(&fd->node);
>                         if (lockref_get_if_zero(&dentry->d_lockref))
>                                 dput_to_list(dentry);
>                         if (need_resched()) {
>                                 spin_unlock(&dentry_hash[i].lock);
>                                 schedule();
>                                 spin_lock(&dentry_hash[i].lock);
>                         }
>                         node = rb_first(&dentry_hash[i].tree);
>                 }
> in that loop.  Actually... a couple of questions:

Looks good.  Do you want me to submit a proper patch?

>         * why do we call shrink_dentry_list() separately for each hash
> bucket?  Easier to gather everything and call it once...

No good reason.

>         * what's the point of rbtree there?  What's wrong with plain
> hlist?  Folks?

The list needs to be ordered wrt. end of validity time.  The timeout
can be different from one dentry to another even within a fuse fs, but
more likely to be varied between different fuse filesystems, so
insertion time itself doesn't determine the validity end time.

Thanks,
Miklos

