Return-Path: <linux-fsdevel+bounces-51154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3391EAD343A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 13:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D7D189368B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30BA28CF59;
	Tue, 10 Jun 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpFNwbbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16A286D58;
	Tue, 10 Jun 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553195; cv=none; b=JsriJXVJWRu87opcn3Wke4Ve8TZo6TZWZ4s/tsxytUs0deBURySTM7InQtkfvals57X7S5VYtkQCwaBDF+wcKANc8Y3NlUv0vRgAq05E17OuIpZua86JuXYoXJ6aLarJQ7UcoRkEqxNRzBr5GorLwNdLc9Rbm0wJW9nqlrgUiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553195; c=relaxed/simple;
	bh=ivV4+afIMd3Xs6QrgS35Yg9Hsfo1ljdX0+KQj3LvrYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCCpRwwlrj7r0Icb4jkNyCUuCFmIa+HyW42a2X+oe4ZYoz4fAGM8CqpKI8egHj5GWzHmmSOFo9YfdmvoM2efEaJpEzahfXTkyZVTXQcklb1I0FL57YEViP2mhcHUNq6rVkEBaLhIoDxZbEwz8KdmnlDYXBWFa6t/9EohuoYXRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpFNwbbi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade58f04fb2so282297366b.0;
        Tue, 10 Jun 2025 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749553188; x=1750157988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBMHbmy12t6g1RNYj0kWM1uARKBAVpLlDGvuC02v+Fk=;
        b=dpFNwbbioiKcO8IRRX8qoEP8Ewmp/iFtV65SAL8sd8u7NHTXfRsnu0wOgEIP8t9DbL
         jxS1S16NhZN6h8Tw8wn0Wap1vAY5BrfFgsSQ+h2y7XedkzeTvFbb253HBPgkZiM8Oyg8
         2PrE6AcVothaLSvbo4FiZN4hLM5CT+BhUXD4FgcykjvTI5x+qAwG74QRg0oOyrVO6Fiw
         QgXwl3NvejISS1t5x6jdGwpvFHeWLIwfHXp3azxnnJs5Hf04J7hbcuCk1An+FHoh6/Vt
         SnW5X5IIdh5WmqTQwF0cvMVuc7vnmHvfyPFchMEshY2Xd0t1ZEtSWJtSrXdrGAZ11d4f
         pyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749553188; x=1750157988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBMHbmy12t6g1RNYj0kWM1uARKBAVpLlDGvuC02v+Fk=;
        b=gZ8pTQFF3ZWpUdU1RY76qju6n+cQ0we5itstBrl4A5NLWd5jwcD3wGzVxt7NV+Xwah
         kZYxQLdckBYMkcPX+EE4hY1OkKW4nNUojrHxKOsNB/+GRDxwgrswBSYr10HgQfj7jeAh
         hSrCoWW9xT/h+DBRnnC6BJxFXGxuDeVEZ7QCM6ie82aBiX8iJSUhuTojodwzI+ISR/5D
         i/5/xL1RE1d1qbn772MjYtN8LAdaQDm9SYQ/wMHXYtEGLsBHwXWcMMFNxCdGn9Kkbn14
         IyXAmFNWwCyZzhg1BDtBpLK7MQD6HUHkGvt49+nnsIQGKvHDgY/8R9WdJx27gaC/tfUe
         S53Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPVvYC8Q9o3sXikNbtSgMNwKOKeAmZ47WoSaVd3Wfb1PkaaARNjynmNaDew62rZ9uQByk2DCFxX0Qo@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAeecrX/6X3puUZpAYYVbSSKrmlQia5ukXOqLJ6AsdJ5g8Gn2
	JUwNnG8a6JeTcx//yTXDYWUek78zJQEkLBdWvMRC4aN4lH4t9ps/9wI98K+pAbrUo3yCwPpvcse
	icwjGjA8JtFK12REQC5EAgCR1SeLEmgGzP3+nYmw=
X-Gm-Gg: ASbGncsncE2VS8iijGIlIQEU01CzbW6XrsJ6WTVKOfnSoBf4Dy9cRRaits/BZ4suJAG
	s/d+aNiGmLk4UHO7BHYCwzwcB2J3tC2nY0Lx4h9VgAl/14uQsPMcwfAIejxgBcuYCyg4hKDlr6o
	sV6bo0ixBVSxwCxhU6PocUHeKunVHJpK/kX2eHc42hVU8=
X-Google-Smtp-Source: AGHT+IFUVRPFVelAXvbArPfuFc3vpl2WJ1fKE4ALNclgY2756HO/qRZj4nzsYB8f3ghKHX0HROkwrEhuISwoppX1KDA=
X-Received: by 2002:a17:907:1c8e:b0:ad8:a41a:3cd2 with SMTP id
 a640c23a62f3a-ade1a9058e7mr1633477066b.16.1749553187888; Tue, 10 Jun 2025
 03:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs> <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs>
In-Reply-To: <20250609223159.GB6138@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 10 Jun 2025 12:59:36 +0200
X-Gm-Features: AX0GCFupdvfZ2fk0jvsPzxZ2w4xAakEGAIcPKTZRhKPOL9Z7Ti0WGY8Du9qPZVs
Message-ID: <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, 
	miklos@szeredi.hu, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 12:32=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Thu, May 29, 2025 at 09:41:23PM +0200, Amir Goldstein wrote:
> >  or
> >
> > On Thu, May 29, 2025 at 6:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Thu, May 22, 2025 at 06:24:50PM +0200, Amir Goldstein wrote:
> > > > On Thu, May 22, 2025 at 1:58=E2=80=AFAM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > Hi everyone,
> > > > >
> > > > > DO NOT MERGE THIS.
> > > > >
> > > > > This is the very first request for comments of a prototype to con=
nect
> > > > > the Linux fuse driver to fs-iomap for regular file IO operations =
to and
> > > > > from files whose contents persist to locally attached storage dev=
ices.
> > > > >
> > > > > Why would you want to do that?  Most filesystem drivers are serio=
usly
> > > > > vulnerable to metadata parsing attacks, as syzbot has shown repea=
tedly
> > > > > over almost a decade of its existence.  Faulty code can lead to t=
otal
> > > > > kernel compromise, and I think there's a very strong incentive to=
 move
> > > > > all that parsing out to userspace where we can containerize the f=
use
> > > > > server process.
> > > > >
> > > > > willy's folios conversion project (and to a certain degree RH's n=
ew
> > > > > mount API) have also demonstrated that treewide changes to the co=
re
> > > > > mm/pagecache/fs code are very very difficult to pull off and take=
 years
> > > > > because you have to understand every filesystem's bespoke use of =
that
> > > > > core code.  Eeeugh.
> > > > >
> > > > > The fuse command plumbing is very simple -- the ->iomap_begin,
> > > > > ->iomap_end, and iomap ioend calls within iomap are turned into u=
pcalls
> > > > > to the fuse server via a trio of new fuse commands.  This is suit=
able
> > > > > for very simple filesystems that don't do tricky things with mapp=
ings
> > > > > (e.g. FAT/HFS) during writeback.  This isn't quite adequate for e=
xt4,
> > > > > but solving that is for the next sprint.
> > > > >
> > > > > With this overly simplistic RFC, I am to show that it's possible =
to
> > > > > build a fuse server for a real filesystem (ext4) that runs entire=
ly in
> > > > > userspace yet maintains most of its performance.  At this early s=
tage I
> > > > > get about 95% of the kernel ext4 driver's streaming directio perf=
ormance
> > > > > on streaming IO, and 110% of its streaming buffered IO performanc=
e.
> > > > > Random buffered IO suffers a 90% hit on writes due to unwritten e=
xtent
> > > > > conversions.  Random direct IO is about 60% as fast as the kernel=
; see
> > > > > the cover letter for the fuse2fs iomap changes for more details.
> > > > >
> > > >
> > > > Very cool!
> > > >
> > > > > There are some major warts remaining:
> > > > >
> > > > > 1. The iomap cookie validation is not present, which can lead to =
subtle
> > > > > races between pagecache zeroing and writeback on filesystems that
> > > > > support unwritten and delalloc mappings.
> > > > >
> > > > > 2. Mappings ought to be cached in the kernel for more speed.
> > > > >
> > > > > 3. iomap doesn't support things like fscrypt or fsverity, and I h=
aven't
> > > > > yet figured out how inline data is supposed to work.
> > > > >
> > > > > 4. I would like to be able to turn on fuse+iomap on a per-inode b=
asis,
> > > > > which currently isn't possible because the kernel fuse driver wil=
l iget
> > > > > inodes prior to calling FUSE_GETATTR to discover the properties o=
f the
> > > > > inode it just read.
> > > >
> > > > Can you make the decision about enabling iomap on lookup?
> > > > The plan for passthrough for inode operations was to allow
> > > > setting up passthough config of inode on lookup.
> > >
> > > The main requirement (especially for buffered IO) is that we've set t=
he
> > > address space operations structure either to the regular fuse one or =
to
> > > the fuse+iomap ops before clearing INEW because the iomap/buffered-io=
.c
> > > code assumes that cannot change on a live inode.
> > >
> > > So I /think/ we could ask the fuse server at inode instantiation time
> > > (which, if I'm reading the code correctly, is when iget5_locked gives
> > > fuse an INEW inode and calls fuse_init_inode) provided it's ok to upc=
all
> > > to userspace at that time.  Alternately I guess we could extend struc=
t
> > > fuse_attr with another FUSE_ATTR_ flag, I think?
> > >
> >
> > The latter. Either extend fuse_attr or struct fuse_entry_out,
> > which is in the responses of FUSE_LOOKUP,
> > FUSE_READDIRPLUS, FUSE_CREATE, FUSE_TMPFILE.
> > which instantiate fuse inodes.
> >
> > There is a very hand wavy discussion about this at:
> > https://lore.kernel.org/linux-fsdevel/CAOQ4uxi2w+S4yy3yiBvGpJYSqC6GOTAZ=
QzzjygaH3TjH7Uc4+Q@mail.gmail.com/
> >
> > In a nutshell, we discussed adding a new FUSE_LOOKUP_HANDLE
> > command that uses the variable length file handle instead of nodeid
> > as a key for the inode.
> >
> > So we will have to extend fuse_entry_out anyway, but TBH I never got to
> > look at the gritty details of how best to extend all the relevant comma=
nds,
> > so I hope I am not sending you down the wrong path.
>
> I found another twist to this story: the upper level libfuse3 library
> assigns distinct nodeids for each directory entry.  These nodeids are
> passed into the kernel and appear to the basis for an iget5_locked call.
> IOWs, each nodeid causes a struct fuse_inode to be created in the
> kernel.
>
> For a single-linked file this is no big deal, but for a hardlink this
> makes iomap a mess because this means that in fuse2fs, an ext2 inode can
> map to multiple kernel fuse_inode objects.  This /really/ breaks the
> locking model of iomap, which assumes that there's one in-kernel inode
> and that it can use i_rwsem to synchronize updates.
>
> So I'm going to have to find a way to deal with this.  I tried trivially
> messing with libfuse nodeid assigment but that blew some assertion.
> Maybe your LOOKUP_HANDLE thing would work.
>

Pull the emergency break!

In an amature move, I did not look at fuse2fs.c before commenting on your
work.

High level fuse interface is not the right tool for the job.
It's not even the easiest way to have written fuse2fs in the first place.

High-level fuse API addresses file system objects with full paths.
This is good for writing simple virtual filesystems, but it is not the
correct nor is the easiest choice to write a userspace driver for ext4.

Low-level fuse interface addresses filesystem objects by nodeid
and requires the server to implement lookup(parent_nodeid, name)
where the server gets to choose the nodeid (not libfuse).

current fuse2fs code needs to go to an effort to convert from full path
to inode + name using ext2fs_namei().

With the low-level fuse op_lookup() might have used the native ext2_lookup(=
)
which would have been much more natural.

You can find the most featureful low-level fuse example at:
https://github.com/libfuse/libfuse/blob/master/example/passthrough_hp.cc

Among other things, the server has an inode cache, where an inode
has in its state 'nopen' (was this inode opened for io) and 'backing_id'
(was this inode mapped for kernel passthrough).

Currently this backing_id mapping is only made on first open of inode,
but the plan is to do that also at lookup time, for example, if the
iomap mode for the inode can be determined at lookup time.


> > > > > 5. ext4 doesn't support out of place writes so I don't know if th=
at
> > > > > actually works correctly.
> > > > >
> > > > > 6. iomap is an inode-based service, not a file-based service.  Th=
is
> > > > > means that we /must/ push ext2's inode numbers into the kernel vi=
a
> > > > > FUSE_GETATTR so that it can report those same numbers back out th=
rough
> > > > > the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate=
 nodeid
> > > > > to index its incore inode, so we have to pass those too so that
> > > > > notifications work properly.
> > > > >
> > > >
> > > > Again, I might be missing something, but as long as the fuse filesy=
stem
> > > > is exposing a single backing filesystem, it should be possible to m=
ake
> > > > sure (via opt-in) that fuse nodeid's are equivalent to the backing =
fs
> > > > inode number.
> > > > See sketch in this WIP branch:
> > > > https://github.com/amir73il/linux/commit/210f7a29a51b085ead9f555978=
c85c9a4a503575
> > >
> > > I think this would work in many places, except for filesystems with
> > > 64-bit inumbers on 32-bit machines.  That might be a good argument fo=
r
> > > continuing to pass along the nodeid and fuse_inode::orig_ino like it
> > > does now.  Plus there are some filesystems that synthesize inode numb=
ers
> > > so tying the two together might not be feasible/desirable anyway.
> > >
> > > Though one nice feature of letting fuse have its own nodeids might be
> > > that if the in-memory index switches to a tree structure, then it cou=
ld
> > > be more compact if the filesystem's inumbers are fairly sparse like x=
fs.
> > > OTOH the current inode hashtable has been around for a very long time=
 so
> > > that might not be a big concern.  For fuse2fs it doesn't matter since
> > > ext4 inumbers are u32.
> > >
> >
> > I wanted to see if declaring one-to-one 64bit ino can simplify things
> > for the first version of inode ops passthrough.
> > If this is not the case, or if this is too much of a limitation for
> > your use case
> > then nevermind.
> > But if it is a good enough shortcut for the demo and can be extended la=
ter,
> > then why not.
>
> It's very tempting, because it's very confusing to have nodeids and
> stat st_ino not be the same thing.
>

Now that I have explained that fuse2fs should be low-level, it should be
trivial to claim that it should have no problem to declare via
FUSE_PASSTHROUGH_INO flag to the kernel that nodeid =3D=3D st_ino,
because I see no reason to implement fuse2fs with non one-to-one
mapping of ino <=3D=3D> nodeid.

Thanks,
Amir.

