Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDEC230BD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgG1NzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:55:04 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:33864 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730138AbgG1NzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:55:03 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 763C320460;
        Tue, 28 Jul 2020 13:55:01 +0000 (UTC)
Date:   Tue, 28 Jul 2020 15:54:58 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] Show /proc/self/net only for CAP_NET_ADMIN
Message-ID: <20200728135458.ng2pmbcznizjksnd@comp-core-i7-2640m-0182e6>
References: <20200727141411.203770-1-gladkov.alexey@gmail.com>
 <20200727141411.203770-3-gladkov.alexey@gmail.com>
 <87blk0ncpb.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blk0ncpb.fsf@x220.int.ebiederm.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Tue, 28 Jul 2020 13:55:01 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:29:36AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > Show /proc/self/net only for CAP_NET_ADMIN if procfs is mounted with
> > subset=pid option in user namespace. This is done to avoid possible
> > information leakage.
> >
> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> > ---
> >  fs/proc/proc_net.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> > index dba63b2429f0..11fa2c4b3529 100644
> > --- a/fs/proc/proc_net.c
> > +++ b/fs/proc/proc_net.c
> > @@ -275,6 +275,12 @@ static struct net *get_proc_task_net(struct inode *dir)
> >  	struct task_struct *task;
> >  	struct nsproxy *ns;
> >  	struct net *net = NULL;
> > +	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
> > +
> > +	if ((fs_info->pidonly == PROC_PIDONLY_ON) &&
> > +	    (current_user_ns() != &init_user_ns) &&
> > +	    !capable(CAP_NET_ADMIN))
> > +		return net;
> >
> >  	rcu_read_lock();
> >  	task = pid_task(proc_pid(dir), PIDTYPE_PID);
> 
> Hmm.
> 
> I see 3 options going forward.
> 
> 1) We just make PROC_PIDONLY_ON mean the net directory does not exist.
>    No permission checks just always fail.

I think it's wrong. Now if someone mounts a fully visible procfs then they
can see this directory. Hiding this directory completely will change the
current behavior.

> 2) Move the permission checks into opendir/readdir and whichever
>    is the appropriate method there and always allow the dentries
>    to be cached.

At first I did so, but then I transferred this check to get_proc_task_net
because if this function does not return anything, then 'net' directory
will exist but will simply be empty.

This allowed us to get rid of unnecessary wrappers for opendir/lookup.

> 3) Simply cache the mounters credentials and make access to the
>    net directories contingent of the permisions of the mounter of
>    proc.  Something like the code below.

Interesting idea. I like that :)

> static struct net *get_proc_task_net(struct inode *dir)
> {
> 	struct task_struct *task;
> 	struct nsproxy *ns;
> 	struct net *net = NULL;
> 
> 	rcu_read_lock();
> 	task = pid_task(proc_pid(dir), PIDTYPE_PID);
> 	if (task != NULL) {
> 		task_lock(task);
> 		ns = task->nsproxy;
> 		if (ns != NULL)
> 			net = get_net(ns->net_ns);
> 		task_unlock(task);
> 	}
> 	rcu_read_unlock();
> 	if ((fs_info->pidonly == PROC_PIDONLY_ON) &&

Is this check necessary? I mean, isn't it worth extending this check to
other cases?

>             !security_capable(fs_info->mounter_cred,
> 			      net->user_ns, CAP_SYS_ADMIN,
> 			      CAP_OPT_NONE)) {
> 		put_net(net);
> 		net = NULL;
> 	}
> 	return net;
> }
> 
> Eric
> 

-- 
Rgrds, legion

