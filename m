Return-Path: <linux-fsdevel+bounces-56744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F12B1B334
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E00A64E1474
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF626F44D;
	Tue,  5 Aug 2025 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv1FKDLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AA1D7E5B;
	Tue,  5 Aug 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396381; cv=none; b=bTLrdoKD4EARxzVq+vn+IyZGdtlm3pdHIhdDcmS7gzCMQ7WrpHVZLA3hyLgpay//Dms9wMpgLxpKSCW2MREkMdgjyEmtlLzxD8w9sPuy+9tI84OivxzToiT5WuZC9byLqy2+h4tp3WQiOass8sMU7Abev19VJLDPG3UoB8aLdi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396381; c=relaxed/simple;
	bh=N13uvOrepqfMZQbmpLn1iC6irvmEOPDeT0bCrz/pe54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNECrbjEBAizlSDfq7MHMpDQzGQFrw6blRRmrHtMkrENvmerZa1vihPHfsHBxcDMYHUbNAbJaSnuGc3i/1z1Np+Mu7MNH88w2QFLI7bVcvkR38f98dFWJanTQUJmyOc52Ee1Qpv7hRzn2HbGyYAt79mka34RxqId0VV00F98nJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv1FKDLP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso3407235e9.2;
        Tue, 05 Aug 2025 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754396378; x=1755001178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78HKa+a6ttLBuyJSrEIeZC/Gs73gWB6HpOEqp8Bqj2U=;
        b=Gv1FKDLPqrpXOQ2SXZEEqAitA/0wU19sraaehnv/tnEJkYqurSutSaOIIfhoRJ4ZBk
         /DI0VlFHl62pRk/8Mhxw1yFHt5EBoJ5Of0BBN9GGPjyPsONYLq2pTn7cAoqEzNFpYDmH
         lF21pOvELZT4n4lnbP84NLxWXDl+LFfXGTfC0YqpIrgWzfGDVGcRnjFVNmopntdeJsMM
         s9qxzMRhY9wK5Fy0MS6cTtvN5+Q121J1s+cW85U0xAIpYiZKbandudZxTrUz6kZ/Cz7J
         3pFH9oZvD0AdD5y69bsnn3qG1Oyy6lC1hBmLo4eaB6hnHQgTz1Xf2teE7IS69jWgab+K
         NkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754396378; x=1755001178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78HKa+a6ttLBuyJSrEIeZC/Gs73gWB6HpOEqp8Bqj2U=;
        b=Zrs32v7inT7dkHWyRc4bot7zIC9Ub5PjVr1VSjrPUSDjjDavFHQq6fhVt3gLs9rs2A
         RdK1UvjyH/cJmgP1s5KGeMB3FCVQx3V3yjfC3vwGir115oivf6fJtHYkMwTO5ZXQi1Yg
         A2xiiR694O37Vg5Rei8d3ixBXivfaTyr9qzPIIM7MzrK6LyoQpLWCognBXehWK8rfrlS
         6X8j5nbjpJymAHMFOlyP5id+qJA0iNHMBlGGBhokflvJqK6eDId0eZzA4jNI60zXxKto
         ay2/MeZ0x5yxFzCdOC+eV7IuGaeVmDrTO5cxkBL95VXBgsJdeGY9bR+NtgYNhL3kivgp
         OGxw==
X-Forwarded-Encrypted: i=1; AJvYcCW8VdZpBFneNlcLdz+eVKfZszwJyRoLIhJ+1kAUqESz+Zu9ZS7b9GMWK+By7BAbXnY242l8ObLRmHsatYNy@vger.kernel.org, AJvYcCX+NlFBwoImm4GZ5x88pKISHTSK+829cPOtFg24Wf1ayuwiqgrpggSFTvjE7stnkZep8bGwwBmK6zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU++iTQ0Gy23z/lxot2YQ8P12PgIo45N0Iahrr3g5N73DlXwcy
	TYpwhSY/psI6jpskpdve9q/IhlhPX7sIfC9ZMV4/rMBc5pOPDriJ/SL7
X-Gm-Gg: ASbGnctBACAvl3gvw+lfTpC4GlklAhflOaaotlrprwcqW9BIimpeQl70+I+kP6R8KXm
	HXeUWXS/pX/Uv372i4bnruZVep74IhFYvSpgsAr274YW1xr28o28K65kCkuvw4XsfajkcCrrq6N
	47NYErmQ7n99JRLbs759QvRhYZOnRsGnj9CuIDXOT3nUa1MFY73i7izq65rTa+SkKhv/a74ZtUs
	FWNn1jAiGO08aifTiqv6yDJteGIDlTcFaEqjcOd6pgTJ8MVX3V3jnGrE8EOqz5pSwR6jagK6yyq
	nFsSF3PqSwd5H5CCpr4IARUdNGZ2PHvXf5XFiMTdTtAsoNvMm3qcjcHYHabB5jT8wPlMFe422oP
	fc9SzkFWSMR9In3fqphDSBfPxvFL0GbnczQIlYvs+ZALHHShDI//+afjHHQgd1DFYKQjyh+vUin
	S6YEPC8w==
X-Google-Smtp-Source: AGHT+IHTS5vcJBuFiQHZY0njOLPtazgxkIpzBiBUdWqiYuGyDBX2gvjL41xBxww/IULLy/qEhfp7NQ==
X-Received: by 2002:a5d:5f4d:0:b0:3a5:2ef8:34f9 with SMTP id ffacd0b85a97d-3b8d94b9fb6mr9421147f8f.27.1754396377752;
        Tue, 05 Aug 2025 05:19:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::6:98ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453333sm19744940f8f.45.2025.08.05.05.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:19:36 -0700 (PDT)
Message-ID: <5dc09930-e137-47ba-a98f-416d3319c8be@gmail.com>
Date: Tue, 5 Aug 2025 13:19:32 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <9bcb1dee-314e-4366-9bad-88a47d516c79@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2025 11:36, David Hildenbrand wrote:
> On 04.08.25 17:40, Usama Arif wrote:
>> The test will set the global system THP setting to never, madvise
>> or always depending on the fixture variant and the 2M setting to
>> inherit before it starts (and reset to original at teardown)
>>
>> This tests if the process can:
>> - successfully set and get the policy to disable THPs expect for madvise.
>> - get hugepages only on MADV_HUGE and MADV_COLLAPSE if the global policy
>>    is madvise/always and only with MADV_COLLAPSE if the global policy is
>>    never.
>> - successfully reset the policy of the process.
>> - after reset, only get hugepages with:
>>    - MADV_COLLAPSE when policy is set to never.
>>    - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>>    - always when policy is set to "always".
>> - repeat the above tests in a forked process to make sure  the policy is
>>    carried across forks.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
> 
> [...]
> 
>> +FIXTURE_VARIANT(prctl_thp_disable_except_madvise)
>> +{
>> +    enum thp_enabled thp_policy;
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, never)
>> +{
>> +    .thp_policy = THP_NEVER,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, madvise)
>> +{
>> +    .thp_policy = THP_MADVISE,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, always)
>> +{
>> +    .thp_policy = THP_ALWAYS,
>> +};
>> +
>> +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
>> +{
>> +    if (!thp_available())
>> +        SKIP(return, "Transparent Hugepages not available\n");
>> +
>> +    self->pmdsize = read_pmd_pagesize();
>> +    if (!self->pmdsize)
>> +        SKIP(return, "Unable to read PMD size\n");
> 
> Should we test here if the kernel knows PR_THP_DISABLE_EXCEPT_ADVISED, and if not, skip?
> 
> Might be as simple as trying issuing two prctl, and making sure the first disabling attempt doesn't fail. If so, SKIP.
> 
> Nothing else jumped at me. Can you include a test run result in the patch description?
> 

Instead of 2 prctls, I think doing just the below should be enough:

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index 93cedaa59854..da28bc4441ed 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -236,6 +236,9 @@ FIXTURE_SETUP(prctl_thp_disable_except_madvise)
        if (!self->pmdsize)
                SKIP(return, "Unable to read PMD size\n");
 
+       if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL))
+               SKIP(return, "Unable to set PR_THP_DISABLE_EXCEPT_ADVISED\n");
+
        thp_save_settings();
        thp_read_settings(&self->settings);
        self->settings.thp_enabled = variant->thp_policy;



Will include the test run result in the last patch description. Just adding it here as well:

./prctl_thp_disable
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

