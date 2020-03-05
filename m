Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2D817A11C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 09:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCEISu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 03:18:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCEISu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3m703ypRjAtYhbKTkAxqNaRn33lkF344lR7igeRi5dw=; b=QeDESQWxblcd1ICzrOjpd4hCUd
        qsEvNamu4phC6ep6Go1fma5VlXhdDamQawtlV0GF1uJ/nY66ALRpwbJquIX4xw+ldXjLejEWIg7YH
        uXcyDaNH7zXvWAmMYuLZRDUOJeeAZGqvTEc0U6f7Zr8W8/wpcDEmip3IXXXupMOacO+KA6/AJxbbe
        VbaB9MadDZ/5IxdnJYyeBdbmY3HmJmUKL/VVl0bcSvl7EUyDm3EY7EYt80tfpwVptOQ1sPdS8Idkf
        QBkBdclOUqOhXgHaRRBGtYB5nc/xE8r/VfTl7NdVhXIuinI1KKF38twaZ4Xp19Y+qNsB4JE2+RpcJ
        oKF9xrMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9liO-0003xf-73; Thu, 05 Mar 2020 08:18:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EBB630066E;
        Thu,  5 Mar 2020 09:16:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F9FE20D3014E; Thu,  5 Mar 2020 09:18:42 +0100 (CET)
Date:   Thu, 5 Mar 2020 09:18:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        walter-zh.wu@mediatek.com, dvyukov@google.com
Subject: Re: mmotm 2020-03-03-22-28 uploaded (warning: objtool:)
Message-ID: <20200305081842.GB2619@hirez.programming.kicks-ass.net>
References: <20200304062843.9yA6NunM5%akpm@linux-foundation.org>
 <cd1c6bd2-3db3-0058-f3b4-36b2221544a0@infradead.org>
 <20200305081717.GT2596@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305081717.GT2596@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 05, 2020 at 09:17:17AM +0100, Peter Zijlstra wrote:
> On Wed, Mar 04, 2020 at 09:34:49AM -0800, Randy Dunlap wrote:

> > mm/kasan/common.o: warning: objtool: kasan_report()+0x13: call to report_enabled() with UACCESS enabled
> 
> I used next/master instead, and found the below broken commit
> responsible for this.

> @@ -634,12 +637,20 @@ void kasan_free_shadow(const struct vm_struct *vm)
>  #endif
>  
>  extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
> +extern bool report_enabled(void);
>  
> -void kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> +bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
>  {
> -	unsigned long flags = user_access_save();
> +	unsigned long flags;
> +
> +	if (likely(!report_enabled()))
> +		return false;

This adds an explicit call before the user_access_save() and that is a
straight on bug.

> +
> +	flags = user_access_save();
>  	__kasan_report(addr, size, is_write, ip);
>  	user_access_restore(flags);
> +
> +	return true;
>  }
