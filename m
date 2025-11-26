Return-Path: <linux-fsdevel+bounces-69891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3217C8A170
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE36934CE17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60AC327200;
	Wed, 26 Nov 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw1BNnjT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C775281525;
	Wed, 26 Nov 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764164913; cv=none; b=ZFoUBOpBXe7Tt0DoA/XsY/aUgPIa6JeqQTPHsOGLZZcY96aLwuVD0JSm96JPIlZlNaP53/aWQgFVyx+vomffWUhVpnQZejrOGAbmYPUi86XboaAnrz/f5Wwyvau2lKHJEgFnt0iqlrhbBrn6t6wBeYmw2VgWoukcXQFtFp1ghGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764164913; c=relaxed/simple;
	bh=C46JPX9ZcAUZYj6SYYUQshAqyaNIL+SjXtfnjDmoayg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5R1632WTt+yR+6UbCZmue3Oa/zO+yRosDmD6lcHorJZnr71/aOvhgKeKOXu3NZuAcZ65CaSHCJL/aXcf422fHQ2DP5o8BzS53Wjl3etnaKylPM7Lcdm9tPk9kEqHN0Zuoy7YC4fAoqUjKS0jIjxejixKArdn6jkBYQRon6uH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw1BNnjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DD3C113D0;
	Wed, 26 Nov 2025 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764164912;
	bh=C46JPX9ZcAUZYj6SYYUQshAqyaNIL+SjXtfnjDmoayg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qw1BNnjTcoYUy8lGXF2ZVgQ7YMvO88sVDBNbiwT48jYhDqyq6UgWKJRAK6Zr9SpHM
	 vTvl1qGg/wTZMY6ZLuEQ8DpY2VrXO2K1Dgg8jxR2FYOe3Pc+a1GbCpcAb4R6I8msCd
	 tiEcQP1I2vCwLaX+QJPsU1+WTt3qMfjs8lekhJWIDWO+AK4k829hRT1ErG3/IyPHcm
	 En6AOy2UvRuczxA7SnqzLpO8luBVS46ZL2tyf49lDOWCFh4lqfvzxiWZMMvue7TVym
	 YSOJ59sgFkh6mI+IWqrFzRIu+4e7FoFHL6DQx6aECtClUeg2IBo+vye70pIDMf4PZe
	 JD/S+uDzueJQA==
Date: Wed, 26 Nov 2025 14:48:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
	"frank.li@vivo.com" <frank.li@vivo.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>, 
	"linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
	"david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>, 
	"syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com" <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
Message-ID: <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3s7phbv2fzuqvuhx"
Content-Disposition: inline
In-Reply-To: <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>


--3s7phbv2fzuqvuhx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Nov 19, 2025 at 07:58:21PM +0000, Viacheslav Dubeyko wrote:
> On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
> > The regression introduced by commit aca740cecbe5 ("fs: open block device
> > after superblock creation") allows setup_bdev_super() to fail after a new
> > superblock has been allocated by sget_fc(), but before hfs_fill_super()
> > takes ownership of the filesystem-specific s_fs_info data.
> > 
> > In that case, hfs_put_super() and the failure paths of hfs_fill_super()
> > are never reached, leaving the HFS mdb structures attached to s->s_fs_info
> > unreleased.The default kill_block_super() teardown also does not free 
> > HFS-specific resources, resulting in a memory leak on early mount failure.
> > 
> > Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
> > hfs_put_super() and the hfs_fill_super() failure path into a dedicated
> > hfs_kill_sb() implementation. This ensures that both normal unmount and
> > early teardown paths (including setup_bdev_super() failure) correctly
> > release HFS metadata.
> > 
> > This also preserves the intended layering: generic_shutdown_super()
> > handles VFS-side cleanup, while HFS filesystem state is fully destroyed
> > afterwards.
> > 
> > Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
> > Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6  
> > Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> > ---
> > ChangeLog:
> > 
> > Changes from v1:
> > 
> > -Changed the patch direction to focus on hfs changes specifically as 
> > suggested by al viro
> > 
> > Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com/  
> > 
> > Note:This patch might need some more testing as I only did run selftests 
> > with no regression, check dmesg output for no regression, run reproducer 
> > with no bug and test it with syzbot as well.
> 
> Have you run xfstests for the patch? Unfortunately, we have multiple xfstests
> failures for HFS now. And you can check the list of known issues here [1]. The
> main point of such run of xfstests is to check that maybe some issue(s) could be
> fixed by the patch. And, more important that you don't introduce new issues. ;)
> 
> > 
> >  fs/hfs/super.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > index 47f50fa555a4..06e1c25e47dc 100644
> > --- a/fs/hfs/super.c
> > +++ b/fs/hfs/super.c
> > @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
> >  {
> >  	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
> >  	hfs_mdb_close(sb);
> > -	/* release the MDB's resources */
> > -	hfs_mdb_put(sb);
> >  }
> >  
> >  static void flush_mdb(struct work_struct *work)
> > @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >  bail_no_root:
> >  	pr_err("get root inode failed\n");
> >  bail:
> > -	hfs_mdb_put(sb);
> >  	return res;
> >  }
> >  
> > @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
> >  	return 0;
> >  }
> >  
> > +static void hfs_kill_sb(struct super_block *sb)
> > +{
> > +	generic_shutdown_super(sb);
> > +	hfs_mdb_put(sb);
> > +	if (sb->s_bdev) {
> > +		sync_blockdev(sb->s_bdev);
> > +		bdev_fput(sb->s_bdev_file);
> > +	}
> > +
> > +}
> > +
> >  static struct file_system_type hfs_fs_type = {
> >  	.owner		= THIS_MODULE,
> >  	.name		= "hfs",
> > -	.kill_sb	= kill_block_super,
> 
> It looks like we have the same issue for the case of HFS+ [2]. Could you please
> double check that HFS+ should be fixed too?

There's no need to open-code this unless I'm missing something. All you
need is the following two patches - untested. Both issues were
introduced by the conversion to the new mount api.

--3s7phbv2fzuqvuhx
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-hfs-ensure-sb-s_fs_info-is-always-cleaned-up.patch"

From 058747cefb26196f3c192c76c631051581b29b27 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 19 Nov 2025 14:30:51 +0100
Subject: [PATCH 1/2] hfs: ensure sb->s_fs_info is always cleaned up

When hfs was converted to the new mount api a bug was introduced by
changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
fails after a new superblock has been allocated by sget_fc(), but before
hfs_fill_super() takes ownership of the filesystem-specific s_fs_info
data it was leaked.

Fix this by freeing sb->s_fs_info in hfs_kill_super().

Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/hfs/mdb.c   | 35 ++++++++++++++---------------------
 fs/hfs/super.c | 10 +++++++++-
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..f28cd24dee84 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -92,7 +92,7 @@ int hfs_mdb_get(struct super_block *sb)
 		/* See if this is an HFS filesystem */
 		bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
 		if (!bh)
-			goto out;
+			return -EIO;
 
 		if (mdb->drSigWord == cpu_to_be16(HFS_SUPER_MAGIC))
 			break;
@@ -102,13 +102,14 @@ int hfs_mdb_get(struct super_block *sb)
 		 * (should do this only for cdrom/loop though)
 		 */
 		if (hfs_part_find(sb, &part_start, &part_size))
-			goto out;
+			return -EIO;
 	}
 
 	HFS_SB(sb)->alloc_blksz = size = be32_to_cpu(mdb->drAlBlkSiz);
 	if (!size || (size & (HFS_SECTOR_SIZE - 1))) {
 		pr_err("bad allocation block size %d\n", size);
-		goto out_bh;
+		brelse(bh);
+		return -EIO;
 	}
 
 	size = min(HFS_SB(sb)->alloc_blksz, (u32)PAGE_SIZE);
@@ -125,14 +126,16 @@ int hfs_mdb_get(struct super_block *sb)
 	brelse(bh);
 	if (!sb_set_blocksize(sb, size)) {
 		pr_err("unable to set blocksize to %u\n", size);
-		goto out;
+		return -EIO;
 	}
 
 	bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
 	if (!bh)
-		goto out;
-	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC))
-		goto out_bh;
+		return -EIO;
+	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC)) {
+		brelse(bh);
+		return -EIO;
+	}
 
 	HFS_SB(sb)->mdb_bh = bh;
 	HFS_SB(sb)->mdb = mdb;
@@ -174,7 +177,7 @@ int hfs_mdb_get(struct super_block *sb)
 
 	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
 	if (!HFS_SB(sb)->bitmap)
-		goto out;
+		return -EIO;
 
 	/* read in the bitmap */
 	block = be16_to_cpu(mdb->drVBMSt) + part_start;
@@ -185,7 +188,7 @@ int hfs_mdb_get(struct super_block *sb)
 		bh = sb_bread(sb, off >> sb->s_blocksize_bits);
 		if (!bh) {
 			pr_err("unable to read volume bitmap\n");
-			goto out;
+			return -EIO;
 		}
 		off2 = off & (sb->s_blocksize - 1);
 		len = min((int)sb->s_blocksize - off2, size);
@@ -199,12 +202,12 @@ int hfs_mdb_get(struct super_block *sb)
 	HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
 	if (!HFS_SB(sb)->ext_tree) {
 		pr_err("unable to open extent tree\n");
-		goto out;
+		return -EIO;
 	}
 	HFS_SB(sb)->cat_tree = hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_keycmp);
 	if (!HFS_SB(sb)->cat_tree) {
 		pr_err("unable to open catalog tree\n");
-		goto out;
+		return -EIO;
 	}
 
 	attrib = mdb->drAtrb;
@@ -229,12 +232,6 @@ int hfs_mdb_get(struct super_block *sb)
 	}
 
 	return 0;
-
-out_bh:
-	brelse(bh);
-out:
-	hfs_mdb_put(sb);
-	return -EIO;
 }
 
 /*
@@ -359,8 +356,6 @@ void hfs_mdb_close(struct super_block *sb)
  * Release the resources associated with the in-core MDB.  */
 void hfs_mdb_put(struct super_block *sb)
 {
-	if (!HFS_SB(sb))
-		return;
 	/* free the B-trees */
 	hfs_btree_close(HFS_SB(sb)->ext_tree);
 	hfs_btree_close(HFS_SB(sb)->cat_tree);
@@ -373,6 +368,4 @@ void hfs_mdb_put(struct super_block *sb)
 	unload_nls(HFS_SB(sb)->nls_disk);
 
 	kfree(HFS_SB(sb)->bitmap);
-	kfree(HFS_SB(sb));
-	sb->s_fs_info = NULL;
 }
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a4..df289cbdd4e8 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -431,10 +431,18 @@ static int hfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void hfs_kill_super(struct super_block *sb)
+{
+	struct hfs_sb_info *hsb = HFS_SB(sb);
+
+	kill_block_super(sb);
+	kfree(hsb);
+}
+
 static struct file_system_type hfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfs",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfs_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfs_init_fs_context,
 };
-- 
2.47.3


--3s7phbv2fzuqvuhx
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-hfsplus-ensure-sb-s_fs_info-is-always-cleaned-up.patch"

From 54b8d07c3e1a22dc07ecb03415edd96524d14642 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 26 Nov 2025 14:43:24 +0100
Subject: [PATCH 2/2] hfsplus: ensure sb->s_fs_info is always cleaned up

When hfsplus was converted to the new mount api a bug was introduced by
changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
fails after a new superblock has been allocated by sget_fc(), but before
hfsplus_fill_super() takes ownership of the filesystem-specific s_fs_info
data it was leaked.

Fix this by freeing sb->s_fs_info in hfsplus_kill_super().

commit 432f7c78cb00 ("hfsplus: convert hfsplus to use the new mount api")
Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/hfsplus/super.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 16bc4abc67e0..8734520f6419 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -328,8 +328,6 @@ static void hfsplus_put_super(struct super_block *sb)
 	hfs_btree_close(sbi->ext_tree);
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
-	call_rcu(&sbi->rcu, delayed_free);
-
 	hfs_dbg("finished\n");
 }
 
@@ -629,7 +627,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 out_unload_nls:
 	unload_nls(sbi->nls);
 	unload_nls(nls);
-	kfree(sbi);
 	return err;
 }
 
@@ -688,10 +685,18 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void hfsplus_kill_super(struct super_block *sb)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+
+	kill_block_super(sb);
+	call_rcu(&sbi->rcu, delayed_free);
+}
+
 static struct file_system_type hfsplus_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfsplus",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfsplus_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfsplus_init_fs_context,
 };
-- 
2.47.3


--3s7phbv2fzuqvuhx--

