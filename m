Return-Path: <linux-fsdevel+bounces-58027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B994EB28188
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883C5B63E70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF7E21D3D3;
	Fri, 15 Aug 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYr1YDQT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E585450F2;
	Fri, 15 Aug 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267659; cv=none; b=hDRe6VWbqRlgOTH9pkDGmb6WMHBmCGKdDv2eMnve6uhLPZscYiPr692ShgS8LEq7PY6T9BeAOEz+iTmSZFg6cyJEa7pDflRhn3pK9kxCfAKUQ+NSGVR1yA6gx7pSrRte1eASTa/GvIBjDsguGFgjiZ7EnjHqlbyUc0a1TGz1sEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267659; c=relaxed/simple;
	bh=CmrUVsxqCUAaZwiw/dyqGAFMg4t9uqIfDWvyH5kmY48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmTMcGlvriDW1fcGm06gG8DiD8Rc4mxCHfp+sCNd7IVLNIY+Y5C9iXm5Msccys1HMx0xOBcuuUQ5ZkHRGmgDrXFHchSdZYuGZaEMXZbI7cRnpg8GJ9GFBazBWbtu9LS+Ejwt6EcUdZMllPgaa9w6bGhXNtLNYJ1bn+1nzEUt7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYr1YDQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D28C4CEEB;
	Fri, 15 Aug 2025 14:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755267658;
	bh=CmrUVsxqCUAaZwiw/dyqGAFMg4t9uqIfDWvyH5kmY48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYr1YDQTr9b6colu0pTAZbwGKfvYrwZluMVJStxZH9QC89uMThSvfYYMBCCl1+5Ic
	 bDXQNfNWXHs9oB8IZo5NsF8T5+XVlltzvwmM52D6FXqH2tLcMoKBUoXLkhzwfi3lti
	 quuJhpYnOxVKuL1cz8qpOm1HiEdGciVsIQurwqhZG5ICEbM7XOexJGdLpTlLFoUL9m
	 RdEpGK++AOrNtG8v9KkoqE/wSkxV+rlMZjIoc7KLL6b+bSWStI3UYWYtt8TlO3T6Hr
	 KkSFFhWEQPW0qcV4UZMNHaPlu8JYB37DZ639bb2X8xgkZqY8IRIBnkV0/MFHWvUnGw
	 VRHi47x6UjQBQ==
Date: Fri, 15 Aug 2025 16:20:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, miklos@szeredi.hu, 
	joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>
Subject: Re: [RFC v3] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250815-inlandsreise-anbinden-51a1b154a36e@brauner>
References: <20250717231038.GQ2672029@frogsfrogsfrogs>
 <20250718-flitzen-imker-4874d797877e@brauner>
 <CAOQ4uxgV_nJZBh4BNE+LEjCsMToHv7vSj8Ci4yJqtR-vrxb=yA@mail.gmail.com>
 <20250718193116.GC2672029@frogsfrogsfrogs>
 <20250723-situiert-lenkrad-c17d23a177bd@brauner>
 <20250723180443.GK2672029@frogsfrogsfrogs>
 <20250731-mitverantwortlich-geothermie-085916922040@brauner>
 <20250731172206.GJ2672070@frogsfrogsfrogs>
 <20250804-beinverletzungen-gerangel-46568ab20e04@brauner>
 <20250812202025.GG7938@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250812202025.GG7938@frogsfrogsfrogs>

On Tue, Aug 12, 2025 at 01:20:25PM -0700, Darrick J. Wong wrote:
> On Mon, Aug 04, 2025 at 12:12:24PM +0200, Christian Brauner wrote:
> > On Thu, Jul 31, 2025 at 10:22:06AM -0700, Darrick J. Wong wrote:
> > > On Thu, Jul 31, 2025 at 12:13:01PM +0200, Christian Brauner wrote:
> > > > On Wed, Jul 23, 2025 at 11:04:43AM -0700, Darrick J. Wong wrote:
> > > > > On Wed, Jul 23, 2025 at 03:05:12PM +0200, Christian Brauner wrote:
> > > > > > On Fri, Jul 18, 2025 at 12:31:16PM -0700, Darrick J. Wong wrote:
> > > > > > > On Fri, Jul 18, 2025 at 01:55:48PM +0200, Amir Goldstein wrote:
> > > > > > > > On Fri, Jul 18, 2025 at 10:54 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jul 17, 2025 at 04:10:38PM -0700, Darrick J. Wong wrote:
> > > > > > > > > > Hi everyone,
> > > > > > > > > >
> > > > > > > > > > DO NOT MERGE THIS, STILL!
> > > > > > > > > >
> > > > > > > > > > This is the third request for comments of a prototype to connect the
> > > > > > > > > > Linux fuse driver to fs-iomap for regular file IO operations to and from
> > > > > > > > > > files whose contents persist to locally attached storage devices.
> > > > > > > > > >
> > > > > > > > > > Why would you want to do that?  Most filesystem drivers are seriously
> > > > > > > > > > vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
> > > > > > > > > > over almost a decade of its existence.  Faulty code can lead to total
> > > > > > > > > > kernel compromise, and I think there's a very strong incentive to move
> > > > > > > > > > all that parsing out to userspace where we can containerize the fuse
> > > > > > > > > > server process.
> > > > > > > > > >
> > > > > > > > > > willy's folios conversion project (and to a certain degree RH's new
> > > > > > > > > > mount API) have also demonstrated that treewide changes to the core
> > > > > > > > > > mm/pagecache/fs code are very very difficult to pull off and take years
> > > > > > > > > > because you have to understand every filesystem's bespoke use of that
> > > > > > > > > > core code.  Eeeugh.
> > > > > > > > > >
> > > > > > > > > > The fuse command plumbing is very simple -- the ->iomap_begin,
> > > > > > > > > > ->iomap_end, and iomap ->ioend calls within iomap are turned into
> > > > > > > > > > upcalls to the fuse server via a trio of new fuse commands.  Pagecache
> > > > > > > > > > writeback is now a directio write.  The fuse server is now able to
> > > > > > > > > > upsert mappings into the kernel for cached access (== zero upcalls for
> > > > > > > > > > rereads and pure overwrites!) and the iomap cache revalidation code
> > > > > > > > > > works.
> > > > > > > > > >
> > > > > > > > > > With this RFC, I am able to show that it's possible to build a fuse
> > > > > > > > > > server for a real filesystem (ext4) that runs entirely in userspace yet
> > > > > > > > > > maintains most of its performance.  At this stage I still get about 95%
> > > > > > > > > > of the kernel ext4 driver's streaming directio performance on streaming
> > > > > > > > > > IO, and 110% of its streaming buffered IO performance.  Random buffered
> > > > > > > > > > IO is about 85% as fast as the kernel.  Random direct IO is about 80% as
> > > > > > > > > > fast as the kernel; see the cover letter for the fuse2fs iomap changes
> > > > > > > > > > for more details.  Unwritten extent conversions on random direct writes
> > > > > > > > > > are especially painful for fuse+iomap (~90% more overhead) due to upcall
> > > > > > > > > > overhead.  And that's with debugging turned on!
> > > > > > > > > >
> > > > > > > > > > These items have been addressed since the first RFC:
> > > > > > > > > >
> > > > > > > > > > 1. The iomap cookie validation is now present, which avoids subtle races
> > > > > > > > > > between pagecache zeroing and writeback on filesystems that support
> > > > > > > > > > unwritten and delalloc mappings.
> > > > > > > > > >
> > > > > > > > > > 2. Mappings can be cached in the kernel for more speed.
> > > > > > > > > >
> > > > > > > > > > 3. iomap supports inline data.
> > > > > > > > > >
> > > > > > > > > > 4. I can now turn on fuse+iomap on a per-inode basis, which turned out
> > > > > > > > > > to be as easy as creating a new ->getattr_iflags callback so that the
> > > > > > > > > > fuse server can set fuse_attr::flags.
> > > > > > > > > >
> > > > > > > > > > 5. statx and syncfs work on iomap filesystems.
> > > > > > > > > >
> > > > > > > > > > 6. Timestamps and ACLs work the same way they do in ext4/xfs when iomap
> > > > > > > > > > is enabled.
> > > > > > > > > >
> > > > > > > > > > 7. The ext4 shutdown ioctl is now supported.
> > > > > > > > > >
> > > > > > > > > > There are some major warts remaining:
> > > > > > > > > >
> > > > > > > > > > a. ext4 doesn't support out of place writes so I don't know if that
> > > > > > > > > > actually works correctly.
> > > > > > > > > >
> > > > > > > > > > b. iomap is an inode-based service, not a file-based service.  This
> > > > > > > > > > means that we /must/ push ext2's inode numbers into the kernel via
> > > > > > > > > > FUSE_GETATTR so that it can report those same numbers back out through
> > > > > > > > > > the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate nodeid
> > > > > > > > > > to index its incore inode, so we have to pass those too so that
> > > > > > > > > > notifications work properly.  This is related to #3 below:
> > > > > > > > > >
> > > > > > > > > > c. Hardlinks and iomap are not possible for upper-level libfuse clients
> > > > > > > > > > because the upper level libfuse likes to abstract kernel nodeids with
> > > > > > > > > > its own homebrew dirent/inode cache, which doesn't understand hardlinks.
> > > > > > > > > > As a result, a hardlinked file results in two distinct struct inodes in
> > > > > > > > > > the kernel, which completely breaks iomap's locking model.  I will have
> > > > > > > > > > to rewrite fuse2fs for the lowlevel libfuse library to make this work,
> > > > > > > > > > but on the plus side there will be far less path lookup overhead.
> > > > > > > > > >
> > > > > > > > > > d. There are too many changes to the IO manager in libext2fs because I
> > > > > > > > > > built things needed to stage the direct/buffered IO paths separately.
> > > > > > > > > > These are now unnecessary but I haven't pulled them out yet because
> > > > > > > > > > they're sort of useful to verify that iomap file IO never goes through
> > > > > > > > > > libext2fs except for inline data.
> > > > > > > > > >
> > > > > > > > > > e. If we're going to use fuse servers as "safe" replacements for kernel
> > > > > > > > > > filesystem drivers, we need to be able to set PF_MEMALLOC_NOFS so that
> > > > > > > > > > fuse2fs memory allocations (in the kernel) don't push pagecache reclaim.
> > > > > > > > > > We also need to disable the OOM killer(s) for fuse servers because you
> > > > > > > > > > don't want filesystems to unmount abruptly.
> > > > > > > > > >
> > > > > > > > > > f. How do we maximally contain the fuse server to have safe filesystem
> > > > > > > > > > mounts?  It's very convenient to use systemd services to configure
> > > > > > > > > > isolation declaratively, but fuse2fs still needs to be able to open
> > > > > > > > > > /dev/fuse, the ext4 block device, and call mount() in the shared
> > > > > > > > > > namespace.  This prevents us from using most of the stronger systemd
> > > > > > > > >
> > > > > > > > > I'm happy to help you here.
> > > > > > > > >
> > > > > > > > > First, I think using a character device for namespaced drivers is always
> > > > > > > > > a mistake. FUSE predates all that ofc. They're incredibly terrible for
> > > > > > > > > delegation because of devtmpfs not being namespaced as well as devices
> > > > > > > > > in general. And having device nodes on anything other than tmpfs is just
> > > > > > > > > wrong (TM).
> > > > > > > > >
> > > > > > > > > In systemd I ultimately want a bpf LSM program that prevents the
> > > > > > > > > creation of device nodes outside of tmpfs. They don't belong on
> > > > > > > > > persistent storage imho. But anyway, that's besides the point.
> > > > > > > > >
> > > > > > > > > Opening the block device should be done by systemd-mountfsd but I think
> > > > > > > > > /dev/fuse should really be openable by the service itself.
> > > > > > > 
> > > > > > > /me slaps his head and remembers that fsopen/fsconfig/fsmount exist.
> > > > > > > Can you pass an fsopen fd to an unprivileged process and have that
> > > > > > > second process call fsmount?
> > > > > > 
> > > > > > Yes, but remember that at some point you must call
> > > > > > fsconfig(FSCONFIG_CMD_CREATE) to create the superblock. On block based
> > > > > > fses that requires CAP_SYS_ADMIN so that has to be done by the
> > > > > > privielged process. All the rest can be done by the unprivileged process
> > > > > > though. That's exactly how bpf tokens work.
> > > > > 
> > > > > Hrm.  Assuming the fsopen mount sequence is still:
> > > > > 
> > > > > 	sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> > > > > 	fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> > > > > 	...
> > > > > 	fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> > > > > 	mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MS_RELATIME);
> > > > > 	move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> > > > > 
> > > > > Then I guess whoever calls fsconfig(FSCONFIG_CMD_CREATE) needs
> > > > > CAP_SYS_ADMIN; and they have to be running in the desired fs namespace
> > > > > for move_mount() to have the intended effect.
> > > > 
> > > > Yes-ish.
> > > > 
> > > > At fsopen() time the user namespace of the caller is recorded in
> > > > fs_context->user_ns. If the filesystems is mountable inside of a user
> > > > namespace then fs_context->user_ns will be used to perform the
> > > > CAP_SYS_ADMIN check.
> > > 
> > > Hrmm, well fuse is one of the filesystems that sets FS_USERNS_MOUNT, so
> > > I gather that means that the fuse service server (ugh) could invoke the
> > > mount using the fsopen fd given to it?  That sounds promising.
> > 
> > Yes, it could provided fsopen() was called in a user namespace that the
> > service holds privileges over.
> > 
> > > 
> > > > For filesystems that aren't mountable inside of user namespaces (ext4,
> > > > xfs, ...) the fs_context->user_ns is ignored in mount_capable() and
> > > > global CAP_SYS_ADMIN is required. sget_fc() and friends flat out refuse
> > > > to mount a filesystem with a non-initial userns if it's not marked as
> > > > mountable. That used to be possible but it's an invitation for extremely
> > > > subtle bugs and you gain control over the superblock itself.
> > > 
> > > I guess that's commit e1c5ae59c0f22f ("fs: don't allow non-init
> > > s_user_ns for filesystems without FS_USERNS_MOUNT")?  What does it mean
> > > for a filesystem to be "...written with a non-initial s_user_ns in
> > > mind"?  Is there something specific that I should look out for, aside
> > > from the usual "we don't mount parking lot xfs because validating that
> > > is too hard and it might explode the kernel"?
> > 
> > So there are two sides on how to view this:
> > 
> > (1) The filesystem is mountable   in a user namespace.
> > (2) The filesystem is delegatable to a user namespace.
> > 
> > These are two different things. Allowing (1) is difficult because of the
> > usual complexities involved even though everyone always seems to believe
> > that their block-based filesystems is reliable enough to be mounted with
> > any corrupted image.
> > 
> > But (2) is something that's doable and in fact something we do allow
> > currently for e.g., bpffs. In order to allow containers to use bpf the
> > container must have a bpffs instance mounted.
> > 
> > To do this fsopen() must be called in the containers user namespace. To
> > allow specific bpf features and to actually create the superblock
> > CAP_SYS_ADMIN or CAP_BPF in the initial users namespace are required.
> > Then a new bpf instance will be created that is owned by the user
> > namespace of the container.
> > 
> > IOW, to delegate a superblock/filesystems to an unprivileged container
> > capabilities are still required but ultimately the filesystems will be
> > owned by the container.
> 
> <nod>
> 
> > One story I always found worth exploring to get at (1) is if we had
> > dm-verity directly integrated into the filesystem. And I don't mean
> > fsverity, I mean dm-verity and in a way such that it's explicitly not
> > part of the on-disk image in contrast to fsverity where each filesystem
> > integrates this very differently into their on-disk format. It basically
> > would be as dumb as it gets. Static, simple arithmetic, appended,
> > pre-pended, whatever.
> 
> That would work as long as you don't need to write to the filesystem,
> ever.  For gold master rootfs that would work fine, less so for "my
> container needs a writable data partition but the bofh doesn't want us
> compromising kernel memory".

Yes, for that use-case you probably almost always want to combine this
with overlayfs. Well, ideally the system would clearly differentiate
between filesystems that contain executable code and those should never
be writable and filesystem that contain data.

