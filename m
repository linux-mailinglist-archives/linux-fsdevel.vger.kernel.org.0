Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9802223876
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 11:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgGQJeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 05:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:34:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE234C061755;
        Fri, 17 Jul 2020 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G+DDgxlCayqTqkbq04dhgvzaNPWJG1ftzlKeUp8ZiFs=; b=J5mK0s4tYmqK6uzf1Ef8cazS/R
        to9O6JMHWxqFx/Q73rJAgfpYCwgTaJ2p4J5jxdEO1zUSL7Q4VWYsXvU5iJzpQR2ZqKENNkHA9EXJr
        ftW+mfAAxwQ0HjEBs1RO0M9ljr04qNOR8yuXhaTdKDLmU0XpO0pwG7bwgBFNDuapJ5HJ7u1Mkd+pS
        cs/sgBSDcF/Dyb1pJETDT1yOY35LS/DK7+hqF+OFHaCvScr8WU5GtLwxRBallJ4KReWd7/F5srgru
        lKtFmrRk7I9GXt8BOAWYoRmFymx51TOWhwZyWD7BZYyNmj+oPmp2nqUHzPk+UataRPkG6PLrUCiUk
        ljYZR/SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwMkl-00005B-TB; Fri, 17 Jul 2020 09:34:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C058C300130;
        Fri, 17 Jul 2020 11:34:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B322929CF6F55; Fri, 17 Jul 2020 11:34:01 +0200 (CEST)
Date:   Fri, 17 Jul 2020 11:34:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     ira.weiny@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200717093401.GG10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-18-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> +/* Define as macros to prevent conflict of inline and noinstr */
> +#define idt_save_pkrs(state)
> +#define idt_restore_pkrs(state)

Use __always_inline
