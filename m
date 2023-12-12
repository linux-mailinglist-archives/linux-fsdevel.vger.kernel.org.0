Return-Path: <linux-fsdevel+bounces-5662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C880E9BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C0A1C20B81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A48D5DF11;
	Tue, 12 Dec 2023 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFopWKc5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MiYwWPre"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B05DC;
	Tue, 12 Dec 2023 03:09:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hpf8021911;
	Tue, 12 Dec 2023 11:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=colzMufsJuw5xL9Z5Ds70rQsQNUsLTo5u2eT2eZG94Y=;
 b=CFopWKc5NOLLbXC1sxdN2+EtlP9msUFns1JpQRmxKenqjstyw5o6d4/zgCmLed+/DzeP
 LbnCzRndHbh0vMV0VezHAKqcRUKqqM3/+SPPvuh74z5CEN/NlDGN3UgyFGamreC5RQtW
 yV7NPwIKgHqVzQtk3mcj3nreGBCuVuc4NF3SoxJscYq/RRTD4p87NCxDEAu4yclU4TCU
 YZZ0jQS9rRcOaGWw+bj2ciYDHU91B9OPB5AmVQstWvVwgBWz6mu2RYQT4nr5PPgnTxry
 L2LvCUa2NW4Mp6gU9VSqkI0vrfY5yyZmegMA+lBTxBGq4vCp/FVnXnumwDYY8r5vbnf8 eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3kn9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAxAsv003210;
	Tue, 12 Dec 2023 11:09:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6e16k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaSsQWq58fc3Capx39YJu1psXAA23JMPDyzOZUzzXGAMejQX4pMuG0Dh5Oh+/oNbAjt3lyobyDGqJ4zO6xI16mfbFrjlq9l5QvU59e/2ibb8kb071lsF5BeozYPeOAQ6nfma9m9purCe3EE6guvSU1d2YbGz2MX64+dMFqN0yoz5lT2Q+w1C1cB8zhR/jQqolNIXTf0jIuigsS3Pnak4W3P5bv+KPb+Se/brFvgiV8xj3OfcyNa5ahoq5bvQkbtxwwk/LUNvsPCBlvmvyzE3cjjAhHn5lNS9r+BA+TQz2VodqjU8hsv9YYxytkKFeQ4ZRgnzB4RO+BXQ1dBMhHRqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=colzMufsJuw5xL9Z5Ds70rQsQNUsLTo5u2eT2eZG94Y=;
 b=iXSPs3asMa0ALgpklXMEtrkMMlaA91XM2ypVkoWlYlKfbEVDIcv1+dWsw4mG1D4qx32ObT18uGrRuozuEk7J3WudZs3+GNccLVgWyqVs0kwfOix56zVB2jFOC5boZek/ctmdZk2LJ8krsf4yAnxDtN5yib0FVZ/NdwttVD9WobaQV/Bjb5MX8ihCH6dsTr0HGXqJL1jyULGONnj0LAtpgAh+xpH/UTN5uRSnA1f1Ntwk2/XRzC2tZDwDmtlWDzz6g759ba29K2LDa6d72ZGVVbRg4rZ1d71v2mo8vryGLyaNWvMY8eWAcM0dn+1z1ygWrw7EGy+Ua/vuro6tXjPD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=colzMufsJuw5xL9Z5Ds70rQsQNUsLTo5u2eT2eZG94Y=;
 b=MiYwWPreYfhbO5LRiUVW3XvDb6iCLLuiGACflCsL2ulfzrnYTF2H5cTxjQvUIKftYkZg0P5VpQSAYeSLnodV9TLcOtcu+YViNFAkCM/jOmv+81kHfj8cjGNSdx4oGcUYznY5dsk0LItJivY1YTj8YsQk3PAh6CiWswvWUcIWJ24=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 02/16] block: Limit atomic writes according to bio and queue limits
Date: Tue, 12 Dec 2023 11:08:30 +0000
Message-Id: <20231212110844.19698-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0255.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ba3071-7499-4102-8fdf-08dbfb02c7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VA3DmgVxI6WGT2956/2NVa//a6Xof1nJ4thgcfHfqWHuBYugdqrPOPeFD/V3T+BZ/UNsVjeicpXALH4grXzqgNLFPSv5v1n3914+PwmAaFN7Al7F/WGgLX9c0HhqMKPyyj54AcGtzhL+/Blkiwa5naEZGNQjv8bs96F+b0/6joa4EoVuF1uGgPE2dsU6MJbcYhyVWVY0afXCnFvMHp/+33yj+P81Qp/NKJun80/WmzKCXuj2E+3uhJqyhS2aHsDcssZ3XQApbX9Mc1DA6bHLuMRoKcZlI/34yEeFj8LTKs5HVH74dIswhnkvETlTFOdZfGSGnbYj36cObjNpwthLbcwVRvqCjzb0Ecyh/yIZebvFQxb5IQV1750rCNybt2M2OAuWKkacW8grr18oeSx5ftesWVg+4h446zQsQHNl/kiWidpe+gR4NVOJXfCNBetql7KVoQ/2/cyHjokMLLgKnL7Idkq9X6DWpI/jmySXrdMcsRF09pXKx4A2I5sbzd/hPaB9tALFkxuRV0weFacZA3jd1P2oWlo+drdGWXLmy6P3EOwRtjYP7YnOcsLHiHdveZ+SmE7aOykQrsK5Hau+sxk+k3PrjNEofdfpbfJ3f1w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?clDQ3XYr3tP41S3KEVaIGDnJVozb34F+Qrwq63CkwsRL0cBhsckPN6MHdVMs?=
 =?us-ascii?Q?CxNj88jH2SNGx5iFJRtRKtWFu+59PbwtoW3nKQ6ESRSckmjqYAyWaD30c1y2?=
 =?us-ascii?Q?DnHLWEIw1qTj0QW85R0fJ42F+ZbstUl15lumHW4nV0oDuoQJ/DmNF5MIA0xg?=
 =?us-ascii?Q?xlGbHhqIwpIYdedS5PSRcubE0VrL0boVypnsuHn0UCpwmUOu0Lmk5ou42FzJ?=
 =?us-ascii?Q?Ku5QNbqh0a/qtDz2puSyHWMlAoU116GELh+W9GKQzD/lT4cIBi7hlH4pCW+0?=
 =?us-ascii?Q?PFcOQiuAgsdMvN1n/W+eaEwzTyYMoEdjdTzkhrqjELf3EFn3FJ21/RSfgLYV?=
 =?us-ascii?Q?DPPplnikugfbykxCIMja0fEFb1aQS5s5RafHp7hPANXk1yOMCJJUJB6whtYY?=
 =?us-ascii?Q?QZxZ7ANJJJ3xXRoHSI5R5APa3NyvzHMm7p13rXhLOyNVh4/QQ2/mGOXvgQiX?=
 =?us-ascii?Q?0ibVV7JQzTTcnDXUtzCwzgirdjGcvsm3W0lpo+iLbRcsO7GSSRaWDvCadNyS?=
 =?us-ascii?Q?PMKroBYac0YnUm4aGFI2T/dbLsuqOteEXOxnmW5XVJvoCdaSguGkoNakaSsU?=
 =?us-ascii?Q?hiIbsAjzbmd0MZffEtheHFYySYSgyND2aqnMMJU/RXnRhTsYgNHgVFjlbmJV?=
 =?us-ascii?Q?xflLWK67fb5Lc5ufKAC+6H7s37Y1WFvBxMT/JOEzGwUnyp2591jdiLyYBwRN?=
 =?us-ascii?Q?veZajhUm061g8jyGUWV4kVtUmqsF/cR/6NeNjDWkbup55jVtT+ClJ/9FaYia?=
 =?us-ascii?Q?SzQdgg4tWZ8VfQ0LUvgi7foqn4XaNjZ5flenafmgvUm/41eBd8ECHv4Usoxi?=
 =?us-ascii?Q?2KVIIcKSKvi1QQbw2rY+U2fRjLlSpjEBzNWmcpmY/oqHjEkh606Vc5L/I7/j?=
 =?us-ascii?Q?FWp8Qzm+eovDtPGgVLelQAGePETm91ulbMsyKXaWQGMcSlAoe5eB4ksHBwGt?=
 =?us-ascii?Q?Nbch0ickIqQb//JbyBo0d57yNKf3Tgdd5YX27HPZcVE3gM+I1tRd6RiuR7zj?=
 =?us-ascii?Q?AreztWv/l3f3QFT/RtYw9HlMF0F89jQdffg+Iu29fK5cE1KqS1KmvRcXBuIy?=
 =?us-ascii?Q?t9UeOahRJ8/7HIbf3DicL2RjqsdcAEAIKwY+tAbXdgtgpxqQOHj5LLeeDUHS?=
 =?us-ascii?Q?SMksq99bw3aqg1ftjeb3WI4bfkxnCFvtQpPgjBRBkyUhNh4jMQfuXCUGIx6I?=
 =?us-ascii?Q?53vLlG60GotEhrFQ47ojGJlasA15AX1ZX1xak11/4XVo6X/6fPDzilqaKWuK?=
 =?us-ascii?Q?IwoY83Jg3Nltpd+fZ654zf2muJzd/RuRV6WMF65ogN+LVJooFR0LXmGfJtg8?=
 =?us-ascii?Q?eVp4rE7qWiNi4l81SZViekjNfSYGmUeUVANNR9XwPggJtl/KvC3HvZpucVki?=
 =?us-ascii?Q?8pCCxX7QkHySs0GAUDOvj5L0+LD4vIGPs4vQga9RvBv4X1x4lrJv39GOBM1K?=
 =?us-ascii?Q?uBnYstf7Z0XV1C69vvgfEpeJHeA0U+nKCPrADjC6/DORvg3qBn9+QuRHnkNi?=
 =?us-ascii?Q?h4qaN+amOY84HgWHehi2ct9a/QOqO+bJ/N7vNcEneZAo8na+b+n4uFHzOlyU?=
 =?us-ascii?Q?1nUQN+6oxjC+kzFN/i5YBN3OcvHSB7QT0ZTmPB4k1I6e0Cn8wWQBLt5WOGGk?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tVdRUUYctiCmZBDmO3tWUNS0Nl1sStrNAjxTeMtDiZc9Co5egbIRRFZrDKrdjksa/HGBgJUPafJ6e6TIW6FwBXD9vhmhg9+Nlj8yif/VEncPrBEcrHRXMdGPfL3dEoc6pTvVlSQmg5DHlotniUkOwWlvdN4Cnse00SBbpyNZYZ1n8F+wKyk6GrtSs5X3TJFzQIhOSUime8FG2Wq1JBBBBA0U1UIqPifJ47S6ybGzwCh+FeUPI5S0Z6Qkr1X4A/EigdZLKWXF8/zYoN4I5qx1zaVUfuLuqQGFU56e9qLh/3TihKGCzQLK90/LTRERnhBGMCZRMlP4IQX0y3tJpY/FG4jH/sxVW81eryHx2OrQrkim3gyYIB4PSdCDOFeTIl/XDKPtQP4XmlVn/AEFuZtC47P+6f4TX/QE9SuKlQbDyLzmjMkuUM8szhesSnIebWwiY+APocNT07jq93tjJD7ZuDqsQjOS+HqcusLsdJzh3Agm/3n1afwd8zrtUZU5UQwmL4JAzFza0Rvb15X02E3npUFr8sLsFbduDmCs6UBQ1xoaqaMBvEqg0s3wH67aCsUoX19mZX/NWF5QUK55I+9wmmvuLr6pADULpWXPmbaYHXY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ba3071-7499-4102-8fdf-08dbfb02c7f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:16.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9j/zpVBTxma448A9oMFeeFtvF8HH22MshB7JXohBydR8l2FHoIBAB955phxe3PuYAw0083n2cA1geQctxyB0GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-ORIG-GUID: wzi5k8_Qxv2KsbVo_jiven9vdYVAETww
X-Proofpoint-GUID: wzi5k8_Qxv2KsbVo_jiven9vdYVAETww

We rely the block layer always being able to send a bio of size
atomic_write_unit_max without being required to split it due to request
queue or other bio limits.

A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors on the
relevant submission paths for atomic writes and each vector contains at
least a PAGE_SIZE of data, apart from the first vector.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d151be394c98..dd699580fccd 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -213,6 +213,26 @@ void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_atomic_write_boundary_bytes);
 
+
+/*
+ * Returns max guaranteed sectors which we can fit in a bio. For convenience of
+ * users, rounddown_pow_of_two() the return value.
+ *
+ * We always assume that we can fit in at least PAGE_SIZE in a segment.
+ */
+static unsigned int blk_queue_max_guaranteed_bio_sectors(
+					struct queue_limits *limits)
+{
+	unsigned int max_segments = min_t(unsigned int, BIO_MAX_VECS,
+					  limits->max_segments);
+
+	if (max_segments < 2)
+		return 0;
+
+	/* subtract 2 to assume PAGE-misaligned IOV start address */
+	return rounddown_pow_of_two((max_segments - 1) * PAGE_SECTORS);
+}
+
 /**
  * blk_queue_atomic_write_unit_min_sectors - smallest unit that can be written
  * atomically to the device.
@@ -223,8 +243,10 @@ void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
 					     unsigned int sectors)
 {
 	struct queue_limits *limits = &q->limits;
+	unsigned int guaranteed_sectors =
+		blk_queue_max_guaranteed_bio_sectors(limits);
 
-	limits->atomic_write_unit_min_sectors = sectors;
+	limits->atomic_write_unit_min_sectors = min(guaranteed_sectors, sectors);
 }
 EXPORT_SYMBOL(blk_queue_atomic_write_unit_min_sectors);
 
@@ -238,8 +260,10 @@ void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
 					     unsigned int sectors)
 {
 	struct queue_limits *limits = &q->limits;
+	unsigned int guaranteed_sectors =
+		blk_queue_max_guaranteed_bio_sectors(limits);
 
-	limits->atomic_write_unit_max_sectors = sectors;
+	limits->atomic_write_unit_max_sectors = min(guaranteed_sectors, sectors);
 }
 EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);
 
-- 
2.35.3


