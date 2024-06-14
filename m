Return-Path: <linux-fsdevel+bounces-21696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2CC908556
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 09:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7623F1C21C7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E3157A43;
	Fri, 14 Jun 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTJkPfrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9514659D;
	Fri, 14 Jun 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351565; cv=fail; b=il8ly4xEBPdCc3p2X5T2An+kKxxUO1MmOPtJLAnS2tBRYboM8gTFpSqEMn+slnKNDEuwQ9sR4Kpg2bHj0uRzSpIDAzsly4CZJZf4HDzneHOzDfjMq/x8CwbJ/yNkcy06hFveYOKxh01zM0VYo6TAnFhmkJU6z+R0BMO1BvH0mmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351565; c=relaxed/simple;
	bh=1EWBsKVIkIlyExzOu4qMa5xPIm0r7WDZWAX4djfQDvE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RZZsiGm8rpMWx3kBG/7+VG8L7dI9sthUCF3DQlGRRP4V4hZXcJ6lZ7kx2CDvKAbGJGl479M4hFwy1vQQJ2j64KkuLiDatcZDFc+32qxyKr8HOTjm6jJ8kylAoNtWRUtMsRUsdonNYu2MmP7wZT3NJkxNloSZ9Jazl/T5g+zeuD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTJkPfrZ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718351561; x=1749887561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1EWBsKVIkIlyExzOu4qMa5xPIm0r7WDZWAX4djfQDvE=;
  b=jTJkPfrZZfNR9cqoqa47/YNWhKt66T25ci5NrpoCD6z1/d9mwZeqaapB
   1OSpKyr6R2l6Xgy6DMuLiLGEM8obD0blWKdvsEq+Zz84gPJzMEPQ3yVz8
   YtEq0QLlzq5qCOfzoUpqXk7YWN/KiRN+/QkLsrf0//LdTigUkJyuetmnj
   xVY7eSU5vzSGOzYq9t48qHhdy/9f/z0+3m60tEMOMCjQXWBJ39PXa3LHj
   sJGC6JHPbd6/uqL13Z6mXzD3bskkIDW+CWEgMHQoNLmngH8g9wwctcBLG
   P1FtkCShJ3CPws4mGkrN6Mszn/CJapRHpZoCxtbxfzLTTqseeuZe6PWbF
   A==;
X-CSE-ConnectionGUID: 8KzsxbtdRUWWE0m1KWZeMg==
X-CSE-MsgGUID: BG/GYO3zTeGM36rjZwnbTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15008633"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15008633"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 00:52:41 -0700
X-CSE-ConnectionGUID: Dm70EozcS8C0lIudi/Iwrg==
X-CSE-MsgGUID: lihWQDXBTfimUQ7aUyf+Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="41102424"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 00:52:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 00:52:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 00:52:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 00:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyAKKZOKIBTPx4ZTOORuyM2IezWjJe9MtdXziEjX8L7SgOWeR6b+6UMeqnDn7f8jyhVvcJJ5msWGrRmllWPdQPoF8fOIdLoE9+/6fnlKRW/g++e0OLu1Sow09MWLti/HDRmUXF5USG79n8PgZOra3yrf9oNXZzTSJKEdULqWcUgx3C7/ljRRwCb/dx2f69/JSclupNZawqiIPOWzF+AbVj82hMEULcj43SFQwCpNuMnT11oLst3MWYFQ/8S40ArjBxGS16z/U+RQd/G5jiqX7jMm7y46UnUypDYv0lNiORPOWVPjLQkhgWtOe9ImCMh8v/KHtQSTB3RHa25cKjdxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A180FNmd0det6WXyvN8yp8nyupkN0ehOm2RkTf8JChQ=;
 b=O8n6/6PicqT/XqvNAs0Tq610xFE1tKlDvyYGbHJrVbMKkVHCJMKOtXpLoAiGOVegvq9/yZ+ua2Pe289LDnqrN2AXqSNG4H1c+pd6Bc0uE+1oByWCjx4PAkzUU3y8Lm+U7W+BbBN5BmuZEZKvocdTRkBzCAEupVGySA9sxnUSkNsEwatcA/EkQJGx6trM4Cuo2ymRlSsZ6zDK6GHfsHXauNz5L8DK/S7H8FpToCP7VGHoHHYiRo3LaJjvrMbMNNR9odHOlnEjDNyjbq/dkVBQ4cC63pIOxNC0trqoL8Ma1zbq8XrPM8fk5CpPhggLRrWmmHO8ZZWhiHPhWXp4ACfHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7086.namprd11.prod.outlook.com (2603:10b6:806:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Fri, 14 Jun
 2024 07:52:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 07:52:37 +0000
Date: Fri, 14 Jun 2024 15:52:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jeff Layton
	<jlayton@kernel.org>, Steve French <sfrench@samba.org>, Paulo Alcantara
	<pc@manguebit.com>, <netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: [dhowells-fs:netfs-writeback] [netfs, cifs]  d639a2f9ab:
 xfstests.generic.080.fail
Message-ID: <202406141533.e9eb9ad9-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: edca2780-f2d8-4efe-7fd4-08dc8c46f528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Er/lR2MdjvekfmJHlNmDG3gOWM9Ftg0ChOUQjwguKuu+lUdzbWejFL6eZqZ8?=
 =?us-ascii?Q?B5DIYi4191nSjmDne5Qq2keh7gopwLXXZ/X0akBOVo7ITHdaXuGVuuUIC/BW?=
 =?us-ascii?Q?BYbVTlt6g4fc9hkPihToWC8MQWcau/znPaXDAvlaUIHip2Oyoof4P/Xxy1PX?=
 =?us-ascii?Q?5zD9afxqc/oAZUPF5Ib8clTEgULH7OZjeRQzTf/MsRMJD7YjIQ+IrqgE0Oqs?=
 =?us-ascii?Q?ifURzVnU3jW83K62fdAvUE1Mdop6aYfQnx+Bq8g0/61AIoewx/lj33viAvTF?=
 =?us-ascii?Q?ZlP5zxfLHTRneO18aCZP+xFSNwUrGznW/tB3NGUfKl821p0o7sSrXde94QFi?=
 =?us-ascii?Q?C9G+LwFcwgyZD8WK6dqLa4eqWB0W7nAb6EOthnnyfksyHlkXwFywFkvlOMSt?=
 =?us-ascii?Q?axCVbDikR3bJFyu+DbGbq45StMxMtFlf/i0FXKCjXSLlrr8I2j/5TT/gIHEw?=
 =?us-ascii?Q?DQqqYhk0vY+39HrR095kRKJIX+/ERqtraKRRNxiCNQJHxpvWm9o22pRpKgnB?=
 =?us-ascii?Q?dkLRE3n7nSxzC6P16sa2hjXDqyf6vVao+U6W226CG0g4f355O47Dx4GzEdI8?=
 =?us-ascii?Q?rIjD7ImeG6PmoDfw7XdRC+zET7N8O8fTuO2UVKZbL44s6r1+Le8MWNt8SgW/?=
 =?us-ascii?Q?uom7XUi370IUAPXjO5Ljs2ZRF9OrUXqasbtELTqkTA+UMEQ7qFzGJ7+MO0MF?=
 =?us-ascii?Q?JX0hXXSenx2Igq6Xe0dY62TEbpmdKOj1MlM/fYaqsuv1iJoMGAhwLfdobYJF?=
 =?us-ascii?Q?hfRxMOQwiY1D4yXtPMguTyL45VM9UDbYiJzFv4xeO7ohSmWmGUmYVvR9Nw8R?=
 =?us-ascii?Q?KT7oQnw9I9OL/sYEqOAiwHEBjME2lrwd49iNOFxANtdpLvqMbWpz+de2dS05?=
 =?us-ascii?Q?HuEUqkt0x/2iYb/qfw6qUMgUb+/y9jYZFGWskUUUjibu2zVmzX1FE563Xc1G?=
 =?us-ascii?Q?Om4+NSlo4d0/4a5TVdQ+psDEiMscYbL+0Be7N5m1I6qjsaIKrsqewCTrF+wl?=
 =?us-ascii?Q?jDMSoY+iFhCZYxQ+0m6urXkIt5rO86xfZ4zEaUXs481n6dWN2zAand7Zx2AY?=
 =?us-ascii?Q?e4FofTTly13g6w+IPVs5kr3JNLdxCfu24zXCPD2IC6aVCvTM6IR7ob4+6V90?=
 =?us-ascii?Q?bBnDNalLYiEi3Bv1MygppaXVEj8rvbbko8aWpkNGDNMaujJ/QClQhlXZpRHB?=
 =?us-ascii?Q?LupyTxMtMaCjKw9GWoyghr1Gt/DtQE/dsL2t+f9zFcqjkrW9IREz37Biqqde?=
 =?us-ascii?Q?mImI0tkkMnELxfr00Ha4BWT1SCyqvycdm13B5R/etw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M2KZkw0akOWhZmAmb82f0YvQoueBcxsGg53dkzk0St5+ypAvCJH1GOlewvfy?=
 =?us-ascii?Q?Anm3yuCQi2UMyUOxhiI0mJ3r4bvitxhB99DwmmX1LsLM7oBjYXFcwV/ilKnX?=
 =?us-ascii?Q?tYyDZ3PrBKA7uGyfv6pxbEq6ayWx6u5JsTA3lKFcZFQtrWslIWcTd/16upym?=
 =?us-ascii?Q?znnrBX6RpyOYRHDakX5C7RcUimaldBVkwF9Yq7r5mK0qLokeG8LZfEB0vsoG?=
 =?us-ascii?Q?ezejNzljYecBYLnQ+wkj6vFuU9SIQjjA2dEleRfn8/HJuKbb6qpiSbDKfn+W?=
 =?us-ascii?Q?eTiTragwbZUFeJbsR+5UJ/n95ZMio2pKsJ3r4pCKl2oyLDOM0H8AkwAHQEOr?=
 =?us-ascii?Q?QeWaY3PDt9C0jSbO5ywsjFyaWzvPgsOBC5SRXt+uT2WAXCPC5sFJxBL3gDFV?=
 =?us-ascii?Q?r3kXtDlc2P/jKW3hlI1SCbcfPG+vxCBPCd4w88B5l1gQVhgXRjkcQYMXamPW?=
 =?us-ascii?Q?2UmnERRonormtqIF1b5ogzQF374xaJlYUEs2c5g9TQCeZa6ixcQq9Hu6vQyr?=
 =?us-ascii?Q?K4P7Ps9xMRvXisKQlXZnMqVf/smr4PKS3AwGNTPcgt82G/GJoti+pg/RtBP2?=
 =?us-ascii?Q?vj7GW5y3AGT2sNZwmseboZhFA6dOeXtU2MmoHvXR+cBWM/H8gaum8LPo/0Jl?=
 =?us-ascii?Q?0EvKkIOOFAthLdRJtZvmxOz+MIecydfEvN1/+NvyhN2hjsiUazjD+Q+2gB2z?=
 =?us-ascii?Q?h7DFv+2l0d4MQ9sW+g1cBaggXQTlIamWWbE3lfo24RM04dyfSKq1RTkeX/1U?=
 =?us-ascii?Q?1ZG1/rAYEA0tyGBc04GqBJXDkO4OxRK+myybB2lFB99bKgqzhnVd4+q5HvvM?=
 =?us-ascii?Q?/abflRXXZXWxb7dTP94esPseIzTYdfAUPlJ1wtEw4dAZSXIdAOMpGoswuf8A?=
 =?us-ascii?Q?KLTPA3whLW/YvnjVvnkpueO4OVJQ7noRhG0oFemiBaVAsHB2OM3g6VkDerk4?=
 =?us-ascii?Q?QpXMeCyKK3+WL1zjeqI2sOkPJ/MFHcJ/tpxpD34gydnaZIlRQ15XQZWaJFyx?=
 =?us-ascii?Q?JTHtkr1baHzJMStTQH+qy7BzOm+rxOTXIUXtmwFdacqz7zv5up1R0j8EqnIQ?=
 =?us-ascii?Q?2NSseJar4qog3cJMr10RdU0FTs89t1awYNioY3Qs/NCsQ6yHrZJhmVHBxRcR?=
 =?us-ascii?Q?SgwffegMs0Ktl5/12505rKLyRtBLvj7NqQyQe7wFisZ5QUaMld+Kokovf45E?=
 =?us-ascii?Q?p3WA2z0sztsKHd6wNwUjd8L/XvIWvn0ZTjQLt7bZwp9VhjCU3S1uOsXsDhkT?=
 =?us-ascii?Q?tznt+p9D6XYGqL/HFWwbWz3WBv8i59MAQBmPQxKim8BfL2cryfYReWrW5xq8?=
 =?us-ascii?Q?kMTOEfSDSvPBCC8NkqQwApQROHMA12gBtfKay0gJSLM64cbzso8Eh5wLkGo8?=
 =?us-ascii?Q?xrrETiZziV60xGoXCHTpWEhFTOrpDj6mo7fcnM4XZz9h/O4FbNK3DgG7Vp9P?=
 =?us-ascii?Q?EnCdN9exafdI193nRPsjHo8UGF+QkH1wfgeChWPL1eS9xad5/AVHCsoKTIKG?=
 =?us-ascii?Q?CSduQ2ZhTpmc5GclzbbOe8Y7sCIj6K30TXdQpFZWpWP3BOOF8ZResx9BowIx?=
 =?us-ascii?Q?9z62uRw2aXOCrX9mhOKhrN2PaWqY2zPuO9f5xEvaKx68hYg0NgKNKNiRCB5n?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edca2780-f2d8-4efe-7fd4-08dc8c46f528
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 07:52:36.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clBsOUZXEW4THgoPl8rPsg0nZQ/f+MA8ZUrFuQ7wmjTK05ciP2ni/IIciaZ4zR1nbdokLlLt6IEM11JPldihdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7086
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.080.fail" on:

commit: d639a2f9abbeb29246eb144e6a3ed9edd3f6d887 ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode")
https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git netfs-writeback

in testcase: xfstests
version: xfstests-x86_64-e46fa3a7-1_20240612
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv3
	test: generic-080



compiler: gcc-13
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406141533.e9eb9ad9-oliver.sang@intel.com

2024-06-13 08:02:14 mount /dev/sdb1 /fs/sdb1
2024-06-13 08:02:15 mkdir -p /smbv3//cifs/sdb1
2024-06-13 08:02:15 export FSTYP=cifs
2024-06-13 08:02:15 export TEST_DEV=//localhost/fs/sdb1
2024-06-13 08:02:15 export TEST_DIR=/smbv3//cifs/sdb1
2024-06-13 08:02:15 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=3.0,mfsymlinks,actimeo=0
2024-06-13 08:02:15 echo generic/080
2024-06-13 08:02:15 ./check -E tests/cifs/exclude.incompatible-smb3.txt -E tests/cifs/exclude.very-slow.txt generic/080
FSTYP         -- cifs
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.10.0-rc2-00003-gd639a2f9abbe #1 SMP PREEMPT_DYNAMIC Thu Jun 13 09:50:57 CST 2024

generic/080       [failed, exit status 2]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/080.out.bad)
    --- tests/generic/080.out	2024-06-12 14:13:57.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/080.out.bad	2024-06-13 08:03:12.373660796 +0000
    @@ -1,2 +1,4 @@
     QA output created by 080
     Silence is golden.
    +mtime not updated
    +ctime not updated
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/080.out /lkp/benchmarks/xfstests/results//generic/080.out.bad'  to see the entire diff)
Ran: generic/080
Failures: generic/080
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240614/202406141533.e9eb9ad9-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


