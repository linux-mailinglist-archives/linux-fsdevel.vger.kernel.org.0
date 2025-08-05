Return-Path: <linux-fsdevel+bounces-56747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B3B1B37D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7F118A3C11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0E27380A;
	Tue,  5 Aug 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAN6VEyk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002B23FC41;
	Tue,  5 Aug 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397087; cv=none; b=fOt6g/f2gQbTyH64NnURKuwed/cgisM5sjOuNdExFO0brjV2k33JNN5CnxmN5Gl4A4r3MIcUvkTuPhOuioYuAjam06tk6Ug6pGcZnvVUCUfCJFvy6XX2QNYy+r8dJSgRFwYIYYwZCHj5wnK+6db8VFYO9KE9tTzeML52GuR9Gqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397087; c=relaxed/simple;
	bh=c0Fcyieh4/NzqGStOPe7aHwE1kpGuocqN3I/TYD4ah0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2NxxxvUcbaB+5r/5MhVcxHjG91tL0TbzRnlmUfUEnS1riG6TQTWoDFNMpwMbfFP6J0XPN3iDZ9aMgje9G50Rgld52XqqiOogwkUgwkoHYB4m5Uy7rUap/yYtEp5rEtYkq0kvRx5R/6sTLMWk8iToC36TJ24hCchwpfwe6WRrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAN6VEyk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso42400975e9.1;
        Tue, 05 Aug 2025 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754397084; x=1755001884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7ilX0mFGR4/JkHsqHcNZKxMRUw+NahHCrzFehFr1BY=;
        b=YAN6VEykoZj2RKsy4Gg16UJz2z7uo44tVgv+H6uGCmEX/DM4E/jVqqB8USX1kxmLDR
         iyqASWiHkLvQNseYzx6T85EgpkBsuSEtzyIwhuzp7hGZDQGRGumRSnR2K2P9gV7vWlgN
         8MznoszrMI9f1atZg9LPLDGEDU6GqCXVBkF8RdWk/lTxekKDiHJRpXdV2QdSnAk3Wlj9
         7QaLZJOQP8Mqdd6bf9Q+nVB5sZyaCvLeUxBzUsEGDEVNnwERt8gTXJKY+jEzFaGYgJAd
         HdIvgZfEbL5oic3Yl7t13zL19iDrsjh/rpGgiOPQJunkmPVpbXJEmloaOBQfVe3SHJRl
         f0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397084; x=1755001884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7ilX0mFGR4/JkHsqHcNZKxMRUw+NahHCrzFehFr1BY=;
        b=OD9M8CMn37MA+tQhkLxdw7bacqq3ucTv8BqFujLsiD0OB1+I51cF2XLop1JIa2JklS
         diwzKY2fhuApmd9OQDjiOaq9Z+KN38Os6J70ptSSkWacMayjKOpKh34rHYvcZo4zPYuH
         69hR18ID7Q63SLz6wzzLqoXoTfvTuqs2AU3tSn8H8Hs4a7HJrGjlC2kwV6DqLavbFa4g
         8BQ27RB4sK8dtLEX2zQzsVw1XN48XVmwzMyG36Kywjvlr0uO0yhKRmEx18LWhQ0sOtqW
         75VZvBpOkLeVjZ00OJUPWKiocyad0qdlsI/0YcgjgqEIq6Dm2ZFeBMe+Wn3mBIdCgJkJ
         2SoA==
X-Forwarded-Encrypted: i=1; AJvYcCV6BPSoyTxu7yXYbeOcy8huatMzlv2FTGqnYgV8GptsPMVI6C2I11mv6gSYcYxZq2AjfTnsNspNlVE=@vger.kernel.org, AJvYcCWfSUkp28nwPKr08aHwF60xmRG2Q02Gy/okGWqJdiBMi0LoEopJXlxcD5M9zrrAT3DHa8WjxBehYRmtMvhF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75nsJbJGImrDtbXRYAWEPkapntTdQdFBJP9Fy2osMMO5yGyYO
	eWd0qfcz8f03jKvOXdYOhR31Im71XQxOcNRbIl3a3auGZCdLH+Btu0d2
X-Gm-Gg: ASbGnctEwiPQvCjV6j7HoY6KLoH1eaQWvwMVsTpM8jD3Nkh2DYAppkaL3cExOexL5/U
	qJnHydPSFDUoivWEFwOijcqoHtYxgcs+NV9bC5pXPr5SfYcedIMwMm6IkCivffbxQJYFzeSAEcs
	ejL1uJ0QZDA5KMcwSCqoWk9dvaOtXiReauULViHwiYu5Hoo/dCgyMrgNjjesbMydgoQTtwoxcoZ
	K0z2B/5WhLZd4emSbvTQiDCTDWLynqtNBj7kilksYPADoUl8Y5c049N539pb+uwCKtBIOP+Zk2U
	ouRx3Nevp5/PhBBRnQCnnVOyVY0Lob7WZ9RD3c/6f6B6g2NvKns3qmeMEwcX2leolSxNCx4kta5
	bWlNsA5r9WkRjIVAeqiWmaB3RFuCfsgggQdnRobsG3cPQxLPhCL2yD4HY/qV5RF0ADcOHGxQ=
X-Google-Smtp-Source: AGHT+IEnzppskDltSmW5ttFeZtALCEJKNR1VGLhcZm5DmqLbGcICelSCPZQ6ElJz30cvbsgwmnqllg==
X-Received: by 2002:a05:600c:4ecd:b0:459:e048:af42 with SMTP id 5b1f17b1804b1-459e048af80mr32090645e9.24.1754397083749;
        Tue, 05 Aug 2025 05:31:23 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::6:98ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5844eebsm1892575e9.1.2025.08.05.05.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:31:22 -0700 (PDT)
Message-ID: <dd981fbe-bbb3-478e-8432-f30e0adb6a88@gmail.com>
Date: Tue, 5 Aug 2025 13:31:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] selftests: prctl: introduce tests for disabling
 THPs except for madvise
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
 <20250804154317.1648084-7-usamaarif642@gmail.com>
 <9bcb1dee-314e-4366-9bad-88a47d516c79@redhat.com>
 <5dc09930-e137-47ba-a98f-416d3319c8be@gmail.com>
 <ff285199-5f29-44b8-81df-891196eeca3d@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ff285199-5f29-44b8-81df-891196eeca3d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2025 13:29, David Hildenbrand wrote:
> On 05.08.25 14:19, Usama Arif wrote:
>>
>>
>> On 05/08/2025 11:36, David Hildenbrand wrote:
>>> On 04.08.25 17:40, Usama Arif wrote:
>>>> The test will set the global system THP setting to never, madvise
>>>> or always depending on the fixture variant and the 2M setting to
>>>> inherit before it starts (and reset to original at teardown)
>>>>
>>>> This tests if the process can:
>>>> - successfully set and get the policy to disable THPs expect for madvise.
>>>> - get hugepages only on MADV_HUGE and MADV_COLLAPSE if the global policy
>>>>     is madvise/always and only with MADV_COLLAPSE if the global policy is
>>>>     never.
>>>> - successfully reset the policy of the process.
>>>> - after reset, only get hugepages with:
>>>>     - MADV_COLLAPSE when policy is set to never.
>>>>     - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>>>>     - always when policy is set to "always".
>>>> - repeat the above tests in a forked process to make sure  the policy is
>>>>     carried across forks.
>>>>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +FIXTURE_VARIANT(prctl_thp_disable_except_madvise)
>>>> +{
>>>> +    enum thp_enabled thp_policy;
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, never)
>>>> +{
>>>> +    .thp_policy = THP_NEVER,
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, madvise)
>>>> +{
>>>> +    .thp_policy = THP_MADVISE,
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, always)
>>>> +{
>>>> +    .thp_policy = THP_ALWAYS,
>>>> +};
>>>> +
>>>> +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
>>>> +{
>>>> +    if (!thp_available())
>>>> +        SKIP(return, "Transparent Hugepages not available\n");
>>>> +
>>>> +    self->pmdsize = read_pmd_pagesize();
>>>> +    if (!self->pmdsize)
>>>> +        SKIP(return, "Unable to read PMD size\n");
>>>
>>> Should we test here if the kernel knows PR_THP_DISABLE_EXCEPT_ADVISED, and if not, skip?
>>>
>>> Might be as simple as trying issuing two prctl, and making sure the first disabling attempt doesn't fail. If so, SKIP.
>>>
>>> Nothing else jumped at me. Can you include a test run result in the patch description?
>>>
>>
>> Instead of 2 prctls, I think doing just the below should be enough:
>>
>> diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
>> index 93cedaa59854..da28bc4441ed 100644
>> --- a/tools/testing/selftests/mm/prctl_thp_disable.c
>> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
>> @@ -236,6 +236,9 @@ FIXTURE_SETUP(prctl_thp_disable_except_madvise)
>>          if (!self->pmdsize)
>>                  SKIP(return, "Unable to read PMD size\n");
>>   +       if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL))
>> +               SKIP(return, "Unable to set PR_THP_DISABLE_EXCEPT_ADVISED\n");
>> +
>>          thp_save_settings();
>>          thp_read_settings(&self->settings);
>>          self->settings.thp_enabled = variant->thp_policy;
> 
> Then probably best to remove the
> 
> ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL), 0);
> 
> From both test functions?
> 
> You can consider doing the same in patch #5.
> 

Yes makes sense, Thanks!

