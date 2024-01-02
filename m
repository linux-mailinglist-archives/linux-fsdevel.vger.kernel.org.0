Return-Path: <linux-fsdevel+bounces-7062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E890D821670
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 03:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F7AB21229
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 02:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669410E1;
	Tue,  2 Jan 2024 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lhzNXiWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13CA3C;
	Tue,  2 Jan 2024 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4021N2Zd007630;
	Tue, 2 Jan 2024 02:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZGxsmnDMc0vbTKGtH4YJqhEz5lvxf1xws5Jq2QyBRnw=; b=lh
	zNXiWfi4qdUlLMM8qujDNCv3SGLhdKdgXAzAJfMrG0SI7M8XCH//UqLWTandHt2q
	bgPEyGWMR/G0QK6VZJYEPcGVJFfg9ugTOr9vW1r0fkGVSdKzGtwl9b6BI+TJgYfe
	DofAcrV1KZzdmNUxV1HluuccluCzXdOn0iLmfV9L0VQkMc9xTwHlmA8+sOnYd8DF
	rJNci9xBGIHcq5nXTf9qYIz7VngxX0c7RmvwXW42OeKLHDpLRs6bSzuUCEyCbSWo
	yAD6q4L4qm20jorNHKvbVqzRz+GCsljj5UCdcfkb0MQSkRy0+GJd1tALIArNauQn
	GCeXUKnVIEEE3/Nr/SBw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vaa7cbx2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 02:19:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4022JwdX031534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 02:19:58 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Jan
 2024 18:19:50 -0800
Message-ID: <cd0f6613-9aa9-4698-bebe-0f61286d7552@quicinc.com>
Date: Tue, 2 Jan 2024 10:19:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman"
	<ebiederm@xmission.com>,
        Hillf Danton <hdanton@sina.com>
CC: <kernel@quicinc.com>, <quic_pkondeti@quicinc.com>, <keescook@chromium.or>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <oleg@redhat.com>,
        <dhowells@redhat.com>, <jarkko@kernel.org>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>
 <ZY30k7OCtxrdR9oP@casper.infradead.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <ZY30k7OCtxrdR9oP@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ieBhQjEar3H5w9T9G5k9p8BSV-vJJDVH
X-Proofpoint-ORIG-GUID: ieBhQjEar3H5w9T9G5k9p8BSV-vJJDVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=518
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401020017



On 12/29/2023 6:20 AM, Matthew Wilcox wrote:
> On Wed, Dec 13, 2023 at 12:27:05PM -0600, Eric W. Biederman wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>>> I think the right way to fix this is to pass a boolean flag to
>>> queued_write_lock_slowpath() to let it know whether it can re-enable
>>> interrupts while checking whether _QW_WAITING is set.
>>
>> Yes.  It seems to make sense to distinguish between write_lock_irq and
>> write_lock_irqsave and fix this for all of write_lock_irq.
> 
> I wasn't planning on doing anything here, but Hillf kind of pushed me into
> it.  I think it needs to be something like this.  Compile tested only.
> If it ends up getting used,
Happy new year!
Thx Metthew for chiming into this. I think more thoughts will gain more 
perfect designs.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index 75b8f4601b28..1152e080c719 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -33,8 +33,8 @@
>   /*
>    * External function declarations
>    */
> -extern void queued_read_lock_slowpath(struct qrwlock *lock);
> -extern void queued_write_lock_slowpath(struct qrwlock *lock);
> +void queued_read_lock_slowpath(struct qrwlock *lock);
> +void queued_write_lock_slowpath(struct qrwlock *lock, bool irq);
>   
>   /**
>    * queued_read_trylock - try to acquire read lock of a queued rwlock
> @@ -98,7 +98,21 @@ static inline void queued_write_lock(struct qrwlock *lock)
>   	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
>   		return;
>   
> -	queued_write_lock_slowpath(lock);
> +	queued_write_lock_slowpath(lock, false);
> +}
> +
> +/**
> + * queued_write_lock_irq - acquire write lock of a queued rwlock
> + * @lock : Pointer to queued rwlock structure
> + */
> +static inline void queued_write_lock_irq(struct qrwlock *lock)
> +{
> +	int cnts = 0;
> +	/* Optimize for the unfair lock case where the fair flag is 0. */
> +	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
> +		return;
> +
> +	queued_write_lock_slowpath(lock, true);
>   }
>   
>   /**
> @@ -138,6 +152,7 @@ static inline int queued_rwlock_is_contended(struct qrwlock *lock)
>    */
>   #define arch_read_lock(l)		queued_read_lock(l)
>   #define arch_write_lock(l)		queued_write_lock(l)
> +#define arch_write_lock_irq(l)		queued_write_lock_irq(l)
>   #define arch_read_trylock(l)		queued_read_trylock(l)
>   #define arch_write_trylock(l)		queued_write_trylock(l)
>   #define arch_read_unlock(l)		queued_read_unlock(l)
> diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
> index c0ef596f340b..897010b6ba0a 100644
> --- a/include/linux/rwlock.h
> +++ b/include/linux/rwlock.h
> @@ -33,6 +33,7 @@ do {								\
>    extern int do_raw_read_trylock(rwlock_t *lock);
>    extern void do_raw_read_unlock(rwlock_t *lock) __releases(lock);
>    extern void do_raw_write_lock(rwlock_t *lock) __acquires(lock);
> + extern void do_raw_write_lock_irq(rwlock_t *lock) __acquires(lock);
>    extern int do_raw_write_trylock(rwlock_t *lock);
>    extern void do_raw_write_unlock(rwlock_t *lock) __releases(lock);
>   #else
> @@ -40,6 +41,7 @@ do {								\
>   # define do_raw_read_trylock(rwlock)	arch_read_trylock(&(rwlock)->raw_lock)
>   # define do_raw_read_unlock(rwlock)	do {arch_read_unlock(&(rwlock)->raw_lock); __release(lock); } while (0)
>   # define do_raw_write_lock(rwlock)	do {__acquire(lock); arch_write_lock(&(rwlock)->raw_lock); } while (0)
> +# define do_raw_write_lock_irq(rwlock)	do {__acquire(lock); arch_write_lock_irq(&(rwlock)->raw_lock); } while (0)
>   # define do_raw_write_trylock(rwlock)	arch_write_trylock(&(rwlock)->raw_lock)
>   # define do_raw_write_unlock(rwlock)	do {arch_write_unlock(&(rwlock)->raw_lock); __release(lock); } while (0)
>   #endif
> diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
> index dceb0a59b692..6257976dfb72 100644
> --- a/include/linux/rwlock_api_smp.h
> +++ b/include/linux/rwlock_api_smp.h
> @@ -193,7 +193,7 @@ static inline void __raw_write_lock_irq(rwlock_t *lock)
>   	local_irq_disable();
>   	preempt_disable();
>   	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> -	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
> +	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock_irq);
>   }
>   
>   static inline void __raw_write_lock_bh(rwlock_t *lock)
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index d2ef312a8611..6c644a71b01d 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -61,9 +61,10 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
>   
>   /**
>    * queued_write_lock_slowpath - acquire write lock of a queued rwlock
> - * @lock : Pointer to queued rwlock structure
> + * @lock: Pointer to queued rwlock structure
> + * @irq: True if we can enable interrupts while spinning
>    */
> -void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
> +void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock, bool irq)
>   {
>   	int cnts;
>   
> @@ -82,7 +83,11 @@ void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
>   
Also a new state showed up after the current design:
1. locked flag with _QW_WAITING, while irq enabled.
2. And this state will be only in interrupt context.
3. lock->wait_lock is hold by the write waiter.
So per my understanding, a different behavior also needed to be done in 
queued_write_lock_slowpath:
   when (unlikely(in_interrupt())) , get the lock directly.
So needed to be done in release path. This is to address Hillf's concern 
on possibility of deadlock.

Add Hillf here to merge thread. I am going to have a tested patch V2 
accordingly.
Feel free to let me know your thoughts prior on that.
>   	/* When no more readers or writers, set the locked flag */
>   	do {
> +		if (irq)
> +			local_irq_enable();
I think write_lock_irqsave also needs to be take account. So 
loal_irq_save(flags) should be take into account here.
>   		cnts = atomic_cond_read_relaxed(&lock->cnts, VAL == _QW_WAITING);
> +		if (irq)
> +			local_irq_disable();
ditto.
>   	} while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));
>   unlock:
>   	arch_spin_unlock(&lock->wait_lock);
> diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
> index 87b03d2e41db..bf94551d7435 100644
> --- a/kernel/locking/spinlock_debug.c
> +++ b/kernel/locking/spinlock_debug.c
> @@ -212,6 +212,13 @@ void do_raw_write_lock(rwlock_t *lock)
>   	debug_write_lock_after(lock);
>   }
>   
> +void do_raw_write_lock_irq(rwlock_t *lock)
> +{
> +	debug_write_lock_before(lock);
> +	arch_write_lock_irq(&lock->raw_lock);
> +	debug_write_lock_after(lock);
> +}
> +
>   int do_raw_write_trylock(rwlock_t *lock)
>   {
>   	int ret = arch_write_trylock(&lock->raw_lock);

-- 
Thx and BRs,
Aiqun(Maria) Yu

