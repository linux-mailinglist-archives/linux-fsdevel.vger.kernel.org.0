Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1488F350C0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhDABo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhDABoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:44:19 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2CC061574;
        Wed, 31 Mar 2021 18:44:19 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRmNW-001WiT-Sb; Thu, 01 Apr 2021 01:44:11 +0000
Date:   Thu, 1 Apr 2021 01:44:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 01/18] vfs: introduce new file range exchange ioctl
Message-ID: <YGUlavtPLH5tZFT/@zeniv-ca.linux.org.uk>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
 <161723933214.3149451.12102627412985512284.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161723933214.3149451.12102627412985512284.stgit@magnolia>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 06:08:52PM -0700, Darrick J. Wong wrote:

> +	ret = vfs_xchg_file_range(file1.file, file2, &args);
> +	if (ret)
> +		goto fdput;
> +
> +	/*
> +	 * The VFS will set RANGE_FSYNC on its own if the file or inode require
> +	 * synchronous writes.  Don't leak this back to userspace.
> +	 */
> +	args.flags &= ~FILE_XCHG_RANGE_FSYNC;
> +	args.flags |= (old_flags & FILE_XCHG_RANGE_FSYNC);
> +
> +	if (copy_to_user(argp, &args, sizeof(args)))
> +		ret = -EFAULT;

Erm...  How is userland supposed to figure out whether that EFAULT
came before or after the operation?  Which of the fields are outputs,
anyway?

> +	/* Don't touch certain kinds of inodes */
> +	if (IS_IMMUTABLE(inode1) || IS_IMMUTABLE(inode2))
> +		return -EPERM;

Append-only should get the same treatment (and IMO if you have
O_APPEND on either file, you should get a failure as well).
