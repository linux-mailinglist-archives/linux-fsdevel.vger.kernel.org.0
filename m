Return-Path: <linux-fsdevel+bounces-65723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1EFC0F0A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6283B109D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B9B433C4;
	Mon, 27 Oct 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OONvCf+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAC29AAE3
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579850; cv=none; b=c6bh/0DkxXcydohOFmcooucG18MB6Q1yPa5cjYC5T028lohqfLxCKbsLYas0ggfUn6ilfjqIkC6yh5TlogmPDyFUvykd6jPhDYgmzE6X7L0DLeVvnA5pJwTdTzoS1nB3fuxVFfTOYvhrHtLQFEd0SUzKMZ8NbMJKhF3C/Lptrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579850; c=relaxed/simple;
	bh=LWsVwGwjYwyqpQ9o3e6Uk+BPg4ajdq/5//0TO+fMTT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pql4dN+bDLk/3xtsuWGNyFipyeXNU737r2Hacyf1RwCpfCvox+sexibNmywedm4cBQwZ++8fmImWg7VnbO71bw1F6ZitzSYE8rK3yXDRuUEfRvN1Gol7nfBArcz9reQ/SeEV3qU+yxLFi35HorgAW8zf84JelJc+nt5ZFeavzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OONvCf+o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=adOAQTvoac18lZ9/wdsLg9tnRtOabe7VU03ECgTR420=;
	b=OONvCf+omaS0XEAdlReBiSeu+VLJjIdqWTxVczkMlS8WyNUhCnlsHXd6KTP8/sst4Gye9n
	utEWwz21kAY+b9BqFptYldDJMP6oUk8G9ibSZ9x7KvRe3h2knSAgxC9Z77DyrpQXMO9ooM
	oCb6j+ML8uzcAtdmoiC59OXwM+Rbs7U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-uUNd6oxBN6ag2XXhC7VjRA-1; Mon, 27 Oct 2025 11:44:03 -0400
X-MC-Unique: uUNd6oxBN6ag2XXhC7VjRA-1
X-Mimecast-MFC-AGG-ID: uUNd6oxBN6ag2XXhC7VjRA_1761579842
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471001b980eso29891235e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579842; x=1762184642;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adOAQTvoac18lZ9/wdsLg9tnRtOabe7VU03ECgTR420=;
        b=XGyi8N5UWbfLXyfiS8/KkviC8O3gOYz9ckzcqhlAkR/RAtRIT504eaWTzmL8+XRtHg
         f8W/K8LKpffVBvUrk43mhEcmmKry/K6cNNqHHsehsd1oJkO553M229BatIUQxrYYl65m
         I0LfJCPuQY3mPZJfkTm6y8OIb2mZ7EEqVxUAr7PraNz7CQcwxnmgTwSaOTFbvIU+jJKw
         2KyG/AKY15r+FQ3ucYk8YwPMOoq1v+8idoRuv5f5T2FXHW9HSR4ZeTQt2I2uaOEqNNUn
         onNPbNZhmfiwJ51UC/eKhrC4VkAasy/p+LCmSjFvSzOuyQtiDThm97M61FgtBDxctm8n
         /6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVUqbqHoSxAoLBCTC5yB+J0MBRoIwVAikZeq5sU/KqBpBCsifJxBSrgf+MOhm0oObrc3fbm6aVJnFS2FPe2@vger.kernel.org
X-Gm-Message-State: AOJu0YwTVTPCQryLxBdrwzWQgA+bMdf3KgeKLvQZViLhyTOqDW73eNZM
	l8R+sCHX9yL+BFP8a65pSsXbyFhFVb442scIAZrBjDItRoIg5M3x/2VvbgAIVEYNHQ/QXrKpumv
	UEXoIXuA47BOmBR69at+w1xY/iKNMjeSYWu+IOP/t4oN+RaSGmamifeWbCV65SG5sGag=
X-Gm-Gg: ASbGncusr+lbKnZ2f3fAH1kdSLLUU/+1LTCEG+D6KjkFacMOs5lcRnqsLKSTHdyHMmm
	A8cXctYNLdmVdDBdR12UtdD7z4Ab5F3gPyMxT91dWQgP/vifLA7PMj4N1yXTxiK0IdJ+l3zvCaT
	H/o+9PicRwBn3uMv27LxEuFTXXdoanCzTeL1KS9E5dgUkxF36SpgKlZV06ocqgPQoW3+gb1IHD1
	cVCxJeCvZ4AcO39W3oIVGzBShRS7ai7F9Ze1+EYdEQCYo+jsCECrgGxv+RRv5j3xX9Ej9PEQeMO
	Otaj8wx66H+9s0ZU/250sIq/IeSsIZZmnsxM+x8YJICOZF5UcDvWRUiMQOLivlDn3fn75pVaX/z
	znBbqOWsNQdvmB7nAOvruldmZbVIt8OLzZigrPQxz7DXrAVtvcdY8TppG6bfDUH55MslazQtlJu
	GozR/MNv+UBj8Q212fA9sQCRsJN5U=
X-Received: by 2002:a05:600c:5487:b0:475:de68:3c28 with SMTP id 5b1f17b1804b1-47717def760mr1347195e9.8.1761579841629;
        Mon, 27 Oct 2025 08:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiDtRwUHjEVIAY8aM164h+qxfVydqUkwRltLaXAZRqa3l9fHnulYdgUNkImXXiSGhlxa52kQ==
X-Received: by 2002:a05:600c:5487:b0:475:de68:3c28 with SMTP id 5b1f17b1804b1-47717def760mr1346995e9.8.1761579841208;
        Mon, 27 Oct 2025 08:44:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddcfd598sm70070705e9.3.2025.10.27.08.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:44:00 -0700 (PDT)
Message-ID: <608c8166-b6c4-4187-abc4-9e1f0d31f107@redhat.com>
Date: Mon, 27 Oct 2025 16:43:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: Use folio_next_pos()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-11-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251024170822.1427218-11-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.25 19:08, Matthew Wilcox (Oracle) wrote:
> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


