Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF24A2237E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgGQJLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:11:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3613C061755;
        Fri, 17 Jul 2020 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kCkqhMS2HaIZBdmyOa4Dix+KbCHHbKCWd/IyAKtmGXE=; b=nPfy4DFa35G3D2G1doZqmNHJwJ
        tUvTnThDxFrBli6t//3AlvL1OnexMAZHeX1xiNzjr7G4kWV/83q5na4v+kzWSPt6SkB15lQSbiG++
        u3ePf4caogtbejjt0TcqywoTD4/87/lAoxutMbavQatxO3/eUSptN77p7dmKFd2BjcVTUsn/OVUiE
        GXYmZW/Uj9v4UBgHV8wFKtZzxnWbVA4U4doHtI1ZM2Te4InNbDrPNolAHWhlbKtJFMZKGf1Cte4ea
        Q6twclkcHKVfnlFNbCUIiG06gJs+JdpL9nleh3Iw2Xldn2Yo/qwQXz86EiJMv9q8ViUgqW8O7a+0N
        ynkrp8CA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwMON-0008S4-94; Fri, 17 Jul 2020 09:10:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7742305C22;
        Fri, 17 Jul 2020 11:10:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C15329CF6F4E; Fri, 17 Jul 2020 11:10:53 +0200 (CEST)
Date:   Fri, 17 Jul 2020 11:10:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     ira.weiny@intel.com
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
Message-ID: <20200717091053.GZ10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-13-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-13-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:20:51AM -0700, ira.weiny@intel.com wrote:
> +static pgprot_t dev_protection_enable_get(struct dev_pagemap *pgmap, pgprot_t prot)
> +{
> +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> +		pgprotval_t val = pgprot_val(prot);
> +
> +		static_branch_inc(&dev_protection_static_key);
> +		prot = __pgprot(val | _PAGE_PKEY(dev_page_pkey));
> +	}
> +	return prot;
> +}

Every other pgprot modifying function is called pgprot_*(), although I
suppose we have the exceptions phys_mem_access_prot() and dma_pgprot().

How about we call this one devm_pgprot() ?
