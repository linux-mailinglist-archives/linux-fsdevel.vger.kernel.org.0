Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6670726C659
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgIPRqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 13:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgIPRqX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:46:23 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4249922241;
        Wed, 16 Sep 2020 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600260071;
        bh=wpolOvjqW37XvCaJsodanttdPRliCEAotM78Hsp5R6E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aJoKnzTWuJHYvtYXsXcG8i+W/LVtpUs/iZfGMiRqVYgzR3n+mK7h+dy3F5UuMSojv
         LhAevAzsHyMqoFGqxCnS48ReY4mvuZnt32iFSrRT0CoW2FZZp/lmSV1H0N4Q+AfeEc
         jIB9yB3oh7OKBaGw1SHlS2Qz1sJRu3pGJWRAuCy4=
Message-ID: <37da4f39a987e66bad001f4db75a43661de53919.camel@kernel.org>
Subject: Re: [RFC PATCH v3 09/16] ceph: preallocate inode for ops that may
 create one
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 16 Sep 2020 08:41:10 -0400
In-Reply-To: <20200915013041.GI899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
         <20200914191707.380444-10-jlayton@kernel.org>
         <20200915013041.GI899@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-14 at 18:30 -0700, Eric Biggers wrote:
> On Mon, Sep 14, 2020 at 03:17:00PM -0400, Jeff Layton wrote:
> > @@ -663,6 +658,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
> >  	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
> >  	struct ceph_mds_client *mdsc = fsc->mdsc;
> >  	struct ceph_mds_request *req;
> > +	struct inode *new_inode = NULL;
> >  	struct dentry *dn;
> >  	struct ceph_acl_sec_ctx as_ctx = {};
> >  	bool try_async = ceph_test_mount_opt(fsc, ASYNC_DIROPS);
> > @@ -675,21 +671,21 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
> >  
> >  	if (dentry->d_name.len > NAME_MAX)
> >  		return -ENAMETOOLONG;
> > -
> > +retry:
> >  	if (flags & O_CREAT) {
> >  		if (ceph_quota_is_max_files_exceeded(dir))
> >  			return -EDQUOT;
> > -		err = ceph_pre_init_acls(dir, &mode, &as_ctx);
> > -		if (err < 0)
> > -			return err;
> > -		err = ceph_security_init_secctx(dentry, mode, &as_ctx);
> > -		if (err < 0)
> > +
> > +		new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
> > +		if (IS_ERR(new_inode)) {
> > +			err = PTR_ERR(new_inode);
> >  			goto out_ctx;
> > +		}
> 
> Is the 'goto out_ctx;' correct here?  It looks like it should be
> 'return PTR_ERR(new_inode)'
> 

Yes, it's correct...see below.

> > +/**
> > + * ceph_new_inode - allocate a new inode in advance of an expected create
> > + * @dir: parent directory for new inode
> > + * @mode: mode of new inode
> > + */
> > +struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
> > +			     umode_t *mode, struct ceph_acl_sec_ctx *as_ctx)
> 
> Some parameters aren't documented.
> 

Thanks, fixed.

> > +	int err;
> >  	struct inode *inode;
> >  
> > -	inode = iget5_locked(sb, (unsigned long)vino.ino, ceph_ino_compare,
> > -			     ceph_set_ino_cb, &vino);
> > +	inode = new_inode_pseudo(dir->i_sb);
> >  	if (!inode)
> >  		return ERR_PTR(-ENOMEM);
> >  
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
> 
> Should this be freeing anything from the ceph_acl_sec_ctx on error?
> 

For now, I'm leaving that to the callers. It's arguably uglier to do it
that way but ceph_release_acl_sec_ctx needs to be called at the end of
the callers anyway, and it's not currently idempotent.

-- 
Jeff Layton <jlayton@kernel.org>

