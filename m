Return-Path: <linux-fsdevel+bounces-26460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67395989A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68058282068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D301C93D9;
	Wed, 21 Aug 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mfYBsSwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD71C93A3;
	Wed, 21 Aug 2024 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231745; cv=fail; b=YUA8VwZs/M4cHLjy/FuZ84YPpXEfIB10cLzsAywMOk76mOePiMPoU2N+521eRkiZKEM46+DC8POxx6JNzHjC28rZMafqLwBB/WbMIvwj4pQsza8NMZqUIBLg6hemUNQK9kStNmC6wejgiLnxDJgtYBBbU3vVR7U5MeROvZRpuGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231745; c=relaxed/simple;
	bh=J+bl/S/JHj1aNxtwT57UinwSgj89xaUkjPVNAvm0RU4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HyUobSMr0zpbAH6oZPiqxCfA0+SjjQVy93Hl/zDpcXzgQFabrREPEHStaNZXlOk7HVyK8M/4czva7eWx+3Axrq1hgIy3Ooaw/0LMZ7t+CNOompycy1l5pqzU1jK49ONOfYxzPi1HQjvf4ddZztKGydpIG2omxe8eWjUSXTXBbGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mfYBsSwL; arc=fail smtp.client-ip=40.107.255.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM5xi5N3ETv0PCnKpCZMOIODFHksY3WoCwQ6uXOa+y2RsAhDMlxdGJp39O+Zz6nX74JQ4CgknH1yh7AwOWhHZBSYaTByHPPeV5o95dnjr4Xl55YqfHhU45QvtBkDOhRd+0ydcd2hpFBWpL5DXuwZUWP4JsHGq28ZD81HmrS8eyiL3VkvgvTY6XZld8b5bRkK+Jl2bPcrQ/sdd43dvw6I6/mSGEVL+c3QAfVMCh+IrCRj6YZe2zC1TAWWcgUp9OxSft+7FA1pvF4pIXLp6uJEbxAm0gJ3nyZHv8+v4UMujk69SDSqurh2eRvvVa59uNYU4RvvGkIxZEGb7PpLDcvRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exFMlRT66mjbsZgN1SDS8OZTxNL6AqNmkF//EfNV5P0=;
 b=m2Ry46x4T1Owqqxj8lXkp0PIZeX7jZZvwdfUbjzP0vuGKv3iwqQp5lnvlGQSyTAdDCVvpoamCiG1ezKCrDcyVZPK0oQqHvwmhDGm1OzrxorRQ31oo2WC/8/Q73fBvDnsojnKC2u5qarVBQXL5aEOhiD1yhtSTIdIHW+I4fMAkdpVDZi7x3NwpT9jJyXFQdQPcv75xMcMurmaKRRguPDCVoAsXJEf1Jj/use5Hkyu+HEedTqaDLhj8DIAdHb2qEiABPOWH5gVMygJv0fiEpRpbtpFUebHRHkqAwKPFs0VOVv4A8WT/IQUNil0NRactqAtMAMs6WR9mv3H0r7gBqR3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exFMlRT66mjbsZgN1SDS8OZTxNL6AqNmkF//EfNV5P0=;
 b=mfYBsSwL6YXlkjylXhiLmzDFn89VqaZOkDpynnY352uy4B57OsG6gEgXjm+hLNWXJLjv6ezsX6dJWMQSS+vU85XT4FIJTVqUGGjWV5Bnb67EgDX3BDJsFbI2Piz8nn70gSBT42cWqi/hilXv+8tjTSfdbTRT0boZExVPl+r5UlBVzcZJrVR2/PhFVe2FOYV0wt0GSLUQhOJMXW44Y4NEByU4G0+TypLl+wSFnfg3rihi2QzatFRDSliKhk5BYZ1FTRU51G8f7dEZcIXJxkDyy5U82001oYMHMzrM4HcdXlyWDgM4wKTpVVV9sIHnT0/BL+pb+CfuZa2Js18WolynLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by SG2PR06MB5287.apcprd06.prod.outlook.com (2603:1096:4:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 09:15:35 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 09:15:35 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] mnt_idmapping: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Wed, 21 Aug 2024 17:15:07 +0800
Message-Id: <20240821091507.158463-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|SG2PR06MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 83843e57-d11d-4d7e-7c3b-08dcc1c1d0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sNGR0j1DJhWf40hc1Q1i2WFXAu6P7zfeMWukM2DOU2Wc13FGRIvfMJvPH0yA?=
 =?us-ascii?Q?bvBCuKnDRwZ+JBE8xc/rT87Ej/hRDOG9u+LkU2XyrRsBW7LZnzk43fSNUnl6?=
 =?us-ascii?Q?iQCRBmypdWv0o7CM36d6O8qIu6qbfEKeXYFHQb5Rujp0z++F0um7b+loXVPL?=
 =?us-ascii?Q?NwWf8AsD5xREvN0c37WygTVqSejJnTa5ITEk+EythOHmbq+e9XDTO/PEw4PP?=
 =?us-ascii?Q?e1KKBkCpwuKnTAD5Np5esSbZr6bAOw0HmpXVdh8hixjRnteMDxQSj0D/hVoT?=
 =?us-ascii?Q?8gqI5hCq1wmW/CvPkyA2qUrRhxk0ClLWB3DNNq4Mh2WQeJvIGDU1ATVFCssQ?=
 =?us-ascii?Q?5a3PgP+i//Adds+A5SMMiR4nTfYeXZJo+AZqGoEu+WsLDHUF9AkE5uUMhNZ2?=
 =?us-ascii?Q?4dKmjX4ApNuH3yfGPjReMBaWOd7ML5qV4ssypUuU2zP63KCk7vDIHMlkvJV9?=
 =?us-ascii?Q?/FepmSqAGcUeleQ5kb7KiMd3xU+p27M7jyHA6qgA5HvbPIlQ2HOwHfZ/1wGe?=
 =?us-ascii?Q?hmyvmmaeuM6MPD7ga3d5vFNLQY3bJFPwDnsa1BYKeJzyWUh80uRgmwjvHxHv?=
 =?us-ascii?Q?J2qA7id8Li7N2N5JJ3Mt2g/eo8XfNkcWs6uvthOPxA77eAhGXlmhzgHg+xYv?=
 =?us-ascii?Q?3JoaQvwfO3uo/HHy7Kr7plNPEiNWH716I4oTrQIDBA33mUjb6VUw2sWJXuA2?=
 =?us-ascii?Q?krkCyaYr+HNyjPXFEKC29RJfBzVZCgCOHmc9LCQ0FChmI8BNXpM46acaotP9?=
 =?us-ascii?Q?HJ7RSBXWvjNEVHOpErNypdKMWOt1RNDhqeb1U1SA8bZsKAcHvBRJAGaRfBkg?=
 =?us-ascii?Q?ZhikioFUTkmmyZxM6ZpcqushlA8Yub54lgjdxVHMk2c5dqAfgEn4aSZUo5iZ?=
 =?us-ascii?Q?P6iMPcZS1WQrQ4E5GxC+lKGaWV3IzEIVLv8Fq3v5w5jKkT4xgLWMbHkwXq12?=
 =?us-ascii?Q?J4lUVuhISdMxVbbJsTcosuvi4uXBCzwEPwTUaVgl/NFmK+CdAUyFCn3PWzty?=
 =?us-ascii?Q?2fHMGA3k2cTPUNLOyCXqMaizndYh4XvXGHDk1YsW84OigmibRpri66Dpi/Ny?=
 =?us-ascii?Q?jGd/BbJy2YxpJsTC/bYIFsTCnvOSCr8/nl7wttHDFimCXJknmaN/VvIfYIoy?=
 =?us-ascii?Q?TCivS0Fiy1kqMSt5uHf/KwrOFVB7sXlKM03IG0i8qTsgv77auVWhyIFKh194?=
 =?us-ascii?Q?LI3z1oDmzFV1meAa4sDRyIjRgbVeHYV/f8h895nbILXiRCF3wtrBWVzFW3hq?=
 =?us-ascii?Q?3taE6m5sxbSRBAGrFpS5z5vvcsAyk9d8gyKvBgAbFUJAtUVQyyTJ2zDdmowC?=
 =?us-ascii?Q?qHFW+jyeIk2b/oESWr6GFSjT1PwfJ173kRncFSD6oEpDWvYfTgC0IVgWRn0A?=
 =?us-ascii?Q?JOK4MFRWIZ9s/ATyNYWqPd34R23/hVVXoVUBM7d2KHxwgt5V7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1G9uN+sw9aoe74jT8DsoMuhtBlKBl1ZNUtrflFO28OnQOK/rSo9/fDa27St?=
 =?us-ascii?Q?8tvL+oEet2O6Ei7Qb1qUY2ci+Lqhghwg5z22jFW15HNNJXk8hIjJqvxxT7SW?=
 =?us-ascii?Q?3z/sgEcf4Z6bKh5b5/skXHx1IiksWvgBAAuwLR2OpwXEZVGOqKwBlTrvys+6?=
 =?us-ascii?Q?ZxPiCETbWaEVVS/RAZXUutl3tBhLgHbOS70kRkf1esHjDITU1hBFtQKMLD3e?=
 =?us-ascii?Q?/LcbbNs2wtRtBoyaYV+N/NF0xeYhWbPax8BEZKjH9YdCAZYwJTtNYj0RqPl0?=
 =?us-ascii?Q?tAattq+A7gtGX3TTzgQIGlJiHMfMza7UCyIJw4ER3skLixO24BWjOpUoHAGm?=
 =?us-ascii?Q?KeRMMXDpp/vIFXcw8aUq/7+Q5MP+VTo/nkRi0By0VgmkepDRIICkUwX+clhJ?=
 =?us-ascii?Q?q3FtcvEN6Eq5aiKqJ2/mewAX4GJZkURqsofiiN3W1M+BEOhEYSE0DGpciyal?=
 =?us-ascii?Q?nSi3zZrgCEiccPHJeNZ440HPIro98OF9ZItZjl4hQPbJBt2CIHMAIyP9bvJM?=
 =?us-ascii?Q?oWZzKTUht7/l7fyMGfrutTs/OsvbiUWVGgBKsadbwBqs5OMIz52TH/QtuqS3?=
 =?us-ascii?Q?9WUT01luzKUqRCTcqznRnK2M/mvcQw5G6uO/xcyJaxlpnBH9aGGw6J1V1s9q?=
 =?us-ascii?Q?Ho3zrcWf7a02mztddQN/nPiAIkFknzW/aj0kxdH1EfeTqoY2i9XMMkdcbW/m?=
 =?us-ascii?Q?v3XGZ6FeBdnXoRiT/M3X5446/bNtxCVLgO56IVoTDoQY3deM57aX16aZ4NTs?=
 =?us-ascii?Q?ucBIhqRkk06IxZweiCelfgn4WpkUNsJx36ELF2Y3z+ZXGevcSufmEjfysEn6?=
 =?us-ascii?Q?Gved0MwNM7Lfhl0KpQGo4n5KOhwAdjoqhfv6DxSPK5NjqcmK+NJCK31sCuwa?=
 =?us-ascii?Q?syHAMLpaGRpaI8u4tg4QkclKpl+elwvRnDPXuHyizscq33m99X64CPma9pm7?=
 =?us-ascii?Q?dpSBhxmpmoVMs8TckCnRyR/yJaoJIMrfbWYD/EKH38mhl3F/47ZeFHi0ljxz?=
 =?us-ascii?Q?XBmG2MX/7a7gnyRmehG+uTH9WsxisVCr+xZyWShEny4uf1FbgcpBydfuxuaG?=
 =?us-ascii?Q?Oi4BHItfT4IZMMR9i+qFD9Znnb5DyLU5rHg1nWOT2x3XHXy/ng4hsqQ+8LS7?=
 =?us-ascii?Q?LWYSLsCiWCwanAya10eAeEUaFBvJk11F7u3RwTuxySnMlPDzFFkzLwBchD1r?=
 =?us-ascii?Q?0SYt8/j1NxMAohq+YLkS3SQYD/h4tWyjfSBI36JSqxPijG4z/yjzJF0zW5id?=
 =?us-ascii?Q?sUUHBzOPpCFzXlSU6ePTErXaHOnwF3cjkQ+YcjCHoVOrN1TejRroqZ5YllxO?=
 =?us-ascii?Q?7tvZJQKxieqeeQXexhRdtG1XA5+YMOGO/vKe8QjfujTfMpMdx/ZlASX3IpIl?=
 =?us-ascii?Q?BUhzdMAxPHvc0x35bbbau+whNujdBf3839uvzJPTe+1vLvm02vy7od1OCrXE?=
 =?us-ascii?Q?Rr3FqE0Ax5iuVHNDYugAl1ssiAgKOJq68XQ45+zEvVNlolN0/ESZjVEOVIav?=
 =?us-ascii?Q?cP9qFcCuNjaPGVCdxyKbZQAsiB2ohoYguM+0n+QaTqJvTi49vqn4HmSSOUoK?=
 =?us-ascii?Q?710YWCuamqDfUXMz1eI21AYeLOYttsX7x3O1TJ6t?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83843e57-d11d-4d7e-7c3b-08dcc1c1d0d5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:15:35.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quhT6/tlJB36ROb/GKSpZffAnKHU523GXulGUeEtJw3+U9ubZ2Wj+oEok3gDXg1/AErzjQiIiHTQYPmzmoCt0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5287

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 fs/mnt_idmapping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 3c60f1eaca61..fea0244a87ce 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -228,9 +228,9 @@ static int copy_mnt_idmap(struct uid_gid_map *map_from,
 		return 0;
 	}
 
-	forward = kmemdup(map_from->forward,
-			  nr_extents * sizeof(struct uid_gid_extent),
-			  GFP_KERNEL_ACCOUNT);
+	forward = kmemdup_array(map_from->forward, nr_extents,
+				sizeof(struct uid_gid_extent),
+				GFP_KERNEL_ACCOUNT);
 	if (!forward)
 		return -ENOMEM;
 
-- 
2.34.1


