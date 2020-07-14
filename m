Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD9D21FCA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgGNTKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:10:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:44617 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbgGNTKs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:10:48 -0400
IronPort-SDR: aRltyJuDUAWNLWYG9L4QE5NcVtwR+o0I6oAsrfTCFWW7zwEKXRsIKbMn3/g3D4ZKj7B4RhAQtV
 p+Vp9Itfn7kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="128568509"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="128568509"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 12:10:48 -0700
IronPort-SDR: ynd6Lt5TNvbdI+beUCIxuy6WUQInSo1MvaulrgHmRMdJk8pzs6c5iZa/GKm6K4HDRY3ph5QM5F
 8i7mRSpTTt1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="390568284"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jul 2020 12:10:47 -0700
Date:   Tue, 14 Jul 2020 12:10:47 -0700
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
Subject: Re: [RFC PATCH 11/15] memremap: Add zone device access protection
Message-ID: <20200714191047.GE3008823@iweiny-DESK2.sc.intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-12-ira.weiny@intel.com>
 <20200714084057.GP10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714084057.GP10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:40:57AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 14, 2020 at 12:02:16AM -0700, ira.weiny@intel.com wrote:
> 
> > +static pgprot_t dev_protection_enable_get(struct dev_pagemap *pgmap, pgprot_t prot)
> > +{
> > +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> > +		pgprotval_t val = pgprot_val(prot);
> > +
> > +		mutex_lock(&dev_prot_enable_lock);
> > +		dev_protection_enable++;
> > +		/* Only enable the static branch 1 time */
> > +		if (dev_protection_enable == 1)
> > +			static_branch_enable(&dev_protection_static_key);
> > +		mutex_unlock(&dev_prot_enable_lock);
> > +
> > +		prot = __pgprot(val | _PAGE_PKEY(dev_page_pkey));
> > +	}
> > +	return prot;
> > +}
> > +
> > +static void dev_protection_enable_put(struct dev_pagemap *pgmap)
> > +{
> > +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> > +		mutex_lock(&dev_prot_enable_lock);
> > +		dev_protection_enable--;
> > +		if (dev_protection_enable == 0)
> > +			static_branch_disable(&dev_protection_static_key);
> > +		mutex_unlock(&dev_prot_enable_lock);
> > +	}
> > +}
> 
> That's an anti-pattern vs static_keys, I'm thinking you actually want
> static_key_slow_{inc,dec}() instead of {enable,disable}().

Thanks.  I'll go read the doc for those as I'm not familiar with them.

Ira
