Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1EE3BE798
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 14:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhGGMHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 08:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhGGMHv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:07:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C50761C9A;
        Wed,  7 Jul 2021 12:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625659511;
        bh=ZeEK/ANtvXr8EHIm8i6aKLUByrXcuhCmz28gAy3bRRA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JmICjisPm4NaoBdFpON77MdX4Eqy2ypLmKJ75mCIW7LkJNfMYj8TstFSN/j7NBmzg
         /X5BGd3hURpWc2wwIyk92IRVRBgwgELh2iCHwdHI5mCI2YIYAzAOzF31usVnQHWruf
         ym0NCdZC/1QzNiN07RGsCKRV8l2IA5TWqeJ0iO6QWZlp+P0DSYIxuOsPH5Pwq9ABMD
         HONbG4hhcfr/FoCKlYGGMzb1wlSbvegMUCd1K5SejjBMznEUNb3ROKVaz2b0TP44xu
         8pLimX4Ws19o9Iq6YMDDjPXGHNztzZRJqNVnM4SryAY+CtC7EHBDKDVkvhLXhlyB/0
         B7JNZX8JQLbqg==
Message-ID: <dc1145b9cf18cc0996d9e47d69ebbc51294c93d9.camel@kernel.org>
Subject: Re: [RFC PATCH v7 05/24] ceph: preallocate inode for ops that may
 create one
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 07 Jul 2021 08:05:09 -0400
In-Reply-To: <83dcbc5c-7a87-b6cd-b364-2ca4aa5bd440@redhat.com>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-6-jlayton@kernel.org>
         <83dcbc5c-7a87-b6cd-b364-2ca4aa5bd440@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 11:37 +0800, Xiubo Li wrote:
> On 6/25/21 9:58 PM, Jeff Layton wrote:
> > When creating a new inode, we need to determine the crypto context
> > before we can transmit the RPC. The fscrypt API has a routine for getting
> > a crypto context before a create occurs, but it requires an inode.
> > 
> > Change the ceph code to preallocate an inode in advance of a create of
> > any sort (open(), mknod(), symlink(), etc). Move the existing code that
> > generates the ACL and SELinux blobs into this routine since that's
> > mostly common across all the different codepaths.
> > 
> > In most cases, we just want to allow ceph_fill_trace to use that inode
> > after the reply comes in, so add a new field to the MDS request for it
> > (r_new_inode).
> > 
> > The async create codepath is a bit different though. In that case, we
> > want to hash the inode in advance of the RPC so that it can be used
> > before the reply comes in. If the call subsequently fails with
> > -EJUKEBOX, then just put the references and clean up the as_ctx. Note
> > that with this change, we now need to regenerate the as_ctx when this
> > occurs, but it's quite rare for it to happen.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ceph/dir.c        | 70 ++++++++++++++++++++-----------------
> >   fs/ceph/file.c       | 62 ++++++++++++++++++++-------------
> >   fs/ceph/inode.c      | 82 ++++++++++++++++++++++++++++++++++++++++----
> >   fs/ceph/mds_client.c |  3 +-
> >   fs/ceph/mds_client.h |  1 +
> >   fs/ceph/super.h      |  7 +++-
> >   6 files changed, 160 insertions(+), 65 deletions(-)
> > 
> [...]
> 
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index eb562e259347..f62785e4dbcb 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -52,17 +52,85 @@ static int ceph_set_ino_cb(struct inode *inode, void *data)
> >   	return 0;
> >   }
> >   
> > -struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino)
> > +/**
> > + * ceph_new_inode - allocate a new inode in advance of an expected create
> > + * @dir: parent directory for new inode
> > + * @dentry: dentry that may eventually point to new inode
> > + * @mode: mode of new inode
> > + * @as_ctx: pointer to inherited security context
> > + *
> > + * Allocate a new inode in advance of an operation to create a new inode.
> > + * This allocates the inode and sets up the acl_sec_ctx with appropriate
> > + * info for the new inode.
> > + *
> > + * Returns a pointer to the new inode or an ERR_PTR.
> > + */
> > +struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
> > +			     umode_t *mode, struct ceph_acl_sec_ctx *as_ctx)
> > +{
> > +	int err;
> > +	struct inode *inode;
> > +
> > +	inode = new_inode_pseudo(dir->i_sb);
> > +	if (!inode)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	if (!S_ISLNK(*mode)) {
> > +		err = ceph_pre_init_acls(dir, mode, as_ctx);
> > +		if (err < 0)
> > +			goto out_err;
> > +	}
> > +
> > +	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
> > +	if (err < 0)
> > +		goto out_err;
> > +
> > +	inode->i_state = 0;
> > +	inode->i_mode = *mode;
> > +	return inode;
> > +out_err:
> > +	iput(inode);
> > +	return ERR_PTR(err);
> > +}
> > +
> > +void ceph_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as_ctx)
> > +{
> > +	if (as_ctx->pagelist) {
> > +		req->r_pagelist = as_ctx->pagelist;
> > +		as_ctx->pagelist = NULL;
> > +	}
> > +}
> > +
> > +/**
> > + * ceph_get_inode - find or create/hash a new inode
> > + * @sb: superblock to search and allocate in
> > + * @vino: vino to search for
> > + * @newino: optional new inode to insert if one isn't found (may be NULL)
> > + *
> > + * Search for or insert a new inode into the hash for the given vino, and return a
> > + * reference to it. If new is non-NULL, its reference is consumed.
> > + */
> > +struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino, struct inode *newino)
> >   {
> >   	struct inode *inode;
> >   
> >   	if (ceph_vino_is_reserved(vino))
> >   		return ERR_PTR(-EREMOTEIO);
> >   
> > -	inode = iget5_locked(sb, (unsigned long)vino.ino, ceph_ino_compare,
> > -			     ceph_set_ino_cb, &vino);
> > -	if (!inode)
> > +	if (newino) {
> > +		inode = inode_insert5(newino, (unsigned long)vino.ino, ceph_ino_compare,
> > +					ceph_set_ino_cb, &vino);
> > +		if (inode != newino)
> > +			iput(newino);
> > +	} else {
> > +		inode = iget5_locked(sb, (unsigned long)vino.ino, ceph_ino_compare,
> > +				     ceph_set_ino_cb, &vino);
> > +	}
> > +
> > +	if (!inode) {
> > +		dout("No inode found for %llx.%llx\n", vino.ino, vino.snap);
> >   		return ERR_PTR(-ENOMEM);
> > +	}
> >   
> >   	dout("get_inode on %llu=%llx.%llx got %p new %d\n", ceph_present_inode(inode),
> >   	     ceph_vinop(inode), inode, !!(inode->i_state & I_NEW));
> > @@ -78,7 +146,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
> >   		.ino = ceph_ino(parent),
> >   		.snap = CEPH_SNAPDIR,
> >   	};
> > -	struct inode *inode = ceph_get_inode(parent->i_sb, vino);
> > +	struct inode *inode = ceph_get_inode(parent->i_sb, vino, NULL);
> >   	struct ceph_inode_info *ci = ceph_inode(inode);
> >   
> >   	if (IS_ERR(inode))
> 
> Should we always check this just before using it before 'struct 
> ceph_inode_info *ci = ceph_inode(inode);' ?
> 
> But it seems the 'ceph_inode()' won't introduce any issue here.
> 
> Thanks,
> 

Yeah, it's just doing pointer math. If it turns out to be an error,
it'll exit before it ever dereferences "ci".


> > @@ -1546,7 +1614,7 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
> >   		vino.ino = le64_to_cpu(rde->inode.in->ino);
> >   		vino.snap = le64_to_cpu(rde->inode.in->snapid);
> >   
> > -		in = ceph_get_inode(req->r_dentry->d_sb, vino);
> > +		in = ceph_get_inode(req->r_dentry->d_sb, vino, NULL);
> >   		if (IS_ERR(in)) {
> >   			err = PTR_ERR(in);
> >   			dout("new_inode badness got %d\n", err);
> > @@ -1748,7 +1816,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
> >   		if (d_really_is_positive(dn)) {
> >   			in = d_inode(dn);
> >   		} else {
> > -			in = ceph_get_inode(parent->d_sb, tvino);
> > +			in = ceph_get_inode(parent->d_sb, tvino, NULL);
> >   			if (IS_ERR(in)) {
> >   				dout("new_inode badness\n");
> >   				d_drop(dn);
> [...]
> 

-- 
Jeff Layton <jlayton@kernel.org>

