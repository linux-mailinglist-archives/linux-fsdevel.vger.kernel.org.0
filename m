Return-Path: <linux-fsdevel+bounces-50992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE4AD1988
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41511188A33A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02728137D;
	Mon,  9 Jun 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QNTUnUU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE88BFF;
	Mon,  9 Jun 2025 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456287; cv=none; b=V8mXLwXVhHHrY6BRUyrZiF7NbwA21sEgLCFr1NG+q0akGaRee7UA7JvqTbT/k3cA85xHnNrw7uD4jsAJnh7Q3VOXMxsKVaX5HrX7/JMJ/cWSoZACL+aXE3DoTcJemD9TvW2QtmcIULJyYd1uov6+cf883sPRAOdry9dZcnEINsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456287; c=relaxed/simple;
	bh=xEJ73sbL0eQTaJZied7LuvrzyD99mbEk3LrODqHjna8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzyvuHB+it8nenQkb/uFuUxg3EXMQCLu6vsX+oGly3CJcdbqovjQZYxd3MBBjNF9223wR57e7W96cypmXON/NuhFiOlVmXdu1jc1k0GPaQq3wON4ltSaAkcqRuwYO4IunL7XyxJTJviC3hdhUiLoGv4zisB6kU2QEMiR37DxNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QNTUnUU3; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749456281; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=h7tfqTud6IhH1XCgFxtry8B8MPksGWJrLr6a4xwF/rA=;
	b=QNTUnUU3FX4Hg+2lVOmGkG1EIANvtKdzbgA/133Yy+OTYwQ6gpS/BMTzyhqgDFzhGOv9HjMJs/xHRYE98TtGmgBOivWpgXkA7/5iDYX1luLkr1xOBr8Cj97cIhfDQ0GSgj5X+1Gq1NCOWhqIdCJHv3rx6W0M3f0InU+G9Gew12Y=
Received: from 30.74.144.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdNLRJ2_1749456278 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Jun 2025 16:04:39 +0800
Message-ID: <890b825e-b3b1-4d32-83ec-662495e35023@linux.alibaba.com>
Date: Mon, 9 Jun 2025 16:04:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for
 users
To: Michal Hocko <mhocko@suse.com>, Ritesh Harjani <ritesh.list@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, donettom@linux.ibm.com,
 aboorvad@linux.ibm.com, sj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
 <87bjqx4h82.fsf@gmail.com> <aEaOzpQElnG2I3Tz@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aEaOzpQElnG2I3Tz@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/9 15:35, Michal Hocko wrote:
> On Mon 09-06-25 10:57:41, Ritesh Harjani wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
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
>>> In addition, the 'mm->rss_stat' is updated by using add_mm_counter() and
>>> dec/inc_mm_counter(), which are all wrappers around percpu_counter_add_batch().
>>> In percpu_counter_add_batch(), there is percpu batch caching to avoid 'fbc->lock'
>>> contention. This patch changes task_mem() and task_statm() to get the accurate
>>> mm counters under the 'fbc->lock', but this should not exacerbate kernel
>>> 'mm->rss_stat' lock contention due to the percpu batch caching of the mm
>>> counters. The following test also confirm the theoretical analysis.
>>>
>>> I run the stress-ng that stresses anon page faults in 32 threads on my 32 cores
>>> machine, while simultaneously running a script that starts 32 threads to
>>> busy-loop pread each stress-ng thread's /proc/pid/status interface. From the
>>> following data, I did not observe any obvious impact of this patch on the
>>> stress-ng tests.
>>>
>>> w/o patch:
>>> stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles          67.327 B/sec
>>> stress-ng: info:  [6848]          1,616,524,844,832 Instructions          24.740 B/sec (0.367 instr. per cycle)
>>> stress-ng: info:  [6848]          39,529,792 Page Faults Total           0.605 M/sec
>>> stress-ng: info:  [6848]          39,529,792 Page Faults Minor           0.605 M/sec
>>>
>>> w/patch:
>>> stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles          68.382 B/sec
>>> stress-ng: info:  [2485]          1,615,101,503,296 Instructions          24.750 B/sec (0.362 instr. per cycle)
>>> stress-ng: info:  [2485]          39,439,232 Page Faults Total           0.604 M/sec
>>> stress-ng: info:  [2485]          39,439,232 Page Faults Minor           0.604 M/sec
>>>
>>> Tested-by Donet Tom <donettom@linux.ibm.com>
>>> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> Acked-by: SeongJae Park <sj@kernel.org>
>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>> Changes from v1:
>>>   - Update the commit message to add some measurements.
>>>   - Add acked tag from Michal. Thanks.
>>>   - Drop the Fixes tag.
>>
>> Any reason why we dropped the Fixes tag? I see there were a series of
>> discussion on v1 and it got concluded that the fix was correct, then why
>> drop the fixes tag?
> 
> This seems more like an improvement than a bug fix.

Yes. I don't have a strong opinion on this, but we (Alibaba) will 
backport it manually, because some of user-space monitoring tools depend 
on these statistics.

