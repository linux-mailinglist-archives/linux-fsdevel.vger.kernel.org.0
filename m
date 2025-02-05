Return-Path: <linux-fsdevel+bounces-40903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441EA28550
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 09:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B8118877DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0FE229B1A;
	Wed,  5 Feb 2025 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4Pvlku+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE422288C8;
	Wed,  5 Feb 2025 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742995; cv=fail; b=EdZBA5rNfSr3IgZxAx3lMqWyD+T3aN4oCUtxAKYP7PeMRJscA5ozFsE8KIN30O8mWbuclQRwcraBH/8UpVePJHQ9IMakJimzjEIzTJQnK7OaVuOiVLkMDyLA2DRZou3KJ2VAJ6P+Y/xl/zU1kt4XVMIFSOuuu9y2YPj/Sqx2meE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742995; c=relaxed/simple;
	bh=xSBnsZtvfLTtCKc7MjfaiACyl72gVTfSpMuTuuZQ5hU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=V1XWDe5jY8pP48CBttbAWg0yAndLNmuPjL7eowYh+Jemx/kIaG81bGRu5HzsLSSBXex762F0g+b4d4o9d0YvG5vaba8GrbFGi40dr7W3NVbjC9bsyZ140buvO9nEVXiALI5tXH2dDacq0X2wpWHs3JyDM7p3CitSscVeJRrghck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4Pvlku+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738742992; x=1770278992;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=xSBnsZtvfLTtCKc7MjfaiACyl72gVTfSpMuTuuZQ5hU=;
  b=I4Pvlku+2D4GQIIEyaL1iSULOZMJX0tsENJh2fqKLeuc49WkvwhHFlR7
   X+ZvHoqztUIMd9QtMz8+i2a48QUisKP92ogCQaztbddz364DnhDGuMpE9
   ds/d1G1yrlgbpO0FuWIVbXNO6j8gXOj0xgeBmRW+MNrT+taYUJMFQDY3B
   rSipec+u54u1BeCaLBSw5DweM2RcaqminOm9eNFoqMNaGm36ZYrd2KyjP
   EgaZzNaOUNp2Kgoi4R8Z1RDIwthrsQvSDBZpH5OjXmx0qWYLlWuBhV3FH
   vgabdlV301P+j3RdPGERngpZvXLr/QFaZ8qdPSrrLnEywvI/VSM0sZNBK
   A==;
X-CSE-ConnectionGUID: OpsUB1vtTfuWgkVx4VOYag==
X-CSE-MsgGUID: LQofCdOVQ0G+WC30hicmaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26900669"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="26900669"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:09:51 -0800
X-CSE-ConnectionGUID: FJdIgeWXRTy1B6FR+ymblg==
X-CSE-MsgGUID: wwFpfqy6SUCTgyj7mMR0Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110719115"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 00:09:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 00:09:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 00:09:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 00:09:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3v2G6JQZFpGK4JEaTL3ISdFEHHwhiPFsl4wFFbtJxEssrUfcMIeMHXymwKMFvi27AbRM+ovjt2cvFzQ4xRJ4eAGvq4hHmgeuRvUSSb8ugOmTIJBLPVN61CsjfI1qyNKhr46Rx12mkDnTipGnAno0LveTDus8p0oFbaVHKZ4Ai7FB/98QEEZKRHp/ATCLHV1sWipEjCEZO0cZH+DPOeI5vKxDcLHgHs1i400a6SoDjBVHg09L7nU/qkAu4W8Mvizl8d/ASqg3eDh6O+BntxgcJDdEbDkAxRAQlnObIxru/1Xa429PRjnh6a5lfc/a52XuZSMA0eBGkqIDAIzdGlNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKdV+29Jz/+rLLkCdokc3hqy3c3nBcbpV+urWmuaqo4=;
 b=eEXWGe6inGHRBaNSQqHf8MUc9ecIF3QN9oJgiEoh3DUSYmQyO6qcmgmyU6efYCw1wuQte55/4iiWhu2OIz2wElRGYGtwCaRs2AEtSKY0M8QfLTQ3eXgOvH1tT0UEJZWV123+XbqZwQUNLz+B8NXSqpwmb0kKi5StTl07A8VzVI1cx/MAxm3R+N2QBMt7YzX4jv9EAxwZed+sZ2sP1G3X3GVXzDRfZJeO/BkvXfikU4XxwqvLsLxTj2xQjrvi4yKuAiC/3pvp/cyatTOzjUOQIVXa/Kzy548h0vpRX1LIuV/oyx1OUhuqu/G3GUomn7+IXObORtrczUBTzaUhpghtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB7525.namprd11.prod.outlook.com (2603:10b6:806:31a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 08:09:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 08:09:45 +0000
Date: Wed, 5 Feb 2025 16:09:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [fsnotify]  a94204f4d4: stress-ng.timerfd.ops_per_sec
 7.0% improvement
Message-ID: <202502051546.fca7cd-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: f9297d68-f2c7-47dd-227c-08dd45bc73c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?rMhANZnN8GGl0by5OAU0ARR/nMhf9XHExEAkPRl9VHRUDsVZOEgPLLmHgJ?=
 =?iso-8859-1?Q?F/j1Vkv8sxqKEnbkacGsuuxWiL4ggLeGA5SsgFNYgi61R+O2ssYJEx1DMQ?=
 =?iso-8859-1?Q?pk9gMwsOkmckfHZKv+Jnkb+hP/jI5hTtX/4XzUtXs94f8pXTkQ+18c9R5F?=
 =?iso-8859-1?Q?yF415AHw1UQJP4m5VyvdRk4kXEjyQM/K01HfHNcaid+NMnSHgeX6bMO5Uk?=
 =?iso-8859-1?Q?9Yb7f8B1m274w2RGGhMIyigj48dI4O/R+Uj+BdXaZAJy+dbMUGcnUF5P/i?=
 =?iso-8859-1?Q?+YfyOZOgNo/jyKt6GaAtPnmiDPRBgzc9UXjcIspHWS0tX56rKnhG29OqGZ?=
 =?iso-8859-1?Q?BuIYYcNX1k1dJX4JU+goagCKNrgfIk4o8mnEVR0N4vJeqcxjt/SSFNrgbp?=
 =?iso-8859-1?Q?0fPVeD2ZOO5/tMZEi+G2DFp4kqi5a7JSJ7pOXHCk24ro1w5gZOIeKY6OC4?=
 =?iso-8859-1?Q?fOIunSGMZn1EqUeIEAQcF3NEzJY5BLu110i1PtYionRPJ0ndYKpLvqg1Nq?=
 =?iso-8859-1?Q?mlTBYkfjXD9gZQncpujq7+TVG3tzLNJXEHN0BglizP5/+0OzYvm7LOetVn?=
 =?iso-8859-1?Q?doP9rAIC7Hnj5WAQyKTP5BFULErgeya7tkFnziwGAYj8ThCmXJ3MIcGQr5?=
 =?iso-8859-1?Q?HhbaSz4VxknLQg55uB0hqJoKvvCcOfLaQrv9uKSaP20zixPUqCCArb+HnT?=
 =?iso-8859-1?Q?yE5CAKyQFlY5qgYAB0C149/QbFgvgHu7hy6S0EprG2NhAYOhjIRw018+Sv?=
 =?iso-8859-1?Q?ssxrEa4yZFLhuBYTkel6e5kLrbrb22ACm4lrvGyrjeJjEK2HA/7SQU/Smg?=
 =?iso-8859-1?Q?w7KOHyN4TnYrWEQG/IYbv+gUNqzJwQpIBAnFPE6WAKlifZffHmw1L2GJNY?=
 =?iso-8859-1?Q?rJcw5usRLavsciMgMOjqnJQkt9grzi2y94DU1lS02Ci24x/Iix+2iz/trn?=
 =?iso-8859-1?Q?5DkterVwhf0bF8L2dzlxfMmoBCrIrlpL/JBilFNmsRtjvUjU9LK7+fls9S?=
 =?iso-8859-1?Q?ujB4WEXyMUl/eciFzi/x3O3QrhTenIVe3TwbsxKtY7H99zr4N6S650cihI?=
 =?iso-8859-1?Q?VHODea2lO4G+aFja3zVijEfzccnrq0NQ4pVdIF8dZqhjQmWnF1WtdSwyj1?=
 =?iso-8859-1?Q?1piP90ACkuXrQOcfdLPG58Gc/zsQleWLv1C82L18UxPgZ+5l8drr383kL1?=
 =?iso-8859-1?Q?sBa9aPdurs/MilcH9evS6Tym3L5IeETdYoi4mQdWKZFGjU0gNI5Kxvr7u9?=
 =?iso-8859-1?Q?M+ajMxAS5eQ6UiyBd6wVmArGVB54axr99hFS/8d1e66bXYC1pXnGntQTIG?=
 =?iso-8859-1?Q?4b0mzjshTcNdEjJQycn2ghcQqU2vsBDJWj+7nsOWF/K9Hoe5n8nCRDDpJb?=
 =?iso-8859-1?Q?covQv2aAGKUcgergAC1ztBmHUjpC074Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zmDAz+ZRfYrFgK0WB/CdnADm0YGBFv9Q5VekiL/ZN6hZp86bhlBOpbIWpL?=
 =?iso-8859-1?Q?lbT04x+8lxSxPJdwT4ASZnYNG39SLOEDarlyhOry0yOrr7itzpep4uvYC5?=
 =?iso-8859-1?Q?jCiQuwl8jWDf/rW8z969pf00uVZZjjz8PoyItNzHwCGV/NNIwaTFD1/pUS?=
 =?iso-8859-1?Q?S+ik655pE67mPmt+fRyPaWXlkzCoIcuthiTwHMSMQwBFKcYf+pR5JDql05?=
 =?iso-8859-1?Q?jV46hMkU1UV5JqO6zmhYTACG1VjQwxT6pnKxLWa27I9oUJTJIOJaG6vBjA?=
 =?iso-8859-1?Q?yNO5WpfUGw3taHohzzLy/BbMckeHdYxQvrnSKchQoRZTsdpsX+N+i1PVJS?=
 =?iso-8859-1?Q?rG8caUcGj2mDOoWz5rJG0Vpc1yaUbatgYEo9cdHDyBXNhLnGQDta7dRi9s?=
 =?iso-8859-1?Q?Z0qTAuC5NJ1A3ZIJT/yLFqsRlhbc3Dy454cfsbDh4bkngCObPeoDhNYnEk?=
 =?iso-8859-1?Q?FL6GsCEVnirbPTQ0Z30gi8X/RBYxKOoNQc1c6FTSZkwHyoW2eMuUDJcjGJ?=
 =?iso-8859-1?Q?L8A0kGD83Hpn+1xDKSf/3Gx/nMknTVzgId+K7iqw3RT0QdJ2JVnNCC9nFr?=
 =?iso-8859-1?Q?nFyTlx7dfuG4Sh4An+/+pnCqkDjwLTLYaXGwe0aNIp8wyCjm+hDURv9dJg?=
 =?iso-8859-1?Q?b/vve0xFuEQsrMJynulSeqmmTUsIDLfjVlll4J1f9oY1VMkDwVyG2ezwbw?=
 =?iso-8859-1?Q?6h4twv4tw1uG/JKBVAgTUWM+tplKWkmUPnD72sbq9nUrZI6cBOreX+tSpw?=
 =?iso-8859-1?Q?93KFi5EicL30gT3KgTEkwBQ3L4c3ieDhzyMye8Q1gguBB9ZeunVgbqHFOQ?=
 =?iso-8859-1?Q?sgU9fPaFQxIk7GIlzlxVzzWp1t8cIbo70f2qbM2azicklqBpyQpMuN7l/M?=
 =?iso-8859-1?Q?dsEh2flePr/+O0kzHRbydD/IaXtZm9owC87DNYwxIEdx5mxfga8yoEyiHG?=
 =?iso-8859-1?Q?E79rVaMFz/bP+ygU+ts1MLSDmcMPDNK9iK4i/2Xfg1/y3hRBwn8DQjGM9S?=
 =?iso-8859-1?Q?SFifnLCNx4lmklWei2e/WQ/sBOTCUHYgCx/6bC7a1/CBGEp7Gc5ZP1gpeU?=
 =?iso-8859-1?Q?lBO6VLJq2dqLDOa8/mqyBWC0iRf/p7AzVZDcmx06VIcMBk8owXVyQdFGaR?=
 =?iso-8859-1?Q?Pxs8DDs3XP9GZ4hqA1qDRQqwMaBMeno6opicfHI3qzNArUnwY9xoaXtTBD?=
 =?iso-8859-1?Q?b+WEiCIH4B5wG+s4nIWQxgKDS3K1Yh5F98vbEHZFn/fWo5+fRyU2CHEKxm?=
 =?iso-8859-1?Q?RG7n0wbAKNS5tUbJbQ+UBZXFSywLe0VYBzJ3V+zvlexHqZBm/DI1sgumf8?=
 =?iso-8859-1?Q?Oc6lfg3tKopwAI9tiPAsrhbC8ecksmYtY/zYLJjuJtVoYx1WLm9q1oCMHZ?=
 =?iso-8859-1?Q?NjJzBG6HUJaHLwIE7uCl2M2a+v7F0wVsvbICRuisGo+J43SqxGmNMIgVR6?=
 =?iso-8859-1?Q?hRRTxalTaGa6/XpLX0CbJdWVAyYYmnCVttT7PSgPBBwHcZbApu5KqQurc+?=
 =?iso-8859-1?Q?e5h7IV+ZAykMyvnKWJuDU1xrdTqITbL7/qAXNO3q9wZ3xlWGOjRFtof/qL?=
 =?iso-8859-1?Q?Oj75Gc/wZh9TK56dpcJIR17rXuTXCXTh78eQxNVryO5MpxWR6yUMTRb8hC?=
 =?iso-8859-1?Q?BZ2rwxAY5tVqFMzRkFQcclXXdra+O9ZNJSydyNsKnmOBLlZ6GVeXJ60g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9297d68-f2c7-47dd-227c-08dd45bc73c5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:09:45.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWNSDfu0jdrslRN88FX+J4Y7sgqXUPp7j8CysBUZrVSBbdwjyGFYXhwvxd/vwylk/cXPEkXZTuycGBJG6xVVvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7525
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 7.0% improvement of stress-ng.timerfd.ops_per_sec on:


commit: a94204f4d48e28a711b7ed10399f749286c433e3 ("fsnotify: opt-in for permission events at file open time")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: timerfd
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250205/202502051546.fca7cd-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/timerfd/stress-ng/60s

commit: 
  ebe559609d ("fs: get rid of __FMODE_NONOTIFY kludge")
  a94204f4d4 ("fsnotify: opt-in for permission events at file open time")

ebe559609d7829b5 a94204f4d48e28a711b7ed10399 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     14.06            +4.3       18.32 ±  3%  mpstat.cpu.all.usr%
      2.94 ±  6%     -12.4%       2.58 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
  29801293            -3.3%   28822891        vmstat.system.in
      2647            -5.9%       2491        stress-ng.time.system_time
    450.55           +37.5%     619.62 ±  3%  stress-ng.time.user_time
 3.066e+09            +7.0%  3.282e+09        stress-ng.timerfd.ops
  51076593            +7.0%   54676277        stress-ng.timerfd.ops_per_sec
 3.087e+10            +4.0%  3.209e+10        perf-stat.i.branch-instructions
      0.26 ±  2%      -0.0        0.24 ±  2%  perf-stat.i.branch-miss-rate%
      7.55 ±  9%      +3.4       10.95 ±  8%  perf-stat.i.cache-miss-rate%
  1.47e+08           -37.7%   91593806 ±  3%  perf-stat.i.cache-references
      1.44            -3.3%       1.39        perf-stat.i.cpi
 1.359e+11            +3.4%  1.405e+11        perf-stat.i.instructions
      0.70            +3.4%       0.72        perf-stat.i.ipc
      0.25 ±  2%      -0.0        0.24        perf-stat.overall.branch-miss-rate%
      7.42 ±  9%      +4.0       11.39 ±  9%  perf-stat.overall.cache-miss-rate%
      1.43            -3.3%       1.39        perf-stat.overall.cpi
      0.70            +3.4%       0.72        perf-stat.overall.ipc
 3.036e+10            +4.0%  3.156e+10        perf-stat.ps.branch-instructions
 1.447e+08           -37.7%   90181814 ±  2%  perf-stat.ps.cache-references
 1.337e+11            +3.4%  1.382e+11        perf-stat.ps.instructions
 8.136e+12            +3.7%  8.439e+12        perf-stat.total.instructions
     13.48            -6.1        7.39 ±  4%  perf-profile.calltrace.cycles-pp.do_timerfd_gettime.__x64_sys_timerfd_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.timerfd_gettime
     34.90            -5.4       29.51 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timerfd_gettime
     33.80            -5.1       28.66 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timerfd_gettime
      5.64 ±  3%      -4.9        0.73 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe.timerfd_gettime
      6.42            -4.0        2.37 ± 20%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_timerfd_gettime.__x64_sys_timerfd_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.69 ±  2%      -2.3        2.36 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.56 ±  2%      -2.3        2.29 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_syscall_64
     38.00            -2.2       35.80        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     39.14            -2.1       37.05        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     29.96            -1.9       28.01        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.16 ±  2%      -1.9        1.23 ± 14%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_timerfd_gettime.__x64_sys_timerfd_gettime.do_syscall_64
      2.61 ±  2%      -1.6        1.02 ± 14%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_timerfd_gettime.__x64_sys_timerfd_gettime
     49.00            -1.5       47.45        perf-profile.calltrace.cycles-pp.read
      2.54 ±  2%      -1.5        0.99 ± 14%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_timerfd_gettime
     25.55            -1.4       24.20 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_timerfd_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.timerfd_gettime
      2.10 ±  4%      -0.9        1.18 ±  5%  perf-profile.calltrace.cycles-pp.fdget.do_timerfd_gettime.__x64_sys_timerfd_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.16            -0.5        3.62        perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.14            -0.2        1.93 ±  2%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.64            -0.1        0.55        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.74            +0.0        0.76        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.do_timerfd_gettime.__x64_sys_timerfd_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.85 ±  2%      +0.0        0.88        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.timerfd_read_iter.vfs_read.ksys_read.do_syscall_64
      0.54 ±  2%      +0.0        0.58 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.rw_verify_area.vfs_read.ksys_read.do_syscall_64
      1.59            +0.0        1.64        perf-profile.calltrace.cycles-pp.timerfd_poll.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.69            +0.1        0.75        perf-profile.calltrace.cycles-pp.ns_to_timespec64.do_timerfd_gettime.__x64_sys_timerfd_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78            +0.1        0.83        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.hrtimer_start_range_ns.timerfd_read_iter.vfs_read.ksys_read
      0.73            +0.1        0.79        perf-profile.calltrace.cycles-pp.hrtimer_forward.timerfd_read_iter.vfs_read.ksys_read.do_syscall_64
      0.94            +0.1        1.02        perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_start_range_ns.hrtimer_start_range_ns.timerfd_read_iter
      1.37            +0.1        1.47        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.20            +0.1        1.31        perf-profile.calltrace.cycles-pp.read_tsc.ktime_get.timerfd_read_iter.vfs_read.ksys_read
      1.28            +0.1        1.38        perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_start_range_ns.hrtimer_start_range_ns.timerfd_read_iter.vfs_read
      1.50            +0.1        1.62        perf-profile.calltrace.cycles-pp.ktime_get.timerfd_read_iter.vfs_read.ksys_read.do_syscall_64
      2.58            +0.1        2.72        perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.82            +0.1        2.96        perf-profile.calltrace.cycles-pp.__poll
      2.81            +0.1        2.95        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      2.81            +0.1        2.95        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
      2.80            +0.1        2.94        perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      2.80            +0.1        2.95        perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      0.56            +0.1        0.71        perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_start_range_ns.timerfd_read_iter.vfs_read
      0.34 ± 70%      +0.2        0.55        perf-profile.calltrace.cycles-pp.fdget.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.59 ±  3%      +0.2        0.82 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.timerfd_read_iter
      0.61 ±  3%      +0.2        0.84 ±  8%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.timerfd_read_iter.vfs_read
      2.66            +0.2        2.89        perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.timerfd_read_iter.vfs_read.ksys_read
      2.65            +0.3        2.91        perf-profile.calltrace.cycles-pp._copy_to_iter.timerfd_read_iter.vfs_read.ksys_read.do_syscall_64
      3.18            +0.3        3.45        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.timerfd_gettime
      0.72 ±  3%      +0.3        0.99 ±  7%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.timerfd_read_iter.vfs_read.ksys_read
      3.18            +0.3        3.46        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      3.94            +0.3        4.25        perf-profile.calltrace.cycles-pp.clear_bhb_loop.timerfd_gettime
      3.96            +0.4        4.32        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
     24.60            +0.4       24.96        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.06 ±  3%      +0.4        1.44 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.timerfd_read_iter.vfs_read.ksys_read.do_syscall_64
      0.57 ±  2%      +0.4        0.99 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.put_itimerspec64.__x64_sys_timerfd_gettime.do_syscall_64
      1.56            +0.4        1.98 ±  5%  perf-profile.calltrace.cycles-pp.stress_timerfd
      1.66            +0.5        2.15        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.timerfd_gettime
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.get_nohz_timer_target.__hrtimer_start_range_ns.hrtimer_start_range_ns.timerfd_read_iter.vfs_read
      2.18            +0.5        2.73        perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_start_range_ns.timerfd_read_iter.vfs_read
      0.00            +0.5        0.55        perf-profile.calltrace.cycles-pp.read_tsc.ktime_get.clockevents_program_event.hrtimer_start_range_ns.timerfd_read_iter
      0.88 ±  2%      +0.6        1.50 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.put_itimerspec64.__x64_sys_timerfd_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.70 ±  9%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.stress_timerfd
      2.90 ±  2%      +0.7        3.64        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.55 ±  2%      +0.8        1.31 ±  5%  perf-profile.calltrace.cycles-pp.sync_regs.asm_sysvec_apic_timer_interrupt.timerfd_gettime
      3.04            +0.8        3.81        perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_start_range_ns.timerfd_read_iter.vfs_read.ksys_read
      0.00            +0.8        0.79 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.put_itimerspec64
      0.00            +0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.put_itimerspec64.__x64_sys_timerfd_gettime
      7.62            +1.3        8.88        perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.timerfd_read_iter.vfs_read.ksys_read.do_syscall_64
      2.11 ±  2%      +1.6        3.66 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt._copy_to_user
      2.17 ±  2%      +1.6        3.77 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt._copy_to_user.put_itimerspec64
      2.62 ±  2%      +1.9        4.56 ±  7%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt._copy_to_user.put_itimerspec64.__x64_sys_timerfd_gettime
     16.65            +2.0       18.61        perf-profile.calltrace.cycles-pp.timerfd_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.48 ±  3%      +2.0        3.48 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.timerfd_gettime
      1.52 ±  3%      +2.1        3.58 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.timerfd_gettime
      1.80 ±  3%      +2.5        4.25 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.timerfd_gettime
      7.90            +3.6       11.54 ±  5%  perf-profile.calltrace.cycles-pp._copy_to_user.put_itimerspec64.__x64_sys_timerfd_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.36 ±  2%      +3.8        9.12 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt._copy_to_user.put_itimerspec64.__x64_sys_timerfd_gettime.do_syscall_64
      9.99            +4.6       14.57 ±  5%  perf-profile.calltrace.cycles-pp.put_itimerspec64.__x64_sys_timerfd_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.timerfd_gettime
      4.90 ±  2%      +6.6       11.49 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.timerfd_gettime
     76.13            -7.4       68.72        perf-profile.children.cycles-pp.do_syscall_64
     77.16            -7.3       69.85        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     14.47            -6.1        8.34 ±  4%  perf-profile.children.cycles-pp.do_timerfd_gettime
     30.34            -2.2       28.19        perf-profile.children.cycles-pp.ksys_read
     49.29            -1.6       47.67        perf-profile.children.cycles-pp.read
     25.92            -1.3       24.58 ±  4%  perf-profile.children.cycles-pp.__x64_sys_timerfd_gettime
      3.05 ±  3%      -1.2        1.86 ±  3%  perf-profile.children.cycles-pp.fdget
     18.64            -0.5       18.13        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.48            -0.4        1.04        perf-profile.children.cycles-pp.x64_sys_call
     15.42            -0.4       15.06        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     15.12            -0.3       14.78        perf-profile.children.cycles-pp.hrtimer_interrupt
      2.44            -0.3        2.09 ±  2%  perf-profile.children.cycles-pp.fdget_pos
      5.25            -0.2        5.04        perf-profile.children.cycles-pp.native_irq_return_iret
      9.86            -0.1        9.73        perf-profile.children.cycles-pp.clockevents_program_event
      7.46            -0.1        7.34        perf-profile.children.cycles-pp.lapic_next_deadline
      2.12            -0.1        2.04        perf-profile.children.cycles-pp.irqtime_account_irq
      1.55            -0.1        1.48        perf-profile.children.cycles-pp.sched_clock_cpu
      1.18            -0.1        1.11        perf-profile.children.cycles-pp.native_sched_clock
      1.74            -0.1        1.68        perf-profile.children.cycles-pp.__irq_exit_rcu
      1.35            -0.1        1.28        perf-profile.children.cycles-pp.sched_clock
      4.02            -0.1        3.96        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      5.09            -0.0        5.05        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.40            -0.0        0.36        perf-profile.children.cycles-pp.clockevents_program_min_delta
      1.21            -0.0        1.17        perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.22 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.__x64_sys_read
      1.02            -0.0        1.00        perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.70            -0.0        0.67        perf-profile.children.cycles-pp.error_entry
      0.22            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.14            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.72            -0.0        0.70        perf-profile.children.cycles-pp.__hrtimer_next_event_base
      1.03            +0.0        1.05        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.33            +0.0        0.36        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.82            +0.0        0.85        perf-profile.children.cycles-pp.hrtimer_forward
      2.50            +0.0        2.55        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.15 ±  5%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.read@plt
      4.95            +0.1        5.01        perf-profile.children.cycles-pp.read_tsc
      0.78            +0.1        0.84        perf-profile.children.cycles-pp.ns_to_timespec64
      1.71            +0.1        1.77        perf-profile.children.cycles-pp.timerfd_poll
      0.86 ±  2%      +0.1        0.93        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.08 ±  6%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      5.56            +0.1        5.65        perf-profile.children.cycles-pp.ktime_get
      2.83            +0.1        2.97        perf-profile.children.cycles-pp.__poll
      2.81            +0.1        2.95        perf-profile.children.cycles-pp.do_sys_poll
      2.81            +0.1        2.95        perf-profile.children.cycles-pp.__x64_sys_poll
      2.66            +0.1        2.81        perf-profile.children.cycles-pp.do_poll
      0.42 ±  2%      +0.2        0.62        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
     29.46            +0.2       29.69        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.88            +0.3        3.16        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.71            +0.3        2.99        perf-profile.children.cycles-pp._copy_to_iter
     24.84            +0.3       25.16        perf-profile.children.cycles-pp.vfs_read
      3.66            +0.3        3.99        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.86 ±  2%      +0.6        2.41 ±  5%  perf-profile.children.cycles-pp.stress_timerfd
      8.00            +0.7        8.67        perf-profile.children.cycles-pp.clear_bhb_loop
      3.24            +0.7        3.91        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.16 ±  2%      +0.8        3.92        perf-profile.children.cycles-pp.rw_verify_area
      0.74 ±  2%      +0.8        1.53 ±  6%  perf-profile.children.cycles-pp.sync_regs
     48.77            +1.3       50.08        perf-profile.children.cycles-pp.timerfd_gettime
     17.26            +2.1       19.36        perf-profile.children.cycles-pp.timerfd_read_iter
      8.73            +4.0       12.72 ±  5%  perf-profile.children.cycles-pp._copy_to_user
     10.42            +4.8       15.19 ±  5%  perf-profile.children.cycles-pp.put_itimerspec64
      4.13            -2.4        1.73        perf-profile.self.cycles-pp.vfs_read
      2.43            -1.6        0.86 ±  3%  perf-profile.self.cycles-pp.ksys_read
      4.55            -1.0        3.52        perf-profile.self.cycles-pp.do_syscall_64
      2.79            -1.0        1.77 ±  5%  perf-profile.self.cycles-pp.do_timerfd_gettime
      1.94 ±  3%      -0.3        1.64 ±  3%  perf-profile.self.cycles-pp.fdget
      5.24            -0.2        5.03        perf-profile.self.cycles-pp.native_irq_return_iret
      0.92            -0.1        0.79        perf-profile.self.cycles-pp.x64_sys_call
      7.41            -0.1        7.29        perf-profile.self.cycles-pp.lapic_next_deadline
      1.13            -0.1        1.06        perf-profile.self.cycles-pp.native_sched_clock
      3.84            -0.1        3.79        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.39            -0.0        0.35        perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.54            -0.0        0.50        perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.66            -0.0        0.64        perf-profile.self.cycles-pp.error_entry
      0.77            -0.0        0.75        perf-profile.self.cycles-pp.hrtimer_interrupt
      0.11 ±  4%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.38            -0.0        0.37        perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.55            -0.0        0.54        perf-profile.self.cycles-pp.irqtime_account_irq
      0.34            -0.0        0.33        perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.79            +0.0        0.80        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.05 ±  8%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.read@plt
      0.78            +0.0        0.80        perf-profile.self.cycles-pp.hrtimer_forward
      0.32            +0.0        0.35        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.72            +0.0        0.75        perf-profile.self.cycles-pp.__x64_sys_timerfd_gettime
      0.32            +0.0        0.35        perf-profile.self.cycles-pp.timerfd_poll
      4.68            +0.0        4.73        perf-profile.self.cycles-pp.read_tsc
      0.47            +0.0        0.52        perf-profile.self.cycles-pp.do_poll
      0.66            +0.1        0.71        perf-profile.self.cycles-pp.ns_to_timespec64
      1.74            +0.1        1.80        perf-profile.self.cycles-pp.read
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.07            +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.86 ±  2%      +0.1        0.93        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.24 ±  2%      +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      2.33            +0.1        2.40        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.89            +0.1        0.98        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.02            +0.1        1.11        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.24 ±  3%      +0.2        1.41 ±  3%  perf-profile.self.cycles-pp.stress_timerfd
      0.90            +0.2        1.14 ±  2%  perf-profile.self.cycles-pp.put_itimerspec64
      2.56            +0.2        2.80        perf-profile.self.cycles-pp._copy_to_iter
      2.79            +0.3        3.05        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.68            +0.3        2.97        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      7.92            +0.7        8.58        perf-profile.self.cycles-pp.clear_bhb_loop
      2.39 ±  2%      +0.7        3.10        perf-profile.self.cycles-pp.rw_verify_area
      0.74 ±  2%      +0.8        1.52 ±  6%  perf-profile.self.cycles-pp.sync_regs
      5.06            +1.3        6.36 ±  3%  perf-profile.self.cycles-pp._copy_to_user
      2.67            +1.7        4.38 ±  3%  perf-profile.self.cycles-pp.timerfd_gettime




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


