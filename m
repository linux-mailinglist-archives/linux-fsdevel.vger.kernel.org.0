Return-Path: <linux-fsdevel+bounces-10452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460B84B48A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E5C1F270FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670601339B7;
	Tue,  6 Feb 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="FhIMWAl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEAB133996
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221140; cv=none; b=MgKFFpBoGjgUAP6O+P43vC8g6QPrWoGKlZk8tkO22hzMYIuJpR5LROdsSDmOEzMIj7frqsX75qdHmXK4m3WCG7UlaHrlQ3jHJl+WlhusVVaJroay5gtr10Kz2kvTtTc9+tArZOvJNHhvisYgfoKevs95U0rws4xUvMqhFjEGf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221140; c=relaxed/simple;
	bh=kCxpyhCIkD8sI2H48EGdcEy1zXvmczzB34iTUOyHnfY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aV8mP5FkT6nUT6PrMUFimoWPe67yz/OBmKEtktsYgF0j3B7jSDa/sloPBrwU3ta/dpMCCjyrHt/mydMH4on8tGVF91n+t4oziSPrQZVAmrOAKt+HJm1qThspvublaKxBfh56n6uk1zWxMTpC2OU1tDItEK4bcXiARfIqqxhigQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=FhIMWAl3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51124e08565so8495756e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 04:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1707221135; x=1707825935; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCxpyhCIkD8sI2H48EGdcEy1zXvmczzB34iTUOyHnfY=;
        b=FhIMWAl3DYnhLV6GE8jMWNGmvrUx/AcOpr+TnbnusqGH56PYJ82tTO6IbB92BoR3lD
         i1zvxBNO4Mffdn70AzED+NbZbTnq30WE+vs90FqbylUa9gzr1vymk8VEWJoH2PePFono
         thJ9auu627HPWr8HZTgUeHnipJtWG+myxPFnhefbz+fMrVfJiHd8nxBCtpOseT7ObjVM
         8VvU+FwtEjWFYUmISW2Mzqb4I8R12bofWoJm9uy3oGbLLRH3yKTW8GfSYP6WaneRYH98
         QZ700EPtng23bdABgwbDj+h6R5MLhTWsvcVvg0fRmM7EVk41M+numFB4vfC+5F9eeYRj
         Me8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707221135; x=1707825935;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCxpyhCIkD8sI2H48EGdcEy1zXvmczzB34iTUOyHnfY=;
        b=P1YRUw/wo1R55NCh8LcZ24y1nlmymY9FagmTF+MLZyUMn1u93GY8YRPtS2/JUxnfWs
         NMN/7PqPnszMpf+Q13NK9/vwokiJqFZCOR87ZY5zOz+JlAtqTuXaalK6bbbf4szXax6+
         wgLgskZhjH5wVVViKMn8+K/gnPv+3VRxD3Ii06WTM1Th4sF/8gz4QwRd8z3pb0y0PNNx
         1AwoxyqZyCsi8s9TXjlkUDMcYiFHYfkrPI4wKv/XKxW0V6Sj1S1iUFvXFcyJq5wcELD3
         5+ejSaNR4/4c9CQacX6OQTLq79f8Ys3SleECug/lrvluJjKaFT9E1sFpBLlGy8D3DIep
         CwfQ==
X-Gm-Message-State: AOJu0YzbgbCSEdf1avOwFk4ysef2ju+rCqS/CUjGEqt3zkk0/PIxF7vd
	4ElDwVcgMSVw0lzqr3EDRuuTWiE91kqicxIOKicygpuR12wDjgyvRRy74fk8Iy0=
X-Google-Smtp-Source: AGHT+IFmL3jA0tK/pJj8zV+Wyl+gyHDkeuKtYcNliLU2onyBUgZDD4rxe34/DE/kwouC8oaHAhnLow==
X-Received: by 2002:a05:6512:31ce:b0:511:619b:7257 with SMTP id j14-20020a05651231ce00b00511619b7257mr297187lfe.53.1707221135306;
        Tue, 06 Feb 2024 04:05:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVygO5oyq7Iwnz00Lw7fjp1Zgsn7nN6wAE5TM1uuRrrGbjb4y+nYgmngiuRaDuLm+I4B5r+GUeiTrPOehppMgaqmSCZaUbTxaJbv8GAjVlHkdwwy1/11/N/kogLDVhWrdHryI9DvRVmHx63+VlKnRM2YbO3DJ1/smlNyGBC1VfXGzk4UaZkWPYaA+sEiA==
Received: from smtpclient.apple ([84.252.147.254])
        by smtp.gmail.com with ESMTPSA id s26-20020a056512203a00b0051152b46a8csm225374lfs.190.2024.02.06.04.05.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 04:05:34 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH next] hfsplus: fix oob in hfsplus_bnode_read_key
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <tencent_164AB8743976ED67863C2F375496E236B009@qq.com>
Date: Tue, 6 Feb 2024 15:05:23 +0300
Cc: syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9DB6A341-5689-4E4A-B485-A798810751F8@dubeyko.com>
References: <000000000000c37a740610762e55@google.com>
 <tencent_164AB8743976ED67863C2F375496E236B009@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
X-Mailer: Apple Mail (2.3774.400.31)



> On 4 Feb 2024, at 14:51, Edward Adam Davis <eadavis@qq.com> wrote:
>=20
> In hfs_brec_insert(), if data has not been moved to "data_off + size", =
the size
> should not be added when reading search_key from node->page.
>=20
> Reported-and-tested-by: =
syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> fs/hfsplus/brec.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index 1918544a7871..9e0e0c1f15a5 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -138,7 +138,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void =
*entry, int entry_len)
> * at the start of the node and it is not the new node
> */
> if (!rec && new_node !=3D node) {
> - hfs_bnode_read_key(node, fd->search_key, data_off + size);

As far as I can see, likewise pattern 'data_off + size=E2=80=99 is used =
multiple times in hfs_brec_insert().
It=E2=80=99s real source of potential bugs, for my taste. Could we =
introduce a special variable (like offset)
that can keep calculated value?

> + hfs_bnode_read_key(node, fd->search_key, data_off +=20
> + (idx_rec_off =3D=3D data_rec_off ? 0 : size));

I believe the code of hfs_brec_insert() is complicated enough.
It will be great to rework this code and to add comments with
reasonable explanation of the essence of modification. It=E2=80=99s not =
so easy
to follow how moving is related to read the key operation.

What do you think?

Thanks,
Slava.

> hfs_brec_update_parent(fd);
> }
>=20
> --=20
> 2.43.0
>=20
>=20


