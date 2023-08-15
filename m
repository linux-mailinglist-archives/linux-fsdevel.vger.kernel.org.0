Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013A77C751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 08:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjHOGCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 02:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjHOGCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:02:25 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30DFA93;
        Mon, 14 Aug 2023 23:02:20 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.29])
        by gateway (Coremail) with SMTP id _____8AxCPLqFNtkwKUYAA--.50808S3;
        Tue, 15 Aug 2023 14:02:18 +0800 (CST)
Received: from [10.180.13.29] (unknown [10.180.13.29])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPCPpFNtkGe9aAA--.8359S3;
        Tue, 15 Aug 2023 14:02:17 +0800 (CST)
Subject: Re: [PATCH v5 2/2] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Jens Axboe <axboe@kernel.dk>, David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <20230811010309.20196-2-zhanghongchen@loongson.cn>
 <20230811010309.20196-1-zhanghongchen@loongson.cn>
 <3955287.1692002820@warthog.procyon.org.uk>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <35d71280-380c-bcda-9e82-32bd8e6cb631@loongson.cn>
Date:   Tue, 15 Aug 2023 14:01:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3955287.1692002820@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPCPpFNtkGe9aAA--.8359S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAEB2Ta+zIAbwABsb
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_JF0_Jw1l4c8EcI0E
        c7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF
        0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x07j83kZUUUUU=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2023/8/14 下午4:47, David Howells wrote:
> Hongchen Zhang <zhanghongchen@loongson.cn> wrote:
> 
>> -	spin_lock_irq(&pipe->rd_wait.lock);
>> +	__pipe_lock(pipe);
> 
> This mustn't sleep.  post_one_notification() needs to be callable with a
> spinlock held.
Hi David,
Where is the usage scenario for post_one_notification, or what usage 
scenarios will it be used in the future?
IMO, it is not advisable for a debugging tool to affect the performance
of an syscall.
> 
> David
> 

-- 
Best Regards
Hongchen Zhang

