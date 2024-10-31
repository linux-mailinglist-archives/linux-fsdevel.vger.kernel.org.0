Return-Path: <linux-fsdevel+bounces-33379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC469B85DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 23:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2932F1C229F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFB21CEADC;
	Thu, 31 Oct 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ReK7dDF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CC71CCB39
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412175; cv=none; b=eaWtgnP0SwHm0sBZO8IQ7ntffv/XtfOsarz5xlTkZQWMeosHI3voMzx5SqarTdJT/qzMfD0OmbLKVVwaRc+qzSaG7IvxzHZW3RtCYxuR8QljNSgJHIbxJEOIb2Lfyj9jzhxQ6Ozco/YZWg9y+00IuXsGhjfvr2X4OJP/JkTTqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412175; c=relaxed/simple;
	bh=xw9c9uRCZip9b5z0xQQXgj61xVnjqCNOu2Ec6UCpIj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0XuAzTbo1X4DTa1RRtbHqxiE4RtIa81oJenGarIw+Jy6fEPTFZ3punr2j+dguGStaVH+DyHolp+pr7MNnHZmahdW++D/kqSEM9ArJV5vnw5OXKA5m6gvN3EQIMvUtdEp1amIk+k8moBN9xI/rCTEo8HQK8fGZfYpLTTHnv9dZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ReK7dDF3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a998a5ca499so176840566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730412165; x=1731016965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6tWGGir5Adx4MqX737fggnZgq14JwkQAdxsqdfZqqg=;
        b=ReK7dDF3eXpEuPJRD/Z9Rgoj3DqC9qwM0zKsVHuSqWX6O/robcMnvNbDKEIhtTQTQf
         yZFCdSWkb2xUNPzxe7v8F/klNPPcit4OQi37ImetGAAik1Qq0ysKOFbdTCqDK2ACy2mx
         2svymG834UbUr6tDDkqmxHxHcG+gKkXpWe9t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412165; x=1731016965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6tWGGir5Adx4MqX737fggnZgq14JwkQAdxsqdfZqqg=;
        b=BPBsJI6OPHbBsI4JyCcYdrD4/zftvXopdqnnZrD1/kj2GjONIr0+YDrv734vqLFLn9
         05TWZIjxIa2+DYVYdxjsMTj+SWN0arfPPfCcM888rhUArWPM630C8+urrirhv4RszvMD
         23Nu7Ok8LKCVfRHzkqmbfWyAT899KYx1Atdblssx9miFp1ruqKWsxp0E8xnDYOSA4e02
         FbdGiKsMo9V2AnyK2ntgZKzOMB1QexPU+hkGG9W6n/KjaE24JublzWqeS5fEZdGOsGNH
         aeAJEclCMP0d4+UYxL/95qhIbT26gJE31IaWx8ZzSB3wRp89+aQsDpyhOYGw1akG0tWe
         SNrw==
X-Forwarded-Encrypted: i=1; AJvYcCVlYWoYuBoAUT7qs5bx2GQe/4A7T86yrzY6yKzb7GDcq0ZUuauiAhxsE4oU9x6tcOQUOE6hnCD8qL3b8Uqi@vger.kernel.org
X-Gm-Message-State: AOJu0YwzloKuuTczbDRmPBEvXd8Z4ybBU+nOXrGhptuVOBw+ABsiyi8v
	u6O7jLkBMZ5FsdPYCoFPEeOzqssnzx+AyOhmKO30g4LXuNlGjkMJL9d5werHKvn7o/1eUo/21W4
	pIl8=
X-Google-Smtp-Source: AGHT+IGWkgOp3KhO6c9LYJzDEfrQJrQA9POUR6Ja6NbMvTOsoUYCUS3lGhgBTMnaYlKFnYCHGfImcA==
X-Received: by 2002:a17:907:6ea1:b0:a9a:bbcb:5177 with SMTP id a640c23a62f3a-a9e658084bfmr118134866b.63.1730412165423;
        Thu, 31 Oct 2024 15:02:45 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564941d5sm111135666b.19.2024.10.31.15.02.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 15:02:44 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a998a5ca499so176837366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 15:02:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGYq/5LxJeaQ/AdNjzFq03LDwR4J00UaCUQQ2QTPuVzQcF/rM1eLcOgupB4rCDr5YFQo5n6B3P7HQwxf7g@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:a9a:dfa5:47d2 with SMTP id
 a640c23a62f3a-a9e657fd8dfmr128991966b.59.1730412163769; Thu, 31 Oct 2024
 15:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
In-Reply-To: <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Oct 2024 12:02:26 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
Message-ID: <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Oct 2024 at 09:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe. Part of the cost seems to be the call, but a bigger part seems
> to be the memory accesses around it with that whole
> inode->i_sb->s_user_ns chain to load it, and then current->cred->fsuid
> to compare against the result.
>
> Anyway, I'll play around with this a bit more and try to get better profi=
les.

Ok, so I've done some more profiles, and yeah, the costs seem to be
almost entirely just cache misses.

make_vfsuid() shows up on the profile a bit too, but that seems to
really be literally just "it's called a lot, and takes some I$
misses".

When the profile looks like this:

 10.71 =E2=94=82      push %rbx
 15.44 =E2=94=82      mov  %edx,%eax
  7.88 =E2=94=82      mov  %rdi,%rbx
       =E2=94=82      cmp  $0xffffffff82532a00,%rdi
  9.65 =E2=94=82    =E2=86=93 je   3a
... nothing ...
 15.00 =E2=94=82ffffffff813493fa:   pop  %rbx
 41.33 =E2=94=82ffffffff813493fb: =E2=86=92 jmp  ffffffff81bb5460 <__x86_re=
turn_thunk>

then it really looks like cache misses and some slow indirect branch
resolution for 'ret' (that __x86_return_thunk branch is misleading -
it is rewritten at runtime, but 'perf report' shows the original
object code).

So some of it is presumably due to IBRS on this CPU, and that's a big
part of make_vfsuid() in this bare-metal non-idmapped case. But the
profile does clearly say that in generic_permission(), the problem is
just the cache misses on the superblock accesses and all the extra
work with the credential check, even when the mapping is the identity
mapping.

I still get a fair number of calls to make_vfsuid() even with my patch
- I guess I'll have to look into why. This is my regular "full build
of an already built kernel", which I *expected* to be mainly just a
lot of fstat() calls by 'make' which I would have thought almost
always hit the fast case.

I might have messed something up.

               Linus

