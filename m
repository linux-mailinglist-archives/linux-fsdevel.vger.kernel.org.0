Return-Path: <linux-fsdevel+bounces-72392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F129CF3B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 14:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D5A319CB6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22ED78F29;
	Mon,  5 Jan 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbBKoouk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4216A33B
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618118; cv=none; b=qRApuHjVARVxGp37YoOJEM0TtEUy/cCpNA4RCKz8To2cEwcP3lJQRRSiI+cqBQ3EuKxam5b+oVWhx2DStxkBFBB5i1JibGINbLNl0kRCJkmwkk0uUYPvt86IiUKoUWHM6gB9FvEvKddCPFFhWua4/SndIfVGWIxww+HIJnPSxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618118; c=relaxed/simple;
	bh=+ST6C6fNnsgZvzYjV2/rW+xuraOFacdykI0B8YiWUog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anFAcT2CFE3tSEeFaQ2Rt9R8M/GJwNHl0T+etHebURB1VKLROmwc+1Xfl0RYZYoFrzneHCDuch01r/FZ9uw4WkSYouERRwTC/EzVTz3EU12HosGKHMUHoq3yDGG7o3zk/hskmIUe0RLc3gjwU16mFKNM8mPjU06ix4j480QEFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbBKoouk; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-121b251438eso2579602c88.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 05:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767618115; x=1768222915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q38tTxcHhQYXj4Ya7jdNvxwYbmmHz0J2xNhuehz16t0=;
        b=hbBKoouktizkb7vMky01AbcNV0aLtHIcaULez0JjuVDaJVIx7UlrmlLmZd+CJvFchV
         awHtSraV78SC8Y4ogT+3gmHdJBhSm4Xq+HSLEvCI8N5NdHZ2pHHQspHqPvtQdEvsTkS2
         Bd8UfDwyDB8+ggS3jXlMj+8gM0s4vwonqxNeBjr6utJ+ho/O0uwk3g9s1rtW6VRaDCUd
         nxqx582LSDNDKtkqivCjun0legKlBeD8DkxQGkSVsRkcDMlehj5RTWrXSf+4JV/uwU7w
         q1OuPD1LJYwsR2x8pUc6p0Ej0F1uU22CPcqNjn/EbrobGGhbr++Ou7xyMaMJ8TUcMYQw
         nfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767618115; x=1768222915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q38tTxcHhQYXj4Ya7jdNvxwYbmmHz0J2xNhuehz16t0=;
        b=lvmZDkk7V9weRsrXRxxYsk5Irqdm8+X0G8yq2Kx1Xh0LSZY2UODOW99JTp+BE4i7O0
         PsuZcly9RemDJiq4g+D+L9Ij4V8uC63BYEwBdENAX0xT+ghkGKeWzmUPZKWST/9UvCUT
         5ePRWxj+yUzaf6sLOn1f6eMbufm1Dk7jWyp/BTSef08QoNChQ30yQ7xV2EkW6Tenj4t3
         jI5BtAWSZUGVK+QSHq00i+oAxi63Ww2TftpxjZHS3vxJG7i8wYPjILWj4yMzMkIf73jy
         RVMxChHsijUyRCyCbmLb8x/4f8JQDi4z1xXWCm7AeFq0lFQE7l2+QqlNfBwTzjw+iNkA
         iIBg==
X-Forwarded-Encrypted: i=1; AJvYcCXSDXl5RRrDiGF76GZDncPg60NfjKXNA7o5MuFHSCntfgiW7nKiUx2goNlq4ZlSGSJKABREwydoZ72oj1G1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4espA8AhJmXTDEbs2R/dTUZbzTdycba3mkulKMjKH1fSdNZ9L
	fj6t3EQjSAi94x7YIcnct0fvzC2h9fIcF2ZN1Oc2/p/kK7ApP3dJeW5Kl52Aw3PnIlII4egSvDj
	J+1aT0Kv0V0LZVOqvwArrz2svPsflPHI=
X-Gm-Gg: AY/fxX7TnaGhfQZUzGukVAd6ZVK8J5156c+dsnDmc1NmEOcTMchwgPa3DdGqoIehhmA
	wgvVfqD2UiAf/JJBhcG6kGDlEi3yqtChE7DnAMov4/Hmlqaw5NLpcSbdvHxgV93RNR1EnMZ1uIE
	FGpxj+X0zyZY6uRx83UcuIoAGSOhHPCZrh3h2HEQ/DK7aDm0tnkzUMjrC1RmcsSGTQHJidFK//2
	6w82TdXHRo0zWXFskMpldHjgiLVvRveA/Ep+DjSUKOKrOsWpAhZbgZ6OadGrp0A6d+0y2w=
X-Google-Smtp-Source: AGHT+IE9AE8MYZdB076F/34GlsSNi7AHzkkpVcZr1pALSKkFYKqdV+4U+xjEZk2dG67zGBuekIEBboID6P4CZKhxNx8=
X-Received: by 2002:a05:7022:f212:b0:119:e569:f874 with SMTP id
 a92af1059eb24-121d80b9761mr6392534c88.17.1767618115114; Mon, 05 Jan 2026
 05:01:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216200005.16281-2-slava@dubeyko.com> <bff1133f-d07f-441c-aab4-d0b6b313b7ac@redhat.com>
In-Reply-To: <bff1133f-d07f-441c-aab4-d0b6b313b7ac@redhat.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 5 Jan 2026 14:01:43 +0100
X-Gm-Features: AQt7F2pwcAJGPr5wvJO_zNTT87r_TiHWO3xq3pfcgwx7ciZnItlsPnmzpzO4Rfs
Message-ID: <CAOi1vP-HvPNh_cEViZBM8NYLg+S2+6MwLrG7my9F-ap6hL9TwQ@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: rework co-maintainers list in MAINTAINERS file
To: Xiubo Li <xiubli@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com, vdubeyko@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 12:44=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote=
:
>
> Reviewed-by: Xiubo Li <xiubli@redhat.com>

Thank you for all your work over the years, Xiubo!  Now applied.

                Ilya

>
> On 12/17/25 04:00, Viacheslav Dubeyko wrote:
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
> >   MAINTAINERS | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5b11839cba9d..f17933667828 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5801,7 +5801,8 @@ F:      drivers/power/supply/cw2015_battery.c
> >
> >   CEPH COMMON CODE (LIBCEPH)
> >   M:  Ilya Dryomov <idryomov@gmail.com>
> > -M:   Xiubo Li <xiubli@redhat.com>
> > +M:   Alex Markuze <amarkuze@redhat.com>
> > +M:   Viacheslav Dubeyko <slava@dubeyko.com>
> >   L:  ceph-devel@vger.kernel.org
> >   S:  Supported
> >   W:  http://ceph.com/
> > @@ -5812,8 +5813,9 @@ F:      include/linux/crush/
> >   F:  net/ceph/
> >
> >   CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
> > -M:   Xiubo Li <xiubli@redhat.com>
> >   M:  Ilya Dryomov <idryomov@gmail.com>
> > +M:   Alex Markuze <amarkuze@redhat.com>
> > +M:   Viacheslav Dubeyko <slava@dubeyko.com>
> >   L:  ceph-devel@vger.kernel.org
> >   S:  Supported
> >   W:  http://ceph.com/
>

