Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB87718AC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 22:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjEaUFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEaUFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 16:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BE219D
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685563492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNA2ebP/Kk24u5JXiZiwF7lD7gfc/9bE909Ix3mRLxI=;
        b=P3cOH955ZD771FQo0moJCIiRV3b2ValR/6q0KER2TacCw0CIcDxy9kJ2X/iFgkIokPCWEB
        V+ZO8vve7+b1+Crag0hOmp2QmHpDdNpGRawynscB3lmXmNt/WpuC8O8UpfDlT3ReUuM1vp
        ZyAfsEXSauRvJSuRf+cZi9d46M+V25o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-noSna6GIOauu1C41_KaVCw-1; Wed, 31 May 2023 16:04:07 -0400
X-MC-Unique: noSna6GIOauu1C41_KaVCw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 792A6858EEB;
        Wed, 31 May 2023 20:03:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6228F492B0A;
        Wed, 31 May 2023 20:03:45 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
        id DCDB516EF93; Wed, 31 May 2023 16:03:44 -0400 (EDT)
Date:   Wed, 31 May 2023 16:03:44 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        gerry@linux.alibaba.com, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] fuse: fix return value of inode_inline_reclaim_one_dmap
 in error path
Message-ID: <ZHeoIFrp303f0E8d@redhat.com>
References: <20230424123250.125404-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123250.125404-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:32:50PM +0800, Jingbo Xu wrote:
> When range already got reclaimed by somebody else, return NULL so that
> the caller could retry to allocate or reclaim another range, instead of
> mistakenly returning the range already got reclaimed and reused by
> others.
> 
> Reported-by: Liu Jiang <gerry@linux.alibaba.com>
> Fixes: 9a752d18c85a ("virtiofs: add logic to free up a memory range")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Hi Jingbo,

This patch looks correct to me.

Are you able to reproduce the problem? Or you are fixing it based on
code inspection?

How are you testing this? We don't have virtiofsd DAX implementation yet
in rust virtiofsd yet. 

I am not sure how to test this chagne now. We had out of tree patches
in qemu and now qemu has gotten rid of C version of virtiofsd so these
patches might not even work now.

Thanks
Vivek
> ---
>  fs/fuse/dax.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 8e74f278a3f6..59aadfd89ee5 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -985,6 +985,7 @@ inode_inline_reclaim_one_dmap(struct fuse_conn_dax *fcd, struct inode *inode,
>  	node = interval_tree_iter_first(&fi->dax->tree, start_idx, start_idx);
>  	/* Range already got reclaimed by somebody else */
>  	if (!node) {
> +		dmap = NULL;
>  		if (retry)
>  			*retry = true;
>  		goto out_write_dmap_sem;
> -- 
> 2.19.1.6.gb485710b
> 

