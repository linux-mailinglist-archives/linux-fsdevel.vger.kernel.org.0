Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3886B633
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 08:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfGQF7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:59:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44522 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQF7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:59:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5s3lE113596;
        Wed, 17 Jul 2019 05:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=heF+seV1dHYmsujuIGvoGvIPyc2pLaI4E/1NbHIygSE=;
 b=0xkpDwXSNpcVhcAYlySeLNWMKRS9OtT88hqr4ELalTwG/IyTGXOax9sNfarZ2wvB4NFd
 RdoIDoiH0xLprHdWTZJRJKaNsubGiQ1lsMOuXeYZ7RbPy7UEDIO76BibBrgGA+zu8N3A
 y/IH33DmI0m32Gxy5B/4XmH1gwi01yEEUw+58Rp3x2Uh16z0zRabiZA88f2SJTEt2Uh6
 ld6Wg4Wc29MjQy67aCkuG9r2jbeyIzF2yrjdrPo0L/SRcp3t4ucYixpYKl0vIBAGJl1v
 HFbSqr5doXU1aMTwepRdXbiaZFlULCpA0UCQ2n6wQO5lUKYct3Tn3MCvkHMjljFIB6tO OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78prbdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:59:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5wlej015311;
        Wed, 17 Jul 2019 05:59:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tsmcc6t1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:59:03 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H5x2NA014171;
        Wed, 17 Jul 2019 05:59:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 05:59:02 +0000
Subject: [PATCH 1/8] iomap: start moving code to fs/iomap/
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        agruenba@redhat.com
Date:   Tue, 16 Jul 2019 22:59:01 -0700
Message-ID: <156334314167.360395.8240505366577542787.stgit@magnolia>
In-Reply-To: <156334313527.360395.511547592522547578.stgit@magnolia>
References: <156334313527.360395.511547592522547578.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170073
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
 fs/iomap/Makefile |    5 +++++
 3 files changed, 7 insertions(+)
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
index 000000000000..de5a1f914b2c
--- /dev/null
+++ b/fs/iomap/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-newer
+#
+# Copyright (c) 2019 Oracle.
+# All Rights Reserved.
+#

