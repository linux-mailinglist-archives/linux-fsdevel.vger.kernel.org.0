Return-Path: <linux-fsdevel+bounces-44136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4326A633DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 05:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBAA1893170
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 04:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12411189B94;
	Sun, 16 Mar 2025 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fn/ua8KD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3218859B;
	Sun, 16 Mar 2025 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742099416; cv=fail; b=k5jcMYW6PPrqycxwQP6NEwVe41JoBdzaAVnmwcSfJE1l0I33E0XVUzUDP8itcWxLSZipmDJeeM2ByzAw5LKzHZTFevDMDNVDBEpHvPwxPnpZ9Emg+VTV7x+ogz+QeWMn2Iz34CK0NqmlfYoXDOyWppRPPDhIC4TmDc9686CAoc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742099416; c=relaxed/simple;
	bh=T5DJRp/TsHbZ5n4ChPkC83b57sPgp1FLVNDK96htuxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPouPCU/KUlcJqGkKTmbDu/z4RgMiYyNQaAYCaGilJCQX0Hri/Qm3itQB8SaUbT3pHZkJK2n1uC7Nvwb8FhSJMOcFxF3KwUCaGJKMZWmw6vgJPiWx6vU2Bmwi3uTVA07zEeuQn8dAJibQDqD6uwVcmpyOekQRAf3fcmCwzQh8ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fn/ua8KD; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ejuk6s3C4oOoreCxXhrhheiN057XUFPQgiZGC058yr/8h2/cnm8BfVbAPkPfSHYAjNMaIwUiiSSanhbw9Z/WZ/IZIK5oThimgk6fDJfQ3MqBSERAsF2bwLAsORbvQ6THK4Oqqu5eilGdi5dDy5midwWZiR5cKP/MhCQKrVxottzzOKMV3UxeYMh3KP+C7jeb62VNqrw8yfJZxGYxrU7BlSwD/Gek20ruSH5UpXIftRDiXu3/Mj6PTZrX0YQ2TdRgAsKICR9NhjXdgicrFEU5v/RRGqi9Vkajb6cwkdj3DO7eilfN7WaxomjGrTNgeimtbG+wkKdpXl1z62MPloP//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjshqkiCaMVrtkBmHmhucNtE06eT8r+7HKLv0OzuJto=;
 b=vjbZik6MrSReE9C0OiP9d/nngkbvkExANMQVjn+4LsfltOa1QADL0TX9bebOp7Z6/oROHJa8UKhHl0HZo9uDGomtI6tyz6mUyR9X3elbmHI3G7wujBlxtUR//KGnPIwmqawaQcjDs0DNtUrapYUOYYv/x0vjQheveed5+LttVUEatlRy5bLZt69nfd9g23zggSg/SvJQATLOrgSon6K8Mq0MSTFL8VAUTKTrKXEIKR486Dhn1R7lkwNzFhdD0zS9Gt+HnC+5hjuLOsDUrZKP87lW9LYv97pAOhoCSmoG1Z0v9GGPcUGjgOVDsuZAxBgYSHZa3ZPA1+T/z8xo/UQ8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjshqkiCaMVrtkBmHmhucNtE06eT8r+7HKLv0OzuJto=;
 b=Fn/ua8KDPgQyHZMelPWmY0rmGvAbNS/PpzPvgZlczzJmNHd+Sfg46EzhY6wVNOwHSbcX48GXVeZkWIs0EyzPuNi0zo26ipyuI3Gtsn3/IJoy9zZvPnhNwTXqKjflJ2Jo0Jn1X2fQxJnoJ4WqV/MGgLkMfcYjOCCBkET6nmEOm3FpB68t0nKME/9PQGu+fzp4pL46PHID9dYZbMLrm9beQHdwutIyRMeo4jgHPdwen0ZzfN4xfkJdDsOy+WEHklXcUVwOtqwEKjFSfs9BI2XBFtSiWSlUUFHmYp4o2uyzXgMxGyuXQQSEveY+mmQJifAaZvCUsVFESrxM4E8hO7Y2Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 04:30:11 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8511.031; Sun, 16 Mar 2025
 04:30:11 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH RFC 5/6] selftests/hmm: Add file-backed migration tests
Date: Sun, 16 Mar 2025 15:29:28 +1100
Message-ID: <e4789b78bf932984c321469e5a7d2bee583653b3.1742099301.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::12) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1395bff4-ee5c-4178-187e-08dd64433daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWSyacArtKYWKQMtD5C99SR7Pusw+URE3vhevgBTyY5cNBefr3Ga7dENaG7i?=
 =?us-ascii?Q?RUDNOQzwXNLaS8FzyYT0bwqL4fJFfqyOMhZ7R2oI4ZRx33w4+io2CfZicRB+?=
 =?us-ascii?Q?5tDCYxx25NMwcTzhfJZ8Ee2w5qTEyJArNwZjKRNi9mfTW2gg4bumm924UjYX?=
 =?us-ascii?Q?1a5QA0aARfqdvPpo4IqMwdyaN+ekJS7l3ZSDyFN/At78z2NEI0nJOXC7Sh7p?=
 =?us-ascii?Q?gX8TAcKmaWImCtEAX9d7pQtkgoh3FWSv8OrcqobcNbv9V2w2uz2sEEq/eS+Z?=
 =?us-ascii?Q?SZFDJVe5TtZ4hTsXN84EqDI9c1/4H5TitEmlDbzEeaZUXoJ4tp3l8ggsGNNp?=
 =?us-ascii?Q?AHcciRxWg/JrrfQVJqpBCSuIpJ8wmanhPKSl8YO5qAFprVSRaji9wdzsv+57?=
 =?us-ascii?Q?w0RPz9qLBUCB9Qh+tX58lomUJxVYqk0bUvWhXc48vESWex9F9OSZCBNO4l2i?=
 =?us-ascii?Q?76xYsPxA5k1TY+MqR6QOM6wQQNIAl5seLxsYYXLNocdW8yGaIkXcTHclL05L?=
 =?us-ascii?Q?e930Tk3EhYR6wyDaXeRq72yKer08iMuBXEcOmmqmdTQm83MNUD4RGrrsqQ0B?=
 =?us-ascii?Q?9lTPNJT2yJkg1plR4ogUqLlwsDWxm0uYz95P9ScxN9z4onNelWJtnOnYrUmm?=
 =?us-ascii?Q?8wOzUCGcrgFgSMzXUNgx67MSrrnHIxzEtURdYeQJI//0xzJyVcc+q27A0tvj?=
 =?us-ascii?Q?AML9id9AmvHUhCgM5CfvRGJGO+ubWTCZjoTfiHQeEJH0JWyfMpq6G57B9+rV?=
 =?us-ascii?Q?UeFda0PWwnSAm3u5AchFg8xn3HhueLp3yHr/j0C0VPz0dVgbWI8NnUN8TpfW?=
 =?us-ascii?Q?OqymijrittfLmtAsNvdsn7/9KJNMCHCn63uXfDgJzCLhi2rWJF/9+0R8SubD?=
 =?us-ascii?Q?xL65rrPuDEjbQ8izBzDgQYshJLvm/0fBpssIzr5iG5AeqaaiPIkWdNnNuY5X?=
 =?us-ascii?Q?jR5E+JwaZrqZwWXoS183JTCMDqYwkJPhLpBqJoCK1eIPWLm07k3qgSDL8JGB?=
 =?us-ascii?Q?IT4youYV6FtM+OOC9asNYPzriXFTTkEUk550kM743O/lI72+EgCP+Xmmg2D/?=
 =?us-ascii?Q?q17sS7AE5/QbKVa6nmKHLUB5LesVix7B1dauSP0pcLszdAqq8Dn2iY9liFi5?=
 =?us-ascii?Q?LSiT4ufXfhu7h+e8UENbhRBwXZpA7sBOcN+RDYXKvSVKIVLZItu8O8IgPzYQ?=
 =?us-ascii?Q?KOVlOp/UvhCj9Tiz33l0N9/6KpvkwvdjY8us0N4Rz3CWNJ2sF2O9wGNlazdM?=
 =?us-ascii?Q?t2lYBzb99e1ALcVf5ebL6GTr7ULoPXFI5Gq9y7weEs88UQcJYqZvHvnwa+ig?=
 =?us-ascii?Q?J+VO80lHQUiYbTExa/qVeJwQTbEsgOg1Bi3nQ+8RVhn1jxgslUcZUzy1xUX+?=
 =?us-ascii?Q?4hHISrjdmjUqeRIpq0HzVSwt76pU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9grK16W4oSKH+eOX2X9yDJ9SKbO/NCwrzsfvyY6iQKpYVjc05BJAWvI1hP2?=
 =?us-ascii?Q?8dWU8ifOrFdS6ffwtSXKIUJMJbn304LZWjulkpyfGEoRtkQXxkklAN3QzC9h?=
 =?us-ascii?Q?7JV7/pbZE5hFXkXWlCXynKSab6Gk/J0CumV/882P6887qo2STfk1suqo6/Zf?=
 =?us-ascii?Q?65O2QaOvrPLo4Ekaqbs+/VpRwIDIDL/gfvrUO9TFvniTPUBuDeK5iCm7Jp50?=
 =?us-ascii?Q?L1vaWS0xFIR4e3RnTb56qe7wRuS5NhIRi9zF9NBg0lip36fJObKXYm5Rf2Gx?=
 =?us-ascii?Q?M+lvg4Oc5j31Mtq3qkPuQL+oQP6XGQs6HB4anansSLaY85k8aNrvqGgntj7q?=
 =?us-ascii?Q?Gm0QwxTxPTdEIKJ38NIbQOoD3wM/N9kIBhgOr28wk90E39TgVQRGeQdIEKS1?=
 =?us-ascii?Q?/Kdn1hID0xVVcXp5vY6WWcy29ak1GQumBYpUJNippRUsU7YkgkZxHmTkGRcx?=
 =?us-ascii?Q?DQeQ8wNB5+blwWpvKPwOrgHdcGuA4Sc6j8iDVXugFkk/WY5cVpepyK8RM+Sm?=
 =?us-ascii?Q?ss6fYOGRqjkXt7Ca6uEpNpjd6hqP7hJA0u+Qhwxe/4CKGkMIRlLjtkSGPH+H?=
 =?us-ascii?Q?mLK6pkipUrW2Abb3sX4ATG2o9QVG/hI30pxrwAAYH9iWc+Aly0jaE2AylB3P?=
 =?us-ascii?Q?6WsCyjRqZyWkQg8AKSydnhJsY1FoHzyyaxItANapKERz7lTF3VIKHJ81zUCs?=
 =?us-ascii?Q?PjL/wrlx/zI5k6L2reY3cIInQTFtoYnJQ4hJOU+Yd6AXHwKsW8DHDK0R+6T7?=
 =?us-ascii?Q?DhypU0Zlxhuz+HbMAzyXjF6lyxAtREFRGmwFBlBTSkgUbz+WVouDs0ReXURT?=
 =?us-ascii?Q?3lMQZSWe+d90F0XiGPA6cLjQpaq8SlICSURBxUV++6RVHs+fa0TOokZCBJbE?=
 =?us-ascii?Q?I1ppN4KfWTttnX8BKv/W90KP/g53LfvnhYBVIy3ECyI5AZhc0jILh5bzvha0?=
 =?us-ascii?Q?Zj2GFkbBSx8hZ4W9Jz46eFBq3apQKx6hOVz+yZ2kXcke1tKDDeEpueWdL1Oy?=
 =?us-ascii?Q?by2uMHIyfz9m5edY7rodR/t+CblRzi770lhIgkZnvxYkSOmDFt2yp4fA1KSr?=
 =?us-ascii?Q?muzHuMiw6bT/mO22/pwHuZeD4ArD4FcB/oyFBQi54mHCfvUZYslE3QCj2vVu?=
 =?us-ascii?Q?9nseadZB3ffP8wazeARztroQ44fHZk9c3oTA6wkQyHzElmnnrkQ7Q4h+0S4s?=
 =?us-ascii?Q?QwnyCwq4i6d/7vF6BtYAJE0/sYnqvZ3rtvU1znNRbThkV2rP7LucDUOfbd8S?=
 =?us-ascii?Q?DeRfyi5h2j01rCvLx5BlO+xXWG5Ip1Q39zzGBXrpOprHiPiMGedls4SsTHOL?=
 =?us-ascii?Q?PAyQvsBFeGiDp/VLIxSevoG7he1bKgVgPGxqSerKGGA0dEFZfpZoZbhnWk1P?=
 =?us-ascii?Q?TROx0LR0JeaW7sYW/qiwueYXAynYmCBrJtyo6MEbDi2dVLeD48xaquL9qLii?=
 =?us-ascii?Q?s7oyt8vzgNGMLikBe2C9hnkFmvo+gd9df9JxeTgmww1smrBMLSXHTf1RJR5e?=
 =?us-ascii?Q?I5OO49uqI54hGit/DjHdgZt+SkBoBftCKEcQfcK+SaZs7vfCaCvraEED1aw1?=
 =?us-ascii?Q?bGs4dZW6+alJekQ5rxvW5WIBAF2xFtoLAH602tdn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1395bff4-ee5c-4178-187e-08dd64433daa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 04:30:11.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vANIbCeOLXRgc8Rf8R9biGsaoCJFZwcO6CiO8zKoFYmGWfhGlu0PHPsQAYGuEO0zQWe1gy/cHb4nqH2CEXstXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

Add tests of file-backed migration to hmm-tests.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 lib/test_hmm.c                         |  27 ++-
 tools/testing/selftests/mm/hmm-tests.c | 252 +++++++++++++++++++++++++-
 2 files changed, 277 insertions(+), 2 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 056f2e4..bd8cd29 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -979,6 +979,8 @@ static int dmirror_migrate_to_device(struct dmirror *dmirror,
 
 	mmap_read_lock(mm);
 	for (addr = start; addr < end; addr = next) {
+		int i, retried = 0;
+
 		vma = vma_lookup(mm, addr);
 		if (!vma || !(vma->vm_flags & VM_READ)) {
 			ret = -EINVAL;
@@ -987,7 +989,7 @@ static int dmirror_migrate_to_device(struct dmirror *dmirror,
 		next = min(end, addr + (ARRAY_SIZE(src_pfns) << PAGE_SHIFT));
 		if (next > vma->vm_end)
 			next = vma->vm_end;
-
+retry:
 		args.vma = vma;
 		args.src = src_pfns;
 		args.dst = dst_pfns;
@@ -1004,6 +1006,16 @@ static int dmirror_migrate_to_device(struct dmirror *dmirror,
 		migrate_vma_pages(&args);
 		dmirror_migrate_finalize_and_map(&args, dmirror);
 		migrate_vma_finalize(&args);
+
+		for (i = 0; i < ((next - addr) >> PAGE_SHIFT); i++) {
+			if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE)
+			    && migrate_pfn_to_page(src_pfns[i])
+			    && retried++ < 3) {
+				wait_on_page_writeback(
+					migrate_pfn_to_page(src_pfns[i]));
+				goto retry;
+			}
+		}
 	}
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -1404,6 +1416,10 @@ static void dmirror_devmem_free(struct page *page)
 	if (rpage != page)
 		__free_page(rpage);
 
+	/* Page has been freed so reinitialize these fields */
+	ClearPageDirty(page);
+	folio_clear_swapbacked(page_folio(page));
+
 	mdevice = dmirror_page_to_device(page);
 	spin_lock(&mdevice->lock);
 
@@ -1459,9 +1475,18 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+static int dmirror_devmem_pagecache(struct page *page, struct page *newpage)
+{
+	set_page_dirty(newpage);
+	copy_highpage(newpage, BACKING_PAGE(page));
+
+	return 0;
+}
+
 static const struct dev_pagemap_ops dmirror_devmem_ops = {
 	.page_free	= dmirror_devmem_free,
 	.migrate_to_ram	= dmirror_devmem_fault,
+	.migrate_to_pagecache = dmirror_devmem_pagecache,
 };
 
 static int dmirror_device_init(struct dmirror_device *mdevice, int id)
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 141bf63..4b77edd 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -999,6 +999,254 @@ TEST_F(hmm, migrate)
 }
 
 /*
+ * Migrate file memory to device private memory.
+ */
+TEST_F(hmm, migrate_file)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size = npages << self->page_shift;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = hmm_create_file(size);
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/*
+	 * TODO: Migration code should try and clean the pages, but it's not
+	 * working.
+	 */
+	fsync(buffer->fd);
+
+	/* Migrate memory to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+TEST_F(hmm, migrate_file_fault)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size = npages << self->page_shift;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = hmm_create_file(size);
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/*
+	 * TODO: Migration code should try and clean the pages, but it's not
+	 * working.
+	 */
+	fsync(buffer->fd);
+
+	/* Migrate memory to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Fault half the pages back to system memory and check them. */
+	for (i = 0, ptr = buffer->ptr; i < size / (2 * sizeof(*ptr)); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Migrate memory to the device again. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+TEST_F(hmm, migrate_fault_read_buf)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size = npages << self->page_shift;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = hmm_create_file(size);
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/*
+	 * TODO: Migration code should try and clean the pages, but it's not
+	 * working.
+	 */
+	fsync(buffer->fd);
+
+	/* Migrate memory to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Use read and check what we read  */
+	read(buffer->fd, buffer->mirror, size);
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+TEST_F(hmm, migrate_fault_write_buf)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size = npages << self->page_shift;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = hmm_create_file(size);
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/*
+	 * TODO: Migration code should try and clean the pages, but it's not
+	 * working.
+	 */
+	fsync(buffer->fd);
+
+	/* Migrate memory to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read and update to write to the device. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i]++, i);
+
+	/* Write to the buffer from the device */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+
+	/* Truncate half the file */
+	size >>= 1;
+	ret = truncate("hmm-test-file", size);
+	ASSERT_EQ(ret, 0);
+
+	/* Use read and check what we read  */
+	ret = read(buffer->fd, buffer->mirror, size);
+	ASSERT_EQ(ret, size);
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i + 1);
+
+	/* Should see the same in the mmap */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i + 1);
+
+	/* And check we get zeros in the second half */
+	size <<= 1;
+	ret = truncate("hmm-test-file", size);
+	ASSERT_EQ(ret, 0);
+
+	for (i = 0, ptr = buffer->ptr; i < size / (2*sizeof(*ptr)); ++i)
+		ASSERT_EQ(ptr[i], i + 1);
+
+	for (i = size/(2*sizeof(*ptr)), ptr = buffer->ptr;
+	     i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
  * Migrate anonymous memory to device private memory and fault some of it back
  * to system memory, then try migrating the resulting mix of system and device
  * private memory to the device.
@@ -1040,8 +1288,10 @@ TEST_F(hmm, migrate_fault)
 	ASSERT_EQ(buffer->cpages, npages);
 
 	/* Check what the device read. */
-	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i) {
 		ASSERT_EQ(ptr[i], i);
+		ptr[i]++;
+	}
 
 	/* Fault half the pages back to system memory and check them. */
 	for (i = 0, ptr = buffer->ptr; i < size / (2 * sizeof(*ptr)); ++i)
-- 
git-series 0.9.1

