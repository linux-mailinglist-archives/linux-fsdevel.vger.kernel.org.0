Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9343439A3E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 17:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhFCPEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 11:04:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43296 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhFCPEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:04:12 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 34F9B219FC;
        Thu,  3 Jun 2021 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622732547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WX+SEg5nwUPzzeI7E04yJuBmldNqEDwn2vR6lnVynXI=;
        b=RbuUYgSocAgICzH7jjupg/ZhnBagEnPzwTxPFVYIAuQUiFR25T3zWSasxi5K6W7w/whghQ
        WOoDe7zlvQ7bgILYYE/rlsl8GP/VLypfPfEkTfysFpyI/LMDf4qWshpUOymtCBt0dTjpbd
        LfNipaTM4oYiYF4et0tHFhO7H9+4ncE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622732547;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WX+SEg5nwUPzzeI7E04yJuBmldNqEDwn2vR6lnVynXI=;
        b=dwf8+LuKjGVVvbfwNr19jiEXDNVMgAi0T3LxCH4g27IHmGx1d+8slbOt6QGU3er9czOA8p
        HWinU17NNmzV3vBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1606AA3B81;
        Thu,  3 Jun 2021 15:02:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DB6351F2C96; Thu,  3 Jun 2021 17:02:26 +0200 (CEST)
Date:   Thu, 3 Jun 2021 17:02:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-api@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] quota: Change quotactl_path() systcall to an
 fd-based one
Message-ID: <20210603150226.GK23647@quack2.suse.cz>
References: <20210602151553.30090-1-jack@suse.cz>
 <20210602151553.30090-2-jack@suse.cz>
 <20210603122504.656sd6kqs3cfivzp@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603122504.656sd6kqs3cfivzp@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-06-21 14:25:04, Christian Brauner wrote:
> On Wed, Jun 02, 2021 at 05:15:52PM +0200, Jan Kara wrote:
> > Some users have pointed out that path-based syscalls are problematic in
> > some environments and at least directory fd argument and possibly also
> > resolve flags are desirable for such syscalls. Rather than
> > reimplementing all details of pathname lookup and following where it may
> > eventually evolve, let's go for full file descriptor based syscall
> 
> Fair, I can accept that.
> 
> > similar to how ioctl(2) works since the beginning. Managing of quotas
> > isn't performance sensitive so the extra overhead of open does not
> > matter and we are able to consume O_PATH descriptors as well which makes
> > open cheap anyway. Also for frequent operations (such as retrieving
> > usage information for all users) we can reuse single fd and in fact get
> > even better performance as well as avoiding races with possible remounts
> > etc.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/quota/quota.c                  | 27 ++++++++++++---------------
> >  include/linux/syscalls.h          |  4 ++--
> >  include/uapi/asm-generic/unistd.h |  4 ++--
> >  kernel/sys_ni.c                   |  2 +-
> >  4 files changed, 17 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> > index 05e4bd9ab6d6..8450bb6186f4 100644
> > --- a/fs/quota/quota.c
> > +++ b/fs/quota/quota.c
> > @@ -968,31 +968,29 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
> >  	return ret;
> >  }
> >  
> > -SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
> > -		mountpoint, qid_t, id, void __user *, addr)
> > +SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
> > +		qid_t, id, void __user *, addr)
> >  {
> >  	struct super_block *sb;
> > -	struct path mountpath;
> >  	unsigned int cmds = cmd >> SUBCMDSHIFT;
> >  	unsigned int type = cmd & SUBCMDMASK;
> > +	struct fd f = fdget_raw(fd);
> >  	int ret;
> >  
> > -	if (type >= MAXQUOTAS)
> > -		return -EINVAL;
> > +	if (!f.file)
> > +		return -EBADF;
> 
> I would maybe change this to
> 
> f = fdget_raw(fd);
> if (!f.file)
> 	return -EBADF;
> 
> instead of directly assigning when declaring the variable.

OK, I'll do this.

> (And it might make sense to fold the second commit into this one.)

Well, I wanted to keep mostly mechanical (and partly autogenerated ;))
changes separately from the "real" stuff that needs serious review... So I
prefer to keep the split.

> But other than these nits this looks good,
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks for review!

								Honza
> 
> >  
> > -	ret = user_path_at(AT_FDCWD, mountpoint,
> > -			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
> > -	if (ret)
> > -		return ret;
> > -
> > -	sb = mountpath.mnt->mnt_sb;
> > +	ret = -EINVAL;
> > +	if (type >= MAXQUOTAS)
> > +		goto out;
> >  
> >  	if (quotactl_cmd_write(cmds)) {
> > -		ret = mnt_want_write(mountpath.mnt);
> > +		ret = mnt_want_write(f.file->f_path.mnt);
> >  		if (ret)
> >  			goto out;
> >  	}
> >  
> > +	sb = f.file->f_path.mnt->mnt_sb;
> >  	if (quotactl_cmd_onoff(cmds))
> >  		down_write(&sb->s_umount);
> >  	else
> > @@ -1006,9 +1004,8 @@ SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
> >  		up_read(&sb->s_umount);
> >  
> >  	if (quotactl_cmd_write(cmds))
> > -		mnt_drop_write(mountpath.mnt);
> > +		mnt_drop_write(f.file->f_path.mnt);
> >  out:
> > -	path_put(&mountpath);
> > -
> > +	fdput(f);
> >  	return ret;
> >  }
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 050511e8f1f8..586128d5c3b8 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -485,8 +485,8 @@ asmlinkage long sys_pipe2(int __user *fildes, int flags);
> >  /* fs/quota.c */
> >  asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
> >  				qid_t id, void __user *addr);
> > -asmlinkage long sys_quotactl_path(unsigned int cmd, const char __user *mountpoint,
> > -				  qid_t id, void __user *addr);
> > +asmlinkage long sys_quotactl_fd(unsigned int fd, unsigned int cmd, qid_t id,
> > +				void __user *addr);
> >  
> >  /* fs/readdir.c */
> >  asmlinkage long sys_getdents64(unsigned int fd,
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 6de5a7fc066b..f211961ce1da 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -863,8 +863,8 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
> >  #define __NR_mount_setattr 442
> >  __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
> > -#define __NR_quotactl_path 443
> > -__SYSCALL(__NR_quotactl_path, sys_quotactl_path)
> > +#define __NR_quotactl_fd 443
> > +__SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
> >  
> >  #define __NR_landlock_create_ruleset 444
> >  __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index 0ea8128468c3..dad4d994641e 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -99,7 +99,7 @@ COND_SYSCALL(flock);
> >  
> >  /* fs/quota.c */
> >  COND_SYSCALL(quotactl);
> > -COND_SYSCALL(quotactl_path);
> > +COND_SYSCALL(quotactl_fd);
> >  
> >  /* fs/readdir.c */
> >  
> > -- 
> > 2.26.2
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
