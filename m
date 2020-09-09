Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6126345D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 19:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgIIRTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 13:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbgIIRT3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:19:29 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C117206D4;
        Wed,  9 Sep 2020 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599671969;
        bh=pHgbv20ycv59bJxqyA+U6rPfrqeKv2GN7dRnJhn0ljo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MDnax6gU6Si9NOHpgs7J+70cygHHgY4F/fMGO/w7q5zAOd90Dawc9hb6vSK1Um1GO
         h2kPLisicOh7c7vWcRlP4enJ0CF+2zzHWuM8MhNyydhPku9BjCWx/XSJ8m2a9ASGN0
         86YRUm3xEAeWYOa4dmwMT+fg1/LSUfT8SH0m9JL8=
Message-ID: <3e56484187b739cfdfbfbc699ecc82800cbaa92c.camel@kernel.org>
Subject: Re: [RFC PATCH v2 12/18] ceph: set S_ENCRYPTED bit if new inode has
 encryption.ctx xattr
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Wed, 09 Sep 2020 13:19:27 -0400
In-Reply-To: <20200909163352.GC828@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-13-jlayton@kernel.org>
         <20200908045737.GK68127@sol.localdomain>
         <c4fd5093a5996840e6fe23dc4507760a5ad70624.camel@kernel.org>
         <20200909163352.GC828@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-09-09 at 09:33 -0700, Eric Biggers wrote:
> On Wed, Sep 09, 2020 at 11:53:35AM -0400, Jeff Layton wrote:
> > > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > > > index 651148194316..c1c1fe2547f9 100644
> > > > --- a/fs/ceph/inode.c
> > > > +++ b/fs/ceph/inode.c
> > > > @@ -964,6 +964,10 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
> > > >  		ceph_forget_all_cached_acls(inode);
> > > >  		ceph_security_invalidate_secctx(inode);
> > > >  		xattr_blob = NULL;
> > > > +		if ((inode->i_state & I_NEW) &&
> > > > +		    (DUMMY_ENCRYPTION_ENABLED(mdsc->fsc) ||
> > > > +		     ceph_inode_has_xattr(ci, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT)))
> > > > +			inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> > > 
> > > The check for DUMMY_ENCRYPTION_ENABLED() here is wrong and should be removed.
> > > When the filesystem is mounted with test_dummy_encryption, there may be
> > > unencrypted inodes already on-disk.  Those shouldn't get S_ENCRYPTED set.
> > > test_dummy_encryption does add some special handling for unencrypted
> > > directories, but that doesn't require S_ENCRYPTED to be set on them.
> > > 
> > 
> > I've been working through your comments. Symlinks work now, as long as I
> > use the fscrypt utility instead of test_dummy_encryption.
> > 
> > When I remove that condition above, then test_dummy_encryption no longer
> > works.  I think I must be missing some context in how
> > test_dummy_encryption is supposed to be used.
> > 
> > Suppose I mount a ceph filesystem with -o test_dummy_encryption. The
> > root inode of the fs is instantiated by going through here, but it's not
> > marked with S_ENCRYPTED because the root has no context.
> > 
> > How will descendant dentries end up encrypted if this one is not marked
> > as such?
> 
> See fscrypt_prepare_new_inode() (or in current mainline, the logic in
> __ext4_new_inode() and f2fs_may_encrypt()).  Encryption gets inherited if:
> 
> 	IS_ENCRYPTED(dir) || fscrypt_get_dummy_context(dir->i_sb) != NULL
> 
> instead of just:
> 
> 	IS_ENCRYPTED(dir)
> 
> Note that this specifically refers to encryption being *inherited*.
> If !IS_ENCRYPTED(dir), then the directory itself remains unencrypted ---
> that means that the filenames are in the directory aren't encrypted, even if
> they name encrypted files/directories/symlinks.
> 

Ok, I think I get it, but it is a little weird. I would have thought
that test_dummy_encryption would just replace the usage of whatever's in
the xattr with the per-sb one (or maybe only when one doesn't exist).

This is a bit different though, in that the dummy context only comes
into play with newly created inodes. So, if I mount an empty
subdirectory using test_dummy_encryption, you can't encrypt the names at
the root.

I guess that's sort of like how it works with "regular" contexts too,
and that prevents someone clobbering old data mistakenly.

Thanks for the explanation!
-- 
Jeff Layton <jlayton@kernel.org>

