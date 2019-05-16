Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3069620678
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfEPLzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:55:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbfEPLzi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:55:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22EC8ACAA;
        Thu, 16 May 2019 11:55:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B561DA86C; Thu, 16 May 2019 13:56:36 +0200 (CEST)
Date:   Thu, 16 May 2019 13:56:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 10/14] fsnotify: call fsnotify_rmdir() hook from btrfs
Message-ID: <20190516115635.GY3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20190516102641.6574-1-amir73il@gmail.com>
 <20190516102641.6574-11-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516102641.6574-11-amir73il@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 01:26:37PM +0300, Amir Goldstein wrote:
> This will allow generating fsnotify delete events after the
> fsnotify_nameremove() hook is removed from d_delete().
> 
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/btrfs/ioctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6dafa857bbb9..2cfd1bfb3871 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2930,8 +2930,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  	inode_lock(inode);
>  	err = btrfs_delete_subvolume(dir, dentry);
>  	inode_unlock(inode);
> -	if (!err)
> +	if (!err) {
> +		fsnotify_rmdir(dir, dentry);
>  		d_delete(dentry);

Ok, this is the only instance of d_delete.

Acked-by: David Sterba <dsterba@suse.com>
