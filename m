Return-Path: <linux-fsdevel+bounces-77823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCoWFP/GmGlgMAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:41:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C560C16AB43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCB843020FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD9314A78;
	Fri, 20 Feb 2026 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K48oo9PH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B222DFA5;
	Fri, 20 Feb 2026 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620087; cv=fail; b=dIG0bp+9flqdaDO3XE9LOl1uNvWjGYrbZmJlc3gF0yxIwJG2+VKBv07yFt1mBFp6eHoeOFkV8kZdiZnIUrJvSadCt3JVmpt5vxHuc1iD7UGdebjcfTrcoRd+mFDFr0z2hOA2xl1920msjjEF6PjhTxJbCC2V57CgotGi5iwy/6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620087; c=relaxed/simple;
	bh=t1owTixmfy4IFai7DvOH8UPQgwMHjhVkHLaA/pcpXEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YZT2bUl6dOihgPRJy3L+meFwLFshUoEIJQZru3PX5O2zISw4HyNEjI0/v6G/vhHyPc9ZLWgA3vJlaMTbtjEZxi1o1F1ziTMd3VOkCgqS3iD8uFhTtJUrnfudg608HLyjZkX76rLugFQi6pQAVnF72wmsjkRjbiv9JcmdXPzMOBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K48oo9PH; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8B7PclBkzFxmzUKtw+xXRT1swhkoH+RyCt2/MTZQdLg3EXhHv8ZA62XfzJpH35tAqhsubL9A2grFW73/GYyG1yZG+JN7lcrltMNQSzOcGSQKxG6R1byrVSycDiJmXEj9QCxtNkNKgTbBlT4vw0kAjhoVFgNw7eujmQl+AxNGEXMt2bwU5Tb7iq1KqeFcIxVJ9/qEPBryFbu0Zciy1uAn6xANzjQdXHLsk57BbFtQvum3yE8FNDTftmQvjK875PjOrgzzKLWp5SEgO8a3wloU01uHvZJ32SKVNbBg+PCriuKIgHcpR0Gm2Y9PJqICfa1MaV31+awIuhK8X2GPiti4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kpi4xp4racxjDxJgayjArBG+7rdqDVUnnO6CGd3rfUQ=;
 b=Bpz43MnUCTA+Kvsag2baSkvQHhMyaG5yakItPAI3ymDif2NWutDNa0DmOR+p8ih6qkxlWGcGurALO9flABAnolRUd0MK68FMocab+AFLBa/0FHciGc9nGzXzEbU7gQEiMGTmjjsemYyKr/GzCjy5OtBt/JtAb73Dhk4pOo302fanhDoe3rDWPxhNmJdLfGmh4C+JFQfP47MtgzN2sRFvZLE+8Vy1YzhVlMrjTjqVWHvZ3AZ5oQm1BBqe+sxqzTixKlG1wqK5OcOONsiX6PsUaBYphGM2rxvdQDcCMS+YgYQsslZcCp3uTRA66xrtiNYalSRw0aUFXSn7SZ0NsYBZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=szeredi.hu smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpi4xp4racxjDxJgayjArBG+7rdqDVUnnO6CGd3rfUQ=;
 b=K48oo9PHER4iyU8/m3TzzDdC/CR+G7Gl5DJsZjJf7lMlyowbeLsEGlKp9o16gkm0qHhp6lbdvz58qf17pqcYVZ3poipajztDC935U2TETry5Pr1ki0hfxCoBOoKnjdKPpIPPwsliJJN2GSMen5kiHavTlkZNrp6KlM1An305KA2PXDryQQ/KN7TiSNO/+nBVOZfLDr1dai8Zf3okle7iQ7vxmMr1PA8NoOpb+yLcdO5KdSB53wsjIVZyZ4jMNlZHta8Vx7zyRp/0rVrnihh3O+Px5GXsuDjX1SnAyYDvPQnhhKUY70KOXgtBkHtzU1o+5ZViTLnKjYchG31DcqA6Pg==
Received: from CH2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:610:20::42)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 20:41:21 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::ba) by CH2PR07CA0029.outlook.office365.com
 (2603:10b6:610:20::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17 via Frontend
 Transport; Fri, 20 Feb 2026 20:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 20:41:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 12:41:04 -0800
Received: from ubuntu.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 12:41:04 -0800
Received: by ubuntu.localdomain (Postfix, from userid 1000)
	id EFD8F26299E; Fri, 20 Feb 2026 13:41:02 -0700 (MST)
From: Jim Harris <jim.harris@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jim.harris@nvidia.com>, <mgurtovoy@nvidia.com>, <ksztyber@nvidia.com>
Subject: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is set
Date: Fri, 20 Feb 2026 13:41:02 -0700
Message-ID: <20260220204102.21317-1-jiharris@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c175eb3-d0e8-43f7-2425-08de70c067ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pqhzjE0oqCyC92iePNUwra5He6p/OFZYPqSdZ0Oc5DeMtyVruP7Hcw16fGx4?=
 =?us-ascii?Q?Q1LmyxRkrjeiZ5PbBApG+KGEJt7P8mVgeBN/cOGI8pbTDcHrOjzWJvqNg8L9?=
 =?us-ascii?Q?3wfMBUhzIrwWAS+UjkS3ab0ciub2RGmCVkNe3uRKcDkQ5LB94Ao8cH1fhe3u?=
 =?us-ascii?Q?ohf+PxumpwW9ikCsjR5EMSLn665kfs6VO3niLPxeSpMCUhP5gsw9cju6hrn3?=
 =?us-ascii?Q?BDBAF9YH+MR8+wqL8Y9DjAXn5EtMRUE9Xd1ny5eonPyDdm+CTJjBra1KZBXr?=
 =?us-ascii?Q?Bfzwd3HCqbR3ZBo/huq4QSLhh502Xa67G+Cq2BSmA3MBV+RXJNxfAxdd5GYN?=
 =?us-ascii?Q?7vQcIqoVoyV3FgSFT3+mZ033Ky22tpVqSjAAIvfxdRBQJFvb/eMRXTmtcHX0?=
 =?us-ascii?Q?6MYAzrvzRSxcnK/k1x7crkuihn9khYRlywWiHgQJhaILqe9F04igobJQiVWt?=
 =?us-ascii?Q?K/kJ1z3P0buRWXZkvnNn7U4o7bNf1HJLF+6awFJoEMhMRYnwUwjD64QlyiWq?=
 =?us-ascii?Q?GGZU1juL1F1z/XPhVwObrr962xt4ZjTJTx16hNDwO4nUhOu4HE5W8BpfMWau?=
 =?us-ascii?Q?kIWckCYwViEGth53g5QZHzpJyNB4+cz8vt3Q1LlcYoRZikJ9BD+E9WvwxRoq?=
 =?us-ascii?Q?xdcEYJXfMNVPha5rncdTt3OF+1hRQyVQvpNIDlg5MVCZkc4F/xB2JL9DSx4I?=
 =?us-ascii?Q?GbDaeE+iHR7lVC92uQbVToEtRy6SGR0Lcseu4HYZ1UCt8nsH6L1yZW1SvpJb?=
 =?us-ascii?Q?V7LG5hpu4pKN1iv3w3QRpYBYLY+Js8n6PYxk7R6AuhpJESTWBSYmgw3a+7ck?=
 =?us-ascii?Q?Ajjcr8bimp7/x+84okId85vt/mmcmukD9bNlx/ogi8P4mRB6lBDq79RoAa9K?=
 =?us-ascii?Q?ROkVVzQx0ArxOMMw67IaMeGuE/ZphIXc3bXqckf+iTQJWCrxoTRJLctH+e6V?=
 =?us-ascii?Q?xJ/d2NgTl4dkI/TU88ZpMzqqB8pqdj8ySuR+3K55HZD6pu/Pr98xYHYKxly8?=
 =?us-ascii?Q?Z6ORFDuVWFTs6jPhflrZSgQa7snFXX7J8JwjUh5EISnbIBuXeAEnTQ160BiP?=
 =?us-ascii?Q?jxy+b1XD5NivZfUagtzwdtHlpT10a2lO1QyFzY3+8Ta+CzyZuHubuwhQ1oDh?=
 =?us-ascii?Q?qVWEtZv8BsSDig5Qq7u+R0Rc8N+hixo/8HymcWjmWGp3gwIHVdixwobFMZ03?=
 =?us-ascii?Q?9n+iUNimC8prVNryfnRImF7/2F1ndGS3O11bn+tsAOGE/jwIs+e8KZBDKPly?=
 =?us-ascii?Q?0LQnVSpvbQ2J/LNQXE79ppQKYkQM7WA5hoCWRUwWImFd1lFJen7IxPMkuFRs?=
 =?us-ascii?Q?DCZBAXt83G5ZyEJ2gJMYsYRVuWlfOQeZNFmlJPRnboDdwg2xuDgpT/7Yyu4l?=
 =?us-ascii?Q?sbyzVvmPMbv3tJPuh4I3RAwwbxDOcuK7mB1V6AQ11wVaa5izcBZTyFW7ujUW?=
 =?us-ascii?Q?rZIbR6Bv2uR7gqy2CD81Q8RAZDZwLxgtrPV/CmS+N4p+5NeXmNge8cg5gedz?=
 =?us-ascii?Q?UmLcRhJ40hnygbAcEv9sa7EsZmRP1Grbsm4ZSs7QNY4XNeHM85P3wtRHw+Ax?=
 =?us-ascii?Q?y91EP79KPVoOPtntTRifA3hNQzvAzBcTB16i45pcghh1+HgH86DTkuobUYzJ?=
 =?us-ascii?Q?DuSfyMF5qcpRbeYoiZoag01v2BdQp6m/2+nJD7o/UMA5jmQOTNe+ncYaa5sw?=
 =?us-ascii?Q?pj6hUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(30052699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dmMkgG5DGwww4lBzpdlp+6eptTfSWzfJHw01VZ1usDjSnLnmPmreSQbdUwtFJn1lpmSBxorBw8CbvXumXTpZ2SRJeDyEwJUWZEA2+SQnni3YPqjJz71enukhM4v7Qz4UmbshdE6Gx9HP0FnlL0b8JvWrUyeFBbxryTKTowGHBqueADQZaMdoR6jwCb7JI9WrPPbaIhfjM3PCqVPeqoTydqp4g271Odvq2K6bb3CPf5rWkAKFbuKWfckPAMOOraPTJePMP46vHha7hDNBQ+Inj/c9zFJquoetuGP2np1gYg13iQ86cP4hQYnUD5o0ET05Cbm2GshWwhdMu+CMi+vRe6vcQQPI+Io96N7avu1Mbf+xwDDDuNukCvrLjM8Ep0fpSqNs/299qYSVGrZFHQHBN6lUEwmIibb6IFembCxNvRCRwqKBcHQ/E2LZx2YElIy0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:41:20.6876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c175eb3-d0e8-43f7-2425-08de70c067ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77823-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jim.harris@nvidia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C560C16AB43
X-Rspamd-Action: no action

From: Jim Harris <jim.harris@nvidia.com>

When O_CREAT is set, we don't need the lookup. The lookup doesn't
harm anything, but it's an extra FUSE operation that's not required.

Signed-off-by: Jim Harris <jim.harris@nvidia.com>
---
 fs/fuse/dir.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f25ee47822ad..35f65d49ed2a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -895,7 +895,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_err;
 	}
 	kfree(forget);
-	d_instantiate(entry, inode);
+	d_drop(entry);
+	d_splice_alias(inode, entry);
 	entry->d_time = epoch;
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_dir_changed(dir);
@@ -936,14 +937,15 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fuse_is_bad(dir))
 		return -EIO;
 
-	if (d_in_lookup(entry)) {
-		struct dentry *res = fuse_lookup(dir, entry, 0);
-		if (res || d_really_is_positive(entry))
-			return finish_no_open(file, res);
-	}
+	if (!(flags & O_CREAT)) {
+		if (d_in_lookup(entry)) {
+			struct dentry *res = fuse_lookup(dir, entry, 0);
 
-	if (!(flags & O_CREAT))
+			if (res || d_really_is_positive(entry))
+				return finish_no_open(file, res);
+		}
 		return finish_no_open(file, NULL);
+	}
 
 	/* Only creates */
 	file->f_mode |= FMODE_CREATED;
-- 
2.43.0


