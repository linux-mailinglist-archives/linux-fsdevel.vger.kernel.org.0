Return-Path: <linux-fsdevel+bounces-29735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A597D13A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 08:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D211F286692
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 06:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EED3EA76;
	Fri, 20 Sep 2024 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3ZGddKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA44374C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814201; cv=fail; b=Jx6mw/rHmN1C4WCnXRd/9AxzBcpi3dMMBgrkzSAavfGjIUiAKfy3hoz2KO+0KzrwQ+xaayJGu69JXCPSKhQgbuNErKCIl/bEtnttVMXmxVJtAOW0hNnlJm6VHbvVGdrJwU+Ktm0uGx6WcyDFusFT8Fd7F99Tib1ucYDHku1kPVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814201; c=relaxed/simple;
	bh=DznMOS+k2H/CMEvWINr2gVePOFReMZLxcOrj0zFpm/4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nbiwd1gOKwKeyhAedB7gBAkSkUQ1Kk8nLTykCj6d1IvBcrtRpx6uAJWK80Jy631BIpzGbWcc31N3FcQ4HMAoQ+qPz3pSmeJVpaXid75MbDP5gu6I08Bce9fzjjI8fPeRpwJRKQN7FlcJegunobAigmJi03Tf7mokAF2FwrbFLPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3ZGddKm; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726814200; x=1758350200;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DznMOS+k2H/CMEvWINr2gVePOFReMZLxcOrj0zFpm/4=;
  b=H3ZGddKmcecn30xIk0hyxWdrMq8PdJLLrKRXp7rF3vBGBP2s7QdlDOKp
   Bp+Tj7bngYYSANKRnvywSv5UP0L7oB+nI0pVLD++gFwMBzTnJ5+87YHea
   1AZ5ZLbvyLzI4HOwGLmmYffPlq3MRt+UXVvcNjTTJjhaUh+PT16UQILXS
   LwU9+nJBme34a2sf/hoY7DNi1Y2XwCVYUXxdEf81Qn01KPvJNt2GGavIO
   ZcHpeR5EZ9Sbap7LQihuO5GRYO5aPLu0hwN2/w+OpAEOn0rxUKetTgsTV
   gQCf3f39y02r1H5QNQEiXjnxacKBVZEcKMZP11Z/k/TRNHIyAA703zktd
   g==;
X-CSE-ConnectionGUID: zLcp1ERmR8KMRDvNQQOpfw==
X-CSE-MsgGUID: X0d3XYBLREGGYa6lK6WeIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29542939"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="29542939"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 23:36:40 -0700
X-CSE-ConnectionGUID: f/6mPJcrTku3e2JiKuBtcQ==
X-CSE-MsgGUID: qtYuXCC6QWCjgMm86xqVFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="69790380"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 23:36:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 23:36:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 23:36:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 23:36:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 23:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAZy13uKpC05eqvZSba0wVzYyBJ1hA6Z4vDVeDdNSDbtUizd84aDMX87f3z75hNUTmzdpIBp0TAfY8rNh8pwelNILetSrq5dnGK8f1BL2THIMK2DCsCyKrGQGBMX26RfbUD4sFLPZiYOpe6RB+NEODxwScZh0y4La925OJJedJpg34P9gLyclZs0qKhPT811KnO+cyFtwry7+eb3AFwGjsrH/8l75XIkHCLcirVP7XEDaqgq/jRKrJi0M5OeEtLXMZRbMyObcWm2hJo3SC2vRdrL3aLhsqXhO+l5pjuqAXJU2csFa0NTx8N07taMwfZho16G7xWbTUSAm7FA4uP7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50A4XbhEwjgwPR523DbJuZKwxqn6Pjr3A70r1J/qg2c=;
 b=Jn6Mmm9UCp8KLGxLthOOq0lOaAdZLlOxbuKYXZrpXfvOEGLmfEFYJ8908r/J54O5vQjexDKvtLnmqo2LW85OeHQq08W9bv7yShp2jrlmAtLz/fmdM5VnPmD1OGqMR69HxzSwRcvItbl4FLLAIeB/SESsIQ16mpKF7ItFpHNmrwsLLqT/0ihG0zui4NLt/Y4rPWJsPxmCmYHwJg9stNYHqVLOcUtrDbvM4l4v21VLU8O/FN5vn58aV1bsvLcHFMZOZOjw+yEDUnzDRPfRlALvX6pC2oLGatESyfsdTThQAIuruBsw+sPSabwMvIINkLdLclFFQfacn6r1jwU4+aOSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV2PR11MB5973.namprd11.prod.outlook.com (2603:10b6:408:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 06:36:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 06:36:34 +0000
Date: Fri, 20 Sep 2024 14:36:24 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, Steve French <sfrench@samba.org>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [netfs] a05b682d49:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <Zu0X6JWpvxhzT6/x@xsang-OptiPlex-9020>
References: <ZuuLLrurWiPSXt7X@xsang-OptiPlex-9020>
 <2362635.1726655653@warthog.procyon.org.uk>
 <Zuo50UCuM1F7EVLk@xsang-OptiPlex-9020>
 <202409131438.3f225fbf-oliver.sang@intel.com>
 <1263138.1726214359@warthog.procyon.org.uk>
 <20240913-felsen-nervig-7ea082a2702c@brauner>
 <2364479.1726658868@warthog.procyon.org.uk>
 <2537824.1726730090@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2537824.1726730090@warthog.procyon.org.uk>
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV2PR11MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 988b9345-706d-4630-0a04-08dcd93e922c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ob/gAYKK0wWUB8pN871DTOIIFYv5IirEfYzdSiJ0QMPkzG7vmADdfO3Zcf3f?=
 =?us-ascii?Q?5vXJC8W7qPGqTXFvE+sBqwawzWB2R8lIEpE6lKBAYeW+DhEXcAQK2KKXOKgS?=
 =?us-ascii?Q?1soTkibPey2Faym6G5cToRM9k47otR0Y7sKnTM42FQUIJlAk/keTYHB3oLdg?=
 =?us-ascii?Q?UWRAkQqkZ+NSj8AaNvm+cXOP1iDX3s4qJF/vIxDwO2sAXETnN61ozee7qlIl?=
 =?us-ascii?Q?zqS66hXMYm25eMVP6vfqOYQvXVNOaRknkuWDF6O2UMPoDyAxZHNfxayiUkL4?=
 =?us-ascii?Q?mO2n7wkCyn8ImUaBMYL4Tv/DUtSnyC5M7iJ8Xz2nCIXalTOOoLCPFU0JTzye?=
 =?us-ascii?Q?G20Utqsdy8ZyX1XvFdfHjTXcn4ey+Gq9cU21jgz0OllDeZB9NPYLQyBpSd0z?=
 =?us-ascii?Q?XQdWLBHDCqi1zCosyr6dLjwTnYSoMHiZ05dt/ZquRzCFh2hYXOf8naFg+a+Z?=
 =?us-ascii?Q?u1wjt26g5GjSYhAyivHsjZW/8Qd6LGQMGQT9CmV6PolVuFt0wE8xKaxD93xC?=
 =?us-ascii?Q?DS2TJtZr6vicz4GwGVcZ0c/VKhvlt3jJireIOzL88U0BKabTFfOJS/S4fgYX?=
 =?us-ascii?Q?04AUev/Of6bqJmdnjgsFP3AWR2iWtqlLb0Nh1kOTRnMJ0WAdLV6KKjvrwbzx?=
 =?us-ascii?Q?XKIPRq6/wJnYp2+/TeISU1N7ixqKX7qRQJZPPN40J6oBzHpztwlXagqnMfEA?=
 =?us-ascii?Q?1keXaf17QsfnJ6A9eZ+SKLoAnlpEkCtg9fFShe9ETgwbIZrbkhlWLTgBejls?=
 =?us-ascii?Q?1Md/KzVbvsZT6SKSyaX1ZlH3Nb1PkuSIH15n5nYqtCJxHJ9mi/1YvXlt3uOV?=
 =?us-ascii?Q?KTYtursA3EzTRcvqTvh6/zcg847occrsDX8PLjnx2ee3uDO2aHAWhiQsGTDB?=
 =?us-ascii?Q?PkE+ta00iid3HU2FhDcZ3WgN0D/DOMqO14FpGXfeq6ay4P9wozEr4oVQcMYs?=
 =?us-ascii?Q?TpCoxMa+Rc8EKbxfHfX77AUR5liIQZJMZKpka994sr5BkCILwRrG+9zXSl0x?=
 =?us-ascii?Q?QVeayt9SDE1TwyY5sR7S6+nnA3AJqPqy2JzE38xrPw2gkK2xl4Vng18Y1rRW?=
 =?us-ascii?Q?cYwQ+BJGqG82JbEH/hAouO/kpLjj4DSFJUx1+bUHkXNt63+hk9VeJOeuS7kI?=
 =?us-ascii?Q?xGNAs3Za9e3ayzjNfsKx33iK/CD8f5ziZ24CZp3nacbK4/f+9TRqx5vFEUqE?=
 =?us-ascii?Q?JkmyzVucsnKRh3wYZICK7d/V/gHz1mDyEi3Q+UciAtxE4m4Zf5j0OU5K8LvE?=
 =?us-ascii?Q?7pam3K5i9b1SO05bwjnuBR7xCawa8Zuao6sJc8z5z4JWMo6FMV1mhRvqFfqr?=
 =?us-ascii?Q?Elw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gkBWUVvPgeI2PBJE5SppYbxY2ZvCdk6LyzEhMvbleZuPyBgAymsykSNk0A20?=
 =?us-ascii?Q?6tTPFt17TPcTjolrl7iUDqEwzUgnSSJIt0YYwaiNVyQ2Z5jUdhdXl/U0ujXC?=
 =?us-ascii?Q?EHqE1blgtLigGr5rz6v1MtCLl3ISQiAT4dQKV1++ZjwdF11Deo3ACE4LSf7I?=
 =?us-ascii?Q?E9YMv/QvqZiz+ohP/sX5P6DoyLHEVSWZMNOT8EKKLlbRI+yx/fuNCXDoT3Tf?=
 =?us-ascii?Q?cCPKNNAthDSGV1gEP+YF0jZOu1mwOkC4V/jIpWY0/VUDeMh6i8G4jqq2nf9w?=
 =?us-ascii?Q?07bNgNOY6+qDaiEIafmqXEwS8SzqL0veLyL0G+T2ekEGcTbePO6a3Cfhybb0?=
 =?us-ascii?Q?yfLyvijB44ebP3HpzjPoH4r7mcBxpJlEs01GLB/ELrRXmPEDfqMZqo8qE/mR?=
 =?us-ascii?Q?227zgEMeJs0jrMacmujs6FWM4P4YPs3JNVL+6FhF4RlFoj+l8Jie0m2Tc0ot?=
 =?us-ascii?Q?D2DfbICyqxFugIEAyXbSOVark/DrNQVTCr6iRYkuRmFXl4Njk9uMmeiHnDdS?=
 =?us-ascii?Q?7pIkoeaegKRT1D4fy9DkrNboxiEDk7cZDnOTv6HN6PUSYwuTJ46BGQKsfnyP?=
 =?us-ascii?Q?NPtWCP8Yg5tK9vp1nGxLa++PE4jXMHlUuIP2mnzIHbhG6/UtugkwUMrfNv0u?=
 =?us-ascii?Q?bzIWuiZQJg1HECxcN5up4uJLqaoCuDS04/YN/Rdg5ORT9vYKa2ejQNi/Q6Di?=
 =?us-ascii?Q?3ASIoD+eea4/i9odQRQiNJpcHCaaCFgMPwDCNsU7gzIHlOpsOy+Zae35A1NN?=
 =?us-ascii?Q?GScQ8hfuffr2+A9RjZMG/I6dABsvfYqisvTPPl7U35AT0REvuCOO0+yAg/JA?=
 =?us-ascii?Q?2zVIJG7inmvxcu6UespBbeuo7AVyuSnMxccPWb1szLx2U3jxM7sN3wMrtuH8?=
 =?us-ascii?Q?JdIpE4n3unAAMb4n4fev/kdOhviTzQeFQOU8scZzBK7FlKcnhvzhYEr+svJ8?=
 =?us-ascii?Q?INPK9/daxvwWH06UoS/iNbRQQyth4ij+FUCvlxUWUr8PnV6KZ/8/VcZa6QR5?=
 =?us-ascii?Q?pknrnd9f01QnLYAH967eJiqLjTSuabfjUoNjQGb9JnOYhmI3ECRKDSEzaoyd?=
 =?us-ascii?Q?+bRV8WDyeaVg4d2dKwKdaIbNooQpbCtz+JmtzNOHYmEbZYbWmj4HB/iKU7BT?=
 =?us-ascii?Q?72ZbmYJLMZIg/tymeWniGdHR4MqqUpI8IT/fb40LZGPHroAzDFaoLvIxWpgf?=
 =?us-ascii?Q?fgwYM+mXEjYDv+zOMxdKa/UxJf6apIpd3/BRirmi4doHJr6vJMa87Widz4iU?=
 =?us-ascii?Q?kvmwNCAqNzh5lVrohwbKOGtjUOrtEvchA8d6JFLuSoVVS+hHosJxOEZFBLSr?=
 =?us-ascii?Q?578KrOm/9ze0H5eosDy7mmafSgoWaBtDkYi4lgEve9scgVE3DlzvjJ7/PJGS?=
 =?us-ascii?Q?IvKnq3MZ9FDmfmIj8uMEmOcDrzF1Q2MTvJ/PkfabHa1uF245R+57dBzs3x5N?=
 =?us-ascii?Q?919JsQsusxsKg5Y4diIj9zXXDADxu67vA/N3ieg2VcEztEzX8HG6uNjRGYI3?=
 =?us-ascii?Q?SRqiKxyfQENXR0uS57pYVeFJGeVOMUN/T0r5XgOGy/rHXwUeDbnrtcqb0S9g?=
 =?us-ascii?Q?V92BMk1fA71tTZAuY1nAEHqaU/b1puzytwxS6zJF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 988b9345-706d-4630-0a04-08dcd93e922c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 06:36:34.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LobKgw0+pQwdzRY3TOoFC+R9/hvJPyfj4nUjNr0/PccnNjnzeon8hJZt2E+A+Q5z++Vbn8KmLOc/h+pagZP0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5973
X-OriginatorOrg: intel.com

hi, David,

On Thu, Sep 19, 2024 at 08:14:50AM +0100, David Howells wrote:
> Oliver Sang <oliver.sang@intel.com> wrote:
> 
> > > Can you tell me SMB server you're using?  Samba, ksmbd, Windows, Azure?  I'm
> > > guessing one of the first two.
> > 
> > we actually use local mount to simulate smb. I attached an output for details.
> > 
> > 2024-09-11 23:30:58 mkdir -p /cifs/sda1
> > 2024-09-11 23:30:58 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda1 /cifs/sda1
> > mount cifs success
> 
> Does your mount command run up samba or something?  This doesn't seem to work
> on my system.  I get:
> 
> andromeda32# mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda6 /mnt
> mount error(111): could not connect to ::1mount error(111): could not connect to 127.0.0.1Unable to find suitable address.

have you enable the samba with a /fs path? such like:

start_smbd()
{
	# setup smb.conf
	cat >> /etc/samba/smb.conf <<EOF
[fs]
   path = /fs
   comment = lkp cifs
   browseable = yes
   read only = no
EOF
	# setup passwd
	(echo "pass"; echo "pass") | smbpasswd -s -a $(whoami)
	# restart service
	systemctl restart smb.service
}

(https://github.com/intel/lkp-tests/blob/48db85cbe0f249d075bc7eef263b485f02cb153d/lib/fs_ext.sh#L93C1-L107C2)

> 
> David
> 

