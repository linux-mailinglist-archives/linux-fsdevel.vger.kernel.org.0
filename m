Return-Path: <linux-fsdevel+bounces-48663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ED1AB1CEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 21:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABC01C06C20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD364241691;
	Fri,  9 May 2025 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="y+QYhiNx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C623C384
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817355; cv=none; b=eiPk7EXMaOktTmd/MzUORAiU6gTsSkH7j/a684Gegb69FwTppGiUbiYIpE/nXjH3S0iEPvMYYsSKDJGeCy3E9itsaoP87sYAuDk6B+oBlIemkgGNCZb8tZluH66/JfUv0XlZQH1u1pcNrc1sWNvfbECk+3Hptgs6lVdTJhBmRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817355; c=relaxed/simple;
	bh=jlIYNxCTwNnS/l56FRIIVYjtR1W9OmMKAxZDOlu4ge4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cn1y/CC59DWI6J3Kx2NYHvREjKKSdC0XjL2GzmjM5Npj+WS+N1v9OC9xcXNrprilK51FZh4P7Z2XstpoMLeHy0RHlt1iUiXtW/KCQykByppWDtwpjTVC8NVH1EP1rllAJdGmvyrJhdUHgZOeXHT9rAsjGzDvI62cUbAlIsPqebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=y+QYhiNx; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso1800069fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1746817352; x=1747422152; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jlIYNxCTwNnS/l56FRIIVYjtR1W9OmMKAxZDOlu4ge4=;
        b=y+QYhiNxT+8Eq0W5s8L54Ro53OrQwxvQtddTXEF9ijWZvDVG0xJgS71vq9okjsFyvs
         TEBOWgGbwmWF924bz18mFhNq8WSo6Ji+ibfVVHf+DHPfJdldgm5vr3pIEkmz07cdevO3
         cwY/jc8FNXzTNvNHauLxyHZCXWCwA+bVV8FfX16DkW0qNmOOeYDz6gyqSQOw7v41RmoE
         7bX58tC9K1dlO6JT2Qm4z7ax4hUHcYjmSJCcY7s1zQeIHs9ppcmgXLmOsIfERklJxK4Q
         ZoveX3u2CtEy0bpz0VDlVHj0hXTjhl+ju3Qitm0KGZYZ8Aap+FYA0E/ySkXKkzYqQRCc
         vKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746817352; x=1747422152;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlIYNxCTwNnS/l56FRIIVYjtR1W9OmMKAxZDOlu4ge4=;
        b=nVJqil0ZU2k4zuiizkNXbwLakhjpL5o8jxYUKErmVBQw2eReBgKZ/d21eWb4BkoQIc
         oxbfSK6nNd9Q5R5eJslkVeZCeNp7WsiO4mBANnL7NU8oxwLjMSE6AG9O5rk7L3Ok67Yj
         mdtr//KMHLGzksUopXJjFLxTBt7rz0Spq0CeA5iCExifCbYSnD9eHUDNcy2dd7wfiQ0P
         XA8JoGTsXHBAKtEQ65lJ6KGCvik7nsLdF0G6HmJYKmxpfjBzRtlosNTCj5vFbxaJT0tp
         cGqRyq3MHiHnPIhmSlaxhV0JdMo5Y/rubA9P7qu5Blpx3Y9f1zWamx6dO25rJlZLPhfv
         yTvQ==
X-Gm-Message-State: AOJu0YzGzfLmm5oVcv7ToJwzjxKWsjmQ+jjAuljgx/Jl9Is7jWZFqU4J
	CD2djoe4giwZb3QvQvVMT0iIw/J1Yceduh+0/IqST+bBENJ6n8OeigdEuvp3/qIrDidoBwPKh6N
	wZpM=
X-Gm-Gg: ASbGncv2fBfhhUoj2mBKheq2dCJzEfhYIdVY2TZeDQnx0XCfZ2EvNKSN0UlgHWegNzp
	KicMIgP3qreH1TXxE9ArP526AVQfxCsV9+SvZCB4NDR5FwaKymkTZtz0kOh4MpnIGo34WA4PEhn
	QStxgztg1YTWp2PpCJ9AXy4xkPoxdAhhBybUa7sReTHHZM92grjtalqSKWeU1QzItommRG1cCxA
	iN1EfHgQlgBrhRX7PlnJ/GwEwLEWgW5mgQXk8v+KSO1NGXBXXRqS58f8xABibXfrXA2V0ehkeg7
	YHLx1ej7Ls9jRZhQ/sgq1K0gE5NZB+bTt6U5X0yAFEgfae66WQMvKRG6xEp16cA=
X-Google-Smtp-Source: AGHT+IFa0NKyRsiAGbkiBgaS0E0hxf42GonnAI7ZlDTR8C7VVJdkwGn98KDi7yyzE09SPbgqbCTUjQ==
X-Received: by 2002:a05:6870:d114:b0:2c1:9897:dd24 with SMTP id 586e51a60fabf-2dba45ccc76mr3220237fac.35.1746817351971;
        Fri, 09 May 2025 12:02:31 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:f242:4c31:ff5d:e2b7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2dba0afc9a7sm725918fac.35.2025.05.09.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 12:02:31 -0700 (PDT)
Message-ID: <d83f9ef1820c52004ce82ce69e58333ba83af85d.camel@dubeyko.com>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?=  [PATCH 2/2] hfs: fix to
 update ctime after rename
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: =?UTF-8?Q?=E6=9D=8E=E6=89=AC=E9=9F=AC?= <frank.li@vivo.com>,  Viacheslav
 Dubeyko <Slava.Dubeyko@ibm.com>, "glaubitz@physik.fu-berlin.de"
 <glaubitz@physik.fu-berlin.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 09 May 2025 12:02:29 -0700
In-Reply-To: <c19db3b68063cd361c475aaebdd95a232aef710c.camel@dubeyko.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
			 <20250429201517.101323-2-frank.li@vivo.com>
		 <24ef85453961b830e6ab49ea3f8f81ff7c472875.camel@ibm.com>
		 <SEZPR06MB5269E572825AE202D1E146A6E888A@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <c19db3b68063cd361c475aaebdd95a232aef710c.camel@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 10:51 -0700, Viacheslav Dubeyko wrote:
> On Wed, 2025-05-07 at 14:22 +0000, =E6=9D=8E=E6=89=AC=E9=9F=AC wrote:
> > Hi Slava,
> >=20
> > > =C2=A0=C2=A0 +ERROR: access time has changed for file1 after remount
> > > =C2=A0=C2=A0 +ERROR: access time has changed after modifying file1
> > > =C2=A0=C2=A0 +ERROR: access time has changed for file in read-only
> > > filesystem
> >=20
> > > It looks like that it is not the whole fix of the issue for HFS
> > > case.
> >=20
> > The test cases that failed after applying this patch are all
> > related
> > to the atime not being updated,
>=20
> If I understood correctly "ERROR: access time has changed for file1
> after remount" means atime has been changed.
>=20
> > but hfs actually does not have atime.=20
> >=20
>=20
> But how the test detects that atime has been updated? If HFS hasn't
> atime, then test cannot detect such update, from my point of view.
>=20

As far as I can see, HFS code operates by atime [1 - 3]. As a result,
generic_fillattr [4] can retrieve the atime value. If we don't store
atime in the on-disk metadata, then the test could see inconsistent
atime value. I believe that dirMdDat/filMdDat (mtime) needs to be
considered as atime too. Because, modification cannot be done without
access action. So, atime =3D=3D mtime.

Thanks,
Slava.

> > So the current fix is =E2=80=8B=E2=80=8Bsufficient, should we modify th=
e 003 test
> > case?
> >=20
>=20
> I don't think so. Probably, something is wrong in HFS code. We need
> to
> double check it.
>=20
> Thanks,
> Slava.
>=20
> > =C2=A0=C2=A0 dirCrDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=
=A0=C2=A0 {date and time of creation}
> > =C2=A0=C2=A0 dirMdDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=
=A0=C2=A0 {date and time of last modification}
> > =C2=A0=C2=A0 dirBkDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=
=A0=C2=A0 {date and time of last backup}
> >=20
> > =C2=A0=C2=A0 filCrDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=
=A0=C2=A0 {date and time of creation}
> > =C2=A0=C2=A0 filMdDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=
=A0=C2=A0 {date and time of last modification}
> > =C2=A0=C2=A0 filBkDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=
=A0=C2=A0 {date and time of last backup}
> >=20
> > Thanks,
> > Yangtao

[1] https://elixir.bootlin.com/linux/v6.12.6/source/fs/hfs/sysdep.c#L35
[2] https://elixir.bootlin.com/linux/v6.12.6/source/fs/hfs/inode.c#L356
[3] https://elixir.bootlin.com/linux/v6.12.6/source/fs/hfs/inode.c#L367
[4] https://elixir.bootlin.com/linux/v6.12.6/source/fs/stat.c#L60

