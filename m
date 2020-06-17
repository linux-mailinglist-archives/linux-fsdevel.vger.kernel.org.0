Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBAA1FCC3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFQL0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 07:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgFQL0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:26:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B503C061573;
        Wed, 17 Jun 2020 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dtjVXSqAE8YM+RRRIFGiF9gC6hEximSsEAusu5uKSbc=; b=t5yWxc2mkT8XowXV2ABaUkNqIU
        PZAh5QEr72aW5SwIRnEA/aVR/0HpajvAbuNlh8tV+k8X6W0VoCMd+vH7RptVD3MGItoo1lKI4YJmU
        3lRkk0BmN7iByUFOBFCr3DKyTALGFBuiHigUz3iNVJEkIpfYG98giuFcHguGwGm2FDEOAoXml3pul
        BOohJBgf2Yxhha5dFjDghwNUCdSNEhIkTSHzNmoaFSTOFlOEs5pLhGMjJwBEQ9S6py0Kf9iDGibEe
        neak6g4iy90QLyPpIQxSa1N54yPkz0w7MUjsTCvHAh9G9cThFBkDziuGGMjavYQsnXfq22YOp5bnS
        KOWsOyWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlWCf-0003Iy-Rn; Wed, 17 Jun 2020 11:26:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50B95301A32;
        Wed, 17 Jun 2020 13:26:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 373A0203B4EA5; Wed, 17 Jun 2020 13:26:00 +0200 (CEST)
Date:   Wed, 17 Jun 2020 13:26:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] fs/namespace.c: use spinlock instead of busy loop
Message-ID: <20200617112600.GH2531@hirez.programming.kicks-ass.net>
References: <20200617104058.14902-1-john.ogness@linutronix.de>
 <20200617104058.14902-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617104058.14902-2-john.ogness@linutronix.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:46:58PM +0206, John Ogness wrote:
> @@ -459,17 +469,39 @@ void mnt_drop_write_file(struct file *file)
>  }
>  EXPORT_SYMBOL(mnt_drop_write_file);
>  
> +static void mnt_lock_writers(struct mount *mnt)
> +{
> +#ifdef CONFIG_SMP
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		spin_lock(&per_cpu_ptr(mnt->mnt_pcp,
> +				       cpu)->mnt_writers_lock);
> +	}
> +#else
> +	spin_lock(&mnt->mnt_writers_lock);
> +#endif
> +}
> +
> +static void mnt_unlock_writers(struct mount *mnt)
> +{
> +#ifdef CONFIG_SMP
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		spin_unlock(&per_cpu_ptr(mnt->mnt_pcp,
> +					 cpu)->mnt_writers_lock);
> +	}
> +#else
> +	spin_unlock(&mnt->mnt_writers_lock);
> +#endif
> +}

*groan*.. this is brlock reincarnate :-/ Also broken.


