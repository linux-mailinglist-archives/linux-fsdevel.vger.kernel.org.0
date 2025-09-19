Return-Path: <linux-fsdevel+bounces-62250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4CBB8A9E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD7C7C4DC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861823815B;
	Fri, 19 Sep 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCkb7KXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6A274671
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300122; cv=none; b=XuDcPEnIK88xKBdFQxFdHnUY1Q4+Kctzw88QJzdss8K0V3W83bEHpXZZ/36wV7I8kXhTmW0grzs7cgAvNZA9qWBGtiXGAQHBWcOy3dWRT0I+45kUkFpYWB/6W69flAsRKuXNzMFKLZrgjeMpcmTRDOKd4vx0dOJO3ZXLYnYfFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300122; c=relaxed/simple;
	bh=zdQAym0+SExRlmqgwYNy4yL7xgSdDP9l1DnQsZE82X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFa4sIRMxeYam03Z4MPYrIeByeo6uvvb9UvPJR5hPNC4WszK3rln2lwy+3U5vHgl+ApqqSE1jPGC+1eAWgJAy5SL1VugPQmLTpMHnGW3tb+vkDymoUMYlWdzYTesRLusE22gVws3ojzlz3Hwfbl9GZslWZ/cOhb42/C87w9ax9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCkb7KXG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b042cc3954fso413799866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758300118; x=1758904918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsnyF0VHRrVolM4i341slmIcokZeOpzDL2ggCkMkYCI=;
        b=hCkb7KXGAWuBGWopgQb97ImEBTB6Lxpp7RxdwNmeTCHWN98bCv/RN+3rxEIVGmuQJr
         SHt3Qr16Yd7z9YKmaRWGOfFmJXeqooxHhlHKic3KvXwiMTiTh1Y3yMERdT167b9awMfS
         gOIDX3FPbNP117YU/j3NYm+76EezgJHfIOM9W2XN7CN4D1OUDFfA4SMgrJWnbMZJLFIg
         JGPQ5D3lkuoH7Lu52ga6C283RF/515ZQaUBPzRmMSjvnW/tgwA1mjJfinJF+zPF5WyDI
         hWUO0woqcJkaTUFFspIy2uVY7CqoinqJHG61gPiQwcL9tYuNCJ+uBqncUbpkIi0YhEJA
         x7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300118; x=1758904918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsnyF0VHRrVolM4i341slmIcokZeOpzDL2ggCkMkYCI=;
        b=RtkzuZF/h34z1+ke7SiWd2P1snAGAVH4vI+2s0JBxWoGS2+htHAsAHB0e0GibG2vZ2
         ufD4TNLeuXmYWgScZoXkEPD4w662OBG4NQqvElruuGIm35LWbRQe9peeLd87LlvN4EAe
         QbOeJnnhFtRVqLk89LSja/g/m4ct8l/5Ka+OQPwH7gabXsHUPul2YcfptY3LXRbtuPm7
         agsYOjSIGFprFEvIeNp7t83Sa4kKeIeKSPFT6OxcypGCnHatzInC7JRjRR5Y5SOMcgTI
         YHlpN7/ExYnPGY2DeYON1SyBecloxUiodyd4Nh6ZYZsNXjYVeafYGDxnNvpiFiTJ50D3
         tjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYFsVZT9fql3p/ejzmvf4vejf1W35ddpTKXRPRe8GTGn2Fzg57Jed8mtJ/ITre7q1RrbFG9Obn/46RTOQz@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYCq+zAF9EnkWYwsJ8ySBoDnIiBeKoa93tH/WJeljxlnhWdrX
	DqBsb33Pep2WbY5eZyzycFnSWCf9bz7UB09bcB3qKOr+EJs8SM6GmePwAc7GvHtAp5666xSisN0
	2sTbuNLczSOWiZxt8QsE8aaITq/T/VZ4=
X-Gm-Gg: ASbGnctZvfXzXtEfZmlaGFVhBGGu88Mm6gr1qxT9Wt+FlV7xu2ZqDFBmPo/6oXNDBJC
	+GexD1fYzsm0Ootp6L70ByMWNX3OH8hOltypUKrQo88YkSEj+x/nlyjbxEOh+j2DKaDFD6HyBaB
	bf6WRhYAtL2Nz3xcrlx/y9WM6vNKmHIUQg0Jg9xdmdIk7fYY9miFCFr7fhtHl7yJfH/Qb4YX+Yk
	D7Y6YXYOM+/f8rfQQq8HjKk6wr/EMBjcTWHqCU=
X-Google-Smtp-Source: AGHT+IFyj2IGGQ0KzXofzY2LkTHDPpUBMzfl6SZmFJEGyJy+I4TCxmC8lvKEB78M6wg0X5bfvGuqzxh+MZbKrbtE6Ps=
X-Received: by 2002:a17:906:dc8f:b0:b1d:285d:1869 with SMTP id
 a640c23a62f3a-b24e23d0f97mr430424966b.0.1758300117737; Fri, 19 Sep 2025
 09:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <aMs7WYubsgGrcSXB@dread.disaster.area> <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
 <CAGudoHEpd++aMp8zcquh6SwAAT+2uKOhHcWRcBEyC6DRS73osA@mail.gmail.com> <aMtlknQpc3NRNSfH@dread.disaster.area>
In-Reply-To: <aMtlknQpc3NRNSfH@dread.disaster.area>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Sep 2025 18:41:44 +0200
X-Gm-Features: AS18NWD8fqrzGhGXWcP16ccmNdsGGV9N_tNdGuH20QcSDTikssGdahdEavd5hZU
Message-ID: <CAGudoHHtSpoqami61KxAJBsk77G0wCTSy-zvNH9W8Pb+S3PoQA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Max Kellermann <max.kellermann@ionos.com>, 
	slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 3:51=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Thu, Sep 18, 2025 at 02:04:52AM +0200, Mateusz Guzik wrote:
> > On Thu, Sep 18, 2025 at 1:08=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbi=
t.com> wrote:
> > > > - wait for Josef to finish his inode refcount rework patchset that
> > > >   gets rid of this whole "writeback doesn't hold an inode reference=
"
> > > >   problem that is the root cause of this the deadlock.
> > > >
> > > > All that adding a whacky async iput work around does right now is
> > > > make it harder for Josef to land the patchset that makes this
> > > > problem go away entirely....
> > > >
> > >
> > > Per Max this is a problem present on older kernels as well, something
> > > of this sort is needed to cover it regardless of what happens in
> > > mainline.
> > >
> > > As for mainline, I don't believe Josef's patchset addresses the probl=
em.
> > >
> > > The newly added refcount now taken by writeback et al only gates the
> > > inode getting freed, it does not gate almost any of iput/evict
> > > processing. As in with the patchset writeback does not hold a real
> > > reference.
> > >
> > > So ceph can still iput from writeback and find itself waiting in
> > > inode_wait_for_writeback, unless the filesystem can be converted to
> > > use the weaker refcounts and iobj_put instead (but that's not
> > > something I would be betting on).
> >
> > To further elaborate, an extra count which only gates the struct being
> > freed has limited usefulness. Notably it does not help filesystems
> > which need the inode to be valid for use the entire time as evict() is
> > only stalled *after* ->evict_inode(), which might have destroyed the
> > vital parts.
>
> Not sure I follow you - ->evict_inode() comes after waiting for
> writeback and other VFS operations to complete. There's nothing in
> the VFS eviction code that actually blocks after ->evict_inode() is
> called.
>

I'm stating that on the stock kernel writeback is indeed guaranteed to
finish first.

My general note there was that the refcount patchset only gates
freeing, consequently reducing its usefulness.

> > For example it
> > may be ceph needs the full reference in writeback,
>
> IMO, we should always hold a full reference in writeback, because
> doing so addresses the underlying eviction vs writeback race
> condition that exists. i.e. we currently handle the lack of
> reference counts in writeback by blocking on I_SYNC in eviction to
> prevent a UAF.
>
> If we have an active reference for writeback in the first
> place then eviction doesn't need to block on writeback because, by
> definition, we cannot be performing writeback and eviction at the
> same time....
>

I agree with the benefit

The problem here is that on the stock kernel writeback is guaranteed
to never invoke ->evict_inode et al.

Just allowing it to hold the ->i_count ref would mean there would be
corner cases where it has to go through with the actual iput(), which
imo would constitute a regression.

If iput_async() as a first class citizen showed up, I would be all for
holding the real ref around writeback.

Looks like we agree something of the sort should be implemented, I
repeat however that the refcount patchset is imo not the way to get
there.

> > then the new ref is
> > of no use here. But for the sake of argument let's say ceph will get
> > away with the ligher ref instead. Even then this is on the clock for a
> > different filesystem to show up which can't do it and needs an async
> > iput and then its developers are looking at "whacky work arounds".
>
> Right, that's because we haven't addressed the underlying problem.
>
> That is, we need to hold the right references at the VFS level such
> that filesystems can't drop the last reference to the inode whilst
> high level VFS inode operations (such as writeback) are in progress
> on that inode.
>
> Done properly, eviction can then be done asynchronously for all
> inodes because we've guaranteed there are no active or
> pending active users of the inode....
>
> .... and at that point, all the custom async inode garbage
> collection stuff that XFS does goes away because it is native
> VFS functionality :)
>

I completely agree here, I just claim the patchset by Josef does not
move the kernel in that direction.

> > The actual generic async iput is the actual async iput, not an
> > arbitrary chunk of it after the inode is partway through processing.
> > But then any form of extra refcounting is of no significance.
> >
> > To that end a non-whacky mechanism to defer iput would be most
> > welcome, presumably provided by the vfs layer itself. Per remarks by
> > Al elsewhere, care needs to be taken to make sure all inodes are
> > sorted out before the super block gets destroyed.
>
> Yes, but first we have to get the reference counting right, such
> that inode eviction only occurs after we've guaranteed there are no
> other active users of the inode. Page cache residency and dirty
> inodes are still in active use, we should account for them that way.
>

I don't have a strong opinion here. If anything I find it suspicious
that code invoked by writeback can end up issuing iput() on something,
but that's not something I'm going to die on a hill for.

Also note the refs as proposed by Josef don't fit the idea as they
allow for majority of iput() to progress.

I claim there are issues concerning flag management (I_WILL_FREE et
al) which would best sorted out before changes in refcount management
are implemented (of whatever variety).

> > This suggests expanding the super_block to track all of the deferred
> > iputs and drain them early in sb destruction. The current struct inode
> > on LP64 has 2 * 4 byte holes and llist linkage is only 8 bytes, so
> > this can be added without growing the struct above stock kernel.
>
> Right, we already do this lockless llist based async garbage
> collection under ->destroy_inode with XFS.
>
> > I would argue it would be good if the work could be deffered to
> > task_work if possible (fput-style). Waiting for these should be easy
> > enough, but arguably the thread which is supposed to get to them can
> > be stalled elsewhere indefinitely, so perhaps this bit is a no-go.
>
> If the reference counting is right, nothing expect a new lookup on
> the inode should stall on an inode queued for eviction...
>

The remark about getting stuck did not concern anything
inode-specific. Rather, any thread can get stuck indefinitely in
certain parts of the kernel. Should that happen after it has iput to
process in task_work, that could be a problem for the mechanism.

Anyhow, the *pressing* issue right now is sorting out the deadlock for
ceph including for kernels older than mainline. And for that I don't
think the patch as proposed by Max is objectionable. (granted though,
I thought the vfs layer would wait for all inodes during unmount
instead of barfing, but ceph is draining the queue the patch postponed
the work to so it should be fine. extra points for the fact that ceph
already used to have iput_async).

