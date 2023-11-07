Return-Path: <linux-fsdevel+bounces-2205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB07E332B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 03:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023281C20940
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 02:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F079917E3;
	Tue,  7 Nov 2023 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="g5RSiNPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC30A49
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 02:47:29 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D8FFA;
	Mon,  6 Nov 2023 18:47:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRZIrnG43hmBpxffTtB2oBP4CyrKcvPIuLS2TdfUfpVBBvCMU8vJLlExkeE+JloWWN3q1WO17LVb7YulwVOKM4/sgNazH0TF0L0Br6BbYuAB8MSoGWZaVrBSXeehybtKdzEuPlwHRacS8EzBLKXZsw3CtZ6RLxy9lYX+mxhxoZbMXA7RSzPrJYvSTT57gviXr49bsG84iFP4GUND3/gdkvWUKXXDSM9tiB//qhpeZ600iYISqT/1w6wGaTvL/8LUwFC2BGTh8h0EAi1irTzCYUObW19emRIN6DNAYZN1L9dmIE3x3p7t26QgCktfEzEK2okxaHA5zRrGBUJRMEb46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDRL7rHqrBv75f0UrjX5kr+iJG9vqSz1EcWBWq/avzY=;
 b=Nh8+iZZf20K3VnagGAYvyOv6yODl2YMOdYAMoi4xtjavLUefm7aOzISzSMRz34KEw3urjA6SqmsODZKDhFTyeqkCVwlEYPqoRWKiE9aOqEYEMbA02B/mSpLN/ykGrfiR3m5iKXPikrWgIm9jMcW4EI+uK46ae8JLonC5QPKVRv7tg8NTcJDoOv22dyD7g59C2bd2le3Ez9dcjDUIycHNB+XY7T/CTw0ODH5JD+6BRA2caboS7OUCifaWeFapiRYhLD7Ggy+Yfx/Rp9BCRiUSbjcZ4p7oJyRtNqdXidxZ492PPRThd20p9f89aWki1Yy6ZUse5pJ8HCPYvcOaDAYpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDRL7rHqrBv75f0UrjX5kr+iJG9vqSz1EcWBWq/avzY=;
 b=g5RSiNPapygj7S23dZDLjbevqtkO54NzkjXjnHweL9Hw/KLmyKK+6es4aoBwYx1HThCNXy5y3xGya+PZOgo1DWKvwEjwnTczJsltjz18JvPs6NmlTyPMsCNJ2F+QjgTRXodlH2ZmacU2bHsVJ+W1IgNzvcX81uY2fNuzfcNDqmYXm2rOgXWuv/ntD1EoJ8Bp0Vn5vX5ZcRdMpSMoc0dd89A1fiODzWu6gfnZKQWyxV2ReIxXxj4IaAu8q8flPIVLolRE75xkIOO1M6m10Ixu9n7UbVnzV5Dnh2/J8LQS00CUNfFcEJtAsFscWllA/L6XpkHQHpOteOLwKU0hBaJFSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SI2PR06MB5242.apcprd06.prod.outlook.com (2603:1096:4:1e2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Tue, 7 Nov 2023 02:47:22 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d%6]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 02:47:22 +0000
From: Minjie Du <duminjie@vivo.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org (open list:PAGE CACHE),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	linux-kernel@vger.kernel.org (open list)
Cc: opensource.kernel@vivo.com,
	Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] mm/filemap: increase usage of folio_next_index() helper
Date: Tue,  7 Nov 2023 10:46:34 +0800
Message-Id: <20231107024635.4512-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0094.jpnprd01.prod.outlook.com
 (2603:1096:405:3::34) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SI2PR06MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3d0404-a7c2-4bf5-25c6-08dbdf3bddda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r4OhjqJ5ZSF4zf5WcN4wTUlENlwvV+AwIHup9kYbPt34yVSf1xWEgp6NOtvnBDaB9LnlYKOwVMMDuG1TJVAYbsaafcSnWwiRIutH+8exvyw7kFX1HJjP90g5GEo/nbRpm+5pBNPWv0MUEJvFJJkGqMRbmRbmlh0fELT0So87z46KkyJPPI7VsGMbnhXI+kuEHFbrNZBXQyppkxIz+c54EcjPncML0LzGyEiot1SAVDXVVzE6TH7VBsjoI8DsOVZD9r1CD+2QZjZjeWlQ1oFCHGiSkQ2fB8oanwyxL0SD195gGkUkKxjp4sdiAYdWrS73AxQHMa3I0z4TQ7ZlEzEMQRQD7ITsa07BQBB6ob+CftV5h+u08aTrb5yu90OUmuBGkUfBWrauLWP7HTVVmQ6Fj4jGV0i8tBpr87cJ7yZD7QKJEWU02Qb98p4ZXe1AOCqM/B5+566/HKAB8fzDp262FVmsC7p99GDg1ZvGOwK9C8Gvf9PO67TsCCvwuHyeQDvTpm8jctcyikbFS9BVfdSnztQPxXAPun9Sbpk2Bat1DUW6rziFs4Ca1EFIsoUpgOO1ienI53nb2sb/iXygvHaB4hrrGJn0INT9v2ZfyGFP/GEnXGSLcJb/re3pdDD37Lk9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(66476007)(66556008)(2906002)(41300700001)(4744005)(5660300002)(38350700005)(110136005)(8676002)(8936002)(316002)(36756003)(4326008)(38100700002)(52116002)(6506007)(66946007)(26005)(1076003)(2616005)(6512007)(478600001)(6486002)(107886003)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qvxEnNjvatv8HzBsOU9JcZ+Uei9KQKn0IazAlQKrzPBj9H4FTe7fVXAVtgbj?=
 =?us-ascii?Q?1PjOWJYfB1tKmME0cMoPfnUrhhsahqstND/2ni6jn8V835dLnYyqh0NKKsY+?=
 =?us-ascii?Q?3wCSuS2I6lZSULBC8MDGAIR3+Winu4IZJm4C5wjZ+1AEm6403HgZZEkR0t/W?=
 =?us-ascii?Q?qjgJbGohL2RRyb7t9kDbzLYMz9kq2EtuHH5FnmZTT8A3p3MF9lWxbNot8xEV?=
 =?us-ascii?Q?r1tIChKc6NL0wzXNKRxPbz9wBJ13lvvOZl+Akb/57Sg1hRRh2PUL1Cvc0dRu?=
 =?us-ascii?Q?rVHpPuz10CAfJ/fTLmIzWGWa6BD21DZVBDRyB2CU76YCKJqsA7DDbYZ9OIYJ?=
 =?us-ascii?Q?FAKrpuFdBquCJgRxv0oxXHxy43oRE1M4IzxO9KDvNpyOaqrZHxJkUaN5GCFy?=
 =?us-ascii?Q?Vpg4UCicDqymPeQfKRm9mXckoOc4IdYRIM+l21uuz2PaMK2U4DQLYEMFnH6o?=
 =?us-ascii?Q?N566/6DKm/uX1PZYv7tVppY5ZLVr/Nl4mNlwrhBDeHhae++e9gAsGrKg/v39?=
 =?us-ascii?Q?Hwe3pBSNhvMrBkuaWmxfaffTWb07fnzPlCzzYAVjFnhyIvI9I+c0LK29XJM+?=
 =?us-ascii?Q?H2tomB+229uICSRay7JK9gSY5QBrB+DxJW1Wa0fuFq70JtH5Goo31qis6IT0?=
 =?us-ascii?Q?Kmp0kWMTV0rKhArxejRqA52HRgphlZj1ywp7hjtNSgSVRUgqrI/fOQB9vaTH?=
 =?us-ascii?Q?AQ978qjHtOFt/JWd76qvoS2SCCe4VPIm4UVYrH8ivZrK3moM/vE7XJQuM6I7?=
 =?us-ascii?Q?/WU2jqLqznq2Jck+lQt8bfn8ooS+f1ybNCFG1WhD2NVSXhKs/CqqDlScrvGs?=
 =?us-ascii?Q?sLIzyxHih5tsNPBaxxJu3kjIwrxyVWccBrt0ewR9RCJXdBid3+6NSoDT/97D?=
 =?us-ascii?Q?T/Nzfr3XzRwhFai/kj5PTyVYaR1TFZnMS5h36nW5ts4sF8hSS7d6gYCfKgPX?=
 =?us-ascii?Q?Yyksfeo8I9RExF/A3fULlGJ3+0Qgr8nwmt+fQ5LwThRpFVXbXt4xLlUUzRuH?=
 =?us-ascii?Q?fqWcpG2Cmor872bbrjlByxzpgpfi71MipAO7fmEFRvcg1isy84KQ2eljqyGH?=
 =?us-ascii?Q?2Xxs3KGOzU/qtZxVpBZ8ichTDGo5JbORMPJlv0OhRaOwVpl2t1km4SqyRozP?=
 =?us-ascii?Q?wHoH0PpeRlWdW/cXw/I3aAg0KVDCpKMUk3dAsNdZkbpqyaw1dTTbcVx/2en/?=
 =?us-ascii?Q?S5H2wUFOI5InY8RHhWObpJqb3eRWboM0cFnjM/DrXYCRozMn0eQG0b8ZK+QX?=
 =?us-ascii?Q?HoX9m4VB+hKzSPXaHMCG8abCJdduzc/DenCo/CX8qq5xcCe8NnCkzpnVJP7F?=
 =?us-ascii?Q?W6kIHkBjNWocCqYQ9RNoMe9CVKsx26s6ma8fNB52xyPUlOV4CJ5w7k+89OjI?=
 =?us-ascii?Q?5kutzO4Yy0FV0luaBDZdHOTkxgJvxwf6d61dKhvqYbBIhg/DkGaR1s4CPvmo?=
 =?us-ascii?Q?An9OVdBjAN8772Hc1aLBpg9BLMdoZRDEh6aRVrzByXzuR4Uz5yE59HIk5tdr?=
 =?us-ascii?Q?JHB9RdX0cI81MxvT4bLKCj3q5uAtktUOAK7EXjvihrqNa6G/WjmqcH4hKAGt?=
 =?us-ascii?Q?jh/45JBmg9Pd1jHEBAF1cvAIYKdTkBL29Di0YXzy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3d0404-a7c2-4bf5-25c6-08dbdf3bddda
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 02:47:22.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6E1+BxVMIJA19j3Oit65OluC5nl4JVsHevQlxvulsolTFjvKyB4Emi5L/l+ZtMbKSDkmjnZ8RbWE0/3IlOFhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5242

Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
the existing helper folio_next_index() in filemap_get_folios_contig().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9710f43a89ac..ec8a3bbddab4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2173,7 +2173,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
-		*start = folio->index + folio_nr_pages(folio);
+		*start = folio_next_index(folio);
 	}
 out:
 	rcu_read_unlock();
-- 
2.39.0


