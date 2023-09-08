Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7EB798222
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 08:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjIHGON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 02:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjIHGOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:14:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F61BD9;
        Thu,  7 Sep 2023 23:14:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B13221F45A;
        Fri,  8 Sep 2023 06:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694153646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u70NF1V9pWl9eEz7YZwVeuG+ejy85zfIYBi8ygYJwcs=;
        b=DfeVirnZxhbQk1vAmjPAszH9kgnjQ3mOjdsW6PQxPQoqn25ABy9S9M94hBjvfqWlB1Rcot
        OhTa3zhpxuizP08v7mUneOy36Jcv03CCEqTfdAUUWJn/+w4m3DUWlfxNC+Gd83kvXJfyDK
        evrDTPIBagGq4EXSJ3pJmeU15gkkenU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694153646;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u70NF1V9pWl9eEz7YZwVeuG+ejy85zfIYBi8ygYJwcs=;
        b=8pVjwALs0VCba9DB+/tcyO7UMWlunbPcm56DD/pKbGKFHTDC57S/iVM0F+Qvf6MyKkqZp2
        msgmNvwoPd7uHgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37819131FD;
        Fri,  8 Sep 2023 06:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CKh6DK67+mSabAAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 08 Sep 2023 06:14:06 +0000
Message-ID: <ee307498-7d15-48e0-9f9f-518c928e8ebc@suse.de>
Date:   Fri, 8 Sep 2023 08:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/12] dm: Enable copy offload for dm-linear target
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164416epcas5p307df0f4ab0a6a6a670fb50f6a8420a2a@epcas5p3.samsung.com>
 <20230906163844.18754-11-nj.shetty@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-11-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/23 18:38, Nitesh Shetty wrote:
> Setting copy_offload_supported flag to enable offload.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>   drivers/md/dm-linear.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index f4448d520ee9..1d1ee30bbefb 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>   	ti->num_discard_bios = 1;
>   	ti->num_secure_erase_bios = 1;
>   	ti->num_write_zeroes_bios = 1;
> +	ti->copy_offload_supported = 1;
>   	ti->private = lc;
>   	return 0;
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

