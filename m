Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8114C4A2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 17:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiBYQLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 11:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiBYQLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:11:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E2D1DBA86
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 08:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645805431; x=1677341431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H07qaKKnB1/Rwj0EaU6kOlwcsfqpK2vhuLy0FxKtZg0=;
  b=nQz799FL+TGZJiChuyUBC75TJoA2y/wMoxeKGVCojAgURU9pjruhAXhG
   3j4fygtp4BOHc5fGNgmtbQxWLLOH7VRoiEihbAyOo5w7pc5UulaA3V/fg
   iNbeZ0DqkBZidPAr/1CnJzIYjcruvkpcjP+GVw70u+7F3VE8IQzmHPS6+
   0M+B51JDvMqHffoDeW/TOI2DsuHgQ98Y2KswwYMVa2rLqSpBqQ13ISAAu
   eS6D2488rFyNIrtIhWaW/sQsZHatwGrENfbpbJXDfQQT4Xm4oP/rKvjNs
   Xicjr/HkArZr/5OfKWBd3ob8WPbxXzOvgxfnSd8rn4/8vfo/zqJ/+QY0W
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="236031147"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="236031147"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:10:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="533618474"
Received: from skannan1-mobl1.amr.corp.intel.com (HELO localhost) ([10.209.142.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:10:30 -0800
Date:   Fri, 25 Feb 2022 08:10:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     ira.weiny@intel.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [LSF/MM/PPF TOPIC] PKS for the page cache and beyond
Message-ID: <Yhj/dsW1IiU9PgzI@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
