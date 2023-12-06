Return-Path: <linux-fsdevel+bounces-4977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057CA806C3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65413B20CDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A303032A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M0GB+QCV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6410DD
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:13:02 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231206101300epoutp03ad34ace6eabc8d2a8a1993c0cf5204e0~eNnP5JJxJ2450524505epoutp038
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:13:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231206101300epoutp03ad34ace6eabc8d2a8a1993c0cf5204e0~eNnP5JJxJ2450524505epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857580;
	bh=1x20GT9zf7S1tCU9RCvaOg6FImzWr8BSd/HxmmWgI7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0GB+QCVe6oVxdni4uuAcVQ8SWK0IHezmwmBx3mZd5wskujheiE/EcHHqoGbfHSmT
	 zBvniwmg9rf0s5Z7D4h3/hzJPAbwvDydR3ePyNdatyszdacjkYdpuRqImOboOHkH6m
	 pzOzldeDPcGmAUJOl1gZSkeo6GMn+6cwAfiyrTM8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231206101300epcas5p4e0ba5cbc5ff683cdd722f4d403b71780~eNnPIVgZC2294422944epcas5p4s;
	Wed,  6 Dec 2023 10:13:00 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SlYBK6PQbz4x9Q2; Wed,  6 Dec
	2023 10:12:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.98.19369.92940756; Wed,  6 Dec 2023 19:12:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101257epcas5p253880d2f8f6318483cd2361b109350d3~eNnMhaHzO2308423084epcas5p24;
	Wed,  6 Dec 2023 10:12:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231206101257epsmtrp2611297c07d68894fd770de346b022efd~eNnMfOfmP0990909909epsmtrp2V;
	Wed,  6 Dec 2023 10:12:57 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-28-657049290644
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.62.08817.92940756; Wed,  6 Dec 2023 19:12:57 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101252epsmtip2f2b615fa7c066041d23ec7348dd3a4e9~eNnIUmOIz0221302213epsmtip2K;
	Wed,  6 Dec 2023 10:12:52 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
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
Subject: [PATCH v18 11/12] null: Enable trace capability for null block
Date: Wed,  6 Dec 2023 15:32:43 +0530
Message-Id: <20231206100253.13100-12-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0ybVRjGc76vfG2HxQrTHaoO+BKj4MpaB+xUgZFs04+gGQnRuP1hbehH
	YZS29uKYRGUwGJcxCngr47IVcHLZgMK4rThgKrSo5Va56NgGRVSyEWC4ZIxpSzvdf7/3vM9z
	3jzvyWHhviVMHitFoaXVComcJLYxOq4FB/ODY1W0YCmPj5qtP+BoZX2DgbL0mzhqvF5MoKVr
	qwA5+k4BdM5YyUDTfd0YMhtLMVTf+D2GSgd+AWjBXo6h3pmX0fncWgYy91oYaLyngkDVXy8w
	UeFkF4EuDD7E0JR+AaCSPDuGuhwnAOrYqMbRpaVlBhqaeRbZNge9YnhUd/l1JmWbbWVQ4z/p
	KFNDPkG11X5K/dFmANSV6UyCqjlT5kUVZd8hqJWFGQa1/K2doM60NwCqbTiDWjPtpEyO21j8
	k0dSI5NpiZRWB9KKRKU0RSGLIuMSxPvF4RECIV8oQnvJQIUkjY4iD7wZz389Re5cCRn4oUSu
	cx7FSzQacnd0pFqp09KByUqNNoqkVVK5KkwVqpGkaXQKWaiC1r4qFAheCXcK309Nbh2oJFQd
	fuk3aidBJjBzCwCbBblhcMI6wSwA21i+XDOAn1+wEO5iFcB1kx64i78BfJCr93pkyc/LwdyN
	XgDzWxo9/jUAe25mOjssFsENhiNlOpdhO7cJh92tQpcG51bhsG1uEHM1/LhvwFN1w1vM4L4A
	h/T2LeZwRfDqjzame1oANIzd22K287xs0Yi7NU9Bi8HBcDHu1GRfPou7BkBuJxsWnV7E3eYD
	8ObFKQ/7wb8G2z2X8uDanV7CzYlwzPAz5mYtnDf3e3gfzLEW464wuDNMc89u9ywfWLTh2MoI
	uRyYl+vrVgfB2dIFz4J2wFtf1XqYgqN1uZ5lnQZw9Mqilx4ElD8WofyxCOX/TzsH8AbAo1Wa
	NBmdGK4S8hX0sf+eNlGZZgJbfyMkvgs0tmyGDgCMBQYAZOHkdo7cpqR9OVLJ8Y9otVKs1slp
	zQAIdy65BOc9nah0fi6FViwMEwnCIiIiwkR7IoTkDs5STqXUlyuTaOlUmlbR6kc+jMXmZWJF
	05lz+xwpCTard4I3LKpp6SDbMl7qye6/0S5LKlzs19my1NaV6PwhosKn1F8hPzEfc9l21PiW
	kRG03/Euudw4Ibr0Dy+m7zXzeyO/P98wInn7YIXs45q9Sz0b/rO/FhiCpF1+POX4B3aW2T4W
	TbONm5oj3yWMJsVOxRYealr0r7KG7An54p2sANnYff39+rvVlZ2H/MbZppLO1fS4P+9eLLb8
	dtui/+aJGGaTZVkkXJ9n7/K5l+Egjqcf3SWWDX1ysvA5rZfms2oD9eVhy/kSo/fkTv4xTvPh
	8LoZyzMxwy82yPOI6aSqs7dOjgri5rIfVK+qrkZGxzWL64NVyQ7hQ5KhSZYIQ3C1RvIvdqji
	VqQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSvK6mZ0GqwawjXBbrTx1jtvj49TeL
	RdOEv8wWq+/2s1m8PvyJ0eLJgXZGiwWL5rJY3Dywk8liz6JJTBYrVx9lsph06BqjxdOrs5gs
	9t7StljYtoTFYs/ekywWl3fNYbOYv+wpu0X39R1sFsuP/2OyuDHhKaPFxI6rTBY7njQyWmz7
	PZ/ZYt3r9ywWJ25JW5z/e5zVQcpj56y77B7n721k8bh8ttRj06pONo/NS+o9Xmyeyeix+2YD
	m8fivsmsHr3N79g8Pj69xeLxft9VNo++LasYPTafrvb4vEnOY9OTt0wB/FFcNimpOZllqUX6
	dglcGRsPzWUr2CZccX/JdcYGxj0CXYycHBICJhKdHa1MXYxcHEICuxkluh6cZYdIiEs0X/sB
	ZQtLrPz3nB2i6COjxLIZfSxdjBwcbAKaEhcml4LERQR2MEv8XNvMBNLALLCGWWLLXF4QW1jA
	XaJ96WmwOIuAqsSJCVfBbF4BS4n9Z85DLZCXmHnpO5jNCRSf/HwRM4gtJGAhsa9xOgtEvaDE
	yZlPWCDmy0s0b53NPIFRYBaS1CwkqQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3
	MYLjXUtrB+OeVR/0DjEycTAeYpTgYFYS4c05n58qxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb
	694UIYH0xJLU7NTUgtQimCwTB6dUA9MGnfk2ka/sCgwSNnidOucimHrtZZXsTef1ktVO94zW
	Gu6Kr3CUDn1f3bFhU7/C0a/VnAHyvU0nnU5NFl70df7xyJvxJ7yzrwQ8MfyzQmODiFFD8Y+2
	9z5JaX1V/g8rYjmNxQOe78r0457ZppbXv5DlZ1QP72F52ZUmU+w/1u9+u8n5isvesgkZvh+v
	PGC4c/s4f5igitqLGvuwbMeg3vQOC957W+XFWyYl3/q4flnS9OzbXXvFFtq5laSk5xps/aed
	cr3gzSvWCdUbTr7ueD9FOkJa7dvr/deZit2TzlraPTv6/KfSA02untW3un8unli9rnPH1dQl
	KgyL/M9eeGycXtZr2L56kcuBm08TZyuxFGckGmoxFxUnAgAxHznxZgMAAA==
X-CMS-MailID: 20231206101257epcas5p253880d2f8f6318483cd2361b109350d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101257epcas5p253880d2f8f6318483cd2361b109350d3
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101257epcas5p253880d2f8f6318483cd2361b109350d3@epcas5p2.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

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


