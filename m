Return-Path: <linux-fsdevel+bounces-44235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF93A665E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 03:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017423A9078
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 02:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B4158DAC;
	Tue, 18 Mar 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AHmfcYpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E83A1DB;
	Tue, 18 Mar 2025 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263250; cv=none; b=kUsiH9JAKGBxDSxXWvdl8sm/Jqx3o/ixONTpRYWfML1X8Qb/ql1Yz+igjH1nPOdBDWeJz0JssSE8kc3iS83plg+tvanRZ9EKm8OmpPIx+dS2qtQ45L6M9QB2H7iTGu6Hu5V/I4Q7V+GftTTBYl/r5/nZUj/Aqfv7nPACPU7TMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263250; c=relaxed/simple;
	bh=h6DxCv8KCQCCwl330zqTekHMwkW9BBmhURXCAhubH+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IirSk9NYImhbC905QQY2fmmj6igj7wvmnjIaUczCjcHOKJcojA0UIXohOwEKVyMouze1dFTr9nI+gqpLRAJ5yNmm4z907JWfzjnONEb/7CpiH/852Yis3yrJSMIJhQTG5NspqjHheg8o++Bv5jlqXRKhyTxCp8CJKSzNfgJtiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AHmfcYpP; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=h6DxCv8KCQCCwl330zqTekHMwkW9BBmhURXCAhubH+A=;
	b=AHmfcYpPlJtC1vOwUXsDFy11Om8PiFvxXTnX/XEG5VyKYVYN2E23NmLnAiNjWp
	mLvVlBxDoDG3rwdyZRICiUUtm/jyFbWm9sth3lo2/CVE2zQbB5140fQ7YIQxZKE7
	+JObgheOgvn0IhKGBY7ghlaye4Owa5cNGs6WaE6iS9Q6E=
Received: from [192.168.22.248] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3P_Cz09hnajuAAA--.18397S2;
	Tue, 18 Mar 2025 10:00:21 +0800 (CST)
Message-ID: <0693eb9c-226b-4233-9d60-dcd65967222a@163.com>
Date: Tue, 18 Mar 2025 10:00:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/proc/page: Refactoring to reduce code duplication.
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, ran.xiaokai@zte.com.cn, dan.carpenter@linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Liu Ye <liuye@kylinos.cn>
References: <20250317100719.134558-1-liuyerd@163.com>
 <a43ff37d-497c-4508-b6e5-667e060908cc@redhat.com>
Content-Language: en-US
From: Liu Ye <liuyerd@163.com>
In-Reply-To: <a43ff37d-497c-4508-b6e5-667e060908cc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P_Cz09hnajuAAA--.18397S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrW3uw4fWw4rJr15Xw4ruFg_yoWrKr17pF
	s8GF42ka18Ja45KrWxJaykZry5ZrykGF4UtrW7Gw1fXa47twna9a4FyFnYvFyxGryUAF1x
	ua9I9ry3uFWjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jB1vxUUUUU=
X-CM-SenderInfo: 5olx5vlug6il2tof0z/1tbiKBMUTGfY0I5n2QAAs8


在 2025/3/17 18:24, David Hildenbrand 写道:
> On 17.03.25 11:07, Liu Ye wrote:
>> From: Liu Ye <liuye@kylinos.cn>
>>
>> The function kpageflags_read and kpagecgroup_read is quite similar
>> to kpagecount_read. Consider refactoring common code into a helper
>> function to reduce code duplication.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>>
>> ---
>> V2 : Use an enumeration to indicate the operation to be performed
>> to avoid passing functions.
>> ---
>> ---
>>   fs/proc/page.c | 166 +++++++++++++++++--------------------------------
>>   1 file changed, 58 insertions(+), 108 deletions(-)
>>
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index a55f5acefa97..66f454330a87 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -22,6 +22,14 @@
>>   #define KPMMASK (KPMSIZE - 1)
>>   #define KPMBITS (KPMSIZE * BITS_PER_BYTE)
>>   +enum kpage_operation {
>> +    KPAGE_FLAGS,
>> +    KPAGE_COUNT,
>> +#ifdef CONFIG_MEMCG
>> +    KPAGE_CGROUP,
>> +#endif
>> +};
>> +
>>   static inline unsigned long get_max_dump_pfn(void)
>>   {
>>   #ifdef CONFIG_SPARSEMEM
>> @@ -37,19 +45,17 @@ static inline unsigned long get_max_dump_pfn(void)
>>   #endif
>>   }
>>   -/* /proc/kpagecount - an array exposing page mapcounts
>> - *
>> - * Each entry is a u64 representing the corresponding
>> - * physical page mapcount.
>> - */
>> -static ssize_t kpagecount_read(struct file *file, char __user *buf,
>> -                 size_t count, loff_t *ppos)
>> +static ssize_t kpage_read(struct file *file, char __user *buf,
>> +        size_t count, loff_t *ppos,
>> +        enum kpage_operation op)
>>   {
>>       const unsigned long max_dump_pfn = get_max_dump_pfn();
>>       u64 __user *out = (u64 __user *)buf;
>> +    struct page *ppage;
>>       unsigned long src = *ppos;
>>       unsigned long pfn;
>>       ssize_t ret = 0;
>> +    u64 info;
>>         pfn = src / KPMSIZE;
>>       if (src & KPMMASK || count & KPMMASK)
>> @@ -59,19 +65,29 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>>       count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>>         while (count > 0) {
>> -        struct page *page;
>> -        u64 mapcount = 0;
>> -
>> -        /*
>> -         * TODO: ZONE_DEVICE support requires to identify
>> -         * memmaps that were actually initialized.
>> -         */
>> -        page = pfn_to_online_page(pfn);
>> -        if (page)
>> -            mapcount = folio_precise_page_mapcount(page_folio(page),
>> -                                   page);
>> -
>> -        if (put_user(mapcount, out)) {
>> +        ppage = pfn_to_online_page(pfn);
>> +
>> +        if (ppage) {
>> +            switch (op) {
>> +            case KPAGE_FLAGS:
>> +                info = stable_page_flags(ppage);
>> +                break;
>> +            case KPAGE_COUNT:
>> +                info = folio_precise_page_mapcount(page_folio(ppage), ppage);
>> +                break;
>> +#ifdef CONFIG_MEMCG
>> +            case KPAGE_CGROUP:
>> +                info = page_cgroup_ino(ppage);
>> +                break;
>> +#endif
>
> In general, LGTM.
>
> I do wonder if we should just get rid of the two "#ifdef CONFIG_MEMCG" by adding
> a stub for page_cgroup_ino().
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 57664e2a8fb7b..24248f4dcc971 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1788,6 +1788,11 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>  {
>  }
>  
> +static inline ino_t page_cgroup_ino(struct page *page)
> +{
> +       return 0;
> +}
> +
>  #endif /* CONFIG_MEMCG */
>  
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
>
>
Agreed. I’ll add a stub for page_cgroup_ino() and remove the #ifdef CONFIG_MEMCG.

like this.

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 66f454330a87..cbadbf9568a1 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -25,9 +25,7 @@
 enum kpage_operation {
        KPAGE_FLAGS,
        KPAGE_COUNT,
-#ifdef CONFIG_MEMCG
        KPAGE_CGROUP,
-#endif
 };
 
 static inline unsigned long get_max_dump_pfn(void)
@@ -75,11 +73,9 @@ static ssize_t kpage_read(struct file *file, char __user *buf,
                        case KPAGE_COUNT:
                                info = folio_precise_page_mapcount(page_folio(ppage), ppage);
                                break;
-#ifdef CONFIG_MEMCG
                        case KPAGE_CGROUP:
                                info = page_cgroup_ino(ppage);
                                break;
-#endif
                        default:
                                info = 0;
                                break;
@@ -262,7 +258,6 @@ static const struct proc_ops kpageflags_proc_ops = {
 };
 
 #ifdef CONFIG_MEMCG
-
 static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
                size_t count, loff_t *ppos)
 {
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6e74b8254d9b..e806e2ebf5b8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1794,6 +1794,10 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 {
 }
 
+static inline ino_t page_cgroup_ino(struct page *page)
+{
+       return 0;
+}
 #endif /* CONFIG_MEMCG */
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)





