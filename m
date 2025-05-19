Return-Path: <linux-fsdevel+bounces-49435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4235AABC48B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63E1189EF63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CED287516;
	Mon, 19 May 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mYs16ml+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013042.outbound.protection.outlook.com [52.101.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF5286D49;
	Mon, 19 May 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672323; cv=fail; b=ankAzF7/Aj1cZxI61hRTD7SyR+TrW92yKFBC9Wk38lgskOxjL00Tbyjzxpo5wYwbB3Gcc3M3Zgn4SYrNBOh0hYci5Y1WlBKA55lFTpp1g/XYhN44sFdt5H0Pi49yTVlCFmvwfNKrdqOjxmL5kzFlzUQeI0ycTZAEBOk8cEMFeAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672323; c=relaxed/simple;
	bh=Dcy0qV28QZEqcFbQvhM82XlsukOU+D2uXqTidTCT1i0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=szlvbNC7UXpo8K4dXNe6ezRHL6YDPnKhmfBZyPaqfrjMlLneiUoaBK61BVlr/Y8nW2Uo8HT9uXp11dkRQBZL9K7FzBbP6YVdGu1mHp1oOrQcWsiNKRgmatEPB1HRUqkr1kFlKlfXEoVVdrsUQXdOIzCTVX73wFbAofZJ9Cua5u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mYs16ml+; arc=fail smtp.client-ip=52.101.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ7dm3DCmw/IHyDRnQjYClJtK5fVa0iOjCJjAEQsHSOU/AZmW25UYsjUATCK1CTUoq80JUp5fBU3rwTj8IrJ/RfF8EFlsnyWqXD6+MXoXVK8KmbAbVyv0jU7DSpmDLqTh8QMF6IAbTkgU1KfE8FadyX74Ff6H5Sqp0uS1CemazK1fmV/IroDaBXosMHE+1YSclEFyXrMQ0dCI0FTXtEdUYEBbF4xfL0HWgzXWE2xoV/QqwZbv/1m2VEacohnli6+uipTkmA3vMohewuZzx7tyTqBH+1hrv5J9kIakyVMKG6AxHxBIUaLpZqCl+zuK1RYRQqPH13wS7D8oEcaPMWnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEC/kv7196r3w8cXpLgqlQ9TjsfHw0mjuV+aiXLIryk=;
 b=gJ3Whm4AmnRAom+7aG0AxA9Rodq4EdhIUB/hq6yjJryIB1UFVifdvcFRpTU8xbXbzWBJzt5pF1MZoB9albtMQX9LiTRZHBo4wsoiRmQEjDtOhA0qQK9DY6aDRmoaUEmGhSnTrdh/j1mlqwAdRMBCS6mVQyTD3pE31UT9HaULA9i99usFPtweDmvsCGDE84y0m3QE9pJvIkIe3BUMs9dDY1NwQ/QNphVJu6FcJfU/f52oBRPfDAPLFktVJDMf34x7LgOJ25yat2AYUrXQoX2xZ3NNRhK2dN0BlEw7YlGILVFsgygs/pzs41TjIe2aDM20KAzzzoR5cNmOC01jiMOTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEC/kv7196r3w8cXpLgqlQ9TjsfHw0mjuV+aiXLIryk=;
 b=mYs16ml+puCq5cYRe8hA3oMYk3GPGJhxHyfOXSjyEoB5t1NHU9vreZk0biw+dO6S/iPY2c9qfZF1GJJPKSorKIDpO82fuyoss/hTmOCbwY3pclOYFPY2+JYZ3UEKG0EXSRvUYIvIaWTWQTu5kSeIEe2CchLt3VCFX7YBdm39xYboYZf3CfRIpQ8fERn7Bxw6eFuUbGX72bybcrGNKMYM5JxKqSYqP8pkozjBqcC30b3bIOXh0AYA6zyNUrF6KEXtI6yripf76c+1q/oGyPWxX8Yzz27etnJTbZeXUCQoGtbIGY7bi+Vbq4SZk54TuGSyguJhU1WRDJUUwfcsWytQkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB7029.apcprd06.prod.outlook.com (2603:1096:990:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 16:31:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8722.027; Mon, 19 May 2025
 16:31:54 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] hfsplus: fix to update ctime after rename
Date: Mon, 19 May 2025 10:52:11 -0600
Message-Id: <20250519165214.1181931-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 8e6cc52c-9585-4ffd-9fbe-08dd96f2aa4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qzXsI/erZMl3TYPwRPC0SpNTR7vQCr9QQmxwtsAaX/hnIe1s7fHFGUK3EiZa?=
 =?us-ascii?Q?33Q9faQhKXRbUf23RKjz6He90N89u+VxJuwDwe6K/xcdEBCeVe9Fr3McX0/s?=
 =?us-ascii?Q?1CCLolFq+VGSEXsb/J/F4UerCwhXyDYh3U0YqYCgnrWD7y+f5iBBdBeXyzTl?=
 =?us-ascii?Q?zWrijjQAWjyYC0vIXOvlFdHT7FU6iembLTH+adoYxU0PReuaoTG9dZNErQGV?=
 =?us-ascii?Q?uWHsh48BUBQNSYro0uEsQXnFCkAoHBeBt5oPmBj7oZW4k3A6sXW0RWWo6oGo?=
 =?us-ascii?Q?X60jYwreD3mrvFg/WO7ZfSV21p0s80qtlnkMKKm0/eHorcOPRUQn5hDC6MVU?=
 =?us-ascii?Q?zMo8eq6/n637xe3qN5BRutxCGgLa+g7VZm55vCPcdFEckHDGu59131zbRnGq?=
 =?us-ascii?Q?iwh8qo2m4R9dKMPNRciBtioyAkQVDiFHwo6QGdqcyxVlF64wfykReYiO6/5S?=
 =?us-ascii?Q?digrcKoLFXPaHpOhzOOX3BjK/JKeOF7dFFmQfWyfphoxXfL3SFf9+fcz/VuG?=
 =?us-ascii?Q?++s+JKpbrypLNHMCEnqusa2D74fEeYgUaMl8YC6pimiEi0vl644coVrjOt6r?=
 =?us-ascii?Q?SLzliILYdZOaaMWrqt61T8MAdbi6K4yroOdHM1BgK7BfwH1MQaDwJ0RXIudl?=
 =?us-ascii?Q?fwcEO4Ojctpgp9P2W/WLfEVXAEo8K+8lAHOgXCB97TQvInP2dUeTVrwzwQZ5?=
 =?us-ascii?Q?BDXbAdyM1B4Btve0P6tFRJQ1UqgZ1O/F7QM/bptnRwhQSyUk+Ozbb6K+aWfS?=
 =?us-ascii?Q?Zx0BaZSrAKnnbhaLfFHPl7J56JvZcwCPeqnuxID5pbZl9JWkyr7ka9WWYrod?=
 =?us-ascii?Q?M6WLpoBrm2jO4OqeRqYAcn9KSBqKuCKWmoR2EyAvVQX+yqIX83vkIxuT8e7p?=
 =?us-ascii?Q?Lr/lWgPgsZ287e0i3ANqdbK3bCvU+Ilrvyt8Vj6o/DPH2UqsSk5HcFeH5RoL?=
 =?us-ascii?Q?wxn9xiOWMfoHYBowq9kpQXR0kOY/0ToWMPRZs3PQEj8MiJW6Siqqivd/oP5D?=
 =?us-ascii?Q?02YQW+VwLd4v3tGuiJlLbmR7F/8iVWlDyZ7AMeEdyUSEM4SCBeprJsU9KwIn?=
 =?us-ascii?Q?bMoWOMekM6qG5DbK1jmfpwe6aBeQEG7Jk4bPFceVG/A2vH8u5AjC5TAvO/uF?=
 =?us-ascii?Q?im/1Vcym/XoiRgk1BgNkMHdJXwilfpJsdPd0dXlvvc7CbQPVfRsawbdvtgDX?=
 =?us-ascii?Q?Tef0ZSH9oERSgSJCA+dAX7fPKOE+FJErIuMrv4u0nOm0s3LBM9Dd+WnPRqB+?=
 =?us-ascii?Q?Ust2uGaUQ7mWBruTyN5fsscucEqUDTzvptl/viBq7ia5jzqlUdeH7AN/gUSO?=
 =?us-ascii?Q?F78XOIZ2iN8JMYdLoJlMOYQ23szgOssNz6dId+y2CUnktnk1dlcR648CHbAh?=
 =?us-ascii?Q?ZeeXxbRqOMqqWD9Wd8hHtabgtYGMS8vHYEJ5HSFX5k8wshOcb2R4Fzfg7kQN?=
 =?us-ascii?Q?aNYobodaOies8B2BwrSZJNlM8FpgJuZWUkyoS1/4jr8ty2YRPqO2PQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUrQ2AVBGqLV1d8ePFPk8WcAwUhDqSVm2n4z08NX3i2D+zh+aiQoddLNeE3A?=
 =?us-ascii?Q?N7j0PnlvzWOlF41M5m42HnsFCQzizJaH8w+tpRJ6O6HPzpRranOBGPFxjoW1?=
 =?us-ascii?Q?CA0C9lLi/CuC28CmV/lS0W8d71VnG616iXgicR8don/aY5bc+cI3MBDvO2VZ?=
 =?us-ascii?Q?OxpFB2MWCnrpJ0b8goWpbnrdBLOcCWgPa1RDs5DzvCONA2jQiTQ5I4TSq6J4?=
 =?us-ascii?Q?eUxW3yggHI/v6gjUtdYG8u/PBQnm5hOMQq2RQnKLYRL+hpmsJNdqAIfs57Ei?=
 =?us-ascii?Q?dG/WjNBz6dxHCgnETywkz7FV5RE3AT+y8YOrOjR9utXtsGJnHDwXv4FK7Eys?=
 =?us-ascii?Q?vSIVaSle6FBmMsrIkSmLyuQwpXLqQ1RIqkagvRqTby148cpZTzue4kxFT+Yo?=
 =?us-ascii?Q?ZXtWUBSRnwT3EeDGB63b50L5FYwtoOGgYhMPom2/dgCV4vUfVbQCwDQ0dYfU?=
 =?us-ascii?Q?KlH6nmeDGwRVA1HDjieqE/i2x+p+ROayFP8zVozhiugEAMKEZTW1UuRCo+3D?=
 =?us-ascii?Q?NTI65qKvpicUkGXws8T/4kmmso7y+l5Mzk69H7hTJSX1KmzBeeDUGllJwKLK?=
 =?us-ascii?Q?XAWEUpFwEbhNXx4hOKj7Y8dQlH6pG9xbBI4sfyubEdxforyruxoo2Ur0h6Sb?=
 =?us-ascii?Q?R1nR8nJ7ZcUCTLTeHoZEEF0hFEIUYLjbnIeqm6ELXlZq8omI8W7rH3Tu1Lls?=
 =?us-ascii?Q?yfOe2NItsUqeVNSM7+cTUkbfPshd6nLiSVmXT+jeEjvEbqYMSB4EGnzzqBfG?=
 =?us-ascii?Q?LDJh6dyBz5c35Lhlk3sEADnRM+df1rdyhw/VsQZxdWThOpYwA3wBEcRe1i5Q?=
 =?us-ascii?Q?hUiorHCBZk9rkYwABMe+4HvvavObzcL5/zh15OlFZyPChoH6/J0JtcDeLefK?=
 =?us-ascii?Q?DhiQW3dn6HRBlCzK/1raswzhBVUwDsxz/Wl3Lsh7C4G0ZRhn5Hvo8tjUUzZ/?=
 =?us-ascii?Q?TrVzh+RWJGIP2hTNKDNPX2rf6JYyLSCI/KjePzCz1CAms8OPWCMBHr1myWB4?=
 =?us-ascii?Q?IRCAl396lukozPRLdMErbQ/FBkvPzMjGW59nM1F1Ms2xbIRDKomxUp2P+Z6V?=
 =?us-ascii?Q?9W9w6/YlYzaZso+t7vzx2XUiAb6swWx5bg1D6hAfhJH8aFoNj8YrX9qiAIHI?=
 =?us-ascii?Q?omfQPt9MlLSijyWc4CGbVWVN68NRy81XIHPzEawINeFx+Z8FB4MwTOETKDDO?=
 =?us-ascii?Q?w1Flcpmgxfk0zDQbupu5Glq+veCK0b9ZoLCOhRYPQG9dP9vBFr1tTsBFAKVU?=
 =?us-ascii?Q?a/92L7pk7R7AAhEzMtEoT3GaDSbgUl63VdC7RKIzuKCqhZsj0eUtItXKENXd?=
 =?us-ascii?Q?GVNkgb2orc+Te2/LbQCZiKw8XUN10avNkxObUtm62TAWCWo5zRUN23v2Lgsq?=
 =?us-ascii?Q?7fAjv5aLU7eYGmdM1Sbj3s0WIW1Bq2REJtmVju4hbo4N8z7wWjR3VvymIU8E?=
 =?us-ascii?Q?s0OSLQujmOsB5XIqEOKTyl4HkfRO8qI3ypn9C0Bxy7G9U4Wtbpq8UGXWBUoA?=
 =?us-ascii?Q?1KvHEWdLEKS405GNtnR7GqwCUb2wHNL5f8VStSuHN1x9bUS2iy5zbZ2DBZ63?=
 =?us-ascii?Q?IyefYO5bEZRZDfFnP+i4SeXDesmWdZDz8DnnAsMU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6cc52c-9585-4ffd-9fbe-08dd96f2aa4a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 16:31:54.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAAdz5HZMsmLoYurInLCn3GwR3Kp6VwvrEk3uJ4e8BreH7OQVEqLFQkyGJJSxzHzii0HNvaglQmzkLpT3mqOfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7029

[BUG]
$ sudo ./check generic/003
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 graphic 6.8.0-58-generic #60~22.04.1-Ubuntu
MKFS_OPTIONS  -- /dev/loop29
MOUNT_OPTIONS -- /dev/loop29 /mnt/scratch

generic/003       - output mismatch
    --- tests/generic/003.out   2025-04-27 08:49:39.876945323 -0600
    +++ /home/graphic/fs/xfstests-dev/results//generic/003.out.bad

     QA output created by 003
    +ERROR: change time has not been updated after changing file1
     Silence is golden
    ...

Ran: generic/003
Failures: generic/003
Failed 1 of 1 tests

[CAUSE]
change time has not been updated after changing file1

[FIX]
Update file ctime after rename in hfsplus_rename().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/dir.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 876bbb80fb4d..e77942440240 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -534,6 +534,7 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags)
 {
+	struct inode *inode = d_inode(old_dentry);
 	int res;
 
 	if (flags & ~RENAME_NOREPLACE)
@@ -552,9 +553,13 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 	res = hfsplus_rename_cat((u32)(unsigned long)old_dentry->d_fsdata,
 				 old_dir, &old_dentry->d_name,
 				 new_dir, &new_dentry->d_name);
-	if (!res)
-		new_dentry->d_fsdata = old_dentry->d_fsdata;
-	return res;
+	if (res)
+		return res;
+
+	new_dentry->d_fsdata = old_dentry->d_fsdata;
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+	return 0;
 }
 
 const struct inode_operations hfsplus_dir_inode_operations = {
-- 
2.48.1


