Return-Path: <linux-fsdevel+bounces-55875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A30FB0F6F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B629E580FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFED42F5327;
	Wed, 23 Jul 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCdgYbFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0252F5489;
	Wed, 23 Jul 2025 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284267; cv=fail; b=oB6gi7czp4wPjxp7WtUC0FIPLuNszcXfL891SvteTCFcenagskrKBPVoPlUYaKPWEPaeCRnpcL+ZhlIIAbhcGSnf2OCEsulgkzxBIqofXRKuuUu7KSP8ecHjoljXttbMHK7IkOCsSlsxpeQ7ymTBl0K4qaB6EgG46/DCYC7CatE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284267; c=relaxed/simple;
	bh=qe51x5urfsdH3FOuKnEYd2nDSZocc1bXMMdajx4s9XA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=LD002iklpyT2M4QNG1fu4SPlJXiC/LrFPvN96cF50PuNwIUVantrzFqMeQnc7MxUeNiw1+zmH/N4VcNLEvYA/vcicYCLwNxpNoIOF3iI6MCn5zjV2QJpfr3pdZS0VvqAHb3N0gaHO1DDws2aQsZxGUcrVUdzlr7RfyTxJwRukOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCdgYbFs; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753284266; x=1784820266;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=qe51x5urfsdH3FOuKnEYd2nDSZocc1bXMMdajx4s9XA=;
  b=iCdgYbFszSj2VQ8e/qyVGFAfFpSxic6KHA9ftwmsneqQQ/sfM1e99DB4
   Torenc23wklv5S/OZfNg1uU1nBLvfwYIhYgekKaxccvLCeojo8mA3+L85
   crFJTARz0GpToNpl9e/UjHVowzJhHUTnZ2GxBRUeMUuo8e7CtkZgOW0sM
   wWMCtZ2hlIXkAFWE+JlqgcKTk8tOANypbeHSBe8KMno7KEkzPOlS0zZi+
   wp+mmE/Wv6Eu/CP5/ZoolQ7u3IcAK2H/STdlORH1weLplvaTHpwp0sWHP
   OU42rjN+qQ96tF5rwFu4GRh++Lu01/VTVQuxZ7MY1nt8QeLXr+k6bF9pr
   Q==;
X-CSE-ConnectionGUID: UipfNq4gRvupDlHia+rnhw==
X-CSE-MsgGUID: TyZJ76p3SnyBZR9q18Za/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55724209"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55724209"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:24:25 -0700
X-CSE-ConnectionGUID: 5+DcC+tTStiMZEbRPtDWVA==
X-CSE-MsgGUID: S/VyPlhbRSeWcXWB5MtnUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159871413"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:24:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:24:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 08:24:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:24:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSVlhIFc3locvH9265v8OZ1ltWbJMjSN1+30B4g/Sn3jJFZzzD1a3ukOrP1FfkgSyYo+gTJWkfU1dRctXnBHgQWjNVkfqKrD8/77bbDSlNnT8zQIKbDihPHvxWVxE+O2/7sRmLoKQJQz/R5a0atGL5j+ssJyK+Vaq3FKnkwR2eIEhfJzyr7n9o55Ico08KxO1O+xasluDjfGFV1f2u5GxPo/lasIB0/6TqywUiBO4mjVuh+Ui44NTEAHciaw2ua5SSVd1taT3lK60zCAMpVbhI6adif/zokswUjKcF546n62HXHU8Hl2mpWdbplg17BgZMFrb54ne7eGvYgiVla0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPjQYiESvgHnf62U78O6fqJ/puJAsyjCmw7XaQWZWwY=;
 b=lnBXZ+bMyI8UN3LWdCuV6pwlL3t6hAyY+2EUI03TBy8QOYkAAbAu7VZhW5UiocxziGQQMCJ6VGyzG6Y32jaIXA8NE7hT09awjv72i9gG4sEX6d84+BRlnX9UvCOaLpcijpeBIscI8aDK5wdHh7Eo84F5d7UO4MHt/OKzNnzn0etDWSySRTGtXE/DOusAxLIhPWdqmx/UjQtmi8W8/Fh9V4XaUR5st/rEsBKzHtMVeP3pMPYiOzLIlJlFciLt5NDaE7lIm3/1BZ3+p2bGs3d3sALFXbN5If0pTBgKj+88cl7qVK3aiA7hFmgwDEVQF9ttz1wb02mtscZ3M2AocfJo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 23 Jul
 2025 15:24:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 15:24:15 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 08:24:13 -0700
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>
Message-ID: <6880fe9dbb6ec_e74a1004b@dwillia2-mobl4.notmuch>
In-Reply-To: <4ac55e2c-54a9-4fab-b0c5-2a928faef33e@amd.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <aHbDLaKt30TglvFa@aschofie-mobl2.lan>
 <4ac55e2c-54a9-4fab-b0c5-2a928faef33e@amd.com>
Subject: Re: [PATCH v5 0/7] Add managed SOFT RESERVE resource handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 39623b51-3753-4091-fd84-08ddc9fcfc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzAxUVltdDRoYmZNMTQzTHYwOUtxcWFhTmprQVFzbngrR1Z0MzBhblhoK1dq?=
 =?utf-8?B?RklIb1dqMHU1cGVJRzNrdTZqM0JEQjNUL081dHNnYitwWFJmZHMwRUliUS9Y?=
 =?utf-8?B?b0NiV1phWXhBNjZIcWxHelVRdGxVUGV1UDFaSzVpSUc3ZUgwSjZRRzhNNE8r?=
 =?utf-8?B?K1ZhL1hoUGVXdW1EcS9HWGt3b2ZoTUJjTUNMNWtjVk9rbmhPM255dVQrRDhT?=
 =?utf-8?B?dk9BaHM4ZHpzTjBsWWlUTkhzMlBmVjk2YXhLem1XRnluQzFDdmlGZmJ5MEpF?=
 =?utf-8?B?bk5TbnNGSEMvU21WSkNUd1prQWdSWGlOdC9lR25hdklBdXRBMjZQQUVSV1hl?=
 =?utf-8?B?cno0YWM3bWh6bzlWYU91Vkx2YmpHVDVHWk0yRjVRMnJidGxRVmFBZVBqTGY5?=
 =?utf-8?B?WkFVYjlJQkNENlM3VFdtc3M4NEgyUTlZeDVHWnZENy82OUU5Rk9IRUFnWXoz?=
 =?utf-8?B?aHQ0bFhDOUsrck5XMS9XN3daUHZ4S3NFQ3QzTmlRdGIzWktEcVhqSjRaOGlh?=
 =?utf-8?B?UWdtdm55dXRkRUE2VEZ6SkVQZm9ZdG5FbjA3ZnZWaXh4QzYxSG5QUVBQREx5?=
 =?utf-8?B?WnF4Njg1akhNSU1FVzBNcXhKMDduVGF0K2o1MUpiajdnMTMvTDFzenJOdnBr?=
 =?utf-8?B?ZFZvR002ekVndDhZZXZaV25Lbk5iclRRWUdicFViWEJEeFVqWXdaVU9wQzdr?=
 =?utf-8?B?MVdENzgzUU9YK2xtdUhtQnJyUytNWU0vK1Q0bU53M0dqamlyVnpURmVzNldV?=
 =?utf-8?B?RUJNb0NEYnhWcTQ5WGxPRm9wZURzdjlwdG95ZEJ5L0xZU3hFci8yNlNIcnpo?=
 =?utf-8?B?RGg3WjFNS3U0emZpK1l3Q2hYemRzTU53ZDN4YU1jMnJQZ3NZZTcrRDJhMmx6?=
 =?utf-8?B?VnlPZVp1Yy9kNWdhaTl6cmlLYWxBNVRYMngrejIvT2gzdU5DUWhMVHlUSEs3?=
 =?utf-8?B?M3c4b0N4NER0L2tRUk14SXdzLzgvd0h0cnBCWmJyT2I0L3lnMDBTUzJEcmMy?=
 =?utf-8?B?MU9MS2RaSmRvSXpDTjVRWVpUeExEQ3FKM2FrNDVZZnQwYURHY2l6bzJTazFr?=
 =?utf-8?B?YzhyNG9PdnRPVHZNU1ZrRlNmRy9YNUJ1TVVzU1M4UTF2bWhGa0NrL0RsWllh?=
 =?utf-8?B?K0htU0VNa29aQzUrbVFSV3JlWWZ6TlBCQWlPUGJMVHFFNUVmdGkwNlRZSnl5?=
 =?utf-8?B?NFh2bm5jVXAvYlJZSG5Rc3hDUkxlZFllWWNBQ0VHbUFzRGEyZFdyOG91ejJY?=
 =?utf-8?B?NG9YakU3Y245YmdIWDhuQkNUSWY2V1EvL2ppTmtpNmZ1UjU5UjlieHFlWDNp?=
 =?utf-8?B?dlRHYzJFTllzUHczeEdKc0xSRUNXVHFKS2o5SEtPckVZS1pkK2ErM0YxbGdP?=
 =?utf-8?B?Q25ReFo4SWFPZjhCL0pDQWJjVjNXT3dKK3VsNGNHTEdkSHFUZHp3ZGNMZHJQ?=
 =?utf-8?B?eURCaHplUk8vVGdVNUxjcWlkMzAvNmtKUEcyMHh3NWNvZlNsT1Q2QVFTMkd5?=
 =?utf-8?B?ZC9vWTFleHM2OC9VYnBKeEFWSFNtMGVUSEFyUTZ6UWZCa2ZZdWs1REticWFr?=
 =?utf-8?B?R2NsNzdKQkxod2UxUHYxNGpKNWxhWXc2cGZBR1dSV1NZc0RWMHNvV014eUNK?=
 =?utf-8?B?RW5pV0NGZ0Z3L2RqY2dTL2cwVlFsVVhFTzlQcnMxb29nbm43WWNiSGxXMXd1?=
 =?utf-8?B?NEordC85aGFpY2k3MFlCNkNNUmFaOVVzWlNqa0w1cVFFU1BIYTI2eHV5RkFU?=
 =?utf-8?B?ZXJiLytKQXNIb2crc28zOHRLa3paenczM1NZWXZ6a05oZ2J3dHI1QmdhYkhY?=
 =?utf-8?B?UkM4bjJQWm1WTFJSVWZHVVJCaHNvaHVhb0hGN2pSUEZYc2pLWmhmVjQzRVRu?=
 =?utf-8?B?WFVQNURzdmRzZlhRaURYeVl5UkMxRjZJOHBZanhscEVlVmtuTmgwbVNnMWpG?=
 =?utf-8?Q?E2f97f1G7Ws=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNoQk5GK1IrVVduODVsZ0s3aUVsQVZaSk1PWkdKYS9RMWNKSEt0ZysyRWNV?=
 =?utf-8?B?YUVSaEp0QU9LazA3RndITnZucEZuVmxrSk8xbXpkK2VNV1ZjYXdIYzdranpi?=
 =?utf-8?B?bFNKdTJWck8wVk1QY3NVUm5iL3pmazNqVHo0bkdTYnNZanpQQjNjbnFwUnAr?=
 =?utf-8?B?bEd0Y3hwK0VRTFRGb0t3QU1TdHRPcDdMdThqeCtWdDJ2NEJnZnB3aXhyYUNa?=
 =?utf-8?B?cGZSSmtUd1l5SEhaN2o3YWM5YzJVbTJBaFBUTjY0SitKajRlN3pyNnI3b004?=
 =?utf-8?B?eEdiTnRlbUNPRysxd3hDWHBNcXVZT2lxU2ZRQmYzc2RSZ3pwN1V1VHI0eSty?=
 =?utf-8?B?KzZjQUtlRXNaM2MwRWpVNFhUTlBIUk4zQXN2bE5OemZBN3JhQkVtUGFQR0Er?=
 =?utf-8?B?MXlkRHV0d1VOZUlsTGhUTXREdXhZakU0MlhEVXI3Q2NUWEttVVJTaDE1RGJC?=
 =?utf-8?B?L3ZRaDRxKy92cDFucjg4QVBkWkY2alVKZkhVaWIyYUZJV2liUnQxd0RKbFZR?=
 =?utf-8?B?aU8yTUxzQTNQQXo1MUszSDlub1V4K1VSZitycUpza2FXdFpLWnMzdFNMUlpw?=
 =?utf-8?B?UEV6dTFYRU1ieU5nTmhWU2tycTN0QXVyalNtdURFZm1KMXNqYmRyc3NKK0xq?=
 =?utf-8?B?YmxVV2F5VnprMUV2ejBQRjBmZUtFUVNlREpvd3VjVWpBSXYrUEpCc1VoaXhZ?=
 =?utf-8?B?djUxTkJUSzZVTjROVHgvUVFMUEJMWTFvL29IZVBCUGU4aS9yTnloREEya3hR?=
 =?utf-8?B?SWdJb3krWUZSNy9QajBxSGJabkQrY3hxYjR0bnFNazE5dk5kUVE1Q2Q3QWJq?=
 =?utf-8?B?Z1NQeTFneWk4RHdDNFcvYjFUVDBkNWNHeFFsTThoNG9WZXZCOGdzOElvL1Bt?=
 =?utf-8?B?K3M5WGcvTmM1Ry9CWHlET0VTSWJoajJaUS9zdUNlUExkS002bWRjeW91VnBr?=
 =?utf-8?B?djd6UGY2dVAwWGp6alcva0Q0TVRhQzJmMWtZNGlMbVNuSVY1d1Rremp5TGZJ?=
 =?utf-8?B?bG03bWtPbkhpbmdDVDVQdTFhWDBPK05pVkhoU3I4MzMxbnZ4YWpwTm0zSm8z?=
 =?utf-8?B?a1kzOUsvRmhKNVBUYzd2Y3RxTTdyU1RrTS82WUhRYmZiZWdDR0gwQTZkdFZk?=
 =?utf-8?B?YmZXNStCYVpzQ1Yxd2wvb1RlaWhCVmpPSTU5cG1CRGY1dHRzQjk4b2hyREFs?=
 =?utf-8?B?Skt2VHBZT0hHeG9YRmVscXA1NCtMTEpNbTA2ZkRidVpYS3gyN2w4ZVBrUy96?=
 =?utf-8?B?Y3lqVjhQbzlWSTNQckNpK3VHTXo0bGpQd2RlZk85OWtvcm50cGIwNFhVcytO?=
 =?utf-8?B?M2RUTzJEVFNGdWx6d2ZtOEtMdUU3SGlNL2dRQzN1OVU5blBtSkdiM1ZYSTE1?=
 =?utf-8?B?aXZSc2xtUTlsUHlhV3F0UWR2dXh5eG9JalBmb0dVSnhsTGdNazZxZE9xWEMw?=
 =?utf-8?B?UzVhVStMUGZsM0tDemFJSlg5RjhMTmxaK0ZqY0RIQ1JrSks3WmViZFdJQ1lP?=
 =?utf-8?B?YjZqNFVmcFRPcy9MdXZldkNQWVc0OE04c3g4MWlySWsvRU9uVE1WcTNvQVVD?=
 =?utf-8?B?L0E2MFNwQUpuTzJWNGxubE41NGx4TVNhbWJmT3VoTHI4SGpvU0JhejJWUk1H?=
 =?utf-8?B?eHhXOXRaQzY1SzZTQU5ZdVRoTzUybml3ZVh3cml5aGVIYVJjc0ZIVmdpdFRE?=
 =?utf-8?B?QldGaExoNTA0WHIrQ0huS2c5czZiQ2NqMnFISC9ZdHpPQjZmSk5IRUxXenZa?=
 =?utf-8?B?aEpjRWx3SjJpYURTZnRCZXVGL21BRW5RSDRLSi95b29ORkNPUzVqUi9ISDNJ?=
 =?utf-8?B?YVNHU0lNU3p0YzNoV3hwTkNsMFdhenJPd3hkcmNYTC9EdlhnQk5hOGdTOXE3?=
 =?utf-8?B?dmVnMWtYRVpFRnE4d29aK3JXckw2L0JzYXB4bUpsVmpBaEpiNlZqNFVVMVls?=
 =?utf-8?B?UkhLRFlZZnlEbTFKNm5FMnhUeFY4Q29kRFBOdWQzbUFveVdkSTlXdUNFNWM4?=
 =?utf-8?B?SGdqdTlGL1pGRWRSY25WUWtKZHN3VnJrZVplYU4rVjRqM2NlM0FZWHluNGNC?=
 =?utf-8?B?ME9keENMdTJRRmN3V2x6TVdudFZ5M29tU29UaXVwbmZLaUllcGJaN1pGNG4z?=
 =?utf-8?B?T2VTaCt1RTNnV1Qwa011NGZuR1BuS1pWU0wvU3Zwd0MzK3lQRWJSM2l4M1hy?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39623b51-3753-4091-fd84-08ddc9fcfc0a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:24:15.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVkywtpHP5vbYlW6FlYfKkcIqV8bQdejdvNgC0z2IlsFtjdCewNbXsGId70X7cFIGxtXIX4GLHNIGicoJlsGrEiUK++NA7QaVAHyLvu6p/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-OriginatorOrg: intel.com

Koralahalli Channabasappa, Smita wrote:
[..]
> That said, I'm still evaluating better options to more robustly 
> coordinate probe ordering between cxl_acpi, cxl_port, cxl_mem and 
> cxl_region and looking for suggestions here.

I never quite understood the arguments around why
wait_for_device_probe() does not work, but I did find a bug in my prior
thinking on the way towards this RFC [1]. The misunderstanding was that
MODULE_SOFTDEP() only guarantees that the module gets loaded eventually,
but it does not guarantee that the softdep has completed init before the
caller performs its own init.

It works sometimes, and that is probably what misled me about that
contract. request_module() is synchronous. With that in place I now see
what wait_for_device_probe() does the right thing. It flushes cxl_pci
attach for devices present at boot, and all follow-on probe work gets
flushed as well.

With that in hand the RFC now has a stable quiesce point to walk the CXL
topology and make decisions. The RFC is effectively a fix for platforms
where CXL loses the MODULE_SOFTDEP() race.

[1]: http://lore.kernel.org/68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch

