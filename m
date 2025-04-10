Return-Path: <linux-fsdevel+bounces-46232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06F7A84E5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D3C9A6E34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F92900AF;
	Thu, 10 Apr 2025 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7+bKMRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9A4C8F;
	Thu, 10 Apr 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317978; cv=fail; b=n1LOB6k/bHTGKvnuBAi37bf3OuF1pevMuDzxSibzGt8FRW5SCLAdr+NSDyJsenWJfpemhXj61Y+SZmZ1Zm4R5lvt/sTAIHG0Wk/h0LLjZ2lm8F9VGS93rOyNVavHr5WN7PLEquzOYAj8EnTaE9DQpfS/m2snQytEDSxNHPBYEOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317978; c=relaxed/simple;
	bh=KuJIJhJNhoYb3btLR/UeULCEDtRTiQBQFIEqFnBBXmc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AHEEw8ESUinTnsFfraRstzH/epWkQRF/C7aYBYnSOy7uphjLYOv1yTUaVmv8C/Gnm6YxQkCyDpyQPHcPqXsvNWhHnBTemJMieCmpvg876rZlI5TTDTvpoorgC+BWi4TGOdIdFe8/QWzLNII63FnwCnSYa2R1N6t5XF+K/V3iyHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7+bKMRx; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744317976; x=1775853976;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KuJIJhJNhoYb3btLR/UeULCEDtRTiQBQFIEqFnBBXmc=;
  b=L7+bKMRx+HxukU2mO+BzCkMUe5Mazv5ea1l03sAo8Ok3vNkSY+t/Ckv+
   uSYasWxBNJU2jZ3p2U9jletCSOucwOAH5/njD5USuBAEm7X7aaW7hFzVK
   q4s4Og2rAMnfjYXOTScv9GXXGlJkidbtQNBrZEEA63leAgUF8j8h1ZkUf
   OakjmV0BLne8HmwnEi/irLWK8ldtphakojKqGOvBxKAlCljKELet4lp3t
   CrAawYfgonW4ettcXyniwdSU5bDO5KRW8+YP1DzbAy2da6q1OfVDSwp45
   FajfMfeT9C875ozyo6cydHKwNMJSdzucJak2eMZZTS8pGnE0+mGvtRHoe
   g==;
X-CSE-ConnectionGUID: t3A3TAU/RMqkMsO2wiWZ1w==
X-CSE-MsgGUID: 8/rzlTOyT4KrzaQuhN2qJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45988930"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45988930"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 13:46:15 -0700
X-CSE-ConnectionGUID: tZ2v+B7VQ7Cfu5EIXaD9lQ==
X-CSE-MsgGUID: b5ufUSQsQVmWx8vdnKHVvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="128777507"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 13:46:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 13:46:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 13:46:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 13:46:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXnHHegEiP5rUZYNjXNLU+3+p+581oIq3t71hDFLyqm4D8+ur+F0peZJvwNOf83iX0IAZXsqDOzlMYw/+HgMrM7DCPC4U8mfFnmCsBMZQLvfELS79nkuf+9+xUTnqkh/a62+mL0o43X7WJnte2APG9xqfFLfRWTti9AWehMfOWqI5Ou21KNpPqvffP2f5SvFmgoBQWEoohgg210u2NBiPnQPhUpG25a7cnzopplJeeZOhU2pW3fsEwIi2x+hlNzUQdw2F2jso7dYqoAMleTLM2g8pOHroyXEqjkR7EXuISORXO6ERGPyEi+BaTOJpq802GNJLhGYY2x0qCR0wTuATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVkMltCRAXkhTimOs8gp94FL5sG1pLkUpQVYhN14pYQ=;
 b=TT3X6DjHjzVjIqI6wTVXAks6u/85phxpY21pSgVS5DiGbKe3MonP/XQCzdJ/rz4K0YVGZr5KLatFxAQDgybCyS+F1ceSBds716rUOxrtcuXH3E7hFR2YVsC1va734DiOdziwERPFuJ3+WdWCJ3IK1irxIdvTmSgXtewGrTVemqFLYuz7doeVWA4vjdEZxEgI3/JZZ0qtjxSsopKuH620mhtnt+q8T+PBZdUZ+EcYPZz2Om0EPlzWUpCGcaidvQuMCvN3PJ9ld/BUyF9cZCeFkFXQzT2B/zSGOVYz/zotgyM1nf7jE9irC3ylwL99zfEakOKfz3s6Hu94n0J1OpvIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF0D0CDCDB9.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Thu, 10 Apr
 2025 20:46:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 20:46:09 +0000
Date: Thu, 10 Apr 2025 13:46:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Matthew Wilcox <willy@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, Alison Schofield <alison.schofield@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrew Morton
	<akpm@linux-foundation.org>, Alistair Popple <apopple@nvidia.com>, "Christoph
 Hellwig" <hch@infradead.org>
Subject: Re: [PATCH v1] fs/dax: fix folio splitting issue by resetting old
 folio order + _nr_pages
Message-ID: <67f82e0e234ea_720529471@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250410091020.119116-1-david@redhat.com>
 <67f826cbd874f_72052944e@dwillia2-xfh.jf.intel.com.notmuch>
 <Z_gotADO2ba-Qz9Z@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z_gotADO2ba-Qz9Z@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0351.namprd04.prod.outlook.com
 (2603:10b6:303:8a::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF0D0CDCDB9:EE_
X-MS-Office365-Filtering-Correlation-Id: 83003472-29be-4610-e058-08dd7870b93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S2CTYXPvQHaJcFbNjD1fNwOrT0aD6YgqoJZJNoX1r6ABtFIXM7N89C8OZQUd?=
 =?us-ascii?Q?SQVgzjWY3ns1wRQET1zVAYMU+wDW8aWIaarhtpiscqLRsY2dRlN/jSzVEMwt?=
 =?us-ascii?Q?bNpWebq5AqSZENoGQi26yJLEivTs/Y20jBa9yy5CkC+d5a+ts7ZRKpGWlFSN?=
 =?us-ascii?Q?s1RLa39cPlyh/C03zwM+pGtccC16oqe5axcP2FRdb5beqmMgBNnjfOne7OOE?=
 =?us-ascii?Q?432dqRu5Fp66QO+MqyB6H++PpOQGZrq5x6v9tuOenro2M1XaQOAcQongcb7P?=
 =?us-ascii?Q?nwnK0Sd06ksNhIW2jNdniftyc08cAc4gisbWqr3/NSSdZfRfD7pp4EdksA42?=
 =?us-ascii?Q?LbCBmwlpz2SjgEJx/4eycFWigWX68mIS0dim87afG0jqHlGsaFGgNIfPw0Sb?=
 =?us-ascii?Q?siQo0I3MdKnvge3VSygX1cvqa5VoLytoD0Omg+DMGgc07VljBruBKOQ8ZxXT?=
 =?us-ascii?Q?pGmUqAA3keHCEdhj9Xswipt5Ot+C19OTkfQlahL1SWajUw5E4s2Yj0DRJG6v?=
 =?us-ascii?Q?hVNMSa7Mqprguc/WqLJC8BAfCliAHUSzvJ0pcbKhd+xnzjvMAOvx8tLwa4Of?=
 =?us-ascii?Q?+ngLUaM3/njvIL7TyOHgAGLGzCCq2sXK29LwjyOpYz1fezyCSAyuCiMpcakb?=
 =?us-ascii?Q?NlJKsLenE1ZUR7bk6QyrLV04WLuJNxSH8ynJN/rC9HxVvMV/ovr5y/DucO3/?=
 =?us-ascii?Q?mFKavlcAQO+A+6cqsxKqdWU2Vxaw2ssccbznu5PMAdRK+JyFSCSAuRwFCJHG?=
 =?us-ascii?Q?qPrXEQeiIBzLwG+evc9lYw47FT+H8F5I+Du1ZnfU5me5s3KTrE6VFyhFJ5BF?=
 =?us-ascii?Q?uFmGM0O/SkxbUM51HNrt2146Ck/qbWHdaLPFF68VG76SUQ7A51Sb6MXkxiub?=
 =?us-ascii?Q?QFv/ogD1ogGnG2RYGBbNeprL5P49eVRsPUNxqnxb3RSKxgDgyJ0CF/eWaBL8?=
 =?us-ascii?Q?fA5mKMv0HAN/Dr8TAt+ngLFVtbytpX/a4uV0pI77aI1olO+S38g+8PCgZ4qt?=
 =?us-ascii?Q?ODeuIIhpVx4kbHobaQ1nBuA6e8ptBMQGR1AkJ9FoL+vdUvhgkkwLAl3HJQyl?=
 =?us-ascii?Q?tZ6bcCCQXUld8wm2EBEZS9w7PENFV6HE2IM2tV6qEhdHrAczeq/by3age1QG?=
 =?us-ascii?Q?uuithNWiAQof6f1e1HaPikDiLNs/EeYQ5mgZuJvSbpOIcFEf9RAQ2tDS0xYX?=
 =?us-ascii?Q?UARlY76f8bk66bqMcKlUbE0Pf0YTtesxpU2xFiqy6xAbk49veS+UmBlALe+c?=
 =?us-ascii?Q?3FLR2KKz6BYKK5wS4+gD3fXEkSoT/zkFN/M10B5gEkIw9+lRDCha0cZFJgS5?=
 =?us-ascii?Q?N565qzo74JAN4zHJyNl/AZzCU/VCsYrQ4R9n3TnQy/TNYDjOqzTE1qmxOBCU?=
 =?us-ascii?Q?NSStr3a5wxnYjIOYfpzy2h2dzFjR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wSw26W7Mxs/AEeh/TyNZcAQtJ6/XQn1R3SjqFpfi6Klzc6w2wTOCCp77c0BY?=
 =?us-ascii?Q?BSKy/5hYbZXSix+gIq+zPCsTNM72XoON1OvqnI1SgnfxIZLQiX1xdb/huQkS?=
 =?us-ascii?Q?yNnvQ3WidknUTOHuU58FDmeYzPfUAt8NU3iD64l16SldqUN2f5jGfs5US9Oc?=
 =?us-ascii?Q?CMsL/jOraoKtsd37qqPANLdK2TXHdDyxW9dl6zOPUTvFwF1ohnfKhficr1f5?=
 =?us-ascii?Q?0pb5XGfhl6mmcNSYSm9Dmq9nfSSUKBq1PJ7Z9Rap6JlCd//LktHXGSrGuXOz?=
 =?us-ascii?Q?9x5UQdt2uB6EjPSBCEB0/zLKgPYIffBuJY6527R4s1lBGg45i8kIAZzguumS?=
 =?us-ascii?Q?qInO2llhyuOtrTYM2yKH164zlEPylMUeqrTWMDD27wpQhC3c27Ru13+B192K?=
 =?us-ascii?Q?5fGdMc7nx/XFeQwe1cgwsjGRd3nSZ6NXrYse5RvrYM7sF9bb73yHNpdTGWXQ?=
 =?us-ascii?Q?IY8QryPzizvo4VcFsda9h2E2csubAo0q0ZkqDJX8cNdNeGREn50ve8nMWiV2?=
 =?us-ascii?Q?wvKa70dnBnCfG1dtDx2lwIvDigA1tgTcTgjAMBMQMiNm67F9KVVuMWgHfE9y?=
 =?us-ascii?Q?Db9OQQmQC3H829YFw3GF77V5dHvSnvGY6RMBlzltptiMu7EvPvbhYCacDBip?=
 =?us-ascii?Q?/9Beq81dhrrHKxq44i6Mf6h+hvc0BTKxpoF+joTplxj9hGEBvPRwP9dt7PES?=
 =?us-ascii?Q?8ivWN1ud/kSH3a5Gpx4ztvBBm6VZGB6MoN+aWXqw5dHa7O2L9IjstLnZaVWo?=
 =?us-ascii?Q?6+p6JSOjWojKyJrDfcoy9+H49oXmYJ5ZeuL7G+gln3mSlq5OI5PX7QaZlmli?=
 =?us-ascii?Q?RUCYRwwFDzh9o/k8/tCnScfmRUnadHAO1NOUacVY0HBDRwlgxuGz5xQr9N+x?=
 =?us-ascii?Q?BY7icvGc6sfvVVzGYVKDBgwzZ4KTvgRLfSayy/euc/ADAwbVnbhY8U8oT8zE?=
 =?us-ascii?Q?VCt6GxLgUg5cfrFpOYgzOArdtplQgYU98sJBwcfRSOUhJqgO+JYKqwQyPJvu?=
 =?us-ascii?Q?y1sFCn3tYXMlii2xjbRBql92c/Qo09wrb8l5KNC3ah6ROu4FGfzs8z8VNIBD?=
 =?us-ascii?Q?cNSpaKrzH3hVo4F7MhhRqt+3PcQ15S0eXSgXIazdOGudP3VJwCCRzuFIfyhv?=
 =?us-ascii?Q?4sEdGuXd8vCD2BquX/Yl6ngNUdeOq3HgbqnTdP/NhFlcCTXV0YCyACgEzS+V?=
 =?us-ascii?Q?Eb7i1W+XC76KfOcPOpCcAdeCSZycxtd7CcuJYYQEB14XTC7CkPqN88DCiNYG?=
 =?us-ascii?Q?056J1Ryw9KSd0ekZbor/hA99AoN6IyoeRz/pL3L/mzODwqJcIYkdOYXlNaiA?=
 =?us-ascii?Q?p7sOYLsJqxBHCib5xQJ3Raq+/B0p3l5u2o2JrC4jvttC2iVc5xbT3LXJwY/J?=
 =?us-ascii?Q?PjN9usWBC/sJoPy1dEm4s5uR1fdOMqUI5ytdV82kwlCaMSLQ2A+bAYT3YRaD?=
 =?us-ascii?Q?YhW5ZV3VspspivG8ASoVNbRZCq0Fs4wpHAjajaqSU6cjh0e+/qlSkr455ZBv?=
 =?us-ascii?Q?joAIDrHk0IKCl+2FZqRiv/+vW76zI4GXwOCIlnELLL+ztjqlgYAgp9jXI80a?=
 =?us-ascii?Q?Og8hMTAcFVuhZa2kkLbdUKWp3KzTkP6L1MejA8oqr/coaXzw9aVK+lMueXQG?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83003472-29be-4610-e058-08dd7870b93b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 20:46:09.7546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGExI0LE0O+/DLbbqRk92u29q03KZehG4FITRSo74jp6QNbMtdIJucd0mrWVptcO0+x0SqZpfOZIoiwIAoxp+jynYtxhAASEGKip5sXzllo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0D0CDCDB9
X-OriginatorOrg: intel.com

Matthew Wilcox wrote:
> On Thu, Apr 10, 2025 at 01:15:07PM -0700, Dan Williams wrote:
> > For consistency and clarity what about this incremental change, to make
> > the __split_folio_to_order() path reuse folio_reset_order(), and use
> > typical bitfield helpers for manipulating _flags_1?
> 
> I dislike this intensely.  It obfuscates rather than providing clarity.

I'm used to pushing folks to use bitfield.h in driver land, but will not
push it further here.

What about this hunk?

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a47682d1ab7..301ca9459122 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3404,7 +3404,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 	if (new_order)
 		folio_set_order(folio, new_order);
 	else
-		ClearPageCompound(&folio->page);
+		folio_reset_order(folio);
 }
 
 /*

