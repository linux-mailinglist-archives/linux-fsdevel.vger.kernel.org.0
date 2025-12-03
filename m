Return-Path: <linux-fsdevel+bounces-70610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A3CA1DF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 23:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFF893009F95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 22:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F02E1EFC;
	Wed,  3 Dec 2025 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkJGw5ZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846D1F3B85
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764802484; cv=none; b=kp+vlYCxLEK6VK2r5vwmp7/dVpJ+yF8e2TMjwmhi2BpVmbZJ9c+0ctFTGwNEXKgnMgxpnsqnLLlDFCz8x6m8XN5F4rvplF2Czy34ydY6BT6etWKMyqK4FpVntk2wDBl9WunZGuJg7rUaShSbhpu/q0YABi1KD6ErZDDAC9zGGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764802484; c=relaxed/simple;
	bh=6tJGWZZCoO+r0gC7HnwLMzkrop1h39jLGGfXFY4U9UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4dvgqM2iNK0bg5cuBdf2mzGsE9NalsDZ36hwvfe35eIFHfKg3inFvOG0+foMV6bdb8XeSmIkhfKd9YLK2uvnq5vd89hzOQLHlPuT8PwErJY8PfRF7q77BwRj5kAo3Dv7sJJU0xV0Km2tgqzzNHWQbmK4vtiGQXhhkyvBVzWdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkJGw5ZV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed75832448so4445431cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 14:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764802481; x=1765407281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibbE6G0sj0VXpSJX096wxxY8pg0SLImHUCWhfoJU+Lg=;
        b=NkJGw5ZVpc8kHb7Dq7RtWlL7X5I3IUTDvBVJIC5Q96Y+a+ZA/jav6lxypkRsnwG2N8
         ceVnFnMwzIJnAzQRz9LPx79UOFaEIs4vu/k3pRTZtg8+Rk3Z61jaltvrf6L2TZAw+6ml
         lKcMioB6IxhAW2UGnGg9sSBxYgb17hVkwKAmac/OQwQMIkHuC2hqviq24Tq9jFYQz5Om
         pefxD0X6rutmDeOj7qwANIDPvkHVWU8EAvNZ4MMKykWTE30C6MFvZzVUMLTqJw9WYLzA
         1XFXO3nmgV7BUD9zZ2zXV2cnmRy2QTntqPxmqw8JljYzf1StlabzA93d1GQR8CrExJYt
         IwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764802481; x=1765407281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ibbE6G0sj0VXpSJX096wxxY8pg0SLImHUCWhfoJU+Lg=;
        b=F7D0TQXXEOztFrcwDGR7igZRpkM5/1Vui9bKPOufKfqWM1p2ZirI5khiqcYMrW3KAh
         VR8f/RmgT5xba5mu8bYJSHrPaIb0/aGvlZLPa5Zd4AQZtqGS5KIDdpoQeRO4/nuh7/7u
         SFwtl9uvLlI2yr4bVCwHYtm4nxCRABJSMKzavQCIMHttUS57eQX6SpFFG1sfa0zEQUu0
         nsNxMyc8DHOFHQqgAgFBcBmJIRG95GqviB5h5CLd3eMcvfJtTY1YzE9fBPGv4gfHLRz2
         xTEnjmr0zO5JOonLIln+gR5V6QtIiuzM1bBJB4gQAsoXZMXnuGPxEncNxeetBC3J0QQ9
         LVPw==
X-Forwarded-Encrypted: i=1; AJvYcCUHMI6Q2mMoboHtxlN+xwbiFQ17Kanlr3+ZFkah27q1vvCHFzVGw6MLW3Qc82ctrodwaPZe7nA1eGW1s2ra@vger.kernel.org
X-Gm-Message-State: AOJu0YwXK2X723kze1FA/g07wD3X1BfEUaw+0QqWV0XvV8UEp8bpHVf0
	9k35BAHciES1ED0CujnOKmVn2wyyv9Idmc3ON354uUkdZaCE/Fc5O4VEMoZDSIFFHYgPw8BGgWg
	UDKxfNI4uZVuvADb8SF+C7GVFiw3QV/I=
X-Gm-Gg: ASbGnculAdffTOigW/sYfGOpll6u7Zl7AMneO4nTdxfO14mcEaXGBVkLECt6fki7eu9
	+QAHwvxZmvAnQiXGd5zoNEh7tBAgw8Ipg8xvFoKlcrQ0Dtx+38UfMGxUYmkVDcDMiWwag8Itp6O
	La1ulsrFZMbkqYaWFXiKLpfgCfOS+tSSoeRgLx/wENfzfdftLsenFQmbdzr0oc6TUx7cfJ1rNp0
	B4CDYSlUs1nn2AzIySJkjrODR11
X-Google-Smtp-Source: AGHT+IHJsViZkMTmCBMxoi5TkpMIEizyyeWGbzB4REIEmL3aB1T868RfMi+DH6hVro0JfQcSeaYFGLbzFktIyTi9l0s=
X-Received: by 2002:ac8:5d92:0:b0:4ee:1e82:e3f4 with SMTP id
 d75a77b69052e-4f0176bf57fmr57600061cf.64.1764802481157; Wed, 03 Dec 2025
 14:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
 <20251203003526.2889477-15-joannelkoong@gmail.com> <CADUfDZrtOdabnxd5x70gN5ZLWj=nQNhwezTfs_0XN9kuDAVsQg@mail.gmail.com>
In-Reply-To: <CADUfDZrtOdabnxd5x70gN5ZLWj=nQNhwezTfs_0XN9kuDAVsQg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Dec 2025 14:54:30 -0800
X-Gm-Features: AWmQ_bnQJaV1Fc6Bw1dt0qhqIMTFKSwQkPyZv7clpAmFphuLK1jEqjgX5JFvHyQ
Message-ID: <CAJnrk1be1WaZ-WBgpSu7m0K0=4xtwPTt2jvHOz3DECoW=tn9zw@mail.gmail.com>
Subject: Re: [PATCH v1 14/30] io_uring: add release callback for ring death
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 2:25=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Tue, Dec 2, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > Allow registering a release callback on a ring context that will be
> > called when the ring is about to be destroyed.
> >
> > This is a preparatory patch for fuse. Fuse will be pinning buffers and
> > registering bvecs, which requires cleanup whenever a server
> > disconnects. It needs to know if the ring is alive when the server has
> > disconnected, to avoid double-freeing or accessing invalid memory.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring.h       |  9 +++++++++
> >  include/linux/io_uring_types.h |  2 ++
> >  io_uring/io_uring.c            | 15 +++++++++++++++
> >  3 files changed, 26 insertions(+)
> >
> > diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
> > index 85fe4e6b275c..327fd8ac6e42 100644
> >
> > +void io_uring_set_release_callback(struct io_ring_ctx *ctx,
> > +                                  void (*release)(void *), void *priv,
> > +                                  unsigned int issue_flags)
> > +{
> > +       io_ring_submit_lock(ctx, issue_flags);
> > +
> > +       ctx->release =3D release;
> > +       ctx->priv =3D priv;
>
> Looks like this doesn't support the registration of multiple release
> callbacks. Should there be a WARN_ON() to that effect?

Great idea, I'll add that in for v2.

Thanks,
Joanne
>
> Best,
> Caleb

