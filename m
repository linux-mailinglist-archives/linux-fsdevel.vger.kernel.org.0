Return-Path: <linux-fsdevel+bounces-71664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10789CCBED8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 14:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7233096D38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7A330328;
	Thu, 18 Dec 2025 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2UPw2RC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mH45WxSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1927145F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063160; cv=none; b=KBcL9WsdCTPmuwxzxCOZt7zBP/4u+DJgZ2vrnU3i9yG1TH16Nde57PbWW9dKOIE5NA1RZRx4mn/vVakwHwYPpZqh2l7WR0bRmiYmiLFExaytJQVY0QqnX/wgEum/aPCuOg0fQRH3DlvGBsu5okuJLnqh/4BmQMp2Sqa1dpvMGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063160; c=relaxed/simple;
	bh=Yki4RI1niKvxDnaXXKcZA+z+TuwX/kNuqeWL3vUqdWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfLbQtSxRfIlJX2J6ANx0TbqghhuqmKftutldp4QkNxembpJX4wKwWvY4TF6S1ptczMCkHvHkf2rfSUzk5cxoHEL+0fP20/j6gzf7jCE1AeIJbh/oZuyq8Lp8VIRUeMDUq1srebKGrocuq4peF1AFOPL6oHbl2kDCChSTxbRws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2UPw2RC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mH45WxSX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766063157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi8j2UszLKoE0x5JmRwZhZOTYSRg9AbqJ2V7XV2grRA=;
	b=d2UPw2RCD7EzlsMp+ZnFUDbtNR8Q74ArXZ2VdmIYE09VSBBI4BA6/KPHarZA6GDTrcJFHa
	WSqg1hAKYO0YWQV9QVKGZu++JSZJl2TF3TV0IR7Mtz0nL9ROYEJuqanI0Yrrrce0I0R+9Y
	fCUfCSms+vWT/ChSY3hiqmWt2mW6+XI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-_-9RwuKlN4ue5-BoU-p2JQ-1; Thu, 18 Dec 2025 08:05:56 -0500
X-MC-Unique: _-9RwuKlN4ue5-BoU-p2JQ-1
X-Mimecast-MFC-AGG-ID: _-9RwuKlN4ue5-BoU-p2JQ_1766063156
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-93f5ac349ecso287760241.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 05:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766063156; x=1766667956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi8j2UszLKoE0x5JmRwZhZOTYSRg9AbqJ2V7XV2grRA=;
        b=mH45WxSXXoXdoO/0udJaxhM5tHMT9L7iFd6JqLsOjB0bJ5cVAeZhgbMNwsWIAToD4c
         wJddoBVEfoVU6Ei1ayhEA089fd/wbSZY1ph2/qoK3O4J2lf1lG0lGYOvnSF6mT7gw+2o
         kpusU04SEXVk110LhYdaJLwHBYmmFYpY1WYLPuvmdXvz7odf+qCoqZB+uY3FMu3FrsI4
         /GDMMhIQkcEVs5fFbngylWBTI6Sh8AqDRbG/W0c1TPGkkGJO7AQ0svLG1qbxaZnC+ir1
         cUqGyLk8qh5K7ZNXdeDtfKGSqqL6N9wFSmmsEytOAjSMioxkzTXVLbf2blLgYk2KRPx9
         xLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766063156; x=1766667956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hi8j2UszLKoE0x5JmRwZhZOTYSRg9AbqJ2V7XV2grRA=;
        b=kdl57vD0WrxKHahmEQjqr9rBokr73NnXzIYrIcEskuMRJqIjAHBS7QYi1KLxwRUUm9
         eFuaq8Ql/nK/k0SV2Ylzg/+n+B2Cmr2XZw5Kzld//LuaZxb1/+y8ggONcetbUh1dID4A
         507YCsrsBerGhl17Jy+sysNUKLUpn904na9mXlRNhNM+I9K9ujCPp7/g9Mci2eHbbdzg
         vCJ6PWFoecpaS3cF4CB6YQc9MULwO/Az4myN051ASCgBCXgDxHUuASxeB+LdV5yLrxYW
         x1d0FsyEALtihVXPIkLujbo6A0/Itv3TfUKTvabh6mz+tAcrseBVqpBURfh1OohuDqyB
         HQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUntm4+NgXBA8kBYHF/zk3I0i5mGF5QTpjp6+iLYj9P5QlsiBCQRbw8yx3rZDzvr2j1yuHiwXEwKPSe4Wou@vger.kernel.org
X-Gm-Message-State: AOJu0YxguSpHKqqNwIzj8KetLfNyGUHMC6AtSaSOvdQUxIQUwGjRQu9l
	EVr0aU2iMLrYjEnad4PZS21dlepgL3sslOFkwsv4PYGfq+lxdDwa8tzGCfpouVen66Z8eiPWsRg
	sC+HzwRhW9SRjDSvY0gUEx4/fLmIZUDFaJniUn6f4kt0lIKozqwMFWdsYYdq1wyX0C5x8joD7bc
	ZfjsTvIPr9EFVuRNeCI18HPt6jUhpA9IgCJA1lJuxW/A==
X-Gm-Gg: AY/fxX5eMInq8Rz43dAgB5i7i9C/+OBinpkt+vC2/ouivV5FkjWxwrz1fXOYD7cvj6c
	r2DWAv+yjYERWu1/tzt7DuWy1Nl7UOo6xPwkosRXO6Hrgj35irPUxm24xpD8EEK1ZNiVZzfB+xF
	qIWl4MNtokNtJEXJHb6M7G6jsE4n+W9c6PR90+8S29sE30cF5+XHN/KwYBX/gwElYAwDF4c0a48
	O4mUtBfvQ==
X-Received: by 2002:a05:6102:943:b0:5dd:89c1:eb77 with SMTP id ada2fe7eead31-5e82780a607mr7205563137.29.1766063155922;
        Thu, 18 Dec 2025 05:05:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElL8beMlsB6pfz6OsFmDAy5Tzrj03M6fz87QnkOfcb+p4PFv+lkskroUYY6NSNVvKbZ5C4AtnEsPhppKz4F9Y=
X-Received: by 2002:a05:6102:943:b0:5dd:89c1:eb77 with SMTP id
 ada2fe7eead31-5e82780a607mr7205507137.29.1766063155531; Thu, 18 Dec 2025
 05:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216200005.16281-2-slava@dubeyko.com> <CAOi1vP88-aV+EXyVEgfiqUoSuqmaJnZ457uG6QrnOG34kimE7w@mail.gmail.com>
In-Reply-To: <CAOi1vP88-aV+EXyVEgfiqUoSuqmaJnZ457uG6QrnOG34kimE7w@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 18 Dec 2025 15:05:43 +0200
X-Gm-Features: AQt7F2okNTEuy6egWuZ050iqS2TAnEjwQleXbv20TTouiMCuELsAJ38SmDyjfN4
Message-ID: <CAO8a2Sh+C7_0+_oHDeRyUiiMZKm4cUJJ-JkNFXbihgWyFBNTyg@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: rework co-maintainers list in MAINTAINERS file
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Thu, Dec 18, 2025 at 12:37=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> =
wrote:
>
> On Tue, Dec 16, 2025 at 9:00=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > This patch reworks the list of co-mainteainers for
> > Ceph file system in MAINTAINERS file.
> >
> > Fixes: d74d6c0e9895 ("ceph: add bug tracking system info to MAINTAINERS=
")
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  MAINTAINERS | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5b11839cba9d..f17933667828 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5801,7 +5801,8 @@ F:        drivers/power/supply/cw2015_battery.c
> >
> >  CEPH COMMON CODE (LIBCEPH)
> >  M:     Ilya Dryomov <idryomov@gmail.com>
> > -M:     Xiubo Li <xiubli@redhat.com>
> > +M:     Alex Markuze <amarkuze@redhat.com>
> > +M:     Viacheslav Dubeyko <slava@dubeyko.com>
> >  L:     ceph-devel@vger.kernel.org
> >  S:     Supported
> >  W:     http://ceph.com/
> > @@ -5812,8 +5813,9 @@ F:        include/linux/crush/
> >  F:     net/ceph/
> >
> >  CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
> > -M:     Xiubo Li <xiubli@redhat.com>
> >  M:     Ilya Dryomov <idryomov@gmail.com>
> > +M:     Alex Markuze <amarkuze@redhat.com>
> > +M:     Viacheslav Dubeyko <slava@dubeyko.com>
> >  L:     ceph-devel@vger.kernel.org
> >  S:     Supported
> >  W:     http://ceph.com/
> > --
> > 2.52.0
> >
>
> Hi Alex and Xiubo,
>
> Could you please send your Acked-by?
>
> (Please ignore the Fixes tag -- commit d74d6c0e9895 isn't really
> related to this patch.)
>
> Thanks,
>
>                 Ilya
>


