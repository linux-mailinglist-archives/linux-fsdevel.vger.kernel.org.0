Return-Path: <linux-fsdevel+bounces-52171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE3AE00AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745803B7D1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87993266563;
	Thu, 19 Jun 2025 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cFm3brsO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B591494A3;
	Thu, 19 Jun 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323506; cv=fail; b=L5ctOTn/k7HerrZiBSHmsM0ejryboKlZ/5/I4H/AxXyLFOC96f1MHoOEbyt4v3UwEJajnDdL/c4y8JoNmtHne9uGD+JcqlO2SqIva9mDNd65saJ8ffjq1sQ4+WwsqnGhkuhFkmgGxxhKs0g/tHHXRzC8CkxvBCzQ4Ttjrc/NZKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323506; c=relaxed/simple;
	bh=bzH9S+rbaYCIXbrc2d6D0tfQ1lm4egnBDOrhUWpPMAU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FZYk6+N8kzBPA6C1Ep9stAlQXOBITOiIOJI6XKw3z8OvoGmwUYY0GQYduNJjVPD6++ijkNK8kiWqnIBAbbP759tRh3BFNHWJtH73xqo65/FiJTyRvCoMGBIZ6L5+Y7R0SwCIxeDSKqENzebnymJ1AP1hI/o1gIWkFQxlfWgksnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cFm3brsO; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC/lfeNr9mhS8hPbBI6YEZAkJYrV147QxI/m98uwTgK5231EHaW3sRGivn/BB1CXAdU/Au3/+3cRnF4kl7mmhNL0qusDj9ALv4RvDkGrneDwfpmjYZTmD9NPrtdpuXc5ndLsF5YqegPWZ3eVyJhQ5Q9b3q7hPZ8k3Ra0yU4Y+RDAgIz1Etuo5q3vgXsCzRzOQzTip/qbwPv7ie+oWMnM0Gru/93BNSQ2u0qfSCWv2i2N2aDFMa0k2EKuwo7DYZZvS109JDxIpX28LwLW14BCUFsXN1+aTdWAEw/vaRLPDhgLMExNlcEIk8lDSSGirVHZsCQI5wPvMIMKyMbQR+UKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehHSUH0k0nOXkAjiMBZeP2x96QtUWsagF5CVEhlaLHU=;
 b=gZ9E1xmyLP4cLTMMvHPpf4l7L2FiO+CWhjgqpvOow9lvZ0tNknzjZ15MzbftpFKCAxeikR94omDuONUtiMrEo7JDIp/GMGgW9oFcGfezwA4m96ZNg+Zi/+l6nGF0kD2JayajqbOdOKvNAuLl+q2js1T3tFwfYadaw3pNmqtz6mPWeQQayoDetJ0vVsgYDJST/Wh65oHn+pNlI8Xoim6pm6mDXaf0YrMxf5KKBwRhU+JVDekCwIeCzSBNnQuLQqshNWJTSTLhiVBRNrtw85QsIQqI7txy7emWxfvkILZFs6ri5RxVk80/7EJoC4uFvhb64bu349mEkbmEBDCnqon8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehHSUH0k0nOXkAjiMBZeP2x96QtUWsagF5CVEhlaLHU=;
 b=cFm3brsO1Y8xD6CnkVQzVg6sqUYx3WKvV7pGX4olcd3rbb+4UHiXAUzuFs+f1K8ws9dxU/DBCgFyG6zHJ5pwPi9KiS5UBBTd8iY8ZfYW3KwT6JX6Pfp8rBygznubtUFtm3ggT746Bg2FwYeFMzN6D1Q7QKjt4GQ1bB/PimXU+VrTL76pAfO1f35csrX62SdcAE77q7NJT0OS8Wb7kklNi/FGxvZFtgNc+p4T2amb0N8l6utlJC5eG1R/pYyipwaAQEPVdZePW4P7pRoYitv4h5s04p7jkclSNae/pxtI29Vst3Az6/QmSOJkSYugrkvye7aLTzbWYoTJB/pdZiSQ6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:58:20 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:58:20 +0000
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
	m.szyprowski@samsung.com
Subject: [PATCH v3 00/14] mm: Remove pXX_devmap page table bit and pfn_t type
Date: Thu, 19 Jun 2025 18:57:52 +1000
Message-ID: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0088.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::16) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: b3238171-a4cc-4aac-1240-08ddaf0f7043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DclWk3yMAG/KXJnsqL7FIW072e8FnC9YiQJOPGy3JD05ciVPa1+/OH9Umboh?=
 =?us-ascii?Q?OatoQd/xvxAv1lCFR6p5TQJvefwrLtI8olUDX+cvJpYLCp6M3wAhgmyETD0B?=
 =?us-ascii?Q?TFL4XFW1nXBkjGupXc7JS1QaaQzbWbhbXulNipfdRCg06nTPImgBNLE8/1ez?=
 =?us-ascii?Q?dRInUPAAmEidnsIkc4AB05y3gWn0eAiFPtC5XKaFiyCgOwFcttjbqackawGs?=
 =?us-ascii?Q?SiiWrPW6himpTS5Inkh1ZyTqf3dzrF10pEHEhh7NKrg27qpUhZk9x7OVhLHL?=
 =?us-ascii?Q?AN5p7SBAupS39tqx4COmJjuODgadc9ueZ5HoaX+mTknF1chjx4r5hE58ZrTB?=
 =?us-ascii?Q?KIDO/GmkDdmv4c0DmbsmFeNkR+1jgFjdRnhpMsmAIfDDUrYgcOVn7qVgloNV?=
 =?us-ascii?Q?F1DIT9HJihRZM7yvXQWSrTaU+04ZgM0Hp17unIf8rdiPILUVqLd506u29IB9?=
 =?us-ascii?Q?J7byDZXRLGaQYitB07fzt4FtNXg4B8uD/3l4dKK/ex6QjIKk+N1YKGo9SjHQ?=
 =?us-ascii?Q?Q1t3V7MtRKvdi5FpG2pGtHLz12Uo7Q0PKeLUQoBoqYHKkLvQypYFlaQNI2c3?=
 =?us-ascii?Q?SQDwxIX17fHy+8IB3SKlk8F9deLRvQybuU2GEAFsmXbWBDnBLhziHBvVb8yQ?=
 =?us-ascii?Q?MT1oN9gmC+kZMveMw/U0pFpGcLst/7BsX1ruU7ZXyXtUCWRuP7bi2pidXwB0?=
 =?us-ascii?Q?o3/06L+/CEbPvCE2eVwGFaKSzJPAXcPaSJt3LZzUBNIJoBa2tIeu3W3eMByn?=
 =?us-ascii?Q?6p+XWp7TQOIqOldwOAdgCtJvJ+sJosoJthzuDnfn61CTD9wq1mtpvdANJOkg?=
 =?us-ascii?Q?MqQNFXi4o9+4Cl+6vskb2bevyzgIFClsQriRxbRfueeHT/RzsW+ytpWr3tXt?=
 =?us-ascii?Q?PxvO/e4p/rb6jwr9F4pvkQkSiKAGI6kwgGHt+9IJ6BlVrZTLwsXqlm6KVIdn?=
 =?us-ascii?Q?OWS0gx71bmsPegbWDrHaNl2+REUMPNuRMyX63qOOHwrDTtJdjuVYpVHQt3/E?=
 =?us-ascii?Q?i0gCdaDIWijpWlHPGOsaQk0iETaV7qxmZCKEJSslu2KX+dlziswCD0UVUuFZ?=
 =?us-ascii?Q?LhzN2f0DIRjayT5rUNzs2C18DDyvdgzHb/rgu+h0c00aAo/rq+5WUg2EHree?=
 =?us-ascii?Q?6wV7ahzIAdzdPmbCiuUspE/UtKicTyWU4rUMqP8kvnbklIHjeMKlyBZ9V0Y6?=
 =?us-ascii?Q?pNQHGFY4+Q7hS+1PlVvVvASKXmbHFRmxeXUYyiPaB4mFnRX48vtfFJyn+5/0?=
 =?us-ascii?Q?R7TE7VNRJfyqQQRNj97EEGbcuzIyjvi42jZHqgtK7JjLigKn/9MZzkZP5mQn?=
 =?us-ascii?Q?DQbOyolDfVzj+37ViiOHxXNCs8xycAR5Vzk8ftEjrB/QRCzYIug+BMtNxq7p?=
 =?us-ascii?Q?NKrD0z2lhNFAj60/SiHEQj7Nt2PtNAJEHS7QnMpoYTnVRE+cMGoqJE+sF4GW?=
 =?us-ascii?Q?3lamti7uT4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fTXmmnWAqRUcX97n3oK1TnH/htjlYN3HtHo0x7QngE0491zi0EtIxMdAvPHt?=
 =?us-ascii?Q?N6agoge+rvnaxyNBctnmPaRUb/9JVCjAtPkfKinOaii7LIf7FSOgMwlqvSOi?=
 =?us-ascii?Q?R+89iv4MCd3oYugUi00Aax/1xPHbOk2Yw/EddwbxIB9S80fI5VTGjlTJI9a2?=
 =?us-ascii?Q?9Vp3xDzQ1nnkwk0EyoKAdlUB5XHB/1PMd91PXJVcsejXHCTQq7elCvhmkwZF?=
 =?us-ascii?Q?wSaiDplda7NusKVtoVCSUsd6ahReUtTNYtqLbjTUGlR79z9kFbnvQYxPcpXk?=
 =?us-ascii?Q?Lq7m++vtVGg3eq2d+z55PX1q2KOoSCMv19cZxhdW6P6LGvaGRrygCmcUj1+C?=
 =?us-ascii?Q?n2i/j8z3s9ksZN2ctdzA9e1khWlaen6VkdCY+jJ8CattlwtYsHz0yGE5ES5Q?=
 =?us-ascii?Q?izi8Hdt+lhGTzzgYcRnEb3T/uMs3qznSdZttR9YAzXAEnZcG5Wzkm3CbORk1?=
 =?us-ascii?Q?OD2LQl/lU9Ir5r5sRIna2QH+sTM1J6JAM5A6K8/Gow+xI1QURu1Sm8dX8dK2?=
 =?us-ascii?Q?Uj2XPHrCcEh2aHZKNFsL8atH1z35u2VmMaqcsHn8pdbzkJWktrbD+UvNY6dO?=
 =?us-ascii?Q?xuJQi4hy6BQAwSHp2+lq5iAFOZ5NrDz5ZyEJSOgD6axqJOIch/3UQiAi1DvX?=
 =?us-ascii?Q?vvUHG+RG9hSq1trM+t7Q8O5cIH6eC+ra6Kq57paCRrDYXdVg7A8nHV5Crakv?=
 =?us-ascii?Q?vccx854VmBq+9E4di/I3XucHSJtAnDvoihGs13ex/Y6XPV1agipt4uYt8tpI?=
 =?us-ascii?Q?v7ZyFLdYNPE1wr7TO7ByQ7bkwjlcSmIogl8QjuZFCkqZb+tc413VXzWuZMSd?=
 =?us-ascii?Q?UQnAtLIEWmYdJ4LGToALWpUUk7/yXJrlvoOBGkRcqkvO5odP+xsiGPyvoBvU?=
 =?us-ascii?Q?h7cU2+v+MFLRKr5DwWIIGK9bJqV5O7aDrrzw6HoCIBeFw8LbEXCgOK6Zq09S?=
 =?us-ascii?Q?xHQiyuwalY9XrFewNobj43hUmxOpv6TvXh1hIPQtJ+UWtuZD7Uz5SLFiRgvl?=
 =?us-ascii?Q?PrKGf+UZB7b3qs7BRLqT4ZdboaDSn1C03FfNwk0t1WvPvPL/ir60cU26Hd5f?=
 =?us-ascii?Q?7TzSouNV+n6+IFMrJ1p+eyYdHWM+rrZIUQZchiz095tBANskppl1wQUuMUTH?=
 =?us-ascii?Q?Va/pP7MxOUW3cqb6WZFpU7Z6SVC5y3vjf1en9J0AiNSLv9PSCmK05XBy8CRu?=
 =?us-ascii?Q?1eQxxsuEUIingkTOGrQ0n2SNrfsEmJkDTBti8lsqxdZBZfO+n8MY6CTFH52t?=
 =?us-ascii?Q?x9Hw+mgQIxF+72ncZJomuLIxMg9kIcNpEFgljUOWSkGCfHWmRJpRc8DmOKVN?=
 =?us-ascii?Q?fqqLTLjov58sQgt2kuPZ13JuBdS9/oVqB/Xzea3zyk37eVfBlE7psOIDBeHp?=
 =?us-ascii?Q?08K7hz/raOOjh9Sf5Qr4Nnfxnd6qpydvQ8UrNKbZlBUR2wbk25b5OSwvruB3?=
 =?us-ascii?Q?6V83VeUWRCX/6Hmy1BRz+9f4/m9e12Lbw2jEF/i42V+vzMt2GGTMzQ+oQ3H5?=
 =?us-ascii?Q?LxmBh3nX4UkqtO1tllTr0nysH50gZ062y7bnmJ27Vw5GfuGH0V6huD5s2WRU?=
 =?us-ascii?Q?F8W5dIMHjdEm93Ksl/6xqUIodDUPaoKQ7Mxtkvwi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3238171-a4cc-4aac-1240-08ddaf0f7043
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:58:20.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjYh0D8L4S2AJt3/lOp17I6mOkvuA9UYnmi/4io7M3eh7k5LkjK/zORUVOwiA0DauxgfxYX807/BpWU3Hw1KmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

Changes from v2:

 - Addressed minor comments from David (thanks!).

 - Reordered removal of the devmap functions.

 - Fixed a minor RISC-V build error introduced by a recent change to mm-unstable
   which added pud_mkdevmap() to RISC-V

Changes from v1:

 - Moved "mm: Remove PFN_MAP, PFN_SPECIAL, PFN_SG_CHAIN and PFN_SG_LAST" later
   in the series to avoid creating a temporary boot issue on RISC-V as reported
   by Marek[1].

 - Rebased on mm-unstable which includes David's insert_pXd() fixes

 - Stop skipping DAX folios in folio_walk_start(). Instead callers not expecting
   ZONE_DEVICE pages should filter these out, as most already do.

Changes from v2 of the RFC[2]:

 - My ZONE_DEVICE refcount series has been merged as commit 7851bf649d42 (Patch series
   "fs/dax: Fix ZONE_DEVICE page reference counts", v9.) which is included in
   v6.15 so have rebased on top of that.

 - No major changes required for the rebase other than fixing up a new user of
   the pfn_t type (intel_th).

 - As a reminder the main benefit of this series is it frees up a PTE bit
   (pte_devmap).

 - This may be a bit late to consider for inclusion in v6.16 unless it can get
   some more reviews before the merge window closes. I don't think missing v6.16
   is a huge issue though.

 - This passed xfstests for a XFS filesystem with DAX enabled on my system and
   as many of the ndctl tests that pass on my system without it.

Changes for v2:

 - This is an update to my previous RFC[3] removing just pfn_t rebased
   on today's mm-unstable which includes my ZONE_DEVICE refcounting
   clean-up.

 - The removal of the devmap PTE bit and associated infrastructure was
   dropped from that series so I have rolled it into this series.

 - Logically this series makes sense to me, but the dropping of devmap
   is wide ranging and touches some areas I'm less familiar with so
   would definitely appreciate any review comments there.

[1] - https://lore.kernel.org/linux-mm/957c0d9d-2c37-4d5f-a8b8-8bf90cd0aedb@samsung.com/
[2] - https://lore.kernel.org/linux-mm/cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com/
[3] - https://lore.kernel.org/linux-mm/cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com/

All users of dax now require a ZONE_DEVICE page which is properly
refcounted. This means there is no longer any need for the PFN_DEV, PFN_MAP
and PFN_SPECIAL flags. Furthermore the PFN_SG_CHAIN and PFN_SG_LAST flags
never appear to have been used. It is therefore possible to remove the
pfn_t type and replace any usage with raw pfns.

The remaining users of PFN_DEV have simply passed this to
vmf_insert_mixed() to create pte_devmap() mappings. It is unclear why this
was the case but presumably to ensure vm_normal_page() does not return
these pages. These users can be trivially converted to raw pfns and
creating a pXX_special() mapping to ensure vm_normal_page() still doesn't
return these pages.

Now that there are no users of PFN_DEV we can remove the devmap page table
bit and all associated functions and macros, freeing up a software page
table bit.

---

Cc: gerald.schaefer@linux.ibm.com
Cc: dan.j.williams@intel.com
Cc: jgg@ziepe.ca
Cc: willy@infradead.org
Cc: david@redhat.com
Cc: linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: jhubbard@nvidia.com
Cc: hch@lst.de
Cc: zhang.lyra@gmail.com
Cc: debug@rivosinc.com
Cc: bjorn@kernel.org
Cc: balbirs@nvidia.com
Cc: lorenzo.stoakes@oracle.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: loongarch@lists.linux.dev
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: John@Groves.net
Cc: m.szyprowski@samsung.com

Alistair Popple (14):
  mm: Convert pXd_devmap checks to vma_is_dax
  mm: Filter zone device pages returned from folio_walk_start()
  mm: Remove remaining uses of PFN_DEV
  mm: Convert vmf_insert_mixed() from using pte_devmap to pte_special
  mm/gup: Remove pXX_devmap usage from get_user_pages()
  mm/huge_memory: Remove pXd_devmap usage from insert_pXd_pfn()
  mm: Remove redundant pXd_devmap calls
  mm/khugepaged: Remove redundant pmd_devmap() check
  powerpc: Remove checks for devmap pages and PMDs/PUDs
  fs/dax: Remove FS_DAX_LIMITED config option
  mm: Remove devmap related functions and page table bits
  mm: Remove PFN_DEV, PFN_MAP, PFN_SPECIAL, PFN_SG_CHAIN and PFN_SG_LAST
  mm: Remove callers of pfn_t functionality
  mm/memremap: Remove unused devmap_managed_key

 Documentation/mm/arch_pgtable_helpers.rst     |   6 +-
 arch/arm64/Kconfig                            |   1 +-
 arch/arm64/include/asm/pgtable-prot.h         |   1 +-
 arch/arm64/include/asm/pgtable.h              |  24 +---
 arch/loongarch/Kconfig                        |   1 +-
 arch/loongarch/include/asm/pgtable-bits.h     |   6 +-
 arch/loongarch/include/asm/pgtable.h          |  19 +--
 arch/powerpc/Kconfig                          |   1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   7 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  53 +------
 arch/powerpc/include/asm/book3s/64/radix.h    |  14 +--
 arch/powerpc/mm/book3s64/hash_hugepage.c      |   2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |   3 +-
 arch/powerpc/mm/book3s64/hugetlbpage.c        |   2 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  10 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   5 +-
 arch/powerpc/mm/pgtable.c                     |   2 +-
 arch/riscv/Kconfig                            |   1 +-
 arch/riscv/include/asm/pgtable-64.h           |  16 +--
 arch/riscv/include/asm/pgtable-bits.h         |   1 +-
 arch/riscv/include/asm/pgtable.h              |  22 +---
 arch/x86/Kconfig                              |   1 +-
 arch/x86/include/asm/pgtable.h                |  51 +------
 arch/x86/include/asm/pgtable_types.h          |   5 +-
 arch/x86/mm/pat/memtype.c                     |   1 +-
 drivers/dax/device.c                          |  23 +--
 drivers/dax/hmem/hmem.c                       |   1 +-
 drivers/dax/kmem.c                            |   1 +-
 drivers/dax/pmem.c                            |   1 +-
 drivers/dax/super.c                           |   3 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c       |   1 +-
 drivers/gpu/drm/gma500/fbdev.c                |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c      |   1 +-
 drivers/gpu/drm/msm/msm_gem.c                 |   1 +-
 drivers/gpu/drm/omapdrm/omap_gem.c            |   7 +-
 drivers/gpu/drm/v3d/v3d_bo.c                  |   1 +-
 drivers/hwtracing/intel_th/msu.c              |   3 +-
 drivers/md/dm-linear.c                        |   2 +-
 drivers/md/dm-log-writes.c                    |   2 +-
 drivers/md/dm-stripe.c                        |   2 +-
 drivers/md/dm-target.c                        |   2 +-
 drivers/md/dm-writecache.c                    |  11 +-
 drivers/md/dm.c                               |   2 +-
 drivers/nvdimm/pmem.c                         |   8 +-
 drivers/nvdimm/pmem.h                         |   4 +-
 drivers/s390/block/dcssblk.c                  |  10 +-
 drivers/vfio/pci/vfio_pci_core.c              |   7 +-
 fs/Kconfig                                    |   9 +-
 fs/cramfs/inode.c                             |   5 +-
 fs/dax.c                                      |  67 +++-----
 fs/ext4/file.c                                |   2 +-
 fs/fuse/dax.c                                 |   3 +-
 fs/fuse/virtio_fs.c                           |   5 +-
 fs/userfaultfd.c                              |   2 +-
 fs/xfs/xfs_file.c                             |   2 +-
 include/linux/dax.h                           |   9 +-
 include/linux/device-mapper.h                 |   2 +-
 include/linux/huge_mm.h                       |  19 +--
 include/linux/mm.h                            |  11 +-
 include/linux/pfn.h                           |   9 +-
 include/linux/pfn_t.h                         | 131 +----------------
 include/linux/pgtable.h                       |  21 +--
 kernel/events/uprobes.c                       |   2 +-
 mm/Kconfig                                    |   4 +-
 mm/debug_vm_pgtable.c                         |  60 +-------
 mm/gup.c                                      | 160 +-------------------
 mm/hmm.c                                      |  12 +-
 mm/huge_memory.c                              |  96 ++---------
 mm/khugepaged.c                               |   2 +-
 mm/madvise.c                                  |   8 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memory.c                                   |  64 ++------
 mm/memremap.c                                 |  32 +----
 mm/migrate.c                                  |   1 +-
 mm/migrate_device.c                           |   2 +-
 mm/mprotect.c                                 |   2 +-
 mm/mremap.c                                   |   9 +-
 mm/page_vma_mapped.c                          |   5 +-
 mm/pagewalk.c                                 |   8 +-
 mm/pgtable-generic.c                          |   7 +-
 mm/userfaultfd.c                              |  10 +-
 mm/vmscan.c                                   |   5 +-
 tools/testing/nvdimm/pmem-dax.c               |   6 +-
 tools/testing/nvdimm/test/iomap.c             |  11 +-
 tools/testing/nvdimm/test/nfit_test.h         |   1 +-
 86 files changed, 189 insertions(+), 976 deletions(-)
 delete mode 100644 include/linux/pfn_t.h

base-commit: f97971f859dd7d22e63982a493aec85d9e75a69e
-- 
git-series 0.9.1

