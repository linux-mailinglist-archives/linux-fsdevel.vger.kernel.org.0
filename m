Return-Path: <linux-fsdevel+bounces-29356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BA5978810
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 20:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5E71F26110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79A12DD88;
	Fri, 13 Sep 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="18sqBN6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00B86AE3
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253035; cv=none; b=uZosY8OKuztu1FTiOZXSKrV+BPimvqctqEZKKPUlh1OQb2+2mk072Ek+cGMrMLRrdIjjZh1vWu3OeOoQnj9LO8KH6SJqERePtf3IMkrf8hVFREmTbXBYazSpIirQ35UDnBNyj6KwtcS1FEfgP2PXoIlz5xOkvGyZcTShR9p34t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253035; c=relaxed/simple;
	bh=9s3J+nIBRdpOtQXBcXpxwGEerq2F+ZsriMixrlq3mRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUtKvhpVlsjjy1PGFtbG9LO50EdnexqihdbXKCPW1lDE313N7h2nhNo9oyE/KkWEV2IP32UEAwP8aHW6MQQKx1nzC7k6CPRNM90eG7Wgvb+8bNELDYyrL5hPzWssIdbUMi0xTPKsk6eQj5CPioaerkD+ylcGjyJRogirfsqA5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=18sqBN6J; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so305083966b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726253032; x=1726857832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh0cDYgrNGGBdJnqeDTLCxWrLu1MGS9x+B+damV6xt4=;
        b=18sqBN6JZL77j+p+mBBKs73UjY8+XiVy+G/p5mDDC7YhnL5LKGbdidQISCfVkVMuin
         rxQFj8i7S2X6zYilPkRlxK5ICpbd/sWgEt16SeTytlNFXrx/AoHtBovU1JOjZCwlHgXZ
         USgBxJG5hOjZJKgX4PYMZFtgfKeCkiXFF5RGV5qPV00AYScWaD0/wPQwQQiVxxy2H/Ib
         OBheKeQz0LmYIAkW7YPVZ2hYloF5SOBssbe4BPWs+GYL2AcgUBPuDVMc2szBvoCmv1Y/
         3be77vgmAaDQme7IR8KJ7G6ySsCxgyERIDpqD0BKCU4eQ8tGpiFdLy0EiHTbBOb9BrIQ
         RWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726253032; x=1726857832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh0cDYgrNGGBdJnqeDTLCxWrLu1MGS9x+B+damV6xt4=;
        b=EVBopsL/72+lAiu6y4ZAPZvvKqaXaikx46IlpANXoooSILl6miTDS2ks9UliiqtPae
         MWwIMncVwOFMVXkL94DCw0srj0hZpYhMbQK92zZ/sz1q92MPrW4ZN1o0XHM+3sIMZHAM
         JZVre68+xAG2C+bOxtKFhfR5zFheJ1VFuEaVK07udWtDQhpyIZxd50wsW4oLjI/FY+m6
         2hiTHB6uy6JtwchMJ1thRG9uXfR0PrLH0f8yQ583bm6lUqp4VyLyRKFpnv6rcjzwTTQn
         Z1zNXfeqpueYQPyRru9MeeFu1zrifh3QmOJzqp+fxsV+ZlYwpGESTJMYRg7Uot53go4r
         mZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCV+nf4E/rqvOTQxJyUIlbUfsT/HD9gCsz/8L79VuVwniBJT7N3qfqDjkPn1xqmOmR6ZqCQW7NwQAQNdxXXu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/s+duU0CqYvxgU6y9SxIxMOFpiVnbJpnmejxI5bkP8wIFgiFp
	Im+YdpsomCRz80TdRKVPnQ76d9mHTT8aOE2y6f3qira2HL42LrlaGLhrjwTik239evsRo063kt1
	XrJCaWoCsad42HlTFzX+93DMWeRqC5Qe6f8M=
X-Google-Smtp-Source: AGHT+IECxwpd8EHiWIoIdYDsW71IpMx5pRA77Ps3QOkH/SLAqTQwBC0Yvb2+gmKvMDtEpMwkL3eel78xWDnaUYcPi2k=
X-Received: by 2002:a17:907:7fa8:b0:a86:7cac:f871 with SMTP id
 a640c23a62f3a-a9029671603mr585172766b.54.1726253030511; Fri, 13 Sep 2024
 11:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org> <20240913112602.xrfdn7hinz32bhso@quack3>
 <bfc8fc016aa16a757f264010fdb8e525513379ce.camel@kernel.org>
In-Reply-To: <bfc8fc016aa16a757f264010fdb8e525513379ce.camel@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Sep 2024 11:43:37 -0700
Message-ID: <CANDhNCpBpBFrwu85oozKNW0N9_FzYXdpDbmX9sOnT_2oCGDeFw@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: move multigrain timestamp floor handling
 into timekeeper
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:01=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Fri, 2024-09-13 at 13:26 +0200, Jan Kara wrote:
> > So what would be the difference if we did instead:
> >
> >       old =3D atomic64_read(&mg_floor);
> >
> > and not bother with the cookie? AFAIU this could result in somewhat mor=
e
> > updates to mg_floor (the contention on the mg_floor cacheline would be =
the
> > same but there would be more invalidates of the cacheline). OTOH these
> > updates can happen only if max(current_coarse_time, mg_floor) =3D=3D
> > inode->i_ctime which is presumably rare? What is your concern that I'm
> > missing?
> >
>
> My main concern is the "somewhat more updates to mg_floor". mg_floor is
> a global variable, so one of my main goals is to minimize the updates
> to it. There is no correctness issue in doing what you're saying above
> (AFAICT anyway), but the window of time between when we fetch the
> current floor and try to do the swap will be smaller, and we'll end up
> doing more swaps as a result.

Would it be worth quantifying that cost?

> Do you have any objection to adding the cookie to this API?

My main concern is it is just a bit subtle. I found it hard to grok
(though I can be pretty dim sometimes, so maybe that doesn't count for
much :)
It seems if it were misused, the fine-grained accessor could
constantly return coarse grained results when called repeatedly with a
very stale cookie.

Further, the point about avoiding "too many" mg_floor writes is a
little fuzzy. It feels almost like folks would need to use the cookie
update as a tuning knob to balance the granularity of their timestamps
against the cost of the global mg_floor writes. So this probably needs
some clear comments to make it more obvious.

thanks
-john

