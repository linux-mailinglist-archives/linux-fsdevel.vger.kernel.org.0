Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144441C595B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgEEOYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 10:24:55 -0400
Received: from fieldses.org ([173.255.197.46]:46712 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgEEOYx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 10:24:53 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 397A2BC3; Tue,  5 May 2020 10:24:52 -0400 (EDT)
Date:   Tue, 5 May 2020 10:24:52 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH 09/12] statx: add mount_root
Message-ID: <20200505142452.GB27314@fieldses.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-10-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-10-mszeredi@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 11:59:12AM +0200, Miklos Szeredi wrote:
> Determining whether a path or file descriptor refers to a mountpoint (or
> more precisely a mount root) is not trivial using current tools.
> 
> Add a flag to statx that indicates whether the path or fd refers to the
> root of a mount or not.

A brief summary of the previous discussion might be useful here.
(Comparing st_dev is unreliable for bind mounts; openat2() with
RESOLVE_NO_XDEV works for some use cases but triggers other code
(like security checks and autofs) that are undesirable in other cases:
https://lore.kernel.org/lkml/1450012.1585579399@warthog.procyon.org.uk/T/#ma4516eed1c7507b83343321e3ebd13bba972301c
)

Looks good to me, though.--b.

> 
> Reported-by: Lennart Poettering <mzxreary@0pointer.de>
> Reported-by: J. Bruce Fields <bfields@fieldses.org>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/stat.c                 | 3 +++
>  include/uapi/linux/stat.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 3d88c99f7743..b9faa6cafafe 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -202,6 +202,9 @@ int vfs_statx(int dfd, const char __user *filename, int flags,
>  	error = vfs_getattr(&path, stat, request_mask, flags);
>  	stat->mnt_id = real_mount(path.mnt)->mnt_id;
>  	stat->result_mask |= STATX_MNT_ID;
> +	if (path.mnt->mnt_root == path.dentry)
> +		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
> +	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
>  	path_put(&path);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index d81456247f10..6df9348bb277 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -181,6 +181,7 @@ struct statx {
>  #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
>  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> +#define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
>  
>  
> -- 
> 2.21.1
