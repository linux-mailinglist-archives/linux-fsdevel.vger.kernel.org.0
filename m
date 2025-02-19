Return-Path: <linux-fsdevel+bounces-42037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C927FA3B0A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8913A9A74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A22B1BFDEC;
	Wed, 19 Feb 2025 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VWDEr3lp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B41BEF7A;
	Wed, 19 Feb 2025 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941543; cv=fail; b=VvtGIuW2DdfUgJiyb7O6Vgh73LIzI2pH/bEl19OMlmH965U+Xk25IpES40UJZVm3oExsvALmkQ5AM669gxYLGb3JDyPQKB6CstgREfCNdauaBksZMolQJ8505Hr/h7W2eB4YPai7zdlx4jNz6IoBnC5sMZrPMyo+pHK+DKh2WF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941543; c=relaxed/simple;
	bh=KS3uzy1H4GowZi5gMZcXF+h94IY3DVQ1c4NmharWc58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IrfbhjVXNzSreufSBtCrlITLQXLnQ4RfbRQMR/l6letyKX9u/UYr2q/88KNqITrF9A4tLC1j1GZB0ayhIOOzPsU2u5OFKGcEAeB5LrbnFDafCqdmyj+sPGBcaLl/xmHhg2MSIcFRbKlPnIzoWIPXMOxV8zWKxAP5HZKamnQpQ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VWDEr3lp; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2lM3ndtmgOOQ2kFM/zbIdMHdtR+hRlusJQStmsfjhJlUFNxpgJL4X7kUDB3MGs4Dt9DZsZxJorbePRa9ttYffx4PxPxX3ucR2iydy45/o/vSf8pJKiT8WaWP5WdX3vkCboLeZOh76fH1h0qic3G5bqxl+lf22qyLoNHIHW2mvygmoCcm9BkDOcjGASFr6360vCm+frXr7RdLNNK77wBDDU8M4Vv2AfWZKo46IhDOrFPhI1x4uI8ZZHGp28BxvehhLMuZ4L04DCnNo8vAzl/Dp/HL/AVS4h/M132qLMveWKWITWvHpIjIxwaVrhGlciopW8g/CHdtOjeifqYJZpENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDaeI1hYQn5SYGceC5I/yp81jrgefyafnpw5hA9x4Qw=;
 b=sD+UJRL6++cSbVPgLpool8HhHxl8RZwDBd+kwrkA2FKcwWKfB/RNpm9sWStontfWMKRRpiwcvQ5QTrk3v9TVSC5qm8xOJWE0TIoPXi2NJ9k069UAxgEJUiL73dtZ38itedGZaOnDj8RxqDFJ4Su7UV7XWFP2tu69fzP3C+vZkWMdL0IJ7PjQoGqMwU3E0MtUBZGP22bJf44KcesYXmreIslOUU2V/BvojVD3PvueuerILLoHINMUHJfLPKGMbMjK1DVXA42xr+nWGvBRuQxjpwKQtQqUHIvGfTZxBDs3iUtkMeu6e8ZIqRXLnKHqUc6qzrskPvjcHTPQ/zQNXxT/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDaeI1hYQn5SYGceC5I/yp81jrgefyafnpw5hA9x4Qw=;
 b=VWDEr3lpdmhp9ZnxZIc0OrKGWkcYX9AZhc4npMi0jNUH6dxAEbmN6nO3LmW+zQA/T90Pgg541mk/nWKJllyduGml6q/L72DROf3zKgk1+S3tGcytrOcasgiDMFvx46VULAeBsZ2/jInms/zOUQhsnfMcndcV7O9DHWqeR308y+GuwyYsK7snDD/K25oyiH8y4U5qKXTLp+lx154ft1830ctmnVNmSceeWoa80D0l1k/ZfzeS5anC74BzOi0EXanMsnYznf0ZpQR5gRrhQ3SS9JVLC0WBBJBS1kkyyGoL2XQPcvay25/lB7DCCf8LlgzjHwqEPoAhWCZMYSMXz+3KqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:05:39 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:05:39 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com
Subject: [PATCH RFC v2 05/12] mm: Remove remaining uses of PFN_DEV
Date: Wed, 19 Feb 2025 16:04:49 +1100
Message-ID: <32f2dec28a8e9fb5e193989c5c69ea269dc70dce.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0067.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: fccecf5f-be5e-4f16-42b6-08dd50a30d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRIRGyCjh4GacOCcrIJ2q2bZqwdDaOHeEedhX78PE2iimmhJV7ifl/tWWcQi?=
 =?us-ascii?Q?J3ppnHo3QVP5YBR9coOBd8DBW7BRXN0az0KJnVUM1/2Aw0AC7cXaAy1Vahui?=
 =?us-ascii?Q?zvsKDnB7v+KVvS1Um5aQ4oR6Zb1ydmUumv5oB/9XurIkP9lQoYMwF0QuxG13?=
 =?us-ascii?Q?6Gdl03i64BdGRCuNYxr4mKplHMsgX1kesTU8156Bg+8pIhD5HaoWDWll+Ksx?=
 =?us-ascii?Q?YUKcydyCekM947TXamKX6PTn1VU0+cMn8S6bnp6/Ne7Gm5eZQpCKIZ6wtTlz?=
 =?us-ascii?Q?9Ti7noy+2Qf1d3jguXUAtRNvpiNLiSeRTJOE7fOP6dorUtNhif17QMZj0tEM?=
 =?us-ascii?Q?cFGSIyUNIJRIvL2GeqechtMkLBcSaoApas+PqhGWXem3Dxw/yUFG/E+mWvtJ?=
 =?us-ascii?Q?ptnVjwceyHq7fbnZcPkSR7JlivzZ7AQthUvUeMfX0vFD+2JICmgrn9UjEfVJ?=
 =?us-ascii?Q?nSLo2IkIciRQE3ifc61A0xQW7DS6ZuIIVWB6sm3xS/fJtSt7Y6Hx0C/vOaTY?=
 =?us-ascii?Q?2u0HmYoI5eMxR2TsMXl7NrR2JEIvOZV3EXCeON3DMV8wND8QooYLu9nC+aW8?=
 =?us-ascii?Q?nU4/CcfQFHzCvaTqxxrJAReSgHxVYWkMBZ+TIIrPcAeKS2sTqQehKP9S8lGF?=
 =?us-ascii?Q?lqOUtC1cm3CmfTYswRFytINy6wQrHfhDtgdvv2gvbtKAjayQerDs4u06YfK3?=
 =?us-ascii?Q?ymZQ0naRztAPFXYOsNjv4Hw2QpzQ+zO7ih1PBACOQRfYg1eXOIKEKdSsPWhy?=
 =?us-ascii?Q?eS/rKZ5bhpYXuf3Z6r7y2fIdlS7N4NsKD5AenF2miAzCz7BkdH81vLANqabr?=
 =?us-ascii?Q?Q+sxyt5IEd5rBSFLChxgOoaaeHyRa1oahYffNS3iaomwvY5XO3nQtdeERm1x?=
 =?us-ascii?Q?FqNu5O5/sLR3IyT4CCYF1JOU2Nq6b4j/KprR1RtJWYaI+2hhQG3DwXK8LK/q?=
 =?us-ascii?Q?qeag0MytYnlpXwPWzp1/4QwSGe39NbpGTh/fWqTcoQeZBeoaP1arlHUdxJCY?=
 =?us-ascii?Q?UTlGwTunJv5BSZ2pefOZwofyazSBdUrH0ubvCbLKeQ5qxXZduqzaLiPlsffk?=
 =?us-ascii?Q?aDTxPcP3Lb3mRAjhnJvYHvX4yARD0PYCFU6SdkpL5fiXuA2qDdrCWrq3SVan?=
 =?us-ascii?Q?rVJAclDn133Lr2oEtE2zeUty7eWSLar5QodxDIqqXVVx/KUTg+vXM1v1VYoH?=
 =?us-ascii?Q?dX8Bx64ak0rtYgANZ8MdJpHr9juqfqMsEOxx4CzEYHBJ3+9QJ3tQLETQzP0I?=
 =?us-ascii?Q?mD6Eck0vM8GHB0aYcDNS54tqMibrE4gpfawdfLCJAs6Eequ9D+cevXKgejBP?=
 =?us-ascii?Q?LE/MkqeasMFWoMUsL6q8wv6LDPUqB0woVUPqPZJaGbbuwabCs8J7Ng4rgToP?=
 =?us-ascii?Q?sk9aRnbZjusKvPSifzInEmQMAxBr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kO/bfTQj9KM59R9qL0XdzR9SpK9wLdDjHa1ajX9ZoiY5QUPbQtONQuUuO558?=
 =?us-ascii?Q?jL1wto80JNy5/ZW6gNyufOYrCz6CDcpRM+Zta3cQjOFWYZJGrGjaOO3veVPi?=
 =?us-ascii?Q?dn6EKp5o/BaWDpZyGlX6MIgyccijlrHf/w2vVjgg0OQbXErI7wkGXmHOFDyU?=
 =?us-ascii?Q?OHSDAENjSUAmjn8PZZuTIfDtsFeS7tXcNArnc16cOgjEe4pATI9wDd2WE+3a?=
 =?us-ascii?Q?I2DWebr14ReE32nPyImslIdR9WnnaWb/h9HU0B60KhFIQJw47tNugIWgyFP8?=
 =?us-ascii?Q?ksh6TwlHlQhs2BNx9BnfQnsJc7n9TMnd7jFS0WOry7/AWS1meXhNg94+HPLR?=
 =?us-ascii?Q?9ytoyDAlnmbi5+1r1P6p1LxcSGe/RiOpS8kZ6i9ATzU4rxfH/92fuI7GucVK?=
 =?us-ascii?Q?2GfN8KkHW2Ghn5NisUWbcJdFwwgevAUxaZuqUkBkxKeSHJfAQyhHzavNUtae?=
 =?us-ascii?Q?CAMhEP4uGFfUXIXaU1epUUa8KjCFrHORHqYjoSX9n6NTpVy06T3tJSw4q/gO?=
 =?us-ascii?Q?et54C+QCrGig2sOmywV+gYZ8ZG07aFdO1rgzn2W6Ng2e8TahyZyHSAwPz1BV?=
 =?us-ascii?Q?ivcB/g7V8BreNId6dEGaZjD/YnrdCEBCj6cZAZ1C88vKmpbHNFM1tsYbzAXZ?=
 =?us-ascii?Q?E3r22E1TWxvr7brSJ78y606eKLMHdDooJIaHlwCvH05hJ6HmK29haMmk9Rd2?=
 =?us-ascii?Q?21XIpq70G6grA/xekIM7EbYR4p7KPiF1DTyhuy0KhzeORSIx2iLpnpSMOVGL?=
 =?us-ascii?Q?5eA+0xfHkfGtnbvQuX9jp1hCdf2obWtLTFJ7c9dzqhk0Aey6RmRrHUjIWau6?=
 =?us-ascii?Q?uuCHfcvX8sW9PWfHyu5Q8Ca/Qd5Nv1InfHWtKqP9GKE5odWqSW3XUOcTiVda?=
 =?us-ascii?Q?IdZKsvRF4Bcobn0nU5g/fx8r86DS7DOafj9EZ6UTEnACpMUfQLevtQ6mOUtH?=
 =?us-ascii?Q?m3WksXx2A8ZqXd0d4VLO9AEGuf345g/0EJA2RLb0JI0yNaqK9qDBIJKpHFip?=
 =?us-ascii?Q?uftNamR6qwgfnN7adJmVk/AOq4Yp7uBFeI/iIEW+kyHDXsF1VV52PZIWKgdS?=
 =?us-ascii?Q?x8AZIxzIcL9XnWXaLIKDBhhR0cVJ8vFcJnDXC9i2qdqAi7MYlSi+BD2cYv6Z?=
 =?us-ascii?Q?O3voT277acZ46NP6kz63jQBTv6hdeVFfMycIYtt4lwLJGppROtsjzMevkAg6?=
 =?us-ascii?Q?STVtOzIQLvJCTzknd3PKaiwniLwBAgo3aauRpZoa1Bj4yH1EGMKZdHQzFk/b?=
 =?us-ascii?Q?zuPPXfFz90cH/cOhEK7Wsllj7bf3MwHJ3jeBwpR1kLdzFdVUhdv/ABV/+fIF?=
 =?us-ascii?Q?nxPOhTJHb4bjgrsJoL42pOSKjDWcy7SyUkXS+97DW8Si66BmGk4nUR2L9TGf?=
 =?us-ascii?Q?xsW+ful/hAuYgxha3gEuDVj2KoJGUIPfC6WKaRtXT7zeOZF338snAOJGEhxW?=
 =?us-ascii?Q?4Jh1LufpNYEKkfh148vfrxaJHtmUKktqW8lgfM69bbOnS1RQ5VKa6+VTp3mq?=
 =?us-ascii?Q?DlfOBivJ5X8vn1NCKnTmE/PZU4UoMgA90AOVAr2+fe3wKxSaMsWc/G5SiMij?=
 =?us-ascii?Q?G+8Id90JilBR4nE/6NQlo7dl2FIxBtmWnrFk8oRf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccecf5f-be5e-4f16-42b6-08dd50a30d64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:39.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blvxif8IWZ49Gnyet4B8QUgpPD8oVPRwCn0Jt6A+w8e3WQh8dTEQzBLFoPHnRcJVgziqbI3QC0Z4sliqlde1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

PFN_DEV was used by callers of dax_direct_access() to figure out if the
returned PFN is associated with a page using pfn_t_has_page() or
not. However all DAX PFNs now require an assoicated ZONE_DEVICE page so can
assume a page exists.

Other users of PFN_DEV were setting it before calling
vmf_insert_mixed(). This is unnecessary as it is no longer checked, instead
relying on pfn_valid() to determine if there is an associated page or not.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/gma500/fbdev.c     |  2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c |  5 ++---
 drivers/s390/block/dcssblk.c       |  3 +--
 drivers/vfio/pci/vfio_pci_core.c   |  6 ++----
 fs/cramfs/inode.c                  |  2 +-
 include/linux/pfn_t.h              | 25 ++-----------------------
 mm/memory.c                        |  4 ++--
 7 files changed, 11 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index 8edefea..109efdc 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -33,7 +33,7 @@ static vm_fault_t psb_fbdev_vm_fault(struct vm_fault *vmf)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	for (i = 0; i < page_num; ++i) {
-		err = vmf_insert_mixed(vma, address, __pfn_to_pfn_t(pfn, PFN_DEV));
+		err = vmf_insert_mixed(vma, address, __pfn_to_pfn_t(pfn, 0));
 		if (unlikely(err & VM_FAULT_ERROR))
 			break;
 		address += PAGE_SIZE;
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index b9c67e4..9df05b2 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -371,8 +371,7 @@ static vm_fault_t omap_gem_fault_1d(struct drm_gem_object *obj,
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	return vmf_insert_mixed(vma, vmf->address,
-			__pfn_to_pfn_t(pfn, PFN_DEV));
+	return vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, 0));
 }
 
 /* Special handling for the case of faulting in 2d tiled buffers */
@@ -468,7 +467,7 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
 
 	for (i = n; i > 0; i--) {
 		ret = vmf_insert_mixed(vma,
-			vaddr, __pfn_to_pfn_t(pfn, PFN_DEV));
+			vaddr, __pfn_to_pfn_t(pfn, 0));
 		if (ret & VM_FAULT_ERROR)
 			break;
 		pfn += priv->usergart[fmt].stride_pfn;
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 7248e54..02d7a21 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -923,8 +923,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
-		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
-				      PFN_DEV);
+		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset), 0);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 586e49e..383e034 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1677,14 +1677,12 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 		break;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	case PMD_ORDER:
-		ret = vmf_insert_pfn_pmd(vmf,
-					 __pfn_to_pfn_t(pfn, PFN_DEV), false);
+		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn, 0), false);
 		break;
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
 	case PUD_ORDER:
-		ret = vmf_insert_pfn_pud(vmf,
-					 __pfn_to_pfn_t(pfn, PFN_DEV), false);
+		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn, 0), false);
 		break;
 #endif
 	default:
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b84d174..820a664 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -412,7 +412,7 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		for (i = 0; i < pages && !ret; i++) {
 			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
-			pfn_t pfn = phys_to_pfn_t(address + off, PFN_DEV);
+			pfn_t pfn = phys_to_pfn_t(address + off, 0);
 			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
 			if (vmf & VM_FAULT_ERROR)
 				ret = vm_fault_to_errno(vmf, 0);
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 46afa12..be8c174 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -8,10 +8,8 @@
  * PFN_DEV - pfn is not covered by system memmap by default
  */
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-#define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
 
-#define PFN_FLAGS_TRACE \
-	{ PFN_DEV,	"DEV" }
+#define PFN_FLAGS_TRACE { }
 
 static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
 {
@@ -33,7 +31,7 @@ static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
 
 static inline bool pfn_t_has_page(pfn_t pfn)
 {
-	return (pfn.val & PFN_DEV) == 0;
+	return true;
 }
 
 static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
@@ -84,23 +82,4 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
 #endif
 #endif
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline bool pfn_t_devmap(pfn_t pfn)
-{
-	const u64 flags = PFN_DEV;
-
-	return (pfn.val & flags) == flags;
-}
-#else
-static inline bool pfn_t_devmap(pfn_t pfn)
-{
-	return false;
-}
-pte_t pte_mkdevmap(pte_t pte);
-pmd_t pmd_mkdevmap(pmd_t pmd);
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
-	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
-pud_t pud_mkdevmap(pud_t pud);
-#endif
-#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
 #endif /* _LINUX_PFN_T_H_ */
diff --git a/mm/memory.c b/mm/memory.c
index 84447c7..a527c70 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2513,9 +2513,9 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
+	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, 0));
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
+	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, 0), pgprot,
 			false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
-- 
git-series 0.9.1

