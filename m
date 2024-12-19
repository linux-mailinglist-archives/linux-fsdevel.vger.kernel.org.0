Return-Path: <linux-fsdevel+bounces-37782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A03039F784A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 10:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733427A5870
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B411522147F;
	Thu, 19 Dec 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJnLIrtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB3222D45
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600051; cv=none; b=ts/ZvK5mPs9jviWKusgpQxrQdxDfA+wsHaoAUnbGVSExYBJlqWctmqa20O5UV1SbrjlMf7R+LbdxbTGYwv+ex94FQYlDpNuOCsxR/4ZaTG8TgM/L7cZsHkoODQ+NKcIH7yoOLNon/dWteo47wqU5RxhvRY/iWeKn0K39A/lgdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600051; c=relaxed/simple;
	bh=Cvn0CctqcnXi156TmS2Rqj02nFqXJH7GcFM0GLgQPME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mipQG3I29jmQz2JbVfcK36RtJazpFpYnE8hPOnUj7J6mVkj6fkJ7X9HJ0sMiZDwyKw+WAeNQF/JR4Zp3l8Sh8oS0F109GVA/KolH5umItZ6q7av8wqrh377duhvj8JSBtw4h3YoqsERx42fxAZKUcTwzogRdevP9x/CxBbsLZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJnLIrtl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734600049; x=1766136049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cvn0CctqcnXi156TmS2Rqj02nFqXJH7GcFM0GLgQPME=;
  b=AJnLIrtlbJw01xmYgyateuQXbJLNuqm4zFMekuETsv8EUFAnzDp5HWxL
   zY/OBOqpSm9v9TL+yRLOOg3Q+M+c/df0LZSpHDdUoLMuJ/nu7uRPdkZgj
   98feQJeuH1M4v3vvomRbB66tPg4HTcuqPSLkXyvrK/oucaQUiySM5LO7i
   kxgLTpm9Soz46iPg+j18azA0men2xycGax8vJ2N0RZJxZ5WhHEdE1GKKN
   aqG5tbGfIRJ6CLnaF0BdrsXlxEgLVwvcrXxdVAkz/cg6TaOqLEbJWP4FX
   M8HP2zfyhIiZ8mazBM2hTYieSAvqSDi0tOzrx3FzMY3KQAd+ZGo/Aj80S
   A==;
X-CSE-ConnectionGUID: ajvbe3rxRvupX3wL+0pA6w==
X-CSE-MsgGUID: QttU7k/wQPiJoU05/U3cVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="60483111"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="60483111"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 01:20:42 -0800
X-CSE-ConnectionGUID: OgsezMqeRn+JPTSFxJH8pw==
X-CSE-MsgGUID: ZUzfGI7LRXixHZzUqURklQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="102990633"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 01:20:40 -0800
Date: Thu, 19 Dec 2024 17:20:15 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Ziljstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org, yi1.lai@intel.com
Subject: Re: [PATCH v3 03/10] fs: lockless mntns rbtree lookup
Message-ID: <Z2PlT5rcRTIhCpft@ly-workstation>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
 <20241213-work-mount-rbtree-lockless-v3-3-6e3cdaf9b280@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-3-6e3cdaf9b280@kernel.org>

On Fri, Dec 13, 2024 at 12:03:42AM +0100, Christian Brauner wrote:
> Currently we use a read-write lock but for the simple search case we can
> make this lockless. Creating a new mount namespace is a rather rare
> event compared with querying mounts in a foreign mount namespace. Once
> this is picked up by e.g., systemd to list mounts in another mount in
> it's isolated services or in containers this will be used a lot so this
> seems worthwhile doing.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/mount.h     |   5 ++-
>  fs/namespace.c | 119 +++++++++++++++++++++++++++++++++++----------------------
>  2 files changed, 77 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 185fc56afc13338f8185fe818051444d540cbd5b..36ead0e45e8aa7614c00001102563a711d9dae6e 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -12,7 +12,10 @@ struct mnt_namespace {
>  	struct user_namespace	*user_ns;
>  	struct ucounts		*ucounts;
>  	u64			seq;	/* Sequence number to prevent loops */
> -	wait_queue_head_t poll;
> +	union {
> +		wait_queue_head_t	poll;
> +		struct rcu_head		mnt_ns_rcu;
> +	};
>  	u64 event;
>  	unsigned int		nr_mounts; /* # of mounts in the namespace */
>  	unsigned int		pending_mounts;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 10fa18dd66018fadfdc9d18c59a851eed7bd55ad..52adee787eb1b6ee8831705b2b121854c3370fb3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -79,6 +79,8 @@ static DECLARE_RWSEM(namespace_sem);
>  static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>  static DEFINE_RWLOCK(mnt_ns_tree_lock);
> +static seqcount_rwlock_t mnt_ns_tree_seqcount = SEQCNT_RWLOCK_ZERO(mnt_ns_tree_seqcount, &mnt_ns_tree_lock);
> +
>  static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
>  
>  struct mount_kattr {
> @@ -105,17 +107,6 @@ EXPORT_SYMBOL_GPL(fs_kobj);
>   */
>  __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
>  
> -static int mnt_ns_cmp(u64 seq, const struct mnt_namespace *ns)
> -{
> -	u64 seq_b = ns->seq;
> -
> -	if (seq < seq_b)
> -		return -1;
> -	if (seq > seq_b)
> -		return 1;
> -	return 0;
> -}
> -
>  static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
>  {
>  	if (!node)
> @@ -123,19 +114,41 @@ static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
>  	return rb_entry(node, struct mnt_namespace, mnt_ns_tree_node);
>  }
>  
> -static bool mnt_ns_less(struct rb_node *a, const struct rb_node *b)
> +static int mnt_ns_cmp(struct rb_node *a, const struct rb_node *b)
>  {
>  	struct mnt_namespace *ns_a = node_to_mnt_ns(a);
>  	struct mnt_namespace *ns_b = node_to_mnt_ns(b);
>  	u64 seq_a = ns_a->seq;
> +	u64 seq_b = ns_b->seq;
> +
> +	if (seq_a < seq_b)
> +		return -1;
> +	if (seq_a > seq_b)
> +		return 1;
> +	return 0;
> +}
>  
> -	return mnt_ns_cmp(seq_a, ns_b) < 0;
> +static inline void mnt_ns_tree_write_lock(void)
> +{
> +	write_lock(&mnt_ns_tree_lock);
> +	write_seqcount_begin(&mnt_ns_tree_seqcount);
> +}
> +
> +static inline void mnt_ns_tree_write_unlock(void)
> +{
> +	write_seqcount_end(&mnt_ns_tree_seqcount);
> +	write_unlock(&mnt_ns_tree_lock);
>  }
>  
>  static void mnt_ns_tree_add(struct mnt_namespace *ns)
>  {
> -	guard(write_lock)(&mnt_ns_tree_lock);
> -	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
> +	struct rb_node *node;
> +
> +	mnt_ns_tree_write_lock();
> +	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
> +	mnt_ns_tree_write_unlock();
> +
> +	WARN_ON_ONCE(node);
>  }
>  
>  static void mnt_ns_release(struct mnt_namespace *ns)
> @@ -150,41 +163,36 @@ static void mnt_ns_release(struct mnt_namespace *ns)
>  }
>  DEFINE_FREE(mnt_ns_release, struct mnt_namespace *, if (_T) mnt_ns_release(_T))
>  
> +static void mnt_ns_release_rcu(struct rcu_head *rcu)
> +{
> +	struct mnt_namespace *mnt_ns;
> +
> +	mnt_ns = container_of(rcu, struct mnt_namespace, mnt_ns_rcu);
> +	mnt_ns_release(mnt_ns);
> +}
> +
>  static void mnt_ns_tree_remove(struct mnt_namespace *ns)
>  {
>  	/* remove from global mount namespace list */
>  	if (!is_anon_ns(ns)) {
> -		guard(write_lock)(&mnt_ns_tree_lock);
> +		mnt_ns_tree_write_lock();
>  		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
> +		mnt_ns_tree_write_unlock();
>  	}
>  
> -	mnt_ns_release(ns);
> +	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
>  }
>  
> -/*
> - * Returns the mount namespace which either has the specified id, or has the
> - * next smallest id afer the specified one.
> - */
> -static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
> +static int mnt_ns_find(const void *key, const struct rb_node *node)
>  {
> -	struct rb_node *node = mnt_ns_tree.rb_node;
> -	struct mnt_namespace *ret = NULL;
> -
> -	lockdep_assert_held(&mnt_ns_tree_lock);
> -
> -	while (node) {
> -		struct mnt_namespace *n = node_to_mnt_ns(node);
> +	const u64 mnt_ns_id = *(u64 *)key;
> +	const struct mnt_namespace *ns = node_to_mnt_ns(node);
>  
> -		if (mnt_ns_id <= n->seq) {
> -			ret = node_to_mnt_ns(node);
> -			if (mnt_ns_id == n->seq)
> -				break;
> -			node = node->rb_left;
> -		} else {
> -			node = node->rb_right;
> -		}
> -	}
> -	return ret;
> +	if (mnt_ns_id < ns->seq)
> +		return -1;
> +	if (mnt_ns_id > ns->seq)
> +		return 1;
> +	return 0;
>  }
>  
>  /*
> @@ -194,18 +202,37 @@ static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
>   * namespace the @namespace_sem must first be acquired. If the namespace has
>   * already shut down before acquiring @namespace_sem, {list,stat}mount() will
>   * see that the mount rbtree of the namespace is empty.
> + *
> + * Note the lookup is lockless protected by a sequence counter. We only
> + * need to guard against false negatives as false positives aren't
> + * possible. So if we didn't find a mount namespace and the sequence
> + * counter has changed we need to retry. If the sequence counter is
> + * still the same we know the search actually failed.
>   */
>  static struct mnt_namespace *lookup_mnt_ns(u64 mnt_ns_id)
>  {
> -       struct mnt_namespace *ns;
> +	struct mnt_namespace *ns;
> +	struct rb_node *node;
> +	unsigned int seq;
> +
> +	guard(rcu)();
> +	do {
> +		seq = read_seqcount_begin(&mnt_ns_tree_seqcount);
> +		node = rb_find_rcu(&mnt_ns_id, &mnt_ns_tree, mnt_ns_find);
> +		if (node)
> +			break;
> +	} while (read_seqcount_retry(&mnt_ns_tree_seqcount, seq));
>  
> -       guard(read_lock)(&mnt_ns_tree_lock);
> -       ns = mnt_ns_find_id_at(mnt_ns_id);
> -       if (!ns || ns->seq != mnt_ns_id)
> -               return NULL;
> +	if (!node)
> +		return NULL;
>  
> -       refcount_inc(&ns->passive);
> -       return ns;
> +	/*
> +	 * The last reference count is put with RCU delay so we can
> +	 * unconditonally acquire a reference here.
> +	 */
> +	ns = node_to_mnt_ns(node);
> +	refcount_inc(&ns->passive);
> +	return ns;
>  }
>  
>  static inline void lock_mount_hash(void)
> 
> -- 
> 2.45.2
>

Hi Christian Brauner ,

Greetings!

I used Syzkaller and found that there is WARNING in mnt_ns_release in linux v6.13-rc3.

After bisection and the first bad commit is:
"
5eda70f550d7 fs: lockless mntns rbtree lookup
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241219_115855_mnt_ns_release
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241219_115855_mnt_ns_release/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241219_115855_mnt_ns_release/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241219_115855_mnt_ns_release/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241219_115855_mnt_ns_release/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241219_115855_mnt_ns_release/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241219_115855_mnt_ns_release/bzImage_fdb298fa865b0136f7be842e6c2e6310dede421a
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241219_115855_mnt_ns_release/fdb298fa865b0136f7be842e6c2e6310dede421a_dmesg.log

"
[  268.453608] ------------[ cut here ]------------
[  268.453889] WARNING: CPU: 0 PID: 10683 at fs/namespace.c:163 mnt_ns_release+0x18d/0x200
[  268.454274] Modules linked in:
[  268.454431] CPU: 0 UID: 0 PID: 10683 Comm: repro Not tainted 6.13.0-rc3-next-20241217-fdb298fa865b #1
[  268.454857] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qe4
[  268.455380] RIP: 0010:mnt_ns_release+0x18d/0x200
[  268.455604] Code: ff ff 48 c7 c7 30 67 29 87 e8 ff ea ac 03 bf 01 00 00 00 89 c3 89 c6 e8 91 81 7e ff 83 fb 019
[  268.456446] RSP: 0018:ffff88806c409df8 EFLAGS: 00010246
[  268.456693] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff820995df
[  268.457023] RDX: ffff888020b40000 RSI: ffffffff820995ed RDI: 0000000000000005
[  268.457359] RBP: ffff88806c409e18 R08: ffff888017a66e48 R09: fffffbfff15085a3
[  268.457861] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888017a66e00
[  268.458188] R13: ffff88806c409eb8 R14: ffffffff816e536a R15: 0000000000000003
[  268.458523] FS:  00007f7f8ffbf600(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
[  268.458880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  268.459150] CR2: 0000000000000000 CR3: 0000000017be6005 CR4: 0000000000770ef0
[  268.459486] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  268.459808] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[  268.460136] PKRU: 55555554
[  268.460271] Call Trace:
[  268.460394]  <IRQ>
[  268.460500]  ? show_regs+0x6d/0x80
[  268.460671]  ? __warn+0xf3/0x390
[  268.460830]  ? report_bug+0x25e/0x4b0
[  268.461008]  ? mnt_ns_release+0x18d/0x200
[  268.461197]  ? report_bug+0x2cb/0x4b0
[  268.461377]  ? mnt_ns_release+0x18d/0x200
[  268.461587]  ? mnt_ns_release+0x18e/0x200
[  268.461781]  ? handle_bug+0xf1/0x190
[  268.461961]  ? exc_invalid_op+0x3c/0x80
[  268.462152]  ? asm_exc_invalid_op+0x1f/0x30
[  268.462357]  ? rcu_core+0x86a/0x1920
[  268.462539]  ? mnt_ns_release+0x17f/0x200
[  268.462733]  ? mnt_ns_release+0x18d/0x200
[  268.462929]  ? mnt_ns_release+0x18d/0x200
[  268.463118]  ? mnt_ns_release+0x18d/0x200
[  268.463313]  ? rcu_core+0x86a/0x1920
[  268.463491]  mnt_ns_release_rcu+0x1f/0x30
[  268.463688]  rcu_core+0x86c/0x1920
[  268.463863]  ? __pfx_rcu_core+0x10/0x10
[  268.464058]  rcu_core_si+0x12/0x20
[  268.464229]  handle_softirqs+0x1c5/0x860
[  268.464431]  __irq_exit_rcu+0x10e/0x170
[  268.464620]  irq_exit_rcu+0x12/0x30
[  268.464795]  sysvec_apic_timer_interrupt+0xb4/0xd0
[  268.465029]  </IRQ>
[  268.465139]  <TASK>
[  268.465251]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  268.465517] RIP: 0010:mnt_ns_tree_add+0xbe/0x490
[  268.465745] Code: 0f 85 34 03 00 00 49 bd 00 00 00 00 00 fc ff df 4d 8b 64 24 38 e8 c2 7a 7e ff 48 8d 7b 98 48d
[  268.466596] RSP: 0018:ffff88801f1b7cc8 EFLAGS: 00000246
[  268.466845] RAX: 1ffff11001afa347 RBX: ffff88800d7d1aa0 RCX: ffffffff8209996c
[  268.467180] RDX: ffff888020b40000 RSI: ffffffff8209992e RDI: ffff88800d7d1a38
[  268.467517] RBP: ffff88801f1b7cf8 R08: 0000000000000000 R09: fffffbfff15085a2
[  268.467844] R10: 0000000000000008 R11: 0000000000000001 R12: 0000000000002725
[  268.468167] R13: dffffc0000000000 R14: ffff888014a71c00 R15: ffff88800d7d12a8
[  268.468501]  ? mnt_ns_tree_add+0xec/0x490
[  268.468697]  ? mnt_ns_tree_add+0xae/0x490
[  268.468891]  ? mnt_ns_tree_add+0xae/0x490
[  268.469088]  copy_mnt_ns+0x5ed/0xa90
[  268.469272]  create_new_namespaces+0xe2/0xb40
[  268.469514]  ? security_capable+0x19d/0x1e0
[  268.469727]  unshare_nsproxy_namespaces+0xca/0x200
[  268.469959]  ksys_unshare+0x482/0xae0
[  268.470138]  ? __pfx_ksys_unshare+0x10/0x10
[  268.470346]  ? __audit_syscall_entry+0x39c/0x500
[  268.470572]  __x64_sys_unshare+0x3a/0x50
[  268.470760]  x64_sys_call+0xd3e/0x2140
[  268.470942]  do_syscall_64+0x6d/0x140
[  268.471118]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  268.471362] RIP: 0033:0x7f7f8fc3ee5d
[  268.471535] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 898
[  268.472375] RSP: 002b:00007ffd32de1248 EFLAGS: 00000286 ORIG_RAX: 0000000000000110
[  268.472719] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7f8fc3ee5d
[  268.473052] RDX: ffffffffffffff80 RSI: ffffffffffffff80 RDI: 0000000020060480
[  268.473386] RBP: 00007ffd32de1250 R08: 00007ffd32de1280 R09: 00007ffd32de1280
[  268.473720] R10: 00007ffd32de1280 R11: 0000000000000286 R12: 00007ffd32de13a8
[  268.474046] R13: 0000000000401713 R14: 0000000000403e08 R15: 00007f7f90006000
[  268.474387]  </TASK>
[  268.474499] irq event stamp: 1528
[  268.474665] hardirqs last  enabled at (1536): [<ffffffff81662885>] __up_console_sem+0x95/0xb0
[  268.475065] hardirqs last disabled at (1543): [<ffffffff8166286a>] __up_console_sem+0x7a/0xb0
[  268.475454] softirqs last  enabled at (0): [<ffffffff81463a8e>] copy_process+0x1d4e/0x6a40
[  268.475830] softirqs last disabled at (661): [<ffffffff8148a84e>] __irq_exit_rcu+0x10e/0x170
[  268.476213] ---[ end trace 0000000000000000 ]---
"

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

