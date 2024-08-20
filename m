Return-Path: <linux-fsdevel+bounces-26405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD80958FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 23:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E3A1C20ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC781C57A6;
	Tue, 20 Aug 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="s6Y/bTwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B714B097
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190720; cv=fail; b=hcj6TRYWv31KbEweH8z47ekoBvSN43Dk1DFWLg6Ydz8jExQhNYC2bLZSIsO6Sk5fofVqDFWWFjm6dA89QMd/nXabd0NeeqY8Aqu2vaJRudA7Suw5C/ayFGVqV/6Cy/ZPA77RKHWo8smLwXvUFteAPs+3nqzAvbv1lXnAxTBRxjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190720; c=relaxed/simple;
	bh=j4R4d7Kmrd2nXZwiou43a0UijQ/RoVbfy1UltUG5TfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ILQ0+I1At7idxvrnWMu0d3q5kmZVjxLuroYR1JruMEHF8DKFcR0l5MFIhc2wqPI38gqsoOQAFGHl/IJA1dSSbvLPMYfqfDyTdAYcRR6nu7aYOQ4vGOBSNIuAY66V8cKW5wFz3+thyArAlyBrD+mF57SiSLTvWkTsFygZST0hs4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=s6Y/bTwB; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176]) by mx-outbound45-34.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 20 Aug 2024 21:51:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3LRxFByl/EDC4g+xV2IAs7MdRKorxDo4tnNq1ZLWRjkVpu1zHATooKD2unH/j8YEP0lWTIa8JdiqL54Q+ROKvYw4hCULXrFXy2Ws5hKVZT7fhq+2C0PyM/uBv2DUVFCiYe5lztVF8Wy3jfGAtdTDvAd07Z2qrcDFtNI7EZs08Wr3jvR2ZPVcwwDiKUjRY+EO3rJj57nwdpbeXwp7AU7GZHQH7WQqssKYSQmFd1UbHY8cF2uKpolg/fsrTrtifGBrj6NujMRirnPef1kzobZmu9KR+sQYJ6AB78w6DwQU4IaxVKoZcqcGQgoijg2W2XhUx3R3FIMLUS4B76LcE3KCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXv3iqhcS2B81YOgMX94IEd8hv/UMF5GeY6Kw1LCpc4=;
 b=ki16+/Au9GWQt85HXQBjjFNUrTFmKjEMi0eTXasWHK5wkvPf5jDt6QP/AdK4fn8WTAUcRDO2jUquEmpqWNsm4dHqssxLKO512hyU82SThxpoxQPUsNTTdlr4J7b6f5MjlhiFXAF4ZLHS6tdnZXvDPy/9qcuy3Im2QSVu+X272/yr62YtRU0AA95FXvCnH5SqKM/NpVEAKofO598t8qDgT4neXT7tiTmhoNV5MTRAbHuHCXtGXT1lPlYnvANkH4hpLeWHVU6GIfQ7iEzmQz75i18kSxTapMt36nmdWhs4u8DvE6Pe47KqcectgAq2ucMcpbJTDOGZpbN6o+3NwWwQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXv3iqhcS2B81YOgMX94IEd8hv/UMF5GeY6Kw1LCpc4=;
 b=s6Y/bTwB70gT3T3LrYZNeri9hliI1eBd+t13FamCAWrLSeBtFtb68Kj4NNUUAsS3JwjTDdmDSCxqwnuLzZ5xoTPGZvPBMiUHUxYUMIEAoQ8LdcSf/jsrquIJ0wrtrO/9K4/G1sIeSMGZjBxblDe2waXUF972PuqWwDYCLfyC3Mk=
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 DM4PR19MB7953.namprd19.prod.outlook.com (2603:10b6:8:18a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 21:17:42 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::63) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Tue, 20 Aug 2024 21:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7897.11
 via Frontend Transport; Tue, 20 Aug 2024 21:17:42 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 09F73D2;
	Tue, 20 Aug 2024 21:17:40 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	josef@toxicpanda.com,
	joannelkoong@gmail.com,
	jefflexu@linux.alibaba.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH] fuse: Add open-gettr for fuse-file-open
Date: Tue, 20 Aug 2024 23:17:35 +0200
Message-ID: <20240820211735.2098951-1-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DM4PR19MB7953:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 924d20bf-98ad-432f-a67d-08dcc15d8718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pR/Al8sHZsKC45JppAykgrI5W5wbB8UPBzmytk2O1WC8wsy/Aqzmuw+YNETv?=
 =?us-ascii?Q?5OeLHouv4xvCSuVftzYUn8v1Vdj/pMyIuoZ6U0WphKORpiKM1I4NAYh0Wf2a?=
 =?us-ascii?Q?zvaX2flhhp077ljMhE8oJjW/GBGxONq7Wn+zLbvF5DAOkYwVQ+Y+pAlXLdAo?=
 =?us-ascii?Q?PXHOYu20q0q/nf3TXNercK3ReaGZmly16hGaxo7Wn1pZz4DnegHG+67KKNVa?=
 =?us-ascii?Q?TKlUBje3U2nSoAQ/eeFcW9KP9YKGg9j5fEUMXdbtU5OYRyYKBspmSF2YXcsJ?=
 =?us-ascii?Q?jnnBHQO+/rI9BSdMoFeM2kjXoGKt4eyEBslBvKHSnDYiwDbPf4KezycHyQJu?=
 =?us-ascii?Q?SoMCnqhxJmDByFexvCNva+vNisY4fNl/LzrVxJ4Pl4knCGDS62BBTKHgVJ+D?=
 =?us-ascii?Q?OSeWFQFqHKXVmfxF3jzBdFxrGVSJ1Xib7bZYhlcs9EqyMe6xc9A5BBtoIFg1?=
 =?us-ascii?Q?jKYqlC+sC2fuqDebbL9Al/KP/1Fujgxf9nE9s8lijuImPjPOmHUXkmU33E3H?=
 =?us-ascii?Q?iG43M/lahBbVwXQJaJ+G4N8lMZxRIFwP/3BFtBjU/VErLst0yDKEzREZw9GZ?=
 =?us-ascii?Q?hv0SP2LuoFKRx1zqDoseKiKm/FsMY807mZLGwSN+IsrIiXgiXwozVBmExZ44?=
 =?us-ascii?Q?vKp2/fGVz3QYQVauGJCXZKvTU0eT8G6s6KzpWKbWxFtxlNJfAzT9Vysq1EHs?=
 =?us-ascii?Q?F+uTJfiIGxO5BTPqCP3JwaLIg76QMttsUeul5PlI8rpFUD4qH6zOzrAbHvDA?=
 =?us-ascii?Q?AEuq428BnLkRrH4Le3VwC8d/O87gckTF/RDY/KoREZvcIzGp0wN/7JROH64U?=
 =?us-ascii?Q?tvTqhreXou+GDkVJlt+wjWWOdMMYDhMYuM9kOwmhocJNX0OXbB/72E9YZy61?=
 =?us-ascii?Q?7RP1XdKL1RP868Jx43mhJ5FgDIdOLn3r3hxDYCtpn7t6DU3ysan17a79brmm?=
 =?us-ascii?Q?jfcV3fGf+4qE9xL6j+cM6uCIpMKORp9DUN1+56/d+ONzuYu53LTMY/yWuXrx?=
 =?us-ascii?Q?18XWycjA02nQQJO5TwfMPms3cgHvpv+AgXniyROtZ+w4bhEsBD1yOIi/CR55?=
 =?us-ascii?Q?ycuovf5Y94unsWxDAJjk4aSbkzSO6YcT0znJR6lEOlMPEk8CSBU10qRnTPc7?=
 =?us-ascii?Q?IRCXQD0hjctj5aqBkZV5miRPB05eu9LyY0FHPlJGJ1WlEw5VVrqMkzVqQkAU?=
 =?us-ascii?Q?wNqAQmDYOunYsvd+QYYxjJeVamE1k8Rc/qUUTKkaVpRAEb3nBFjqOJKdr8dW?=
 =?us-ascii?Q?bPAb344T5Huy1D1bPsmM3ucX9kZrAGin8PmLZQNL4kiM8wFkYZdwLaeqVlny?=
 =?us-ascii?Q?03VsZWaj37XLCjmunQddRxly24LkncT6aVUmre58hndlEBojZ1nEdO3lsNlw?=
 =?us-ascii?Q?xBm3O7Z/NcnzEQ8dsurXgyu5r/+J?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PYXmK6j1TrzaAoyhdWZoKppgnFGmnae/vWDoTK3tJMlfg4uQTpYaunQ4rSDxS9MYCwKvylxsDEfXyCf/abeQdulRxpss9IsU2ouTxyp54pv5x6JFsb47S+odICYwFgu9j0IVL8tQTT9UfuTvorS3Rt+wgIR7OgMp3QA1qwmnE8fV8DM3XAVcF14wAR3RbXIujRobfiI8Cp/vqWSjpxBfPMvIhEUztwGFg5D4ty+o/XC84cGe7z8z0exccQC84vgjE2OawQqRTXBxs7dA9OM6Sih4hLxaBw9WTeI7XCOlRSV1P6mciq0bxecao7ymhD9Ago1WkJYkZx6uxuI7Ug2jf24yCGN+UncQtpkurVSc5FB6mc5z92TQKBXkPjletk5CY33Q8E2DY7zl6LHQMRFWsHtKve+OGFYO2c14bxAEupD15dxswGHX/BYtMtMO2ep5kPwC/2HGHAepxrRwG2dZeyhWZk90yTPtKNRxgvlUIhTNO2qA6cmEdu4wL2RY9xIHPGXT8tE8nH7BWE00g0TgxN3M0ywGxzUv/xUdqg9dYLJs0h3YzuwgybjW4A3J8B8AbOkl/+U4osUHBkzPqn12AI62oMRSwjwnrD3Ltffc6xA6ejw6NqPZrVey57Oulu1ciXJNWCH9UEVOh/Vd2a675g==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 21:17:42.1332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924d20bf-98ad-432f-a67d-08dcc15d8718
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7953
X-OriginatorOrg: ddn.com
X-BESS-ID: 1724190710-111554-5604-22533-1
X-BESS-VER: 2019.1_20240812.1719
X-BESS-Apparent-Source-IP: 104.47.73.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaWhpZAVgZQ0Nw4KTXZMCXFwi
	zVODU11dIiMdU4ydTYwNI8ycwyxdREqTYWAH0YFh9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.258480 [from 
	cloudscan8-174.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

This is to update attributes on open to achieve close-to-open
coherency even if an inode has a attribute cache timeout.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>

---
libfuse patch:
https://github.com/libfuse/libfuse/pull/1020
(FUSE_OPENDIR_GETATTR still missing at time of writing)

Note: This does not make use of existing atomic-open patches
as these are more complex than two new opcodes for open-getattr.

Note2: This is an alternative to Joannes patch that adds
FOPEN_FETCH_ATTR, which would need to kernel/userspace transitions
https://lore.kernel.org/all/20240813212149.1909627-1-joannelkoong@gmail.com/

Question for reviewers:
- Should this better use statx fields? Probably not needed for
  coherency?
- Should this introduce a new struct that contains
  struct fuse_open_out and struct fuse_attr_out, with
  additional padding between them to avoid incompat issues
  if either struct should be extended?
---
 fs/fuse/file.c            | 94 ++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |  7 +++
 fs/fuse/ioctl.c           |  2 +-
 include/uapi/linux/fuse.h |  5 +++
 4 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..d470e6a2b3d4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -51,6 +51,78 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 	return fuse_simple_request(fm, &args);
 }
 
+/*
+ * Open the file and update inode attributes
+ */
+static int fuse_file_open_getattr(struct fuse_mount *fm, u64 nodeid,
+				  struct inode *inode, unsigned int open_flags,
+				  int opcode,
+				  struct fuse_open_out *open_outargp)
+{
+	struct fuse_conn *fc = fm->fc;
+	u64 attr_version = fuse_get_attr_version(fc);
+	struct fuse_open_in inarg;
+	struct fuse_attr_out attr_outarg;
+	FUSE_ARGS(args);
+	int err;
+
+	/* convert the opcode from plain open to open-with-getattr */
+	if (opcode == FUSE_OPEN) {
+		if (fc->no_open_getattr)
+			return -ENOSYS;
+		opcode = FUSE_OPEN_GETATTR;
+	} else {
+		if (fc->no_opendir_getattr)
+			return -ENOSYS;
+		opcode = FUSE_OPENDIR_GETATTR;
+	}
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.flags = open_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
+	if (!fm->fc->atomic_o_trunc)
+		inarg.flags &= ~O_TRUNC;
+
+	if (fm->fc->handle_killpriv_v2 &&
+	    (inarg.flags & O_TRUNC) && !capable(CAP_FSETID)) {
+		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
+	}
+
+	args.opcode = opcode;
+	args.nodeid = nodeid;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 2;
+	args.out_args[0].size = sizeof(*open_outargp);
+	args.out_args[0].value = open_outargp;
+	args.out_args[1].size = sizeof(attr_outarg);
+	args.out_args[1].value = &attr_outarg;
+
+	err = fuse_simple_request(fm, &args);
+	if (err) {
+		if (err == -ENOSYS) {
+			if (opcode == FUSE_OPEN)
+				fc->no_open_getattr = 1;
+			else
+				fc->no_opendir_getattr = 1;
+		}
+		return err;
+	}
+
+	err = -EIO;
+	if (fuse_invalid_attr(&attr_outarg.attr) ||
+	    inode_wrong_type(inode, attr_outarg.attr.mode)) {
+		fuse_make_bad(inode);
+		return err;
+	}
+
+	fuse_change_attributes(inode, &attr_outarg.attr, NULL,
+			       ATTR_TIMEOUT(&attr_outarg), attr_version);
+
+	return 0;
+}
+
+
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
 {
 	struct fuse_file *ff;
@@ -123,7 +195,12 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 	}
 }
 
+/*
+ * @inode might be NULL, the caller indicates the attr updates are not
+ *        needed on open
+ */
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
+				 struct inode *inode,
 				 unsigned int open_flags, bool isdir)
 {
 	struct fuse_conn *fc = fm->fc;
@@ -143,7 +220,19 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 		struct fuse_open_out *outargp = &ff->args->open_outarg;
 		int err;
 
-		err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
+		err = -ENOSYS;
+		if (inode) {
+			/*
+			 * open-with-getattr preferred for
+			 * close-to-open coherency
+			 */
+			err = fuse_file_open_getattr(fm, nodeid, inode,
+						     open_flags, opcode,
+						     outargp);
+		}
+		if (err == -ENOSYS)
+			err = fuse_send_open(fm, nodeid, open_flags, opcode,
+					     outargp);
 		if (!err) {
 			ff->fh = outargp->fh;
 			ff->open_flags = outargp->open_flags;
@@ -172,7 +261,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file_inode(file),
+					      file->f_flags, isdir);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..5c0ea7ce0b4a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -731,9 +731,15 @@ struct fuse_conn {
 	/** Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
+	/** Is open-getattr not implemented by fs */
+	unsigned no_open_getattr:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
+	/** Is opendir-getattr not implemented by fs? */
+	unsigned no_opendir_getattr:1;
+
 	/** Is fsync not implemented by fs? */
 	unsigned no_fsync:1;
 
@@ -1404,6 +1410,7 @@ void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
 
 /* file.c */
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
+				 struct inode *inode,
 				 unsigned int open_flags, bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 572ce8a82ceb..d5322f6a904d 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -493,7 +493,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
+	return fuse_file_open(fm, get_node_id(inode), NULL, O_RDONLY, isdir);
 }
 
 static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..34b06cf62c16 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,9 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ * 7.41
+ *  - add FUSE_OPEN_GETATTR/FUSE_OPENDIR_GETATTR
  */
 
 #ifndef _LINUX_FUSE_H
@@ -633,6 +636,8 @@ enum fuse_opcode {
 	FUSE_SYNCFS		= 50,
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
+	FUSE_OPEN_GETATTR	= 53,
+	FUSE_OPENDIR_GETATTR	= 54,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.43.0


