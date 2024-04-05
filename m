Return-Path: <linux-fsdevel+bounces-16216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522389A3D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 20:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467D91C21D84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9BA171E64;
	Fri,  5 Apr 2024 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hnwiHyfM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF616C690
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340290; cv=none; b=jsqeXrI2AJcRj1gAuZG95sNMEHpNADWt7Gv35UqFvjTiyaG1IpLr3I1TpCSQOv1vUx6X1Vel4QlucqQhWrMRVzaLRE2Ppi57dwEjsXWwcH5NfVbfEOptDCZSodIXqtlXR0JcYXoJTxBpOqD3ubI65EBfwpvwoE78hjmwdttfh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340290; c=relaxed/simple;
	bh=Z/gYh40YSgwB2BZnBaFHPThTxllMSe3ftcvL4OlrbvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/Ru0U+JMWrHlLv1LPRGuPGZ56h9d4NFirojeubtmmq9whpwrfzMbr6hvh0vprsOOnApvo6pycheB1Mw2IUNUCHxRHWnfYGjBLA9G4nRhAJEtGilL4F+CWQINSPNM74/KoG1xi6OEa42reW2XJdk7AZwv+v3GrqXW/gXOTUbO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hnwiHyfM; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VB5wj1nt8z21p;
	Fri,  5 Apr 2024 20:04:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712340277;
	bh=Z/gYh40YSgwB2BZnBaFHPThTxllMSe3ftcvL4OlrbvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnwiHyfMe2qRGtR744cczcj2mgeS9ScuX1Jho6NI/WW/Hck8zxLz4e5HZkFrtQHeM
	 ivqPfzHI+EO5q8whpB1H+uQTDwvnhRq6W4l8J01r/YGwqwch4dEOHcE2H49JAL3L27
	 L3CUhXBm9uRNZqX5fy50+FnGaqU3boEEra8yety4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VB5wh3yKlzmBB;
	Fri,  5 Apr 2024 20:04:36 +0200 (CEST)
Date: Fri, 5 Apr 2024 20:04:36 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	Amir Goldstein <amir73il@gmail.com>, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v13 01/10] landlock: Add IOCTL access right for character
 and block devices
Message-ID: <20240405.ahtaVee6ahc0@digikod.net>
References: <20240327131040.158777-1-gnoack@google.com>
 <20240327131040.158777-2-gnoack@google.com>
 <20240327.eibaiNgu6lou@digikod.net>
 <ZgxOYauBXowTIgx-@google.com>
 <20240403.In2aiweBeir2@digikod.net>
 <ZhAkDW2u3GItsody@google.com>
 <ZhAlXB3PWC4yyU8F@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhAlXB3PWC4yyU8F@google.com>
X-Infomaniak-Routing: alpha

On Fri, Apr 05, 2024 at 06:22:52PM +0200, Günther Noack wrote:
> On Fri, Apr 05, 2024 at 06:17:17PM +0200, Günther Noack wrote:
> > On Wed, Apr 03, 2024 at 01:15:45PM +0200, Mickaël Salaün wrote:
> > > On Tue, Apr 02, 2024 at 08:28:49PM +0200, Günther Noack wrote:
> > > > Can you please clarify how you make up your mind about what should be permitted
> > > > and what should not?  I have trouble understanding the rationale for the changes
> > > > that you asked for below, apart from the points that they are harmless and that
> > > > the return codes should be consistent.
> > > 
> > > The rationale is the same: all IOCTL commands that are not
> > > passed/specific to character or block devices (i.e. IOCTLs defined in
> > > fs/ioctl.c) are allowed.  vfs_masked_device_ioctl() returns true if the
> > > IOCTL command is not passed to the related device driver but handled by
> > > fs/ioctl.c instead (i.e. handled by the VFS layer).
> > 
> > Thanks for clarifying -- this makes more sense now.  I traced the cases with
> > -ENOIOCTLCMD through the code more thoroughly and it is more aligned now with
> > what you implemented before.  The places where I ended up implementing it
> > differently to your vfs_masked_device_ioctl() patch are:
> > 
> >  * Do not blanket-permit FS_IOC_{GET,SET}{FLAGS,XATTR}.
> >    They fall back to the device implementation.
> > 
> >  * FS_IOC_GETUUID and FS_IOC_GETFSSYSFSPATH are now handled.
> >    These return -ENOIOCTLCMD from do_vfs_ioctl(), so they do fall back to the
> >    handlers in struct file_operations, so we can not permit these either.
> 
> Kent, Amir:
> 
> Is it intentional that the new FS_IOC_GETUUID and FS_IOC_GETFSSYSFSPATH IOCTLs
> can fall back to a IOCTL implementation in struct file_operations?  I found this
> remark by Amir which sounded vaguely like it might have been on purpose?  Did I
> understand that correctly?

I think the rationale is that all new VFS IOCTLs should have this fall
back because device drivers might already implement them.

> 
> https://lore.kernel.org/lkml/CAOQ4uxjvEL4P4vV5SKpHVS5DtOwKpxAn4n4+Kfqawcu+H-MC5g@mail.gmail.com/
> 
> Otherwise, I am happy to send a patch to make it non-extensible (the impls in
> fs/ioctl.c would need to return -ENOTTY).  This would let us reason better about
> the safety of these IOCTLs for IOCTL security policies enforced by the Landlock
> LSM. (Some of these file_operations IOCTL implementations do stuff before
> looking at the cmd number.)
> 
> Thanks,
> —Günther
> 

