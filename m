Return-Path: <linux-fsdevel+bounces-41023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEABBA2A0C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67179167D67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E641D224AF2;
	Thu,  6 Feb 2025 06:13:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0822332E;
	Thu,  6 Feb 2025 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738822404; cv=none; b=BC0Ew2dc1cQRxL0e0RQ9H3DwOhdpXExJSjYre5bGbhmn+ObTPZ0cglIbfje3E84jHNwuexmnzD25H/FUIKqGDtfpLKZBDVBOqaPmxDTt/JqOv3dSl6ay2jO02oyjjZa7EUpf9m8Eht8oQojmKpHRFhPXPYQPfNqNccSG29AKyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738822404; c=relaxed/simple;
	bh=QPSFVvim1khGndp9G0sS+Fqd4kfhnsgI0vmM66bRMGI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JqsMcCboFPObI9STZSicRvhYp2US7S7TI8NHtdWglwovu2Lcp1f05oog2aOciCO9tG2Zq7Rd3VvoC2pCHR0Xf6hTmof/kmYAxKCau6Bgwn/+dMzCwNnkqKx1ODJ8rC/WZCm7dVXFHQmpuCLl5cGEpk0KKA+td9JBSWJdRgoDbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YpRbs61Zhz4f3jks;
	Thu,  6 Feb 2025 14:12:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ABE591A058E;
	Thu,  6 Feb 2025 14:13:13 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCnCF34UqRnpFU0DA--.34331S2;
	Thu, 06 Feb 2025 14:13:13 +0800 (CST)
Subject: Re: [PATCH v4 2/5] Xarray: move forward index correctly in
 xas_pause()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20241218154613.58754-1-shikemeng@huaweicloud.com>
 <20241218154613.58754-3-shikemeng@huaweicloud.com>
 <CAMuHMdU_bfadUO=0OZ=AoQ9EAmQPA4wsLCBqohXR+QCeCKRn4A@mail.gmail.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <82014768-2ea7-2a28-cade-99d5d8ebe59e@huaweicloud.com>
Date: Thu, 6 Feb 2025 14:13:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU_bfadUO=0OZ=AoQ9EAmQPA4wsLCBqohXR+QCeCKRn4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnCF34UqRnpFU0DA--.34331S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW7Ww15Kw18XryUAF17GFg_yoWrCFWDpF
	WDJa4xKFW8Jr1Ikr18ta10q3409w1Yka13KrW5GF10yrsrCrnaya1jgrZ8uFyDuF4qvry2
	yF4vgw1qgw4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 1/28/2025 12:21 AM, Geert Uytterhoeven wrote:
> Hi Kemeng,
> 
> On Wed, 18 Dec 2024 at 07:58, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>> After xas_load(), xas->index could point to mid of found multi-index entry
>> and xas->index's bits under node->shift maybe non-zero. The afterward
>> xas_pause() will move forward xas->index with xa->node->shift with bits
>> under node->shift un-masked and thus skip some index unexpectedly.
>>
>> Consider following case:
>> Assume XA_CHUNK_SHIFT is 4.
>> xa_store_range(xa, 16, 31, ...)
>> xa_store(xa, 32, ...)
>> XA_STATE(xas, xa, 17);
>> xas_for_each(&xas,...)
>> xas_load(&xas)
>> /* xas->index = 17, xas->xa_offset = 1, xas->xa_node->xa_shift = 4 */
>> xas_pause()
>> /* xas->index = 33, xas->xa_offset = 2, xas->xa_node->xa_shift = 4 */
>> As we can see, index of 32 is skipped unexpectedly.
>>
>> Fix this by mask bit under node->xa_shift when move forward index in
>> xas_pause().
>>
>> For now, this will not cause serious problems. Only minor problem
>> like cachestat return less number of page status could happen.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Thanks for your patch, which is now commit c9ba5249ef8b080c ("Xarray:
> move forward index correctly in xas_pause()") upstream.
> 
>> --- a/lib/test_xarray.c
>> +++ b/lib/test_xarray.c
>> @@ -1448,6 +1448,41 @@ static noinline void check_pause(struct xarray *xa)
>>         XA_BUG_ON(xa, count != order_limit);
>>
>>         xa_destroy(xa);
>> +
>> +       index = 0;
>> +       for (order = XA_CHUNK_SHIFT; order > 0; order--) {
>> +               XA_BUG_ON(xa, xa_store_order(xa, index, order,
>> +                                       xa_mk_index(index), GFP_KERNEL));
>> +               index += 1UL << order;
>> +       }
>> +
>> +       index = 0;
>> +       count = 0;
>> +       xas_set(&xas, 0);
>> +       rcu_read_lock();
>> +       xas_for_each(&xas, entry, ULONG_MAX) {
>> +               XA_BUG_ON(xa, entry != xa_mk_index(index));
>> +               index += 1UL << (XA_CHUNK_SHIFT - count);
>> +               count++;
>> +       }
>> +       rcu_read_unlock();
>> +       XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
>> +
>> +       index = 0;
>> +       count = 0;
>> +       xas_set(&xas, XA_CHUNK_SIZE / 2 + 1);
>> +       rcu_read_lock();
>> +       xas_for_each(&xas, entry, ULONG_MAX) {
>> +               XA_BUG_ON(xa, entry != xa_mk_index(index));
>> +               index += 1UL << (XA_CHUNK_SHIFT - count);
>> +               count++;
>> +               xas_pause(&xas);
>> +       }
>> +       rcu_read_unlock();
>> +       XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
>> +
>> +       xa_destroy(xa);
>> +
>>  }
> 
> On m68k, the last four XA_BUG_ON() checks above are triggered when
> running the test.  With extra debug prints added:
> 
>     entry = 00000002 xa_mk_index(index) = 000000c1
>     entry = 00000002 xa_mk_index(index) = 000000e1
>     entry = 00000002 xa_mk_index(index) = 000000f1
>     ...
>     entry = 000000e2 xa_mk_index(index) = fffff0ff
>     entry = 000000f9 xa_mk_index(index) = fffff8ff
>     entry = 000000f2 xa_mk_index(index) = fffffcff
>     count = 63 XA_CHUNK_SHIFT = 6
>     entry = 00000081 xa_mk_index(index) = 00000001
>     entry = 00000002 xa_mk_index(index) = 00000081
>     entry = 00000002 xa_mk_index(index) = 000000c1
>     ...
>     entry = 000000e2 xa_mk_index(index) = ffffe0ff
>     entry = 000000f9 xa_mk_index(index) = fffff0ff
>     entry = 000000f2 xa_mk_index(index) = fffff8ff
>      count = 62 XA_CHUNK_SHIFT = 6
> 
> On arm32, the test succeeds, so it's probably not a 32-vs-64-bit issue.
> Perhaps a big-endian or alignment issue (alignof(int/long) = 2)?
Hi Geert,
Sorry for late reply. After check the debug info and the code, I think
the test is failed because CONFIG_XARRAY_MULTI is off. I guess
CONFIG_XARRAY_MULTI is on arm32 and is off on m68k so the test result
diffs. Luckly it's only a problem of of test code.
I will send patch to correct the test code soon. Thanks!

Kemeng

> 
>> --- a/lib/xarray.c
>> +++ b/lib/xarray.c
>> @@ -1147,6 +1147,7 @@ void xas_pause(struct xa_state *xas)
>>                         if (!xa_is_sibling(xa_entry(xas->xa, node, offset)))
>>                                 break;
>>                 }
>> +               xas->xa_index &= ~0UL << node->shift;
>>                 xas->xa_index += (offset - xas->xa_offset) << node->shift;
>>                 if (xas->xa_index == 0)
>>                         xas->xa_node = XAS_BOUNDS;
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


