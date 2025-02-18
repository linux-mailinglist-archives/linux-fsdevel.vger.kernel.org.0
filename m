Return-Path: <linux-fsdevel+bounces-41920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B724A391E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034063B47F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668E1D5CD3;
	Tue, 18 Feb 2025 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b+f2S53s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB791AF0CA;
	Tue, 18 Feb 2025 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851005; cv=fail; b=owUta6GhOJjNLUL1bc2pxMIn1bN8hrMdzYeonqDxk6X02SBm9jEf0JDZ8ILt0aSMqoHiUgGbaHUqTuVt3n3Rp0dYItQ1TUCW0VEfS/FU4LdBGhEP8Nkw4EskUQJZY6BkpIK2bTCY54mCFuLOlG1XrvHyvHPtNdcjdCDsHyiAcH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851005; c=relaxed/simple;
	bh=9TEromW9vRZnFHDpv9LHTGNUInQH+fMiZA6oXda1IrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TnmkejQObqhwPP6Q0lYv5lZh3iATHXOf9fCB8jeXgXyokVjxQh2N7Qxl2mJMVzoCS0OJEk9SkJfh+5yMJL5LTHmk9mzXAmjhY2S0UMjLOkLH8jD2VzUphjj96dbH4MFxmZX5PQWBYxUK+mxoYu4xFjhv2ZmpRaQ7PKdrU/7o5pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b+f2S53s; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQkoR9fqCOGDQ+eg/1QtufCLKx3gOYOf6e7Y5kLIUZOMAR2KqWjtfRnUiuOGpZMOlNPEGM6zRQmiaa5/Xl4kvcC/IysIMLkDmMmuhRWYRgSSPl5NDtNBYrcU92lwXJr3HjyKWPZdFqU3hUHwlRjmnYV57VoyRAFFrn7fhhAAhZjHiEpRa58CqzM28F9Xgm0dx6H2nyHpao1s15fZvqGUKoIT7/X2IlpjIqQgb8PBh3oXPNQ1GVMjRSiINzj8JeZ6XzXkGx5Km/p/dWP+jtS6g7LXb2ifIVAlwh+NNb2zkVE30JfbWBAH4fHwxpbLBR2HdZ2yNkM0WJv/R0MtUTUcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz0xPUgxEv2VmYCP8Dm5xz29OCp4yeM8XyN0+NmpTis=;
 b=rTzfMXlIvkOrpjo/AifmiG9XmFNEESY5LH79btrm7Z0jLTJPGQb5ieht8qGSfyDqKIAzKq+flI5CWOGl/yTph/BX8Pg7apJP9XRfb9SZNcEj+3fPlVXLMjzkuLBo9Hq5ze3YHGAbLwJAvQMFR6EkmrjnZTJv6h0rtAcoMHe8QSQmLVs2BH/6OM1jmy/39c9U8t478SOHi4RM5Un/nbYMI+L7LytVUtx8fBeEcvg+hVGhwHeSGfKdnuRnA9TyycHcWtTIdB5A74+dmOffxoz0cI9+huGUQiwsf4G1xL0hymYaIhggxIuWfxUf82FXePqhKxT8DUKi8f5mwfY7qXdKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz0xPUgxEv2VmYCP8Dm5xz29OCp4yeM8XyN0+NmpTis=;
 b=b+f2S53sjCiTkP90vTiTezHxbHHqXP6U2RIHTRHWW7kfqyaK9MX7mx50Dre/B6oFpAv4Rc4UPmH6gyPs59/Ud3vLfKE/V5dK5sVPKQbmH2/94qAlZP6TTnScdyOZVJ3TZFdbY9LKM44oNb4yYwFO2DQoaOpFi8p0CtfgWSOApmknwGt97kA4tjV/CKwsWKDAy3qBLWm3shJwMJFOZe5z2kvdxTbmjwhl74eRKDEs9/TRWHE7721rejw+e2NFDsCLkP/OQdG4qGtxuFf9f+YX4brNmwgZfdm9FXFDjj64kTKhovR6osrpXwgzWR/lLfPHb1j2IxsK9Q2JaNDnzxOgOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:56:41 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:56:41 +0000
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
Subject: [PATCH v8 10/20] mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
Date: Tue, 18 Feb 2025 14:55:26 +1100
Message-ID: <6aedb0ac2886dcc4503cb705273db5b3863a0b66.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 58036606-32dd-4349-8024-08dd4fd040c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZUSRpZrMHJXpcKCKxnUkXpvPiR9m5Ni65qSRk6xRgs2bmVzC2D/vdhdVZ+9v?=
 =?us-ascii?Q?jOEMwh/9OoXVEGYzqT+OOxEUVXXjGo/DldSHnKSEo35T3r4wvNHnB9cJaPJG?=
 =?us-ascii?Q?XU9v/URzUCn/i3hYgrYrJUmMrRjaI5ppW5XX8Gp+Rx5h5JdGSrc2G3xd18NR?=
 =?us-ascii?Q?ctpqYN/3aeK+udWdqvhTbMDvwnVzXuVWusPIB7mADhT8TF5fiLKK93SkFFGR?=
 =?us-ascii?Q?KctZoXYsGbXp49DckuzA4/mw7xxgo6d0a2TuXdVAi1hDI8TQ5iK0QK+m8fsj?=
 =?us-ascii?Q?8dMi6drhwc8rzaKxKdX8qbCjBi6paEIDL/tC8oaUjtojx9w4LNU4AQVd5Ht4?=
 =?us-ascii?Q?jhpkU1ts95v7M5FzNpDlD/+apD8ZHQV0eAdmPYQz/g0RseWNJmcHmu2Gu6WL?=
 =?us-ascii?Q?Aj2xBGbsEhM4baV/bsMNdqlvJl9aGCrtkT8VvqjSGQSZQ8Xun7C4Coa4f1xm?=
 =?us-ascii?Q?GMra6HPHc4PYpYoDAHbm29xnrJPcSMP1L1smB1rifQSiP0SXIEr5R6rBfuPx?=
 =?us-ascii?Q?WJUqgKUX8Cci/XF7b5uCnCxagtqeSVCPkPfKPMJSpGmdb4VZ5nPrsVZxcIhW?=
 =?us-ascii?Q?njzoN0FfPiWwix2xS3dvUeyZPE+JiyJzapGNVwkjCSddmDQ00lRvb/h8H2+8?=
 =?us-ascii?Q?6jSbRenS2ZWuFUHydzcb81YAcywCUKKsa29zXI7FjEfQk9M/toV6wJ37e2XW?=
 =?us-ascii?Q?oDeEnj8kH2uahrTvzzBSdSFTiSB6QnflnI7rRav5an2CpKhKXi3RD1IeS+U7?=
 =?us-ascii?Q?4H239HP8zcKBcdb9xsvqLqsSuPR+6E3Ntzz6bXBp7OsVcTAIerFGxE2J/UlC?=
 =?us-ascii?Q?05gUv2cWwD3vx60nYwRWxLE6rJetNbwaQi4EJdrCbZ4mirOwDhvg+oaN+z2P?=
 =?us-ascii?Q?IKKg7d8bLp58bSyCXW0cpBM4Kajxg80moDf4/ysQXrfGKaJ274admK3Dwgj4?=
 =?us-ascii?Q?mZKDUR070uORfYQ71oHUSty8vT9DWc31ETetdNYvxVswmYoZoOomHjbL454g?=
 =?us-ascii?Q?NDuUX48BfkThvTL7h2IeZpDDakolGBrHIhEqNKv4P+RcWzCbKicrqyExP1pn?=
 =?us-ascii?Q?SZaXmsheW7pE6FLLKTwnJCaqogcftvBeYoVNn90pKdxOz37nS40QyqPHU5/O?=
 =?us-ascii?Q?f+kf99hlaGODhtpT+qrjcDrRxd6kHT6Wxvtv0UgymeFZnq1NDbgxRqXIwnfP?=
 =?us-ascii?Q?zBG6pUopD9vnfhTc7u20794oN9/FjN3tnVpg2qKbUkJqms4cGlLSFLUchCri?=
 =?us-ascii?Q?0IyW7v9/N7+avsBy/drtypIxxIn7Z9jEk9avQYLpiLgq9hvZgWVeH48N2Y6F?=
 =?us-ascii?Q?hb+3bwx1GATCZG61EzvKv4Nly3WnI8lIxTN/JykKWYkMnl6AwiHOe7iGpFPw?=
 =?us-ascii?Q?37Y3sOIxQJgG45g/Y1yAEZgtKCSF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CV6/4yN/eCwX5LVEkCyGBJeTVwQ2H72ELqor8w/LTYqEgoPfLHkNvrhysaVw?=
 =?us-ascii?Q?mgaZVbOq4rHb5hxaGKfFUe/FubTS6jXTr0BOdUHnPnVzrbT4aAZ9vdx7m1iF?=
 =?us-ascii?Q?P7TTvUjRM8UwpdiLHCfCdoq54YjGdubLS1T2ajUJ9At1rZo1fC1rnEAvk/IU?=
 =?us-ascii?Q?7GbYHnqMhAExSKx0LdRYtH4o2udNNKI43NdSCw/0yrnaE+VQJAwSPh4A10Lw?=
 =?us-ascii?Q?1Lg4zRH1a/SENJKNSCciGnuvpCYcvK1msjWL3KGSN3JxcbkvU9h4DU3d1XHL?=
 =?us-ascii?Q?m2OBQraT8mohuVTuBeJ+3Mk4ttfdNfTyBm+cXckChR9JavuLtwvuf6FOUb7h?=
 =?us-ascii?Q?KpU1fS578y42R+6e+yHuSVPB9Jw8fF7uyOhAXGzEm8Xeq4rQK5JMlbtrx2Ur?=
 =?us-ascii?Q?MfP2REhjAMgijFYoONDP/Gh92xBwpdZmuLLZq6Np/iO1Jvn76tx0zyEnHpr9?=
 =?us-ascii?Q?Nq8sF9OfyM0uQNFNNKeJszBmI2RQHIq7NTxOL5GZaykRORakwzPqF/BuR/hD?=
 =?us-ascii?Q?2LC5Eem+i02Nb/rbIVALjBnql2oIcCbqaYwe7BiIXLhlqEodzjSQcm1EQ/Qi?=
 =?us-ascii?Q?BpZ5Qcn6z8X4W+qh63k4Va3LJK+QeEIF4pzdMV+KqxvjWeJ5FNGCKrB+Qkna?=
 =?us-ascii?Q?fzJgLwu9ob15/TN9jvBdYbiZHUTZaoxQ8i7mVpgM5fe6AV7P6yXWcGxYHn6G?=
 =?us-ascii?Q?GOfRCBzQ2547QO3jooAhO0sst0owZqRZodlo6hQYocDAr5eJnAycPqRhFWOe?=
 =?us-ascii?Q?8NlsMPc3Q9SApTnL/MGVcXrXmWBuPf/b0gJuFOBI2t27ClH5lx8G7vjq6q+w?=
 =?us-ascii?Q?WAmJSG+89q7oLAzOsHzwaL5gGdss8lOB2c9KhC1SK3ne8tru8XdbJ1gWYjnC?=
 =?us-ascii?Q?Gs9QL2mukLaKJ/KnWCBHlZPUumPr0zyExwJA2nLAaF1J3gzIXOTPQ+Ia1cgT?=
 =?us-ascii?Q?L3CVqEw9d1iMPyHC7Y7Uh45C6ZoXEo8l3aZyjN97b68imbpguPNrjiXjtl8U?=
 =?us-ascii?Q?Myg8aGgxxllNDPpdkIePR06XR/+eia3no9xVBfXYgbjHbABeZeOBTZNwFJhy?=
 =?us-ascii?Q?a48d/KN+XJnnLwOvsQ0/vaWioJGXd4ccSeSHF3SuecT8vIm683J6rsv+WjhQ?=
 =?us-ascii?Q?qEtQJpy8/MNIzYemSZj4nB91qX+/1Cv0NsQ/SyNFVt5DsEo48vtWBAOFh3sI?=
 =?us-ascii?Q?QU1As7nsHGjt9hM5eKs78aqhh99Cujt3ZVHgHQwdZsyiPzmKQK7F2iSE2oJG?=
 =?us-ascii?Q?R/tL27OmhClp95qy7iz3R47IWttiWxCJBRO6Xxdaj+Pkxq6HLp6JBcsL2qKC?=
 =?us-ascii?Q?DB8aXi/hJvmBIvGUQBbqro7qDglPxU8C7F/PSRbkHkOLiiwAbB+bkvXe2Gac?=
 =?us-ascii?Q?TTI/bz2WQC4YBExipHMTmY8eomXsLU32QjHF9i7QfKQ96iOcibBNgdlQN2zf?=
 =?us-ascii?Q?GkO7+IFYnjziTFtbdRlIM5RnNiZW96hmjKFnJCoZkj0SKRKXLSs7MqkBCAuT?=
 =?us-ascii?Q?N9PK7jTk4UNuBWMrYwjp9vnP88RIIUJ36JVTlzv6NZpdbwYJWidsdVqtqDG0?=
 =?us-ascii?Q?62PHFAezP6Rzub22OLsqx6sjnEzdNv6Dq8i/1jyT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58036606-32dd-4349-8024-08dd4fd040c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:56:41.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2jSvb8Zkm1I+EQ7ChdzK5WRwWkwbCRHM+D+SiJ1Hjlz8VNPqPXwkGN6krhTZWm1Uv9bed9gOcAstn+0ofV+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Currently ZONE_DEVICE page reference counts are initialised by core
memory management code in __init_zone_device_page() as part of the
memremap() call which driver modules make to obtain ZONE_DEVICE
pages. This initialises page refcounts to 1 before returning them to
the driver.

This was presumably done because it drivers had a reference of sorts
on the page. It also ensured the page could always be mapped with
vm_insert_page() for example and would never get freed (ie. have a
zero refcount), freeing drivers of manipulating page reference counts.

However it complicates figuring out whether or not a page is free from
the mm perspective because it is no longer possible to just look at
the refcount. Instead the page type must be known and if GUP is used a
secondary pgmap reference is also sometimes needed.

To simplify this it is desirable to remove the page reference count
for the driver, so core mm can just use the refcount without having to
account for page type or do other types of tracking. This is possible
because drivers can always assume the page is valid as core kernel
will never offline or remove the struct page.

This means it is now up to drivers to initialise the page refcount as
required. P2PDMA uses vm_insert_page() to map the page, and that
requires a non-zero reference count when initialising the page so set
that when the page is first mapped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes since v2:

 - Initialise the page refcount for all pages covered by the kaddr
---
 drivers/pci/p2pdma.c | 13 +++++++++++--
 mm/memremap.c        | 17 +++++++++++++----
 mm/mm_init.c         | 22 ++++++++++++++++++----
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0cb7e0a..04773a8 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -140,13 +140,22 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 	rcu_read_unlock();
 
 	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
-		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
+		struct page *page = virt_to_page(kaddr);
+
+		/*
+		 * Initialise the refcount for the freshly allocated page. As
+		 * we have just allocated the page no one else should be
+		 * using it.
+		 */
+		VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
+		set_page_count(page, 1);
+		ret = vm_insert_page(vma, vaddr, page);
 		if (ret) {
 			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
 			return ret;
 		}
 		percpu_ref_get(ref);
-		put_page(virt_to_page(kaddr));
+		put_page(page);
 		kaddr += PAGE_SIZE;
 		len -= PAGE_SIZE;
 	}
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547..07bbe0e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -488,15 +488,24 @@ void free_zone_device_folio(struct folio *folio)
 	folio->mapping = NULL;
 	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
 
-	if (folio->page.pgmap->type != MEMORY_DEVICE_PRIVATE &&
-	    folio->page.pgmap->type != MEMORY_DEVICE_COHERENT)
+	switch (folio->page.pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
 		folio_set_count(folio, 1);
-	else
-		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_PCI_P2PDMA:
+		break;
+	}
 }
 
 void zone_device_page_init(struct page *page)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c767946..6be9796 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1017,12 +1017,26 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages are released directly to the driver page allocator
-	 * which will set the page count to 1 when allocating the page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
+	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
+	 * allocator which will set the page count to 1 when allocating the
+	 * page.
+	 *
+	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
+	 * their refcount reset to one whenever they are freed (ie. after
+	 * their refcount drops to 0).
 	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_COHERENT)
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
+		break;
+	}
 }
 
 /*
-- 
git-series 0.9.1

