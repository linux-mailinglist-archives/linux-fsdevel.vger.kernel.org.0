Return-Path: <linux-fsdevel+bounces-17718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 870808B1B0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 08:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8822B2312D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 06:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212A44C6E;
	Thu, 25 Apr 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiiM3bSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957944C68;
	Thu, 25 Apr 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026542; cv=fail; b=mRksaAk1DHZwbP4TiPLoe+lb+nimCLzb8t6q6MheN2aaMYANswEi1Ap1i5/rewhL8ngZmkHTLzzPHrvAmQYLR23mn04vY791FySNS2WK2PHcrCCmh3uVMCG8ix4D46Y8qbQ2YMDHJi6fp37K797ErzCJMseiSxhSEVXWX9dOrPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026542; c=relaxed/simple;
	bh=Mevp4o/Gqs+2mXbRrUR09nIjasvJkPUB1dJuaCR9pMg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UoUjgCwSFCLr0lKlPHO13qmJRkZxii7dOThxWSCBbilJs1dVUp3F/k0wlJKDDat4HTXROzSLg5S/PH1OKRCFNP64zQ00aeIJjrWALx8FNl+j2m47wM+OxexQ7ONYPDdAacW/iG1PyJD53I3vx380XUbUOZ7YTAaTqhIvsXZXxJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiiM3bSz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714026541; x=1745562541;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Mevp4o/Gqs+2mXbRrUR09nIjasvJkPUB1dJuaCR9pMg=;
  b=QiiM3bSzhCEo8Zw0X36RRDPuphCTC3vvwuLElD1gfliCS8i4nDPRq8vg
   xcrY5USuJt/+CfmTO18Co/QrKnz+8KLB2wwPF64iWFMghCqq8a45oFQuM
   zaoylLcPUdKLPnnhnnKPuEavg/QXzc5zx55S9LL7a4mRg2Tdge5AhdSx/
   tR9tttXDUccTMXYo3fyY7F0wenDGh1wpPH2booxKWXhV6PgQ+HPj/qqII
   mY0tqlniJigl2q7ibLsskCKgdri9rY/rH03VfNmH/OzsrXA7YE0RGRRC0
   ucifWPDxvYzgxHyj6JFprI59yXq3SLBjk0b+L/Iz0RR1XeMbormsEt7l5
   A==;
X-CSE-ConnectionGUID: VxutV7EwQd+oUr8ZKFxauw==
X-CSE-MsgGUID: 2NA9GOeZTUaS4o0k9a9Pug==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="20839327"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="20839327"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 23:28:57 -0700
X-CSE-ConnectionGUID: LpHhldKrTYiuqLnC0vvQIQ==
X-CSE-MsgGUID: JH8ENu99SkGQq+2g+9Gvvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="48204958"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 23:28:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 23:28:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 23:28:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 23:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+NkeihO1952R0HRrw3QiH1pzUFpfu5EpMRQ4OniQAjbVB1HMZBS7CVswgUu428+7ksE5EvscJl030bTNrmhRr+CjjzitHPoVGurmO9UI+qBsp6nUcgeDnBLEXw8PdEPnCIjdcz9eFXThIdfisRKvnJpQ1PKuuihIHwuNzCsOAXsd4zIe5Vl3hsgi00Qa8FJ2Ka723t7ZdQHUNlfOozjVNnwv5McgpB86pYQTJnxPUXpb1C9sNJQ+QGxxvnP7RPQOUcPodfa3Z/50nLRWdcyqcLHSOKGLxP7e2SGfUUjOKY5GPv+wAwJTYPwy5STXKs2L2xJ+UcgPlZc+FAe/KdJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G9GJ/g02b3O6kZa05fkg030NugeIcsr35fo40tCJmw=;
 b=IaDhBcBGHwJKhdVtajNH6mQS1rci+KB99V17El1KZqgi8Mo9CQwUpowwpY7/XR2Lqg/OQgeFXcu7SU7PoqqVBnhMI4R96GyykZryIiVGRq8gJchFHM22+nGd8VuhkBEFVMFEIoOs0+8CTtE0XiCORLrU/5pPkIsvjdWchAHUY8k7blrJvYIyZeV3jsmU/9A3clwzCFQm7je8wqt/VCNUdhg0dR79ri9Q003ZSqQUG5hev2mXOUdjv5yNDqdrgQkzSFX8mUO8sedKYv5DDyNzWwwgvJw3MsCPWNM6LbD1wYJPtvxu8rE6L6V4qPF79jDtHLBo6F/CFFeVlcz2fRJNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 06:28:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:28:52 +0000
Date: Thu, 25 Apr 2024 14:28:43 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steve French
	<sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, "Rohith
 Surabattula" <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: Re: [dhowells-fs:cifs-netfs] [cifs] b4834f12a4:
 WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio
Message-ID: <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020>
References: <202404161031.468b84f-oliver.sang@intel.com>
 <164954.1713356321@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <164954.1713356321@warthog.procyon.org.uk>
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a661aae-00a3-460d-3e35-08dc64f0f983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2gJNX6s3zSG0HZ4qH26x1FJBbkDZRVFm0lsN5T1gm3Cn/a6YzuohGgZIrPaN?=
 =?us-ascii?Q?VwTq7nBYJMWkirwki5Y6J2GzuZJw5yxZqiYhVUv8kx+hRoRVPBaknBOfz45v?=
 =?us-ascii?Q?C4UDimc8g+Ka2Pfb6d89IREG8U8qhu5wkl3roCQAQMfrCT2sJGS7h8GU8YmU?=
 =?us-ascii?Q?VRXsPCbETs8gTEmGAOGf30fKXgLI4pGOGKr5q3ootMqj1xCp/CsAijoC9f2p?=
 =?us-ascii?Q?X7sHp6ZbtslsGq56G8ueNkKOCwuRyP9ZICeUsWEXrsxL50svmLHLR3XS1Z8B?=
 =?us-ascii?Q?gt6T6gudYy3NynMmr5RJhFDhBMSSRwhSupV10KOCUM2hJPToPriJNkjpgOkU?=
 =?us-ascii?Q?sHwZuSgMUYHEzO7S9NWNccVsif/xbNtaKrVyqaMoekAkR3mz1NcjjF6AA+v5?=
 =?us-ascii?Q?lm1Oc2tvE0icS8q3NStoTSakVZMirEo8quUHR2F//bonCLqxJyhc5d2sPznD?=
 =?us-ascii?Q?G9CUw2RfcBNLk+KNpvH/3ZwH6bAnJlbzx5oCOqnrQwkxYXOY1LC970j7FIaa?=
 =?us-ascii?Q?e8myRMAQlgElKhIRNUz70BXZQkiL6PC0Rg/8XyvGs2EAC0uCGuHDwfjH/DYs?=
 =?us-ascii?Q?kWlgXmKM05MpgL2g0XahltUIaO8yGZAdRLF3B+yFmk0CWWpbSaOraR7A3xZ7?=
 =?us-ascii?Q?2tthvI44wx4Fk1Lu34fKA1fL0db4qGyhgarbp2Pmcm6gZsu7d5FSVEFHNxdp?=
 =?us-ascii?Q?0236hljwW00SO1m2F2Rg6ITY497OkQx6d87She9thKSWdX2eAIRgaRng7dy4?=
 =?us-ascii?Q?q67Kd66ilFxgNwUWqwRvhICm4CTcCjfMpAhv6A5sruJxxxkEoA4RsFd8ymww?=
 =?us-ascii?Q?PbJygzeh5I0SuM0cvy7QRv3iKtGQXfiIvYA2mZOvQYy2dkrr+uIXuUH2GZcC?=
 =?us-ascii?Q?uGp4s0UHJJZ1jKQ9l/7BFXvVVN4CA4Z23mXPUAC5tyaozbnmExDdsoeF0WXm?=
 =?us-ascii?Q?+asj2rITJEqeu86+rP0PjdNjM9y1URwyUm1qlLIWBcFRW4srEHrhpEQxLo8a?=
 =?us-ascii?Q?nMTI0OP0fYhpWVIxMLGz6bgu+Vsvhmo18m3G33G5fSMTefeJvks56B9Sc3am?=
 =?us-ascii?Q?sHW6cELXm2urOAGx+eIVG98vPmrWOFRb57Zie4EDPWfBTLdGlMebN1pJuuA2?=
 =?us-ascii?Q?DIpIyv5/FDWPv5EYb3kWY1Vecp+M4rhZ8g9DmVkRVxM+h4BnWoE4bTV3JhHE?=
 =?us-ascii?Q?I7QuRzxrQQPQWDqHma47qJbPRViH+OrNOuV0BZJnxjvaMMM0GVezEB18eDw?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfiP7J+otghS98LsVwCBKbFoe9sz1ncWDKhBhnUwvm9kPJAgfDGDebC3ydLH?=
 =?us-ascii?Q?mYkaS071F+ckPKyKvmZ0uJMQ7kLAza7w2z6tPzaePfPh9e+yL7HRdbn1e3kS?=
 =?us-ascii?Q?7HtEBmVQn3dwb/719m/t3TGhlP3GwvifTMeTmlPz6+RCnETty0xTKzGvlLsB?=
 =?us-ascii?Q?H8eSsAG0iV4BkVPxo1ZWO4pAxBxkit/VFgB5egq6QGSIXZDRj1gtLt0yAPrF?=
 =?us-ascii?Q?32mRGk8G6KiRdJKDCzyjFZYENyWjEiGzM/+HHz2YI5dOKsp5pWc9i7/ITJne?=
 =?us-ascii?Q?fsWqVDbUWPF+tH/xScgYEZCdwUIgc0VVOtCmYGK9UlHbQ+kX/wQN8/t6YXMx?=
 =?us-ascii?Q?8ObJyLfOljlJ9XKXvYHU9KU11geAfcep5p65J4NDmSNkAevmeC7ZFdQMnfZg?=
 =?us-ascii?Q?S9wBpODmXXUAk8HZi3WdkSone4pIA84E01VA9RZfSU2YxVoJ9oeirvJHT8WP?=
 =?us-ascii?Q?7LMdKfNHsTq1Xqu4vUgfSjus9QQCbYM1U6sEMaSRNqVyDhVJFW4wXGhRqwas?=
 =?us-ascii?Q?gqcYLlfgjZgH1MXqzYzTXQ6xbL9q0i3yUGDT7UrnrmWzF+EA27qLODodLjf+?=
 =?us-ascii?Q?YqcR5pxaj5R5JBa/UysC+G0Vsllqlv5P4dJCJC/RO6zBw2/LCkuvoOMElZOt?=
 =?us-ascii?Q?LjkXutGkGh29bavJVO8JiqL31h8W8dbCh8QjYYun5RPxVeCrEsBY8IpQzwHH?=
 =?us-ascii?Q?z6kAgy8FOnftskJm4oItwJCLnDpoy/CekCFY/3YGXtv10HkrAa7B7Ld8oZi0?=
 =?us-ascii?Q?HhyRYvIQAIslbPlHaRAreSMN5cnZgykmv8wMT6nUh33GRaqBn0jTrLjKtDmv?=
 =?us-ascii?Q?McDFBcom8GhcGjti8o+He8FzK0mHpaoAU0lMZWPLf2p6YAO0Cx8qvqHUNj+D?=
 =?us-ascii?Q?3z4WxLPbLOyZ6yXFVRvkB8h1iDqJxobry1gsOgyKKOoBbEuhTHxJNOih09XD?=
 =?us-ascii?Q?hTzMAG9OQnfJDM2pWy9MkFWVGUCdyC2cbXS0GPbKhn+gqowg4uERunbzk999?=
 =?us-ascii?Q?HofFMnVQZVqseGTXMUd7GdD3ELPSv6o/gyoURXdq5Q6zkQCBSmZFbD+rqVUY?=
 =?us-ascii?Q?rc8KYa0phV6l/bOJi+CsiSR2I6xGofOhR1r6OgpUVtp9o/MYiZJdGbkZnp+M?=
 =?us-ascii?Q?pHowfaGE0CeT8fy1Qm2o1qyhzx7Zmvhqcx2EF9PgcB3Wvx1gsmCxv69MoAXR?=
 =?us-ascii?Q?QjkjzVFHJfMXXTwFnT3AzC7bIDEGqWQjM6vusX9D5Xy+BbvpEWIEryGPFQ/r?=
 =?us-ascii?Q?by3CbsxjI6NiBDuDXqFPuLnK+g456Sn5JcFRv7ng3nCREh5oNtY4K+s584U1?=
 =?us-ascii?Q?Cwf5k9lLUUFYLg+yTTPHlhzUvOqMDndWls/NkFMhuP2KCFnX+HMTcj+Su7Ds?=
 =?us-ascii?Q?/0r2jbgbEj14bnRXXWbEXFkwLMvjmi6jjmwYY0TKyuSakT9vywx4dy+7/QW4?=
 =?us-ascii?Q?9nwOFZpz62rwgOpul1V0A5pmdiX0JBly5zLTG6VjGTXO+Yaz82qKQjBz5lpa?=
 =?us-ascii?Q?ONHKYZ+0mgv/pB7IR2Lp6EyGZQk4dSu3H07Hw6gcvVrx0JomEWfrCu5AtB+C?=
 =?us-ascii?Q?oDSfljOYLw+HXTC6jB3HH1h4eab6bLLXROeVb/klwVAYM+k2/5KaHna/c+u8?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a661aae-00a3-460d-3e35-08dc64f0f983
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:28:52.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +59uX+aNgCx2J+m/mivh/8ifygfMeo+Rut38cBeicl+PCd4c/tbOcWyeftxxNr5p/+Voz3w5w4jFaVzGxzZFtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
X-OriginatorOrg: intel.com

hi, David,

On Wed, Apr 17, 2024 at 01:18:41PM +0100, David Howells wrote:
> When I try and do "sudo bin/lkp install job.yaml", I get an error because
> Fedora 39 doesn't have a libarchive-tools package.

sorry for late. we made some fix for fedora 39 recently, could you try again?
I can pass "sudo bin/lkp install job.yaml" on my local machine with fedora 39
now.

we found the similar issue
(WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio)
still exist upon below commit in latest branch: dhowells-fs/cifs-netfs

0e533e79c0edb cifs: Cut over to using netfslib

> 
> Also, I can't find a "filemicro_seqwriterandvargam.f" script, presumably
> because it would get patched into existence by the failing install step above.

yes, this is only generated after all previous steps pass.

$ bin/lkp split-job --compatible job.yaml
...
/tmp/split-job20240424-80542-6az47a => ./job-1HDD-btrfs-cifs-filemicro_seqwriterandvargam.f.yaml


BTW, you also need follow
https://github.com/intel/lkp-tests?tab=readme-ov-file#run-your-own-disk-partitions
to use your own disk since this test needs 1 HDD.

if you find further issues, could you capture full logs? thanks a lot!

> 
> David
> 

