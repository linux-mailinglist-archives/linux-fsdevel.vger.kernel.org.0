Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF15A2D37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiHZRRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 13:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiHZRRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:17:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D7AD87F3;
        Fri, 26 Aug 2022 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534269; x=1693070269;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KwjNfQYAzpFvaPY/cJlUEOzalTxntNE7gB2sV8ipr7o=;
  b=jKzJ/RUzo3sYsSR3TPrfEIoYsoztzz5gf4Zu2wtYSdAgPpoYhsrcIUw4
   +164XtHAgpfuIw8o4hDbwJVdBsM+LPRB0p9w+t9SltbDRHf2UwKLhq8Bw
   skJAvpJ2cGyZmFo5vYCaY2K0+ATKBwPzhHgMfquVCkTpu/OobF+TzKfXy
   OmoEXmZOHVXWTk4T8TmGh+GuhWEmJk+k1TWHJXMB7IL8YJQsbjdnt4g77
   dIugWRzDR6SsDyxgfLyI1/ocFbnSE2ta2ue/2tedfsX+uOw7NF8hYYbqN
   6dnUmFjxbNxh7Ka/hC5QOY3a+hB4njUhou0hnrw1kj1mHEzRdTdBruAko
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="380858548"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="380858548"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:17:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="856078731"
Received: from jodirobx-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.108.22])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:17:48 -0700
Subject: [PATCH 0/4] mm, xfs, dax: Fixes for memory_failure() handling
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org, djwong@kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Jane Chu <jane.chu@oracle.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Al Viro <viro@zeniv.linux.org.uk>, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 26 Aug 2022 10:17:48 -0700
Message-ID: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I failed to run the memory error injection section of the ndctl test
suite on linux-next prior to the merge window and as a result some bugs
were missed. While the new enabling targeted reflink enabled XFS
filesystems the bugs cropped up in the surrounding cases of DAX error
injection on ext4-fsdax and device-dax.

One new assumption / clarification in this set is the notion that if a
filesystem's ->notify_failure() handler returns -EOPNOTSUPP, then it
must be the case that the fsdax usage of page->index and page->mapping
are valid. I am fairly certain this is true for
xfs_dax_notify_failure(), but would appreciate another set of eyes.

The bulk of the change is in mm/memory-failure.c, so perhaps this set
should go through Andrew's tree.

---

Dan Williams (4):
      xfs: Quiet notify_failure EOPNOTSUPP cases
      xfs: Fix SB_BORN check in xfs_dax_notify_failure()
      mm/memory-failure: Fix detection of memory_failure() handlers
      mm/memory-failure: Fall back to vma_address() when ->notify_failure() fails


 fs/xfs/xfs_notify_failure.c |    6 +++---
 include/linux/memremap.h    |    5 +++++
 mm/memory-failure.c         |   24 +++++++++++++-----------
 3 files changed, 21 insertions(+), 14 deletions(-)

base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
