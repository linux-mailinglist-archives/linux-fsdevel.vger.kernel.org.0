Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC5F4B324B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Feb 2022 02:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354508AbiBLBGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 20:06:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiBLBF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 20:05:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84346D82
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Feb 2022 17:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644627957; x=1676163957;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H07qaKKnB1/Rwj0EaU6kOlwcsfqpK2vhuLy0FxKtZg0=;
  b=mtSzw6eH/FiDz7LbAUMH4d+3IeZYS9kpT+xwbBtMBakg1pw12CdE5leD
   O2rU63niWt4AkuAxbQzZqQTmHjYAOPS3vg30JvQn3OwtGzP6cAFklEl2N
   phKk8m4usuGGLsNSzdL24RxZFkcgmhM/mFO1p20p0MRQZm91NZ8KZMhRR
   CxmqmMAJIb3ZfIjw8aff6ROe44oYfXNsozxoScSZsGaWK4Zsw+EggbY9g
   WTz6jaDDrwBAfdYOa1sw6k6QLFqpJj9yv6eZPqfGev7zleB61fGFCJ0lt
   hPRS7REtUr49lnxBheLeC1SKu6frawsJs5DQ1CaeU+L1fy+Q2JcSEVw7C
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="248670259"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="248670259"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:05:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542308724"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:05:56 -0800
Date:   Fri, 11 Feb 2022 17:05:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     ira.weiny@intel.com, 'Dan Williams' <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: PKS for the page cache and beyond
Message-ID: <20220212010556.GU785175@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Protection Key Supervisor (PKS) presents a way to control access to a large
domain of memory quickly, without a page table walk or TLB flush, as well as
with finer granularity; allowing protection control on individual threads.

Multiple areas of memory have been identified as candidates to be protected
with PKS.  These include the initial use case persistent memory (PMEM), page
tables[1], kernel secret keys[2], and the page cache.[3]  Like PMEM the page
cache presents a significant surface area where stray writes, or other bugs,
could corrupt data permanently.

I would like to discuss the ramifications of being able to change memory
permissions in this new way.  While PKS has a lot to offer it does not come for
free.  One trade off is the loss of direct access via page_address() in
!HIGHMEM builds.

Already PMEM's faced challenges in the leverage of kmap/kunmap.  While the page
cache should be able to leverage this work, this is driving a redefinition of
what kmap means.  Especially since the HIGHMEM use case is increasingly
meaningless on modern machines.

Ira Weiny

[1] https://lore.kernel.org/lkml/20210830235927.6443-2-rick.p.edgecombe@intel.com/
[2] https://lore.kernel.org/lkml/20201009201410.3209180-3-ira.weiny@intel.com/
[3] https://lwn.net/Articles/883352/
