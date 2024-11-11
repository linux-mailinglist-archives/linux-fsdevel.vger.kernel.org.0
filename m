Return-Path: <linux-fsdevel+bounces-34340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC59C49C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE129289470
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395261BD9C9;
	Mon, 11 Nov 2024 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ7lMQr/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89F38F83;
	Mon, 11 Nov 2024 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368186; cv=none; b=qjD2K+QxnOdB9RyAjzFdyrBYiYbMBx5u7sRTxK+eoLXVaRkTw1m+QCYvuiZZCUyYLEs3EPXd5RcCpyaPel3BoY1AXfuScDI53ZZt/7bDYuzWMEqlHH7subFGRGak96X+5unTHewrG06CqEQyWFz0ezgn46M3zoF7AnDOvo31h5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368186; c=relaxed/simple;
	bh=khCerP7Ay/PFkDwN9tHyFDanLd3uDgCYYA0oK2BT3Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqACCkLW2dtXWEZ86hnSCpm/gH9vt752pfkuBpw7IdLtPXeu9vPcB1hslHG7+P6SwhPVxTJ73NtLEfmvu4oc9VStrbgCgnx+iJDFCTr4LIOQHTywBHCjtlSU1vgNfghR9TbSUtuDG00HJ61AXKL1dk0n2OtlN7YKlzdnfWyVdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ7lMQr/; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5140cddb073so1075132e0c.3;
        Mon, 11 Nov 2024 15:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731368184; x=1731972984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB1YZjL/g4WPNa5p6ho7uTDJtxrw637uxbsOjPihoL4=;
        b=LQ7lMQr/9MyD8sDv3SOViHJHMMw9kmTSbCLikEJSALNfeYgspRKmttsYSfSpv6Nx+w
         g+tbI8yVXQdRqwUA8yRcLfijmNdFSE9otcbKWbhd+f+ZySApOTtRHAPWbYkLYjn5ef6W
         8gSYEVXwa5rlHlpBstXTs0jGwz9gnJ8piz8sFecI6z7ilGbQnEVltQst/IdwHHIZwdZZ
         IZNdIMVnQX+wm3YHrCYykcx9a3LYSl/n7l9OnzmbHDvxpxzKloHccPJomqc1AnhsNY6J
         i4kRJP5L6wWf+CD6nWPvbMrx2s6YWo9bW5GL1p4eRFSatIjBCYtTmgneGJf7iObCRWY5
         yYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368184; x=1731972984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB1YZjL/g4WPNa5p6ho7uTDJtxrw637uxbsOjPihoL4=;
        b=ssG90wyEkWkwybJ3o8WkM2Z9Ybx+Tbka/G08tK24Cmv1lzEzOYxV9C+nOXb328VMXB
         A4NJku8kB9IUB8Rh3GKvmd2RDQC5vQaUs700g63gDfdF2ciyhS6a5XOXT/2A5HfIKGCX
         1/yRyHHG6lwiu9H3GsBZ4C93gTphbgpbOnBnSJtYhDl7jvPY+UOKcgOUAREqt6ttcMGZ
         KzIReg0YYZk5myb4Xllyo3pu63EysEeSkgUPfXhNt/jdk6Zz9VRAwp0gYVFIqMpVvosa
         IV9ggxqns10hpaiKqJ16yjVCHNPmVPSz3DtqYun5EZ3E4E+PhLfVr3Sc8B18jx4YRWOS
         pNag==
X-Forwarded-Encrypted: i=1; AJvYcCUXFCMJESDEgBSwpeOyEa1VaU1LSuucqxGjCBLTojwfeWRfp3zYwU5RpnRmcdXJakulcWCGx51lVgmt1Exm7g==@vger.kernel.org, AJvYcCVTJHi9rCKuNA6v0CahXjnK3i3eH1iXAoLs0rEgia/HRZQsTzGi+GUUKdOvx9jRfSdL5jb0Rai6TlWmkw==@vger.kernel.org, AJvYcCVU7O4XgMEDGccvRn577zugeNmN28oAmar7khS5ZrHnLDmK6Nu0Tw/kVS752+x40/FSaHh8t19SSVQIuA==@vger.kernel.org, AJvYcCXxEe7mI0Fl0v6o/ZQxin7YxySac5Eig1wxgn30UDjUVeAYq3uv9XUuzHye1V+wsz8JPl5WoD96eHCJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0W0LZRDMnn1YeoZfGdUY0QCgSwzIJi5DCZNE2OwXvsCVC1Ffe
	k28X4UJmpTF8q8TB3+tRcxRG/H0dywPLH8BWE8TCfaqjKrmr4X50R01TVDBtoDi7yDI8pVNb8ko
	3Q7ilY5UblujdWYMTeBHCW56irDV5o/PrM4Q=
X-Google-Smtp-Source: AGHT+IHlHqW9AdZyfpZzGtvMz9MbvMwWSRsKkW2rbTmr8IjIKFtuxOJ6ThRYbwePpYz1fu+sC6uCZbkyQIGaylXfmVw=
X-Received: by 2002:a05:6122:2089:b0:50f:fe39:a508 with SMTP id
 71dfb90a1353d-51401eb04f6mr12944884e0c.11.1731368183658; Mon, 11 Nov 2024
 15:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
In-Reply-To: <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Nov 2024 00:36:12 +0100
Message-ID: <CAOQ4uxg0k4bGz6zOKS+Qt5BjEqDdUhvgG+5pLBPqSCcnQdffig@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 11 Nov 2024 at 12:19, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3782,7 +3782,15 @@ static int do_open(struct nameidata *nd,
> > +       /*
> > +        * This permission hook is different than fsnotify_open_perm() =
hook.
> > +        * This is a pre-content hook that is called without sb_writers=
 held
> > +        * and after the file was truncated.
> > +        */
> > +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0)=
;
> >  }
>
> Stop adding sh*t like this to the VFS layer.
>
> Seriously. I spend time and effort looking at profiles, and then
> people who do *not* seem to spend the time and effort just willy nilly
> add fsnotify and security events and show down basic paths.
>
> I'm going to NAK any new fsnotify and permission hooks unless people
> show that they don't add any overhead.
>

FWIW we did work to eliminate overhead long before posting the new hooks.

This prep work has already been merged back in v6.9:
https://lore.kernel.org/linux-fsdevel/20240317184154.1200192-1-amir73il@gma=
il.com/

After working closely with Oliver and kernel test robot to eliminate
the overhead
of the pre-content hooks and on the way, also reduce overhead of the existi=
ng
fanotify permission hooks that were merged back in the day.

> Because I'm really really tired of having to wade through various
> permission hooks in the profiles that I can not fix or optimize,
> because those hoosk have no sane defined semantics, just "let user
> space know".
>
> Yes, right now it's mostly just the security layer. But this really
> looks to me like now fsnotify will be the same kind of pain.
>
> And that location is STUPID. Dammit, it is even *documented* to be
> stupid. It's a "pre-content" hook that happens after the contents have
> already been truncated. WTF? That's no "pre".
>

Yeh, I understand why it seems stupid and it may have been poorly
documented, but there is actually a good reason for the location of
this hook.

The problem with the existing fsnotify_open_perm() hook is that
with O_CREATE, open_last_lookups() takes sb_writers freeze
protection (regardless if file with really created), so we cannot
safely use this hook to start writing to file and fill its content.

So the important part of the comment is:
"This permission hook is different than fsnotify_open_perm() hook.
 This is a pre-content hook that is called without sb_writers held"

The part that follows "and after the file was truncated", simply
means that in case of O_TRUNC we won't need to fill file content,
because the file will have zero size anyway.

And for the record, it is not "pre-open" it is "pre-content-access", so the
name may be confusing but it is not wrong.

> I tried to follow the deep chain of inlines to see what actually ends
> up happening, and it looks like if the *whole* filesystem has no
> notify events at all, the fsnotify_sb_has_watchers() check will make
> this mostly go away, except for all the D$ accesses needed just to
> check for it.
>
> But even *one* entirely unrelated event will now force every single
> open to typically call __fsnotify_parent() (or possibly "just"
> fsnotify), because there's no sane "nobody cares about this dentry"
> kind of thing.
>
> So effectively this is a new hook that gets called on every single
> open call that nobody else cares about than you, and that people have
> lived without for three decades.
>

That's exactly the reason for the commit
a5e57b4d370c fsnotify: optimize the case of no permission event watchers

It is supposed to reduce overhead to bare minimum for hooks of
events from the class "permission" (FSNOTIFY_PRIO_CONTENT), which
are typically only watched for Anti-malware software, so
fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT)
is typically false on any given fs.

And same for the new hooks for events of class "pre-content".
fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_PRE_CONTENT)
will only be true for fs of dedicated systems that run an HSM service, wher=
e
the overhead of the hooks is not going to be a concern.

> Stop it, or at least add the code to not do this all completely pointless=
ly.
>
> Because otherwise I will not take this kind of stuff any more. I just
> spent time trying to figure out how to avoid the pointless cache
> misses we did for every path component traversal.
>
> So I *really* don't want to see another pointless stupid fsnotify hook
> in my profiles.

I understand your frustration from crawling performance regressions, I
really do.
I am personally very grateful for the services of Oliver and his
kernel test robot
who test my development branches to catch regressions very soon in the
development
process.

We may have missed things along the way and you may yet find more issues
that justify another NAK, or more work, but you should know that a lot of c=
are
was taken to try to avoid inflicting pain on the system.

I have been practically doing vfs prep and cleanup work together with
Josef and Jan and Christian for at least a year before we got to post v1 of=
 the
pre-content patches.

So all I ask in return is that you consider the possibility that this is no=
t
utter garbage and try to work with us to address your concerns.

Pre-content hooks (and HSM) is a very powerful feature that many people
are requesting and I believe that we will be able to deliver this
feature without
crapping all over the VFS.

Thanks,
Amir.

