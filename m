Return-Path: <linux-fsdevel+bounces-69247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 056ACC75396
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3DC234E516
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6263590A4;
	Thu, 20 Nov 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="UkE7X3yq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021106.outbound.protection.outlook.com [52.101.62.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0015855E;
	Thu, 20 Nov 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654282; cv=fail; b=f/hNO1NL1MFuaugDi4EUovR0IrhsDhUJnT5h1RQLCTrXQb5cq1V8UUhY8Sp6jAOiamGjh5VtpRDrB+IG3SK64N7jFP2/B58LkRbe3RU0FI4EundmiowaIOeAs6CBk7+TyjXvtvyuUA5ypQ19XrUGaEmVL09ptzJmNOLltIZ54m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654282; c=relaxed/simple;
	bh=gYdhcm0j68SpC2NAeryt3K4ek98UYEAjSHGiORnVQis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pU7CuQ5tlBcGpfJU8DFviXsGWHT/8F4+wYQTJPUWUpergcZ/1sDRFsHaNkWOKl3il1hZzWtGd+OnaXLbiGgZnoDPsVmmVww90dR/NjFX7Szbij6T27Juzcjw2STuIgB9BpMFhbPtOH2n/kSN69pT08expkWrTSP8nlNdT/lFnTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=UkE7X3yq; arc=fail smtp.client-ip=52.101.62.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9/3FZFUjtGxP7wh71S7CX/IyEZzkUw+k9Q2zdoT/4B7cwID0qghLuKUtxFjkBWUunpNsZKKJJDpKHjsSgIT0yPuiF4InRrMNXCgy1u0XmvRARqAgs2pzMXWjYntmSrokq2D4bx4K6C6401BOqwuitza2B0eP6lDb6oFltAfKteBQQZJU7AQrXjTsOrLxBiYh7PeHH0PDFagTzyyBdhECZRW6XFkY73kvjWv1GXTf5XjrEqTgeX+ykk4xRC0h/y/6XJnXFRxoWcBWPfaAkeasP4AU8Avbc8UpZYcYxQ2PZpFtEkhNTVJyBKQ/EqhKzdXBhoLqSk2t0Q0hzSowWoc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+YXgMK35SqjkIRzfSb/7XjjLJliUiK8c7M5LVZtVyg=;
 b=PgAMpKbNET5PsBOcB835dA1UTzvvTGjn9wwn/TgUIlQ46utXVEjqlftV5U8VsxxRncxt01KNPxiGxNiMDEKQbBumhhOYVx0vVrIAWjqwRVwINlMko79bGaZdK2jy/5EKt9/+t3ZN3UlG3lxp+lpglVVF3/OQG2WEcQMXGeLqUpEH3dkUTxt7zxq/AuqCptZ/+vAvnIWADBDpGXxGF362JuxaL+XS4Lsa5lOTifhq4W6cvoMkvGrmHYL9THGB0BuI5/6wP3LwkkEtwjP47VLIkoC84uofvx9ZN9WNSRuDYu4fTBCpkIGjNzrarKIbcCcrjpeTa72Q5aOkP+mQhcoVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+YXgMK35SqjkIRzfSb/7XjjLJliUiK8c7M5LVZtVyg=;
 b=UkE7X3yqIjlXP1yxGipRwjG3NInbDItQ6HCDtKZaQvmQEi0nwJRB9NkNt4FUSX6IfYg372xLuRLg7k+VceuSTM5DULrWmG+cwjbgH3y4X9LyNJO91R8ea/1Gg5e/N3W5LyKKdx5txINONrfEG2YzSjPyi9G8oY64nZ9VkhjMg1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SA3PR13MB7319.namprd13.prod.outlook.com (2603:10b6:806:480::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 15:57:54 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 15:57:54 +0000
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
Subject: [PATCH v2 1/3] VFS: move dentry_create() from fs/open.c to fs/namei.c
Date: Thu, 20 Nov 2025 10:57:46 -0500
Message-ID: <0bc8a9d976d295736911f13db19e303f3444bf59.1763653605.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1763653605.git.bcodding@hammerspace.com>
References: <cover.1763653605.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::3c) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|SA3PR13MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 74301932-c273-4a51-f303-08de284d90aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xX202lQYzWEDuA7jyqthlOIAvSc1j8osOi8ytAbqwtDpglXRZ5vW20WcIneA?=
 =?us-ascii?Q?mOSPpu7MkkdpOOgX3cvho0FDzi1PS5pgVwNe9fau2MSxBSzjVZJRUybsZOQQ?=
 =?us-ascii?Q?pMvljq/ocxPTPNNg2OmGDxc7/XqJOaWQzmpDuRhUpYrNLwYU70r6QpJnTYoX?=
 =?us-ascii?Q?MChGgeK81E3QqtMsE7QoK60rPZBLI0L9Ey8k2NayXqM/ykIPKyS2e6d5L+1n?=
 =?us-ascii?Q?tfHD9Y9pQUscgrBevHUmPomcZ2CQUCHDqbEtN+cQp3zzZ+mEwuKOb8dO2AuG?=
 =?us-ascii?Q?Az+Iq2K5a+wo8OAR0p2wjvj9kIaRkRTjkevTRkLnm+VoO18v3W8+nMxUpC78?=
 =?us-ascii?Q?Py5AG0oJZMy9eyFjy1nL+B1j1H84v21GiTYwwCXAVFD8Velfv1sw1L3CqcWa?=
 =?us-ascii?Q?5SvjQHVZbJH9ZqVd+TTAXSrlyFRheGbvTmrYWpL9ioCB4AdA1F3AWqXhROn9?=
 =?us-ascii?Q?K3RSrppuWH4McPHeGVHeNsQTOjKCVKrqPiMk4smh/ptXs1bVgqEwHOwzHZ4R?=
 =?us-ascii?Q?R1rvFdIPTiT/jiK7EV+frdqveImMVFJWctdkEo39Cc7cqMRwpQ6KzbiKD+AD?=
 =?us-ascii?Q?miwDWrRKDV31uamelglmPXA33+tApM1ay/UkkT4UYIrWA8/cOldP6u7baTGJ?=
 =?us-ascii?Q?99zx7c4FkKrpAEWWwbhrIj1LmONyOp1VlY0jlk9/AvTCGTf9v1KlJ6Nk0p7m?=
 =?us-ascii?Q?pcb6z8fOYEf7NSgTs0ZyP8lJyU/KwAEILdLXJbyNw9cP/ZJTBxpaWAUXV50D?=
 =?us-ascii?Q?fOxUm+WD4e653lzpYYjA+vo2LArYIcgffI6dlNUYPf6jOaIdwOIA+KZLv6jj?=
 =?us-ascii?Q?S9hi9gjAOt719KMJBUezhB2T9NG9J6DAzHSJ07Dju6RNQQaSu5OTKRRC3a6T?=
 =?us-ascii?Q?p55DnL6YvYdZbw62fnlUV2pn1J17zIaFVnTvU3IlY7kde5hbhlJtfFNu+dn+?=
 =?us-ascii?Q?pPiS1HcJpc0cypBsWYa0zJxcdcuEwq6anxh48vhSnQpceylXNEkBY6mOfF9Z?=
 =?us-ascii?Q?pwYYF5PXqDHDQOlSyqmppieN2bi2Flzs+Zz6zs7JahkYzNcey2TO+6nqz1N6?=
 =?us-ascii?Q?iUVnmFWiFJ3Fmb/wGjUjSsXFawwjVqEf0BKcvpf9dR6HAxi7c51wZaq9D0O4?=
 =?us-ascii?Q?eQJlA2FmGzklAoFDuWUcjv+fqkRC0jk4fAt5tFGOezvVuuzPIYGvWWktO9Ns?=
 =?us-ascii?Q?A71h55TVQKzp++KCtIplLqup1PQve5Fyp0jQViR5JtBdynt2fr0Rnq+/T4L0?=
 =?us-ascii?Q?Qsho9sP8wfhqXWKVm9UXTterM7P4ckoBUI4MRKTyqEh5lGjlv0l9iEDdt1Ng?=
 =?us-ascii?Q?ZAk0KOAVNeCmrwyP08OK0bE1D6uq9Qs/j4thq9EI0lrVk4VcVI3Zf2ggGWo1?=
 =?us-ascii?Q?hEEu/V+qIaNcJZ4IPjhBXEB+GEsr2Dvzz9rFIOZ5oxH1mzhDHXveCjOqY7/n?=
 =?us-ascii?Q?imBci0U2SJCLb7p8PLR39pNe8syAoNtB20+/KxGbyn0Q8hnZ7n5DSKzFLC/N?=
 =?us-ascii?Q?Z0jyk4EWHJ2ZFUw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obiA0o6yGP5EAFUMdrLIr8fLjRXqxHOqnGSX7labAGetDDhvAoq8iLxQkM9T?=
 =?us-ascii?Q?bQ6Vr9ccl2usjszwPucbj5DEjlOCgI29pEGvegmlygIQdHfAuAv04E0XLTdS?=
 =?us-ascii?Q?5eHk44/rO+/axVLTWsU2HaLLgZkbup5/8YsWHZuM2zP6s1nNkSs79PqZtvh1?=
 =?us-ascii?Q?5+2Hkh0iBmAISQvs9HMwAGF7RJH8K/+53ARPGVVSM7zcSoNhUlPHnm13pxwt?=
 =?us-ascii?Q?mhS4HmjcQ8InqPUiL5dq2s5zFzTpwwDgrJDJE8KRjDdaWgeNb4ctLL45HIas?=
 =?us-ascii?Q?1MbBa23k2jwYMKkHbS7+XpZDmTkKuauy0QNnqla5u0BVKRoOg599LxmNuqJE?=
 =?us-ascii?Q?IqIMV8z05mTvrNDbTeIeCilfzJ8nl3Rx3dHm5BsrWCVWR+OQMuX9Zf1cOP7Q?=
 =?us-ascii?Q?y7OaeBfMfbVQzADOwfk4YltxRpWFUS3vqvpbWy8XzqqlO+5hHAlWJf2gJoFo?=
 =?us-ascii?Q?267MWnBwIkX/Iv6RHVnLJ3WjWVlffSvJKC9kITqGomy/H1WTqPqrWvXsfgP1?=
 =?us-ascii?Q?o59Piw18v7TGlEi8yGe9ORjXBgVmwyI+ApCDCYB4/ojUK8CDhF7lJ2rFoOH9?=
 =?us-ascii?Q?dgtnFX28n8orWF4tcgrfjGrHmHiqtN5geaVbz6p6pFGC6VqvKy5CBA7DJe5C?=
 =?us-ascii?Q?vP46ksY/qpG1s/xfTkHoWIysQIh08c7pTZAV4ummns+Y30VS0myiOXaa4zzE?=
 =?us-ascii?Q?5MFHtZ8TdMDwc+NVHBRBXonMnOCzmNHfuvLZaTkLK1kF4ysQbi2I4hRLlNAK?=
 =?us-ascii?Q?sMfkC5s260q8X1Xs0DNHt+cjuPCccUoL3szzaEE8N2/E8QpsO7anoc498/Ll?=
 =?us-ascii?Q?RmF38ncK2/MB+zIQOVTBCupw++1W32oGOJuSSUrOvuj24uGdAoC1KE8t2gsS?=
 =?us-ascii?Q?NhvNQ81FzL62OfG9yLNIIuOORTc26xi/8pfGIWLAfoOnEgPTsnrwqkKlwlh/?=
 =?us-ascii?Q?Sb92Zo8F/KCzEeqhJ943ROr8Ha1S6g62FPxoHPEcaBwIDnjIGDDY6JEIVqxT?=
 =?us-ascii?Q?QONitQzTGcgDjeIL7iLu/36YBgM0bIfKHbMb7pUGA0wNZ/RTA0EM5jG5twl0?=
 =?us-ascii?Q?53G2gXf9qG5Pw+pCUuoiij/jclQC4lii9j3u/U2GrGraRrka1Z4Ti4kw6GNd?=
 =?us-ascii?Q?GShziqBmy0Hl6C8bz8tLb/PQx7oAi+UkmMv/eBerUEHrC3fLSn6I+jW8hrd1?=
 =?us-ascii?Q?fNMhppGjU29zOrgL25D5drinl5HWHRcqR9uf9oI41Be7j5iQFxN/ocj4HkwY?=
 =?us-ascii?Q?xj3huVd34bfuxN2RybRmTVc2vc3NtBsszeouUJUS1hyUs6VriB8P5a/xutSg?=
 =?us-ascii?Q?ApuQtaOJe4MLZBAzMOpVTlHmp8u8Cbl238bLr4lb2/FNbfcM7HnLO8zyvVmX?=
 =?us-ascii?Q?8NkeGOIAOHb3RmTfBS5qvNbioOM49kWgHv8IImX8z1M5lzAQTnUJbPJqn+Gs?=
 =?us-ascii?Q?Y6rnoNGvCu9iefn2Xrn6qKPQMdXzGu7NgseoMv2vDTMDRCfFmc9NFirZlCCt?=
 =?us-ascii?Q?30i60pwSkBAiwyROz9soAozSVGD/V0OGzWwndT/09xsIY0a3WLSicutdcyu1?=
 =?us-ascii?Q?RdzadTF5wH1BUTfXSkCiY0xhDVo+t5jAhWD+klG3O5H3YzJfgoXPVptYPoJg?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74301932-c273-4a51-f303-08de284d90aa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:57:53.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDGWsTx/0/HOPJJKh3w7P5nRWOTm09m7ERdLFxo5wv5X5j2dFHk2tzWfvjrb4cQ3oeul3KvB5iT5dzzMKMKD06VtljVKDipXm+0yunfRuMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB7319

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
index cd43ff89fbaa..e2bfd2a73cba 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4191,6 +4191,47 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 }
 EXPORT_SYMBOL(user_path_create);
 
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
index 9655158c3885..8fdece931f7d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1142,47 +1142,6 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
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


