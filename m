Return-Path: <linux-fsdevel+bounces-25228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E3949FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 08:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39D21C225DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 06:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34261B5817;
	Wed,  7 Aug 2024 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FRY2Rt1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F115E2F5A;
	Wed,  7 Aug 2024 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012434; cv=none; b=hBuJySaqAV9ewXdTI6VQYPAvRKiANhIdZnxi174pQMH8rSX2llxbNA3221AUGbH0LZMKfG6FkITipm4BW66J6dqa6+M+2/uJFsl824wC18Jx26/RKXQgMy4P5aUKe3jzXEoC4fXKMyMyHuP0aiiJHEkelUdpguQ652wPLcv/l2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012434; c=relaxed/simple;
	bh=HexqomGxq4QNblrFAaRU3frGctUtQoVjetodoDFP+ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZic4RxSNEzv9F7XsknmkIWvpDzVlHDBeymJYV1YCIrBoej2LBJ7JUxWj5hXlUzzzaxWdrDPkN7paFbbmg48EeR47mWUA4xXh8HttN19OtFKXEKJv+h+SmM1VyJ5i2Okq4NYRshYBWLktkbGnqPvBu+6pBdQ+P0w9NRJm+S8+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FRY2Rt1c; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jsJQqLqyoht9ZRPg7hY8RhyerLZz2EuFdx93CoJ5IwM=; b=FRY2Rt1c6CwuFhy8FptzMl83pk
	EggkRB+iYddw5p+CG5hBg5Z3R/tSlHPTv/kaHyQcGSHKTn0y8TAhWl+nlx5VZQfE/CWFf3XWdeXy/
	j8Wrt804GA+qZxsH7O1huD9NEw5s9KbtSelik4lw8w/OoylBi696WacGepDOMLg29hvPyf0R2Anjl
	xlWHM9/HmB/Y+zepf1zEQTf1f+CwSxHuAB6g3U8SxRnRrua+BeBUxCTqC9uAUqOapZvF2VYsFZqy0
	+pGBK98IhLzJdL3BVYjzX4OdPtJc9ugRNg8+g0L/CkaxcsUrz9boDaWYeLBkKBNDsg1AQ77wEcWiB
	Hkb5MAoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbaF4-00000002FaH-0eMb;
	Wed, 07 Aug 2024 06:33:50 +0000
Date: Wed, 7 Aug 2024 07:33:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <20240807063350.GV5334@ZenIV>
References: <20240806144628.874350-1-mjguzik@gmail.com>
 <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
 <20240807033820.GS5334@ZenIV>
 <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807062300.GU5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807062300.GU5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 07, 2024 at 07:23:00AM +0100, Al Viro wrote:
> 	After having looked at the problem, how about the following
> series:
> 
> 1/5) lift path_get() *AND* path_put() out of do_dentry_open()
> into the callers.  The latter - conditional upon "do_dentry_open()
> has not set FMODE_OPENED".  Equivalent transformation.
> 
> 2/5) move path_get() we'd lifted into the callers past the
> call of do_dentry_open(), conditionally collapse it with path_put().
> You'd get e.g.
> int vfs_open(const struct path *path, struct file *file)
> {
>         int ret;
> 
>         file->f_path = *path;
>         ret = do_dentry_open(file, NULL);
>         if (!ret) {
>                 /*
>                  * Once we return a file with FMODE_OPENED, __fput() will call
>                  * fsnotify_close(), so we need fsnotify_open() here for
>                  * symmetry.
>                  */
>                 fsnotify_open(file);
>         }
> 	if (file->f_mode & FMODE_OPENED)
> 		path_get(path);
>         return ret;
> }
> 
> Equivalent transformation, provided that nobody is playing silly
> buggers with reassigning ->f_path in their ->open() instances.
> They *really* should not - if anyone does, we'd better catch them
> and fix them^Wtheir code.  Incidentally, if we find any such,
> we have a damn good reason to add asserts in the callers.  As
> in, "if do_dentry_open() has set FMODE_OPENED, it would bloody
> better *not* modify ->f_path".  <greps> Nope, nobody is that
> insane.
> 
> 3/5) split vfs_open_consume() out of vfs_open() (possibly
> named vfs_open_borrow()), replace the call in do_open() with
> calling the new function.
> 
> Trivially equivalent transformation.
> 
> 4/5) Remove conditional path_get() from vfs_open_consume()
> and finish_open().  Add
> 		if (file->f_mode & FMODE_OPENED)
> 			path_get(&nd->path);
> before terminate_walk(nd); in path_openat().
> 
> Equivalent transformation - see
>         if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
>                 dput(nd->path.dentry);
>                 nd->path.dentry = dentry;
>                 return NULL;
>         }
> in lookup_open() (which is where nd->path gets in sync with what
> had been given to do_dentry_open() in finish_open()); in case
> of vfs_open_consume() in do_open() it's in sync from the very
> beginning.  And we never modify nd->path after those points.
> So we can move grabbing it downstream, keeping it under the
> same condition (which also happens to be true only if we'd
> called do_dentry_open(), so for all other paths through the
> whole thing it's a no-op.
> 
> 5/5) replace
> 		if (file->f_mode & FMODE_OPENED)
> 			path_get(&nd->path);
> 		terminate_walk(nd);
> with
> 		if (file->f_mode & FMODE_OPENED) {
> 			nd->path.mnt = NULL;
> 			nd->path.dentry = NULL;
> 		}
> 		terminate_walk(nd);
> Again, an obvious equivalent transformation.

BTW, similar to that, with that we could turn do_o_path()
into

        struct path path;
        int error = path_lookupat(nd, flags, &path);
        if (!error) {
                audit_inode(nd->name, path.dentry, 0);
                error = vfs_open_borrow(&path, file);
		if (!(file->f_mode & FMODE_OPENED))
			path_put(&path);
        }
        return error;
}

and perhaps do something similar in the vicinity of
vfs_tmpfile() / do_o_tmpfile().

