Return-Path: <linux-fsdevel+bounces-15580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4319890634
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD829EBB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EA812D76F;
	Thu, 28 Mar 2024 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DXOp6IKO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048053BBC7
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644238; cv=none; b=CG1MP72w8BL88JfAUROdfcv9OtzI+7e9dkD5KiXAVIzJ5nB1oK2E7hT4wGuJ55/JtP4DE8PkxigZk4xfCJmeG7ZfbE4e4zUsnGluJmesbzdkJaTiuacmSEPM4JtgOhgc4a8vi4CnNY7/19tOYb+4BYLAHMlj3pmRrWeksjIXB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644238; c=relaxed/simple;
	bh=+bSrKAtDF5uJe/MOUQh6w++8XZ49Zs92jJVUIiROUZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acAvIOgHHKl5kqEaop1ol2RcWHqG4/bQDq3GxUX+w/npFOvsTla9Z7UbBbtURjh0fE/yFlqv04PB2xR+PSByYCom2kgYQY+KstWCz9TVrKtgyvTB2YVd21MpakAKJaC3p695GSuURHon7TEy9+oKx8hTTrF+SxPRx9HxpwrFqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DXOp6IKO; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V58WB1Cs4zY8m;
	Thu, 28 Mar 2024 17:43:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711644230;
	bh=+bSrKAtDF5uJe/MOUQh6w++8XZ49Zs92jJVUIiROUZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXOp6IKO55i6BlFAuMxhPG/l0JvRNaGEgg0nV1UX+hFYw+Xy3yL58Pps5MyuS9PRf
	 9YqFZhuu9iIisMmS2TGxsOZOkcu8z1JihsOCZBH9Pe9DEkLg6iGTTCcLOx1UA8fisE
	 iDxv2hytl/l2wyx2AufkXulw49xs5We8HMNXp/RU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V58W9410hzsB;
	Thu, 28 Mar 2024 17:43:49 +0100 (CET)
Date: Thu, 28 Mar 2024 17:43:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in
 sync with the Landlock LSM
Message-ID: <20240328.mahn4seChaej@digikod.net>
References: <20240327131040.158777-1-gnoack@google.com>
 <20240327131040.158777-11-gnoack@google.com>
 <20240328.ahgh8EiLahpa@digikod.net>
 <CAHC9VhT0SjH19ToK7=5d5hdkP-ChTpEEaeHbM0=K8ni_ECGQcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT0SjH19ToK7=5d5hdkP-ChTpEEaeHbM0=K8ni_ECGQcw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Mar 28, 2024 at 09:08:13AM -0400, Paul Moore wrote:
> On Thu, Mar 28, 2024 at 8:11 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Wed, Mar 27, 2024 at 01:10:40PM +0000, Günther Noack wrote:
> > > Landlock's IOCTL support needs to partially replicate the list of
> > > IOCTLs from do_vfs_ioctl().  The list of commands implemented in
> > > do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.
> > >
> > > Signed-off-by: Günther Noack <gnoack@google.com>
> > > ---
> > >  fs/ioctl.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index 1d5abfdf0f22..661b46125669 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *file, void __user *argp)
> > >   *
> > >   * When you add any new common ioctls to the switches above and below,
> > >   * please ensure they have compatible arguments in compat mode.
> > > + *
> > > + * The commands which are implemented here should be kept in sync with the IOCTL
> > > + * security policies in the Landlock LSM.
> >
> > Suggestion:
> > "with the Landlock IOCTL security policy defined in security/landlock/fs.c"
> 
> We really shouldn't have any comments or code outside of the security/
> directory that reference a specific LSM implementation.  I'm sure
> there are probably a few old comments referring to SELinux, but those
> are bugs as far as I'm concerned (if anyone spots one, please let me
> know or send me a patch!).
> 
> How about the following?
> 
> "The LSM list should also be notified of any command additions or

"The LSM mailing list..."

> changes as specific LSMs may be affected."

Looks good.

> 
> -- 
> paul-moore.com
> 

