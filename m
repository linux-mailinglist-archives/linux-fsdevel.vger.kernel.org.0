Return-Path: <linux-fsdevel+bounces-12715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B3862A13
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 12:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775651F215A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7AA10798;
	Sun, 25 Feb 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cfdlt0I8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49BEED5;
	Sun, 25 Feb 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708860552; cv=fail; b=jxPOY6AZ0TJMc9w/leW5cJU0E2pPgIjLV4dEtl1hXRr1CLNjIr5pMYNIqef/iCNKVGz+F+an6bnZOKwPuQ8qOLkyGu+2y8QiSWtIo69PTUHetBhqwtfhSnl5PAfMu5x2G+2o8Rhhgcw1MwxaMcKmn5XBid27SA4xItRjNVYDTP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708860552; c=relaxed/simple;
	bh=5444LbxxZmS9GOJ0fGNdTvaqnng2/kKH9ciYJ+L4yT4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oDMUS8S+c2lTbcnwdAfHXUyvXt5GW0uVa/5euEfs0jhh91o8DFc+47bDVsNUCznopQFpkEK3ZvKSCMYU7nBkihuiamnabdjO/RyzkZzGiFt/m/BBB2Jz6i92GV4NJIC9JkC2NF9SiIA23nzXOhWKEEvdCcfXYaZU/frW6wcDK2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cfdlt0I8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708860550; x=1740396550;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5444LbxxZmS9GOJ0fGNdTvaqnng2/kKH9ciYJ+L4yT4=;
  b=Cfdlt0I8lITpCk4ORAsCx66ki/OV8XdAxJ5EgPm0Hy8bYlbPSldLuGzz
   dvzrXYbeP0f8t9qScM9qjh86/VirUIbdBJoJ1j85X2SmnD6BwrN0UuJjb
   dVMCQutIi/4q3dGaPtac2e88EBUfujhZ70Gi7Zi8qrBefHl1gQ+XUlxO0
   nE7ZArKp3RCKP2pDSwViHi+ss1/7c8XAGBYq5PggdQEznG3n7p/NwHeo5
   Of8M3Eaadd2X2qMgo9IO4emPqUENuRKuvMq5mODgFwinYohDQIW4sFLyF
   jYu7S1QFgJVh7aDWY5484Q63vE179OPdVt12AxVNHdM2ohdYrdcvg0U1J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="3023737"
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="3023737"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 03:29:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="6729638"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2024 03:29:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 03:29:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 03:29:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 03:29:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se49oUQF8oaVI8KfP/kt/gzUKIeqLsZZAQ0wCTzTYSAScatBMRsiuy0+H9XmLhq1vDKCilABJSWAd+bKh+xAqsyXPyFvTRuTS/P/l9jy70sPZPuku1NgZFPe4pfui0GvE68OBFi4fQN2pzWqaydKYRVmvUnUVLZys5sOJ8RXHM7XIZMhlFMyUf9gRWoRms65pQ1mxo9KkErQQz/JbniheZcUz/aRP2bx0Oq0ovcOVU5B77ZLBb7/aTJmykm7ev44q9DaLHfDdZDC31DyQ6v4HzGZFv16gOaokGns8OYE1nuNUhYBSxn+EFCPEj1as6LO0e89VMPNMM0/f3dWY/Iyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94rFnxMDOQsolSQ8AQc6DYK5wrBRfVzIFzOA+J9PAlg=;
 b=DFfGX1pHzujC4dbqQkeIqGs4z0AsCAFRduor2b+gJMZqWTZT+z/PwwW2NvaslN0zj77dgOUmnMKYcMnTqKNFIQwGlf78rpMS7YZ7nw6fqXH58GUs/AOrbAjRvOOaULpgNiN8Q8QpguPeCQlEZtnVN9oTguFiVZwsAtb1GniA/5Hht4p6pE87xGHUam1zYwSbf5chIXxta7MR/oi70i8l6ErU3mv9MAwjcaeVJ6lCc6+JWJraGLsBDp/Nx/szl9kj84cPoKYGEUyndU/p/F65esqhLr2F/vmyV5iTxnfL0JLJQfx1i6f01vhzK86+4qtZp+kP2zculroVoZqQGhiC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Sun, 25 Feb
 2024 11:28:09 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::df02:f598:edc:808b]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::df02:f598:edc:808b%5]) with mapi id 15.20.7339.022; Sun, 25 Feb 2024
 11:28:09 +0000
Date: Sun, 25 Feb 2024 19:28:00 +0800
From: Philip Li <philip.li@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: <julie.du@intel.com>, 0day robot <lkp@intel.com>,
	<kdevops@lists.linux.dev>, Joel Granados <j.granados@samsung.com>, "Daniel
 Gomez" <da.gomez@samsung.com>, Christian Brauner <brauner@kernel.org>, "Hugh
 Dickins" <hughd@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>,
	<linux-modules@vger.kernel.org>, Kees Cook <keescook@chromium.org>, "Linux FS
 Devel" <linux-fsdevel@vger.kernel.org>
Subject: Re: Automation with 0-day & kdevops
Message-ID: <ZdskQE0iwFXpPhGw@rli9-mobl>
References: <CAB=NE6VRZFn+jxmxADGb3j7fLzBG9rAJ-9RCddEwz0HtwvtHxg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAB=NE6VRZFn+jxmxADGb3j7fLzBG9rAJ-9RCddEwz0HtwvtHxg@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|SJ0PR11MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 030171e1-07f4-4c84-4f8d-08dc35f4d814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ct0sMHD/1qHiVW/Iv1ALHBCqcjO8CtQLYBDhnjmg4s7FpcpXihIDbRDxiV+57p3k9y+Rx0m29K/Y3Tg9asLsxh1ovGLavhz+jU3dgwDnvqNGwhd/zmm1DlXYxO80YwJ2Hx3/NOceGTvudL5dCRBybo4YcZdwFIWYwu+FjsL5FfrY/JeWmzVRHsJRlsfQpOtM2cg/MZcud5llkoBYPbGJfMwBdz6ZIuCEbQYUv0eeAdDZGaA4nI22U6obt4nlUClV2g8KVutWKlgi5b+bf7WuJZG64/SbyX81ndd/YI8gNIL3srDtzJ8aYgKQlMwehxwgzUrDCODT2ae7gIQ+c2aY3cLx36miZbKxX5d6XChgjiAajUoSyOp10CdwjT30ogixJM8ntbhE9tvdSbc0vZuOP+LjYzyjx0Ho1cK9tbXdUU8XeyJq6WTsuSXXRoySbRIlnQEPa/hAQ+f1vK5ywJGbmZQwX6AXG2iH0bMoHKylrTs57kEmiXhcfmd2QGnkVZsWQk/J/NGnM+STdaLcv32dAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g56NCF0BFhSlmLV4qWfwNZD8mpDybkbcWLJaARzF6BVrFxJUZyzDINDeOQe+?=
 =?us-ascii?Q?Hg1NQ7iTqlg7aFYoI+gdqca1FwZ9MDYmRCilDc4620WEz7CDZW1JahsixRZ8?=
 =?us-ascii?Q?t8CZOrPW8oE61YMtWb0y+cubeg6N8Bejr9sOGAQqzbiNzJlCxc857FNFcIL6?=
 =?us-ascii?Q?mtzV0AP4Sl6rYAUP7fjtLgJqspSFDKzDQ3doDZkNc8440hzusA1W+5bzlsBr?=
 =?us-ascii?Q?4V+pd+cLJbC9/8utUB/w63+p9hcdlQJ7SaKrHZzj4gM49+9ceg6pKz6duRWK?=
 =?us-ascii?Q?NHb0uHHDboxMxWBg90EreGOaqYxwdEd6xMHHN2w6zMIg9FDzwNZkdjb9T/pp?=
 =?us-ascii?Q?4JQ/g410cbclGnID5B5JRLkuGidXXDvQ/UPxgCL5poDqjiMur6s5Hcboi6su?=
 =?us-ascii?Q?gItpxlmeTkuhykTSFzQT4WK9YK14qgw195AvPokArPyxFih7WSWdGqKLf09j?=
 =?us-ascii?Q?3bZMIPX8LOErqX9ap7+EgUvZknnra2LaFuevbEz/9sNDzY0fZ3iyYF4kAKar?=
 =?us-ascii?Q?SxeFr22M+6R3GDPmKS9tDoIBSEtbnYDtzF887MSvjVDxQKyFeREnlQ2wX/d0?=
 =?us-ascii?Q?owifoKHsesxX79+zxfwSjN3p3NkKFa3T+NzPXYabNpuWRwFXPEXvwjKiGfwW?=
 =?us-ascii?Q?1lcVMPceP1GmFk0zQEiElQHyjFHc25Vyxdg/GD6bUNuFB/lz3I1X5sUT76SW?=
 =?us-ascii?Q?1Ieukb0rKCXopaLkncjxQT13ZTCDEyKic4bx6UcPGkEEHGuorPWiDCvkUdjU?=
 =?us-ascii?Q?IBujSoj4mWWMQMuc6jQMdu59ts3jE6X8KWquL8nXVxXsnuHrABvtrXNl1JtH?=
 =?us-ascii?Q?yWyK9tVM+Zb9de/7KfsTExNpKIORYV5OGUNEOZP4ijImewwEallmujaew9uG?=
 =?us-ascii?Q?rFaZIIaWF++Qqek7QHZT82Wjbz5TOMApVwtJ0/uoo/08WI6+t12o/O+D9fAi?=
 =?us-ascii?Q?GPM9ZcFjKCLi2F+Dar2ihiy1phEn9JYlLDCrFRgFDZCyGhTMnB0Hn9YWFdF9?=
 =?us-ascii?Q?ak3f5aispti6NQfkJANrHOWntZ+5fCfsbYgCLLRmCZq2OvAsHLqknnwNKQsE?=
 =?us-ascii?Q?oifQuLINNzNZ8e+CQdtieyspBJol/IsCB6E7rPPbexnezlqcQm8OsDS/nHVx?=
 =?us-ascii?Q?v5p6nfHscZBw81jsbS6D4v5ofRPd4GzY0R7Htr8waKQoy3fz2E9pJe07Drdo?=
 =?us-ascii?Q?qngN8/qOP+nYMOmzHEguuviwBF4XJKWbUGYJjvG/jPuUngup9AMNljam8JbB?=
 =?us-ascii?Q?Jwp84t4VpUd2NbhlQ+3chJAlTVGeUdYu9R2HIgGTn7isT3vba7ADFfnO0mL5?=
 =?us-ascii?Q?ZbmAlJw8qYwmNOBR+JUJ9d+cOpyp7KL2Kb3sMV65N/fnnWHbXB11Zo8vCLHX?=
 =?us-ascii?Q?n3xFaSMnABltRGakZFahX96Vcl9E3+RkmwXwqjHL8qslm6Psrvfi+1ajWfHr?=
 =?us-ascii?Q?yXFS9nhnjhaTgvTkHjFYfC6KzC8iFw4S+9TLvZXvXpW48CVCEnEyE/cngR97?=
 =?us-ascii?Q?xNboKO1CWX0BjxdSaliI6m8ttKofrdsARw2yVoMAYniaBiQfuW2Cb3GmAonk?=
 =?us-ascii?Q?+yanjZtX6Emf5zfIoM8oPzHDt63Zw+yNyn41In0E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 030171e1-07f4-4c84-4f8d-08dc35f4d814
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 11:28:09.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBLh7yiFi14aSxJxIize9qYK/AONa12ROPDWf6H5PAKItUYIoLvFslb90UfmHpJKOiSLjFOJB+i7ZtxqiOAzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com

On Fri, Feb 23, 2024 at 07:44:12AM -0800, Luis Chamberlain wrote:
> Dear 0-day developers,
> 
> kdevops [0] has evolved over the years now to a full automation suite
> for kernel development and testing. As for the later aspects of it, we
> use it to enable complicated subsystem tests such as filesystems
> testing. Our automated filesystem coverage has been rather reduced
> given the complexity, and so one of its goals was to tackle this. It
> also has support to automate testing complex subsystems involving
> custom non-upstream yet for things like qemu as well.
> 
> While long term we'd like to aim towards automating most of the things
> tested under kdevops, it makes sense to start slow with a few simpler
> targets. Since kdevops supports kselftests as well, my recommendation
> is we start with a few selftests for components we have kernel
> maintainers willing to help with either review or help tune up. The
> same applies to filesystems. While we have support to test most
> popular filesystems it makes sense to start with something simple.
> 
> To this end I'd like to see if we can collaborate with 0-day so enable
> automation of testing for the following components, the first 3 of
> which I help maintain:
> 
> With kdevops using its kernel selftests support:
> 
>   * Linux kernel modules: using kernel selftests and userspace kmod tests
>   * Linux firmware loader: firmware selftests
>   * Linux sysctl
> 
> As for filesystems I'd like to start with tmpfs as we have a developer
> who already has a good baseline for it, and is helping to fix some
> fstests bugs found, Daniel Gomez. We also have created different
> target profiles to test tmpfs for the different mount options it
> supports.
> 
> What would this collaboration consist of? Using 0-day's automated to
> git clone kdevops, spawn some resouces and run a series of make
> commands. If git diff returns non-empty we have a new failure.

Thanks Luis, we are glad to collaborate on this. We will learn the detail of
kdevops that the website contains a lot of useful materials. And we will update
our progress to you next month for the questions and next steps.

Thanks

> 
> [0] https://github.com/linux-kdevops/kdevops
> 
>  Luis
> 

