Return-Path: <linux-fsdevel+bounces-43109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AE3A4E08D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B48D189EA81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A2F20550D;
	Tue,  4 Mar 2025 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlLTRNph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDD204F73
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097837; cv=pass; b=mHzsCdTJQv0uLYyceoz6K71L5RgA3E6StOInP3wvBq3QSgRuZZ7PvMxBa/TP8aMSp0zBHqJGO1gBm92C2mOUdGEcrSSdvXf3VNmnQk6ylWv4ku4hR7e2xreZriI60Dk8JSknLzDkwPTQq8bFkBd+Us7z6OUuIy4BJO9/DWi6deQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097837; c=relaxed/simple;
	bh=eXllzOnoRt5/aqD3OK5q+LXzVWXzKgBZPq0p3jULFrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDLQDkd1bVxlxv4Oojx9fe4pff9nhmMmkJnpMn57ZhA9Mhkhzr4Ffo+Uaw1iGEbKgRO/pnF8jzig3VdgoKcauBU4VQRoetU/o0UUL6z2DHffuCTMQKU+yt2EA97raV+NRKJJX/ZffPo43o4Js8iCE/zLCWvHqmU6LJhxAAgOOig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlLTRNph; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 1FA9340D91BF
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 17:17:14 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlLTRNph
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6d5G5nwJzFw9D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 17:16:02 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 1F7C742731; Tue,  4 Mar 2025 17:15:27 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlLTRNph
X-Envelope-From: <linux-kernel+bounces-541214-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlLTRNph
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 0131C41B5C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:59:08 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id CC39C2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:59:08 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA8D18826F6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0D1F03EA;
	Mon,  3 Mar 2025 08:58:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC011EFFAD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992305; cv=none; b=PQMOAC3IhJYGcI2Ttid0xJ0IqEYEf0FWqe2tk63K6w4XF+w2OuWNoxngpfj5ahunG/54/aIteNv0kMjhSedGud03UjpCEG79+60J8c/IR6+QVSwe1cOPsr++A5zJ0gbnrwCOchzEnSZWX4pby7hHyi5eq1M/4vFd4n5mh8iNw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992305; c=relaxed/simple;
	bh=eXllzOnoRt5/aqD3OK5q+LXzVWXzKgBZPq0p3jULFrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3FeNi6wkrpDwY09BzQPomiypp59S3L0reebJXfUnJ5PRZyY6AM7eXNdhfkUqFMCnqBh7Sf5/5ILo2VyRVlu1fCfgFxYCpKDRlpwW3AnJXgtb9bXqmtS67qm7irAvv0SD9r8qzWbW61zfuP1BT4uwxltkUWxTkIacv/JZV6A6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlLTRNph; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740992301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yhKA0PWZzkHsCkSvRw6WIRSjH0fQoXRBt2BANeFnGaI=;
	b=FlLTRNphcbOuuY9Lk+b+bJ3bQi0912o4Xn3MpyCyRB2nHnJSy8lH/5o+MnVUXN4l8gEXN8
	zG+HB87chsKAO4Rzy2BRyu//4Fo1oEVSfXmopwGYxnmWSUYpafB8U9Th3dlj1BgpcjgGED
	Dt8lli1sskf9ONOHdFPu/eu+JD0DBu8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-jM3ml-n-Px6345P5nMgzsQ-1; Mon, 03 Mar 2025 03:58:19 -0500
X-MC-Unique: jM3ml-n-Px6345P5nMgzsQ-1
X-Mimecast-MFC-AGG-ID: jM3ml-n-Px6345P5nMgzsQ_1740992299
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3910876fce0so600185f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740992298; x=1741597098;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yhKA0PWZzkHsCkSvRw6WIRSjH0fQoXRBt2BANeFnGaI=;
        b=DEctHM9I6xH3kj5wl554u/MKq7lfV8lx7N2Hw+WGjxJ09mbrz8PAQU3xCy4goyAQLr
         t9KzW7YI/kuXkDbW03IXmKLCdllGRVsamohW9/53zRrqp0oUm8eXRKmqoo7442d6i05r
         21ceBIJAHQzEGu7M9dBR1LXB7aDoUZ5A2BE0cdsAKhej/b7J2hhk6TWGXHDxIIzd3B12
         KJHDBRBn7O6C3JyWppQGYTDdEsUpRMVU2LtRuP0H9d20SUdmWhoZpkU5yGgnadUvq/Ug
         AAYUml0so2m6P0jP7NjPj8/sOX6p2iJVP8JDaDhY8mkUxfD7jIVOuRMOip3oHBIoFE6r
         XQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW5v1QWDGsA/4dql6f6rDFc/DJLpNpS9cDXqed0sc+EG8uVodC69i4NVMarQlN/TYmdql28LQ1CdSQ/v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/bHIsfhlQPdqQlr/04wQ2xWBDga0FJhcaZymkFNH+k9/8SGG
	YFDBIVclOlp+FP6kzRsWufRB4jnVhiucOpfwxPZDLdmi09BAhtsHsLGQvBwVskMODjeqftduHjE
	+0Cn8bcFWxKDI0gMuw07ZcHY8f/+JLkOqfT06qIZZGTWNjzhWrBfE0MF3bDDgMg==
X-Gm-Gg: ASbGncvW/lAJko1F7g7pECBJeKdLC9AVVh+Y+sNS7YZ4RUuZBAoElWDyZcZb+EsC/kW
	jUX2OSbS3zq2Wp/TX/FzynYYcdvayHgDSbtM4DkKd0mEonauRJN4DaCcVXU38s/TdSVEfx8RfEy
	i+pBVEM3XU7p7ouz6Y59L0ujCsMkFFBJyF7fuaOoRkb4D5IdOIJq4wWolAfcS6DHPIb6QkYnak4
	fQ8z65/V8hXhom4y8FAMwQgi2J6hwtwTHhtzfKNHkXRjR0rLZjXY7EeDAvGUh0H/u3QN0uSujwY
	0Mtd28tv+9wX4ondYBefAJw16n4srVuynlCg8tbdETCXzRuPFoDWD4b4x1A5FT0uhU+nE+b5xLb
	OOWz6bypzbAM7VRjipTyMGjDj4uwexzbCotBydm4ODA8=
X-Received: by 2002:a5d:59ae:0:b0:391:10f9:f3a1 with SMTP id ffacd0b85a97d-39110f9f4ffmr1082156f8f.35.1740992298664;
        Mon, 03 Mar 2025 00:58:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrOB8TUQnl8FpqKRAFyy2zHk+Etq0hy84HKx7V6iLK+hyXpCu8bZkk/epZdl6ibKYIEl0N0g==
X-Received: by 2002:a5d:59ae:0:b0:391:10f9:f3a1 with SMTP id ffacd0b85a97d-39110f9f4ffmr1082091f8f.35.1740992298255;
        Mon, 03 Mar 2025 00:58:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e61csm13948947f8f.98.2025.03.03.00.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:58:17 -0800 (PST)
Message-ID: <964e8991-44c0-4ff7-91cc-033ed7c09835@redhat.com>
Date: Mon, 3 Mar 2025 09:58:15 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/20] fs/dax: Properly refcount fs dax pages
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
 <c7d886ad7468a20452ef6e0ddab6cfe220874e7c.1740713401.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c7d886ad7468a20452ef6e0ddab6cfe220874e7c.1740713401.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6d5G5nwJzFw9D
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741702579.40398@6qdeO9SA67PfwkvoUL9KQA
X-ITU-MailScanner-SpamCheck: not spam


> -static inline unsigned long dax_folio_share_put(struct folio *folio)
> +static inline unsigned long dax_folio_put(struct folio *folio)
>   {
> -	return --folio->page.share;
> +	unsigned long ref;
> +	int order, i;
> +
> +	if (!dax_folio_is_shared(folio))
> +		ref = 0;
> +	else
> +		ref = --folio->share;
> +

It would still be good to learn how this non-atomic update here is safe 
(@Dan?), but that's independent of this series.

Staring at it, I would have thought we have to us an atomic_t here.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



