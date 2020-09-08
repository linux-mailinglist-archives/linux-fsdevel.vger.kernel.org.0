Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467732609B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 06:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgIHE5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 00:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgIHE5k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:57:40 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59DA521532;
        Tue,  8 Sep 2020 04:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599541059;
        bh=BXjJ7VTCiw+5SvAud4hMtfbOXgvCXYoA0dr2WWZ7p1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dioSAYdllyFr4SvQIHavMponXd1G5JV9PGNARv1B1en9Qky5OoO5axIj34rCIbUuE
         +H7AQUYAvm0dM5e2MOmGiAzCRCjFVxMUsZh+VsU/AXUcaJ2hxXEkyYWwl++QWPB19M
         +q5Dt2kBfpqHsFPkUSmOWXA8kcYPe5QNSsR4/WAA=
Date:   Mon, 7 Sep 2020 21:57:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 12/18] ceph: set S_ENCRYPTED bit if new inode has
 encryption.ctx xattr
Message-ID: <20200908045737.GK68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-13-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-13-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:31PM -0400, Jeff Layton wrote:
> This hack fixes a chicken-and-egg problem when fetching inodes from the
> server. Once we move to a dedicated field in the inode, then this should
> be able to go away.

To clarify: while this *could* be the permanent solution, you're planning to
make ceph support storing an "is inode encrypted?" flag on the server, similar
to what the local filesystems do with i_flags (since searching the xattrs for
every inode is much more expensive than a simple flag check)?

> +#define DUMMY_ENCRYPTION_ENABLED(fsc) ((fsc)->dummy_enc_ctx.ctx != NULL)
> +

As I mentioned on an earlier patch, please put the support for the
"test_dummy_encryption" mount option in a separate patch.  It's best thought of
separately from the basic fscrypt support.

>  int ceph_fscrypt_set_ops(struct super_block *sb);
>  int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>  				 struct ceph_acl_sec_ctx *as);
>  
>  #else /* CONFIG_FS_ENCRYPTION */
>  
> +#define DUMMY_ENCRYPTION_ENABLED(fsc) (0)
> +
>  static inline int ceph_fscrypt_set_ops(struct super_block *sb)
>  {
>  	return 0;
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 651148194316..c1c1fe2547f9 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -964,6 +964,10 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>  		ceph_forget_all_cached_acls(inode);
>  		ceph_security_invalidate_secctx(inode);
>  		xattr_blob = NULL;
> +		if ((inode->i_state & I_NEW) &&
> +		    (DUMMY_ENCRYPTION_ENABLED(mdsc->fsc) ||
> +		     ceph_inode_has_xattr(ci, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT)))
> +			inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);

The check for DUMMY_ENCRYPTION_ENABLED() here is wrong and should be removed.
When the filesystem is mounted with test_dummy_encryption, there may be
unencrypted inodes already on-disk.  Those shouldn't get S_ENCRYPTED set.
test_dummy_encryption does add some special handling for unencrypted
directories, but that doesn't require S_ENCRYPTED to be set on them.

- Eric
