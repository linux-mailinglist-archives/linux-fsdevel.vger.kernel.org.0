Return-Path: <linux-fsdevel+bounces-44954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34143A6FA8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898D21892BC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867F256C7B;
	Tue, 25 Mar 2025 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lz1M7sFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F62571C1
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903885; cv=none; b=B3DqhfhDTu8v6rJmjKCXcqruCMZh96AAqAq2BD31GloVXa3yezm4Mas8OtumN39aJL52hIrPk3QTGevcSH6/anhY+v9ixbjYulXDYkDH9D9B2PPR3+C2KWxK1TrwLjZTOidgOV3AU9WDFZxsYy7gZ6h5nUAgGFEdWnkgD+GTKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903885; c=relaxed/simple;
	bh=EhkCcKvMO5FXE+BxXjdos8aDqMsGvPPSOVvmXd199Ng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kRM5Iue0XZbvKnyGZlU1bOeSaX9Wt2wx3cHpT8PGD2NWad7jmKEe9mLe5bTO3+CZyPJHdue9bh6591uyFkWZ7irKZtu9s469QJ0QJ5K/2G1hCKNtduutwUrGFKdYO27bHVjXFNlrLY4OBctuBcrjTANkr27eAw6Ffcovu1I04JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lz1M7sFy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742903881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66ScJ5U4mFltzfqo02WJQQOu9FrvajI5Tu1fFaDtkl4=;
	b=Lz1M7sFyeXzgHjfuMBjoXtgjtY6yr48h5QD0Tmen3MFh9Bw8zGQ7OW8eJoolA4VZa7x0BW
	R7TKI1MG4hsEJHW5/DD9wPF94OaK33MQ2rmTU9VLayO6ir80+FJbtiAc5o6XGhdtOvV5da
	TFJIU5HHxNzuZHK7j7plLv27D5N37Os=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-rU1h3beIO3ubSMiLHGXvUQ-1; Tue, 25 Mar 2025 07:57:58 -0400
X-MC-Unique: rU1h3beIO3ubSMiLHGXvUQ-1
X-Mimecast-MFC-AGG-ID: rU1h3beIO3ubSMiLHGXvUQ_1742903877
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30c0c56a73aso26292021fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 04:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903877; x=1743508677;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66ScJ5U4mFltzfqo02WJQQOu9FrvajI5Tu1fFaDtkl4=;
        b=LFkB4F62oJL+zDITaXPkBhdPZjVasXg2OSTzYHjp+YBewDIXemijD1ObFJkvA7JcDU
         LOxkHaQDC9BpFSyzZZwhY/eAI5sNnq1Sk7+T8I6Qtl0XhfrdeyA0LdixiOSt7KJ+UWov
         r++XrT2uHzhikaVmdud/Z3oYQFWiKBamw79gSJwEsMlbgD3B/mf2kTOqz7IsJLxB/ucN
         FaWqujTLlBOFKyAXohaBED98bn/2cck7p/h1qc6zJkHBmeKN00dD4dNIkL5bUpL2K9ah
         wycqGctawd1n+Id2db8MZVgW7Vqg8miwxQEZdINUHujdo6GkvL/OnvRx8mfRWDzR+XmH
         eCBw==
X-Forwarded-Encrypted: i=1; AJvYcCXoFX91ibEw0JK+mfkWmwh2Xo4dUgHZb9yYaDSn5Eksw2tAtzkpWwmiuoSnGic7JFVgYCGOnhqrwms/fbnm@vger.kernel.org
X-Gm-Message-State: AOJu0YxFR6GFW9r777okbH8cnR+ILYOpt438iTLNPIJq6lFQ7ATDiwMJ
	dmLl3h/5pqrxryOv+hEpYYjvN/En0/6AQHiaCP3mYt1ANnGSm8/0coLR60GXdzi2VjsWyvvJSeU
	WWUg30il3HHx4WpN+OExBGax2KOIysPSgjP8/i2L3GDerGbCV6KXKG7xu17yaamI=
X-Gm-Gg: ASbGnctbtWEs9kneYk6AuULCvFCSas/t2lum/Va66FYGwDCv6t7lm4QnHmh5qE4Y1Ch
	ZS98NvTVRkWF9wxDA/og9T1U3xATLVhFvdM3wZjXhXZ4mSl9ea1WhjGyR3fbBo6ZcTjlM8MjCf0
	Wjj0k7CmHdIDVPP/8w11sTm/NIA0nFHt7JBTYGgTbj5dn5y4CAJf0KP0YNnM558J2RFAhUoOGbo
	iQg0OOOai6sxXwsVlcTjFUeTRRNHSCeQBK+73rfXNEP/q9EPHwQLpscQwoKEad9Zuebl8tdzKob
	OuJ3QTimDF6g0jOcAaNxhDfjy24GHkjuXtlkspbY5KzQuBozUeMGkmo=
X-Received: by 2002:a05:651c:170d:b0:30c:460f:f56 with SMTP id 38308e7fff4ca-30d7e2349a2mr51836641fa.20.1742903876760;
        Tue, 25 Mar 2025 04:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFsVQ5ThcgNl6aFdF7RZUEJ9ftLWGxPNlNQbEsFkk48iEQQ4ebeeG5mcwR88P3gcTTqWHXCA==
X-Received: by 2002:a05:651c:170d:b0:30c:460f:f56 with SMTP id 38308e7fff4ca-30d7e2349a2mr51836521fa.20.1742903876296;
        Tue, 25 Mar 2025 04:57:56 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7c1d8esm17547331fa.13.2025.03.25.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:57:55 -0700 (PDT)
Message-ID: <636546d444306b8af453cdf126453a8a1f0404d1.camel@redhat.com>
Subject: Re: [PATCH v2 1/5] ovl: don't allow datadir only
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Giuseppe Scrivano <gscrivan@redhat.com>, stable@vger.kernel.org
Date: Tue, 25 Mar 2025 12:57:54 +0100
In-Reply-To: <20250325104634.162496-2-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
	 <20250325104634.162496-2-mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-25 at 11:46 +0100, Miklos Szeredi wrote:
> In theory overlayfs could support upper layer directly referring to a
> data
> layer, but there's no current use case for this.
>=20
> Originally, when data-only layers were introduced, this wasn't
> allowed,
> only introduced by the "datadir+" feature, but without actually
> handling
> this case, resulting in an Oops.
>=20
> Fix by disallowing datadir without lowerdir.
>=20
> Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Fixes: 24e16e385f22 ("ovl: add support for appending lowerdirs one by
> one")
> Cc: <stable@vger.kernel.org> # v6.7
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Alexander Larsson <alexl@redhat.com>


> =C2=A0		return ERR_PTR(-EINVAL);
> =C2=A0	}
> =C2=A0
> +	if (ctx->nr =3D=3D ctx->nr_data) {
> +		pr_err("at least one non-data lowerdir is
> required\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> =C2=A0	err =3D -EINVAL;
> =C2=A0	for (i =3D 0; i < ctx->nr; i++) {
> =C2=A0		l =3D &ctx->lower[i];

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's an obese crooked filmmaker trapped in a world he never made. She's
a=20
provocative red-headed stripper from a different time and place. They=20
fight crime!=20


