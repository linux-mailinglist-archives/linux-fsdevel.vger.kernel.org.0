Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B794E505E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 11:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbiCWKg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 06:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiCWKg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:36:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E925E81;
        Wed, 23 Mar 2022 03:34:58 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KNl7R2yBxzfYqr;
        Wed, 23 Mar 2022 18:33:23 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 18:34:56 +0800
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 18:34:56 +0800
Subject: Re: [PATCH -next] uaccess: fix __access_ok limit setup in compat mode
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stafford Horne <shorne@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20220318071130.163942-1-chenjiahao16@huawei.com>
 <CAK8P3a3==vLKZUOceuMh3X1U5_sN82Vpm8J_3P-H-+q3sKKMxg@mail.gmail.com>
 <88ff36b3-558b-9c3f-f21d-5ef05b3227c5@huawei.com>
 <CAK8P3a3_iZihNmgRNz7Ntrp8sj0hB_Yrpu5iT++ivMjsUXH7+w@mail.gmail.com>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
Message-ID: <6517b497-f85e-c4dd-98b9-39997ad120d5@huawei.com>
Date:   Wed, 23 Mar 2022 18:34:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3_iZihNmgRNz7Ntrp8sj0hB_Yrpu5iT++ivMjsUXH7+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2022/3/22 22:41, Arnd Bergmann 写道:
> On Tue, Mar 22, 2022 at 1:55 PM chenjiahao (C) <chenjiahao16@huawei.com> wrote:
>> 在 2022/3/18 15:44, Arnd Bergmann 写道:
>>> This should not result in any user visible difference, in both cases
>>> user process will see a -EFAULT return code from its system call.
>>> Are you able to come up with a test case that shows an observable
>>> difference in behavior?
>> Actually, this patch do comes from a testcase failure, the code is
>> pasted below:
> Thank you for the test case!
>
>> #define TMPFILE "__1234567890"
>> #define BUF_SIZE    1024
>>
>> int main()
>> {
>>       char buf[BUF_SIZE] = {0};
>>       int fd;
>>       int ret;
>>       int err;
>>
>>       fd = open(TMPFILE, O_CREAT | O_RDWR);
>>       if(-1 == fd)
>>       {
>>           perror("open");
>>           return 1;
>>       }
>>
>>       ret = pread64(fd, buf, -1, 1);
>>       if((-1 == ret) && (EFAULT == errno))
>>       {
>>           close(fd);
>>           unlink(TMPFILE);
>>           printf("PASS\n");
>>           return 0;
>>       }
>>       err = errno;
>>       perror("pread64");
>>       printf("err = %d\n", err);
>>       close(fd);
>>       unlink(TMPFILE);
>>       printf("FAIL\n");
>>
>>       return 1;
>>    }
>>
>> The expected result is:
>>
>> PASS
>>
>> but the result of 32-bit testcase running in x86-64 kernel with compat
>> mode is:
>>
>> pread64: Success
>> err = 0
>> FAIL
>>
>>
>> In my explanation, pread64 is called with count '0xffffffffull' and
>> offset '1', which might still not trigger
>>
>> page fault in 64-bit kernel.
>>
>>
>> This patch uses TASK_SIZE as the addr_limit to performance a stricter
>> address check and intercepts
> I see. So while the kernel behavior was not meant to change from
> my patch, it clearly did, which may cause problems. However, I'm
> not sure if the changed behavior is actually wrong.
>
>> the illegal pointer address from 32-bit userspace at a very early time.
>> Which is roughly the same
>>
>> address limit check as __access_ok in arch/ia64.
>>
>>
>> This is why this fixes my testcase failure above, or have I missed
>> anything else?
> My interpretation of what is going on here is that the pread64() call
> still behaves according to the documented behavior, returning a small
> number of bytes from the file, up to the first faulting address.
>
> As the manual page for pread64() describes,
>
>         On  success,  pread()  returns  the  number  of  bytes read
>         (a return of zero indicates end of file) and pwrite() returns
>         the number of bytes written.
>         Note that it is not an error for a successful call to transfer
>         fewer bytes than requested  (see  read(2)
>         and write(2)).

I have really missed this point. The behavior here is and should

be aligned with the manual definition.

>
> The difference after my patch is that originally it returned
> -EFAULT because part of the buffer is outside of the
> addressable memory, but now it returns success because
> part of the buffer is inside the addressable memory ;-)
>
> I'm also not sure about which patch caused the change in
> behavior, can you double-check that? The one you cited,
> 967747bbc084 ("uaccess: remove CONFIG_SET_FS"), does
> not actually touch the x86 implementation, and commit
> 36903abedfe8 ("x86: remove __range_not_ok()") does touch
> x86 but the limit was already TASK_SIZE_MAX since commit
> 47058bb54b57 ("x86: remove address space overrides using
> set_fs()") back in linux-5.10.

I have performed the testcase on the same environment with

several old LTS kernel versions, all the results are "fault".

The behavior before and after your patches should be consistent.


So the fault should due to the disagreement between the

testcase's intention and the real pread64 definition. I have been

misled by the former one. Thanks for your interpretation.


Jiahao

>
>          Arnd
>
> .
