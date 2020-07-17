Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF7822376F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgGQIzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQIy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:54:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB95DC061755;
        Fri, 17 Jul 2020 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aEr7cpiEkCxbEVwXSRfLp3Ytk5hTAgwAHhMYmtgWkp8=; b=XTp6bn8FEKwlnyQgkHyasqtfQs
        fFYXMAUIiMSk8ZvOhG343GjKyPZe9SzrBqo4dgVstwgjT/qqnBnojwBCg02q+0+oaf4CtVI9jrQ03
        ONB24bL/N5z3WjOc/fHRXLiv5pluGJgrS96d7OVkA8awqCpQdsFU7l6f1TDqUW+wjR9oMMFFmdtJn
        VzUhKVeV4zqZEVhYbJxkhKgUC4lOzWSbPL46WpppaNrJaSpNv9qbChKd0nKPB+YDqPSa0c4DPcASR
        deR1T0ijZzeJx31cEvj91bKq7KSnx5u0W411DK6OS3PyVW3svSma5utxYBHXipY7w2w6E5oKjTaT5
        O7+5x+pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwM8j-0002lD-9h; Fri, 17 Jul 2020 08:54:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79D35304D58;
        Fri, 17 Jul 2020 10:54:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5001929CF6F79; Fri, 17 Jul 2020 10:54:42 +0200 (CEST)
Date:   Fri, 17 Jul 2020 10:54:42 +0200
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
Subject: Re: [PATCH RFC V2 02/17] x86/fpu: Refactor
 arch_set_user_pkey_access() for PKS support
Message-ID: <20200717085442.GX10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-3-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:20:41AM -0700, ira.weiny@intel.com wrote:
> +/*
> + * Get a new pkey register value from the user values specified.
> + *
> + * Kernel users use the same flags as user space:
> + *     PKEY_DISABLE_ACCESS
> + *     PKEY_DISABLE_WRITE
> + */
> +u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val)
> +{
> +	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
> +	u32 new_pkr_bits = 0;
> +
> +	/* Set the bits we need in the register:  */
> +	if (init_val & PKEY_DISABLE_ACCESS)
> +		new_pkr_bits |= PKR_AD_BIT;
> +	if (init_val & PKEY_DISABLE_WRITE)
> +		new_pkr_bits |= PKR_WD_BIT;
> +
> +	/* Shift the bits in to the correct place: */
> +	new_pkr_bits <<= pkey_shift;
> +
> +	/* Mask off any old bits in place: */
> +	old_pkr &= ~((PKR_AD_BIT | PKR_WD_BIT) << pkey_shift);
> +
> +	/* Return the old part along with the new part: */
> +	return old_pkr | new_pkr_bits;
> +}

This is unbelievable junk...

How about something like:

u32 update_pkey_reg(u32 pk_reg, int pkey, unsigned int flags)
{
	int pkey_shift = pkey * PKR_BITS_PER_PKEY;

	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);

	if (flags & PKEY_DISABLE_ACCESS)
		pk_reg |= PKR_AD_BIT << pkey_shift;
	if (flags & PKEY_DISABLE_WRITE)
		pk_reg |= PKR_WD_BIT << pkey_shift;

	return pk_reg;
}

Then we at least have a little clue wtf the thing does.. Yes I started
with a rename and then got annoyed at the implementation too.
