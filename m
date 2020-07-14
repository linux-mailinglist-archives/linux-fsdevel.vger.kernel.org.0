Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1A21FC8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgGNTKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:10:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:65171 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbgGNTJw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:52 -0400
IronPort-SDR: 9Bfeb0/0Naw0dTcYqAOMzBFQIbwFhqES6uIjGLDuwYS6ZDA9k7rTiIx6IdmO+QnHqP7wxi5UuR
 3y9gI5QUBFDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="150426923"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="150426923"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 12:09:46 -0700
IronPort-SDR: F5+6TagJ+l1griOYsZtzQkFGRpSQRa2AcrvfdSOx4vFmi7tumHZNFRIJUHlFtNvtasUh0ZpCV3
 s3kdDTQFO7MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="285855453"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2020 12:09:45 -0700
Date:   Tue, 14 Jul 2020 12:09:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 04/15] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200714190945.GD3008823@iweiny-DESK2.sc.intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-5-ira.weiny@intel.com>
 <20200714082701.GO10769@hirez.programming.kicks-ass.net>
 <20200714185322.GB3008823@iweiny-DESK2.sc.intel.com>
 <20200714190539.GG5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714190539.GG5523@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:05:39PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 14, 2020 at 11:53:22AM -0700, Ira Weiny wrote:
> > On Tue, Jul 14, 2020 at 10:27:01AM +0200, Peter Zijlstra wrote:
> > > On Tue, Jul 14, 2020 at 12:02:09AM -0700, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > The PKRS MSR is defined as a per-core register.  This isolates memory
> > > > access by CPU.  Unfortunately, the MSR is not preserved by XSAVE.
> > > > Therefore, We must preserve the protections for individual tasks even if
> > > > they are context switched out and placed on another cpu later.
> > > 
> > > This is a contradiction and utter trainwreck.
> > 
> > I don't understand where there is a contradiction?  Perhaps I should have said
> > the MSR is not XSAVE managed vs 'preserved'?
> 
> You're stating the MSR is per-*CORE*, and then continue to talk about
> per-task state.
> 
> We've had a bunch of MSRs have exactly that problem recently, and it's
> not fun. We're not going to do that again.

Ah sorry, my mistake yes I meant 'per-logical-processor' like Dave said.  I'll
update the commit message.

Ira
