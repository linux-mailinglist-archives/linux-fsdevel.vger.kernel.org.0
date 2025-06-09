Return-Path: <linux-fsdevel+bounces-51009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F63AD1BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 12:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC03A4633
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5FA253958;
	Mon,  9 Jun 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6VV6Gjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038124DFF3;
	Mon,  9 Jun 2025 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749465578; cv=none; b=CCTQ2qPeAi+MCaMems+niktUpQux/lGQZzkUnoAXT8OO/FGrZuAZQwKqK+fjmwiLTNj8hKKBfIcAw9wpnFKq2eGYrMGv2CRNVmJt7C2DqI1lygTMEublLN0JrGPApvOskHtQ850tY9vlvcseURzczLg7BaISCiWoUCve4hwKRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749465578; c=relaxed/simple;
	bh=o40cdfq0avXaOThlxnjrAygFWUAA6SzRVbbR8gMI28g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlMdz5BqAOVfxZnwVXgbVKR43j1MRCsqR5M0qfJzxdSDH9V4z3BlJHs3GuOtdd+Uyu/v6rNa3f1MfNpSo2vRT22e2Vwt/EyxM01TmL68I/828ea/ty2cCyXoCGxIE7KO4xeoTOk/7P4lW+CD2QCuMjmXoMDbknRwL71/ogDSfFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6VV6Gjs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad8826c05f2so788845866b.3;
        Mon, 09 Jun 2025 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749465575; x=1750070375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqf9whZk0cxbC1mikTl36CpUHfdl9sydJLTZx6NhoRE=;
        b=l6VV6GjsCexkEeSDZJ/2Gjpt2jC/Zzk9jpR3/RAaPC2Z4wn+VF21MzJQFVB5yu0nQX
         2bitsZYoAtG9WRMdw+hfHmxhlzu8n35UpJQikQ/kALu5qQWed2BSSierUK7ChyRwI1hB
         OtvXtcUVYKqdbxJuNgeafO/GDxClxwPyT1avqbr4eUVnXRMsf5vtFETpvAcjy/LZA5fS
         wASZDBqAll8IVECu/N5IyEpVLG8IAwe5oTrcRO1G1e/wzMf+SNJwcW2kgWkb+Vqf62YP
         DmuI9fp2+FDByyyWnq8XkyuhUMjqWzMdF8ocXKMO17zMZQk1O0neRK5H29QeXGLbrZ6O
         CU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749465575; x=1750070375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqf9whZk0cxbC1mikTl36CpUHfdl9sydJLTZx6NhoRE=;
        b=knXW7Cma/ML/lJiy7aGAUtH+6eTvo4DVsnb0y2ive+dcUHI8IuYuXTwJ6T1qaNCRod
         SDej4zw2twsAzmkdLcDHVGZOqvZLxMBa6f1C+xw54ZqbC64LRMKb18d4h7NHp+0loQCK
         GFg9/5woQttbAouAgFgGH5AQcCetwgpO3IHMMrtzevymgJcXuFL0CTxC3vpIbNqoyOGu
         Z05raVCKzbu787bh+p6ocU+0Ih0yXf9hbHHixhYNfwaTE6pG9sws64rr0t+m24T66jPs
         LotoGK5laG206D+6qAUJj8ufnPu2GRn71yAVAa5wZ52m2LXkL0CX5J177CmKS+2wLvMp
         mAKg==
X-Forwarded-Encrypted: i=1; AJvYcCVLtDZB5/fgS8xgFYPt01c9jixLHkRxGU29Lj9qq0V4gOmXTTT04YDTg84zo4Sv8KSXlpQ9JddqID2Uyr1c@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfGzRpYeuMR7CUA2xFcfmEm+Wy8g8YniWmWVhClr+fjdSZ2v+
	FTViF9acZl2KICsR9DZSxzYnGnC/Jgj2+D/ZOHG7Gi6RAKLPYSvJHH4syACCIzQe7uhPb+/fHw0
	WDVcTEIkKFhtVSFQ5V2XsP8cE7F/Ton+pjSRl/BE=
X-Gm-Gg: ASbGncsHs3nGxupFmIhfTMNqckZor6N80rOHOcP1vI165yGuYp89qDDKy6J/3oCcv5+
	zoxhPfIS+vj/YNGgEpZzR07OjVke84QWYJ0k20ZkMIdjpjtAFINB0VgHXK5z7yK5BT7K0gWIkEg
	8WTtZH5m4lkYQWSnWuy81Os2o8o7vRJA2D7nO+VkpIq5w=
X-Google-Smtp-Source: AGHT+IEpGFjoAjap5QfCQxT2eELPju+hiAr1THRIgrMNT9q8V6s66B1ndE+dAzQ3//lLUg/MrNVLCOuyTRsSRL9j8OM=
X-Received: by 2002:a17:907:6d28:b0:add:f4ac:171f with SMTP id
 a640c23a62f3a-ade1a9e20c0mr1181219266b.5.1749465575107; Mon, 09 Jun 2025
 03:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608145826.s6fnuitdfjb4hldr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250608145826.s6fnuitdfjb4hldr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Jun 2025 12:39:23 +0200
X-Gm-Features: AX0GCFvnWN5homw0IrsXhcndVJaElvaTd_6wyQQFA35tlNsnB-zG0WwZmBfQ0Gc
Message-ID: <CAOQ4uxiO-WhCc8H8tpW5YB-vQwm9VkUk1SpU5r+-K6jLmJjxqw@mail.gmail.com>
Subject: Re: [xfstests o/012] unexpected failure on latest linux
To: Zorro Lang <zlang@redhat.com>
Cc: linux-unionfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 4:58=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote:
>
> Hi,
>
> My fstests regression test on overlayfs hit an unknown failure (diff outp=
ut):
>
>   --- /dev/fd/63        2025-06-07 10:18:01.306026526 -0400
>   +++ overlay/012.out.bad       2025-06-07 10:18:00.941720188 -0400
>   @@ -1,2 +1,2 @@
>    QA output created by 012
>   -rm: cannot remove 'SCRATCH_MNT/test': Stale file handle
>   +rm: cannot remove 'SCRATCH_MNT/test': Is a directory
>
> Due to I never hit o/012 failed before, but it fails on this regression t=
est.
> So I report this to overlay list to double check if it's a overlay regres=
sion
> or a test bug.

Kernel regression in 6.16-rc1.

I noticed it before rc1 but fix [1] didn't make it in time for rc1.
Should be there for rc2.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20250605101530.2336320-1-amir73il=
@gmail.com/

