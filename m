Return-Path: <linux-fsdevel+bounces-38540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A047BA0368E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B039164B17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398F1F191B;
	Tue,  7 Jan 2025 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cVYWI52A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7731F1312;
	Tue,  7 Jan 2025 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221486; cv=fail; b=QetsDtvTb+X1lkBvU5W38h75ZmPDJ4sSr8ADYdFlc2rysT8oAWhHs4g7f3TGm2q/zV9UQX/gCKWByXDmr76hcunMxz2bYeHImUymani5hz5HI/rRf8tL7RPTeXDp3y8YyYfK+G4l0lB0W1hl5Vygd324ry1llCuf1zK4hN8iLRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221486; c=relaxed/simple;
	bh=bVzgWyQa4w+3Tu64z6XFGDevakKWyWcLsWA7cirN12I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hr+nZpxKqveU8bS1j9QTw/cAcCHrWvAKtU4uvaOEBmnaNN6KircSbJF6pgAXV3Cp+Pbak+bAmN7HGubfepH+bUDEKAyL203YBcxb26qebYNMmYdrLb1gBilChwlyoVoAfxo0ZhAKb+NRy4xlT4g8lV98iwb6x1ZQ7lp4GqnCZ68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cVYWI52A; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skMK1GbarBBi099eMrgO+8LlZB3fofcV91OaiMNBzb9eoQNq5aX3ldbKEHC79tXaMHm0QGAw3D/DXs5NtdpDuaRS/lYAKtCnQ6RUkvdD2ZcS0arnz2byi/1cIWYNojmE+bOmCYj8jdGe+U86pFeMP2N8qFSLUowtjRdNgcaAKMrf6h/bWXXRgLTdpfZ5o09uuSf5uDonQXXjiJQ/4YQ4tb1sNs9BPQ2iLkFBOfgY1Sgnrpe2Menuyk/zFCb5XAXeMVCPY/faUFXh75nxXVgpLZ+VI/MJaFI2LU5RipGT+Pl5x7WYqPxVD17jcJ3rrkGIMeUuITUqbxPPk2OUPNgetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=YD978Bugvi6PXAazYhmeCtxnh4E3xRe5JYmRO2uydAFu/Dc6HW+P0WAHglLLAccqfJn9a1cLygyymsbqvDgkng4/mmyYDnnxRFVCP3BZN0/3JcHLmxH153L0BwuzqcmlZQDHjhyz+Xl8bkIWKEcRiknwM0L4CN+pmuaUS7MuGb3WP8l7fFmaFvofnYFIbH9YOzBYnmZuRaMAXxDoWKu/ZStk+BSv72cTCzL7vti5Os8qBr/3EAHDKXERhI7OG/qoXKPwWadgvTJ6+P77C0/KH9pNWLeoKKuLb/hRs0KY/86CsBHH2GjxtzkICLTniltgOKyxGcguvrgo/B5TwM77fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=cVYWI52AxNYqH+dvAm0oYPcexIun6v0rtlnCJGmyRZU8/U0vHZDwt7eGTd7nwhkaSnlWGGaSsswl2IIOUbnwoMRXuicidCfSxy7xXjEuRkJtiJIbBNOE094TFCEJ63j4oXoiLXzyCCDztWe8d2z6UXrF61GV88kLyP3EAfiVvdpg9DbcN4BMU8piojWFnKV3WWo+z3jteOi4utPzM8rLeRmepGsCWfhETWD4kv3iR1e2Fc0Kwf6Re9AqS1yXOTjaSyyQUjCCm7VulvFx7J3HmetCwWrjkdUTGkdFvKbSoTKlt+xcU3+WR72NQQnNmVH9NzTaTM7Y+ikSLOb0JxAsLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Tue, 7 Jan 2025 03:44:37 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:44:37 +0000
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
Subject: [PATCH v5 22/25] device/dax: Properly refcount device dax pages when mapping
Date: Tue,  7 Jan 2025 14:42:38 +1100
Message-ID: <76a9b48325b4daedd9d5aec1d88e5b10e94500f6.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0030.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7ff89a-94de-49af-2a47-08dd2ecd9bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KatHTJMl3m8iiIsZgDC2e4izT2d5EL0y6VKc8RXQ143pDaH2BqiTbAvRgwke?=
 =?us-ascii?Q?ggoF1oU9arHhzNuT5YFoBrGoei7Hzqg5K9g0cIMXWKNtTcb7wtES+kOKf3yV?=
 =?us-ascii?Q?/XEqIbgJjXqz8+dX5jarFnIDniH545OyR47yzymEPRRX74RlEgKd1VYPM+EP?=
 =?us-ascii?Q?optoiYDLq9dFAOJUyxTaVEK2FykhCcCcJqofCmfTz+ZFLqW70+ASHZV9widg?=
 =?us-ascii?Q?P4SLYFWGEad5mWjFzeZzUsoLM/cZsmDDFE/mCG60NVBDjggKN9EB83MCWPir?=
 =?us-ascii?Q?tQOdglRfnlVwciLkkqzP8JcEPqOuElO76LUsRKSDjBRY7vmDl9P/dpHSR9wK?=
 =?us-ascii?Q?9kDttSLw8HSXi/7vCsZndePkA8P569YSic4oRRTNUgT3l6DKPrbY98bGuX0F?=
 =?us-ascii?Q?rOhZ99qTvoxgiT5xH9OrhP+wgZNDAFci7Q9+r5mveNXgUoPkkDfUixlU3JgC?=
 =?us-ascii?Q?IDR00A7l2bTV6VrTr52h7jMlBGfEj4kUBEKekqpCiXKgL3+pFWB2GyE9Z72P?=
 =?us-ascii?Q?GxrOrqB2G+4KpdDyX672QdWM2a3+YvLGv9X1ND+OaIbKQypk+f4Oy3BBq+Jd?=
 =?us-ascii?Q?MXHsU6/uthmVDz1eq4bSo+ov1GhomfOiGbxc7Ko3wnvBvmD5eXZvVBKYHnh9?=
 =?us-ascii?Q?0UPCxrgdwFv5zZVnd99d4j0tYaJhvnMRa+fdyRLwEMDJkxVu2B0aeX2ypIzY?=
 =?us-ascii?Q?B/ziWidwqoNMjZOu8VATeSeNFRmwq/WDuSPWnh+zd2NECOGtNS1GGOnILunJ?=
 =?us-ascii?Q?fK3rzOT4OqWG+NE+Bvu+Wmnc4Hoco/HpxQ3A/KhqMiuVS4kmclHfNNIVUqsQ?=
 =?us-ascii?Q?1IzfFySgw9GzXeX2AIAQhXFW+96vtlHKwemnK9IZJZqZtJV+sahsUi/vGx1a?=
 =?us-ascii?Q?kkmg+gWGxuHBDzd4JNpdb0hfF+wSvq+9aO1/M8aMaHnXK4JE89S5/htDKGBZ?=
 =?us-ascii?Q?rg97zDOLJqxTX8zry9DRcqDK0LShcABjsxFRbjmj3aCJzORoG8ipqAQXtFnT?=
 =?us-ascii?Q?f7zGQ4mnyOc3jJKMZoqaUZ/6HM7x4mW3ekGufmjiOrxzBT9cKJkUh5tvlg3T?=
 =?us-ascii?Q?lc4CuxH/5IoK+BEl/9tTknFtF1L5K9ZPB0QmRm32My1lDAh1S+l0iPNuBGN3?=
 =?us-ascii?Q?Lv15RMSEquXgG1eh/TbSDV4McAoW/JejVPV8BayB5sedGqoj6NcIAe4IDUhr?=
 =?us-ascii?Q?pnk6wOfu5M1lk6WGyB06fintqs9n7R/rKVyCSbmOs1P8df4lf2ara38TkFd9?=
 =?us-ascii?Q?v/CVxqTr/NBHyl6FglqwcZc+bGv34IcmtVUYgzmJotmHraaww67xyXotaRu9?=
 =?us-ascii?Q?pyQfVyX1GJLHTrGSghcjr6ysPntIFOyG/dFCkQRS0xPor2bxB4KTtWHkf3As?=
 =?us-ascii?Q?xqhygTWrLXbbFegFNLvOOsbU7tFM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5pBjyI4RTSEPpLPluB0btFY3jGjvdKR7xHJJ8evWReD50Tx3YmmR3njG15G+?=
 =?us-ascii?Q?E/5f2a0bRb+mNCLCdKB7gsydLRN6+blM1pEbqtjAMzDkc3cHeTl1AVJwdJ5e?=
 =?us-ascii?Q?tCQMZ3fU298mPV+5if+Vkap9K8mJmYZRX6jjbab0LRGrpMjl+ekmUKJLb5dT?=
 =?us-ascii?Q?6Csuyfm2oXpb6KjHGuN3X1MdthNRzjkb3zMKIH+9c1gwx07mCPonqjH4KUFb?=
 =?us-ascii?Q?BL5nvr2ZYmrTv0jARGIYxOfWtPhXb5/hWmEhU5En2obaq2cerI18BVXDI0Fm?=
 =?us-ascii?Q?34h7+zKnJQcU3tC0XgAqmTfkzF9AL7sZZhCnGRg76pBg1Sw8gudigJ+4TSS7?=
 =?us-ascii?Q?hc1YDOPB7BufidHfLN5cyyXBS4OPtO0hrqfDhzdEktR2P2Tx1dP7dcH8R1of?=
 =?us-ascii?Q?NK+Zd+7qR49h2rY6aC+vMiEO5g5FnZCC3Hpk2CRTWBuEDlLIfk5dbh5gk10g?=
 =?us-ascii?Q?PIcMWOtrQOg31VwFlbZPTxDMCQltQuzvSA0meKtI11UsNsI2x7kIVTFwStrA?=
 =?us-ascii?Q?2+zIOnIz5uoauEb/Io71FmmFYnhckMBxFv4h/nuPc8DBARMmTFoctg3TWj+M?=
 =?us-ascii?Q?f4+pQMXZbg1XZgxoHbQV4NCPt/oqMGjYHy5oGylK1FfRXhHOygr3Xiapl0k2?=
 =?us-ascii?Q?iyvCZLai+9+ZCIeZXTCNCbkZ9fVq4vYlOJK90LWMUNh4QyqyeY88VrLOibH/?=
 =?us-ascii?Q?pYN7l6raDqFOCv3+wEFWOWgC/Tj0QWc3MtNi0bbYODILq+Glio/lJUanIRA0?=
 =?us-ascii?Q?OoidVl2xS6dw06mJg1JZmkyxbJY09hqYmD5kqICviHc6yLCyCK5RobtL25te?=
 =?us-ascii?Q?GQixA/SImB6tOKTe8+4ZnI9ZnPfA6FwpOLXU41ClW+6wM7s+YGZPMa/fiEeY?=
 =?us-ascii?Q?dWYzYG1liMpEyttpW1XPWvD9mznEh+VruF8oJICbdXECQvIta5/k14XsiCzA?=
 =?us-ascii?Q?j40DqgAJKGjiSCOTe7WCDYNY8/2ty/4ZqRBNCy8tLqkmEEHyWR6x9sCxrf0k?=
 =?us-ascii?Q?6NpMnvvdWo0UR6nsOw2fegW00RcUUvGzw8pOCJI1LDIA7Tai8OU1nsCA1faz?=
 =?us-ascii?Q?7xhynS5SzWhV5dRZkO+COFD7ao6RCN0q1bmcEik4Ia7f2GxZpopw3mcHp0hB?=
 =?us-ascii?Q?r+eIBCHilRYt5561fRupe0PwIqZofhvDNlSov/TesJegRlEcxOA8Geyo6htS?=
 =?us-ascii?Q?m8EUARulCcPKmnLvbqZ8qLZxAiF+btQ99zUQrcl62jeGLbZsdrnG1ka6jhqM?=
 =?us-ascii?Q?3Z5VSkyun+CCzKa34U/YFGJXWkqk8IqyrSiUKEnqgU+xgwH56RdvOW3tuXXO?=
 =?us-ascii?Q?o1q+nh9wPkN9tx/NTPVsQ7zbnZasuNfhv3VHznt/kwkERDqoL23RaNEIWkSW?=
 =?us-ascii?Q?yRqx9B1ehugrVvRbgHxVOy7Tgt62TpkjG2Oo/kKpOgYs+zoy/+W6mp07YtlA?=
 =?us-ascii?Q?Rzkp1qYOFwQ0zpuh6bdeSKm8v4Stjo8/x361U2hJMllD6QeJ2re1IE8uTSkl?=
 =?us-ascii?Q?Xk3tAp+S0Nvu/tSzMN5Trkw8vQlIpTjlcD49nYh5FjuX/ol4KgkZpIb/RJLy?=
 =?us-ascii?Q?xAJb3W5lLFkB9cVgkkeWGboenpwLN8Sq6f7Tp9C5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7ff89a-94de-49af-2a47-08dd2ecd9bab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:44:37.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GB6fwl9yHYs20pf3Z6qVVkEL3yvxVTHBKWtXCRepke6Z/7JAgemzoS4JFTLOLsVMx4i019Exb/ToooMI1+K46w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

Device DAX pages are currently not reference counted when mapped,
instead relying on the devmap PTE bit to ensure mapping code will not
get/put references. This requires special handling in various page
table walkers, particularly GUP, to manage references on the
underlying pgmap to ensure the pages remain valid.

However there is no reason these pages can't be refcounted properly at
map time. Doning so eliminates the need for the devmap PTE bit,
freeing up a precious PTE bit. It also simplifies GUP as it no longer
needs to manage the special pgmap references and can instead just
treat the pages normally as defined by vm_normal_page().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/dax/device.c | 15 +++++++++------
 mm/memremap.c        | 13 ++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 6d74e62..fd22dbf 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -126,11 +126,12 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+					vmf->flags & FAULT_FLAG_WRITE);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
@@ -169,11 +170,12 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -214,11 +216,12 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pud(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
diff --git a/mm/memremap.c b/mm/memremap.c
index 9a8879b..532a52a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -460,11 +460,10 @@ void free_zone_device_folio(struct folio *folio)
 {
 	struct dev_pagemap *pgmap = folio->pgmap;
 
-	if (WARN_ON_ONCE(!pgmap->ops))
-		return;
-
-	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
-			 !pgmap->ops->page_free))
+	if (WARN_ON_ONCE((!pgmap->ops &&
+			  pgmap->type != MEMORY_DEVICE_GENERIC) ||
+			 (pgmap->ops && !pgmap->ops->page_free &&
+			  pgmap->type != MEMORY_DEVICE_FS_DAX)))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -494,7 +493,8 @@ void free_zone_device_folio(struct folio *folio)
 	 * zero which indicating the page has been removed from the file
 	 * system mapping.
 	 */
-	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX &&
+	    pgmap->type != MEMORY_DEVICE_GENERIC)
 		folio->mapping = NULL;
 
 	switch (pgmap->type) {
@@ -509,7 +509,6 @@ void free_zone_device_folio(struct folio *folio)
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
-		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
-- 
git-series 0.9.1

