Return-Path: <linux-fsdevel+bounces-56766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D902B1B65E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C504D3B7919
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F53727702B;
	Tue,  5 Aug 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoFDAz9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C721C16B;
	Tue,  5 Aug 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403985; cv=none; b=mOUbTRor4LFYG2Y+cIiRBKbRWTCQL/jpGm2I1AQo3qxmE/tHUgstzVKk3GvksTQc4jEXyc/MGSgD766vONluUls9hDHA6/UBc1lMavkJ/Kodeu5P8gTZ0MZq+vK7iu0FcQX93u+qYmVNkL+93G0DOkvN85hYSK1nbN6OdBsNdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403985; c=relaxed/simple;
	bh=FwtBnLDhwV/1DNOAles45j9etEv98yJEYZEYdpI4Odk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzb7YGcpogrhYdkXMgcwhW775AgpMNPZfVtV5nrjxEW9YlFrHWKTIb5P5LAbqtLtr1dqjNOKkbIWWv/D0uMusRtzV9vy7rWzcwtexiJnmgJKroVLU0QQpqTB5vl2CYehQFlmvw7VSUdkFTemH18uf7gAk5vgHnE/C+avB/cgrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoFDAz9e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so40896725e9.3;
        Tue, 05 Aug 2025 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754403982; x=1755008782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ry5Dfhvc2U44AmB7UaxhnygbevOBppFjf0G6WuFTeXE=;
        b=OoFDAz9e6rNUeSgtywoSv1XGmF7US4NORzRHyoziq1vl/6vHc9QI385UGurq6khDDn
         ruEtsqnwXgTVekuJiJ1NKgKWBipLc13lC/ej6+YPSAG3pD+S2SvRB0VzY1g2fHL7XdG9
         N9j0Wsk1pDC5Qd37dOxpVCG+6yVArqs00csMObQYsaTB2YDbLaTxBBThz14vlNJwwGty
         5CUewGeP6KU7A5ELplbCK2RHTOKogYSgl1qhjHYTXZG5Wz9ASWzZ8F2RryTYdiaMqCUu
         ikBZzIGZOBcFytMznPb26Xi2k7yaww+pYhdbjnBtJMZasP/k7UBwVGTrC/YPTbFCYGwS
         XGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403982; x=1755008782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ry5Dfhvc2U44AmB7UaxhnygbevOBppFjf0G6WuFTeXE=;
        b=QHO8tayQ52TD6G5hjjVpaBmLXVoHHno3RLy87P5Dxn7OhoDHcX7D/VAqXUqqEuf870
         kR3cb3eWiAyEsrJnku/zwFb7R/iPAbW9f/CdqT14d2aAFNXMYeHYaacxqcaWCi5xxul6
         kHCHVG2Y+hbqXFVPfZnpnJisJwMc+R7ZHHW+2mHXxSo9mJRftmgPbkFMIuPe+EZrLJca
         d1OS4l8SoTeuiyNt5kOyskJhrwJ1HDHuhlyipxoxJjvWOuHAz9MFEMNNu7dam1JFXe8G
         R8LMSmR/NljmO36kewZUUgX2Jco9Qe8TpbAX9f/inqUBD/5FMvRvsDfHDlF65uru3lht
         Iviw==
X-Forwarded-Encrypted: i=1; AJvYcCUw0p0vUDqWn0fj1zfb3HnBKcgN/nUgGW8zVdiS81CSnZmGLltKSlvPUPtmg5+a7yMEOFKo62/lQaR/quF7@vger.kernel.org, AJvYcCVKO3p82kVQ9zOGrsEpr4RdzSJjGu6ns8n7sZDCrT46qL+KWtZ79zbZ06YMAfgQ057s/iIvTz2aOFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHd/DSRQj8ZyiYuH05CMuVnDP53uWhf/6MoqRccJrYUJ/Qfdca
	Xj9XAjKjNGKy5oW1B2Nvb+UgTzkAyysZDIQEikrB0dQMF8i8eGC+EwNQ
X-Gm-Gg: ASbGncus7ApoZ1Gyfk4d3LYo4/ho7V90hU9/jPDyYdTwzZnOYg/sA5bxA+K8UFNUoOI
	UAgiRdhMIlOGlCcdSOvCWZkOrTl16hh7LwCqmcg5hREd5JDH+nnD6MWskZSBHIa5WsPvPVeWjxx
	rbTnC4+IVM3HRfJd/FZ/mYVdg126YiPpRVwqtGTFwZl7JmAeM1YMpi7dzknuO5O2D6CItNDMAhr
	i0W6UPemwOzwD8nLsdcBMUZwJnxll1KhZ2Dz8AVDxmoYdq0pNjuIvZ/EWr9yBtdSvp4+hHPTmNu
	BT89lYQhan/GQa6MWEnroMbQWGI+IrX4RSPlwmm7Ts5120TFXJZs1OHmzy6UbqAJtIhmKT1D+MA
	wQBYIo5mAUusEQEMXc6LPyOdU+sqgedRSpbSoU9lIks5UovYn1RyyMV/nNWmpGlwUZTrsrve20f
	1k/RsOww==
X-Google-Smtp-Source: AGHT+IH9EpTWoImUYJcCr9my5UTeO92YxiB5fFdInePVkEEtZ/CAl5u4VV1vdMFHKZwzOROQeDzq4Q==
X-Received: by 2002:a05:600c:470d:b0:459:d709:e5a1 with SMTP id 5b1f17b1804b1-459d709e91emr78434045e9.6.1754403981789;
        Tue, 05 Aug 2025 07:26:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::6:98ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5c40eb1sm1458615e9.6.2025.08.05.07.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 07:26:21 -0700 (PDT)
Message-ID: <955ed533-dd7e-45e6-a2cb-f379a5878ef7@gmail.com>
Date: Tue, 5 Aug 2025 15:26:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] selftests: prctl: introduce tests for disabling
 THPs completely
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
 <20250804154317.1648084-6-usamaarif642@gmail.com>
 <66c2b413-fa60-476a-b88f-542bbda9c89c@redhat.com>
 <a22beba8-17ae-4c40-88f0-d4027d17fdbc@gmail.com>
 <e608f766-8750-4781-bd23-8fa95b6d683a@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <e608f766-8750-4781-bd23-8fa95b6d683a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2025 13:55, David Hildenbrand wrote:
> On 05.08.25 14:46, Usama Arif wrote:
>>
>>
>> On 05/08/2025 13:39, David Hildenbrand wrote:
>>>> +FIXTURE_SETUP(prctl_thp_disable_completely)
>>>> +{
>>>> +    if (!thp_available())
>>>> +        SKIP(return, "Transparent Hugepages not available\n");
>>>> +
>>>> +    self->pmdsize = read_pmd_pagesize();
>>>> +    if (!self->pmdsize)
>>>> +        SKIP(return, "Unable to read PMD size\n");
>>>> +
>>>> +    thp_save_settings();
>>>> +    thp_read_settings(&self->settings);
>>>> +    self->settings.thp_enabled = variant->thp_policy;
>>>> +    self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
>>>
>>> Oh, one more thing: should we set all other sizes also to THP_INHERIT or (for simplicity) THP_NEVER?
>>>
>>
>> hmm do we need to? I am hoping that we should always get the PMD size THP no matter what the policy
>> for others is in the scenario we have?
> 
> Assuming 64K is set to "always", couldn't it mislead us in the "madvise"/"never" test cases in some scenarios?
> 

I tried it with 64K to always and seems to be ok. check_huge_anon checks AnonHugepages from smaps which
only indicates the pmd mapped THPs only. So I think should be ok?
Happy to set them to never and the change is probably something simple like below (untested), but
just trying to understand better the need for it.

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index 4b072d4ecc30..ee692c397835 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -142,6 +142,8 @@ FIXTURE_SETUP(prctl_thp_disable_completely)
        thp_save_settings();
        thp_read_settings(&self->settings);
        self->settings.thp_enabled = variant->thp_policy;
+       for (int i = 1; i < sz2ord(self->pmdsize, getpagesize()); i++)
+               self->settings.hugepages[i].enabled = THP_INHERIT;
        self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
        thp_write_settings(&self->settings);
 }
@@ -244,6 +246,8 @@ FIXTURE_SETUP(prctl_thp_disable_except_madvise)
        thp_save_settings();
        thp_read_settings(&self->settings);
        self->settings.thp_enabled = variant->thp_policy;
+       for (int i = 1; i < sz2ord(self->pmdsize, getpagesize()); i++)
+               self->settings.hugepages[i].enabled = THP_INHERIT;
        self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
        thp_write_settings(&self->settings);
 }
 


[root@vm7 vmuser]# echo always >  /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled                                                                                                                                                                                                                        
[root@vm7 vmuser]# ./prctl_thp_disable                                                                                                                                                                                                                                                                              
TAP version 13                                                                                                                                                                                                                                                                                                      
1..12                                                                                                                                                                                                                                                                                                               
# Starting 12 tests from 6 test cases.                                                                                                                                                                                                                                                                              
#  RUN           prctl_thp_disable_completely.never.nofork ...
#            OK  prctl_thp_disable_completely.never.nofork
ok 1 prctl_thp_disable_completely.never.nofork
#  RUN           prctl_thp_disable_completely.never.fork ...
#            OK  prctl_thp_disable_completely.never.fork
ok 2 prctl_thp_disable_completely.never.fork
#  RUN           prctl_thp_disable_completely.madvise.nofork ...
#            OK  prctl_thp_disable_completely.madvise.nofork
ok 3 prctl_thp_disable_completely.madvise.nofork
#  RUN           prctl_thp_disable_completely.madvise.fork ...
#            OK  prctl_thp_disable_completely.madvise.fork
ok 4 prctl_thp_disable_completely.madvise.fork
#  RUN           prctl_thp_disable_completely.always.nofork ...
#            OK  prctl_thp_disable_completely.always.nofork
ok 5 prctl_thp_disable_completely.always.nofork
#  RUN           prctl_thp_disable_completely.always.fork ...
#            OK  prctl_thp_disable_completely.always.fork
ok 6 prctl_thp_disable_completely.always.fork
#  RUN           prctl_thp_disable_except_madvise.never.nofork ...
#            OK  prctl_thp_disable_except_madvise.never.nofork
ok 7 prctl_thp_disable_except_madvise.never.nofork
#  RUN           prctl_thp_disable_except_madvise.never.fork ...
#            OK  prctl_thp_disable_except_madvise.never.fork
ok 8 prctl_thp_disable_except_madvise.never.fork
#  RUN           prctl_thp_disable_except_madvise.madvise.nofork ...
#            OK  prctl_thp_disable_except_madvise.madvise.nofork
ok 9 prctl_thp_disable_except_madvise.madvise.nofork
#  RUN           prctl_thp_disable_except_madvise.madvise.fork ...
#            OK  prctl_thp_disable_except_madvise.madvise.fork
ok 10 prctl_thp_disable_except_madvise.madvise.fork
#  RUN           prctl_thp_disable_except_madvise.always.nofork ...
#            OK  prctl_thp_disable_except_madvise.always.nofork
ok 11 prctl_thp_disable_except_madvise.always.nofork
#  RUN           prctl_thp_disable_except_madvise.always.fork ...
#            OK  prctl_thp_disable_except_madvise.always.fork
ok 12 prctl_thp_disable_except_madvise.always.fork
# PASSED: 12 / 12 tests passed.
# Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

