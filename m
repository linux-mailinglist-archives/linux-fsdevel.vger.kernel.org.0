Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265871FF14D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 14:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgFRMKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 08:10:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:58261 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgFRMKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:10:13 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200618121009epoutp02fd835de1c451ec231a7dfc8ee8b5fb8e~ZoiHCFmCU0480004800epoutp02L
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 12:10:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200618121009epoutp02fd835de1c451ec231a7dfc8ee8b5fb8e~ZoiHCFmCU0480004800epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592482209;
        bh=vjuIqEJrow48HTftCC7QXvVlxYZ/RCtLUMgGhLL3EZk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kciM2KW1a5tljq97EUdfV57hSoHS+6PBTSlB2nqx4QG9OGRtW+EPdAfDBa+VEU1Tw
         jIWVsq3cjwBgqeocfWOzoTU7EhwFISRhWMd11bkvfpcXjS12xbAXWFfUAK0+YWyhKg
         YeDYl5tB9M58sZ9yHzIxQPfFjpD5n//jJocZFry4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200618121008epcas1p4de6f2446f64408e1e85f9bcde75885b3~ZoiGvb5pv3178331783epcas1p48;
        Thu, 18 Jun 2020 12:10:08 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49ngjq6YPxzMqYkZ; Thu, 18 Jun
        2020 12:10:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.CB.29173.F995BEE5; Thu, 18 Jun 2020 21:10:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200618121007epcas1p1aa0f24b361e0232913bf7477ee0a92c8~ZoiFefivc2444024440epcas1p1c;
        Thu, 18 Jun 2020 12:10:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200618121007epsmtrp292f6ed3f2fa5db419dc7b79760a3daf3~ZoiFd3Syg3212132121epsmtrp2Z;
        Thu, 18 Jun 2020 12:10:07 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-c7-5eeb599f7cf2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.70.08382.F995BEE5; Thu, 18 Jun 2020 21:10:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.115]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618121007epsmtip1f5eb374c3713eab1424c3a8d666be777~ZoiFTs-WY1697916979epsmtip1S;
        Thu, 18 Jun 2020 12:10:07 +0000 (GMT)
From:   Sungjong Seo <sj1557.seo@samsung.com>
To:     namjae.jeon@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH] exfat: flush dirty metadata in fsync
Date:   Thu, 18 Jun 2020 20:43:26 +0900
Message-Id: <1592480606-14657-1-git-send-email-sj1557.seo@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7bCmru78yNdxBk8/GFrs2XuSxeLyrjls
        Fj+m11ts+XeE1YHFo2/LKkaPz5vkApiicmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgPYoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoM
        DQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMmZsO8BYsFa04vSZ7awNjLcEuxg5OCQETCR+NNZ3
        MXJxCAnsYJSYsmc3WxcjJ5DziVFiwgEWCPsbo0TbhVgQG6T+zuorLBANexklPs79yAbhfGaU
        mPFkLiNIFZuAtsTypmXMILaIgLTEpPnHmUBsZoEMiZtvjoPVCAuYSpy6shTMZhFQlVj9YivY
        Nl4BN4nmUw9YILbJSZw8NpkVZIGEQDu7xKfZZ9ghznaR2LSgAKJGWOLV8S3sELaUxOd3e9kg
        7HqJ3atOsUD0NjBKHHm0EGqoscT8loXMIHOYBTQl1u/ShwgrSuz8DXE/swCfxLuvPawQq3gl
        OtqEIEpUJL5/2MkCs+rKj6tMECUeEv1HEyBhFSsxe+cblgmMsrMQ5i9gZFzFKJZaUJybnlps
        WGCMHEObGMEJR8t8B+O0tx/0DjEycTAeYpTgYFYS4XX+/SJOiDclsbIqtSg/vqg0J7X4EKMp
        MLgmMkuJJucDU15eSbyhqZGxsbGFiZm5mamxkjivr9WFOCGB9MSS1OzU1ILUIpg+Jg5OqQam
        /fWKE67MlTy6pqSnLkdfYb6RxpLnST02i57/duwIy2/3Cutdul/k0I79uiJRfv/iDy6av5Pz
        fJT91vNlJ38YrHvklv4+f+vRI2cvnX22MzJeXC79U1rDhqCqRe28G57p6fyKkfuvfPJkFjf3
        KbsP+c71ndc5Oidl6QhOSj1V4/Zlm2nHC96gSdH9uWlHd7GdafCyenvwckVekfOUhyxPqmR0
        GsO22us81vE6Yy9cmapqXShc4JG11KLmn9yt/5mVCZXt4V81Zhir205efan6hZ7M4nz9pUEz
        2JJLzp75s2/TzxuL2TZsLXiu1hm0M/KgjpH7iuQlAg9E+Pgvbjg7x3p32WcWyTc//3ufTVus
        xFKckWioxVxUnAgAy1Z+vcEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJMWRmVeSWpSXmKPExsWy7bCSnO78yNdxBtOvilrs2XuSxeLyrjls
        Fj+m11ts+XeE1YHFo2/LKkaPz5vkApiiuGxSUnMyy1KL9O0SuDJmbDvAWLBWtOL0me2sDYy3
        BLsYOTkkBEwk7qy+wtLFyMUhJLCbUWJXz0bGLkYOoISUxMF9mhCmsMThw8Ug5UICHxkluh47
        g9hsAtoSy5uWMYPYIgLSEpPmH2cCsZkFsiRu3TrKAmILC5hKnLqylBHEZhFQlVj9YitYnFfA
        TaL51AMWiBPkJE4em8w6gZFnASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4BDQ
        0tzBuH3VB71DjEwcjIcYJTiYlUR4nX+/iBPiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6NwYZyQ
        QHpiSWp2ampBahFMlomDU6qBKa8tf+Wxwx7HrLfYMP0/4jonhG2z406591ZTpubJHv+c9Kzj
        vOki5t/euSfmGaeeOHfIeINX2ZSSE79eH20SzzvB9IjzSLbkli+6yVXx1T99Xumyihs6Lumy
        O1Z9Pyu5odI97s7aGUfLdIPTdHc6rf67RsV0s7Xj2T/+apFeU3VMPyx5fXam7e99Pis9da7/
        mzfLfN/aZif1bRy88wwniMbtWmH6aIl/326J2++yfDqOHN0iLV/Ct/zuI5m58aWRSouaVuXW
        O7pEzvohNXXJ3aInK3/czfKYXB7cZSt3s7dJcbf+qeL1Vd+PBRnXrZr5NXtK5broE34lv56c
        4Tr1N5BhfaOi/cet8xjYrA+eL1BiKc5INNRiLipOBADj/w/OcAIAAA==
X-CMS-MailID: 20200618121007epcas1p1aa0f24b361e0232913bf7477ee0a92c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200618121007epcas1p1aa0f24b361e0232913bf7477ee0a92c8
References: <CGME20200618121007epcas1p1aa0f24b361e0232913bf7477ee0a92c8@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

generic_file_fsync() exfat used could not guarantee the consistency of
a file because it has flushed not dirty metadata but only dirty data pages
for a file.

Instead of that, use exfat_file_fsync() for files and directories so that
it guarantees to commit both the metadata and data pages for a file.

Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/dir.c      |  2 +-
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/file.c     | 19 ++++++++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 02acbb6ddf02..b71c540d88f2 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -309,7 +309,7 @@ const struct file_operations exfat_dir_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate	= exfat_iterate,
-	.fsync		= generic_file_fsync,
+	.fsync		= exfat_file_fsync,
 };
 
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu)
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 84664024e51e..6ec253581b86 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -417,6 +417,7 @@ void exfat_truncate(struct inode *inode, loff_t size);
 int exfat_setattr(struct dentry *dentry, struct iattr *attr);
 int exfat_getattr(const struct path *path, struct kstat *stat,
 		unsigned int request_mask, unsigned int query_flags);
+int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index fce03f318787..3b7fea465fd4 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/buffer_head.h>
+#include <linux/blkdev.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -346,12 +347,28 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 	return error;
 }
 
+int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
+{
+	struct inode *inode = filp->f_mapping->host;
+	int err;
+
+	err = __generic_file_fsync(filp, start, end, datasync);
+	if (err)
+		return err;
+
+	err = sync_blockdev(inode->i_sb->s_bdev);
+	if (err)
+		return err;
+
+	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL);
+}
+
 const struct file_operations exfat_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-	.fsync		= generic_file_fsync,
+	.fsync		= exfat_file_fsync,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
-- 
2.17.1

