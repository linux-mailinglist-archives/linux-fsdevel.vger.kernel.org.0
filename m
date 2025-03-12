Return-Path: <linux-fsdevel+bounces-43832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82647A5E525
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD78B17654A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240FF2C182;
	Wed, 12 Mar 2025 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ9T0lyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4191EDA11
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810534; cv=none; b=qlS13Q/BZ5TTp7KHTUoVi2QXwHYAjPOFqIib0IGUe6ICEuZ9nOiReZobfvhoXfHD3tswVwQWBDuHefIkXhMM5S1F8F72/dfTv3+cXGyPRaw8Uy6O1NcCJJKSNC93FuM3b7jqyzEwoV878JVJEVx7m9n219keFpQkGl8r6x5rvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810534; c=relaxed/simple;
	bh=AW1UNFDZG15j41J3sF+UBm0LublPLpiYaZymjtd3AYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKSrzuMVNi1woZ7M5uu0d7iCidsF3fNK0m6hp5k1xSFZ+lFiyN8lUty2G1CzHtw5YbRg0wOmieIzfQ8IP7JMzP9QBHWlzrSuOoG74svtgZ4jwmtc308KhYJUyN67BNZKu8kcnkhtZkQcv+h9D6GusY2fMS5DAKvVh0MmhkmdQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQ9T0lyh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741810531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLkIeO0MCQT7MR4XxoTZC2Dt6fLNdFPHwBMGedp21e8=;
	b=MQ9T0lyh0MdnFVflYynmUG7b7t/aHUR7S/AmgTjw94xYR86AIVLuHWDWNzGRsOqi9aFOWi
	Sq6N9TqhVfR5nKvgHScMZ31fXgGnlRMtl3wUUFVK4RpxiFIMnteKpbv3fI+4oNr8NMlmDx
	Kc8T4w0OQK/qpiUyiQuEYOaDxxN5s/g=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-pX-ak3whMW-XfSYCzFDUZw-1; Wed, 12 Mar 2025 16:15:27 -0400
X-MC-Unique: pX-ak3whMW-XfSYCzFDUZw-1
X-Mimecast-MFC-AGG-ID: pX-ak3whMW-XfSYCzFDUZw_1741810527
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e6345bc7bd7so1892422276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 13:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810527; x=1742415327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLkIeO0MCQT7MR4XxoTZC2Dt6fLNdFPHwBMGedp21e8=;
        b=vkz+m1bXVtExxNP8EDSYnveUUsVzN67mmXafyuR42I/9GceZEEwsuX6vQ58mg57189
         B1kJ6JATp6UXT34USsP8gLpF0dUVQUBmZ2oYw87MC6u4MSC9lde3SeV2pHR69bYGyq1w
         4dkufajatsJ7+ZfVQPPXb7KC1k6X/n0CdqBmauWayAAgNqCxcTv7l+9+mg0BpO9k6lPX
         KdwHIze71U+T1l+c5nrSJI8h1pJkpV55PswB2jqtzDsLS1M0xdt76KYzve37D2+SDqUf
         uvbig+3AdbHlAIQduVcTIM59FdrpSz1o6c210ElYRcWfoOQBsL2TPQgwJMbgW/UPPZDI
         hIPw==
X-Forwarded-Encrypted: i=1; AJvYcCXYLTCnjXRwONk3Az/Glt1juZgxxW5imW66qvdY/Tm0Z4azKRa6A9JiU0h61tW/f721RvdCh4Pqi+zW7gvZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBXhbjFzfRJG/ro7Biip5ntPHGpFphFiyrGRxQL6LzV5YNfoA
	Ne8quWkjC81CnG8mYQdfbcvo+alRTdcWQpyxUpLEY+qRIpm8fPOfqw0uz9ZGI+9zxdG77lajObs
	LDVBKIvKiH3v+V5jjg/dw1IizNC1rgtI8T1cta69XNDhzLBuj0zSXhMgtqQWjZVNBX5RZAtIOAD
	UOzjKazRMlie9jXHMOwKdkYtt93xy3jF+F+6LOsw==
X-Gm-Gg: ASbGnct4iF6zv6aqO1RxKrvxlLvwQwF+HMOx+EtEDz3aHCzHOTkRfyBE2eI9nplkzML
	3LsY4FD+MIqkkoHa9m8MkLLUPU8C2mnIZN3f4lEjWFBZ9smLNWqFxRYHYELS0Ir1AV4+4rRyZox
	MAZ0a/ZGeF9n0=
X-Received: by 2002:a05:6902:1b8a:b0:e58:cb:70f0 with SMTP id 3f1490d57ef6-e63dd280e5amr1426494276.6.1741810527115;
        Wed, 12 Mar 2025 13:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRjCueQJTtD1Yip12lTSRS0J2WXsza8uUs7pkqkkc4WEhTu9c6Jn8ZqT/i5u+iVlL2g8+CwS2JOOpWtSQA1o0=
X-Received: by 2002:a05:6902:1b8a:b0:e58:cb:70f0 with SMTP id
 3f1490d57ef6-e63dd280e5amr1426459276.6.1741810526854; Wed, 12 Mar 2025
 13:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-2-npache@redhat.com>
 <oiues63fvb5xx45pue676iso3d3mcqboxdtmcfldwj4xm7q4g7@rxrgpz5l23ok>
In-Reply-To: <oiues63fvb5xx45pue676iso3d3mcqboxdtmcfldwj4xm7q4g7@rxrgpz5l23ok>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 14:14:59 -0600
X-Gm-Features: AQ5f1Joh0g4Z83aGfjvoE-bfcrPmBotalHWvxVjzooJnUWJwOvfHN9lhNGt-h0o
Message-ID: <CAA1CXcCG6pdVaU7PGks2n3SdRjT1xxpP=yfsF3Mt-J4eCcshiw@mail.gmail.com>
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mst@redhat.com, david@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, nphamcs@gmail.com, 
	yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 10:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Mar 11, 2025 at 06:06:56PM -0600, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers an=
d
> > expose it through /proc/meminfo and other memory reporting interfaces.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  fs/proc/meminfo.c      | 2 ++
> >  include/linux/mmzone.h | 1 +
> >  mm/memcontrol.c        | 1 +
> >  mm/show_mem.c          | 4 +++-
> >  mm/vmstat.c            | 1 +
> >  5 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > index 8ba9b1472390..83be312159c9 100644
> > --- a/fs/proc/meminfo.c
> > +++ b/fs/proc/meminfo.c
> > @@ -162,6 +162,8 @@ static int meminfo_proc_show(struct seq_file *m, vo=
id *v)
> >       show_val_kb(m, "Unaccepted:     ",
> >                   global_zone_page_state(NR_UNACCEPTED));
> >  #endif
> > +     show_val_kb(m, "Balloon:        ",
> > +                 global_node_page_state(NR_BALLOON_PAGES));
> >
> >       hugetlb_report_meminfo(m);
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 9540b41894da..71d3ff19267a 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -223,6 +223,7 @@ enum node_stat_item {
> >  #ifdef CONFIG_HUGETLB_PAGE
> >       NR_HUGETLB,
> >  #endif
> > +     NR_BALLOON_PAGES,
> >       NR_VM_NODE_STAT_ITEMS
> >  };
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 4de6acb9b8ec..182b44646bfa 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1377,6 +1377,7 @@ static const struct memory_stat memory_stats[] =
=3D {
> >  #ifdef CONFIG_HUGETLB_PAGE
> >       { "hugetlb",                    NR_HUGETLB                      }=
,
> >  #endif
> > +     { "nr_balloon_pages",           NR_BALLOON_PAGES                }=
,
>
> Please remove the above counter from memcontrol.c as I don't think this
> memory is accounted towards memcg.

Fixed-- Thank you!
>


