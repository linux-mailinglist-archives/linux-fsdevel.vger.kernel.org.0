Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9121EB99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 10:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGNIlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 04:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNIlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:41:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1297C061755;
        Tue, 14 Jul 2020 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7EYMAPkg0epsaMUyGWJdgDKUvk+AqT0tO9qkB/mcaeo=; b=wfr+9nwGB+CdzxX9LElESkKpwK
        5k6vYKRmT9DWltVSjWYMZnlQ/I7lRShp5WfUSxuESbkpptjM1Zh51DEeu3IE2h70muDG6uMcqNOJs
        tbUiCnwFTFua/844sZg8NY3KOWNMYBopQOL65ye10DuSJEQrab2Owce2ZJPEvCdclI4nYahvmc+/m
        EAV1vZjgIkz6FI88PB18iJgnXx5oP3SGBVUT0ldkiYGCcd17mQCOx3Ky+cLShm+MxUZWkyYv8ysI/
        pC8MiwAVFKfFJndnElLfvG/DprsK6kP6uqUIpq6f1xjuyLepg4kSLDczlLmAkx+6IjVFOvlyQchuw
        oZXIlvmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvGUl-0006VI-Lv; Tue, 14 Jul 2020 08:40:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8831E305C22;
        Tue, 14 Jul 2020 10:40:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7393128B91072; Tue, 14 Jul 2020 10:40:57 +0200 (CEST)
Date:   Tue, 14 Jul 2020 10:40:57 +0200
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
Subject: Re: [RFC PATCH 11/15] memremap: Add zone device access protection
Message-ID: <20200714084057.GP10769@hirez.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-12-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714070220.3500839-12-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:02:16AM -0700, ira.weiny@intel.com wrote:

> +static pgprot_t dev_protection_enable_get(struct dev_pagemap *pgmap, pgprot_t prot)
> +{
> +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> +		pgprotval_t val = pgprot_val(prot);
> +
> +		mutex_lock(&dev_prot_enable_lock);
> +		dev_protection_enable++;
> +		/* Only enable the static branch 1 time */
> +		if (dev_protection_enable == 1)
> +			static_branch_enable(&dev_protection_static_key);
> +		mutex_unlock(&dev_prot_enable_lock);
> +
> +		prot = __pgprot(val | _PAGE_PKEY(dev_page_pkey));
> +	}
> +	return prot;
> +}
> +
> +static void dev_protection_enable_put(struct dev_pagemap *pgmap)
> +{
> +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> +		mutex_lock(&dev_prot_enable_lock);
> +		dev_protection_enable--;
> +		if (dev_protection_enable == 0)
> +			static_branch_disable(&dev_protection_static_key);
> +		mutex_unlock(&dev_prot_enable_lock);
> +	}
> +}

That's an anti-pattern vs static_keys, I'm thinking you actually want
static_key_slow_{inc,dec}() instead of {enable,disable}().

