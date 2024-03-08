Return-Path: <linux-fsdevel+bounces-14023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24357876B2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 20:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE619282B22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87C5A79C;
	Fri,  8 Mar 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cWs/SRyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE685A4E2
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925792; cv=none; b=Vytejz8F6+d5Y7DPpdTpBZyGi4RRWtA3Omu6vOaLjRh/bGN4UGlu/TToUE83O0Oj6tJ9J2Qo8t+WJ9erp1BJA6vmYBZGhDyemBtxhpZ/IQLtMgRBQoIwlfeRcftlntfm69zeQNAIW4d1urAA32cBDZSZRejZ1IRANe1Xumk6e8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925792; c=relaxed/simple;
	bh=Ddw7qVrdwoIYvERz07iQgXFSX01EyK3i0dmku3uTDEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6s8ej70v4qvY+dLkPfxSd6A55Kk2XZRwNRrHkf8JJkkWRXsJSUqHnOalCgrqo/cYY/sUvDMHyZEB/XZahiY1MK/jhNBL291T8Rqhghhlip9nQV8DbkhUfHHw/VFiWXlb1vVPzXrlx7//HrEQIA0iiYTljUKqx2MpiZZ1xJmPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cWs/SRyc; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a068e26d8so9844947b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709925789; x=1710530589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBke2gD8OzX5nFNAE0JR/exakrZE/yQXlXOJhrS6KgQ=;
        b=cWs/SRyca0xq6pHOOvbihNQpOBt9WASlQtPrQkIgL/jHHgDd6tVBNznGcbGjNH1m5F
         u4sc9dkppFvVBCeLbNM0DA35JJnAcw/udG6t+z03LSyeP/sMgSNUb/yNS99M7BKmDpoh
         KEiNj1M4/0Cur60jlsobGUKwhrAL9nvYG28QDTolJq+KBTGMrCkby20LcmIN1/1Jowci
         5t2BIWoXmDbff9XXm1bazbSyZ6bgFoSsEXLzhz2Fa2daOO+WQ7Ngt/ALmUKb8Go+yxpq
         C3/Cs3wciJkgIpbB0y1WvoWYFTxxpyvxTPB320clSTnbBTRzamWcBDi6MsR33AgVCNPQ
         TBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709925789; x=1710530589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBke2gD8OzX5nFNAE0JR/exakrZE/yQXlXOJhrS6KgQ=;
        b=h1BubBoW56unrBqwP8Izjitys/4ae1LiXEGAlirVKrbh8/HrWfd68ZbYcNUYzUPzNr
         J8FdqaArLc8Hz7t1+4dBWByTD8ITGo1G47zZE76fDj+HvrqZ56qHdrvum0v85oxRPF9E
         FQrcAAMZdsFSAbaneszzgTVhDP90HWWRGipL1QuInxBKZxIsUS7s3GN9amrx2tbUm6ig
         5VTur+xjK6pXqfrxWfzPVwp5/8uOAqLd434t3pVZ40vQa++34/ruQ2sj318T4U80x5fT
         pRgHJCWX8punwal6FGoeDumSFlHZWpER68lp+OvDWnPkvhgcYZt+0lAFUl7/pbylrbDD
         Q4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUKPH8W1BePNDHKvFf/XrE6kX+wdSMvMK5//29gmwwHmflsSKUUfVQldRDniCQzBDzRoNeTzvCIXWdUTh0qUAn0Ool0Q/CcUlVlgPy5Pw==
X-Gm-Message-State: AOJu0YysNmvv+OonzVw1d/KEpxaV6Nc+K8FXK8cbAt0iaU6aF7/i6jo3
	OZ2ZA8D8oN3mJc8jx+v2jO6veQR2xdlRwtEEeMVpVFbGNeEZNSJzbqY6hiW2/h0EdiROx50AOOf
	/cHPYPq6RrtdVUeQQr/z0XHVoj/XbG15+38PZ
X-Google-Smtp-Source: AGHT+IFiT7W+O9fV9cIX83+LivpxmLL9XtEe2MwNphBDoOhqniLEanqwigvg/AM91yezljl8itI6w5f/79FhgXTUat8=
X-Received: by 2002:a81:4703:0:b0:608:d311:1acc with SMTP id
 u3-20020a814703000000b00608d3111accmr118679ywa.29.1709925789298; Fri, 08 Mar
 2024 11:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219183539.2926165-1-mic@digikod.net> <ZedgzRDQaki2B8nU@google.com>
 <20240306.zoochahX8xai@digikod.net> <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner> <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com> <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area> <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <20240308.saiheoxai7eT@digikod.net>
In-Reply-To: <20240308.saiheoxai7eT@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Mar 2024 14:22:58 -0500
Message-ID: <CAHC9VhSjMLzfjm8re+3GN4PrAjO2qQW4Rf4o1wLchPDuqD-0Pw@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 4:29=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > > On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
> > >> On Thu, Mar 7, 2024 at 7:57=E2=80=AFAM G=C3=BCnther Noack <gnoack@go=
ogle.com> wrote:
> > >> I need some more convincing as to why we need to introduce these new
> > >> hooks, or even the vfs_masked_device_ioctl() classifier as originall=
y
> > >> proposed at the top of this thread.  I believe I understand why
> > >> Landlock wants this, but I worry that we all might have different
> > >> definitions of a "safe" ioctl list, and encoding a definition into t=
he
> > >> LSM hooks seems like a bad idea to me.
> > >
> > > I have no idea what a "safe" ioctl means here. Subsystems already
> > > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> > > "safe" clearly means something different here.
> >
> > That was my problem with the first version as well, but I think
> > drawing the line between "implemented in fs/ioctl.c" and
> > "implemented in a random device driver fops->unlock_ioctl()"
> > seems like a more helpful definition.
> >
> > This won't just protect from calling into drivers that are lacking
> > a CAP_SYS_ADMIN check, but also from those that end up being
> > harmful regardless of the ioctl command code passed into them
> > because of stupid driver bugs.
>
> Indeed.
>
> "safe" is definitely not the right word, it is too broad, relative to
> use cases and threat models.  There is no "safe" IOCTL.
>
> Let's replace "safe IOCTL" with "IOCTL always allowed in a Landlock
> sandbox".

Which is a problem from a LSM perspective as we want to avoid hooks
which are tightly bound to a single LSM or security model.  It's okay
if a new hook only has a single LSM implementation, but the hook's
definition should be such that it is reasonably generalized to support
multiple LSM/models.

> Our assumptions are (in the context of Landlock):
>
> 1. There are IOCTLs tied to file types (e.g. block device with
>    major/minor) that can easily be identified from user space (e.g. with
>    the path name and file's metadata).  /dev/* files make sense for user
>    space and they scope to a specific use case (with relative
>    privileges).  This category of IOCTLs is implemented in standalone
>    device drivers (for most of them).
>
> 2. Most user space processes should not be denied access to IOCTLs that
>    are managed by the VFS layer or the underlying filesystem
>    implementations.  For instance, the do_vfs_ioctl()'s ones (e.g.
>    FIOCLEX, FIONREAD) should always be allowed because they may be
>    required to legitimately use files, and for performance and security
>    reasons (e.g. fs-crypt, fsverity implemented at the filesystem layer).
>    Moreover, these IOCTLs should already check the read/write permission
>    (on the related FD), which is not the case for most block/char device
>    IOCTL.
>
> 3. IOCTLs to pipes and sockets are out of scope.  They should always be
>    allowed for now because they don't directly expose files' data but
>    IPCs instead, and we are focusing on FS access rights for now.
>
> We want to add a new LANDLOCK_ACCESS_FS_IOCTL_DEV right that could match
> on char/block device's specific IOCTLs, but it would not have any impact
> on other IOCTLs which would then always be allowed (if the sandboxed
> process is allowed to open the file).
>
> Because IOCTLs are implemented in layers and all IOCTLs commands live in
> the same 32-bit namespace, we need a way to identify the layer
> implemented by block and character devices.  The new LSM hook proposal
> enables us to cleanly and efficiently identify the char/block device
> IOCTL layer with an additional check on the file type.

I guess I should wait until there is an actual patch, but as of right
now a VFS ioctl specific LSM hook looks far too limited to me and
isn't something I can support at this point in time.  It's obviously
limited to only a subset of the ioctls, meaning that in order to have
comprehensive coverage we would either need to implement a full range
of subsystem ioctl hooks (ugh), or just use the existing
security_file_ioctl().  I understand that this makes things a bit more
complicated for Landlock's initial ioctl implementation, but
considering my thoughts above and the fact that Landlock's ioctl
protections are still evolving I'd rather not add a lot of extra hooks
right now.

--=20
paul-moore.com

