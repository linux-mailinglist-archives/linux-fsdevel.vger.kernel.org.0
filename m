Return-Path: <linux-fsdevel+bounces-55477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB66EB0AB17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 22:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD28E3AFBF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E9E21B9CD;
	Fri, 18 Jul 2025 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax/DRfZH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB2209F45;
	Fri, 18 Jul 2025 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870101; cv=none; b=Da0ZGWd5ghkNQdIUHxDs+sLeXx3RcyVGLbJZE0/EDAyhfYJrNJQ30a7F7K0jBT38pxjjWE3bWopShs43A6VN9hieSF+61tR2pNi931ufwtQcoe8K3m1LQtUJJon3c4KAk9CyvrFNWChBmikKRiXGNKdhLyQbwdm8QAZKOo6vY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870101; c=relaxed/simple;
	bh=P2S9yLAq4MM9XJgTBvdqs7XLFCc5gEQw5eMDjFzosWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOm6WrjbtfavRdJGFkisInLG7tGOCk7RG3dRokQh/tAWXEGn84q0mkJ3lXGdRoBfmZEBYNklmr3cFVqqsfxr3NJFYQwFrjAmTF2uaBI8qnQIawcGV0Tzt/S6bmYZJXETUQqzjBs95wPaSzipKeM/mRVtEerC+6fiw9GykmKruaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax/DRfZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD600C4CEEB;
	Fri, 18 Jul 2025 20:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752870100;
	bh=P2S9yLAq4MM9XJgTBvdqs7XLFCc5gEQw5eMDjFzosWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ax/DRfZHSL12VKwmjy2Jv5nSCxMO0tehtr+ja77T8XZJJwZs03c2qUTjJgjLeTPjs
	 nsDD9Tu6Wf5kTHAXujjfXNVWIxkdVZAXZvCsGVr+zhIBPdZGl6/ATRI9xxWMlNTlKy
	 tj+kbaXhWlNRlV9r+Yr7Fs3U+Mp/wpkCxaXlBynaJ1jDxzQFLlyLnk8f9YyBg5ikUW
	 JU8JkWT7L5EMzRXO2Ve8E0QRbGlT0zOKVqD7/j6yIOI9+b2a18KK5n7SYWVsZVt+2g
	 yzhRpWS7hnDDXroRvGrc7uAt822OUfv1c8lht6bS3eEG4BXiRkkYUgE/AnTbb//xrT
	 59VjH7M5c+jMA==
Date: Fri, 18 Jul 2025 13:21:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net,
	bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>
Subject: Re: [RFC v3] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250718202140.GF2672029@frogsfrogsfrogs>
References: <20250717231038.GQ2672029@frogsfrogsfrogs>
 <20250718-flitzen-imker-4874d797877e@brauner>
 <CAOQ4uxgV_nJZBh4BNE+LEjCsMToHv7vSj8Ci4yJqtR-vrxb=yA@mail.gmail.com>
 <20250718193116.GC2672029@frogsfrogsfrogs>
 <CAOQ4uxgTtGrZ0ACuj-t3aY7dxjzbX6=69ybR7HVUcNemrTaVQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgTtGrZ0ACuj-t3aY7dxjzbX6=69ybR7HVUcNemrTaVQQ@mail.gmail.com>

On Fri, Jul 18, 2025 at 09:56:56PM +0200, Amir Goldstein wrote:
> On Fri, Jul 18, 2025 at 9:31 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Jul 18, 2025 at 01:55:48PM +0200, Amir Goldstein wrote:
> > > On Fri, Jul 18, 2025 at 10:54 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Thu, Jul 17, 2025 at 04:10:38PM -0700, Darrick J. Wong wrote:
> > > > > Hi everyone,
> > > > >
> > > > > DO NOT MERGE THIS, STILL!
> > > > >
> > > > > This is the third request for comments of a prototype to connect the
> > > > > Linux fuse driver to fs-iomap for regular file IO operations to and from
> > > > > files whose contents persist to locally attached storage devices.
> > > > >
> > > > > Why would you want to do that?  Most filesystem drivers are seriously
> > > > > vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
> > > > > over almost a decade of its existence.  Faulty code can lead to total
> > > > > kernel compromise, and I think there's a very strong incentive to move
> > > > > all that parsing out to userspace where we can containerize the fuse
> > > > > server process.
> > > > >
> > > > > willy's folios conversion project (and to a certain degree RH's new
> > > > > mount API) have also demonstrated that treewide changes to the core
> > > > > mm/pagecache/fs code are very very difficult to pull off and take years
> > > > > because you have to understand every filesystem's bespoke use of that
> > > > > core code.  Eeeugh.
> > > > >
> > > > > The fuse command plumbing is very simple -- the ->iomap_begin,
> > > > > ->iomap_end, and iomap ->ioend calls within iomap are turned into
> > > > > upcalls to the fuse server via a trio of new fuse commands.  Pagecache
> > > > > writeback is now a directio write.  The fuse server is now able to
> > > > > upsert mappings into the kernel for cached access (== zero upcalls for
> > > > > rereads and pure overwrites!) and the iomap cache revalidation code
> > > > > works.
> > > > >
> > > > > With this RFC, I am able to show that it's possible to build a fuse
> > > > > server for a real filesystem (ext4) that runs entirely in userspace yet
> > > > > maintains most of its performance.  At this stage I still get about 95%
> > > > > of the kernel ext4 driver's streaming directio performance on streaming
> > > > > IO, and 110% of its streaming buffered IO performance.  Random buffered
> > > > > IO is about 85% as fast as the kernel.  Random direct IO is about 80% as
> > > > > fast as the kernel; see the cover letter for the fuse2fs iomap changes
> > > > > for more details.  Unwritten extent conversions on random direct writes
> > > > > are especially painful for fuse+iomap (~90% more overhead) due to upcall
> > > > > overhead.  And that's with debugging turned on!
> > > > >
> > > > > These items have been addressed since the first RFC:
> > > > >
> > > > > 1. The iomap cookie validation is now present, which avoids subtle races
> > > > > between pagecache zeroing and writeback on filesystems that support
> > > > > unwritten and delalloc mappings.
> > > > >
> > > > > 2. Mappings can be cached in the kernel for more speed.
> > > > >
> > > > > 3. iomap supports inline data.
> > > > >
> > > > > 4. I can now turn on fuse+iomap on a per-inode basis, which turned out
> > > > > to be as easy as creating a new ->getattr_iflags callback so that the
> > > > > fuse server can set fuse_attr::flags.
> > > > >
> > > > > 5. statx and syncfs work on iomap filesystems.
> > > > >
> > > > > 6. Timestamps and ACLs work the same way they do in ext4/xfs when iomap
> > > > > is enabled.
> > > > >
> > > > > 7. The ext4 shutdown ioctl is now supported.
> > > > >
> > > > > There are some major warts remaining:
> > > > >
> > > > > a. ext4 doesn't support out of place writes so I don't know if that
> > > > > actually works correctly.
> > > > >
> > > > > b. iomap is an inode-based service, not a file-based service.  This
> > > > > means that we /must/ push ext2's inode numbers into the kernel via
> > > > > FUSE_GETATTR so that it can report those same numbers back out through
> > > > > the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate nodeid
> > > > > to index its incore inode, so we have to pass those too so that
> > > > > notifications work properly.  This is related to #3 below:
> > > > >
> > > > > c. Hardlinks and iomap are not possible for upper-level libfuse clients
> > > > > because the upper level libfuse likes to abstract kernel nodeids with
> > > > > its own homebrew dirent/inode cache, which doesn't understand hardlinks.
> > > > > As a result, a hardlinked file results in two distinct struct inodes in
> > > > > the kernel, which completely breaks iomap's locking model.  I will have
> > > > > to rewrite fuse2fs for the lowlevel libfuse library to make this work,
> > > > > but on the plus side there will be far less path lookup overhead.
> > > > >
> > > > > d. There are too many changes to the IO manager in libext2fs because I
> > > > > built things needed to stage the direct/buffered IO paths separately.
> > > > > These are now unnecessary but I haven't pulled them out yet because
> > > > > they're sort of useful to verify that iomap file IO never goes through
> > > > > libext2fs except for inline data.
> > > > >
> > > > > e. If we're going to use fuse servers as "safe" replacements for kernel
> > > > > filesystem drivers, we need to be able to set PF_MEMALLOC_NOFS so that
> > > > > fuse2fs memory allocations (in the kernel) don't push pagecache reclaim.
> > > > > We also need to disable the OOM killer(s) for fuse servers because you
> > > > > don't want filesystems to unmount abruptly.
> > > > >
> > > > > f. How do we maximally contain the fuse server to have safe filesystem
> > > > > mounts?  It's very convenient to use systemd services to configure
> > > > > isolation declaratively, but fuse2fs still needs to be able to open
> > > > > /dev/fuse, the ext4 block device, and call mount() in the shared
> > > > > namespace.  This prevents us from using most of the stronger systemd
> > > >
> > > > I'm happy to help you here.
> > > >
> > > > First, I think using a character device for namespaced drivers is always
> > > > a mistake. FUSE predates all that ofc. They're incredibly terrible for
> > > > delegation because of devtmpfs not being namespaced as well as devices
> > > > in general. And having device nodes on anything other than tmpfs is just
> > > > wrong (TM).
> > > >
> > > > In systemd I ultimately want a bpf LSM program that prevents the
> > > > creation of device nodes outside of tmpfs. They don't belong on
> > > > persistent storage imho. But anyway, that's besides the point.
> > > >
> > > > Opening the block device should be done by systemd-mountfsd but I think
> > > > /dev/fuse should really be openable by the service itself.
> >
> > /me slaps his head and remembers that fsopen/fsconfig/fsmount exist.
> > Can you pass an fsopen fd to an unprivileged process and have that
> > second process call fsmount?
> >
> > If so, then it would be more convenient if mount.safe/systemd-mountfsd
> > could pass open fds for /dev/fuse fsopen then the fuse server wouldn't
> > need any special /dev access at all.  I think then the fuse server's
> > service could have:
> >
> > DynamicUser=true
> > ProtectSystem=true
> > ProtectHome=true
> > PrivateTmp=true
> > PrivateDevices=true
> > DevicePolicy=strict
> >
> > (I think most of those are redundant with DynamicUser=true but a lot of
> > my systemd-fu is paged out ATM.)
> >
> > My goal here is extreme containment -- the code doing the fs metadata
> > parsing has no privileges, no write access except to the fds it was
> > given, no network access, and no ability to read anything outside the
> > root filesystem.  Then I can get back to writing buffer
> > overflows^W^Whigh quality filesystem code in peace.
> >
> > > > So we can try and allowlist /dev/fuse in vfs_mknod() similar to
> > > > whiteouts. That means you can do mknod() in the container to create
> > > > /dev/fuse (Personally, I would even restrict this to tmpfs right off the
> > > > bat so that containers can only do this on their private tmpfs mount at
> > > > /dev.)
> > > >
> > > > The downside of this would be to give unprivileged containers access to
> > > > FUSE by default. I don't think that's a problem per se but it is a uapi
> > > > change.
> >
> > Yeah, that is a new risk.  It's still better than metadata parsing
> > within the kernel address space ... though who knows how thoroughly fuse
> > has been fuzzed by syzbot :P
> >
> > > > Let me think a bit about alternatives. I have one crazy idea but I'm not
> > > > sure enough about it to spill it.
> >
> > Please do share, #f is my crazy unbaked idea. :)
> >
> > > I don't think there is a hard requirement for the fuse fd to be opened from
> > > a device driver.
> > > With fuse io_uring communication, the open fd doesn't even need to do io.
> > >
> > > > > protections because they tend to run in a private mount namespace with
> > > > > various parts of the filesystem either hidden or readonly.
> > > > >
> > > > > In theory one could design a socket protocol to pass mount options,
> > > > > block device paths, fds, and responsibility for the mount() call between
> > > > > a mount helper and a service:
> > > >
> > > > This isn't a problem really. This should just be an extension to
> > > > systemd-mountfsd.
> >
> > I suppose mount.safe could very well call systemd-mount to go do all the
> > systemd-related service setup, and that would take care of udisks as
> > well.
> >
> > > This is relevant not only to systemd env.
> > >
> > > I have been experimenting with this mount helper service to mount fuse fs
> > > inside an unprivileged kubernetes container, where opening of /dev/fuse
> > > is restricted by LSM policy:
> > >
> > > https://github.com/pfnet-research/meta-fuse-csi-plugin?tab=readme-ov-file#fusermount3-proxy-modified-fusermount3-approach
> >
> > That sounds similar to what I was thinking about, though there are a lot
> > of TLAs that I don't understand.
> 
> Heh. UDS is Unix Domain Socket if that's what you missed (?)
> All the rest don't matter.

I was wondering what that was.

> It's just a privileged service to mount fuse filesystems.
> The interesting thing is the trick with replacing fusermount3
> to make existing fuse filesystems work out of the box, but the
> principle is simply what you described.

<nod> Got it.

--D

> Thanks,
> Amir.
> 

