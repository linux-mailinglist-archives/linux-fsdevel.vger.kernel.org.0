Return-Path: <linux-fsdevel+bounces-70046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B673C8F6A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5C4F34DA7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314F338911;
	Thu, 27 Nov 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Dx42oOpG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023119.outbound.protection.outlook.com [40.93.201.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90970334369;
	Thu, 27 Nov 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259339; cv=fail; b=fCUAi2x/VJGaLIf/Jv0umgLJYqkDtL9VAPtynlrb8U62rr0RJ0exREMkDP35g/Vpswb3obz7nDFT98e6KMIfDknJBOdslABlG5dd514fWcxFhfruRvXJy9PmPahCmpesPMpyql5Kv3rzAnHVOqetI5sXNQZcf+jvW/OdWVYBcgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259339; c=relaxed/simple;
	bh=eorZNxmntJepG0o+V1X6ofQbdE7YdFvsGksATzX4V64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JRmjzRG/tHw0JgMOIPSXkZB5I9CayU9zgLghkHroy9NWyL9aV4tUbTjxh/pCgK7mDsAU5M968wCOroGXBQcktDIXsrW0/TNEzkKqmRPZFk3HExj1LNCA3YjjJ/7MLdiRc/SVKFumKkPl+/Egw7uf6btYqZIakYwbCH23+Uc600E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Dx42oOpG; arc=fail smtp.client-ip=40.93.201.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlP+tHqCz+y49J3b6kJ49Ne4CIL1fE2nJ2zZXJdMdPFwhphK+hpwvZP3J7mgWgfiW9tN51Yy+LdwnW4H9GnJpf8f0yJ6GvpnxJwDW//e9TF4YiEzhA4S71I+1hkazB9WkHS/3evIWinNHZCFgxIoqrbIU3Yckn5xKiIXn4SA7IcDduD0qeL5qk40j4H+mw/P/4rG0MGprwdGc3scAx+OH6hPxXmTM4Teq+pYe8QbYHetiiDifvMwkLScZA6Xt4pzbsPwVa3lt5/Y3OdgI2wjR8P/Wcv1p5tH5Ztmg6c7NHsVj1/ShK+Bsv0i3KwEBotC1Qh8gIypfVZNexThJyZ7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPsA0FhmhjvszZ8o71tm4/Edw2r9cbPpVjzonIvK0Qc=;
 b=PQ0c4hzjKWKIVsBqg7+WNW6kcAL1SfUQX0iwxte6DB6Tt4LkgW5WKAM6mKQ++jVjoEK09NPu75icwAOJoUBXdVpiCM89X2RlwaOR7tUo+piPYNRAWeXxJA0qc6OOohxzXKnPl4EJ8knNYRcrqpeUAmYVApy41HELHOyce+CaD/YUcoMu7SIuPAsZv54SamRLuUteCMidK4puYv0zKW4d0EEdhfcBHj1sYmzbsVQFETfMGWE7PnQWFQHosynZePlNim5oTnEUH11o9/niLY6gRNACxgYwackfzucuGXf/uae7zLdV4qXHtqmhFREiMTSq+S8V7ZncphjnM1HY6JQqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPsA0FhmhjvszZ8o71tm4/Edw2r9cbPpVjzonIvK0Qc=;
 b=Dx42oOpGfnbo91Sh8kLdhcAPN9aqpj5ek2txTdFJw6WBP5tJPAbLMRK0kXN0zT0yVAix9rnQhBmSEa+djSQui34ckY3U1uzXWb2Ox3Gszk+sUgBKOUolmH52+NI0/f9oLSXGMvAbeqgLrRBZi3QnhDbUKSkCLsD8RbcSVYaY0W4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SJ0PR13MB5500.namprd13.prod.outlook.com (2603:10b6:a03:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 16:02:10 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 16:02:10 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/3] VFS: move dentry_create() from fs/open.c to fs/namei.c
Date: Thu, 27 Nov 2025 11:02:03 -0500
Message-ID: <42deec53a50e1676e5501f8f1e17967d47b83681.1764259052.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1764259052.git.bcodding@hammerspace.com>
References: <cover.1764259052.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:91::23) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|SJ0PR13MB5500:EE_
X-MS-Office365-Filtering-Correlation-Id: 01afa67e-86f4-4cc9-cbe9-08de2dce5236
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bnJ918hKPyvcjYreQF2O3C+zzKufONjgjb2W7SXcuRSR/3xYZwey3CLBJqh8?=
 =?us-ascii?Q?J2EQTRv/y4NaK9+5IuG+yzcMcoh1E4zrTpyXvXNcMOeMl6yGdObs7dLxYlKV?=
 =?us-ascii?Q?OE6y+WsmgDP7lhxoWNrezLmcOHLFf/myNlHm6rtSQbeZTU0Ks/xcI8cS2cMf?=
 =?us-ascii?Q?bsdY8vBbV6x5eqfnjz6ZIWbbTmBbdZRln2M6OIcTmEOPipfOtY7nQtZ72ROR?=
 =?us-ascii?Q?B39WwY0JX29plBHfF6fJas4or9tc64MRdjZSkmKg90jVLwm84efBMxWL/J0o?=
 =?us-ascii?Q?1vm40X2s+mDyQoAIpmO0bNj6vCEWxtyXITgHaZxxuMHs/SOqEDKHzLTF0e2O?=
 =?us-ascii?Q?6E/bLJwSwguArJeZqKmyy/r7pHxA3EBXl/h+6QJIKPQaZ5c/krj/vFntkqdt?=
 =?us-ascii?Q?xwRCFl4z4VmdhTWIjQM4GKi2onivvmZLug8tVvVJa3sj7TF8Wpj72lQRz8Ql?=
 =?us-ascii?Q?vZZtCBEqNheQsyhRkiSWB6D6sdlFxqe5MmJLIz/UqUX/8A45LkaTdJ0LE4/x?=
 =?us-ascii?Q?cLhiKMcaHq0LBmU4mf77yGGRFsN+lQ5dPnl+zPE9B3z/H/te+dVKfhiJwsCA?=
 =?us-ascii?Q?HVnfVsh2j+KX9U4GY8ir+fNwDpulHITDNh1lHYytnaehl4iEfnkPj0jok7vN?=
 =?us-ascii?Q?t+kRhXO4do8XKYSg48H/dip3X9kLD8wHSNITVJ/j1oMCAGFQkFBMdmJ5a5FW?=
 =?us-ascii?Q?cLsHbAXEJ70a9XToNB7ylCUYvNnNqEhD2cVfiTKd+DYknp9cdV5rP0SJSqBs?=
 =?us-ascii?Q?G1y1An/IqnOZkDlKPw8N8L4yUex2PmN6MzDZLBy9cuq5qWQWTV9QzZiIubMa?=
 =?us-ascii?Q?t33igmNUYmrOv7Cf6PZtrzE+tFJBgAdwbbL+BfMp/vw1SWp6GxQn9/7VePRh?=
 =?us-ascii?Q?KEpt0wZ4FjEADxYpyjMlZa9te4Ytles4Fd8NkZGmQ9b+SI6k2QFo9IfftgZn?=
 =?us-ascii?Q?P0LznuCMPqblpBTlLuU8GK0KZVdkI4NQWqIjV9ARFIm0v3Ps6C2WbmtStGDt?=
 =?us-ascii?Q?G/WMsLK/YDe403j0GAVx5nQHvLn5exMcbgnuT/e4y7FcLAdidmxJlvn50FKl?=
 =?us-ascii?Q?QNEhHgj98ZQTzMTTXM7C0WL6oxz5nHrtQPTqK/2EOUCqb4CHnykpKoxsFpv4?=
 =?us-ascii?Q?ONC56GAfGSyXLZL+zbyxnBhwak87V8ENIlaSmJ0JoAIf00vcksFIKh13gCeD?=
 =?us-ascii?Q?QQl5hd/iWb9/78BUB/QO4yJ2dpT4K+Pa4xRXlx9jILGDnz9rei2faGV/tsER?=
 =?us-ascii?Q?MPbtuPk2XX0L/9DCieqM6UIbuTP99K4uCotI9n4bFr0K2KYtlfMcDbNMtPOj?=
 =?us-ascii?Q?uBD4GVB7Jverh/WjEGdVhfw6rqwfIMj8v6pzBdBcQc+BeaOA46nJ79hE3/mF?=
 =?us-ascii?Q?bx9/jUpE0OQw4By5exgXGpBElvV9x17OMqJz+UkO41hPQuWMPTWl6mcG0DOB?=
 =?us-ascii?Q?nOgmD2oTfRyJYcZ4NGOcZRa6wvkcMZNHI6I1V9aRx/Ps+mh1epiqqa6maSPc?=
 =?us-ascii?Q?T272nmtZX/JTYB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?erwEyW9M4iodf4mKENclV2J/iuzJaOyErTLdT+ieXWY1Kh+7DvcdR3K5mB7J?=
 =?us-ascii?Q?o96sljOnjRI3V4dg46j6Uzh1ogqP6rSSFsCxQ6ofXvNZpae7asBQ0OydXBZJ?=
 =?us-ascii?Q?3DO1gltSM6plyvpfyUvjxG6LOqZYpCQRLfj7zCrGXajs12dbGuo8qFvcQ2Hi?=
 =?us-ascii?Q?3wiZhfmkvRq2EEjc4a/8X1W+GjOsZ5kMtne77vPqvcLh2DqqybAhZovcLjuJ?=
 =?us-ascii?Q?W+ZRkZURE01eckkIiWYfCDUJWsJM7Tuzm00NghzYcHh4GG6oKhIJ8RLsPcLu?=
 =?us-ascii?Q?TH9foC3Wu9nRjCRw7naQCbrLKDQwZpFeWfkf92SeAoguO/AFh5QmR+rRtpX6?=
 =?us-ascii?Q?cBn0vMlbLR4DTme+dOr4IKCcD0vpNt5dUP4RTS0sZORlVRTGtV0jQ/ucWGQN?=
 =?us-ascii?Q?rYpuZ2aBk+i8upTsRtCF9n1qSk2XEtMsUJAb9jNkd+qt8GG174HWQ4Sahi2A?=
 =?us-ascii?Q?kryiLZjnW3q/jTUnZqVKZ/7fqOqkDjSa0ygghNdiDyNIaBz/xbiBcpR5BQOl?=
 =?us-ascii?Q?p1pr5UdqSnL+k95DULBCEfvrH2A+0f4amNTH5w6zr3xTbHIupl+EZVzjXXE+?=
 =?us-ascii?Q?L1OvmpmgaNWXCsK59Sm7NzaHcT5ldML1yAJN+ZLtz7ZKhLsLTW0w6CwyGCnO?=
 =?us-ascii?Q?2PMMQ/3xRie5ymkEYxic2qH2nuHjnSRwLIa65WikMcYfQSBgYxJpqJfBBBxW?=
 =?us-ascii?Q?OHziukwDYERn6Ec/FEdlLFa7nBgSE+FQQowWbK/17encIDsYMLgy4G83zJFn?=
 =?us-ascii?Q?QRtfPITKmru/COl9S/1UMn2FtQ9MeCjdi5rlgOki7O0Wg/PjCx6b2fqdJD+D?=
 =?us-ascii?Q?P83xHCpSQHiK3kDTnWDxs8BenPPvJt+WB2icLRhvJhF0T8enVvesu0ETaiOR?=
 =?us-ascii?Q?c1tqJZ8PVu6bKxoP8QCGN6Kg5AnQfxnwl4Q+YI/ArmK7aZif4+qJ/dTdTnVd?=
 =?us-ascii?Q?bB6YiRo+nn15OrMuEvIfHP/pa5bqJEajV3qCdW51nGClgIe444Zy2kkNf4h1?=
 =?us-ascii?Q?/nJ1npAMhKU6EGQHsL6VKJjsC2LJ3CusGXJOuN3r3g6Jc/+UT14TyAYFwzDC?=
 =?us-ascii?Q?X/WJmH33nQ54ySMXcezloDO1GrwjuFY1KBVufQ+pPI7eYk+8RHGHAFUlVMuO?=
 =?us-ascii?Q?Qzyk+V+h+/ukIzZHgKYAzeI8n7U5Mly/BX43rxp4iBtmzYvjqJy3wmRzEwns?=
 =?us-ascii?Q?6P/EZp939l6tO5IZ9YF985/chw872A+5GWF5pfRJul6BCCz5nx6p4m4O0axc?=
 =?us-ascii?Q?EH4+90fNr0tL+URJEz5EMCmZBr3kMYKGNnpfmmURdqWmYXXD7tria2LRnszM?=
 =?us-ascii?Q?tqqan3onupVFpgRKiHGkeZxlSuDSBwv+42viwGonm69a5Jzs4Knnmazk+ROJ?=
 =?us-ascii?Q?zppCh3qzB2Jsw7yb9R2a+ZsT87TjOX5XAthTkOE1mMHtv2Mk1F3CaB7/egB1?=
 =?us-ascii?Q?WyXovNrNSekw/w7dAWdfnhpUjDThciza3jJlW3fTlAOqP+yTiquOKqXHj8mI?=
 =?us-ascii?Q?3giQxAu3L1CLU75oPMKmXDXho+o87hlCBpVzTixQtBzHm4noZ6XAGc2h8JhR?=
 =?us-ascii?Q?ZfoV9qM1LsxRLrYd06am/GAGrvf+wGAgbqiaylL1GPjRXeGDLFQ5V5UCkfEe?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01afa67e-86f4-4cc9-cbe9-08de2dce5236
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 16:02:10.0297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhnOd+uEQGibJp6AYke9QLe4C8+SsuQvPS5I9PLu6OLrmTFrydntus/gzw9cvao4O8ay9Ib85hqQg+qclRmiCk1udqnE4dtnrgx0295tkcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5500

To prepare knfsd's helper dentry_create(), move it to namei.c so that it
can access static functions within.  Callers of dentry_create() can be
viewed as being mostly done with lookup, but still need to perform a few
final checks.  In order to use atomic_open() we want dentry_create() to
be able to access:

	- vfs_prepare_mode
	- may_o_create
	- atomic_open

.. all of which have static declarations.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/open.c  | 41 -----------------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7377020a2cba..88f82cb5f7a0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4278,6 +4278,47 @@ inline struct dentry *start_creating_user_path(
 }
 EXPORT_SYMBOL(start_creating_user_path);
 
+/**
+ * dentry_create - Create and open a file
+ * @path: path to create
+ * @flags: O_ flags
+ * @mode: mode bits for new file
+ * @cred: credentials to use
+ *
+ * Caller must hold the parent directory's lock, and have prepared
+ * a negative dentry, placed in @path->dentry, for the new file.
+ *
+ * Caller sets @path->mnt to the vfsmount of the filesystem where
+ * the new file is to be created. The parent directory and the
+ * negative dentry must reside on the same filesystem instance.
+ *
+ * On success, returns a "struct file *". Otherwise a ERR_PTR
+ * is returned.
+ */
+struct file *dentry_create(const struct path *path, int flags, umode_t mode,
+			   const struct cred *cred)
+{
+	struct file *file;
+	int error;
+
+	file = alloc_empty_file(flags, cred);
+	if (IS_ERR(file))
+		return file;
+
+	error = vfs_create(mnt_idmap(path->mnt),
+			   d_inode(path->dentry->d_parent),
+			   path->dentry, mode, true);
+	if (!error)
+		error = vfs_open(path, file);
+
+	if (unlikely(error)) {
+		fput(file);
+		return ERR_PTR(error);
+	}
+	return file;
+}
+EXPORT_SYMBOL(dentry_create);
+
 /**
  * vfs_mknod - create device node or file
  * @idmap:	idmap of the mount the inode was found from
diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..d6dbb43d41bd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1144,47 +1144,6 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
 	return f;
 }
 
-/**
- * dentry_create - Create and open a file
- * @path: path to create
- * @flags: O_ flags
- * @mode: mode bits for new file
- * @cred: credentials to use
- *
- * Caller must hold the parent directory's lock, and have prepared
- * a negative dentry, placed in @path->dentry, for the new file.
- *
- * Caller sets @path->mnt to the vfsmount of the filesystem where
- * the new file is to be created. The parent directory and the
- * negative dentry must reside on the same filesystem instance.
- *
- * On success, returns a "struct file *". Otherwise a ERR_PTR
- * is returned.
- */
-struct file *dentry_create(const struct path *path, int flags, umode_t mode,
-			   const struct cred *cred)
-{
-	struct file *f;
-	int error;
-
-	f = alloc_empty_file(flags, cred);
-	if (IS_ERR(f))
-		return f;
-
-	error = vfs_create(mnt_idmap(path->mnt),
-			   d_inode(path->dentry->d_parent),
-			   path->dentry, mode, true);
-	if (!error)
-		error = vfs_open(path, f);
-
-	if (unlikely(error)) {
-		fput(f);
-		return ERR_PTR(error);
-	}
-	return f;
-}
-EXPORT_SYMBOL(dentry_create);
-
 /**
  * kernel_file_open - open a file for kernel internal use
  * @path:	path of the file to open
-- 
2.50.1


