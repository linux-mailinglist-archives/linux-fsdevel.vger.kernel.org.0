Return-Path: <linux-fsdevel+bounces-69897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F52C8A58F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937283A224A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE5303A08;
	Wed, 26 Nov 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="N9qMwswO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020092.outbound.protection.outlook.com [52.101.201.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561C302151;
	Wed, 26 Nov 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167506; cv=fail; b=NlCecR7tFaHWUXoUKh+TJgNablPPw7+AfwzS1/ej6hn5TeBKTXzXLMR7k6cSS84hSYuyPqka+CrDCxPgkEDfOg6NSxKpUDXj9g6eNuALGW+nPufG8a8JSM4A/Iua9g/EW5ZCSPnBzrPn9ygFjZfJsEhiHJUqdFtXpl57lbNUu1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167506; c=relaxed/simple;
	bh=eorZNxmntJepG0o+V1X6ofQbdE7YdFvsGksATzX4V64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W27G3PizX9d0nltvGqO2Q5PjNxSvN5qiW0veTAYDIkRTmWkKKTCEFU3eO6vy3QSa0zzPAZzJkmBVce4NSH1fk9DFE050+5R41U6yQTdTJKkYad59TMdIgcoChsBe8WbiTi0wFvAsrTZYOehmc7Umn/fmfGSjpU0NKzkTfOGeVg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=N9qMwswO; arc=fail smtp.client-ip=52.101.201.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpsV4ns5vn1hHMfHtjxoXZvIsng3k0BfIsjswlfcQw4SaZEy6mnUelC5MsCTmPFb86+kQHzftVOdk7HG23iPgODHH/pPWhh6gtzxIzch64AzJ8IaBADLhQRkqta/TuX91HFJFKos3zzFZ57QO5ld7AVYgA9W1smOYlMbAIRHOrzP7IFvfVqLtbLyN0xIidjiNhex7YRbjDQ85/AACd+Rn5MkaTHQ16/rFH8p2O0kf+EU15SNl316SdZuRmW+3YqenljRKenQGOzKPi+nZjAlzV//veotLH7uJCCgrA07uHB7OSyyTGD7hlUd7535nNbIOrZIMabO9gCmJsVaIsFPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPsA0FhmhjvszZ8o71tm4/Edw2r9cbPpVjzonIvK0Qc=;
 b=t3zSXisxRUNWQNaK1biOXM4uNILRGVbDkSA4gG2L4CdaSXYfTYZWIz3IJ9lpz3TmTGzncY9q213bKkCFNszSq3R2CUEJIBoSx7Y+e9AbEKYBCqyZESTWBF6y+fUjMB2Y4RofXq7oOAci0u2XYVNPy1qWmTUCoQWcjLDTfyzS2HqeBxMR9bGUH0acjqp6T0Q16hb3dDmEuiRftbtfMWlIww2OLciAAIMSr2wjCRhtgHlGrxZH/jwUXGZzyTEvYho8NRfpIkVbDODdKYoU2unQF8jKEwXo/l9SGuK/cAICLOyYnK7h/BrdbMLq5wyDwzh2yH4TSaSEwZG8/IZkJreOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPsA0FhmhjvszZ8o71tm4/Edw2r9cbPpVjzonIvK0Qc=;
 b=N9qMwswOImdClE2ZAs24ivoeud15rOGN8rVAko6pTOku377HtfLOxqvu3Y+Hqv8OWNWzwqzipipPBJGmJx57JyUZcaiSPazpd8rzq9+3LnDST3sudEUibZGlXF9dbDqjta2I8PBzxsLD9/2hPGTbrsK8e4f7zSdpgEaEWRKXaZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by IA1PR13MB7519.namprd13.prod.outlook.com (2603:10b6:208:59e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 14:31:42 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 14:31:42 +0000
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
Subject: [PATCH v3 1/3] VFS: move dentry_create() from fs/open.c to fs/namei.c
Date: Wed, 26 Nov 2025 09:31:34 -0500
Message-ID: <42deec53a50e1676e5501f8f1e17967d47b83681.1764167204.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1764167204.git.bcodding@hammerspace.com>
References: <cover.1764167204.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0041.namprd17.prod.outlook.com
 (2603:10b6:510:323::24) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|IA1PR13MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7463aa07-4d32-40b6-b885-08de2cf8845e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8i9e96nVQPxkn8r1VYTWRUdvB5+mihwaQ4PU5mPwhu+kXERdrP30EodLbBu?=
 =?us-ascii?Q?559/8JPooXUFTVlgxnoH0OkM8hkmBGZsjXl+POdJsxGCZxZ2i4at7y6GVU3l?=
 =?us-ascii?Q?F/2p4gWVJqJeYuOACudy2xCWA9oAnpfmYlvPCqKXSlHMvIIbaap13J5SaNPX?=
 =?us-ascii?Q?TWOEN9qA8CCpmZ4/OD4HVryDU8Wl+MTHPKUMFOEwhCJDPkoRp6CBz3/+VEQc?=
 =?us-ascii?Q?FfYC5tq1Cn8GFap7jHyo+Gb4Rq00CMxLn8tJBQSr0z0iArrAmMQJ768jPh/C?=
 =?us-ascii?Q?VzPSafnoJxuJGKec5J6UAybNbtV3ulcCmozJZoJnsSJ14xnpoitEgN3q2Zr5?=
 =?us-ascii?Q?yhzaHEGeaEEeNfRVvWcWlYTcaglkwpKAtIqEhZxlKVDIfknn1bKn7EEKFtxa?=
 =?us-ascii?Q?llrwVbjpTZpl4BN3bzY1DolmRXzlnNoj2UWejckh3DiBIzv/eFFzg4OGFIqp?=
 =?us-ascii?Q?S0fGftk6a+087m+p2udWXRHaE7nC1gvRJVb7rhjl9QJE5Raehr5G9B4rvkp3?=
 =?us-ascii?Q?TV/zUgwIOfHAWeL/aYKVHR3lRIwPpjy6RjnmzGsHOZgoVc9Pzct/eqxJqPXH?=
 =?us-ascii?Q?w4HhDjq0EhPWyUhB3+fTYXWkhb48qktyVFN6xG1+XIBdsIzIQXxsMRrbUExt?=
 =?us-ascii?Q?M6QVG5brq6BO6V895UloZlEePiktIkYz8Cch/OABTNaNDEufjxklf82IT40X?=
 =?us-ascii?Q?60ZjLWcKzH5tOTRujAu7kaNxKkVYLj3YFSeYF7UGGnELy61h1lG2hrTK+Lfq?=
 =?us-ascii?Q?2S8fnlbBfLriY4lzs65zDzPPQ5Fl+eHxjU6bnQpr30FMNksEHh7iVuBTtwnC?=
 =?us-ascii?Q?gArcFSTaYHSbqngiZS2MVUEYQDkGutoTGCXed225T6wBWJIJzcPOU4x89pN3?=
 =?us-ascii?Q?Upz+oG692StZRmN8fiCSjtaP/I4BkmktShvDtNEmLw2vzN6tzsOotEXMN4Sq?=
 =?us-ascii?Q?VuO9GdZ6jPYMHVdT9c1267N23N9X3+omjAsWh6KnZ06FS1FdmzZisMk3fyZZ?=
 =?us-ascii?Q?uF6GLqm97q08Ya4tYsSKMfbyofCBqwowe9cQNwtLb8Rfc5osng1FuHHqS3EQ?=
 =?us-ascii?Q?z9yXVuod6mO6CQqG0LE1frN9q9OEJR8X9vciwuIQCJrDurZjapmG7Xbxjf5d?=
 =?us-ascii?Q?DVGGttvXjmHw+A87dCfiaLGux/nOdLcpliZrUax24C1+81nYbrmOVmK/ZaKf?=
 =?us-ascii?Q?q33wVbZMTPflf9G0Hi9KwFlPk9NBNuf8rdHO5n9jHQInax3U70/Y08yN+820?=
 =?us-ascii?Q?FuWsJ32QuXFZm2A2NF5Y3ybwszciPYd26r+YrXbq1d7kwM27lgNo7QA3DCIf?=
 =?us-ascii?Q?8l6mIGLDxb7dFPU/SjYw3+vYlStt4CnxsTZN17SvtSGqMwWlbw5pdciQNe9w?=
 =?us-ascii?Q?t+PZbDySBMYZ3yDi8zoYyAroUPvCKx++1iX7YMzvhAx6ZzYbey8A+Hknb+ju?=
 =?us-ascii?Q?z2/3sTDCj9h3wDCPtanhjhiXUeonJN1uMM6pzh2iO3ojGT61XSrG35P5LkCc?=
 =?us-ascii?Q?xYxiMFXFNHzA+kc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?riZmbFXTb7MkpvxNr3ly4Pp51/D+vk+qUtp0KDZd8vM4s4sINMqUedKC/m1c?=
 =?us-ascii?Q?EPHE8xwog0mF1uxMt2pky2Ub7tL8VzNWwB9F5iS/577l9HRcGmhNS95X2sug?=
 =?us-ascii?Q?sv95CqXFjO+/nS5weKlvOqDgF2IwiS2yrLa941yBW/AijFxHyUWVWN/o/sZk?=
 =?us-ascii?Q?Kyr5BBAW/qKg7IcAfugqJqqZ5SZiCIUwFxDeC1hEuKOljZnn4G1+BsClDz1l?=
 =?us-ascii?Q?9UfGg9TTPAXmdYiGgIXdysH4A2qVr0qgopNu36wHfh2WgStiP6yRKCIcwmMU?=
 =?us-ascii?Q?Bwt4w76m59yms+At56MeK+U9419kgOZBlc3NRtbRJASKzPLfcOhAo2jXeyvS?=
 =?us-ascii?Q?ge1DCreBZEn+Qlu6AnG/zBHBCSbcsW34QewdAlCZZ0PmBcuyNqoMQc/3ewH4?=
 =?us-ascii?Q?iX27GmUDN7fAetRvqqhvva4gicIIMHwjlLYVanBBBp1QT42wQku3yhEhwkTY?=
 =?us-ascii?Q?QW+761PTnYHAEbMMfF3chZjGeD92ToUfxLJlgQDmMQo0z5bP/oJJcos4d5II?=
 =?us-ascii?Q?rKy/wCv+//RO6UvDWwNuT0cRRbzcL8/oxwqhvh8HrkQohAIFgE8whhmmXoq9?=
 =?us-ascii?Q?sjbc5caCTM7XMZSzJRptPM1EankV8iU3LdsnEktZvRHnH3sZj9vzQPgjFdJs?=
 =?us-ascii?Q?4AykjqixuGYthsa+Oyit/ltA383UUw+opw8JIzzdTMKBBlfZS051YQ2eMAKu?=
 =?us-ascii?Q?fmYZST7JtVnb+wQ+eDpaX16G35gpU/FBolxb3bzvhRHq6xyB0rJ0apwMNf5Z?=
 =?us-ascii?Q?aqUgfNYAxR+0HyVw2YFNNncPsZj6UNjTS+Rbw0iwIoIkaB4n4DpgyOv3Rd4/?=
 =?us-ascii?Q?Zovs/YqJ3KuludWIMvTY4Hcg+3zcHbdIUE2c0KA2fpwPYDqKsh2G1vPQxrt7?=
 =?us-ascii?Q?ifUMEnsjtKoeGnLKI7FAcuTClHxxyQHM7dksscd2j8CEW023wZJ+H9GBFx3N?=
 =?us-ascii?Q?jCPCmjj0APEliBz2BoFI802gM0XLHgl9Akap6ihKo+P0afKuy9hVNwbx3ueZ?=
 =?us-ascii?Q?gLheJS5Qwc27ipaxu/dRf44FN6rQuajqvOWppXEjoTkimOYJ7zDG5yLwpRA5?=
 =?us-ascii?Q?AsH9wghdaZCy4gA7fmG/y6oaNjgNI4cG7WwMnUURyBfh6wqX/Ib8wJkzjfy4?=
 =?us-ascii?Q?6U3cAoTeCxLdwz4IGeNkBXyljdgLtkEfdr08rp0nmg4SaPhS8gaBMHCg8ec5?=
 =?us-ascii?Q?RIWDonhZX5Z4strbcUWOl98p2ATVln0YiTRNQeBx+QPYw3FjI8szBWu11kc7?=
 =?us-ascii?Q?8j7BadLL7HKPlyIFdm2hjVBuaLQLiX1uDFbHY6MciNFrhItbb1XYiHKm/Q49?=
 =?us-ascii?Q?xxeHle0NcJnUMKClQmZRN2Ya7kW5S7Cp5xiukEwbJCn369Cb9jRxnl2iWSzu?=
 =?us-ascii?Q?QksNqHP9Znom1OP8FtdhDPQgaGD1fCqd5ajEwrtUaROSfHiJbh3FjCmEm33M?=
 =?us-ascii?Q?uBZqYACHKCcyaTjqFGrNXYse8UbMzDOkuWxD1Fg0OQAGefDbjXv1mx4d0dUG?=
 =?us-ascii?Q?IFlk8GL9c67pRXSAFBKCCp8rrB6v1GjE67UK8NaXQLQRwXCDB/eGHbYWKokW?=
 =?us-ascii?Q?O4eJmvSNel6KVKXW9or1LP5Q21xHuJPNWsafbhZOWouG2LJ0sMl0aPZxuInj?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7463aa07-4d32-40b6-b885-08de2cf8845e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 14:31:41.9674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgE2zHnx9EFJX//eY2d6mVHt+XRW4E+79yLR0nPoiQ7jRFwWk0UayZtg9tFK7yP7kvjZ4MbgCWU5yCkRkE7+JDX5lgLtGoNOWnXrMhJTK2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR13MB7519

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


