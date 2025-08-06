Return-Path: <linux-fsdevel+bounces-56857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF590B1C9FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A30564A98
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4D29CB24;
	Wed,  6 Aug 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fmBRaBt4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013061.outbound.protection.outlook.com [40.107.44.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FB729B77C;
	Wed,  6 Aug 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498982; cv=fail; b=BCEWlFMcEOudl1jbdVqvhgAwy81h4U/MySwfbcYf9OFN6HQ/txb/58oUvqM84at50kUOPoTedIQW8ROlsPqfi8b75MB3U+WZXNxekt7Kyv3sJjNsVSbpZuPmqW8eRki9YCmNAjd1PaHED5Wt6ezikTr+6gaP5q9bNX+wxBRi54s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498982; c=relaxed/simple;
	bh=kGtN5H/X7TSq4Bml9NU7QFFNbN+1Wt7baZjsoRbW1OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qg+6XpnPUXc8T/dbuzmSxU4nBl3wBMIIgzR/Ei6ipLMoOjedJOdJXhyNDZ+Aq5J8MqX3AZo27cx2MF0CfSjy9Ck5vi3iQttg9AVMvKZDsU3jwQ8obJ9bwlCXQWJ5nWjPfpUlep48Ka7GTL/+W8JFh0kYF6JG/qE8nPvAp8JRVy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fmBRaBt4; arc=fail smtp.client-ip=40.107.44.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsV+vR5zD6cqF3MDOm7e3ioJGymqKYblwFWA8Z00FmXD8dM4dmhlTPBJdbOz7ZTcmM3q6NzxowCFEySx3SOxX9ors364IRu8owMkMF44pZjNm/LMVGA5JPr3hKQbJSZQLLWwc5sWP7loa2BM9jOJw0PropVtatVXAacTaAGsj+KV/Yty6sc2ppgvg6pekX1eNLAdn4/6E8XhR+GoolLrXPoVGW4YXYy0WPPbl+km+mjLMy8HgTKkIOsyopZh6liLBgPpVFwZnm0XDUCNAF+sUjDdlM5tO4zdcOTOHaSXlKiLj9OzqXE3v8/ckPfut5BkyEf9xY7zz4ZgcuEGraMIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbEe3kWcoXHK3Hdr68Nj9s6YrCQw4O4FG9VPsl8zPqE=;
 b=gMDp/vlN0rMOqxlHx2iQMSES9/ls4/lEzgWFV/bjB4px4Ny8KcKjRAz13bH7uThuDsc6THuo9SK/GVGGGAFmOR6YiOtAjqp7nIHKUIbfTu8wVXIsuMZQLAxTvPQzqYSzSqMtU81Lk5WB61rIV2IuBWNg8wueVcTl7ASrw5ZMjZ1EUeKWCpc8EgFJPRYRgo25rcfT6IUjHV/hWlQwh0Ewf1b+N3JERTurFRSezSAsEE8A58WhrgBazw5ukY8n122F1O9DFF4FlWVQ87cxV9CyWxJAdjsvVybzMkeGnPHQdfse27nBc+5w8ac/0XKroiYVPaj5iryne53uwAe2Z1OiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbEe3kWcoXHK3Hdr68Nj9s6YrCQw4O4FG9VPsl8zPqE=;
 b=fmBRaBt4j1779YGT6rzCNr9RAkBUnTuTGzse1WnplJM3oh7NvVxTS0KlbD2ehO0GsWTo7XlY0moqb4ZbqyWWrOQxWlDSm0haxayQ5fp14Mo5zgn+a1jfBUDO3aF0Lgm36VZPz9GLwC5M6WfcUad48NAOxeg8NofZeE4WBN/vJh4UnL+lOHTkiMfSYwmR/ZGkJSWscqq+CO+FLQQeVg5kyn7PdKX2RavCmSNqLNyzmHV56Fr9QcKRO0xHxXxG7WyqkHm0uWjE2Ds2M7tHWqYhr+cPZ/jJ0JTK+ljdl1EAjtMR9HcOQG1IgJ+/HJtBVuQ9aEqG0UFLuQBqbvjWEkANrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6337.apcprd06.prod.outlook.com (2603:1096:400:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 16:49:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 16:49:32 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hfsplus: abort hfsplus_lookup if name is too long
Date: Wed,  6 Aug 2025 11:11:30 -0600
Message-Id: <20250806171132.3402278-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806171132.3402278-1-frank.li@vivo.com>
References: <20250806171132.3402278-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f36da7e-7b26-435a-88e5-08ddd50937de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o+HMJh6foeKZ2w5ifkRgmk6yap6gPd7nchIWpl9ZqtNLbhefpHb1Ai+UFyc5?=
 =?us-ascii?Q?/jwf3D5xMlht9LTon0nxOCV8b/JYDNjMdJcmuaERyjxC578bHIeEO1MFB1oU?=
 =?us-ascii?Q?JTY+4DyLRndOBmKZjRLnZ872u3PdzFEROXv0YHDgeA+tOorAN2LOWGck+K9r?=
 =?us-ascii?Q?4W4rmSHCRd/Sjrbi9pXrh4qmRkgUm/1WkY/LzFDSqXFfvKwOLm9/CPcIyr/U?=
 =?us-ascii?Q?a9Xn45B6wv+A3bfX5wUakfYQgmsPnikOLeIDGlNe4f5UvB7hMtWQnON+8l+r?=
 =?us-ascii?Q?L7lSiP6eH5XoYub4mzdVYetgVL8xYhEywcT+3n99Anxdt+nJcIAY1XTVALWQ?=
 =?us-ascii?Q?qsvI6epRhlwJUU0oQomEsu4na03e9dtd1KB9uvywb/6DAEJ8ydaKEXeiTSoJ?=
 =?us-ascii?Q?DLIj1nSSNJwC9gJGHG2rOGnGMzqycaDRywZF7itcUZfMjfTUkkinnNODPYn9?=
 =?us-ascii?Q?i4w+nQNqLu5dgQsrkw/Cu7+N9qAtWBsqAX5JGgkxcIbQiJ9Ozs2XfFltKIME?=
 =?us-ascii?Q?spaQzQWlrjBm/Y/6rAnKUxP4rzRkaQxJ55wYcytO/E83BHrzjBaN+kE3fGh5?=
 =?us-ascii?Q?pTXN8zzGNobl7sID9WIbiXD5JnkvKhCRXEU9Mr6fED6HMow54gNOqdDfUfBm?=
 =?us-ascii?Q?bJs3spHU1nvqWJC3RKVnv9e30MQSl9eeo5ggszot4Q5DgoLrJtetdz2aVdqI?=
 =?us-ascii?Q?sO/dcHO4LMlxXjBeMnDGohIV9W/gY7WvZlzf1qV3X8gXPqek6faJj/+wkX1M?=
 =?us-ascii?Q?hnnjfWM3oriXtWpc0C8IULo9TMR9KBgKk3k63A2cWnib2cJt0wTYC7j7T2YY?=
 =?us-ascii?Q?J4pxQuPPZ7jTkXJbZQQYOREwuuG0LMIge2xpW2jli7ffKaTndm+GEBWgmKtV?=
 =?us-ascii?Q?HEhKDmIJ3wpXH/czg/omNrQ7Y3BWLGpNBPwhIwB0PEmhoS3mWwj2qDzbRytK?=
 =?us-ascii?Q?kWnc5Zyv1YQCR9X0NzCzVGIVl7AsE/w2a5uxfL0gNYlY2VE5E32Wh2KOJB/s?=
 =?us-ascii?Q?Kcbg/Cf2Cdage08tAIE0JTvokGQvgOG74APeMmkuSwp9TG4fEBwWob0xz4r1?=
 =?us-ascii?Q?svIN1mTxC5cE/hMA12uWByjqF78e1WiV1beV4vI6AR39gFsE0FcmIi3QVKmE?=
 =?us-ascii?Q?bzL0XKFceK/zQS0fYv8W0j7URj2MZRgfvfHUWh+1VMF2krZgciai5zmlOAYj?=
 =?us-ascii?Q?i5W+hM7W8PFdIQu9F+RmyGcvSTCSIwXEnuM6u0as6B8pSkQrNFvqiOUhDzJd?=
 =?us-ascii?Q?+m3m8OzMaAAACVQZoWhfOHn5p0MiQggdIkZG9kfpMyQ4JLryJ82jGXRVNBZg?=
 =?us-ascii?Q?XPk2mPzA51bdyfjdQ38Py5a988DyGsPDGHUZ4kygBOj28sp6PiCM/L3ZZrEA?=
 =?us-ascii?Q?O9F2aqEJU4PecHu1g1sgqeofmQNaemilU+/xvqerbfxq0CGRETzu778Y4Baw?=
 =?us-ascii?Q?O5qrmsWPedRBZWn+wq3FFR0fk0srI47Xj7EsT3Ut5q+xGp1QaNu+qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cYSfoPhdgUOsMYCqx5VC4yoKO20vFiWkfY95H1j7PWhALxTmuQZ5x0cRay6S?=
 =?us-ascii?Q?5UPWBVpvN4S0Qr5u8N6q1mU2VJmlV/YpBqpSgGUbMBSsYfnBwhQFcz9CjPLk?=
 =?us-ascii?Q?SPchyLGQkI99JrX1iRoMWGo1fW+VGEe/tr3F9qytbkqPVZovZXxOyWi4CdvD?=
 =?us-ascii?Q?sPgAUTvzquKzAJQzHbqsUjR5/0BgCjUjtZp/t29EaCtEVxwS6Y7m7q9cBMXh?=
 =?us-ascii?Q?PdzP7Rbw9hosSDJAk85LNIKGRNJUpA3K8asQGgFThTAHhPM9ZvzIzWH2QsIV?=
 =?us-ascii?Q?+c+0bEAaPG6CUIsxlOJX+G4ZioxDohSC6W4IsKnW9wMrN4Zsr6DpTUIXaxN1?=
 =?us-ascii?Q?6195FywMbUKVKnAiNlbHYAkD5LKh+f5Y/ynIYePjeiTmdCtZ2QkJ4qjdWcH0?=
 =?us-ascii?Q?B7iE2csHcQB/4MkZ6n7YfR81X7LAhm01B+vOYTE/4IIiSF1eZNg2i87UjLmo?=
 =?us-ascii?Q?GSxY+uWerQX9mJVgkzZoMUiNDz0Xln8rjS1RIDduj5phVHGZ9mmOaC9CMz/u?=
 =?us-ascii?Q?h3WdPql+Brx1zTifLfcpRPsXVPU/MmORFZLVQfeZlNUyzYFtOKyTOdM0u+X3?=
 =?us-ascii?Q?OLt3j18W92XbBEFDfslb41StGlJyT0QW0rCoyBKxr3XwxqZJbyJ8XpjnnUYD?=
 =?us-ascii?Q?enhHYUvqQGD9u9PE4r2TF/1XVDyVNf0vdvfjFXgGmraM0yHtCphvduwnofMG?=
 =?us-ascii?Q?jui3QFNf5oW4rgOeG7s4X4vspumZup4KSP0x0D6njzhVFK1mxhesB/NVMMfg?=
 =?us-ascii?Q?u+OH0apM9Qf4jsmuHRTXq3XVUhiApvfeynEVW6pPbsdbWkp93wTB/AnMcjAm?=
 =?us-ascii?Q?R5MjSj26dnCo5BKZ5TDklun3ydrCZXzIX33c/RoPaA1xBjVIqGaaOJJUr4KH?=
 =?us-ascii?Q?RMcAWdwohybjg1N1EY+1n+ENC4GcOrKg0XaE8jqXiEGAFEtsKRxzP1LZUO9P?=
 =?us-ascii?Q?MjZNFyoEKHz4YCRZ6oh+0cL53ztVtoQCdHD0lBs2hWLzOzi1OuMef3hcE17M?=
 =?us-ascii?Q?U3E5/HeJ5CelF89NbR5j9paxwO45ylFYROunKH+YfwOu7hVRSLBle2MBeYoA?=
 =?us-ascii?Q?KJi/LU7EqKqllnANutM359ce8zxitTuH79Qd44JIfQUydiMDPDVACNz/5nhL?=
 =?us-ascii?Q?OCSim7g+Gyy313jM2p631QH3lBJHRqGx3KRERl909VoT0u9vJMLfz7UpLgV3?=
 =?us-ascii?Q?/gwHGODhV3762xYyALeKzxMruqeWdZPhp4y7DshyrrarPXMY7kTCFA7eFMGG?=
 =?us-ascii?Q?/n4g02EBNaaj5+8DPfEZ0fOtAoTDySaIXzcjamymc/BvUtgX/aTYBFi6SQwu?=
 =?us-ascii?Q?iDDyo8XMAJuuOv88vl2E0iLQKwg9e68niOZFITX0t7wrAxLMSgg2Cq3loQQp?=
 =?us-ascii?Q?uQQPw+uKx7Jxxznrz6JhFe+X/xLroLlMZUUulPJDZW/4QlPQotREME0DpH2o?=
 =?us-ascii?Q?u5eWlOMbkoiS1os+bwcbbtODEoHdfXRcXqnfoxP42qyF5YpLjeWlfMnUr7gg?=
 =?us-ascii?Q?JXcenkPWh/rXD/X0wcGBTIQ9I8exWmghoqvNx/faE41MYz34TU4MIpvKheEE?=
 =?us-ascii?Q?mXy9daRo8V2VBUCdoNTjLbIU2QRPPHmNubex5Svi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f36da7e-7b26-435a-88e5-08ddd50937de
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 16:49:32.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bpizPWIIZEt3gp3FvnZMGIIm+ezCRkDUujVX1gLk6ei0J9OrsvBheBywCpLcjPqSSygqqP3QS5PjHQsaA8rIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6337

Long file names for hfs is 255 characters.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfsplus/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 876bbb80fb4d..d8fb401e7fdc 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -38,6 +38,9 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 	u32 cnid, linkid = 0;
 	u16 type;
 
+	if (dentry->d_name.len > HFSPLUS_MAX_STRLEN)
+		return ERR_PTR(-ENAMETOOLONG);
+
 	sb = dir->i_sb;
 
 	dentry->d_fsdata = NULL;
-- 
2.48.1


