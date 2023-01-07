Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048BA660B22
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 01:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbjAGA6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 19:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAGA6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:58:14 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ADEB271A8;
        Fri,  6 Jan 2023 16:58:12 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8CxjfCjw7hjYioAAA--.1002S3;
        Sat, 07 Jan 2023 08:58:11 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHuSiw7hjK3cVAA--.64673S3;
        Sat, 07 Jan 2023 08:58:10 +0800 (CST)
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Luis Chamberlain <mcgrof@kernel.org>
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
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <9da36d2c-2229-08a4-d78f-e789b93132b1@loongson.cn>
Date:   Sat, 7 Jan 2023 08:58:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y7hyw+fTdgAF6uYP@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxHuSiw7hjK3cVAA--.64673S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr43ZFWktr45KFWDZr4Dtwb_yoW8Wr1rpa
        s3AFZ2krWkJFy8AF929Fy7ZayFv39xWas5tryj9FWkJFykWrW7trnIg3WjkFy8Wrs3Aa4Y
        9a1UXF9I9w45ZaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis,

On 2023/1/7 上午3:13, Luis Chamberlain wrote:
> On Fri, Jan 06, 2023 at 05:48:44PM +0800, Hongchen Zhang wrote:
>> Use spinlock in pipe_read/write cost too much time,IMO
>> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
>> On the other hand, we can use __pipe_{lock,unlock} to protect
>> the pipe->{head,tail} in pipe_resize_ring and
>> post_one_notification.
>>
>> I tested this patch using UnixBench's pipe test case on a x86_64
>> machine,and get the following data:
>> 1) before this patch
>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
>> Pipe Throughput                   12440.0     493023.3    396.3
>>                                                          ========
>> System Benchmarks Index Score (Partial Only)              396.3
>>
>> 2) after this patch
>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
>> Pipe Throughput                   12440.0     507551.4    408.0
>>                                                          ========
>> System Benchmarks Index Score (Partial Only)              408.0
>>
>> so we get ~3% speedup.
>>
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> ---
> 
> After the above "---" line you should have the changlog descrption.
> For instance:
> 
> v3:
>    - fixes bleh blah blah
> v2:
>    - fixes 0-day report by ... etc..
>    - fixes spelling or whatever
> 
> I cannot decipher what you did here differently, not do I want to go
> looking and diff'ing. So you are making the life of reviewer harder.
> 
>    Luis
> 
Matthew also reminded me to add the change log, but I don't think it is 
necessary to write the change log to fix the errors in the patch. 
Anyway, I think it is a good habit and will add these contents in the 
new v3 version.

Best Regards,
Hongchen Zhang

