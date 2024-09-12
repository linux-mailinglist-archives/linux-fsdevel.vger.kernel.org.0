Return-Path: <linux-fsdevel+bounces-29216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1DF9772C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C381F2495F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CE11C174F;
	Thu, 12 Sep 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmiybILs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2118BC19
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173356; cv=none; b=YDADk1S2dY2o9Q6xgci/BcjmAfxUnWFy3aw6cVYNbf5TCcSI+isHKqIAIE2208SutXNtyd9OiquckaawrUw372Gj8zbUT4GJppQbRmaoiqj35zqpHFoeDScVdbpx/g0L5OqBpZeBw7xGIAUzFMll1/08PTvxrUM8xyJAJrW6SF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173356; c=relaxed/simple;
	bh=kUGAfoDLNCZWBTPAR+6jsLaXeg7dZKMiK4x1yTroAoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5A7LXuDo0ILJMZ3hj5FQQQ/ODYawP/mXkNJVy7eYOYJeskJo8cWtcvR8TGEisZhXCmn1QswQxGEAKO5KNreuCdrlFasPQtUqCKkhOqlnaIWjr5Bn+e0PHuAY4zSpAFhKG4mF56dk/1hdiTckJgqzfzUJfo5cRoZnSaJBWcWyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmiybILs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so1444239a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173353; x=1726778153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPyje0OHvWufuDaW/wO4b41jG4x08M2sTKOIRQm1UUo=;
        b=hmiybILsRI4JoFUPSykJ1vKKrflMOYb68xDKs4PsMs4R9cozE5e/HQdyVSK/meE2LG
         KZ8VBDgirVmW00h+mFr9//VyXj18Pexj487sVIA+HAvoOYdBeWYoDJJSxqSfLCb+zGwT
         bVS4luDIf/TH30ljpP1cQKGT6rFMDpipVRxOVUZ9E1Eudt7GMRhR5FK1n1hBtImJoPoZ
         kdMllxCJiaDJZe3+5jtW2lo6ggtsxbQ3EZJx3oX+rhqR5XCcwab/fTDEj7oBs8bjc8SW
         K96dbQsKhDKbzPPXxIQMMx1eahPHTdMjPWt71neURQ4DcSwidWw6IbCjHObmeu0M2QVj
         hYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173353; x=1726778153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPyje0OHvWufuDaW/wO4b41jG4x08M2sTKOIRQm1UUo=;
        b=qjXGR6XAX/ZVxcSAfBR4RCkz+YUIQqRbWuK2PXzmnYyU7pmKC72iZ66Fmi1NZVVYfD
         wYhkCPTctLxbMifr+HcMwq3KVRpH8EKBe3ZGEplV1ZK6y5ZxpgnziSEd3CjO+DZr+Sva
         PA5bJgLQYLwq0AECnSFWtj9V/26J8M41cRDBcHo/VwzkSZN29OvzZQDgfaPVVCYbhGCA
         0RgSQx94zn+GlADCf0Xf8ApNPKsminxSWoZRvRUpiCIrp+kKPGMl45TJHAwab8lfUcXa
         lvtpWS7aQci9/yio/VTBBk+0wE/M8Rb0g6aQ/TIHz/HOVlP0G152YjvcyzBpJBzP2H/X
         LhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhrP5s8ZpXayGRsYEslL2lCpXBgphZbIC6yojsanpK8QU8jao50GPY5VjEAQhYTEA1moH5qeGz61eWm5X7@vger.kernel.org
X-Gm-Message-State: AOJu0YxYasK4EaPzDlVnU75/c8wiN4jSipdtDplD3rOcMGeBkbzcLQhr
	qzAkoGWh5wz1NoYMwjCfjIJ1B+U9PlcIEBP+jCHFT8gyjyStz697nDvCoubvvTLgFKZPWVxtY+m
	OCNwu3WEpLqvm2yrb/rZkgpRt7k0oV6kBjb0=
X-Google-Smtp-Source: AGHT+IFxDMjHDWm3CVPkFzN+glo30yHjPLs7dO9zEs5B79Xj8upFe4UXtxGVo1AlaBPAZoJflQ3c0PrG1+DtiwFjQ8U=
X-Received: by 2002:a17:907:868c:b0:a8d:2d2e:90f3 with SMTP id
 a640c23a62f3a-a9029668262mr389551566b.55.1726173352752; Thu, 12 Sep 2024
 13:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org> <CANDhNCrpkTfe6BRVNf1ihhGALbPBBhOs1PCPxA4MDHa1+=sEbQ@mail.gmail.com>
 <80f8f49da3f7208101e497a130a8abe106b298ad.camel@kernel.org> <CANDhNCoLCbAYRtA+kjVNiTeNZg6UtCycNpNievLboXbjNU-a9g@mail.gmail.com>
In-Reply-To: <CANDhNCoLCbAYRtA+kjVNiTeNZg6UtCycNpNievLboXbjNU-a9g@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Sep 2024 13:35:41 -0700
Message-ID: <CANDhNCo-BWqpX1aWi8-q1RaAA_4KigUPcaEML6yCb2EksAX=vA@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: move multigrain timestamp floor handling
 into timekeeper
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 1:33=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> On Thu, Sep 12, 2024 at 1:18=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> > On Thu, 2024-09-12 at 13:11 -0700, John Stultz wrote:
> > > On Thu, Sep 12, 2024 at 11:02=E2=80=AFAM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > But instead, it seems like if something has happened since the cookie
> > > value was saved (another cpu getting a fine grained timestamp), your
> > > ktime_get_real_ts64_mg() will fall back to returning the same coarse
> > > grained time saved to the cookie, as if no time had past?
> > >
> > > It seems like that could cause problems:
> > >
> > > cpu1                                     cpu2
> > > ---------------------------------------------------------------------=
-----
> > >                                          t2a =3D ktime_get_coarse_rea=
l_ts64_mg
> > > t1a =3D ktime_get_coarse_real_ts64_mg()
> > > t1b =3D ktime_get_real_ts64_mg(t1a)
> > >
> > >                                          t2b =3D ktime_get_real_ts64_=
mg(t2a)
> > >
> > > Where t2b will seem to be before t1b, even though it happened afterwa=
rds.
> > >
> >
> > Ahh no, the subtle thing about atomic64_try_cmpxchg is that it
> > overwrites "old" with the value that was currently there in the event
> > that the cmp fails.
>
> Ah, ok. Thank you for the explanation there!
>
> > So, the try_cmpxchg there will either swap the new value into place, or
> > if it was updated in the meantime, "old" will now refer to the value
> > that's currently in the floor word. Either is fine in this case, so we
> > don't need to retry anything.
>
>
> Though if cpu2 then made another call to
> ktime_get_coarse_real_ts64_mg(), the value returned there will be the
> same as t1b? and would be before t2b?

Oh, no. Apologies again, as I see  t2b would be the same as t1b as well. Ok=
.
-john

