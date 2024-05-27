Return-Path: <linux-fsdevel+bounces-20207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3765A8CFA2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 09:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8B91F21A52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 07:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367981BC3C;
	Mon, 27 May 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RogVgb9W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296461F5FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795216; cv=none; b=qjse1JMh9AD03BM5FJXs5jtbq8cgnXwB4qL7hc5Qd31D19vbMMNtXDg/thBPPGuJ5usI8LftEBSItoBj6d6v4Tb3qSoUNsI17lynkRA7rhDuduxwZtrWeENkNfm5qwoDIoeAT/+DKr0NUKv0tjCe1qnFHoS25N7y8zrMtiWe+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795216; c=relaxed/simple;
	bh=uYRLEMYbUp3EeSjC/NuDVxpwnZ8p8U46ukUXSSR7wdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYvemYep7D9rdy8sRfTcfPqlnmwzCy4sT27h8aLHps1ElnyZxV/CyAGlQHlf6R+U3X/70DtztgV146sDhSXDc4xLhs2YSXyGO60ywQdz7wRR8AtucuGhOkZFG4iainf+zGG8bSlaNsh8ji0CPXszxRx/TRnKmfPX6BaWoPYoJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RogVgb9W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716795214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Stx8nsYupK1retZeodvUwtce4GNZK7VWKmIXj47JHKk=;
	b=RogVgb9WYNhwS5CaJ1RW10FJlzqu1k+oEHBg4FfqUM5pSJ5g94LxUE+d0sW6jfRE8pCUGa
	eKtdCFw79SbiQxq2xBj6KrHF75pIpASA6uYJjXCV2D5nliDxhmVTPvcQFosTGg2DHCLnUV
	gPtowzfWfTIdLb33SWEvZW0gGVvZY24=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Cuu8hxTDMMiDK2e4e97Wzg-1; Mon, 27 May 2024 03:33:32 -0400
X-MC-Unique: Cuu8hxTDMMiDK2e4e97Wzg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-794aeada1faso336439685a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 00:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795212; x=1717400012;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Stx8nsYupK1retZeodvUwtce4GNZK7VWKmIXj47JHKk=;
        b=i3K6LTzySeSaUa+Iohp4iB+FwGxyDQIGEX61ucDERmKHYlbVI5bp5EoLBb/qeD7BWV
         xk7W3dRo0ykUks7gQ/k6+pI5DI4OwThqRtEy2t/pv9q55Wivab96hzcL+UOuoXwiyszZ
         gInr5RrQBQinrZmkPYZY0gAAWsEpuSIhY+rN1pr+yEuqeKRZLxXJd6Q7KZKNOCTWq+XO
         uDq9KTUpsOWIHaSXnzdo1gK/xiUsf8qb0eHqLMK0m/Vt/LgETz237S36Rsqa4Sx+PGGD
         1kj0CFX5VALAIl0gAdO72ZxQ9JbmfI5F+oCwjkKfm+QONaQjDqAKo/oxUzYj2ghL3cxW
         o8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSZY/3LsthYWI9l4O27+0fdRkUAjadoUUM1LeVJA8hxU0F7xT3Zfh0WGir3WK+VM+PjhPNOM1+H+6lsmC+R5afXMfBoZzdGNVRBi4q7A==
X-Gm-Message-State: AOJu0Yx7Tqwo5+2KnlJ1KwkbFu632RmhypZynkgH+0oElwIqy25u9Zn9
	RiLrmGTi0nABY4SBqIH4Ua4V7QpzT/KhmQ33GayjZI/hJBTQ7mV1O40OaJl/AEstZSUxUzgFddy
	2MnUQe03Hs7c8/pY/cU92ft/2LnM+QjNGA/ivmkp15t3dKCfpUn7645KzIYqB0Nc=
X-Received: by 2002:a05:620a:91b:b0:792:ba9e:d730 with SMTP id af79cd13be357-794aaf8bf51mr826791885a.0.1716795212109;
        Mon, 27 May 2024 00:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE/3pPs3Vm1d+crgAAu/1hHrCejTqkMeasyZPJuKiKRdtxp691PtFwHU7g1rdZmvXB/dz6Sw==
X-Received: by 2002:a05:620a:91b:b0:792:ba9e:d730 with SMTP id af79cd13be357-794aaf8bf51mr826790785a.0.1716795211679;
        Mon, 27 May 2024 00:33:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd085ddsm277854785a.76.2024.05.27.00.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 00:33:31 -0700 (PDT)
Message-ID: <2c8c4ddd-3b5e-49cb-9391-c249c27fdd2d@redhat.com>
Date: Mon, 27 May 2024 09:33:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after
 getting mmap_lock again
To: Yuanyuan Zhong <yzhong@purestorage.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Mohamed Khalfella <mkhalfella@purestorage.com>
References: <20240523183531.2535436-1-yzhong@purestorage.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20240523183531.2535436-1-yzhong@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.05.24 um 20:35 schrieb Yuanyuan Zhong:
> After switching smaps_rollup to use VMA iterator, searching for next
> entry is part of the condition expression of the do-while loop. So the
> current VMA needs to be addressed before the continue statement.
> 
> Fixes: c4c84f06285e ("fs/proc/task_mmu: stop using linked list and highest_vm_end")
> Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   fs/proc/task_mmu.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e5a5f015ff03..f8d35f993fe5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -970,12 +970,17 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>   				break;
>   
>   			/* Case 1 and 2 above */
> -			if (vma->vm_start >= last_vma_end)
> +			if (vma->vm_start >= last_vma_end) {
> +				smap_gather_stats(vma, &mss, 0);
> +				last_vma_end = vma->vm_end;
>   				continue;
> +			}
>   
>   			/* Case 4 above */
> -			if (vma->vm_end > last_vma_end)
> +			if (vma->vm_end > last_vma_end) {
>   				smap_gather_stats(vma, &mss, last_vma_end);
> +				last_vma_end = vma->vm_end;
> +			}
>   		}
>   	} for_each_vma(vmi, vma);
>   

Looks correct to me. I guess getting a reproducer is rather tricky.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


