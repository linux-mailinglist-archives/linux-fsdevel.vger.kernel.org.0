Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C24322AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhJRPWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233513AbhJRPWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634570390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gJqfV7DrARcYiTDUMbw6IUj1vup6B8cy9XkOz0GBZyU=;
        b=dLF0FvANV0xZObsEuV0bIAzVyk7HQu0ADSRlW2ZrcJHcPU1i7HYSjZLVSGGc+4clmxGlV2
        e8QT6jvF71EU+IajhiV1V9KXicID4kzeFH9x8bSUyttFGuBPHLjq/Jl8kOL42tu4TkoYz1
        eF8J+9qACS0gGhbjxUYK9ruzC8lTYes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-8ES0ccB1MH6p4-ttp0grBw-1; Mon, 18 Oct 2021 11:19:47 -0400
X-MC-Unique: 8ES0ccB1MH6p4-ttp0grBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D28D780A5C1;
        Mon, 18 Oct 2021 15:19:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B050870953;
        Mon, 18 Oct 2021 15:19:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 456F02256F3; Mon, 18 Oct 2021 11:19:20 -0400 (EDT)
Date:   Mon, 18 Oct 2021 11:19:20 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hub,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 6/7] fuse: mark inode DONT_CACHE when per-file DAX
 hint changes
Message-ID: <YW2QeIdS2X48FOHk@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-7-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011030052.98923-7-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:00:51AM +0800, Jeffle Xu wrote:
> When the per-file DAX hint changes while the file is still *opened*, it
> is quite complicated and maybe fragile to dynamically change the DAX
> state.
> 
> Hence mark the inode and corresponding dentries as DONE_CACHE once the
> per-file DAX hint changes, so that the inode instance will be evicted
> and freed as soon as possible once the file is closed and the last
> reference to the inode is put. And then when the file gets reopened next
> time, the new instantiated inode will reflect the new DAX state.
> 
> In summary, when the per-file DAX hint changes for an *opened* file, the
> DAX state of the file won't be updated until this file is closed and
> reopened later.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c    | 9 +++++++++
>  fs/fuse/fuse_i.h | 1 +
>  fs/fuse/inode.c  | 3 +++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 15bde36829b8..ca083c13f5e8 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1364,6 +1364,15 @@ void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>  	inode->i_data.a_ops = &fuse_dax_file_aops;
>  }
>  
> +void fuse_dax_dontcache(struct inode *inode, unsigned int flags)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +
> +	if (fc->dax_mode == FUSE_DAX_INODE &&
> +	    (!!IS_DAX(inode) != !!(flags & FUSE_ATTR_DAX)))
> +		d_mark_dontcache(inode);
> +}
> +
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment)
>  {
>  	if (fc->dax && (map_alignment > FUSE_DAX_SHIFT)) {
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 0270a41c31d7..bb2c11e0311a 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1270,6 +1270,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc);
>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>  void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
>  void fuse_dax_inode_cleanup(struct inode *inode);
> +void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>  void fuse_dax_cancel_work(struct fuse_conn *fc);
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 73f19cd6e702..cf934c2ba761 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -268,6 +268,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>  		if (inval)
>  			invalidate_inode_pages2(inode->i_mapping);
>  	}
> +
> +	if (IS_ENABLED(CONFIG_FUSE_DAX))
> +		fuse_dax_dontcache(inode, attr->flags);

Should we give this function more generic name. Say
fuse_dax_change_attributes(). And let that function decide what attributes
have changed and does it need to take any action.

Vivek

>  }
>  
>  static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
> -- 
> 2.27.0
> 

