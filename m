Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA5E7AF8CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 05:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjI0DnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 23:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjI0DiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:38:06 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C741A64A;
        Tue, 26 Sep 2023 20:05:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RwM0l4zsfz4f3kpj;
        Wed, 27 Sep 2023 11:04:55 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgBHy6vWmxNl3palBQ--.62671S2;
        Wed, 27 Sep 2023 11:04:55 +0800 (CST)
Subject: Re: [PATCH] fuse: remove unneeded lock which protecting update of
 congestion_threshold
To:     Bernd Schubert <bernd.schubert@fastmail.fm>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230914154553.71939-1-shikemeng@huaweicloud.com>
 <9a5d4c82-1ab3-e96d-98bb-369acc8404d1@fastmail.fm>
 <177d891e-9258-68bb-72aa-4d4126403b7e@huaweicloud.com>
 <73e673d6-ecb8-dec9-bdc0-6dde9c4e76cb@fastmail.fm>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <a66f94b8-4330-4e0d-589c-a031a5b3802c@huaweicloud.com>
Date:   Wed, 27 Sep 2023 11:04:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <73e673d6-ecb8-dec9-bdc0-6dde9c4e76cb@fastmail.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHy6vWmxNl3palBQ--.62671S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4DKr1rZrWUJry5CF1DAwb_yoWrJw45pr
        WktFy2kFZ8Zws5urnFyF1Uu34rt3yfta1UWFyqgryUZrZ8Jw1F9FW2vrWYgFyUAr4xJa4q
        qF4Yg343ZF98AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



on 9/19/2023 9:12 PM, Bernd Schubert wrote:
> 
> 
> On 9/19/23 08:11, Kemeng Shi wrote:
>>
>>
>> on 9/16/2023 7:06 PM, Bernd Schubert wrote:
>>>
>>>
>>> On 9/14/23 17:45, Kemeng Shi wrote:
>>>> Commit 670d21c6e17f6 ("fuse: remove reliance on bdi congestion") change how
>>>> congestion_threshold is used and lock in
>>>> fuse_conn_congestion_threshold_write is not needed anymore.
>>>> 1. Access to supe_block is removed along with removing of bdi congestion.
>>>> Then down_read(&fc->killsb) which protecting access to super_block is no
>>>> needed.
>>>> 2. Compare num_background and congestion_threshold without holding
>>>> bg_lock. Then there is no need to hold bg_lock to update
>>>> congestion_threshold.
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>    fs/fuse/control.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
>>>> index 247ef4f76761..c5d7bf80efed 100644
>>>> --- a/fs/fuse/control.c
>>>> +++ b/fs/fuse/control.c
>>>> @@ -174,11 +174,7 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
>>>>        if (!fc)
>>>>            goto out;
>>>>    -    down_read(&fc->killsb);
>>>> -    spin_lock(&fc->bg_lock);
>>>>        fc->congestion_threshold = val;
>>>> -    spin_unlock(&fc->bg_lock);
>>>> -    up_read(&fc->killsb);
>>>>        fuse_conn_put(fc);
>>>>    out:
>>>>        return ret;
>>>
>>> Yeah, I don't see readers holding any of these locks.
>>> I just wonder if it wouldn't be better to use WRITE_ONCE to ensure a single atomic operation to store the value.
>> Sure, WRITE_ONCE looks better. I wonder if we should use READ_ONCE from reader.
>> Would like to get any advice. Thanks!
> 
Sorry for the dealy - it toke me some time to go through the barrier documents.
> I'm not entirely sure either, but I _think_ the compiler is free to store a 32 bit value  with multiple operations (like 2 x 16 bit). In that case a competing reading thread might read garbage...
> Although I don't see this documented here
> https://www.kernel.org/doc/Documentation/memory-barriers.txt
I found this is documented in section
"(*) For aligned memory locations whose size allows them to be accessed..."
Then WRITE_ONCE is absolutely needed now as you menthioned before.
> Though documented there is that the compile is free to optimize out the storage at all, see
> "(*) Similarly, the compiler is within its rights to omit a store entirely"
> 
> 
> Regarding READ_ONCE, I don't have a strong opinion, if the compiler makes some optimizations and the value would be wrong for a few cycles, would that matter for that variable? Unless the compiler would be really creative and the variable would get never updated... For sure READ_ONCE would be safer, but I don't know if it is needed
> SSee section
> "The compiler is within its rights to omit a load entirely if it know"
> in the document above.
I go through all examples of optimizations in document and congestion_threshold
has no same trouble descripted in document.
For specifc case you menthioned that "The compiler is within its rights to omit
a load entirely if it know". The compiler will keep the first load and only omit
successive loads from same variable in loop. As there is no repeat loading from
congestion_threshold in loop, congestion_threshold is out of this trouble.
Anyway, congestion_threshold is more like a hint and the worst case is that it is
stale for a few cycles. I prefer to keep reading congestion_threshold without
READ_ONCE and will do it in next version if it's fine to you. Thanks!
> 
> Thanks,
> Bernd
> 
> 
> 
> 

