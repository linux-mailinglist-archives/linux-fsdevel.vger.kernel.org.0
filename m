Return-Path: <linux-fsdevel+bounces-49803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A68AC2CEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE915410C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 01:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7B1DFD86;
	Sat, 24 May 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GducTPmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79C127E18;
	Sat, 24 May 2025 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748050171; cv=none; b=uABHLdsBb7FGXPz7ShbArShCGzFHXX/7DUPtGjZBMnyHzex6/pZGIeQgQwxAOAcb0Ypgq6So7rlHOLbS82Q+s+Q26uWquI87CeyOhkcYnCltZtebtV9ZXNnD27W46n5Mt4Zf8r4DJ93YrAjS32BOGx06eDXJq2/1pJ38+r/LO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748050171; c=relaxed/simple;
	bh=Ee7PbT9GaRaRs+NY1P3k7sBexoErNT6M4ozPGrZAUzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ounp9Zsq/Ffal7ojGte578HfI4YEJiVNAyjt+m7Gkix/PJhuFzfy63bBzCapPGsTMQCpWTC1cLBXNHMmgtKMRudKdcCnef/hQuWHyMoFwogs7X6ZHvRC3DHyj6CAGDs1ZShSma4t5k2X2YikDkL0er2KWxES2cdrOp9/c6nGijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GducTPmj; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748050160; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N29YGrSzA3zqIkby0ImioiElpY0ZMtKGfk9pdQlO27M=;
	b=GducTPmjx9rEIPAjz9aAn5WJhyslApKA3b+HsCD2WM5vfLgjE+LOAHT7cj4bQsqY7HIa6kkBL7MZvsTlr7IRFztHEmKLDoi4xY7ZbPBoTkO/GrlC9A0bMtZBCmMGeZzL0MaxkAtC71z+04A5qxsq0/H+sWgH3sxJt2pCPCuYvZw=
Received: from 30.171.233.170(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbcLI26_1748050156 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 May 2025 09:29:18 +0800
Message-ID: <99e39ac1-d766-4d6e-a69a-525c49662ac0@linux.alibaba.com>
Date: Sat, 24 May 2025 09:29:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: fix the inaccurate memory statistics issue for
 users
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, shakeel.butt@linux.dev
References: <20250523172305.57843-1-sj@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250523172305.57843-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/5/24 01:23, SeongJae Park wrote:
> On Fri, 23 May 2025 10:20:29 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
>> On Fri, 23 May 2025 11:16:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>
>>> On some large machines with a high number of CPUs running a 64K kernel,
>>
>> What does 64K kernel means?

Sorry for not being clear. I mean a 64K pagesize kernel on Arm servers.

>>> we found that the 'RES' field is always 0 displayed by the top command
>>> for some processes, which will cause a lot of confusion for users.
>>>
>>>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>>   875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>>>        1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
>>>
>>> The main reason is that the batch size of the percpu counter is quite large
>>> on these machines, caching a significant percpu value, since converting mm's
>>> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
>>> stats into percpu_counter").
> 
> Forgot asking this, sorry.  Should we add Fixes: tag and Cc stable@?

Yes, will add the Fixes tag in next version. Thanks for reviewing.

