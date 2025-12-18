Return-Path: <linux-fsdevel+bounces-71604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E36CCA372
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 04:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26B933061C7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC732FE581;
	Thu, 18 Dec 2025 03:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqrD6Rtr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDbxNoS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0B2571B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 03:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766029854; cv=none; b=eXcUiNycmocqHOZ9rbbY/mDOK5aaYdVkFKxnmcdLdv0lOwqxLqmhHVcPytWssWmylwQUA72AeRU15eJ/Uv2P9APNQixBnJAp1PWtoLP5m6xfKc5hCjoK6BpLYR5pScqvI52dTNkXm7TCW/Ykaa4062Jj9uvnIsfuRWDDNEx2c+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766029854; c=relaxed/simple;
	bh=3NjRZoIfXWJ3zNa/5zT3Awvrf33cGByJk/NuJvo2i88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lg3ueSGeeY5Eo+/sax3GRW5LQjkND9WRcr7WKw5vTp9PNUwcNJw7BwbSD3SvVBEE2AKlz9MgNkgibOXSmLczhDMZRXfai4lGeMi/MF3HGHm3UhByhePO/U1OnmOcxLb0UbAtT5vU4WN8lX/1Dn/ln8OkKQHerUjTgl74tIK1AJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqrD6Rtr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDbxNoS9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766029851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HREBjb2QxiwbqHRQDxCYqTPo2R84DWJ+5LQcwkuRwhM=;
	b=XqrD6RtrspCSZOMBbsC9C8BYVjtk7XoUlYmGWHRXoHrc++HwHH8ASHZ1bevRfkw+3g8DuA
	lT76L5owb3APVBePA7naxIp9Hn/ZbWCupdCSl+37DtOh7NjZeS96WgqTO9psr0cni4L0Dp
	pRTL4bkpGwiMtTmMZzR2bqJK2ahWhpA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-6n2IylQgMrqX6scakhV2nQ-1; Wed, 17 Dec 2025 22:50:50 -0500
X-MC-Unique: 6n2IylQgMrqX6scakhV2nQ-1
X-Mimecast-MFC-AGG-ID: 6n2IylQgMrqX6scakhV2nQ_1766029849
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-65d004d4d01so149492eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 19:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766029849; x=1766634649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HREBjb2QxiwbqHRQDxCYqTPo2R84DWJ+5LQcwkuRwhM=;
        b=fDbxNoS9QAC+IwI2GVjKbn7Yn/EX/kaORpE+kh9J0mG/+TGThU444MbwfGxE9+WOWv
         WluCQRtK5V1OL3LmP7r+yVTyhAVyUimLU/jyGWxWcS4/ZdUMj12k1S3yPPetmccdkKdS
         QYAcCQteLpID4k4B10u3DvKfnlCCrKL/+x4MRPCtPXPvaJBDNVD9O2Uw1RkZzpSafRdp
         Pjsr7uI5kVMMAQ98VxlhKaRbjFk3zNjmTmdEyhjpL7I64TycPtGFful6mnCa4/phXCEm
         OhQFi0BbOXwBWbhxNSgEsnyi04ih/gGbDwitxCrg5/c/QqraYbCSG+miKweUgSp3q4Oi
         U+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766029849; x=1766634649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HREBjb2QxiwbqHRQDxCYqTPo2R84DWJ+5LQcwkuRwhM=;
        b=nvYpiRQqlf05hDXgb6C7uiRqQoIKaj0sxFoy3q0pGUB7HWqsKFt121QZ4SXwkp+go2
         iPPxadjO+ro500GiVOLm76rrgXW2JFUjhi5LsBNUnwyU7mGBuifJKWB7WVw2orvjFrRG
         /GIKXyTzsnSL898G/F62BP09IGUf11p/6lGxk7/S8bpky/mK6KJhclcjPvmXWy4Q9IOI
         EtGWk9mOzwAg91VV3XamBWRjGU/IEr8O2zR8OydthejNCzZnULQanerwF0Q5XX9hZZAu
         59pvABQwEva29G3n+JNANydecg/i3gj2whRDoUcVLhrivtuWmff2vMSTmCLxrSD3hIFF
         D2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb+EZnHXYo3NCuzvI+IGnQJAQqDrq9sbP38n3LqnWY9SR0umeR8sFSiw3jyyGZcVrmXTuN0q6akFeu0NQP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2u51IKGinO3awOX1g0WrDiIgpoQfuDY0cULSwRxOIdkLVjtrO
	OKjAfzpBFdpcqzvgZNU9TuLAtyA8NwU7ybbtbhj97uCLUud4J0MV2UXl96m17bFubad3wVBLULx
	urTMdANSFOrkBO0BE38+ka4Bwrh7wTdAO8O8Pqm9OGMLKT2FdpYNsyA1v5Ahwm/5Ub7K54o90Gr
	W7OI7N8PPzuFRsp2yF9oAC20FtMp7HzqEvzpkN7731+A==
X-Gm-Gg: AY/fxX4jEFlGiPwxwTi66Jvzolq3jJoeml0k07ELejSakx7L8L+J2lPb8W5xxssE/uE
	3ROWh/r22Wq+/JFV5WZmsT5SsKNFfenEpUTkGgTVmy0ZA+jslvSXuXIjPmq1kjrDEnGMypfcCdD
	pKL9K95uplr36lmtcWFQmoSFPwO5XUh0iBFL1gzSaZoiaHj99TPUcytQDSeQyt0thJzWf66sHWX
	eH8D9asYPB3HuRd7BSP0d9NYA==
X-Received: by 2002:a05:6820:1613:b0:659:9a49:8e3b with SMTP id 006d021491bc7-65b4518076fmr8410105eaf.11.1766029849444;
        Wed, 17 Dec 2025 19:50:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmnT+9YdP42WGYbx4GL92R/LsivEa+Q4Y8dS576ThWfw+doiQ2TCzi3NRqSV8Hy3+gr19NHDpEyB+sb4qeG9g=
X-Received: by 2002:a05:6820:1613:b0:659:9a49:8e3b with SMTP id
 006d021491bc7-65b4518076fmr8410100eaf.11.1766029849137; Wed, 17 Dec 2025
 19:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215215301.10433-2-slava@dubeyko.com> <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com>
In-Reply-To: <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 17 Dec 2025 22:50:23 -0500
X-Gm-Features: AQt7F2qRHCnNAtF8htmTG7RN9sTQYIaOKs8Qm9m-7WqsZ7izIVxH2V_V15lJJbU
Message-ID: <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	Kotresh Hiremath Ravishankar <khiremat@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 3:44=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2025-12-17 at 15:36 -0500, Patrick Donnelly wrote:
> > Hi Slava,
> >
> > A few things:
> >
> > * CEPH_NAMESPACE_WIDCARD -> CEPH_NAMESPACE_WILDCARD ?
>
> Yeah, sure :) My bad.
>
> > * The comment "name for "old" CephFS file systems," appears twice.
> > Probably only necessary in the header.
>
> Makes sense.
>
> > * You also need to update ceph_mds_auth_match to call
> > namespace_equals.
> >
>
> Do you mean this code [1]?

Yes, that's it.

> >  Suggest documenting (in the man page) that
> > mds_namespace mntopt can be "*" now.
> >
>
> Agreed. Which man page do you mean? Because 'man mount' contains no info =
about
> Ceph. And it is my worry that we have nothing there. We should do somethi=
ng
> about it. Do I miss something here?

https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50aecf1b0c41e/=
doc/man/8/mount.ceph.rst

^ that file. (There may be others but I think that's the main one
users look at.)

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


