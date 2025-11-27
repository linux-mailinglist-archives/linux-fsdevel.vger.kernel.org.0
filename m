Return-Path: <linux-fsdevel+bounces-69955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392E1C8C9DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 02:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCFF3B48E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E7523D7C0;
	Thu, 27 Nov 2025 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SssbFVCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574821CC68;
	Thu, 27 Nov 2025 01:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764208606; cv=fail; b=NCtYXB3QGxrpiyzca6nzoJj49Sl4maLp33X1+1ImaZOdpgiM2Mb+iq/mA/c6rsmqaeCYdyGVNWqmzCSLzp/v/2KLDh2eWopyjjH5+FatHIKJ1icBT0tJ2I1HjtDLCwdf76D48xRk1GoNDweBGpRoE6UXtqld1ZdNZnsbh36X9/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764208606; c=relaxed/simple;
	bh=bq6i96PDTALNr6Hhf8kq5M4hmGiVvqW9rRCCYaT3l/0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uxdJru0YbNUmeiAexIveqRhsObSzOCnQVz+n7/xBVy9vwZ2NwBnqwSr5WlL9+DZNn5Nut2bcCD5iTxs+98FF0QnlHgjCrXPHs+RLEZ+QDZEJhrkZYtMwjKediYsbhd90COdfJ+IEz9yOXJ4ZEAvHfWNVXOhRyN9jk39gLCPfHP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SssbFVCK; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764208605; x=1795744605;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bq6i96PDTALNr6Hhf8kq5M4hmGiVvqW9rRCCYaT3l/0=;
  b=SssbFVCK1+kEMVwvOpIqxd9/PRObUHNHL9NFhenkgy7+M+MPBdCJMO3K
   eAtf50ZMkISn7XUzg2lsGzoRtIdG/sebPtTvwlgUJv7+G3YGVnCi2bxtn
   rpJQPzY5QZjxDwAWNW6DJ9KzciEV+ghzlvobVjoooeTWPPn9rLV6MlJkf
   QhM5xo76cwvuLLaxNL42dYBNHB4Iz3rNQNQH7Fhb3KwMUkeMfE7O/mWAM
   ALsWwDNIJY1zUYcJoc+EjDEo+2BglvWIrp0oDg4ldl4CyIImzYYtaeFRw
   u9W77PMWoUVK0RYn4BMEPO46ZxYQHMawA3JroQ10PA0A+39eaGzHlOwQ/
   A==;
X-CSE-ConnectionGUID: 3DllhReNSAqtCUsoaGaCOw==
X-CSE-MsgGUID: 8vZYXX3pTmuINwIi5hO16Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="65963794"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="65963794"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 17:56:44 -0800
X-CSE-ConnectionGUID: ohd/Ri1mReWBiEgE1BU1KQ==
X-CSE-MsgGUID: WUIv4s0zQFClnaUQsFoNjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="198051565"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 17:56:44 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 17:56:43 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 17:56:43 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 17:56:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJmQY3sfgEhkD2m1M0KQf1aoz01ecE+P57CX/lMgVm9tN6Tbh91TlAkNXbs9cbxUMR5A6QZPnNS1BrpRNBAeQBryxpVuJUD9bhiEWzTmm6k832oIbQXpyloRhyfnddcKkzBcuLxGx2Deej28p1OTev6TA0jkLkaw+4GUKyu/+oR1mvqMGmsJ3veiszZjC1Pe0WyGfaKDaFOQnklnqPf60N8bHYPhOOxgM25XxT2YVCJFhjFLwmp6bwPMuLqzqlOeLxmVdtm9+ZA/kTW/Fj+NSHv06VpvFWnzsaGyOmfIAGiLFzqkndGpoXq8LiqKvRrfUWFP4NP6z5mkoWwTkzNGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwW6SSclW7bGpiQqukrk6nu91aaQaWNmeWKGuwmtwLc=;
 b=Ma3kbDsKGNE6/q80lvljgVw3nPu7f7t4yXVxtqGknoI0sHgE3L9tIrCjNuccuKxkUsd+H+Cw0+Zme2ZLYM8tIn5RRAe67YcOxsOYcDiMBK1xR1iGPOQiDsU+9Lz82aDoC8r+aE6/ztWxHWc8hhC7u26hKJE+8Qak6Bv2F1FTFW1f+lmNOqbi8WxRBJGeETvmtvoAobyzC3v0oHanFdCjzwAEWwq3Ya8XYxNvzyz50In3NuM4OVYbh57htSa4h77AiwsygkZPTeYjNuU1go70FMAfvaT3dgsLL8Q287Oi3huXIPTsU3dlSNiGCKFKCTIZIglxljib60dad9pI6oIERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 01:56:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 01:56:40 +0000
Date: Thu, 27 Nov 2025 09:56:31 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Wei Gao <wegao@suse.com>
CC: Andrei Vagin <avagin@google.com>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oe-lkp@lists.linux.dev>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: Re: [LTP] [linus:master] [fs/namespace] 78f0e33cd6:
 ltp.listmount04.fail
Message-ID: <aSevz+HGPM/sEP3X@xsang-OptiPlex-9020>
References: <202511251629.ccc5680d-lkp@intel.com>
 <aSeue5UPBm3QGH8-@autotest-wegao.qe.prg2.suse.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSeue5UPBm3QGH8-@autotest-wegao.qe.prg2.suse.org>
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad2902a-1966-477b-6f85-08de2d58352b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hh/KeVmcmw+QMdAJK97lQZAsci+XqmBJ0XeJ9LqvxKKiWh1LK83EEeyhkF5o?=
 =?us-ascii?Q?7JAi6bk702EsU/+zNZCPPwU27/dKYaXByZ+YNdDypahZ5Ri1IpUdPLRrotCr?=
 =?us-ascii?Q?MRojGZxoXaYTeoFITZBy4J9X0ioYFPw90MoYQ9fVEAHCGafiOPtqR2vPTvCb?=
 =?us-ascii?Q?QR68y4em00vqL3nvcTqFgK+f3EJJLg+bASUkUisAbPZF/6LBJMWCi75J511f?=
 =?us-ascii?Q?bPoK9VToPqyiF0swCG42dtQlVkLPifjOGiXySIbgiLAjzu/KPCzDGuT6sKXy?=
 =?us-ascii?Q?3u2dvFMUnPlXH62Fp3Ubzt7y87Qmet2PodmefphOLb4Q5plSvb8LzBTrmTaG?=
 =?us-ascii?Q?l/vi16ny3ccZDtut36x6acgHRv8Xu0FIR1hXAftUlqAAD1V3pvEWbLOtoASx?=
 =?us-ascii?Q?fb9m7VrKPD3p/Tjhpuiugn8hZos8CYM6aglHaxQSlbzmKKuChVip89TMmsiu?=
 =?us-ascii?Q?HwKM7km6S+pExONgWW7121J6Y8S33y6yezhbZDUeDQ6J90IglSdpTNyRZ5VP?=
 =?us-ascii?Q?0EDrowMg51Gsoxco2KNLamkQsk4dSp5T8HyKsCdTEJxNrEEG4wsDeetMprlH?=
 =?us-ascii?Q?5QKT30ZJzLtRkj6VqSK8+VO0h6kN9bcZLvOfhGDUhmhsPXtngLhF6tgq3kr3?=
 =?us-ascii?Q?EWoAyS3/ohyFDZDtw5i6o9hYDHe2Y0EbWh3In1oDPWTISk8WrKHLMKt4bCx2?=
 =?us-ascii?Q?hf29swPe4hk4th4Mbc9uV9ZPcPDzPLzQQSZSLYdmJBwq9wgZv03PbOKX8JN6?=
 =?us-ascii?Q?u4fNrJIQLB+7Y45l3QP/22BvVhak+2ZdXvhbNiU4+6BbgjOq7uiTwueOTEn4?=
 =?us-ascii?Q?dMCyM4cGxZP8aPt04ojrRfv6xLPCVsbBgB0NwhyWAx70CUTJWaM/hN5MYTKu?=
 =?us-ascii?Q?mG7E5DkzAcj2qEIocx7C39L9pH8DklVC0gmNnTJMA8GI9To6BFUu0qEr6o85?=
 =?us-ascii?Q?9G0HGHvUq26+jK1oirvJD2/PPK72G05d0Q7y46pR7Ow5s1wJBy0EopRZ0EO0?=
 =?us-ascii?Q?KTXPke8Rt9afx5l+IPgmr8l22AOs10eLgNY8iOltDLqrGx6Fg+qbDaSO8OVp?=
 =?us-ascii?Q?XL8oXYrLkBhWxz7x62Qh3Oh3AXVeIwb5kTRwakgb0XIG5Ofs22n8gsFKdSQJ?=
 =?us-ascii?Q?Lt3yitlFXnkUmB0SSReEtWSHdeqOlZ7b0+Yuqr3WNigHkg79icLYw/8nDOND?=
 =?us-ascii?Q?fLL/ncuT5ynMJR9rBDCQ5+nPSHXNPUHw8fxC+Way1gNqoBCwQ2xGhME5C0Ze?=
 =?us-ascii?Q?mNAPTTrKiO5Tr30scqBpG0ZGcamgaWlPQlYVhnSeELhdzHjYsFozd/2zDr4s?=
 =?us-ascii?Q?QV5mQd4HpTWOsiB3xu6xPPIS3EmGRnSZUVqfaM13Bes/oO7n093g8AZWUxVi?=
 =?us-ascii?Q?yDi4RaOUHx3cHUzupYkrYFqmTk9FB9Iqs1n5HpLBh91Vun0FqZjychgJqoHJ?=
 =?us-ascii?Q?dMlAfSFe4SZwVttKMLnEZMNJYN+DKfebS46Hs7WNO4uFBjmVvaSTmw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5nLPkO/pyE0x3uJZCP4L4O0Ez2o1/lGHqpO6NtY5kXV6tDGhlXb7Q9iB05nz?=
 =?us-ascii?Q?XclZOqGGmOMD7jCdnSI18sBXBCahlIpeISitg4hdCOwz+E7UDUp8basc8iHa?=
 =?us-ascii?Q?aiYHcNMML1AYpxf7IiVgKoaV4CgVUUuc5ylCLWgo6Xm7wqhCrYxxl+ig+mms?=
 =?us-ascii?Q?iFzhBjtvOfh6pBf4JoEAWVUzJnIXhpeMNmRkyZjUMeLuRWOERhCvKx6ejxK7?=
 =?us-ascii?Q?T7NeOhXdwB0AK49IOCz9b3q/kNYxbZN8SQo9dziT3hpuY6coGawVU+/a8KYt?=
 =?us-ascii?Q?02OaEAFHFkqP/xdKoSncKv3/tp+zx8s09idOzRDcP2wotJnoOrwRaJtxYqLv?=
 =?us-ascii?Q?D9D5l/Rfafxxr1rG7AHzK/Eq06D3qVhw2nabsnXH4Ljzg1lmrHJ7wHSujRqb?=
 =?us-ascii?Q?//jye1IB2vDd3nAT+yvipI25DHHDYtYauCGDDD++MTLDoUUVgtXJCfzSuZOz?=
 =?us-ascii?Q?jhoTUfiVeQ417AjKyQUojGEgpeaADAZzNQUJH96XvSDOtPzhpJDjs52O7wCe?=
 =?us-ascii?Q?2yZIJZmKSOAiXDVVhxGAykhSD0GxWtDO9tC+QU7q6uGJhk7vWoFoH6iAKZfC?=
 =?us-ascii?Q?LMXt3Y/T8aXiidCaodOYiZdhiMHFX4whn9J2/yqG2BC5fNxJ5A7losJTDgJo?=
 =?us-ascii?Q?zF2nLVz16j4wHPrhI86llNHs+kNeuyUYXoChasRBBzv9Fkw8EME5P9itlYRV?=
 =?us-ascii?Q?BVsmEjCBkFcxWPtEQqvhGvYWPgt1WW1KPKdp7auRbTa352/607JM8dgEK2r1?=
 =?us-ascii?Q?N0DjxQxT0kHxNYESo7BvJcUcEPGFAAQe3OW8e3DCTnf6Mb6qo15Favspw3L8?=
 =?us-ascii?Q?7e99lQ5EHVpJhzTp7FO9r48/edpnfc7sS2U1cpBMJHeY1tcAiZPkzlOKpDsY?=
 =?us-ascii?Q?WYRXhWgBBc/PWLCk5bi5/g3PkLLB2T9bPSPcJwA3KQHUVyBT4d+SWbP0MtJw?=
 =?us-ascii?Q?+q52tHSJNtGMcNURJ0h9V4wV2DvcWx80xl5/nN4UKRyMBmZca2c2S2k+eN+w?=
 =?us-ascii?Q?0bh/IXzglcavUO0EdoJQYD48yiRX5pVN4RwTjMqEFGpkHLX2dN5k2x1MQmY9?=
 =?us-ascii?Q?3D4mgYseMncJHu0LzsBkG1pGn3usJ0fxtwk1gkqMlz0Nzd2kaw60h1ET4+hF?=
 =?us-ascii?Q?EP/aQt08aIXw3EA5cQnbWmReAsO2xFLqOuYTe/GOIi5i903inVVOsb+zrE0q?=
 =?us-ascii?Q?24WSnxiG+DUyyebntnnBADeMZZvKXLY9K3S66KUlUt7GxZ+dEPmsAvORtRq6?=
 =?us-ascii?Q?85NGXLak+MFRiu0+txBZKX06Xgq2RFR6+hVTwhiiYRIMsW0cmm+zznwzQ3TX?=
 =?us-ascii?Q?5SLQbDiZpfmVDR2XwI4R+iKWgL4KfRANLxnPBD2JYnu12+gJp5a1j68Hzi51?=
 =?us-ascii?Q?kdPQHVI+lBkmPlJZObLkN8oYNpNkmEFx3E3Xo08mSUirC9erXKWPnN/nijm/?=
 =?us-ascii?Q?nWWosWm4upzYpjsh3gqXOU+8Yb1rgms9Gle/G4BnWfhBPgL5wFFKh1DfqEI7?=
 =?us-ascii?Q?Jiyl3mRb+CKAsI2CwjFlAlqaLLuEIlDWWK33K0IgoS9cZKcc8kleGP+Oja4a?=
 =?us-ascii?Q?6aiE5yXjqVe6aEKXDoqeTXlbvJyhp6GOnayDxJpb03+9L3nDG9Xvnu7E5NUk?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad2902a-1966-477b-6f85-08de2d58352b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 01:56:40.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Lr/jJXcWS3KHJGH+hhubdW5iGoNePEet7gWbNTApePXMcTLOKBTIsMuElQUq9R/lMl0jPclXTQvl2L/ma3ubQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
X-OriginatorOrg: intel.com

On Thu, Nov 27, 2025 at 01:50:51AM +0000, Wei Gao wrote:
> On Tue, Nov 25, 2025 at 04:33:35PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "ltp.listmount04.fail" on:
> > 
> > commit: 78f0e33cd6c939a555aa80dbed2fec6b333a7660 ("fs/namespace: correctly handle errors returned by grab_requested_mnt_ns")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on      linus/master fd95357fd8c6778ac7dea6c57a19b8b182b6e91f]
> > [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]
> > 
> > in testcase: ltp
> > version: 
> > with following parameters:
> > 
> > 	disk: 1SSD
> > 	fs: btrfs
> > 	test: syscalls-06/listmount04
> > 
> > 
> > 
> LTP patch:
> https://patchwork.ozlabs.org/project/ltp/patch/20251127143959.9416-1-wegao@suse.com/

thanks a lot for information! we will update ltp testsuite when your patch
merged.

