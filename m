Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B7169A54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfGOR7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 13:59:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41950 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfGOR7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:59:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHxTCe143583;
        Mon, 15 Jul 2019 17:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZPs6hLbYqMJevsAfMSAkMV6SzndfSJoUyz9Kv0kHe64=;
 b=ZwB+XQWG80zrFST8v7D034eGikS0PJpPJi7rtwjyvaAzCvcCGEHZHNnbSK7Ozif1RHeY
 aI03f5IAWvrmLnXhi5WDTSmB3RikuMMm5wsnX+gfLvWF7Olil8BVXVQTm8316o62f2SF
 ZjYqSGWdoHIZeDLeFLi/TbOgrzZxOXgg9d4DG6v7j135Ub2nf+2ip6N/1RYdA7m1fIPC
 JsZW9PBe7vdv2l7ZkcGJAiY7SDfmEj2AGGltlI5tMzPSLf8tbBxWxLYXDMll6NluoMP4
 ZfgLsLT+mWeEne4LwTZe/aa8WveF7boy1Dd6SxzFgJX1IT0+p0DxOoSicPJm32MLxSKY iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qtg4uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 17:59:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHwWeu073878;
        Mon, 15 Jul 2019 17:59:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tq6mmdr80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 17:59:29 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6FHxSZH028477;
        Mon, 15 Jul 2019 17:59:28 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 10:59:27 -0700
Subject: [PATCH 1/9] iomap: start moving code to fs/iomap/
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        agruenba@redhat.com
Date:   Mon, 15 Jul 2019 10:59:26 -0700
Message-ID: <156321356685.148361.4004787941003993925.stgit@magnolia>
In-Reply-To: <156321356040.148361.7463881761568794395.stgit@magnolia>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150209
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150209
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Create the build infrastructure we need to start migrating iomap code to
fs/iomap/ from fs/iomap.c.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 MAINTAINERS       |    1 +
 fs/Makefile       |    1 +
 fs/iomap/Makefile |    7 +++++++
 3 files changed, 9 insertions(+)
 create mode 100644 fs/iomap/Makefile


diff --git a/MAINTAINERS b/MAINTAINERS
index f5533d1bda2e..1086ac7b0f05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8362,6 +8362,7 @@ L:	linux-fsdevel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 S:	Supported
 F:	fs/iomap.c
+F:	fs/iomap/
 F:	include/linux/iomap.h
 
 IOMMU DRIVERS
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..8e61bdf9f330 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_SYSCTL)		+= drop_caches.o
 
 obj-$(CONFIG_FHANDLE)		+= fhandle.o
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
+obj-y				+= iomap/
 
 obj-y				+= quota/
 
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
new file mode 100644
index 000000000000..b778a05acac3
--- /dev/null
+++ b/fs/iomap/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-newer
+#
+# Copyright (c) 2019 Oracle.
+# All Rights Reserved.
+#
+
+ccflags-y += -I $(srctree)/$(src)/..

