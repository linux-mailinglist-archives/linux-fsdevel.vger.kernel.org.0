Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA25E6EFEC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 03:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbjD0BGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 21:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbjD0BGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:06:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD25E5;
        Wed, 26 Apr 2023 18:06:49 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q6Hb91BfHzsR90;
        Thu, 27 Apr 2023 09:05:09 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 09:06:46 +0800
Message-ID: <f345b2b4-73e5-a88d-6cff-767827ab57d0@huawei.com>
Date:   Thu, 27 Apr 2023 09:06:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "chu, jane" <jane.chu@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20230417045323.11054-1-wangkefeng.wang@huawei.com>
 <20230418031243.GA2845864@hori.linux.bs1.fc.nec.co.jp>
 <54d761bb-1bcc-21a2-6b53-9d797a3c076b@huawei.com>
 <20230419072557.GA2926483@hori.linux.bs1.fc.nec.co.jp>
 <9fa67780-c48f-4675-731b-4e9a25cd29a0@huawei.com>
 <7d0c38a9-ed2a-a221-0c67-4a2f3945d48b@oracle.com>
 <6dc1b117-020e-be9e-7e5e-a349ffb7d00a@huawei.com>
 <9a9876a2-a2fd-40d9-b215-3e6c8207e711@huawei.com>
 <20230421031356.GA3048466@hori.linux.bs1.fc.nec.co.jp>
 <1bd6a635-5a3d-c294-38ce-5c6fcff6494f@huawei.com>
 <20230424064427.GA3267052@hori.linux.bs1.fc.nec.co.jp>
 <SJ1PR11MB60833E08F3C3028F7463FE19FC679@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <316b5a9e-5d5f-3bcf-57c1-86fafe6681c3@huawei.com>
 <SJ1PR11MB6083452F5EB3F1812C0D2DFEFC649@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6b350187-a9a5-fb37-79b1-bf69068f0182@huawei.com>
 <SJ1PR11MB60833517FCAA19AC5F20FC3CFC659@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <SJ1PR11MB60833517FCAA19AC5F20FC3CFC659@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/4/26 23:45, Luck, Tony wrote:
>>>> Thanks for your confirm, and what your option about add
>>>> MCE_IN_KERNEL_COPYIN to EX_TYPE_DEFAULT_MCE_SAFE/FAULT_MCE_SAFE type
>>>> to let do_machine_check call queue_task_work(&m, msg, kill_me_never),
>>>> which kill every call memory_failure_queue() after mc safe copy return?
>>>
>>> I haven't been following this thread closely. Can you give a link to the e-mail
>>> where you posted a patch that does this? Or just repost that patch if easier.
>>
>> The major diff changes is [1], I will post a formal patch when -rc1 out,
>> thanks.
>>
>> [1]
>> https://lore.kernel.org/linux-mm/6dc1b117-020e-be9e-7e5e-a349ffb7d00a@huawei.com/
> 
> There seem to be a few misconceptions in that message. Not sure if all of them
> were resolved.  Here are some pertinent points:
> 
>>>> In my understanding, an MCE should not be triggered when MC-safe copy
>>>> tries
>>>> to access to a memory error.  So I feel that we might be talking about
>>>> different scenarios.
> 
> This is wrong. There is still a machine check when a MC-safe copy does a read
> from a location that has a memory error.
> 
> The recovery flow in this case does not involve queue_task_work(). That is only
> useful for machine check exceptions taken in user context. The queued work will
> be executed to call memory_failure() from the kernel, but in process context (not
> from the machine check exception stack) to handle the error.
> 
> For machine checks taken by kernel code (MC-safe copy functions) the recovery
> path is here:
> 
>                  if (m.kflags & MCE_IN_KERNEL_RECOV) {
>                          if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
>                                  mce_panic("Failed kernel mode recovery", &m, msg);
>                  }
> 
>                  if (m.kflags & MCE_IN_KERNEL_COPYIN)
>                          queue_task_work(&m, msg, kill_me_never);
> 
> The "fixup_exception()" ensures that on return from the machine check handler
> code returns to the extable[] fixup location instead of the instruction that was
> loading from the memory error location.
> 
> When the exception was from one of the copy_from_user() variants it makes
> sense to also do the queue_task_work() because the kernel is going to return
> to the user context (with an EFAULT error code from whatever system call was
> attempting the copy_from_user()).
> 
> But in the core dump case there is no return to user. The process is being
> terminated by the signal that leads to this core dump. So even though you
> may consider the page being accessed to be a "user" page, you can't fix
> it by queueing work to run on return to user.

For coredump，the task work will be called too, see following code,

get_signal
	sig_kernel_coredump
		elf_core_dump
			dump_user_range
				_copy_from_iter // with MC-safe copy, return without panic
	do_group_exit(ksig->info.si_signo);
		do_exit
			exit_task_work
				task_work_run
					kill_me_never
						memory_failure

I also add debug print to check the memory_failure() processing after
add MCE_IN_KERNEL_COPYIN to MCE_SAFE exception type, also tested CoW of
normal page and huge page, it works too.

> 
> I don't have an well thought out suggestion on how to make sure that memory_failure()
> is called for the page in this case. Maybe the core dump code can check for the
> return from the MC-safe copy it is using and handle it in the error path?
> 

So we could safely add MCE_IN_KERNEL_COPYIN to all MCE_SAFE exception type?

The kernel diff based on next-20230425 shown bellow

diff --git a/arch/x86/kernel/cpu/mce/severity.c 
b/arch/x86/kernel/cpu/mce/severity.c
index c4477162c07d..63e94484c5d6 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -293,12 +293,11 @@ static noinstr int error_context(struct mce *m, 
struct pt_regs *regs)
  	case EX_TYPE_COPY:
  		if (!copy_user)
  			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
  		fallthrough;

  	case EX_TYPE_FAULT_MCE_SAFE:
  	case EX_TYPE_DEFAULT_MCE_SAFE:
-		m->kflags |= MCE_IN_KERNEL_RECOV;
+		m->kflags |= MCE_IN_KERNEL_RECOV | MCE_IN_KERNEL_COPYIN;
  		return IN_KERNEL_RECOV;

  	default:
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4509a566fe6c..59a7afe3dfce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3667,23 +3667,19 @@ enum mf_flags {
  int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
  		      unsigned long count, int mf_flags);
  extern int memory_failure(unsigned long pfn, int flags);
+extern void memory_failure_queue(unsigned long pfn, int flags);
  extern void memory_failure_queue_kick(int cpu);
  extern int unpoison_memory(unsigned long pfn);
  extern void shake_page(struct page *p);
  extern atomic_long_t num_poisoned_pages __read_mostly;
  extern int soft_offline_page(unsigned long pfn, int flags);
  #ifdef CONFIG_MEMORY_FAILURE
-extern void memory_failure_queue(unsigned long pfn, int flags);
  extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
  					bool *migratable_cleared);
  void num_poisoned_pages_inc(unsigned long pfn);
  void num_poisoned_pages_sub(unsigned long pfn, long i);
  struct task_struct *task_early_kill(struct task_struct *tsk, int 
force_early);
  #else
-static inline void memory_failure_queue(unsigned long pfn, int flags)
-{
-}
-
  static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int 
flags,
  					bool *migratable_cleared)
  {
diff --git a/mm/ksm.c b/mm/ksm.c
index 0156bded3a66..7abdf4892387 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2794,7 +2794,6 @@ struct page *ksm_might_need_to_copy(struct page *page,
  	if (new_page) {
  		if (copy_mc_user_highpage(new_page, page, address, vma)) {
  			put_page(new_page);
-			memory_failure_queue(page_to_pfn(page), 0);
  			return ERR_PTR(-EHWPOISON);
  		}
  		SetPageDirty(new_page);
diff --git a/mm/memory.c b/mm/memory.c
index 5e2c6b1fc00e..c0f586257017 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2814,10 +2814,8 @@ static inline int __wp_page_copy_user(struct page 
*dst, struct page *src,
  	unsigned long addr = vmf->address;

  	if (likely(src)) {
-		if (copy_mc_user_highpage(dst, src, addr, vma)) {
-			memory_failure_queue(page_to_pfn(src), 0);
+		if (copy_mc_user_highpage(dst, src, addr, vma))
  			return -EHWPOISON;
-		}
  		return 0;
  	}

@@ -5852,10 +5850,8 @@ static int copy_user_gigantic_page(struct folio 
*dst, struct folio *src,

  		cond_resched();
  		if (copy_mc_user_highpage(dst_page, src_page,
-					  addr + i*PAGE_SIZE, vma)) {
-			memory_failure_queue(page_to_pfn(src_page), 0);
+					  addr + i*PAGE_SIZE, vma))
  			return -EHWPOISON;
-		}
  	}
  	return 0;
  }
@@ -5871,10 +5867,8 @@ static int copy_subpage(unsigned long addr, int 
idx, void *arg)
  	struct copy_subpage_arg *copy_arg = arg;

  	if (copy_mc_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
-				  addr, copy_arg->vma)) {
-		memory_failure_queue(page_to_pfn(copy_arg->src + idx), 0);
+				  addr, copy_arg->vma))
  		return -EHWPOISON;
-	}
  	return 0;
  }

-- 
2.35.3


Thanks,

> -Tony
