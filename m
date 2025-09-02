Return-Path: <linux-fsdevel+bounces-59945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C367DB3F781
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7D1483CA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1312E7F1D;
	Tue,  2 Sep 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4h3P23p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D4246778
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800224; cv=none; b=uttCBETzw/L1BtBVMEgQVdeYfi+3TitKIrQPR+9hSUztRva4+u65Y9bMDD0YhX3Cbi9W8k+P8id/0s+EGCkFyNbchfLi6CKnuP8bYzJn+kj9R76At+kskErzRjaf6pfdyhDCmLhx6FkUQKe5Pg4olXUbHZLYiT/hYnPSDGHvJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800224; c=relaxed/simple;
	bh=ksKqA3iVgcDyVSoIBjmEtSC5G07laXVwfks0AXMVGIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZX8UTvvVIEqNYtqAWE0d5vqdsegKvbRr/j9y3kQDVc++J3YTLJOeygco7L2WJtEa3fDEY3dhcPe2wk6QvgK7fjAL7bu80h9uwrOXfn5OAPJ5rTqdGz9iD+T3ohtDsjp/Yb2+Xdcdg0QT5PLs24KecXrVQ50XTooqtMxn7n1Unho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4h3P23p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aS4Vyr1Pain/urXoI8HpaIVdg+wdDq3QstyD3UxMikY=;
	b=b4h3P23pb9ok7l0b4InavRynzp38A5K1rzIYUZ82JO/GmH4WClTEcoz5UDYzIlZVFe+lf+
	kPoUBLLw4n33ZUiv7GtluIvIgT4p++YwmgqJjr8kAl9t+cmG/q1gcLDf1iXeG9YrQn4PrG
	Yn+4oyxBHxHTpnf+2zmZqpyZBw40i/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-pxpAkRKKPu-0_Y6it3Uqeg-1; Tue, 02 Sep 2025 04:03:40 -0400
X-MC-Unique: pxpAkRKKPu-0_Y6it3Uqeg-1
X-Mimecast-MFC-AGG-ID: pxpAkRKKPu-0_Y6it3Uqeg_1756800219
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3d17731acb6so2686167f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 01:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800219; x=1757405019;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aS4Vyr1Pain/urXoI8HpaIVdg+wdDq3QstyD3UxMikY=;
        b=FRVPX8H8ycuEeCJul4Z9M5yOkNKQYiiC9w7Jt8jkUadrlPnNpwTaOtHCpXw/R+g4u6
         fEC9gRXwpQRwlU2jxGuT61H9tWP1oKAgF+W2EqV2YxbtoMsIQ+G/3nXC4AyuKnOCBPDZ
         bF7bz7Jv7T8goN7AhnF3/YJr7mHPKP8lETDoYxB6uf6NnXtGckne8OjWF4wqp6hykRuJ
         73vp+JxewzRbCslUdmWZOcXUbu+ZRBmmKSucEr8aEglAkEIp+ZBLfSvh3hhbfxtSarW0
         Mmtki9nhbXcQvdbUzKS1rqzVLdkRia22zdpDycZCi0AEy9EBVyYZFuCD6H8OSCntXwdd
         3XFg==
X-Forwarded-Encrypted: i=1; AJvYcCU6r0PCQ8N5WCUTxWRO0GWJ6xCXhKvIkdxud95dAZ2qCuNzFrppcoyTBwCk5cBBmI5pztWF7AiUdbR1O+9w@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNOX88GbQrKaX0eYfsnIak9UxTiNRl/jmXxn66hLwy35EN28L
	Oq6Is95ymL32b1JwWkEIwAbMnuGOEn1ZiKltHZw8yPaKly8+CrpJBuynp9hCgPxiOUq+dJsCwer
	TJbDJ7uv5Ot7HlcuUcfUuOktbG0kAJM6jDv7XfQsccUVL1u4EHIKwXtjByP/VhnH2QT8=
X-Gm-Gg: ASbGncuJ32vJXOv6wBhb6gMBarsT9tuucUZoKhO6ITi4tsNsU+SLFabBh40WTg14np8
	prenkEeZyYbd0pRwPfWdnrU3oFMhT1dsPXnzYIDJxyLBDwwJDk/8pLZucmaoo2TEtoXBQHpgRnk
	tcz8j6vFxCtM5byZE8Fgl+mio0m9yOfAn54Y5M4CQ3et0nDuW8M+0lKZBgGkWGBoNMW3ch2zxaZ
	XdjkZ3pFDqkpfLcjrBpFb1xkfcdpkPJ+/nuYNOZwljIB5FnmbVi11zoVlrkCoO8m5+sJnBRMR1S
	Cv7/s3CZZdb+gSVKdNqviWWsvGDC9JkH/6vIP88fcs257OviCAOoazJDPFeUycuvSF5Yma13uX4
	x/lq/j3DMxhvM6yAxRgGw5KBJdpT7E44KFHSMWEZFO3+b4xEqLcHGS8tDwBONiuUCvrU=
X-Received: by 2002:a5d:5d07:0:b0:3d5:4967:1895 with SMTP id ffacd0b85a97d-3d549671ee8mr6894425f8f.10.1756800219157;
        Tue, 02 Sep 2025 01:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQpyPxYTW4X3f3NKWjIgNaSxeeHpjwanEWaUJCVc+WrhnHijlVjaMRV/TGhD+ddM98xdJSAw==
X-Received: by 2002:a5d:5d07:0:b0:3d5:4967:1895 with SMTP id ffacd0b85a97d-3d549671ee8mr6894360f8f.10.1756800218588;
        Tue, 02 Sep 2025 01:03:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2edf1sm7879366f8f.16.2025.09.02.01.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:03:38 -0700 (PDT)
Message-ID: <deaabbf6-655c-4a83-b5f8-131a6be7b2fa@redhat.com>
Date: Tue, 2 Sep 2025 10:03:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] mm: constify process_shares_mm() for improved
 const-correctness
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
 <20250901205021.3573313-6-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901205021.3573313-6-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 22:50, Max Kellermann wrote:
> This function only reads from the pointer arguments.
> 
> Local (loop) variables are also annotated with `const` to clarify that
> these will not be written to.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


