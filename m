Return-Path: <linux-fsdevel+bounces-60974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF8B53E84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 00:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A768AA6058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B896534AB1F;
	Thu, 11 Sep 2025 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBRxTS/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD2342C88;
	Thu, 11 Sep 2025 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628481; cv=fail; b=PcFsRkNN1NLbAdLj8hTzyt1OMQFE06XZOBBWc7fN+Vyo5NNgBnyA896XRN2lh+CM3tgThmr4kXz1se+/kaARh8vW+JyJGTXCooQC2XFHDYfzKIdqDqwJrPTG7Da31Oh8HdbumUpoTdWSyhcb/INL18pZUwyq6EaNFeIv9VH+lQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628481; c=relaxed/simple;
	bh=WVMQo6mpQ/b+WqvKhu7x8+i1hPUZygZNl5VCKkqm9Gk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AAMHPSel6hmPgM9MVeKcjpU4QIAYXD9qTvSiDPVzAh0hQR47OFX7ja5o5mE39bEU5ixyeYUVcWNYeNjFB3QdPxe6+dMa+OSWXC5YwTM3y8ZwJFtugKFtm6AJ6M9tUHgOuYTiB2peU6Sw1AhMxGI8huWWg5sYRPEFl2U9gqpduNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBRxTS/V; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757628480; x=1789164480;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WVMQo6mpQ/b+WqvKhu7x8+i1hPUZygZNl5VCKkqm9Gk=;
  b=LBRxTS/V3Yz/DepLPoof3SpiTnzLDUPLbNvN/HSFZIleWgmI5NXNg+yT
   AqVP4nM2Z27C/ziTEEK+4UmdeFrPv1oRn0Kekj42O6Ly7gede2PSfhY37
   kblXavqzFBfWA88hE/Xe9F6JHkGvr6Mr5UlJqVTqqJYm57wwhb23BLJYJ
   nHlEk1ErxHQdpMZl/HtZGiwO2LCEcwp2Wv7o3YMJ/55X0MlVMjIudfiVE
   syKFWEvytmS44x5h6mgaYQim0GhhwuK72EFT1OeNFxIqsS3oG0vp4kgDM
   8hOq4Z0PC1pXtjenk0sLbnJnKvJTVlqCuQFAGaF3bgxBBJ5KMUKOTACEH
   Q==;
X-CSE-ConnectionGUID: YkT+eEWDQAeC7er2+UMONg==
X-CSE-MsgGUID: sJRu0w1wQn6VbqhHDwl4xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60047639"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="60047639"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 15:07:58 -0700
X-CSE-ConnectionGUID: U6lWyK6UTcmYMbAPExNOLQ==
X-CSE-MsgGUID: v0NE2+oWSAC0gXSGJnwhTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="173375460"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 15:07:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 15:07:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 15:07:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 15:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFVtCAxN7HfqW8jh9OHyy/v+TCKQ4F+WiL9QjEczdFR0ynaq1dl+RJkHrj17fs58soc/ycyAykGYftCbFDCuznWMcqqKsl2zqIr9vW7IFbhrdl/hUGJcE81OM1RE35zyxN0OnUpvxwESLAfPAXZ2kXIV7Qo+g+Yepp78lBl4LeGgVbjadaOtZ6LNkpWP5i80YCVsMmQcapg/gApVLPPXwPknKmpkfmvLnYWpfrFNGNl06gsqkPa+yTR469oyxwHHglcfgHik21YKj4pLJYSh0Jg2FBemYqk1o53FdkUg2jL4tbeceU7m9Yzq2g5aEUU5dkOXBDFImmga1W1V8z9kLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cNNf73/JRglblIRtVK/g6Tyl545PuASxqcWeEmDvWU=;
 b=vIXrVNqQ4jMuBAud/KroaKhkzOxm+s30aFRdKklI7vfRe40mc7iONyn8KciKur7+8TgtlKOhu0MzmjtD9VzmFEZ/IvnNweq7uirPRMNSPl9Ig0VkUnfsuFk5wcBh6AIRsOx1+gryHUkW/kaiArKo5exI/30SicG2l0ncX9bVZke5ujR5Es+2R1iKndBp7nmg/WllwkX9wUmX+A/DnrWnMTO2C4K849grHO89JjWJlp6el2oG6HUmR7X9kAAks90eOrrpo9KwAJFAF4Los9Xh2YV4KUOHPA7GyqaLb2YYzFkS+PQWG601Tg72+w/58uV3S0Ld7E7L5T9q7FryKa0v5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 22:07:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 22:07:48 +0000
Message-ID: <f04792c6-f651-41f7-a960-56ca37894454@intel.com>
Date: Thu, 11 Sep 2025 15:07:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] mm: update resctl to use mmap_prepare
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
	Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "David S .
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre
	<nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, David Hildenbrand <david@redhat.com>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Tony Luck
	<tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>, James Morse
	<james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>, "Dmitry
 Vyukov" <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, "Jann
 Horn" <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>, <ntfs3@lists.linux.dev>,
	<kexec@lists.infradead.org>, <kasan-dev@googlegroups.com>, Jason Gunthorpe
	<jgg@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <f0bfba7672f5fb39dffeeed65c64900d65ba0124.1757534913.git.lorenzo.stoakes@oracle.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f0bfba7672f5fb39dffeeed65c64900d65ba0124.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 319beb2c-694a-446d-cac7-08ddf17fa485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk04RzdPUEtuUFdCdXJaMk8vcG41bzNvL3hlNjBhaXVES0pyRGMvaWF5cjMw?=
 =?utf-8?B?RVZORnJvQ3V2Sm80YTJLamxsYWR1R01qT0RIR1hIdzVVM2xLUHZXaFoyYm9I?=
 =?utf-8?B?dENrMm9qTWNjTmNibU9ZTkowbThqRG1jclNRNXJ1YmV5aHpVV2F3MUp2d245?=
 =?utf-8?B?d2V6cWRLUkFTeDBMTGVmVWlkRUlieFovaW45NkpxNDh4cmtGYWVtTXNZektU?=
 =?utf-8?B?Z29HTGtUdVZGL3VvY0lmYWl0UW5yN1JTT0llYWYrU2FiUHhXejh4cVFRMXFZ?=
 =?utf-8?B?Qk1GNnRMTkNtaGhwcTNTRENwaEdnZ3AyQkFaUldoQitaL3BQL1Vpb3Fzd1BO?=
 =?utf-8?B?VUdTQTBLTEJEcVpsMkdsZkowemYyWkU2bUVXYk5HcC9IbStLMXNnUkNyQnpn?=
 =?utf-8?B?bXY4clptaUNldjBnOEd2cnNQTUYvckRZMlZ6Q1BjTW82d2VsVFZjZExGdTMv?=
 =?utf-8?B?YWN6MFl3ZkhMQlJsMUtaeWwvckhxL1ZNV3NCY0dUdmNBa0J0NWwwTUdTVTFB?=
 =?utf-8?B?YURFdUYxK1QxVzI3TTAyQng3Y0NWeUkvSlJTcHg1ZmpRZmlJeWNRMGMzWVM2?=
 =?utf-8?B?MDVFM1J5NXVRYWpkalhkUjlBVVQ4cXk1MUJ6S3V5Q3lBWWpaS3BBYnJYYS8w?=
 =?utf-8?B?enluK0JaQ1ErSHA5YkVDSzkrSVRpaDdodWtTaEtON1RNcXlBUHhqZThSS2dx?=
 =?utf-8?B?QitJQU82RTRsSmRuUmNqRW1Gdmo2RDRpMDZvVXk5Q09aL2JOcTUwa0dwODBi?=
 =?utf-8?B?UHVIMnJXRHgwRFFyU1BIb2twNDRQSGtjRGhTY3M0b3lkZWgzeWQ2Z2lsMmYz?=
 =?utf-8?B?T0hlbG5HMUdxV01pbjJqK25iV3d5SWRZN08rTE1yNEFCYiswUFhzbFhLUEpY?=
 =?utf-8?B?Tm5Ba0E0eWJOdjNSWjU5bzFFS0pRaGt5NU5raGhsNFVyWE5YUEZmOXBLSDdP?=
 =?utf-8?B?QkQwZjlTTnF4R3AyZ2RHMjNZS2IxOHZ6akp5di9acGtKaTJHdFVjcGY0VmNY?=
 =?utf-8?B?Rnk5SHI0T1drdlYyOG9FYWUzSlhLbW5uTWlyZlBMTHFKZ1Bta0ZrdVkwSFVt?=
 =?utf-8?B?VVU5SGZldlp4andUTUN6SjRpL2pwTkgrVjA1bTl3M0pzUm9JaUFacmVXYnU2?=
 =?utf-8?B?UmFEWGhvekF0NkVnaUtQR1hiczlEbXdWNzdVbEtiRENJRzJLaDVnREdKK0pj?=
 =?utf-8?B?OE1SaTlseDI1Und4RkxiTk1IME5KUXBqdVhHTGkrc2lFWkVIQ2JsRGRsVmFv?=
 =?utf-8?B?aDZseVJrSVJWcTU1VEx6S3hnUG0wVEJaaCtPdzRPcEJSU3BvMUVKanYzOWxK?=
 =?utf-8?B?QWt1aU5QT0FNNHY4U2VpSU5ZclFheUQrOXFSNzNXNGlqSUNGUlJ6MERiS1Fi?=
 =?utf-8?B?QUhGSWIyVzh2VTk1c2h1ZkpsNkdpeklMc1c0b3hyYmw4RDBmcTFvNjJoeWF3?=
 =?utf-8?B?ZlMvVlhGRlJvMHhGSHYvaGhkR3NhTEJ4Nlc2NVp3MS9TKzEwUTdrenpnb3lU?=
 =?utf-8?B?Ynhrci9FRHF6T3JldXJnbmxlQmZoZit4LzhuV2s0UDBzWjVLcnJOTzd2RXZo?=
 =?utf-8?B?RGlUdUNzQW1OWUVTa0t6S0tuWTdYVUtTcU1nWDNEdlVlaXVaZU84Zi94RU9I?=
 =?utf-8?B?SDNvZ0pkeHJBWVZGK25lblMvYzVneloxbzJqRDFHSzNiSnhBZm13U1dnbXhC?=
 =?utf-8?B?SXB5MUwyZWdIeDk3UlhwWkxVS2dYOFJuRlp0TlphL2djNG9QRkZkREkvSG5Q?=
 =?utf-8?B?YmllVWc0ZGJqS1ZBVitqWCtzSHE5V21Ub0JiaFlrR1pxS1lSbGV4ZVBRdWl0?=
 =?utf-8?B?aEpsN1g2MlBmUW5mMDN3TTc5M1UwSGtTdDk4ZlpxdkkxK3p0ZnNnQnowSGdJ?=
 =?utf-8?B?ZzhlRWZNNXA3SDZjVm9TbDQ1RGsxdkF6UWtnQVNSVnJnOU1vZ2RMUGh3M2d5?=
 =?utf-8?Q?AeK/eY4ohe0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENpTWZGNnBaYU9Ka3U1VXYrWkxZTTNFVkE4c1Q4eDViZnYzZG1SL3dHZS92?=
 =?utf-8?B?Q0lMS2lpWUY2eXhtZXRTalA5SzBFQXU0bjRSZXJDenBEN0d3Z2Vra3J1WTZR?=
 =?utf-8?B?RlpLY2t2UDlrM3I4dGVVTDJ3R0Rrc2NINU1GbFNRL0FOcXBEUWRhQWpEU1lr?=
 =?utf-8?B?Z2lkUndBMmM2ZnhPelBDUDU4d09nUVRraUhZeEZXc0doVmRlSmhKdnN5RUp1?=
 =?utf-8?B?aGpBN1BocDFHSDhYVXhqTldmUVFZOUVJZ25DTzVvcnhTM01CdFdxeWlmZjRX?=
 =?utf-8?B?U2cvVFRvMW1wYXRHUHFrdXR6eEdZTGhLUHZ0YUNVZzlOMFBTSkJLUk9KKzlX?=
 =?utf-8?B?eW1CMDVZeC9FVHp4T1hXc0Q5ZmU5bjlEUVhQdE9MczJqRjZaM0xKSEg5QlBU?=
 =?utf-8?B?VDZKUFcyWjlWTUlIRVVacDhtVGR2UzY5cXRQbzRiZHJiRGl5eEdONlF4OUxP?=
 =?utf-8?B?K2wzK1EvWU1mNVRvejB4cXc3TFpXbEdrRHVKNGtaTzIreGRzZm9IZ1dlVElN?=
 =?utf-8?B?NlNndERuTzhHd1h1UkpUVWRNcGF3Q3F2VXhBcWdlYnRqcVFLMFlyakZyRmh4?=
 =?utf-8?B?bmNtbEFJVUsyWmxJdWt6R1hkZUhlWENtOHFHa2NaclVpaVNISlh4QlpXVjNO?=
 =?utf-8?B?dTBMRDgrZHA5VHovQUtob2MvQWp1MFpRTUVWSEhJWW1HODdubEtNbjVFN0V4?=
 =?utf-8?B?Ni91NmFLMHdxcDVHaVlLNmhlT1ZuZEVVdDNNWGN3MWkvc3BjbVJyWWdydEZl?=
 =?utf-8?B?N1FTWDhodGdSREYzQTkwbkFzdHd4ZGsyRjd3QzBYVDQzNTB4MzV6OVRyN2Jr?=
 =?utf-8?B?c01hL0YzR0RWcWg4alJ6WHdFc01pdkpnVUl3SnZ0WldtRXNLWW1KQTQ3UW5i?=
 =?utf-8?B?bW9aRDg3T1hra1BrZ2VBbWRzRU9VS0oyeDJneWNhMGhaQzlXQlhNbUJpeXBh?=
 =?utf-8?B?U0xLb1BoSHlUMUl3ZXlVdmRoeTZDYlNLNzA5M1I1UTVOMnlUUllUNDBPNnl1?=
 =?utf-8?B?ekEreFliUnA3OTNJREVYcXUvbW52TGVoYkI2YkN4Z3R4WGFidFRMazU4Yzdm?=
 =?utf-8?B?Wk1ZRnhISzJIbTNrc2wzbmYwODk2bXhVTXFEM3R1RnBFQmhGS3pHeDJYNVM1?=
 =?utf-8?B?eENpRExNcDU0N3ZNYnNRNUt4Z3BIdEhzaC9qMHNNdGFLYlEyTiszditqTU5Q?=
 =?utf-8?B?eWtwTDBEWnZFTHExV05XQ3o1VFBrZjR5L1B2cjVNZ2EzZUg4YU50WFpUTXgw?=
 =?utf-8?B?Rm1qc2phMUFQR0tDMDJ2bnFlaHJwN3ptOERTdGVKOFN0bC9aWnNscTlOM2s1?=
 =?utf-8?B?VzNBVGhpVlQ1QVJUaC9mZy8vaVJ5b08xYUE3ZWMrQkRlbUg1RE5SSi9jVnZ3?=
 =?utf-8?B?VHI1MVlHTytuV0RMVU9kMWlLVXdHZDh2OGhtRUFVQXlSN0JPM3dFK3ovK0du?=
 =?utf-8?B?ekFxQmpESlRrYUpBbzBzY3E4c1h0bGtxa1BrNUZBRGNYVnNBV0lGb3VyZzZv?=
 =?utf-8?B?aDlxLzFmTkJtRVJtSHJUREJvaW9sOEI4cEtnNHoxMXB2MWV2SW5wZFpZTnBG?=
 =?utf-8?B?b3ZJWEswdkdueTJkM1lHK0RXUXgrSmFnSUtuZUgxd25ENHRHbWN6ZzVzeEgy?=
 =?utf-8?B?bU1tL3VKZTN1NXZ3UjcxaWVzdkg1azFjZjVXZm9sajR2Qlg1cGRhTEYzNFI2?=
 =?utf-8?B?ZFkxTXFrL0lDMVJqL1BqU3Q5N2prN2lTOGVNT1RPelBGR2tLamlvWE94QjUz?=
 =?utf-8?B?QTlJd29VZ3JNWU02R1dpeXZzT1FPU29kV0xVYVJzQ0JZNEwwZVhRSVgrMUdr?=
 =?utf-8?B?RFZyMDVsbGtNRVVGdzN3TEpXMm1Wam1XbkhJajRoZzhUUzBaazVNM2FLMitt?=
 =?utf-8?B?SXFFaTBSMERYd1dQbExmc2ZhSEM0RWp1ZjVvMjdwa2RqSDVPM3JmK1pPUXVW?=
 =?utf-8?B?YVdONHJUbzdBRnFtUFNhTlJhWHNHTUptYlNYSVRENUF4NXpFbkZhTUF5S2ht?=
 =?utf-8?B?cTgzRE5yQWNpRnVTb245cVJRNmdDelFJSjVoMUlyWWVoTW83WnBucmpuWHdH?=
 =?utf-8?B?T01uUUFsRjNoODJwUzRydGROcU1DMUZ5RHJteWdFa0ZPY1dRUnlXSWVZZGwr?=
 =?utf-8?B?OTdSZC9WVWdqMk1nU2lhYXNoWjdOYnNXd3E2cUlVSU9veXk1SFQrYUwzdmpi?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 319beb2c-694a-446d-cac7-08ddf17fa485
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 22:07:48.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO5jqT5bmqq3jlE63kAzh7ThfNpeBg8PqnLpYMv16VOydfIKeo9nuSGlCOTYP1Vn2szmpkXQZvG35yWfdCnDhtRdV2i0nmt/Db7iZC6ir3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com

Hi Lorenzo,

On 9/10/25 1:22 PM, Lorenzo Stoakes wrote:
> Make use of the ability to specify a remap action within mmap_prepare to
> update the resctl pseudo-lock to use mmap_prepare in favour of the
> deprecated mmap hook.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Thank you.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

This does not conflict with any of the resctrl changes currently
being queued in tip tree for inclusion during next merge window.

Reinette

