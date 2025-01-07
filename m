Return-Path: <linux-fsdevel+bounces-38537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF38A0367A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657741885FC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3E1F0E34;
	Tue,  7 Jan 2025 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AVASDWC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A41F03DC;
	Tue,  7 Jan 2025 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221471; cv=fail; b=eBopEQvbJkoq5pnBMrgnJmjIbbnqOV6LTuFd4SHLCO5h3EeKgUpnPCDjTdDvOd95pkNsGH+j6/DDIcu92ygaVGVL3v1n3nwmEq+LHKmfzy7Qwc9XiUpTyWYS3EE3LEjAANq6v44M97d468NDmhilFA+s0w+rmLNLpRGiBOeY4qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221471; c=relaxed/simple;
	bh=ENb6SZxQecnoaFbHfwgRGbaSbQxHOqcV89BxHel02z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s9gmW3kD3DVga0+FbDYxaWx/i+s0B0oujm964bjobZ0Iztn5mrblAokXjk+X7oaGCCLpeILCOiByLQwBZ5gSTq8apHuO3bEWmJLOdxLuh3dqzeMptzZ0sHNQlkDPUiU8w5y84NKSBZ231n0Z14rwD+RBPQUcqhMXS3dC/OPqQYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AVASDWC7; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djna9EzuPjqmxj7aIRuCPylBnro367rGX/ulg8eevLteUWODeuyYk/BTaekm7H+LvF8inusIsuOiwsyfUG0UzZuqX9qUmbP6C0gM0YFs+Yz/Ku2xdYRNyMTbdAsS2FzvFnpC0Sbbw0USvH/i73W2DxTgIU321Vmgw4JXr3z/8CCjW8wycjk9TJVMMW9Mv5MStBd3t0jAR12jWY4Ozx8em1YeRbgdDSzs+iWt2NAs2vLUkCscYG/ALUgS/YufwKkdiPpsEqWaoqCMdupUQHckXEE2PYGzlez8vh3oDqke2I0tqevFxOHc9rsX4JhdUoq87DFRvYRdiwElftfNUocolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvFcZCSCKcpqUQ54gxypRLCdDBXUc+Lz/TVUpjcAZiQ=;
 b=olTjLteFELl7eYkhAdxaikZo8WDRR+/trvGRjuVjr7wPX/NpaHIwC+2KZbf4O3VIa9E6rDz+aWJW4HihvZMreww+gx8HSeIXtOCrwx16Om46pSWlICTj2U81AjbMLYbQQIm6z7zPc+PSwj0aIbOBkHUqzHmKcuzT0VftaPiIuyOk9d5MHsKmekWR/fN/7Ut0gyIjLgn+4Yhn6mLdD7WZVbxpNancFN0+51Yzh5yTD28lX4jURs8BWWrlr+CIk2OWznFAu6GNdYWGVZ7cIO1lB7a111l2bB9VupQRvoGJzvm/REPbTOADcvZVqMF1iadUxjo4ZP+AP7NyXZGPvg8UEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvFcZCSCKcpqUQ54gxypRLCdDBXUc+Lz/TVUpjcAZiQ=;
 b=AVASDWC72YI0KSjtaNTvlNL93uhomP/t6CQy8uXHcc9zH5VJ7hlZAKibUrylckYevGb6NUOurYZ5g1GO/9bROSlyuSvCcsib5KOM1ui1DaQsfYdyagYoBqiW6u6gFGxf2pIlIhxNBFANygIeyVBDig3fbZF2PB5t7U+WmNethxuzjkY/u4N1+1JmJHEaazEzm1CJJnkStKSub4lByMw7CD42wbfyUmpkBv07A97Er74N5SFdXcENoAErQslrcUCcpC2gt2W5goECRtRpeKp0mp0fllxcT5I13Ehe0/tIHN3uIf4UVUOBstrKkH4ZY9JvmxkPdWJJVUxzFAFB4P4w0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:44:23 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:44:23 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	david@fromorbit.com
Subject: [PATCH v5 19/25] proc/task_mmu: Mark devdax and fsdax pages as always unpinned
Date: Tue,  7 Jan 2025 14:42:35 +1100
Message-ID: <e17a04cf8feaa838e62d0c7d1de97444222b7956.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0123.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db0ad6c-cef2-4653-4543-08dd2ecd9373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dNJ5yOaLsC9EBW7as9wtgjrGXpHHaMKnUKLzY+HkRR2/dz2VPGA7uHC+zqY8?=
 =?us-ascii?Q?jXGsJNsaCQ5fuAoTWjjWXTDf2FPnd8udrj2UqQ/GtNiAotc+Xu8UraTbO1tJ?=
 =?us-ascii?Q?Z6t1Qapr9+9xVQsL2G8Q+K8UTgg5G5OWe1Q0L7JNT7PGxnqhKHMf3zoXon2/?=
 =?us-ascii?Q?lN3zCUO8rlmfNEqjrNjXK7OXRkNZn87WUT8vqFlFShQQ5iluIQ2lrE3hgYl3?=
 =?us-ascii?Q?LlzTlcczWBhKiu/TrdBAlIMrhW0vscfe4Y91U8V4DHmXUKOok18Noia2Zhu3?=
 =?us-ascii?Q?78LGhTb3DaBJAVungmRZ9XDA9l0ief3NAxhRhYdHVJV+tKvU4fjA4sUYHpWD?=
 =?us-ascii?Q?tqjuFQp6lWqRHdFB5Dlf8j9Ur8NVOQe6opeBSc5zn/k245PUsbQ9pssiM1O+?=
 =?us-ascii?Q?FdAi+1HoMI1L/wCPtkztMp5zBspYWZ1V7xRCSLvVhDGWDALzCdgVZy7GAASg?=
 =?us-ascii?Q?15zyT2qXWMLN18P0qICYfwCnlf1z4Ehb60Cv9UWRuWOzhWUIvBFOJqLEYCS5?=
 =?us-ascii?Q?qfKxDX2UN8HDyNI95iDbWvKWSWOTjRX766ollhdSkhvFpa+mQKI5rDrzFgT/?=
 =?us-ascii?Q?/bCHKaaco5V+SltN4YBwNt5SrV3dExrjb1tJat+r694Roujus699bIrt9hqY?=
 =?us-ascii?Q?afR8AqsuOZbeZ5mJdd6oIKhH5UdeSHcjcQB5yqz/ixqcmyNeFE0kCKzF3hHd?=
 =?us-ascii?Q?c6T2bl6Zl7YidPj2HolSKxdbMHBzjDj/XHjMxNV8lTwLNcMQO45H+WmXVsjp?=
 =?us-ascii?Q?hWLhD+zbYjEjSGA4i7zEHGk76kEfRSaHrS5inLRxS5fbW7CRDwkmb+WwKsOS?=
 =?us-ascii?Q?mS7EpuSuIyI+ZFhF7eHUS6GhDX6nIujvCbm6Vooxa4WZ5rIIuieWtLEAmLFq?=
 =?us-ascii?Q?p7gYdQ0rirmtsRbh9YQNPIqwtnyFZaWf9bkav+Pxkmb+2RHAnncDTEhBn9Cn?=
 =?us-ascii?Q?gll7R3Lyh/pwwoWkE6hn5q0evqaf37DG8dVPSZlfljCDQVUP9c6SJLataGRV?=
 =?us-ascii?Q?boUggj4Zw1+IuJCKr9uPUo3UGspzUZ5yS1X2ovUHxM/vLWp/1DWmgD4RT06J?=
 =?us-ascii?Q?daRYKuJeTB5Wtsj8iCPG3T34uo5b9tamrzM48t98Geq4eBEVUMLJTf4WQhKn?=
 =?us-ascii?Q?qPR/6jMvLdCgcBFMeW4q6Hn21liRcyH5YxbNV1YtaQK/VMP388NGAnElLdKH?=
 =?us-ascii?Q?17kHpfEaxq/AFp7xvJGycoeYPBunkHzIKN8Br+lSG7fEcVtUjMoe0/0swrtI?=
 =?us-ascii?Q?iHA4uCCfsA+QxjlTrRdWbbacBfsB3gewByMVmpcxyxGrpJZ3jPOl3hi9dBNY?=
 =?us-ascii?Q?kRikOQlhT8a7VivzyVBRSrYV7tm70smXV8ucguKd7WNioooIJUCrsOrta+LZ?=
 =?us-ascii?Q?6c6nPPwyXtMTOrYbahwu+2zCjMWT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KN5RQxcnoX/1zvmV+Og0piFX8gsRizeeqkyF4JQOevYS3hbVmdUsOEHNdaTX?=
 =?us-ascii?Q?ApcsEgDALr93UQyosx2wOYte1XZ5U+EZLUBQFSX7EU9Gl3GRVTwzjDUFTssv?=
 =?us-ascii?Q?k8u8J/0SphI0Gwwp/3iZQHGlzIOBG3cqGa3aN4o/OUTPlbHdhKU0/OotzeTi?=
 =?us-ascii?Q?ILRXybYHRh9+ogwpAcxmWueg2jl3ktHQqTeE3TqpiFeFqHpSYXJV3yOThlrh?=
 =?us-ascii?Q?xaXSKIhNqohX0m0vwWP21aKJhX9r5a3o3V2lItWSy7EzTgDl30Mv0kUTaoQK?=
 =?us-ascii?Q?58PT3rWnBFgQaw4aAl+DHDed8wwDgjDTJdjhzsyozOiWWYoNNtpxquDxYuP/?=
 =?us-ascii?Q?GdFAxE8Q9Vbfmb/jfxVc66uLWvC4v+kqsgHdN9SmeFIC9YJZrRDEOjwzRaPk?=
 =?us-ascii?Q?AKS5zYqKnIkMiGKJ9ETJF8zT6R9pqrFjPQlXZiZZKlYU3g5uP2AcK40Aeveg?=
 =?us-ascii?Q?RrTBFvwWeKFf6ZcZpNQVmJ1cL2tetdjhJN5pGpIfljHM2GkhxZ2jdtYhCUOT?=
 =?us-ascii?Q?6A0RZd5K1MMyPIhkU4LDzoUT14v3qqW+bXlL/q1QQ/xXvDC4Zr1MNQgR9fqe?=
 =?us-ascii?Q?jyi55lbMlJAYPyxFMWlSRGwO8NjGJetZwlW0+GOMTCq/eKi/NUf6vpLsKnWx?=
 =?us-ascii?Q?K0Z9ufo3Yyvo4CvxsufYRDwddYx3EG5dPyYaTvKtwBR0qTqVlXBL3a1Sfx43?=
 =?us-ascii?Q?493DPJLdBGYqAD9yO9KMzA8X6ZKyErzFCJcKoX4155rqj7J76o8xr3HjD1Ef?=
 =?us-ascii?Q?SBjRJB/YyZ92ISg/OfaodintGHgJGmMPVQwMw4Wm17jXDMObu9XxlMRlpgzx?=
 =?us-ascii?Q?xNDXBPrtWXPrMbLm5Ktwd1K4ZKSGxJKPDYlsheVPHwg1GYGvFSZN8hCXPJnr?=
 =?us-ascii?Q?ExXbVTPlaWjiMCQUCVIAd7l6DVhDnx/FRy3k69SXUKqTZM6iEleR/5r+ixvg?=
 =?us-ascii?Q?DMD7ulW8YC7OjaycaJo0ZJ0QFBMuY+Crhf0l4lil9TkWLrVMOOvKJgix7u0k?=
 =?us-ascii?Q?rS/fnd3WC0wfTf6j5n9x7ayuSiYArXip6Bpl++jDcGB3jakeO7mnmU6pTi3z?=
 =?us-ascii?Q?Wd+SvCByfW6d5WcechvO8qGPeeL2b/LA1xin8vbl6vT863QNXF5BmPsmtq7+?=
 =?us-ascii?Q?MVzSorYIViCt5fiJJEANEeeO/SYdL0IZC/5ciAnMECWTJ2QgB8GDlpan0Q1y?=
 =?us-ascii?Q?J5NfurjYiu+YRChFDJ8a2E1/fMUcWU8D2ACZwqBpHm+4r+VjDqdyaZL7YixI?=
 =?us-ascii?Q?6eGdU+uhiZeotxdksFf6pZzmHC0G1ZouzUXxRnlebl8AawR7p1HaZx7RarSl?=
 =?us-ascii?Q?P0GVDOuT7LMpH7457iN/XlYVqWDll2mdO3lfrsy03iba2M6Z4W6sHTBwHKWk?=
 =?us-ascii?Q?66Y8WxheZ/PDjGD1v9b4oyKLuiDTsP5g+w0v0eQGvArp72G2miBsuCVbu7F6?=
 =?us-ascii?Q?U5kBQpDRYTcYClBCwRxtggimjV80+w8qyKnmrSm+5CYAeDKcy3wCxSCMJDIV?=
 =?us-ascii?Q?8ZUlypZwXRNoqS4B3IrkGD1UhYN87+09W2vWxZn7fK5rtM8Fs+JdxAigHYEG?=
 =?us-ascii?Q?qP3rAvPiXhvHfWfgWUCHoJLKDZhLlZUc7ioUVtNO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db0ad6c-cef2-4653-4543-08dd2ecd9373
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:44:23.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTuchVdjuVgok9m2kLg+9hZH6XA+bLufJjvEa3kGafsApaIrmDmjOWZr5PUJlzMArrf+EYgzHVbZ9UZ48yYnNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

The procfs mmu files such as smaps and pagemap currently ignore devdax and
fsdax pages because these pages are considered special. A future change
will start treating these as normal pages, meaning they can be exposed via
smaps and pagemap.

The only difference is that devdax and fsdax pages can never be pinned for
DMA via FOLL_LONGTERM, so add an explicit check in pte_is_pinned() to
reflect that.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:

 - After discussion with David remove the checks for DAX pages for
   smaps and pagemap walkers. This means DAX pages will now appear in
   those procfs files.
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 38a5a3e..9a8a7d3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1378,7 +1378,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
 	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
 		return false;
 	folio = vm_normal_folio(vma, addr, pte);
-	if (!folio)
+	if (!folio || folio_is_devdax(folio) || folio_is_fsdax(folio))
 		return false;
 	return folio_maybe_dma_pinned(folio);
 }
-- 
git-series 0.9.1

