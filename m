Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A864D3B49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 21:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiCIUqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 15:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiCIUqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:46:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF4377CC;
        Wed,  9 Mar 2022 12:45:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7D73B82171;
        Wed,  9 Mar 2022 20:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6BCC340EC;
        Wed,  9 Mar 2022 20:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646858705;
        bh=PjlPqpJTmh6e0UAumy4g+1qzPoTzrLX0saZj7KzVbFE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YgtDwQ/Syc9j0sruZWhi5nSmNtctoT/Pkqg7fyRRP4P1nxS1pSFdOSjqnapcrmAkZ
         bZQ8+H7Ev6tBOqGlEm4gXR7WSZK6pjZomSX2n4FMj64ZPBwDVhP1MDD+OSXZ70mUHd
         4/GWTztgS3UauP6/nOJ8cq1RcZg7GOX4uX/9XCBDkpMs9DRKeCDYCzEavFL+aeUuxL
         tzpRBeauQpYcs+JCUzPP2TG6EXsGK7ZGVINcUv5d8EtCq3zHfKVcN3CENVS9/yJR2q
         xcaZK1e7EUjbySOG43QZoydp7UfT5H4Ggxj5QlSr0INPwZhk/HlnPJzjohuL3u26fI
         fUZAN+8feRtXQ==
Message-ID: <2ebfd2f772ceef605896e58bbd0e733e1413ff71.camel@kernel.org>
Subject: Re: [PATCH v2 18/19] netfs: Keep track of the actual remote file
 size
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Mar 2022 15:45:02 -0500
In-Reply-To: <164678219305.1200972.6459431995188365134.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
         <164678219305.1200972.6459431995188365134.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-08 at 23:29 +0000, David Howells wrote:
> Provide a place in which to keep track of the actual remote file size in
> the netfs context.  This is needed because inode->i_size will be updated as
> we buffer writes in the pagecache, but the server file size won't get
> updated until we flush them back.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> 
> Link: https://lore.kernel.org/r/164623013727.3564931.17659955636985232717.stgit@warthog.procyon.org.uk/ # v1
> ---
> 
>  include/linux/netfs.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 8458b30172a5..c7bf1eaf51d5 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -126,6 +126,7 @@ struct netfs_i_context {
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	struct fscache_cookie	*cache;
>  #endif
> +	loff_t			remote_i_size;	/* Size of the remote file */
>  };
>  
>  /*
> @@ -324,6 +325,21 @@ static inline void netfs_i_context_init(struct inode *inode,
>  
>  	memset(ctx, 0, sizeof(*ctx));
>  	ctx->ops = ops;
> +	ctx->remote_i_size = i_size_read(inode);
> +}
> +
> +/**
> + * netfs_resize_file - Note that a file got resized
> + * @inode: The inode being resized
> + * @new_i_size: The new file size
> + *
> + * Inform the netfs lib that a file got resized so that it can adjust its state.
> + */
> +static inline void netfs_resize_file(struct inode *inode, loff_t new_i_size)
> +{
> +	struct netfs_i_context *ctx = netfs_i_context(inode);
> +
> +	ctx->remote_i_size = new_i_size;
>  }
>  
>  /**
> 
> 

This seems like something useful, but I wonder if it'll need some sort
of serialization vs. concurrent updates. Can we assume that netfs itself
will never call netfs_resize_file?

Ceph already has some pretty complicated size tracking, since it can get
async notifications of size changes from the MDS. We'll have to consider
how to integrate this with what it does. Probably this will replace one
(or more?) of its fields.

We may need to offer up some guidance wrt locking.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
