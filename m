Return-Path: <linux-fsdevel+bounces-59948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524AB3F79A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D15716F4A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DAA2E7F27;
	Tue,  2 Sep 2025 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbA05NHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96452DE71A
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800311; cv=none; b=tvzunRRp0R4DIRe/OnZ99AZqVOj5KftMEkQxOMBk+A1OaT3GM/hOcg+n4ACt8VEuo04pSWKy8u3o6p68Owok2bxZN0A1T3iv51Vi5fGz+BPp6DFsmrLgw3ZxqvlXcxd5yNySMGQHjy8ItLqJJpbEQV2fpK/Im0MTle8MoW3Z4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800311; c=relaxed/simple;
	bh=K4Ocs6yu0IqqTnRJwbmWBZCNKRqN+qH+orEPanx4Cgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m7VjPVgMsl7lkjKpmLr0/EdUHG9CQteAM46JPMmQUaP6pyWbCklL5Gr1BC5z8kFJJbr2gTfvSIVMAIAz/5RBSAYBdTL1QXIVLWYzZlw1wUswaofgIKxuPI1oZarrMkLxSVQj/HjmdjnPWFmPC76ZTuVU2cQ/ItqvKcjsdC4sPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbA05NHV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tPo22dHqGBXNfMJC3YtYSt+ZH77YUJI8Qj4kJSNDPxU=;
	b=BbA05NHVohfz9c2GiW1v3zYa0RCayl3A3jsNv8q0SRtveO3F61WcLZ8psD+j6u6v9PaWtY
	QX+oVFBllKErKZ1n6q3xv1vKZ/H8FGGPxNc8WoOsTF8xz3w6+36cJvC1EFJVjUK8imnkNQ
	IWhqbBKFNld170Jly7E4/nMUv2ASNsQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-_2yPzhzBPUapgEiJA3g__g-1; Tue, 02 Sep 2025 04:05:07 -0400
X-MC-Unique: _2yPzhzBPUapgEiJA3g__g-1
X-Mimecast-MFC-AGG-ID: _2yPzhzBPUapgEiJA3g__g_1756800307
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3d17731ab27so2621889f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 01:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800306; x=1757405106;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPo22dHqGBXNfMJC3YtYSt+ZH77YUJI8Qj4kJSNDPxU=;
        b=iO7/ohufen+p2m7/sSc8lINGDBNuaNaUUtpQHO19gRiBQKGqNq2Qy6ER4/YNAsDfwg
         KBSHtMtjOo4EmN/1155iaBOYCXoo74V4AkbaYX1MGwWx06X0AwEfLDK/Dd/SdH9pGbTk
         Hw0ZX00JaXzWVd2dwuG3+Qb8BTng/B9zgLhf1yAW39FhnmIlLYU0zX6XM0ubxGSjDKi/
         y99wxIyhYN8bz7Ekk4O3VeGUE3/owqvT5hAFH2cy0IQN1gazG2O+T3dYl3fVHeAvb6po
         KVeu58rrat7eH8yf2gfomQmZIgDK6nzpuerCTNwP8R0+Dh9WOQfJc3kiLr1ptQn+e8Dg
         HKNw==
X-Forwarded-Encrypted: i=1; AJvYcCWvgHxhec/Q0eqQ+1OfZgE4XwGvWnHCvnCe2GPhspZunZ9V90neBGdIqHDk9CMzQK/ObCj5xhjQ5jRYxs4A@vger.kernel.org
X-Gm-Message-State: AOJu0YzExU6YOf0Q/zb7m1o+j5hydiUAxSzaNPWa69ypKAMxdOWet2Jw
	+L/xz14WDZkhZ9Gl76UlDXB+zxyLj9yelcUZEKdiuVDMMF0CtRQV4m8P5Rz08iDTpCzgJEoXdUM
	c4qyjR5ClzsfpmoYw5WSn/2xSb9pRR2g5kxcOS1c5/Wjza8dz45q+ttJTN/mbMN8wA2Y=
X-Gm-Gg: ASbGncs3yVj95H1hAswTv8E31mvFmxGoumvxHsJgHQOKZcUkfQAbjKLpjsZhUSmUuX5
	7gqyiYKJIwn8r6mvp0oj9hCU2xEAllkvd4VNLpP5AmrDt7VxxIsul8IXW91UGXlEfLlhaEkJDnf
	5n8As+S3fMCGha6jq+vf7jjQuxExcLft3KOzZblpPbTLqz4xg8Zrf++DlNFbyl1EP90K5Fs5Alm
	ADdn5QphUtS/DxDw0xqfjFqbYLAoYqY1UFQaaSuXzmPxa8VWk1xsK6cez6UuA1isHi3mPc2JaZP
	A0PPkIYt1g7yZkvoNJJT1vTgtKXhzrItru5a4U1zX9NVWZcJwQ/yzXo4MXp+w+NVO1/2tjlgYLH
	TGsXse1CgeA7VWyi7C4ht8Er4OTpSY6c0Zf4AWHI9mCu+rTcTvwp39D7QQaA7LfbFyeY=
X-Received: by 2002:a5d:5846:0:b0:3cf:2700:6815 with SMTP id ffacd0b85a97d-3d1dea8c5f7mr6987995f8f.41.1756800306410;
        Tue, 02 Sep 2025 01:05:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzPAh6/Ctw87y1nU9iTpmGdZ0U+BaubKbfxauYz4I7gupbzMzbOUFUgEPl3x3u19pXf1/bLw==
X-Received: by 2002:a5d:5846:0:b0:3cf:2700:6815 with SMTP id ffacd0b85a97d-3d1dea8c5f7mr6987903f8f.41.1756800305758;
        Tue, 02 Sep 2025 01:05:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d7330e4bc9sm6704550f8f.10.2025.09.02.01.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:05:05 -0700 (PDT)
Message-ID: <0f9791f1-ec4a-4517-8ace-945d3437ac74@redhat.com>
Date: Tue, 2 Sep 2025 10:05:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] mm: constify arch_pick_mmap_layout() for
 improved const-correctness
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-9-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901205021.3573313-9-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 22:50, Max Kellermann wrote:
> This function only reads from the rlimit pointer (but writes to the
> mm_struct pointer which is kept without `const`).
> 
> All callees are already const-ified or (internal functions) are being
> constified by this patch.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


