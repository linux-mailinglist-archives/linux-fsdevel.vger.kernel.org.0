Return-Path: <linux-fsdevel+bounces-35139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6599D19B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AFA283293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2394C1E573F;
	Mon, 18 Nov 2024 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8MjXJJN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8531C07F2;
	Mon, 18 Nov 2024 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961968; cv=none; b=nVDAatkTa/tk8IaOTiD7h6kb4LIUr9ewNMpNas7zlxkeqVsEj9fQRwAxbtkRZaQW4CqTHA3Ye47jblTCpgdRRGa+uV63p8gK8Bs8RpkbZ2AwxMqaP/UMhctXi8+n+pT2QRwXUgG1G7xD0JBJiGIYppjs8bOsadcUHHx+kt9Q07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961968; c=relaxed/simple;
	bh=ZBMf67qmlIUiIgnrCTvUKyGq9bgnvBdT/sUTuLJaAnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLGKmd+/OhrgWdtOMjayGjxEWS27u4a0wx0ZZqT0njo2dQsBtPJjL6doZQhazBeDqWDumhaTwjo7HY8uvDzW4fhhnvwlg9ZnTChHo9D+bnsKRrCRVbA89uh6vRv6NHfEdRNbQA5/Va+9l/MGF5FuXJ+QBMr7dmeZ7YOa0g+tTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8MjXJJN; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso32322261fa.2;
        Mon, 18 Nov 2024 12:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731961965; x=1732566765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgkw4rY2Vp7+018NbXyOTmaUax7Rkon55Ocp7kerVyc=;
        b=K8MjXJJNz5nkY5I+meiA6zq+s+roX6OEc8PhWzE/2gjpYABAEr0qNuD9t0Xz0Lh1en
         kOTldPNVQQ/B51WySUnLoyBOcHVqCq9q9nZW1MHcBN6HKeRPFUWYyIyRy3bRfyPBdFex
         YZLsK9XsamISNp0aJsKDhJAUHb7mS6CScTEEdsdp4dQR020k7VbxIb2KndzhCMRfMwzi
         xuCpPD404S/gmdjuqkH4VQiGVoPNLzCdJQaV+0ayVB15Br/dD0Yxaei70hiheSvoXaOK
         GoKgHivfx9nd+Qwmb9MYMaIdk6ZSQYUYpdabG/OxXgozIofejpE/9dhtllaRFbtaEj83
         PinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731961965; x=1732566765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgkw4rY2Vp7+018NbXyOTmaUax7Rkon55Ocp7kerVyc=;
        b=Sp84c7Lur0buE1cs5GoU5WJRQH7v48HX7dvuVjS2V7PAzBCzTB5kp63cjg/u/20PKK
         Ki7Y5Yv/kS5o+XqN49fPEmOmwKYnbTmU/zyPEJNZvK6V6BAPfXjqXR23iQsZLxWwczK9
         R5bvPqA4tLaVMtb+aoGN0Uj5W6wXmDW03bKbBIHD1WyNyJBaZ3Eo2Gn2XYYGTZUcu1xY
         AT6+GT5hLDxMM+6CgV7c2HVDJy1xpaJjbysZB7x7TUH8tpBzT/V8GYA056a/M/mFCfK/
         pwlfFeDDPHytQ2dXPuiAGaU+//N4UJbLDLs11iheJ7kmbL0QCyLSfQuDSTZDKrjfalGe
         vtDw==
X-Forwarded-Encrypted: i=1; AJvYcCU9S48uFhK0Cs5B5qJaq1lnM4TF+fjZZYWfalC/d80vhPUq7goUVxl/pGnyCiRW3/xyhkupOivVUscEmGeH@vger.kernel.org, AJvYcCVMcDPEBorZ09sDqTDtWxu1vpe8iHRW/+xh56H4nND2foDZEm2J1wvDg36UNRXvWokATIMTP/CFOxrUl9fL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdh2PTmPcA7sZTWeiuiInyH96y4pK8LyyVG3qoFa5xBatxMUQS
	6SqRHA3NQIhuw0oaDKmVcOPZjs9D9g5orrRRfe+cPuNbSHydSUalnNA7buaUlObIsNYtS0AeqZF
	9o4/xS8am5Aoa5nnsukducez/X1Y=
X-Google-Smtp-Source: AGHT+IEFYQl4G6iFAoTxnP3jAPZik50EQQxO3reOJKtTI1X1ka/as5lGXjOuyK7/iXvJ9cRhHUrMgOhxzfFzj2Jf6ko=
X-Received: by 2002:a2e:a9a5:0:b0:2fa:fdd1:be23 with SMTP id
 38308e7fff4ca-2ff606dae98mr108093231fa.28.1731961964798; Mon, 18 Nov 2024
 12:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118085357.494178-1-mjguzik@gmail.com> <20241118115359.mzzx3avongvfqaha@quack3>
 <CAGudoHHezVS1Z00N1EvC-QC5Z_R7pAbJw+B0Z1rijEN_OdFO1g@mail.gmail.com>
 <20241118144104.wjoxtdumjr4xaxcv@quack3> <CAGudoHECQkQQrcHuWkP2badRP6eXequEiBD2=VTcMfd_Tfj+rA@mail.gmail.com>
 <20241118154418.GH3387508@ZenIV>
In-Reply-To: <20241118154418.GH3387508@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 18 Nov 2024 21:32:33 +0100
Message-ID: <CAGudoHHJwreaSZirs6qfQw5-qRnyHsFLeKp_=T2=S_J=VezKLg@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: dodge strlen() in vfs_readlink() when ->i_link
 is populated
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 4:44=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Nov 18, 2024 at 03:51:34PM +0100, Mateusz Guzik wrote:
>
> > This is only 1.5% because of other weird slowdowns which don't need to
> > be there, notably putname using atomics. If the other crap was already
> > fixed it would be closer to 5%.
>
> Describe your plans re putname(), please.  Because we are pretty much
> certain to step on each other's toes here in the coming cycle.

I don't have immediate plans for putname, but I posted a total hack
some time ago in relation to it:
https://lore.kernel.org/all/20240604132448.101183-1-mjguzik@gmail.com/

along with this:
> The race is only possible with io_uring which has a dedicated entry
> point, thus a getname variant which takes it into account could store
> the need to use atomics as a flag in struct filename. To that end
> getname could take a boolean indicating this, fronted with some inlines
> and the current entry point renamed to __getname_flags to hide it.

> Option B is to add a routine which "upgrades" to atomics after getname
> returns, but that's a littly fishy vs audit_reusename.

> At the end of the day all spots which modify the ref could branch on the
> atomics flag.

I ended up not getting this done because there was something real off
about name caching for audit, I don't remember the details but I was
not confident the code is correct as is.

Anyhow, someone else sorting this out is most welcome.

Apart from the few things I posted I have no immediate plans to mess
with anything vfs (I do have some plans to reduce the cost of memcg
though).

--=20
Mateusz Guzik <mjguzik gmail.com>

