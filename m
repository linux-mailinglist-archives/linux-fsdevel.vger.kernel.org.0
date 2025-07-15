Return-Path: <linux-fsdevel+bounces-54982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5379B06134
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41FB1C46560
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7428B3F6;
	Tue, 15 Jul 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+2wgWrl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53C28A41C
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589326; cv=none; b=DEvUxtOBbOg/9gQbepKps/x/DWFLmDqEfdiREQMQk3X4us78ICAU6qxeTu72D2sOqPCrO+RBeHVqOcZlDhwLMYYrCXrnZME5lx0boRlqDBmUD94mywY2we2K/SzVVOhgH8sME9KUhUv2fFQ5jTjMPHUWD22wQ2B0sljdDRWXeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589326; c=relaxed/simple;
	bh=6vTFftX9JgKJtLyS9WEX0i/rEg1WH40G07TigvFEHyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArA1GUsUJKrO6UWdjMiNUb/qaagvmLSYYQAz9nisULNoJYKrOeHTC9M7f3s2BPkFsAyztEduIhAhFSxcJpAG7yh4mWozhK+OsDC8TXDn92+GJ8zF1bDB1aQ0L01/tHhGS9LPmlOYDc5TZxDfmSvHR8LVL7pIGtcQ+fV1WD+WAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+2wgWrl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752589322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDrEGUfdEY5bNUZj0OPBlZFo/nFLzvL2Qn0I2Pn5t0w=;
	b=I+2wgWrluEe7HTGbGvCg1KJ0YLtRiE1/D11mGVwM4jF5WIg4PgmRTbaKyuqEtl1BOuoQTu
	UEaz+vTG9y0KpoaojIYCwVZNxqn6SW7nkvi0DJwr/cFmOIaNbuCa83XM0aCWFWrDZOiHOw
	yBbQEWg3xltltyDJurgCUFPj0vDAmWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-ixtChKOmO8mpO3bbu4jSig-1; Tue, 15 Jul 2025 10:22:01 -0400
X-MC-Unique: ixtChKOmO8mpO3bbu4jSig-1
X-Mimecast-MFC-AGG-ID: ixtChKOmO8mpO3bbu4jSig_1752589320
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4561dbbcc7eso7652445e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 07:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589320; x=1753194120;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDrEGUfdEY5bNUZj0OPBlZFo/nFLzvL2Qn0I2Pn5t0w=;
        b=o4wKzTls9h6ZcPQ5NQaa0BxXCiS2MhAoOf+FZvzwOuiq6dxS2p+xuvg1bx+MS0upd4
         8J0MqC82es38PS/LpJS2kfZIZtQ0/urzxxVbeEjtiW1yGfl0AwbZrToDJyXEpspi1HDP
         GORG4gdC4tvoBzwjja6eDsCir0rlNu8qADFNPb5GtLULiP+FzObV6gNUxOkYSuthY+08
         iCLHLFUpO8Oic4bB+48ivMUFkLm4N6s+22wepvw0ftN2alMUOSiFZ1tLTp8bm574hyWW
         89jUSJZptN37LlPjXqRhSGX0i2DuueYjpLNyCFuLZLxBCWH9ZaneQXv2l7IYQZ6sQ5YH
         b8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfNP63rumkSrzF9veRJObjJT1byTxZC5de+Z49b6d073RxxTwIh5Pz341N0+IHPiquX7R8LUrb/AYTC34t@vger.kernel.org
X-Gm-Message-State: AOJu0YxNX/l/tfdLaD0UXBsBMtMeDeSdjiI7D43H9HKe9GzdxDqIcm+1
	30jXAuhWxpiuVI/OYw3A2pBtL77hO7PVQWBGzoROc9vym1Hyhr/dwlCnUmN7qived5kE23Rf5Wg
	1+FlgvSxzEoIeAeO+BtLqvowCLRE6NHZaS8DnK13f2h/tlGHiEkoIXaK9/Fa2Sg52qzQ=
X-Gm-Gg: ASbGncskOSbcNUEuMQjDYbgoec40UTRYp3OCwDOoGxppQg/Ci+Un14qcvZ1Fm6jQAcI
	Nv5XinZ5cPdr2/BE3I74qjcfrcv05LZTFHZQ6skAggO8GiF0F7e8WVinqQz2w985E/6iJd3pxfo
	6Sny2O8Mqi0kl5DGoFE7rtIgo0t8LIuXm9ZCC+Gwygc7DJuAspP/lq/sr28bcOuMk4XoCyJ36mH
	Jeh/Ik3N6mCoV+X2s2zDH8Iwq3EbYg8a5YvqXLn/FIHBeVfpvUjqn69v5AZrMDzwnK6a7qvi68C
	LSq1dP4gBPKo7UxAbNyJujyN8zJQpKsV8GoBfPBrirGdEfVU5S1/o4kNEOCWy08tPz+okp87P8t
	GAQMO/IfMSLfc6kphK/BBGtQ+PFT6otTSNMzx6mEBK7lb1BqV8yehYzmWaz6H3CQXcJE=
X-Received: by 2002:a05:600c:a208:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-45627a4535fmr16117405e9.23.1752589319853;
        Tue, 15 Jul 2025 07:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmFicQGLhaeIqIZaRygdy0pZOKRG2JvGq7gYgR7tSdKq9ZAb0t0UWibnFtXm6Rsiqbr86/Tg==
X-Received: by 2002:a05:600c:a208:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-45627a4535fmr16117065e9.23.1752589319405;
        Tue, 15 Jul 2025 07:21:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e135sm15388978f8f.72.2025.07.15.07.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:21:58 -0700 (PDT)
Message-ID: <26fded53-b79d-4538-bc56-3d2055eb5d62@redhat.com>
Date: Tue, 15 Jul 2025 16:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: add static PMD zero page
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-4-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707142319.319642-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
> 
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of single bvec.
> 
> This concern was raised during the review of adding LBS support to
> XFS[1][2].
> 
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completitions
> can be async and the process that created the huge_zero_folio might no
> longer be alive.

Of course, what we could do is indicating that there is any untracked 
reference to the huge zero folio, and then simply refuse to free it for 
all eternity.

Essentially, every any non-mm reference -> un-shrinkable.

We'd still be allocating the huge zero folio dynamically. We could try 
allocating it on first usage either from memblock, or from the buddy if
already around.

Then, we'd only need a config option to allow for that to happen.

-- 
Cheers,

David / dhildenb


