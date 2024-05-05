Return-Path: <linux-fsdevel+bounces-18775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90CF8BC364
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 22:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F0A1C2141C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F76EB56;
	Sun,  5 May 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O63G1E/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B86DD0D
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714939410; cv=none; b=RBoh7CRFICf7FZQmwQlV4JzS0pz5aZl1wAVd/qT88/fWETKBcSvgoc77wPSqpVfbK2vlpidC4dDO1c+ZwNFVyR4t4eKKoeUSjV6wuVJuqSIS2jHMULgUIhMEhbo9II+Om4NRhlJDZsWMaxAODva20OkgZ/hLkGHBcvi/wKDa8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714939410; c=relaxed/simple;
	bh=wWs9rnVSNPVg9flRopfXNHpvrjJqY4eLW8+/eL6ffhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+hCxtH/UGvzdZH4kOCjIx8pH992n2u+lQ8xUz3HH2e/ghbwZLryeOxnt9ZurPR91sk1GgdZXlj8PKMMrzCM8Jhgt2TKEhl9A2LKQ/eNtGLssgraQuLq4cn2FJ1CiI9We5J0ZRyAmjfl28+XKkMtkWLu+q19vNyzqMsYY4khxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O63G1E/+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so1326348e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714939406; x=1715544206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EHEpVJVmF2eGrGo8U8tgs6RR34ElBujEmi1VC80nQxg=;
        b=O63G1E/+7eBWR310Zub5Uoveljh5Dxn3u+PhSS+4shS8AjLRiDj+ArjSaBHId88gZ+
         5edZ2Md2dopxrQc5rl6rHtWfSDNZTvjE6vwnyUfhMK18WSCAQJeHQocneLpvZHgtw59o
         afMD1e0prLch0Ci2wjiF+oVb2EP8ohEa50ykU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714939406; x=1715544206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHEpVJVmF2eGrGo8U8tgs6RR34ElBujEmi1VC80nQxg=;
        b=lw6aK0UMnSOUuBfmLzNizRrLeaRphxmEYVNNhMWcnc2okB4moEBjutx5IrMXYT05ip
         wXwgBcsNhb1O+kCfqam1Oef21/RvbUNsz+/homs0PlhPGZghvrY8i9o6gtOH/8GSuZGr
         1d1ooufhhNsBhBXSyQWeDQmwJfF0j+gJB6LPFvmlX8ZCev1X74QibCO/P3v+dZCgfLLC
         6hTDPd584c6Hu2ldfzNcHl6YzagTrlNyiPVlaT05BN04BOFZ/9U7ytfA6OtE7cstDL+K
         7Tr/WmFMB+PAxFUV41US7uhyc4cOH4tZkVy6Fs9wdO10ySeAXNwfF3D54Ewanx87L6Yg
         e/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjSkfoc7JzgRvqlhT+uLAZu2cnlsuBs+Xxrgywq6ipx3iLapP/3PcfFw+ALJoYovI/LIjlQ9RU+ZiAVdU6y4HnHh635MSY8O7l1+6PhA==
X-Gm-Message-State: AOJu0YwhCnfLqAdtSqBnkhEdVjEZxD0C6G9T/w1cn4wGw2/lVgkJfatF
	lT2O2TTXYykctkmTSqZqF774z13o2V+Tw85QxV7mjkjcGUilKKHmGQaEWqxm5rt+JWAnGVfmQg+
	fIDN3mg==
X-Google-Smtp-Source: AGHT+IFJdukPn1JHk1TEcXl6518rZS0awl8z5UsqHoFrJMsmU8u4kxNJju7x8X9qjYZ6EAAvgcLyMA==
X-Received: by 2002:ac2:490b:0:b0:51e:fd97:af89 with SMTP id n11-20020ac2490b000000b0051efd97af89mr5055944lfi.16.1714939406145;
        Sun, 05 May 2024 13:03:26 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q26-20020ac2529a000000b00514b44c589csm1328474lfm.111.2024.05.05.13.03.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 13:03:24 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so1326307e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 13:03:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsREiVMMCTH9vGWfQrD4bpIKx5KYQ4oVeWRHJNJK/zE4HT3BYtG6xN6WRvE06lALheKrUS2pQXRLsCCjaeROsQGHXtswEZfj1CIrDORA==
X-Received: by 2002:a05:6512:202c:b0:518:c057:6ab1 with SMTP id
 s12-20020a056512202c00b00518c0576ab1mr4629192lfs.66.1714939404009; Sun, 05
 May 2024 13:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
 <CAHk-=whrSSNYVzTHNFDNGag_xcKuv=RaQUX8+n29kkic39DRuQ@mail.gmail.com> <20240505194603.GH2118490@ZenIV>
In-Reply-To: <20240505194603.GH2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 May 2024 13:03:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipanX2KYbWvO5=5Zv9O3r8kA-tqBid0g3mLTCt_wt8OA@mail.gmail.com>
Message-ID: <CAHk-=wipanX2KYbWvO5=5Zv9O3r8kA-tqBid0g3mLTCt_wt8OA@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 May 2024 at 12:46, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I've no problem with having epoll grab a reference, but if we make that
> a universal requirement ->poll() instances can rely upon,

Al, we're note "making that a requirement".

It always has been.

Otgherwise, the docs should have shouted out DAMN LOUDLY that you
can't rely on all the normal refcounting of 'struct file' THAT EVERY
SINGLE NORMAL VFS FUNCTION CAN.

Lookie herte: epoll is unimportant and irrelevant garbage compared to
something fundamental like "read()", and what does read() do?

It does this:

        struct fd f = fdget_pos(fd);

        if (f.file) {
                ...

which is being DAMN CAREFUL to make sure that the file has the proper
refcounts before it then calls "vfs_read()". There's a lot of very
careful and subtle code in fdget_pos() to make this all proper, and
that even if the file is closed by another thread concurrently, we
*always* have a refcount to it, and it's always live over the whole
'vfs_read()' sequence.

'vfs_poll()' is NOT DIFFERENT in this regard. Not at all.

Now, you have two choices that are intellectually honest:

 - admit that epoll() - which is a hell of a lot less important -
should spend a small fraction of that effort on making its vfs_poll()
use sane

 - say that all this fdget_pos() care is uncalled for in the read()
path, and we should make all the filesystem .read() functions be aware
that the file pointer they get may be garbage, and they should use
get_file_active() to make sure every 'struct file *' use they have is
safe?

because if your choice is that "epoll can do whatever the f*&k it
wants", then it's in clear violation of all the effort we go to in a
MUCH MORE IMPORTANT code path, and is clearly not consistent or
logical.

Neither you nor Christian have explained why you think it's ok for
that epoll() garbage to magically violate all our regular rules.

Your claim that those regular rules are some new conditional
requirement that we'd be imposing. NO. They are the rules that
*anybody* who gets a 'struct file *' pointer should always be able to
rely on by default: it's damn well a ref-counted thing, and the caller
holds the refcount.

The exceptional case is exactly the other way around: if you do random
crap with unrefcounted poitners, it's *your* problem, and *you* are
the one who has to be careful. Not some unrelated poor driver that
didn't know about your f*&k-up.

Dammit, epoll is CLEARLY BUGGY. It's passing off random kernel
pointers without holding a refcount to them. THAT'S A BUG.

And fixing that bug is *not* somehow changing existing rules as you
are trying to claim. No. It's just fixing a bug.

So stop claiming that this is some "new requirement". It is absolutely
nothing of the sort. epoll() actively MISUSED file pointer, because
file pointers are fundamentally refcounted (as are pretty much all
sane kernel interfaces).

                Linus

