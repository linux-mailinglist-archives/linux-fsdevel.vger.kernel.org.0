Return-Path: <linux-fsdevel+bounces-70948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C23CAB100
	for <lists+linux-fsdevel@lfdr.de>; Sun, 07 Dec 2025 04:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2E583006D9E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Dec 2025 03:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB425DB0D;
	Sun,  7 Dec 2025 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="JSsG+vG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7716CD33
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Dec 2025 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765079921; cv=none; b=CtWIq6FbxBpNx5BTcZ+zILErRmbChYHmG39ftYtp/hXDdlybId20K4JeHzmMxwhW2imjEV7vZrurkyn5SzxsiqjQkWLlI9xsE3ijkUF7OysC+LoWso3b2VB13q+ZLrhWs7Hzw5hytFjA0vFMO7BnSwDde0wZ5HS5YC9r2MyvSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765079921; c=relaxed/simple;
	bh=MW1IBt7tj5u7SAYIiSAFFifjUwvjDbPW0VLc8JcXH60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkRf+m6iz9V8EOxYsDcc7J8aleSniMI2Z/qwPRYM7Argz8ZxR7eZvams2E2m2Ozs5sKTPeQxUOfPV8NSdWsjZX3wY6VQ9vd4OeRPEXJr/Ftu+AeBJEH0Eo0rHetWQubYfhDhku8t24CD7mOjZ/G04v22R709brpLaI9+cWII9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=JSsG+vG6; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6432842cafdso3084497d50.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Dec 2025 19:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1765079918; x=1765684718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8Dhj7HqJsYQH3UAafMyWPGKGLGv5GqqtjsclhIZcjE=;
        b=JSsG+vG6V/hI/QEKlrteDddsbpljentdfLIy19B+v2itrQ9AY4Vz2pbO1mUoPSaq5Q
         xlErSdylossVCg5EfMlm6RCvevwQbR9KBaCCa6e4L/pohzHczqVAL2tAwReS/WNX96+d
         zVxYO3Jal/nGmidI5fJzJvga/ewpQKNVKf8FQAN9F/EwG33Lq5yc/HFWU16ygeW4RdPH
         ewMyWB++QGAV+E10hnv3xfByQnNOeP4XOMuow7YgWgjJgc6JxxEtkelvZZB8d4H9lD1+
         TIYArQZ3R37xHpthGADjgLepkQUSPc2CHYkBHdIUKBl+3M93b8p6LokS3DH/AA7xVzkz
         YSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765079918; x=1765684718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8Dhj7HqJsYQH3UAafMyWPGKGLGv5GqqtjsclhIZcjE=;
        b=IgKrqilMXt1dWilXYe/es21NhtBhpYnj5NzE4hnGcE4U+zsCcWk660fNPdnkPi7hfR
         5gw9udymHKFdIKThNGnDwHWRpBjOqqeJqPjWk8Goljt2meyb1UZyXfA4u11AS96agRC/
         qZLDHmUcB9o4XYXFja9fEQma4nfOz13bBH9++vermcXwILmSi4ChA0DeC1AGQEQrsjeO
         liWAt+/7Ost27qH6Zn3pvBdKeFmFsjIeUd5SbW/oe82jg4d6ARriE17Wnn9d82i1aSIC
         zarge7lL5PYgmBQUFyDYoLwISc5t6gdR++SirXOyR3c2elXxZfyJBLDuIalD3KBzxjko
         03LA==
X-Forwarded-Encrypted: i=1; AJvYcCU+atOJQhi1/TmJpLVpoLNVAApKavxYIHLEM+SVS1Lwsjinono0XmfJpU26+OMONUgwxZinVi3ffKucbDoD@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7/d3E19UPR2verMddpibHKDAvX64oFD/P0s1+zJipTaPnEVG
	1ktn2521p8HUvQZeg5Ffc7pBRyH+VKJAdC7Qkn9ICrJwBZpGVwpUYJaF/MWPB/dDWJ8=
X-Gm-Gg: ASbGncunGxYHL5EgHbrjqoTGFSN+igTIFkD2K4OumhD1yN9IEKQTRQM74D4NzdhHpQ0
	GLilkoESmhbJahOILaCrRHLB2vu6VAGttwblNvWyW7+jcmnv/DYGgXlX3N8cxhwOgJXgL4x0EYi
	8V2r+84PnS4BppZpmB9PuJ9B+kWe8HV9K7JdtE7G/UTaTlrZDsDKlQJRaT/ogMtOKXuiPEydYev
	90zbB5feyzyyZBpubKx/C+JC3v2LRW+KkRm4z2TsegK+92xVdqG+m35+mrWfjBEiefUJdX0KQFP
	mo6GfoaXl+9b+PJgwKXxOdETagbJs7hJ9DzevkaGxE2LE2nM6a1COPwAAkZ9vjr2Z9RLJ9NybqU
	JimIPFhV8iYLLue80lCE+xKQcx7i+mFe3sU/aT3PD9iCQ013FltCHq53DpdZYK4g0brW8Gwgeve
	Fpoyv4Zk9EzL/5GUCW2F2tyMs=
X-Google-Smtp-Source: AGHT+IF7IMPlGiWu+BIl+fSR5dTgu+L3aG1wLJfiqath2rj1T81EjX52oxD5AsB399iILGT3OrlYxw==
X-Received: by 2002:a05:690e:4362:b0:642:f9a9:74eb with SMTP id 956f58d0204a3-6444e7cae4amr2480094d50.71.1765079917800;
        Sat, 06 Dec 2025 19:58:37 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:e180:3200:8343:50ac])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f2abcf8sm3707339d50.4.2025.12.06.19.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 19:58:37 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix volume corruption issue for generic/498
Date: Sat,  6 Dec 2025 19:58:22 -0800
Message-Id: <20251207035821.3863657-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/498 leaves HFS+ volume
in corrupted state:

sudo ./check generic/498
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc1+ #18 SMP PREEMPT_DYNAMIC Thu Dec 4 12:24:45 PST 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/498 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see XFSTESTS-2/xfstests-dev/results//generic/498.full for details)

Ran: generic/498
Failures: generic/498
Failed 1 of 1 tests

sudo fsck.hfsplus -d /dev/loop51
** /dev/loop51
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
Invalid leaf record count
(It should be 16 instead of 2)
** Checking multi-linked files.
CheckHardLinks: found 1 pre-Leopard file inodes.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x8000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
CheckHardLinks: found 1 pre-Leopard file inodes.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.

The generic/498 test executes such steps on final phase:

mkdir $SCRATCH_MNT/A
mkdir $SCRATCH_MNT/B
mkdir $SCRATCH_MNT/A/C
touch $SCRATCH_MNT/B/foo
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/B/foo

ln $SCRATCH_MNT/B/foo $SCRATCH_MNT/A/C/foo
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/A

"Simulate a power failure and mount the filesystem
to check that what we explicitly fsync'ed exists."

_flakey_drop_and_remount

The FSCK tool complains about "Invalid leaf record count".
HFS+ b-tree header contains leaf_count field is updated
by hfs_brec_insert() and hfs_brec_remove(). The hfs_brec_insert()
is involved into hard link creation process. However,
modified in-core leaf_count field is stored into HFS+
b-tree header by hfs_btree_write() method. But,
unfortunately, hfs_btree_write() hasn't been called
by hfsplus_cat_write_inode() and hfsplus_file_fsync()
stores not fully consistent state of the Catalog File's
b-tree.

This patch adds calling hfs_btree_write() method in
the hfsplus_cat_write_inode() with the goal of
storing consistent state of Catalog File's b-tree.
Finally, it makes FSCK tool happy.

sudo ./check generic/498
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc1+ #22 SMP PREEMPT_DYNAMIC Sat Dec  6 17:01:31 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/498 33s ...  31s
Ran: generic/498
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 7ae6745ca7ae..cc03d3beaaa1 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -612,6 +612,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 int hfsplus_cat_write_inode(struct inode *inode)
 {
 	struct inode *main_inode = inode;
+	struct hfs_btree *tree = HFSPLUS_SB(inode->i_sb)->cat_tree;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
 	int res = 0;
@@ -622,7 +623,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (!main_inode->i_nlink)
 		return 0;
 
-	if (hfs_find_init(HFSPLUS_SB(main_inode->i_sb)->cat_tree, &fd))
+	if (hfs_find_init(tree, &fd))
 		/* panic? */
 		return -EIO;
 
@@ -687,6 +688,15 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
+
+	if (!res) {
+		res = hfs_btree_write(tree);
+		if (res) {
+			pr_err("b-tree write err: %d, ino %lu\n",
+			       res, inode->i_ino);
+		}
+	}
+
 	return res;
 }
 
-- 
2.43.0


