Return-Path: <linux-fsdevel+bounces-61251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7450EB56860
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B293BED85
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16DE25F99F;
	Sun, 14 Sep 2025 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AZSC/ke6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012044.outbound.protection.outlook.com [52.101.126.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90B1F8728;
	Sun, 14 Sep 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851902; cv=fail; b=h39nzxa2MH74LjkfwF7WONRrLTD1R74Ft3jT2haVm3vCVXsqP4xlmr8msQrxcTkP5pXTcFNmgBB+rjMzZB85RN6eNq69SbDZNlGJ8sVXFfY7KFmJJ1vk4kbkKjiUy9/nBJ63RYn+DOZy9hAG7i5Stebuh+O4kZwLrLGSb0jw2Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851902; c=relaxed/simple;
	bh=y/Jcw//CvnHzKTWWtHKVlNYD4A/r/5WvrXBwuXJjJus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acpjbTuQejxssqCX+LFE02pkBjp/pL4Wfa3vCgHHi/ebKFXgZPHVuRbo2MHmIAV9vpctmryBQqczANOR93//TxhrQzXyYyNt/PKue+0NwMSv6f7uPOQiAXRMUlMfGeF1LXRpH9wEz2wupN9W4A+6P61J5ZQyaCkHDDPHV26uXF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AZSC/ke6; arc=fail smtp.client-ip=52.101.126.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIMPtxhWEUXv0Q4mhiiVD1Tq24CrZ1ob+slg6B6KX1pMRxK86Ydhl3uTIs2HkoxTBESTghKbV4Bf3klyxngWqiMOMdGSW8GaBKIXs3mUjcscwG81UERxlIgJCmhMicVQf24zb0zcK7klR4HRUiW9Bzqp9hzljuOkYm8izVojgO04o4RxSs12sZve7yZmBR/SSjYY7nOMTjYKzRETndtW0V7jLZcVIVJ0UiSOFeVQlliJb1gFjH2JrO0BdoE24ge9lvJ/6PLvxVlptygiebuScPRToS20wI95xdh2FLGsSaPxhmjJPn+A2zQqLmUq+uWcje7RY8n389VNBiO8c4jnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QXP5VKxzMpyAlhq1NHPBw1EXClNsOQIPvNh/aihnhE=;
 b=lQy850u2hiV+HBR5wftUw66Wv460hNoBEk2u9yhn1ZrY86MErWMEYTbruLlUhgWQ6CKEcveV0y6OOeL12cMawNtLYAx62uJgWsTHQtaJ2dnq17bIuLW1k+5KoZuAkvq76OCY/5YwU3uabzEdUd/E/tahmCCCWMyNGTroRmLbN7rxRlmGh3rtVAiVQpFBoHGHKlRgWonAjsqk2e2GRRBR6+sY7bKu7McU30Sy8v/FkOBng5pL36FasFnpA5PpKpITy6XK9MfFwKQZr2+lfPM6Jj4pah8hfhSaKvoi1GrWToaDFmS8NlzXo8rNjZsNiuEdyxyph7Zf2sWM4RvtXEm9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QXP5VKxzMpyAlhq1NHPBw1EXClNsOQIPvNh/aihnhE=;
 b=AZSC/ke6rNUpT7I43k2eSx7qmfv4gE7fRRi7ki7WfWnwLxaAehp8AicU3KLcrkOgi3W25vFAwDw1oxuI3+K95xvyhxWtlwQdlBS5J7mW/XAQ7c8nTNvpuUV6NoHj7E5VE/ptqI6OlJGTMZvsjqeMna8JHsNIylBwoseWVPv9VEcTwyMQL+MV+z3GCwZuoGTzUIca9lFlWmuQ2VEvMiylGvgOmY18wACEsprKMsB+BZHRnSlx//hkgvMUoh7HRLH+rxJyYIvyMtMiAXaWwnBTKDnC5czAQ6RzM0iUa6sM4upCnOnLuIQDlAjMQ/LRyeiq+Xbsnhp0eQd2fEw0s69UVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com (2603:1096:101:2e4::9)
 by SEYPR06MB6226.apcprd06.prod.outlook.com (2603:1096:101:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sun, 14 Sep
 2025 12:11:38 +0000
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4]) by SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4%4]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 12:11:38 +0000
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
Subject: [RFC 1/2] writeback: add support for filesystems to affine inodes to specific writeback ctx
Date: Sun, 14 Sep 2025 20:11:08 +0800
Message-Id: <20250914121109.36403-2-wangyufei@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b950a7ce-f80f-4776-45d8-08ddf387db1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3tl2E+0LysL/g5VOHszne9JqrEwchjD0Us/EyI142FGay/48oB+ZTO+rK9P?=
 =?us-ascii?Q?lbbm2jNPsTymF2MUAlkKnSXb7ZbxiY6IQzXnha8hsdKcD0EFgTEOTQvMlv9r?=
 =?us-ascii?Q?8E8oRxbWPTESdt+huCw9qHkibQbATleTVHyshN2EO8XPo8ui/xmzEHvPjzGj?=
 =?us-ascii?Q?BShYQUIWynKuuAKENiNKnhSkXioMV7APan3wcL/KBCUkF+8uPr0iV0p86qLb?=
 =?us-ascii?Q?OdOCR6RBgTEXzjKzVOpem1EUZ6JaxFdreW18UwCSDsn1z8Bs8Nw2PgR9qKF9?=
 =?us-ascii?Q?xPoez00uWv0/AaXJ62Qyw1Zwnmpa4nIr8inxxjyDrJxxhLA1VEfyz6tI1dlu?=
 =?us-ascii?Q?6LbT+a5u7l3DJbVLVWjQraj/DqOUcoplQ6uof1NL/akkDjbx2NqeJqt1pGJ6?=
 =?us-ascii?Q?7HiBM3QVvqojC8qifEs1Su3SDOwI1UBT1xrHZ165i8WAZ1PQAajhQjkvzFhN?=
 =?us-ascii?Q?wsB7Hi0M/vWrVSXhWscl53gOTlu1mPYw0YJLBZofuf6F+CcbwH54SmMsQMBD?=
 =?us-ascii?Q?XQVgEpkLLHfyp+mTK+3/NDDynJo0KOdhM3VZGQ5GTyzBAwR7UB1qlZ4HO2xi?=
 =?us-ascii?Q?8PoNmFvUq3AgaXbr5IlLF75HXKc50SHnASXBgqubIPdtW7XxlGj4TUi2w5Qy?=
 =?us-ascii?Q?tk7cyKaA2WUDI4U5fdJKhfbl6hC5I+9RntaCJtT9qzvi67J5d1xetD2Fl4lZ?=
 =?us-ascii?Q?HaXy0sBJV4fV8h+s7a+on7N0qzxU4wCJvClJsFD1bcopd61usbDi5zWBnjDy?=
 =?us-ascii?Q?em9oHUuT09m+NpI5ztEybeusRNvyy6uqMnOI6giL/7PSIyJ4j9Dfvx4y4Y2s?=
 =?us-ascii?Q?XlTRjk93vc2JhE7ceU+7Jjz3+uHVmUcWbWoW9KbYPvWVMlOD8SllYyuw+jAL?=
 =?us-ascii?Q?TtlHMQvGu28o1nQkLVNTGtCV4xuDRPqtuBCLy/458Df4Xlp363hIMgwPxszW?=
 =?us-ascii?Q?rqW9ucwKjWaoXh256CAe/0Mmj/nKfIGTPN2wX26M+5I6KnlWZmV3w/f5IxQ+?=
 =?us-ascii?Q?+RWnwL5xMfDiwdq3EnUTl4C5yZzTrVap1qmIEU6D+PKIBVkiOyAt9IEo5c8A?=
 =?us-ascii?Q?KvVTUgtdReM5jEHTbuiki68/u+2uxwkvXaNm2abEQfhWhPV1c7mmrcVUmbuX?=
 =?us-ascii?Q?MANN0/7TkNt/f95QuybcS2b5haMs57vSBlNHtwFXpH8NGeYdL2QeTf32odT5?=
 =?us-ascii?Q?e9PtEqoXhBP30p2wpJF6SdtbzbPDqdKcyDiB/yyg55SQFPWPz/7SrkS2j8uW?=
 =?us-ascii?Q?MZD0cEyocTZ+KMGTElQI0OulTfzio5TZ5D8Kaldns6pbhoywdxnGmSq+tNNC?=
 =?us-ascii?Q?Q0FgXEqx6xnNHIscXZSbftS1plblkjC8gimHA01rQJWGi5FT4L4BjvHOpiVG?=
 =?us-ascii?Q?U6cABhpeLXTIBmXavyewJ547pLmCz7QC7NiBYFbGOor9w6VKEE2qdkmtFHvA?=
 =?us-ascii?Q?BWNrdPWS9pEWvWBO5YfLnQLEBbCQtsXNAuM9VuPO2qdAmMjH5iMSgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR06MB7957.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USVeD7X8atm2KZn0aoF7xL3gj99yOj8wT7vd62hS33xHJ5W4f5x30xjHg2ZY?=
 =?us-ascii?Q?/rYnQ//jNeAPXKVcZJD11hwd6PhQqacgD9dFbuv7eQksoNAbxP5oDXQXG2Ps?=
 =?us-ascii?Q?Lgzr9uJTgsZKYiTVuUrghnHsPeltvljFMUmskX+nq8dUNWP1uqKcz5TfBwdj?=
 =?us-ascii?Q?/rRiVKIoaIggMuppQLwP17OTt+z1kSPxome45aGIke0QGrUuW83LaXHydR+w?=
 =?us-ascii?Q?epsqsSEF2ZSv9MXMAUSppMkxz3kT+i/yewglpvDcuk2hn0nEpIHS/LHfwnEx?=
 =?us-ascii?Q?RuXYk8mxjFFnyy59eFmv9XtG4ylqf0f4J1PShQQfDKo2bUAMP4IRT6YPO657?=
 =?us-ascii?Q?RsvadMuOWe990JSMoIeJnUSKTDTK/2gEFPsiq4WXYV9xHRbqogmugs8J0bQ4?=
 =?us-ascii?Q?Yn0VmofYVwv3B5UiMaOn9q9Xyak1eFcAMP7K6pUcVuYoQOCrCu9T6kkthdFy?=
 =?us-ascii?Q?r70NjTa8FRtpZbEPKnMzVZ8jMyv9IkVs6C559T1NbNKTN5NXkgMpfWNL6SOU?=
 =?us-ascii?Q?Ld8jzc25Tz34vFLlaXQTRtZinXihoT2wmXUlUYsS4v7d6ZoNFKaeERWvw6xR?=
 =?us-ascii?Q?YZw1gYhShMBTezQB0APG/lzfowJPIkXvSp2PguqCIE0Tl4hHaRft7HUyJ1yF?=
 =?us-ascii?Q?0d/wAIdUJFagT6QqjExZcWH99/aXKvwqJrnWFEzDZkNw/lvTcrAB98rf1bOr?=
 =?us-ascii?Q?03KOf5rtV1/nf+XIegcjt4EmVE6nhrZzhYhlCxYVMo+Iy8og/ZyJusfp9neh?=
 =?us-ascii?Q?+Ivn61dZzdS+sVTReCsA75FqkKYTUnax+bajrCCJT051kSHlYcf2LzKCDwOW?=
 =?us-ascii?Q?YAEuhwsSVHHYe79hSMjC7GP8jhv50lzc6QCiW9CuDIMRGjJ8aaK7S3VQbcJv?=
 =?us-ascii?Q?k9cGUwT3/Ry9uNJlcP+vRcR4K9K7cQ+5qDMv2CO68dwusjOe+/1J/TI8E0jE?=
 =?us-ascii?Q?nRUDSDlCEDwWCyiboDmkUEBVCu4BDv65nZPZym/PmKtAUVL4GP0L+G9wps3s?=
 =?us-ascii?Q?3rRECC+Zf4FStFI56nebXc2cdp45fJ2huHEkuvkel09/HaXXdeQeVxSE35xO?=
 =?us-ascii?Q?UXP+MAudGeTsSCrl2EPOi29IgzlbWl4troTZSNueWhmefpLKSbk1WIktZnp/?=
 =?us-ascii?Q?sHutzg98OFbCZKNfRVrstSzBEg1sQYCTwx2rHrjqwxmKsknFccDZS2pxE00P?=
 =?us-ascii?Q?sTsSzKtvQd2FkayY8gE0sykvl3vcDBM77sbJDadkAUaz4TbjfaBalH4+2Oix?=
 =?us-ascii?Q?eM4pCeSfXOf748U0dBNbaZeArNGooZAua2mx4rOyxE7cqD5ucN1CO6ncSwxj?=
 =?us-ascii?Q?9LW77gD/KeHrVNObWFpaglWIRZFCN2xeYCyXZwVvnuMiQoDfcX4IR3G9NFsL?=
 =?us-ascii?Q?NCbt2IUdbt2z6NyvzGC9feyJAiNL/DKbaWQUEPkZp7B9301wlBHhbXWPrNo3?=
 =?us-ascii?Q?AWW5K2pUZfGhwaKKn5yRM+g7TadzEW1lswF0kH62b0VjBHri3jzXY54VKwPM?=
 =?us-ascii?Q?/B54WNF8QcD9ZoWutsgCu8IlkF6Bs5XgEq48KPIzW7268J3QSNLuP7Z7/SNf?=
 =?us-ascii?Q?RQgBDOollQ/ekrkYdYV6W760HfQTqXd6UnSfGHKE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b950a7ce-f80f-4776-45d8-08ddf387db1b
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB7957.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 12:11:38.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s6sedeguzwaNgcLufcRtcl9zgqS2Pzzgow2W3nPiLpkkLvMhSZmu44mdBZ+9LNXmsrvVOMA/uat1lqUd2Gomw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6226

Introduce a new superblock operation get_inode_wb_ctx_idx() to allow
filesystems to decide how inodes are assigned to writeback contexts.
This helps optimize parallel writeback performance based on the
underlying filesystem architecture.

In fetch_bdi_writeback_ctx(), if this operation is implemented by the
filesystem, it will return a specific writeback context index for a
given inode. Otherwise fall back to the default way.

Signed-off-by: wangyufei <wangyufei@vivo.com>
---
 include/linux/backing-dev.h | 3 +++
 include/linux/fs.h          | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index c93509f5e..d02536f6e 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -144,7 +144,10 @@ static inline struct bdi_writeback_ctx *
 fetch_bdi_writeback_ctx(struct inode *inode)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	struct super_block *sb = inode->i_sb;
 
+	if (sb->s_op->get_inode_wb_ctx_idx)
+		return bdi->wb_ctx_arr[sb->s_op->get_inode_wb_ctx_idx(inode, bdi->nr_wb_ctx)];
 	return bdi->wb_ctx_arr[inode->i_ino % bdi->nr_wb_ctx];
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c07228bd..fad7a75fd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2491,6 +2491,7 @@ struct super_operations {
 	 */
 	int (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
 	void (*shutdown)(struct super_block *sb);
+	unsigned int (*get_inode_wb_ctx_idx)(struct inode *inode, int nr_wb_ctx);
 };
 
 /*
-- 
2.34.1


