Return-Path: <linux-fsdevel+bounces-62200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DDB8803A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21591C27714
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D282BF012;
	Fri, 19 Sep 2025 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gsnpztdn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F12BEC3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264216; cv=none; b=sUXnTFffsMdsqCKkdXbxouuENUhYF9F7myJ1o+Ii8yokJgye62hRAqfkTckXiIw/WLVDIAlddLObHac43zfYLSGEHBIR09qAPjN/Xf2JCenu2iDZt51BmtuwztolCrGrXvrYchkOdDcedNsNipQsTz2oTgmJai3D769Kmcjv8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264216; c=relaxed/simple;
	bh=pDgMPvbCzBgKsjWeQYiQdKAYD9d5aE0jVaYl4nco+5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV7jtKzel09AOXdSR3iT0PjNo3exO4n4i5HwgKPcdkCWPmbEnpaT7NQX66Pe+buH3qx4ABXP740VzYspSBeftFx7sVy6gnCoV5OgG3OdfNL4FoZDtaTIlgXlAoyiz2Th4JzdunniP1XZ6/opiiL648/005dPhPsR2g0uOcI+1l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gsnpztdn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5f3e06ba9so32526151cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758264213; x=1758869013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDgMPvbCzBgKsjWeQYiQdKAYD9d5aE0jVaYl4nco+5I=;
        b=gsnpztdn4LjvC0gnI9lbp1MZliG9mR3r7ln+aRwhcORX/AXiDXdxql5gPLmoo68dYU
         LLtOk++9Qk223ICoBQNxFYuD3tpZtmQbl5TdynYhiJDicepn8XjU/mAob0/Y5wL3MItX
         aFT2n+FL95UIBPsokjAxEosWtTsD7TdqJNXkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758264213; x=1758869013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDgMPvbCzBgKsjWeQYiQdKAYD9d5aE0jVaYl4nco+5I=;
        b=GTAoijwdAuG1dbsW48hFvWVm/+tm99GEcAR4ILbdTvT89xOjIJ+67aZII1u4JodeTF
         nFieoF1p5EgEcvH9SdqbJtpIhj79EQik704n/jXXBdCjnGg0aoFKRdLbLz/SW3MUcQ0L
         cMtFLVRLeW6xSyw68Rzb+O5LiqBvE0/1rHHVd1v2JJUTOxGQIrYGv0Oq7yNNuCUjmweN
         LF4GcpKMnN6jZk2BoU1rlhKH9y7kizEra8LejmJyLjVr9lh8hf5Dt+mgHkkaSiRTrBq8
         jckNHL40q1FjX+FjMdx6t8/yWQag5dz8vp24iYsH0qF/MKqXobbUY1smUSUT9JWwCjXI
         KrnA==
X-Gm-Message-State: AOJu0Yw3r8HSK9z1jjEJ0BieDVB9W9RkHEMcFm99qsYT03Jq0Gb+397z
	rwW6/RJ/F5A2H2iVe0ztmih5B7LNNoI0vZVOFI7qhtGbGZbSC/Gwp9HOPtf0gLt+GzrSRH5IWba
	By79z91+7bS3iR3Zb8Q5sl0cyu2g/kUyxIN55yKLDEjGClytShAjPpSw=
X-Gm-Gg: ASbGnctFZPjG0oJCdaPcEglEz1FYrn9mWB3I/eF8rlkuvlLYfIEfcIUqct6fNEWsB8M
	ou1vnBd4WlTv1KDPdB3p6UPMFGa+BVrV+a2figemgI+EPeaJAuMxM8kdD/sEl76zZy8KL6vZWVr
	E+96O+yQ64wwQSefsqFQnMwmv+hpEBmvLSQDTI+mH/pHz90NuYGxD/D7JhrlkOaiEamTRLrUPJ3
	wki1rFWlZBmw0vCAa5exvnDuQvNBDdJLg0rfu0=
X-Google-Smtp-Source: AGHT+IH7BmIHFoa4YKFToivU6LzwYyiK+VHId3cOW37POfKDqGjZItF4zx64vHCHnzeA5DMrgfu5eC0R1Cl4cF0NcpQ=
X-Received: by 2002:a05:622a:349:b0:4b7:ad20:9393 with SMTP id
 d75a77b69052e-4c03c19445bmr29714311cf.4.1758264213118; Thu, 18 Sep 2025
 23:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917205533.214336-1-mssola@mssola.com>
In-Reply-To: <20250917205533.214336-1-mssola@mssola.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Sep 2025 08:43:22 +0200
X-Gm-Features: AS18NWA2eZxV5MToWOOu4fgYvuODb16v-isLriffr0OTySzPgyVq7D5IBxmpe30
Message-ID: <CAJfpegvt8ydN0uKYpbWVAmzZtHJ2kg3PwffZYvB33G_4fnq7BQ@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: Use strscpy instead of strcpy
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sept 2025 at 22:55, Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.=
com> wrote:
>
> As pointed out in [1], strcpy() is deprecated in favor of
> strscpy().
>
> Furthermore, the length of the name to be copied is well known at this
> point since we are going to move the pointer by that much on the next
> line. Hence, it's safe to assume 'namelen' for the length of the string
> to be copied.

By "length of a string" usually the number of non-null chars is meant
(i.e. strlen(str)).

So the variable 'namelen' is confusingly named, a better one would be names=
ize.

>
> [1] KSPP#88

I don't understand this notation.

Patch itself looks good.

Thanks,
Miklos

