Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D081261D9D5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Nov 2022 13:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiKEMQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Nov 2022 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEMQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Nov 2022 08:16:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD7E021
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Nov 2022 05:16:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b29so6682846pfp.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Nov 2022 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQtVUX55WFqW60wZgzv2oInTb6sEFXR67otU1suxdBE=;
        b=29h7jkZmHtDKRYld3mkk+ugynkKfg1jpcJ2K1fJ8ymdWIZlCTy3eH+DMZ3unlvAHNz
         h6428rXRzx0N27AaRC5LVMIXmOxAr4lom3CTbEXkype1Kt8SLotfhBhI3g+HPNRZ2k9V
         TASiTnqfcW049pDaFaAYf4UlwGkFDHbrm7ZZnfaClejvKII4r5nvzjiw4a9AbFnkaj11
         sc5Tv28trWkhpmtm8rTOmkwybBJIf22nm0+PAi+BFj9OuBXvDmO22nBR2feYpB/fzTXz
         jTSskCZZ1jHICGXWWEnu9WUcHAYu6a03/SWy9ttUVVgxeQ97NLEyMAYD+ibFVw9YRqcF
         tbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQtVUX55WFqW60wZgzv2oInTb6sEFXR67otU1suxdBE=;
        b=ImwQrQiJr3cFMJXdfzFcox1fOPUbYjrsABPwc9LvQ/YH/v+n9a0Y1kjgkWNp1/6A6i
         roTQC3RYt3h/tsfYWX7dvgDSBtHrpVyMBKIcxoTrYHgaJg8Sa8E45CsSeqqAydxufiJ3
         VHMfeF/6HuWX/MrN5SdoWP26Fhsf2a4xsWOFDykb8RkXHWlIOW9L9skNA7YXDgTY6MeK
         AJNj94ZruwCCBsmEhRwl4r7IjaoqcBWUEosTqF2M2t8j3GzOhE6dbJAebFYIh1Q4XrPd
         4i39uVYg7DMFI6LF4fj4F4pJOy6LLnBtzU/mBe9A1HbmV3vA4bsg4bh8SuTVBCTN1eol
         NHTQ==
X-Gm-Message-State: ACrzQf0ra1YXf/GwpHC8onGCeVFBv+xtoHmVBf1D7veFGNf4ioc7vS6B
        vRjl8xtxAbD4rFSs+5eEMp+/Kg==
X-Google-Smtp-Source: AMsMyM47tbsRsiznPrtw5nJLy1bdKvFTyRjXkgKv+6WSVj3Aw/WJHHyU3Oav+o8JRw2IwdrBJ04Gcw==
X-Received: by 2002:a05:6a02:281:b0:45c:2b19:a52c with SMTP id bk1-20020a056a02028100b0045c2b19a52cmr33061220pgb.180.1667650601476;
        Sat, 05 Nov 2022 05:16:41 -0700 (PDT)
Received: from [10.255.93.192] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b005668b26ade0sm1201429pfk.136.2022.11.05.05.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 05:16:40 -0700 (PDT)
Message-ID: <be6a67b0-479f-db0a-fa69-764713135d70@bytedance.com>
Date:   Sat, 5 Nov 2022 20:16:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: xarray, fault injection and syzkaller
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
References: <Y2QR0EDvq7p9i1xw@nvidia.com>
 <Y2Qd2dBqpOXuJm22@casper.infradead.org> <Y2QfkszbNaI297nl@nvidia.com>
 <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
 <Y2RbCUdEY2syxRLW@nvidia.com>
 <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
 <Y2VT6b/AgwddWxYj@nvidia.com>
 <CACT4Y+aog92JBEGqga1QxZ7w6iPsEvEKE=6v7m78pROGAQ7KEA@mail.gmail.com>
 <6e33dd02-99b0-0899-aed5-07f770340a74@bytedance.com>
In-Reply-To: <6e33dd02-99b0-0899-aed5-07f770340a74@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/5 06:43, Qi Zheng wrote:
> 
> 
> On 2022/11/5 02:21, Dmitry Vyukov wrote:
>> On Fri, 4 Nov 2022 at 11:03, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>
>>> On Fri, Nov 04, 2022 at 10:47:17AM -0700, Dmitry Vyukov wrote:
>>>>>> Do we know how common/useful such an allocation pattern is?
>>>>>
>>>>> I have coded something like this a few times, in my cases it is
>>>>> usually something like: try to allocate a big chunk of memory hoping
>>>>> for a huge page, then fall back to a smaller allocation
>>>>>
>>>>> Most likely the key consideration is that the callsites are using
>>>>> GFP_NOWARN, so perhaps we can just avoid decrementing the nth on a
>>>>> NOWARN case assuming that another allocation attempt will closely
>>>>> follow?
>>>>
>>>> GFP_NOWARN is also extensively used for allocations with
>>>> user-controlled size, e.g.:
>>>> https://elixir.bootlin.com/linux/v6.1-rc3/source/net/unix/af_unix.c#L3451
>>>>
>>>> That's different and these allocations are usually not repeated.
>>>> So looking at GFP_NOWARN does not look like the right thing to do.
>>>
>>> This may be the best option then, arguably perhaps even more
>>> "realistic" than normal fail_nth as in a real system if this stuff
>>> starts failing there is a good chance things from then on will fail
>>> too during the error cleanup.
>>>
>>>>> However, this would also have to fix the obnoxious behavior of fail
>>>>> nth where it fails its own copy_from_user on its write system call -
>>>>> meaning there would be no way to turn it off.
>>>>
>>>> Oh, interesting. We added failing of copy_from/to_user later and did
>>>> not consider such interaction.
>>>> Filed https://bugzilla.kernel.org/show_bug.cgi?id=216660 for this.
>>>
>>> Oh, I will tell you the other two bugish things I noticed
>>>
>>> __should_failslab() has this:
>>>
>>>          if (gfpflags & __GFP_NOWARN)
>>>                  failslab.attr.no_warn = true;
>>>
>>>          return should_fail(&failslab.attr, s->object_size);
>>>
>>> Which always permanently turns off no_warn for slab during early
>>> boot. This is why syzkaller reports are so confusing. They trigger a
>>> slab fault injection, which in all other cases gives a notification
>>> backtrace, but in slab cases there is no hint about the fault
>>> injection in the log.
>>
>> Ouch, this looks like a bug in:
>>
>> commit 3f913fc5f9745613088d3c569778c9813ab9c129
>> Author: Qi Zheng <zhengqi.arch@bytedance.com>
>> Date:   Thu May 19 14:08:55 2022 -0700
>>       mm: fix missing handler for __GFP_NOWARN
>>
>> +Qi could you please fix it?
>>
>> At the very least the local gfpflags should not alter the global
>> failslab.attr that is persistent and shared by all tasks.
> 
> Oh, It indeed shouldn't alter the global failslab.attr, I'll fix it.

How about the following changes? If it's ok, I will send this fix patch.
Thanks. :)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 9f6e25467844..b61a3fb7a2a3 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -20,7 +20,6 @@ struct fault_attr {
         atomic_t space;
         unsigned long verbose;
         bool task_filter;
-       bool no_warn;
         unsigned long stacktrace_depth;
         unsigned long require_start;
         unsigned long require_end;
@@ -40,12 +39,12 @@ struct fault_attr {
                 .ratelimit_state = RATELIMIT_STATE_INIT_DISABLED,       \
                 .verbose = 2,                                           \
                 .dname = NULL,                                          \
-               .no_warn = false,                                       \
         }

  #define DECLARE_FAULT_ATTR(name) struct fault_attr name = 
FAULT_ATTR_INITIALIZER
  int setup_fault_attr(struct fault_attr *attr, char *str);
  bool should_fail(struct fault_attr *attr, ssize_t size);
+bool should_fail_gfp(struct fault_attr *attr, ssize_t size, gfp_t 
gfpflags);

  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 4b8fafce415c..95af50832770 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -41,9 +41,6 @@ EXPORT_SYMBOL_GPL(setup_fault_attr);

  static void fail_dump(struct fault_attr *attr)
  {
-       if (attr->no_warn)
-               return;
-
         if (attr->verbose > 0 && __ratelimit(&attr->ratelimit_state)) {
                 printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure.\n"
                        "name %pd, interval %lu, probability %lu, "
@@ -98,12 +95,7 @@ static inline bool fail_stacktrace(struct fault_attr 
*attr)

  #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */

-/*
- * This code is stolen from failmalloc-1.0
- * http://www.nongnu.org/failmalloc/
- */
-
-bool should_fail(struct fault_attr *attr, ssize_t size)
+bool should_fail_check(struct fault_attr *attr, ssize_t size)
  {
         bool stack_checked = false;

@@ -118,7 +110,7 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
                         fail_nth--;
                         WRITE_ONCE(current->fail_nth, fail_nth);
                         if (!fail_nth)
-                               goto fail;
+                               return true;

                         return false;
                 }
@@ -151,7 +143,19 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
         if (attr->probability <= get_random_u32_below(100))
                 return false;

-fail:
+       return true;
+}
+
+/*
+ * This code is stolen from failmalloc-1.0
+ * http://www.nongnu.org/failmalloc/
+ */
+
+bool should_fail(struct fault_attr *attr, ssize_t size)
+{
+       if (!should_fail_check(attr, size))
+               return false;
+
         fail_dump(attr);

         if (atomic_read(&attr->times) != -1)
@@ -161,6 +165,21 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
  }
  EXPORT_SYMBOL_GPL(should_fail);

+bool should_fail_gfp(struct fault_attr *attr, ssize_t size, gfp_t gfpflags)
+{
+       if (!should_fail_check(attr, size))
+               return false;
+
+       if (!(gfpflags & __GFP_NOWARN))
+               fail_dump(attr);
+
+       if (atomic_read(&attr->times) != -1)
+               atomic_dec_not_zero(&attr->times);
+
+       return true;
+}
+EXPORT_SYMBOL_GPL(should_fail_gfp);
+
  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS

  static int debugfs_ul_set(void *data, u64 val)
diff --git a/mm/failslab.c b/mm/failslab.c
index 58df9789f1d2..21338b256791 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -30,10 +30,7 @@ bool __should_failslab(struct kmem_cache *s, gfp_t 
gfpflags)
         if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
                 return false;

-       if (gfpflags & __GFP_NOWARN)
-               failslab.attr.no_warn = true;
-
-       return should_fail(&failslab.attr, s->object_size);
+       return should_fail_gfp(&failslab.attr, s->object_size, gfpflags);
  }

  static int __init setup_failslab(char *str)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7192ded44ad0..4e70b5599ada 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3912,10 +3912,7 @@ static bool __should_fail_alloc_page(gfp_t 
gfp_mask, unsigned int order)
                         (gfp_mask & __GFP_DIRECT_RECLAIM))
                 return false;

-       if (gfp_mask & __GFP_NOWARN)
-               fail_page_alloc.attr.no_warn = true;
-
-       return should_fail(&fail_page_alloc.attr, 1 << order);
+       return should_fail_gfp(&fail_page_alloc.attr, 1 << order, gfp_mask);
  }

  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS

> 
> But a warning should not be printed for callers that currently specify
> __GFP_NOWARN, because that could lead to deadlocks, such as the deadlock
> case mentioned in commit 6b9dbedbe349 ("tty: fix deadlock caused by 
> calling printk() under tty_port->lock").
> 
> Thanks,
> Qi
> 
>>
>> But I am not sure if we really don't want to issue the fault injection
>> stack in this case. It's not a WARNING, it's merely an information
>> message. It looks useful in all cases, even with GFP_NOWARN. Why
>> should it be suppressed?
>>
>>
>>> Once that is fixed we can quickly explain why the socketpair() example
>>> in the docs shows success ret codes in the middle of the sweep when
>>> run on syzkaller kernels
>>>
>>> fail_nth interacts badly with other kernel features typically enabled
>>> in syzkaller kernels. Eg it fails in hidden kmemleak instrumentation:
>>>
>>> [   18.499559] FAULT_INJECTION: forcing a failure.
>>> [   18.499559] name failslab, interval 1, probability 0, space 0, 
>>> times 0
>>> [   18.499720] CPU: 10 PID: 386 Comm: iommufd_fail_nt Not tainted 
>>> 6.1.0-rc3+ #34
>>> [   18.499826] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), 
>>> BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>>> [   18.499971] Call Trace:
>>> [   18.500010]  <TASK>
>>> [   18.500048]  show_stack+0x3d/0x3f
>>> [   18.500114]  dump_stack_lvl+0x92/0xbd
>>> [   18.500171]  dump_stack+0x15/0x17
>>> [   18.500232]  should_fail.cold+0x5/0xa
>>> [   18.500291]  __should_failslab+0xb6/0x100
>>> [   18.500349]  should_failslab+0x9/0x20
>>> [   18.500416]  kmem_cache_alloc+0x64/0x4e0
>>> [   18.500477]  ? __create_object+0x40/0xc50
>>> [   18.500539]  __create_object+0x40/0xc50
>>> [   18.500620]  ? kasan_poison+0x3a/0x50
>>> [   18.500690]  ? kasan_unpoison+0x28/0x50
>>> [***18.500753]  kmemleak_alloc+0x24/0x30
>>> [   18.500816]  __kmem_cache_alloc_node+0x1de/0x400
>>> [   18.500900]  ? iopt_alloc_area_pages+0x95/0x560 [iommufd]
>>> [   18.500993]  kmalloc_trace+0x26/0x110
>>> [   18.501059]  iopt_alloc_area_pages+0x95/0x560 [iommufd]
>>>
>>> Which has the consequence of syzkaller wasting half its fail_nth
>>> effort because it is triggering failures in hidden instrumentation
>>> that has no impact on the main code path.
>>>
>>> Maybe a kmem_cache_alloc_no_fault_inject() would be helpful for a few
>>> cases.
>>>
>>> Jason
> 

-- 
Thanks,
Qi
