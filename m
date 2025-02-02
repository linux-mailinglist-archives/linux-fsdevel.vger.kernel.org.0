Return-Path: <linux-fsdevel+bounces-40545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BAFA24D66
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 11:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946381884058
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F41D6194;
	Sun,  2 Feb 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6POX4H5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354B155336;
	Sun,  2 Feb 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738490648; cv=none; b=oVr57p/inA1r+Lguhap8ieo0ppj+rceUMcDvnuCLhg5IjhDi2tNgKgBJPqox6K1wo6UCfH68jowSmCbN0D3K+4m9Wa3wONfinuQ0gZc/EkqdEJol5XEbVeGcGpbVI4/tVBlGWEaUdYdijmdIBW1vDmiJZfWxktVQC283qk3pj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738490648; c=relaxed/simple;
	bh=5A0/mbYhYVhz+EAh4niEYVaHaPaMDyo4YCYJ4LKkzsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBQeff9PMO6jmk2Cmnw1+B3VO3djwS/Ur94wqgWfYxT+hdbl3HJla08mWbMU3q0EcBt3wu6AAYxl7fZGM5SE5NQA8/2MzxJcdRX551saupGhKD2NiNkIs3uBqIateLn+JoDVJgs/f3GWZLP0aeX4bPWgi04SBKvgJccfVXl4V/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6POX4H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9657C4CED1;
	Sun,  2 Feb 2025 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738490648;
	bh=5A0/mbYhYVhz+EAh4niEYVaHaPaMDyo4YCYJ4LKkzsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6POX4H5oxeJIP0Oz3wl/tMuUNjNfGnUuDdqDOX1gC1yVkwxrKGivBkXucI1X36Ea
	 Dfik1aAcAskf/w2yBbjZ4QXR2CMyDkfFk3zMUbG1tTr3ROMKVhUHNpLZyFj+1UEpJO
	 C206/Hnp3kknPUP1GKRO6WenGKK9hdleRoXn5IODEeg6Vh9e8gmUB1LLtTlS/vAYfB
	 2rG2GkzCmNthh+KQEY0wnqAJKX4UW60NM4mccxYxG7DEfjQYe3FDa201J4Wp0MnKxQ
	 lrFDHmAWFaBkwIuyKk5cU52dTJLaIj2vX0saJXFhrbJg+FVEaoiUCxT0a+KNFSZ70f
	 5KeIzRwMl++4g==
Date: Sun, 2 Feb 2025 11:04:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults
 for files with pre content watches
Message-ID: <20250202-abbauen-meerrettich-912513202ce4@brauner>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com>
 <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
 <Z512mt1hmX5Jg7iH@x1.local>
 <20250201-legehennen-klopfen-2ab140dc0422@brauner>
 <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
 <CAOQ4uxjVTir-mmx05zh231BpEN1XbXpooscZyfNUYmVj32-d3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjVTir-mmx05zh231BpEN1XbXpooscZyfNUYmVj32-d3w@mail.gmail.com>

On Sun, Feb 02, 2025 at 08:46:21AM +0100, Amir Goldstein wrote:
> On Sun, Feb 2, 2025 at 1:58 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sat, 1 Feb 2025 at 06:38, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Ok, but those "device fds" aren't really device fds in the sense that
> > > they are character fds. They are regular files afaict from:
> > >
> > > vfio_device_open_file(struct vfio_device *device)
> > >
> > > (Well, it's actually worse as anon_inode_getfile() files don't have any
> > > mode at all but that's beside the point.)?
> > >
> > > In any case, I think you're right that such files would (accidently?)
> > > qualify for content watches afaict. So at least that should probably get
> > > FMODE_NONOTIFY.
> >
> > Hmm. Can we just make all anon_inodes do that? I don't think you can
> > sanely have pre-content watches on anon-inodes, since you can't really
> > have access to them to _set_ the content watch from outside anyway..
> >
> > In fact, maybe do it in alloc_file_pseudo()?
> >
> 
> The problem is that we cannot set FMODE_NONOTIFY -
> we tried that once but it regressed some workloads watching
> write on pipe fd or something.

Ok, that might be true. But I would assume that most users of
alloc_file_pseudo() or the anonymous inode infrastructure will not care
about fanotify events. I would not go for a separate helper. It'd be
nice to keep the number of file allocation functions low.

I'd rather have the subsystems that want it explicitly opt-in to
fanotify watches, i.e., remove FMODE_NONOTIFY. Because right now we have
broken fanotify support for e.g., nsfs already. So make the subsystems
think about whether they actually want to support it.

I would disqualify all anonymous inodes and see what actually does
break. I naively suspect that almost no one uses anonymous inodes +
fanotify. I'd be very surprised.

I'm currently traveling (see you later btw) but from a very cursory
reading I would naively suspect the following:

// Suspects for FMODE_NONOTIFY
drivers/dma-buf/dma-buf.c:      file = alloc_file_pseudo(inode, dma_buf_mnt, "dmabuf",
drivers/misc/cxl/api.c: file = alloc_file_pseudo(inode, cxl_vfs_mount, name,
drivers/scsi/cxlflash/ocxl_hw.c:        file = alloc_file_pseudo(inode, ocxlflash_vfs_mount, name,
fs/anon_inodes.c:       file = alloc_file_pseudo(inode, anon_inode_mnt, name,
fs/hugetlbfs/inode.c:           file = alloc_file_pseudo(inode, mnt, name, O_RDWR,
kernel/bpf/token.c:     file = alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
mm/secretmem.c: file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
block/bdev.c:   bdev_file = alloc_file_pseudo_noaccount(BD_INODE(bdev),
drivers/tty/pty.c: static int ptmx_open(struct inode *inode, struct file *filp)

// Suspects for ~FMODE_NONOTIFY
fs/aio.c:       file = alloc_file_pseudo(inode, aio_mnt, "[aio]",
fs/pipe.c:      f = alloc_file_pseudo(inode, pipe_mnt, "",
mm/shmem.c:             res = alloc_file_pseudo(inode, mnt, name, O_RDWR,

// Unsure:
fs/nfs/nfs4file.c:      filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, O_RDONLY,
net/socket.c:   file = alloc_file_pseudo(SOCK_INODE(sock), sock_mnt, dname,

> 
> and the no-pre-content is a flag combination (to save FMODE_ flags)
> which makes things a bit messy.
> 
> We could try to initialize f_mode to FMODE_NONOTIFY_PERM
> for anon_inode, which opts out of both permission and pre-content
> events and leaves the legacy inotify workloads unaffected.
> 
> But, then code like this will not do the right thing:
> 
>         /* We refuse fsnotify events on ptmx, since it's a shared resource */
>         filp->f_mode |= FMODE_NONOTIFY;
> 
> We will need to convert all those to use a helper.
> I am traveling today so will be able to look closer tomorrow.
> 
> Jan,
> 
> What do you think?
> 
> Amir.

