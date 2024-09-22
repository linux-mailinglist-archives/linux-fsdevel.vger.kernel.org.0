Return-Path: <linux-fsdevel+bounces-29795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FC997DFA0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 03:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFC82818A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7461917EF;
	Sun, 22 Sep 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OH9qTf34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3C1917CE;
	Sun, 22 Sep 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726966837; cv=fail; b=LsWF53axb/oNWVv9wBreCfZ2zUbM8Dr+YdOxWdEEG6jcOP55Uxvje96pKPhIONPedZtduC/1jkz1inhwWFiFIjh3dDPbtelD9ntDhfcHNZkekrPjC3/8VoBLRVM7bt21hS2um3EH1XOi3Yf6QWZqUNW+fI16V4HgefpAv0ylIzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726966837; c=relaxed/simple;
	bh=1iQQwRWO3nZ+RF3m5sZtNGsVNdgcpbuSxyZD7UIuMTE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RHFgNHyD41QWX1Oh+2DR1QargLVT2Vy3B1/o/8aHCTk4w2ToJVNn8g1/sLxtl2riJcOg3HuqOicuiFmJneFn1CdYpFkotcQAm3qIKg/FGC7KeL68eTeweNqfOKgYbb2M05Nhe+qzLwSxdWDnGhD7ugQg1wyxDlG8MifiEFoF7UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OH9qTf34; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726966836; x=1758502836;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1iQQwRWO3nZ+RF3m5sZtNGsVNdgcpbuSxyZD7UIuMTE=;
  b=OH9qTf34kLIT/kTGPZuCdx+hGUsdmvN79nwehcLJiPXuiTxUyezc5SM6
   pOo+OJ9oMK77VSm8ibYVpqTvqScdPy/Jrs7WyrqQkGz/4/R0QVP8FV6U0
   6l6ITXpTQTL69WfwAi4WtF/nmAF94SEgebpjU/V5jmOudAAhXt1onTpvL
   Klav1rqz+nBw71BZDKbZy0ZYEyhm5jajWIloG4G3BfaDRAGsQIVmpxR53
   qZ4Cf4kvsAmNU+EFcWmjn4lcshxj9KFFwh40ZC3p3vRDw/mlRX3SLeEKW
   sTJr4B+/U5OBgKt1SRMwb5k8zrBsDo/OCSlDJey58CkYByDZ7k2/dyCdb
   w==;
X-CSE-ConnectionGUID: ctvwJF2tSruPw3bTNMqLAw==
X-CSE-MsgGUID: 44zmOGi1TV2FluUAxG/CUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="48465869"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="48465869"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 18:00:35 -0700
X-CSE-ConnectionGUID: UBeovkMHSxG6Kdyv5xioZg==
X-CSE-MsgGUID: Jo2g8gGjTtqyR0STCj72Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="75243216"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2024 18:00:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 18:00:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 21 Sep 2024 18:00:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 21 Sep 2024 18:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Alw8f1yyMijLedgPhTsyUDZ+px3vu9Oow+nnjsrADzebJF8z4Ss/h6fJYxIxC3kskWvb5PdZWQY9cSxOVkkohUOgX6xy3iRQiuZF5WWZafolBZXAXYgUoedDz9RzUHVP3AJgDqKlBDo1VjWaiFThBiTR/4y/YQfmLED30eZkXlRz1GHB9gSYiJq66JIWGa3sru655I30Du215xRp525QdxClTdGblNeiSE6lktvsGPRz/UT6pzgt2Xr3yniFH7zl78sn5JVyblPnUeaOjT0mzJUaX65iDoBBB/VkwL9KYNrt/1mZfBCnky7ovgtDElNwhfLvJhx2sCsRmt+gWFsHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRsC191aWeX7WfxUiROMBLasKK+U0tMCg8VlYC5S7ps=;
 b=SRFSyBIodMntQAWjElSdbB0ZKnku1RFyCrr1Xdifpb9IXG3odNM4wPuQN7p6ho/RDAXQo1Mqk0GdAWD5Lz+7lIlSae8wlRGV3kLmAUlIrFaSGi9srL4Rhi3BdGhvHc/oDiV3T846dZlM1BXnDq18+wkGZou0iLZY9E7+6c04H3C2NdxK8LpryxBxx/d94FPgko/sc+bqyltk+iqCe/7bzjhkdIbLuqdXsdiDjsSY1k3hqF+80GVeZx6JaVbBEtPUzKKNApVGWgG55NypAKZvSQB+vwBcTAoc6KZa0LrhBqPeqceUjtNZLgZmkj8Sp6hMRDMjWOoeu00di3oXKTC8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 01:00:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7962.027; Sun, 22 Sep 2024
 01:00:31 +0000
Date: Sun, 22 Sep 2024 03:00:27 +0200
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: Re: [PATCH 01/12] mm/gup.c: Remove redundant check for PCI P2PDMA
 page
Message-ID: <66ef6c2bb7f9_edc02946b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <2ebba7a606ef78084d6c8869dc18580c56de810f.1725941415.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ebba7a606ef78084d6c8869dc18580c56de810f.1725941415.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:303:b4::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 7174a89b-836b-45c7-90ff-08dcdaa1f506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nusA1ho/HWWWNsKZ6EOnrQwETitYJOgk4namvewBCjpTsvDa/SNOaMom0JnT?=
 =?us-ascii?Q?IsQ+VIErMLqMI9PbaUpBL1YBuRbmsw+IcXg087x198jh/lRgTjYQm//x9Qgr?=
 =?us-ascii?Q?/Y4vClPg1Dp+Oa9dbCU0j8JTJAJ5JfW/7ANRrcSszD6rTfKlUwykWB8BJiqj?=
 =?us-ascii?Q?RZOYrL8KuLXJAmCGkr3ENu59y9YoxmciVdpkRi0VqCOhOYZVd6eeYz80fgv2?=
 =?us-ascii?Q?QO7X0vl6V7x3DcbLAcwlfPxRN+DftOjFE7y0Ns9N2iV23+6V204BsguHWoeD?=
 =?us-ascii?Q?juBHPEqmQlE1PpPoLUl/u0KgWUj9GOkCnFSDpjJDKknGm4Sl95XMU2pIRUc/?=
 =?us-ascii?Q?h0m/YCYXt8b4i8kpVYVCLh8R1chwLSUhQj3Wonx29OvXNeu1gHjfrAspN/AO?=
 =?us-ascii?Q?oS6P8gezOf9TfK1uNCBhIOaks9WVIWYlC570tsKLxhDRcAMs6x1FNdOfF3Af?=
 =?us-ascii?Q?NvTs6s3VhCTgbv5HYCcR2IqOeOBHs8HRVA4dXO8IpYVaU2mqZ+B6od4V8Mgp?=
 =?us-ascii?Q?+ah80J6gkejwcifecuoT6eaZXkbMVzJolm+WTcNI+xjRP2LxC8DtLflg2QRY?=
 =?us-ascii?Q?EePWQYVQJf4TZwnN/AOb4mA3avfZirn3ZmRq0ZGv9CuB4rOok5hvMcVsej7d?=
 =?us-ascii?Q?PFy2zH55fcm0I4uTzuUpV6msdZPlYMyH6c3ABq8R5g+qy0keCSE+Ny3I+T8c?=
 =?us-ascii?Q?YuiaJBiq48khL3TrTMHnIIMZrzm3pAPOjlbyV8V2ODdini37iKnzXq6NWdzO?=
 =?us-ascii?Q?23Abd9Q9Gq8Xd7qc8QT6iyfs9A+3Vgr4oZSef+vyk90tggBW/nSHKGsGnO2U?=
 =?us-ascii?Q?27QWqDWIiMdK15b1IWMueb4gW6hF+xPfjT3iDR+r9XJThx0GnOgVGoSpiD3z?=
 =?us-ascii?Q?fLXaC45bm9DzKf5JILltFSsAPj9qxWPhrA6Mt4OMwIjGiU1rqxYHQm+8e3/G?=
 =?us-ascii?Q?tq9K7a+Jxet0GSxgrrttQ7o7CwhVWyJ8CvWI6SDSh707khTvkkMb/xXvgAP1?=
 =?us-ascii?Q?L/wuCQ/XZXXRP/CR5hhzWvbOs4B3AQ5saY4qFEuRSikNL67PHguI+ZD+1vXE?=
 =?us-ascii?Q?JW3exM8Cxfc4RdmdV170v/wjaP4YHu8mKu3hoA2VWrUIBgx/xEx5qZ8PoiYS?=
 =?us-ascii?Q?sKT28ihzxpFwZ0A2ZunRWtg7IWDt0q049IywBKzmCc7Ujy6hijbZJQ3+FI/K?=
 =?us-ascii?Q?9b/jDHpCODj0y1MTqgUqBnx6eKEhd2bVM0XI5Wk3ztrLF+SgFvhXT7LKSssr?=
 =?us-ascii?Q?suTYxc+1OD+aEahTtHcx0e5Yt/N0Kg29qFQt31ub1DfZmDAfXzwgrptXlGa7?=
 =?us-ascii?Q?xZgACt0B8+gi89NIc+5XjrQW2KqkLfisEnZhIZ3XIP62CA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Yh5e9WxUZwbt0TC2PFjTU2fceJmZCVsnbn3PsoDX8/PSRVX+Q/cRa9YTroj?=
 =?us-ascii?Q?QbxF/womFGyXel4ODiTh6o09MoWU0XUPBg60ilzIN94EH5b9lofa+K+VhHpc?=
 =?us-ascii?Q?O4GmSZpm9Jav7+hTT4o8ap3lMbQ4RftulmRax0b3wKVWYwYl3vmAPJMG+MtH?=
 =?us-ascii?Q?OZRVyOfRNhtfyBiPm/7NocbavQPP8CWrZv4LU8P17BCfjLoRAr/8Mmh64JFo?=
 =?us-ascii?Q?qsvVFxgkwSc+zmr6vqgK3J6/+vIPKz0OwbCOQjD/Z6IOfHcqgszIS3DeYMjl?=
 =?us-ascii?Q?pLNUrg/c/BxD8G6d48wyywSHxwv0WJbweGZsYuNQL10j9U8bN3N4blOedl89?=
 =?us-ascii?Q?efcay/IYDEbDBmaOMkg9V8q01JTmWJyA32Jn6cJwygBWRXwwgDvQ/xpjSilY?=
 =?us-ascii?Q?QaGtjt+RzrUcBgk1gc0Gs4ZMNrJ4RmGxd9WcyzXZ05OmIDHCoTrxcw3ISJZx?=
 =?us-ascii?Q?Kezowa4/tPY+vH7VNh8n3Hp+I6/8fP1QouPSyncp9Jha/rGo6V8E/iZo8Jrh?=
 =?us-ascii?Q?RFqwEZYZqYKNGAXebGHmhewzhA1OTK1n8n6sW19p9WBG37EIf3YT1f25iv3p?=
 =?us-ascii?Q?QdoY8bafd7fa4tUeYBCEMMLnwRbCzOwG5YXdUW/8lOEP10Eo8dE9TZ/CLYIA?=
 =?us-ascii?Q?fwmKOf/yUm9Q30YHTAvhNRjUSc+kTfl4OmpROjzgbMV4JQu+GKkNO3UwzCy9?=
 =?us-ascii?Q?hee/r/QFWlVxchtkcyxj+JOAyXB+uBzV91jmm6rRAyWrBboCkTKc7NliYxP5?=
 =?us-ascii?Q?I2hsWINBaljU6UXEkiZBvF9SLAIsyEv7IRxnulC1Glxj/BUtvD1Pejks8HlZ?=
 =?us-ascii?Q?Lq4WOFIUyWrfAXlUdQ2GwXeHsARoOWzVehK1Xigt+UdhJZ/HUYvlji5CpPyO?=
 =?us-ascii?Q?2QI82UCeE/i8eZMvnUXGeIYjhACMclLrycW1II9/wxmtvegfvAbcnA6pFDL9?=
 =?us-ascii?Q?JZiGrNUF4CHIezLRsayMaRaYHBW/wq3Q/4TxHnGE/ex5pEh6+HkxkJG1eBfd?=
 =?us-ascii?Q?Le6gegbG60ZPdCvkthWRlkda3WydS5tArMXBVtbjzXfm2rC6/JwCqIyvTh4O?=
 =?us-ascii?Q?e5aW+nnEjUwgGqMxEW8jfceolHmF48ZE4BGbTy9sFyMEv1wq2Zj/9Z0xITi2?=
 =?us-ascii?Q?mOAKV6OjWRdQusDv+yRC05xGyNvHRghNECOJrbfgKww0CW0nzSvCRNa7HSCN?=
 =?us-ascii?Q?Egsb5O5kExffBtC8XRKgNtXOB6YWlwl/zSTRTwFFkt2lRjI62XEtb+ZFZ1CC?=
 =?us-ascii?Q?BsPGgM5LQGKWPzNCZtWhYRPBKa1ZlHv0zsu0SJ9Bl3txOyTn3HPoJYRzc8tk?=
 =?us-ascii?Q?np46yEG79VNWi8IIn57hGv/sQOBKXRtui/Kr+uj2djy/gM7GSIRsjJ29tzH/?=
 =?us-ascii?Q?Bmf5BffcTj9dNIt83ZhGMXAa5WBf1whOt74BdjIsFVtjjvIZ8MxnaKcVAgdH?=
 =?us-ascii?Q?Nz6/4wuHt9aIkBYIEm13wJUtPSR9yqIhH4TAKU9XTMxld/N53vbtfNMkBaKJ?=
 =?us-ascii?Q?UOQHpr3ffw/1uDWcJL328ghwHj1BHAi+TvBoiV1bWRhBnBV3/YkC6VnYZY1Z?=
 =?us-ascii?Q?P6g6ywibh6Sd7b/byd/VYbzYd8fwpev2qoCb1eWLD2Mu3F/f1rqLNyk/aWxH?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7174a89b-836b-45c7-90ff-08dcdaa1f506
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 01:00:31.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvfpW0wuLZEaH67JetQFo+q0vjy/+l+TU4ALS5Lh/dtQ5cq2iDDwVBW2+tpxWye54q357NY95QLBpBD8PFh0qoKLj/DO1b/XCF+NQDPWllU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
> check in __gup_device_huge() is redundant. Remove it
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index d19884e..5d2fc9a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2954,11 +2954,6 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
>  			break;
>  		}
>  
> -		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
> -			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
> -			break;
> -		}
> -

Looks good.

Reviewed-by: Dan Wiliams <dan.j.williams@intel.com>

