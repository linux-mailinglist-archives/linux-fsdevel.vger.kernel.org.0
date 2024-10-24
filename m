Return-Path: <linux-fsdevel+bounces-32819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863879AF2F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 21:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138AF1F23149
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07911A7AC7;
	Thu, 24 Oct 2024 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnPiJ6Z9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5C147C91;
	Thu, 24 Oct 2024 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799614; cv=none; b=Fia/wgjopVVDHxhY310UFBvwt8fKisRviiTb9s64eoovjTjtFHNOBqVayK7/rCQNeniuhwaYy3v5nFkro0oMlk+uECA1sYt56e3/Xz58tNumE9+lwArDkBzz3KRGjPVJ7tVPPfbAdOl4c/8LO9wgbZaIduKST1PI21As15Jf7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799614; c=relaxed/simple;
	bh=fdMUNfcSZ7BdARmONDQxeYG2UP8bXDM0r1GmXUMxhz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Po+bDQS3FVUSj+n6aZUXqG7J3FvAXMC98LqP5SRxX4cmOTmC4qelJp36vDq9iiQEYbkvQ0xorNiIVGp2Y9YJpnGkFssBUzKpX5EcLMOhR59E33ygBglyGZ1AvjZRQnbTd0njUGRAfQ7/iNe8JMCCVPqgRHccGmJAwohYDxgQQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnPiJ6Z9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb51f39394so14486921fa.2;
        Thu, 24 Oct 2024 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729799610; x=1730404410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdMUNfcSZ7BdARmONDQxeYG2UP8bXDM0r1GmXUMxhz0=;
        b=RnPiJ6Z9cln8XJ1wZRbYV4VJbV3BeHI5BYc+T2rq7lwyl86VH/QXAkR73WbrCB58Xv
         P0vxOkA4dJHwB1ipw1EV/hS7JrZvOXDXhtDWMt2Q+rHZZjnRCxxd4QJI06BOCD7ZQJBW
         UCrbJ27jWJqJtit2N4juejTTeIu5BsC78MBgWlIIEYn1AhASZrX/k62Hq2VjxsBYBoMq
         +lxnve3lxB6FIeqJrlA1zxSGQrWm9J4aNobnEPLGEp8A2XmLm0DRMwqmzd9LpY6/w+ko
         MLgeVeDGvvKnIEldplDpQVyDDvVir/d9ljE9aj5nXLVpLslzb00WEtbCLIiGEhVshSnN
         0B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799610; x=1730404410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdMUNfcSZ7BdARmONDQxeYG2UP8bXDM0r1GmXUMxhz0=;
        b=CnKKTd+0Xxh4Um+74ytde4Vr/3/8JSup1eKKiV8Y7aKzlecX7JulOW26nZTzWi7PlV
         FyK3dU1SqS9AuKTB7Gwf/w8Rb79pV9ZzOsL7rWQESth3B4Hw9FhOs6V32IrvBdfBdvGJ
         T3K9LI7lYxbEs6yFHw6pUtyBAgYnze7gyrmVANsPNDR6lC8qxP1jjgmU9TTv5+yl2kBv
         l6vONYC1oWLROOOt21rIBTi5vVIuzxkPBDv679iLn397nDaEV7yKWFp6MOzQeLeZz3XI
         2Ndat3hJmr4MBZdZRhSVKGRNqIuIk6Nq722usLvlqkH8L8Ta/irPWCVEClcNZNUqUs5r
         +6ow==
X-Forwarded-Encrypted: i=1; AJvYcCUKHyjxB/Ahnxlcxzikm53DbpOfexLq9mDdPThzc0bwYfeeGxd0r1QTlI6w+afyWMYQ6BS1vWLOTGA=@vger.kernel.org, AJvYcCWI8QZUg/ovfc2jp33LJFcyIYozSm6VAENoyh3cylmdWi/vFUXEmg594IDvKG8/JPHUwB+sIWArMMoK1p5QfQ==@vger.kernel.org, AJvYcCXB1JxlceABaNtblrET9aJm/gv7Qg1FSaZujGQ0lyp/WkWSiWqB0xCLoci0qRFqGwqj0+i9uLClmW0P4Grc@vger.kernel.org
X-Gm-Message-State: AOJu0YynbSl3Xv/YnNp5rFSnfWRXVLi34/WFZeRPR5Q555M6SsxpV4or
	ZTNPu19+ZKxggCdzhvSTE/dZtfW3vKm4zN8zNmgO3sjLZiMhPp21G9ogWZnoQ+aU4E4kjGOaN3+
	8Yi2Qxp/urYihO9XM8TG4NN4nJp7tOg==
X-Google-Smtp-Source: AGHT+IEfJR4TsyFU+v14aVkd26FFpNVhnDKNLXkmteAoazAgwE2S/biPF3eHN6VbFyWZwY+HqYXRS92CnpI2nl3pwOs=
X-Received: by 2002:a2e:be24:0:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2fca81c2448mr23740601fa.4.1729799610107; Thu, 24 Oct 2024
 12:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-ks9mz5deGSA_GNXyqVfW5BtK0+C5d+LT9y33U2OLj7+XSOw@mail.gmail.com>
 <20241010214150.52895-2-tamird@gmail.com> <1f10bfa9-5a49-4f9b-bbbd-05c7c791684b@infradead.org>
 <ZwhYDsBczHnS7_4r@casper.infradead.org> <CAJ-ks9mpZc703=Y1_H6FeaUrAmhKC9bKP886M5KNjw85Mwi14w@mail.gmail.com>
In-Reply-To: <CAJ-ks9mpZc703=Y1_H6FeaUrAmhKC9bKP886M5KNjw85Mwi14w@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 24 Oct 2024 15:52:53 -0400
Message-ID: <CAJ-ks9mn_aOjaxwiwddKPKMUshiSa1EHjC_2X5DDas7JLtcnSg@mail.gmail.com>
Subject: Re: [PATCH v4] XArray: minor documentation improvements
To: Matthew Wilcox <willy@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:51=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Thu, Oct 10, 2024 at 6:41=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Thu, Oct 10, 2024 at 02:50:24PM -0700, Randy Dunlap wrote:
> > > I'm satisfied with this change although obviously it's up to Matthew.
> >
> > Matthew's on holiday and will be back on Tuesday, thanks.
>
> Hi Matthew, could you give this a look please? Thank you.

Hi Matthew, could you please have a look at this?

