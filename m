Return-Path: <linux-fsdevel+bounces-58137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D63AB29F4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C4984E2806
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B82765E0;
	Mon, 18 Aug 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py0udxLM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9EC215F7D;
	Mon, 18 Aug 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513780; cv=none; b=OlwZ6Y0NVKMYascHB57kYmDJTwRMJN5dWAw5qsaINiUtToYVM0SIDiACk/++Mb0gtKZvfVWYJbZgQGWKH2kPeaZUkU+I8OMuYpEj2Ouz6qja/4yuZe41Vi7+PtlWOsyhYoomK0msLujQvbIMtl4cgj+9x9K36miB2sX9cg3hjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513780; c=relaxed/simple;
	bh=u84tw/w1OLcZCIxKinsw/JcxtlEv0hJ904HXGa9aaGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNO6VNElRRsV/k4/4yG/+xNLz/ldTiy75mwCsFDJDcnvp7DKK69yrO6cXaqXysUMCtpi9W6msxdK4eczITBnA82Duw2Ou/dlzqj5YdCuZ3E1v4ZGy7CieIL8Hf/0l3Y+jQc0Lszw2LHck/DCxRUbCTNIR8Kd9BGzvr2DlouvHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py0udxLM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b916fda762so2373344f8f.0;
        Mon, 18 Aug 2025 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755513776; x=1756118576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JE4IP0xudja5BlNOujM7gUm5gN03tzBb6HO3+FrlBKg=;
        b=Py0udxLMDx2XdB3R6Q5fqLSMgbTw0iUAks1gtkO0rRjV6kVbstyTSZuYAnkrudvSlo
         3tq2n4xu6a2wKGI5cD+d+fYVjhxjZrMClwk72Ozy36vANKuR/jgFIPjCvdoHdKkqh3cZ
         WA2NsbPKKz9VCpXAS+j30UCCDzRocyODoggJ8NA3O1WBD4pPZOENgEJ/RvQuVJPr03D/
         ovL3NypdOw0Ed4K5Gcl2/BSIxITJi6VWZ5xn9aVkUVReY9M5U5icYpqZxBKLavt8q4SK
         tPNLIzmO2Y5nSt+4uXxyR8GXqjirOkgAc5FEcC5XrmEMKP/zZMphyc8+PYiQQb4YQwi6
         UDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513776; x=1756118576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JE4IP0xudja5BlNOujM7gUm5gN03tzBb6HO3+FrlBKg=;
        b=b762JpQ5S6fHJT/xFGuB1UhFoUJ02bkRR528MVoN9hH5wK+cfLGLHWierCQSLzzqDS
         rgqM1xdgbxMuvfSXAtsd3Rwq/kZxTT7p1VzsLUHrQXovG6gdhkhy1MkeZQTWQH6jxXnW
         aKoP0X/rKQ0gNb1433Obq5JQgK7BceFgZ20JsuHYBPc3h1fnjVyvAPeKvu7hvgrqT1kZ
         idNH3sqoMIyt1n3oafkkZZh9+XVqKKEet+yzYj1Du/IgSST2iEmWHGt2xnmafs7GJaBH
         d9jMVyBNsP/yRqo8XwlLk9avTXOeThMsKdx97ohHZ72NhvkXGtC/MG+I+D1JJPO4+XG3
         m0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjvhtMavC1pOyLv56FR1hCInRkCo2bvmnuQ/byQDq8PolKkzbagBlfOb+VkaB+6B2jI/csOLAvNzlF5pFi@vger.kernel.org, AJvYcCXfqDgIbGAKvDfBDA1FZBcKWP8eSUAdXKBwDChzc+0mnQ8dY57i0exr3Y1r33w0Vv9zi82oondlbaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2tzYnuZlzpfIM3yE1wdtoEIrQAxequlKyJckahnJDVua0JgY
	bvJ2cWbv1h9pVMqDnrt1aaB5SvZ6BOEYcyB7kdus7TlF9W6kVIeyGC1A
X-Gm-Gg: ASbGnct1Z9e/L+ZHbuhh43qHL47nmG/CzkX226ez/dqlE7H9u35ApLQWF8XEwsjag52
	QUtHO1kdYVj3yLrOCS8/GDLhI9RsEj3ApWxM2Up64EcUvYTHATw0JyqefB31c8Lv0hfrK/z2ErN
	9wTo71MchYT3Qz+ScSOo5LWJMIU50B+p4mcjbpkG7ZlpUz5ySnz9ijjkf7czE7WUqQlZhJPb98M
	LM8WJapaCDbCBgR+E2N2IjKynKCG+KLmn9sf6E+vJm8V4hSusYu3K4btbEEE3bySW39uj/f49ou
	WyHyhjzzn/EfSDoQWXrlLuI09SOrX0D3sK7F0sNz9AexoUbuKTJzwPwMpTpk04Jjvc19DtfMaKS
	meT584ztxfCbiBS+8JakEVWwIKG+tSM0ZEujdyYn+eqwdhqwT2XU9Silv6SiGp/2sUbbySkmXMK
	EK5rGguQ==
X-Google-Smtp-Source: AGHT+IFKP9QZ1thEf493w6nDqLQbZYUy0PPDE6aSEoN/rO80+JpNoZTVzO4HbHsDTllsrSB3lskQsQ==
X-Received: by 2002:a05:6000:2287:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3bb4d619c81mr9565589f8f.29.1755513776385;
        Mon, 18 Aug 2025 03:42:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::5:7223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb680798fasm12417323f8f.52.2025.08.18.03.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 03:42:55 -0700 (PDT)
Message-ID: <3dca2de4-9a6a-4efe-a86c-83f9509831fc@gmail.com>
Date: Mon, 18 Aug 2025 11:42:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-8-usamaarif642@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250815135549.130506-8-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/08/2025 14:54, Usama Arif wrote:
> The test will set the global system THP setting to never, madvise
> or always depending on the fixture variant and the 2M setting to
> inherit before it starts (and reset to original at teardown).
> The fixture setup will also test if PR_SET_THP_DISABLE prctl call can
> be made with PR_THP_DISABLE_EXCEPT_ADVISED and skip if it fails.
> 
> This tests if the process can:
> - successfully get the policy to disable THPs expect for madvise.
> - get hugepages only on MADV_HUGE and MADV_COLLAPSE if the global policy
>   is madvise/always and only with MADV_COLLAPSE if the global policy is
>   never.
> - successfully reset the policy of the process.
> - after reset, only get hugepages with:
>   - MADV_COLLAPSE when policy is set to never.
>   - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>   - always when policy is set to "always".
> - never get a THP with MADV_NOHUGEPAGE.
> - repeat the above tests in a forked process to make sure  the policy is
>   carried across forks.
> 
> Test results:
> ./prctl_thp_disable
> TAP version 13
> 1..12
> ok 1 prctl_thp_disable_completely.never.nofork
> ok 2 prctl_thp_disable_completely.never.fork
> ok 3 prctl_thp_disable_completely.madvise.nofork
> ok 4 prctl_thp_disable_completely.madvise.fork
> ok 5 prctl_thp_disable_completely.always.nofork
> ok 6 prctl_thp_disable_completely.always.fork
> ok 7 prctl_thp_disable_except_madvise.never.nofork
> ok 8 prctl_thp_disable_except_madvise.never.fork
> ok 9 prctl_thp_disable_except_madvise.madvise.nofork
> ok 10 prctl_thp_disable_except_madvise.madvise.fork
> ok 11 prctl_thp_disable_except_madvise.always.nofork
> ok 12 prctl_thp_disable_except_madvise.always.fork
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---


Andrew could you please help apply the below fixlet on top of this patch?

Thanks!

From 85908068c15fee0b9e5796fbc552e38239c2765a Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Mon, 18 Aug 2025 11:37:10 +0100
Subject: [PATCH 4/4] [fixlet] selftests: prctl: return after executing test in
 child process

The next step after executing the test is a wait, but there is
nothing to wait for in the child, so just return.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/mm/prctl_thp_disable.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index 21d181ab599a2..feb711dca3a1d 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -273,9 +273,11 @@ TEST_F(prctl_thp_disable_except_madvise, fork)
 	pid = fork();
 	ASSERT_GE(pid, 0);
 
-	if (!pid)
+	if (!pid) {
 		prctl_thp_disable_except_madvise_test(_metadata, self->pmdsize,
 						      variant->thp_policy);
+		return;
+	}
 
 	wait(&ret);
 	if (WIFEXITED(ret))
-- 
2.47.3



