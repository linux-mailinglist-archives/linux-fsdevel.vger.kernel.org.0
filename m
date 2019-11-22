Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B61105E5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 02:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKVBqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 20:46:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38654 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVBqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:46:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1iJoV114927;
        Fri, 22 Nov 2019 01:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=OwY+D9qGKI49K3+/ouo1AvQdPJnLK/yuze3zbUyDGv8=;
 b=i55wGTcgYS/KkN4KPy/IXeuZbpI+0Key3N8rQoWVcF+sYcYLHq3XPSpCCB6FSsBjMJBK
 Ye8/PRTpj16M66Kc0jwcCVVmeizXoFuWOfz0UJ+7M1FFrY/NMFOAwQEyR/EqF37bATtg
 e2cXuQbyNSthYtuXV1f2IopTMG0nZKVT3pDAWK6oiAD7gswUoFNhPtYFHZgqgs18APSE
 9j5iLt6m6E/dS3PeOM6G+oCgR3wwzJsgnTym3f5A41HQkLQ6oVH5yYxegUrEeJbH39bj
 BJgTZQZjWJGBFEUW0SfBUrZeTCsV5HtVmpIH/8WvGEffcWRfRybbELtajIk/LPZktq1X Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wa92q7ta2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:46:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1hvTb003474;
        Fri, 22 Nov 2019 01:46:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wda072689-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:46:04 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAM1k2nT003105;
        Fri, 22 Nov 2019 01:46:02 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 17:46:02 -0800
Date:   Thu, 21 Nov 2019 17:46:01 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] iomap: trace iomap_appply results
Message-ID: <20191122014601.GQ6211@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=959
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220013
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is basically a debugging patch that I've been using to monitor what
exactly xfs is sending back to iomap, and thought I ought to pitch it to
the mailing list universe to see what reaction I get.

--D

---
From: Darrick J. Wong <darrick.wong@oracle.com>

Add some tracepoints so that we can more easily debug what the
filesystem is returning from ->iomap_begin.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/apply.c |    7 ++++
 fs/iomap/trace.h |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 484dd8eda861..76925b40b5fd 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -7,6 +7,7 @@
 #include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/iomap.h>
+#include "trace.h"
 
 /*
  * Execute a iomap write on a segment of the mapping that spans a
@@ -28,6 +29,8 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	loff_t written = 0, ret;
 	u64 end;
 
+	trace_iomap_apply(inode, pos, length, flags, ops, actor, _RET_IP_);
+
 	/*
 	 * Need to map a range from start position for length bytes. This can
 	 * span multiple pages - it is only guaranteed to return a range of a
@@ -48,6 +51,10 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	if (WARN_ON(iomap.length == 0))
 		return -EIO;
 
+	trace_iomap_apply_dstmap(inode, &iomap);
+	if (srcmap.type != IOMAP_HOLE)
+		trace_iomap_apply_srcmap(inode, &srcmap);
+
 	/*
 	 * Cut down the length to the one actually provided by the filesystem,
 	 * as it might not be able to give us the whole size that we requested.
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 4ca1aa2f3f6e..6dc227b8c47e 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -80,6 +80,109 @@ DEFINE_PAGE_EVENT(iomap_writepage);
 DEFINE_PAGE_EVENT(iomap_releasepage);
 DEFINE_PAGE_EVENT(iomap_invalidatepage);
 
+#define IOMAP_TYPE_STRINGS \
+	{ IOMAP_HOLE,		"HOLE" }, \
+	{ IOMAP_DELALLOC,	"DELALLOC" }, \
+	{ IOMAP_MAPPED,		"MAPPED" }, \
+	{ IOMAP_UNWRITTEN,	"UNWRITTEN" }, \
+	{ IOMAP_INLINE,		"INLINE" }
+
+#define IOMAP_FLAGS_STRINGS \
+	{ IOMAP_WRITE,		"WRITE" }, \
+	{ IOMAP_ZERO,		"ZERO" }, \
+	{ IOMAP_REPORT,		"REPORT" }, \
+	{ IOMAP_FAULT,		"FAULT" }, \
+	{ IOMAP_DIRECT,		"DIRECT" }, \
+	{ IOMAP_NOWAIT,		"NOWAIT" }
+
+#define IOMAP_F_FLAGS_STRINGS \
+	{ IOMAP_F_NEW,		"NEW" }, \
+	{ IOMAP_F_DIRTY,	"DIRTY" }, \
+	{ IOMAP_F_SHARED,	"SHARED" }, \
+	{ IOMAP_F_MERGED,	"MERGED" }, \
+	{ IOMAP_F_BUFFER_HEAD,	"BH" }, \
+	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }
+
+DECLARE_EVENT_CLASS(iomap_class,
+	TP_PROTO(struct inode *inode, struct iomap *iomap),
+	TP_ARGS(inode, iomap),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, ino)
+		__field(u64, addr)
+		__field(loff_t, offset)
+		__field(u64, length)
+		__field(u16, type)
+		__field(u16, flags)
+		__field(dev_t, bdev)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->addr = iomap->addr;
+		__entry->offset = iomap->offset;
+		__entry->length = iomap->length;
+		__entry->type = iomap->type;
+		__entry->flags = iomap->flags;
+		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
+	),
+	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d addr %lld offset %lld "
+		  "length %llu type %s flags %s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
+		  __entry->addr,
+		  __entry->offset,
+		  __entry->length,
+		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
+		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS))
+)
+
+#define DEFINE_IOMAP_EVENT(name)		\
+DEFINE_EVENT(iomap_class, name,	\
+	TP_PROTO(struct inode *inode, struct iomap *iomap), \
+	TP_ARGS(inode, iomap))
+DEFINE_IOMAP_EVENT(iomap_apply_dstmap);
+DEFINE_IOMAP_EVENT(iomap_apply_srcmap);
+
+TRACE_EVENT(iomap_apply,
+	TP_PROTO(struct inode *inode, loff_t pos, loff_t length,
+		unsigned int flags, const void *ops, void *actor,
+		unsigned long caller),
+	TP_ARGS(inode, pos, length, flags, ops, actor, caller),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, ino)
+		__field(loff_t, pos)
+		__field(loff_t, length)
+		__field(unsigned int, flags)
+		__field(const void *, ops)
+		__field(void *, actor)
+		__field(unsigned long, caller)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pos = pos;
+		__entry->length = length;
+		__entry->flags = flags;
+		__entry->ops = ops;
+		__entry->actor = actor;
+		__entry->caller = caller;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos %lld length %lld flags %s (0x%x) "
+		  "ops %ps caller %pS actor %ps",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		   __entry->ino,
+		   __entry->pos,
+		   __entry->length,
+		   __print_flags(__entry->flags, "|", IOMAP_FLAGS_STRINGS),
+		   __entry->flags,
+		   __entry->ops,
+		   (void *)__entry->caller,
+		   __entry->actor)
+);
+
 #endif /* _IOMAP_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
