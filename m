Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515DB342BE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 12:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCTLPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 07:15:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:3812 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhCTLPW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:15:22 -0400
IronPort-SDR: 3VRHl3V/C/tLiaGVI3njtbzDq/76mXDcQGSrDwrmsoLY3KqkLbugi/bjM19lRmHJBMC4rwhxGR
 schBa/lnbOaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="251369040"
X-IronPort-AV: E=Sophos;i="5.81,264,1610438400"; 
   d="gz'50?scan'50,208,50";a="251369040"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2021 00:55:15 -0700
IronPort-SDR: dZpF/RDm6c7RKuj/mRZQXd4nifQz34F7HmioByCMxLnLom8fDQqYWmrjkOAFaNXErOwe8cyGDD
 g/lJGJhyowyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,264,1610438400"; 
   d="gz'50?scan'50,208,50";a="451127741"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2021 00:55:12 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNWRz-0002SD-TP; Sat, 20 Mar 2021 07:55:11 +0000
Date:   Sat, 20 Mar 2021 15:54:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 26/27] mm/filemap: Convert page wait queues to be
 folios
Message-ID: <202103201545.q6AYBAIm-lkp@intel.com>
References: <20210320054104.1300774-27-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20210320054104.1300774-27-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Matthew,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20210319]
[cannot apply to linux/master linus/master hnaz-linux-mm/master v5.12-rc3 v5.12-rc2 v5.12-rc1 v5.12-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Memory-Folios/20210320-134732
base:    f00397ee41c79b6155b9b44abd0055b2c0621349
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/93822cea6776a7c6c5b1341ed1c3fdbd1e5eeaab
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Memory-Folios/20210320-134732
        git checkout 93822cea6776a7c6c5b1341ed1c3fdbd1e5eeaab
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/filemap.c:1400: warning: Function parameter or member 'folio' not described in 'add_folio_wait_queue'
>> mm/filemap.c:1400: warning: expecting prototype for add_page_wait_queue(). Prototype was for add_folio_wait_queue() instead


vim +1400 mm/filemap.c

9a1ea439b16b92 Hugh Dickins            2018-12-28  1391  
385e1ca5f21c46 David Howells           2009-04-03  1392  /**
385e1ca5f21c46 David Howells           2009-04-03  1393   * add_page_wait_queue - Add an arbitrary waiter to a page's wait queue
697f619fc87aa9 Randy Dunlap            2009-04-13  1394   * @page: Page defining the wait queue of interest
697f619fc87aa9 Randy Dunlap            2009-04-13  1395   * @waiter: Waiter to add to the queue
385e1ca5f21c46 David Howells           2009-04-03  1396   *
385e1ca5f21c46 David Howells           2009-04-03  1397   * Add an arbitrary @waiter to the wait queue for the nominated @page.
385e1ca5f21c46 David Howells           2009-04-03  1398   */
93822cea6776a7 Matthew Wilcox (Oracle  2021-03-20  1399) void add_folio_wait_queue(struct folio *folio, wait_queue_entry_t *waiter)
385e1ca5f21c46 David Howells           2009-04-03 @1400  {
93822cea6776a7 Matthew Wilcox (Oracle  2021-03-20  1401) 	wait_queue_head_t *q = folio_waitqueue(folio);
385e1ca5f21c46 David Howells           2009-04-03  1402  	unsigned long flags;
385e1ca5f21c46 David Howells           2009-04-03  1403  
385e1ca5f21c46 David Howells           2009-04-03  1404  	spin_lock_irqsave(&q->lock, flags);
9c3a815f471a84 Linus Torvalds          2017-08-28  1405  	__add_wait_queue_entry_tail(q, waiter);
93822cea6776a7 Matthew Wilcox (Oracle  2021-03-20  1406) 	SetFolioWaiters(folio);
385e1ca5f21c46 David Howells           2009-04-03  1407  	spin_unlock_irqrestore(&q->lock, flags);
385e1ca5f21c46 David Howells           2009-04-03  1408  }
93822cea6776a7 Matthew Wilcox (Oracle  2021-03-20  1409) EXPORT_SYMBOL_GPL(add_folio_wait_queue);
385e1ca5f21c46 David Howells           2009-04-03  1410  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mYCpIKhGyMATD0i+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Opp5c0lSIf4Oy/FKymkVpT4GpbcqEGwPWxsupIx6re5JVysDk2D21ZgJsK+i6hk2VY1nFNlu
lGNPVVrb/S9GoqeMlPdwuh5R4lAKKImba0pBqQyAmF80GaLjYFb6HqKtKzKVzGakhHKaPnta
7pdnuIPJtGKE2oSmMd80PUKvfHNcBluJiEnip/aTxTCo8QxWlk3RR2ay1j3zSe5bwxL6D7OW
2QmqlSE8bGi5AASYFUHimVrIcnT+IVMZxUxdBhMmXpUaZCd0r87PTYbeFMHC6L6ihJcGd7C+
zu0XEL5KPSwJxdDiVEGAoJzIZL/0aoTzfhbOHbg4c8ePm0wpvPJDjJOtTR2VQTGmefRRI9Zd
YVWgoKdTGXULXY4GzwOLIkpEYbtQnnFdB/y419dO42khIjUNDwMIAdg9Yx9Luwt4XyN3LA/D
eAqD4WNQinandytOek0q2qLKgqIa59TcHYBcgkNKUeYynMP1DNPlQQaLX2YCUA8wm0nHDuvA
y9gmrkXHR9lGuqvmWT1eyHzTns+Th6fFAKbvOA1Kehtsx0XI4wpGXfJbiUwO3pc0r0+7q0ta
1rQbpBhKi1Y1fxjk9A7k1mEaKmqVT16qP+Hmf1bb5fPKfMkdJjQmW6ylMh7OZeqp7+pkSjK3
cZAUj634grob5pN24ZkWXZ1cAXsQV5+LF6V0PrygqbhYVcmSikwibPEc7PMDveNKrcAjvAd4
ne+ho8mzypMc0ZZYLnk0B/V64a8Mzue4B7B0bfjzazLyw8fRDBOPe3pGGfeUJyqzNFq+KmTu
aiXDHXDUDHiCZJAWJvreR70hYQDzJFWZJXl607iQFSZ1Jq3bPB0jqOMkp28gJUeJtykyTZSn
s7k7akkVQ/r6Vs3yO1qf09+eu/BxJn2S8lYA1TmVzGrvG75B4RkaeVM6zuVOQXvPxQKO1dDO
I8JT1haLMgWl1tORKtjY8z28mbKdrNLNmnUyVxM2zT0zBs75Ieyd3pUjL3UZUaor8TNIx2e0
xDARsVHKnkF8wl4ptO+7vWG0PqiCVnnPf1qV/z+OsEzxFKoAAA==

--mYCpIKhGyMATD0i+--
