Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076E279420E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbjIFRb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIFRb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:31:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF1B19A2;
        Wed,  6 Sep 2023 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694021512; x=1725557512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CZ59n4Ux4qiEnv0AVHLukHmA42VAOZ5j2gNn6FmckzA=;
  b=dn3HSSfZq7XIUrwPKZN1EwQ+MXNORxzxjkzrol/mMI7fU5Lao0maQpf2
   bVf64dwVb4/GkXMzCwslBVQP6B5iff4SSpv/z44B1wvSlVq+KJNiaYN9H
   yg1gxmb8vRorTciahzwgrhpKKGJr8dFh6QDOyhXGGfN/C8NH22dFWQKvE
   OhHC4KGOc6KT7D5e3rfO5GDzFMFXlfui65hcF50BmizBi6XW/x9gQmg65
   L+MuOfVSXNfqz08JnmpM4d3J7hJcejmuvWOUS2auNzXDqqjheCcBhnTJF
   HSxnrDDMBwAvX4yTU3HErJ5b+578vb4ODfjfPfXYhQfax0Uo/Mr2e21UC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441111901"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="441111901"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 10:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741642679"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="741642679"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2023 10:31:43 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdwNQ-0000Rf-17;
        Wed, 06 Sep 2023 17:31:40 +0000
Date:   Thu, 7 Sep 2023 01:31:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev, Anish Moorthy <amoorthy@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christian Brauner <brauner@kernel.org>, peterx@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 2/7] poll: Add a poll_flags for poll_queue_proc()
Message-ID: <202309070146.47KrWvAH-lkp@intel.com>
References: <20230905214235.320571-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905214235.320571-3-peterx@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-userfaultfd-Make-uffd-read-wait-event-exclusive/20230906-054430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230905214235.320571-3-peterx%40redhat.com
patch subject: [PATCH 2/7] poll: Add a poll_flags for poll_queue_proc()
config: x86_64-buildonly-randconfig-005-20230906 (https://download.01.org/0day-ci/archive/20230907/202309070146.47KrWvAH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070146.47KrWvAH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070146.47KrWvAH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/xen/privcmd.c: In function 'privcmd_irqfd_assign':
>> drivers/xen/privcmd.c:965:40: error: passing argument 2 of 'init_poll_funcptr' from incompatible pointer type [-Werror=incompatible-pointer-types]
     965 |         init_poll_funcptr(&kirqfd->pt, irqfd_poll_func);
         |                                        ^~~~~~~~~~~~~~~
         |                                        |
         |                                        void (*)(struct file *, wait_queue_head_t *, poll_table *) {aka void (*)(struct file *, struct wait_queue_head *, struct poll_table_struct *)}
   In file included from drivers/xen/privcmd.c:17:
   include/linux/poll.h:76:70: note: expected 'poll_queue_proc' {aka 'void (*)(struct file *, struct wait_queue_head *, struct poll_table_struct *, unsigned int)'} but argument is of type 'void (*)(struct file *, wait_queue_head_t *, poll_table *)' {aka 'void (*)(struct file *, struct wait_queue_head *, struct poll_table_struct *)'}
      76 | static inline void init_poll_funcptr(poll_table *pt, poll_queue_proc qproc)
         |                                                      ~~~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors


vim +/init_poll_funcptr +965 drivers/xen/privcmd.c

f8941e6c4c7129 Viresh Kumar 2023-08-22   924  
f8941e6c4c7129 Viresh Kumar 2023-08-22   925  static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
f8941e6c4c7129 Viresh Kumar 2023-08-22   926  {
f8941e6c4c7129 Viresh Kumar 2023-08-22   927  	struct privcmd_kernel_irqfd *kirqfd, *tmp;
f8941e6c4c7129 Viresh Kumar 2023-08-22   928  	__poll_t events;
f8941e6c4c7129 Viresh Kumar 2023-08-22   929  	struct fd f;
f8941e6c4c7129 Viresh Kumar 2023-08-22   930  	void *dm_op;
f8941e6c4c7129 Viresh Kumar 2023-08-22   931  	int ret;
f8941e6c4c7129 Viresh Kumar 2023-08-22   932  
f8941e6c4c7129 Viresh Kumar 2023-08-22   933  	kirqfd = kzalloc(sizeof(*kirqfd) + irqfd->size, GFP_KERNEL);
f8941e6c4c7129 Viresh Kumar 2023-08-22   934  	if (!kirqfd)
f8941e6c4c7129 Viresh Kumar 2023-08-22   935  		return -ENOMEM;
f8941e6c4c7129 Viresh Kumar 2023-08-22   936  	dm_op = kirqfd + 1;
f8941e6c4c7129 Viresh Kumar 2023-08-22   937  
f8941e6c4c7129 Viresh Kumar 2023-08-22   938  	if (copy_from_user(dm_op, irqfd->dm_op, irqfd->size)) {
f8941e6c4c7129 Viresh Kumar 2023-08-22   939  		ret = -EFAULT;
f8941e6c4c7129 Viresh Kumar 2023-08-22   940  		goto error_kfree;
f8941e6c4c7129 Viresh Kumar 2023-08-22   941  	}
f8941e6c4c7129 Viresh Kumar 2023-08-22   942  
f8941e6c4c7129 Viresh Kumar 2023-08-22   943  	kirqfd->xbufs.size = irqfd->size;
f8941e6c4c7129 Viresh Kumar 2023-08-22   944  	set_xen_guest_handle(kirqfd->xbufs.h, dm_op);
f8941e6c4c7129 Viresh Kumar 2023-08-22   945  	kirqfd->dom = irqfd->dom;
f8941e6c4c7129 Viresh Kumar 2023-08-22   946  	INIT_WORK(&kirqfd->shutdown, irqfd_shutdown);
f8941e6c4c7129 Viresh Kumar 2023-08-22   947  
f8941e6c4c7129 Viresh Kumar 2023-08-22   948  	f = fdget(irqfd->fd);
f8941e6c4c7129 Viresh Kumar 2023-08-22   949  	if (!f.file) {
f8941e6c4c7129 Viresh Kumar 2023-08-22   950  		ret = -EBADF;
f8941e6c4c7129 Viresh Kumar 2023-08-22   951  		goto error_kfree;
f8941e6c4c7129 Viresh Kumar 2023-08-22   952  	}
f8941e6c4c7129 Viresh Kumar 2023-08-22   953  
f8941e6c4c7129 Viresh Kumar 2023-08-22   954  	kirqfd->eventfd = eventfd_ctx_fileget(f.file);
f8941e6c4c7129 Viresh Kumar 2023-08-22   955  	if (IS_ERR(kirqfd->eventfd)) {
f8941e6c4c7129 Viresh Kumar 2023-08-22   956  		ret = PTR_ERR(kirqfd->eventfd);
f8941e6c4c7129 Viresh Kumar 2023-08-22   957  		goto error_fd_put;
f8941e6c4c7129 Viresh Kumar 2023-08-22   958  	}
f8941e6c4c7129 Viresh Kumar 2023-08-22   959  
f8941e6c4c7129 Viresh Kumar 2023-08-22   960  	/*
f8941e6c4c7129 Viresh Kumar 2023-08-22   961  	 * Install our own custom wake-up handling so we are notified via a
f8941e6c4c7129 Viresh Kumar 2023-08-22   962  	 * callback whenever someone signals the underlying eventfd.
f8941e6c4c7129 Viresh Kumar 2023-08-22   963  	 */
f8941e6c4c7129 Viresh Kumar 2023-08-22   964  	init_waitqueue_func_entry(&kirqfd->wait, irqfd_wakeup);
f8941e6c4c7129 Viresh Kumar 2023-08-22  @965  	init_poll_funcptr(&kirqfd->pt, irqfd_poll_func);
f8941e6c4c7129 Viresh Kumar 2023-08-22   966  
f8941e6c4c7129 Viresh Kumar 2023-08-22   967  	mutex_lock(&irqfds_lock);
f8941e6c4c7129 Viresh Kumar 2023-08-22   968  
f8941e6c4c7129 Viresh Kumar 2023-08-22   969  	list_for_each_entry(tmp, &irqfds_list, list) {
f8941e6c4c7129 Viresh Kumar 2023-08-22   970  		if (kirqfd->eventfd == tmp->eventfd) {
f8941e6c4c7129 Viresh Kumar 2023-08-22   971  			ret = -EBUSY;
f8941e6c4c7129 Viresh Kumar 2023-08-22   972  			mutex_unlock(&irqfds_lock);
f8941e6c4c7129 Viresh Kumar 2023-08-22   973  			goto error_eventfd;
f8941e6c4c7129 Viresh Kumar 2023-08-22   974  		}
f8941e6c4c7129 Viresh Kumar 2023-08-22   975  	}
f8941e6c4c7129 Viresh Kumar 2023-08-22   976  
f8941e6c4c7129 Viresh Kumar 2023-08-22   977  	list_add_tail(&kirqfd->list, &irqfds_list);
f8941e6c4c7129 Viresh Kumar 2023-08-22   978  	mutex_unlock(&irqfds_lock);
f8941e6c4c7129 Viresh Kumar 2023-08-22   979  
f8941e6c4c7129 Viresh Kumar 2023-08-22   980  	/*
f8941e6c4c7129 Viresh Kumar 2023-08-22   981  	 * Check if there was an event already pending on the eventfd before we
f8941e6c4c7129 Viresh Kumar 2023-08-22   982  	 * registered, and trigger it as if we didn't miss it.
f8941e6c4c7129 Viresh Kumar 2023-08-22   983  	 */
f8941e6c4c7129 Viresh Kumar 2023-08-22   984  	events = vfs_poll(f.file, &kirqfd->pt);
f8941e6c4c7129 Viresh Kumar 2023-08-22   985  	if (events & EPOLLIN)
f8941e6c4c7129 Viresh Kumar 2023-08-22   986  		irqfd_inject(kirqfd);
f8941e6c4c7129 Viresh Kumar 2023-08-22   987  
f8941e6c4c7129 Viresh Kumar 2023-08-22   988  	/*
f8941e6c4c7129 Viresh Kumar 2023-08-22   989  	 * Do not drop the file until the kirqfd is fully initialized, otherwise
f8941e6c4c7129 Viresh Kumar 2023-08-22   990  	 * we might race against the EPOLLHUP.
f8941e6c4c7129 Viresh Kumar 2023-08-22   991  	 */
f8941e6c4c7129 Viresh Kumar 2023-08-22   992  	fdput(f);
f8941e6c4c7129 Viresh Kumar 2023-08-22   993  	return 0;
f8941e6c4c7129 Viresh Kumar 2023-08-22   994  
f8941e6c4c7129 Viresh Kumar 2023-08-22   995  error_eventfd:
f8941e6c4c7129 Viresh Kumar 2023-08-22   996  	eventfd_ctx_put(kirqfd->eventfd);
f8941e6c4c7129 Viresh Kumar 2023-08-22   997  
f8941e6c4c7129 Viresh Kumar 2023-08-22   998  error_fd_put:
f8941e6c4c7129 Viresh Kumar 2023-08-22   999  	fdput(f);
f8941e6c4c7129 Viresh Kumar 2023-08-22  1000  
f8941e6c4c7129 Viresh Kumar 2023-08-22  1001  error_kfree:
f8941e6c4c7129 Viresh Kumar 2023-08-22  1002  	kfree(kirqfd);
f8941e6c4c7129 Viresh Kumar 2023-08-22  1003  	return ret;
f8941e6c4c7129 Viresh Kumar 2023-08-22  1004  }
f8941e6c4c7129 Viresh Kumar 2023-08-22  1005  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
