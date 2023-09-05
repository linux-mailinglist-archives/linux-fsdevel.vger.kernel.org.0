Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9E793275
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 01:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbjIEXWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 19:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbjIEXWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:22:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2839E;
        Tue,  5 Sep 2023 16:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693956151; x=1725492151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R0NmfG3Tf6pWI/IPB52SKS2t7Lm+PqP0JsgP7aqRXYk=;
  b=WOs6qUtGlnJUsEFhXXwuv8lJLdTzqg2NM1HB/VXM/l4SYxiPwwjipL6f
   N4uBUkJGIzbdyPcUYS7Iyd7ix3f81Q5RF495SIupP5XAID5zdr4MpTVpW
   TwOde28H6LdMcR8NxNhSYghxHYVXaXXLzCjQgvYS6AfihNCdS3z8kWxZR
   1EZQD6zgLRsS++lHUT37I102/Sa43FS7zvvLqS57TWSzHD1wvdsceSauz
   UCJ3sKbFwNUDQuTxH9LraV5nlqquwcBmb5OmV8bC8T4V30IqH9Jx485wT
   z5vEz414enHS8ehlx1rmiWu6SP7gvDG/QHugT5VRw9fROcZVcG/ThTmTf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407922985"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="407922985"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 16:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="1072150069"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="1072150069"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2023 16:22:27 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdfNJ-0002Bw-0Q;
        Tue, 05 Sep 2023 23:22:25 +0000
Date:   Wed, 6 Sep 2023 07:21:54 +0800
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
Message-ID: <202309060752.FQUjUmGA-lkp@intel.com>
References: <20230905214235.320571-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905214235.320571-3-peterx@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-userfaultfd-Make-uffd-read-wait-event-exclusive/20230906-054430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230905214235.320571-3-peterx%40redhat.com
patch subject: [PATCH 2/7] poll: Add a poll_flags for poll_queue_proc()
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230906/202309060752.FQUjUmGA-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309060752.FQUjUmGA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309060752.FQUjUmGA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/9p/trans_fd.c:555: warning: Function parameter or member 'flags' not described in 'p9_pollwait'


vim +555 net/9p/trans_fd.c

8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  542  
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  543  /**
5503ac565998837 Eric Van Hensbergen 2008-10-13  544   * p9_pollwait - add poll task to the wait queue
5503ac565998837 Eric Van Hensbergen 2008-10-13  545   * @filp: file pointer being polled
5503ac565998837 Eric Van Hensbergen 2008-10-13  546   * @wait_address: wait_q to block on
5503ac565998837 Eric Van Hensbergen 2008-10-13  547   * @p: poll state
ee443996a35c1e0 Eric Van Hensbergen 2008-03-05  548   *
5503ac565998837 Eric Van Hensbergen 2008-10-13  549   * called by files poll operation to add v9fs-poll task to files wait queue
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  550   */
ee443996a35c1e0 Eric Van Hensbergen 2008-03-05  551  
5503ac565998837 Eric Van Hensbergen 2008-10-13  552  static void
14649d7d7806aba Peter Xu            2023-09-05  553  p9_pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *p,
14649d7d7806aba Peter Xu            2023-09-05  554  	    poll_flags flags)
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06 @555  {
5503ac565998837 Eric Van Hensbergen 2008-10-13  556  	struct p9_conn *m = container_of(p, struct p9_conn, pt);
5503ac565998837 Eric Van Hensbergen 2008-10-13  557  	struct p9_poll_wait *pwait = NULL;
5503ac565998837 Eric Van Hensbergen 2008-10-13  558  	int i;
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  559  
5503ac565998837 Eric Van Hensbergen 2008-10-13  560  	for (i = 0; i < ARRAY_SIZE(m->poll_wait); i++) {
5503ac565998837 Eric Van Hensbergen 2008-10-13  561  		if (m->poll_wait[i].wait_addr == NULL) {
5503ac565998837 Eric Van Hensbergen 2008-10-13  562  			pwait = &m->poll_wait[i];
5503ac565998837 Eric Van Hensbergen 2008-10-13  563  			break;
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  564  		}
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  565  	}
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  566  
5503ac565998837 Eric Van Hensbergen 2008-10-13  567  	if (!pwait) {
5d3851530d6d685 Joe Perches         2011-11-28  568  		p9_debug(P9_DEBUG_ERROR, "not enough wait_address slots\n");
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  569  		return;
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  570  	}
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  571  
5503ac565998837 Eric Van Hensbergen 2008-10-13  572  	pwait->conn = m;
5503ac565998837 Eric Van Hensbergen 2008-10-13  573  	pwait->wait_addr = wait_address;
5503ac565998837 Eric Van Hensbergen 2008-10-13  574  	init_waitqueue_func_entry(&pwait->wait, p9_pollwake);
5503ac565998837 Eric Van Hensbergen 2008-10-13  575  	add_wait_queue(wait_address, &pwait->wait);
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  576  }
8a0dc95fd976a05 Eric Van Hensbergen 2008-02-06  577  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
