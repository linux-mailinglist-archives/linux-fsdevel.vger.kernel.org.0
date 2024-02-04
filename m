Return-Path: <linux-fsdevel+bounces-10212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B8C848B82
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 07:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3458EB22F81
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8063179DF;
	Sun,  4 Feb 2024 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmqqMQg5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6B679D2;
	Sun,  4 Feb 2024 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707028389; cv=fail; b=LSs+YMOV3IoBP0hMPHVSOfn3QwDsyJ6ri+qIUhHhsxheLsG5h8u/M+A3Dk1oHDhChnW9y7ig/CYPd4f4JjhAofq1UuubugrurNkdnIh3c1CkCAhubPACpjP4QQT+scQ+DdhZz6m/h5rawCXXQINsqpBb+JMxGIoFRyW4Vga+k4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707028389; c=relaxed/simple;
	bh=uho38/X7zWsdH4Jae9z4Th4Inqn759mPohMwHjxNkxo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUtrKMcagdGsRbza8gKDa7RkzQVCzxCh5WifzrNmmAnkMzHxxapgdfwykEaiGqjHargcnbSU+OljPweWKswZpTXzjGHh5KwP21BrxOYZjmY3QFWoQjiPTCfZZfakVif5w6UPJr74c3GB3+or7B55tTR4bvjcmeP6/23MmO/bnh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmqqMQg5; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707028388; x=1738564388;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uho38/X7zWsdH4Jae9z4Th4Inqn759mPohMwHjxNkxo=;
  b=VmqqMQg5DimSCERZxWhHtQtvzBCK751XidQT4WgYenR1Cp0185ztMclF
   rkch3Ecmi9iQUlV7cQUm4s2dmPVU/068aqfVtmtnMOV8XwD/zb1n7mjxr
   JWYdeVjlsvwdJ9OrBUb1eI7zxCWHNxD0vwZv8mytWSsj5YnpWg1Wv9YRs
   uPobdlmRIh1jIF35TXH354yJEGhcd4EQLVA4ZHRT/x043cJARB1lKmg4n
   146bBoRIxZlGgSUiWq3Mi9blV3VB1KnbXHTuV9lMTTNgrDH3YHB+qqWVd
   4roCXt+hLOuZr3VjvjLZ4/38dY+AQU+2BH+5Qe30kcnWOg3jDXwbMaqOh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="11107369"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11107369"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 22:33:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="724244"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2024 22:33:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 3 Feb 2024 22:33:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 3 Feb 2024 22:33:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 3 Feb 2024 22:33:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 3 Feb 2024 22:33:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZvOBY02favNgwXryesoFhk/fUGYV8D3Iw7iq4b/kHEvoa0P6MxgFFCXkdQYQDpLDAd+zgveAOEHfr8Ba/1sksHZqRj6zaVw5x9i38koQPEuTY4bZEreN28y7CaM/UTsNxI7lGUeNzaBDKlmGDIwpoD4UPHZvFdADZx3ofSutKWSYL3q6QHqpIGVZxWUj8lXpdpbN939/eGYcA/D7qAGw9Yc8ABRDBC6JyAOt3q0W8qaigZHWYLqj6qPH8sGWJwG2+PGom+DyhEmwt4cT32ewA+dUxsrZvuGKN0UtIMFD4GpGP1jcb0osqClG06Djkjw6q9gIhApIxBr24n/yx0Wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPgDnJEKuuhiNSC4eWSdK2JdVX8TRAdaGmVAIdvnsA8=;
 b=OIipih4sGhY8dgP+G+NE95gq0G37nAs+QDbt0K+GMRKEzBYxXeKnEDxnB5xlIft//14LUQw5sUquaUZQLyDjUeepGl/RpdXJboG7Rd7PxFT21/8Bne2y/tb3dxBQgVix1pZwSrPdZKxknKXkWlXDkFv1a6DWLzhtxptS4vFralRBrgAUow7H2O0/52ATS/wp6nmsRyo5c7gu+vJDn7iXodVoE2O2QxiCiT+TbGCV4i68wTFwXjmLbuzhm1PH3OE4uNhyB1NHrZquBWGMqhXH9ktAYp3fnovQuZjMlZPQagu/gykKds/XzFKMjiujgciZ3dwNFSV/9KEt5utJyMZOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6945.namprd11.prod.outlook.com (2603:10b6:806:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 06:33:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 06:33:00 +0000
Date: Sun, 4 Feb 2024 14:32:51 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linus:master] [remap_range] dfad37051a:
 stress-ng.file-ioctl.ops_per_sec -11.2% regression
Message-ID: <Zb8vk1Psust0ODrs@xsang-OptiPlex-9020>
References: <202401312229.eddeb9a6-oliver.sang@intel.com>
 <CAOQ4uxiwCGxBBbz3Edsu-aeJbNzh5b-+gvTHwtBFnCvbto2v-g@mail.gmail.com>
 <CAOQ4uxgAaApTVxxPLKH69PMP-5My=1vS_c6TGqvV5MizMKoaiw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgAaApTVxxPLKH69PMP-5My=1vS_c6TGqvV5MizMKoaiw@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: d283d77c-0c0b-4a8d-0c0f-08dc254b21f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t03sSt+DL2njVrkY8Uz/Ad9KIj0M/IKisxNTUUnjw7sc9yvc9xnJUxpumbGie1jh8gBzT0KN7cKst36F4aT4HmJ/805M4H1klJh2SO73tIyXucKFOl7k1YQj9fKCdPQrlxcppa+llNUjWY7A7a2omYYXZngs4MW+IjU43ZKwAJNogO3ltvn3kx39ebemXHbXC/MaVZBaTSNtkpr5iBxcDuYzNNTaz+lyPtRd//U5yimXiUZeWUXmAJMhsMEpaBxrhgHVcgG/oBPNzFlBdgGs5vD3SR9HRzyg6Ie0mIm9IXC4WvcPPAEPg6hXLv4YoaUOFXlIoH2xcXsOUo04MxNzZm98Jd2/cLLNEs6Nuyc+vHvyGtSwLozLFmlP0+DX1jaz1MaQHgqmgP6ncmdvUNOFViTurE4zwFqvSoXVrsDJVpucuT+z6as5hm1a9pmjxfHrFF1RQ1bl/nIhWeg+XrN+202kAD3pDyV2LTvySJHgURCKQ+tulthPBORRetQ3iGiMlRLrNf3FjkoI7OqEW6zulnH9AYvXMcJfiNzgO751bvpmojijOW/IGVFYuI/z2ielKQyS8tUCqebr7ja5+jx9mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(44832011)(8936002)(8676002)(4326008)(2906002)(30864003)(5660300002)(86362001)(66946007)(66556008)(316002)(54906003)(6916009)(66476007)(82960400001)(38100700002)(53546011)(6506007)(9686003)(6512007)(478600001)(6666004)(6486002)(966005)(83380400001)(26005)(107886003)(33716001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm9TMmxnSkZ1dFJKSzdteFh6c3UxV1NRanc0WDlMVTJpT3AxWmViU0t4QlpH?=
 =?utf-8?B?cWpuSyszVEhIWjZ5Y0htOWQ5WFA1VTJtcnFPZHRuLzdzM0xCNmFCYmJjN1ZQ?=
 =?utf-8?B?dTdhUThqaEY1R1IvUHRoeDR2TG1ZT0xMRkVTNFlDWENhU1FucS93MTBGUW5P?=
 =?utf-8?B?SFB3blhDNysxTFR2aTI2a3FGdFB4RGlGa2w5K0RsRy9XSHU3MXNLcnJ3N3VF?=
 =?utf-8?B?U3pKMzlxSXZpUUpmczFBdE5DZWU3Z21FM2VPVzF6dExFaXV2d0tWc1cvQlVB?=
 =?utf-8?B?YnRDTVlmKy9OK1gxSmxUbyt4L3d5LzNWVlNmWjZ6ck8rVE1ZMjh3bEZ6d3dR?=
 =?utf-8?B?QnBjQk1kQnFRUURyQWpJR1dhNW11WlkxWXZFR09zMEhaS2FYakxFbmVUc1pC?=
 =?utf-8?B?Qjh4Q0lJNDRBK3kvL28zbGxXbEM2c2lhMmV0UEdZYitPczlJU21IRHFYaC9j?=
 =?utf-8?B?TmxkbVMybS9hblZ3UlJqeVhNZnJ5SlVOaHBrd0x1YXN3U3QvVzRDYmx6K3Vr?=
 =?utf-8?B?aENxN0cwMDJTQk5HVnQ4bjVEWlpsWE0wc0IwZVdpcGYwWERjQTNkNVNYRDBM?=
 =?utf-8?B?c2xXQWxNeGdEak5YRm1GRXJuMzg4cWt0TnQ4MWFQSUp4Mm9SUXh4Q014TS9C?=
 =?utf-8?B?cjJtVDdOVm9LVkkyUW5MNEVTYzhxQjhrK043bDhEL0FjbzFrU0VzL0xKbDhS?=
 =?utf-8?B?V0VXMzFiNEFBVnRqRGtCdWhxR2JHUWVoNEF6eVNhUFFsaFM1UTFySkRqZXgv?=
 =?utf-8?B?UEduaEpOa3hvTGFkQVZXUUlvY2NGN1o0WElDdmlTZC9zdEMxeTJHLy9DUVA3?=
 =?utf-8?B?QkRLS21FWlZOa3Z5UE1nU0s3ei9lNGpNNnBqRTZaK0x1ZHRDNm44UVZyVjNk?=
 =?utf-8?B?OHM2bHBFaEpJTTlidi9TdE5oSnh5QTA5eFFHNG5QNG9hZGtXaTBxeUFuMzd0?=
 =?utf-8?B?WVJTZGRhaVpyZHhoSm53Qzl6M2JSZmd3a29xY0tXWEtzMjBCU0phNFZxaDRO?=
 =?utf-8?B?a1VEM2wwVVlyYU0wVFFmdzJ5MzkxWWJwZElaNmJpSFpaTUo3bnNldUoxemQ5?=
 =?utf-8?B?bGVvbVdOOFAxcjZIbVpGVWh5bWdwcTNwVHg0Z1ZrWDV5TklUU2M4S0s2dnRW?=
 =?utf-8?B?MzFUNXRCd2FwQ3RkSW53QmtITUQzU1dVeTBtU01sdWJoS0Q1cmtHZzBCeGYv?=
 =?utf-8?B?VU5aWnVGcjZPeHVtQkJWK1lwcmtPeEFXOG9PTXBJVTd4ZHE4WVRkZm01N2F2?=
 =?utf-8?B?V1RsdGh0a2lMRWxPUk1rYWVYbmxIN09kblhXUHJGNzB6YTEzZ0NrY3ppZWFQ?=
 =?utf-8?B?cDdBUHhmWGpyQVROTHp6NHhTT0Y4eThBU3lUY0tsK042WXR4L1ZjRm9zT3BP?=
 =?utf-8?B?eSt0K3V5V01XNW5TU2NWYjRnM1o1WkNqRzhKWG40aVcyb3BpVHhmMGZlTU1I?=
 =?utf-8?B?SXBJRHJnOGh0WU9rcm10QzhQWDE3cGJhbUUzZGYyZytOZzhtSlBHcFp4NkNz?=
 =?utf-8?B?V1NjdHljcy9hUGtyWitzSnEvZUhET0VqenRQVlZqU0dnd3dSV3RnL3FMYUF3?=
 =?utf-8?B?UnpYdnZ1WlpNekcrcDRORThZYWF3ZXBmdjFHYXVzbjNFWkZLVmVaRC9OQkJ1?=
 =?utf-8?B?QU5HZWI3MnVxRC9US3dVRjR4dlpyR0p0djk3U2RuL2xQYkVpbHVlcW5Xdm83?=
 =?utf-8?B?dzlLSytFNlQreE51elE0cCtxd1p6cktZVUdTZW1qZDlBZy9rb2QyK2Q3cWtx?=
 =?utf-8?B?bUZ3bUZzd00vQUN6M0tkaitJS2JPTXUzTVlmMnRGNFNOMU5wMGdKcFFYWWVY?=
 =?utf-8?B?bEVXZ2h6UXUrR2JFWmo2TjlLZ2dvSDl2UUxiZDR0SXpEN1RIdExYbGhxR3VO?=
 =?utf-8?B?UnRnMHdDZXNNVXNxWE1tYlRHRllXNHdqanpXWUdXbFdMQnpWb2FmVWNMRGRO?=
 =?utf-8?B?eitrSGlEVVF2a2FQZzJoL3N1dE42b3k0dVNKWE9INlNpZVpaMkxnY2ZZcG15?=
 =?utf-8?B?R0lvM0lZQzRSNHZxOFkvRFJtZVZMWWFpMXUycG94eWFYK1ZiNldrUzJQblpp?=
 =?utf-8?B?WHE4WnU2Z2o4UDlJREh5cjJEaHAzRkFnV3Y0cDhkYzFFZXVsbjN0WU90YkJL?=
 =?utf-8?Q?Obt82pibLcF5OtDozAzcCCewj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d283d77c-0c0b-4a8d-0c0f-08dc254b21f5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 06:33:00.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVKKZxBwpHDGVJbpz+EJWikPBt4gLELqrkJOdqWe91EJmGQJrl52SnloDTc8cCFbAQ22gKInUnSGAI1Aa1ssrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-OriginatorOrg: intel.com

hi, Amir,

On Fri, Feb 02, 2024 at 11:13:56AM +0200, Amir Goldstein wrote:
> On Wed, Jan 31, 2024 at 5:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Jan 31, 2024 at 4:13 PM kenel test robot <oliver.sang@intel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed a -11.2% regression of stress-ng.file-ioctl.ops_per_sec on:
> > >
> > >
> > > commit: dfad37051ade6ac0d404ef4913f3bd01954ee51c ("remap_range: move permission hooks out of do_clone_file_range()")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> >
> > Can you please try this fix:
> >
> >  7d4213664bda remap_range: move sanity checks out of do_clone_file_range()
> >
> > from:
> >
> > https://github.com/amir73il/linux ovl-fixes
> >
> 
> Sorry, Oliver, this was a buggy commit.
> I pushed this fixes version to ovl-fixes branch:
> 
>  1c5e7db8e1b2 remap_range: merge do_clone_file_range() into
> vfs_clone_file_range()
> 
> Can you please test.

the regression disappeared by above commit in our tests.

I noticed this branch is based on v6.8-rc2, so I directly tested upon it and its
parent (3f01e53bf6). I found 3f01e53bf6 has same data as dfad37051a we reported.

and on 1c5e7db8e1b2, the performance back to the same level before dfad37051a.

below is the summary:

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/file-ioctl/stress-ng/60s

commit:
  d53471ba6f ("splice: remove permission hook from iter_file_splice_write()")
  dfad37051a ("remap_range: move permission hooks out of do_clone_file_range()")
  3f01e53bf6 ("MAINTAINERS: update overlayfs git tree")
  1c5e7db8e1 ("remap_range: merge do_clone_file_range() into vfs_clone_file_range()")

d53471ba6f7ae97a dfad37051ade6ac0d404ef4913f 3f01e53bf658495e01cab85d82a 1c5e7db8e1b25b9ef86a9026862
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
  95739218           -11.2%   84990543 ±  2%     -11.3%   84951004            +0.7%   96455282        stress-ng.file-ioctl.ops
   1595650           -11.2%    1416506 ±  2%     -11.3%    1415846            +0.7%    1607584        stress-ng.file-ioctl.ops_per_sec



below is the details FYI:

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/file-ioctl/stress-ng/60s

commit:
  d53471ba6f ("splice: remove permission hook from iter_file_splice_write()")
  dfad37051a ("remap_range: move permission hooks out of do_clone_file_range()")
  3f01e53bf6 ("MAINTAINERS: update overlayfs git tree")
  1c5e7db8e1 ("remap_range: merge do_clone_file_range() into vfs_clone_file_range()")

d53471ba6f7ae97a dfad37051ade6ac0d404ef4913f 3f01e53bf658495e01cab85d82a 1c5e7db8e1b25b9ef86a9026862
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
      2.57            -0.3        2.27            -0.3        2.25            -0.0        2.52        mpstat.cpu.all.usr%
      7.40            +3.4%       7.65            +4.1%       7.71            +0.4%       7.43        iostat.cpu.system
      2.50           -11.5%       2.22           -12.5%       2.19            -1.9%       2.46        iostat.cpu.user
     49702 ±  6%      -3.4%      48023 ± 12%     +13.4%      56347 ±  8%     +20.0%      59637 ±  2%  meminfo.AnonHugePages
     74632            -0.2%      74463           -57.7%      31584           -57.6%      31669        meminfo.Percpu
     87960 ±  2%      +1.6%      89400 ±  5%     +12.2%      98666 ±  7%      +4.3%      91739 ±  9%  numa-meminfo.node0.SUnreclaim
     69529 ±  3%      -1.9%      68208 ±  7%     -16.2%      58254 ± 13%      -5.5%      65677 ± 14%  numa-meminfo.node1.SUnreclaim
     21990 ±  2%      +1.6%      22350 ±  5%     +12.2%      24666 ±  7%      +4.3%      22934 ±  9%  numa-vmstat.node0.nr_slab_unreclaimable
     17382 ±  3%      -1.9%      17052 ±  7%     -16.2%      14563 ± 13%      -5.5%      16419 ± 14%  numa-vmstat.node1.nr_slab_unreclaimable
    267.41            +4.2%     278.66            +4.7%     280.04            +0.7%     269.27        time.system_time
     90.19           -12.5%      78.96           -14.0%      77.59            -2.0%      88.37        time.user_time
     34.41            +0.5%      34.57            +3.7%      35.69            +3.2%      35.51        boot-time.boot
     23.41            +0.5%      23.52            +5.5%      24.69            +4.5%      24.47        boot-time.dhcp
      1991            +0.6%       2002            +4.0%       2071            +3.4%       2059        boot-time.idle
      1434 ± 10%     -18.2%       1172 ± 18%     -57.1%     615.00 ±  9%     -63.1%     529.50 ± 11%  perf-c2c.DRAM.remote
      1117 ±  9%      -7.0%       1039 ±  9%     -52.8%     527.67 ± 11%     -57.1%     480.00 ± 13%  perf-c2c.HITM.local
    167.67 ± 14%      -5.5%     158.50 ± 31%     -41.0%      99.00 ± 14%     -57.6%      71.17 ± 22%  perf-c2c.HITM.remote
  95739218           -11.2%   84990543 ±  2%     -11.3%   84951004            +0.7%   96455282        stress-ng.file-ioctl.ops
   1595650           -11.2%    1416506 ±  2%     -11.3%    1415846            +0.7%    1607584        stress-ng.file-ioctl.ops_per_sec
    267.41            +4.2%     278.66            +4.7%     280.04            +0.7%     269.27        stress-ng.time.system_time
     90.19           -12.5%      78.96           -14.0%      77.59            -2.0%      88.37        stress-ng.time.user_time
     44.89 ± 16%      +1.5%      45.57 ± 19%    -100.0%       0.00          -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.avg
    515.17 ±  2%      +5.4%     542.92 ±  9%    -100.0%       0.00          -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.max
    135.06 ±  8%      +2.3%     138.12 ± 10%    -100.0%       0.00          -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.stddev
    891.47            -0.4%     887.93           +15.8%       1031           +14.9%       1024        sched_debug.cpu.clock_task.stddev
  12529207            +0.0%   12529207           -50.2%    6237751           -50.2%    6237751        sched_debug.sysctl_sched.sysctl_sched_features
     86772            -0.4%      86400            +4.9%      91010            +4.7%      90835        proc-vmstat.nr_anon_pages
    105949            -0.4%     105517            +5.1%     111368            +4.8%     111042        proc-vmstat.nr_inactive_anon
    105949            -0.4%     105517            +5.1%     111368            +4.8%     111042        proc-vmstat.nr_zone_inactive_anon
    425778            +0.8%     429132            +1.3%     431364            +2.4%     435972        proc-vmstat.pgalloc_normal
    415867            +0.5%     417794            +1.2%     420781            +1.9%     423729        proc-vmstat.pgfree
    696576 ±  2%      -3.8%     670080 ±  7%    -100.0%       0.00          -100.0%       0.00        proc-vmstat.unevictable_pgs_scanned
      0.00 ± 17%      +0.0%       0.00 ± 17%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.tpm_try_transmit.tpm_transmit
      0.00 ± 20%      +9.1%       0.00 ± 28%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.wait_for_tpm_stat.tpm_tis_send_data
      0.00 ± 31%      +0.0%       0.00 ± 17%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.01 ± 28%     -28.3%       0.01 ± 54%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00 ± 30%     +13.3%       0.00 ± 13%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.tpm_try_transmit.tpm_transmit
      0.00 ± 39%      -4.8%       0.00 ± 41%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.wait_for_tpm_stat.tpm_tis_send_data
      0.00 ± 31%      +0.0%       0.00 ± 17%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
    564.55 ± 37%     -48.8%     288.96 ± 73%     +10.0%     621.20 ± 62%     -90.2%      55.05 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 27%     -17.6%       0.01 ± 24%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      4.00 ± 54%      +8.3%       4.33 ±126%     +29.2%       5.17 ± 51%     -87.5%       0.50 ±223%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     51.83 ± 20%     -13.5%      44.83 ± 34%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1013            -1.2%       1001 ±100%     +48.2%       1502 ± 63%     -83.8%     164.00 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 41%     -23.9%       0.04 ± 60%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    564.54 ± 37%     -44.3%     314.30 ± 57%     +10.2%     622.40 ± 62%     -72.6%     154.89 ± 80%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 61%     +29.4%       0.02 ± 16%      +1.2%       0.01 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
      0.02 ± 29%     -19.2%       0.01 ± 21%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ± 27%     -17.6%       0.01 ± 24%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.71            +0.0%       0.71          -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.tpm_try_transmit.tpm_transmit
      0.45            +0.1%       0.45          -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.wait_for_tpm_stat.tpm_tis_send_data
      0.99            -0.1%       0.99          -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.00 ±145%    +160.0%       0.00 ±114%  +19320.0%       0.16 ±217%  +20700.0%       0.17 ±202%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      0.03 ± 64%     +14.2%       0.03 ± 63%     -13.7%       0.03 ± 18%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
      0.04 ± 59%      -5.6%       0.03 ± 57%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.06 ± 41%     -23.9%       0.04 ± 60%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.98            -0.1%       0.98          -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.tpm_try_transmit.tpm_transmit
      0.99            +0.1%       0.99          -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.wait_for_tpm_stat.tpm_tis_send_data
      0.99            -0.1%       0.99          -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.00 ±145%    +160.0%       0.00 ±114%  +19320.0%       0.16 ±217%  +20700.0%       0.17 ±202%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      0.12 ±  9%     +37.6%       0.16 ±  3%     +46.3%       0.17 ±  2%      +0.9%       0.12 ±  8%  perf-stat.i.MPKI
 5.619e+09            -4.9%  5.346e+09           -10.1%  5.053e+09            -8.3%  5.154e+09        perf-stat.i.branch-instructions
      0.13            +0.0        0.13 ±  5%      +0.0        0.13 ±  2%      +0.0        0.14        perf-stat.i.branch-miss-rate%
   8104366            -3.2%    7841290 ±  5%      -2.2%    7928723 ±  2%      +0.4%    8134981        perf-stat.i.branch-misses
     25.26 ± 12%      +5.4       30.67 ±  2%      +6.1       31.39 ±  2%      -2.8       22.49 ± 12%  perf-stat.i.cache-miss-rate%
   3226271 ±  8%     +32.3%    4268159 ±  2%     +34.1%    4327362 ±  2%      -6.7%    3008704 ±  7%  perf-stat.i.cache-misses
  13880671 ±  2%      +7.6%   14934433            +7.0%   14856536            +4.2%   14464224 ±  3%  perf-stat.i.cache-references
      0.83            +3.9%       0.86            +8.9%       0.90            +8.2%       0.89        perf-stat.i.cpi
      7405 ±  8%     -26.1%       5473 ±  2%     -27.2%       5395 ±  2%      +7.5%       7963 ±  7%  perf-stat.i.cycles-between-cache-misses
      0.02 ±210%      +0.0        0.03 ±217%      -0.0        0.00 ±  7%      -0.0        0.00 ±  6%  perf-stat.i.dTLB-load-miss-rate%
   1198124 ±210%     +87.7%    2248507 ±217%     -95.7%      51944 ±  7%     -95.8%      50495 ±  6%  perf-stat.i.dTLB-load-misses
 7.817e+09            -2.7%   7.61e+09            -5.8%  7.364e+09            -6.8%  7.285e+09        perf-stat.i.dTLB-loads
      0.00 ±  4%      +0.0        0.00 ±  3%      +0.0        0.00 ±  3%      +0.0        0.00 ±  2%  perf-stat.i.dTLB-store-miss-rate%
     26775 ±  3%      -2.5%      26108 ±  2%      -7.7%      24702 ±  3%      -1.4%      26389 ±  2%  perf-stat.i.dTLB-store-misses
 5.186e+09            -6.0%  4.873e+09           -10.8%  4.624e+09            -8.4%  4.749e+09        perf-stat.i.dTLB-stores
 2.807e+10            -3.9%  2.696e+10            -8.3%  2.575e+10            -7.5%  2.597e+10        perf-stat.i.instructions
      1.21            -3.7%       1.17            -8.1%       1.11            -7.6%       1.12        perf-stat.i.ipc
    257.16           +12.9%     290.46           +12.7%     289.89            +2.2%     262.78 ±  2%  perf-stat.i.metric.K/sec
    290.80            -4.2%     278.45            -8.5%     266.14            -7.7%     268.43        perf-stat.i.metric.M/sec
   1580051 ± 11%     +38.0%    2180479 ±  5%     +41.9%    2242249 ±  3%      -7.4%    1463122 ± 12%  perf-stat.i.node-load-misses
    228848 ± 22%    +116.2%     494834 ± 27%     +83.2%     419274 ± 22%     -18.7%     186032 ± 32%  perf-stat.i.node-loads
    739626 ± 15%     +28.2%     948465 ± 11%     +36.7%    1011333 ±  8%      -8.4%     677284 ±  4%  perf-stat.i.node-store-misses
      0.11 ±  9%     +37.7%       0.16 ±  3%     +46.1%       0.17 ±  2%      +0.8%       0.12 ±  8%  perf-stat.overall.MPKI
      0.14            +0.0        0.15 ±  5%      +0.0        0.16 ±  2%      +0.0        0.16        perf-stat.overall.branch-miss-rate%
     23.29 ± 11%      +5.3       28.58 ±  2%      +5.8       29.13 ±  2%      -2.4       20.89 ± 11%  perf-stat.overall.cache-miss-rate%
      0.82            +3.9%       0.86            +8.8%       0.90            +8.1%       0.89        perf-stat.overall.cpi
      7231 ±  8%     -25.1%       5416 ±  2%     -26.1%       5343 ±  2%      +7.0%       7740 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.02 ±210%      +0.0        0.03 ±217%      -0.0        0.00 ±  7%      -0.0        0.00 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  3%      +0.0        0.00 ±  3%      +0.0        0.00 ±  2%      +0.0        0.00 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
      1.21            -3.7%       1.17            -8.1%       1.11            -7.5%       1.12        perf-stat.overall.ipc
 5.524e+09            -4.8%  5.257e+09           -10.1%  4.967e+09            -8.3%  5.068e+09        perf-stat.ps.branch-instructions
   7962517            -3.1%    7713102 ±  5%      -2.3%    7781058            +0.5%    8006027        perf-stat.ps.branch-misses
   3170718 ±  8%     +32.4%    4196610 ±  2%     +34.1%    4253192 ±  2%      -6.7%    2957362 ±  7%  perf-stat.ps.cache-misses
  13646445 ±  2%      +7.6%   14686495 ±  2%      +7.0%   14601960            +4.2%   14219304 ±  3%  perf-stat.ps.cache-references
   1178079 ±210%     +87.7%    2210990 ±217%     -95.7%      51043 ±  7%     -95.8%      49643 ±  6%  perf-stat.ps.dTLB-load-misses
 7.685e+09            -2.6%  7.483e+09            -5.8%   7.24e+09            -6.8%  7.163e+09        perf-stat.ps.dTLB-loads
     26301 ±  3%      -2.5%      25656 ±  2%      -7.8%      24251 ±  3%      -1.5%      25913 ±  2%  perf-stat.ps.dTLB-store-misses
 5.099e+09            -6.0%  4.792e+09           -10.8%  4.546e+09            -8.4%   4.67e+09        perf-stat.ps.dTLB-stores
 2.759e+10            -3.9%  2.651e+10            -8.3%  2.531e+10            -7.5%  2.553e+10        perf-stat.ps.instructions
   1553350 ± 11%     +38.1%    2144498 ±  5%     +41.9%    2204343 ±  3%      -7.4%    1438512 ± 12%  perf-stat.ps.node-load-misses
    224907 ± 22%    +116.2%     486304 ± 27%     +83.2%     412125 ± 22%     -18.7%     182868 ± 32%  perf-stat.ps.node-loads
    727127 ± 15%     +28.3%     932767 ± 11%     +36.7%     994262 ±  8%      -8.4%     665892 ±  4%  perf-stat.ps.node-store-misses
 1.668e+12            -3.4%  1.611e+12 ±  2%      -8.6%  1.524e+12            -7.5%  1.544e+12        perf-stat.total.instructions
      5.57 ±  3%      -0.7        4.85 ±  2%      -5.6        0.00            -5.6        0.00        perf-profile.calltrace.cycles-pp.__fget_light.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.89 ± 23%      -0.4        0.45 ± 44%      -0.9        0.00            -0.9        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      4.28 ±  5%      -0.3        3.94 ±  9%      -0.5        3.79            +0.0        4.29        perf-profile.calltrace.cycles-pp._copy_from_user.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.30 ±  2%      -0.3        2.00            -0.3        1.99            +0.0        2.32        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.69 ±  3%      -0.3        1.39 ±  4%      -0.4        1.26 ±  2%      -0.2        1.48 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
      1.99 ±  2%      -0.3        1.72            -0.2        1.74            +0.0        2.02        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±101%      -0.2        0.08 ±223%      +0.3        0.58 ±  9%      +0.5        0.79 ± 27%  perf-profile.calltrace.cycles-pp.security_file_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      2.27            -0.2        2.09 ±  5%      -0.2        2.06 ±  2%      +0.1        2.32        perf-profile.calltrace.cycles-pp._copy_from_user.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.16 ±  3%      -0.2        1.00 ±  3%      -0.1        1.01            +0.0        1.19 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ±  4%      -0.2        0.44 ± 45%      -0.6        0.00            -0.6        0.00        perf-profile.calltrace.cycles-pp.__fget_light.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.47 ± 11%      -0.1        1.36            -0.5        0.95 ± 23%      -0.2        1.31 ±  8%  perf-profile.calltrace.cycles-pp.memdup_user.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.0        0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.__fdget_raw.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.5        0.53 ± 46%      +0.8        0.83 ± 26%  perf-profile.calltrace.cycles-pp.__fdget.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      0.00            +0.0        0.00            +5.6        5.59            +6.5        6.50 ±  3%  perf-profile.calltrace.cycles-pp.__fdget.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.00            +0.0        0.00            +7.3        7.28 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.remap_verify_area.vfs_clone_file_range.ioctl_file_clone
      0.00            +0.0        0.00            +7.6        7.64 ±  2%      +0.0        0.00        perf-profile.calltrace.cycles-pp.security_file_permission.remap_verify_area.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl
      0.00            +0.0        0.00            +8.2        8.20 ±  2%      +0.0        0.00        perf-profile.calltrace.cycles-pp.remap_verify_area.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
      0.00            +1.5        1.52 ±  2%      +1.3        1.33 ± 15%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
      0.00            +6.9        6.94 ±  6%      +0.0        0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl
      0.00            +7.4        7.41 ±  6%      +0.0        0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
     21.11            +7.4       28.53            +7.6       28.73            -0.8       20.32        perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      3.18 ±  2%      +8.7       11.87 ±  3%      +9.0       12.22            -1.1        2.04 ±  8%  perf-profile.calltrace.cycles-pp.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46 ±  9%      +8.9       10.36 ±  4%      +9.3       10.77            -1.5        0.00        perf-profile.calltrace.cycles-pp.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
     10.70            -1.3        9.39 ±  3%      -1.6        9.11            +0.0       10.73        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     11.31            -1.1       10.24 ±  2%      -1.5        9.76            -0.2       11.11 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      7.87 ±  3%      -1.0        6.90            -7.9        0.00            -7.9        0.00        perf-profile.children.cycles-pp.__fget_light
      5.13            -0.7        4.46 ±  2%      -1.3        3.82            -0.8        4.33 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.74 ±  3%      -0.6        7.09 ±  5%      -0.8        6.90            +0.1        7.80        perf-profile.children.cycles-pp._copy_from_user
      0.89            -0.4        0.46 ±  5%      -0.5        0.40 ±  5%      -0.9        0.00        perf-profile.children.cycles-pp.do_clone_file_range
      3.45 ±  2%      -0.4        3.10            -0.4        3.08            +0.0        3.48        perf-profile.children.cycles-pp.llseek
      1.80 ±  4%      -0.3        1.49 ±  3%      -0.2        1.60 ±  2%      +0.0        1.80 ±  3%  perf-profile.children.cycles-pp.stress_file_ioctl
      1.83            -0.2        1.63 ±  4%      -0.2        1.63 ±  3%      -0.0        1.83 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.53 ±  3%      -0.2        1.34 ±  4%      -1.5        0.00            -1.5        0.00        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      2.32 ±  3%      -0.2        2.13            -0.3        2.03 ±  2%      +0.0        2.34 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.58 ±  2%      -0.2        1.40            -0.3        1.26 ±  3%      -0.2        1.40        perf-profile.children.cycles-pp.memdup_user
      1.81            -0.2        1.62            -0.2        1.57 ±  2%      -0.0        1.80 ±  4%  perf-profile.children.cycles-pp.__get_user_4
      1.26 ±  3%      -0.2        1.08 ±  3%      -0.1        1.12 ±  2%      +0.0        1.31 ±  3%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      1.32 ±  2%      -0.2        1.14 ±  2%      -0.4        0.90 ±  4%      -0.3        1.04        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      2.06 ±  2%      -0.2        1.90 ±  3%      -2.1        0.00            -2.1        0.00        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      1.12 ±  3%      -0.1        0.99 ±  2%      +0.0        1.13            +0.2        1.27 ±  2%  perf-profile.children.cycles-pp.security_file_ioctl
      0.84 ±  3%      -0.1        0.73 ±  3%      -0.1        0.77 ±  2%      +0.1        0.92 ±  3%  perf-profile.children.cycles-pp.ksys_lseek
      0.29 ±  4%      -0.1        0.18 ±  4%      -0.1        0.16 ±  5%      -0.1        0.17 ±  8%  perf-profile.children.cycles-pp.generic_file_rw_checks
      0.76 ±  3%      -0.1        0.68            -0.1        0.68            -0.0        0.75 ±  4%  perf-profile.children.cycles-pp.amd_clear_divider
      0.84 ±  3%      -0.1        0.75 ±  3%      -0.1        0.77 ±  2%      +0.1        0.89 ±  2%  perf-profile.children.cycles-pp.__put_user_4
      0.86 ±  4%      -0.1        0.78 ±  3%      -0.1        0.78 ±  3%      +0.0        0.89 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.53 ±  3%      -0.1        0.46 ±  4%      -0.0        0.50 ±  3%      +0.1        0.60 ±  6%  perf-profile.children.cycles-pp.__fdget_pos
      0.19 ± 11%      -0.1        0.12 ± 10%      -0.1        0.12 ±  9%      +0.0        0.22 ±  6%  perf-profile.children.cycles-pp.stress_mwc8
      0.54 ±  5%      -0.1        0.48 ±  6%      -0.1        0.45 ±  5%      -0.1        0.47 ±  6%  perf-profile.children.cycles-pp.__check_object_size
      0.73 ±  2%      -0.1        0.67 ±  5%      +6.0        6.78            +7.1        7.84 ±  2%  perf-profile.children.cycles-pp.__fdget
      0.49 ±  2%      -0.1        0.43 ±  3%      -0.2        0.34 ±  3%      -0.1        0.40 ±  3%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      0.51 ±  4%      -0.1        0.45 ±  5%      -0.0        0.48 ± 18%      -0.0        0.49        perf-profile.children.cycles-pp.ioctl@plt
      0.58 ±  3%      -0.0        0.54 ±  4%      -0.1        0.53 ±  4%      +0.0        0.59 ±  3%  perf-profile.children.cycles-pp.__get_user_2
      0.38 ±  3%      -0.0        0.33 ±  4%      -0.4        0.00            -0.4        0.00        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.44 ±  3%      -0.0        0.40 ±  3%      -0.1        0.39 ±  5%      +0.0        0.45 ±  5%  perf-profile.children.cycles-pp.__libc_fcntl64
      0.24 ±  6%      -0.0        0.20 ±  7%      -0.0        0.21 ±  5%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.do_fcntl
      0.48 ±  3%      -0.0        0.44 ±  2%      -0.0        0.44 ±  3%      +0.0        0.49 ±  2%  perf-profile.children.cycles-pp.set_close_on_exec
      0.38 ±  6%      -0.0        0.36 ±  3%      -0.0        0.38 ±  4%      +0.1        0.44 ±  4%  perf-profile.children.cycles-pp.check_flag
      0.26 ±  5%      -0.0        0.24 ± 11%      -0.1        0.20 ±  9%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.check_heap_object
      0.16 ±  8%      -0.0        0.14 ±  8%      -0.0        0.15 ±  9%      +0.0        0.17 ±  9%  perf-profile.children.cycles-pp.__check_heap_object
      0.10 ± 13%      -0.0        0.08 ± 11%      +0.0        0.11 ± 10%      +0.0        0.13 ± 10%  perf-profile.children.cycles-pp.security_file_fcntl
      0.20 ±  7%      -0.0        0.18 ±  5%      -0.0        0.17 ±  5%      +0.0        0.21 ± 12%  perf-profile.children.cycles-pp.inode_get_bytes
      0.13 ±  7%      -0.0        0.12 ± 15%      -0.0        0.11 ±  9%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.08 ± 11%      -0.0        0.08 ±  6%      +0.2        0.26 ±  3%      +0.2        0.30 ±  6%  perf-profile.children.cycles-pp.kfree
      0.08 ± 14%      -0.0        0.08 ±  6%      +0.0        0.10 ± 10%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.__errno_location
      0.06 ± 11%      +0.0        0.06 ± 11%      +0.4        0.46 ±  5%      +0.5        0.54 ±  3%  perf-profile.children.cycles-pp.__fdget_raw
      0.00            +0.0        0.00            +8.3        8.30 ±  2%      +0.0        0.00        perf-profile.children.cycles-pp.remap_verify_area
      0.28 ±  3%      +0.0        0.30 ±  7%      -0.0        0.26 ± 11%      -0.2        0.06 ± 14%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.2        0.25 ±  4%      +0.0        0.00            +0.0        0.00        perf-profile.children.cycles-pp.fsnotify_perm
      0.57            +0.6        1.15 ±  3%      +0.6        1.13 ±  2%      +0.0        0.60 ±  3%  perf-profile.children.cycles-pp.aa_file_perm
     85.52            +1.4       86.91            +1.3       86.85            -0.0       85.51        perf-profile.children.cycles-pp.ioctl
      0.00            +1.6        1.55            +1.5        1.52            +0.0        0.00        perf-profile.children.cycles-pp.__fsnotify_parent
     62.60            +4.0       66.55            +4.5       67.05            +0.1       62.67        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     59.77            +4.3       64.05            +4.8       64.53            +0.0       59.82        perf-profile.children.cycles-pp.do_syscall_64
     47.98            +5.7       53.66            +6.2       54.22            +0.1       48.10        perf-profile.children.cycles-pp.__x64_sys_ioctl
     21.64            +7.3       28.98            +7.5       29.19            -0.8       20.85        perf-profile.children.cycles-pp.do_vfs_ioctl
      8.29 ±  4%      +7.4       15.74 ±  6%      +7.9       16.18 ±  3%      +0.3        8.60 ±  9%  perf-profile.children.cycles-pp.apparmor_file_permission
      8.78 ±  4%      +7.9       16.64 ±  5%      +8.2       17.03 ±  3%      +0.3        9.10 ±  9%  perf-profile.children.cycles-pp.security_file_permission
      3.30 ±  2%      +8.7       11.96 ±  3%      +9.0       12.30            -1.1        2.22 ±  3%  perf-profile.children.cycles-pp.ioctl_file_clone
      1.68            +8.9       10.55 ±  3%      +9.2       10.92            -1.1        0.60 ±  7%  perf-profile.children.cycles-pp.vfs_clone_file_range
     10.33            -1.3        9.02 ±  3%      -1.5        8.80            +0.1       10.38        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
     11.15            -1.2        9.92 ±  2%      -1.4        9.77            -0.1       11.07 ±  2%  perf-profile.self.cycles-pp.ioctl
      7.55 ±  3%      -0.9        6.61            -7.6        0.00            -7.6        0.00        perf-profile.self.cycles-pp.__fget_light
      7.54 ±  3%      -0.6        6.92 ±  6%      -0.8        6.73            +0.1        7.59        perf-profile.self.cycles-pp._copy_from_user
      3.16 ±  4%      -0.5        2.69 ±  2%      -0.5        2.68            -0.1        3.11 ±  2%  perf-profile.self.cycles-pp.do_vfs_ioctl
      2.95 ±  2%      -0.4        2.55 ±  2%      -0.3        2.64            +0.1        3.04 ±  2%  perf-profile.self.cycles-pp.__x64_sys_ioctl
      3.32            -0.4        2.93 ±  2%      +1.7        5.00            +2.3        5.66 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      3.08 ±  2%      -0.4        2.72 ±  3%      -0.3        2.74 ±  2%      +0.0        3.10        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.13            -0.4        2.78 ±  2%      -0.4        2.73 ±  2%      +0.0        3.15 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.39 ±  2%      -0.3        2.10 ±  2%      -0.3        2.09 ±  2%      -0.0        2.38        perf-profile.self.cycles-pp.ioctl_preallocate
      0.57 ±  2%      -0.3        0.31 ±  9%      -0.3        0.26 ±  5%      -0.6        0.00        perf-profile.self.cycles-pp.do_clone_file_range
      2.02 ±  2%      -0.3        1.77 ±  3%      +0.2        2.26 ±  2%      +0.5        2.54 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.54 ±  4%      -0.2        1.29 ±  3%      -0.2        1.37 ±  3%      +0.0        1.55 ±  4%  perf-profile.self.cycles-pp.stress_file_ioctl
      1.83            -0.2        1.62 ±  4%      -0.2        1.62 ±  3%      -0.0        1.83 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      2.32 ±  3%      -0.2        2.13            -0.3        2.03 ±  2%      +0.0        2.33 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.77            -0.2        1.58            -0.2        1.54 ±  2%      -0.0        1.75 ±  4%  perf-profile.self.cycles-pp.__get_user_4
      1.28 ±  2%      -0.2        1.11 ±  4%      -1.3        0.00            -1.3        0.00        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      1.76 ±  2%      -0.1        1.62 ±  3%      -1.8        0.00            -1.8        0.00        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.25 ±  6%      -0.1        0.12 ±  8%      -0.2        0.10 ±  9%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.generic_file_rw_checks
      0.48 ±  2%      -0.1        0.38 ±  4%      -0.1        0.34 ±  6%      -0.0        0.47 ±  3%  perf-profile.self.cycles-pp.ioctl_file_clone
      0.79 ±  3%      -0.1        0.70 ±  2%      -0.1        0.67 ±  4%      -0.0        0.78 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.81 ±  3%      -0.1        0.73 ±  4%      -0.1        0.75 ±  2%      +0.1        0.87 ±  2%  perf-profile.self.cycles-pp.__put_user_4
      0.90 ±  4%      -0.1        0.82 ±  5%      -0.2        0.75 ±  5%      -0.1        0.85 ±  2%  perf-profile.self.cycles-pp.vfs_fallocate
      0.81 ±  5%      -0.1        0.73 ±  3%      -0.1        0.74 ±  3%      +0.0        0.84 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.52 ±  4%      -0.1        0.44 ±  3%      -0.1        0.46 ±  3%      -0.0        0.51 ±  6%  perf-profile.self.cycles-pp.amd_clear_divider
      0.17 ± 11%      -0.1        0.12 ± 10%      -0.1        0.11 ±  9%      +0.0        0.21 ±  6%  perf-profile.self.cycles-pp.stress_mwc8
      0.57 ±  3%      -0.0        0.52 ±  4%      -0.0        0.52 ±  4%      +0.0        0.58 ±  2%  perf-profile.self.cycles-pp.__get_user_2
      0.42 ±  4%      -0.0        0.38 ±  3%      -0.0        0.37 ±  6%      +0.0        0.42 ±  6%  perf-profile.self.cycles-pp.__libc_fcntl64
      0.30 ±  3%      -0.0        0.26 ±  5%      +0.1        0.39 ±  5%      +0.2        0.47 ±  5%  perf-profile.self.cycles-pp.__x64_sys_fcntl
      0.22 ±  5%      -0.0        0.18 ±  6%      -0.0        0.19 ±  6%      -0.0        0.21 ±  4%  perf-profile.self.cycles-pp.do_fcntl
      0.28 ±  3%      -0.0        0.24 ±  2%      -0.3        0.00            -0.3        0.00        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.27 ±  4%      -0.0        0.24 ±  8%      +6.1        6.32            +7.1        7.33 ±  2%  perf-profile.self.cycles-pp.__fdget
      0.14 ± 10%      -0.0        0.12 ±  8%      +0.3        0.49 ±  4%      +0.4        0.59 ±  6%  perf-profile.self.cycles-pp.__fdget_pos
      0.19 ±  4%      -0.0        0.17 ±  8%      +0.0        0.20 ± 39%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.ioctl@plt
      0.22 ±  6%      -0.0        0.21 ±  4%      +0.0        0.23 ±  6%      +0.0        0.26 ±  5%  perf-profile.self.cycles-pp.check_flag
      0.07 ± 10%      -0.0        0.06 ± 13%      +0.2        0.28 ±  3%      +0.3        0.32 ±  5%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.12 ±  7%      -0.0        0.12 ± 16%      -0.0        0.10 ±  7%      -0.0        0.09 ± 12%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.07 ± 13%      -0.0        0.06 ± 11%      +0.2        0.24 ±  3%      +0.2        0.29 ±  5%  perf-profile.self.cycles-pp.kfree
      0.46 ±  5%      -0.0        0.46 ±  3%      -0.1        0.37 ±  6%      -0.0        0.42 ±  6%  perf-profile.self.cycles-pp.llseek
      0.10 ± 13%      -0.0        0.09 ±  9%      -0.0        0.07 ± 12%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.check_heap_object
      0.00            +0.0        0.00            +0.4        0.42 ±  5%      +0.5        0.50 ±  3%  perf-profile.self.cycles-pp.__fdget_raw
      0.00            +0.0        0.00            +0.5        0.46 ±  4%      +0.0        0.00        perf-profile.self.cycles-pp.remap_verify_area
      0.05 ± 45%      +0.0        0.06 ±  8%      +0.0        0.08 ±  9%      +0.0        0.08 ± 13%  perf-profile.self.cycles-pp.__errno_location
      0.66 ±  2%      +0.0        0.68 ±  3%      -0.0        0.64 ±  3%      -0.2        0.42 ±  8%  perf-profile.self.cycles-pp.vfs_clone_file_range
      0.00            +0.2        0.22 ±  4%      +0.0        0.00            +0.0        0.00        perf-profile.self.cycles-pp.fsnotify_perm
      0.49 ±  3%      +0.4        0.92 ±  2%      +0.4        0.94            +0.0        0.51 ±  3%  perf-profile.self.cycles-pp.security_file_permission
      0.46 ±  2%      +0.5        0.96 ±  2%      +0.5        0.94 ±  2%      +0.0        0.47 ±  3%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +1.5        1.52 ±  2%      +1.5        1.49 ±  2%      +0.0        0.00        perf-profile.self.cycles-pp.__fsnotify_parent
      7.75 ±  4%      +6.8       14.58 ±  7%      +7.3       15.02 ±  4%      +0.3        8.03 ± 10%  perf-profile.self.cycles-pp.apparmor_file_permission


> 
> Thanks,
> Amir.

