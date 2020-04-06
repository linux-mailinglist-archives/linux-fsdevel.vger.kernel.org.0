Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A539F19F9B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 18:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgDFQHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 12:07:07 -0400
Received: from fieldses.org ([173.255.197.46]:51964 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgDFQHH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:07:07 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E97F01513; Mon,  6 Apr 2020 12:07:06 -0400 (EDT)
Date:   Mon, 6 Apr 2020 12:07:06 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200406160706.GC2147@fieldses.org>
References: <2590640.1585757211@warthog.procyon.org.uk>
 <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login>
 <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login>
 <20200403203024.GB27105@fieldses.org>
 <CAJfpegvxnp8N-o-iTXzj0UnYZbDPfms1zpwcHf1tdhRJ4au3Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegvxnp8N-o-iTXzj0UnYZbDPfms1zpwcHf1tdhRJ4au3Og@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch makes sense to me, thanks!

In the NFS case it's implementing the "mountpoint" export option:

       mountpoint=path

       mp     This option makes it possible to only export a directory  if  it
              has  successfully  been  mounted.   If  no  path  is given (e.g.
              mountpoint or mp) then the export point must  also  be  a  mount
              point.  If it isn't then the export point is not exported.  This
              allows you to be sure that the directory underneath a mountpoint
              will never be exported by accident if, for example, the filesys‐
              tem failed to mount due to a disc error.

              If a path is given (e.g.  mountpoint=/path or mp=/path) then the
              nominated  path  must  be a mountpoint for the exportpoint to be
              exported.

--b.

On Mon, Apr 06, 2020 at 10:35:55AM +0200, Miklos Szeredi wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
> Subject: statx: add mount_root
> 
> Determining whether a path or file descriptor refers to a mountpoint (or
> more precisely a mount root) is not trivial using current tools.
> 
> Add a flag to statx that indicates whether the path or fd refers to the
> root of a mount or not.
> 
> Reported-by: Lennart Poettering <mzxreary@0pointer.de>
> Reported-by: J. Bruce Fields <bfields@fieldses.org>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/stat.c                 |    3 +++
>  include/uapi/linux/stat.h |    1 +
>  2 files changed, 4 insertions(+)
> 
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -172,6 +172,7 @@ struct statx {
>  #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
>  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> +#define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
>  
>  
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -202,6 +202,9 @@ int vfs_statx(int dfd, const char __user
>  	error = vfs_getattr(&path, stat, request_mask, flags);
>  	stat->mnt_id = real_mount(path.mnt)->mnt_id;
>  	stat->result_mask |= STATX_MNT_ID;
> +	if (path.mnt->mnt_root == path.dentry)
> +		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
> +	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
>  	path_put(&path);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;

