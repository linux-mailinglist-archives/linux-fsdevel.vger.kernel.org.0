Return-Path: <linux-fsdevel+bounces-24220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3643893BB15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 05:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689131C22A50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 03:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B591B17565;
	Thu, 25 Jul 2024 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3mmNgFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126B81E;
	Thu, 25 Jul 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721876758; cv=none; b=OwrlQfeLyl3LVSGi4mbWN9znQt9dtEiGOV5fJbBbDev6yQVV/rWES1Gda02g5MwQ6QZ/7U7rVhJ4CTLCDuq5jkWumuNtgXZl9ewlAycE3IW5e5/XD4TnHkLZxlLYa+QvuPolfVDu8JKNAbPhHGuif5erERukfRHM7lv5PxFfXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721876758; c=relaxed/simple;
	bh=xlu1j6QuVCPapdTWRZn3zuFFw+lOcqrkvmlHJYlFOow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9lpBaVAv6au6Zt8fsvH2C4uf8BAcUbYyF+UaEiG56EZ7qAl/Ez57lP/1uz9ymRArE/+RPmgUzwRp8rxboiI6m1AtCpGCDRIdi5GYyL7HWBNhFED43k/MYVVru5XimAPFojZW1EDGrjXH5yPuQTdXIL7ibmSrE9/BkZxj494ncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3mmNgFJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427fc9216f7so3313675e9.2;
        Wed, 24 Jul 2024 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721876755; x=1722481555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlVdy6OQzTGqiqZ//klvDrPFrZ13FCx6zLB8hIpHuf8=;
        b=l3mmNgFJWjR/s7eIk2QlBQ6se8GfRykTWXTAuayhuFbJGB/CziOc4r/f32vIkBzMRV
         yFUwRu2QvAGK+EhETFuCq7oU5vxV+MAayKq7rqzoi2RInBs/DCyClRMTwlG70ZLqgUHY
         2dVXXF3Tzwt6uonBLHDjamMZ+7fDOUkuLtkIVKkCTNek0j4K1MsMmnP3gdPbKHJ6VwF3
         sKNzeT5NxVcH248zz6tKimOt08yPyRd5i3DOqQWs1TbkcSrDJwh+WWDdn1gZTKO4Dn82
         kAz6FIxVbBgGdF4RtJPr5mswDOqBBlJXv2eboaSJ2T6EH4Uir3arA3iqgtpw6JQ4V5Dp
         7V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721876755; x=1722481555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlVdy6OQzTGqiqZ//klvDrPFrZ13FCx6zLB8hIpHuf8=;
        b=GBShEYYCZuv3bAO8UwuqNycmqsH5tWnHw9xRkuZFpBeK4yneKiGeoa1H+CzeCd+Aoj
         0I4naqh+Opzec6DcP200KpIW4xk1UegOb/n6+UeaQFKqkt2E8eVAds/BRomBZ8SmyZkF
         2sKvDskEBOgwZ47sP7NOwNr21OEO7Wt200HL54Dc9jzbrCtGQFK5G60D1sjjaONimExE
         d1NuEaeXJ5mTXJshXtmgWyeDQcL6sdJNLiAHuhW/IvYeq2183NRIjlc5cTlKE8hPrzrc
         bwaQxKPdVxsL+IRbU1y6ViifLA8zhWWvF60fBXfLoxmcQON18F3w5lYjNX7gOFYkCcQh
         wyHw==
X-Forwarded-Encrypted: i=1; AJvYcCXTqsSJVNnmlGvURizgn+tSsTpRhBnFBJ4pRqT7FsF9VfyswD4cYs2EmykPXzEESzbJ2kcHpSN6auzGVk/2jCpMBhl40EfDtIuZL5eqyj/97k30rUDmYSXrylysdbQoZ5MmXr9OGM3mUE10mQ==
X-Gm-Message-State: AOJu0Yy1B7PqhhfllXdVKi9oCgyU1Htxl2JkGe2u8cDbXzXdSjL8pdnZ
	Sn1AW5u7MNgzI60W2/AIozk2/2ceGalhUBrfKDskMTTTgnFnXZ8WA8g3ZIPvmL0pfyr3Hkh3oxo
	V0E3K8rA/yYQCKkHLUuw55cGpP6A=
X-Google-Smtp-Source: AGHT+IHk+42C8f29LE3oXIpSL+gBgvKcMHB/XTRZ+YZZvZcxqIWy6CvpAMiL0o/q7i7W3O+ZItXMbHWLvUnP506nOt4=
X-Received: by 2002:a5d:6645:0:b0:368:5bb4:169b with SMTP id
 ffacd0b85a97d-36b363818eemr466488f8f.4.1721876754667; Wed, 24 Jul 2024
 20:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
 <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
 <CAHB1NagAwSpPzLOa6s9PMPPdJL5dpLUuq=W3t4CWkfLyzgGJxA@mail.gmail.com> <20240724194313.01cfc493b253cbe1626ec563@linux-foundation.org>
In-Reply-To: <20240724194313.01cfc493b253cbe1626ec563@linux-foundation.org>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Wed, 24 Jul 2024 23:05:43 -0400
Message-ID: <CAHB1NagB0-N777xzODLe19YBV1UJn4YGuUo67-O9cgKKgc-CLg@mail.gmail.com>
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, masahiroy@kernel.org, n.schier@avm.de, 
	ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=882=
4=E6=97=A5=E5=91=A8=E4=B8=89 22:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 24 Jul 2024 22:30:49 -0400 Julian Sun <sunjunchao2870@gmail.com> =
wrote:
>
> > I noticed that you have already merged this patch into the
> > mm-nonmm-unstable branch.
>
> Yup.  If a patch looks desirable (and reasonably close to ready) I'll
> grab it to give it some exposure and testing while it's under
> development, To help things along and to hopefully arrive at a batter
> end result.
>
> > If I want to continue refining this script,
> > should I send a new v2 version or make modifications based on the
> > current version?
>
>
> > Either is OK - whatever makes most sense for the reviewers.  Reissuing
> > a large patch series for a single line change is counterproductive ;)
Thanks for your clarification. I will send a new patch based on the
current version.
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

