Return-Path: <linux-fsdevel+bounces-33048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFD09B2D10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 11:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B011F228C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6471D434E;
	Mon, 28 Oct 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccWsdmg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A361D270B
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112030; cv=none; b=aW/Tu7glpKb5flSXDXO0UicXMD/FiEoL+TEgcZcL2FH8Rupy2gnjaoU+u/Vh3EhXGBuBBSDHIiidvKic422i+4DgUjfrYFbCZb6iYO1xhY+eesUEoEWVC8BFa9jMG/ZauZAOzKfdhTcGcTm/ijwYZN363ZPeMYnam/G47slCq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112030; c=relaxed/simple;
	bh=wgvOFR93MVO34Tw2IcLbYfyQPbmBhtl0ULhFWXPap/s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=msMLqhxlHrs7Z4XvMG9T1keeS1FrbUUr2tB5sVauGPq+JCp7fCeplPHcctW0rWx095BiuGmENeqciVbZSoE2x0sI7vwbq5Kdmb4OcWkyaavFM4QPphURCQgW44sCnuYjWV0Cf+Eg2GAgIgUFN016uuDYVWeITTiIKAnbvQKBmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccWsdmg9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730112027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BdaIiJhMXSQOqg5cTY+NEVANs9jRAw6a5nwQGChQ1Wk=;
	b=ccWsdmg9DQxELAd5Sc2MNXvb/cUEtKGNH85idIbGDlIxUWeoq1oODLFiBDljkaT/ImQ3LI
	xK3Nbo0nMwkOZO/yyrI0N6vA5igO+BinswP1T24Lqoj66va/f2x9MgTDUMLHWxWdo1+Wlx
	bft/sAaPchyF6VP7t78ygfOPtkPZrl8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-enMyuvgqOQWmHkp600KWbw-1; Mon, 28 Oct 2024 06:40:26 -0400
X-MC-Unique: enMyuvgqOQWmHkp600KWbw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d662dd3c8so2236607f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 03:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730112025; x=1730716825;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BdaIiJhMXSQOqg5cTY+NEVANs9jRAw6a5nwQGChQ1Wk=;
        b=XPlC5jI9t8lsQmruyDxrEszGR5MRthEM6j4YolnwttdJIFU620XyAcUV/6yXTNtvPS
         D8p7N5M/9U9OswfPL1/1G0DfGG7L4B1LsKkde0BE6vY9vVPfvN2VKQck+lJF4p+rAGOO
         504YoajlBzAt0kyw2QnDV5zvoZ2K4NUzYE5tS/tSRyb7zyaTYxU7S0vi5PpPwnIP4xhA
         5Y6jjZ6DFy9MV29HSMHM0vPyrVyfsLxM+eZDOZ5XBvXtofgpTys1ZJhejRP3+DWZy1Tq
         vn+laTOmKs/FVCq2YmNFIisP+qRzxoYcFM9vnoHWfCdAveaiUFu+An68/VDCS5tU2Wtx
         oykQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjFCneBzvDGmAAlzoVp/xw5f6d0vQ7djgPPfhDWtUYunveX5zPUUdHPQDIcrajMJL4ZAhiRYyteH+oW8gv@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjx1uqVLkHOOn7ZTXUi4aZ5YHmU9m3tIcZToe9FTIpKDLe0vT
	FOzJgF07j77pck4+S52bnc7gCFG1tzicwDsFGUf6uLPMymrCBFeZNbMbhjkJESP+0lGMg+vN87x
	IUlQDX9RCpfdqYUXcvx2GTaJ7qH6MlmsQfA0yQG5LKg9M6wTectT9NYP+LTxIkc8=
X-Received: by 2002:a05:6000:10cc:b0:37c:cc4b:d1ea with SMTP id ffacd0b85a97d-380611f5ff0mr6235196f8f.53.1730112025330;
        Mon, 28 Oct 2024 03:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV0jRZSl++wHd4benXoWusxKV2hjEC/fjXGopqXIYY1Es/myN/5gcaoAwev1TcMGRGMWoTVw==
X-Received: by 2002:a05:6000:10cc:b0:37c:cc4b:d1ea with SMTP id ffacd0b85a97d-380611f5ff0mr6235170f8f.53.1730112024946;
        Mon, 28 Oct 2024 03:40:24 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b71231sm9077127f8f.66.2024.10.28.03.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 03:40:24 -0700 (PDT)
Message-ID: <071fa927-dcaf-4df2-b175-5ed6a200f112@redhat.com>
Date: Mon, 28 Oct 2024 11:40:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] memcg-v1: remove charge move code
From: David Hildenbrand <david@redhat.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>,
 Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-3-shakeel.butt@linux.dev>
 <f18fa492-5d59-4708-95f6-9878fffdf859@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f18fa492-5d59-4708-95f6-9878fffdf859@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.24 11:22, David Hildenbrand wrote:
>> -
>> -	pgdat = folio_pgdat(folio);
>> -	from_vec = mem_cgroup_lruvec(from, pgdat);
>> -	to_vec = mem_cgroup_lruvec(to, pgdat);
>> -
>> -	folio_memcg_lock(folio);
>> -
>> -	if (folio_test_anon(folio)) {
>> -		if (folio_mapped(folio)) {
>> -			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
>> -			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
> 
> Good, because this code was likely wrong :) (-> partially mapped anon
> folios)

Staring at the code some more, mem_cgroup_move_charge_pte_range() refuses
PTE-mapped large folios, so that might have done the right thing.

-- 
Cheers,

David / dhildenb


