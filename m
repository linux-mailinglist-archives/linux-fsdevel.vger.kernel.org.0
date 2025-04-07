Return-Path: <linux-fsdevel+bounces-45832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0245A7D1C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 03:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE72169389
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 01:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6922212B0D;
	Mon,  7 Apr 2025 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ddscq2FF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DE12063F9;
	Mon,  7 Apr 2025 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743990078; cv=none; b=PUMSHXSDeA0u3YAgkB43V9kT9Ckr+tucK/lVsAuzPpqZHCWOLGJ8INM32CivO9SnZtOu4/GpyGDT3F2t8riWA2LAxQIG8enDY3PEHCDdAD+4BrOPhB6vrIqeYBaiY631of/RYcZOSaFfFeVaDop5x8NmhwGUednvWO773XNlPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743990078; c=relaxed/simple;
	bh=GkbpG4zdHL7ZRFR+4B/BVoLar8zHOqpkqt14tGLhgBQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vi0OmaYqtvGYdOWVawi2BUBRv2s1y0haagC7GTsxBzayuYKkT+z4aMwBYx8j6tSEvmtDR6RFSxbE+BB9Iy8pPDIe/G7za7AjV/4cgZl9TBrfAkpv4z2VJxNwwiPB8uWiT2d4wcvcVojjGXyp5uSiQ5X5Tn/Y8n3c03jt7DDhg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ddscq2FF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=FvmvB2Ur9V3JiBcAElYaFHJ791CrCzjrxmQzbqAxeIs=;
	b=ddscq2FFzWrFERGU/97MnsJmGwncZGlGBvAU//oe2DaSN4C8aOKIYxp/ZGH++x
	n9Ao6RQwvxI/TbaRqR0L6c6gmSUUyEynV5+C+tF58CtatFb9dLC5TNi7cT8trY+z
	BXVwos7tIL0iEKE+0jutLjSm1g9tVPmWEHyYpGr8QaaMs=
Received: from [192.168.22.248] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHrzTuLPNnAZvpEg--.33341S2;
	Mon, 07 Apr 2025 09:40:00 +0800 (CST)
Message-ID: <6d1714a4-097e-4d8e-9f2a-907f031ac8f9@163.com>
Date: Mon, 7 Apr 2025 09:39:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/proc/page: Refactoring to reduce code duplication.
From: Liu Ye <liuyerd@163.com>
To: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev,
 Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@redhat.com, svetly.todorov@memverge.com,
 vbabka@suse.cz, ran.xiaokai@zte.com.cn, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Liu Ye <liuye@kylinos.cn>
References: <20250318063226.223284-1-liuyerd@163.com>
 <c21dbc6b-3f1b-4015-9aee-44979ef0233e@163.com>
Content-Language: en-US
In-Reply-To: <c21dbc6b-3f1b-4015-9aee-44979ef0233e@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHrzTuLPNnAZvpEg--.33341S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr45Ww4fWF45Zr47CF1Utrb_yoW3Jry7pF
	4kGF4jya18XFyYkr12qws5Za4av3s3AF4jyrW7G3WfXFyqqrnakFySyFnY9FyxCryUZF1x
	XayqgrnxuFWjyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwa93UUUUU=
X-CM-SenderInfo: 5olx5vlug6il2tof0z/xtbBMRoaTGfgx7fuMwACsV

Friendly ping.

在 2025/3/24 11:25, Liu Ye 写道:
> Friendly ping.
>
> 在 2025/3/18 14:32, Liu Ye 写道:
>> From: Liu Ye <liuye@kylinos.cn>
>>
>> The function kpageflags_read and kpagecgroup_read is quite similar
>> to kpagecount_read. Consider refactoring common code into a helper
>> function to reduce code duplication.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>>
>> ---
>> V4 : Update code remake patch.
>> V3 : Add a stub for page_cgroup_ino and remove the #ifdef CONFIG_MEMCG.
>> V2 : Use an enumeration to indicate the operation to be performed
>> to avoid passing functions.
>> ---
>> ---
>>  fs/proc/page.c             | 161 +++++++++++++------------------------
>>  include/linux/memcontrol.h |   4 +
>>  2 files changed, 58 insertions(+), 107 deletions(-)
>>
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index 23fc771100ae..999af26c7298 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -22,6 +22,12 @@
>>  #define KPMMASK (KPMSIZE - 1)
>>  #define KPMBITS (KPMSIZE * BITS_PER_BYTE)
>>  
>> +enum kpage_operation {
>> +	KPAGE_FLAGS,
>> +	KPAGE_COUNT,
>> +	KPAGE_CGROUP,
>> +};
>> +
>>  static inline unsigned long get_max_dump_pfn(void)
>>  {
>>  #ifdef CONFIG_SPARSEMEM
>> @@ -37,19 +43,17 @@ static inline unsigned long get_max_dump_pfn(void)
>>  #endif
>>  }
>>  
>> -/* /proc/kpagecount - an array exposing page mapcounts
>> - *
>> - * Each entry is a u64 representing the corresponding
>> - * physical page mapcount.
>> - */
>> -static ssize_t kpagecount_read(struct file *file, char __user *buf,
>> -			     size_t count, loff_t *ppos)
>> +static ssize_t kpage_read(struct file *file, char __user *buf,
>> +		size_t count, loff_t *ppos,
>> +		enum kpage_operation op)
>>  {
>>  	const unsigned long max_dump_pfn = get_max_dump_pfn();
>>  	u64 __user *out = (u64 __user *)buf;
>> +	struct page *page;
>>  	unsigned long src = *ppos;
>>  	unsigned long pfn;
>>  	ssize_t ret = 0;
>> +	u64 info;
>>  
>>  	pfn = src / KPMSIZE;
>>  	if (src & KPMMASK || count & KPMMASK)
>> @@ -59,24 +63,34 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>>  	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>>  
>>  	while (count > 0) {
>> -		struct page *page;
>> -		u64 mapcount = 0;
>> -
>>  		/*
>>  		 * TODO: ZONE_DEVICE support requires to identify
>>  		 * memmaps that were actually initialized.
>>  		 */
>>  		page = pfn_to_online_page(pfn);
>> -		if (page) {
>> -			struct folio *folio = page_folio(page);
>>  
>> -			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
>> -				mapcount = folio_precise_page_mapcount(folio, page);
>> -			else
>> -				mapcount = folio_average_page_mapcount(folio);
>> -		}
>> -
>> -		if (put_user(mapcount, out)) {
>> +		if (page) {
>> +			switch (op) {
>> +			case KPAGE_FLAGS:
>> +				info = stable_page_flags(page);
>> +				break;
>> +			case KPAGE_COUNT:
>> +				if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
>> +					info = folio_precise_page_mapcount(page_folio(page), page);
>> +				else
>> +					info = folio_average_page_mapcount(page_folio(page));
>> +				break;
>> +			case KPAGE_CGROUP:
>> +				info = page_cgroup_ino(page);
>> +				break;
>> +			default:
>> +				info = 0;
>> +				break;
>> +			}
>> +		} else
>> +			info = 0;
>> +
>> +		if (put_user(info, out)) {
>>  			ret = -EFAULT;
>>  			break;
>>  		}
>> @@ -94,17 +108,23 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>>  	return ret;
>>  }
>>  
>> +/* /proc/kpagecount - an array exposing page mapcounts
>> + *
>> + * Each entry is a u64 representing the corresponding
>> + * physical page mapcount.
>> + */
>> +static ssize_t kpagecount_read(struct file *file, char __user *buf,
>> +		size_t count, loff_t *ppos)
>> +{
>> +	return kpage_read(file, buf, count, ppos, KPAGE_COUNT);
>> +}
>> +
>>  static const struct proc_ops kpagecount_proc_ops = {
>>  	.proc_flags	= PROC_ENTRY_PERMANENT,
>>  	.proc_lseek	= mem_lseek,
>>  	.proc_read	= kpagecount_read,
>>  };
>>  
>> -/* /proc/kpageflags - an array exposing page flags
>> - *
>> - * Each entry is a u64 representing the corresponding
>> - * physical page flags.
>> - */
>>  
>>  static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
>>  {
>> @@ -225,47 +245,17 @@ u64 stable_page_flags(const struct page *page)
>>  #endif
>>  
>>  	return u;
>> -};
>> +}
>>  
>> +/* /proc/kpageflags - an array exposing page flags
>> + *
>> + * Each entry is a u64 representing the corresponding
>> + * physical page flags.
>> + */
>>  static ssize_t kpageflags_read(struct file *file, char __user *buf,
>> -			     size_t count, loff_t *ppos)
>> +		size_t count, loff_t *ppos)
>>  {
>> -	const unsigned long max_dump_pfn = get_max_dump_pfn();
>> -	u64 __user *out = (u64 __user *)buf;
>> -	unsigned long src = *ppos;
>> -	unsigned long pfn;
>> -	ssize_t ret = 0;
>> -
>> -	pfn = src / KPMSIZE;
>> -	if (src & KPMMASK || count & KPMMASK)
>> -		return -EINVAL;
>> -	if (src >= max_dump_pfn * KPMSIZE)
>> -		return 0;
>> -	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>> -
>> -	while (count > 0) {
>> -		/*
>> -		 * TODO: ZONE_DEVICE support requires to identify
>> -		 * memmaps that were actually initialized.
>> -		 */
>> -		struct page *page = pfn_to_online_page(pfn);
>> -
>> -		if (put_user(stable_page_flags(page), out)) {
>> -			ret = -EFAULT;
>> -			break;
>> -		}
>> -
>> -		pfn++;
>> -		out++;
>> -		count -= KPMSIZE;
>> -
>> -		cond_resched();
>> -	}
>> -
>> -	*ppos += (char __user *)out - buf;
>> -	if (!ret)
>> -		ret = (char __user *)out - buf;
>> -	return ret;
>> +	return kpage_read(file, buf, count, ppos, KPAGE_FLAGS);
>>  }
>>  
>>  static const struct proc_ops kpageflags_proc_ops = {
>> @@ -276,53 +266,10 @@ static const struct proc_ops kpageflags_proc_ops = {
>>  
>>  #ifdef CONFIG_MEMCG
>>  static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
>> -				size_t count, loff_t *ppos)
>> +		size_t count, loff_t *ppos)
>>  {
>> -	const unsigned long max_dump_pfn = get_max_dump_pfn();
>> -	u64 __user *out = (u64 __user *)buf;
>> -	struct page *ppage;
>> -	unsigned long src = *ppos;
>> -	unsigned long pfn;
>> -	ssize_t ret = 0;
>> -	u64 ino;
>> -
>> -	pfn = src / KPMSIZE;
>> -	if (src & KPMMASK || count & KPMMASK)
>> -		return -EINVAL;
>> -	if (src >= max_dump_pfn * KPMSIZE)
>> -		return 0;
>> -	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>> -
>> -	while (count > 0) {
>> -		/*
>> -		 * TODO: ZONE_DEVICE support requires to identify
>> -		 * memmaps that were actually initialized.
>> -		 */
>> -		ppage = pfn_to_online_page(pfn);
>> -
>> -		if (ppage)
>> -			ino = page_cgroup_ino(ppage);
>> -		else
>> -			ino = 0;
>> -
>> -		if (put_user(ino, out)) {
>> -			ret = -EFAULT;
>> -			break;
>> -		}
>> -
>> -		pfn++;
>> -		out++;
>> -		count -= KPMSIZE;
>> -
>> -		cond_resched();
>> -	}
>> -
>> -	*ppos += (char __user *)out - buf;
>> -	if (!ret)
>> -		ret = (char __user *)out - buf;
>> -	return ret;
>> +	return kpage_read(file, buf, count, ppos, KPAGE_CGROUP);
>>  }
>> -
>>  static const struct proc_ops kpagecgroup_proc_ops = {
>>  	.proc_flags	= PROC_ENTRY_PERMANENT,
>>  	.proc_lseek	= mem_lseek,
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 53364526d877..5264d148bdd9 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1793,6 +1793,10 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>>  {
>>  }
>>  
>> +static inline ino_t page_cgroup_ino(struct page *page)
>> +{
>> +	return 0;
>> +}
>>  #endif /* CONFIG_MEMCG */
>>  
>>  #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)


