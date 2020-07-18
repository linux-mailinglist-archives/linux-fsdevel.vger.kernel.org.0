Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3D2248E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 07:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgGRFGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 01:06:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:7941 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgGRFGv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:06:51 -0400
IronPort-SDR: 7YftjD1FvMeh2cfhLU+Hl2Z19UHAwH4voI2BitVIuI/J9Dh24sj6d2cuBq5Vr4Rv5+msav1Td9
 Dd7iw7W5Prww==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="137184356"
X-IronPort-AV: E=Sophos;i="5.75,365,1589266800"; 
   d="scan'208";a="137184356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 22:06:50 -0700
IronPort-SDR: PY3XuV+vuuAtpY8rxRvZ+3vMP/33Vq1wquR8p4Yg18XVLAL6vT+hjMFvaGQsieLHuShfCSaRfd
 pufbVEiCB0pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,365,1589266800"; 
   d="scan'208";a="270979648"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2020 22:06:50 -0700
Date:   Fri, 17 Jul 2020 22:06:50 -0700
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
Subject: Re: [PATCH RFC V2 12/17] memremap: Add zone device access protection
Message-ID: <20200718050650.GT3008823@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-13-ira.weiny@intel.com>
 <20200717091053.GZ10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717091053.GZ10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:10:53AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:51AM -0700, ira.weiny@intel.com wrote:
> > +static pgprot_t dev_protection_enable_get(struct dev_pagemap *pgmap, pgprot_t prot)
> > +{
> > +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> > +		pgprotval_t val = pgprot_val(prot);
> > +
> > +		static_branch_inc(&dev_protection_static_key);
> > +		prot = __pgprot(val | _PAGE_PKEY(dev_page_pkey));
> > +	}
> > +	return prot;
> > +}
> 
> Every other pgprot modifying function is called pgprot_*(), although I
> suppose we have the exceptions phys_mem_access_prot() and dma_pgprot().

Yea...  this function kind of morphed.  The issue is that this is also a 'get'
with a corresponding 'put'.  So I'm at a loss for what makes sense between the
2 functions.

> 
> How about we call this one devm_pgprot() ?

Dan Williams mentioned to me that the devm is not an appropriate prefix.  Thus
the 'dev' prefix instead.

How about dev_pgprot_{get,put}()?

Ira
