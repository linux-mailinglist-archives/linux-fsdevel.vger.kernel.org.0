Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565D473A38A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 16:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjFVOsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjFVOsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:48:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66410C2;
        Thu, 22 Jun 2023 07:48:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 22955229C0;
        Thu, 22 Jun 2023 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687445279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0hFI3xJ2OGZHWhdLSxnOFvnT5Y+IP+BBRNQel7RyVs=;
        b=YraQJudJxxlhLJeEEEMxIUpfKYnVAv60cpmpHUQTGUBUh8t+ZXVmLjxm9M+1UGDbzHnQsz
        y6MEklPR6hPtAV8L33jHrD9qnGqvcBlma7u4mxdi/4lNztRux4EuDbVLobNoZf1RBa/v9Z
        PHfZlgjn/oBKddDSwkaKW1hcpThgEsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687445279;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0hFI3xJ2OGZHWhdLSxnOFvnT5Y+IP+BBRNQel7RyVs=;
        b=6XBRPNh3BjOoRZ1UijrujZWnxKxTKGitdF/zIOBj8hh8OwgFWdOjIPj2xpz1ePgJ9tQjeA
        VaJVHD8gCvpB4lBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA77013905;
        Thu, 22 Jun 2023 14:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id awUvLB5flGSsIgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 22 Jun 2023 14:47:58 +0000
Message-ID: <b04a0191-fa27-f8dc-440c-ec363d9c0636@suse.cz>
Date:   Thu, 22 Jun 2023 16:47:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/29] mm: shrinker: add shrinker::private_data field
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, roman.gushchin@linux.dev,
        djwong@kernel.org, brauner@kernel.org, paulmck@kernel.org,
        tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-2-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230622085335.77010-2-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/23 10:53, Qi Zheng wrote:
> To prepare for the dynamic allocation of shrinker instances
> embedded in other structures, add a private_data field to
> struct shrinker, so that we can use shrinker::private_data
> to record and get the original embedded structure.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

I would fold this to 02/29, less churn.

> ---
>  include/linux/shrinker.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 224293b2dd06..43e6fcabbf51 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -70,6 +70,8 @@ struct shrinker {
>  	int seeks;	/* seeks to recreate an obj */
>  	unsigned flags;
>  
> +	void *private_data;
> +
>  	/* These are for internal use */
>  	struct list_head list;
>  #ifdef CONFIG_MEMCG

