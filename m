Return-Path: <linux-fsdevel+bounces-56662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7313CB1A669
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D893A1897E2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB28274B37;
	Mon,  4 Aug 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFb+hotc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4692749F2;
	Mon,  4 Aug 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322369; cv=none; b=sidFGsHdvDrQ34MdOdAugDj3yle7mZwkRgYgdN0LR6Cqis/VqYt+QRb2K0NFnQ2rzjR8YiH2HyHfOs4o5QQkIFtPY+84ETP4zbUNmtxlu9FdAVXhztmyuUTHjUSHwLpcKNAuY1faR3Q5CJInnM5Sak9bB8hYKOw/rOMqH9qVfgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322369; c=relaxed/simple;
	bh=mZ9fH9xdv+Jrv5Yn99fEL8SH6zdGrz0G5e+vPVt9iKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ac/0NFWrkBf68AfmC9bxHFUJMOCfv5FqPwgFOWaXjlLaCGkdXCDLrItToMBvRfnPNgh8Ppl9chwHzl86i9bEJenSyJkeECu8iMY+X0dzg95Ao8jwOOaVNLQZZNPS1ykA5ejnUKHxCMmCHR+DtYYb/NZmwgcFCUxyHvnMfZVmAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFb+hotc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so19081015e9.2;
        Mon, 04 Aug 2025 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322365; x=1754927165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSPs+xmcRpXzGAfInjNfwF6qcuUqjylfctStx4mmHhY=;
        b=OFb+hotc9Su0kyf1HapKi3hmpDRJBKyPpfcXPMS+eaDLhDmQOTEZmqY95G701X4Cf2
         lULKHiNsq9UvcvDvDB1ehiuzTiDXAI+y/cE627qWjtXUlYSi4+HKvuGuIhYz7DMU32gh
         49bnlm/Kxf1mZT776+2YDCe0/wYuftNafGhdvrN9aBdIXxj9BqanDTt7yQUQRW+s4qF3
         phdnDs/zvLoEQb1+yjAo8Fzq0hLz6reOTl6GcoJ0Bzonbv38Jr2ZDLCIOAUTQwzuZV4T
         ewcEF0HZrdJM8EfsbknOhM/lPvyKfRfRmey2MAl6JIKPO7O2hsMUtsJBLyed+d4sKy+4
         x3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322365; x=1754927165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSPs+xmcRpXzGAfInjNfwF6qcuUqjylfctStx4mmHhY=;
        b=XSvFbH8dlrtCzRARHFyHeC9Lqv1lyAnJrlygUdb3NMmdefWJZBrjW52DDyuvrlHHNY
         /XFbdlWG+c/g9cPAvH20YWgJS5enG+p1C202SMJPIj2L4uRCcKff0rzTDuhWi/QHv0Ll
         wzXyEecudZKt8Fdw0llfnlrIK9U+fJeCsfMLP7yBFkcbfJX9+qIcS6vTrFfWpehlG5cu
         deZaQTd7USzFiS409cNCVWvwlyEmTDvW7+cN5fCeHQHJHFUNGtzl7cgZo7r3Tk0T9FlG
         usssNo0+9efsRQPUg2jw4M5OApuTnTO8FZPNskSYGDE7FWmbgg2t2LqLmQ/bQGeLat30
         Nz4g==
X-Forwarded-Encrypted: i=1; AJvYcCUco4I3Aw4tkiLK69Tesv7UwSGOwCi7I0vnTn0kDF13P31/YtAiZ2nKc0HgVI7m9VqcZoPf/Tw0iHMyRS6x@vger.kernel.org, AJvYcCVw4zDczTFjX1JbL87zdYAa24qE+N+BUrjAO8GmLWbM78UpbOs7m5gR5hV+C29gfJraK8YguEkucPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWJeGpW9ML65G9hiR021jEOmcTVViHrM4oIxC1/Opu7FxH4y3
	yus1UToeEctiMhp17gd+8Bf19UU2uF1T29N0y9GeTa/k5sHw6joMkHOs
X-Gm-Gg: ASbGncvWcwfQ0QnmcHg1IBAYCKeF2zU2jwBBlMC+CktNxzQ3m80yC5PCtZzFujxCRrH
	KYcLa4HgNKpzOBGl39fV6cSRKv/A5xAiA4d8R30+Xp1OmBQQqNbwP+feyAhP41RV1Sr029QV4wk
	UliWejnU2QcZPA/qv0xdpkE8YNDfIBqWHjAz+dr+tQAwQiago3HWClEicEWkzlwyWBhTxMS4roT
	vLxr1KcF/jOaiIWaDo1NCT+d1tlB08xHj2btnQb+WHSGj5En/hgaf+9+3InEpRKjyHkYmm86sBK
	YTz2j1y62kKlBCcTYx3CQF6u3/qetzpiVnW7TQMw0zw+BE/oPhIlWvX2YGofa0PSMxRbhVlqWcu
	XDyeMcHIkmGYsaA10V5lGiI5D5ZHBNtp8MQx0kUwtvCy1AY8V/5cTTOuJijShGSXYgMz1YZbXeh
	TjgVn3+Q==
X-Google-Smtp-Source: AGHT+IH3mTcbBsftpdea/bfQ68d+fnRjUnK7Qbl1Z7kxY+gw6GFtjqZKvLEbxRDEUPNLOcHUPMEsYQ==
X-Received: by 2002:a05:600c:138d:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-458b69f2c1fmr90559905e9.2.1754322364805;
        Mon, 04 Aug 2025 08:46:04 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:64f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458bd5a1148sm57008995e9.0.2025.08.04.08.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 08:46:04 -0700 (PDT)
Message-ID: <58a3317d-96e0-4836-a4c3-cb02c5c55095@gmail.com>
Date: Mon, 4 Aug 2025 16:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] prctl: extend PR_SET_THP_DISABLE to only provide
 THPs when advised
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
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250804154317.1648084-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/08/2025 16:40, Usama Arif wrote:
> (Resending this as forgot to include PATCH v2 in subject prefix)

Not a resend, this is v3, just forgot to remove the above line from the
previous cover letter :) 

