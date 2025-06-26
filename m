Return-Path: <linux-fsdevel+bounces-53111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2CAEA41C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 19:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37D73A7EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78792EF9D6;
	Thu, 26 Jun 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Nwj3B1p6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012007.outbound.protection.outlook.com [40.107.75.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857C2EF9AC;
	Thu, 26 Jun 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957834; cv=fail; b=k9Q7yPsrAYjPShhQ7xJt1YfxVV1ID7JKiYHZYzVz30LFzgHTalcubcon1ND/bXaQCHfH4SkPvrQNxVnLTtuAb52jxcvcuu+ZQbSJcVHIXZMsruwQldbGtRy03kUmc2oDTidsr70eqJT+5ffOx5KNzHKK35K6hvUpyqksUppAIvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957834; c=relaxed/simple;
	bh=P2Lxi+JxzbjwUsd/mhzooz+NpLPtdXqItNiTy9yYtvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tCxJOxk5QLmeT/P8SchJfEuSPnR16KPZf/7lLk3TauiaAnJmhDtR4KDWQT2TF6ScoqAk/q5/BBuyBCn+6JncD2LKAiGxqoQ/89Z4yyqfriuUhgY5JdE7eg1aQoDjHBeQAUYLal44YZoJUrgNvcEMcuh/Pvqrl5j18RzeJ2xOPy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Nwj3B1p6; arc=fail smtp.client-ip=40.107.75.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bteeaA/M0Ts82fN8iPAIPTSn3qWWGXX2oU99fkhnaveKvolYmCgqG8trvddOOR4iG3ynM4DCNNuqi/rJY0bwNtBS8VhnKx/ceb9dqOlRACVFvQ5wXOH78dOXIeyUQKJKDMmwYxDLwDZ0+yIbYVOw8xcX3lbpDAW6vHAi/LQOy3NiliMl/l6uY2E0VViHyGKBJd3EV06ll0ZseCis1y5/aNJrgIMxfHEdo9zF14UL022raOnEkNx3ifo53Ja0uXIWYjnGLKCBI+hG3cEfMs6zNgtaXiIvjZNWaMMCqbuj5Nq5gFlaatEwn4atPYraCR/kSSYNDuDVusdm5irSdG/k/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcQDHSMcmQA+kIgPmzRkbQ4Ow3qAz++6gTRG168eUDY=;
 b=BBxe/if7rM6+98bbIg3E1bmKFJOEPSXziEOLeR4EicXzTB/pqmCMZ2gJv26PdrTiTQ/tYjz2p1TlZTHSixleMouLnZu0mSMnxz1mrJ5O1Uek4O1zeL72ytbh/TQGc/80T6ITotqnp1P5o7NVB4a8QB/Rjnb+mihE+GXihhrXvvQQa3ttNDI96hikvU5JHK0L26gwNv2xUq+n/agjtNozYGivcYtu0vxAjHmyAbVXFQiKYA/YYnAT9X0fSJNHByk2wTdmkpG5B03Nntr3DLpmAH/SoKFmKm+yMeFd4oQWgZ+GC+1N/74VNRDb3CuwiZbiIotVsJzRJV4cRQ5tk4uQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcQDHSMcmQA+kIgPmzRkbQ4Ow3qAz++6gTRG168eUDY=;
 b=Nwj3B1p6jM2ozNFfU9sHwf9tjbzR/2LrTlSRpp775w+v6QOOilXyazwO4KmgqIEShNS7B4VrOfWYIumZwHndWwpl4Xkni/ODHBq16+IAxR3PaJqPROofaGCjWYyZV9cx65DRblr0r+TmaDIziLV1ZGBd2PCeJaU8SirGLEXPkqthNeyY6ptFjjNQyKkX0fipOz7TdJU1N0JcpI58ikxBC6WYo0W9f7+R9+TSN7n+GlPs0vbD/1+/Y7qD8qhwSxkzVqUFSM5JgccLjaslPkSqHO8QlgCIKT+rc0fF2lRcagbGVmBu9UXl2iYpRv76ShLJkIC1X1nzJ6HOVaooQmkJ0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5610.apcprd06.prod.outlook.com (2603:1096:400:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Thu, 26 Jun
 2025 17:10:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 17:10:29 +0000
From: Yangtao Li <frank.li@vivo.com>
To: axboe@kernel.dk,
	aivazian.tigran@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	shaggy@kernel.org,
	konishi.ryusuke@gmail.com,
	almaz.alexandrovich@paragon-software.com,
	me@bobcopeland.com,
	willy@infradead.org,
	josef@toxicpanda.com,
	kovalev@altlinux.org,
	dave@stgolabs.net,
	mhocko@suse.com,
	chentaotao@didiglobal.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	bpf@vger.kernel.org
Subject: [PATCH 4/4] hfs: enable uncached buffer io support
Date: Thu, 26 Jun 2025 11:30:23 -0600
Message-Id: <20250626173023.2702554-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626173023.2702554-1-frank.li@vivo.com>
References: <20250626173023.2702554-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4d399f-c0bd-4e3a-1869-08ddb4d45a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6WSNU7/QfXF7lewmV0vPUN+rzUPaE9x84hdfxl38fcpliYhW2STe0YSJkaoX?=
 =?us-ascii?Q?rcuzcZoHILjSE8TkzrVj9Ufko047dv0Mqk4JIQEvothNcLc3l7fosEOAsBL0?=
 =?us-ascii?Q?+z1RgznEgH8L5Sm3A1NF1pgt7gTeMkfQ/kHowFgKbY4IG/45YL1fmZgHfUbO?=
 =?us-ascii?Q?mIdtFwOvYfmgqkifCumYIyDEK3bJiZiYjmmrV7I5OuGiX1zeEli6LHQuJn/f?=
 =?us-ascii?Q?IVViSyL9+aIGZUOD0CodAOHJ8/RHKMRPI48nVExUXaGy/attvK5OSpD7yxTt?=
 =?us-ascii?Q?u9VLczXMd5Qv4Kp+wfCTh30TABtRRLsk0KS5CDQ8qXAY0wVjumBs+a/Trq0u?=
 =?us-ascii?Q?r4gJb2P3l60kEG38L2MU1R0fiT8Dy0HgaV/CZnQdYsEGYiFkhJwPI/C3Zaro?=
 =?us-ascii?Q?r6b2ikv1iVnIs2EaVfUtOCq28LirOgldNB/EcV3LMNd43v590YS0KXtHIK+P?=
 =?us-ascii?Q?uDpaBwRvLgxBHvwUwKRpSE3cr3WKo3UnRj1iarOHJTQO9YX8lwQ2rAgg41Wf?=
 =?us-ascii?Q?4aP176wRZvewA2zfPSQOoRYnG04I7mlrNbFHWV147hhAPwqCZLOFo+p9scJ4?=
 =?us-ascii?Q?utRRjWvgdvycyDRqXWmt93KRha0Akfg19hKalUn1kpe6Y81AErcN9hxhXN0v?=
 =?us-ascii?Q?sBT2QHBkcxaCQaznydCln4xlpW4WeKWmdSY/J/kF7KQ2X8HtMwbwpEEkpCie?=
 =?us-ascii?Q?q+scZhoWg3xb7ClS6Qtlw56n61+IbEee9TEPWnwhktFSvDCADSNfYKYj3M7G?=
 =?us-ascii?Q?glSKnmdUyFJtsjn0voJFNKmhiHdMD8bvGlIRgWsEscGndM6uhFHmgrZIPaiJ?=
 =?us-ascii?Q?SoGHP7BUJ8WJFNSvc4sLHIYk8E5HClhcjdj71WnjE3u+SqkhHpYDyA6R/9j4?=
 =?us-ascii?Q?lObriIhNlDStDrtykTlwdvysc/CtWcb6tm0s/ZFxeerMFlZY5uOXpjn2QOv+?=
 =?us-ascii?Q?01Aa1zlPk0dq/jdwoQiDtjbd9KsieP+cv0waIaUV4ErwRZ6pqcw3Y2rBWef8?=
 =?us-ascii?Q?K835UpAjt5btCbyWc7k6e6pn0AYtvSh9X+FLWIXF88UgzQmFpP5Icc/FEEpP?=
 =?us-ascii?Q?7X9I5ZfZyvc6/WOQ17JDj8ZJQk3F/58WeuoelMHHObuA74c+M9Lrm5gGiS2j?=
 =?us-ascii?Q?qDlghTY6Eb/Sc6puI8VozIGkvd8UajLtlHPZTTWYNeyUuUOOte2Qs4tuRz/L?=
 =?us-ascii?Q?aS/u3asc5aM9QxkPu7HN4K7f0icIrBjGNeuw67wK9j0Y6Wvj4ce3QbhfFQd+?=
 =?us-ascii?Q?i2WK2xtuWyvusrCLwx3Y5rSJPRcefQEzAR+LEZ+dtxfounNhwj66GBktGHfz?=
 =?us-ascii?Q?hPveIzexDoVgSvRXIyrkzUrSlenPWC2mdT0+bW0w9HHiG5O9UtRT6PapMWah?=
 =?us-ascii?Q?FXwvfvkoYZ5Ti8SIDFbP/IeMk13MDqJXw01ZIyeWLZUYql9aI03v+oPPztJ2?=
 =?us-ascii?Q?H49lFVxEo2xX7az9G7Mv+lz3oQ0kJegwGSJUPMMU2zJHIKmgOOEFId0SgDQw?=
 =?us-ascii?Q?uXnhBVlGxyZ76vQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1qusTXUtbyINs7s1tkhZqJE/zM3/oDS+yi7ypFEUrkCk6qHkayqjHXEtFF7?=
 =?us-ascii?Q?12+5IUG4OCT56PKpRz9DwO+7+V5ebhyx/iUuTzJA2WvUc+yBd5b0g/RjkC1c?=
 =?us-ascii?Q?6fuZiYwl7lYQJKog8hSM4WPi9C5wGq7f6UIb7pc/GMZs7flkSJvXMpkyGG1H?=
 =?us-ascii?Q?7/thqU2svvToC6ev1M9VO/4J5IkXijbj1oWvQcad7FttFoVeLKzsHfN2tmDc?=
 =?us-ascii?Q?hCeyQmvN3ZBvFJ+lG8/IkyG3JDixJoqb1WGDaJpOWLThC/F9YXDQO17Vb8QH?=
 =?us-ascii?Q?JFl7p163qQO61HVcEFGoioMSGE9LtmG6eR3/eulRA46cGvKqxaSArxRigOJ3?=
 =?us-ascii?Q?MsQR9WgRwh7rTwAo8xme42V3XA+T/GwcQCY+nLyHRV1FnSO/nsXqFJRsRO4G?=
 =?us-ascii?Q?7/msAotHlhNSppQaxpEJ9y/HupQb+SL/Z+Hw/6m+Iy/qggoo43/cyBGgCnJM?=
 =?us-ascii?Q?mcsJo2sFoX4zUScSQPPybx+QZrwmhH4mVYSYkc1+JQET9CUq3rXh513CfuSJ?=
 =?us-ascii?Q?YE7D/jDZnyRAUiU2gmahkzyGr5/yslZbI7HWNxtRyDsfe0sWRE8ICARNG83M?=
 =?us-ascii?Q?tO7AWTOeLcyRbnUB6PZDOryRMYEcL/ArJxTslo0mubvmw8s3heQZ0roRTY2S?=
 =?us-ascii?Q?PZmXLiKTNc1tPoXDXMthZUHyOQ3lPARw+kuLvY1ulgAPvseQqKlsbf0mSnhv?=
 =?us-ascii?Q?t6rwPgIqtHc0p50obd7+oA8cxPAGBsBFJu7xe5ZcOmze4WbkFj4967V04BkC?=
 =?us-ascii?Q?1tBneWKiAPNQuWKdMWED9+bl3fLd6C0MmFjI3mLQwgiKUILnQMRC/TO2Wlek?=
 =?us-ascii?Q?l3XjrKBcY7rJzA6i1wE5m0z8j0NCZ4cavfR3b+1mk1lhN8NvtE1MXjmhk9xM?=
 =?us-ascii?Q?02nwYRh64nO5LE3p8j9uQ1t5Y/lCTpyx0ftnQBTPdgLvpnuw12A3ah5KP2IL?=
 =?us-ascii?Q?jQyMwMkCqGn/D6ziFauygM0UYXZ1JueidSWLCZm44Q50jjuNkZZ9x1XK+gCt?=
 =?us-ascii?Q?6VHYU7MckqrbEqEgxfmNeOYLHson40k23C23509vY7xZZ7qhAzpjMyjpm7w3?=
 =?us-ascii?Q?HyedqMwBkQMq12mOAOyygxDxR07zp+Lg6hz4HIrW3xYt3ORMdUYUw5QQ/fKP?=
 =?us-ascii?Q?5XWcSwZHSYg+HteNZ1IE8GC+rYBAlNOxFKzduJsyRGt6ODthY58n46Kmi2Dg?=
 =?us-ascii?Q?k251j0CIuGvQCyaBUkgLzFDfzXxI97rV8p6h3/EdnUMTxzgX6WhTSmLinTp7?=
 =?us-ascii?Q?ZKfliViN31tb4VITtCGjr91+2t+0zvJboJNyloLzNMsYlbPZmL4/MPgh2Kfc?=
 =?us-ascii?Q?Wa0NyARSVf3nKhHDpwOTJwJjiYtA88kuuy3ScrGc05rByyLCSURcWDSnRytO?=
 =?us-ascii?Q?BNBboSf3+/eTGIFxvqtLWMcnATiJVA6X4VbD/A32Kg8MCtBVl5y9ppmHpWrt?=
 =?us-ascii?Q?/O2wcqUDjTq8YjAHmvBIzJBH2FRZolHw/HjYjxnxaX4hhtqbkZO7UTOw/sLD?=
 =?us-ascii?Q?cI4Y3TEutcaVpSPc+FQ+URKouY9ovaEfnJFo57RW6YkUiYB/Rpc1VjqYwVI8?=
 =?us-ascii?Q?dOZ1NNSHEfg1HkEovHZHrie76bz07I3AXzfTZJT3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4d399f-c0bd-4e3a-1869-08ddb4d45a10
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 17:10:29.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeOII528DvjaQorOWbv5t+tVdhuaOx2GbPHm1MdxMNusgHR8eEC49gVnEdolI/Ao2WHqB0aTEVxg+5ZwRVDLXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5610

Now cont_write_begin() support DONTCACHE mode, let's set FOP_DONTCACHE
flag to enable uncached buffer io support for hfs.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 8409e4412366..a62f45e9745d 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -695,6 +695,7 @@ static const struct file_operations hfs_file_operations = {
 	.fsync		= hfs_file_fsync,
 	.open		= hfs_file_open,
 	.release	= hfs_file_release,
+	.fop_flags	= FOP_DONTCACHE,
 };
 
 static const struct inode_operations hfs_file_inode_operations = {
-- 
2.48.1


