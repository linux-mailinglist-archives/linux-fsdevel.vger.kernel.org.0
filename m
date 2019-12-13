Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2159311EC35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 21:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLMUyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 15:54:37 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:45667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMUyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:54:37 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M27Bp-1ihmpU2pLt-002XGN; Fri, 13 Dec 2019 21:54:33 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/24] hfs/hfsplus: use 64-bit inode timestamps
Date:   Fri, 13 Dec 2019 21:53:39 +0100
Message-Id: <20191213205417.3871055-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XqMpj8o6u9NYzuj3rgf12in7GXdK8b+g+ASj7vaIy/neEOyN42J
 4kT//QrdC+R3EDPxtHVZ/GkJhWttxJWqahEX0zv64cj5oVuoYETGHG7oAHIYvpX2QosSvct
 ddBHO8D9+gADwoHY/gMwsp+K8ZyU+RCb5H3wQhtrjjk1NJBofRa8YMkMBg5jQdZsGihO7o+
 PHBn9nB5gcuj9pJPu9ANQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lQyG22QQ74k=:ppxLRXs2HfG+wch52J7SEk
 D7vKzuAX84XA4nvpIl9pgCmZ/WszjP/JKenJt8zkWiyaqhv9g7S8o3UtrHQzMDFBy+FvMxkzD
 1wQTppPANHKEygSveUEB7C4GyKYJKKyXZrxaaHY2aZxA9/tZ0owbANhc55kdmOET37BB4kah6
 krpCRoJYNau0FCEfNb9EMZ6LtUDsXWyW10Rb8/qr2YsO1TqKYHpnnRfE3Gpj6g4TS2iEjvudY
 uDEaQ+1N/yAsEiwlO/PFXB0zetAbmlY9wJqBvgP+IemkMrQlb1HZ2WBHDfhqQsMEYfezENF9j
 hc3pOObQTJJvnti1eoNs2+/n/VwjaYkdfN9I06QkJu9BTcPoFrG58Ka4oQtFOUc6Wo323Ri5R
 yvg6aUqXB6LhXW2WJ4r88lOMb9CwbA2XbkzFaQaSv1xboMfCSLX9Rt9i534Pw0H74mbv+Lxvv
 pEa7B2vboRbQ+K/m6xDeladD96+1JAFq5cZ1sk9uG+nYoJEgrGswD/+hHAojvDtHPAS67rsUv
 XijjSC6/OQ7QIHXBeW/eMkTJTq1+bcBIESvd4fAUezzzh6sdk1ophSDRoGikTQPpc1mQMb9MT
 Ay4/4V8tBUo6zjEJiWIdNi4EGi+sfGLcHjJebbJQbTTHMmmfc3crLXKDeQuk/+G7apM5uT0XV
 7XUE3l3cJiIvAuuKeiKg+a+/bf1BtZb/cmkW5xT1GIVcABv1q/4QuAnTBntK0x2XPKo2RPXc/
 rP0+BId4mwx7RiH78nufQOhFHQ+HHiCM1cK2QTtN0yQ68mR/saRKx5y66QzBn+SeflQUuJJZY
 vB7SJHkcCtt7VQgtTCoyaAY+0i5ENre+M8lNhgOGwyl0oTwAUvTIkeWtYF8vIgX+ctKktIqdW
 PgeweHdDkgOgDmvJtp1g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The interpretation of on-disk timestamps in HFS and HFS+ differs
between 32-bit and 64-bit kernels at the moment. Use 64-bit timestamps
consistently so apply the current 64-bit behavior everyhere.

According to the official documentation for HFS+ [1], inode timestamps
are supposed to cover the time range from 1904 to 2040 as originally
used in classic MacOS.

The traditional Linux usage is to convert the timestamps into an unsigned
32-bit number based on the Unix epoch and from there to a time_t. On
32-bit systems, that wraps the time from 2038 to 1902, so the last
two years of the valid time range become garbled. On 64-bit systems,
all times before 1970 get turned into timestamps between 2038 and 2106,
which is more convenient but also different from the documented behavior.

Looking at the Darwin sources [2], it seems that MacOS is inconsistent in
yet another way: all timestamps are wrapped around to a 32-bit unsigned
number when written to the disk, but when read back, all numeric values
lower than 2082844800U are assumed to be invalid, so we cannot represent
the times before 1970 or the times after 2040.

While all implementations seem to agree on the interpretation of values
between 1970 and 2038, they often differ on the exact range they support
when reading back values outside of the common range:

MacOS (traditional):		1904-2040
Apple Documentation:		1904-2040
MacOS X source comments:	1970-2040
MacOS X source code:		1970-2038
32-bit Linux:			1902-2038
64-bit Linux:			1970-2106
hfsfuse:			1970-2040
hfsutils (32 bit, old libc)	1902-2038
hfsutils (32 bit, new libc)	1970-2106
hfsutils (64 bit)		1904-2040
hfsplus-utils			1904-2040
hfsexplorer			1904-2040
7-zip				1904-2040

Out of the above, the range from 1970 to 2106 seems to be the most useful,
as it allows using HFS and HFS+ beyond year 2038, and this matches the
behavior that most users would see today on Linux, as few people run
32-bit kernels any more.

Link: [1] https://developer.apple.com/library/archive/technotes/tn/tn1150.html
Link: [2] https://opensource.apple.com/source/hfs/hfs-407.30.1/core/MacOSStubs.c.auto.html
Link: https://lore.kernel.org/lkml/20180711224625.airwna6gzyatoowe@eaf/
Suggested-by: "Ernesto A. Fernández" <ernesto.mnd.fernandez@gmail.com>
Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: revert back to 1970-2106 time range
    fix bugs found in review
    merge both patches into one
    drop cc:stable tag
v2: treat pre-1970 dates as invalid following MacOS X behavior,
    reword and expand changelog text
---
 fs/hfs/hfs_fs.h         | 28 ++++++++++++++++++++++------
 fs/hfs/inode.c          |  4 ++--
 fs/hfsplus/hfsplus_fs.h | 28 +++++++++++++++++++++++-----
 fs/hfsplus/inode.c      | 12 ++++++------
 4 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 6d0783e2e276..f71c384064c8 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -242,19 +242,35 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
 /*
  * There are two time systems.  Both are based on seconds since
  * a particular time/date.
- *	Unix:	unsigned lil-endian since 00:00 GMT, Jan. 1, 1970
+ *	Unix:	signed little-endian since 00:00 GMT, Jan. 1, 1970
  *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
  *
+ * HFS implementations are highly inconsistent, this one matches the
+ * traditional behavior of 64-bit Linux, giving the most useful
+ * time range between 1970 and 2106, by treating any on-disk timestamp
+ * under HFS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
  */
-#define __hfs_u_to_mtime(sec)	cpu_to_be32(sec + 2082844800U - sys_tz.tz_minuteswest * 60)
-#define __hfs_m_to_utime(sec)	(be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
+#define HFS_UTC_OFFSET 2082844800U
 
+static inline time64_t __hfs_m_to_utime(__be32 mt)
+{
+	time64_t ut = (u32)(be32_to_cpu(mt) - HFS_UTC_OFFSET);
+
+	return ut + sys_tz.tz_minuteswest * 60;
+}
+
+static inline __be32 __hfs_u_to_mtime(time64_t ut)
+{
+	ut -= sys_tz.tz_minuteswest * 60;
+
+	return cpu_to_be32(lower_32_bits(ut) + HFS_UTC_OFFSET);
+}
 #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
 
-#define hfs_m_to_utime(time)	(struct timespec){ .tv_sec = __hfs_m_to_utime(time) }
-#define hfs_u_to_mtime(time)	__hfs_u_to_mtime((time).tv_sec)
-#define hfs_mtime()		__hfs_u_to_mtime(get_seconds())
+#define hfs_m_to_utime(time)   (struct timespec64){ .tv_sec = __hfs_m_to_utime(time) }
+#define hfs_u_to_mtime(time)   __hfs_u_to_mtime((time).tv_sec)
+#define hfs_mtime()		__hfs_u_to_mtime(ktime_get_real_seconds())
 
 static inline const char *hfs_mdb_name(struct super_block *sb)
 {
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index da243c84e93b..2f224b98ee94 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -351,7 +351,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				timespec_to_timespec64(hfs_m_to_utime(rec->file.MdDat));
+				hfs_m_to_utime(rec->file.MdDat);
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
@@ -362,7 +362,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				timespec_to_timespec64(hfs_m_to_utime(rec->dir.MdDat));
+				hfs_m_to_utime(rec->dir.MdDat);
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index b8471bf05def..3b03fff68543 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -533,13 +533,31 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
 		       void **data, int op, int op_flags);
 int hfsplus_read_wrapper(struct super_block *sb);
 
-/* time macros */
-#define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
-#define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
+/*
+ * time helpers: convert between 1904-base and 1970-base timestamps
+ *
+ * HFS+ implementations are highly inconsistent, this one matches the
+ * traditional behavior of 64-bit Linux, giving the most useful
+ * time range between 1970 and 2106, by treating any on-disk timestamp
+ * under HFSPLUS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
+ */
+#define HFSPLUS_UTC_OFFSET 2082844800U
+
+static inline time64_t __hfsp_mt2ut(__be32 mt)
+{
+	time64_t ut = (u32)(be32_to_cpu(mt) - HFSPLUS_UTC_OFFSET);
+
+	return ut;
+}
+
+static inline __be32 __hfsp_ut2mt(time64_t ut)
+{
+	return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
+}
 
 /* compatibility */
-#define hfsp_mt2ut(t)		(struct timespec){ .tv_sec = __hfsp_mt2ut(t) }
+#define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
-#define hfsp_now2mt()		__hfsp_ut2mt(get_seconds())
+#define hfsp_now2mt()		__hfsp_ut2mt(ktime_get_real_seconds())
 
 #endif
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index d131c8ea7eb6..94bd83b36644 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -504,9 +504,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		hfsplus_get_perms(inode, &folder->permissions, 1);
 		set_nlink(inode, 1);
 		inode->i_size = 2 + be32_to_cpu(folder->valence);
-		inode->i_atime = timespec_to_timespec64(hfsp_mt2ut(folder->access_date));
-		inode->i_mtime = timespec_to_timespec64(hfsp_mt2ut(folder->content_mod_date));
-		inode->i_ctime = timespec_to_timespec64(hfsp_mt2ut(folder->attribute_mod_date));
+		inode->i_atime = hfsp_mt2ut(folder->access_date);
+		inode->i_mtime = hfsp_mt2ut(folder->content_mod_date);
+		inode->i_ctime = hfsp_mt2ut(folder->attribute_mod_date);
 		HFSPLUS_I(inode)->create_date = folder->create_date;
 		HFSPLUS_I(inode)->fs_blocks = 0;
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
@@ -542,9 +542,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 			init_special_inode(inode, inode->i_mode,
 					   be32_to_cpu(file->permissions.dev));
 		}
-		inode->i_atime = timespec_to_timespec64(hfsp_mt2ut(file->access_date));
-		inode->i_mtime = timespec_to_timespec64(hfsp_mt2ut(file->content_mod_date));
-		inode->i_ctime = timespec_to_timespec64(hfsp_mt2ut(file->attribute_mod_date));
+		inode->i_atime = hfsp_mt2ut(file->access_date);
+		inode->i_mtime = hfsp_mt2ut(file->content_mod_date);
+		inode->i_ctime = hfsp_mt2ut(file->attribute_mod_date);
 		HFSPLUS_I(inode)->create_date = file->create_date;
 	} else {
 		pr_err("bad catalog entry used to create inode\n");
-- 
2.20.0

