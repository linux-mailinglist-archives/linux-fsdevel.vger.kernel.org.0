Return-Path: <linux-fsdevel+bounces-38409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597BA020EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 09:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BD47A1F96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 08:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E398C1D90B3;
	Mon,  6 Jan 2025 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOKiGDxQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCE1D8DE1;
	Mon,  6 Jan 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152524; cv=none; b=q3QrF08RHRO1eoEZrg2Uwz+Jv6+mQanfOTbOhDRnsIA2eGyOr6tgE1s4ogPkZ/piyY3c9bCqwccjUHr4ElVebZaIhhzHS5oOrzskoeiYJy5y2pgN0IwCqnAoX/IyYfkRUqMktAAQIdtnXqfP2otuYURVX/TXzl5XY7uSvUpnftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152524; c=relaxed/simple;
	bh=H+gFINVbb+nOCEqT9QQN/XMGSyGN9OGVfjvZIOdNJwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHlBGbQiDJ17U+Mh38+DFUXdezIhQvwi+eA5DgT2fO3mS8pOBH1y/j1kxngYO/Jz4n2UBMzNrKZM0eVSKKamp5e9kM0cT6fBLRh2rsbS5N6UVm+9YSk1LC5UhsUrrNzyCAYkkQFuhzNC5ntmBFKGspeGgdOo1qVXNSOJt6nRbcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOKiGDxQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401e6efffcso16580626e87.3;
        Mon, 06 Jan 2025 00:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736152517; x=1736757317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq36ONrrzNeUzm/WBB++1PFiUlFmJ9wXn3DMdB5FnEA=;
        b=cOKiGDxQl3KgGY77mXBhdWLcU68pPWMCxqutclKtvqfvRbkjb/n2qkHqHC1fq8Jsdo
         vfBkjJEnlERaV1CBCrvbE9rb0s9CldrQrh9Hv2BB3SSZ1v7/goaW7xOT4AJ4eZEA37re
         jqnzkacg3CagTqvavf3A/gW7ysxaaMKuPMw2d67ilct9Kc+vA8BeeKuMqRBfcp5/EBr7
         Ws+LeXe5zw1Cdtf/vbXs/5e0GypmBVEnFyBzgZJDg3S4J9zsjoGsl5IDrMpKBNIl8Fr8
         DpFXYl8Od2Ec/MAFLLuECJVOlS/j7qly7PgskWyi4fhEKo0YZGGQORtu79Pe05Uv19E8
         pJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736152517; x=1736757317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq36ONrrzNeUzm/WBB++1PFiUlFmJ9wXn3DMdB5FnEA=;
        b=MaR//1tfhtoooNcYExM1bMJPavC4vRY490XuKwrsypKhLsmc93k73ZXBaJw9Ys+BlU
         qbQOptYw80815TFY4oxZsYeyNIBgdhKY7o9p2O5HeFDSJFfv/qcxyKjzRH0rxlfACgeP
         EQIKr3Tq9JPhWMreoiP9tZNUMdkJrbhgjt6cDyBRdOtMAYbHX8py9bN5kF8fJsDdTqDf
         DiJsWycFuVUI+3UzegFbK/+w3NsOBZwV9cgN79MSAGlR7LqC6TA7MZJvds/rsUKTWuy9
         YUAbBp1piLAoFXz6cO311f+FqcaFdN68D1wBfYZhb0dX1XbmtJdRw7JxYj1ALgI5lQrW
         +28w==
X-Forwarded-Encrypted: i=1; AJvYcCUN6DfEUv5EipNovDbGwnxJJH8C532rL9XC6NC4FmguS5A8w33cpbIBUyeYkicUchnbZkZ+aHqS+frz@vger.kernel.org, AJvYcCW0kQrdXWOHVPENrwCblxDgkD18k+OkDfGW3LLd1wJUbj1TfPWy5L/3PCZBqs+32azkMSzEcerf8KEKpqpI@vger.kernel.org
X-Gm-Message-State: AOJu0YzkfZ2egRqg6blMioFNGxxmX9ZEkfk9cQp2Rv1c24E/4VbMtuC7
	hHQK/S3fZlWfGUbWASlTyxUmZeJ90X25r1ZWF7MSqNkbr+yLmeiJPu7dwAnscEWgJBdpfg7UKyt
	mbuC1t/yEyogaWfP0ZYGdTzF5SEpLCefoyzTZ2wYj
X-Gm-Gg: ASbGncueeFr8sZHNfB4010SAdv6x8r22GHhKUPO971sgr7UX9CY+ZuWRxhv6OTKdRiO
	TtuEJmC/fy4ScILwZHB5m+Wj4AbTn+FtQtxd1oV8=
X-Google-Smtp-Source: AGHT+IF58MtI8FTeFFToH4mIQ4HnNZKlvKx8EUWDToPP070VoXPwU3tV9FWEzY8FSPGyvsgv1QKAWyv/q8qb9uQKgtQ=
X-Received: by 2002:a05:6512:3d86:b0:542:218a:2af7 with SMTP id
 2adb3069b0e04-54229538b19mr18578842e87.15.1736152516643; Mon, 06 Jan 2025
 00:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920122851.215641-1-sunjunchao2870@gmail.com> <20240925-gewillt-bankintern-0fd0ba5bca82@brauner>
In-Reply-To: <20240925-gewillt-bankintern-0fd0ba5bca82@brauner>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Mon, 6 Jan 2025 16:35:05 +0800
Message-ID: <CAHB1NaicZFAGDHaOxiKDL+wcSx2ncWcKNLBBATDBfJ+9bxLa+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] vfs: Fix implicit conversion problem when testing
 overflow case
To: Christian Brauner <brauner@kernel.org>
Cc: stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed this patch hasn=E2=80=99t been merged into 6.13. Was it overlooke=
d
or rejected?

Christian Brauner <brauner@kernel.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=B8=89 16:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 20 Sep 2024 20:28:51 +0800, Julian Sun wrote:
> > The overflow check in generic_copy_file_checks() and generic_remap_chec=
ks()
> > is now broken because the result of the addition is implicitly converte=
d to
> > an unsigned type, which disrupts the comparison with signed numbers.
> > This caused the kernel to not return EOVERFLOW in copy_file_range()
> > call with len is set to 0xffffffffa003e45bul.
> >
> > Use the check_add_overflow() macro to fix this issue.
> >
> > [...]
>
> Applied to the vfs.misc.v6.13 branch of the vfs/vfs.git tree.
> Patches in the vfs.misc.v6.13 branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc.v6.13
>
> [2/3] vfs: Fix implicit conversion problem when testing overflow case
>       https://git.kernel.org/vfs/vfs/c/8f3ab2511887



--=20
Julian Sun <sunjunchao2870@gmail.com>

