Return-Path: <linux-fsdevel+bounces-22602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D47919F5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 08:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C301C21623
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 06:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B401376E0;
	Thu, 27 Jun 2024 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvy5hH2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7F200DE;
	Thu, 27 Jun 2024 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470204; cv=fail; b=tUacmi72Vibbp4mTMfaxiYzGUkrYHWqLXb91L9VK9i+IvoiARt9a732QAUYe1SMNi1wWTiuhWog5KCthNfimeXEBcKp/ZAWBJjwkLp8l4iz4PDWREpX3PBvxwmbYBqRbx+o2nsravojNNDGuC7k+HoE1ovccrLxrsqCPY938ZcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470204; c=relaxed/simple;
	bh=AJ3rt3gGjaRJd9Aj7L41vzbXdPO5Cpq9d86iEsNuNh4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QT3agI5G894LIm3bWJpFlQZF1J+v1usBLNIMWsm/XhDOE7AwMIGjUyAq3fe9TcyTufHBXAWxuwt9+cPvcsO7jqTGm86nwjV4s7+ZNXEidvFHhZshS7JwXAS6KJaWbwawdTbz1JGOmIeiPjoWLG1SKHQ3lIq33e0s4yHEXT9fxi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvy5hH2n; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719470202; x=1751006202;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AJ3rt3gGjaRJd9Aj7L41vzbXdPO5Cpq9d86iEsNuNh4=;
  b=jvy5hH2n2VSRbsPUPWqcQPlKm8yWHcN26SyCC19qJRxy+tVjYZwqEkcN
   Mlj50pQwJAoxNOZTbWT8yMWhKuX4GoYGODQD/cML47KbpF6jCHi/4sQgm
   FTn+jy2j10TKc3ZPp93WOBsfUzvTBGAbf1vHs08Mh7iKxriq4cIiCN2IP
   CzUTdzTKCfTFjQ5xUryZToU2lOY2wCCcSXSCUW3hDmWAvrJ6ZCyYSTxep
   wBhZlbGIGffYP7kuQQYwlHq4U9fJAgB5KFfTrWDh8OaOjoprP0d8Bj5mo
   36poY2E6potOJ44I4hSYpQym1RNvqGXgMOyKza4CVEmuf68pcsEtKi1XB
   g==;
X-CSE-ConnectionGUID: YWzQPZgyREiMZk0B8ykKyQ==
X-CSE-MsgGUID: XtPt0w8eTqOfbOc9EwEedA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27974769"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="27974769"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 23:36:41 -0700
X-CSE-ConnectionGUID: tMsXaOTkQTqOj5bi7peMIA==
X-CSE-MsgGUID: H3WHlpeSTguNTSSeTynlng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="44688386"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 23:36:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 23:36:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 23:36:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 23:36:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 23:36:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0hG2U7m76pUjXSNkJ8BiyMY4WvJ9zAjAW46FOWrGLfz34Pivf1UiQ5J5qfP4Y/EZamncFOpmA9OTxT1aXp2nnc8e5XYZkrgy4fPfICeY1WZnCuC92beTPllMMvqeMqZcDMRoZTDYCtttlO8qo5ufnB8Nxi7DI7lTi76TrZnV8Byvw9ArOv7bejC1KAIYvTWNQZE1PtqqJWVXnb2GAMFlUvflZr9VJo48B3AuUbaGETDLRqvaul70AhEO8/EQBixUXynwhKgqATMJ3fyE5FpyGStmJppzO+AS1IqxjTE215Iz6u1g65TAxrP+AkC3+mrvskv72M/IYf5l03jzEpmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VP6ODylPkQpTLXcZEpgB7ClQJxb3PiaHvnMLAdooLY=;
 b=MqczREiFPmqIvWZWSZAkiWQpUseiU390GLj++TmAy8TdpIZ8gZSyR+orlu82hNbJaJ6IBq0gCrqf4Va1DOKaUtR80ddBhOFtQj4Aqb+KbHNj3Gc4UR9nGlWdsyq6T4y20nmhokion9jUXzj+lcPsn1pp+BGqv0+pbf+j1b3IdbDYb14NKUamRh9tAjJGqD1WHpVD0/x7odDIXnpnUQO1eK+1w+/IWBCjIDAZBA+A8cqPDobaIzi2gYudErATFxuO5eenpQuzY5R8I+XS2885kHjcCxwrx7fpgNeAXZV17RJWWMdgXKBTl1385CM6qsFecyJXLL/RDx3yG7WS0vgCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Thu, 27 Jun
 2024 06:36:32 +0000
Received: from BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::6f9b:50de:e910:9aaa]) by BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::6f9b:50de:e910:9aaa%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 06:36:32 +0000
Date: Wed, 26 Jun 2024 23:36:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
	<bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>, Alistair Popple
	<apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 01/13] mm/gup.c: Remove redundant check for PCI P2PDMA
 page
Message-ID: <667d0861a0e2_5ff42946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <e24726e36a7b8cb39b0d85ebbbbc9ba564dd3a74.1719386613.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e24726e36a7b8cb39b0d85ebbbbc9ba564dd3a74.1719386613.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To LV3SPRMB0083.namprd11.prod.outlook.com
 (2603:10b6:408:291::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR11MB8127:EE_|CY8PR11MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c5f59f-5e86-4a11-453c-08dc96737ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C4cB2Oq0bJtwXHyLLyWoSLCBD3x33mfsBiBy3MepPMn0Y0oNZjbM93PeaS/+?=
 =?us-ascii?Q?WyKYFYzOXj9dlX0TATfcS/wYZji2eABEjpNy5hpP9fQLMI+r5ZQOhHAmRSa4?=
 =?us-ascii?Q?2wHXbzU3qDKZuWcK9rAaPTq3yYlQgt9SZ/vvxMoQXArNNxwz5n+stk5xHyZI?=
 =?us-ascii?Q?ah6XuJxlQwopEhj5NaEuGFzV78K12wHAQZj9mYdagus8+lgHwY8Nlm+kKCEC?=
 =?us-ascii?Q?PYt7cGeFh9BWcF7SP6Xwgkb7DOaDIBbet7lobpMfKduX5KqCgOU4oR9K+P5j?=
 =?us-ascii?Q?t+9ooa6nBrh/JN9HD8SzEfwT7Vgnr7XUrg3fG+hon56Q8N1Jfh5k48RP/aAA?=
 =?us-ascii?Q?KfmYOLtAmpbxi0zNQRkvzyv6j7UI1kbhlCer0rnCZE8H5YWMxe3EWllAzB0B?=
 =?us-ascii?Q?UZcV/2ExBxINOFMEW87nAww3Kayr1/jdLcmCTLiAQ2SmVsu+Ah6g2NlZQ/d6?=
 =?us-ascii?Q?L9RnSQMh64HVXK6ACcNM38fFv5Fz5RcdkjXSpHk/iJSRaDBJDGZwyWNDi/zR?=
 =?us-ascii?Q?wXCrYonVvwKvYzs6NfPruc+Iq6UIrk9Xjka7iGW+lc2Cv0fbsz053m/Muq3g?=
 =?us-ascii?Q?w8IsZRuMXlMBRi6kTcmuulCo5iiY/BtVa8z2nCsja7KhULWmf74StukB1oI/?=
 =?us-ascii?Q?JFg3jTgrgHNJ5HaP/O2bc61aOrgjSHSJo3cA0MlgRQun9lqteTmRf/JYvhSa?=
 =?us-ascii?Q?/FPtoXX+b6EnkRu8jkgfQheI0+zcNu+xbsyRJKr5XiEKuHDEoDwP8LTDy9vp?=
 =?us-ascii?Q?VfLZT4xyasU1cyKVv82JdDtLH6GX8G9XLyWABS9viLLT5aY+TA24b5N57kUF?=
 =?us-ascii?Q?/hPnCw/a5MsT8SPmYf83cAidSNKBrECytY4BR8/AC7LsBNT61fLr15aJKqBe?=
 =?us-ascii?Q?6hjErh+LcVvScC+BBHGu3iTItntK6HaJ3NFB7nidoUuoGtzYNYDXHulo9JUf?=
 =?us-ascii?Q?aCKA2jC/+Bh3gEVlamBr2qxGqR3l8in0qGUbqrj5KAHdpOZoyGk4JH4N20nz?=
 =?us-ascii?Q?3fjXoKCGvbiTmIx4zYtXsqjHZ3pkz7UKnlH4npgI3VhzvEvxYIL1jCtn+tms?=
 =?us-ascii?Q?kmzjIURTSFszLCqyHNX1GMeNK5I4a6dVfqcsQSXYTqiLKzt5BpsFYw8/+w4+?=
 =?us-ascii?Q?UhPIqhmOaQ05VPGrYkiFfmS9b7oMwfva5OVwrSNnuLxJq8kG43RipBJAlnu9?=
 =?us-ascii?Q?7uXjLfCme7TfCm2gLVNtL3fYX9ajAR6rZkCiwuBWsfYe2Z1BemEp7ufpxmxh?=
 =?us-ascii?Q?fPuh6pYz/YUwo2mEltvGj538LdAwGJCED+aMHhL6CD2NV/OfRm2DNCl+jZc1?=
 =?us-ascii?Q?oNN6q7/O4ZSi0zifa4hrsCDAIwlw5sEIASTGxM2lw5I6Tg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR11MB8127.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LsPP8y4B8W/Wb6RQbv5/2OsTApXbknlwHqUbNZeJpt2JWoCF+Vt60V5wRWSm?=
 =?us-ascii?Q?kZBRgro/SaGoMvcSF9wWo1m3LnMHWxARJ3XIOLqwrM2Am2C+VO5H8GrzX3Lt?=
 =?us-ascii?Q?y8N+RQF/n4U5zTx0VZkguIAz9nMNHqPw1KMNEf4zli+TmivR0VyBXqdC09ib?=
 =?us-ascii?Q?M0F2Zvc9vSncezn2wwOe8PLB+j4ZLSJMTo3BPIEgN/SVNEI6ZwKfbUtK5w0G?=
 =?us-ascii?Q?e6uqjsa+91LNw0EXdKLuzGRzRxqdP0LC+FhiwxO/yv0bK5IiTH+xzk29ZVjn?=
 =?us-ascii?Q?BC/ixF8NTi5VDVmZEgh62n5IkGY6WIr0WtLwTIftyMmASoKFkVxqfHwbyLP2?=
 =?us-ascii?Q?cMoe5AadUvWuiFXEO+3bYQDyw3hpPvNwODmyOL80tk1Y7UzMTv7QQ09jwMBz?=
 =?us-ascii?Q?eF+O5sm8PnY4CdnG1jBkzNk6JC9RFCdt/2E8Z6i+wUur8I/GFU7TSlADkCjy?=
 =?us-ascii?Q?yr1KiMDipXIO8UQWoyeO+kSSAq3GZTB+sqyn83+eI3S5RsyBi/DlmwZZtQZL?=
 =?us-ascii?Q?YIBCHSyyZEM4KcfOtBewAFR8sVTzxFcoxiUzFlY+okhnFK4PD3bVZFY61xmU?=
 =?us-ascii?Q?Z37VWnY/K9rDeVdpFpyINe84OH0NNfvZcxma0So/uWLiPR2eSv/IesOvKQ0A?=
 =?us-ascii?Q?Iuw6k/4zH10NAG38DI1DfQ9Km7MSqdMx7wP+vSyy4G1hcZuMS7HaO51Ja06f?=
 =?us-ascii?Q?mvDQXS+IEF5mMFb1lUXgkAvAEGY72DrOVgTAJ3alc8od5pYR9JX5ZbYtVEqG?=
 =?us-ascii?Q?BfOKKd1d9wv40In3/UFhx3A2yl2LREtIxFK7O4fxxZBvQTbV4RTTKdSL7n9W?=
 =?us-ascii?Q?VoGPTctByjOEWPuiofDZpuMcuaOHEdbLLUwvgShgbpDqj5aG9DmDMLQnzJwp?=
 =?us-ascii?Q?1AY2HrRfhNGnrZvRq50wq+CGiBBEGqDu4U9PHeaYpoa9yJuObJFQ52vF1Mn1?=
 =?us-ascii?Q?YXDGo7xHkg707ee+/VwYOMjsTil3JMJUJzgO/KXQsnzl/euNsHJUsYsOWYEC?=
 =?us-ascii?Q?VrvoMaNIRTnKyN55ssFKhiG5IX3JRMofSVXlyvUWr9D+xSPd4kJYpJyh4YW/?=
 =?us-ascii?Q?7teeQfB4nnC+9p+4UfvebmGc9sTBaZ+PtLKl5oNLKm7FAHHMTbi0scydzGH4?=
 =?us-ascii?Q?bBMa5CAJuB3TdwkRWtZ7poypmcKOlKCvZdnLcQ1yuzu9apHAkxxo3t96pZvc?=
 =?us-ascii?Q?H7Z1wO1EfR53cMN0oCELptCAf1SCwuX9aw7E4jXk9Ikf+mcqPzJymZG2GQgZ?=
 =?us-ascii?Q?EqTkgwM+EJx0U3Hazq/fElGp5pUmbk/aY6VPpPzZBnj/AkXrvWlBoXSdra24?=
 =?us-ascii?Q?2gwJQhywzuh72GQhi70Uk+2gQxborn2dYeZgRmHyp17McCD3Bw2Y6oy24qTt?=
 =?us-ascii?Q?ILwHoFSDndqTIT0XVIVVSLz4ILmF4tHSNoVE+QMQlfUY+0iBH3M+4GwiSegB?=
 =?us-ascii?Q?wO0YgHdiHNePG52Y8H7GSoxbRZc+pdYabax4zfr5CccJoEdMtZQ9QbhpjQoC?=
 =?us-ascii?Q?tsGbK7jFgbpmUX1ttJ9ORXmCZWaWt0EZd4byAVFbdK4ML0/freztuskjsKfy?=
 =?us-ascii?Q?qObGLmiNmF7Ck4CuGaTWHnbc6LFr8umKeF8syLWplO4vN2VEdeYk16ZSOyER?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c5f59f-5e86-4a11-453c-08dc96737ada
X-MS-Exchange-CrossTenant-AuthSource: LV3SPRMB0083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 06:36:32.6515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+Snq8UBkVji/PW1UcPGRnVJAoj3i+EwWDFDDwQ8AFXm42t3Wuyn7TWVMlfq6Rcc/75svXI2G9JUfQ4s8GnLU+jaOQrITChPLJXLsV/cppI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
> check in __gup_device_huge() is redundant. Remove it
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>

