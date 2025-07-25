Return-Path: <linux-fsdevel+bounces-56015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC06B11A81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401795A2625
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 09:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0612737E9;
	Fri, 25 Jul 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bZeRRmh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1440B272E74
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434347; cv=none; b=oeMy1032337Z4QEXD7SUNB91ajmuQ2j7vKaUj/RZoSrgzRPbFrje7k5kBvRBWygGsYyoQ/LcjYXU8BoIwITfYy+Aa8LFsNjfBUFsE7h5giBxQjgT9AegliK6FYZAmIzTDkOIZf4V2tX7FcqpSX7Q6rjnI6k2OOC2YVudMoqRw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434347; c=relaxed/simple;
	bh=y00en8JmQ27yaXVtN2IhI2YG/66JV5PNKjL9U7G0hqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRylvNwVSFw4P4M60dn03gVMatGke1FG8Prj+NyIxc/lnpgq2zH+Dk7GMhu1hd1XfIPAT8qLGiWTTAmQNomDTfCxjevfmEG7PRNwkMSV2d5cIoPHmK2z2c5JZaK27pbcAd0NwO0yh2njqfemVwSiwoOYNSNErmPvQ4pRVxD6axw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bZeRRmh9; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bpMR31Ym4zMng;
	Fri, 25 Jul 2025 11:05:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1753434335;
	bh=ORX+mJHzmxeGWx1Ko9kWXehnUMUizczoMJHonVLFDlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZeRRmh9PwG/38Co6iefxjAUr7ytpDOq60aPicglKclzILX9pNY4RAEQQxnci6VXr
	 d0qlZi5WWH2KlwOx1hwa5m6YrfyZ6ikNrmfvVFrxb6zPFzso1vcbm+Opcn3mHaE2TM
	 1D0AwxdYBM0nAWrSPWbeFO2eAkOQA2OTyb1N0x/c=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bpMR16hZ5zCCJ;
	Fri, 25 Jul 2025 11:05:33 +0200 (CEST)
Date: Fri, 25 Jul 2025 11:05:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Tingmao Wang <m@maowtm.org>, Jann Horn <jannh@google.com>, 
	John Johansen <john.johansen@canonical.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ben Scarlato <akhna@google.com>, Christian Brauner <brauner@kernel.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Jeff Xu <jeffxu@google.com>, NeilBrown <neil@brown.name>, 
	Paul Moore <paul@paul-moore.com>, Ryan Sullivan <rysulliv@redhat.com>, Song Liu <song@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/4] landlock: Fix handling of disconnected directories
Message-ID: <20250725.Aequee7deiMe@digikod.net>
References: <20250719104204.545188-1-mic@digikod.net>
 <20250719104204.545188-3-mic@digikod.net>
 <18425339-1f4b-4d98-8400-1decef26eda7@maowtm.org>
 <20250723.vouso1Kievao@digikod.net>
 <aIJH9CoEKWNq0HwN@google.com>
 <20250724.ECiGoor4ulub@digikod.net>
 <87tt307vtd.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tt307vtd.fsf@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Jul 24, 2025 at 09:54:22PM -0600, Abhinav Saxena wrote:
> Hi!
> 
> Mickaël Salaün <mic@digikod.net> writes:
> > On Thu, Jul 24, 2025 at 04:49:24PM +0200, Günther Noack wrote:
> >> On Wed, Jul 23, 2025 at 11:01:42PM +0200, Mickaël Salaün wrote:
> >> > On Tue, Jul 22, 2025 at 07:04:02PM +0100, Tingmao Wang wrote:
> >> > > On the other hand, I’m still a bit uncertain about the domain check
> >> > > semantics.  While it would not cause a rename to be allowed if it is
> >> > > otherwise not allowed by any rules on or above the mountpoint, this gets a
> >> > > bit weird if we have a situation where renames are allowed on the
> >> > > mountpoint or everywhere, but not read/writes, however read/writes are
> >> > > allowed directly on a file, but the dir containing that file gets
> >> > > disconnected so the sandboxed application can’t read or write to it.
> >> > > (Maybe someone would set up such a policy where renames are allowed,
> >> > > expecting Landlock to always prevent renames where additional permissions
> >> > > would be exposed?)
> >> > >
> >> > > In the above situation, if the file is then moved to a connected
> >> > > directory, it will become readable/writable again.
> >> >
> >> > We can generalize this issue to not only the end file but any component
> >> > of the path: disconnected directories.  In fact, the main issue is the
> >> > potential inconsistency of access checks over time (e.g. between two
> >> > renames).  This could be exploited to bypass the security checks done
> >> > for FS_REFER.
> >> >
> >> > I see two solutions:
> >> >
> >> > 1. *Always* walk down to the IS_ROOT directory, and then jump to the
> >> >    mount point.  This makes it possible to have consistent access checks
> >> >    for renames and open/use.  The first downside is that that would
> >> >    change the current behavior for bind mounts that could get more
> >> >    access rights (if the policy explicitly sets rights for the hidden
> >> >    directories).  The second downside is that we’ll do more walk.
> >> >
> >> > 2. Return -EACCES (or -ENOENT) for actions involving disconnected
> >> >    directories, or renames of disconnected opened files.  This second
> >> >    solution is simpler and safer but completely disables the use of
> >> >    disconnected directories and the rename of disconnected files for
> >> >    sandboxed processes.
> >> >
> >> > It would be much better to be able to handle opened directories as
> >> > (object) capabilities, but that is not currently possible because of the
> >> > way paths are handled by the VFS and LSM hooks.
> >> >
> >> > Tingmao, Günther, Jann, what do you think?
> >>
> >> I have to admit that so far, I still failed to wrap my head around the
> >> full patch set and its possible corner cases.  I hope I did not
> >> misunderstand things all too badly below:
> >>
> >> As far as I understand the proposed patch, we are “checkpointing” the
> >> intermediate results of the path walk at every mount point boundary,
> >> and in the case where we run into a disconnected directory in one of
> >> the nested mount points, we restore from the intermediate result at
> >> the previous mount point directory and skip to the next mount point.
> >
> > Correct
> >
> >>
> >> Visually speaking, if the layout is this (where “:” denotes a
> >> mountpoint boundary between the mountpoints MP1, MP2, MP3):
> >>
> >>                           dirfd
> >>                             |
> >>           :                 V         :
> >> 	  :       ham <— spam <— eggs <— x.txt
> >> 	  :    (disconn.)             :
> >>           :                           :
> >>   / <— foo <— bar <— baz        :
> >>           :                           :
> >>     MP1                 MP2                  MP3
> >>
> >> When a process holds a reference to the “spam” directory, which is now
> >> disconnected, and invokes openat(dirfd, “eggs/x.txt”, …), then we
> >> would:
> >>
> >>   * traverse x.txt
> >>   * traverse eggs (checkpointing the intermediate result) <-.
> >>   * traverse spam                                           |
> >>   * traverse ham                                            |
> >>   * discover that ham is disconnected:                      |
> >>      * restore the intermediate result from “eggs” ———’
> >>      * continue the walk at foo
> >>   * end up at the root
> >>
> >> So effectively, since the results from “spam” and “ham” are discarded,
> >> we would traverse only the inodes in the outer and inner mountpoints
> >> MP1 and MP3, but effectively return a result that looks like we did
> >> not traverse MP2?
> >
> > We’d still check MP2’s inode, but otherwise yes.
> >
> 
> I don’t know if it makes sense, but can access rights be cached as part
> of the inode security blob? Although I am not sure if the LSM blob would
> exist after unlinking.

We're not talking about unlinked files but renamed directories that are
opened in a bind mount.  There is no issue with unlinked files, only
when opening something new from an open directory.

With Landlock, because it is unprivileged and then has standalone
security policies, we would need to have one cache per sandbox, which
has its own set of issues.  That would be independant from the current
patch series anyway.

> 
> But if it does, maybe during unlink, keep the cached rights for MP2,
> and during openat():
> 1. Start at disconnected “spam” inode
> 2. Check spam->i_security->allowed_access  <- Cached MP2 rights
> 3. Continue normal path walk with preserved access context

As explained, we cannot do that with the current LSM and VFS
APIs

> 
> >>
> >> Maybe (likely) I misread the code. :) It’s not clear to me what the
> >> thinking behind this is.  Also, if there was another directory in
> >> between “spam” and “eggs” in MP2, wouldn’t we be missing the access
> >> rights attached to this directory?
> >
> > Yes, we would ignore this access right because we don’t know that the
> > path was resolved from spam.
> >
> >>
> >>
> >> Regarding the capability approach:
> >>
> >> I agree that a “capability” approach would be the better solution, but
> >> it seems infeasible with the existing LSM hooks at the moment.  I
> >> would be in favor of it though.
> >
> > Yes, it would be a new feature with potential important changes.
> >
> > In the meantime, we still need a fix for disconnected directories, and
> > this fix needs to be backported.  That’s why the capability approach is
> > not part of the two solutions. ;)
> >
> >>
> >> To spell it out a bit more explicitly what that would mean in my mind:
> >>
> >> When a path is looked up relative to a dirfd, the path walk upwards
> >> would terminate at the dirfd and use previously calculated access
> >> rights stored in the associated struct file.  These access rights
> >> would be determined at the time of opening the dirfd, similar to how we
> >> are already storing the “truncate” access right today for regular
> >> files.
> >>
> >> (Remark: There might still be corner cases where we have to solve it
> >> the hard way, if someone uses “..” together with a dirfd-relative
> >> lookup.)
> >
> > Yep, real capabilities don’t have “..” in their design.  On Linux (and
> > Landlock), we need to properly handle “..”, which is challenging.
> >
> >>
> >> I also looked at what it would take to change the LSM hooks to pass
> >> the directory that the lookup was done relative to, but it seems that
> >> this would have to be passed through a bunch of VFS callbacks as well,
> >> which seems like a larger change.  I would be curious whether that
> >> would be deemed an acceptable change.
> >>
> >> —Günther
> >>
> >>
> >> P.S. Related to relative directory lookups, there is some movement in
> >> the BSDs as well to use dirfds as capabilities, by adding a flag to
> >> open directories that enforces O_BENEATH on subsequent opens:
> >>
> >>  * <https://undeadly.org/cgi?action=article;sid=20250529080623>
> >>  * <https://reviews.freebsd.org/D50371>
> >>
> >> (both found via <https://news.ycombinator.com/item?id=44575361>)
> >>
> >> If a dirfd had such a flag, that would get rid of the corner case
> >> above.
> >
> > This would be nice but it would not solve the current issue because we
> > cannot force all processes to use this flag (which breaks some use
> > cases).
> >
> > FYI, Capsicum is a more complete implementation:
> > <https://man.freebsd.org/cgi/man.cgi?query=capsicum&sektion=4>
> > See the vfs.lookup_cap_dotdot sysctl too.
> 
> Also, my apologies, as this may be tangential to the current
> conversation, but since object-based capabilities were mentioned, I had
> some design ideas around it while working on the memfd feature [1]. I

Thanks for your patch series!  It is on my todo list but I'll need a bit
of time to review it.

> don’t know if the design for object-based capabilities has been
> internally formalized yet, but since we’re at this juncture, it would
> make me glad if any of this is helpful in any way :)
> 
> If I understand things correctly, the domain currently applies to ALL
> file operations via paths and persists until the process exits.

Yes (but it doesn't apply on already opened file descriptors).

> Therefore, with disconnected directories, once a path component is
> unlinked, security policies can be bypassed, as access checks on
> previously visible ancestors might get skipped.

There is no security bypass, because Landlock is a deny-by-default (when
handled) access control, and also because filesystem's parent
directories are evaluated (but not necessarily all the visible/mounted
filesystems).

Also, there is no issue with unlinked files.

> 
> Current Landlock Architecture:
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 
> Process -> Landlock Domain -> Access Decision
> 
> {Filesystem Rules, Network Rules, Scope Restrictions}
> 
> Path/Port Resolution + Domain Boundary Checks
> 
> 
> Enhanced Architecture with Object Capabilities:
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 
> Process -> Enhanced Landlock Domain ->   Access Decision
> ━━
>   
> ━━
> {Path Rules, Network Rules,  (AND)   {FD Capabilities}
>  Scope Restrictions}                      |
> ━━━━━━━━━━━━━━━
>  Per-FD Rights 
> ━━━━━━━━━━━━━━━
> Traditional Resolution             (calculated)
> 
> Unlike SCOPE which provides coarse-grained blocking, object capabilities
> provide with the facility to add domain specific fine-grained individual
> FD operations. So that we have:
> 
> Child Domain = Parent Domain & New Restrictions
>              = {
>     path_rules: Parent.path_rules & Child.path_rules,
>     net_rules: Parent.net_rules & Child.net_rules,
>     scope: Parent.scope | Child.scope,  /* Additive */
>     fd_caps: path_rules & net_rules & scope & Child.allowed_fd_operations
> }
> 
> where the Child domain *must* be more restrictive than the parent. Here
> is an example:
> 
> /* Example */
> Parent Domain = {
>     path_rules: [“/var/www” -> READ_FILE|READ_DIR, “/var/log” -> WRITE_FILE],
>     net_rules: [“80” -> BIND_TCP, “443” -> BIND_TCP],
>     scope: [SIGNAL, ABSTRACT_UNIX],
> 
>     /* Auto-derived FD capabilities */
>     fd_caps: {
>         3: READ_FILE,           /* /var/www/index.html */
>         7: READ_DIR,            /* /var/www directory */
>         12: WRITE_FILE,         /* /var/log/access.log */
>         15: BIND_TCP,           /* socket bound to port 80 */
>         20: READ_FILE|READ_DIR  /* /var/www/images/ */
>     }
> }
> 
> /* Child creates new domain with additional restrictions */
> Child.new_restrictions = {
>     path_rules: ["/var/www" -> READ_FILE only], /* Remove READ_DIR */
>     net_rules: [],                              /* Remove all network */
>     scope: [SIGNAL, ABSTRACT_UNIX, MEMFD_EXEC], /* Add MEMFD restriction */
> }
> 
> /* Child FD capabilities = Parent & Child restrictions */
> Child.fd_caps = {
>     3: READ_FILE,     /* READ_FILE & READ_FILE = READ_FILE */
>     7: 0,             /* READ_DIR & READ_FILE = none (no access) */
>     12: WRITE_FILE,   /* WRITE_FILE unchanged (not restricted) */
>     15: 0,            /* BIND_TCP & none = none (network blocked) */
>     20: READ_FILE     /* (READ_FILE|READ_DIR) & READ_FILE = READ_FILE */
> }
> 
> API Design: Reusing Existing Flags
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 
> /* Extended ruleset - reuse existing flags where possible */
> struct landlock_ruleset_attr {
>     __u64 handled_access_fs;      /* Existing: also applies to FDs */
>     __u64 handled_access_net;     /* Existing: also applies to FDs */
>     __u64 scoped;                 /* Existing: domain boundaries */
>     __u64 handled_access_fd;      /* NEW: FD-specific operations only */
> };
> 
> /* New syscalls */
> long landlock_set_fd_capability(int fd, __u64 access_rights, __u32 flags);

Such a syscall could be useful in some scenarios but in most cases
programs should not require to be modified.

> 
> /* Reuse existing filesystem/network flags for FD operations */
> landlock_set_fd_capability(file_fd, LANDLOCK_ACCESS_FS_READ_FILE, 0);
> landlock_set_fd_capability(dir_fd, LANDLOCK_ACCESS_FS_READ_DIR, 0);
> landlock_set_fd_capability(sock_fd, LANDLOCK_ACCESS_NET_BIND_TCP, 0);
> 
> `============'
> 
> With object capabilities, we assign access rights to file descriptors
> directly, at open/alloc time, eliminating the need for path resolution
> during future use.

Except when ".." is used to resolve a path relative to such
capability/FD, and we need to support that for compatibility reasons.

> 
> This solves the core issue because:
> • FDs remain valid even when disconnected, and
> • Rights are bound to the object rather than its pathname.
> 
> Therefore, openat with dirfd should still work.
> 
> int dirfd = open(“/tmp/work", O_RDONLY);        // Connected
> unlink(”/tmp/work");                            // Now disconnected

It's not possible to unlink a directory nor rmdir a non-empty one.

> openat(dirfd, “file.txt”, O_RDONLY);            // Still works, FD bound
> 
> Moreover, no path resolution is needed at a later stage and sandboxed
> processes don’t bypass restrictions.
> 
> Would love to hear any feedback and thoughts on this.

I think we all agree that capabilities would be nice, but the VFS and
LSM's APIs would need to be updated, and that would need to update user
space code, while breaking some use cases.

> 
> Best,
> Abhinav
> 
> [1] - <https://lore.kernel.org/all/20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com/>


