Return-Path: <linux-fsdevel+bounces-74536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1877CD3B8E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C610E3025A57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DCF2DB784;
	Mon, 19 Jan 2026 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqMLCyH2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE4248867
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855906; cv=pass; b=dQXqd1ucFIYyqhT5G1Y9pIzhN/FF/0OL6+Jxjj48tw52Q0gibqKN29uEAs9p4sJQ9HUrqtUOTZv7YxI5KpKBcUL++Be3p9V3gIT8Vqmu7+JiWc/WOjBmAV62rWJBMeEgfDYSOc+v38mZ1vwkYqGnA9+jb7q+V+fqV8fj8D8hUWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855906; c=relaxed/simple;
	bh=wqn79PuPJxP9q+cPhB1QH7vQG9zLAThA0Jc3FuOJ4+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuqOpDnLMcg/zzoAgoe14zeSvC7QC0QlXGWN11aDEYb2Z10LVC0OVUaps+l6v2TVpgvQap9YlfJplNLkvIotHBu6DvZiBFzA3EYIsUthA1ybPoo+O58xiCN7+nA1SCyMo7XlfsBHcVOKj27wkqDRMOTt96ZDQ/XpWbiexR57b1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqMLCyH2; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so7900468a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 12:51:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768855903; cv=none;
        d=google.com; s=arc-20240605;
        b=ga7dFZRRUo7n040aweFBR+YZKaEVmnVzxabhhjtBllOvzYghwJOqzvfrfjoLmTo1ws
         jBj4p2Z18Ll5yZ5ztQQNoiUQJh0LdrXHfGl62NOfl6FBogPIhfw/Hx6i2gQ0x7tnIJs0
         VlbaLFJPRACiCZEY7JJRporuTJARQRzUdik8ZUCCF7qTvHPGpS20gdU5ewA46CvRjcCT
         whKYPJciXN0LxE1a/hISXj7bYGT6zAXRuSbJeBxZlHQNj6S/IIrYHZVAfLdshkKkmPb6
         3R7AP6D9ajdD9oAJJCZvsin8S4WGJrWc3ZcAqtHjnbeVqOztIBymEkEjc7NlQ2Uig85a
         D7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPKXgrdsislNDnizVkaAwVkjcIIakNuhLIL/lYUceqs=;
        fh=mzE1U9B0lv6MbwufWrD2FeImXiRILlw/5SJPP/bHO+c=;
        b=IY/exVAKhW9EvtlDKCzTe6Hlgbwir0nwlluWO0dCqh5+/GD9eld+hBMONwIMNjVZOs
         bC5re5R8pTL5XchzwRUVUxkT0AoRusUiuw4A72FzhnGyxYuU1pi4eIyZl2hpMsUyJcCD
         cWW5n50bKaQSMFUZvL36ZKZCTSWHC0IuL/NVNJtgzd9QJo6JMsS417uRK4A9ePeUKmi+
         vFbUsqyaRaM2GsP94XTI7SCG8PLz5Cs16AeqII2kv1CMgVbc1RCAJnfrJ8VxunLua1T/
         Uzg9L6HJcKJfnpG7bDSF7p+nm0fuE/tJ6HTEQhbDW12EnHfShhEZv2wz9R3AvZ1mJgyH
         mhpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768855903; x=1769460703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPKXgrdsislNDnizVkaAwVkjcIIakNuhLIL/lYUceqs=;
        b=RqMLCyH2mTTLgHqL8gWGTC+JXUplEC5brdWBAeW8jZWdKBobRlAsPRnHmuqpDUupAe
         cESvlpuOrOnHvH7siIQDawQpK4R706BQidlSzJrVDr0JmsjgEIy39Qe/aiEX3TXUOzjZ
         7aK2hyFmKOo/FNwZQs6DKiGM6LZKYjEwmYoYcofxOs1Q3o7tT5MiEC5yBckOSCgxGsp2
         /UorwVj15TV+MVi2qsLZHsLBim2Z68GND2kYlXZFJKqn4oWACEkHBAv4Pa5Gist6Ywp7
         kjjBYipfuUudpPlEqlq3MSlF9kkJhqlmyvDhupeiB6Xwj9ChYy5uJ4FRBbt6CU7T/pB8
         sHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855903; x=1769460703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPKXgrdsislNDnizVkaAwVkjcIIakNuhLIL/lYUceqs=;
        b=QtIybpR6JVVmXJXvS1oVznTTKTCg7+cqSqDHAaayiRkiZmXkNqR04qnpvsbgW5ZJKl
         ueE/t31xRkZhIrLRoG1ZOLikh/QSSjMMssPpJE1Uz01wuVnwLHqYhBXhbV6yp/7QkqN1
         497Y11CmCFA/vz835Fix+4wzJg/CGHh8BGsRiVyHG3XHvUCJZOofIEqq0NSsL0ELpLy/
         4QB8v/eQmMvDCiW52s3My9xVbhlcxAszcFQovHC3q2WTimG9jxCahYloztqd35JVHarJ
         rQDkTVkBtnm15Nb4JE+cUo92qqO3/Ait5PH2ogSuEot7qLdBaMXhP4eyW36r4sfTTe0F
         +pZw==
X-Forwarded-Encrypted: i=1; AJvYcCW7anmjFFLNI8i4lLyefytnNbJ+IbEQb6AkC5jaDX/bYbd8jEWgRHEROCeOj67UovCqVThjWyg4xmicQe6k@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1dfW+zlbEpmVpOQSA9/leAgER+bs5sXII67tgC88vO/r9Biv
	ldFPn2GpbRI8YpTgwFRui0y6H7pcNARQagYuxHN/pPg3ZibD6QWm92e64QmgSu/nFP7xS2oNzkS
	2qD7VSNYCoxg5ShVJUA38RM59Q9CjIRo=
X-Gm-Gg: AY/fxX5HaNFXeFoCKcfUrDZKXfCoDcjYFdIfV/usFzhfvrnT9nwWxH4q+PfQdVGVLqo
	r3CblgTptW2Yu3e9GM6xKATQHZFF2ywWgEzrEB5YA9x2qwi2caKuYpm6YOZU+o0t3ipBzIaDB6F
	7ZiExP/XDEN65nrgnD6tR6aw06wpDbOTVTHCqGfRSXf4qWKkW7vagqVbroJ9HMJCB/UiPg3jVPz
	X//UORWzbLHNbhIz/j5hWQ8xeBE06nBnRfFLC6oXk/c7ueSLFwepp0OhSK9u/aQ4xTV/Bhnug2u
	7n06bhm9KQnnFa173z0HPsy9/kY=
X-Received: by 2002:a17:907:930a:b0:b80:3846:d46 with SMTP id
 a640c23a62f3a-b8792d5a7a8mr1231456966b.20.1768855902482; Mon, 19 Jan 2026
 12:51:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org>
In-Reply-To: <20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 19 Jan 2026 21:51:30 +0100
X-Gm-Features: AZwV_QhrqtH2aLnpzXy8S-ieYs9zc___esrR5cMpB0gFaoQSGb_4hhqNZUgTOSQ
Message-ID: <CAGudoHEej7_Q-nkJqBU8Md15ESVtyxZ9Wbq9zwyUEcfT034=xg@mail.gmail.com>
Subject: Re: [PATCH RFC] pidfs: convert rb-tree to rhashtable
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:06=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Convert the pidfs inode-to-pid mapping from an rb-tree with seqcount
> protection to an rhashtable. This removes the global pidmap_lock
> contention from pidfs_ino_get_pid() lookups and allows the hashtable
> insert to happen outside the pidmap_lock.
>
> pidfs_add_pid() is split. pidfs_prepare_pid() allocates inode number and
> initializes pid fields and is called inside pidmap_lock. pidfs_add_pid()
> inserts pid into rhashtable and is called outside pidmap_lock. Insertion
> into the rhashtable can fail and memory allocation may happen so we need
> to drop the spinlock.
>
> The hashtable removal is deferred to the RCU callback to ensure safe
> concurrent lookups. To guard against accidently opening an already
> reaped task pidfs_ino_get_pid() uses additional checks beyond pid_vnr().
> If pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd
> or it already went through pidfs_exit() aka the process as already
> reaped. If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out
> whether the task has exited. Switch to refcount_inc_not_zero() to ensure
> that the pid isn't about to be freed.
>
> This slightly changes visibility semantics: pidfd creation is denied
> after pidfs_exit() runs, which is just before the pid number is removed
> from the via free_pid(). That should not be an issue though.
>
> I haven't perfed this and I would like to make this Mateusz problem...
>
> Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c            | 107 ++++++++++++++++++++++++++++----------------=
------
>  include/linux/pid.h   |   4 +-
>  include/linux/pidfs.h |   3 +-
>  kernel/pid.c          |  19 ++++++---
>  4 files changed, 79 insertions(+), 54 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index dba703d4ce4a..e97931249ba2 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -21,6 +21,7 @@
>  #include <linux/utsname.h>
>  #include <net/net_namespace.h>
>  #include <linux/coredump.h>
> +#include <linux/rhashtable.h>
>  #include <linux/xattr.h>
>
>  #include "internal.h"
> @@ -55,7 +56,23 @@ struct pidfs_attr {
>         __u32 coredump_signal;
>  };
>
> -static struct rb_root pidfs_ino_tree =3D RB_ROOT;
> +static struct rhashtable pidfs_ino_ht;
> +
> +static int pidfs_ino_ht_cmp(struct rhashtable_compare_arg *arg, const vo=
id *pidp)
> +{
> +       const u64 *ino =3D arg->key;
> +       const struct pid *pid =3D pidp;
> +
> +       return pid->ino !=3D *ino;
> +}
> +
> +static const struct rhashtable_params pidfs_ino_ht_params =3D {
> +       .key_offset             =3D offsetof(struct pid, ino),
> +       .key_len                =3D sizeof(u64),
> +       .head_offset            =3D offsetof(struct pid, pidfs_hash),
> +       .obj_cmpfn              =3D pidfs_ino_ht_cmp,
> +       .automatic_shrinking    =3D true,
> +};
>
>  #if BITS_PER_LONG =3D=3D 32
>  static inline unsigned long pidfs_ino(u64 ino)
> @@ -84,21 +101,11 @@ static inline u32 pidfs_gen(u64 ino)
>  }
>  #endif
>
> -static int pidfs_ino_cmp(struct rb_node *a, const struct rb_node *b)
> -{
> -       struct pid *pid_a =3D rb_entry(a, struct pid, pidfs_node);
> -       struct pid *pid_b =3D rb_entry(b, struct pid, pidfs_node);
> -       u64 pid_ino_a =3D pid_a->ino;
> -       u64 pid_ino_b =3D pid_b->ino;
> -
> -       if (pid_ino_a < pid_ino_b)
> -               return -1;
> -       if (pid_ino_a > pid_ino_b)
> -               return 1;
> -       return 0;
> -}
> -
> -void pidfs_add_pid(struct pid *pid)
> +/*
> + * Allocate inode number and initialize pidfs fields.
> + * Called with pidmap_lock held.
> + */
> +void pidfs_prepare_pid(struct pid *pid)
>  {
>         static u64 pidfs_ino_nr =3D 2;
>
> @@ -134,17 +141,23 @@ void pidfs_add_pid(struct pid *pid)
>         pid->stashed =3D NULL;
>         pid->attr =3D NULL;
>         pidfs_ino_nr++;
> +}
>
> -       write_seqcount_begin(&pidmap_lock_seq);
> -       rb_find_add_rcu(&pid->pidfs_node, &pidfs_ino_tree, pidfs_ino_cmp)=
;
> -       write_seqcount_end(&pidmap_lock_seq);
> +/*
> + * Insert pid into the pidfs hashtable.
> + * Must be called without holding pidmap_lock (can allocate memory).
> + * Returns 0 on success, negative error on failure.
> + */
> +int pidfs_add_pid(struct pid *pid)
> +{
> +       return rhashtable_insert_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> +                                     pidfs_ino_ht_params);
>  }
>
>  void pidfs_remove_pid(struct pid *pid)
>  {
> -       write_seqcount_begin(&pidmap_lock_seq);
> -       rb_erase(&pid->pidfs_node, &pidfs_ino_tree);
> -       write_seqcount_end(&pidmap_lock_seq);
> +       rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> +                              pidfs_ino_ht_params);
>  }
>
>  void pidfs_free_pid(struct pid *pid)
> @@ -773,43 +786,42 @@ static int pidfs_encode_fh(struct inode *inode, u32=
 *fh, int *max_len,
>         return FILEID_KERNFS;
>  }
>
> -static int pidfs_ino_find(const void *key, const struct rb_node *node)
> -{
> -       const u64 pid_ino =3D *(u64 *)key;
> -       const struct pid *pid =3D rb_entry(node, struct pid, pidfs_node);
> -
> -       if (pid_ino < pid->ino)
> -               return -1;
> -       if (pid_ino > pid->ino)
> -               return 1;
> -       return 0;
> -}
> -
>  /* Find a struct pid based on the inode number. */
>  static struct pid *pidfs_ino_get_pid(u64 ino)
>  {
>         struct pid *pid;
> -       struct rb_node *node;
> -       unsigned int seq;
> +       struct pidfs_attr *attr;
>
>         guard(rcu)();
> -       do {
> -               seq =3D read_seqcount_begin(&pidmap_lock_seq);
> -               node =3D rb_find_rcu(&ino, &pidfs_ino_tree, pidfs_ino_fin=
d);
> -               if (node)
> -                       break;
> -       } while (read_seqcount_retry(&pidmap_lock_seq, seq));
>
> -       if (!node)
> +       pid =3D rhashtable_lookup(&pidfs_ino_ht, &ino, pidfs_ino_ht_param=
s);
> +       if (!pid)
>                 return NULL;
>
> -       pid =3D rb_entry(node, struct pid, pidfs_node);
> -
>         /* Within our pid namespace hierarchy? */
>         if (pid_vnr(pid) =3D=3D 0)
>                 return NULL;
>
> -       return get_pid(pid);
> +       /*
> +        * If attr is NULL the pid is still in the IDR but never had
> +        * a pidfd. If attr is an error the pid went through pidfs_exit()
> +        * and is about to be removed. Either way, deny access.
> +        */
> +       attr =3D READ_ONCE(pid->attr);
> +       if (IS_ERR_OR_NULL(attr))
> +               return NULL;
> +
> +       /*
> +        * If PIDFS_ATTR_BIT_EXIT is set the task has exited and we
> +        * should not allow new file handle lookups.
> +        */
> +       if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
> +               return NULL;
> +
> +       if (!refcount_inc_not_zero(&pid->count))
> +               return NULL;
> +
> +       return pid;
>  }
>
>  static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> @@ -1086,6 +1098,9 @@ struct file *pidfs_alloc_file(struct pid *pid, unsi=
gned int flags)
>
>  void __init pidfs_init(void)
>  {
> +       if (rhashtable_init(&pidfs_ino_ht, &pidfs_ino_ht_params))
> +               panic("Failed to initialize pidfs hashtable");
> +
>         pidfs_attr_cachep =3D kmem_cache_create("pidfs_attr_cache", sizeo=
f(struct pidfs_attr), 0,
>                                          (SLAB_HWCACHE_ALIGN | SLAB_RECLA=
IM_ACCOUNT |
>                                           SLAB_ACCOUNT | SLAB_PANIC), NUL=
L);
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 003a1027d219..ce9b5cb7560b 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -6,6 +6,7 @@
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
>  #include <linux/refcount.h>
> +#include <linux/rhashtable-types.h>
>  #include <linux/sched.h>
>  #include <linux/wait.h>
>
> @@ -60,7 +61,7 @@ struct pid {
>         spinlock_t lock;
>         struct {
>                 u64 ino;
> -               struct rb_node pidfs_node;
> +               struct rhash_head pidfs_hash;
>                 struct dentry *stashed;
>                 struct pidfs_attr *attr;
>         };
> @@ -73,7 +74,6 @@ struct pid {
>         struct upid numbers[];
>  };
>
> -extern seqcount_spinlock_t pidmap_lock_seq;
>  extern struct pid init_struct_pid;
>
>  struct file;
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 3e08c33da2df..416bdff4d6ce 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -6,7 +6,8 @@ struct coredump_params;
>
>  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
>  void __init pidfs_init(void);
> -void pidfs_add_pid(struct pid *pid);
> +void pidfs_prepare_pid(struct pid *pid);
> +int pidfs_add_pid(struct pid *pid);
>  void pidfs_remove_pid(struct pid *pid);
>  void pidfs_exit(struct task_struct *tsk);
>  #ifdef CONFIG_COREDUMP
> diff --git a/kernel/pid.c b/kernel/pid.c
> index ad4400a9f15f..7da2c3e8f79c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -43,7 +43,6 @@
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
>  #include <linux/pidfs.h>
> -#include <linux/seqlock.h>
>  #include <net/sock.h>
>  #include <uapi/linux/pidfd.h>
>
> @@ -85,7 +84,6 @@ struct pid_namespace init_pid_ns =3D {
>  EXPORT_SYMBOL_GPL(init_pid_ns);
>
>  static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
> -seqcount_spinlock_t pidmap_lock_seq =3D SEQCNT_SPINLOCK_ZERO(pidmap_lock=
_seq, &pidmap_lock);
>
>  void put_pid(struct pid *pid)
>  {
> @@ -106,6 +104,7 @@ EXPORT_SYMBOL_GPL(put_pid);
>  static void delayed_put_pid(struct rcu_head *rhp)
>  {
>         struct pid *pid =3D container_of(rhp, struct pid, rcu);
> +       pidfs_remove_pid(pid);
>         put_pid(pid);
>  }
>
> @@ -141,7 +140,6 @@ void free_pid(struct pid *pid)
>
>                 idr_remove(&ns->idr, upid->nr);
>         }
> -       pidfs_remove_pid(pid);
>         spin_unlock(&pidmap_lock);
>
>         call_rcu(&pid->rcu, delayed_put_pid);
> @@ -315,7 +313,14 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_=
t *arg_set_tid,
>         retval =3D -ENOMEM;
>         if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
>                 goto out_free;
> -       pidfs_add_pid(pid);
> +       pidfs_prepare_pid(pid);
> +       spin_unlock(&pidmap_lock);
> +
> +       retval =3D pidfs_add_pid(pid);
> +       if (retval)
> +               goto out_free_idr;
> +
> +       spin_lock(&pidmap_lock);

This brings back the relock trip, reducing eficacy of the patch.

Longer term someone(tm) will need to implement lockless alloc_pid (in
the fast path anyway).

In order to facilitate that the pidfs thing needs to get its own
synchronisation. To my understanding rhashtable covers its own locking
just fine, so the thing left to handle is ino allocation.

I was unable to find a ready to use mechanism, but conceptually it can
be implemented the same way get_next_ino is sorted out, except on 64
bit values and ignoring wraparound (as in, the code can assume this
will never wrap).

With these in place there is no pidfs-specific work happening under pidmap_=
lock.

I have not looked much into pidfs itself, I'm sure there is some
complexity there to sort out, but scalability-wise the above will do
it.

