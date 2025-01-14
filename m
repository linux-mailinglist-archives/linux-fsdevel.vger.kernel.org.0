Return-Path: <linux-fsdevel+bounces-39105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2CA0FE12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 02:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15244169981
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C42253F3;
	Tue, 14 Jan 2025 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnMD3SB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE704EC5;
	Tue, 14 Jan 2025 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818084; cv=fail; b=X4i+wZ2y/JmI9+9uV1CrcgdxK11vUkkP+QAmBYaGGbCKZSBoUb8xfLx0x5hDmKimpRl2+B1PKCnvOLuVeg/Ix2VuQeL2eA50ztTxxmbSBrPMRr8bMayVEzQto6HPoXfmLbSbrB3HW6aSRAxTmFX94SMFels/qhwlPJen0wmDHWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818084; c=relaxed/simple;
	bh=WaI+aBeaxvufFMiBoVMCUjRLH0xFWsNBww4pTmYYqpY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XWpRvjXMnzufu74V2AqaA5SYGNpRy/HLoS1IalksVwWYEAJfjLP0Ss9HXmwHzCba6UW7aQ+Kpe+879WyKaf6mhbslpOYqsv4E8TOiLgjzDILC6T/WWbwha1O6QN4O8GpfaBPHqPdtZJwTFwC/vpYo0ENHqlupgInsuqxAulsxTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnMD3SB2; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736818082; x=1768354082;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WaI+aBeaxvufFMiBoVMCUjRLH0xFWsNBww4pTmYYqpY=;
  b=AnMD3SB2g/8Miumcd6EP97R01QGwgbw7yoBAT5CSEeNs+hMwK+/BMxT/
   vQh3JFvMVkT0vid+ByNO1kCBAIG12Jl0lP0tQvTrDImbawcXAQ9KL680h
   l11s6UtEktIj3jdxPxwdBJrMaopzjrgNoa9dMhsGev4fvGhIWU3fyYFdN
   0VBHniNerhZr25/SeCS5el5fMaWMhcPvQtEU4AmK+qLm0EXbxOLFaKH5K
   tASixZrfpXib5OEx3/CowWrmTiC+IDruD5yivLd09krbnYP6p4rmitisY
   4XbHIeGaWbokvzjMOixmCKn/UQVFIcDkrf1sN5Py1gSZLnmar78QTU3wq
   Q==;
X-CSE-ConnectionGUID: Z37ilu9cSkSzcGAdh5jdGg==
X-CSE-MsgGUID: oOMtmVWXQIC6SoOHaS/4qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47766293"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="47766293"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 17:28:01 -0800
X-CSE-ConnectionGUID: 1Qn4sM7ORMqyWsz4dVXJeg==
X-CSE-MsgGUID: ZCTm4DFwR5qe8R0EVOSMJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="104826811"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 17:28:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 17:27:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 17:27:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 17:27:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4TruQV50+rBvAWz/8edJgK/4bw0Vf+dTB385+SrCwWK2xA+DErGYC27B6E46eEawwC7rJpTq8Yxx+uLtxuWfYNLrHsly0XxJr3AsbUsJEQbor8gdnD7iwAYB2gWr8TheUogd/Jrhd5qKXz5lsQxGvYChZ84/KiCbwm4y4fcoKyDUsARptpoZlQoRgAO+zPnebfCDYYg2+bzEKAhtTbsTWfzWhyokwd9SZvP/si6LqLSbLHtlaoUvy5h3B68xv0l8xFRJ/QEyOHWy9oWNK1EfPNEXCbkEPKNZt/H4AMrIRn8RrWBK9WuI+W/1xeA3sNE41fRRrcDjjBUw7tQ7BAYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpGFklNadqMYkFWGmynzZAJUAqs6ixGQDL52ICkTCWU=;
 b=JzFmXtF28kcgDuul58tQjWTsVB3KhPSA0HEHkzWSPf9GvcrJh6CDhGtf5cQCrK0Yp9F/3MSaLM3hrdu6geDoJ//ihm9aD4nWUmHXPg5b9quHIXg0WLv21QdGxJQlv92tchiGfzX21xFkCe7xzoUgD844TweSMDtScQQ3SpoMjeDb8UwFDJ7IJDhNYq7NkJIiJJThwa3MXS2asQO1L0senAtweDSqMoT1ikrUfjfFtoi9LzY0AhiQ104V/hVsC4HZl67N5uMHGhMJxd8BUM8C2W1exds+rV+dlYKycWgtJJjtCI2bJ70AATL6tFGYaLgNHQlYynxrghTVaCjhP7DFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6919.namprd11.prod.outlook.com (2603:10b6:806:2bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 01:27:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 01:27:26 +0000
Date: Mon, 13 Jan 2025 17:27:22 -0800
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
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 15/26] huge_memory: Add vmf_insert_folio_pud()
Message-ID: <6785bd7a1b9f8_20fa294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <60fcfaa3df47885b1df9b064ecb3d4e366fc07e7.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60fcfaa3df47885b1df9b064ecb3d4e366fc07e7.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 837a4c89-324f-439a-7287-08dd343a9ab2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1oLzHMFz03ski3H+WkofF+kutmKwOezLstoAhNlpt/ZsHKLotalkiA54TZlo?=
 =?us-ascii?Q?QB70J9jyzVtchBxjyfJl6ICdTMfu4qEco6Bv+3MRf+sp+dLMAuIgW9Hcmgqh?=
 =?us-ascii?Q?aL33jUqkw1RKCHkmoaNMvThhXUAJz8LIoV7fQs5nWvfjY18jLbngt2d35inm?=
 =?us-ascii?Q?fcy8j+nvBUHijsMYmZisn3wpJlEcHZGxUadwH5SY/AoDko3uPTNl26tdD75U?=
 =?us-ascii?Q?bFCKCN1ApsY5Z3mpc6qEt5rfBv1SWitiC68UIH1Cz2RgP0BMMmpesbKi6WbL?=
 =?us-ascii?Q?XANrgkt5hBy9k/SOnVellnr8Dc1Ha6vnJoLiUuvoqLRK4qOJ7lukjwCek9k2?=
 =?us-ascii?Q?6SChsx4r3xIbsZNs1geJhZFGRwr5XO/g2LOPUVXmSVUj24YaYdTAaOQFHHWI?=
 =?us-ascii?Q?Me1U8OnO77degtub/ELH2p0dLvDehVCkeElPFSWX63dzc0oAszvqrQp1om/B?=
 =?us-ascii?Q?8YHrk3n+iNY+LBN4AAO9uqacf6VCShO9006lLFgcM0oIDUOKUGv9qomqn4/H?=
 =?us-ascii?Q?K+ra9VXI86r6UfsundyECU6mraZ5/iV4qHyNypoWk/16tzU2GA/sfkkUVZx6?=
 =?us-ascii?Q?HAEjXmW8v8MUh1J6XUme9iptCJFCbpHLdHNzaZtcepTB39CpYwsbIC/wGB9P?=
 =?us-ascii?Q?isnnNbYUE9C00KuqAFI4VynfIUqU7WRsE8aZdYzxnTSzAefeklpRlmN5ogLL?=
 =?us-ascii?Q?IIWppgpjNqtiPyB9KeS+yoraef/e8TDwJrazZGbobZlQ/l6a7dW+KI76HuFz?=
 =?us-ascii?Q?xUlaZyv+Uu66HWtyWS7yeJEcZnLnLb7akyTro8kxDhAmkXQ+S27nWy6FvzzH?=
 =?us-ascii?Q?hvvSzBWuUi2AxXUzQckOQT2HFGRkUn5yKGcvM97OfcMHMf+G9F0n86VMBTA1?=
 =?us-ascii?Q?C9qrfD/EUzFHfUR1n+S7okvcC2bexVfhI9Zx4s8wJ4E/GPw0XTOyxKOrBTzP?=
 =?us-ascii?Q?MTEPyIv95E1DOCAQyeIql8sacxW68mK/9MaezVXnTxL+vNL5u4qqYXrTC9Ut?=
 =?us-ascii?Q?t4zIUG8obySc2T6cHLg9OM8sklgWZMx64fG8HcoJinuaE3QGPKvr2TC5AVg1?=
 =?us-ascii?Q?SWNINLXnYZ4KP1LVCWpoaJhhyCFrOUvKLeI9gYfNNcaXaSfsmiQ/8A/TUULu?=
 =?us-ascii?Q?posBLl8+JGRp/pjVQ4LwCLWXWcJNNCzHjilnbnRFNGwzyHPYu4L0p1kQS7JU?=
 =?us-ascii?Q?eH+DmaPfXuXIBpKAaViebaGxUo2qzrfBxUDicrIiOQK77HPJ+rUXtVJz/oqz?=
 =?us-ascii?Q?9AVNBghKaE6W6Y0v1YUKmbzX444CBwX0qF/w18hBfq7iVnF9wAQINdtfO2Oz?=
 =?us-ascii?Q?Fr64R3H2ng2ePSLMZqoBZAklJMnP+oluthak8gSHqjrDAi1BgXoz019N/ys4?=
 =?us-ascii?Q?1f29kBmz+ge00t8lOXXSeYvqBp5+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rY7arcwxaSL4vUKdVOJ96my557I8Mt5OlMOr+gpFEn7QHokcLFcbthzsKD+A?=
 =?us-ascii?Q?07NfWYnER3BReBGf4iRsAF62jnhY5M8vtVlcJFWjlfsAx5lzwDLxM0whpDGf?=
 =?us-ascii?Q?BxF1ePvXHTNOto7Biju0N3rQXv3tRSvjrTQR+aulXYRGyusARnNw5OSTO+XW?=
 =?us-ascii?Q?D+aimFFjKPKAmOJ2blsyHVeo5wqAO3M3JYQ8ehLFHhaw+vCFWhPdeQ35sAfQ?=
 =?us-ascii?Q?9fLOZhiaV6m9UcGEyVoJXOcrb2a/LXCDmTguQMmt6/S6/nWoxOWrS88TRzoi?=
 =?us-ascii?Q?yNnUiJjh2spFrQCZGm2jAW01WSnmcHaOVXbb91lGIW7Pqx2rrJrWeSPkVRW0?=
 =?us-ascii?Q?xGxoQyoZbpHuHjRRDFHxcETKkXWI3+al0VhPoyIH64hjxlbKglcwdPH6V4TZ?=
 =?us-ascii?Q?4ThI6xLO9nIr5WPGMDyT4MZ8JH5rozgcX4gWA2zCMmUA2zUGCrIgNRpHo/ti?=
 =?us-ascii?Q?0D6mZAhUmdcn6Cu15xQS/nayjAXkTRi5noOuN5BzVLIy+ghwv5xpTEQu+58J?=
 =?us-ascii?Q?u/SUQsspUp5Hg2YeOiZDuJcVW7w/DZZgv3v8XWoii6ZVKzZW2s+5ua6mihRs?=
 =?us-ascii?Q?CDqCXVycPJOK9FoOZkQKKBSIgCcrjWBHeHcrkAp9IpTbfJF7CYgM7eWoByb4?=
 =?us-ascii?Q?4X3J+7xOtSWXrdK7Ve4Wwk/cVIvvtfxS41nnKwlDAlZEVuKrAgg9oQsakLec?=
 =?us-ascii?Q?acIcLu6oiQTReMQn4V3zpzumJA95+s9Y6aDITcL2E6c7QCY06SWJ/Z5/iNrH?=
 =?us-ascii?Q?dgXe74yz/TyfS9LcMOfVBeq49zkypuI431YAsJzPB5R/IVEhqA+/FffJ6MzI?=
 =?us-ascii?Q?V77fWh+I4I8/AF5nPKPG57ga437bkDiPkDzKRsoT3Qz51fJVjV41R6GJP6nB?=
 =?us-ascii?Q?YDb60CjntXn63o6o/1i8Trs88IL84RwMPOwhvfSIytnrb6oQmcYE2VGZRoJh?=
 =?us-ascii?Q?TAw4cvn8C8G8OuPwZo3bAL6FPGx30en2irO4osZtmlVupSoSHdisgx1QuJsx?=
 =?us-ascii?Q?Xuf1zuuf/stUUbWruG4r25bG3uAAgYSkyvFDaDAJeG0X7snLJryWP1TxBcTg?=
 =?us-ascii?Q?8MOU1VspSV3cRgodrVyQ6ckUPhtA/GTQdGiCiCyhVR25jPb2Ic441EjCEnr7?=
 =?us-ascii?Q?5Ap1rEzttm1du0ONxVZSBMqyT3Tu7Lsb+saJ65XtnKS9PSvy8dj6ys+sU/Q1?=
 =?us-ascii?Q?CMXQeumjZSlUyna66+lAL2/uSYUxYp/ah30pBzZWUhJwrJRHtMPlMFD8bwPA?=
 =?us-ascii?Q?U6PgpoDbaCVzNZJH7JPdV7N5h/H6cV/AAGtQ/l6QOqFOdqk3dXWWa8+VwE/9?=
 =?us-ascii?Q?tiCDeIB+WHSESRPxMpI+5sLQCKIpXnHxuxxCp/vMIVznyUc46z+T6OiZ+Gaz?=
 =?us-ascii?Q?qRw71EZLcks0nofudpbuXkh3v5sEIGHbWBOnRU4XcVApQZyeqW/ddT+ij5Sk?=
 =?us-ascii?Q?rpv70wIcP8WSUxVfmjCrL9gmYzE1u9sis0ZsT5oFBFTj7Qs01KCyS0aFcHZ/?=
 =?us-ascii?Q?eQh0DaSFRmCe9NEfnUKmeZBP4A2oJPMAMPg6BX2o+gwF3HdsGI8SNSktCryy?=
 =?us-ascii?Q?+6vuDz5h0N+xh317uyPQDtJJrTlcLe9xOhG3yLZt5W/1GiCDTzuU1zznW05d?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 837a4c89-324f-439a-7287-08dd343a9ab2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 01:27:26.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhRdWk++69eehBnaESxJz8kSMCw03heHD0tJQjcEj+PZp0Zrdm7ukp+1BTADWsmRWpGXyp1nAFjvEdbw5rgCDvo6IWoUkwns5wRmCBqvSLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6919
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Currently DAX folio/page reference counts are managed differently to
> normal pages. To allow these to be managed the same as normal pages
> introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
> and take references as it would for a normally mapped page.
> 
> This is distinct from the current mechanism, vmf_insert_pfn_pud, which
> simply inserts a special devmap PUD entry into the page table without
> holding a reference to the page for the mapping.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Looks correct for what it is:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

