Return-Path: <linux-fsdevel+bounces-43850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB3A5E7FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 00:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99DD7AC163
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 23:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F661F131A;
	Wed, 12 Mar 2025 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlU6q2A8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E231B0406
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820685; cv=none; b=Ytj0wqMBFbQgeo5DDcG4yVdXK8gqF5licMyRr4mxJUYagyNHT+i1h4US8c8jjGGN0eGqeCOeMiOHtcLHc1kQmpfOpqPhFQCXDg0AYyGnBpr0FsDre/XC/6DK4UJRhJgZa2EC/B7cEiIlKkYFqHSv3HVqYINk3Tz5fqmTG+skvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820685; c=relaxed/simple;
	bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvWwKxCQ8afnJdpRsPqh6ZD1LTIanM6bzPVMXDyUAIXNnm/5HPACLc+U3bzxcq+jzqGSL23VlMdo2wyKMok0BXjZ2c097XN6ZbxHVqLYeYl9w9HPz5ngWqH/2rg1kDYt1iRnF4GzrAs0PUq7Eq8G2cdQEHub1NNOzCWPKo5KS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlU6q2A8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741820682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
	b=MlU6q2A8a4uCwqBNOlxeDEILGorCOSeWUvxDY+SIWf5LWnKEi1j7LJyx151qsyGUl2RY6t
	NiR9c+TsFmuceIU6+dGFxR1J9sfo1xk8irhkoqPSbYwLVSnYz1FrJDYI8hqERbUhNU4yNv
	+8X9qeZ9LqKRd2CvH1K/NA4ervmG4fE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-wCqogoMDPy-Go8oKNq9qCQ-1; Wed, 12 Mar 2025 19:04:41 -0400
X-MC-Unique: wCqogoMDPy-Go8oKNq9qCQ-1
X-Mimecast-MFC-AGG-ID: wCqogoMDPy-Go8oKNq9qCQ_1741820681
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6feb1097d64so4946047b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 16:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741820681; x=1742425481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
        b=qb3PHTfQKJvrHFbKgRAMNi6jXTePcLzgQMkZEjPW/rC++YHivcd1Wpa7U49/iLirfh
         de38Jto/d6b7ZT+jxbIMJaLza6QFyLIkjY0+c8lmzpO9+4SpHGze4Cw4pRTuHTGinKT/
         7HsXo6Oc6oiPfERo2whL+bHRAVt76x6IsO7PnmYkbQZwA9Gt2gkQnVcgCnxdiNGe/q9L
         /M9ZI8Sz3izDO6aaJ5eBHw3il7/a4zFHT3JHsdFVpxA6YfWyhAQOrDoy3k5pNUk6KuPm
         s/5oQKWY3ntRSfvcRhc82teuC5OTGWZ2PCztbfV8iCcbaiZ9rhbq+u+ABwn5g0wE5KOZ
         Qp2w==
X-Forwarded-Encrypted: i=1; AJvYcCW2BlDVoHmJ3itCS5xOSrxnhELZ+NSwI/32Zw7ZKsVg9kHv4RMf7Kp828WvVeh+5SBrJCg1zbWBjudBRhkZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZ9h3OCq8ZBQJZ/dFM5Ev9zrmRrrj1dbHYqkHEB3W4wKBLKCL
	Y+UpihZ6g/DWoYiXXf2gmRgyAIJfeVreXzMxIIOcKOz8LaE4WQ7B0LvcJw6ZxFGkl4Dmi4jyaou
	P910Tma87Y1wbwiyUEzDzwXluBDN07YehaVQemJ/G6e8G2V7W2a8ZSlXrMj7hV3rQujoXkdWxW0
	4M7oX/ZFsKaWDzoSl8qV4300TYpN7CFldp94+gGA==
X-Gm-Gg: ASbGnct9fQAyFqQNjHczrHQz8YSmUCrdCoRpTxppiToeFTP4CnADekU/uL9LGMbV4La
	sI8Xr1D0l0CxLnQMgNo7qK8Cp1J8XqL+aqXSI3hZKT3G0vbl1pxdlY0xMxYN3zAnqiW31T9AZPY
	emCU9jgJ2PeIs=
X-Received: by 2002:a05:6902:2ec3:b0:e63:65bc:a173 with SMTP id 3f1490d57ef6-e6365bca293mr20489031276.41.1741820680968;
        Wed, 12 Mar 2025 16:04:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE29IOsL3if064ONRlZf/bCswPuk7JbIN/+ScTtHA6PhUNFhrt31PPwWl6SfPGyM46nmrjRUH8DQbWz44H/+M=
X-Received: by 2002:a05:6902:2ec3:b0:e63:65bc:a173 with SMTP id
 3f1490d57ef6-e6365bca293mr20489001276.41.1741820680678; Wed, 12 Mar 2025
 16:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
In-Reply-To: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 17:04:14 -0600
X-Gm-Features: AQ5f1JrCck7ZrLXTjsNL6uP-21nbhhEyl_MT0WXZGBOwpNadq0-oKKZGcnVqKd4
Message-ID: <CAA1CXcCv20TW+Xgn18E0Jn1rbT003+3gR-KAxxE9GLzh=EHNmQ@mail.gmail.com>
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: David Hildenbrand <david@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.03.25 01:06, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers an=
d
> > expose it through /proc/meminfo and other memory reporting interfaces.
>
> In balloon_page_enqueue_one(), we perform a
>
> __count_vm_event(BALLOON_INFLATE)
>
> and in balloon_page_list_dequeue
>
> __count_vm_event(BALLOON_DEFLATE);
>
>
> Should we maybe simply do the per-node accounting similarly there?

I think the issue is that some balloon drivers use the
balloon_compaction interface while others use their own.

This would require unifying all the drivers under a single api which
may be tricky if they all have different behavior
>
> --
> Cheers,
>
> David / dhildenb
>


