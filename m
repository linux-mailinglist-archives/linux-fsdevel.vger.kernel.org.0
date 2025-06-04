Return-Path: <linux-fsdevel+bounces-50571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E747CACD672
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 05:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21EE7A82A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 03:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9516238D3A;
	Wed,  4 Jun 2025 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c/GpJUv8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D52144C4;
	Wed,  4 Jun 2025 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749007386; cv=fail; b=t7tY+yIJ49RqBTZjzSvFuz/VThaEOwcd4sRgvx5gjYGQ6qfHldMyE6tbmPZNpvvUzEUlXX/hsa0Pyd2BdkcqABOb8mVjM2vvY2/37/6vk7BayV3SJ1TCUHG6yeZdGcx6jR2byFVFEjwujA8Z0WU8fw2f2IE1HrzapR8Ltj+ILzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749007386; c=relaxed/simple;
	bh=xazYVQDifn5rCaXSasgY6pTi/gvpfm0WynTf2Q2YFuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTFPZphsi5QEEIRHAuMuZjNHmYe1xrJ9v8XN3L03qE5cjt/KoeOqbvOEHXa9JcEWKDltVId++Fo8cMSsm+0XQp67V9QgdWaj+RgPnfY+xtI/UbM9AueQFDzkzMXDHCFqD7hAgiFtMzJnNaidWxQ82LwRO9bHKWEOQOGz6ZGdBG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c/GpJUv8; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr8t8rryO7sagnj9+2ilIFZK3QtA9s6v1jrmY3E4LfhTtb7UoGKIp3erYDVnAsGdr2idw8qn3MMd7q90rHCCIlkLg1lU2mcxP/M+t83zLjFrLfDAEyeq7yuVQrKTRvFQyX6UqbH4GZvLlcxfzQZ4aZ7o4EyAeSvGTsILBCT7R9cQzHdueQNGp29EUpCWceCSFCidcZk33jH1RDRh4JKIl0IlIogxOCAQ8wHYfE45sk1uc2tbJkWvwJIGmkD2ImEQUrw9StR7P3OiIvLsLrwKkr7RHKD1VU9ahyzLJmD+5AHqR48oc7L2v4jFni4IHj1eKLec2nBzxppn3o4Uyp1+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/oXCYfs8p22yX2veREcR01aN8OcxQDVRRVacg1XFbU=;
 b=TbqWUCHLlCYrMVlrplKYOCPpqan16Li7ICOVwaRpiK18yILeoST54HEX0lKQq+HkK2qeGCdPhL8JesBo32yzJiv20dsrekxlJffAOg2UVBcq/2S/g7Ae4HK388uOYrzpARzBw2J1gPko3FD/2IHbYY2NukPAkRTT2RBklcpzUtijH2GPKzpS8S91CaBo5kEz+cEHftpaRqBH/oDVD6CFFOAJmO2W+dKBuNw6UZpaDEi++2Bsk4fer3RNHARmQR5oFH9edzjuhQE0n4qHKkOEP1ZpSwNFd66Armugaj5Gq0lsdtnn8757T/K8lOdiPfaZx9V2gaNGlZ5TNa9GVwZPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/oXCYfs8p22yX2veREcR01aN8OcxQDVRRVacg1XFbU=;
 b=c/GpJUv8OW8i2Vhs66PzdqcH8lTANEO98IkESHP8wftmKVjZBtpNtZdJq52MuAL8ZZaKZaGDTRPZE0VTRDJlXhelhnhuoupo7wcjONfBQPSEfIMyWWslO+JtxuPNv2jfTtxUzZxQGqlyXd8o/jF8KiSLRph75RQHkcslbWm+xaMY0j7xZS1n1X1OaxIqeYT4qk30+1C8uer+2ksjtlGx8yH1ZXI5q6e31P1sJ1MN1RBQ1MRF1wqxIyAZyRDg1X2JNO7emDUMC4hoPrOUPF2NhIBgS+miG0a7lWy77GiqN3X8QRAGpyG5aQsrynlhPeMzPEPPa4gUyujeVjoYGnAtYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 03:23:01 +0000
Received: from DS0PR12MB7728.namprd12.prod.outlook.com
 ([fe80::f790:9057:1f2:6e67]) by DS0PR12MB7728.namprd12.prod.outlook.com
 ([fe80::f790:9057:1f2:6e67%5]) with mapi id 15.20.8769.022; Wed, 4 Jun 2025
 03:23:01 +0000
Date: Wed, 4 Jun 2025 13:22:56 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com, 
	dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org, david@redhat.com, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, 
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org, balbirs@nvidia.com, 
	lorenzo.stoakes@oracle.com, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-cxl@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, John@groves.net
Subject: Re: [PATCH 01/12] mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
Message-ID: <ekafxsxxsf3y7mhgiogo6yoh7k45vfqwd73i3tzjb7gtsjdt5t@vwga6qbn3jcz>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <cb45fa705b2eefa1228e262778e784e9b3646827.1748500293.git-series.apopple@nvidia.com>
 <20250529124620.00006ac7@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529124620.00006ac7@huawei.com>
X-ClientProxiedBy: SY5P282CA0110.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::15) To DS0PR12MB7728.namprd12.prod.outlook.com
 (2603:10b6:8:13a::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7728:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 54683ab3-b473-4e53-b754-08dda3171c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GVr/G4aJ4rDXJVN4SS0786b5vXzk5qo/hRdaGlcWRe8FkqPbwICk4ehwscxl?=
 =?us-ascii?Q?xcdLpuiTM24Qj1o2eNAJyQgljAnkK+TsX2J8Pm8V5c/GH6sa/Jic5HEL8wHf?=
 =?us-ascii?Q?/2xGkmduMiVp0brTzrxaaGKPaDd5WV+BMKLrjNLCjid62HYDQR/wJ3hNcUrN?=
 =?us-ascii?Q?Zj3NtxGNaZDhhP1zzNAecafPt56UYXy4vf6wx84auk6piQ7Ewi0jtsr5vI10?=
 =?us-ascii?Q?7Q9FHTfwFB9L9xQM1vbA9kH7O4yiBJaz6w7OHEbMe4YmHwJhdo9hEtKi5fBX?=
 =?us-ascii?Q?W855iLktJDG37B0F19jFGoJeUzD7q7auOSE++GAMfrSwZo/QCirU2wSXJAZy?=
 =?us-ascii?Q?p0IS8rrysxFpyfSm5cWWYbY+dvLZvDazRvAJ0TCpXsVRxTTVtBlxA+DLeI+O?=
 =?us-ascii?Q?pRKjy/GSG2N/5l+QlI3HENYNsKum6FfnvLRsdyRNJXMzB/ydrNwhYlmXpqfg?=
 =?us-ascii?Q?bz/vGLchmCO/AqhD2osrCNAQraGaceB10wYtxwwESGU+a8H+dz67xkom8R0M?=
 =?us-ascii?Q?TaELbWFqcwh2JQkriMPa0yIz9iK7I5fa+dy36geVcr0u1sxbBUDpV83+xAH9?=
 =?us-ascii?Q?6a2NMo+tddV3KE2SMqyM+vkBS6tDjjaRupWKIe14GLqmKfmIcRSEhXDUQ4vA?=
 =?us-ascii?Q?BXSk4qcyVpJNAlkN/oqS5fDhuW5REr99jvUQEPm9ioUe+qRWPdx9w0CB004L?=
 =?us-ascii?Q?4TVzLV2GRGSHTleO5nRRcdVr0aIgkI8XZ84cEAOyjpZHj1DXkzGexNMXqpEG?=
 =?us-ascii?Q?hbpvZ9pvZ7YilDJXw6LU4k2GN7vTNzKH+pevv5akcl310eyrLdq8q+gj4dAQ?=
 =?us-ascii?Q?oMoznIGk5VVpapIrSUAb2PY2Rv2KZTmg5KG42i+poZ08ELsEt3EMYOsynM8J?=
 =?us-ascii?Q?Z4Qw/wEfv+VUF/R4rgXyvp9wEwdKy9fUn0qziYTtln4CUrZ/F8Uom6C1Trd1?=
 =?us-ascii?Q?PCUxYXFtIATfhg9LOESYDpmlCacpFHXCcWaFG4JVCX+N/0HcUnAjW5RvCrCD?=
 =?us-ascii?Q?G1T1dgMPcR2JtTw9Ih6lg3iJrmIFdV8wUFp09vOU6hfUcWppt1m6t1pv2pI0?=
 =?us-ascii?Q?QsIO7oH3q3gRa8z4C2wwG+sjLK/eD8ZLwhXkeMSG3m7W6rloeu4PagVZCImE?=
 =?us-ascii?Q?P8FUM8heulsmBDUfzEm+hbMw7jVPnQQCOF7Lba3Z7vFej7e7MkTDdll/1rEp?=
 =?us-ascii?Q?CkF8BQkFMYqKxugeL0KD75XQe7bwUEzqj7Tn/+olBNbEUi7UJASexG0AJrRE?=
 =?us-ascii?Q?86j+TO2DYEyPI5MOhSSdQcHoj7VoIQrUKiIOF4PPKXLNtLdLPlT5GRNvOLDY?=
 =?us-ascii?Q?9Z8Wf0UmPxVjttTeIow+Wi8ezurkAuAxVeDdclPPfVaLRANgCPg/+ghfIE/6?=
 =?us-ascii?Q?Af2eGBT70mUwa2snRdg+yqXEi1PzWjfQuK/Jt0ZuvYR4mUoEr/hRr351hzAP?=
 =?us-ascii?Q?+TmTFYN5sKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pIX7+dq6PKkLyFyjZE8czFpOvTTVkffwyxAG9efM7oyH7oUehlUPBAFOvQcy?=
 =?us-ascii?Q?zj+HapJQ7+BXsqTq+xMOYBBjIMDBggbec5UsR0DBbjtQ2MkR0cQIiYjjeK/1?=
 =?us-ascii?Q?g7vmDUZR6wjVBSfBS5uXREduiRxwpDNhRKcboyVnDaytrqqMJaeF+3aL554Q?=
 =?us-ascii?Q?GaGYMW6Py4X7a7JMXSvCcLIvBRMcexcG1W0XfqhQr+xYk8TOctFt6zWZluJ+?=
 =?us-ascii?Q?bRWB0D11tOhLwGtFWwtpPt/qALp3TTceSplPBO7R1tTpVZ0HILquY8w0ZUTP?=
 =?us-ascii?Q?+KuKG4ROXjFrmgL1JUX1IVBhVHN47FWIpJlqY12jUOfkhVlcldXykm/aS4lI?=
 =?us-ascii?Q?ShzckjKgeM8zpRLJFljv4dWfBFeFyJ2/cv/HNn7ccZ1/kPQqJx5S9GaOTvQ2?=
 =?us-ascii?Q?FQhZphXMufkKNFcecZKsmmWlaxh503NsQ/S3NVoCNUn5fmPuXqncBJ7gdcyd?=
 =?us-ascii?Q?fbWeFz6WcTU5iNwGbsGOYmjBCqrPC9oAIgI/d9yKsqDCaUtiCX3l5p8UQ9Iz?=
 =?us-ascii?Q?Rvd69wvQG8Fl/8LSTps/glSOkg9h/lX27LbSvK+oUujqEUfaTQrEAbRcje9T?=
 =?us-ascii?Q?xbkgIRJ80tXrfRq394yrWRSQQnY3lgMPD2rfdPsHuAQtOtNSLqFtEGok3mn1?=
 =?us-ascii?Q?NXa7SZHRSRx0eJLmB+U5DLvmwAW1PB36Drzxt7YrHmI0CYRGvw4WLCm8j9Q6?=
 =?us-ascii?Q?mV3ea9MlmziLLw8nWo4WIz5TSeMLwHY8mrl07+OLdqIcGeVvKC7XhijSqIJh?=
 =?us-ascii?Q?064E43X3p0+HkiVljF519hLIq5Mo/X/3rxVHQSSzsbE1a6ieKxtoTL25zU4u?=
 =?us-ascii?Q?pRz77Z9AgmW+Ycx4l+WYaxnWgMyPhEaAhcjZo37NtqXSMixhLIukijKEepXW?=
 =?us-ascii?Q?Glpp0FMnm/LXC5wyyvSPt2spbzVvdD7f7KKaQkp4mFp0JLZi2ZIXbzNxsnL1?=
 =?us-ascii?Q?LOcZbWACMA5uL+CDVrIZ93qFNxcRqWt5iX9Qp3o+Riu84F1qc5h8JhJG5znG?=
 =?us-ascii?Q?p9VzvN9CdTrH2ROBaR6mquPgNmWmwvIyC0oSS4Pg25LWNPmR4XnE14vazqb2?=
 =?us-ascii?Q?8Y4INjQB72sEkoyWwUGt08IjXSkIZmPSubQugVEjUHzUXwY6vICzPOFFZYVv?=
 =?us-ascii?Q?ZJNlvWo3CAkxuxRsTOB3OdlAZoEhBn96QBdgDSyEsJMJ3Z0cJ0H+ed/E8Cu0?=
 =?us-ascii?Q?GB88e4XIU84oeUDVrTBYM60ZeU3ep1wutMrXWDo1Z5pyLZJfFxs3S1eKITxO?=
 =?us-ascii?Q?0A65GKqTOlthaUxkkKD1d9H1A+pVngBaNkacSHNpDYF2WTkRc0OZXgjMh3dI?=
 =?us-ascii?Q?+1H6UWnZXLmYYup68fihgSKVX+hJSdSsvX3S9yhyHHneakevxrlVagActhkn?=
 =?us-ascii?Q?vMkS7Mjxf/B+f/9ujWuY1T7hQNLeVXeJtCoG7yeu5brhXa/gWik/ZIqOIqwU?=
 =?us-ascii?Q?3IlSw0OT697Lr5+OxdxKFlciG2WAVNL2C30R4kKWUFRVmL6VEhAdurm/P9Du?=
 =?us-ascii?Q?8TgSE8oE+I25men7qL5A2hmWguoAPOPILRVTbQE/560pYXpHHeeSC4DA/7M+?=
 =?us-ascii?Q?Ts8prSBazKjaZXmP3/mBzaOHIlBFB1Bgy5GCIaPf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54683ab3-b473-4e53-b754-08dda3171c38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 03:23:01.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXLK1uYBPiIVPBcHZiJsRK2eEKSOW9NBAvaQ56JrerO1xO1FdZPiqsLpWadurR7oEnBxW2pVHxsHjnylhwywSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345

On Thu, May 29, 2025 at 12:46:20PM +0100, Jonathan Cameron wrote:
> On Thu, 29 May 2025 16:32:02 +1000
> Alistair Popple <apopple@nvidia.com> wrote:
> 
> > The PFN_MAP flag is no longer used for anything, so remove it. The
> > PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been used so
> > also remove them.
> 
> Superficial thing but you seem to be be removing PFN_SPECIAL as well and
> this description and patche description don't mention that.
> 
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> On superficial comment inline.
> 
> > ---
> >  include/linux/pfn_t.h             | 31 +++----------------------------
> >  mm/memory.c                       |  2 --
> >  tools/testing/nvdimm/test/iomap.c |  4 ----
> >  3 files changed, 3 insertions(+), 34 deletions(-)
> > 
> > diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
> > index 2d91482..46afa12 100644
> > --- a/include/linux/pfn_t.h
> > +++ b/include/linux/pfn_t.h
> > @@ -5,26 +5,13 @@
> 
> 
> 
> > diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> > index e431372..ddceb04 100644
> > --- a/tools/testing/nvdimm/test/iomap.c
> > +++ b/tools/testing/nvdimm/test/iomap.c
> > @@ -137,10 +137,6 @@ EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
> >  
> >  pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
> >  {
> > -	struct nfit_test_resource *nfit_res = get_nfit_res(addr);
> > -
> > -	if (nfit_res)
> > -		flags &= ~PFN_MAP;
> >          return phys_to_pfn_t(addr, flags);
> 
> Maybe not the time to point it out, but what is going on with indent here?
> Looks like some spaces snuck in for that last line.

Yeah weird. I don't think that was me. In any case this gets deleted entirely
later in the series so won't bother to fix it here.

> >  }
> >  EXPORT_SYMBOL(__wrap_phys_to_pfn_t);
> 

