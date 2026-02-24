Return-Path: <linux-fsdevel+bounces-78283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE51Hb3RnWn4SAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:28:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98030189CD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F810312E4C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14C43A785E;
	Tue, 24 Feb 2026 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlnR5EqW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315921799F
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950327; cv=none; b=RYMLVdatM5+z0Ftc8SYaE/IPgeA+N+NGYMhJj/cHGuRIMUmKLGHB29+7zlkSHm4IHW2eATZBeGb0HRu++mU/i3B3U3Hbst584/VhdaoScK2+GA+6nZDWzVmiJpgJbKvfYAjRPOyIW3MuCaUw9rWA1yyLpIcbuZnuZhsjpbjsR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950327; c=relaxed/simple;
	bh=hjcoNIh+6P15mbaTtt400Y5K3aN93ZrDfc9NibSay7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7fIjzemfwT3nbLL4B1uGjIeSDpdNespkqxiFxJW5jAhoWcAiADIgFS42kKV5akXblDaLuLbeaMIj4ojyRq8nJGSxX7aUtDXUB80Sms0wnrkxqFZ5/1U/Q0l+49Qn8vyapYHpPAjE2YNxxt6a5Xk8a+GO7A3cHs02Jf+4KGAZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlnR5EqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62725C116D0;
	Tue, 24 Feb 2026 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771950326;
	bh=hjcoNIh+6P15mbaTtt400Y5K3aN93ZrDfc9NibSay7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlnR5EqW9AYySvFLi4zSVBflTOyLjvLpqhGOOf7efa8kqZ/3qkeVzmwNtTTB9z6Tg
	 k61dG1JHVGzgjzhrGYTECVmfJJjaUZMacI+P4P3ktTQA4byI17cUW8CBRhWRBxLIYa
	 IQ8g+jSIhg/NUwX72UnO2Hnjbzx3shJv7bj1/6ITt4JDEaZzrFVqudRWxgK8B5gXCo
	 1CopRcLe42SRSymR0Z+n1Gxr50rZH8FsDxP7LS+Mvk+D2HwkKVxHB2PjyZ0Nib0b9g
	 blfivsdaQeGc9hWiz9Nv1a4zLc00oOr6AK2Ttq0J8ZD6Ej6tNZZ/EtYuwDRxHbQ5Q0
	 rEeiJ3L/sXNJg==
Date: Tue, 24 Feb 2026 17:25:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guillaume Tucker <gtucker@gtucker.io>, Tejun Heo <tj@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, kunit-dev@googlegroups.com, David Gow <davidgow@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: make_task_dead() & kthread_exit()
Message-ID: <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
 <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78283-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,googlegroups.com,google.com,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url,msgid.link:url]
X-Rspamd-Queue-Id: 98030189CD9
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:22:31PM +0100, Christian Brauner wrote:
> On Fri, Feb 20, 2026 at 04:11:43PM +0100, Guillaume Tucker wrote:
> > Hi Christian et al,
> > 
> > On 20/01/2026 15:52, Christian Brauner wrote:
> > > Mateusz reported performance penalties [1] during task creation because
> > > pidfs uses pidmap_lock to add elements into the rbtree. Switch to an
> > > rhashtable to have separate fine-grained locking and to decouple from
> > > pidmap_lock moving all heavy manipulations outside of it.
> > > 
> > > Convert the pidfs inode-to-pid mapping from an rb-tree with seqcount
> > > protection to an rhashtable. This removes the global pidmap_lock
> > > contention from pidfs_ino_get_pid() lookups and allows the hashtable
> > > insert to happen outside the pidmap_lock.
> > > 
> > > pidfs_add_pid() is split. pidfs_prepare_pid() allocates inode number and
> > > initializes pid fields and is called inside pidmap_lock. pidfs_add_pid()
> > > inserts pid into rhashtable and is called outside pidmap_lock. Insertion
> > > into the rhashtable can fail and memory allocation may happen so we need
> > > to drop the spinlock.
> > > 
> > > To guard against accidently opening an already reaped task
> > > pidfs_ino_get_pid() uses additional checks beyond pid_vnr(). If
> > > pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd or
> > > it already went through pidfs_exit() aka the process as already reaped.
> > > If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out whether
> > > the task has exited.
> > > 
> > > This slightly changes visibility semantics: pidfd creation is denied
> > > after pidfs_exit() runs, which is just before the pid number is removed
> > > from the via free_pid(). That should not be an issue though.
> > > 
> > > Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com [1]
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > > Changes in v2:
> > > - Ensure that pid is removed before call_rcu() from pidfs.
> > > - Don't drop and reacquire spinlock.
> > > - Link to v1: https://patch.msgid.link/20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org
> > > ---
> > >  fs/pidfs.c            | 81 +++++++++++++++++++++------------------------------
> > >  include/linux/pid.h   |  4 +--
> > >  include/linux/pidfs.h |  3 +-
> > >  kernel/pid.c          | 13 ++++++---
> > >  4 files changed, 46 insertions(+), 55 deletions(-)
> > 
> > [...]
> > 
> > > diff --git a/kernel/pid.c b/kernel/pid.c
> > > index ad4400a9f15f..6077da774652 100644
> > > --- a/kernel/pid.c
> > > +++ b/kernel/pid.c
> > > @@ -43,7 +43,6 @@
> > >  #include <linux/sched/task.h>
> > >  #include <linux/idr.h>
> > >  #include <linux/pidfs.h>
> > > -#include <linux/seqlock.h>
> > >  #include <net/sock.h>
> > >  #include <uapi/linux/pidfd.h>
> > >  
> > > @@ -85,7 +84,6 @@ struct pid_namespace init_pid_ns = {
> > >  EXPORT_SYMBOL_GPL(init_pid_ns);
> > >  
> > >  static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
> > > -seqcount_spinlock_t pidmap_lock_seq = SEQCNT_SPINLOCK_ZERO(pidmap_lock_seq, &pidmap_lock);
> > >  
> > >  void put_pid(struct pid *pid)
> > >  {
> > > @@ -141,9 +139,9 @@ void free_pid(struct pid *pid)
> > >  
> > >  		idr_remove(&ns->idr, upid->nr);
> > >  	}
> > > -	pidfs_remove_pid(pid);
> > >  	spin_unlock(&pidmap_lock);
> > >  
> > > +	pidfs_remove_pid(pid);
> > >  	call_rcu(&pid->rcu, delayed_put_pid);
> > >  }
> > 
> > There appears to be a reproducible panic in rcu since next-20260216
> > at least while running KUnit.  After running a bisection I found that
> > it was visible at a merge commit adding this patch 44e59e62b2a2
> > ("Merge branch 'kernel-7.0.misc' into vfs.all").  I then narrowed it
> > down further on a test branch by rebasing the pidfs series on top of
> > the last known working commit:
> > 
> >     https://gitlab.com/gtucker/linux/-/commits/kunit-rcu-debug-rebased
> > 
> > I also did some initial investigation with basic printk debugging and
> > haven't found anything obviously wrong in this patch itself, although
> > I'm no expert in pidfs...  One symptom is that the kernel panic
> > always happens because the function pointer to delayed_put_pid()
> > becomes corrupt.  As a quick hack, if I just call put_pid() in
> > free_pid() rather than go through rcu then there's no panic - see the
> > last commit on the test branch from the link above.  The issue is
> > still in next-20260219 as far as I can tell.
> > 
> > Here's how to reproduce this, using the new container script and a
> > plain container image to run KUnit vith QEMU on x86:
> > 
> > scripts/container -s -i docker.io/gtucker/korg-gcc:kunit -- \
> >     tools/testing/kunit/kunit.py \
> >     run \
> >     --arch=x86_64 \
> >     --cross_compile=x86_64-linux-
> > 
> > The panic can be seen in .kunit/test.log:
> > 
> >     [gtucker] rcu_do_batch:2609 count=7 func=ffffffff99026d40
> >     Oops: invalid opcode: 0000 [#2] SMP NOPTI
> >     CPU: 0 UID: 0 PID: 197 Comm: kunit_try_catch Tainted: G      D          N  6.19.0-09950-gc33cbc7ffae4 #77 PREEMPT(lazy)
> >     Tainted: [D]=DIE, [N]=TEST
> >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.1 11/11/2019
> >     RIP: 0010:0xffffffff99026d42
> > 
> > Looking at the last rcu callbacks that were enqueued with my extra
> > printk messages:
> > 
> > $ grep call_rcu .kunit/test.log | tail -n16
> > [gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
> > [gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
> > [gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
> > [gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
> > [gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
> > [gtucker] call_rcu include/linux/sched/task.h:159 put_task_struct ffffffff98887ae0
> > [gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
> > [gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
> > [gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
> > [gtucker] call_rcu kernel/pid.c:148 free_pid ffffffff988adaf0
> > [gtucker] call_rcu kernel/exit.c:237 put_task_struct_rcu_user ffffffff9888e440
> > [gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
> > [gtucker] call_rcu lib/radix-tree.c:310 radix_tree_node_free ffffffff98ccc1a0
> > [gtucker] call_rcu kernel/pid.c:148 free_pid ffffffff988adaf0
> > [gtucker] call_rcu kernel/exit.c:237 put_task_struct_rcu_user ffffffff9888e440
> > [gtucker] call_rcu kernel/cred.c:83 __put_cred ffffffff988b7cd0
> > 
> > and then the ones that were called:
> > 
> > $ grep rcu_do_batch .kunit/test.log | tail
> > [gtucker] rcu_do_batch:2609 count=7 func=ffffffff98887ae0
> > [gtucker] rcu_do_batch:2609 count=8 func=ffffffff98887ae0
> > [gtucker] rcu_do_batch:2609 count=9 func=ffffffff98887ae0
> > [gtucker] rcu_do_batch:2609 count=1 func=ffffffff98ccc1a0
> > [gtucker] rcu_do_batch:2609 count=2 func=ffffffff98887ae0
> > [gtucker] rcu_do_batch:2609 count=3 func=ffffffff988b7cd0
> > [gtucker] rcu_do_batch:2609 count=4 func=ffffffff988b7cd0
> > [gtucker] rcu_do_batch:2609 count=5 func=ffffffff988b7cd0
> > [gtucker] rcu_do_batch:2609 count=6 func=ffffffff98ccc1a0
> > [gtucker] rcu_do_batch:2609 count=7 func=ffffffff99026d40
> > 
> > we can see that the last pointer ffffffff99026d40 was never enqueued,
> > and the one from free_pid() ffffffff988adaf0 was never dequeued.
> > This is where I stopped investigating as it looked legit and someone
> > else might have more clues as to what's going on here.  I've only
> > seen the problem with this callback but again, KUnit is a very narrow
> > kind of workload so the root cause may well be lying elsewhere.
> > 
> > Please let me know if you need any more debugging details or if I can
> > help test a fix.  Hope this helps!
> 
> Thanks for the report. I have so far no idea how that can happen:
> 
> * Is this reproducible with multiple compilers?
> * Is this reproducible on v7.0-rc1?
> 
> Fwiw, we're missing one check currently:
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 3b96571d0fe6..dc11acd445ae 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -326,7 +326,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
> 
>         retval = pidfs_add_pid(pid);
>         if (unlikely(retval)) {
> -               free_pid(pid);
> +               if (pid != &init_struct_pid)
> +                       free_pid(pid);
>                 pid = ERR_PTR(-ENOMEM);
>         }
> 
> But it seems unlikely that pidfs_add_pid() fails here.

Ugh, yuck squared.

IIUC, the bug is a UAF in free_kthread_struct(). It wasn't easy
detectable until the pidfs rhashtable conversion changed struct pid's
size and field layout.

The rhashtable conversion replaced struct pid's struct rb_node of 24
bytes with struct rhash_head of 8 bytes, shrinking struct pid by 16
bytes bringing it to 144 bytes. This means it's now the same size as
struct kthread (without CONFIG_BLK_CGROUP). Both structs use
SLAB_HWCACHE_ALIGN bringing it to 192. KUnit sets
CONFIG_SLAB_MERGE_DEFAULT=y. So now struct pid and struct kthread share
slab caches. First part of the puzzle.

struct pid.rcu.func is at offset 0x78 and struct kthread.affinity node
at offset 0x78. I'm I'm right then we can already see where this is
going.

So free_kthread_struct() calls kfree(kthread) without checking whether
the kthread's affinity_node is still linked in kthread_affinity_list.

If a kthread exits via a path that bypasses kthread_exit() (e.g.,
make_task_dead() after an oops -- which calls do_exit() directly),
the affinity_node remains in the global kthread_affinity_list. When
free_kthread_struct() later frees the kthread struct, the linked list
still references the freed memory. Any subsequent list_del() by another
kthread in kthread_exit() writes to the freed memory:

    list_del(&kthread->affinity_node):
    entry->prev->next = entry->next   // writes to freed predecessor's offset 0x78

With cache merging, this freed kthread memory may have been reused for a
struct pid. The write corrupts pid.rcu.func at the same offset 0x78,
replacing delayed_put_pid with &kthread_affinity_list. The next RCU
callback invocation is fscked.

* Raising SLAB_NO_MERGE makes the bug go away.
* Turn on
  CONFIG_KASAN=y
  CONFIG_KASAN_GENERIC=y
  CONFIG_KASAN_INLINE=y

  BUG: KASAN: slab-use-after-free in kthread_exit+0x255/0x280
  Write of size 8 at addr ffff888003238f78 by task kunit_try_catch/183

  Allocated by task 169:
    set_kthread_struct+0x31/0x150
    copy_process+0x203d/0x4c00

  <snip>

  Freed by task 0:
    free_task+0x147/0x3a0
    rcu_core+0x58e/0x1c50

  <snip>

Object at ffff888003238f00 belongs to kmalloc-192 cache.
Allocated by
set_kthread_struct()
-> kzalloc(sizeof(*kthread)).
Freed by
free_task()
-> free_kthread_struct()
   -> kfree().

Written to at offset 0x78 (affinity_node.next) by another kthread's
list_del in kthread_exit().

Fix should be something like

    void free_kthread_struct(struct task_struct *k)
    {
        struct kthread *kthread;

        kthread = to_kthread(k);
        if (!kthread)
            return;

    +   if (!list_empty(&kthread->affinity_node)) {
    +       mutex_lock(&kthread_affinity_lock);
    +       list_del(&kthread->affinity_node);
    +       mutex_unlock(&kthread_affinity_lock);
    +   }
    +   if (kthread->preferred_affinity)
    +       kfree(kthread->preferred_affinity);

    #ifdef CONFIG_BLK_CGROUP
        WARN_ON_ONCE(kthread->blkcg_css);
    #endif
        k->worker_private = NULL;
        kfree(kthread->full_name);
        kfree(kthread);
    }

The normal kthread_exit() path already unlinks the node. After
list_del(), the node's pointers are set to LIST_POISON1/LIST_POISON2, so
list_empty() returns false. To avoid a double-unlink, kthread_exit()
should use list_del_init() instead of list_del(), so that
free_kthread_struct()'s list_empty() check correctly detects the
already-unlinked state.

I had claude reproduce this under various conditions because I'm a lazy fsck.

