Return-Path: <linux-fsdevel+bounces-9679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F884462B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD8CB33B0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF112C55F;
	Wed, 31 Jan 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xkmBRb90"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790B2E851
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721029; cv=none; b=CTK+zTOJkDz68zieisqyU0kKOP03NDrb2XuS8uQ9kMh4pBc6U/Db9NtNziwtbJII/5yUGjsJwevyLcpTrbzCBAPM2G8TjnYAv7BFmeImCRuNSWBASAMjG1Q9g171dXwqLMkTwz4eN/z3zhtSCEhZtL5/JkE10JE06k1kzxwGe1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721029; c=relaxed/simple;
	bh=cAy3A/nsuuQmXt1F/QnEsLCzrcAleYAuTwhVe0jYTuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr2YC3sOE7OkGPQ+fs3KrjXHOlK96UgOPrQD/PYtGtnmDMoAbRQVoKjr+3VpsYZMAxrlcknO26FEIFopypY4RpjLaBrY2O1PDOJY8JvSdlX6WQf8ONNa7SstXlqJ5X543AeqTue201Gi9XarpP/g3JrNSFlTR9ozkbe7lx6OM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xkmBRb90; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TQ7Pt6YVKzMq4cK;
	Wed, 31 Jan 2024 17:52:50 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TQ7Pt1rbHzNB5;
	Wed, 31 Jan 2024 17:52:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1706719970;
	bh=cAy3A/nsuuQmXt1F/QnEsLCzrcAleYAuTwhVe0jYTuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xkmBRb90keH2gNRfB2o09PxLk6r/tMEAt3ern2tjLF+l0dZqeBgZpdxLTk/qQCkzk
	 abSekSnoGMq737oElJhD3QTl7BdyKTP8vPe+mUucWYEDGp09wq6fRwp0iorlHnmWAm
	 Mzbd97t0e5WwGlvQBghVQyZQI5B49iX3uxkh8N94=
Date: Wed, 31 Jan 2024 17:52:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: Re: [PATCH v8 4/9] landlock: Add IOCTL access right
Message-ID: <20240131.IsheajooXee5@digikod.net>
References: <20231208155121.1943775-1-gnoack@google.com>
 <20231208155121.1943775-5-gnoack@google.com>
 <20231214.feeZ6Hahwaem@digikod.net>
 <20231214.Iev8oopu8iel@digikod.net>
 <20231214.aeC5Wax8phe1@digikod.net>
 <Zbk8RZCQ4M2i7BQn@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbk8RZCQ4M2i7BQn@google.com>
X-Infomaniak-Routing: alpha

On Tue, Jan 30, 2024 at 07:13:25PM +0100, Günther Noack wrote:
> Hello!
> 
> On Thu, Dec 14, 2023 at 03:28:10PM +0100, Mickaël Salaün wrote:
> > Christian, what do you think about the following IOCTL groups?
> > 
> > On Thu, Dec 14, 2023 at 11:14:10AM +0100, Mickaël Salaün wrote:
> > > On Thu, Dec 14, 2023 at 10:26:49AM +0100, Mickaël Salaün wrote:
> > > > On Fri, Dec 08, 2023 at 04:51:16PM +0100, Günther Noack wrote:

> > > > > +	switch (cmd) {
> > > > > +	case FIOCLEX:
> > > > > +	case FIONCLEX:
> > > > > +	case FIONBIO:
> > > > > +	case FIOASYNC:
> > > > > +		/*
> > > > > +		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> > > > > +		 * close-on-exec and the file's buffered-IO and async flags.
> > > > > +		 * These operations are also available through fcntl(2),
> > > > > +		 * and are unconditionally permitted in Landlock.
> > > > > +		 */
> > > > > +		return 0;
> > 
> > Could you please add comments for the following IOCTL commands
> > explaining why they make sense for the related file/dir read/write
> > mapping? We discussed about that in the ML but it would be much easier
> > to put that doc here for future changes, and for reviewers to understand
> > the rationale. Some of this doc is already in the cover letter.
> 
> Done, I'm adding documentation inline here.
> 
> > 
> > To make this easier to follow, what about renaming the IOCTL groups to
> > something like this:
> > * LANDLOCK_ACCESS_FS_IOCTL_GROUP1:
> >   LANDLOCK_ACCESS_FS_IOCTL_GET_SIZE

Well, this looks better:
LANDLOCK_ACCESS_FS_IOCTL_RW

We could think that it includes LANDLOCK_ACCESS_FS_MAKE_* though (which
is not the case), but it looks like the least worst...  These synthetic
access rights are not public anyway.

> > * LANDLOCK_ACCESS_FS_IOCTL_GROUP2:
> >   LANDLOCK_ACCESS_FS_IOCTL_GET_INNER

LANDLOCK_ACCESS_FS_IOCTL_RW_FILE

> > * LANDLOCK_ACCESS_FS_IOCTL_GROUP3:
> >   LANDLOCK_ACCESS_FS_IOCTL_READ_FILE

LANDLOCK_ACCESS_FS_IOCTL_R_FILE

> > * LANDLOCK_ACCESS_FS_IOCTL_GROUP4:
> >   LANDLOCK_ACCESS_FS_IOCTL_WRITE_FILE

LANDLOCK_ACCESS_FS_IOCTL_W_FILE

> 
> Agreed that better names are in order here.
> I renamed them as you suggested.
> 
> In principle, it would have been nice to name them after the access rights which
> enable them, but LANDLOCK_ACCESS_FS_IOCTL_READ_DIR_OR_READ_FILE_OR_WRITE_FILE is
> a bit too long for my taste. o_O
> 
> 
> > > > > +	case FIOQSIZE:
> > > > > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP1;
> > > > > +	case FS_IOC_FIEMAP:
> > > > > +	case FIBMAP:
> > > > > +	case FIGETBSZ:
> > 
> > Does it make sense to not include FIGETBSZ in
> > LANDLOCK_ACCESS_FS_IOCTL_GROUP1? I think it's OK like this as previously

I guess I meant "Does it make sense *to include* FIGETBSZ in
LANDLOCK_ACCESS_FS_IOCTL_GROUP1?" Which means to allow it for the
write_file, read_file and read_dir access rights:
LANDLOCK_ACCESS_FS_IOCTL_RW.

> > explained but I'd like to get confirmation:
> > https://lore.kernel.org/r/20230904.aiWae8eineo4@digikod.net
> 
> It seems that the more standardized way to get file system block sizes is to use
> POSIX' statvfs(3) interface, whose functionality is provided through the
> statfs(2) syscall.  These functions have the usual path-based and fd-based
> variants.  Landlock does not currently restrict statfs(2) at all, but there is
> an existing LSM security hook for it.
> 
> We should probably introduce an access right to restrict statfs(2) in the
> future, because this otherwise lets callers probe for the existence of files.  I
> filed https://github.com/landlock-lsm/linux/issues/18 for it.

According to the struct statfs fields, most of them seems to be useful
for file writes (e.g. f_bsize) and file creations (e.g. f_ffree) but
potentially for file read too (e.g. f_bsize). I'm not sure how statfs is
used in practice though.

> 
> I am not sure how to group this best.  It seems like a very harmless thing to
> allow.  (What is to be learned from the filesystem blocksize anyway?)  If we are
> unsure about it, we could do the following though:

I agree that it seems to be harmless.

When we'll be able to control statfs(2), following the same logic,
LANDLOCK_ACCESS_FS_IOCTL_RW should allows to use it.  To said it another
way, implementing the statfs LSM hook doesn't seem to be useful once we
get the ability to restrict path walks:
https://github.com/landlock-lsm/linux/issues/9
Until then, there are other ways to probe for file existence anyway.

> 
>  - disallow FIGETBSZ unless LANDLOCK_ACCESS_FS_IOCTL ("misc") is granted
>  - allow FIGETBSZ together with a future access right which controls statfs(2)
> 
> In that case, the use of FIGETBSZ would be nicely separable from regular read
> access for files, and it would be associated with the same right.

If this FIGETBSZ is legitimately used by applications to optimize their
FS interactions, then we should not mask it under FS_IOCTL because this
would result of applications allowing FS_IOCTL everywhere, which is not
what we want.

> 
> (We could also potentially group FS_IOC_FIEMAP and FIBMAP in the same way.
> These ones give information about file extents and a file's block numbers.  (You
> can check whether your file is stored in a continuous area on disk.))
> 
> This would simplify the story somewhat for the IOCTLs that we need to
> immediately give access to.
> 
> What do you think?

It would help to trace a lot of generic applications and see which IOCTL
command are used in practice, we might discover new ones.

> 
> 
> > > > > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP2;
> > > > > +	case FIONREAD:
> > > > > +	case FIDEDUPERANGE:
> > > > > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP3;
> > > > > +	case FICLONE:
> > > > > +	case FICLONERANGE:
> > 
> > The FICLONE* commands seems to already check read/write permissions with
> > generic_file_rw_checks(). Always allowing them should then be OK (and
> > the current tests should still pass), but we can still keep them here to
> > make the required access right explicit and test with and without
> > Landlock restrictions to make sure this is consistent with the VFS
> > access checks. See
> > https://lore.kernel.org/r/20230904.aiWae8eineo4@digikod.net
> > If this is correct, a new test should check that Landlock restrictions
> > are the same as the VFS checks and then don't impact such IOCTLs.
> 
> Noted.  I'll look into it.
> 
> (My understanding of FICLONE, FIDEDUPRANGE and FICLONERANGE is that they let
> files share the same underlying storage, on a per-range basis ("reflink").  The
> IOCTL man pages for these do not explain that as explicitly, but the key point
> is that the two resulting files still behave like a regular copy, because this
> feature exists on COW file systems only.  So that reinforces the approach of
> using READ_FILE and WRITE_FILE access rights for these IOCTL commands (because
> it behaves just as if we had called read() on one file and written the results
> to the other file with write()).)
> 
> 
> > > > > +	case FS_IOC_RESVSP:
> > > > > +	case FS_IOC_RESVSP64:
> > > > > +	case FS_IOC_UNRESVSP:
> > > > > +	case FS_IOC_UNRESVSP64:
> > > > > +	case FS_IOC_ZERO_RANGE:
> > > > > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP4;
> > > > > +	default:
> > > > > +		/*
> > > > > +		 * Other commands are guarded by the catch-all access right.
> > > > > +		 */
> > > > > +		return LANDLOCK_ACCESS_FS_IOCTL;
> > > > > +	}
> > > > > +}
> 
> > We previously talked about allowing all IOCTLs on unix sockets and named
> > pipes: https://lore.kernel.org/r/ZP7lxmXklksadvz+@google.com
> 
> Thanks for the reminder, I missed that.  Putting it on the TODO list.
> 
> 
> > I think the remaining issue with this grouping is that if the VFS
> > implementation returns -ENOIOCTLCMD, then the IOCTL command can be
> > forwarded to the device driver (for character or block devices).
> > For instance, FIONREAD on a character device could translate to unknown
> > action (on this device), which should then be considered dangerous and
> > denied unless explicitly allowed with LANDLOCK_ACCESS_FS_IOCTL (but not
> > any IOCTL_GROUP*).
> >
> > For instance, FIONREAD on /dev/null should return -ENOTTY, which should
> > then also be the case if LANDLOCK_ACCESS_FS_IOCTL is allowed (even if
> > LANDLOCK_ACCESS_FS_READ_FILE is denied). This is also the case for
> > file_ioctl()'s commands.
> > 
> > One solution to implement this logic would be to add an additional check
> > in hook_file_ioctl() for specific file types (!S_ISREG or socket or pipe
> > exceptions) and IOCTL commands.
> 
> In my view this seems OK, because we are primarily protecting access to
> resources (files), and only secondarily reducing the exposed kernel attack
> surface.

Correct, but of course block and character devices need to be handled.
seccomp-bpf is the main tool to protect the kernel in this case.

> 
> I agree there is a certain risk associated with calling ioctl(fd, FIONREAD, ...)
> on a buggy device driver.  But then again, that risk is comparable to the risk
> of calling read(fd, &buf, buflen) on the same buggy device driver.  So the
> LANDLOCK_ACCESS_FS_READ_FILE right grants access to both.  Users who are
> concerned about the security of specific device drivers can enforce a policy
> where only the necessary device files can be opened.

I'm thinking about the case where the FIONREAD value is used by a device
with a completely different semantic. This should be a bad practice but
this could happen, right Christian?

> 
> Does that make sense?
> 
> (Otherwise, if it makes you feel better, we can also change it so that these
> IOCTL commands require LANDLOCK_ACCESS_FS_IOCTL if they are used on non-S_ISREG
> files.  But it would complicate the IOCTL logic a bit, which we are exposing to
> users.)

I think I'd prefer this approach. I'm not sure how special files (but
still S_ISREG) are handled though, nor if this could be an issue.

> 
> 
> > Christian, is it correct to say that device drivers are not "required"
> > to follow the same semantic as the VFS's IOCTLs and that (for whatever
> > reason) collisions may occur? I guess this is not the case for
> > filesystems, which should implement similar semantic for the same
> > IOCTLs.
> 
> Christian, friendly ping! :)  Do you have opinions on this?
> 
> If the Landlock LSM makes decisions based on the IOCTL command numbers, do we
> have to assume that underlying device drivers might expose different
> functionality under the same IOCTL command numbers?
> 
> Thanks,
> —Günther
> 

