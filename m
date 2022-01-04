Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259074849FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 22:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiADVk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 16:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiADVkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:40:25 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9B1C061761;
        Tue,  4 Jan 2022 13:40:24 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4rXY-00HIuJ-SA; Tue, 04 Jan 2022 21:40:20 +0000
Date:   Tue, 4 Jan 2022 21:40:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix bug when opening a file with O_DIRECT on a
 file system that does not support it will leave an empty file
Message-ID: <YdS+xJMYbBMJBTcH@zeniv-ca.linux.org.uk>
References: <20220104094217.99187-1-qhjin.dev@gmail.com>
 <YdRdBcUAp7Mgp4pV@zeniv-ca.linux.org.uk>
 <CACL7WENRAkZKo5sx5HvRJ_e9KXmM-SyOutb8BAthJzfH1b2vDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACL7WENRAkZKo5sx5HvRJ_e9KXmM-SyOutb8BAthJzfH1b2vDA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 05:23:30AM +0800, Qinghua Jin wrote:
> OK, thanks.
> So, how to resolve this bug? I think we should check the param before
> creating the inode and dentry. Maybe the best place is in the lookup_open
> where the last component get created, and the parent inode and child inode
> is in the same filesystem, so I think we can use
> dir_inode->i_mapping->a_ops->direct_IO to check the O_DIRECT param. The
> code looks like this:
>   if((open_flag & O_CREAT) && (open_flag & O_DIRECT)) {
>     if (!dir_inode->i_mapping || !dir_inode->i_mapping->a_ops ||
>             !dir_inode->i_mapping->a_ops->direct_IO)
>                 return ERR_PTR(-EINVAL);
>     }
> should do the work.

Why would it?  Seriously, why would directories' use of page cache resemble that
by the regular files on the same fs?  Sure, for minixfs we have that - directory
contents there happens to be stored in exact same way as for regular files.
For many other filesystem types it's not true.

Incidentally, how would an inode possibly get NULL ->i_mapping?  Or NULL
->a_ops, for that matter (IOW, the existing check is also partially
cargo-culted)...
