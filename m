Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC77C82FC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfHFKgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 06:36:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41643 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732534AbfHFKgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:36:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so37568591pls.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0Wilp6roBIsdQ40Pa0gikkfrKuFSJkj9vHJ430JGZ8=;
        b=yBSWChLqbeoq5PRv1NFDpgqkTe+IWZ0NXp3UXkWOdUFbznL4X5s9a4jX9e7zqwGMsP
         7siDaILd0QUW2OiwTs2TBkA2nguDPr7Gw3/0ZiosrM67X3yu5+zmOU8YxJM9GNeOlYRi
         FWNYZppcftyNVxczw/mmMiQOjJeqjapSl9VBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0Wilp6roBIsdQ40Pa0gikkfrKuFSJkj9vHJ430JGZ8=;
        b=dhqghMyNMhSm76526cRGqt4fGq5DFZzlR6rWOCphKfQYhxiWvaAOX15R7pde+jqxPV
         KDg4ctTf9cNeEg2Z/W0STd0QbQL5HBFy4IrdNTRVdvHLohSM6rL72K3r54KoO1QTYiHP
         nTWcgyjprAvACK/2Uy6Tu6bY3EOZsQTE7smxYJd7kwPsgKa3pFC1YsCT6/yL3jgeyYfA
         /5Xk+ADpkhl4y2L/7dCX8Sy1FTf6qxgwXlYihXM/YfwMaqc/s7XHyOCDQXTISNt19Ur8
         7ekP7Cdk683Jjs6CNElcumvYBGF5HtkAwP5nlqW9HnfemAv1iQ7PUQAUKYJV+9AkD8f2
         616g==
X-Gm-Message-State: APjAAAUCQUrmxmVaNKkzExAq6hplwhZMBbkeuWOmdmqmN8HmQHmH32/a
        mTMrXIy08WMqrs4UKPfyHH0b7g==
X-Google-Smtp-Source: APXvYqxI32lagxLu9cZ/Ui9N0pJztkq18ietG60iUZs8inFhbhnQnPT6tWK0xEvWGoQOr/kBgINWoQ==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr2564494plr.198.1565087790447;
        Tue, 06 Aug 2019 03:36:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j15sm99017998pfe.3.2019.08.06.03.36.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 03:36:29 -0700 (PDT)
Date:   Tue, 6 Aug 2019 06:36:27 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 3/5] [RFC] arm64: Add support for idle bit in swap PTE
Message-ID: <20190806103627.GA218260@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806084203.GJ11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:42:03AM +0200, Michal Hocko wrote:
> On Mon 05-08-19 13:04:49, Joel Fernandes (Google) wrote:
> > This bit will be used by idle page tracking code to correctly identify
> > if a page that was swapped out was idle before it got swapped out.
> > Without this PTE bit, we lose information about if a page is idle or not
> > since the page frame gets unmapped.
> 
> And why do we need that? Why cannot we simply assume all swapped out
> pages to be idle? They were certainly idle enough to be reclaimed,
> right? Or what does idle actualy mean here?

Yes, but other than swapping, in Android a page can be forced to be swapped
out as well using the new hints that Minchan is adding?

Also, even if they were idle enough to be swapped, there is a chance that they
were marked as idle and *accessed* before the swapping. Due to swapping, the
"page was accessed since we last marked it as idle" information is lost. I am
able to verify this.

Idle in this context means the same thing as in page idle tracking terms, the
page was not accessed by userspace since we last marked it as idle (using
/proc/<pid>/page_idle).

thanks,

 - Joel


> > In this patch we reuse PTE_DEVMAP bit since idle page tracking only
> > works on user pages in the LRU. Device pages should not consitute those
> > so it should be unused and safe to use.
> > 
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  arch/arm64/Kconfig                    |  1 +
> >  arch/arm64/include/asm/pgtable-prot.h |  1 +
> >  arch/arm64/include/asm/pgtable.h      | 15 +++++++++++++++
> >  3 files changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 3adcec05b1f6..9d1412c693d7 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -128,6 +128,7 @@ config ARM64
> >  	select HAVE_ARCH_MMAP_RND_BITS
> >  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> >  	select HAVE_ARCH_PREL32_RELOCATIONS
> > +	select HAVE_ARCH_PTE_SWP_PGIDLE
> >  	select HAVE_ARCH_SECCOMP_FILTER
> >  	select HAVE_ARCH_STACKLEAK
> >  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> > diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> > index 92d2e9f28f28..917b15c5d63a 100644
> > --- a/arch/arm64/include/asm/pgtable-prot.h
> > +++ b/arch/arm64/include/asm/pgtable-prot.h
> > @@ -18,6 +18,7 @@
> >  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
> >  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
> >  #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
> > +#define PTE_SWP_PGIDLE		PTE_DEVMAP		 /* for idle page tracking during swapout */
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 3f5461f7b560..558f5ebd81ba 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -212,6 +212,21 @@ static inline pte_t pte_mkdevmap(pte_t pte)
> >  	return set_pte_bit(pte, __pgprot(PTE_DEVMAP));
> >  }
> >  
> > +static inline int pte_swp_page_idle(pte_t pte)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline pte_t pte_swp_mkpage_idle(pte_t pte)
> > +{
> > +	return set_pte_bit(pte, __pgprot(PTE_SWP_PGIDLE));
> > +}
> > +
> > +static inline pte_t pte_swp_clear_page_idle(pte_t pte)
> > +{
> > +	return clear_pte_bit(pte, __pgprot(PTE_SWP_PGIDLE));
> > +}
> > +
> >  static inline void set_pte(pte_t *ptep, pte_t pte)
> >  {
> >  	WRITE_ONCE(*ptep, pte);
> > -- 
> > 2.22.0.770.g0f2c4a37fd-goog
> 
> -- 
> Michal Hocko
> SUSE Labs
