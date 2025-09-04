Return-Path: <linux-fsdevel+bounces-60292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 988ADB4458B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 20:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75409AA063D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C2340D91;
	Thu,  4 Sep 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tn6uGwlh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99464136988
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011002; cv=none; b=MmhTb+T7HMkNtUfxXgyAXpkqbWGslGVVOsxZ8KF1LAenXKG+gSDZLTkfXo6fAzOKkL382FD8Uub9hbANUiYfRExQIctca6qYStfnGzwAAsQZx9zs3RjjIGiz7ukagvnbQ9EgD9BXSCS+feXKNr2xzyc2CxcWuy9am1TnibaS1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011002; c=relaxed/simple;
	bh=nNREjiI14TMw6bLqfOvvB8e6QL7VI165+o0XHDB3XRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PCuSO9L/zOmV4aIxzwg3URXSQauRyRl1kKaCR0iTagHf3QzJ9oI2U1iMaICUDCNnDOVUT+Jww8qgOlIbp0OT5I4AHf/dgMo0BrgtfiOpXU5OzKyxQTdWNRAzCGvI8aYBDdc8FDYMFZcP7lktqbXUeQe15MEbgDzkqQGOAJzIh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tn6uGwlh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757010999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUoOgtDmVPvtU0d6dLe6T2mB6VaPbKe1PvwedEnTvlQ=;
	b=Tn6uGwlhwMmEkWPGYkGF+8ZMCJXJzWRQXQNxvUZ2RoRZbfXCOhW7v3XahWoxTeuqOAUQJg
	fIpQWuSMC1F6SWVFSOm9heGNLqKy9WyCXqPaDOoFQx4B8V2xHiN+Eq8QJsJ1vW6UV02RTT
	qn5I9MgaIJqIGN1AxjPuj4M+geCqfH0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-GTaRXeXfO72fjTuHBlNcTw-1; Thu, 04 Sep 2025 14:36:38 -0400
X-MC-Unique: GTaRXeXfO72fjTuHBlNcTw-1
X-Mimecast-MFC-AGG-ID: GTaRXeXfO72fjTuHBlNcTw_1757010998
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-72290345419so12431737b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 11:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757010998; x=1757615798;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUoOgtDmVPvtU0d6dLe6T2mB6VaPbKe1PvwedEnTvlQ=;
        b=UODLNT+XtO1gaZtHmC4VnssvofRYRpD/0stGbicKjR4+seOspHb7+PmHeX2QoLvgSq
         F6QSdMj7L2gR/tlOjm2PMglTApPebA7Nc4wLFvU2iEpSAKSXv5nrN8ZTqh1YaGkqTziI
         ZZuMxc1klzrlz/oz3dwWlEMyW+L56L1Wj+/BS8VYTRU3qHs4qSzTqpDieGdpgN+RED2+
         aKoudH1BBa70zeHXsDWjqAoPRRRM+QbuIRTvX0w2H1jH0WJQbCL8Wap9HOS0gBYNMHCW
         YJ9rNeeMteanixOkwwMGiIRphWHn5R0x3qaMmzCnVrrlmhdAsCd9T7Q2tegPpLId8V+B
         yNng==
X-Forwarded-Encrypted: i=1; AJvYcCUDl1plxaV99LSWB1DZt1iTH7u7B0VpL/oxI33k6MFIOYwlE3F2mT4knj9ZIC6gU4hpjNzWYW3M0w4vvuF2@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMq+R2Pdp0oRrpe3ceES5ggs1ntcSv1XXhciCkkk2qvF04MNP
	mqyzA/s0vb3MiT80FJjILwI+Qos3R7QB+PHoak+oAMzc27ODCOlfVWmgGUCW/VJKGJdxeoBzGAG
	w5upjqt4Mo9DEi75d22jV+fcjsk4iHvnrAgHIgRg7VzM/EzSsHnYDsGDcMkpY0geKvDU=
X-Gm-Gg: ASbGncvkGj+CqI16eEZjSBDZA+QCn5S+7MGQHo25Gm4qJWT5buP/NVifZizLWPJdtIN
	s7tlosD63dzTjqB492QtNuZPtgCys3HVfIvVPJovcio1GhVAtLu4V66x2NORVMJBF+Isfz/dlaO
	z+Ks+YRPAG7AWnMykoNONtn08UmQWwhdgPizqr1H4YV4eQOSd4i3wSy3/AZJa/NpfHg3WZtfXCA
	3hQqHTxaa458OcOxRDazpR6pCIzevgyTwr9z0MSlKjP+G0o/73CFkQIRaU0GA3T+4TbVuxM9gbA
	ocGs1OnXI9Cfx7elRfX8UHjQ3SZSJjvP+W8+nJ8AwpUWAzEgVclNKcQRWj7qNlHX4HJ2
X-Received: by 2002:a05:690c:6512:b0:71f:9a36:d332 with SMTP id 00721157ae682-72544c08a77mr6426057b3.27.1757010997738;
        Thu, 04 Sep 2025 11:36:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE82QRekzPTrDWlL/a6mMRqKoCvQRuBEzYmW5Cr995ml7oOTUF1e6Enft6jXC9PiheIYQzdMQ==
X-Received: by 2002:a05:690c:6512:b0:71f:9a36:d332 with SMTP id 00721157ae682-72544c08a77mr6425887b3.27.1757010997313;
        Thu, 04 Sep 2025 11:36:37 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8502985sm23540587b3.40.2025.09.04.11.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:36:36 -0700 (PDT)
Message-ID: <189c4b739dafa71d7e0717fd2c4138a5226ef8fd.camel@redhat.com>
Subject: Re: [PATCH] ceph: add in MAINTAINERS bug tracking system info
From: vdubeyko@redhat.com
To: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pdonnell@redhat.com, amarkuze@redhat.com
Date: Thu, 04 Sep 2025 11:36:34 -0700
In-Reply-To: <CAOi1vP8Og5phUw3LO3Fv3yfnSSx3FhuSmj7j4pHrF00t-MGS9w@mail.gmail.com>
References: <20250902200957.126211-2-slava@dubeyko.com>
	 <CAOi1vP8Og5phUw3LO3Fv3yfnSSx3FhuSmj7j4pHrF00t-MGS9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ilya,

On Thu, 2025-09-04 at 12:45 +0200, Ilya Dryomov wrote:
> On Tue, Sep 2, 2025 at 10:10=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > CephFS kernel client depends on declaractions in
> > include/linux/ceph/. So, this folder with Ceph
> > declarations should be mentioned for CephFS kernel
> > client. Also, this patch adds information about
>=20
> Hi Slava,
>=20
> This argument can be extended to everything that falls under CEPH
> COMMON CODE (LIBCEPH) entry and then be applied to RBD as well.
> Instead of duplicating include/linux/ceph/ path, I'd suggest replacing
> Xiubo with yourself and/or Alex under LIBCEPH and CEPH entries so that
> you get CCed on all patches.  That would appropriately reflect the
> status quo IMO.
>=20
> > Ceph bug tracking system.
> >=20
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6dcfbd11efef..70fc6435f784 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5625,6 +5625,7 @@ M:        Xiubo Li <xiubli@redhat.com>
> >  L:     ceph-devel@vger.kernel.org
> >  S:     Supported
> >  W:     http://ceph.com/
> > +B:     https://tracker.ceph.com/
>=20
> Let's add this for RADOS BLOCK DEVICE (RBD) entry too.
>=20
>=20

Makes sense. Let me rework the patch.

Thanks,
Slava.


