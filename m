Return-Path: <linux-fsdevel+bounces-38832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1252EA087F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDCC3A93D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835020FAAE;
	Fri, 10 Jan 2025 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OYnRCweQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDE20E71A;
	Fri, 10 Jan 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489016; cv=fail; b=WPsEJth46Hq3awgufaA1NlDx9UTks0KxKhO2W5NmBYtlu6/o/jAxZuN/qJkiLaWNHfNwuFmYFnR6B29a1dC2acsHnm+mp6Q9cia8d8Ud/zKFkhIIfcRiYvrlBBVal+8tDH+amLd+J1WeauGUkgTm1sJ/hLWX5eBJj0dr0HcwcgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489016; c=relaxed/simple;
	bh=Y5+/6X0xFawwRmhUCjufJZL3LhNC+cGhCTaBSqOaW7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=apmYmBMIK1UMIEoew7iPGkEfGGVOsgvO3KBJtunzO10VR14qrzd1j8TEVMGpIJvGGVxsxM9b5j5+/3UsKMJoDsP+jImQ3kPCN/JEWpTRacMecUZZOZZ9OAZa1OIVJ9INd4KSnpUe0Zw6xxmmlHtqOnJEM3odLbEWlPqabAKeEvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OYnRCweQ; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H08DlGYp2qMUPZd44cK5N4ZS3uSSN9LnxcqOq5GoUeALmaJYIfVZ4goc0TJ7ID/qWOcJLzTe5uRQiOL9BqqeGn7RqfDrvm0eu8DR6vj5n4NBe97l1McbmCThpvRbIYdp3CDRCW0gpxWkYhWQbrHqsYtdkVZyYt9RJ/uPvtFLlwQTosU1F2P6MxY6uha9fn0Wr8C/VNgf6k3P45dnx9lEUpz+rKh3NiS+GqLS6dF+oFJfhiogSSPdCixRJdPszctnB0b1vntTBS9HlNaLUS/lYfcwfz+ycu0vVrgbwcAmxSXbVwTlx498AyFrmaXWzyb98DxPzvFMfsumLbnzcePM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCgMbF7x2UBpOxgDMd1b2b4SxJz7gCANr+Q4cTmNWOM=;
 b=aYmpJWoY8CDs0+duKL8E50+e6Jef+Ou3Efq1S+p3XRhz3ySgbPuXFJklODlC/b06nseIhYsFG/oCnphazTu/tgHra2DcG5wc4j78zc6WJQ2ssalxHq77NT52HzOIuI98Yal55Cnzcdb1uZTPTDy+OKVSB0I2Pvp+OLzcU/+OqUEKu/PQBc2FMqgrGH3a17VmK3nUWf2J6nqt3hkDalq0puBTL73OzuWmlYgrklxvw2chKWQDt/lb5RPis0tM1UD2EL+PeJ5hTmQ1VBnrbjA1T7TnD9lSZN0AmeyLuBJnVHCQMqRQDBjupZ0AwAfTr4q1pqrR25LOYFD3LA711DMjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCgMbF7x2UBpOxgDMd1b2b4SxJz7gCANr+Q4cTmNWOM=;
 b=OYnRCweQZX8DbnYCjWEUN/meQgyOZI8VORRTUUSkzGkyna6bSblsGgf/HsZUgnOTuRzIMp440+aM2OunClRsCbgrXX/HasAcK6/XRGC72fbqu0loNs96BdlX2Cm38JrNggQMnx6SMFINlBK+KaM0PoccSkUoJfJS8AMCqLyU5SyXUkKrAA2fOHlErz1KFcgcU1paZVyE379StsKYPOrri+ILJGN0OpmRM4/fdAoLB8WQ3XYMWMOc6+ryo6fLsjVRtO+V+RktnOk5uqpQLVj/S14pbTyXcE+7of2USq6Y1o7YDmkl2iExoH7HgXT3SVSUNFrZ7rZ/xBj3sxo+ln5s8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Fri, 10 Jan 2025 06:03:32 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:03:32 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH v6 26/26] Revert "LoongArch: Add ARCH_HAS_PTE_DEVMAP support"
Date: Fri, 10 Jan 2025 17:00:54 +1100
Message-ID: <8dbcf7eecf7d0aaa032df5cc62815269ddcf198e.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0075.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: e9455f33-2f6e-488f-f672-08dd313c830b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HZMaIfFZrz+inBpQytpPLK4CZ42j+6E1dkhkPF26PuKNkD2QgwjOMl7g3Sh7?=
 =?us-ascii?Q?4q7mUDKx/Q0mxn3AUUmTloQssXieNf2NQd6sLKgZO3YkMc4v5Qqz4UAS/dbO?=
 =?us-ascii?Q?XDIQZp3LPJ5bbsFAN7ktMv8+i1BOL9t7vtS9SiXfXxAts0kZwGDuT4wCjbKd?=
 =?us-ascii?Q?IOGZJO9K2FgQhuYbBAFgHm5Kntcs9TvUKEeTDJcjcHJL9+ZGDICY+ZtR/M3A?=
 =?us-ascii?Q?t1YbikMf8ApETlCviUfb2bZ2lLkredOhJFUVDSxWxiWcW8ijrmN5+8FRKwwn?=
 =?us-ascii?Q?3/mHHh3XqPcJtohXCGQoqbWwfzDlAPoFwR/7b5wGdRAaJ0mUinxMSVE/BPiE?=
 =?us-ascii?Q?Tbsnpjg8xuRDr2MNWuOnVLLxGGAXQDdgPQiDFz+Rmycj63Ihzf2+/lbvrkiH?=
 =?us-ascii?Q?Ogz8FADL+dzG/jYJ8D6zojq8UEAtAogTq6hg23gQdNQviBdPDLxt4dIqptEm?=
 =?us-ascii?Q?9Nl00yvOWlh3pwJijeBskjSnUh+kbnvMJKabX/yFaktWUlW6l4qZhjaD5yV8?=
 =?us-ascii?Q?hLeXA03kPBxh/hduj/AcO9c6bCRd8FmzpSivKdzQnT9Axnla4acIJUZZ7BNA?=
 =?us-ascii?Q?Gixoh+Tuc7975G8HL1jsuBH1/09MqPKQyF4BWe1DrHeVBM4+VGFP0J2ZBdSS?=
 =?us-ascii?Q?sv9b+uv2RzdSAjxU6rvsB/AF8rQW42Xpr88y8tLpyoOTj2pzqAZhtmlm2yEs?=
 =?us-ascii?Q?hXcfqppk82YZ1v2asBBMIiI8W7GvDrAu5LGy38i/LtSvV+hG3nGyltKeF8A3?=
 =?us-ascii?Q?PJEHiacdhNZVYHnXmPwBpmh63DWu7CyEQzftJH5Ntmhoc1n1E3uKEzd/fxND?=
 =?us-ascii?Q?s84wDpzLVgFYRhxUioZwZPNBm1Py8bFOdThFmxt2O9qXzkYgmbHevDcZ80S0?=
 =?us-ascii?Q?vwPXeN3nbfXfNOx0EBPO6jaoZZXDuoN6NrPkQFEkMPprQokq9vqlpZsaCBcw?=
 =?us-ascii?Q?y9QOBQ2Pc1CPvR3LMQMK8V81wno6ARr49/6yVHxPqOmKWmEl6fWsp4Xi9x5n?=
 =?us-ascii?Q?wplvRfOrHJ1yfRFgD6MSTXWLJCOb7YenDC5DsxcTLu5guwTWHu0AQHFWC5gM?=
 =?us-ascii?Q?3xlB3+UY575snHXXoMvK4ZF2PMjVEwTWzzyUEWaLgEYDOYteTGKUNoD5rZK7?=
 =?us-ascii?Q?xBxcwSFXUVgU5Ga5riABUHC0ROTmTrwPErVUqCzeRtvQOR0mkPcs8/nCI/81?=
 =?us-ascii?Q?v4UqSbj0GoOY3D61NZHcpyttk164LIaSVBnr2rB/UcInyl1nMboHsllLOWs7?=
 =?us-ascii?Q?IxVgsXLci1EocseMg2l8cngw6rUA5R2UeDcIyYx8mCRnh18e/XrdekiYrmQx?=
 =?us-ascii?Q?gkicTyR7En0dnNoT32hAzNVi5tsv6ZdmrdywToDrvBYAL74pnzRMpWfCkADN?=
 =?us-ascii?Q?S/zcotZUM/OKWLa386KMnmTKng82?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qwhOVcHQFD5C28eaM6HLxru/5MTVmEtsZ1ZU3ztIadeXuwm4GZwvmdwtZQBz?=
 =?us-ascii?Q?gD/ZSOzfUeIZ2KwYLt8h77QP+4n7pNrGy1DefR/jT4TZeGaebfVwSYw3RI3n?=
 =?us-ascii?Q?jIK4U6o+F6cEsZuqhG/+UkdmOlznhrT/FaO4Jw36pJmXepDaRwKUoJC6dy17?=
 =?us-ascii?Q?5OREDxMBTLKNPaAL+wwV7T7T5Xy11hMU9FaChlaR2OGGXgy6SFzj6eD7b3Cq?=
 =?us-ascii?Q?J5Kp5jq2nZ6NW6HfbV7gLfvJUZMm2RfZ7MlzUSLqXm4h4XPinoPGOxDN/blD?=
 =?us-ascii?Q?nOfuc3386fO2LhjxywKVZAozM0SQOUU6sxOENbNNZfcMP5BgYqRADuMmAv21?=
 =?us-ascii?Q?sSKxK4EglAOKhhWTclcGAYUP7wYTwJU9CfYL3Iu0CCnUkqSIrNOAMhXKe9dq?=
 =?us-ascii?Q?L17EzgEUdP8AIKFwpTiRJ9vInCzY4DfFs3t4FkFkZ4jObLwjmSslZHnLqhfu?=
 =?us-ascii?Q?COPL2Hfk1SRVcg4YN0xorVNCLFi5bAyt8DMm+gTPDgetIvN3gcq7SCj+hGYI?=
 =?us-ascii?Q?42X+7DrSAd2HPspyF2VUJS9NQQCSfs4jEGLasZrkDtkBJ20DI+DNjkxAIaVY?=
 =?us-ascii?Q?qJr3bBUE5S0/IQJpFiul5BggIKhk23t/wExsarq+c2ZSI8QCb3wrVVMNcT4+?=
 =?us-ascii?Q?x5bU9pi2RPU7UZ/lTts5xVgFKn+jrFxwr+BjRLfOQZtLbNwcS0Y0epR134c6?=
 =?us-ascii?Q?31diTzVfmPbiB4juEXoGTY4kYPot/NgpEZnouIz9FVvy6qM9hvrrKgBKq1x9?=
 =?us-ascii?Q?rzQF4+xR7tz3bx228YsY9HhtrGRXYyngICQM9MgGfo8JbyKq0pKWa61u4WeC?=
 =?us-ascii?Q?GIKgYmp7z3IRG+sSwskXTt4wvGfQ3sd/6eKCa8mM/orJ5mKEnOyu1VlReXqk?=
 =?us-ascii?Q?gmPJsFboeJ3f7Ao5+UV15z4mveImwgVc34vGs00OOlbyEkqtW1EqCfKjak5d?=
 =?us-ascii?Q?JrZ1/Tn/Db8tl9BZkhOlu9uZKDKKDmoOkO2yB7vtkIazXD3EASUlzZuvaCYG?=
 =?us-ascii?Q?lzDgKghBtban6Js3kA2jyh6142F3jozzpFDdCnJkTV31kbsiGW1alXFG4KDn?=
 =?us-ascii?Q?V72TynAVJN1ZqsirU9CbHLGGjB9OE06X3iKJZzT8NZtf5qslw/kPgJ3Vwj1T?=
 =?us-ascii?Q?F1sPwKe2CqsZ3F2DEVZiZkMrtD4SiYbjl6cGmHZlUG+uNS3Qct/Ps6q2i4WA?=
 =?us-ascii?Q?fQYI9wDWW4eewvdW4FcTYFYN8Yq3dtRvOFxq8RL0xX/4eCT5CbutwGACBak/?=
 =?us-ascii?Q?XZqyVfwqHEKMySrRROn0kYLc9/uOnJQl0E2DM2IsBZdLlE0sMvJXmJTb+HZd?=
 =?us-ascii?Q?xBrjKXdm9iyuxgOFXsy9JFk6x8f9OKfzvj/CmYtWIjFOCcswtkQ5opfbU3yt?=
 =?us-ascii?Q?ZpeLnU4UONd2YnaxKE8+0r7CQwLherb82xjO5cuWtFIdeDdKQ9cL6GgDhVH3?=
 =?us-ascii?Q?W89Hxpaf+YTqSnOHmpWZtOmE2FnkmHxHtAktZGdlWJ9M5KzRCjZikHgfi0WH?=
 =?us-ascii?Q?66+Xa9p/DCCExoFsCQizYEMogslaKD2Tr4k3lrW+gk78y1C1qnb1kRDGEeUP?=
 =?us-ascii?Q?0ODTWz4nVxmmScs0j7GQO1ipGGW5mRRjWbp66aaq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9455f33-2f6e-488f-f672-08dd313c830b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:03:32.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVUEqa3IwuoHR6886tgFc+Mr7PUWZ+Y1jyRqL20KEf4HRPgc+03/Zn4LJezJ+n1UNVNkXru86coBEYlAYSUlXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331

DEVMAP PTEs are no longer required to support ZONE_DEVICE so remove
them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 arch/loongarch/Kconfig                    |  1 -
 arch/loongarch/include/asm/pgtable-bits.h |  6 ++----
 arch/loongarch/include/asm/pgtable.h      | 19 -------------------
 3 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1c4d13a..b7fc27f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -25,7 +25,6 @@ config LOONGARCH
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PREEMPT_LAZY
-	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index 82cd3a9..21319c1 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -22,7 +22,6 @@
 #define	_PAGE_PFN_SHIFT		12
 #define	_PAGE_SWP_EXCLUSIVE_SHIFT 23
 #define	_PAGE_PFN_END_SHIFT	48
-#define	_PAGE_DEVMAP_SHIFT	59
 #define	_PAGE_PRESENT_INVALID_SHIFT 60
 #define	_PAGE_NO_READ_SHIFT	61
 #define	_PAGE_NO_EXEC_SHIFT	62
@@ -36,7 +35,6 @@
 #define _PAGE_MODIFIED		(_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
 #define _PAGE_PROTNONE		(_ULCAST_(1) << _PAGE_PROTNONE_SHIFT)
 #define _PAGE_SPECIAL		(_ULCAST_(1) << _PAGE_SPECIAL_SHIFT)
-#define _PAGE_DEVMAP		(_ULCAST_(1) << _PAGE_DEVMAP_SHIFT)
 
 /* We borrow bit 23 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	(_ULCAST_(1) << _PAGE_SWP_EXCLUSIVE_SHIFT)
@@ -76,8 +74,8 @@
 #define __READABLE	(_PAGE_VALID)
 #define __WRITEABLE	(_PAGE_DIRTY | _PAGE_WRITE)
 
-#define _PAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PAGE_DEVMAP | _PFN_MASK | _CACHE_MASK | _PAGE_PLV)
-#define _HPAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PAGE_DEVMAP | _PFN_MASK | _CACHE_MASK | _PAGE_PLV | _PAGE_HUGE)
+#define _PAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PFN_MASK | _CACHE_MASK | _PAGE_PLV)
+#define _HPAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PFN_MASK | _CACHE_MASK | _PAGE_PLV | _PAGE_HUGE)
 
 #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_NO_READ | \
 				 _PAGE_USER | _CACHE_CC)
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index da34673..d83b14b 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -410,9 +410,6 @@ static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; 
 static inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |= _PAGE_SPECIAL; return pte; }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
-static inline int pte_devmap(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DEVMAP); }
-static inline pte_t pte_mkdevmap(pte_t pte)	{ pte_val(pte) |= _PAGE_DEVMAP; return pte; }
-
 #define pte_accessible pte_accessible
 static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
 {
@@ -547,17 +544,6 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pmd;
 }
 
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_DEVMAP);
-}
-
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	pmd_val(pmd) |= _PAGE_DEVMAP;
-	return pmd;
-}
-
 static inline struct page *pmd_page(pmd_t pmd)
 {
 	if (pmd_trans_huge(pmd))
@@ -613,11 +599,6 @@ static inline long pmd_protnone(pmd_t pmd)
 #define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
 #define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pud_devmap(pud)		(0)
-#define pgd_devmap(pgd)		(0)
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing
  * constraints placed on us by the cache architecture.
-- 
git-series 0.9.1

