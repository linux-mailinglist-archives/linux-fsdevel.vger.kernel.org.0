Return-Path: <linux-fsdevel+bounces-56283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6972B15523
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F437A4F02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45FB280312;
	Tue, 29 Jul 2025 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bouHgjYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E943AA4;
	Tue, 29 Jul 2025 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827237; cv=none; b=EdEE2I2rn+7h/uzhMt/NM1rJD7EtedI6w97K3tDEbUGZLIU0gi+xBRwuiGWo2PnJoXx9m/uusMiemEuQvcR7jitrLYpv+0bL+wObVb1hm39BumhECKz1M6LVIQ6ktxUcdwVtRlbki9xQN4Z2SgtBexBeI+OWi3wcFsHZgraiO3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827237; c=relaxed/simple;
	bh=KBbRGtPvztUsLVDX9J8vosq8mYvwYMawegdfU9NhLaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4kjayClBJbF1PjgtBQOSlTzOPeVGYqNJAeilJW9HFpVJzniogqD/4qeuqYxUnfzBuHXuBqMV/U108fRCDy7TJIQ0nS6Znl7RhpY+uHcfdU2KfdUrNjAA/98cOH5DSK76zwQJmiVHo5N9cb9mbh1g1uT11vRNryWMLFxcVQ5G00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bouHgjYu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45610582d07so39406845e9.0;
        Tue, 29 Jul 2025 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753827233; x=1754432033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4TdMm0dqbyPQgLDNL4WQ//dsNOz2sMfofhnU8OFQgg=;
        b=bouHgjYusjuU2nqbWe3jzfq73PHAS18tRZSAkczRUEZD/rX/6mNbnCSqC7NwBYod8U
         HMzYiwCdLYIw+MsfNbgv6NgJyzwO2DurxoecYHArf4byJJ+yF7ptvWLV4tvsdVC2LI+f
         m+GGwiX+9wlCi3/5EXttwCxJWMlbOmXrqRQftvj3LtecCkcYNHVU114qmZjeOEhRpVhJ
         0ROTl41Fy4BPwGpf+O8BWBv+Usp4y+J40+XaPTAq8VZLqfOfbx1Ok2/jfGwTmK0YKGjg
         rSYatYo7qGVuhxivshv5kWJOeFhaBjZ5E3zjVijojuVudqWQDuRP+9EjXEd/wcF5ZjrD
         DwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753827233; x=1754432033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4TdMm0dqbyPQgLDNL4WQ//dsNOz2sMfofhnU8OFQgg=;
        b=EMurT+49UKjyxWFsqMDD34VCC2aFXz5GTq2ExQsx6gCv9KbldJmWELcmTRMAsG1kh8
         ohcsMNI8Vx7wtl4soakKtOIgzQ0zApHlvOl/L+KzVRkhtNSlYA3LuTnUSOzp+bH513ZM
         dXHNYtrRhtmHSUWGXUV14wOU2LIUdk8JDaDkzQVPP6U+rGfKL6pe2oIwisboNgvICd0/
         BTR5X0Vfn46AMYX8HWUEWg9HZnUxJGXZkv1m0wbzKT5IjqdtTbKYg9J29P2ZZU31O8AD
         Qgjy1oiUez9eQeMESwWfokQs4Cw6wV6ilN+uFp09/jkqpOD9rZJIZVnaAKHReOZeFJ4q
         TFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL3koKmRMQVnCi3zXmZZgZd6zeqw2kz5CwHzxEGjWBn9bhTd6LRsSAz+mlqVdpykoxjhe4exRhY60=@vger.kernel.org, AJvYcCXBtDQv2OPhnSV4T6QCTv+YrkIZwQM05urErSy3Ebsvoj8zm40nApVa8OKyEBHkBu0rb/kcUac03jfcWHTH@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0SmH+S1fG1okF2A67fMAlBLDNjs3BwiW9Il/m4WcUD9bnuKV
	cjml5RF4pBdF0e2J/gNl73M6l5XcgMrw1pr43OrvLFqWsRi8Tfas0ssm
X-Gm-Gg: ASbGncvoQkeoJIjsoLSVV9l7vKxwFsSsyXgMFOkQy5UppFRikzQo2gbfGk7qLVflf1/
	lLp4yCLm1vMfz5tuuKW05uMOyYnWXwr5x9jgCXzGxR5NfXXWP7HEMt16z1lBHw+hvuxsn9+dYlj
	BDPuPZy3eSXkt+tY/4YK6bYHD4uT/s78JRHoYjeS0ASxQT6BEeRsWvhMSwRpNjYiuBjqLiScDUW
	V6KKKzZebtyNPr8qj0EuGwHEe8Mb+HcjSj8stflWLpkk/d0opCu1xLm/Jy8Mv3ZBBMGGSQFPu8X
	/kXozSmULGaRcoNY+UzTEwA1Z/IvCt8OuZy3suObzKCv/vtnoMUBp+gC3Bi0PiJ1lf1A8EJw7HW
	I11uFypbwi2K6WtGoe07Vlo5eu4r6b0ZaWaGPCY8NXfkj9PFuNXpuk/SHLabUf2zP8MBQsWHbkA
	T28zVS1hLr55SIEDynM/0d
X-Google-Smtp-Source: AGHT+IEeWIQxoNPjyhb0qgajHm83bwS2o4UYVKQz54yvj8B5BNWBgnOWxAGCs5O9lSHAl/LE7QHulA==
X-Received: by 2002:a05:600c:1d22:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-45892b95320mr11780725e9.4.1753827232385;
        Tue, 29 Jul 2025 15:13:52 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4? ([2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953778c9sm2629375e9.14.2025.07.29.15.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 15:13:51 -0700 (PDT)
Message-ID: <4dc95e54-e0ef-4919-973a-748845897ef9@gmail.com>
Date: Tue, 29 Jul 2025 23:13:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] selftests: prctl: introduce tests for disabling THPs
 completely
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
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
 <20250725162258.1043176-5-usamaarif642@gmail.com>
 <b9c72ab9-9687-4953-adfe-0a588a6dd0f7@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <b9c72ab9-9687-4953-adfe-0a588a6dd0f7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> +
>> +    self->pmdsize = read_pmd_pagesize();
>> +    if (!self->pmdsize)
>> +        SKIP(return, "Unable to read PMD size\n");
>> +
>> +    thp_read_settings(&self->settings);
>> +    self->settings.thp_enabled = THP_MADVISE;
>> +    self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
>> +    thp_save_settings();
>> +    thp_push_settings(&self->settings);
> 
> push without pop, should that be alarming? :)
> 
> Can we just use thp_write_settings()? (not sure why that push/pop is required ... is it?)
> 

Thanks for the reviews!
Ack on the previous comments, I have fixed them and will include in next revision.
Yes, I think we can replace thp_push_settings with thp_write_settings.

For this, I actually just copied what cow.c and uffd-wp-mremap.c are doing :)

You can see in these 2 files that we do [1]
- thp_read_settings / thp_save_settings
- thp_push_settings

Than we run the experiment

and at the end we do [2]
- thp_restore_settings

i.e. there is no pop.

I think we can change the thp_push_settings to thp_write_settings in [3] and [4] as well?
I can fix and test it if it makes sense. It should prevent people like me from making a
similar mistake when they just copy from it :)

[1] https://elixir.bootlin.com/linux/v6.16/source/tools/testing/selftests/mm/cow.c#L1884
[2] https://elixir.bootlin.com/linux/v6.16/source/tools/testing/selftests/mm/cow.c#L1911 
[3] https://elixir.bootlin.com/linux/v6.16/source/tools/testing/selftests/mm/cow.c#L1886
[4] https://elixir.bootlin.com/linux/v6.16/source/tools/testing/selftests/mm/uffd-wp-mremap.c#L355


>> +}
>> +
>> +FIXTURE_TEARDOWN(prctl_thp_disable_completely)
>> +{> +    thp_restore_settings();
>> +}
>> +
>> +/* prctl_thp_disable_except_madvise fixture sets system THP setting to madvise */
>> +static void prctl_thp_disable_completely(struct __test_metadata *const _metadata,
>> +                     size_t pmdsize)
>> +{
>> +    int res = 0;
>> +
>> +    res = prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL);
>> +    ASSERT_EQ(res, 1);
>> +
>> +    /* global = madvise, process = never, we shouldn't get HPs even with madvise */
> 
> s/HPs/THPs/
> 
>> +    res = test_mmap_thp(NONE, pmdsize);
>> +    ASSERT_EQ(res, 0);
>> +
>> +    res = test_mmap_thp(HUGE, pmdsize);
>> +    ASSERT_EQ(res, 0);
>> +
>> +    res = test_mmap_thp(COLLAPSE, pmdsize);
>> +    ASSERT_EQ(res, 0);
>> +
>> +    /* Reset to system policy */
>> +    res =  prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL);
>> +    ASSERT_EQ(res, 0);
>> +
>> +    /* global = madvise */
>> +    res = test_mmap_thp(NONE, pmdsize);
>> +    ASSERT_EQ(res, 0);
>> +
>> +    res = test_mmap_thp(HUGE, pmdsize);
>> +    ASSERT_EQ(res, 1);
>> +
>> +    res = test_mmap_thp(COLLAPSE, pmdsize);
>> +    ASSERT_EQ(res, 1);
> 
> 
> Makes me wonder: should we test for global=always and global=always?

Do you mean global=madvise and global=always?> 
> (or simply for all possible values, including global=never if easily possible?)
> 
> At least testing with global=always should exercise more possible paths
> than global=always (esp., test_mmap_thp(NONE, pmdsize) which would
> never apply in madvise mode).
> 

lol I think over here as well you meant madvise in the 2nd instance.

I was just looking at other selftests and I saw FIXTURE_VARIANT_ADD, I think we can
use that to do it without replicating too much code. Let me see if I
can use that and do it for never, madvise and always. If it doesnt help
there might be some code replication, but that should be ok.

Thanks!





