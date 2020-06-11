Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860E31F5F16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 02:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgFKAOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 20:14:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35046 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgFKAOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:14:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05B0D4m3119079;
        Thu, 11 Jun 2020 00:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VSQ9eS7gkSGb0v4ligtQhmEu3fEZRdfYfrfA7KqdkF0=;
 b=D3iX9xrRX5rW/U7VEa6vX2dgh89GLylVg3Uk1+g203IjaylRs2i7LG8bwLZVUKojwOjt
 /AYoqERKgLbPzSnoUhgXH1bPqlBOoIXdOE2wnEXMvP49FYXRX+HNWfqqUbYLQl/z3Id5
 mFQhAYL8S6XGPi3avU4HtmjS5Jix9UBz+pfz6erdgweq62iB/SyX3eB438X1+L56oWVj
 I9IDVnrgCdNx61VVygWLbJ2y3ACfGHXfTllk/Pmzx/aziGVNIgJWEZM3D6s0TAQfn2uA
 xmQ7h1qpv9gYspYBTQ18Xnt5Y2WiEXbe2O2airz2bDXLX0EKn48f8C/aqClr5UxLWGrD 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31jepnxyag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 00:13:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05B0CUSx056589;
        Thu, 11 Jun 2020 00:13:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31gn2af3py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 00:13:58 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05B0DsrQ003884;
        Thu, 11 Jun 2020 00:13:55 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 17:13:54 -0700
Subject: Re: [PATCH v2] ovl: provide real_file() and overlayfs
 get_unmapped_area()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Colin Walters <walters@verbum.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>
References: <4ebd0429-f715-d523-4c09-43fa2c3bc338@oracle.com>
 <202005281652.QNakLkW3%lkp@intel.com>
 <365d83b8-3af7-2113-3a20-2aed51d9de91@oracle.com>
 <CAJfpegtz=tzndsF=_1tYHewGwEgvqEOA_4zj8HCAqyFdKe6mag@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ffc00a9e-5c2f-0c3e-aa1e-9836b98f7b54@oracle.com>
Date:   Wed, 10 Jun 2020 17:13:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegtz=tzndsF=_1tYHewGwEgvqEOA_4zj8HCAqyFdKe6mag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100173
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/4/20 2:16 AM, Miklos Szeredi wrote:
> On Thu, May 28, 2020 at 11:01 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> Well yuck!  get_unmapped_area is not part of mm_struct if !CONFIG_MMU.
>>
>> Miklos, would adding '#ifdef CONFIG_MMU' around the overlayfs code be too
>> ugly for you?  Another option is to use real_file() in the mmap code as
>> done in [1].
> 
> I think the proper fix is to add an inline helper
> (call_get_unmapped_area()?) in linux/mm.h, and make that work properly
> for the NOMMU case as well.
> 

I'm ignoring the above issue for now.  There may be a more fundamental issue
that I do not know how to solve without adding another memeber to
file_operations.  Why?

In order to go from file -> realfile, one needs to do something like the
code you provided.

	while (file->f_op == &ovl_file_operations)
		file = file->private_data;
	return file;

The problem is that this needs to be called from core kernel code
(is_file_hugepages in mmap).  ovl_file_operations is obviously only defined
in the overlayfs code.  Since overlayfs can be built as a module, I do not
know of a way to reference ovl_file_operations which will only become available
when/if overlayfs is loaded.  Is there a way to do that?

If there is no other way to do this, then I think we need to add another
member to file_operations as is done in the following patch.  I hope there
is another way, because adding another file_op seems like overkill.

From 6d22c93284263b5ddcc2199adc1bcceb233f1499 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 10 Jun 2020 16:23:46 -0700
Subject: [PATCH v3] ovl: add f_real file_operation and supporting code for
 overlayfs

If a file is on a union/overlay, then the 'struct file *' will have
overlayfs file operations.  The routine is_file_hugepages() compares
f->f_op to hugetlbfs_file_operations to determine if it is a hugetlbfs
file.  If a hugetlbfs file is on a union/overlay, this comparison is
false and is_file_hugepages() incorrectly indicates the underlying
file is not hugetlbfs.  One result of this is a BUG as shown in [1].

mmap uses is_file_hugepages() to identify hugetlbfs file and potentially
round up length because hugetlbfs files have different alignment
restrictions.  This is defined/expected behavior.  In addition, mmap
code would like to use the filesystem specific get_unmapped_area()
routine if one is defined.

To address this issue,
- Add a new file operation f_real while will return the underlying file.
  Only overlayfs provides a function for this operation.
- Add a new routine real_file() which can be used by core code get an
  underlying file.
- Update is_file_hugepages to get the real file.
- Add get_unmapped_area f_op to oerrlayfs to call underlying routine.

[1] https://lore.kernel.org/linux-mm/000000000000b4684e05a2968ca6@google.com/

Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/overlayfs/file.c     | 23 +++++++++++++++++++++++
 include/linux/fs.h      |  8 ++++++++
 include/linux/hugetlb.h |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 87c362f65448..eb870fc3912f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -757,6 +757,27 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 			    remap_flags, op);
 }
 
+#ifdef CONFIG_MMU
+static unsigned long ovl_get_unmapped_area(struct file *file,
+				unsigned long uaddr, unsigned long len,
+				unsigned long pgoff, unsigned long flags)
+{
+	file = real_file(file);
+
+	return (file->f_op->get_unmapped_area ?:
+		current->mm->get_unmapped_area)(file, uaddr, len, pgoff, flags);
+}
+#else
+#define ovl_get_unmapped_area NULL
+#endif
+
+static struct file *ovl_f_real(struct file *file)
+{
+	while (file->f_op == &ovl_file_operations)
+		file = file->private_data;
+	return file;
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
@@ -771,9 +792,11 @@ const struct file_operations ovl_file_operations = {
 	.compat_ioctl	= ovl_compat_ioctl,
 	.splice_read    = ovl_splice_read,
 	.splice_write   = ovl_splice_write,
+	.f_real		= ovl_f_real,
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
+	.get_unmapped_area	= ovl_get_unmapped_area,
 };
 
 int __init ovl_aio_request_cache_init(void)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 45cc10cdf6dd..59a969549aec 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1863,6 +1863,7 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	struct file * (*f_real)(struct file *file);
 } __randomize_layout;
 
 struct inode_operations {
@@ -1895,6 +1896,13 @@ struct inode_operations {
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
 } ____cacheline_aligned;
 
+static inline struct file *real_file(struct file *file)
+{
+	if (unlikely(file->f_op->f_real))
+		return file->f_op->f_real(file);
+	return file;
+}
+
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
 				     struct iov_iter *iter)
 {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 43a1cef8f0f1..528b07145414 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -437,6 +437,8 @@ struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
 
 static inline bool is_file_hugepages(struct file *file)
 {
+	file = real_file(file);
+
 	if (file->f_op == &hugetlbfs_file_operations)
 		return true;
 
-- 
2.25.4

