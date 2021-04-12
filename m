Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DFA35CF03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbhDLQ6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 12:58:52 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:35522 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbhDLQ6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:58:03 -0400
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 634EBA2AF72;
        Mon, 12 Apr 2021 18:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1618246662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LdFy/WsqRV13J/Bu3JnHBX56utssyQ/cLHJjiDA2rn8=;
        b=nIE3wXy40y37nIc2Un3HjB7AQJvoP7Qc319exCQqFUEdkwyLzw2pPDCaKy4U121T4Q4Zoh
        YylzeRA+iPNTnNBnlX2vI8p/PpmNum9fp7l6yyX7gXnbUG0abahjpzyb812z9ImBw3oQBQ
        KWqzXh3Nqa8B/g++6JxiFDN2KmpTR/s=
Date:   Mon, 12 Apr 2021 18:57:41 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     chukaiping <chukaiping@baidu.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/compaction:let proactive compaction order configurable
Message-ID: <20210412165741.shqududzlfhge7ff@spock.localdomain>
References: <1618218330-50591-1-git-send-email-chukaiping@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618218330-50591-1-git-send-email-chukaiping@baidu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

On Mon, Apr 12, 2021 at 05:05:30PM +0800, chukaiping wrote:
> Currently the proactive compaction order is fixed to
> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
> normal 4KB memory, but it's too high for the machines with small
> normal memory, for example the machines with most memory configured
> as 1GB hugetlbfs huge pages. In these machines the max order of
> free pages is often below 9, and it's always below 9 even with hard
> compaction. This will lead to proactive compaction be triggered very
> frequently. In these machines we only care about order of 3 or 4.
> This patch export the oder to proc and let it configurable
> by user, and the default value is still COMPACTION_HPAGE_ORDER.
> 
> Signed-off-by: chukaiping <chukaiping@baidu.com>
> ---
>  include/linux/compaction.h |    1 +
>  kernel/sysctl.c            |   10 ++++++++++
>  mm/compaction.c            |    7 ++++---
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index ed4070e..151ccd1 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int order)
>  #ifdef CONFIG_COMPACTION
>  extern int sysctl_compact_memory;
>  extern unsigned int sysctl_compaction_proactiveness;
> +extern unsigned int sysctl_compaction_order;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 62fbd09..277df31 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -114,6 +114,7 @@
>  static int __maybe_unused neg_one = -1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;
> +static int __maybe_unused ten = 10;

^^ does the upper limit have to be hard-coded like this?

>  static unsigned long zero_ul;
>  static unsigned long one_ul = 1;
>  static unsigned long long_max = LONG_MAX;
> @@ -2871,6 +2872,15 @@ int proc_do_static_key(struct ctl_table *table, int write,
>  		.extra2		= &one_hundred,
>  	},
>  	{
> +		.procname       = "compaction_order",
> +		.data           = &sysctl_compaction_order,
> +		.maxlen         = sizeof(sysctl_compaction_order),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1         = SYSCTL_ZERO,

I wonder what happens if this knob is set to 0. Have you tested such a
corner case?

> +		.extra2         = &ten,
> +	},
> +	{
>  		.procname	= "extfrag_threshold",
>  		.data		= &sysctl_extfrag_threshold,
>  		.maxlen		= sizeof(int),
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f447..a192996 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1925,16 +1925,16 @@ static bool kswapd_is_running(pg_data_t *pgdat)
>  
>  /*
>   * A zone's fragmentation score is the external fragmentation wrt to the
> - * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
> + * sysctl_compaction_order. It returns a value in the range [0, 100].
>   */
>  static unsigned int fragmentation_score_zone(struct zone *zone)
>  {
> -	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +	return extfrag_for_order(zone, sysctl_compaction_order);
>  }
>  
>  /*
>   * A weighted zone's fragmentation score is the external fragmentation
> - * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
> + * wrt to the sysctl_compaction_order scaled by the zone's size. It
>   * returns a value in the range [0, 100].
>   *
>   * The scaling factor ensures that proactive compaction focuses on larger
> @@ -2666,6 +2666,7 @@ static void compact_nodes(void)
>   * background. It takes values in the range [0, 100].
>   */
>  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
> +unsigned int __read_mostly sysctl_compaction_order = COMPACTION_HPAGE_ORDER;
>  
>  /*
>   * This is the entry point for compacting all nodes via
> -- 
> 1.7.1
> 

-- 
  Oleksandr Natalenko (post-factum)
