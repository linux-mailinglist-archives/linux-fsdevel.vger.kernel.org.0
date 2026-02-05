Return-Path: <linux-fsdevel+bounces-76373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sARUJJpQhGkE2gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 09:11:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C92EFC10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 09:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B039303098D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 08:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF391361DC5;
	Thu,  5 Feb 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUNqAU4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90494361647;
	Thu,  5 Feb 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278996; cv=fail; b=TMo+rGeNobvY42Y4HBgyyPpiAhbT9pxpeP8aOzOPK5T8LBKOOz5Rwzv2TzyOlch9J5PNRfrOw9RV34NItbpgEsXym2u5kesaZLGTldSa+s5bJGvspdn6s7u14j8rMZVI1Y5PO6QpCuhZ1av+GmXia9/OqsIea24WUKjRKgm+0i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278996; c=relaxed/simple;
	bh=B6ZwwjvUCvWstdh9p6aFk3idYr6lQFLPXad4aynGEns=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pnkUS0P/yrNpbudgYEY17Ude+58qL6c0BoLD8/IfO8A+ly1BQi7UryCDlwH0YQnBJJWPyBuZYbqubENOgXU+/Nxy2trO2nTwQ6bm7Mvpni9vCr69rv17UVLdMZbGKjfdN6BFhrkblj0YmSMdE5eRG1zkUoatJLS18dkTjPg3x0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUNqAU4r; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770278995; x=1801814995;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B6ZwwjvUCvWstdh9p6aFk3idYr6lQFLPXad4aynGEns=;
  b=DUNqAU4rLewDKw0ty64SaINiZX1mA+xTZVJnyQ/z2mOTjJobtl1mJw7z
   mbuK0L8HcR59hVbg2b/PNxq2grqew0MCbpdMvWGwlVhSQ5WX3gjCbBkfP
   yEp+y1uWFSUNGW+C3efTziXiQxt4fkhq1MEO+9afHM7rtJRjYDqjppWHN
   WH794qD5gKWczTU3RbLQOHQHjXS9vhZkuPYnsgGL8/b74GfNZC0H5B/3z
   rx2UixzUzalxc5VzVSAXl20OIKZeodPoYw5NTTLr3pkq084+rGDNbExcO
   Mn8jTQGsCIS/2KT9CTpQNB/jiyPZevaebiBbiXATrBP+saMaQBg0mmEyf
   Q==;
X-CSE-ConnectionGUID: PZyQqVyDQrOy8juctjWbag==
X-CSE-MsgGUID: YcC7d3N2Q7isZolhcQuOCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71569578"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71569578"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:09:55 -0800
X-CSE-ConnectionGUID: K3miVKY4S3usFq+OVtOSyQ==
X-CSE-MsgGUID: IZAidgakRKmHehDhKSj64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="209535669"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:09:55 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:09:54 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 00:09:54 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:09:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP411j7m68nokSVWpzx/VFgTLe84dCk5Cz8ZuD5IZxOjGk7YcYAzrxOb8xSJx2XycR81/T1IZCmlPibOFBbbsV9e5sl4SURP7ivngNpsAeGVGU9Tx47cPLWjkUYFvsmsJ4k1LWRuogiWxUauG51oPkZOS+C4iRVFfXDRdHobxND6giv2y6Uy6MawEMoEXQJndP3bARmc1sl705ClqWTRm7j1GWMVKas+gIGCgfz3CIdmXEaPVO65UkTr8E33FjQkYBuJQ/VRIxhUSlU2FjpJgL9icjweh9Av9zzC0uUcy5KzIaJ+9kvuy/jaRI5c6SowAWCqf6lT9JRdQJPLm75Ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hewwCe7i7zoc24DnREJwZBvS2MjltsOsrUwrGf/hUI8=;
 b=KBw/EMld1KRWHbKzlNQRSHYtbDlt4SPOd6tt7/yYSw1PAg/SwyVsO1hL8vikEsaE1Q9ZzB0JrjxmsVvLD71QnBpEDnBZlBug69QZZ2Y9yOll9odtYIkv8kMEEwFcCe73GWh6ljNqtG31iZTnkRFi4y0FTIjMbPT8n8IplC2//1EJLMpwj4R9RcV+XxAJaPSrteHxe+NqcThPn+spsPX/PzV2KCOFml929eMp7s8hm+q+UYTh4chHNY1DcdX+HBNM98BqJR5WP+odq064TOPxlRNK0LI1fZJIPwrImBz6XKFDsQz+jjhCAARMHaD/PT/V/kUUWwy9Bvjl2uigSwRfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:09:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 08:09:47 +0000
Date: Thu, 5 Feb 2026 16:09:38 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jeff Layton
	<jlayton@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [fs]  313c47f4fe:
 BUG:kernel_hang_in_test_stage
Message-ID: <aYRQQmbnJeM7Dr00@xsang-OptiPlex-9020>
References: <202601270735.29b7c33e-lkp@intel.com>
 <20260130-badeunfall-flaggen-d4df12bcb501@brauner>
 <20260131-dahin-nahtlos-06f69134584a@brauner>
 <aYFPw4WeItF84APy@xsang-OptiPlex-9020>
 <20260203-galopp-wachdienst-02c010334a81@brauner>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260203-galopp-wachdienst-02c010334a81@brauner>
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd6a365-1ab8-48da-3b23-08de648ded6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FQpcOH4cZVsk5eMYOY7kTe2hHayaZylKTJjcBL2VSmmxoXnIznVMsA8J2vBd?=
 =?us-ascii?Q?WTTC0Vazlrelc/sxnvRRFfyiy1N6h0ri0qK/hr1VPakUTeulrHvgvzk5410h?=
 =?us-ascii?Q?/7m4bUGMxG4Va0OqjemaQZdXPwrnUzey/k0nPMlMApuNt/8i0Ppee6zKqc2z?=
 =?us-ascii?Q?QdifVJ97TbcF4JWJAUs3vbwrJOFgYJVC+KHoadnT+OdjTcAz5supiHVfZPoN?=
 =?us-ascii?Q?8A0M4YzitgZKg0L71qJJc5dsSrGvbGWvKiJvSHvdAR134xxPX29RyPDwmEqb?=
 =?us-ascii?Q?B3ijRaBxB53kSGmNbKlnjOW9oDG18/Y68IcUSW/QYOSD5SQS3JH9Q+WGauzb?=
 =?us-ascii?Q?YqLQKCibngg7vMW9/E8Txwlhx+m6qM1Rykq9M2wEMglahNxR/37gxRhei7h4?=
 =?us-ascii?Q?WEa5C9hQ8hbPYUL6bh2VhLkurXE1wPH4SgB/icpQvRrcZfb9ko4LkyS0BVlI?=
 =?us-ascii?Q?S41o2jfxqMWk0dK9t35mGs0aa5XbZoxXennp873qw6n1LastP2PLtEnjfWUx?=
 =?us-ascii?Q?pmxR5IzxrvCjb8wWnV5hAkCkiWAzBtScGEO3k1mO186IASAFPgxPnAZo5KuO?=
 =?us-ascii?Q?VeieU522Be4Eottw57aqi9Pjeu8ihewYb7cGBSt5g9Vl20G8RUC5+yULEfmG?=
 =?us-ascii?Q?ErRBVfACxtqmk9i3dhGTRIyIceTd92b+2xiopi0Svqy1KIBSoSHBUCgPxI0u?=
 =?us-ascii?Q?2WADHnWjvw5Q0ac8ao0xZmcFNPnxTaq2rJT4PPrlNbtqo9YDkTlWek8XG3FA?=
 =?us-ascii?Q?Z0P+F5EiKFryj+F1JSBqGc+18fNAtDnvfqWlxEhV00gx6vSdFGVmMZMEgJUR?=
 =?us-ascii?Q?N8ZeaIZEDm+7NSlDT1uKuvVIO/Ws/zRupWUYbkYxSJR0B6h+8Yse91MD3H22?=
 =?us-ascii?Q?FLyrdPcYIB2PbeZV/pUvSs0X+cpK4o6rffCd7m2ml/xgnoCUty5BhF36rNFy?=
 =?us-ascii?Q?N5uOXMmui5q3PTZn3NUH3IGaYzMG7dg+i1go18jJRIe5WspO2EaVVNBVEez6?=
 =?us-ascii?Q?f0sAe9nqXG7kPP7VcBEbBJmrN9Ng7X7D3ePZrSxjjfGp0BtgZEJD/yGy5qWg?=
 =?us-ascii?Q?q4rUokDlmnJ3O2XdJnKpIZenmY+Uhnskp96lQ7AZ4Xua1S1BpEU9PampA4Js?=
 =?us-ascii?Q?gWx9OhXoxfL8aasEizywKF/zHAbTEsflZ8RbX/mQSifjA8BLTMzQsgeIAobo?=
 =?us-ascii?Q?0Wh9j3hSkR5aezqdery5b85tcOjJvQnicK2jMwTval1vMfhM0Sa60ZlXboZF?=
 =?us-ascii?Q?OnQ46u4m9/uIvyhFxC/09864qeasz+PvgwwedYd0pn1oHy1PMFObZty//mgW?=
 =?us-ascii?Q?NANxj7lvPcZybjdvxYhDM6SUo6sGlMtjuwzDjucpZukUZBX1GDISYHWFvMav?=
 =?us-ascii?Q?2m3zGDUKLnGQ4vKFqjlXSq30U4ZrC7YORfi5IUX6vSU6ZOhf9W2WYwNEY3ep?=
 =?us-ascii?Q?j89ECDyjkjnM9/pB+fOWBPDkv8GIuRqOoRq6OhbRN0w4rhjfSF1kGbWtyscz?=
 =?us-ascii?Q?BAm21gOjy48Zh6jCRHfTs0st1I3jgMRtHdk8FC6KPbKve/HVFtfVf49zSmbC?=
 =?us-ascii?Q?xLhUZbTOyNfXAZog4GQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYmIrdIbBCdaeYrNuWX/rCxjGN8BSvlAxs4lB0JxHiJjtk96hSZPNRKbzkRN?=
 =?us-ascii?Q?Z6Tn43o6fXFz5GNSojBmAX3stoJZWE9DvRj6VeVJRA38zd/8Bwzv0shlgkTR?=
 =?us-ascii?Q?Mij2dqj81aEWO5r3T7Rq7jsO0Dhde5LmuUUCxIiFc3FSqxUuzxA+k1Ma4GVq?=
 =?us-ascii?Q?JqAwgc+Akxler48xX4SDvsh6Kz2jj+julYN415ImDlpP4sfCjpZ0yXoJiNBQ?=
 =?us-ascii?Q?jjH8+1BxJuBmF+gOLJBpQR8XqdBfBnzfzFrKWosP3me4K//fXkPsCTXE8hGQ?=
 =?us-ascii?Q?mG6je+r75B4r9wiBaGhfLNUNecgOWiXkwSwmJ14VVs50nkB+gMibLcnwqBey?=
 =?us-ascii?Q?w7LRbcbqcjXeNxLxrfOkSZIoZ/pSNgsNv3liutVo7ZG3wU9tfkHcWqBfDkta?=
 =?us-ascii?Q?PdI8ix0RnpQMiWW+KnORt/+nu20kaawQuDgF/8n3h9VUvqzuBp50AlnwYuYK?=
 =?us-ascii?Q?+N+p6RFlLFmKeVRThgUxiDJBjpHQjx+CVvFXnRq8N2glUmbTCZMKUk4FVeBW?=
 =?us-ascii?Q?pRiHWH8yrFNg0wqEsnogsJq9p7lLY3VUo+qKj+gP1yjJRYD5QwqTBa4HxrUR?=
 =?us-ascii?Q?ziWcK5Lj4tmpHrhzJLHsjP/h3Pn7lDN4mDB8bRvk2dRAtpz8gZEnO+3XkbNz?=
 =?us-ascii?Q?YISKSym4tcsg3yRvYHkVjqXhKHfUL9JiI8CzYZw6LleIdja3IhQPC6ZfoZMm?=
 =?us-ascii?Q?s22ljZc+N+96BEo0YxH5F6MLTNFxkgPKjvoWEmLAFSEaw7NXofGiE14A9vJF?=
 =?us-ascii?Q?7c7M1KqPWJxmcNWUakgPwQtOQnLRZERq/P78q1d2ACO7ag+5pSxuywFMvPlD?=
 =?us-ascii?Q?8C+ptWQ41gjOEyGjPJhHKweu2CsV+ba6Nc+W+U5AcioplrYw3CI4xXVnMLbz?=
 =?us-ascii?Q?Ke4MfL7C9aUK+6EncbYdPlSP0NRDsYyS7vuHnlOL/JYhpqfkkWji8YCPvC1V?=
 =?us-ascii?Q?cSxCZk9bV9xGSw6lcsRmiOU9d7f8X5q9sA3XoyV2Jt1dDWafh7EI1se/mpYq?=
 =?us-ascii?Q?2ckSejDPXKZ/2gaKVF+Rvpvxs027C6vx3Ek11C86r1SyXUXPgcxkOlENGZtz?=
 =?us-ascii?Q?cQ6uHt5mWctG6V09B8y0YCYXcX9Atnp5nMLmmd4YEEvM97Skzr2s+HiQh/sR?=
 =?us-ascii?Q?oWLqqLH4qYls+RO56QfH/48NouJna29WDvCLCXzoZmxBbTiOMGjO6R6nc3t0?=
 =?us-ascii?Q?OpJ/zYF2Gv4ROUXun9MayEFRnjmeFc0w08nbyYFCHj6k6wK4QIRAo6+zwgHQ?=
 =?us-ascii?Q?S24QTup434o+odnS+05si+J4zZZG3suuo5fuZ+2KlKCI4nRZwbTvskTH+1Fh?=
 =?us-ascii?Q?SClO73X4qP3wDXdVDOwAYhEzQeOUqQsIOAAP2H3iM6Avo0AKN5vEFSUDvH/B?=
 =?us-ascii?Q?/BjiqWsHMw7LfBrX3MAgmcgKBWD4FBz2P+KnB09G8bbbi6Koe2tdOIgyt5a/?=
 =?us-ascii?Q?hZGOK0jPJfOYefjP+b8OJzscSzdI5a1/UrG7xXv4wPxt3ND/FkrbEsV6PAlL?=
 =?us-ascii?Q?fPtWedqBrUuTLY03WGqfR9h2bcpwDGKn7oQZXMDhtr96+qhPJKExAOESrL+6?=
 =?us-ascii?Q?K56ir1ClUgegmixR3xofRQDQAWgq4AIgHN+tOjR0dgReQc+bWigLlCe5oF6o?=
 =?us-ascii?Q?5aDRcIbRb++seSzTyIPUJcJDMQDlhnOcn8+MzCL/1p3Cc7ppwZPLAJ08tErv?=
 =?us-ascii?Q?KDtW1YEhOpTcQmCobeadoftoU1+Bm7iGqkLm5L+Ae5dKwjEvq2PYtQT5Jw1j?=
 =?us-ascii?Q?Rk/kzI+R9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd6a365-1ab8-48da-3b23-08de648ded6c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:09:47.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FS2VgYZpxgpqTmTuz8e8fDm/Fg2RqrjHK/LxgI2jLoaiVvBWRC7I2QkmLrhUJCQKa27FLwpgiT5idDub8TZJLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76373-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,2603:10b6:408:1b6::9:received,192.198.163.15:received,40.107.201.57:received,10.22.229.23:received,10.64.159.146:received,10.7.248.11:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 16C92EFC10
X-Rspamd-Action: no action

hi, Christian Brauner,

On Tue, Feb 03, 2026 at 01:57:11PM +0100, Christian Brauner wrote:

[...]

> 
> I manually edited the job-script file to point to something existing on
> the server. If I delete everything that I did and restart the test using
> just the parameters and the job-script provided with your link then I
> run into the issues I mentioned in my first mail again...

[...]

> 
> 
> So I edit job-script and do:
> 
>         # export bm_initrd='/osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz'
>         export bm_initrd='/osimage/pkg/debian-13-x86_64-20250902.cgz/trinity-x86_64-294c4652-1_20251011.cgz'
> 
> but that doesn't work because the glibc version is too old for the
> trinity test thing. So I switch to another bm_initrd:
> 
>         # original: export bm_initrd='/osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz'
>         # export bm_initrd='/osimage/pkg/debian-13-x86_64-20250902.cgz/trinity-x86_64-294c4652-1_20251011.cgz'
>         export bm_initrd='/osimage/pkg/yocto-x86_64-minimal-20190520.cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz'
> 
> And that one got it working and I managed to reproduce the issue.

oh, really sorry about this. this is our code issue. we will fix it.

> 
> The tests executes random VFS system calls including pivot_root(). I
> added debugging output into that system call:
> 
> And then it becomes clear:
> 
>         [   21.185641][ T5251] VFS: BEFORE PIVOT ROOT FROM /var/volatile/tmp to /var/volatile/tmp
>         [   21.185645][ T5251] pivot_root: overmounts from nullfs BEFORE PIVOT ROOT (nullfs):
>         [   21.185646][ T5251]   [0] ffff88816a4e3c80 (rootfs)
>         [   21.185709][ T5251] VFS: AFTER PIVOT ROOT FROM / to /
>         [   21.192478][ T5251] pivot_root: overmounts from nullfs AFTER PIVOT ROOT (nullfs):
>         [   21.192480][ T5251]   [0] ffff88816a4e2d80 (tmpfs)
>         [   21.201027][ T5251]   [1] ffff88816a4e3c80 (rootfs)
> 
>         <snip>
> 
>         [   29.328721][ T5250] VFS: BEFORE PIVOT ROOT FROM /var/volatile/tmp to /var/volatile/tmp
>         [   29.331584][ T5250] pivot_root: overmounts from nullfs BEFORE PIVOT ROOT (nullfs):
>         [   29.334168][ T5250]   [0] ffff88810ca52300 (rootfs)
>         [   29.335742][ T5250] VFS: AFTER PIVOT ROOT FROM / to /
>         [   29.337399][ T5250] pivot_root: overmounts from nullfs AFTER PIVOT ROOT (nullfs):
>         [   29.339935][ T5250]   [0] ffff88811efba300 (tmpfs)
>         [   29.341133][ T5250]   [1] ffff88810ca52300 (rootfs)
> 
>         <snip>
> 
>         [   30.507784][ T1768] /lkp/lkp/src/monitors/meminfo: line 45: date: not found
>         [   30.507784][ T1768] /lkp/lkp/src/monitors/meminfo: line 46: cat: not found
>         [   30.507784][ T1768] /lkp/lkp/src/monitors/meminfo: line 25: /lkp/lkp/src/bin/event/wait: not found
> 
> During random system call execution
> pivot_root("/var/volatile/tmp", "/var/volatile/tmp")
> is called. This makes the "/var/volatile/tmp" tmpfs mount the rootfs for
> everyone and mounts the old rootfs on top of the new rootfs. That means
> as soon as anything is called that relies on binaries that are located
> in the old rootfs they won't find it anymore as the fs root of all
> tasks has been set to /var/volatile/tmp
> 
> Before nullfs that pivot_root() call would have failed because the
> initramfs mount had no parent mount. nullfs makes that finally work.
> 
> I would like to try and enable nullfs unconditional before we resort to
> making it a boot option. pivot_root() is inherently destructive for a
> test setup so I would just do:
> 
> diff --git a/syscalls/pivot_root.c b/syscalls/pivot_root.c
> index 3a33fcc5..13c00b07 100644
> --- a/syscalls/pivot_root.c
> +++ b/syscalls/pivot_root.c
> @@ -11,4 +11,5 @@ struct syscallentry syscall_pivot_root = {
>         .arg2name = "put_old",
>         .arg2type = ARG_ADDRESS,
>         .group = GROUP_VFS,
> +       .flags = AVOID_SYSCALL, /* May end up switching everyone's rootfs. */
>  };
> 
> You would see the same problem if instead of running from the initramfs
> mount you'd be running from a separate rootfs. In other words running
> these tests with a rootfs would surface the same error.
> 
> I'd appreciate it if you would patch trinity with my diff above (no
> attribution needed). I suspect people generally don't run system call
> fuzzers in their workloads so I'd like to move forward and only revert
> if we have to.

got it. we will test later. but as you mentioned, seems like a corner case,
we will pick this after other tasks with high priorities. thanks!


