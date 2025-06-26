Return-Path: <linux-fsdevel+bounces-53054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E76AE9586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD69F4A20C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 06:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42742221F1F;
	Thu, 26 Jun 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDE0NkCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12553217F40;
	Thu, 26 Jun 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917670; cv=fail; b=NwreTD4kGmD/r/DKU2gEg/KrBYHP/TlfcB9ZJfaN1U1YgRTIvFoIfqvCbfpfaryzzJjZbiyOoYIqLSiq/RIdWBHkAhaVSAR8aH0kRBiQcGvVEz6NoKHjkI5KJgn/QzmI9nAWYbFX68v+XpCwF3qDkf/Tn2IDzu6YF22O5BZRUrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917670; c=relaxed/simple;
	bh=HkAtuj1XXwKpvXQnqNjwGT1Yss4SlRsoPKZ59eA1oF8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PQthbI6ynMvb6b6NMLGgv0S3vKYYdEUzHtGQQWCFMfattFhxob4VkJyEwktcHoYrdXlJ3XM1HiYHznCdB5d4EFxCODV58KWL4qf8iNXIsS3AknuLXrO0grswkWN+ApdPLpFLqbQmImOmcI8WOmZFdx0ZU3Wrz7o5vYnHGCTLUU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDE0NkCl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750917664; x=1782453664;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=HkAtuj1XXwKpvXQnqNjwGT1Yss4SlRsoPKZ59eA1oF8=;
  b=DDE0NkClDAuXkn2cmRIAsn7YTnWPg8MaK896nhVR0c3yDF1mQijNq6Lz
   c6OfhNO2pnkgaFNnQR2yd5xWHKeMmeFxt24cgWbyfmxkuMPqCR3P/vHVH
   5oYEAFpvHXQTUl08mk7JeAHYUfb9codnR/v/Rw5NWpvN5dNNCWV5p0mzI
   SJG65k7Rj8svsNAVto+n37+NoRqwlsKe4uOgwiWNxYaYXf52gc6cmxH+Y
   Me+lu4P5tv9O/NOqBl/bnfcSC3LoYwsdzIuFYZWlx7rm79YBh+bmTXIaR
   GryvmrTi/jxRJlzgqMgK8C9wkfuJb4TDG5qqNbMU8S77Uc6wlCMZmvzQm
   Q==;
X-CSE-ConnectionGUID: SaUCEhSWTAelavuiPkzDKw==
X-CSE-MsgGUID: klOc2tzgTNiA0OmgD+HZWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64261433"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="64261433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 23:00:59 -0700
X-CSE-ConnectionGUID: MOG4rEaFRvCkOMqlFk5Q0w==
X-CSE-MsgGUID: bbXEwVxrT9iByUHuaTbgTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="156453770"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 23:00:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 23:00:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 23:00:50 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 23:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpMjXq2FLjh7aF/cNdBeBIRuAbVBTmHp72ku+bDee4KhAnvXXkSNL20XNF+l4L8A4bsFGWhfnSg73Tz+TtW1veFUTKnt9C9oc0L9n1ZlAN0p5Hgp5yqHG7oSERgH2K6p8jI3o72VO8VEIwD/RslXIz47cNX2EVKiff8p05r8bW2PFG1VDS7NwWe8NAj2wO1cFTTIIX4rpFAMV9xJly3FnnvW6SPLaEBrsweF8I5OhIfZR5a+pjNYmUU0wPnB1MM1REeH+tzrdXJ8wUrS1p698X75sCMBI6L2IhmUqOcGpBTc9GNBgGw6Px/f4Wl5gqaflXrBdaZvdnDfAbCzvmhlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blVEh5LeEKSOaIRqAPJcWWYyMRhpy12Mv/klDTJw2yY=;
 b=a48aKYmCuaedtJvF9x32q8FlJYOkMLMt1wQ9lRKtVtLUAnza77gHxTkhFfoLvHNI0P5ai+L42ZBULE+i+mcWX2y1sE9YeDyb916tvF8HUfCY6lcFTBBJFl4OLR3D3iC9eLsxtuRmIxx/OyMjgr9tL6DEWslnMpzS4szSA5T+qXppWthS2KGk8FfSEI8jZzzTAgG7/vUNObLHZqCPCiy76IshRqI9FDHkaOYNtbqnl/HWVO40X5yXlN4BDjYoV4crltYk2zY97HwzKi7f5Pg3Ccnp8pbhMeUiiPJdexkvo5+JAS/ksXg6IVfk7gHwkXoY+CPUdX260TAPOwjxccfXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7274.namprd11.prod.outlook.com (2603:10b6:610:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 06:00:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8857.025; Thu, 26 Jun 2025
 06:00:44 +0000
Date: Thu, 26 Jun 2025 14:00:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [pipe_read]  aaec5a95d5:  hackbench.throughput 6.4%
 regression
Message-ID: <202506261329.8c74199e-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bd6f59-0e75-438b-1c8f-08ddb476c945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?bFssyAwy2OMLi/d+/DgOOVdv0BYfupt2vD1LmkUEqZXE2WZWNUVZHuZWyr?=
 =?iso-8859-1?Q?9jA1tduiHS0A53vkdxAvCjVsAIspf8GX/0lYqAAELg1HITMh0jeH7Kfjpv?=
 =?iso-8859-1?Q?YW+KC4mcqLAjRJWqZhJ1XGObz9PJKw11V55jX5G2y4yhKhQVio5Wzcu2Mm?=
 =?iso-8859-1?Q?Msng4Er4bJr+nG5ZyyDyfyoqIYgTTaVgBqBjKQvPHIo1ahoc05XwzVq6kR?=
 =?iso-8859-1?Q?Y11fhc1TLj92T6KlxlJkiSdvMxdidx44uYu9xaBTaX2IUDQMjuPp7CQ693?=
 =?iso-8859-1?Q?tDBISBgj5ZbfXkWywuGtRBEv4oFKnQpD8QunjzKwMclBmFOGlgReCCdqo6?=
 =?iso-8859-1?Q?5io6yEOTlxiViJBcAV32klKKyBXVPeQL4btCow/EGvrHtR0rW1Buo4GFso?=
 =?iso-8859-1?Q?mkBIuufeeq6yD9gyqFjolDmuiGL30nA8TVcieBGBO3CXo66ayHD+gJtDRx?=
 =?iso-8859-1?Q?YqqimsJIL3pGXU/gZ53EpCw09g58A/DNnx8TR7qMLM1Uj0Z/eb4sdkdvvY?=
 =?iso-8859-1?Q?QXYObdMkmtJV3cgkX3wynxlmPebwzq/ss0lro5bBzCLjgm5QwPVrMo2Img?=
 =?iso-8859-1?Q?4QoIdMbDOYSCY38XZay87mjJ9bS83bvo+KUmrYYjg20GbjdxNcEzxuSoCj?=
 =?iso-8859-1?Q?8GwpeOpU3u79oBZ7+DrJSOXSd2apJsrZ96z/MzqL4OAmg6y5e0/rAA3nHY?=
 =?iso-8859-1?Q?QCCkQiy787kRpfkbquNs4k/NN4ZJ0ctM4JyMzDXQV5MYQgWibpWS8VgM93?=
 =?iso-8859-1?Q?ahxBZaFxMfsa7ofZ6C8w4TI+e9VuWGXzn1KAQp20X9/QBcXttq1LFKCRVp?=
 =?iso-8859-1?Q?rUnjRPduNSqwxY5pLUttK0kxqqIiJGcTBQF12q0PZNDgffpUqYAZ+EZ9eJ?=
 =?iso-8859-1?Q?ez9N3c4SCGt8diL/fJR+LNh17epLZMWT17HCz3xQN1qJmRYW99xG0jSuGm?=
 =?iso-8859-1?Q?G2y3bzCTld6choqt5Rx9Rx4qaERW/2zjVUyrH1XUdhqKfAPGB1eeyDQYF6?=
 =?iso-8859-1?Q?FP6/MZBiOzfTiNtQE+jVFFFpDub7nwfOqhVNQlaNZujhxxfOcKeV4QhMJP?=
 =?iso-8859-1?Q?y3BgSMHS5H8G/v9amVH1NW5J5PehFXblEwTw+ivjT1ypmeltEG5prDaHro?=
 =?iso-8859-1?Q?morMK3R4ML1ajzDuScxgTippgSbFr95nSHVwbl453pS330BZLP6gJq41SC?=
 =?iso-8859-1?Q?ihhImCde5nxgCPBbBUokzQzDPQFq7BjlBHTzIWsjNgTPHMDbT9IQqpe01A?=
 =?iso-8859-1?Q?GtG7s4Q7GFXJ0vFDEhc7CLT8Kbs2nIChkZWiYQBq+rG6i+pLh2l8miRuDw?=
 =?iso-8859-1?Q?XE0bwWgndVRCgJd5Tae/beguaSIEt9JxFdsy71DUmvfMvWZw16JgRGeOuJ?=
 =?iso-8859-1?Q?JI/B5Kjf4RYuCBpkDtJjSYR6KBt86QwXNhPn+Bct/XT+R1mNmOHNJPnqBw?=
 =?iso-8859-1?Q?VYjQI5Bd5+O0GXTT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?52Tj2l6GDUQqDn5do9j+6/A6CO4oHmPTSavBb4xNbonNKKXjIIhCvd3eIj?=
 =?iso-8859-1?Q?3lolzT7ifjnEAwXOfJEgfsQXt+Lh4prJTd7wC2Bi/ys3HuR0VTZHZ5hcEs?=
 =?iso-8859-1?Q?H/d8VxQwxz3RAwpXATlP0nZHUAr68eWQDTjhGCB4XzyBcxcmglNqUOVu8A?=
 =?iso-8859-1?Q?kFW9Qet5pswAMWvp2jCXMw7t9qvmI3s14QoZxGWskaeO17Ko2NSp6t4xiU?=
 =?iso-8859-1?Q?DBZmsiCcMO7noZyM7RJPu6pjfYGq9v9V0BqpLKKhyb0HdHl6lwPsOVOJfg?=
 =?iso-8859-1?Q?1fHT6rSKuj5HWyzL/cta9Mt8CrzAHezNV3XtLoYUGZB319B4pSQf+YxOEZ?=
 =?iso-8859-1?Q?jP4Nnz9LVx75d02sg0Qigq4Vf0jNDqM8XVQ79jktWctdZsLHrJYPwtDJTE?=
 =?iso-8859-1?Q?N4wNV11jERPOBh/4mqeAXbjJyRYZ8TCO5uXwEFGjUvKiH+pH++Mvbh9nDz?=
 =?iso-8859-1?Q?5fE/tA1DwJeFAtQcnSQpfB8XnKSoOTaotKMRt/08t6Ku3AjHUE+OKQ8XCp?=
 =?iso-8859-1?Q?iF7F8dPSgx6dwgNLieAJTG5WO2GvfU01oI64elCy4MlW4vIDY9xXj/0pL/?=
 =?iso-8859-1?Q?BFMgK0hYBys0G/LCBW5IUS9//bskl0LFQB2S/Hu3r1z9IGvhCoFgKNk+qv?=
 =?iso-8859-1?Q?xiq6eudg4zlhqitABNyQOuZJf0yND0+Ele6YWHxtfLR5JyQewj5Ho0qyX3?=
 =?iso-8859-1?Q?9bfKBAR0vi1Ip6qLOLQFiOK4MPkMqmR1g7kK9livwg/WJ5GSWD8E0kqAt+?=
 =?iso-8859-1?Q?CMkihk9pXnuGF+djfjO5HZmmft09DP3itkgajIibwoGC87+NSZaj/+Q5Bv?=
 =?iso-8859-1?Q?ijLR4ysi/f8q2HflbCTjcFFhb5gH57mvc4ls8jK4pwNI9hca3A6gO274bO?=
 =?iso-8859-1?Q?ZbOdD02j7uvtTZmboT9hjVg+ZqHRUy1PudzXUsWkEEmB3fOwWsVWVDYC0M?=
 =?iso-8859-1?Q?JSpixA8DPbG45/DUM3WA9z5rdfBMeiG4v4y8WSOLKY0sVjO9H4eqEQVuaG?=
 =?iso-8859-1?Q?ee4fGnDlYRHKaYXHPVUSILCMowcHFq4rOst7DtoaLP07zDjxyKHTe69q5d?=
 =?iso-8859-1?Q?Ox1JyRVEf4mY7TY/3iGp34c+eD+qKDy8Qp64/+sDGV/3IRcPT1zr0upcox?=
 =?iso-8859-1?Q?ozXvcqpt6/ZsZgETMVoFHFB4eyA0RWkbzLShyJQA6b97GM0fGYR8o4c+GS?=
 =?iso-8859-1?Q?rj9/2lgUCyljBY0Fr84Xbgb2VaunyFAOAQW8TWgGXJkz7P3ZiF9iMJX3UJ?=
 =?iso-8859-1?Q?80WpnhxrTzyZJ8dW1lEZXVTQ2EYa0/peO1fQlGIDUNfpZcb9Vzp+jg7ujR?=
 =?iso-8859-1?Q?eEOaErd8EV+llJ9iRbQg4UFCU1aBfmEtn1dYYZ9xaXlNAQrpneaT2B0YxP?=
 =?iso-8859-1?Q?IhdQGpxmFLE1eooACKK7dOrUdhvJ5ETDdmzrAZtaaZA/94Mme5NlzkOyV+?=
 =?iso-8859-1?Q?GRYOLJ43FLhUwJuVLEcYVdQzmY5eLqUTtJELL7rgOzNDlq1H7RIFTcbiuB?=
 =?iso-8859-1?Q?KhJHNkv5orhF8sgb/LASdUyLoSUYNB0v6aAY4nkuZ+9MtTWpd/LPKQ8pQJ?=
 =?iso-8859-1?Q?XR0tY4+H/AmZ8zs0ONThtIm/hHYLtlcQNZ5lLNziyGLRAg8z0h/rygga1l?=
 =?iso-8859-1?Q?+md/0J7XBJbiEf5TP2NzBG9V3IY0D8btUrQA6bbBcvJe3a50cZ/WyINQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bd6f59-0e75-438b-1c8f-08ddb476c945
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 06:00:44.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv3PEPvrJEmvumQcuEnikvA/NBlHbDPzQVmbcYdPEPccgn5S8+I0fm9T/mrPHjwsXklHukSCIh1inDvVmBPNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7274
X-OriginatorOrg: intel.com



Hello,


for this commit, we reported
"[brauner-vfs:vfs-6.14.misc] [pipe_read]  aaec5a95d5: hackbench.throughput 7.5% regression"
in
https://lore.kernel.org/all/202501101015.90874b3a-lkp@intel.com/
and
"[linux-next:master] [pipe_read]  aaec5a95d5: stress-ng.poll.ops_per_sec 11.1% regression"
in
https://lore.kernel.org/all/202501201311.6d25a0b9-lkp@intel.com/

we also noticed in
https://lore.kernel.org/all/20250123125607.GA16498@redhat.com/
that the hackbench regression is reproducible.

now we noticed the commit is in mainline and still found similar regression.
(as well as an improvement as below details)

we don't have enough background knowledge that if the benefit of this change
is more important than some small regression on micro benchmark, this report
is just FYI what we observed in our tests.


kernel test robot noticed a 6.4% regression of hackbench.throughput on:


commit: aaec5a95d59615523db03dd53c2052f0a87beea7 ("pipe_read: don't wake up the writer if the pipe is still full")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      78f4e737a53e1163ded2687a922fce138aee73f5]
[still regression on linux-next/master 2ae2aaafb21454f4781c30734959cf223ab486ef]

testcase: hackbench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory
parameters:

	nr_threads: 50%
	iterations: 4
	mode: process
	ipc: pipe
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput  7.7% regression                                            |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory  |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | ipc=pipe                                                                                    |
|                  | iterations=4                                                                                |
|                  | mode=threads                                                                                |
|                  | nr_threads=50%                                                                              |
+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.poll.ops_per_sec  11.1% regression                                     |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=poll                                                                                   |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.tee.ops_per_sec 500.7% improvement                                     |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory   |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=tee                                                                                    |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput  7.5% regression                                            |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory  |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | ipc=pipe                                                                                    |
|                  | iterations=4                                                                                |
|                  | mode=process                                                                                |
|                  | nr_threads=50%                                                                              |
+------------------+---------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506261329.8c74199e-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250626/202506261329.8c74199e-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/pipe/4/x86_64-rhel-9.4/process/50%/debian-12-x86_64-20240206.cgz/lkp-skl-d06/hackbench

commit: 
  d2fc0ed52a ("Merge branch 'vfs-6.14.uncached_buffered_io'")
  aaec5a95d5 ("pipe_read: don't wake up the writer if the pipe is still full")

d2fc0ed52a284a13 aaec5a95d59615523db03dd53c2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3255 ±  2%     +11.7%       3637        perf-c2c.HITM.local
    339169 ±  2%     +15.4%     391366        vmstat.system.cs
     71801 ±  2%     +38.8%      99667 ±  2%  vmstat.system.in
     32837 ±  3%      -6.4%      30733 ±  2%  proc-vmstat.nr_mapped
   3900380            -8.4%    3573143        proc-vmstat.numa_hit
   3901829            -8.4%    3573143        proc-vmstat.numa_local
   3931376            -8.2%    3607706        proc-vmstat.pgalloc_normal
   3715390            -8.5%    3398913        proc-vmstat.pgfree
     27292            -6.4%      25535        hackbench.throughput
     26387            -4.8%      25121        hackbench.throughput_avg
     27292            -6.4%      25535        hackbench.throughput_best
   5171648 ±  3%     +28.2%    6632375 ±  2%  hackbench.time.involuntary_context_switches
    154.57            +7.8%     166.62        hackbench.time.system_time
  18478209 ±  2%     +19.8%   22145567        hackbench.time.voluntary_context_switches
     16.66 ±100%     -10.7        5.98 ±205%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     16.66 ±100%     -10.7        5.98 ±205%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write
     16.66 ±100%     -10.7        5.98 ±205%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     16.66 ±100%     -10.7        5.98 ±205%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
     16.66 ±100%     -10.7        5.98 ±205%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
     16.66 ±100%     -10.7        5.98 ±205%  perf-profile.children.cycles-pp.shmem_write_begin
      9402 ±  8%     -16.5%       7847 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      1045 ± 22%     -24.3%     791.38 ± 11%  sched_debug.cfs_rq:/.util_est.avg
    610.42 ± 45%     -57.0%     262.42 ± 66%  sched_debug.cfs_rq:/.util_est.min
   2616103 ±  2%     +14.4%    2991704        sched_debug.cpu.nr_switches.avg
   2689656           +14.9%    3089911        sched_debug.cpu.nr_switches.max
   2561049 ±  2%     +12.5%    2882129 ±  3%  sched_debug.cpu.nr_switches.min
      0.84            +9.0%       0.92        perf-stat.i.MPKI
      1.99            +0.1        2.05        perf-stat.i.branch-miss-rate%
  34496253            +3.7%   35766259        perf-stat.i.branch-misses
      2.63            +0.1        2.75        perf-stat.i.cache-miss-rate%
   7514001            +8.9%    8180511        perf-stat.i.cache-misses
 2.998e+08            +5.0%  3.149e+08        perf-stat.i.cache-references
    347430 ±  2%     +15.6%     401508        perf-stat.i.context-switches
      3115           -67.6%       1010 ±  5%  perf-stat.i.cpu-migrations
      2213           -11.2%       1966        perf-stat.i.cycles-between-cache-misses
     87.19 ±  2%     +15.3%     100.54        perf-stat.i.metric.K/sec
      1688            -2.0%       1655        perf-stat.i.minor-faults
      1688            -2.0%       1655        perf-stat.i.page-faults
      0.87            +8.4%       0.94        perf-stat.overall.MPKI
      1.98            +0.1        2.05        perf-stat.overall.branch-miss-rate%
      2.51            +0.1        2.60        perf-stat.overall.cache-miss-rate%
      1797            -8.1%       1652        perf-stat.overall.cycles-between-cache-misses
  34012373            +3.7%   35283212        perf-stat.ps.branch-misses
   7409882            +8.9%    8071103        perf-stat.ps.cache-misses
 2.956e+08            +5.1%  3.107e+08        perf-stat.ps.cache-references
    342572 ±  2%     +15.6%     396160        perf-stat.ps.context-switches
      3071           -67.5%     996.99 ±  5%  perf-stat.ps.cpu-migrations
      1665            -1.9%       1633        perf-stat.ps.minor-faults
      1665            -1.9%       1633        perf-stat.ps.page-faults
 6.128e+11            +5.5%  6.463e+11        perf-stat.total.instructions
      0.14 ± 10%     -16.0%       0.12 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.31 ±  4%     -15.6%       0.26 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.55 ±  6%     +52.0%       0.83 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      2.88 ± 13%    +105.9%       5.93 ± 18%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3.29 ±  5%    +126.6%       7.46 ±  7%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.14 ±  8%     +27.1%       0.17 ± 13%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.69 ±  6%    +713.7%       5.62        perf-sched.sch_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.66 ± 24%     +75.5%       1.16 ± 20%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.25 ±  6%     +61.3%       0.40 ±  4%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     34.33 ± 10%     +25.0%      42.92 ± 10%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     33.35 ± 21%     +40.9%      47.00 ± 15%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.66 ±  4%     -16.4%       0.55 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      1.33 ±  6%     +85.1%       2.45 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      6.57 ± 36%     +80.8%      11.88 ± 18%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      8.78 ±  7%    +173.3%      24.00 ±  5%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.28 ± 10%     +32.7%       0.37 ± 15%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.16 ±  5%    +768.0%      18.79 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     11.16 ± 18%     +69.1%      18.88 ± 15%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      5.41 ± 11%     +38.3%       7.48 ± 14%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.58 ±  7%     +98.6%       1.16 ±  4%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5243 ±  5%     +36.9%       7176 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      4198 ±  3%     +72.3%       7231 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
    520.33 ±  4%     +71.8%     893.83 ±  2%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     25991 ±  9%     -29.5%      18330 ± 12%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      8647 ±  5%     +51.1%      13067 ±  3%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     98274 ±  5%     -93.4%       6480 ±  2%  perf-sched.wait_and_delay.count.pipe_write.vfs_write.ksys_write.do_syscall_64
     98.00 ± 34%     +74.5%     171.00 ± 15%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
    139344 ±  6%     -27.5%     101087 ±  4%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     71.46 ± 14%     +38.1%      98.71 ± 12%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
    673.17 ± 13%     +16.9%     787.17 ±  4%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.35 ±  4%     -17.1%       0.29 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.78 ±  6%    +108.2%       1.62 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      5.49 ±  8%    +201.3%      16.55 ±  4%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.14 ± 12%     +38.5%       0.20 ± 20%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.47 ±  4%    +793.5%      13.17 ±  2%  perf-sched.wait_time.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      6.76 ± 14%     +99.6%      13.50 ± 16%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      4.75 ± 15%     +33.2%       6.33 ± 14%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     35.39 ± 11%     -19.9%      28.35 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.34 ±  8%    +126.1%       0.76 ±  4%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     63.41 ± 25%     +72.9%     109.66 ± 14%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     45.83 ± 18%     +56.6%      71.79 ± 17%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
    673.16 ± 13%     +16.9%     787.17 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread


***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/pipe/4/x86_64-rhel-9.4/threads/50%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/hackbench

commit: 
  d2fc0ed52a ("Merge branch 'vfs-6.14.uncached_buffered_io'")
  aaec5a95d5 ("pipe_read: don't wake up the writer if the pipe is still full")

d2fc0ed52a284a13 aaec5a95d59615523db03dd53c2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 5.042e+08 ± 17%     -18.7%    4.1e+08 ±  2%  cpuidle..time
  10652969 ±  6%     -28.3%    7635249 ±  6%  cpuidle..usage
      4.47 ± 21%      -1.4        3.07 ±  6%  mpstat.cpu.all.idle%
      0.03 ±  4%      -0.0        0.03        mpstat.cpu.all.soft%
      1452           -14.4%       1243        vmstat.procs.r
   1402445           +25.6%    1761120        vmstat.system.in
   2894369 ± 22%     -34.7%    1889346 ± 12%  numa-meminfo.node1.Active
   2894369 ± 22%     -34.7%    1889346 ± 12%  numa-meminfo.node1.Active(anon)
   2473459 ± 33%     -42.9%    1412836 ± 22%  numa-meminfo.node1.Shmem
    724297 ± 22%     -34.7%     472642 ± 12%  numa-vmstat.node1.nr_active_anon
    618989 ± 33%     -42.9%     353537 ± 21%  numa-vmstat.node1.nr_shmem
    724296 ± 22%     -34.7%     472642 ± 12%  numa-vmstat.node1.nr_zone_active_anon
     98180 ±  5%     +59.7%     156837 ±  4%  perf-c2c.HITM.local
      3639 ± 11%     +82.8%       6651 ± 21%  perf-c2c.HITM.remote
    101819 ±  5%     +60.6%     163489 ±  4%  perf-c2c.HITM.total
   3267360 ± 25%     -32.4%    2208241 ± 14%  meminfo.Active
   3267360 ± 25%     -32.4%    2208241 ± 14%  meminfo.Active(anon)
   5982182 ± 13%     -17.5%    4933057 ±  6%  meminfo.Cached
   3425356 ± 24%     -30.9%    2366882 ± 13%  meminfo.Committed_AS
   9822130 ±  8%     -12.0%    8641150 ±  4%  meminfo.Memused
   2479849 ± 33%     -42.3%    1430723 ± 22%  meminfo.Shmem
   9900363 ±  8%     -11.4%    8768940 ±  3%  meminfo.max_used_kB
    823004            -7.7%     759380        hackbench.throughput
    788354            -7.0%     732864        hackbench.throughput_avg
    823004            -7.7%     759380        hackbench.throughput_best
    714741            -5.7%     674114        hackbench.throughput_worst
     76.78            +7.5%      82.53        hackbench.time.elapsed_time
     76.78            +7.5%      82.53        hackbench.time.elapsed_time.max
 1.971e+08           +30.4%   2.57e+08        hackbench.time.involuntary_context_switches
     52109 ±  3%     +25.6%      65473 ±  7%  hackbench.time.minor_page_faults
      8193            +9.5%       8974        hackbench.time.system_time
      1209            +2.4%       1238        hackbench.time.user_time
    813559 ± 25%     -32.1%     552002 ± 14%  proc-vmstat.nr_active_anon
    197770            -1.1%     195674        proc-vmstat.nr_anon_pages
   1492419 ± 13%     -17.4%    1233047 ±  6%  proc-vmstat.nr_file_pages
    616835 ± 33%     -42.0%     357462 ± 22%  proc-vmstat.nr_shmem
     30639            -1.9%      30072        proc-vmstat.nr_slab_reclaimable
    813559 ± 25%     -32.1%     552002 ± 14%  proc-vmstat.nr_zone_active_anon
    232915 ±  8%     -19.5%     187586 ± 15%  proc-vmstat.numa_hint_faults
 1.131e+08            -2.3%  1.105e+08        proc-vmstat.numa_hit
  1.13e+08            -2.3%  1.104e+08        proc-vmstat.numa_local
 1.132e+08            -2.3%  1.106e+08        proc-vmstat.pgalloc_normal
 1.117e+08            -1.8%  1.097e+08        proc-vmstat.pgfree
 5.855e+10            -5.8%  5.513e+10        perf-stat.i.branch-instructions
      0.45            +0.0        0.47        perf-stat.i.branch-miss-rate%
 2.443e+08            -1.8%  2.399e+08        perf-stat.i.branch-misses
     13.43 ±  3%      -4.3        9.18 ±  6%  perf-stat.i.cache-miss-rate%
 1.239e+09 ±  4%     +39.5%  1.729e+09        perf-stat.i.cache-references
      1.26            +6.9%       1.35        perf-stat.i.cpi
    577288 ±  2%     +53.7%     887271        perf-stat.i.cpu-migrations
 2.522e+11            -5.7%  2.378e+11        perf-stat.i.instructions
      0.80            -6.3%       0.75        perf-stat.i.ipc
     98.67            +2.5%     101.14        perf-stat.i.metric.K/sec
      9540 ±  3%      -9.7%       8612 ±  4%  perf-stat.i.minor-faults
      9540 ±  3%      -9.7%       8612 ±  4%  perf-stat.i.page-faults
      0.35 ± 44%      +0.1        0.43        perf-stat.overall.branch-miss-rate%
      1.05 ± 44%     +28.3%       1.35        perf-stat.overall.cpi
 1.019e+09 ± 44%     +67.4%  1.705e+09        perf-stat.ps.cache-references
    470800 ± 44%     +85.7%     874307        perf-stat.ps.cpu-migrations
 1.611e+13 ± 44%     +22.0%  1.966e+13        perf-stat.total.instructions
      6.14 ±  4%     -12.7%       5.36 ±  5%  sched_debug.cfs_rq:/.h_nr_running.avg
     18.00 ± 14%     -28.3%      12.90 ± 13%  sched_debug.cfs_rq:/.h_nr_running.max
      3.94 ± 23%     -29.5%       2.78        sched_debug.cfs_rq:/.h_nr_running.stddev
      6216 ±  2%     -11.3%       5516 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
     13241 ± 13%     -22.6%      10251 ± 10%  sched_debug.cfs_rq:/.runnable_avg.max
      2459 ± 38%     -38.6%       1510 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    278.40 ±  7%      -8.8%     253.92 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
      6923 ±  3%     -16.5%       5782        sched_debug.cpu.curr->pid.avg
      9278           -13.6%       8017        sched_debug.cpu.curr->pid.max
      1850 ± 22%     -45.1%       1015 ± 13%  sched_debug.cpu.curr->pid.stddev
      7640 ± 28%     -72.3%       2117 ±128%  sched_debug.cpu.max_idle_balance_cost.stddev
      6.10 ±  4%     -12.0%       5.37 ±  5%  sched_debug.cpu.nr_running.avg
     18.00 ± 14%     -28.3%      12.90 ± 13%  sched_debug.cpu.nr_running.max
      3.96 ± 23%     -29.9%       2.78 ±  2%  sched_debug.cpu.nr_running.stddev
   3401286 ± 11%     -12.9%    2963839        sched_debug.cpu.nr_switches.max
   2211723 ±  7%     +17.1%    2589948        sched_debug.cpu.nr_switches.min
    148894 ± 18%     -54.6%      67575 ± 16%  sched_debug.cpu.nr_switches.stddev
     14.58 ± 40%     -11.7        2.86 ±199%  perf-profile.calltrace.cycles-pp.__cmd_record
     11.53 ± 72%     -11.5        0.00        perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
     11.53 ± 72%     -11.5        0.00        perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     14.22 ± 46%     -11.4        2.86 ±199%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
     14.22 ± 46%     -11.4        2.86 ±199%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     14.22 ± 46%     -11.4        2.86 ±199%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      9.34 ± 71%      -9.3        0.00        perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      6.13 ± 71%      -6.1        0.00        perf-profile.calltrace.cycles-pp.evlist__parse_sample.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event
      4.23 ± 78%      -4.2        0.00        perf-profile.calltrace.cycles-pp.evsel__parse_sample.evlist__parse_sample.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
     24.02 ± 18%     -11.6       12.41 ± 40%  perf-profile.children.cycles-pp.__cmd_record
     11.53 ± 72%     -11.5        0.00        perf-profile.children.cycles-pp.__ordered_events__flush
     11.53 ± 72%     -11.5        0.00        perf-profile.children.cycles-pp.perf_session__process_user_event
     14.22 ± 46%     -11.4        2.86 ±199%  perf-profile.children.cycles-pp.perf_session__process_events
     14.22 ± 46%     -11.4        2.86 ±199%  perf-profile.children.cycles-pp.reader__read_event
     14.22 ± 46%     -11.4        2.86 ±199%  perf-profile.children.cycles-pp.record__finish_output
      9.62 ± 72%      -9.6        0.00        perf-profile.children.cycles-pp.perf_session__deliver_event
      6.13 ± 71%      -6.1        0.00        perf-profile.children.cycles-pp.evlist__parse_sample
      4.23 ± 78%      -4.2        0.00        perf-profile.children.cycles-pp.evsel__parse_sample
      1.14 ± 73%      +2.4        3.57 ± 32%  perf-profile.children.cycles-pp._raw_spin_lock
      4.23 ± 78%      -4.2        0.00        perf-profile.self.cycles-pp.evsel__parse_sample
     11.45 ± 31%     +96.2%      22.47 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.71 ± 89%     -84.9%       0.11 ± 96%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.17 ±127%     -97.5%       0.00 ±123%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
      5.99 ± 31%    +275.3%      22.48 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.97 ±110%   +3354.5%      33.55 ±162%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
     14.75 ± 34%    +431.2%      78.36 ± 26%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1.27 ± 51%    +499.2%       7.58 ± 35%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.12 ± 30%     +60.4%       1.79 ± 12%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.39 ± 35%    +843.3%      60.32 ± 14%  perf-sched.sch_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     17.90 ± 58%    +176.4%      49.48 ± 26%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     14.40 ± 45%    +295.1%      56.90 ± 84%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.40 ± 27%    +274.3%       5.24 ± 11%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    510.34 ± 65%     -92.2%      39.72 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
     32.40 ±170%     -93.0%       2.26 ± 66%  perf-sched.sch_delay.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.64 ±166%     -99.3%       0.00 ±123%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
    555.37 ± 23%     +49.0%     827.50 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
    943.44 ± 41%    +197.2%       2803 ± 23%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
    810.08 ± 36%    +171.4%       2198 ± 16%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    192.58 ± 77%     -95.5%       8.67 ±148%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
    543.49 ± 54%    +103.5%       1105 ± 40%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1677 ± 19%    +133.6%       3917 ± 15%  perf-sched.sch_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    855.77 ± 35%    +159.6%       2221 ± 27%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      1552 ± 25%    +161.6%       4061 ± 17%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.64 ± 30%     +74.2%       2.86 ± 12%  perf-sched.total_sch_delay.average.ms
      5.08 ± 30%     +64.1%       8.33 ± 12%  perf-sched.total_wait_and_delay.average.ms
   4913449 ± 35%     -47.7%    2568016 ± 23%  perf-sched.total_wait_and_delay.count.ms
      3.44 ± 31%     +59.3%       5.47 ± 12%  perf-sched.total_wait_time.average.ms
     27.82 ± 25%     +61.5%      44.93 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     18.33 ± 33%    +256.8%      65.40 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
     45.92 ± 35%    +409.9%     234.14 ± 19%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      3.25 ± 31%     +56.1%       5.07 ± 12%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     20.64 ± 35%    +757.2%     176.94 ± 14%  perf-sched.wait_and_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     53.51 ± 55%    +168.5%     143.67 ± 22%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     51.14 ± 42%    +182.7%     144.54 ± 61%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4.14 ± 30%    +268.0%      15.24 ± 12%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     61.67 ± 20%     -64.3%      22.00 ± 35%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
   3724906 ± 34%     -42.3%    2149531 ± 23%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    444284 ± 37%     -95.4%      20647 ± 25%  perf-sched.wait_and_delay.count.pipe_write.vfs_write.ksys_write.do_syscall_64
     16.83 ± 23%     -65.5%       5.80 ± 63%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    172.17 ± 55%     -63.8%      62.40 ± 50%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    477.83 ± 35%     -47.1%     252.80 ± 18%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    723761 ± 35%     -46.7%     385737 ± 23%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1896 ± 41%    +204.0%       5763 ± 20%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      1712 ± 34%    +181.2%       4814 ± 26%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      3572 ± 20%    +121.8%       7924 ± 15%  perf-sched.wait_and_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      1736 ± 35%    +158.6%       4491 ± 27%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      3117 ± 25%    +161.0%       8134 ± 17%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     12.30 ±215%     -99.6%       0.05 ± 97%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     16.37 ± 22%     +37.3%      22.47 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.16 ±139%     -97.3%       0.00 ±123%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
     12.34 ± 34%    +247.8%      42.92 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.97 ±110%   +3354.5%      33.55 ±162%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
     12.20 ± 94%     -91.7%       1.02 ±131%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     31.17 ± 36%    +399.8%     155.78 ± 15%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1.54 ± 53%    +393.0%       7.60 ± 35%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.13 ± 31%     +53.9%       3.28 ± 12%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     14.25 ± 36%    +718.5%     116.62 ± 13%  perf-sched.wait_time.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     35.62 ± 54%    +164.5%      94.19 ± 20%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     36.74 ± 44%    +138.6%      87.65 ± 48%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.74 ± 32%    +264.8%      10.00 ± 12%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    510.34 ± 65%     -92.2%      39.72 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
    168.24 ±221%     -99.9%       0.19 ±116%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.63 ±170%     -99.3%       0.00 ±123%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
    582.26 ± 22%     +60.9%     936.72 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      1044 ± 34%    +199.8%       3131 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
    185.64 ±128%     -98.9%       2.02 ±130%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1078 ± 23%    +165.2%       2861 ± 28%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    196.06 ± 76%     -95.1%       9.51 ±134%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      1918 ± 26%    +114.1%       4107 ± 15%  perf-sched.wait_time.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    941.82 ± 25%    +144.5%       2303 ± 23%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      1971 ± 24%    +119.6%       4329 ± 12%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]



***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/poll/stress-ng/60s

commit: 
  d2fc0ed52a ("Merge branch 'vfs-6.14.uncached_buffered_io'")
  aaec5a95d5 ("pipe_read: don't wake up the writer if the pipe is still full")

d2fc0ed52a284a13 aaec5a95d59615523db03dd53c2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.049e+08           -54.4%  1.847e+08        cpuidle..usage
     70.66 ±  2%     -40.9%      41.74 ±  3%  vmstat.procs.r
  13673771           -55.5%    6089704        vmstat.system.cs
   3388831            -9.5%    3067987        vmstat.system.in
      6.62           +12.4       19.04 ±  6%  mpstat.cpu.all.irq%
      0.07            -0.0        0.06        mpstat.cpu.all.soft%
     17.51            -6.8       10.76        mpstat.cpu.all.sys%
      4.98            -1.0        4.01 ±  2%  mpstat.cpu.all.usr%
     18.00 ±  4%    +110.2%      37.83 ± 37%  mpstat.max_utilization.seconds
      3483 ± 17%     -38.5%       2141 ±  9%  perf-c2c.DRAM.local
      2266 ±  5%    +256.6%       8081 ±  5%  perf-c2c.DRAM.remote
    173996 ±  2%     -50.8%      85520 ± 12%  perf-c2c.HITM.local
      1097 ± 10%     +97.5%       2168 ±  5%  perf-c2c.HITM.remote
    175093 ±  2%     -49.9%      87689 ± 11%  perf-c2c.HITM.total
   2643650            +5.6%    2790795 ±  2%  proc-vmstat.nr_active_anon
   3308720            +4.6%    3459916        proc-vmstat.nr_file_pages
   2427405            +6.2%    2578600 ±  2%  proc-vmstat.nr_shmem
   2643650            +5.6%    2790795 ±  2%  proc-vmstat.nr_zone_active_anon
    235308           -19.3%     189819 ± 12%  proc-vmstat.numa_hint_faults_local
   1437439            -5.5%    1358004 ±  3%  proc-vmstat.pgfault
  8.71e+08           -11.1%  7.745e+08        stress-ng.poll.ops
  14516970           -11.1%   12907569        stress-ng.poll.ops_per_sec
    181583           -57.1%      77818 ± 21%  stress-ng.time.involuntary_context_switches
     85474            +1.6%      86823        stress-ng.time.minor_page_faults
      6150           -47.8%       3208        stress-ng.time.percent_of_cpu_this_job_got
      2993           -50.6%       1477        stress-ng.time.system_time
    711.20           -36.0%     454.85        stress-ng.time.user_time
 4.427e+08           -56.2%  1.937e+08        stress-ng.time.voluntary_context_switches
    834292 ±  4%     -60.5%     329635 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.avg
    520206 ±  5%     -70.0%     155956 ± 44%  sched_debug.cfs_rq:/.avg_vruntime.min
     80954 ± 25%     -78.0%      17846 ± 55%  sched_debug.cfs_rq:/.left_deadline.avg
    312463 ± 46%     -69.5%      95397 ± 67%  sched_debug.cfs_rq:/.left_deadline.stddev
     80943 ± 25%     -78.0%      17842 ± 55%  sched_debug.cfs_rq:/.left_vruntime.avg
    312436 ± 46%     -69.5%      95382 ± 67%  sched_debug.cfs_rq:/.left_vruntime.stddev
    834292 ±  4%     -60.5%     329635 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
    520206 ±  5%     -70.0%     155956 ± 44%  sched_debug.cfs_rq:/.min_vruntime.min
     80943 ± 25%     -78.0%      17842 ± 55%  sched_debug.cfs_rq:/.right_vruntime.avg
    312436 ± 46%     -69.5%      95382 ± 67%  sched_debug.cfs_rq:/.right_vruntime.stddev
    224.99 ±  4%     -32.0%     152.91 ±  9%  sched_debug.cfs_rq:/.runnable_avg.avg
    212.19 ±  4%     -30.4%     147.67 ±  8%  sched_debug.cfs_rq:/.util_avg.avg
     28.51 ±  5%     -26.3%      21.02 ± 29%  sched_debug.cfs_rq:/.util_est.avg
      0.18 ±  6%     -41.8%       0.11 ± 30%  sched_debug.cpu.nr_running.avg
      0.38 ±  6%     -23.2%       0.29 ± 14%  sched_debug.cpu.nr_running.stddev
   1893149           -63.0%     700843 ± 44%  sched_debug.cpu.nr_switches.avg
   2007234           -62.4%     755101 ± 43%  sched_debug.cpu.nr_switches.max
    845934 ± 16%     -65.9%     288868 ± 45%  sched_debug.cpu.nr_switches.min
    136058 ±  6%     -62.3%      51280 ± 45%  sched_debug.cpu.nr_switches.stddev
     54.75 ± 29%     -35.9%      35.08 ± 21%  sched_debug.cpu.nr_uninterruptible.max
      0.13 ±  3%    +138.2%       0.30 ±  3%  perf-stat.i.MPKI
 4.279e+10           -24.6%  3.224e+10        perf-stat.i.branch-instructions
      0.57            -0.1        0.47 ±  2%  perf-stat.i.branch-miss-rate%
 2.343e+08           -36.3%  1.493e+08 ±  2%  perf-stat.i.branch-misses
      3.22 ±  2%      +7.6       10.77 ±  2%  perf-stat.i.cache-miss-rate%
  29560239 ±  2%     +71.2%   50594050 ±  4%  perf-stat.i.cache-misses
 8.946e+08           -49.8%  4.494e+08 ±  2%  perf-stat.i.cache-references
  14167388           -55.5%    6301671        perf-stat.i.context-switches
      1.33           +45.2%       1.93 ±  3%  perf-stat.i.cpi
 2.778e+11            +8.5%  3.013e+11 ±  2%  perf-stat.i.cpu-cycles
   2501362           -83.7%     408632        perf-stat.i.cpu-migrations
     15733 ±  3%     -52.7%       7444 ±  7%  perf-stat.i.cycles-between-cache-misses
 2.138e+11           -25.5%  1.594e+11        perf-stat.i.instructions
      0.76           -29.3%       0.54 ±  2%  perf-stat.i.ipc
     74.48           -59.7%      29.98        perf-stat.i.metric.K/sec
     21318            -6.8%      19869 ±  6%  perf-stat.i.minor-faults
     21318            -6.8%      19869 ±  6%  perf-stat.i.page-faults
      0.14 ±  2%    +130.0%       0.32 ±  4%  perf-stat.overall.MPKI
      0.55            -0.1        0.46 ±  2%  perf-stat.overall.branch-miss-rate%
      3.30            +7.9       11.24 ±  2%  perf-stat.overall.cache-miss-rate%
      1.30           +45.5%       1.89 ±  3%  perf-stat.overall.cpi
      9426 ±  2%     -36.7%       5969 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.77           -31.2%       0.53 ±  3%  perf-stat.overall.ipc
 4.206e+10           -24.7%  3.167e+10        perf-stat.ps.branch-instructions
 2.299e+08           -36.3%  1.464e+08 ±  2%  perf-stat.ps.branch-misses
  28994632 ±  2%     +71.3%   49675855 ±  4%  perf-stat.ps.cache-misses
 8.795e+08           -49.8%  4.419e+08 ±  2%  perf-stat.ps.cache-references
  13938322           -55.5%    6196929        perf-stat.ps.context-switches
 2.732e+11            +8.3%   2.96e+11 ±  2%  perf-stat.ps.cpu-cycles
   2460505           -83.7%     402100        perf-stat.ps.cpu-migrations
 2.102e+11           -25.5%  1.565e+11        perf-stat.ps.instructions
      0.01 ± 82%    +259.6%       0.05 ± 57%  perf-stat.ps.major-faults
     20785            -7.2%      19284 ±  6%  perf-stat.ps.minor-faults
     20785            -7.2%      19284 ±  6%  perf-stat.ps.page-faults
 1.283e+13           -25.5%   9.55e+12        perf-stat.total.instructions
     40.62           -19.6       21.06 ± 10%  perf-profile.calltrace.cycles-pp.stress_run
     15.66            -8.0        7.64 ±  9%  perf-profile.calltrace.cycles-pp.stress_poll.stress_run
     12.84            -7.7        5.14 ± 16%  perf-profile.calltrace.cycles-pp.write.stress_run
     12.48            -7.5        4.98 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     13.32            -7.3        6.04 ±  9%  perf-profile.calltrace.cycles-pp.read.stress_poll.stress_run
     11.55            -7.1        4.46 ± 17%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.stress_run
     11.38            -7.0        4.33 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_run
     12.17            -7.0        5.16 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.stress_poll.stress_run
     12.00            -7.0        5.02 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_poll.stress_run
     10.32            -6.7        3.60 ± 17%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_run
     10.86            -6.7        4.16 ±  9%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_poll
     10.38            -6.6        3.81 ±  9%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      9.91            -6.4        3.52 ±  8%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      7.32            -6.3        0.97 ±  3%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      9.45            -6.3        3.13 ±  9%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.21            -6.2        3.00 ±  8%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.76 ±  2%      -5.8        0.91 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      6.30 ±  2%      -5.4        0.88 ±  3%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      5.61 ±  2%      -4.8        0.84 ±  3%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      4.97 ±  2%      -4.2        0.78 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      4.84 ±  3%      -4.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      3.16 ±  4%      -2.6        0.61 ±  5%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending
      2.57            -1.4        1.13 ±  7%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      3.45            -1.2        2.20 ±  8%  perf-profile.calltrace.cycles-pp.core_sys_select.do_pselect.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.70            -1.2        1.50 ±  8%  perf-profile.calltrace.cycles-pp.__poll.stress_run
      2.45            -1.1        1.31 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll.stress_run
      2.43            -1.1        1.30 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll.stress_run
      2.77            -1.1        1.65 ±  8%  perf-profile.calltrace.cycles-pp.do_select.core_sys_select.do_pselect.__x64_sys_pselect6.do_syscall_64
      3.70            -1.1        2.58 ±  8%  perf-profile.calltrace.cycles-pp.ppoll.stress_run
      2.92            -1.1        1.82 ±  8%  perf-profile.calltrace.cycles-pp.__select
      2.30            -1.1        1.20 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll.stress_run
      2.13            -1.1        1.08 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      2.67            -1.0        1.63 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__select
      2.65            -1.0        1.62 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      2.54            -1.0        1.54 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      2.51            -1.0        1.51 ±  9%  perf-profile.calltrace.cycles-pp.do_pselect.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe.__select
      2.91            -0.9        2.02 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ppoll.stress_run
      2.86            -0.9        1.98 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ppoll.stress_run
      1.35            -0.9        0.49 ± 45%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      2.53            -0.8        1.72 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_ppoll.do_syscall_64.entry_SYSCALL_64_after_hwframe.ppoll.stress_run
      1.07            -0.7        0.38 ± 70%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.01            -0.6        1.36 ± 28%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write.stress_run
      2.57            -0.6        1.94 ±  9%  perf-profile.calltrace.cycles-pp.pselect.stress_run
      1.24            -0.6        0.64 ±  9%  perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.32            -0.6        1.75 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.pselect.stress_run
      2.30            -0.6        1.74 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.pselect.stress_run
      2.18            -0.5        1.65 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe.pselect.stress_run
      2.10            -0.5        1.58 ±  9%  perf-profile.calltrace.cycles-pp.do_pselect.__x64_sys_pselect6.do_syscall_64.entry_SYSCALL_64_after_hwframe.pselect
      1.59            -0.5        1.08 ± 29%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read.stress_poll.stress_run
      0.72            -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.__getrlimit.stress_run
      1.46            -0.5        1.00 ±  9%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.30            -0.4        0.86 ±  9%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      0.67            -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.65            -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_run
      0.65            -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_poll
      0.77            -0.4        0.40 ± 71%  perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      0.93            -0.3        0.58 ± 45%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.70            -0.3        0.36 ± 70%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.setrlimit64.stress_run
      0.62 ±  3%      -0.3        0.29 ±100%  perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__pick_next_task.__schedule.schedule
      0.60 ±  4%      -0.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.dequeue_entities.pick_task_fair.pick_next_task_fair.__pick_next_task.__schedule
      1.09            -0.3        0.77 ±  8%  perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.56 ±  4%      -0.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.dl_server_stop.dequeue_entities.pick_task_fair.pick_next_task_fair.__pick_next_task
      1.15            -0.3        0.87 ±  8%  perf-profile.calltrace.cycles-pp.setrlimit64.stress_run
      0.74            -0.3        0.47 ± 45%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.setrlimit64.stress_run
      0.94            -0.3        0.68 ±  9%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_ppoll.do_syscall_64.entry_SYSCALL_64_after_hwframe.ppoll
      0.88            -0.2        0.65 ±  8%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      0.95            -0.1        0.88 ±  5%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      0.95            -0.1        0.88 ±  5%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      0.96            -0.1        0.90 ±  5%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.97            -0.1        0.91 ±  5%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.97            -0.1        0.91 ±  5%  perf-profile.calltrace.cycles-pp.__cmd_record
      0.97            -0.1        0.91 ±  5%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      0.97            -0.1        0.91 ±  5%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      0.00            +0.7        0.65 ± 10%  perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer
      0.00            +0.7        0.67 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      0.00            +0.7        0.70 ± 11%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      1.11 ±  8%      +0.7        1.82 ±  5%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.99 ±  9%      +0.7        1.72 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.do_nanosleep
      0.00            +0.7        0.74 ± 11%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair
      0.00            +0.8        0.75 ± 11%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__pick_next_task
      0.40 ± 71%      +0.8        1.15 ±  9%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule.schedule
      0.00            +1.0        0.95 ± 10%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule
      0.08 ±223%      +1.0        1.05 ± 10%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up
      0.75 ±  2%      +3.1        3.88 ± 26%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.09 ±223%      +3.7        3.83 ± 27%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle.do_idle
      0.00            +3.8        3.77 ± 27%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch
      0.00            +3.8        3.78 ± 27%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule
      0.00            +3.8        3.80 ± 27%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle
     39.66            +6.2       45.84 ±  2%  perf-profile.calltrace.cycles-pp.common_startup_64
     39.42            +6.2       45.61 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     39.39            +6.2       45.60 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     39.32            +6.3       45.57 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.96 ±  4%      +8.8       12.76 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer
      4.16 ±  4%      +8.9       13.02 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      5.00 ±  3%      +9.2       14.23        perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start
      3.14 ±  8%     +12.2       15.34 ± 16%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      3.33 ±  8%     +12.4       15.73 ± 15%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start
     26.25           +12.6       38.87 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     24.91           +13.0       37.86 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     24.29           +13.0       37.33 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      8.54           +14.8       23.30 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
     13.88           +15.3       29.13 ±  2%  perf-profile.calltrace.cycles-pp.clock_nanosleep
     12.88           +15.6       28.47 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     12.90           +15.6       28.49 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      4.28 ± 10%     +16.2       20.46 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities
      5.70 ±  3%     +16.3       22.00 ±  5%  perf-profile.calltrace.cycles-pp.dl_server_stop.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      4.20 ±  4%     +16.4       20.62 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities.dequeue_task_fair
     11.34           +16.5       27.80 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     11.04           +16.5       27.58 ±  3%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     11.03           +16.5       27.57 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.88           +16.6       27.46 ±  3%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      4.56 ±  4%     +16.7       21.23 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities.dequeue_task_fair.try_to_block_task
      6.60 ±  2%     +16.8       23.41 ±  4%  perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      6.56 ±  2%     +16.8       23.38 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.do_nanosleep
      9.56           +16.9       26.44 ±  4%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      9.47           +16.9       26.38 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
     10.92           +20.9       31.83 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.03 ±  2%     +21.0       31.00 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      9.54 ±  2%     +21.0       30.58 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      9.38 ±  2%     +21.0       30.43 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      9.54 ±  4%     +21.4       30.97 ±  8%  perf-profile.calltrace.cycles-pp.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate
      9.13 ±  4%     +21.6       30.74 ±  8%  perf-profile.calltrace.cycles-pp.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task
      8.84 ±  4%     +21.7       30.56 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair
      6.41 ±  3%     +24.0       30.41 ±  8%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up
      8.60 ±  2%     +24.8       33.35 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      8.58 ±  2%     +24.8       33.33 ±  7%  perf-profile.calltrace.cycles-pp.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      7.13 ±  3%     +24.8       31.91 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup
      7.15 ±  3%     +24.8       31.94 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      7.19 ±  3%     +24.8       31.99 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      8.91 ±  2%     +24.8       33.76 ±  7%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     40.62           -19.6       21.06 ± 10%  perf-profile.children.cycles-pp.stress_run
     16.04            -8.1        7.94 ±  9%  perf-profile.children.cycles-pp.stress_poll
     13.84            -7.6        6.21 ±  8%  perf-profile.children.cycles-pp.write
     14.59            -7.6        7.03 ±  9%  perf-profile.children.cycles-pp.read
     12.53            -7.5        4.99 ± 10%  perf-profile.children.cycles-pp.intel_idle
     10.91            -6.7        4.20 ±  9%  perf-profile.children.cycles-pp.ksys_read
     10.44            -6.6        3.85 ±  9%  perf-profile.children.cycles-pp.vfs_read
     10.41            -6.5        3.90 ±  8%  perf-profile.children.cycles-pp.ksys_write
     10.00            -6.5        3.53 ±  9%  perf-profile.children.cycles-pp.pipe_read
      7.51            -6.4        1.07 ±  3%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      7.42            -6.4        0.98 ±  4%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
     10.00            -6.4        3.59 ±  8%  perf-profile.children.cycles-pp.vfs_write
      9.34            -6.3        3.08 ±  8%  perf-profile.children.cycles-pp.pipe_write
      6.96 ±  2%      -5.9        1.03 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
      5.18            -4.7        0.53 ±  8%  perf-profile.children.cycles-pp.__wake_up_sync_key
      4.50            -4.4        0.12 ± 10%  perf-profile.children.cycles-pp.__wake_up_common
     48.46            -2.3       46.12        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.58            -2.3        0.30 ±  6%  perf-profile.children.cycles-pp.select_task_rq
     47.90            -2.2       45.72        perf-profile.children.cycles-pp.do_syscall_64
      2.35            -2.1        0.27 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      2.03            -1.8        0.22 ±  5%  perf-profile.children.cycles-pp.select_idle_sibling
      4.74            -1.5        3.19 ±  8%  perf-profile.children.cycles-pp.__x64_sys_pselect6
      4.63            -1.5        3.10 ±  8%  perf-profile.children.cycles-pp.do_pselect
      2.68            -1.5        1.17 ±  7%  perf-profile.children.cycles-pp.dequeue_entity
      3.11            -1.3        1.80 ±  8%  perf-profile.children.cycles-pp.do_sys_poll
      3.35            -1.3        2.05 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.34            -1.3        1.07 ±  9%  perf-profile.children.cycles-pp.pipe_poll
      3.48            -1.3        2.22 ±  9%  perf-profile.children.cycles-pp.core_sys_select
      2.82            -1.2        1.60 ±  8%  perf-profile.children.cycles-pp.__poll
      4.00            -1.2        2.82 ±  8%  perf-profile.children.cycles-pp.ppoll
      3.05            -1.1        1.92 ±  8%  perf-profile.children.cycles-pp.__select
      2.82            -1.1        1.69 ±  8%  perf-profile.children.cycles-pp.do_select
      2.32            -1.1        1.22 ±  8%  perf-profile.children.cycles-pp.__x64_sys_poll
      1.17            -1.0        0.15 ±  6%  perf-profile.children.cycles-pp.available_idle_cpu
      1.85            -1.0        0.84 ±  7%  perf-profile.children.cycles-pp.update_load_avg
      1.05            -1.0        0.08 ± 10%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.12            -0.8        0.27 ±  8%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      3.48            -0.8        2.67 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      3.11 ±  3%      -0.8        2.30 ±  4%  perf-profile.children.cycles-pp.__pick_next_task
      2.55            -0.8        1.74 ±  8%  perf-profile.children.cycles-pp.__x64_sys_ppoll
      2.07            -0.8        1.27 ±  8%  perf-profile.children.cycles-pp.enqueue_entity
      1.85            -0.8        1.07 ±  8%  perf-profile.children.cycles-pp.do_poll
      0.77            -0.7        0.03 ± 70%  perf-profile.children.cycles-pp.__smp_call_single_queue
      1.75            -0.7        1.03 ±  9%  perf-profile.children.cycles-pp.mutex_lock
      2.84 ±  3%      -0.7        2.14 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.88            -0.7        0.19 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      2.67            -0.7        2.02 ±  8%  perf-profile.children.cycles-pp.pselect
      0.92            -0.6        0.31 ±  7%  perf-profile.children.cycles-pp.prepare_task_switch
      0.89            -0.6        0.28 ±  9%  perf-profile.children.cycles-pp.__switch_to
      0.68            -0.6        0.07 ±  8%  perf-profile.children.cycles-pp.set_task_cpu
      0.77            -0.6        0.17 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.65            -0.6        0.07 ±  9%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.72            -0.6        0.16 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      1.13 ±  3%      -0.6        0.57 ±  9%  perf-profile.children.cycles-pp.pick_task_fair
      0.86 ±  3%      -0.5        0.32 ±  8%  perf-profile.children.cycles-pp.update_cfs_group
      0.76            -0.5        0.22 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      1.57            -0.5        1.05 ±  8%  perf-profile.children.cycles-pp._copy_from_user
      1.28            -0.5        0.77 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.80            -0.5        0.32 ±  9%  perf-profile.children.cycles-pp.__pollwait
      1.50            -0.5        1.03 ±  9%  perf-profile.children.cycles-pp.copy_page_to_iter
      1.00            -0.5        0.52 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.98            -0.5        0.51 ± 10%  perf-profile.children.cycles-pp.ktime_get
      1.31            -0.4        0.87 ±  9%  perf-profile.children.cycles-pp._copy_to_iter
      0.76            -0.4        0.34 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.64            -0.4        0.23 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.56            -0.4        0.16 ±  7%  perf-profile.children.cycles-pp.switch_fpu_return
      0.76            -0.4        0.37 ±  9%  perf-profile.children.cycles-pp.add_wait_queue
      0.64            -0.4        0.25 ±  8%  perf-profile.children.cycles-pp.sched_clock_cpu
      1.56            -0.3        1.22 ±  8%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.56            -0.3        0.22 ± 10%  perf-profile.children.cycles-pp.sched_clock
      0.47            -0.3        0.13 ±  8%  perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      0.83            -0.3        0.49 ±  8%  perf-profile.children.cycles-pp.set_user_sigmask
      1.34            -0.3        1.02 ±  8%  perf-profile.children.cycles-pp.setrlimit64
      1.12            -0.3        0.80 ±  8%  perf-profile.children.cycles-pp.touch_atime
      0.40            -0.3        0.10 ±  8%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.86            -0.3        0.56 ±  8%  perf-profile.children.cycles-pp.__do_sys_prlimit64
      0.59            -0.3        0.31 ±  4%  perf-profile.children.cycles-pp.set_next_task_fair
      0.67            -0.3        0.40 ±  8%  perf-profile.children.cycles-pp.fdget
      0.56            -0.3        0.29 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.45            -0.3        0.18 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.82            -0.3        0.55 ±  8%  perf-profile.children.cycles-pp.__getrlimit
      0.94            -0.2        0.70 ±  8%  perf-profile.children.cycles-pp.atime_needs_update
      0.54            -0.2        0.29 ±  9%  perf-profile.children.cycles-pp.hrtimer_active
      0.91            -0.2        0.66 ±  8%  perf-profile.children.cycles-pp.ktime_get_ts64
      0.95            -0.2        0.72 ±  8%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.93            -0.2        0.70 ±  9%  perf-profile.children.cycles-pp.poll_select_finish
      0.29            -0.2        0.07 ± 10%  perf-profile.children.cycles-pp.perf_tp_event
      0.34            -0.2        0.13 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.47            -0.2        0.26 ±  9%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.64 ±  2%      -0.2        0.44 ± 11%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.78            -0.2        0.58 ±  8%  perf-profile.children.cycles-pp._copy_from_iter
      0.28 ±  2%      -0.2        0.09 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      0.36            -0.2        0.18 ±  9%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.39 ±  3%      -0.2        0.20 ± 11%  perf-profile.children.cycles-pp.task_contending
      0.67            -0.2        0.49 ±  8%  perf-profile.children.cycles-pp.get_timespec64
      0.54            -0.2        0.37 ±  8%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.63            -0.2        0.46 ±  9%  perf-profile.children.cycles-pp.mutex_unlock
      0.26 ±  2%      -0.2        0.10 ± 11%  perf-profile.children.cycles-pp.__get_user_8
      0.27 ±  2%      -0.2        0.11 ± 10%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.31 ±  2%      -0.2        0.15 ±  8%  perf-profile.children.cycles-pp.__nanosleep
      0.76            -0.2        0.60 ±  8%  perf-profile.children.cycles-pp.current_time
      0.58 ±  3%      -0.2        0.43 ±  8%  perf-profile.children.cycles-pp.idle_cpu
      0.25            -0.2        0.10 ± 11%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.32            -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.do_prlimit
      0.48            -0.1        0.34 ±  9%  perf-profile.children.cycles-pp.fdget_pos
      0.59            -0.1        0.44 ±  8%  perf-profile.children.cycles-pp.file_update_time
      0.64            -0.1        0.50 ±  8%  perf-profile.children.cycles-pp.poll_freewait
      0.54            -0.1        0.40 ±  8%  perf-profile.children.cycles-pp.select_estimate_accuracy
      0.24            -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.sleep
      0.35            -0.1        0.22 ±  8%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.49            -0.1        0.36 ±  9%  perf-profile.children.cycles-pp.rw_verify_area
      0.22 ±  2%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.reweight_entity
      0.87 ±  2%      -0.1        0.75 ±  7%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.48            -0.1        0.36 ±  9%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.17            -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.32            -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.67            -0.1        0.57 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      0.25            -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.13 ±  3%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.18 ±  2%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.update_entity_lag
      0.38            -0.1        0.29 ±  9%  perf-profile.children.cycles-pp.remove_wait_queue
      0.48            -0.1        0.39 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.29 ±  3%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.12            -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.40            -0.1        0.32 ±  8%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.14            -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.ct_idle_exit
      0.28            -0.1        0.20 ±  8%  perf-profile.children.cycles-pp.__set_current_blocked
      0.44 ±  2%      -0.1        0.36 ±  8%  perf-profile.children.cycles-pp.x64_sys_call
      0.12 ±  3%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.__calc_delta
      0.26 ±  2%      -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.32            -0.1        0.24 ±  8%  perf-profile.children.cycles-pp._copy_to_user
      0.32            -0.1        0.25 ±  9%  perf-profile.children.cycles-pp.__cond_resched
      0.32            -0.1        0.25 ±  8%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.13 ±  3%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__dequeue_entity
      0.12 ±  3%      -0.1        0.05 ± 45%  perf-profile.children.cycles-pp.call_cpuidle
      0.28            -0.1        0.22 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.28            -0.1        0.21 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.18 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.95            -0.1        0.88 ±  5%  perf-profile.children.cycles-pp.queue_event
      0.12            -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.update_min_vruntime
      0.95            -0.1        0.88 ±  5%  perf-profile.children.cycles-pp.ordered_events__queue
      0.30            -0.1        0.23 ±  9%  perf-profile.children.cycles-pp.put_timespec64
      0.20 ±  2%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.place_entity
      0.96            -0.1        0.90 ±  5%  perf-profile.children.cycles-pp.process_simple
      0.10 ±  5%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.97            -0.1        0.91 ±  5%  perf-profile.children.cycles-pp.perf_session__process_events
      0.97            -0.1        0.91 ±  5%  perf-profile.children.cycles-pp.reader__read_event
      0.97            -0.1        0.91 ±  5%  perf-profile.children.cycles-pp.record__finish_output
      0.47            -0.1        0.42 ±  9%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.19 ±  2%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.recalc_sigpending
      0.20            -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.18 ±  4%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.__enqueue_entity
      0.14 ±  2%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.poll_select_set_timeout
      0.10            -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.task_non_contending
      0.15            -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.os_xsave
      0.10 ±  3%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__mutex_lock
      0.16 ±  2%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.fput
      0.19            -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.security_file_permission
      0.15            -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.17 ±  2%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.rcu_all_qs
      0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.vruntime_eligible
      0.14            -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.__check_object_size
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__put_user_8
      0.11            -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.__fdelt_warn
      0.14 ±  3%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.__memset
      0.12 ±  4%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.kill_fasync
      0.14            -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.avg_vruntime
      0.09            -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.make_vfsgid
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.task_work_run
      0.08            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__fdelt_chk@plt
      0.10 ±  5%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.put_prev_entity
      0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.07            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.get_sigset_argpack
      0.08 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.sched_balance_domains
      0.07 ±  9%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp._find_next_and_bit
      0.06 ±  6%      +0.0        0.09 ± 30%  perf-profile.children.cycles-pp.handle_internal_command
      0.06 ±  6%      +0.0        0.09 ± 30%  perf-profile.children.cycles-pp.main
      0.06 ±  6%      +0.0        0.09 ± 30%  perf-profile.children.cycles-pp.run_builtin
      0.05            +0.0        0.08 ± 31%  perf-profile.children.cycles-pp.cmd_record
      0.00            +0.1        0.06 ± 31%  perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +0.1        0.07 ± 36%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.48            +0.1        0.57 ±  8%  perf-profile.children.cycles-pp.timerqueue_del
      0.12 ±  3%      +0.1        0.22 ± 19%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.sched_balance_find_src_rq
      0.41            +0.1        0.52 ±  8%  perf-profile.children.cycles-pp.rb_erase
      0.08 ±  6%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.24 ±  4%      +0.2        0.43 ± 19%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.30 ±  3%      +0.2        0.48 ± 18%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.12 ±  7%      +0.2        0.32 ± 22%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.45 ±  2%      +0.3        0.74 ± 18%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.15            +0.3        0.46 ± 22%  perf-profile.children.cycles-pp.poll_idle
      0.80 ± 16%      +0.4        1.17 ±  9%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.38 ± 28%      +0.4        0.77 ± 11%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.36 ± 30%      +0.4        0.74 ± 11%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.40 ± 27%      +0.4        0.79 ± 11%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.47 ± 24%      +0.5        1.00 ±  9%  perf-profile.children.cycles-pp.sched_balance_rq
      1.51            +2.6        4.10 ± 25%  perf-profile.children.cycles-pp.finish_task_switch
     39.66            +6.2       45.84 ±  2%  perf-profile.children.cycles-pp.common_startup_64
     39.66            +6.2       45.84 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     39.42            +6.2       45.61 ±  3%  perf-profile.children.cycles-pp.start_secondary
     39.60            +6.2       45.82 ±  2%  perf-profile.children.cycles-pp.do_idle
      5.60 ±  2%      +8.7       14.34        perf-profile.children.cycles-pp._raw_spin_lock
      6.49 ±  2%      +8.8       15.24        perf-profile.children.cycles-pp.__hrtimer_start_range_ns
     13.94           +12.5       26.47 ±  4%  perf-profile.children.cycles-pp.schedule
     26.42           +12.7       39.07 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
     25.01           +13.0       37.98 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
     24.98           +13.0       37.97 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
     18.29           +13.4       31.65 ±  6%  perf-profile.children.cycles-pp.__schedule
      9.51 ±  2%     +14.3       23.82 ±  5%  perf-profile.children.cycles-pp.dequeue_entities
      8.69           +14.7       23.42 ±  4%  perf-profile.children.cycles-pp.try_to_block_task
      8.63           +14.8       23.40 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
     14.16           +15.1       29.27 ±  2%  perf-profile.children.cycles-pp.clock_nanosleep
      6.58 ±  3%     +15.9       22.49 ±  5%  perf-profile.children.cycles-pp.dl_server_stop
      6.11 ±  3%     +16.0       22.10 ±  6%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
     11.36           +16.4       27.80 ±  3%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
     11.13           +16.5       27.63 ±  3%  perf-profile.children.cycles-pp.common_nsleep
     11.04           +16.5       27.58 ±  3%  perf-profile.children.cycles-pp.hrtimer_nanosleep
     10.90           +16.6       27.48 ±  3%  perf-profile.children.cycles-pp.do_nanosleep
     13.85 ±  2%     +19.6       33.48 ±  7%  perf-profile.children.cycles-pp.ttwu_do_activate
     13.09 ±  2%     +20.3       33.39 ±  7%  perf-profile.children.cycles-pp.enqueue_task
     13.56           +20.4       33.96 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
     12.92 ±  3%     +20.4       33.35 ±  7%  perf-profile.children.cycles-pp.enqueue_task_fair
     10.20 ±  4%     +21.4       31.56 ±  8%  perf-profile.children.cycles-pp.enqueue_dl_entity
     10.24 ±  4%     +21.4       31.61 ±  8%  perf-profile.children.cycles-pp.dl_server_start
     11.02 ±  3%     +21.5       32.51 ±  7%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      9.74 ±  4%     +21.6       31.34 ±  8%  perf-profile.children.cycles-pp.start_dl_timer
     12.42           +24.0       36.41 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     11.69           +24.1       35.78 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     11.11 ±  2%     +24.2       35.30 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     10.91 ±  2%     +24.2       35.13 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
     10.24 ±  2%     +24.2       34.49 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      9.69 ±  2%     +24.3       33.96 ±  7%  perf-profile.children.cycles-pp.hrtimer_wakeup
     11.90 ±  4%     +27.9       39.77 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     13.14 ±  4%     +38.1       51.29 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     12.52            -7.5        4.99 ± 10%  perf-profile.self.cycles-pp.intel_idle
      3.10            -1.4        1.72 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.16            -1.0        0.15 ±  6%  perf-profile.self.cycles-pp.available_idle_cpu
      1.65            -0.9        0.74 ±  5%  perf-profile.self.cycles-pp.__schedule
      1.07            -0.9        0.20 ±  8%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.44            -0.6        0.80 ±  9%  perf-profile.self.cycles-pp.mutex_lock
      0.87            -0.6        0.27 ±  9%  perf-profile.self.cycles-pp.__switch_to
      0.88            -0.6        0.28 ±  8%  perf-profile.self.cycles-pp.update_load_avg
      1.94            -0.6        1.36 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.64            -0.6        0.07 ±  9%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.85 ±  3%      -0.5        0.31 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.75            -0.5        0.22 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      1.51            -0.5        1.02 ±  8%  perf-profile.self.cycles-pp._copy_from_user
      0.72            -0.5        0.23 ±  6%  perf-profile.self.cycles-pp.prepare_task_switch
      0.58            -0.5        0.09 ±  7%  perf-profile.self.cycles-pp.__wake_up_common
      1.22            -0.5        0.74 ±  8%  perf-profile.self.cycles-pp.read_tsc
      0.77            -0.5        0.31 ±  9%  perf-profile.self.cycles-pp.__pollwait
      1.25            -0.5        0.79 ±  9%  perf-profile.self.cycles-pp.stress_poll
      1.29 ±  2%      -0.5        0.83 ±  8%  perf-profile.self.cycles-pp.pipe_read
      1.26            -0.4        0.84 ±  9%  perf-profile.self.cycles-pp._copy_to_iter
      0.59            -0.4        0.18 ±  4%  perf-profile.self.cycles-pp.finish_task_switch
      0.62            -0.4        0.22 ±  9%  perf-profile.self.cycles-pp.native_sched_clock
      0.71            -0.4        0.34 ±  9%  perf-profile.self.cycles-pp.pipe_poll
      0.43            -0.4        0.08 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.92            -0.4        0.57 ±  9%  perf-profile.self.cycles-pp.pipe_write
      1.53            -0.3        1.19 ±  8%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.40            -0.3        0.10 ±  8%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.42            -0.3        0.14 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.56            -0.3        0.29 ±  9%  perf-profile.self.cycles-pp.do_sys_poll
      0.63            -0.3        0.37 ±  9%  perf-profile.self.cycles-pp.fdget
      1.08            -0.2        0.83 ±  9%  perf-profile.self.cycles-pp.read
      0.38            -0.2        0.13 ±  7%  perf-profile.self.cycles-pp.dequeue_entity
      0.42            -0.2        0.17 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.92            -0.2        0.67 ±  8%  perf-profile.self.cycles-pp.do_syscall_64
      0.99            -0.2        0.74 ±  8%  perf-profile.self.cycles-pp.write
      0.28            -0.2        0.04 ± 45%  perf-profile.self.cycles-pp.set_task_cpu
      0.51            -0.2        0.28 ± 10%  perf-profile.self.cycles-pp.hrtimer_active
      0.46            -0.2        0.23 ±  7%  perf-profile.self.cycles-pp.update_rq_clock
      0.76            -0.2        0.57 ±  9%  perf-profile.self.cycles-pp._copy_from_iter
      0.32 ±  2%      -0.2        0.13 ±  8%  perf-profile.self.cycles-pp.update_curr
      0.70            -0.2        0.52 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.28            -0.2        0.11 ±  8%  perf-profile.self.cycles-pp.do_idle
      0.34            -0.2        0.17 ±  7%  perf-profile.self.cycles-pp.clock_nanosleep
      0.60            -0.2        0.44 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.91            -0.2        0.74 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.22 ±  3%      -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.60            -0.2        0.44 ±  9%  perf-profile.self.cycles-pp.mutex_unlock
      0.57 ±  2%      -0.2        0.41 ±  9%  perf-profile.self.cycles-pp.idle_cpu
      0.25 ±  2%      -0.2        0.10 ±  9%  perf-profile.self.cycles-pp.__get_user_8
      0.45 ±  2%      -0.2        0.30 ±  9%  perf-profile.self.cycles-pp.atime_needs_update
      0.37 ±  2%      -0.1        0.23 ± 11%  perf-profile.self.cycles-pp.ktime_get
      0.58            -0.1        0.43 ±  9%  perf-profile.self.cycles-pp.vfs_read
      0.24            -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.44 ±  2%      -0.1        0.30 ±  9%  perf-profile.self.cycles-pp.fdget_pos
      0.46            -0.1        0.34 ±  9%  perf-profile.self.cycles-pp.ppoll
      0.21            -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.23 ±  2%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.19 ±  2%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.___perf_sw_event
      0.18 ±  2%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.46            -0.1        0.33 ±  8%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.21            -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.sleep
      0.57            -0.1        0.46 ±  9%  perf-profile.self.cycles-pp.do_select
      0.46            -0.1        0.34 ±  8%  perf-profile.self.cycles-pp.vfs_write
      0.42            -0.1        0.31 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.16 ±  2%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.switch_fpu_return
      0.29            -0.1        0.18 ±  9%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.19            -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.reweight_entity
      0.20            -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.13 ±  3%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.29            -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.rw_verify_area
      0.11            -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__calc_delta
      0.44            -0.1        0.35 ±  8%  perf-profile.self.cycles-pp.current_time
      0.40            -0.1        0.32 ±  8%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.18 ±  2%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.11 ±  4%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.28            -0.1        0.20 ±  8%  perf-profile.self.cycles-pp.__do_sys_prlimit64
      0.10 ±  3%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__dequeue_entity
      0.30            -0.1        0.23 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.31            -0.1        0.24 ±  9%  perf-profile.self.cycles-pp._copy_to_user
      0.39            -0.1        0.32 ±  9%  perf-profile.self.cycles-pp.x64_sys_call
      0.11            -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.update_min_vruntime
      0.28            -0.1        0.21 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.29 ±  2%      -0.1        0.22 ±  8%  perf-profile.self.cycles-pp.ktime_get_ts64
      0.28            -0.1        0.22 ±  9%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.23            -0.1        0.17 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10 ±  3%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.place_entity
      0.13 ±  3%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.__wake_up_sync_key
      0.20 ±  2%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.select_estimate_accuracy
      0.47            -0.1        0.42 ±  9%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.30            -0.1        0.25 ± 11%  perf-profile.self.cycles-pp.core_sys_select
      0.21 ±  3%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.dequeue_entities
      0.20            -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.15            -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.get_timespec64
      0.24            -0.0        0.19 ±  7%  perf-profile.self.cycles-pp.do_poll
      0.21            -0.0        0.16 ±  9%  perf-profile.self.cycles-pp.setrlimit64
      0.21            -0.0        0.16 ±  7%  perf-profile.self.cycles-pp.ksys_write
      0.19 ±  2%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.recalc_sigpending
      0.23 ±  2%      -0.0        0.18 ±  8%  perf-profile.self.cycles-pp.ksys_read
      0.18            -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__cond_resched
      0.17 ±  2%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.15            -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.os_xsave
      0.11 ±  6%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__pick_next_task
      0.16 ±  2%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.__select
      0.21            -0.0        0.17 ±  9%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.17 ±  4%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__enqueue_entity
      0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__put_user_8
      0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.common_nsleep
      0.16 ±  3%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.12 ±  3%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.16            -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.security_file_permission
      0.15 ±  2%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.fput
      0.11            -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.vruntime_eligible
      0.12 ±  3%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.__nanosleep
      0.12            -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.__x64_sys_clock_nanosleep
      0.07            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__fdelt_warn
      0.13 ±  2%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.__poll
      0.12            -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.poll_select_finish
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.set_user_sigmask
      0.13 ±  2%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.pselect
      0.10 ±  4%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.get_nohz_timer_target
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__getrlimit
      0.09            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.do_prlimit
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.rcu_all_qs
      0.09            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.07 ±  5%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.get_sigset_argpack
      0.10 ±  3%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.do_nanosleep
      0.10 ±  4%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.file_update_time
      0.07 ±  7%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.kill_fasync
      0.12 ±  3%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.__memset
      0.10 ±  5%      -0.0        0.08 ± 12%  perf-profile.self.cycles-pp.start_dl_timer
      0.08 ±  4%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.09            -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__x64_sys_ppoll
      0.13 ±  3%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.avg_vruntime
      0.08            -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.add_wait_queue
      0.08            -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.hrtimer_nanosleep
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.do_pselect
      0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.touch_atime
      0.07 ±  7%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.sched_balance_find_src_rq
      0.40            +0.1        0.52 ±  8%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.2        0.15 ±  9%  perf-profile.self.cycles-pp.update_curr_dl_se
      0.29 ± 30%      +0.3        0.58 ± 11%  perf-profile.self.cycles-pp.update_sg_lb_stats
     13.13 ±  5%     +38.1       51.28 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/tee/stress-ng/60s

commit: 
  d2fc0ed52a ("Merge branch 'vfs-6.14.uncached_buffered_io'")
  aaec5a95d5 ("pipe_read: don't wake up the writer if the pipe is still full")

d2fc0ed52a284a13 aaec5a95d59615523db03dd53c2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    123346 ± 30%     -48.2%      63936 ± 24%  cpuidle..usage
     11.44            +5.9       17.37        mpstat.cpu.all.usr%
      1237 ± 32%     -83.3%     206.40 ± 20%  perf-c2c.DRAM.local
    934.33 ±  7%     +53.9%       1438 ± 10%  perf-c2c.DRAM.remote
    263.67 ± 11%     +26.7%     334.00 ±  5%  perf-c2c.HITM.remote
     11.14           +51.4%      16.87        vmstat.cpu.us
  22963300           -95.8%     968409        vmstat.system.cs
    197683            -8.3%     181346        vmstat.system.in
   5623585 ± 19%     -55.7%    2490490 ± 19%  numa-meminfo.node1.Active
   5623585 ± 19%     -55.7%    2490490 ± 19%  numa-meminfo.node1.Active(anon)
   1738706 ±  8%     -70.3%     516074 ± 29%  numa-meminfo.node1.Mapped
   5336025 ± 20%     -61.3%    2063073 ± 14%  numa-meminfo.node1.Shmem
   7701721           +79.2%   13801344        numa-numastat.node0.local_node
   7732133           +79.0%   13842144        numa-numastat.node0.numa_hit
   9660861 ±  4%     +51.6%   14643708        numa-numastat.node1.local_node
   9696676 ±  4%     +51.3%   14669530        numa-numastat.node1.numa_hit
   4203288          +500.7%   25250189        stress-ng.tee.ops
     70053          +500.7%     420829        stress-ng.tee.ops_per_sec
 7.264e+08           -96.5%   25607922        stress-ng.time.involuntary_context_switches
      3392            -7.6%       3134        stress-ng.time.system_time
    356.72           +78.5%     636.76        stress-ng.time.user_time
  7.31e+08           -95.1%   35783971        stress-ng.time.voluntary_context_switches
   7716552           +79.4%   13841559        numa-vmstat.node0.numa_hit
   7686141           +79.6%   13800760        numa-vmstat.node0.numa_local
   1403134 ± 19%     -55.6%     622772 ± 19%  numa-vmstat.node1.nr_active_anon
    432841 ±  7%     -69.9%     130433 ± 27%  numa-vmstat.node1.nr_mapped
   1331229 ± 19%     -61.3%     515736 ± 14%  numa-vmstat.node1.nr_shmem
   1403134 ± 19%     -55.6%     622771 ± 19%  numa-vmstat.node1.nr_zone_active_anon
   9682370 ±  3%     +51.5%   14668660        numa-vmstat.node1.numa_hit
   9646555 ±  4%     +51.8%   14642837        numa-vmstat.node1.numa_local
   6151580 ± 17%     -51.1%    3005085 ±  4%  meminfo.Active
   6151580 ± 17%     -51.1%    3005085 ±  4%  meminfo.Active(anon)
   8920705 ± 11%     -35.0%    5794702        meminfo.Cached
   7882102 ± 13%     -40.6%    4678787        meminfo.Committed_AS
   1893975 ±  6%     -63.9%     682914 ± 24%  meminfo.Mapped
  11167190 ±  9%     -28.6%    7968104        meminfo.Memused
     27261 ±  2%     -13.4%      23618 ±  6%  meminfo.PageTables
   5395896 ± 19%     -57.9%    2269891        meminfo.Shmem
  11232918 ±  9%     -27.7%    8115848        meminfo.max_used_kB
      0.55 ±  5%     -24.7%       0.42 ±  4%  sched_debug.cfs_rq:/.h_nr_running.stddev
    267.15 ± 77%     -71.5%      76.26 ± 16%  sched_debug.cfs_rq:/.load_avg.avg
     10410 ±122%     -93.8%     641.30 ± 33%  sched_debug.cfs_rq:/.load_avg.max
      1371 ±112%     -88.1%     163.88 ± 10%  sched_debug.cfs_rq:/.load_avg.stddev
    833.50 ± 23%     +24.0%       1033        sched_debug.cfs_rq:/.runnable_avg.min
    247.56 ± 10%     -14.6%     211.50 ± 12%  sched_debug.cfs_rq:/.runnable_avg.stddev
    485.86 ±  5%     +30.5%     633.96 ±  5%  sched_debug.cfs_rq:/.util_est.avg
      1085 ±  5%     +16.3%       1262 ±  9%  sched_debug.cfs_rq:/.util_est.max
    173.70 ±  7%     +36.8%     237.65 ±  6%  sched_debug.cfs_rq:/.util_est.stddev
    398375 ±  4%     +12.5%     448175 ±  2%  sched_debug.cpu.avg_idle.avg
    176609 ± 11%     +38.4%     244462 ±  5%  sched_debug.cpu.avg_idle.stddev
      0.55 ±  5%     -22.3%       0.43 ±  3%  sched_debug.cpu.nr_running.stddev
  11181287           -95.8%     474442        sched_debug.cpu.nr_switches.avg
  11740535           -95.7%     505782 ±  2%  sched_debug.cpu.nr_switches.max
   8593260 ±  5%     -95.1%     424452 ±  4%  sched_debug.cpu.nr_switches.min
    569340 ± 10%     -97.7%      12920 ± 14%  sched_debug.cpu.nr_switches.stddev
   1537988 ± 17%     -51.2%     751031 ±  3%  proc-vmstat.nr_active_anon
   6276579            +1.3%    6356360        proc-vmstat.nr_dirty_background_threshold
  12568504            +1.3%   12728261        proc-vmstat.nr_dirty_threshold
   2230307 ± 11%     -35.1%    1448223        proc-vmstat.nr_file_pages
  63142546            +1.3%   63941500        proc-vmstat.nr_free_pages
    472553 ±  6%     -64.0%     170048 ± 22%  proc-vmstat.nr_mapped
      6828 ±  2%     -13.2%       5929 ±  6%  proc-vmstat.nr_page_table_pages
   1349103 ± 19%     -58.0%     567019        proc-vmstat.nr_shmem
     26209 ±  2%      -6.9%      24399        proc-vmstat.nr_slab_reclaimable
   1537988 ± 17%     -51.2%     751031 ±  3%  proc-vmstat.nr_zone_active_anon
    167438 ± 12%     -50.9%      82288 ± 24%  proc-vmstat.numa_hint_faults
    106871 ± 19%     -62.1%      40516 ± 33%  proc-vmstat.numa_hint_faults_local
  17429790 ±  2%     +63.6%   28512466        proc-vmstat.numa_hit
  17363565 ±  2%     +63.8%   28445844        proc-vmstat.numa_local
  17470213 ±  2%     +63.5%   28565863        proc-vmstat.pgalloc_normal
    645222           -20.6%     512041 ±  3%  proc-vmstat.pgfault
  15401346           +80.1%   27730965        proc-vmstat.pgfree
 5.248e+10            +8.6%  5.701e+10        perf-stat.i.branch-instructions
      0.33 ±  3%      -0.2        0.10 ± 11%  perf-stat.i.branch-miss-rate%
 1.647e+08 ±  2%     -71.0%   47792335 ±  9%  perf-stat.i.branch-misses
     19.40 ±  8%      +5.2       24.63 ±  7%  perf-stat.i.cache-miss-rate%
   9432268 ± 15%     -23.5%    7215380 ± 14%  perf-stat.i.cache-misses
  46766538 ± 10%     -34.7%   30557228 ±  8%  perf-stat.i.cache-references
  23928853           -95.8%    1009521        perf-stat.i.context-switches
    373.88           -95.8%      15.81        perf-stat.i.metric.K/sec
      8711 ±  3%     -23.2%       6694 ±  4%  perf-stat.i.minor-faults
      8711 ±  3%     -23.1%       6694 ±  4%  perf-stat.i.page-faults
      0.31 ±  2%      -0.2        0.08 ±  9%  perf-stat.overall.branch-miss-rate%
     20.07 ±  7%      +3.3       23.33 ±  6%  perf-stat.overall.cache-miss-rate%
  5.16e+10            +8.6%  5.606e+10        perf-stat.ps.branch-instructions
 1.616e+08 ±  2%     -71.0%   46862413 ±  9%  perf-stat.ps.branch-misses
   9324763 ± 15%     -23.8%    7101263 ± 15%  perf-stat.ps.cache-misses
  46321216 ± 10%     -34.6%   30283901 ±  8%  perf-stat.ps.cache-references
  23514896           -95.8%     992706        perf-stat.ps.context-switches
      8550 ±  2%     -23.0%       6584 ±  4%  perf-stat.ps.minor-faults
      8550 ±  2%     -23.0%       6584 ±  4%  perf-stat.ps.page-faults
      0.00 ±223%   +2945.0%       0.08 ±150%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
     13.16 ± 77%     -93.4%       0.87 ±132%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +74228.0%       0.62 ± 53%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.98 ± 30%     -70.0%       0.30 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.18 ±140%    +313.8%       0.76 ± 45%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     14.41 ±148%     -99.1%       0.12 ± 18%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 53%    +564.2%       0.10 ± 44%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.33 ± 33%     -33.3%       0.22 ± 34%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.86 ± 27%     -77.3%       0.20        perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.29 ± 27%     -89.3%       0.14 ± 40%  perf-sched.sch_delay.avg.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
      0.02 ± 23%     -56.7%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
      0.34 ± 15%     -69.1%       0.10 ±  2%  perf-sched.sch_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      9.19 ± 61%     -99.8%       0.01 ± 67%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02 ± 20%    +287.4%       0.09        perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     17.13 ± 92%     -99.0%       0.18 ±112%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%   +3485.6%       0.15 ±164%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.10 ±158%   +1534.9%       1.65 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
    863.48 ± 36%     -70.7%     252.62 ±149%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +5.5e+05%       4.62 ± 63%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      1.28 ±217%    +504.3%       7.74 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
    203.65 ± 26%     -95.4%       9.44 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.04 ±223%    +444.1%       0.20 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.54 ±142%   +1407.1%       8.13 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.27 ±135%   +1223.4%       3.63 ± 81%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      2014 ± 40%     -99.0%      19.92 ± 29%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    299.74 ± 13%     -96.5%      10.45 ± 64%  perf-sched.sch_delay.max.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
    328.92 ± 16%     -91.7%      27.21 ±166%  perf-sched.sch_delay.max.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
    309.06 ± 14%     -89.4%      32.70 ±100%  perf-sched.sch_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    444.84 ± 29%     -99.7%       1.19 ±129%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    939.99 ± 61%     -94.4%      52.33 ±127%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1372 ± 80%     -98.8%      16.87 ±160%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 20%    +127.0%       0.07        perf-sched.total_sch_delay.average.ms
      2159 ± 40%     -87.1%     278.03 ±131%  perf-sched.total_sch_delay.max.ms
      0.12 ± 15%    +213.1%       0.38 ±  2%  perf-sched.total_wait_and_delay.average.ms
  12670156 ± 20%     -65.4%    4386881        perf-sched.total_wait_and_delay.count.ms
      5167 ± 12%     -20.5%       4108        perf-sched.total_wait_and_delay.max.ms
      0.09 ± 14%    +242.6%       0.31 ±  2%  perf-sched.total_wait_time.average.ms
     38.76 ± 39%     -69.3%      11.90 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.00 ± 29%     -68.8%       0.62 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.35 ±149%    +330.4%       1.52 ± 45%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.66 ± 33%     -38.7%       0.41 ± 53%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.94 ± 47%     -81.1%       0.56 ± 62%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      3.20 ± 14%     -51.5%       1.55 ± 23%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.99 ± 27%     -86.5%       0.40 ± 29%  perf-sched.wait_and_delay.avg.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
      0.05 ± 22%    +215.4%       0.17        perf-sched.wait_and_delay.avg.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
      5.84 ± 22%     -94.9%       0.30 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     22.31 ± 37%     -86.9%       2.92 ± 15%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     60.96 ± 64%     -95.9%       2.48 ± 15%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    694.35 ± 24%     -34.8%     452.48        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     41.35 ± 51%     -61.4%      15.94 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    837.15 ±  9%     -38.7%     513.26 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 18%    +287.7%       0.19        perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    974.67 ± 43%     -81.2%     183.00 ± 98%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
    172.83 ± 12%    +115.7%     372.80 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2935 ± 44%     -60.9%       1147 ± 26%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.00 ±141%  +17520.0%     176.20 ± 25%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      1742 ± 16%     +66.8%       2906 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
    517.00 ± 55%    +596.3%       3600 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      1.00 ±141%  +32440.0%     325.40 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
    885.67 ± 41%     -65.1%     308.80 ± 54%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      1.17 ± 76%    +328.6%       5.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     46.17 ± 21%    +102.3%      93.40 ±  3%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.33 ± 61%    +203.2%      19.20 ±  5%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    827.50 ± 20%    +192.3%       2418 ±  8%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     23590 ± 24%    +194.3%      69429 ± 22%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     34754 ± 32%    +467.3%     197159 ± 28%  perf-sched.wait_and_delay.count.pipe_wait_readable.ipipe_prep.part.0.do_tee
   6287013 ± 20%     -74.8%    1585356 ±  3%  perf-sched.wait_and_delay.count.pipe_wait_writable.opipe_prep.part.0.do_tee
     46312 ± 21%   +1467.4%     725907 ±  6%  perf-sched.wait_and_delay.count.pipe_write.vfs_write.ksys_write.do_syscall_64
     24.50 ± 22%     +92.7%      47.20 ± 15%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     11.67 ± 24%     +98.9%      23.20        perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     40.67 ± 22%    +114.4%      87.20        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      8.83 ± 28%    +121.9%      19.60 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    319.00 ± 16%    +103.7%     649.80 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
   6266766 ± 20%     -71.4%    1792099        perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     15.00 ± 27%    +144.0%      36.60        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    207.17 ± 33%    +104.6%     423.80 ±  8%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1843 ± 20%     -34.8%       1201 ± 33%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.56 ±218%    +505.4%      15.49 ± 17%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
    407.31 ± 26%     -95.4%      18.88 ± 10%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      1.04 ±149%   +1457.6%      16.26 ± 32%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1185 ± 57%     -94.0%      70.68 ±122%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4839 ± 21%     -63.0%       1788 ± 64%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    599.48 ± 13%     -94.8%      30.94 ± 68%  perf-sched.wait_and_delay.max.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
    657.85 ± 16%     -91.5%      55.93 ±160%  perf-sched.wait_and_delay.max.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
    673.79 ± 21%     -90.3%      65.42 ±100%  perf-sched.wait_and_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    284.00 ± 52%     -95.5%      12.82 ±110%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1366 ± 52%     -98.7%      17.62 ± 86%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2100 ± 52%     -76.0%     505.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1044 ± 29%     -61.4%     403.20 ± 22%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2349 ± 19%     -57.4%       1000        perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     25.60 ± 21%     -56.9%      11.03 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +74228.0%       0.62 ± 53%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      1.02 ± 28%     -67.7%       0.33 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.18 ±140%    +313.8%       0.76 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.33 ± 33%     -33.3%       0.22 ± 34%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.63 ± 50%     -87.7%       0.32 ± 47%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      2.34 ± 14%     -42.1%       1.36 ± 26%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.70 ± 27%     -84.4%       0.26 ± 24%  perf-sched.wait_time.avg.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
      0.03 ± 20%    +408.2%       0.16        perf-sched.wait_time.avg.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
      5.51 ± 23%     -96.5%       0.19 ±  2%  perf-sched.wait_time.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     19.69 ± 35%     -85.8%       2.79 ±  8%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%  +20831.4%       0.24 ± 55%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_double_lock
     49.52 ± 60%     -95.6%       2.19 ± 15%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    694.34 ± 24%     -34.8%     452.47        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    837.02 ±  9%     -38.7%     513.25 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 17%    +287.0%       0.10        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.19 ±131%   +1122.8%       2.33 ± 76%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
      0.00 ±223%  +5.5e+05%       4.62 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      1.28 ±217%    +504.3%       7.74 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
    203.65 ± 26%     -95.4%       9.44 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.54 ±142%   +1407.1%       8.13 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     32.46 ± 99%     -80.2%       6.42 ± 74%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    300.67 ± 13%     -91.3%      26.05 ± 75%  perf-sched.wait_time.max.ms.pipe_wait_readable.ipipe_prep.part.0.do_tee
    328.99 ± 16%     -86.2%      45.34 ±151%  perf-sched.wait_time.max.ms.pipe_wait_writable.opipe_prep.part.0.do_tee
    391.47 ± 23%     -86.7%      51.90 ±136%  perf-sched.wait_time.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    239.99 ± 46%     -96.1%       9.32 ± 77%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%  +49648.6%       0.58 ± 61%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_double_lock
    864.13 ± 37%     -98.0%      17.07 ± 89%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2100 ± 52%     -76.0%     504.99        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2172 ± 17%     -54.0%       1000        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     16.97           -15.7        1.26 ±  3%  perf-profile.calltrace.cycles-pp.tee
     15.24           -14.7        0.59 ±  2%  perf-profile.calltrace.cycles-pp.opipe_prep.do_tee.__x64_sys_tee.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.19           -14.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.pipe_wait_writable.opipe_prep.do_tee.__x64_sys_tee.do_syscall_64
     15.29           -14.6        0.69 ±  3%  perf-profile.calltrace.cycles-pp.do_tee.__x64_sys_tee.do_syscall_64.entry_SYSCALL_64_after_hwframe.tee
     15.30           -14.6        0.73 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_tee.do_syscall_64.entry_SYSCALL_64_after_hwframe.tee
     15.34           -14.4        0.94 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.tee
     15.34           -14.4        0.96 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.tee
     14.06           -14.0        0.10 ±200%  perf-profile.calltrace.cycles-pp.schedule.pipe_wait_writable.opipe_prep.do_tee.__x64_sys_tee
     13.67           -13.6        0.10 ±200%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_wait_writable.opipe_prep.do_tee
     40.88           -11.1       29.80        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     10.86           -10.9        0.00        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_read.vfs_read.ksys_read.do_syscall_64
     13.96           -10.7        3.26        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     41.52           -10.6       30.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     10.50           -10.5        0.00        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.pipe_read.vfs_read.ksys_read
     10.35           -10.3        0.00        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_read.vfs_read
     10.12           -10.1        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_read
      9.38            -9.4        0.00        perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      9.02            -9.0        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     52.99            -7.3       45.71        perf-profile.calltrace.cycles-pp.read
      6.05 ±  2%      -6.0        0.00        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      5.49            -5.5        0.00        perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.pipe_wait_writable.opipe_prep
      5.25            -5.2        0.00        perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.pipe_wait_writable
      5.02            -5.0        0.00        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
     20.87            -4.0       16.84        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.38            -2.3       21.12        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     25.16            -1.2       23.92        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.91            -0.2        0.73 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      0.54 ±  2%      +0.3        0.83 ±  2%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64_mg.current_time.atime_needs_update.touch_atime.pipe_read
      0.61            +0.5        1.07        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72            +0.5        1.24 ±  2%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.07            +0.5        1.62 ±  2%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.78            +0.6        1.42        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.17 ±141%      +0.7        0.91        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.75        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.17            +0.8        1.93        perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
      0.00            +0.8        0.76 ±  4%  perf-profile.calltrace.cycles-pp.stress_tee_pipe_write
      0.00            +0.8        0.77        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.08 ±223%      +0.8        0.88        perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64_mg.current_time.inode_needs_update_time.file_update_time.pipe_write
      0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
      1.14            +0.8        1.96 ±  2%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.98            +0.9        1.84 ±  2%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.16            +0.9        2.08        perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.pipe_write.vfs_write
      1.18            +1.0        2.13        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.63            +1.3        2.93        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
      2.33            +1.4        3.72        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      1.72            +1.4        3.16        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.63            +1.6        4.22        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.98            +1.6        3.57        perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
      2.86            +2.1        4.95        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      3.43            +2.5        5.92        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.99            +2.6        5.54        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      3.52            +2.6        6.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      4.25            +2.9        7.12        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      3.50            +3.0        6.47        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      3.75            +3.2        6.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      4.49            +3.8        8.33        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      9.78            +8.2       17.98        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.20           +10.2       22.45        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     13.89           +11.7       25.59        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     17.18           +14.4       31.62        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     17.86           +15.0       32.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     26.99           +22.8       49.78        perf-profile.calltrace.cycles-pp.write
     23.67           -22.6        1.11 ±  2%  perf-profile.children.cycles-pp.schedule
     23.19           -22.1        1.09 ±  2%  perf-profile.children.cycles-pp.__schedule
     16.98           -15.7        1.30 ±  3%  perf-profile.children.cycles-pp.tee
     15.24           -14.7        0.56 ±  3%  perf-profile.children.cycles-pp.pipe_wait_writable
     15.24           -14.7        0.59 ±  3%  perf-profile.children.cycles-pp.opipe_prep
     15.29           -14.6        0.70 ±  3%  perf-profile.children.cycles-pp.do_tee
     15.30           -14.6        0.73 ±  3%  perf-profile.children.cycles-pp.__x64_sys_tee
     73.87           -10.7       63.20        perf-profile.children.cycles-pp.do_syscall_64
     10.91           -10.5        0.45 ±  5%  perf-profile.children.cycles-pp.__wake_up_sync_key
     10.61           -10.1        0.52 ±  7%  perf-profile.children.cycles-pp.__wake_up_common
     75.40           -10.0       65.40        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.44            -9.9        0.51 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
     10.32            -9.8        0.51 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
     16.00            -9.0        6.96        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     53.19            -7.3       45.93        perf-profile.children.cycles-pp.read
      6.34            -6.1        0.29 ±  2%  perf-profile.children.cycles-pp.__pick_next_task
      6.16            -5.9        0.28 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      6.13 ±  2%      -5.8        0.28        perf-profile.children.cycles-pp.ttwu_do_activate
      5.56            -5.3        0.27 ±  4%  perf-profile.children.cycles-pp.try_to_block_task
      5.32            -5.1        0.26 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      5.12            -4.9        0.25 ±  3%  perf-profile.children.cycles-pp.dequeue_entities
      4.92 ±  3%      -4.7        0.25 ±  2%  perf-profile.children.cycles-pp.enqueue_task
      4.69 ±  3%      -4.5        0.23 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      4.57            -4.3        0.22 ±  5%  perf-profile.children.cycles-pp.update_curr
      4.42            -4.2        0.21        perf-profile.children.cycles-pp.update_load_avg
      4.31            -4.1        0.19 ±  2%  perf-profile.children.cycles-pp.switch_mm_irqs_off
     21.23            -3.8       17.41        perf-profile.children.cycles-pp.pipe_read
      3.28            -3.1        0.15 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      2.87 ±  3%      -2.7        0.12 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
     23.53            -2.2       21.36        perf-profile.children.cycles-pp.vfs_read
      2.17            -2.1        0.09 ±  4%  perf-profile.children.cycles-pp.pick_task_fair
      1.90            -1.8        0.09 ±  7%  perf-profile.children.cycles-pp.set_next_entity
      1.70            -1.6        0.08 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      1.70            -1.6        0.09 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      1.59            -1.5        0.07 ±  7%  perf-profile.children.cycles-pp.__switch_to_asm
      1.65            -1.5        0.14        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      1.54            -1.5        0.07        perf-profile.children.cycles-pp.__switch_to
      1.43            -1.4        0.07        perf-profile.children.cycles-pp.put_prev_entity
      1.39            -1.3        0.06        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.36            -1.3        0.07        perf-profile.children.cycles-pp.wakeup_preempt
      1.28            -1.2        0.07        perf-profile.children.cycles-pp.pick_eevdf
     25.30            -1.1       24.16        perf-profile.children.cycles-pp.ksys_read
      1.17 ±  9%      -1.1        0.06 ±  8%  perf-profile.children.cycles-pp.select_task_rq
      0.98 ± 11%      -0.9        0.04 ± 50%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.99            -0.9        0.06 ±  6%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.90            -0.8        0.08 ±  6%  perf-profile.children.cycles-pp.rseq_ip_fixup
      1.05 ± 16%      -0.7        0.34 ±113%  perf-profile.children.cycles-pp.reader__read_event
      1.05 ± 16%      -0.7        0.34 ±112%  perf-profile.children.cycles-pp.perf_session__process_events
      1.05 ± 16%      -0.7        0.34 ±112%  perf-profile.children.cycles-pp.record__finish_output
      0.71            -0.6        0.06        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.61            -0.6        0.04 ± 50%  perf-profile.children.cycles-pp.os_xsave
      0.62 ±  5%      -0.5        0.08 ±  5%  perf-profile.children.cycles-pp.reweight_entity
      0.59            -0.5        0.05 ±  7%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.22 ±  2%      -0.1        0.11        perf-profile.children.cycles-pp.switch_fpu_return
      0.19 ±  3%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.18 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.sched_tick
      0.07            +0.0        0.09 ± 15%  perf-profile.children.cycles-pp.__wake_up
      0.09 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.page_counter_cancel
      0.09 ± 10%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.07 ±  5%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.__splice_from_pipe
      0.11 ±  9%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.uncharge_batch
      0.07 ±  6%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.08 ±  5%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.12 ± 11%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
      0.12 ±  9%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__folio_put
      0.00            +0.1        0.06 ± 12%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.08            +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.splice_from_pipe
      0.18 ±  8%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.__x64_sys_read
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.09 ±  5%      +0.1        0.19 ±  7%  perf-profile.children.cycles-pp.do_splice
      0.09 ±  4%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.__x64_sys_splice
      0.19            +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.make_vfsuid
      0.19            +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.make_vfsgid
      0.16 ±  2%      +0.1        0.29        perf-profile.children.cycles-pp.__x64_sys_write
      0.22 ±  5%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.read@plt
      0.19 ±  2%      +0.2        0.34 ±  6%  perf-profile.children.cycles-pp.write@plt
      1.00            +0.2        1.16 ±  3%  perf-profile.children.cycles-pp.stress_tee_pipe_read
      0.14 ±  3%      +0.2        0.33 ±  5%  perf-profile.children.cycles-pp.splice
      0.36            +0.2        0.60        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.38            +0.3        0.68        perf-profile.children.cycles-pp.kill_fasync
      1.48            +0.3        1.78        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.40            +0.3        0.73        perf-profile.children.cycles-pp.rcu_all_qs
      0.56            +0.4        0.96        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.56            +0.4        1.00        perf-profile.children.cycles-pp.stress_tee_pipe_write
      0.58            +0.5        1.04        perf-profile.children.cycles-pp.security_file_permission
      1.13            +0.7        1.88        perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.96            +0.8        1.72        perf-profile.children.cycles-pp.x64_sys_call
      0.92            +0.8        1.69        perf-profile.children.cycles-pp.__cond_resched
      1.30            +1.0        2.33        perf-profile.children.cycles-pp.rw_verify_area
      1.59            +1.3        2.87        perf-profile.children.cycles-pp.mutex_unlock
      1.72            +1.4        3.11        perf-profile.children.cycles-pp.inode_needs_update_time
      2.14            +1.5        3.62        perf-profile.children.cycles-pp.fdget_pos
      2.51            +1.5        4.04        perf-profile.children.cycles-pp.atime_needs_update
      2.72            +1.7        4.37        perf-profile.children.cycles-pp.touch_atime
      2.08            +1.7        3.75        perf-profile.children.cycles-pp.file_update_time
      2.52            +1.8        4.35        perf-profile.children.cycles-pp.current_time
      2.52            +2.0        4.49        perf-profile.children.cycles-pp.mutex_lock
      2.92            +2.1        5.03        perf-profile.children.cycles-pp._copy_to_iter
      3.53            +2.6        6.09        perf-profile.children.cycles-pp.copy_page_to_iter
      3.04            +2.6        5.64        perf-profile.children.cycles-pp._copy_from_iter
      3.27            +2.7        5.96        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.65            +3.1        6.75        perf-profile.children.cycles-pp.copy_page_from_iter
      4.17            +3.3        7.49        perf-profile.children.cycles-pp.entry_SYSCALL_64
      8.86            +6.9       15.76        perf-profile.children.cycles-pp.clear_bhb_loop
     10.12            +8.5       18.62        perf-profile.children.cycles-pp.pipe_write
     12.38           +10.4       22.74        perf-profile.children.cycles-pp.vfs_write
     14.06           +11.8       25.89        perf-profile.children.cycles-pp.ksys_write
     27.17           +22.9       50.09        perf-profile.children.cycles-pp.write
      4.22            -4.0        0.19        perf-profile.self.cycles-pp.switch_mm_irqs_off
      2.34            -2.2        0.11 ±  4%  perf-profile.self.cycles-pp.__schedule
      1.73 ±  4%      -1.6        0.08 ± 12%  perf-profile.self.cycles-pp.update_curr
      1.57            -1.5        0.07 ±  7%  perf-profile.self.cycles-pp.__switch_to_asm
      1.56            -1.5        0.08 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      1.46            -1.4        0.07 ±  7%  perf-profile.self.cycles-pp.__switch_to
      1.43            -1.4        0.07        perf-profile.self.cycles-pp.update_load_avg
      1.30            -1.2        0.06 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.82 ±  2%      -0.8        0.05 ±  7%  perf-profile.self.cycles-pp.prepare_task_switch
      0.81            -0.8        0.04 ± 50%  perf-profile.self.cycles-pp.pick_eevdf
      0.67            -0.6        0.05 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.60            -0.6        0.04 ± 50%  perf-profile.self.cycles-pp.os_xsave
      0.08 ± 12%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.read@plt
      0.08 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.page_counter_cancel
      0.13 ± 11%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__x64_sys_read
      0.05            +0.1        0.10 ± 17%  perf-profile.self.cycles-pp.write@plt
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.tee
      0.11 ±  3%      +0.1        0.19        perf-profile.self.cycles-pp.__x64_sys_write
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.14 ±  2%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.make_vfsgid
      0.14            +0.1        0.24        perf-profile.self.cycles-pp.make_vfsuid
      0.20 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.touch_atime
      0.20 ±  2%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.kill_fasync
      0.87            +0.2        1.04 ±  3%  perf-profile.self.cycles-pp.stress_tee_pipe_read
      0.30            +0.2        0.54        perf-profile.self.cycles-pp.rcu_all_qs
      0.34            +0.2        0.59        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.35            +0.3        0.63        perf-profile.self.cycles-pp.file_update_time
      0.45            +0.3        0.78        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.50 ±  2%      +0.4        0.86 ±  2%  perf-profile.self.cycles-pp.stress_tee_pipe_write
      0.47            +0.4        0.85        perf-profile.self.cycles-pp.inode_needs_update_time
      0.48            +0.4        0.86        perf-profile.self.cycles-pp.security_file_permission
      0.62            +0.4        1.06        perf-profile.self.cycles-pp.copy_page_to_iter
      0.51            +0.4        0.96        perf-profile.self.cycles-pp.__cond_resched
      0.70            +0.5        1.18 ±  2%  perf-profile.self.cycles-pp.ksys_read
      0.96            +0.5        1.47        perf-profile.self.cycles-pp.atime_needs_update
      0.66            +0.5        1.19        perf-profile.self.cycles-pp.copy_page_from_iter
      1.18            +0.6        1.74        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.72            +0.6        1.29        perf-profile.self.cycles-pp.rw_verify_area
      0.71            +0.6        1.31        perf-profile.self.cycles-pp.ksys_write
      1.51            +0.7        2.18        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.85            +0.7        1.52        perf-profile.self.cycles-pp.x64_sys_call
      1.03            +0.7        1.70        perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      1.04            +0.8        1.82        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.87            +1.0        2.92        perf-profile.self.cycles-pp.pipe_read
      1.39            +1.1        2.47        perf-profile.self.cycles-pp.current_time
      1.64            +1.1        2.78 ±  2%  perf-profile.self.cycles-pp.vfs_read
      1.59            +1.2        2.78        perf-profile.self.cycles-pp.mutex_lock
      1.49            +1.2        2.68        perf-profile.self.cycles-pp.mutex_unlock
      1.81            +1.2        3.04        perf-profile.self.cycles-pp.read
      2.03            +1.4        3.39        perf-profile.self.cycles-pp.do_syscall_64
      2.03            +1.4        3.44 ±  2%  perf-profile.self.cycles-pp.fdget_pos
      1.64            +1.4        3.07        perf-profile.self.cycles-pp.vfs_write
      1.84            +1.6        3.43        perf-profile.self.cycles-pp.write
      3.60            +1.8        5.36        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      2.13            +1.8        3.94 ±  2%  perf-profile.self.cycles-pp.pipe_write
      2.86            +2.1        4.93        perf-profile.self.cycles-pp._copy_to_iter
      2.93            +2.5        5.44        perf-profile.self.cycles-pp._copy_from_iter
      3.16            +2.6        5.75        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      8.75            +6.8       15.58        perf-profile.self.cycles-pp.clear_bhb_loop



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/pipe/4/x86_64-rhel-9.4/process/50%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/hackbench

commit: 
  d2fc0ed52a ("Merge branch 'vfs-6.14.uncached_buffered_io'")
  aaec5a95d5 ("pipe_read: don't wake up the writer if the pipe is still full")

d2fc0ed52a284a13 aaec5a95d59615523db03dd53c2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.04 ±  2%      -0.0        0.03 ±  6%  mpstat.cpu.all.soft%
     13470 ± 44%     +47.4%      19860 ± 22%  numa-vmstat.node1.nr_slab_reclaimable
     53825 ± 44%     +47.6%      79444 ± 22%  numa-meminfo.node1.KReclaimable
     53825 ± 44%     +47.6%      79444 ± 22%  numa-meminfo.node1.SReclaimable
      1423           -14.8%       1212 ±  2%  vmstat.procs.r
   1419871 ±  3%     +22.4%    1737760 ±  2%  vmstat.system.in
     28551 ± 13%     -37.8%      17760 ±  8%  perf-c2c.DRAM.remote
    122888 ±  7%     +55.5%     191041 ±  2%  perf-c2c.HITM.local
      4310 ± 13%     -20.0%       3448 ±  9%  perf-c2c.HITM.remote
    127198 ±  7%     +52.9%     194489 ±  2%  perf-c2c.HITM.total
    903976            -7.5%     836425        hackbench.throughput
    866824            -7.6%     801128        hackbench.throughput_avg
    903976            -7.5%     836425        hackbench.throughput_best
    785145            -6.8%     731474        hackbench.throughput_worst
     69.85            +8.1%      75.53        hackbench.time.elapsed_time
     69.85            +8.1%      75.53        hackbench.time.elapsed_time.max
 1.986e+08           +22.1%  2.424e+08        hackbench.time.involuntary_context_switches
      7559            +9.7%       8296        hackbench.time.system_time
    985.62            +4.1%       1026        hackbench.time.user_time
      6.06 ±  4%     -16.2%       5.08 ±  2%  sched_debug.cfs_rq:/.h_nr_running.avg
     14.20 ± 13%     -19.0%      11.50 ±  4%  sched_debug.cfs_rq:/.h_nr_running.max
      3.32 ±  3%     -18.4%       2.71 ±  2%  sched_debug.cfs_rq:/.h_nr_running.stddev
      5996 ±  2%     +34.3%       8054 ± 23%  sched_debug.cfs_rq:/.load.avg
     24211 ±  8%   +1091.3%     288431 ± 88%  sched_debug.cfs_rq:/.load.max
      4439 ±  3%    +504.9%      26851 ± 81%  sched_debug.cfs_rq:/.load.stddev
      1.00 ± 54%     +83.3%       1.83 ± 12%  sched_debug.cfs_rq:/.load_avg.min
      6203 ±  2%     -15.4%       5246 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      1886 ±  7%     -22.5%       1461 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
    151.50 ± 28%     +55.7%     235.83 ± 11%  sched_debug.cfs_rq:/.util_avg.min
    667.32 ±  3%     -21.3%     525.24 ±  8%  sched_debug.cfs_rq:/.util_est.avg
      6.06 ±  4%     -16.1%       5.09 ±  2%  sched_debug.cpu.nr_running.avg
     14.20 ± 13%     -19.0%      11.50 ±  4%  sched_debug.cpu.nr_running.max
      3.30 ±  4%     -18.7%       2.68 ±  2%  sched_debug.cpu.nr_running.stddev
    130727 ± 33%     -46.7%      69684 ± 27%  sched_debug.cpu.nr_switches.stddev
      6.98 ± 11%      -2.4        4.61 ± 24%  perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      6.98 ± 11%      -2.4        4.61 ± 24%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.67 ± 11%      -2.1        4.61 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn
      6.67 ± 11%      -2.1        4.61 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn.perf_mmap__push
      6.67 ± 11%      -2.1        4.61 ± 24%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen
      3.02 ± 44%      -1.9        1.09 ± 47%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      6.67 ± 11%      -1.8        4.86 ± 17%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      6.67 ± 11%      -1.8        4.86 ± 17%  perf-profile.calltrace.cycles-pp.write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      6.67 ± 11%      -1.8        4.86 ± 17%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      2.72 ± 21%      -1.2        1.50 ± 57%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.17 ±122%      +2.5        3.65 ± 43%  perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.81 ± 62%      +2.8        4.59 ± 21%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.52 ± 65%      +3.1        4.63 ± 39%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.52 ± 65%      +3.1        4.63 ± 39%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.98 ± 11%      -2.4        4.61 ± 24%  perf-profile.children.cycles-pp.generic_perform_write
      6.98 ± 11%      -2.4        4.61 ± 24%  perf-profile.children.cycles-pp.shmem_file_write_iter
      3.93 ± 39%      -2.2        1.75 ± 66%  perf-profile.children.cycles-pp.mutex_unlock
      6.67 ± 11%      -1.8        4.86 ± 17%  perf-profile.children.cycles-pp.record__pushfn
      6.67 ± 11%      -1.4        5.30 ± 11%  perf-profile.children.cycles-pp.writen
      2.72 ± 21%      -1.2        1.50 ± 57%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      2.72 ± 21%      -1.2        1.50 ± 57%  perf-profile.children.cycles-pp.fault_in_readable
      1.17 ±122%      +2.5        3.65 ± 43%  perf-profile.children.cycles-pp.do_pte_missing
 6.169e+10            -6.4%  5.773e+10        perf-stat.i.branch-instructions
 2.704e+08            -3.6%  2.607e+08        perf-stat.i.branch-misses
     13.54 ± 10%      -4.4        9.18 ±  2%  perf-stat.i.cache-miss-rate%
 1.343e+09 ±  9%     +40.2%  1.883e+09 ±  3%  perf-stat.i.cache-references
  12981250 ±  2%      -2.9%   12601747        perf-stat.i.context-switches
      1.18            +7.0%       1.26        perf-stat.i.cpi
    656622 ±  3%     +43.2%     940118        perf-stat.i.cpu-migrations
 2.674e+11            -6.3%  2.506e+11        perf-stat.i.instructions
      0.85            -6.3%       0.80        perf-stat.i.ipc
     13648 ±  2%      -7.1%      12676 ±  3%  perf-stat.i.minor-faults
     13650 ±  2%      -7.1%      12677 ±  3%  perf-stat.i.page-faults
      0.44            +0.0        0.45        perf-stat.overall.branch-miss-rate%
     13.19 ± 10%      -4.3        8.94 ±  3%  perf-stat.overall.cache-miss-rate%
      1.18            +7.3%       1.26        perf-stat.overall.cpi
      0.85            -6.8%       0.79        perf-stat.overall.ipc
 6.089e+10            -6.3%  5.703e+10        perf-stat.ps.branch-instructions
 2.666e+08            -3.5%  2.572e+08        perf-stat.ps.branch-misses
 1.324e+09 ±  9%     +40.3%  1.858e+09 ±  3%  perf-stat.ps.cache-references
  12791040 ±  2%      -2.8%   12432936        perf-stat.ps.context-switches
    646715 ±  3%     +43.3%     926916        perf-stat.ps.cpu-migrations
  2.64e+11            -6.2%  2.476e+11        perf-stat.ps.instructions
     13461 ±  2%      -7.7%      12426 ±  3%  perf-stat.ps.minor-faults
     13463 ±  2%      -7.7%      12427 ±  3%  perf-stat.ps.page-faults
      3.22 ± 92%    +235.4%      10.78 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
      0.24 ±100%     -84.4%       0.04 ±102%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.08 ± 90%     -88.4%       0.01 ±112%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
     10.19 ±196%     -99.8%       0.02 ±134%  perf-sched.sch_delay.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      2.47 ±196%     -99.8%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.10 ± 45%     -83.6%       0.02 ±153%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.09 ± 86%     -92.9%       0.01 ±172%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      7.03 ± 19%    +243.1%      24.13 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      5.62 ±195%     -99.6%       0.02 ± 92%  perf-sched.sch_delay.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     15.78 ± 28%    +338.0%      69.12 ± 19%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.99 ± 19%     +59.4%       1.57 ± 12%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.84 ± 20%    +945.2%      61.00 ± 11%  perf-sched.sch_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     15.78 ± 21%    +208.2%      48.63 ± 11%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     12.67 ± 71%    +452.9%      70.03 ± 81%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.22 ± 17%    +252.3%       4.30 ± 11%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.12 ± 83%    +577.2%       0.83 ± 61%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.20 ±104%     -94.9%       0.01 ±115%  perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
     20.36 ±196%     -99.9%       0.02 ±129%  perf-sched.sch_delay.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      2.48 ±195%     -99.7%       0.01 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.28 ± 88%     -89.8%       0.03 ±148%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.14 ±105%     -95.5%       0.01 ±172%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      1095 ± 14%    +118.2%       2389 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
     16.66 ±198%     -99.7%       0.05 ±104%  perf-sched.sch_delay.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
    797.45 ± 24%    +149.6%       1990 ± 17%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1768 ± 22%     +94.8%       3445 ± 11%  perf-sched.sch_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    746.96 ± 15%    +265.4%       2729 ± 21%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      0.01 ± 15%     -33.9%       0.01 ± 45%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1716 ± 29%    +121.7%       3804 ± 17%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.54 ±107%    +338.8%       2.37 ± 51%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.41 ± 19%     +78.0%       2.51 ± 11%  perf-sched.total_sch_delay.average.ms
      2305 ± 20%     +82.3%       4203 ± 11%  perf-sched.total_sch_delay.max.ms
      4.38 ± 18%     +68.2%       7.37 ± 11%  perf-sched.total_wait_and_delay.average.ms
   4583511 ± 23%     -32.5%    3091848 ± 17%  perf-sched.total_wait_and_delay.count.ms
      5607 ± 10%     +48.2%       8309 ±  8%  perf-sched.total_wait_and_delay.max.ms
      2.97 ± 18%     +63.5%       4.86 ± 11%  perf-sched.total_wait_time.average.ms
      5092 ±  4%     +13.9%       5800 ±  6%  perf-sched.total_wait_time.max.ms
     11.10 ± 59%    +210.8%      34.49 ± 24%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
     21.29 ± 17%    +235.3%      71.40 ± 12%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
    110.43 ± 47%    +250.5%     387.09 ± 45%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.98 ± 24%    +319.4%     205.43 ± 16%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      2.87 ± 19%     +56.2%       4.48 ± 11%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     19.17 ± 20%    +835.0%     179.22 ± 10%  perf-sched.wait_and_delay.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     48.33 ± 24%    +209.7%     149.70 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     38.33 ± 45%    +401.4%     192.16 ± 68%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.58 ± 17%    +253.9%      12.65 ± 11%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     56.40 ± 39%     -72.8%      15.33 ± 46%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    785.60 ± 53%     -49.5%     396.83 ± 49%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    356336 ± 23%     -93.6%      22658 ± 16%  perf-sched.wait_and_delay.count.pipe_write.vfs_write.ksys_write.do_syscall_64
    203.40 ± 27%     -71.1%      58.83 ± 63%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    779.32 ± 74%    +132.5%       1812 ± 26%  perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
      2209 ± 14%    +116.3%       4779 ± 15%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      1679 ± 22%    +139.3%       4019 ± 18%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      3543 ± 22%     +98.8%       7042 ± 10%  perf-sched.wait_and_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      1595 ± 26%    +243.1%       5471 ± 21%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      5048 ±  4%     +12.6%       5685 ±  6%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4052 ± 22%     +88.2%       7626 ± 17%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.88 ± 48%    +200.8%      23.70 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
      0.24 ±100%     -84.4%       0.04 ±102%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      6.22 ± 65%    +237.5%      21.00 ± 59%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.pipe_write
      0.08 ± 90%     -88.4%       0.01 ±112%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
     18.06 ± 14%     +43.8%      25.98 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     10.19 ±196%     -99.8%       0.02 ±134%  perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      2.47 ±196%     -99.8%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.10 ± 45%     -83.5%       0.02 ±153%  perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.09 ± 86%     -92.9%       0.01 ±172%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     14.26 ± 16%    +231.5%      47.27 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      6.86 ±196%     -99.6%       0.02 ± 92%  perf-sched.wait_time.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      2.44 ± 44%    +137.1%       5.78 ± 46%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.20 ± 23%    +310.5%     136.31 ± 16%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1.88 ± 19%     +54.5%       2.91 ± 11%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     13.33 ± 21%    +786.7%     118.22 ± 10%  perf-sched.wait_time.avg.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     32.55 ± 25%    +210.5%     101.07 ± 12%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     25.66 ± 34%    +375.9%     122.14 ± 60%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.35 ± 18%    +254.7%       8.35 ± 11%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ± 84%    +731.0%       0.70 ± 43%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    502.86 ± 46%    +115.0%       1081 ± 38%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pipe_write.vfs_write
    188.34 ±175%     -97.8%       4.23 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.pipe_read
      0.20 ±104%     -94.9%       0.01 ±115%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
     20.36 ±196%     -99.9%       0.02 ±129%  perf-sched.wait_time.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      2.48 ±195%     -99.7%       0.01 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.28 ± 88%     -89.8%       0.03 ±148%  perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.14 ±105%     -95.5%       0.01 ±172%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      1126 ± 15%    +132.8%       2622 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
     20.38 ±198%     -99.8%       0.05 ±104%  perf-sched.wait_time.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
    951.43 ± 18%    +142.5%       2307 ± 15%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1820 ± 24%    +107.0%       3767 ±  7%  perf-sched.wait_time.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
    994.33 ± 39%    +179.3%       2776 ± 19%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
    921.59 ± 39%     +70.0%       1566 ± 29%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5048 ±  4%     +12.6%       5685 ±  6%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2400 ± 36%     +64.8%       3954 ± 12%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.42 ±103%    +470.3%       2.37 ± 50%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


