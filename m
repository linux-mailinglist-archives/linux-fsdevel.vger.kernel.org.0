Return-Path: <linux-fsdevel+bounces-16217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B089A3FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 20:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BA41F22E3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69B171E71;
	Fri,  5 Apr 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ATQej8jQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94517167C
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341061; cv=none; b=PQsL7HFKoXMEURogeI2tC05sqm8nAnEQKlBAZqZ968/YVtH0sW2wZ8Hb+DgAEcWPx7PYkr4ZVAXlRpoZGi6e6mWvKZsqBaXh9DN2wfxdT3BV/5/bG3ZFjQB3YnId/FyxLGUoMpL4Wt97CKQXGNhgASV+6ICAKi5EkjP+scOZEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341061; c=relaxed/simple;
	bh=9AkpJlrF5odbZV84lVLCxgA8MjnO8gRUI0F9+okt4N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpo9SubQyzpkBbt9PpZmN6xhf4xvV6lnXm9UmNpbEpHmfzXkT1Y0GrpJ2IcGhoemkrwnocpTsvnyl4EBeUyW/Q1u4ZiwKT9sRno0tAXVFUdYxb/w17bvTtzHZjL6Lzuc5HIoVsK9Q8cgl37+8rB8lXUdCtV3lgOTMNwEDdMKDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ATQej8jQ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Apr 2024 14:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712341056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRUSRTybuNRB3AfwvsaVKFQldXbDzh1KNiUNcGYtJqc=;
	b=ATQej8jQu8tuNtAXedkf+i8FuCyCe76gbQonboyja2qc3hoxthjvbOAdkDPsoB4/CJW/yN
	PWkMVvivlV8A3A2ZPuEhxBRWzcAlXsqDx2voFXfgnCRuRp1Y6gqZtB5FB/xD1pe57cVpGx
	7OuOUU/cl0625FvM2Iyp+b+MRlbYNV8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Subject: Re: [PATCH v13 01/10] landlock: Add IOCTL access right for character
 and block devices
Message-ID: <cnwpkeovzbumhprco7q2c2y6zxzmxfpwpwe3tyy6c3gg2szgqd@vfzjaw5v5imr>
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
X-Migadu-Flow: FLOW_OUT

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
> 
> https://lore.kernel.org/lkml/CAOQ4uxjvEL4P4vV5SKpHVS5DtOwKpxAn4n4+Kfqawcu+H-MC5g@mail.gmail.com/
> 
> Otherwise, I am happy to send a patch to make it non-extensible (the impls in
> fs/ioctl.c would need to return -ENOTTY).  This would let us reason better about
> the safety of these IOCTLs for IOCTL security policies enforced by the Landlock
> LSM. (Some of these file_operations IOCTL implementations do stuff before
> looking at the cmd number.)

They're not supposed to be extensible - the generic implementations are
all we need.

