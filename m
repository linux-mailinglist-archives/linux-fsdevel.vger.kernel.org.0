Return-Path: <linux-fsdevel+bounces-37587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC639F4256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99CA7A51A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DB1DFE00;
	Tue, 17 Dec 2024 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JIVvDalB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DBC1DF984;
	Tue, 17 Dec 2024 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412487; cv=fail; b=P6wGd15phQymBYqjHFsvLZq6qU4OiDe7+HFcd7lt82OQJMKb4hl6ex/G9F1y5v8/OQ6yqAq3lg8Uc44EwrjEmHFc9UCviYC2Ca2TNNIZLIkqR2l7bxyRE9ZgNTbw3h6jVYn1K0wOVV5oaN+wLwjIKBruMBlNrIMg7oYh6iHc2c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412487; c=relaxed/simple;
	bh=6Fr3vnXYEeP8NiNGAQ3OzK5IM9cbS3MdlS/JsB4+dUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S85IYbuONB0QORhBy+dPjvZU6w7FBrtsnt3PBIrp2d/2Jt6VJ54qUunBWRi+V/7OyIPcKkFA+9I3IBmva4EkU2mccSPGGIXS8CpNS1zhbFOV3N9PXZSHtAExCO8OaD0w9QeXdrjAlGmMRAWY0geh63nfphOoC5lNks69dgSxrIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JIVvDalB; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8nnEn1ajo+2Pj76utqjNUhwM1VIb1yjyfJl60/dlnw9nDy8wuh593+D290FZwxaP1vmLdMiw6sSctmrSoQPAwY2DyAF3VV4fTiD2DMUoLng7Pjjw5B94QuV2rFHyT1KCW9hFU2qpBps48Z2f3kKaSYChhFK/xdmbv6b18IWa+Yokf4UQp9HJR9g0vMLOE6gGfI6gwuYY2JwhWRTg/su5Rk1/nst3B0skfGsKb751gSjml9ACvskAOvNjPerIvqhYfEFmIwnxi2Hko9/ffGYVHZ6myAocnwMMjr+ssgziKRjdq8gkCEiVbXWvYOcQlODXmt8DVvCjZJK+xxAqSvy6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5MhO/dRA0tjI1dUV5ZoqTSusZp5BthCYTx40EefRUo=;
 b=VsN5TdvIUvW7jm5aLviM9G6LT3yNMzFC2VNpK9JrYQVOuupY8oEUSPZkrfoZjCf/dskeqGqI0thmzakWDTiUjXZ7hiV/TBs9m9cQZ6CdUjcftAWQ/Ml+XvczUviqIsBj9AI/IxUbDJq4OK7fRTTYzWvXaFyQrBDEJ2djSTFNSU4ZuqBS1sUFsf3w/e1YHbXs1ngjoPHbxTxyz+5XUK6S9r9vrU6W1Ge1nrY8iuq1t7BUA/i5HDOay8MX8vC4pjOVRiuDG2N8pDh7nPuEmEy1/8xAhXxmpfpE85lGV/0qNJ/4lZTQpD9wMR1U38SO7x8gtB2urI+eTiZt/+4hNclD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5MhO/dRA0tjI1dUV5ZoqTSusZp5BthCYTx40EefRUo=;
 b=JIVvDalB7NE70/AIzHzsl59yFKa5FIM/rudzetMB87Wwh7YZs9CAR/64BGWedSXATj0V6+KG6K6x7NVZZQz+I27jpwM+ziwzZgwV3Jxp2byuAlEy7O3e1DOTGDsDUhDgy5az2aUYwaj96E+QTNFPpRQwY3mT4RXXzg5j6a9E6zkT6Rl2ov58sx/ad02FJBhIuk2VuofMCxcDi1WJaXkdwTaysh5EqpUYGVLPVCI9J5OqqhP1K7miSLHu8G3Zrl3Hh+pp64bhUR/Lcg8GhHwzT4j3YP69xQHXfblNlWd5D3g8Zk6LiBj9xV1AO64ousRMKjniFn0k78xnyg/AKZFlJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:14:44 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:14:44 +0000
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
Subject: [PATCH v4 13/25] mm/memory: Add vmf_insert_page_mkwrite()
Date: Tue, 17 Dec 2024 16:12:56 +1100
Message-ID: <e55ea5e8aa44946b09030fc4a164d2735c305327.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0016.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::26) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 707a850a-c47f-486d-7807-08dd1e59b788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kt66ZZU9iGjMeOzPDja6nI82dO8l/qPHRxslb32KOWvmTSnvJTYkVlk//pGV?=
 =?us-ascii?Q?UktMqE6bblUs3yAsSvfNBCr4mG+iZWBxyEz7PiJeWpUBCxWMXlR0aOUsLQGb?=
 =?us-ascii?Q?O2U2xSFkTNxaF9nwXDyiU+HnKAjWmdD3PfgzWpEfnjNvxZNqhGlpve0kPUvP?=
 =?us-ascii?Q?40dCl1KWf4AeGIQU9h6zusWFOW+4mCN71aXKh32qb0wwqCBAqniCprZY9UQA?=
 =?us-ascii?Q?+NTmI5NuRfEJv9RBOKW7zmoM9bmK1F58h/K2wwbJZe7wPyMa7tkaBUEXBG+2?=
 =?us-ascii?Q?kPhltXgt0KGdW2USi0Qwvq5vLLjEZRc0X8vUZwZsTUlVXpDVfAnb97/xJR7S?=
 =?us-ascii?Q?Ch6YcmgyyH7XcwDeOXAgLAUy1IdBVcVWPr5oTqw/T49xt5lHH1CaWo0Exy3u?=
 =?us-ascii?Q?UwF3UqWBPV5o0xLWA7XF1f4ylUxkypqKOf3j0AbxKA7gOLTUwjg1W7zDrQrw?=
 =?us-ascii?Q?SBsdLCSuuug83kyzx5WjI1oZI6pnwMvA5mBQRIjAZcAOGOj0FC80ZuTrDRa+?=
 =?us-ascii?Q?eaVeuoGErKiS8p+RsbXBys2mtr5KKlTkFVsl+ZCJEp0Xk1iYqQ2semyMJW7/?=
 =?us-ascii?Q?opn35URHJ9fdLqGVCdl50xEI+Umk+7P8A24pf0CznBDhFy+4JNjVvrgqJoKF?=
 =?us-ascii?Q?0liajL583dz8UMc7puiHJUVcJ0EY2PppaD3SygvJBoeXsWyIaHjULjS14e+9?=
 =?us-ascii?Q?R2h89GxTrX4LZLjYehumIXLSwVtMxg2xpgK+oDF+uEj2GBfdXs0jY3eJOYRx?=
 =?us-ascii?Q?rATIAOpw/XcuZGUSrFhNVePo795c6SOjzCiLNhT/Oc36eoFgLDSgItx1cASo?=
 =?us-ascii?Q?EelbMiKpvlGGeQ4yU8im0VS5Jhseq70MvsZEwkMGhSmftB/Shbuz1ZbuZnte?=
 =?us-ascii?Q?q2kQThhX/3BKp524Jf2wW5OmZv/pHnnBgsmncQ2CLgB3XWxWtMGCaBenhpmz?=
 =?us-ascii?Q?KUaM0YB9v/tHdY1KjNDDNyxby5uxsLvH2fjDbo2/ALCfgrT1EBog25xFSAtQ?=
 =?us-ascii?Q?aBVmuXmfVPnB0c6SJqCcUecqoDw0UycI6ZUOW//7GCQp5egXOxNPI5+X67W+?=
 =?us-ascii?Q?WqDnkRnwJDQKv49wAtnGt7RWsbbAoK9+0enXwMNBopH/8wogg2Oag2bcpBtW?=
 =?us-ascii?Q?6dqi1EYq1CxZtsB5AD2Boru/R2g0C9/Sjfnu8tSVEhcaiNUObIBEFfTGSQtG?=
 =?us-ascii?Q?z18bi6i/KweLO0leJC06XSsLB7hzkP2ut0zbcyQlYLudrRFyeKOmxCEoJu5K?=
 =?us-ascii?Q?WE6ShHODGNsHHlGjwpo19BI3v6HRRWf3+UUlvCjJOep+g0ts8RTWv32CL60y?=
 =?us-ascii?Q?YUMuZGz54mVDsDW4Y1htBjrb1aCQpsXt7chxgPg9tWcNEHygtL1/BBe+fM2U?=
 =?us-ascii?Q?WlsHLLg5BXBMywdjxl/4cDIwLhFz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?amY/o2cdeFIYVbsbGUtboZ6nfjsYmT6sdCKyFJ+YBQTeaEyqy/hGX84S1OZB?=
 =?us-ascii?Q?Hi71KqIBOvLG/ryD84984FLU2+3oKZ7Plg/SJ5jEhwsPkPzYvM+V81vDLFt2?=
 =?us-ascii?Q?QG3hshExJePplr2nobCaUfk2GhXerjo3g0X3pti/+7ALSW3FsJbcB9mX1AEA?=
 =?us-ascii?Q?zADP1Gp/Xi7+OdT+kdv0UNkurikx1XbS2uIuc2vrZTC5qzY0wKUcLpXXdIax?=
 =?us-ascii?Q?Wu2uBuauIY5wrI6gPv6qU90A7OYGF6IiYd3iW60AwImMUCbaOfoLFs4XZRHF?=
 =?us-ascii?Q?UItoF9c+/uE1RTkHCWlWuWhwjW/fvfLtZLWjyemkvKRFWFeSkWLYRkuoYDF/?=
 =?us-ascii?Q?dgyc16hxuDr3UNCDHHHXynwanodeCWZL/0rSpNh5J50EF3T3eyi/UXqwWUBl?=
 =?us-ascii?Q?5zdGpcsv7AmiMt5bLwbMAV/TCHe/0XBqycTHrh3Auvr21j40iGyqXgr96ilB?=
 =?us-ascii?Q?c44In/M/2N595jKEIBFFeutw2oPJimPBNEGoiU7r4XQQqV3bCX/gOdELVJkV?=
 =?us-ascii?Q?vcK2X2HcOysDqieYxZy5LqlUbZqINnviYPubBPH1jio4e6bXq3IFyiYxz2KD?=
 =?us-ascii?Q?g4E4+X1mwsvkfeXHVWgyD8Ez6SeKjO5/XdBSzxVz//N+AAJVTnSsCp4t+Q/F?=
 =?us-ascii?Q?Q291rD+6KkjECc4yXzKaaEUGJDun4aeWQY56JEAf8AXNFwik69AzleVJQlNI?=
 =?us-ascii?Q?2//TUdjZ5luFbgL5elut/NRYRXKEtXFXjr+tgdJdRcDOcUqXpKhcTAeJOu/+?=
 =?us-ascii?Q?pJMTTzuqWaod21oqtOtqn3nR2dho4XsBbWGFujRTk7Qsu4dkoBD2dweEToj1?=
 =?us-ascii?Q?GME32DcTHfOj+GjXByUuiABhf1yB0+2zZRNTVTkPcYG5aHkQUsWhukm1VBfo?=
 =?us-ascii?Q?pIgCmTqZlObhMyK0iOOAyLYI9Xg2FyiXB1V+h57lCfHrR/re63ghIqhhuE01?=
 =?us-ascii?Q?kDsKqfx7pDKIJ5FI6cqhLOFABs5mBHemSL5TTmbONCrAoA7BnadrOe2PPIwE?=
 =?us-ascii?Q?iByqIcwuIOnBRIsHtB1y44SRrgVnpwSa67Cysz/yeuMggUqacQhXoYTVXBk5?=
 =?us-ascii?Q?G4bJgQVPbYj79TZuYb6c1Rnp2xaTJ1p5oUUdk+ZVlsy2EVTDa6fo9x/VYYBx?=
 =?us-ascii?Q?xHXXf5osBp3Q5qsGRddXkaBn07ZH88FWMed4rCpKUkU24nKPtb5+7jBctGtW?=
 =?us-ascii?Q?zIXY8Uts0knsx4XyFPQuELXAuINR4KaAk88wF743npdhz0/6mM0ZZJGLKoxF?=
 =?us-ascii?Q?1h5uADermedp4ZolfMdtnZPT4ukxBXslfd1+ma3+Qz9Vsy2hOSWEjCZmfnmf?=
 =?us-ascii?Q?NYA6H5dQt9buZMb3rK011nVzfBsuI2Ezd5Sydb2PZW/t0YrrS6Qgoihydmb9?=
 =?us-ascii?Q?zphdLLnonXFbfXvd1u/9xyIO53t188x/VCzEx7ls2K3IG3GYCpfiilSzDVFn?=
 =?us-ascii?Q?xz0ac6seIiMDhp0WNgyrMp4y/DPzM1SXvnS/xLhtZ19YfjAIsRaQOWIXIKsa?=
 =?us-ascii?Q?Db8cKStNLJLCjF1aYI/x1Bgo4+UymDkT8JwNk6IG9MUYi1wJAmeK99HdcUuk?=
 =?us-ascii?Q?t/THQ9KzR53TmKU5i/+iNljd37GDEIlxwQpmhuFa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707a850a-c47f-486d-7807-08dd1e59b788
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:14:43.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrxOoINxJEPydz6kQXH89kVqUovVV1L7w3zmdQddH+16k9iBybaFjljYMzUw59MsXTnPCwWejuetQgi0zr5rjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
creates a special devmap PTE entry for the pfn but does not take a
reference on the underlying struct page for the mapping. This is
because DAX page refcounts are treated specially, as indicated by the
presence of a devmap entry.

To allow DAX page refcounts to be managed the same as normal page
refcounts introduce vmf_insert_page_mkwrite(). This will take a
reference on the underlying page much the same as vmf_insert_page,
except it also permits upgrading an existing mapping to be writable if
requested/possible.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Updates from v2:

 - Rename function to make not DAX specific

 - Split the insert_page_into_pte_locked() change into a separate
   patch.

Updates from v1:

 - Re-arrange code in insert_page_into_pte_locked() based on comments
   from Jan Kara.

 - Call mkdrity/mkyoung for the mkwrite case, also suggested by Jan.
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e790298..f267b06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3620,6 +3620,8 @@ int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
+vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
+			bool write);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index cd82952..4f73454 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2632,6 +2632,42 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
+			bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pgprot_t pgprot = vma->vm_page_prot;
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long addr = vmf->address;
+	int err;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	track_pfn_insert(vma, &pgprot, pfn_to_pfn_t(pfn));
+
+	if (!pfn_modify_allowed(pfn, pgprot))
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * We refcount the page normally so make sure pfn_valid is true.
+	 */
+	if (!pfn_valid(pfn))
+		return VM_FAULT_SIGBUS;
+
+	if (WARN_ON(is_zero_pfn(pfn) && write))
+		return VM_FAULT_SIGBUS;
+
+	err = insert_page(vma, addr, page, pgprot, write);
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err < 0 && err != -EBUSY)
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_page_mkwrite);
+
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
 {
-- 
git-series 0.9.1

