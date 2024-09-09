Return-Path: <linux-fsdevel+bounces-28919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0AE970DED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 08:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA721F21638
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 06:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C541ACE0D;
	Mon,  9 Sep 2024 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ndzPe056"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2076.outbound.protection.outlook.com [40.107.215.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1DB658;
	Mon,  9 Sep 2024 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725863667; cv=fail; b=AxLV1IiiGKnC21rap/FS5gtSZoBy5Q35yTPDLtEoRZmOykNtHfmrNzCxkJXUEtUJtfHyutG9dxB6g3to1j8VnIuj64JSppMOaRMTgj5eu+seL3eXxGQ24PfID+9nIlKQSC+JVwSEmbOk/Tu90fKcqscMKzPaiAdClIqxbjwB+JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725863667; c=relaxed/simple;
	bh=aHSO8lzykKt3mjAsHMJMMuBO2Dab/6xHAYyecV0mnFM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jZyEufW981sXRrJIun/6++MMGlQR1vcjAjhYeE4Z08Zix/g3nh+7NPYy2J3cZW8Gsldc6YpFOnVEWMASeAFVB/Le/YGmMTnopKrxgGQBPdn0Q8DZRfTtQvj43ZS32KJp6wPlvUhKyXURIon9wn5Iwap7lU5qqvX7zbOTvO/UNOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ndzPe056; arc=fail smtp.client-ip=40.107.215.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJN18udKN46B1AxtbANCBTgMk+yw7afq3/tBUCB4/mWCGympK7roXR25bPJ2ALWn1jY3uXgDx1Z4GczN5LxLQlS6zCUEjjQXUrM9lYV5dBr6nPyTArNDFJ9zz0DsWpy7nxOGZr404meOlLtZjnzAXyJzAg+r2w7gSRdAqWq1Fg2oVhjyetinpIU7HaRebCeM2eka7E9amucvQhXkKb8dsdyG6oCUClJ+xso+8JdUnv3i2CkAvMkYjJ4E7UtcKYDlq9CYPm9t/Ga7vMEI5zM/Vz8MHYNnY1MSHexKPy/4ekRW2ZTQ9PL1HLzfDudE4C5nem48Zk40VF4F9lyXB214Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M88HiiVe+M2Y4X9U6vkqo6e43RamNmQjmZ1eHAc95EQ=;
 b=zAoYLh64w4tmYXkyMhEsql9YNDKgzVtjZHTJGB6Jj7tTsifneynqFHTbuPvLdUUQzO4ZIGnzTtokscNb1Fs2D6+K2v89LzYz91beQsx44Bs7bwYhuxVshVs43FkFkYd0fanccTp9FM5Dmyg7q0zFAr0QrJIEY9KuIs0DejTfXZZ5KWX9w1K2YntwJIGaSPJctjeBg4Q/qIl0DQLRDMa87/fuXQ5rARVUTY/HforCWrvbRw6cRa1ip8p1tn517d4CNwYLDlGuW6I3N4uF9hFudSLBpr+WsDijJWHDe8ADl8Ccz/hnBQnGP/J9e3N9JV2V+G6RCDmHxLcmEj5ICksYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M88HiiVe+M2Y4X9U6vkqo6e43RamNmQjmZ1eHAc95EQ=;
 b=ndzPe056keKxgMzjMnKK0WqAEkc8E9K5oa6n4H3ecitHwMSAVwpWj3gax6yf/Eeuk36ggL82cKNZtyXANvHsjFyVF9H+dKRZ56hPpZ3uINOMNTn8dK6xaS93pR9BqNqCDFD+BtprADRVB9yGb8wvgrbgfKFKwlVbcaNozShxUOw0gLfF4S6eD+wPDEFUyEAiyMvAEbbG+nYbXBSUC7qVLcjcolfjhcJMlX5ZXStG2i9J4mCeEaFGY/qW45fyBxY9d1BY5L3bV60+UAoD8fK7OvRN3X70TVm8FGpJsfKCd2Tsp9JwEqzW/iacz03zl1lvWnRZJNRgz+unQDamOuxbyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by KL1PR06MB7286.apcprd06.prod.outlook.com (2603:1096:820:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 06:34:15 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 06:34:14 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] proc: Fix typo in the comment
Date: Mon,  9 Sep 2024 14:33:53 +0800
Message-Id: <20240909063353.2246419-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|KL1PR06MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a1dbe9-53fa-42a1-ee6b-08dcd0996c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8ELG6J1acruEfu6PrUJtUqMmuEsA8CNNZAbQGj7sHoMVTOsICAbE8v6aK/r?=
 =?us-ascii?Q?n1d6t6jE+bYpa3Euy42ztGBu2hrdutzBqATpmTUxvSHI3uylx6ee6G1VG6Fd?=
 =?us-ascii?Q?cnFkIuGXKEHzPNUc0XUfLRJADoQ4UIulX9eORYNOARh9S/Vx5HvwNpy1U7Xl?=
 =?us-ascii?Q?pJ+iutdrKg63oZROUYb9oOywiXcRgCEpJPk1mxGMmVFFttqufr/hIv7S6Ic+?=
 =?us-ascii?Q?Dp88UMUAM94/N1nj79NL+aum3OUKvSpzSDAQQwLOv1lSdl5c2zD0dBDdL2CU?=
 =?us-ascii?Q?QCGoJSwSZGy/7niluBni3arw6Lqo9HZgumyOgWnUiDFTW+4nkp5BEqFWUIJq?=
 =?us-ascii?Q?iJ1tJn+/g7h9ZOUMZfug9UmnySZU0j1XRna9b7ahibWh+agTvGWlTfHBHTt0?=
 =?us-ascii?Q?EIHRlNc9swSxhT28oWmD4wzcltHAuZ1BFIMgbQIyVO9E40mSxXypiA9jauF9?=
 =?us-ascii?Q?L+hwMwg8VwdPbnKQxd+ZaNY5fraTjh6xqokUkVRB0DYx95SvY8NLsNxWj70t?=
 =?us-ascii?Q?pMoc0geBDyNMVk2Wuu4NJgRHwMoBbMCUq5V7AnzPXoahrD2p3OmplNiJOIZG?=
 =?us-ascii?Q?zaSRNzWebLsi5hfvVokkXguW9GVfaT/Nhac9WVF6gzf2DC37QHCOrhsW7dgK?=
 =?us-ascii?Q?jJKlTUap6q+7bu8xi3jwAW3XnTT4546m8wcLuTISU+aIHjBXtNWLaB6C45oF?=
 =?us-ascii?Q?T1s5CKDi6z2Vq5jbo0+L7lcjBOzjeRtPu0KhwyLyfOhUno9ZwotRr4GHpoNK?=
 =?us-ascii?Q?6JF9NIwdt8RtzhtOc/0UgKt20Te/VrfJdm+Ow+vtZhBXqXzf+cwWctK4RM6/?=
 =?us-ascii?Q?9wm7wkZpbk8j2iQ72TinvA61nkkAWJFW8a9jPYLzoRn/3Axj/RnT8fbAHmGS?=
 =?us-ascii?Q?LXmYJ+1RDoNk14U1hWlpA06+IREXwNvzk/bNjzhKYMqMBgtV/KSGVlaTdCZJ?=
 =?us-ascii?Q?TGqr5FviWxljY8jHQx8oQDPtKszjdHPnk+Nwpx43V0YQd44nMNGVd5Cvf+bz?=
 =?us-ascii?Q?RVUl1Y6VtAUy8lQEKoIUgK/h7xp8/rxrB02Z8a42moL8xN6X6406yaiYR8lH?=
 =?us-ascii?Q?oHHyyHJctsbeDF9npUBU4dYckaVlpL+72B28AKhhtOxoyN6tKH6IRUTZP2NN?=
 =?us-ascii?Q?dMx1H/EkcpcqYcUxzRWFkxWohB3086DBp9fuEqK7x5QRbDTduJ7hiGbTNRfn?=
 =?us-ascii?Q?fjzn93pJfDIiLAPx93tdcZFOBJG3xiINGEUgtQ2QYjCALzl3pIGoq9QpGAQs?=
 =?us-ascii?Q?TVUg39cTJHzM9wwWAz8ae0nN4Xpzf6ttlAH89H8eDubWYAS5wSc9AGct8DNw?=
 =?us-ascii?Q?XGarezTaKc8uKu4YyQdYqdFbPxoM7K36QDlev37BJMciDHjO0At1n6P9MWCI?=
 =?us-ascii?Q?nF7KqEEBfwcZ+l0HhkUK7ksKOOk4YI9PZW01MWZ218CzygGDRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xXPk0LEeA9Mge2gxDmQlgKQ+UiLVPpEYTwVQU/YEwG3OY+HdCC04SGMmCtjX?=
 =?us-ascii?Q?l8Zo7LkBku5bqJ+zIY+4wx8tJI25gALogX/BqRGyQlx1dktDQPtL8wEymbja?=
 =?us-ascii?Q?t+V/iAI0rekdYU+rmeQqdGgphRzXXfaS2Dc09kBleK/+w0S8pMIRm5hUFm6x?=
 =?us-ascii?Q?FA5x4u4oYjo7GgdGU5MYgt2fQQQpJyVTSnZEBnvpKOKwhMLlVRpw3r5GPJ10?=
 =?us-ascii?Q?NC7kh9cBLXGkSHBKqMyPYybQ8s2EpWv7ykXct+oVSueDE2ZQDlqWV6nqL+Yl?=
 =?us-ascii?Q?/E7BTid7lw8gldQb9CRooK05nyGO7jHT21UqBSCMQ6IOGZafkQn31PLn2dIM?=
 =?us-ascii?Q?Q4MmkLmUvXTh+LS3VfV83Gjniv2ekm4aogZYNrGPjMvRNB/zBhmicB0Be2o7?=
 =?us-ascii?Q?k3vU5MajC0PBzGaagf+ofQH12nlgifyN2T2NlVU0W18WXn4ZCb0I2/gssvti?=
 =?us-ascii?Q?iLYoQlIJRPRIYGi3+JD7tlF+vw9cPD1hjTeQTtSoTMLvygjLiK6/+zoJL39y?=
 =?us-ascii?Q?eNoWfbUUxhQ2SeQKE1M2+D4DdyCfVoRISKJezFOCyA9y/AZ725eiaQW3lquU?=
 =?us-ascii?Q?BzB/o8HGbJ4jlRHZoBZ5U2LK+otBbZI58uaCyI/SsFg0DDCuf721i2Elx6m/?=
 =?us-ascii?Q?npDN0pbClBA8DiQXTMSc4O4+lfnUnwNDiGRCphPbNR42nbU8F7+l7rrPqQAy?=
 =?us-ascii?Q?Z7WNzkiBj+ZHei0xbeErIvQ/XvxJWP8jybZb8vm2ustd/3RRi5v+TfKZVfPM?=
 =?us-ascii?Q?vxgWaO8NoyJ9NHiaInENYEULB5DigoBBzNO8FucvIYXZwuDDcMebWlqGe1n9?=
 =?us-ascii?Q?jTP8esj0//jHX/yH8XT5CXiZ3kBM5sT0PZD8UCdbGyhojE/zxnZpK+UahOrW?=
 =?us-ascii?Q?gCQxnz/KseVu/hw3DrweRqetOwR7M1X1MbhLuAIvept4NK+CzdRdHddjbcy6?=
 =?us-ascii?Q?UbbZZzp6YHQSaMwZIQ3YgQrscGLFj9KdJAsSPcHO5SoGBhfDcsEbYrjni7ad?=
 =?us-ascii?Q?FziobYsnlcxAoJXatLwTofsgEeBu7sLXu27Ln1dPMx0UhpLqAer82UseES3V?=
 =?us-ascii?Q?ZVaRDIRG4KacnzgVroe6RQ/WFiN7C6huyA8v/X4t8sU4ANnYi00yYXD/6LZc?=
 =?us-ascii?Q?81lUBDtnrGjeH2q2z9eCv2T8e37E72MHUbs8hZCZAlwRh54jYTtYr9QjxA7b?=
 =?us-ascii?Q?CzSG+cd7nVyz0WBflDMp0khp8ERyPxKIhU5+MA8fIhGDL7ReVxuEpyDsvACE?=
 =?us-ascii?Q?eIz5G9c5re4Sd1QEpO+N/7aSVco5SnugKBgtk01E1xXSHKu3QEH5bJPIL0b/?=
 =?us-ascii?Q?dviWih/V61+vr/IJPwwhdzAjm92yJ6nt/DZbNq8mqyuyWlzwicVqjs4a3MXA?=
 =?us-ascii?Q?wRZZtc06/Ghe76pjQb3dTSX882iXgtf5Mbbg+9IqaFUk3Qsmm/l7c8mEo/L5?=
 =?us-ascii?Q?nWX9DZjHfv9mqn+eSLIcvDvLjdKAsUW7mNKSlZyowLTae+i54mqnBXu9z7M8?=
 =?us-ascii?Q?waMg7cT9bRevQyuerCd9Hjxa0DTqpg2XmaGr4RNd4gm7thvCBdWDmyarSV0P?=
 =?us-ascii?Q?gz46CO+mfafKrgMy42fv78pFo5xbGspfZg1+8jHC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a1dbe9-53fa-42a1-ee6b-08dcd0996c6a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 06:34:14.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0+rDd7lBk9o/chXsutOtXbd1OFIWrmVX14/q87I37l+vSmibz/GKrAYnA9UjXLivt9JGMpAj2m4lWDxrMjShA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7286

The deference here confuses me. 

Maybe here want to say that because show_fd_locks() does not dereference
the files pointer, using the stale value of the files pointer is safe.

Correctly spelled comments make it easier for the reader to understand
the code.

replace 'deferences' with 'dereferences' in the comment &
replace 'inialized' with 'initialized' in the comment.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 fs/proc/fd.c    | 2 +-
 fs/proc/kcore.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 623780449..1f54a54bf 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -59,7 +59,7 @@ static int seq_show(struct seq_file *m, void *v)
 		   real_mount(file->f_path.mnt)->mnt_id,
 		   file_inode(file)->i_ino);
 
-	/* show_fd_locks() never deferences files so a stale value is safe */
+	/* show_fd_locks() never dereferences files, so a stale value is safe */
 	show_fd_locks(m, file, files);
 	if (seq_has_overflowed(m))
 		goto out;
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 8e08a9a1b..7d0acdad7 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -235,7 +235,7 @@ static int kcore_ram_list(struct list_head *list)
 	int nid, ret;
 	unsigned long end_pfn;
 
-	/* Not inialized....update now */
+	/* Not initialized....update now */
 	/* find out "max pfn" */
 	end_pfn = 0;
 	for_each_node_state(nid, N_MEMORY) {
-- 
2.34.1


