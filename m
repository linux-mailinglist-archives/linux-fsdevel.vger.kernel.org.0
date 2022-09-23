Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22D45E803D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 18:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIWQ7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIWQ7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:59:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C831497A1;
        Fri, 23 Sep 2022 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663952349; x=1695488349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CIRBiJPRHh+0D1EeS0RX65F9gDuYu+hhf6z3sGzOoSM=;
  b=Es6xcQ46ards3kmV+xJB+aj0QiV+afDKisD3xstyIb7hEXKnEtyMKCN7
   EeWV4NV9Vd/Sfi+FZdz2Rx52iV5U7kDfxFay7zuVcwznhdoA0SXCxIr8W
   w5r0p3cDVkwe6ODXxYGF9jYTZvCjUWpuBjBanB5Sdmuej/zMF5svv/5mD
   hRc8Meg1+W1HT0lbYd5KvsgSqI4JVX1M5eDT4JCcaVuZs1Y4Z/x4Otsb6
   AcvZegd5B0POwbtinqowlAuwklhh0XuEJneRcdbOHH95xzjRFJMpGH8LX
   Qvp5rsHXGfiMSIDLiEMO3kFH2hIw80pUQg5ALQc9SOT769LAYWk3MQhqs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="362448428"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="362448428"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="709359851"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Sep 2022 09:59:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1obm12-006ZuO-2Q;
        Fri, 23 Sep 2022 19:59:04 +0300
Date:   Fri, 23 Sep 2022 19:59:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Eliav Farber <farbere@amazon.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        yangyicong@hisilicon.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH] libfs: fix negative value support in simple_attr_write()
Message-ID: <Yy3l2IIFEjDWGNlF@smile.fi.intel.com>
References: <20220918135036.33595-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918135036.33595-1-farbere@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 18, 2022 at 01:50:36PM +0000, Eliav Farber wrote:
> After commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), a user trying set a negative value will get a
> '-EINVAL' error, because simple_attr_write() was modified to use
> kstrtoull() which can handle only unsigned values, instead of
> simple_strtoll().
> 
> This breaks all the places using DEFINE_DEBUGFS_ATTRIBUTE() with format
> of a signed integer.
> 
> The u64 value which attr->set() receives is not an issue for negative
> numbers.
> The %lld and %llu in any case are for 64-bit value. Representing it as
> unsigned simplifies the generic code, but it doesn't mean we can't keep
> their signed value if we know that.
> 
> This change basically reverts the mentioned commit, but uses kstrtoll()
> instead of simple_strtoll() which is obsolete.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

and I prefer this one over spreading more macros with redundant formatting
parameter.

> Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  fs/libfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 31b0ddf01c31..3bccd75815db 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1016,7 +1016,7 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
>  		goto out;
>  
>  	attr->set_buf[size] = '\0';
> -	ret = kstrtoull(attr->set_buf, 0, &val);
> +	ret = kstrtoll(attr->set_buf, 0, &val);
>  	if (ret)
>  		goto out;
>  	ret = attr->set(attr->data, val);
> -- 
> 2.37.1
> 

-- 
With Best Regards,
Andy Shevchenko


