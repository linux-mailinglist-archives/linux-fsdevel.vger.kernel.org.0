Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D72237FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgGQJRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 05:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQJRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:17:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9DCC061755;
        Fri, 17 Jul 2020 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pcQ0H1o6p26C2vKLZMF/SJZnMQU+q3kwcSeFrBwvG4U=; b=1GK9EL0Mygx6wkzcHli7MajxZJ
        9bdhJlSKGlg4PMmK23HdyR74DFHwv0hwspiU36sq/NpoEbxvPgpHX+8UyWNxtplg/0VsSXxHCiPB3
        vFRbTtyHpuDavKAh5w7zgL1ghadeqPivAdZCXA0naaJhiCuhyiecFBb+pzLL7zWi9zOvxepXMvaQN
        ntvXivnC5cIE5QyoWA0OpNwPZQrVkbCA07py36E1hxi0uGtUkzP/EmssVu2Q7jz/ZEso4gZGV7W+F
        m5QxMYoo9/iJWWSIgBtc57v9llapUacsJoD8uETqbubjS8m9fifXpugMechsC7FZGC8PNVM2D9NmB
        Pjg04+Jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwMUc-0002bP-4T; Fri, 17 Jul 2020 09:17:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 163AB3003D8;
        Fri, 17 Jul 2020 11:17:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0035129CF6F50; Fri, 17 Jul 2020 11:17:18 +0200 (CEST)
Date:   Fri, 17 Jul 2020 11:17:18 +0200
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
Message-ID: <20200717091718.GA10769@hirez.programming.kicks-ass.net>
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
> +void dev_access_disable(void)
> +{
> +	unsigned long flags;
> +
> +	if (!static_branch_unlikely(&dev_protection_static_key))
> +		return;
> +
> +	local_irq_save(flags);
> +	current->dev_page_access_ref--;
> +	if (current->dev_page_access_ref == 0)

	if (!--current->dev_page_access_ref)

> +		pks_update_protection(dev_page_pkey, PKEY_DISABLE_ACCESS);
> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL_GPL(dev_access_disable);
> +
> +void dev_access_enable(void)
> +{
> +	unsigned long flags;
> +
> +	if (!static_branch_unlikely(&dev_protection_static_key))
> +		return;
> +
> +	local_irq_save(flags);
> +	/* 0 clears the PKEY_DISABLE_ACCESS bit, allowing access */
> +	if (current->dev_page_access_ref == 0)
> +		pks_update_protection(dev_page_pkey, 0);
> +	current->dev_page_access_ref++;

	if (!current->dev_page_access_ref++)

> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL_GPL(dev_access_enable);


Also, you probably want something like:

static __always_inline devm_access_disable(void)
{
	if (static_branch_unlikely(&dev_protection_static_key))
		__devm_access_disable();
}

static __always_inline devm_access_enable(void)
{
	if (static_branch_unlikely(&dev_protection_static_key))
		__devm_access_enable();
}
