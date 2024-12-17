Return-Path: <linux-fsdevel+bounces-37639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC09F4DEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 15:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6048818917DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142081F5402;
	Tue, 17 Dec 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kBh1Ct1U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA22AEE0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446175; cv=none; b=eKeLbdtN982fcCWzbFtyh+BKfunx1S9ft9FwxxSdpcBWXMASbLHAwEaQRpKRQuQafnbD4lWrFkGsR7tCnNesMNyfFednqvMtuACgZfboHKSxF7xkt2wu1l1xckyzxA53xslXfdyjH+XKvUVv2qal1tQHPR+teFnXLhQ0L3IHiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446175; c=relaxed/simple;
	bh=mNN4jwwOSEVrcbdPxCtxzgpwFbcuBCdAfH2BmGb/xXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUMUEObi+ZACmf46hfaX/+gVeo4noZD5lXeegImTehesKj73BQNXmbfJOk1RLME9BCAPXWo4hriHF/jnpJ0cTHcoVM7py+IcbuQkKZt7+iyJEe06mKdWbGczRD5wOm1p2F+ByTHGk6HM1ESz//v1T/Ly6Ot2j4V7XwrFPzWhEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kBh1Ct1U; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46677ef6920so44307131cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 06:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1734446171; x=1735050971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mNN4jwwOSEVrcbdPxCtxzgpwFbcuBCdAfH2BmGb/xXo=;
        b=kBh1Ct1U8FVyAlnYcLAQNkJDKBSz5HGrVbjDXVtqaJPSpzXLboOmcDk3GvKwsypxDV
         FqDLowEao0uDrTqmWxNDHqOPtAXd86oReeI+F5qHxDSAEE/Q5xt51E5B6NQ32D7/5oPd
         DGoArmjJ7STc7kqLOR4g/X2zn+RfDGoEw8L/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446171; x=1735050971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNN4jwwOSEVrcbdPxCtxzgpwFbcuBCdAfH2BmGb/xXo=;
        b=HHpYStI+MS4q/Z2Rb8SZfRFpiGUN8IP4zzQI4uhaI+rQ+Bf6aTR3d3/UL1cBZHHu9S
         oW78IDzF0BlWHBVFSL3d+mgmVkMCik/oTO0bDk6zTP6SEUwyVGzYJoUkNtLZN7G61ZhE
         h1GqU49QYNV7gW/NX6ZEDaEhaM0V8DiavXPzKX77xiD2wyQShUBSe3ap8qHXmkIaFiW6
         MxlGudRwHttW/4MiSU8PJ0X48u6x4nkmm4ybFDBxioriMNSX1ElgaZpvzFbcDiW9n2fY
         dnA8oLMUS+Gvj5ginsrxtfJbz2CczhIzsyL9tq9B4jBB3yEQ1mB2sPHXlpwiPhi9Qx04
         3rkQ==
X-Gm-Message-State: AOJu0Yx0VNle9SN/U0kGH2NiHQB4Awox9R59uiTpNLwn3HzWCVzoDuuk
	eqM7vuDQJIbi448pDA7ml7ccRiwsxLwJee7C5Ijdw3u2gS9Q3YFHD2ArRK/B6xHSBhZHXQ3k7kY
	gpLcUDz5kodKj2U9MrZKJOpe+2e+WynP/vvLYfg==
X-Gm-Gg: ASbGncuyGkl0qLxPyURNSYoqowg/xY+Zk+q6r2iphEKk7DR7OT1BJ9cuXxupNiTFXhF
	D6OoHk7GImt3EQaxJ4FdrAMfn6pGnEc1bOtWyq/U=
X-Google-Smtp-Source: AGHT+IG7ob/krk3VSKgX2ZFbnnJAHNGtXmOBbv9yAKHwh6bte/nEHrBcvvPrckuUU9LgtFcScAjnBgW0vCBLFQNGtYY=
X-Received: by 2002:a05:622a:15d0:b0:467:5cfb:bd40 with SMTP id
 d75a77b69052e-468f8dbed13mr55283791cf.19.1734446171567; Tue, 17 Dec 2024
 06:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-erhielten-regung-44bb1604ca8f@brauner>
 <CAJfpegsn+anx7nHQbD7HCf301DyvaWqg-pAi6FUAgfhGLiZurA@mail.gmail.com> <20241217-tippen-medium-cae7a909222c@brauner>
In-Reply-To: <20241217-tippen-medium-cae7a909222c@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Dec 2024 15:36:00 +0100
Message-ID: <CAJfpegs9YZsrmRfea1pOL2T-r4RznrrogbQOoj2+3v2TQumDYQ@mail.gmail.com>
Subject: Re: [PATCH] fs: use xarray for old mount id
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 14:52, Christian Brauner <brauner@kernel.org> wrote:

> Right now, if I mount and unmount immediately afterwards and no one
> managed to get their mount in between I get the same id assigned. That's
> true of xa_alloc() as well from my testing. So I think we can just risk

Okay.

Maybe worth a mention in the patch header.

Thanks,
Miklos

