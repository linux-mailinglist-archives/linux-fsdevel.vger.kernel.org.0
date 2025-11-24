Return-Path: <linux-fsdevel+bounces-69711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC71C824D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 20:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C610348917
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852752D8390;
	Mon, 24 Nov 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXckLuxa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C31A9F87
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012319; cv=none; b=f78OoRlp2lJcpg/eAlF3koWOAo1lL5iDmkgRuO0n52qPrjTxI36A1XMmDl1xJAYkREoCtYdYT1ElMBqxE5VolaJL6dqMMCQLsfxzGN2egWZNyRtJ8Fg959NOO1Nvzn4iOfpsnP1Q1j+vv7cU9Vjo0OABlocwLR9Sz/5W4gcfwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012319; c=relaxed/simple;
	bh=8yAstxFCuO/xLz0Qr0ZPOrm522xtnzYWomT9NacnbJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyDhDUpK4Yeqq9UdttAYaj2ECG+xZKXAxGnMUihAkid4IXQNMBn+dJ8D2a8q1FJy7qdR8y3Mkv2D9RwZiV07VsglHaiadwqMx0Yu7SV+1mhnk4avN+W5T9+EHKiczVomTeV4Ugii4CMBOALXwA9xRrSO3tBQIwww5TrirJqJXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXckLuxa; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so7796989a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 11:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764012316; x=1764617116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9qyNmraSZxfH4EDiK1SbuyABcD2ZmeejgHMgM0Aus0=;
        b=LXckLuxarppMaCUPl9bt3hD8q7Zivui+rm8KpVNhLdmPTZ/4cc5EPaA2YKlvpnOuKT
         mEQOrnFp56r0t5ambXTrVhGFd80DrhKaecSeXYUP1UbgmdkkjV9A3Hj2jnmfG/YEHshu
         F+qU2kcmfHPORbsE8IQHxKj+WG9sXf5XTAOHfAW2VCNYd3mS6EcTf05CWK/t/8zm3Pqp
         ZME1PfujhqgOQzNBzgbr4DkrKUQQMWGHzss6c8EcsXZRBXXlZc9Tr9CyEXK4N5vhq+W/
         LqbO1Tf34H/oLv92dF6xD9sSQ1DsnJIzJP9p0s8wA2ju7kEQ3BdM31pFCYwWk3bi7/Mv
         nfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764012316; x=1764617116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9qyNmraSZxfH4EDiK1SbuyABcD2ZmeejgHMgM0Aus0=;
        b=siAHVOt1p+qSwrh+ir5Bvv6/5bULMgcgTMWFfHZKs3UFS1xATIjetttUWLcP9FAsSQ
         SIhcn5776eVbkdZRSKT8Wln6Lm/Uiy4SfkaO3yF7hX6se2pPV7PrTbc9JSdOOFQ5tp8Q
         Md0ibtNXXU4kU1rNOTV2Cc0+u6mud4kcFgftGsEdsLPU/FVGxyyFS1HMu2s0sIb6upu0
         1QoHWBgNrIjq+kfbFVWEHQzel1PoCFAaTMUJDGyeJMqXAMUdqPknkw3e715sQPqUI5ct
         I8uVtHQh7+3I6u6e7aLFzL0L6bwPip3uvjSsToTRoXcpJdi47ihj7itJhUTkieYyXhkj
         OIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnulH6DisnnLOg736BPsRu/pMsukFx1Rnme2I5X5OJh2HGHfaDXqDfq3l7jvqNVL2VmgtrLvL+LzAa0udk@vger.kernel.org
X-Gm-Message-State: AOJu0YxcP13lqd5BNbyRpaHdyFjuPRnavdqX+WUCfjJ8t8CEvmrjDm2Y
	Vc1go6BwGc1TQnDtDbhN7Oovlj0kyeLRC3C560EpwlLoU9QfFgIoY5p19Qz2EwdvoS0Q8Z3p9Ir
	jKh3HG9FYmDFi+a92Y2jQBdmZEXtdYsA=
X-Gm-Gg: ASbGncuLxU7k3LZ642ij78njJzJR8aruQG24v292twF72pXrzp8WOWIreeNBQEA+k4y
	xyZHBOJCBQlOj3xaEeCGGIgVN3Idh0kM0kR0K9zdZageiiCMBHGbJ7Un7xcZXf8p155NyLAiPQW
	vEspfKpGHeRLNy/S7D7/0wGhiX0j9u2++8Dznwp/eDCgbBVnh9tXXHMg1rXXzCndbdwEAS88E+K
	xsWcxM6AP7WC1+TAcb434C4XFeug7+Ya9uk88Nh9kaAYBwM+AOepebgOxAVtc6c3FH8GD/zXfv8
	9G47TobfP/Cdg5It1PfS2WHFJw==
X-Google-Smtp-Source: AGHT+IEnPxGRBNwP+fRYNNpdpxzVlaNFWJqa96znKAS5unWGRk2BSHbb2O8CSVNHkJLmswNREiziC/IElvtyhDkguXA=
X-Received: by 2002:a17:907:7292:b0:b70:b077:b94b with SMTP id
 a640c23a62f3a-b7671a7c4a8mr1497131066b.43.1764012316404; Mon, 24 Nov 2025
 11:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010221737.1403539-1-mjguzik@gmail.com> <20251124174742.2939610-1-agruenba@redhat.com>
In-Reply-To: <20251124174742.2939610-1-agruenba@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Nov 2025 20:25:04 +0100
X-Gm-Features: AWmQ_blB8BCENP9pkSfZbdUMJ1NNc6fRgrXKlf8wFPSo9ThjIeR4tI_Bjwnr_pI
Message-ID: <CAGudoHF4PNbJpc5uUDA02d=TD8gL2J4epn-+hhKhreou1dVX5g@mail.gmail.com>
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 6:47=E2=80=AFPM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
>
> On Sat, Oct 11, 2025 at 12:17=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
> > +             *isnew =3D !!(inode_state_read(inode) & I_NEW);
>
> Nit: the not-nots here and in the other two places in this patch are not
> doing anything.  Please avoid that kind of thing.
>

Huh, it appears you are right. So happens I_NEW has the value of 0x1,
so I tried out another flag:

bool flagvar_de(struct inode *inode);
bool flagvar_de(struct inode *inode)
{
        return !!(inode_state_read(inode) & I_CREATING);
}
EXPORT_SYMBOL(flagvar_de);

bool flagvar(struct inode *inode);
bool flagvar(struct inode *inode)
{
        return inode_state_read(inode) & I_CREATING;
}
EXPORT_SYMBOL(flagvar);

    endbr64
    call   22c9 <flagvar+0x9>
    movzbl 0x91(%rdi),%eax
    shr    $0x7,%al
    jmp    22d8 <flagvar+0x18>

    endbr64
    call   699 <flagvar_de+0x9>
    movzbl 0x91(%rdi),%eax
    shr    $0x7,%al
    jmp    6a8 <flagvar_de+0x18>

Was that always a thing? My grep for '!!' shows plenty of hits in the
kernel tree and I'm pretty sure this was an established pratice.

