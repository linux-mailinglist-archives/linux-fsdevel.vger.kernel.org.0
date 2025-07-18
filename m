Return-Path: <linux-fsdevel+bounces-55425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1CCB0A3AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 13:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8D5A44AE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D45B2D97A5;
	Fri, 18 Jul 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzWcma+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC02D3206;
	Fri, 18 Jul 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839764; cv=none; b=HbgCVp7CexThLwUgjOtTXki5m+nczVnkC1mJ0D5V/4on9umxzoYENIJVetTQcD55O2vEUcOjD1cblJhjfQR7d8JXExf4dHcLlkaybN5ghfDK4Anz/tqK2xzVU60jXdMZI0w1Vlquu4Xm9AmA6QxtmMzbuGJNfOyQ6Uuw1/MnF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839764; c=relaxed/simple;
	bh=Yu9l4+uGnDWMAB72ETaRjtr5I9KSRbjG/k2/y7LSmag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3/fvnn+syUzku9Iz6KvXODsL/xJfJEnfLqrl6N+WtLmO+e7neEH1nnZOs1Tv4D9+L591e3wNiHIF0VXWsrILSR8uSVPvaIX6EfZsQWwX0FeUFf8xo3n3wchqUR03vEYi2wEHXfSGsTfQZhDF4dvalQRLGtOyeQPU50D16YU/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzWcma+D; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae36e88a5daso353725266b.1;
        Fri, 18 Jul 2025 04:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752839761; x=1753444561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAQodLI6GJOGzR7lSrQTLz0mIJeGH24cMSNI+L4TfyQ=;
        b=AzWcma+DYA/S+O19QK07hYzoN4T/ZOAHFm5kn0txHyCzyEbQH9Abr0CBAYWPdQAz+Q
         pyrmBAfgpykKhESDWIu9e1fm8nmM4AZt0b/RZ6izqKCAUrTiPjyUKfuh2suWJkHfzul/
         v2bN6Umi3ooxM+crlr0CWiEHZH8ZpSqPxq2pYlQyhPIwBfp+eqTxSWT3leGwYBfWk5qL
         7LMCY7abA39lvl8cItEnsSgta9jKxE4JFpX6nD5zz2Dg6F58EAoMmOEOsWW/Iq/GoED9
         dcoFPy2ocbUnT8VSl4R6VPqJnCasKocaoy44Zd8RDcQ6q6k65dqf5+deR4tGBkvUoz05
         yfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839761; x=1753444561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAQodLI6GJOGzR7lSrQTLz0mIJeGH24cMSNI+L4TfyQ=;
        b=a9DwtdH5HiAo2cxF3+2prV0hxi0r4lKVCzfw/Tj3Sx/UkyCbCpDE4UAmtf3Mq7qmy4
         GftGJcF+ak+SGu9uRXCvCEOyvEl2N8LOPBbej8ezIomDdjbLnEPyauqJi54xSlptOcrx
         uXgE6GUYPmU4nFg+ziHuZPPBnuuSQcuVNK/hmXH6F6eL9lC3Zx+UpM27kUBr1Y6ZLnMh
         OcZGeBBHn+6eSoOT8uH0lMgvxH0rwdtCQFIuMMdgYTc3f4oWc2vZi2DHkVLY8J52iOEU
         99xlFNent65CfrRdxnfYFB5gPfY8cCN97t2okF7B7VzELJeHKvOQAJWJOsEttj0u2YBc
         DhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNU23S6Z/lNQh5jzTJvoS+2FEG6mlIuCP3KEtTXyS3LkzFG3+kdUSfZI4TkXrj5/+3Xz8BofIQCitI@vger.kernel.org, AJvYcCXMwhU/AkMZih6bpLnkWZ7EKR9bKHRo3Y91Erz6E2YKi1QT8NhPdzpebtDLM9NMFXCnMDbudXJcSzYSkkqpnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxkZbE7jXV/VpSoZ5eTVshodMmbcmdMimt2qo2vkEaM+oLJ5q
	V6/f+hjZoyWEAqHu9sLZEzQDGVzVk6FMzXuN82M3y1LoG9fwQ7PbVpgRQ3sI7hq1FN/zd9fxQsm
	BC8DMNsb8GFWOZsmANxsL0fPXq1+upgk=
X-Gm-Gg: ASbGncs6oFqY0gCDybMnzvf57VBzoVanvOiM1eTorhDF5l3bPZUxPpFRsflEF7q8WYI
	OmVUn+KpJgyZfVF3P29LCykdONxptty05H3wikP5+N8oVr0E8s2e2CLHF0yvoXVP14ATSYV1bsa
	MfQi9y55HcD8eK9WHHvi7e57vEyQLGBd8ROJkMUzJvYWV/i927CtCjUijek0xNNRFl2r44kMu3S
	EnpIaE=
X-Google-Smtp-Source: AGHT+IFRVG8ZFlnkGQ3hS9Di9zxyWFt8m0JA6xcSYNpcVgCNsfAlN/kdmS+xKVi7s+GClb8q0qKAp75nlvoK8SO41JI=
X-Received: by 2002:a17:907:96a2:b0:ae3:60e5:ece3 with SMTP id
 a640c23a62f3a-ae9cdd8436fmr1021536266b.6.1752839760835; Fri, 18 Jul 2025
 04:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717231038.GQ2672029@frogsfrogsfrogs> <20250718-flitzen-imker-4874d797877e@brauner>
In-Reply-To: <20250718-flitzen-imker-4874d797877e@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Jul 2025 13:55:48 +0200
X-Gm-Features: Ac12FXy7G6eUbdR7EELvqcJsgC8hbqG8QMJ6xpOfbLPgoLYK_jgB1P3eB9P4jlE
Message-ID: <CAOQ4uxgV_nJZBh4BNE+LEjCsMToHv7vSj8Ci4yJqtR-vrxb=yA@mail.gmail.com>
Subject: Re: [RFC v3] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, 
	bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, 
	Josef Bacik <josef@toxicpanda.com>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:54=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Jul 17, 2025 at 04:10:38PM -0700, Darrick J. Wong wrote:
> > Hi everyone,
> >
> > DO NOT MERGE THIS, STILL!
> >
> > This is the third request for comments of a prototype to connect the
> > Linux fuse driver to fs-iomap for regular file IO operations to and fro=
m
> > files whose contents persist to locally attached storage devices.
> >
> > Why would you want to do that?  Most filesystem drivers are seriously
> > vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
> > over almost a decade of its existence.  Faulty code can lead to total
> > kernel compromise, and I think there's a very strong incentive to move
> > all that parsing out to userspace where we can containerize the fuse
> > server process.
> >
> > willy's folios conversion project (and to a certain degree RH's new
> > mount API) have also demonstrated that treewide changes to the core
> > mm/pagecache/fs code are very very difficult to pull off and take years
> > because you have to understand every filesystem's bespoke use of that
> > core code.  Eeeugh.
> >
> > The fuse command plumbing is very simple -- the ->iomap_begin,
> > ->iomap_end, and iomap ->ioend calls within iomap are turned into
> > upcalls to the fuse server via a trio of new fuse commands.  Pagecache
> > writeback is now a directio write.  The fuse server is now able to
> > upsert mappings into the kernel for cached access (=3D=3D zero upcalls =
for
> > rereads and pure overwrites!) and the iomap cache revalidation code
> > works.
> >
> > With this RFC, I am able to show that it's possible to build a fuse
> > server for a real filesystem (ext4) that runs entirely in userspace yet
> > maintains most of its performance.  At this stage I still get about 95%
> > of the kernel ext4 driver's streaming directio performance on streaming
> > IO, and 110% of its streaming buffered IO performance.  Random buffered
> > IO is about 85% as fast as the kernel.  Random direct IO is about 80% a=
s
> > fast as the kernel; see the cover letter for the fuse2fs iomap changes
> > for more details.  Unwritten extent conversions on random direct writes
> > are especially painful for fuse+iomap (~90% more overhead) due to upcal=
l
> > overhead.  And that's with debugging turned on!
> >
> > These items have been addressed since the first RFC:
> >
> > 1. The iomap cookie validation is now present, which avoids subtle race=
s
> > between pagecache zeroing and writeback on filesystems that support
> > unwritten and delalloc mappings.
> >
> > 2. Mappings can be cached in the kernel for more speed.
> >
> > 3. iomap supports inline data.
> >
> > 4. I can now turn on fuse+iomap on a per-inode basis, which turned out
> > to be as easy as creating a new ->getattr_iflags callback so that the
> > fuse server can set fuse_attr::flags.
> >
> > 5. statx and syncfs work on iomap filesystems.
> >
> > 6. Timestamps and ACLs work the same way they do in ext4/xfs when iomap
> > is enabled.
> >
> > 7. The ext4 shutdown ioctl is now supported.
> >
> > There are some major warts remaining:
> >
> > a. ext4 doesn't support out of place writes so I don't know if that
> > actually works correctly.
> >
> > b. iomap is an inode-based service, not a file-based service.  This
> > means that we /must/ push ext2's inode numbers into the kernel via
> > FUSE_GETATTR so that it can report those same numbers back out through
> > the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate nodei=
d
> > to index its incore inode, so we have to pass those too so that
> > notifications work properly.  This is related to #3 below:
> >
> > c. Hardlinks and iomap are not possible for upper-level libfuse clients
> > because the upper level libfuse likes to abstract kernel nodeids with
> > its own homebrew dirent/inode cache, which doesn't understand hardlinks=
.
> > As a result, a hardlinked file results in two distinct struct inodes in
> > the kernel, which completely breaks iomap's locking model.  I will have
> > to rewrite fuse2fs for the lowlevel libfuse library to make this work,
> > but on the plus side there will be far less path lookup overhead.
> >
> > d. There are too many changes to the IO manager in libext2fs because I
> > built things needed to stage the direct/buffered IO paths separately.
> > These are now unnecessary but I haven't pulled them out yet because
> > they're sort of useful to verify that iomap file IO never goes through
> > libext2fs except for inline data.
> >
> > e. If we're going to use fuse servers as "safe" replacements for kernel
> > filesystem drivers, we need to be able to set PF_MEMALLOC_NOFS so that
> > fuse2fs memory allocations (in the kernel) don't push pagecache reclaim=
.
> > We also need to disable the OOM killer(s) for fuse servers because you
> > don't want filesystems to unmount abruptly.
> >
> > f. How do we maximally contain the fuse server to have safe filesystem
> > mounts?  It's very convenient to use systemd services to configure
> > isolation declaratively, but fuse2fs still needs to be able to open
> > /dev/fuse, the ext4 block device, and call mount() in the shared
> > namespace.  This prevents us from using most of the stronger systemd
>
> I'm happy to help you here.
>
> First, I think using a character device for namespaced drivers is always
> a mistake. FUSE predates all that ofc. They're incredibly terrible for
> delegation because of devtmpfs not being namespaced as well as devices
> in general. And having device nodes on anything other than tmpfs is just
> wrong (TM).
>
> In systemd I ultimately want a bpf LSM program that prevents the
> creation of device nodes outside of tmpfs. They don't belong on
> persistent storage imho. But anyway, that's besides the point.
>
> Opening the block device should be done by systemd-mountfsd but I think
> /dev/fuse should really be openable by the service itself.
>
> So we can try and allowlist /dev/fuse in vfs_mknod() similar to
> whiteouts. That means you can do mknod() in the container to create
> /dev/fuse (Personally, I would even restrict this to tmpfs right off the
> bat so that containers can only do this on their private tmpfs mount at
> /dev.)
>
> The downside of this would be to give unprivileged containers access to
> FUSE by default. I don't think that's a problem per se but it is a uapi
> change.
>
> Let me think a bit about alternatives. I have one crazy idea but I'm not
> sure enough about it to spill it.
>

I don't think there is a hard requirement for the fuse fd to be opened from
a device driver.
With fuse io_uring communication, the open fd doesn't even need to do io.

> > protections because they tend to run in a private mount namespace with
> > various parts of the filesystem either hidden or readonly.
> >
> > In theory one could design a socket protocol to pass mount options,
> > block device paths, fds, and responsibility for the mount() call betwee=
n
> > a mount helper and a service:
>
> This isn't a problem really. This should just be an extension to
> systemd-mountfsd.

This is relevant not only to systemd env.

I have been experimenting with this mount helper service to mount fuse fs
inside an unprivileged kubernetes container, where opening of /dev/fuse
is restricted by LSM policy:

https://github.com/pfnet-research/meta-fuse-csi-plugin?tab=3Dreadme-ov-file=
#fusermount3-proxy-modified-fusermount3-approach

Thanks,
Amir.

