Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38B265FC41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 08:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjAFHuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 02:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFHuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:50:16 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B4496E0C4;
        Thu,  5 Jan 2023 23:50:12 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8Ax3eqz0rdj6woAAA--.39S3;
        Fri, 06 Jan 2023 15:50:11 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxnb6x0rdjhRsVAA--.39619S3;
        Fri, 06 Jan 2023 15:50:10 +0800 (CST)
Subject: Re: [PATCH v2] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103063303.23345-1-zhanghongchen@loongson.cn>
 <20230105185909.c77ce4d136279ec46a204d61@linux-foundation.org>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <c3cbede6-f19e-3333-ba0f-d3f005e5d599@loongson.cn>
Date:   Fri, 6 Jan 2023 15:50:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230105185909.c77ce4d136279ec46a204d61@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxnb6x0rdjhRsVAA--.39619S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr1DGr1fXw1UGF18Kry3Arb_yoW8Aw13pF
        Wxtr4vkr4kuFy5Xw12kry5W34rC3yFgrsrJrZYqF1q93W5uwn5KFWfJFWY9r13AF12k3W3
        Zr4jqayUXFWUJaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AF
        wI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
        AE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,
On 2023/1/6 am 10:59, Andrew Morton wrote:
> On Tue,  3 Jan 2023 14:33:03 +0800 Hongchen Zhang <zhanghongchen@loongson.cn> wrote:
> 
>> Use spinlock in pipe_read/write cost too much time,IMO
>> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
>> On the other hand, we can use __pipe_lock/unlock to protect the
>> pipe->head/tail in pipe_resize_ring and post_one_notification.
> 
> Can you please test this with the test code in Linus's 0ddad21d3e99 and
> check that performance is good?
> 
I tested with the test code in Linus's 0ddad21d3e99,and get the 
following result:

1) before this patch
          13,136.54 msec task-clock           #    3.870 CPUs utilized 

          1,186,779      context-switches     #   90.342 K/sec 

            668,867      cpu-migrations       #   50.917 K/sec 

                895      page-faults          #   68.131 /sec 

     29,875,711,543      cycles               #    2.274 GHz 

     12,372,397,462      instructions         #    0.41  insn per cycle 

      2,480,235,723      branches             #  188.804 M/sec 

         47,191,943      branch-misses        #    1.90% of all branches 


        3.394806886 seconds time elapsed

        0.037869000 seconds user
        0.189346000 seconds sys

2) after this patch

          12,395.63 msec task-clock          #    4.138 CPUs utilized 

          1,193,381      context-switches    #   96.274 K/sec 

            585,543      cpu-migrations      #   47.238 K/sec 

              1,063      page-faults         #   85.756 /sec 

     27,691,587,226      cycles              #    2.234 GHz 

     11,738,307,999      instructions        #    0.42  insn per cycle 

      2,351,299,522      branches            #  189.688 M/sec 

         45,404,526      branch-misses       #    1.93% of all branches 


        2.995280878 seconds time elapsed

        0.010615000 seconds user
        0.206999000 seconds sys
After adding this patch, the time used on this test program becomes less.

Another thing, because of my carelessness, trinity tool tested a bug, I
will remove the unnecessary __pipe_{lock,unlock} in pipe_resize_ring in 
v3, because the lock is owned in pipe_fcntl/pipe_ioctl.

Thanks.



