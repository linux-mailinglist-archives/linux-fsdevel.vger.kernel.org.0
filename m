Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA545E8F13
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 19:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiIXR5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 13:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiIXR4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:56:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92F57272
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lt6D1A3ndshgspWp6qBlwmMK4P4FZw6X5SqG/DnPQJY=; b=H6sZbo8J35NFdWjQhLRvCF8UIi
        akPYvEAzUIAdxGbmUEvUxVyY5etA7WJAanszF568vRIrLnsDlHgGEIHl66HOMQp6HeDsTHE0csmZS
        hTc3sGc5NUDB8vs5Sw/PlopT4Yv/n/guvvQeyNHszpV1zo3MRyrg1FUooYmFaiYRxVeBqS/Rk4kL1
        6ZpZSVUW9W6sjU7Z/y8IKlqGg/5etXEA40kWbZekWK5n4QpiLC413C488eulns66dJlNRrDtQcEvA
        ZVamt+RX6TM7O6uYjMb1miKa5+HH9WMLbAOvOmaukiybwSh9pvMHEBTD5qE5vfRBtwZJxrNxDrHRN
        hypY4Q5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oc9OT-003OQO-1x;
        Sat, 24 Sep 2022 17:56:49 +0000
Date:   Sat, 24 Sep 2022 18:56:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH 06/29] 9p: implement get acl method
Message-ID: <Yy9E4T0HT6hEmpoZ@ZenIV>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-7-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922151728.1557914-7-brauner@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:17:04PM +0200, Christian Brauner wrote:

> -static struct posix_acl *__v9fs_get_acl(struct p9_fid *fid, char *name)
> +static int v9fs_fid_get_acl(struct p9_fid *fid, const char *name,
> +			    struct posix_acl **kacl)
>  {
>  	ssize_t size;
>  	void *value = NULL;
>  	struct posix_acl *acl = NULL;
>  
>  	size = v9fs_fid_xattr_get(fid, name, NULL, 0);
> -	if (size > 0) {
> -		value = kzalloc(size, GFP_NOFS);
> -		if (!value)
> -			return ERR_PTR(-ENOMEM);
> -		size = v9fs_fid_xattr_get(fid, name, value, size);
> -		if (size > 0) {
> -			acl = posix_acl_from_xattr(&init_user_ns, value, size);
> -			if (IS_ERR(acl))
> -				goto err_out;
> -		}
> -	} else if (size == -ENODATA || size == 0 ||
> -		   size == -ENOSYS || size == -EOPNOTSUPP) {
> -		acl = NULL;
> -	} else
> -		acl = ERR_PTR(-EIO);
> +	if (size <= 0)
> +		goto out;
>  
> -err_out:
> +	/* just return the size */
> +	if (!kacl)
> +		goto out;

How can that happen?  Both callers are passing addresses of local variables
as the third argument.  And what's the point of that kacl thing, anyway?
Same callers would be much happier if you returned acl or ERR_PTR()...

> +	value = kzalloc(size, GFP_NOFS);
> +	if (!value) {
> +		size = -ENOMEM;
> +		goto out;
> +	}
> +
> +	size = v9fs_fid_xattr_get(fid, name, value, size);
> +	if (size <= 0)
> +		goto out;
> +
> +	acl = posix_acl_from_xattr(&init_user_ns, value, size);
> +	if (IS_ERR(acl)) {
> +		size = PTR_ERR(acl);
> +		goto out;
> +	}
> +	*kacl = acl;
> +
> +out:
>  	kfree(value);
> +	return size;
> +}

Compare that (and callers of that helper) with

static struct posix_acl *v9fs_fid_get_acl(struct p9_fid *fid, const char *name)
{
	ssize_t size;
	void *value;
	struct posix_acl *acl;

	size = v9fs_fid_xattr_get(fid, name, NULL, 0);
	if (size <= 0)
		return ERR_PTR(size);

	value = kzalloc(size, GFP_NOFS);
	if (!value)
		return ERR_PTR(-ENOMEM);

	size = v9fs_fid_xattr_get(fid, name, value, size);
	if (size > 0)
		acl = posix_acl_from_xattr(&init_user_ns, value, size);
	else
		acl = ERR_PTR(size);
	kfree(value);
	return acl;
}

static struct posix_acl *v9fs_acl_get(struct dentry *dentry, const char *name)
{
	struct p9_fid *fid;
	struct posix_acl *acl;

	fid = v9fs_fid_lookup(dentry);
	if (IS_ERR(fid))
		return ERR_CAST(fid);

	acl = v9fs_fid_get_acl(fid, name);
	p9_fid_put(fid);
  	return acl;
}
  
static struct posix_acl *__v9fs_get_acl(struct p9_fid *fid, const char *name)
{
	struct posix_acl *acl = v9fs_fid_get_acl(fid, name);

	if (IS_ERR(acl)) {
		if (acl == ERR_PTR(-ENODATA) || acl == ERR_PTR(-ENOSYS) ||
		    acl == ERR_PTR(-EOPNOTSUPP))
			acl = NULL;
		else
			acl = ERR_PTR(-EIO);
	}
	return acl;
}
