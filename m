Return-Path: <linux-fsdevel+bounces-19904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564E8CB0FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE43528277C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6C0143C77;
	Tue, 21 May 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZasXqI+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D44143C50;
	Tue, 21 May 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304089; cv=fail; b=Soy8rfCEqWPW46zkZ7DzQ00azx4t+/lQxGYi+aH+ieIzbKrKqzcvuOsE9LntPzufPD+eRrXswvViqorng95wDYw6qaCtcOPuLEUXTX1vKmh9irzsRZJGScUl6/vPopc8xrktIBD0Sy6KKFPG28niTV84X6dDwpGdgJ13/7zjmU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304089; c=relaxed/simple;
	bh=8uVzSN5dW7EaOePCMfm+LcaEgmRFJ7IXl4RO3TcoKCs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=jgLmIr4VJv6aRVqeWf27SdR6XCFCSpfbzvogDCZixC6wKz8NLLrEb89H1uF5hq8Gr4nW5HaMZ1gHlmcndnI3BsF5b8dxqO5DWWATP8/2SMv76/spyEXmN6o/oUeeIoiRijf0ldPjdAiELI5Ta3s9+czN+ioleHwIfP/xjoysw1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZasXqI+V; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716304088; x=1747840088;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8uVzSN5dW7EaOePCMfm+LcaEgmRFJ7IXl4RO3TcoKCs=;
  b=ZasXqI+VMGzDJadpeEuUQsuxuq8h3F7B0wz7FtPXxnEXsxmlvz6PqcPJ
   xNG7uamzAJiik6C5jDEfZrYSLY9ptpV/GCezqHHSUjP55TEFuyKR70qoZ
   ECGP8i3/Q3NQFWh6lpGmqCoxFzJV+5mOioBw/JHIhYiOX3iAIbaz+hXiW
   yPYdad2W6r0x9yTvm+HQ4Z4VyCZzFqJKkzFFiAzCDKVxOKPmeHZYnBhLe
   rncxzJJ8e3uCSZdPerEFojt2ZKGBjAO8Y0yDeXrlVm65n0o2k+iBfqlfp
   yBaD7wFfem3OWRSsvigCurG/32lzNi6S4jMkkzILxJRvQoZYfgyAiuhuC
   w==;
X-CSE-ConnectionGUID: XMaYUZ9hR5avkZo6uXIeDg==
X-CSE-MsgGUID: Z31Z2bhWQOuDX12b1pKvpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="30028727"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="30028727"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 08:07:55 -0700
X-CSE-ConnectionGUID: V8XOO92UQK61S0E7U9WpkA==
X-CSE-MsgGUID: E5Vmn/HoSjOqGPD/D6MoZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33010688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 08:07:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 08:07:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 08:07:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 08:07:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 08:07:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ/q/swpzRvBWKIs0q6HOxcdTYIaGSZLBULWVHzgDAWWI+IdTgoFnOcoXi2/jlJG5cstM8CjSi6/fpVHNr3uOxcBk77VSpuQjv6bPKbaWw67cXrJ4B5RbS4J+YtKywxOfl0ON4M4jcbHXBv7VipozT53j/4xeuRg739W68Av0wucZBIfyNhho83De0xGoRxzxdKM1CtjGfDfGxn7P/Cy1dTMP4nnIQujIxUmXy0vER3TSe6Jk7rD6DjONTvFR2aPc9G8WBfLy3kZ5QThdkpixbp//QqruOiMFtBDMg4X3zQaDMdGKLctMppY42dxJfn5FGhS2fhCTVgWe7dxjZK4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9oxtWNh6BwnhdSzX6AsD4vDqlGrqd8zF4FiZANtqTY=;
 b=bb84fpvfol+vG6b+1yzP4NHGKDQFnILyMHpSVUslL7CuXBJbpFtvYqLZwg3A0EYvgQBNW19S5agIWX7V8XcyugOiBi1Ygb/QoZjeil31ltSr0ZXQ8q9H3v+vK0a5PXdKfe2t9f6XKv9q/1aUOPg4dJG4YHiideI8K+9IN+wirp7vEf3YI+PizFJpTebkbytZbTxGSUWVmc6SjUVpBXd7UNve67BWICmWWFK7fXzWg/4hrwoYYuBkrb0DzNDmsE9z2KkCK39iYKJ23ZfNWV33ft53e6DEBRxJFgK7bn9ogmYwm3VthOiAn4rIJoWUjLbPKt3KP1deF1cFfbwSFA35zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 15:07:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 15:07:47 +0000
Date: Tue, 21 May 2024 23:07:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [viro-vfs:untested.persistency] [rpc_gssd_dummy_populate()]
 5b8fc55107: WARNING:at_fs/namei.c:#lookup_one_len
Message-ID: <202405212204.3561a6e0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9fb6de-edca-4527-7070-08dc79a7c61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ropalTg5dk9SShbFW+5VFnk3QNTnZDYOEDZECdt4w3N2l+gLSirnKbdpsGb1?=
 =?us-ascii?Q?keSOY8IJkLFXK5pIHLXr/hp61LgiY6OT0Zd9PS+CrZAKNjIZmNGMTrggOzzl?=
 =?us-ascii?Q?L92pJ0Wee6yoLcUwTSCi5CiTIf3anRXCiteebdYzvDmLRVri6K9UrXsz+kY+?=
 =?us-ascii?Q?1b97gKzDz6EJhH4P60yR4FniWat11oNsuFroDdWtiHtUCptHEbFmyz54ffV8?=
 =?us-ascii?Q?xrhAWshqKy5NDDiEUmtK9OYDkEYTM41WPrPbTi3ZyQuoRSUtdyrFEePdl36Y?=
 =?us-ascii?Q?pPKuy3xJETihozDYyir2FPBhYPnz6xhP/GiHu8E0UTUoe12JYoLkQXoSnfd8?=
 =?us-ascii?Q?RVyXUfKKqLvi9EoGJVIITnHDX7G+bQorRfOc83Z3s96+7nW98fcNtkrAAlZg?=
 =?us-ascii?Q?LyAIIF0AqkDLy8sKyzSojkZakMGnB24ai8wWJahQNri6h4WSG1svFa33gkB0?=
 =?us-ascii?Q?ZYJqZPkPgx3wBIC2MB+f4YwSmNuY8Py6Qw76CNlkXG4aihstls3t3dtER3II?=
 =?us-ascii?Q?/BoibrDJAAG6fIl1ANMb0KR4EvrbKZBQN/bDFTH6Eq8yEqjVXLFU/VYKcerf?=
 =?us-ascii?Q?3kRizjsPKzBcNzaiMlrn1KbRT8lTYpXazUCxdkXFZxEC8FMMsJMCaz0T/KZu?=
 =?us-ascii?Q?VJ/K004Xze/1Csr6WuuQBgj3f4XnLNS0JLyjaOvcee/goZkqylEhcqVoF/Tu?=
 =?us-ascii?Q?a1AZ0mh8krrtMmwYE1kauuDFYMCepLaCvaJWR1TKldZNpwUUmxOFza/cefZh?=
 =?us-ascii?Q?7PPORh4uQd1TfcxmdPFOMltACS/dnOON061hyHe4L2zFi+kfoHzNlfaa9QPp?=
 =?us-ascii?Q?4VowtrId4MnOtlBBbc+JiUr3BwYnhbEjQtie5E1EPKw4Jb9ehmJF9KxnDVeE?=
 =?us-ascii?Q?DkpJHxKBpmSY3kwPCcv2VznFCsI25JSoQ0uoWhgXrI8iBMNYMEAe2WGkt4EF?=
 =?us-ascii?Q?P5/XRm44Vh1ozRz6ReffDPxOmhFlN8yDfJ3j9KlqW2d784qxzELglkMepyCL?=
 =?us-ascii?Q?PwAw+/E3amQDI4NIKAoUjjbdNvpEseErt2kjSBqrD56CvQ6Pn00PwSLIKHme?=
 =?us-ascii?Q?Lv2LSkSLN0Mjj34NB5DWnYRmsSxmnmbOpevbT7H+XOsqcWz1PqSpr+WrEAP8?=
 =?us-ascii?Q?VHFkIREdIiAxu9RzlWZxXeYDY3VfuZ6N4CdIyPY215c/xVMwVASZNjnwAnVp?=
 =?us-ascii?Q?6w4RqyDDHP8mDg4dV/Netu4JfFKXmXUxTskPHVzK2wS+Mx1osGCeoUEKrKw?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vIMyHD3Puo+pKlq/nv0kvPFjJbRC10zJ1vLz3Sb0vhaiAQpVFYn66wo0pxWm?=
 =?us-ascii?Q?RE6PDh5XqwlNF2PkipEtgA4NtszXgNpbi7nfdrV0KPEFnPgyiVHWSCcXUq92?=
 =?us-ascii?Q?cAmfm+lx4A5i+SmNB5NszcF/IQGRadn+s5MG0CuNpqDoLoGi7ihwPw0ci+u4?=
 =?us-ascii?Q?qE6keRLqmPAXo1ftMz8zjaFepzNfKpLv8hQZZwolsncGzOYD4QaFAS/K+MkT?=
 =?us-ascii?Q?sqw5OxObRfo/xbI/Wj5MWQIJG38B5ZHqwXly5HPKpL0XFvgLMEvMcfhvT+eg?=
 =?us-ascii?Q?xQgri9NHe7QnBvU1um/vD+SRSNQzwsFZw0dN7h7O0WPtn76YeBkc1NGAxaCm?=
 =?us-ascii?Q?ckcfuFzrvY8/EOPLpk5EBczvOK7pvD3qvIxNeWnO+F3rrvwX9kJNEQbqgho1?=
 =?us-ascii?Q?ewX4Tvfg9XulvOTc8nO8OzvBuyhEvZUckQi+MZcaTs3vafMNbQAzeGUhoJT6?=
 =?us-ascii?Q?fiRerevBJELWok6zH9AIrzZVgCjMAbSMIYH8UVZRoJX7diDKG6Y/b7A9OejL?=
 =?us-ascii?Q?bfozuzAmtWOmp0EgfEsmkafi0K3RlnLC8klVMM5nzoD83UrJ4LZD2kRdqBEM?=
 =?us-ascii?Q?qiUlOsuGS+PgaYcvFAD+NZe8tuhh8PiEkKxnUyG++62PZHwEk1Nw1Cfof0QM?=
 =?us-ascii?Q?Oe9zewo++9XpR92jFMCUISEn+IEOJBTvDX4+vhLdTw7T+t+wFZg0Gww2jQv4?=
 =?us-ascii?Q?ts630T49ZxzVelh4r9M7XfmaWedLZKBA7O6Lj1d/ORHEX3potWVQVqtsu3Dx?=
 =?us-ascii?Q?w5qGnmg6L0A4HvcRo5wmPRi9wqAUTHhch/LSvDUIUlaUk6VsU+BafPTZEzHP?=
 =?us-ascii?Q?WIG1Ynvrd2oe0k8clLiloWL2qInOX8bQhrtUA8BFy5hiYhsWIo2bM/c8a374?=
 =?us-ascii?Q?Igpdn/D5bNaNUz4VgVG4IMtTgecUWGvFU657baguKicSKxjt9pI8nP1c7ORF?=
 =?us-ascii?Q?g9MIga8M6aGkRM5443R48zTkAv7rBt/+3SYFfmzpl+j9bpp+U7ab6c5c2Ye4?=
 =?us-ascii?Q?Tm5pNkTK6AVARHUJJOgST/niHOQ+L6y+WX8h17gXUHvPIoPrOBgg5h8D+pO6?=
 =?us-ascii?Q?/gQPooUPkI474UKcRp28BgQjfIxz6m0WoU1T7LvL+EradVrZKsZdczxKLrQg?=
 =?us-ascii?Q?/d9r9meubGmy5rgtqX4hLxCoF8R34z3ZqnoV5Av13xk6RFUReyVw3vF68rlD?=
 =?us-ascii?Q?xSzXCcCQ44PQP1RwNe/Kzl1Dt5zVkoCh4X6ESkObaO3TmehgZUtDL56/ml2v?=
 =?us-ascii?Q?5OC9h/200yt+0dTrKBowZsnoL6fJJgl5no1vCznSvGHFSLSJKMyjg/8d53nq?=
 =?us-ascii?Q?7ybPBHVYHl2upPMvuVrucs0gN91Cd8JL/UZAueNWhnxuTFIhA0zHQQPgCvO4?=
 =?us-ascii?Q?RgjpNXenzGWQkNhMEx2aaCBaC+nvsceR63CMatpali8yP78KEIuG4w0uTqHR?=
 =?us-ascii?Q?+kEOVoqLanYIdHASop3RRg3bOEyHrOhhP5ty0OvcrQq7TgFoYbqqZAlgmqzc?=
 =?us-ascii?Q?SLztrif2VN05xDoKY20feei1rUS4teWexDWf16eoDdotgiS7AiKNl4V0a7PS?=
 =?us-ascii?Q?uclagLLh8jOjavE6Eq0kOnrnQkDMoP1SFCoHcXcwPVxvuQx4tsn66CXuXXdI?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9fb6de-edca-4527-7070-08dc79a7c61c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 15:07:47.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsJyWBz7sHWDUwGoGmWwo4d1oRLAyP9rJpoBULAmtxWpW1DB8+arojFp/8qSbHgEJeyfYyXZMf6e4TFQLGAicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/namei.c:#lookup_one_len" on:

commit: 5b8fc55107547b5e2029da70e48a802555ddebc5 ("rpc_gssd_dummy_populate(): don't bother with rpc_populate()")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git untested.persistency

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------+------------+------------+
|                                       | f1e3e91194 | 5b8fc55107 |
+---------------------------------------+------------+------------+
| WARNING:at_fs/namei.c:#lookup_one_len | 0          | 10         |
| EIP:lookup_one_len                    | 0          | 10         |
+---------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405212204.3561a6e0-lkp@intel.com


[   12.875884][   T78] ------------[ cut here ]------------
[ 12.877101][ T78] WARNING: CPU: 0 PID: 78 at fs/namei.c:2749 lookup_one_len (fs/namei.c:2749 (discriminator 1)) 
[   12.878808][   T78] Modules linked in:
[   12.879785][   T78] CPU: 0 PID: 78 Comm: mount Not tainted 6.9.0-00025-g5b8fc5510754 #1
[   12.881481][   T78] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 12.883591][ T78] EIP: lookup_one_len (fs/namei.c:2749 (discriminator 1)) 
[ 12.884634][ T78] Code: 5d 31 d2 31 c9 c3 8d 74 26 00 31 c9 89 da 89 f0 e8 d5 f7 ff ff 85 c0 75 e2 31 c9 89 da 89 f0 e8 46 fe ff ff eb d5 8d 74 26 00 <0f> 0b eb b4 55 89 e5 56 53 89 cb 83 ec 0c 8b 49 38 c7 45 ec 00 00
All code
========
   0:	5d                   	pop    %rbp
   1:	31 d2                	xor    %edx,%edx
   3:	31 c9                	xor    %ecx,%ecx
   5:	c3                   	ret
   6:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   a:	31 c9                	xor    %ecx,%ecx
   c:	89 da                	mov    %ebx,%edx
   e:	89 f0                	mov    %esi,%eax
  10:	e8 d5 f7 ff ff       	call   0xfffffffffffff7ea
  15:	85 c0                	test   %eax,%eax
  17:	75 e2                	jne    0xfffffffffffffffb
  19:	31 c9                	xor    %ecx,%ecx
  1b:	89 da                	mov    %ebx,%edx
  1d:	89 f0                	mov    %esi,%eax
  1f:	e8 46 fe ff ff       	call   0xfffffffffffffe6a
  24:	eb d5                	jmp    0xfffffffffffffffb
  26:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb b4                	jmp    0xffffffffffffffe2
  2e:	55                   	push   %rbp
  2f:	89 e5                	mov    %esp,%ebp
  31:	56                   	push   %rsi
  32:	53                   	push   %rbx
  33:	89 cb                	mov    %ecx,%ebx
  35:	83 ec 0c             	sub    $0xc,%esp
  38:	8b 49 38             	mov    0x38(%rcx),%ecx
  3b:	c7                   	.byte 0xc7
  3c:	45 ec                	rex.RB in (%dx),%al
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb b4                	jmp    0xffffffffffffffb8
   4:	55                   	push   %rbp
   5:	89 e5                	mov    %esp,%ebp
   7:	56                   	push   %rsi
   8:	53                   	push   %rbx
   9:	89 cb                	mov    %ecx,%ebx
   b:	83 ec 0c             	sub    $0xc,%esp
   e:	8b 49 38             	mov    0x38(%rcx),%ecx
  11:	c7                   	.byte 0xc7
  12:	45 ec                	rex.RB in (%dx),%al
	...
[   12.888482][   T78] EAX: c2ae9824 EBX: c75406d0 ECX: 00000006 EDX: 00000000
[   12.889887][   T78] ESI: c2ae9824 EDI: eba49c64 EBP: eba49bf8 ESP: eba49be4
[   12.891386][   T78] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010246
[   12.892954][   T78] CR0: 80050033 CR2: b7f4f630 CR3: 2ab45000 CR4: 000406d0
[   12.894310][   T78] Call Trace:
[ 12.895022][ T78] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 12.896014][ T78] ? lookup_one_len (fs/namei.c:2749 (discriminator 1)) 
[ 12.896981][ T78] ? __warn (kernel/panic.c:694) 
[ 12.897870][ T78] ? lookup_one_len (fs/namei.c:2749 (discriminator 1)) 
[ 12.898831][ T78] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 12.899934][ T78] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 12.900893][ T78] ? handle_bug (arch/x86/kernel/traps.c:218) 
[ 12.901802][ T78] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 12.902792][ T78] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 12.903923][ T78] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 12.904877][ T78] ? lookup_one_len (fs/namei.c:2749 (discriminator 1)) 
[ 12.905831][ T78] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 12.906751][ T78] ? lookup_one_len (fs/namei.c:2749 (discriminator 1)) 
[ 12.907837][ T78] start_creating_persistent (fs/libfs.c:2157 (discriminator 1)) 
[ 12.908975][ T78] rpc_create_common (net/sunrpc/rpc_pipe.c:492) 
[ 12.910041][ T78] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 12.911039][ T78] ? __d_lookup (fs/dcache.c:2393) 
[ 12.912069][ T78] rpc_new_dir (net/sunrpc/rpc_pipe.c:532 (discriminator 1)) 
[ 12.913007][ T78] ? d_lookup (fs/dcache.c:2317) 
[ 12.913842][ T78] ? rpc_new_dir (net/sunrpc/rpc_pipe.c:532 (discriminator 1)) 
[ 12.914816][ T78] rpc_fill_super (net/sunrpc/rpc_pipe.c:1130 net/sunrpc/rpc_pipe.c:1167) 
[ 12.915900][ T78] ? shrinker_register (arch/x86/include/asm/atomic.h:28 include/linux/atomic/atomic-arch-fallback.h:503 include/linux/atomic/atomic-instrumented.h:68 include/linux/refcount.h:125 mm/shrinker.c:755) 
[ 12.916948][ T78] get_tree_keyed (fs/super.c:1268 fs/super.c:1305) 
[ 12.917939][ T78] ? rpc_kill_sb (net/sunrpc/rpc_pipe.c:1146) 
[ 12.918846][ T78] ? rpc_kill_sb (net/sunrpc/rpc_pipe.c:1146) 
[ 12.919861][ T78] ? get_tree_keyed (fs/super.c:1268 fs/super.c:1305) 
[ 12.920846][ T78] rpc_fs_get_tree (net/sunrpc/rpc_pipe.c:1195) 
[ 12.921836][ T78] vfs_get_tree (fs/super.c:1779) 
[ 12.922768][ T78] do_new_mount (fs/namespace.c:3352) 
[ 12.923821][ T78] path_mount (fs/namespace.c:3679) 
[ 12.924766][ T78] __ia32_sys_mount (fs/namespace.c:3692 fs/namespace.c:3898 fs/namespace.c:3875 fs/namespace.c:3875) 
[ 12.925813][ T78] ia32_sys_call (arch/x86/entry/syscall_32.c:42) 
[ 12.926845][ T78] do_int80_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:339 (discriminator 1)) 
[ 12.927960][ T78] ? do_faccessat (fs/open.c:530) 
[ 12.928987][ T78] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4599) 
[ 12.934850][ T78] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 12.936035][ T78] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 12.937087][ T78] ? __lock_release+0x42/0x148 
[ 12.938193][ T78] ? filemap_map_pages (include/linux/rcupdate.h:813 mm/filemap.c:3615) 
[ 12.939319][ T78] ? filemap_map_pages (include/linux/rcupdate.h:813 mm/filemap.c:3615) 
[ 12.940365][ T78] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 12.941304][ T78] ? filemap_map_pages (mm/filemap.c:3617 (discriminator 2)) 
[ 12.942365][ T78] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1)) 
[ 12.943411][ T78] ? __lock_release+0x42/0x148 
[ 12.944537][ T78] ? do_fault_around (include/linux/rcupdate.h:813 mm/memory.c:4855) 
[ 12.945572][ T78] ? do_fault_around (include/linux/rcupdate.h:813 mm/memory.c:4855) 
[ 12.946583][ T78] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 12.947532][ T78] ? do_fault_around (mm/memory.c:4858) 
[ 12.948449][ T78] ? do_pte_missing (mm/memory.c:4885 mm/memory.c:5024 mm/memory.c:3880) 
[ 12.949473][ T78] ? handle_pte_fault (include/linux/rcupdate.h:813 mm/memory.c:5294) 
[ 12.950502][ T78] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 12.951532][ T78] ? handle_pte_fault (mm/memory.c:5300) 
[ 12.952592][ T78] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1)) 
[ 12.953569][ T78] ? __lock_release+0x42/0x148 
[ 12.954665][ T78] ? do_user_addr_fault (arch/x86/mm/fault.c:1412 (discriminator 1)) 
[ 12.955830][ T78] ? do_user_addr_fault (arch/x86/mm/fault.c:1412 (discriminator 1)) 
[ 12.956945][ T78] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4599) 
[ 12.958255][ T78] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 12.959452][ T78] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 12.960522][ T78] ? exc_page_fault (arch/x86/mm/fault.c:1536) 
[ 12.961548][ T78] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   12.962475][   T78] EIP: 0xb7fa6092
[ 12.963303][ T78] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240521/202405212204.3561a6e0-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


