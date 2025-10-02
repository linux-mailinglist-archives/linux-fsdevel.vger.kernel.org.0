Return-Path: <linux-fsdevel+bounces-63212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2912BB2BF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 09:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526CA1C4F17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 07:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE652D1F4E;
	Thu,  2 Oct 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/r4OwOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4F2D1905
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391701; cv=none; b=Gpy6kMjqeiLGn5PXIQk7j8pKGJpI1jIFJhpSDM5bzm21nRXoY5EuWOcyPDVOpSsNm80wyYNqLt1sdpvfwoXHf1S3Wz2WAS7OfsqyqRr9n8aTPagrOuWSYAOPB/RF/Ul21mxcFoW+zkM1ZgZ6195xrajIPeaPkFL9RJYZlX1B/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391701; c=relaxed/simple;
	bh=nb9SLyTaxwx10+zZr/x8CleDAMeEWEvApjntTON8H7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJwLn3t1QezVU/6G3grUuahZX9wo4VAIWsvM86W2f7+tS42Zv8JEVRhrH816h73J69+VLa61hwfC4weWxveKnQCe4Dz4gbIxYR28P5Q66z0aiulfmU30yy/41sOy02KRLKB3hN5gK7sGxgDb2177fKU2Kt5m0QTJJy0/cRi7inM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/r4OwOe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759391698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vikbvMujRxH5+j8MHPapMlTJNADuVwLSxX8Ctdq/Fn4=;
	b=Z/r4OwOess7EcSQJql7uoMPLtlo+QbxeRHfhws+qgdu/kIvmHJg6cFUR4Rb91WgpojeuSE
	FTxf67wBFXfdEI2KwEvYtZM8DbMs9/sAq4VjQfbJ5hRt79RBGbSVdSCv9Fs91D9ONNJ8k5
	kXxkyLHmxOdhDHDKrKYZLC63HzT6bfE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-JMdkCHWWN_yiiMtSi4jfog-1; Thu, 02 Oct 2025 03:54:57 -0400
X-MC-Unique: JMdkCHWWN_yiiMtSi4jfog-1
X-Mimecast-MFC-AGG-ID: JMdkCHWWN_yiiMtSi4jfog_1759391696
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so269209f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 00:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759391696; x=1759996496;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vikbvMujRxH5+j8MHPapMlTJNADuVwLSxX8Ctdq/Fn4=;
        b=tKQ3VlupKJqNRudWHg1C5m5bD9rqcEsYDt+xSzAF1cEAiX3pvfU8kOwTLdvoyDW46d
         EpToqIhuEyj5FTmbJAU32GMsqedYD1Mw7DmgmE4JGsxsrYYoihzAhLHSHX02CP/uf2VG
         c7FtN/VLB/gAzqBNfSDgGrhBcRk/gOPUITs7XzZEcWzx6ges8cp6NZhTDrRs+88gXX/N
         ys1QslpvyArwlYNBGlCxBBQ/WgqlL9mcehBCPvtynGBl9gLpHZSfHZaWzKWrPR4sXAV6
         tLJKRoEV+JSUDB/FRDgIeotcW9jtKHBT9yU6nLapbqMV+jfBKpVFvxbqLghpwBm1MQr1
         7+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXx12lIbvG+Wp6NaPYMiZ54O3blMGEb1gV5UahMC1IbYPOEu2VllsbL+Gm6VBbtUYY6oIgRQTrKWM+LUaOu@vger.kernel.org
X-Gm-Message-State: AOJu0YzDA80ZV/Dm/ymT6F7JSE7/TGtyu6RCjDbRvbWHtqkjMdPdM0Jo
	d11TZGZvxU+T7qaPRwWpn8UX5s6vlY5RdEcs7PAQL5Wq1LlSHRm9TtNoSqTXPdY6YzOzrzQl7DW
	AZbjrzUxmAd3wnYE8iGJAi1zREMInKVFIBs0qcoS+XpWikmANDDCi1BpBZsmyTPeJ356n6WU4Yg
	U=
X-Gm-Gg: ASbGnctYqcZQYEqqIZOaTCSDzVzp072/lbfOcZiX3DkdiYnrroZHMCG6qHTTgBWACxk
	0rI8/ozkxAmS5lYaN/ngfuZckvfzQJdZsXQptEWwemliYz6NWWUdA/9cf3kLcdhIS/EvDhucG4s
	qn7W3oTJSu2oZejsB8ZuzakhtRXPanJYvKG7M+7OYvq9xyqBcA+klNrxEwlc39cHcRqZx9Ipowm
	18OFFccgd+EmyFM7wzQfhZuq/g5kaKrjW78Yr1ZZRc95wPfkFXxZJGbjPNeUNMWk6HfLbf6oRrW
	bRcvtlZ5oK3TOFbJ4h3snyGwyFsAhPFJrGLMEBM7B09LqwqRIELyjM2wTz5qgvl1D2nXc4Y9CWF
	NrU5hw+is
X-Received: by 2002:a05:6000:420a:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-425577f1b33mr4696228f8f.14.1759391696270;
        Thu, 02 Oct 2025 00:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4ucs9qEAt4KkjYeplUmqpl78kNlA5Io8C5XuP/RQbkK+tZkwKR1bmiFsNk+oZQa0IXEyYPA==
X-Received: by 2002:a05:6000:420a:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-425577f1b33mr4696203f8f.14.1759391695720;
        Thu, 02 Oct 2025 00:54:55 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4b71sm2383313f8f.57.2025.10.02.00.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:54:55 -0700 (PDT)
Message-ID: <7b7028f7-8225-475f-bf74-a0e6d3fa90e7@redhat.com>
Date: Thu, 2 Oct 2025 09:54:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: redefine VM_* flag constants with BIT()
To: Jakub Acs <acsjakub@amazon.de>, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Peter Xu <peterx@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251002075202.11306-1-acsjakub@amazon.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251002075202.11306-1-acsjakub@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.10.25 09:52, Jakub Acs wrote:
> Make VM_* flag constant definitions consistent - unify all to use BIT()
> macro.
> 
> We have previously changed VM_MERGEABLE in a separate bugfix. This is a
> follow-up to make all the VM_* flag constant definitions consistent, as
> suggested by David in [1].
> 
> [1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/
> 
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xu Xin <xu.xin16@zte.com.cn>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---

LGTM now, thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


