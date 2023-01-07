Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB15660C2C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 04:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjAGDbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 22:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAGDbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 22:31:44 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40A4A87F3B;
        Fri,  6 Jan 2023 19:31:42 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8AxnOqd57hjHTQAAA--.579S3;
        Sat, 07 Jan 2023 11:31:41 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXL6a57hjVYgVAA--.36667S3;
        Sat, 07 Jan 2023 11:31:39 +0800 (CST)
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     sedat.dilek@gmail.com, Luis Chamberlain <mcgrof@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230106094844.26241-1-zhanghongchen@loongson.cn>
 <Y7hyw+fTdgAF6uYP@bombadil.infradead.org>
 <CA+icZUUdGCdzYvdi3_vdpHqNvE12wsAw3CKCmeut1-R78kjHHg@mail.gmail.com>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <f9d1231e-8a9f-487f-24d9-a3406de9d1f8@loongson.cn>
Date:   Sat, 7 Jan 2023 11:31:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUUdGCdzYvdi3_vdpHqNvE12wsAw3CKCmeut1-R78kjHHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxXL6a57hjVYgVAA--.36667S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZryfurWrCry5Kr1furykKrg_yoW8uryDpa
        93Ca92kFWktFy8Cay29FW2vFW0v39xWa4vqrWY9F1kXFyvgFnxXr43Gr1UC34kWr1kC3W5
        ua1UJr9a9r15ZaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sedat,

On 2023/1/7 am 4:33, Sedat Dilek wrote:
> On Fri, Jan 6, 2023 at 8:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> On Fri, Jan 06, 2023 at 05:48:44PM +0800, Hongchen Zhang wrote:
>>> Use spinlock in pipe_read/write cost too much time,IMO
>>> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
>>> On the other hand, we can use __pipe_{lock,unlock} to protect
>>> the pipe->{head,tail} in pipe_resize_ring and
>>> post_one_notification.
>>>
>>> I tested this patch using UnixBench's pipe test case on a x86_64
>>> machine,and get the following data:
>>> 1) before this patch
>>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
>>> Pipe Throughput                   12440.0     493023.3    396.3
>>>                                                          ========
>>> System Benchmarks Index Score (Partial Only)              396.3
>>>
>>> 2) after this patch
>>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
>>> Pipe Throughput                   12440.0     507551.4    408.0
>>>                                                          ========
>>> System Benchmarks Index Score (Partial Only)              408.0
>>>
>>> so we get ~3% speedup.
>>>
>>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>>> ---
>>
>> After the above "---" line you should have the changlog descrption.
>> For instance:
>>
>> v3:
>>    - fixes bleh blah blah
>> v2:
>>    - fixes 0-day report by ... etc..
>>    - fixes spelling or whatever
>>
>> I cannot decipher what you did here differently, not do I want to go
>> looking and diff'ing. So you are making the life of reviewer harder.
>>
> 
> Happy new 2023.
> 
> Positive wording... You can make reviewers' life easy when...
> (encourage people).
> Life is easy, people live hard.
> 
> +1 Adding ChangeLog of patch history
> 
> Cannot say...
> Might be good to add the link to Linus test-case + your results in the
> commit message as well?
> 
> ...
> Link: https://git.kernel.org/linus/0ddad21d3e99 (test-case of Linus
> suggested-by Andrew)
> ...
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ...
> 
> Thanks.
> 
> Best regards,
> -Sedat-
> 

OK, I have send a new v3 patch with these messages in commit message, 
Please help to check and review again.

Best Regards,
Hongchen Zhang

