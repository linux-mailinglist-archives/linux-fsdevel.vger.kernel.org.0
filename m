Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECDE535747
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 03:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiE0BVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 21:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiE0BVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 21:21:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A910D4;
        Thu, 26 May 2022 18:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xkmgVlLHUrsvW9kgx9erOioxhXsicILhQsHT8zL99yU=; b=XOB+la0usr2jCz4xChRNHdSc0J
        WhH7oxwmbJpuLADA+beMwJMHr+8/2enHvbFU5P1nHLtmmb3nCuORNtyC2BzZWXQsARo+lfJSLHxcm
        oraiUqjZYKFprFe1EniS7BQygCgPhNEXMkXE6uAlpe8drYiWH++dR7qJ0/Qwm7QbzBH6/u1MQHP5x
        jTSUA8lZuL3xMzyXJDmST3fWiugu1lJUBqNnyuyCejDlVZ6Mo0FgMlFg9EpQSAWECX/GzKIFHjOrz
        nITbfhaRdhBV0zJVcVcV2lwSAgLfsIoO65FIz8KCfq5vH860jLkplEjWnzmf9iHzyGbP7hKp8JoaF
        ISqqts7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuOfj-001i49-0v; Fri, 27 May 2022 01:21:47 +0000
Date:   Fri, 27 May 2022 02:21:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] XArray: handle XA_FLAGS_ACCOUNT in xas_split_alloc
Message-ID: <YpAnqqY/c3Y5ZkPG@casper.infradead.org>
References: <348dc099-737d-94ba-55ad-2db285084c73@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348dc099-737d-94ba-55ad-2db285084c73@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 11:26:37AM +0300, Vasily Averin wrote:
> Commit 7b785645e8f1 ("mm: fix page cache convergence regression")
> added support of new XA_FLAGS_ACCOUNT flag into all Xarray allocation
> functions. Later commit 8fc75643c5e1 ("XArray: add xas_split")
> introduced xas_split_alloc() but missed about XA_FLAGS_ACCOUNT
> processing.

Thanks, Vasily.

Johannes, Shakeel, is this right?  I don't fully understand the accounting
stuff.

> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  lib/xarray.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 54e646e8e6ee..5f5b42e6f842 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1013,6 +1013,8 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
>  	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
>  		return;
>  
> +	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
> +		gfp |= __GFP_ACCOUNT;
>  	do {
>  		unsigned int i;
>  		void *sibling = NULL;
> -- 
> 2.31.1
> 
