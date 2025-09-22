Return-Path: <linux-fsdevel+bounces-62375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C0B8F9F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0543B1F5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DCA2BB1D;
	Mon, 22 Sep 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Mu5Pyz1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5C267AF1
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530742; cv=none; b=f6/m/ddhxD7UN+jYs25PLyOSPzyzVYaN6XauNDocYkEdbZExqMSA/NMRWmD2NbFsx562ByJzKJ8x9FcFeNMRRw2f19H1SbUgPOgV941GPfhYUPYH1g5KEOS5DzqLlEKTdK7jwXDLsFmltFPsT9JyLrj7D321yg+QlA8yCqGYhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530742; c=relaxed/simple;
	bh=Mu4y5suevRJy30ykD9+xVLAZ13ULFsP4n3z47D7tFlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqUItaR85O0jek5f5IvbBPelvgh9KjeRMc1SfiBLw+Wvh8v7ERM6dSgLT3Rgxw4nDxGbLWobT5O8u7F7uVLAKurMTzk+yMAY/w8E2l8s9/n/BLO5L7GQle14PUR5f4kbzYuqZuxeO8BaR129dNH6EWM4evSQwzZr9gO6/xuApoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Mu5Pyz1p; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b7a40c7fc2so65293271cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758530738; x=1759135538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s2XqFjlLJYc4g5wzl1cmBCWkanojaJe6UBKMzLm4NHk=;
        b=Mu5Pyz1p8ISlNaSgbgTvK5Mqi4xrSsnwopiZQkXvaMJP02j9i2r74itMDp7OxnPjSM
         AyJz6jlAjd1qNdcqG1qJGlbSWfV9HE8c1YOWxZ100VV1M4Rxbxbt+BKQmhR3wewQRJUh
         fQW3s3G4xMgjRVMLxObLjPhjOxFXgmsNJiNj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530738; x=1759135538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2XqFjlLJYc4g5wzl1cmBCWkanojaJe6UBKMzLm4NHk=;
        b=fMrfoPSLHJymTcOZumNyxv9kXN5F+ZiK6enQnqXOXYCVJhq0dx6h/vCoWKqTpF/YOG
         VYx9DFg0cXsJmVzTGNnz2/T0XARltzoYQW3lrnzfCr7WhxATZHa+GVyQPrbAgx6lTio+
         1OBBtIcuvCPLTN/TGMPBhdYKb/lISGL8fp/lwqVZ3n1ds1eYw/kjfg3rMHCd0YNoKT4Y
         Q6e+DZhuTSDzRAPGUTBh8UUOwior/d3xzIUeTANRNATQzT2rk1w40ugKpOAPntD3yR2l
         LzbXKL5TOsdJCrJQt9hMP+e9DZK3X6u86ROiNVdLgQHrGTq+PW2ZqeQlec1WUDTwstQo
         Pr4A==
X-Forwarded-Encrypted: i=1; AJvYcCXd945YWvkpcUSNNxGda9GQWqJBJkKsO188pyTzGmCfbdUl2mpCSk5zL53SLzEsYsUf5SiMoe8clTO2FPVJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwyiYUF0aDXZbfCz2C1M+9O9MqpCGrCzn17aPQPo2sK/Q0p/f91
	7r4q4av9q0QfUtP8ApsmXmSh04wu6aL8e6kkYroKr17Ni5lnBQpsJ/D5okQ55VxFCkQfVsv8HUx
	xt/LpmVGkflXoqLErn+bogPbCnlzMDI4pEgE73QpfMw==
X-Gm-Gg: ASbGnculi+VIjvRgQKSIs7HXYL5pm/MnufX+ods33Hi5vjb+Y956425+ihakfVV6vWR
	LzAf7xMTf/sVZ7WYyQAO/0sFVgs//xd9ZZJ3z4uZUPYuP+nNKXCrMiv5gKEzvgzbhxk2QBr5bHc
	k0Vlnlg5e4SSI5ov+VJ7CbMxW8qSrkk83Rf8G1XGTagz7AoNv5ogCKVDRofAHhbEKVhR8N1ylJC
	3GDCA14EdLNuRb38dLrYyn03JRV/6xHl90ZSiA=
X-Google-Smtp-Source: AGHT+IFPJz6G55c5Wc6N3Myge8pLH2ISy43a7i8nddhLDRmtAbaYcNMa1nhfCBpNmT2BvmmGL1Zb/MELgHBd1Dyzo5I=
X-Received: by 2002:a05:622a:5148:b0:4b6:24ba:dc6a with SMTP id
 d75a77b69052e-4c071cd0a4bmr156740781cf.38.1758530738028; Mon, 22 Sep 2025
 01:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919081843.522786-1-mszeredi@redhat.com> <175832640326.1696783.9546171210030422213@noble.neil.brown.name>
In-Reply-To: <175832640326.1696783.9546171210030422213@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 22 Sep 2025 10:45:26 +0200
X-Gm-Features: AS18NWAgR8A4O9LJ7yDqbIk272RJJ4YBxmhwQS1GbzCGc8A9ZPCOCsor0ATnt0o
Message-ID: <CAJfpegvikkRip89GiRnd1yp_xD5EvTtAjtMgV_ak5znGj0tGDQ@mail.gmail.com>
Subject: Re: [RFC PATCH] namei: fix revalidate vs. rename race
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Sept 2025 at 02:00, NeilBrown <neilb@ownmail.net> wrote:

> However this change means that the dentry isn't invalidated where the
> code currently expects that it will be.  i.e.  lookup_dcache() can
> return NULL when there is still a perfectly valid dentry.
> Does this matter?
> It can only happen when the parent isn't locked and when it does happen,
> current code will lock that parent and repeat the lookup.
> So if we simplified the change to only call d_invalidate() if we have
> the parent locked, then that will almost work.

But why bother?  This is a rare race, optimizing it makes no sense to me.

> The remaining gap is that directories can be renamed by d_splice_alias()
> while the parent is locked shared.  I think that is a different problem
> that would be best served with a different, more focused, solution.

I'm not even sure anything needs to be fixed here.   It's not possible
to fix the "race" between revalidation of old name and lookup of new
name.  At least not in the VFS.

Thanks,
Miklos

