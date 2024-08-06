Return-Path: <linux-fsdevel+bounces-25176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2E89498C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32126283407
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E8F129A7E;
	Tue,  6 Aug 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXWXAxfD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32738DD8;
	Tue,  6 Aug 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974643; cv=none; b=hhOLyT6d0KqLz+DBYO+C0oxboO1DaMKnpxt1uUn29jGzp9MYZylRJExaJBcgs3ksTzIbdO0mwgmOLT1EMukTM4s6K97TU8fLcKeTRkhlR2kLu/Eb8TF+KLMSbmU5AroxXZZe8B/LjBMORtA4LsAZU9/gZo6Um40KyLbPL98VlqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974643; c=relaxed/simple;
	bh=B4xPK2nX0Jd4w3S9JKMHKt+B2SKQoIzCrl+47Covdds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLgCGGL6LcWbdLRoHm22uq/DehHtLIyfbEOc/P6I7M3HqEAthKKHDqJL+aUxuqnKDNYtIhvsckz+lTyHPXxLOqYoPp47681EO2S3BVb7lIF5mMkVHSFUV6/47NF57z6pROtuNTG/BgVPR4KQti/VHo6SXjyr1l2xcrKDdxzqVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXWXAxfD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so143039466b.1;
        Tue, 06 Aug 2024 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722974640; x=1723579440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4xPK2nX0Jd4w3S9JKMHKt+B2SKQoIzCrl+47Covdds=;
        b=dXWXAxfDVOqjArDuwzw5yRzebQBXxKGI3ticHnVCFCA9VVoQrA+upb11U/Ljkj0DCq
         lM5tOot1m4oS0j1f+j1GlyM71mAvzkQo53vDqLsKFJ7TMl2QrNsZz1vQlX24k/Q+kFCO
         whu038KJRsZtC7IjqwqNjp2vvoqM1osDodVq5c7xeQIs14s84mcy7Kmszrwllpe6t8tc
         kCeh/DvyPcNcrdH/fLDtuwFkDRWtootefmreyZiMZpyskJdpwv/FP1WUGxPiqN+FfBNt
         +lHz95/AGsG5D0SFbu0uRhMI11eIbMbhGqnoE4xXKtp/pGwdc0BNMBxAPdfJ6OYzKxbP
         xpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722974640; x=1723579440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4xPK2nX0Jd4w3S9JKMHKt+B2SKQoIzCrl+47Covdds=;
        b=ng4Vve/7ZPOeb7phzJvEBUydzPCxkpVqCHo5N4oPot4txLpK03f6ESy9f4/bqixq3a
         m6Z/xJkt55O0qwfAvzKI0Zs2INUwaQf02o/5UUHnzM5LhctqgXDxFi9oIS/XNEbzBpoA
         e/vAVfjblmBN/onz9dpbKHXuVYfiurI5gMdaBPjWBO8BYfLSQo/jOj73Pl/Hzvb1TGpN
         YERjfUOOmU5yHM3JCX/MRosUN7cVLU+jOyhg+voa2KfEpWgfR8MbqPwqhY8XJ4ctUsqd
         JiqiUeJfcgIEAivbvv2k6qA3dohSz8OJKjGYBpWz1mDnqAzxyH1d8O0I3/Sk59zmmfJY
         d2tA==
X-Forwarded-Encrypted: i=1; AJvYcCWpbZgf8P0iMwPjqvq8jg6Evx/mtf4koD5OELDwSO/BFHlpGsvSBzLTwkq3XBmhZIITiOTYIGsxGBI6wk9TkxuMxqvegtUK5Te5hjCIPvK10hZPpY6XcblHWKuBSe6cd8ftUHhWqSf1NvYDAg==
X-Gm-Message-State: AOJu0Yw6sijg4K3ht3mw7Loq8S9XLqtug3+Ss0NOn85+LMSGRjqfr1rS
	qK9C6cpVG3dMmtmlovd5of+ARtHwQ3aXzHJ9n1sTucGWfVKG1+7t1+y9jWtWei6lYX04wSLc3Rd
	9pKU3Fek9sqOKw2ocVP9RDd3UDTE=
X-Google-Smtp-Source: AGHT+IEzRE3yrGXS27rravqKK9dmF0CQofb6bIzWfbmGrAcDX3MyfhoXyTUjn5RXZOlcVkHoHOXCjPM6H3XdrA0+eLQ=
X-Received: by 2002:a17:907:d93:b0:a77:ab40:6d7f with SMTP id
 a640c23a62f3a-a7dc509f658mr1133251466b.43.1722974639740; Tue, 06 Aug 2024
 13:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com>
 <87ikwdtqiy.fsf@linux.intel.com> <44862ec7c85cdc19529e26f47176d0ecfc90d888.camel@kernel.org>
In-Reply-To: <44862ec7c85cdc19529e26f47176d0ecfc90d888.camel@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 6 Aug 2024 22:03:46 +0200
Message-ID: <CAGudoHGZVBw3h_pHDaaSMeDgf3q_qn4wmkfOoG6y-CKN9sZLVQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
To: Jeff Layton <jlayton@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:26=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Tue, 2024-08-06 at 12:11 -0700, Andi Kleen wrote:
> > Mateusz Guzik <mjguzik@gmail.com> writes:
> > >
> > > I would bench with that myself, but I temporarily don't have handy
> > > access to bigger hw. Even so, the below is completely optional and
> > > perhaps more of a suggestion for the future :)
> > >
> > > I hacked up the test case based on tests/open1.c.
> >
> > Don't you need two test cases? One where the file exists and one
> > where it doesn't. Because the "doesn't exist" will likely be slower
> > than before because it will do the lookups twice,
> > and it will likely even slow single threaded.
> >
> > I assume the penalty will also depend on the number of entries
> > in the path.
> >
> > That all seem to be an important considerations in judging the benefits
> > of the patch.
> >
>
> Definitely.
>
> FWIW, I did test a single threaded (bespoke) test case that did a bunch
> of O_CREAT opens, closes and then unlinks. I didn't measure any
> discernable difference with this patch. My conclusion from that was
> that the extra lockless lookup should be cheap.
>
> That said, this could show a difference if you have rather long hash
> chains that need to be walked completely, and you have to actually do
> the create every time. In practice though, time spent under the
> inode_lock and doing the create tends to dominate in that case, so I
> *think* this should still be worthwhile.
>
> I'll plan to add a test like that to will_it_scale unless Mateusz beats
> me to it. A long soak in linux-next is probably also justified with
> this patch.

Well if we are really going there I have to point out a couple of
three things concerning single-threaded performance from entering the
kernel to getting back with a file descriptor.

The headline is that there is a lot of single-threaded perf left on
the table and modulo a significant hit in terms of cycles it is going
to be hard to measure a meaningful result.

Before I get to the vfs layer, there is a significant loss in the
memory allocator because of memcg -- it takes several irq off/on trips
for every alloc (needed to grab struct file *). I have a plan what to
do with it (handle stuff with local cmpxchg (note no lock prefix)),
which I'm trying to get around to. Apart from that you may note the
allocator fast path performs a 16-byte cmpxchg, which is again dog
slow and executes twice (once for the file obj, another time for the
namei buffer). Someone(tm) should patch it up and I have some vague
ideas, but 0 idea when I can take a serious stab.

As for vfs, just from atomics perspective:
- opening a results in a spurious ref/unref cycle on the dentry, i
posted a patch [1] to sort it out (maybe Al will write his own
instead). single-threaded it gives about +5% to open/close rate
- there is an avoidable smp_mb in do_dentry_open, posted a patch [2]
and it got acked. i did not bother benching it
- someone sneaked in atomic refcount management to "struct filename"
to appease io_uring vs audit. this results in another atomic added to
every single path lookup. I have an idea what to do there
- opening for write (which you do with O_CREAT) calls
mnt_get_write_access which contains another smp_mb. this probably can
be sorted out the same way percpu semaphores got taken care of
- __legitimize_mnt has yet another smp_mb to synchro against unmount.
this *probably* can be sorted out with synchronize_rcu, but some care
is needed to not induce massive delays on unmount
- credential management is also done with atomics (so that's get + put
for the open/close cycle), $elsewhere I implemented a scheme where the
local count is cached in the thread itself and only rolled up on
credential change. this whacks the problem and is something i'm
planning on proposing at some point

and more

That is to say I completely agree this does add extra work, but the
kernel is not in shape where true single-threaded impact can be
sensibly measured. I do find it prudent to validate nothing happened
to somehow floor scalability of the case which does need to create
stuff though.

[1] https://lore.kernel.org/linux-fsdevel/20240806163256.882140-1-mjguzik@g=
mail.com/
[2] https://lore.kernel.org/linux-fsdevel/20240806172846.886570-1-mjguzik@g=
mail.com/

--=20
Mateusz Guzik <mjguzik gmail.com>

