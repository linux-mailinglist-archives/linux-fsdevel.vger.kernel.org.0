Return-Path: <linux-fsdevel+bounces-38261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5999FE2F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 07:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0742A7A125A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 06:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2819E833;
	Mon, 30 Dec 2024 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbzQR18l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E78165F16;
	Mon, 30 Dec 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735540594; cv=fail; b=N1CdGvf+W+itcxa38jp1HvF976A7m0PUpQeXzGR4YA5B+5+eQ1Jm5aWeFuuUlDIOTiEQ+0Y0ndf6bIhb72VV8Hpkg782w8eXKSYrv7ypfP60EvXg5duA/oDrIwvsHBCZVm421O+I1UwYUAbqP3m3d/ckwmPbxWgvE8Ji95gJ+QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735540594; c=relaxed/simple;
	bh=dgGbwMYT0tH6ilYrorgUUAzEhnHuqfcfT+QbpqOCG/c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=a3sS5ulhFN3pcwhfDtfT++z6NVIjVTlmLQgcRH2bBG0jMOMVXNeq/6mDxCNyHB+P21V6XQjbINAk4g+35AORTp5Mrj2fwJbJpJr+4gp23KTXungYJO9UFBtIstgXlL5B4zVthzkAfo8nAjUVzfi6/6nIwNmdYGsKK28XfmWq7A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbzQR18l; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735540593; x=1767076593;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dgGbwMYT0tH6ilYrorgUUAzEhnHuqfcfT+QbpqOCG/c=;
  b=GbzQR18lkJslsyLHhTZJjogx6p+CmHfXU/xn50JnoUICOReyAE+6DUS8
   LZFDsxoXrWcN/AR8F/yqAykOtqAC8Diuv92RsI24Gh0EHKF6gveJG92Zj
   gTxmT2XHfUE22McSzPK3OEr8ZMeGRnVoLnMhC4s6CTCVBty5PzJYUjzwc
   mfEnMP170PfsOlpETdlWqdG/6QOCHWDhvvru1mxk0/FrnFekk2C5eX4kI
   +3uzyqwS0UcoMNThof9akVK2LlfMy8UHM8+F9ikv/Zi7MyaKOtmTC0JUK
   +/vpw7bNZOYuY4yvgEkSyTiv76FzSsmR4C+mxivmI2otJ2HncuLnZERm6
   g==;
X-CSE-ConnectionGUID: +R0YYTOJR7WSsckx5eJKrg==
X-CSE-MsgGUID: 6rYulW9ARwCqqxqsjiRYGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46821735"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46821735"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 22:36:32 -0800
X-CSE-ConnectionGUID: iv7JRN4hQky9bUypkBnmVw==
X-CSE-MsgGUID: 0sD3xfXCTyKTfVGxyHuVjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104776647"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2024 22:36:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 29 Dec 2024 22:36:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 29 Dec 2024 22:36:05 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 29 Dec 2024 22:36:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS3GRndSIIHkvUweaN/AAgMlMujStaKrlVvd/koKqGiZ57BDhJwfQAy7OCaRW4oGxQT4pwfVf6Wre0YdqbgWTjPzBbxihVvj082eXrJTKHhfKScqO0snKLY01QIGyLwpqz7WUF9IQL/KrOWIJI5Envw+9hru6EGKwCXB0CWm/DA5Ye1c7hCe++Zgkj/nAhVNkCHumURJ8GRoc1je0mhcw4usEbx0TezzDOr588wQAbS9hEJ15R2mZg0xwdiEiM4kgSWPZU+AJjyL84VshPTlc7NrR4rBxXqXgt19zhirY5h+O8auP4yE0HTbMQ2EWhz4TIeFVcXI/U2I2bNSrrBk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93WZ5w8I9QdsO3+mdu9lS1a8dZyZ0eJ2vEYtqX7X0CY=;
 b=PIXJprbfWxhHNWR/C3ih/1phUAXkYS2bepz/owHxMyyFgMU2V2wRmvlwzz65ofXXrFskQ8UdjAItwmGwK/4fWk48ajVBmwY52o6GsgPNq6jmN/dK9YlH2ixw/mkWtZ+1QFDeG2ozWCXQ4c6Ll+uPQt7KAtGQ/NVxx2HnH31P1Mw8/NSH7pkh/UKu7CdYeOSaeMyZUPK1pE9JU7Rzk2Gs96IbXwBVXv6bOTUrKjYre3TJrdoZNFlRh8lEU6pK5fLKxgIvCe1ipmG/tjqdBA88YA2WRAvCT+af4QV0rJYwNKfb36Q10gUCI+sMReAR2KxJ4HBsehSKacK3ejA7dVcf8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7893.namprd11.prod.outlook.com (2603:10b6:610:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 06:35:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 06:35:58 +0000
Date: Mon, 30 Dec 2024 14:35:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>,
	Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fs]  75ead69a71:
 kernel-selftests.filesystems/statmount.statmount_test.fail
Message-ID: <202412301338.77cc6482-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: bc676f50-1b0c-4f45-b738-08dd289c38aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TWjC8HBk2yBabcVCpHquHA9kk/A0c219xS6AZh/GS4wO3/sW+paOVvXCRgc5?=
 =?us-ascii?Q?l3BJeLnZlaq+MHQP1PKa3Nojwbw2mnPsn/eaVxSfd1Fawb9y8a836ileCknD?=
 =?us-ascii?Q?Pz/udlVZHAs6SsHI+tR38WPrAMvNooN2oPOKNMdC13ImZke0cdNilQ/QJCh/?=
 =?us-ascii?Q?Es1Us5V6r/JqXMsH7gG4qvH5fTnXRFdcJW2r22DObhIh/5Ejq3VR83K23FuP?=
 =?us-ascii?Q?a1D1+Z/+YmfjL3xb+ujIQASU1iwpBC0ybh9G5AB1C+kmVBL1Hw6vbcYE0lYy?=
 =?us-ascii?Q?eC+pf5af+GgjKzcPRUptbyfpNzF/8DkT0AoXIH1kt9RXHcUFj6j+Ta02B/Qy?=
 =?us-ascii?Q?o9vFqpWrxb2fckNd2zUK2a2Y5vSolV8TQ451Jct3aNgo0ZbjoEr3fuYi+B5J?=
 =?us-ascii?Q?XNXzYIT/V0leaLgdK6HWh2WsUiyo+TSZScCCSIVKOAYtPA8mBZMeRWgQyMRP?=
 =?us-ascii?Q?+bCPdJZnnLqPYPHNKEX35UQkhcd8aItUoecalnZnYQ7uFywzLokwEkTliHA+?=
 =?us-ascii?Q?P9oXE9gIw7txEnDEKQuRtTqHpH+9vHz8sC7MAPh63AGJ9bcnc3MvEogfKHFe?=
 =?us-ascii?Q?JSXfRWgPPCGpzwtrAfakovQFOFacDfNwwBrVcdTEAV9C4k5AlKuFZJpag+JT?=
 =?us-ascii?Q?umyKB6vJB/8g6kmkDMe9bueR4xj9isoOKrIG6ytAvCyy4PGIf0xdgG61V8eh?=
 =?us-ascii?Q?D+QaYzcWSlVEK6zDAWHHrDAFQVB6ptsgg7uUmMof7eetBEyVaS+8SGQ4+cFf?=
 =?us-ascii?Q?kKIvV05A0RbnyYry/7QTdwoSL4sG48DO9Me6tiDrbpSuTORViTB3zPje+r0w?=
 =?us-ascii?Q?LTc4Df7W6pfn2o5LIYKqi1jBrS1YWAHfNsHQjv/U5TaNKPVn1clTH9y6QzO9?=
 =?us-ascii?Q?oWGfRElSXGHvKkfXdHqwLxCJA+zlaDBRPHkpMOEaNc7staZJ8FRApfGS5Fdj?=
 =?us-ascii?Q?Vbcysa39+/jVRBChCBGIodvHnECkv4WRk5xdLaxMgLnJ7dFYoV19KXM19zBB?=
 =?us-ascii?Q?uPA8xYj3K4pHZexqQOyTcrwoApNCtx3THy+0zmr/mvhNdB66rAdgLxMXf3ha?=
 =?us-ascii?Q?FPtQOin0IyzOU0s7ZY5QfQMz0FNDmiTH/20S4nssmwI9iDAsSBQ4BFQuWwNg?=
 =?us-ascii?Q?n0Nj2ixdFMxUS/RWdyDUCHz7jpe/eMZY8FnGovgBUsgJYvUuYhn9pR64rFKw?=
 =?us-ascii?Q?cO6OsRd7r6oYYnbPBGeb1OCx1MWo8ut0QZCW89c8DA9+IvO/gClgTzW4eOAr?=
 =?us-ascii?Q?cPDIvGzV/Nq8RYzydevDSzyqxNn1ZhWnjme+cWEgMiCHhjFrBjjXG9kXl358?=
 =?us-ascii?Q?jrwu+MRrHrxx+QlZfMnOhdtVashRIbxkhQUaJyMIUo0RbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XqKu/fubSvDF2uAZECaMMC6WOqEdN78Nme76M7VgRu0b3zBnj2BetNEWB/QP?=
 =?us-ascii?Q?AU/KCg0NDo1dCWlZ3GgPMmetFu1RJKSdR4K/uezExSt4Zq/PkDIFma9J/oNx?=
 =?us-ascii?Q?1/CjPqHgU7NeXhda5AA212b24oPI1M7b/NcoG1hOB1BCs5Njq3ZZC+ZQnO5t?=
 =?us-ascii?Q?6yEhnpZCMeTZG5+lelUJKEUkrIiZESEE4j4gvnPeloRYO+QgnEVyWfz8LPPk?=
 =?us-ascii?Q?ZUZQ6mF6NCiR5H0+3uFatuhJ1M17UNANucqyfo8XdmZxrKx7djSVz7Z3EEfJ?=
 =?us-ascii?Q?28cT27A7BKog5T8UqS6VmYUHGmd+MELGXK6xVwXEV28bTxMF+bThszytdajE?=
 =?us-ascii?Q?ciGf7DfXM4XbVAuleXktKrL8n6P6ShQCqMB++F0GpSWkUX+TLUuKPtlAQDsN?=
 =?us-ascii?Q?nZjogUOBfIgalSOax/leEZgq0z/QIBlneLaMIkE9+qg56pYabZ9qgBbXswrD?=
 =?us-ascii?Q?j5w/aHOEodUzscINg0g0pDEU/Z/QS4I3SiVeVw/FC3+T0FE+PuV8mHdqT7A9?=
 =?us-ascii?Q?QsjHD6Rwmjyy2XpJnj35+ychW1qbi9+HeVZeyeixcf1nEfK/0ex028cfG3kR?=
 =?us-ascii?Q?yzEMu98a4qaHZPaYWocZd3fbDUT3IZ6v5kLo59xr9NlCuhBSfJrqTIzTBh7I?=
 =?us-ascii?Q?guHaZ0gRKBYddFWu32Mh53C0nYlketZRIjAnjKWhORZ+LNBJMDKfjXgHMaZR?=
 =?us-ascii?Q?48QD+eAlE6VWmgkW8hepM/SaoK8L8BUWIv59FnRmHp/HFlBpIUurpTh7wqFK?=
 =?us-ascii?Q?bWEThb22A4Y2Avzni6WOVozxnMZAJXQMFKHEJMJ0XqZVX5vl9BLyJ+tZDUz3?=
 =?us-ascii?Q?fdvGaDQpIykvFWi34T7RwSzzJahDn1kBDbdqUPwWXZTqXJBZjNCMEUgXMp4T?=
 =?us-ascii?Q?xfnwLDkllAEcnUbaoL8gUihAj1PmrV7UwCFCg9xpLdsX37FNz3jsBKnBB2SS?=
 =?us-ascii?Q?Rrk7RHOJJEes+3osd3ZfQHfmTpTIU9Byp3019nCrx+G8/uFeJkklZ3wMtJjI?=
 =?us-ascii?Q?2pF0+Dz9h62Wop9hFqz5Klzh2G+2q7d4lH06pi7K3XLTNXhKlBm7UaoOnV/u?=
 =?us-ascii?Q?Pme1tqnacq1zXMNZ1xRmoiWVs1sOt8Huu5b089mHAfCFpfUBjGZlG54XeTzD?=
 =?us-ascii?Q?l4zSR2DX1xhRaf+CQKIFUizIrKznQHbzDx88U3KWj6EcOsp4iYZeJTjR6kqV?=
 =?us-ascii?Q?XFDSl2VCUqi4QVyvRExWHiODrP9EqSfNA9My6d9wqZv4PSVdYSMXRiCsNTJn?=
 =?us-ascii?Q?WQ08GHjheAZBD9haty5xhzEoEAFjsPN05X1zaJPeXbFmfLk7s95xxPtL0/x5?=
 =?us-ascii?Q?GawJJ+xmYJsfmc8znfOOdSt/lceFK6dhSbJidgb+VQhRCJ016LujdvbbOSVy?=
 =?us-ascii?Q?MKXYJbIZHGRtP0O8MbZJtWcwXd9X970j8cy4Ku4Yn3/sSPtFGII2ff2qD464?=
 =?us-ascii?Q?mWp9zdjk08CsyfDNY6DYTxNO8FQ4x9qY9ndO4kXbdUqKf8tDm8KhSyu/fSPP?=
 =?us-ascii?Q?Axy0XKMBLeyw4rxznZV0NWtmbd2wBecZaGbrbhVxiBGetYcA1eRDXeV9Ctcr?=
 =?us-ascii?Q?/pDxaXaHXxr3+ekn8J/WPqtDOOkal2T4j72vthnMGnp+d7HOQP2Mgra6A8uP?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc676f50-1b0c-4f45-b738-08dd289c38aa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 06:35:58.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqVEQPLWpdXG9FzfwCOo98ES3mt0slKGZrQSrZsaqiT0RMI9pK/ci83MDXTpdMQWMdHgxOFXgcLAOiu+RGr2NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7893
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.filesystems/statmount.statmount_test.fail" on:

commit: 75ead69a717332efa70303fba85e1876793c74a9 ("fs: don't let statmount return empty strings")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      8379578b11d5e073792b5db2690faa12effce8e0]
[test failed on linux-next/master 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7503345ac5f5-1_20241208
with following parameters:

	group: filesystems



config: x86_64-dcg_x86_64_defconfig-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412301338.77cc6482-lkp@intel.com


TAP version 13
1..2
# timeout set to 300
# selftests: filesystems/statmount: statmount_test
# TAP version 13
# 1..15
# ok 1 listmount empty root
# ok 2 statmount zero mask
# ok 3 statmount mnt basic
# ok 4 statmount sb basic
# ok 5 statmount mount root
# ok 6 statmount mount point
# ok 7 statmount fs type
# not ok 8 unexpected mount options: 'tmpfs' != ''
# ok 9 statmount string mount root
# ok 10 statmount string mount point
# ok 11 statmount string fs type
# ok 12 statmount string mount root & all
# ok 13 statmount string mount point & all
# ok 14 statmount string fs type & all
# ok 15 listmount tree
# # Totals: pass:14 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: filesystems/statmount: statmount_test # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241230/202412301338.77cc6482-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


