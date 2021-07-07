Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0F3BE191
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 05:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhGGDk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 23:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhGGDk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 23:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625629096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2aWbDZbFo4kzS9y74gUrqgwbmoseq7BXNDY/LziZbQ=;
        b=NUoUKNW2FVnOOdjA1KP+B0It2cXEcwEL5lWS4pm3H9P9A80+k9/8rQm9ITxLOfXARgaXC7
        5sY3XsiB5p2SKbVhBHctwtkNvVEBAAAnczQLsuJNfnC+z2IWwKO+G52Fv9qZOf0grKfz0O
        6efOhAXbw3K080+wRgzZg5zXbDKm7so=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-7lfXr3VEPfqAqlfkI5vFgw-1; Tue, 06 Jul 2021 23:38:15 -0400
X-MC-Unique: 7lfXr3VEPfqAqlfkI5vFgw-1
Received: by mail-pg1-f197.google.com with SMTP id o15-20020a655bcf0000b029022c1a9c33b7so580330pgr.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jul 2021 20:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=h2aWbDZbFo4kzS9y74gUrqgwbmoseq7BXNDY/LziZbQ=;
        b=Ltmv/l8O5X8joA0MHoJdMtgq6RaCBbahhX6/N2ObB3Q6f3uvUAWaD4csNsDpn9WsHW
         BC1b33UicZdi4IO0D0aIlMc+ZoldkdDpVXwDUVPquUun3TV6HzH6aBX+K0OJva9q1SzU
         +iKE5KQzvvFkIH2jnQagm5BVOQSoJVEs/dPzZLD+PVeLXvXm/5l7ocVRHvG30uk+5sM0
         Plb0zFQIDQvGwj2Kg7ip7kLrDpDoGEiOPYzwYVwf2Fs2jemmDApgbwMNdhXJNZK2QjaD
         mZ2p8seRLIDsGmw6ftQ3c7CF5yCC3GkS9RIKzg+wEzG0TNu6rDe6lZoFJXfu5NNiDZIT
         J4Bw==
X-Gm-Message-State: AOAM5338/5hH5F9ShQqA0gPgbDmLTzmdLBKC/jFAmzSmjUbJiP2a+lO5
        kMRqZ9bfrFVSZ9j+N8M/tmvqwgUsikEaqlGfLjIyPlOdU79lthGI4mC+DNSBUlRqDzpkbmbOUB6
        u3Mv5G+7MkogwkUvggONDIWyfrg==
X-Received: by 2002:a17:90a:f2c2:: with SMTP id gt2mr24309143pjb.86.1625629094154;
        Tue, 06 Jul 2021 20:38:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp9tsBWasHibXpYhkN407hti3EvzOBBo0XHjAt+5NtZ/0PszQJRKWn58zOIE/JFHpmpi+E2Q==
X-Received: by 2002:a17:90a:f2c2:: with SMTP id gt2mr24309124pjb.86.1625629093907;
        Tue, 06 Jul 2021 20:38:13 -0700 (PDT)
Received: from [10.72.13.191] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v4sm19471875pgr.65.2021.07.06.20.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 20:38:13 -0700 (PDT)
Subject: Re: [RFC PATCH v7 05/24] ceph: preallocate inode for ops that may
 create one
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-6-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <83dcbc5c-7a87-b6cd-b364-2ca4aa5bd440@redhat.com>
Date:   Wed, 7 Jul 2021 11:37:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625135834.12934-6-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/25/21 9:58 PM, Jeff Layton wrote:
> When creating a new inode, we need to determine the crypto context
> before we can transmit the RPC. The fscrypt API has a routine for getting
> a crypto context before a create occurs, but it requires an inode.
>
> Change the ceph code to preallocate an inode in advance of a create of
> any sort (open(), mknod(), symlink(), etc). Move the existing code that
> generates the ACL and SELinux blobs into this routine since that's
> mostly common across all the different codepaths.
>
> In most cases, we just want to allow ceph_fill_trace to use that inode
> after the reply comes in, so add a new field to the MDS request for it
> (r_new_inode).
>
> The async create codepath is a bit different though. In that case, we
> want to hash the inode in advance of the RPC so that it can be used
> before the reply comes in. If the call subsequently fails with
> -EJUKEBOX, then just put the references and clean up the as_ctx. Note
> that with this change, we now need to regenerate the as_ctx when this
> occurs, but it's quite rare for it to happen.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/dir.c        | 70 ++++++++++++++++++++-----------------
>   fs/ceph/file.c       | 62 ++++++++++++++++++++-------------
>   fs/ceph/inode.c      | 82 ++++++++++++++++++++++++++++++++++++++++----
>   fs/ceph/mds_client.c |  3 +-
>   fs/ceph/mds_client.h |  1 +
>   fs/ceph/super.h      |  7 +++-
>   6 files changed, 160 insertions(+), 65 deletions(-)
>
[...]

> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index eb562e259347..f62785e4dbcb 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -52,17 +52,85 @@ static int ceph_set_ino_cb(struct inode *inode, void *data)
>   	return 0;
>   }
>   
> -struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino)
> +/**
> + * ceph_new_inode - allocate a new inode in advance of an expected create
> + * @dir: parent directory for new inode
> + * @dentry: dentry that may eventually point to new inode
> + * @mode: mode of new inode
> + * @as_ctx: pointer to inherited security context
> + *
> + * Allocate a new inode in advance of an operation to create a new inode.
> + * This allocates the inode and sets up the acl_sec_ctx with appropriate
> + * info for the new inode.
> + *
> + * Returns a pointer to the new inode or an ERR_PTR.
> + */
> +struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
> +			     umode_t *mode, struct ceph_acl_sec_ctx *as_ctx)
> +{
> +	int err;
> +	struct inode *inode;
> +
> +	inode = new_inode_pseudo(dir->i_sb);
> +	if (!inode)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!S_ISLNK(*mode)) {
> +		err = ceph_pre_init_acls(dir, mode, as_ctx);
> +		if (err < 0)
> +			goto out_err;
> +	}
> +
> +	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
> +	if (err < 0)
> +		goto out_err;
> +
> +	inode->i_state = 0;
> +	inode->i_mode = *mode;
> +	return inode;
> +out_err:
> +	iput(inode);
> +	return ERR_PTR(err);
> +}
> +
> +void ceph_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as_ctx)
> +{
> +	if (as_ctx->pagelist) {
> +		req->r_pagelist = as_ctx->pagelist;
> +		as_ctx->pagelist = NULL;
> +	}
> +}
> +
> +/**
> + * ceph_get_inode - find or create/hash a new inode
> + * @sb: superblock to search and allocate in
> + * @vino: vino to search for
> + * @newino: optional new inode to insert if one isn't found (may be NULL)
> + *
> + * Search for or insert a new inode into the hash for the given vino, and return a
> + * reference to it. If new is non-NULL, its reference is consumed.
> + */
> +struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino, struct inode *newino)
>   {
>   	struct inode *inode;
>   
>   	if (ceph_vino_is_reserved(vino))
>   		return ERR_PTR(-EREMOTEIO);
>   
> -	inode = iget5_locked(sb, (unsigned long)vino.ino, ceph_ino_compare,
> -			     ceph_set_ino_cb, &vino);
> -	if (!inode)
> +	if (newino) {
> +		inode = inode_insert5(newino, (unsigned long)vino.ino, ceph_ino_compare,
> +					ceph_set_ino_cb, &vino);
> +		if (inode != newino)
> +			iput(newino);
> +	} else {
> +		inode = iget5_locked(sb, (unsigned long)vino.ino, ceph_ino_compare,
> +				     ceph_set_ino_cb, &vino);
> +	}
> +
> +	if (!inode) {
> +		dout("No inode found for %llx.%llx\n", vino.ino, vino.snap);
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	dout("get_inode on %llu=%llx.%llx got %p new %d\n", ceph_present_inode(inode),
>   	     ceph_vinop(inode), inode, !!(inode->i_state & I_NEW));
> @@ -78,7 +146,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   		.ino = ceph_ino(parent),
>   		.snap = CEPH_SNAPDIR,
>   	};
> -	struct inode *inode = ceph_get_inode(parent->i_sb, vino);
> +	struct inode *inode = ceph_get_inode(parent->i_sb, vino, NULL);
>   	struct ceph_inode_info *ci = ceph_inode(inode);
>   
>   	if (IS_ERR(inode))

Should we always check this just before using it before 'struct 
ceph_inode_info *ci = ceph_inode(inode);' ?

But it seems the 'ceph_inode()' won't introduce any issue here.

Thanks,

> @@ -1546,7 +1614,7 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
>   		vino.ino = le64_to_cpu(rde->inode.in->ino);
>   		vino.snap = le64_to_cpu(rde->inode.in->snapid);
>   
> -		in = ceph_get_inode(req->r_dentry->d_sb, vino);
> +		in = ceph_get_inode(req->r_dentry->d_sb, vino, NULL);
>   		if (IS_ERR(in)) {
>   			err = PTR_ERR(in);
>   			dout("new_inode badness got %d\n", err);
> @@ -1748,7 +1816,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>   		if (d_really_is_positive(dn)) {
>   			in = d_inode(dn);
>   		} else {
> -			in = ceph_get_inode(parent->d_sb, tvino);
> +			in = ceph_get_inode(parent->d_sb, tvino, NULL);
>   			if (IS_ERR(in)) {
>   				dout("new_inode badness\n");
>   				d_drop(dn);
[...]

