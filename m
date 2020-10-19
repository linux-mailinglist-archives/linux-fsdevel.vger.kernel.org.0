Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE932924B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgJSJhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 05:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgJSJhl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:37:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C6C0613CE;
        Mon, 19 Oct 2020 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O3B5SDSSGOQ/+MQUdt0Hy/pyKJ8BUU2Uw0eRUC0gQJw=; b=UjWOH0rqHpfO2evvAot8XfZPhm
        Ujz8nN5NXFhX2X4ST7K3yr0FRVocJcnYRDv/x7ri2cofoF0tNd4LH43/uNrRKlRuD7TzTxbBiCxfy
        f08AUp6A/Do8cyTspB4hlKZPrmm2mETomhSipdZAEa6fN7de/Z1evQijJAVE/MGG/DxVM2iU4Qn1q
        FUGEOKLtigWd+T+4WYYGb9bKOVXkDEghzmKrV64OZSbp3a8dondpd2YaqnxT8BjrOR+snVk2sP+AP
        w4nUUDdb7ykKA7E8PI1XyPVgSG1NlxEHDdKwSNLo4JS+pBVzA5E8S9e3uLAZUr0QXqTZzSQjS9Nvy
        WFDYp1rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kURbQ-0003ky-22; Mon, 19 Oct 2020 09:37:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B242E3012C3;
        Mon, 19 Oct 2020 11:37:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A127821447780; Mon, 19 Oct 2020 11:37:14 +0200 (CEST)
Date:   Mon, 19 Oct 2020 11:37:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201019093714.GI2628@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
 <20201016111226.GN2611@hirez.programming.kicks-ass.net>
 <20201017051410.GW2046448@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017051410.GW2046448@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 10:14:10PM -0700, Ira Weiny wrote:
> > so it either needs to
> > explicitly do so, or have an assertion that preemption is indeed
> > disabled.
> 
> However, I don't think I understand clearly.  Doesn't [get|put]_cpu_ptr()
> handle the preempt_disable() for us? 

It does.

> Is it not sufficient to rely on that?

It is.

> Dave's comment seems to be the opposite where we need to eliminate preempt
> disable before calling write_pkrs().
> 
> FWIW I think I'm mistaken in my response to Dave regarding the
> preempt_disable() in pks_update_protection().

Dave's concern is that we're calling with with preemption already
disabled so disabling it again is superfluous.
