Return-Path: <linux-fsdevel+bounces-40309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB5A22162
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6DE1884DC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A81DEFC4;
	Wed, 29 Jan 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFiXsiHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5BE1DED73
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167011; cv=none; b=J/oSUUoT+LgXhAgEMPjG41V+GZZtsup/DlkSpHuqAwRmqshYSY2doD7M4uf4wPl5G3ahZMizlBAiCLyVZQlHymZrqbM6JClm0zkQYdJ9EzgmVrOZAZxcIxLGllgyj/3g+pVSJoodj/leJP/+DAP6jvsMw/fTp0S+JOuWY5DcsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167011; c=relaxed/simple;
	bh=aJg2pGbyYaXNfFFI0xi7sNC2Bh7oXdAOtBDJ+CQblRM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=H7N5Sq5s7vNrLgnZN1sZZOgpBX4lk+WvG3/5fE5xT3pYT22EwVchl9AWOrJOaa92ynR2JzkTwRLrdU2jZs7VqhDZT1WWOpgYBxSBm5yrERlUdtMZQb+OUzN5Lmn02tZ4p+0n1bta8Hny6lh5O6QfG8OoVJKs9MyKD0yvlNZmui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFiXsiHo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738167008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=+Sviuz/7PdVGldcMvJZHEYR5dXaqXDVQMCd1NnVoeKY=;
	b=VFiXsiHoedLpwukzJeOQnMqC8lIjwItaVt+gQMj5b4Kj32O4KI+QQJqS67D3wqOjHJPcs6
	+OmfBqTxuiuNyZ+UlhSDG6137BlokxDDIx4V4Xi3mRREZRjGtnU+/zJQkGfQ+H3YUVUyA1
	Mt9IgnbGwwfaP585BlNjaC/bGKF5T44=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-iga7rBuYOECcszrMejukJQ-1; Wed, 29 Jan 2025 11:10:06 -0500
X-MC-Unique: iga7rBuYOECcszrMejukJQ-1
X-Mimecast-MFC-AGG-ID: iga7rBuYOECcszrMejukJQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385ed79291eso418846f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 08:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738167005; x=1738771805;
        h=content-transfer-encoding:organization:autocrypt:subject:cc:to:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sviuz/7PdVGldcMvJZHEYR5dXaqXDVQMCd1NnVoeKY=;
        b=KuFkW/V+7yY+DDZJcGslinZtAAQaS7ruUbxa0uEeJcTqpZX8L1ysK8ClTmw7vos3gx
         gQUiJ/ed//o42Gg1hT7q/CaIxhuRU8PoJaOhQey6GfrF3YnlCRVqyziP9R0PoKSQTsvq
         sMevIczPBvl6BWyBr80dqdvXN3aZ9UPSffTsxLdCvdW+AhgX58kL/uN9v7HVTjWYhN4H
         hn2w+P4rfpoj3hFNJ0jjlcp1AJnA2Q9Zt3tPmp0A04C9DpOE2ZzQmY/MUFhub3O40YsG
         auWz58kZy0mGpqlIefiPmzWYm8njR7bgjwclLXAZhk/OAF/7bjwwx/EUEporWUyhE9bi
         Z2YQ==
X-Gm-Message-State: AOJu0Yyqguhr6bSGZHT/t24/UhO6kPzDDQEQ9KT2F1rVo3RNToXZAiyr
	NICExySxzGf0DEOyUXBLEyJCYoofUfoJ3b/tokiTz0i4knxw8h/KOztnp3FGb1CfRMaGwgiuqFf
	GV/tAd6uwNRmsAMK/tYVBY7O//GkoWHJcUd9ZqLOllZ2irH3d94tkoNojhxj6ac8=
X-Gm-Gg: ASbGnctpzsKZ3iWHHu0bh1ALM1l8NZsrmwgMsc/MpkoAZTy5UMRgZBDaqSgssDCZNw0
	x0fVD2Ckj1p5l387ASrvCWdaneQt6My3Exxj89B6tipY63MDMME0oQi9pHedfsRdfiQRF+byHIG
	b/Erg3oHuhvK4mwNovU6ihRD6Jcr/kZJmPOGCW1KnGb+Sx62nNwqn0PB7QYQPPeIwdSLS1+uXoN
	Gt31Ryhh3IOjMRPI9PLxOt0ioh+ggPZC4tMXIqwffvq2/Hp91q+7s4dGNnGX/zJB9jiKFw5/FtC
	fVO5rk0hZD0tzQDlCHC2erWarRwKbIVA83LdIFkleHteeTZJWu6q7683pcGDkDlN4eDhXBA9j1G
	W8ltk6tX2123AJrdYAbrzzB89ZEVbcD2e
X-Received: by 2002:a05:6000:1f81:b0:38a:a019:30dd with SMTP id ffacd0b85a97d-38c50fe7e90mr3232359f8f.8.1738167005567;
        Wed, 29 Jan 2025 08:10:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJU2RM8iDcFoezcOv5+sEpTMmBvKEdvji8omBs1fmfQ9d9s2OyrVeDnZaW2KSppMTM8usjEg==
X-Received: by 2002:a05:6000:1f81:b0:38a:a019:30dd with SMTP id ffacd0b85a97d-38c50fe7e90mr3232324f8f.8.1738167005099;
        Wed, 29 Jan 2025 08:10:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:3b00:64b8:6719:5794:bf13? (p200300cbc7053b0064b867195794bf13.dip0.t-ipconnect.de. [2003:cb:c705:3b00:64b8:6719:5794:bf13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c4b75sm17208188f8f.100.2025.01.29.08.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 08:10:04 -0800 (PST)
Message-ID: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>
Date: Wed, 29 Jan 2025 17:10:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Jeff Layton <jlayton@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Joanne Koong
 <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: [LSF/MM/BPF TOPIC] Migrating the un-migratable
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

___GFP_MOVABLE allocations are supposed to be movable -> migratable: the 
page allocator can place them on 
MIGRATE_CMA/ZONE_MOVABLE/MIGRATE_MOVABLE areas: areas where the 
expectation is that allocations can be migrated (somewhat reliably) to 
different memory areas on demand.

Mechanisms that turn such allocations unmigratable, such as long-term 
page pinning (FOLL_LONGTERM), migrate these allocations at least out of 
MIGRATE_CMA/ZONE_MOVABLE areas first.

Ideally, we'd only perform this migration if really required (e.g., 
long-term pinning), and rather "fix" other cases to not turn allocations 
unmigratable.

However, we have some rather obscure cases that can turn migratable 
allocations effectively unmigratable for a long/indeterminate time, 
possibly controlled by unprivileged user space.

Possible effects include:
* CMA allocations failing
* Memory hotunplug not making progress
* Memory compaction not working as expected

Some cases I can fix myself [1], others are harder to tackle.

As one example, in context of FUSE we recently discovered that folios 
that are under writeback cannot be migrated, and user space in control 
of when writeback will end. Something similar can happen ->readahead() 
where user space is in charge of supplying page content. Networking 
filesystems in general seem to be prone to this as well.

As another example, failing to split large folios can prevent migration 
if memory is fragmented. XFS (IOMAP in general) refuses to split folios 
that are dirty [3]. Splitting of folios and page migration have a lot in 
common.

This session is to collect cases that are known to be problematic, and 
to start discussing possible approaches to make some of these 
un-migratable allocations migratable, or alternative strategies to deal 
with this.


[1] https://lkml.kernel.org/r/20250129115411.2077152-1-david@redhat.com
[2] 
https://lkml.kernel.org/r/CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com
[3] 
https://lkml.kernel.org/r/4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com

-- 
Cheers,

David / dhildenb


