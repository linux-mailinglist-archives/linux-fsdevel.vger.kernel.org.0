Return-Path: <linux-fsdevel+bounces-6781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC43781C5D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA081C25224
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DFF22F0D;
	Fri, 22 Dec 2023 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u6/pyKiR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6422EF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231222073251epoutp01644b00b986fccd7c55140d6d2671f392~jFv_qKEA53115931159epoutp01a
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231222073251epoutp01644b00b986fccd7c55140d6d2671f392~jFv_qKEA53115931159epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230371;
	bh=Q0pzwoO8FGWSOp2naz3g5BT4IBzXcQeY3AEFwmS1OLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6/pyKiR4nJilbs/nHNIzIALHBG3JbtDMF4BLoWRbQ8HSC2Ny6pfO3uIivnnbAO3D
	 wewRSM0hc0eFPgPLaj+Xf49wYGe+aY3vHzKbrg4q24eMHWt/RpG4+F5KbNXGwpeoa6
	 bAu3PPNiHJpFtm4lMFevAXea+l6V48SLDWXOvxZ4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231222073250epcas5p14c52bc5a11e8cbb01b1668064dc1999b~jFv9cgZb32275422754epcas5p1e;
	Fri, 22 Dec 2023 07:32:50 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SxJt81Fsyz4x9Q7; Fri, 22 Dec
	2023 07:32:48 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7F.B9.19369.0AB35856; Fri, 22 Dec 2023 16:32:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231222062237epcas5p4ec8dd02068efc7f0fca133a4241ca308~jEyqMMj4Z0902509025epcas5p4S;
	Fri, 22 Dec 2023 06:22:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231222062237epsmtrp213b0b000da4a86971afba36caf47b248~jEyqK1Qpd1720617206epsmtrp2L;
	Fri, 22 Dec 2023 06:22:37 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-46-65853ba0b2af
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F7.D8.08817.D2B25856; Fri, 22 Dec 2023 15:22:37 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062233epsmtip22a1d209c2a01750ffee5de9c57802f9f~jEymvdoyd0303903039epsmtip2u;
	Fri, 22 Dec 2023 06:22:33 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 11/12] null: Enable trace capability for null block
Date: Fri, 22 Dec 2023 11:43:05 +0530
Message-Id: <20231222061313.12260-12-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0zTVxTHd3+/8qNQCz8eZte6MVLDNmDQVkq9vNRFgj91JN3YJG5mUOGX
	lgBt0wIyZVuZAo43KG7W8Zi6MaCRRxF5VaEGERrGH4Y62GRh0o2CkwFDo6RuLYXN/z73e8/3
	nHvOzWHi3hddOcw0eRatkksyuIQ7o+tW4JshDVEFNL9M64JaR2/jaGl1jYG+qLThqOV+BYEW
	bi0DNDtQBFDDpVoGmhzowVD/pWoMNbUMYajaaAbIMqHFkGEqGH1beIWB+g0jDHS39xsC1X9v
	cUUl97oJ1Dj8HEM/VVoAqjozgaHu2XyAutbqcXR1YZGB7kxtR+O2YZe9HKpHe9+VGp9uZ1B3
	x7KpjuYvCUp/5XNqTn8BUH2TGoK6XH7WhSo79YiglixTDGrxxgRBlXc2A0pvOkmtdPhRHbN/
	YmLPD9OjZbQklVb50/IURWqaXBrDPZSQtC8pXMQXhAgi0C6uv1ySScdwY98Rh8SlZdhHwvXP
	kWRk2yWxRK3m8nZHqxTZWbS/TKHOiuHSytQMpVAZqpZkqrPl0lA5nRUp4PN3htsDk9NlhTfH
	MGWRT27f2gyhAefIYuDGhKQQLnU1MRzsTfYDaJ07UAzc7bwMYE3tQ8J5eAzgqrmOsemob60E
	zgsDgI3tFuC0F2BwsT2+GDCZBBkMTf8wHbIvqcNhT7vAEY+TdTjU/zaMOS58yP3weWPbelIG
	GQAXr5swh5dNRkHr7QMOhCQPVvzq5Yhws6t/PLvs4mA26QVHLsyuO3HyNXjq2kXckR6Sejf4
	181eV+c7Y+Hy4DRwsg+cH+7c0Dlw5ZGBcPJx2HTuB8JpPg2g9p52w7AHFoxW4I5H4GQgbO3l
	OeVXYc3oVcxZ2AOWrc1iTp0Nu+s2eQfUtTZs5N8GzU/yN5iCtutzuHNu5QBOV1tBJfDXvtCQ
	9oWGtP+XbgB4M+DQSnWmlE4JVwpC5PTx/z45RZHZAda3JEjcDVrabKFGgDGBEUAmzvVlK946
	TXuzUyWfnKBViiRVdgatNoJw+8CrcM7WFIV9zeRZSQJhBF8oEomEEWEiAfdl9kJBbao3KZVk
	0ek0raRVmz6M6cbRYDVa5qHxIk92Ws78MT/r5FzhE4/RpaczPjLPT/eUnNirnMzrw6MOj+/X
	Mzs9z448NBeW8Sz5CXkexfTq1yPPrL3JOp3vAPWuZlQii+f5NcU3jL1Ps+KMb1Ov+29bePDg
	YP5XiTOaw0G2rdv9guvT423u1GrYmVLXtqaWQYEhWs76mV/F4rV5fRQgRqIlfnjojfOBvzzV
	FR2J1Ll9Fjuc8KOo1JR7ZNbvpUCx0BxwTWfekWeKjfPa+/fQFsgS7BQffW9flJHTEXInkixt
	FaedZG2xqrxy26WP5z8weVgGkU/iMe+Pd69+l3wwB2iOsgxvaM2BQyVhOSuv+Pzen7hLOsZl
	qGUSQRCuUkv+BXEBq4muBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHe885Ho+D0XETfNUw2ipoc9oi6O1m9aE6BVF0USiiVju5ldO5
	qd1xuWqtWqkV4crmfaVpNU1nmxnTMrNRalaaWcHMTNLMC5S5aknQt9/zvzw88FA4r4UIpZQJ
	yawmQRYvIDlEVb1gukQiPsHOHTUEo1tPHuFoaHScQOkZEzgqfXueRP313wDyPDAAlJufQ6CO
	BzUYcuZnYehG6UMMZbleAtTTbsZQbacY5Z0sJJCztolAbfeukshS3OOPzryyk8ja6MXQ64we
	gDJPtWPI7jkGUNW4BUfl/YMEetwZhp5NNPotD2VqzG/9mWfddwimzZ3C2EqMJFNRmMZ8qsgG
	jKNDRzIF5y74MSb9AMkM9XQSzOD9dpI5V1kCmIrmw8ywLZyxeb5gG6Zu5SyRs/HKVFYTFb2T
	ozhZ58bUBv4Bx/gHUgcu0qdBAAXp+dByKwOcBhyKRzsAPDvWQE4aIbB4ogGfZD684e31nwzp
	Meh+qf8zUBRJi2HzL8qnB9F2HH4v02O+Ak7fxGFlDtfHfHo19FpvEz4m6FlwsLoZ83W59GLY
	92iNDyEdBc+/C/QlAv6ovT8K/HzMoxfBpt6Kv+dw6UDYlO0hJrdPh/q7V/AMQJv/s8z/WbkA
	KwEhrFqrilNppep5Cez+SK1MpU1JiIvcnaiygb9fF4nswFnyNdIFMAq4AKRwQRA3MeI4y+PK
	ZQcPsZrEHZqUeFbrAmEUIQjmjvWb5Dw6TpbM7mNZNav552JUQKgOm6nau6xxQFh9anGtcESA
	5qAz0bONiueZ3lp5+q91S9vNXvHtjVnVhd2t5WUvGiTk0YtGN7lK2n3NT1yYyt51KUQrLa2c
	Krjks+3wz7SzK6QjqYN2ZZ0ldvxCzCWmxhSrqB5Vb1YGPa17M0MQnARetSmijyaFr71pqrRK
	Pa7sbc68Yk/6nuG4tD5Dy6Y+qiPnfevAWKrj4HbTim0xkvDrsUufLsxvkQ8tXBCiM65PSuao
	PxoN9ULOV71cunMgLIK7peCdVTbsyJkmPDGCdd137ZIk89NjwfYi60hrUcQ13eXMPZnsfP7s
	aYFubdb7UpvziFLo6uqaEpDYR4uiBIRWIZOKcI1W9hvNZliTZAMAAA==
X-CMS-MailID: 20231222062237epcas5p4ec8dd02068efc7f0fca133a4241ca308
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062237epcas5p4ec8dd02068efc7f0fca133a4241ca308
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062237epcas5p4ec8dd02068efc7f0fca133a4241ca308@epcas5p4.samsung.com>

This is a prep patch to enable copy trace capability.
At present only zoned null_block is using trace, so we decoupled trace
and zoned dependency to make it usable in null_blk driver also.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/block/null_blk/Makefile | 2 --
 drivers/block/null_blk/main.c   | 3 +++
 drivers/block/null_blk/trace.h  | 2 ++
 drivers/block/null_blk/zoned.c  | 1 -
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Makefile
index 84c36e512ab8..672adcf0ad24 100644
--- a/drivers/block/null_blk/Makefile
+++ b/drivers/block/null_blk/Makefile
@@ -5,7 +5,5 @@ ccflags-y			+= -I$(src)
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs			:= main.o
-ifeq ($(CONFIG_BLK_DEV_ZONED), y)
 null_blk-$(CONFIG_TRACING) 	+= trace.o
-endif
 null_blk-$(CONFIG_BLK_DEV_ZONED) += zoned.o
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3021d58ca51c..1b40c674f62b 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -11,6 +11,9 @@
 #include <linux/init.h>
 #include "null_blk.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"null_blk: " fmt
 
diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trace.h
index 6b2b370e786f..91446c34eac2 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -30,6 +30,7 @@ static inline void __assign_disk_name(char *name, struct gendisk *disk)
 }
 #endif
 
+#ifdef CONFIG_BLK_DEV_ZONED
 TRACE_EVENT(nullb_zone_op,
 	    TP_PROTO(struct nullb_cmd *cmd, unsigned int zone_no,
 		     unsigned int zone_cond),
@@ -67,6 +68,7 @@ TRACE_EVENT(nullb_report_zones,
 	    TP_printk("%s nr_zones=%u",
 		      __print_disk_name(__entry->disk), __entry->nr_zones)
 );
+#endif /* CONFIG_BLK_DEV_ZONED */
 
 #endif /* _TRACE_NULLB_H */
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55c5b48bc276..9694461a31a4 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -3,7 +3,6 @@
 #include <linux/bitmap.h>
 #include "null_blk.h"
 
-#define CREATE_TRACE_POINTS
 #include "trace.h"
 
 #undef pr_fmt
-- 
2.35.1.500.gb896f729e2


