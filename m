Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8227C4733A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbhLMSLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 13:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236073AbhLMSLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639419060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ti7soy3xcy/wxNi+B5qp8dXl7p56YvGz3pI6Qnm2p2s=;
        b=RR9s/Tk1Dp78/JIEUQ05v6CzMlQeLNAU1PjItc3XJhCFO/X1CfemvDKArOtKwpZ3wnplZV
        9m0+D+faaTFZOII+TW5aHj39aoULeb0uWrZjMnTr1BQTUdg9qFLdr27w+0BzUsV0npK+rh
        C2rQwVeF1TFeZ4Yd1moRIbUuHq2EBCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-PNyv_MTUP-qVoOISR1ebDw-1; Mon, 13 Dec 2021 13:10:57 -0500
X-MC-Unique: PNyv_MTUP-qVoOISR1ebDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57BB785B666;
        Mon, 13 Dec 2021 18:10:56 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 576A110190A7;
        Mon, 13 Dec 2021 18:10:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BC8DA22341B; Mon, 13 Dec 2021 13:10:43 -0500 (EST)
Date:   Mon, 13 Dec 2021 13:10:43 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v8 6/7] fuse: mark inode DONT_CACHE when per inode DAX
 hint changes
Message-ID: <YbeMo86J2/AYipbB@redhat.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
 <20211125070530.79602-7-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125070530.79602-7-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:05:29PM +0800, Jeffle Xu wrote:
> When the per inode DAX hint changes while the file is still *opened*, it
> is quite complicated and maybe fragile to dynamically change the DAX
> state.
> 
> Hence mark the inode and corresponding dentries as DONE_CACHE once the
> per inode DAX hint changes, so that the inode instance will be evicted
> and freed as soon as possible once the file is closed and the last
> reference to the inode is put. And then when the file gets reopened next
> time, the new instantiated inode will reflect the new DAX state.
> 
> In summary, when the per inode DAX hint changes for an *opened* file, the
> DAX state of the file won't be updated until this file is closed and
> reopened later.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek
> ---
>  fs/fuse/dax.c    | 9 +++++++++
>  fs/fuse/fuse_i.h | 1 +
>  fs/fuse/inode.c  | 3 +++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 234c2278420f..b19e7eaed4ef 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1363,6 +1363,15 @@ void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>  	inode->i_data.a_ops = &fuse_dax_file_aops;
>  }
>  
> +void fuse_dax_dontcache(struct inode *inode, unsigned int flags)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +
> +	if (fuse_is_inode_dax_mode(fc->dax_mode) &&
> +	    (!!IS_DAX(inode) != !!(flags & FUSE_ATTR_DAX)))
> +		d_mark_dontcache(inode);
> +}
> +
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment)
>  {
>  	if (fc->dax && (map_alignment > FUSE_DAX_SHIFT)) {
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 83970723314a..af19d1d821ea 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1293,6 +1293,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc);
>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>  void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
>  void fuse_dax_inode_cleanup(struct inode *inode);
> +void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>  void fuse_dax_cancel_work(struct fuse_conn *fc);
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b26612fce6d0..b25d99eb8411 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -301,6 +301,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>  		if (inval)
>  			invalidate_inode_pages2(inode->i_mapping);
>  	}
> +
> +	if (IS_ENABLED(CONFIG_FUSE_DAX))
> +		fuse_dax_dontcache(inode, attr->flags);
>  }
>  
>  static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
> -- 
> 2.27.0
> 

