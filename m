Return-Path: <linux-fsdevel+bounces-40673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A32BA26657
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841841650B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C730210F45;
	Mon,  3 Feb 2025 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDWAgBhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12459182B4;
	Mon,  3 Feb 2025 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738620309; cv=none; b=K3D5vbYvuOI0zCAPVW5ri6PabyFrWPEzDx8LgPX2yS9dlmvP6nssNGqdUxVWMqV2j2bLjRqHFVGy/7BYiKpf41Zuzj8OI34wfJdPUWyqv/rIIfZ8MsfZ0veNzh6BUp/ROOS4kmGWN3r9phhrRpgjZE3dxr5G3xd07dwjA4Oaa3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738620309; c=relaxed/simple;
	bh=ufoZtdzqAXNiU6MS5es6W1qsJw4Ka4IgUyF7ZD8Rlng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdEUVavdgsIohxKWLH4xZwGSZto1MjeT2RoZ8w8XCXquNxCbr2qCrZTz4YIkEd3RGO7qeyknykghCNkW4/eyLgiinC7P0PPA/ElanvbyPRxrvrls6Xn7eV8wludbzCV8bQb476cyjF2jB5VrB3eN7BwyB4e/kOR86FmDiBorrak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDWAgBhk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so11756685a12.1;
        Mon, 03 Feb 2025 14:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738620305; x=1739225105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfWPhz+INVJNiVKqXovLTadhCIqvZ16J6qdYwJ+KXTc=;
        b=RDWAgBhkLpIVFQ+yTZBWox2uIWNC1F614HTg431wcHwcgXjT0C5RNWMTOxajkvPvog
         AKvd74gpOf6lA9zd30C23HFX62+r4tse6zuw8vV14LytXQG5PRoNQ8HPdXWYEz6IGUUn
         IZC0EpZzp1Hz6SVkMk04sfQfroV5RZdCXh7RLkncIm8IK+boC6BhIANSu42uwjn8aTfv
         vDUSLWdmzMBaSbJtZhx/4Y9jOGaVGtwx59FX8li/Ra1HdDQ3QoVuwRD8SDop5WSR7GQm
         MkhPGZjhR5oWjnpeSdw6/f5ZMVbM3UWMO2C6qoiL+uW2vHRzWH2R+sr333soQJyA4eqr
         HKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738620305; x=1739225105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfWPhz+INVJNiVKqXovLTadhCIqvZ16J6qdYwJ+KXTc=;
        b=mbi7boZ0bKXUDFBS+oUrqJW2B10nWt+Nr7dM2uKp2hebfNp9PI0RQhr4AKBH3BUn0N
         cgbweZLkg52gqZE6W4B+FfU02imJrEYKJDLoqGfIth4JHasBXAEx3Y1DGvuKCRecNQSD
         GLqSIPC+GxS9BrUrTuDGiO54Enn9ofoSiKA99f2217kGfuuuuDksoB/c6QXRhs2okW4b
         Y4+wG9I7YKLdyjc/rSkaSkbSOPM4JiRoj+AOB74AQCtH8YBFw1ffeo9PWEzPHLGxX4TE
         mGPRPb/51ArlNL7sHiM8ofikLEKYKrfyNHAKPkUiJlCieXgLqWaTu4tA+BYWo6eeStcR
         u1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU3rskhH2JPkcmk+RXuU7saB+GcxfkbThYTXTlr7Gf1UIVd1nHkK0OJxFIZetbKZZUrsK45CMiJZGfG@vger.kernel.org, AJvYcCVLaSGgN+U7o1pwMgR4dzmUk3/bUWdevLZxHXGJ5oMLQSKh0xT1T5NezpGCg5bSXTa1SOpmFGW5AUgJ9g==@vger.kernel.org, AJvYcCVvFv3Ad5uNXY+kHWGnoKyH/RBYu37mDK+FbVTI1TR76frYphnOsHC9JaOpzi/bpvwcUbU=@vger.kernel.org, AJvYcCWcLprHyKCx+dGSgRIZ3UZX3TT4jYDEafa4B3i9Yr5CqRp8K35fiafnXkCHCtP7L5Yd5ZWJ06+zR3BM6kjBGA==@vger.kernel.org, AJvYcCX0si5UIF9OTLgMPJid2sRJqt34DXZnKD+B0cYHWQxc5039d1P21bCfT8E7uYz+/EOQSZISW7mS3XZM5MQ3@vger.kernel.org, AJvYcCXK/8Us3OymNQ2oVNIO3DV4q1PPjXmYoSdL1q5ozY3qTxgjNjjrAbueif56SsK5Z3X+/guAPAzcQ80aUZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOK5TO0zBBBx7iEg/dvwMxPA/Pw7OKNaHZVnqYoMieyuGs5LdL
	5ikrHphh4D03WZ8kcaYraErbwmwsmmg01PtBsEiytX7dVCxtmogp0VnwDIFUBAYmUUB9ngEJAM/
	n4YwpE2JwbZfHGeTsagTL7nvfT/Q=
X-Gm-Gg: ASbGnctaABttaL7/ujRICX1Etzxpzcu3c2kODq1G1M1uBvsBgo4nteRktKU2T7/MWjH
	tLCf5v644MveJNxYJyb3lxwxJ6PowNwyN9qVrFo6W8tv+t2G1zeGkPjgW/W+HNyo8MgNDR6Xc
X-Google-Smtp-Source: AGHT+IEBK110MqEEHGqul3TiQcmes0hYTWLnCbKjzyx7fAeU1bAn7xW39fRuNMB1W3Z9Juvhf087o643m1E06cI4MgU=
X-Received: by 2002:a05:6402:13d2:b0:5db:7353:2b5c with SMTP id
 4fb4d7f45d1cf-5dcc14db066mr910803a12.11.1738620304633; Mon, 03 Feb 2025
 14:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com> <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
 <Z512mt1hmX5Jg7iH@x1.local> <20250201-legehennen-klopfen-2ab140dc0422@brauner>
 <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
 <CAOQ4uxjVTir-mmx05zh231BpEN1XbXpooscZyfNUYmVj32-d3w@mail.gmail.com>
 <20250202-abbauen-meerrettich-912513202ce4@brauner> <l5apiabdjosyy4gfuenr4oqdfio3zdiajzxoekdgtsohzpn3mj@dcmvayncbye4>
 <CAOQ4uxg63JR2jsy_xA63Zkh_6wzsy_2c30Z_05kZ=cHsRC_UzQ@mail.gmail.com> <20250203144135.1caef6c3.alex.williamson@redhat.com>
In-Reply-To: <20250203144135.1caef6c3.alex.williamson@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Feb 2025 23:04:53 +0100
X-Gm-Features: AWEUYZluDUNL1TbMXt-rEN5-evy5A4JQDjuv20638mpd-F-mrLwQ5eRV4vDdsoY
Message-ID: <CAOQ4uxg2kmwftGGMYPLWgsixVcFEV9+0ZoBTGDJDDX7GmCAmCA@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 10:41=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 3 Feb 2025 21:39:27 +0100
> Amir Goldstein <amir73il@gmail.com> wrote:
>
> > On Mon, Feb 3, 2025 at 1:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sun 02-02-25 11:04:02, Christian Brauner wrote:
> > > > On Sun, Feb 02, 2025 at 08:46:21AM +0100, Amir Goldstein wrote:
> > > > > On Sun, Feb 2, 2025 at 1:58=E2=80=AFAM Linus Torvalds
> > > > > <torvalds@linux-foundation.org> wrote:
> > > > > >
> > > > > > On Sat, 1 Feb 2025 at 06:38, Christian Brauner <brauner@kernel.=
org> wrote:
> > > > > > >
> > > > > > > Ok, but those "device fds" aren't really device fds in the se=
nse that
> > > > > > > they are character fds. They are regular files afaict from:
> > > > > > >
> > > > > > > vfio_device_open_file(struct vfio_device *device)
> > > > > > >
> > > > > > > (Well, it's actually worse as anon_inode_getfile() files don'=
t have any
> > > > > > > mode at all but that's beside the point.)?
> > > > > > >
> > > > > > > In any case, I think you're right that such files would (acci=
dently?)
> > > > > > > qualify for content watches afaict. So at least that should p=
robably get
> > > > > > > FMODE_NONOTIFY.
> > > > > >
> > > > > > Hmm. Can we just make all anon_inodes do that? I don't think yo=
u can
> > > > > > sanely have pre-content watches on anon-inodes, since you can't=
 really
> > > > > > have access to them to _set_ the content watch from outside any=
way..
> > > > > >
> > > > > > In fact, maybe do it in alloc_file_pseudo()?
> > > > > >
> > > > >
> > > > > The problem is that we cannot set FMODE_NONOTIFY -
> > > > > we tried that once but it regressed some workloads watching
> > > > > write on pipe fd or something.
> > > >
> > > > Ok, that might be true. But I would assume that most users of
> > > > alloc_file_pseudo() or the anonymous inode infrastructure will not =
care
> > > > about fanotify events. I would not go for a separate helper. It'd b=
e
> > > > nice to keep the number of file allocation functions low.
> > > >
> > > > I'd rather have the subsystems that want it explicitly opt-in to
> > > > fanotify watches, i.e., remove FMODE_NONOTIFY. Because right now we=
 have
> > > > broken fanotify support for e.g., nsfs already. So make the subsyst=
ems
> > > > think about whether they actually want to support it.
> > >
> > > Agreed, that would be a saner default.
> > >
> > > > I would disqualify all anonymous inodes and see what actually does
> > > > break. I naively suspect that almost no one uses anonymous inodes +
> > > > fanotify. I'd be very surprised.
> > > >
> > > > I'm currently traveling (see you later btw) but from a very cursory
> > > > reading I would naively suspect the following:
> > > >
> > > > // Suspects for FMODE_NONOTIFY
> > > > drivers/dma-buf/dma-buf.c:      file =3D alloc_file_pseudo(inode, d=
ma_buf_mnt, "dmabuf",
> > > > drivers/misc/cxl/api.c: file =3D alloc_file_pseudo(inode, cxl_vfs_m=
ount, name,
> > > > drivers/scsi/cxlflash/ocxl_hw.c:        file =3D alloc_file_pseudo(=
inode, ocxlflash_vfs_mount, name,
> > > > fs/anon_inodes.c:       file =3D alloc_file_pseudo(inode, anon_inod=
e_mnt, name,
> > > > fs/hugetlbfs/inode.c:           file =3D alloc_file_pseudo(inode, m=
nt, name, O_RDWR,
> > > > kernel/bpf/token.c:     file =3D alloc_file_pseudo(inode, path.mnt,=
 BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
> > > > mm/secretmem.c: file =3D alloc_file_pseudo(inode, secretmem_mnt, "s=
ecretmem",
> > > > block/bdev.c:   bdev_file =3D alloc_file_pseudo_noaccount(BD_INODE(=
bdev),
> > > > drivers/tty/pty.c: static int ptmx_open(struct inode *inode, struct=
 file *filp)
> > > >
> > > > // Suspects for ~FMODE_NONOTIFY
> > > > fs/aio.c:       file =3D alloc_file_pseudo(inode, aio_mnt, "[aio]",
> > >
> > > This is just a helper file for managing aio context so I don't think =
any
> > > notification makes sense there (events are not well defined). So I'd =
say
> > > FMODE_NONOTIFY here as well.
> > >
> > > > fs/pipe.c:      f =3D alloc_file_pseudo(inode, pipe_mnt, "",
> > > > mm/shmem.c:             res =3D alloc_file_pseudo(inode, mnt, name,=
 O_RDWR,
> > >
> > > This is actually used for stuff like IPC SEM where notification doesn=
't
> > > make sense. It's also used when mmapping /dev/zero but that struct fi=
le
> > > isn't easily accessible to userspace so overall I'd say this should b=
e
> > > FMODE_NONOTIFY as well.
> >
> > I think there is another code path that the audit missed for getting th=
ese
> > pseudo files not via alloc_file_pseudo():
> > ipc/shm.c:      file =3D alloc_file_clone(base, f_flags,
> >
> > which does not copy f_mode as far as I can tell.
> >
> > >
> > > > // Unsure:
> > > > fs/nfs/nfs4file.c:      filep =3D alloc_file_pseudo(r_ino, ss_mnt, =
read_name, O_RDONLY,
> > >
> > > AFAICS this struct file is for copy offload and doesn't leave the ker=
nel.
> > > Hence FMODE_NONOTIFY should be fine.
> > >
> > > > net/socket.c:   file =3D alloc_file_pseudo(SOCK_INODE(sock), sock_m=
nt, dname,
> > >
> > > In this case I think we need to be careful. It's a similar case as pi=
pes so
> > > probably we should use ~FMODE_NONOTIFY here from pure caution.
> > >
> >
> > I tried this approach with patch:
> > "fsnotify: disable notification by default for all pseudo files"
> >
> > But I also added another patch:
> > "fsnotify: disable pre-content and permission events by default"
> >
> > So that code paths that we missed such as alloc_file_clone()
> > will not have pre-content events enabled.
> >
> > Alex,
> >
> > Can you please try this branch:
> >
> > https://github.com/amir73il/linux/commits/fsnotify-fixes/
> >
> > and verify that it fixes your issue.
> >
> > The branch contains one prep patch:
> > "fsnotify: use accessor to set FMODE_NONOTIFY_*"
> > and two independent Fixes patches.
> >
> > Assuming that it fixes your issue, can you please test each of the
> > Fixes patches individually, because every one of them should be fixing
> > the issue independently and every one of them could break something,
> > so we may end up reverting it later on.
>
> Test #1:
>
> fsnotify: disable pre-content and permission events by default
> fsnotify: disable notification by default for all pseudo files
> fsnotify: use accessor to set FMODE_NONOTIFY_*
>
> Result: Pass, vfio-pci huge_fault observed
>
> Test #2:
>
> fsnotify: disable notification by default for all pseudo files
> fsnotify: use accessor to set FMODE_NONOTIFY_*
>
> Result: Pass, vfio-pci huge_fault observed
>
> Test #3:
>
> fsnotify: disable pre-content and permission events by default
> fsnotify: use accessor to set FMODE_NONOTIFY_*
>
> Result: Pass, vfio-pci huge_fault observed
>
> Test #4 (control):
>
> fsnotify: use accessor to set FMODE_NONOTIFY_*
>
> Result: Fail, no vfio-pci huge_fault observed
>
> For any combination of the Fixes patches:
>
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
>

That was fast.
I will post the patches.

Thanks!
Amir.

