Return-Path: <linux-fsdevel+bounces-56855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36ADB1C9FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBAC564991
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD8529ACCD;
	Wed,  6 Aug 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TkVOCZH/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013061.outbound.protection.outlook.com [40.107.44.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04B1A23A9;
	Wed,  6 Aug 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498978; cv=fail; b=Y+WOwBNFf0dpQ1IQQc2BY+uETAha1iFzG7jty0C4OO83vVIq8CKQbtrgREWS39xVWOQ3hzR7AVCszbMzHRXHD/0LN5Cv/JxP612/t7ug0ZvFK9J5vmauBnPEERcGN6n+wwI8pg95uUCDzjlhaLa/c6jvqGyCSd4NKrm5ONHsSBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498978; c=relaxed/simple;
	bh=/Us8ykyFWwShrdoHkRgZPFtFMBNkf7mJEj/k9hy8WTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MXfsIIPBHLJ/UF6Z19szqpvrKN0q2cskUMiOfbQQrvSgTZmDmM79MstNqrXiLXi8tiFdx2YWYJePMAu6VuNlLfh3rX0zB+h7xMVQ3jWimjTuxJRDhAmO8HyNZglh8ifRD138meL5SKhhH7BcRwiF/FKGLITCKfuAJ/phgmCgMDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TkVOCZH/; arc=fail smtp.client-ip=40.107.44.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM93CzF1vGRWxqqNBCyEJzKNsR/w2pxgbknc1+C7rXxGoVnr7Fy3mAfa4lgiaQ9/DcxJZO2J3queLgOBc0kuR8VaK47/bixrn6QPdqEZMlWAC1lUq7uARoA3ZiK2rFoY9fv++tl+weT98rDn2gFuflwfYAUfKjF0x+U2Vs6/+MKyRHu+hVnQW1RKbW9SCJeohDXaZG0MhOztpMhFPzq+AV7VvMvxGAUDZQcaGKv0/lK+khREIRbCtQt2K0TrBEuYXl3WZNaQlyFUBk0CWexZ2Q7a+hE0Qo22zYq1EU/B2CdrtSP+2bq1/ZOR0mIWONVZ9pwzyKHnGF0JFD5HEmsnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dsf1rVye++W9uOzLozgqrZnLU4frjnDv8RthXX7DU9c=;
 b=UPR4r9MJucSTJD7K9FkAaHXeF2N/z3FT6C095qC6SMeQPcIriFlQMbVRrJZzqy0pGj6w/qZlIRkGqSXdE4yx1oKeLR7PyiABq7W5DGJZ/rV2FweepjWkq0vRNfYFrYobH0FVHmdMnAAW/sU3ftIDoGGel4SgzelqSe//79jbqfgwITZl2NG+GD20K2KIb+UgLyhzTJlvLO4zT92WDH7nwYC5Cyzk72OTSS761RB0xXqlocO0CDkIdVOKUe+T9Qu4DDjsYd69cPYF9+q4eq9ubOVHFbb6zmuajLSNMXwRcf1Efmrl8ccNfaAj/Ez6fCEMzNQUuIcjgjlEigiuc9yYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dsf1rVye++W9uOzLozgqrZnLU4frjnDv8RthXX7DU9c=;
 b=TkVOCZH/zSwegf9f/yKWvSlL4aDk5deG3Ilg1Wpk07rIKc5MSWlOPsnZY/kQziwP90dwRFl15RmgNBE0ebEKHG3e7odyF77Hs7Yo/ZA7Kw7XKizNVFsDlpLJkDFY3PbM74scqUH/IBuYmd8VYh/eU29TQxpvjWxcMjLXAd5ETxnnHkycZiHWcM2eGZiGqaTmlQX95DfpfKV0sQhFPYP80cIpcCosHl8zD10GMRB+aCkHCFebXB+Tbggs8wl1fCCexjypbbFPitMZqoER4niwY7PSEhUwIrdj3HoYcaEFH7EnACgNsli2/340Dy1dSH32zs21Lvbm/qqiGkRwhZ9krA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6337.apcprd06.prod.outlook.com (2603:1096:400:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 16:49:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 16:49:31 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hfs: abort hfs_lookup if name is too long
Date: Wed,  6 Aug 2025 11:11:29 -0600
Message-Id: <20250806171132.3402278-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba209356-21db-464c-c8f6-08ddd50936b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U16U7hi/h2OVF30feGCS1kTvf0yz14szp7tet6AU7w7dWvsDuPKwlWQwOGYV?=
 =?us-ascii?Q?DjWbdka8n7SOJ9ZBl8rI+627ByvWElpcsoCkgJw+ZeG1s+wsifHFChkIGmW7?=
 =?us-ascii?Q?CrLRkp9kJ+mF0nd0XlUG7DAa8clBsx2RTTmhj1jpvgJP/YsbLXe+JnIhUpz0?=
 =?us-ascii?Q?lAKbLKTxBBhrcH+DVGFCxGyfhsoBCFrQU/0KKKpAHUDe57NJZRLv/G3JcTyh?=
 =?us-ascii?Q?7oMzAVAdotyhDjFPAsZlPmMr9OHQlSnBvCmaT42fu5uBp9Hdu1+TRIiY2J+/?=
 =?us-ascii?Q?yaqhM8AEVjzt5QLfYjsD11WxdBv9WAw1cdJyFtVq1nAsW3F0Qqd8T69cV1tg?=
 =?us-ascii?Q?KgQJxLiBAyEtX1JRnOQPK8tOSja1qbL1MOQuLuM0qNnoobXroXnN+j2t0a6x?=
 =?us-ascii?Q?iaRhoYowtD4MWwT6UUOxMKOUeyAWngtKv19qUuEXrWv9fYTF1rnatjACdrna?=
 =?us-ascii?Q?joJ9X/1k0xbLwffvur8jCoMIGFaV0FXnxzK/hiK/SFHKnfxxyFZYcaX20n3v?=
 =?us-ascii?Q?B9FynliivPt2bSOCd8mqV9s93ntUiukUs05Rd37Qk2o+YZgyZJdiMcOEpgEw?=
 =?us-ascii?Q?e2/Sa/C1V57dB/vQ4w5Z3XgIEUhiip0E195OG65OcjUWC50jOebJ2ZC7nvwZ?=
 =?us-ascii?Q?9HDlHsCM/DONVyBrpeMuE/59Tpnv0a00J2Zw4/FxdAxkqPUtTbr9yta6MbMd?=
 =?us-ascii?Q?H8rEawFDT1Cm19YHN/KfpRZ5QbrEpmaa39M6e2ZeCyQbSIHW/mvjfDqrIpYw?=
 =?us-ascii?Q?S5HrkoYnoCaR7EIwX+0Sot9GZIuaXs6AUUFbrK0+fIv9scqOb3AOsvKsLcbq?=
 =?us-ascii?Q?U1H81RikPvdAIj5lcaGwk0tgAh2lRsiUKnsnTt1v6A8X+M/GXUYm863bossa?=
 =?us-ascii?Q?LcI5AccPp8jAALiQSw2FcgUoDojFMqe5wF0WmpBHbMuxvG57/yU6xRr4BblX?=
 =?us-ascii?Q?Vf06pSbfWTFRP5BLAEH8CeyxTRvQQV/ViHySFogUN/FgUE/Bra4lpvusKo/J?=
 =?us-ascii?Q?7ginLL4Iv/b1IqfK9FNQkzcxpzm5FPpxgp1fwsgNe+ujBPtq3gTHlqxpM602?=
 =?us-ascii?Q?JtGGXJRn8fqk0WjSuho6S+FJr/cToPiz6lyuiNKgZ3BYY1dl9Fq3BP/NJtxi?=
 =?us-ascii?Q?wNXt0L5hV6MtFccCtgIQ6IHRRUAFqCwsJrMT01mEuk1MVyCTwRSk9bnhEcp3?=
 =?us-ascii?Q?WqfQhze/uSml5I58r3vnD+vBTWCbT+TfI0ZKxNFQv1kAk+4ZMHE6plZ0NOYq?=
 =?us-ascii?Q?5AheVAh1g4WEoE8lsN/5Ymb8RcQ8mM0I4QT1i4wj8mf5Bk4sdlJCpkNxkwkg?=
 =?us-ascii?Q?3yWqDt5Fc+gREgkVmjy7St1i3aHXAxPP0/gJES/VhcfXa5opeUEMVBDKM0os?=
 =?us-ascii?Q?AziKHpUE+/JWHQNVRIRnyJ0HjuzjBUYys9oXDr88phE2d14NV4AdrnBWCBdO?=
 =?us-ascii?Q?KYPYgwfY7b+3t8GOGcwx9PVGhaj7no/06iVVunHKvtwJN3ll4nG9TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgv9EF8DENUF6gi0tmb/X2jpxn9LcmcDUTy+8lwVHvS2pNBSJ77qvj8uGgdE?=
 =?us-ascii?Q?KTJgCS8bEh3lcvaletyS0YIJoyC/g1gN4FWfEQysJn6rk5nlprVXT8CfTqnp?=
 =?us-ascii?Q?6ZTnKwaIeBM07slLgDjGhmr1QCucdqhUUiPKwyXvEbvkVPtUKEs5nnKn3c6Z?=
 =?us-ascii?Q?xTGCuuQIpZQSJM9c6ldlUcl/f5wW4Jouf3E5xzz7TadaQCJeiYiQe1yqwFcN?=
 =?us-ascii?Q?woWWh6wZgNTz1fcCvgixfDOAsGWQU/pZerS6BZEnFSclz7vW1TAoD15mLpSU?=
 =?us-ascii?Q?0LIWToKnKQb42u55VmyVs893h7c865iC57029Ph3+iO45YQAHPtQAhYDkzsG?=
 =?us-ascii?Q?EMhSD8xVFtTm6usedfrbpoE3jKC9GGzEd37zm994h+De+X0hzHWmLmAx+8nm?=
 =?us-ascii?Q?8aoI6l2hJuUyfT0cKElmpVRF7hxO0rUpV8+KYBo5ncYIYul5/kZpiMas/BNZ?=
 =?us-ascii?Q?biWLs1RSlrZDLCg4rHgPj1KTUfbB1uUXR6MZHMp5UaHGnVh/LziS185rnU0/?=
 =?us-ascii?Q?kfzXLCVMP8tiR9vSK14xWZVZdS1NmzD6kWMp1RAu1LIVDjQAj24SvbzpxN94?=
 =?us-ascii?Q?+EOmEycEHgZYyYGgQXsAkpFbaX6Et/M8o7+FkjiP8gapl+25MlmGZ6urJGOj?=
 =?us-ascii?Q?JDFpkq6PgNhvl+5ID3dq86cY27Z/v/kXzlPezkpTKR+DjwCOllYZYkkzAOdl?=
 =?us-ascii?Q?Cu41Fb0zRxgnXS6oXchnlNqWDXORo2dJyY8JHI4bBcD38qs9ry4QsgZn49aH?=
 =?us-ascii?Q?Z54W8gVLv7wTaiegiyhBO3R3tBlL2P3Ey9jByN5FZdVEWNwAFDbNWTk0WNrq?=
 =?us-ascii?Q?ZIzRBed4SzaMGdoC/WKthhrRcW/SiOZTJrHWsq1WS5ZSV+4Mx48DcTSm78bs?=
 =?us-ascii?Q?8GGQM5/cDbgY+/jIhr2mbQpFdUN5sejlseBncyhfCZgdBL7csnaDtv3ppTY2?=
 =?us-ascii?Q?M6yLYg1FNPMLvy+3+fK/xFtSKHQBPo+vHXD88lvOHgMXwV39pj/8+gCh9VZT?=
 =?us-ascii?Q?2EDXtFvFdLEqdMcbhY6yXsBj75r4fnKTm5CzNR+PayUysOOsMdrWFN2lYZp3?=
 =?us-ascii?Q?yNul3UACEiHxoR16oS13c2UbfZvDtJG8L6O/P34KjMQ00gACb1PKkoZgTC+F?=
 =?us-ascii?Q?QSDD0qddnC0ONJd1sYbz8+rb+7/TMdBBiF4LUDvl8lWGvBkpOw+Hy/duiR3D?=
 =?us-ascii?Q?o+9td+PYA4Q7Ij1oeCbU/g9wly5M7hv4Cy4kYg8Y1DOKYTVdxldtu/KLz3ms?=
 =?us-ascii?Q?rdqVaJnayuid6Db8+k6RY5dzElGHAMy77pOEwyGiuuwh/IKx99Wxf8NjVKVx?=
 =?us-ascii?Q?QIUhCKRW7vXxYKwUAXTy1Z0RcmAAHi0DYcRuQZklz54at6YQhmuSXRulMiRp?=
 =?us-ascii?Q?gbabX03Ok8XGKLI+PeMjzq2bsrXboW+CAMIC2nGdeY9jtmrx91lqOI9QExIT?=
 =?us-ascii?Q?yI/xGXqVNJRCRUfUEIMIetyax31WU97ytQ9hsCcupLwYrpSDqPuVzFGzyqD/?=
 =?us-ascii?Q?boVs6cXgANPBbpQaypS0jrdEeNvYxHEklGJZgaW78e1I29FAMZDy40bqHTNw?=
 =?us-ascii?Q?8r2zaSP+g9WMa7GNlKeDTf0jJoJEI0AKP0SbL/ms?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba209356-21db-464c-c8f6-08ddd50936b2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 16:49:30.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2HKQK3V2E9Um1tjhsybCL0YwJAohEyQhPq4wkldZP4e8coqJOuZye++xtyRbS3IBzwQdEeWW17bAWM9FqdmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6337

Long file names for hfs is 31 characters.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..30f6194da939 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -25,6 +25,9 @@ static struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	int res;
 
+	if (dentry->d_name.len > HFS_NAMELEN)
+		return ERR_PTR(-ENAMETOOLONG);
+
 	res = hfs_find_init(HFS_SB(dir->i_sb)->cat_tree, &fd);
 	if (res)
 		return ERR_PTR(res);
-- 
2.48.1


