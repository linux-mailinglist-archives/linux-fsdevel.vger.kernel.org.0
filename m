Return-Path: <linux-fsdevel+bounces-61252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C9B56864
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 14:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE822175B94
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7EA2641CA;
	Sun, 14 Sep 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bPQnaizd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013022.outbound.protection.outlook.com [52.101.127.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B025F973;
	Sun, 14 Sep 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851909; cv=fail; b=P9aQAEhpnv+yCASs08J9D7kto9lz90bgXnLkK+fjL2TlV25+HRUEAS8AKapgbCZnc7+o9hLnZE0zmg1WrXfuB7+GWffyohH1Bq6DZ836PxHxgqQOs4wHBwgtFH5qF6Oz3tHeqnc7MJkw32He/I13mBtnK0LX4MZemShGX2B3m+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851909; c=relaxed/simple;
	bh=zoT+zD1q4piqxuMQfttjuClrXaOU6gbiurLey/Q1F9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cclk2FN9DJb4+/TnKnHaxiCEclViOdnek1apOM/xSrSJNL8iPFFKx+31ihrDo+vkfzT5ptYx9u0iikdE6R4yiGF+Xin8qrHqan8s3h1idCgHsKmydjQWy2W2WnDloKoaq1VipsJSOpox2WABRQgAXmET/t/H2rzMv0IoHTbPd6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bPQnaizd; arc=fail smtp.client-ip=52.101.127.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIydWu0Tgi9jqjHxs0ZMGS9KDu/U8UhLmsaB8+J1mwc1S8Hv6hClKmFksqztcVdCEdrhgs0dboDwJU7rY7+wQpXMbZuH2YrvmZqFparlg/bbhfjJoBM0sodQGvXRIyH5BoiF0CXr+uCU5PstMOiNugeHs2ufqaMgnkxIjZFT8JSal6tmold0NmdpArKoUMrCqVgdG2yyBa5Ju538phCzzKk4G/7jeBmKtdr3NWUDkHGmH0WOXtYKkAB7YytghO25Bgso7rfiooezqB3og62QCzzyD9S4la57XgMaYNBUG0bYQ3esBe0BlAMG68sFh7egabXiXrbkzg0xZRVo4obbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENaaFpJSZVwr/uWMF1fk3AvD1iZiKh96qoGddOLwzHI=;
 b=C3IfX05wg3HqV5PBN6Qoxl7OxtHSn4DUSpwg+ne8RB64RaNuCPDhRMETr8clH5NzdWof6rrxjFfONcw/cw42qwngIAhA1gnNWxM/Efq/MhmRJ2gsHGS85lj5dDq9iZdPDw8lhRrx4HP9oFJ+JPn2Z1LFS2mncO55sQcU6gJ1pBqrtSLSNW66DmaULL3KC9j/D40vMnwltYVlKQkSziy72Fn3WIpeubPxLEYM/7OWqM10qDoZyMije66tBr8U1k6Egui0uQ64Njj1C8CfGbxQNKZEjfqrR/ViPZQIpSs4jguDd66M3djwnuuk+B85RHt+7ToA5Jl+3K8PjDarkTW3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENaaFpJSZVwr/uWMF1fk3AvD1iZiKh96qoGddOLwzHI=;
 b=bPQnaizdEW2TaBbuj1+f6Vmd04fK10qPos9NAgIeEDbsOvEwPR4PIPxQP7aKEiXSSGH9wgryo8eew/Ig2LIlCJW9JyeH35OQpYqMDna0tGJuMHFEgIx0QiDBcn5endjCzGlpiw4n4Fc+doFdhO2XOg9G2VPMUa7MIt6eg4lPBpPj2qIfJz12cP/aAD5pxonWaBkh38etyyfYvui2rREomvBGYdsW7QkeC5895Ie0qDr71QTmk3F+GODQHlVfNXzjSsqwZqNxGSm+dQFE2vunSITbGAkO4FOFwpnJR5ohPq3miuemZtFo1vW/BolDxaUI8lqlBd+GS0pPLC93nyIFFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com (2603:1096:101:2e4::9)
 by SEYPR06MB6226.apcprd06.prod.outlook.com (2603:1096:101:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sun, 14 Sep
 2025 12:11:44 +0000
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4]) by SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4%4]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 12:11:44 +0000
From: wangyufei <wangyufei@vivo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	cem@kernel.org
Cc: kundan.kumar@samsung.com,
	anuj20.g@samsung.com,
	hch@lst.de,
	bernd@bsbernd.com,
	djwong@kernel.org,
	david@fromorbit.com,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	opensource.kernel@vivo.com,
	wangyufei <wangyufei@vivo.com>
Subject: [RFC 2/2] xfs: implement get_inode_wb_ctx_idx() for per-AG parallel writeback
Date: Sun, 14 Sep 2025 20:11:09 +0800
Message-Id: <20250914121109.36403-3-wangyufei@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250914121109.36403-1-wangyufei@vivo.com>
References: <20250914121109.36403-1-wangyufei@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:405:3::15) To SE3PR06MB7957.apcprd06.prod.outlook.com
 (2603:1096:101:2e4::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR06MB7957:EE_|SEYPR06MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b8666c-a8ce-4e9b-5152-08ddf387def5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uV23DQG4D5eJL5j4oPAtSL9XGiEhHCxkyUVMr+18GT94UdJt0kaHCkbeZn7Q?=
 =?us-ascii?Q?pwwgeHtOPnO2usGbhxXgeJ9CMIgRqh22rlLUw2romnHMXQ1ffJ/hA5HBbWZB?=
 =?us-ascii?Q?Ws4ExQSxuWGD8cna2jO3hCJ5JnAutnRnVplaSyImqmNGQZn3ekT8StxfUQam?=
 =?us-ascii?Q?uk0FarhcpN3dahuJvjZZC0cbFF6HOihgEXUHOSxJOM2v975WQkz4aN4A1461?=
 =?us-ascii?Q?KluWzYUTUcyIr4Nru6RS7swW61g/QDXNN/QycCNYEGW88wy3ZJa4Va3O5fWE?=
 =?us-ascii?Q?bPf4havrz858mjq4mXtH/CFlJ1d2MyTKvoCo3KO/WgLX2jGfdshbShYTxh6L?=
 =?us-ascii?Q?cZZV2zUV5ZsSYI452CESaY2rBfOSkoVvQy6CroHKJSkA90M1IcVYwigGdc4u?=
 =?us-ascii?Q?hfXltQr3N9KqTHqJWf1A4u54Eai2iKq2JxeKMUdaNHH4si7TDM9YGAc2BQhl?=
 =?us-ascii?Q?NHUWZucohpRuuk4/oNZEnJcnCLCjUQ9MjEjXjMMFPRRo+y6lFXEHBczOx6x5?=
 =?us-ascii?Q?4tLYAyCRkzmdWGBXaTWWUhX2sY8SSJycQ4u6Mm3fZiiKcPYShfjKO271aBpr?=
 =?us-ascii?Q?JM+0bpWEEtSKUdVEDIEleKqF3Gd7FvzKsRhVKMn2JWlJcrsliJp/CHyZQfbw?=
 =?us-ascii?Q?O589Ad/sPEv1cceRzpxEQ0Wis6cpcQY5SGArqPB5B4fnkmVI7JfRxur0jYf3?=
 =?us-ascii?Q?atQMtnChLsufU7e8QIqGxzaClAr4RiYCf24/DWqG94nW/w1WV3nVdK4bxfXr?=
 =?us-ascii?Q?SV+e2RnzcwhXXrp03iqXV5JV4832h7IQd1D45OtvnO/AUCfmlquhePEFMNRB?=
 =?us-ascii?Q?3u+FLFm/DYrqc5TICtnvfTYRMpNtiNtQDSVjs1Afbc5Q+BHOe+K01Gh1cSQA?=
 =?us-ascii?Q?t69PdWbZIK+Kr+I+GmrJE+7XSBrrLIQ8TJvL2aGK1IcUQRYQbxIR777pUoft?=
 =?us-ascii?Q?Frfzerxq1VjrE5fHMr+HS7ORcgxl8MjAHgB4uRFbqP54bCMav2KrmEDReibx?=
 =?us-ascii?Q?8h67l+WjeKZXk/yyO2TO0iakFU2qbY/e52JFCAYwG0TRlmG8II4Ejs1n/WD2?=
 =?us-ascii?Q?umYRltaIFiLk8wtik5GqbNqs3V66NM2I+KHO4yX9XqGx+lRAUfTasqOFIoJA?=
 =?us-ascii?Q?jON2NIl6oRxiLED5rITiI4x+V/mEBsDqNWbTHwtqF5GTOzP/ZRwaDZtbSjB1?=
 =?us-ascii?Q?TGBrHvzxu4YNZ/gOwBJaQ8goqE2vfy8mkJJTPogD2K0JZm32/r3q+Z7/rqZV?=
 =?us-ascii?Q?RdfbdUxUmbQYahN9sOk6L1EeruleW91kjUMLqla79hJMNT2oJkHA7rHuPPUn?=
 =?us-ascii?Q?QMBJ2zAwX3rwxljl/cggzU26CLE8LZ3/SqINfd97LTJK8/3FE26LNzzc8Z/4?=
 =?us-ascii?Q?NDDs/zJIWlJx9zrDRBC/pGe+Hehzk8nNjG6r7i35SjXSNt9ID/sr4/coFc7i?=
 =?us-ascii?Q?f0SuxYee5vkEQk1wfNBh3TOXEIkhlkXULiD2PVWqUH8LnG9asTDdmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR06MB7957.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s/7oz0AS8BP3V00Mt8fGnB3farsMnv2BtN4X9mZO4JEM9jqP0Qir12w5gwjw?=
 =?us-ascii?Q?baNjPD6WvVt+ztSRASCPgpeF8K7xy/OKlkKKcTW72utcK8jaVxt/LalntR+Q?=
 =?us-ascii?Q?QpGuUJ1P1GQvDoEuhmjONNGdzOJdFNOqbd7h/L5SLyPFcoUPkStDPtUiHSEg?=
 =?us-ascii?Q?2EkzniXLtV1Q2MbBnw3gUhFbDkI+sbcShgrjWElWa2I0VuWHpSzbK/I29qy8?=
 =?us-ascii?Q?AetU68x9WdZx4XJYfxp1tCfdd90biKTqEGCiyhcCdtnBkygFppcNVUajK5pV?=
 =?us-ascii?Q?yOlkF/VTli2RrimxbkK3TppVd+vkQxFbGXDwFgzAXfhfWlZFS+9qihECEGK6?=
 =?us-ascii?Q?0wbeHURa2eoNo2YZho0uhPmNtjh2fUFUDd2LxAcgbi05QIY+JEZWHsx1FaCY?=
 =?us-ascii?Q?Gm0aK8apgofbQ9ltsJig7awdncWFhUT0ZCZS+L4PHc6YBUttLvAoPaAEHbdA?=
 =?us-ascii?Q?LtsYv0Dnmvc2W688d5fDxB0Z8A8XLweUt9uzOi5a+qvLHaYNpU2zWY2tiEje?=
 =?us-ascii?Q?O+MAZS1U5aUhOF8zJb5Z7yi4yyEz9Ld0IAdMYBmP1hLkHxzVnb7rqWL/Zw6W?=
 =?us-ascii?Q?X10pDGu42P7F4ZixXARt9F2sLXBcMLT9GNr2Xbf6226kWg+HBQv62zLxCwEX?=
 =?us-ascii?Q?kppSTII3xPFs5LFqsNkbDfnPsVDR7jtOiHP59euBXg4JuBrVBXL9Z4aaEgcQ?=
 =?us-ascii?Q?lUZJtw9FJ81SSzEDdxTTO6qyoDOB844T0ssy5rBa1DUbPLHIzKNu3D1U+WCl?=
 =?us-ascii?Q?gHn77COiiYymQVkPm5w/WBLFtaV+ccBsDWbqepvGYbXeurs1eQgSw+fyXc1w?=
 =?us-ascii?Q?c2B/WdPn5cLx+40h1oosXiMhQn4oL0wkY3d1pSK5bt0UrZC/HzH+ZZ9Cew1A?=
 =?us-ascii?Q?ZTeOZy9tF1Mpk4B/zZOi0zAQv22mwWPO4wfdefxI63McE5pTT7oo3owQGNsa?=
 =?us-ascii?Q?9s4Ru09ujSTmODHtJNun1aGme7j0n2A6E6H9zb/BsJgH2PaaSPZb5yrFlRbz?=
 =?us-ascii?Q?Vhd1rJOcx4/Sg6Z//djJpSZwbEc572HQYk+rHzSVV42Rc/7YdTKR0yVV82s4?=
 =?us-ascii?Q?cpEUDd8W6gMlsZ7u1+33lRHwKFnKdpV6521oMWHuabevqiok1kJkq+qLMM5Q?=
 =?us-ascii?Q?4f9W4JnUpBGOCTrdUy2Izv3CvfffkFYuTLYaErA8xELAWU6O2JLoeh5wgJog?=
 =?us-ascii?Q?v+QrAs2F1B1qETzorajNfA8T99eTCN0wOE6Yda6kM7HXCXOvS3llvDgmIK7Q?=
 =?us-ascii?Q?XhzbEA9/+qCOm5QN3UT9THUergnLeViurFjwRFsrlSzIEAff3QbzCWSYRjMb?=
 =?us-ascii?Q?+jMn8JCB28mc4AqMmmwEm1zqNVPqSBJ5LFcpLjMLgYZDRN55e5mNjt53vw0A?=
 =?us-ascii?Q?4fb9jS4nLnVDQLMCO11kynJ7fhjcUmnoom3IKfVFXUWtjSubLcZrToXncunY?=
 =?us-ascii?Q?aOIjHzjcqUb+GkXHNtFzaqMZikcsQuOrV9jzsMv/LSPRx41wrIZg4IHYTKyS?=
 =?us-ascii?Q?TR8aCtNQrttsAIv8zFrkLwm319z6K3kHEZSzqv8k9Ia6HAEC47lyxrmUEY37?=
 =?us-ascii?Q?obLrLNSPt+C94cDF+Z02daEHuY1O32PWafYugCsD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b8666c-a8ce-4e9b-5152-08ddf387def5
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB7957.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 12:11:44.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNu7xzq49i+mWCYyJlCrqSJascJV6mUzvV6/2VESeIQGfyoaZu7PeSkevfvtzVbahz1uwO23Cc56j6dtbZVhNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6226

The number of writeback contexts is set to the number of CPUs by
default. This allows XFS to decide how to assign inodes to writeback
contexts based on its allocation groups.

Implement get_inode_wb_ctx_idx() in xfs_super_operations as follows:
- Limit the number of active writeback contexts to the number of AGs.
- Assign inodes from the same AG to a unique writeback context.

Signed-off-by: wangyufei <wangyufei@vivo.com>
---
 fs/xfs/xfs_super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 77acb3e5a..156df0397 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1279,6 +1279,19 @@ xfs_fs_show_stats(
 	return 0;
 }
 
+static unsigned int
+xfs_fs_get_inode_wb_ctx_idx(
+	struct inode		*inode,
+	int			nr_wb_ctx)
+{
+	struct xfs_inode *xfs_inode = XFS_I(inode);
+	struct xfs_mount *mp = XFS_M(inode->i_sb);
+
+	if (mp->m_sb.sb_agcount <= nr_wb_ctx)
+		return XFS_INO_TO_AGNO(mp, xfs_inode->i_ino);
+	return xfs_inode->i_ino % nr_wb_ctx;
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1295,6 +1308,7 @@ static const struct super_operations xfs_super_operations = {
 	.free_cached_objects	= xfs_fs_free_cached_objects,
 	.shutdown		= xfs_fs_shutdown,
 	.show_stats		= xfs_fs_show_stats,
+	.get_inode_wb_ctx_idx   = xfs_fs_get_inode_wb_ctx_idx,
 };
 
 static int
-- 
2.34.1


