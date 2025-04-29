Return-Path: <linux-fsdevel+bounces-47628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5396AAA1597
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A550E18856C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C92522BD;
	Tue, 29 Apr 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNsPN0q9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C172512FD
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947502; cv=none; b=VEu6VxTX9OIUUJCjA+4Az8M+R/d1CeyjLg3Yzi0/GELWjPJ286xeMbJLBPsYzMs0OaeIN5UiktRvFrnCU1GuDg9O2fY6p7dO/NZlpFG15hpJn5i4ifmb39vvonwFwswqVX/zyPaUYL2Qtpom8mdRfMLcySFRegrc2kpqLdiSLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947502; c=relaxed/simple;
	bh=6/2+cYiocmy0wyB5QejMKFLePah8s6a06xWG4IqQVKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjNr3umXhf3ikDocMR4zAoUEoum9+wRbJCWycaxSrk0SLp1st36hYcbzHQJZxU0Hb1zVk8iTskFtrZLquWHP5Nz/0kpxq3Kray45yPyHRZtLMPgCqtKjD/Ewr7Enaw8skirT4NU+FKeJmxuAWRRGHPA/WJuFsE+8Sh8UbLvE5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNsPN0q9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745947500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e/bLyArrocjzIsxdJa7jG1qfjWAEQUi1ZPYPngioU1o=;
	b=jNsPN0q98uyh/sS58X7tBpFLRgVS1U+O5GVAt6Rh6KzOX2XH3llgLm8yQ4o2LSO59MB96N
	DtTc3v3n39FbSrtXnnXdcojphRfmZ8ekryfrEWLXEjK9aZr7pZ7Aik1TE/PwltCh5nckf9
	/QotCZEMOdgZUmdVnXP3gTmupDttPa8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649--TAFF8CfNWKwi7RfLa2Lmg-1; Tue, 29 Apr 2025 13:24:32 -0400
X-MC-Unique: -TAFF8CfNWKwi7RfLa2Lmg-1
X-Mimecast-MFC-AGG-ID: -TAFF8CfNWKwi7RfLa2Lmg_1745947471
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912539665cso23748f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 10:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745947471; x=1746552271;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e/bLyArrocjzIsxdJa7jG1qfjWAEQUi1ZPYPngioU1o=;
        b=Ho6m7G+USfo4/SmUJ7DrQNP+Zcg+c3pmCoU+O1oGjdeRRXvB5jiMphKiEpUGtTz/iZ
         RedcWHy4p4G2+tTHP/L44bByl5wrdd9+C7NW3swvTDRDWeibFs/bTvRX2mjoDJuYTzeC
         OJQzh/WLnOzUq1CUDRJn0JtoTR0FIX/RHVwKV2z6rzV2oT8Ps8/yz7NWB8pBT/cTyudC
         7iHZRlX+/xdWhyzvQBRW8LVa6dX9wiHbDiiHkErGPUeqg0RbrJ0wJz4H/CtysAYdgkko
         nUR+gViPXy3jzEF9X+MFhmBwMu/IYoHDC3GYhJ12LvDno4wShPWDiGiLmtLGhck4EoP6
         gDUg==
X-Forwarded-Encrypted: i=1; AJvYcCUNyDjOuZSr3PwABE/YwC6KTj7OvbigfP8+7RtsHPN6Pi49FR8fJ5SwQ/MVuVLswuyeSswoAVwny9dE1amk@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4i2BbhNvt65I3wD8HBgZpQhUug5v61uz0A+lnP49q98Gr+CQ
	+p+n43x/h+2xK8VFBCIX801MQu8hZRbPU1gHifGFk7qkSGItIIpFHDizyeAT+xdDcrahjZEekp8
	igg8vQhX+GxRlYbAak4H8LHPtmxWNhv2cQ246lRdcRwOgepnFZaTfouQuaiao7p0=
X-Gm-Gg: ASbGncuDnPdo0anuIX2vk0zZX0v/jTGUsV/dpiiQMOzV0SjN47w7ow808pyqA4m1snh
	ToqgQeAvPttwoVtCfm0JMF6CAjnK3fMNyUKsqIDZIegKCml8vgPOkKi6ZHB3TqkD7kdBon/SxyL
	50hMeO45Cohj83VopdPJ39sg1b/JPUASTMGawmxJyScUKf16UdfUU6Kr/XdXUCR/RRzeD+39ZUt
	2LDvccos+5CWOCR5ieDOgGi00Etdlr5QZvzzAX3FQdQDOhW5K0ruh/MK0/yInHWg2BAho/Vnjdp
	dsvLDs2mPv9YTZ1Q0cKwCo5rKUhjmJHmkm9vureZXUxmp8J3egQFY6bGkFXHcYNFSeCBRHccEQD
	+nbjeG0iMIIHqWwBoAjDC5J+/WG6CugMBkcKxfl8=
X-Received: by 2002:a05:6000:144f:b0:3a0:88b8:276 with SMTP id ffacd0b85a97d-3a08a501c34mr3475555f8f.3.1745947471508;
        Tue, 29 Apr 2025 10:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE7ui2XecAp7z+5YQCQ/G12l/zKaGk8AEgJ6wB0Jn+XqH6LadxEqe+Pn4apy1YfTj5fBzHZA==
X-Received: by 2002:a05:6000:144f:b0:3a0:88b8:276 with SMTP id ffacd0b85a97d-3a08a501c34mr3475529f8f.3.1745947471138;
        Tue, 29 Apr 2025 10:24:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:fa00:8909:2d07:8909:6a5a? (p200300cbc73bfa0089092d0789096a5a.dip0.t-ipconnect.de. [2003:cb:c73b:fa00:8909:2d07:8909:6a5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2ac27dsm197171435e9.22.2025.04.29.10.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 10:24:30 -0700 (PDT)
Message-ID: <905a7c96-a162-4dbc-8592-8d040b398cb0@redhat.com>
Date: Tue, 29 Apr 2025 19:24:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.04.25 17:28, Lorenzo Stoakes wrote:
> Right now these are performed in kernel/fork.c which is odd and a violation
> of separation of concerns, as well as preventing us from integrating this
> and related logic into userland VMA testing going forward, and perhaps more
> importantly - enabling us to, in a subsequent commit, make VMA
> allocation/freeing a purely internal mm operation.
> 
> There is a fly in the ointment - nommu - mmap.c is not compiled if
> CONFIG_MMU not set, and neither is vma.c.
> 
> To square the circle, let's add a new file - vma_init.c. This will be
> compiled for both CONFIG_MMU and nommu builds, and will also form part of
> the VMA userland testing.
> 
> This allows us to de-duplicate code, while maintaining separation of
> concerns and the ability for us to userland test this logic.
> 
> Update the VMA userland tests accordingly, additionally adding a
> detach_free_vma() helper function to correctly detach VMAs before freeing
> them in test code, as this change was triggering the assert for this.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


