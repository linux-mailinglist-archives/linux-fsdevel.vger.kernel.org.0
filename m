Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7C568061B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 07:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjA3Gnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 01:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjA3Gne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:43:34 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDA31423B
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 22:43:33 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC23968BEB; Mon, 30 Jan 2023 07:43:29 +0100 (CET)
Date:   Mon, 30 Jan 2023 07:43:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 05/12] erofs: drop posix acl handlers
Message-ID: <20230130064329.GF31145@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v1-5-6cf155b492b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-5-6cf155b492b6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This review is not for erofs specifically, but for all file systems using
the same scheme.

> +static const char *erofs_xattr_prefix(int xattr_index, struct dentry *dentry)
> +{
> +	const char *name = NULL;
> +	const struct xattr_handler *handler = NULL;
> +
> +	switch (xattr_index) {
> +	case EROFS_XATTR_INDEX_USER:
> +		handler = &erofs_xattr_user_handler;
> +		break;
> +	case EROFS_XATTR_INDEX_TRUSTED:
> +		handler = &erofs_xattr_trusted_handler;
> +		break;
> +#ifdef CONFIG_EROFS_FS_SECURITY
> +	case EROFS_XATTR_INDEX_SECURITY:
> +		handler = &erofs_xattr_security_handler;
> +		break;
> +#endif
> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> +	case EROFS_XATTR_INDEX_POSIX_ACL_ACCESS:
> +		if (posix_acl_dentry_list(dentry))
> +			name = XATTR_NAME_POSIX_ACL_ACCESS;
> +		break;
> +	case EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT:
> +		if (posix_acl_dentry_list(dentry))
> +			name = XATTR_NAME_POSIX_ACL_DEFAULT;
> +		break;
> +#endif
> +	default:
> +		return NULL;
> +	}
> +
> +	if (xattr_dentry_list(handler, dentry))
> +		name = xattr_prefix(handler);

I'm not a huge fan of all this duplicate logic in the file systems
that is more verbose and a bit confusing.  Until we remove the
xattr handlers entirely, I wonder if we just need to keep a
special ->list for posix xattrs, just to be able to keep the
old logic in all these file system.  That is a ->list that
works for xattr_dentry_list, but never actually lists anything.

That would remove all this boiler plate for now without minimal
core additions.  Eventually we can hopefully remove first ->list
and then the xattr handlers entirely, but until then this seems
like a step backwards.
