Return-Path: <linux-fsdevel+bounces-50102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348AAC82D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 21:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45011500BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A3233134;
	Thu, 29 May 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFL9gRGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1712110;
	Thu, 29 May 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748547699; cv=none; b=jgmm/OFnvAZJVKXSwp0WudgwC6p1Mo2aTpBkIRDv/qNH+AcBXBXODrAQ4tTxpTHGgfml69fDP9bObu/74/5lkTgo5XW3AhN66SVE3HaNW2p4vz3YivNSp8jhKw7P5qB3uYWGrLEvK4qcJvGcrdkHv23LBgVrmpTBFMQS9pEOds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748547699; c=relaxed/simple;
	bh=faB//5zj8LjyOQl2vi3mwWJbWqGE4+2PLln03isVTls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWQVAGZGR6DxQeNaqUqeU3csqnn1z8dN6FkDAkSDoimyMfmI5d2rWwWLFCFkwgbxv9OQ6c2PdNQwUFqNu/Ez7KQ0mNCVf1uwxQTEcjzaKIEw00EfFU57NVjTU9/OO68Qnp9Lc6i0wHDUcwvxZn6ymhJerOH937jcPC1LV6uBRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFL9gRGQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad69e4f2100so198551766b.2;
        Thu, 29 May 2025 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748547696; x=1749152496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAzLvaxuWrHk/PDo4mDUPGEH9SlvCqy850dkZjMakCE=;
        b=TFL9gRGQzekIowl04e9lQzdbG4E38sE030hnqjtZRcY/cK6IK5gKqNXgDXJPlUfjRZ
         qfQ0h3NKyi+Kbhems2F7LXMVHMzJJqgTa9IaDORGaZj7AGOu/Sd8nkI2WXMaDDO4QWXq
         Pl3nQJjEyqFpp3r+pJy8EX5/9ccq+MkyFaHKq8IJYK4WahCNdJ7V3p3ikl7uPbwKGlKZ
         iNRshnsgW1JRoeHp6Gu6EoGwXdwI13zfmZECJiBtfX2QAM5VF/+oeNK6qv5b0ilIkg42
         YFrwNJsAAu0yi1os+2Sx2rW8EuUgNGNi88O9nSM9qBP0pFwoZUeoQ3gTWw9Al3wcxevS
         YhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748547696; x=1749152496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAzLvaxuWrHk/PDo4mDUPGEH9SlvCqy850dkZjMakCE=;
        b=psCErXpLXjI3z75ktSKOo2B0jG3YwZAXgNF9KtaKVMRof53D173HPT9fbH+ow0IUpy
         LqlOQiky07vGNg0LYBuPxIhcl7friMXgWk59fuvfSRIAzVHMo2oZnr9tfrlwLNB8ebuq
         1i9QuYHdPUamNxSAOaJWHRHyL97Ze5rieBHni0XWjLJuApTaQZOfarEzwrebpcAUgjmx
         d2obLPQptCKeUwgPO/U1pzgHepKeC/LI8+8raD2HAXTU6/5xJNfP34/VxHagAJZUFDIo
         hujAkltMcp0bKk4nP8i4T7JkU47pQQGshhiG0lhMLsZ87GvIKjrCSwVl3ZGzcZaAqLfe
         fRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdJ+ye93r8o6aHqHtce8lHN6Wo1WBwDeqCPpTLLI8oxWZB8dUFGSYtVfXOfSWGGYdR/jHW/sn2kqXM@vger.kernel.org
X-Gm-Message-State: AOJu0YxUr6Kbka+XSVvsVCn7OJo3iirMC8oNtMdqcy7n3pQrvUnpZz5s
	ykh3ijbY45K2gpMW+PEUH1uFrg9FFF+m3HURWh/J0Lb3E/hlTJKvdLtm5rxKJeX/a9TpfEfuscy
	mZAk9aoOhmrE2uX/QXk4VzInY9fVlvCo=
X-Gm-Gg: ASbGncuXCB/CWgj839MIBWHG+JyRqyBnW9QMQxt7N4fI3pV7I2kVfVqER3yNljIWMhZ
	7s30fW760AUA9DvKGVaF201qYRiwqrp679P3YH/WUZEVIV8EH2tgQgx1DMZY9UZbSFLeS3y8mZp
	6eVPQtzgl9EtGo6AW6F6ODZifIDv2BQGiV
X-Google-Smtp-Source: AGHT+IFWJk5coKplhacZN8PPVX3ku6qQ1gXcQ9LocP/OKLJ6cdH9OZ9eS+kNx6UhcmSXiQoMsQqlpK1ORO54Q3/wpkI=
X-Received: by 2002:a17:907:72d2:b0:ad8:87a0:62aa with SMTP id
 a640c23a62f3a-adb3225ad42mr72900866b.27.1748547695282; Thu, 29 May 2025
 12:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs>
In-Reply-To: <20250529164503.GB8282@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 May 2025 21:41:23 +0200
X-Gm-Features: AX0GCFu7pqta6rdvwndbgDtclsxul4PEZgl-Lkv5eXmBpDtb8xV3bN3YZhOkjJc
Message-ID: <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, 
	miklos@szeredi.hu, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 or

On Thu, May 29, 2025 at 6:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, May 22, 2025 at 06:24:50PM +0200, Amir Goldstein wrote:
> > On Thu, May 22, 2025 at 1:58=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > Hi everyone,
> > >
> > > DO NOT MERGE THIS.
> > >
> > > This is the very first request for comments of a prototype to connect
> > > the Linux fuse driver to fs-iomap for regular file IO operations to a=
nd
> > > from files whose contents persist to locally attached storage devices=
.
> > >
> > > Why would you want to do that?  Most filesystem drivers are seriously
> > > vulnerable to metadata parsing attacks, as syzbot has shown repeatedl=
y
> > > over almost a decade of its existence.  Faulty code can lead to total
> > > kernel compromise, and I think there's a very strong incentive to mov=
e
> > > all that parsing out to userspace where we can containerize the fuse
> > > server process.
> > >
> > > willy's folios conversion project (and to a certain degree RH's new
> > > mount API) have also demonstrated that treewide changes to the core
> > > mm/pagecache/fs code are very very difficult to pull off and take yea=
rs
> > > because you have to understand every filesystem's bespoke use of that
> > > core code.  Eeeugh.
> > >
> > > The fuse command plumbing is very simple -- the ->iomap_begin,
> > > ->iomap_end, and iomap ioend calls within iomap are turned into upcal=
ls
> > > to the fuse server via a trio of new fuse commands.  This is suitable
> > > for very simple filesystems that don't do tricky things with mappings
> > > (e.g. FAT/HFS) during writeback.  This isn't quite adequate for ext4,
> > > but solving that is for the next sprint.
> > >
> > > With this overly simplistic RFC, I am to show that it's possible to
> > > build a fuse server for a real filesystem (ext4) that runs entirely i=
n
> > > userspace yet maintains most of its performance.  At this early stage=
 I
> > > get about 95% of the kernel ext4 driver's streaming directio performa=
nce
> > > on streaming IO, and 110% of its streaming buffered IO performance.
> > > Random buffered IO suffers a 90% hit on writes due to unwritten exten=
t
> > > conversions.  Random direct IO is about 60% as fast as the kernel; se=
e
> > > the cover letter for the fuse2fs iomap changes for more details.
> > >
> >
> > Very cool!
> >
> > > There are some major warts remaining:
> > >
> > > 1. The iomap cookie validation is not present, which can lead to subt=
le
> > > races between pagecache zeroing and writeback on filesystems that
> > > support unwritten and delalloc mappings.
> > >
> > > 2. Mappings ought to be cached in the kernel for more speed.
> > >
> > > 3. iomap doesn't support things like fscrypt or fsverity, and I haven=
't
> > > yet figured out how inline data is supposed to work.
> > >
> > > 4. I would like to be able to turn on fuse+iomap on a per-inode basis=
,
> > > which currently isn't possible because the kernel fuse driver will ig=
et
> > > inodes prior to calling FUSE_GETATTR to discover the properties of th=
e
> > > inode it just read.
> >
> > Can you make the decision about enabling iomap on lookup?
> > The plan for passthrough for inode operations was to allow
> > setting up passthough config of inode on lookup.
>
> The main requirement (especially for buffered IO) is that we've set the
> address space operations structure either to the regular fuse one or to
> the fuse+iomap ops before clearing INEW because the iomap/buffered-io.c
> code assumes that cannot change on a live inode.
>
> So I /think/ we could ask the fuse server at inode instantiation time
> (which, if I'm reading the code correctly, is when iget5_locked gives
> fuse an INEW inode and calls fuse_init_inode) provided it's ok to upcall
> to userspace at that time.  Alternately I guess we could extend struct
> fuse_attr with another FUSE_ATTR_ flag, I think?
>

The latter. Either extend fuse_attr or struct fuse_entry_out,
which is in the responses of FUSE_LOOKUP,
FUSE_READDIRPLUS, FUSE_CREATE, FUSE_TMPFILE.
which instantiate fuse inodes.

There is a very hand wavy discussion about this at:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxi2w+S4yy3yiBvGpJYSqC6GOTAZQzzj=
ygaH3TjH7Uc4+Q@mail.gmail.com/

In a nutshell, we discussed adding a new FUSE_LOOKUP_HANDLE
command that uses the variable length file handle instead of nodeid
as a key for the inode.

So we will have to extend fuse_entry_out anyway, but TBH I never got to
look at the gritty details of how best to extend all the relevant commands,
so I hope I am not sending you down the wrong path.


> > > 5. ext4 doesn't support out of place writes so I don't know if that
> > > actually works correctly.
> > >
> > > 6. iomap is an inode-based service, not a file-based service.  This
> > > means that we /must/ push ext2's inode numbers into the kernel via
> > > FUSE_GETATTR so that it can report those same numbers back out throug=
h
> > > the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate nod=
eid
> > > to index its incore inode, so we have to pass those too so that
> > > notifications work properly.
> > >
> >
> > Again, I might be missing something, but as long as the fuse filesystem
> > is exposing a single backing filesystem, it should be possible to make
> > sure (via opt-in) that fuse nodeid's are equivalent to the backing fs
> > inode number.
> > See sketch in this WIP branch:
> > https://github.com/amir73il/linux/commit/210f7a29a51b085ead9f555978c85c=
9a4a503575
>
> I think this would work in many places, except for filesystems with
> 64-bit inumbers on 32-bit machines.  That might be a good argument for
> continuing to pass along the nodeid and fuse_inode::orig_ino like it
> does now.  Plus there are some filesystems that synthesize inode numbers
> so tying the two together might not be feasible/desirable anyway.
>
> Though one nice feature of letting fuse have its own nodeids might be
> that if the in-memory index switches to a tree structure, then it could
> be more compact if the filesystem's inumbers are fairly sparse like xfs.
> OTOH the current inode hashtable has been around for a very long time so
> that might not be a big concern.  For fuse2fs it doesn't matter since
> ext4 inumbers are u32.
>

I wanted to see if declaring one-to-one 64bit ino can simplify things
for the first version of inode ops passthrough.
If this is not the case, or if this is too much of a limitation for
your use case
then nevermind.
But if it is a good enough shortcut for the demo and can be extended later,
then why not.

Thanks,
Amir.

