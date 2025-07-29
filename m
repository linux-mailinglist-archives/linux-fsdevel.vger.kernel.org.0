Return-Path: <linux-fsdevel+bounces-56284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58812B1552E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DA43BE5C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4D528312F;
	Tue, 29 Jul 2025 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+mHkkHM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A11B85F8;
	Tue, 29 Jul 2025 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827477; cv=none; b=kLcUHiFfkQbuaVe5opHFvb78ZkOZZv2SLkaqLG/b+WaL5vC8OijpM1KvvY/XHNfjOyYo518InqsnDs9/3LTXc5wL86t7MaVuBoJAjW4hltbDL8hne1EcjhfdFZbdT+grlVdSY/cShQuFI7b3X8s/Rc/YkoXkzPeOWA2e8MeOKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827477; c=relaxed/simple;
	bh=H+jnV/1Qq2i+vsDX6MbmZMSo6lGowa7lRaOh2ijlEWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBPy6EE4vkr03K0VesJ+RnCQW566fpWmx9cTHi3d/+g4HBowW9aOovjucLtlnr/tnWS9ApSQxvpkz1hijvrIKSHFM7KM6p/lIpFpid4OY9CvDmfpQNAc7dQ+ZxFKIyLkI2P7mrfUT4eqSXF74F6c/xEF53EahGb6VkBkaUFAG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+mHkkHM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso162475e9.1;
        Tue, 29 Jul 2025 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753827474; x=1754432274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9R9i9gZzmllbRYerZjV3O0Hgnx9VaX1f/NEv9kky20=;
        b=W+mHkkHMsAHAwQx3zqJrD/GcUG/MOXW18m4yciKgEAzMt9o3W2+jCikv7JGxL3TfbU
         t/CpjMRmuUKCGn3W+K4d3xTr7rvTGrnVw6KA9AzjrMDtgSGl0Gnrr0kQnCLUH3Izz7s5
         o8hibDogFLFufW1zzT2B+6cPkOyy5SUQ8C0Mo1iBR2GLMzzCMr8jTxA+6xY1LCy/Lo4q
         UMmnb0uTHloL1NtCu8K1F8zPn8Cug5HYeV77vwIaIySBgmapTtyx7eiseGvMhQfENCcL
         U26TpwW8HOXG+8U7/qgnNmCWHVu7x/ax11B9as+3EtaeJDX3PkKQF8tOJjDRuSnqR0av
         7Hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753827474; x=1754432274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9R9i9gZzmllbRYerZjV3O0Hgnx9VaX1f/NEv9kky20=;
        b=m3OowV4M9ROHnCj9778/qx4fP1xOgecGWqzafZgdATUzbt3hHeee/pjS8mWeR/PAM2
         6rWhLW9/G6Xwa4JJlXJ/OwcHxhjMwBSM0qCIs5IXz8g2GXOy0iysla+Al4n+9XS9DOuF
         IxCrPJiMXlnViqrQyFrp2cnI/bhw2jXr/oGiZAwHGMSv7ss9S1Wgvsgt9P8jmue3IJnm
         prtBT3qxR2HbFc50Md9lZX0THcR43KIYy+IvFfrtBFSx79CyIs+7KOoXJ43PRBb0Xf6n
         PrzVBjCzkqNCQNlmwcd/Zl3hyUDa669EVTheeRz1QCIyPtGUJnVCYZ/Cf5vcQMCKBQeo
         HpVg==
X-Forwarded-Encrypted: i=1; AJvYcCUzfqxSIi3iqbX8jeF9uX+lMRbErb3pZEKa6n5iKq05VTB/p+6s7cXEPY7LeaAwXX+KZTDi/gyD8H0=@vger.kernel.org, AJvYcCWvQYu137pkVoRkE6M4GfDH8RUBZtL3RFgz/Frvrx/52uJNGWm/MEZ9xFTNhzHc+Ken+PvWHZnVlnuYTMEv7g==@vger.kernel.org, AJvYcCXy59ZjMQhsp+rz+ZU4LInhHCgCA//CEEeghO6nnSPLKcHn8RH48O+77p+tx8SJfgEJgLcb0KrxyyvwbD37@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVOgjFsgZcKUO3alXY99wE3B/eLCorhPanYSwBONerDRNi5gL
	4BUl41pG3+J6QcJ1HJVN18SwmI0susvQ7biUrLxBOBr+aBptZ8WUPdMT
X-Gm-Gg: ASbGnctZ7fDeszVEI+xsZWkm12RQuY0ryoi1WhqtKi6Xx757lQsOJrhb9/81Xg0Q02s
	YyXJPbClUPeV1OY3uNbNlCgqxFKuw0oVU6FVgeJhdKln+LA3HPf/6y+nUgTWCTwH16ZgOohm6op
	QGTwm94sljeouSWs0zYZ8B6WI8hzy39AzyOYgP99W8FD7QqNJxzSMm6CRA2rD3XT/KxrATtlxTj
	xewqb9WGB/FEuT9jzo8xULe6hBBiyd8ER1NQvCqItkKOLkehO9nzyrNqJJQqp9LGwLBuZoDRGqQ
	mkNzQwTfDnwyFrRcvx5rX65NATOP823zPUo4u93GbZJJRfqlKYb1JL7Rt/UHngjv7W82dMuaqtm
	A+Dy1CNXcN2HSNFrmSO9us3wgac0m7UO2FvkuRSH0DtkPcDgNVTaHeF+RoqpcKzjIBFWoHh88V6
	gg4XnI/f/eXA==
X-Google-Smtp-Source: AGHT+IFAxzVacxawo5KpZIZ8F2nXYc0D7iKisaZ5kTwE/SHS9IidB0NJRFvZd5YAa1l7F+++rO+7qg==
X-Received: by 2002:a05:600c:3582:b0:456:1204:e7e6 with SMTP id 5b1f17b1804b1-45892b9d130mr11458165e9.11.1753827473924;
        Tue, 29 Jul 2025 15:17:53 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4? ([2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536a6e7sm2875515e9.2.2025.07.29.15.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 15:17:53 -0700 (PDT)
Message-ID: <59099cb0-638b-4ca7-b20e-f407a2d27217@gmail.com>
Date: Tue, 29 Jul 2025 23:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] selftests: prctl: introduce tests for disabling THPs
 except for madvise
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250728165549.62546-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250728165549.62546-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>> +	res = test_mmap_thp(COLLAPSE, pmdsize);
>> +	ASSERT_EQ(res, 1);
> 
> Seems res is not being used other than saving the return value for assertions.
> Why don't you do the assertion at once, e.g., ASSERT_EQ(test_mmap_thp(...), 1)?
> No strong opinion, but I think that could make code shorter and easier to read.
> 

Yeah this is on purpose, I found it easier to evaluate what the output should be
if I wrote code like this. As compiler will likely just optimize it out (although
we dont really care about performance :) ), although others might find without res
better.
I think you had mentioned it in the earlier thread as well. I will remove it.>> +}
>> +
>> +TEST_F(prctl_thp_disable_except_madvise, nofork)
>> +{
>> +	int res = 0;
>> +
>> +	res = prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL);
>> +	ASSERT_EQ(res, 0);
> 
> Again, I think 'res' can be removed.
> 
>> +	prctl_thp_disable_except_madvise(_metadata, self->pmdsize);
>> +}
>> +
>> +TEST_F(prctl_thp_disable_except_madvise, fork)
>> +{
>> +	int res = 0, ret = 0;
>> +	pid_t pid;
>> +
>> +	res = prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL);
>> +	ASSERT_EQ(res, 0);
> 
> Ditto.
> 
>> +
>> +	/* Make sure prctl changes are carried across fork */
>> +	pid = fork();
>> +	ASSERT_GE(pid, 0);
>> +
>> +	if (!pid)
>> +		prctl_thp_disable_except_madvise(_metadata, self->pmdsize);
>> +
>> +	wait(&ret);
>> +	if (WIFEXITED(ret))
>> +		ret = WEXITSTATUS(ret);
>> +	else
>> +		ret = -EINVAL;
>> +	ASSERT_EQ(ret, 0);
>> +}
>> +
>>  FIXTURE(prctl_thp_disable_completely)
>>  {
>>  	struct thp_settings settings;
>> -- 
>> 2.47.3
> 
> 
> Thanks,
> SJ



