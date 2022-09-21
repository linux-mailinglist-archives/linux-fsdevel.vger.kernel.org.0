Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C005C000F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIUOjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 10:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIUOjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:39:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA3491D1D;
        Wed, 21 Sep 2022 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663771153; x=1695307153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oFx94BI3SJh/UQVfFOWc15ZgcO3WozKUbcES7Xwvxf4=;
  b=mAEc0FbS9APCMMSyylISU+ARLP/Yrebz0yDtD7mJ59olH3cENXMk8poX
   SuDvjDW1eILa+gXhzdfVOYZQzqYNQ8AbK0sKdFotJcjKeuTFECZaarZOE
   9Eby8YT6CBktRkQncIvfOJ9MqJflIfoKeEHoNW4l0VOPBbfsj+A7k2i3H
   7qFwb6kcwWZioBw1ofvPTzZgw3MOYpNTalLQ5/tQ42Who5hr6nDemRklp
   k6ZnDOVGjPaJ5b+DaVCunDoPRQwTp0NCd86gQWzjMxUZldML/PyM0tvZP
   wv6AWNcFiTBPW5v2FhjwJVzUVBhRw1vMYZI8ROVCPBLSJO6L4VywhrGX7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="326332291"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="326332291"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 07:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="597008978"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2022 07:39:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ob0sX-005aqQ-0L;
        Wed, 21 Sep 2022 17:39:09 +0300
Date:   Wed, 21 Sep 2022 17:39:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eliav Farber <farbere@amazon.com>, viro@zeniv.linux.org.uk,
        yangyicong@hisilicon.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] libfs: fix negative value support in simple_attr_write()
Message-ID: <YysiDKaLpiUUlX78@smile.fi.intel.com>
References: <20220918135036.33595-1-farbere@amazon.com>
 <20220919142413.c294de0777dcac8abe2d2f71@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919142413.c294de0777dcac8abe2d2f71@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 02:24:13PM -0700, Andrew Morton wrote:
> On Sun, 18 Sep 2022 13:50:36 +0000 Eliav Farber <farbere@amazon.com> wrote:
> 
> > After commit 488dac0c9237 ("libfs: fix error cast of negative value in
> > simple_attr_write()"), a user trying set a negative value will get a
> > '-EINVAL' error, because simple_attr_write() was modified to use
> > kstrtoull() which can handle only unsigned values, instead of
> > simple_strtoll().
> > 
> > This breaks all the places using DEFINE_DEBUGFS_ATTRIBUTE() with format
> > of a signed integer.
> > 
> > The u64 value which attr->set() receives is not an issue for negative
> > numbers.
> > The %lld and %llu in any case are for 64-bit value. Representing it as
> > unsigned simplifies the generic code, but it doesn't mean we can't keep
> > their signed value if we know that.
> > 
> > This change basically reverts the mentioned commit, but uses kstrtoll()
> > instead of simple_strtoll() which is obsolete.
> > 
> 
> https://lkml.kernel.org/r/20220919172418.45257-1-akinobu.mita@gmail.com
> addresses the same thing.
> 
> Should the final version of this fix be backported into -stable trees?

But it questioning the formatting string as a parameter. Why do we need that
in the first place then?

-- 
With Best Regards,
Andy Shevchenko


