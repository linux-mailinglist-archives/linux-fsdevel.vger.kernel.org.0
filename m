Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63724483A77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 03:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiADCG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 21:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiADCGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:06:54 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458FCC061761;
        Mon,  3 Jan 2022 18:06:54 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4ZDv-00H47P-5m; Tue, 04 Jan 2022 02:06:51 +0000
Date:   Tue, 4 Jan 2022 02:06:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qinghua Jin <qhjin_dev@163.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: fix bug when opening a file with O_DIRECT on a file
 system that does not support it will leave an empty file
Message-ID: <YdOru5u/Vs2+ns7B@zeniv-ca.linux.org.uk>
References: <20220104015358.57443-1-qhjin_dev@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104015358.57443-1-qhjin_dev@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 09:53:58AM +0800, Qinghua Jin wrote:
> Colin Ian King reported the following
> 
> 1. create a minix file system and mount it
> 2. open a file on the file system with O_RDWR | O_CREAT | O_TRUNC | O_DIRECT
> 3. open fails with -EINVAL but leaves an empty file behind.  All other open() failures don't leave the
> failed open files behind.
> 
> The reason is because when checking the O_DIRECT in do_dentry_open, the inode has created, and later err
> processing can't remove the inode:
> 
>         /* NB: we're sure to have correct a_ops only after f_op->open */
>         if (f->f_flags & O_DIRECT) {
>                 if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
>                         return -EINVAL;
>         }
> 
> The patch will check the O_DIRECT before creating the inode in lookup_open function.

NAK.  You are looking at ->a_ops of the parent directory.  Which might have nothing
whatsoever to do with that of a regular file created in it.

IOW, you've removed the check on the file we are opening and replaced it with
random check that just happens to yield negative on minixfs.
