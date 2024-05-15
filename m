Return-Path: <linux-fsdevel+bounces-19533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E378C6983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 17:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3291F22FFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E98D155759;
	Wed, 15 May 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bSrNVRrd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2070.outbound.protection.outlook.com [40.92.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA0155743;
	Wed, 15 May 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786260; cv=fail; b=ZTBb0/AkdO87kMdkx5Dtfyc3rjsyJ9hyoY3HUwzjwZ3/a00MHZrMrI8oTsm3F4jHXvQC7UHY7Yk900FNvv4d80WJVc/V8LKXRWcmrJX64641CP8xpqArB+3HaxeJJDtlsxb3kfkogTOihAljPfmMapwsbwALuKSucC654uC4j64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786260; c=relaxed/simple;
	bh=Flqz8rhx0jIW+HYg5cE6RyBSWYDHJVhfCBHyVbcmPEg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OoYLFc0iTw/A+2SfdWLG7LVmSFGQvOQYJNI01tbgfQSPuDz1c6lUubNuhYeX+UN25qu+Gf8Iz4PAPGmP2vEe86iQ3HzIxlokHgMYwWZYl5ZT4IaN3IuUvhSHEVXot4x7R6za8xi1xYv1rAryK+e/zhxQNaS3oytlGBs9UjLHUjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bSrNVRrd; arc=fail smtp.client-ip=40.92.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee2PWvJvhZY7b7/O26+zLQrszugVBF+Tf5CFbVaMy4fnwGUWwza3fUbJWZUuWQNsqDCX0NmJQET+5AizeygvKQ8/avPPgUpuUU3QMd5Y7B/aA/N0t5GUcHD+MbNPZkDNsujRyqONb06YbZtdgkan6/dZN8DMOSTwgAu8awLfYaFPAX3MJ+XEDoXtlvy17PswuuqG/YIk3wuPNPf2MqcmDRTt21HNfBsTnSYSaysHE70zi5codYt0C3DAqWGy7wIy3OwKao9GGgGHExgBsvTxzwyIKsWfZ1inlVdpxE3JQtHoT+ZuK7geRIB65t5Pe8zGswPMqkQkMEk9b242CdM9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPkuZp3TN2Jb43XcPWbbuKzzk9i+ykb9TRt/nYkp9kU=;
 b=l+dL3lHS45BFIS7OpM5jOlg7lvlApGWdM+eSf/2GzVX8B1MWvFDcXW0FtcgQsCoFz4gT0xTW5NOpFonCogRPsRB0ZusD1rWI6nhq90A6EcgHCs3HsN2KutROP5EWSKdwIA5102vlyNP97S7Iwih9OXGV4Z9vzcqRhPGkUXEAoOQ09zp8+30zGXYpq3HDOtIbXR5PE/z7aYjWosQZc1xxFPnQgNOZAntmmJhydHyXWDP5ixkSarxrkKAJo9drnSP4L2LuXqY1VaSQJadFF3MVdFMVuIOEawEOOmUOMMcSKbGZTCxzbbnY7WLHfn/P3AdfxV1SPLYwu736Tj9jyxgLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPkuZp3TN2Jb43XcPWbbuKzzk9i+ykb9TRt/nYkp9kU=;
 b=bSrNVRrdOpm8d+UnALbSpdaSigW5EBnH3utN0rFR5/S9iExZ+eyV6zUWUousMMRsjzMKYb3Vc5gRLeQZVWxXKLzJQ1Zrz9UpxVs4HU0BqgDWJxy55D3A5W6bSq56xRcJr3VZUxhfdONjlDdHeU24D3oQsj77AwHDX9DbTVmdIOnrUV7mImaVV9aSATYQoi05vcM0KUFFNz6xZk9yj742MlEmkH8IggIipd4NLH2p8lV5QRIHIDPDCcGATIv17LHDk/IQJ1JWmrGkn+43CEHPOjvyDQm7mzI26ZYB56fxVr8AqO+9bmJQJyaV85Pc69KQakIlU8nc5zbP8Ar1bxumYw==
Received: from BYAPR03MB4168.namprd03.prod.outlook.com (2603:10b6:a03:78::23)
 by CO3PR03MB6759.namprd03.prod.outlook.com (2603:10b6:303:179::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Wed, 15 May
 2024 15:17:36 +0000
Received: from BYAPR03MB4168.namprd03.prod.outlook.com
 ([fe80::b8b1:7fdc:95d4:238a]) by BYAPR03MB4168.namprd03.prod.outlook.com
 ([fe80::b8b1:7fdc:95d4:238a%6]) with mapi id 15.20.7587.028; Wed, 15 May 2024
 15:17:36 +0000
From: Jiasheng Jiang <jiashengjiangcool@outlook.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	arnd@arndb.de,
	gregkh@suse.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>
Subject: [PATCH] libfs: fix implicitly cast in simple_attr_write_xsigned()
Date: Wed, 15 May 2024 15:17:25 +0000
Message-ID:
 <BYAPR03MB41685A92DCDD499A2B1369F0ADEC2@BYAPR03MB4168.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [p7thUIOmSuGJwmFBUyzNstLkPYH3D7zV]
X-ClientProxiedBy: CH0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:610:b1::21) To BYAPR03MB4168.namprd03.prod.outlook.com
 (2603:10b6:a03:78::23)
X-Microsoft-Original-Message-ID:
 <20240515151725.4742-1-jiashengjiangcool@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4168:EE_|CO3PR03MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc6d8b2-6bcf-4519-0cfa-08dc74f225a1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3420499023|3430499023|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	J5Dg0c0bQlhy3f/ZvBTA6qJLvZ3e9VnxRP1sE2SXXweGb9AEN546vlpVTBeb3qYxevyC+kVkMiP93WoVCGBs3rXTRzAsiW3pOgFaNWE87zFlb6E8m3TKTAb65i7LqcXwgYMyYbX9p46JS9U83DXjvBreLrQpozm0JucWlRCR0S/jeRFv2q6a21yMzqLq8FxMywwlg7M7GhjJnDXPtv6esM+9xcljzBIBHqrfqW6w5FADsX6ykQtBACahqK/b/NuFrXQCYy5+oFs0TdznBO8BTPKn5tal2KeiLMKY33dxZ0Lqrjw7cbNCg36oMydXHevJjPxnBF1bH7hRYH1hDXtOLCLUAIesrXN5FTarmtCyl6j2neUMPEuDNqJ2gXLTOdH01sE7YHNk9fZ1Pg5o3Dj3Gki62tkoop/Jacl36PVeNR6kEAoVsMECj2lu1yyEgGSYeL8Q5ngE0Zd4+/wrRnC+2x7S5aJztEbwnYopg3B4dnj1WnnZUUIPcoMizKNZhn4vNMMcoJEBGQTh1h0+B+XQkGzcwZZF6RPeP9qWeGu56WwEzUz1lXHLbw4BGd74vj7GyDXsctmyLSmxsJWToKAWlkQUQvPOam68u69mgCDmLIdTmycIN2orGdaWdj81dpzk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Tty6Qj5aNC69UGlTzYkMZkER63lFagneIoEvk5lh8fVCEkzuwpq9kEOweE0?=
 =?us-ascii?Q?XpOCEkpaY7tvJ5/1RUiLHZPEdWzBuueFMHccrHzQmNWzRud2CreaHQe9KzZU?=
 =?us-ascii?Q?las+3YMNRQlqnLzcv+A0i6SVt9e/6XsrybWwsTIONgYTonh3BWPboXhyqGe4?=
 =?us-ascii?Q?w+5JTS6cLH56J+qSHUOsJ34C/jBWSCA+uBFWMMfAfGnHZE+oH5LgcW3TUqR2?=
 =?us-ascii?Q?fsTpqBNWs0dz//RjlwUFjAHagoeRQD6nGt/a3jfX5/jPt2YCLCmCAxuSNGcC?=
 =?us-ascii?Q?HRsSXY21Zufsz1VZUy9qLmjzuZ5W8A0L1QUwhqA2smbOYjroZmARlTlBXwsw?=
 =?us-ascii?Q?owcDvM8GbYbnI4FvJADYOhOcBWvhqLSO3jOr5aFZ9HnZ44DdnLWyLwb2Ar8h?=
 =?us-ascii?Q?3qx7dz6lsX60CoSieNpeICc1t/GfObJ69tq1nOcUWED/8EV+FgJdvJMzDJTL?=
 =?us-ascii?Q?ZEN/y1+XA9QoPLL7imDsYcqqkWjgpyr0ZVpf4nTCWcEw4BvBqT9EFRBMR+z+?=
 =?us-ascii?Q?UfM+Spd/EEzy0uGaX3IQq5I7BD+iy40PpKZM9LL2skSKowKsJUHaw/mIHUNU?=
 =?us-ascii?Q?myUGY2KkSU+bD1LVqqMe7QGtKf0HefoL8u26TBdM3AeLk400rYHcxcgxIEhJ?=
 =?us-ascii?Q?YT1HdGV3VLWE6295XZwthv4w6BzEm0yQb1LT8YXwnfp6zd0f/tocgYZ9aY5Q?=
 =?us-ascii?Q?ddtQ08Sg4Uv+t1OEFsIuCb/g3RKigNf9Cd7DqgfYgIG6mYxuOg42GstIFybL?=
 =?us-ascii?Q?EuU701hkNtl6PwQMQG5mTpjDDzJgIJgzdlIISt04Nx8R4KK2tuDo5Wbl7d3W?=
 =?us-ascii?Q?+qA3l9CsiLhaPPTgdcHScJW1iB5M5Z6ZfV9ociPdX/sSxeIJrIvgHK2VpGpQ?=
 =?us-ascii?Q?DSMVLlxGvG/RmKgVu803F2AOIO6UihecbVHGqfM9IExMVVQ89U3JIhdMaRDm?=
 =?us-ascii?Q?3JWW4Z4BpxB/BI1bG0cpBZYsoHek7F7BwBvmzHevD7gVEUFx3r9Uet/F+JTt?=
 =?us-ascii?Q?6AvcdL01hWlF52dDkTv1l/LVk2TNyj4O0OVwgsMYeDDvRhUjo+m1kHFJ76UG?=
 =?us-ascii?Q?bDfxAe1l6FjwtcRo4co3VF3IHT2qDQNmyZg8stVwCDX5nAAp1ZQa+QLsPM0t?=
 =?us-ascii?Q?OhHP48w6gdApc4Tzn7rxmooYBZfKd65BKhnBgD+0v2XG3RftONiFV/IshMGw?=
 =?us-ascii?Q?9/i7hY5VrijX398YplhrAjuQeQvGfORHNaTa5TiBhYvQYoTCH5wO08XZw9IY?=
 =?us-ascii?Q?b9tbjEy3H5hSU/VtPz01?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc6d8b2-6bcf-4519-0cfa-08dc74f225a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 15:17:35.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR03MB6759

Return 0 to indicate failure and return "len" to indicate success.
It was hard to distinguish success or failure if "len" equals the error
code after the implicit cast.
Moreover, eliminating implicit cast is a better practice.

Fixes: acaefc25d21f ("[PATCH] libfs: add simple attribute files")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
---
 fs/libfs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index b635ee5adbcc..637451f0d53e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1348,24 +1348,27 @@ static ssize_t simple_attr_write_xsigned(struct file *file, const char __user *b
 
 	attr = file->private_data;
 	if (!attr->set)
-		return -EACCES;
+		return 0;
 
 	ret = mutex_lock_interruptible(&attr->mutex);
 	if (ret)
-		return ret;
+		return 0;
 
-	ret = -EFAULT;
 	size = min(sizeof(attr->set_buf) - 1, len);
-	if (copy_from_user(attr->set_buf, buf, size))
+	if (copy_from_user(attr->set_buf, buf, size)) {
+		ret = 0;
 		goto out;
+	}
 
 	attr->set_buf[size] = '\0';
 	if (is_signed)
-		ret = kstrtoll(attr->set_buf, 0, &val);
+		ret = (size_t)kstrtoll(attr->set_buf, 0, &val);
 	else
-		ret = kstrtoull(attr->set_buf, 0, &val);
-	if (ret)
+		ret = (size_t)kstrtoull(attr->set_buf, 0, &val);
+	if (ret) {
+		ret = 0;
 		goto out;
+	}
 	ret = attr->set(attr->data, val);
 	if (ret == 0)
 		ret = len; /* on success, claim we got the whole input */
-- 
2.25.1


