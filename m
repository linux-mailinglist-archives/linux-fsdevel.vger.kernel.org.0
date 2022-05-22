Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570CD530220
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbiEVJnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiEVJnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 05:43:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6368E369F5;
        Sun, 22 May 2022 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653212596; x=1684748596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J1uRxreTk2vcgBP+Mv+o2kjbzDSrcYl4+WqXF1IBsU8=;
  b=XLdFBFgoTxYniEX/Tgn4Zn+eawD1UL5Q246madtsbUR93j8vJQJxGjGC
   DSmUBRbgrz1vTIcybBLpuT4IxU6VLCyv0S4x5GShKFED4IgCb7Oq0htuq
   JJzS5PP8EuSazctx0FafiAytjCG4YkwDjJ5d6xursevIyPMC/3+XZEYQ1
   CU5NPbb35V0FZkTgnA4oN/pGVkgMvKLyufNbocRKD+0rRB1WL6DbGOvvc
   E+3c6wF9N2x1TKJgnidh20sMU/i4ItCB0LdyCiNVDifDZTBXvtFyhs6rO
   nm7O4P7n9m8b3D3NeSXjti3nte6hgIqoLVXtK5ZhGD9Ga2Gu4dtfRq+KA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="260564934"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="260564934"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 02:43:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="571562866"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 02:43:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nsi73-000IR6-9y;
        Sun, 22 May 2022 12:43:01 +0300
Date:   Sun, 22 May 2022 12:43:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>, keescook@chromium.org,
        pmladek@suse.com, bcain@quicinc.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mcgrof@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com,
        onkarnath.1@samsung.com
Subject: Re: [PATCH 1/5] kallsyms: pass buffer size in sprint_* APIs
Message-ID: <YooFpVGuDoyfoQPS@smile.fi.intel.com>
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
 <CGME20220520083725epcas5p1c3e2989c991e50603a40c81ccc4982e0@epcas5p1.samsung.com>
 <20220520083701.2610975-2-maninder1.s@samsung.com>
 <f3627eae-f5ae-1d30-2c09-1820a255334a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3627eae-f5ae-1d30-2c09-1820a255334a@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 03:52:01PM -0400, Waiman Long wrote:
> On 5/20/22 04:36, Maninder Singh wrote:

...

> > -		sprint_symbol(sym, addr);
> > +		sprint_symbol(sym, KSYM_SYMBOL_LEN, addr);
> 
> Instead of hardcoding KSYM_SYMBOL_LEN everywhere, will it better to hide it
> like this:
> 
>         extern int __sprint_symbol(char *buffer, size_t size, unsigned long
> address);
>         #define sprint_symbol(buf, addr)        __sprint_symbol(buf,
> sizeof(buf), addr)
> 
> Or you can use sizeof(buf) directly instead of KSYM_SYMBOL_LEN.

This assumes that buf is defined as char [], which might be not always the
case. If you are going with the macro, than ARRAY_SIZE() seems appropriate
to perform a check against the above mentioned constraint.


-- 
With Best Regards,
Andy Shevchenko


