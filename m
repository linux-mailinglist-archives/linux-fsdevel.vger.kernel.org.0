Return-Path: <linux-fsdevel+bounces-59951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA73B3F7F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E46A167C6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB62E9EB2;
	Tue,  2 Sep 2025 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOtDZtiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172662E7F17
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800674; cv=none; b=PjHJdl8PkVTCR+mAky7CkLsnsCrkl+ofOgaTSMVnkfIYiaS5bUIHv2pEJpGjBuE4Ldgq2NbIAfzUZrPQ0z0ckQs2eHh5JyqhWRYDCCxjG3xgtan6oSwM5R7Tiimk7g32b5lyak5KONLsAeCEoydKVQKzbx9ZvHKY5jYc/RfkwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800674; c=relaxed/simple;
	bh=arfEnnFWdf6Tk7LHYUgPjFzHGxjCDtLm42H/zx3Bins=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bOzeARa/WeW1UTIRdA7F3Qbg5wQDXNyxkuNjtU6ihcJRNARI1rxv7FIDIRYO920lBgb2l9O6LgS6sRZSZ2AIpHs2PIvErUBUmU8hpK11EF9SYrClzy3SkFtmCGxBDcGMb6Su0u+rUAxby4saqujHMTa9NhSkabsE2dD5b7GFfac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOtDZtiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w4MWf5Tj42XyG4g8ZZ+nHXLySkFy5Z+t+SpLs9FN6OQ=;
	b=cOtDZtiHArld1qfZVKyzv7vcPqUS8Kkt3fQpoBUc6uG7GaDPwFtN/n2oytKB3cBwLKK9gC
	/S+6jMcz6RF1VBv1oE0aRE7bhUe8Sk09laxPL5mjc52gCluTLBoAI7WMBPzOCW8O+Bangf
	89RdQybBBcmNXKvTcsx9WvIyCG5WVik=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-BCH4WVSuPk6OCT1nYdfShw-1; Tue, 02 Sep 2025 04:11:09 -0400
X-MC-Unique: BCH4WVSuPk6OCT1nYdfShw-1
X-Mimecast-MFC-AGG-ID: BCH4WVSuPk6OCT1nYdfShw_1756800668
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b87609663so13636255e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 01:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800668; x=1757405468;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4MWf5Tj42XyG4g8ZZ+nHXLySkFy5Z+t+SpLs9FN6OQ=;
        b=Yhe/Ic9ZpwemizVkNslrxkWXenlA9t/dP0ubOtdsQF89x7cbgW2TeqJWe4cPy+hlTz
         2pKkSRNSasQrBEjfvz89joe9gt4xwZ6sS6NBenM/U1j12E/75agVp1TX/+Kkpxf9kME8
         dFbUbVq5Pqx3iZ+2SJsW8S1mgmVjnt4e3kjbxdeeT5/QyjbG6aed5HXlYHP9gQKzMmBt
         zDbGSgZML2sB0mcb6KlG+2+D9DP3UXqZoNtYUvaDlnerN+yr4cuIjn/LuyX8yyPr8Qx7
         kwY2KXipQMmLzRvUNTea47P5+4bhZGaJevm2px7+2e+JvzPyj4WtZPXFK3TKcXMB8gra
         aB4w==
X-Forwarded-Encrypted: i=1; AJvYcCWjgHIkJOIqAnJCjV2grkBdiW/FKMlB8pudmaOm4PeKJLh2G93I6Pl7mQ49fyKgGJbqUq1dMJ7HtgFYvL1F@vger.kernel.org
X-Gm-Message-State: AOJu0YxyK3FSG8EszK6yIO63m4xWM4g1rBdZig/4WSeqkaElt2H23gMA
	1a2ijH0tM26k/KYvRyz2DFp3QjKlWdqPzplndMnZ2vUhFAzbOoAf6O3kEZRITjcsx8oU48L3ZKi
	KQ7WslXXmD1xWHBu7noiufOou+tvvh6pUK+NvWZqLd8poHLOpWW9AoLUPmh71hN2Cq9o=
X-Gm-Gg: ASbGnctcTmCVLoqLTCMER9A2W57Y14a2U/vMiSm3HPM4SzAyFf8D6bwuHRyRhsEknnR
	9a84/BmuAkQNfgyVnNdS3cYf+kDV+pzDz+MmKt0SmuOHFxcM3wD8It+KWyjx6WetUCchlmMXlLK
	K9SfnrMrqgRMRTUdgEQqNkBpE/gMOiMhCjPDky7JBzMcFlR5PZt47I2kt5lm1of2KmG7YQu+YVM
	2OaMxMkyOoieXUopC8DXWmZgzbGaJYwQ5ae6Jkg57B8HskY7FXbocsCaB3bzsFPWwn2/k80iTWP
	Rq6BFkMe6WkVexEgmxPXcbNeonODec0ZnkgCGOj1DRO3jDtfOs2LstRS4cq13j+Vkm4Fj3LYBWe
	vyu2mbE63Ro7DjFxgGYwmTv9h4yvb56x5xA6ozYF+B6KqDIGKiGoTAkm9XZj51rDM8/U=
X-Received: by 2002:a05:600c:1e89:b0:45b:88c6:70a2 with SMTP id 5b1f17b1804b1-45b88c67360mr71590465e9.1.1756800668358;
        Tue, 02 Sep 2025 01:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1u/GPZRrAk5+4OF8Grl0TirFQTXJJs3FiBdxsp7971JurAJnmwDEqUWzkf0hTf7n/W9m6vg==
X-Received: by 2002:a05:600c:1e89:b0:45b:88c6:70a2 with SMTP id 5b1f17b1804b1-45b88c67360mr71589695e9.1.1756800667854;
        Tue, 02 Sep 2025 01:11:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b98c95c77sm10525715e9.7.2025.09.02.01.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:11:07 -0700 (PDT)
Message-ID: <12bb3414-2ca8-4384-80e5-81889f2bd35f@redhat.com>
Date: Tue, 2 Sep 2025 10:11:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/12] mm: constify highmem related functions for
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
 <20250901205021.3573313-13-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901205021.3573313-13-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 22:50, Max Kellermann wrote:
> Lots of functions in mm/highmem.c do not write to the given pointers
> and do not call functions that take non-const pointers and can
> therefore be constified.
> 
> This includes functions like kunmap() which might be implemented in a
> way that writes to the pointer (e.g. to update reference counters or
> mapping fields), but currently are not.
> 
> kmap() on the other hand cannot be made const because it calls
> set_page_address() which is non-const in some
> architectures/configurations.

Right, we store the address in page->virtual.

It's interesting that kumap() won't set that field to NULL. That seems 
to happen in flush_all_zero_pkmaps(). And we seem to flush during kmap() 
in case we have to empty slots.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


