Return-Path: <linux-fsdevel+bounces-17759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8BD8B21F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3291F21F88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0341494D1;
	Thu, 25 Apr 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDxN32I7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CB1494C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049505; cv=none; b=ArQ0o8B0sRPN/q1jGp61QQjRIpS92sbbMgqH7NvFHuDPHV8RKL6uvp2Q4KG/WaIt48rpjoiTwvf4BbGy6cWhbX+gW6POYXffE1dTUM+h64IOUCkg4T82D9rw+CpEOEVNOqdNCMLBG6xIqDgkXnpuk7xT1K46wZhpQINm+ck+Wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049505; c=relaxed/simple;
	bh=uW0/rRa+VKsU1GkQJxdpA8DdFvn7tcaJIztIHYDoqEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lg/6UPJoydjl5CMKppq4i577iUbeNYxxTiWk03zuzWHpOq/o1dNgghWoGO6kmWVTM1L5EkGyujrMYaKxMixd0vNrh8i0qh+NfRIPgCdQxQAXtrhptbu13F5/XhiqBiJm5rCRkInvk53q6vzg/AJYmLtFMgm1rbgobjmLP9WFYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDxN32I7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714049503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=krmJ2ViUMfg+AINQ1obswbRFRThcZ9ZrIRj03SWk/yI=;
	b=FDxN32I7TEar430xipIlaR1AS8yNy6wMA5IVw1Q0A8KNLV9pdoqNkb+QO558ZD3DW5utnc
	LWPhJxoFtEvc8KwthjzuQaNr5MTz6bXffMWUvoGoiLyySpXNL4q1dtiqUCj5EZPHR6sBnJ
	GGb9ZDvE3B1OZ9Wm5vy7LO8kbBQm7dw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-weZYVFaJMnGvuINdmzzPOg-1; Thu, 25 Apr 2024 08:51:41 -0400
X-MC-Unique: weZYVFaJMnGvuINdmzzPOg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34a4ded7d49so931427f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 05:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714049500; x=1714654300;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=krmJ2ViUMfg+AINQ1obswbRFRThcZ9ZrIRj03SWk/yI=;
        b=owTf7SIU79jhz2l56jSr5upWm7kYfE47+JiMxWE27+Q5ofW6WKSgwhbe6tEjIN7SPV
         IYjcvX76VJyXwTve/eU+lRzXGbXgyGvjPIRDasfMB5UvKBl59xtqUGRJZyiOF2Tl0jjL
         AEQsVK/8C6jZMk892vNWFo/GF8e3LI0Ffxkicyble0FRuf8wXGNcLPmJU9aJppW+z2ZQ
         r/ISzBXeo4g82CswbZWI+s4zIlRBpISLNuIVC4U4D/LA38aTRzO8U6OaVgQWBJtyH7wd
         vY/wrBqXzDTSqZnc9UB5qBMv5ivpntd12PtWYXyr2/ZUKP6+3GosEuFcriLMLHUjm7rU
         0+pw==
X-Forwarded-Encrypted: i=1; AJvYcCWV4SGggx+fFH5OxKjoOP123UaF8fMhfN2fyCYSJVSsmluYwXRrdpmqYt2gwIq6+Y786F2VLTDkoPb7MO/guPyNERhQCHEv9njNj8IoIw==
X-Gm-Message-State: AOJu0YxaeIG+yVGWLN1PA0j0UQSDuLqsHQ7UAw+ZYG7l0fxCPtZovDlz
	DzSx+8oVE/gcGpxvhI0RaFMv0GIjb/coNfR49Itv9XVqduQj/NHjARql/kuyFYTVYXUOO+QCwfv
	g08CnH/U1+EetqsFfKdBrCCRtogL1o6gAyk0Pxwxo0EInXJJtOUdYMVDpRg5yXSA=
X-Received: by 2002:a05:600c:3b07:b0:418:a2ce:77ae with SMTP id m7-20020a05600c3b0700b00418a2ce77aemr3515971wms.27.1714049500321;
        Thu, 25 Apr 2024 05:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaJwcXDCrGcd7ftGYfOCokMw95T3AavJU6hlO4mLqIqCrKVVBEeKvQJbaF+RS72KWbICjGXw==
X-Received: by 2002:a05:600c:3b07:b0:418:a2ce:77ae with SMTP id m7-20020a05600c3b0700b00418a2ce77aemr3515961wms.27.1714049499916;
        Thu, 25 Apr 2024 05:51:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b00414659ba8c2sm27546670wmq.37.2024.04.25.05.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 05:51:39 -0700 (PDT)
Message-ID: <4ec6eab0-9e8e-4381-97e6-927f5ee55e8e@redhat.com>
Date: Thu, 25 Apr 2024 14:51:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] ksm: add ksm involvement information for each
 process
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 shr@devkernel.io
References: <202404252049158858OT9IpNshMmQC1itDY1B1@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <202404252049158858OT9IpNshMmQC1itDY1B1@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 14:49, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
> MMF_VM_MERGEABLE and MMF_VM_MERGE_ANY. It helps administrators to
> better know the system's KSM behavior at process level.
> 
> MMF_VM_MERGEABLE: yes/no
> 	whether a process'mm is added by madvise() into the candidate list
> 	of KSM or not.
> MMF_VM_MERGE_ANY: yes/no
> 	whether a process'mm is added by prctl at process level into the
> candidate list of KSM or not.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>   fs/proc/base.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 18550c071d71..421594b8510c 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3217,6 +3217,10 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>   		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
>   		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>   		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
> +		seq_printf(m, "MMF_VM_MERGEABLE: %s\n",
> +				test_bit(MMF_VM_MERGEABLE, &mm->flags) ? "yes" : "no");
> +		seq_printf(m, "MMF_VM_MERGE_ANY: %s\n",
> +				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");

Not sure if exposing these internal flag names is appropriate. Better 
describe what they do.

-- 
Cheers,

David / dhildenb


