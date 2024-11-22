Return-Path: <linux-fsdevel+bounces-35535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A819D57E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F031F21FE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869F5FDA7;
	Fri, 22 Nov 2024 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WzvJHj29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7E22087
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240615; cv=none; b=YtUoG1Jeh5xqD6LqQj2sFhPDUVu0ehK4ingV6acTxKPfyWMLZBnru6DSYbedLVvzyr5xDG5LnsX9N0OMHcDXcpRit0jGeP6hwy45/BWIg2xWzCEx8BSS6hpquqzOCseAeB7d/gOSpoYkYZ5b2FdhPCkUkm57ccpg7Sv5+X5x/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240615; c=relaxed/simple;
	bh=KkrkTNo5S8PdCIaycnsN7MtVrnpwTwYKHdgAtsIrOJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gti0tgzjeIUzbqDtcxw71MHZN7E3VMKmpJs2643iUO+YKbzn4KLf+P9P/HNErGW+2boe1cF+3VHPGXuJKw0w9b1ZkFpILdmDoX++W6jxccND0aW2f+vQ5H42g1EeOkkphkFwYJZgrjq+RilPiL+Z4r558tMlNuiTRVBY4MGsav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=WzvJHj29; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ea6f821decso1369119a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 17:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732240612; x=1732845412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYw2d70zj3fLcyL/GZSLH0sLEFFOIq2ghVO7jLs6al4=;
        b=WzvJHj29jumSZLeitXa7peEoGr52fDjkmnxAtqeIdFqv8RiHqWqLuwsEinKYJuLODS
         ue8D4DmvDyC0pSHQD54x1qsFs8YuPQ510h71ZAa1Z9UPGprWmxhXl4XG9aCCQDaNXfIm
         4R1II9X8JR2sRK/B1xkZUcB2Yc7IidjFsn6JOpcjqmkWYcpwNfz2RXrj4oJZ0BqwzLZg
         cWn8uk7nN3T/e56ZvcI1WHRomvMhef5VtkQVz6KrbUc0stM0EqnWMl4crABJNqdsty3w
         KGlYicNoTXJvwKQsnNlMspM1piBWBireLkCJHpNeKYLAF4yEkBn2qInPC6yVXmuk4iVP
         Oung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732240612; x=1732845412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYw2d70zj3fLcyL/GZSLH0sLEFFOIq2ghVO7jLs6al4=;
        b=RmqV1f1hz9pXEhJzhTIdfQTp4eTZA1YS3uDlRu6znLqDv/FwJG2cIshzAudmaQSIjT
         6fuhJBYBxI3fUS5YtvEoFGo5vHowwSR//WJwR6cB/1nU+GLEWOL2TLLVGukHkyVJ2w9G
         M+LnDNE/nmrcnxTyjjebdXs6KiIJz4BiVC3esW/FokN8O+ZpkzOHu3shgHn7MaS/GwTw
         pRu7UTLnFcW8+E3k+sI2XoBx3wi6380NuKh5CcEjPXEqjz5LUUcvogc430KlkGdDAGH6
         6L+Crcf8F91V7cEiprSYOOWU5OfS5xUemu5BpBxy3tCuu9d8rxaRyirbFgMFjW/Yxnu1
         puQg==
X-Forwarded-Encrypted: i=1; AJvYcCV1zr+PCD1x0Hgvp6qb1LZEAHb3TlyB4mFZ3SkKEBedjzdezxvFoArxtgy2roAgcEfTEe/kk9i0ooBsECs0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx36eh2QqAzGnvHEKSucZVXoOC03pbgWUzjpTMAXnzMT9Sq76v2
	pRfKjjXvh1C7l68yVRjjcR+0+8T0GSWNwjKJ2u7iHazd03cBMbBlxJBN1xcI50o=
X-Gm-Gg: ASbGncuRc8XYYoFf1CpUNgkG8lsinlUSrOXq02FBuityKgRwZX+R0HmgyRN8BerUoTu
	0MwDpv1sH72egh/hgC23F4KRKDOwQ2OMjtfQEiOHnw/+K63dBVc48XfsA/wwnLF70GuITMw41s7
	9Tjx5NNCbq9D+RhOS0n1NOr28OAxYdR8bUXkizbM9A/U1RI4VTFHs/1IxndiDV4FsvDfQqtbA0H
	B0oOgJtxDRsrOG5QBOUjbRuyfd68F6uRn98KLHWkwmW7XbQgI4rUVlW4su9UOxhDof8doiN7/kn
	M7ogeL7QQd4AqwxW386DXlgQuw==
X-Google-Smtp-Source: AGHT+IG5UfbjzHrcBQ6JBzzjEPdk8N0DmBlY27dT4IXLy8mOucaRHdLyvzq4hqFdrjdY5qkD8nwwrw==
X-Received: by 2002:a17:90b:1c03:b0:2ea:546f:7e7b with SMTP id 98e67ed59e1d1-2eb0e52646amr1335784a91.20.1732240612595;
        Thu, 21 Nov 2024 17:56:52 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02ea3ddsm3954315a91.3.2024.11.21.17.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 17:56:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tEIue-00000001VSd-2OfP;
	Fri, 22 Nov 2024 12:56:48 +1100
Date: Fri, 22 Nov 2024 12:56:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hughd@google.com,
	linux-ext4@vger.kernel.org, tytso@mit.edu, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/3] vfs: support caching symlink lengths in inodes
Message-ID: <Zz_k4CtwOKGUbr6V@dread.disaster.area>
References: <20241120112037.822078-1-mjguzik@gmail.com>
 <20241120112037.822078-2-mjguzik@gmail.com>
 <20241121-seilschaft-zeitig-7c8c3431bd00@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121-seilschaft-zeitig-7c8c3431bd00@brauner>

On Thu, Nov 21, 2024 at 11:12:52AM +0100, Christian Brauner wrote:
> I think that i_devices should be moved into the union as it's really
> only used with i_cdev but it's not that easily done because list_head
> needs to be initialized.

I'm planning on using i_devices with block devices, too, so the
block device list doesn't need to use i_sb_list anymore (similar to
how i_devices is used by the char dev infrastructure. See the patch
below...

> I roughly envisioned something like:
> 
> union {
>         struct {
>                 struct cdev             *i_cdev;
>                 struct list_head        i_devices;
>         };
>         struct {
>                 char                    *i_link;
>                 unsigned int            i_link_len;
>         };
>         struct pipe_inode_info          *i_pipe;
>         unsigned                        i_dir_seq;
> };
> 

I'd probably have to undo any unioning/association with i_cdev to
use i_devices with block devs...

-Dave
-- 
Dave Chinner
david@fromorbit.com


bdev: stop using sb->s_inodes

From: Dave Chinner <dchinner@redhat.com>

Iteration of block device inodes is done via the
blockdev_superblock->s_inodes list. We want to remove this list and
the inode i_sb_list list heads, so we need some other way for block
devices to be iterated.

Take a leaf from the chardev code and use the inode->i_devices list
head to link all the block device inodes together and replace the
s_inodes list with a bdev private global list.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 block/bdev.c | 56 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 33f9c4605e3a..d733507f584a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -317,6 +317,8 @@ EXPORT_SYMBOL(bdev_thaw);
 
 static  __cacheline_aligned_in_smp DEFINE_MUTEX(bdev_lock);
 static struct kmem_cache *bdev_cachep __ro_after_init;
+static LIST_HEAD(bdev_inodes);
+static DEFINE_SPINLOCK(bdev_inodes_lock);
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
@@ -362,6 +364,10 @@ static void init_once(void *data)
 
 static void bdev_evict_inode(struct inode *inode)
 {
+	spin_lock(&bdev_inodes_lock);
+	list_del_init(&inode->i_devices);
+	spin_unlock(&bdev_inodes_lock);
+
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
@@ -412,19 +418,35 @@ void __init bdev_cache_init(void)
 	blockdev_superblock = blockdev_mnt->mnt_sb;   /* For writeback */
 }
 
-struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
+static struct inode *bdev_new_inode(void)
 {
-	struct block_device *bdev;
 	struct inode *inode;
 
-	inode = new_inode(blockdev_superblock);
+	inode = new_inode_pseudo(blockdev_superblock);
 	if (!inode)
 		return NULL;
+
+	spin_lock(&bdev_inodes_lock);
+	list_add(&inode->i_devices, &bdev_inodes);
+	spin_unlock(&bdev_inodes_lock);
+
 	inode->i_mode = S_IFBLK;
 	inode->i_rdev = 0;
 	inode->i_data.a_ops = &def_blk_aops;
 	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
 
+	return inode;
+}
+
+struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
+{
+	struct block_device *bdev;
+	struct inode *inode;
+
+	inode = bdev_new_inode();
+	if (!inode)
+		return NULL;
+
 	bdev = I_BDEV(inode);
 	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
@@ -477,10 +499,10 @@ long nr_blockdev_pages(void)
 	struct inode *inode;
 	long ret = 0;
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
+	spin_lock(&bdev_inodes_lock);
+	list_for_each_entry(inode, &bdev_inodes, i_devices)
 		ret += inode->i_mapping->nrpages;
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
+	spin_unlock(&bdev_inodes_lock);
 
 	return ret;
 }
@@ -1218,8 +1240,8 @@ void sync_bdevs(bool wait)
 {
 	struct inode *inode, *old_inode = NULL;
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
+	spin_lock(&bdev_inodes_lock);
+	list_for_each_entry(inode, &bdev_inodes, i_devices) {
 		struct address_space *mapping = inode->i_mapping;
 		struct block_device *bdev;
 
@@ -1231,14 +1253,14 @@ void sync_bdevs(bool wait)
 		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&blockdev_superblock->s_inode_list_lock);
+		spin_unlock(&bdev_inodes_lock);
+
 		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock  We cannot iput the inode now as we can
-		 * be holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
+		 * We hold a reference to 'inode' so it won't get removed from
+		 * bdev inodes list while we drop the lock.  We need to hold the
+		 * reference until we have a reference on the next inode on the
+		 * list, so we can't drop it until the next time we let go of
+		 * the bdev_inodes_lock.
 		 */
 		iput(old_inode);
 		old_inode = inode;
@@ -1260,9 +1282,9 @@ void sync_bdevs(bool wait)
 		}
 		mutex_unlock(&bdev->bd_disk->open_mutex);
 
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
+		spin_lock(&bdev_inodes_lock);
 	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
+	spin_unlock(&bdev_inodes_lock);
 	iput(old_inode);
 }
 

