Return-Path: <linux-fsdevel+bounces-42034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA7A3B08E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774BC16CF5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA91B87F4;
	Wed, 19 Feb 2025 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHtg2bDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF591B81DC;
	Wed, 19 Feb 2025 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941527; cv=fail; b=RfyHgVqI7ONbV8NZk0yLJyH58nIf2sNz4zwn0CAip00FHSiFNoAlj0mC5sQcgWqZENrMHKlhXkFtJGkRZRiWNu6cqNuA250MKtuKDDiTJrud8TPygDrCQHz5ojaZmRx5eBFcnCHy/BaGv03THzMkzZ/+SL0dvTZyAECJE+HxDX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941527; c=relaxed/simple;
	bh=0FZDUFf+5BBUfMF/7KR+Fj+xoNTpcXSnwZ7a3a/0540=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brWfIrXQa8x6tX8BD0KE0hU66qPBMT+h0RQrxClPvmDpn1lXvnME3LRCF2wNvWqIpJN83tWLvuO7hVUgM9B1nB+2i2blk4PdByDqiEBu+u3AbbdF537KY0fdM0LDgHR67hO+Ng8t69kCWUxMZ14yIOzIy5V3/89zdiH8AeNMPr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHtg2bDu; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBmX2RNAdKn7A1vTEVjhUEdlofxloMmkR7d4O6lp0XcwMEPzSlmUAiAS9LACPWPpQTy0C3DS20QralAUp3bh5M5Eku4ZYAlJsIXPo+u7ksLYlYZwuwLFaY01DLCqJ9fSBhexkeA9wsWxzDChDHNVJIU+p1xoWY9bL/ogUImscZWc1kKT9Z5oPUP8JRjsmRkB0wFm4qYPc4uokAHP57BoTjd9ay2ayWAw6AnqS+omOeVqnURu404/OfcHr0Mi41+OVdoNjCShAG0Mtt8v2WMWOXIMlrZ14aUFT57gENCE6KJzT4xDV5W/XSq5IhCIIaoWmdmSuzFctuM1Gbpr/vIC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a4+Q+E73o+RYJln5DCkDPNlg1ReAJnfPq8rXKt2KGU=;
 b=ANH2SCuBYnC5lYRye3AjdrtV8/9nQ4Hiyfw+mtfIrGYb4ZV0jdnBONAZbnSTqy1/p60JBtOFqGGZi1elv9f7mWdYsTrsEa9PB5dnwq+wxERpnJEyEPN+mJFQ3I09NJnwrIivhTOyA3cigh2ZWvmF7OILZNK/18GMGsxB5UIgaDK5uWtatljCIHPe4AAFp2UvnYQm5gSLFZwZIHTWTC+frLte0mM6lKrvW+PYvyavLJkiNcWKAYip/II0/5NCL6eqPgJOmOMibanOEBU3Pp0KP0lj031sJq57j+jvwFj6UfYhJZpEANH3Vbk0lX16D1fnLITGa7kwgVSXwdBy5zEYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a4+Q+E73o+RYJln5DCkDPNlg1ReAJnfPq8rXKt2KGU=;
 b=pHtg2bDu3k47QNjJNaluwUV4Ij0dWpU6hpwmFVgYO2Rh6T4/4a9ioDGiRw+/7PpmeU8zsqTTUjvEHvjtLSNX5w0rlIf4uB2HEkKchlzDlQ+FcZV56BPCJIR9SbfQkLkuCiABZNq3newCgBvXSYeCzJxUViPd+CKbZ62fK6fsyZ6Hu5b72rC+yxniPTb/LJrNUUBHt1mYkHSKDqI9j9O5iedpzu4ThfJToPC4E1T/a35laYLaS2JPv+7JCdVgxuJV9H1tMfITECTWU+mC6W1+YZBa1/y5QS/4F2Q1nqjMBjmveWAS/bB0eF71yiPmZioYxSfgRE03AzLmeZK3kLLCoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:05:23 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:05:23 +0000
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
Subject: [PATCH RFC v2 02/12] mm: Convert pXd_devmap checks to vma_is_dax
Date: Wed, 19 Feb 2025 16:04:46 +1100
Message-ID: <5142b971de0a9608147c003953781b34aa6a3a45.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0124.ausprd01.prod.outlook.com
 (2603:10c6:10:246::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fae45d-7231-4b5c-105d-08dd50a303b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xPYWe7KyHyhiBTUka8EtIcE8FSZoghjdreHziIReLCzguOE23rdAAhmGb585?=
 =?us-ascii?Q?9iOeJ4xwl0Yx4bhOGVZU2gEYn5VfGraWprrh9J+zrA89fZ+pEo1TzkmSjs5z?=
 =?us-ascii?Q?sgiVMxArkTbOzoXNy1bqxwpzgNIlaSThdIZ4axKCFChC/i+YZnEp+pWJP0Gp?=
 =?us-ascii?Q?OmDL8C2s2zYLp6UpxHuOK7h/bGJ9ArVQ7lZr4Hm4xTnu7zbqTJhdaC/Lyume?=
 =?us-ascii?Q?/nNieZElkq+ORGQstO8zJ0QDdePZiVhABwfIXt1pYlugt92HL4VEIhRhaTkq?=
 =?us-ascii?Q?2LV0BmAZWIJ08ERWNQ/FUfYh4e0t6W4Bsx4LAYTLJm5yIJRNO5/CeD5lrBBW?=
 =?us-ascii?Q?kfPuDM0gFXNR7DbERGfqYyH4/aLKxLtN2vqzbPnlkJ8NUirhNBfYjwntFLq/?=
 =?us-ascii?Q?36E7CMYZ4neckn4rSCb+SAaa916WFobLxc07DCz0Uq+Dm3U+vgYZP+I1CmM3?=
 =?us-ascii?Q?R12E5LXpeORZMauw1iu+fKIOoVDAFWcBb38fW6UZ0ocZm+FxmILN4uuPi05X?=
 =?us-ascii?Q?gFv2X74lCzDdre+iHQfowyGvOduBqaN0qldFb0Ve3XuPsEhEH8sMbSk5KaHG?=
 =?us-ascii?Q?QHI/YkaFSfd0L7gFPk0soaE/S8RIjr4a/Y2+0paj9jCPpVnSiAcbsXc54KyD?=
 =?us-ascii?Q?TU+I8FaxDtwN+PgDoYoFX2uXZi4opCAx4SpsME3jIvxPvm/LPsFcxF8HhGdQ?=
 =?us-ascii?Q?JY3ogHHTB1lW8+eQ0gPoNBS0/2IZmc0U3onxcKnbkUULUbXGP/m26ZMmxuvv?=
 =?us-ascii?Q?g25w75867zBfXcqDjZDONvojoQ+TiCQDyoHE372H+INHuXU7Ed+k0x2HM3qm?=
 =?us-ascii?Q?nIu6ovjsrlefg31h8MvcOzpIgAsuwbB6aXsRvUmJd7BRdj0eONYE9dRcB1qA?=
 =?us-ascii?Q?X7kca98mxkZxMzA0Dk91zkxAl+Qu7sO/aIHegxKkOpzLb9jUuQb1oWrN1qHv?=
 =?us-ascii?Q?64Ve8cW6j+T73vldLlTNHJW7HWgtP4GcVRe6uOSKJ3iC2srvMXSceuocSid+?=
 =?us-ascii?Q?AYWC01XqLtRod6/CSAQEzF1MGj5SIsmaLiIgofpC1liD1Hm0cO3RkTia5HHu?=
 =?us-ascii?Q?LkPD/YRtUc522r9JBo0PN6p2mx20g476aVZyQsZQ/1aX5WotwJZPtbbLZlHI?=
 =?us-ascii?Q?3g35Lk03YjluQUTok8210laRvE5V4P2D/6r+yi3MqyZBKoeJX7YnFq/tPt61?=
 =?us-ascii?Q?UoxmaK8S+ehZFirCjIWWRFAMtK7EuMI/Jc9LXSM/2bB0Nh5VGRxT45qGq+xj?=
 =?us-ascii?Q?as+Bk7PvrkPfS2udU6788SBWIGZqyWueNmRczmNWck/3oVADfqSuELHWouGJ?=
 =?us-ascii?Q?D95P7uJbLlDxCXqHCcIQrk+15kFrpBrdRn/rq2FY6xSbx99NqqsY8cJTcYoa?=
 =?us-ascii?Q?yTuAI8SNsrOeRed3HaahB4M/qNBK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkfQHOHxCrFvsy+Uq9n012i+7NyYdVW4M9bTqyCzMFNajuLfhGTcuCiV+gTl?=
 =?us-ascii?Q?oViBTJcAapRgFsNDIbfxONIBeIR/zooxN1Uhlai6CC5j1jGtXfdzN4WhBorP?=
 =?us-ascii?Q?P0Yaj7HCYAbo0bXOeuBAJpMs5Su+BTVIKZY2Qn0C6f2sISOkE4EJwxBNrleb?=
 =?us-ascii?Q?7Q7604nJ1rCWUD3MlOgMUZn+7fXonHYuVFejACDMsiBWmyEaiBZOLvYGII++?=
 =?us-ascii?Q?5qLxJb7CzGeyxU2U3s8y4oLg1EWTDYm9wCmapVWBYeL2TLG4XuNryAImr3ky?=
 =?us-ascii?Q?6RTW2OwwThbjUTQ/KGgVwXdxIUfbkjvuQHNQ1ZWZmh9T4Kt+I+BIpWCxKUBT?=
 =?us-ascii?Q?3YzXMYEaf0Smd0NamrbhUINfadX+dOVSavf7bD69VtMJf0+r81XyO1zZjdAz?=
 =?us-ascii?Q?QG2YZeQVCin2H19/I1AI32gjv0xgtLA7ZqvrnbrKGE7ci7N3zP16BIHrYurW?=
 =?us-ascii?Q?lTTUkZmi5d/G8yCCI1A/UEbVkWgA1P4Cvm0X+2lZCwaLxmJYpcWyRdCRHHcm?=
 =?us-ascii?Q?DJt59/7Z1PuybSnmMXEV/zYUVlV13h3WHwGxm6i1jvozTvzBsVBs8Ix4AvOF?=
 =?us-ascii?Q?PxSwRVhpJ3sTPa5ldxHp1T4UPZXE9u8muiwLtlDsl14TSjMi8iwtAh11zuI3?=
 =?us-ascii?Q?1up9Pwyh03Ww3CMNM3tqFh9nVrhsvC73/qrQj/yLI61d9p/v4oJHxTm1mupn?=
 =?us-ascii?Q?PhCfkgVi7yg7to4CSft4Pw1nXpQFscpiL2Srjy7i47v6ZBwBU4dx+KZb04/u?=
 =?us-ascii?Q?Vb7kOBEIamD/jfOZLkZGtlabzbn2BGS42ruYMxQgNdsZ0VaEpQSMLyuv+ha1?=
 =?us-ascii?Q?S4gCJAXAHhcvxzTMlJ24n9pHRvvofD0vmcVDFL1O7aZPyFsPiLuFnUEjs3kq?=
 =?us-ascii?Q?5tcLWk5S/ZuGvM9mmICyyonwYyZIjWU6GBW50sA8wMkD0YDoJ1p2vGb651pp?=
 =?us-ascii?Q?qufGYKFlqLV3YfZhAvvk3B08rv6BDfjODCit38I4aE9I+TWRuHDtc1WAaXgp?=
 =?us-ascii?Q?1CYW0Nkx9aRjbxDqW2X7L+ryEh1xFpCz/rolFvLM1maazN8rpfCAIdrOcrrr?=
 =?us-ascii?Q?X4hE3I0GNK4o+e14ZG+9aGnMp14Mu9c/Wvv9xUT9hXL9zTpPWOpPK0kypOVN?=
 =?us-ascii?Q?zYgDndFCA46ZbL6Ixq73GoujCbNFLBPYapgf6Ll10nNAKZ4iKK1OAjVLyVj/?=
 =?us-ascii?Q?NppYRCJEso1AFcAM1yutVsllntscpyTWfX35JsbTCN8YSiyXx011njL8OQVy?=
 =?us-ascii?Q?1FVY/Bdas7Yr/j1782zlMsdBNWaHwJKqk/QiQXJcbIxOpxhQlClZ7TpoSFHa?=
 =?us-ascii?Q?jLf79Ur4yI3uc6+9WXT3JNajVLLWlc5bRTfz8e6EXS9kJEGXCZFlk2agpiSt?=
 =?us-ascii?Q?iUv1PVgQOHBjx6tG+tZPuQu3bHWScRisVrCzEIf9O0+ENg566pK7sYNxUig4?=
 =?us-ascii?Q?A+3jOsqmJL2TdyAS0SazdrjgfXyes8K8p2wW09HMeqYohRFzZDR82ssP/FYl?=
 =?us-ascii?Q?eOgJWNHImQrFYhReQcJYPNdvj3CINTOk9NNAm/pE95aVy4jLdBQatwJQAviR?=
 =?us-ascii?Q?tGB+hVvWYIeVUGr0SYGs9+/1NbCbFLp/EdlQqv+q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fae45d-7231-4b5c-105d-08dd50a303b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:23.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNxeUYW7C5qJ0KDUB+KtF1eTDOeTHDeWf6iVlPGTi2vi6Rc399QgHv1R47ubcwjn+VMqZ/2amahODbl1+Z/j3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

Currently dax is the only user of pmd and pud mapped ZONE_DEVICE
pages. Therefore page walkers that want to exclude DAX pages can check
pmd_devmap or pud_devmap. However soon dax will no longer set PFN_DEV,
meaning dax pages are mapped as normal pages.

Ensure page walkers that currently use pXd_devmap to skip DAX pages
continue to do so by adding explicit checks of the VMA instead.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/userfaultfd.c | 2 +-
 mm/hmm.c         | 2 +-
 mm/userfaultfd.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 97c4d71..27e3ec0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -304,7 +304,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	if (!pmd_present(_pmd) || pmd_devmap(_pmd))
+	if (!pmd_present(_pmd) || vma_is_dax(vmf->vma))
 		goto out;
 
 	if (pmd_trans_huge(_pmd)) {
diff --git a/mm/hmm.c b/mm/hmm.c
index 082f7b7..db12c0a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -429,7 +429,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
 
-	if (pud_leaf(pud) && pud_devmap(pud)) {
+	if (pud_leaf(pud) && vma_is_dax(walk->vma)) {
 		unsigned long i, npages, pfn;
 		unsigned int required_fault;
 		unsigned long *hmm_pfns;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 867898c..cc6dc18 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1710,7 +1710,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
 		if (ptl) {
-			if (pmd_devmap(*src_pmd)) {
+			if (vma_is_dax(src_vma)) {
 				spin_unlock(ptl);
 				err = -ENOENT;
 				break;
-- 
git-series 0.9.1

