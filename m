Return-Path: <linux-fsdevel+bounces-17871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3EA8B3218
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A61C2176C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462C13C9AD;
	Fri, 26 Apr 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFDCXNM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AF14293
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119193; cv=none; b=aU2p/3CyhgU4HeLcmvK/arFFwfgrH6CEPaOMxMZnoP2qnpqnDiKn+d8XIOBBsDI1S9FAbAkN0MVsGkV16inqFajps+dfDD7NsGaQ+OLHKf+mXb+gdkHRJ+tdvGAdWJeYA6eJBBseap9G+YjZybJ+m2w9NpovcLbPEi7SjOZXlTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119193; c=relaxed/simple;
	bh=Z5+DZQqeYmXZDLyZej4BSiGJtIi3heNomxLaim50DIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQHOXy+l/Gon10p6NSNIgpKxynxRM5WcshIl6riAnrwC+d9Tp5diWZVe7FhcWSrHRmRJuAEJPxT4CQiZO8rJ3ro8rGZ3qau5YcPoc2epTE2w+of89oNaOTAuVBSQRyBH03SvFee5PBPAAgJlAt+aTc9jjTE55RufYosGBO6ecOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFDCXNM0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714119190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4wVvMR9QBthSgGfJ1Yq67tCFimGOYOSeWNl1DqI6ZuU=;
	b=WFDCXNM0Gp0Ebqyzp+x2JMdotFjtBhFAHIbzRg9GpdUXQzGlnB0/cVGFBxz3/QX0Iqdflj
	dsoPOhijeyg/KaYq6EIF2ZXOtz4C72Ucfwzkiowej1h7SIV7CUM5qUeiY7wR2SexzFZb3B
	cHZ5tMSP0ynkfYJ++D/L5ubnjLmdv8c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-UH_XtIh9NA2rzfgU3kz-FQ-1; Fri, 26 Apr 2024 04:13:07 -0400
X-MC-Unique: UH_XtIh9NA2rzfgU3kz-FQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-349e1effeb5so1548561f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 01:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119186; x=1714723986;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wVvMR9QBthSgGfJ1Yq67tCFimGOYOSeWNl1DqI6ZuU=;
        b=Kfm/LgfgLsFCaFui9SKcqA5YrrChP/1SC50c2eB21C7p16bV4XVwK/mrY3WVtSHuri
         3S4bPkdDIC7/kcoS/X/yIGhzDS42RpFRhYF9Z7Icc7pkhJnAF/M7ddAGIskaMrVPn1GX
         tiLLQshlv9oJxdR3i5o3rvfBKlaM9nUEzuxQIfYOSNFmsN7o0yryQ9U1b04j475RX9lb
         fW8L9RbsPLi1Khqy5G94IYn27Zl68ui5HX1YxhTM6k9Eyb/+Rhj8KjX/62w7rRkR233c
         B4ayL0fr0h/SIM5GGvi8cTToFY2N0j3h9SnslGDhc1T7aqZT6zP6D5qGNrb1VTTr6pEr
         s31A==
X-Forwarded-Encrypted: i=1; AJvYcCWEshJkeOckhPhTSaREdH5b1tAHmtDqU5z7RKQbR6vqqqHCdQm8wr/ACV7IHUW/eHkFMkhxFskrCjLG3dxGXpa3Ef6334PWiLM7sVErwg==
X-Gm-Message-State: AOJu0YyM7wDyK9gk2jVJ45fI2KKulHr40RK7xsATcwb5Dn01yzIODN17
	VMI3Zz0DlNIOqKHELEqk/0kBzs3+CqgaJfjEre3miISVkBf6glU41y02nkDHJIgsaT/xmbIZShQ
	c5DWxqJKJktrG9HojSELFvSI335VebADdF53kWE1sLJN4HKnKMFYfE1ZYANsujPI=
X-Received: by 2002:a5d:67cf:0:b0:343:39a6:93bc with SMTP id n15-20020a5d67cf000000b0034339a693bcmr1773576wrw.11.1714119186230;
        Fri, 26 Apr 2024 01:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb2czMa8mR6OyEp9wFwbNiHxlxk4lIjR2qEOWqpJmdFakLPIpCUHu6wqhuUf5ZSh0+Thy/iQ==
X-Received: by 2002:a5d:67cf:0:b0:343:39a6:93bc with SMTP id n15-20020a5d67cf000000b0034339a693bcmr1773555wrw.11.1714119185796;
        Fri, 26 Apr 2024 01:13:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d4591000000b0034658db39d7sm21897137wrq.8.2024.04.26.01.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 01:13:05 -0700 (PDT)
Message-ID: <bc0e1cdd-2d9d-437c-8fc9-4df0e13c48c0@redhat.com>
Date: Fri, 26 Apr 2024 10:13:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v2] ksm: add ksm involvement information for
 each process
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 shr@devkernel.io
References: <20240426094619962AxIC6CSpfpJNeiy8HRA9h@zte.com.cn>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240426094619962AxIC6CSpfpJNeiy8HRA9h@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 03:46, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
> MMF_VM_MERGEABLE and MMF_VM_MERGE_ANY. It helps administrators to
> better know the system's KSM behavior at process level.
> 
> KSM_mergeable: yes/no
> 	whether the process'mm is added by madvise() into the candidate list
> 	of KSM or not.
> KSM_merge_any: yes/no
> 	whether the process'mm is added by prctl() into the candidate list
> 	of KSM or not, and fully enabled at process level.
> 

Thinking about it, we should avoid exposing internal toggles with 
unclear semantics to the user. See below.

> Changelog
> =========
> v1 -> v2:
> 	replace the internal flag names with straightforward strings.
> 	* MMF_VM_MERGEABLE -> KSM_mergeable
> 	* MMF_VM_MERGE_ANY -> KSM_merge_any
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>   fs/proc/base.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 18550c071d71..50e808ffcda4 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3217,6 +3217,10 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>   		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
>   		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>   		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
> +		seq_printf(m, "KSM_mergeable: %s\n",
> +				test_bit(MMF_VM_MERGEABLE, &mm->flags) ? "yes" : "no");

All it *currently* means is "we called __ksm_enter()" once. It does not 
mean that KSM is still enabled for that process and that any VMA would 
be considered for merging.

I don't think we should expose this.

That information can be more reliably had by looking at

"/proc/pid/smaps" and looking for "mg".

Which tells you exactly if any VMA (and which) is currently applicable 
to KSM.


> +		seq_printf(m, "KSM_merge_any: %s\n",
> +				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");

This makes more sense to export. It's the same as reading 
prctl(PR_GET_MEMORY_MERGE).

The man page [1] calls it simply "KSM has been enabled for this 
process", so process-wide KSM compared to per-VMA KSM.

"KSM_enabled:"

*might* be more reasonable in the context of PR_SET_MEMORY_MERGE.

It wouldn't tell though if KSM is enabled on the system, though.


[1] 
https://lore.kernel.org/linux-mm/20230227220206.436662-1-shr@devkernel.io/T/

-- 
Cheers,

David / dhildenb


