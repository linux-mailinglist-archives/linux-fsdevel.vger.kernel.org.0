Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E601421FDF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 22:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgGNUAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 16:00:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:25480 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgGNUAl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:00:41 -0400
IronPort-SDR: 2IhkmdjfPgZ5IuioDDRrcWeaOHjBw3lv0U5MhQaqEp8Xl+psT/JE+D0WyUK0huLJiDBztAorb9
 BkNPxqDPHcTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="210560145"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="210560145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 13:00:41 -0700
IronPort-SDR: 4MS2nxEKSwXjwkPrhbmJP1OzdSRAj8lQAiaaHjC1Noo6yhxlz0lTa5uR4dcxyj5kZWZTGL1LmE
 m/OZlhrKMlvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="299658353"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2020 13:00:40 -0700
Date:   Tue, 14 Jul 2020 13:00:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [RFC PATCH 12/15] kmap: Add stray write protection for device
 pages
Message-ID: <20200714200040.GF3008823@iweiny-DESK2.sc.intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-13-ira.weiny@intel.com>
 <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
 <20200714190615.GC3008823@iweiny-DESK2.sc.intel.com>
 <20200714192930.GH5523@worktop.programming.kicks-ass.net>
 <50d472d8-e4d9-dd35-f31f-268aa69c76e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d472d8-e4d9-dd35-f31f-268aa69c76e2@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:42:11PM -0700, Dave Hansen wrote:
> On 7/14/20 12:29 PM, Peter Zijlstra wrote:
> > On Tue, Jul 14, 2020 at 12:06:16PM -0700, Ira Weiny wrote:
> >> On Tue, Jul 14, 2020 at 10:44:51AM +0200, Peter Zijlstra wrote:
> >>> So, if I followed along correctly, you're proposing to do a WRMSR per
> >>> k{,un}map{_atomic}(), sounds like excellent performance all-round :-(
> >> Only to pages which have this additional protection, ie not DRAM.
> >>
> >> User mappings of this memory is not affected (would be covered by User PKeys if
> >> desired).  User mappings to persistent memory are the primary use case and the
> >> performant path.
> > Because performance to non-volatile memory doesn't matter? I think Dave
> > has a better answer here ...
> 
> So, these WRMSRs are less evil than normal.  They're architecturally
> non-serializing instructions, just like the others in the SDM WRMSR
> documentation:
> 
> 	Note that WRMSR to the IA32_TSC_DEADLINE MSR (MSR index 6E0H)
> 	and the X2APIC MSRs (MSR indices 802H to 83FH) are  not
> 	serializing.
> 
> This section of the SDM needs to be updated for the PKRS.  Also note
> that the PKRS WRMSR is similar in its ordering properties to WRPKRU:
> 
> 	WRPKRU will never execute speculatively. Memory accesses
> 	affected by PKRU register will not execute (even speculatively)
> 	until all prior executions of WRPKRU have completed execution
> 	and updated the PKRU register.
> 
> Which means we don't have to do silliness like LFENCE before WRMSR to
> get ordering *back*.  This is another tidbit that needs to get added to
> the SDM.  It should probably also get captured in the changelog.
> 
> But, either way, this *will* make accessing PMEM more expensive from the
> kernel.  No escaping that.  But, we've also got customers saying they
> won't deploy PMEM until we mitigate this stray write issue.  Those folks
> are quite willing to pay the increased in-kernel cost for increased
> protection from stray kernel writes.  Intel is also quite motivated
> because we really like increasing the number of PMEM deployments. :)
> 
> Ira, can you make sure this all gets pulled into the changelogs somewhere?

Yes of course.  Thanks for writing that up.

Ira
