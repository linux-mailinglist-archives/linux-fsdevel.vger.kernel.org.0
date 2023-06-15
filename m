Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB01730FF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjFOG47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjFOG4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:56:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03875189;
        Wed, 14 Jun 2023 23:56:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AEA152237E;
        Thu, 15 Jun 2023 06:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686812205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkJYgCra4jVLJ32gsb9X2TbMDcgRHhpos8XQdf9PsE4=;
        b=mlABUDve92NN9L83exdpMUL7+L9IIhR8s2SqHD4pWS7+VM5AC+0VFuNje88SgG57tqvBzT
        kwrv/fOQ2bkFiEk4kzQ64AwHjDeex2ErwveYPm6cbftNCJRo4rMfSQU122W0DoER/rfxPS
        mOPv4qgBK4r9nldh8qZYVUDTQdTp9ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686812205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkJYgCra4jVLJ32gsb9X2TbMDcgRHhpos8XQdf9PsE4=;
        b=RP2wBHkG43ZK/nVYpcfYl6fMMcsWO3EDhxae2fSIIKYdnjAcUZPqAPFsAwvFoWhDyFHLzj
        Tv7FctC9drZYjYAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 834C313467;
        Thu, 15 Jun 2023 06:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nLxeHS22imTMfgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 15 Jun 2023 06:56:45 +0000
Message-ID: <509a8f54-78e1-7776-cae3-e0ecbdbb25ba@suse.de>
Date:   Thu, 15 Jun 2023 08:56:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/11] md-bitmap: initialize variables at declaration time
 in md_bitmap_file_unmap
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230615064840.629492-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/23 08:48, Christoph Hellwig wrote:
> Just a small tidyup to prepare for bigger changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/md-bitmap.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index d8469720fac23f..0b2d8933cbc75e 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -842,14 +842,10 @@ static int md_bitmap_storage_alloc(struct bitmap_storage *store,
>   
>   static void md_bitmap_file_unmap(struct bitmap_storage *store)
>   {
> -	struct page **map, *sb_page;
> -	int pages;
> -	struct file *file;
> -
> -	file = store->file;
> -	map = store->filemap;
> -	pages = store->file_pages;
> -	sb_page = store->sb_page;
> +	struct file *file = store->file;
> +	struct page *sb_page = store->sb_page;
> +	struct page **map = store->filemap;
> +	int pages = store->file_pages;
>   
>   	while (pages--)
>   		if (map[pages] != sb_page) /* 0 is sb_page, release it below */
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

