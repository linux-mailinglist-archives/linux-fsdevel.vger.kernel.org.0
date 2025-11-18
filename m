Return-Path: <linux-fsdevel+bounces-68985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D92C6AB1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E81C3A55E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C848329ACC0;
	Tue, 18 Nov 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OFseOLUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020133.outbound.protection.outlook.com [52.101.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D9253F13;
	Tue, 18 Nov 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483650; cv=fail; b=rmvxMQGejO6aJWFCr5zkyfvfLyUR49N6Uv5G8QMy6AwB3ufRC36tV24wuxA3od8Kl2ttcezKdhIIq9oddomqD5Byq0vbuyDJxXl2LjbS+wVbxQfWMDK99MSiQtmwL7uVCYiQnaLyxvwIJcCEtnVQ7cWdyu19MPLKmDvjBP8Qcdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483650; c=relaxed/simple;
	bh=DwGczCv2J+9Hxilji6bptqtXCRyL74fOIDyDMpmI6Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YE+vMu7Bl1lF/ibRmyr2hULbxTqByKh+IIS7goMQ9KFiBW3ltT4Z0QcYafgDMwgk0h6+q7vyPSN+73QrH5YGqZE4EEVWGJ1eO/PWE2er7o4EC80XN4OqkkoojWZ1OfazJ+i4IutX8ELEkX/462Zlt0ACrYcdbtQB9kXLsOEnYYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OFseOLUF; arc=fail smtp.client-ip=52.101.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fph1ed3Ro8KdckP+2uE8iN+N5orkI9ArH0gt0q6yC/0rvMG+7QpA9sbxeA8L90//RBHcrchkS0u/+lkHRgTcONEPw+KPwxJSH5Mo0253NzflA3sPQu3gUBdXitR5nOyfSLEB+zJcdkDQ5bwXoI9d7oR8DKSIH0XhD5p6dAZY58wG6dSeVXJrHYGqt9L8c30vLreyuk1AtNh6HmUNhQadNegAhH4zYHbtOUGvKmQ1ukijysQEtcM3TLY6z+wVnbdXLdmGEGH+8ZbdQzXuHCIi2DIDaK0SX+2bKZakfv5Kw4XkQrc9z2Cf59VfMvENdOpTCKPupKpoEB+6sYpo4W1LxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXkNg2Zc2qwp5brBaFKNyTQlKLobws3PIxisakKIsO8=;
 b=WGjYdv23x9WcBcHPF43zmMthzUhPlaTeSHOtfe27R4nUB868PaFvCJPfw2JQOwfeQhPZagDqeiYZrr+uWC26d/qoMA1L6IRkkJj8Bf0vmDIVZy0qJHPzz+TCcRJFij/YxFqPsvh0RN3AHzp80aR0GulXyxchLg9zRknvM6+fqq4/CGu1Qur/bRqi6UwE2OFMBtRuSWE9Fu/24vD9zn6IrIql+GODr3x5cWF1xCXnowvUC0xY5pQHQe3N8Ca10pWMWoVdvlNO9L96OyBZ/a+Gjxl5kSYOenXn/SjXSGltPAOn/fqkct65M5sv2S2TbXM+c1W4SmxsApKUtQ+3JQCNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXkNg2Zc2qwp5brBaFKNyTQlKLobws3PIxisakKIsO8=;
 b=OFseOLUF9+I8cx0JsOQ7pV0+cHclj8jwXDqpham+1TKPIQGDnBcAVLlzGPt7GNNBJD6tskkdZDktX4o9tpHfsHotAPyLa1Fy6jNlhvl13d3d+/YEdPv3wdnVaZRXk97RNHix9jNe04H8+fl5NWHXnn1j9H8+xpXZnVosYatKQ+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by MN2PR13MB4072.namprd13.prod.outlook.com (2603:10b6:208:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 18 Nov
 2025 16:34:05 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 16:34:04 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v1 1/3] VFS: move dentry_create() from fs/open.c to fs/namei.c
Date: Tue, 18 Nov 2025 11:33:57 -0500
Message-ID: <9d219b32fa06998fee599815022dc70ed638d445.1763483341.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1763483341.git.bcodding@hammerspace.com>
References: <cover.1763483341.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::16) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|MN2PR13MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7dd31d-a86b-4289-5c46-08de26c049cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6M205+CWvEViK3ZRfImX1Gq9n41TgVq+oMPOPHfCC5cO5/HQOMTfPtN44blQ?=
 =?us-ascii?Q?VZCeABCg0zL1Z8AKHs3JQdAU7QoW2p+q78DHypZOygo6J3Fk33QDOcJ7GEIQ?=
 =?us-ascii?Q?5Hfw9umsp0rtsu1zxdcwo3NTa6tkZkdKqJIxE6bShwIDFPZcomXWBkaYVB4i?=
 =?us-ascii?Q?fAATYXBYljuxFvAZAaLp4uhQMMqA8XbcECND+m5CoejytzYl/HnVOjCqyYga?=
 =?us-ascii?Q?5Y86ag3fCK2sCpkMSLn4lveySnryq6dO44HsEK+eoIIKIjw+XaQY6j5TNfLU?=
 =?us-ascii?Q?4FUX7xLhxxG4YtElq0Jpw3orSl3L12bLn1LFpoxx0jfa8vPk6Lp9IQOkVaix?=
 =?us-ascii?Q?yu7YcC8psJBaQG7aOf67Yrd81my0KvuvUJjtmg1VmWREjJqGjC6zON3b9KG2?=
 =?us-ascii?Q?f1b97Rrrqrja0jzv112tf1uKFCVZFv1SKebTjjqcFkIOFHhDHA/c5EGwzZJK?=
 =?us-ascii?Q?3YM3mX/Hkqt6L/UO+L8BM2IYq4mL75D3kzCyDCGAtbZCfuZeTvpvTDMJqiRc?=
 =?us-ascii?Q?NuG9IIrOFbWY95m3uw2nUnbTHlMqXG37SzhCpUUg/QKeeSu2Jwt06wBTsuCP?=
 =?us-ascii?Q?BUNYU1GzUy9FuBCrmE7maP9AB5mHD6pBXXW54tIsZYppZB1rHDPaGVL3X9r9?=
 =?us-ascii?Q?pFKcz7/ApS7p31wD0foFyEVIwB1KmNL96JVk6dtOgY2dqJ7rMsFFDBct2F19?=
 =?us-ascii?Q?Ivotxgfu9COY872vAy0VNcIlUd0FuMAsktXVYTv4eMMeedMPfFhQ8c3CzUrK?=
 =?us-ascii?Q?uUuqeW6HfQm2OMFj2/Tjc12DPZ/w83Ks6OwNRWf2nk8VBRyjGeDcXvelVQbS?=
 =?us-ascii?Q?7eF0FKg7dqVR3spxYsPqidvZZYxo8Y2yz3gsaV6i6i0+tPYocahSBo2oGR8j?=
 =?us-ascii?Q?SYotvgsjeLJSjcgZTncZ8cBYaJ4tJQWEla3OrASIyQTSt1OkbdpkvzcDqvgu?=
 =?us-ascii?Q?2JZwR/8eqQe0WyfF3AaCR6egC5aWeIyQA8kwA/84svMzilHr9wasxYg3Txsg?=
 =?us-ascii?Q?VIjUlr/gje4iC4zarA7ccrHJkPQEk9V/NLgo4H65Wtu8g0Y7TkOPXoJmdcq8?=
 =?us-ascii?Q?GK/utplhaDtO5KOGWHezhBmYFhcEj2E91f9Zmcyl09JLX+WA3wsjG8ljqIZ1?=
 =?us-ascii?Q?8+HFgXuUvBr6gUiSsHOW1gMzFZB/tqAHv8RuWi8/TowIe/PV1KMZqX4xxkmo?=
 =?us-ascii?Q?NAB4Ms5Bc3uyKY4RI9zNvryVx5BfyVjbl8sJIPSX/+SNle0WHPcUNbCppv2c?=
 =?us-ascii?Q?5TIxMxc2XIFFPa1H9tVHJzmKrd3qO787ckdyE1A9XjOyee1sJNxmiDB5b91t?=
 =?us-ascii?Q?FokO5NnBwPkAsBWVU+t/zAskJxdhIgxHPW71Z/LM7ADZReadrXrsnF62XOSz?=
 =?us-ascii?Q?HMNboQewdEKCkNSvCkTbRkAQHlYnDr2lmL2CBtTR7IEe1f33EFOM3jKZ99RL?=
 =?us-ascii?Q?bAjm1mzd4fHPn6yZfZ8iVkUIpqF31yUL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+TQU29dnh1VRz2N463T/q2+CzdH0uW9bh0mNuHylzDRtioBathKPINMb5X2d?=
 =?us-ascii?Q?YSlkK0hKK80e9t9SnOw6/IFJORcP8l8lfL03F2bxm7/fufeFAo7443EIqkMs?=
 =?us-ascii?Q?enjg+G+7VqXzN2McfuY6B1xOvrw0NCKy3XXYesmhx1hIgx803TlXamZuPZgN?=
 =?us-ascii?Q?toSR2/d1xa2/nCx7YQ6pB9GoitE+acpWlpuGBPkz63ZF/JNC4zRcl0CdB9Zz?=
 =?us-ascii?Q?OGCHTIkm8gwqs24URtyuvAlY5LKIbRZBSi3xdmNI5Np1CUAw1Bi1Xf0YG83N?=
 =?us-ascii?Q?RRZgA6BTDKOAsgnoVA1g//mRUJrxqrAFtE/JlZKy+3VibdAe/WfvteqKdzB8?=
 =?us-ascii?Q?QhpCasnhHzU2YAi9XSEMUOyWAQ0kwmERtkwGU/GzEYJ0DMnVbuJT7BhUdojf?=
 =?us-ascii?Q?k1l1nAc6joRGvjAaangYAO+4eKZMU9MBN7xs9mMyf1cxF3ahH4wvy6lSwDSr?=
 =?us-ascii?Q?E2ESgeHwOv0JjVcVbXMlR98RFqIEutiBKhHFvc27IHJXvJfls8Cw25512auI?=
 =?us-ascii?Q?43rFX9tzx7zF5k6SUaFL2WtavbyLBocDe0N7suFjvP5eABIYDFLx19Yz8qZ2?=
 =?us-ascii?Q?IfmTAzY8e20uwAhTUVxCxosFa7iVXNXOr45tLElPdfsOtgdy+orj6RvDUBfG?=
 =?us-ascii?Q?07BHNYqoRbln9W0XMVvmVMdHlx/5wvT2HV7luGPZ/t8cX5R33om6muzNja1z?=
 =?us-ascii?Q?qneTfyiSxv2DQuZJj40ihhzvTEpacON8+i6KBYoXIgWXR7VBnyRIk51j5KNW?=
 =?us-ascii?Q?wGZHoZIuxrm25cH+IAvLz6auZDKiCI8eLjKssHVM8hyVCo0QTuixMpgm+A2m?=
 =?us-ascii?Q?dplO9idEuCFEGateRLhFpAMYunPpWI4RlGGB9Yo4DfE/Kau9HrhTosapeScl?=
 =?us-ascii?Q?7atDsZLkBWfdl1KJe1JPMf3kN7uXaAgt6jrfoyd5wWRs40aNDuNm/VLbifwG?=
 =?us-ascii?Q?XlRaiPsn5liFvo72cCjFWumcUZrgZ+iprCXTSM+qKWm44Q2Vm4DxyVglPD+I?=
 =?us-ascii?Q?0BO/+lAduynXFJpkmOLAlidqoQOAxCXD2+ex9QCDthhpe4Cvyjw7lRSsX7bS?=
 =?us-ascii?Q?8047YQhAxry36TlGTRHU+ncyVoMKe5JrtRTlhsCsfQIcWooSzSGmjjdtl12a?=
 =?us-ascii?Q?tySYs6dQrNvRs3Qbp72m7gmpvolODoMt6Eh8ZDjMFPQ/N9LlbNfM94hwXt3j?=
 =?us-ascii?Q?ACQXvFFO6wDgQmtwmmsY3KYOBSWrQKyucbBRzBKuhvJ8+6uZUnGlPOwr7k+U?=
 =?us-ascii?Q?RTOPNSViie4Ni9BkEMBtEkl80deMvrLf/zj1yRe2m0HadSCWq5OF3kNScxKF?=
 =?us-ascii?Q?zgPYPAI7wSlr3GdroW4FdKpT4NqVrYoJ871c+dD/YsemUNF+vlQJOZ7x4nuc?=
 =?us-ascii?Q?HVyHAaGNqa5g4YYGs0Jgbi+Rsy2DH+iXbLTtBcG7X7YSyi46QnHJ+woBNrWd?=
 =?us-ascii?Q?vf0Pzn200q+NWlAbZMngzXwRLd5SyutgWZ470xROD39RhrsXoz3HfGlnTkyw?=
 =?us-ascii?Q?8/adJghsd/7EuJa2Ez369bg9GS42nlPXDNAyfOifYMdTfNdV1J0QAYGDdavi?=
 =?us-ascii?Q?uUOT8TvGC8coXGTDU3OT2l5rOYieNIZtb8UQFmRjNQ7mU2SQ8JlfY9qx8EJP?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7dd31d-a86b-4289-5c46-08de26c049cb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:34:04.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUO9r4jAYKv/uBwXUZHW9QztCzAU2e6G/mQMa/g54/AIuySzG42A2uenTQKBRVQKOWcjASYqPT9wRiVpUbytO8hF0w3124MpRVnBxlt0V00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4072

To prepare knfsd's helper dentry_create(), move it to namei.c so that it
can access static functions within.  Callers of dentry_create() can be
viewed as being mostly done with lookup, but still need to perform a few
final checks.  In order to o use atomic_open() we want dentry_create() to
be able to access:

	- vfs_prepare_mode
	- may_o_create
	- atomic_open

.. all of which have static declarations.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
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


