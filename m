Return-Path: <linux-fsdevel+bounces-51189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA8AD4348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 21:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15DF7A71BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 19:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C58E231825;
	Tue, 10 Jun 2025 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VglPUC1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C741EE7D5;
	Tue, 10 Jun 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749585132; cv=none; b=uupZOF3ytv7D5P9qOnX72j2Fp6E1P3/qHI6bVjP1Cvh0cH9r9Q0cjiE2leBWDSf/qgFTSi4W4KERpzBlw5MwCD9thLlfliBCeB9KaH/MyI4XT3SrgVKdSEOMKx/qPhEe0zX7WeHscgmE1Hfv7/3uAeNxOyOKrKd8z8GQ38e8//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749585132; c=relaxed/simple;
	bh=PWvx3oKcZZjiRNrDHkXSP+e2jKQA7s+eakuGX6RL4oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1ltepBq+uQmhw2KBLQIBqjvwdfK42zHh7PcEtAm6hr6uV6kY2a2rVs8tySW6hAQaWwfQRMGua+aSTRg6iS1vho74soSG6OM7ULHsmkXyTZYKtizSbIDnFZvcyfMzB/l7K15xXz481/+B3ZADeQ4GSgfoyMq0PRfp4X9XUuHwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VglPUC1f; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad88d77314bso1091398166b.1;
        Tue, 10 Jun 2025 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749585129; x=1750189929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT8szgIUfe1SKplVmVvyLURewacO/t+cqK+5jdl87d0=;
        b=VglPUC1fPqn8AnsNGrZVquAmuOPV/uzWSj/etXp/ccZ/JU4Qu58Wh/CxlUyCjTo+wi
         RI1kQgUMbQAsDjOh6AGy7Tc+zFyi5UwyyKBYVmpeRj0ggUMHTltTgsJ2X2+E0P+IAEmk
         N0pFRUVuZbgN4vG6lQk8LqHkPR/zPtrEHez1O2cKzkRsyDv0bCJmXztUgNdu5icFZB2+
         9FjhzQEYLpD3lWwoCy3Afc/pCiFx+WSMFTfKWS9asKgSZ1tfJPMtLFbLRxmx3Vi34L1k
         TPxK/Ilxxq74ZEHXOeoLurNEFjfsUAY2ifB0mV7r3LN5M19JwncQEf1TzbPtnatRNHL3
         i9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749585129; x=1750189929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT8szgIUfe1SKplVmVvyLURewacO/t+cqK+5jdl87d0=;
        b=FvIlhtYu13K/gktlFi6nXWpXRZjB5M3LJbzDa+EniRz2N+4BmtmfmnfUQH7QIzwvP5
         Iy1ID5wJeKDpQp5Y0QVZRAGa6AMbH6plhhAfruyzR8dbjqufcOt7CodRuZDnLeA96eUD
         vHiLMJdSJ9yc5QfzOeRasWNikYRvJSzKsp8bbeBNgRzi4qT2BRkyUc01JeWHPXuKGFYo
         PCc0sOUeOPS9UASXur5bv+KPA25911fhHDwcJkEjR3T01OelusmVaMFgH/ZYLncwJ9i/
         A1W1Dul/k8ZtBMCfaiCwDv/jFZj1G5tVXhCN9zPbXQfgo+v+06Z1VswhscL9880ag/BV
         FCsw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5qn1gxZqAJxfSTKbOUkkI6Adyh0vPuro5sxRtPQo0Y9+8nkpYxISDZsvXnHOqlWLlR1c1dcy/XkS@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLGjAQe1szNmpXYhcSVTQkmv4tkA2NsEWbF08CHm0d4YjtEbw
	8UCGGpLUD+VYEMpxILxjakuhD37FV8SAbxemh/mYICTKXB+3p/5IdGq7E2xAYilNZELN8DQMnL5
	fG+FurALaNPV4DixsIcUBTorqX1zcOmg=
X-Gm-Gg: ASbGncu4wBAOfr6vURJXZwjDFCeDOnq4SYzeno5wyiKmFb6siO4Op25PhgAjaTWwm/j
	aHc0yd7JeomC8sUEclH2DYeLhxmuCeeH78eIoCJf4KMNtFmUnwxFfjfsouko7lY5thYTZjl5iRV
	oFj8ch5oGZ36lxIAQFZLJpUa0KfoGDG3rCBe4aUcgTrzY=
X-Google-Smtp-Source: AGHT+IHTsZLaqBTddgiQERDEA2zREdgoyayAhFVDx5XaPHvWDM/WmK2m8w4TWtm6g6Q8yod8WFbGYAOmgOl0ByqOaQg=
X-Received: by 2002:a17:907:3e28:b0:ade:422d:3167 with SMTP id
 a640c23a62f3a-ade897e0612mr60947966b.49.1749585128432; Tue, 10 Jun 2025
 12:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs> <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs> <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs>
In-Reply-To: <20250610190026.GA6134@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 10 Jun 2025 21:51:55 +0200
X-Gm-Features: AX0GCFu4wwo6rJC-Qc-psJhto-pTz4BZQJZBnw3gk_fLIcXr3F0j07ISckgOG2A
Message-ID: <CAOQ4uxj4G_7E-Yba0hP2kpdeX17Fma0H-dB6Z8=BkbOWsF9NUg@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, 
	miklos@szeredi.hu, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 9:00=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Jun 10, 2025 at 12:59:36PM +0200, Amir Goldstein wrote:
> > On Tue, Jun 10, 2025 at 12:32=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > >
> > > On Thu, May 29, 2025 at 09:41:23PM +0200, Amir Goldstein wrote:
> > > >  or
> > > >
> > > > On Thu, May 29, 2025 at 6:45=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > On Thu, May 22, 2025 at 06:24:50PM +0200, Amir Goldstein wrote:
> > > > > > On Thu, May 22, 2025 at 1:58=E2=80=AFAM Darrick J. Wong <djwong=
@kernel.org> wrote:
> > > > > > >
> > > > > > > Hi everyone,
> > > > > > >
> > > > > > > DO NOT MERGE THIS.
> > > > > > >
> > > > > > > This is the very first request for comments of a prototype to=
 connect
> > > > > > > the Linux fuse driver to fs-iomap for regular file IO operati=
ons to and
> > > > > > > from files whose contents persist to locally attached storage=
 devices.
> > > > > > >
> > > > > > > Why would you want to do that?  Most filesystem drivers are s=
eriously
> > > > > > > vulnerable to metadata parsing attacks, as syzbot has shown r=
epeatedly
> > > > > > > over almost a decade of its existence.  Faulty code can lead =
to total
> > > > > > > kernel compromise, and I think there's a very strong incentiv=
e to move
> > > > > > > all that parsing out to userspace where we can containerize t=
he fuse
> > > > > > > server process.
> > > > > > >
> > > > > > > willy's folios conversion project (and to a certain degree RH=
's new
> > > > > > > mount API) have also demonstrated that treewide changes to th=
e core
> > > > > > > mm/pagecache/fs code are very very difficult to pull off and =
take years
> > > > > > > because you have to understand every filesystem's bespoke use=
 of that
> > > > > > > core code.  Eeeugh.
> > > > > > >
> > > > > > > The fuse command plumbing is very simple -- the ->iomap_begin=
,
> > > > > > > ->iomap_end, and iomap ioend calls within iomap are turned in=
to upcalls
> > > > > > > to the fuse server via a trio of new fuse commands.  This is =
suitable
> > > > > > > for very simple filesystems that don't do tricky things with =
mappings
> > > > > > > (e.g. FAT/HFS) during writeback.  This isn't quite adequate f=
or ext4,
> > > > > > > but solving that is for the next sprint.
> > > > > > >
> > > > > > > With this overly simplistic RFC, I am to show that it's possi=
ble to
> > > > > > > build a fuse server for a real filesystem (ext4) that runs en=
tirely in
> > > > > > > userspace yet maintains most of its performance.  At this ear=
ly stage I
> > > > > > > get about 95% of the kernel ext4 driver's streaming directio =
performance
> > > > > > > on streaming IO, and 110% of its streaming buffered IO perfor=
mance.
> > > > > > > Random buffered IO suffers a 90% hit on writes due to unwritt=
en extent
> > > > > > > conversions.  Random direct IO is about 60% as fast as the ke=
rnel; see
> > > > > > > the cover letter for the fuse2fs iomap changes for more detai=
ls.
> > > > > > >
> > > > > >
> > > > > > Very cool!
> > > > > >
> > > > > > > There are some major warts remaining:
> > > > > > >
> > > > > > > 1. The iomap cookie validation is not present, which can lead=
 to subtle
> > > > > > > races between pagecache zeroing and writeback on filesystems =
that
> > > > > > > support unwritten and delalloc mappings.
> > > > > > >
> > > > > > > 2. Mappings ought to be cached in the kernel for more speed.
> > > > > > >
> > > > > > > 3. iomap doesn't support things like fscrypt or fsverity, and=
 I haven't
> > > > > > > yet figured out how inline data is supposed to work.
> > > > > > >
> > > > > > > 4. I would like to be able to turn on fuse+iomap on a per-ino=
de basis,
> > > > > > > which currently isn't possible because the kernel fuse driver=
 will iget
> > > > > > > inodes prior to calling FUSE_GETATTR to discover the properti=
es of the
> > > > > > > inode it just read.
> > > > > >
> > > > > > Can you make the decision about enabling iomap on lookup?
> > > > > > The plan for passthrough for inode operations was to allow
> > > > > > setting up passthough config of inode on lookup.
> > > > >
> > > > > The main requirement (especially for buffered IO) is that we've s=
et the
> > > > > address space operations structure either to the regular fuse one=
 or to
> > > > > the fuse+iomap ops before clearing INEW because the iomap/buffere=
d-io.c
> > > > > code assumes that cannot change on a live inode.
> > > > >
> > > > > So I /think/ we could ask the fuse server at inode instantiation =
time
> > > > > (which, if I'm reading the code correctly, is when iget5_locked g=
ives
> > > > > fuse an INEW inode and calls fuse_init_inode) provided it's ok to=
 upcall
> > > > > to userspace at that time.  Alternately I guess we could extend s=
truct
> > > > > fuse_attr with another FUSE_ATTR_ flag, I think?
> > > > >
> > > >
> > > > The latter. Either extend fuse_attr or struct fuse_entry_out,
> > > > which is in the responses of FUSE_LOOKUP,
> > > > FUSE_READDIRPLUS, FUSE_CREATE, FUSE_TMPFILE.
> > > > which instantiate fuse inodes.
> > > >
> > > > There is a very hand wavy discussion about this at:
> > > > https://lore.kernel.org/linux-fsdevel/CAOQ4uxi2w+S4yy3yiBvGpJYSqC6G=
OTAZQzzjygaH3TjH7Uc4+Q@mail.gmail.com/
> > > >
> > > > In a nutshell, we discussed adding a new FUSE_LOOKUP_HANDLE
> > > > command that uses the variable length file handle instead of nodeid
> > > > as a key for the inode.
> > > >
> > > > So we will have to extend fuse_entry_out anyway, but TBH I never go=
t to
> > > > look at the gritty details of how best to extend all the relevant c=
ommands,
> > > > so I hope I am not sending you down the wrong path.
> > >
> > > I found another twist to this story: the upper level libfuse3 library
> > > assigns distinct nodeids for each directory entry.  These nodeids are
> > > passed into the kernel and appear to the basis for an iget5_locked ca=
ll.
> > > IOWs, each nodeid causes a struct fuse_inode to be created in the
> > > kernel.
> > >
> > > For a single-linked file this is no big deal, but for a hardlink this
> > > makes iomap a mess because this means that in fuse2fs, an ext2 inode =
can
> > > map to multiple kernel fuse_inode objects.  This /really/ breaks the
> > > locking model of iomap, which assumes that there's one in-kernel inod=
e
> > > and that it can use i_rwsem to synchronize updates.
> > >
> > > So I'm going to have to find a way to deal with this.  I tried trivia=
lly
> > > messing with libfuse nodeid assigment but that blew some assertion.
> > > Maybe your LOOKUP_HANDLE thing would work.
> > >
> >
> > Pull the emergency break!
> >
> > In an amature move, I did not look at fuse2fs.c before commenting on yo=
ur
> > work.
> >
> > High level fuse interface is not the right tool for the job.
> > It's not even the easiest way to have written fuse2fs in the first plac=
e.
>
> At the time I thought it would minimize friction across multiple
> operating systems' fuse implementations.
>
> > High-level fuse API addresses file system objects with full paths.
> > This is good for writing simple virtual filesystems, but it is not the
> > correct nor is the easiest choice to write a userspace driver for ext4.
>
> Agreed, it's a *terrible* way to implement ext4.
>
> I think, however, that Ted would like to maintain compatibility with
> macfuse and freebsd(?) so he's been resistant to rewriting the entire
> program to work with the lowlevel library.
>
> That said, I decided just now to do some spelunking into those two fuse
> ports and have discovered that freebsd[1] packages the same upstream
> libfuse as linux, and macfuse[2] seems to vendor both libfuse 2 and 3.
>
> [1] https://wiki.freebsd.org/FUSEFS
> [2] https://github.com/macfuse/macfuse
>
> Seeing as Debian 13 has killed off libfuse2 entirely, maybe I should
> think about rewriting all of fuse2fs against the lowlevel library?  It's
> really annoying to deal with all the problems of the current codebase.
> I think I'll try to stabilize the current fuse+iomap code and then look
> into a fuse2fs port.  What would we call it, fuse4fs? :D
>
> > Low-level fuse interface addresses filesystem objects by nodeid
> > and requires the server to implement lookup(parent_nodeid, name)
> > where the server gets to choose the nodeid (not libfuse).
>
> Does the nodeid for the root directory have to be FUSE_ROOT_ID?

Yeh, I think that's the case, otherwise FUSE_INIT would need to
tell the kernel the root nodeid, because there is no lookup to
return the root nodeid.

> I guess
> for ext4 that's not a big deal since ext2 inode #1 is the badblocks file
> which cannot be accessed from userspace anyway.
>

As long as inode #1 is reserved it should be fine.
just need to refine the rules of the one-to-one mapping with
this exception.

Thanks,
Amir.

