Return-Path: <linux-fsdevel+bounces-2991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B197EE8EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5054DB20B32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB2495DE;
	Thu, 16 Nov 2023 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="sMXVK0vC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [IPv6:2001:1600:3:17::190f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC2AEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 13:49:37 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SWYbJ2H2BzMqSyh;
	Thu, 16 Nov 2023 21:49:32 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SWYbH2nxPzMpnPl;
	Thu, 16 Nov 2023 22:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1700171372;
	bh=i2xecIaXPG8Bpk3/6L195RW2xiLR+TEf52D94v2JTas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMXVK0vCaXldie0BiddYT0x43rNMxO1rIXmo+y0jFYNKX4jyPS4/oLWEgEzKl9VEf
	 sjk9O0HoLbpIgrULtOKC1ayvL3pEqhJUXOfRD9g5EQbYT2GNDF9BY2zQiLxq3Rn7nc
	 A5HZtZqIWPrKe/8Y/SqvSJqIU7LIwV3feJlAL1Ps=
Date: Thu, 16 Nov 2023 16:49:09 -0500
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Landlock: IOCTL support
Message-ID: <20231116.haW5ca7aiyee@digikod.net>
References: <20231103155717.78042-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103155717.78042-1-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 03, 2023 at 04:57:10PM +0100, Günther Noack wrote:
> Hello!
> 
> These patches add simple ioctl(2) support to Landlock.
> 
> Objective
> ~~~~~~~~~
> 
> Make ioctl(2) requests restrictable with Landlock,
> in a way that is useful for real-world applications.
> 
> Proposed approach
> ~~~~~~~~~~~~~~~~~
> 
> Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
> of ioctl(2) on file descriptors.
> 
> We attach IOCTL access rights to opened file descriptors, as we
> already do for LANDLOCK_ACCESS_FS_TRUNCATE.
> 
> If LANDLOCK_ACCESS_FS_IOCTL is handled (restricted in the ruleset),
> the LANDLOCK_ACCESS_FS_IOCTL access right governs the use of all IOCTL
> commands.
> 
> We make an exception for the common and known-harmless IOCTL commands
> FIOCLEX, FIONCLEX, FIONBIO and FIONREAD.  These IOCTL commands are
> always permitted.  Their functionality is already available through
> fcntl(2).
> 
> If additionally(!), the access rights LANDLOCK_ACCESS_FS_READ_FILE,
> LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_DIR are
> handled, these access rights also unlock some IOCTL commands which are
> considered safe for use with files opened in these ways.
> 
> As soon as these access rights are handled, the affected IOCTL
> commands can not be permitted through LANDLOCK_ACCESS_FS_IOCTL any
> more, but only be permitted through the respective more specific
> access rights.  A full list of these access rights is listed below in
> this cover letter and in the documentation.
> 
> I believe that this approach works for the majority of use cases, and
> offers a good trade-off between Landlock API and implementation
> complexity and flexibility when the feature is used.
> 
> Current limitations
> ~~~~~~~~~~~~~~~~~~~
> 
> With this patch set, ioctl(2) requests can *not* be filtered based on
> file type, device number (dev_t) or on the ioctl(2) request number.
> 
> On the initial RFC patch set [1], we have reached consensus to start
> with this simpler coarse-grained approach, and build additional IOCTL
> restriction capabilities on top in subsequent steps.
> 
> [1] https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net/
> 
> Notable implications of this approach
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> * Existing inherited file descriptors stay unaffected
>   when a program enables Landlock.
> 
>   This means in particular that in common scenarios,
>   the terminal's IOCTLs (ioctl_tty(2)) continue to work.
> 
> * ioctl(2) continues to be available for file descriptors acquired
>   through means other than open(2).  Example: Network sockets,
>   memfd_create(2), file descriptors that are already open before the
>   Landlock ruleset is enabled.
> 
> Examples
> ~~~~~~~~
> 
> Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:
> 
>   LL_FS_RO=/ LL_FS_RW=. ./sandboxer /bin/bash
> 
> The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write" rights
> here, so we expect that newly opened files outside of $HOME don't work
> with most IOCTL commands.
> 
>   * "stty" works: It probes terminal properties
> 
>   * "stty </dev/tty" fails: /dev/tty can be reopened, but the IOCTL is
>     denied.
> 
>   * "eject" fails: ioctls to use CD-ROM drive are denied.
> 
>   * "ls /dev" works: It uses ioctl to get the terminal size for
>     columnar layout
> 
>   * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
>     attempts to reopen /dev/tty.)
> 
> IOCTL groups
> ~~~~~~~~~~~~
> 
> To decide which IOCTL commands should be blanket-permitted we went
> through the list of IOCTL commands mentioned in fs/ioctl.c and looked
> at them individually to understand what they are about.  The following
> list is for reference.
> 
> We should always allow the following IOCTL commands, which are also
> available through fcntl(2) with the F_SETFD and F_SETFL commands:
> 
>  * FIOCLEX, FIONCLEX - these work on the file descriptor and
>    manipulate the close-on-exec flag
>  * FIONBIO, FIOASYNC - these work on the struct file and enable
>    nonblocking-IO and async flags
> 
> The following command is guarded and enabled by either of
> LANDLOCK_ACCESS_FS_WRITE_FILE, LANDLOCK_ACCESS_FS_READ_FILE or
> LANDLOCK_ACCESS_FS_READ_DIR (G2), once one of them is handled
> (otherwise by LANDLOCK_ACCESS_FS_IOCTL):
> 
>  * FIOQSIZE - get the size of the opened file
> 
> The following commands are guarded and enabled by either of
> LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_FILE (G2),
> once one of them is handled (otherwise by LANDLOCK_ACCESS_FS_IOCTL):
> 
> These are commands that read file system internals:
> 
>  * FS_IOC_FIEMAP - get information about file extent mapping
>    (c.f. https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt)
>  * FIBMAP - get a file's file system block number
>  * FIGETBSZ - get file system blocksize
> 
> The following commands are guarded and enabled by
> LANDLOCK_ACCESS_FS_READ_FILE (G3), if it is handled (otherwise by
> LANDLOCK_ACCESS_FS_IOCTL):
> 
>  * FIONREAD - get the number of bytes available for reading (the
>    implementation is defined per file type)
>  * FIDEDUPRANGE - manipulating shared physical storage between files.
> 
> The following commands are guarded and enabled by
> LANDLOCK_ACCESS_FS_WRITE_FILE (G4), if it is handled (otherwise by
> LANDLOCK_ACCESS_FS_IOCTL):
> 
>  * FICLONE, FICLONERANGE - making files share physical storage between
>    multiple files.  These only work on some file systems, by design.
>  * FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64,
>    FS_IOC_ZERO_RANGE: Backwards compatibility with legacy XFS
>    preallocation syscalls which predate fallocate(2).
> 
> The following commands are also mentioned in fs/ioctl.c, but are not
> handled specially and are managed by LANDLOCK_ACCESS_FS_IOCTL together
> with all other remaining IOCTL commands:
> 
>  * FIFREEZE, FITHAW - work on superblock(!) to freeze/thaw the file
>    system. Requires CAP_SYS_ADMIN.
>  * Accessing file attributes:
>    * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS - manipulate inode flags (ioctl_iflags(2))
>    * FS_IOC_FSGETXATTR, FS_IOC_FSSETXATTR - more attributes

This looks great!

It would be nice to copy these IOCTL descriptions to the user
documentation too. That would help explain the rationale and let users
know that they should not be worried about the related IOCTLs.

> 
> Open questions
> ~~~~~~~~~~~~~~
> 
> This is unlikely to be the last iteration, but we are getting closer.
> 
> Some notable open questions are:
> 
>  * Code style
>  
>    * Should we move the IOCTL access right expansion logic into the
>      outer layers in syscall.c?  Where it currently lives in
>      ruleset.h, this logic feels too FS-specific, and it introduces
>      the additional complication that we now have to track which
>      access_mask_t-s are already expanded and which are not.  It might
>      be simpler to do the expansion earlier.

What about creating a new helper in fs.c that expands the FS access
rights, something like this:

int landlock_expand_fs_access(access_mask_t *access_mask)
{
	if (!*access_mask)
		return -ENOMSG;

	*access_mask = expand_all_ioctl(*access_mask, *access_mask);
	return 0;
}


And in syscalls.c:

	err =
		landlock_expand_fs_access(&ruleset_attr.handled_access_fs);
	if (err)
		return err;

	/* Checks arguments and transforms to kernel struct. */
	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
					  ruleset_attr.handled_access_net);


And patch the landlock_create_ruleset() helper with that:

-	if (!fs_access_mask && !net_access_mask)
+	if (WARN_ON_ONCE(!fs_access_mask) && !net_access_mask)
		return ERR_PTR(-ENOMSG);

> 
>    * Rename IOCTL_CMD_G1, ..., IOCTL_CMD_G4 and give them better names.

Why not something like LANDLOCK_ACCESS_FS_IOCTL_GROUP* to highlight that
these are in fact (synthetic) access rights?

I'm not sure we can find better than GROUP because even the content of
these groups might change in the future with new access rights.

> 
>  * When LANDLOCK_ACCESS_FS_IOCTL is granted on a file hierarchy,
>    should this grant the permission to use *any* IOCTL?  (Right now,
>    it is any IOCTL except for the ones covered by the IOCTL groups,
>    and it's a bit weird that the scope of LANDLOCK_ACCESS_FS_IOCTL
>    becomes smaller when other access rights are also handled.

Are you suggesting to handle differently this right if it is applied to
a directory?

If the scope of LANDLOCK_ACCESS_FS_IOCTL is well documented, that should
be OK. But maybe we should rename this right to something like
LANDLOCK_ACCESS_FS_IOCTL_DEFAULT to make it more obvious that it handles
IOCTLs that are not handled by other access rights?


> 
>  * Backwards compatibility for user-space libraries.
> 
>    This is not documented yet, because it is currently not necessary
>    yet.  But as soon as we have a hypothetical Landlock ABI v6 with a
>    new IOCTL-enabled "GFX" access right, the "best effort" downgrade
>    from v6 to v5 becomes more involved: If the caller handles
>    GFX+IOCTL and permits GFX on a file, the correct downgrade to make
>    this work on a Landlock v5 kernel is to handle IOCTL only, and
>    permit IOCTL(!).

I don't see any issue to this approach. If there is no way to handle GFX
in v5, then there is nothing more we can do than allowing GFX (on the
same file). Another way to say it is that in v5 we allow any IOCTL
(including GFX ones) on the GFX files, an in v6 we *need* replace this
IOCTL right with the newly available GFX right, *if it is handled* by
the ruleset.

If GFX would not be tied to a file, I think it would not be a good
design for this access right. Currently all access rights are tied to
objects/data, or relative to the sandbox (e.g. ptrace).

