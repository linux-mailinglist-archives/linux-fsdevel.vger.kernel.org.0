Return-Path: <linux-fsdevel+bounces-12988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6066869D22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFB6B26D65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010123767;
	Tue, 27 Feb 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6IS0R8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F812032D;
	Tue, 27 Feb 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053108; cv=none; b=tInq8HhbvBIRB62NBZf94q7mY6Za22kQz93WhVgTazuwZz7vgd73fDhYKwlKnw64LzRr2O9YzFsPuS16BNalNxTVzdVcW7KRORYJblqH5rPxZKB862rMpedlA2wZv6IEEin4K82mUnCuEquG4MAEG6gtoSN4OGOUKhxjySNiInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053108; c=relaxed/simple;
	bh=ufjVPE9waMFIo/MVVzce/tOWX+JYoUk46QRqXvfo1VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QleyqKLVNBGVbBMQGcLSECDWzWDK5K+RYgPyBJqGYW85EDhUqy3LSUXSa0axYI/AGArTfdf4YRtIYDySpWT+IMSfdFk0uomSDW7Hs3IudErGb4amrEvjt8/iga2NvdMsEhUAPR0sspzcnroJD5EIXf1jxaujG2hODuvPGYfxVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6IS0R8a; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d335a593e6so86555e0c.0;
        Tue, 27 Feb 2024 08:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709053106; x=1709657906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=intUDPdxA52JtEe5pwYJK6j4f9I3pbX2uhoa1TR9ryw=;
        b=O6IS0R8awo7ZBc0Ne+upQ4oKQLxSCtmScwQQBeOxZBXfa0Hs/gMGDTsTAnc1X+x2CR
         sH4EjqRiLWt0yDZkG0rvh3mK+ZHRNEC5nKvP75rxNSyw2zsI/7jgq+LRN2g3Dsc5sumX
         e4gS3RLJH7M3e0fcX1yIPXLxp78f2GO2rgqNf4Ctx3iVceK4bqo04tJOjidBU/zvS4ML
         ETVH4mTAsii88n6xPYcMRag8UcOySpA3lPeFL4TFgfteuxIGvoCHj4Ri6RDoaheffBWZ
         97PBqFxLSDWf9bzyEd1MBuD3dH0QnLAN79khtyvjCU9QraxEvo2MQ4QeZu/Ci8E/rXGB
         YOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709053106; x=1709657906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=intUDPdxA52JtEe5pwYJK6j4f9I3pbX2uhoa1TR9ryw=;
        b=ZESYXaIwV/KJB9jKjW1KV+0rb4spkRgq0g0eBHWU9ft9qCih+jWJur1gOkIW0nJhuJ
         7d12teJrKlyGDLcNS9nzymXqXXMnurWQA5EUKXnVV91aSrdXN/EtvvzMkhUTKVR2kXiQ
         J876fIxC7klZZWK7wRQbr1iI+XAWOvMwHbWFgRURxiuvOuNUtBn6By2QOqY1JU/IbBXT
         zdGdE9Vki7fJd6uSTevK3EzipBspRnHNFwlluLqKQ0+XEufLa9bwBwFDtn8Qa870RS9b
         JUlD2Iy8/0kcwrGzQiF0KtrCitNs0vNCpV6bK6bTV0moer8JwSL4lOQlChCM0XQcD+5c
         Spzg==
X-Forwarded-Encrypted: i=1; AJvYcCWQSgpsTOojH8UrKZPZkXIzvaC57m5AUsAs0Q+dYTqeRzy5xQoMQoOJ/mVWw19PVQpSgq+hjBGRp08MtreMVWB4s0RlIk4Hip8k
X-Gm-Message-State: AOJu0YyAvAQiWrA8ojwoSQTq8Peo1tf3KBPK6H7KLp4wM1L/VDPk3mZZ
	WI55pcWb21vjPvhcqAnJaAiSAhRvh4zN4PwHhImhqx3MGpsXY83gW2i5MW0vkuhczHCvLxg2hqQ
	4ehUWUTY9RJyRkN5M03DHH91Y0EYphcRP/1cYAg==
X-Google-Smtp-Source: AGHT+IFwZ+hFp7bUTfOBg5+fa+HAMISWXfQI2GTDMxqWzqlDjA5Mx33EH/dcpSxW4VNhlUtlfVcFH6hlja5zyg2FJ5Q=
X-Received: by 2002:ac5:cbeb:0:b0:4d1:6b73:865f with SMTP id
 i11-20020ac5cbeb000000b004d16b73865fmr6208987vkn.0.1709053105675; Tue, 27 Feb
 2024 08:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <CAOQ4uxh-gKGuwrvuQnWKcKLKQe2j9s__Yx2T-gCrDJMUbm5ZYA@mail.gmail.com> <20240227154525.GV616564@frogsfrogsfrogs>
In-Reply-To: <20240227154525.GV616564@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Feb 2024 18:58:13 +0200
Message-ID: <CAOQ4uxg9k7261Gw08iCBMZ2sfk7tEwwKh4ufor_PpF-NApvEOA@mail.gmail.com>
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Feb 27, 2024 at 11:23:39AM +0200, Amir Goldstein wrote:
> > On Tue, Feb 27, 2024 at 4:18=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
[...]
> > Maybe a stupid question, but under which circumstances would mtime
> > change and ctime not change? Why are both needed?
>
> It's the other way 'round -- mtime doesn't change but ctime does.  The
> race I'm trying to protect against is:
>
> Thread 0                        Thread 1
> <snapshot fd cmtime>
> <start writing tempfd>
>                                 <fstat fd>
>                                 <write to fd>
>                                 <futimens to reset mtime>
> <commitrange>
>
> mtime is controllable by "attackers" but ctime isn't.  I think we only
> need to capture ctime, but ye olde swapext ioctl (from which this
> derives) did both.
>

Yes, that's what I meant. was just a braino.
mtime seems redundant, but if you want to keep it for compatibility with
legacy API, so be it.

> > And for a new API, wouldn't it be better to use change_cookie (a.k.a i_=
version)?
>
> Seeing as iversion (as the vfs and/or jlayton seems to want it) doesn't
> work in the intended manner in XFS, no.
>

OK. for the record, AFAICT, the problem of NFS guys with xfs iversion
is that it is too
aggressive to their taste (i.e. bumped on atime updates), but because
ctime is always
updated along with iversion in xfs and because iversion has no granularity
problem, I think it is a better choice for you, regardless of any
other filesystems
and their interpretation of ctime or iversion.

> > Even if this API is designed to be hoisted out of XFS at some future ti=
me,
> > Is there a real need to support it on filesystems that do not support
> > i_version(?)
>
> Given the way the iversion discussions have gone (file data write
> counter) I don't think there's a way to support commitrange on
> non-iversion filesystems.
>
> I withdrew any plans to make this more than an XFS-specific ioctl last
> year after giving up on ever getting through fsdevel review.  I think
> the last reply I got was from viro back in 2021...
>

understandable.
I wasn't implying that you should hoist this out of XFS.
I was wondering about why not use xfs's iversion, which
seems like a better change counter than ctime.

> > Not to mention the fact that POSIX does not explicitly define how ctime=
 should
> > behave with changes to fiemap (uninitialized extent and all), so who kn=
ows
> > how other filesystems may update ctime in those cases.
>
> ...and given the lack of interest from any other filesystem developers
> in porting it to !xfs, I'm not likely to take this up ever again.  To be
> faiproblemr, I think the only filesystems that could possibly support
> EXCHANGE_RANGE are /maybe/ btrfs and /probably/ bcachefs.
>

Again, sorry if my question were misinterpreted.
I was not trying to imply that this API should be hoisted.

> > I realize that STATX_CHANGE_COOKIE is currently kernel internal, but
> > it seems that XFS_IOC_EXCHANGE_RANGE is a case where userspace
> > really explicitly requests a bump of i_version on the next change.
>
> Another way I could've structured this (and still could!) would be to
> deproblemclare the entire freshness region as an untyped u64 fresh[4] blo=
b and
> add a START_COMMIT ioctl to fill it out.  Then the kernel fs drivers
> gets to determine what goes in there.
>
> That at least would be less work for userspace to do.
>

To me that makes sense. Cleaner API.
Less questions asked.
But it's up to you.

Thanks,
Amir.

