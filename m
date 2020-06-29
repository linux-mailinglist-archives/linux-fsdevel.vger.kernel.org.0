Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F38D20E444
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbgF2VXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:23:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgF2SvZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:51:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8E8FAD2C;
        Mon, 29 Jun 2020 18:12:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 811B91E12E7; Mon, 29 Jun 2020 20:12:58 +0200 (CEST)
Date:   Mon, 29 Jun 2020 20:12:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Revert "fs: Do not check if there is a fsnotify watcher
 on pseudo inodes"
Message-ID: <20200629181258.GI26507@quack2.suse.cz>
References: <7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com>
 <CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com>
 <20200629130915.GF26507@quack2.suse.cz>
 <CAOQ4uxhdOMbn9vL_PAGKLtriVzkjwBkuEgbdB5+uH2ZM6uA97w@mail.gmail.com>
 <20200629144145.GA3183@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629144145.GA3183@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 29-06-20 15:41:45, Mel Gorman wrote:
> This reverts commit e9c15badbb7b ("fs: Do not check if there is a
> fsnotify watcher on pseudo inodes"). The commit intended to eliminate
> fsnotify-related overhead for pseudo inodes but it is broken in
> concept. inotify can receive events of pipe files under /proc/X/fd and
> chromium relies on close and open events for sandboxing. Maxim Levitsky
> reported the following
> 
>   Chromium starts as a white rectangle, shows few white rectangles that
>   resemble its notifications and then crashes.
> 
>   The stdout output from chromium:
> 
>   [mlevitsk@starship ~]$chromium-freeworld
>   mesa: for the   --simplifycfg-sink-common option: may only occur zero or one times!
>   mesa: for the   --global-isel-abort option: may only occur zero or one times!
>   [3379:3379:0628/135151.440930:ERROR:browser_switcher_service.cc(238)] XXX Init()
>   ../../sandbox/linux/seccomp-bpf-helpers/sigsys_handlers.cc:**CRASHING**:seccomp-bpf failure in syscall 0072
>   Received signal 11 SEGV_MAPERR 0000004a9048
> 
> Crashes are not universal but even if chromium does not crash, it certainly
> does not work properly. While filtering just modify and access might be
> safe, the benefit is not worth the risk hence the revert.
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Fixes: e9c15badbb7b ("fs: Do not check if there is a fsnotify watcher on pseudo inodes")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Thanks for the revert Mel. I can see Linus already picked it up so we are
done.

								Honza

> ---
>  fs/file_table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 65603502fed6..656647f9575a 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -230,7 +230,7 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
>  		d_set_d_op(path.dentry, &anon_ops);
>  	path.mnt = mntget(mnt);
>  	d_instantiate(path.dentry, inode);
> -	file = alloc_file(&path, flags | FMODE_NONOTIFY, fops);
> +	file = alloc_file(&path, flags, fops);
>  	if (IS_ERR(file)) {
>  		ihold(inode);
>  		path_put(&path);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
