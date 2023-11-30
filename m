Return-Path: <linux-fsdevel+bounces-4346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A84B7FECFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC495281D28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562B3C06F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="aAinTKau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BECBD;
	Thu, 30 Nov 2023 01:27:50 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SgrT11qJ0zMpngF;
	Thu, 30 Nov 2023 09:27:49 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SgrT03dS9zMppB0;
	Thu, 30 Nov 2023 10:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701336469;
	bh=tG22Th4W4M4eztt2igYhmlVBoyr2PasyqOHFuo8mNdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAinTKauyBruUeTmvIk+nAhy99bKCnVUCa/pEGYAYdnE+l7gF7iV8WyF5K5kcyDAM
	 LqqzYOW7KLs7i0p0Ce3ueG+3kTmFzm83dqaTiYh+ur0Gd+d3lFJi7r4BEnE7/OoZ6A
	 I4wUEF7EI5ZXmUail3k/+lu235A4YzZ0E4ow9ZyA=
Date: Thu, 30 Nov 2023 10:27:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] landlock: Add IOCTL access right
Message-ID: <20231130.Aapo3iec1OG9@digikod.net>
References: <20231117154920.1706371-1-gnoack@google.com>
 <20231117154920.1706371-3-gnoack@google.com>
 <20231120.fau2Oi6queij@digikod.net>
 <ZWDDlvXCdShpFIZ5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWDDlvXCdShpFIZ5@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 24, 2023 at 04:39:02PM +0100, Günther Noack wrote:
> On Mon, Nov 20, 2023 at 08:43:30PM +0100, Mickaël Salaün wrote:
> > On Fri, Nov 17, 2023 at 04:49:15PM +0100, Günther Noack wrote:
> > > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP1	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1)
> > > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP2	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 2)
> > > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP3	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 3)
> > > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP4	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 4)
> > 
> > Please move this LANDLOCK_ACCESS_FS_IOCTL_* block to fs.h
> > 
> > We can still create the public and private masks in limits.h but add a
> > static_assert() to make sure there is no overlap.
> 
> Done.
> 
> 
> > >  	/* Checks content (and 32-bits cast). */
> > > -	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
> > > -	    LANDLOCK_MASK_ACCESS_FS)
> > > +	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_PUBLIC_ACCESS_FS) !=
> > > +	    LANDLOCK_MASK_PUBLIC_ACCESS_FS)
> > 
> > It would now be possible to add LANDLOCK_ACCESS_FS_IOCTL_GROUP* to a
> > rule, which is not part of the API/ABI. I've sent a patch with new tests
> > to make sure this is covered:
> > https://lore.kernel.org/r/20231120193914.441117-2-mic@digikod.net
> > 
> > I'll push it in my -next branch if everything is OK before pushing your
> > next series. Please review it.
> 
> Thanks, good catch!
> 
> Looking at add_rule_path_beneath(), it indeed does not look like I have covered
> that case in my patch.  I'll put an explicit check for it, like this:
> 
>   /*
>    * Checks that allowed_access matches the @ruleset constraints and only
>    * consists of publicly visible access rights (as opposed to synthetic
>    * ones).
>    */
>   mask = landlock_get_raw_fs_access_mask(ruleset, 0) &
>          LANDLOCK_MASK_PUBLIC_ACCESS_FS;
>   if ((path_beneath_attr.allowed_access | mask) != mask)
>           return -EINVAL;
> 
> I assume that the tests that you added were failing?  Or was there an obscure
> code path that caught it anyway?

Yep, it was failing, but it works with the v6.

> 
> Thanks,
> —Günther
> 

