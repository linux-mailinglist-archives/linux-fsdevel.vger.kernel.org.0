Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D824CBE31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiCCMwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 07:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCCMwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:52:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721FD184B79;
        Thu,  3 Mar 2022 04:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 275C9B8250F;
        Thu,  3 Mar 2022 12:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5767FC004E1;
        Thu,  3 Mar 2022 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646311895;
        bh=OTrmcL4xmDZ9LP4eXxRB4TvKYiKUGaZuGXMOhO/shuw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P78vbiaJb4eH+kfLw5HeUxNqzBzyVqR2D9jgkzEjNIv7dYjFi6gvexgokzKCzQlT+
         gwVUe0oD3GhjqnD+86B0+Lu9bDGERqR3aQe0O5Bg/xHHFy2TTj9zIS1OU8Yn1wUyKt
         06x/XEienkLrtwHm6+JCQpdw4DUMgL+R1yettUrqd4ukAOHI+t2yDC9ZmPuP9wqFXm
         9fMkmFAHT7lJEZ8x5dMN6dCzrxQQ3OsRg6KDc0nQqGNktKhUGfacrz8Q5VF/x5P+u8
         98Fh8qd7KDUC17DJpBL5Ct1lof45B4R3ODTG8EVCFvW5bnm2cuXDILjI7EjPF0JxoF
         ZTPvocfGXvb1g==
Message-ID: <ca84ca91f1114bb9d8d0de29a00ac8a631caf5b2.camel@kernel.org>
Subject: Re: [PATCH] cachefiles: Fix incorrect length to fallocate()
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Mar 2022 07:51:33 -0500
In-Reply-To: <164630854858.3665356.17419701804248490708.stgit@warthog.procyon.org.uk>
References: <164630854858.3665356.17419701804248490708.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-03-03 at 11:55 +0000, David Howells wrote:
> When cachefiles_shorten_object() calls fallocate() to shape the cache file
> to match the DIO size, it passes the total file size it wants to achieve,
> not the amount of zeros that should be inserted.  Since this is meant to
> preallocate that amount of storage for the file, it can cause the cache to
> fill up the disk and hit ENOSPC.
> 
> Fix this by passing the length actually required to go from the current EOF
> to the desired EOF.
> 
> Fixes: 7623ed6772de ("cachefiles: Implement cookie resize for truncate")
> Reported-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> ---
> 
>  fs/cachefiles/interface.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
> index 51c968cd00a6..ae93cee9d25d 100644
> --- a/fs/cachefiles/interface.c
> +++ b/fs/cachefiles/interface.c
> @@ -254,7 +254,7 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
>  		ret = cachefiles_inject_write_error();
>  		if (ret == 0)
>  			ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
> -					    new_size, dio_size);
> +					    new_size, dio_size - new_size);
>  		if (ret < 0) {
>  			trace_cachefiles_io_error(object, file_inode(file), ret,
>  						  cachefiles_trace_fallocate_error);
> 
> 

Looks good!

I could often force the cache to fill up with the right fsstress run on
ceph, but with this in place I'm on the 5th run of xfstest generic/013
and it hasn't happened yet. You can add these if you like:

Tested-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
