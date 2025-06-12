Return-Path: <linux-fsdevel+bounces-51404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7507AD67AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 08:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90111BC0641
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 06:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6906D1F2B88;
	Thu, 12 Jun 2025 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUuafSFh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C55153598;
	Thu, 12 Jun 2025 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708668; cv=none; b=GJ6gh7740ZrtahgoEydjhxdFc6yZAkdm+5EEKQgykDdwil5RmWOOj5ivhU6wXkd85DCegIAvUNy4gPvHvyON6wiXPIL8fkl9vAK4bb+jwbmUAYg7RIQ8ReN4AQHFDcecb9fOlBdo6W0FG0bnf/T8b/Hpn21dsyTHsYw0IkGM8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708668; c=relaxed/simple;
	bh=SXjeUHKg14l7OLHSKrdFUjO2sxQKxhA1BWcSJzRPCe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkisDyEl2rrpwFljEwSsZBi0Tp8wvLNDZllCZjElJ5B3fhsaeYUfMjeW7ynIzpACbDbtju8OFVhl0F7fsuQc2+CAwwYa4583LritY9vqOE8vcWAfTtfX8H0/hctograZJOVM47FaiSi8Q2fHkjTZYL0UhwWAeDfC/4S60xY2jG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUuafSFh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad8826c05f2so107524266b.3;
        Wed, 11 Jun 2025 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749708665; x=1750313465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uGqrdv5MeylimBylhz+Y5TijsG5wbdMDi4tXU/7d3E=;
        b=KUuafSFhucKQp2H6+5lXmWNidiwUgN7gTKIkF656IuMeNZRmnm+3rQDImw7HPnCl7P
         7Yi+w/8gXGI3u6NNAmvoGuo8P8e9+3nkskrZ0lxopmQFZ47TjzPeXwGghek/XWtOj0Bu
         +xaP73JZ3MMSWzNwknLkLX6/CNB0DJhpLI+KuVWMrRm9niPy0ape6xrdGZbv4XuHr6ck
         ZHVVgVfImFYlfCRCMWi29vZmTO8LRbKEXyQhI1PQd63pbx4wwikCZWbV7t8kOKxlWZVZ
         5zzgzwkaJMraXBe6AZoG2BflvWl80FQQwwkzA/vFFAKzRopSuBTY/uR8iz1aZTGBVSdM
         DASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708665; x=1750313465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uGqrdv5MeylimBylhz+Y5TijsG5wbdMDi4tXU/7d3E=;
        b=UKTMwiNU7ZFWgsgPRj0F53qOaWhRdue3/KEHQo8ESxfGKlxaIJaa1CE9/WKE4R+PNy
         5GWTiuY6Z5v85PJc3n08l+OW7H1H5ORt+h8VeDRJyFI011ark2JbrC9SiR2H+4G4GmvA
         c5AAw9Ygk6MdTKvAfh5j0SXuo7oSsEmZlUgHTg8/csqlV/VopFx67JD6IpbrwmFbit86
         lwWL1sDpSfN8PuuKHF09drECHxAU74Gc5r3MKBy21M/mnWzRHATXkqILa5KfdAVOeJUb
         IlGGp3ysyY6NKpzRbVH7OEH6ZAor/Bz4BnfGEHpTg1s/+sIXZKnUpJLaVWyAP68WJSBT
         ueyA==
X-Forwarded-Encrypted: i=1; AJvYcCV0hN0PT+4JItga+1qv5oU1ItgNjGNijQ9TFese2BDmuE6wk+XzRMRC8i/ybHmMpkYNb7xdecvg9EMW@vger.kernel.org, AJvYcCX4KPDUW0HlvYf4ktXPbsCoUEbWgUK7tm+t+mkBlj8Jp4MAHCdYkhhk6F3esCIDRC/O4wJNBpGiyfBRfdI08g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PVNlK4Mja86OCQ0KsppVjqConGbYYPr3Juj/hIMA+U+WLFh+
	AGF2yipt7cI2xHCvi3LNGUUJNt/if15qbZT//cPyFAYwBw0OsXqoEhl8Uj1++u/T7NRwHQSfDzZ
	UZ7JHUe5TgoC/MnXq7IZEyw6ysoi7OHQI3IcS
X-Gm-Gg: ASbGncs3YlA6nvP3U1tZ4ydLnTHAhxD2XBT6n1ldZtvwtKQBa/U0stQANWLVMPevzGD
	rR4fcxxCrwOvQMmPjxO9JgL3sFF0s7hl9o5+42gTwSbtBjZQuHhA/JqaS3kfi35f83zngKFyzsD
	MkzHKkEwMHKpqzjNeqPFRqIc9JBGqhHQIvUNEuis/MOc/d4xSB+FGZ8w==
X-Google-Smtp-Source: AGHT+IGZeHlQtLkyh69BVdait8/rEIzp6KWULxhxJEBWvG7sl/RI9HthZRhaw+SglFUn/FDAvnhUd9DitEnasF7j200=
X-Received: by 2002:a17:907:3ea4:b0:ad8:9428:6a3c with SMTP id
 a640c23a62f3a-adea2e356d9mr213814266b.11.1749708664614; Wed, 11 Jun 2025
 23:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs> <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs> <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs> <20250611115629.GL784455@mit.edu> <20250612032007.GD6134@frogsfrogsfrogs>
In-Reply-To: <20250612032007.GD6134@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Jun 2025 08:10:51 +0200
X-Gm-Features: AX0GCFtE07GnKp6xHwLMRGbyLvT1rvu3IbWFXu1GLHHSryrUXRPBwvMHj8kkOmA
Message-ID: <CAOQ4uxiFp2Keo-qg4Jj+iJ3oE83x8Xph8oQruC-WyeOUHfz-5Q@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, 
	bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, 
	Josef Bacik <josef@toxicpanda.com>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	Allison Karlitskaya <lis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 5:20=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jun 11, 2025 at 10:56:29AM -0100, Theodore Ts'o wrote:
> > +Allison Karlitskaya
> >
> > On Tue, Jun 10, 2025 at 12:00:26PM -0700, Darrick J. Wong wrote:
> > > > High level fuse interface is not the right tool for the job.
> > > > It's not even the easiest way to have written fuse2fs in the first =
place.
> > >
> > > At the time I thought it would minimize friction across multiple
> > > operating systems' fuse implementations.
> > >
> > > > High-level fuse API addresses file system objects with full paths.
> > > > This is good for writing simple virtual filesystems, but it is not =
the
> > > > correct nor is the easiest choice to write a userspace driver for e=
xt4.
> > >
> > > Agreed, it's a *terrible* way to implement ext4.
> > >
> > > I think, however, that Ted would like to maintain compatibility with
> > > macfuse and freebsd(?) so he's been resistant to rewriting the entire
> > > program to work with the lowlevel library.
> >
> > My priority is to make sure that we have compatibility with other OS's
> > (in particular MacOS, FreeBSD, if possible Windows, although that's
> > not something that I develop against or have test vehicles to
> > validate).  However, from what I can tell, they all support Fuse3 at
> > this point --- MacFuse, FreeBSD, and WinFSP all have Fuse3 support as
> > of today.
> >
> > The only complaint that I've had about breaking support using Fuse2
> > was from Allison (Cc'ed), who was involved with another Github
> > project, whose Github Actions break because they were using a very old
> > version of Ubuntu LTS 20.04), which only had support for libfuse2.  I
> > am going to assume that this is probably only because they hadn't
> > bothered to update their .github/workflows/ci.yaml file, and not
> > because there was any inherit requirement that we support ancient
> > versions of Linux distributions.  (When I was at IBM, I remember
> > having to support customers who used RHEL4, and even in one extreme
> > case, RHEL3 because there were a customer paying $$$$$ that refused to
> > update; but that was well over a decade ago, and at this point, I'm
> > finding it a lot harder to care about that.  :-)
> >
> > My plan is that after I release 1.47.2 (which will have some
> > interesting data corruption bugfixes thanks to Darrick and other users
> > using fuse2fs in deadly earnest, as opposed to as a lightweight way to
> > copy files in and out of an file system image), I plan to transition
> > the master and next branches for the future 1.48 release, and the
> > maint branch will have bug fixes for 1.47.N releases.
> >
> > At that point, unless I hear some very strong arguments against, for
> > 1.48, my current thinking is that we will drop support for Fuse2.  I
> > will still care about making sure that fuse2fs will build and work
> > well enough that casual file copies work on MacOS and FreeBSD, and
> > I'll accept patches that make fuse2fs work with WinFSP.  In practice,
> > this means that Linux-specific things like Verity support will need to
> > be #ifdef'ed so that they will build against MacFUSE, and I assume the
> > same will be true for fuseblk mode and iomap mode(?).
>
> <nod> I might just drop fuseblk mode since it's unusable for
> unprivileged userspace and regular files; and is a real pain even for
> "I'm pretending to be the kernel" mode.
>
> > This may break the github actions for composefs-rs[1], but I'm going
> > to assume that they can figure out a way to transition to Fuse3
> > (hopefully by just using a newer version of Ubuntu, but I suppose it's
> > possible that Rust bindings only exist for Fuse2, and not Fuse3).  But
> > in any case, I don't think it makes sense to hold back fuse2fs
> > development just for the sake of Ubuntu Focal (LTS 20.04).  And if
> > necessary, composefs-rs can just stay back on e2fsprogs 1.47.N until
> > they can get off of Fuse2 and/or Ubuntu 20.04.  Allison, does that
> > sound fair to you?
> >
> > [1] https://github.com/containers/composefs-rs
> >
> > Does anyone else have any objections to dropping Fuse2 support?  And
> > is that sufficient for folks to more easily support iomap mode in
> > fuse2fs?
>
> I don't have any objections to cleaning the fuse2 crud out of fuse2fs.
>
> I /do/ worry that rewriting fuse2fs to target the lowlevel fuse3 library
> instead of the highlevel one is going to break the !linux platforms.
> Although I *think* macfuse and freebsd fuse actually support the
> lowlevel library will be ok, I do worry that we might lose windows
> support.  I can't tell if winfsp or dokan are what you're supposed to
> use there, but afaict neither of them support the lowlevel interface.
>
> That said, I could just fork fuse2fs and make the fork ("fuse4fs") talk
> to the lowlevel library, and we can see what happens when/if people try
> to build it on those platforms.
>
> (Though again I have zero capacity to build macos or windows programs...)
>
> TBH it might be a huge relief to just start with a new fuse4fs codebase
> where I can focus on making iomap the single IO path that works really
> well, rather than try to support the existing one.  There's a lot of IO
> manager changes in the fuse2fs+iomap prototype that I think just go away
> if you don't need to support doing the file IO yourself.
>
> Any code that's shareable between fuse[24]fs should of course get split
> out, which should ease the maintenance burden of having two fuse
> servers.  Most of fuse2fs' "smarts" are just calling libext2fs anyway.

That seems like a good way to focus your energy on the important
goals. I like it.

Thanks,
Amir.

