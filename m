Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0A263101
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgIIPxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 11:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbgIIPxh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:53:37 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 598C22064B;
        Wed,  9 Sep 2020 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599666816;
        bh=NejtTJTgmOPiYWyXqDjSjrA5fG/Yl1LvR7QrRHtW+/Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JYVLJ7UoB3HCHINUdWeL2qi2itwdZ9+/TscgnLHNUMc8FqNSr8TrnkmiVAENPk8fq
         jY5jjx8scqDpAOtgIQCdR+NXXqeHl525lj5b06t9QL2Ws+3prdQpsfbL65LqLALFMi
         pbBtjccBFNdr5iz+GrLRwDvi4L5HQFZ06IJEwYdA=
Message-ID: <c4fd5093a5996840e6fe23dc4507760a5ad70624.camel@kernel.org>
Subject: Re: [RFC PATCH v2 12/18] ceph: set S_ENCRYPTED bit if new inode has
 encryption.ctx xattr
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Wed, 09 Sep 2020 11:53:35 -0400
In-Reply-To: <20200908045737.GK68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-13-jlayton@kernel.org>
         <20200908045737.GK68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 21:57 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:31PM -0400, Jeff Layton wrote:
> > This hack fixes a chicken-and-egg problem when fetching inodes from the
> > server. Once we move to a dedicated field in the inode, then this should
> > be able to go away.
> 
> To clarify: while this *could* be the permanent solution, you're planning to
> make ceph support storing an "is inode encrypted?" flag on the server, similar
> to what the local filesystems do with i_flags (since searching the xattrs for
> every inode is much more expensive than a simple flag check)?
> 
> > +#define DUMMY_ENCRYPTION_ENABLED(fsc) ((fsc)->dummy_enc_ctx.ctx != NULL)
> > +
> 
> As I mentioned on an earlier patch, please put the support for the
> "test_dummy_encryption" mount option in a separate patch.  It's best thought of
> separately from the basic fscrypt support.
> 
> >  int ceph_fscrypt_set_ops(struct super_block *sb);
> >  int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> >  				 struct ceph_acl_sec_ctx *as);
> >  
> >  #else /* CONFIG_FS_ENCRYPTION */
> >  
> > +#define DUMMY_ENCRYPTION_ENABLED(fsc) (0)
> > +
> >  static inline int ceph_fscrypt_set_ops(struct super_block *sb)
> >  {
> >  	return 0;
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 651148194316..c1c1fe2547f9 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -964,6 +964,10 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
> >  		ceph_forget_all_cached_acls(inode);
> >  		ceph_security_invalidate_secctx(inode);
> >  		xattr_blob = NULL;
> > +		if ((inode->i_state & I_NEW) &&
> > +		    (DUMMY_ENCRYPTION_ENABLED(mdsc->fsc) ||
> > +		     ceph_inode_has_xattr(ci, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT)))
> > +			inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> 
> The check for DUMMY_ENCRYPTION_ENABLED() here is wrong and should be removed.
> When the filesystem is mounted with test_dummy_encryption, there may be
> unencrypted inodes already on-disk.  Those shouldn't get S_ENCRYPTED set.
> test_dummy_encryption does add some special handling for unencrypted
> directories, but that doesn't require S_ENCRYPTED to be set on them.
> 

I've been working through your comments. Symlinks work now, as long as I
use the fscrypt utility instead of test_dummy_encryption.

When I remove that condition above, then test_dummy_encryption no longer
works.  I think I must be missing some context in how
test_dummy_encryption is supposed to be used.

Suppose I mount a ceph filesystem with -o test_dummy_encryption. The
root inode of the fs is instantiated by going through here, but it's not
marked with S_ENCRYPTED because the root has no context.

How will descendant dentries end up encrypted if this one is not marked
as such?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

