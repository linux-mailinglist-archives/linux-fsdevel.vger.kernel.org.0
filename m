Return-Path: <linux-fsdevel+bounces-40664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710FA264E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 21:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176A9169D9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3821128D;
	Mon,  3 Feb 2025 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arJoZS3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45C20E6F7;
	Mon,  3 Feb 2025 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738615182; cv=none; b=n7XeXmR1akFF+bqzERn6RS2veOI6d8LgchhLfgaw51MM/kTetKd+SqM/tb5xPsRQ41UwHutSQJwv4AM6yVyDRlpXGU+4rVIgvTuOgWeKU0dIxUnLe0nzGaQ8U1/NZrmn+Sw4dhYiiOgCkTjEfpa5wcsnJf4Pr3wKjNs4lANzug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738615182; c=relaxed/simple;
	bh=DSUOkZcVTQO69xFV5OKgk8D9SmJ9ASYct8T4zNGSmHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECAEz1P8ksON3Ks4T/JmZBlreoR56Izt24ilqezjvUc0suY5joxii+P3Cz3gT01Qwig7Fgon6pA46pwZdUfIAjPCVurN93KjJkQcF/nctkR+Vn3lIlr/ldsMW7YeWPkM7/xaawyr6j7e5VyQuhQSQwLzaVxI3csZBNFJG+OaEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arJoZS3B; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dc7eba78e6so9004109a12.3;
        Mon, 03 Feb 2025 12:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738615179; x=1739219979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJoLeA5HCdF+uipqG9OTqGKMKt79tnpVrboddnu4FFc=;
        b=arJoZS3BMf5uA0J5DcPDzk9cBa1YmActbBMqt34JwX78njRnqBD+QYBJD3l1M57KWa
         TMebfUQ2u6gTMJKMa+LCF09JIhltYJvj+Rzi80RI2gyrFT0K0UYE2obQjT2IoHbUIgJq
         1GhICHMg/s6CgI+BAjAq6au7la01w/vJy7f7enGOwyrrQYY3CutTt8+e3NgmU6fs2T1g
         l0MzvhCMNc4Hep9Xs0Pdepf7+X/wEnqdMYAEbjSzKl+8wFZC1q8F4H4ZpWNI+xmuzdGU
         p9eEwWJraQgEsJZGUZZ8vIJmDme2mSavF4v7KcUTPWhFcpdDLf1MHnvYYdwC1M4Rp6Cg
         V+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738615179; x=1739219979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJoLeA5HCdF+uipqG9OTqGKMKt79tnpVrboddnu4FFc=;
        b=COVWVwPXnNNXaK6AzlguE5EFIsvAwOrFYtwIXeVYaHFXhlph2oIwijdJSRgWKyRNAD
         4m80VaAymzkUUPf+CSPnZvNjgEWfwBqMrMXmeplDFGB4o1IdPbGFZ0FYaTSoN0f9DrNx
         xuEJSVc9xaiy9umpeOoz7VxdGluSD14guJYROmVE05e2WBfHYJVSnfy0Th3vpz899+lp
         72DwDfweE9GBS+xJD6Z9Q2c/j2w4BEaZVonclHOmVe2QgV1UqMKp4ZlAnZkUuHKpId98
         W8niWl2+OLw03uRCmz8xnvCc6rUwNnOPBKYj2zFfd1SsVwt9ttvRhTZyIQQ1+IdyP9OQ
         kbcg==
X-Forwarded-Encrypted: i=1; AJvYcCU7V3sJqsTRwRraL42g2Iwfsj9qUpuYh+hjBqEvhGQ2V9DNpLCqxKtoNcMjP1K3H+IDkO++oVh+nXRAlw==@vger.kernel.org, AJvYcCUJkwJBBs2XxU+YG3xFiyp1Nafhg0GKbMej9sxYkgcqVs9PFicOqB8sLP3bUW0ZLWIaWw8nznH5Ax8U@vger.kernel.org, AJvYcCXIFxkTnOd+7Kw+L4kwp2tqk+o5Qa/EV8d0SVTr7v41kk83s9jNK8gW6AM7MlJn3lLVE+buloVGRo85N9VD@vger.kernel.org, AJvYcCXVMohUNiImaxzUKLaCigIDgZBcbnhVnwhwrIcWNc3UmzgEtCsOBocvw1PpN3dq9bFjVC4=@vger.kernel.org, AJvYcCXpvxwgeiTz+FihdMlkSZ99AjYY56SZf+V/nekLWEGBeNX5XaRBB0lijHj54K08cFnp7ig05VHj07xqHrjwkQ==@vger.kernel.org, AJvYcCXsMOmxax1HrUyPo1gbx+Phf6sCAAO7gn8NYWbioAEtlUkQDPNLYcEDfjvS9w7jfr0ehBwY358imQq47f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywwwe5egKPieedOeZqgxN2m5IM169vbJL4WicDm37W7BLq2l8c
	KxckLhRvr75f7laE5d41eQv5a85/p1u3ZBzJ5wQyRYV2M21f2HuVp2S39nfw3jLRumFLHzr0zdP
	8zEaCtsFBoPxk4r0i9jqz3m+aDWmI/n8/Nks=
X-Gm-Gg: ASbGncshP4NQ5bfaAXClZHIl52neqC+jPe0Rk/SbO6axMhC6emZjF/kkGa0F9R/knc0
	sSsPpN3lVA+EDaDc6noAebkehNhqc229bCjcVtv4Mgkn4sK/yfeKaolvkc9gx8w4HZIgfgzow
X-Google-Smtp-Source: AGHT+IFNFuJ6PFWXTnztMuE1X9BK0sRVnxTYJ0CcSl1i8HxwsroaqPn8G3ITli2ILPX2NDGvbG709VaVv1BtBVn5pVE=
X-Received: by 2002:a05:6402:1d49:b0:5dc:8b8b:3527 with SMTP id
 4fb4d7f45d1cf-5dc8b8b3955mr14245605a12.17.1738615178722; Mon, 03 Feb 2025
 12:39:38 -0800 (PST)
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
In-Reply-To: <l5apiabdjosyy4gfuenr4oqdfio3zdiajzxoekdgtsohzpn3mj@dcmvayncbye4>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Feb 2025 21:39:27 +0100
X-Gm-Features: AWEUYZkbHu6mMa6EWY6xvPoTALvkWrJQw00UR10VzqG2w2z2rfA8abpNUzs3ZCQ
Message-ID: <CAOQ4uxg63JR2jsy_xA63Zkh_6wzsy_2c30Z_05kZ=cHsRC_UzQ@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
To: Jan Kara <jack@suse.cz>, Alex Williamson <alex.williamson@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 1:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 02-02-25 11:04:02, Christian Brauner wrote:
> > On Sun, Feb 02, 2025 at 08:46:21AM +0100, Amir Goldstein wrote:
> > > On Sun, Feb 2, 2025 at 1:58=E2=80=AFAM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Sat, 1 Feb 2025 at 06:38, Christian Brauner <brauner@kernel.org>=
 wrote:
> > > > >
> > > > > Ok, but those "device fds" aren't really device fds in the sense =
that
> > > > > they are character fds. They are regular files afaict from:
> > > > >
> > > > > vfio_device_open_file(struct vfio_device *device)
> > > > >
> > > > > (Well, it's actually worse as anon_inode_getfile() files don't ha=
ve any
> > > > > mode at all but that's beside the point.)?
> > > > >
> > > > > In any case, I think you're right that such files would (accident=
ly?)
> > > > > qualify for content watches afaict. So at least that should proba=
bly get
> > > > > FMODE_NONOTIFY.
> > > >
> > > > Hmm. Can we just make all anon_inodes do that? I don't think you ca=
n
> > > > sanely have pre-content watches on anon-inodes, since you can't rea=
lly
> > > > have access to them to _set_ the content watch from outside anyway.=
.
> > > >
> > > > In fact, maybe do it in alloc_file_pseudo()?
> > > >
> > >
> > > The problem is that we cannot set FMODE_NONOTIFY -
> > > we tried that once but it regressed some workloads watching
> > > write on pipe fd or something.
> >
> > Ok, that might be true. But I would assume that most users of
> > alloc_file_pseudo() or the anonymous inode infrastructure will not care
> > about fanotify events. I would not go for a separate helper. It'd be
> > nice to keep the number of file allocation functions low.
> >
> > I'd rather have the subsystems that want it explicitly opt-in to
> > fanotify watches, i.e., remove FMODE_NONOTIFY. Because right now we hav=
e
> > broken fanotify support for e.g., nsfs already. So make the subsystems
> > think about whether they actually want to support it.
>
> Agreed, that would be a saner default.
>
> > I would disqualify all anonymous inodes and see what actually does
> > break. I naively suspect that almost no one uses anonymous inodes +
> > fanotify. I'd be very surprised.
> >
> > I'm currently traveling (see you later btw) but from a very cursory
> > reading I would naively suspect the following:
> >
> > // Suspects for FMODE_NONOTIFY
> > drivers/dma-buf/dma-buf.c:      file =3D alloc_file_pseudo(inode, dma_b=
uf_mnt, "dmabuf",
> > drivers/misc/cxl/api.c: file =3D alloc_file_pseudo(inode, cxl_vfs_mount=
, name,
> > drivers/scsi/cxlflash/ocxl_hw.c:        file =3D alloc_file_pseudo(inod=
e, ocxlflash_vfs_mount, name,
> > fs/anon_inodes.c:       file =3D alloc_file_pseudo(inode, anon_inode_mn=
t, name,
> > fs/hugetlbfs/inode.c:           file =3D alloc_file_pseudo(inode, mnt, =
name, O_RDWR,
> > kernel/bpf/token.c:     file =3D alloc_file_pseudo(inode, path.mnt, BPF=
_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
> > mm/secretmem.c: file =3D alloc_file_pseudo(inode, secretmem_mnt, "secre=
tmem",
> > block/bdev.c:   bdev_file =3D alloc_file_pseudo_noaccount(BD_INODE(bdev=
),
> > drivers/tty/pty.c: static int ptmx_open(struct inode *inode, struct fil=
e *filp)
> >
> > // Suspects for ~FMODE_NONOTIFY
> > fs/aio.c:       file =3D alloc_file_pseudo(inode, aio_mnt, "[aio]",
>
> This is just a helper file for managing aio context so I don't think any
> notification makes sense there (events are not well defined). So I'd say
> FMODE_NONOTIFY here as well.
>
> > fs/pipe.c:      f =3D alloc_file_pseudo(inode, pipe_mnt, "",
> > mm/shmem.c:             res =3D alloc_file_pseudo(inode, mnt, name, O_R=
DWR,
>
> This is actually used for stuff like IPC SEM where notification doesn't
> make sense. It's also used when mmapping /dev/zero but that struct file
> isn't easily accessible to userspace so overall I'd say this should be
> FMODE_NONOTIFY as well.

I think there is another code path that the audit missed for getting these
pseudo files not via alloc_file_pseudo():
ipc/shm.c:      file =3D alloc_file_clone(base, f_flags,

which does not copy f_mode as far as I can tell.

>
> > // Unsure:
> > fs/nfs/nfs4file.c:      filep =3D alloc_file_pseudo(r_ino, ss_mnt, read=
_name, O_RDONLY,
>
> AFAICS this struct file is for copy offload and doesn't leave the kernel.
> Hence FMODE_NONOTIFY should be fine.
>
> > net/socket.c:   file =3D alloc_file_pseudo(SOCK_INODE(sock), sock_mnt, =
dname,
>
> In this case I think we need to be careful. It's a similar case as pipes =
so
> probably we should use ~FMODE_NONOTIFY here from pure caution.
>

I tried this approach with patch:
"fsnotify: disable notification by default for all pseudo files"

But I also added another patch:
"fsnotify: disable pre-content and permission events by default"

So that code paths that we missed such as alloc_file_clone()
will not have pre-content events enabled.

Alex,

Can you please try this branch:

https://github.com/amir73il/linux/commits/fsnotify-fixes/

and verify that it fixes your issue.

The branch contains one prep patch:
"fsnotify: use accessor to set FMODE_NONOTIFY_*"
and two independent Fixes patches.

Assuming that it fixes your issue, can you please test each of the
Fixes patches individually, because every one of them should be fixing
the issue independently and every one of them could break something,
so we may end up reverting it later on.

Thanks,
Amir.

