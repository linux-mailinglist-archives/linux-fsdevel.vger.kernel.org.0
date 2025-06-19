Return-Path: <linux-fsdevel+bounces-52170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169BAE0075
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D919B4A1ABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1971265CA6;
	Thu, 19 Jun 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hjm78fMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA4200127;
	Thu, 19 Jun 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323148; cv=fail; b=SX5aXUzj70MEI012JP5oFjKaz+7EEqVIuhWg0GjAFbkqA6OnTD8AMkE3NpeoH0Px3Kl77jp6UWrbN+420aaKU7OSQom+mBHRtTijp4aY2XPB8G+XCCUmzyphNt1E42TfCRIwsJ8KwattBZ+iRXiOFzjiYb+c0YD9XwoyhqP54WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323148; c=relaxed/simple;
	bh=6iaZcE0Ux1wH3pLrAcyRsLPpdPbtirPcyIrFUk3Wlrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ufRP0Oq+St+OIrbK/Egut5hZSuPnoBTq/aGDVgifOqx6Ce9ud9mxQ5AOwPYJoBWR2PhcntLwLdnNM9JL+idV2NM4ezXCzKZlYH1K+cVnOpZmrUlMR+99IZWcpMNMV9G8rdjZUdi8klS/6z7xrhD5/m/+z0acAMao1WX1mDg/Mcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hjm78fMk; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FW5MKcZtN5h2BkZ3pPXb9ovVRHCRCIwYdFuK7J1jhaC3F0zZzjbqRPWsGNfPeUwPlWZmYRoRUkn+0HysSm4JFruGsEr0tqrKN1JDQkTbgPuep1MuQJ3XbZPUka+Ab3wMTLWchk7hMCJjEaN6CpnonMNG97KtFPOgsGX+R/xF1JHzS7mvlzqMthdik/faUSLbV+AJm/rvJS8wuBl5MMyPpWyE9HRVsPvoSd/S7VL1jet5GVPto3BpkG2rLCZqbEyZur3ToYjCpQgUWNxgJe/v4ZyNkY6B1vUX5gBtgrDuOeZAZMMkoOIEORsZ9o6SzGWdYQ/7KuLTJTXIO9ToPoBphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmnGaK32QdSoBhTlBJ+WD/lbDDO8veDO5yFj1/sXGVY=;
 b=IAzo6jxTseWza+HMwHhFc/mgv4wNh5QUMp0o7KXt0uT+pIqs2TC5aDKz5/oDrkcMpu6UmZExpIZ8VaB4T8Ex6FP2TLP07w4MFCcqCs0ecjtGwyLFzdso+gBoGgkpV+lCzx1fjUWlKeQEc8KosnGCqfh3t0h2Hfa2Wor4FkOrmpXukw8A8VqkufF3AEruqa1S34l+p7bTMzP02cQ59QnbGbWkTrD20VwsYJwYmjJMc9+7EadrrOKFJa0wQInxhUndnWrSQ23d2oknGajIBg48RJ847356Py/8vy/yfeumCTbnfSScUmXBm3qeWrVG3DU/WDyGCr5KxehUd+5Lwe6PKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmnGaK32QdSoBhTlBJ+WD/lbDDO8veDO5yFj1/sXGVY=;
 b=Hjm78fMkBNZN2xG6+e5MM06DUyQC81EmgODLOQA5HfU3ELqtRHH8MJ/KbeIKQK+zbCC9u1MUEtP6jxwh5lM+o03N75PlkzXAGAGDtMxVJPvjSpQqMn1dJkgWHISmfccZF96Cw4f8PoCaUZUMvcy0vl01dKSJB8JF7G6TS0Vu+XLW80jQIhKiEb3f1uEZcZYQRkkhpkjQ6PYKYR9ZDReHETQ5+DVEf8ZI9/k6BfPhosIZ5FKdW87XMEwCN+D4+B5kUHDsCdibrwWxU79p1IJe7kypmW9of/MZUwmx9jIDAA4GWr8FoFqgwl01BtiThZiE+fC+QHoUFz2GRP0XT+7+DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:52:23 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:52:23 +0000
Date: Thu, 19 Jun 2025 18:52:19 +1000
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	gerald.schaefer@linux.ibm.com, dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, 
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org, balbirs@nvidia.com, 
	lorenzo.stoakes@oracle.com, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-cxl@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, John@groves.net, m.szyprowski@samsung.com
Subject: Re: [PATCH v2 06/14] mm/huge_memory: Remove pXd_devmap usage from
 insert_pXd_pfn()
Message-ID: <esagpnu4oqjpfhvvzfhg6ux5pbikalurex7aw3lelwto4qqzft@vsgljrouwuv7>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <67bc382c49ed8b165cfbd927886372272c35f508.1750075065.git-series.apopple@nvidia.com>
 <6bb233ef-5e56-4546-b571-6a5f052d8b45@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb233ef-5e56-4546-b571-6a5f052d8b45@redhat.com>
X-ClientProxiedBy: SY5P282CA0155.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::21) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2061a9-582e-4a2b-70e0-08ddaf0e9b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QcOHbrBlUdXo4W/BvIF93Am75N0qLBbdfyFVKutama1YZfICn06/imiGZJKY?=
 =?us-ascii?Q?dcmg6e8Qg4B/xo9wLTa99vge+JUrXCWztP6+n/YCDfUKbweaGcNWDJ4XkPlc?=
 =?us-ascii?Q?P0MKwfeKfi7bF9YpfKti8ULt+38Y25g8TnG+OPIDJnp4+ljCFOTba1gjx8vA?=
 =?us-ascii?Q?TeXq7WVREAOuoGLSKY3iUwEv6aInOhCFd7FkXkpr906Wutu0N6hTOZcjjlle?=
 =?us-ascii?Q?dZT7/EQ1S/OM8WQaoiUaqoTYqTBLkC8Pt+Q5TAq/Wp5RnoZ0Gg7G6bdwppTq?=
 =?us-ascii?Q?CDkh10NTJXiaSCbfPiLW7jadHfc80SYxAJ7H1CFgOg9Qh0pyzMWri8khkcbb?=
 =?us-ascii?Q?CzGFdkjO3aKWUtou+al0r6Aw8b4MHORH9bbXBYxlQaYAgZ1B59gI8jD/xBuM?=
 =?us-ascii?Q?6TJJ47hwrc7e6C2R0rPXV8jl+f+CN3e7t4foQxQEGK9FUM6NJjBZ0hCQ6sFU?=
 =?us-ascii?Q?u8u3xOyxQ4OYautNRtq44BYeaoMR+Ctqfr9KV1CpIVIE8gXKqXxjmKuxJ/qO?=
 =?us-ascii?Q?eWyAvprzGOY/UAHF8UKLwnB5sDP6UUSWZH5HqPPPOZnl+bpOr7W486pzCA2l?=
 =?us-ascii?Q?G3zoCiPa2M9JNkCTl3HaEgxnJZ0pGTEoy3e1AlCTuXnQM8aJ9rob/ZQJkna2?=
 =?us-ascii?Q?IL287f0pDqBQcRXqdhT+fB/YV6qMgmVodtXTPT84XC/jD86nPgIXXB/6YlV3?=
 =?us-ascii?Q?oWQqol2411EwMrWB+XNOXV2smMC82tXeLz88Fj1UJqSSLPkjuDy+iJx8S+6H?=
 =?us-ascii?Q?TPwOzrCFAUgwoPsii5vv0e01wcZ69/IHAmK3CTBrZ6ue/weqpzaKnQn9iDCp?=
 =?us-ascii?Q?V9zrDT7lomWJwDMEQD9BbUl/R3g94EuFXqBc7b63slU6PlHI2UcfWYt09nzT?=
 =?us-ascii?Q?w3pjRxrv6/N+NW74vf2xv0ppH/G/QLRaTIqcPWnYELO9B4V+VzeOBoTanOrI?=
 =?us-ascii?Q?zXCy/rDkC3Hbh95a1J11Y8+FZtmrs2spuko5X+36+EA7fv13nSOA6+yj69eF?=
 =?us-ascii?Q?Mhl00PJLV4MvAstMOS5zUbmu2ArQPKEviMemDe+AKbkEN/jHL71J6m3z6GJo?=
 =?us-ascii?Q?WeECSr3okzK3QD0V8tF/9c5JQ/+cDHp7KXVTx6cgmuGINJ409v3bu+b6FIXm?=
 =?us-ascii?Q?TrOvRsm/D6JCErCI5O+cH7azcobD7ybVwx4bz8LESFAzFIhjnT+9T+DH4akn?=
 =?us-ascii?Q?7ex2xhT+wZztzbThv2uaTdP1qf+r2U9ohlV2bMdCw99rP0eMXX2eRFXDFynE?=
 =?us-ascii?Q?5ld8PFSXTgyeOyE3cOBFTHcx0KG8zgRRobDF2cWXa2trO/x0KZuYwCIlP/mD?=
 =?us-ascii?Q?YBUGsrM4qUSi6YRID20y7TppeeIHtFtthP1kLkKOk88uT4glnPj6JWJ3BadL?=
 =?us-ascii?Q?1oqRNhHlX5k6yM9vKLLB8BYHrGZp3dGGmukn9Z/jUmUGLIieDztY7pTNR9Kj?=
 =?us-ascii?Q?2Jwf9PfIul0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9pm/QPelYhVd+5C5G17htaAp1mj7iO2cB67sn250LWijmgK4ao6nRT6nxcyU?=
 =?us-ascii?Q?x+iXT0Ab7K106aGNfChtarWy/OJXPRrtjsPGJNu0ixBeHg/3QhXqOpGAoohy?=
 =?us-ascii?Q?DRXLn4pubuE/WfbrEK9mNOEmNI3GagbTmqo6CM9QhTPIV2jmDm7+CGLeSgkG?=
 =?us-ascii?Q?ifAyPhLVYziR8SiK1ROT+oLwXHtEsmtaTdFeebBfB9eR9i/ipPJyOERRE6D8?=
 =?us-ascii?Q?8bkG0CC7lNYBJEkfA7EuXz9s4uCG67Gjx7FV2bVZ7XoY+GuCs0AefVPAvKVp?=
 =?us-ascii?Q?XtQhXB5Nr70aB2DLARPHOIWoQObHj7OiaA0wls393u4RHG54u+4v0/B447Ds?=
 =?us-ascii?Q?P7dXydj3kqKupEWDnJyZFbW4V4DdpfhGNxCiMdRZdofoME+/BH2o3Ef6ud8V?=
 =?us-ascii?Q?gHz1qTcsPWUJDf3TElcnqk2v0XBimMu344tR2JUCmdu7r9Zb+x4bl3q+xlZf?=
 =?us-ascii?Q?q9eWXlpjrxmpH3mlX1N/KVbG3vn3TgfxtQTF/zKhYHFednCZaYKIrSv4wQ1c?=
 =?us-ascii?Q?gj1FtdJoFtB3gaMRg503yaxvFH4/yVhJe/UMZQ6SUvmlb/LGtU758whvk67q?=
 =?us-ascii?Q?ojjCCQ/es43E2WM4RnYL2U+lAr9cQEeSxNH7YGG1AjC3g34dgQn1li1JofwJ?=
 =?us-ascii?Q?sEDNYk4j6HY6b351d1eri4ZarekEPv1arqcoOpsDf+Nww/H4TNsXr+D2CnA1?=
 =?us-ascii?Q?YXoV9rXgsPPVrGZLdxdq4jJNwsT57MQVgS0XcyBtyRq563GvBMGa67eWTcB6?=
 =?us-ascii?Q?U5Fv3lBfVOYeeG7aU+d0shA0bkC70ewktpSZT21f4kSHyypIi5x7S+IQQQk8?=
 =?us-ascii?Q?nEdUKHoGnyLdBVksUeB25I6lY5huiZ3OauCSWVw8Xr2dGbD6PE7ja0TJq3AQ?=
 =?us-ascii?Q?fwfP5SdLeQeNTF2kRydf+jZadFukatqJGfiafGgy4cYavrp10nIz51wKjpCN?=
 =?us-ascii?Q?cL6+/OvJXsnsBaB+JyvhvTDMN7BZeVLMPrlUXOtQLws8S59YKXI0utjLkGLK?=
 =?us-ascii?Q?IeKb3dL7wU1E6JiKDAonogoTxpknHk8h0aAr4XiEfUKqjrVRXB1vx/v4jBVp?=
 =?us-ascii?Q?qBcvbSkoNMtDhJmdUnMzlb9dJCAV40RMqIRzRSD58sTMefpavPqjHpinqAoy?=
 =?us-ascii?Q?meYSdBy3/SEazXQD22guca6YhvD3g59fCb/MFl5Qn7eKtzy7/kcA/qdtpdkj?=
 =?us-ascii?Q?B7tyBm4tsqYyRB/nkBIGZPWngiQLSQMkD9L18uYwRb6qKL88NerSFDFUFoRb?=
 =?us-ascii?Q?UQDcwYzryBlSpcznJmYdtCC3En8ar2KS8e9vSx4N0MXdhXCzz8K6BXBk+Jn1?=
 =?us-ascii?Q?DVaTCcHXX2UYTdg8nr0Qwhv5BfU73xSYiudstd4zq67bPQK6OjHsTXyt0sUD?=
 =?us-ascii?Q?5WSc7y0+acNrFt5lJIZdMX7sx2dSKYcQV2qccCVN5JernRHhGIvgCu1G6yEc?=
 =?us-ascii?Q?fIl/59gUr9Iyt9cL2vn2eS0j5l54md5wbMlwA/haCKXYFCQ6DfUS2aod+6TD?=
 =?us-ascii?Q?YMHesb4cu7U2ikv4d6JEQgHAVigRTW5cQdK3Cf9Ojr3hcCmDFNjauDpX5IfG?=
 =?us-ascii?Q?Ud9BxVpmlLMy9HGDVLgwA6L1gTETEIKOXgWRp2Nq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2061a9-582e-4a2b-70e0-08ddaf0e9b66
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:52:23.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpT19xq6gG1CBSGE7aOrbfKN62ad05QnoyGA0G61zhTo8vFQHzTSgJh3FjQhcxRkursHt/Ruut7JoGU5oXFE+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

On Tue, Jun 17, 2025 at 11:49:20AM +0200, David Hildenbrand wrote:
> On 16.06.25 13:58, Alistair Popple wrote:
> > Nothing uses PFN_DEV anymore so no need to create devmap pXd's when
> > mapping a PFN. Instead special mappings will be created which ensures
> > vm_normal_page_pXd() will not return pages which don't have an
> > associated page. This could change behaviour slightly on architectures
> > where pXd_devmap() does not imply pXd_special() as the normal page
> > checks would have fallen through to checking VM_PFNMAP/MIXEDMAP instead,
> > which in theory at least could have returned a page.
> > 
> > However vm_normal_page_pXd() should never have been returning pages for
> > pXd_devmap() entries anyway, so anything relying on that would have been
> > a bug.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > 
> > ---
> > 
> > Changes since v1:
> > 
> >   - New for v2
> > ---
> >   mm/huge_memory.c | 12 ++----------
> >   1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b096240..6514e25 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1415,11 +1415,7 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
> >   		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
> >   	} else {
> >   		entry = pmd_mkhuge(pfn_t_pmd(fop.pfn, prot));
> > -
> > -		if (pfn_t_devmap(fop.pfn))
> > -			entry = pmd_mkdevmap(entry);
> > -		else
> > -			entry = pmd_mkspecial(entry);
> > +		entry = pmd_mkspecial(entry);
> >   	}
> >   	if (write) {
> >   		entry = pmd_mkyoung(pmd_mkdirty(entry));
> > @@ -1565,11 +1561,7 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
> >   		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PUD_NR);
> >   	} else {
> >   		entry = pud_mkhuge(pfn_t_pud(fop.pfn, prot));
> > -
> > -		if (pfn_t_devmap(fop.pfn))
> > -			entry = pud_mkdevmap(entry);
> > -		else
> > -			entry = pud_mkspecial(entry);
> > +		entry = pud_mkspecial(entry);
> >   	}
> >   	if (write) {
> >   		entry = pud_mkyoung(pud_mkdirty(entry));
> 
> 
> Why not squash this patch into #3, and remove the pmd_special() check from
> vm_normal_page_pmd() in the same go? Seems wrong to handle the PMD/PUD case
> separately.

Yeah, that was mostly because "someone" (and thankyou btw, it was somewhat my
mess) changed all this while I was working on it :-) I wanted to make the rebase
fixups obvious but will squash them for v3.

> But now I am confused why some pte_devmap() checks are removed in patch #3,
> while others are removed in #7.
> 
> Why not split it up into (a) stop setting p*_devmap() and (b) remove
> p*_devmap().
> 
> Logically makes more sense to me ... :)

Heh. You're right. For various reasons this patch series has gone through a
couple of reorderings, mainly to get rid of unused stuff early in the series but
that didn't work out due to that RISC-V bug. I needed a break from silly rebase
build errors so this was a good checkpoint.

But I've reworked things for v3 to get the ordering a bit more sensible.

> -- 
> Cheers,
> 
> David / dhildenb
> 

