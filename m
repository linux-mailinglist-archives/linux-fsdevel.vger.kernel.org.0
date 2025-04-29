Return-Path: <linux-fsdevel+bounces-47626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68614AA159D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6173C9873B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127242528E9;
	Tue, 29 Apr 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enhBOVRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E872528E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947356; cv=none; b=X3RdbJ5XozO40s/QSJDfRLptS4E8lN3uuBNZFH+lIwug9xgmz9JAzjqvI0d++Xb0NM0mkAqpbX+O6UUEZ8HnEKlkQPF2NlAwwhEGWy9jfwvB7pwIcT2pdhurefdpp9Z5lXmXiVVCXEdkcLAkUHl/vpXZcSAiTEEOlZgWNdLkczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947356; c=relaxed/simple;
	bh=L4BNnkRR9uqLDG/4D/80t5HMleTkeLj0BZ8qMZ2TLIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hzb+45fWV3HYhZCLjHuCapps1ZvsoWUyVG4fUCFcE3QLS+kNQhrduQ/yGq0ZrUPn5vllbWimFkfVKsFTpo2jG+WDewptWldIRLSz9KHszBMu1mQRBoMGlfL3yu9o+dlzTUNss967/1G73zHpuWxUFaMVTaFdeklGmYDIKMsXfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=enhBOVRA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745947353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qAfYTOYo0st9O8DtaYFErlvF+Z0seeV68r2hFxsaUz4=;
	b=enhBOVRAWUuVJBFVyrt4xbcEuR/UeXaz12X6XxaZ1jX6VBs5zkZbQm0N0yPUbEE08Y0+YV
	oM+ubh8GzTOZcXa4VJCYKr1n/xVQ0aHkoBAzUT5GKlpVyPMInqWShbw9+e5ZEWvCDXHo/d
	RFFUITkeaeEk029x3YWCttFzGBqgAlc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-a-I9IgmpN9esCkv6KX-Wkg-1; Tue, 29 Apr 2025 13:22:32 -0400
X-MC-Unique: a-I9IgmpN9esCkv6KX-Wkg-1
X-Mimecast-MFC-AGG-ID: a-I9IgmpN9esCkv6KX-Wkg_1745947351
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso36392295e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 10:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745947351; x=1746552151;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qAfYTOYo0st9O8DtaYFErlvF+Z0seeV68r2hFxsaUz4=;
        b=hRITgDgQQASeu4yQYCF+nXCAVekByfaUbPfGs214DOi0fGSj2CayNtEZORdkQcpOk1
         hPiidvDMLYHAuC5uYDfb817wIytBeMK/L6rqFP/5nBHQ3fOdriWHK23XENt0G3AY9Trl
         eeEyoxl3A6GKpDhb/w4f4lliPunzeEEuLdj7lKMRYWMSw1tj5I9088nEyum3en+BkkIZ
         CseCs9I4FsJRPh2Uc85lFin5nCY5k1X+RKdQg45yOkPmXYUOQ4sXJXd84aAxnovc93qw
         BlYreiokdULVwQi8ZGY03v/ryPeQl3KVK4Ww7aKnAflvKgLQ4HNZzYWy/9uZmoqtOlKm
         sgmg==
X-Forwarded-Encrypted: i=1; AJvYcCWl6bqdO7ytjJ4vXcD+tj+/Dx/wt8yfnyFWpUarpnhWKMmqE1k6Vs5wkKdTcUSc9tu7GrD7JaxaNIhH4egs@vger.kernel.org
X-Gm-Message-State: AOJu0YzlsBtbC8oiBqOAYaao6CJNxUyw+BgO3Xi8x9dUAdb2vRFBsrrV
	pr92w024RhOkarfkz210pYHEjyA10R3eCf/XH9VIuD7TWR8sO1VcGh2Cyig2hcd/yJdSGOs8oqm
	9C2m6v6mmLQqccgPQjE0jzvFZ9qcwUsAsWO01JOMASPjmLNNcE1UBoqV1htiY/HM=
X-Gm-Gg: ASbGncsVSueV2FmVLpkgmN1GsiB2kRnxg1nqRFakLX/5+Ery0w88fi2w/KOeYD8fgTH
	uj/E32dwEREvXZuK+Eogkit5dMxFKGkduXEgcreEatholmkD8zDzrFbuYlxKd3+6lx4VymuyNPy
	TlM79IXLFZzlqvPzfXXn8bMcg3GBhaBqRxCGY19hi6hx7rDwFNNcGq9dR/uaU5P72iACw60C0dS
	7g9o4401xWdytaAQJHdyW6DWaCDd6UMwY35n/lXyHUIBbc5Qdwq539ehic6gtbt57mQ0to3LQJL
	Nfp3pnTTJyuv25ZKWJ9KlNq6LGjBCGCbmU22/rhg77fdXw7Jjm/OnoTfdHJ7ph8W5rInxo849mv
	evS3VXxWHcNfoMRXM7oVEfHsKSxJBrJhGykcsDsM=
X-Received: by 2002:a05:600c:3b85:b0:43b:cb12:ba6d with SMTP id 5b1f17b1804b1-441b1f3066amr1432735e9.3.1745947351115;
        Tue, 29 Apr 2025 10:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx2KVcawLRxhiuq/u0/yCcC6YZYsJNwwfrRs66PSlGvPfzsc1e2FbhPXSFRaIdwpXkKF1vWw==
X-Received: by 2002:a05:600c:3b85:b0:43b:cb12:ba6d with SMTP id 5b1f17b1804b1-441b1f3066amr1432485e9.3.1745947350715;
        Tue, 29 Apr 2025 10:22:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:fa00:8909:2d07:8909:6a5a? (p200300cbc73bfa0089092d0789096a5a.dip0.t-ipconnect.de. [2003:cb:c73b:fa00:8909:2d07:8909:6a5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2e0414sm199915345e9.40.2025.04.29.10.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 10:22:30 -0700 (PDT)
Message-ID: <b6b68904-ca4b-48d9-b9e6-c65db3ae7f69@redhat.com>
Date: Tue, 29 Apr 2025 19:22:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: establish mm/vma_exec.c for shared exec/mm VMA
 functionality
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
 <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.04.25 17:28, Lorenzo Stoakes wrote:
> There is functionality that overlaps the exec and memory mapping
> subsystems. While it properly belongs in mm, it is important that exec
> maintainers maintain oversight of this functionality correctly.
> 
> We can establish both goals by adding a new mm/vma_exec.c file which
> contains these 'glue' functions, and have fs/exec.c import them.
> 
> As a part of this change, to ensure that proper oversight is achieved, add
> the file to both the MEMORY MAPPING and EXEC & BINFMT API, ELF sections.
> 
> scripts/get_maintainer.pl can correctly handle files in multiple entries
> and this neatly handles the cross-over.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


