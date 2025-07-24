Return-Path: <linux-fsdevel+bounces-55960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8DFB1103A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E799E16D2A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654B12EAD1D;
	Thu, 24 Jul 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nqgmgnfq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016D285045;
	Thu, 24 Jul 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377030; cv=none; b=tuYd0Xj3mfT1TpynA5FsVKHp6jb00TnncQv9WyC183EjiQP1ob1tjGuGWf5lsEwdomRFDsFYKn4tHT5vlG7DMt4IZyuwYo5udEKcw0uy99WvTtoefS6R4896Rc4TtZ6NhZNSoqYWBR7gjLHm93yhLn5K0OlNyj8NtlStcLIdgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377030; c=relaxed/simple;
	bh=HuQ1X40d3HdWi4r5uTvkEVmKf3SZuSUnjDmbIj5gKO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHAz04Ac9gpJp6MtTFHuHPFMdaQeDtY4KanT4Z28POCrLC1GfJi/EfNoIf5dXu5AHQr53Zn3ZxejPy+6YKHLeoPkUAIML6QVNcB98N2EkJe2+yhVpFzPmlamakw4XsYEUlVRN6Hjh438n2/maqq6eUECFuzvI+/HvBbivyuajlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nqgmgnfq; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bnyDm4LlVzTFy;
	Thu, 24 Jul 2025 19:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1753377016;
	bh=uyXcrCnqFFQKLSZxrC3lv0uiQIEd9ws4tiolv28Gjx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqgmgnfq1MmwfzuPL2YSvUn0mkapUWws0VhNoaFyfluTSr/ZV/xVfjEsnYpMylaSy
	 edwJE0gzzwdQJwnUkfEBNYdfUR8M5lh2SX2EDR4ED52ZiKlLLk3OqL9YqGVBOu8y4z
	 1H/vl29iN9Na67qjBwKRo0c1LyEJMpAkzC43IlZo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bnyDk5wv9zt7M;
	Thu, 24 Jul 2025 19:10:14 +0200 (CEST)
Date: Thu, 24 Jul 2025 19:10:11 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>, Jann Horn <jannh@google.com>, 
	John Johansen <john.johansen@canonical.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ben Scarlato <akhna@google.com>, Christian Brauner <brauner@kernel.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Jeff Xu <jeffxu@google.com>, NeilBrown <neil@brown.name>, 
	Paul Moore <paul@paul-moore.com>, Ryan Sullivan <rysulliv@redhat.com>, Song Liu <song@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/4] landlock: Fix handling of disconnected directories
Message-ID: <20250724.ECiGoor4ulub@digikod.net>
References: <20250719104204.545188-1-mic@digikod.net>
 <20250719104204.545188-3-mic@digikod.net>
 <18425339-1f4b-4d98-8400-1decef26eda7@maowtm.org>
 <20250723.vouso1Kievao@digikod.net>
 <aIJH9CoEKWNq0HwN@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIJH9CoEKWNq0HwN@google.com>
X-Infomaniak-Routing: alpha

On Thu, Jul 24, 2025 at 04:49:24PM +0200, Günther Noack wrote:
> On Wed, Jul 23, 2025 at 11:01:42PM +0200, Mickaël Salaün wrote:
> > On Tue, Jul 22, 2025 at 07:04:02PM +0100, Tingmao Wang wrote:
> > > On the other hand, I'm still a bit uncertain about the domain check
> > > semantics.  While it would not cause a rename to be allowed if it is
> > > otherwise not allowed by any rules on or above the mountpoint, this gets a
> > > bit weird if we have a situation where renames are allowed on the
> > > mountpoint or everywhere, but not read/writes, however read/writes are
> > > allowed directly on a file, but the dir containing that file gets
> > > disconnected so the sandboxed application can't read or write to it.
> > > (Maybe someone would set up such a policy where renames are allowed,
> > > expecting Landlock to always prevent renames where additional permissions
> > > would be exposed?)
> > > 
> > > In the above situation, if the file is then moved to a connected
> > > directory, it will become readable/writable again.
> > 
> > We can generalize this issue to not only the end file but any component
> > of the path: disconnected directories.  In fact, the main issue is the
> > potential inconsistency of access checks over time (e.g. between two
> > renames).  This could be exploited to bypass the security checks done
> > for FS_REFER.
> > 
> > I see two solutions:
> > 
> > 1. *Always* walk down to the IS_ROOT directory, and then jump to the
> >    mount point.  This makes it possible to have consistent access checks
> >    for renames and open/use.  The first downside is that that would
> >    change the current behavior for bind mounts that could get more
> >    access rights (if the policy explicitly sets rights for the hidden
> >    directories).  The second downside is that we'll do more walk.
> > 
> > 2. Return -EACCES (or -ENOENT) for actions involving disconnected
> >    directories, or renames of disconnected opened files.  This second
> >    solution is simpler and safer but completely disables the use of
> >    disconnected directories and the rename of disconnected files for
> >    sandboxed processes.
> > 
> > It would be much better to be able to handle opened directories as
> > (object) capabilities, but that is not currently possible because of the
> > way paths are handled by the VFS and LSM hooks.
> > 
> > Tingmao, Günther, Jann, what do you think?
> 
> I have to admit that so far, I still failed to wrap my head around the
> full patch set and its possible corner cases.  I hope I did not
> misunderstand things all too badly below:
> 
> As far as I understand the proposed patch, we are "checkpointing" the
> intermediate results of the path walk at every mount point boundary,
> and in the case where we run into a disconnected directory in one of
> the nested mount points, we restore from the intermediate result at
> the previous mount point directory and skip to the next mount point.

Correct

> 
> Visually speaking, if the layout is this (where ":" denotes a
> mountpoint boundary between the mountpoints MP1, MP2, MP3):
> 
>                           dirfd
>                             |
>           :                 V         :
> 	  :       ham <--- spam <--- eggs <--- x.txt
> 	  :    (disconn.)             :
>           :                           :
>   / <--- foo <--- bar <--- baz        :
>           :                           :
>     MP1                 MP2                  MP3
> 
> When a process holds a reference to the "spam" directory, which is now
> disconnected, and invokes openat(dirfd, "eggs/x.txt", ...), then we
> would:
> 
>   * traverse x.txt
>   * traverse eggs (checkpointing the intermediate result) <-.
>   * traverse spam                                           |
>   * traverse ham                                            |
>   * discover that ham is disconnected:                      |
>      * restore the intermediate result from "eggs" ---------'
>      * continue the walk at foo
>   * end up at the root
> 
> So effectively, since the results from "spam" and "ham" are discarded,
> we would traverse only the inodes in the outer and inner mountpoints
> MP1 and MP3, but effectively return a result that looks like we did
> not traverse MP2?

We'd still check MP2's inode, but otherwise yes.

> 
> Maybe (likely) I misread the code. :) It's not clear to me what the
> thinking behind this is.  Also, if there was another directory in
> between "spam" and "eggs" in MP2, wouldn't we be missing the access
> rights attached to this directory?

Yes, we would ignore this access right because we don't know that the
path was resolved from spam.

> 
> 
> Regarding the capability approach:
> 
> I agree that a "capability" approach would be the better solution, but
> it seems infeasible with the existing LSM hooks at the moment.  I
> would be in favor of it though.

Yes, it would be a new feature with potential important changes.

In the meantime, we still need a fix for disconnected directories, and
this fix needs to be backported.  That's why the capability approach is
not part of the two solutions. ;)

> 
> To spell it out a bit more explicitly what that would mean in my mind:
> 
> When a path is looked up relative to a dirfd, the path walk upwards
> would terminate at the dirfd and use previously calculated access
> rights stored in the associated struct file.  These access rights
> would be determined at the time of opening the dirfd, similar to how we
> are already storing the "truncate" access right today for regular
> files.
> 
> (Remark: There might still be corner cases where we have to solve it
> the hard way, if someone uses ".." together with a dirfd-relative
> lookup.)

Yep, real capabilities don't have ".." in their design.  On Linux (and
Landlock), we need to properly handle "..", which is challenging.

> 
> I also looked at what it would take to change the LSM hooks to pass
> the directory that the lookup was done relative to, but it seems that
> this would have to be passed through a bunch of VFS callbacks as well,
> which seems like a larger change.  I would be curious whether that
> would be deemed an acceptable change.
> 
> —Günther
> 
> 
> P.S. Related to relative directory lookups, there is some movement in
> the BSDs as well to use dirfds as capabilities, by adding a flag to
> open directories that enforces O_BENEATH on subsequent opens:
> 
>  * https://undeadly.org/cgi?action=article;sid=20250529080623
>  * https://reviews.freebsd.org/D50371
> 
> (both found via https://news.ycombinator.com/item?id=44575361)
> 
> If a dirfd had such a flag, that would get rid of the corner case
> above.

This would be nice but it would not solve the current issue because we
cannot force all processes to use this flag (which breaks some use
cases).

FYI, Capsicum is a more complete implementation:
https://man.freebsd.org/cgi/man.cgi?query=capsicum&sektion=4
See the vfs.lookup_cap_dotdot sysctl too.

