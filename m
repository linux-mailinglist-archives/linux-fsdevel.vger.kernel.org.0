Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA82613921
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 15:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiJaOg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiJaOgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:36:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F2CB30
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 07:36:22 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1G0z3nYZzHvTs;
        Mon, 31 Oct 2022 22:36:03 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 22:36:20 +0800
Subject: Re: [PATCH v2] fs: fix undefined behavior in bit shift for SB_NOUSER
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <dhowells@redhat.com>
References: <20221031134811.178127-1-cuigaosheng1@huawei.com>
 <Y1/TWdY//yUgXGck@casper.infradead.org>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <3dcc91f9-48ef-5874-955a-dd5e1492a648@huawei.com>
Date:   Mon, 31 Oct 2022 22:36:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Y1/TWdY//yUgXGck@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Shouldn't those ^^^ also be marked as unsigned?  And it's confusing to
> have the style change halfway through the sequence; can you convert them
> to (1U << n) as well?

Thanks, I have made a patch v3 and submit it, but I'm not sure should I
add "Reviewed-by: Christoph Hellwig<hch@lst.de>"  because the code has been
changed,Thank you all again!

On 2022/10/31 21:53, Matthew Wilcox wrote:
> On Mon, Oct 31, 2022 at 09:48:11PM +0800, Gaosheng Cui wrote:
>> +++ b/include/linux/fs.h
>> @@ -1384,19 +1384,19 @@ extern int send_sigurg(struct fown_struct *fown);
>>   #define SB_NOATIME	1024	/* Do not update access times. */
>>   #define SB_NODIRATIME	2048	/* Do not update directory access times */
>>   #define SB_SILENT	32768
> Shouldn't those ^^^ also be marked as unsigned?  And it's confusing to
> have the style change halfway through the sequence; can you convert them
> to (1U << n) as well?
>
>> -#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
>> -#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
>> -#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
>> -#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
>> -#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
>> +#define SB_POSIXACL	(1U << 16) /* VFS does not apply the umask */
>> +#define SB_INLINECRYPT	(1U << 17) /* Use blk-crypto for encrypted files */
>> +#define SB_KERNMOUNT	(1U << 22) /* this is a kern_mount call */
>> +#define SB_I_VERSION	(1U << 23) /* Update inode I_version field */
>> +#define SB_LAZYTIME	(1U << 25) /* Update the on-disk [acm]times lazily */
>>   
>>   /* These sb flags are internal to the kernel */
>> -#define SB_SUBMOUNT     (1<<26)
>> -#define SB_FORCE    	(1<<27)
>> -#define SB_NOSEC	(1<<28)
>> -#define SB_BORN		(1<<29)
>> -#define SB_ACTIVE	(1<<30)
>> -#define SB_NOUSER	(1<<31)
>> +#define SB_SUBMOUNT	(1U << 26)
>> +#define SB_FORCE	(1U << 27)
>> +#define SB_NOSEC	(1U << 28)
>> +#define SB_BORN		(1U << 29)
>> +#define SB_ACTIVE	(1U << 30)
>> +#define SB_NOUSER	(1U << 31)
>>   
>>   /* These flags relate to encoding and casefolding */
>>   #define SB_ENC_STRICT_MODE_FL	(1 << 0)
>> -- 
>> 2.25.1
>>
> .
