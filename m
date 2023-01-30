Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E652868060D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 07:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjA3GiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 01:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjA3GiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:38:10 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A48827991
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 22:37:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4400268C7B; Mon, 30 Jan 2023 07:37:07 +0100 (CET)
Date:   Mon, 30 Jan 2023 07:37:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 02/12] xattr, posix acl: add listxattr helpers
Message-ID: <20230130063706.GC31145@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v1-2-6cf155b492b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-2-6cf155b492b6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:28:47PM +0100, Christian Brauner wrote:
> +static inline bool posix_acl_dentry_list(struct dentry *dentry)
> +{
> +	return IS_POSIXACL(d_backing_inode(dentry));
> +}

I find the open coded IS_POSIXACL much easier to read then this.
But if you want this helpers please add a comment on why it exists
and should be used.

> +static inline bool xattr_dentry_list(const struct xattr_handler *handler,
> +				     struct dentry *dentry)
> +{
> +	return handler && (!handler->list || handler->list(dentry));
> +}

This one could also benefit from a comment explaining what it does.
Also the name seems wrong, should be be something like
xattr_handler_can_list?  
