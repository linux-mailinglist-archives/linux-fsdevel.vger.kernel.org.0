Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDFF66B585
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 03:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjAPCQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 21:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjAPCQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:16:42 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B5A146A3;
        Sun, 15 Jan 2023 18:16:39 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8Dxh+mGs8RjEsoBAA--.339S3;
        Mon, 16 Jan 2023 10:16:38 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+SEs8Rj2f4ZAA--.13846S3;
        Mon, 16 Jan 2023 10:16:37 +0800 (CST)
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     sedat.dilek@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230107012324.30698-1-zhanghongchen@loongson.cn>
 <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn>
 <CA+icZUU3-t0+NhdMQ39OeuwR13eMVOKVhLwS31WTHQ1ksaWgNg@mail.gmail.com>
 <CA+icZUXWAu_+KT9wYfdn7uSp1=ikO5ZdhM2VFokRi_JfhL455Q@mail.gmail.com>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <c896b0f8-e172-625c-59f2-a78c745c92f6@loongson.cn>
Date:   Mon, 16 Jan 2023 10:16:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUXWAu_+KT9wYfdn7uSp1=ikO5ZdhM2VFokRi_JfhL455Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxf+SEs8Rj2f4ZAA--.13846S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ww13CFyfXr1DJw18AFW7CFg_yoW8Kw4rpF
        93CFn7tr4DJw1UJry29Fn0qFWYv343WryqgrWUKFyUJ3ZYgwnrtF47JryUW3s8uF4FkF4r
        Aw4Ut3sFgF45AaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU89iSPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi sedat,


On 2023/1/16 am9:52, Sedat Dilek wrote:
> On Fri, Jan 13, 2023 at 10:32 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> On Fri, Jan 13, 2023 at 4:19 AM Hongchen Zhang
>> <zhanghongchen@loongson.cn> wrote:
>>>
>>> Hi All,
>>> any question about this patch, can it be merged?
>>>
>>> Thanks
>>> On 2023/1/7 am 9:23, Hongchen Zhang wrote:
>>>> Use spinlock in pipe_read/write cost too much time,IMO
>>>> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
>>>> On the other hand, we can use __pipe_{lock,unlock} to protect
>>>> the pipe->{head,tail} in pipe_resize_ring and
>>>> post_one_notification.
>>>>
>>>> Reminded by Matthew, I tested this patch using UnixBench's pipe
>>>> test case on a x86_64 machine,and get the following data:
>>>> 1) before this patch
>>>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
>>>> Pipe Throughput                   12440.0     493023.3    396.3
>>>>                                                           ========
>>>> System Benchmarks Index Score (Partial Only)              396.3
>>>>
>>>> 2) after this patch
>>>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
>>>> Pipe Throughput                   12440.0     507551.4    408.0
>>>>                                                           ========
>>>> System Benchmarks Index Score (Partial Only)              408.0
>>>>
>>>> so we get ~3% speedup.
>>>>
>>>> Reminded by Andrew, I tested this patch with the test code in
>>>> Linus's 0ddad21d3e99 add get following result:
>>
>> Happy new 2023 Hongchen Zhang,
>>
>> Thanks for the update and sorry for the late response.
>>
>> Should be "...s/add/and get following result:"
>>
>> I cannot say much about the patch itself or tested it in my build-environment.
>>
>> Best regards,
>> -Sedat-
>>
> 
> I have applied v3 on top of Linux v6.2-rc4.
> 
> Used pipebench for a quick testing.
> 
> # fdisk -l /dev/sdb
> Disk /dev/sdb: 14,91 GiB, 16013942784 bytes, 31277232 sectors
> Disk model: SanDisk iSSD P4
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x74f02dea
> 
> Device     Boot Start      End  Sectors  Size Id Type
> /dev/sdb1        2048 31277231 31275184 14,9G 83 Linux
> 
> # cat /dev/sdb | pipebench > /dev/null
> Summary:
> Piped   14.91 GB in 00h01m34.20s:  162.12 MB/second
> 
> Not tested/benchmarked with the kernel w/o your patch.
> 
> -Sedat-
> 
OK, If there is any problem, let's continue to discuss it
and hope it can be merged into the main line.

Best Regards,
Hongchen Zhang

