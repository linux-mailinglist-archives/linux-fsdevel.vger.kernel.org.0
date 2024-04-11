Return-Path: <linux-fsdevel+bounces-16683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF48A15C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3092284C6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E014D44D;
	Thu, 11 Apr 2024 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cd76YDqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79614D29E
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842664; cv=none; b=Eyz2u68Ag8xcdg8WwLMwi54ewY41PgfkKqNgS7EoFoPsEslyXWF+VkJ4BJXqW1bQm2t3j9ZffldwHuxUotqs1cxc+/2i3xYR1A6U3Su/5DeZILNCZHrNl9M2YyJHWX461Fqki7+PYNN0CDEGG3zT+0SacpWolfwQJSxQucNGXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842664; c=relaxed/simple;
	bh=DIAb7MBg/O79YuapLR2aNqATub3e0SOKNJsfHZ2b5E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlIaS63g5mA0PQvezf+dEZj7W90pPRpBMoepREA1Bp1h2w7IPkA6RD+MRKpWG+g9ovZsM7FCZozMskXDjS1sI+/eFyregqNQ35SqsBZezU4kLZhJTrSLQ4pqc/ZAXb/tTFddRv2eU9Z8D8edAXA3wMaD7JznEZCm9qlRzf+SQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cd76YDqR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712842661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dERZePAMGY5Ogff4MXaSm74/ezvcT6trwfEdO0OfoQE=;
	b=cd76YDqRGMktNz2x+QEwyoSAkJJtepEeaklAP5rugJRWAYLN7sQQ1hzR97fbMKyxLE9UbT
	Etp1spDaoFySssPu5YcLnXa83NAgANvX3A9/Op3TMGIzVyrSJsNZsxJFbDwWXC3qcSzUBt
	IIk784IMXj+suUCF4f1iu/GunjPVSxg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-5jkkeft0OnaIN521sky6yQ-1; Thu, 11 Apr 2024 09:37:38 -0400
X-MC-Unique: 5jkkeft0OnaIN521sky6yQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69945bfdbfdso2030816d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 06:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842657; x=1713447457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dERZePAMGY5Ogff4MXaSm74/ezvcT6trwfEdO0OfoQE=;
        b=gyd0G6HwK77HDa4TE3ml7bJ/UzcHtdaGDO5vjpjGOSNMiExlaSOT2Y5nytXYDM3GXc
         JZpRhMgyCW5GNm+je7yUxxCwFur3av5mkI75wUQeCutuGbN85Nx54h+5vyhex8n4WudH
         DJvIwHhgda2HdpwEVTcFmN+fER6G3Zbt/V39PBsl2rAFcqCXdXBPO/xlvjBdhc7RziqP
         GzJ4pLSVW690UAIyoODy7k2ENyezF68ISAYCw4W23B/8u60gxiVWR3hFNAZg1tWrdofC
         3Wsm1svhY3MCjKK5wYYamtu4t4jQ6mV12uNdxNEhfDH8hsxwjJ1KdJw3sXW3enQuyVmw
         OZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrYaYbjDQ61RyeDsM/K0baEcPCApEIpvD7XX5cXoWtBdlVAgGQD+A7O4jtn12AIWosYhLuEqvjdrt5rvYEUhG5C52pLtd+ROWHkMo7UQ==
X-Gm-Message-State: AOJu0YzmxhmgT+hSmRjcg4bHuAVfOhc2E5TiyIv0uyJHw1rRxvqbNsa5
	LUegHqNc4pusyleqmfSt6Tr4eUILKBytIm+yYCou/ihO1l1rFfX6vB981hShceGDtP02yUoJOX6
	8KciB1zlpYuG14tC9MopLRrVuib8v9iCXnN7V31WsdqTh41iP50dphvUzVR6Rj2Q=
X-Received: by 2002:a05:6214:da1:b0:69b:1833:598e with SMTP id h1-20020a0562140da100b0069b1833598emr6052229qvh.6.1712842656856;
        Thu, 11 Apr 2024 06:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ6y7GR0pZzFXXvPoL0L/gLuIw2bwjbZR6CEdv4NI7c2F2dzHLnZvnROzJ8bJwU9WvPh/HLg==
X-Received: by 2002:a05:6214:da1:b0:69b:1833:598e with SMTP id h1-20020a0562140da100b0069b1833598emr6052197qvh.6.1712842656337;
        Thu, 11 Apr 2024 06:37:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id e7-20020a0cf747000000b0069943d0e5a3sm946973qvo.93.2024.04.11.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:37:35 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:37:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	david@fromorbit.com, dan.j.williams@intel.com, jhubbard@nvidia.com,
	rcampbell@nvidia.com, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
	hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 02/10] mm/hmm: Remove dead check for HugeTLB and FS DAX
Message-ID: <ZhfnnYfqWKZn5Inh@x1n>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <e4a877d1f77d778a2e820b9df66f6b7422bf2276.1712796818.git-series.apopple@nvidia.com>
 <20240411122530.GQ5383@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411122530.GQ5383@nvidia.com>

On Thu, Apr 11, 2024 at 09:25:30AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 11, 2024 at 10:57:23AM +1000, Alistair Popple wrote:
> > pud_huge() returns true only for a HugeTLB page. pud_devmap() is only
> > used by FS DAX pages. These two things are mutually exclusive so this
> > code is dead code and can be removed.
> 
> I'm not sure this is true.. pud_huge() is mostly a misspelling of pud_leaf()..
> 
> > -	if (pud_huge(pud) && pud_devmap(pud)) {
> 
> I suspect this should be written as:
> 
>    if (pud_leaf(pud) && pud_devmap(pud)) {
> 
> In line with Peter's work here:
> 
> https://lore.kernel.org/linux-mm/20240321220802.679544-1-peterx@redhat.com/

Just to provide more information for Alistair, this patch already switched
that over to a _leaf():

https://lore.kernel.org/r/20240318200404.448346-12-peterx@redhat.com

That's in mm-unstable now, so should see that in a rebase.

And btw it's great to see that pxx_devmap() can go away.

Thanks,

-- 
Peter Xu


