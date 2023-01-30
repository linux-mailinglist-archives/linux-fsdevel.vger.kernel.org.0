Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06A46805F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 07:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjA3Gf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 01:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjA3Gf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:35:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680611ABD4
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 22:35:25 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 148CB68BEB; Mon, 30 Jan 2023 07:35:22 +0100 (CET)
Date:   Mon, 30 Jan 2023 07:35:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 01/12] xattr: simplify listxattr helpers
Message-ID: <20230130063521.GB31145@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v1-1-6cf155b492b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-1-6cf155b492b6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:28:46PM +0100, Christian Brauner wrote:
> +static int xattr_list_one(char **buffer, ssize_t *remaining_size,
> +			  const char *name)
> +{
> +	size_t len = strlen(name) + 1;
> +	if (*buffer) {

Empty line after the variable declaraion(s), please.

> +static int posix_acl_listxattr(struct inode *inode, char **buffer,
> +			       ssize_t *remaining_size)
> +{
> +#ifdef CONFIG_FS_POSIX_ACL

This function should go into posix_acl.c, with a stub in the header
instead of the ifdef.

> +	err = posix_acl_listxattr(d_inode(dentry), &buffer, &remaining_size);
> +	if (err)
> +		return err;

And I suspect the call to posix_acl_listxattr should move into the caller in
the VFS instead of the method, just like ACLs are handled in
the get/set side.
