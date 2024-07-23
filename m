Return-Path: <linux-fsdevel+bounces-24129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EDD93A08C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F5D0B21D99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B815219E;
	Tue, 23 Jul 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geely.onmicrosoft.com header.i=@geely.onmicrosoft.com header.b="S6SNXgdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060.outbound.protection.outlook.com [40.107.255.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D18381B1;
	Tue, 23 Jul 2024 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738323; cv=fail; b=Efm2By2FhjKiN8kPs8Z8hztFmh0G5L20pb7uYJnQK4nE3mxaFqSo3+d8ShG7PzNlMW/hDodXxD23vmFf029W16cSa3edLfaS3ZHmZf3+bjks2zG6jjiX7AU5Hv0kQI31a+SS/T2BfLsl+Mhqb+nrDlIgV0vCdy3Wfk7e3kdZXdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738323; c=relaxed/simple;
	bh=NhHahtEv3pp035OaoFSJsf5+joFXpd63x8AvVgNI1aQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L+KpxcbNCq0DN7u/t1qrfGrgQArEZclipeR6MtPuu4rgwutizRKYDpxsSQoO5MF5uqcK+qrxuc5s6pqDMZC/BD+8hMUj8IdlEu5jfGkGy+TRiwHK99zMEr50ZiRiArmMHm5GAJ4JmBgFQp82q50/0wseWflZM4ohV4W66NuM6d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeekrlife.com; spf=pass smtp.mailfrom=zeekrlife.com; dkim=pass (2048-bit key) header.d=geely.onmicrosoft.com header.i=@geely.onmicrosoft.com header.b=S6SNXgdr; arc=fail smtp.client-ip=40.107.255.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeekrlife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeekrlife.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bnp4kf6iivZWm6vLK/opl+qJg3K4J5BusuIXtR3izQ9ap8zvXsIfFYMC4vzGK0XBivLyfV0mTnH100Jbi4vVRy4ESAGBrvJwoz+Z5nWkNi/RIiWmxRiu8SAsut0XEP6+d307TVLfsv/sJrO9pvikLOX8C18/LfJl1kC4zFH29175RHsF32kzrTRBnf5IpgtCOzoHOOd6GPwtIH4tkJUTVlUMh8uqgSbN8+THARovqZvO/7bQxa+yXSYT4BXCvREu3qhKUuN3zouso9O2J8dNtTqad6LqASLbKR/KJb5ezBROkIwKdF/UZG6cG8ux7GZG+K72AL60ONZ77+cJEytjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCl0TKMNnGqR1v0r190hBsZKDF6884tz3YwbaUkZIPA=;
 b=zCVAldmxJ+MYrery2YfC3Y6nu3o7pxznazp+dhB7IuZ2rB8tp/zfH3lyYc9XVWNkmkSq46AOUFXny+AIploUW7UrddFdLVCoc32WDVXFp93DnrypgAQTq1FQ50sAtWte2iu5xUD7DjMKOFHiy8iLfv17Uz14WAMppAR6E1piK4MfWpz80lalPCHofwPJcndBkkNOx7GOsXxw7vYZ1kVEnX/G12+VkpP4EKuh1Xfko9z2eRQ9Kk6ff/tsbp3s5lYjPIpF35EiW0ndijRgMhYoI8QSwVlo0U/J0qZh2PGJ7NTdGLMIYnG81je+yK+qHF709d+uLPwGpcHHYMzrpHTmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.52.185.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=zeekrlife.com;
 dmarc=bestguesspass action=none header.from=zeekrlife.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geely.onmicrosoft.com;
 s=selector1-geely-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCl0TKMNnGqR1v0r190hBsZKDF6884tz3YwbaUkZIPA=;
 b=S6SNXgdr2iKyT4dckGNjuoUNw3cTWZ5Or9+HQR6Fe4CCt19cJbvhp7kudbMo7KFj5TTG09u7Xy0KKUNyzkgJYpFz0rQIcM6Epr713QGRHc21DGKq/5KUZjWzsghQpWDouhRRU4TyFgToukTIxrrVn6z7ANTgX3LYcRarAngJc/d6urNI/86Udfk1/IjkpADkOg9Uv4P2j4V48a3qKrerpiZzi7Z6D0N2cNbf7jlKSB0BLrjUfHIw60HG6Mi9rh0HLe1xKtaAvPcWKGKv79Wp//bIuqUYA8Teab+FlMsugM9ypGyJ3CjScgRyMP3dn9XoGUZfcdNjmrCZku5r/4h5HA==
Received: from PS2PR02CA0093.apcprd02.prod.outlook.com (2603:1096:300:5c::33)
 by TYSPR02MB6448.apcprd02.prod.outlook.com (2603:1096:400:42d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 12:38:37 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::a) by PS2PR02CA0093.outlook.office365.com
 (2603:1096:300:5c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 12:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.52.185.129)
 smtp.mailfrom=zeekrlife.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=zeekrlife.com;
Received-SPF: Pass (protection.outlook.com: domain of zeekrlife.com designates
 20.52.185.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.52.185.129; helo=CN-BJI-EXP64.Geely.Auto; pr=C
Received: from CN-BJI-EXP64.Geely.Auto (20.52.185.129) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 12:38:35 +0000
Received: from localhost.localdomain (10.186.26.39) by CN-BJI-EXP64.Geely.Auto
 (10.186.65.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jul
 2024 20:38:32 +0800
From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To: <jlayton@kernel.org>, <chuck.lever@oracle.com>, <alex.aring@gmail.com>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ssawgyw@gmail.com>, <Dashi.Luban@zeekrlife.com>, Yuwei Guan
	<Yuwei.Guan@zeekrlife.com>
Subject: [PATCH] filelock: add file path in lock_get_status() to show more debug info
Date: Tue, 23 Jul 2024 20:38:16 +0800
Message-ID: <20240723123816.3676322-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CN-BJI-EXP16.Geely.Auto (10.86.210.80) To
 CN-BJI-EXP64.Geely.Auto (10.186.65.77)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TYSPR02MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: cafa1068-6613-492c-27db-08dcab145f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnJKR1RqUUE0TVdlTjdKNHd2VkgvYThnajNyTkZsUm5HOXoySnFnKzZaMHdy?=
 =?utf-8?B?WnN0RFhtZ1BDbFZGSHN0elZYRmhMdzVpUjFRVVRIMmVNbTkzZ21JbitldzBI?=
 =?utf-8?B?TjdYMytLWjhmdm1WL1JZWmhIK2Q5bHZqYXk4UnpKYWJET0FFbHpaN1hyYjNO?=
 =?utf-8?B?TkpZdlFpaDNsdUxpL0JNR1RsRzRuRXl3WUpXTE9mcE92cGVDTkE4TEVSUmQv?=
 =?utf-8?B?a0tSOG16ZGdiVE02cSsrRVN1RE45WDE2Z0RjWFlFWUVnTGtuemMrOUk3dnpZ?=
 =?utf-8?B?bzBEelRwYXQxYXBlWXc2SEUwZ2NTVjJrNDI5Qll5bFpwNGRLOEFPd2JkR1FZ?=
 =?utf-8?B?YUxUaDluNkViNER6ejIvVWlRMEp5VnJPbnZuZlpTVDVOZWpmWmxQVmhZTUhP?=
 =?utf-8?B?RDZLaGhCbnVaYWhtVTQ3VWh2bUE1dFZCdkFCQlpqZlBEaytZRTR4VTVjTzZK?=
 =?utf-8?B?OUFySTVEUXNjYkdicldtSzlZY2pmeWl3OUY3dVYrUlBpaGF2TERDcWtTdzls?=
 =?utf-8?B?Tkx6MGt5Smk3RWRYSXBXVWtrMkR4UExJOHRoUlJwa2s4K1dOaDljbVJybDFq?=
 =?utf-8?B?Z1EwUVVHazRKZUtwMjU2OUVielZ3dGpkclZZMW9FTHp6ejdDOTNpVnVFYnZ2?=
 =?utf-8?B?VHo0NUYvaGFQVGhuajVKL1M0d2did21Wd2MzZXUxaWVmTzdzdm0zbFZrTGQx?=
 =?utf-8?B?R21tY2tRYU5qZ0RydUxBa0cwL2lOVlc2YTNQTytYNC9nb09UK285N2dLTko5?=
 =?utf-8?B?STlTb3JTNG04djZkeERoTkJDcnYzZjVIL2FlZ1dNb05VbE0wUzJ0WjAwNG9S?=
 =?utf-8?B?QmpNbDk0anNNM2pEWFlWSUlCSnF0STEwTFNxOGhzRHZFbjl0dkFUcEczU0Nn?=
 =?utf-8?B?T252amw0cDJVeFZsRlorRGk3TmkyZzhDU0E2RHd6R1ZHb1paNVpGdjFTRE1O?=
 =?utf-8?B?NTIxME5RSi8xWVBGZHY5QldYWjhoQVBycEVWU0h0THFKZXF0c21xYjdkMVlL?=
 =?utf-8?B?RXZVRS9aaVJEclpGUDRyMTRtWXBrVXlsRU9lbk15alhXb0RGUEhzRXhJOGYr?=
 =?utf-8?B?MHhOcm5EcWZhZ053L0VyN09kZGd5SGNxZzlRZlArRENzSDdKVk1hbEFLbngx?=
 =?utf-8?B?NVE3RzhmY01IVUhnOVdHdjNyUjJhbkN4d2pKZEV2dTRwbzNIYm5VVDRMWkJO?=
 =?utf-8?B?a0hndmREd3BjQXdJQ1Fza2hVZTlMZEFvVi9sdVR1aUtYQVh2WEk5Q1NhWnhS?=
 =?utf-8?B?aDc3c2lzUlYxOXJ3NXdPQkFQb2piZXRuVXJnWUxJR2R3UGJYVDU1QlIveWRX?=
 =?utf-8?B?VzMyaXIwdWQvUHdscVRuYitWSEt6OU9JbkdDR0tPOFkyS1RkQnU4NHkzajZ2?=
 =?utf-8?B?TXNQTUVZaG5HM0hIbm1LLzAyYkhBZ290U0h2cEltZXNiSUN2aFhDakhNUTZH?=
 =?utf-8?B?RHd3OTFyOG5qRkEwTnNpVHVlRERYaGRIUStybGFlK3NMNDNicllja201dS9s?=
 =?utf-8?B?UkxrV2g4VHRldGtMOTFuaGJuTWZXaVkyOGFmazFtVDRvczRPb1VYVlVNRkZt?=
 =?utf-8?B?SHdDSGw0R0dqNlk0REJOb0w4VmZlVnEzVk5TZ0ZreTR2cW80bWVORW15ZEJy?=
 =?utf-8?B?MFF0Vzc0eGE0dGlYMTlnTlI0b1A0Y2c5WTY2SlhTZitXa1BKYnVSMVRhTkw5?=
 =?utf-8?B?cGhXbTM0SDJwZUhybzdRWHJkTVArNDEzam5Ramx5NTV1cEx1WFphNEU5aXVD?=
 =?utf-8?B?WXJNQ2k2R1VPRTJESXNxVk1oWlpsRjRiWUtEZmxwdkM2QXdMclh0eGdDTlRl?=
 =?utf-8?B?S3hibmlzYnhpcnB4QXd5RjhtNEZMcFBoSUx6NXl5QkFKNHVCRVVDQlRhSFNR?=
 =?utf-8?B?M2pTaW5naDF5L0J3TGJodG1JVXREWWw1Z1BlcVk2N3pQMEUxNE9iNW5ROTdE?=
 =?utf-8?Q?+k0m3Hg9+fs7gv63CXrl7x8RZejC2GVr?=
X-Forefront-Antispam-Report:
	CIP:20.52.185.129;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CN-BJI-EXP64.Geely.Auto;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Zeekrlife.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 12:38:35.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafa1068-6613-492c-27db-08dcab145f25
X-MS-Exchange-CrossTenant-Id: 6af81d03-dafe-4d76-a257-3cc43cb0454f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6af81d03-dafe-4d76-a257-3cc43cb0454f;Ip=[20.52.185.129];Helo=[CN-BJI-EXP64.Geely.Auto]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB6448

The current lock_get_status() function shows ino, but it’s not
intuitive enough for debugging. This patch will add the file’s
path information, making it easier to debug which specific file
is holding the lock.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/locks.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index bdd94c32256f..feb0a4427a5b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2764,6 +2764,8 @@ static void lock_get_status(struct seq_file *f, struct file_lock_core *flc,
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 	int type = flc->flc_type;
 	struct file_lock *fl = file_lock(flc);
+	struct dentry *dentry = NULL;
+	char *path, *pathbuf;
 
 	pid = locks_translate_pid(flc, proc_pidns);
 
@@ -2819,8 +2821,29 @@ static void lock_get_status(struct seq_file *f, struct file_lock_core *flc,
 		seq_printf(f, "%d %02x:%02x:%lu ", pid,
 				MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino);
+
+		pathbuf = __getname();
+		if (!pathbuf)
+			seq_printf(f, "%s ", "UNKNOWN");
+		else {
+			ihold(inode);
+			dentry = d_obtain_alias(inode);
+			if (!IS_ERR(dentry)) {
+				path = dentry_path_raw(dentry, pathbuf, PATH_MAX);
+				if (IS_ERR(path)) {
+					strscpy(pathbuf, "UNKNOWN", PATH_MAX);
+					path = pathbuf;
+				}
+				dput(dentry);
+			} else {
+				strscpy(pathbuf, "UNKNOWN", PATH_MAX);
+				path = pathbuf;
+			}
+			seq_printf(f, "%s ", path);
+			__putname(pathbuf);
+		}
 	} else {
-		seq_printf(f, "%d <none>:0 ", pid);
+		seq_printf(f, "%d <none>:0:<none> UNKNOWN ", pid);
 	}
 	if (flc->flc_flags & FL_POSIX) {
 		if (fl->fl_end == OFFSET_MAX)
-- 
2.17.1


