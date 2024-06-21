Return-Path: <linux-fsdevel+bounces-22087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A9F91206A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 11:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64F51C215FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC316E868;
	Fri, 21 Jun 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dt/0TPep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565452F71
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961874; cv=fail; b=S0fz1ZExN1eXZ8wugUE3JIUNCg40exDFVyuRt5NPgUBj+o1F0/zHe26AARnZvfs6XOEUeAY1M1dJ08tUmfysZKdHibHEEaXNfKMVza7VkvNnl2/QyqDEGInR+hXu5NQ1JtOVEoWCy14vDAygqZuXdxhtYUTDAZI9FOvrYQKLcJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961874; c=relaxed/simple;
	bh=Sfjcr+n+a7qTjT8K/C32cR9h8DQ9tG8ROclItWB3G3Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gEHUOPQo6v7ND472E4LipkzJtVCo4yz3Ci/jei0uUYaFMAtT+GnCV2Q6nbRERSR0F+ZPtsmxQlJ+Ac71g7/IahwM72eEb5n6paxa5wyGLMICM6r1qTVeaNdee5BsbacaVFXMzWlHmXrNj2+fDeIM8KbmDdqeL2dp7IzizAt7lwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dt/0TPep; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718961872; x=1750497872;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Sfjcr+n+a7qTjT8K/C32cR9h8DQ9tG8ROclItWB3G3Y=;
  b=Dt/0TPeptQ+kepVQoBmCpiwuzDqIVQ6KPTamOEyqetyMk4ifu0d9PPWw
   Jl3SthmYVJBL+UUtddahY71GFDPvBN9hac48xn6jLsnST+3uUuST42sB1
   I9N9KKdYSgkqnWr37JPK164y5ztqBQwKwV1EmE+NDembd6nv6nX0Yupi4
   KSSEPBv0KvpiMvwrmQiXHZ4/Sl7VVonSi9xMU3jlNz0nurwxD1HBca669
   pYmCMKlsd/PYFNjjh289p3FVoxa40kj16oxBlJ2+EgOC2u7LXdWcSHIRC
   DcSqU7altpWLObMLfJ+QgaTFHSWfTsu5tMpT7jK9etNlQKpmfNbiEs5Dv
   A==;
X-CSE-ConnectionGUID: bsZBzbaAQ76E06GGNuyXYA==
X-CSE-MsgGUID: e63fNHqxRSmbhuj2jb5n9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33530437"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="33530437"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 02:24:32 -0700
X-CSE-ConnectionGUID: SwNHfLqkS3GLGaOqrlMXCw==
X-CSE-MsgGUID: 5Zu+gnruTYq3WIFfh9esZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="73285938"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 02:24:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 02:24:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 02:24:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 02:24:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 02:24:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEgWL2ECH+sT3Qyu88qXapldDd/TSwqMV8uKMC7QxOpWd/o0u97I/63EAoVQ+naomzXAuBwYFWynC5sMtLB112aEP/QnfavV4yIEUjXCd6buWMjL/xaPnkLBKxBwAb8Yr9WCgMdMsjN4Y6RSc8FZiO+nKBRICFpgn929cmNFaZ+fDJQKSkeUB+A1vSmeGLIy3EOxQjd3zCck+EhAVekjrsKMWcwDU6GEMPIPEFtb42oB3WjddbdAaLFJLXM1lwDZRQIo+Z+sQiyIpwoxXiz8yv4vW+6p8kObd/55EBJhxPxQrTO1aYkQqdnksQcUqF5cLpjVf0RiZY6rK6MeKQTqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOlbR5AOHKlmSOVqQvD+57LNl41jQPiDvX9XZzfTn+4=;
 b=OPhDkf1ey9TOPZxsHKGordYjLVPSnQXxB0hxFw3Zu5U6M6lpN9oobPzvp1j03wBIQtJQsEP5hAgN8UVlkpvTrhqtjPn+v/eDnlH12mXPD16HdgIgsrMKFYNgoNS6cFVRBtdIVJwmzaTyJ/L45itumTnDQSqCQ9i4RQ0P6uGAdd2FQxgd2ZQ/SdID7Q9PqIl1ActtVQgeYQIqqVuaQRV95Q8gb4Ax07JjDZPVAKD9GbvPnJxK2XZ8mWUnrDcP8C+mEIZHKkv7QcWnnZ4utSTvQLW6MPOXLHHGGVMLPtpA+Y7AZJfWsWXYnWzVN/NDwOo2sWY9SOzE1elG4oPyGX0MRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 09:24:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 09:24:23 +0000
Date: Fri, 21 Jun 2024 17:24:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [vfs]  632586fb1b:
 WARNING:at_mm/slub.c:#cache_from_obj
Message-ID: <202406211634.7ef4671b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c364cd7-f7f1-4961-a085-08dc91d3effc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zjJPQCM9188gMErCXYuD2sDZYSvHeVRMqB56eTICm9eq8TFsFybLw9HECPQN?=
 =?us-ascii?Q?sgeEjOf5j0f4w9xof8b0HWQHoYvlBeb3XdCVT7El8v9ERP8PDkAXGgJzTbcd?=
 =?us-ascii?Q?9bI1sM1Uuq6rKIqllJ/1JEsRkWXBh4OWuia6tqsxRZQ4Wos6SuhWFJ432NUJ?=
 =?us-ascii?Q?LEQPIoSLUVNbP73ajrL/Uaw2PfzFU6cUBKi1d4eXUUjpmtegra07U0Fbt09y?=
 =?us-ascii?Q?UBFEPfx+HPVAAeXY8epAEx4KZJYie5AqDOYJXDkKZy/hxSKPvjOPhmty3S7m?=
 =?us-ascii?Q?kbResyAJ++DB79Mfe0H1F+Ym5gTU6h/EQuWuQpLtCB4mn9ff70PwWCYVAnxk?=
 =?us-ascii?Q?gvDWmiwWAce0Rz2/WJDlL9cFa3Tay1KHaUQ4AsqSTb1d3L4puEJX/pjlqjqX?=
 =?us-ascii?Q?r6jl3pAdB4DCRZi4Zj+OCCRVV2A9knJJuibrtaUwTKJaqf6L/X/yvb60vHZU?=
 =?us-ascii?Q?AAFRTDPwpdGNtNh8OvIeg2W5TbXI2Ov+j0FlbZVqL/0QKlZvIBk4dJzbmMWJ?=
 =?us-ascii?Q?rwNPbY5mqnrMeT7EQN5iqz18sI8GiMJzFSDQ6yHZQtXTn3Ptns+Udwe53/oW?=
 =?us-ascii?Q?MgkikLxEF9rGIDRe36jBtW1P0wLSbJ8ynP1Q6uGp3O8QXWiXuLzkC7KHpFy6?=
 =?us-ascii?Q?4D0CspmnF58uGDW3URIthVh8Wt14bQjajanirPdo83lEB2Hn4z92E7EPEHHV?=
 =?us-ascii?Q?j0tk1/HKAdsfC9YmPrgWwencPH+9x1Jl33+JR969S6YJS8doA4IfKGFDDtGZ?=
 =?us-ascii?Q?aTlb+ycBdf3+FV50wiUXSb2PsGVe2aPmFU7y3mE4g5e+zCH9IxBoK5tEeiEU?=
 =?us-ascii?Q?VSlUpxqHCactvjygUMy4psOMfOlX42Xubam0J1lVieqLCjgKTS38CF863WQl?=
 =?us-ascii?Q?Gpfw14Cbanv6pTTZFvy2kODrkwVOpc0kjJztqRpUsGNx98MveJ2JuXppbjov?=
 =?us-ascii?Q?+WrfmyyeRVOoE2J5eY74Es/z4J2MtLhcxoy8JSnXa5ws6ueYj3Z7VNt/CBOI?=
 =?us-ascii?Q?DBzNiOj4I+Ill39hRAcR0InH9uR0zqgyvWD2QlRgRA5r+qvooBbEWSg5Lj8J?=
 =?us-ascii?Q?KLZC0wViHP0QIlsEIC8CRvvGsDXmAW7ViQ7HBF2Rc2XKln/ohyB+g8FgIa7r?=
 =?us-ascii?Q?A3qwsWeLaYmwer8kXmI0ZhhniGOW8+X14IJdnyLyrFpysw/AE9ax+KvMjKVW?=
 =?us-ascii?Q?0ilJ2R8yidvVPQ8jO4MJ4jaRfJ9FFVCTkAfaCK+Eh05SKwljEZU0qLNLl6tn?=
 =?us-ascii?Q?Zc8xjJ8gJiBuy7IVTgok2Iv3s+ODOhbpc4i8sqfqkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDip3EzIjIrMladM6Q4FBuEmpI3rfB71eHqfgtsBjgO50q8CLY7YDWsdotP8?=
 =?us-ascii?Q?88zPUPCsuH1gVNcvn9M0M4Y1LjCiBqiFYNXryVCqkgwpQM7+HhvoWKyOm28W?=
 =?us-ascii?Q?lh98x4ScZCrQ7XzEw7BcFNHO8fpr6tOfNS6L2xPcOccFN39z+cMZKKN7UAan?=
 =?us-ascii?Q?mQKJfKfkxjlLsFTRugXexF7oqcgnfSt7VntQlwY2Tijkx0QdhBpFvp9SahFG?=
 =?us-ascii?Q?pnA/uCWkQgcmryLhPisBAMmiBvgXVWIrchOOvGLO/qd1nX58g5OisTMw9nUR?=
 =?us-ascii?Q?56m28Mjv6iJZ7HCmtF7dVGG8bVsJ1knXuxDn7gXuDZPXh7VebTrM5UgSBlkG?=
 =?us-ascii?Q?o58Z8lOkjZLDvq2Zq/5UQRsdOjYNBczZz768Y7d6ftLMqO2VZ3OJ2sQwj3sA?=
 =?us-ascii?Q?RNzV/3JfkAqCgvDbQuOwCt9fW8sEnP95Lho+w9+A9xxen75PCS4gtz711EFw?=
 =?us-ascii?Q?G8rDjsJaK0O5LkMDrKBwmi07GDm5XdlsRnsLmGJ6zIekegQvlas8dBjTFG8I?=
 =?us-ascii?Q?A/jF4cwYxsErhGJTii2GrDr4ruB1f8kdVGOYLoYGYdIk6ILd6VYzkIunelxG?=
 =?us-ascii?Q?7b7RGabhxxnHWmGjM/GkJ8NmpMN4HPTlrbwTGxdrjpnQ0eHTqLi9Q0FK+D0v?=
 =?us-ascii?Q?8gGfsqkHMAaYQWVdaKNF5LtVcNn+bT4sgxHJ8UvR2EhETtCXTa//KFOC349Q?=
 =?us-ascii?Q?d3Kf7yYuokm39LG/gmf944iCJ5ed/+4BtgbCmCTb/zP9MXgL6PZ/bolPI9gf?=
 =?us-ascii?Q?R8ewwWyRvaCeuvBEaxyBpIpeye1pBlDW21wWGFREHgDhtCh8fPRdEJUPsJaJ?=
 =?us-ascii?Q?FRYTfodqP4XwWM2EsSdXGpmTwLs/Qd4ZIpB0r4akhuvpI6Q3hUaAW+4AbnaS?=
 =?us-ascii?Q?t+PfCuEwDIo87BoSvs5Dvr2WYJZ4wBDTM1tRHCKMphZzCsNuMU1Ca0WHbBeV?=
 =?us-ascii?Q?8RPuipVbOOBqFV7ebgdFle1X4J01jkmHNeoEW5olHu8wNNO3vMuS7vv6UE74?=
 =?us-ascii?Q?W4IGWmkhARoLKwV93CQFv5gQWrHzh2nUCjNwSmwgoyL21OmOlmkZ9ZS3tKKl?=
 =?us-ascii?Q?y8ne2GyK4sR10EpAZJ6tWB9h4dMMajwlkTJOSIagadBLSNu5adDw8IZk4Ux+?=
 =?us-ascii?Q?AhUq+PH6W9msgcBOCLWN70UY8MjYv4poEiI7W1ogGEMHmcYuQdioHTCguruv?=
 =?us-ascii?Q?cyRuznY6NUXKUyx3e0m+4YF2X1Rz1DZm8DZucAjaiI9TdsRz6RnO7RndkHz1?=
 =?us-ascii?Q?7wdzNwiSShWCva+YdPrDeixAW67yeLMmNTyJJApudJPJsTFuhU13XDjLNVLo?=
 =?us-ascii?Q?MCABnb7+FITC1eI2xBuiR3F9D1IuVamRZompiGohQnehyNch1lk1RKrZaQ8U?=
 =?us-ascii?Q?QspBrcV7OcdFkrJKlCALgCkN7kbw5Eti1Xv1yy0SbOkpu0P8Ug2zyeBL7FOk?=
 =?us-ascii?Q?BEjzyBZULRAVEIOBogDhL3S03PAVVsaJnZUaPogv+nV1gntEhImPXICqJfEp?=
 =?us-ascii?Q?lQ/SiE6ipuif1I4jYcLmFpVKa6q3Qs+OqqViueJOz9d8nIw6XPNM6excSbKZ?=
 =?us-ascii?Q?5rf6iW/1NJiY0/7ofhnzk4VM5p2tNNPXkiNBnbcql9+7R52B9Tlre892Uwm8?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c364cd7-f7f1-4961-a085-08dc91d3effc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:24:23.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpLkuusiXB6u0qZhhsAJICnT+vAxl9C+njzfhsYvD9a4D3R7CCt8+8J5qnpP7SMzrFl3JrOrNkibNCMfoVmcww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/slub.c:#cache_from_obj" on:

commit: 632586fb1b5da157f060730549ad45ba9f5e0371 ("vfs: shave a branch in getname_flags")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d0]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed the issue does not always happen, 27 out of 50 runs as below.
but keeps clean on parent.


dff60734fc7606fa 632586fb1b5da157f060730549a
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :50          54%          27:50    dmesg.BUG:KASAN:double-free_in_getname_flags
           :50          54%          27:50    dmesg.RIP:cache_from_obj
           :50          54%          27:50    dmesg.WARNING:at_mm/slub.c:#cache_from_obj



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406211634.7ef4671b-lkp@intel.com


[  270.294992][ T3903] ------------[ cut here ]------------
[  270.296024][ T3903] cache_from_obj: Wrong slab cache. names_cache but object is from kmalloc-64
[ 270.297635][ T3903] WARNING: CPU: 1 PID: 3903 at mm/slub.c:4490 cache_from_obj (mm/slub.c:4490 (discriminator 1)) 
[  270.299438][ T3903] Modules linked in:
[  270.300188][ T3903] CPU: 1 PID: 3903 Comm: trinity-c7 Not tainted 6.10.0-rc1-00012-g632586fb1b5d #1
[  270.301728][ T3903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 270.303625][ T3903] RIP: 0010:cache_from_obj (mm/slub.c:4490 (discriminator 1)) 
[ 270.304640][ T3903] Code: d0 4c 8d 70 ff 4c 89 f3 e9 cd fd ff ff 90 49 8b 4e 60 49 8b 55 60 48 c7 c6 58 30 7c 86 48 c7 c7 08 bd a3 87 e8 1b 12 80 ff 90 <0f> 0b 90 90 b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 00 e7 84
All code
========
   0:	d0 4c 8d 70          	rorb   0x70(%rbp,%rcx,4)
   4:	ff 4c 89 f3          	decl   -0xd(%rcx,%rcx,4)
   8:	e9 cd fd ff ff       	jmp    0xfffffffffffffdda
   d:	90                   	nop
   e:	49 8b 4e 60          	mov    0x60(%r14),%rcx
  12:	49 8b 55 60          	mov    0x60(%r13),%rdx
  16:	48 c7 c6 58 30 7c 86 	mov    $0xffffffff867c3058,%rsi
  1d:	48 c7 c7 08 bd a3 87 	mov    $0xffffffff87a3bd08,%rdi
  24:	e8 1b 12 80 ff       	call   0xffffffffff801244
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	b9 01 00 00 00       	mov    $0x1,%ecx
  33:	31 d2                	xor    %edx,%edx
  35:	be 01 00 00 00       	mov    $0x1,%esi
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	c7                   	.byte 0xc7
  3d:	00 e7                	add    %ah,%bh
  3f:	84                   	.byte 0x84

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	90                   	nop
   4:	b9 01 00 00 00       	mov    $0x1,%ecx
   9:	31 d2                	xor    %edx,%edx
   b:	be 01 00 00 00       	mov    $0x1,%esi
  10:	48                   	rex.W
  11:	c7                   	.byte 0xc7
  12:	c7                   	.byte 0xc7
  13:	00 e7                	add    %ah,%bh
  15:	84                   	.byte 0x84
[  270.322649][ T3903] RSP: 0000:ffffc90005877da0 EFLAGS: 00010246
[  270.323751][ T3903] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[  270.325199][ T3903] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  270.326772][ T3903] RBP: ffffc90005877dd0 R08: 0000000000000000 R09: 0000000000000000
[  270.328141][ T3903] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888163657c00
[  270.329532][ T3903] R13: ffff88810037ea00 R14: ffff8881000418c0 R15: 0000000000000000
[  270.337444][ T3903] FS:  0000000000000000(0000) GS:ffff8883ae600000(0063) knlGS:00000000f7f8a040
[  270.339031][ T3903] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  270.340221][ T3903] CR2: 0000000000000004 CR3: 0000000107680000 CR4: 00000000000406b0
[  270.341572][ T3903] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  270.354716][ T3903] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  270.356112][ T3903] Call Trace:
[  270.356773][ T3903]  <TASK>
[ 270.357370][ T3903] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 270.358166][ T3903] ? cache_from_obj (mm/slub.c:4490 (discriminator 1)) 
[ 270.359164][ T3903] ? __warn (kernel/panic.c:693) 
[ 270.359930][ T3903] ? cache_from_obj (mm/slub.c:4490 (discriminator 1)) 
[ 270.360833][ T3903] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 270.361735][ T3903] ? handle_bug (arch/x86/kernel/traps.c:239 (discriminator 1)) 
[ 270.362633][ T3903] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 270.363485][ T3903] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 270.364477][ T3903] ? cache_from_obj (mm/slub.c:4490 (discriminator 1)) 
[ 270.365528][ T3903] ? __might_fault (mm/memory.c:6233 (discriminator 1)) 
[ 270.366514][ T3903] kmem_cache_free (mm/slub.c:4508) 
[ 270.367386][ T3903] ? strncpy_from_user (lib/strncpy_from_user.c:145) 
[ 270.368374][ T3903] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
[ 270.369368][ T3903] getname_flags (fs/namei.c:197) 
[ 270.370337][ T3903] user_path_at (fs/namei.c:2936) 
[ 270.371150][ T3903] __ia32_sys_oldumount (fs/namespace.c:1916 fs/namespace.c:1934 fs/namespace.c:1932 fs/namespace.c:1932) 
[ 270.372081][ T3903] ? __pfx___ia32_sys_oldumount (fs/namespace.c:1932) 
[ 270.373093][ T3903] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
[ 270.374009][ T3903] ia32_sys_call (arch/x86/entry/syscall_32.c:42) 
[ 270.375005][ T3903] do_int80_emulation (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:253 (discriminator 1)) 
[ 270.375956][ T3903] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[  270.376722][ T3903] RIP: 0023:0xf7f90092
[ 270.377483][ T3903] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
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
https://download.01.org/0day-ci/archive/20240621/202406211634.7ef4671b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


