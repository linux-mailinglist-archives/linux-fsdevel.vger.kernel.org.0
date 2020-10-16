Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD262903C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 13:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395532AbgJPLIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 07:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394978AbgJPLIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 07:08:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB189C061755;
        Fri, 16 Oct 2020 04:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eyZ2qg64RQ303sBdkP1lBs7fkr9God3dSz0qy38M/4M=; b=dZ9yLLnDn8uHkOohF4LtcVTtmG
        vD/AvaMvtW7Iv79FR7SYDe3WCGkohikUM/LA3sJTkktbuTGecWJvkHruNptN/hVsM2IupFmNIA5S2
        H69bQ0Xu77anBDXOJpsYWe7HHiH337wX6hYLdljPurcjoEypXOYYjyKQvTTowiu2JOKasGGQ3Ossx
        x62zDNQP0/8RlsPG6ycSOA2wYISuv2XuWA+cMKIfe67hrK8616drWYuaoceAy9lBS9hNaXpb/QDXH
        NY6rmTF3WZZmzQ9PYAMvqWkvZcVjSAbvTFWrdah3Db5WssoZG3WYHZbfoY6sxywhh63dSN4xzCz1t
        SJLSJzPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTNaP-0001gC-NE; Fri, 16 Oct 2020 11:07:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 978F03011E6;
        Fri, 16 Oct 2020 13:07:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A2F622E98D29; Fri, 16 Oct 2020 13:07:47 +0200 (CEST)
Date:   Fri, 16 Oct 2020 13:07:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     ira.weiny@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 5/9] x86/pks: Add PKS kernel API
Message-ID: <20201016110747.GM2611@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009194258.3207172-6-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 12:42:54PM -0700, ira.weiny@intel.com wrote:
> +static inline void pks_update_protection(int pkey, unsigned long protection)
> +{
> +	current->thread.saved_pkrs = update_pkey_val(current->thread.saved_pkrs,
> +						     pkey, protection);
> +	preempt_disable();
> +	write_pkrs(current->thread.saved_pkrs);
> +	preempt_enable();
> +}

write_pkrs() already disables preemption itself. Wrapping it in yet
another layer is useless.
