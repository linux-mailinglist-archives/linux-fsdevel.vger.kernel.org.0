Return-Path: <linux-fsdevel+bounces-51734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C34ADAF82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD17E173D8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C552F365A;
	Mon, 16 Jun 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s9Gb9dkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116A2F2C68;
	Mon, 16 Jun 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075141; cv=fail; b=NAbMn+K1Tc52mbLfAJ4ZV8LPj/OGyhbyc8t/k2vEEq8DV5Jtrx7SUMRoL7PS5q1+5/Lw9ILcvRi7RCoRwASTi32A2w3TK3zyxvo3YUJcuA6rf/ugNOLl7XYQI+ux064MvOkmTASZYmI+0t2D2sQPCgizzcjy/M7NtazWUEIRG14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075141; c=relaxed/simple;
	bh=SDci8d8VVPmBlvujgQ3VllzHIY8cS25SuLgH3bQPsgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m80fYAh0LI5NCjuyS7COw7eEe/2YJuqqbFXUrDnyXi/C7m1hN0LeJW2tTT36oZguBYprCg4h52UQTMAMI475kkM0nMl8GZHgEQHtkDvsYtWahSjZwKiJQgOQbXvdNRdw+3QIeMbGoXVmvfTNl6E81CfJw+AL1w8sLL+atc0lV3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s9Gb9dkY; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR1/BK3tts0uJU5DvOs9LDw1tZBYpyeAhMSM7Ecbj7Cxknbhqv9Mry/5YcElHjVCUizBE5NeH9A7CxZ7hGQ9Fbq3Jxenn6MFhw9vBv4L5dzYhmIFUmhX7FNb37t6AnX1uNeGsoK6v8lgDh2OqQTjQQF/Zb7055vIgTjxK8Ag9nkcOcraWxs0Kl3zXC/L8mfAC/Xl9AbD4JOxa68AEiSkbVllNcfaXXj5C9xGtv5hpc8o71lJWTeoDy850EsN1biflpHOQ/PYCDpbI1euXcEX9Q7u419/zGNspHyjl4lGuRODSmgKCIGQcOqObfkPJMG+y673TnYDSU/S04FNok/bag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PToyrEJz5f7HbVv4aY9rivuVlgIU5ysxttgCwGWMy5w=;
 b=aSQqQ747O2RolNezh+bVBsZnI1R5QJRKJYBhrwy4p3a9bcWkf6WDWk6D+7nW2Q7sOB+kEXBuI5hMrFa4Elarl0bTqs0+XFr2bhGKduEZud1utYevGnBZiUzvSXBQU5nde85da8p52hQ8zF77Ps+NoewrWV31Wpubj056LNuThvyFrzIH61TfY8JlTt/Vx7B1R0Ygq2INVK0QHK9gg7+PfzOlM2IYiG4eDveV7GhJoPt9MoNYSshowJyRqznb9fqbHnc/hMADV7T5fCC2L7g20en8Z6uRHm6T77niZ6NkJAmfGyn5VFPdp2QAH9GMuAwfiZtOWA27G9rwrmxoEjVsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PToyrEJz5f7HbVv4aY9rivuVlgIU5ysxttgCwGWMy5w=;
 b=s9Gb9dkY7bI4k8zXQhD8BBcSL5KFsC4JJ87DK6R4IRctJzfttPCYJZRSmiwdcYgsbWgnHphd8AoNLEgN2OxSDOl/wpzfJD2GNNBhq+v0vXYvw1jWX3UFGt3iKzEQ0xXnTFzEAsHMl2+6jEFlnlQ/jOx8vh12C3lYcaFjMMSqbQrwHgPZqxK+Y4LsgyDUCk+3dgTJsvD8ynaJswF8d+X1VCyfC6bJBOP5WrpWNLzi0X+k91pc3lrgEck3u469swZJKr0hWowAahuIqyrl4t03Zfx/FdxzoIFd7qfDrpWmvdy9Xjnnjn458eX2oWFIOzwtyb2Vth/F5gO90vyva7dvvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:58:56 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:58:56 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
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
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 04/14] mm: Remove remaining uses of PFN_DEV
Date: Mon, 16 Jun 2025 21:58:06 +1000
Message-ID: <059a2e87240d7bb00016155ef5426c08977759e0.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0028.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::14) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 3795b7e7-8bea-4ccd-58f9-08ddaccd2bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yjD8cQxsmqKlvdEX5QPVZ50sEXAxaOrxijY2hS+8IvWZeZK2uhRWZvvwQTt8?=
 =?us-ascii?Q?RA/B1KQ4iURHA/4vSpnXqiSM4we3ItlTMlzuu8NgTkcZaLJhrH8KjTdPo/m2?=
 =?us-ascii?Q?fNvehic4UgeDAwUlzLYVILwpc13rYNQmPRi6+DNNfryHk+cRE8L4S/kVj34+?=
 =?us-ascii?Q?L24rzygV72oA6v05HwVYB8YFDaK8md5NvlIJNLHSyfnGZW6I1urT/6l4DDMG?=
 =?us-ascii?Q?WjfwyLPMYnBtifhdC8M9A5lgifOSXGsmFoHxxyuGeb1XeBjPAAiEkNfbaPRT?=
 =?us-ascii?Q?pi8BDTjxMsCTZTn1ORspVoeVNQ9AVE3Pma50mYc4USsISBJDJV3vlXOlBYPK?=
 =?us-ascii?Q?OF4Usc8rweV6nHeRwiRm3SCK84yYds5sAdpb2rUE80jq6YpFjyp85NhFg71C?=
 =?us-ascii?Q?2ZWQNlVdDFbi29kZlS1g+IXeYi7PDxieiktZchdlD//dYLCxoK5IeDQOGBFm?=
 =?us-ascii?Q?e+GN/UUUktVrrifR33R8MfuPJI58bxlG+iz2S7Hwpk3GiAxuOapWjFnMQ3ih?=
 =?us-ascii?Q?egChvAFGpMiX1fb7GxH0MPuX67T7s0MiwPlxL2zyJi8KsFu+KHLxR2efhSEg?=
 =?us-ascii?Q?qEc/a4GjM8CIukyL8gmEPkTWi+AmsLl10WSCak7/ARSZJt/v3eWPgOMcLBVA?=
 =?us-ascii?Q?dZ2EWa8F4URTTkt27+Be9bNSebPKpkEo6y69QWTZk7Jbl502UxpczgDPYXHL?=
 =?us-ascii?Q?egu/W4VOn+9gTsZ76lb8ZKQwFaXNoyj7Us5Tu04+BqyA746RwKEzcN6cpPmK?=
 =?us-ascii?Q?dwms4TgvzV0V+OSL1TNUGHRLjj4Im8zD+BfGxdgPvsZYh9dXCMllTNvw1X+3?=
 =?us-ascii?Q?/XXB29jEbU5d217yICUTSP+v4PBuh+3HCVt2m/tUsi2G7QH1R5zjpT2mEEd0?=
 =?us-ascii?Q?3BON6UCp1z/a+R668PuRA4sKwwL16VFlb1o0G+1kCUwBhx7SRhdmbck9UAvf?=
 =?us-ascii?Q?w/5gKb95zGCfIvuVnvXbayZHvby0YMwIdMDoRWA1suf7b4A8IJPzfUeeGCRW?=
 =?us-ascii?Q?K80dbx3RRC6uX5taqY/nY7hDwzSvxSgIPMkdUo3eScOZLXq9x/m7oNvjQAjG?=
 =?us-ascii?Q?1NxwnY+Gxdvr8CFcDGlDSpN2Iw0NHzypn2hm6aAqInuuYqaE+3tI1ZIYv4Ue?=
 =?us-ascii?Q?IezWzPB7RTXzVbx9Wm9X9HcdviYkHeD/ZFBIxgmgoOfcCoXF15Hwsh5klyQ1?=
 =?us-ascii?Q?noO950X+8umqqzBfwIez163p9LfOplZBAHLZuBIdD4eLsEb+QqCunMMqw3kx?=
 =?us-ascii?Q?N0v9aHNu0imJS7ZrqGJzUm24SbaVvyWx2VXDumUEinzrsHNCEjl/FkqgvX+s?=
 =?us-ascii?Q?GoO5v0p49hU5s+YLWNJ9uRjal8sHB+zzicZpTp0eqJkKmO2fDhoCJc4nZBpG?=
 =?us-ascii?Q?OYyFhOy1u7fGZYwBI2HEOQ8vikK8AzLKvwafSh7CBkG7CIdYf4mZkGecGqHT?=
 =?us-ascii?Q?RzSlV4ohIzY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVXr8fqisTRNXUdcNlHdQtKO5iYVcPSvP/NB0nJgz8i/VMRyGz8OvkgoMBKA?=
 =?us-ascii?Q?GnQxCkWS49sXI+ek5CoqHmVAci4HscBgHZDubv7NaQjuoWfGJHM+usLWwhTT?=
 =?us-ascii?Q?GulaX4PzzCBmJoovTXKolDiZJtJ+K7Wtetffo7eh2gHuUcc20bpJSx5dH7qO?=
 =?us-ascii?Q?jVsUSQjnrIekN8J1l4Gf7EUuWSAm4D80Z4D2JqZrsEI6Y1xoHoFHx73fkJk2?=
 =?us-ascii?Q?earadOsKvpkbYzxcayjDLZ6KxTX5+hWGzDBxE1Dd0swAT59+JHwkAS+HCerM?=
 =?us-ascii?Q?l8SbT83z9HTn5Am/RpMPIg7KmWjCpLseIg1w77fXsKgkbsSCxPVeHUD+QzCO?=
 =?us-ascii?Q?CN7S5c84xkMX/v1OkpCQe9HciCmqDGU+Wb28gSZHwLRtdeL6/17b4Lw+maKA?=
 =?us-ascii?Q?DFXfJQJObJTBYIsFtqKmOkFqkK2o9GGtLQAuYAQ1c3ospr+bnnO+qUtaeLeZ?=
 =?us-ascii?Q?Ja6rzzrlXTB99OrczF+Xv1G/gOLFjGXSMRTQXlArTsUgJk/fCrF0JKaR8jrl?=
 =?us-ascii?Q?iW/sjUWLB0//M/ZkkuQOHMkCX7C5FQMuN9JNJ/QEciXoXlU3kDb6Vm8/F8Gj?=
 =?us-ascii?Q?CFdb9yv9h2cZcfRWCVsPfaK2yGxt9u1p5ShzBTg2BP22oTk9uSeEENRwVfyM?=
 =?us-ascii?Q?czLmjuXqp0cOoqEAKdtzyPVAn1QdGbBzuEx1P6uRDW+QCOQyjulHgxhbkOTd?=
 =?us-ascii?Q?RKdLwTNEM0RpxmE+gcC1mQOj03doLMgIQ2Risy4g17OzbiGsJ2tigsQZmVPY?=
 =?us-ascii?Q?Kf2wT35cS3xQvTRvtnXcp+vhslrSq5j52tAOyi6zZKW6ieoSXFzthU2+iN2h?=
 =?us-ascii?Q?oA20Ldl3dhbDliwlv9WhI5bsMQAlg/IXZdZTXinBQvrH6H7PCElkiEysx7UU?=
 =?us-ascii?Q?8thOcYPzELVzUVAdK2zRnUF9a1l7om/K4QsRMQqxRLmfZh1iEPU7KGs6Y74F?=
 =?us-ascii?Q?tHh7OBRqdKhZmFXvDG7gv2UmYEUnhJjGmHLHRKdGd861VDV4wA7bOB80RrSn?=
 =?us-ascii?Q?9bD8VB7V+KVa+eZcj5Rb6JI75e/6M/JXYeDVbWwK46dPkBvp8dPXmFFnGMet?=
 =?us-ascii?Q?OKKw3HZooRZF4CBxiP7JEg6KxXb8RnQ2w7yZwOg92WTxZm9oPifz43d8MLYS?=
 =?us-ascii?Q?abGnjHxXwIZ2X1nOTL5Hxsvee23HIVfiwu0pU1A4O3opXqmRYabbj9FlUwkU?=
 =?us-ascii?Q?GuldBDhyasDXfSEZ/6XjbiW3MAss6kfgpCZ2fj7KiZIX1jDQeEKw+0gtyzjW?=
 =?us-ascii?Q?0Ya9Q61xROQbY6H+ji+cvIG7u4XstqYrIMQ8i4lXIhgavyNMu5I1Do+hrE3D?=
 =?us-ascii?Q?pXEjuOMzRcU5KN4yRWmNJRan3T8W8V57Yc+7r3/Cf48QRQuQljXxFO4WgjpD?=
 =?us-ascii?Q?BjCkHF41ZrL7yegwvUCIoYwVThwwEliOwP/yqdQZFLraK9KQUPjDQcmz6NyB?=
 =?us-ascii?Q?iBZA1/+MS2FPPh7smrZU0kRPBlL4XDWjDePZPpg59mf8jDQMZpqyTYgCy1ek?=
 =?us-ascii?Q?+Suqp/PJTPcFVtHS2GJb9bsTclcNYHqoROU8KF+jV9DqjRN1luLgY01eHw0f?=
 =?us-ascii?Q?oiuiT15uEPVoSm7JvoVqFBzA7U8KEEBzdMW7DfRB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3795b7e7-8bea-4ccd-58f9-08ddaccd2bdc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:58:56.4380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl7gFntxJNRK3lOP20XtvoGg/Au/MSaczPcZZyFfJnsht5VRjpRgV6Aim889e/XYsdaD0vazShfb3O4Wi9Yoow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

PFN_DEV was used by callers of dax_direct_access() to figure out if the
returned PFN is associated with a page using pfn_t_has_page() or
not. However all DAX PFNs now require an assoicated ZONE_DEVICE page so can
assume a page exists.

Other users of PFN_DEV were setting it before calling
vmf_insert_mixed(). This is unnecessary as it is no longer checked, instead
relying on pfn_valid() to determine if there is an associated page or not.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes since v1:

 - Removed usage of pfn_t_devmap() that was removed later in the series
   to maintain bisectability as pointed out by Jonathan Cameron.

 - Rebased on David's cleanup[1]

[1] https://lore.kernel.org/linux-mm/20250611120654.545963-1-david@redhat.com/
---
 drivers/gpu/drm/gma500/fbdev.c     | 2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c | 5 ++---
 drivers/s390/block/dcssblk.c       | 3 +--
 drivers/vfio/pci/vfio_pci_core.c   | 6 ++----
 fs/cramfs/inode.c                  | 2 +-
 include/linux/pfn_t.h              | 7 ++-----
 mm/memory.c                        | 2 +-
 7 files changed, 10 insertions(+), 17 deletions(-)

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
index cdc7b2f..249ae40 100644
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
index 6328c3a..3f2ad5f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1669,14 +1669,12 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
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
index 2d91482..2b0d6e0 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -7,7 +7,6 @@
  * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
  * PFN_SG_CHAIN - pfn is a pointer to the next scatterlist entry
  * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
- * PFN_DEV - pfn is not covered by system memmap by default
  * PFN_MAP - pfn has a dynamic page mapping established by a device driver
  * PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
  *		 get_user_pages
@@ -15,7 +14,6 @@
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
 #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
 #define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
-#define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
 #define PFN_MAP (1ULL << (BITS_PER_LONG_LONG - 4))
 #define PFN_SPECIAL (1ULL << (BITS_PER_LONG_LONG - 5))
 
@@ -23,7 +21,6 @@
 	{ PFN_SPECIAL,	"SPECIAL" }, \
 	{ PFN_SG_CHAIN,	"SG_CHAIN" }, \
 	{ PFN_SG_LAST,	"SG_LAST" }, \
-	{ PFN_DEV,	"DEV" }, \
 	{ PFN_MAP,	"MAP" }
 
 static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
@@ -46,7 +43,7 @@ static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
 
 static inline bool pfn_t_has_page(pfn_t pfn)
 {
-	return (pfn.val & PFN_MAP) == PFN_MAP || (pfn.val & PFN_DEV) == 0;
+	return (pfn.val & PFN_MAP) == PFN_MAP;
 }
 
 static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
@@ -100,7 +97,7 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
 #ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
 static inline bool pfn_t_devmap(pfn_t pfn)
 {
-	const u64 flags = PFN_DEV|PFN_MAP;
+	const u64 flags = PFN_MAP;
 
 	return (pfn.val & flags) == flags;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 2c6eda1..97aaad9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2544,7 +2544,7 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
+	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, 0), pgprot,
 			false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
-- 
git-series 0.9.1

