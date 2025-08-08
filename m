Return-Path: <linux-fsdevel+bounces-57033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01CB1E2EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F444567AB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589FA239E62;
	Fri,  8 Aug 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SqzAXywl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012009.outbound.protection.outlook.com [52.101.126.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171F22759C;
	Fri,  8 Aug 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637317; cv=fail; b=MJ+cKpD999xluyYOPHX6AK3QII1sxfiJAjLGSn8iAGGiNLSKY/BmVaDp0YZFjn/vkF8AXH4hWX2xfrWVFTNm0Lr3EYUVqEV1Ok7NAnGzuUM/vZlIN35NrD1X8TZjMtxmQCxmCD9L27llKV03qLvlhQc2+VT2D8S2Qd30/pvxY38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637317; c=relaxed/simple;
	bh=sc6mvQCPhDlXsylyqdsui4cv/CWMJd0NF765AOOOjPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J52hyh1E82oHreRTeFsiYDjUT0hn8SO4ht2u+Vuaqb43docXkef9zv8I47OaewsaTD2iiozpaJu/MWgKPSKGVtOI1l3z8XQ4UPciBsY0ntr9fVyfZG3to/7vNI3lnvYmmNuHd0EAOQnR73HvBNyvKg01E3/K06W9t9nsxk83q6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SqzAXywl; arc=fail smtp.client-ip=52.101.126.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fac4ztbPeBU1qKNC6Q6Gn4M4gG0WzvUuUzH4s8IikCF9gqDLxDDAcOsUHivrFxIthKS729B6xffw7Iyq3TsJ9JRDHgZGDPmC07/lB0rnFeiEFWR5yt2TxDlwndgNkLXbbsuNJuQNTpmc+926ZrBx4szl+HsCfQftBl6cw+EzfU0PNOBb9yVR6xyjmO3O6c0+IaksXSkfUo7bjdySlpKHhhMOz8ZGDyI69vZfLJtU7HdFVbZi9deSD8lUi/AefcOQ/b+vVJF8B7FXERyJOIOWdML3fXGZ9O01r9rZEv35aOsKGL0Y7NyBNuCapwIWj28jHFcnm6Ud+EcxcHyBk367bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZxE10TZy2HFNHhCZRE+JLB+wf35rwSu0t/X+DKZw3Y=;
 b=MJucWLBbyEGVyu8u1GsiP4bzn5/FfxrnmwS/kw+lnwLzF+3EVNZgpCKBFW6hhG9rWzhx73TP7Drezwc0wOJ+v0kvAonsbHHFBrvNZYbOTQN0xEvOAaUh5S32hW2AJQX40ee2CMgnRAGVUZb6FjMfPSg5SBfAD3jlpTn159dDO9M8USIBT017WMa9UNnVcZfOCqRtqjzp3KCp2JwGVj3zKC3VcgO+NEy4XkgWViDLQOocRtCLgXhu42evqJpcxZR4f6bVsVwaO+BpkW12c9Aqbi8L8LjMrzllogoMLkfobKjtxwwg7o4nuDanGVu2uT4PSoBO78jM/1XEvf+hFuIuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZxE10TZy2HFNHhCZRE+JLB+wf35rwSu0t/X+DKZw3Y=;
 b=SqzAXywlIYxR/6vH8Xnlk8UezmNTUJih45xYT19eykn0KcGOObIx12AxT9X0kGCUKHwEnVw0Dr6obGZ4izl4xD7jil824GgQan4ehMXM885M0+2H5PSP8TyRBplUHt88IPP8xp/mCnhGBJ7667FXqrXtGvhHwZyiA0jkPdKydab1+URU5udpSZsT8thcX3z7rUAqSrSUofS2ZHaCS1lIf72qq3L8O946fHEW0atgOVkS+dFJ0tDhgNM8jOoFCBow/FgCcIYcICAas56qH4ImPzNkSLOgI/6Iqh2HoSZnMjXcHMahTIrseOuRWCedB92sNNwhfX9n+MKjAT8p5vHRMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6463.apcprd06.prod.outlook.com (2603:1096:400:464::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:15:11 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 07:15:11 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 1/6] fs: fix "writen"->"written"
Date: Fri,  8 Aug 2025 15:14:53 +0800
Message-Id: <20250808071459.174087-2-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808071459.174087-1-zhao.xichao@vivo.com>
References: <20250808071459.174087-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 536850ed-f160-4ac9-a2bc-08ddd64b4fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0fNzdXRvvmrQWVBc1vd+W/yZ3vB6S9TPqmWktc3ukSraJoY1W08RJ25GlnkJ?=
 =?us-ascii?Q?PfMr/GdJYCEFjG4MwFXJazIvF8ePcrofxBU8v8NBicnS/b+AAl8WySoJZC+W?=
 =?us-ascii?Q?XYLl4DPumtJ4eqbXisGgHEVFQlEKgLhhU6ERCDRQVJrvwsEGl9+qSbzBWJPL?=
 =?us-ascii?Q?CsYlY6mAieE3fJlPbYvtjBRwlQjn0NW/MaqPjXHQTvHYz/fugYekhM3NW9x4?=
 =?us-ascii?Q?8zqcwas1gx8uTi3p9EWyJSiEvPQJWC4uHolv6wNR0bWkxFKEV/Mb+7B72ino?=
 =?us-ascii?Q?dH0w6jX670+gjOVtLiFGZ6OP5XuJYvv6tnAH4A33Ombyxj6ouzbZMj2hKL6v?=
 =?us-ascii?Q?RX4Yxi/zyt5kuJDpeX3ClKC3Oy0/hQ9IJ8woP904qlsQU18HWmuWI8S+B+tm?=
 =?us-ascii?Q?YjxDzBZlcWjiYFP3xA+YDF2fTQEr2RfCDdxlk9iomEyaNZK8PVaW18w1PUMc?=
 =?us-ascii?Q?15MVzdAK14Gh6TRGOkkd3qB8AqURqjAgaR6USyMJwt9r5VaJK8AE5S7Lx39g?=
 =?us-ascii?Q?4r1fB2V/3bBQkk4Du5X+WIiyuIW4yNzutmAwZhpZyEuncVU9pJTMMBOhFzI5?=
 =?us-ascii?Q?rnSJy8q9i/Y+KjmvVdeWRSTiFScBd7NYQ0IN4vm4si19Tb0vGRn8GUA6CW9s?=
 =?us-ascii?Q?jPu/lwdnfP5+Xw+kcxlRlFx6gKVnALbiypXRGPh0Lqg4LaPihTENyzlOBTa7?=
 =?us-ascii?Q?TfjJcrEPFwDF+3kA2r7sXJo5qHtdmsF/XRRuWC7Kb1EV4M5AcRqnOaGck8XC?=
 =?us-ascii?Q?upzEKB5FLHq9rku29WGmMw2BMcQK1D6tB4g6wAFjJBzhls4EfbwfM8l+jmZr?=
 =?us-ascii?Q?6uR2SyPTEPR1gUoPtx7MP26uAEiMSTaHr1+gJlfRjDHy8XAhLSP7SCrK3djx?=
 =?us-ascii?Q?i0Ir8cslxzz6unGHJOp83155XrvGcRgWy+jkMwTZ6PLModURrxtyFcx6Ms6u?=
 =?us-ascii?Q?AaSkLlxLSJmODO2ubsBRdk+bS7MpoUI0ubCfiQvHa+zIYJmf+kruVGCMtfut?=
 =?us-ascii?Q?RnDC4dL4dnuAMv2WO6CuwgM6q278fvkRG4cM3svXewc7DSRpxW36IQE3n6yt?=
 =?us-ascii?Q?WINx30I2gr69G0cVLFEBUD7LHgilfZ6jHs5L+HLYba4Xv2Pn7zUEKgN5jK/u?=
 =?us-ascii?Q?vbcAgWKxjILZWD8Qvc/+ZJOKGJrVxoKXHZ2Y9UY0rkByFXglEQMzYnURg3iD?=
 =?us-ascii?Q?8neJtfOVEKc+pSUZDKZdubBgSmXeP1tyRehO5aRQHl/4uH0AHJWnGZuy38Fj?=
 =?us-ascii?Q?yQW+Q7HXZjRLa4bjlGcQE+YzKTFYEjQa+iEV7ALlC9GwvrzpiqFMyFH7qrow?=
 =?us-ascii?Q?dTD3vsR/jYlVhEAoKKpt9eecoM40itmVEkV0+fVf4x3exHUNkVD2AJt8jakr?=
 =?us-ascii?Q?QsID86ufg/zBsaj5RjHCvqCNHXn34xLRXI9E5f04pvTHRnpMkAdTjjmNAlJz?=
 =?us-ascii?Q?2PDsTKNfHmlLRTx82OplXP9gplFEfGGbD7M3KJLgz+kATGaFDM9DrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BOfPTVI6S2kIQUsftMq5Qyxy5DWpazmx6TSIShyPOHIanu4l4gpoAcdLeUsp?=
 =?us-ascii?Q?7PcUrxweXmhlmj7WuWC7vTc4KrWdtbrtZxT8Uhgpqso0m+vA+a5Wfy0wF0kJ?=
 =?us-ascii?Q?QPtkATpln4L3tSYlBDksxY3vbcS7p2Xy/FjIpi/h94/BxpvzZf29hEGHAgj7?=
 =?us-ascii?Q?8hfTXajC++lEEPji8RZbP5o0ZyCsf99n9WVMnRfjviKI4jYNTfgGf9Jd7hyN?=
 =?us-ascii?Q?iaOIgzegpZimVL7HlUw6Ackz2sEP9RUivV9TMH70Qg3WrXGm1TKNxc0fwucc?=
 =?us-ascii?Q?5XIEvHDWgZaJ3Gl5XZ5hb9OTsfqu20d3qLhSe1TjgN/anNaJvPj1nxiIyaQ+?=
 =?us-ascii?Q?HJdpa1ygwsKTCI5tSXgICSw/eSsAyAWAQMsuvh8tDxl8+TTKJvhvPdCEEPUm?=
 =?us-ascii?Q?TPhWsGadwgy+wxRRJoeaWzasOdVglFujxxHWZvZxKnCRqWzU2AB27VnM8S5Y?=
 =?us-ascii?Q?Yd+YaEDoMLp3J19mjCda9tWprIRA+DY9bs1xKdVmir/3GsmXNTJoVtM/gxUV?=
 =?us-ascii?Q?g3+0RVqYhQz/FqBuQYmNKkgBvBaKFXD/wYTKE3kUaXlEp70ZoExsDEHoepab?=
 =?us-ascii?Q?tth7N3lLajUUVgDCMPtmq9GX2sEak9BUON7SR33iDzGYZF64auPLDSp668EM?=
 =?us-ascii?Q?mLLh6Ig6OpOm3B7UkSM0yIPKoDXc8TUqnMhsr5CLl3A8wPBc5YTa2XyoWl69?=
 =?us-ascii?Q?he6COhQJHkOA6sJNeQLuqVzhtrtneA2UnxuqWjAohHjcU9R4UcNsgBDt4v85?=
 =?us-ascii?Q?nX8cOqj/8AcuDWWh7Se7GejqJ4pPyy4GRv0z8+CAf2tXQIgE77OM0mUpHHwL?=
 =?us-ascii?Q?mK8+o38ggqN5ntDF5ZzlrM8T5l1thCqRXZ7ns3TQPMnDxn0nvlC6WpSvlKty?=
 =?us-ascii?Q?2BP7qY+7XuhGKvaqAkSbuqE/CCVzv8Djydj6wFVNt0MkVnS4xlW1nU8o1Usi?=
 =?us-ascii?Q?Lb5wpQfT+9LxuB9yePCLG5xsoKbvIveO4nZjjCj5IXgkM+cBg/P5b3Q8IRk1?=
 =?us-ascii?Q?XQ/9pwIm6Sc2cMwWLomrPjLdRzbb/IbVonxfUgt2TFXBXUEC0+t8qYo83d85?=
 =?us-ascii?Q?ukVA8TwGM5A9HJ6ryqhrkvMQCM3IYZP0QbeyWih8V4X3mp1DE2xR5/mGNDfG?=
 =?us-ascii?Q?74Ha7t/8/i9+6heHCR6iOvlaIQw9qizGR2wpzq1UW81V/tR/RYcG8GJyDDLp?=
 =?us-ascii?Q?V8OuGKLwlcXHkst5Wc2wTQm+GHC5AJl22LLLfkhb/B5X0ZW3a13omeq9UwhP?=
 =?us-ascii?Q?4bUHSijBXKJELewixQmfIon6tCcHTi+iyjqKjHanQ0Q1lti31NNijOOMIDft?=
 =?us-ascii?Q?KolhQd960mCaLwqKgp36gFoWCzjSd+6twHMDXltY9/jC9rDsIm/szvk3KIBg?=
 =?us-ascii?Q?xxIujxKbfi9To8Gbhmy9PMJYFlG910THW/2iqIP7DJ47BQLC/Sh3HHhwEv1p?=
 =?us-ascii?Q?yxI799hzWRLn61TLRt4ZfRm4n/DrK2sB9zKZRcTFhFkSbfpB0p2mrZdvuqIh?=
 =?us-ascii?Q?oq+vnizrIJCuxSScAx01wkoBNoQfeG6zSdxd59cFSKUebPddCAT6ssw4LrKB?=
 =?us-ascii?Q?TOhI/K2cMBsvL5O60lpIjWc9SiKFg6j7hTQV/aAb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536850ed-f160-4ac9-a2bc-08ddd64b4fe0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:15:11.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wymeeVDt90+Eyaf2HwhzEJJsTUUppYb+bve+Ibr+iOnKdYS6vxbrBqIq5N41IoP4K8Urx6x+elUNZGt6mx3/cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6463

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 044a3011be49..10f7caff7f0f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4828,7 +4828,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 		return -EPERM;
 	/*
 	 * Updating the link count will likely cause i_uid and i_gid to
-	 * be writen back improperly if their true value is unknown to
+	 * be written back improperly if their true value is unknown to
 	 * the vfs.
 	 */
 	if (HAS_UNMAPPED_ID(idmap, inode))
-- 
2.34.1


