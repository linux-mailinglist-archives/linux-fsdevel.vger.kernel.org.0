Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644DB21FD59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgGNT3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNT3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:29:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4651FC061755;
        Tue, 14 Jul 2020 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DxRaLkjpUaoEf0xxT682sMuthlbkUQaqou9xBSEthzs=; b=tzoYhF+ndXteGbrYuyAmg/q9ql
        lJtaI0FuH3c8J42sQR/E2uYkhCpFeXPc7FOgJmI68T+H7bkQ1q0y60RT2NqowxnJ3StJLPeHeFkX+
        OJQuj30D3GKP79EnnrdKlWLBIRpGW8Uk7sk/geT4GGepsLX1EzHvB6k7GgVEqZNBr8+N0VDQGEOvL
        qCTLoXPiM68Ko3DHDHTOU+jyhW0vavjCzO+PW93pSARAtS+smk4XeVnWr5NFiSvSl/91dIrVZy0Kj
        3iEsiKrDzeyxoXFNxo7ATz5CUBvlf0xCdP/0GAON2pptcLhSZ1rsMxpICMN616g+xltCbAX7YAnS8
        Yffd4cvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQcO-0002xP-EN; Tue, 14 Jul 2020 19:29:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA08A9817E0; Tue, 14 Jul 2020 21:29:30 +0200 (CEST)
Date:   Tue, 14 Jul 2020 21:29:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
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
Subject: Re: [RFC PATCH 12/15] kmap: Add stray write protection for device
 pages
Message-ID: <20200714192930.GH5523@worktop.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-13-ira.weiny@intel.com>
 <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
 <20200714190615.GC3008823@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714190615.GC3008823@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:06:16PM -0700, Ira Weiny wrote:
> On Tue, Jul 14, 2020 at 10:44:51AM +0200, Peter Zijlstra wrote:

> > So, if I followed along correctly, you're proposing to do a WRMSR per
> > k{,un}map{_atomic}(), sounds like excellent performance all-round :-(
> 
> Only to pages which have this additional protection, ie not DRAM.
> 
> User mappings of this memory is not affected (would be covered by User PKeys if
> desired).  User mappings to persistent memory are the primary use case and the
> performant path.

Because performance to non-volatile memory doesn't matter? I think Dave
has a better answer here ...
