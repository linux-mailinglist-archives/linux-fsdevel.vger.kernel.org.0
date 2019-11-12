Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44065F8F7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 13:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKLMO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 07:14:26 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:41081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLMO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:14:26 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MN5Nt-1iELfw33sz-00J2Ua; Tue, 12 Nov 2019 13:09:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 4/5] xfs: extend inode format for 40-bit timestamps
Date:   Tue, 12 Nov 2019 13:09:09 +0100
Message-Id: <20191112120910.1977003-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191112120910.1977003-1-arnd@arndb.de>
References: <20191112120910.1977003-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lZlOOf1pBekRLipBlAilH+XzjYbrcQRrqVcwu4nBcCWmCTIDKiD
 LXawXD6oHFCeNZmmIDEvQjBVahKe0DgngSfMd3OAXlDTbeROhd5OB0q4C+WGrsiiuiWuIlP
 dZHF5jZrAOqH8F8uSQlbQAnhB37z7qgEslvnoBVDBTjb2Htwp+iZ8+9xGYHv3TvgbOCD6sx
 IZgkpH9mO9HHOjcdfPhrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9RkGbgebqw=:wCDsNd9TTU0GjFQKf8Sxu4
 6p6ILi7FggJ6rzrXshKP/IgaweLuDyQQ6aA5Kedtn0fXRuCX2ZhCye3jI3mfCq9w/TnGT5qHl
 HZvO7ccYtbvX1WYAQb3nDJv+J3P2Kf4pAzXK/aGakp2z8uKajD8dZ5rnJZQwonAEXBx+GRlqj
 WRhHH06ERLPWeQkPcny2UsUTaMvPkblkyNeEFf83Z3hj5ZA4YQx50clUVCe1USFEr1Ztcwf8r
 FlGyp8kBLKg66CpUcOyLmSKdbYJcyNrvaVZV55fL8Bcuiul1GD7TBqWN9SVb8ryxw0n9musEX
 9whZrMNaLnwy7yCjcqUK/HNMUSYaVF0bpAHd+UPAyC8BNfeV5zLCWIuHpkGmhj/M5WBfZo4o1
 CFPWpuyzyc8K+EBxsB2m7nuT/kgE2xP2hSYCfdWN2eLSHi2MaD1jndlcwetWvTAPshAKwZeO0
 zQ7ETjc11JMZa4qJ3K2PiIVjyOxAMaWt3EhvNAxsX114Wdc7nSgshlGz4IqYjlBI7IsufXhtN
 YVS9dyzAoJPYWjupA9RLXS3EcBjMWkNAyTPILbSPojdkdxW7ASh14iLR2RbODz3FYoQOz0HBq
 JxccRZOTMJJcBY7NoYguhNmmI0jsu4dkodl2g+C7VxFyBUiwWJrQBuVi09sOGNCTYogQ0pe8P
 Z3Md8LCVKgOWJLCRouF6jtmkW0AjQZEdepERY0/f06DhHF5kKami1heMn1eeCIQoZyCRSduGU
 ErYv9kZSmtDQeQP67xGocASt5B9Tj/l/I7V1zKOCnk7b5CYOZGz8vzSTDch+dhlbTnLAzOf3J
 KFnlsK0nrJ/TjP2mMw1U5KCGL8RSrpnmd8W7WcUUh/XQ7eOrsbreO550Z7sHIlUlPz4PSM77j
 sjfu38OeOrV22EZGp+tQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

XFS is the only major file system that lacks timestamps beyond year 2038,
and is already being deployed in systems that may have to be supported
beyond that time.

Fortunately, the inode format still has a few reserved bits that can be
used to extend the current format. There are two bits in the nanosecond
portion that could be used in the same way that ext4 does, extending
the timestamps until year 2378, as well as 12 unused bytes after the
already allocated fields.

There are four timestamps that need to be extended, so using four
bytes out of the reserved space gets us all the way until year 36676,
by extending the current 1902-2036 with another 255 epochs, which
seems to be a reasonable range.

I am not sure whether this change to the inode format requires a
new version for the inode. All existing file system images remain
compatible, while mounting a file systems with extended timestamps
beyond 2038 would report that timestamp incorrectly in the 1902
through 2038 range, matching the traditional Linux behavior of
wrapping timestamps.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/xfs/libxfs/xfs_format.h      |  6 +++++-
 fs/xfs/libxfs/xfs_inode_buf.c   | 28 ++++++++++++++++++++--------
 fs/xfs/libxfs/xfs_inode_buf.h   |  1 +
 fs/xfs/libxfs/xfs_log_format.h  |  6 +++++-
 fs/xfs/libxfs/xfs_trans_inode.c |  3 ++-
 fs/xfs/xfs_inode.c              |  3 ++-
 fs/xfs/xfs_inode_item.c         | 10 +++++++---
 fs/xfs/xfs_iops.c               |  3 ++-
 fs/xfs/xfs_itable.c             |  2 +-
 fs/xfs/xfs_super.c              |  2 +-
 10 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index c968b60cee15..dc8d160775fb 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -883,7 +883,11 @@ typedef struct xfs_dinode {
 	__be64		di_lsn;		/* flush sequence */
 	__be64		di_flags2;	/* more random flags */
 	__be32		di_cowextsize;	/* basic cow extent size for file */
-	__u8		di_pad2[12];	/* more padding for future expansion */
+	__u8		di_atime_hi;	/* upper 8 bits of di_atime */
+	__u8		di_mtime_hi;	/* upper 8 bits of di_mtime */
+	__u8		di_ctime_hi;	/* upper 8 bits of di_ctime */
+	__u8		di_crtime_hi;	/* upper 8 bits of di_crtime */
+	__u8		di_pad2[8];	/* more padding for future expansion */
 
 	/* fields only written to during inode creation */
 	xfs_timestamp_t	di_crtime;	/* time created */
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 28ab3c5255e1..4989b6f1ac6f 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -228,16 +228,19 @@ xfs_inode_from_disk(
 	to->di_flushiter = be16_to_cpu(from->di_flushiter);
 
 	/*
-	 * Time is signed, so need to convert to signed 32 bit before
-	 * storing in inode timestamp which may be 64 bit. Otherwise
-	 * a time before epoch is converted to a time long after epoch
-	 * on 64 bit systems.
+	 * The supported time range starts at INT_MIN, corresponding to
+	 * year 1902. With the traditional low 32 bits, this ends in
+	 * year 2038, the extra 8 bits extend it by another 255 epochs
+	 * of 136.1 years each, up to year 36744.
 	 */
-	inode->i_atime.tv_sec = (int)be32_to_cpu(from->di_atime.t_sec);
+	inode->i_atime.tv_sec = be32_to_cpu(from->di_atime.t_sec) +
+				((u64)from->di_atime_hi << 32);
 	inode->i_atime.tv_nsec = (int)be32_to_cpu(from->di_atime.t_nsec);
-	inode->i_mtime.tv_sec = (int)be32_to_cpu(from->di_mtime.t_sec);
+	inode->i_mtime.tv_sec = (int)be32_to_cpu(from->di_mtime.t_sec) +
+				((u64)from->di_mtime_hi << 32);
 	inode->i_mtime.tv_nsec = (int)be32_to_cpu(from->di_mtime.t_nsec);
-	inode->i_ctime.tv_sec = (int)be32_to_cpu(from->di_ctime.t_sec);
+	inode->i_ctime.tv_sec = (int)be32_to_cpu(from->di_ctime.t_sec) +
+				((u64)from->di_ctime_hi << 32);
 	inode->i_ctime.tv_nsec = (int)be32_to_cpu(from->di_ctime.t_nsec);
 	inode->i_generation = be32_to_cpu(from->di_gen);
 	inode->i_mode = be16_to_cpu(from->di_mode);
@@ -256,7 +259,8 @@ xfs_inode_from_disk(
 	if (to->di_version == 3) {
 		inode_set_iversion_queried(inode,
 					   be64_to_cpu(from->di_changecount));
-		to->di_crtime.t_sec = be32_to_cpu(from->di_crtime.t_sec);
+		to->di_crtime.t_sec = be32_to_cpu(from->di_crtime.t_sec) +
+				((u64)from->di_crtime_hi << 32);
 		to->di_crtime.t_nsec = be32_to_cpu(from->di_crtime.t_nsec);
 		to->di_flags2 = be64_to_cpu(from->di_flags2);
 		to->di_cowextsize = be32_to_cpu(from->di_cowextsize);
@@ -284,10 +288,13 @@ xfs_inode_to_disk(
 
 	memset(to->di_pad, 0, sizeof(to->di_pad));
 	to->di_atime.t_sec = cpu_to_be32(inode->i_atime.tv_sec);
+	to->di_atime_hi = upper_32_bits(inode->i_atime.tv_sec);
 	to->di_atime.t_nsec = cpu_to_be32(inode->i_atime.tv_nsec);
 	to->di_mtime.t_sec = cpu_to_be32(inode->i_mtime.tv_sec);
+	to->di_mtime_hi = upper_32_bits(inode->i_mtime.tv_sec);
 	to->di_mtime.t_nsec = cpu_to_be32(inode->i_mtime.tv_nsec);
 	to->di_ctime.t_sec = cpu_to_be32(inode->i_ctime.tv_sec);
+	to->di_ctime_hi = upper_32_bits(inode->i_ctime.tv_sec);
 	to->di_ctime.t_nsec = cpu_to_be32(inode->i_ctime.tv_nsec);
 	to->di_nlink = cpu_to_be32(inode->i_nlink);
 	to->di_gen = cpu_to_be32(inode->i_generation);
@@ -307,6 +314,7 @@ xfs_inode_to_disk(
 	if (from->di_version == 3) {
 		to->di_changecount = cpu_to_be64(inode_peek_iversion(inode));
 		to->di_crtime.t_sec = cpu_to_be32(from->di_crtime.t_sec);
+		to->di_crtime_hi = upper_32_bits(from->di_crtime.t_sec);
 		to->di_crtime.t_nsec = cpu_to_be32(from->di_crtime.t_nsec);
 		to->di_flags2 = cpu_to_be64(from->di_flags2);
 		to->di_cowextsize = cpu_to_be32(from->di_cowextsize);
@@ -338,10 +346,13 @@ xfs_log_dinode_to_disk(
 	memcpy(to->di_pad, from->di_pad, sizeof(to->di_pad));
 
 	to->di_atime.t_sec = cpu_to_be32(from->di_atime.t_sec);
+	to->di_atime_hi = from->di_atime_hi;
 	to->di_atime.t_nsec = cpu_to_be32(from->di_atime.t_nsec);
 	to->di_mtime.t_sec = cpu_to_be32(from->di_mtime.t_sec);
+	to->di_mtime_hi = from->di_mtime_hi;
 	to->di_mtime.t_nsec = cpu_to_be32(from->di_mtime.t_nsec);
 	to->di_ctime.t_sec = cpu_to_be32(from->di_ctime.t_sec);
+	to->di_ctime_hi = from->di_ctime_hi;
 	to->di_ctime.t_nsec = cpu_to_be32(from->di_ctime.t_nsec);
 
 	to->di_size = cpu_to_be64(from->di_size);
@@ -359,6 +370,7 @@ xfs_log_dinode_to_disk(
 	if (from->di_version == 3) {
 		to->di_changecount = cpu_to_be64(from->di_changecount);
 		to->di_crtime.t_sec = cpu_to_be32(from->di_crtime.t_sec);
+		to->di_crtime_hi = from->di_crtime_hi;
 		to->di_crtime.t_nsec = cpu_to_be32(from->di_crtime.t_nsec);
 		to->di_flags2 = cpu_to_be64(from->di_flags2);
 		to->di_cowextsize = cpu_to_be32(from->di_cowextsize);
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index ab0f84165317..49556e1898da 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -38,6 +38,7 @@ struct xfs_icdinode {
 	uint32_t	di_cowextsize;	/* basic cow extent size for file */
 
 	xfs_ictimestamp_t di_crtime;	/* time created */
+	uint8_t		di_crtime_hi;	/* upper 8 bites of di_crtime */
 };
 
 /*
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index e5f97c69b320..c17e7c6511ff 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -414,7 +414,11 @@ struct xfs_log_dinode {
 	xfs_lsn_t	di_lsn;		/* flush sequence */
 	uint64_t	di_flags2;	/* more random flags */
 	uint32_t	di_cowextsize;	/* basic cow extent size for file */
-	uint8_t		di_pad2[12];	/* more padding for future expansion */
+	uint8_t		di_atime_hi;	/* upper 8 bits of di_atime */
+	uint8_t		di_mtime_hi;	/* upper 8 bits of di_mtime */
+	uint8_t		di_ctime_hi;	/* upper 8 bits of di_ctime */
+	uint8_t		di_crtime_hi;	/* upper 8 bits of di_crtime */
+	uint8_t		di_pad2[8];	/* more padding for future expansion */
 
 	/* fields only written to during inode creation */
 	xfs_ictimestamp_t di_crtime;	/* time created */
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index a9ad90926b87..419356eec52c 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -67,7 +67,8 @@ xfs_trans_ichgtime(
 	if (flags & XFS_ICHGTIME_CHG)
 		inode->i_ctime = tv;
 	if (flags & XFS_ICHGTIME_CREATE) {
-		ip->i_d.di_crtime.t_sec = (int32_t)tv.tv_sec;
+		ip->i_d.di_crtime.t_sec = lower_32_bits(tv.tv_sec);
+		ip->i_d.di_crtime_hi = upper_32_bits(tv.tv_sec);
 		ip->i_d.di_crtime.t_nsec = (int32_t)tv.tv_nsec;
 	}
 }
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 18f4b262e61c..c0d9d568ea4f 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -845,7 +845,8 @@ xfs_ialloc(
 		inode_set_iversion(inode, 1);
 		ip->i_d.di_flags2 = 0;
 		ip->i_d.di_cowextsize = 0;
-		ip->i_d.di_crtime.t_sec = (int32_t)tv.tv_sec;
+		ip->i_d.di_crtime.t_sec = lower_32_bits(tv.tv_sec);
+		ip->i_d.di_crtime_hi = upper_32_bits(tv.tv_sec);
 		ip->i_d.di_crtime.t_nsec = (int32_t)tv.tv_nsec;
 	}
 
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index bb8f076805b9..338188a5a698 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -314,11 +314,14 @@ xfs_inode_to_log_dinode(
 
 	memset(to->di_pad, 0, sizeof(to->di_pad));
 	memset(to->di_pad3, 0, sizeof(to->di_pad3));
-	to->di_atime.t_sec = inode->i_atime.tv_sec;
+	to->di_atime.t_sec = lower_32_bits(inode->i_atime.tv_sec);
+	to->di_atime_hi = upper_32_bits(inode->i_atime.tv_sec);
 	to->di_atime.t_nsec = inode->i_atime.tv_nsec;
-	to->di_mtime.t_sec = inode->i_mtime.tv_sec;
+	to->di_mtime.t_sec = lower_32_bits(inode->i_mtime.tv_sec);
+	to->di_mtime_hi = upper_32_bits(inode->i_mtime.tv_sec);
 	to->di_mtime.t_nsec = inode->i_mtime.tv_nsec;
-	to->di_ctime.t_sec = inode->i_ctime.tv_sec;
+	to->di_ctime.t_sec = lower_32_bits(inode->i_ctime.tv_sec);
+	to->di_ctime_hi = upper_32_bits(inode->i_ctime.tv_sec);
 	to->di_ctime.t_nsec = inode->i_ctime.tv_nsec;
 	to->di_nlink = inode->i_nlink;
 	to->di_gen = inode->i_generation;
@@ -341,6 +344,7 @@ xfs_inode_to_log_dinode(
 	if (from->di_version == 3) {
 		to->di_changecount = inode_peek_iversion(inode);
 		to->di_crtime.t_sec = from->di_crtime.t_sec;
+		to->di_crtime_hi = from->di_crtime_hi;
 		to->di_crtime.t_nsec = from->di_crtime.t_nsec;
 		to->di_flags2 = from->di_flags2;
 		to->di_cowextsize = from->di_cowextsize;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index fe285d123d69..72d40ae1e91f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -516,7 +516,8 @@ xfs_vn_getattr(
 	if (ip->i_d.di_version == 3) {
 		if (request_mask & STATX_BTIME) {
 			stat->result_mask |= STATX_BTIME;
-			stat->btime.tv_sec = ip->i_d.di_crtime.t_sec;
+			stat->btime.tv_sec = ip->i_d.di_crtime.t_sec +
+					((u64)ip->i_d.di_crtime_hi << 32);
 			stat->btime.tv_nsec = ip->i_d.di_crtime.t_nsec;
 		}
 	}
diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index 884950adbd16..ea4bf4475727 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -97,7 +97,7 @@ xfs_bulkstat_one_int(
 	buf->bs_mtime_nsec = inode->i_mtime.tv_nsec;
 	buf->bs_ctime = inode->i_ctime.tv_sec;
 	buf->bs_ctime_nsec = inode->i_ctime.tv_nsec;
-	buf->bs_btime = dic->di_crtime.t_sec;
+	buf->bs_btime = dic->di_crtime.t_sec + ((u64)dic->di_crtime_hi << 32);
 	buf->bs_btime_nsec = dic->di_crtime.t_nsec;
 	buf->bs_gen = inode->i_generation;
 	buf->bs_mode = inode->i_mode;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8d1df9f8be07..2adfe1039693 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1665,7 +1665,7 @@ xfs_fs_fill_super(
 	sb->s_max_links = XFS_MAXLINK;
 	sb->s_time_gran = 1;
 	sb->s_time_min = S32_MIN;
-	sb->s_time_max = S32_MAX;
+	sb->s_time_max = S32_MAX + 255 * 0x100000000ull;
 	sb->s_iflags |= SB_I_CGROUPWB;
 
 	set_posix_acl_flag(sb);
-- 
2.20.0

