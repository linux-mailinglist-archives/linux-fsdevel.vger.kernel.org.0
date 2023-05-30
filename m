Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0677166C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjE3POh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjE3POc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2127E8
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685459624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vye8gB1vOKUzz58ckJ8yXN12XsS7VmnNhEIxChnaCeU=;
        b=KsIuH7mTAiUSub88mI9U/W1zk6poN6GrAO5UfrisxfXQNY6MJZ1JtTzAOO3sSy2o6T/1K7
        hOnUPuJ02QRaL+VP+Vr0Y6GmMbQS6xwzWF6Xp7bRCpp7VtBzH6Ez1M7N+8ldwYtPWX4oZr
        nKSnKrAOpLl0tpEFu1XhaRp+CxBqgsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-hmEFKwvqOZWLGW87qowi1w-1; Tue, 30 May 2023 11:13:40 -0400
X-MC-Unique: hmEFKwvqOZWLGW87qowi1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB27785A5BA;
        Tue, 30 May 2023 15:13:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A93F140EBB8;
        Tue, 30 May 2023 15:13:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 34UFDdMG006630;
        Tue, 30 May 2023 11:13:39 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 34UFDc58006626;
        Tue, 30 May 2023 11:13:38 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 30 May 2023 11:13:38 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
cc:     "axboe @ kernel . dk" <axboe@kernel.dk>,
        linux-block@vger.kernel.org, damien.lemoal@wdc.com, kch@nvidia.com,
        agruenba@redhat.com, shaggy@kernel.org, song@kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        snitzer@kernel.org, jfs-discussion@lists.sourceforge.net,
        willy@infradead.org, ming.lei@redhat.com, cluster-devel@redhat.com,
        linux-mm@kvack.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        hch@lst.de, rpeterso@redhat.com
Subject: Re: [dm-devel] [PATCH v5 16/20] dm-crypt: check if adding pages to
 clone bio fails
In-Reply-To: <20230502101934.24901-17-johannes.thumshirn@wdc.com>
Message-ID: <alpine.LRH.2.21.2305301045220.3943@file01.intranet.prod.int.rdu2.redhat.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com> <20230502101934.24901-17-johannes.thumshirn@wdc.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 2 May 2023, Johannes Thumshirn wrote:

> Check if adding pages to clone bio fails and if it does retry with
> reclaim. This mirrors the behaviour of page allocation in
> crypt_alloc_buffer().
> 
> This way we can mark bio_add_pages as __must_check.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  drivers/md/dm-crypt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 8b47b913ee83..b234dc089cee 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -1693,7 +1693,14 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
>  
>  		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
>  
> -		bio_add_page(clone, page, len, 0);
> +		if (!bio_add_page(clone, page, len, 0)) {
> +			mempool_free(page, &cc->page_pool);
> +			crypt_free_buffer_pages(cc, clone);
> +			bio_put(clone);
> +			gfp_mask |= __GFP_DIRECT_RECLAIM;
> +			goto retry;
> +
> +		}
>  
>  		remaining_size -= len;
>  	}

Hi

I nack this. This just adds code that can't ever be executed.

dm-crypt already allocates enough entries in the vector (see "unsigned int 
nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;"), so bio_add_page can't 
fail.

If you want to add __must_check to bio_add_page, you should change the 
dm-crypt code to:
if (!bio_add_page(clone, page, len, 0)) {
	WARN(1, "this can't happen");
	return NULL;
}
and not write recovery code for a can't-happen case.

Mikulas

