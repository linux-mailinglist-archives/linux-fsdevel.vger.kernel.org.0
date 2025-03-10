Return-Path: <linux-fsdevel+bounces-43572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FA6A58E76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B8716A185
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 08:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1AD224228;
	Mon, 10 Mar 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORU7fh/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719F13EFF3;
	Mon, 10 Mar 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596356; cv=fail; b=klmEKHJwOBO2lXSzl7kk/1fsXaaeAEzYSXDXDqhTB2yW+Z+1nML5xcQUb3hChBdxmYF1otazBNNU0wwgFVsJUbPPAGA2oHIJssjcmOe9DMU39XzWUF/5nyCJbSU1tMEdGA4+eeAzYtb1OVgwKG8VhhxNtZOVC5vo6y6UrODrbzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596356; c=relaxed/simple;
	bh=1EEnIbnxQ241bR6j+vuFKhsZjM2O4v9LTen40mAFZl0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m5FS/w4PCLQv1iAPbyXNvmuJT9LeY9hoURplCBNvmC/2Igi440Gi5DtNpD+KqeDznAbo/quijjPlv3U0iQSE4KL3129vUIVb35lxZ9YjZVe09W4ES5ZcR8sHqukIK1Yn36Q+wR6Z4HiE+mH/qdhhMpzq7MwOBh50ezzqxWg81hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORU7fh/b; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741596354; x=1773132354;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1EEnIbnxQ241bR6j+vuFKhsZjM2O4v9LTen40mAFZl0=;
  b=ORU7fh/btCDp/OUhJmp8VA76ouskOxbZWq8tN16xBc3nOpvCPuq6IrP/
   tQZRAG6L+SxBSSwihJaGpyvEiXWcU1pzZM6wSXXRzS+EiB2Lbk8lZc9pz
   pry0d264w7uBGw/H7drtesArvUp1M+FoVExOhtVA4GYBLGjczzE47Gsuz
   iyPVJ6NP5/XHZ5rB6wyyuuE6XlDVuRII3iuE+jEOIspF8psxaOM8tty7/
   /4ZvXkEyVT3pcWr/yeYICoN/hgJJK6hwNLq4pXsRy+nmJZDOOJQxmSVxY
   ZSky8Nb1b+XnVvLk+XBULPo2epic3IWG4EIIYn4y1vsLTrjkImYLBgRi5
   A==;
X-CSE-ConnectionGUID: PWJLiUj3RUenH0B0AUCVuQ==
X-CSE-MsgGUID: yEY2fXs7RdmlHSNGDauyKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="46491719"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="46491719"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:45:54 -0700
X-CSE-ConnectionGUID: JRuICz7cRuiat3L08WtZjA==
X-CSE-MsgGUID: d6CykR8oSbqzksflBCBeAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143141248"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:45:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 01:45:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 01:45:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 01:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKiQbs+uF7vXvaIR/C++04iMvK0TC2OHOfgA6Rpe8xuVr6uJVhdpsyMY596oDBh1GOiHwXF3h9HnCe4DvC/MbdueXTRzFFVfPkRpUSayAj/RNezoQgrsnIKyHta31qJVdK42j5J7vUBjjsQs6icbOVkZmJpxi27/X4m0HNklNAJ59Gm8z5gp6WgGg4tRLlA203J6L1Ep2XMSl6oa9WCtK/UxdsLqZOugDg/U6hhcU13ZaywsAOxDftVXC6RbxmtTuuSstdjw2f7HYc9nw1YWmbu712EzmdQmeh1fV2sAToK/ejrOrcAPfHAkFYxM3anNUwFqi9IYfxXK3PgPSkSJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gIp3VTv0O3Nf2wZwpc2ddPCSxCZhrQ8d3QYkdKRQR4=;
 b=HVv89ocYL9sChbtyj4ceGpT7t0bgdwyt9o2NTggHNGfPxpCDjwlIvWOIoGoz2QuQ25F3XIzxsUrbn3w7g3ZAv9+1+7a473TBbsyhniMLSuQFqhZAEwPoRM5HwjRXipdFw8mVfLEE6a2XiO49CtmFwKyfNF+17l685ErdYVL3Etw1XpmezNR4sJslTTPOCSOQsWYWuWyY4DgduFzwaDNEpserQdB06GHFrxTTzG3I5zrzuj5VqQMaEwMiUon7V6VmfY0ZTH0dDTDAQqT75FGb8+bcKoW3Wr0MhRtRSjDMSq3IaaPtYSC7Wd3MLBIlzTmBgk+X7F3lUOQxy7MLJShUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:45:50 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%7]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 08:45:50 +0000
Date: Mon, 10 Mar 2025 16:45:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Ted Ts'o <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mateusz Guzik <mjguzik@gmail.com>, Dave Chinner
	<david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] [v2] filemap: Move prefaulting out of hot write path
Message-ID: <202503101621.e0858506-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228203722.CAEB63AC@davehans-spike.ostc.intel.com>
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|SA1PR11MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: cf46469b-29c9-4ebb-d555-08dd5faff566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?TXhTlOwCORn9f5/Abi/kpUgyTOxT7Pv1AdlM/uXnB9ScpWYO39swd1k9xd?=
 =?iso-8859-1?Q?Eo1PsoWKrK4laV1X4cq5h4y6iXcNi90JDwIjRl/ogazghCQ9ygLuIP+6d2?=
 =?iso-8859-1?Q?dyohNjvzWCOxdvo9Rgg++uzlMJRKOsC0DWY9gBHS0H6DYERAFS20kXfQfe?=
 =?iso-8859-1?Q?NGokjrS6zJh1Mb0mXgA3KVY9oIeKam6IBrZguSKZhyZxMwSTmFL+oJB2Ux?=
 =?iso-8859-1?Q?+wA3bNvGaLTsGZsCL6PfB0BIFbkUh2orgDJ0+bt89NHFyGUhKCR/hEYipM?=
 =?iso-8859-1?Q?4KatSFJoGBiqBB+QGk8kvhDvaujWTcW1amMJvsUMZf8gTN46cmYpgfX3jr?=
 =?iso-8859-1?Q?yQSmBHCXtw/0FDO1mCZ5Cs566QuVsk6L0AgHVV385liSXQ1u/xbv1sVCAh?=
 =?iso-8859-1?Q?a0rAne89p459Y75a946HcVY/GRRPmbUy2iz97Wyt6fWOG2F7YNMmi/lAdq?=
 =?iso-8859-1?Q?f03M4Goj+Hf7CvFP2qVHEJYIPYteM0PSeAu4Y5dNLEfXhK5MfbHPD5EtSL?=
 =?iso-8859-1?Q?3CuuTY1NONuJCXlYgftdNkbbbdGaTBayvJpqaEpX+K77YwLZ7jbK9d2vr6?=
 =?iso-8859-1?Q?Rhovvhky0hasFEIgHaH+h5u+99OvH8iYpthtU8xqelfzSzPiA2fniLogCl?=
 =?iso-8859-1?Q?BLCd/JUa5uSp2EALqtNxSXmQcldg7eKsmniWfVHi0JDFUV36ryiP3QJdO/?=
 =?iso-8859-1?Q?/NU+2s/cbPADELGPlnrhOgI/o/KWEK3AF6GSKDLXsNLoHisho8tMmJKV7b?=
 =?iso-8859-1?Q?OK/0UBZwGtWAE8nMBCN32BlVl2lqKF8gK9HJB6nkNjz2A2lozQ/dlOG5xq?=
 =?iso-8859-1?Q?8GyItzdbJ2yt3QEoY1mqkPLK3fap+aRenPJ9Fh+Tz70+AZBjbr2dF+fgjP?=
 =?iso-8859-1?Q?MqRIWgBFViQswBT5eZbKx3SgDo30i9HIQRC1Yp5NaJAks3JmJkgsaqWtmv?=
 =?iso-8859-1?Q?ZPgb3Ij1FRcp0cOCIPU8zNJPTaKsPJQP4YQb8kyYFaMB7rwSSl2P1P3nRj?=
 =?iso-8859-1?Q?qIkwdCfycBHdWZe2RhA+K3n+8HaQbLvpqxnqBAVySkOAzqQiFFVjqwznLW?=
 =?iso-8859-1?Q?gnYuckqlp1VlSDzwsSBF/CJaTILcVmuwDAwJgWEge2IF2G18wdeP9ScrmE?=
 =?iso-8859-1?Q?vjtGj5u0t3MjB2WHJsJTlyJl+DB/owEROR6UQdQ60kQzGNLANXZTlEPYKQ?=
 =?iso-8859-1?Q?zPmP/Dnfv1Bp+K/eAAHSkQBLKiUOShgFPULqjq5yWvbej2D+EMoQ8+erCs?=
 =?iso-8859-1?Q?9ET6ne+nnqbD4RxBh+WkiXNlFz7jENL4mpeDKkrOfTzQ1kNFGxkRuzjwzp?=
 =?iso-8859-1?Q?NS8+aOtRTnF2jcw3AznnrS/1iBqzpmbPF0eGou7/91sLmKYPvq3b/3Dm/m?=
 =?iso-8859-1?Q?qajllX6KS343SuuowzhMuFTRf0l2uZgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gcnCV5neR7czy46s02hR3a0M3ln+W0S7mQCTwk47UUl8UyF4NhVvBgpyIw?=
 =?iso-8859-1?Q?NR1uwUCEJ2jhOZupDL1Vi5N7xBECGViQKQQS/edVW1VHl+hTrFGDSghta0?=
 =?iso-8859-1?Q?DL3RBv0rUck5eb9/tOcZS1HAJX9oCRUFFwaYX6sLLIL+sKj2VDBsLoiifB?=
 =?iso-8859-1?Q?u9yLsjc1Ixsaxs+YCey8XHjNLekz9ShEWZhIzJM7368uMyumMYFm3oHe0K?=
 =?iso-8859-1?Q?Wwr6CZB8Wn25NZ00fnJWfUwZ5iuAjwT8BXlUzzcFjlA2NBUpCGizuOsggm?=
 =?iso-8859-1?Q?TNEhdmqh7iYVj4WbYUh4WvIoCS+dqwqgSMPaAglCZEi4qGSHZsdtGVnvYp?=
 =?iso-8859-1?Q?zxe2itMdb7k+V8ICv9pFQL/KoXcIRRXWO1/C96XncrRBoqHlGWvfNd5366?=
 =?iso-8859-1?Q?wYB/mIusqtTi8A0W5NQhNROaps5YHxo2ewgmSb3nCj/amnwa0MAU5llvik?=
 =?iso-8859-1?Q?UWrutDwCCQnICfsHdlIA7efPHorwiKcYPPKTYRGAKIFW+6T9noyB/agvo6?=
 =?iso-8859-1?Q?ptqTJkNWwdlN7KKTGx/U6Yy+0w+wZnZa+6I1+IVT58Lx6UVHRb5DWiPc7B?=
 =?iso-8859-1?Q?vu0BFY9iu3/5Sup/yfVQeBkjqlgc4Ra67Hg+2jpcNumrODJ7rpIendM84v?=
 =?iso-8859-1?Q?bAPmaVoKIkRXQN5GDAz1Ya4IPuOIljN+RR9PL1hCtz7voK2FBwffqv2AO+?=
 =?iso-8859-1?Q?F8yYiGbQxorfOElQ0VrXjuS3lf8Si1r05fefLnI829L92PVIIUIdcPjhAu?=
 =?iso-8859-1?Q?nBluDKQ2qeSB4b7sUEDd7Xmex8kyF5jXlf9+q6GNXOFV1nE++etwiULo1f?=
 =?iso-8859-1?Q?Y+2esFLmdwR4e7DE+Q8TkAjXzu6ZwvIfykmTWJHHVvVdVQW0+xmLbxdzhu?=
 =?iso-8859-1?Q?1+WhiPgYAW84x06Pfxps2Sxd3GS9jXwxxv8b3NBu2vticSARzPU9ldB7J3?=
 =?iso-8859-1?Q?E0X4t577vaCAJJNJMXsT0L08SDhD3Qup50rrCCYMmhpAPt59H4qG6FTh7g?=
 =?iso-8859-1?Q?/XBX3/m9pfam8GYVdk2kD6uRcvTyKOlykVnLY+5Kiv2En6t0XhtWpNIFmo?=
 =?iso-8859-1?Q?eIKHib6glLM919j/osjW/skeQAuPwEjgWnmUPQk8WFdGITRxfuo0cEUzxI?=
 =?iso-8859-1?Q?7vYqU6ThoGgrTJOAQoDPag2az3h6KtLa9GNuPUjpAJxjcFrfnWId+11gju?=
 =?iso-8859-1?Q?MDvnd/XACtgV+itVifgi8p7VQlll5m1hEUcwhjEWpZKo0wtKgMZmMeYvO4?=
 =?iso-8859-1?Q?lz7/iDEGnGqZBZ5dVc6W/bOYFofAngOldOfxnVRhn5rrWC7tK+1b3I283H?=
 =?iso-8859-1?Q?PITQF6wk8siw7Y4/OkYgekEF0I1Uk+Qj9eI8acmQjmBLEiKeeewAoACgaw?=
 =?iso-8859-1?Q?trxrOnk6Q9Pl6KZfZCYY9YoUxclzHs3pYkdposaRTGiQ7FmQoykoXG75zO?=
 =?iso-8859-1?Q?I5bp34MB17mI+MrVJf7BKSlcapK0kpf1MBH5xz2TABEqrdsvHU0j/33xvm?=
 =?iso-8859-1?Q?zyAM016riPMD4MUSv5r18zwbUcd3X6DhT3sk0ZOSvmt5mB8xzEbcU1EXb0?=
 =?iso-8859-1?Q?/78eA3/ZRT5RgiVTUkRTrW/LGmsAfKj579wvICjmF+u9yK4HnQtJlmIgPT?=
 =?iso-8859-1?Q?6+WCZTyG8l5/WgVUhAadt7fhAjOj70iMXKiWfAPvA1bnb/lKw21taxug?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf46469b-29c9-4ebb-d555-08dd5faff566
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:45:49.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZceKRVFYNdbX3cH+bdLojGMwupI2Ul1mjCtMDmnxRm+QQu2oMn2rOd8ZKP4XmdxpTQD9xm8vNJrs4crHRCK3ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.6% improvement of will-it-scale.per_thread_ops on:


commit: 391ab5826c820c58d180534a7a727ff5668d4d61 ("[PATCH] [v2] filemap: Move prefaulting out of hot write path")
url: https://github.com/intel-lab-lkp/linux/commits/Dave-Hansen/filemap-Move-prefaulting-out-of-hot-write-path/20250301-043921
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20250228203722.CAEB63AC@davehans-spike.ostc.intel.com/
patch subject: [PATCH] [v2] filemap: Move prefaulting out of hot write path

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: pwrite1
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503101621.e0858506-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/pwrite1/will-it-scale

commit: 
  3dec9c0e67 ("foo")
  391ab5826c ("filemap: Move prefaulting out of hot write path")

3dec9c0e67aaf496 391ab5826c820c58d180534a7a7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    182266 ±  3%      +9.4%     199333 ±  4%  meminfo.DirectMap4k
    765.67 ±  8%     -22.1%     596.83 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     17510 ±  6%     +19.3%      20889 ±  8%  sched_debug.cpu.nr_switches.max
      3219 ±  5%     +11.2%       3578 ±  2%  sched_debug.cpu.nr_switches.stddev
  54561715            +3.6%   56543708        will-it-scale.104.threads
    524631            +3.6%     543689        will-it-scale.per_thread_ops
  54561715            +3.6%   56543708        will-it-scale.workload
 1.752e+10            -1.2%  1.731e+10        perf-stat.i.branch-instructions
      1.59            +0.0        1.63        perf-stat.i.branch-miss-rate%
      3.25            +1.8%       3.31        perf-stat.i.cpi
 8.828e+10            -1.5%  8.699e+10        perf-stat.i.instructions
      0.31            -1.8%       0.30        perf-stat.i.ipc
      1.58            +0.0        1.62        perf-stat.overall.branch-miss-rate%
      3.25            +1.8%       3.31        perf-stat.overall.cpi
      0.31            -1.7%       0.30        perf-stat.overall.ipc
    487316            -4.8%     464012        perf-stat.overall.path-length
 1.746e+10            -1.2%  1.725e+10        perf-stat.ps.branch-instructions
 8.798e+10            -1.5%   8.67e+10        perf-stat.ps.instructions
 2.659e+13            -1.3%  2.624e+13        perf-stat.total.instructions
     34.45            -5.9       28.57        perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
     48.17            -5.3       42.87 ±  2%  perf-profile.calltrace.cycles-pp.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     42.56            -5.3       37.29 ±  2%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.38            -4.9       46.46        perf-profile.calltrace.cycles-pp.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     54.26            -4.5       49.76        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     62.52            -3.9       58.65        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     13.30 ±  2%      -2.3       10.96        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
     10.17 ±  2%      -2.0        8.18        perf-profile.calltrace.cycles-pp.rep_movs_alternative.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write
      0.59 ±  4%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.88 ±  3%      -0.1        0.74 ±  4%  perf-profile.calltrace.cycles-pp.folio_mark_accessed.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.67 ±  2%      -0.1        0.56        perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
     99.51            +0.1       99.56        perf-profile.calltrace.cycles-pp.__libc_pwrite
      0.64 ±  5%      +0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.fput.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      0.93 ±  2%      +0.1        1.02        perf-profile.calltrace.cycles-pp.folio_unlock.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write
      0.72            +0.1        0.82 ±  2%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64_mg.current_time.inode_needs_update_time.file_update_time.shmem_file_write_iter
      1.20            +0.2        1.38 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      0.84 ±  2%      +0.2        1.04 ±  2%  perf-profile.calltrace.cycles-pp.noop_dirty_folio.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write
      1.48            +0.2        1.72 ±  2%  perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.shmem_file_write_iter.vfs_write
      1.00 ±  2%      +0.3        1.26 ±  3%  perf-profile.calltrace.cycles-pp.folio_mark_dirty.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write
      1.99 ±  3%      +0.3        2.27 ±  4%  perf-profile.calltrace.cycles-pp.fdget.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      6.69            +0.3        7.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__libc_pwrite
      2.24            +0.4        2.60 ±  3%  perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
      2.78 ±  2%      +0.4        3.21 ±  2%  perf-profile.calltrace.cycles-pp.file_update_time.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
      4.34            +0.6        4.92        perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
     12.01            +0.9       12.92        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__libc_pwrite
      2.89 ±  6%      +1.4        4.26 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__libc_pwrite
     15.09            +1.5       16.61        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_pwrite
     34.58            -5.9       28.70        perf-profile.children.cycles-pp.generic_perform_write
     48.24            -5.3       42.94 ±  2%  perf-profile.children.cycles-pp.vfs_write
     42.95            -5.3       37.66 ±  2%  perf-profile.children.cycles-pp.shmem_file_write_iter
     51.54            -4.9       46.63        perf-profile.children.cycles-pp.__x64_sys_pwrite64
     54.37            -4.5       49.86        perf-profile.children.cycles-pp.do_syscall_64
     62.76            -3.9       58.90        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.62 ±  2%      -2.3        8.30        perf-profile.children.cycles-pp.rep_movs_alternative
     13.47 ±  2%      -2.3       11.16        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.90 ±  3%      -0.1        0.76 ±  4%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.69 ±  2%      -0.1        0.60        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.29            -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.testcase
      0.31 ±  3%      -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.50            -0.0        0.48        perf-profile.children.cycles-pp.rcu_all_qs
     99.67            +0.0       99.70        perf-profile.children.cycles-pp.__libc_pwrite
      0.64 ±  5%      +0.1        0.71 ±  2%  perf-profile.children.cycles-pp.fput
      0.43 ±  3%      +0.1        0.50 ±  2%  perf-profile.children.cycles-pp.folio_mapping
      0.94 ±  2%      +0.1        1.02        perf-profile.children.cycles-pp.folio_unlock
      0.74 ±  2%      +0.1        0.85 ±  2%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      1.23            +0.2        1.41 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.89            +0.2        1.10 ±  2%  perf-profile.children.cycles-pp.noop_dirty_folio
      1.54            +0.2        1.79 ±  2%  perf-profile.children.cycles-pp.current_time
      1.99 ±  3%      +0.3        2.27 ±  4%  perf-profile.children.cycles-pp.fdget
      1.08 ±  3%      +0.3        1.36 ±  3%  perf-profile.children.cycles-pp.folio_mark_dirty
      2.30            +0.4        2.66 ±  3%  perf-profile.children.cycles-pp.inode_needs_update_time
      2.86 ±  2%      +0.4        3.30 ±  2%  perf-profile.children.cycles-pp.file_update_time
      4.58            +0.6        5.17        perf-profile.children.cycles-pp.shmem_write_end
      1.73 ±  5%      +0.7        2.43 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
     12.88            +1.0       13.84        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      6.99            +1.0        7.95        perf-profile.children.cycles-pp.entry_SYSCALL_64
     15.22            +1.5       16.75        perf-profile.children.cycles-pp.syscall_return_via_sysret
     10.43 ±  2%      -2.3        8.08        perf-profile.self.cycles-pp.rep_movs_alternative
      3.26            -0.4        2.86        perf-profile.self.cycles-pp.generic_perform_write
      2.02            -0.2        1.78 ±  2%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.87 ±  3%      -0.1        0.74 ±  4%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.53 ±  2%      -0.1        0.43 ±  2%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.25 ±  2%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.testcase
      0.54            +0.0        0.59        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.79 ±  4%      +0.0        0.84 ±  2%  perf-profile.self.cycles-pp.__x64_sys_pwrite64
      0.51 ±  2%      +0.1        0.58 ±  2%  perf-profile.self.cycles-pp.fput
      0.38 ±  3%      +0.1        0.45 ±  2%  perf-profile.self.cycles-pp.folio_mapping
      0.74 ±  2%      +0.1        0.82        perf-profile.self.cycles-pp.folio_unlock
      0.73 ±  4%      +0.1        0.82 ±  4%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.54 ±  6%      +0.1        0.64 ±  3%  perf-profile.self.cycles-pp.file_update_time
      0.72 ±  2%      +0.1        0.82 ±  2%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.79 ±  2%      +0.1        0.94 ±  3%  perf-profile.self.cycles-pp.current_time
      0.98 ±  2%      +0.2        1.14 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.85            +0.2        1.04 ±  2%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.65 ±  3%      +0.2        0.85 ±  4%  perf-profile.self.cycles-pp.folio_mark_dirty
      1.11 ±  6%      +0.2        1.32 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      1.98 ±  3%      +0.3        2.26 ±  4%  perf-profile.self.cycles-pp.fdget
      2.14 ±  2%      +0.4        2.55 ±  3%  perf-profile.self.cycles-pp.__libc_pwrite
      1.63            +0.6        2.23 ±  3%  perf-profile.self.cycles-pp.shmem_write_begin
      8.54            +0.7        9.20        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.09            +0.9        7.03 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
     12.75            +1.0       13.70        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
     15.20            +1.5       16.72        perf-profile.self.cycles-pp.syscall_return_via_sysret




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


