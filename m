Return-Path: <linux-fsdevel+bounces-48880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1103AB5331
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89A57B7DE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95852239E69;
	Tue, 13 May 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="In1hmpun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456523F424
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132925; cv=none; b=NdExE+bKXV8rtUMj3LpOfHQjKh2IUX9IGvS1M2XEZwAzuZbwEH6lIdxAN8zQt3wnQv+xSOZc0N5zA1U7Zqn8XPSS+/kYWYw1GCF5CdCgNFTfsqtuz5DsDnn4V3yrMvT+dT9VwPVId1qgG3TMfGXkf6169fOIkRwElmVJ4CiPHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132925; c=relaxed/simple;
	bh=PpkLE4bdcSVatVRZIRFo2nmrSWSvduXDyMtAL26tOmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2bYyBgzn9FQawF6vGsbWWWFWLpvOd3PxeGsJ2ETFV1hV6peoRjjBFv9Que+REPfAKroNH+vaXQJrg+DEa6VdwgFlojpSunfcrrgwhSbFyMXMyxQokfTjxvPgn5o0YVs2r0Uq4baXIIr8C7C+rOwxE54VJvZ1QGqz3EHYPxft0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=In1hmpun; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so829196866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1747132921; x=1747737721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpkLE4bdcSVatVRZIRFo2nmrSWSvduXDyMtAL26tOmA=;
        b=In1hmpunk4Os8dUk4GFed1tGGAF2PYZMTgKfG+JrHvHw0r+zu1ERRf/faYbXcntjlG
         McBN7H5lbX3uNTfT6VqhWRhiu6j1Twp+hfxG7pTiM4O4sMdYHeMExswAflzuki2+bQNC
         Lt7oO7ywkyLmbDg3nw//EkVX3zN6W/YCim3fepJbK4sF0BZPm3NYvujzZWrmCVgmHLYj
         F1vKdtIEQWNy9xsorbjhJ2qWZENniIVugTnnO5OArADmCXmxNakdxsQEg+NHzVuiok4W
         2teeRlCY2kxCEH5i/JLepi0lnx4fyBVwVMs+W2QLSWZu5M0gYbRN7mS8TOlFgnN90QIU
         LQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132921; x=1747737721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpkLE4bdcSVatVRZIRFo2nmrSWSvduXDyMtAL26tOmA=;
        b=pi3FeczsmKNIv37aj2NlBFhbAIERFMq+Hmw8C5l+7R2Q2coBphbuTYWTdkYQiLFnZK
         5cSLcAntkCD3cryY9ruMTkoh38EiEN/SJxeE9wUa/awNC0ixhD9YYKS/3TE+U2lOsf9H
         hTQeaLkCSv26bmuRhfecxXLx/fQ5pDeC7SssTB3sbA1u6mb7UT+TI9/0YoF+Va/8e5YT
         bVrVcGfcy6JtrkKKx5fkRDFyKZ6iV0by32KuYnhYtzCT6mRy3bB7k5LMYWR9q2k93NZp
         mLe9IGpZY/06QgyCmAr61FaSjzdbFs4WgvXeSFIs6Uu74KVyxECGla6bltCPHisljU65
         zAjA==
X-Forwarded-Encrypted: i=1; AJvYcCWKy2WLt0xCXHEYauM+OMa9Qee6ZQErJAkbCjI18u6zB/3LiYJbRUpEou9QdpMhiQOAAkEMEdGKxvYub/vl@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrsoaS2nmB3lLfF/dhtP1DX40bZpdJ8KIiLWtSmCgKAojSkpI
	xm8+iczYSVkJqvVewR1tDYW3mDyB9NVBP9h2X2XgiHrn12KLAC3lHBcfTMSXLL2DwXOO9Vf5nEr
	/wn89ecekco+zfF+otbKep4hatrxV2Yd+9I2Y7g==
X-Gm-Gg: ASbGncuJrOV9hgsCyJrmbSxSfelxSGFcq89bff+HLmnsK2+JCF9p/zMp3s4Ks4gDemG
	2QxQWVtbh0gd0hRsy1JziXVryBQ9cCcVcLik6JdxByLZd/ptu4BxnwqJeL54ga69C/RNUO8UXsX
	a5zou8X0mz8qmXDTwzTehnjF/Haae5niWSipxhS/wIaQMYjOJR5Ti6zRRmqaIAhA==
X-Google-Smtp-Source: AGHT+IG/QGsGyv4Ia4Wsh2r1sJHTSLLfE8cawvhW9uxg8cG6FnAm+n/draAgvW12YWHrgqzue3NkOhUdqobga1cF4p8=
X-Received: by 2002:a17:907:94d1:b0:ad2:46b2:78ad with SMTP id
 a640c23a62f3a-ad246b2859emr938581966b.24.1747132920838; Tue, 13 May 2025
 03:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429094644.3501450-1-max.kellermann@ionos.com>
 <20250429094644.3501450-2-max.kellermann@ionos.com> <20250429-anpassen-exkremente-98686d53a021@brauner>
 <CAKPOu+8H11mcMEn5gQYcJs5BhTt8J8Cypz73Vdp_tTHZRXgOKg@mail.gmail.com>
 <20250512-unrat-kapital-2122d3777c5d@brauner> <hzrj5b7x3rvtxt4qgjxdihhi5vjoc5gw3i35pbyopa7ccucizo@q5c42kjlkly3>
 <20250513-gebilde-beglichen-e60708a46caf@brauner>
In-Reply-To: <20250513-gebilde-beglichen-e60708a46caf@brauner>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 13 May 2025 12:41:49 +0200
X-Gm-Features: AX0GCFsICYnXFz6P4pIL3Hd1gP1nSyyWhZq2AVrnY-GWc43m-lXrhBG4S3e-bbk
Message-ID: <CAKPOu+97-ZXA=rr6DbbLKFb1KoJSG7_dwgjRjJ2KXah45=8z3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: make several inode lock operations killable
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 9:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Great. @Max you want to send an updated version where split into
> separate patches?

So this is about fear of not-so-perfect existing code calling this.
Yes, will post splitted v2 today.

