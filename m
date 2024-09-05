Return-Path: <linux-fsdevel+bounces-28667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D034F96CC7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 04:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863752822BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 02:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAAC2746A;
	Thu,  5 Sep 2024 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHArBe+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8CB2107;
	Thu,  5 Sep 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502053; cv=fail; b=dmUmDGEpM6X6YVsSZIrgCkvj6AsaX/TGwphQcpokupFX0OtmRvLLUX3kWWkjBuFDfEX3QYvm343FyLRVW1a2TDkDPszIVhKirMI8/9NYKfKFr9IJ/yXBPpv2dIYCJsgjUCgmenvu7Fnp9Z1JDnt4NP+iWisyIerFgIJWgNyJRyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502053; c=relaxed/simple;
	bh=yMzZRnGvWTAEfU3FwUw9KXdWs6F8jrhBDa41eUJudn0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tPO5noWPKyESfw9oiPBcXOcMlmXRI4k/OKN+uY5zPDwlt/9p3mtq1tHomzGM3BgKar++o0T2MyC6Sps0scsEq7cu53jPU1RQ9DQbSG1pqS8kOA23pMcli9AdiqWaIuD+sggPyq2RX0RkL5I/VYvsXO9CjOdcQTCLY2PnM8v0rUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHArBe+p; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725502051; x=1757038051;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yMzZRnGvWTAEfU3FwUw9KXdWs6F8jrhBDa41eUJudn0=;
  b=IHArBe+pcViLvqeVfAF1Z9cPq/bIvWZBuXPuwhrmFRzrR0nChGahzaRu
   +eiG0mq9p5Hoj0n1ivH/oiKHfHS8k/Kc64j6sI7JaC3/aSZlZu4Ca2BXs
   8zn2nQ9DN/cRcvMJvK4QbgMGOHsdoYR49YzQGs27lfRX846sTnP67lmP1
   2p4Yp2MaeEN7rqJDxKHVN2pLfxWPC372onF7aNjMAqJwRA7cjhF+gmCQW
   tDxWAcOJ+kGKyaud16iVRFAm4yXiiRVcLeYhCBMmP59o2hWNgP+EdW+q8
   u2nPwnpfClvGyeAGk8WbZmBbf8raHV9Fq35azykFx1H5SWHVDco+Z2CVi
   Q==;
X-CSE-ConnectionGUID: mbBAiURTRQOkf5HjVUl+TA==
X-CSE-MsgGUID: B8GJPHGnSSOfxI0gVx+FdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27984306"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="27984306"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 19:07:31 -0700
X-CSE-ConnectionGUID: 9iwTt6ZmSomQebbd4KDI5w==
X-CSE-MsgGUID: pHJNbKQISgqSrpJpz6ri6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65695300"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 19:07:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 19:07:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 19:07:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 19:07:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 19:07:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muql1BkDA1RPKCKMKMUfyv83Zb2uX7Ix/TwiBagtGhQkwa9oybYgPI4JykrF36MqoFIw+h6tMykiaRvl0t4x7iMxzWcbqdpUh91guZDf2rIITyLRzQKYvpuV0jD+YF5g+WX34z4IzF7ci6Tj25iw9B9PWuLT9JZVlPbzhAsVXFe4ggovEgMoo+wUNig+b1r9L+rqU1IG3I1xip81fzA13GY+CAQQ7D7eQ4ObmRRT16HT4veD0cl6kK35fcnJlYMerQa7SCCIqKNgXNkpBJCEm4ZdUCNlXnp0ufX8T6tcXECzIVEqRWtMb2/S+qPUkJ9pKipm4OPZS2Zvb/WN318Cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN+kQn0yyu5S8xgd1Gj7lg87ABPtot/yFiV6cdKqpeg=;
 b=VOeFbXDjt83nW3+l7SqyotHjh7qPtkvCC1aGfqtmsTcWn/uZ7HDb6YgwyGTgVF4wSz/EbrmLUH405ZMQ0u1xJb0rJOhFJtmPdYpAi/3nenl0j8DJlZfM74I5SAS5z1vpjFe+pHpwxKZ/yZsrWxdFnD2bVLTfxNnkZJz1GusPKwV9JzDnmgqHju1183TWDbl+mrybafLCAxsUrE+y6AMHqn/fiCxBctL9wmGcwsWXChdoyc+d/iC7djxDlXiqf+Kg9ppotS1mOv4FfohadocHUmpwJbTHOyHNlwKJxRVHq0ykx7dc/BbDtzBSczVL3hqbKX5n0VgXZ8rLmS9Snr459g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 02:07:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Thu, 5 Sep 2024
 02:07:26 +0000
Date: Thu, 5 Sep 2024 10:07:17 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [brauner-vfs:work.f_version.wip.v1] [proc] e85c0d9e72:
 WARNING:lock_held_when_returning_to_user_space
Message-ID: <ZtkSVZ47t9+KjHGK@xsang-OptiPlex-9020>
References: <202409032134.c262dced-lkp@intel.com>
 <20240903-lehrgang-gepfercht-7fe83a53f87d@brauner>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903-lehrgang-gepfercht-7fe83a53f87d@brauner>
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0388d3-de71-4a8c-6a2a-08dccd4f7d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PpeLhTFp6eAZwG/0fWv9eD83zKjpym14slDW4xjxb1/Mt3VcGhGGqNyZuSNN?=
 =?us-ascii?Q?9b3/rLjEi61sMVaj8Q8y3kDlxKgqtIgV8TrSNJlZnr/R9cqcUxNN5FAVdZRL?=
 =?us-ascii?Q?LeSH7spW+RKDkKWquWnNNX05DPcNbXq/30sJvSKqS9oz8m3CMrBuNEOskawa?=
 =?us-ascii?Q?dC04p1sbgYhQATIJw5//1rmnK5BCyD7EXGrQAhyyS7Vg/zqnq3aFLtuvFZUi?=
 =?us-ascii?Q?Ye5LeQSzluUiBBEZg2ZV9JkRqkmO4aa8nEaQ96Gh/fMBgQqlB2Z+D/Z2iELn?=
 =?us-ascii?Q?ZL+qy3XOOF/g+yg+dTQ8FXMkg67mNZBwfHx78EKuNv64kf45tn3HLq+TY5ZE?=
 =?us-ascii?Q?2OuPsNr1krktAau9OVhTVnsNC+odyoGn9Sttr3RiYo5hjpvKUHMp37TohSPr?=
 =?us-ascii?Q?2wVBx8GX9mIys0EFemzjl7MOUCdnqjk4agiYKs4DNAju5LjVXZ41zWWgCfP2?=
 =?us-ascii?Q?y6UEu8+STSbXAbvXbMQrB49WeEjbd/t62WLiLC6JQBwL0BSapGMuvPZI2eq/?=
 =?us-ascii?Q?Sk3/7p+agqx/3pU+JaDjBdDgJpNxNaY46IWYgSB9h/iqhDpDiAeQIFOt1N53?=
 =?us-ascii?Q?eE162HSAGN9hiDw2z5S/LCVyRmhN9kQ2h3UO023GmHuLXk8kt61HpCuRpANI?=
 =?us-ascii?Q?EwCDsQ1z2gw6yL1Pk4jU1LXF23LMOSKJi9GB1xCLwVrC2OvU/bn9ofKiH0oW?=
 =?us-ascii?Q?CLTrdvUZGKfxrV+LOJihITIpukADmXwTuTA0E2lhdRjnMOUmH9NxxP52iLd0?=
 =?us-ascii?Q?ajvsnv3dC+nISoCF2LJJ75fosN41TvEPLZmH1dTJ7cfX6hPDkn8GHxBNBnA2?=
 =?us-ascii?Q?5MW+E5iigojV0ck+QrtgetTf9zHPr5Gy1WUFhwbsNgEHwS7aeBS6p2KmbiaN?=
 =?us-ascii?Q?8YTxwh6Y4jsEeGHD84+d0hX//pWncVyiI2dlzJULRwAdvy24dVxQB6TjgciG?=
 =?us-ascii?Q?OcnLHr0KnDPmjBEIMbsSLebMf2pfj7QzN+Wx2gq4tacTpy4y3FZ02niW0TsA?=
 =?us-ascii?Q?Lkt+17WYTprTKXH+NO4yYmm+DF5CTgQpAlaeUETl7WJER1gRMF6woscYsrcz?=
 =?us-ascii?Q?TaoJt4yWD5XkqlhQGK1uK3RdaoGzu051VZLi74ECVGl8zda2FEQTnpAITtTo?=
 =?us-ascii?Q?fvMp5ZljRHRvJE1auMJq/Wnrs29DCEqPe4QgVBbGjs8SYu0yp1bDfdCjikAt?=
 =?us-ascii?Q?xOoZ2QMsA8qZOIN7cnwiR7ew+bpCTj41cnbVaLtqjNXoRP8xplm4QZYOr6jp?=
 =?us-ascii?Q?+ZayaC1M0vvtoX/rqtjFyQwdansn/qhI7QL//c4T1S0fbxtoa0sHYUp9eQKC?=
 =?us-ascii?Q?QTBmM/RJBUCO3SDRbky82UTvkfOaq90kds5HnmKFMY+/7eoAPIvkjPXsJHjB?=
 =?us-ascii?Q?pxwYCDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zIIQN7glyNQxEsnFyw4PUVA8eFBMJZFxqU+ZvZfHKJTxljXCSWXB9E1quQNB?=
 =?us-ascii?Q?cx3C3HnSaSUmT8GJKwroBOr6K7Ij4YOG/xGX61xRqNryOafd4MegejYsjBIL?=
 =?us-ascii?Q?PX4jx0YG02p31YBQjsyJmeicm1g7SQqOxq7IEkWZYrqks7fCXRyq/9QkgNOl?=
 =?us-ascii?Q?QD96zpohUPDk4bQx169YN/eYuzEoBlFJNG6G7OSR5+XbUqOg+o/mOqJsdziI?=
 =?us-ascii?Q?68D47OpYDJFcnRryOuLBt4YGQW48aQJXsYKml71Doxl/UJX7tsGMh3NLfY64?=
 =?us-ascii?Q?twdSrDz8ZmpwXa0aOZrsPlhIhU9o7I7pOtT9N3urt/P5nIL7ESMJhZIJObgd?=
 =?us-ascii?Q?qlBpIWDCDdHsshGZdoLaHICkA+4lQLcLvvYPVkvsjj8amhoTPUnmryf4pLap?=
 =?us-ascii?Q?xNZNoGvAPbR1M19mBK9b395uQdpUFEx1DhnrUSp0uQW+r6mKLE3sAGgdfTGe?=
 =?us-ascii?Q?BrSGD6NxdqhY7s3d5xy1l7kvi9BqTRE5Ahr2090ZanI3eOkjLRqeJkuu6KFb?=
 =?us-ascii?Q?A+LawlIBzsJvppioHxRQyfIL/GIVTnnsTqzPboVmT/nn3715yRFzLkRfBu9U?=
 =?us-ascii?Q?1saz3HI0I87Ed6Ma1alegnmB2IncGfEGEGpBt4KWmL3iSlaEE3zgoJLno2Kf?=
 =?us-ascii?Q?afSlU3eh1j/IrQ3vPHcmSM2vIsDvvzhYi9bswT3TqqLISygG68AcZlzGQwuo?=
 =?us-ascii?Q?HZSJwWqwcffZsmCStZPH3/Tq2/KJM6TDF9lln5Ps/fhR35Ome7xLx15Kb6d4?=
 =?us-ascii?Q?LwXLaZvnGE0bKiOIf8PmaXAw5xxRXOSuxQPP1cNeGng43pcici5Tgp0eWcBH?=
 =?us-ascii?Q?dNXZbzbjtAFRKMaY5tAM2SvVOe5lowJSXFxJKMVX8aBld8KDL6T1ldjDrYLp?=
 =?us-ascii?Q?AGA8RMoX38avkCw8xvZQUjp1d80mThW5gQe7zasIzVP7EJ5/ea2+aQDoaZaB?=
 =?us-ascii?Q?ul/ufVYDHFr0hjbZnygVtZdROBuuGW3y9zNw6elyGqL6pXgr72hWbOFD1Ekj?=
 =?us-ascii?Q?x2ea2inlI1na0ButUAjPYEbQbY03EXsS+EbRi7bkeKZ9/deR5gjgEc3JwaKW?=
 =?us-ascii?Q?F3PFxlUTB6lw5fXB7+3UIksFnGWmrehaLU11ZvvE3g/47RlcuBpXNc+GOZoJ?=
 =?us-ascii?Q?M7TCHRF8gy5/KhZ6YEerZPKG0/vYtWbNYlJzhqpBlWA4DvEu4tPMWxlm/jwn?=
 =?us-ascii?Q?Jviea4e/nHoFJBUq0x7ytn9xrfeVO/kPS2z1t3aogEGE3R4WaSiKjKq97vKg?=
 =?us-ascii?Q?pjmqOoJzkbu0IwcNWyTLmNK0DmscE+C9Ahro9l/PsNesd1f2OUdL8AriKUqc?=
 =?us-ascii?Q?SOapYeHg8re3o+HrzY2MRV3Eb/7yxsOfpt3lRyi0bQBJNlbYOS45JwwMCMgL?=
 =?us-ascii?Q?bUYJ7C+moE+Wq+A+/1n8equiqYAvP9Vv8jWt9ZZbKoo7fFyhNXX+5n56cEV7?=
 =?us-ascii?Q?anGFw5tVo/6xXaSEXaN1Me0GLyny4Wi4979HwTkfSgmJpqT4z0SwPRIE2C5n?=
 =?us-ascii?Q?lc1P/RLIsRFpdKGxhoQT/m0kkUtXD7WDzc1qQ3Xzsz8idYf5pQzwjf11zbrB?=
 =?us-ascii?Q?FQJKuV5JejIuwzkJtJqEGKk6ny0CWxo0n2T8JNrz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0388d3-de71-4a8c-6a2a-08dccd4f7d33
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 02:07:26.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5CValjGiNPhFzuOyOZAY9iXjDONusK/vIJZvXwYWCD9gK3sVX8MXE/13eeDt25f0+xh62ugzGpbpdiWlJS67A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com

hi, Christian Brauner,

On Tue, Sep 03, 2024 at 03:59:19PM +0200, Christian Brauner wrote:
> On Tue, Sep 03, 2024 at 09:53:05PM GMT, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:lock_held_when_returning_to_user_space" on:
> > 
> > commit: e85c0d9e725529a5ed68ad0b6abc62b332654156 ("proc: wean of off f_version")
> > https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.f_version.wip.v1
> 
> This is once again an old branch that's dead and was never sent.
> Can you please exclude anything that has a *.v<nr> suffix? I thought I
> already added a commit to this effect to the repository.

got it. seems previous deny pattern has a small problem.

Philip just pushed a fix [1]

at the same time, we noticed for v<nr>, there are two different styles in 3
repos owned by your that we are monitoring.
style #1: _v<nr>
style #2: .v<nr>

should we deny both or handle them differently for different repo?

repo #1:

$ git remote -v
origin  https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git (fetch)
origin  https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git (push)

$ git branch | grep _v
  2018-11-02/namespace_br_netfilter_sysctls_v0
  2019-01-12/proc_overflow_v4
  binderfs_new_mount_api_v1
...

$ git branch | grep -E "\.v"
  cgroup.kill.v1
  cgroup.kill.v2
  cgroup.kill.v3
...

repo #2:

$ git remote -v
origin  https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git (fetch)
origin  https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git (push)

$ git branch | grep _v  (there is no _v<nr> in results)
  work.f_version
  work.f_version.wip.v1

$ git branch | grep -E "\.v"
  b4/fs-btrfs-mount-api.v1
  b4/fs-btrfs-mount-api.wip.v1
  b4/fs-move-mount-beneath.v4
...

repo #3:

$ git remote -v
origin  https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git (fetch)
origin  https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git (push)

$ git branch | grep _v
<-- noting

$ git branch | grep -E "\.v"
  b4/fs-acl-remove-generic-xattr-handlers.v3.wip.v2
  b4/fs-fuse-acl.wip.v2
  b4/fs-idmapped-mnt_idmap-conversion.v1



[1]
https://github.com/intel/lkp-tests/commit/06ab3e9c88486633c0fbf87748e302783df50f04

the change is similar to below

--- a/repo/linux/brauner-vfs
+++ b/repo/linux/brauner-vfs
@@ -1,7 +1,7 @@
 url: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
 integration_testing_branches: vfs.all
 owner: Christian Brauner <brauner@kernel.org>
-branch_denylist: .*_v[0-9]*|.*wip*
+branch_denylist: .*_v[0-9]*|.*wip.*




