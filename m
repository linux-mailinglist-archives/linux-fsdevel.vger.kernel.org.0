Return-Path: <linux-fsdevel+bounces-22973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84B79247D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 21:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A621C21338
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E785298;
	Tue,  2 Jul 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="dIZiZD0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9391EB25
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947147; cv=fail; b=dyJqbeUtp0pc2Hvm4XoDPeZ8DIhr//+ZxqGCG6EhIp+0GkiXHLiRdWGbDEnd6+ioEKy71C+t3h80usZWwf55/2VWEtHwC0jDv2DclfTS76Zj1m61Qwq975flWuBLeX0z7NLjpolCvynQKH6JqEpCaalRa0fUCUxC8zji3VF3Yy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947147; c=relaxed/simple;
	bh=j8IRxoV8rEZHsF1fTMQRr0cNZ+414kydQiZ+nsz0jnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=J9ZPHt6/DIYuU03/xI9Yg8Kt8oeEO4o4aGyyumAhR5rEWrEBb2DHMUXKu4+iUqROvAcCzv5klrH83ptyrTcY0ATknVBxTCueRWTElmia9M5Tn+m/L0a8YDFhJBh7mKHBRqUPIKjHMzQaIzAEaNdZi5/YJtYpBcDf3nVtn+rhIdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=dIZiZD0f; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by mx-outbound15-59.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 02 Jul 2024 19:05:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A12nlJyk2RkQbGlwoRdeRdmo8GlnhoZiBKQFYiGhnTcWNBNUCuAVJjbVRApwAhWJai/xZ8ZBo66XM6tBb6478H/58Bmm24Vgej6IN0Ys7k3n/3g/k/fJPNUmqiL3sR96RJz70nTiGsaiLNJoc3RdmjMIgZzu+mGTpQdtfZkhmwRCPW+B1rqYo7GStjYUdAAIOgq2dYbOKeiFy2NMri5ff/oXhQ6K1L1j9P9Vz0VC4OKP5wx3fprQv5cYwPJeYrO9Jd8EsKvi5AJqldFeORkcPCuJ2kjY/Z8E0PN+qd4HQ4OMN5cdBg+bP9/BMJKOKcO9fsp/KkC9uBWsLO//tewXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ef9+gpE4KISur++gbCWiG8GQQIzq/TH6uHhw0Uzaio=;
 b=GBjdNBj2QzhiGZ6J3HlxJIOe8qx0O62PrccC4pOCS/akVLVHYZWMGTNNGnsHhk4SPVgzWecc6L1s1qRQYLz2PxWQbQwMQ9n4vdEaiqRkQgU/hb/Aq5IEgMURXT/31iQglaTRzJ2FGYapFDbiKUlM7a90kr4p+RD/VW8KWA6h5aoUPiTRJjn1yxaXesqzZ1rkvLtX/gItjIq3m6EiJK3XoChjLQcWFU63lQiNujEej9ii3ust/mvUhTLa/eTeqz5mU/pcIU47BOG7CP7SgHM8xkiBxDwvMtB/EzFYQLj8Z97UWT7j4gpXitn1wi31Egaf4Umw6xLJIAqPC99Y5QhK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ef9+gpE4KISur++gbCWiG8GQQIzq/TH6uHhw0Uzaio=;
 b=dIZiZD0fzylVncKXvU0Bm/LQ7EVmCFmVLpJc7++QitxjhBgagMm1QOyC4wrWhgKMsiGCVw6hmiDwXhndWCOMqwxvtdk9OZjAJgKF2bdioxTJSreoZX6xBIja41r7YJqxN3XOFG3neoX/zaAki8Lz3fhNW68YjSPwDezMGh5gPhA=
Received: from SJ0PR03CA0158.namprd03.prod.outlook.com (2603:10b6:a03:338::13)
 by DM4PR19MB5955.namprd19.prod.outlook.com (2603:10b6:8:6b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 16:31:22 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::66) by SJ0PR03CA0158.outlook.office365.com
 (2603:10b6:a03:338::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Tue, 2 Jul 2024 16:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7741.18
 via Frontend Transport; Tue, 2 Jul 2024 16:31:22 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 882BA27;
	Tue,  2 Jul 2024 16:31:21 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH] fuse: Allow to align reads/writes
Date: Tue,  2 Jul 2024 18:31:08 +0200
Message-Id: <20240702163108.616342-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|DM4PR19MB5955:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6777ef3b-7f57-4406-6e9b-08dc9ab468fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvu5HPc+bEn2TtOl4ZsS0orqUg6CN68M+Ualcz0lwth2p8gUpdv9vs2XqOJl?=
 =?us-ascii?Q?5tUOCdA8x3X5KYvJX0hXG93G+7MQIzW7C5wrB7VhOtWm+dt24HeaPDbsPj6T?=
 =?us-ascii?Q?ArVEs/xsldBcEMMgkWWyT26RiN6vUjKWCreDMitbWFlIWe1xIkbIdm0FusmK?=
 =?us-ascii?Q?8IPyvlSI69QOq20DqG6hL9nz5S2HgwerqeJie8op5fLLdzp83EnkdcbS6h/B?=
 =?us-ascii?Q?IW9fHUfV/ubi0r9Ds5u4AqQY7Mfu0RjsKHpOpnF6AG0+VayIGBoJU3sOCA33?=
 =?us-ascii?Q?VizVx2mQ/elRCg91KoJ4ty6bw3pTBYynvwQ+P13YMhW2UaClycfTkMMb5dHs?=
 =?us-ascii?Q?loU6AFSEcv16ou+pmW95cF6W5gRzmDXg+2KMn0rW3apRjTTFeZb7il8s8GDa?=
 =?us-ascii?Q?Sigtw/m2su8HdMCuTMyK2CYEHlt3vQTxEnCU+840LbUFXhZka0OQPMQVEJzn?=
 =?us-ascii?Q?l6zrmsOBuK7fRdM6q0r4DAlNW9eLWEhWIyiephe6ZcWRNeLFgrL3L4tyRHzB?=
 =?us-ascii?Q?nmPRn+szJ1q0uNYhvrhfPLW+d/jmKzuyl0wP+4cyocRuyS0P5ol26oKGATUR?=
 =?us-ascii?Q?9ZVofHM98PTdidYhwjW6Eo4eiKV2QEcn4QKZscKIjx+A6gAam1MSSsHaf6Zv?=
 =?us-ascii?Q?w/WEtHBSkcC2f5zUh60c7hDwUfqiP94opkSH+DBpcA+G0SbGPJYxxtrDvADv?=
 =?us-ascii?Q?MmmINRkIe1Fn+rmYBMxMrMF3PEzEegOKReL1xHFRraZxF052Er6TZN2fNkm6?=
 =?us-ascii?Q?a//a/TNeH18qjHwgIv0X7eipQmYAIEeDhkAz0EScLINDKqpe8HWmDAoCR4cM?=
 =?us-ascii?Q?PYfAieIETPVaMyhwRMHO7kHkwagh6lwUVDXP5XhpUus9bxC78PwFGBKufCAn?=
 =?us-ascii?Q?24pwnJF26yGBB4Wlq8nK108QHUx/a7DqGZ/XCFT9yN2I+pm5OH0RXlPuEBQ/?=
 =?us-ascii?Q?sjrJknBYhiWsJrl2+K87rHSlhJKsdNkRb7feZxBE8J7aOHNmxe9nIeZNSmQH?=
 =?us-ascii?Q?pQ2ZuoaKGmOJzTNDfXDV7t1St3SDH9ALuWcbimVNZ3Yoo3GRow7aW6La4oj+?=
 =?us-ascii?Q?KLGHSqhrjqF5EvJSPBZBVClldThatVHFVpSaOhDYlxhKpjyJyC2oHZGJdd7F?=
 =?us-ascii?Q?torfdXPAqrP9WD2sAv7gaaKFH1lMbTqbK8wQp4oIdbpSfn2VABCwm4Ke5P+U?=
 =?us-ascii?Q?2r4swFZKGUJthGGO5T6zuA/mcdca9LODyu9r6c5y24tA3CF6HXhffHxhHgBE?=
 =?us-ascii?Q?RjiEZgOX7kOj3bi7afMhd5SuUTZPSYeHPKnvUxPPDGthw+maSQQHSp+S9pq8?=
 =?us-ascii?Q?fKxzCzu/T7IGWhli4zwV3wSj34wXwI8aUqiDpRve9rSijnyEn+7HBQrlui6X?=
 =?us-ascii?Q?90YuUcg06N0hIB2q0p9+3VR56MCVCyr7gNNGNnoL2GglJkPG3OQw6k+lAxi+?=
 =?us-ascii?Q?lBojKczlsTSEt1dU0Eczyt6gypbozQmc?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gTuiq9W6/2FmYaCm7UsmgAWkkaMoqdf3eMvG1v6gTItz5nmVHe2APrUPuctVOCC3Zjr9k/SbyVWfpyM0CmFEzusHfJcOR3WN+cAtpNJXGdF7OQQ9Jb2+WcqDImNgVLFabWnzJ/YL1ggHdiMTQL33CnBJWlMXBXJbhFkCdI5Gsk+Ol8X4O+jnxQ4Q753fVheXaDlRHhq3P0UcxFkzP29SQ7qOZYcjGXyDTcZadT6mxp5JTnWfTUZxGw73NC7meTLPxsgfGq+H0vnW618K1Y4n6TcsrKWZ9NwCo+RBIfPYjxntkVRIV4NfZz7c7Us+ZkrZsFwzPYJwmqg280/d8cr9X/mIrPlzmI1gbbbe0GMEmJfzlnscIdbYQR4LarixGQS7WY1bnwO7ZInIt1R/osT6/dhwMcnLK5+Vk7XnHyF7GtcqP0pAWMFoAUP46eM0znldBqG/TTuQobQ1pb9LiCgErNsRSAds25hISJOWUsd3b+fsNFlcdy7GGihtLeJ7TWu+666wPtwHVgwidUW8/3RTJZ+yfbFebWfaHyyad21c8s/6bq0rL11NPwMxMV8W/VCf5TcEGx05wIlM9tCRfW52mcTPIbUnzTNY63lR+xS1Xumf+4yLzQTUeoobA94gW8tj58CPd7/2ndaqnEsf+P7jcQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 16:31:22.4707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6777ef3b-7f57-4406-6e9b-08dc9ab468fa
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5955
X-OriginatorOrg: ddn.com
X-BESS-ID: 1719947143-103899-3942-11940-1
X-BESS-VER: 2019.1_20240620.2317
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYmBpZAVgZQ0DLJItnY1NTQKN
	ko1TDZOC3NMjHR0NLc0NDcOC0lydhCqTYWAPYO45tBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.257352 [from 
	cloudscan14-93.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Read/writes IOs should be page aligned as fuse server
might need to copy data to another buffer otherwise in
order to fulfill network or device storage requirements.

Simple reproducer is with libfuse, example/passthrough*
and opening a file with O_DIRECT - without this change
writing to that file failed with -EINVAL if the underlying
file system was using ext4 (for passthrough_hp the
'passthrough' feature has to be disabled).

Given this needs server side changes as new feature flag is
introduced.

Disadvantage of aligned writes is that server side needs
needs another splice syscall (when splice is used) to seek
over the unaligned area - i.e. syscall and memory copy overhead.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>

---
From implementation point of view 'struct fuse_in_arg' /
'struct fuse_arg' gets another parameter 'align_size', which has to
be set by fuse_write_args_fill. For all other fuse operations this
parameter has to be 0, which is guranteed by the existing
initialization via FUSE_ARGS and C99 style
initialization { .size = 0, .value = NULL }, i.e. other members are
zero.
Another choice would have been to extend fuse_write_in to
PAGE_SIZE - sizeof(fuse_in_header), but then would be an
arch/PAGE_SIZE depending struct size and would also require
lots of stack usage.
---
 fs/fuse/dev.c             | 21 +++++++++++++++++++--
 fs/fuse/file.c            | 12 ++++++++++++
 fs/fuse/fuse_i.h          |  9 +++++++--
 fs/fuse/inode.c           |  5 ++++-
 include/uapi/linux/fuse.h | 13 +++++++++++--
 5 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..a13793507d0b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1009,6 +1009,20 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 	return 0;
 }
 
+static int fuse_copy_align(struct fuse_copy_state *cs, unsigned int align_size)
+{
+	/* Might happen if fuse-server does not use page aligned buffers */
+	if (cs->len < align_size) {
+		pr_info("Remaining cs->len (%u) too small for alignment (%u)\n",
+			cs->len, align_size);
+		return -EINVAL;
+	}
+	cs->len -= align_size;
+	cs->offset += align_size;
+
+	return 0;
+}
+
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
@@ -1019,10 +1033,13 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
-		if (i == numargs - 1 && argpages)
+		if (i == numargs - 1 && argpages) {
 			err = fuse_copy_pages(cs, arg->size, zeroing);
-		else
+		} else {
 			err = fuse_copy_one(cs, arg->value, arg->size);
+			if (!err && arg->align_size)
+				err = fuse_copy_align(cs, arg->align_size);
+		}
 	}
 	return err;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..0e1c540c6139 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1062,6 +1062,18 @@ static void fuse_write_args_fill(struct fuse_io_args *ia, struct fuse_file *ff,
 		args->in_args[0].size = FUSE_COMPAT_WRITE_IN_SIZE;
 	else
 		args->in_args[0].size = sizeof(ia->write.in);
+
+	if (ff->fm->fc->align_writes) {
+		/*
+		 * add an extra alignment offset after the fuse header to
+		 * the next page
+		 */
+		args->in_args[0].align_size = PAGE_SIZE -
+					      sizeof(struct fuse_in_header) -
+					      sizeof(ia->write.in);
+		ia->write.in.align_size = args->in_args[0].align_size;
+	}
+
 	args->in_args[0].value = &ia->write.in;
 	args->in_args[1].size = count;
 	args->out_numargs = 1;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..cb15153c6785 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -275,13 +275,15 @@ struct fuse_file {
 
 /** One input argument of a request */
 struct fuse_in_arg {
-	unsigned size;
+	unsigned int size;
+	unsigned int align_size;
 	const void *value;
 };
 
 /** One output argument of a request */
 struct fuse_arg {
-	unsigned size;
+	unsigned int size;
+	unsigned int align_size;
 	void *value;
 };
 
@@ -860,6 +862,9 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/** Should (write) data be page aligned? */
+	unsigned int align_writes:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..e8b42859f553 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1331,6 +1331,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+
+			if (flags & FUSE_ALIGN_WRITES)
+				fc->align_writes = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1378,7 +1381,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALIGN_WRITES;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..4f5ddd7fe9b4 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,11 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ * 7.41
+ *  - add FUSE_ALIGN_WRITES init flag
+ *  - make use of padding in struct fuse_write_in when
+ *    initialization agrees on aligned writes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -252,7 +257,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 40
+#define FUSE_KERNEL_MINOR_VERSION 41
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -421,6 +426,8 @@ struct fuse_file_lock {
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and the high bit
  *		    of the request ID indicates resend requests
+ * FUSE_ALIGN_WRITES: For opcode FUSE_WRITE,  data follow the headers with a
+ *		      page aligned offset
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -463,6 +470,7 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH	(1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
 #define FUSE_HAS_RESEND		(1ULL << 39)
+#define FUSE_ALIGN_WRITES	(1ULL << 40)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
@@ -496,6 +504,7 @@ struct fuse_file_lock {
  * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
  * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
  * FUSE_WRITE_KILL_SUIDGID: kill suid and sgid bits
+ * FUSE_WRITE_ALIGNED: Data are at an page size aligned offset
  */
 #define FUSE_WRITE_CACHE	(1 << 0)
 #define FUSE_WRITE_LOCKOWNER	(1 << 1)
@@ -812,7 +821,7 @@ struct fuse_write_in {
 	uint32_t	write_flags;
 	uint64_t	lock_owner;
 	uint32_t	flags;
-	uint32_t	padding;
+	uint32_t	align_size; /* extra alignment offset to the next page */
 };
 
 struct fuse_write_out {
-- 
2.43.0


