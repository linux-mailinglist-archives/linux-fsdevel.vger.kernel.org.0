Return-Path: <linux-fsdevel+bounces-9255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A583FA00
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1995B21875
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A793C460;
	Sun, 28 Jan 2024 21:11:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A752EB1C;
	Sun, 28 Jan 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706476271; cv=none; b=u/yf/jxGGFLjRZVLic1b4AjJLj6uFz1H02feJIGGPo+aA6pVL8aBUGJO+QR6CbIFIfkI9GzIY6ed5epsYjDG6h+6H6g41gJrGRs83KzCRQQuHyXL+/MpRTg4eyLGUQnfcVpEwT3pkpbekbD+XbClBgFpF9yFe01Q28zNOLzhlAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706476271; c=relaxed/simple;
	bh=7EoMtBfT4xrORhmdqFRQIB2xMAGG1Pl7zzI9Zn/zAoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvNrTZkSv1mVf/WkW1KfAUggO/RtnV9PHdLwlu7rYEWM5GK4xOG2GBgW3pxGC5hpNT1qJHaRpA65Eb2QWfKjxtimS8X2McyjtzqnNkmQkNLz9tiUt8ZDkDf8br08CEi/fRIfIKACD4/lk3A0ATQ+2oGsP2acu1yAyWDlISIy79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9ACC433F1;
	Sun, 28 Jan 2024 21:11:09 +0000 (UTC)
Date: Sun, 28 Jan 2024 16:11:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128161107.01af6dd2@rorschach.local.home>
In-Reply-To: <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
	<20240128151542.6efa2118@rorschach.local.home>
	<CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 12:53:31 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 28 Jan 2024 at 12:15, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I have to understand how the dentry lookup works. Basically, when the
> > ei gets deleted, it can't be freed until all dentries it references
> > (including its children) are no longer being accessed. Does that lookup
> > get called only when a dentry with the name doesn't already exist?  
> 
> Dentry lookup gets called with the parent inode locked for reading, so
> a lookup can happen in parallel with readdir and other dentry lookup.
> 
> BUT.
> 
> Each dentry is also "self-serializing", so you will never see a lookup
> on the same name (in the same directory) concurrently.

The above is what I wanted to know.

> 
> The implementation is very much internal to the VFS layer, and it's
> all kinds of nasty, with a new potential lookup waiting for the old
> one, verifying that the old one is still usable, and maybe repeating
> it all until we find a successful previous lookup or we're the only
> dentry remaining.
> 
> It's nasty code that is very much in the "Al Viro" camp, but the point
> is that any normal filesystem should treat lookups as being concurrent
> with non-creation events, but not concurrently multiples.
> 
> There *is* some common code with "atomic_open()", where filesystems
> that implement that then want to know if it's the *first* lookup, or a
> use of a previously looked up dentry, and they'll use the
> "d_in_lookup()" thing to determine that. So this whole "keep track of
> which dentries are *currently* being looked up is actually exposed,
> but any normal filesystem should never care.
> 
> But if you think you have that issue (tracefs does not), you really
> want to talk to Al extensively.
> 
> > That is, can I assume that eventfs_root_lookup() is only called when
> > the VFS file system could not find an existing dentry and it has to
> > create one?  
> 
> Correct. For any _particular_ name, you should think of lookup as serialized.
> 
> > If that's the case, then I can remove the ei->dentry and just add a ref
> > counter that it was accessed. Then the final dput() should call
> > eventfs_set_ei_status_free() (I hate that name and need to change it),
> > and if the ei->is_freed is set, it can free the ei.  
> 
> Note that the final 'dput()' will happen *after* the dentry has been
> removed, so what can happen is
> 
>    lookup("name", d1);
>    ... lookup successful, dentry is used ..
>    ... dentry at some point has no more users ..
>    ... memory pressure prunes unused dentries ..
>    ... dentry gets unhashed and is no longer visible ..
>    lookup("name", d2);
>    ... new dentry is created ..
>    final dput(d1);
>    .. old dentry - that wasn't accessible any more is freed ..

Actually I was mistaken. I'm looking at the final iput() not dput().

> 
> and this is actually one of the *reasons* that virtual filesystems
> must not try to cache dentry pointers in their internal data
> structures. Because note how the fuilesystem saw the new lookup(d2) of
> the same name *before* it saw the >d_release(d1) of the old dentry.
> 
> And the above is fundamental: we obviously cannot call '->d_release()'
> until the old dentry is all dead and buried (lockref_mark_dead() etc),
> so pretty much by definition you'll have that ordering being possible.
> 
> It's extremely unlikely, of course. I'll be you'll never hit it in testing.
> 
> So if if you associate some internal data structure with a dentry,
> just *what* happens when you haven't been told abotu the old dentry
> being dead when the new one happens?
> 
> See why I say that it's fundamentally wrong for a filesystem to try to
> track dentries? All the operations that can use a dentry will get one
> passed down to them by the VFS layer. The filesystem has no business
> trying to remember some dentry from a previous operation, and the
> filesystem *will* get it wrong.
> 
> But also note how refcounting works fine. In fact, refcounting is
> pretty much the *only* thing that works fine. So what you *should* do
> is
> 
>  - at lookup(), when you save your filesystem data in "->d_fsdata",
> you increment a refcount
> 
>  - at ->d_release(), you decrement a refcount
> 
> and now you're fine. Yes, when the above (very very unlikely)
> situation happens, you'll temporarily have a refcount incremented
> twice, but that's kind of the *point* of refcounts.
> 
> Side note: this is pretty much true of any kernel data structure. If
> you have a kernel data structure that isn't just used within one
> thread, it must be refcounted. But it'as *doubly* true when you save
> references to something that the VFS maintains, because you DO NOT
> CONTROL the lifetime of that entity.
> 
> > The eventfs_remove_dir() can free the ei (after SRCU) if it has no
> > references, otherwise it needs to wait for the final dput() to do the
> > free.  
> 
> Honestly, you should just *always* do refcounting. No "free after RCU
> delay" as an alternative. Just refcount it.
> 
> Now, the RCU delay may be needed if the lookup of said structure
> happens under RCU, but no, saying "I use SRCU to make sure the
> lifetime is at least X" is just broken.
> 
> The refcount is what gives the lifetime. Any form of RCU-delaying
> should then be purely about non-refcounting RCU lookups that may
> happen as the thing is dying (and said lookup should *look* at the
> refcount and say "oh, this is dead, I'm not returning this".
> 
> > I think the ei->dentry was required for the dir wrapper logic that we
> > removed.  
> 
> I think all of this was due to the bogus readdir that created dentries
> willy-nilly and without the required serialization.
> 
> And that was all horribly broken.  It wasn't even the above kind of
> "really subtle race that you'll never hit in practice" broken. It was
> just absolutely broken with readdir and lookup racing on the same name
> and creating an unholy dentry mess.

Hmm, if I understand the above, I could get rid of keeping around
dentry and even remove the eventfs_set_ei_status_free().

I can try something to see if it works.

-- Steve


