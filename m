Return-Path: <linux-fsdevel+bounces-78261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAlMINunnWmgQwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:30:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD0187B06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 873BC31F13FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124FB39B497;
	Tue, 24 Feb 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlvDPAhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0139C648
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939357; cv=none; b=aaPA++NeLiRLebZaP6LFZC7DQy06Wb6yAfcMoJGQycQZwg8NUTFyihMgdw0RrJS/ROxcuWcHE1Lj7GYKl3x3RFL+8L1uH5QWNClOB5d2heJGBMUi9bQSsAM1EOUTyqiIU43eV4BeWq80eUPaccWCE4I88LV321Z3MmNCVANb6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939357; c=relaxed/simple;
	bh=D0aOpU8fG/5n90j6AVZSyRsK/28oNYzf+Nzy/SOBQQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7a/9hscwDyQ6c6xzcTtnQW+ZwORU27vassQay9UR0LIx1buImKR/IO5k9ywk480duEeS9WjfGU+tWqrE865LuKMpcAJlDmpoxAfsmefm1sKQaGXiCJfebr7F6fZGelsXX6wE4Y5UkXTN0lnkuuM449H5PTTwb5aqkwnopvvWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlvDPAhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8BBC19422;
	Tue, 24 Feb 2026 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771939357;
	bh=D0aOpU8fG/5n90j6AVZSyRsK/28oNYzf+Nzy/SOBQQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlvDPAhEr/VnFyC8SLnCz86ZNhEXhC7OncYmhwqPhiZrDR0/XLFLhNcWG86pX3rYK
	 tYwOObmWOdxWIOwVnfNNIJQVz0Ih7XKd2iH9O7yMkkHaLfWgSKQmOtFCUXTX/8U+1D
	 RH9Lv8gAOAhVD1iD3xQ9YIr7JWPJN0S5Nyq0xB9gH7uG3TbbPbpRrN/aMNyOX3WDdZ
	 FUDfjQ0boWC+rWeo17vXmgIXpZoXA4B5Ksiv/flknXlbX6eWP/EkoC7Im8eCVZSJ5f
	 ITreubC1albA4mLdk+vEOvEjKkOnIiFu8Y8Dnq6vMOzSX2oJd/7UmMIoonsRuh73AQ
	 BX7dqIwFqAVmw==
Date: Tue, 24 Feb 2026 14:22:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guillaume Tucker <gtucker@gtucker.io>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, kunit-dev@googlegroups.com, David Gow <davidgow@google.com>
Subject: Re: [PATCH RFC v2] pidfs: convert rb-tree to rhashtable
Message-ID: <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78261-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,googlegroups.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,docker.io:url,msgid.link:url,gitlab.com:url]
X-Rspamd-Queue-Id: DDCD0187B06
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:11:43PM +0100, Guillaume Tucker wrote:
> Hi Christian et al,
> 
> On 20/01/2026 15:52, Christian Brauner wrote:
> > Mateusz reported performance penalties [1] during task creation because
> > pidfs uses pidmap_lock to add elements into the rbtree. Switch to an
> > rhashtable to have separate fine-grained locking and to decouple from
> > pidmap_lock moving all heavy manipulations outside of it.
> > 
> > Convert the pidfs inode-to-pid mapping from an rb-tree with seqcount
> > protection to an rhashtable. This removes the global pidmap_lock
> > contention from pidfs_ino_get_pid() lookups and allows the hashtable
> > insert to happen outside the pidmap_lock.
> > 
> > pidfs_add_pid() is split. pidfs_prepare_pid() allocates inode number and
> > initializes pid fields and is called inside pidmap_lock. pidfs_add_pid()
> > inserts pid into rhashtable and is called outside pidmap_lock. Insertion
> > into the rhashtable can fail and memory allocation may happen so we need
> > to drop the spinlock.
> > 
> > To guard against accidently opening an already reaped task
> > pidfs_ino_get_pid() uses additional checks beyond pid_vnr(). If
> > pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd or
> > it already went through pidfs_exit() aka the process as already reaped.
> > If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out whether
> > the task has exited.
> > 
> > This slightly changes visibility semantics: pidfd creation is denied
> > after pidfs_exit() runs, which is just before the pid number is removed
> > from the via free_pid(). That should not be an issue though.
> > 
> > Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com [1]
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Changes in v2:
> > - Ensure that pid is removed before call_rcu() from pidfs.
> > - Don't drop and reacquire spinlock.
> > - Link to v1: https://patch.msgid.link/20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org
> > ---
> >  fs/pidfs.c            | 81 +++++++++++++++++++++------------------------------
> >  include/linux/pid.h   |  4 +--
> >  include/linux/pidfs.h |  3 +-
> >  kernel/pid.c          | 13 ++++++---
> >  4 files changed, 46 insertions(+), 55 deletions(-)
> 
> [...]
> 
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index ad4400a9f15f..6077da774652 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -43,7 +43,6 @@
> >  #include <linux/sched/task.h>
> >  #include <linux/idr.h>
> >  #include <linux/pidfs.h>
> > -#include <linux/seqlock.h>
> >  #include <net/sock.h>
> >  #include <uapi/linux/pidfd.h>
> >  
> > @@ -85,7 +84,6 @@ struct pid_namespace init_pid_ns = {
> >  EXPORT_SYMBOL_GPL(init_pid_ns);
> >  
> >  static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
> > -seqcount_spinlock_t pidmap_lock_seq = SEQCNT_SPINLOCK_ZERO(pidmap_lock_seq, &pidmap_lock);
> >  
> >  void put_pid(struct pid *pid)
> >  {
> > @@ -141,9 +139,9 @@ void free_pid(struct pid *pid)
> >  
> >  		idr_remove(&ns->idr, upid->nr);
> >  	}
> > -	pidfs_remove_pid(pid);
> >  	spin_unlock(&pidmap_lock);
> >  
> > +	pidfs_remove_pid(pid);
> >  	call_rcu(&pid->rcu, delayed_put_pid);
> >  }
> 
> There appears to be a reproducible panic in rcu since next-20260216
> at least while running KUnit.  After running a bisection I found that
> it was visible at a merge commit adding this patch 44e59e62b2a2
> ("Merge branch 'kernel-7.0.misc' into vfs.all").  I then narrowed it
> down further on a test branch by rebasing the pidfs series on top of
> the last known working commit:
> 
>     https://gitlab.com/gtucker/linux/-/commits/kunit-rcu-debug-rebased
> 
> I also did some initial investigation with basic printk debugging and
> haven't found anything obviously wrong in this patch itself, although
> I'm no expert in pidfs...  One symptom is that the kernel panic
> always happens because the function pointer to delayed_put_pid()
> becomes corrupt.  As a quick hack, if I just call put_pid() in
> free_pid() rather than go through rcu then there's no panic - see the
> last commit on the test branch from the link above.  The issue is
> still in next-20260219 as far as I can tell.
> 
> Here's how to reproduce this, using the new container script and a
> plain container image to run KUnit vith QEMU on x86:
> 
> scripts/container -s -i docker.io/gtucker/korg-gcc:kunit -- \
>     tools/testing/kunit/kunit.py \
>     run \
>     --arch=x86_64 \
>     --cross_compile=x86_64-linux-
> 
> The panic can be seen in .kunit/test.log:
> 
>     [gtucker] rcu_do_batch:2609 count=7 func=ffffffff99026d40
>     Oops: invalid opcode: 0000 [#2] SMP NOPTI
>     CPU: 0 UID: 0 PID: 197 Comm: kunit_try_catch Tainted: G      D          N  6.19.0-09950-gc33cbc7ffae4 #77 PREEMPT(lazy)
>     Tainted: [D]=DIE, [N]=TEST
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.1 11/11/2019
>     RIP: 0010:0xffffffff99026d42
> 
> Looking at the last rcu callbacks that were enqueued with my extra
> printk messages:
> 
> $ grep call_rcu .kunit/test.log | tail -n16
> [gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
> [gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
> [gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
> [gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
> [gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
> [gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
> [gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
> [gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
> [gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
> [gtucker] call_rcu kernel/pid.c:148 free_pid ffffffff988adaf0
> [gtucker] call_rcu kernel/exit.c:237 put_task_struct_rcu_user ffffffff9888e440
> [gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
> [gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
> [gtucker] call_rcu kernel/pid.c:148 free_pid ffffffff988adaf0
> [gtucker] call_rcu kernel/exit.c:237 put_task_struct_rcu_user ffffffff9888e440
> [gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
> 
> and then the ones that were called:
> 
> $ grep rcu_do_batch .kunit/test.log | tail
> [gtucker] rcu_do_batch:2609 count=7 func=ffffffff98887ae0
> [gtucker] rcu_do_batch:2609 count=8 func=ffffffff98887ae0
> [gtucker] rcu_do_batch:2609 count=9 func=ffffffff98887ae0
> [gtucker] rcu_do_batch:2609 count=1 func=ffffffff98ccc1a0
> [gtucker] rcu_do_batch:2609 count=2 func=ffffffff98887ae0
> [gtucker] rcu_do_batch:2609 count=3 func=ffffffff988b7cd0
> [gtucker] rcu_do_batch:2609 count=4 func=ffffffff988b7cd0
> [gtucker] rcu_do_batch:2609 count=5 func=ffffffff988b7cd0
> [gtucker] rcu_do_batch:2609 count=6 func=ffffffff98ccc1a0
> [gtucker] rcu_do_batch:2609 count=7 func=ffffffff99026d40
> 
> we can see that the last pointer ffffffff99026d40 was never enqueued,
> and the one from free_pid() ffffffff988adaf0 was never dequeued.
> This is where I stopped investigating as it looked legit and someone
> else might have more clues as to what's going on here.  I've only
> seen the problem with this callback but again, KUnit is a very narrow
> kind of workload so the root cause may well be lying elsewhere.
> 
> Please let me know if you need any more debugging details or if I can
> help test a fix.  Hope this helps!

Thanks for the report. I have so far no idea how that can happen:

* Is this reproducible with multiple compilers?
* Is this reproducible on v7.0-rc1?

Fwiw, we're missing one check currently:

diff --git a/kernel/pid.c b/kernel/pid.c
index 3b96571d0fe6..dc11acd445ae 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -326,7 +326,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,

        retval = pidfs_add_pid(pid);
        if (unlikely(retval)) {
-               free_pid(pid);
+               if (pid != &init_struct_pid)
+                       free_pid(pid);
                pid = ERR_PTR(-ENOMEM);
        }

But it seems unlikely that pidfs_add_pid() fails here.

