Return-Path: <linux-fsdevel+bounces-74130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F76D32B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38E1E313E74D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E88224B0E;
	Fri, 16 Jan 2026 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cZpQXnk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022084.outbound.protection.outlook.com [40.107.200.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA21F239B;
	Fri, 16 Jan 2026 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573951; cv=fail; b=nVb9kZ2X2iW/wib2pdyKeiDFicML4fDe8lahM8M6Xz+MZ4g0z7jSTjG/XjMPyHjt2UxmX6TkYvyw7NEgpPKeSd7oVI3xnflI0hLQc226trqaRhO/H2oEd+zbTeldp9YIrjIp15t2qfMRBzjL2Lx2MpnbJ62eIwACLNymCLF32mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573951; c=relaxed/simple;
	bh=6EzFwaDHOgOOjDyOQCc67Bw+A5Z/8OjWKy06L0Tvyi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHivxHcq02ZO1W6zfoCdYHgn/9KbnMMrkqaSP4EksgypVFI/rMX38qku07jXZ1FZE5iXRncdl9U0lr7mEnlBL9zemtYRMOeU1U/+rwBMeRVdbIu7BnTZzczEOQEWdI56fcPUVWzyXa9rAaj3VnDFBxvhJap6DIc31WcDrTTPCmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cZpQXnk6; arc=fail smtp.client-ip=40.107.200.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIVpwrMPd6MG08G52XYbIEncHq3ySjdKsYr7wL43WKuAIiJvDQbQUWKa8sxZ+aq9l+GgIgEN/z/PHclvC5Z0LZS1LXyofd7GcbBqBMWkRlC4/pAZFW11px+xsrd7p6zL/p0pbCr7VhX74hTmJSRjiq7KVSnV+sooXTbR+OiQ2xUAz+y5HoIzBzqoMVjlrqFWOm2o7ZsSa5TKfsaLMY/mjWvZAyYo0JEwj4nhzCRLUbrvjTs2DdP95NWOBzx+SbKiXNojcXGevOVOjazNRoLU8rMSxaky9pdPa5SGcJkGIWKc6WbsH9ItSXgPo93JxCZ0gqSieB/1cj9eMcn7s7eDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwzxfUesh1ZF2ggFGLwbKUIciaQrCIjKo6s5Cg/a9ck=;
 b=SHRMje210zARereZ9BNkMY3QmIJ1EOK78xBWlSExaKgQwjj41cB5zYTcKFZuuuDCq5qYyeDLGUzuLshkKk31FJfMlOcKbYTWv12mzAU2HPsCGfqrYXj2V/tosbXk1mCoY/2fc1ogPXOOEq6FjnV6yLMqHRWea0XJA15Ce5GYG2ZNv6n5AJz9wpexXqQFJs8jVvgKY7bM4pXI0TvEjgggMu+uNj5Le4bYSdLemiyap37hwAl56hHQzSRWfMOixwpgKZh+BnYqNnQfON1wdi/CTmF9SBwzgW2iC0kyD8bPQGM9tCPKrTXkhz6IM0KlBA9aL36DzQdwCj4/n71xF9uRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwzxfUesh1ZF2ggFGLwbKUIciaQrCIjKo6s5Cg/a9ck=;
 b=cZpQXnk6TgxKfLuVJbD+uYyrTF49RWF2RHPYdj74qza/6wnIadlCyodEfajM+v0pPF+35+oge3f39VMH6U0iCEl0PXC7uUnZH4njJoYDeSVrGUrny4mvL4zZhb5caBvSvNUJpKpngFQHfrXOvyniTKsbrSZ9BXWkd4JuQ1FA17E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SN4PR13MB5280.namprd13.prod.outlook.com (2603:10b6:806:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:32:25 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:32:25 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v1 3/4] NFSD/export: Add sign_fh export option
Date: Fri, 16 Jan 2026 09:32:13 -0500
Message-ID: <455770c55ed3500a65a0d5d30133f5f23515a1cc.1768573690.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SN4PR13MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ba679c-e053-4706-7595-08de550c111b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NVpXSqwuQiol1/qwIyFCcZhQlKv36ffqU/Lt6YFa0O635S8U8BFFIs6NdVqd?=
 =?us-ascii?Q?COX94MZw8z91gsijzHtOQsqUEVXwGPi+4MfIw8kOBT5zhTKLhb+anXuN3iRz?=
 =?us-ascii?Q?UGVE6pUOAYvtRQrYqLUk4Soq2z17jEzugqnOG6bTAlc5hDrgTMg7zY69Am11?=
 =?us-ascii?Q?c84qrYknqVJ+Xbrgf66m3lfbxvis/qdqDGgwiRWm6u4FR3DoZ/OTJ+63HJbC?=
 =?us-ascii?Q?5y89Mk1przH2oYXmf7CDz7xl/YwbVgWGVTSz5BF6zWqkRJ/gZC27GHljBh8d?=
 =?us-ascii?Q?j1+Ss6TjqwNwfNhjX+7U+6uSq+8Wz6vAzDOjrId+64QFLdag5FmU32exYJ/1?=
 =?us-ascii?Q?Yy6CBhsTiy8H77mVLJe7Vl2AcHJFKvqKsvnHcqtZ0ykdeGcCwJ4lGnmK01Vr?=
 =?us-ascii?Q?38imnpJt7Clvyy/Fiph7yljb9Oad7330GxKfP6Q554pdmZ1iJcL1XuPvjwD+?=
 =?us-ascii?Q?Ijwcdsu59Lt+LAhWVoga/LslDUOpULAvVdlTPF9xyPrbkOWxtnMAP6uKPhBb?=
 =?us-ascii?Q?yc+gipq+sQGlMYw33sYkmjEv0ZogzxOaBbV4ndtzYz3h1LZlwLE5y9tlJcZs?=
 =?us-ascii?Q?//JZgGrlWv2tMi47vVli6ZnnlCz3fhe8SlKBT//xcML0xIXSKxbdcGYAv4KI?=
 =?us-ascii?Q?J2oibynv/nrMUCK9KpTa7hz1LKbGsJDJEtYt03SvPISN0tuQbAQf5TM1KV+C?=
 =?us-ascii?Q?H1zHqm886DlbOt4clFnRu46mzLy9A7OThEHieKznJJ2MwnqUgtGJFn5xYsJ0?=
 =?us-ascii?Q?/VUYkQcdga9zxma0V7POF5Dp924PyR93EVxnrA8aenzogHdpDuGjbyGWmO6n?=
 =?us-ascii?Q?xaUMLvzkREQWuZuaKmwN4abj5XwVLao/G6ER5QCkhRBRLQT0rDdmLVE29kkS?=
 =?us-ascii?Q?qbVU8YnSZWhazRfAyGl2p/JJWhdEZNe0fngw6oi4cb5A0DgDx+CQeGZ2nMkm?=
 =?us-ascii?Q?5bSLZE8HcHMa5X3/rZYtGA2may5tfXbz9e/xOFokcgrgMfGeTHWh2HnnUsdU?=
 =?us-ascii?Q?C/mz9NPs77XII2L+F9zA81FO7eOjIsjsjkFEMcL2AuYN0Y1cQkgUm8dBV3Rx?=
 =?us-ascii?Q?+LRdHawQKEwTqMd5T6uDA5NpqKtDDmamVsQDfo73eTQjHF/oUVJsY5OT8/BO?=
 =?us-ascii?Q?AIhGhJiiJ3uguOolmN0IC2N85ZYnhQhXBgJX2xGqDmQbowpBaXJEsGVzMXIa?=
 =?us-ascii?Q?O7LOWfbS82g7pYnX0s3IxfVveMgT4lU2MmNXBm/Xew0+n002vwHrSSYT85Ls?=
 =?us-ascii?Q?WTjWw2X8knAwJZvCJ2DIllQ3CM7YEJpAsg2xEYuscuiLaD9nKvm93uX9FNDo?=
 =?us-ascii?Q?LDnbLQWqKuBRtEO1XzqkuM2oML/zoTpzIsaW8GhrGWevbBRPZOHBlLvpEkD3?=
 =?us-ascii?Q?asUxSLSALcGuR7gUViJMvtg9bVDMz8TYhvTL+0riQm/iay6i1648CrmsCUvf?=
 =?us-ascii?Q?XCB0K19o/pOwyGKKMRFIHuk3SYnrJEUqXN0wIkVuPJKMHzgGplieCGI5KaKw?=
 =?us-ascii?Q?JsvDD+9I1003q0y7KmmCVYTLp/mPLo3HEJvPL0veJnjsqhHYaPhTN0Hzii9a?=
 =?us-ascii?Q?Jw3fVtZG/+FoDUt2KI8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EKPEHKymarmcJg4h4eKGCBQuXazJnvSNb+G+5xQ4yiXyGQs7l2qmmJi/FULz?=
 =?us-ascii?Q?NFtQyEPJO+rt++s/U8HEFaFxHcbUjJXUei3Q+bpaWNGkQsHJt5pSshsd7wyo?=
 =?us-ascii?Q?t6r1UhA8lq5l6pGsr/tXfiq7pomDxTOYpU0Npz3FNFFkJWoQSdW2zlLF8VhE?=
 =?us-ascii?Q?w48+qA5wP25PRPfJ/UoB+f72ZsEMw9QVwJntoOhbQWnwm+mtMaB/ct15LRLm?=
 =?us-ascii?Q?Bnzlz5XGozVjSDvakvCfilmRDsSqTQ/BCsWqUof0NWGxN01tl55+J/FwZUO5?=
 =?us-ascii?Q?SvJx+CCnWUV2burwT4BR82SWx3o7V1BMUjf1n/EArid23pcyqEwNdo6A2X0P?=
 =?us-ascii?Q?ejmRdcKufq2ALQfrxKEqdUkfilaM6xUKuTUAEhoHfGlnOp+wrAz4ZpcYmojB?=
 =?us-ascii?Q?LTMA1xghL3TWYAHSIYVWOvZmUPbZEWXdhmVgr2EUZk/5yXh+jQnErwHOV2jQ?=
 =?us-ascii?Q?AqHn5YrtDWZRMwDurTlZU+Pkq+EE/lf/ry1AmAkCLIQQMCq2dnDV+WUQF1Em?=
 =?us-ascii?Q?QEB8laJmUD+B0QXGp6NmojqYWJEQiCxYvxjrXYkgAUZrJB07XMZ7kKOE3ap3?=
 =?us-ascii?Q?fqulSOC4uUteOPx3DxLuS7JHLQaOgHkdFdEXGbGPYqH9KDTaJ8/KA/Bk878O?=
 =?us-ascii?Q?31MT87eQqbzfOxi+oEgwobT7G4M/DQd7w9dSPogRiA5VfwZzy1AiOdESC3C5?=
 =?us-ascii?Q?/BhoKBHY+vzWbYRYeqUzMe3A2r+BZ+qz9vkYJGumK5T1lw7M0cIRvqhhy6dC?=
 =?us-ascii?Q?xBXMjkLJdxEJplM0gmvhBwJ05fNoPenVI4GJ7VJcywudYyBTznRQGxhAL9rM?=
 =?us-ascii?Q?l6VqY2eWzSj6GA+cKA2QMUgApeoumYs1yq0wV++sTc51sSM+djjyeh1MNjss?=
 =?us-ascii?Q?+fknCXtcST1hejgccGQ5IMu3v2f+c8D7Tqg4qV+/EMN1LB4LGg62uK4IJCCh?=
 =?us-ascii?Q?vEv7ikRpx8cFLb+ljKd938BCiuaF9fzxur6QMU1X+L4vq2VCFhP7ZawwuxU4?=
 =?us-ascii?Q?i1DbtprNepPR6QGAVcBIxorlK85vu6H9ntosif2LHzDiSCbe8X8ZsB070yNr?=
 =?us-ascii?Q?9oluNJE8wqKi8/+lEaNdL7G6R0oAwag/gd4QaoNaxMPix45V/4EVBXD+Ja08?=
 =?us-ascii?Q?6/27RJypJNjtj/ZSc586tRw6yArb2upk/JUeXzpittHNt/TQofRzgTW/jKal?=
 =?us-ascii?Q?XlHDNPgQ6AOcrjjncSD8EDOwKZs5LO7Y/6MS2yWtNkb5g0DQO6cxvITEixau?=
 =?us-ascii?Q?JmNKn+i0YoFYpaNEBDl4lkwhtchdEUCDt3HrEzMMEgAj02P3XJ2WlgRhmasR?=
 =?us-ascii?Q?Mp1SM/fjZsVBQ5Ng2eeNK7/GwVIlTMe91blY6N3raqRolFjriu4MEy4RGg/h?=
 =?us-ascii?Q?3bpebvjOrhqefKLYroLYkDaa1o4ah3q6ziWJB6Oq4qmnMYl7XmukPBWKR/l6?=
 =?us-ascii?Q?lOgvtXYntV26IT+itAsJT8wkitbzJyWnG9BZ0HnIUhuz5T3CNQOJsmwBJ3x7?=
 =?us-ascii?Q?J1GTw6Jf43riyA3xwacbS/htEZ1GyQhK4TBlmox5SZm828e4p3ra3ZDiUapD?=
 =?us-ascii?Q?7KvsQ4eWLp6b+cMomMtdw9f2sdQD+iLGjUOVIffQbxkHO2UccXRkRzAyswYn?=
 =?us-ascii?Q?OKmFKI/jwQRswk6zvUYomMgsTtFHKGhJ/ecoYb5DhxQ/FZbeKXSeR+4X0H0t?=
 =?us-ascii?Q?+c6BStkaFHo1y/V9Jt6z9Pb3SOKF6jzLB5gtWmKwuVFVpZyPP4hz4a1kcaat?=
 =?us-ascii?Q?T2DurNUCEc4Lg8qwiMPlNzs/AFkhxaY=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ba679c-e053-4706-7595-08de550c111b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:32:24.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg77/aNULP58prCzK4b7ljTF6CKsGCJZ+xJstnH8hd6r8npzAzEd3/b/g4IXXAP722w4yWreMuHqoox2XIhRp7DXhgVUJkVzXa69Ffnq1LI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5280

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad19..19c7a91c5373 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1349,13 +1349,14 @@ static struct flags {
 	{ NFSEXP_ASYNC, {"async", "sync"}},
 	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
 	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
+	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
 	{ NFSEXP_NOHIDE, {"nohide", ""}},
-	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
 	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
+	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
-	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index 4e712bb02322..6a73955fa5ba 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -34,7 +34,7 @@
 #define NFSEXP_GATHERED_WRITES	BIT(5)
 #define NFSEXP_NOREADDIRPLUS    BIT(6)
 #define NFSEXP_SECURITY_LABEL	BIT(7)
-/* BIT(8) currently unused */
+#define NFSEXP_SIGN_FH			BIT(8)
 #define NFSEXP_NOHIDE			BIT(9)
 #define NFSEXP_NOSUBTREECHECK	BIT(10)
 #define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests - just trust */
@@ -55,7 +55,7 @@
 #define NFSEXP_PNFS				BIT(17)
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS			BIT(18) - BIT(8) - 1
+#define NFSEXP_ALLFLAGS			BIT(18) - 1
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.50.1


