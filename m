Return-Path: <linux-fsdevel+bounces-57916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6028EB26B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CB2A05EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328022577C;
	Thu, 14 Aug 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+BzqK/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579A1B4248;
	Thu, 14 Aug 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186084; cv=none; b=cv12lddJ1mNSLk8a37xMIufIq1Qi/V4/2UDVaL1j0ewti74CbyyPZiIEvwhJKbYOMaxfimlB6okwVpLqc1pLiFxXV7B6o+ZAl6XbZCPCLluT6PqC6VEYqmwBypS2nl4MUibMngTIH8ZDBL2MWOwNig3dg0ByHuu4rq054zQNYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186084; c=relaxed/simple;
	bh=E1acSe5dsxNOq0OBgSQhYrtNCDT4l3dYQWs9asGQvIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DartpbSW9BLj1b/reKT/GWYIKfMtpoK72faQbI63FjVNcWJOMjqEur+wUGK3zL9T0l5jn26HBpB6R9o5x4O0EHgUEQYXT4kV83tWS+mdvq9vkiypXp1MYcG+Bz3ewIjLSprfUdijLsl1Beii+S1+WQ/iWIJa7LhRVAf4zOVjuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+BzqK/1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b065d58so7137745e9.1;
        Thu, 14 Aug 2025 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186081; x=1755790881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Snu4TW99vD6eKnQ20z+tTcXAXQFZQCSrz3K4OLsk2tI=;
        b=R+BzqK/1g0U47mgS37WWJhTx7F8jR0v+1rllrkmT2fNAjwitf1IqCtibjFCBpnn4cX
         0FjvoLAAEWLYAeACJWaNHxEg06zhsyU7ScwRgf/MAMgFNxGvztsfvlc2By5QoCQIepbY
         cgQ/6xp5nbHeZAY1w7UwO529tiwZ8mnrvuracEco1UaXt6CDRAadvc9ckt3PTjcN+59k
         0N3JwisRobY2aJPCcuRlGdMJFxU3JCpMoZhinVucQdYNx6CaAIdsJsrzvIZxmnG+VkMB
         NSCIMeoKuhAhUn5a6LjoffgPInuNS7YcEJmG/KDegX699OyxLzaXQ8WAofUomsTsyxea
         C/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186081; x=1755790881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Snu4TW99vD6eKnQ20z+tTcXAXQFZQCSrz3K4OLsk2tI=;
        b=DGNbKNeJZaTxSS4GbMAwao1raxi+G8YI5PR9rmz1XZbeEPFXjUUhFrbAQ8l1AHbvbq
         XQ98yweQrHlXcwBkUiEN0vuqsEfmhIanGLp6TqnIdCr2Q6CImfbBdnDkluqHuIlnA+/B
         OFEgDZFzX6ds2nQaGgsxGMc63a3vlENJfPqrXCUpykf+jhHp5R7IVmxk5e4eKhLr8KK1
         /3fWeMkMF3PbtZr9E1j0+6Pah7QGrXZvRDUNNcvXnVlNrCyzE4jM8z0yUAJFNr4J7zQv
         PZCk8udwQhtfmbSMaxiWZQdknPgLMsAeTGO5LdhbCCY0nbYTFaHLQWcqNtPCkifcIseT
         sK8g==
X-Forwarded-Encrypted: i=1; AJvYcCU8TX9zamlTSBYFQ7SWkOEY2qBrq+OJ4SmFG+xNtKVnD6V7ieQnXREyT+nNQfEq92NYSuvxlWIWLTmqA5Ca@vger.kernel.org, AJvYcCVodA4HP/oqzRfybQOpG16cmq1KDNfFMoYV4AOkqokWrcJs/hR3jn/rMRduL9kF119ex/BA0bqY8pI=@vger.kernel.org, AJvYcCXvG/d9HnUBWSfU3WK9TZhjeffnOMw2zXYtfOLTZNs2QF4RkT0hRPSZTuSqLwLnIoG8Cnv1YOUsERYgom3clA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEg9Rw4DE6TCS4gfoyY8BmF56me3BCfUGrHZU3eD7SmJPm/Qth
	njdqstiK2FaeZze6zwnl3RU+LO5J8t7iDAfRZ2SJUI60insKrGwIONvR
X-Gm-Gg: ASbGncsWiwSHkAJRD0WnrxWLyERwdcgi+8n6ySftT6nYOr8b4anvezVOHcYX56WUQC7
	EoJbqFgGS5M1F8XAE02UrIEcpcpmyR8iFM3XOrOIzaTeBrLxXA7eooVrBaBVMyt/pMiu0hw06hg
	q2o9MJ4m9o6VP/lRks7sJyP/Jq6L3ghheoT5IgtcDkeDSAi2gwObLnpc/SGQcB8bK3Z7jGGtXQn
	UGr5bqJUZbpxB8C63iZkL1xg4SRMwKvWrj7+FF1L111qW5oXq0THRAyGJq+llNHqeKjUvlJMPp4
	3j9Ql5XZgqKAw+X5KgZ+wvQUqaKRm8y8j5KvS+jtGvDf+X/nNCvlcGt/aOv3pmPVmbyUjkyt6Eq
	/5oMnec4iO5YvHGE4EbQP0xAwo/wdaTJ1sOCy7mV1Az+9VLBUdLhdgrImHMsOpOeahVA6eTjn+q
	yEkj/iaA==
X-Google-Smtp-Source: AGHT+IFR6kyS0MwCFXecgpL+CkpUW4A1Qwi/ZDuTfTRfuJxCm+OLfkLiLdmsUzftuDIX9sgmP/813w==
X-Received: by 2002:a05:600c:4e87:b0:458:f70d:ebdd with SMTP id 5b1f17b1804b1-45a1b646ab1mr37271215e9.16.1755186080861;
        Thu, 14 Aug 2025 08:41:20 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:8979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b7c18d7sm16194935e9.2.2025.08.14.08.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:41:20 -0700 (PDT)
Message-ID: <0879b2c9-3088-4f92-8d73-666493ec783a@gmail.com>
Date: Thu, 14 Aug 2025 16:41:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Mark Brown <broonie@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
 <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
 <5dce29cc-3fad-416f-844d-d40c9a089a5f@lucifer.local>
 <b433c998-0f7b-4ca4-a867-5d1235149843@sirena.org.uk>
 <eb90eff6-ded8-40a3-818f-fce3331df464@redhat.com>
 <47e98636-aace-4a42-b6a4-3c63880f394b@sirena.org.uk>
 <1387eeb8-fc61-4894-b12f-6cae3ad920bd@redhat.com>
 <620a586e-54a2-4ce0-9cf7-2ddf4b6ef59d@sirena.org.uk>
 <de8da320-3286-4639-8f61-b99d1186ca41@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <de8da320-3286-4639-8f61-b99d1186ca41@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/08/2025 16:02, Lorenzo Stoakes wrote:
> On Thu, Aug 14, 2025 at 02:08:57PM +0100, Mark Brown wrote:
>> On Thu, Aug 14, 2025 at 02:59:13PM +0200, David Hildenbrand wrote:
>>> On 14.08.25 14:09, Mark Brown wrote:
>>
>>>> Perhaps this is something that needs considering in the ABI, so
>>>> userspace can reasonably figure out if it failed to configure whatever
>>>> is being configured due to a missing feature (in which case it should
>>>> fall back to not using that feature somehow) or due to it messing
>>>> something else up?  We might be happy with the tests being version
>>>> specific but general userspace should be able to be a bit more robust.
>>
>>> Yeah, the whole prctl() ship has sailed, unfortunately :(
>>
>> Perhaps a second call or sysfs file or something that returns the
>> supported mask?  You'd still have a boostrapping issue with existing
>> versions but at least at any newer stuff would be helped.
> 
> Ack yeah I do wish we had better APIs for expressing what was
> available/not. Will put this sort of thing on the TODO...
> 
> Overall I don't want to hold this up unnecesarily, and I bow to the
> consensus if others feel we ought not to _assume_ same kernel at least best
> effort.
> 
> Usama - It's ok to leave it as is in this case since obviously only tip
> kernel will have this feature.

ah ok, so will keep it at skipping if prctl doesnt work in fixture as is
in the current v4 version.

I only have the below diff and its equivalent for patch 7 as a difference over
this version. Will wait until tomorrow morning incase there are more comments
and hopefully send out a last revision!

Thanks!



diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index 8845e9f414560..e9e519c85224c 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -18,6 +18,7 @@
 
 enum thp_collapse_type {
        THP_COLLAPSE_NONE,
+       THP_COLLAPSE_MADV_NOHUGEPAGE,
        THP_COLLAPSE_MADV_HUGEPAGE,     /* MADV_HUGEPAGE before access */
        THP_COLLAPSE_MADV_COLLAPSE,     /* MADV_COLLAPSE after access */
 };
@@ -49,6 +50,8 @@ static int test_mmap_thp(enum thp_collapse_type madvise_buf, size_t pmdsize)
 
        if (madvise_buf == THP_COLLAPSE_MADV_HUGEPAGE)
                madvise(mem, pmdsize, MADV_HUGEPAGE);
+       else if (madvise_buf == THP_COLLAPSE_MADV_NOHUGEPAGE)
+               madvise(mem, pmdsize, MADV_NOHUGEPAGE);
 
        /* Ensure memory is allocated */
        memset(mem, 1, pmdsize);
@@ -73,6 +76,8 @@ static void prctl_thp_disable_completely_test(struct __test_metadata *const _met
        /* tests after prctl overrides global policy */
        ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize), 0);
 
+       ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_NOHUGEPAGE, pmdsize), 0);
+
        ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize), 0);
 
        ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 0);
@@ -84,6 +89,8 @@ static void prctl_thp_disable_completely_test(struct __test_metadata *const _met
        ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
                  thp_policy == THP_ALWAYS ? 1 : 0);
 
+       ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_NOHUGEPAGE, pmdsize), 0);
+
        ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
                  thp_policy == THP_NEVER ? 0 : 1);

> 
> Cheers, Lorenzo


