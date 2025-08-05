Return-Path: <linux-fsdevel+bounces-56731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8CB1B1E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8593BA89E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F226CE0E;
	Tue,  5 Aug 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMsAJAbc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159B156237
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389500; cv=none; b=QNsJBppmKX3gdxCapqlGtoHangd7DnB32p0wcR8QKaEUtJhPSdqTklnaCNgoLkg0lskc4HwhYH2tCG576k/4METnJngA1EcXd+vEuSgqqEQIwZp1U+Ik5km79X/kAWZpqz3m1zu95eC8KzKfU10opY3C1fVJFtTb/jWkHlbZy0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389500; c=relaxed/simple;
	bh=GOJ9HvDFeOVL3a7vbmOngeI/UuaMPYaoNSTpee0rEzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9pfXOkONpZjROEOGy/HdtRNIy1rNqjfzA+fiKj261FAkifGK1hg3mj9NKU2EM9OSn1o1v6I5cXMU3ugwm5vT2wGWSH+WPcvQc11I8pXalhGX4HRaWznuB8lKzH7JmAjCxP0KMX0AxE+FmF1DYBJVkboXSCSBC8Aq3NeH5oZUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMsAJAbc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754389497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VBbjKtAO1a03uu2qCH/wtI3fB+RdVfOGPyKiXjnpo+E=;
	b=eMsAJAbclFOFeSUdZ6+E/DC3nJ6EVfqq0+mYMG4kZeH1pt8tqkZov4ly28IVtj4on9Uz6V
	HBMBIsiMLOdnhgYnuDB8w2UW4T8BLkr1LzOB62OmLhwcfK31shQqKJvZh80aQZIirTOY6x
	gaRTLn+A0jmjaSZDxLsFcFFjXVeQLmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-PSgeafy8Mzq2hl5g_x4kMA-1; Tue, 05 Aug 2025 06:24:56 -0400
X-MC-Unique: PSgeafy8Mzq2hl5g_x4kMA-1
X-Mimecast-MFC-AGG-ID: PSgeafy8Mzq2hl5g_x4kMA_1754389495
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459e0f54c88so4641915e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 03:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389495; x=1754994295;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VBbjKtAO1a03uu2qCH/wtI3fB+RdVfOGPyKiXjnpo+E=;
        b=w1dE+u1fUFoeL6yE5G3pbjnj2devx+mKsyUalOL/Yoc05X7vSdOmS38gprNCAvBlKN
         WwewTxIze5Hwrf5w6LTP/ysD9sbsVBTHI96y5rdOA5PfW9IqKBr+PyX+I/9tcMgn9rNS
         WuXsK9gygpQP6+MfvIrvi6rRZjbHstLlf1YljaizuZbEzEMcfIrYYVRQERTXDYIgjXA4
         +bcfaFAoFYhtBzk3P7IlhKXuIT4BF/Q++4P4HHiRXatOsz6V+mQOHgd6G+ydvxpuq1wp
         vkky1Nbasxauhwax9ocNLes8KMPBBVgByONEpseyWvrjyPOyIz/MujItynTcSQtWqgmW
         5cyA==
X-Gm-Message-State: AOJu0YylUaDQDwNvvwPGO3Yd/52f47unzbnvAYJ3dpxJpP94IhXAVXyu
	R0axaFPeXZ4X6uBwhdSyGWveSAL9K753Y188xnhU6uGLpc2jDFFcMhHD0doxAeAqHQ14/lW6de5
	VsyoNsTBPmQEIcg9Vlu9LR+l7cb5UYZ16+TgDC55iqVIQNstIFQe1GVJUpdQAN0oohts=
X-Gm-Gg: ASbGnctiewj6bXgF3HVfqXhuP2rGDQsxucCyTPHsYpnpGxWBlOi/90lfBu/5H9J14aG
	6xURaEpIdYtn9OF+ZNVXvCHLGPJ6CRhCNFWpNbMEeLs24DJUaXLq8MNdWHRnensSAuYFr4FaxUj
	YTRl6zDK1ikFqEE3F+oCYv8H7/izFVyWT3uW/QX6GhUw1VYKHdxG22so2utzrJNZKwQyzfSjiME
	HjcK2w+vqN8offPPw+AZFvWOlpT3DHAMSYh7FrYD4dgPOoL83Ps/PipOH3TR3/hW3i7V/Kewhga
	r7+b/iRKFca4250c7JvHFhUdT9+jXLcneISDapguyZ6lfpET1byvs1YEHS26vhw6yTmARO265pD
	XQFqpAQcXV//3FRgBH9/IbIVdMl4CsAteMAnhIRR6tmWCYYLD8k9hr4aB36SaaqRqpo8=
X-Received: by 2002:a05:600c:6d0:b0:459:dd4e:4435 with SMTP id 5b1f17b1804b1-459e0cd0377mr16733205e9.5.1754389495232;
        Tue, 05 Aug 2025 03:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+zb28sOFCvmiXLYnwTCwUW2470YVI9yNLiQDTNd1mndb0l8A/C348gU+81Rr5jw5UUCPB+g==
X-Received: by 2002:a05:600c:6d0:b0:459:dd4e:4435 with SMTP id 5b1f17b1804b1-459e0cd0377mr16733045e9.5.1754389494731;
        Tue, 05 Aug 2025 03:24:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dfa64da0sm48813325e9.3.2025.08.05.03.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:24:54 -0700 (PDT)
Message-ID: <7828753c-98fc-4f96-bf7c-0d94f3b99e4b@redhat.com>
Date: Tue, 5 Aug 2025 12:24:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] docs: transhuge: document process level THP
 controls
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-5-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804154317.1648084-5-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 17:40, Usama Arif wrote:
> This includes the PR_SET_THP_DISABLE/PR_GET_THP_DISABLE pair of
> prctl calls as well the newly introduced PR_THP_DISABLE_EXCEPT_ADVISED
> flag for the PR_SET_THP_DISABLE prctl call.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst | 38 ++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 370fba113460..a36a04394ff5 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -225,6 +225,44 @@ to "always" or "madvise"), and it'll be automatically shutdown when
>   PMD-sized THP is disabled (when both the per-size anon control and the
>   top-level control are "never")
>   
> +process THP controls
> +--------------------
> +
> +A process can control its own THP behaviour using the ``PR_SET_THP_DISABLE``
> +and ``PR_GET_THP_DISABLE`` pair of prctl(2) calls. These calls support the
> +following arguments::
> +

Not sure if we really want to talk about MMF_ internals.

> +	prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0):
> +		This will set the MMF_DISABLE_THP_COMPLETELY mm flag which will
> +		result in no THPs being faulted in or collapsed, irrespective
> +		of global THP controls. This flag and hence the behaviour is
> +		inherited across fork(2) and execve(2).

"
This will disable THPs completely for the process, irrespective
of global THP controls or MADV_COLLAPSE.
"

?

> +
> +	prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, 0, 0):
> +		This will set the MMF_DISABLE_THP_EXCEPT_ADVISED mm flag which
> +		will result in THPs being faulted in or collapsed only for
> +		the following cases:

Maybe:

This will disable THPs for the process except when the usage of THPs is 
advised. Consequently, THPs will only be used when:
- Global THP controls are set to "always" or "madvise" and
   the area either has VM_HUGEPAGE set (e.g., due do MADV_HUGEPAGE) or
   MADV_COLLAPSE is used.
- Global THP controls are set to "never" and MADV_COLLAPSE is used. This
   is the same behavior as if THPs would not be disabled on a process
   level.
Note that MADV_COLLAPSE is currently always rejected if VM_NOHUGEPAGE is 
set on an area.
...

 > +		  or MADV_COLLAPSE.
> +		- Global THP controls are set to "always" or "madvise" and
> +		  the process has madvised the region with either MADV_HUGEPAGE
> +		  or MADV_COLLAPSE.
> +		- Global THP controls is set to "never" and the process has
> +		  madvised the region with MADV_COLLAPSE.
> +		This flag and hence the behaviour is inherited across fork(2)
> +		and execve(2).
> +
> +	prctl(PR_SET_THP_DISABLE, 0, 0, 0, 0):
> +		This will clear the MMF_DISABLE_THP_COMPLETELY and
> +		MMF_DISABLE_THP_EXCEPT_ADVISED mm flags. The process will
> +		behave according to the global THP controls. This behaviour
> +		will be inherited across fork(2) and execve(2).

"This will re-enabled THPs for the process, as if they would never have 
been disabled. Whether THPs will actually be used depends on global THP 
controls."

?

> +
> +	prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0):
> +		This will return the THP disable mm flag status of the process
> +		that was set by prctl(PR_SET_THP_DISABLE, ...). i.e.
> +		- 1 if MMF_DISABLE_THP_COMPLETELY flag is set

if PR_SET_THP_DISABLE was called without any flags

> +		- 3 if MMF_DISABLE_THP_EXCEPT_ADVISED flag is set

if PR_SET_THP_DISABLE was called with PR_THP_DISABLE_EXCEPT_ADVISED

> +		- 0 otherwise.

> +
>   Khugepaged controls
>   -------------------
>   


-- 
Cheers,

David / dhildenb


