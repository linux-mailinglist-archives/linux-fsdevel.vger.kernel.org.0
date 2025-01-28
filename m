Return-Path: <linux-fsdevel+bounces-40212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D360A2076E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4E77A43FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28211991CA;
	Tue, 28 Jan 2025 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yey7gpoO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C894199252;
	Tue, 28 Jan 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057075; cv=fail; b=JiVJFG/hKvfiE5dXrAJu70ub1Tjh2RQVQmTf60PvPv0PgvgGXEZZlEgc2d6tZ+dsjZviu0ipPSMasGUsoDCyF920k7wCzzMrc56X5faVZpCr6oSAYR7vKa4Tf4rWRLqAYIqitACBbif/W7/GjLlJpJJPlDJ1BF0BTmq7Foq/h88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057075; c=relaxed/simple;
	bh=UoVnwt4A1Is4M3D8UrNyaEd00BJSVIxJoty1chRP4Zw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3yHJQj+Z50OcVupEpt464qOjZHfGKzW68kLVb4wVxXWDztBHKF/FFLpLX2Hv6Jefm9P0fSOAW5qG00EC5vhxI0wG/LxDhN3gLhY/i6oxd/SLHFGpzbjzHyIrhVUKXD3GxI4ZNIFCkKJ8CnZ2xTz00HoSJwlQjp8CdEgX/FslzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yey7gpoO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738057072; x=1769593072;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UoVnwt4A1Is4M3D8UrNyaEd00BJSVIxJoty1chRP4Zw=;
  b=Yey7gpoO4j0qNv1gD3LMbPX25VHhLXG8USq6MijG0L65z9dxxg3e0aN1
   021j83cnrFCMizj8fKgrm70XlIWEmKD6U9pupZ0rbTdvqxWZwxRYmKfE5
   zmIt3E6qOjfAypJgHsSXuW9COH6VCxCD576vemnrMgyJHobdhAx0G321j
   dmdgfOn2BmY95i2NnZWKa51bssDZq+uXgOxYeshk9dI9WDBdfHcJGY0Zm
   A/kFsHVboHnUYGSE17MC+76+WxRxFoZ/JUtraSrcVgHEmspHk8FyMM4UX
   RF2qJed/UxxZ+tSpCrOIBfhAQjqm+w2Kb279sXGt6IWSrN1HA0QEWB3Er
   w==;
X-CSE-ConnectionGUID: xW/tLBjASKq9FB7CAtjh/w==
X-CSE-MsgGUID: SeIOyf3jSzOwg3XXqgdFlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="42289317"
X-IronPort-AV: E=Sophos;i="6.13,240,1732608000"; 
   d="scan'208";a="42289317"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 01:37:52 -0800
X-CSE-ConnectionGUID: L0RYD3EdThCjhcozatIuVg==
X-CSE-MsgGUID: Q8fxP2lxTMaHOd+JZOfUbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,240,1732608000"; 
   d="scan'208";a="139575414"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2025 01:37:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 28 Jan 2025 01:37:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 28 Jan 2025 01:37:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 28 Jan 2025 01:37:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu8Oaj7f12A3XRW6MAGfN297qIDM+qLBAe6RK1mZ1zIE9DdK+uVTxyEpW5wQjlBjzZHzWBkC1yBsMjKX/2YBtiKpm9bPNZHX6EqaTALCUvEcRMvCWgGoZJ1G9T1amxdka7kf2ZkQYxTaDOU/WbMYWB8/VOmhQof8ZO12IzWCw7ULfjbzo5Wcx6zWWp9JXGpEWaGlu4wgci1ojy4iEVIV4Tec6Q8MBh2x4a4iMT2CrKs60+8exosOQJbj0CVd+CkVjdNgg2XZAmulu2cAZzf7RYtKUX9E/sXZblVcx7yd0ncugxfcjS7vn4l88l6+slpPkXhwSx0YyBf4Hc+D7W/Fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPyZJrFBzFwc7q+2WIs+hwIbed+7gGpfb7uQ+dg+C+w=;
 b=aLU9mZcRfzyyibDUgZ+KyJlVbUU1O3yjDuer/NE2waryitTH7Buzqx+G/l2sUGdu6TUC85UYt6DzdE7XmiHeEcabYTaMZtvRPV8QzgVXCc+QdEcQKlWsFvphbe2aecpBZYttTkVt9zrEQ+USt39GchPTorle8bD5in/BqKGlq/useCRzo6Rj6fqHCKtjD1EUXp7ZLi01P7Z2iwQB9XZ16PS6M5rLG66/3CY2ZR/qs5GuHhPSrlLanuUnPxmVURTTZ/obFXDBOpghBLA0tv+NL0HIt3/tqq6nqInqk3erUUYDAlxezG8nzfpdsTrkdJ6Z2ppb0QAe1j72IfbnofFpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4576.namprd11.prod.outlook.com (2603:10b6:806:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 09:37:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 09:37:48 +0000
Date: Tue, 28 Jan 2025 17:37:39 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [do_pollfd()]  8935989798:
 will-it-scale.per_process_ops 11.7% regression
Message-ID: <Z5ilYwlw9+8/9N3U@xsang-OptiPlex-9020>
References: <202501261509.b6b4260d-lkp@intel.com>
 <20250127192616.GG1977892@ZenIV>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250127192616.GG1977892@ZenIV>
X-ClientProxiedBy: KL1PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: e7452e8d-7659-4442-c6cd-08dd3f7f6d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zP8ioKGFEb3PT2tIPKIMtcDg+r3MparBrI4MP2aMB5UtS75o9ac1Q5mbFG?=
 =?iso-8859-1?Q?Vnwl69VTyuOzVYCMyRhYPjHd1oaXOVhSTmHLTujRt3Bclhfw/1sxSFz2+O?=
 =?iso-8859-1?Q?9kIvoC9eKA0paCEekEmtCuw7d5xtnomoThVBWybeb5qJ7tYzphIr8gZlxB?=
 =?iso-8859-1?Q?uUBhEzp7ekijuzhHQRtxsMsGcYKuu8dQI+bG6Ji+R1EfI5qfuP0XbHTdRg?=
 =?iso-8859-1?Q?CtcHnwLqq6vKGkyTkhC2X+U32ccmXfOpz7jKnHDqkLs2hCUsGQDe5t3TRd?=
 =?iso-8859-1?Q?o3WywfHn70yW2mXKIhwoWwPPTHB3IcofXY+kJehd0xBvsaCEV09GDRB3ZH?=
 =?iso-8859-1?Q?fegk3EOSeMgEMa6onj9acimWyroQBroY11zky3/m4kjgWczIRgRu23PMEq?=
 =?iso-8859-1?Q?4v+zhXMN5iqT+RFERJuxNrgj1nKsssPJkXPZ8mQ/oes4qR3579HfKXAFSc?=
 =?iso-8859-1?Q?qZTYn/72/oTBx17EUTYXaVCiZFVLWMyxhtRPMoTmpVMHM+I98jyc69oHoZ?=
 =?iso-8859-1?Q?Rl1kcy7cHpme0DgcRWvV1pE9tcSoAfkM4XjEIATfvD2UZxs9KIR0O2n46i?=
 =?iso-8859-1?Q?Iw51hFgosplAfaUi+3efjOEZk8SJgsph/fCXvlYYDFa1875+eT3ES7/1rc?=
 =?iso-8859-1?Q?L3Gz8EuPf+phv6+n0fCGhPTgKNR18JjKwHFmC3tZsLDGfRyGp19J8YFZ7d?=
 =?iso-8859-1?Q?HxAjZRACgrx0XtsyB708bdq/MahQWaNTiDZAWsZUmFgifdMd9R3ZgW/gth?=
 =?iso-8859-1?Q?Ne85OadhJ7WpBMy1/oK8D6M6oPB3rgEXjuSeAXFcWr1mxQXQJ39dvGMz4E?=
 =?iso-8859-1?Q?n5312qNtlOabB84JBHcc7uf/FmzqDTewpm1IvPltBlBcrWo0XquTTpJeLd?=
 =?iso-8859-1?Q?PNr62OyR4CSFsleD/lsa31nNkGGMYn/YjQz2Ft0XgzZZ49KGx8gULrcg9c?=
 =?iso-8859-1?Q?MKA0rw7WolrFLhT+8S8XX914OdyxmqCKJV9C16m7iukmelxgTi0qAzGJSx?=
 =?iso-8859-1?Q?RWsYe4niCj2Y9XFzqGwuapid5s4N2JKsiVwOTCU1mVNSv8B+U5zapF91dl?=
 =?iso-8859-1?Q?MXXloHQoCrOJ9RlqLgZQpmbLcd0T8sjBVZMJg9NUN33pRtUhMxqIl1WFsC?=
 =?iso-8859-1?Q?ZV0CEEE/BNryiRkfI+7bFhF3aFh8imNFSx3W/4hwzIFHgQ8coWC0q6db51?=
 =?iso-8859-1?Q?RnCiPlUhlp1zCSyxnpjs7wCByeNYiFXmIn3CqYAM49QsqGBP/zycizRziT?=
 =?iso-8859-1?Q?/GaadRjJHfdFuCcNaZmN2qoM1m79eS345OAtq/Cj7HPkY/3Bi/8jtg+4FQ?=
 =?iso-8859-1?Q?GU9o4XrbcQlpjSGhWYZhMOwTHn3IWhdjTkGuiasMPcvjWr7MRDevqb9MDa?=
 =?iso-8859-1?Q?/g1cmHdsr0luZmBYPifsXPmNkICpyWeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bGL7fzTK6oXvRLKIQ4PMk8VvOuRBO23qHZuRbfRw7E1+L5+EN6Qnq5W8tk?=
 =?iso-8859-1?Q?OGYY/WgWBaek4HH1lG0wJDCqrha54YkoFQUhcpPuChj6P3IHciTWB+A3eu?=
 =?iso-8859-1?Q?BzB72fJU+nRiPOMXZEFHk9gOxtk4MSYL2z/aBRTugyCKZ2phHnRUFzFlVS?=
 =?iso-8859-1?Q?iW9gP7zbNVGT+J1quLUqLopD9kYrov4QOn1Hxlw6w6FMgBvgtbEpqaQLzp?=
 =?iso-8859-1?Q?IJMCfUNGBAwYetzLvHG4tT36g/Q+g0K++uMFM3of/6vJlUGhIhxUi619AD?=
 =?iso-8859-1?Q?oxcp3sMWLhgNgLSvGRaF6k+1Zx6d3g4/4vbw235KTwkeVhp9tsP+TPlw3c?=
 =?iso-8859-1?Q?Et7ARE/PwHeewQkqSr/gMDB5ufvJozelFlH9Lx43kpwuFOqdJUh32zeXxJ?=
 =?iso-8859-1?Q?INH8XRqYmr+keHIeBxxpyILlo52sElcOp//riMaI6qT8H1Gr4WQ4/Qcn5z?=
 =?iso-8859-1?Q?sxlzjcyzkHt9CAVTqTeRsrkWLUQc52MLT/W4Ovf+jQsEY4HfQffiXY/TBq?=
 =?iso-8859-1?Q?iixw3BNpqhU5GAj+ADdu9i1lWjXO/ZizlfFCFjpFXKLaTr6yXYkuk921DR?=
 =?iso-8859-1?Q?Ug83AWMk6RKW8U+a7juOqxN+OkgH9t/OX0oapOr2lZ9c0PbAKBUe6/q8us?=
 =?iso-8859-1?Q?GjML0NkMRP3fWcqRJx6me8MunX21rVX3i6GISDd7N06u/cTs6pfI89ehZj?=
 =?iso-8859-1?Q?r1AExS/uQ8Iwr2xgfF+FEKZSytU+vrT5vr8tqMMugxPu6xr3iVeWz14+ZJ?=
 =?iso-8859-1?Q?5VPZO5qp2177q0lmiiil1HleUuQrXM61dqLqay1AT8MHYLzPf4tGPXbHkL?=
 =?iso-8859-1?Q?ZCWPXfU2mHA1gBf/zRYV+pyZRMs3Q51I9a14S9Ist/0kHuD4JdskbvrrHU?=
 =?iso-8859-1?Q?xEccNpTxjbc6S65QhjgSF1/4h91s1nExRAgztWEW3z3pLhSxEfi3qlHsQW?=
 =?iso-8859-1?Q?lNikqInpZ/aWUAw5wmwu5on3wYM7TV0UAIHxDjgmGK1eShyDfozhi+4BJI?=
 =?iso-8859-1?Q?tsgNEaXqIZc5IC1BNFqp+z5m0aaoJ5BZB9yNYh3ykOmDC9q0ZSsPYApaCE?=
 =?iso-8859-1?Q?LAnnTehS1QDWwSkQN05iilWYvpWoTCIC1dbZbEmaf0Vk7AehvhLDUO460q?=
 =?iso-8859-1?Q?L/8sHVE9WP+C6RM8IUfbIDh/2aDn/v0UCuwqUq5RQ8a4PX1QCcefOOrjM0?=
 =?iso-8859-1?Q?LtVZCmjx1Zh1CYIgi8xoig+hoKX1As/1fiKB61EFq1vtOjEOM4XXZKOcon?=
 =?iso-8859-1?Q?a91m7G5YCXh3MBw6kgmxQLz9WqqqQzurv1SJ8LXA+gBpjhqv579Y7NcdJj?=
 =?iso-8859-1?Q?DX0o5CrUjg0AM1nVl103eCjTjzgkmG03WxMvUBZHNu1sCOJVIj0oOY2W5K?=
 =?iso-8859-1?Q?twPRT3lbbviKBAf4X0NG68ma1Pw45p16D9jWbxtGzszhGxfTvs0colnyrm?=
 =?iso-8859-1?Q?ANGTj4UPHQ2qWeQ3XWG7ZfjLyNq42An2rzUt+Ctfwj9RJZZAMiBVnWfmzU?=
 =?iso-8859-1?Q?LhLuRvzPANlG3WUSeI8k7DINlYG2tA1My8+cWFZ1a3QN2FJGvDxlabGmiF?=
 =?iso-8859-1?Q?KDes0V3VewfXE+3hYY+u4qa0nJfvtVzbxE//4WKq/wV2vtuRZdR7Adlvpl?=
 =?iso-8859-1?Q?tdUzSxVGgbO30kEleBdVq7L20+80ExuH6C1sb4KtmccOfeLjLOUFefiw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7452e8d-7659-4442-c6cd-08dd3f7f6d42
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:37:48.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgfmLFPD60hFVhr7bBnruTghmXkW9VZ6436uH8IG0gASufPjkGzmFDwyb1VJ8pJKMgKXKu71N7iJO1tfUZls7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4576
X-OriginatorOrg: intel.com

hi, Al Viro,

On Mon, Jan 27, 2025 at 07:26:16PM +0000, Al Viro wrote:
> On Sun, Jan 26, 2025 at 04:16:04PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 11.7% regression of will-it-scale.per_process_ops on:
> > 
> > 
> > commit: 89359897983825dbfc08578e7ee807aaf24d9911 ("do_pollfd(): convert to CLASS(fd)")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test faield on linus/master      b46c89c08f4146e7987fc355941a93b12e2c03ef]
> > [test failed on linux-next/master 5ffa57f6eecefababb8cbe327222ef171943b183]
> > 
> > testcase: will-it-scale
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > parameters:
> > 
> > 	nr_task: 100%
> > 	mode: process
> > 	test: poll2
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202501261509.b6b4260d-lkp@intel.com
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250126/202501261509.b6b4260d-lkp@intel.com
> 
> Very interesting...  Looking at the generated asm, two things seem to
> change in there- "we need an fput()" case in (now implicit) fdput() in
> do_pollfd() is no longer out of line and slightly different spills are
> done in do_poll().
> 
> Just to make sure it's not a geniune change of logics somewhere,
> could you compare d000e073ca2a, 893598979838 and d000e073ca2a with the
> delta below?  That delta provably is an equivalent transformation - all
> exits from do_pollfd() go through the return in the end, so that just
> shifts the last assignment in there into the caller.

the 'd000e073ca2a with the delta below' has just very similar score as
d000e073ca2a as below.

Tested-by: kernel test robot <oliver.sang@intel.com>


=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/poll2/will-it-scale

commit: 
  d000e073ca ("convert do_select()")
  8935989798 ("do_pollfd(): convert to CLASS(fd)")
  2c43a225261 <--- d000e073ca with the delta below

d000e073ca2a08ab 89359897983825dbfc08578e7ee 2c43a2252614bf1692ef2ad5a46
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    263173           -11.7%     232411            -0.5%     261953        will-it-scale.per_process_ops


below full comparison FYI.

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/poll2/will-it-scale

commit: 
  d000e073ca ("convert do_select()")
  8935989798 ("do_pollfd(): convert to CLASS(fd)")
  2c43a225261 <--- d000e073ca with the delta below

d000e073ca2a08ab 89359897983825dbfc08578e7ee 2c43a2252614bf1692ef2ad5a46
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
  1.98e+08 ± 12%     +15.7%   2.29e+08 ± 18%     -13.1%  1.721e+08        cpuidle..time
     21281 ±147%    +197.5%      63313 ± 84%    +180.7%      59731 ± 86%  numa-meminfo.node0.Shmem
      5318 ±147%    +197.5%      15825 ± 84%    +180.7%      14930 ± 86%  numa-vmstat.node0.nr_shmem
     88607            +0.2%      88803            -1.5%      87297        proc-vmstat.nr_shmem
     11118 ± 15%     +13.6%      12633 ± 51%     -27.7%       8034 ± 10%  proc-vmstat.numa_hint_faults_local
     21894 ±  4%    +135.8%      51630 ±124%    +144.5%      53539 ±117%  sched_debug.cfs_rq:/.load.max
      2575 ±  4%    +106.7%       5323 ±112%    +115.5%       5548 ±106%  sched_debug.cfs_rq:/.load.stddev
      3940 ± 18%     -19.1%       3188 ±  8%     -25.5%       2933 ± 20%  sched_debug.cpu.avg_idle.min
  27370126           -11.7%   24170828            -0.5%   27243222        will-it-scale.104.processes
    263173           -11.7%     232411            -0.5%     261953        will-it-scale.per_process_ops
  27370126           -11.7%   24170828            -0.5%   27243222        will-it-scale.workload
      0.12 ± 16%     -42.1%       0.07 ± 42%     -36.3%       0.07 ± 35%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.33 ± 28%    +154.2%      11.02 ± 61%     +86.2%       8.07 ± 83%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.27 ± 22%     -34.2%       1.49 ± 66%     -48.9%       1.16 ± 36%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    268.62 ± 53%     -61.2%     104.10 ±114%     -39.4%     162.90 ± 82%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1053 ±  6%     -17.1%     873.33 ± 15%      -4.6%       1004 ± 11%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1687 ± 10%     +11.7%       1884 ±  6%      +5.3%       1777 ± 10%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      3519 ±  4%     +11.2%       3913 ±  5%      +3.9%       3656 ±  5%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      8.67 ± 28%    +154.2%      22.04 ± 61%     +86.2%      16.14 ± 83%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    268.45 ± 53%     -61.4%     103.72 ±115%     -39.5%     162.49 ± 83%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.33 ± 28%    +154.2%      11.02 ± 61%     +86.2%       8.07 ± 83%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.01 ±  2%     +10.0%       0.01            +0.7%       0.01 ±  2%  perf-stat.i.MPKI
 5.157e+10           -11.7%  4.554e+10            -0.5%  5.133e+10        perf-stat.i.branch-instructions
 1.573e+08           -11.8%  1.387e+08            +0.0%  1.573e+08        perf-stat.i.branch-misses
      0.97           +13.1%       1.09            +0.2%       0.97        perf-stat.i.cpi
   2.9e+11           -11.7%  2.561e+11            -0.5%  2.887e+11        perf-stat.i.instructions
      1.04           -11.7%       0.91            -0.2%       1.03        perf-stat.i.ipc
      0.00 ±  2%     +17.9%       0.00            +1.4%       0.00 ±  3%  perf-stat.overall.MPKI
      0.96           +13.2%       1.09            +0.2%       0.97        perf-stat.overall.cpi
      1.04           -11.7%       0.92            -0.2%       1.03        perf-stat.overall.ipc
  5.14e+10           -11.7%  4.538e+10            -0.5%  5.116e+10        perf-stat.ps.branch-instructions
 1.567e+08           -11.8%  1.382e+08            +0.0%  1.568e+08        perf-stat.ps.branch-misses
 2.891e+11           -11.7%  2.552e+11            -0.5%  2.877e+11        perf-stat.ps.instructions
 8.743e+13           -11.7%  7.724e+13            -0.5%  8.699e+13        perf-stat.total.instructions
      7.61            -0.6        7.03            +0.0        7.63        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__poll
      6.16            -0.5        5.66            -0.0        6.13        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__poll
      5.11 ±  2%      -0.5        4.62 ±  2%      +0.3        5.44        perf-profile.calltrace.cycles-pp.testcase
      2.92 ±  2%      -0.4        2.55 ±  2%      -0.1        2.85        perf-profile.calltrace.cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.91            -0.3        2.60            +0.0        2.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__poll
      1.92 ±  5%      -0.3        1.67 ±  4%      -0.1        1.84        perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64
      2.12            -0.2        1.91            -0.0        2.10        perf-profile.calltrace.cycles-pp.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.32            -0.2        1.17            -0.0        1.30        perf-profile.calltrace.cycles-pp.__kmalloc_noprof.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.84            -0.1        1.72            +0.0        1.85        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__poll
      0.98            -0.1        0.88 ±  2%      -0.0        0.97        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.97            -0.1        0.88            -0.0        0.94 ±  4%  perf-profile.calltrace.cycles-pp.kfree.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72            -0.1        0.66            -0.0        0.72        perf-profile.calltrace.cycles-pp.__virt_addr_valid.check_heap_object.__check_object_size.do_sys_poll.__x64_sys_poll
      0.62            -0.1        0.57            +0.0        0.62        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     94.36            +0.5       94.89            -0.3       94.03        perf-profile.calltrace.cycles-pp.__poll
     75.76            +2.0       77.76            -0.3       75.45        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
     71.45            +2.4       73.83            -0.3       71.12        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     69.72            +2.5       72.24            -0.4       69.32        perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     69.19            +2.6       71.77            -0.4       68.80        perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     54.05            +4.1       58.18            -0.2       53.85        perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.56            +4.5       43.08            -0.2       38.35        perf-profile.calltrace.cycles-pp.fdget.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      7.68            -0.6        7.10            +0.0        7.70        perf-profile.children.cycles-pp.syscall_return_via_sysret
      6.61            -0.6        6.06            -0.0        6.59        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      5.12 ±  2%      -0.5        4.64 ±  2%      +0.3        5.45        perf-profile.children.cycles-pp.testcase
      3.15 ±  2%      -0.4        2.74 ±  2%      -0.1        3.07        perf-profile.children.cycles-pp._copy_from_user
      3.70            -0.4        3.33            +0.0        3.72        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.94 ±  4%      -0.3        1.69 ±  4%      -0.1        1.86        perf-profile.children.cycles-pp.rep_movs_alternative
      2.26            -0.2        2.04            -0.0        2.25        perf-profile.children.cycles-pp.__check_object_size
      1.35            -0.2        1.19            -0.0        1.33        perf-profile.children.cycles-pp.__kmalloc_noprof
      1.04            -0.1        0.94            -0.0        1.04        perf-profile.children.cycles-pp.check_heap_object
      0.97            -0.1        0.88            -0.0        0.94 ±  4%  perf-profile.children.cycles-pp.kfree
      1.07            -0.1        1.00            +0.0        1.08        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.74            -0.1        0.66            -0.0        0.73        perf-profile.children.cycles-pp.__virt_addr_valid
      0.57            -0.1        0.50            -0.0        0.56 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.63            -0.0        0.58            +0.0        0.63        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.22 ±  2%      -0.0        0.20 ±  2%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.check_stack_object
      0.18 ±  3%      -0.0        0.16            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.07 ±  6%      -0.0        0.06            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.13            -0.0        0.12 ±  3%      +0.0        0.13        perf-profile.children.cycles-pp.x64_sys_call
      0.34            -0.0        0.33            -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.12 ±  3%      -0.0        0.11            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
     94.98            +0.5       95.45            -0.3       94.65        perf-profile.children.cycles-pp.__poll
     75.89            +2.0       77.89            -0.3       75.58        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     71.52            +2.4       73.89            -0.3       71.19        perf-profile.children.cycles-pp.do_syscall_64
     69.78            +2.5       72.29            -0.4       69.38        perf-profile.children.cycles-pp.__x64_sys_poll
     69.28            +2.6       71.85            -0.4       68.89        perf-profile.children.cycles-pp.do_sys_poll
     54.18            +4.1       58.28            -0.2       53.99        perf-profile.children.cycles-pp.do_poll
     38.44            +4.6       43.00            -0.2       38.24        perf-profile.children.cycles-pp.fdget
      7.24            -0.6        6.60            -0.1        7.19        perf-profile.self.cycles-pp.do_sys_poll
      7.68            -0.6        7.09            +0.0        7.70        perf-profile.self.cycles-pp.syscall_return_via_sysret
     16.95            -0.6       16.39            +0.0       16.96        perf-profile.self.cycles-pp.do_poll
      6.55            -0.5        6.00            -0.0        6.52        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.93 ±  2%      -0.5        4.46 ±  2%      +0.3        5.26        perf-profile.self.cycles-pp.testcase
      4.46            -0.4        4.06            +0.0        4.47        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.25            -0.3        2.92            +0.0        3.27        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.78 ±  5%      -0.2        1.54 ±  4%      -0.1        1.70        perf-profile.self.cycles-pp.rep_movs_alternative
      1.34            -0.2        1.18            -0.0        1.33        perf-profile.self.cycles-pp._copy_from_user
      1.16            -0.1        1.02 ±  2%      -0.0        1.15        perf-profile.self.cycles-pp.__kmalloc_noprof
      0.96            -0.1        0.87            -0.0        0.93 ±  4%  perf-profile.self.cycles-pp.kfree
      0.68            -0.1        0.61 ±  2%      -0.0        0.68        perf-profile.self.cycles-pp.__virt_addr_valid
      0.56            -0.1        0.50            -0.0        0.55        perf-profile.self.cycles-pp.__check_heap_object
      0.43            -0.0        0.39            -0.0        0.43        perf-profile.self.cycles-pp.__x64_sys_poll
      0.49            -0.0        0.45            -0.0        0.49        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.29 ±  2%      -0.0        0.26 ±  3%      +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.19            -0.0        0.17 ±  3%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.check_stack_object
      0.26            -0.0        0.25 ±  3%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.check_heap_object
      0.12            -0.0        0.11 ±  3%      +0.0        0.12        perf-profile.self.cycles-pp.x64_sys_call
     36.98            +4.6       41.62            -0.2       36.77        perf-profile.self.cycles-pp.fdget

> 
> diff --git a/fs/select.c b/fs/select.c
> index b41e2d651cc1..e0c816fa4ec4 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -875,8 +875,6 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
>  	fdput(f);
>  
>  out:
> -	/* ... and so does ->revents */
> -	pollfd->revents = mangle_poll(mask);
>  	return mask;
>  }
>  
> @@ -909,6 +907,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
>  			pfd = walk->entries;
>  			pfd_end = pfd + walk->len;
>  			for (; pfd != pfd_end; pfd++) {
> +				__poll_t mask;
>  				/*
>  				 * Fish for events. If we found one, record it
>  				 * and kill poll_table->_qproc, so we don't
> @@ -916,8 +915,9 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
>  				 * this. They'll get immediately deregistered
>  				 * when we break out and return.
>  				 */
> -				if (do_pollfd(pfd, pt, &can_busy_loop,
> -					      busy_flag)) {
> +				mask = do_pollfd(pfd, pt, &can_busy_loop, busy_flag);
> +				pfd->revents = mangle_poll(mask);
> +				if (mask) {
>  					count++;
>  					pt->_qproc = NULL;
>  					/* found something, stop busy polling */
> 

