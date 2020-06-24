Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5B5206BDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 07:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbgFXFmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 01:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388470AbgFXFmj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:42:39 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB01720768;
        Wed, 24 Jun 2020 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592977359;
        bh=fHdY9nn8NgJ9JVY0fSdYkbZ9nf7LPBc7XBKSfqLQLKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqTgVkoO7ugKxbBCHnVIerXa56LTd+UjeSduGt5xrC9wVZYLMSDLRHe5prmgK9bSs
         w26715uwkfKDky4fGd86IXyd/REcd+htJsdcqPsptwZiIvuaZgf4+wJ46fh1yiRtFC
         uofq/Ed5ofwshr3zNAKS7TkxWxOI/HJe+vwKUgCs=
Date:   Tue, 23 Jun 2020 22:42:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v9 2/4] fs: Add standard casefolding support
Message-ID: <20200624054237.GF844@sol.localdomain>
References: <20200624043341.33364-1-drosen@google.com>
 <20200624043341.33364-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624043341.33364-3-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:33:39PM -0700, Daniel Rosenberg wrote:
> This adds general supporting functions for filesystems that use
> utf8 casefolding. It provides standard dentry_operations and adds the
> necessary structures in struct super_block to allow this standardization.
> 
> Ext4 and F2fs will switch to these common implementations.

It would be helpful to explicitly call out anything that's "new" in this commit,
i.e. anything that isn't simply moving code into the libfs with no behavior
changes.  There's the change of ->d_hash() to use utf8_casefold_hash() instead
of allocating memory; that's not present in the ext4 and f2fs versions.

There's also the change of needs_casefold() to be aware of encrypt+casefold.
(Maybe that small change would better belong in a later patchset that actually
introduces encrypt+casefold support?)

Anything else?

> +/**
> + * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
> + * @dentry:	dentry whose name we are hashing
> + * @str:	qstr of name whose hash we should fill in
> + *
> + * Return: 0 if hash was successful, or -ERRNO
> + */

It also returns 0 if the hashing was not done because it wants to fallback to
the standard hashing.

> +static inline bool needs_casefold(const struct inode *dir)
> +{
> +	return 0;
> +}

The return type is bool, so it should 'return false', not 'return 0'.

- Eric
