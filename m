Return-Path: <linux-fsdevel+bounces-50431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC63AACC1C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 10:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3861916587B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA232280312;
	Tue,  3 Jun 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DY0SvXZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17C269AE0;
	Tue,  3 Jun 2025 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938115; cv=none; b=d32gAWydgcOeQlMBgmwMKDYlQe22FiOKOHGHaGVXTuYrVJRuIYdJ+LwyleL/76+NAigr72SgJvz05MOvbDwVj+s+y8RjikoKWsB+k3qe2/oiUiuls3LWMH5vP1/DrMQlFPMENueZ9EbThxmqD6/Dsk8w+1PurLfhmYr7J0lfuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938115; c=relaxed/simple;
	bh=nUgrPD5FR6zEEOvfUGgTpt1Y+LgTw9lL9QNv+QYXSLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ykke+YWWO5FZJuLEP8vLSVtxr2NzqadtaVVDuMYQFrZnK78xBa5rJqf/ktGTQPT55Hj2sQ7iD3TCVE1xDBWQ6bXRZKnfSSczedsH0w47ygb9rUTY7FpB0DevWKdP5rCk1Y4REtz1N58jFmVc5pW4zFoQRR1INprhgLw5FBaIv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DY0SvXZW; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748938103; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=94IxEkB+vGRX1OwSpnG6F+yDF6/i4bDG7xzgyZQ+YKk=;
	b=DY0SvXZWNA/RpcI5IsCnc+HzGRFAqehL0jXhJ24J1x0SqSow5WkcJagz2iOzQtmJTh4pCdt+j+/85m8//2icRo4t2HGMg3LLucs3mwETohl2GGZ0t0lZnD7bBUypPNCwBrzE+6rML6OCL5qBPsXvvK5Yj4gReNAytaOOClU7D8M=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcnHjtm_1748938101 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 16:08:21 +0800
Message-ID: <72f0dc8c-def3-447c-b54e-c390705f8c26@linux.alibaba.com>
Date: Tue, 3 Jun 2025 16:08:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
To: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 donettom@linux.ibm.com, aboorvad@linux.ibm.com, sj@kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
 <20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>
 <aDm1GCV8yToFG1cq@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aDm1GCV8yToFG1cq@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/5/30 21:39, Michal Hocko wrote:
> On Thu 29-05-25 20:53:13, Andrew Morton wrote:
>> On Sat, 24 May 2025 09:59:53 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>
>>> On some large machines with a high number of CPUs running a 64K pagesize
>>> kernel, we found that the 'RES' field is always 0 displayed by the top
>>> command for some processes, which will cause a lot of confusion for users.
>>>
>>>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>>   875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>>>        1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
>>>
>>> The main reason is that the batch size of the percpu counter is quite large
>>> on these machines, caching a significant percpu value, since converting mm's
>>> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
>>> stats into percpu_counter"). Intuitively, the batch number should be optimized,
>>> but on some paths, performance may take precedence over statistical accuracy.
>>> Therefore, introducing a new interface to add the percpu statistical count
>>> and display it to users, which can remove the confusion. In addition, this
>>> change is not expected to be on a performance-critical path, so the modification
>>> should be acceptable.
>>>
>>> Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
>>
>> Three years ago.
>>
>>> Tested-by Donet Tom <donettom@linux.ibm.com>
>>> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> Acked-by: SeongJae Park <sj@kernel.org>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> Thanks, I added cc:stable to this.
> 
> I have only noticed this new posting now. I do not think this is a
> stable material. I am also not convinced that the impact of the pcp lock
> exposure to the userspace has been properly analyzed and documented in
> the changelog. I am not nacking the patch (yet) but I would like to see
> a serious analyses that this has been properly thought through.

Good point. I did a quick measurement on my 32 cores Arm machine. I ran 
two workloads, one is the 'top' command: top -d 1 (updating every 
second). Another workload is kernel building (time make -j32).

 From the following data, I did not see any significant impact of the 
patch changes on the execution of the kernel building workload.

w/o patch:
real	4m33.887s
user	118m24.153s
sys	9m51.402s

w/ patch:
real	4m34.495s
user	118m21.739s
sys	9m39.232s

