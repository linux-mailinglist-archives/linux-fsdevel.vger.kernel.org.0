Return-Path: <linux-fsdevel+bounces-59072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0EB340DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342AB1787FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AD32750FA;
	Mon, 25 Aug 2025 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="l57A5rIT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013015.outbound.protection.outlook.com [40.107.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C42673A5;
	Mon, 25 Aug 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128936; cv=fail; b=IppsxUP0BZOxQfyD/uaVK1Kvl/BpYpGsJpbrmUbFXhd9s5IjpgddqXlsw7uI/VMSlPTGmmaUoi8ar4rL18tmHbfh+1oHlERRpY28UM1Hu6HzXL0cOm0uCNuQAEAsh/c/6p2y/u78PksVhBRlQwQajZHA+NshWd/T6Gk3mu1mSy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128936; c=relaxed/simple;
	bh=x5iPYH7DN9D8WlwLBmirh7Ho/qW4z7Hxs1kHOtjgsCA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NT/27ikKc5haZwgGBtPPrXk5fcE7JjtugZm3c41R1zX5u4YoGF2fGOahpAnVp0feI6IZGt4/CqlC5CgIuB4qqoueuxnDkp6G0FzPSm3XCWSZaPEdwO3sODwDXU8/IQD2iB+fmPIgDiDQYia5xvJof/i1y53UbMHrCeaKra3i6W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=l57A5rIT; arc=fail smtp.client-ip=40.107.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIT5mhnH0HbtbkFbh3tqtGtIgbKNICXCir6xGQ3TCLTmxdh+Te93HsqSDPnd13tdbwclXSz80dXo6PPPW7PTvEesXjC6HxZGf1NQj4/b/v+5Y8r74pKqtIGJVXz1HSLiAk4GAISiEDAaBNEtgOoWaCLXT8yrhSh4nb7E3Nad1qsRgbv+xH17C3zxDx31VWtTw+sYm7BuqOuUYjZBDmwdorJrUXTpPiauALhq+1FXeFHUTGCHxRLymWkkrNsaHQM9eAqcYaX9YU/xBuxap+Fo2ocSXlc+RYbtValzZbYo0xCSsM31OI6jekV3btlAIjyTE68pKFKzkm1xY3diyP+7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbtWwrlgEspRzs6TPMADkLz5i4LEKTaSbdQ2dxXOIiU=;
 b=NVLAFCwFZ+5YZdFqNm0U8AaVZwiY3b06j4SRmL/0JS5YSbq1ZAi2V7j707n43r/tLky1PiJERquPWfRm7lZ/lKND6MPHJnDuuBlyQYjpSU3v/3HxT6zdiqa+f8n+GqyAvLgFFD0V4FWCrcA4QJnWAM96UK+2j3ENKybMqEeG0jjf0LDFVORSljq/sdmvvkOCSArSlScJE0vEkfv7t9jG8iboseywEg156CCP9lzWMlqx3PXpI2sciOz4yVAabWcSWgMMQ+fSNUn0V25JlkF17rE8CzfTdf6TscjgPK0301TZo+mK+MAzlIS5kjKZeOOWZ2mJ+rL9Tvmo5CEblcXUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbtWwrlgEspRzs6TPMADkLz5i4LEKTaSbdQ2dxXOIiU=;
 b=l57A5rITU0rH3sf5qRLCzrWLSkhupRHAOdr1VONWFYZriHPYgLEYcElMMIJbAHOLlOI7ukyKd23YtZMhjNtDQBC3d+KjaoaDpfdav1LRZM1sSR+NHqbHf/Lbel1zRiK2OeFKK1t1gzedgofOIts/LfBfXooC4DL9nmwW8fjqkWdwgyui9vo4so+GOTmO8M8gy5iu/or7+uEC3w87P+X7h4VLKAn/uEc/Q6zKRMg8u+rpZgOt/iZW8tASz+G23ptrybGcnYudaXZ5djJYUg4JQmtC20O9YfJav0RUevc29SfqsFsVAOhKrmCFvoiEDbKWnkOkHvR2VKfj8P9n/3xZqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 13:35:31 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:35:31 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	linux-fsdevel@vger.kernel.org (open list:EXFAT FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] exfat: Remove unnecessary parentheses
Date: Mon, 25 Aug 2025 21:35:18 +0800
Message-Id: <20250825133519.337291-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0120.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::36) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c799b91-0bb1-4e9d-1453-08dde3dc4303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?laB7m4aDUrEPpu892geEKWB4ZZboLBHNRjjHz6OW8LkBkzbJkNZMctI/UAet?=
 =?us-ascii?Q?iO7j3BBOz9LzCkFDse367r5a2tlW3tlrkfPgy2yEo34aMyDAbJUXvWTlq/Ip?=
 =?us-ascii?Q?ZUnoMP953Vc2/keTHhAe1uTLdkDKaxgXhhMBYYSmOH0Odsz6cMPCdJtT/6dU?=
 =?us-ascii?Q?OMW6ot34eZTR30Xk1bi9D//CxMQe2IbA0qLi2DvK6utSQIHfA99HdrPOT7Xe?=
 =?us-ascii?Q?ATRGO853R5yxDTiYd7yK3mVdGwNvTcHV9RiiF6M7m/Le3XTBbjE7WKyUsekG?=
 =?us-ascii?Q?fjgA25alUNQU5YF45ImbUlWioW/5kjRWBZyDQmU1VBAp6knLemyTDuXsaCPM?=
 =?us-ascii?Q?gV6lv2HlE2QMH5KORWFbUfjoB1Ey0ubv8/FhoprS83mTk1SmuokifI6mMPtR?=
 =?us-ascii?Q?LCP0d3JAIB7HiIj6mnBBbbmjANuYMnEokk93WsamrrC1vUsGWnzoZtnKg/0K?=
 =?us-ascii?Q?MDM+PydDcJ55whV6oOUDWdxc+YO+XRWVpK0i0QPYybwQ0YDjqcaJYdu9Xu1A?=
 =?us-ascii?Q?DPtKFMMwlrTFdKxnBXraPeQW939UPjA56bvxTAF8WZsseqpeAakq8AgYDEcb?=
 =?us-ascii?Q?zzAjyilKDG/V96egSHKOXuiByrSaUBCKZMIbtwUZDACMeHDROgAXy3R96hFB?=
 =?us-ascii?Q?7GUntLCed2mNdYV/Tn5egWVGqVst2y7uiLInaAn5EmEB6qMQtBhmKOHlpKKY?=
 =?us-ascii?Q?A13uV35nZp/J/tY21cWDcnp9T4F3clhpcjV0IsM2rTISj6dvF7hFSJ58+mbx?=
 =?us-ascii?Q?310KOM9P5ngnhmhY+ndtapqLYXTNsyBtoH/N4wLZBReRWc118Rwey1uPZ359?=
 =?us-ascii?Q?b0jvebCpslWrBFRHXo2q/RLlY99RAoWHI1S+gNrFStoiQfPbJtN4kkwFfdjD?=
 =?us-ascii?Q?7YETCcSbArz8gk9aZpKP3ZY1wC8IZVtyUlg5YEOn5o7Kq+uV5peEaMCrHQSz?=
 =?us-ascii?Q?j0XpaAWj01mJnpl6q/XGSba1jf7mE9e9Tp0gFTBhklxlAjMf4ypNu/x1B99l?=
 =?us-ascii?Q?+yife08lVrpXCe9VCHSAyi/wBOSieUBFTtmmfNDx+NBRzX5dngop8QZUCXYA?=
 =?us-ascii?Q?LifMwZwuvG8FHpUQH65HgaYkCmmd4SnrROqPH//96ap2XLcAuk9vcVh2ojJh?=
 =?us-ascii?Q?Fgo7yhaeBIX4LK02emaxhQyPm8LBuWfU6Gd6yufmm5FnMMk8gj7JAgvaSXiA?=
 =?us-ascii?Q?g2O7mzaMgS68ILDhmej6SusDKO3Og1jgspYhg6Pvj0OOCx+eEC6dBdY6cP5W?=
 =?us-ascii?Q?DZL+5f5Ch7VwKW2Rc2XbcHU7VJiRCHUz+kiSsXjlPvvkP/4MCr2JwYBBsR/c?=
 =?us-ascii?Q?Z9TdJkjApGVA8fuMp28wBxslI4BWhpdVXeriRY8il4ouyMcuLjBB+n+dglEt?=
 =?us-ascii?Q?f+ELfg4YHNRZRe/3iUsol9Ej1FnmR8mwf8EG43QZMBbg9sE8roPlS53pcFDu?=
 =?us-ascii?Q?pRJQo6f/f9J4A7DGpOlXtviIqU5nCOv29i4CykNndrkS/PhidwZsRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uTO/5s9okmU+HkBCPvHFXnot20AcliAlvi+BDtzUr1wKtbOtlYhkjAYuNk8c?=
 =?us-ascii?Q?STxAcDS1TIPWDUAAL4QRmTUPpg/g9MvlQljpDm7KosJe/izDBT1zYqhRPPfi?=
 =?us-ascii?Q?CSyJ4pcSyxKDAbxdqSjh7OLfHvTau1oIcg8bKcixTkjl8V64y/lbtaq7/5e8?=
 =?us-ascii?Q?JBdI9V/4sH6CP+Su4wGOQWedO3DeilyvAYzpfOL0biBh36FhNfX540qXhj90?=
 =?us-ascii?Q?NiD2rwwm8KtwJD1bX/TwX+JuuL5iTtnYWh2TOeYZ7HsufoPK3tuA7H0pKFaa?=
 =?us-ascii?Q?xj0FUtuIbfiTWMPeL6OY72UUrQ+PFXP6borWsPgwp+c52K2NDEDKkW8m65fL?=
 =?us-ascii?Q?Lp4ioELRs0mmKjelTEuxk6bfZXVXdtD1a27zfMdCF4vxWxbRVdafYw/Ucvip?=
 =?us-ascii?Q?KbP4Joa8m9LLOT8AavFT4xzZi5oJ05pgZOtgFGkZMerPtnA8CWvSIHULWtsi?=
 =?us-ascii?Q?4jRL6JUFLRLW78APM5gqR+NqKZg5i4u4tKEFSLTIlb91h1hDRyXkj3DMVgCO?=
 =?us-ascii?Q?kaCJBouqAhoAKdkqyIku5Tlu/0dIoIZF7ql+h28PS3Bwqebg/ugRXlps+i9+?=
 =?us-ascii?Q?oE+Z8XfHzVr1m7GTOsZ8fUJSwYMZDvzQQWbpORaR0dsCnvuby9bx3ZCiKwAW?=
 =?us-ascii?Q?svCqH2CzFpjjUvcYiivUva7OTO69HnM0kMqKSzEJ+mTu91vO1ei5O5fgUR9G?=
 =?us-ascii?Q?RXfkg0mHku9Zj8WiYDEGhqq654pe2imZ14YyGOQJSW2AUyCNSh02RDfYvGBy?=
 =?us-ascii?Q?LS8Nb4xYzepEKBfm0gyPVVAN/yx3gJeFnVXktBVqFQoFqp0qx8pZ91cOpYIp?=
 =?us-ascii?Q?P34nlwwQYOsoc0znQDFco8GRKETwsJp+BQkdzBBQFWhjuvFsl94jyIjb0URb?=
 =?us-ascii?Q?MEe0Rdx/gnsdzbfOugqr++ziY0n9OEorCrDF5OY5MkFXfSUuwkjo430jyKMh?=
 =?us-ascii?Q?/MLSanmgS8Qyb1BJFEdxJI/y62oTRoxsY3Iiz4r6Y00MlcgtlAs6bYqPjM3q?=
 =?us-ascii?Q?tQmjVpMHOMEXBVvwTGn+YXdyfa/CI9cUnfQHy1FGWbqBmoOB/uZMqIxcnrNG?=
 =?us-ascii?Q?Ky1RNo+WhcL91sln6Go47QUf4Yg0wWoJyvKyCsNAx+wkiVv+HrOZa0Rf2z0s?=
 =?us-ascii?Q?32RIzC7mfH/FoCbsfiN1xhgKx0x8GM1rc0cyzvNSRtOFhPvv2Pllq+4sbkk4?=
 =?us-ascii?Q?2WUe/4iPxUGefcBO05ZdiTjGAEB2X0yeyrg08sP/Hm7A/a2VK0MnQHZzYUcX?=
 =?us-ascii?Q?EMX21fa5WV7RrHAQogbeLh4epki36QssuLFcbv5Misds9J9IIpe+IRjoPVHe?=
 =?us-ascii?Q?UF9lwN6qPmYup6JJfywwrs7uALmHlhvvuuaA07+zO9EhcAenAVw6/h1r1dWP?=
 =?us-ascii?Q?5hC9U/4w8HcdqeALikVKne5nMWbN8R6BNldSTJ3iF5gb7PcRI4X2LtP1NftC?=
 =?us-ascii?Q?pokMU91fzsCDNSLryuxP/d6m6zGO4aOEzdhi2ErwL8ouQbmyQPlXbI2MwUje?=
 =?us-ascii?Q?ZOleqV1hfqVsXCuQmnUKf70z8YYJ0BoNJqqxLrMdkfPHqg5AmKI8dU/yX2xC?=
 =?us-ascii?Q?KGdzxFF7Q20smPn24/S9JuupTvDWxs5DStBrM8Bh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c799b91-0bb1-4e9d-1453-08dde3dc4303
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:35:31.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiLiyALlGWNH6gkCy91Dp2YHFrXsNfMxWI5OPRAosWkJFCXxnJvs/RoksRN+Kkmd96MhKxTny+zoWRwCbHwyLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299

When using &, it's unnecessary to have parentheses afterward. Remove
redundant parentheses to enhance readability.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 1729bf42eb51..8243d94ceaf4 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -789,7 +789,7 @@ int exfat_create_upcase_table(struct super_block *sb)
 			return ret;
 		}
 
-		if (exfat_get_next_cluster(sb, &(clu.dir)))
+		if (exfat_get_next_cluster(sb, &clu.dir))
 			return -EIO;
 	}
 
-- 
2.34.1


