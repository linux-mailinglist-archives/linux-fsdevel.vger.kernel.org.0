Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B931320D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 09:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgAGIBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 03:01:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45678 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgAGIBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:01:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so75329810otp.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 00:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sDizgeLJIfmRd5NSswY0RkdPnNnLRyBjmNA5/1HpEw8=;
        b=HikvB18OPX8a6L3Qz8aPJXdIUsWcCSnHjsextW+2Lv65CndgPq8FSgBg35k3dTeS9o
         O96b/tb458Cx9Cv7IXRMDlxz4JafAMbolx4bUyy+Up92YoGW0wNgP1xcSmpPamk797jd
         Yec+8Kf1ygnEbaLxY5Dj9ZcYSYH7z4BgCf6J747/wkgpsjQ4eg3hfqNZQtNFJxuyKtN0
         UBTAnrOajvlF2YJEjvSHPvlj2HgN1zJq5d0O3cWmsUBx/fBidcky8I9ArSQrZg47oZrM
         dpFMWXQqx+uRAficB8Xbki833FNvitjLCivLclsPjNbvcP6me0hxhui+WJzXVwr4CvL6
         vWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sDizgeLJIfmRd5NSswY0RkdPnNnLRyBjmNA5/1HpEw8=;
        b=lTDCI1jIMoyJ9cOEoJznFSDcv5X6qhAEKYlI0mow7aRNEwJ9mQfk5OnFDHQxKpjRNW
         zXKLtjyD676IjO364BSaL5wkWtB+blbq13dTpF89P4xTBTg/OkIeNDGon7d8Nj0VSt1Y
         ykE2oMewjFn8DELoDKL0RiLuDQC37SEMlW7S+479uMNyMC3G3nsECDAbRBJTIY6K7l+x
         KtGnDd1gKSPfDOTYuvvyadp5eljdbtyEq4aO08X6+zoeUOw0EDBaYn/PimvqZtYeICFp
         z53iKalztw0wrIK2mbtntuqXUOhA6uvNPRd1U5JQBXRfbcfRdppg2rHgNzg3pMM4TYay
         I9KA==
X-Gm-Message-State: APjAAAVwNnlqEemE2HSu3D31WfunTG3Y2H77g+12FJ5wsW7J1olZyfhK
        A8KNTymHKfjGwuKZY3EjAUFZKw==
X-Google-Smtp-Source: APXvYqwWbc4wjGeSXt9FvaXv5Qkt+OfLw/WpqY6NuISI4kfsIeZM+gW4mDXARdLliWW3lWx7LDcCvA==
X-Received: by 2002:a05:6830:1385:: with SMTP id d5mr91933187otq.61.1578384098420;
        Tue, 07 Jan 2020 00:01:38 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e65sm25138868otb.62.2020.01.07.00.01.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jan 2020 00:01:37 -0800 (PST)
Date:   Tue, 7 Jan 2020 00:01:17 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>
cc:     "zhengbin (A)" <zhengbin13@huawei.com>,
        "J. R. Okajima" <hooanon05g@gmail.com>,
        Linux MM <linux-mm@kvack.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 1/2] tmpfs: Add per-superblock i_ino support
In-Reply-To: <CAOQ4uxijrY7mRkAW1OEym7Xi=v6+fDjhAVBfucwtWPx6bokr5Q@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2001062304500.1496@eggly.anvils>
References: <cover.1578225806.git.chris@chrisdown.name> <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578225806.git.chris@chrisdown.name> <4106bf3f-5c99-77a4-717e-10a0ffa6a3fa@huawei.com> <CAOQ4uxijrY7mRkAW1OEym7Xi=v6+fDjhAVBfucwtWPx6bokr5Q@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Jan 2020, Amir Goldstein wrote:
> On Mon, Jan 6, 2020 at 4:04 AM zhengbin (A) <zhengbin13@huawei.com> wrote:
> > On 2020/1/5 20:06, Chris Down wrote:
> > > get_next_ino has a number of problems:
> > >
> > > - It uses and returns a uint, which is susceptible to become overflowed
> > >   if a lot of volatile inodes that use get_next_ino are created.
> > > - It's global, with no specificity per-sb or even per-filesystem. This
> > >   means it's not that difficult to cause inode number wraparounds on a
> > >   single device, which can result in having multiple distinct inodes
> > >   with the same inode number.
> > >
> > > This patch adds a per-superblock counter that mitigates the second case.
> > > This design also allows us to later have a specific i_ino size
> > > per-device, for example, allowing users to choose whether to use 32- or
> > > 64-bit inodes for each tmpfs mount. This is implemented in the next
> > > commit.
> > >
> > > Signed-off-by: Chris Down <chris@chrisdown.name>
> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Jeff Layton <jlayton@kernel.org>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: kernel-team@fb.com
> > > ---
> > >  include/linux/shmem_fs.h |  1 +
> > >  mm/shmem.c               | 30 +++++++++++++++++++++++++++++-
> > >  2 files changed, 30 insertions(+), 1 deletion(-)
> > >
> > > v5: Nothing in code, just resending with correct linux-mm domain.
> > >
> > > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > > index de8e4b71e3ba..7fac91f490dc 100644
> > > --- a/include/linux/shmem_fs.h
> > > +++ b/include/linux/shmem_fs.h
> > > @@ -35,6 +35,7 @@ struct shmem_sb_info {
> > >       unsigned char huge;         /* Whether to try for hugepages */
> > >       kuid_t uid;                 /* Mount uid for root directory */
> > >       kgid_t gid;                 /* Mount gid for root directory */
> > > +     ino_t next_ino;             /* The next per-sb inode number to use */
> > >       struct mempolicy *mpol;     /* default memory policy for mappings */
> > >       spinlock_t shrinklist_lock;   /* Protects shrinklist */
> > >       struct list_head shrinklist;  /* List of shinkable inodes */
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 8793e8cc1a48..9e97ba972225 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2236,6 +2236,12 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> > >       return 0;
> > >  }
> > >
> > > +/*
> > > + * shmem_get_inode - reserve, allocate, and initialise a new inode
> > > + *
> > > + * If this tmpfs is from kern_mount we use get_next_ino, which is global, since
> > > + * inum churn there is low and this avoids taking locks.
> > > + */
> > >  static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
> > >                                    umode_t mode, dev_t dev, unsigned long flags)
> > >  {
> > > @@ -2248,7 +2254,28 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
> > >
> > >       inode = new_inode(sb);
> > >       if (inode) {
> > > -             inode->i_ino = get_next_ino();
> > > +             if (sb->s_flags & SB_KERNMOUNT) {
> > > +                     /*
> > > +                      * __shmem_file_setup, one of our callers, is lock-free:
> > > +                      * it doesn't hold stat_lock in shmem_reserve_inode
> > > +                      * since max_inodes is always 0, and is called from
> > > +                      * potentially unknown contexts. As such, use the global
> > > +                      * allocator which doesn't require the per-sb stat_lock.
> > > +                      */
> > > +                     inode->i_ino = get_next_ino();
> > > +             } else {
> > > +                     spin_lock(&sbinfo->stat_lock);
> >
> > Use spin_lock will affect performance, how about define
> >
> > unsigned long __percpu *last_ino_number; /* Last inode number */
> > atomic64_t shared_last_ino_number; /* Shared last inode number */
> > in shmem_sb_info, whose performance will be better?
> >
> 
> Please take a look at shmem_reserve_inode().
> spin lock is already being taken in shmem_get_inode()
> so there is nothing to be gained from complicating next_ino counter.
> 
> This fact would have been a lot clearer if next_ino was incremented
> inside shmem_reserve_inode() and its value returned to be used by
> shmem_get_inode(), but I am also fine with code as it is with the
> comment above.

Chris, Amir, thank you both for all the work you have been putting
into this over the holiday.  I'm only now catching up, sorry.

It appears that what you are ending up with above is very close to
the patch Google has been using for several years.  I'm glad Chris
has explored some interesting options, disappointed that you had no
more success than I had in trying to solve it efficiently with 32-bit
inos, agree with the way in which Amir cut it back.  That we've come to
the same conclusions independently is good confirmation of this approach.

Only yesterday did I get to see that Amir had asked to see my patch on
the 27th: rediffed against 5.5-rc5, appended now below.  I'm showing it,
though it's known deficient in three ways (not to mention lack of config
or mount options, but I now see Dave Chinner has an interesting take on
those) - better make it visible to you now, than me delay you further.

It does indicate a couple of improvements to Chris's current patch:
reducing use of stat_lock, as Amir suggested (in both nr_inodes limited
and unlimited cases); and need to fix shmem_encode_fh(), which neither
of us did yet.  Where we should go from here, fix Chris's or fix mine,
I've not decided.

From: Hugh Dickins <hughd@google.com>
Date: Fri, 7 Aug 2015 20:08:53 -0700
Subject: [PATCH] tmpfs: provide 64-bit inode numbers

Some programs (including ld.so and clang) try to deduplicate opened
files by comparing st_dev and st_ino, which breaks down when two files
on the same tmpfs have the same inode number: we are now hitting this
problem too often.  J. R. Okajima has reported the same problem with
backup tools.

tmpfs is currently sharing the same 32-bit get_next_ino() pool as
sockets, pipes, ramfs, hugetlbfs etc.  It delivers 32-bit inos even
on a 64-bit kernel for one reason: because if a 32-bit executable
compiled without _FILE_OFFSET_BITS=64 tries to stat a file with an
ino which won't fit in 32 bits, glibc fails that with EOVERFLOW.
glibc is being correct, but unhelpful: so 2.6.22 commit 866b04fccbf1
("inode numbering: make static counters in new_inode and iunique be
32 bits") forced get_next_ino() to unsigned int.

But whatever the upstream need to avoid surprising a mis-built
32-bit executable, Google production can be sure of the 64-bit
environment, and any remaining 32-bit executables built with
_FILE_OFFSET_BITS=64 (our files are sometimes bigger than 2G).

So, leave get_next_ino() as it is, but convert tmpfs to supply
unsigned long inos, and let each superblock keep its own account:
it was weird to be sharing a pool with such disparate uses before.

shmem_reserve_inode() already provides a good place to do this;
and normally it has to take stat_lock to update free_inodes, so
no overhead to increment its next_ino under the same lock.  But
if it's the internal shm_mnt, or mounted with "nr_inodes=0" to
increase scalability by avoiding that stat_lock, then use the
same percpu batching technique as get_next_ino().

Take on board 4.2 commit 2adc376c5519 ("vfs: avoid creation of
inode number 0 in get_next_ino"): for safety, skip any ino whose
low 32 bits is 0.

Upstream?  That's tougher: maybe try to upstream this as is, and
see what falls out; maybe add ino32 or ino64 mount options before
trying; or maybe upstream has to stick with the 32-bit ino, and a
scheme more complicated than this be implemented for tmpfs.

Not-Yet-Signed-off-by: Hugh Dickins <hughd@google.com>

1) Probably needs minor corrections for the 32-bit kernel: I wasn't
   worrying about that at the time, and expect some "unsigned long"s
   I didn't need to change for the 64-bit kernel actually need to be
   "u64"s or "ino_t"s now.
2) The "return 1" from shmem_encode_fh() would nowadays be written as
   "return FILEID_INO32_GEN" (and overlayfs takes particular interest
   in that fileid); yet it already put the high 32 bits of the ino into
   the fh: probably needs a different fileid once high 32 bits are set.
3) When this patch was written, a tmpfs could not be remounted from
   limited nr_inodes to unlimited nr_inodes=0; but that restriction
   was accidentally (though sensibly) lifted during v5.4's mount API
   mods; so would need to be taken into account (or reverted) here.
---

 include/linux/shmem_fs.h |    2 +
 mm/shmem.c               |   59 ++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 4 deletions(-)

--- 5.5-rc5/include/linux/shmem_fs.h	2019-11-24 16:32:01.000000000 -0800
+++ linux/include/linux/shmem_fs.h	2020-01-06 19:58:04.487301841 -0800
@@ -30,6 +30,8 @@ struct shmem_sb_info {
 	struct percpu_counter used_blocks;  /* How many are allocated */
 	unsigned long max_inodes;   /* How many inodes are allowed */
 	unsigned long free_inodes;  /* How many are left for allocation */
+	unsigned long next_ino;	    /* Next inode number to be allocated */
+	unsigned long __percpu *ino_batch; /* Next per cpu, if unlimited */
 	spinlock_t stat_lock;	    /* Serialize shmem_sb_info changes */
 	umode_t mode;		    /* Mount mode for root directory */
 	unsigned char huge;	    /* Whether to try for hugepages */
--- 5.5-rc5/mm/shmem.c	2019-12-08 18:04:55.053566640 -0800
+++ linux/mm/shmem.c	2020-01-06 19:58:04.487301841 -0800
@@ -261,9 +261,24 @@ bool vma_is_shmem(struct vm_area_struct
 static LIST_HEAD(shmem_swaplist);
 static DEFINE_MUTEX(shmem_swaplist_mutex);
 
-static int shmem_reserve_inode(struct super_block *sb)
+/*
+ * shmem_reserve_inode() reserves "space" for a shmem inode, and allocates
+ * an ino.  Unlike get_next_ino() in fs/inode.c, the 64-bit kernel here goes
+ * for a 64-bit st_ino, expecting even 32-bit userspace to have been built
+ * with _FILE_OFFSET_BITS=64 nowadays; but lest it has not, each sb uses its
+ * own supply, independent of sockets and pipes etc, and of other tmpfs sbs.
+ * Maybe add a 32-bit ino mount option later, if it turns out to be needed.
+ * Don't worry about 64-bit ino support from a 32-bit kernel at this time.
+ *
+ * shmem_reserve_inode() is also called when making a hard link, to allow for
+ * the space needed by each dentry; but no new ino is wanted then (NULL inop).
+ */
+#define SHMEM_INO_BATCH 1024
+static int shmem_reserve_inode(struct super_block *sb, unsigned long *inop)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+	unsigned long ino;
+
 	if (sbinfo->max_inodes) {
 		spin_lock(&sbinfo->stat_lock);
 		if (!sbinfo->free_inodes) {
@@ -271,7 +286,35 @@ static int shmem_reserve_inode(struct su
 			return -ENOSPC;
 		}
 		sbinfo->free_inodes--;
+		if (inop) {
+			ino = sbinfo->next_ino++;
+			/* Avoid 0 in the low 32 bits: might appear deleted */
+			if (unlikely((unsigned int)ino == 0))
+				ino = sbinfo->next_ino++;
+			*inop = ino;
+		}
 		spin_unlock(&sbinfo->stat_lock);
+	} else if (inop) {
+		unsigned long *next_ino;
+		/*
+		 * Internal shm_mnt, or mounted with unlimited nr_inodes=0 for
+		 * maximum scalability: we don't need to take stat_lock every
+		 * time here, so use percpu batching like get_next_ino().
+		 */
+		next_ino = per_cpu_ptr(sbinfo->ino_batch, get_cpu());
+		ino = *next_ino;
+		if (unlikely((ino & (SHMEM_INO_BATCH-1)) == 0)) {
+			spin_lock(&sbinfo->stat_lock);
+			ino = sbinfo->next_ino;
+			sbinfo->next_ino += SHMEM_INO_BATCH;
+			spin_unlock(&sbinfo->stat_lock);
+			/* Avoid 0 in the low 32 bits: might appear deleted */
+			if (unlikely((unsigned int)ino == 0))
+				ino++;
+		}
+		*inop = ino;
+		*next_ino = ++ino;
+		put_cpu();
 	}
 	return 0;
 }
@@ -2241,13 +2284,14 @@ static struct inode *shmem_get_inode(str
 	struct inode *inode;
 	struct shmem_inode_info *info;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+	unsigned long ino;
 
-	if (shmem_reserve_inode(sb))
+	if (shmem_reserve_inode(sb, &ino))
 		return NULL;
 
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		inode->i_ino = ino;
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -2960,7 +3004,7 @@ static int shmem_link(struct dentry *old
 	 * first link must skip that, to get the accounting right.
 	 */
 	if (inode->i_nlink) {
-		ret = shmem_reserve_inode(inode->i_sb);
+		ret = shmem_reserve_inode(inode->i_sb, NULL);
 		if (ret)
 			goto out;
 	}
@@ -3621,6 +3665,7 @@ static void shmem_put_super(struct super
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
 	kfree(sbinfo);
@@ -3663,6 +3708,12 @@ static int shmem_fill_super(struct super
 #endif
 	sbinfo->max_blocks = ctx->blocks;
 	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
+	/* If inodes are unlimited for scalability, use percpu ino batching */
+	if (!sbinfo->max_inodes) {
+		sbinfo->ino_batch = alloc_percpu(unsigned long);
+		if (!sbinfo->ino_batch)
+			goto failed;
+	}
 	sbinfo->uid = ctx->uid;
 	sbinfo->gid = ctx->gid;
 	sbinfo->mode = ctx->mode;
