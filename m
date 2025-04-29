Return-Path: <linux-fsdevel+bounces-47624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769BEAA1500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04DF16D9F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB5E21ADC7;
	Tue, 29 Apr 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Ag8+8JF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99321ABDB
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947195; cv=none; b=d3sxMsPzyp6lf0Y56XNCPwlQIZPu/D6E2WczdvsJ5yykb1+glPo71N1SvLRtbHCDgkft0CRSAcZ8qK5442nbU37XJ9PZjCMMTUhIDqya83zzDIfPKDHpbRJtddtNJSddvqvWTV/zqYaC6+/jG/BLrYyf8UOgNhQ9kn312xPbGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947195; c=relaxed/simple;
	bh=HjrmHBQjqR2LcStTMCDiAj1dv0lWskq7x0jur1KTn1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KMYMJLIEN//YVznUul9vx8D2Bbzs3sKiXM2WGQhyU187ssoPg430PmrdFudC7WwYN3G1Sbk/zy+I/X33FKzRKnYe1zLw1A18VMnOcCZQvjLcJikjcHBbRLRk/3BTYcdfuu83EiwkwLSyyn5A2lRWe7P2z0I2ZLPTG6O3J/ontfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Ag8+8JF3; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-401c43671ecso43874b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1745947192; x=1746551992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7lW7yvmOz0wbYqoUTHL1Dww1AOmgMqUjAa5marebUmc=;
        b=Ag8+8JF3T+NWTYKvEfDks7liTf8yIT+nsx+A3B65KSp0nPBvYpSthFufw7Z+XvAnSw
         f7Pp5CCpHdf3T/e8XSS33ubdgaozYPFyNA8dmojNFyIDc+6K3IV129WX+YOabLQKamSo
         L6pmavRZVE6D2qpNOVIkcjw8P2B1yXOI4vvi6QwzEodojO3A5FvECWKI+RLo501itTHz
         Mb+n+YbdgDlIDWzg2T7im0+dqzG62/c7xajIvI28p0wbueeSTSoEtTG8o32RhrN481Ga
         qDKGb+xLY4lJikQqFoSRnVxO2QUyziOmsdfHT4pFJDGSE7NzGjVspIZp7+eXGTRJ4ruR
         zVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745947192; x=1746551992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lW7yvmOz0wbYqoUTHL1Dww1AOmgMqUjAa5marebUmc=;
        b=qMggGd1SqNpJtk54cdJKB7ZoXiNWLrWdN5Ye6LSQi6ydEzphSmoPXPdVOpcRLMTmDE
         NiXT8yR3fqUgZtVbPMrAH0QfwQZltg8DfdDGBS/iaLN/49aC92J1Y+4/Yo5iZuFoczHl
         qKimC2B9hZCEWtm0QKZOMxDCxT8LICz7wRjQRTxsW+9cqOuj3M+ofegj9bj/jMYukqSx
         Kun2NHPKTpK5lj4nhy+f/T+f/XNJazE/6SLrGqWQwjmBV0yjadcQpeUE6WBSqd8/y6RQ
         zmAT+2LVR/TzRYLxaWhNVa7VxuQ50cW/xbD9UwrMGbxQeQxaBGUBoiQiFYOGHH+unKz7
         KNWA==
X-Forwarded-Encrypted: i=1; AJvYcCVIpW+c0aiH1MSRa8jxGKg6N4wtwlL8H73CIvs2YrIxta/muC50EB4v3KBCLV+rEnDqdb/Qx2Qf6BW764u9@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHsh97N/+LJLEgo5krx3qdjofrVI0AK7oME7BNrlJg5qSLhS2
	p12bgyVuRM+ZDA6/JXgF0dV9eroKDsQQs8YYvcu4OQWU6kdvrXGVpmk4xRbw23k=
X-Gm-Gg: ASbGnctxM+Oshq3Av8kAU3s0jKNubwYpU+6iTz546Apjf7RZAWh6e3k2IykwQVSAHwk
	u+Vg5LkHz9b1mAjgPTkdM47qFqkKTKPQqGa+NhcrHRhsVIJeaQrWIAKQc2YXSUB/OSjxeh/r33l
	EMk8lCTCIEj1bvJBQk+sgI6KKvouS1wroPgIf24eBOD7jB+n245Kk1zkmOpLYq9orgtPdoV8csg
	8RzCCRO2Fg6om1cG9qkCjOY+XKRneheuIkYYuJdqrQkZS6nWw/5D21EK7IeQw55Ix87VjQ1uCGX
	uKaTjT3sOQ7JaoZ9RMVNDEIqowJVmo9aQeMwVFIC6nVlDw==
X-Google-Smtp-Source: AGHT+IHKo6lDewIlKKRtZIpl+eKmGku9Xi6n3d9oui0y6TJQqUIDXs4BZBNxfbQa3Ymw+cd+1IOIXg==
X-Received: by 2002:a05:6808:448c:b0:3f6:7677:5bef with SMTP id 5614622812f47-40210fcce02mr2422278b6e.2.1745947191979;
        Tue, 29 Apr 2025 10:19:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::45? ([2600:1700:6476:1430::45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4021291e56asm354268b6e.7.2025.04.29.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:19:51 -0700 (PDT)
Message-ID: <9c2571057c141f46515e26b5e0cb06176d5df093.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: fix not erasing deleted b-tree node issue
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
 "glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "frank.li@vivo.com" <frank.li@vivo.com>
Cc: "Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>
Date: Tue, 29 Apr 2025 10:19:50 -0700
In-Reply-To: <78d3899f-5e07-4a76-8135-81cfea3b0086@wdc.com>
References: <20250429011524.1542743-1-slava@dubeyko.com>
	 <78d3899f-5e07-4a76-8135-81cfea3b0086@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-29 at 06:05 +0000, Johannes Thumshirn wrote:
> On 29.04.25 03:16, Viacheslav Dubeyko wrote:
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > ---
> > =C2=A0 fs/hfs/bnode.c | 2 ++
> > =C2=A0 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> > index cb823a8a6ba9..c5eae7c418a1 100644
> > --- a/fs/hfs/bnode.c
> > +++ b/fs/hfs/bnode.c
> > @@ -219,6 +219,8 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
> > =C2=A0=C2=A0		tree->root =3D 0;
> > =C2=A0=C2=A0		tree->depth =3D 0;
> > =C2=A0=C2=A0	}
> > +
> > +	hfs_bnode_clear(node, 0, tree->node_size);
> > =C2=A0=C2=A0	set_bit(HFS_BNODE_DELETED, &node->flags);
> > =C2=A0 }
> > =C2=A0=20
>=20
> Hi Slava,
>=20
> I've just checked HFS+ code and hfs_bnode_unlink() in
> fs/hfsplus/bnode.c=20
> is a copy of the fs/hfs/bnode.c one (maybe most of the file is so=20
> there's room for unification?). So I think the fix is needed there as
> well.
>=20

Yeah, makes sense. This fix should be there too. I simply started from
HFS and I didn't take a look into the HFS+ code yet. Let me prepare the
patch for HFS+ too.

Unification makes sense, but it requires more efforts. I think we need
to fix at first the bugs that are failing xfstests run. However, the
unification could be not so simple taking into account the difference
in on-disk layout and current implementation of drivers. So, let me
think about it more.

Thanks,
Slava.

