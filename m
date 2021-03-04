Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA032D14B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbhCDK6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:58:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:53284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239108AbhCDK6S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:58:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4E35AD21;
        Thu,  4 Mar 2021 10:57:36 +0000 (UTC)
Subject: Re: [PATCH v2] mm/compaction: remove unused variable
 sysctl_compact_memory
To:     Pintu Kumar <pintu@codeaurora.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, iamjoonsoo.kim@lge.com,
        sh_def@163.com, mateusznosek0@gmail.com, bhe@redhat.com,
        nigupta@nvidia.com, yzaikin@google.com, keescook@chromium.org,
        mcgrof@kernel.org, mgorman@techsingularity.net
Cc:     pintu.ping@gmail.com
References: <c99eb67f67e4e24b4df1a78a583837b1@codeaurora.org>
 <1614852224-14671-1-git-send-email-pintu@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9df94aca-7121-5d7a-8f92-890d8d5e8223@suse.cz>
Date:   Thu, 4 Mar 2021 11:57:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614852224-14671-1-git-send-email-pintu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/21 11:03 AM, Pintu Kumar wrote:
> The sysctl_compact_memory is mostly unused in mm/compaction.c
> It just acts as a place holder for sysctl to store .data.
> 
> But the .data itself is not needed here.
> So we can get ride of this variable completely and make .data as NULL.
> This will also eliminate the extern declaration from header file.
> No functionality is broken or changed this way.
> 
> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
> Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> v2: completely get rid of this variable and set .data to NULL
>     Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> 
>  include/linux/compaction.h | 1 -
>  kernel/sysctl.c            | 2 +-
>  mm/compaction.c            | 3 ---
>  3 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index ed4070e..4221888 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -81,7 +81,6 @@ static inline unsigned long compact_gap(unsigned int order)
>  }
>  
>  #ifdef CONFIG_COMPACTION
> -extern int sysctl_compact_memory;
>  extern unsigned int sysctl_compaction_proactiveness;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index c9fbdd8..07ef240 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2856,7 +2856,7 @@ static struct ctl_table vm_table[] = {
>  #ifdef CONFIG_COMPACTION
>  	{
>  		.procname	= "compact_memory",
> -		.data		= &sysctl_compact_memory,
> +		.data		= NULL,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0200,
>  		.proc_handler	= sysctl_compaction_handler,
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 190ccda..ede2886 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2650,9 +2650,6 @@ static void compact_nodes(void)
>  		compact_node(nid);
>  }
>  
> -/* The written value is actually unused, all memory is compacted */
> -int sysctl_compact_memory;
> -
>  /*
>   * Tunable for proactive compaction. It determines how
>   * aggressively the kernel should compact memory in the
> 

