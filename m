Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A3F6B03F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 11:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCHKVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 05:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCHKVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:21:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B73B6D36;
        Wed,  8 Mar 2023 02:21:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 291861FE35;
        Wed,  8 Mar 2023 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678270877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZa0zpAJCeh9dzklwAiQIDL273b6n4qNFXa7CBwrKNI=;
        b=P089fFIeokxOaKc2AugIP592HPZ9E/nYJdJaAkitiG8p5Ny8rI79+EnhcDQCGz3R80NA4u
        4p8N9UiD2Nh70cxcV9TGbYAbKGjOaZWjw5frB5ihLE6ZSznFoOb9m8XqiXebpCeXd2Q7Vv
        LiNy0WDoavyfWfCdREY9NwlnuS0csCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678270877;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZa0zpAJCeh9dzklwAiQIDL273b6n4qNFXa7CBwrKNI=;
        b=iFNnLRikDeqTC1JTbHAm9Z0Vf4a2PwibCfkX9pPQ49UiGyZR/4OD43yKaCgRxz2JlglRCI
        DNjm22/74WXOySDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E834F1391B;
        Wed,  8 Mar 2023 10:21:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1LqXN5xhCGSFWQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Mar 2023 10:21:16 +0000
Message-ID: <83344b3d-1de1-f3c2-913c-a8c54ce7a99f@suse.cz>
Date:   Wed, 8 Mar 2023 11:21:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 1/2] sysctl: Limit the value of interface
 compact_memory
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, mcgrof@kernel.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <202303061407332798543@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202303061407332798543@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/6/23 07:07, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> In Documentation/admin-guide/sysctl/vm.rst:109 say: when 1 is written
> to the file, all zones are compacted such that free memory is available
> in contiguous blocks where possible.
> So limit the value of interface compact_memory to 1.
> 
> Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/

I don't think the split to two patches you did, achieves Luis' request.

> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> ---
>  include/linux/compaction.h | 1 +
>  kernel/sysctl.c            | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 52a9ff65faee..caa24e33eeb1 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -81,6 +81,7 @@ static inline unsigned long compact_gap(unsigned int order)
>  }
> 
>  #ifdef CONFIG_COMPACTION
> +extern int sysctl_compact_memory;
>  extern unsigned int sysctl_compaction_proactiveness;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index c14552a662ae..67f70952f71a 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2192,10 +2192,12 @@ static struct ctl_table vm_table[] = {
>  #ifdef CONFIG_COMPACTION
>  	{
>  		.procname	= "compact_memory",
> -		.data		= NULL,
> +		.data		= &sysctl_compact_memory,

I doubt this compiles/links without patch 2, as there's no definition
until patch 2.

>  		.maxlen		= sizeof(int),
>  		.mode		= 0200,
>  		.proc_handler	= sysctl_compaction_handler,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_ONE,
>  	},
>  	{
>  		.procname	= "compaction_proactiveness",

IIUC his request was to move the compaction entries out of sysctl.c?

