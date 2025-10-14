Return-Path: <linux-fsdevel+bounces-64133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE4BD9BAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 15:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96518355BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D541D7E4A;
	Tue, 14 Oct 2025 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQLkKiQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E92676DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448697; cv=none; b=OOAGE2smqYrUWwp6Vau3D3VAwXuisj7MhG3HoqLBzLBYSBACyviEeHdZQcjXgfuzOsd6KO2mN39uBqOavZcP8SG3Lt7AoMZx4zQW4xaOHcbntlFF08gW2xd6Y0gjCp/Dna8hQoAKGl/MlhYugevOaBGm9SLaUqugUYP6NDkEVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448697; c=relaxed/simple;
	bh=iIjZWpm1TiQUVzmyWQwDNnrEF5an80tu+OC+tdhyZC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdmjbT6Br89cGUwjQyLppKJkJ1WIGuaEzeGGe2WgGgmAyOrYw/HaXE2fXhO9itDTTtQqYeTZfYi/ryaBtwqXgIE1sw5SkXxlfWKdwMEgK1clAYW+EEBi9gb/yZpUqZ7p81Z7rtE3RyXIaBruu9lPFC5m+nDQM1/8BOP8NXQFxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQLkKiQf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so9391290a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760448694; x=1761053494; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRUz1hWdNpegFSxtg102ODjrrEjXcJrCzI5fyTVJ/6Q=;
        b=DQLkKiQfZND2IFf/h5wDCcU7nsL9b0MO2/wBM6KPAhNCZWhVN94HQy5fsrTU25tbgB
         2Gq2QvLkWPnA0xkfn7ycw1MgwA2qLz0g6AbmWxcd6bS2Qhofps5FAzMPAi7eFfr7nrj3
         9J10C2KCHIbn2+sRa1U7qZRnp1tmnEvHAE9WILBT/9Nb9MvbcypJtByoH3PDylNSnu6z
         Ql/nNsHVyp7t4cPhcemA2LhGv6CkCqMoygInePHf8U8QXwjfwbEAM4W8B9Bdcu/4Y4re
         drd4lrgRyWoBlvc2EOxKN69l9MeFWyOnJfPQUx/e+/qOIX/3Rdm/jJCyYkveMuFV8AjL
         NL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448694; x=1761053494;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRUz1hWdNpegFSxtg102ODjrrEjXcJrCzI5fyTVJ/6Q=;
        b=UhHzfyk75oKarUptXMso+rLyEvRRvMXSGTgKO/KsRgCD8x8HBXD6CvQ+Kz7UfnxYhH
         UW/WIvucchbBpmR+oXNbmVNIeSQ+TKq0v1sid+5oD5P3yyCW/eWWSb/3ujVDWHKZQxTX
         l6TKB8M0iMehnuqBP4tau6N58fOf+RBiaPyRWH7Uafh9zeoSur85kzR1ENcCKP45nGLP
         1v2JC22xkHnAlZQJu8fL8nQI+mDPWrfszehiBjmMABFHAQd9x1c8d1qCPDjGV99avUlP
         QtUR3wdV9SzEvVYXlpyNEWHCyR48tqUP+aqbTuTrwibm0ljg1CaQV3Czx5N1qIT9Gz7r
         ePVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNWn9c/3ofVtcHnVvZNJxsBWbNDB3CJBLzWwj/r8daay+ukpU2GD6szKgVFcizFwzKopipzwZIQ692RoRf@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCYTm38w0Ebf7B3nCMeBjRPAJzesbtfnE6M9LGSle4MgUEJZ2
	6GQQAmt4r+su17R21CVdQ2vrI3lWX0DGHXS03AWcBpLPL/KkzkS7PV2z
X-Gm-Gg: ASbGncv/Me/FM6u5v8B6j47Wosswe4ScZLgyWXnqP4oZObWEexe0dij73eBGQpLxrAG
	QO033sRJIkOrn5z0K9SLfuIFgWWFB2LDndP327Z03dC0jKIJJg22k/uveAaEIXg7dYnL75S5BRV
	G+UupbNh0IKcD7prvTajzwdJWmHcXSpVZTVkBsicKfanLUvj5CVqC+4Eygobdrbj7ij8iFNfnvj
	FtFOpNs6uVFfas78BUwm8vcczvPmaa2n0ZVUUGQ6+YVn2chL2E017nKDyU1EaPfRUdexiCxkF+4
	WS3PVXOj0KXwzxnYoHm+k5av8Wi3vi80bwMpIAz2PVk9en+PrLCBTA+qeYLSe/Eoelhbac01WxK
	6v45aiSH6x9M+nRfQrjKpOcGDlF31Hu2jLyjyEgyTiajCBDHnWjQ=
X-Google-Smtp-Source: AGHT+IEgU+DdjYJjvofvtunCeX3nSH0eRUv1dqIRtOgeOUMEIzSuMU2hUdZtSc3ZGyXswVn9RHzZCQ==
X-Received: by 2002:a17:907:7f0b:b0:b46:31be:e8fe with SMTP id a640c23a62f3a-b50aa48c4f0mr2728492866b.11.1760448693406;
        Tue, 14 Oct 2025 06:31:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d971ec69sm1123110766b.85.2025.10.14.06.31.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Oct 2025 06:31:32 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:31:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 20/20] mm: stop maintaining the per-page mapcount of
 large folios (CONFIG_NO_PAGE_MAPCOUNT)
Message-ID: <20251014133132.6garfzi24xlh3jr5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-21-david@redhat.com>
 <20251014122335.dpyk5advbkioojnm@master>
 <71380b43-c23c-42b5-8aab-f158bb37bc75@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71380b43-c23c-42b5-8aab-f158bb37bc75@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Oct 14, 2025 at 02:59:30PM +0200, David Hildenbrand wrote:
>On 14.10.25 14:23, Wei Yang wrote:
>> On Mon, Mar 03, 2025 at 05:30:13PM +0100, David Hildenbrand wrote:
>> [...]
>> > @@ -1678,6 +1726,22 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>> > 		break;
>> > 	case RMAP_LEVEL_PMD:
>> > 	case RMAP_LEVEL_PUD:
>> > +		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
>> > +			last = atomic_add_negative(-1, &folio->_entire_mapcount);
>> > +			if (level == RMAP_LEVEL_PMD && last)
>> > +				nr_pmdmapped = folio_large_nr_pages(folio);
>> > +			nr = folio_dec_return_large_mapcount(folio, vma);
>> > +			if (!nr) {
>> > +				/* Now completely unmapped. */
>> > +				nr = folio_large_nr_pages(folio);
>> > +			} else {
>> > +				partially_mapped = last &&
>> > +						   nr < folio_large_nr_pages(folio);
>> 
>> Hi, David
>
>Hi!
>
>> 
>> Do you think this is better to be?
>> 
>> 	partially_mapped = last && nr < nr_pmdmapped;
>
>I see what you mean, it would be similar to the CONFIG_PAGE_MAPCOUNT case
>below.
>
>But probably it could then be
>
>	partially_mapped = nr < nr_pmdmapped;
>
>because nr_pmdmapped is only set when "last = true".
>
>I'm not sure if there is a good reason to change it at this point though.
>Smells like a micro-optimization for PUD, which we probably shouldn't worry
>about.
>
>> 
>> As commit 349994cf61e6 mentioned, we don't support partially mapped PUD-sized
>> folio yet.
>
>We do support partially mapped PUD-sized folios I think, but not anonymous
>PUD-sized folios.
>
>So consequently the partially_mapped variable will never really be used later
>on, because the folio_test_anon() will never hit in the PUD case.
>

Ok, folio_test_anon() takes care of it. We won't add it to defer list by
accident.

>-- 
>Cheers
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

