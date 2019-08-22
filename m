Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250FB98B66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 08:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbfHVGaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 02:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731704AbfHVGaV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:30:21 -0400
Received: from zzz.localdomain (unknown [67.218.105.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3AFD205ED;
        Thu, 22 Aug 2019 06:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566455420;
        bh=2DtatxVDW1nKwmkx3HMXXS8CVF6c+oRXWYzMKDp5Fn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pADeM8o+S9FavrrK1virg0c1+J17cKB/9RHK6QOEgjHnUcAX7K4SVgHhkz3sTh1it
         vizzqYlJkeKKqx01xW5JKWUm2khks3UKw4w8pI4/U42pScG98m4XwclhTGN9T9s1Sy
         sTvKgIRzs4Z71KddB7+jkjEKz6gkDo6t8rBH2BQE=
Date:   Wed, 21 Aug 2019 23:30:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
Message-ID: <20190822063018.GK6111@zzz.localdomain>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
References: <0000000000004f43fa058a97f4d3@google.com>
 <201906060520.x565Kd8j017983@www262.sakura.ne.jp>
 <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp>
 <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp>
 <20190618204933.GE17978@ZenIV.linux.org.uk>
 <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Tetsuo,

On Sat, Jun 22, 2019 at 01:45:30PM +0900, Tetsuo Handa wrote:
> On 2019/06/19 5:49, Al Viro wrote:
> > On Sun, Jun 16, 2019 at 03:49:00PM +0900, Tetsuo Handa wrote:
> >> Hello, Al.
> >>
> >> Q1: Do you agree that we should fix TOMOYO side rather than SOCKET_I()->sk
> >>     management.
> > 
> > You do realize that sockets are not unique in that respect, right?
> > All kinds of interesting stuff can be accessed via /proc/*/fd/*, and
> > it _can_ be closed under you.  So I'd suggest checking how your code
> > copes with similar for pipes, FIFOs, epoll, etc., accessed that way...
> 
> I know all kinds of interesting stuff can be accessed via /proc/*/fd/*,
> and it _can_ be closed under me.
> 
> Regarding sockets, I was accessing "struct socket" memory and
> "struct sock" memory which are outside of "struct inode" memory.
> 
> But regarding other objects, I am accessing "struct dentry" memory,
> "struct super_block" memory and "struct inode" memory. I'm expecting
> that these memory can't be kfree()d as long as "struct path" holds
> a reference. Is my expectation correct?
> 
> > 
> > We are _not_ going to be checking that in fs/open.c - the stuff found
> > via /proc/*/fd/* can have the associated file closed by the time
> > we get to calling ->open() and we won't know that until said call.
> 
> OK. Then, fixing TOMOYO side is the correct way.
> 
> > 
> >> Q2: Do you see any problem with using f->f_path.dentry->d_inode ?
> >>     Do we need to use d_backing_inode() or d_inode() ?
> > 
> > Huh?  What's wrong with file_inode(f), in the first place?  And
> > just when can that be NULL, while we are at it?
> 
> Oh, I was not aware of file_inode(). Thanks.
> 
> > 
> >>>  static int tomoyo_inode_getattr(const struct path *path)
> >>>  {
> >>> +	/* It is not safe to call tomoyo_get_socket_name(). */
> >>> +	if (path->dentry->d_inode && S_ISSOCK(path->dentry->d_inode->i_mode))
> >>> +		return 0;
> > 
> > Can that be called for a negative?
> > 
> 
> I check for NULL when I'm not sure it is guaranteed to hold a valid pointer.
> You meant "we are sure that path->dentry->d_inode is valid", don't you?
> 
> By the way, "negative" associates with IS_ERR() range. I guess that
> "NULL" is the better name...
> 
> Anyway, here is V2 patch.
> 
> From c63c4074300921d6d1c33c3b8dc9c84ebfededf5 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 22 Jun 2019 13:14:26 +0900
> Subject: [PATCH v2] tomoyo: Don't check open/getattr permission on sockets.
> 
> syzbot is reporting that use of SOCKET_I()->sk from open() can result in
> use after free problem [1], for socket's inode is still reachable via
> /proc/pid/fd/n despite destruction of SOCKET_I()->sk already completed.
> 
> But there is no point with calling security_file_open() on sockets
> because open("/proc/pid/fd/n", !O_PATH) on sockets fails with -ENXIO.
> 
> There is some point with calling security_inode_getattr() on sockets
> because stat("/proc/pid/fd/n") and fstat(open("/proc/pid/fd/n", O_PATH))
> are valid. If we want to access "struct sock"->sk_{family,type,protocol}
> fields, we will need to use security_socket_post_create() hook and
> security_inode_free() hook in order to remember these fields because
> security_sk_free() hook is called before the inode is destructed. But
> since information which can be protected by checking
> security_inode_getattr() on sockets is trivial, let's not be bothered by
> "struct inode"->i_security management.
> 
> There is point with calling security_file_ioctl() on sockets. Since
> ioctl(open("/proc/pid/fd/n", O_PATH)) is invalid, security_file_ioctl()
> on sockets should remain safe.
> 
> [1] https://syzkaller.appspot.com/bug?id=73d590010454403d55164cca23bd0565b1eb3b74
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>
> ---
>  security/tomoyo/tomoyo.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 716c92e..8ea3f5d 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -126,6 +126,9 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
>   */
>  static int tomoyo_inode_getattr(const struct path *path)
>  {
> +	/* It is not safe to call tomoyo_get_socket_name(). */
> +	if (S_ISSOCK(d_inode(path->dentry)->i_mode))
> +		return 0;
>  	return tomoyo_path_perm(TOMOYO_TYPE_GETATTR, path, NULL);
>  }
>  
> @@ -316,6 +319,9 @@ static int tomoyo_file_open(struct file *f)
>  	/* Don't check read permission here if called from do_execve(). */
>  	if (current->in_execve)
>  		return 0;
> +	/* Sockets can't be opened by open(). */
> +	if (S_ISSOCK(file_inode(f)->i_mode))
> +		return 0;
>  	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
>  					    f->f_flags);
>  }
> -- 

What happened to this patch?

Also, isn't the same bug in other places too?:

	- tomoyo_path_chmod()
	- tomoyo_path_chown()
	- smack_inode_getsecurity()
	- smack_inode_setsecurity()

- Eric
