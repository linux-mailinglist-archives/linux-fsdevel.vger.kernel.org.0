Return-Path: <linux-fsdevel+bounces-13605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288AA871C8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 12:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9381C22CF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA205A118;
	Tue,  5 Mar 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GukJuJeO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57A59B54
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636268; cv=none; b=DxnwCycyFNhYtqYTcueZJT7KRmCY82v1MWiKoFZR+S+/aIaEWMY9vYUeo+pHMq5zfaFAOSPwDhlGtTkV6H259FTTalbXFVOjTGQ8w4/M1ALya3l1yvhOcHS1xMFYQl0zyf9g4wL+f3SUTskozucJT/fjgdL90pV3+FLS3GlakJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636268; c=relaxed/simple;
	bh=W5nH/t7VJIrVAtMF9iJfdBXs0AEjnwK0LP0IMVBjv4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drL6w+6TUOo4r/rRlIwYqudfCDqL/kEwis++9vVT38ZCOcCXC8gPX339YkOlfn1sj2Q4R2qj3tOzs6s9Mrv5dqITFauKkbRbhHvpzaZlFyUGVlMHRvX2fKjf6rVqO/30BkxlGBodbLIcBKSinEtFum0x+7DxKf9plhScmLrv6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GukJuJeO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4429c556efso739645566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 02:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709636263; x=1710241063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVi6jrroLkoTY6YGhLQ6aIfOlmKSMEPfeYKlERsXkgU=;
        b=GukJuJeO57+nuOQCBYC5yzqzWOeoFOYdnHmuRy6YumVG3YCoq54ThwMKFdUU9A9l/0
         JaA+2aVyzZq93a9wkibmEjPILyEze7RAXYJ5pmE+gdIEM178G+PeN3jBlDW0Rxu00qYJ
         TE4nFH6DNTvyhwT2cQ6H8H0Iudr2lJDPMuZTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636263; x=1710241063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVi6jrroLkoTY6YGhLQ6aIfOlmKSMEPfeYKlERsXkgU=;
        b=UPXY+Cg9zVP4sAh0+TgsXqLnWVXUSU8d9PnABzHf/kd9ORQ/mw6szh2tsTP+LPjvDZ
         l8DbrJso6ZPlfhq3BiH+6kH6yfMMnWFTsUjlTg+wtiFTPSf3sarp6/Sb3LvxCxQmPOQa
         wCMpi/1cG230Vp8UvyfvXup3TUutJPSYSvlCOlM2mpdXyBirbC/nM7/U+/rMvlWmsxlh
         Z7sJFAcQB14gYDWoxrhcZRyn8CggA+WYZiHlZX8yz7jPYsg52nnl0tm1OvdagQHIjzPt
         PfcGT8vGRKxlWej90+B+oJyRO21p+tdDXRGAHz9I5Rr6nRyxyU3W21hrJdO2zJAZg+ZY
         4fXw==
X-Forwarded-Encrypted: i=1; AJvYcCU0dU04cec7KgSC+JOJ3JSgQcsrSTHsw4X63nUyrX2QhcbWDPlH6xtb33vOTAb7AE9LX9q2FVqlUreQS8wS02+prawS8ezb6tFAN32LrA==
X-Gm-Message-State: AOJu0YzbiWrEvqJ9X5sFttw1mar/SxmahOGdWV3ANWbTrTDrpNvjpt9g
	8BIMHJzzNcj4TLwSiwNBCE/YrBdAo/Ssq5YBRPCr5qidA5BBvv2/baigapV2PmLRwZ51zu9IhTt
	iSSLvbdWLoJdGQzddK/B65GrKX6R+8vsx9CnvXlws2s0gX49f
X-Google-Smtp-Source: AGHT+IG8oj+Yyr+aeyaK7vVIVdQXYY3lp35///+Neq/VmWJaAPckYCAKH9/0vHtoiwpcD1wnOtLtmZIGyS4+KHMjDG4=
X-Received: by 2002:a17:906:2411:b0:a44:2636:9965 with SMTP id
 z17-20020a170906241100b00a4426369965mr8189799eja.29.1709636262943; Tue, 05
 Mar 2024 02:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142453.1906268-1-amir73il@gmail.com> <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com> <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
 <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
 <CAOQ4uxji-yzWFeQYP9FKvVXg473GP6tC2pyHUbEPoYxT+qDYsA@mail.gmail.com>
 <4e3d80ad-3c61-4adf-b74f-0c62e468eb54@kernel.dk> <CAJfpegsAs3V8jU2UWyJUB33FCbmoFiOSp9Cjzrgc9+XcomN0Uw@mail.gmail.com>
 <20240229-ausrollen-verebben-ea5597a9cfa0@brauner> <20240229-stochern-fachsimpeln-ad8227434069@brauner>
In-Reply-To: <20240229-stochern-fachsimpeln-ad8227434069@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 11:57:31 +0100
Message-ID: <CAJfpegsyGwuVq_b4ytwr3wYYNri7Yedn+Fkoof=bCNJf0bcdmg@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Amir Goldstein <amir73il@gmail.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	linux-fsdevel@vger.kernel.org, Alessio Balsini <balsini@android.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 11:17, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Feb 29, 2024 at 11:15:35AM +0100, Christian Brauner wrote:
> > On Wed, Feb 28, 2024 at 04:01:17PM +0100, Miklos Szeredi wrote:
> > > On Wed, 28 Feb 2024 at 15:32, Jens Axboe <axboe@kernel.dk> wrote:
> > > >
> > > > On 2/28/24 4:28 AM, Amir Goldstein wrote:
> > >
> > > > > Are fixed files visible to lsof?
> > > >
> > > > lsof won't show them, but you can read the fdinfo of the io_uring fd to
> > > > see them. Would probably be possible to make lsof find and show them
> > > > too, but haven't looked into that.
> >
> > I actually wrote about this before when I suggested IORING_OP_FIXED_FD_INSTALL:
> > https://patchwork.kernel.org/project/io-uring/patch/df0e24ff-f3a0-4818-8282-2a4e03b7b5a6@kernel.dk/#25629935
>
> I think that it shouldn't be a problem as long as userspace has some way
> of figuring this out. So extending lsof might just be enough for this.

Problem is fdinfo on io_uring fd just contains the last component names.

Do we want full "magic symlink" semantics for these?  I'm not sure.
But just the last component does seem too little.

I've advocated using xattr for querying virtual attributes like these.
So I'll advocate again.   Does anyone see a problem with adding

getxattr("/proc/$PID/fdinfo/$IO_URING_FD",
"io_uring:fixed_files:$SLOT:path", buf, buflen);

?

Thanks,
Miklos

