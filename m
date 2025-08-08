Return-Path: <linux-fsdevel+bounces-57035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC435B1E314
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF018A026F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AC7246782;
	Fri,  8 Aug 2025 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="G5fUC3Cd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012009.outbound.protection.outlook.com [52.101.126.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC524169A;
	Fri,  8 Aug 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637325; cv=fail; b=IIfYoyBFtBYl04HH31gIkeEqIoFVUzuW9kBjvU+NdEDi8pcwtNBM3fwxy/PpzqOcDcvMPpxZK5PhkpPKHfToXDJlVMPxCZbK5TONIUBnchC26Qlw2qNAvVgW7Wls5nfu/yELz5wRufag6kJ54RZtSFqHlmSShwK9cD2+cOtkOuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637325; c=relaxed/simple;
	bh=fC+rFmC/6X3lfUkolERW6b9aE3UNa/kxS56L3o6aPjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRSo0F9UN8eFtba5qTPaeYeeqFRWRYz/AgylTRQgPOznbot6/6rXJ0azK5u3U2M5RvAC9io/iVQP5wp0Qfi7xjj9xQMg6/3+DjgqhlXKZTXUcp4jfiS9ENntulpsr39YYTYJ5dAwGqQu7PcF09GVNZrovoy6vpBy2j3npB05lb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=G5fUC3Cd; arc=fail smtp.client-ip=52.101.126.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EptRWQcSGtbjYKSpd2P3tnuRxSmRU2T8u2egizRIlxauwFsdqBLhLYPJ6XhOR5qOIINSBSEjW3o1RXTnpkNay+zw3lanq7MnzfThay/mDwXABO/a/XWWQxPYmJ3owZuItAVFwAJs+jftTNd4IGoniJghcP1CTQPWta66RcZ8S+E/AlsEsQjylaVsM0rVfsokyeT56GiyG7roqVLrXO6J+cFEGwT5qQgWZ2xTdELt7vdwh0N5rDHZyyXrfhNn+vjyygsy8w6pbjNRMt343lC3Hc9g1L9wECxKYkrDXXI/gq7czsH2uQhfJJt++oE57sjOa1klZHaTs0QsJcJdxYZYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xQxWk7EjgoMLCi3TbjUQh2ToTfiQ5VOh/n79zFgcBI=;
 b=AtIOp/Uedcm92XLjmCw0gVjLEIdb8jTaeYhJshac3XL3LVeHMoh3UgtC7ChKVlgCUNv4fqy701f6EHkS3SEQZvyIfcyPgwsIlPzNiSeTwUtxbAzCC/ykt+M3EwCVMT3R5UwDX0a9Pt5wkvG6bXSVj5sEPsIZa0yMczk5zVjcbjkkS0LS7f+AwY7jn3YO+zpZgeVpN7q1Aqu36CpDLph16WqUcP4nSAvFtZHLAvCr9mgWgwcb1f9hVh0eSfWZI3D8Tb607DxWos9j2yakREwMQ+aSfbKUIUclJSIC0JUi10PSyiGNXt4IvgpvHN4p8nDkqSELqRQdpfFckJZ9lc7HwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xQxWk7EjgoMLCi3TbjUQh2ToTfiQ5VOh/n79zFgcBI=;
 b=G5fUC3Cd/bBXstplws+w6tHpSiqHqasPYdT0myXbiPPECohmn0nvElTPELYghkLqMti2016e/6TX+z+B9J0mwxFb6E4/G4ZfTkSeAAq1VsjiToUS8HzQWquxbp2tIM18AnpEr45uA90FFpl5hwX5I9zLASfGbK+1oc9HZgBA4/2e/JqBw1UV++WRBUk2wa0dsnkrJ5qBCYCp0O2vz9uw08tSQMqygWXLpSgwe0b0qWkc5RMNP98CUQPsy3ARGQETVw/YC2m7RJU6z0vpkOdSyg3FqNfpqgD6KHcSwGs33DUXGPDYeVKVMORJzRE2fJLPpkxDkK0bKfjavyAr4q1Jnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6463.apcprd06.prod.outlook.com (2603:1096:400:464::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:15:16 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 07:15:16 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org (open list:ZONEFS FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 5/6] zonefs: fix "unwriten"->"unwritten"
Date: Fri,  8 Aug 2025 15:14:57 +0800
Message-Id: <20250808071459.174087-6-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b829126e-d2f2-413d-ba32-08ddd64b52ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mcaTrn+nbhVtfQqKFGRGG1kHjHntNV/CX+hDDwqB4BGYFSfQVBQkVS7t0Juy?=
 =?us-ascii?Q?Grbr2XjiZdYxbRK16DrmxQUK2AbeGyi1ISk1cAQHtD3mPFIjpnMVqU2MWtnx?=
 =?us-ascii?Q?As06KSdofE6dsbZHXak2sbIZPQGO6wDASx9axfHw7CI159ti51r6cCUvK1Hq?=
 =?us-ascii?Q?2TUC+0JvIXrJAqzilJlmPxYGv1LxLXcJYzbBtEBR11isRb9pmCbrS3o2/VFD?=
 =?us-ascii?Q?DwIF2Lzu7D2E/0W1vmmYtoHF7n/KjFMY3hqRF+Dbzxt1ukxbHEgjVfiTv72n?=
 =?us-ascii?Q?PmAapFolE4d2yiBgwThb+sZ2DcTMRjQItuM1g4iVTNmDTK1DXVhLR8EhptLx?=
 =?us-ascii?Q?BJZHlQwVxJ/8H5Jcla8pWRQdlDPDPGhbRiW6Q10BJy3O3qYjSmUrkCMd4Gas?=
 =?us-ascii?Q?cIFJE6deh0lrU3Oa+w6W/CpA4odWtrQ+6AA6NQWn0wrXBEeF0SzNIFwTQtOP?=
 =?us-ascii?Q?6wk1pM8DW4daY7IfJlkoBOTqBdWeYQz8fe4cMnaQw/92rjMH32IvmTDiezBA?=
 =?us-ascii?Q?z1780HmwukXs3xYqpiRPvE8Jfom0aeEoEzrY28lTWr8dxYYxlOtWcEUZ+S0p?=
 =?us-ascii?Q?PkUSaUo/DIar2QMAQ9DvDyrDc58YQOcJ9YEGKqmdeN+fxQIh+FfRgaLm/8Dg?=
 =?us-ascii?Q?IOKtWVceOAyARpiBeZjqaBnyKGatROc6xEknKIBxmAy2mA+Tr/rYWYcrpD0D?=
 =?us-ascii?Q?p06MbK45g4SMuZHPILzlOm0dnd62fvnQFzIIKy/+ap41RQ82K58mogHkhFzO?=
 =?us-ascii?Q?Mf47cXwCOQbA7ZAcn2gPTknFkcHGkDLvR8Uvh6molSG3bKG9T1LYg5ERbxmp?=
 =?us-ascii?Q?MYL+b/LVX/En4GnFMX3Ii9NaITzghAJBI2Ej0GhGHC3uDp5w/y0MBmAt7+Vj?=
 =?us-ascii?Q?sOWidCwp4NXvcNOZsOsoMZITpRBXnmrL4xl7GvLR226AFOahknWzbRFptzUg?=
 =?us-ascii?Q?+kvfsxlO7xURWDIcCAaoa7wM9uiZMXX6vBGSZHZyU69LYv1Xj/dg7ODa4eo7?=
 =?us-ascii?Q?67YdyJeXS/rzN42JmEDlBfja2EwdcnmbnCSrfnqPJnKVzHtvruVQkgMZ73kd?=
 =?us-ascii?Q?+tX3l7PIHUeTprizngWbFSkXke1x0xrQLyphamWaWw4Tqq7qgzVrKuAPiwCQ?=
 =?us-ascii?Q?PyIrffPqdyAE9HPwp/dIORNoATErpl2iG7HCIMdUeChCyhvBDsdZ750l15K+?=
 =?us-ascii?Q?J0vujY0KxiDjUqZZxfooDxnHUcVpo9W0fMRa9FlFxxqunya8doKQnXyxySgd?=
 =?us-ascii?Q?a+vTotlgkwvsJi0ip9rsG8P2G7eAJM9V3gonN4AuK50NBdH4SiiZiClkQGoL?=
 =?us-ascii?Q?9l5wDirvsb7wrbF2vQAX0gBIEDG4Z2RqQ8Cs9LMGmeLM/LtkWTwDdDvb6Qak?=
 =?us-ascii?Q?6Ny48NZ+UACgtMPEx0zwq922fIm8eFXMKTvHZ8uOyFakgoGwHQj39xV+BL9e?=
 =?us-ascii?Q?qcKXMraYgjGqXveR5Ja9vQFG4T7aAwzEfSouW2dbO86m2Xs1MpUeKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rPwTkKIKBuoNJETZngRu1y0ceZgY48oPMAC9pcGng+SY1lZ3m+TCxsBxTyoJ?=
 =?us-ascii?Q?JikkHCxjpKHxmKrAHCwOpj/6swLAurYvT9TYPcyqYbTbWfipdGZJxH9ZwOiQ?=
 =?us-ascii?Q?0PcmQCr6HtCSq4n8uqFSRXR07uvloRhy4TT06lUFPg6A3sI1XZz+Ljj8E7Ba?=
 =?us-ascii?Q?ZFRNMUhy4px+kb58yfvucn3Hp1Scgf4dg6jtKua7NnYUr21t9vAPBQ1UzKpY?=
 =?us-ascii?Q?poyB9xNQnjQoV3BnuLtY8XNOJ9PjEVsz+fKPOfquanWG4mQwhJrtkdOEpBOw?=
 =?us-ascii?Q?2sWHRO1NVHXk9zxOj+71pbU7lhyXFdoSFD2M/irljxk+jFgrBElA8Zali+6c?=
 =?us-ascii?Q?3G6UWnBF0+GWRV3XLa0A1nmXQitQUoC6riZDuBxqYW1ggvDFWC3GEiRdOf0p?=
 =?us-ascii?Q?phKmWlDF/+bQAXMif7drRHhE9fu6HWNjSDHDbqeK6L5pjtbADhU0llABE9Hc?=
 =?us-ascii?Q?u6Hlvv9Qpgibm55mMdV3xszWmIKzUaRS56gearZH7qleYnaoMXrrSRaaiytq?=
 =?us-ascii?Q?OJprezFIxW1EGiSPl6fw1FWxR7lsD4aXLA9hB6M5M9KOht/HjpJh9aqqD+eX?=
 =?us-ascii?Q?PjvJbR95Id2hDULusLNfZ5pIouIkrMoHzpuQOhDaGG4vboKA80pCXgYMG/bu?=
 =?us-ascii?Q?r+kVsZNJKqaFeZNDe8TH7jboD3zu6ot2bSUHw+bS8QnrmHE4BKsrG369G0sy?=
 =?us-ascii?Q?8ZzV4IlsFr03Q4ckyFvoIkCYiB8wxCifDmniJwvIzUGOU23nZhXrMaM5UnTh?=
 =?us-ascii?Q?yee5jOzqqLHQz1K1jEJdVyKtyA4nxwhj/P54nVOUsRcEA19hZxczFk483gp7?=
 =?us-ascii?Q?rIzrtwwNTBG3qAhweUru5IJMoIDKwGVXz1rbi24jquQTgwoUOlUSizrxT2QH?=
 =?us-ascii?Q?tt9kWvGvpsPdwSzV7Aj9X4OgYsxmPvQcNXpWfCkxBqj+QmqJgrLrnZ+8AbTh?=
 =?us-ascii?Q?0u2Jjg/uDtJjmT7Ar6yG2Ju9NHQGZtEJxR3Xuob2g8IboNbTZR74c8YRfSkZ?=
 =?us-ascii?Q?Mfmf5UUlBTiOhB/VzgpUTC8JUuuZ0iQ6KmbL7OovPVQALSzkMxmAXzmFQDtq?=
 =?us-ascii?Q?YP4pMcZB2VW7D0oLgVP/k3LqQF27/ASJzIn2GQXiHQPoXiwJeYBQFX7DNqZD?=
 =?us-ascii?Q?moy8A4/SLh7Kr9tCHgyMGw14EiM7qH9R1EwISrgCc/7XjhJjzuHdjaoppd9N?=
 =?us-ascii?Q?pRF0EpoCzcTe+YMsXUVjfO802LADRtUWqA2Dqwbcsc1VsNzIEVkBORR+lW8J?=
 =?us-ascii?Q?2zV0l6mVTA45f0ogDEKBxOFlzQNSsVg0C/o40wqqKzfxoO+OOz3g0xpTGCdT?=
 =?us-ascii?Q?qwdk9Vo2hi5DuWDqt7C2COz067CVN9TbXe8TKwB+SQG4UIThm2CAc2Mr9grY?=
 =?us-ascii?Q?aH759HzTNKQkbsM8ucuA/u5INdMwf9oMPbbtQmpeJuB8H3JEBqe0Cy4U/wj7?=
 =?us-ascii?Q?D75jdZGUJiFSLTsmhDHIvE2GzGDsM9C6YlqwqzCIUhixTZEcpkIxLW5UJNco?=
 =?us-ascii?Q?OHQoyhBt4j6XnIsqLfWLl67iZCsfMUsy77BfS5zHejR+4Vr3QFXX/WcAQm1j?=
 =?us-ascii?Q?kCTzJKXUhLcE+8BGKbOp6ooDUVTcC6pe/TvL6TTp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b829126e-d2f2-413d-ba32-08ddd64b52ee
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:15:16.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU2BYqH5Vy4MCofw+S7TTBAeAqP16EwkcqXI/dmFFv26nFYRiiaGAPkk7kLEgWJQNVLGbK8128gQJucvxBqdIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6463

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/zonefs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index fd3a5922f6c3..90e2ad8ee5f4 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -85,7 +85,7 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
 	/*
 	 * For conventional zones, all blocks are always mapped. For sequential
 	 * zones, all blocks after always mapped below the inode size (zone
-	 * write pointer) and unwriten beyond.
+	 * write pointer) and unwritten beyond.
 	 */
 	mutex_lock(&zi->i_truncate_mutex);
 	iomap->bdev = inode->i_sb->s_bdev;
-- 
2.34.1


