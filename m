Return-Path: <linux-fsdevel+bounces-35253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D499D322C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 03:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64AECB23CBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740745016;
	Wed, 20 Nov 2024 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+puC7nl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461584EB45;
	Wed, 20 Nov 2024 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732069813; cv=none; b=HDAyrGzuzTCLRh4n6xtBykkYEuP5E6PcqZXaZV+p+naQd4CsDTvrx0Mej1YMvxXSMBPRRbxDOzofuK3M/lDvDP+X0WWI8B6nQOyRwFHesRjl9mp/yhqhAyQNjgisfvD2HTKZPYc+psIRRuKKHgQwLzZdt5qkztwqroTeCwpusXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732069813; c=relaxed/simple;
	bh=pxKqV1xI9qWnWc8lCdM4llK/Shb0tdmvQU207x77kZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRjWQVq/GlxjALi/+lOWwpfFKE/b3VYxoF7QDtMSjIjau0QjLn+OxVRG6usS7K7++X1CVA12qFPWSM4ENn30Z74hTL8tIjUmc79izbinw7njtIG/OdN4j/15fffd4jF8HNARqznPHFEpcuy3ARp77rM5nSw8Af0EBqNJbCy8glk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+puC7nl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so5412705a12.0;
        Tue, 19 Nov 2024 18:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732069805; x=1732674605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh+TdjnkDPsXkreYZjskDUHFvw+7Sbm7pXH3lhRyu5M=;
        b=M+puC7nlSbDx8Q4XfPvnG17V9HFoRpulLUcEkvBiul4en8lUp1Zvlgda+M/qqm5Vsd
         fxF9uZmmEGCgs5kMQ/WE3M3ULVhUI6VBCXTXkeq1gs9zQqdxglpruUQgG36Ca2kdGbVz
         gOnR4iZ0UUuXbqLVeKxaihlw8ZJnBK3lAz0BQzWOf34CTrnaUO0fvhEAUBB+hMoNNAK/
         iJOar8t+3iaFwZ9EPxq1RQZaOHCFvePT4TENP19rJHwaXjFnzks+X8BttWTZ57aIbyBf
         CDVMCK5J4dFMvHNVWFRvMYYY83xBUBia6M96H5HJRDNroe3KLFIGf8r5Ve6u+HspL8bD
         qpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732069805; x=1732674605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh+TdjnkDPsXkreYZjskDUHFvw+7Sbm7pXH3lhRyu5M=;
        b=u1CsIgPHmapKqlE5H2KJ7ViYGOZWhds9X8hMY4hGEPfIeJp55zn44K2b7Owb+m+5fY
         wG0PSHMuj1EC3a+b04XpWzdiIa/+L3k6IbzXEmgvx9nuYZxnP1oX+UXJ99Ml4j1L1XDj
         M8JWavybqj5/Qq9j9rayrl98LbD2QJns0UZm9wtdR9X3mSB6+JCYO84sTI1L+NtbDIxz
         wvXqIuJRYK66VrTZMLcqDCf2A4ULXgTNij8g8nJGuxmbkYZ+ea2DwV/crB8pH4HfewuJ
         VXTiLAqaljOW3KP0mLqLBVw7qltCyg8ThO1zXI52HySgmnywK7Dr1M7/Nu9mPUzpDXqZ
         6f0w==
X-Forwarded-Encrypted: i=1; AJvYcCW8KxDj5U1uaJglzBsMhEtprZF+i80TPcxiIUuKNZCqQQ72lARtDkGfX0n5ICu0klu3ZsglNGmm@vger.kernel.org, AJvYcCWcAanpslSmGz7FU53dyPLygfWg+kD8BqCy0buROh7a6QoOCXtDdHpbt0OUbG3lj1O2r+5QQPw+2LOKHnQf@vger.kernel.org, AJvYcCWcZ/oTt0EUcOHwFp5gJhg+my36aR16a3NuYJtBWKfRaeUErcIJUhD+79A3qJUK5wAKxLfBJm3edbbLSZlO@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUz4flQ5Yc+GL+pdcIDzvUGrhyo5E8IMyPxKyDDqclP0IaziQ
	32HxJ9grDxFdEi8q+qFPcA8nsreLnfQijHvOM2Hy4SRomMA/EPOMrc4gI7Y5aOZWUrtL/SXIGW9
	OaTJE4PoaAiffxGa8m+TBArplNLs=
X-Google-Smtp-Source: AGHT+IGqIEnOEjDI+kEjgAYxgsWZM8sFqQQJ6E3XV7AZLjVFnO1ZackJMXsfxQXI4JGzoyRBKb0YHnabL6STVaEwwWM=
X-Received: by 2002:a05:6402:d08:b0:5cf:d19c:fb20 with SMTP id
 4fb4d7f45d1cf-5cff4c43027mr554043a12.13.1732069805424; Tue, 19 Nov 2024
 18:30:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117165540.GF3387508@ZenIV> <E79FF080-A233-42F6-80EB-543384A0C3AC@gmail.com>
 <20241118070330.GG3387508@ZenIV> <3pgol63eo77aourqigop3wrub7i3m5rvubusbwb4iy5twldfww@4lhilngahtxg>
 <20241120020845.GK3387508@ZenIV>
In-Reply-To: <20241120020845.GK3387508@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 20 Nov 2024 03:29:53 +0100
Message-ID: <CAGudoHF59zAFZCH=XnvNi4zS_WeCgSgUzUL362e78mczgsgSNQ@mail.gmail.com>
Subject: Re: [PATCH] fs: prevent data-race due to missing inode_lock when
 calling vfs_getattr
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeongjun Park <aha310510@gmail.com>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 3:08=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Nov 20, 2024 at 02:44:17AM +0100, Mateusz Guzik wrote:
>
> > > Pardon me, but I am unable to follow your reasoning.
> > >
> >
> > I suspect the argument is that the overhead of issuing a syscall is big
> > enough that the extra cost of taking the lock trip wont be visible, but
> > that's not accurate -- atomics are measurable when added to syscalls,
> > even on modern CPUs.
>
> Blocking is even more noticable, and the sucker can be contended.  And no=
t
> just by chmod() et.al. - write() will do it, for example.
>

Ye I was going for the best case scenario.

> > Nonetheless, as an example say an inode is owned by 0:0 and is being
> > chowned to 1:1 and this is handled by setattr_copy.
> >
> > The ids are updated one after another:
> > [snip]
> >         i_uid_update(idmap, attr, inode);
> >         i_gid_update(idmap, attr, inode);
> > [/snip]
> >
> > So at least in principle it may be someone issuing getattr in parallel
> > will happen to spot 1:0 (as opposed to 0:0 or 1:1), which was never set
> > on the inode and is merely an artifact of hitting the timing.
> >
> > This would be a bug, but I don't believe this is serious enough to
> > justify taking the inode lock to get out of.
>
> If anything, such scenarios would be more interesting for permission chec=
ks...

This indeed came up in that context, I can't be arsed to find the
specific e-mail. Somewhere around looking at eliding lockref in favor
of rcu-only operation I noted that inodes can arbitrarily change
during permission checks (including LSMs) and currently there are no
means to detect that. If memory serves Christian said this is known
and if LSMs want better it's their business to do it. fwiw I think for
perms some machinery (maybe with sequence counters) is warranted, but
I have no interest in fighting about the subject.

--=20
Mateusz Guzik <mjguzik gmail.com>

