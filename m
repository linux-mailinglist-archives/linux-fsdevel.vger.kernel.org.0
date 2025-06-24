Return-Path: <linux-fsdevel+bounces-52714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D973FAE5FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E03A717A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B732797A0;
	Tue, 24 Jun 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2s2sYPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC7253950;
	Tue, 24 Jun 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755087; cv=fail; b=bYQkfKDttD5O5xa8xt42dPYH33Fpy0IYVmPm9J+8xwzOLaIhk0zfOM/+22GaMX/zlWaqtcGtnRfulrYxErZotThwv32fWNSFE0Ppz0HlL1D16o37r/sIbsAuIkTp2A/l/5oA6gx4Pmk5pF1M7bAVcMvNURYg3Fqo0BpTEGvtlOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755087; c=relaxed/simple;
	bh=wkkMOwuwhH9C3p+g1HrV3t5onXn4ZCIZgaYX2opFrXI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZYd9xuENQEw9SVSSxHuKCXsUs+rI8TDlmK5Es/XDVzgJ++V6VqBxHZbAP68jDjaqimG7Zk39OcP0lLOJmcr84AFisCNLwvVRjUwZCe3yJdBIaaUsgeh3rpwx9S1Op67uxs8qijsgI2IC2zDZqrqeF1y0FlBi+ARAihsx5wioTHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2s2sYPg; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750755086; x=1782291086;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=wkkMOwuwhH9C3p+g1HrV3t5onXn4ZCIZgaYX2opFrXI=;
  b=V2s2sYPgd43BPCzdByvs+ZzKm0biCP6L9AQy3aFxUCJ+b3IyfCi2Ho0e
   IrB4Bo6b+AICMqf0Pvgbpl9t4/XLGlogmt5zXazygPN64tLJMGnRtwt06
   XvbVUTB3/v34Hv1FvRBuAHh3Hn7AIG9Gkk/IWqKKZD5frTJHxLXuilmZY
   6gCTlq7dakFo0p0zuVXq+FPl3x3UBel0sPh6XPCTkjSYT+PL3Kb2J/7zp
   WYC6GCWISKOeOx7D1zCXFjG/hgZP570pZHL4v1NQYLgq4RdwuC/UIOV5X
   ZboPJi9VhtOL2SdGkzqDu3rXyFe8HWPsOWBNbt7K9Odq/UFQFLV1uxxN6
   A==;
X-CSE-ConnectionGUID: ToyxjUj5TIKS2dnEar165A==
X-CSE-MsgGUID: zFQR2KcqS7KcAuUm54K1bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="63680030"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="63680030"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:51:25 -0700
X-CSE-ConnectionGUID: pIVDKXPfRS2vzPv/9Dwt/Q==
X-CSE-MsgGUID: yKZ/6sIlRWmxaZhvridHvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="155884229"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:51:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:51:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 01:51:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:51:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuTai4YTzfQzssLkdSyq6NQD5YKapoas9DOJhNPqASe/2CEH6vCcHmdsUyuRepkYAdYs3UankBpM2cJb++VPlDOELT0wpI0PpoaAgt+NZltD/hq7oOO8pkO5ojPt9pFmW6U7y6prKO+LXWJH+C64X7ABxR4Vx99ZFzco6pByYuPh9Q73dqVWQCct/p65kvjyFo+CFyVm0oz7j4/UxfBh24Dg8DjACz/21bamEm6afSTlO7mbomdadr6u6wiiwFCX6OlCFTghnv83J3aKINTjl6j0JCNT4zJMQ3AJ4vfwmZqwLuEmYAzvgmbhYMcmbz4zl6jSdk2XjFpe5SaPh+1Tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzfClqpNVFukNpQCaCH8CDZ29+NNcqGJwv5WmzLs8Xg=;
 b=jXIFdu7A3cYytSJ4S7ueG0p1md5lXeHQLY+LUdgrvx1o9GhDHhA9AboOyx4qiDAcSB0oB4faBTB7UoEUUWXzAMGnOMl7XImsAngYzQO7RjrYcMsPLPQ5Ok2JAST6AFeHiN2CpdXN1qS90PFt0uVi0CldLnIc9mNLCg6/uI4Ef1oDFurutFRpNCzZJaBgWygF55emd/bhldCj7RUUVT0dmT47BCGT4KKjxu+WiwMlFxncK0GYvLZmmbVnhKTDzgghTvahas3vFMHVRi9skrkubheeG0DL01kRm/ynygUGNWTZyYTRs4a+XlaVM1UaDM1Q7T5SRwm1NkVjjaSx1Djjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6055.namprd11.prod.outlook.com (2603:10b6:510:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 08:51:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 08:51:18 +0000
Date: Tue, 24 Jun 2025 16:51:02 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Pankaj Raghav <p.raghav@samsung.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Hildenbrand
	<david@redhat.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain
	<dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Borislav
 Petkov" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	<willy@infradead.org>, <x86@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
	<mcgrof@kernel.org>, <gost.dev@samsung.com>, <kernel@pankajraghav.com>,
	<hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 3/5] mm: add static PMD zero page
Message-ID: <202506201441.2f96266-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612105100.59144-4-p.raghav@samsung.com>
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4565976e-a8d5-4e3e-4be9-08ddb2fc4948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A+XRMYjLu5NT1KF7k7hyv+c8QEPcBvlBplYVSb6ec23o2yqmFaelPQA5CuYc?=
 =?us-ascii?Q?Jo6EcYbvodejBOJVQ2MzzwNPg7x8q9L36MRQ/p2oP7Z+JlhgdegDN5gQi6hJ?=
 =?us-ascii?Q?DVFV56qVOgE1/GpHT0bjcQivW7juQpYUPbUsyn2mc462+bHgQc+WMiitMn/R?=
 =?us-ascii?Q?8HCwQAageX8c2mMTRSs4pe+TsavVImFNjhqNyLY0p8zhKHsbr+O4ZULZFCWp?=
 =?us-ascii?Q?RCQKwgMLxtwkUk1GXl7iWXL9sCjx55Nl/UJYdcaBbsY51B3BDd4HsE4RXEnG?=
 =?us-ascii?Q?PH0HD0lXfsSnc0TpjeRsgbgqjR52het4aaH0IrAMCZ1lxUStuYlKmtFe7y9h?=
 =?us-ascii?Q?K7luH1I7bQM2U1CFMOwtW7Y20vEX2SIG7MV9Pb2ocFATXXU3iueqUzxc9ZLz?=
 =?us-ascii?Q?pDEdK9UbH/ZW/f5imqQJYz025k1aBnMmOSeY38Vo3M7FUA3w7rYoJy8Qrwcj?=
 =?us-ascii?Q?emF9i73LbjVMNvp0p6v/yyicdU40Nt+IwUqipELpTHT6eOMHcUFgJC/+pXHO?=
 =?us-ascii?Q?9O01CtCjXHhQYpdcFYTQg9iaTQpqis87zxIhzyUewLoy3+ofreOmsaVqPnsd?=
 =?us-ascii?Q?6aajyZoXkJFbrKHux/zTrVuvZBiYsDJWnnZw8YtZZKZiZj8wn/a/ozhhIYiz?=
 =?us-ascii?Q?4BVQ6gsqazmDdrr+DXzPfcMYHQbZNJLzMMvht1j51RYojIRstP4bmeHmUZnJ?=
 =?us-ascii?Q?0mrir/wF8ZRlOjSLAI8kYHc0/4ZAaZGxmbjt8j4kNekuwf3jrLvbLXAONGvo?=
 =?us-ascii?Q?IsTPvICS+t6Z2hM/hflBxOA+N86W/PfyDt05o754qMwAEx7vFZ96ReM2bYns?=
 =?us-ascii?Q?BN0bsMaaHBaDreb/8xQnIr6h7B+8D8d0OwSUA/FS8nh0qsLat+eiGq6YMyDG?=
 =?us-ascii?Q?fFCJngamwcCjNzsK0bM8Ys6rsDMBEnNMV6b12qekoFEfF3amrBoO0+tJk+6t?=
 =?us-ascii?Q?HLjNH9GQ51JUydM2fTKY18pPc/7FyoMo6N6v1Amw5Q/3wbafiOfrnIBspobX?=
 =?us-ascii?Q?OPj7UBpnW0aa7wMXBBgLla74ZhLEyp9vtkYAQvzNZma8PLHSQEDxxESTNusj?=
 =?us-ascii?Q?7lRER72y/L//qDysOx2teNERSjJj3Lu7MYFDhd3QGs9h8rFc6W+wOB/feabY?=
 =?us-ascii?Q?LWXePXIuOuN/rp23meLxpTKMIyiDv2wGwkDXcZyoRJBKBEZNxAZs2xRzgXp/?=
 =?us-ascii?Q?LXoTaFDmggrwEKCXOpDqtwabUpUQes+6IWEPKdqImicRvG4ouakTiqpRlhAI?=
 =?us-ascii?Q?27gG4rX02SAsOQ93H9uPioavcFrym+Z2/SI4JUw06IE2OVEhmR4r2Gg6PoNc?=
 =?us-ascii?Q?fwCMEYkZST3mDMICDXPvg/19tCqPUVVouq+301ilu5uysQisX4wSs+RSOZ7F?=
 =?us-ascii?Q?NxcQ7ic+SWfbF5CiXB8R9GPaFXzZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvs9k+MJuQqaTy5gMvC9hC8fDw7/S1m5vMuLNUn9r3QuD5/YOp7cIqJXNtRG?=
 =?us-ascii?Q?YSvM+KACfJE5ZgaM0XxdWZnf5L+JOEG5IVvbVAdQ6c/MUKVfiXmw2NXycLow?=
 =?us-ascii?Q?sPbJzM8H9ne+h2N6jauhFwyCTYOBW35l7wJcMbMw0L5yyjEU5UlkB8d+t+q5?=
 =?us-ascii?Q?uCwImb5d5zW0ttTM8sq1KD3UdR48DVtcjQIsBM/sOSEjhsH5r4NDmvwY3rW5?=
 =?us-ascii?Q?98lSS2F+7O7u38j/cwfQGvhCYfQNKp990tPOGidO6arYhqyhEPQNeRbKsaf/?=
 =?us-ascii?Q?EnFenPD0JHjJlZaz6i5VQN1NzqP44zhhh0kdcEUBBauZAeQaZPmeuz16CqPw?=
 =?us-ascii?Q?6urUaKH48Hfm/CdAcwTydx1/HLtx/BqFs29k79NC1cIKBMDS7KY2BfpLzp8X?=
 =?us-ascii?Q?9Cojofdl+jPBtpc3S+PRHvq6Zoyq4mJnVR46belwKeTw1YT0JDwkpZoJfH+p?=
 =?us-ascii?Q?6J8191hFTL2ucC4VTE4c9QlRFXNJYrStw5cDc5Ktp2esAVLX79jpusH33vyv?=
 =?us-ascii?Q?OF9S+vD3OZ8ZQKfXWkiYBqKjrS7yocyp3dVGa4l8/I4Yw6e15bLTJ8llJbI4?=
 =?us-ascii?Q?PUzKb+0ZssKzpg80kES/RIiq9wJ9ZK81dmTue8kbkZGRNzi8WeWLQYYaaszP?=
 =?us-ascii?Q?JgP+Z07JlY0XBU4v/KJcB92V7Z4vasxUqDzWzZGTZwFhrQC4tdo+t9d4oxls?=
 =?us-ascii?Q?gEm+UCYVbhcGwB2t7KcgMYh9zmBEii8DFMEOXx270Q+jn53MPHtQOjfAY6eQ?=
 =?us-ascii?Q?gu+Fn9DW6aOh7VoWl6sZylHRHAuh3B95s+L64Bk7cl5w/pOUsxAffzKlzPOC?=
 =?us-ascii?Q?XaOe1A25vsL+UPWcMpoAH/vUDmu4vpXXFZIZUfY0U0knxf5oZvK1k/EflV8T?=
 =?us-ascii?Q?ImP++IFyRnoXUF+CplLeaYnFNLReIxRmAXdx4emlERkbR3B4EjYU2s7mAF1m?=
 =?us-ascii?Q?ggcvKrHdPfPspfofWpbVmIseCsXo+JwqFWWB9Fjpx7chMwfOdSN8FWlCG6B0?=
 =?us-ascii?Q?RKtpJU4Y7iSOz2cEtH0+3bEGBGcLbW6gyKD3oIR2XwoWEm4GDlHO7JVxEhav?=
 =?us-ascii?Q?y2kY7idZtdn5yELDeNUL1G8vUCaVZDsclkvMSxgILnAeM3EaUh5OJfDmqYwW?=
 =?us-ascii?Q?OUuvbRRHkVAcGYRXLrHH9YeCi/P8d12KPx18TFwBlbyHObHz148epUc7d8of?=
 =?us-ascii?Q?UwpMFFnc2aVgwVj9MC9gyGiunaiKI9iL7w/OgC2Ra7DWJmIVWnwAPRDzfMYV?=
 =?us-ascii?Q?ieWUcFkXzp+nCwu+tYLE08s5hP5O12uOzy2DDgKOqP/6KsQSdjMdv3Y6Ms5Q?=
 =?us-ascii?Q?0H1rGqW+v8TeXZsb/WJrTvDttffYlX24MiXcZEl8Mtnb64QhMzYeaANJY/QQ?=
 =?us-ascii?Q?RTCUTx1jHyOf6hfsCcPOxYIAcV1/UdIYxc1MqniKiCtT9HkRHuljoR8DKJkU?=
 =?us-ascii?Q?f63WyS6M8+z92nbg+Kib5UQYqljhvi6Ml55L/iUdJVZckoO15cQJ8w30woap?=
 =?us-ascii?Q?LJWq3dJeVZ0JNTBnEkkpMhcatIS0UAVU6LF51FeoK1AzGdEnab7nvh9m4RGo?=
 =?us-ascii?Q?fwU0SrA5aQYllY4xBYvnW064nbB5M1Ancb+yPB85FmqPW0s4Eidx2lNjmf4B?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4565976e-a8d5-4e3e-4be9-08ddb2fc4948
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:51:18.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGQKkGUBMYyU7wBy6DDvlkUBBVd6wfi4hsgOkQr06hXPCf1gqvW3n6ZKE/Ij0oXlMTxv2xeaatpbos7uGR1TeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6055
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/gup.c:#try_grab_folio" on:

commit: 8e628a9d6cc5c377ae06b7821f8280cd6ff2a20f ("[PATCH 3/5] mm: add static PMD zero page")
url: https://github.com/intel-lab-lkp/linux/commits/Pankaj-Raghav/mm-move-huge_zero_page-declaration-from-huge_mm-h-to-mm-h/20250612-185248
patch link: https://lore.kernel.org/all/20250612105100.59144-4-p.raghav@samsung.com/
patch subject: [PATCH 3/5] mm: add static PMD zero page

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20241228
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: x86_64-randconfig-077-20250618
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506201441.2f96266-lkp@intel.com


[  379.105772][ T4274] ------------[ cut here ]------------
[ 379.107617][ T4274] WARNING: CPU: 0 PID: 4274 at mm/gup.c:148 try_grab_folio (mm/gup.c:148 (discriminator 12)) 
[  379.109660][ T4274] Modules linked in:
[  379.111018][ T4274] CPU: 0 UID: 65534 PID: 4274 Comm: trinity-c3 Not tainted 6.16.0-rc1-00003-g8e628a9d6cc5 #1 PREEMPT(voluntary)
[  379.113741][ T4274] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 379.116285][ T4274] RIP: 0010:try_grab_folio (mm/gup.c:148 (discriminator 12)) 
[ 379.117678][ T4274] Code: 00 48 01 1d 6f 95 3f 0b 48 c7 c7 38 95 55 8f be 08 00 00 00 e8 76 98 0f 00 48 01 1d 47 08 ac 0d e9 e4 fe ff ff e8 c5 2c cd ff <0f> 0b b8 f4 ff ff ff e9 d5 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38
All code
========
   0:	00 48 01             	add    %cl,0x1(%rax)
   3:	1d 6f 95 3f 0b       	sbb    $0xb3f956f,%eax
   8:	48 c7 c7 38 95 55 8f 	mov    $0xffffffff8f559538,%rdi
   f:	be 08 00 00 00       	mov    $0x8,%esi
  14:	e8 76 98 0f 00       	call   0xf988f
  19:	48 01 1d 47 08 ac 0d 	add    %rbx,0xdac0847(%rip)        # 0xdac0867
  20:	e9 e4 fe ff ff       	jmp    0xffffffffffffff09
  25:	e8 c5 2c cd ff       	call   0xffffffffffcd2cef
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  31:	e9 d5 fe ff ff       	jmp    0xffffffffffffff0b
  36:	44 89 f1             	mov    %r14d,%ecx
  39:	80 e1 07             	and    $0x7,%cl
  3c:	80 c1 03             	add    $0x3,%cl
  3f:	38                   	.byte 0x38

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
   7:	e9 d5 fe ff ff       	jmp    0xfffffffffffffee1
   c:	44 89 f1             	mov    %r14d,%ecx
   f:	80 e1 07             	and    $0x7,%cl
  12:	80 c1 03             	add    $0x3,%cl
  15:	38                   	.byte 0x38
[  379.122288][ T4274] RSP: 0018:ffffc90003eafc00 EFLAGS: 00010246
[  379.123803][ T4274] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[  379.125678][ T4274] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  379.127640][ T4274] RBP: 0000000000210008 R08: 0000000000000000 R09: 0000000000000000
[  379.129505][ T4274] R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
[  379.131448][ T4274] R13: ffffea0000398000 R14: ffffea0000398034 R15: ffffea0000398000
[  379.133373][ T4274] FS:  00007f8feed44740(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[  379.135522][ T4274] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  379.137151][ T4274] CR2: 000000000000006e CR3: 0000000157d77000 CR4: 00000000000406f0
[  379.139063][ T4274] Call Trace:
[  379.139969][ T4274]  <TASK>
[ 379.140739][ T4274] follow_huge_pmd (mm/gup.c:767) 
[ 379.141902][ T4274] __get_user_pages (mm/gup.c:993) 
[ 379.143221][ T4274] populate_vma_page_range (mm/gup.c:1926 (discriminator 1)) 
[ 379.144519][ T4274] __mm_populate (mm/gup.c:2029) 
[ 379.145559][ T4274] vm_mmap_pgoff (include/linux/mm.h:? mm/util.c:584) 
[ 379.146769][ T4274] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[ 379.148226][ T4274] do_syscall_64 (arch/x86/entry/syscall_64.c:?) 
[ 379.149357][ T4274] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:473 (discriminator 3)) 
[ 379.150866][ T4274] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  379.152205][ T4274] RIP: 0033:0x7f8feee48719
[ 379.153354][ T4274] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  379.157899][ T4274] RSP: 002b:00007ffc477ec658 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
[  379.159864][ T4274] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f8feee48719
[  379.161627][ T4274] RDX: 0000000000000004 RSI: 0000000000200000 RDI: 0000000000000000
[  379.163409][ T4274] RBP: 00007f8fed769058 R08: ffffffffffffffff R09: 0000000000000000
[  379.165255][ T4274] R10: 0000000004008862 R11: 0000000000000246 R12: 0000000000000009
[  379.167147][ T4274] R13: 00007f8feed446c0 R14: 00007f8fed769058 R15: 00007f8fed769000
[  379.169043][ T4274]  </TASK>
[  379.169891][ T4274] irq event stamp: 771243
[ 379.170971][ T4274] hardirqs last enabled at (771255): __console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 kernel/printk/printk.c:344 kernel/printk/printk.c:2885) 
[ 379.173320][ T4274] hardirqs last disabled at (771278): __console_unlock (kernel/printk/printk.c:342 (discriminator 9) kernel/printk/printk.c:2885 (discriminator 9)) 
[ 379.175642][ T4274] softirqs last enabled at (771272): handle_softirqs (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:426 kernel/softirq.c:607) 
[ 379.177979][ T4274] softirqs last disabled at (771263): __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:682) 
[  379.180133][ T4274] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250620/202506201441.2f96266-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


