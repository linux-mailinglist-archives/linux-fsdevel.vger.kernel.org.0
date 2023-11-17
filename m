Return-Path: <linux-fsdevel+bounces-3049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F284C7EF8CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58CEDB20B83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 20:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805A433C4;
	Fri, 17 Nov 2023 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ugpukwFS"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 82516 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Nov 2023 12:44:50 PST
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DF7D50
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 12:44:50 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SX8684h3XzMqwx2;
	Fri, 17 Nov 2023 20:44:48 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SX8676kSCzMpnPf;
	Fri, 17 Nov 2023 21:44:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1700253888;
	bh=syrmWcViwhFbV+UtLTiEObffa0ZHp0o2E+Et2ptrBr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugpukwFSoYn6eFK0vKIlV9W1qNix+clbWquw8wh7xesvyQm3Si1n3ClWqRdjWyr79
	 Sjpue/87x74huGJNCFZifdv+n+L4LJR4pPkQjtJ1SXx/EYFWm21UAOSytE2hCplYew
	 FhCfdzw9XQEv1L6Ic1C9gg+tl/J/uZ44LM1TlFfA=
Date: Fri, 17 Nov 2023 21:44:31 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Landlock: IOCTL support
Message-ID: <20231117.aen7feDah5aD@digikod.net>
References: <20231103155717.78042-1-gnoack@google.com>
 <20231116.haW5ca7aiyee@digikod.net>
 <ZVd8RP01oNc5K92c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVd8RP01oNc5K92c@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 17, 2023 at 03:44:20PM +0100, Günther Noack wrote:
> On Thu, Nov 16, 2023 at 04:49:09PM -0500, Mickaël Salaün wrote:
> > On Fri, Nov 03, 2023 at 04:57:10PM +0100, Günther Noack wrote:

> > > Open questions
> > > ~~~~~~~~~~~~~~
> > > 
> > > This is unlikely to be the last iteration, but we are getting closer.
> > > 
> > > Some notable open questions are:
> > > 
> > >  * Code style
> > >  
> > >    * Should we move the IOCTL access right expansion logic into the
> > >      outer layers in syscall.c?  Where it currently lives in
> > >      ruleset.h, this logic feels too FS-specific, and it introduces
> > >      the additional complication that we now have to track which
> > >      access_mask_t-s are already expanded and which are not.  It might
> > >      be simpler to do the expansion earlier.
> > 
> > What about creating a new helper in fs.c that expands the FS access
> > rights, something like this:
> > 
> > int landlock_expand_fs_access(access_mask_t *access_mask)
> > {
> > 	if (!*access_mask)
> > 		return -ENOMSG;
> > 
> > 	*access_mask = expand_all_ioctl(*access_mask, *access_mask);
> > 	return 0;
> > }
> > 
> > 
> > And in syscalls.c:
> > 
> > 	err =
> > 		landlock_expand_fs_access(&ruleset_attr.handled_access_fs);
> > 	if (err)
> > 		return err;
> > 
> > 	/* Checks arguments and transforms to kernel struct. */
> > 	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
> > 					  ruleset_attr.handled_access_net);
> 
> Done, this looks good.
> 
> I called the landlock_expand_fs_access function slightly differently and made it
> return the resulting access_mask_t (because it does not make a performance
> difference, and then there is no potential for calling it with a null pointer,
> and the function does not need to return an error).
> 
> As a consequence of doing it like this, I also moved the expansion functions
> into fs.c, away from ruleset.h where they did not fit in. :)
> 
> 
> > And patch the landlock_create_ruleset() helper with that:
> > 
> > -	if (!fs_access_mask && !net_access_mask)
> > +	if (WARN_ON_ONCE(!fs_access_mask) && !net_access_mask)
> > 		return ERR_PTR(-ENOMSG);
> 
> Why would you want to warn on the case where fs_access_mask is zero?

Because in my suggestion the real check is moved/copied to
landlock_expand_fs_access(), which is called before, and it should then
not be possible to have this case here.

> 
> Is it not a legitimate use case to use Landlock for the network aspect only?
> 
> (If a user is not handling any of the LANDLOCK_ACCESS_FS* rights, the expansion
> step is not going to add any.)

Correct

> 
> 
> > >    * Rename IOCTL_CMD_G1, ..., IOCTL_CMD_G4 and give them better names.
> > 
> > Why not something like LANDLOCK_ACCESS_FS_IOCTL_GROUP* to highlight that
> > these are in fact (synthetic) access rights?
> > 
> > I'm not sure we can find better than GROUP because even the content of
> > these groups might change in the future with new access rights.
> 
> Makes sense, renamed as suggested.  TBH, IOCTL_CMD_G1...4 was more of a
> placeholder anyway because I was so lazy with my typing. ;)
> 
> 
> > >  * When LANDLOCK_ACCESS_FS_IOCTL is granted on a file hierarchy,
> > >    should this grant the permission to use *any* IOCTL?  (Right now,
> > >    it is any IOCTL except for the ones covered by the IOCTL groups,
> > >    and it's a bit weird that the scope of LANDLOCK_ACCESS_FS_IOCTL
> > >    becomes smaller when other access rights are also handled.
> > 
> > Are you suggesting to handle differently this right if it is applied to
> > a directory?
> 
> No - this applies to files as well.  I am suggesting that granting
> LANDLOCK_ACCESS_FS_IOCTL on a file or file hierarchy should always give access
> to *all* ioctls, both the ones in the synthetic groups and the remaining ones.
> 
> Let me spell out the scenario:
> 
> Steps to reproduce:
>   - handle: LANDLOCK_ACCESS_FS_IOCTL | LANDLOCK_ACCESS_FS_READ_FILE
>   - permit: LANDLOCK_ACCESS_FS_IOCTL
>             on file f
>   - open file f (for write-only)
>   - attempt to use ioctl(fd, FIOQSIZE, ...)
> 
> With this patch set:
>   - ioctl(fd, FIOQSIZE, ...) fails,
>     because FIOQSIZE is part of IOCTL_CMD_G1
>     and because LANDLOCK_ACCESS_FS_READ_FILE is handled,
>     IOCTL_CMD_G1 is only unlocked through LANDLOCK_ACCESS_FS_READ_FILE

Correct, and it looks consistent to me.

> 
> Alternative proposal:
>   - ioctl(fd, FIOQSIZE, ...) should maybe work,
>     because LANDLOCK_ACCESS_FS_IOCTL is permitted on f
> 
>     Implementation-wise, this would mean to add
> 
>     expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_IOCTL, ioctl_groups)
> 
>     to expand_all_ioctl().
> 
> I feel that this alternative might be less surprising, because granting the
> IOCTL right would grant all the things that were restricted when handling the
> IOCTL right, and it would be more "symmetric".
> 
> What do you think?

I though that we discussed about that and we agree that it was the way
to go. Cf. the table of handled/allowed/not-allowed.

Why would LANDLOCK_ACCESS_FS_IOCTL grant access to FIOQSIZE in the case
of a directory but not a file? These would be two different semantics.

> 
> 
> > If the scope of LANDLOCK_ACCESS_FS_IOCTL is well documented, that should
> > be OK. But maybe we should rename this right to something like
> > LANDLOCK_ACCESS_FS_IOCTL_DEFAULT to make it more obvious that it handles
> > IOCTLs that are not handled by other access rights?
> 
> Hmm, I'm not convinced this is a good name.  It makes sense in the context of
> allowing "all the other ioctls" for a file or file hierarchy, but when setting
> LANDLOCK_ACCESS_FS_IOCTL in handled_access_fs, that flag turns off *all* ioctls,
> so "default" doesn't seem appropriate to me.

It should turn off all IOCTLs that are not handled by another access
right.  The handled access rights should be expanded the same way as the
allowed access rights.

> 
> 
> > >  * Backwards compatibility for user-space libraries.
> > > 
> > >    This is not documented yet, because it is currently not necessary
> > >    yet.  But as soon as we have a hypothetical Landlock ABI v6 with a
> > >    new IOCTL-enabled "GFX" access right, the "best effort" downgrade
> > >    from v6 to v5 becomes more involved: If the caller handles
> > >    GFX+IOCTL and permits GFX on a file, the correct downgrade to make
> > >    this work on a Landlock v5 kernel is to handle IOCTL only, and
> > >    permit IOCTL(!).
> > 
> > I don't see any issue to this approach. If there is no way to handle GFX
> > in v5, then there is nothing more we can do than allowing GFX (on the
> > same file). Another way to say it is that in v5 we allow any IOCTL
> > (including GFX ones) on the GFX files, an in v6 we *need* replace this
> > IOCTL right with the newly available GFX right, *if it is handled* by
> > the ruleset.
> > 
> > If GFX would not be tied to a file, I think it would not be a good
> > design for this access right. Currently all access rights are tied to
> > objects/data, or relative to the sandbox (e.g. ptrace).
> 
> Yes, makes sense - we are aligned then.
> 
> —Günther

