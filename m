Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277C818E74F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Mar 2020 08:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgCVHOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Mar 2020 03:14:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56774 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgCVHOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Mar 2020 03:14:24 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9dd6359b34936204; Sun, 22 Mar 2020 08:14:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] hibernate: Allow uswsusp to write to swap
Date:   Sun, 22 Mar 2020 08:14:21 +0100
Message-ID: <5202091.FuziMeULnI@kreacher>
In-Reply-To: <20200304170646.GA31552@dumbo>
References: <20200304170646.GA31552@dumbo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, March 4, 2020 6:06:46 PM CET Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> It turns out that there is one use case for programs being able to
> write to swap devices, and that is the userspace hibernation code.
> 
> Quick fix: disable the S_SWAPFILE check if hibernation is configured.
> 
> Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
> Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Reported-by: Marian Klein <mkleinsoft@gmail.com>
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> v2:
>  - use hibernation_available() instead of IS_ENABLED(CONFIG_HIBERNATE)
>  - make Fixes: point to the right commit

This looks OK to me.

Has it been taken care of already, or am I expected to apply it?

> ---
>  fs/block_dev.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: b/fs/block_dev.c
> ===================================================================
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -34,6 +34,7 @@
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/falloc.h>
>  #include <linux/uaccess.h>
> +#include <linux/suspend.h>
>  #include "internal.h"
>  
>  struct bdev_inode {
> @@ -2001,7 +2002,8 @@ ssize_t blkdev_write_iter(struct kiocb *
>  	if (bdev_read_only(I_BDEV(bd_inode)))
>  		return -EPERM;
>  
> -	if (IS_SWAPFILE(bd_inode))
> +	/* uswsusp needs write permission to the swap */
> +	if (IS_SWAPFILE(bd_inode) && !hibernation_available())
>  		return -ETXTBSY;
>  
>  	if (!iov_iter_count(from))
> 




