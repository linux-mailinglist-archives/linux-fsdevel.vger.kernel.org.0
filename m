Return-Path: <linux-fsdevel+bounces-22667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418B91AF40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2952878D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB4194A4E;
	Thu, 27 Jun 2024 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEC/mSWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133D18054;
	Thu, 27 Jun 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513937; cv=none; b=Xzazg90E0oSwxsCsEEtle7eXHGxTS8C6cFuF/8QwcW/Q10V29QGIBdem6tKe0rrfBq68ESG/k9Dv2or60JIihF1LmThGMjjPuFE4G7iw8s86KAiDU/62z5cCQFo6i8uWnxTSCVqHCqZrEdikPGSEXy9/CKf9cvD7378NhKGhTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513937; c=relaxed/simple;
	bh=YIRjgfoOz1zwpTjnd7qoDst83c4pOm4phGIXwwTTlno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMP+jvQ7b3gJYwSE8hYO7fifpNoKqAGhvCEByUV1TPIwYeDoyTv46+vmQUpbIdkcJWsNnjoR/si6Qo2Ga/DLlvPXtRVTQ5f6Y/iyO8fsMNQs/7h7M4bMbHcjSH8qQ+PGrnuPmsUN1BeILG2l0hQpzcBrdk8wuLYPYbQh4iF7eB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEC/mSWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6744BC2BBFC;
	Thu, 27 Jun 2024 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719513936;
	bh=YIRjgfoOz1zwpTjnd7qoDst83c4pOm4phGIXwwTTlno=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eEC/mSWYMRMfPE7D3H5v8kqWb8cr7Q1/pe4pl+qZ4eGiZmkaav5n46C0QrfKvAA9Y
	 4smwwYsGDnttU2ISy545CfPu3yDtxOV0DSFpYDfGVYyH+9Au1T7qJ+qpBA/DSXWPWF
	 KPpPemqvQgUWk0MO4dnwG+o8xscbrKajbeN/ty9Ng2hQcPoFsIRm9YOeX8ifeiryhq
	 6QMwobwBBYimdgePm3yJNdsrEZ+7xXKSEJfabzt8cq4WGgAhmkK/DVpCQPYScn+n1q
	 DxXYEGQlbK5qMx/wJ7/XLx6bZCLRCV6kRZLRidrNnJ2kzXjB43WmaQBi5Y1A+LVf+l
	 NMPG+FEb/7++A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 625D3CE0A70; Thu, 27 Jun 2024 11:45:34 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:45:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>,
	jmorris@namei.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, serge@hallyn.com,
	syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <cd36f364-2430-49e7-9430-7076a315b76f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
 <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net>
 <202406271019.BF8123A5@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202406271019.BF8123A5@keescook>

On Thu, Jun 27, 2024 at 11:12:43AM -0700, Kees Cook wrote:
> On Thu, Jun 27, 2024 at 03:34:41PM +0200, Mickaël Salaün wrote:
> > I didn't find specific issues with Landlock's code except the extra
> > check in hook_inode_free_security().  It looks like inode->i_security is
> > a dangling pointer, leading to UAF.
> > 
> > Reading security_inode_free() comments, two things looks weird to me:
> > > /**
> > >  * security_inode_free() - Free an inode's LSM blob
> > >  * @inode: the inode
> > >  *
> > >  * Deallocate the inode security structure and set @inode->i_security to NULL.
> > 
> > I don't see where i_security is set to NULL.
> 
> Yeah, I don't either...
> 
> > >  */
> > > void security_inode_free(struct inode *inode)
> > > {
> > 
> > Shouldn't we add this check here?
> > if (!inode->i_security)
> > 	return;
> 
> Probably, yes. The LSMs that check for NULL i_security in the free hook
> all do so right at the beginning...

Given your fix below, I am assuming that they do this check within some
sort of an RCU read-side critical section.

> > > 	call_void_hook(inode_free_security, inode);
> > > 	/*
> > > 	 * The inode may still be referenced in a path walk and
> > > 	 * a call to security_inode_permission() can be made
> > > 	 * after inode_free_security() is called. Ideally, the VFS
> > > 	 * wouldn't do this, but fixing that is a much harder
> > > 	 * job. For now, simply free the i_security via RCU, and
> > > 	 * leave the current inode->i_security pointer intact.
> > > 	 * The inode will be freed after the RCU grace period too.
> > 
> > It's not clear to me why this should be safe if an LSM try to use the
> > partially-freed blob after the hook calls and before the actual blob
> > free.
> 
> Yeah, it's not clear to me what the expected lifetime is here. How is
> inode_permission() being called if all inode reference counts are 0? It
> does seem intentional, though.
> 
> The RCU logic was introduced in commit 3dc91d4338d6 ("SELinux: Fix possible
> NULL pointer dereference in selinux_inode_permission()"), with much
> discussion:
> https://lore.kernel.org/lkml/20140109101932.0508dec7@gandalf.local.home/
> (This commit seems to remove setting "i_security = NULL", though, which
> the comment implies is intended, but then it also seems to depend on
> finding a NULL?)
> 
> LSMs using i_security are:
> 
> security/bpf/hooks.c:   .lbs_inode = sizeof(struct bpf_storage_blob),
> security/integrity/evm/evm_main.c:      .lbs_inode = sizeof(struct evm_iint_cache),
> security/integrity/ima/ima_main.c:      .lbs_inode = sizeof(struct ima_iint_cache *),
> security/landlock/setup.c:      .lbs_inode = sizeof(struct landlock_inode_security),
> security/selinux/hooks.c:       .lbs_inode = sizeof(struct inode_security_struct),
> security/smack/smack_lsm.c:     .lbs_inode = sizeof(struct inode_smack),
> 
> SELinux is still checking for NULL. See selinux_inode() and
> selinux_inode_free_security(), as do bpf_inode() and
> bpf_inode_storage_free(). evm and ima also check for NULL.
> 
> landlock_inode() does not, though.
> 
> Smack doesn't hook the free, but it should still check for NULL, and it's not.
> 
> So I think this needs fixing in Landlock and Smack.
> 
> I kind of think that the LSM infrastructure needs to provide a common
> helper for the "access the blob" action, as we've got it repeated in
> each LSM, and we have 2 implementations that are missing NULL checks...
> 
> > 
> > > 	 */
> > > 	if (inode->i_security)
> > > 		call_rcu((struct rcu_head *)inode->i_security,
> > > 			 inode_free_by_rcu);
> > 
> > And then:
> > inode->i_security = NULL;
> > 
> > But why call_rcu()?  i_security is not protected by RCU barriers.
> 
> I assume it's because security_inode_free() via __destroy_inode() via
> destroy_inode() via evict() via iput_final() via iput() may be running
> in interrupt context?
> 
> But I still don't see where i_security gets set to NULL. This won't fix
> the permissions hook races for Landlock and Smack, but should make
> lifetime a bit more clear?
> 
> 
> diff --git a/security/security.c b/security/security.c
> index 9c3fb2f60e2a..a8658ebcaf0c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1613,7 +1613,8 @@ static void inode_free_by_rcu(struct rcu_head *head)
>   */
>  void security_inode_free(struct inode *inode)
>  {
> -	call_void_hook(inode_free_security, inode);
> +	struct rcu_head *inode_blob = inode->i_security;
> +
>  	/*
>  	 * The inode may still be referenced in a path walk and
>  	 * a call to security_inode_permission() can be made
> @@ -1623,9 +1624,11 @@ void security_inode_free(struct inode *inode)
>  	 * leave the current inode->i_security pointer intact.
>  	 * The inode will be freed after the RCU grace period too.
>  	 */
> -	if (inode->i_security)
> -		call_rcu((struct rcu_head *)inode->i_security,
> -			 inode_free_by_rcu);
> +	if (inode_blob) {
> +		call_void_hook(inode_free_security, inode);
> +		inode->i_security = NULL;
> +		call_rcu(inode_blob, inode_free_by_rcu);
> +	}
>  }

This approach looks plausible to me.

							Thanx, Paul

>  /**
> 
> 
> -Kees
> 
> > 
> > > }
> > 
> > 
> > On Thu, May 16, 2024 at 09:31:21AM GMT, Mickaël Salaün wrote:
> > > Adding membarrier experts.
> > > 
> > > On Wed, May 15, 2024 at 05:12:58PM +0200, Mickaël Salaün wrote:
> > > > On Thu, May 09, 2024 at 08:01:49PM -0400, Paul Moore wrote:
> > > > > On Wed, May 8, 2024 at 3:32 PM syzbot
> > > > > <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14a46760980000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=5446fbf332b0602ede0b
> > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > >
> > > > > > Downloadable assets:
> > > > > > disk image: https://storage.googleapis.com/syzbot-assets/39d66018d8ad/disk-dccb07f2.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/c160b651d1bc/vmlinux-dccb07f2.xz
> > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/3662a33ac713/bzImage-dccb07f2.xz
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
> > > > > >
> > > > > > general protection fault, probably for non-canonical address 0xdffffc018f62f515: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > > > > KASAN: probably user-memory-access in range [0x0000000c7b17a8a8-0x0000000c7b17a8af]
> > > > > > CPU: 1 PID: 5102 Comm: syz-executor.1 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> > > > > > RIP: 0010:hook_inode_free_security+0x5b/0xb0 security/landlock/fs.c:1047
> > > > > 
> > > > > Possibly a Landlock issue, Mickaël?
> > > > 
> > > > It looks like security_inode_free() is called two times on the same
> > > > inode.  This could happen if an inode labeled by Landlock is put
> > > > concurrently with release_inode() for a closed ruleset or with
> > > > hook_sb_delete().  I didn't find any race condition that could lead to
> > > > two calls to iput() though.  Could WRITE_ONCE(object->underobj, NULL)
> > > > change anything even if object->lock is locked?
> > 
> > I don't think so anymore, the issue is with i_security, not the blob
> > content.
> > 
> > > > 
> > > > A bit unrelated but looking at the SELinux code, I see that selinux_inode()
> > > > checks `!inode->i_security`.  In which case could this happen?
> > 
> > I think this shouldn't happen, and that might actually be an issue for
> > SELinux.  See my above comment about security_free_inode().
> > 
> > > > 
> > > > > 
> > > > > > Code: 8a fd 48 8b 1b 48 c7 c0 c4 4e d5 8d 48 c1 e8 03 42 0f b6 04 30 84 c0 75 3e 48 63 05 33 59 65 09 48 01 c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 66 be 8a fd 48 83 3b 00 75 0d e8
> > > > > > RSP: 0018:ffffc9000307f9a8 EFLAGS: 00010212
> > > > > > RAX: 000000018f62f515 RBX: 0000000c7b17a8a8 RCX: ffff888027668000
> > > > > > RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff88805c0bb270
> > > > > > RBP: ffffffff8c01fb00 R08: ffffffff82132a15 R09: 1ffff1100b81765f
> > > > > > R10: dffffc0000000000 R11: ffffffff846ff540 R12: dffffc0000000000
> > > > > > R13: 1ffff1100b817683 R14: dffffc0000000000 R15: dffffc0000000000
> > > > > > FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 00007f43c42de000 CR3: 00000000635f8000 CR4: 0000000000350ef0
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  security_inode_free+0x4a/0xd0 security/security.c:1613
> > > > > >  __destroy_inode+0x2d9/0x650 fs/inode.c:286
> > > > > >  destroy_inode fs/inode.c:309 [inline]
> > > > > >  evict+0x521/0x630 fs/inode.c:682
> > > > > >  dispose_list fs/inode.c:700 [inline]
> > > > > >  evict_inodes+0x5f9/0x690 fs/inode.c:750
> > > > > >  generic_shutdown_super+0x9d/0x2d0 fs/super.c:626
> > > > > >  kill_block_super+0x44/0x90 fs/super.c:1675
> > > > > >  deactivate_locked_super+0xc6/0x130 fs/super.c:472
> > > > > >  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
> > > > > >  task_work_run+0x251/0x310 kernel/task_work.c:180
> > > > > >  exit_task_work include/linux/task_work.h:38 [inline]
> > > > > >  do_exit+0xa1b/0x27e0 kernel/exit.c:878
> > > > > >  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
> > > > > >  __do_sys_exit_group kernel/exit.c:1038 [inline]
> > > > > >  __se_sys_exit_group kernel/exit.c:1036 [inline]
> > > > > >  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
> > > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > > >  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > > RIP: 0033:0x7f731567dd69
> > > > > > Code: Unable to access opcode bytes at 0x7f731567dd3f.
> > > > > > RSP: 002b:00007fff4f0804d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > > > > > RAX: ffffffffffffffda RBX: 00007f73156c93a3 RCX: 00007f731567dd69
> > > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > > > RBP: 0000000000000002 R08: 00007fff4f07e277 R09: 00007fff4f081790
> > > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff4f081790
> > > > > > R13: 00007f73156c937e R14: 00000000000154d0 R15: 000000000000001e
> > > > > >  </TASK>
> > > > > > Modules linked in:
> > > > > > ---[ end trace 0000000000000000 ]---
> > > > > 
> > > > > -- 
> > > > > paul-moore.com
> > > > > 
> 
> -- 
> Kees Cook

