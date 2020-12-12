Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04A02D864C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 12:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438498AbgLLLsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 06:48:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438416AbgLLLsu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 06:48:50 -0500
Message-ID: <9ee191a5aadbabfe3571748072337b4fd0359800.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607773689;
        bh=31htvr81n75Zq7sOZci0YyM2LE18Gus6pGJOzZ3wjO8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CB/90MQWmWgCI91878UEQepx3xnX0byvzW2JkKxHDd1W4q1UojHkthfQHZkTkLSHT
         5wJlG+2tv+5NphaSHG9cEx8x5yjgSn6v32BglcwJrIOsOai6cFpL0L1UMRrLfEwBzb
         JsjGhalcSWKM9xyqER7G6fgErLWkBN06uUoyN9PIvFlpUyuE/VOP1vngzDqACmzCt0
         cap0qi/7nQrWWneVQzi6qaKkZv76GKinstJx8O8T72nWj2eojT5y3ORtjTVb78BmJJ
         HMXEWLx63Od045JM7rGG7uVIwDkg6RqcWP88/36m206M7c/ytnt1PYZLFPoWep/lHi
         9VCX9FMsCfjKA==
Subject: Re: [PATCH v2 0/3] Check errors on sync for volatile overlayfs
 mounts
From:   Jeff Layton <jlayton@kernel.org>
To:     Sargun Dhillon <sargun@sargun.me>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Sat, 12 Dec 2020 06:48:07 -0500
In-Reply-To: <7779e2ed97080009d894f3442bfad31972494542.camel@kernel.org>
References: <20201211235002.4195-1-sargun@sargun.me>
         <7779e2ed97080009d894f3442bfad31972494542.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-12-12 at 06:21 -0500, Jeff Layton wrote:
> On Fri, 2020-12-11 at 15:49 -0800, Sargun Dhillon wrote:
> > The semantics of errseq and syncfs are such that it is impossible to track
> > if any errors have occurred between the time the first error occurred, and
> > the user checks for the error (calls syncfs, and subsequently
> > errseq_check_and_advance.
> > 
> > Overlayfs has a volatile feature which short-circuits syncfs. This, in turn
> > makes it so that the user can have silent data corruption and not know
> > about it. The third patch in the series introduces behaviour that makes it
> > so that we can track errors, and bubble up whether the user has put
> > themselves in bad situation.
> > 
> > This required some gymanstics in errseq, and adding a wrapper around it
> > called "errseq_counter" (errseq + counter). The data structure uses an
> > atomic to track overflow errors. This approach, rather than moving to an
> > atomic64 / u64 is so we can avoid bloating every person that subscribes to
> > an errseq, and only add the subscriber behaviour to those who care (at the
> > expense of space.
> > 
> > The datastructure is write-optimized, and rightfully so, as the users
> > of the counter feature are just overlayfs, and it's called in fsync
> > checking, which is a rather seldom operation, and not really on
> > any hotpaths.
> > 
> > [1]: https://lore.kernel.org/linux-fsdevel/20201202092720.41522-1-sargun@sargun.me/
> > 
> > Sargun Dhillon (3):
> >   errseq: Add errseq_counter to allow for all errors to be observed
> >   errseq: Add mechanism to snapshot errseq_counter and check snapshot
> >   overlay: Implement volatile-specific fsync error behaviour
> > 
> >  Documentation/filesystems/overlayfs.rst |   8 ++
> >  fs/buffer.c                             |   2 +-
> >  fs/overlayfs/file.c                     |   5 +-
> >  fs/overlayfs/overlayfs.h                |   1 +
> >  fs/overlayfs/ovl_entry.h                |   3 +
> >  fs/overlayfs/readdir.c                  |   5 +-
> >  fs/overlayfs/super.c                    |  26 +++--
> >  fs/overlayfs/util.c                     |  28 +++++
> >  fs/super.c                              |   1 +
> >  fs/sync.c                               |   3 +-
> >  include/linux/errseq.h                  |  18 ++++
> >  include/linux/fs.h                      |   6 +-
> >  include/linux/pagemap.h                 |   2 +-
> >  lib/errseq.c                            | 129 ++++++++++++++++++++----
> >  14 files changed, 202 insertions(+), 35 deletions(-)
> > 
> 
> It would hel if you could more clearly lay out the semantics you're
> looking for. If I understand correctly:
> 
> You basically want to be able to sample the sb->s_wb_err of the upper
> layer at mount time and then always return an error if any new errors
> were recorded since that point.
> 
> If that's correct, then I'm not sure I get need for all of this extra
> counter machinery. Why not just sample it at mount time without
> recording it as 0 if the seen flag isn't set. Then just do an
> errseq_check against the upper superblock (without advancing) in the
> overlayfs ->sync_fs routine and just errseq_set that error into the
> overlayfs superblock? The syncfs syscall wrapper should then always
> report the latest error.
> 
> Or (even better) rework all of the sync_fs/syncfs mess to be more sane,
> so that overlayfs has more control over what errors get returned to
> userland. ISTM that the main problem you have is that the
> errseq_check_and_advance is done in the syscall wrapper, and that's
> probably not appropriate for your use-case.
> 

Something like this is what I was thinking (completely untested, of
course and needs comments). Would this not give you what you want for
volatile mount syncfs semantics?

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094df8e..b7ada3fd04fd 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -79,6 +79,7 @@ struct ovl_fs {
 	atomic_long_t last_ino;
 	/* Whiteout dentry cache */
 	struct dentry *whiteout;
+	errseq_t err;
 };
 
 static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 290983bcfbb3..35780776360c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -264,8 +264,12 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	if (!ovl_upper_mnt(ofs))
 		return 0;
 
-	if (!ovl_should_sync(ofs))
-		return 0;
+	if (!ovl_should_sync(ofs)) {
+		ret = errseq_check(&upper_sb->s_wb_err, ofs->err);
+		errseq_set(&sb->s_wb_err, ret);
+		return ret;
+	}
+
 	/*
 	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 	 * All the super blocks will be iterated, including upper_sb.
@@ -1945,7 +1949,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 
 		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
 		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
-
+		ofs->err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
 	}
 	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
 	err = PTR_ERR(oe);
diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index fc2777770768..0d9ead687dc1 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -9,6 +9,7 @@ typedef u32	errseq_t;
 
 errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
+errseq_t errseq_sample_advance(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
 int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
 #endif
diff --git a/lib/errseq.c b/lib/errseq.c
index 81f9e33aa7e7..27ab3000507f 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -130,6 +130,25 @@ errseq_t errseq_sample(errseq_t *eseq)
 }
 EXPORT_SYMBOL(errseq_sample);
 
+errseq_t errseq_sample_advance(errseq_t *eseq)
+{
+	errseq_t old = READ_ONCE(*eseq);
+	errseq_t new = old;
+
+	/*
+	 * For the common case of no errors ever having been set, we can skip
+	 * marking the SEEN bit. Once an error has been set, the value will
+	 * never go back to zero.
+	 */
+	if (old != 0) {
+		new |= ERRSEQ_SEEN;
+		if (old != new)
+			cmpxchg(eseq, old, new);
+	}
+	return new;
+}
+EXPORT_SYMBOL(errseq_sample_advance);
+
 /**
  * errseq_check() - Has an error occurred since a particular sample point?
  * @eseq: Pointer to errseq_t value to be checked.


