Return-Path: <linux-fsdevel+bounces-67628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16862C449BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 00:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50203AF056
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 23:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023826FDBB;
	Sun,  9 Nov 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZmcOuLFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3588D26CE35
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729693; cv=none; b=L7J4akG8DeaiBQT/Ogpnx5dHArPkkfDnCEzI1JEIPc+CrRt7QK5/0ndoWYx0BKuBa5gCjQrF3cjVawIWHXThBdcrCBN16ArQ6vcyd+k1n9+JIABRaQTR/pNH/6xC7GaBFco2lHFaWSCEydBUqav9+bDhEUHW9fAUori4ukz1jhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729693; c=relaxed/simple;
	bh=iACxoHcoDxLWZj3kolEGP9nbhxUet6TkNrDdT2g6g6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZFvGB65EwxgTmEmR9Jub/9UHZzV3+IGbi8n/7J9mVYljBjPPjq0lhOuIROLSkiEwziieZFrdi7eWDfEK7iu6sGJpFL3AUOxSBsJJXz8EjnrlxIWtkpt5drKTUl8U2DrMvHIsGXFrWYLfCt13opcIDt3FdvlWXxeD0FeF6tQRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZmcOuLFZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b729f239b39so519275266b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 15:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762729689; x=1763334489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAZXs3XadTTrsCvx/VeK6Nga0Xvd+txMXgtt9i6bijA=;
        b=ZmcOuLFZceHb71iFe7EbCUnGZvf1GBccZl7skKMvy+hQwpdvuoln+JUEo2i5So0W8W
         TzLlE6Eo9IqgsAuPDM4dFyqCbkvWZe8RoR+qIPn4IrtfpFoUavnEpkrdK2TsLCU7GlH2
         q+ZoKfsy9DKsJEL6WG5gc/R5pn7h/Brnlccvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729689; x=1763334489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAZXs3XadTTrsCvx/VeK6Nga0Xvd+txMXgtt9i6bijA=;
        b=v+7iygz+Ud3RVoShfoyVwPaCdZOIP53oVRzOo1RTyijVXPTdGptIybW37ItDbrLQpC
         LsO6sAmcEr325I00VJZ6BfyGQTZC/4iU7RPCeEgwTEitLy1SsgAR/V8cJWNpwZAcs0g2
         fX0/QsucIt6tsHnbb+cOO09mEsY01hwy2oR76u2fyFwjmvoCceUh4iFSyp6603k7wi8B
         4US10Hne8nSku8+TlJzgnaZzu5ceR25FqKBgMqJptA5v9niM6Iku8FBXOfFetEkyQVGK
         zfW3sGz6uytEgzoUgnE7jamhDJjjZFYP2logZ6iF9oCr3PfFCXJWR8KWIZKBwAkJT61b
         C7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN4fNpLqcmcIupHZnU/5at4/8gvMSCvLVgxPdoNgVnYimj1QZlv23IUGERzsTYj/lzQISnj9jRVWeNGDEz@vger.kernel.org
X-Gm-Message-State: AOJu0YyRpg3/1dNToih+mY8PB77a2/CcwCUxfWyT7t0cNj2ctFJOFTt/
	hhPLVRNKI5R91DwH+AQxaUih856OnTPLXz0PUb6M+56PuerH4X04U20vv8X64EVBtHP4gomt5MN
	SUCZk3aw=
X-Gm-Gg: ASbGncson044cRWLOxyMOYdpNP1tz1X3nrwWyu4eaOCAAAbnvEThF0G3U6kO2txByb4
	LfJ65f+u/3sGuNrJp1rG3oJm2u0jyq+rDyoTlVrXu2a6HtGe1M4Bm34sT8L9PPno/m8IjjoQYCb
	QRUEXkt29TG98PyWc5sPQV8UxgV2SQRkmH8hWOAYOZX7/lBJ1m4JFXeLT2DOQpoLkRm8Z6kbYyK
	iWOG2exTArL484xHhNqMaTWtiy1fNXEnRZSt3/3hHb3SOh6A3ZxdAbVGpmKRjS/OhLkDUl3Nu2p
	q9t5qjuANvcqp7e0s3WELp3QGulPd0qXAhaire1z1SUnqgJBVrWw/+l4tRyGVQ5XI43JzvVoguO
	DqdI14a1K5TY9DIVVXppJA9e+iWFG0ZkTZicN2R8wLJL0LfqxzWsu4c5eKUEpgwx6MMyNaT09hA
	LkOp2AyFdVUYIZRrqjd+GuTcbMLVdZbZbxjGSp9pNODhG/KDzsvYOMiFK9KAsA
X-Google-Smtp-Source: AGHT+IFyVSwvwEWskhcC7Iu+EO6GI6Cp6xtFpPqW3gUybkYAgYDVShaQ7HCt1WxeMf0BoDkXzl7UHA==
X-Received: by 2002:a17:907:961f:b0:b27:edf1:f638 with SMTP id a640c23a62f3a-b72d0b031f4mr966322666b.23.1762729689268;
        Sun, 09 Nov 2025 15:08:09 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa11367sm905952966b.68.2025.11.09.15.08.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:08:08 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b727f452fffso412298866b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 15:08:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUntDIbVoNb9YIWcjbXDzrVV1NqYD7+govNwPckJ+kYMZIvlcjuurRyfIzJqQPCDsM/KYWL7I8MoGW+AEeE@vger.kernel.org
X-Received: by 2002:a17:907:7f13:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b72dfd9b02cmr669689266b.16.1762729688139; Sun, 09 Nov 2025
 15:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
 <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
 <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
 <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com>
 <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
 <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com> <CAHk-=wgbn+6pGaPw1k6LsMyaPQqz4PxOqF_kN+drQvNudF_1XA@mail.gmail.com>
In-Reply-To: <CAHk-=wgbn+6pGaPw1k6LsMyaPQqz4PxOqF_kN+drQvNudF_1XA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 15:07:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghq+wJrgrDy=-S5TmVNkaJS5RWsQ3kFfCCwv0juoKG4w@mail.gmail.com>
X-Gm-Features: AWmQ_bnxTScKA_GtJGPpI3hrR3y54KxE0TmLEXSfNmQBESKxwdZdKzo52akvKlY
Message-ID: <CAHk-=wghq+wJrgrDy=-S5TmVNkaJS5RWsQ3kFfCCwv0juoKG4w@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 14:44, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And again: that patch will slow things down [..]

Having done a profile just to see, the regular allocation path
(getname_flags -> kmem_cache_alloc_noprof) certainly shows up.

But on that test set (kernel build), I never hit the 128-byte limit,
and interestingly putname() shows up a tiny bit more than
getname_flags().

At least one reason seems to be that the

        if (refcnt != 1) {

thing in putname() is mispredicted, and without the auditing code, the
"refcnt == 1" case is obviously the common case.

Anyway. Not a great test, and this is all the "good behavior", and all
the *real* costs in that particular path are in strncpy_from_user(),
kmem_cache_free() and kmem_cache_alloc_noprof().

And yeah, STAC/CLAC is expensive on my old Zen 2 machine, as are the
cmpxchg16b in the slab alloc/free paths.

And in the end, the actual path walking is more expensive than all of
this, as is selinux_inode_permission(). So the actual filename copying
isn't *really* all that noticeable - you have to look for it.

              Linus

