Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973A92286D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgGURKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgGURKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:10:40 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67F4C061794;
        Tue, 21 Jul 2020 10:10:39 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxvmm-00HKD7-K6; Tue, 21 Jul 2020 17:10:36 +0000
Date:   Tue, 21 Jul 2020 18:10:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 16/24] init: add an init_chroot helper
Message-ID: <20200721171036.GX2786714@ZenIV.linux.org.uk>
References: <20200721162818.197315-1-hch@lst.de>
 <20200721162818.197315-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721162818.197315-17-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 06:28:10PM +0200, Christoph Hellwig wrote:

> +int __init init_chroot(const char *filename)
> +{
> +	struct path path;
> +	int error;
> +
> +	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
> +	if (error)
> +		return error;
> +	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);

Matter of taste, but if we do that, I wonder if we would be better off with
	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
	if (!error && !ns_capable(current_user_ns(), CAP_SYS_CHROOT))
		error = -EPERM;
	if (!error)
		error = security_path_chroot(&path);
	if (!error)
		set_fs_root(current->fs, &path);
	path_put(&path);
	return error;

