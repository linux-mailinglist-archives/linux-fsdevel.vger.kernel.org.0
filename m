Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDB7583D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 19:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjGRRtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 13:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjGRRta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:49:30 -0400
X-Greylist: delayed 8317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Jul 2023 10:49:28 PDT
Received: from diomedes.noc.ntua.gr (diomedes.noc.ntua.gr [IPv6:2001:648:2000:de::220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CA5FDC;
        Tue, 18 Jul 2023 10:49:27 -0700 (PDT)
Received: from danaos.cslab.ece.ntua.gr (danaos.cslab.ece.ntua.gr [147.102.3.1])
        by diomedes.noc.ntua.gr (8.15.2/8.15.2) with ESMTP id 36IEXD69061138;
        Tue, 18 Jul 2023 17:33:13 +0300 (EEST)
        (envelope-from jimsiak@cslab.ece.ntua.gr)
Received: from [147.102.3.213] (avalanche.cslab.ece.ntua.gr [147.102.3.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by danaos.cslab.ece.ntua.gr (Postfix) with ESMTPSA id E2E6720E3B;
        Tue, 18 Jul 2023 17:33:12 +0300 (EEST)
Message-ID: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
Date:   Tue, 18 Jul 2023 17:33:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From:   Dimitris Siakavaras <jimsiak@cslab.ece.ntua.gr>
Subject: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.6.1 (diomedes.noc.ntua.gr [147.102.222.220]); Tue, 18 Jul 2023 17:33:14 +0300 (EEST)
X-Virus-Scanned: clamav-milter 0.101.4 at dkim.noc.ntua.gr
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, this is my first bug report so I apologise in advance for any 
missing information and/or difficulty in explaining the problem in my 
email. I am at your disposal to provide any other necessary information 
or modify appropriately my email.

Problem: Using userfaultfd for a process that uses KVM and triggers the 
asynchronous page fault handling results in processes to hung forever.
Processor: AMD EPYC 7402 24-Core Processor
Kernel version: 5.13 (the problem also occurs on 6.4.3 and 6.5-rc2)

Unfortunately, my execution environment involves a pretty complex set of 
components to setup so it is not straightforward for me to share code 
that can be used to reproduce the issue, so I will try to explain the 
problem as clearly as possible.

I have two processes:
1. A firecracker VM process (https://firecracker-microvm.github.io/) 
which uses KVM.
2. A second process that handles the userpage faults of the firecracker 
process.

The race condition involves the released field of the userfaultfd_ctx 
structure.
More specifically:

* Process 2 invokes the close() system call for the userfaultfd 
descriptor, thus triggering the execution of userfaultfd_release() in 
the kernel.
   userfaultfd_release() contains the following lines of code:

    WRITE_ONCE(ctx->released, true);

     if (!mmget_not_zero(mm))
         goto wakeup;

     /*
      * Flush page faults out of all CPUs. NOTE: all page faults
      * must be retried without returning VM_FAULT_SIGBUS if
      * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
      * changes while handle_userfault released the mmap_lock. So
      * it's critical that released is set to true (above), before
      * taking the mmap_lock for writing.
      */
     mmap_write_lock(mm);

* Process 1 is getting a page fault while running inside KVM_ENTRY. This 
triggers the execution of kvm_tdp_page_fault(), and the following 
function call chain is executed:

kvm_tdp_page_fault() -> direct_page_fault() -> try_async_pf() -> 
kvm_arch_setup_async_pf() -> kvm_setup_async_pf()

kvm_setup_async_pf() adds in the workqueue function async_pf_execute:
     INIT_WORK(&work->work, async_pf_execute);

Then, the following function call chain is executed:
async_pf_execute() -> get_user_pages_remote() -> 
__get_user_pages_remote() -> __get_user_pages_locked() -> __get_user_pages()

__get_user_pages() is called with mmap_lock taken and in there is the 
following code:
retry:
         /*
          * If we have a pending SIGKILL, don't keep faulting pages and
          * potentially allocating memory.
          */
         if (fatal_signal_pending(current)) {
             ret = -EINTR;
             goto out;
         }
         cond_resched();

         page = follow_page_mask(vma, start, foll_flags, &ctx);
         if (!page) {
             ret = faultin_page(vma, start, &foll_flags, locked);
             switch (ret) {
             case 0:
                 goto retry;

When faultin_page() is called here it will in turn call the following 
chain of functions:

faultin_page() -> handle_mm_fault() -> __handle__mm_fault() -> 
handle_pte_fault() -> do_anonymous_page() -> handle_userfault()

The final handle_userfault() function is the function used by 
userfaultfd to handle the userfault. In this function we can find the 
following code:

if (unlikely(READ_ONCE(ctx->released))) {
         /*
          * Don't return VM_FAULT_SIGBUS in this case, so a non
          * cooperative manager can close the uffd after the
          * last UFFDIO_COPY, without risking to trigger an
          * involuntary SIGBUS if the process was starting the
          * userfaultfd while the userfaultfd was still armed
          * (but after the last UFFDIO_COPY). If the uffd
          * wasn't already closed when the userfault reached
          * this point, that would normally be solved by
          * userfaultfd_must_wait returning 'false'.
          *
          * If we were to return VM_FAULT_SIGBUS here, the non
          * cooperative manager would be instead forced to
          * always call UFFDIO_UNREGISTER before it can safely
          * close the uffd.
          */
         ret = VM_FAULT_NOPAGE;
         goto out;
}

The problem is that when ctx->released has been set to 1 by 
userfaultfd_release() called by Process 2, handle_userfault() will 
return VM_FAULT_NOPAGE due to the above if statement.
This will result in VM_FAULT_NOPAGE returned by handle_mm_fault() in 
faultin_page() and faultin_page() in turn will return 0.
Getting back to the invocation of faultin_page() from __get_user_pages() 
the "case 0:" statement will cause the execution to go back to the retry 
label. Given that ctx->released never turns back to 0, this loop will 
continue forever and Process 1 will be stuck calling faultin_page(), 
getting 0 as return value, going back to retry, and so on.

Given that Process 1 still holds the mmap_lock and will never release 
it, process 2 will also hang in the call of mmap_write_lock(mm).

This results in both processes being stuck in a deadlock/livelock situation.

Unfortunately, I have only a minor knowledge of the mm kernel subsystem 
so I am not able to provide a solution to the problem, but I hope 
someone else with experience in kernel developing can come up with a 
proper solution.

Thank you very much,
Best Regards,
Dimitris Siakavaras
