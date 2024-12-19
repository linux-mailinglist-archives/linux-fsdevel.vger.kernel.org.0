Return-Path: <linux-fsdevel+bounces-37794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E93AB9F7BF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 14:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF137A0587
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 13:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52E838DFC;
	Thu, 19 Dec 2024 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5lOBKa9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5B801
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734613512; cv=none; b=ARfCp9uy6eefcsUGYKwyOr8SiashRp+xmCsvELViO3SH9hcKvlEF+QmMPLaGjdmcUay5PLohri9ezJpCEX3NbRKfSvU0lC3HC8/akM9UUrLgvEMerISTNzwtPZoKFb0raTlukwfNNuyWfWpXjE/oFU6QjmW+uBBl+8bWdxzflhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734613512; c=relaxed/simple;
	bh=r1jCidUp+cvRhjuC2J6eG7t33CTSGGM8hB3Cq3HHWm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AR6D2GKON8YMTa+cCMOXd60eSczKJ0z8wFXyieYHN3R8y0J0s0NKIlFsIo4yFMyzCQRuICDwUEu2zswLmVzwsjLmfmW6iJsQxUkdodGo7bCd5UxgTR6GLpMNWnGa/zEul/mKkb1dM+KUqAaCpoBvTgQDEjXiAG0vMViFkO1FxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5lOBKa9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734613509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T5ScgxkNuZ1ybwXQme4UGRREuWyyWaRIhTG+vUuR3Xc=;
	b=U5lOBKa9m1OLePCruvB8yhAd2wpW0U+gT2kL7ctUtTT/zgiJHlwyiiIqdzX6NvUPIWJngK
	ZThgdFilHkFSarIQaCeDU4q4o7FK8h7wIYuPKUR2nnLt/AKG9U1rp3OL0Vj8yUkH66Rfx3
	p8Iq4873WqCFbpRbGqcETjCPTYGTVso=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-AM-WnhsAMnGnQqrAc0tF8Q-1; Thu, 19 Dec 2024 08:05:08 -0500
X-MC-Unique: AM-WnhsAMnGnQqrAc0tF8Q-1
X-Mimecast-MFC-AGG-ID: AM-WnhsAMnGnQqrAc0tF8Q
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385ed79291eso996870f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 05:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734613507; x=1735218307;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T5ScgxkNuZ1ybwXQme4UGRREuWyyWaRIhTG+vUuR3Xc=;
        b=pY7iwQoUqeRE9CNgi90/aW1o7A9ERuUM5F0rXykDCqQxzOQokzLERVproIkyySJBH2
         g/AHZNmn5Vbvq5BvD+SKFEGps+lWW5lP0Y8TVGq2/FTuRLiHEoonh2hpqxaNumCsD81T
         RwILf4kxYf1gJGZHoD8giHbDvWvqdEaMvpgGnUAgpbthGexkntm4oTzm9+0LitNqr7IW
         rNyU5mKBGKsRR22zvhsK2dUbSEM+1TcWIAY+Yf5d9p3uVRmLddh/aYnnMq392F26aeHy
         9E1iNnrGHhFXDfo/MRKPuZOOekvp++c3CGO0CKMabSzG8v+T6q2IRp2d+I335CVYhfZP
         3Daw==
X-Forwarded-Encrypted: i=1; AJvYcCUExxeu5CsZMBwLtNsy+S2m8mYdSvr19HIgVu+n3sNm33DtXYqTxNM1m/lTkiywan3BlFUwpoMMN7/lz7ss@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GZWhgmfLZX2SrQTlCLJC8rePq30xuaROaebcYr/eIZDlo8Gt
	TIMc72qO3sZOxnazB3Uj2WZKZHIBs+4SucwCFTbGphjTKR++G2ZclEACbdyRb9GRcCnavwIyQb3
	DmqwBGZJIAwJ4VTeu1VSr8QTHgO2UYtCDrVwff+IcGuTojrISW54ihnaV8YxKn4k=
X-Gm-Gg: ASbGncvktuQktUXndiJUYDSCEISvjRyRnFr8VwbtKgjzPM3gx9ZwnKq7+7xI35LwjAI
	FmjJ5+10RyaWtSbAd1NwVWzkCP5O//dX1eellG36U0UnHaRY7PNJdcu3hrtKomvX/LFNTnLxT9K
	0G35osn/Kgh/stxt+91BpwvyTzNuN4R2AnsJv6gFOZa62gZ9FkKMZxBrmyDlTdGBv41E+dxWvQg
	/iYmMhxZ58TgNesUyC/VgQlaOdgCgOhfjmvQsuxyM7NHy3Osr+Bwi0TyFz01qvu3erV7vLNyKb7
	Y574+3MQmt1UNreqZS4hqPh+5RJAVUiAvryvsdcPeLOtk+cduNQzLtuCPwZSnUbqhoefEm2rvul
	gghQwRA==
X-Received: by 2002:a05:6000:1863:b0:386:3bde:9849 with SMTP id ffacd0b85a97d-38a1a20f407mr2696274f8f.12.1734613507023;
        Thu, 19 Dec 2024 05:05:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZxd5/mfBE4XH/PDfC5RZrYtRzsU+3d1fLOzHQbPbIWfr4ljQziLuWO40YIOgGa7NxCDTgAg==
X-Received: by 2002:a05:6000:1863:b0:386:3bde:9849 with SMTP id ffacd0b85a97d-38a1a20f407mr2696219f8f.12.1734613506515;
        Thu, 19 Dec 2024 05:05:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c639sm17416435e9.31.2024.12.19.05.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 05:05:05 -0800 (PST)
Message-ID: <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
Date: Thu, 19 Dec 2024 14:05:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev, jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241122232359.429647-5-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.11.24 00:23, Joanne Koong wrote:
> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
> writeback may take an indeterminate amount of time to complete, and
> waits may get stuck.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>   mm/migrate.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index df91248755e4..fe73284e5246 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>   		 */
>   		switch (mode) {
>   		case MIGRATE_SYNC:
> -			break;
> +			if (!src->mapping ||
> +			    !mapping_writeback_indeterminate(src->mapping))
> +				break;
> +			fallthrough;
>   		default:
>   			rc = -EBUSY;
>   			goto out;

Ehm, doesn't this mean that any fuse user can essentially completely 
block CMA allocations, memory compaction, memory hotunplug, memory 
poisoning... ?!

That sounds very bad.

-- 
Cheers,

David / dhildenb


