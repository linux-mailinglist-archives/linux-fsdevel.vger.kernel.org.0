Return-Path: <linux-fsdevel+bounces-17245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 379DB8A99AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 14:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EF71F224E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053915F418;
	Thu, 18 Apr 2024 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ElppOv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06315F321
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442915; cv=none; b=QkanbMqK1VhHl1CVY+3bu2mAtplHkpUBHBrre9WhFfVuc9VKMs8uQZk4gDpVZ0uUB+4r7D7NAxhFawnIO1v1E+5zmI0Qx3Pfh1gDHsKv83+h1FUZUOswlRlDqOsS4dorsdDHWs0y5/OJbsyv9my1sNQTfvjsoWiK8S+PugHpt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442915; c=relaxed/simple;
	bh=6ruhslAedCjjjSMp2+E4OQLfEGFsurT97SGY+S13OTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EiNUZ4q7DJ6aAfPW/P5CNUHhGiaMVy805VIutrRriBmjYbXm95e4odfr/NrSOuVgg0tqbLOjKEkRIjmNmFwbKUPYSRUQgetup2Zlp31gNKCpWdKvLeNlYS5xaS8OFbHEj7VnjyRJfyLXC7RVd0PcYrN5btp6WF32xmmt/pq0NB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ElppOv3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b233089deso8386147b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713442912; x=1714047712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7yzYGaNli5QLhz6sRFnhGUzOpTSYT7MYkpNgPPkp6A=;
        b=0ElppOv3wFKJSc/98suYJ/u6lZ+eeGt0HMFito4wgNe8CuuRSIcjsyRabbdwvc8sVD
         6U3yrucpcnniBQHvKZoGMLxwOB55WJ1PwAMTr8WNRj5wQBmmMPVKKNQghynEHBUYdTT2
         Vmq2JZfhItKBmq3bGaGg3+cMjbukPRs+T8ggS8pE99tDdbEdGMZ3cuATRoymy8FzxMif
         7CKnpLa/W4bLLUwbRVKWZ5xAksIfjGoEgp1qY6l97Mf+xhbkpmK+L9XrGrZQmSl+Q5kX
         hw4aiQXOnxbHUao+NR8gJxbpBJTHcPGNJ6m0Sv+U3kR802fr+hArBV60mxYnLZ6nKJm1
         +itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713442912; x=1714047712;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I7yzYGaNli5QLhz6sRFnhGUzOpTSYT7MYkpNgPPkp6A=;
        b=KntS5n6A1XpHD7c4YBO2veoV4j8P8Lprv+L5U4md2tK+ztFuFlZErsF6wbwu/R8kQs
         DY3Pkuklu+V09wMjSDMx9UngwntVOkG5jxpzZe0l/YYox8YM4QpMxf4qSbRHKC5hnCw6
         cb5Iurz+uyZ8FwA1RrKXTzffH2DEJE2lQ1YP+X2QU1HQVSR8+Ids54ZwkkmOnaBLP+Jn
         VQeLb+H4zJ2IY0l/Nc67nmEsVpowMpW+UznsH8wPeLnQylLUVL2wJAJXHXD4Pk36hM/v
         EYJBjGuhQDVx4qajc3C2lCZpuJ3Ut2ICP0L1DwhgVuwRKTyNsIAYICuTXTT7PVNPi+dD
         /YwA==
X-Forwarded-Encrypted: i=1; AJvYcCWBAgz3IfgHwwSpMGlAXx0E8opEE6u6Sjp8p4/ijwpe5ME7KXi/Z6x/HVSMHmIMKgqCUCsMgPTFNe6Q+2W95fmtk4VIQYmHnnae9PRnCw==
X-Gm-Message-State: AOJu0Yxh/OQ1AJVuVgJYS8FCTB9aqd03dl049l41AoAQW/QyvPYCGWeT
	vauYCfe571AHaQME+KNDCDZYKPAtPZEAGIB7GDGmDri8apYDRsPaW3U5cXPSSAGwE2xqCeo664c
	nhA==
X-Google-Smtp-Source: AGHT+IF/BI8kEVlpQVhtsp62I/g5/LcFGmnu1XOI6yR8URZA5R+AeHtZJCX5j12AxQVdz9UE0xXimFVwsAM=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:f80d:0:b0:61a:d161:ff8a with SMTP id
 z13-20020a81f80d000000b0061ad161ff8amr458565ywm.1.1713442912458; Thu, 18 Apr
 2024 05:21:52 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:21:49 +0200
In-Reply-To: <20240412.soo4theeseeY@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com> <20240405214040.101396-9-gnoack@google.com>
 <20240412.soo4theeseeY@digikod.net>
Message-ID: <ZiEQXXXJnSiHrK1R@google.com>
Subject: Re: [PATCH v14 08/12] selftests/landlock: Exhaustive test for the
 IOCTL allow-list
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 05:18:06PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Apr 05, 2024 at 09:40:36PM +0000, G=C3=BCnther Noack wrote:
> > +static int ioctl_error(int fd, unsigned int cmd)
> > +{
> > +	char buf[1024]; /* sufficiently large */
>=20
> Could we shrink a bit this buffer?

Shrunk to 128.

I'm also zeroing the buffer now, which was missing before,
to make the behaviour deterministic.


> > +	int res =3D ioctl(fd, cmd, &buf);
> > +
> > +	if (res < 0)
> > +		return errno;
> > +
> > +	return 0;
> > +}


> > +TEST_F_FORK(layout1, blanket_permitted_ioctls)
> > +{
> > +   [...]
> > +	/*
> > +	 * Checks permitted commands.
> > +	 * These ones may return errors, but should not be blocked by Landloc=
k.
> > +	 */
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FIOCLEX));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FIONCLEX));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FIONBIO));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FIOASYNC));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FIOQSIZE));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FIFREEZE));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FITHAW));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_FIEMAP));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FIGETBSZ));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FICLONE));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FICLONERANGE));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FIDEDUPERANGE));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSUUID));
> > +	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSSYSFSPATH));
>=20
> Could we check for ENOTTY instead of !EACCES? /dev/null should be pretty
> stable.

The expected results are all over the place, unfortunately.
When I tried it, I got this:

        EXPECT_EQ(0, ioctl_error(fd, FIOCLEX));
        EXPECT_EQ(0, ioctl_error(fd, FIONCLEX));
        EXPECT_EQ(0, ioctl_error(fd, FIONBIO));
        EXPECT_EQ(0, ioctl_error(fd, FIOASYNC));
        EXPECT_EQ(ENOTTY, ioctl_error(fd, FIOQSIZE));
        EXPECT_EQ(EPERM, ioctl_error(fd, FIFREEZE));
        EXPECT_EQ(EPERM, ioctl_error(fd, FITHAW));
        EXPECT_EQ(EOPNOTSUPP, ioctl_error(fd, FS_IOC_FIEMAP));
        EXPECT_EQ(0, ioctl_error(fd, FIGETBSZ));
        EXPECT_EQ(EBADF, ioctl_error(fd, FICLONE));
        EXPECT_EQ(EXDEV, ioctl_error(fd, FICLONERANGE));  // <----
        EXPECT_EQ(EINVAL, ioctl_error(fd, FIDEDUPERANGE));
        EXPECT_EQ(0, ioctl_error(fd, FS_IOC_GETFSUUID));
        EXPECT_EQ(ENOTTY, ioctl_error(fd, FS_IOC_GETFSSYSFSPATH));

I find this difficult to read and it distracts from the main point, which
is that we got past the Landlock check which would have returned an EACCES.

I spotted an additional problem with FICLONERANGE -- when we pass a
zero-initialized buffer to that IOCTL, it'll interpret some of these zeros
to refer to file descriptor 0 (stdin)... and what that means is not
controlled by the test - the error code can change depending on what that
FD is.  (I don't want to start filling in all these structs individually.)

The only thing that really matters to us is that the result is not EACCES
(=3D=3D> we have gotten past the Landlock policy check).  Testing the exact
behaviour of all of these IOCTLs is maybe stepping too much on the turf of
these IOCTL implementations and making the test more brittle towards
cahnges unrelated to Landlock than they need to be [1].

So, if you are OK with that, I would prefer to keep these checks using
EXPECT_NE(EACCES, ...).

=E2=80=94G=C3=BCnther

[1] https://abseil.io/resources/swe-book/html/ch12.html has a discussion on
    why to avoid brittle tests (written about Google, but applicable here
    as well, IMHO)

