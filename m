Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F23414E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 06:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhCSFcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 01:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233861AbhCSFba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616131890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pi7qcf0su8SHd5MhPDGQZEuOYgak0GZ+PGaHggZ/3J0=;
        b=eOtm1DzmWJPZuzsoJXSz3yG/M8eBRk2zN3JqHmmj8FQ7fRUu9jEBgW7ZYF2XrFQFAT+Ym2
        GRWazpUe2CL/lpxSWBmSe9XRsopECPiDX1Rv+MKQCvZ81UInqKtbclsenBVmdbl+ZhviRt
        4yygXRq9hRSzDJ+7OPqOVL0mrhZu70c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-zag788nPNjqgswtfbyM_kg-1; Fri, 19 Mar 2021 01:31:26 -0400
X-MC-Unique: zag788nPNjqgswtfbyM_kg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECD73107ACCA;
        Fri, 19 Mar 2021 05:31:24 +0000 (UTC)
Received: from [10.72.12.240] (ovpn-12-240.pek2.redhat.com [10.72.12.240])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EDE150457;
        Fri, 19 Mar 2021 05:31:19 +0000 (UTC)
Subject: Re: [PATCH v2] ceph: don't use d_add in ceph_handle_snapdir
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        idryomov@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        pdonnell@redhat.com
References: <20210316203919.102346-1-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <a7ce9ff6-a187-372d-1d33-e10ea9364827@redhat.com>
Date:   Fri, 19 Mar 2021 13:31:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316203919.102346-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/3/17 4:39, Jeff Layton wrote:
> It's possible ceph_get_snapdir could end up finding a (disconnected)
> inode that already exists in the cache. Change the prototype for
> ceph_handle_snapdir to return a dentry pointer and have it use
> d_splice_alias so we don't end up with an aliased dentry in the cache.
>
> URL: https://tracker.ceph.com/issues/49843
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/dir.c   | 32 ++++++++++++++++++++------------
>   fs/ceph/file.c  |  7 +++++--
>   fs/ceph/super.h |  2 +-
>   3 files changed, 26 insertions(+), 15 deletions(-)
>
> v2:
>      zero out err var when ceph_handle_snapdir returns success
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 113f669d71dd..570662dec3fe 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -667,8 +667,8 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
>   /*
>    * Handle lookups for the hidden .snap directory.
>    */
> -int ceph_handle_snapdir(struct ceph_mds_request *req,
> -			struct dentry *dentry, int err)
> +struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
> +				   struct dentry *dentry, int err)
>   {
>   	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
>   	struct inode *parent = d_inode(dentry->d_parent); /* we hold i_mutex */
> @@ -676,18 +676,19 @@ int ceph_handle_snapdir(struct ceph_mds_request *req,
>   	/* .snap dir? */
>   	if (err == -ENOENT &&
>   	    ceph_snap(parent) == CEPH_NOSNAP &&
> -	    strcmp(dentry->d_name.name,
> -		   fsc->mount_options->snapdir_name) == 0) {
> +	    strcmp(dentry->d_name.name, fsc->mount_options->snapdir_name) == 0) {
> +		struct dentry *res;
>   		struct inode *inode = ceph_get_snapdir(parent);
> +
>   		if (IS_ERR(inode))
> -			return PTR_ERR(inode);
> -		dout("ENOENT on snapdir %p '%pd', linking to snapdir %p\n",
> -		     dentry, dentry, inode);
> -		BUG_ON(!d_unhashed(dentry));
> -		d_add(dentry, inode);
> -		err = 0;
> +			return ERR_CAST(inode);
> +		res = d_splice_alias(inode, dentry);
> +		dout("ENOENT on snapdir %p '%pd', linking to snapdir %p. Spliced dentry %p\n",
> +		     dentry, dentry, inode, res);
> +		if (res)
> +			dentry = res;
>   	}
> -	return err;
> +	return dentry;
>   }
>   
>   /*
> @@ -743,6 +744,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>   	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
>   	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
>   	struct ceph_mds_request *req;
> +	struct dentry *res;
>   	int op;
>   	int mask;
>   	int err;
> @@ -793,7 +795,13 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>   	req->r_parent = dir;
>   	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
>   	err = ceph_mdsc_do_request(mdsc, NULL, req);
> -	err = ceph_handle_snapdir(req, dentry, err);
> +	res = ceph_handle_snapdir(req, dentry, err);
> +	if (IS_ERR(res)) {
> +		err = PTR_ERR(res);
> +	} else {
> +		dentry = res;
> +		err = 0;
> +	}
>   	dentry = ceph_finish_lookup(req, dentry, err);
>   	ceph_mdsc_put_request(req);  /* will dput(dentry) */
>   	dout("lookup result=%p\n", dentry);
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 209535d5b8d3..a6ef1d143308 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -739,9 +739,12 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>   	err = ceph_mdsc_do_request(mdsc,
>   				   (flags & (O_CREAT|O_TRUNC)) ? dir : NULL,
>   				   req);
> -	err = ceph_handle_snapdir(req, dentry, err);
> -	if (err)
> +	dentry = ceph_handle_snapdir(req, dentry, err);
> +	if (IS_ERR(dentry)) {
> +		err = PTR_ERR(dentry);
>   		goto out_req;
> +	}
> +	err = 0;
>   
>   	if ((flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
>   		err = ceph_handle_notrace_create(dir, dentry);
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 188565d806b2..07a3fb52ae30 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1193,7 +1193,7 @@ extern const struct dentry_operations ceph_dentry_ops;
>   
>   extern loff_t ceph_make_fpos(unsigned high, unsigned off, bool hash_order);
>   extern int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry);
> -extern int ceph_handle_snapdir(struct ceph_mds_request *req,
> +extern struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
>   			       struct dentry *dentry, int err);
>   extern struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
>   					 struct dentry *dentry, int err);

LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

