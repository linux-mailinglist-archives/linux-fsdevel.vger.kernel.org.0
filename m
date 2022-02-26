Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA84C5471
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 08:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiBZHiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 02:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiBZHiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:38:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AB112630;
        Fri, 25 Feb 2022 23:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645861066; x=1677397066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rS/E+W2/97ST4K/88Qf66fE+o1rQtxjY0+PNbov5cAA=;
  b=dz7k3MLTDOtduXa2yGqJxAcD0+sIfs2dsvpyox+zEAnCWumIklNvIJrr
   WiWYJzlVLRFFZ5PdAEmcHT4rT5dZlfc2Aker+Yn97QobQ/NsP2MhqO/2D
   7sH6d2aT/H+J4BX2Oc+bUpFKI4F4PVLOrwr9zxaHoyfLrApsfiPLBvsN6
   kb0CUFbzKniyJ9KZphdOArAhN4l3GsfGupdbnO6DEeMGNa31T81x4oz8+
   KaSdluFP7ftOMMDuzFDO5kUp8RjbgAcoPvRirvKBI0NJo09rjVXeEjGy1
   +QEY1xREs0T/gdnXUOPvBVLZRwkFTTri0Y5Ig8krve3Ew1COMGQD2LuZ2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="277280221"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="277280221"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 23:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="574831778"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2022 23:37:43 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNreB-0005G1-53; Sat, 26 Feb 2022 07:37:43 +0000
Date:   Sat, 26 Feb 2022 15:37:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, dhowells@redhat.com, jlayton@kernel.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Enable multipage folio support
Message-ID: <202202261524.4tAqmT0a-lkp@intel.com>
References: <2274528.1645833226@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2274528.1645833226@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on dhowells-fs/fscache-next]
[also build test ERROR on linux/master linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Howells/afs-Enable-multipage-folio-support/20220226-075436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-next
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220226/202202261524.4tAqmT0a-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/91637acf6da0c809e1bedc59696d6bc0a8604f03
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-Howells/afs-Enable-multipage-folio-support/20220226-075436
        git checkout 91637acf6da0c809e1bedc59696d6bc0a8604f03
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "PageHeadHuge" [fs/afs/kafs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
