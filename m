Return-Path: <linux-fsdevel+bounces-24905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B8194661E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 01:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496EF1F22292
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 23:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F7C13A412;
	Fri,  2 Aug 2024 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="jaRztRFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106D47A64
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641155; cv=fail; b=YuQqQeEOSZloS+3SeSFUwauO6hQURg60pCxCGRqq3yNCsXKWbNaDy0fEzoaL1ueFpg0YhA2eKt7fS8Q33upkY87wT7sf2z2snyEtiO/jfTO4XcPIljAHEkVgrrs+mV/GJWZ/0gpNB04M/y8WsXNlXHFG17GnBxFZBzL9HkN7crw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641155; c=relaxed/simple;
	bh=UqAnG1j3AFzKVM1URXSTfOe4NEBxtYTaYNbCfjtkFn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mu/enJbBw5VVKhgDUr0rfhK+yAH29bPLutzbpdkOgVo/FAFDTxsrmMZ1oOtYMaSZD2QIhfo7up0tkasNsX89ZthbY5vKYm3TLTQhPmiimH5Qn0V7UISQwOK+ssM69LwkrPRHDQU7CTi5qwOD6Yf9H5eigYx/5P5o857vhrHfBfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=jaRztRFz; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40]) by mx-outbound13-97.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 02 Aug 2024 23:25:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pt2iTTRqR1NlbRtH26ym8Hyo869qqCLMxWatq1BlWVRAHEyRYsYUDRoxQxmf/Q8VDVBxHHoZoOVlryDvbnCupUp7b211isdeYOctmCr28jDnr6B6zA+rSvE94+WuQ81WU720kNwBkExe4Gt6M3dlrDE/WX+rvPI+9qkodqv1EXSX6g5XHb5Bfs6n77QI44/l+wpYO0Zf5ruHxyZyNxKvOFIxwivF7IluNou8l0THnLvOyimjGYIZ8dB2Tbxo7pmcexWUxmjSQLCZCmbEYshRmT3fQBmPF9ekfAfUXgJ7SQU3vDZuyuYr8225jhTCk3fkTl94F2pr+83wEaQ5tK0EGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysgLjCoghmbMQtJs4SP3BgXVcBUdbT9SDKgokQo9AsQ=;
 b=e/ex4ntuAkq50LlN43kSo9Ehdfh9nm+SKYe8Lc/v/Cy66ucN51Z76EaaaxS642MBGjzu4vOLcrkkfSo+9gjcdQE8BGcw85e11qHM5JF+ShxVQjAGAe2wP7hKGXtca6XKE83X90M+xqIy9YigDT16gfgVaDFaJPklupRaWpoK8xBvHNTWOq8Kt9mC/ZcCMjLn7Wzm0JCfkseQthuTSINYmX4QO4ptxoDgzXxewEtv6HosqoOqrKi2OLEU6Um4w+YZjJdNC6Lh7HQO8+urf1cp1dbbN05wNzvdRqg7FlDEi642SMPxH+93YfPM5yCO1msVNJPc9bHJlLBYbOIEhmH+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysgLjCoghmbMQtJs4SP3BgXVcBUdbT9SDKgokQo9AsQ=;
 b=jaRztRFzBN7JIin/toHH4p20m5fdCq+JHeOHsY876WYQw0izQlCrKD6QvEKuIuMWgREgtOEnM0mVyfVKFXWfgJlNEy9QzagBq0QRvvZnviDT8wjbd+WjHFZgvQ00525U8W8WwxM3HIMg0dAJ8ZxU64YcWQNTWKpS9Z1BhoMz9s8=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by PH8PR19MB7757.namprd19.prod.outlook.com (2603:10b6:510:259::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Fri, 2 Aug
 2024 21:52:30 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::24) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Fri, 2 Aug 2024 21:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7828.19 via
 Frontend Transport; Fri, 2 Aug 2024 21:52:28 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 19FC113;
	Fri,  2 Aug 2024 21:52:27 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	josef@toxicpanda.com,
	joannelkoong@gmail.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2] fuse: Allow page aligned writes
Date: Fri,  2 Aug 2024 23:52:00 +0200
Message-ID: <20240802215200.2842855-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH8PR19MB7757:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: afc10260-be02-4e2e-c207-08dcb33d6773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?9FW3SMhix8iscR+7Lz/Xda9je3Bx8GlvSSQJ6O/W2v4Xj4deGnKuWGRCO+YD?=
 =?us-ascii?Q?sk3UDccmf/F81VsQWCeJXxVQhiOOTZp+mHJJkUePViCQlARKUV8DyC+iRadL?=
 =?us-ascii?Q?UAxYW0e+YoyzYUThFDtl2DcFNPDhW34oW5dBh2F3P7OhIzc94NXk8dFWHwom?=
 =?us-ascii?Q?EHXM8MFdxK1INkFnyqcNz/D5269gWRVY3BdH/xGx75LkMfb0R5qieusBw0qj?=
 =?us-ascii?Q?jTCmIekooX2jc0c9oLWgqoZypwM5gMJQlaJECl4AsmYFjZ39jt8Nf1orX/fP?=
 =?us-ascii?Q?zdqDlw8IEclR33HU3tOXTHoluznvKsisXXGKs7YMKqCTN45I8Eldx8cZisDf?=
 =?us-ascii?Q?wA4xTyP7ixPvVoQ8jN9uNqcGAJJHIXlbdSEJAApBoH1lSBUwjcKwpICnFBvi?=
 =?us-ascii?Q?bgCn80rY7vKk+sYt966gPFr3po06yt2sexPwvJmUcR+Z5pTIltc5R98gfm5v?=
 =?us-ascii?Q?NUFRBGo4BQy3/chyrvCthfs022YWa5ojvzK43cQ4uxx6+c8ibIsi6HiRSt5/?=
 =?us-ascii?Q?zGuo/Zfs7vGW0vWdLbfSnac6lg73jrYwkYLp6xCXTWBVL/gf/tWaQq4q1dDt?=
 =?us-ascii?Q?PCC6gGiX/nU5Og9bwlkfD8lWWnPE+CywhsqT0T+nz69nU/FcvK414KLyQmoZ?=
 =?us-ascii?Q?cWcEIqSjTr7Xrab9ECC1PsxO1Ux4S/DO12bakRtAKBT1zv6xHq15B8X73h6b?=
 =?us-ascii?Q?yogcZxUdNv1nP+f+YK70h8UzX/XTOn93MIg9R3TDZcAe5+/0GdA3Ln1Dzp38?=
 =?us-ascii?Q?IphIYB+kTqjH+KpANGcPC87l7fqifEy3E9Jx920Fc8bYmYdxieeShHz3sPJr?=
 =?us-ascii?Q?UI/X2f0trjgoXggCiRKmVoZou+2uJYsbZ/0OHdAVOPEgJNz4gHYODMGd94B4?=
 =?us-ascii?Q?/Yj/lyEOPKPtFJelBqNl9bV5Th4AAu50DxsmgPS3fq3BUtT1lMY2TNl85H83?=
 =?us-ascii?Q?IFf3C4H0t56OrqFkMqzTK8Lo7ZMcSQBwHzXC4JjFpTRlLwSKxAgiACUq2kJv?=
 =?us-ascii?Q?0fpdg7nmh7pECByadCGzufo4MbrB5Jz1ZYOb/8jiYlI+1PPSHHY3bjj77lPo?=
 =?us-ascii?Q?MuGCZ2BKX9brR5Eh1X1WCfwhD90Pu+nSQfR2+t4MCzc40xlLKrTFR5L82h97?=
 =?us-ascii?Q?krjU2xgT3n4kknnWa5X7uwLer6/+howBsQ94ksVzBr5LifH5WbFw31M0h8Ag?=
 =?us-ascii?Q?lc+RS2Moca8vtjvUmbaO7Ik1ATx9A25BCiZH2Q/VJZglMr/BCTdlV/GoK1vK?=
 =?us-ascii?Q?IlxK9GhL/KTNoXQ0u+FMvJgEUXSWZ36ZzcEV7nSu3lSBO2LQGQ8Wy/63V0uK?=
 =?us-ascii?Q?Yu3TVjbCuzzALG6ckHsWtG3e4bo8KkR+lQJ62Qc64Us8b94wK2sjsytGdw2g?=
 =?us-ascii?Q?nGzFTTXhAdO/hlOOWMKrRUKs1Ll/?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 bKYDiqXZWANwqUs08OiXlzf7qbb+PQ1uG+Kwg68x/cVJxIGamjLNyperSoxevjPpijueOMdHqlAt0hu7Mw7blj4ggtC1VegR+JP/vAHwzYiNQRxinRIW2ll1e9400FZLrZs3ZPHOgiOQ8eMaA5qVFhlij/ZltooajGGdQXY24a6WK3jtAyvtGEEjbmRuy4+AwAWWp5Ttuj07xiWpu3loxF1t4/O9fRPDUlY6G3T2uULOmQ3GQwyt2SaD5NN1dkDHqUaml1RKEsm7nMAmZaflTt26H02UORkXDncqam+ArAjRDraUXKuETI+ANQxRd+DTMfwnQaUFtkZTtKQDXD21ESbH6iNTbh8rO97VYgxof4GAjeIaRcwQgf2xSHkJXrxSKBDi/BWo1i7UE3C5YoVgwMd/oU/nGRG4YP0ueDv7gWrYMPJ3ZZpdRLS1scSypowXc6T5rzOWmMHt3Oshyi/AIzxG+AXlb8pZya7ot9IFMuM7fo7L/MtP+/xZoLl/hFWaXObN959tfQA6xxVSNDtkJJ5gjNLSCvdA11F+hFkoBZ4DNmHgWh/uTCX663fGrU0QMlfGmzV1QNRBKZXxs9Xc2wXnbUVTdPVfGTuyZe28UvoTPE25I0/XNRvK2PRcWCSPMsOMllKmKrzfXon3/iujKA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 21:52:28.8690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc10260-be02-4e2e-c207-08dcb33d6773
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7757
X-OriginatorOrg: ddn.com
X-BESS-ID: 1722641151-103425-12642-28534-1
X-BESS-VER: 2019.1_20240801.2148
X-BESS-Apparent-Source-IP: 104.47.55.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbmBkZAVgZQ0CLNONXY2DDFwM
	TIxMg00TLFLNEsxTDV1DzRxMzMMMlcqTYWAFoljzBBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.258065 [from 
	cloudscan21-220.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Read/writes IOs should be page aligned as fuse server
might need to copy data to another buffer otherwise in
order to fulfill network or device storage requirements.

Simple reproducer is with libfuse, example/passthrough*
and opening a file with O_DIRECT - without this change
writing to that file failed with -EINVAL if the underlying
file system was requiring alignment.

Required server side changes:
Server needs to seek to the next page, without splice that is
just page size buffer alignment, with splice another splice
syscall is needed to seek over the unaligned area.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>

---

Changes since v1:
- Fuse client does not send the alignment offset anymore in the write
  header.
- Use FOPEN_ALIGNED_WRITES to be filled in by FUSE_OPEN and FUSE_CREATE
  instead of a FUSE_INIT flag to allow control per file and to safe
  init flags.
- Instead of seeking a fixed offset, fuse_copy_align() just seeks to the
  next page.
- Added sanity checks in fuse_copy_align().

libfuse patch:
https://github.com/libfuse/libfuse/pull/983

From implmentation point of view it is debatable if request type
parsing should be done in fuse_copy_args() or if alignment
should be stored in struct fuse_arg / fuse_in_arg.
---
 fs/fuse/dev.c             | 25 +++++++++++++++++++++++--
 fs/fuse/file.c            |  6 ++++++
 fs/fuse/fuse_i.h          |  6 ++++--
 include/uapi/linux/fuse.h |  9 ++++++++-
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..e0db408db90f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1009,6 +1009,24 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 	return 0;
 }
 
+/* Align to the next page */
+static int fuse_copy_align(struct fuse_copy_state *cs)
+{
+	if (WARN_ON(!cs->write))
+		return -EIO;
+
+	if (WARN_ON(cs->move_pages))
+		return -EIO;
+
+	if (WARN_ON(cs->len == PAGE_SIZE || cs->offset == 0))
+		return -EIO;
+
+	/* Seek to the next page */
+	cs->offset += cs->len;
+	cs->len = 0;
+	return 0;
+}
+
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
@@ -1019,10 +1037,13 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
-		if (i == numargs - 1 && argpages)
+		if (i == numargs - 1 && argpages) {
 			err = fuse_copy_pages(cs, arg->size, zeroing);
-		else
+		} else {
 			err = fuse_copy_one(cs, arg->value, arg->size);
+			if (!err && arg->align)
+				err = fuse_copy_align(cs);
+		}
 	}
 	return err;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..931e7324137f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1062,6 +1062,12 @@ static void fuse_write_args_fill(struct fuse_io_args *ia, struct fuse_file *ff,
 		args->in_args[0].size = FUSE_COMPAT_WRITE_IN_SIZE;
 	else
 		args->in_args[0].size = sizeof(ia->write.in);
+
+	if (ff->open_flags & FOPEN_ALIGNED_WRITES) {
+		args->in_args[0].align = 1;
+		ia->write.in.write_flags |= FUSE_WRITE_ALIGNED;
+	}
+
 	args->in_args[0].value = &ia->write.in;
 	args->in_args[1].size = count;
 	args->out_numargs = 1;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..1600bd7b1d0d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -275,13 +275,15 @@ struct fuse_file {
 
 /** One input argument of a request */
 struct fuse_in_arg {
-	unsigned size;
+	unsigned int size;
+	unsigned int align:1;
 	const void *value;
 };
 
 /** One output argument of a request */
 struct fuse_arg {
-	unsigned size;
+	unsigned int size;
+	unsigned int align:1;
 	void *value;
 };
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..742262c7c1eb 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,9 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ * 7.41
+ *  - add FOPEN_ALIGNED_WRITES open flag and FUSE_WRITE_ALIGNED write flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -252,7 +255,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 40
+#define FUSE_KERNEL_MINOR_VERSION 41
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -360,6 +363,7 @@ struct fuse_file_lock {
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
+ * FOPEN_ALIGNED_WRITES: Page align write io data
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -369,6 +373,7 @@ struct fuse_file_lock {
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 #define FOPEN_PASSTHROUGH	(1 << 7)
+#define FOPEN_ALIGNED_WRITES	(1 << 8)
 
 /**
  * INIT request/reply flags
@@ -496,10 +501,12 @@ struct fuse_file_lock {
  * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
  * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
  * FUSE_WRITE_KILL_SUIDGID: kill suid and sgid bits
+ * FUSE_WRITE_ALIGNED: Write io data are page aligned
  */
 #define FUSE_WRITE_CACHE	(1 << 0)
 #define FUSE_WRITE_LOCKOWNER	(1 << 1)
 #define FUSE_WRITE_KILL_SUIDGID (1 << 2)
+#define FUSE_WRITE_ALIGNED      (1 << 3)
 
 /* Obsolete alias; this flag implies killing suid/sgid only. */
 #define FUSE_WRITE_KILL_PRIV	FUSE_WRITE_KILL_SUIDGID
-- 
2.43.0


