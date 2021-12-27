Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2E47FEC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 16:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhL0Pci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 10:32:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:31158 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238015AbhL0Pce (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640619154; x=1672155154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ftgT5rz4My36TxPcpmhbqQvJm2D6myU8LmuRkWvQ4k=;
  b=l9HwYedXxh17oewzcthf6hmiuxufojNoEXZvwBkSz0uywoQdMXnSDe69
   uwZH00uVxZoFDXKvKdi8m4HBfdUNVFcCvawSwmVhuaqbKV+FK5gqAuDHZ
   pcwX7BOwn+4xHKWQttHerkRwi7F/+R8Up0DnvrrFx3uHgnFl72rNqYrv2
   3NFBKmpVrCwiMs1NWrwaA0JMbfdeSvzRDfgskWEXbZIgKKac8P9xQN4dT
   sgk0MjG1lI63I4haYi4GmKqlEglJ4dzuOksQnJgoKH6N10AJex99deZRM
   dYC91SdJbiF13hXlUdP3mm8jG+K5Y3oCnI60NSNc++SiDTAA2TWg3u0/K
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="301979530"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="301979530"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 07:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="618475900"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Dec 2021 07:32:27 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1rz8-0006UP-SR; Mon, 27 Dec 2021 15:32:26 +0000
Date:   Mon, 27 Dec 2021 23:32:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Message-ID: <202112272340.1ho7sEjG-lkp@intel.com>
References: <20211227125444.21187-20-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227125444.21187-20-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeffle,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dhowells-fs/fscache-next]
[cannot apply to xiang-erofs/dev-test ceph-client/for-linus linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-next
config: csky-defconfig (https://download.01.org/0day-ci/archive/20211227/202112272340.1ho7sEjG-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/54c300b4598e3f2836d8233681da387fe388cfda
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
        git checkout 54c300b4598e3f2836d8233681da387fe388cfda
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash fs/cachefiles/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/cachefiles/io.c:564:5: warning: no previous prototype for 'cachefiles_demand_read' [-Wmissing-prototypes]
     564 | int cachefiles_demand_read(struct netfs_cache_resources *cres,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   In function 'cachefiles_alloc_req',
       inlined from 'cachefiles_demand_read' at fs/cachefiles/io.c:575:8:
>> fs/cachefiles/io.c:557:9: warning: 'strncpy' specified bound 255 equals destination size [-Wstringop-truncation]
     557 |         strncpy(req_in->path, object->d_name, sizeof(req_in->path));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +557 fs/cachefiles/io.c

   541	
   542	static struct cachefiles_req *cachefiles_alloc_req(struct cachefiles_object *object,
   543							   loff_t start_pos,
   544							   size_t len)
   545	{
   546		struct cachefiles_req *req;
   547		struct cachefiles_req_in *req_in;
   548	
   549		req = kzalloc(sizeof(*req), GFP_KERNEL);
   550		if (!req)
   551			return NULL;
   552	
   553		req_in = &req->req_in;
   554	
   555		req_in->off = start_pos;
   556		req_in->len = len;
 > 557		strncpy(req_in->path, object->d_name, sizeof(req_in->path));
   558	
   559		init_completion(&req->done);
   560	
   561		return req;
   562	}
   563	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
