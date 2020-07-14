Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2321EB4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGNI1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgGNI1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:27:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F56C061755;
        Tue, 14 Jul 2020 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A51ag8nDs9zuaekV72PLvRRRTy65GcHBqX/h7vCoPM8=; b=Qliqg88yubr5gTr0CebRm5zHyM
        VmoSi0W8BiWxbo8q0BQItVbTESnzPp2YQGxipV4dST4DFJUBsJEgrytU7IzP9Ptmtt31ahpakJj6W
        pvVJgC5LHcsQYfqFGy5fNdrhBWJcuZf7H3SfDGiu09ZMSL4+z0b4A+hAncBX1lLJRahHM4aEJlNXj
        lWa0NgagAQJSPYr3J9uR3wRQOov3bvouDKlbm6svybYdiMyh2k7P7B7hdk3PoyRtrnU8/ltNHbyf4
        4872KPEM7cf358Zm+G7TVXFu4J9ua11eoXXrDYwTVxnobsO9G7E1mpGrwznsBUZ6VolO/a5+BQvvh
        bjtbmldw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvGHI-0003qe-0A; Tue, 14 Jul 2020 08:27:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E72DC305C22;
        Tue, 14 Jul 2020 10:27:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5FA120D27C6B; Tue, 14 Jul 2020 10:27:01 +0200 (CEST)
Date:   Tue, 14 Jul 2020 10:27:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     ira.weiny@intel.com
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
Message-ID: <20200714082701.GO10769@hirez.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714070220.3500839-5-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:02:09AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The PKRS MSR is defined as a per-core register.  This isolates memory
> access by CPU.  Unfortunately, the MSR is not preserved by XSAVE.
> Therefore, We must preserve the protections for individual tasks even if
> they are context switched out and placed on another cpu later.

This is a contradiction and utter trainwreck. We're not going to do more
per-core MSRs and pretend they make sense per-task.
