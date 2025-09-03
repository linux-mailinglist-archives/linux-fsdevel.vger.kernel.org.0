Return-Path: <linux-fsdevel+bounces-60129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FE9B41835
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2314B1B22A59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E92E9EAE;
	Wed,  3 Sep 2025 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUrawY7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6B2E266E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887409; cv=none; b=uDz6FzeiDTf71tRhMkUREgcwsjtwl9XjUQFgGeij6ip5+ElrKt3D8rfJa07CWVRPBMoiVQevRjh7574hFuk2JMfPXbFlA3YHRRUAC0VvQ1p//8sfIbPlcv0wno17ZYhqW5RzZ2ByYFThEPXHdgBxVpcLySK7SRsEOYdutOZy7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887409; c=relaxed/simple;
	bh=Re+e7BijoTbsCgSZ5iTUQbLfBnwaPcYBU5qrPytMDuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCw0WDJ+47McbvoND+6g7ZdKgAsCgdfox9GVJXHuclKe+kZSZ3Eq4YrJ9x6AKO8eRNeWjy1NoE2WZ0+ogsHyLh68YR9JGATctf6I0ciuGk5Nz9FdAdLLYwjTQPtH5L1K88t3aXMjMrzbpBL8w8t1rdNLuV6tBGO/zkU8nYqFSUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUrawY7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756887407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2z6mpopbPufu8fsWdtEVQ7DTC3tmoaLG19ol2Qw0vU=;
	b=PUrawY7TteGstfMyummeTcETR1tYv9AsnHaUmIcUmEODboT0dmLupO8lRtdxWIyQOIlre+
	1rf/k4WeaHprKYWw1RdoUsbgPciYBhLa4WK9las7eCClTeWGdQnwkLJ1bgsnhr0XF7r0si
	fpQmQ1Qpp3veugQ2y6Ql2l12GNNNalo=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-rN-nljuyPu2hraobrZdLQQ-1; Wed, 03 Sep 2025 04:16:45 -0400
X-MC-Unique: rN-nljuyPu2hraobrZdLQQ-1
X-Mimecast-MFC-AGG-ID: rN-nljuyPu2hraobrZdLQQ_1756887405
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-544a01adb85so800491e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 01:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887405; x=1757492205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2z6mpopbPufu8fsWdtEVQ7DTC3tmoaLG19ol2Qw0vU=;
        b=ef/oHe2vkeANDw+TnaPIqMOfAPmk7WN2Xb/Bg2O95DNUhrieNzYJqfzvhmsMiXlmit
         5XoGhNr1Owl/IAYmp4qXWi1q8eAWjIvlMpkRgXxBWTtvFkjLDaLvCxwabusv55vM31hX
         2qlHJ5eSmsYWfaVhkY8pkrv09ATS1nzw0Bgao/ZlGI2z1aM0jI9axn6ebYFNI2cF8YJg
         VhFN6dgr+s6KMAYbb4UIt/fRCUbd2Q96GABzenReyFxHyEkR/m7sVbPq+6IOeK6rq8wc
         h7MQelC/bZ7r+6kxlUiGWxYeGcsbOtYr3nKvZZoaKmbRKFU/y7H8QVkB34TeZt7hmMRJ
         c51Q==
X-Forwarded-Encrypted: i=1; AJvYcCWv6vKzZRXKV1IakVZiAyBMMnn23nQ5X5mcnAmTeFclkG1cZls2Z6UAFjFt3aADSSb7Zag2sn2j7s39Nop2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0IBbLcXJwFg+apMHV/MGClkscLzPEWxo248NjdLxATj6OBTV
	D+sK+vpzkPMQuDsCfSR1D3KGgfgHSPawSfI4xtsefdWJugYB/L5RS1gXL1kcUepn0GpNdKO3wx/
	Kodncmee2pOpowJIzG27mYdl1GhHyr5QRg8629BvLyHlGv0CJUJpvkFU3YvoBkvz11kkSpByeTN
	k6lGBCsdy8w4c2DdCCw1gkdN90kvrU3hmbD+GX5nRO4Q==
X-Gm-Gg: ASbGnct/4/EqtiT6vsxqJoZjjEo00LKSHwYmVBoKVb79HYMmZtTPlq2CnDzd0lNr6Ll
	vRjRlwJIE7LskURmldvSeRacY/xUPYsqSfih0FTEckmbwFd56mBk9rAWJ1+aq5d7hxviFAdpXW1
	t7lD3BQuFY6UIGDiY3e3klv5/2hqwthbGR2H/ipWk2
X-Received: by 2002:a05:6122:481:b0:544:87e2:12fe with SMTP id 71dfb90a1353d-5449e88de88mr3961470e0c.4.1756887405224;
        Wed, 03 Sep 2025 01:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECS/N35Drdg76RdlbxNZjeIUpa5pkGUOiSFJbCeAeT74IRBGvY3NcFO57G8Fk6ZkCSKNJMgWfcn+XXAaDVI4w=
X-Received: by 2002:a05:6122:481:b0:544:87e2:12fe with SMTP id
 71dfb90a1353d-5449e88de88mr3961462e0c.4.1756887404889; Wed, 03 Sep 2025
 01:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902200957.126211-2-slava@dubeyko.com>
In-Reply-To: <20250902200957.126211-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 3 Sep 2025 11:16:33 +0300
X-Gm-Features: Ac12FXxirMUeXEEMOfPTgApw4Z7n8102_Gpg2uemNkSOmE9Hz_uIfRUN1CVjrUk
Message-ID: <CAO8a2SiikJxtRSaEPYuX51EhEYw2MCUWFCJHac62SiRXWQVEMA@mail.gmail.com>
Subject: Re: [PATCH] ceph: add in MAINTAINERS bug tracking system info
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Tue, Sep 2, 2025 at 11:10=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> CephFS kernel client depends on declaractions in
> include/linux/ceph/. So, this folder with Ceph
> declarations should be mentioned for CephFS kernel
> client. Also, this patch adds information about
> Ceph bug tracking system.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dcfbd11efef..70fc6435f784 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5625,6 +5625,7 @@ M:        Xiubo Li <xiubli@redhat.com>
>  L:     ceph-devel@vger.kernel.org
>  S:     Supported
>  W:     http://ceph.com/
> +B:     https://tracker.ceph.com/
>  T:     git https://github.com/ceph/ceph-client.git
>  F:     include/linux/ceph/
>  F:     include/linux/crush/
> @@ -5636,8 +5637,10 @@ M:       Ilya Dryomov <idryomov@gmail.com>
>  L:     ceph-devel@vger.kernel.org
>  S:     Supported
>  W:     http://ceph.com/
> +B:     https://tracker.ceph.com/
>  T:     git https://github.com/ceph/ceph-client.git
>  F:     Documentation/filesystems/ceph.rst
> +F:     include/linux/ceph/
>  F:     fs/ceph/
>
>  CERTIFICATE HANDLING
> --
> 2.51.0
>


