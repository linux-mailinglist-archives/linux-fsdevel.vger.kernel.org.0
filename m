Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57C44F8157
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiDGONh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiDGONg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E1AF138374
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649340664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T9gNLvj+RzSmMEWWNqwab09rZ5taTtgxhPO2/45pSnk=;
        b=Y3ImM0girmSC+Dx8ryKBdiK+YOaFUThDR8f25obPn0P7xNwYDRBSKS6fVX6rBNohOg8Z/o
        N7VeEWD4fKhrZJlbzN7Q11jqkhhHCAVeT0cUpkXx1RP9/A1WKu+PW3SmO3y3utfP4DQMEE
        n8QYLZJpFdf6eNVkVlXDjMjiAbU1FOk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-PPuv8H_HPQWzTK4AvKUwfA-1; Thu, 07 Apr 2022 10:11:02 -0400
X-MC-Unique: PPuv8H_HPQWzTK4AvKUwfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6858629DD9B0;
        Thu,  7 Apr 2022 14:11:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E07052024CB9;
        Thu,  7 Apr 2022 14:10:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8D3BE220EFF; Thu,  7 Apr 2022 10:10:56 -0400 (EDT)
Date:   Thu, 7 Apr 2022 10:10:56 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     miklos@szeredi.hu, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Message-ID: <Yk7w8L1f/yik+qrR@redhat.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
> Move dmap free worker kicker inside the critical region, so that extra
> spinlock lock/unlock could be avoided.
> 
> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Looks good to me. Have you done any testing to make sure nothing is
broken.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index d7d3a7f06862..b9f8795d52c4 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -138,9 +138,9 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn_dax *fcd)
>  		WARN_ON(fcd->nr_free_ranges <= 0);
>  		fcd->nr_free_ranges--;
>  	}
> +	__kick_dmap_free_worker(fcd, 0);
>  	spin_unlock(&fcd->lock);
>  
> -	kick_dmap_free_worker(fcd, 0);
>  	return dmap;
>  }
>  
> -- 
> 2.27.0
> 

