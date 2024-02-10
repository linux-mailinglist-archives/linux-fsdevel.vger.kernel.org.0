Return-Path: <linux-fsdevel+bounces-11052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6770285051D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 17:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62DEB22856
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B355C5E5;
	Sat, 10 Feb 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DgyfIQ2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265E2B9C2
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582356; cv=none; b=EFEo6rNf4D24EpvmkYfNtYu/nT79UvpYUp7Son9JF4ZLMzdojeR981x9Qjhnw/XZxXIVtNxvl9+DPMqU0YgNMuqvCqn5/yCJTROoJwwZKyQ0EphNCY25qJ1uSbF/ga9K2CwJ/zPzdWycWDf9l4nNNfyixxUUVy1mBs9CLLf22vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582356; c=relaxed/simple;
	bh=yz4YPAEAtTp8k4pNiQ5w2gqQ/oV/Qj08LwiUYa9phAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha5HPC7DNxjSPzuHXZfqLEnmeU8fKMYDmibCALh52b8FD04kE2t8vgiVi6h1RtuOj6kYdN0scbe9B6H4fO21cMFLZACORHQ2Cuikj0s6CFj7gfZiX88jjwuX+ofTdmdV4hzgnB5kHmVcRl0tPE2x6i3NF8IAWCMjvlTr5RVAUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DgyfIQ2v; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0dc3fdd1bso16565251fa.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 08:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707582352; x=1708187152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=14+TKgFu1eJaYyQcIW+M7oXMBhISCCQlq6Tol6TlzIg=;
        b=DgyfIQ2vr2y6w9uu2S1WUHit5mdCJXC0Q+CJye0FxqFSHm1gpKSqUMu8gFzrxBRUQx
         ZbtlBAz0w1UwDJg9KmaCPN1o7ukQhfe6NGCbh2o9i8lMTjdrchl/8q6Ydfwl7vUsvx6B
         V6D/6twYv58HlK+xK1nxiwZshCHb1xWQtbBTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707582352; x=1708187152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14+TKgFu1eJaYyQcIW+M7oXMBhISCCQlq6Tol6TlzIg=;
        b=r7KmLY1nG0YhqvAZrfOnQOg/Xf/c2RPIplFHGjWHCcJhYu5nqOZxJtF6TpF9Na7hfZ
         4/mZnHuKZE1O94pWpBEJ8qBTO+lb4JrM2M/pi0pMwwF5wUGHLK3tSEhFRiq7kaAdt5p8
         eMNmPZ4iwRVyAoMQVXS6e+8HMVxSXpUDGtf2haDJ3YShUhoSB9MhJ5qUiVzlgrq316q0
         AbDHqkywxDVPtWj7MHTnQValFx7tsdkguyDXnk+KlYc0Cq8OSlec9lRW83WvKl66C6Rp
         d0YpBWlMdLgh15+Z4A0jZOL9mRLt6t6fq9I7i6/1Pn7f5d1YS79UZrt/RXdgT1yyjv9N
         EENQ==
X-Gm-Message-State: AOJu0Ywya+MMVP47xgYU+uhpyUouZI8IaaisElRtPEKk4QV1ipMGFxaC
	1UtKJ/aEow9wxhrfejoywMreZFyb2CcY8bQSx97ooZ7o8jtT1yVJa44ITup/QVWbBh9M79sSZDU
	H7vs=
X-Google-Smtp-Source: AGHT+IHJ19Ru/xqNMD4ZXg5UlECp/1yQ4rWJVz4tGZmUfxySAWZz9NnjK9jkpVPaVVs4PxVqriOTCQ==
X-Received: by 2002:a05:6512:158c:b0:511:4ab0:8ddc with SMTP id bp12-20020a056512158c00b005114ab08ddcmr1814190lfb.57.1707582351856;
        Sat, 10 Feb 2024 08:25:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqwJT6NX2NR8MYd15Dova0aiNQgm7Xvu2T+jJoRyRGRwcxcMV0o6ldN4CaFpWizeZDkodX6QqLVFEDGH0wXD/qrbcWc3DyKeBzhBi35Q==
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id m10-20020a19520a000000b005117bff2799sm274324lfb.278.2024.02.10.08.25.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 08:25:51 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5116ec49365so2099592e87.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 08:25:50 -0800 (PST)
X-Received: by 2002:ac2:558c:0:b0:511:4ff5:4dbc with SMTP id
 v12-20020ac2558c000000b005114ff54dbcmr1533326lfg.60.1707582350649; Sat, 10
 Feb 2024 08:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207222248.GB608142@ZenIV> <ZcQKYydYzCT04AyT@casper.infradead.org>
 <CAKwvOdmX20oymAbxJeKSOkqgxiOEJgXgx+wy998qUviTtxv0uw@mail.gmail.com> <20240210042307.GF608142@ZenIV>
In-Reply-To: <20240210042307.GF608142@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Feb 2024 08:25:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whZefPXJaPSZR=3JzX9Bx2zRoCK9ASd=US5CFfU0HCTfw@mail.gmail.com>
Message-ID: <CAHk-=whZefPXJaPSZR=3JzX9Bx2zRoCK9ASd=US5CFfU0HCTfw@mail.gmail.com>
Subject: Re: [RFC] ->d_name accesses
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 20:23, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Can it reorder the loads of const member wrt e.g. barrier()?

As far as I know, a C compiler can *not* in any situation think that
"const" means that something is immutable.

In C, a pointer to a "const' thing means that you are not allowed to
modify the object through *that* pointer, but it does not mean that
there might not be another non-const pointer that aliases the same
object.

Now, things are a bit different if the object definition itself is
"const", in that then there is generally no way for such an alias to
happen.

But anything that gets a pointer to a data structure that has a const
member cannot in the general case know whether there might be another
pointer somewhere else that could change said member.

IOW, 'const' - despite the name - does not mean "this field is
constant". It literally means "you can't write through this field".

And then as a very special case of that, if the compiler can show that
there are no possible aliases, the compiler can treat it as a constant
value.

The "no aliases" knowledge might be because the compiler itself
generates the object (eg an automatic variable), but it might also be
through things like "restrict" where the programmer has told the
compiler that no aliases exist.

But when it is a part of a union, by *definition* there are aliases to
the same field, and they may not be const.

End result: a compiler cannot validly hoist the load across the
spin_lock, because as far as the compiler knows, the spinlock could
change the value. 'const' in no way means 'the value cannot change'.

Of course, who knows what bugs can exist, but this is fairly
fundamental.  I don't believe a C compiler can possibly get this wrong
and call itself a C compiler.

                   Linus

