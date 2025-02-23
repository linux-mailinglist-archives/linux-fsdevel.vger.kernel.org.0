Return-Path: <linux-fsdevel+bounces-42352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2BA40CE1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 06:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4BE16EB62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 05:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C101C860A;
	Sun, 23 Feb 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrlBTFIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CB10A3E
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740290300; cv=none; b=PGQ68Hqpxa+KrxY5rHwtPbykVIiQYIajxnGG0/Ter15dTrwGCJIJ57CxF+EC9rRqLFE7YAsp/li77ToZCTd2fJcYEDujGP4s/tEDGZjIYfalJAIQFNPBjSI32uWRAFLpD1hMQzABD3AUZ4AndWHA7AW4gr50g6F+GH7CUST7jdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740290300; c=relaxed/simple;
	bh=l9gI3X/2jmA5DiwT08AFj9Iga9fihS+aUnHjc6aiX2c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GVJ8J+3QIUQfB+Ga1s5OCConGOoMItIr1vA5dDTuAw7CPxFrPFWUTBiw8QQCuMzZbfaCnCOCSS9r42GOtXf++sIlQQTItpPRkIbnT6l/W/0f/YpCwFykmtjh6CqDKCNAI9eR+Q2nDJiuMZExtDmuPPhXpfbyQm0F0pK4++OmCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrlBTFIl; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc3db58932so5059041a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2025 21:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740290297; x=1740895097; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BGZJFtPJi93pDl+vFPJ8Fizj9SCziKJ5IL8J9wS43lg=;
        b=HrlBTFIlpzfgNqzjln3VXPUb6mFbVPnKS3e8jaQo60naFXrh6uwiasPH/v7eFNe2+F
         PF4GccUFldhXdp0J93WYOOWLItJuFCuZQbLzSQ1odCzDTpKwvFXSxdGuOH3YY35XLxHM
         ecI38mGuAp2JXKhmQ1hE2boyrY00b1WZ6V4PW38NRWwvsMPJQ+xIpD1BqAWg0xp2girK
         VGqcQCLv6/DwJV5hgkyu7+3bMBY6xIVefAwsivkYvNwPsk0JvGa4PL5+NswRlxqC5GVT
         KXEHDDr4S0qIPE35IfeYqu5YFkMzQMdSjC6osObPa7pQCgEpfbzrpEkXJ0XZmEL8Kdvg
         Jlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740290297; x=1740895097;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGZJFtPJi93pDl+vFPJ8Fizj9SCziKJ5IL8J9wS43lg=;
        b=sKBC7wx4WyTzf9QhphGGG8nk8OPdC1sdJ6aZ/gUBgW3gvxCpcQYwd3ax1LzrjVQdA7
         ap9HCt+jk9xI+wSTktUBqSgtUnlDgWCd+NQcctRbX4U+ABo1gelaLUr/7rWkZfnp86PP
         gAI7H5v6pVmidFeF37T6z8BTO7DdGpEjgu3u21nkicEHu12hdLVJitrPmonEJcd5vSny
         gIDx63fTKaLVwCDq8WlQrZEhK7WIHm5fX6ewj4GICdylq7fdb4UZ0zyMJ9zY6tAhs2W9
         qT7YhK9kvKLUJnjp30RF1NHbZ9pGgusHe5AtToxvVvrjUkD1F6NN+ZmJOfG7qD/HHoGg
         2MdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDi3SizYrP62OV1VKhxu8AB+xsVjLVopoJxFaW2yZR0I6NuxY1eccIus19ZP0b2RFeDesZvQoIfTPo4Q3h@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHPDeB5TqFb12oj8uGX3DONtdm798fA/5tnL0rbch71nnHDXG
	H2BidIQD2OUNpxaql8KSyCMuecjJT4YYiG6COobAB31JfmyGm8bS
X-Gm-Gg: ASbGnctqFs/dkPBAjf06MJXSawf3i5gF+24S5bhB0+9YaF3TItxokvy6TdqV4yyfQ6u
	tzljQENRbS67mMdu611Zbg0Ulr+M5BXUNwSD2kWcZ/kmUnzMyZi633fTAoYKjXD6W39shKHkj1H
	dE4hiIDtk3CD5nwa2utz7uMLGCClfW++BV5R61S2XI1Lo9Z6GM5oqLk57slSPX7n1zzj6jsSjh2
	wHrd4ssCraiHwf6c5os4vi2bZ+xyR5PIw7craaMwRgaPtKhPMpx5SrO9roqHStPqRloqE1yqL8i
	B6ZDhlS0HkoVxmvOsQ==
X-Google-Smtp-Source: AGHT+IHqU/8HpogskbuizH8U8Q2G1weY64/81zcdnrMILOeUk3/UP81xhXgHSVyKMEPnIQe1f1eM+A==
X-Received: by 2002:a05:6a21:1796:b0:1ee:d418:f758 with SMTP id adf61e73a8af0-1eef3c889e0mr14861134637.17.1740290297146;
        Sat, 22 Feb 2025 21:58:17 -0800 (PST)
Received: from dw-tp ([171.76.82.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adcd481d902sm12636077a12.21.2025.02.22.21.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 21:58:16 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kalesh Singh <kaleshsingh@google.com>, lsf-pc@lists.linux-foundation.org, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
In-Reply-To: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
Date: Sun, 23 Feb 2025 11:04:50 +0530
Message-ID: <87wmdhgr5x.fsf@gmail.com>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Kalesh Singh <kaleshsingh@google.com> writes:

> Hi organizers of LSF/MM,
>
> I realize this is a late submission, but I was hoping there might
> still be a chance to have this topic considered for discussion.
>
> Problem Statement
> ===============
>
> Readahead can result in unnecessary page cache pollution for mapped
> regions that are never accessed. Current mechanisms to disable
> readahead lack granularity and rather operate at the file or VMA

From what I understand the readahead setting is done at the per-bdi
level (default set to 128K). That means we don't get to control the
amount of readahead pages needed on a per file basis. If say we can
control the amount of readahead pages on a per open fd, will that solve
the problem you are facing? That also means we don't need to change the
setting for the entire system, but we can control this knob on a per fd
basis? 

I just quickly hacked fcntl to allow setting no. of ra_pages in
inode->i_ra_pages. Readahead algorithm then takes this setting whenever
it initializes the readahead control in "file_ra_state_init()"
So after one opens the file, we can set the fcntl F_SET_FILE_READAHEAD
to the preferred value on the open fd. 


Note: I am not saying the implementation could be 100% correct. But it's
just a quick working PoC to discuss whether this is the right approach
to the given problem.

-ritesh


<quick patch>
===========
fcntl: Add control to set per inode readahead pages

As of now readahead setting is done in units of pages at the bdi level.
(default 128K).
But sometimes the user wants to have more granular control over this
knob on a per file basis. This adds support to control readahead pages
on an open fd.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/btrfs/defrag.c           |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/relocation.c       |  2 +-
 fs/btrfs/send.c             |  2 +-
 fs/cramfs/inode.c           |  2 +-
 fs/fcntl.c                  | 44 +++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4file.c           |  2 +-
 fs/open.c                   |  2 +-
 include/linux/fs.h          |  4 +++-
 include/uapi/linux/fcntl.h  |  2 ++
 mm/readahead.c              |  7 ++++--
 11 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 968dae953948..c6616d69a9af 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -261,7 +261,7 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	range.len = (u64)-1;
 	range.start = cur;
 	range.extent_thresh = defrag->extent_thresh;
-	file_ra_state_init(ra, inode->i_mapping);
+	file_ra_state_init(ra, inode);
 
 	sb_start_write(fs_info->sb);
 	ret = btrfs_defrag_file(inode, ra, &range, defrag->transid,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index cfa52ef40b06..ac240b148747 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -373,7 +373,7 @@ static void readahead_cache(struct inode *inode)
 	struct file_ra_state ra;
 	unsigned long last_index;
 
-	file_ra_state_init(&ra, inode->i_mapping);
+	file_ra_state_init(&ra, inode);
 	last_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
 	page_cache_sync_readahead(inode->i_mapping, &ra, NULL, 0, last_index);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bf267bdfa8f8..7688b79ae7e7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3057,7 +3057,7 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 	if (ret)
 		goto out;
 
-	file_ra_state_init(ra, inode->i_mapping);
+	file_ra_state_init(ra, inode);
 
 	ret = setup_relocation_extent_mapping(rc);
 	if (ret)
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7254279c3cc9..b22fc2a426e4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5745,7 +5745,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 			return err;
 		}
 		memset(&sctx->ra, 0, sizeof(struct file_ra_state));
-		file_ra_state_init(&sctx->ra, sctx->cur_inode->i_mapping);
+		file_ra_state_init(&sctx->ra, sctx->cur_inode);
 
 		/*
 		 * It's very likely there are no pages from this inode in the page
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b84d1747a020..917f09040f6e 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -214,7 +214,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 	devsize = bdev_nr_bytes(sb->s_bdev) >> PAGE_SHIFT;
 
 	/* Ok, read in BLKS_PER_BUF pages completely first. */
-	file_ra_state_init(&ra, mapping);
+	file_ra_state_init(&ra, mapping->host);
 	page_cache_sync_readahead(mapping, &ra, NULL, blocknr, BLKS_PER_BUF);
 
 	for (i = 0; i < BLKS_PER_BUF; i++) {
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 49884fa3c81d..277afe78536f 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -394,6 +394,44 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static long fcntl_get_file_readahead(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	u64 __user *argp = (u64 __user *)arg;
+	u64 ra_pages = READ_ONCE(inode->i_ra_pages);
+
+	if (copy_to_user(argp, &ra_pages, sizeof(*argp)))
+		return -EFAULT;
+	return 0;
+}
+
+
+static long fcntl_set_file_readahead(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	u64 __user *argp = (u64 __user *)arg;
+	u64 ra_pages;
+
+	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
+		return -EPERM;
+
+	if (copy_from_user(&ra_pages, argp, sizeof(ra_pages)))
+		return -EFAULT;
+
+	WRITE_ONCE(inode->i_ra_pages, ra_pages);
+
+	/*
+	 * file->f_mapping->host may differ from inode. As an example,
+	 * blkdev_open() modifies file->f_mapping.
+	 */
+	if (file->f_mapping->host != inode)
+		WRITE_ONCE(file->f_mapping->host->i_ra_pages, ra_pages);
+
+	return 0;
+}
+
 /* Is the file descriptor a dup of the file? */
 static long f_dupfd_query(int fd, struct file *filp)
 {
@@ -552,6 +590,12 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_RW_HINT:
 		err = fcntl_set_rw_hint(filp, cmd, arg);
 		break;
+	case F_GET_FILE_READAHEAD:
+		err = fcntl_get_file_readahead(filp, cmd, arg);
+		break;
+	case F_SET_FILE_READAHEAD:
+		err = fcntl_set_file_readahead(filp, cmd, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1cd9652f3c28..cee84aa8aa0f 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -388,7 +388,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 	nfs_file_set_open_context(filep, ctx);
 	put_nfs_open_context(ctx);
 
-	file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mapping);
+	file_ra_state_init(&filep->f_ra, filep->f_mapping->host);
 	res = filep;
 out_free_name:
 	kfree(read_name);
diff --git a/fs/open.c b/fs/open.c
index 0f75e220b700..466c3affe161 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -961,7 +961,7 @@ static int do_dentry_open(struct file *f,
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 	f->f_iocb_flags = iocb_flags(f);
 
-	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
+	file_ra_state_init(&f->f_ra, f->f_mapping->host);
 
 	if ((f->f_flags & O_DIRECT) && !(f->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 12fe11b6e3dd..77ee23e30245 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -678,6 +678,8 @@ struct inode {
 	unsigned short          i_bytes;
 	u8			i_blkbits;
 	enum rw_hint		i_write_hint;
+	/* Per inode setting for max readahead in page_size units */
+	unsigned long		i_ra_pages;
 	blkcnt_t		i_blocks;
 
 #ifdef __NEED_I_SIZE_ORDERED
@@ -3271,7 +3273,7 @@ extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
 
 
 extern void
-file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
+file_ra_state_init(struct file_ra_state *ra, struct inode *inode);
 extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
 extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int whence);
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6e6907e63bfc..b6e5413ca660 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -60,6 +60,8 @@
 #define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
+#define F_GET_FILE_READAHEAD	(F_LINUX_SPECIFIC_BASE + 15)
+#define F_SET_FILE_READAHEAD	(F_LINUX_SPECIFIC_BASE + 16)
 
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
diff --git a/mm/readahead.c b/mm/readahead.c
index 2bc3abf07828..71079ae1753d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -136,9 +136,12 @@
  * memset *ra to zero.
  */
 void
-file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
+file_ra_state_init(struct file_ra_state *ra, struct inode *inode)
 {
-	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
+	unsigned int ra_pages = inode->i_ra_pages ? inode->i_ra_pages :
+				inode_to_bdi(inode)->ra_pages;
+
+	ra->ra_pages = ra_pages;
 	ra->prev_pos = -1;
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);

2.39.5

