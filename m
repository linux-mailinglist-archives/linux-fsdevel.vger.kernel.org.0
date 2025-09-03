Return-Path: <linux-fsdevel+bounces-60202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7EB42A7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9F97B2C3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7732DF6E9;
	Wed,  3 Sep 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NC7pzXoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BF2DCF6B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929952; cv=none; b=e6yXi+4m9LpIBL42TEn4hDs1SSbSMlHPkUjHRX4OIlccWqJR0pHPg5R5+qGgbhnZ7pVeR1SzHXmMqXCy9m5KadLwEh6a/O4EUszGpiaPieD/yRktto8XwH+TEkJxSd0duNjt6wS9bxwvIJloh9RiOdqpR02TdlgX/W65xnlJB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929952; c=relaxed/simple;
	bh=5we+GAXeMHUv3iOh96y2D/VT96h7+mOgo3fOex2C8Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujHmEh8N4KH4iwO9RFL17y6pdHRZpwL+EIMlirFY0rBdzdooxNQo0yWmY4VZGjQY0zV97RbwecwjNVa37hQzWxRmnv6u9TysGO3b5lKqGC+D3tvkbMhblUf8MuzBQ0vegxqyG7NNb0J6jMciewsiNzIa4lLQVQ5PraKZcilp9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NC7pzXoM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756929950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tJJW3wpHxiazUQti0atBSKNrLCeANgw+ouJZoVKaKYo=;
	b=NC7pzXoMCvDg2+sIHO34pkybbYHZPybyzcRovKVUlgqvP+jALSrRHCAg7DKvmLNUsfWo8C
	IAuhhowGRGXpQZdObBQFkAhkL0xDzTjyKAN5FmFROmAahH60SlRF57NaDuCmPNi2bfZd4Y
	v7wTWZbYIunTqfY0dJnFNu6XNRgSrvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-PC0BaTHRPOW8rXIrcgxlJw-1; Wed, 03 Sep 2025 16:05:48 -0400
X-MC-Unique: PC0BaTHRPOW8rXIrcgxlJw-1
X-Mimecast-MFC-AGG-ID: PC0BaTHRPOW8rXIrcgxlJw_1756929947
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso1339545e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 13:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756929947; x=1757534747;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJJW3wpHxiazUQti0atBSKNrLCeANgw+ouJZoVKaKYo=;
        b=eMLuUFZITqQPzrHighKOLIuBxzb2QSborqXIFRAjtVvy2rN8mAPe+WTSWkhBUVp6H7
         9MFD3ehan/ycYdWIhV2GTlocwQqzlRg7C+c/btR8ws+Hecco/EffekPplVLSnN72+zCs
         m41ywzGLt+SyxkhH8VOM6CyrEhj87MJIolb897hgmJ8gkJ2HWWlX8yAsN2EWdjNxfbRZ
         xfdJPEedI0azuJB7lPsrt6T3BdwPi+pXmATJ4dWzlXDRAegP10AD69d17LSGga1v5D90
         tV+nB4r6qsuPIytHqpRc7xNnSler+/Wc0ON+1RE2aFYmNwm7ERf2hYIZaT1O3yvlqXFt
         0HSw==
X-Forwarded-Encrypted: i=1; AJvYcCUYHnUPVenAv5AQasVaafDxRzZQPUlmnb+4wYfuEOD+qJnSuycUudCKJmIYDrbJ2geHOwzyDI9vcCi1skJk@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/BIIZH+NOLifw6ABUQ30vtncTVTdO1aRE4drzq7/Oa0PU0WR
	x1I/CN6Mv0a6LzD7NiGJUMyyhYGkeRp4xIZWyE1QFEtrCwUuAvBLOY3EmfI6oqX7DbV7JJRTwpM
	hSD1LrZPComaBXXd5xu1GHakiU1mW46sVni4YrWzrpSJeq0cCxtAkupmqpfgdY3aUheY=
X-Gm-Gg: ASbGncvCdYaB4ZRJRCHhe8tbCk99xyv24wrC66O85Y5wPA+uLc7sGWwKJxAXsKsz0Go
	2gAAkFyZgduuLpuSYlPOdC/CUnNmLGts/oxU3RlATnjJ36Q56+K5fNPUainInhcuHXdVUXbY7Qu
	dniOQqkfjK4oEo8ki1Id2veeMfV7TyWI4Hj7JsNpD/SCOSXSotgwbaC4aQ25+ebeK7B9qwXG8tT
	5OSS6jkeotEasugittLZU+gXBgZJZlpBMji7AlqVKNYVygMfe4y/BqLxIvfygndbewYtjesDgvs
	qsPeNZ0BJM3bE822usEGgvbLW86OgTc/dO6jezywUKYtgg3ogjQmWMqVYZhbrFe/3/wENVKbCRt
	LcuR8WVSHwBD+eAen3eHDE9dIoCrqa0DrWLQKv4n/uzLjHpeoUja3k0ySFB7E67AObIQ=
X-Received: by 2002:a05:600c:35d4:b0:45c:b6cb:e4b2 with SMTP id 5b1f17b1804b1-45cb6cbe8ffmr24788435e9.12.1756929946791;
        Wed, 03 Sep 2025 13:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGru8BK5sN0fUnS1G2rr4hp+6xO6Ql4hkR82i9YyrN5xU7YfiqJER+te2tfeY4mifoi9TYRCQ==
X-Received: by 2002:a05:600c:35d4:b0:45c:b6cb:e4b2 with SMTP id 5b1f17b1804b1-45cb6cbe8ffmr24788185e9.12.1756929946340;
        Wed, 03 Sep 2025 13:05:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm25242063f8f.13.2025.09.03.13.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 13:05:45 -0700 (PDT)
Message-ID: <701a1718-fddc-4ae1-817d-d9549ad71a09@redhat.com>
Date: Wed, 3 Sep 2025 22:05:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] mm: pass number of pages to
 __folio_start_writeback()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
 brauner@kernel.org, willy@infradead.org, jack@suse.cz, hch@infradead.org,
 jlayton@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-2-joannelkoong@gmail.com>
 <e130c95a-103c-40ba-95d9-2da4303ed2fd@redhat.com>
 <20250903200210.GJ1587915@frogsfrogsfrogs>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250903200210.GJ1587915@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.25 22:02, Darrick J. Wong wrote:
> On Wed, Sep 03, 2025 at 01:48:41PM +0200, David Hildenbrand wrote:
>> On 30.08.25 01:39, Joanne Koong wrote:
>>> Add an additional arg to __folio_start_writeback() that takes in the
>>> number of pages to write back.
>>
>> Usually we pass something like page+nr_pages so we know the actual range. I
>> assume here this is not required, because we only care about using the
>> #pages for accounting purposes, right?
> 
> I think all the "nr_pages" here are actually the number of dirty pages
> in the folio, right?  Or so I gather since later patches have iomap
> walking bitmaps to find all the set/clear bits.  Perhaps that parameter
> ought to be called nr_dirty(_pages)?

That would make perfect sense to me :)

-- 
Cheers

David / dhildenb


