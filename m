Return-Path: <linux-fsdevel+bounces-31415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F7995F78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 08:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D461F23DFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406516F282;
	Wed,  9 Oct 2024 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiNZ14H2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55F36D;
	Wed,  9 Oct 2024 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454245; cv=none; b=JXQgsEEh5KMF11HjLI8Qnz1uJafU70Crpt9L3ahyKP3LJkat7KXVEpAuFjBvU7frPlHysd0YqbFAUdpGzTnoimwCZ+I6S01+JL8cIUBQV0NC2mn1I1E6QgMNQ/4NUwD9Nwfalx5Vmbk0czWEhuAmP3rdAiE9OZsXywZzzAgQ9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454245; c=relaxed/simple;
	bh=RdBWdWxGVyp+5Nof5w3sn1QFaGwjFcn9GtLFXgl7wk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=athg0imYJOBFWMNqKcy97r5F7rDQ7AajrOSizGXLW3JKDEf6hi5GdMVzWwXZ8oA12qnViEpP+2x4zXcI4AtX9+hU9EbDHzOVY3CviKVoumuOxyjJOUeF/ehi1Di2h8fB9zLdEU318e1vkARakN4VZW5p2rKshzDt/a06bdh5xVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiNZ14H2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7acdd65fbceso503458885a.3;
        Tue, 08 Oct 2024 23:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728454242; x=1729059042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ui4szlwk2nThXCz611znwbVCqX5LskAI+9OcNuaAK/4=;
        b=UiNZ14H2d1DkVsV4iEERndE9xv38MV16o0OTL+SZzCpYwDVc3jZPu69IcleHkO9Ds+
         1XMS2tZsKmiUHwLO/E1KavHeR0IuHWSuF7dEkUlvEQRiPTOtFDU/Cnxv3+c9PfpRVT0M
         bbMOpSbQHUqi6cKPtup2CFNPcSMT4kIG2GnUlcO+PdpZcU6Ybbm8Fd4ml4erZMMHH6Uj
         JXi882Z7xBu+nZW2/rsbf7BEM/FbstB23kEdoFDdzDFfT10HPv8VVxsgC61+DKcBEyXQ
         CjiKtxUoZLvpYmxHWKKrAT7zIW8K4RvYcylGqnjBIMrZJmQFhE870hScPwXFma3KBs5O
         lZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728454242; x=1729059042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui4szlwk2nThXCz611znwbVCqX5LskAI+9OcNuaAK/4=;
        b=P57bW3gEZ6EMKYc8PtsGbBw3jPi1RxA1ulnQE5NUdmNOSLy4k+Vv211UiS/9cVx6VT
         jyR94IkSg2Z7Y4tVxKgUu4LqmLlg4L0p+wFsKUaUrS0lbqAf1hpFIntV8mVWIqgomznx
         j48pwBDBjuxTk9MAIUOU8Bsv5mZLDFyMPE0NIYJ0WoIpXoAGZR7ecdblYY6NlcM2Wrht
         B7JMq3CF4bKepdTtpvfX0ic9cCSoTO/RU93/usL/sKo4hoVK4k1GCCU2TTj4tOB4M3Cc
         /+jF5SgLUXENFhRwxzmx1zXItQRnEfpTBZjGNQbD651sSDI9jGxB32pLOP+cX9miLsNN
         7GgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp7vACIDIioA07Qpb/hr6RAX+EoFUw7LPoRun1ot25OyJomuGEi5EocW8p34Rk2xp8MvbLodHzJ/QhFszoWw==@vger.kernel.org, AJvYcCVgmvAOaPasGlxM4Jk3EjWKIuFzSGGwQ0jsmTh0gq5eXg4aHeQThRH8a348dTFnLS5a0vqK79xi0DS+11CpVQ==@vger.kernel.org, AJvYcCWBwqq4qxYFsa0HjfVRqNtuoPoDOwKa4WPe3ExdW/ZXneWLOcupTMhO/HAxV7GSwsoGzn7ZTPXLB0ya@vger.kernel.org, AJvYcCWawYHx/a1Ow+bYr3tksQkj8uk2fpwTSy1UOzs9yeqezfkPlm9yLaDJLIoqKvHlLCIWHO1HrlmyALe86vv8QqDs8sb4NUsY@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGsrwj+uMXI5W0Kh7jxu6wM6dzXaWvXa0kmXJIj+/zJRO9Mc5
	OdEtTUCFYp3jw/eBy3DpTSBvLebpO+QFhhAzeUo10jzrCl+SU8SCVr4vYkt2I68rUXRxcPMGvpu
	JIm962ZOWNDtjDO2/gN2FPoUEU2E=
X-Google-Smtp-Source: AGHT+IEp/EChg31sRq6snrYUHTCq45Fud33e1ZXwlB8Ptwi9260S6FJYBUXMRk1No6Tvrdjftgfxa7/NPyoljVuvkAc=
X-Received: by 2002:a05:620a:191e:b0:7a3:7889:4af0 with SMTP id
 af79cd13be357-7b07954bf54mr183899385a.28.1728454242249; Tue, 08 Oct 2024
 23:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002014017.3801899-1-david@fromorbit.com> <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org> <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3> <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area> <CAOQ4uxgzPM4e=Wc=UVe=rpuug=yaWwu5zEtLJmukJf6d7MUJow@mail.gmail.com>
 <20241008112344.mzi2qjpaszrkrsxg@quack3> <ZwXDzKGj6Bp28kYe@dread.disaster.area>
In-Reply-To: <ZwXDzKGj6Bp28kYe@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Oct 2024 08:10:30 +0200
Message-ID: <CAOQ4uxhXOifdohHE+3t-2hznsJfYf0KEy1XEkc653ub2OjeO4A@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:44=E2=80=AFAM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Tue, Oct 08, 2024 at 01:23:44PM +0200, Jan Kara wrote:
> > On Tue 08-10-24 10:57:22, Amir Goldstein wrote:
> > > On Tue, Oct 8, 2024 at 1:33=E2=80=AFAM Dave Chinner <david@fromorbit.=
com> wrote:
> > > >
> > > > On Mon, Oct 07, 2024 at 01:37:19PM -0700, Linus Torvalds wrote:
> > > > > On Thu, 3 Oct 2024 at 04:57, Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > Fair enough. If we go with the iterator variant I've suggested =
to Dave in
> > > > > > [1], we could combine the evict_inodes(), fsnotify_unmount_inod=
es() and
> > > > > > Landlocks hook_sb_delete() into a single iteration relatively e=
asily. But
> > > > > > I'd wait with that convertion until this series lands.
> > > > >
> > > > > Honza, I looked at this a bit more, particularly with an eye of "=
what
> > > > > happens if we just end up making the inode lifetimes subject to t=
he
> > > > > dentry lifetimes" as suggested by Dave elsewhere.
> > > >
> > > > ....
> > > >
> > > > > which makes the fsnotify_inode_delete() happen when the inode is
> > > > > removed from the dentry.
> > > >
> > > > There may be other inode references being held that make
> > > > the inode live longer than the dentry cache. When should the
> > > > fsnotify marks be removed from the inode in that case? Do they need
> > > > to remain until, e.g, writeback completes?
> > > >
> > >
> > > fsnotify inode marks remain until explicitly removed or until sb
> > > is unmounted (*), so other inode references are irrelevant to
> > > inode mark removal.
> > >
> > > (*) fanotify has "evictable" inode marks, which do not hold inode
> > > reference and go away on inode evict, but those mark evictions
> > > do not generate any event (i.e. there is no FAN_UNMOUNT).
> >
> > Yes. Amir beat me with the response so let me just add that FS_UMOUNT e=
vent
> > is for inotify which guarantees that either you get an event about some=
body
> > unlinking the inode (e.g. IN_DELETE_SELF) or event about filesystem bei=
ng
> > unmounted (IN_UMOUNT) if you place mark on some inode. I also don't see=
 how
> > we would maintain this behavior with what Linus proposes.
>
> Thanks. I didn't respond last night when I read Amir's decription
> because I wanted to think it over. Knowing where the unmount event
> requirement certainly helps.
>
> I am probably missing something important, but it really seems to me
> that the object reference counting model is the back to
> front.  Currently the mark is being attached to the inode and then
> the inode pinned by a reference count to make the mark attached
> to the inode persistent until unmount. This then requires the inodes
> to be swept by unmount because fsnotify has effectively leaked them
> as it isn't tracking such inodes itself.
>
> [ Keep in mind that I'm not saying this was a bad or wrong thing to
> do because the s_inodes list was there to be able to do this sort of
> lazy cleanup. But now that we want to remove the s_inodes list if at
> all possible, it is a problem we need to solve differently. ]
>
> AFAICT, inotify does not appear to require the inode to send events
> - it only requires access to the inode mark itself. Hence it does
> not the inode in cache to generate IN_UNMOUNT events, it just
> needs the mark itself to be findable at unmount.  Do any of the
> other backends that require unmount notifications that require
> special access to the inode itself?
>

No other backend supports IN_UNMOUNT/FS_UNMOUNT.
We want to add unmount events support to fanotify, but those are
only going to be possible for watching a mount or an sb, not inodes.

> If not, and the fsnotify sb info is tracking these persistent marks,
> then we don't need to iterate inodes at unmount. This means we don't
> need to pin inodes when they have marks attached, and so the
> dependency on the s_inodes list goes away.
>
> With this inverted model, we need the first fsnotify event callout
> after the inode is instantiated to look for a persistent mark for
> the inode. We know how to do this efficiently - it's exactly the
> same caching model we use for ACLs. On the first lookup, we check
> the inode for ACL data and set the ACL pointer appropriately to
> indicate that a lookup has been done and there are no ACLs
> associated with the inode.
>
> At this point, the fsnotify inode marks can all be removed from the
> inode when it is being evicted and there's no need for fsnotify to
> pin inodes at all.
>
> > > > > Then at umount time, the dentry shrinking will deal with all live
> > > > > dentries, and at most the fsnotify layer would send the FS_UNMOUN=
T to
> > > > > just the root dentry inodes?
> > > >
> > > > I don't think even that is necessary, because
> > > > shrink_dcache_for_umount() drops the sb->s_root dentry after
> > > > trimming the dentry tree. Hence the dcache drop would cleanup all
> > > > inode references, roots included.
> > > >
> > > > > Wouldn't that make things much cleaner, and remove at least *one*=
 odd
> > > > > use of the nasty s_inodes list?
> > > >
> > > > Yes, it would, but someone who knows exactly when the fsnotify
> > > > marks can be removed needs to chime in here...
> >
> > So fsnotify needs a list of inodes for the superblock which have marks
> > attached and for which we hold inode reference. We can keep it inside
> > fsnotify code although it would practically mean another list_head for =
the
> > inode for this list (probably in our fsnotify_connector structure which
> > connects list of notification marks to the inode).
>
> I don't think that is necessary. We need to get rid of the inode
> reference, not move where we track inode references. The persistent
> object is the fsnotify mark, not the cached inode. It's the mark
> that needs to be persistent, and that's what the fsnotify code
> should be tracking.
>
> The fsnotify marks are much smaller than inodes, and there going to
> be fewer cached marks than inodes, especially once inode pinning is
> removed. Hence I think this will result in a net reduction in memory
> footprint for "marked-until-unmount" configurations as we won't pin
> nearly as many inodes in cache...
>

It is a feasible design which has all the benefits that you listed.
But it is a big change, just to get away from s_inodes
(much easier to maintain a private list of pinned inodes).

inotify (recursive tree watches for that matter) has been
inefficient that way for a long time, and users now have less
memory hogging solutions like fanotify mount and sb marks.
granted, not unprivileged users, but still.

So there needs to be a good justification to make this design change.
One such justification would be to provide the infrastructure to
the feature that Jan referred to as the "holy grail" in his LPC talk,
namely, subtree watches.

If we introduce code that looks up persistent "mark rules" on
inode instantiation, then we could use it to "reconnect" inotify
persistent inode marks (by ino/fid) or to establish automatic
marks based on subtree/path based rules.

audit code has something that resembles this and I suspect that
this Landlock is doing something similar (?), but I didn't check.
path based rules are always going to be elusive and tricky and
Al is always going to hate them ;)

Bottom line - good idea, not easy, requires allocating development resource=
s.

Thanks,
Amir.

