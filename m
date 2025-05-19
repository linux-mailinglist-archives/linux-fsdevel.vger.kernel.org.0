Return-Path: <linux-fsdevel+bounces-49434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFBABC489
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AD9189A667
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184392874EF;
	Mon, 19 May 2025 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XDBl41Hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013042.outbound.protection.outlook.com [52.101.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8531E5701;
	Mon, 19 May 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672321; cv=fail; b=JBu5FTBOqiVpd2fxfEB+9wQwcqOoMOjZPJ15kQfOeQBvC3Bn76hZ+eHsvH26k52A+09EoYoo58PZrrwoInKzbZAykU3JFLFC/wLiU8LEkFj2LxHoeIfE4RlsG4tBUfpD1DWiciRnx0xbfNaaXE0RTX9AYQQHu1ITPwN23iHoZkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672321; c=relaxed/simple;
	bh=4+f7z0hSLJb8/peuC8PvcZD5IrCKyfzH81F/L1MyNUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f7dFyizKW72M4kjQwkHNfvMV6TzBlFeBNhOtmPbtO0ZQCox6/PC4HIYJEzb4q6RvVvY9rfgM2CyBVQcHkkANWN9c4wjAhOK3dF7MFdmIdIfCh3eys+B57z6k4hEWsvsNgyDlVHlFsWztRxMzPfc0hrpD2Dcm+lkiaPcOrp9jNTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XDBl41Hh; arc=fail smtp.client-ip=52.101.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc6eyNJrr5LNtluHnuWvcTlNsbIfxXrxFTRePtR4QF4nQJTegl+hMsUQb03UnavbBeLGG49g4jbCK5Ssr80OdP/KDaoaTmrdsJ3Efhya/d+nUpz9hiYa5qZh002YBEJaIewAxU6ki6jloabYZB4WjGHgqg8lMortWKTM6RdGCvq73Z6118LleKkpdWZozwFvzKMtqpCBHGTdzDUHqjT3VXYR3CFWWy8Oer7dQoPSbGGz3vx3n1LifUioY3t0pIUxpQF96cX6QZrA5rGn1Mntik/K8Q3XEsiJk2ErG5hXFG1mAhMPdFNoBzyJhKTKzKzxhv8pmFQVrmz+AuY/YNwqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEMsBrEHWF/13rxqbkJJ/oRGRV+5X51l/82wUQQOKeI=;
 b=aaSa9pzE0Gp1TXeJ8meLqkTi/9AMp1MDGAWi9/VZwIBnrH2JXVZZrj8jNwyPZ1Q0VdYmwNKtSJ9n61EHbTl+RqOPLPBhG00D3tZywe/FVigsqs8xOlzjjhXXk29OhXx6M2L+SJVkjmDK1Z8qlV61l3raAZHhIRguvTvglx1HZzxXtR6hAtzITCYQnlS1NeWKnw/hpoX9Ey6CDw+Sss9xbEXiU3h8jNmQ0LNrgb9Qq6cNBGdP5FmdVEEJ+oFVB9KlcOo0HJ7/UZIFFanB/y1RJpPkhMjlZEBeBQHB8usWfixWqquLoTWVZnl+xOaFUjIObkxVHYBZn5sv/2eIOVDXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEMsBrEHWF/13rxqbkJJ/oRGRV+5X51l/82wUQQOKeI=;
 b=XDBl41HhCuRQ+LVePiLoO2r5tjydDWCvFT5pJv+rDfFkN+yxO+oBT4sskv2niJDkbQxTrKL2JnzAg1I1Dv9HwtOoFggyq7HaHW7BlKjsyOwzRT4XxoISixHYuUTlEXEcpZ1siZfmQWPmE5ZUQf/ArG4rd7Cg5ewQC5tArjTndXgWi/hUroWdx8aHRLXeJOE46VQKl1btR7jJ5z0o/3O5uMKQWhrctZ0lSKdiZz3qg3LrnWiBNf9wpRHd5KpjfG1bBcp+2UuIuGxV+l1WY63yi098VY9mmeEhXKE9QAmJ4HpqQy55fJTC6cUZ1MZFcqbkNUtv67tR4j0TSmFWlSo8yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB7029.apcprd06.prod.outlook.com (2603:1096:990:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 16:31:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8722.027; Mon, 19 May 2025
 16:31:56 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] hfs: correct superblock flags
Date: Mon, 19 May 2025 10:52:12 -0600
Message-Id: <20250519165214.1181931-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519165214.1181931-1-frank.li@vivo.com>
References: <20250519165214.1181931-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0221.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b724ca-c16d-466b-72c3-08dd96f2aba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6HS2jNJ3UBJXf95GmlHQP/wEf+Q7Ckx9elkA1ovSCth0y6l0YVm7E0KqKqOg?=
 =?us-ascii?Q?LEuEjvK7aFHNbHyCdqk8ky4gXgbw5ZnSgVrxoHzrC1MOrfLe82LDDpbJ9JZ8?=
 =?us-ascii?Q?eaOt4d1hoCSPPLmKIHTJaHTBNz7Dd/WNKJwHZLGW5wq1U0fwIdV86EQSGs1G?=
 =?us-ascii?Q?OQ3MJ6/0PW0vrt6fpEEi/97sj6Q041iicAVONoKBjtvnIMXHkpL4QXVPgH8X?=
 =?us-ascii?Q?xu1AvTD6ru0FTI+Il72lAbQmlGBzIlnvZcqhtpiq1ZsVRdwYJK6Rn2gFlikQ?=
 =?us-ascii?Q?Um/DGoXdsElcjyIHxGRO6PL/S8ULPWPZepPchYelQCRLbVI54+Hel1L5t8Wo?=
 =?us-ascii?Q?t6IKjhRta7oMIEVob5Glmsrbj4vLzl/kx+DFwerQsFReQbxyj97B62K27855?=
 =?us-ascii?Q?3PLyNEwWQtK6/2i0qGin2HbP6R2+r0tQtKNCPlC3CuzvPKlD/fVdScxbjCQc?=
 =?us-ascii?Q?nJxIOdyhIyKk9v9x3ebBmwZMqLczRmo/vS6Cs2I3ZoiDhuXOWju9fu1RDCGN?=
 =?us-ascii?Q?Lsm7tt93xvmueHzTBzV/oxqArjkxVUGTnUNma30PkbOeQlsXnry5tXEGj0MX?=
 =?us-ascii?Q?OW2cHEzvj1I693Ag+AxF/0kYoKvI8RfJrP8n+/5vUT1yi6sWastQRfBPegWG?=
 =?us-ascii?Q?0tQI8I7rVS4DCNjXdDGuKbBCm74krJ7zoXQUS6HXhrJFnX4ZbUCfJ3yCNmqn?=
 =?us-ascii?Q?im5zPeMAsi3aMyHRlZE2w0WIXPFRU4jIq5SeI5DpyI1xoOqTfApmZN6Ukck2?=
 =?us-ascii?Q?ujvWV3gGAQSxIxbWiRoMWjsuJKuz4CkTYEEd6gbmAZNVO4FHTnpyWiCG6GvK?=
 =?us-ascii?Q?4C/YJ98QI+v7oc3CyllLADrQCNIev1lxKRHScw61PCo+eB7Rpr/OX9LUAG9v?=
 =?us-ascii?Q?Va0MGGJM4DZQP4Qr6Wt87mAO7UBSnGMV/DSiNmH+UYwIknaL5kJmPqHtdo5n?=
 =?us-ascii?Q?BYjh8mPiPOasSb8wI0WNneZk0QyfhC0CVT94MXeW7ilokQNdJXdu2lb6Q7cG?=
 =?us-ascii?Q?pjmXpGxLIOJS0vG3w/J+cLr5HltqrvyltGABi7YDB39dP4Ly5MzCXtnIFzS9?=
 =?us-ascii?Q?VA5IEllYYEE/k1IhDejpP9D5MXIlEKTvyW4Q6Jc7xfJymJJct/MyXjzdXQBV?=
 =?us-ascii?Q?awIGPQwm8afOlIrk7q25zg2YvLqy78gnKvj5cCBTHN2aXrhUmdbPAmUj0M5E?=
 =?us-ascii?Q?z0fVnrgV1tyOxXv57aATaPXJpdwpYeRwOFN8WDiXr2uaYoe3avL4eINdtHYM?=
 =?us-ascii?Q?5i9PTxQzoZwQVtXhOfm+WylgN29W2vz+/iVeUJGGY7S2hvR+7pY3a7esE+gi?=
 =?us-ascii?Q?WriMeLlFmllwYTaNl0AnjvqB26ps60DxvswR5vX3JtL9BEpQxcCA9Djmxgio?=
 =?us-ascii?Q?BcJSn/gjyFtaGCEKyIJPjJPVs2Xg2uklhZSiRg8c9M4JtEKiGHJ7gMxfc21H?=
 =?us-ascii?Q?6QCSJGvgxliJbIqCZj2l3g8BnPNuHQjW2vHxrvTlI9qULw71ybgYIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fVYFy09sRlIxUh8vAH9KxDVQKBHVNUMLrhJXkHN2bg34Cfh+VgSD82mZdEkQ?=
 =?us-ascii?Q?XlVcfXKc+sjBFn4h0M/QM1sPijAyXVAdNS7XiT2X8cXPqgmH0iIJQMfwOvuY?=
 =?us-ascii?Q?+hRoRlHOnHEaGRzGBUqZbsBAZk1C027YOPOrt/OLX/5PODpmaTpOY45FMExZ?=
 =?us-ascii?Q?tJWG02hVrq0y7cEjCk9DMLtZ9RBO3mq2KDKuGbtwOQoeDdM6aU+c5xagDE2a?=
 =?us-ascii?Q?R7nfvBnLGw+z2XZ9dHGlVldm8w07DG2DcKEaMD/SOtstxGHitkN33SA0+X7b?=
 =?us-ascii?Q?3wsd04NjWMoG7CrXlIIZ8VD9+neLP7Gq/D56HRg0A5uxbIotKdKx0mHbOEtH?=
 =?us-ascii?Q?EbTkDsxoqcjq4TF1fxnNKm/Ugz4V9QLlqVoqFN5kXPvSomoH4bigB4msrA30?=
 =?us-ascii?Q?emI4nLTKTI+PCQAmmyZvpTVuf05NAFyFqjeL0dFxqA1wOXtOPmXJyfPik/Ta?=
 =?us-ascii?Q?K/eKVOw0dTgwAVFw2C2irWFzJRimsoy0L14zpKjDI1yRvn753Yp5dyf4ot/E?=
 =?us-ascii?Q?UEgYNTOx3nlrAlO2jOsixu4+EoC2HZWUnwfFhk8kxFtXQr6A7zw/dW66306g?=
 =?us-ascii?Q?Uk9HJE3b0bnTAk+7tKRPWmeSrSNfMXEGuHvKjf+wKbQt3l0MShagwTScc1g4?=
 =?us-ascii?Q?m/T9WGUd/rZVuskDbtB6/hNeyvAn2kurQjOLfpv5rUWRiLpQ7NEq98kqCkCP?=
 =?us-ascii?Q?A7no/juMW/w5fiP9SZm/kCGyMtTCTLx7QXEtjU7tl6MKe5Yp7u/kXLnG/ndN?=
 =?us-ascii?Q?0zRKhXQ6460le3hODEW2VVGapr0AHL0hpLUrQpU8Bldqz+4Z1bSVA6/J9AC7?=
 =?us-ascii?Q?fjRKqWKAHNZj0RilYnLVCaH4K+MaDeSTwpLhi5i5zo6M91Tap2hVDe/LSJma?=
 =?us-ascii?Q?hBCh9ddHTaDrW/Np1DDmUF7fmgL7E09zGFZFBSXb5SuJaR86GUpJNeoVDrBC?=
 =?us-ascii?Q?UfR72IU5/W6MOoM67wYD1W6dLK+xZ6n1KshRYVIdy/4W3ouBfhMmbQseQDf6?=
 =?us-ascii?Q?Of/oQX5TejPCLqDgHnD7ULQXWL9qTBREMSBPOAGXGz4mqfoekCDnzBWj2q37?=
 =?us-ascii?Q?qI2x0lRcN8fw0VI2nUepcmYX6tRH0/BC9uxKy+a40aPH3NZJwy7LenjqGck4?=
 =?us-ascii?Q?oHbz3Se8uJtTfuTDT7u8TKB0u354X52Q1AIUfjl06iq5z4Ug/OzYBnxs8NvZ?=
 =?us-ascii?Q?9b8yQRIYUJxFnX12fRcH2OnSupzJ1dBtRaCXON/YH1T4AsWaMAbSUMW1o/bT?=
 =?us-ascii?Q?1h+t+jvZrJddbJobMV+mXCRxuQXV/9k40t3989l4dyYT67A0WSnCBZsdOOYy?=
 =?us-ascii?Q?1HmCbTjpoDZyMg3U9EKftqNeDPmKXqQORj8DMK2QZWPsQBc5qxw6ojGqfDu6?=
 =?us-ascii?Q?MaH3jmgS+J6duiKRBHPgtiSBMD2UKlltLwqqcDVCJrMPl+rjmJFMob9zxW2W?=
 =?us-ascii?Q?MxFXOWCXfjq/u7Glh4m8Lx704J+LGJFiU4r54Nuj4AkHGAjhj3HJcFwPPkzA?=
 =?us-ascii?Q?bSij7kVqV0Tc5Xf0FEPYUBmGSI34e64NTlD93377ZxxzfgKqSezL3mpUQ3Ql?=
 =?us-ascii?Q?JTOo169z3zWiRBcP3emvByHnEycGzIPGncEc11Jt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b724ca-c16d-466b-72c3-08dd96f2aba3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 16:31:56.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNuVxaRwK8bdipx2Ts/qPPX8s9KKg1aRtd8V+oue4VvPZn816qybgljMOA/tU1qUzRDsZkMioyaGjAYIkLOFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7029

We don't support atime updates of any kind,
because hfs actually does not have atime.

   dirCrDat:      LongInt;    {date and time of creation}
   dirMdDat:      LongInt;    {date and time of last modification}
   dirBkDat:      LongInt;    {date and time of last backup}

   filCrDat:      LongInt;    {date and time of creation}
   filMdDat:      LongInt;    {date and time of last modification}
   filBkDat:      LongInt;    {date and time of last backup}

W/O patch(xfstest generic/003):

 +ERROR: access time has changed for file1 after remount
 +ERROR: access time has changed after modifying file1
 +ERROR: change time has not been updated after changing file1
 +ERROR: access time has changed for file in read-only filesystem

W/ patch(xfstest generic/003):

 +ERROR: access time has not been updated after accessing file1 first time
 +ERROR: access time has not been updated after accessing file2
 +ERROR: access time has changed after modifying file1
 +ERROR: change time has not been updated after changing file1
 +ERROR: access time has not been updated after accessing file3 second time
 +ERROR: access time has not been updated after accessing file3 third time

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index fe09c2093a93..9fab84b157b4 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -331,7 +331,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->sb = sb;
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
-	sb->s_flags |= SB_NODIRATIME;
+	sb->s_flags |= SB_NOATIME;
 	mutex_init(&sbi->bitmap_lock);
 
 	res = hfs_mdb_get(sb);
-- 
2.48.1


