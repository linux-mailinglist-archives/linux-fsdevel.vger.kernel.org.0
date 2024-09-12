Return-Path: <linux-fsdevel+bounces-29212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AA497729D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 22:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAD4B23070
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9D81C0DD9;
	Thu, 12 Sep 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEh2Oiyl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779C1BF80A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172163; cv=none; b=oqA3LCZu1OwpF2mplLOJeiGCswUEaCvN4sWLisuEqj8v65PA0wUn8T1pMBH9ZXSI5MzMV0UyHPdXSFREBp9rDfA9kzwuLXto4WqpqcdQUEBUOWiZ+le1hIsWLzgmXJ058JfqVLyrX3bXVrSE0Tos7NRf88bK/OMJ/9AMNI/6BEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172163; c=relaxed/simple;
	bh=hHoQQyYyg4nYi15hTtxasl5id2V0+j+p7ZvGXRW5XH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnRxqymJdRIcE7zfd/QFQuV06dpHklq70yAUfc5hLhujxc/RNOi4a7fNVV8HxBYrfR+NQFlpSkeWWdRh4dO+DHRg/RZd0TX00maZvrQyK9nE3+8ML+XVAJuzEWhmYw4Ip3xBS3ge3CX710UWdYcLwbatTV2TJ5MKlXq7a5d7dKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEh2Oiyl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365a9574b6so379005e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 13:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726172160; x=1726776960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OcTdr1oD21bDFlWgrDP94oUO7BjSI12VKiNlN7J8IY=;
        b=oEh2OiylrfGxB8wzckgyh/y5aUB20gsmcd/VLuT6Apr/WYfO8u1ZaLEJxGvwiJncNo
         JHfL71OA10rMLkq6M4C0RKo55Rom9IJJ5RcXhX8HkBQamUMILVKMruvbjb/Bc8stlwnd
         ALMQWBG5MLT8dwK3PlaxvEzGqRikTHj2o2z5lQYZCMKMLedhQDVlAGROqdRSK/DhTTyC
         /lb+eGCMQKUQZQWSfHZM+JyGbCG4jpWL3AvL5Hjp4PgEXDP8XRN6Ny6eisqQwdRlDsnB
         OH5ccONZb9NCLqhlpxgMFzuL9LL6TRcY50CkM+PNtJ74wUF/kWnm2aIKCnHDsy8dxAGL
         WFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726172160; x=1726776960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OcTdr1oD21bDFlWgrDP94oUO7BjSI12VKiNlN7J8IY=;
        b=t+nZro0d/D+H+ptXrj21NpnJSwrC2N5nQyWd2WBNyzERsTxjIFBCfhpiB++N9pSEZ8
         Lyut/WZYjBqk3TAkrJf6YFIk+eNN1JS3p/B5D55Q74V0HB35rzgQrAGWlBHvxDxFCPV6
         dzwthvRGOgFM8mDSCTdOesuwVacT5uIml4qI0DKutfZ97cJnJ5MSSEF2hxq4x5GRFLUx
         QButsDeS46tZZ/uLAwa3yys7tjux1hdWxXPHo2ipfAWFTPyEYJ2JBDAjBi0w+NxI12JT
         lhDnORWEYAxRVsPZ8iPZEbBgYgzu69M5h1M7+5YsHAnTwhjk7YFj2fZX1w3LXhAZDzgZ
         0MDg==
X-Forwarded-Encrypted: i=1; AJvYcCVuG8axOv9AJdA2WtmUfWpe4yJCsDzasWGZiAZEYZy6NIp1pXXIqSIXizAkEpvMdgTyEKaciLYaaz2eSHC5@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUXxDxZcmutPndiBDZinmjNqS6BDbeowytlc/dU2FHcexkcFK
	TxN2DZNW2+i1tREaka0TMuX4L2GBI7GRWuphv4o1zcCDQ02UWzWhNGGh1+5tc7B2fO5vN2VqVx3
	tGZdUbcY/u4d6Ez4kM5RC2vvMeTXwZqsH3DI=
X-Google-Smtp-Source: AGHT+IFmGbLe7NzaH3EJuurC1RFXKVf3MQbr9jwudg2Gy6okgYnei1JNov9IGPgqos7iOnHDL5Kegj48KEr6vIYkmXY=
X-Received: by 2002:a05:6512:2812:b0:533:3fc8:9ab9 with SMTP id
 2adb3069b0e04-5367fef18femr305656e87.34.1726172159944; Thu, 12 Sep 2024
 13:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org> <CANDhNCrpkTfe6BRVNf1ihhGALbPBBhOs1PCPxA4MDHa1+=sEbQ@mail.gmail.com>
In-Reply-To: <CANDhNCrpkTfe6BRVNf1ihhGALbPBBhOs1PCPxA4MDHa1+=sEbQ@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Sep 2024 13:15:49 -0700
Message-ID: <CANDhNCrfzMZj8T-mCKd9RAF4D6-EBAtmkffvP5-WMJbgQHdztw@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: move multigrain timestamp floor handling
 into timekeeper
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 1:11=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> So initially I was expecting this to look something like (sorry for
> the whitespace damage here):
> {
>     do {
>         seq =3D read_seqcount_begin(&tk_core.seq);
>         ts->tv_sec =3D tk->xtime_sec;
>         mono =3D tk->tkr_mono.base;
>         nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
>         offset =3D *offsets[TK_OFFS_REAL];
>     } while (read_seqcount_retry(&tk_core.seq, seq));
>
>     mono =3D ktime_add_ns(mono, nsecs);
>     do {
>         old =3D atomic64_read(&mg_floor);
>         if (floor >=3D mono)
>             break;

Apologies, that should be
         if (old >=3D mono)
             break;

thanks
-john

