Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765D567FC57
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 03:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjA2C32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Jan 2023 21:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjA2C30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:29:26 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24346234C3;
        Sat, 28 Jan 2023 18:29:24 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8DxnfAC2tVjNToJAA--.19808S3;
        Sun, 29 Jan 2023 10:29:22 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ7392dVj5uwjAA--.5993S3;
        Sun, 29 Jan 2023 10:29:18 +0800 (CST)
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        maobibo <maobibo@loongson.cn>,
        David Howells <dhowells@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230107012324.30698-1-zhanghongchen@loongson.cn>
 <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn>
 <4b140bd0-9b7f-50b5-9e3b-16d8afe52a50@loongson.cn>
 <Y8TUqcSO5VrbYfcM@casper.infradead.org> <Y8W9TR5ifZmRADLB@ZenIV>
 <20230116141608.a72015bdd8bbbedd5c50cc3e@linux-foundation.org>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <90dd93c0-d0ed-50c1-9a86-dad5bb3754af@loongson.cn>
Date:   Sun, 29 Jan 2023 10:29:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230116141608.a72015bdd8bbbedd5c50cc3e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxJ7392dVj5uwjAA--.5993S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KF4fKr17Ww1kurWUKrWruFg_yoW8ZFyfpF
        y3JFsFyw4DJr10yrsrt3yIvry8t3yfGF98XFn5KrZ7CFn0qFyFkFW7KFWa9rs3urn3K3Wj
        kw4jga4xZr1qva7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

Sorry to reply to you so late, because I took a long holiday.

On 2023/1/17 am 6:16, Andrew Morton wrote:
> On Mon, 16 Jan 2023 21:10:37 +0000 Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
>> On Mon, Jan 16, 2023 at 04:38:01AM +0000, Matthew Wilcox wrote:
>>> On Mon, Jan 16, 2023 at 11:16:13AM +0800, maobibo wrote:
>>>> Hongchen,
>>>>
>>>> I have a glance with this patch, it simply replaces with
>>>> spinlock_irqsave with mutex lock. There may be performance
>>>> improvement with two processes competing with pipe, however
>>>> for N processes, there will be complex context switches
>>>> and ipi interruptts.
>>>>
>>>> Can you find some cases with more than 2 processes competing
>>>> pipe, rather than only unixbench?
>>>
>>> What real applications have pipes with more than 1 writer & 1 reader?
>>> I'm OK with slowing down the weird cases if the common cases go faster.
>>
>> >From commit 0ddad21d3e99c743a3aa473121dc5561679e26bb:
>>      While this isn't a common occurrence in the traditional "use a pipe as a
>>      data transport" case, where you typically only have a single reader and
>>      a single writer process, there is one common special case: using a pipe
>>      as a source of "locking tokens" rather than for data communication.
>>      
>>      In particular, the GNU make jobserver code ends up using a pipe as a way
>>      to limit parallelism, where each job consumes a token by reading a byte
>>      from the jobserver pipe, and releases the token by writing a byte back
>>      to the pipe.
> 
> The author has tested this patch with Linus's test code from 0ddad21d3e
> and the results were OK
> (https://lkml.kernel.org/r/c3cbede6-f19e-3333-ba0f-d3f005e5d599@loongson.cn).
> 
> I've been stalling on this patch until Linus gets back to his desk,
> which now appears to have happened.
> 
> Hongchen, when convenient, please capture this discussion (as well as
> the testing results with Linus's sample code) in the changelog and send
> us a v4, with Linus on cc?
> 
I will send you a v4 and cc to Linus.

Thanks.
Hongchen Zhang

