Return-Path: <linux-fsdevel+bounces-39145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39CAA109CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E0718897D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C786C154BEC;
	Tue, 14 Jan 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4WTnxxr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE814AD19
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866074; cv=none; b=ojPSJcbrJzhQMVTXuyghPTEH+kMOmG9arTziA+CFyAeIwjw1v605/5Yub+j/bugLaM8oEizxlyGPUAJHxkbFlXlVz2c/1Fl3Guv4u/POha73/jXpMQDARQGNuA2Qx0VO3gZY7Ql4KfNf3ojwH4g/UfVBnLXJyQLFrD/tEQAcg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866074; c=relaxed/simple;
	bh=n0gFWavEdTvtzvVwm6qJrQDd/tgnPw11Y8Zbx+7YwaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfFmQpg0fMA59vXp4Sc+8CSBCJuj50JQvs5Fhc+6MsMZyBePXQ3X8QSwaCAxitQe9FeRpf0utmsDyOg7NWndW45quZltm+svksJEfSZKKjItc7U5oexcSyV3DpT/qROi2NrhJ+VR2pVrIMxVdhGMMfgvIhcocHBEKKmQ2lApZ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4WTnxxr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736866071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W1UWAgLlJaquYVVEeAD7AobVV/dxlnCJ6eG/I3yuA44=;
	b=F4WTnxxrRVt9a4mgGswp1GoxID99wDhJPdsRd/IVAUEyQB+2AtPs1gWh5R6xz7NSQ6oZJy
	OMcJ8OA6MtwUpNqog1/qupPCe+ZL5Q4x2jFLkyC5iq1Q6Ae5osKSo+qZi/H5Aw6uJj6M17
	eGOl7I5oHzVEWTCsnszbPlmH/PlRP3Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-FZw_6fqkMtWd1MfKSsIKqw-1; Tue, 14 Jan 2025 09:47:50 -0500
X-MC-Unique: FZw_6fqkMtWd1MfKSsIKqw-1
X-Mimecast-MFC-AGG-ID: FZw_6fqkMtWd1MfKSsIKqw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4362f893bfaso30509685e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 06:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866069; x=1737470869;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1UWAgLlJaquYVVEeAD7AobVV/dxlnCJ6eG/I3yuA44=;
        b=lZbqAMG5rSDPSmURgcvi4cZf+4uUgvIqYkC1MmOj72TAlbakiwZfjMniFQcRN/ZSFt
         Ykv6YEQeeQ+TDjtP9Rcz4E4MgCemE5tVu1CXjO2sTG3VmBalLEjY0P1GPf7ALjk23XtQ
         ZQnMEF4KSiV8LW++XollOLXEayxvniuIt3R2KWGuXHUUDGRaT38c3boXkDnx1K+6KxLq
         PPXF5rA3QosZn+uJkMxk1PA/McfgTuGWfACAceY/PoKJ59Xo9geFNNN7MlG4K3Oy0SCA
         lM6vs+NEFrXDkrIs3MSxBMXG0/gUwvfv/kIxtA0MtURGvTrALbrAY7iG5il16IOg18Sm
         L9/A==
X-Forwarded-Encrypted: i=1; AJvYcCUHXmkNgS+erOAttWvH/mbKLweaDJZOvb5tARQ+8EtI+sFlo908tDNZWzPlupVFVp+zsF2QvvIAxZhFZB5X@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKGDRPFFdc6YKDfpn4+V+z5JXEm7KdLH37oBh1VwRmmZsFZ5p
	atDQYqGbbG+OcNlDuVU6l/VAyGLyHecAVC/mwW4f5AOX7ClB4TbiBLlyyrlxLZT9rHoFhD7K3B8
	7mHOrSeVjZpwJ/WzesHMeIlqvEq7FJy58eXDK3mk4+HeOrPI8iu+6Z+qW4U/4xhU=
X-Gm-Gg: ASbGnct93y0vkN4WAuX4if5kmEfJiPZhs8Huh4IPrXU9EVeZ5qbiw7k3OYX1mS1TDCd
	p0PBzbqWMKfxPJr2u1IXv5qSBXbbhpfIra170nW6Yswjy0gT5CNQ4A0UzWW6Q6vmPScZDrzTr1x
	IGdfOd/iOeuJh4N1hlOvEw1Q3nJREeJzSfYXEUqTuqKGrlMWEgtVdTqnWVgDTykCHFsMwh+LrmT
	+dgjrk1t+8dcFe7PKugci4K+j3+lj3kfuxvivfP8QdKENG6ZLrxdkQIcqhByXBU5wLI6zOcKfTE
	qZZxeOw6CSrGnMoKjqWqeUJYqzjkLv1QWvrJb0nqoKwER9WzhIup0PKj0AHaRu9iFAaqXGJL8p2
	qVqAEanT8
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr219460575e9.3.1736866068918;
        Tue, 14 Jan 2025 06:47:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEENnT/QV/z/XX4uFBevKHkPxg7NffS9Usi3CNGFfMDEfqLcKcxnlPQgZ2KD/ykp7GZk9Grug==
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr219459495e9.3.1736866067102;
        Tue, 14 Jan 2025 06:47:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1967sm14681312f8f.86.2025.01.14.06.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 06:47:45 -0800 (PST)
Message-ID: <f696d28c-c3a8-4500-98da-4ddcaa0db41f@redhat.com>
Date: Tue, 14 Jan 2025 15:47:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/26] fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping
 flag
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com,
 gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, peterx@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com,
 hch@lst.de, david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <b8b39849e171c120442963d3fd81c49a8f005bf0.1736488799.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b8b39849e171c120442963d3fd81c49a8f005bf0.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 07:00, Alistair Popple wrote:
> PAGE_MAPPING_DAX_SHARED is the same as PAGE_MAPPING_ANON. This isn't
> currently a problem because FS DAX pages are treated
> specially. However a future change will make FS DAX pages more like
> normal pages, so folio_test_anon() must not return true for a FS DAX
> page.

Yes, very nice to see PAGE_MAPPING_DAX_SHARED go!

-- 
Cheers,

David / dhildenb


