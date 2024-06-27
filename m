Return-Path: <linux-fsdevel+bounces-22603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CAD919FBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 08:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654831F26FCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188C147A76;
	Thu, 27 Jun 2024 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXIZp/96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5446557;
	Thu, 27 Jun 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471533; cv=fail; b=HRLGimOIBw/14Rj7a9yqam4EkOD2/bJXV2j0PRsLsrkMe79kK2UHKXYFicB9iApT8aKblSSQAV38YiPhuuOFigLr0gT9E0/3a89AnBe8dTOceIYEasl63abggD8eGMNV00xfs8V5nRCudwoDswQqtVy/sUnCO7+++kXGcbIymEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471533; c=relaxed/simple;
	bh=AjaIF9FRSFNp2jEOZesqeNefygNMFQqmu9woCEDobDE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QvlRvkURo8Vs2Gnv9SyiMOOA918uUUl70eDFhhF+vxK+aTbg2fphCR5hBydsq1PHf9WMsvsYe4i968tnbRFFiOpgMpdtw3F8JvaV6cSwLtLUxuuD6AqlqFFGOYBSbfv0vphZrXdFXcQpw0iHTwc+G9vF041DDIMG5lyAOZJQbVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXIZp/96; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719471532; x=1751007532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AjaIF9FRSFNp2jEOZesqeNefygNMFQqmu9woCEDobDE=;
  b=IXIZp/96A0h44I2UgVY2IhaRen7wDFgbHUS/AxUZNbGQ5FnEecfaKK5l
   ZBRa4MQ8EH3qQh5GCpcFPqxRJ6sxN/f0jPmov0t2ChEn1WJkaYzQX7eTf
   boeW+UHLhxRPED4x6Deo1igj1/zBiAE80e1nMsn1uw6/dDyO7Qm2ZMPvW
   EXOTYPCwdyT7XO5E47p5VJPKuBqWtInudVG8qFOPED6n78rkZrduLINgX
   rrfLVJTJJCnwRISaSsIx/YBkYuVCgnS9+ziXJKAQ7e6nvfM+Q2A7hnzyF
   ku6fKFE8EufVZNezHxtU4KofHS6Cc4loQgSjQhndscqSRcTX3XpQExIin
   w==;
X-CSE-ConnectionGUID: C42V0LcUQ429q1Rk0sZygg==
X-CSE-MsgGUID: o7tZEk5NSPCyAbApvtJ5QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16322761"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="16322761"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 23:58:51 -0700
X-CSE-ConnectionGUID: bPthUCIBSPCEWXesShCahA==
X-CSE-MsgGUID: UQ9jmRvBR3G7ZCXfS6vVgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="44921530"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 23:58:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 23:58:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 23:58:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 23:58:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1p6Tq0ufYAAKB9XcETN1Am0Nk885WmoNmERaXDpMlzPE2+5mqkYOOj/y2PW14nOUAcAoYTLVOhCmuI8x00DPdNeX+sY3SlhE8bD49mnkb6be0trAHxsjtd4Eq6HlXJ5eNf6O8YkG2dMGJjMRT9tJizKhswOoxdnHj+OboUJwuYW/9f0d89wEtrrQoGfJwu0rF31cFc1AwtwEcfwgNMDpwTYEHky+SyQiRT0Gz4gqpGQNjyNYHkuBY2e5Zz41go+CybbatOM/prMNfjpEfVzNU9kdccixHwnO0WxmFLnDw9vbMe9xDDijbElB9cMc4QpmNEK9oSVp0t8JEUsL6g+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=totcL5xQ+eFrnJPeVR0kW8okHJmo5Ugz6u8ZwRAbw5c=;
 b=kFBy9LbFlgSBOG/N/2pFFFjEaPOmO+alHZX0Y75Sngiy074/qyZ7AI0VcUs9qesmzjVxKg2atE528LlZlT7MseA3VORkokHukb3TqWAf0GGbUt7zqIG3+i6iXsfVolI7TqcIizM1Fk9RiUSOAAxGiXLsBUuuFGrtB67PgF+Tej1zIV4rIyfGit6madx9OyZ1sZnNb6aJhR6FJ6/I1Cf8oiCm+BpP7w19XNoyS/XvwXW4jHpqeLUqQXi702e/OdhqO3xq92qn3G4g3I0Gdgaai4LvZWLh2IvS9rt5GeV8HvLXv5xRdmWvNTGg3p2F7svJsu497O5nGvnYru8lk8PXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20)
 by PH8PR11MB8257.namprd11.prod.outlook.com (2603:10b6:510:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 06:58:46 +0000
Received: from BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::6f9b:50de:e910:9aaa]) by BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::6f9b:50de:e910:9aaa%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 06:58:46 +0000
Date: Wed, 26 Jun 2024 23:58:43 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
	<bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>, Alistair Popple
	<apopple@nvidia.com>
Subject: Re: [PATCH 00/13] fs/dax: Fix FS DAX page reference counts
Message-ID: <667d0da3572c_5be92947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To BY1PR11MB8127.namprd11.prod.outlook.com
 (2603:10b6:a03:531::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR11MB8127:EE_|PH8PR11MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 62072add-aa1e-47bd-acee-08dc96769733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gALuLwHM1CuEPJDInG5XrfhDlxZPf7ImZQpR+tZtmRERLOYWe/gHWqVtUvSQ?=
 =?us-ascii?Q?MuAszq/SHB/qUHA9hKNVPLgydpr2UZRl7nnPdoQJe4QnpnFSrhL/ub41UrRD?=
 =?us-ascii?Q?lz1p2WxosM+8hlSDFmC+fK5+Ga1HDleXVZ0xmQpj9LCK+MAi8QrfXJUHMkOy?=
 =?us-ascii?Q?s1AhCW285T5MkcCYqpzhmH6DrDb2BQW5Dqt++G7I/3SmlRSQAHfWQeA/bYHg?=
 =?us-ascii?Q?kRGYlMw767+hJQuicarMegOy6D1yIrFeeAc9rFN/ZvSEsx32CnrFcIEXZY6m?=
 =?us-ascii?Q?4lN8JHi4IYDDiiKkuf5GUB4vairOpKGgH1zPW22dIbnFXdiNwTitEhVUJ/56?=
 =?us-ascii?Q?HNmfG0CPkCALkCiXdE42ij8loSXfssa+nUQtLytGpNhxHMJ0ASx8AulqfAwR?=
 =?us-ascii?Q?NjleYWIle+/YovXIOycYL5grkpviCJeJ/WhY8TheQ3fEfakUDZ5IVo/cfvV/?=
 =?us-ascii?Q?P2MjK5UQjfMme+EBOkzhnxkZrxcC6e67fKgH4Ssm5awi5UtvpaWWisOzfiPQ?=
 =?us-ascii?Q?vqiQbsh7mGbYuYFCr8qIwUOIFivmLIoh4N4eqKZNRCBMDZfRnZBlTWxiHna5?=
 =?us-ascii?Q?hfEYvCBVVQiUcvxLoa27Zirmee9zY+T6pjWjNK4HlLpy1YsCVkenlYPrtOGE?=
 =?us-ascii?Q?+gQYyNrmxDOPxAzW1EccQuiMVQ4UL29rKRbQOBOKJPtuSxtxfAP4B6Qxjfvj?=
 =?us-ascii?Q?BK9ztTgXxGiw4KTKcyVgTGgn3nyvgvatTNuyE11SOGXZIWQch4OIZR5sG7sx?=
 =?us-ascii?Q?ozmFSb5DG4V012sgc5Ceo06ET3hJCZMeIWNz9xHEtPju5eu7qaXnfc/r8ZiH?=
 =?us-ascii?Q?gVf+UlJkT1sqMpBI+lIjY5h1hjOLDz2C5IevB8ptZJlKahdwEr+p+FyGKdxc?=
 =?us-ascii?Q?//3TeliX25Y5k1l+iNsKkXO927XQ6VeaK5o4Y2GZYxPKW67dheBHkdoZDOoG?=
 =?us-ascii?Q?SuA6oG0RWAIUjFADPS9RHinL0pDNa32xfmWqjycIZUXQYmKuQJd8Hcxjk4uU?=
 =?us-ascii?Q?ROWh8JAKsCntrxFzOHETOjq4N4GB+/pu3ZCK08uFxG2qNA+naoLMY4WtghLf?=
 =?us-ascii?Q?rWVdEDSWleqH5fljD6Hgc1CT50Fpo1Tr9Ml27aNUBeN6lWB6lLr8QmmY33eY?=
 =?us-ascii?Q?X1y0Ke2PvY0xb2mRGDWx6tuva3oxZzhVaz7k9Ml7qZgclCRMCbf+8Y35VPr2?=
 =?us-ascii?Q?ynatLoZFfciY+0IggtNVMPEPaZc6TCoi94vn0zwEr0HFUz9fIXMjErBFKO7t?=
 =?us-ascii?Q?6g7ip/qkkihFwz37P9mRwpTUB7EBLK12KoY3P+PMaNixgz29C1udcBkrrSAy?=
 =?us-ascii?Q?FvY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR11MB8127.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+UPHUbSiIaDjtu9MVS3LHTJ1TKD17M6TXIz6T+vYsoVbJhemP90SdqQCbL9?=
 =?us-ascii?Q?aACv3a+Mnlp0qB9XuyzklKOJzSPLP1O22DC4LAqpkcOZCAJJLup6pVo/xkws?=
 =?us-ascii?Q?5cOMD/GVPdDRAY4SlWFdW3FgEQtaiqfDYwTuIwSicl0nkfmR84jRC1tbAyGP?=
 =?us-ascii?Q?9MCL24Yyh6b5eeM0XGGzX4KWs8VyJl8ti0xeaHIYZXoHp1vSt57AGjU0ERiU?=
 =?us-ascii?Q?kqxlr83bmEKnNo4LEjznR10pts+5LyiJvOfat7iqnp2D0dPnJMm+8G64Lr2b?=
 =?us-ascii?Q?T9XrxkENKjh0VeWixXRVjeFzMECwaMDzszS634/wGrzrUe48LOiuPd3Ka12F?=
 =?us-ascii?Q?auZKMGRnxlBGuIHdwHcecnM3lyu34SbV8BcD67XdSGkVTFskQ4AFe3kQqauw?=
 =?us-ascii?Q?Rx4S5JPtTJaA+jYInZS2S3d4NoeCZuZlid/cKnfHm7C2l6Ie9CbmGRYT9JMQ?=
 =?us-ascii?Q?NU0q0bNjRf+t5pmYzUuGrGymU8G4G1oGvI+3qddr0wj8No/K7iA4ZEIim7d9?=
 =?us-ascii?Q?fmF/v5rIz2RZUOdDdufkGsOkOoyoC6YCKfuSt2pwJyEVXujSc2zbeM+GULkm?=
 =?us-ascii?Q?wbrgaDSYw06n+4RrfdoZfSf4+2WF6Kj+zjm/BSgiaTbp+uIpCbCMZUlWfDyF?=
 =?us-ascii?Q?VVX0QLHxW53tGg6z5WYsbpYJz4zsB8lIMRbbw6oVEw7pRXaynn94zMlPddYJ?=
 =?us-ascii?Q?V272ldp9VH0zNWZ3tEHdxNtt17yphxaNvhI5Uw7YkaOd9xwviA5c1bzcpxX2?=
 =?us-ascii?Q?U79M4agBnuG3CONjAucMWcWlnT6AK9KkWH4yp3mB6uUfJQ7ptC/Spq+AztR2?=
 =?us-ascii?Q?W/9ads4r/1748rLsjkWHHAZWQcbXqpcxcBr0TBzDBiUAkllmJpN5DtQlgS7X?=
 =?us-ascii?Q?j8ZUseqXoFL9F1Y9sKzwtGdUZrF6pdtu2r04Yjhagfem3NTkPI8jpp2cuDTh?=
 =?us-ascii?Q?MoFYOTQYnFYDaSvxJEGb3NLHVjUXu2lO/zxnT7gAyvil9B2GFWjYeU+megjW?=
 =?us-ascii?Q?036w0vfsxFRZogbj4EhCm/eek3/4yH99cvHTnxwqxIKplSsln5Sz/eoFcoFv?=
 =?us-ascii?Q?557UbJXyOgg36wHI8Ro2oXdddyo293vQd0vRcbTeWG9aBSM61xFyyv5QMg75?=
 =?us-ascii?Q?7tKoIxa7klbzEapWD4Bq58JeTJRI8A/TqgDbSQMY7wXmGoB6pTRfSWDe1dXH?=
 =?us-ascii?Q?4BiZFTlwfTn85NuI+bwRFLjJxcH8Do7pEl5E/Wb9MG5kSrb8BcBMLdjhC3SA?=
 =?us-ascii?Q?tQ7Un5JQUqWqQ5MrM9hrI+LrQdYUSTdLa6JhecJakwpa0fOvnmzUNGXyXS4y?=
 =?us-ascii?Q?ilLaC57fUpytyPatMdGYjfb/3atNa/XBI6vtiT/E0SkcdMax/9/R1yaAcgrq?=
 =?us-ascii?Q?wB23w9pwYn3jqDSD5Dnh7PyzBaOSkNO4au0gT6iguhMp3eaGKd1D4NqX0UiO?=
 =?us-ascii?Q?FqStEnqSoorAea1O8CAVVTvNCMYgVn+a/qP7hC5575cYHSlJ0ESZumdB59zW?=
 =?us-ascii?Q?QOIiczkWErfYn3DtavRktxMUewPVc5buYxuRLhqvVKbCft4BRJ+oBdWv/MlK?=
 =?us-ascii?Q?yo+RKwpVqpwE/3dIUsuiOd4d+IUpFEbhF11pg1ADzeX0AXslMNPRSNc/iK4m?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62072add-aa1e-47bd-acee-08dc96769733
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8127.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 06:58:46.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T10naUCnWfpe85xnL3jej7qpejXKci2706YAn5zzp304goOqV0ZA7FndmOR6Xw91Rvwc3o0Rx9QBWI6MoqB+ABSrwlMCGnVMg1cWd1e4VPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8257
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> FS DAX pages have always maintained their own page reference counts
> without following the normal rules for page reference counting. In
> particular pages are considered free when the refcount hits one rather
> than zero and refcounts are not added when mapping the page.
> 
> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> mechanism for allowing GUP to hold references on the page (see
> get_dev_pagemap). However there doesn't seem to be any reason why FS
> DAX pages need their own reference counting scheme.
> 
> By treating the refcounts on these pages the same way as normal pages
> we can remove a lot of special checks. In particular pXd_trans_huge()
> becomes the same as pXd_leaf(), although I haven't made that change
> here. It also frees up a valuable SW define PTE bit on architectures
> that have devmap PTE bits defined.
> 
> It also almost certainly allows further clean-up of the devmap managed
> functions, but I have left that as a future improvment.
> 
> This is an update to the original RFC rebased onto v6.10-rc5. Unlike
> the original RFC it passes the same number of ndctl test suite
> (https://github.com/pmem/ndctl) tests as my current development
> environment does without these patches.

Are you seeing the 'mmap.sh' test fail even without these patches?

I see this with the patches, will try without in the morning.

 EXT4-fs (pmem0): unmounting filesystem 26ea1463-343a-464f-9f16-91cb176dbdc7.
 XFS (pmem0): Mounting V5 Filesystem 554953fd-c9f4-460f-bc37-f43979986b68
 XFS (pmem0): Ending clean mount
 Oops: general protection fault, probably for non-canonical address 0xdead000000000518: 00
T SMP PTI
 CPU: 15 PID: 1295 Comm: mmap Tainted: G           OE    N 6.10.0-rc5+ #261
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240524-3.fc40 05/24/2024
 RIP: 0010:folio_mark_dirty+0x25/0x60
 Code: 90 90 90 90 90 0f 1f 44 00 00 53 48 89 fb e8 22 18 02 00 48 85 c0 74 26 48 89 c7 48
0 02 00 74 05 f0 80 63 02 fd <48> 8b 87 18 01 00 00 48 89 de 5b 48 8b 40 18 e9 77 90 c0 00
 RSP: 0018:ffffb073022f7b08 EFLAGS: 00010246
 RAX: 004ffff800002000 RBX: ffffd0d005000300 RCX: 0400000000000040
 RDX: 0000000000000000 RSI: 00007f4006200000 RDI: dead000000000400
 RBP: 0000000000000000 R08: ffff9a4b04504a30 R09: 000fffffffffffff
 R10: ffffd0d005000300 R11: 0000000000000000 R12: 00007f4006200000
 R13: ffff9a4b7c96c000 R14: ffff9a4b7daba440 R15: ffffb073022f7cb0
 FS:  00007f4046351740(0000) GS:ffff9a4d77780000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f40461ff000 CR3: 000000027aea6000 CR4: 00000000000006f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __die_body.cold+0x19/0x26
  ? die_addr+0x38/0x60
  ? exc_general_protection+0x143/0x420
  ? asm_exc_general_protection+0x22/0x30
  ? folio_mark_dirty+0x25/0x60
  ? folio_mark_dirty+0xe/0x60
  unmap_page_range+0xea5/0x1550
  unmap_vmas+0xf8/0x1e0
  unmap_region.constprop.0+0xd7/0x150
  ? lock_is_held_type+0xd5/0x130
  do_vmi_align_munmap.isra.0+0x3f4/0x580
  ? mas_walk+0x101/0x1b0
  __vm_munmap+0xa6/0x170
  __x64_sys_munmap+0x17/0x20
  do_syscall_64+0x75/0x190
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

$ faddr2line vmlinux folio_mark_dirty+0x25
folio_mark_dirty+0x25/0x58:
folio_mark_dirty at mm/page-writeback.c:2860

