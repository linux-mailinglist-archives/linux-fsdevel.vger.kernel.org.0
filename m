Return-Path: <linux-fsdevel+bounces-46225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E1A84CA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 21:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A318E1B60EB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2370F28EA68;
	Thu, 10 Apr 2025 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1n+8tTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EC28D83E;
	Thu, 10 Apr 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312363; cv=fail; b=dzUYsp0HPo6oaWfU7Q3WePFQpS1zR+NThs/M4t1aPZWIU68Zy1wnbNSaDdOCntdPZorInL3bvCFWpHOy+hAxDWMr7EJc/tFlAnI0NEhbcxRaHqE3ecthw83p+h+zoNQo/L/vIPJLYJBwTa+uTuZDY1N5mAZIc/Rc1qtgt64WImg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312363; c=relaxed/simple;
	bh=O/6t2p7+mcOuJubA9htr19OPK1AHyhQx9AZCpMP0lwc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oS5GSEzz/pm3Q8zXhM07Xm8oJZTt3GeEOTMpJBzQwLbp6ySm9WRNEcvlC1g8raI/48MHvpFLzBKVwiCq6QZbNE5KUVeamD+BMSHdxtOnok5UhTK9AvPUtvKV6guNfVKMzhuHTh61t98x2qrPCblrPzY5CLI+hTtj0BISxf5dkTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1n+8tTT; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744312362; x=1775848362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O/6t2p7+mcOuJubA9htr19OPK1AHyhQx9AZCpMP0lwc=;
  b=b1n+8tTTJfTi+Sz60mUxleEcsbuZ6kmoGno8zQ0Z21u50Hd5/vxcpDDX
   unI4jfChnZGKp8+ea64x0P6Pkoel1B+jz9EqNh8cOyTESaprepnE8xNuH
   Of+O0ZU0uM3ci7yz47qvkjRYSohDqUJ5UtU1RSC2VsKpfIVwGzq4BMx8r
   3AE6nnQKkao6RqV9rUUBBmWkN2gqXjChsUEb+LAB8ROmOoqMwzgMTxuk4
   DnVmAw60BaghfjSCxqWHTI6XNDcmGbOGflF6N0iQHEK4jV/MB10z6djAI
   IHXl9bso461fvWEaCO7rEg8JYDJN+ngSajhM04M3vF4KJky3x6xAETvPf
   A==;
X-CSE-ConnectionGUID: GV63mCt6RrWG/CwbiYxgrg==
X-CSE-MsgGUID: uuV97qdJScqDoX+buh4zfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56032807"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="56032807"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 12:12:41 -0700
X-CSE-ConnectionGUID: 6QSLpbGUTv+0fTi7jdvoig==
X-CSE-MsgGUID: lWcMKykuSrKlQAWtHePLUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133853872"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 12:12:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:12:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 12:12:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 12:12:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy8FTkJCoACHCZrQAXwejSlnljFAf9j3zpyWy32Iw/FBQv/9HgLmxwyPIvoCFtVg13SNuqX36B5sf/kXZXcpGE3OCi8lP0ig1jJ9uKdjewxV1ItqHBih0a9A+9cDChuJlF8rZdT9BpltsELeF4CGhdVEgKZdr/uBoymdFusjT/6V/5RAfpWr0Hu/Dz1vHOl74m5mlwI3ge4NXbMkX8LnixRGVL5DFH3HdPd+SFDjBAAPS148JoqFV1ILf3jMvW/qBGmU9EQ7+6NZH4Q4XOG+FoUeg6XVGfnD+W7fWSQr+hJoBJz308m1qutyJPz9QsrHzM5ts8ni17M5LNSP7WaMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/6t2p7+mcOuJubA9htr19OPK1AHyhQx9AZCpMP0lwc=;
 b=Z9BsKoZwi03jnqL1dvzJp5ht091Iw/jZA/vi5lbm4qFrPEowtXss2vXJ5VDhKcKkqVrDBjTsJmUFHnC4jjP/kEWri3UNDsvZcwTr5JnVES2a+0dThfQhyQ/WiMlGbVdDwAhvFMnrR6brB0BV9teo5ZGiFNAR3gq5G1E5ovn5O9rWyhc8PO32OzGAETG4nOEVroDD8S1kL9e/86Hp21G30z7VATq9BZYlCDYzuJMb2kgcM2TbTPSvLZs5oNAEJUqyL55VbrrPOHdBzgwzh+ysCf7KtPz/WcdpEJD9Eh4+W0ZxtOizKjJtNmF5QpkhUMKs5dVOw5cisBITL0iJ6jVtLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 19:12:37 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 19:12:37 +0000
Date: Thu, 10 Apr 2025 12:12:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: David Hildenbrand <david@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Alistair
 Popple" <apopple@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] fs/dax: fix folio splitting issue by resetting old
 folio order + _nr_pages
Message-ID: <Z_gYIU7Nq-YDYnc7@aschofie-mobl2.lan>
References: <20250410091020.119116-1-david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250410091020.119116-1-david@redhat.com>
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|IA0PR11MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: c44f0fe8-8c09-4c6c-e371-08dd7863a802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NreU9QDqinrw+4MR3r7Hw592U1iyk6BvQYAyk3mGvMU7JKua7Vt0FVzcf1mO?=
 =?us-ascii?Q?Sf82W/Cob9YzXzx6qjEHFTEjNr7q6xjFgFrRIUXzD8l7meVkhs177pSSmhzr?=
 =?us-ascii?Q?rBUA90wMcoVbwMHVBRmLHJGFZsNCU/fo7+X4H7PEbJaXBjqdfIIMavOq1RyQ?=
 =?us-ascii?Q?7dBAlDqQ5AzBClw26ftR/P6jCBb8tEOtFo127wl0npgYoBJrh19V6DmlDoBW?=
 =?us-ascii?Q?XDdV3fpvI55fLYnCZI2rjV6uKMibsA509x8yUS4JOOUk8INWYL2q4fUgFFy7?=
 =?us-ascii?Q?yR11wps0+soiQpZnhR7xLFG0BhiXFF+RCSfGHjvMPnmvn+WcSS5+Tm0g+iHJ?=
 =?us-ascii?Q?4xCd15Hr9+seonxdGGaewiBMi+rzb01j7SIA2ipDkI/9aNnIanO80x09j2bw?=
 =?us-ascii?Q?OqKyZpAQIHpRL+j/vXcECUo9IL2lOhQy8VMT8WW7n13Vjs86N7Cn8yz4+zbL?=
 =?us-ascii?Q?/XGj+RUcbg7QGSBcFFNR2vnuSZIkqyRvwhR2doKSf8fxynXdjcb9zz32A657?=
 =?us-ascii?Q?GP2SWn49+IQnnQIS+kU4bw/yKPOy9Imoqy4c0kpH9olL3FpTD/QOC0QIijfb?=
 =?us-ascii?Q?LDboc5GjowlXqMBPOccaUHXD8qV6wc3vv5JCcsHjU7SPij83AUne5lRn2gQ+?=
 =?us-ascii?Q?+Q0nGVfbDitlLOhZRVUNFDlEaL+ynMUlEq9N9BWXdu9SkWCc3LOIS19VFyDW?=
 =?us-ascii?Q?nGh+VZhha+00ZVg8IFAptV0pGLbNdwdtKSX8DbWPghwxDMZfmhQkzP/qwkU/?=
 =?us-ascii?Q?GwZNASrMU3p7ab0Kb4tHoMCSlQ1WXhzspAmFkk+Dt+Id5UYsShLoxxQPN37r?=
 =?us-ascii?Q?D0/Y/lxK7Ev/VJqo9mfJQh2UQXaICobrj2ucb4gbsYw7N0Z+RtzgoPPM7oIj?=
 =?us-ascii?Q?BI2U2UOvaGFTkdoH7/esiM8KU5xUtdxH3yYsgZALMw/yaD43IVjvkGJiqsuZ?=
 =?us-ascii?Q?fciU6+7cxu8jrgbf9YsNBpatTBRGbtQ05L/g2vvSZwAene5M430VSPLDesh/?=
 =?us-ascii?Q?3UTaPYm/Jl2QLi6CDY18ucMcN74QsA/gqUQyJvVw+FhDSZawz5CFx/bFC26/?=
 =?us-ascii?Q?R8fCsJqKajftH82ME8cBZ7IT2Pz4ZXpwaa/6rlr0Eng38MMnq5OOvuhr8ubY?=
 =?us-ascii?Q?kA0a2Ibm+qxWGCRkcjzmhrXsSKRie7VLelKlsH/u6axkMyUwjeHRIiGEQDei?=
 =?us-ascii?Q?Jm6LhpccRR7xEUEzxH/9kA72OTxTWcHY2PcjWa4vhjdY8gpy+KwJ8bTEGAWZ?=
 =?us-ascii?Q?1NT9uC7oYStiDFCSg2r6Uxba1g+o8RR0R4uzdb67kCfhmOhwZRjyDClptYx3?=
 =?us-ascii?Q?ekRIBrw+FaEqnKtBPWYKEtVvgx6h0ljONAI7nbObDAVJGcsAuJLIOCpeZLQJ?=
 =?us-ascii?Q?Zt9Z9FdsJLPIQkqa2+JYuIZisKjWEa4pF6chSIH+/W7XDK2M0i4FtUSf3zmI?=
 =?us-ascii?Q?WNZS6CTUX3k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVqVjheYjFr96Qq0hOjIyPlxVJ5BXJ1/cs8qffmJl488VVgSqKvk7VOYjez2?=
 =?us-ascii?Q?yO0LSWugQqGTvSEZ6Lo07rrMDncs/OgP3IcPk7l4YdRYhjdWkdIODACzj2aJ?=
 =?us-ascii?Q?e5vRfX+BfhWVVJYsmuBXb0xeOGis3cFECXX6rm8O113UuGDGwYrRVq/QkuQf?=
 =?us-ascii?Q?kRirzFV1ErvR58nU8Imb3Ir9+Qw3+wfeI5sZsznPhlShJRGoLrZWgIetz9Pd?=
 =?us-ascii?Q?CD6Dx9ZjBChxXqOZ78t4VID2U/EOjNt8QuyLoAvexMXv12OUnfvVLNrc33DO?=
 =?us-ascii?Q?dDmQrmhDNMvxWaizcFf/xOJBIpo7sW6hqG387UAaOHhkWrZjnFjnHoA4yyu5?=
 =?us-ascii?Q?qqCrnfIv/CJ2SP8MnQkKQBgVFa/MPagGh04KhIB/Mc4sXdGvAIM4aOYTsDFU?=
 =?us-ascii?Q?ptRyCgfcf283mdliJTiPr3mq/duVAq7VuLe2UHz4pxy3dY4FP4/bSe89NQgz?=
 =?us-ascii?Q?MrMJVFkGby1p4pZtCJ7CWsualg4WwDok18qy/TISyedV5fBMskLgVgx97ux3?=
 =?us-ascii?Q?FgbBrAs7rmTRSrxfGv1AhBHd3gP1EsKmWNIhVIS+2yuXgDbqbbtKh2qxE03m?=
 =?us-ascii?Q?g759oP3TRVq2IiWLMpMVCVVXxRPf6apqKdfHwV1LtIKmWE1aGj+Z209MeTZt?=
 =?us-ascii?Q?/RPW5wYFApUda+apCybHPlZKscFEF5aWBomDqsYPdLgTU8SpRm5ghSDb9iOm?=
 =?us-ascii?Q?vqzMyqg9IC0ekL7Veoli5aYdq8g67wX2hIazYvckg+HHy9g3TcTk1fXj8j7L?=
 =?us-ascii?Q?ZtmX8TOm3KUBi2NBTospJW6lm3iEdTSbbfDaw78ZL70ilSY6eWMVCm+q5deV?=
 =?us-ascii?Q?k0BFviX3bpMUCs5sx5+0H9L2jFhsLebGat6EVzkEL8UyXCcMnA6Xb8utWaRK?=
 =?us-ascii?Q?eeWE7E2fQVQrXsvIQGzQnZ6K4aaocznJnUrHv+wpqUhhMtxVPNaw6tkAwlMA?=
 =?us-ascii?Q?Y317WTGDcSXZBcH1kCojrVhaXuajQdlppelb9FpwaNwij7xE6NtGGjRFKOsu?=
 =?us-ascii?Q?ZZyEkkqXyL68oBRiUQwJ/nA1Aev6jshInELNxQMKVlnddf4mSYf6nXH5AVEX?=
 =?us-ascii?Q?iANFny6k6wkkZXbefx6NT5qRD1YUC2e20Wa61DG+OTClNoPfOc5bMBRUxpTG?=
 =?us-ascii?Q?CXLWeUwKDiNGsA6BKuqTqiDazSD+kSARUf60Z3EWAMzhZLNOd6MTgSQ+gmMe?=
 =?us-ascii?Q?lphrzHplFR87AnCydJ0HwlSYqAi8x8HOmEiYqphMucH6I3geH3jFV/um2uZy?=
 =?us-ascii?Q?MzdN+Htu2UrN7RXIBuG2PPW2qkNHW4PnDCAAr27pB9ZpJCb1vT2JpUQjZzmt?=
 =?us-ascii?Q?NnyeYnDk96xzfYTCApQdDLRR5LwNHNJYuPLTVQmOb9ZVYpiBvApok7bvOh3Q?=
 =?us-ascii?Q?x499LrsvF7tjoP504idCd0EMijwjp9dV3wyf+/19y0hCZDq4lWwiMgV26+xX?=
 =?us-ascii?Q?3ugxMW+VL4SvDZUbJdrmBML2O7Vy4I9OPkSVNKCs9Yb6oyaOZYM0aC0Nsxwk?=
 =?us-ascii?Q?7A7p3g96DhkjQZQ8PSZr9r8sH7EUUgSLVdUco9iHhILoEoXXj37CoGZ9RQ2n?=
 =?us-ascii?Q?DSPoxzRyWDHqQcK4zKtagkbpBzKr76awOzEMFgXXggLRPZT8CG2WtDQKpMiD?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c44f0fe8-8c09-4c6c-e371-08dd7863a802
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:12:37.4592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUDhb6TXtQAE4Y9KspfpZ3V94l3qc3+vaZiQK68nFmIca39KYdWwzUIzxkfcnKsGkvWY6ZF39B2vcaba2f0up4XhteQjL74pi/yv0npv2C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7283
X-OriginatorOrg: intel.com

On Thu, Apr 10, 2025 at 11:10:20AM +0200, David Hildenbrand wrote:
> Alison reports an issue with fsdax when large extends end up using
> large ZONE_DEVICE folios:
>

Passes the ndctl/dax unit tests.

Tested-by: Alison Schofield <alison.schofield@intel.com>

snip


