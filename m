Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6931E5207
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 02:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgE1ABm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 20:01:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36206 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE1ABl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 20:01:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RNvdea188654;
        Thu, 28 May 2020 00:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1u3KnY7wsn8eqS5LxH5DG3FtH5UMSs7unlE6FhJcW6A=;
 b=q//hMjAVRFCgFyxmIxFf/zWdcT7o6cFAZeSYEKSslEFYMehBIducY0I60EPGzhnIj0HE
 xM2TO3v5Zzs198xwSPjULYUrRUPk3Zc6t59pE6K8Beat1djjfWZKAUJ7/wKremLa/b0G
 NSUBU/chouDa4Y6kDe+AMjwm+xTRqbZytGf37p2l/tql5RxJqMZMHgvxhuoMI0QnT9nn
 lIurwPMiHk0h/fegYIl4qHXMV48WP+b3l8I1uksR5DW1R+3cCMzoR74pTElGumXYWT3N
 GgYiLFd/b9+bSr2YwY6FN8lonz/9Wttl+N8SZz5MxVIWCKlt6ezsVs97wGkq0NU+BfXx 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 316u8r27w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 00:01:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RNvaGf155723;
        Thu, 28 May 2020 00:01:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 317j5td1ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 00:01:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04S01PV0024374;
        Thu, 28 May 2020 00:01:26 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 17:01:25 -0700
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Walters <walters@verbum.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org
References: <000000000000b4684e05a2968ca6@google.com>
 <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
 <bb232cfa-5965-42d0-88cf-46d13f7ebda3@www.fastmail.com>
 <9a56a79a-88ed-9ff4-115e-ec169cba5c0b@oracle.com>
 <CAJfpegsNVB12MQ-Jgbb-f=+i3g0Xy52miT3TmUAYL951HVQS_w@mail.gmail.com>
 <78313ae9-8596-9cbe-f648-3152660be9b3@oracle.com>
 <20200522100553.GE13131@miu.piliscsaba.redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4ebd0429-f715-d523-4c09-43fa2c3bc338@oracle.com>
Date:   Wed, 27 May 2020 17:01:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522100553.GE13131@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270177
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/20 3:05 AM, Miklos Szeredi wrote:
> On Wed, May 20, 2020 at 10:27:15AM -0700, Mike Kravetz wrote:
> 
>> I am fairly confident it is all about checking limits and alignment.  The
>> filesystem knows if it can/should align to base or huge page size. DAX has
>> some interesting additional restrictions, and several 'traditional' filesystems
>> check if they are 'on DAX'.
> 
> 
> Okay, I haven't looked at DAX vs. overlay.  I'm sure it's going to come up at
> some point, if it hasn't already.
> 
>>
>> In a previous e-mail, you suggested hugetlb_get_unmapped_area could do the
>> length adjustment in hugetlb_get_unmapped_area (generic and arch specific).
>> I agree, although there may be the need to add length overflow checks in
>> these routines (after round up) as this is done in core code now.  However,
>> this can be done as a separate cleanup patch.
>>
>> In any case, we need to get the core mmap code to call filesystem specific
>> get_unmapped_area if on a union/overlay.  The patch I suggested does this
>> by simply calling real_file to determine if there is a filesystem specific
>> get_unmapped_area.  The other approach would be to provide an overlayfs
>> get_unmapped_area that calls the underlying filesystem get_unmapped_area.
> 
> That latter is what's done for all other stacked operations in overlayfs.
> 
> Untested patch below.
> 

Thanks Miklos!

We still need the 'real_file()' routine for is_file_hugepages.  So combining
these, I propose the following patch.  It addresses the known issue as well
as potential issues with is_file_hugepages returning incorrect information.
I don't really like a separate header file for real_file, but I can not
think of any good place to put it.

Let me know what you think,

From 33f6bbd19406108b61a4113b1ec8e4e6888cd482 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 27 May 2020 16:58:58 -0700
Subject: [PATCH v2] ovl: provide real_file() and overlayfs get_unmapped_area()

If a file is on a union/overlay, then the 'struct file *' will have
overlayfs file operations.  The routine is_file_hugepages() compares
f->f_op to hugetlbfs_file_operations to determine if it is a hugetlbfs
file.  If a hugetlbfs file is on a union/overlay, this comparison is
false and is_file_hugepages() incorrectly indicates the underlying
file is not hugetlbfs.  One result of this is a BUG as shown in [1].

mmap uses is_file_hugepages() because hugetlbfs files have different
alignment restrictions.  In addition, mmap code would like to use the
filesystem specific get_unmapped_area() routine if one is defined.

To address this issue,
- Add a new routine real_file() which will return the underlying file.
- Update is_file_hugepages to get the real file.
- Add get_unmapped_area f_op to oerrlayfs to call underlying routine.

[1] https://lore.kernel.org/linux-mm/000000000000b4684e05a2968ca6@google.com/

Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/overlayfs/file.c       | 13 +++++++++++++
 include/linux/hugetlb.h   |  3 +++
 include/linux/overlayfs.h | 27 +++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 include/linux/overlayfs.h

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 87c362f65448..cc020e1c72d5 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -12,6 +12,7 @@
 #include <linux/splice.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/overlayfs.h>
 #include "overlayfs.h"
 
 struct ovl_aio_req {
@@ -757,6 +758,17 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 			    remap_flags, op);
 }
 
+static unsigned long ovl_get_unmapped_area(struct file *file,
+				unsigned long uaddr, unsigned long len,
+				unsigned long pgoff, unsigned long flags)
+{
+	struct file *realfile = real_file(file);
+
+	return (realfile->f_op->get_unmapped_area ?:
+		current->mm->get_unmapped_area)(realfile,
+						uaddr, len, pgoff, flags);
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
@@ -774,6 +786,7 @@ const struct file_operations ovl_file_operations = {
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
+	.get_unmapped_area	= ovl_get_unmapped_area,
 };
 
 int __init ovl_aio_request_cache_init(void)
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
-- 
2.25.4

