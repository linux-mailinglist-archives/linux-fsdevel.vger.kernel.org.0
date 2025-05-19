Return-Path: <linux-fsdevel+bounces-49436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB6BABC48D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA617A6970
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11F288525;
	Mon, 19 May 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qMuSiPbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013042.outbound.protection.outlook.com [52.101.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92994287509;
	Mon, 19 May 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672325; cv=fail; b=U7VAVtnPlC8YFeSHDLeKJsVF/R65gGgG8iIx6QNLpAcgD4ROd0xhg3G32H5QMIzksCgDV3kM2S+naDUcCJBymaOUvF+8NxvvQNak5niSyiPnOmXjU1/2QbqTmypJHYO/1jv+mjfB+4a+XQfzePR/cNS4Acx6+GrsRN3xUQls3zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672325; c=relaxed/simple;
	bh=i42GsSuNuvP1aLmp3TW5ib5M08Qb7s+6i5htW1ywy7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y+Hf6fX0SOQglwmmjPcGD76cCKKHzCc397RAKHs2NZ8kmdLe4nkWNAtG1L5iIXQEBks2fANgWEqrM3f8RsMNLbVBI8CFTkEcx0vwGIaXPgUEB1XLAApe4xhC5NqovLgb1yuOh2Y3mj21ZdvoXWhuKyNDFNyNbTRdqAFY3drxEQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qMuSiPbi; arc=fail smtp.client-ip=52.101.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FE7BcCJZxS9yuh9L2oGf1Wbje9pw3bauA3XYAsiENwafuIk1inFmG+KDNeKYdmuwbjAlWZ2t/eouR9IEgDg0OYV8ssgOW3h8lyWsjFIRAdjuM1+Yq7IrNUZtKpCVYSEbvzAP1UrhpBIilLVbUWefPoIMkZUeUaONi8xO1S7YeeTS0TnO7uKeza0yVu2VaRKr+VJcmBoMFbttlsUaELxo+PPDLP4h0N9jSXq1qfVzN75QeI4Uft3Qb106D+yinC+DpIBdNzVTwORsQ9kLQ5z8FROre+Npzs7AbLO33CjMWyFmLZz8RLT6zWAgCTpZ4Fc8xCBT0+onLVs/fhk1tpRGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4DxMMmWQnVc5zzchMYl8+vtCkz3OstMDvL44sl5MjY=;
 b=LEuLK9jzO5cDltItq0+TM7d5ZI3XdKRo//orhRg27V04yfVVzAcX8y9XtX8VpPFlm1zi+MwdD5+Fezdeg7qPeaT3HO8Xd7QXWNkXSCmGqwZnl/ylbRP+KcBFWh5psYvyu5l2AtF227oEmR6lZMk0N4Drs25UPWLJzFXrrm19rnCeit65m7cyP1n6iiMd2JFOmwx3imrCzc+E5WJxj5b6G8+UAYFdM6G6dl+7PCxA6NMm0ZXXSTHaix1AQN4fXwmCSXWqB/WBZg0AvEfxiCDryylEo+3NgosmY+lrbi3YZ7aRJIoGXFHZhwHJ7xry6xk0/h8zEkXD8JzTzYrXSiJzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4DxMMmWQnVc5zzchMYl8+vtCkz3OstMDvL44sl5MjY=;
 b=qMuSiPbiSyCkLzX5261txrMGNJ4H/sQt1tBp/Kxc0FlwWZryZJKJGGub7ockaaUJYBcBwADWluzH7rHGKW6sOUr88zQTT94PVhBAzKExGFC/mMOYjhbPxF30bYGmEoqeVZIUcdyUsuaZgLhg1YZzogQlbkbzuvwhXc6jFn18ZA1U+YwduBTEHf5FQnufdM0c1qIvBrixz11xmxJeBYKTsm+9BJ59afwpkOCeU6i4X7D5IiigjOSdKlAnA4PKKbTMwPqt4q7W2jkDo9n+mx+q0u/gEFKK9N2EM8w7nyL2nTBFlWQ4cYyhWu/oaY1UJeSOmVUg0DrB/WzGJ8I/OEveuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB7029.apcprd06.prod.outlook.com (2603:1096:990:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 16:31:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8722.027; Mon, 19 May 2025
 16:31:58 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] hfs: fix to update ctime after rename
Date: Mon, 19 May 2025 10:52:13 -0600
Message-Id: <20250519165214.1181931-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fda2339c-8c34-461e-da71-08dd96f2acd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0G3JDQNuE2iVlZcsYb93CU5oXRy+LPMWB1uQS6WrJPOOWxeLgrVgOq8qQj1S?=
 =?us-ascii?Q?qfKSHPhwvXf2htjqUXvLTjkQdojyNW+QknoB8oM+kHVB9dkos+RFNrPbX5K4?=
 =?us-ascii?Q?SSzIaNz/V3fGIhb/JjavvbYsufw+DuF6RZuurSX0KvJbHyoRSd5IWqzRdje0?=
 =?us-ascii?Q?8LbKQ+SoYQbVWvJir9wAGPVtKYgngIOFqv2RZ9v5SYA8ZHFg13tEMISaRH5m?=
 =?us-ascii?Q?BoCnfLRfRjm1u0rdvs3Tp+iOe4jBDLNyG6Kcvp0XWZpbO3TeyWgvgBQim+bh?=
 =?us-ascii?Q?7MDOlN7lkmi722iq/WOXGV2xvN35UXbivSxg2dkf3AbYzHSNV1aztNRiJbn0?=
 =?us-ascii?Q?yqFRhD0ivV/7skq15RHEYKA3OOKs0DlcuXwve2XsYIPNY49468rdoD7wuShI?=
 =?us-ascii?Q?lSYutioe5GAslA//qO/BBWyBSgwn74LYk6cjkRlPZ305sfmFekRz2R3uu1Vx?=
 =?us-ascii?Q?HGisHgRzKPm5hqK1VnXEMlV8QgcMy5FFl0kWeKBYRH/Aovp8P2aGSS6m1VDT?=
 =?us-ascii?Q?CTlowXvRc4sUSlbf+gQoajspWxaLJN2c2IvGWfqf7fDN+t59NJW6nXazXDhH?=
 =?us-ascii?Q?RPp6zwAzC3RSy4fUVX4RN2E64yNYMyRU7vdbKGJ1HYFkQf3M38LI4q1Unj2O?=
 =?us-ascii?Q?erSisob2pUqcpQayrVTJoVc7NDG+CAcHlwP5CsbFVow54q/Kg7y5rMChDw17?=
 =?us-ascii?Q?xAGc7Z8x9nL5XBzNDz3FT+ocqdUprGXy9oXFG2LcPTSIm1gDDbJ45SwSShue?=
 =?us-ascii?Q?AsUmh0Ndw3Xj+SvGdAdElQ5BoaKGHMBqAI9p4kpdVpQqtQ/pYhFJDiTsfuOj?=
 =?us-ascii?Q?yal8DqK+MxN3AUHua1bW+VOk8zLTA/Alc/bcfH76J3g1Mk2n90Ib5Ji8yDNA?=
 =?us-ascii?Q?BNiZw4DTR90NXJGdf6mp9dekUnV+8JAesgYBaJ1dawD/e7r8xzZzGgXMvcRC?=
 =?us-ascii?Q?mkWq7Kj/9jG3z7iV83XNRCmTz/kkFuuI54gl4oVF4/5jYF2MjU7BP4ikoNHh?=
 =?us-ascii?Q?0qfpJR9alYLaNftc0ADUOIY9kRxjwRVKmnQhdqYZe6RYBX3e7hRqOmC3gfX7?=
 =?us-ascii?Q?sGq2wss4Fa1R0n+gt/X0QiPQ7WhylOrMQ2uB5Fdu+hyJVd24TC3pxf6c0An9?=
 =?us-ascii?Q?Cnc3tDtJep0qfMZzvCBLIxsif8JTpIHNwJKp8+wEsv5w4WGQUx6h0GM+9kEO?=
 =?us-ascii?Q?/MEgYuCxSIFDCMBxHxZzDG89noqor7XEqnooYMfzqzzQ8CCE6WuAk8G1GbK6?=
 =?us-ascii?Q?6m0itUaAZYKl87VcKSc3WSzLlbiEnTra0/fBFZ3XMnpJxCotnjP92co0H1AD?=
 =?us-ascii?Q?+uf9Q2ZdspKyNBUHkSwiT5TUv0qquhoQZURKaa0zSRfXuBwSCNAIrJkY3j+1?=
 =?us-ascii?Q?fPv7HH2dAj8WGw4T5ig+w09RrxVsoVwBsB53M4NGiiaNL7jiSAy5a2Tlr9q3?=
 =?us-ascii?Q?4Y59igTncNWec3F0RJIrDMHSzBH3ahvfyQTyR1ZHhbbTjxnM1w04ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?20mGLRSLrp2d+KtEEslvINHXCGbvW+AOpUrOKzz3zrDHiNVsgFKjBrTb8osy?=
 =?us-ascii?Q?1UFBY/s8T9JNMSyDrtRLbv7S4PUANcyRFAHpIvGAJfwjwrCe6W+DZH1RD4/J?=
 =?us-ascii?Q?lmkenAzN2SIk02WjdKWfny+nr+mvyQYbHtrXJAB/Cf+sbuW8JUVjkNgVka3Z?=
 =?us-ascii?Q?4Sv8RR2eREkVRJdnoTMmrH1cpSvKTHAfuqjPjvImbIw1wOfjXeehqSiRTd/F?=
 =?us-ascii?Q?gmght/riCUL7xbUShD3QVakYKr+BF8hYIRo3hkF6ZXhqIIgfdNOYhTiVAvCU?=
 =?us-ascii?Q?sSuZn2cL6Kv5LKIZOpCOrENJ/x2pFVI5YmH7m5xERcEPEKlXKRS9dWEK1FV4?=
 =?us-ascii?Q?FJbrUotprb5lY8zGah+o3ikaqtQWbdLyO7fQ4QnuyOvwdTa1Z1QjbmiznzcX?=
 =?us-ascii?Q?0u4aZi2emKwG58hxgXOKQUUoMuG8u+NayN77MSmLZabItBIQUV9jcAn5pSgp?=
 =?us-ascii?Q?NTjZRebOXFCZ9l4BX1qqgVMNDGvrnqY0eVHYDiWN8OArfoCYkRrd5ZyOfpQs?=
 =?us-ascii?Q?Nb4qwNoRfao3AOlhPAgFKNrwyAnnydXRYHU2KgI1CXT/MAlKmffIRyJYogh2?=
 =?us-ascii?Q?EV7BNbjuV0MDud988HcIXIFkmqUgFEzS70N1mWsl8s/VlMF4T20ldz8IRVW7?=
 =?us-ascii?Q?VFBDCLmXpDJBcaXBTpnp/MKnnsNVc1QOJ2zZ6uXJOKhULEDGqA9LQ51wCryh?=
 =?us-ascii?Q?6PGNIF5e23AHlyivp3feNRNVvSz7JyOvpybmRHuuWCfe27acIFDruhJoLaBX?=
 =?us-ascii?Q?P/WHEzhgopvZ0Vxpb0rT0iI5i2mUm7maGM6QWZRmtW3Q4fR6X0DSjpxDtjz2?=
 =?us-ascii?Q?1n4zupTp3jID9yteZFiYKju9U6dPAkY1cj6I5aSCXI4ErXQX/7a5noHzhPCL?=
 =?us-ascii?Q?nNAa7EhgdHxkVIKpRGxwb0xAn5kjJVbDYVGe33zawML9JIe/Krr8VvwlrnPd?=
 =?us-ascii?Q?YQhQFFxDLc4LMkkISdUvC88Pkxk8Mo+xz/1SGFj9/bxcVAAG9hstUXWSXWhA?=
 =?us-ascii?Q?4SDlKEjSX1XXjP6kSRyvrvNxVgKWKdF6O4iW7ndsx5Pi2tT3dH2S66fnYfmI?=
 =?us-ascii?Q?stPkg/EwsCa3Sbup1JxJaar61H4Fo8ezqAJmpxnagEpmdDytcDJ/SXcY5j3I?=
 =?us-ascii?Q?O4kkLbDcXThCmIDMyD9p2iRTnJIFVSbWRt94YPEfaYcsdwm7RhG0jaIzmFVx?=
 =?us-ascii?Q?P3ewhoGeA1ttWcByEQFmqILQfbRKMOnpq2DIZoMyk3FUvcT81uJbGg8INw1L?=
 =?us-ascii?Q?jHwgbTj2bIx2EBlsJ47XbVRlKLUEDy7SyfAtbkQg5yDxkKhxR973aS1xg6D9?=
 =?us-ascii?Q?AFKfSuA8HpEVEYhv2VnDyQ7LkeoUh1uybLxt19uOx2134nwYE09VP0I01NvE?=
 =?us-ascii?Q?l2XVxZ2WOxAdb/HXiCHPwIn9GD4k/FADPJ+QVJ1ibNYpaHv6Hu2Dd/LW7YBC?=
 =?us-ascii?Q?qHtjbEBUiuBiMSAssHpN4Wjq2oW7vLS76tlxazG9RtKN2/Hz1RdACbvSh0bU?=
 =?us-ascii?Q?yQmqVZIWkFam38Sk90nx9yLj5vCH6/o9Whkobn9SFIKze37k98xXVLkE8MSH?=
 =?us-ascii?Q?czIRYvWU1NpdU25B120sN8EhAdTCNQdNWkoJSo7J?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda2339c-8c34-461e-da71-08dd96f2acd6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 16:31:58.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqJfQe9wIA/B/xjmUG6j4fBHSL3YJ3f8tj/xQTsTzC2A2CGufhx0+q7FLKp0S32VBD410pk9YsDMK4JJ3d7rJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7029

Similar to hfsplus, let's update file ctime after the rename operation
in hfs_rename().

W/O patch(xfstest generic/003):

 +ERROR: access time has not been updated after accessing file1 first time
 +ERROR: access time has not been updated after accessing file2
 +ERROR: access time has changed after modifying file1
 +ERROR: change time has not been updated after changing file1
 +ERROR: access time has not been updated after accessing file3 second time
 +ERROR: access time has not been updated after accessing file3 third time

W/ patch(xfstest generic/003):

 +ERROR: access time has not been updated after accessing file1 first time
 +ERROR: access time has not been updated after accessing file2
 +ERROR: access time has changed after modifying file1
 +ERROR: access time has not been updated after accessing file3 second time
 +ERROR: access time has not been updated after accessing file3 third time

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfs/dir.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..756ea7b895e2 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -284,6 +284,7 @@ static int hfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
+	struct inode *inode = d_inode(old_dentry);
 	int res;
 
 	if (flags & ~RENAME_NOREPLACE)
@@ -296,14 +297,16 @@ static int hfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			return res;
 	}
 
-	res = hfs_cat_move(d_inode(old_dentry)->i_ino,
-			   old_dir, &old_dentry->d_name,
+	res = hfs_cat_move(inode->i_ino, old_dir, &old_dentry->d_name,
 			   new_dir, &new_dentry->d_name);
-	if (!res)
-		hfs_cat_build_key(old_dir->i_sb,
-				  (btree_key *)&HFS_I(d_inode(old_dentry))->cat_key,
-				  new_dir->i_ino, &new_dentry->d_name);
-	return res;
+	if (res)
+		return res;
+
+	hfs_cat_build_key(old_dir->i_sb, (btree_key *)&HFS_I(inode)->cat_key,
+			  new_dir->i_ino, &new_dentry->d_name);
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+	return 0;
 }
 
 const struct file_operations hfs_dir_operations = {
-- 
2.48.1


