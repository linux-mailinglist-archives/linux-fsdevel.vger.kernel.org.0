Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25222534014
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbiEYPMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 11:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245103AbiEYPMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 11:12:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC3B0D03;
        Wed, 25 May 2022 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653491556; x=1685027556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dcB6j0j2Z3wrogy8OawuEn4BB7M0+1bgI6Iy3Cd0r/8=;
  b=O/nP8oxQ7KQjkscmmf3pUB25ysZqovznoesalcczOBnt/saPrFhkkOoV
   2Q7WVqUrptc+6E1+rk1KWMaVuMNFMMLZEc8X+FHytBMjGtN40KIJFjOlo
   HfCcie0ky+tx/qfYq+jAc2Y52OYCNvVeE9zOxTLLVMhsABrqi9+Rachkl
   sqv6NuuBU4cHrwEoyq+HKFg+Vj4SHojPQkaARDQ5CR91EB/evEGDala0C
   DrPE4gF6lnwRyiYYAk+2277dLVKzXjem6wzBbxmJg1n3r0//uA5aVxuzW
   M8NzD/UrEC9rUvQqpxIjfT+S/PvVH1tO/vPwnxbbaHi4GXnG2U7oedLo/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="271411558"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="271411558"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 08:12:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601948889"
Received: from vlpathak-mobl.amr.corp.intel.com (HELO localhost) ([10.212.116.219])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 08:12:35 -0700
Date:   Wed, 25 May 2022 08:12:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <Yo5HY3dzjVigCJ7i@iweiny-desk3>
References: <20220516101925.15272-1-fmdefrancesco@gmail.com>
 <YoJl+lh0QELbv/TL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoJl+lh0QELbv/TL@casper.infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Do you know of any real users of UFS?

Fabio and I have been looking into how to test this and it seems like UFS
support has been dropped in my system.  For example, there is no mkfs.ufs in my
fc35 system.

Searching google, I see that mkfs.ufs turns up a couple of Oracle documents.
And some other links mention something called newfs which I've never heard of.

The patches follow the same pattern which was added to ext2 a while back and
have not caused an issue.  So I'm pretty confident they will be ok.

However, if it is critical that these be tested I think Fabio will have to hold
off on these patches for now as there are plenty of other kmap() call sites
which are more important to be fixed.

Ira
