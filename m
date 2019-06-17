Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54F493FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 23:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfFQVe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 17:34:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33698 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFQVez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:34:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hczH8-0008LW-Jk; Mon, 17 Jun 2019 21:34:50 +0000
Date:   Mon, 17 Jun 2019 22:34:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: fsmount: add missing mntget()
Message-ID: <20190617213450.GW17978@ZenIV.linux.org.uk>
References: <20190610183031.GE63833@gmail.com>
 <20190612184313.143456-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612184313.143456-1-ebiggers@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:43:13AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> sys_fsmount() needs to take a reference to the new mount when adding it
> to the anonymous mount namespace.  Otherwise the filesystem can be
> unmounted while it's still in use, as found by syzkaller.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: syzbot+99de05d099a170867f22@syzkaller.appspotmail.com
> Reported-by: syzbot+7008b8b8ba7df475fdc8@syzkaller.appspotmail.com
> Fixes: 93766fbd2696 ("vfs: syscall: Add fsmount() to create a mount for a superblock")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/namespace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index b26778bdc236e..5dc137a22d406 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3445,6 +3445,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  	ns->root = mnt;
>  	ns->mounts = 1;
>  	list_add(&mnt->mnt_list, &ns->list);
> +	mntget(newmount.mnt);
>  
>  	/* Attach to an apparent O_PATH fd with a note that we need to unmount
>  	 * it, not just simply put it.

Nice catch...  Applied, with apologies for having been MIA lately.
