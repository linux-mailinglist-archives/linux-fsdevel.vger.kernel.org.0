Return-Path: <linux-fsdevel+bounces-69899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D1C8A592
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A9374E19E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9E3043C0;
	Wed, 26 Nov 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="c9nrXOUD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022090.outbound.protection.outlook.com [40.107.209.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FED303CB7;
	Wed, 26 Nov 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167511; cv=fail; b=WS6uoHNQ4On0SCjANEYiY6oDdqXNCBwpFeuSbpPEHutkss6seWM3udiFKYxQ44qeUh6+scSrNEYp3VsYHfIhtojlbl5P8zzEfnxLa1/ECNK4CnasGUn25UqdOtLdE5wTmEKvEOKpXpqLVWa4bzpCJLGfCkieeLX+fGllF1+UT48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167511; c=relaxed/simple;
	bh=tcMk80bIwgXGhIK+0n/fjeT9iszU+KR2GjSwshe+CR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/uWgxc2AE0KZIS73340koZwe0PqYUMAWpMHgbl5fX1YFhZNrE6sf8XDikYpoVunb8XYfL/VF6gcf7mvEhEXw2ZLjhhxqkAc0XavmS3pYHlwm0X13jUE+xzXDOuECwA7sRfd8VE2rQTXMceKnOM70vHShJO6VkifQKfccPtr3d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=c9nrXOUD; arc=fail smtp.client-ip=40.107.209.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAf5TnBv0Sa+cs1iCvM01raHxaQiwoj16XvS8qj8vglwFEMuXhZGCUsggtd0JvqoQQXggcYD8ujBuHVtVxjNK+arln0B0RJV3+f9lUNRyt9fTA6D+ZXNhmPweskPU48xObOrMsYUzMOomB9w3pTpMxnq4Cx+bQU6blEQ+QXIBSUvgFkfATGdgyihd3XgbRYB6j96YAMmtjL3BIjOM4U0HTbUxmXqaHFrpkef0GA+jdpwvjTJBcV+Afe3mL5osrMvWGcdQsxGy34+zauef2Z4YWCByH12Yu4dmmh7ADBZHAsCNrMlAyJoDInYVJDARlTW353fHf2EdnYq2Md0lOXv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2WUDHPIQMU1UZXDJl81Hi3Eu8QFmg+9QAVvWH2BjLU=;
 b=hwgGOZV4CrOVJgwPlcEZr2gNX11yYTpwyRRCMhXrUpGKsDTC3XN3Guej1ZKXLeqpYuDE1u/5iT6Ngkr85c/tkq73LPaLzDKdisPyGsnKZ/nEAAajpggLq0V+Hv6IQzBj6/J9QU8IHbcRlMTEaHWwyOVgSiQdYqi3N+l1a7gfaGcgvVVOpiMCJi+cOm9SUKna4l1BUzGQqDw2/JLFiA3jgezhr/uY/IOJwqWiff5wdYyUBeGHv3SfLQaT7hRxCS8f5qIoV+lI7588F7jo1GgAlduTG9/w8Z1CUUUDJJZaJw7sNlMpF/8SRUk0lu67Z4UrzjUkid9ibSBPfjK+La17OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2WUDHPIQMU1UZXDJl81Hi3Eu8QFmg+9QAVvWH2BjLU=;
 b=c9nrXOUDM7+JiQF8/akzC5ldGwEa7/kUB2Uwf/nrd0t8J+a1lz5EmxEF52Z4zUqJxnNQvjDPLdF3BcRBfLn7nZXwYuhJHNE+dHW2EZIL2lUOA1KkXH1IsFHnCVyLSdUXOpC+6wTA7LBAnkyUKxZ+QJ6hTOiBP5N9YtPeZQOCUYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by IA1PR13MB7519.namprd13.prod.outlook.com (2603:10b6:208:59e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 14:31:43 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 14:31:43 +0000
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
Subject: [PATCH v3 2/3] VFS: Prepare atomic_open() for dentry_create()
Date: Wed, 26 Nov 2025 09:31:35 -0500
Message-ID: <e8c1d2ca28de4a972d37e78599502108148fe17d.1764167204.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: eacabaa8-5fe9-4f6a-f690-08de2cf8857e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nwuRPYU7ZwEwH3knMQ57KThGse78SpGElEVOpVy8Lx2dns7mFPE+Sfo/Lbb5?=
 =?us-ascii?Q?VQiachSjb//X+Y58aVriiPjP2CwpgTW8AOhc83fhmQmaOfYRTwqAu+/SiqDP?=
 =?us-ascii?Q?2QpxJ90OTtnqmadUzVtkAwp2cSs4+KlirS7YUK1N4ndXDmqPlDA9DMQ+XSYM?=
 =?us-ascii?Q?klbD1y9u39aTaR7LJ7a6kAU8SAqbzDV5TKWncXLop7bAZ9h1tRdeq8LNW/bG?=
 =?us-ascii?Q?Ov/jocKzudHAiwt/BM7pX4sY48ZMbVPLfzJ9VjUAySqDCDMOdYMKlHNPXSqz?=
 =?us-ascii?Q?CrNdPPLK8yp9tpC9kE/EwuZvXM/h0lP7nF/gr89jQGAqrkiVym63ZKKb55jW?=
 =?us-ascii?Q?h5juRR/If0CdvYMHUfyAUe5AKcEGdTqCNJOektgVNp3FK5GJarhAGHyORfWS?=
 =?us-ascii?Q?mS0DSPCRhMHgy65bRbbzz13Yt0ToOM3taoB0hBuIQa3lnm6Cb54rNavNMWHh?=
 =?us-ascii?Q?oi4usTdVC8MFlV35pmCdUsMtBSycQTBOBPTLEBNqxsZUHaUiVqzx7+lEhObB?=
 =?us-ascii?Q?UL4OqtWpr0pkf+IMjaJITTBu21YtXNK6dMt1B7A/ju2yuLXY7QFHs/TRbimJ?=
 =?us-ascii?Q?2o9HsIEtTUR+XdvzgtPQJiBbrGZA1QH51Dri6iVZ+hSqjyo4VZzAKic5ifKt?=
 =?us-ascii?Q?lgxjpqXm+GADH0afv9Dx5YQI+7zRf4zBlXyofOT+6xan1Mb2OPb0YfMl85o4?=
 =?us-ascii?Q?Gkq29Yrq9YCUm2PtxhlsOCXrMYxi3WzLu+Y2+OACrvqepMbjFQdoUxFCaWAx?=
 =?us-ascii?Q?84H/ZS0Jr9LsTtXok38BjxAabsQ0gD9Dx9wENkPRz5xG1mGbX+1EdiCE3lqt?=
 =?us-ascii?Q?UVrQbtwOGRmGQiQ4zwx6VxYrL1fZASRfj0JdWqOFNG0Q6P4bQfxRe6xdCs2K?=
 =?us-ascii?Q?qXs9SPGhQI3CBHTOG7AsdpGK8awxF7V2cc47emenJNeK6uPYBCHku6zVNx77?=
 =?us-ascii?Q?MVfECyIgre6jAFZkWvosdaW83joqBZoXbukhqVPCZBXrqspOo6cpVAyAoBZ2?=
 =?us-ascii?Q?LZUr03lK4AU5TZMLplZRPnpiFAigKSF3/Cz/WVBB5LIXGQg09bkcnYqxGTSM?=
 =?us-ascii?Q?qy4g5h/ut6E1AwScmI7BKnhXolT0AwX5t5CziA0Iiqji7KD3GjknboBYzxnj?=
 =?us-ascii?Q?61prIaSD1Ac6Ce9R3W6fiCMv8ycdBpegs+UY+m7EjSvIG2Gji+KMm2CzaPuD?=
 =?us-ascii?Q?HHTdY5CfUKX9nckTYVTFtOx0m2/D7Qa0li3WhK0yJuTL0eLHhd+l/KKlWkNV?=
 =?us-ascii?Q?fbflODILk/rq6Yw0ff+lBLQzPMgU+R6iPLMZqwgGjN/PZRIk+iLTxkq5e7pm?=
 =?us-ascii?Q?jV/Zwh7cOV/rTbOA15HboguLDvr57eEyK4MVoXealvyqifqqQyJi229X2fzW?=
 =?us-ascii?Q?BYhRkyV8HKx2GMko6iqRPWekQGSNPc3TL3o0u0gd2fVAiK89YQoTQ+SuMO9R?=
 =?us-ascii?Q?SUuMmV2KtO/5/WI3SvubtKlqpPUdlXziTgvtE8hkoKDv51oNzrpfzTxrBNxB?=
 =?us-ascii?Q?OpxEcuKF7WS2+yw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ByBXen6mlJVFqXgpFOLKS9Mvoh5m8W1G/a98Khg/IxWrB9Elm/uw/ZfMgDjH?=
 =?us-ascii?Q?ydDzOwHs+/N95Qn54Czx4gFDs1DuxeNyaFeXyyIaGjrubkqMJppleV6Ce4WP?=
 =?us-ascii?Q?jhGTcWbS0t/GE0AJ4t3GOmK5l/iF8PKfNly4H8QXBpXhmUoYOoc9x0s1oA2s?=
 =?us-ascii?Q?oSk17tJ1NrTWyXr23RrOcyutoT0rnUY+rEJQ2mRkN+Xp2hBfaFjoTCtalayO?=
 =?us-ascii?Q?7tvGExaPhW/ITZyaVyYSwaI1ealomqE+oAmvnXQiAn/GjQa/p3iqmhgNwuhR?=
 =?us-ascii?Q?3Dg21FjoilYxUCXkxpwaY2gpOj7mK9/uzklEZe7013yhy5RwnKVgh2A4Jkmw?=
 =?us-ascii?Q?LF5eqVjvxo+pH+pVM99yme1IKMeS5ImTDiF3vyygwh+lDJ+gMHUYNAHPyhBl?=
 =?us-ascii?Q?kxcjiTVbd1vwGZPxnrlpVRtrtnSkl9br4g7KJFnfdv/htcgwuPOKywGB69x3?=
 =?us-ascii?Q?Pafpi+HO4AdtEpqHF2/78ywbRf+6Sfkj/yRL9fiqYnBNdKp5iq3W4kUc2/JQ?=
 =?us-ascii?Q?erjx2VijB6SqzibxKM/qMmZrhnGnMVn3sPWf2Vy5N5gGQuuM6TmKn6S7B5Xx?=
 =?us-ascii?Q?TSkcAzlyrh/Wgwi+ABJKFoxqIOJq/iLqfnLRo2suorcAbO7/yWwQWrdupELM?=
 =?us-ascii?Q?DE+1bubTTQC/1lepxWYuoWoqKm/cJn3CVEkb4CPLohmY2M4Or5Is4mkDsAiz?=
 =?us-ascii?Q?lhNfVsK48GK826wZX0wonHpqnBwwCMm8yt+vHPiylVYtmm0LujtMo5WiJz1O?=
 =?us-ascii?Q?Yc9/S2MizJcYtpv9C+ws5IFW84MTFN7/2aN+DALqlnv1uaRmXnoZjeDQvJHp?=
 =?us-ascii?Q?ujS1TZPmP/VQOCP5BkJXy013KfRXyJQxutQsmFJ4lIi4kO/sDqdFtYJLS4pP?=
 =?us-ascii?Q?8++wK+u9h+APo5OnIZqH6QHGwouWU6+M4pAf1p2t23TRmvThib/0sFAFo1TQ?=
 =?us-ascii?Q?R1M1uz+PGRF2uzL7tuppBuboqZnm4hvfSfat+GpNHN//MA+9T9r5P3ubAcUv?=
 =?us-ascii?Q?LCgGd47wRVf1PaQQ8xVMG6/XY+elehWeke/YMbwVaBGLrpEUmfLww6fV8hLX?=
 =?us-ascii?Q?TQCCFoRL+OxqYaqY0Z8IJiMZphBQJPzj2SpkRCcOcMVs7NA/2SlJzs/4FEzt?=
 =?us-ascii?Q?97BfaVJeOtB3fCrWzTFZjZIEEHOBl8WMnIGfIyBYpENECyjrKMPfwtmw73Rr?=
 =?us-ascii?Q?rK076JKilYQMzk00KpA59nCQxFf1Pt8PjAcmsl9DQCRwFadoVxTYUF6sNBYs?=
 =?us-ascii?Q?piOpYY/O+d0KFopL/Toikrl7EujOERk/UbXzBG0gSHCA0QY2A8EGF1A+FIxk?=
 =?us-ascii?Q?t4IF9uoWa3C1mqmSU1P+IQxnFPFqG7vafVvwSwx7C96mLfOLvkNHYjA124en?=
 =?us-ascii?Q?5Xcmcx1JuWnsoSwfVApfyyHdTPfamfjEPjinS85uA87R0gEU0ixsePZCPbQ5?=
 =?us-ascii?Q?/aIlzaWMaFJ3xbXmhmsAR8M1q6pOaqXcjAHIYNgPttugeXC/Xu4k9Gh0nFWk?=
 =?us-ascii?Q?AzuL9Kv0NxcmIFcPS2jJf9w9HWjS4HYYMZrC2ubLVd9P+yXxQsmCo7kQv3ZP?=
 =?us-ascii?Q?FHjKx3j70LnwOR5YWutFVKtLan410Vw+tKVUY8FZtGN352r7LB/V8bH3nzGS?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacabaa8-5fe9-4f6a-f690-08de2cf8857e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 14:31:43.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXMEZjY+yn6RyiEmsimO+LDfENe4R6ShTAAG5w4Q135UyNtr5O6vI8lCefyqWh7SRVsHWN1ZFsx89h27iDtxD+Jki+wHtEPy+X9lAm6CfFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR13MB7519

The next patch allows dentry_create() to call atomic_open(), but it does
not have fabricated nameidata.  Let atomic_open() take a path instead.

Since atomic_open() currently takes a nameidata of which it only uses the
path and the flags, and flags are only used to update open_flags, then the
flag update can happen before calling atomic_open(). Then, only the path
needs be passed to atomic_open() rather than the whole nameidata.  This
makes it easier for dentry_create() To call atomic_open().

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 88f82cb5f7a0..389f91a4d121 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3640,19 +3640,16 @@ static int may_o_create(struct mnt_idmap *idmap,
  *
  * Returns an error code otherwise.
  */
-static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
+static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
 				  struct file *file,
 				  int open_flag, umode_t mode)
 {
 	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
-	struct inode *dir =  nd->path.dentry->d_inode;
+	struct inode *dir =  path->dentry->d_inode;
 	int error;
 
-	if (nd->flags & LOOKUP_DIRECTORY)
-		open_flag |= O_DIRECTORY;
-
 	file->__f_path.dentry = DENTRY_NOT_SET;
-	file->__f_path.mnt = nd->path.mnt;
+	file->__f_path.mnt = path->mnt;
 	error = dir->i_op->atomic_open(dir, dentry, file,
 				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
@@ -3764,7 +3761,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (create_error)
 		open_flag &= ~O_CREAT;
 	if (dir_inode->i_op->atomic_open) {
-		dentry = atomic_open(nd, dentry, file, open_flag, mode);
+		if (nd->flags & LOOKUP_DIRECTORY)
+			open_flag |= O_DIRECTORY;
+		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
 		return dentry;
-- 
2.50.1


