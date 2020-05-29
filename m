Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29521E8427
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 18:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgE2Q5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 12:57:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33946 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Q5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 12:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qvd2kL2qR8kYZV6dL5sMKSK5ISQvBrt0W/9AThJt2AM=; b=pT6m47epRbNie5A2cBpR+yhH6f
        xir8/PrXyRp8sqIRmpvbzc0py1g7M35qEGmn+FSNWwMGWC09FYbWyQsLE9PvgzwanOVRcfnEK4ygL
        iT8WIdPAQnBeGjSbjuAmCl+48AYJZ2+drW3eSAgIt0IRnnCgjNt+qMSE9ldmgGvu9nYhyKUgzsCit
        AEPs8bwJSzuGVfVTh6d6lVJMWq/CxNtgszAyz1qki53bXXcBUx+ZVNX6CeT8uXWuTxRHB9+7I8QUG
        dtRIaBDVinVNkrbG1Wgv6pcC/qrM3v4ByOloX57gHEYmw62EySl90A0Cc7T8HeZB8boFHdFsZx3zQ
        sWl0P5oA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeiH9-0001gH-7c; Fri, 29 May 2020 16:54:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75A8D301A80;
        Fri, 29 May 2020 18:54:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E64EE2BB51403; Fri, 29 May 2020 18:54:19 +0200 (CEST)
Date:   Fri, 29 May 2020 18:54:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200529165419.GF706460@hirez.programming.kicks-ass.net>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
 <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
 <20200529143556.GE706478@hirez.programming.kicks-ass.net>
 <20200529145325.GB706518@hirez.programming.kicks-ass.net>
 <20200529153336.GC706518@hirez.programming.kicks-ass.net>
 <20200529160514.cyaytn33thphb3tz@treble>
 <20200529161253.GD706460@hirez.programming.kicks-ass.net>
 <20200529165011.o7vvhn4wcj6zjxux@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529165011.o7vvhn4wcj6zjxux@treble>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 11:50:11AM -0500, Josh Poimboeuf wrote:
> The nested likelys seem like overkill anyway -- user_access_begin() is
> __always_inline and it already has unlikely(), which should be
> propagated.
> 
> So just remove the outer likelys?

That fixes it. Ack!

> diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
> index a12b8629206d..ee63d7576fd2 100644
> --- a/arch/x86/lib/csum-wrappers_64.c
> +++ b/arch/x86/lib/csum-wrappers_64.c
> @@ -27,7 +27,7 @@ csum_and_copy_from_user(const void __user *src, void *dst,
>  	might_sleep();
>  	*errp = 0;
>  
> -	if (!likely(user_access_begin(src, len)))
> +	if (!user_access_begin(src, len))
>  		goto out_err;
>  
>  	/*
> @@ -89,7 +89,7 @@ csum_and_copy_to_user(const void *src, void __user *dst,
>  
>  	might_sleep();
>  
> -	if (unlikely(!user_access_begin(dst, len))) {
> +	if (!user_access_begin(dst, len)) {
>  		*errp = -EFAULT;
>  		return 0;
>  	}
> 
