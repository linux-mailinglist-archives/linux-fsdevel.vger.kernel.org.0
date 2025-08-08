Return-Path: <linux-fsdevel+bounces-57135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE10B1EEFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01FC621BE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF8F287514;
	Fri,  8 Aug 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="RD/aATFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B8265CDD
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682652; cv=none; b=mPErdnXlycP2gDsEf9bxsDagQ7fKRMFLHxILxZz0l4Wf6VqUf8FCiGBsEmx+DekkcsPPp+fKqNjHD8XHlF34v8Jqrj9p1ApO926U3LRpCyWDw2UcZcTq2SEEUAglnLvlHPkD0dsKuXlKi1I5nTVh6ZyYdy0ScgpPGG00XaEgsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682652; c=relaxed/simple;
	bh=Sc/KT9+jonRmarrGCSxuWrbwI1SSxmDuf+SesyM2xfI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SDc1OAd0G6a9ohvBKI14vOeSF/b1aoPxsjMgXvEU0Qlex3OPlmOATkADOxLH7OBp697rdtXWnugf/ggqi4HvIHSITYng7C4LZFU6n1DL/aZwiodG7mAsQYKm6tp84dIpODV3/FRwnKsmtAlHwbsgeOT+sdvnmfEu/T4VdwoTAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=RD/aATFX; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8e0c6f1707so2085441276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1754682650; x=1755287450; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1d7sy+FUtMKbSjdaZ2ag6gRU2WtgS0Mb6if8K3uW+/M=;
        b=RD/aATFXnp528yE+svEOag9V7TT6WT51MUFXZEPDjO6tTgFjEv1qpSC5dcZPrrK50h
         n8BncxTf4QIdleQe7JkigZGq3FOJuHIqvpj6V0amrGP82xkviMYzyh6MMzd4FavdlGDj
         NvsBae2Ral10/TeFp8hJIVF8aECrLEEHX7g9cVyHiu3pXsoPuWprU1A24gyi5yHbggD+
         Tz7XbSVHhU8pyI7VVqSYTTOgVDPrGccWgUBGlVerkHTfHV2HM7blV7Cd43ig2QbSE18o
         Fk2RFOQV5n9CSUoXDbHaei3ajS8wGF0WJncbC/o11SmEXXIGXvEt/h4ugSA76KpECFdY
         8PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682650; x=1755287450;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1d7sy+FUtMKbSjdaZ2ag6gRU2WtgS0Mb6if8K3uW+/M=;
        b=V6tfWD3j+bSeEukf0hnTGyXvWP63FKzV1QEkaUoxXMkdh/leNQRWgjZxRVoJ5VDSOU
         /15go9zVUFF2DKG0BOudN93G9Xu6lOYzlUEHvDdekhwzevOrC3sf3M+f29ZtdQIXnsVw
         B/Rf/cTS84LPN1+W8U3MPelPUuI72ohWKAH1yt/hYj2RvcID31rVZPccLN9xn+oH1R04
         dG/PIS5liwVnL324xM/Fsf/7mhBPNPpSLwnZ44YCiA4w5ZrsWRzxHFbnVMsxTUar8kLZ
         8Jau9pk3Jk/+c0V59uhg9EDmgka8MOoESJKp+bgd4YAlnCHsP1Wl8YgGcMeL2TAIeDFK
         6qmw==
X-Gm-Message-State: AOJu0Yz3UMFFDk6ExSoEUiRKSVzOLL2BPs2817RrgUaMxVxJJFEbK1ae
	8nm5afNhM43RIDHzMwCFYXYYV4zGX7AZJv6pHOXjgZ4WXwkcrokz+KjJ6KXAJ9eyTC/LvzX9fmF
	Nvr/BOdpOWg==
X-Gm-Gg: ASbGncuWCR2DEVDcAGDlIbIibBi/teCJVQPwUyYN3oBAeEkFEUSPf+CR7GN/cHgCZ0p
	ff8sdMaczhk5pgBo2QPHYmtjT1dgTahshlDcVQDa2bN4tn45y21MqvqeFCOSlCk2WnXZmlFoNPD
	ucAwOnxgqajWuFVe+0HZ/18FInXRA+OOEotcpyq8V5oVvwaOrHZ51aLYFPqsUtzllQWf862AWiL
	JKVmVbQRR9JrrS8XOk0rPoe1DIlkwtwT6hjCz7mZQM3TFOAFZ0kGT25owp9hWxVcR79js0ddt3I
	xDw8f3SOOViXrUPan+Ejyc0Aav45bZYWET34Vh5vtkKszpgXGbZGaRSZKTq/DtRzGgCx8AgDbeC
	oCd3CRRKfsbfhj+K8mHbc0Kyi8RE=
X-Google-Smtp-Source: AGHT+IFsb2/9BkywaesGdc2454DcyEVeVOOwSeasMddiddomuDWyzmLgsz9s3o4yTOdkkSSU5BgFPQ==
X-Received: by 2002:a05:6902:15c3:b0:e8e:1e6e:ff92 with SMTP id 3f1490d57ef6-e904b5a1b74mr5113389276.34.1754682649661;
        Fri, 08 Aug 2025 12:50:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::3d? ([2600:1700:6476:1430::3d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a9b63sm53650317b3.13.2025.08.08.12.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:50:48 -0700 (PDT)
Message-ID: <a7857b101a09c1926d69f24076231f38cf5cde96.camel@dubeyko.com>
Subject: Re: [PATCH] MAINTAINERS: update location of hfs&hfsplus trees
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, Viacheslav Dubeyko
 <Slava.Dubeyko@ibm.com>,  "glaubitz@physik.fu-berlin.de"	
 <glaubitz@physik.fu-berlin.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 08 Aug 2025 12:50:47 -0700
In-Reply-To: <c17cd9f3-0651-49ce-805f-d94ef2b232c1@vivo.com>
References: <20250729160158.2157843-1-frank.li@vivo.com>
	 <d359b20348c17c5426cca6937a96a739e9f1a7dc.camel@ibm.com>
	 <c17cd9f3-0651-49ce-805f-d94ef2b232c1@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-06 at 00:43 +0800, Yangtao Li wrote:
> Hi Slava,
>=20
> =E5=9C=A8 7/30/2025 3:12 AM, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > On Tue, 2025-07-29 at 10:01 -0600, Yangtao Li wrote:
> > > Update it at MAINTAINERS file.
> > >=20
> > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > ---
> > > =C2=A0 MAINTAINERS | 2 ++
> > > =C2=A0 1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 7a4e63bacaa4..48b25f1e2c01 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -10659,6 +10659,7 @@ M:	John Paul Adrian Glaubitz
> > > <glaubitz@physik.fu-berlin.de>
> > > =C2=A0 M:	Yangtao Li <frank.li@vivo.com>
> > > =C2=A0 L:	linux-fsdevel@vger.kernel.org
> > > =C2=A0 S:	Maintained
> > > +T:	git
> > > git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
> > > =C2=A0 F:	Documentation/filesystems/hfs.rst
> > > =C2=A0 F:	fs/hfs/
> > > =C2=A0=20
> > > @@ -10668,6 +10669,7 @@ M:	John Paul Adrian Glaubitz
> > > <glaubitz@physik.fu-berlin.de>
> > > =C2=A0 M:	Yangtao Li <frank.li@vivo.com>
> > > =C2=A0 L:	linux-fsdevel@vger.kernel.org
> > > =C2=A0 S:	Maintained
> > > +T:	git
> > > git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
> > > =C2=A0 F:	Documentation/filesystems/hfsplus.rst
> > > =C2=A0 F:	fs/hfsplus/
> > > =C2=A0=20
> > Makes sense. We need to update it here.
> >=20
> > By the way, we have also=C2=A0[1]. I am collecting patches there at
> > first too and we
> > can use it for the initial testing. Also, we have very simple bug
> > tracking
> > system [2] and I am tracking the known and opened issues there.
> > Should we add
> > this information too?
> >=20
> > We have empty WiKi there, but we could add the information there
> > too.
>=20
>=20
> Do you mind we add those facility step by step, or add those=C2=A0facilit=
y
> in=20
> one patch?
>=20
>=20

I think it makes sense to have all info in one patch. What's the point
to split it on several patches?

Thanks,
Slava.

