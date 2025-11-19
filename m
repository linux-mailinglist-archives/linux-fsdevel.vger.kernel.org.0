Return-Path: <linux-fsdevel+bounces-69144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F221C710D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 21:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 06E4F2B369
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1B536212F;
	Wed, 19 Nov 2025 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEZIWj9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE72324B09
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763584846; cv=none; b=r/bpTTTUMLRxdhm2MQJDNvYqStER6LCPmvqOD5AoZSGMwjeeym6mX9FH5PJnSgcaUDAoUdb/zanzd/SeZWDshP4e7Qq7MVuFCxCT7Jq5ZhulYto9Z6S/TTEQ9FFcWyGNxRAa63PRHV93cYRhybBWGperfBgriwmB/kL/hslWokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763584846; c=relaxed/simple;
	bh=nb0d+q8s5ABDqhBBwjYaPxxoDlshsiM5jRXTTQw3Lj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc9T8ECRObVuJDKAHqidpsSONPJYUCsxgrMF+zDgTR6FJhFqboALdmbIcXnOqhpwwRp+K7r8r53KGVonsV6uCta67rAo4tmlrNxdh4KHC9jLEBA5WHl0wcBZ3gidT6CuN+Lo9TSouvAFqQmgVsyPqHQtuSclTC2YGJRzwL6i0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEZIWj9f; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso276966a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 12:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763584843; x=1764189643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYLZLXrherScn0zzMY+8QJvzKw1xWqfOq4qVbQHg5Vk=;
        b=nEZIWj9fZvwn6xONtB3ZbF18ud1WB21b8n2Byd2e6flhUYqNzTJUN0vnhFXqEYZjY5
         sLJ0u6+pZFzFWybkRkvDxPXfx/Hvb9LiOMjIcNLKLcylBBxdWrShoSI/40oYk06mwyWi
         DprjtAHDVlk86x/etjQesDgPAwz6Qfiarz19atJZF04qRdckL8o1U+J6Oy6DbtqzssOZ
         HnIKf/5nV7uIwq4koNmbHi3+ZO88YxsSdr6aM8m2sk6sDEGEnhkkJ/oJTKuBOj/h+tw3
         6uYZkxSehhHjCmxnpvwErTNxF1uwUNAnofsxSvHbSrsHda0icJ4wdCxXNhAbG3BJ3uEn
         gBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763584843; x=1764189643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fYLZLXrherScn0zzMY+8QJvzKw1xWqfOq4qVbQHg5Vk=;
        b=wPFCuPQ0ZjEbf9XSr3a6wbZmE4SyEB/rZIt212HTqqHI+q1JAKpLFAPpHIe69MhNEh
         GVFQ0hSElvYHZymuS1Ljyv7FAIpBcGh+vu3YehV0NxD8H7o8f/f+AO0DTiPjHTqVOht2
         hIsAwOjHh/anyjvxWtE8jOX6OyH4eoxLvaC5sA0IKINZEdhUyzrSpD5calBvfuH7kGq2
         Sy2Hx4dDbe/NAhFlJ+DG18JDKGhe79FzwBQS4/lw3VPnRIjphGrJSEMwLuXRv0oVgAbe
         lTd299XnHAH8aFyabSQj7XOxurEc+iS/hn/sHI1d7u7OvZEbNCElCXUAhlWJANwclr0a
         Vkuw==
X-Forwarded-Encrypted: i=1; AJvYcCVxrWXxxz/WAXNmtcbRG/FnFj4a+tMPcUScS+eJLEb4tuzcPILu1rrI5DZN+W7tH1SGO47Yb5mftRY8F2zB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12FLKVni0yRxNOaI39rXiXHLzwuhXkjC+dmJ3akeR+XPTkgDs
	jxX3D2en/+k1rJC1sxzAVxs9JTK16dAduLXc2rwVw4/dqF/5hXAf+u59K2IaFGnVZL8LQtJ2B+M
	w5GzR/siIxGOOh18KtSORjIdIzBbc/2E=
X-Gm-Gg: ASbGnctnG37nTtW8jPBuiVwI/FDVFaAreeKPcMHYinC8lp2u5gam6JASvbJmd0A9ttl
	t9WhHrVLRk83FAjIda5zKlRT92szKmLjNyuW+whVEMqmcoaOC5GcpY5omOIE1hFEqtZXjKXiXca
	/bpQSHq+lBv/Aac4p4iq+oxF28KVlrOgkL7CMTh6YK6V7G/Dk54rnbqRUt7ILSL8NmD0WDTGi40
	LiSV4M/h9AdFv6tqWoV/b+eFM7y6xlzmI0hrj2P/KKyrugF8OBfdWbrfbgQD0oUw8pVcKjfvzjr
	6jtbn8vNA/GMyK6ccm2JGj8mKBZGFrRAx8cb
X-Google-Smtp-Source: AGHT+IG8Rg3Lqn0c6bOAkDLepGzjfFWXq/WRByZX/AKCN3alz/XTte5GQ4ZSIQ8YeF4FLtQg1ZogyJsd2DDKIGxzfK0=
X-Received: by 2002:a05:6402:3506:b0:643:4e9c:d165 with SMTP id
 4fb4d7f45d1cf-645369f8918mr520826a12.5.1763584842781; Wed, 19 Nov 2025
 12:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119184001.2942865-1-mjguzik@gmail.com> <20251119194210.GO2441659@ZenIV>
 <CAGudoHHroVs1pNe575f7wNDKm_+ZVvK3tJhOhk_+5ZgYjFkxCA@mail.gmail.com> <20251119202359.GP2441659@ZenIV>
In-Reply-To: <20251119202359.GP2441659@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 19 Nov 2025 21:40:31 +0100
X-Gm-Features: AWmQ_bmzfwePN_LAy-GLlNNO_bON4D7M-LrY8PdDOkeIKWRFGIT5XSxsV_39RRY
Message-ID: <CAGudoHEPAGu4T9WvuA_zG_ALyMAbnbaFDqv54y4-G9FgbqEqrg@mail.gmail.com>
Subject: Re: [PATCH] fs: inline step_into() and walk_component()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So I think this is best split into 2 parts:
1. the tidy ups around step_into as present right now
2. implementation of the fast path + inlining of complete_walk

I did not previously mentally register that pick_link() is not
tail-callable because the address of struct path is passed as one of
the arguments. I'm going to massage it to pass dentry, mnt as 2 args
instead.

As for the fast path, I slightly tweaked your version:
static __always_inline const char *step_into(struct nameidata *nd, int flag=
s,
                    struct dentry *dentry)
{
       if (likely((nd->flags & LOOKUP_RCU) &&
           !d_managed(dentry) && !d_is_symlink(dentry))) {
               /*
                * Simple case of not having to worry about mount
points or symlink traversal.
                */
               struct inode *inode =3D dentry->d_inode;
               if (read_seqcount_retry(&dentry->d_seq, nd->next_seq))
                       return ERR_PTR(-ECHILD);
               if (unlikely(!inode))
                       return ERR_PTR(-ENOENT);
               nd->path.dentry =3D dentry;
               /* nd->path.mnt is retained on purpose */
               nd->inode =3D inode;
               nd->seq =3D nd->next_seq;
               return NULL;
       }
       return step_into_slowpath(nd, flags, dentry);
}

There is a comment about path.mnt and use of d_managed instead of
open-coding it, the other comment is a little different, but again
that's cosmetics.

Since this is de facto your code, modulo small massaging by me (+ two
instances of __always_inline), I don't think I should be slapping my
authorship on it and maybe you prefer your version exactly as you sent
it. Alternatively, since this follows step_into() as currently
present, just lifted out and slightly massaged, I can slap my name on
this and state this is what happened.

I'll be a perfectly happy camper if you take authorship here and write
your own commit message or take mine in whatever capacity (presumably
you would want the bench + profiling info).

Just state how you want this sorted out on my end. My goal here is to
get this crapper out of the way, I don't care for some meta data on a
commit.

On Wed, Nov 19, 2025 at 9:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Nov 19, 2025 at 08:49:36PM +0100, Mateusz Guzik wrote:
> > btw, is there a way to combine DCACHE_MANAGED_DENTRY + symlink check
> > into one branch? The compiler refuses at the moment due to type being
> > a bitfield. Given how few free flags are remaining this is quite a
> > bummer.
>
> Is that really worth bothering with?  Condition is "bits 15..17 are 000
> and bits 19..21 are _not_ 110" and I don't see any clean way to change
> the encoding so that it could be done in one test.  In theory we could
> do something like swapping the "type" and "managed" bits and use the
> fact that 6 (symlink) is the maximal type we might run into, turning
> that into flags & ((7<<15)|(7<<19))) < (6<<15), but...  *ewww*
>
> If nothing else, it would
>         * require us to remember that "managed" bits must be higher
> than "type" ones
>         * require us to remember that 7 is never to be used as type
>         * require every sodding human reader to figure out what the
> bleeding fuck is that test about
> and I really don't believe that shaving a couple of cycles is worth
> that.

