Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E708A5C0016
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIUOk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 10:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIUOkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:40:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097504BD2B;
        Wed, 21 Sep 2022 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663771224; x=1695307224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pM6yA6AJ9Eh1jPWxSkV7ceab4yFKTnUkuNGbuDJGxaM=;
  b=lE29qnJZZwdkyDLF276+7dSwmLVTtwBQdCz0FlDLXLGMgsbT0t83h3pW
   OBXgzMMtIgxK6ZMuFrwShVmHUs4Lehmiqos/iQuJbUBtWM7J03OqSj4+w
   Q+q0QK+8JsJWftrqev/CKG1bu2g3/UGk02j6bt1eYiQsJWtsYTCS3eVjf
   adFSW+DbuKyEBLAFJsZF9lNYoz7A4uf9FvjZIw2We6gR6YhdnSPLKFFTc
   b5jLW+rfBUwmFzlAOZpr1YHBvnP8m3nG/ScVDwF4+YrvC4WBgeRmQVY1R
   24sqDkipI6P+8LSGuPwwBXaB4M+dcGucTQ5gOQfPSHblSiQJHrWoTE9rc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="363996364"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="363996364"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 07:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="794696206"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2022 07:40:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ob0tf-005ark-1n;
        Wed, 21 Sep 2022 17:40:19 +0300
Date:   Wed, 21 Sep 2022 17:40:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eliav Farber <farbere@amazon.com>, viro@zeniv.linux.org.uk,
        yangyicong@hisilicon.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] libfs: fix negative value support in simple_attr_write()
Message-ID: <YysiU0shyB2N0kl7@smile.fi.intel.com>
References: <20220918135036.33595-1-farbere@amazon.com>
 <20220919142413.c294de0777dcac8abe2d2f71@linux-foundation.org>
 <YysiDKaLpiUUlX78@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YysiDKaLpiUUlX78@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:39:09PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 19, 2022 at 02:24:13PM -0700, Andrew Morton wrote:
> > On Sun, 18 Sep 2022 13:50:36 +0000 Eliav Farber <farbere@amazon.com> wrote:

...

> > https://lkml.kernel.org/r/20220919172418.45257-1-akinobu.mita@gmail.com

> > Should the final version of this fix be backported into -stable trees?
> 
> But it questioning the formatting string as a parameter. Why do we need that
> in the first place then?

Sorry if above is the similar to something I have sent earlier, I had had an
issue with my IMAP and SMTP servers access.

-- 
With Best Regards,
Andy Shevchenko


