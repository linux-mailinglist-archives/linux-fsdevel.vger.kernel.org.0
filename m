Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257955E9B4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 09:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiIZH5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 03:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiIZH5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40F840E09
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 00:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64CA56187F
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 07:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CA4C433C1;
        Mon, 26 Sep 2022 07:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664178667;
        bh=Br+kEjrCm2Xv3HFYwhTAWI+LQ3pOYKeHDiJTqf2tbAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJq9JmmPBUxK+hw1ySG+SLXF9TgzInmhGIEj8L6ObtlX8QAxiIRJBSqXR+K2OhBnq
         qYOdeTqBvR/Se7xFtKwiEP60Pm3x43RNOFlzgluanhKF9f3t1dFyWPZhkXIGlI6Kvb
         sLHjS/WfOzjFeu1bBQgeD6KIHUdpLEiiUxwWUAlu57B/N2Sk1PBCYEn4vN7W1d4mNj
         VElnMXfBvmeaGXGDPRrGTVoY0hT10is+8bSFZgH+awbMUk/3XQLbY+MfiLBX4ROW6Y
         tcl7XJS6Q7mw7GBSD2ublYeUtQk/vsZiNRcL/k8AH8iuMwtXDeKuAbSlO8QdUcsh+W
         P4qbFg1SuP2FQ==
Date:   Mon, 26 Sep 2022 09:51:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH 07/29] 9p: implement set acl method
Message-ID: <20220926075102.xfn373uyjsoqm7bi@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-8-brauner@kernel.org>
 <Yy9K+lTiVF5SiwO0@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy9K+lTiVF5SiwO0@ZenIV>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 24, 2022 at 07:22:50PM +0100, Al Viro wrote:
> On Thu, Sep 22, 2022 at 05:17:05PM +0200, Christian Brauner wrote:
> 
> > +int v9fs_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > +		     struct posix_acl *acl, int type)
> > +{
> > +	int retval;
> > +	void *value = NULL;
> > +	size_t size = 0;
> > +	struct v9fs_session_info *v9ses;
> > +	struct inode *inode = d_inode(dentry);
> > +
> > +	v9ses = v9fs_dentry2v9ses(dentry);
> > +
> > +	if (acl) {
> > +		retval = posix_acl_valid(inode->i_sb->s_user_ns, acl);
> > +		if (retval)
> > +			goto err_out;
> > +
> > +		size = posix_acl_xattr_size(acl->a_count);
> > +
> > +		value = kzalloc(size, GFP_NOFS);
> > +		if (!value) {
> > +			retval = -ENOMEM;
> > +			goto err_out;
> > +		}
> > +
> > +		retval = posix_acl_to_xattr(&init_user_ns, acl, value, size);
> > +		if (retval < 0)
> > +			goto err_out;
> > +	}
> > +
> > +	/*
> > +	 * set the attribute on the remote. Without even looking at the
> > +	 * xattr value. We leave it to the server to validate
> > +	 */
> > +	if ((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT) {
> > +		retval = v9fs_xattr_set(dentry, posix_acl_xattr_name(type),
> > +					value, size, 0);
> > +		goto err_out;
> > +	}
> 
> > +	if (S_ISLNK(inode->i_mode))
> > +		return -EOPNOTSUPP;
> > +	if (!inode_owner_or_capable(&init_user_ns, inode))
> > +		return -EPERM;
> 
> Shouldn't that chunk have been in the very beginning?  As it is, you've
> got a leak here...

Good catch, I probably messed up the merge conflict resolution in my
last rebase... Thanks for spotting!
