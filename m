Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9078F2286AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 19:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgGURDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbgGURBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:01:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E770C061794;
        Tue, 21 Jul 2020 10:01:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxvdO-00HJt3-0L; Tue, 21 Jul 2020 17:00:54 +0000
Date:   Tue, 21 Jul 2020 18:00:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 21/24] init: add an init_symlink helper
Message-ID: <20200721170053.GV2786714@ZenIV.linux.org.uk>
References: <20200721162818.197315-1-hch@lst.de>
 <20200721162818.197315-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721162818.197315-22-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 06:28:15PM +0200, Christoph Hellwig wrote:
> Add a simple helper to symlink with a kernel space file name and switch
> the early init code over to it.  Remove the now unused ksys_symlink.

> +int __init init_symlink(const char *oldname, const char *newname)
> +{
> +	struct filename *from = getname_kernel(oldname);

What the hell for?  You are only using from ->name later.

> +	struct dentry *dentry;
> +	struct path path;
> +	int error;
> +
> +	if (IS_ERR(from))
> +		return PTR_ERR(from);
> +	dentry = kern_path_create(AT_FDCWD, newname, &path, 0);
> +	error = PTR_ERR(dentry);
> +	if (IS_ERR(dentry))
> +		goto out_putname;
> +	error = security_path_symlink(&path, dentry, from->name);
> +	if (!error)
> +		error = vfs_symlink(path.dentry->d_inode, dentry, from->name);
> +	done_path_create(&path, dentry);
> +out_putname:
> +	putname(from);
> +	return error;
> +}

And again, the same comment regarding the location of file.
