Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E3D74D8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfGYLux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 07:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfGYLux (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:50:53 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F478229F9;
        Thu, 25 Jul 2019 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564055452;
        bh=lwTJPGPBO29LVdbB8De87KFPeekZCN4ZY7JPRWWWHhE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=I12g6neBh1MSkPKhwUky9LOYVn1xzVT3t+MiyxNF+zVDzqzi3tk7WqWfSKQuTf5gC
         /ZUbsDT9Twod3CQp1y0LQGuCukbn0vpSwO/1+tP/mBT5y4fEPA/owmZM6kByzeavOc
         CzfY5/0Q9UYBT75lnn+GnSXBDYZAEhK6wxia7vFg=
Message-ID: <342087bebc5d1eebadafcda02de067294441cd0d.camel@kernel.org>
Subject: Re: [PATCH 1/1] locks: Fix procfs output for file leases
From:   Jeff Layton <jlayton@kernel.org>
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 25 Jul 2019 07:50:50 -0400
In-Reply-To: <68a58eb885e32c1d7be0b4a531709ba2f33a758e.1563988369.git.asml.silence@gmail.com>
References: <68a58eb885e32c1d7be0b4a531709ba2f33a758e.1563988369.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-07-24 at 20:16 +0300, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Since commit 778fc546f749c588aa2f ("locks: fix tracking of inprogress
> lease breaks"), leases break don't change @fl_type but modifies
> @fl_flags. However, procfs's part haven't been updated.
> 
> Previously, for a breaking lease the target type was printed (see
> target_leasetype()), as returns fcntl(F_GETLEASE). But now it's always
> "READ", as F_UNLCK no longer means "breaking". Unlike the previous
> one, this behaviour don't provide a complete description of the lease.
> 
> There are /proc/pid/fdinfo/ outputs for a lease (the same for READ and
> WRITE) breaked by O_WRONLY.
> -- before:
> lock:   1: LEASE  BREAKING  READ  2558 08:03:815793 0 EOF
> -- after:
> lock:   1: LEASE  BREAKING  UNLCK  2558 08:03:815793 0 EOF
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/locks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 686eae21daf6..24d1db632f6c 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2784,10 +2784,10 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  			       ? (fl->fl_type & LOCK_WRITE) ? "RW   " : "READ "
>  			       : (fl->fl_type & LOCK_WRITE) ? "WRITE" : "NONE ");
>  	} else {
> -		seq_printf(f, "%s ",
> -			       (lease_breaking(fl))
> -			       ? (fl->fl_type == F_UNLCK) ? "UNLCK" : "READ "
> -			       : (fl->fl_type == F_WRLCK) ? "WRITE" : "READ ");
> +		int type = IS_LEASE(fl) ? target_leasetype(fl) : fl->fl_type;
> +
> +		seq_printf(f, "%s ", (type == F_WRLCK) ? "WRITE" :
> +				     (type == F_RDLCK) ? "READ" : "UNLCK");
>  	}
>  	if (inode) {
>  		/* userspace relies on this representation of dev_t */

Thanks! Merged for v5.4.
-- 
Jeff Layton <jlayton@kernel.org>

