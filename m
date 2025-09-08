Return-Path: <linux-fsdevel+bounces-60567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D50B493ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB1E7B5E6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D457130E0FF;
	Mon,  8 Sep 2025 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjOanSVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465A1C3BFC;
	Mon,  8 Sep 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346037; cv=none; b=pOLI1DZb6mI0PVa5rOQI7IV/aAyq1347p/EXvOQLowRWZd9Vd+dGeDYDio5g2QsijrwnB5PqgmHJAOf5Go8K/9bJhihNRh2Ute/LP1ENcy0fp4A22d7uElGHhdPcFRpRuBW5v9SdJYf4dsNEev6/7zc4P0jENb3r3vXOq25dYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346037; c=relaxed/simple;
	bh=qwriLjbmcAGst/zCmLUrZmks1+AuUfZH39KvUOcOH0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFQVd9M2eaSnVbjweXbNdcyXx61wjQbTiaEhQbvXuHBANfqc2+zM3dGYLf1Q2bumoAsXhIbekMkJ6gpEujHBc0vAG3iVfQrdeeKISKaoaCYVVrV8aMNmAKWcqXkqfnolAucum10caK8imLEsINXfEVDA/DL+2IvM09luTdLFoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjOanSVC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5d5b1bfa3so43206091cf.1;
        Mon, 08 Sep 2025 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757346034; x=1757950834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmlBlDpl+4/RqcC9nUmRT5mg0GKEaeGb1rCCM8xHueA=;
        b=cjOanSVCQmSsQ+LhkaIc8PG0AetM8KahhpKaq0v4uZPUOf/DJSDdTi5k3Znu/n78+i
         6hxnx6t7pkUnXpKPIUn18MY1gUalAJgjOuJdHVqbN0hih74EF9Bt6byDhwV5NddSG6z6
         CDGVMTpqZb6KPp/hWb/C7Gi9AFIEaDn0FijpfeGziJa481mRYNTg5zoRjJSl+37GezKF
         N2EbWuzVsRzxOQKstJrpY/gsAhCm3g8NfOBvW+95BTgY9DlkzM9ADHtfgCU433izM/yN
         39WQ+jvhAyPOP24MyGEnEBSUnlp2CK29qxzUuMuXF18w8xWjuOE+nrqxrZU9BuwEl3yG
         Z6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346034; x=1757950834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmlBlDpl+4/RqcC9nUmRT5mg0GKEaeGb1rCCM8xHueA=;
        b=bbQFEefL2hp5DeDe+6ahDG7HCPrQ/H64zOI00Pjqk2WplpA6qfUTDdZGK89HU5elzP
         TuZ4mGwuWDv5t4b1k3ofHHMFeqrwCzrh1OPi5ZRUI7pCXLqy2hnl6ryjNXKqnTW1jVe2
         wgwXc4xrWeZqxQnSrdR2+uP8EhxYGiuQFL9wRFXt6bbQ9eVD9u74pW+TgVWRzVD36SLM
         7au5kOhJnQjm3INHSTGej20fBiHaNXYNbNP17dV0VEKjkVKaWdfVXz1JyryXrc5nKzXP
         AeCHI9D5AMYzQMyqa8py6h06EOi1aJ4qd42pubN7Ms3Q7lbSEKbfvsOhNdKz4bqTPO+b
         2fvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0cqPRnCq8kqOwNlDP13fqv6OvokQp9GYY5nw6vzfcyWNe5MFbQpdQN+nlCob3kMmCno30AnDKB4ivae3j@vger.kernel.org, AJvYcCXJ3GIBsqgx/AxmrWJDXQ7IuPSnNTDdzVftE+JRemalsHZsW5E7Moy2fr+XLctJYRFAv+WAhPchjerOZzmwMA==@vger.kernel.org, AJvYcCXuajJMU2pxJvUQwIIPRk96shn1J60gycJ9ituECNwZgFw3ZEoaqLci00jpmVNX9p6TbqhrQ2XT3jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhJD8ysZayR42W0NJkbU/qjD/wo6oRr8walDa6kUvbEe9q1c8
	ed/WfT+SZkp5jIRQtT9IKwbJnoBxXfk0B8qNi0naAP2zJ5u4Mxl8fS7B
X-Gm-Gg: ASbGnct8hs47PuOprxwapvpfkCoIew7M5H2cC8hvIT1A2yIvIKAE4Hfs7A1IiOJ32W9
	8nC/9NIjMfOLEce0WIAXMBx2gmxgMR4lkck0VyBpmJSa6yWlx14OV2tUmtV8sF8i7erExoESsxZ
	VnfoWh6wtCrMhspnUB4Jl6FW6K5cTbk+mTsj4pM+hlTWXnsxdtdmLhFRf02cY7PHjYHY/kkWcI1
	DB/si0xgwANOifqTd7he857TMgjaEGfPBfzB8hk7+56FQ0qs00IfkTmpSzGpxlif5xxKzmfDE9K
	WuTGsQ91DacJm7zruX/8MxADk7LG2AjZTYqT/SU6vfHoh1xsejqq2eOuesd0jEIgHWpkdfa044q
	5DSbj24SYYjVr97BBhze8am8zx8W2Nwzu0n9cxe4J6LJLGzWcJfBbJizSP588FNubqaJNqM5wtO
	QLsILFk2v6+Io=
X-Google-Smtp-Source: AGHT+IFU1PZ+J2iW9oBqGqqd64Y3TTikMQfv+fShqzgZXQJgjFCltE/gj+GjX+w0jAHOPjKr8vx3MA==
X-Received: by 2002:a05:622a:19a5:b0:4b3:15d4:1c1d with SMTP id d75a77b69052e-4b5f84bdc33mr88981991cf.84.1757346034372;
        Mon, 08 Sep 2025 08:40:34 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1456:e851:ddd5:be9f? ([2620:10d:c091:500::3:4e10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f7ac9f8sm106132511cf.52.2025.09.08.08.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:40:33 -0700 (PDT)
Message-ID: <1d7a945c-70db-4446-85ab-19f5af88e204@gmail.com>
Date: Mon, 8 Sep 2025 11:40:30 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] selftests: prctl: introduce tests for disabling
 THPs completely
Content-Language: en-GB
To: Mark Brown <broonie@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 david@redhat.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 corbet@lwn.net, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
 riel@surriel.com, laoar.shao@gmail.com, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Aishwarya.TCV@arm.com
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
 <c8249725-e91d-4c51-b9bb-40305e61e20d@sirena.org.uk>
 <5F7011AF-8CC2-45E0-A226-273261856FF0@nvidia.com>
 <620a27cc-7a5f-473f-8937-5221d257c066@sirena.org.uk>
 <abe39fc3-37a3-416d-b868-345f4e577427@gmail.com>
 <771871a1-9ee7-472d-b8fd-449565c5ae80@sirena.org.uk>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <771871a1-9ee7-472d-b8fd-449565c5ae80@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/09/2025 16:38, Mark Brown wrote:
> On Fri, Sep 05, 2025 at 08:40:25PM +0100, Usama Arif wrote:
> 
>> diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
>> index 89ed0d7db1c16..0afcdbad94f3d 100644
>> --- a/tools/testing/selftests/mm/prctl_thp_disable.c
>> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
>> @@ -9,6 +9,7 @@
>>  #include <string.h>
>>  #include <unistd.h>
>>  #include <sys/mman.h>
>> +#include <linux/mman.h>
>>  #include <sys/prctl.h>
>>  #include <sys/wait.h>
> 
>> should fix this issue?
> 
> That seems to do the right thing for me, I'm slightly nervous about
> collisions with glibc in future (it's been an issue in the past when
> they're not using our headers) but I guess we can deal with that if it
> actually comes up.

I have seen this included in another selftest as well with MADV_COLLAPSE.

I think best to have it. I will send a patch with it.

Thanks for confirming!

