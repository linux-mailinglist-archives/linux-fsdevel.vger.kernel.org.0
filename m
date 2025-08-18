Return-Path: <linux-fsdevel+bounces-58138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B47FB29F52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D201717A334
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A72765EA;
	Mon, 18 Aug 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVk7WmVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783D2765CC;
	Mon, 18 Aug 2025 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513823; cv=none; b=dXhyXrWE/epzg8PjHxBy6IGk5vY+rq7q1U17egud/1SeADoVjQBu8gM5HSVUlRTa9bnVVGZDougwIOxpM1WcA5FXzLFRAs/X057iGf86v2IVklIv0F+BFrei5NpoO38NcvSc6RH836dvHD2IQgU0dhWZQrSVj0+caxYrjUxXwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513823; c=relaxed/simple;
	bh=Zt1gMmCEWLI3/oLyfWB5PLNg8I5VQKWHXz3FvR8qYiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLWjBybmOFmBKwArpUNVfx5IVXrqAAHd5v/lAn8p+6tsQxFc007utTDwr/OwFV85prVbhkkkflxFg7TZMWPfZL8sRQFPxxsff+slj5/ZscXVg6mH+hwCKpCwjy5KRTXbDsNFkQ9QjFaJKGbdPbQijsN8KtYeYvbK1eFr7bLbyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVk7WmVZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso2961307f8f.0;
        Mon, 18 Aug 2025 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755513820; x=1756118620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6r3SaHRyW0coFrYXSGevRrDyhzWvwUgHlOXlsOiQukM=;
        b=fVk7WmVZS3E/gwjIuPgq1VN1wVMdSOJAHm0z/3N0o9V89LwcM8ffe3tK3O6ztLdHPF
         5F/4WMbXlC0KFbP98MXxfARrUAvV4Z+7fHGyAvoqAgtsRIsQDG/UDkVtL8+1xNfd3+Ug
         Py8qt6QXC8/D3dLuFQo708nE+aoheWX/vMpp/oIcikPbMuV5QLmeb/UlVNQid1k7TSdX
         aP+F2QiFG1RJwewDdYOs1siPJdpPx35XNTA9F+bMBC7ZATgzewsEUX7BKuPNhsk2UGrJ
         DHR8CHdWOKqEKnfv88u3KiP4r4NwCpJe/oiK38LWXgqt7nmfEFiDnoTipau3c+uSTTkN
         FAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513820; x=1756118620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6r3SaHRyW0coFrYXSGevRrDyhzWvwUgHlOXlsOiQukM=;
        b=L6wDgM8MT3ASTKVJ8C3NUtj43WyMfFM/e4Z/6PZfXibs3q1diImlGPJFD4H9aRuowo
         62bswpRSlNAFnIxRjz7kDFEW2QCC2RqWxlRUKcU/lBC/IyC/szrNw5mexVrCu7A97Gap
         0GieHjQ+kHXWj4PrKqL1L9GToiNfNHxzpBufyLWmuXLcTWF/CK0wMPruyD8oDt/qBEHR
         pbxVxq9cXSmXDuXfopUVP7U3N3zSTyR/+UMe1iC/2qPYstFutgbDIyz4bOwSRP9TCwpq
         1rnQhYefV+LjpcJ4Za/LKK15misSo6QRmHQbz1YBrJtz/pvejNV4pPwjHpO5ZYlJ+EEi
         8rDg==
X-Forwarded-Encrypted: i=1; AJvYcCUddrRQS89iqxFjgL5veu6LxRDrD0mcrdjC5lXvHbaCKzmf6SeZn43jUhiCHEbmo1/4lspoPQbDN/cWg2Il@vger.kernel.org, AJvYcCX275Mn+0dduomMGPngzpWdFmTlyiW/RSPWRr5cEXCMMimHT1WEIitkOGIQETyQUsBGz/iaEUpukfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9EOjP2YLsdjo18oOxL8HCS3ZTaazNvYV7I/O+9onTBgaxOkh
	icFFhQpy1EjP48XGiznS5PVTm4sowDtgShc/HZavSNN4Aw8kvFpoMkYQ
X-Gm-Gg: ASbGnctVO/Xw+QJ47ZYz8+XUC/z+DzIaVMI7IWH+j6toxqI12oojdycEMnRKqio1g86
	nSn4DkISmS56K64PYSffS/K893UTjEzZY2mc3gxLj7DsUCbpyxN4FSFkHUrrn6n0f966ZiOLr7f
	BbDcXw2MrDCe9cS+w0Z7pWCXbP9TA4glbIp58UMTxbOB49znrGiTAtEZkIE0dWXT3nHy9JOUhqL
	1Py2ZSat5SwG1qJ/LxQWhyPoqQ4G8UPFMbycPSk5Af7dyLEdhwStKXBp26AhCcbNt4y913n3Zc+
	nmHZIZzlCM2In8Uk66vcgaHUYCOBk/qxnPX95Pmsh4Dp2KGgu4P6suB97cNvZhrkUNzu4Y3XIvz
	239I2uEvtro2P7LWk/cpKmsMDIR5a2g1+BkWbQkQHLHtdGxIzx07IZv4UjBHSYvnZtBr2YlE+tW
	Ci4+wuBg==
X-Google-Smtp-Source: AGHT+IFsKR1Ldy5RQ1PDhrHI0xRfPnmBR+5bPKLtaVpXzp3YgdHRXH22mh0OTnGitE+mCt+Wq/AYAg==
X-Received: by 2002:a05:6000:2501:b0:3b7:8af8:b91d with SMTP id ffacd0b85a97d-3bc69cc2bd2mr6578410f8f.35.1755513820124;
        Mon, 18 Aug 2025 03:43:40 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::5:7223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a23327809sm70936965e9.5.2025.08.18.03.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 03:43:39 -0700 (PDT)
Message-ID: <5560e517-aa26-4693-baf7-e618bec3c5fa@gmail.com>
Date: Mon, 18 Aug 2025 11:43:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] selftests: prctl: introduce tests for disabling
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
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
 <a385e09f-f582-4ede-9e60-1d85cee02a3c@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <a385e09f-f582-4ede-9e60-1d85cee02a3c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/08/2025 10:36, David Hildenbrand wrote:
>> +
>> +TEST_F(prctl_thp_disable_completely, fork)
>> +{
>> +    int ret = 0;
>> +    pid_t pid;
>> +
>> +    /* Make sure prctl changes are carried across fork */
>> +    pid = fork();
>> +    ASSERT_GE(pid, 0);
>> +
>> +    if (!pid)
>> +        prctl_thp_disable_completely_test(_metadata, self->pmdsize, variant->thp_policy);
>> +
> 
> Skimming over this once more ... this raises two questions
> 
> (a) There is nothing to wait for in the child
> (b) Does it work when we return in the child from this function?
> 
> I think (b) works by design of the kselftest_harness, as this function is
> itself executed from a child process.
> 
> Regarding (a), it might be cleaner to just
> 

Makes sense, thanks for pointing this out! Have sent the fixlets.

