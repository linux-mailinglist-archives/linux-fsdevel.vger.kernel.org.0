Return-Path: <linux-fsdevel+bounces-49709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0014AC1BD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 07:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71756A261C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 05:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A1225A3B;
	Fri, 23 May 2025 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Got1i35A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63422578D;
	Fri, 23 May 2025 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747977951; cv=none; b=kg7btK8o3XSICJ71H+zoCN4EuXflY+mCEw8pYkvV+aXuDMlG1a5v1agpuop9uChJNkNqAEYjkUHb4jdo1s7+XLLa49xHfduX/XQI/txfXSQTfFDF+AOv4w9pwKT/NWox8J9sXHqaDsCpCQc6uMDm2Y/+8JTOijYiZHygJCxF65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747977951; c=relaxed/simple;
	bh=jj9BgReTvHeJe4y8jLSLUWxQCNxv1v3iTuGIjgBQl4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvfvaoERXadhyCrbmVBve7ZiflVrMBS4bUT+9QUc8HOtLlEohdxz4rXfeA8ZOxO1p1WTpva76vnPAbobNuRQhpvKIhnUD5R2OPepZX7+YQ8xczY2lplmcLEVKvxOkXnmLHl23wRHlaqQCIf9QEwnoLt89ZEIUrLSeFIlaWx3Cgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Got1i35A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNW4vw024648;
	Fri, 23 May 2025 05:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YxjC6Y
	/cUxQss4M80L0v2JPy8dv2dlD/GJSo5/DNYrs=; b=Got1i35AonF7azkpcUu5tW
	p0oDjpNscsn9AUO+S4aMs0Nbqiu8a9WEi0XkjFRW3HXETwZOChNRwAUmEcW6ZZwV
	vUEbMQDo1UrGYLPsuB30Pr4uo8tgxMTfrFRbh00hY8wPdd6L+n9Rgfmq1Ax3A8i1
	zx6ukMWaOofLC6SxbCCt+M57H2arzkq5euJPJStoMmYl2Hw81Sj6eynnEH0ajTgA
	gluRIGpiMs7VLKNJKZECgSLliUtjbotR7AZ7vagCs/X74ZuBwbVNzpapDY4ivxfw
	FZLd9vPQ0MdoS5bxlPjpd4QruumMMvb8Y1bPQJco/ZKV9+T9a3ojovPHHwDDFVvA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sxhwdu72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 05:25:33 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54N5NwiK031978;
	Fri, 23 May 2025 05:25:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sxhwdu6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 05:25:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N1OHSw032091;
	Fri, 23 May 2025 05:25:31 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnmn25m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 05:25:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54N5PVAA60948804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 05:25:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E042058055;
	Fri, 23 May 2025 05:25:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ED4E5804B;
	Fri, 23 May 2025 05:25:26 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 May 2025 05:25:26 +0000 (GMT)
Message-ID: <ac3b8c16-1f2b-4f2f-8bcd-ef8da8544a20@linux.ibm.com>
Date: Fri, 23 May 2025 10:55:24 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: fix the inaccurate memory statistics issue for
 users
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
        david@redhat.com, shakeelb@google.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA0MyBTYWx0ZWRfXxJRyzXsBHwPu ntI7I4Tfrkndp3EDwoJkzFtMFt1SrDrd4/OJZbkVsyFNhyXBqlWt5T60KgrRAvArIWyqbdojjLG xvVJUJdNJdVIVGHCaSNTyc3xl5x+5u23R45UgqRABKUzT59mII6631AnypDu8ziqwC5K08Awuvg
 6VpjHGcEG5Nmk1IRHV0xxuUMKApIVjqUQRxFaNUlnQuLz0ZmMU/X/hAwOKKSdKQWZ39Ygr8cKpH CSC1/iQEsdSZY89LbM1fYr2duU2XX4nj7/TRtaArr0AqZSd7zjIpZjtv+bEF1wQXTM88xCd9Y4t HedN3azxspFzNXi9Tj710bHdKQOOWBZvi1PrvwPMpfDp4w+BDdrFPtOMg7EbWSYZqXWKWRkrDcm
 JJa8uz8xYd+Fp7cJDie6iAnYKNvPzhzQXWP2AJIBzYYxyRXBvlQPOJ+6cJnHrLC7pNaZMH5g
X-Proofpoint-GUID: Fc8I8pRSBtQX3eEirUu-2IZEmgh7OJaG
X-Authority-Analysis: v=2.4 cv=O685vA9W c=1 sm=1 tr=0 ts=683006cd cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=bJgjvqlET6HPnKk_xIcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LM8uU1SdoVM6B511od_tFrYjKP9VKcpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230043


On 5/23/25 8:46 AM, Baolin Wang wrote:
> On some large machines with a high number of CPUs running a 64K kernel,
> we found that the 'RES' field is always 0 displayed by the top command
> for some processes, which will cause a lot of confusion for users.
>
>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>   875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>        1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
>
> The main reason is that the batch size of the percpu counter is quite large
> on these machines, caching a significant percpu value, since converting mm's
> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> stats into percpu_counter"). Intuitively, the batch number should be optimized,
> but on some paths, performance may take precedence over statistical accuracy.
> Therefore, introducing a new interface to add the percpu statistical count
> and display it to users, which can remove the confusion. In addition, this
> change is not expected to be on a performance-critical path, so the modification
> should be acceptable.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   fs/proc/task_mmu.c | 14 +++++++-------
>   include/linux/mm.h |  5 +++++
>   2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index b9e4fbbdf6e6..f629e6526935 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -36,9 +36,9 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>   	unsigned long text, lib, swap, anon, file, shmem;
>   	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
>   
> -	anon = get_mm_counter(mm, MM_ANONPAGES);
> -	file = get_mm_counter(mm, MM_FILEPAGES);
> -	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
> +	anon = get_mm_counter_sum(mm, MM_ANONPAGES);


Hi Baolin Wang,

We also observed the same issue where the RSS value in /proc/PID/status
was 0 on machines with a high number of CPUs. With this patch, the issue
got fixedl

Rss value without this patch
----------------------------
  # cat /proc/87406/status
.....
VmRSS:           0 kB
RssAnon:           0 kB
RssFile:           0 k


Rss values with this patch
--------------------------
  # cat /proc/3055/status
VmRSS:        2176 kB
RssAnon:         512 kB
RssFile:        1664 kB
RssShmem:           0 kB

Tested-by Donet Tom <donettom@linux.ibm.com>


> +	file = get_mm_counter_sum(mm, MM_FILEPAGES);
> +	shmem = get_mm_counter_sum(mm, MM_SHMEMPAGES);
>   
>   	/*
>   	 * Note: to minimize their overhead, mm maintains hiwater_vm and
> @@ -59,7 +59,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>   	text = min(text, mm->exec_vm << PAGE_SHIFT);
>   	lib = (mm->exec_vm << PAGE_SHIFT) - text;
>   
> -	swap = get_mm_counter(mm, MM_SWAPENTS);
> +	swap = get_mm_counter_sum(mm, MM_SWAPENTS);
>   	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
>   	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
>   	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
> @@ -92,12 +92,12 @@ unsigned long task_statm(struct mm_struct *mm,
>   			 unsigned long *shared, unsigned long *text,
>   			 unsigned long *data, unsigned long *resident)
>   {
> -	*shared = get_mm_counter(mm, MM_FILEPAGES) +
> -			get_mm_counter(mm, MM_SHMEMPAGES);
> +	*shared = get_mm_counter_sum(mm, MM_FILEPAGES) +
> +			get_mm_counter_sum(mm, MM_SHMEMPAGES);
>   	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
>   								>> PAGE_SHIFT;
>   	*data = mm->data_vm + mm->stack_vm;
> -	*resident = *shared + get_mm_counter(mm, MM_ANONPAGES);
> +	*resident = *shared + get_mm_counter_sum(mm, MM_ANONPAGES);
>   	return mm->total_vm;
>   }
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 185424858f23..15ec5cfe9515 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2568,6 +2568,11 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
>   	return percpu_counter_read_positive(&mm->rss_stat[member]);
>   }
>   
> +static inline unsigned long get_mm_counter_sum(struct mm_struct *mm, int member)
> +{
> +	return percpu_counter_sum_positive(&mm->rss_stat[member]);
> +}
> +
>   void mm_trace_rss_stat(struct mm_struct *mm, int member);
>   
>   static inline void add_mm_counter(struct mm_struct *mm, int member, long value)

