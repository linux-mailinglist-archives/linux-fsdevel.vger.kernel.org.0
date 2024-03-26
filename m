Return-Path: <linux-fsdevel+bounces-15347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951188C520
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF801C62234
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE512DD87;
	Tue, 26 Mar 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0qdbMucO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B912D778
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463297; cv=none; b=nSl5oz81sF2eGq2irVv9ea6QmTmqqWcKDnLebm2aAIrfv2EsyvoQrIB59upTQn/6uo2g4gszfsnuTswAx1ZvjTpi+p5XuUTNVOCis80NWURASjDznxjGvXfcItDacIRGA9IQ2iimAJXTZMy9lLss5zT841ARlsHtfONre+Sker0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463297; c=relaxed/simple;
	bh=6lmafzCsTWpTvGeu21j779OMA5ZG5ow47Ac1mlpCsqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1Y1TBdVXm8byaekfKubBvXHnTaHqEV59Ak+oatLi42NFDzXViT9Q/6p5CxyRa5Z9zu8ECr9C9Eu7FL98wl9Pzg8fvClMzKfR/b1vk5QaHNDDyCOwlSOwEYtB0CGN8l7/5qsl7yEuMsen7nf/xNO8FPIqq5Fhr2xXXNz30uaJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0qdbMucO; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V3sbZ2sKtzbSS;
	Tue, 26 Mar 2024 15:28:10 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V3sbY0c8Zzr9;
	Tue, 26 Mar 2024 15:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711463290;
	bh=6lmafzCsTWpTvGeu21j779OMA5ZG5ow47Ac1mlpCsqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0qdbMucO5xs1uqHka3M9q8VqVDkmiY6Telpoml3gQonVqqniVXWmiR5tN5A7fw42M
	 A5EJhy/7F+69xZjBrKC0DLVbWHZ7FLqp/NlTTTJb/8EjdWr3XsApKSsPB2+wOxlYND
	 WTzh6H7MU77zQnsBnu6hv16ulsh/bo6SzrC29YqY=
Date: Tue, 26 Mar 2024 15:28:08 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for
 IOCTL hooks
Message-ID: <20240326.ooCheem1biV2@digikod.net>
References: <20240325134004.4074874-1-gnoack@google.com>
 <20240325134004.4074874-2-gnoack@google.com>
 <80221152-70dd-4749-8231-9bf334ea7160@app.fastmail.com>
 <20240326.pie9eiF2Weis@digikod.net>
 <83b0f28a-92a5-401a-a7f0-d0b0539fc1e5@app.fastmail.com>
 <20240326.ahyaaPa0ohs6@digikod.net>
 <b6a2a782-894a-461c-8fc1-9a3669545633@app.fastmail.com>
 <ZgLJG0aN0psur5Z7@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgLJG0aN0psur5Z7@google.com>
X-Infomaniak-Routing: alpha

On Tue, Mar 26, 2024 at 02:09:47PM +0100, Günther Noack wrote:
> On Tue, Mar 26, 2024 at 12:58:42PM +0100, Arnd Bergmann wrote:
> > On Tue, Mar 26, 2024, at 11:10, Mickaël Salaün wrote:
> > > On Tue, Mar 26, 2024 at 10:33:23AM +0100, Arnd Bergmann wrote:
> > >> On Tue, Mar 26, 2024, at 09:32, Mickaël Salaün wrote:
> > >> >
> > >> > This is indeed a simpler solution but unfortunately this doesn't fit
> > >> > well with the requirements for an access control, especially when we
> > >> > need to log denied accesses.  Indeed, with this approach, the LSM (or
> > >> > any other security mechanism) that returns ENOFILEOPS cannot know for
> > >> > sure if the related request will allowed or not, and then it cannot
> > >> > create reliable logs (unlike with EACCES or EPERM).
> > >> 
> > >> Where does the requirement come from specifically, i.e.
> > >> who is the consumer of that log?
> > >
> > > The audit framework may be used by LSMs to log denials.
> > >
> > >> 
> > >> Even if the log doesn't tell you directly whether the ioctl
> > >> was ultimately denied, I would think logging the ENOFILEOPS
> > >> along with the command number is enough to reconstruct what
> > >> actually happened from reading the log later.
> > >
> > > We could indeed log ENOFILEOPS but that could include a lot of allowed
> > > requests and we usually only want unlegitimate access requests to be
> > > logged.  Recording all ENOFILEOPS would mean 1/ that logs would be
> > > flooded by legitimate requests and 2/ that user space log parsers would
> > > need to deduce if a request was allowed or not, which require to know
> > > the list of IOCTL commands implemented by fs/ioctl.c, which would defeat
> > > the goal of this specific patch.
> > 
> > Right, makes sense. Unfortunately that means I don't see any
> > option that I think is actually better than what we have today,
> > but that forces the use of a custom whitelist or extra logic in
> > landlock.
> > 
> > I didn't really mind having an extra hook for the callbacks
> > in addition to the top-level one, but that was already nacked.
> 
> Thank you both for the review!
> 
> I agree, this approach would break logging.
> 
> As you both also said, I also think this leads us back to the approach
> where we hardcode the allow-list of permitted IOCTL commands in the
> file_ioctl hook.
> 
> I think this approach has the following upsides:
> 
>   1. Landlock's (future) audit logging will be able to log exactly
>      which IOCTL commands were denied.
>   2. The allow-list of permitted IOCTL commands can be reasoned about
>      locally and does not accidentally change as a side-effect of a
>      change to the implementation of fs/ioctl.c.
> 
> A risk that we have is:
> 
>   3. We might miss changes to fs/ioctl.c which we might want to
>      reflect in Landlock.
> 
> 
> To think about 2 and 3 in more concrete terms, I categorized the
> scenarios in which IOCTL cmd implementations can get added to or
> removed from the do_vfs_ioctl() layer:
> 
>   Case A: New cmd added to do_vfs_ioctl layer
> 
>     We want to double check whether this cmd should be included in
>     Landlock's allow list.  (Because the command is new, there are no
>     existing users of the IOCTL command, so we can't break anyone and
>     we it probably does not require to be made explicit in Landlock's
>     ABI versioning scheme.)
> 
>     ==> We need to catch these changes early,
>         and should do Landlock-side changes in sync.
> 
>   Case B: Existing cmd removed from do_vfs_ioctl layer
> 
>     (This case is unlikely, as it would be a backwards-incompatible
>     change in the ioctl interface.)
> 
>   Case C: Existing cmd is moved from f_ops->..._ioctl() to do_vfs_ioctl()
> 
>     (For regular files, I think this has happened for the XFS
>     "reflink" ioctls before, which became features in other COW file
>     systems as well.)
> 
>     If such a change happens for device files (which are in scope for
>     Landlock's IOCTL feature), we should catch these changes.  We
>     should consider whether the affected IOCTL command should be
>     allow-listed.  Strictly speaking, if we allow-list the cmd, which
>     was previously not allow-listed, this would mean that Landlock's
>     DEV_IOCTL feature would have different semantics than before
>     (permitting an additional cmd), and it would potentially be a
>     backwards-incompatible change that need to be made explicit in
>     Landlock's ABI versioning.
> 
>   Case D: Existing cmd is moved from do_vfs_ioctl() to f_ops->..._ioctl()
> 
>     (This case seems also very unlikely to me because it decentralizes
>     the reasoning about these IOCTL APIs which are currently centrally
>     controlled and must stay backwards compatible.)
> 

Excellent summary! You should put a link to this email in the commit
message and quickly explain why we ended up here.

> 
> 
> So -- a proposal:
> 
> * Keep the original implementation of fs/ioctl.c
> * Implement Landlock's file_ioctl hook with a switch(cmd) where we list
>   the permitted IOCTL commands from do_vfs_ioctl.
> * Make sure Landlock maintainers learn about changes to do_vfs_ioctl():
>   * Put a warning on top of do_vfs_ioctl() to loop in Landlock
>     maintainers

Yes please.

>   * Set up automation to catch such changes?
> 
> 
> Open questions are:
> 
> * Mickaël, do you think we should use a more device-file-specific
>   subset of IOCTL commands again, or would you prefer to stick to the
>   full list of all IOCTL commands implemented in do_vfs_ioctl()?

We should stick to the device-file-specific IOCTL commands [1] but we
should probably complete the switch-case with commented cases (in the
same order as in do_vfs_ioctl) to know which one were reviewed (as in
[1]).  These helpers should now be static and in security/landlock/fs.c

[1] https://lore.kernel.org/r/20240219183539.2926165-1-mic@digikod.net

BTW, there are now two new IOCTL commands (FS_IOC_GETUUID and
FS_IOC_GETFSSYSFSPATH) masking device-specific IOCTL ones.

> 
> * Regarding automation:
> 
>   We could additionally set up some automation to watch changes to
>   do_vfs_ioctl().  Given the low rate of change in that corner, we
>   might get away with extracting the relevant portion of the C file
>   (awk '/^static int do_vfs_ioctl/, /^\}/' fs/ioctl.c) and watching
>   for any changes.  It is brittle, but the rate of changes is low, and
>   reasoning about source code is difficult and error prone as well.
> 
>   In an ideal world this could maybe be part of the kernel test
>   suites, but I still have not found the right place where this could
>   be hooked in.  Do you have any thoughts on this?

I think this change should be enough for now:

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12222,6 +12222,7 @@ W:	https://landlock.io
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
+F:	fs/ioctl.c
 F:	include/uapi/linux/landlock.h
 F:	samples/landlock/
 F:	security/landlock/

It should be OK considered the number of patches matching this file: a
subset of https://lore.kernel.org/all/?q=dfn%3Afs%2Fioctl.c

