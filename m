Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152527944C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbjIFUyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 16:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjIFUyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:54:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6954EE9;
        Wed,  6 Sep 2023 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694033648; x=1725569648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VqeF0aeYObOh3hd+HV3wpbgpW4Kt9ciCv6dvaF8ZXEw=;
  b=eSG3M1USxnzK2Nh534LefQvZCLDLQnBEOwyoyUIu9u9rsmOzcjQl0k9a
   CyMxGDWPvocwW6FnwLaA22F+V5/tvFfxNDJkyNH7A4OuVaiMhnCkl6FEB
   tkMp3aRWNJ5g9fRLNjwcD6vtoxBduJ8LalW4xJQXcRrWsiSHuFfRloc8x
   ODoY6kJ4zFAM4Uxek03Crm+R+/sqH3WobAMQYNTSpFq6C3YzyqEA/Rtge
   JPOnrrVEcuqAIAcayuqQpHGZSduImmrjbc+bUdkPBrg/BAaVMpjgS5fa4
   ZEvu1GRbFuSwCsJAbQV5eIXLa6wIrtdJt5RtdOxY+o3DSv/4rYQyAYmyP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="374574264"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="374574264"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="915430165"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="915430165"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Sep 2023 13:54:02 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdzXE-0000Zn-1e;
        Wed, 06 Sep 2023 20:54:00 +0000
Date:   Thu, 7 Sep 2023 04:53:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Anish Moorthy <amoorthy@google.com>,
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
Message-ID: <202309070440.eKzBcg8X-lkp@intel.com>
References: <20230905214235.320571-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905214235.320571-3-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: hexagon-randconfig-002-20230906 (https://download.01.org/0day-ci/archive/20230907/202309070440.eKzBcg8X-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070440.eKzBcg8X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070440.eKzBcg8X-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/vhost/vhost.c:14:
   In file included from include/uapi/linux/vhost.h:14:
   In file included from include/uapi/linux/vhost_types.h:16:
   In file included from include/linux/virtio_config.h:7:
   In file included from include/linux/virtio.h:7:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/vhost/vhost.c:14:
   In file included from include/uapi/linux/vhost.h:14:
   In file included from include/uapi/linux/vhost_types.h:16:
   In file included from include/linux/virtio_config.h:7:
   In file included from include/linux/virtio.h:7:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/vhost/vhost.c:14:
   In file included from include/uapi/linux/vhost.h:14:
   In file included from include/uapi/linux/vhost_types.h:16:
   In file included from include/linux/virtio_config.h:7:
   In file included from include/linux/virtio.h:7:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/vhost/vhost.c:193:41: error: incompatible function pointer types passing 'int (wait_queue_entry_t *, unsigned int, int, void *, poll_flags)' (aka 'int (struct wait_queue_entry *, unsigned int, int, void *, unsigned int)') to parameter of type 'wait_queue_func_t' (aka 'int (*)(struct wait_queue_entry *, unsigned int, int, void *)') [-Werror,-Wincompatible-function-pointer-types]
           init_waitqueue_func_entry(&poll->wait, vhost_poll_wakeup);
                                                  ^~~~~~~~~~~~~~~~~
   include/linux/wait.h:90:80: note: passing argument to parameter 'func' here
   init_waitqueue_func_entry(struct wait_queue_entry *wq_entry, wait_queue_func_t func)
                                                                                  ^
>> drivers/vhost/vhost.c:194:34: error: incompatible function pointer types passing 'void (struct file *, wait_queue_head_t *, poll_table *)' (aka 'void (struct file *, struct wait_queue_head *, struct poll_table_struct *)') to parameter of type 'poll_queue_proc' (aka 'void (*)(struct file *, struct wait_queue_head *, struct poll_table_struct *, unsigned int)') [-Werror,-Wincompatible-function-pointer-types]
           init_poll_funcptr(&poll->table, vhost_poll_func);
                                           ^~~~~~~~~~~~~~~
   include/linux/poll.h:76:70: note: passing argument to parameter 'qproc' here
   static inline void init_poll_funcptr(poll_table *pt, poll_queue_proc qproc)
                                                                        ^
>> drivers/vhost/vhost.c:215:57: error: too few arguments to function call, expected 5, have 4
                   vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
                   ~~~~~~~~~~~~~~~~~                                     ^
   drivers/vhost/vhost.c:164:12: note: 'vhost_poll_wakeup' declared here
   static int vhost_poll_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync,
              ^
   6 warnings and 3 errors generated.


vim +193 drivers/vhost/vhost.c

87d6a412bd1ed8 Michael S. Tsirkin 2010-09-02  187  
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  188  /* Init poll structure */
c23f3445e68e1d Tejun Heo          2010-06-02  189  void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
493b94bf5ae0f6 Mike Christie      2023-06-26  190  		     __poll_t mask, struct vhost_dev *dev,
493b94bf5ae0f6 Mike Christie      2023-06-26  191  		     struct vhost_virtqueue *vq)
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  192  {
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14 @193  	init_waitqueue_func_entry(&poll->wait, vhost_poll_wakeup);
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14 @194  	init_poll_funcptr(&poll->table, vhost_poll_func);
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  195  	poll->mask = mask;
c23f3445e68e1d Tejun Heo          2010-06-02  196  	poll->dev = dev;
2b8b328b61c799 Jason Wang         2013-01-28  197  	poll->wqh = NULL;
493b94bf5ae0f6 Mike Christie      2023-06-26  198  	poll->vq = vq;
c23f3445e68e1d Tejun Heo          2010-06-02  199  
87d6a412bd1ed8 Michael S. Tsirkin 2010-09-02  200  	vhost_work_init(&poll->work, fn);
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  201  }
6ac1afbf6132df Asias He           2013-05-06  202  EXPORT_SYMBOL_GPL(vhost_poll_init);
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  203  
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  204  /* Start polling a file. We add ourselves to file's wait queue. The caller must
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  205   * keep a reference to a file until after vhost_poll_stop is called. */
2b8b328b61c799 Jason Wang         2013-01-28  206  int vhost_poll_start(struct vhost_poll *poll, struct file *file)
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  207  {
e6c8adca20ba45 Al Viro            2017-07-03  208  	__poll_t mask;
d47effe1be0c4f Krishna Kumar      2011-03-01  209  
70181d51209cbc Jason Wang         2013-04-10  210  	if (poll->wqh)
70181d51209cbc Jason Wang         2013-04-10  211  		return 0;
70181d51209cbc Jason Wang         2013-04-10  212  
9965ed174e7d38 Christoph Hellwig  2018-03-05  213  	mask = vfs_poll(file, &poll->table);
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  214  	if (mask)
3ad6f93e98d6df Al Viro            2017-07-03 @215  		vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
a9a08845e9acbd Linus Torvalds     2018-02-11  216  	if (mask & EPOLLERR) {
dc6455a71c7fc5 Jason Wang         2018-03-27  217  		vhost_poll_stop(poll);
896fc242bc1d26 Yunsheng Lin       2019-08-20  218  		return -EINVAL;
2b8b328b61c799 Jason Wang         2013-01-28  219  	}
2b8b328b61c799 Jason Wang         2013-01-28  220  
896fc242bc1d26 Yunsheng Lin       2019-08-20  221  	return 0;
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  222  }
6ac1afbf6132df Asias He           2013-05-06  223  EXPORT_SYMBOL_GPL(vhost_poll_start);
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  224  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
