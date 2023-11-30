Return-Path: <linux-fsdevel+bounces-4344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 037E27FECFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86737B20BE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11C3C075
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IJw9bJxH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fad])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1471A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 01:26:51 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SgrRt13JfzMpnXM;
	Thu, 30 Nov 2023 09:26:50 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SgrRs0JNKzMppB6;
	Thu, 30 Nov 2023 10:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701336410;
	bh=2LdqcSNzH4MXIUu2RII5/gxylMCRInKW/CGCYqXhkeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJw9bJxHKQ5sMhCqQ4bE9qLXlraj6pyu4ce4xGSfMARZJvihI87UPO2eoPQqkOFSG
	 JBm4fJ2Yre95Yy+XfaOjdMci8LAs6ymRnNXHilZ0vQRIr57mxYmJj9sx6VHM/Cbxmk
	 /CnMIiZMXasDC4wTZtq0l4YYaLZ+9qCyjhboBDeA=
Date: Thu, 30 Nov 2023 10:26:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Landlock: IOCTL support
Message-ID: <20231130.eipai4uXighe@digikod.net>
References: <20231103155717.78042-1-gnoack@google.com>
 <20231116.haW5ca7aiyee@digikod.net>
 <ZVd8RP01oNc5K92c@google.com>
 <20231117.aen7feDah5aD@digikod.net>
 <ZWCe1FnVVlYQmQFG@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWCe1FnVVlYQmQFG@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 24, 2023 at 02:02:12PM +0100, Günther Noack wrote:
> On Fri, Nov 17, 2023 at 09:44:31PM +0100, Mickaël Salaün wrote:
> > On Fri, Nov 17, 2023 at 03:44:20PM +0100, Günther Noack wrote:
> > > On Thu, Nov 16, 2023 at 04:49:09PM -0500, Mickaël Salaün wrote:
> > > > On Fri, Nov 03, 2023 at 04:57:10PM +0100, Günther Noack wrote:
> > > > And patch the landlock_create_ruleset() helper with that:
> > > > 
> > > > -	if (!fs_access_mask && !net_access_mask)
> > > > +	if (WARN_ON_ONCE(!fs_access_mask) && !net_access_mask)
> > > > 		return ERR_PTR(-ENOMSG);
> > > 
> > > Why would you want to warn on the case where fs_access_mask is zero?
> > 
> > Because in my suggestion the real check is moved/copied to
> > landlock_expand_fs_access(), which is called before, and it should then
> > not be possible to have this case here.
> 
> Oh, I see, I misread that code.  I guess it does not apply to the version that
> we ended up with.
> 
> 
> > > > >  * When LANDLOCK_ACCESS_FS_IOCTL is granted on a file hierarchy,
> > > > >    should this grant the permission to use *any* IOCTL?  (Right now,
> > > > >    it is any IOCTL except for the ones covered by the IOCTL groups,
> > > > >    and it's a bit weird that the scope of LANDLOCK_ACCESS_FS_IOCTL
> > > > >    becomes smaller when other access rights are also handled.
> > > > 
> > > > Are you suggesting to handle differently this right if it is applied to
> > > > a directory?
> > > 
> > > No - this applies to files as well.  I am suggesting that granting
> > > LANDLOCK_ACCESS_FS_IOCTL on a file or file hierarchy should always give access
> > > to *all* ioctls, both the ones in the synthetic groups and the remaining ones.
> > > 
> > > Let me spell out the scenario:
> > > 
> > > Steps to reproduce:
> > >   - handle: LANDLOCK_ACCESS_FS_IOCTL | LANDLOCK_ACCESS_FS_READ_FILE
> > >   - permit: LANDLOCK_ACCESS_FS_IOCTL
> > >             on file f
> > >   - open file f (for write-only)
> > >   - attempt to use ioctl(fd, FIOQSIZE, ...)
> > > 
> > > With this patch set:
> > >   - ioctl(fd, FIOQSIZE, ...) fails,
> > >     because FIOQSIZE is part of IOCTL_CMD_G1
> > >     and because LANDLOCK_ACCESS_FS_READ_FILE is handled,
> > >     IOCTL_CMD_G1 is only unlocked through LANDLOCK_ACCESS_FS_READ_FILE
> > 
> > Correct, and it looks consistent to me.
> > 
> > > 
> > > Alternative proposal:
> > >   - ioctl(fd, FIOQSIZE, ...) should maybe work,
> > >     because LANDLOCK_ACCESS_FS_IOCTL is permitted on f
> > > 
> > >     Implementation-wise, this would mean to add
> > > 
> > >     expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_IOCTL, ioctl_groups)
> > > 
> > >     to expand_all_ioctl().
> > > 
> > > I feel that this alternative might be less surprising, because granting the
> > > IOCTL right would grant all the things that were restricted when handling the
> > > IOCTL right, and it would be more "symmetric".
> > > 
> > > What do you think?
> > 
> > I though that we discussed about that and we agree that it was the way
> > to go. Cf. the table of handled/allowed/not-allowed.
> 
> We can go with the current implementation as well, I don't feel very strongly
> about it.
> 
> 
> > Why would LANDLOCK_ACCESS_FS_IOCTL grant access to FIOQSIZE in the case
> > of a directory but not a file? These would be two different semantics.
> 
> If the ruleset were enforced in that proposal, as in the example above, it would
> not distinguish whether the affected filesystem paths are files or directories.
> 
> If LANDLOCK_ACCESS_FS_IOCTL is handled, the semantics would be:
> 
>   * If you permit LANDLOCK_ACCESS_FS_READ_FILE on a directory or file,
>     it would become possible to use these ioctl commands on the affected files
>     which are relevant and harmless for reading files.  (As before)
> 
>   * If you permit LANDLOCK_ACCESS_FS_IOCTL on a directory or file,
>     it would become possible to use *all* ioctl commands on the affected files.
> 
>     (That is the difference.  In the current implementation, this only affects
>      the ioctl commands which are *not* in the synthetic groups.  In the
>      alternative proposal, it would affect *all* ioctl commands.
> 
>      I think this might be simpler to reason about, because the set of ioctl
>      commands which are affected by permitting(!) LANDLOCK_ACCESS_FS_IOCTL would
>      always be the same (namely, all ioctl commands), and it would not be
>      dependent on whether other access rights are handled.)
> 
> 
> I don't think it is at odds with the backwards-compatibility concerns which we
> previously discussed.  The synthetic groups still exist, it's just the
> "permitting LANDLOCK_ACCESS_FS_IOCTL on a file or directory" which affects a
> different set of IOCTL commands.

It would not be a backward-compatibility issue, but it would make
LANDLOCK_ACCESS_FS_IOCTL too powerful even if we get safer/better access
rights. Furthermore, reducing the scope of LANDLOCK_ACCESS_FS_IOCTL with
new handled access rights should better inform end encourage developers
to drop LANDLOCK_ACCESS_FS_IOCTL when it is not strictly needed.
It would be useful to explain this rationale in the commit message.
See https://lore.kernel.org/all/20231020.moefooYeV9ei@digikod.net/

> 
> 
> > > > If the scope of LANDLOCK_ACCESS_FS_IOCTL is well documented, that should
> > > > be OK. But maybe we should rename this right to something like
> > > > LANDLOCK_ACCESS_FS_IOCTL_DEFAULT to make it more obvious that it handles
> > > > IOCTLs that are not handled by other access rights?
> > > 
> > > Hmm, I'm not convinced this is a good name.  It makes sense in the context of
> > > allowing "all the other ioctls" for a file or file hierarchy, but when setting
> > > LANDLOCK_ACCESS_FS_IOCTL in handled_access_fs, that flag turns off *all* ioctls,
> > > so "default" doesn't seem appropriate to me.
> > 
> > It should turn off all IOCTLs that are not handled by another access
> > right.  The handled access rights should be expanded the same way as the
> > allowed access rights.
> 
> If you handle LANDLOCK_ACCESS_FS_IOCTL, and you don't permit anything on files
> or directories, all IOCTL commands will be forbidden, independent of what else
> is handled.
> 
> The opposite is not true:
> 
> If you handle LANDLOCK_ACCESS_FS_READ_FILE, and you don't handle
> LANDLOCK_ACCESS_FS_IOCTL, all IOCTL commands will happily work.
> 
> So if you see it through that lens, you could say that it is only the
> LANDLOCK_ACCESS_FS_IOCTL bit in the "handled" mask which forbids any IOCTL
> commands at all.

Handling LANDLOCK_ACCESS_FS_IOCTL does make all IOCTLs denied by
default. However, to allow IOCTLs, developers may need to allow
LANDLOCK_ACCESS_FS_IOCTL or another access right according to the
underlying semantic.

It would be useful to add an example with your table in the
documentation, for instance with LANDLOCK_ACCESS_FS_READ_FILE (handled
or not handled, with LANDLOCK_ACCESS_FS_IOCTL or not, allowed on a file
or not...).

> 
> 
> I hope this makes sense.  It's not my intent to open this
> backwards-compatibility can of worms from scratch... :)
> 
> —Günther
> 

