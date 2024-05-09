Return-Path: <linux-fsdevel+bounces-19179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5F78C10C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DD01F221F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03C015B98B;
	Thu,  9 May 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RI3TeiEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAC12E1F6
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263324; cv=none; b=YUPbZKJ/T44q4pz3xoXJ74g0ThfIZF43l5JSJqxmds2d2fwEiMtkIi4vuZBveAX4M+SblrsobKVuCf8jogRetJ2j6Ho0O3cGp07qVKF3GxYaGwtcHzH86wRfyozw7r6K9cMlnAg1GCzK4ADcMnLbfLsTFLoeXuoMSivcGCzw/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263324; c=relaxed/simple;
	bh=M0h7GIYKm5K8c21WGyDVnq1wSfNIwK2dw6Y/cyw2mnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQXHDCaIdmI9XXtdt2X/pJrkD5F05ARQmFgQSj09s7OEpnPyfSiEv+8rQvSkA+Ym6Huwb4wNrdgt91xPDnfY6KvZILNCFklLGBYcM2D4UU90LZtAVBdlzW1glagE1poFFH+q/TKRl3QFc7FNyxug0+xqgueti2lmJCHhKHCPzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RI3TeiEL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43de92e234dso9691421cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715263321; x=1715868121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxXM07tt0/OK6dXc3DYIRyyq3et18XLiV0rVPn2jyy4=;
        b=RI3TeiELwkUkaOsDHKhU4Ou7D4m2xNRv5OST5lqJL7ExUXKCUr/dbGGqzth8FzcwSK
         eMzUf3LjIkFyt8Zczg8ftoP6zotqLjkNuRd0MMS9trfjP9luBIs2nwuZPMDgLoWpGxqW
         UiLbNd2G6fxAWjSUcGB4ABoydhLsEQ5F5ZXM6hFyiyG1epExNFpqDrPA/URjEXE3qfGV
         XKKXLlIQ9VsRfsqJbw5mKMZKNU9tGupPCkaowRl+xUo2QfdoqJko9VnsPfyiUYy4IEys
         g/b3Dmb6ETwOtUGJBN02i6vz7UHQp2cGNAj9bDGXydwR9VPDinEEPbD66JBmUJFsFGx0
         88DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263321; x=1715868121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxXM07tt0/OK6dXc3DYIRyyq3et18XLiV0rVPn2jyy4=;
        b=ZKgaZK68qBX/Hj7eSD6PE8ZiR/NLHDb/7c9u6j+IAcdJghL+mfDAQNSyL3Y1W2JXt4
         7b7sT+1lOFix02ZSjOn1C0ZDf+Ob2W3quX2E2P6vOMlnWxVUvictyTR8sAyRhrNrM5aT
         pieZrI1uugM0hVPnAN0QTCq7NRmKV28B/35DgKew/D+irEDluKVK5KY8J+bIWCp07Vy9
         vwZVpqFLZXs/09/v6XoSBMvr9pASu4ehEa/NcHMT3J0LvCSrIKg7q8mi097APJcq3cN7
         1KYQFhoDkzIvZBgfwNmjWAAjEsMRgP4/Vuy5k+M/AiH5LIn9NK/8lymdpQYXPTZ38quI
         5YqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuhHW1SwkR1M/ztBfMJmpe5xDOPQR8BicL+VCGXMdJq3oH0vB3bz7XYwzYOXBbHabE6SbMHjzf5TUHe3NZ3Ig8HEy/V3PbposgvK3nUg==
X-Gm-Message-State: AOJu0Yy9kbZkwJOrIIaDes7Pm/L2PK0c15XV4C2FbDVfaoxJRfoxfwh6
	7Q6FUDSnmoMedBfE8l9GaVLjSeN+V7XKiFFV9lCZYkht5u83QmWmlc9rlWvG0Hc=
X-Google-Smtp-Source: AGHT+IHJeZ7OXr4LZ9Z5cUPR+WM0M9J4Pkw7iCipKJxZeay1vOmlP//gFF0u3LftJDLZcU+sbpDopQ==
X-Received: by 2002:a05:622a:90:b0:43a:b66d:1a67 with SMTP id d75a77b69052e-43dec297526mr39555301cf.29.1715263320889;
        Thu, 09 May 2024 07:02:00 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54c95c2sm8535041cf.14.2024.05.09.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:01:59 -0700 (PDT)
Date: Thu, 9 May 2024 10:01:49 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH rfc 4/4] mm: filemap: try to batch lruvec stat updating
Message-ID: <20240509140149.GA374370@cmpxchg.org>
References: <20240429072417.2146732-1-wangkefeng.wang@huawei.com>
 <20240429072417.2146732-5-wangkefeng.wang@huawei.com>
 <411eb896-56c6-4895-a2ba-6c492f8b51fd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411eb896-56c6-4895-a2ba-6c492f8b51fd@huawei.com>

On Tue, May 07, 2024 at 05:06:57PM +0800, Kefeng Wang wrote:
> > +static void filemap_lruvec_stat_update(struct mem_cgroup *memcg,
> > +				       pg_data_t *pgdat, int nr)
> > +{
> > +	struct lruvec *lruvec;
> > +
> > +	if (!memcg) {
> > +		__mod_node_page_state(pgdat, NR_FILE_MAPPED, nr);
> > +		return;
> > +	}
> > +
> > +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > +	__mod_lruvec_state(lruvec, NR_FILE_MAPPED, nr);
> > +}
> > +
> >   vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> >   			     pgoff_t start_pgoff, pgoff_t end_pgoff)
> >   {
> > @@ -3628,6 +3642,9 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> >   	vm_fault_t ret = 0;
> >   	unsigned long rss = 0;
> >   	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
> > +	struct mem_cgroup *memcg, *memcg_cur;
> > +	pg_data_t *pgdat, *pgdat_cur;
> > +	int nr_mapped = 0;
> >   
> >   	rcu_read_lock();
> >   	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
> > @@ -3648,9 +3665,20 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> >   	}
> >   
> >   	folio_type = mm_counter_file(folio);
> > +	memcg = folio_memcg(folio);
> > +	pgdat = folio_pgdat(folio);

You should be able to do:

	lruvec = folio_lruvec(folio);

and then pass that directly to filemap_lruvec_stat_update().

