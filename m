Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88388269B2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 03:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIOBat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 21:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIOBan (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:30:43 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B60C20770;
        Tue, 15 Sep 2020 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600133442;
        bh=02lCOsnm4FenhdhQcBTHqzPLdKzBa6eWceyoE3rY+B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PXHllC51wtAxu2C1EsB3Wlnta8GCA/W7Zrh5d6bkmGsf8D5Y58TeaKmtPwIFklLaT
         Jri6Sgl5CnmHii9QgnuVJaLGy5HDexao7s4yhA4jLwxrFsTcEDfs2idGlNbl1C9EEX
         XlBW9ddvos5/4dHRv6+Jp2UZaqta+7wxZ06vTjCI=
Date:   Mon, 14 Sep 2020 18:30:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 09/16] ceph: preallocate inode for ops that may
 create one
Message-ID: <20200915013041.GI899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-10-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-10-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:17:00PM -0400, Jeff Layton wrote:
> @@ -663,6 +658,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>  	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
>  	struct ceph_mds_client *mdsc = fsc->mdsc;
>  	struct ceph_mds_request *req;
> +	struct inode *new_inode = NULL;
>  	struct dentry *dn;
>  	struct ceph_acl_sec_ctx as_ctx = {};
>  	bool try_async = ceph_test_mount_opt(fsc, ASYNC_DIROPS);
> @@ -675,21 +671,21 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>  
>  	if (dentry->d_name.len > NAME_MAX)
>  		return -ENAMETOOLONG;
> -
> +retry:
>  	if (flags & O_CREAT) {
>  		if (ceph_quota_is_max_files_exceeded(dir))
>  			return -EDQUOT;
> -		err = ceph_pre_init_acls(dir, &mode, &as_ctx);
> -		if (err < 0)
> -			return err;
> -		err = ceph_security_init_secctx(dentry, mode, &as_ctx);
> -		if (err < 0)
> +
> +		new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
> +		if (IS_ERR(new_inode)) {
> +			err = PTR_ERR(new_inode);
>  			goto out_ctx;
> +		}

Is the 'goto out_ctx;' correct here?  It looks like it should be
'return PTR_ERR(new_inode)'

> +/**
> + * ceph_new_inode - allocate a new inode in advance of an expected create
> + * @dir: parent directory for new inode
> + * @mode: mode of new inode
> + */
> +struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
> +			     umode_t *mode, struct ceph_acl_sec_ctx *as_ctx)

Some parameters aren't documented.

> +	int err;
>  	struct inode *inode;
>  
> -	inode = iget5_locked(sb, (unsigned long)vino.ino, ceph_ino_compare,
> -			     ceph_set_ino_cb, &vino);
> +	inode = new_inode_pseudo(dir->i_sb);
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  
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

Should this be freeing anything from the ceph_acl_sec_ctx on error?

- Eric
