Return-Path: <linux-fsdevel+bounces-56631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2AAB19F86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 12:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5963AEE0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 10:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E4A248166;
	Mon,  4 Aug 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCbAqjhL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751124677C;
	Mon,  4 Aug 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302350; cv=none; b=QWOh6J7q76J0XlFfDVmz6aY8dPfUPo39rOXm2CGIAu2trNIPUjNNztDEkA3p0LpdLZ8RKCoWaXV6kmB6GHY4mvL1dp+REQmtUvl1DQXBpi/4VwZ6oPlv9AJaXE00PFQafoysFKKPDdEle1SoOgfYBzWcWCLWbApAbyessVx9U1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302350; c=relaxed/simple;
	bh=1h3tSzfJEFTHhAiczHx0Em7xHnHH9WPW4Imq/5IMruY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpMhir3kE5ycXEnVBwNWMhv56DLjCX8l6l0gp2pVGvEjnYbTZwSaLRAbPXFpgmrG/F42kIZR8xYpj07v0KlZmfSFCPpzIfuiHMbYYByqQi6ZV7wTsjS3qno1tL+rb5tj5BhfFERxmmzJQ2hCEz7CbTcrYvYqt6kflWzCqXLw+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCbAqjhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A1DC4CEE7;
	Mon,  4 Aug 2025 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754302349;
	bh=1h3tSzfJEFTHhAiczHx0Em7xHnHH9WPW4Imq/5IMruY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCbAqjhLVuDEYRi35k8S7fXJLdyZXyaSUaDybMGSg4S3WuXvLwSs0GGv/lHVMtYm6
	 RzhF17k8ENHUkHX17cLC0KZ8PIQIjUPJCZxk+Pn4IpaqE/bIUWT9VF6K8FRhuT9SPL
	 gO/MlfsS8hMcMd/fDa8YPaJNlwdGFQXcO3C9sX+O1utZItng1r5nFDW9qbjs1GFjVJ
	 avtRsFGnBMPxPq9IeUE5tdkn77gYByL4BIjQ86ZXPgPt8zb5bPWp3/KwefuEHYmlIV
	 X38h3IrPueAMX5o3A/F++dw9bxl1RnR630oG/Yuq0JBDZewX4+MawSgw8Tw27q0MxJ
	 l5dflnSIOr7gQ==
Date: Mon, 4 Aug 2025 12:12:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, miklos@szeredi.hu, 
	joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>
Subject: Re: [RFC v3] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250804-beinverletzungen-gerangel-46568ab20e04@brauner>
References: <20250717231038.GQ2672029@frogsfrogsfrogs>
 <20250718-flitzen-imker-4874d797877e@brauner>
 <CAOQ4uxgV_nJZBh4BNE+LEjCsMToHv7vSj8Ci4yJqtR-vrxb=yA@mail.gmail.com>
 <20250718193116.GC2672029@frogsfrogsfrogs>
 <20250723-situiert-lenkrad-c17d23a177bd@brauner>
 <20250723180443.GK2672029@frogsfrogsfrogs>
 <20250731-mitverantwortlich-geothermie-085916922040@brauner>
 <20250731172206.GJ2672070@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731172206.GJ2672070@frogsfrogsfrogs>

On Thu, Jul 31, 2025 at 10:22:06AM -0700, Darrick J. Wong wrote:
> On Thu, Jul 31, 2025 at 12:13:01PM +0200, Christian Brauner wrote:
> > On Wed, Jul 23, 2025 at 11:04:43AM -0700, Darrick J. Wong wrote:
> > > On Wed, Jul 23, 2025 at 03:05:12PM +0200, Christian Brauner wrote:
> > > > On Fri, Jul 18, 2025 at 12:31:16PM -0700, Darrick J. Wong wrote:
> > > > > On Fri, Jul 18, 2025 at 01:55:48PM +0200, Amir Goldstein wrote:
> > > > > > On Fri, Jul 18, 2025 at 10:54 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Jul 17, 2025 at 04:10:38PM -0700, Darrick J. Wong wrote:
> > > > > > > > Hi everyone,
> > > > > > > >
> > > > > > > > DO NOT MERGE THIS, STILL!
> > > > > > > >
> > > > > > > > This is the third request for comments of a prototype to connect the
> > > > > > > > Linux fuse driver to fs-iomap for regular file IO operations to and from
> > > > > > > > files whose contents persist to locally attached storage devices.
> > > > > > > >
> > > > > > > > Why would you want to do that?  Most filesystem drivers are seriously
> > > > > > > > vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
> > > > > > > > over almost a decade of its existence.  Faulty code can lead to total
> > > > > > > > kernel compromise, and I think there's a very strong incentive to move
> > > > > > > > all that parsing out to userspace where we can containerize the fuse
> > > > > > > > server process.
> > > > > > > >
> > > > > > > > willy's folios conversion project (and to a certain degree RH's new
> > > > > > > > mount API) have also demonstrated that treewide changes to the core
> > > > > > > > mm/pagecache/fs code are very very difficult to pull off and take years
> > > > > > > > because you have to understand every filesystem's bespoke use of that
> > > > > > > > core code.  Eeeugh.
> > > > > > > >
> > > > > > > > The fuse command plumbing is very simple -- the ->iomap_begin,
> > > > > > > > ->iomap_end, and iomap ->ioend calls within iomap are turned into
> > > > > > > > upcalls to the fuse server via a trio of new fuse commands.  Pagecache
> > > > > > > > writeback is now a directio write.  The fuse server is now able to
> > > > > > > > upsert mappings into the kernel for cached access (== zero upcalls for
> > > > > > > > rereads and pure overwrites!) and the iomap cache revalidation code
> > > > > > > > works.
> > > > > > > >
> > > > > > > > With this RFC, I am able to show that it's possible to build a fuse
> > > > > > > > server for a real filesystem (ext4) that runs entirely in userspace yet
> > > > > > > > maintains most of its performance.  At this stage I still get about 95%
> > > > > > > > of the kernel ext4 driver's streaming directio performance on streaming
> > > > > > > > IO, and 110% of its streaming buffered IO performance.  Random buffered
> > > > > > > > IO is about 85% as fast as the kernel.  Random direct IO is about 80% as
> > > > > > > > fast as the kernel; see the cover letter for the fuse2fs iomap changes
> > > > > > > > for more details.  Unwritten extent conversions on random direct writes
> > > > > > > > are especially painful for fuse+iomap (~90% more overhead) due to upcall
> > > > > > > > overhead.  And that's with debugging turned on!
> > > > > > > >
> > > > > > > > These items have been addressed since the first RFC:
> > > > > > > >
> > > > > > > > 1. The iomap cookie validation is now present, which avoids subtle races
> > > > > > > > between pagecache zeroing and writeback on filesystems that support
> > > > > > > > unwritten and delalloc mappings.
> > > > > > > >
> > > > > > > > 2. Mappings can be cached in the kernel for more speed.
> > > > > > > >
> > > > > > > > 3. iomap supports inline data.
> > > > > > > >
> > > > > > > > 4. I can now turn on fuse+iomap on a per-inode basis, which turned out
> > > > > > > > to be as easy as creating a new ->getattr_iflags callback so that the
> > > > > > > > fuse server can set fuse_attr::flags.
> > > > > > > >
> > > > > > > > 5. statx and syncfs work on iomap filesystems.
> > > > > > > >
> > > > > > > > 6. Timestamps and ACLs work the same way they do in ext4/xfs when iomap
> > > > > > > > is enabled.
> > > > > > > >
> > > > > > > > 7. The ext4 shutdown ioctl is now supported.
> > > > > > > >
> > > > > > > > There are some major warts remaining:
> > > > > > > >
> > > > > > > > a. ext4 doesn't support out of place writes so I don't know if that
> > > > > > > > actually works correctly.
> > > > > > > >
> > > > > > > > b. iomap is an inode-based service, not a file-based service.  This
> > > > > > > > means that we /must/ push ext2's inode numbers into the kernel via
> > > > > > > > FUSE_GETATTR so that it can report those same numbers back out through
> > > > > > > > the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate nodeid
> > > > > > > > to index its incore inode, so we have to pass those too so that
> > > > > > > > notifications work properly.  This is related to #3 below:
> > > > > > > >
> > > > > > > > c. Hardlinks and iomap are not possible for upper-level libfuse clients
> > > > > > > > because the upper level libfuse likes to abstract kernel nodeids with
> > > > > > > > its own homebrew dirent/inode cache, which doesn't understand hardlinks.
> > > > > > > > As a result, a hardlinked file results in two distinct struct inodes in
> > > > > > > > the kernel, which completely breaks iomap's locking model.  I will have
> > > > > > > > to rewrite fuse2fs for the lowlevel libfuse library to make this work,
> > > > > > > > but on the plus side there will be far less path lookup overhead.
> > > > > > > >
> > > > > > > > d. There are too many changes to the IO manager in libext2fs because I
> > > > > > > > built things needed to stage the direct/buffered IO paths separately.
> > > > > > > > These are now unnecessary but I haven't pulled them out yet because
> > > > > > > > they're sort of useful to verify that iomap file IO never goes through
> > > > > > > > libext2fs except for inline data.
> > > > > > > >
> > > > > > > > e. If we're going to use fuse servers as "safe" replacements for kernel
> > > > > > > > filesystem drivers, we need to be able to set PF_MEMALLOC_NOFS so that
> > > > > > > > fuse2fs memory allocations (in the kernel) don't push pagecache reclaim.
> > > > > > > > We also need to disable the OOM killer(s) for fuse servers because you
> > > > > > > > don't want filesystems to unmount abruptly.
> > > > > > > >
> > > > > > > > f. How do we maximally contain the fuse server to have safe filesystem
> > > > > > > > mounts?  It's very convenient to use systemd services to configure
> > > > > > > > isolation declaratively, but fuse2fs still needs to be able to open
> > > > > > > > /dev/fuse, the ext4 block device, and call mount() in the shared
> > > > > > > > namespace.  This prevents us from using most of the stronger systemd
> > > > > > >
> > > > > > > I'm happy to help you here.
> > > > > > >
> > > > > > > First, I think using a character device for namespaced drivers is always
> > > > > > > a mistake. FUSE predates all that ofc. They're incredibly terrible for
> > > > > > > delegation because of devtmpfs not being namespaced as well as devices
> > > > > > > in general. And having device nodes on anything other than tmpfs is just
> > > > > > > wrong (TM).
> > > > > > >
> > > > > > > In systemd I ultimately want a bpf LSM program that prevents the
> > > > > > > creation of device nodes outside of tmpfs. They don't belong on
> > > > > > > persistent storage imho. But anyway, that's besides the point.
> > > > > > >
> > > > > > > Opening the block device should be done by systemd-mountfsd but I think
> > > > > > > /dev/fuse should really be openable by the service itself.
> > > > > 
> > > > > /me slaps his head and remembers that fsopen/fsconfig/fsmount exist.
> > > > > Can you pass an fsopen fd to an unprivileged process and have that
> > > > > second process call fsmount?
> > > > 
> > > > Yes, but remember that at some point you must call
> > > > fsconfig(FSCONFIG_CMD_CREATE) to create the superblock. On block based
> > > > fses that requires CAP_SYS_ADMIN so that has to be done by the
> > > > privielged process. All the rest can be done by the unprivileged process
> > > > though. That's exactly how bpf tokens work.
> > > 
> > > Hrm.  Assuming the fsopen mount sequence is still:
> > > 
> > > 	sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> > > 	fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> > > 	...
> > > 	fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> > > 	mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MS_RELATIME);
> > > 	move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> > > 
> > > Then I guess whoever calls fsconfig(FSCONFIG_CMD_CREATE) needs
> > > CAP_SYS_ADMIN; and they have to be running in the desired fs namespace
> > > for move_mount() to have the intended effect.
> > 
> > Yes-ish.
> > 
> > At fsopen() time the user namespace of the caller is recorded in
> > fs_context->user_ns. If the filesystems is mountable inside of a user
> > namespace then fs_context->user_ns will be used to perform the
> > CAP_SYS_ADMIN check.
> 
> Hrmm, well fuse is one of the filesystems that sets FS_USERNS_MOUNT, so
> I gather that means that the fuse service server (ugh) could invoke the
> mount using the fsopen fd given to it?  That sounds promising.

Yes, it could provided fsopen() was called in a user namespace that the
service holds privileges over.

> 
> > For filesystems that aren't mountable inside of user namespaces (ext4,
> > xfs, ...) the fs_context->user_ns is ignored in mount_capable() and
> > global CAP_SYS_ADMIN is required. sget_fc() and friends flat out refuse
> > to mount a filesystem with a non-initial userns if it's not marked as
> > mountable. That used to be possible but it's an invitation for extremely
> > subtle bugs and you gain control over the superblock itself.
> 
> I guess that's commit e1c5ae59c0f22f ("fs: don't allow non-init
> s_user_ns for filesystems without FS_USERNS_MOUNT")?  What does it mean
> for a filesystem to be "...written with a non-initial s_user_ns in
> mind"?  Is there something specific that I should look out for, aside
> from the usual "we don't mount parking lot xfs because validating that
> is too hard and it might explode the kernel"?

So there are two sides on how to view this:

(1) The filesystem is mountable   in a user namespace.
(2) The filesystem is delegatable to a user namespace.

These are two different things. Allowing (1) is difficult because of the
usual complexities involved even though everyone always seems to believe
that their block-based filesystems is reliable enough to be mounted with
any corrupted image.

But (2) is something that's doable and in fact something we do allow
currently for e.g., bpffs. In order to allow containers to use bpf the
container must have a bpffs instance mounted.

To do this fsopen() must be called in the containers user namespace. To
allow specific bpf features and to actually create the superblock
CAP_SYS_ADMIN or CAP_BPF in the initial users namespace are required.
Then a new bpf instance will be created that is owned by the user
namespace of the container.

IOW, to delegate a superblock/filesystems to an unprivileged container
capabilities are still required but ultimately the filesystems will be
owned by the container.

One story I always found worth exploring to get at (1) is if we had
dm-verity directly integrated into the filesystem. And I don't mean
fsverity, I mean dm-verity and in a way such that it's explicitly not
part of the on-disk image in contrast to fsverity where each filesystem
integrates this very differently into their on-disk format. It basically
would be as dumb as it gets. Static, simple arithmetic, appended,
pre-pended, whatever.

> 
> > TL;DR the user namespace the superblock belongs to is usually determined
> > at fsopen() time.
> > 
> > > 
> > > Can two processes share the same fsopen fd?  If so then systemd-mountfsd
> > 
> > Yes, they can share and it's synchronized.
> 
> > > could pass the fsopen fd to the fuse server (whilst retaining its own
> > > copy).  The fuse server could do its own mount option parsing, call
> > 
> > Yes, systemd-mountfsd already does passing like that.
> 
> Oh!
> 
> > > FSCONFIG_SET_* on the fd, and then signal back to systemd-mountfsd to do
> > > the create/fsmount/move_mount part.
> > 
> > Yes.
> 
> If the fdopen fd tracks the userns of whoever initiated the mount
> attempt, then maybe the fuse server can do that part too?  I guess the
> weird part would be that the fuse server would effectively be passing a
> path from the caller's ns, despite not having access to that ns.

Remind me why the FUSE server would want to track the userns?

> 
> > > The systemd-mountfsd would have to be running in desired fs namespace
> > > and with sufficient privileges to open block devices, but I'm guessing
> > > that's already a requirement?
> > 
> > Yes, systemd-mountfsd is a system level service running in the initial
> > set of namespaces and interacting with systemd-nsresourced (namespace
> > related stuff). It can obviously also create helper to setns() into
> > various namespaces if required. 
> 
> <nod> I think I saw something else from you about a file descriptor
> store, so I'll go look there next.
> 
> --D
> 
> > > 
> > > > > If so, then it would be more convenient if mount.safe/systemd-mountfsd
> > > > > could pass open fds for /dev/fuse fsopen then the fuse server wouldn't
> > 
> > Yes, I would think so.
> > 
> > > > 
> > > > Yes, that would work.
> > > 
> > > Oh goody :)
> > > 
> > > > > need any special /dev access at all.  I think then the fuse server's
> > > > > service could have:
> > > > > 
> > > > > DynamicUser=true
> > > > > ProtectSystem=true
> > > > > ProtectHome=true
> > > > > PrivateTmp=true
> > > > > PrivateDevices=true
> > > > > DevicePolicy=strict
> > > > > 
> > > > > (I think most of those are redundant with DynamicUser=true but a lot of
> > > > > my systemd-fu is paged out ATM.)
> > > > > 
> > > > > My goal here is extreme containment -- the code doing the fs metadata
> > > > > parsing has no privileges, no write access except to the fds it was
> > > > > given, no network access, and no ability to read anything outside the
> > > > > root filesystem.  Then I can get back to writing buffer
> > > > > overflows^W^Whigh quality filesystem code in peace.
> > > > 
> > > > Yeah, sounds about right.
> > > > 
> > > > > 
> > > > > > > So we can try and allowlist /dev/fuse in vfs_mknod() similar to
> > > > > > > whiteouts. That means you can do mknod() in the container to create
> > > > > > > /dev/fuse (Personally, I would even restrict this to tmpfs right off the
> > > > > > > bat so that containers can only do this on their private tmpfs mount at
> > > > > > > /dev.)
> > > > > > >
> > > > > > > The downside of this would be to give unprivileged containers access to
> > > > > > > FUSE by default. I don't think that's a problem per se but it is a uapi
> > > > > > > change.
> > > > > 
> > > > > Yeah, that is a new risk.  It's still better than metadata parsing
> > > > > within the kernel address space ... though who knows how thoroughly fuse
> > > > > has been fuzzed by syzbot :P
> > > > > 
> > > > > > > Let me think a bit about alternatives. I have one crazy idea but I'm not
> > > > > > > sure enough about it to spill it.
> > > > > 
> > > > > Please do share, #f is my crazy unbaked idea. :)
> > > > > 
> > > > > > I don't think there is a hard requirement for the fuse fd to be opened from
> > > > > > a device driver.
> > > > > > With fuse io_uring communication, the open fd doesn't even need to do io.
> > > > > > 
> > > > > > > > protections because they tend to run in a private mount namespace with
> > > > > > > > various parts of the filesystem either hidden or readonly.
> > > > > > > >
> > > > > > > > In theory one could design a socket protocol to pass mount options,
> > > > > > > > block device paths, fds, and responsibility for the mount() call between
> > > > > > > > a mount helper and a service:
> > > > > > >
> > > > > > > This isn't a problem really. This should just be an extension to
> > > > > > > systemd-mountfsd.
> > > > > 
> > > > > I suppose mount.safe could very well call systemd-mount to go do all the
> > > > > systemd-related service setup, and that would take care of udisks as
> > > > > well.
> > > > 
> > > > The ultimate goal is to teach mount(8)/libmount to use that daemon when
> > > > it's available. Because that would just make unprivileged mounting work
> > > > without userspace noticing anything.
> > > 
> > > That sounds really neat. :)
> > > 
> > > --D

