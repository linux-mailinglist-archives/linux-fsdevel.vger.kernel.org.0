Return-Path: <linux-fsdevel+bounces-25226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD6F949F54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DA5282D90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC067190466;
	Wed,  7 Aug 2024 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMnGbHYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788C6BFA3;
	Wed,  7 Aug 2024 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009579; cv=none; b=f8aqG0j2WHcMmLoZf7slSQCWYbCOlxsrAIzpez3DCER7SdVJlgRGL64xcfkuEJGi1q/UlHG/Ao+U2ux+eYHoRCvGiXfItJHTtN9o72rJtVb2wLDJwcDS2kVdR1yWIKFbkJoKBmE/xBBTe4NIvPEViTyrRbuOlloa8n5TE7aoBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009579; c=relaxed/simple;
	bh=ofyRRKO2zYH+BtgiGOTFOSJdLoIl8A/bu4ICuzb3+sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5IIHFwZhcNv+2SIw+vdr7FNf78prkXZXPag11L3AKLyiso91HbioFCmL9LPlivGAL5wLu/VR5VmjtVNqfCNpDUFEd4E2BKfkKhLdQSXK9RSi2OUl15WzwUzaupgSW2lqRnwblEN7Ikf5GWDH0KWrzp6XwDkLyKyLn3Ay9yYaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMnGbHYG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso20900611fa.2;
        Tue, 06 Aug 2024 22:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723009575; x=1723614375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcb8I7w4XJr73TE9YkB2Oy7AxbXGoDVjQzJSI+C8LeQ=;
        b=gMnGbHYGVpp7zew5l4LTRPeHtph3aWVbVqxD8m5Qim+HK75aB6JDfTre8OWSuNIWG4
         41xItFmjR9ksu3ncYKS8x5m3SMfWNwZlPfAJlKqqRvk6W71t077U+pttHQMsKNnMqtL6
         2BbSUjm8KFkmIo1xLhBHIMks8C16zEz5EHPBJdiJ0lLpOe0B5E3DC4qS5hUQLp6URry/
         Y7bmg+GuLwI0vG4PKdA9Lcay5ej7gTt4liMho8A6vPLiK4e+Stk9nzwaOZZ4oW5xuh2S
         gBygBqaIpt2TA/5opB1iXAfwy/EgzxGdEz45jlqadOzSDhx/SnSEmiqaHmcGvRU7CQO2
         ahvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723009575; x=1723614375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcb8I7w4XJr73TE9YkB2Oy7AxbXGoDVjQzJSI+C8LeQ=;
        b=Xi6T5U2ZlqvJxJ+7Vj5nhCZ+YJgi9HnunrCMk4/PGSRazAINegZBwEhEmfmghk3+h9
         7IzYNjb8dBreWT3IXLYOOLn0hmwpMiCg0vVQssiZS+YEzZ/pSRqESU6D3B0WxxvAR2TD
         UOaD6Gae+qZQ2T2/2ZE7wgKgIB1cqq9Xu+odB7aAvdVtxGQ6cAk7o51rI3/x0KQR7TQu
         MBeupIvi6gp1y/SL588uHQALW/r3LxjJaOC+uGEDHxdU/gVZvusMloYTdwBppAJcn4+p
         5JYBp3km4OhIXG9xbB9XT5wn54TtTrWtzAh5TOSg8DiRTCEG651OUvh1TREKmR/rECJQ
         uUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4M8pcerAbX7qNmxsupw3c7P48beUH6h6OfCWtXXMYdnzxOb5o6XAU4AXqjeTNxnHteI98OisqS1q+IS3mWXu2+MuTW0n0wgRv9AM3eIH0nYvOMBsNqy4RS3gG0A/dhoFDVyx9wTAMnPzzug==
X-Gm-Message-State: AOJu0YyOQ8TjGPd6n5/06yNFqTX9oZrU06UsDEn/a5Apm16SRkjr3LlW
	jr+TNFJwE4TZJ3CuAvPA0+dhK2UuNDgYWWKq7NE2IuH12qoeIEmmYlqYu3aD8VgObkoiQRqkrvB
	yVMXO2Q+S0IOmwCpVDBFFuduRE5NawKj5htk=
X-Google-Smtp-Source: AGHT+IH7v6xbC2zRXNuxMJ3RK08Eyos2aCCVQ6JCrQHyfYwIV1lQxxVyJwGdDzEFXgbSns5aJw4ItoP1KpZbiXviwls=
X-Received: by 2002:a2e:9cc9:0:b0:2ef:1c0f:a0f3 with SMTP id
 38308e7fff4ca-2f15aa88b76mr136938201fa.6.1723009574993; Tue, 06 Aug 2024
 22:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806144628.874350-1-mjguzik@gmail.com> <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
 <20240807033820.GS5334@ZenIV> <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807053232.GT5334@ZenIV>
In-Reply-To: <20240807053232.GT5334@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Aug 2024 07:46:02 +0200
Message-ID: <CAGudoHFoVHk1ZZOa=Bbb1MyGgSxeAK1bMvLPFKnagzuLz7PBGw@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:32=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Wed, Aug 07, 2024 at 05:57:07AM +0200, Mateusz Guzik wrote:
>
> [there'll be a separate reply with what I hope might be a usable
> approach]
>

At the moment I'm trying to get the spurious lockref cycle out of the
way because it is interfering with the actual thing I'm trying to do.

This entire pointer poisoning business is optional and the v2 I posted
does not do any of it.

With this in mind can you review v2? Here is the link for reference:
https://lore.kernel.org/linux-fsdevel/20240806163256.882140-1-mjguzik@gmail=
.com/T/#u

As for the feedback below, I'm going to circle back to it when I take
a stab at adding debug macros, but no ETA.

> > Yes, this is my understanding of the code and part of my compliant. :)
> >
> > Things just work(tm) as is with NULLified pointers, but this is error-p=
rone.
>
> And carrying the arseloads of information (which ones do and which do not
> need to be dropped) is *less* error-prone?  Are you serious?
>
> > As a hypothetical suppose there is code executing some time after
> > vfs_open which looks at nd->path.dentry and by finding the pointer is
> > NULL it concludes the lookup did not work out.
> >
> > If such code exists *and* the pointer is poisoned in the above sense
> > (notably merely branching on it with kasan already traps), then the
> > consumer will be caught immediately during coverage testing by
> > syzkaller.
>
> You are much too optimistic about the quality of test coverage in this
> particular area.
>
> > If such code exists but the pointer is only nullified, one is only
> > going to find out the hard way when some functionality weirdly breaks.
>
> To do _useful_ asserts, one needs invariants to check.  And "we got
> to this check after having passed through that assignment at some
> earlier point" is not it.  That's why I'm asking questions about
> the state.
>
> The thing is, suppose I (or you, or somebody else) is trying to modify
> the whole thing.  There's a magical mystery assert in the way; what
> should be done with it?  Move it/split it/remove it/do something
> random and hope syzkaller won't catch anything?  If I can reason
> about the predicate being checked, I can at least start figuring out
> what should be done.  If not, it's bloody guaranteed to rot.
>
> This particular area (pathwalk machinery) has a nasty history of
> growing complexity once in a while, with following cleanups and
> massage to get it back into more or less tolerable shape.
> And refactoring that had been _painful_ - I'd done more than
> a few there.
>
> As far as I can tell, at the moment this flag (and yes, I've seen its
> removal in the next version) is "we'd called vfs_open_consume() at
> some point, then found ourselves still in RCU mode or we'd called
> vfs_open_consume() more than once".
>
> This is *NOT* a property of state; it's a property of execution
> history.  The first part is checked in the wrong place - one of
> the invariants (trivially verified by code examination) is that
> LOOKUP_RCU is never regained after it had been dropped.  The
> only place where it can be set is path_init() and calling _that_
> between path_init() and terminate_walk() would be
>         a) a hard and very visible bug
>         b) would've wiped your flag anyway.
> So that part of the check is basically "we are not calling
> vfs_open_consume() under rcu_read_lock()".  Which is definitely
> a desirable property, since ->open() can block.  So can
> mnt_want_write() several lines prior.  Invariant here is
> "the places where we set FMODE_OPENED or FMODE_CREATED may
> not have LOOKUP_RCU".  Having
>         if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
>                 error =3D complete_walk(nd);
>                 if (error)
>                         return error;
>         }
> in the beginning of do_open() guarantees that for vfs_open()
> call there.  All other places where that can happen are in
> lookup_open() or called from it (via ->atomic_open() to
> finish_open()).  And *that* definitely should not be done
> in RCU mode, due to
>         if (open_flag & O_CREAT)
>                 inode_lock(dir->d_inode);
>         else
>                 inode_lock_shared(dir->d_inode);
>         dentry =3D lookup_open(nd, file, op, got_write);
> in the sole caller of that thing.  Again, can't grab a blocking
> lock under rcu_read_lock().  Which is why we have this
>                 if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU))
>                         return ERR_PTR(-ECHILD);
>         } else {
>                 /* create side of things */
>                 if (nd->flags & LOOKUP_RCU) {
>                         if (!try_to_unlazy(nd))
>                                 return ERR_PTR(-ECHILD);
>                 }
> slightly prior to that call.  WARN_ON_ONCE is basically "lookup_fast()
> has returned NULL and stayed in RCU mode", which should never happen.
> try_to_unlazy() is straight "either switch to non-RCU mode or return an
> error" - that's what this function is for.  No WARN_ON after that - it
> would only obfuscate things.
>
> *IF* you want to add debugging checks for that kind of stuff, just call
> that assert_nonrcu(nd), make it check and whine and feel free to slap
> them in reasonable amount of places (anything that makes a reader go
> "for fuck sake, hadn't we (a) done that on the entry to this function
> and (b) done IO since then, anyway?" is obviously not reasonable, etc. -
> no more than common sense limitations).
>
> Another common sense thing: extra asserts won't confuse syzkaller, but
> they very much can confuse a human reader.  And any rewrites are done
> by humans...
>
> As for the double call of vfs_open_consume()...  You do realize that
> the damn thing wouldn't have reached that check if it would ever have
> cause to be triggered, right?  Seeing that we call
> static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
> {
>         /* Pairs with smp_store_release() in do_idmap_mount(). */
>         return smp_load_acquire(&mnt->mnt_idmap);
> }
> near the beginning of do_open(), ~20 lines before the place where
> you added that check...
>
> I'm not sure it makes sense to defend against a weird loop appearing
> out of nowhere near the top of call chain, but if you want to do that,
> this is not the right place for that.



--=20
Mateusz Guzik <mjguzik gmail.com>

