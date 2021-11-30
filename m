Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E589463A0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 16:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhK3PcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 10:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhK3PcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:32:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A495C061574;
        Tue, 30 Nov 2021 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kl4jDrt0lTZq8RUWESr9jq2BAnd24QRKSF504zE02jo=; b=PDeElGOGe02xxIEM4OTY/z1eeE
        UqJah6JaGsMTL9IegoCL/cu1eG9mCexMh+NrtVLBhed22f+XD91RoQDOFkFeeWVicS4p4Kus4Ow1k
        1O5NrIA4i07/Uh+baufG8mhZr2Cr4Y6memj4iL4Iwvw9j3U/BPcTtxU0vbuUHJlV+4cOAxxMFk3d8
        N+Imw5Hcx2uMhmVzSVL7gBSWIfVjbuoLB1xDpEjckFxXHW74+Tnz32aJ2Ds3SVXVJu5ZdPiNIkgva
        FjX/fcyNSYcUctN8YPjNzzSsxhI3vBlPkx5ax+/ZYdrUWdNQNigHm3znOJ2+2NG4R02HCT8jFT7O5
        4cFvN7zw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms53g-005tZl-8x; Tue, 30 Nov 2021 15:28:40 +0000
Date:   Tue, 30 Nov 2021 07:28:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexey Avramov <hakavlad@inbox.lv>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, oleksandr@natalenko.name, kernel@xanmod.org,
        aros@gmx.com, iam@valdikss.org.ru, hakavlad@gmail.com
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
Message-ID: <YaZDKLzWBLdcnok7@bombadil.infradead.org>
References: <20211130201652.2218636d@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130201652.2218636d@mail.inbox.lv>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 08:16:52PM +0900, Alexey Avramov wrote:
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 083be6af2..65fc38756 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3132,6 +3132,27 @@ static struct ctl_table vm_table[] = {
>  	},
>  #endif
>  	{
> +		.procname	= "anon_min_kbytes",
> +		.data		= &sysctl_anon_min_kbytes,
> +		.maxlen		= sizeof(unsigned long),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +	},
> +	{
> +		.procname	= "clean_low_kbytes",
> +		.data		= &sysctl_clean_low_kbytes,
> +		.maxlen		= sizeof(unsigned long),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +	},
> +	{
> +		.procname	= "clean_min_kbytes",
> +		.data		= &sysctl_clean_min_kbytes,
> +		.maxlen		= sizeof(unsigned long),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +	},
> +	{
>  		.procname	= "user_reserve_kbytes",
>  		.data		= &sysctl_user_reserve_kbytes,
>  		.maxlen		= sizeof(sysctl_user_reserve_kbytes),

Please don't clutter this file anymore than what we have with random
sysctls, as otherwise it becomes a pain to deal with merge conficts.
You can use register_sysctl_init("vm", whatever_your_local_table_name)
within the file you are adding your sysctl.

 Luis
