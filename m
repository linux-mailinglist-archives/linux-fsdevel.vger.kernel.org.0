Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF42E5E8F4E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 20:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiIXSXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiIXSWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 14:22:54 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5649179A43
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=23lhcfycZqlWXN2AMX4GImlCjeGLWA+8QmriHOTlMDg=; b=mXuTM4dIVFJnEoesECSkPSTk/C
        SrQQYTuZ1DwGexNTYZNWA1LUybCYR2wqvejBGVki1HYaeF998orFeXwUC/BM9rQwRwsbLHED/OU+S
        +ED+e1UdOMtcyW8PWbci1EUtrFcGAB/k21BrQJgYFY61mc+L/dRXFE271/buhAhS7Ed2AM3mvIYdQ
        AVUjGAObzQuuL1OcN1ugRzxArTFNaE4AxtcJ+G7hFyRJOFHsDHAWOWSRw7dsVlsIh/WFltDw4OI0t
        aDJYDlVjBxKk40pMebSR9x13j/zaGFBDvsC6vQW9FB/jeFCzTxFOuiCZDzl4PD79pd1wIA7YlGdqF
        IKrwCEkQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oc9ne-003Ozl-0R;
        Sat, 24 Sep 2022 18:22:50 +0000
Date:   Sat, 24 Sep 2022 19:22:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH 07/29] 9p: implement set acl method
Message-ID: <Yy9K+lTiVF5SiwO0@ZenIV>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-8-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922151728.1557914-8-brauner@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:17:05PM +0200, Christian Brauner wrote:

> +int v9fs_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> +		     struct posix_acl *acl, int type)
> +{
> +	int retval;
> +	void *value = NULL;
> +	size_t size = 0;
> +	struct v9fs_session_info *v9ses;
> +	struct inode *inode = d_inode(dentry);
> +
> +	v9ses = v9fs_dentry2v9ses(dentry);
> +
> +	if (acl) {
> +		retval = posix_acl_valid(inode->i_sb->s_user_ns, acl);
> +		if (retval)
> +			goto err_out;
> +
> +		size = posix_acl_xattr_size(acl->a_count);
> +
> +		value = kzalloc(size, GFP_NOFS);
> +		if (!value) {
> +			retval = -ENOMEM;
> +			goto err_out;
> +		}
> +
> +		retval = posix_acl_to_xattr(&init_user_ns, acl, value, size);
> +		if (retval < 0)
> +			goto err_out;
> +	}
> +
> +	/*
> +	 * set the attribute on the remote. Without even looking at the
> +	 * xattr value. We leave it to the server to validate
> +	 */
> +	if ((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT) {
> +		retval = v9fs_xattr_set(dentry, posix_acl_xattr_name(type),
> +					value, size, 0);
> +		goto err_out;
> +	}

> +	if (S_ISLNK(inode->i_mode))
> +		return -EOPNOTSUPP;
> +	if (!inode_owner_or_capable(&init_user_ns, inode))
> +		return -EPERM;

Shouldn't that chunk have been in the very beginning?  As it is, you've
got a leak here...
