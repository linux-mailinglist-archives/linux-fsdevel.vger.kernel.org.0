Return-Path: <linux-fsdevel+bounces-21413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5E903951
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F0EB21CB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260017A906;
	Tue, 11 Jun 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuJJpmZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D30178CF1
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103096; cv=none; b=L8mvZciJOBTS2IHWI7JomzymniOZDFM4XMc25HlDB5aImz+hsVe+Ey2R7EnUzJDPZsGy1S4xymb0mEpy99QeHH3PY9np+S5wyo80JmftyTnHZMcBCUDfL+Lb8Z+HUDwF6FQ/ttQa7bolqynHAiBe2LbRCcnIVeDaux8gMVhJjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103096; c=relaxed/simple;
	bh=5jokJu+77cTy9PlFn2+XS0YSs6Y+O/ThgQSZEKuYE/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9jr7Ovij0MSGJFMy/OKqm6Sg6kJrixeQmfp9WCSa+EdT0xO+z25AG/hLccC0gRMJaBpZqTPc26jW4v5Cm4PbTPMmkUp65zV19H8CJVzVq0PPEspSOrMiZnLlOAQJQL4M9kK2HRmjLR6h7tI63B7AbxVN7nUuouAmdH0AnoI+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuJJpmZ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718103094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xJzyOstj03OACQiOW3AK8lHNiLSnxNoCbEIihZoOnH0=;
	b=XuJJpmZ/0XmtmucD2TltVwqnHwkXKQORnH8UqoKp6Cw74fkQLKgR6stUaksvkdQRz35bY1
	uXiJjEUoEevIjoOKHQwlHAlzCtMh58hdp37uMPSbOCKbe1YrHb3mHJc9W1a0k0cc+i7ORY
	TJK/QAJn9x+wTePO4jzU8akdQvWRE2M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-tn8tWhBKOpCGSnO2MFp30A-1; Tue, 11 Jun 2024 06:51:31 -0400
X-MC-Unique: tn8tWhBKOpCGSnO2MFp30A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ea892f8441so7015991fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 03:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103090; x=1718707890;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xJzyOstj03OACQiOW3AK8lHNiLSnxNoCbEIihZoOnH0=;
        b=B7yqIVCePaqOhEEUY1aAyCqmvvk+s1aAsC4WR+i330ZO63onUJlaRNcleqoQwyLT3e
         owmxrsqW7GN7FzES9UaqMvq1gXoPa6t84hqYRD1Pm0WcBVJZ6vhaZoagFex82/ezEQ1S
         0PZLpxnlKaNXoVUq8hvdK9ICivija/nTWTj1xKI8zolT3uYYsOy4wcY4bYfmZ+5kC1gC
         AjHpTT1whB7yrDyIg+FY5fCaiUsyw7Vq+3BJ3qnsODDRc97HvqyMV2YsdkOT6VNRsjb7
         nZfgsAv9sqdvuvX/IWG9hj+50ABo3EEGKDaC6SD3buZNC8kwoXJZM0OPjFPBlVD0zPsI
         WkFg==
X-Forwarded-Encrypted: i=1; AJvYcCWbG39V2zUm6qhe6cWlxy34iv0a25MVmwI60iK0/KUQBNHFcmttg/6uNOPiib9jsbq4Ajv1IsriQfEV+DzJykrNf+ixqNs0EPyuJMa+Lw==
X-Gm-Message-State: AOJu0YzGwIgGnji0wyrTZj6z7PEsnoyTdPhGEIUxoGd2ylATpzL+ebIn
	RLDp5m3Lc/F9QVNcCHjzmVRn+06n/B92554GWkU8iIfFqHE3R+Vqyi6dJZ77kRHkdxwDbYsgewd
	o/7TBtIqJRz+gk/Wa4jothz6yHB6rqmSH9xZ3GvS9spSeT09b/p6sTeAI7zVKNRA=
X-Received: by 2002:a2e:968e:0:b0:2ea:eb13:daca with SMTP id 38308e7fff4ca-2eaeb13dc4bmr56084741fa.47.1718103089992;
        Tue, 11 Jun 2024 03:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI8M5WVGO1DoLzk1IMAmgEjhphAqPWfsq/oAwYotOI1b9XdZDhhbZgyW9zoL+yWdPtjk0DYA==
X-Received: by 2002:a2e:968e:0:b0:2ea:eb13:daca with SMTP id 38308e7fff4ca-2eaeb13dc4bmr56084601fa.47.1718103089490;
        Tue, 11 Jun 2024 03:51:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1b1cc3e6sm7980702f8f.34.2024.06.11.03.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 03:51:25 -0700 (PDT)
Message-ID: <48d71064-b9a4-49dd-b933-e9891982e1c2@redhat.com>
Date: Tue, 11 Jun 2024 12:51:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] fs/proc/task_mmu: don't indicate PM_MMAP_EXCLUSIVE
 without PM_PRESENT
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
References: <20240607122357.115423-1-david@redhat.com>
 <20240607122357.115423-3-david@redhat.com>
 <ZmaDSQZlAl7Jb-wi@localhost.localdomain>
 <Zmf5NdeKewGEhYLI@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zmf5NdeKewGEhYLI@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 09:13, Oscar Salvador wrote:
> On Mon, Jun 10, 2024 at 06:38:33AM +0200, Oscar Salvador wrote:
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Uh, I spaced out here, sorry.
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

:)

Thanks!

-- 
Cheers,

David / dhildenb


