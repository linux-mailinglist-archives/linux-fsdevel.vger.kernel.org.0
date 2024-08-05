Return-Path: <linux-fsdevel+bounces-25028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A50947EFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 18:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08265281C16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988F15B54F;
	Mon,  5 Aug 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoiVlGq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86E1422BD;
	Mon,  5 Aug 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874230; cv=none; b=A+Q5nriwc/eSYT3O2/wSl6ZgHo7XUhSfLeJTNSCHSjzWXPL6HQlwovl4aEzLW8dQH1WwPSO7Dt9gXBwiNucl6bfR1MqH8M+Chp/vcWVSJ2aHiRDyr+zgVqVYXfp2qmsWRn7ALwgLuDk01JKbqwhYL0h9zH6O2xrLqyq65MAOtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874230; c=relaxed/simple;
	bh=/WkvlckJ99EoN/pKgxuKxBEh/1SWU+7BFIjv+c636MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVwh7bAiamkW9W9FnXvtJn2aEH+0JqKLeYDNtbdTK4eVu3AY8l5tq4mIIb4oaRKVYXttIACUOCY3Nq4c8SUvoOElt7il+8oLym3LUdu1kYpDYpNmyxXxegrd84KutPDajQyHhJLhSNi2d2NA5hcRsP7d+s1+wYkpSHmlIVEPvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoiVlGq9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a94aa5080so455828266b.3;
        Mon, 05 Aug 2024 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722874226; x=1723479026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFdpwo1zebzxYBrs/HPUZB2OJH18LDnIiHm2UZAgBG0=;
        b=LoiVlGq9Yu35N2Ne0JS9eb8vgVUgmq9hkNXUz+roKfIhkr61xT8QbWds+WiJ1GmNoZ
         SEVY3OP09bgmE6UMAGpyT5phocjpTc7b2uOPAI1KDTGX2bx7EOPXJDfF7QhaEN/2+8Y6
         swUAVhzUD6kD7muillgZYwPRAnSrpMtKI6oMcYP4PKmYt75EAd6lIABWGuNenhch/qQw
         zJoXJzh2t+QQ197LH6/m7XLzs2w8Ta6HCjAWZEO8EL+Qu+kMgWTjXfjFGUz4DMBCCFf8
         XgQJw6hnKSlM7Pc+X6SRd5wgkXq7nsKTbHej2LiwQ3IQH0BITUAvrTiT3U4JZr4HTYBV
         53zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722874227; x=1723479027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFdpwo1zebzxYBrs/HPUZB2OJH18LDnIiHm2UZAgBG0=;
        b=JiNNnhiOWb1kBQUlSD9rG/62QsbP/PBJqZV1wttOZcim/asAG30axrAzF9x5FmFK4P
         f3WF481u9Mrk+efEQIc0S6R1UEYZYxum6JLolt7FI7VHGiKag+r//tcfJpJk18iT5WWq
         L2dPN+PdXN+Bc+AK825f+5eeuY2I7dMLgCH0KUKsT9xD83SDdtyOhq1uIiyImKQJxcq+
         CXEZMNkNanhZJYUwgzlV0wDdXCoF5L3uBzni64joYjUzZq18UTReQ+LVps+VBdnLeeO2
         VczovM/6eTPnHASJquQ7/Cv80P7i3RAqtUYw7Wt6xn42dsI2NZrg6j/DcrA7oc9KeWI4
         Y7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVk6JJG9Bv1DZVLkTa4XAKikvnDDOk+ix+X1uZIuStB9cnT/4mkoQLIpAk+qcQROmxvCuIDPHllOigUZtShAaDluj0eF8Fzo2oNU/nyGRkMDrNnuIaGUCIjGimycFX3Jeuc5wulMAufu86OwzB/VW/PUajG1skRhrSdDDOjR5PyfwUE4DauKgY=
X-Gm-Message-State: AOJu0Yz2VrnyJUYWoDErqIr6nOgFk/vkqWaXHkM98h4QzGlLqNa+Tm7x
	dXEiPcjMTQfOxGrnxQGM/xOqv06W1J0MQVRGJbHd/neOwqAhBMUBDoBLpmaDjcAG3UPTcLsmfuX
	pZ0VA6B0NapECFOYFlclacvQiqa0=
X-Google-Smtp-Source: AGHT+IFVsBiY4FP45Ci/g/NiTF5U6feukizhwMj6KFaBmjW2NWAWzyE4jYIKs7+jNfZ1cygT+XYINzcA+E7Ono6Ui1M=
X-Received: by 2002:a17:907:2daa:b0:a7a:ab1a:2d71 with SMTP id
 a640c23a62f3a-a7dc51bd5cbmr889891066b.59.1722874226314; Mon, 05 Aug 2024
 09:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805013446.814357-1-chengzhihao@huaweicloud.com>
In-Reply-To: <20240805013446.814357-1-chengzhihao@huaweicloud.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 5 Aug 2024 18:10:13 +0200
Message-ID: <CAGudoHHVnB3ZV1Pa235uqw+KoJZ6EN4b5An4LsW-z=EVhgHiVg@mail.gmail.com>
Subject: Re: [PATCH] vfs: Don't evict inode under the inode lru traversing context
To: Zhihao Cheng <chengzhihao@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tahsin@google.com, 
	error27@gmail.com, tytso@mit.edu, rydercoding@hotmail.com, jack@suse.cz, 
	hch@infradead.org, andreas.dilger@intel.com, richard@nod.at, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	chengzhihao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
	wangzhaolong1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 3:24=E2=80=AFAM Zhihao Cheng <chengzhihao@huaweiclou=
d.com> wrote:
>
> From: Zhihao Cheng <chengzhihao1@huawei.com>
>
> The inode reclaiming process(See function prune_icache_sb) collects all
> reclaimable inodes and mark them with I_FREEING flag at first, at that
> time, other processes will be stuck if they try getting these inodes
> (See function find_inode_fast), then the reclaiming process destroy the
> inodes by function dispose_list(). Some filesystems(eg. ext4 with
> ea_inode feature, ubifs with xattr) may do inode lookup in the inode
> evicting callback function, if the inode lookup is operated under the
> inode lru traversing context, deadlock problems may happen.
>
> Case 1: In function ext4_evict_inode(), the ea inode lookup could happen
>         if ea_inode feature is enabled, the lookup process will be stuck
>         under the evicting context like this:
>
>  1. File A has inode i_reg and an ea inode i_ea
>  2. getfattr(A, xattr_buf) // i_ea is added into lru // lru->i_ea
>  3. Then, following three processes running like this:
>
>     PA                              PB
>  echo 2 > /proc/sys/vm/drop_caches
>   shrink_slab
>    prune_dcache_sb
>    // i_reg is added into lru, lru->i_ea->i_reg
>    prune_icache_sb
>     list_lru_walk_one
>      inode_lru_isolate
>       i_ea->i_state |=3D I_FREEING // set inode state
>      inode_lru_isolate
>       __iget(i_reg)
>       spin_unlock(&i_reg->i_lock)
>       spin_unlock(lru_lock)
>                                      rm file A
>                                       i_reg->nlink =3D 0
>       iput(i_reg) // i_reg->nlink is 0, do evict
>        ext4_evict_inode
>         ext4_xattr_delete_inode
>          ext4_xattr_inode_dec_ref_all
>           ext4_xattr_inode_iget
>            ext4_iget(i_ea->i_ino)
>             iget_locked
>              find_inode_fast
>               __wait_on_freeing_inode(i_ea) ----=E2=86=92 AA deadlock
>     dispose_list // cannot be executed by prune_icache_sb
>      wake_up_bit(&i_ea->i_state)
>
> Case 2: In deleted inode writing function ubifs_jnl_write_inode(), file
>         deleting process holds BASEHD's wbuf->io_mutex while getting the
>         xattr inode, which could race with inode reclaiming process(The
>         reclaiming process could try locking BASEHD's wbuf->io_mutex in
>         inode evicting function), then an ABBA deadlock problem would
>         happen as following:
>
>  1. File A has inode ia and a xattr(with inode ixa), regular file B has
>     inode ib and a xattr.
>  2. getfattr(A, xattr_buf) // ixa is added into lru // lru->ixa
>  3. Then, following three processes running like this:
>
>         PA                PB                        PC
>                 echo 2 > /proc/sys/vm/drop_caches
>                  shrink_slab
>                   prune_dcache_sb
>                   // ib and ia are added into lru, lru->ixa->ib->ia
>                   prune_icache_sb
>                    list_lru_walk_one
>                     inode_lru_isolate
>                      ixa->i_state |=3D I_FREEING // set inode state
>                     inode_lru_isolate
>                      __iget(ib)
>                      spin_unlock(&ib->i_lock)
>                      spin_unlock(lru_lock)
>                                                    rm file B
>                                                     ib->nlink =3D 0
>  rm file A
>   iput(ia)
>    ubifs_evict_inode(ia)
>     ubifs_jnl_delete_inode(ia)
>      ubifs_jnl_write_inode(ia)
>       make_reservation(BASEHD) // Lock wbuf->io_mutex
>       ubifs_iget(ixa->i_ino)
>        iget_locked
>         find_inode_fast
>          __wait_on_freeing_inode(ixa)
>           |          iput(ib) // ib->nlink is 0, do evict
>           |           ubifs_evict_inode
>           |            ubifs_jnl_delete_inode(ib)
>           =E2=86=93             ubifs_jnl_write_inode
>      ABBA deadlock =E2=86=90-----make_reservation(BASEHD)
>                    dispose_list // cannot be executed by prune_icache_sb
>                     wake_up_bit(&ixa->i_state)
>
> Fix it by forbidding inode evicting under the inode lru traversing
> context. In details, we import a new inode state flag 'I_LRU_ISOLATING'
> to pin inode without holding i_count under the inode lru traversing
> context, the inode evicting process will wait until this flag is
> cleared from i_state.
>
> Link: https://lore.kernel.org/all/37c29c42-7685-d1f0-067d-63582ffac405@hu=
aweicloud.com/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219022
> Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
> Fixes: 7959cf3a7506 ("ubifs: journal: Handle xattrs like files")

I only have some tidy-ups with stuff I neglected to mention when
typing up my proposal.

> ---
>  fs/inode.c         | 37 +++++++++++++++++++++++++++++++++++--
>  include/linux/fs.h |  5 +++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 86670941884b..f1c6e8072f39 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -488,6 +488,36 @@ static void inode_lru_list_del(struct inode *inode)
>                 this_cpu_dec(nr_unused);
>  }
>
> +static void inode_lru_isolating(struct inode *inode)
> +{

        lockdep_assert_held(&inode->i_lock);

> +       BUG_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FRE=
E));
> +       inode->i_state |=3D I_LRU_ISOLATING;
> +}
> +
> +static void inode_lru_finish_isolating(struct inode *inode)
> +{
> +       spin_lock(&inode->i_lock);
> +       BUG_ON(!(inode->i_state & I_LRU_ISOLATING));
> +       inode->i_state &=3D ~I_LRU_ISOLATING;
> +       wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
> +       spin_unlock(&inode->i_lock);
> +}
> +
> +static void inode_wait_for_lru_isolating(struct inode *inode)
> +{
> +       DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
> +       wait_queue_head_t *wqh;
> +

Top of evict() asserts on I_FREEING being set, used to decide it's not
legit to pin above. This dependency can be documented it in the
routine as well:

BUG_ON(!(inode->i_state & I_FREEING));

> +       spin_lock(&inode->i_lock);

This lock acquire is avoidable, which is always nice to do for
single-threaded perf. Probably can be also done for the writeback code
below. Maybe I'll massage it myself after the patch lands.

> +       wqh =3D bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
> +       while (inode->i_state & I_LRU_ISOLATING) {
> +               spin_unlock(&inode->i_lock);
> +               __wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
> +               spin_lock(&inode->i_lock);
> +       }
> +       spin_unlock(&inode->i_lock);
> +}

So new arrivals *are* blocked by this point thanks to I_FREEING being
set on entry to evict(). This also means the flag can show up at most
once.

Thus instead of looping this should merely go to sleep once and assert
the I_LRU_ISOLATING flag is no longer set after waking up.

> +
>  /**
>   * inode_sb_list_add - add inode to the superblock list of inodes
>   * @inode: inode to add
> @@ -657,6 +687,9 @@ static void evict(struct inode *inode)
>
>         inode_sb_list_del(inode);
>
> +       /* Wait for LRU isolating to finish. */

I don't think this comment adds anything given the name of the func.

> +       inode_wait_for_lru_isolating(inode);
> +
>         /*
>          * Wait for flusher thread to be done with the inode so that file=
system
>          * does not start destroying it while writeback is still running.=
 Since
> @@ -855,7 +888,7 @@ static enum lru_status inode_lru_isolate(struct list_=
head *item,
>          * be under pressure before the cache inside the highmem zone.
>          */
>         if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
> -               __iget(inode);
> +               inode_lru_isolating(inode);
>                 spin_unlock(&inode->i_lock);
>                 spin_unlock(lru_lock);
>                 if (remove_inode_buffers(inode)) {
> @@ -867,7 +900,7 @@ static enum lru_status inode_lru_isolate(struct list_=
head *item,
>                                 __count_vm_events(PGINODESTEAL, reap);
>                         mm_account_reclaimed_pages(reap);
>                 }
> -               iput(inode);
> +               inode_lru_finish_isolating(inode);
>                 spin_lock(lru_lock);
>                 return LRU_RETRY;
>         }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..fb0426f349fc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2392,6 +2392,9 @@ static inline void kiocb_clone(struct kiocb *kiocb,=
 struct kiocb *kiocb_src,
>   *
>   * I_PINNING_FSCACHE_WB        Inode is pinning an fscache object for wr=
iteback.
>   *
> + * I_LRU_ISOLATING     Inode is pinned being isolated from LRU without h=
olding
> + *                     i_count.
> + *
>   * Q: What is the difference between I_WILL_FREE and I_FREEING?
>   */
>  #define I_DIRTY_SYNC           (1 << 0)
> @@ -2415,6 +2418,8 @@ static inline void kiocb_clone(struct kiocb *kiocb,=
 struct kiocb *kiocb_src,
>  #define I_DONTCACHE            (1 << 16)
>  #define I_SYNC_QUEUED          (1 << 17)
>  #define I_PINNING_NETFS_WB     (1 << 18)
> +#define __I_LRU_ISOLATING      19
> +#define I_LRU_ISOLATING                (1 << __I_LRU_ISOLATING)
>
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
>  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> --
> 2.39.2
>


--=20
Mateusz Guzik <mjguzik gmail.com>

