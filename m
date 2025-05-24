Return-Path: <linux-fsdevel+bounces-49802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E94AC2CE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 03:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DA59E5E9F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9FF1DF979;
	Sat, 24 May 2025 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nZ43NjLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE228EB;
	Sat, 24 May 2025 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049946; cv=none; b=VxORbeFo6KJjfhNqofkCC3mw9WfVKU9zSpicm1W84ZZ7bQLO+RCpPOb7Et3aGnwQLxK2kEGojJ7NhmQqL7cmp0uTLl7NVIApOaWml9N/Kpy4fZ2d5Q7r1ccDin7uR9x6INHC/SgpnSG4EX+BI4S3w7uqbZS3Ft49rUhWwbAupnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049946; c=relaxed/simple;
	bh=YlIuXQCl/ZsiFwqZNKg3LYBMER9DURBVyynx/FPpyFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hE/wkAfOMwDKOfHcpBuQ7NbX/Pd3fgW1Peckze90uxKOuiFzMA+DeCUfPTKhwyMLiysF/NrUQdMltavg7O4q9w9FgyDUKeOqpTIxYb30CYgBwqiB7glcwg4JtpZSDUcHa8jS8c9LfzeWette3Rvqz2UP+j0TjCrD1speZrSegcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nZ43NjLb; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748049935; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/TDP53dyJqq5lJvlbulEFVZWA288bXU/fQlMslx8xrA=;
	b=nZ43NjLb4eHpHM9ckIzLB3oucv7p/0Tq2OK3D4FrjqpMKe7pAJKU5oT8yLwH8Mof5y/sNDWbCJZVV0LowqHAP4hD0pc3P77IIIFKrS4che4pkSaQvYkZV1STcflhKvISXapeweZIS/6MRsfw0TCA23clA7ZnBnI4pIRQ6/6/Axs=
Received: from 30.171.233.170(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbcACGj_1748049933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 May 2025 09:25:34 +0800
Message-ID: <1963f1b2-5879-49a8-99db-41acbfc58ff3@linux.alibaba.com>
Date: Sat, 24 May 2025 09:25:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: fix the inaccurate memory statistics issue for
 users
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
 <67n3snrowiyxjw6grddyer7np5rpnpg4x5f6bsyonmgcc5k5eq@s5v4ux27i4fw>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <67n3snrowiyxjw6grddyer7np5rpnpg4x5f6bsyonmgcc5k5eq@s5v4ux27i4fw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/5/23 22:11, Shakeel Butt wrote:
> CC Mathieu
> 
> On Fri, May 23, 2025 at 11:16:13AM +0800, Baolin Wang wrote:
>> On some large machines with a high number of CPUs running a 64K kernel,
>> we found that the 'RES' field is always 0 displayed by the top command
>> for some processes, which will cause a lot of confusion for users.
>>
>>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>   875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>>        1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
>>
>> The main reason is that the batch size of the percpu counter is quite large
>> on these machines, caching a significant percpu value, since converting mm's
>> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
>> stats into percpu_counter"). Intuitively, the batch number should be optimized,
>> but on some paths, performance may take precedence over statistical accuracy.
>> Therefore, introducing a new interface to add the percpu statistical count
>> and display it to users, which can remove the confusion. In addition, this
>> change is not expected to be on a performance-critical path, so the modification
>> should be acceptable.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Hi Baolin, this seems reasonale. For long term Mathieu is planning to
> fix this with newer hierarchical percpu counter until then this looks
> good.

OK. Good.

> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks.

