Return-Path: <linux-fsdevel+bounces-70047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022E1C8F6D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18653AC878
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4C338F52;
	Thu, 27 Nov 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="J1QHt19v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023119.outbound.protection.outlook.com [40.93.201.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37702D12E2;
	Thu, 27 Nov 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259341; cv=fail; b=H1Nzfv0L4bdYSptFJ1w3caJ5xt5x4FOEkuCR9AvIAV/eX4JSbyObQnkSYj4ZCal6sKpxC4vU7lhLCAUvCbrd+YPINSTjMA1cevqib9mjt0bZ4IW0Dlqp67ZPkhYOYrEWBe5cruZrFibXMMLRxa68ZOd7kIccNhESl21mWnMgh5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259341; c=relaxed/simple;
	bh=tcMk80bIwgXGhIK+0n/fjeT9iszU+KR2GjSwshe+CR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6hAOlbRi2qXXePlw2EopyaLlyGqjZSulgf1jMrZwf12hxp9HlJ7SMxRxLgaVlhzL2jNWqa0MGPUOy6DoV8t4bIkl/ualWig3u4p6Dk360qhG6vTc1QGXXbp14XJ8fd5+GqgHlnkgTIraM6GD7wMBc8YoORQKfGfQa+aTG7hg30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=J1QHt19v; arc=fail smtp.client-ip=40.93.201.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gm8ZK1CV3hNGoP4cWLqxYUR1mc43HK+t6g/+fgcQHLrFtkW4CBUyCCjzzqN0F4EOP1mhLWuf6vcktzf0dixYylEouAKS3Hs6egn0ax/GPGNp7MUEx61w4956R0zDxVzGp9PxSHjQ38ZN22SPE4vcjdNHAnAL0F/EAh78VLflUvEXgRITnbfnapA2BRfbp8TxwoWusBhXMema8CH9jtAoVPRnzeriDUBiQ4AOMjdd7NBBczLz2Cvw13I7g9jSXGutXXZV9hoz0+dBPo4Ebk6d95Pff0z4PkKQ1l6FHyFrOGw+nByjzc+LW9EjPbUapNVFBcSqMiPz7qauloGQV5wevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2WUDHPIQMU1UZXDJl81Hi3Eu8QFmg+9QAVvWH2BjLU=;
 b=gFBwK78pPfmNl4MhlilhxT44SKBZslLRuFZC96L//qPcUTIj0YP2p3vD0iew/Ndrb7iISdcmABdwG5sWn5sFqW8TE9bCeu0DE/lM8gClL7FkB320GCREHuEG3U2+Ve1xiIJooFakm7IyZUpW43JhXqECQ3YsUiGEJNIA9cP9gUWQS8xoKtF1Re2vXAtqQkalJ5vTbKZm3VGoWem9BAB4UvM/xdbpGX6iE3/Ba9DOkUBQ/ax4uVDXGx6Gk7g7OtcpVvFbGS0InRB2ngvcB4aP28URupdpdgjMd0DNNe+vJeRFJleSTmH8NhdtKVQ1hs7ZOPY7i+4VlhuKXpWNMURvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2WUDHPIQMU1UZXDJl81Hi3Eu8QFmg+9QAVvWH2BjLU=;
 b=J1QHt19vImYjrKrztsgJQG7Oc4r4d3ddydjShbKy7UV/FucnxNNN2/DlAwdswgav/Kytn3xwMmNEFam4RVCnRtR2iZSzx/4LN+bfdw9VodTLlOceVtwU2jEEgz5wKbQPhR5YVooSxVjB2UaEUQAgV7J/geAst3nc5eBHdqq2fD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SJ0PR13MB5500.namprd13.prod.outlook.com (2603:10b6:a03:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 16:02:11 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 16:02:11 +0000
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
Subject: [PATCH v4 2/3] VFS: Prepare atomic_open() for dentry_create()
Date: Thu, 27 Nov 2025 11:02:04 -0500
Message-ID: <e8c1d2ca28de4a972d37e78599502108148fe17d.1764259052.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66ac591f-241e-4bce-94c5-08de2dce530b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?StiK0Y4JsMHLfWVXiBQYvnndh7D2bP8QFNTRm5YtNDwri3oOs/rZcx5yNmJy?=
 =?us-ascii?Q?ahgWtGlhUGllWkbvVplXyxXI9Ux4i9546Vd2jHcnaSDin+L1RF0RsM+Jkcar?=
 =?us-ascii?Q?0r/0mBXOtk/KrTlVx5uIK3nQHpVnmctC/vxwqIvZSGhwodW44pPARr0+20FB?=
 =?us-ascii?Q?i8cTXjxHBKFkC+O0ajIlhFPNqzxZ8CRAxD0b8gwE2xz+YVUJdqJq8G7gned6?=
 =?us-ascii?Q?Apnr/54HIaInUTZUyXIsGAAM5/1EcB7fQ53Zu6yWLMiBY+UWmjL4zFnZm/r3?=
 =?us-ascii?Q?WnKCBwQ/N+Gvo/Er5jWmw7SviDs8/+BV5l9va9YF6R1FfZiMBRhItuM4Xett?=
 =?us-ascii?Q?a58lCPtM2/Y4S1TgeYfZGOplmTD2Fbu1AVk3cNe810OwfeGtiibtmjHiUEio?=
 =?us-ascii?Q?6bSH0Ok6O9smblRvaslWMdN9A1SFecCkJpvJmoUQBzRPwe9bn10S8tVykOj3?=
 =?us-ascii?Q?NUuvJ8OR2LAfmDlSo1wwjq08y/udekWpUgQd7aaLLv5PF+7XSPd+TEvas2Df?=
 =?us-ascii?Q?GqsZgK61EQhWBbQjsZMT9c0XwaK/CkyXtgEl1r6aoQVkesMpfaJnse01jKSU?=
 =?us-ascii?Q?GnT/8MsneJJDAiJHlv2QH06ud5v2kaa4kOTNcEZsdDaVq/DOxrJofegcGKod?=
 =?us-ascii?Q?dHqWlhFUmBkaoMP/a6R3iP/0clvWfzFmh5xmbVX17r+Lv7l8J1Yc/Wl8oF0p?=
 =?us-ascii?Q?RZL/l6K2oD3oGxv9v95CiA3tPfNqznC9xg9T+yTq0vZFhdYJzae/CbkkGpaE?=
 =?us-ascii?Q?qPOVgJlSuKfLCz/XWnauFcxZZhma9Mt8M6Bhks6upJBwo6mN1whk1O8zWl34?=
 =?us-ascii?Q?hcuJuADP3F3inpPn/RnwIAbR1mG8RFgX7kJvlqYhOnXcGe/u44ptQRCrtYaW?=
 =?us-ascii?Q?bTNlHnXRz38v3U2Hu9ePrnerkAp8OOp2Ur3648GgolrQvkEqH46VqyX8KHeu?=
 =?us-ascii?Q?t+fRQ0DOn0pLOMnWx5UqQODb80R5kcrUdezmays5qSNtL38JhkYJ5aX7M3cV?=
 =?us-ascii?Q?WfPq/gi0NqAA4VTVhTNEwy4H5RD99xTFrXsZWJyQsvzVEz1gZz4qRMX+NsRR?=
 =?us-ascii?Q?vXW4ku16wA087YRybO4HPNXh1gPGIO9tbdgrdjkSViYuWiVsV+yy7rg6jcaL?=
 =?us-ascii?Q?rW+8JS8cPwb7U/gnUkNdPfH5caulvGWKufCWwirHgB2j38ycqVBIWeTaPGdF?=
 =?us-ascii?Q?hH+4rKNyJHfrB5wdNlWEADVUkGID32EPcrXJVuV3wrwD+NSagC+ZdQlWQuBb?=
 =?us-ascii?Q?sKtWjc6Mq3JS+Fv8T2tsj5GlKaBGNcCKqwyi+HoOlxwISy0TquvO1poDNbuO?=
 =?us-ascii?Q?qvwGKoh/aE8EUq0A19417c6czEL0S2X8TrwkSW84wu2VyCYHKqk0enM4FnEj?=
 =?us-ascii?Q?b8am17XlJJ9nFj4whgwTQIU+B4H27avZFgQx/aqq+7kpAehH2sglvsjVTP1+?=
 =?us-ascii?Q?MPgesLlNhYnB1HigcW/6SfsmbAdZaq85hXJ/rUFm10rW4T1t3cvO75swwBNj?=
 =?us-ascii?Q?NlPUUjCs2wgyyi4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mTFu2fqWMG+aimJyipK8yQsHtF+3IsotbZOxCQphDGatZOzlv2zcXARIHShV?=
 =?us-ascii?Q?2gxCd9I4Py4JMqmLVHMocyyfcb0Fh9YTLvykzDZKsfAVneByok8b1AIZGt6I?=
 =?us-ascii?Q?8al3IvkKh8IOevca1rRXizJbYmSRV2XteAzKGcqlhpzdTRwXwNYMwBpsJeHz?=
 =?us-ascii?Q?CI/iFV+/HaxNO5dgo40IqhBoIlLWqcxPH+PRwVR6ggdpDtdlmZSY7thGxs6H?=
 =?us-ascii?Q?eDF5BgeG+IHF0xNkwaTRvWi+HVN0FzUok7cDFyGJZFdFqK7NtWa5sIS4wu44?=
 =?us-ascii?Q?OZjGU//SHB0H5LMc80kTVB2knOCBldC1Wvld6iBLLPkTeUXdGqb6SMbkkpMb?=
 =?us-ascii?Q?IVnSNhxOfHfKWX5/4qqjippEIaBKHTo9/C/N440iBSWLy8jz48+Cr/mMnfco?=
 =?us-ascii?Q?VIYA/PEvpyFeHzJktU3YIrx/UgEmIqAXEydkJvKVvpSAhvrWOoMvVCYeq0Vk?=
 =?us-ascii?Q?EaPhrozHQyrn83LCNja2Xvnv80EfEHczeirZ5hHukZ6IExj+VZShInKUsInI?=
 =?us-ascii?Q?Zj+rLRjc1mdu3MVsshKat3l2w06DtiqZTmecpMX1ft43BEJ5nfKS0bq3i1z3?=
 =?us-ascii?Q?uEd45IMjmaTCKRcg7HBWsbyus3ETLdAkf/JehrH3+LGgQ2Fd/mMep0Y/VHV7?=
 =?us-ascii?Q?4EFZOTdosgPz0lpKKQLfMk9ot3Rgj8WPVMO+1sq7L1HLg+oaleEwVzmmFvZy?=
 =?us-ascii?Q?gz/3OTQ1xgkUTece+aaeXvMd/fBl2d9h33DoA6Xeuw5gyXWUyhUFViUWhcT6?=
 =?us-ascii?Q?G4y4LKAhhbe2mPpocLd6PNa6Nus/gcxgNQTUdQOvDTv2QMuF0dek6K/Mbz7N?=
 =?us-ascii?Q?iDtONvld9W/R7zkNWU4OlxJvHOUnq00Rxz2dPMJX6AWQ911nm0Er4r+WPzuJ?=
 =?us-ascii?Q?MO663228Y82x0v5GMJjHIX442ip8c5a8nxDjJrmbKR9eiwquhKk+OFVnuTdj?=
 =?us-ascii?Q?dG9LNT5sJnSIjdc8RytXLzamFqqUINsNd/sci26DwPCUjmQvSsdpmGwZNYBH?=
 =?us-ascii?Q?+WwLtPIfDV3TWepPUAtcHus+fm3KiA509galKk/u2+t93RDkapN35DXLMVjZ?=
 =?us-ascii?Q?uj57YIgMOUdz34z3xnOtNdch0d/LrjuKsBjHb/xNEBUN2HbtsKzBNiJERsVj?=
 =?us-ascii?Q?Ock+WLan25Wu96urBHhK1AqhXsWACLX4tdPwoBL6mc69ihmWnJoX4+r55NE9?=
 =?us-ascii?Q?mnFB3HsbVkcTnlqsa/X1r65A0Gdo5imWU6JHNQ0HD3SvuiJS8Wpt5SlKxuv2?=
 =?us-ascii?Q?cxiSa8T4O6XoKRrfc17PVmz4emr+OuyFkqeURZ9WeAELAIioMXn8CUt4t7Rg?=
 =?us-ascii?Q?ppr1QZNxja88/mi3036iKcoeGfiy4C9eP9k8oyN3lAVBA4VlnGboFT+suaD5?=
 =?us-ascii?Q?ZBrsjxjLsTEdJOipbYjyofPIiQmUQMILENklQwpSykLNSdpP0B37Z0X9mO1S?=
 =?us-ascii?Q?qLfHB2X2wHo3wPbmx0SR34YfoMQJoKWz8s7alyivTce8Lbba8zEcDnJwUo3e?=
 =?us-ascii?Q?NU6CUt/UjYll7AiXBDMowpAeB913VwRNXCU869KjRIPYcP8UtK/VGU7PperR?=
 =?us-ascii?Q?wdFXoW8yyMMRi69vBubQG01CNomn3v4hE1eHxGykQO3Na+ZLrZmyrx4ClLfS?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ac591f-241e-4bce-94c5-08de2dce530b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 16:02:11.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HiFFKEAFVILEugRoAEj7eq7RPvwtAxbVrrRQtXlmYMQTTS1NVPt3UgMJ4B2d6hWMnAlZgXy2KQhF/xFoTwFyACiKQziMa+omDjU+fEb0vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5500

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


