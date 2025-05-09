Return-Path: <linux-fsdevel+bounces-48654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC3AB1BC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627CA9E5AAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8774215060;
	Fri,  9 May 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="yu6e1gp3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1B238C2F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813108; cv=none; b=G3Pc1d2kj286Mfz8ab54Rscq3efNRksqJ/13S87K0c2qSSQx8Vizhv2sYvfa2+cGtLIuNjTcKy2xV/CLrZ1p8pPBfLoIoXAYsOdGmBf1vX5WjK3oh4VB8tFkM0gdj+9qbI48Z5LTcFiLHfewT19maEHtLXbYu/WtrMyigvFPoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813108; c=relaxed/simple;
	bh=Q/eDqnaWNfB1O7xKE77ouU9p0ZDT+uECIZdfEDtngBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pc8Mu1/iZ7lhGE+5YfIAklfNfEfAq4qYJxD/9W3VUZ/Ba3DX1J8BDJBPSicePxNX83EaoKW5VVg9sqtKIRhz1NHsY5kwp40Qz02HnYsz/5OhZNgDoBpxew0D/92G7CRjVPSdkjanBP+VkQrICaK2xHFv0y7/VWcwalk6Y+592TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=yu6e1gp3; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72b82c8230aso832465a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1746813105; x=1747417905; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q/eDqnaWNfB1O7xKE77ouU9p0ZDT+uECIZdfEDtngBE=;
        b=yu6e1gp3yzRODnpCUm0YUPeerrwDWg+5lzvXTxiKULbHEO195hyoZjEMkiAF9rTUtO
         kK7XpqDOSS0to/vBR0Xp/y3Iy8t0UG0h72Iv5nyWHiJIeezC5QBP9zSI7HP0Zk8NtGDM
         CRtm0VHgrUEyvmj3BsQYyQrWHAa3EhsXqWHpGD3MpdUC+pXkgTPuaZN2sD6x5+GAOzVF
         7dza4C3NyIbY4ZgPwyiG//YxVec9rMetjlTzkQqpsg6lLjgnPvEjtTao0042FeseM+94
         G9V57kMLy7o01UHxz8Y6R+EKEVn9IxeN8OPUtvu9tJGQ85iRC0U9YHCV5T5NO0yksLGv
         Yvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746813105; x=1747417905;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/eDqnaWNfB1O7xKE77ouU9p0ZDT+uECIZdfEDtngBE=;
        b=G4j7yGXN93+SvGjD5Yws/X9x1jKQvE5JWBsxCM0At1Y/lzuWtAcYKEJB+x7WGR2V64
         R2iLgAwK+UUY6sMuDgGhna+09oiPEZKG8s6tZQoKEHgPxDphw/7yOZobW57zbBH7z40p
         tWZhRoHo5o0FelxvuER99BfyjQHfKXeEojAz9i03V/S7aXcDbWRreRal1+Zlxv0GZvWZ
         hb3/2D6LvSHQS5TewKDiAbNiOSyylfYXFv1uyLkQCrahrBD2q8CoWZrDaQJG87sb1kev
         w2XS54s0KbHMeKWjkNsG6/W8oA/YKuJwb0H4vW5AsIe/nEI2vAFWROllDJjwhTNOGpys
         yxFg==
X-Gm-Message-State: AOJu0Yx21nBYQo01c7fKaGGEU2H27a6xnbuV0WJHOhrTCpvccEbCGLrT
	6cUKKLZRqa62YLgsAS57FhomVeFFquw36YEZunmNXpSi66SO12hHTSwXX6d3E00=
X-Gm-Gg: ASbGncugakWcgiW3vw4WtpRdCxgONum4SaxBSDCCTdJN5pJUdUt4+eUZy6WdJlY6ZjK
	soAhHjgYHejvD9GZSxdG4ETodmFXHwJSa4bwj4ePxjR4xPMaG/mcaBJAE0DlNNKWJ68gpgwPmF2
	/8jgjvAhTwmN4puz+mD8n+GTp3oUISoEvqF/f2yNWLMXfmlnTFBSVccHCQchIcs4uvNfVCIDdFY
	AwcMOmdrocKfpwLGSTmdfO0aVFvjj92nzOU3zFz4qqZ05MYWwy1ERn1TMMyreForcgVuPJ4Cdq3
	yfifwAamxYkN5xKIQ+wznQdaRkr9VbHPWw1t42MDVOyodMP5voda
X-Google-Smtp-Source: AGHT+IHDCQ7Ns9Wq06VLrKzTLv74WPBLip6/SOmObU7e4P5+nkf8W86+WJ2FlLyUAMn2pLU0ZAdu7w==
X-Received: by 2002:a05:6830:71a3:b0:72c:3289:827c with SMTP id 46e09a7af769-73226a3b787mr2700710a34.16.1746813105531;
        Fri, 09 May 2025 10:51:45 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:f242:4c31:ff5d:e2b7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732265cd9b4sm610362a34.52.2025.05.09.10.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:51:44 -0700 (PDT)
Message-ID: <c19db3b68063cd361c475aaebdd95a232aef710c.camel@dubeyko.com>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?=  [PATCH 2/2] hfs: fix to
 update ctime after rename
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: =?UTF-8?Q?=E6=9D=8E=E6=89=AC=E9=9F=AC?= <frank.li@vivo.com>,  Viacheslav
 Dubeyko <Slava.Dubeyko@ibm.com>, "glaubitz@physik.fu-berlin.de"
 <glaubitz@physik.fu-berlin.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 09 May 2025 10:51:43 -0700
In-Reply-To: <SEZPR06MB5269E572825AE202D1E146A6E888A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
		 <20250429201517.101323-2-frank.li@vivo.com>
	 <24ef85453961b830e6ab49ea3f8f81ff7c472875.camel@ibm.com>
	 <SEZPR06MB5269E572825AE202D1E146A6E888A@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 14:22 +0000, =E6=9D=8E=E6=89=AC=E9=9F=AC wrote:
> Hi Slava,
>=20
> > =C2=A0=C2=A0 +ERROR: access time has changed for file1 after remount
> > =C2=A0=C2=A0 +ERROR: access time has changed after modifying file1
> > =C2=A0=C2=A0 +ERROR: access time has changed for file in read-only file=
system
>=20
> > It looks like that it is not the whole fix of the issue for HFS
> > case.
>=20
> The test cases that failed after applying this patch are all related
> to the atime not being updated,

If I understood correctly "ERROR: access time has changed for file1
after remount" means atime has been changed.

> but hfs actually does not have atime.=20
>=20

But how the test detects that atime has been updated? If HFS hasn't
atime, then test cannot detect such update, from my point of view.

> So the current fix is =E2=80=8B=E2=80=8Bsufficient, should we modify the =
003 test
> case?
>=20

I don't think so. Probably, something is wrong in HFS code. We need to
double check it.

Thanks,
Slava.

> =C2=A0=C2=A0 dirCrDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of creation}
> =C2=A0=C2=A0 dirMdDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last modification}
> =C2=A0=C2=A0 dirBkDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last backup}
>=20
> =C2=A0=C2=A0 filCrDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of creation}
> =C2=A0=C2=A0 filMdDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last modification}
> =C2=A0=C2=A0 filBkDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last backup}
>=20
> Thanks,
> Yangtao

