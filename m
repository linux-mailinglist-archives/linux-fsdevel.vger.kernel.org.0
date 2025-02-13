Return-Path: <linux-fsdevel+bounces-41662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC9AA345EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 16:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596B116FB7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1782A1D1;
	Thu, 13 Feb 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnolaN+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB226B0A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459459; cv=none; b=ODMQCfY7wDo4UVZDpgHuxFqb4k4/u3kwMBJ5JpuG3a7kE/mYQUZMjnzlx3Fc0tRuoSUxTQ0ioT8MWxV0CgZp00Fi2SV2yoRfx9kgPnNlVfEMWkK+l7R0Ddx3BSaRwE8EuSMj0+jfeC6Am3PAvNioLRPl+vvrHzB+Moa9t1c1GJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459459; c=relaxed/simple;
	bh=6sWFKE3ygMeD9DJFO7+zNl/6OfLm2Ob7E2Ci8yKtLNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFqeESFFZNsrLK3FPycMI1SOzOQZ1UoJ4+HN2U8A34B5vR8SFVVAgtByqr49Kt7fKbJ849945/D3s3LCxzlzjXi5ARCH+lo507TLC4GPBHHCV/DNwnewrjGJIDAr1gjA7NIQWUvF34h2Ihi5PpkXu+ytk9wIpDyRia8lHV9SPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnolaN+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65F6C4CEE4;
	Thu, 13 Feb 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739459459;
	bh=6sWFKE3ygMeD9DJFO7+zNl/6OfLm2Ob7E2Ci8yKtLNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnolaN+nZaFslexqIoETjZ/cetRyZSSyc2Xdem6KAppiOwhZevxLq7jkWAKAuz7HU
	 v/R1jzyaKXHmJuMJ4Fqk3Z9+OmA4rtV8e+VaynmUGAFE4kEmj7yGA+9IJX6vns7FiE
	 FwAs6gbXTacynTDu9gO/ajjBklINQFU2WpXN/w0Cu0HSmqKLT+DHkZfsV61Ey7jGXB
	 76yIYNNvj6TEO3vZIG/IDd4iamzbRkU4uAY0G7RL/QGX5Qi7aIZwjU824ijWEyFOGJ
	 hfGcrilx77e2Ai/G6fU+d9tttaekJeiQozQ24YT/RXuij7pv/Pk7PC/Z/HM/RP5I1+
	 h7MBbt8SApstg==
Date: Thu, 13 Feb 2025 16:10:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
Message-ID: <20250213-eskalation-hellblau-cba3b6377b36@brauner>
References: <20250207-daten-mahlzeit-99d2079864fb@brauner>
 <hn5go2srp6csjkckh3sgru7moukgsa3glsvc6bwd5leabzamw6@osxrfpjw5wqq>
 <CAGudoHGGW0BZcqyWbEV7x3rtQnRCkhhkbHNhYB0QeihSnE0VTA@mail.gmail.com>
 <20250210-urfassung-heerscharen-aa9c46a64724@brauner>
 <rdvlpbbybxrlti5xywzlcmtq63ln2evibmzeqf3lvmyclaumsd@2s43fhbmrxqg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="volnlywmczmjulmh"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rdvlpbbybxrlti5xywzlcmtq63ln2evibmzeqf3lvmyclaumsd@2s43fhbmrxqg>


--volnlywmczmjulmh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Feb 10, 2025 at 03:58:17PM +0100, Jan Kara wrote:
> On Mon 10-02-25 13:01:38, Christian Brauner wrote:
> > On Fri, Feb 07, 2025 at 05:42:17PM +0100, Mateusz Guzik wrote:
> > > On Fri, Feb 7, 2025 at 4:50 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Fri 07-02-25 15:10:33, Christian Brauner wrote:
> > > > > Before 2011 there was no meaningful synchronization between
> > > > > read/readdir/write/seek. Only in commit
> > > > > ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
> > > > > synchronization was added for SEEK_CUR by taking f_lock around
> > > > > vfs_setpos().
> > > > >
> > > > > Then in 2014 full synchronization between read/readdir/write/seek was
> > > > > added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
> > > > > by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
> > > > > for directories. At that point taking f_lock became unnecessary for such
> > > > > files.
> > > > >
> > > > > So only acquire f_lock for SEEK_CUR if this isn't a file that would have
> > > > > acquired f_pos_lock if necessary.
> > > > >
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > >
> > > > ...
> > > >
> > > > >       if (whence == SEEK_CUR) {
> > > > > +             bool locked;
> > > > > +
> > > > >               /*
> > > > > -              * f_lock protects against read/modify/write race with
> > > > > -              * other SEEK_CURs. Note that parallel writes and reads
> > > > > -              * behave like SEEK_SET.
> > > > > +              * If the file requires locking via f_pos_lock we know
> > > > > +              * that mutual exclusion for SEEK_CUR on the same file
> > > > > +              * is guaranteed. If the file isn't locked, we take
> > > > > +              * f_lock to protect against f_pos races with other
> > > > > +              * SEEK_CURs.
> > > > >                */
> > > > > -             guard(spinlock)(&file->f_lock);
> > > > > -             return vfs_setpos(file, file->f_pos + offset, maxsize);
> > > > > +             locked = (file->f_mode & FMODE_ATOMIC_POS) ||
> > > > > +                      file->f_op->iterate_shared;
> > > >
> > > > As far as I understand the rationale this should match to
> > > > file_needs_f_pos_lock() (or it can possibly be weaker) but it isn't obvious
> > > > to me that's the case. After thinking about possibilities, I could convince
> > > > myself that what you suggest is indeed safe but the condition being in two
> > > > completely independent places and leading to subtle bugs if it gets out of
> > > > sync seems a bit fragile to me.
> > > >
> > > 
> > > A debug-only assert that the lock is held when expected should sort it out?
> > 
> > Good idea. Let me reuse the newly added infra:
> > VFS_WARN_ON_ONCE(locked && !mutex_is_locked(&file->f_pos_lock));
> 
> Fine, but won't this actually trigger? file_needs_f_pos_lock() is:
> 
>         return (file->f_mode & FMODE_ATOMIC_POS) &&
>                 (file_count(file) > 1 || file->f_op->iterate_shared);
> 
> and here you have:
> 
>         locked = (file->f_mode & FMODE_ATOMIC_POS) ||
>                   file->f_op->iterate_shared;
> 
> So if (file->f_mode & FMODE_ATOMIC_POS) and (file_count(file) == 1),
> file_needs_f_pos_lock() returns false but locked is true?

Sorry, I got lost in other mails.
Yes, you're right. I had changed the patch in my tree to fix that.
I'll append it here. Sorry about that. Tell me if that looks sane ok to
you now.

--volnlywmczmjulmh
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-don-t-needlessly-acquire-f_lock.patch"

From 1534e4816a5c128dbf6e6942ab43b780ec51b336 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 7 Feb 2025 15:10:33 +0100
Subject: [PATCH] fs: don't needlessly acquire f_lock

Before 2011 there was no meaningful synchronization between
read/readdir/write/seek. Only in commit
ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
synchronization was added for SEEK_CUR by taking f_lock around
vfs_setpos().

Then in 2014 full synchronization between read/readdir/write/seek was
added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
for directories. At that point taking f_lock became unnecessary for such
files.

So only acquire f_lock for SEEK_CUR if this isn't a file that would have
acquired f_pos_lock if necessary.

Link: https://lore.kernel.org/r/20250207-daten-mahlzeit-99d2079864fb@brauner
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file.c       | 10 ++++++++++
 fs/internal.h   |  1 +
 fs/read_write.c | 13 +++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index d868cdb95d1e..44efdc8c1e27 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1182,6 +1182,16 @@ static inline bool file_needs_f_pos_lock(struct file *file)
 		(file_count(file) > 1 || file->f_op->iterate_shared);
 }
 
+bool file_seek_cur_needs_f_lock(struct file *file)
+{
+	if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_shared)
+		return false;
+
+	VFS_WARN_ON_ONCE((file_count(file) > 1) &&
+			 !mutex_is_locked(&file->f_pos_lock));
+	return true;
+}
+
 struct fd fdget_pos(unsigned int fd)
 {
 	struct fd f = fdget(fd);
diff --git a/fs/internal.h b/fs/internal.h
index 84607e7b05dc..1cb85a62c07f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -338,3 +338,4 @@ static inline bool path_mounted(const struct path *path)
 	return path->mnt->mnt_root == path->dentry;
 }
 void file_f_owner_release(struct file *file);
+bool file_seek_cur_needs_f_lock(struct file *file);
diff --git a/fs/read_write.c b/fs/read_write.c
index a6133241dfb8..bb0ed26a0b3a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -169,11 +169,16 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
 
 	if (whence == SEEK_CUR) {
 		/*
-		 * f_lock protects against read/modify/write race with
-		 * other SEEK_CURs. Note that parallel writes and reads
-		 * behave like SEEK_SET.
+		 * If the file requires locking via f_pos_lock we know
+		 * that mutual exclusion for SEEK_CUR on the same file
+		 * is guaranteed. If the file isn't locked, we take
+		 * f_lock to protect against f_pos races with other
+		 * SEEK_CURs.
 		 */
-		guard(spinlock)(&file->f_lock);
+		if (file_seek_cur_needs_f_lock(file)) {
+			guard(spinlock)(&file->f_lock);
+			return vfs_setpos(file, file->f_pos + offset, maxsize);
+		}
 		return vfs_setpos(file, file->f_pos + offset, maxsize);
 	}
 
-- 
2.47.2


--volnlywmczmjulmh--

