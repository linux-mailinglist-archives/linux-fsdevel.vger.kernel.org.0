Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A703C3453CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 01:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhCWAXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 20:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhCWAXP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:23:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A43C4619AA;
        Tue, 23 Mar 2021 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616458995;
        bh=nkXyKoH5tzxY3ZZp2BfQD7Nub4F95PaZoMxm5kRoHAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2jWFrji6uSyaOuVhuBYGdz5yDMxbQOo8xo4R6rZpArE+V0248puk9RsVkblgo7S8
         S9UsgVZNhje3vHMwqMwyYG4t2oANep1ANGMXaacYeEs+dip0iHWCgI4YHaGLLGtg3Q
         nRrLEKWG+oRGYgPsiDnvBBFisfgli/Gs61fkAT6F2ezWiiqa/Kb+18xLEOlsdQwaxL
         ZAua1PkLk9jPUCh1D0oJ6IUO+WXTyaB4Q6k4c+jwk9gdN3AtCaEtI5ywyOA+89+Gqi
         cNRM08tiJwV2D5c7bjfvRDVz2y89eJdqJeLvXY6LygJ0EImp3ppRmGY8TYuZ5bZ6dQ
         nHMOqBIrtxZNw==
Date:   Mon, 22 Mar 2021 17:23:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 01/18] vfs: add miscattr ops
Message-ID: <YFk08XPc2oNWoUWT@gmail.com>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
 <20210203124112.1182614-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203124112.1182614-2-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:40:55PM +0100, Miklos Szeredi wrote:
> + * Verifying attributes involves retrieving current attributes with
> + * i_op->miscattr_get(), this also allows initilaizing attributes that have

initilaizing => initializing

> +int vfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct miscattr old_ma = {};
> +	int err;
> +
> +	if (d_is_special(dentry))
> +		return -ENOTTY;
> +
> +	if (!inode->i_op->miscattr_set)
> +		return -ENOIOCTLCMD;
> +
> +	if (!inode_owner_or_capable(inode))
> +		return -EPERM;

Shouldn't this be EACCES, not EPERM?

> +/**
> + * miscattr_has_xattr - check for extentended flags/attributes

extentended => extended

- Eric
