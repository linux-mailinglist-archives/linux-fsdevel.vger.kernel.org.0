Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85D52903C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395345AbgJPLGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 07:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395027AbgJPLGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 07:06:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E6DC061755;
        Fri, 16 Oct 2020 04:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+HxT6lf8z2s6GX+yM9g2TG2m/mbY0AbXizuVmoeBCSI=; b=capeaNLUb3LFnGa/brHo4bIFTQ
        QJQCo9AMK4SnBeVk0sX4k2XI9kRKM66EHK7p878iLEgmTG9DTgeNRK9CW4C5ZvWitr99zV5WD+9Gw
        ytFSGteXDgy6qxNtniRa8OZBSn/DblzJ4SG5CS1qjKzxSzcBousHhBruuLTZZ5Z000k0dorzxRThr
        uq4wcigwlAEJEZT89cgqbp0Ro3TJz09ioe2044DK7ZMHEdOFsYAWkflsH0qX8g6kkCktfa88f/Ccn
        tq4jiLDAyn/dzjhhXdB4rtlSWS2yb5XJnLgGbujgvpvpfk0PA7w4f6G8Eqo5wABoMVBNPnvhIwiCO
        o26+0dyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTNZF-0002eY-9X; Fri, 16 Oct 2020 11:06:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76ACD30015A;
        Fri, 16 Oct 2020 13:06:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CC0B203C7039; Fri, 16 Oct 2020 13:06:36 +0200 (CEST)
Date:   Fri, 16 Oct 2020 13:06:36 +0200
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
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201016110636.GL2611@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009194258.3207172-5-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 12:42:53PM -0700, ira.weiny@intel.com wrote:

> @@ -644,6 +663,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  
>  	if ((tifp ^ tifn) & _TIF_SLD)
>  		switch_to_sld(tifn);
> +
> +	pks_sched_in();
>  }
>  

You seem to have lost the comment proposed here:

  https://lkml.kernel.org/r/20200717083140.GW10769@hirez.programming.kicks-ass.net

It is useful and important information that the wrmsr normally doesn't
happen.

> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index 3cf8f775f36d..30f65dd3d0c5 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -229,3 +229,31 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
>  
>  	return pk_reg;
>  }
> +
> +DEFINE_PER_CPU(u32, pkrs_cache);
> +
> +/**
> + * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
> + * serializing but still maintains ordering properties similar to WRPKRU.
> + * The current SDM section on PKRS needs updating but should be the same as
> + * that of WRPKRU.  So to quote from the WRPKRU text:
> + *
> + * 	WRPKRU will never execute transiently. Memory accesses
> + * 	affected by PKRU register will not execute (even transiently)
> + * 	until all prior executions of WRPKRU have completed execution
> + * 	and updated the PKRU register.

(whitespace damage; space followed by tabstop)

> + */
> +void write_pkrs(u32 new_pkrs)
> +{
> +	u32 *pkrs;
> +
> +	if (!static_cpu_has(X86_FEATURE_PKS))
> +		return;
> +
> +	pkrs = get_cpu_ptr(&pkrs_cache);
> +	if (*pkrs != new_pkrs) {
> +		*pkrs = new_pkrs;
> +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
> +	}
> +	put_cpu_ptr(pkrs);
> +}

looks familiar that... :-)
