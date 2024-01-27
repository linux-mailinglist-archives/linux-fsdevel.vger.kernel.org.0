Return-Path: <linux-fsdevel+bounces-9220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEADB83EFD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 20:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C11F221AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1772E62A;
	Sat, 27 Jan 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BxXNNww8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260052C86A
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706384708; cv=none; b=oL7aZZPEw9KKM0rx3V9ykiovO99MND0aNodnGAImy80OoGdbFQ56qOlOBv1pZSo4bcOOF9oWhZu4w92m/sTrCXiTf2grHOutK+VbudwMNOUS38IoHFDvwwacleK/aqmbstsCBKUlYycmk5yHRsLvOn5byOCHeUFpWO3CLSH2Rtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706384708; c=relaxed/simple;
	bh=7LPZwhAeF5FXcZdYqYWAIFCklJO1lhQWiMSiwTOVCLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSB20Gb5Woe4OHjOUONoTVfGexEMypq5rI20r0SohXKR6nFsj6C0JXO5HAvNbUFEhpa1J93lyJDh0INzOl/XX/C5PAU+nTDRCFxH/xhJWzo7smu2+qwL5H5YOwrAIfNbD0CJfS1oYllEwNLOI7lMNHUyBeuKy+/PIxfwIDp9O9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BxXNNww8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55c1ac8d2f2so1257065a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706384704; x=1706989504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dauG2xyvU0hWcJd1iYWE0kBCym5t6BZZQljgkbaBQjU=;
        b=BxXNNww8kD1GPwhbxX4b7UPc+uo3gVt/OB9TvKB/cy9ichxRcAybULH4wTHW0azS1L
         eGb/gmsjz2az9DbYmCgDThUBVOTeyohlJAzYBj/m61PNcfGelSCNJy+sixseizjme4bM
         2Ru05iyjiTCJlkMasHOyRkQj6dhN5OSkhdDgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706384704; x=1706989504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dauG2xyvU0hWcJd1iYWE0kBCym5t6BZZQljgkbaBQjU=;
        b=nCVzEsuXgrlOB4p5NKTsMi/5fR5NGZEE7N6hq70Y0X3ZMlJD1/Du+8Kp75LWFA7R33
         qKabSBb8J0qX2HkSNuq3Zs9ffcmsX/GDiJ5PWKbEq7RP8wfdEOaotA5f0Et/gxNwZ4lW
         kJ9f2Iu4iWl96ROLAeoTHidRhtofmnaOcMKELsl0Uo/0j3j7yIer0jlSTvtR9lL8mjb5
         clo3tEZk6no9NCz0up/jJkfq6flH55K9m5qzge9isBRXLRWJWgIOoYbqX4WpyNEygdN6
         8wqxUHuqWqZvoGN+dfmTr0bU53F0vcE6f3XKexzLDu5eT32vWLfCw1iSLgSxSMTiJ3b/
         7vhA==
X-Gm-Message-State: AOJu0YxD/Sq5v/p3Ew0hGyx+ctKeWB+ui5LqAbzriZpCXF7e+aH/zem8
	cANXuytRS0oS6HVRH34gDrjW9H/n0KDtrawN/rJegtogOBnURuyLgsm0W96QrxeE3cKI+FzzolM
	7tf0SuQ==
X-Google-Smtp-Source: AGHT+IH768ViV3oHElDo1ESloSoJnYMuAdaFlTkxayuXukcIUlpQ8HzTsBgtjdpcH89fZF6fywYELQ==
X-Received: by 2002:aa7:d4d4:0:b0:55d:d993:b5b6 with SMTP id t20-20020aa7d4d4000000b0055dd993b5b6mr1200762edr.41.1706384704035;
        Sat, 27 Jan 2024 11:45:04 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id k17-20020a056402049100b0055c63205052sm1940197edv.37.2024.01.27.11.45.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 11:45:02 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55d4013f3e0so1114579a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 11:45:02 -0800 (PST)
X-Received: by 2002:a05:6402:35c4:b0:55c:2852:7b50 with SMTP id
 z4-20020a05640235c400b0055c28527b50mr1635136edc.29.1706384702029; Sat, 27 Jan
 2024 11:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024012522-shorten-deviator-9f45@gregkh> <20240125205055.2752ac1c@rorschach.local.home>
 <2024012528-caviar-gumming-a14b@gregkh> <20240125214007.67d45fcf@rorschach.local.home>
 <2024012634-rotten-conjoined-0a98@gregkh> <20240126101553.7c22b054@gandalf.local.home>
 <2024012600-dose-happiest-f57d@gregkh> <20240126114451.17be7e15@gandalf.local.home>
 <CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
 <d661e4a68a799d8ae85f0eab67b1074bfde6a87b.camel@HansenPartnership.com> <ZbVGLXu4DuomEvJH@casper.infradead.org>
In-Reply-To: <ZbVGLXu4DuomEvJH@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jan 2024 11:44:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whXg6zAHWZ7f+CdOg5GOMffR3RSDVyvORTZhipxp5iAFQ@mail.gmail.com>
Message-ID: <CAHk-=whXg6zAHWZ7f+CdOg5GOMffR3RSDVyvORTZhipxp5iAFQ@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
To: Matthew Wilcox <willy@infradead.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Amir Goldstein <amir73il@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jan 2024 at 10:06, Matthew Wilcox <willy@infradead.org> wrote:
>
> I'd suggest that eventfs and shiftfs are not "simple filesystems".
> They're synthetic filesystems that want to do very different things
> from block filesystems and network filesystems.  We have a lot of
> infrastructure in place to help authors of, say, bcachefs, but not a lot
> of infrastructure for synthetic filesystems (procfs, overlayfs, sysfs,
> debugfs, etc).

Indeed.

I think it's worth pointing out three very _fundamental_ design issues
here, which all mean that a "regular filesystem" is in many ways much
simpler than a virtual one:

 (a) this is what the VFS has literally primarily been designed for.

When you look at a lot of VFS issues, they almost all come from just
very basic "this is what a filesystem needs" issues, and particularly
performance issues. And when you talk "performance", the #1 thing is
caching. In fact, I'd argue that #2 is caching too. Caching is just
*so* important, and it really shows in the VFS. Think about just about
any part of the VFS, and it's all about caching filesystem data. It's
why the dentry cache exists, it's why the page / folios exist, it's
what 99% of all the VFS code is about.

And that performance / caching issue isn't just why most of the VFS
code exists, it's literally also the reason for most of the design
decisions. The dentry cache is a hugely complicated beast, and a *lot*
of the complications are directly related to one thing, and one thing
only: performance. It's why locking is so incredibly baroque.

Yes, there are other complications. The whole notion of "bind mounts"
is a huge complication that arguably isn't performance-related, and
it's why we have that combination of "vfsmount" and "dentry" that we
together call a "path". And that tends to confuse low-level filesystem
people, because the other thing the VFS layer does is to try to shield
the low-level filesystem from higher-level concepts like that, so that
the low-level filesystem literally doesn't have to know about "oh,
this same filesystem is mounted in five different places". The VFS
layer takes care of that, and the filesystem doesn't need to know.

So part of it is that the VFS has been designed for regular
filesystems, but the *other* part of the puzzle is on the other side:

 (b) regular filesystems have been designed to be filesystems.

Ok, that may sound like a stupid truism, but when it comes to the
discussion of virtual filesystems and relative simplicity, it's quite
a big deal. The fact is, a regular filesystem has literally been
designed from the ground up to do regular filesystem things. And that
matters.

Yes, yes, many filesystems then made various bad design decisions, and
the world isn't perfect. But basically things like "read a directory"
and "read and write files" and "rename things" are all things that the
filesystem was *designed* for.

So the VFS layer was designed for real filesystems, and real
filesystems were designed to do filesystem operations, so they are not
just made to fit together, they are also all made to expose all the
normal read/write/open/stat/whatever system calls.

 (c) none of the above is generally true of virtual filesystems

Sure, *some* virtual filesystems are designed to act like a filesystem
from the ground up. Something like "tmpfs" is obviously a virtual
filesystem, but it's "virtual" only in the sense that it doesn't have
much of a backing store. It's still designed primarily to *be* a
filesystem, and the only operations that happen on it are filesystem
operations.

So ignore 'tmpfs' here, and think about all the other virtual
filesystems we have.

And realize that hey aren't really designed to be filesystems per se -
they are literally designed to be something entirely different, and
the filesystem interface is then only a secondary thing - it's a
window into a strange non-filesystem world where normal filesystem
operations don't even exist, even if sometimes there can be some kind
of convoluted transformation for them.

So you have "simple" things like just plain read-only files in /proc,
and desp[ite being about as simple as they come, they fail miserably
at the most fundamental part of a file: you can't even 'stat()' them
and get sane file size data from them.

And "caching" - which was the #1 reason for most of the filesystem
code - ends up being much less so, although it turns out that it's
still hugely important because of the abstraction interface it allows.

So all those dentries, and all the complicated lookup code, end up
still being quite important to make the virtual filesystem look like a
filesystem at all: it's what gives you the 'getcwd()' system call,
it's what still gives you the whole bind mount thing, it really ends
up giving a lot of "structure" to the virtual filesystem that would be
an absolute nightmare without it.  But it's a structure that is really
designed for something else.

Because the non-filesystem virtual part that a virtual filesystem is
actually trying to expose _as_ a filesystem to user space usually has
lifetime rules (and other rules) that are *entirely* unrelated to any
filesystem activity. A user can "chdir()" into a directory that
describes a process, but the lifetime of that process is then entirely
unrelated to that, and it can go away as a process, while the
directory still has to virtually exist.

That's part of what the VFS code gives a virtual filesystem: the
dentries etc end up being those things that hang around even when the
virtual part that they described may have disappeared. And you *need*
that, just to get sane UNIX 'home directory' semantics.

I think people often don't think of how much that VFS infrastructure
protects them from.

But it's also why virtual filesystems are generally a complete mess:
you have these two pieces, and they are really doing two *COMPLETELY*
different things.

It's why I told Steven so forcefully that tracefs must not mess around
with VFS internals. A virtual filesystem either needs to be a "real
filesystem" aka tmpfs and just leave it *all* to the VFS layer, or it
needs to just treat the dentries as a separate cache that the virtual
filesystem is *not* in charge of, and trust the VFS layer to do the
filesystem parts.

But no. You should *not* look at a virtual filesystem as a guide how
to write a filesystem, or how to use the VFS. Look at a real FS. A
simple one, and preferably one that is built from the ground up to
look like a POSIX one, so that you don't end up getting confused by
all the nasty hacks to make it all look ok.

IOW, while FAT is a simple filesystem, don't look at that one, just
because then you end up with all the complications that come from
decades of non-UNIX filesystem history.

I'd say "look at minix or sysv filesystems", except those may be
simple but they also end up being so legacy that they aren't good
examples. You shouldn't use buffer-heads for anything new. But they
are still probably good examples for one thing: if you want to
understand the real power of dentries, look at either of the minix or
sysv 'namei.c' files. Just *look* at how simple they are. Ignore the
internal implementation of how a directory entry is then looked up on
disk - because that's obviously filesystem-specific - and instead just
look at the interface.

           Linus

