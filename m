Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB3C224F39
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 06:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgGSElh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 00:41:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:61697 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgGSElh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 00:41:37 -0400
IronPort-SDR: nza1mJTyNBeOvSsIDLc1pCI3luxkGOucCnIqiAj8Vb7vFYljs9Z2SS1R0q9ftO/I5BmIaRJlxW
 NNI9+O2Wc0Hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="211329734"
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="scan'208";a="211329734"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 21:41:36 -0700
IronPort-SDR: 0R5r0POrAHJZkIVzaYM5LvL14m/HsDRcbVdHTM0jGjiiFzLf4uCpR3LN64DWY7R6h6P5xz5WOU
 AavFLGXR8NLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="scan'208";a="269852530"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2020 21:41:36 -0700
Date:   Sat, 18 Jul 2020 21:41:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 14/17] dax: Stray write protection for
 dax_direct_access()
Message-ID: <20200719044135.GB478573@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-15-ira.weiny@intel.com>
 <20200717092243.GD10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717092243.GD10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:22:43AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:53AM -0700, ira.weiny@intel.com wrote:
> 
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -30,12 +30,14 @@ static DEFINE_SPINLOCK(dax_host_lock);
> >  
> >  int dax_read_lock(void)
> >  {
> > +	dev_access_enable();
> >  	return srcu_read_lock(&dax_srcu);
> >  }
> >  EXPORT_SYMBOL_GPL(dax_read_lock);
> >  
> >  void dax_read_unlock(int id)
> >  {
> > +	dev_access_disable();
> >  	srcu_read_unlock(&dax_srcu, id);
> >  }
> >  EXPORT_SYMBOL_GPL(dax_read_unlock);
> 
> This is inconsistently ordered.

Thanks, good catch.

Fixed.
Ira
