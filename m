Return-Path: <linux-fsdevel+bounces-35609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2B29D6573
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 22:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7681615D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E3217D341;
	Fri, 22 Nov 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cql9YvyL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D81CA9C;
	Fri, 22 Nov 2024 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732312132; cv=fail; b=BqCbsuojULZ0ubWhDlDSg4kOU+BkStmoIwUafYso7jB8R/WkE70PyuNy6asWIvHKaqKB5hvEixHYKq1//zRTGwz1vlJP6/3fPTwrRm+FaDJ7rGrVqdeQIvIswHLb1+ohTVHMs1fzaMOVhkbfgNkvxySA5akHNo/pVgivEW1B0Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732312132; c=relaxed/simple;
	bh=PoKQd3M0dhTjpFk7RN+ukD8qcViK7Zx74sLf6sl6HXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zx7BBP4jJw9z1AHOWiHd+AkD3BUAusdJ6zO07TJtWPZCnBVm5qMvSGy7rYFedLmLXA9ZuH7S7ZhCwtWHt9LbFwYMo4MeayfGbZOf/r8atIpkLYT9QhP2xsTcJVOxvzerkDNSckw+Cs6V4Q0VqD1WuDxn3T2MqAxQlGKreE9PgPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cql9YvyL; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732312131; x=1763848131;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PoKQd3M0dhTjpFk7RN+ukD8qcViK7Zx74sLf6sl6HXo=;
  b=Cql9YvyL8J70Mg7l/XdM5Paeazfdrve2IJMqJ5Yd44tXfULXngJwbMeN
   HaJCnA50rUol5/O3Nn3BAq6+xixPvs7RljPCtBGNlOuOKDe0M7SXKkcPh
   fatNsWtXab0dz4bMukU/Kdj1FjZV/qgtV2Stlk3G/CZpe0orkFxVNb9ad
   R6F8RFyKIr4Fus69hTuziCLXx+KvpTCl5aYN2G8FiL/1o/REz2AiV8lnh
   B0hLxmafl5S5geRK+K2EZGo9/cz9Jth8CDQ4L015ZKPRq1dmjI5GP7y9x
   dKqZT1wJ50QNGTUcyl2MQ9IO9TzTrld1/cZn19kotyEUMllFKTsQSVG5x
   Q==;
X-CSE-ConnectionGUID: 4ZRqrOCaRICjdYfMjaLMrg==
X-CSE-MsgGUID: yWiEKdLARAKpR98KgyHA1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="31840970"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="31840970"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:48:49 -0800
X-CSE-ConnectionGUID: JmbcAtmuSGKu0ZcL4SjhZw==
X-CSE-MsgGUID: 73h0PxSETXyCGem2ob96Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="128190753"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 13:48:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 13:48:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 13:48:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 13:48:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZqU6jzi1B7/BpRsgdJHa2SI8MD39urLMV7yV9Zkl4TCxPF/ysraItNvNpivsVrLeWsiLrF6x4B4gvRv69FNW9i5SKmuP45x2N0JRfeMPkBgi3nXP/QjmAVS9eQqvHhotlRskDm8tVxBo1BG3u7dzLN/Fzo25Ta3ISysmj+Xm9Nb5hFJubbm/t5pdjjF231KYjcZfLgf0IRcxJV36Y0VepVIyE9/PCSMOGgxs3GC5/WE+GzisPoptDA2rD839VyAeWtvN8rgCTga7R1ClJa4SfkQBCbEvg3YTufIVcj180rZu9Q0l2U3rnn4TSYUUKR//iUf9zfr6jFmdwlzbFiFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amZw5f4l2r5tpOyL/8d2BbCTqfnnNP05dStK/tollj0=;
 b=vWfKqH8HNk8EjRqHeImXB0sujViEvntRJ2qcV3mkIkZSdAKUO7oIInvflmfTg4rurGEy+/YkCb4FBk14frjh6L2uZlpn6iC8iM7vjmCrrjc909hbp8VfgIpRbWHbWGGgZLfIoV4p/KJSxInkOnk281pRMOxYUSSMqQM18ZFV759kbjvTg+gtpBQwiVhvpfeTYMAzyH4xorT4F6G2bn+80W/LZ8KM7L9241ibIQtKQ8mI9+24djbeLw3trp60DGFX/x6bRcZFPnUzaLwDyZMvjliYEr6vW2nwZixgg/PwPQVMLFV2DPIUuNrtnnZ67B2SChQxw9jSojjOSASTerXZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7338.namprd11.prod.outlook.com (2603:10b6:930:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Fri, 22 Nov
 2024 21:48:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 21:48:45 +0000
Date: Fri, 22 Nov 2024 13:48:42 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>, Michal Hocko
	<mhocko@suse.com>
CC: Dave Chinner <david@fromorbit.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Yafang Shao
	<laoar.shao@gmail.com>, <jack@suse.cz>, Christian Brauner
	<brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
	<serge@hallyn.com>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-bcachefs@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maintainers@linux.kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <6740fc3aabec0_5eb129497@dwillia2-xfh.jf.intel.com.notmuch>
References: <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
X-ClientProxiedBy: MW4PR04CA0379.namprd04.prod.outlook.com
 (2603:10b6:303:81::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: c75f5b1c-d487-4e85-8d11-08dd0b3f7070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T3XSSS3xDkBXfsUjvwMzQ6kjJMY9PyGzSdUTDDCK76w7m2ZZ023lLkON6sus?=
 =?us-ascii?Q?lxYv2YKy6CLl45g4z10vNqKYvoDwv2GHpGWd1X6JeObgtZqDr/NMb8S9ibg3?=
 =?us-ascii?Q?BKydLb0JeykB1xcsUD2XNJqNbncTkXImyjIG1Fnwvzp/kFLszAQ4o3WkuI85?=
 =?us-ascii?Q?1OC/gV0UzjSANm3RbwOmaSAZ4jrDIZI02mnVaaC3FS/jVyMjMFmCfLJgQO1B?=
 =?us-ascii?Q?MQ/ve+k87bwnvXdEjn2d8BwKGw5UW04nu8Y8HWsQQMfBNZFxK0O0zYtHDzO/?=
 =?us-ascii?Q?v6vp5tBta8+nZWaO2PhL4WNLA+bbQpx96iVmcUEIcXhE9/6tItcWs7WxRqhB?=
 =?us-ascii?Q?aAnvnguDOydb3oH1pQP3MIFndEG4LWAOhUulozhCMF8x1cdntec12WBbBwSv?=
 =?us-ascii?Q?Pt4L9rGwyr1lU8jb+UjUWeJUD7r3lbvJt4jT2T3qcBfsa0hffP5mkDmUaZMz?=
 =?us-ascii?Q?CU/vqoDUNnvU3fAJ9iwQPrzHUd/RNXmM7IcUehAgcuKe1wO673OJC8bmDZjV?=
 =?us-ascii?Q?drxKSG5JDTFqQ4qjQCUnSs5UjbizpMa2C4bEB5vMMT9PyT1NAwjmorS8kqL/?=
 =?us-ascii?Q?clgcF0m09xQyEA9OpWVzqvGTfUhGbqn0NaunZL+ddDttfriZkQEEGNO0hAe9?=
 =?us-ascii?Q?AaKpVHS1Qd84disGCkouUJ2xTBQ760kq7B8eygxpVBtLAt0IR+DYXucb3QQW?=
 =?us-ascii?Q?bCiHr0Wt+K9oVp3WaViQ69T7AJy2FLjqNKXJMFJ068RCpz/ITMCbQMNbJhsH?=
 =?us-ascii?Q?fSu/kSKXc88xHg5I0XaZ9QWGmSTEDSXjcYVseZUqTC0j6Z/iFv4jvJ6iJpnT?=
 =?us-ascii?Q?rrnNy3rMm0PE8TKWIf+xOAzD8KkoD8yHyYzPRu6J2BW7n7YG3bzB7Ao5NO7X?=
 =?us-ascii?Q?QsnJ0DqI5Tw6xvHcqX13TcYepRek4DCJZPklzWx0KXrMzyumNsR8oakgpXZt?=
 =?us-ascii?Q?79OuiFuVjmuQUpTV7LR/V0ugtqom4ldAaGSY/qxXq+F5LW1Jv0f3okyvseAA?=
 =?us-ascii?Q?5zQcAmN+ybPJNUjv35KahlbAJGZSWBcUCfTawH1+d2m/IghohmFIr+xsmVW8?=
 =?us-ascii?Q?xKNCWNw55Sc/xGOf0O+y9RQr4QgTDnmxvtO4FxddnIN3NiPNdd2L1BGDu6fw?=
 =?us-ascii?Q?lxfXIORYWEjYOga+P2B/qNlCoB9walGcYoH52IWRs4rsKjOVKhJGNCl0Z4kP?=
 =?us-ascii?Q?Ze24sMhVl9smsGKw80E5yhuZLgglLBTY6Yx79e0bG9nMamJdUkqb8VrWDpFz?=
 =?us-ascii?Q?cv7I5LTzTD8uC5iogAB7J5pVeazyxTBZlKYCRCHSvg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5rTVaqSs9aj1IwR2iXLCBcBtdepN4eZzOi67e8WHss2JPgadCZXRVsmKi5z?=
 =?us-ascii?Q?GiSwdnZgby64EwSEJCyNp/WNgkcpX/6eC9uqt3lXvyrxQuwA4/dADdvFKV6x?=
 =?us-ascii?Q?WDpGyzRX8BBtVOc8CM9tnJOpjHCHzhrfQaoVISmz4ctlbjFlZJOYP3e8uWgQ?=
 =?us-ascii?Q?9axHsn+T9BHykavxYMI4cknT15x5lRkyhmUPSzP+kCl5mRcw5guJO6wG6/XB?=
 =?us-ascii?Q?Cn4DnufX8oHf5020OiTMFi0Wg0P5cWv1FKDWrHbCRMFIy54DCsi5hG838LOq?=
 =?us-ascii?Q?5Wj5zgHbPR2xkgJYLH5B49wBcfw8JCBBCeystKJJLNC6cFPqtnVkELaXKYmx?=
 =?us-ascii?Q?RjSvbhzkIQvjmBGUv/MHkzqRvUpErKnTaZVwmFwOEoEMjBmF9yW7AQzpQ4fh?=
 =?us-ascii?Q?rdORwaxEqND2NQKRq9/W3Z2WjMvnFbgfqco9wcKQ1w5Jobz+T+WhK5GeaEqQ?=
 =?us-ascii?Q?sxZihx0wk+RxzJAR88MALUBJEdKj1ubrqCP9tjerp8BzZ97VVuOzD0g/Ca9z?=
 =?us-ascii?Q?1voSN+BIWpGj3Zi5CsGAxLqpxSztPrKPn0Xog26hVOe5Vml2Xns11YK8VKQK?=
 =?us-ascii?Q?eTLEpr0yrD3s7YrU+mbHXqNaZMyt8Zz5q+p8m9KiLOZGYcezgLvupaLBptgD?=
 =?us-ascii?Q?ju4c6orFuzr3z3bRFSULJEqs1i2Lglm3hhXMPz/6BajFj1rXXh9oZNrn2ZqN?=
 =?us-ascii?Q?B/YWXNAeawTMDJffCLAoNMlLGlabo054BpeJCldbMbYgm4VqEhaTnDqPGrrs?=
 =?us-ascii?Q?aK1VzsQfaRc5YPLPRSry56/Oz1+3vplbIW5VOseyjWd2q+uSAcoApecklAJ3?=
 =?us-ascii?Q?G8zpajkfwW5GaP3LDu86/H3TLk/h+o5B8/edStUwiXFm2hZ6Zw3S4kntx9py?=
 =?us-ascii?Q?aI8eC4cR6Zn9H2UvQNbhljG8XyfDmXcDQJcUkJpfqK1DL9Q5UsNZa4+JRp9D?=
 =?us-ascii?Q?ZcUu07jqSXLQObWYtjaUglW2aWAFzASlSyMFRftSKk2iTSWgyyflhsRf+XCM?=
 =?us-ascii?Q?jfX3eBGMPikJc2nxHLkrthX2piGjbLM8sx0vK+YFxt7wLs0+t1ODzjJLV0yJ?=
 =?us-ascii?Q?WyQMAnd9KW23rJ1MKIVBN5Crq7Nda5OHquNTPuqvMpiVdov0T5Ot2idVpBP2?=
 =?us-ascii?Q?C49qe+zWsuw196/jzE8vo2EwslEWCgb6AgnuxTKaL2oTOE17GIUgBPYSlYS3?=
 =?us-ascii?Q?a51hRH+crtq2BqMvG8BczNR+lsojYPggA0bDJttB+ykHHCUtR55rmHGx3Iwu?=
 =?us-ascii?Q?H6KSTHVvqlYEKe5wttBi4NuIOEkuNY4HQzMMpea7bLmBXIfTlhD3ywAD54YV?=
 =?us-ascii?Q?17YlaUdkdAFKtwemqDoYk6IlAsXxYAqCNpK8Dx3LCvLew7lqocwWP98Fi6xo?=
 =?us-ascii?Q?PInLidujo4VH1Zp725dJOdWN1qzSjGyv+gbqDjuoO50Xv94MjSM0l1Z30nC6?=
 =?us-ascii?Q?W4Pz0yDZvlBfRqcWVHBOsk+ufcYsXmIGmdGi2WCCJwKEuS9ZZvceLLVlZdZp?=
 =?us-ascii?Q?n6DfAYADwKhLwyS5tPBVNv+BhdvMViCPTjerSgm6lzR/fzEpw6jNpKDXeWZW?=
 =?us-ascii?Q?DOVRvr7tb0SHmo8bfai6MoooancIyfY54Ju6XY2IfakFWSftRpznJ/XByYx2?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c75f5b1c-d487-4e85-8d11-08dd0b3f7070
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 21:48:45.6628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOYSeA7x8huse/oEPGYk5zvcR61Nn8V3AEm28/Bt0xIusQhg5TjyNiQeYChi0Lc2xl9FntQPfU4IzVBoPS6SaXbpJTQBcs8RYSF44vWjVKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7338
X-OriginatorOrg: intel.com

Kent Overstreet wrote:
> On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
> > On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> > > On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > > > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
[..]

Kent,

The Code of Conduct Committee received reports about your conduct in
this email discussion.

Link to email where the violation took place:

https://lore.kernel.org/citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk

Our community works on trust and respect and has agreed to abide by the
Code of Conduct:

Reference: https://docs.kernel.org/process/code-of-conduct.html

The code of Conduct Committee has determined that your written abuse
of another community member required action on your part to repair the
damage to the individual and the community. You took insufficient action
to restore the community's faith in having otherwise productive technical
discussions without the fear of personal attacks.

Following the Code of Conduct Interpretation process the TAB has approved
has approved the following recommendation:

-- Restrict Kent Overstreet's participation in the kernel development
   process during the Linux 6.13 kernel development cycle.

       - Scope: Decline all pull requests from Kent Overstreet during
         the Linux 6.13 kernel development cycle.

