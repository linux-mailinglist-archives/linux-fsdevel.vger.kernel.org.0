Return-Path: <linux-fsdevel+bounces-39172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C458CA110EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 20:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 349637A1248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B020013A;
	Tue, 14 Jan 2025 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx4pq5Yq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3BD1917ED;
	Tue, 14 Jan 2025 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881887; cv=fail; b=Yhi+f4HCFq8r9XgxKOJHu/9Jlvwm//CHlL30wnJ07T29Hmkm4d3MsCQtbXCTWjG4Ga5UTttlZZMQIDiJO0sod/xwSOCPX2UFDiauiAQKrSw3Eq9Ukn9GLPRUU8lT8GN5epRi34RRqz6RRB0s3FGi9YWReu6pytABQrW+eRppKQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881887; c=relaxed/simple;
	bh=x96bTXS8F+aB1rla7loASjmyzVz5XNs0swP7HCQFz9s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ChwyQz87Dn0AJhvRftnIH0iiiFeipMEakZs7ZLeeblh/cpU3bjs1JGiPSltwICAAWeDHplqnJtZ3IephQL80oaSZTTw+ZbLtvc4asnzZ/WiWYPj4QrgTcno0MxECUTo8EGnUuxmCpyceaijgRkpJEfM4Z3eUfWDZJjwQmTutVs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx4pq5Yq; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736881885; x=1768417885;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=x96bTXS8F+aB1rla7loASjmyzVz5XNs0swP7HCQFz9s=;
  b=Jx4pq5Yqs7qrfsLVFTLAmkfr59fFS7BCc/haPeo+XF0xyCl2WOpt3fyh
   pvmdKp6O2rYqZKAMvD1u3HVUiHaKbNoYhmaxpNb+Woz+C3N6OYfF/XoP2
   60dnOV+T3emdrNh+o3lKqm0kSHrImdLSxNocYCb7YXUoPhNyWP25HfbRp
   JPLB5ulxSIO5Jk6FMAndAvO4OmrD5GAS+W2yi1zLXRt0EpLbwYW+vFpGX
   aySqt3APOZIsD6OjHSbxsVv/LSzBPmpOYNkFJG43FrJIeXL9cnfJxG1pU
   nyNH5ckpi+eBy6J3KFiU/vmcacPfXSXDWekUYScS/sIj8MRm0f427a0nn
   A==;
X-CSE-ConnectionGUID: ohk/pMq6TIOyT7ACNH9grg==
X-CSE-MsgGUID: HCxdLmaOQAa77TJNH8T+Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="48196251"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="48196251"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 11:11:24 -0800
X-CSE-ConnectionGUID: WIwNKjpWQNSAvnHyqzlD2A==
X-CSE-MsgGUID: aY8unT4QTeyQ7n/HyCyfxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105388487"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 11:11:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 11:11:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 11:11:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 11:11:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y60f158+vhBLCVlYeEzUsjtCdCpyyxwTd0GNU4W8uz3Sm+ushax9WrRviG+nKqrw6D9qpSnU4KrAZDVC0OgZJJHfSHxPkIaANgWHwfzyKf5XE0RMRYLd8lo7jJdVdiQmlYDiOK90xKL+Q8uXR6jOc48aavp7vnQVtSJNAkKdFhKQNL7bkPq5KGEx04M4Kbl9xKfpRb6vPC69RxNZHDdfQVdvbMwzG9lNFU3NtkbjuItOijVjpmGipAMgzQIDUltX3fqQk3vu/nAggp0enzB2u4KKpyIGojX6ZeAdD8xLMRFG0GOaRR8Sm7ABS9YRvClI7qJH6TEs2mrUtn//j34X4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myNyQUFBnItbIxoD/JtjDu/z6+OEkDpryaIDUw3V398=;
 b=kgDugOIGJSSxbPCnlXj1trS6hlafdN5+3nYftrdcG+g3pK+ytvS0qFlshN92PS1Sz0kFaSvpn/b4XRNzE2ZN7CVHrWolPgv1H+QC7XlXgYLxFUKSAsrcgZqo8l01KogWFVNfPc/RELt9e/rXSvdhRNsfBSRaxs4TxRlEsy3cqaMsMVNvJSCMUv/OUnXEsf9CNVl5zje6EmSikoGUwwkefY+psh7ITpJn1s+/5eNs3+thM6E25OeC1M4nE0a/Yz7xdnffakUso9DtUCOH/TRn6pDOg0GY2IekQuMViQ3LbuqYz5l92mn4gA19wOkC1VhS0RBgJa3cGjdLsJa49HaxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6364.namprd11.prod.outlook.com (2603:10b6:208:3b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 19:11:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 19:11:20 +0000
Date: Tue, 14 Jan 2025 11:11:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: <alison.schofield@intel.com>, Alistair Popple <apopple@nvidia.com>,
	<lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v6 25/26] Revert "riscv: mm: Add support for ZONE_DEVICE"
Message-ID: <6786b6d426b83_20f32940@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <4983dede0d60686508513b3d9cfd26aed983fb7d.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4983dede0d60686508513b3d9cfd26aed983fb7d.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:303:16d::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 010ebd39-2ccf-4f16-cd98-08dd34cf3a9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?qEUFFyL+aGwOZWp03EiYMKARO02g4//k/XDdBxbznhpOjWlYMs05sWE8p0?=
 =?iso-8859-1?Q?DJi8V4hUpAZHcjEaXTWzXaquG/mF9UNIzmExfjtdKgbytqg0H9540dHdQl?=
 =?iso-8859-1?Q?V2VCHzbBD7d2iQoeiU7kfRkIp6MMAB8CKpXRTkhdN4Vj4nDpc68k/7WuZs?=
 =?iso-8859-1?Q?iipHWN1nuToyC6efa/WkMWtGl91P7L+qDvN8Xhrreu32RvS8sbHztdd2ug?=
 =?iso-8859-1?Q?NGMFQpg4bj0L3WKUUEuZxUkc+MSoYeMz7KmUHWsR2BmbFSy9WNbm1dX7L6?=
 =?iso-8859-1?Q?HgBNeB1bCwK7oJRYrZN7pohc/+A96Vxm9X9TYZdQpNsXhyJ0eWUv7zZwhy?=
 =?iso-8859-1?Q?+n8tyNIbDAPB2GpKtJ3NJVBZft/C6hGlvAaUkRukKC5nqPld9+he4dDUb4?=
 =?iso-8859-1?Q?fxWMuno2i4/CGlAWSgYeVUrNw7653tBCER4zo1UsaPqlGD4dgeYJMEZJdR?=
 =?iso-8859-1?Q?xzRk41iu/3+6mDR3F2HZo+lAjJqoGsPpfkxEaVNXpmTw2FfSXKdpKM/O8D?=
 =?iso-8859-1?Q?7RofJ4DPFZHo5BVazWSlze1BOfUIxUOsuAtDVed4XUI/7GLkAdYCNoTfda?=
 =?iso-8859-1?Q?wtagXWdwijITuk0i04Sk10ydIFxdYy5r+InCime0Kgb9QMQArDo492KPR4?=
 =?iso-8859-1?Q?yxPsumk+Vw488DJpbq/8waiW3Kw0dW1A1Kjh1VVOahwwdwgzc5kM8VPBx7?=
 =?iso-8859-1?Q?EzWhxQ0KM8wpvUMdrIzzkg7OzGH1we5n6Nk6iq0kgfPEmi8PXtosAZfFON?=
 =?iso-8859-1?Q?fhl5pg3IG/fJ60VTy+cN/7Guk8rqfBgy0axLHUaYi5anZ/DYAjKgqI49ed?=
 =?iso-8859-1?Q?c6czUNsX6fzGXzp9iUPMVe2qv8zo5OLoc4HEowAjUhpER02x1XB+hiox9+?=
 =?iso-8859-1?Q?Q/4yMnOGZJblrt94FQsNYnEcIDppzq2PRD0AkOcxqDWMonzbLe3fGsaW3V?=
 =?iso-8859-1?Q?rBg6xKEivvAxXlGsxeUMSWCBlSJZCIh62uSRXZyTVjx/7WN+zm9reckoZ3?=
 =?iso-8859-1?Q?953xiCDAu4aAW+Q1uJKX7vfAchxouorjAmXD8EVKdQO4yPph++F27dfUad?=
 =?iso-8859-1?Q?Kqa7IQQhwWXc9K3IoX/xCBqHXop+8viaH1/GyIE0EZsqJm381MczkwG1Xy?=
 =?iso-8859-1?Q?xYKu+7Xh71VyRI4wKFEN+pA49eX/OODcZ2rhshHKO0tyVnNIniw0lz4NbG?=
 =?iso-8859-1?Q?/wdT3abbuofgkj4teNCkgARpsHs5mU1G66/1Zy9WNnex+lbonDf3xWA1s5?=
 =?iso-8859-1?Q?Zq/IRal1N2UUiuvqVxtoSPY3vRt4LeVPf/Xx27bfJ9lfmKrGfvke2MtLR2?=
 =?iso-8859-1?Q?418XyCB4mmrQ2JS+4AR9uI4zH0n6OzPk9CNMvmSJKeOoQDZQu+H6tpmC1p?=
 =?iso-8859-1?Q?VoeKn/NMdig53ddYwlv0o1ssRrcMkg0j/DYXtisne4tBU6z9pyOkg7kL6N?=
 =?iso-8859-1?Q?HfhPtHgdY5bIwyGy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7b4ZyheY3kiOC3epwTLh5YapdnnHXLtRl+DckpY2b6zeMsEZ8FkWCtdFiX?=
 =?iso-8859-1?Q?J6RiuRJZWVxX2n7SOTNTJJ0PBLbHf3LrBfFUEC1xy6QODAaGStRjFqcA4E?=
 =?iso-8859-1?Q?FBkko0KwbbUGUwFU6YOo8yDOsysuKPkE7YsEg7KCJ3vaV9OLbU+62LpoM7?=
 =?iso-8859-1?Q?LmEWBUfkcNfG32Qpo4uF5jpqFv03yC+PxM9uT9JvHtvF/2wAGXpicfZPOp?=
 =?iso-8859-1?Q?cIl4CKx0g5nm5vSPh2uIzO9Fs532e/ezX33/Qf2Q0yuveuiqDR7/zWdsMW?=
 =?iso-8859-1?Q?j1g7wIIzNcN8pGzSziWi07CvlCAxgmNctApfwRSODTYxKP81n/pHmaBSL9?=
 =?iso-8859-1?Q?Acfiw9B10asTix2ExoT39M/91QED6pVLVBr5aah7nyVUlq+0AAXabZiZME?=
 =?iso-8859-1?Q?BkB+IyA3R7Hg8IaYt4PHOZvBBAMaeK8kUPdHa9lNF5WqkDfrkGeQe1gEEo?=
 =?iso-8859-1?Q?slOsak9kj/ZVIBvp/aLPyYCSdWLB4HeT/48aHo2qH4cTYJFfucqu9OTGxH?=
 =?iso-8859-1?Q?ivKnzFMnzFDxUruSqhxcNZARM4dkqZP6U1mIOt1bzWktjhhHE+KeDp+ZkE?=
 =?iso-8859-1?Q?f+75Hf7kr6FHEUWEOGXDx3Gl37kyh3Epe3Zm1Y831hLge37P9iBRATxjcQ?=
 =?iso-8859-1?Q?4YwhFwhb+cuEyDBYEqIKAlYMZ4Jht71W5dqcoxKcZx/6nmvOhf3VOQLjyv?=
 =?iso-8859-1?Q?JQZM2/mr1eQHT9gI9C9QmARNhY3GcdbiYszwapv/LRh1UIHfRTPJ01RmxF?=
 =?iso-8859-1?Q?KS2E9b62GxWHOBB+72LcRSej6T6IvOGGjwz7Mx9I/6Rk7Pu8AM7WovkpcG?=
 =?iso-8859-1?Q?RdcvzsThLEgtEGhww6upnvYqdcywFACeCm9yGw/Ck6h7BDUb9zD92ZvV9Q?=
 =?iso-8859-1?Q?qetAzXGeorohSvRjeyOmmJtIuohDok6uP9Qnoi/np5ZO7xMW3Ldw67KMet?=
 =?iso-8859-1?Q?7TlhCI9lvwUuw4mpVlBD+zPqrQulLLWuwCxMJGS6s4kiHsE8UXqfT1bhQd?=
 =?iso-8859-1?Q?+azRWH3Si/pWYo2A2bt6OJ+q8wUeapAmHrpw4uPoAGjxwj0HebPwCOKBo0?=
 =?iso-8859-1?Q?zFiLPwQLfyU7+w5689NvXE+/2DP0ZOYXH7M+MC76rGbIRvby7M4YVkw+sq?=
 =?iso-8859-1?Q?Vkj87Z7Olyr6RWn2st6y6BVSvciZBbcd71vwMrsVhxDdW7F5Oq8cxaQDs1?=
 =?iso-8859-1?Q?dT7b3Qg5tsfK5nFvo9wvFi2E4Sw5EWO4fsj0bxAJFvWAAjfx3YDnCrSZQm?=
 =?iso-8859-1?Q?68LhHKwEO2IV+zSKdEV1+B0wIeb9b3K6kZXXYx8V6e+yGC6G7881kboGmR?=
 =?iso-8859-1?Q?kQs8z5fMSz0Bg3vRT/cRypWMS0vxqtcxR+ydcZDP9kyYf/SZm6Jrn2SXnA?=
 =?iso-8859-1?Q?fbuKhpEAEZOZtYc8vyB2UmRw15WYh+SH8uSWJSMdUbJpnUGeHkgQRK8uJv?=
 =?iso-8859-1?Q?2D/lXUBb4EF4+o4o4DoMXVreO4c5Qp0iT+zDQQe/iQThRuwI7K8LuutMpg?=
 =?iso-8859-1?Q?BaXsXwMk43kJVP8uyfqArTguqe8zYP4nqNt36AM3AXD6qDLecDVXojBYg0?=
 =?iso-8859-1?Q?YkguVD2PXE7oB8yfM2ohliqmU/kI34TJ+gDdXgChjKUSAOluQK82q5wNdS?=
 =?iso-8859-1?Q?QbXtZe1tiR+gpwk9/NSAU0grVlEhfhTrh+QzTyjYtAM7P3XT0Xxf3Tcg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 010ebd39-2ccf-4f16-cd98-08dd34cf3a9d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:11:20.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9wDK9JijPeeh0TuZkbMVO4+3QjbazE82bM0VjDLXF1SQ7MeHenAFPjZDsKBfuB8KaF8pRPbY4gRpCH5Y1f4+kCQZkKnTyBHyw43PgDR3j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6364
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> DEVMAP PTEs are no longer required to support ZONE_DEVICE so remove
> them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>

This and the next are candidates to squash into the previous remove
patch, right? ...and I am not sure a standalone "Revert" commit is
appropriate when other archs get an omnibus "Remove" cleanup with a
longer explanation in the changelog.

Patch looks good though and you can preserve my Reviewed-by on the
squash.

