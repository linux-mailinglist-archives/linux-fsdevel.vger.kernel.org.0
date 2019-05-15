Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E81E964
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfEOHvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 03:51:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:56810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfEOHvS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 03:51:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E760AD8F;
        Wed, 15 May 2019 07:51:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2E8E21E3CA1; Wed, 15 May 2019 09:51:15 +0200 (CEST)
Date:   Wed, 15 May 2019 09:51:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/4] fs: create simple_remove() helper
Message-ID: <20190515075115.GB11965@quack2.suse.cz>
References: <20190514221901.29125-1-amir73il@gmail.com>
 <20190514221901.29125-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514221901.29125-2-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-05-19 01:18:58, Amir Goldstein wrote:
> There is a common pattern among pseudo filesystems for removing a dentry
> from code paths that are NOT coming from vfs_{unlink,rmdir}, using a
> combination of simple_{unlink,rmdir} and d_delete().
> 
> Create an helper to perform this common operation.  This helper is going
> to be used as a place holder for the new fsnotify_remove() hook.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks like a good idea. One comment below:

> +/*
> + * Unlike simple_unlink/rmdir, this helper is NOT called from vfs_unlink/rmdir.
> + * Caller must guaranty that d_parent and d_name are stable.
> + */
> +int simple_remove(struct inode *dir, struct dentry *dentry)
> +{
> +	int ret;
> +
> +	dget(dentry);
> +	if (d_is_dir(dentry))
> +		ret = simple_rmdir(dir, dentry);
> +	else
> +		ret = simple_unlink(dir, dentry);
> +
> +	if (!ret)
> +		d_delete(dentry);
> +	dput(dentry);

This dget() - dput() pair looks fishy. After some research I understand why
it's needed but I think it deserves a comment like:

	/*
	 * 'simple_' operations get dentry reference on create/mkdir and drop
	 * it on unlink/rmdir. So we have to get dentry reference here to
	 * protect d_delete() from accessing freed dentry.
	 */

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
