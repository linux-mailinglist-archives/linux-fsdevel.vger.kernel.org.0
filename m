Return-Path: <linux-fsdevel+bounces-56740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8C1B1B318
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3058518A2858
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2046526CE30;
	Tue,  5 Aug 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUtH2Mbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848B248F51;
	Tue,  5 Aug 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395781; cv=none; b=ZjqeBmLaQ7M6Dm3nagXriae1RZDYlyi0QRlniicWCsalENdhwhdv9hf+Kfa+N1qbEn31+ZbT3mB9sX1CS0Uk2hywhdr/6Sfu74aQEW9elbsj1Ne1X+77dEhN4hdqEnR7V1FNw9fosmFeDbzgMnqrCR9+h45QVQTkAzYm9Ij1gFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395781; c=relaxed/simple;
	bh=u7YmLOIiY7LaTcDo3/FpMSiIN+D1YykNaQxHLBfp7fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2VtuA+2H6eYgNQWEE9eOJpoazFOzC75FdhGh2V80ZVODS4mud9x28wQ6xWb89jpzxkFX4yKhiSxAx3VuNbMS1FsxsgUXWqh02f+vbR2vxI/XVpDYfgg3PWpXOvjlyrq6otrXImuzpv0PgJMkAdDXdVM2HC9TUoJoqegCiAdM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUtH2Mbx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458baf449cbso29114045e9.0;
        Tue, 05 Aug 2025 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754395777; x=1755000577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QnDvv+RYZWrQhG27roIN5rQzgCLkdpLVj3Hura9BY24=;
        b=IUtH2MbxxEJkE/LcuiU9ZJGJBWxBSYnqbJ0VyBOvhWLBdQsOVAvtnWNfXpGy87uR/o
         Ci+i+SZQxxmchjwrGjTMqZdv+emy+QhfPrWx8Bwi2Svj+YjDVs8UE+7q8aeQUZtchx+p
         A+XhgDs27+gCdpdR9U9dheohaUhS+fRAcL6yMi0TI7uPdW9Q0oooA+KoDsbpqkJzfR65
         tKhoogBLU86b6poNKKHZljzYaAwCreURewFA8tOo9C9jHth4laARE3aeYbignJ6QjiVx
         QolacnKSEK6abgmwqV0JsANmLKnViuGefMXGMaxZloFI88IdtbylgDnL5ot7zFm9j7I6
         3djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754395777; x=1755000577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnDvv+RYZWrQhG27roIN5rQzgCLkdpLVj3Hura9BY24=;
        b=uTg0ULzfOup6teayaHIq3aawiJSvAwBQzDTY3GR75t4996hpXHMVoWo/yXge91oqZw
         8H8/1Gx97cRZ46PX4yNtE3gkxN9celFdMEFjPbGLZPXjCAyPz2gXEa9VnQ5F4bpmeq1A
         VDm234kdV80cxGyX6H5u3kkJOGsil++9TIF9eraxPT2sBY9FwQtLgdKpTeNrfO9uGRu9
         a6pryo5GpCWiTA6IGJkmUEw2CIgwXM6CejjB5UgNO6bEJ1CHkBcrxDjyWMsmXdOPEmOI
         pxRHPgIjX6GyZIVaaxWAUgTT3EU4ahV6jSmrTfWxsathD+j88nKi6Gh2WIR3BnyLeFbJ
         Z+2g==
X-Forwarded-Encrypted: i=1; AJvYcCWy67y6nlzUIxhwdyRzI7vpiY+8H8TxM6uuRQ8qMi304gqHHluoz/JHlDoR9zulkJ/c9946lEbyEV0=@vger.kernel.org, AJvYcCXI3Ui+M8Jb7sax/2FTzSbJCA4ePO8Vzbc8+8QXV9UDh85jjvikqTx40NMXg210EpBUviKQZxn+LcTiUH9u@vger.kernel.org
X-Gm-Message-State: AOJu0YzOe1eNrgNajfiSaIomDnqY+giqzbF/ui9o61lf0zEnJ4Uq81SW
	EhZbO0iHJABpl8/PEaobp6QQmdnLopanpFSLW28jczGVM4+M1gEECxmn
X-Gm-Gg: ASbGncvIAC2WdRHdHtTLxCVrTlPDBrXLaf0naT6o8Q/fVKPsUzT4D3z3tgIhaIuhuYF
	Em2Q4MMVDGRLTkDTKHVcWVETpIm6hTrs2cK0GYReNX1BdcHu3MOEbVGKfDFg81mJoFF06SQmcrh
	ma/kT4jfqXavK8v3eKQmNE3iHeaIjzagRkXc68bjJ+PhSCCVYKint4q+Si/OglNZAcp8YkWPS1R
	MDBVGojlPmhzk5GaydCNxufs1f0o4nUuVG97qIqHTGeBim5q9eMWL2KGa5J0hk/CV6lOPzcWrjs
	SUDIzQmrspb0sAUjAbhEwQ52bWdrmFCBs/OsJLaFc8Ux7inS5vdoEu5L5N1sUkP3iDS/n8QtFTF
	x7V3L13HWCvhKeUjoNGhZ5e/vHUasNoNycBS1VvMqf9rY6LBL7ycO5Hw5f2sEzCMHGhjvomg=
X-Google-Smtp-Source: AGHT+IHaZvpfuNdcteCmnFuvch+C+rl8ZmnFCmfkcK/icZCUVfFy77dZQumTyON7VuwTLmN17F0Guw==
X-Received: by 2002:a05:600c:4709:b0:459:d46a:ee3d with SMTP id 5b1f17b1804b1-459d46af0c7mr77845295e9.2.1754395776562;
        Tue, 05 Aug 2025 05:09:36 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::6:98ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm1048305e9.2.2025.08.05.05.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:09:35 -0700 (PDT)
Message-ID: <4cb3dbf4-87bb-4946-8e43-36dcb5d9fefe@gmail.com>
Date: Tue, 5 Aug 2025 13:09:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] docs: transhuge: document process level THP
 controls
To: David Hildenbrand <david@redhat.com>,
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
 <7828753c-98fc-4f96-bf7c-0d94f3b99e4b@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <7828753c-98fc-4f96-bf7c-0d94f3b99e4b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2025 11:24, David Hildenbrand wrote:
> On 04.08.25 17:40, Usama Arif wrote:
>> This includes the PR_SET_THP_DISABLE/PR_GET_THP_DISABLE pair of
>> prctl calls as well the newly introduced PR_THP_DISABLE_EXCEPT_ADVISED
>> flag for the PR_SET_THP_DISABLE prctl call.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   Documentation/admin-guide/mm/transhuge.rst | 38 ++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 370fba113460..a36a04394ff5 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -225,6 +225,44 @@ to "always" or "madvise"), and it'll be automatically shutdown when
>>   PMD-sized THP is disabled (when both the per-size anon control and the
>>   top-level control are "never")
>>   +process THP controls
>> +--------------------
>> +
>> +A process can control its own THP behaviour using the ``PR_SET_THP_DISABLE``
>> +and ``PR_GET_THP_DISABLE`` pair of prctl(2) calls. These calls support the
>> +following arguments::
>> +
> 
> Not sure if we really want to talk about MMF_ internals.
> 

Thanks! have changed it for the next revision according to your suggestions.

