Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C4651B99C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 10:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbiEEIKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346334AbiEEIKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 04:10:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432613337C;
        Thu,  5 May 2022 01:06:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D6FDE211C3;
        Thu,  5 May 2022 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651738011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZibYFJG5L2p6UoYm18ZdrBgQ/joeqb23OybZbEbxM8=;
        b=EueUyxcMRVtde2gP6R3UUx/00/YS5hBP1o99JvrcQ21/ObKygnimQ8ZdIopoHp98LuBiae
        /kt5K+8cE+kpnPTIDoFkexblIVbmrd+5BbP9bHX2+BYy4r32XGsnHpY6aEY25kA1E8GsmR
        ECs3I6XIXPa9wzYGWE905vrvDe5oitI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EC5513A65;
        Thu,  5 May 2022 08:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R4J8FJuFc2LdAgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 05 May 2022 08:06:51 +0000
Message-ID: <9d53e1bd-b370-cc8c-5194-fa084b887ecc@suse.com>
Date:   Thu, 5 May 2022 11:06:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/5] iomap: add per-iomap_iter private data
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220504162342.573651-1-hch@lst.de>
 <20220504162342.573651-3-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220504162342.573651-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4.05.22 г. 19:23 ч., Christoph Hellwig wrote:
> Allow the file system to keep state for all iterations.  For now only
> wire it up for direct I/O as there is an immediate need for it there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/iomap/direct-io.c  | 8 ++++++++
>   include/linux/iomap.h | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 15929690d89e3..355abe2eacc6a 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -520,6 +520,14 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   	dio->submit.waiter = current;
>   	dio->submit.poll_bio = NULL;
>   
> +	/*
> +	 * Transfer the private data that was passed by the caller to the
> +	 * iomap_iter, and clear it in the iocb, as iocb->private will be
> +	 * used for polled bio completion later.
> +	 */
> +	iomi.private = iocb->private;
> +	WRITE_ONCE(iocb->private, NULL);

nit: Why use WRITE_ONCE here? Generaly when it's used it will suggest to 
the reader something funny is going on with accessing that variable 
without holding a particular lock?

> +
>   	if (iov_iter_rw(iter) == READ) {
>   		if (iomi.pos >= dio->i_size)
>   			goto out_free_dio;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index a5483020dad41..109c055865f73 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -188,6 +188,7 @@ struct iomap_iter {
>   	unsigned flags;
>   	struct iomap iomap;
>   	struct iomap srcmap;
> +	void *private;
>   };
>   
>   int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
