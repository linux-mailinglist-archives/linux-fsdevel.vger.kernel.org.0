Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F805EF02A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiI2IRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiI2IRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:17:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF913E7F2;
        Thu, 29 Sep 2022 01:17:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DB8D68BFE; Thu, 29 Sep 2022 10:17:27 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:17:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 14/29] acl: add vfs_set_acl()
Message-ID: <20220929081727.GB3699@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-15-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928160843.382601-15-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +EXPORT_SYMBOL(vfs_set_acl);

I think all this stackable file system infrastucture should be
EXPORT_SYMBOL_GPL, like a lot of the other internal stuff.

> +int xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
> +		     const char *name, int mask)

Hmm.  The only think ACLs actually need from xattr_permission are
the immutable / append check and the HAS_UNMAPPED_ID one.  I'd rather
open code that, or if you cane come up with a sane name do a smaller
helper rather than doing all the strcmp on the prefixes for now
good reason.

> +static inline int vfs_set_acl(struct user_namespace *mnt_userns,
> +			      struct dentry *dentry, const char *name,
> +			      struct posix_acl *acl)
> +{
> +	return 0;

Should this really return 0 if ACLs are not supported?
