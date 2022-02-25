Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFAD4C4B2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 17:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbiBYQqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 11:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240744AbiBYQqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:46:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E64A22D648
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645807572; x=1677343572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCgw0LWT1+2QvtoTlKlxzXXA4QkTFgfXGwz78fZbxIk=;
  b=dMykKfp4O68B3Mglq+bSSrEi7GbGO7JCBjvF9m5P5arPAkrzzI2kfix2
   7L5DDWtH3MNMT7yNdawvBR+MzUGb4fWniSmZbFNnneaERf/rOYcEteTWv
   X6epEejkCybr2VWfoxYJEC48KvwzgQcq0iMZgCETvi7qbyEdFbcvmjoiV
   25Sgy1QSOXTbWEcaO804MzDe0rBCgQlpBWQC1X8d6e1mqdJePpUoidqRO
   4tmauxKM1/8NlblA1nMSpRyKClfqYl/aYE9XC854Beh7QmFUOk3gnFdVr
   Q0j45IkfFh3b/wsnH7jUdtcbZvvWRThzsO7PPSI5PGSdotrhhhkObQvT2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="236038244"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="236038244"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:45:56 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="506742962"
Received: from skannan1-mobl1.amr.corp.intel.com (HELO localhost) ([10.209.142.223])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:45:52 -0800
Date:   Fri, 25 Feb 2022 08:45:51 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        ira.weiny@intel.com
Subject: [LSF/MM/BPF TOPIC] PKS for the page cache and beyond
Message-ID: <YhkHvxrEeiIMNQm8@iweiny-desk3>
References: <Yhj/dsW1IiU9PgzI@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhj/dsW1IiU9PgzI@iweiny-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Resend due to typo in tag. s/PPF/BPF/

However, I also realized one should fill out the google form now.  I'll do that
straight away.

Thanks,
Ira

On Fri, Feb 25, 2022 at 08:10:30AM -0800, Ira Weiny wrote:
> Hello,
> 
> Protection Key Supervisor (PKS) presents a way to control access to a large
> domain of memory quickly, without a page table walk or TLB flush, as well as
> with finer granularity; allowing protection control on individual threads.
> 
> Multiple areas of memory have been identified as candidates to be protected
> with PKS.  These include the initial use case persistent memory (PMEM), page
> tables[1], kernel secret keys[2], and the page cache.[3]  Like PMEM the page
> cache presents a significant surface area where stray writes, or other bugs,
> could corrupt data permanently.
> 
> I would like to discuss the ramifications of being able to change memory
> permissions in this new way.  While PKS has a lot to offer it does not come for
> free.  One trade off is the loss of direct access via page_address() in
> !HIGHMEM builds.
> 
> Already PMEM's faced challenges in the leverage of kmap/kunmap.  While the page
> cache should be able to leverage this work, this is driving a redefinition of
> what kmap means.  Especially since the HIGHMEM use case is increasingly
> meaningless on modern machines.
> 
> Ira Weiny
> 
> [1] https://lore.kernel.org/lkml/20210830235927.6443-2-rick.p.edgecombe@intel.com/
> [2] https://lore.kernel.org/lkml/20201009201410.3209180-3-ira.weiny@intel.com/
> [3] https://lwn.net/Articles/883352/
