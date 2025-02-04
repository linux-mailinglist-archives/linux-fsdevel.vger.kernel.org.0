Return-Path: <linux-fsdevel+bounces-40838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD1A27EB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41DE1665CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5B622370F;
	Tue,  4 Feb 2025 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="coQbm4Hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB221CA09;
	Tue,  4 Feb 2025 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709360; cv=fail; b=HXoSfLgcDXUut0Lquf9JC9TIaAc7DiTteN9gyNfT1bpcg1S5wnK/qOf1mjJINKKci4WOVGmdopA4aMiqEG6522+q8nSVVns+We83qNhcdXYz5FLoHCf1pdDAs6ldoEfWA9lqolHQi1n8DTIkqJOkmgvOupMuSF1MbZWneyydwmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709360; c=relaxed/simple;
	bh=dUlTqc9u6IsxnhvU04QniFbNb+cc1sDHsCJfpJzJOiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQN4oc9owp8lpC4pMxUcP0B2X4FxNf1yudjhnNPFXyUhaYz7w2R5/VL2/EvwHR3OtB7NP4p5umJ6ceScHTA3DGCemJxGD1B5XVwFcgMj1SK2bQXMBvaAaT8ZaHHQgpEvxTqlxL8jJ2y3jH2sUVdNAbzgq5G7v4wG2SI3PZaVR1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=coQbm4Hh; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWkPnd1mUAu6wgua3NKPqjCGidih9Ce/ZcqMhY1Tjsbcn47LPJxaSHJjWoSZ8aTCPOIYxq/WPUwXJJ8lmVXp/+/gbjuKUKAOxNUG7HCODm6LuFph2rw/RltF0co1P9rOaSruHKgs91YPMU21wFtTTET8r02PUBzIFwWI4bgQ8gemPRklo9r4sdAfzvqrjTKBuFSELeuZEppiSLFmCCS+Xma76KaHWg3Tt3IVwNm6PKN+liNNtrUDvwCcJokG+2SAwNagQKBykYlVHbe0DS0jG85sreygDHCT8nVItOj50IRifJ2NU+PlqXZ5Bzo5R86rLh98wBkJPARxpyMhmL3z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg560wvl1Mx/lUDQ5xPCIbLEvq3tfowlq6KuG94pc1A=;
 b=k6kpiQ8qUMGDQRrxi3Dg0rthNk7Una9s8SQTDwQEsE/+5KE/wvubvDHSg9NkS2gYZdgWvCvlY2pKK0WQwAyPXZiF7DGKcGWgLRz9fYg7gygQWL6weQvDKXV146c+HKGumm0OFMNYwJmwVq1eB2fAreNFsEAEWYkVnkg8WfPosVvPaz9Hllc4qE1Hp04rptDulPs5tbv67mGxql2RgJTouqTllejTvjSqXlidJr+f5pRmvEBIFDs3Ap5aAb3LIQDpQYKAG9O/tzb4K76pqBFc3U8M5GwvJ92hNBJu8oDGaSF5E/GWxlX8t5+xwyxZTzpPKv4axngvFP6+9UQjmzky6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg560wvl1Mx/lUDQ5xPCIbLEvq3tfowlq6KuG94pc1A=;
 b=coQbm4HhxE6SxCW+LZW1aNoiP5/HxsEPe6k5/46v2RZeHimgGMQr7sJ8ZV8o1SMqaVHYHQua01PN/CfeSKQZ0vIImdqJDLsBP8YExv+/dG9Cp3fY5mM6cGxwMFgVr7yz8dSS3lh/Jawga/vO527aTgPBgR7yzJ56Zi+oeem/8m3ooksfVhHFDUSYmxVLAdhBtSu07oQcV6eMpAlRprlAa6VwGkL0vsMX5bQAHEGqwt20BbLjWP5UgOEAz9rXMIkhCDoTU/S62+eqWcTVljjrialKO2xQTOsGVfUZqks7CCLCQp3nN2uEue+yh0H+yUEGcQJUuAhC6nQJ5RZ5hQDX2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:49:14 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:14 +0000
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
Subject: [PATCH v7 08/20] fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping flag
Date: Wed,  5 Feb 2025 09:48:05 +1100
Message-ID: <43ec2089396e367fda2835c27717604b9bafe880.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0055.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b19395-5de9-4120-e54e-08dd456e261c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qPoPk0Vn3IyBhbeVkOMceUa4kfaDHOOR98GrqmXyT2QW4FahkUdPptwnIc10?=
 =?us-ascii?Q?L4VJNPXXAndu+DlFhL40omKa1pKTDXm/dA21j2YAk6+uDg4BD4uM3d6K4fn8?=
 =?us-ascii?Q?l3B4qzjjqkc/yFgbcFKsnrufaTkjNPJT7W2MDmQqP5tYJEjEn9CU8Cl0Mkhs?=
 =?us-ascii?Q?kp1DTmqCGrJEXToxe+QGSb05Pol1buo+HBOH9WgZMhRyvAX205P0fIP7ZQrc?=
 =?us-ascii?Q?DTEbhG8MRvkobV7L9TyuZ4wk5mS5BFDzxPWoG5XLFTBOU6Asu05HU7ycg0+P?=
 =?us-ascii?Q?eAeFbDj3A9YnF686yW2BgvFTOcn3qOSKzWz2+cdgyRFIDzV0/dnuBl1NmaI1?=
 =?us-ascii?Q?0hBM0avVlk8dtnY6Ri2GFNilNvmyQwe+aFZAzQSMETSksa1r1GNwk1oPYn6X?=
 =?us-ascii?Q?JCedJnHPTotw6uYfulIAh7g9jC4UdDYnghUsUpGl43f557ZfmDz4g59rXwIp?=
 =?us-ascii?Q?1gPrdG72sixGVOOpyElQS3Psvi8Nip5rXLriXob0iAi3v1UNh7QLO1skl8AI?=
 =?us-ascii?Q?VR84SjQdaLMO1Wnzdt7WZ4AAgLdSltrU0uCEckH8MHVOjTRvunKeBppzm5wZ?=
 =?us-ascii?Q?CZkvCqonuonrKmZLsUcYPkrJ9mMHvk9K4ZGXcJUWQmtTF5TMK6Kwr6VTN3ls?=
 =?us-ascii?Q?52WdI3z1icrdR4UcTinLu9AiV+fjMxGoNKybO4LUOol8yrJp5YYLVBIY4Dsr?=
 =?us-ascii?Q?sDmw3radA+FlY22LcQK2YQMQzgtY1O0qHZRVm6zlJE1FsSIZRcpdErA8UKy6?=
 =?us-ascii?Q?CAEE6fiPo+5VNax9ARvBQqDwcf417y90qxQv6h5OLyTQ75M2dBRdx/qse3Vx?=
 =?us-ascii?Q?DagZILmbAvK8oLVKl9bMtGp9mSy6fzG0hwnj2VmoREIt0OkpCxdAKy7s8RG6?=
 =?us-ascii?Q?E9n0KAwXDTYr7G6SPeFs8k4W11/9kKNJPV+pgdLjCq0GUBxAhhcjATWnKdqE?=
 =?us-ascii?Q?DqRdcOMd4xbhzz3Bij0KqR8WreMoHntrHrgDmcO0funTiaeJLbxu2kg23boC?=
 =?us-ascii?Q?T1hknlAYY6ZoGJEaRsz2PdYJoEl8VLBr2G/GC6RIpsmCrtOoq8RMiZ96+kI+?=
 =?us-ascii?Q?MvGCielutbbTwKxxSLhxx4DAjZ7DZLOMCHuty3ydzPhKHnLRcG2jKrP5nk/d?=
 =?us-ascii?Q?sYv6zgyzMRgllXjucCZQutxoD/KE2emD4z3mPektNC7CYpAhHoNTkemMuSKF?=
 =?us-ascii?Q?aPVxCXxF66Np91HA7n8Eafny0e4UWHAWNSbY6B4xpZYg3CdzSLxiPdN89+LV?=
 =?us-ascii?Q?U6mFyicFEAId4xQaTJQqEHf3bxrjFs+1GLjEm62mZ0oCD/e5wx65eZ1VsVJH?=
 =?us-ascii?Q?whmpdhBsDVBDB3S1HDkoA2h6VeN13yZf30ePuuIQGnnviAd3IHr+i/kzLCmY?=
 =?us-ascii?Q?ShhtJVcRp6A8dxhhuHKk2v4ixyHU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dhYGv4IfmoOtIfujtbHUeTNYYpGhzDrN0S4zn7QdYJcf1lZNuOIVUBe/9XuL?=
 =?us-ascii?Q?q7Mfk6Aa2Bi04begTJuOUZQ3UyHJ74GA71dfYAxgykZZgsOxdIKdKXh9LXhN?=
 =?us-ascii?Q?EJDb7E5Hc3rLF9FpEQWeoPbeCywLKHvigKC+onH2aHCZVHdDhmNlHmCOIqDI?=
 =?us-ascii?Q?JoYToL92aH4ypShe7uihlYngOmdtRyZDff/G8Cu08qSrbdI02QJlHVdBp6ng?=
 =?us-ascii?Q?TZfZ8Pm2y9K0GAOBXlJEkM3/WdtzXCU+PguNc1bdgrr8KL9/FYbXoQkGprP9?=
 =?us-ascii?Q?olBXma/8ymkxs0vc84unMbUQbjH6ADm18b/qktUGaS6Lh/RYq5N+WVMil+mm?=
 =?us-ascii?Q?HsTFmBaIzeWoG8cqjJiIyx5swPxS9dHOMgJZ8OcGBUe5Kw34YRA+BBc/3c+I?=
 =?us-ascii?Q?impYLn7aqVCkizWwOF3HtjoDGnOuKlfbFxJHKGjYNQdG58vFIJT+UkNLP1e1?=
 =?us-ascii?Q?J9M2hsifBol/fqWiGdDGuAdgpCvoIkhZwcuSvBthLOp8NZyXVP6OPtlC+N4o?=
 =?us-ascii?Q?7Zdx2X14IxR0vNUyKbQgQUfkRXYMMMQM+Zl8xAvFVN22tOaFXpnw0UfJxXN5?=
 =?us-ascii?Q?B7ggOJZVzUDGI3ft00K995chH2aW4YtCBFQl36WwOHPibmyfp/ec9oVFgdlp?=
 =?us-ascii?Q?jBZk+TsTzewVNlyXfsw9AuIqN8ya0HABJvxCShUgUYpFq/9CbCKMwcszRJkj?=
 =?us-ascii?Q?caVvfou9v64ShuQpGN0GlsUpkrY793VPwsOULBKZ8bx0ANky0odMGZqAx2Q1?=
 =?us-ascii?Q?AzXnBxh70UU+/PEgIqjogOeA84WpkO19Ydb1k4Q3jsYHzAANk9WphLvx30Do?=
 =?us-ascii?Q?DZMZgmZGOMYnzzgvyJNu3aDFIzwkk7eBA9IqGZWuReHqgRMEWgknNevw+F3Q?=
 =?us-ascii?Q?SLnLXMR5UB/j6NTTKD4Rbxf44CstqLqWW2Tw6VaOCBiqi3j/OR5H8aAM/XKd?=
 =?us-ascii?Q?u2tO6yvIzHTp4CT26SB7+ewnvhe7brcH+K+90XmMAyyeCfmZ72nIzt4jAU/f?=
 =?us-ascii?Q?H99m2BUoURokxpE01W74DMzmFvTA7uql4PHgRDdJOsee8uBs6bt6a1nw0f1q?=
 =?us-ascii?Q?L5tsDtr6lTDI8BulbMgNApMBbPtf1b9bdX+BmJjRo3N1QJEVwusNHfEuvtOc?=
 =?us-ascii?Q?W91c8NU1JJ3exnNZWLmuD6HBnT+vKOc/l8tiUEvG68SUwjxO+IiR3k2WSNk9?=
 =?us-ascii?Q?4nhGjOpswQs0RPMsUIuNl5Ncse/4W+x/F3RQbDhi9lLbS4IWN1i4FObbW0tj?=
 =?us-ascii?Q?WH8pB3S+IjEcm3m7Gb03xvKvUOGhbjUkFNH61f9OQxbcSnnSS0f6mSYJc3ML?=
 =?us-ascii?Q?MmBlSbOMwLrwxBhXUMQS4zT9/uwjHTpKIPIjKgChYnMhs1XMeQyVUC+mm0nT?=
 =?us-ascii?Q?rif3/ryvaliThdM4M+K5SEGdXKmYxf+y0ygzikh6h2HePYaXeCMmNYLczI2G?=
 =?us-ascii?Q?ffS4q76HzShkJy+dZrLtYYdKesP4gevW6JucXp6D4/GJ9yjJmDYcA5unYhj5?=
 =?us-ascii?Q?+EIGSlMJYtwe2NLDY/x3tN/ZcYi9GGrPsLMiI2Qmm2pRzmhVyjvtQJWecYDh?=
 =?us-ascii?Q?snwREfqN8lRGvi/mdC48uzr+dMOIE1/P9ZajGG/Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b19395-5de9-4120-e54e-08dd456e261c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:14.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WluYl+zvbUG9mYMES4O1ugJrT6/QkNiR+yvAbWa/cS19XF55zrXgKCz8mWOL8L9r+pEwamN0DEuJS7MGuhnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

The page ->mapping pointer can have magic values like
PAGE_MAPPING_DAX_SHARED and PAGE_MAPPING_ANON for page owner specific
usage. Currently PAGE_MAPPING_DAX_SHARED and PAGE_MAPPING_ANON alias to the
same value. This isn't a problem because FS DAX pages are never seen by the
anonymous mapping code and vice versa.

However a future change will make FS DAX pages more like normal pages, so
folio_test_anon() must not return true for a FS DAX page.

We could explicitly test for a FS DAX page in folio_test_anon(),
etc. however the PAGE_MAPPING_DAX_SHARED flag isn't actually
needed. Instead we can use the page->mapping field to implicitly track the
first mapping of a page. If page->mapping is non-NULL it implies the page
is associated with a single mapping at page->index. If the page is
associated with a second mapping clear page->mapping and set page->share to
1.

This is possible because a shared mapping implies the file-system
implements dax_holder_operations which makes the ->mapping and ->index,
which is a union with ->share, unused.

The page is considered shared when page->mapping == NULL and
page->share > 0 or page->mapping != NULL, implying it is present in at
least one address space. This also makes it easier for a future change to
detect when a page is first mapped into an address space which requires
special handling.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v7:

 - Fix for checking when creating a shared mapping in dax_associate_entry.
 - Remove dax_page_share_get().
 - Add dax_page_make_shared().
---
 fs/dax.c                   | 55 ++++++++++++++++++++++++---------------
 include/linux/page-flags.h |  6 +----
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 9c28eb3..1128a0d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -351,39 +351,48 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
+/*
+ * A DAX page is considered shared if it has no mapping set and ->share (which
+ * shares the ->index field) is non-zero. Note this may return false even if the
+ * page is shared between multiple files but has not yet actually been mapped
+ * into multiple address spaces.
+ */
 static inline bool dax_page_is_shared(struct page *page)
 {
-	return page->mapping == PAGE_MAPPING_DAX_SHARED;
+	return !page->mapping && page->share;
 }
 
 /*
- * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
- * refcount.
+ * When it is called by dax_insert_entry(), the shared flag will indicate
+ * whether this entry is shared by multiple files. If the page has not
+ * previously been associated with any mappings the ->mapping and ->index
+ * fields will be set. If it has already been associated with a mapping
+ * the mapping will be cleared and the share count set. It's then up to
+ * reverse map users like memory_failure() to call back into the filesystem to
+ * recover ->mapping and ->index information. For example by implementing
+ * dax_holder_operations.
  */
-static inline void dax_page_share_get(struct page *page)
+static void dax_page_make_shared(struct page *page)
 {
-	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
-		/*
-		 * Reset the index if the page was already mapped
-		 * regularly before.
-		 */
-		if (page->mapping)
-			page->share = 1;
-		page->mapping = PAGE_MAPPING_DAX_SHARED;
-	}
-	page->share++;
+	/*
+	 * page is not currently shared so mark it as shared by clearing
+	 * page->mapping.
+	 */
+	page->mapping = NULL;
+
+	/*
+	 * page has previously been mapped into one address space so set the
+	 * share count.
+	 */
+	page->share = 1;
 }
 
 static inline unsigned long dax_page_share_put(struct page *page)
 {
+	WARN_ON_ONCE(!page->share);
 	return --page->share;
 }
 
-/*
- * When it is called in dax_insert_entry(), the shared flag will indicate that
- * whether this entry is shared by multiple files.  If so, set the page->mapping
- * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
- */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
 		struct vm_area_struct *vma, unsigned long address, bool shared)
 {
@@ -397,8 +406,12 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (shared) {
-			dax_page_share_get(page);
+		if (shared && (page->mapping || page->share)) {
+			if (page->mapping)
+				dax_page_make_shared(page);
+
+			WARN_ON_ONCE(!page->share);
+			page->share++;
 		} else {
 			WARN_ON_ONCE(page->mapping);
 			page->mapping = mapping;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 36d2835..cab382b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -673,12 +673,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 
-/*
- * Different with flags above, this flag is used only for fsdax mode.  It
- * indicates that this page->mapping is now under reflink case.
- */
-#define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
-
 static __always_inline bool folio_mapping_flags(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
-- 
git-series 0.9.1

