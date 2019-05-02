Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6200F11B9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEBOjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 10:39:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56282 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfEBOjH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 10:39:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7599CAD8C;
        Thu,  2 May 2019 14:39:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 183761E0D71; Thu,  2 May 2019 16:39:05 +0200 (CEST)
Date:   Thu, 2 May 2019 16:39:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Steve French <smfrench@gmail.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] network fs notification
Message-ID: <20190502143905.GA25032@quack2.suse.cz>
References: <20190501205541.GC30899@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501205541.GC30899@veci.piliscsaba.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-05-19 16:55:41, Miklos Szeredi wrote:
> This is a really really trivial first iteration, but I think it's enough to
> try out CIFS notification support.  Doesn't deal with mark deletion, but
> that's best effort anyway: fsnotify() will filter out unneeded events.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c |    6 +++++-
>  fs/notify/inotify/inotify_user.c   |    2 ++
>  include/linux/fs.h                 |    1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1041,9 +1041,13 @@ static int do_fanotify_mark(int fanotify
>  		else if (mark_type == FAN_MARK_FILESYSTEM)
>  			ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
>  						   flags, fsid);
> -		else
> +		else {
>  			ret = fanotify_add_inode_mark(group, inode, mask,
>  						      flags, fsid);
> +
> +			if (!ret && inode->i_op->notify_update)
> +				inode->i_op->notify_update(inode);
> +		}

Yeah, so I had something like this in mind but I wanted to inform the
filesystem about superblock and mountpoint marks as well. And I'd pass the
'mask' as well as presumably filesystem could behave differently depending
on whether we are looking for create vs unlink vs file change events etc...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
