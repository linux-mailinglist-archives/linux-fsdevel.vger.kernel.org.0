Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B215C49C15D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiAZCeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:34:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236442AbiAZCeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643164444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2lYZcdoMmNoVVOhgdbLqUSBCGCBawSokbUMPIdI5srg=;
        b=C38Ekw8t9wYv56rpwzJoAgBTz1N3Sv79KBckuCIeCl+CTlOaEBJkOqjUtZ3ZyuI9ajFFdb
        yhaEl7jpzzsr7jVP+G3stZ9G7+zS5yHEJqQHxkUdhAtTzB46qqCLs54jujcPMNN7xXEWHT
        8AhXOgPWZjdLfB8l9wd7i8ekeWM5RGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-Teu1OUp7Phin521DAM5dgQ-1; Tue, 25 Jan 2022 21:33:58 -0500
X-MC-Unique: Teu1OUp7Phin521DAM5dgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F16F183DD22;
        Wed, 26 Jan 2022 02:33:56 +0000 (UTC)
Received: from localhost (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C55ABB18AE;
        Wed, 26 Jan 2022 02:33:37 +0000 (UTC)
Date:   Wed, 26 Jan 2022 10:33:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2] proc/vmcore: fix possible deadlock on concurrent mmap
 and read
Message-ID: <20220126023334.GA30295@MiWiFi-R3L-srv>
References: <20220119193417.100385-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119193417.100385-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/19/22 at 08:34pm, David Hildenbrand wrote:
> Lockdep noticed that there is chance for a deadlock if we have
> concurrent mmap, concurrent read, and the addition/removal of a
> callback.
> 
> As nicely explained by Boqun:
> 
> "
> Lockdep warned about the above sequences because rw_semaphore is a fair
> read-write lock, and the following can cause a deadlock:
> 
> 	TASK 1			TASK 2		TASK 3
> 	======			======		======
> 	down_write(mmap_lock);
> 				down_read(vmcore_cb_rwsem)
> 						down_write(vmcore_cb_rwsem); // blocked
> 	down_read(vmcore_cb_rwsem); // cannot get the lock because of the fairness
> 				down_read(mmap_lock); // blocked

It's almost impossible to have chance to register or unregister vmcore
cb during vmcore dumping, so the deadlock can only exist theorictically.
While muting the lockdep is still good. This patch looks good to me.
Thanks for the fix.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> IOW, a reader can block another read if there is a writer queued by the
> second reader and the lock is fair.
> "
> 
> To fix, convert to srcu to make this deadlock impossible. We need srcu as
> our callbacks can sleep. With this change, I cannot trigger any lockdep
> warnings.
> 
> [    6.386519] ======================================================
> [    6.387203] WARNING: possible circular locking dependency detected
> [    6.387965] 5.17.0-0.rc0.20220117git0c947b893d69.68.test.fc36.x86_64 #1 Not tainted
> [    6.388899] ------------------------------------------------------
> [    6.389657] makedumpfile/542 is trying to acquire lock:
> [    6.390308] ffffffff832d2eb8 (vmcore_cb_rwsem){.+.+}-{3:3}, at: mmap_vmcore+0x340/0x580
> [    6.391290]
> [    6.391290] but task is already holding lock:
> [    6.391978] ffff8880af226438 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x84/0x150
> [    6.392898]
> [    6.392898] which lock already depends on the new lock.
> [    6.392898]
> [    6.393866]
> [    6.393866] the existing dependency chain (in reverse order) is:
> [    6.394762]
> [    6.394762] -> #1 (&mm->mmap_lock#2){++++}-{3:3}:
> [    6.395530]        lock_acquire+0xc3/0x1a0
> [    6.396047]        __might_fault+0x4e/0x70
> [    6.396562]        _copy_to_user+0x1f/0x90
> [    6.397093]        __copy_oldmem_page+0x72/0xc0
> [    6.397663]        read_from_oldmem+0x77/0x1e0
> [    6.398229]        read_vmcore+0x2c2/0x310
> [    6.398742]        proc_reg_read+0x47/0xa0
> [    6.399265]        vfs_read+0x101/0x340
> [    6.399751]        __x64_sys_pread64+0x5d/0xa0
> [    6.400314]        do_syscall_64+0x43/0x90
> [    6.400778]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    6.401390]
> [    6.401390] -> #0 (vmcore_cb_rwsem){.+.+}-{3:3}:
> [    6.402063]        validate_chain+0x9f4/0x2670
> [    6.402560]        __lock_acquire+0x8f7/0xbc0
> [    6.403054]        lock_acquire+0xc3/0x1a0
> [    6.403509]        down_read+0x4a/0x140
> [    6.403948]        mmap_vmcore+0x340/0x580
> [    6.404403]        proc_reg_mmap+0x3e/0x90
> [    6.404866]        mmap_region+0x504/0x880
> [    6.405322]        do_mmap+0x38a/0x520
> [    6.405744]        vm_mmap_pgoff+0xc1/0x150
> [    6.406258]        ksys_mmap_pgoff+0x178/0x200
> [    6.406823]        do_syscall_64+0x43/0x90
> [    6.407339]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    6.407975]
> [    6.407975] other info that might help us debug this:
> [    6.407975]
> [    6.408945]  Possible unsafe locking scenario:
> [    6.408945]
> [    6.409684]        CPU0                    CPU1
> [    6.410196]        ----                    ----
> [    6.410703]   lock(&mm->mmap_lock#2);
> [    6.411121]                                lock(vmcore_cb_rwsem);
> [    6.411792]                                lock(&mm->mmap_lock#2);
> [    6.412465]   lock(vmcore_cb_rwsem);
> [    6.412873]
> [    6.412873]  *** DEADLOCK ***
> [    6.412873]
> [    6.413522] 1 lock held by makedumpfile/542:
> [    6.414006]  #0: ffff8880af226438 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x84/0x150
> [    6.414944]
> [    6.414944] stack backtrace:
> [    6.415432] CPU: 0 PID: 542 Comm: makedumpfile Not tainted 5.17.0-0.rc0.20220117git0c947b893d69.68.test.fc36.x86_64 #1
> [    6.416581] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [    6.417272] Call Trace:
> [    6.417593]  <TASK>
> [    6.417882]  dump_stack_lvl+0x5d/0x78
> [    6.418346]  print_circular_bug+0x5d7/0x5f0
> [    6.418821]  ? stack_trace_save+0x3a/0x50
> [    6.419273]  ? save_trace+0x3d/0x330
> [    6.419681]  check_noncircular+0xd1/0xe0
> [    6.420217]  validate_chain+0x9f4/0x2670
> [    6.420715]  ? __lock_acquire+0x8f7/0xbc0
> [    6.421234]  ? __lock_acquire+0x8f7/0xbc0
> [    6.421685]  __lock_acquire+0x8f7/0xbc0
> [    6.422127]  lock_acquire+0xc3/0x1a0
> [    6.422535]  ? mmap_vmcore+0x340/0x580
> [    6.422965]  ? lock_is_held_type+0xe2/0x140
> [    6.423432]  ? mmap_vmcore+0x340/0x580
> [    6.423893]  down_read+0x4a/0x140
> [    6.424321]  ? mmap_vmcore+0x340/0x580
> [    6.424800]  mmap_vmcore+0x340/0x580
> [    6.425237]  ? vm_area_alloc+0x1c/0x60
> [    6.425661]  ? trace_kmem_cache_alloc+0x30/0xe0
> [    6.426174]  ? kmem_cache_alloc+0x1e0/0x2f0
> [    6.426641]  proc_reg_mmap+0x3e/0x90
> [    6.427052]  mmap_region+0x504/0x880
> [    6.427462]  do_mmap+0x38a/0x520
> [    6.427842]  vm_mmap_pgoff+0xc1/0x150
> [    6.428260]  ksys_mmap_pgoff+0x178/0x200
> [    6.428701]  do_syscall_64+0x43/0x90
> [    6.429126]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    6.429745] RIP: 0033:0x7fc7359b8fc7
> [    6.430157] Code: 00 00 00 89 ef e8 69 b3 ff ff eb e4 e8 c2 64 01 00 66 90 f3 0f 1e fa 41 89 ca 41 f7 c1 ff 0f 00 00 75 10 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 21 c3 48 8b 05 21 7e 0e 00 64 c7 00 16 00 00
> [    6.432147] RSP: 002b:00007fff35b4c208 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> [    6.432970] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fc7359b8fc7
> [    6.433746] RDX: 0000000000000001 RSI: 0000000000400000 RDI: 0000000000000000
> [    6.434529] RBP: 000055a1125ecf10 R08: 0000000000000003 R09: 0000000000002000
> [    6.435310] R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000002000
> [    6.436093] R13: 0000000000400000 R14: 000055a1124269e2 R15: 0000000000000000
> [    6.436887]  </TASK>
> 
> Reported-by: Baoquan He <bhe@redhat.com>
> Fixes: cc5f2704c934 ("proc/vmcore: convert oldmem_pfn_is_ram callback to more generic vmcore callbacks")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Was: [PATCH v1] proc/vmcore: fix false positive lockdep warning
> 
> v1 -> v2:
> - Adjust subject/description
> - Add Fixes:
> 
> ---
>  fs/proc/vmcore.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 702754dd1daf..edeb01dfe05d 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -62,7 +62,8 @@ core_param(novmcoredd, vmcoredd_disabled, bool, 0);
>  /* Device Dump Size */
>  static size_t vmcoredd_orig_sz;
>  
> -static DECLARE_RWSEM(vmcore_cb_rwsem);
> +static DEFINE_SPINLOCK(vmcore_cb_lock);
> +DEFINE_STATIC_SRCU(vmcore_cb_srcu);
>  /* List of registered vmcore callbacks. */
>  static LIST_HEAD(vmcore_cb_list);
>  /* Whether the vmcore has been opened once. */
> @@ -70,8 +71,8 @@ static bool vmcore_opened;
>  
>  void register_vmcore_cb(struct vmcore_cb *cb)
>  {
> -	down_write(&vmcore_cb_rwsem);
>  	INIT_LIST_HEAD(&cb->next);
> +	spin_lock(&vmcore_cb_lock);
>  	list_add_tail(&cb->next, &vmcore_cb_list);
>  	/*
>  	 * Registering a vmcore callback after the vmcore was opened is
> @@ -79,14 +80,14 @@ void register_vmcore_cb(struct vmcore_cb *cb)
>  	 */
>  	if (vmcore_opened)
>  		pr_warn_once("Unexpected vmcore callback registration\n");
> -	up_write(&vmcore_cb_rwsem);
> +	spin_unlock(&vmcore_cb_lock);
>  }
>  EXPORT_SYMBOL_GPL(register_vmcore_cb);
>  
>  void unregister_vmcore_cb(struct vmcore_cb *cb)
>  {
> -	down_write(&vmcore_cb_rwsem);
> -	list_del(&cb->next);
> +	spin_lock(&vmcore_cb_lock);
> +	list_del_rcu(&cb->next);
>  	/*
>  	 * Unregistering a vmcore callback after the vmcore was opened is
>  	 * very unusual (e.g., forced driver removal), but we cannot stop
> @@ -94,7 +95,9 @@ void unregister_vmcore_cb(struct vmcore_cb *cb)
>  	 */
>  	if (vmcore_opened)
>  		pr_warn_once("Unexpected vmcore callback unregistration\n");
> -	up_write(&vmcore_cb_rwsem);
> +	spin_unlock(&vmcore_cb_lock);
> +
> +	synchronize_srcu(&vmcore_cb_srcu);
>  }
>  EXPORT_SYMBOL_GPL(unregister_vmcore_cb);
>  
> @@ -103,9 +106,8 @@ static bool pfn_is_ram(unsigned long pfn)
>  	struct vmcore_cb *cb;
>  	bool ret = true;
>  
> -	lockdep_assert_held_read(&vmcore_cb_rwsem);
> -
> -	list_for_each_entry(cb, &vmcore_cb_list, next) {
> +	list_for_each_entry_srcu(cb, &vmcore_cb_list, next,
> +				 srcu_read_lock_held(&vmcore_cb_srcu)) {
>  		if (unlikely(!cb->pfn_is_ram))
>  			continue;
>  		ret = cb->pfn_is_ram(cb, pfn);
> @@ -118,9 +120,9 @@ static bool pfn_is_ram(unsigned long pfn)
>  
>  static int open_vmcore(struct inode *inode, struct file *file)
>  {
> -	down_read(&vmcore_cb_rwsem);
> +	spin_lock(&vmcore_cb_lock);
>  	vmcore_opened = true;
> -	up_read(&vmcore_cb_rwsem);
> +	spin_unlock(&vmcore_cb_lock);
>  
>  	return 0;
>  }
> @@ -133,6 +135,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  	unsigned long pfn, offset;
>  	size_t nr_bytes;
>  	ssize_t read = 0, tmp;
> +	int idx;
>  
>  	if (!count)
>  		return 0;
> @@ -140,7 +143,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  	offset = (unsigned long)(*ppos % PAGE_SIZE);
>  	pfn = (unsigned long)(*ppos / PAGE_SIZE);
>  
> -	down_read(&vmcore_cb_rwsem);
> +	idx = srcu_read_lock(&vmcore_cb_srcu);
>  	do {
>  		if (count > (PAGE_SIZE - offset))
>  			nr_bytes = PAGE_SIZE - offset;
> @@ -165,7 +168,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  						       offset, userbuf);
>  		}
>  		if (tmp < 0) {
> -			up_read(&vmcore_cb_rwsem);
> +			srcu_read_unlock(&vmcore_cb_srcu, idx);
>  			return tmp;
>  		}
>  
> @@ -176,8 +179,8 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  		++pfn;
>  		offset = 0;
>  	} while (count);
> +	srcu_read_unlock(&vmcore_cb_srcu, idx);
>  
> -	up_read(&vmcore_cb_rwsem);
>  	return read;
>  }
>  
> @@ -568,18 +571,18 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
>  			    unsigned long from, unsigned long pfn,
>  			    unsigned long size, pgprot_t prot)
>  {
> -	int ret;
> +	int ret, idx;
>  
>  	/*
> -	 * Check if oldmem_pfn_is_ram was registered to avoid
> -	 * looping over all pages without a reason.
> +	 * Check if a callback was registered to avoid looping over all
> +	 * pages without a reason.
>  	 */
> -	down_read(&vmcore_cb_rwsem);
> +	idx = srcu_read_lock(&vmcore_cb_srcu);
>  	if (!list_empty(&vmcore_cb_list))
>  		ret = remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
>  	else
>  		ret = remap_oldmem_pfn_range(vma, from, pfn, size, prot);
> -	up_read(&vmcore_cb_rwsem);
> +	srcu_read_unlock(&vmcore_cb_srcu, idx);
>  	return ret;
>  }
>  
> -- 
> 2.34.1
> 

