Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834AC5588AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 21:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiFWTZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 15:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiFWTZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D54BB52E7B
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656009520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeNVREv1NWyeUggZHOzWT8IR8BLdwJfkFs5TG9nYZK4=;
        b=dmh/qMBopOareocywkme3RPEOq2wM/7SwyCK+vdxlRggni8gVg6T10zWl3eNC+Tq+5wp72
        QzV5dotNa3IlTOUgZvNkCEKRelI04viocMeiJ6nvhkns9slR9d4+cFpjO4ScJSifrS6T3b
        m99r8ZPvoXjYRXsqM/1B8EqU9N2sSws=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-C68Z2qpLNROBPtNyCW2cFA-1; Thu, 23 Jun 2022 14:38:37 -0400
X-MC-Unique: C68Z2qpLNROBPtNyCW2cFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26EB33806700;
        Thu, 23 Jun 2022 18:38:37 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.18.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17ADA141510C;
        Thu, 23 Jun 2022 18:38:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id CD8682209F9; Thu, 23 Jun 2022 14:38:36 -0400 (EDT)
Date:   Thu, 23 Jun 2022 14:38:36 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     wubo <11123156@vivo.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wu Bo <bo.wu@vivo.com>
Subject: Re: [PATCH] fuse: force sync attr when inode is invalidated
Message-ID: <YrSzLNCSg/8fWZ1j@redhat.com>
References: <20220621125651.14954-1-11123156@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621125651.14954-1-11123156@vivo.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 21, 2022 at 08:56:51PM +0800, wubo wrote:
> From: Wu Bo <bo.wu@vivo.com>
> 
> Now the fuse driver only trust it's local inode size when
> writeback_cache is enabled. Even the userspace server tell the driver
> the inode cache is invalidated, the size attrabute will not update. And
> will keep it's out-of-date size till the inode cache is dropped. This is
> not reasonable.

BTW, can you give more details about what's the use case. With
writeback_cache, writes can be cached in fuse and not sent to
file server immediately. And I think that's why fuse trusts
local i_size.

With writeback_cache enabled, I don't think file should be modified
externally (outside the fuse client).

So what's that use case where file size cached in fuse is out of
date. You probably should not use writeback_cache if you are
modifying files outside the fuse client.

Having said that I am not sure why FUSE_NOTIFY_INVAL_INODE was added to
begin with. If files are not supposed to be modifed outside the fuse
client, why are we dropping acls and invalidating attrs. If intent is
just to drop page cache, then it should have been just that nothing
else. 

So up to some extent, FUSE_NOTIFY_INVAL_INODE is somewhat confusing. Would
have been good if there was some documentation for it.

Thanks
Vivek

> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/fuse/inode.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 8c0665c5dff8..a4e62c7f2b83 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -162,6 +162,11 @@ static ino_t fuse_squash_ino(u64 ino64)
>  	return ino;
>  }
>  
> +static bool fuse_force_sync(struct fuse_inode *fi)
> +{
> +	return fi->i_time == 0;
> +}
> +
>  void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>  				   u64 attr_valid, u32 cache_mask)
>  {
> @@ -222,8 +227,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>  u32 fuse_get_cache_mask(struct inode *inode)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	bool is_force_sync = fuse_force_sync(fi);
>  
> -	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
> +	if (!fc->writeback_cache || !S_ISREG(inode->i_mode) || is_force_sync)
>  		return 0;
>  
>  	return STATX_MTIME | STATX_CTIME | STATX_SIZE;
> @@ -437,6 +444,7 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>  	fi = get_fuse_inode(inode);
>  	spin_lock(&fi->lock);
>  	fi->attr_version = atomic64_inc_return(&fc->attr_version);
> +	fi->i_time = 0;
>  	spin_unlock(&fi->lock);
>  
>  	fuse_invalidate_attr(inode);
> -- 
> 2.35.1
> 

