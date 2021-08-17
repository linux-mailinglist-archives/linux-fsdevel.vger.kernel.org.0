Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD03EEAF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 12:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhHQK1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 06:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234632AbhHQK1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629196010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPOZjn3V5im3EaSW+oKZSoZf4HaKDzmboAenj2oASbI=;
        b=WqxsD3Ir8BFLql3g5mImy4OlGMsmAMD3SkvjfdZLc8ii9QU6MKLeeZ8lIGZNj7q4MNkmpc
        xB2MBc5StvwLWNs791BdqaK7Lttm1SpetD+2t89vsT1xb0eocCEJRQ2wiwvYhYnXSlgHot
        pou1p+bhdRYJvZuwkc7bOuPpncNPL6U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-97iVtqV2NbKnW_v6kbw1Cw-1; Tue, 17 Aug 2021 06:26:48 -0400
X-MC-Unique: 97iVtqV2NbKnW_v6kbw1Cw-1
Received: by mail-wm1-f71.google.com with SMTP id 11-20020a05600c024bb02902e679d663d1so4857866wmj.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 03:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dPOZjn3V5im3EaSW+oKZSoZf4HaKDzmboAenj2oASbI=;
        b=VMVe2SGs85gXmUyLZHcy86ZNlegjXLvGtak7BOAkYXBZDQzQdLy95p29doBoH54Y0B
         9fyKeG16pDhgOZ9D2B5+YJNS9hj6U9wwjdwQeyYKBJllHIlgK+YhFQCtnmY+QM6MTg/b
         v/CPRwXarxHr4CNJexClvOTfuwEpx6XMRT5nbpBiuhZEXlyTvciJXi7mtUMGv5t/JJe8
         dNNZ+qZsta1OMuXMZuBb5lFz4SUU29VTkXL/N2b8a3Z6UDV6ccODaMVCLdXoR3XzYha6
         JRUAKzqow3uc0uTp4TYPfh1GCb1DU+VDfIpKFkvobDwioP1vhsL5sP/K9pY4pGQbWw4r
         2HaA==
X-Gm-Message-State: AOAM530nyKOjVekrsBMYxAWG4ommjpA4iMQe0Q42TVrEpIL6sXW54rpQ
        nualGPezAT3bqOycEB6TnjWm4cOMPN+ecXxVUtzeZrXAp59+zIX46kccU/MC7xyFuUA1yzy7Mr0
        q//5fdISDeTmQwsWNEsRvaTiY4A==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr2487670wmj.119.1629196007628;
        Tue, 17 Aug 2021 03:26:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZpPkW0eowh5zeHCjZYpXMEsSrO7sfME5hs/QsYMSAWHwk4z4E0xnU4zl3GG5yBTtHDNtGvg==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr2487663wmj.119.1629196007464;
        Tue, 17 Aug 2021 03:26:47 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id j17sm1885274wrt.69.2021.08.17.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 03:26:47 -0700 (PDT)
Date:   Tue, 17 Aug 2021 11:26:45 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [Virtio-fs] [PATCH v4 6/8] fuse: mark inode DONT_CACHE when
 per-file DAX indication changes
Message-ID: <YRuO5ZzqDmuSC3pN@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022220.17574-7-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817022220.17574-7-jefflexu@linux.alibaba.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> When the per-file DAX indication changes while the file is still
> *opened*, it is quite complicated and maybe fragile to dynamically
> change the DAX state.
> 
> Hence mark the inode and corresponding dentries as DONE_CACHE once the

                                                     ^^^^^^^^^^
typo as DONT ?

Dave

> per-file DAX indication changes, so that the inode instance will be
> evicted and freed as soon as possible once the file is closed and the
> last reference to the inode is put. And then when the file gets reopened
> next time, the inode will reflect the new DAX state.
> 
> In summary, when the per-file DAX indication changes for an *opened*
> file, the state of the file won't be updated until this file is closed
> and reopened later.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c    | 9 +++++++++
>  fs/fuse/fuse_i.h | 1 +
>  fs/fuse/inode.c  | 3 +++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 30833f8d37dd..f7ede0be4e00 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1364,6 +1364,15 @@ void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>  	inode->i_data.a_ops = &fuse_dax_file_aops;
>  }
>  
> +void fuse_dax_dontcache(struct inode *inode, bool newdax)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +
> +	if (fc->dax_mode == FUSE_DAX_INODE &&
> +	    fc->perfile_dax && (!!IS_DAX(inode) != newdax))
> +		d_mark_dontcache(inode);
> +}
> +
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment)
>  {
>  	if (fc->dax && (map_alignment > FUSE_DAX_SHIFT)) {
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7b7b4c208af2..56fe1c4d2136 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1260,6 +1260,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc);
>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>  void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
>  void fuse_dax_inode_cleanup(struct inode *inode);
> +void fuse_dax_dontcache(struct inode *inode, bool newdax);
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>  void fuse_dax_cancel_work(struct fuse_conn *fc);
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 8080f78befed..8c9774c6a210 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -269,6 +269,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>  		if (inval)
>  			invalidate_inode_pages2(inode->i_mapping);
>  	}
> +
> +	if (IS_ENABLED(CONFIG_FUSE_DAX))
> +		fuse_dax_dontcache(inode, attr->flags & FUSE_ATTR_DAX);
>  }
>  
>  static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
> -- 
> 2.27.0
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

