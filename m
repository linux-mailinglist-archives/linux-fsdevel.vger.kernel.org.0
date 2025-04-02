Return-Path: <linux-fsdevel+bounces-45503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DEEA78AD9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C88127A5084
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0D621ABC3;
	Wed,  2 Apr 2025 09:15:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F307205AD7;
	Wed,  2 Apr 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585351; cv=none; b=uJxRMS4vDz4ClWao4Qlnr/HYXj89cfGdlpjV0NDm66BYwH8Mr2QoZB/F3O0PoGEMmTNViUx1u5FsItBSrQre5gcDZoprD1lFk8G+DHvfHKD68Ji0cGzGxpBVsFTvr3O0+pi/4x4w3cZNHvAAHLQjmJDrvpoucocHVluSVs7nldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585351; c=relaxed/simple;
	bh=L9sjaXrfYSgQgRa1e9C5yEIG6VacKfIGXFkTXEok4qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LcV/qydnprjJcXN0v0glAF/jjwYZf0pSZTuD3k+28nqIokH9ZmaorASGhDOJexc/3eYL2my/N7IcTswoqh7c6grdfjvo6V4ujBYdl1bFk7Bmk84K0DsfJkTKZDKafJEJXfJvLkeahyNFoLPAP01b6DQxiwQEo8Ch0cEyqIp5z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZSJxs6rsLz2TS1p;
	Wed,  2 Apr 2025 17:10:57 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 32A021402C4;
	Wed,  2 Apr 2025 17:15:46 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 17:15:45 +0800
Message-ID: <e6537aa9-6fe7-47e4-afd3-9da549ce12a1@huawei.com>
Date: Wed, 2 Apr 2025 17:15:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH][SMB3 client] fix TCP timers deadlock after rmmod
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, <edumazet@google.com>,
	<ematsumiya@suse.de>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
	<smfrench@gmail.com>, <zhangchangzhong@huawei.com>, <cve@kernel.org>,
	<sfrench@samba.org>
References: <ac39f5a1-664a-4812-bb50-ceb9771d1d66@huawei.com>
 <20250402020807.28583-1-kuniyu@amazon.com>
 <36dc113c-383e-4b8a-88c1-6a070e712086@huawei.com>
 <2025040200-unchanged-roaming-52b3@gregkh>
From: Wang Zhaolong <wangzhaolong1@huawei.com>
In-Reply-To: <2025040200-unchanged-roaming-52b3@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500010.china.huawei.com (7.202.181.71)

> On Wed, Apr 02, 2025 at 12:49:50PM +0800, Wang Zhaolong wrote:
>> Yes, it seems the previous description might not have been entirely clear.
>> I need to clearly point out that this patch, intended as the fix for CVE-2024-54680,
>> does not actually address any real issues. It also fails to resolve the null pointer
>> dereference problem within lockdep. On top of that, it has caused a series of
>> subsequent leakage issues.
> 
> If this cve does not actually fix anything, then we can easily reject
> it, please just let us know if that needs to happen here.
> 
> thanks,
> 
> greg k-h
Hi Greg,

Yes, I can confirm that the patch for CVE-2024-54680 (commit e9f2517a3e18)
should be rejected. Our analysis shows:

1. It fails to address the actual null pointer dereference in lockdep

2. It introduces multiple serious issues:
    1. A socket leak vulnerability as documented in bugzilla #219972
    2. Network namespace refcount imbalance issues as described in
      bugzilla #219792 (which required the follow-up mainline fix
      4e7f1644f2ac "smb: client: Fix netns refcount imbalance
      causing leaks and use-after-free")

The next thing we should probably do is:
    - Reverting e9f2517a3e18
    - Reverting the follow-up fix 4e7f1644f2ac, as it's trying to fix
      problems introduced by the problematic CVE patch
    - Addressing the original lockdep issue properly (Kuniyuki is working
      on a module ownership tracking patch, though it hasn't been merged yet)

Regardless of the status of Kuniyuki's lockdep fix, the CVE patch itself
is fundamentally flawed and should be rejected as it creates more problems
than it solves.

Thank you for your attention to this matter.

Best regards.
Wang Zhaolong


