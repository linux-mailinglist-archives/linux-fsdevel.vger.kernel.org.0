Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95771351463
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhDALN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 07:13:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:57990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234352AbhDALNd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 07:13:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4B13B305;
        Thu,  1 Apr 2021 11:13:31 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 36b15272;
        Thu, 1 Apr 2021 11:14:51 +0000 (UTC)
Date:   Thu, 1 Apr 2021 12:14:51 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/19] ceph: make ceph_get_name decrypt filenames
Message-ID: <YGWrKxYOdWgrhOPp@suse.de>
References: <20210326173227.96363-1-jlayton@kernel.org>
 <20210331203520.65916-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210331203520.65916-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 04:35:20PM -0400, Jeff Layton wrote:
> When we do a lookupino to the MDS, we get a filename in the trace.
> ceph_get_name uses that name directly, so we must properly decrypt
> it before copying it to the name buffer.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/export.c | 42 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 11 deletions(-)
> 
> This patch is what's needed to fix the "busy inodes after umount"
> issue I was seeing with xfstest generic/477, and also makes that
> test pass reliably with mounts using -o test_dummy_encryption.

You mentioned this issue the other day on IRC but I couldn't reproduce.

On the other hand, I'm seeing another issue.  Here's a way to reproduce:

- create an encrypted dir 'd' and create a file 'f'
- umount and mount the filesystem
- unlock dir 'd'
- cat d/f
  cat: d/2: No such file or directory

It happens _almost_ every time I do the umount+mount+unlock+cat.  Looks
like ceph_atomic_open() fails to see that directory as encrypted.  I don't
think the problem is on this open itself, but in the unlock because a
simple 'ls' also fails to show the decrypted names.  (On the other end, if
you do an 'ls' _before_ the unlock, everything seems to work fine.)

I didn't had time to dig deeper into this yet, but I don't remember seeing
this behaviour in previous versions of the patchset.

Cheers,
--
Luís

> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index 17d8c8f4ec89..f4e3a17ffc01 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -7,6 +7,7 @@
>  
>  #include "super.h"
>  #include "mds_client.h"
> +#include "crypto.h"
>  
>  /*
>   * Basic fh
> @@ -516,7 +517,9 @@ static int ceph_get_name(struct dentry *parent, char *name,
>  {
>  	struct ceph_mds_client *mdsc;
>  	struct ceph_mds_request *req;
> +	struct inode *dir = d_inode(parent);
>  	struct inode *inode = d_inode(child);
> +	struct ceph_mds_reply_info_parsed *rinfo;
>  	int err;
>  
>  	if (ceph_snap(inode) != CEPH_NOSNAP)
> @@ -528,29 +531,46 @@ static int ceph_get_name(struct dentry *parent, char *name,
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	inode_lock(d_inode(parent));
> -
> +	inode_lock(dir);
>  	req->r_inode = inode;
>  	ihold(inode);
>  	req->r_ino2 = ceph_vino(d_inode(parent));
> -	req->r_parent = d_inode(parent);
> +	req->r_parent = dir;
>  	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
>  	req->r_num_caps = 2;
>  	err = ceph_mdsc_do_request(mdsc, NULL, req);
> +	inode_unlock(dir);
>  
> -	inode_unlock(d_inode(parent));
> +	if (err)
> +		goto out;
>  
> -	if (!err) {
> -		struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
> +	rinfo = &req->r_reply_info;
> +	if (!IS_ENCRYPTED(dir)) {
>  		memcpy(name, rinfo->dname, rinfo->dname_len);
>  		name[rinfo->dname_len] = 0;
> -		dout("get_name %p ino %llx.%llx name %s\n",
> -		     child, ceph_vinop(inode), name);
>  	} else {
> -		dout("get_name %p ino %llx.%llx err %d\n",
> -		     child, ceph_vinop(inode), err);
> -	}
> +		struct fscrypt_str oname = FSTR_INIT(NULL, 0);
> +		struct ceph_fname fname = { .dir	= dir,
> +					    .name	= rinfo->dname,
> +					    .ctext	= rinfo->altname,
> +					    .name_len	= rinfo->dname_len,
> +					    .ctext_len	= rinfo->altname_len };
> +
> +		err = ceph_fname_alloc_buffer(dir, &oname);
> +		if (err < 0)
> +			goto out;
>  
> +		err = ceph_fname_to_usr(&fname, NULL, &oname, NULL);
> +		if (!err) {
> +			memcpy(name, oname.name, oname.len);
> +			name[oname.len] = 0;
> +		}
> +		ceph_fname_free_buffer(dir, &oname);
> +	}
> +out:
> +	dout("get_name %p ino %llx.%llx err %d %s%s\n",
> +		     child, ceph_vinop(inode), err,
> +		     err ? "" : "name ", err ? "" : name);
>  	ceph_mdsc_put_request(req);
>  	return err;
>  }
> -- 
> 2.30.2
> 
