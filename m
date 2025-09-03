Return-Path: <linux-fsdevel+bounces-60154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F91B42356
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1637BF69B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65663101D5;
	Wed,  3 Sep 2025 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj0UB0W1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746761C84DF;
	Wed,  3 Sep 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908395; cv=none; b=CmyxSeXmCKGUBl0AWNk9SrA/PowNrruxprgQ52KiXYqVIFAHbI37nIOdJcFre6L9aQzayUqIg9oBzicGQkXs0fR3Kshoswz+85S6/LiRIyUOVhmY8LyKRDz7qVnUjyqlsdLYU976wUYJMP/+Ou89kZTpGnYybRbug79T5s1Nmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908395; c=relaxed/simple;
	bh=mcSj6sBducJtq3QFx+SZal1G+3uS/KNlrKO5HrQqiUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWfARj3cumrsns9ySjt0Gg9ZtyE8tWF1Z6pChOxD1yUtsdKrP7NfQiflhlzuMBoHUSpN6vRxKArUqNAYX0yUOHgxoo1RZxY8ehAkqxFTvV7j9OyWHYuKE7B7C3g9nAJfAVWCwVQ/p5aBXdNpoG7x0lObDza+IYm83N0qYjTPPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj0UB0W1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61e8fdfd9b4so2120495a12.1;
        Wed, 03 Sep 2025 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756908392; x=1757513192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcSj6sBducJtq3QFx+SZal1G+3uS/KNlrKO5HrQqiUo=;
        b=Aj0UB0W13COwkbj3JuklLGkEjYqu9fX1vGUHcQr9x1EMR7ITyBBZ7JIzFlXz14lVsV
         06OKzClGjwy8tuXtCOUo98EMTLdlobotcNuVo/2/peP1748hTZaCtFYyNHN1iZ151hfF
         EmQz8oW/8aSd8s00Y2QVmbBRuBldHfwWuBtnlohRbeQeehIRHv878zeFzyWHogFZPGKa
         x5JYAetnkmWXDyHIAAXmHJ6nBsJZ1YTrAmddJzR6C75AK3KGdOc6IM0CDDlBxKd/kqb3
         ooDH18YtbHF9N9C+SeNerZwL0Vv2CKjl+dB1rbg6rSg9faEmjruXc4y3AfzQd2LfzOGz
         0PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908392; x=1757513192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcSj6sBducJtq3QFx+SZal1G+3uS/KNlrKO5HrQqiUo=;
        b=nqGdGoQ8vIdZoRFRv08K2moUf8p+RONyJEkUdLPfsvLFLSM/YN9vDhkX697KRl2XLs
         W7KkIGIABViFlB/7s6WyW723mXaaze/tF3agUkxSeyWKWCFVWZWQ9MtM88NIuyDmXZpW
         Zu02BOOz9cSeFNZ7R9KJnNJn5NnG7KyzFbFZvi2kMz6kDyEjQaMPm9/RuG5JQYXV/dFL
         X8V6C+4VNJliIF/syJ58341S1cjf2vMXWIk1pyLidorkLOc2moCO+/x1lGLo0E6u7lsU
         lLitKJF70etiu6wi7m36F5ddLiyIENCUBjdi9sJBA9vxC91iaUpCujMf1wSgq5U62bpc
         RvlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq3OaPLBAnnjsNtksrBwi8xs+hCvlifgD9Bf5VoiRC3qZno3gzsHrVEPv4gsqW4Co60IRsoocFzo7o4/Pm@vger.kernel.org, AJvYcCWrS/oZKHhDZZGc2X7nfaWI9vgk9xZ/soEvYtyINjmuCRHwuvKo8z5gGFYJmf7RZq2HDCbHL4BsVgqorSrB@vger.kernel.org
X-Gm-Message-State: AOJu0YziCtxBLp9atbiQ16iO3wRsm6f1CZk7d2QUGB6vWQ2ItSV/QZ11
	LTNEo5OqPgmMOcWw7o5MHrrsDGMLcWjeejKgr3A0xv301wmXZSv+N0IUnF3MdNBzvhkPL+XQ4kI
	RDG+u0m6H7p0SbKNLmCshTWcwf/9Z4Jc=
X-Gm-Gg: ASbGnctVcUqFFHNsuFixf/fiffGHlBI54GJ3bu89hinRUm8+MpxeMrEfxgAN4rvkXma
	uu9/MllS0wwKlMbsqAPjaJvCyXwnSX9Y7IpzLOcOZDUFvOE7NoaqEibFt98T76X1oC0NiHA+VcD
	0Shkr+/hGx1LiQw3QQhujq4401Ep8+/W128wmc9Ez77A7VK70ODoV4+vydPaQcPM5XYjv1tyukp
	4YqDjM=
X-Google-Smtp-Source: AGHT+IGpjEpj1IJ6T8EHew5Nfz0x5tQL07YxgbZKRCSEna9fAUs8WjkIQrE9rKKag+kpN6af4bvomm64Arr/UlpvDKU=
X-Received: by 2002:a05:6402:354e:b0:61c:90c:ee97 with SMTP id
 4fb4d7f45d1cf-61d26882f04mr15587215a12.4.1756908391436; Wed, 03 Sep 2025
 07:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903093413.3434-1-lidiangang@bytedance.com> <ownanwiqdhijstazux3j5jsawdyw6tcgjufk6zrejppnqyoy7d@hdqmfb4q7wpz>
In-Reply-To: <ownanwiqdhijstazux3j5jsawdyw6tcgjufk6zrejppnqyoy7d@hdqmfb4q7wpz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Sep 2025 16:06:19 +0200
X-Gm-Features: Ac12FXy_mNxEqcs6hMH0BU3mgcsLIjZNGOEJy8Qu4kjnWkk_XD_OjSFyEg0aVCQ
Message-ID: <CAOQ4uxiDEwrNVLkwuuA84RWoUPovi--Xj4BRuL-5OEwiQyAFXQ@mail.gmail.com>
Subject: Re: [RFC 0/1] fsnotify: clear PARENT_WATCHED flags lazily for v5.4
To: Diangang Li <lidiangang@bytedance.com>
Cc: stephen.s.brennan@oracle.com, changfengnan@bytedance.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 3:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 03-09-25 17:34:12, Diangang Li wrote:
> > Hi Amir, Jan, et al,
> >
> > Commit `41f49be2e51a71` ("fsnotify: clear PARENT_WATCHED flags lazily")
> > has resolved the softlockup in `__fsnotify_parent` when there are milli=
ons
> > of negative dentries. The Linux kernel CVE team has assigned CVE-2024-4=
7660
> > to this issue[1]. I noticed that the CVE patch was only backported to t=
he
> > 5.10 stable tree, and not to 5.4. Is there any specific reason or analy=
sis
> > regarding the 5.4 branch? We have encountered this issue in our product=
ion
> > environments running kernel 5.4. After manually applying and deconflict=
ing
> > this patch, the problem was resolved.

All this above would be nice to send Greg for context
so he can distinguish your posting from AI bots posting backports without
having tested them or without having encountered the issue ;)

But IMO, it is more helpful to send these notes after the ---
line in the patch notes rather than having a single path with a cover lette=
r
as a backport patch.

> >
> > Any comments or suggestions regarding this backport would be appreciate=
d.
>
> I don't have any objections against including this in 5.4-stable branch.
> Probably it was not applied because of some patch conflict. Feel free to
> send the backport to stable@vger.kernel.org, I believe Greg will gladly
> pickup the patch.

Also you need to fix some technical issues with your patch submission.

1. Subject:
[RFC 1/1] fsnotify: clear PARENT_WATCHED flags lazily
change to
[PATCH 5.4] fsnotify: clear PARENT_WATCHED flags lazily

to explain that this is a backport and the target stable branch.

2. mainline reference:
commit 172e422ffea2 ("fsnotify: clear PARENT_WATCHED flags lazily")

The common pattern used in stable tree is:
commit 172e422ffea20a89bfdc672741c1aad6fbb5044e upstream.

3. Signed-offs:
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Diangang Li <lidiangang@bytedance.com>

Unless you are backporting a patch different that upstream version
it is probably better to cherry-pick the commit from upstream without
Sasha's signed-off.
Not a big deal, but at least that's how Greg expects it:
https://lore.kernel.org/stable/2025090200-uniquely-pumice-1afa@gregkh/

and you may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

