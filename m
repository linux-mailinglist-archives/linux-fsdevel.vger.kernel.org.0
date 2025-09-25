Return-Path: <linux-fsdevel+bounces-62789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A35BA0FD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138A21C23204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD60D315D51;
	Thu, 25 Sep 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hz2ueWGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8583112D0;
	Thu, 25 Sep 2025 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824273; cv=fail; b=m1boPFAk9K27lt5ZLUmjb8PvIbqE9JVFNjMVvg4J9hvr+/8u5akir/Wsdik90lwlukEmcHGdsFBwOpVbBFSJIroWzaQuIMrX8UTvOOuz1KzJzvM5ZmkB7eBu4YIawTbz8SNi6NfO6S/Ha+ES8H5AR/nx4F6/iEHPWLDHv/loReQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824273; c=relaxed/simple;
	bh=2SYCFV+rbv/yGuOKF/wzMxFOCNM4FDrSxB2TDiY/LvA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=gPuRdhnRrwloY1Q3Atv/1sBW626SSEY6BmPTXNXIl8x1nP5zwMpOXJzGG0UBSZI+xa4RKRGldDpn4rQ6ycHoDIHuesz/aSoRR/zNuNOE1y5OMrCOCOz3p470IB4evoEE9Fqd9xWut+6Mm8R3VFD1wz8E3HoCLbtFNsLtHSGBfUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hz2ueWGF; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758824272; x=1790360272;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=2SYCFV+rbv/yGuOKF/wzMxFOCNM4FDrSxB2TDiY/LvA=;
  b=hz2ueWGF9/IskBZbwll0ek+dwhgNi9tsUaDzvHZ+Ik7D0yJF6Mn45maV
   NAyst2z7ZQlDmBQF554ozj64JL83/Tmo4z+TvF8IZqA5SRzxL7oKzNrM2
   vOEG9kSv7uL7qKywb7oACqwbxV5bGlFdn0FS6BqKED0RkkpN5jY1cICVz
   OupWPCsIVN69vFCNT94+K46OnzyEalGvUMRWuNPDblzNEbys6PsiFCVHy
   OSdmFhdzmd0zBMomkCu0xrDfHZAtrQqhyNxZjC7kz2U+U0pJ5UQdHmeaB
   gaoKafcKOAPq8DoWv3oHbvo8ghmZWNXyNQfrRSxbXgL4erGXRgHhibLd1
   g==;
X-CSE-ConnectionGUID: 7HPt9OI/Q/Gt9qztZjUHJw==
X-CSE-MsgGUID: RBJeIYPSS9m9mCrPC4Pkgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61324431"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="61324431"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 11:17:51 -0700
X-CSE-ConnectionGUID: zPdQKrbqR1izTxnjj3GEnA==
X-CSE-MsgGUID: eHXfbpSlRJ2GjxZtl9VrsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="178159134"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 11:17:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 11:17:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 11:17:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 11:17:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9TePvl+o0RJPNuGl/V6mzyaTFxlzOIVmTA9Qxyi8TsnZLCEWOlEAJnh8SGGer6z/YE6xmomvj6z0DiCneUgNrz9SKGav998RWfr3sZdanmO4h0mpkxHGSStVk051corcLTZpKI7aBDq4oiMIBv87AKC7Av6iCq//oEAvMLonFiWRv8Nz3XkKpvwJ26NvVJ9ifod24+BnI/iJxD5zYocV7Cb+y/IugDoDahMKUGUnSV7lIi9OKFl/WvO1gIihL6UYnEx5FxYiLnspXf7FJ8R41pB22BqJ2xbMfLatoDCaQmOhEqc65PrKr2sCE3vpKwFQAj0/uahROtxBvE37ingug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqv7jEHJPTFSBA748oWooGKVccw/Me1Gm2NAjlMGsbY=;
 b=rVqtOFI2jOrqF3dd4noCJDdDdoKOqQJqzxd3zW5PXC7DyH7A5cB0NDQYChOVy5sjJbeg8ATP3orJvYf7Zu2g+YOeKKewNgus/RicyCFoUWWdce5W0qJiogVjDoTXpldSTjUeA+RzfgB9cmUOKwXktXiZfc0gAqLOZC1hBa63FIx4K8S1g2IdgfMo72yEkmsB1wbWUcZCQdRoyCeUXEfwg+/+hScU7UuNhenf41vAfPkIfAYVCg0m36MCDwoPsuDNk1cUU8KvPl5PfiAy+QERura11G8OcoQHH2eUtY568LbNOzz0pnMlVF8ilFpyQN7u/zFDKl/ykEJYgufGzkSXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8093.namprd11.prod.outlook.com (2603:10b6:610:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 18:17:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 18:17:45 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 25 Sep 2025 11:17:43 -0700
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
	<dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Robert
 Richter" <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, <ardb@kernel.org>, <bp@alien8.de>
Message-ID: <68d587474b76c_10520100df@dwillia2-mobl4.notmuch>
In-Reply-To: <d3e696c4-1ffa-47f0-baee-cb1bb4296332@amd.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
 <68bf603dee8ff_75e31001d@dwillia2-mobl4.notmuch>
 <d3e696c4-1ffa-47f0-baee-cb1bb4296332@amd.com>
Subject: Re: [PATCH 1/6] dax/hmem, e820, resource: Defer Soft Reserved
 registration until hmem is ready
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed56f58-7cc2-4391-8a3a-08ddfc5fd318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU9MNmdFRjR0cW1oUGhyTU1qb3ZuUXltNGFicDBsYmV6TzdmUDJhcXZET0ds?=
 =?utf-8?B?bUFsajBSNEhCTm4xTkZQaXExQ3V3dWxJRit0NXhmOVZnQysxbmkvSWdpUFh0?=
 =?utf-8?B?b1lrYWpwd3pTZ3l6VTZFNTZDK3JDTlZkQjhaaXhSRXpWYmJWRnpWeFBUSCtt?=
 =?utf-8?B?bDdVa2lyMGFYY1Jhb21RT2dOdzBwditPNXJpTm5nbHJZMWpURTVsbDFYSjhH?=
 =?utf-8?B?U0xJbytQSHF4YTc3R1FUeEFXT1FHbmpkbkxXV0FzZGluamF4OWc1Z2NGcmE4?=
 =?utf-8?B?U29ZS2pCckNoaWF6VzJYMnpTSzJYL2dmT1FwYlMwVVd2L3o0N2RCREs3SFhR?=
 =?utf-8?B?ck9Za05PclFZQVZ0NDA1VjhYZ0hEZ3YrTXBzSE1pS3VsS3podFFjcU9hZXBr?=
 =?utf-8?B?bklsLytjWkFLZmZkM0Z4QUNZbGZPOFYxOWk1UjJ4bUcwMWxMS0Y2ejZBOXVs?=
 =?utf-8?B?VE1LUWQyUkdaeHVYQnhiUEtldk9IWWFrQkhaVWpxaHc0UENrVDNJNEZEWGdX?=
 =?utf-8?B?WmxSVlJrYjVKckMvejFYc2lqaVFTVmVwK3pEeXNjNXJBRzhGRXd4dkI3U3BT?=
 =?utf-8?B?YUx6N0NoSnpyUkFDOFJrb1RoOERRZnZ4bjFuU29EUTBOZjlTWC9rZ01rOEc3?=
 =?utf-8?B?Zkw0a2xRY2ViaWQxSTZvTllCblptS0lWZFB6ek5jSEZPMUJKQWF5MGE5TDRP?=
 =?utf-8?B?ZHI4cENVNkN0a1RyZDhJdlE2aDNYZVdkMUhPMnJCMHF4R1ZlNmxoV3VJNXFx?=
 =?utf-8?B?c080VHNBZDU0VmdKWUpTdkRlVVc2WW5tbW50WE9nS0tWNmFPV2d4Z29LUEhZ?=
 =?utf-8?B?L1Q0UWtLblVWNVhmYkh5dnRMV3prZXZqeVZJamxMVXN4ZXpIc2lIUk80ZzJH?=
 =?utf-8?B?QzM0bzMxdlF1VVJxZG9LS3EyL2pnVFRrdmpEZ2o2RUNsOGM5UVVhTkN6WktW?=
 =?utf-8?B?Q09COURXeWxsci9MMFZ5eVRpaGQwd1R1aDBBOHJpTHVqSlh1WExySmpabjd1?=
 =?utf-8?B?NjVHSzBROHVkSWhoVGlrcmx4STZrSkNPc0R6YlV2OFUwQXZGOEE1UjhHdnYr?=
 =?utf-8?B?TEdvZzVRWG4rZWc5OWp6NXlLeVREY2lweHJEMThtb2wweE1tNzB2N2dhalpa?=
 =?utf-8?B?ako3SzJOakFpOTd2cS9vUG9NNjBVUGVHNlU2WG04MDhPRGswY3U1bVlxTFh6?=
 =?utf-8?B?WlBjbVNocXRBRXdKa2VxUkttWThSRE1kaENJd3VLK1FlaHUxOFVYSGkxZWVm?=
 =?utf-8?B?K2hHVEdMSTRNMThseVRkRXVnRWJyeGdpaElrZU03K2paQVBCZkxJdGlEVXps?=
 =?utf-8?B?QnVXWDljMG82UkVQS2hKY3VJUDlRcU96dDNFMlpxb2tURmV1U0NFcTFweXVn?=
 =?utf-8?B?cXBQN3dRWUJ3VUJQMnU3UmQ3TGEzVFFZWWU2azVacjV2dXduVnpyR1ZXdGJi?=
 =?utf-8?B?NzZWNUlvOEs0VTQyMEowNnVVN0VlRGh1NDQxRW9CUllsajVTeEh0ZzYxYlpV?=
 =?utf-8?B?SnJKbUxhdUxVamZOTUUvWnJTOGhaaDk3cXJYbkxsYUFMVkFIRUw4N3dJaTNH?=
 =?utf-8?B?WXZkNStVdkxDR0lKUkpiUTBOdncvSzk2eXlIVzNoVjM4MThLRUEyU3gzTkJV?=
 =?utf-8?B?ME1iUWVVWmljNlNqbjk5VjNEck1meXFzL05zY1RQZXZvZm50YmlOOTdKMVd4?=
 =?utf-8?B?dGVaYXVTeXJpKzhOMk4xbGxFRnlxTWVoNGFHdE5XclREZm5qZDVmOUQyOFlL?=
 =?utf-8?B?K0g2YU9YQVpvbllRMzhKQURISEtYR3d0VzlJYy9mTmMrTno4R003VmFxVGVz?=
 =?utf-8?B?MjRydEdydVRBUWM5LzRxMmsrT2dlMnNiK3NvaXdQL2lrS2dTWFh1N2h6OVZm?=
 =?utf-8?B?NjFDd3Q2YmlORFFPVWlTN1JZOVllTFVtK1I0Y2RlQmdpa1NTZGtEZWNncTFh?=
 =?utf-8?B?QmxoUG1DUVc0ek1SSE1XNXQycFM1cWxTV2d0eVFkc2s2Y094cG8wVGllOHRp?=
 =?utf-8?B?K09YU01NZkZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0Z5bVZMaytraUpzTHoxcVBqZ0hZelMySnhPVndieW45cnhzNW5Cb2ZiRGEz?=
 =?utf-8?B?WElqb3ZrOCtXcmJoYUtqaGpyMEdvWXIvTFFkWlcvNzhxdzN6dExiS0w2bk1s?=
 =?utf-8?B?SENWWWx6elREWkJFbHlrT2thc3dOR1BwOUZGRnR5WEZrdDVRbkYyc0Q3cUF1?=
 =?utf-8?B?YkFzUGdSY1RDeEM4VVVhNFRGUExPZlVkNGFBUk93SDlJdUV0SlZyc05qS3k2?=
 =?utf-8?B?TlRzbHVSWndJcUdjSW5LYmxxRmNQQnNPb1hxOWFnNGNDTUtOdlRZVjdTMktZ?=
 =?utf-8?B?aUlCN0VuYW4rM2VxSS9oK2syZjlFVGtiSXUwSXJEWDVDVGxUNlRHbVZySFJU?=
 =?utf-8?B?YUExN20yNjZyd0treTY5THhDcjBBNng0ZjU4eElzTnh3VERwTkZwV3B5V0hQ?=
 =?utf-8?B?UGFHOVNRMjJPb0F6RGttSzBVMFlTMmxGbGRSSGRDVFJhRENZR1FwNlF6aXY3?=
 =?utf-8?B?T3RjNFZiMmxqK25qWDF5REc1cDRYa0NnTURKcjJiTmVVaWt6cEYxMVRieW10?=
 =?utf-8?B?Zm9TMmRBWG8vWWdRdTl4cVhReVJPeG1KTFFnVHlmZVJwWW9GS3hweVhCQ0xK?=
 =?utf-8?B?a3JvUVU0c0toLzlPRjJVNWROaUJ0bzB0OE94Z2hxVW1VTnM4ZTFNcFJsK1FB?=
 =?utf-8?B?eUFCTWlGR25GczY4QnlHQTA2SzZ3YnJJUDdFVVBOckl2WjQ3bmxrTE5yWEow?=
 =?utf-8?B?VzNoVEZSSkRNOC93bnFIeVBBSDg4TndXc0dsUXJTMXNBMjcxSE00dHhmWTYv?=
 =?utf-8?B?aHZUYTI1RXVocUxXa2FHSFRNV0dkNnR1MFBIOWIxN1VJckpYaFhOK09UeXI1?=
 =?utf-8?B?bHNKSkExTU94Myt4dW5TY2hEM2dMQzZLbE1pTzNrUWFkOFVtRXcxOEwzczR3?=
 =?utf-8?B?RE1uUm44NTNDdjRLaEp1UjdPeFoyNldManFwOEFFTER4ZTgwNnQ3R3FtZEtP?=
 =?utf-8?B?aXhOazQ3MGxlYUdIRkpSc0UwQmNQTkhhOEhLWkk0Z0IxRmVjOEVncHhVZ1hr?=
 =?utf-8?B?RHFuU1AxOGhwbkhCRmtoU3c3QmJGdjdIdU9rYzZLQzBSaFNnbmVEWE1LMElY?=
 =?utf-8?B?NkpGZEI0L0xUOVY4Z0QrZ1RNUkZwVXdwU2VHZ1ZoeUJpZHNTSkRZbkU3dUJw?=
 =?utf-8?B?dThQRXlJbXQ4RGtvMHFURzE1OENHbVhDYlczRzRwWlBkWVJ3STd2eFhXaWt6?=
 =?utf-8?B?UkVTR29HUDJRaURvcUVqSWNnQkIxU0NMdE95OWZLcndpbk1odm96eVNuZTZB?=
 =?utf-8?B?VnZaRmN2TWtVMHFic1pPMnV5cTJBeXFlcjExM3NKa1l2aE5lcmk3NktVblZM?=
 =?utf-8?B?U0tEZWhRVm56eHRyeFhKRFlZNDMzYmlBK0xkVkZiMUU2OVA1N1E2M1loUFBT?=
 =?utf-8?B?b3FLNU1yMlZlYjhKU3pWcGc4akU1MTNjcHI2Uks0aVpnUjNISVFLandVZFN0?=
 =?utf-8?B?Z2ZWUWZnWm13azcybG1ERTVMZEU4MjNnSFFRK3ZzdjFkNFB5ZXh6S3VtRXF2?=
 =?utf-8?B?VHIxV0cyL05sK0N4b3dFTWtFWEMvYzl3Qkgxc0h0M0JpSGFMNUptOHpGTGZT?=
 =?utf-8?B?elB0TzZNbUpIcklVcHJZUmlmZWRZRHp2ODhLQnJtMHVEL1RTMTdhOXcybW5N?=
 =?utf-8?B?QlFBUm05ZFRmWXlCbzNKV2Y4TklzNkNuUHZkRlNwT1ZzZSt6VWxEcWhiQjJB?=
 =?utf-8?B?b0l1Vkd2WEQ5ZHZGeDlxRVpPc3hMSE9RK2h1Qyt3dU1LV3ZoZUZVSElIQ1c0?=
 =?utf-8?B?eDJOZ0tpZWdqRnJxalovSTlvSGtnM1pmYWpaU0I1WlBUOUlPRWNHaTZEL2Vt?=
 =?utf-8?B?OVJjZHFNc0tFSnNWdE1iVEZQeGdLL3JiYWRGeG9aVnJZbWh4RHZaRHRjS2pn?=
 =?utf-8?B?UnZRQ212ZHdLdUhRS3lac293TDZkR0xLZmlUYTdRZ3FBQitjSzNsQ1htTlNx?=
 =?utf-8?B?Tlp2Y3FybTdaMzNYWnBqYWdOakROOWhGTElSc0xaTDIrbVcyRzVyWk54VHVZ?=
 =?utf-8?B?N0dnZm5WQkhnc3NDMDBLWXlCeDZ3RjIyTkEyYzFqN2NOTXQ2SURiOXI2Q3BM?=
 =?utf-8?B?NFgvbzU5VnhvWWVmVmhsS3Z1RmdHdDk3VDMyN003S1JDQWlwOE93bGpJUC9p?=
 =?utf-8?B?d1hYWC90ZGZuVEVrT0JqUXJsL0N2UjZKUWZ3alc5U2JkKzhDRm1yMXFzb2hj?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed56f58-7cc2-4391-8a3a-08ddfc5fd318
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 18:17:45.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3Oz47qdKX008uXNdSExGYC9C5s9DyK7UnFqqVEc8WTAOA7DPsNU/0GYYKNqHoQlx+t5eVxSixjuPd3yqTA2vSxtuC+7NS53PV0jvpptaGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8093
X-OriginatorOrg: intel.com

Koralahalli Channabasappa, Smita wrote:
> On 9/8/2025 4:01 PM, dan.j.williams@intel.com wrote:
> > [ add Boris and Ard ]
> >=20
> > Ard, Boris, can you have a look at the touches to early e820/x86 init
> > (insert_resource_late()) and give an ack (or nak). The general problem
> > here is conflicts between e820 memory resources and CXL subsystem memor=
y
> > resources.
> >=20
> > Smita Koralahalli wrote:
> >> Insert Soft Reserved memory into a dedicated soft_reserve_resource tre=
e
> >> instead of the iomem_resource tree at boot.
> >>
> >> Publishing Soft Reserved ranges into iomem too early causes conflicts =
with
> >> CXL hotplug and region assembly failure, especially when Soft Reserved
> >> overlaps CXL regions.
> >>
> >> Re-inserting these ranges into iomem will be handled in follow-up patc=
hes,
> >> after ensuring CXL window publication ordering is stabilized and when =
the
> >> dax_hmem is ready to consume them.
> >>
> >> This avoids trimming or deleting resources later and provides a cleane=
r
> >> handoff between EFI-defined memory and CXL resource management.
> >>
> >> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.c=
om>
> >=20
> >=20
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >=20
> > Smita, if you added changes this should have Co-developed-by. Otherwise
> > plain Signed-off-by is interpreted as only chain of custody.  Any other
> > patches that you add my Signed-off-by to should also have
> > Co-developed-by or be From: me.
> >=20
> > Alternatively if you completely rewritel a patch with your own approach
> > then note the source (with a Link:) and leave off the original SOB.
> >=20
> > Lastly, in this case it looks unmodified from what I wrote? Then it
> > should be:
> >=20
> > From: Dan Williams <dan.j.williams@intel.com>
> >=20
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.co=
m>
> >=20
> > ...to show the chain of custody of you forwarding a diff authored
> > completely by someone else.
>=20
> Thanks for clarifying, Dan. I wasn=E2=80=99t aware of the distinction bef=
ore=20
> (especially to handle the chain of custody..). I will update to reflect=20
> that properly and will also be careful with how I handle authorship and=20
> sign-offs in future submissions.

Yeah, the choice to replace From: is subjective and I usually reserve
that for significant rewrites. If any of the original patch remains then
add Co-developed-by + Signed-off-by. If none of the original patch
remains I do still like to say:

"based on an original patch by ..." with a Link: to that inspiration
patch.

...and if you just forward the original, keep From: untouched and just
add your own Signed-off-by as documented in
Documentation/process/submitting-patches.rst.=

