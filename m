Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC85C198
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfGARCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:02:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37748 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfGARCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:02:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61Gndq9184196;
        Mon, 1 Jul 2019 17:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ByHVvXG0J/ZWRXheS+Z3F8kLQCeBtiifOg6LqyUHoO0=;
 b=eYH58pqXtMojt1q3GuF/FcnVmQWVyK2aYO/++AJtaBmGIGOhLtB0vr9rMmiFT6uCM50V
 kMgNZgUen+OyQ98C8tjfaHb6SWm5505CRmyQFy/KKfnw4MajPeTH1u3LBjrYErojtpye
 BOpyS8M3ymqyrTMXEGmepBcMkOC//q8UihluwrIdLr9jS+EK6T5nJwZclXd8Rg2+yftW
 EOp5K/s09dxM5qmtB0YjGz0/dDqIoCE6ZXkUFCrNGHMbX8a+evBRyGcRQW0D9Ks3Qi31
 p/iZzou8Z9UiVLomOGYpeuzyU8mMeewX2yCi9PI9HsrEbghO4MQAlT/CnnPh2gBPF2Ta kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2te61dxu8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmNwX080428;
        Mon, 1 Jul 2019 17:02:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tebak9pbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:11 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x61H28C0001556;
        Mon, 1 Jul 2019 17:02:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:02:07 -0700
Subject: [PATCH 01/11] iomap: start moving code to fs/iomap/
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:02:05 -0700
Message-ID: <156200052577.1790352.9825618388583583693.stgit@magnolia>
In-Reply-To: <156200051933.1790352.5147420943973755350.stgit@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010201
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
index 57f496cff999..8ce7d57e4d30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8222,6 +8222,7 @@ L:	linux-fsdevel@vger.kernel.org
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

