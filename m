Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC9F6B0405
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 11:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCHKXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 05:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCHKXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:23:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED8A7299;
        Wed,  8 Mar 2023 02:23:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F11F1FE3C;
        Wed,  8 Mar 2023 10:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678271006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oyXynkh60CJXXg36k6qmlCFCaHiUgRLQaqjGCWpxkY=;
        b=HqA9T/snvtOWPVahyw1DoiTJTKFTw3CDK52mCgXmz75QqNcX1Ns9VVKHdpoHlSrEma//fP
        HBmu3FKw5D8Ef/CXYo6Y1+Jc6CxEOvxyp4uAZ/Uo5hWYPRCSIPnukfPqkwLoW4rIXVhC/k
        3p9Iy/Ms0rR/7ypXZSNeZ8PLLxyn4Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678271006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oyXynkh60CJXXg36k6qmlCFCaHiUgRLQaqjGCWpxkY=;
        b=iVsYRuHoa7MmGUtveN83sOYKjJn7La9KrbP/OXybajtI4R/BbNU5VtR6nU5EcmNafjoerR
        LH1qaK28HFbcqcAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0E391391B;
        Wed,  8 Mar 2023 10:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /rLiNR1iCGS1WgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Mar 2023 10:23:25 +0000
Message-ID: <c48666f2-8226-3678-a744-6d613288f188@suse.cz>
Date:   Wed, 8 Mar 2023 11:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 2/2] mm: compaction: Limit the value of interface
 compact_memory
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, mcgrof@kernel.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <202303061405242788477@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202303061405242788477@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/6/23 07:05, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Available only when CONFIG_COMPACTION is set. When 1 is written to
> the file, all zones are compacted such that free memory is available
> in contiguous blocks where possible.
> But echo others-parameter > compact_memory, this function will be
> triggered by writing parameters to the interface.
> 
> Applied this patch,
> sh/$ echo 1.1 > /proc/sys/vm/compact_memory
> sh/$ sh: write error: Invalid argument
> The start and end time of printing triggering compact_memory.
> 
> Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  mm/compaction.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5a9501e0ae01..2c9ecc4b9d23 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2763,6 +2763,8 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
>  	return 0;
>  }
> 
> +/* The written value is actually unused, all memory is compacted */
> +int sysctl_compact_memory;
>  /*
>   * This is the entry point for compacting all nodes via
>   * /proc/sys/vm/compact_memory
> @@ -2770,8 +2772,16 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
>  int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos)
>  {
> -	if (write)
> +	int ret;
> +
> +	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
> +	if (ret)
> +		return ret;
> +	if (write) {
> +		pr_info("compact_nodes start\n");
>  		compact_nodes();
> +		pr_info("compact_nodes end\n");

I'm not sure we want to start spamming the dmesg. This would make sense
if we wanted to deprecate the sysctl and start hunting for remaining
callers to be fixed. Otherwise ftrace can be used to capture e.g. the time.

> +	}
> 
>  	return 0;
>  }
