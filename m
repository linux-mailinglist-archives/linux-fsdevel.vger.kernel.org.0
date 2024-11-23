Return-Path: <linux-fsdevel+bounces-35625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43FC9D67A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 06:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77563282416
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 05:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AB9165EFC;
	Sat, 23 Nov 2024 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ns4roqSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68E2AEF1
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732339340; cv=none; b=LUIi0dzdLYlRMPndffddrMIe5DqaA4rVZaOhJxROyjAA10pcoq8K64COVg0Uk4N8I53XriAahEGJDd7tXZUV6n5OL820olFzREtxupA6It31fr5l14NLzXwALPndFntKbSdjxKFZZZrxVMjPTN59XCJXNHG9XIIEKgi/mqToAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732339340; c=relaxed/simple;
	bh=7tU5ALD6dT/GscddLn0cfJ213h8MSmkYT/S9vdeLi4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+5CrzIG5pJcbEKubr1qY9nLrIueADKG+Lf5nd1Fv5wqvH9orp+uK7iSJC0QgwGM/QNIQ1QGaWB6Z5YklRIazyEh8NEdmTEJ1opHUE413SUsPV4azgvggx8sBy5wdP7xsamoYpAsbIUyYU1CImjMCbLMn/STX27QjZnNxGjmQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ns4roqSj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa1e51ce601so449628766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 21:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732339336; x=1732944136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz/Cem8L1Zly4fm6PMZZr9K2nmFFTd5Yiu7PpEQWHQQ=;
        b=Ns4roqSj/PgcITPoBIrA7VyIQQAr4f6ACmYvOe3AubSlqNhrXIVkl2YXWFhd5fzanw
         znu1r8R47HU8DR5q1/6xmNu3k2uQLRa9NqeSrok7ni5gJpRc2GE1gdzjwcJooy0adm3O
         ULhyiicjGO/eoHK4zx6NvFYZw2y5r2692PyhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732339336; x=1732944136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bz/Cem8L1Zly4fm6PMZZr9K2nmFFTd5Yiu7PpEQWHQQ=;
        b=rIM1jCCJHsPvr8iU7G9agHr0en9uMOJFwOAhlIQhwIRez5a0x1v0ZfPsl9jqvLIJ8k
         /WECmV/RubcK0LEToloTejI8jSfgM94oq0sa4WjFGVY2b1rjOYT1tx6ILObWDnHtw3xw
         gPf8GJkwEauF1xxkVxAEfXU+BXklEYcJQOlePO4mtxg8Itm/wDe5Pl7fUg2sMEiKIQWu
         CwV5vAsEtrYsZUnNLsBu2NHR2T/O4kucv9iLS4n4SOJMz/wpVN5tEZygbmrHz2sWdn6K
         Qltp7LNj7QoRh1SZtWfc5IjLFbow8Hn37uFYcmqoeo0V3TmP7Vs91z1S6JesrkAuqMLV
         H47A==
X-Forwarded-Encrypted: i=1; AJvYcCX/foGP6s9TgvPO0+OpmVKNQRfVwTP4otkbSC6e+C5XxnVdvQlhW3wENhr4E/3GvNG6vBW+Rj+GPt62uB22@vger.kernel.org
X-Gm-Message-State: AOJu0YySwNAXDd3dhx9LvC76o7mkfeXeOoJrXnBgmHsNJqHyotyLqbOb
	Z31KAqVLvl4Z9CKkJMqsOJnoJ+bQftSi1bNnSx5QdSCZs5hn6LIZStYmcgk+UqkeCHhG4OpO5mr
	JcRgzFg==
X-Gm-Gg: ASbGncv5OTWTnAS5eIbAK8xVxScuFZSJF/VLsIAF6sW+ypEsNofknBJtmbDnBee8gGq
	wy/xwtt8O+JKoxW9Zt1p+ZJnz2LL5xpDO7v8kIukACIjSKs1BPxoJ8XHrr72vnSmc7BWccfb6tL
	EtmvW1hhNdTCIAxq8NhXwAiimnquaRhUbLfM6vZtu+gpoUdBQd53LS8Lw5HFilp6peNdNRKZLcw
	JPq7cNdSVXt1Nx0NLlgDWS/SWTRhaL/mPBjr0lrrflKY1issZcRc+ks0zXmKxLPCZrm4kh1Unvs
	AHOG7CkANQZw/CSkkyXt0rTn
X-Google-Smtp-Source: AGHT+IE/+CMSruXu02nNKER5nfqGqMMfjdbApmugUd7JXW9ncbhx7Ycr7aCtjEg/Se6O+re4D66ydg==
X-Received: by 2002:a17:906:2182:b0:aa5:3853:5536 with SMTP id a640c23a62f3a-aa5385357camr19376366b.46.1732339336546;
        Fri, 22 Nov 2024 21:22:16 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f00b0sm178162366b.45.2024.11.22.21.22.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 21:22:15 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso152150466b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 21:22:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXM1b8irxadIj9ow70/vW4RMY7/TBXJ48wFcMmlt0J7/qV83xiG4rVsvqB+mY9dGqXZy3nf+5hym6iYB41W@vger.kernel.org
X-Received: by 2002:a17:906:18b2:b0:aa5:14a8:f6d9 with SMTP id
 a640c23a62f3a-aa514a8fdacmr332444066b.14.1732339334425; Fri, 22 Nov 2024
 21:22:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com>
In-Reply-To: <20241122095746.198762-1-amir73il@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 21:21:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
Message-ID: <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 01:57, Amir Goldstein <amir73il@gmail.com> wrote:
>
> - Introduction and use of revert/override_creds_light() helpers, that were
>   suggested by Christian as a mitigation to cache line bouncing and false
>   sharing of fields in overlayfs creator_cred long lived struct cred copy.

So I don't actively hate this, but I do wonder if this shouldn't have
been done differently.

In particular, I suspect *most* users of override_creds() actually
wants this "light" version, because they all already hold a ref to the
cred that they want to use as the override.

We did it that safe way with the extra refcount not because most
people would need it, but it was expected to not be a big deal.

Now you found that it *is* a big deal, and instead of just fixing the
old interface, you create a whole new interface and the mental burden
of having to know the difference between the two.

So may I ask that you look at perhaps just converting the (not very
many) users of the non-light cred override to the "light" version?

Because I suspect you will find that they basically *all* convert. I
wouldn't be surprised if some of them could convert automatically with
a coccinelle script.

Because we actually have several users that have a pattern line

        old_cred = override_creds(override_cred);

        /* override_cred() gets its own ref */
        put_cred(override_cred);

because it *didn't* want the new cred, because it's literally a
temporary cred that already had the single ref it needed, and the code
actually it wants it to go away when it does

        revert_creds(old_cred);

End result: I suspect what it *really* would have wanted is basically
to have 'override_creds()' not do the refcount at all, and at revert
time, it would want "revert_creds()" to return the creds that got
reverted, and then it would just do

        old_cred = override_creds(override_cred);
        ...
        put_cred(revert_creds(old_cred));

instead - which would not change the refcount on 'old_cred' at all at
any time (and does it for the override case only at the end when it
actually wants it free'd).

And the above is very annoyingly *almost* exactly what your "light"
interface does, except your interface is bad too: it doesn't return
the reverted creds.

So then users have to remember the override_creds *and* the old creds,
just to do their own cred refcounting outside of this all.

In other words, what I really dislike about this all is that

 (a) we had a flawed interface

 (b) you added *another* flawed interface for one special case you cared about

 (c) now we have *two* flawed interfaces instead of one better one

Hmm?

                  Linus

