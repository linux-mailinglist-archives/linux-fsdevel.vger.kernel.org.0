Return-Path: <linux-fsdevel+bounces-750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0E7CF836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E051BB217B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A41EB4F;
	Thu, 19 Oct 2023 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dO0aohtD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8591EB25
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:05:36 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D372123
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:33 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231019120429epoutp02b8e7f25056ed3d12fea139e2f7edf966~PgK4USSoa2723527235epoutp027
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231019120429epoutp02b8e7f25056ed3d12fea139e2f7edf966~PgK4USSoa2723527235epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717069;
	bh=ddG+iMTBPykY7aem2/d5RFRU6pD1r9HGia7WdJCIOGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dO0aohtDW8Y+Qo5zwCcjT305ZBTbZgibKLbv4F2+TzGAZV1opHVstGZ6uaD5yvx3n
	 txG4SaChvJGZnGweFXbE+VeBqunzfkUepszUaQr6wYUFi3uQeNkyqpD1V5Ab68rdFK
	 KtBzAf+bgJ7gxVo5w0hNTogGUlaePznMI1D6gzcA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231019120428epcas5p4d723ca2957f7203c4d2701934872abe7~PgK3kT7Kh2715127151epcas5p4B;
	Thu, 19 Oct 2023 12:04:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SB5x71dYBz4x9Pp; Thu, 19 Oct
	2023 12:04:27 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.88.10009.B4B11356; Thu, 19 Oct 2023 21:04:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231019111004epcas5p4ff1f40fbc56715d0b1033fa47adca93f~PfbXjg6vj2423124231epcas5p4n;
	Thu, 19 Oct 2023 11:10:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019111004epsmtrp205ee1fd77aee25a662712da74be81aae~PfbXiRvXZ1629616296epsmtrp2_;
	Thu, 19 Oct 2023 11:10:04 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-55-65311b4bc577
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.D9.08755.C8E01356; Thu, 19 Oct 2023 20:10:04 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019111001epsmtip1a2133c2992c6f76748a0a7ac4ecaac12~PfbUZyLMq0547905479epsmtip1j;
	Thu, 19 Oct 2023 11:10:01 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 11/12] null: Enable trace capability for null block
Date: Thu, 19 Oct 2023 16:31:39 +0530
Message-Id: <20231019110147.31672-12-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TezBcVxyec+/du4vZuh6dHqTJZjMyJYNdzyMobdK6JWaMzJiRPuTW3sFg
	7ezdTfpIJyIeU4YVj5QViYpEifeqIhaViqApqSBMaKK0HeTFtJpIqtalzX/f7zu/7/ud73fm
	iHDrYqG9KF6pYdVKJlFKmhOt15ycXUId5Kzs0ldC1DB4HUdP/lwjUGreCxxdmdaRaPHaMkBz
	PZkAlVeUEWiypx1DnRX5GKq+0oeh/N5xgObH9BgyTu1DX2dUEqjTOECg0Y5zJLpweV6Isifa
	SFTV/w+G7uTNA9Q2dwqg1rULOKpffESgG1MOaPhFvyDIjm7XTwvp4Zkmgh69qaWba74kaUPl
	SfoPQwmgr06mkPTF3AIBnXP6IUk/mZ8i6EddYySd21IDaMPQ5/RK8066ee4BFm55JME/jmUU
	rFrCKmOSFfHK2ABp6OHoA9Fe3jK5i9wX+UglSiaJDZAePBTu8m584sY2pJJjTKJ2gwpnOE7q
	9qa/OlmrYSVxyZwmQMqqFIkqT5UrxyRxWmWsq5LV7JfLZO5eG41HE+LGizOFqkybT243/oyl
	gEIqC5iJIOUJyxZLhFnAXGRNXQXQWFUl4ItlAIcX6jC++AvAzKbbYFuSerOG5A+MAI4OfLcl
	Scfgb7oZPAuIRCS1Dw6ti0y8LZWOw+67S8BU4NR5HBpm+zGTlQ0VDIfqFwQmTFCOsHqpbZMX
	U37wTlU/YTKClBvU/WJlos026MbsCpxvsYIDJXOECePULnj621Lc5A+pBjPYNT4GeO1B2JVh
	zt/aBi70twh5bA9XHhpJHh+H1YXfkLw2DUD9hH4rZiBMH9RthsEpJ9jQ4cbTr8OiwXqMn/sK
	zFmbw3heDNvOb+M9sLahfMvfDo6vntrCNFzoTCP4ZeUCWGt4LswDEv1LefQv5dH/P7oc4DXA
	jlVxSbEs56VyV7LH/3vmmOSkZrD5RZxD2sD9e49dewEmAr0AinCprdiRlrHWYgXz6WesOjla
	rU1kuV7gtbHvM7j9qzHJG39MqYmWe/rKPL29vT19Pbzl0tfEi+llCmsqltGwCSyrYtXbOkxk
	Zp+CXUzYHfbFiUqtZvleJPvjunlgg09RcJiF/0i6Y3bl8Dut90PmJgNXima9IgR1T7PcInJu
	tek/6nzr+w7vjrfhr7qgwZLs2fmApajVqGYnC6/EJaf2xoxz/vmrZ0urcz1aY/bMLNqGZD97
	o8VCh0Yc7lruFUe5B7nLLkcZVFSa2PUD55Xh62d27O+tsh+ovdHHHXJ772PjT767JmlZahDh
	tHtvRb7kCPT7XTcdyvhIyJ113UWRBb1+BSeZyKSzJ6KPHuP+dh+XGEsP933YMzLx9AcPS+16
	za2x9YjHzPuKSu7AJU134I6VpQdr1cErFnYTqucBTYZnsZIOq8KqaUG/pK84TEpwcYzcGVdz
	zL+ZEfCSqwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUzMcRzHfX+/3/3uV9vp57L1vY7YTZOa6pbxnacyma+nhj88rzr66UEP
	t9+VCCs1RelhNJKH6pweDkWXnESpdMiNiXQ3YdwRHdXFmrXEdbP577336/15f/54M6TYSHky
	sYnJHJ+oiJfRrlRju8xr/smpci5waNgb1T3pJNHwzzEKZRaNk+hqXyGNBtrtAFlacwAqV1+k
	kKn1DoGa1acIVHP1IYFOtfUAZH1VSqB7Zj9Uka2hUPO9xxTqbrpAo7JKqxDlvdbTqMrwm0C9
	RVaA9JajADWOlZGodmCQQo/MUvRs3CAIkeA7pX1C/OztTQp3G1NwvfYEjXWadNyvOwfwXVMG
	jS8XnBbg/KzvNB62mik8eP8VjQsatADrug7hkXovXG/5Rmx02+G6NIqLj93P8QHLI11jekpy
	hMoc9wMvb7wgMkAxmwtcGMgugJlGLZ0LXBkxexdAU3cdcAIJrBzvIJ3aHdb8/ix0hrIIWFhV
	LcgFDEOzfrBrgnH409lCEn4fP0s4Dkj2GgkbLooc2p1dDbtqvwocmmK9YY1NP5kRsUtgb5WB
	cvRANgAWvpvmsF3+2jfy1JN/xexi+L78o9AZnwYfn7NQzvpZMOvWebIIsKX/odL/UDkgtEDC
	KVUJ0QkquVKeyKX6qxQJqpTEaP89SQn1YHJx33l6cFs75N8GCAa0AciQsukibxzIiUVRioNp
	HJ8UwafEc6o2IGUomYfIoz8/SsxGK5K5fRyn5Ph/lGBcPDOIyKfSOT+mjM7VBYX7ffDZMHaY
	+NT/pNUgjkk6ougw2m1xRdbUxl+pZjJiS1C7ZvnUm2eGBlttoQ0ZApeC4Ecn364M/rRrmVWt
	J6njYctA6MFjS6R5w2np4Zd2tGxND7YtXJOPRkpyn7/v2N3SbbrFbw/S29e+6Y9Ytd4tbuFO
	N5s5syYzHy+SdIY32EJg2GHLSFdlsdf1soFq+Q+te/UuLls5oSHDpLPnezTFDLZ8GP1M2gWx
	Rl2oT23kXsGKuuymlg3NFRKwJ2qxKW+imI2vmnHFN0Szzn8l7xm3LUCkDp73xbQpbeZmUS9p
	7xml/favM1DPA5P73qxV93Q+WMPLKFWMQu5L8irFH+TAt8BgAwAA
X-CMS-MailID: 20231019111004epcas5p4ff1f40fbc56715d0b1033fa47adca93f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019111004epcas5p4ff1f40fbc56715d0b1033fa47adca93f
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019111004epcas5p4ff1f40fbc56715d0b1033fa47adca93f@epcas5p4.samsung.com>

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
index 968090935eb2..c56bef0edc5e 100644
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


