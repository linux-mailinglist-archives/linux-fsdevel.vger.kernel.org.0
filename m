Return-Path: <linux-fsdevel+bounces-41911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F4A39181
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795373B3001
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 03:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770CA1ABEAC;
	Tue, 18 Feb 2025 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eot5qjsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A11A254C;
	Tue, 18 Feb 2025 03:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850963; cv=fail; b=DDAVFkR43p2AULp/cLZNHu3WLFbcx0lzIWENtxPkpehXRWqymYpj7sxhcbDrTWcvqyl6myXB52ZQcZx7k5NS6SnVGClWUn4fCENGQQx1nPdNXFFK8OPTZEbszshi/jZ9i9ZrQu56gjq1Kw2KRhdLAoCYY62nB7Ijwf222VkxmqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850963; c=relaxed/simple;
	bh=5/d30KwRzi0/d8XqveRbEC2GpdHbnWrTnk2QdYNj2o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cx/ltrTPOWqYFU7PXeeWWJ7q5mAAyEt7NQITHMUOhOq8j/TQ076Kiowxz7+Zw1TUnsho+X8Oy/bLvxpV2zqNDYFVYBP4Kzgr86MPA3ZpWGsBSiUurV2wRhdYGekE2A2oVZOnuebBLJ754tAFr6SSr2ZlgRRfIgp7z+bLlDoy4Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eot5qjsS; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWdREEvzuJx45A79T5w7NyslQ2MJxhabFXAB90kFinhHq5se0wZOsi99MhhVQlN2Q8P14BGF46YQW4VQY9OnPIqp4JoZDPuCEa7HxABWFmsE2KrkWPtMmYP4q89t2wD7xfBH6Wm1VMkaiVFAGvLhAmLUnExeSbk9ASJfuVXncgc7FRH9gVieaABRdzI1JkQRyZxW5LXl4jB0HI85OIvOdMlnF7yRWSZD41AfLMJRyATVkgnutgb3GAAfajnFuMcRZ/QWRI90sK4Us6Wfz7uv6qXjPbuV31D0e2odY+yuyhA4a/1nVVadvvOnwgDD7LkcLbe5nquKtICvN7xZq5lx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fpOKX5mt97+LmuzK0U3LyecTQPT8dlAshklE5pRhO4=;
 b=X3iM5MNr/oYYVq8L6lmLxiLTCZKykcktIzjMiGzYTnO1yMlIFAW56Ke+NeDU345Hc39EKNR2pqKP98i+Xx85AvtxodP9UAs8Gym8HdxK9ftcXY4KK7APQCnhoCtDtrAJdSVelB22eGnGiF+m78Jf62IHSWMfmPYrAevTmwlk97bjJSZAb7RGlU06MidZiclB+k2btBheWZfmnmnX3IMmRYghQoIenWvbyB21gZif86HMIudZc20iYCPVEifQizFCReLLA17Dg2ySfTyxt82F5xzBgkHstu3jI612zxS5BdnOXIP3VVg1z4LUVQ7kHtqw78hcqck6FWds61mX9jT6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fpOKX5mt97+LmuzK0U3LyecTQPT8dlAshklE5pRhO4=;
 b=Eot5qjsSMksUPGcZ2W9+d+LDObgfkKnuUA921BDNSMus/ylTDXbjxRuqNVEO+hRa+Y58oXUVxU/m5k+LJmz424K/SezGdm8lVoaVnEhVg6ENB9aNb9CsYpv0vNVEEzeTOQ+EER8luRLn5O8PcvvODrkzGqN5yVdxy2rzyJFKUBEtBh/XWbxZj+22it2XeF9+cP1Y0Hr+EFdMMfNNWiyud1nbhQbehiCAm7Yns1JR/8x/VfAyxdOVgUsTkXeaVwraq/xkL2HzD9jJGgre1EO4f+8ey1XZAGm0FoEJ6Tfr4C9FvHlMVaovH7LnFOqqooXyETEUDDYluqQtcVOB1jUmsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 18 Feb
 2025 03:55:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:55:53 +0000
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
	loongarch@lists.linux.dev,
	Balbir Singh <balbirs@nvidia.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v8 01/20] fuse: Fix dax truncate/punch_hole fault path
Date: Tue, 18 Feb 2025 14:55:17 +1100
Message-ID: <f09a34b6c40032022e4ddee6fadb7cc676f08867.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cd05f5-eb0e-48c5-8c0c-08dd4fd023b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AggfaFSdqwyBiOYjAnXAX1fvIGknNcfsM2ByopVnDjMzJkLaer17BZiovigC?=
 =?us-ascii?Q?y17ljUWilEH2qh9mzum8QCa7UEEWuaN6KqchwdngzeHV9UuPPcTZHcXCUV2s?=
 =?us-ascii?Q?zPOpqEmRrl+qSDwoJkwvDoZVIzp/WwbqZ6MzFZfIoLrWJad1ZZbB3TJPt9dC?=
 =?us-ascii?Q?2xFGOpXPCVF9jm30idd1EMZWs/xd8F0c/zZuE17ahpBBoaLSPi1vqN671mry?=
 =?us-ascii?Q?VsZwKXflTXmPIyaZsDsLsmAk0IjaTpvAVbZ440NNpolDiUb6uGwH/PDiJpbp?=
 =?us-ascii?Q?2F7c06yCQheKfPDsfMhF9n+EqZspbQzpqQKqXQ6roHL0L8ap1LhVEo+Bwvw1?=
 =?us-ascii?Q?ytXw2pcSB6mG4UdbV4JW83K84gkQ0n61IyKd6ZaVE6QN5Kfv3zDrSJrIwC7/?=
 =?us-ascii?Q?lm8dyWp9YKk8t9+xjykRBcxzJ3Lcz17DYdiRuEigkzKJ50BmFMyI2wFmrib2?=
 =?us-ascii?Q?Oa0/mpHZB/UfflZ3vpmf+giCbljFl54J1iGHoA9jlUUC6CjfMDwLelMj3qk5?=
 =?us-ascii?Q?5pBjQ+eFsgtf0YnLDtDB03b45p7l/yJPkXYlIsDN3ThYlwlyqPPPOlYcqbbA?=
 =?us-ascii?Q?WA+IWwBkUxspxIEkDJq2ioN2wCBcgFwFVLne0RQYa/jIydSWYSfqC6DJ491h?=
 =?us-ascii?Q?/TrmdUFIj/eOwftIc9pLWKJy1PgGI3kN2MJId05OHfMucOjDzb7kkzgyk4Fw?=
 =?us-ascii?Q?ImJUK33xVeXoLswIMBxseZtAxvZF9fnXVtvXV9g1GuRW2g3A6VDxoKhfA6OZ?=
 =?us-ascii?Q?QgKz8UE0GEUpa8Nu9WtNlVRwrNOdIACTj54Wj0uNemFjeuDaeii3ktfhk4UU?=
 =?us-ascii?Q?ZBOb6yTedXboCgDUD/PbuAjtwKyI/xx4E9W2obHfyHUew6z0TO22h6OZr2iq?=
 =?us-ascii?Q?Bmd1to5WNRq2WyXnrjQ7/QVkiwQt4lwpr3xyayG+CGYasj1pYo3AE8GX3jV8?=
 =?us-ascii?Q?ulOqA7YOMt/lnM5pEiInegFokAwvPHgAf6S8H2LZO07nrmZtCIIRT1tRRnVj?=
 =?us-ascii?Q?KqzGOofzMHOJUn9RprupMtxvalyFpG6a1leGCxGQ+LVWJJkmq/IALD+YmmVW?=
 =?us-ascii?Q?OKchjAtCEhFr7pLszGDFer7J2ESNpqoD3tiFQrAABI6P/aw8GB6eGKgMwx0W?=
 =?us-ascii?Q?39bZKF8qqeju9N+oCZ0CTvboDd2In0L+4/v9D3PchzhY29QmDlSfGya2iy7q?=
 =?us-ascii?Q?kAqKYw43J25p7WoEg4Da/fy4mU9vSf7iG1ZU4rDIBu/aPkmY+QGZ0c6Sg62Q?=
 =?us-ascii?Q?Uw/zBJbQ2wekS3N/uQ18gsFXTL6S0z2+NtjgByPqzcFKrYdLHIWLz7Dkajq4?=
 =?us-ascii?Q?+I61nOoSETJNOKJPaw1g3dhmw5jLDuRzZ3L4K8J+gsQ04rfuEriRfiZGr83X?=
 =?us-ascii?Q?6XlvfZaRlcbR+KSmZ10Gu6Bq/ROy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74O4lyJ3H7uUCKZYGInh6YihxDHGc28aHvi+ABGMm48x8eZdO+wm5vcTuFND?=
 =?us-ascii?Q?Kh5cIfUhTCcoANJFi1Uzv+ctECDstOTHGz3tfHI27Ir1M6oCKcYJb86lVuUH?=
 =?us-ascii?Q?GoL1DJpUuBd1asGv/x0EpNcPwBeUsyLtveyiBDt4YMcPTwmr11IfcI7SS04s?=
 =?us-ascii?Q?Vnz3XHFivRKCOMOcifU69Q6hoDb3KIRPzb5t/eGHK7heLFTdGRij81zK5FM0?=
 =?us-ascii?Q?XlcHG/1Y3sKKTfXqSgpCzMPoJuiLdmA6V213fzzDwBZr7/b8otxbMNy+H4CE?=
 =?us-ascii?Q?/ot8Er0SiGGepEkLd/VKXSxNJCV8Ju5iiTHRI5Q9FiEMgosdrPByhhsotoLF?=
 =?us-ascii?Q?3lnRja0Ti3rZ5yyYnfzCj39IzAOYgPZk9rfAH8bnxNqs3q7mn6O7L9y4Rgez?=
 =?us-ascii?Q?wS8QkzmWTwGfGvr2JhJmunPMdn40Ribh32r7QulQPsuGhoMHwl50xa48EEWx?=
 =?us-ascii?Q?1OEiH4j6yB+JQa7By6c+T9qrG0yyehUgEEkfr0WOIqY4VxS+DU6S+rKltGSC?=
 =?us-ascii?Q?4sZHXlYo5hL4OVwHgefhtGVsxqj75acOyZAmdNVryhobd9Hla3z6lHBCqclk?=
 =?us-ascii?Q?9IrH4jBeyCXWBPJqvg4MXG5F2jbZqxurTlK2/BDSkhIQLwiCoJ0mUhnscn8E?=
 =?us-ascii?Q?EC0BRBjrUbpiLpBgo+av1lzUh+X5yXzdXJ6ABIKKpLTLtaEAd5m+AezPfo2Y?=
 =?us-ascii?Q?QFr/hGxJOnld4nRIpKr+OA+yWM9w1Mah8yW04iGmqFvaqNulfSUGbbSW6tam?=
 =?us-ascii?Q?4cWFlJUhFhi+Gs+NBNPSELAqEov7NGFA0woSmCTuhZAGvlCyMqaxQhy1v0sK?=
 =?us-ascii?Q?jhb55BR6kggIve7TYj6onb0js6mXi2jqI9Jh7x8b0c/OWcTpD6jljZN1xhv/?=
 =?us-ascii?Q?OOCj+rv5R1yNDlAGl+Z0+HuJo9bsc58p/7o9ant2pcb6Sf35uSZ9jgBOvTI7?=
 =?us-ascii?Q?GBw1+cPjtgdpScc4SZgSCPIaQ3asDmleR668X4ij+fMyHNcdacQ1sAM3pI/e?=
 =?us-ascii?Q?Iocdxid71UPAk4Ih29SmET34S6C+xDzrLu9jy7vpRBoH5AwhJDp3VPORdonX?=
 =?us-ascii?Q?zx98xSOGw7U1y6azaXk5hTnt1Jc6boSERecclC98ZPJpSFbp03TzBarXAqP6?=
 =?us-ascii?Q?EdhLO+X4vhWKMR06AvTou2B+cgPkEdutA96e4T4mVhha8pLh4GsZPf8rjW2b?=
 =?us-ascii?Q?6otY8PC7sIP0ODoesYvmTmCNJyC6YE75yYFrkQ6Mj2tKwe5030K2iqzr9rz+?=
 =?us-ascii?Q?1l/q/6i8lvvrrdqQVYvrSxN+DxtU1Vrig76FL1Jw0JI+006OW0zes3lnY6Za?=
 =?us-ascii?Q?A0iFqSVEqs9YZaYkBInGtRns8cO9b+h2fjMBbwHz/aPM/MkDHlbGp0sksjlQ?=
 =?us-ascii?Q?7L5FjJ3OMjyXPsJ3anWdK7ajykh/APN4Afw0ODqf8xKzwkeffQsYJjmRVbPa?=
 =?us-ascii?Q?MS6GrHYcpLfLlNjgESFDKQe43eArV1nRgkSeGNKXvVEemw6fXyx9a8YAhItO?=
 =?us-ascii?Q?TkMxOtKop0iF3epHkJcQnAmPvfCU2TRvgXsMBC/ZGQa/xhdWOvp6JcSAjyKA?=
 =?us-ascii?Q?mNot+l+LDepD4hrLqqTkOoGN5V/ji0haQ/BGD+1v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cd05f5-eb0e-48c5-8c0c-08dd4fd023b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:55:53.0297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBCd2ahJTe0F2TvlTAtsgpm7PEVkehgXPVCCI6eK78Ywk9fJKLf/xeCzGFuTlOFBrRUjt2CnkfTPdXAX8eZQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

FS DAX requires file systems to call into the DAX layout prior to unlinking
inodes to ensure there is no ongoing DMA or other remote access to the
direct mapped page. The fuse file system implements
fuse_dax_break_layouts() to do this which includes a comment indicating
that passing dmap_end == 0 leads to unmapping of the whole file.

However this is not true - passing dmap_end == 0 will not unmap anything
before dmap_start, and further more dax_layout_busy_page_range() will not
scan any of the range to see if there maybe ongoing DMA access to the
range. Fix this by passing -1 for dmap_end to fuse_dax_break_layouts()
which will invalidate the entire file range to
dax_layout_busy_page_range().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
Cc: Vivek Goyal <vgoyal@redhat.com>

---

Changes for v6:

 - Original patch had a misplaced hunk due to a bad rebase.
 - Reworked fix based on Dan's comments.
---
 fs/fuse/dax.c  | 1 -
 fs/fuse/dir.c  | 2 +-
 fs/fuse/file.c | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 0b6ee6d..b7f805d 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -682,7 +682,6 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 			0, 0, fuse_wait_dax_page(inode));
 }
 
-/* dmap_end == 0 leads to unmapping of whole file */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 198862b..6c5d441 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1940,7 +1940,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err) {
 			filemap_invalidate_unlock(mapping);
 			return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d92a54..dc90613 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -253,7 +253,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 
 	if (dax_truncate) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out_inode_unlock;
 	}
@@ -3196,7 +3196,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	inode_lock(inode);
 	if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out;
 	}
-- 
git-series 0.9.1

