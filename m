Return-Path: <linux-fsdevel+bounces-44381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893FA680E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C01727CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 23:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FA0209F2A;
	Tue, 18 Mar 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="bmltcFh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4E1E1E03
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341703; cv=none; b=BAu9c6broLXj1l7KEKhfQp5nYifLytQ+IBnvXlBOQ7v2mAWYLO6KwcFSKvYocEt6jRqD2hxFVgZTiTM9aGoRNOuwMt+/gsiko58kYLU2IRsWlQ5Ec62igFU9f02o4DNB7mJhSImgrzxuwXoXsiLrpNr5lddOhV8jdkE6WDnnYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341703; c=relaxed/simple;
	bh=owtQHzDcTFCGAoSc3JYGk77LcDrZ9gqG74YnNAq63Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPlxcxVI6EsxESWTlWRxQCSz4jJNWrj89KRXv37JVK6gNirgbiV6ZDlcIyCI0AEIo3DZFVbnwuCD2U3J8yZXUqxpiIGcMVWkd8HgIJEYHCatxSlMU+C+cLLrIJCiZ3j7UDuF1lTVsRnoa0aVviKA0nzrVJe4ms9tFtsMAewj/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=bmltcFh4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so102200475ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 16:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1742341700; x=1742946500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PR+NKwosoobeaGRhVj5bivnn5154fgxDCBRgqjhOj3M=;
        b=bmltcFh4K17mbFhokOwuioMYmaeOOEGsZj7J+65Du+CIcL3mY8DRSe0IFJf83VFxLE
         D1Rm6wjO3Rd26+tRxo45dv5efBIa0lLdhthuewD4Wc5h5Vco7A4XuGhvtozfDXUXZF8c
         hgWUNtB+kdMGHobRNxiUeDmbB5fNapeyiXodL20XY8mUuQDBVEJQdB133Bg2VOWXXLH7
         R/9CVq8lNCtplhRu4cgOEv5GQPmsabEXkIQsyWozKm6SG0T6RbTiDPeNYQcrKpfOy621
         z852ESJAT8dm9cjsYbK6VoNeNSbrS4PBNPzf6yGZxSWOK0MYvRV8y5FJjms+zHjbSiBN
         fSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742341700; x=1742946500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PR+NKwosoobeaGRhVj5bivnn5154fgxDCBRgqjhOj3M=;
        b=bIuwG1p7kMela4VkjrjgX8e1mLIbbm0ckd4tE/NI9faXYfYf5fjUlOPd6ZENfIzo3v
         SpsKHk38UAuU5Az3D9XHDIw73Z3qQqkhxM2ReEdvhyrMrjK/vUvfcYJMtNeDHoM/8+m4
         yjL+Ap89BN6B4407lL6GNFWRsnj9vQn7eMzooLMrtdtM5BEV7jXhw+pdyd0GLuHAzy4q
         4DeNf2EVupatSG1yAmZr4Wo2GyuuHExlZAFt68clSucC3a/uhbZPJtT236+ZHVihuLmv
         T2oOjPoja2YSjtl1Ne6p6qUpMgJ03SY6EL0nsnsL0cxf42GliV/Z8NP080zvKUECdTsh
         fy1w==
X-Forwarded-Encrypted: i=1; AJvYcCVzLpeGTkLxCGcIZ8v7qGWb2hR/B/rB1R80YYQoH+0D7oTesh3P24HwG5+rT81VtorRyrlfbNRWeNqnX/vw@vger.kernel.org
X-Gm-Message-State: AOJu0YxQl3OZ9v7pb7jELy8g0mxw642YQVmM4xRfeBgaS+DyUn+83B+p
	xlfBI06sxPiiyj1soATEkjvaiuca9Gw+q/h4qr+wm1SHqKan/F0sO4ldSt+haIwkE/9L4cd/+tv
	658yrsg==
X-Gm-Gg: ASbGncvv8P8jojaGee9gtMBlUmeo6kKvVHeyPybDFUE1Ft04XFVQ4z7+fnepR6uNDex
	67S26W2pXiD/xtqY6DXFxY2/WQFOgyQ1E5E3R7Q85veVwqYW7lT6DeJ6HtiPWidcKj0XZVJK01R
	4dflGy0vrvWkxWrxwtETyMiyrlDBASlPrO9dZJIKgF58xckW8RqMDL8hy+kkWfIEGq92KFshQVr
	n2LVh0MydC+VeNwZlFzXl5KMBvzpQ0DkkngXSF5LzXONkWxt5s7AzOonPP4apX6Dx8nVojRsYBW
	Dr6rvCLV7zL1Ga85+8r+YlTVPeSStgrRkwjlqoxnxhwgJY8HDVu+
X-Google-Smtp-Source: AGHT+IFyxWq0NDJLDdOXscQWHRlDquTdmazyjqfr1H0MQwU0SvnopnHeB67q9jz5PNGD3nvFA3sBeg==
X-Received: by 2002:a17:902:db12:b0:220:c4e8:3b9d with SMTP id d9443c01a7336-22649a47649mr7826925ad.37.1742341700180;
        Tue, 18 Mar 2025 16:48:20 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430::48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7b6sm101137395ad.177.2025.03.18.16.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:48:19 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	amarkuze@redhat.com
Cc: dhowells@redhat.com,
	idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [RFC PATCH] ceph: fix ceph_fallocate() ignoring of FALLOC_FL_ALLOCATE_RANGE mode
Date: Tue, 18 Mar 2025 16:47:52 -0700
Message-ID: <20250318234752.886003-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The fio test reveals the issue for the case of file size
is not aligned on 4K (for example, 4122, 8600, 10K etc).
The reproducing path:

target_dir=/mnt/cephfs
report_dir=/report
size=100ki
nrfiles=10
pattern=0x74657374

fio --runtime=5M --rw=write --bs=4k --size=$size \
--nrfiles=$nrfiles --numjobs=16 --buffer_pattern=0x74657374 \
--iodepth=1 --direct=0 --ioengine=libaio --group_reporting \
--name=fiotest --directory=$target_dir \
--output $report_dir/sequential_write.log

fio --runtime=5M --verify_only --verify=pattern \
--verify_pattern=0x74657374 --size=$size --nrfiles=$nrfiles \
--numjobs=16 --bs=4k --iodepth=1 --direct=0 --name=fiotest \
--ioengine=libaio --group_reporting --verify_fatal=1 \
--verify_state_save=0 --directory=$target_dir \
--output $report_dir/verify_sequential_write.log

The essence of the issue that the write phase calls
the fallocate() to pre-allocate 10K of file size and, then,
it writes only 8KB of data. However, CephFS code
in ceph_fallocate() ignores the FALLOC_FL_ALLOCATE_RANGE
mode and, finally, file is 8K in size only. As a result,
verification phase initiates wierd behaviour of CephFS code.
CephFS code calls ceph_fallocate() again and completely
re-write the file content by some garbage. Finally,
verification phase fails because file contains unexpected
data pattern.

fio: got pattern 'd0', wanted '74'. Bad bits 3
fio: bad pattern block offset 0
pattern: verify failed at file /mnt/cephfs/fiotest.3.0 offset 0, length 2631490270 (requested block: offset=0, length=4096, flags=8)
fio: verify type mismatch (36969 media, 18 given)
fio: got pattern '25', wanted '74'. Bad bits 3
fio: bad pattern block offset 0
pattern: verify failed at file /mnt/cephfs/fiotest.4.0 offset 0, length 1694436820 (requested block: offset=0, length=4096, flags=8)
fio: verify type mismatch (6714 media, 18 given)

Expected state ot the file:

hexdump -C ./fiotest.0.0
00000000 74 65 73 74 74 65 73 74 74 65 73 74 74 65 73 74 |testtesttesttest| *
00002000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 |................| *
00002190 00 00 00 00 00 00 00 00 |........|
00002198

Real state of the file:

head -n 2 ./fiotest.0.0
00000000 35 e0 28 cc 38 a0 99 16 06 9c 6a a9 f2 cd e9 0a |5.(.8.....j.....|
00000010 80 53 2a 07 09 e5 0d 15 70 4a 25 f7 0b 39 9d 18 |.S*.....pJ%..9..|

The patch reworks ceph_fallocate() method by means of adding
support of FALLOC_FL_ALLOCATE_RANGE mode. Also, it adds the checking
that new size can be allocated by means of checking inode_newsize_ok(),
fsc->max_file_size, and ceph_quota_is_max_bytes_exceeded().
Invalidation and making dirty logic is moved into dedicated
methods.

There is one peculiarity for the case of generic/103 test.
CephFS logic receives max_file_size from MDS server and it's 1TB
by default. As a result, generic/103 can fail if max_file_size
is smaller than volume size:

generic/103 6s ... - output mismatch (see /home/slavad/XFSTESTS/xfstests-dev/results//generic/103.out.bad)
--- tests/generic/103.out 2025-02-25 13:05:32.494668258 -0800
+++ /home/slavad/XFSTESTS/xfstests-dev/results//generic/103.out.bad 2025-03-17 22:28:26.475750878 -0700
@ -1,2 +1,3 @
QA output created by 103
+fallocate: No space left on device
Silence is golden.

The solution is to set the max_file_size equal to volume size:

sudo ceph fs volume info cephfs
{
    "mon_addrs": [
        "192.168.1.213:6789",
        "192.168.1.212:6789",
        "192.168.1.195:6789"
    ],
    "pools": {
        "data": [
            {
                "avail": 7531994808320,
                "name": "cephfs_data",
                "used": 163955761152
            }
        ],
        "metadata": [
            {
                "avail": 7531994808320,
                "name": "cephfs_metadata",
                "used": 706346483
            }
        ]
    }
}

sudo ceph fs set cephfs max_file_size 7531994808320

sudo ./check generic/103
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 ceph-0005 6.14.0-rc5+ #82 SMP PREEMPT_DYNAMIC Tue Mar 18 14:12:08 PDT 2025
MKFS_OPTIONS  -- 192.168.1.212:6789:/scratch
MOUNT_OPTIONS -- -o name=admin 192.168.1.212:6789:/scratch /mnt/cephfs/scratch

generic/103 6s ...  8s
Ran: generic/103
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/file.c | 114 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 91 insertions(+), 23 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 851d70200c6b..7bf283eba29a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2655,24 +2655,64 @@ static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
 	return ret;
 }
 
-static long ceph_fallocate(struct file *file, int mode,
+static inline
+void ceph_fallocate_mark_dirty(struct inode *inode,
+				struct ceph_cap_flush **prealloc_cf)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	int dirty;
+
+	spin_lock(&ci->i_ceph_lock);
+	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
+					prealloc_cf);
+	spin_unlock(&ci->i_ceph_lock);
+
+	if (dirty)
+		__mark_inode_dirty(inode, dirty);
+}
+
+static inline
+int ceph_fallocate_invalidate(struct inode *inode,
+				struct ceph_cap_flush **prealloc_cf,
 				loff_t offset, loff_t length)
+{
+	int ret = 0;
+
+	filemap_invalidate_lock(inode->i_mapping);
+	ceph_fscache_invalidate(inode, false);
+	ceph_zero_pagecache_range(inode, offset, length);
+	ret = ceph_zero_objects(inode, offset, length);
+	if (!ret)
+		ceph_fallocate_mark_dirty(inode, prealloc_cf);
+	filemap_invalidate_unlock(inode->i_mapping);
+
+	return ret;
+}
+
+static long ceph_fallocate(struct file *file, int mode,
+			   loff_t offset, loff_t length)
 {
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap_flush *prealloc_cf;
 	struct ceph_client *cl = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int want, got = 0;
-	int dirty;
-	int ret = 0;
 	loff_t endoff = 0;
 	loff_t size;
+	loff_t new_size;
+	int ret = 0;
 
 	doutc(cl, "%p %llx.%llx mode %x, offset %llu length %llu\n",
 	      inode, ceph_vinop(inode), mode, offset, length);
 
-	if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+	if (mode == FALLOC_FL_ALLOCATE_RANGE ||
+	    mode == (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
+		/*
+		 * Supported modes. Continue logic.
+		 */
+	} else
 		return -EOPNOTSUPP;
 
 	if (!S_ISREG(inode->i_mode))
@@ -2687,18 +2727,35 @@ static long ceph_fallocate(struct file *file, int mode,
 
 	inode_lock(inode);
 
+	size = i_size_read(inode);
+	new_size = offset + length;
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && new_size > size) {
+		ret = inode_newsize_ok(inode, new_size);
+		if (ret)
+			goto unlock;
+
+		if (new_size > max(size, fsc->max_file_size)) {
+			ret = -ENOSPC;
+			goto unlock;
+		}
+
+		if (ceph_quota_is_max_bytes_exceeded(inode, offset + length)) {
+			ret = -EDQUOT;
+			goto unlock;
+		}
+	}
+
 	if (ceph_snap(inode) != CEPH_NOSNAP) {
 		ret = -EROFS;
 		goto unlock;
 	}
 
-	size = i_size_read(inode);
-
-	/* Are we punching a hole beyond EOF? */
-	if (offset >= size)
-		goto unlock;
-	if ((offset + length) > size)
-		length = size - offset;
+	if ((mode & FALLOC_FL_KEEP_SIZE) || (mode & FALLOC_FL_PUNCH_HOLE)) {
+		/* Are we punching a hole beyond EOF? */
+		if (offset >= size)
+			goto unlock;
+	}
 
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
@@ -2713,20 +2770,31 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (ret)
 		goto put_caps;
 
-	filemap_invalidate_lock(inode->i_mapping);
-	ceph_fscache_invalidate(inode, false);
-	ceph_zero_pagecache_range(inode, offset, length);
-	ret = ceph_zero_objects(inode, offset, length);
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		if ((offset + length) > size)
+			length = size - offset;
 
-	if (!ret) {
-		spin_lock(&ci->i_ceph_lock);
-		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
-					       &prealloc_cf);
-		spin_unlock(&ci->i_ceph_lock);
-		if (dirty)
-			__mark_inode_dirty(inode, dirty);
+		ret = ceph_fallocate_invalidate(inode, &prealloc_cf,
+						offset, length);
+	} else if (mode & FALLOC_FL_KEEP_SIZE) {
+		/*
+		 * If the FALLOC_FL_KEEP_SIZE flag is specified in mode,
+		 * then the file size will not be changed even
+		 * if offset+size is greater than the file size.
+		 */
+	} else {
+		/*
+		 * FALLOC_FL_ALLOCATE_RANGE case:
+		 * The default operation (i.e., mode is zero) of fallocate()
+		 * allocates the disk space within the range specified by
+		 * offset and size.  The file size will be changed if
+		 * offset+size is greater than the file size.
+		 */
+		if ((offset + length) > size) {
+			ceph_inode_set_size(inode, offset + length);
+			ceph_fallocate_mark_dirty(inode, &prealloc_cf);
+		}
 	}
-	filemap_invalidate_unlock(inode->i_mapping);
 
 put_caps:
 	ceph_put_cap_refs(ci, got);
-- 
2.48.0


