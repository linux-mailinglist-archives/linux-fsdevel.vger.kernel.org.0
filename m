Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF461F7183
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 02:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgFLA5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 20:57:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56182 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLA5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:57:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05C0uWCT139167;
        Fri, 12 Jun 2020 00:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=G7qsYAo6+TVtQ8VyceFO8x8YzKDVMYcOi5p/gHiivcY=;
 b=v2kfQ6gZ8eybpn9y2AU/igZyxPMPc+VkN7QoINeR29tTCSc4TJDVhZMjelqf9udxerVz
 k7k4WoJIn8Ol+wgaGXgjeBImAlcZchgaLhmVXBEcka1y07Vtqb897vSPkNkJMbv4T4pT
 XzVAB2ix3lnwB9iZp2C7APoeTiNg2ycTtQHd+DYb577ibCPOZEqWVFTc9iSKFlrXJ1g0
 wJst+s30PQLysUXnSVyhLgXTmjXX4MRIgLo5IZdlHSkQr0YG71K/NO3pkInbSTFas1hu
 d3c7k0GvTofyNfK9X1ZmqMRH9TwzRgyhK0N9shgxOObNUK51LGUZ3Mj2QvM4CwBRJVRj kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3snagvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 00:57:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05C0lmKr021833;
        Fri, 12 Jun 2020 00:57:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31kye50grm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 00:57:05 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05C0l0tH007043;
        Fri, 12 Jun 2020 00:47:00 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 17:46:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 2/2] ovl: call underlying get_unmapped_area() routine. propogate FMODE_HUGETLBFS
Date:   Thu, 11 Jun 2020 17:46:44 -0700
Message-Id: <20200612004644.255692-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200612004644.255692-1-mike.kravetz@oracle.com>
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120004
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The core routine get_unmapped_area will call a filesystem specific version
of get_unmapped_area if it exists in file operations.  If a file is on a
union/overlay, overlayfs does not contain a get_unmapped_area f_op and the
underlying filesystem routine may be ignored.  Add an overlayfs f_op to call
the underlying f_op if it exists.

The routine is_file_hugetlbfs() is used to determine if a file is on
hugetlbfs.  This is determined by f_mode & FMODE_HUGETLBFS.  Copy the mode
to the overlayfs file during open so that is_file_hugetlbfs() will work as
intended.

These two issues can result in the BUG as shown in [1].

[1] https://lore.kernel.org/linux-mm/000000000000b4684e05a2968ca6@google.com/

Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/overlayfs/file.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 87c362f65448..41e5746ba3c6 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -124,6 +124,8 @@ static int ovl_real_fdget(const struct file *file, struct fd *real)
 	return ovl_real_fdget_meta(file, real, false);
 }
 
+#define OVL_F_MODE_TO_UPPER	(FMODE_HUGETLBFS)
+
 static int ovl_open(struct inode *inode, struct file *file)
 {
 	struct file *realfile;
@@ -140,6 +142,9 @@ static int ovl_open(struct inode *inode, struct file *file)
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
+	/* Copy modes from underlying file */
+	file->f_mode |= (realfile->f_mode & OVL_F_MODE_TO_UPPER);
+
 	file->private_data = realfile;
 
 	return 0;
@@ -757,6 +762,21 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 			    remap_flags, op);
 }
 
+#ifdef CONFIG_MMU
+static unsigned long ovl_get_unmapped_area(struct file *file,
+				unsigned long uaddr, unsigned long len,
+				unsigned long pgoff, unsigned long flags)
+{
+	struct file *realfile = file->private_data;
+
+	return (realfile->f_op->get_unmapped_area ?:
+		current->mm->get_unmapped_area)(realfile,
+						uaddr, len, pgoff, flags);
+}
+#else
+#define ovl_get_unmapped_area NULL
+#endif
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
@@ -774,6 +794,7 @@ const struct file_operations ovl_file_operations = {
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
+	.get_unmapped_area	= ovl_get_unmapped_area,
 };
 
 int __init ovl_aio_request_cache_init(void)
-- 
2.25.4

