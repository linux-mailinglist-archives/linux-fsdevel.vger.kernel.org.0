Return-Path: <linux-fsdevel+bounces-4707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF82802746
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 21:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EC6B20818
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 20:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6859218646
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="sJFG5M3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F78C0
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 12:11:21 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50be03cc8a3so2388536e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Dec 2023 12:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1701634280; x=1702239080; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoYaUinr8b+tkgabYLkrdYXM9IqNfemzC0q7KxnZpVg=;
        b=sJFG5M3hk/oUBPvmoSbh5OqLmVEc642ghqbWsZPSAJsbonAs59qNTH7cZO0IsdPww9
         C2SeEMm+5hSJ+0wLcmmt3cZkv1A7fw8u05fVcyjaMJWQtRTXnSF1nvNtpcRGSi1p89A9
         MNYJYkcjQC5sd02Np3BEyy0M7QKIbDo9uiTI269Op45Z6bYWZm9DhBIK0d/x/R3sNX17
         nCaphaM5VfykKUBZXEu8ZD4koEnYFeMEKTyefCnaS96nqGv8FY2GAdh9AvTsxMYxgTic
         9a3BLg0xR8tM1KDmOADNE8g6WqtAbrFoHfxSaFxFxqdrcGzmpQubkUJiJmCrOxM+6AEn
         cbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701634280; x=1702239080;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoYaUinr8b+tkgabYLkrdYXM9IqNfemzC0q7KxnZpVg=;
        b=tMS9IMkCRGZMUbmI3HLAJ3ItZoI1UVtqboe8ZJDxpu0r5GZghoMLfaziqITLz04Q1t
         hgABUxACZM9R4RP+oDKwPL1a74hSv0oxEqJxv7IM7wCKZcApPfZdx4SQACS2NUBP0AyF
         ab73LJG6dGdHIWod1FJYdx6XFB/ihGsZJ6Si2o0lf3ScxX4sFkIiXzmLMVxxPiYkJPvQ
         eXEK2gjTOaxVl5S99FyaBSYyuJCVuqfivZhUmo9vdEnr7eENx9CeBpv7GmokLimWABVp
         VuqCLH9BVeLMfKq+r52o90LvlYiMtka1ngurTPNslRVuLr2DVKxmqYt0GnK5+RgwGIME
         HRKA==
X-Gm-Message-State: AOJu0YzlihpK12pDqgaa7OiYPaYLvXIT3NOsU6KyPSy1jDBO5ewIqFKy
	r9M5DebuPtbipgIzd+1pIboHiO4+fA73s/mNhGvq5szM
X-Google-Smtp-Source: AGHT+IGWlpgNCA9Q8/cPm4KtNT3CYX8uIzwpV+RPWmgRycZGdrepquy/In0NZxihv4PP/XXQNagpmw==
X-Received: by 2002:a19:500d:0:b0:50b:f1e9:b0ea with SMTP id e13-20020a19500d000000b0050bf1e9b0eamr414905lfb.100.1701634279645;
        Sun, 03 Dec 2023 12:11:19 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:2d98:8daa:a4e8:b964])
        by smtp.gmail.com with ESMTPSA id be17-20020a056512251100b0050bc39bdd43sm43774lfb.211.2023.12.03.12.11.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2023 12:11:19 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Issue with 8K folio size in __filemap_get_folio()
Message-Id: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com>
Date: Sun, 3 Dec 2023 23:11:14 +0300
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)

Hi Matthew,

I believe we have issue in __filemap_get_folio() logic for the case of =
8K folio size (order is equal to 1).

Let=E2=80=99s imagine we have such code and folio is not created yet for =
index =3D=3D 0:

fgf_t fgp_flags =3D FGP_WRITEBEGIN;

mapping_set_large_folios(mapping);
fgp_flags |=3D fgf_set_order(8192);

folio =3D __filemap_get_folio(mapping, 0, fgf_flags, =
mapping_gfp_mask(mapping));

As a result, we received folio with size 4K but not 8K as it was =
expected:

struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t =
index,
		fgf_t fgp_flags, gfp_t gfp)
{

	folio =3D filemap_get_entry(mapping, index);
	if (xa_is_value(folio))
		folio =3D NULL;
	if (!folio)
		goto no_page;   <=E2=80=94=E2=80=94 we have no folio, so =
we jump to no_page

/* skipped */

no_page:
	if (!folio && (fgp_flags & FGP_CREAT)) {
		unsigned order =3D FGF_GET_ORDER(fgp_flags);  <=E2=80=94=E2=
=80=94 we have order =3D=3D 1
		int err;

/* skipped */

		if (!mapping_large_folio_support(mapping)) <=E2=80=94 we =
set up the support of large folios
			order =3D 0;
		if (order > MAX_PAGECACHE_ORDER)
			order =3D MAX_PAGECACHE_ORDER;
		/* If we're not aligned, allocate a smaller folio */
		if (index & ((1UL << order) - 1))
			order =3D __ffs(index);

/* we still have order is equal to 1 here */

		do {
			gfp_t alloc_gfp =3D gfp;

			err =3D -ENOMEM;
			if (order =3D=3D 1)
				order =3D 0;  <=E2=80=94=E2=80=94 we =
correct the order to zero because order was 1

			if (order > 0)
				alloc_gfp |=3D __GFP_NORETRY | =
__GFP_NOWARN;
			folio =3D filemap_alloc_folio(alloc_gfp, order);

/* Finally, we allocated folio with 4K instead of 8K */

			if (!folio)
				continue;

/* skipped */
		} while (order-- > 0);

/* skipped */
	}

	if (!folio)
		return ERR_PTR(-ENOENT);
	return folio;
}

So, why do we correct the order to zero always if order is equal to one?
It sounds for me like incorrect logic. Even if we consider the troubles
with memory allocation, then we will try allocate, for example, 16K, =
exclude 8K,
and, finally, will try to allocate 4K. This logic puzzles me anyway.
Do I miss something here?

Thanks,
Slava.





