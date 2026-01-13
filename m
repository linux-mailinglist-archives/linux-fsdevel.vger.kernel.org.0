Return-Path: <linux-fsdevel+bounces-73369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A9D166A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 04:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADAB530092BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 03:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288C2306487;
	Tue, 13 Jan 2026 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfY/E9u4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1BA30171A;
	Tue, 13 Jan 2026 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273940; cv=fail; b=TV79edMH84tLl0kPAQlz0U6HGCaiKJB82ORxXuPDzozwQplE1L1pANr5qZMduov2m7QdacfPZyLA15SvFlhxuV4OX4qFEirGIZCQIpoUvpKJfY7osoUQqZcfV0KNh1JWx7bsbbk96JuWlCPu+GbQKaRjLJTxNhOwjvxCArh0Cbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273940; c=relaxed/simple;
	bh=1V7JMJYaKLJt9O6LMzRu11ARZh4aPM0girog/8dZsNA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=T3G1WC+mhwiFe9LbnbFevtX6WaoZA10EB3Dv7wy1Jsz+OENqMLJCP0re67AGDLDfYggrJhAMxwcxH2C7lokojM/VuRQbhyZ0qW4MqxNSaZoqgbWoQTH7yGYjKDmQi1AIU2GninTjXu2h8zGOZccdXIkmMh8dxGuQ7n81j8byrCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfY/E9u4; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768273939; x=1799809939;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=1V7JMJYaKLJt9O6LMzRu11ARZh4aPM0girog/8dZsNA=;
  b=MfY/E9u43nut3FN5Fb983pWpTiOphSMzfkRTKtRKpsBsWWfaewAaiw4N
   S1x4djUvr/zu+EDiYv7QyKWgXcxEY/M9evkYBgdqrN3YCdAfNF0k964aa
   D/B9y9KQ5yADNg/REjUlWQLOjPcT2AhQvJSBP8AU/BfBTMBmQw8T6KPyf
   NMg3wUAx2wHsjNbF8NC/l7Sj+NbTH2F+z7nYHv5vcYLdH2AxCqNaVkH4a
   /PqLNsvG6jlC1zgvmNNgqQqRZTyiSmyfONAB8RcpJymQQQbEQUCvOxTIh
   pacS5/ztCiGOfG+KfxAL7ASRCAfJqDRvreawKFT88JjcBpO8X9YkWsTM1
   Q==;
X-CSE-ConnectionGUID: pZA2w0RuQHubAbdcb0sw1Q==
X-CSE-MsgGUID: EON3lI18TFesbP0l+ckwBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="57111096"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="57111096"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 19:12:18 -0800
X-CSE-ConnectionGUID: KCBluYtwR0uLjXFS8qkB6Q==
X-CSE-MsgGUID: RjfgblL0Q4yZ+NxT3i+0gg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 19:12:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 19:12:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 19:12:15 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 19:12:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxxk026+kE5cJFQC3gMw8Xd3EppOSTWARBlBauFsk7F0BN6M+EWu0+ceQ15cXOy+J0G51Z/4JsjwqfK+4erMFujAYuF3HCQ4VyooCaTt74Stjd+yal6+YPJYJvZh29h7Z7rGC9mfr7yMhW+Hidv/Daldz9QM2l57ZtiicP7KLtCwT0peS+USk9BNAzSHvVdKkEbCvaEoS5wuqmNhtrhvwHn7aPGPsY2r96PoFO3q4MrJjRSBo0INpKgAw1p+ibx9LJnS0POztOEe/LzV+Y8ttMdAG+YWdwzae5KNVGztWflpDDxp98vpFC6YyiyUxVnX3eYUBcn5qd8TAhFzA5F8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4E81DE0ppIASGf99xEDO8isvqY4jTjOxlPFgS+bqLXQ=;
 b=yaeSrMsBRUu2GOzdT58U2SsjidQ9nJsVkoZjHXLkeNLaVzrEQ72EeztoWMd9Xn+QltJh39Ci2qu+Goxyt3W3MNIldG/eRYDJOxURQgIGaKLmpD7zBrUdq5FVroGLzmlLqCPlnDxHi83oXHalFfGhrOD//qvFp1cBe1gcLM24bEZyzQ+uxcP4CShGyP2JIJRXJ1R0MzoliMozh+gl2/R6RiM054oqJjmT6WnrpUkRQtdwjl5WuI3XNBs0df8Av0bUIFJ1457GsL3HXVwMwLHSiQAPaZL0kHGvh3cMaxhLOqwn0bd+Tn0k5osJ+w93oVe74wBt2va9httZTwxdInUWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4710.namprd11.prod.outlook.com (2603:10b6:208:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 03:12:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 03:12:12 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 12 Jan 2026 19:12:10 -0800
To: Gregory Price <gourry@gourry.net>, <dan.j.williams@intel.com>
CC: Balbir Singh <balbirs@nvidia.com>, Yury Norov <ynorov@nvidia.com>,
	<linux-mm@kvack.org>, <cgroups@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <kernel-team@meta.com>,
	<longman@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>, <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <dakr@kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<surenb@google.com>, <mhocko@suse.com>, <jackmanb@google.com>,
	<ziy@nvidia.com>, <david@kernel.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <rppt@kernel.org>, <axelrasmussen@google.com>,
	<yuanchu@google.com>, <weixugc@google.com>, <yury.norov@gmail.com>,
	<linux@rasmusvillemoes.dk>, <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<chrisl@kernel.org>, <kasong@tencent.com>, <shikemeng@huaweicloud.com>,
	<nphamcs@gmail.com>, <bhe@redhat.com>, <baohua@kernel.org>,
	<yosry.ahmed@linux.dev>, <chengming.zhou@linux.dev>,
	<roman.gushchin@linux.dev>, <muchun.song@linux.dev>, <osalvador@suse.de>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<cl@gentwo.org>, <harry.yoo@oracle.com>, <zhengqi.arch@bytedance.com>
Message-ID: <6965b80a887d5_875d100b5@dwillia2-mobl4.notmuch>
In-Reply-To: <aWWuU8xphCP_g6KI@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
 <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
 <aWUs8Fx2CG07F81e@yury>
 <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
 <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
 <696571507b075_20718100d4@dwillia2-mobl4.notmuch>
 <966ce77a-c055-4ab8-9c40-d02de7b67895@nvidia.com>
 <aWWGZVsY84D7YNu1@gourry-fedora-PF4VCD3F>
 <69659d418650a_207181009a@dwillia2-mobl4.notmuch>
 <aWWuU8xphCP_g6KI@gourry-fedora-PF4VCD3F>
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ceaad9b-ee8a-4ab2-84ae-08de52518bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjdwRXRJSDNhL0RFbzR6aTMxN2ZKbFkwd3NyNUhYVmdyWU5vWXhRelc5d1JU?=
 =?utf-8?B?WVdORlgwNXd3QTFZcUlsRlBwZGRqTjZzTFpqQi9LU09NSVp0aDJ2b29JTjVN?=
 =?utf-8?B?dDlkMFJZeFF5RkxLdVFIclZPd0JqbzVUQ28zS0J3Mit5aTZDNWxMZmVjQjBO?=
 =?utf-8?B?NHFhMWhuSkxSQXBVQmJaM1prSjFDQ0J6dzNVZHNqenhudkQvT2ZZZXhabVFx?=
 =?utf-8?B?SGEyMWFnZ2szK2x4UzhibSthcE9qSzNyb1dwREtoeDI2UFJKbHEwbDRwc2po?=
 =?utf-8?B?RTVvOXoxT2FwN3dJNTY5L0Z4bUUzQ0VoOXpVUXRja2xGanZuQUtEWWovRXhr?=
 =?utf-8?B?RGV3eThsTHQycmtPb2h2TEdkMFc5TmhpOWZwbFdpZVZpdi85KzY0cFRxOTZt?=
 =?utf-8?B?QytqSVlJdTNuWXhYTCtmc01wTXZvT1Y5ZjZVcjJPK2hSOWU5d2dIQUNBWGN5?=
 =?utf-8?B?T1ROYVh2MERqYS9TbnlkMStkTTE1Y0JBSzJRRzhhM1dvdmJGY2V6MzNUZVM2?=
 =?utf-8?B?UzRDelRuckxwZFRGY0dzdjB6am4xWjBObG8yazlaYkJWQ25pbFd1c2R1ZlRs?=
 =?utf-8?B?UE5xL25kemxvenJ4UVFhbnV6YWhKaDQ3cjkvejkvM1c0V2V3SUpKY0dIQWo2?=
 =?utf-8?B?S0wwM2FlUlBkQlE4bTI2MVJjcGVpRHgwY1pyQUpyNGxhSlhGUDBXcjROdDRl?=
 =?utf-8?B?cVFTcjJ5b1dHelJTbGFEbXdNRGtXV1dnUW5kRlJFZys2d1NvTExqR0RGL05R?=
 =?utf-8?B?eHJienpONjcra0hzdlY1U2Y1dXN0T2diQVNFaVFMcnZnWUx6YXZXTHlON05J?=
 =?utf-8?B?UTRaZmovNGZmazhtNTdTNjhCckhZL0p4UURvbmFhMlpVQkI4NjJocHYyUEdP?=
 =?utf-8?B?YVZuZzJJRzJ0ei9NekhQamh0b1ZSZHNGRllsSnR5M0JLSjQ2ZXlZZElQM0pB?=
 =?utf-8?B?OHN3NmVlMWFVNzhMcWJEekJGZnV6WVUyM3lDS21OQnJTd0Nmc2w0ZDZPdnF6?=
 =?utf-8?B?OFNOd2hPTnp5c1VmZGV6UjhNcEdySlAwazByV1BsSWlQbWJkeXVLTUV2bFVY?=
 =?utf-8?B?VkxqbVZBY2xDS3N5RUh4M2h2WWRaNXJSdmtGUFFCM0oxeEdzWU5VK0lLSDdK?=
 =?utf-8?B?czBFajE5SmhvQjF1SkZOcjlYYlVxRHdWeFA0Q0Q5UDNxamdpN2EwbTl4dTNF?=
 =?utf-8?B?T0V6UE42amxsYlRMejZHUDV1VWhrMDRkSkFETXU0TU5NQ2hSTy96ZXduMlN3?=
 =?utf-8?B?Tk9YeEVPMXNsWjRkQmh0UlhQYmszRUJmNjVST0lmOFZCRjlTNFVJd0dTNFJi?=
 =?utf-8?B?VW05clN4VmxaVTQ2T0hCaGQxSm1zVzMvWS9LL2NadVBCOU1UMG9McWtvQU5o?=
 =?utf-8?B?eHl3c1YzeXUybGZjTXBqRTByUHpqTmtDdGJHNlJiSFQva3lKU0pjNmRNK0dW?=
 =?utf-8?B?ZjFEMFlUbW9TMnRIN1FMMUExK2h0cUZzSU41ZmM2NVhiNUFJQkI0OWszVW5N?=
 =?utf-8?B?K0E5OURmaEpLUXhWK01hS05DTVNJWitEWFA5d0VGT2JqZ0xSL2tUMVVHMDZY?=
 =?utf-8?B?WWVXV1N2dXQ4VDdlMjdNQUpwbi96UXBXTTVJNHE1ZVRTTXc5ZTk0SHYyYkJ4?=
 =?utf-8?B?RVZMOTdlbUFJM0RtZzcvdnl0NktJSVJkalNqQjVZbjRCRldvM1B1YndxZHFL?=
 =?utf-8?B?dGl3anlJTlpJbFpmQUVvaVFRMHlVdDNnczRRMHlTNWRZQ1p3V3F4WVZuRWVu?=
 =?utf-8?B?OFozQTZYdlhiSGJiSWFBR0hXamV4Zm1NbFRGU1E1VHpXeGVDUFlheEJYS2l5?=
 =?utf-8?B?dGNQa1JpcG02MnNtMVBWZzFjeTJHclk1TTJYNmwxV3Z1UFl0d2J6cmUvUFdS?=
 =?utf-8?B?TkJSUHF0amdWUHdWRVBTckR1TFpRREhwN2dFRjhjYkdtWlhxUldMWlNaU0xm?=
 =?utf-8?Q?Mxs2Ue0cjXwfqh+HSWVE9YWb3N5MaD5C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFPVmNPcTlzSi9nRTRpT0NjVzQ4cnR0cWcyQkJ0V3pUNGs1RjFZaVlvZW1X?=
 =?utf-8?B?UVUwT0VXME0xbmRRVE02Q25xRUJ4YnJhTVB4T2YrN2oxOXQya24zY0ZoY044?=
 =?utf-8?B?MndjTEtzZm5ma3oyLzNmR09hbGZRWVJKcHZpNUY4Y3hkOUorUXlSL0ZvOWth?=
 =?utf-8?B?WUpYL0I4dVBZTXYzMmw2UmFSZGxhS3lrb1NEZ3BKMmJCaVJsR05iRktCeXhN?=
 =?utf-8?B?a1NJWU1xWnZMNmNpT2tTLy9GRUswWUZvS0xvZU1xblQ0anNPNnVFLzdiM3Jp?=
 =?utf-8?B?YXpMamhvR2pEdXdJZFpwREdHekhEWmZNSzJac1NQTWhXM1hvMkhiUHdYY1gr?=
 =?utf-8?B?WmZHZllwVVk4bUFVQ25JbDUzRElESDNaSFoxeGNxTFlNTTZXZGZrdHV4cU85?=
 =?utf-8?B?T1pvcUNxS1VmcG1PV2J4bC9leWZMVEZxekR0K2kwUFBuOTUvdVFVNVRjSzhG?=
 =?utf-8?B?TjBNbzhuejExVnYvZ2tNZ0VXdXBKbGtrVFdLV0QyOFgvV3F2V3pUc3NGOG1Z?=
 =?utf-8?B?WkdUQ2V5TCtrUHFCM2pJaW5Nb1gwZXpBdkRUdEtnTWljaEZHd2wrVGE0NktH?=
 =?utf-8?B?aWFnR0VvNFVpV3NkaU0xcERjdUMxdnJwakUxK3Z3c1pXd1pJK0ptWHN1aDdH?=
 =?utf-8?B?WDBERFJwOUoyc21FeC8xRURXZTRaQ0NYQnlZd1dIdkpNSWUwMFZndHFYT3JQ?=
 =?utf-8?B?SFljTXBaTlRjeE5TMFBlRW1pWit1ckRrdzZySWxrK09WZGZXdUl3L0k3NTVT?=
 =?utf-8?B?N2lIZFJRbjNha2lFSXRnZ3ZOVGl4aDNsdU5vdTJVei9LOUtXNEM2c0JvNm53?=
 =?utf-8?B?WVdqU2NjVEU3enBEbkxLTGI3MS80WExYSVpGdWFudVM1TUt3QXZ1eDFTZ25u?=
 =?utf-8?B?b3pJTEpkcklUenFUZnNCY3RudVNocDBhM2R1KzF1c0grTEZxS2tKM0laNThG?=
 =?utf-8?B?WUpIRlhiQm43Ym4vejdTZ3RhakloM21PWk0wTGQ3d1lYK0o0NE1ZWlVyckxP?=
 =?utf-8?B?N2tZNjBtb3kyK1NZcUJCYVpUdDdoT0Q2bzRPSVRuVUhhemtJZjVNRkNhK1dq?=
 =?utf-8?B?VjJaY3JLKzRSaGNVU2dqb29FWkdxcTl0NURXV1JpSXFXcDdkdUwyYWhwR3R0?=
 =?utf-8?B?dWlEZ3hBS1BZUTBQdm51Vk1pZTdzY0tGamZQVTM0ZXk5Q0VZekM5cXVtM1RD?=
 =?utf-8?B?cmMwV2VJQkFKN3pFckFldGNuS0hzbU1XMTFKRDJCM0RzeVd3c0hCY09mMWYy?=
 =?utf-8?B?aXEzendVTUM0UU8xbHU1L2E2Y0ZxWFJtNDRjaFIrMUF4WVh4MWZVcDVKM0Fq?=
 =?utf-8?B?RnZrdDZJajZoM3FiYUxqQUp1V1UyZEk1YjA0SjJ4dE1GNFJhVHZ4eDk3WGI3?=
 =?utf-8?B?dzJVUG1sZHhFWlJ3OHF3WmJnQzhnYUtNMUVNVEdrdWZudkR5VXJielJpalNa?=
 =?utf-8?B?TlhXYUw5eVFqT1dRd1pSQUZYN0pTMDNZVms4dFpOVXlEWmF6ZTRBM0VEdmwz?=
 =?utf-8?B?TmRYQ3FyY2E0a0JvbiszZ3BpckpjbHFGT0gzNzQwRXRSdUZqcVNLS2c4UFBk?=
 =?utf-8?B?ZmJNK1VzaGVielRDRHYvak80YjhQZ0wyS1QzSmowWVBKZUxyc3hkMjNFeGZn?=
 =?utf-8?B?Skc4VGVpY0JzZTFsbDAzcnRIalZLU3VBNHF6WGJoRXpOR2IyM2ZGWVZKRDZa?=
 =?utf-8?B?SzBZc3JhTWNZRGxjRXE2dldrd1MrVnJSc1RQK3J2bDc1SXFmQWlFNEo2ZXdi?=
 =?utf-8?B?M3FMTjNYTHZpRCsxMUJuZHZHaEVPNGl5OUZEbWZ5UFp3SWRqR2s0M2d6Y2Vs?=
 =?utf-8?B?UWRyc09uQ2tydTYvOXVPcExWRjgzVTdkZHdFQlhNVCt1U2VhNUt4QWxGYW4v?=
 =?utf-8?B?VTA3MkI2YzZVelUvTWZHbnQ3aEsrcjdTOFo2TFdjcHR5Y2pLODF6L1dzVjdy?=
 =?utf-8?B?QVUzc2orQ2xQRDFnMiswUFczd28vcEo4UzhVb2JrM21ZOUlaVlFhT1MwMDBD?=
 =?utf-8?B?b1pQdzVPNWJBaDZFdi9nTDFFckRRVE5VVkpzQ1F1RnVkNTR6cnlVd1hkeVRI?=
 =?utf-8?B?UjljeExoUU16MnJYL0owaHowbHBKTTZVZ1dRbmFqZnFZcjM1eVZkOEFOc2xX?=
 =?utf-8?B?M1g0eWVsL1J0R1pYSjUrdTJjejlhdndXN3RySnNvTFpGcFo4bmhEdExuV09r?=
 =?utf-8?B?Y1FyZDJJQTJ4aUtKVjhGMU5YeVp6elZ0c0pRSHdWb2xRWXpMK0dtUEdaSXFV?=
 =?utf-8?B?SEZQY1lhUzE1NUZQVkxwWWhBdy8vV3ZCUDNaOVh2NzdwaUw1SUVKRk1TTmk4?=
 =?utf-8?B?TmR2OGJ6OFlyMU1mZ3g1WHl6RFFpS2Q3b2xsOFN1czJBQlZGd1JpYVQ4cUIr?=
 =?utf-8?Q?6ag2gjd+sg/nTB/U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ceaad9b-ee8a-4ab2-84ae-08de52518bd0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:12:12.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11diACPGJxqtI/GSmLYLqvjb4heOey2cgF1PYpnDmyYtPJ5247z0WaMTPsk0zDkHPlCOP1hPB5ix81QqcsSqHu7TVGn+VxnM7btilTLwtbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Mon, Jan 12, 2026 at 05:17:53PM -0800, dan.j.williams@intel.com wrote:
> > 
> > I think what Balbir is saying is that the _PUBLIC is implied and can be
> > omitted. It is true that N_MEMORY[_PUBLIC] already indicates multi-zone
> > support. So N_MEMORY_PRIVATE makes sense to me as something that it is
> > distinct from N_{HIGH,NORMAL}_MEMORY which are subsets of N_MEMORY.
> > Distinct to prompt "go read the documentation to figure out why this
> > thing looks not like the others".
> 
> Ah, ack.  Will update for v4 once i give some thought to the compression
> stuff and the cgroups notes.
> 
> I would love if the ZONE_DEVICE folks could also chime in on whether the
> callback structures for pgmap and hmm might be re-usable here, but might
> take a few more versions to get the attention of everyone.

page->pgmap clobbers page->lru, i.e. they share the same union, so you
could not directly use the current ZONE_DEVICE scheme. That is because
current ZONE_DEVICE scheme needs to support ZONE_DEVICE mixed with
ZONE_NORMAL + ZONE_MOVABLE in the same node.

However, with N_MEMORY_PRIVATE effectively enabling a "node per device"
construct, you could move 'struct dev_pagemap' to node scope. I.e.
rather than annotate each page with which device it belongs teach
pgmap->ops callers to consider that the dev_pagemap instance may come
from the node instead.

