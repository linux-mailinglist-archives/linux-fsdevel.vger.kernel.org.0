Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F766B2090
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCIJsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCIJrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:47:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D0CD13E1;
        Thu,  9 Mar 2023 01:47:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B08A221AA7;
        Thu,  9 Mar 2023 09:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678355266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfyXvrHWZozVXtRW0kcNSJ66/sHe/spEA4DDBYt+QOg=;
        b=pMLfsmabn9VFam7HtxAw/YV2w/Qw9WzeVtGGvxnUxmy9E2KYf4oPXDucX+sqaQqA8Inztj
        Q+KwuCIGTmH+BRqKOzNP/cfUs3nO83nt79EwBnQOYAmvwudRwQYNJ8j2BRG1+s8KKCxKrq
        3hzjopitpuhjTk7bqAsj2EwQmuGYaNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678355266;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfyXvrHWZozVXtRW0kcNSJ66/sHe/spEA4DDBYt+QOg=;
        b=Ep2QN6M/Uyuq1BU6aBkDHZF3C4YJCVLDAbouu6f/cjWapkjZOZjzIb1u7HqnpRZzgNIPkr
        R6l73cuSfXIBkhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 858941391B;
        Thu,  9 Mar 2023 09:47:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FbowH0KrCWTKGAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 09:47:46 +0000
Message-ID: <17e2a143-37eb-fb4e-d8a9-2d6dc20f9499@suse.cz>
Date:   Thu, 9 Mar 2023 10:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3 1/2] mm: compaction: move compact_memory sysctl to its
 own file
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, mcgrof@kernel.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        chi.minghao@zte.com.cn
References: <202303091144483856804@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202303091144483856804@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/9/23 04:44, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The compact_memory is part of compaction, move it to its own file.
> 
> Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  kernel/sysctl.c |  7 -------
>  mm/compaction.c | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index c14552a662ae..f574f9985df4 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2190,13 +2190,6 @@ static struct ctl_table vm_table[] = {
>  		.extra2		= SYSCTL_FOUR,
>  	},
>  #ifdef CONFIG_COMPACTION
> -	{
> -		.procname	= "compact_memory",
> -		.data		= NULL,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0200,
> -		.proc_handler	= sysctl_compaction_handler,
> -	},
>  	{
>  		.procname	= "compaction_proactiveness",
>  		.data		= &sysctl_compaction_proactiveness,

There's also this one, and two more, please move all of them at once?

> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5a9501e0ae01..acbda28c11f4 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2763,6 +2763,18 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
>  	return 0;
>  }
> 
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table vm_compact_memory[] = {
> +	{
> +		.procname	= "compact_memory",
> +		.data		= NULL,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0200,
> +		.proc_handler	= sysctl_compaction_handler,
> +	},
> +	{ }
> +};
> +#endif
>  /*
>   * This is the entry point for compacting all nodes via
>   * /proc/sys/vm/compact_memory
> @@ -3078,6 +3090,9 @@ static int __init kcompactd_init(void)
> 
>  	for_each_node_state(nid, N_MEMORY)
>  		kcompactd_run(nid);
> +#ifdef CONFIG_SYSCTL
> +	register_sysctl_init("vm", vm_compact_memory);
> +#endif
>  	return 0;
>  }
>  subsys_initcall(kcompactd_init)

