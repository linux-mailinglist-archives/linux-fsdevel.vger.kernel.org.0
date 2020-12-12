Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014352D8899
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 18:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407637AbgLLR0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 12:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406273AbgLLR0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 12:26:15 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB3C0613D6
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 09:25:35 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ko8e8-000ncP-FF; Sat, 12 Dec 2020 17:25:28 +0000
Date:   Sat, 12 Dec 2020 17:25:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file
 open
Message-ID: <20201212172528.GB3579531@ZenIV.linux.org.uk>
References: <20201212165105.902688-1-axboe@kernel.dk>
 <20201212165105.902688-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212165105.902688-5-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 12, 2020 at 09:51:04AM -0700, Jens Axboe wrote:

>  	struct dentry *dentry;
> @@ -3164,17 +3165,38 @@ static const char *open_last_lookups(struct nameidata *nd,
>  	}
>  
>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> -		got_write = !mnt_want_write(nd->path.mnt);
> +		if (nonblock) {
> +			got_write = !mnt_want_write_trylock(nd->path.mnt);
> +			if (!got_write)
> +				return ERR_PTR(-EAGAIN);
> +		} else {
> +			got_write = !mnt_want_write(nd->path.mnt);
> +		}
>  		/*
>  		 * do _not_ fail yet - we might not need that or fail with
>  		 * a different error; let lookup_open() decide; we'll be
>  		 * dropping this one anyway.
>  		 */

Read the comment immediately after the place you are modifying.  Really.
To elaborate: consider e.g. the case when /mnt/foo is a symlink to /tmp/bar,
/mnt is mounted r/o and you are asking to open /mnt/foo for write.  We get
to /mnt, call open_last_lookups() to resolve the last component ("foo") in
it.  And find that the sucker happens to be an absolute symlink, so we need
to jump into root and resolve "tmp/bar" staring from there.  Which is what
the loop in the caller is about.  Eventually we'll get to /tmp and call
open_last_lookups() to resolve "bar" there.  /tmp needs to be mounted
writable; /mnt does not.

Sure, you bail out only in nonblock case, so normally the next time around
it'll go sanely.  But you are making the damn thing (and it's still too
convoluted, even after a lot of massage towards sanity) harder to reason
about.

> +	if (open_flag & O_CREAT) {
> +		if (nonblock) {
> +			if (!inode_trylock(dir->d_inode)) {
> +				dentry = ERR_PTR(-EAGAIN);
> +				goto drop_write;
> +			}
> +		} else {
> +			inode_lock(dir->d_inode);
> +		}
> +	} else {
> +		if (nonblock) {
> +			if (!inode_trylock_shared(dir->d_inode)) {
> +				dentry = ERR_PTR(-EAGAIN);
> +				goto drop_write;
> +			}
> +		} else {
> +			inode_lock_shared(dir->d_inode);
> +		}
> +	}
>  	dentry = lookup_open(nd, file, op, got_write);

... as well as more bloated, with no obvious benefits (take a look
at lookup_open()).
