Return-Path: <linux-fsdevel+bounces-21501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30167904AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 07:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41ECB1C23B93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 05:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22834381D9;
	Wed, 12 Jun 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLYSSHvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6A22092;
	Wed, 12 Jun 2024 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718170558; cv=none; b=NcYXezOUsAsBiUBbJ8fBwAgyJqqknNJTionbPJUce6/MCvMsyd7kaGWwIKynL7hG/TtDgvs7HoSMD87uUgG0+JIWirxcNmSsxU8ZxZAg6qtWL+X7o2THo99CAqY/9UsY9QZ9lHgrXqvuGrMMFGj2D0asOPJcUC7wXI3WmKHnJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718170558; c=relaxed/simple;
	bh=8L5KjEap6e1V2hpP+V8+oD92dlNBh9b7WzaJPZZxRdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ndp7QBrj4suV13q6E60cxJeJYPUgdjS9sjLSUuTofPqWx0tqmbg69PnWIFz76uZgyTCi7OMZFgA58dXLx5hGlbIEDMMTAUL7ktyl8PL/jHqQgh3MIxhutJiv84mzLgh2Zr8O+b3Pvjw0W23lj/rvbD3m7DwoYrWens3gAuZUIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLYSSHvI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so725781366b.1;
        Tue, 11 Jun 2024 22:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718170555; x=1718775355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L5KjEap6e1V2hpP+V8+oD92dlNBh9b7WzaJPZZxRdg=;
        b=ZLYSSHvIkCJrl0bd3WcUTSZd3PSBdXR0Nw24w1s1nOOASRkMHeIu3kLZus1Go3BCSV
         gK9sPpqYaBuQaNzBJaurrwfns1umOXa6LoM8HTdMFfKi+aREr/kojHnmNbgMdQ8sy2At
         SI3Tr95H5G68h7AJpotshPgHY87sLftB9U12CgRrmuyOL0E5HDoPj/9vse3oxqS8UKPE
         s0HIB1XXH+R7KzCcUNhauiOjGA5ixeewdQad/kLGOqEMarc79IfGm6dyzDF+5fpcI3ma
         Rf6Ja2YEwXlHB5AM8c6uzOMplVaRrPVHYazsArq8EE5yrwCq5AtumYkThE+ZBgXsa+hl
         TJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718170555; x=1718775355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L5KjEap6e1V2hpP+V8+oD92dlNBh9b7WzaJPZZxRdg=;
        b=OUWFPuiPDiy9Ch7LqRhcCA7mp4WyTmWBVnfJdVEn1aPkNLZcgZCQofoefbJnqduRCI
         bpYTTIwHWcsKnsfoLH5DJuZfj61U7+wQEuvcBHwNsbrgnArZlrxktTdVN59VsDs7rcDh
         9/QxuQ1kLneF35KdDW/EHVcvBeLEnQo1s9KlnAY4vTKJ+PEbHx32pNdQy6YNL19nFe2t
         V0jCr7S2wEW7WRZlAefuEGUSgE681lJx9qhCV5hQHAnBur7RXeky41cNetZg1trBTgD3
         8OswUwtGQgudDoi2ZhsJY6DEuew3fHfQwIsypMIFC7TqEdodljHJjmB4Ky8HZUoKf9k3
         itWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbS1joBtleiwxwHJPZ9bikQRc62z8HRB3G9LfRfIVV+ORGk8kfE81f/nzMMu1F87dcLkSFuiqhCX6cSsQwvGLuAEnmc8PDirenIx5yzASpzOfIMKWijRPr/Hel4ToVadfSd1Yvvjii/cSGY/s462sUt4tGjF4fruRKjADbvE/G/ZIrLI5FBg==
X-Gm-Message-State: AOJu0YzUD7bZbW+jW/L8ozRn9vx28ur3E097qPxH5UPUBZ3QQMMgqKkS
	o81+YTRb+BgOx5zZ+RYSCG7R/36CkTiorACQDx6Ex/BunG7pCJSXx1/HxWsP6X5qgwSmGpg4vjm
	V3ULnqPFPnNVrsECQ5rFDNX8WEEE=
X-Google-Smtp-Source: AGHT+IF8SKBpiOztMbBdnJAu8LvJWR9zS9OppOdn8p8Bc2oKTRy6V6W021BkucO7e/Zb7pjngxRNtZ8dop9KON8Mo8I=
X-Received: by 2002:a17:906:a08:b0:a68:a137:d041 with SMTP id
 a640c23a62f3a-a6f47d36659mr35762866b.12.1718170554978; Tue, 11 Jun 2024
 22:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214911.1863909-1-bvanassche@acm.org> <20240130214911.1863909-12-bvanassche@acm.org>
 <Zmi6QDymvLY5wMgD@surfacebook.localdomain> <678af54a-2f5d-451d-8a4d-9af4d88bfcbb@heusel.eu>
 <9dae2056-792a-4bd0-ab1d-6c545ec781b9@acm.org>
In-Reply-To: <9dae2056-792a-4bd0-ab1d-6c545ec781b9@acm.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 12 Jun 2024 08:35:18 +0300
Message-ID: <CAHp75Vd02o_z2swHQ8Tajyvdi25do3ys7+GMES7RAg0NffgAUA@mail.gmail.com>
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Heusel <christian@heusel.eu>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Damien Le Moal <dlemoal@kernel.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:08=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
> On 6/11/24 2:21 PM, Christian Heusel wrote:
> > On 24/06/11 11:57PM, Andy Shevchenko wrote:
> >> Tue, Jan 30, 2024 at 01:48:37PM -0800, Bart Van Assche kirjoitti:
> >>> Recently T10 standardized SBC constrained streams. This mechanism all=
ows
> >>> to pass data lifetime information to SCSI devices in the group number
> >>> field. Add support for translating write hint information into a
> >>> permanent stream number in the sd driver. Use WRITE(10) instead of
> >>> WRITE(6) if data lifetime information is present because the WRITE(6)
> >>> command does not have a GROUP NUMBER field.
> >>
> >> This patch broke very badly my connected Garmin FR35 sport watch. The =
boot time
> >> increased by 1 minute along with broken access to USB mass storage.
> >>
> >> On the reboot it takes ages as well.
> >>
> >> Revert of this and one little dependency (unrelated by functional mean=
s) helps.
> >
> > We have tested that the revert fixes the issue on top of v6.10-rc3.
> >
> > Also adding the regressions list in CC and making regzbot aware of this
> > issue.
> >
> >> Details are here: https://gitlab.archlinux.org/archlinux/packaging/pac=
kages/linux/-/issues/60
> >>
> >> P.S. Big thanks to Arch Linux team to help with bisection!
> >
> > If this is fixed adding in a "Reported-by" or "Bisected-by" (depending
> > on what this subsystem uses) for me would be appreciated :)
>
> Thank you Christian for having gone through the painful process of
> bisecting this issue.

> Is the Garmin FR35 Flash device perhaps connected to a USB bus? If so,

Yes. It is written above in my report here.

> this is the second report of a USB storage device that resets if it
> receives a query for the IO Advice Hints Grouping mode page. Does the
> patch below help?

I tested the kernel build from
https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/60=
#note_190857
which claims to have this fix and it fixes my issue.

Reported-and-tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. And please add any suitable tag for Christian, thank you!

--=20
With Best Regards,
Andy Shevchenko

