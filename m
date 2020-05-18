Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A63B1D8B9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 01:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgERXYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 19:24:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39722 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgERXYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 19:24:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04INN66x022469;
        Mon, 18 May 2020 23:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=WOQOuitc5s7ymPyD0TdTSCoVvlNo2C64vJokX/6G0mU=;
 b=IkJt5X4k5HUEOfKoQBexKYIlRGOnooV44da9dUUGzcigfGDUVcy3q+ONLZmnMA/5K1Zm
 xyFNiSQOLY9Q+JnNyNO0tlIHZ77EyylCVzPz2w0f1buJo0zOijqmvF5QqXtRdhoYg6ZJ
 59eE8ncFKDY/pS97DzufI7aJMIfjpgVfkE6cKD1CfLBpWyCVnpWtW/kY2D1dfF27Ip31
 ED2gko7xhfQS+uO25NtZ8SBasOARBdGfqFyzDIMB0JpzX1vWMjCF4CFYOoda5G/Z315K
 Pd7+WFrK7moHxzA6Xm4roudfKL+1/XDLSJoG8fUhIrz6+U3diLxp3KCzlXjrlN822Wxa cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3127kr20xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 23:24:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04INIL87074889;
        Mon, 18 May 2020 23:22:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 312t3wn7tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 23:22:12 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04INMADT018217;
        Mon, 18 May 2020 23:22:10 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 May 2020 16:22:09 -0700
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000b4684e05a2968ca6@google.com>
 <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
 <d32b8579-04a3-2a9b-cd54-1d581c63332e@oracle.com>
 <86c504b3-52c9-55f6-13db-ab55b2f6980e@oracle.com>
 <CAJfpegsy5vzO5e3DJGTrpXoGRTzjegoLaDdzheDeQhw+uokYnQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <04a00e3b-539c-236f-e43b-0024ef94b7cb@oracle.com>
Date:   Mon, 18 May 2020 16:22:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegsy5vzO5e3DJGTrpXoGRTzjegoLaDdzheDeQhw+uokYnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180197
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180198
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/20 4:12 AM, Miklos Szeredi wrote:
> On Sat, May 16, 2020 at 12:15 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> Any suggestions on how to move forward?  It seems like there may be the
>> need for a real_file() routine?  I see a d_real dentry_op was added to
>> deal with this issue for dentries.  Might we need something similiar for
>> files (f_real)?
>>
>> Looking for suggestions as I do not normally work with this code.
> 
> And I'm not so familiar with hugepages code.  I'd suggest moving
> length alignment into f_op->get_unmapped_area() and cleaning up other
> special casing of hugetlb mappings, but it's probably far from
> trivial...
> 
> So yeah, that leaves a real_file() helper or something similar.
> Unlike the example I gave first it actually needs to be recursive:
> 
> static inline struct file *real_file(struct file *file)
> {
>     whole (unlikely(file->f_op == ovl_file_operations))
>         file = file->private_data;
>     return file;
> }

If we add real_file(), then I think it only needs to be called in two
places: is_file_hugepages() and core mmap code.  However, I could not
think of a good place to put real_file().  Below is a patch which creates
a new file <linux/overlayfs.h> for the routine.  It does solve this BUG
and should fix any other issues with callers of is_file_hugepages().
Let me know what you think.

I add a 'Suggested-by:' for real_file, but am happy to change that to
a 'Signed-off-by:' if you prefer.

From ea6a96aa3f5365df39f7cf213f87abe336b43e71 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 18 May 2020 15:29:12 -0700
Subject: [PATCH] ovl: provide real_file() for use by hugetlb and mmap

If a file is on a union/overlay, then the 'struct file *' will have
overlayfs file operations.  The routine is_file_hugepages() compares
f->f_op to hugetlbfs_file_operations to determine if it is a hugetlbfs
file.  If a hugetlbfs file is on a union/overlay, this comparison is
false and is_file_hugepages() incorrectly indicates the underlying
file is not hugetlbfs.  One result of this is a BUG as shown in [1].

mmap uses is_file_hugepages() because hugetlbfs files have different
alignment restrictions.  In addition, mmap code would like to use the
filesystem specific get_unmapped_area() routine if one is defined.

To address this issue, add a new routine real_file() which will return
the underlying file.  Update is_file_hugepages and mmap code to get the
real file.

[1] https://lore.kernel.org/linux-mm/000000000000b4684e05a2968ca6@google.com/

Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h   |  3 +++
 include/linux/overlayfs.h | 27 +++++++++++++++++++++++++++
 mm/mmap.c                 |  2 ++
 3 files changed, 32 insertions(+)
 create mode 100644 include/linux/overlayfs.h

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 43a1cef8f0f1..fb22c0a7474a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -9,6 +9,7 @@
 #include <linux/cgroup.h>
 #include <linux/list.h>
 #include <linux/kref.h>
+#include <linux/overlayfs.h>
 #include <asm/pgtable.h>
 
 struct ctl_table;
@@ -437,6 +438,8 @@ struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
 
 static inline bool is_file_hugepages(struct file *file)
 {
+	file = real_file(file);
+
 	if (file->f_op == &hugetlbfs_file_operations)
 		return true;
 
diff --git a/include/linux/overlayfs.h b/include/linux/overlayfs.h
new file mode 100644
index 000000000000..eecdfda0286f
--- /dev/null
+++ b/include/linux/overlayfs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OVERLAYFS_H
+#define _LINUX_OVERLAYFS_H
+
+#include <linux/fs.h>
+
+extern const struct file_operations ovl_file_operations;
+
+#ifdef CONFIG_OVERLAY_FS
+/*
+ * If file is on a union/overlay, then return the underlying real file.
+ * Otherwise return the file itself.
+ */
+static inline struct file *real_file(struct file *file)
+{
+	while (unlikely(file->f_op == &ovl_file_operations))
+		file = file->private_data;
+	return file;
+}
+#else
+static inline struct file *real_file(struct file *file)
+{
+	return file;
+}
+#endif
+
+#endif /* _LINUX_OVERLAYFS_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index f609e9ec4a25..7f45a4057a15 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/overlayfs.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -2203,6 +2204,7 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 	get_area = current->mm->get_unmapped_area;
 	if (file) {
+		file = real_file(file);
 		if (file->f_op->get_unmapped_area)
 			get_area = file->f_op->get_unmapped_area;
 	} else if (flags & MAP_SHARED) {
-- 
2.25.4

