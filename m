Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3A168261
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 16:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgBUPyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 10:54:52 -0500
Received: from verein.lst.de ([213.95.11.211]:56151 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbgBUPyw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:54:52 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CDAA68BFE; Fri, 21 Feb 2020 16:54:50 +0100 (CET)
Date:   Fri, 21 Feb 2020 16:54:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: remove the kuid/kgid conversion wrappers
Message-ID: <20200221155450.GA9228@lst.de>
References: <20200218210020.40846-1-hch@lst.de> <20200218210020.40846-4-hch@lst.de> <20200221012616.GF9506@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221012616.GF9506@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 05:26:16PM -0800, Darrick J. Wong wrote:
> >  	to->di_format = from->di_format;
> > -	inode->i_uid = xfs_uid_to_kuid(be32_to_cpu(from->di_uid));
> 
> Hmm.  I'm not up on my userns-fu, but right now this is effectively:
> 
> inode->i_uid = make_kuid(&init_user_ns, be32_to_cpu(from->di_uid));
> 
> > -	inode->i_gid = xfs_gid_to_kgid(be32_to_cpu(from->di_gid));
> > +	i_uid_write(inode, be32_to_cpu(from->di_uid));
> 
> Whereas this is:
> 
> inode->i_uid = make_kuid(inode->i_sb->s_user_ns, be32_to_cpu(...));

Yes.  Which is intentional and mentioned in the commit log.

> 
> What happens if s_user_ns != init_user_ns?  Isn't this a behavior
> change?  Granted, it looks like many of the other filesystems use
> i_uid_write so maybe we're the ones who are doing it wrong...?

In that case the uid gets translated.  Which is intentional as it is
done everywhere else and XFS is the ugly ducking out that fails
to properly take the user_ns into account.

> > --- a/fs/xfs/xfs_acl.c
> > +++ b/fs/xfs/xfs_acl.c
> > @@ -67,10 +67,12 @@ xfs_acl_from_disk(
> >  
> >  		switch (acl_e->e_tag) {
> >  		case ACL_USER:
> > -			acl_e->e_uid = xfs_uid_to_kuid(be32_to_cpu(ace->ae_id));
> > +			acl_e->e_uid = make_kuid(&init_user_ns,
> > +						 be32_to_cpu(ace->ae_id));
> 
> And I'm assuming that the "gross layering violation in the vfs xattr
> code" is why it's init_user_ns here?

Yes.  The generic xattr code checks if the attr is one of the ACL ones
in common code before calling into the fs and already translates them,
causing a giant mess.
