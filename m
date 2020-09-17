Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65DB26D228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 06:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIQEPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 00:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQEPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 00:15:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2298C06174A;
        Wed, 16 Sep 2020 21:15:09 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIlK3-000BFY-Og; Thu, 17 Sep 2020 04:15:03 +0000
Date:   Thu, 17 Sep 2020 05:15:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Rich Felker <dalias@libc.org>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfs: block chmod of symlinks
Message-ID: <20200917041503.GT3421308@ZenIV.linux.org.uk>
References: <20200916002157.GO3265@brightrain.aerifal.cx>
 <20200916002253.GP3265@brightrain.aerifal.cx>
 <20200916062553.GB27867@infradead.org>
 <20200917040715.GS3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917040715.GS3421308@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 05:07:15AM +0100, Al Viro wrote:
> On Wed, Sep 16, 2020 at 07:25:53AM +0100, Christoph Hellwig wrote:
> > On Tue, Sep 15, 2020 at 08:22:54PM -0400, Rich Felker wrote:
> > > It was discovered while implementing userspace emulation of fchmodat
> > > AT_SYMLINK_NOFOLLOW (using O_PATH and procfs magic symlinks; otherwise
> > > it's not possible to target symlinks with chmod operations) that some
> > > filesystems erroneously allow access mode of symlinks to be changed,
> > > but return failure with EOPNOTSUPP (see glibc issue #14578 and commit
> > > a492b1e5ef). This inconsistency is non-conforming and wrong, and the
> > > consensus seems to be that it was unintentional to allow link modes to
> > > be changed in the first place.
> > > 
> > > Signed-off-by: Rich Felker <dalias@libc.org>
> > > ---
> > >  fs/open.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 9af548fb841b..cdb7964aaa6e 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -570,6 +570,12 @@ int chmod_common(const struct path *path, umode_t mode)
> > >  	struct iattr newattrs;
> > >  	int error;
> > >  
> > > +	/* Block chmod from getting to fs layer. Ideally the fs would either
> > > +	 * allow it or fail with EOPNOTSUPP, but some are buggy and return
> > > +	 * an error but change the mode, which is non-conforming and wrong. */
> > > +	if (S_ISLNK(inode->i_mode))
> > > +		return -EOPNOTSUPP;
> > 
> > Our usualy place for this would be setattr_prepare.  Also the comment
> > style is off, and I don't think we should talk about buggy file systems
> > here, but a policy to not allow the chmod.  I also suspect the right
> > error value is EINVAL - EOPNOTSUPP isn't really used in normal posix
> > file system interfaces.
> 
> Er...   Wasn't that an ACL-related crap?  XFS calling posix_acl_chmod()
> after it has committed to i_mode change, propagating the error to
> caller of ->notify_change(), IIRC...
> 
> Put it another way, why do we want
>         if (!inode->i_op->set_acl)
>                 return -EOPNOTSUPP;
> in posix_acl_chmod(), when we have
>         if (!IS_POSIXACL(inode))
>                 return 0;
> right next to it?  If nothing else, make that
> 	if (!IS_POSIXACL(inode) || !inode->i_op->get_acl)
> 		return 0;	// piss off - nothing to adjust here

Arrgh...  That'd break shmem and similar filesystems...  Still, it
feels like we should _not_ bother in cases when there's no ACL
for that sucker; after all, if get_acl() returns NULL, we quietly
return 0 and that's it.

How about something like this instead?

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 95882b3f5f62..2339160fabab 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -559,8 +559,6 @@ posix_acl_chmod(struct inode *inode, umode_t mode)
 
 	if (!IS_POSIXACL(inode))
 		return 0;
-	if (!inode->i_op->set_acl)
-		return -EOPNOTSUPP;
 
 	acl = get_acl(inode, ACL_TYPE_ACCESS);
 	if (IS_ERR_OR_NULL(acl)) {
@@ -569,6 +567,10 @@ posix_acl_chmod(struct inode *inode, umode_t mode)
 		return PTR_ERR(acl);
 	}
 
+	if (!inode->i_op->set_acl) {
+		posix_acl_release(acl);
+		return -EOPNOTSUPP;
+	}
 	ret = __posix_acl_chmod(&acl, GFP_KERNEL, mode);
 	if (ret)
 		return ret;
