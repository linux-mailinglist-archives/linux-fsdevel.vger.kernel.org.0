Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D0252913A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 22:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbiEPUJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 16:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350021AbiEPUAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 16:00:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F053A45AC7;
        Mon, 16 May 2022 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652730891; x=1684266891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fScrN08znRDZaq3DWOz2/SzfYqSDlpSGins4k3VDQok=;
  b=C8vYxgEMQEXCfuZ2a8yqVSQ0BC12xHGEhkOND/PbkXlE0SpPHcoJXNzW
   MnYO9PhcBwK1BbolpV3g0sB+JllxsEh6fzlK4x2JDenD08emyZ7ZC1Cg5
   eD9Myq/CD1N4Tnzn5ydKCIzJk6rv+oYjGDbo79TzCwtKW2ZzIi0W8vZ+2
   q6eaABVq2wGqvxppv1EkTWqEEygLwqnR+K4fFC3RUQ9UwJZ4VXW3OUwXZ
   jz9sX4f1X5u/PetbjRxx3qs1EW/qbe8oSoImr3Km/IXwsBOQ38jmO1HKg
   qxdPmVeLnvaBNVAPZBzCGBIsv/aR/HWs549P2GqzF0gZajeqA6oLU+480
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="333990653"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="333990653"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 12:53:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="568501950"
Received: from csalmon-mobl.amr.corp.intel.com (HELO localhost) ([10.212.118.70])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 12:53:54 -0700
Date:   Mon, 16 May 2022 12:53:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <YoKr0rUEA6q2wYs4@iweiny-desk3>
References: <20220516101925.15272-1-fmdefrancesco@gmail.com>
 <YoJl+lh0QELbv/TL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoJl+lh0QELbv/TL@casper.infradead.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 03:55:54PM +0100, Matthew Wilcox wrote:
> On Mon, May 16, 2022 at 12:19:25PM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page(). With
> > kmap_local_page(), the mapping is per thread, CPU local and not globally
> > visible.
> > 
> > The usage of kmap_local_page() in fs/ufs is pre-thread, therefore replace
> > kmap() / kunmap() calls with kmap_local_page() / kunmap_local().
> > 
> > kunmap_local() requires the mapping address, so return that address from
> > ufs_get_page() to be used in ufs_put_page().
> > 
> > These changes are essentially ported from fs/ext2 and are largely based on
> > commit 782b76d7abdf ("fs/ext2: Replace kmap() with kmap_local_page()").
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Have you done more than compile-tested this?  I'd like to know that it's
> been tested on a machine with HIGHMEM enabled (in a VM, presumably).
> UFS doesn't get a lot of testing, and it'd be annoying to put out a
> patch that breaks the kmap_local() rules.

I'm not against trying to test.  But did you see a place which might break
the kmap_local() rules?

Ira
