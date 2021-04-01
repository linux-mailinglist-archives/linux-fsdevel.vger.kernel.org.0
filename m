Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACA5352181
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 23:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhDAVSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 17:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234065AbhDAVSp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:18:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E16F0610A0;
        Thu,  1 Apr 2021 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617311926;
        bh=Zgmmd5hzP1ieDt7VbAxwl8OOV3LmW5efkdClsJU5rUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbO6mk/bB0mFPmOeL9NjtIM+LQW9B1ejrfan62mSTB9TRf6NAB0WZQmiUJeljydLe
         DAuF8xu/JQCpQ2nDj1IeDrSTTAvAEou7uRMPQLx5JFADOvrZjlgPqzLTaEmiHs/Xy9
         XjX2OvXou5bRPKFkFAknTOUREe5uKkkawncfONSwQr5X6tb57TEfFZoXZyFA1I6Unn
         A5tCz1qw017KsQ5hhjgKTg/8CboIFmwFYON530mQi7pAtYHAhEg/NE6EiWqABLInt6
         SEmzm0rawcAuy8LSrQYfZK3mck+E3kkRjbkt+vzwLKZSuB4GSiAHYdZjpDJaKZ8hx0
         rpBX6PCazs6eA==
Date:   Thu, 1 Apr 2021 14:18:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 01/18] vfs: introduce new file range exchange ioctl
Message-ID: <20210401211845.GE4090233@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
 <161723933214.3149451.12102627412985512284.stgit@magnolia>
 <YGUlavtPLH5tZFT/@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGUlavtPLH5tZFT/@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:44:10AM +0000, Al Viro wrote:
> On Wed, Mar 31, 2021 at 06:08:52PM -0700, Darrick J. Wong wrote:
> 
> > +	ret = vfs_xchg_file_range(file1.file, file2, &args);
> > +	if (ret)
> > +		goto fdput;
> > +
> > +	/*
> > +	 * The VFS will set RANGE_FSYNC on its own if the file or inode require
> > +	 * synchronous writes.  Don't leak this back to userspace.
> > +	 */
> > +	args.flags &= ~FILE_XCHG_RANGE_FSYNC;
> > +	args.flags |= (old_flags & FILE_XCHG_RANGE_FSYNC);
> > +
> > +	if (copy_to_user(argp, &args, sizeof(args)))
> > +		ret = -EFAULT;
> 
> Erm...  How is userland supposed to figure out whether that EFAULT
> came before or after the operation?  Which of the fields are outputs,
> anyway?

Come to think of it, none of the fields are outputs, so this whole block
can go away.  Thanks for noticing that. :)

> > +	/* Don't touch certain kinds of inodes */
> > +	if (IS_IMMUTABLE(inode1) || IS_IMMUTABLE(inode2))
> > +		return -EPERM;
> 
> Append-only should get the same treatment (and IMO if you have

Assuming you meant IS_APPEND, I thought we only checked that at open
time, as part of requiring O_APPEND?

> O_APPEND on either file, you should get a failure as well).

generic_rw_checks (which is called by do_xchg_file_range) will send back
-EBADF if the file descriptors are O_APPEND.

--D
