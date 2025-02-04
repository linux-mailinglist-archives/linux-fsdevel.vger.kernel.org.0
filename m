Return-Path: <linux-fsdevel+bounces-40834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB9A27E92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE0A166620
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF231221D85;
	Tue,  4 Feb 2025 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sGbVe6xb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AB21C193;
	Tue,  4 Feb 2025 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709341; cv=fail; b=sa8o4/837K347HJYlk/Cy7ooB5qRsuRRxL5g1Rem7Jq8JbxAHHEWlS2WNfJ+byhYgjLt8zDVYs8bBhVqgihr8u8YfbbvrTVeVW9FogyE98yi4jTjJ16KZMRhf5qlZtefe1y4dvJIClj6H0GB+dMhXdIPTeQ0kkO/uUwIGtV7jz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709341; c=relaxed/simple;
	bh=JgKeSG0jPINKnY3MMH7kvv/oeraU9GIBDBb8CKy4BfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=byCId7mltBvC6rSqsJ0ok2t6mg4pAP+dFl6qudD+xiKP5osqv3GmkufFqxU7YEOVMKwwWF5ltaGJdEW88tHer4KzVo4ezvVkGU0YUJj8S3azzW6DfLUnhCg94YFDVpH1AYAzTlr+Wt+IbH6wW41B9Yrwh/XTPnmADRya2vSCtBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sGbVe6xb; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNOnP+V95JEXGJ3u4U3JI1V/riZs/4j669baCpzEBZennWRl7PjgmQp4lRV7s9mmO8m1qjeGXdsKPy7jRRkFEm42csHhn3/cFotV58w8aLGpdEWGgV/jsopJ+Xn+ypY7CPtQ1jMApXuBubN4FfjivRP2pV2AmUeLLtiua/QdsBPBNsZoTDRon/HFwixULNrenk9qKqklFdAttEdDU3VSZ6FwNPnLCJyjG4RBo8dgmL8JKfHMLqw+gfme4Imv1Jep/7mXtOeqL61tBXFvRATGOmx61DzO+rL+k9RzlshFDcWoL75d7iAGKqQzPpUuAEz2jXuv7ujRoc7YXEbxZyDJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/Fa2ZekTWhZALAVQHC6hy9omuVvvJHtpbIXF2ikkLE=;
 b=Lc13JNv3Y1br5uSxD72ZNdGMBFzptN3oolw4xm46befpb5wUdNuyzkbdhsS0R8slXntdzCvDRU/srSQSQLm9CBxKsmaLmEugJYTd70ss1uXVN/9/Tty47hLNmKUu6Q2U3b36UPwS3vYZGPSygL27vz/oonNNXbnAdFDNb4WswSVgBnkyZgploGd8mI/aOsKC2z+PfQ4nnkntB/RE2U9twVw9HxSgT3s7+EsGq+0EbkruPS5DrVjsQ+c2BgFoiBCZRTK58F3dHPGrPlufniKI0sH7KGuNDLSk/7dpbwATqJ3u/m2K22a88ZAcK68jSk0wA6VzA4RFeCNlU1rwsbo45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/Fa2ZekTWhZALAVQHC6hy9omuVvvJHtpbIXF2ikkLE=;
 b=sGbVe6xbx4gTYFit04YEXq2xQHHcBD2tvVCVtX+76eY1ErEpux60EK6YsWKQixm5DCB3woaOVm+2Z8Jpxbyrkgx76AcmaQmhig4Xtd2fL2WKmYmaAg2IRbxOwav8GUtjqbFvr3ADZMN0EwZsqzRsdJZxSosZBBCbnH9HY7QLZvnJBPOSzhkPvAH9EMDXtxF6OMDZ3f6HrGriDb988N+xJA1u7wTaecw6siP6wBpMBPpYTxxARXSP3wf7jdtzrZuxz+rTAfXtXgVtkxEt2jViirh7umovPDwCPVEino+huCUpjXkMecCp2dtG6oojmk/dWnaLQwcaNbatLayo+6Wn0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:48:56 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:48:56 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v7 04/20] fs/dax: Refactor wait for dax idle page
Date: Wed,  5 Feb 2025 09:48:01 +1100
Message-ID: <8e6f61482cd0c0be1750ecd5b7412fbfab414e49.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0064.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: d30c4b65-90ce-423f-2843-08dd456e1b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lza01wcp1LuJRQSSOSVqkGJIBTZypd72zc2Iaa5Rhli9uhwCAxrVds7tG9YM?=
 =?us-ascii?Q?Mwtkzr0toOo5XRu9enmQeujHva/N8VZW3P1eyfFgZWFon8GJ8cHqTUAme7cX?=
 =?us-ascii?Q?IOYapSP9iWkldq7P6BUbytHFwl6vvktNKlYaU9MGjpfN7sQ+vDiYu0OvbO7p?=
 =?us-ascii?Q?59VWjHcRJ57JIHOybx1mBsOs75wxdhgueyF9Woa0LtRN8Q24FuLeOFJaZxg7?=
 =?us-ascii?Q?OtIAGMS8PQABAdoath8/62hyrA84P9U3GDQ/AsnWV3+ivbT8cZrj5b86O/IY?=
 =?us-ascii?Q?ojR6/vgDIWTXn3LscHnmivvNBCHyJiVbtyrdk904zsvLxrkRI/aqOOvBhTtn?=
 =?us-ascii?Q?Geb/e8wmdWU/zSlkVcsVxJuig9yiWXTVfuTG7pLgsoybK/iR7KH13wTPgRqJ?=
 =?us-ascii?Q?1JqsYTXUDknFO6jywCoSNm2QSX4u0qMA2NRxoSkrmLmway5Xjgw0cmXtIy/s?=
 =?us-ascii?Q?XFbSRDnsHfirm4y0ad5UxBaLNFwfwfCFQNjJtPFbwltZ3+3XNuKQq3Rb+fY7?=
 =?us-ascii?Q?1MP4y9eTZQAd6EqPxNGhLpdA5/FGL7D7T4Q8pVfWhrTuJlTCRbngWbADJJbt?=
 =?us-ascii?Q?J4OPz7mg4et6xonKtx93LxI33jIqK8N8ztUpJ/NeUlgddD/8d7rciIDIXlix?=
 =?us-ascii?Q?Qjs0ByN8DxdhryY5gGfQb1YpVhyQGWjZ9Ps350lfEloRExTctrHWM90+fv/g?=
 =?us-ascii?Q?YHqgpDwdqEnHvG9vJEgIo1bbgdMm3u2gEmsOvefP5RBcCzIxOCgOLkqwt+Pr?=
 =?us-ascii?Q?yQ2+AbCgm6aOA/2rz/gA6PVQESXRUCSjik4+O/B2WUbavEbl/nVYLyoG2dZt?=
 =?us-ascii?Q?sIGrW1Ox0xSkK0Gnojx+Zl8SvrurxZFOpn1DWXUK9jBSuD6LNINPpId7EmWw?=
 =?us-ascii?Q?sfj202OR+zR0cdLu5FpjYr7KQTgItAMXiZEiLkVvoZs3Abdlt+hs5ML+OpOT?=
 =?us-ascii?Q?WlJhWr+ECqaEA24mP5TR794qlkAOHPZtwA6TESETm3tBztAr3q48brX7HAt2?=
 =?us-ascii?Q?0gbIUIC51/lwuYlz87ZYWiNyXMRH8r/z/Vol02v9VStms2R18+7ebei8ELGk?=
 =?us-ascii?Q?CF6K1F0J5JBDsctPHWQcG8TisSWqqHDunO0e6exofsbStVUEFOXpluqRbi/5?=
 =?us-ascii?Q?77mnoW/s22SXBjFkQzBuah/q7BTa7EgHyW1C/Pw5TfZYVenELzAKBLT43FYG?=
 =?us-ascii?Q?Zi2ucBG4fwn85lSuxbwfoO5db0/58DyOIFiiDBhmi98WJCUJcuCfpuW19uRo?=
 =?us-ascii?Q?9dgsf5B6kbbvzlsYFzFu6SZmE794MFCTi54LNcxJdfnnfI2tmKx8Ud+i6415?=
 =?us-ascii?Q?BtMdmKosoNO7x4dw/Gn4RRpsrN4i+4m6bLF4EdHx0PAuZu74C44RKwGRifnP?=
 =?us-ascii?Q?K/YupQdUT/NR2utoskvLrZDQOAXQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2ROUHIKr0UIQzZVvpkPChBdsypxcicK9kNl4ZlBbnxX+nNy+0B9c3z5afDM?=
 =?us-ascii?Q?TH+jbb/pwjy6kg7+v/MbDhumqRFlhT5osBqfN0oc1F3OVDdcTqsOCaqYeK6Z?=
 =?us-ascii?Q?A8IJdCjFkxyAYSGzJyuhGRot/fB7LE1YdkFqf7clKm5o8XV6TEG73ENmqdLa?=
 =?us-ascii?Q?QXfULgbfKdJYcyLQhahHW+6SX2YHe5qrMm8tAis0guuas208jd9OW3/WHclL?=
 =?us-ascii?Q?HK5jXUDWp5wsLmpOnZB4jWwiHCPtRR5Kyt1Ct17MX9oJbncRxHIsQNuBgSeT?=
 =?us-ascii?Q?BNIBSdMy0SEu6+px0DGeV/y74M3AmF9TfLSGsxY0lhXAPwBNc4MsJSBRbGqv?=
 =?us-ascii?Q?1njIboJbZSUhiP06EY9r9DIxYaWS8UgZJFU9vwT359ZwaWAKM6pBgiBpiQ3t?=
 =?us-ascii?Q?wnvC3jF2zldwEpm+vkuiidpMmUyJk4L7RAoqfGDnP9VAb2Q0wYkKCnYy1yKF?=
 =?us-ascii?Q?uziLFidYhUlbL36V4oB6PwJibT9vb85pGlRYvnqKehG1q/OB412HMqnpf8tf?=
 =?us-ascii?Q?P3cxfIPnuBZqweSAQmSgfCSMA1Jd7eMMMxrf6SXC4znZRHr+RJ+9TeHQ78zG?=
 =?us-ascii?Q?vQ5qQzZsAm9k649Jx3C4qC4I2dtR82ZTZ+45aoD9NW93As9Gp7rQ6cZhPGE8?=
 =?us-ascii?Q?9kAJahbAfVqkfiig2Ig10Hw0pWU6btBBHaeI+84tOar0m0m6UNwP72e5G3n0?=
 =?us-ascii?Q?oGZnFkiEnvyMgPu5u5CNB6Uqnww3c/c1tYQEIRJAIaLO562ZdeVUyNaqxvWa?=
 =?us-ascii?Q?pPLg6tUJHEkYOMdQ0ZMK8iX+q9LyLTK++EqF3s5GRLcfuzkQob99nZOwt8Oi?=
 =?us-ascii?Q?kbvjo0Sh4/b5mlx95i9J/lzz+BVnfS7Vk+pXGStz69rpfD/QhMgZybtU23zl?=
 =?us-ascii?Q?cIzcwDUmMxBMCXCi8pT8sM2Kb5rwT48NWJR2mHOKxP1R5RX3yXgYt3vr4YlF?=
 =?us-ascii?Q?iY9ZooM/ecIoOaHPRoKgrSEJhkU4hKxSg2kdoRQJKIWxN5zLBvpqUF/iW6LH?=
 =?us-ascii?Q?tTqXN0GBjQSXiygyzIOluARz76Dq3zM//BuPK7V3w5c/b1qolvh1djnciSfe?=
 =?us-ascii?Q?YaOEpc0XO9oFxwLOutiTz926IZCk2bCvGEZasTlGw45nQlRn8fc5WCO3Bd+0?=
 =?us-ascii?Q?YuBQ6Btc870imH/eo+1+ZlaHKqBuZRUJIveNQuj9rDTahR4RF9W2hJ0LFuFM?=
 =?us-ascii?Q?cqIDHL6Fxl2IdROD75PwNj5CxDaAcnaiyMjDAgNwwqO1KXsLsU4KjjctZM96?=
 =?us-ascii?Q?HZocHcuD9ozCoOQthqZf79E4ZC11ksy+xOW9yyKEDNiIA4fIxGBIuXq1YpZi?=
 =?us-ascii?Q?VChsm8/S2HqF9CynE0ZvkFHH9I3mmaoZOGTUKxRtkcmhZZ4eUuv24Chs6hAC?=
 =?us-ascii?Q?6RwmwEatXUH5LO36fQCSsG76dqQQci06CQQNnl4BZ/K7BT5eGq9Piah5izNi?=
 =?us-ascii?Q?DvPUfZ3RKbEHLtrfqK4JCT1e2jgtc/oUqTcNJUunwVv9pPnlat1/i9wttKzx?=
 =?us-ascii?Q?DN9a1c+Q7QPKB62ZuwasMIUChu3jkY6J3cg+gmDovOafWQPcrdRLur4RB0oI?=
 =?us-ascii?Q?yYBEDG3bI5pHf4uUdmchclxkFW1y20V2LYWJR5lA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30c4b65-90ce-423f-2843-08dd456e1b07
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:48:56.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0I33VvBlHso+UFioXF/4hj7P0xREtQjn87If6JL2oPRwCGMGF22tnAObA12jdqnWVO2u/0mvT4yoGswLU+FB6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

A FS DAX page is considered idle when its refcount drops to one. This
is currently open-coded in all file systems supporting FS DAX. Move
the idle detection to a common function to make future changes easier.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c     | 5 +----
 fs/fuse/dax.c       | 4 +---
 fs/xfs/xfs_inode.c  | 4 +---
 include/linux/dax.h | 8 ++++++++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5..cc1acb1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3922,10 +3922,7 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) == 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(inode));
+		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
 	} while (error == 0);
 
 	return error;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index b7f805d..bf6faa3 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -677,9 +677,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, fuse_wait_dax_page(inode));
+	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
 }
 
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c95fe1b..a457c13 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3017,9 +3017,7 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
 }
 
 int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index df41a00..9b1ce98 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -207,6 +207,14 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
+static inline int dax_wait_page_idle(struct page *page,
+				void (cb)(struct inode *),
+				struct inode *inode)
+{
+	return ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
 void dax_read_unlock(int id);
-- 
git-series 0.9.1

