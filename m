Return-Path: <linux-fsdevel+bounces-37940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 992BF9F950A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2DF18936A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BF6218ABC;
	Fri, 20 Dec 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyekCPiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7E1C3F2B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707032; cv=none; b=kNJZH5uhPu3a2VUMxVHLnEX39kmCgY+3EFa6vAoXNsLZv+akEHpcTZh6YBsn3Qz0yHrZUGh3dm1Jfc8ebOedZBN0fh+jc+opPZRfPHzwU1VSJ5ijLp2ZiruI9Bsu1sqhgB6jlxzKdl3WZCJUsRd8JpPJ9eGv4ilvK7vC6MSvefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707032; c=relaxed/simple;
	bh=e+m7fBHPpMDdNahwnBtswauC8Bzq0gPI01dZRSoqa3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqmL6/vSE/EMkC9vRTa2sCdUJZXJws9jOGLE3sGb619FEFGaOwnVuVywiZNBf1hdiOWY/fPjrTOlMtKoVoQq/0J/tzAvddaF1gJV129o5sYIcH3W9/LcDjOf9u1Gp8PsX/VMUr7m92ciUZQ2NORL1AiidJaYItwbj68WiRv1GsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyekCPiC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734707029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OWAB0kDBETvYpu2MrV6mU0PsK+ELU4H4C8gE6dHo/1A=;
	b=DyekCPiC5Tf5YlThowa5nTt2w2fKIbSpkAXN49IL6+ZncSV/RzT1A/yeApyOvsesVQdbS9
	APtlfovTMWps2LQQLvz4kVWja1goWGSw5fIr7xpAsyEM2dzisBBmxILzb2X4ptNAaDLu9+
	gQvXb2jNtkOo2FAxYi1PUd6j2LXXI+Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284--zBwKtKNM1uAyLBnZ4ekvg-1; Fri, 20 Dec 2024 10:03:48 -0500
X-MC-Unique: -zBwKtKNM1uAyLBnZ4ekvg-1
X-Mimecast-MFC-AGG-ID: -zBwKtKNM1uAyLBnZ4ekvg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso11473985e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707027; x=1735311827;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OWAB0kDBETvYpu2MrV6mU0PsK+ELU4H4C8gE6dHo/1A=;
        b=WwEkBSPRZ5zDc8GAnlC/q2sVfu+mkRwAqoPQ99XyEv+cUnGqXzQf1vvsrNQ0M6cFVr
         ZV5Q22ykVxdhkq2qGZhuKqKmHYUyhbBvQr5aysqVqQS/qyfbb/DaCN5MCl4LXNrz6wSq
         aFchOzxp29q5l1sl2ycJ/2jLXxoMePctz0bBZZMHdJDSlWsbH0AMtTmCg5OAmrwHszIF
         nUzcusG7iFSx/WXFBekgepHwrBVI9Y1es64DsLCi07avcZVl5BGRIdMQuNvdiSVigzSv
         7SNytpH3z/+UdaxLHaFqt4kn3QHGqnGO8sApR49X0k/9e1elVukSKnBk+Zse1MyJzXv4
         Favg==
X-Forwarded-Encrypted: i=1; AJvYcCU1jDr6YGeVD/kjY8Ld0f3OpjYaLDHGc+Vp5WlyJEDr9+l4iY/6YfRs/Kq0x8ROPzAYtGHZ2Njwxhsj7iGH@vger.kernel.org
X-Gm-Message-State: AOJu0YzLXtiNnuu8ycKpdnBYKLizKd5vbBMDV4mldTLKVr839883jbgr
	XyLTyZkst7P8b9TVAdtfhH1SY0+L0HlEwqHriz3QZMkXDm7tmgbjXetjpcKV6ktr6PqDEplZ9M6
	r4alIH+d9iVam8ZqSE5ddKXK4lhutALC379eX4fbXogX3X71KgK+wWdmbcyJjm1M=
X-Gm-Gg: ASbGncvBgBu500ImmBMmQfT6u09zLw4PZl2G7cgEBqEet5L/0Kf7OyE1McPfqvihzFe
	n2j2BLUwFcmntF3XpOLlGlj4TozdmhtN0BHokmK3XAN71qLFf4l23A2jDhVCp3ZzZxp4mJZtWgt
	2G6BLbMPh5wTuflSg5Wko8u/CyFaGMDBRejHGIMJwUweF8cbhZ7HRJQSO8DpAb6o4M49T7qP/8g
	BZo0RedzX0aaEO9Ftvy4fIr0HtzpN8MeH/52P7nl+rTu3gETr1Lx6oH/1PPwK74pzYSXtJw6W6Y
	lOmTXQ0RhYW9jzW3d6rePNzfi26HCfz5ru2OzTcOUBPA2r5GH774OLNtC7ISH8A5WR+by9QZ9gB
	1Xya3lFNU
X-Received: by 2002:a05:6000:4012:b0:385:f892:c8fe with SMTP id ffacd0b85a97d-38a221fa22cmr3417278f8f.21.1734707026726;
        Fri, 20 Dec 2024 07:03:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnarzRDpKkohEao/pdyX0GNLj+85BhrAGPwqQr4aAIG/ckAEOg73IGCK6l092v0cKpqvqSWg==
X-Received: by 2002:a05:6000:4012:b0:385:f892:c8fe with SMTP id ffacd0b85a97d-38a221fa22cmr3417166f8f.21.1734707025953;
        Fri, 20 Dec 2024 07:03:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828ba0sm4188959f8f.14.2024.12.20.07.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 07:03:45 -0800 (PST)
Message-ID: <042d3631-e3ab-437a-b628-4004ca3ddb45@redhat.com>
Date: Fri, 20 Dec 2024 16:03:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] mm: add PG_dropbehind folio flag
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 bfoster@redhat.com, Vlastimil Babka <vbabka@suse.cz>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-5-axboe@kernel.dk>
 <wi3n3k26uizgm3hhbz4qxi6k342e5gxprtvqpzdqftekutfy65@3usaz63baobt>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <wi3n3k26uizgm3hhbz4qxi6k342e5gxprtvqpzdqftekutfy65@3usaz63baobt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.12.24 12:08, Kirill A. Shutemov wrote:
> On Fri, Dec 13, 2024 at 08:55:18AM -0700, Jens Axboe wrote:
>> Add a folio flag that file IO can use to indicate that the cached IO
>> being done should be dropped from the page cache upon completion.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> + David, Vlastimil.
> 
> I think we should consider converting existing folio_set_reclaim() /
> SetPageReclaim() users to the new flag. From a quick scan, all of them
> would benefit from dropping the page after writeback is complete instead
> of leaving the folio on the LRU.

I wonder of there are some use cases where we write a lot of data to 
then only consume it read-only from that point on (databases? fancy AI 
stuff? no idea :) ).

-- 
Cheers,

David / dhildenb


