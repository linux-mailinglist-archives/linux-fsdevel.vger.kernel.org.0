Return-Path: <linux-fsdevel+bounces-12415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D1485EEB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 02:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816082847E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D31F516;
	Thu, 22 Feb 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+AZMR2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F986125D7;
	Thu, 22 Feb 2024 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708565706; cv=fail; b=AOoelKRc9yrkIgR94QvxOJ+4ZUdZrYltshUvMObjQ9WIqPWm63ZbjtesXJ1d/gLkuY4sr2DKvi4TnbPWqAW8MluHEbhBjQ5vVe08jJBEcFIUfCJ/AUCheXDYA/8h8a6ppTtMaSRlHBz7SE4XHwbtrgQJRfxhSnPJXl1GG7TL/Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708565706; c=relaxed/simple;
	bh=mhYJn5eRFZFujteJ+scAop0/YhibazhfXwk7K0efhko=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n9hnNeLI4IhzgjGY/UoNe85yTxfwMKRip6C53vcyIzi5AKVtH+Sd5cU0n2MYnsFZHmBYI+xG04+gZbWYCmD9jcrutxXHyysbj4kSyr3Ap7GpRA9lpokEcI/c8++0fr+uhLasvCCd2NPKk1ZOznRb+H3BmwCV0DrtzfX0cBUtyQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+AZMR2G; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708565704; x=1740101704;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mhYJn5eRFZFujteJ+scAop0/YhibazhfXwk7K0efhko=;
  b=L+AZMR2GsSwiI4Zc1DTHiIXqwvFL8ySbc0hnEE2XmHLq++tbrC7d6/X/
   a9zHoC2bfvuhEjIx5vt4KeayH7oTCqx7hl74rkgoxhbtYlO9lcMRXGjF0
   YYwr1JmceGKgVdc7SwxqdqcHwWgB9lr2uIDnPqAktO9YPZiq94NRgcQRf
   JDDwGUb2FD+61GersO6g6lI3bDzrG3L/IW76tcDf1qM6devQNzwcW9wyc
   Xkf/TQoE5qliku2i3hQ0k1VJeXlK46Cbaq6Anou26oB6L1Vyz10uRA7A/
   L35M9tP5nAz5WEyn4P0SHrbuwiUfOnMT3rb91sqUrOvqEncvO54vZiih3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="3254113"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="3254113"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 17:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5475354"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 17:33:05 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 17:33:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 17:33:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 17:33:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1mWBRHU30RRwEPj0Cc3+nZY9lVhiHT5yJLYc+S6RFTW3hWLXlFSBYk2iNHa5PznB9FZGvXacJH1dWA+uqsxWtcvKLli3qJz0qNpOjSblIv7T41oRSKJat+qtDjCHQDv2jwmqeCR7Jz634GP64yK6L/+djs9c75Xno16zdJG0d8Bi0yFLvES/byxZC6x7rS1k8qkJ9L8yXKvLywT6h5NqfJ+p8aM/UfT1s6E0iWtyAIkYKxhEhZQr2QzQH4HE/uRCTFlj8HFPMbnUkPttQyI90N7+DHfeRbTj2hfFKM1aa+xt0GGVDq/CV4kV0RiRuSFkzdLHTBAHyTTxJrpJeN05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5QeqV9E5DxPQeU2nT+BKk5sVaDHbYh+OwbdFr4n/a8=;
 b=BNQd6/nGwmi9CyePeHIiNLU29D9OSa5WUIYMPPSSjKPC3Fpfp+1DMydTmoRuzI/cd/M+JtcvpPVxPpNk2VxjXQ86xKcwpyuEfjKrHOM6O6rXMY0NFIqIx6rMyG+zDQqD6l6Snf7QKjBn/egr3X7sdSma2eKEJ9GVWbvcefpU9h4+iFnrQfXweWAhoh4PWftpBKddBbbuJ1D10OkyqseAWfvGHl+ebObnDvuSHrQya1Fs8/kzrMNWMfm8Do5MkYvGUKy4oPe5+0GotNwUqkGzNPg7JRs0d7yNY7VzV+Tvl69OwyJEqkBFQQkisSkvquBuRdJUtem7E6+wx7L8b16Vyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO6PR11MB5570.namprd11.prod.outlook.com (2603:10b6:303:138::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Thu, 22 Feb
 2024 01:33:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 01:33:01 +0000
Date: Thu, 22 Feb 2024 09:32:52 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jan Kara <jack@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, Guo Xuenan <guoxuenan@huawei.com>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [readahead]  ab4443fe3c:
 vm-scalability.throughput -21.4% regression
Message-ID: <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240221111425.ozdozcbl3konmkov@quack3>
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO6PR11MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bba0e0-6b41-4371-4586-08dc334634f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v28FGJoTygUYF3K3AdlGLOvQKDRtu72OpOAIR4cKGQynS1z+JXiOj3oqba4dZ/k0qOfB1n0kHnsJv4ctbnPP0ew0FhSj869IXl3opw/wvdtsThA9YiCzAxzhIZxoLcMlALF3hcIluXNPNCyS5JxyC67KeOwcYj711p+0+EeGCkVN2xqx36gQ21vtwGbZCVv2UxSTfqxU0CCq/lG18HQZymxz4CBmZmb0seoOxbmOK8MmxkMjngQskwP6YBf8ySgvmM7qyBJgyM3uITlLWswZ6Cr64IVAbZgmuaEZb8zacaCnvHOT98PwYXkRvTaa+7cEbA4Me2cTtXztjDcdZrAkV6588chfjeuIX2tikOZvVkxEuOI0qM+LCrF3sKdnPM7OGgqIvXTjglAU1JLZB+gGvn9qKoT3D0IDJdZYWi6wTK2ykXrWmBuIZACz8WPJkmy5Z7uY35T6zlFDMgREpggy15g17FEz0o8NPX71AxvVlbRZlQIjMCH8V9mnFi8YEqRny7aERpFCc4BpGW/QcaGmkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c5mwCq1hHPTtPfApcfjnBrnc8XhFZDyKhM1+cZlegd+LU1Wt6lE9nlLws0Tm?=
 =?us-ascii?Q?tOAsOp7xyjnZl1SbTLz6dq3e4fb2q6GiLWY5ljBgmipVI+Cs1EUzpthVxG6e?=
 =?us-ascii?Q?S4iVfohGMA9qJQ3Q+TaYJRJSaE7MnVh1m8nidBfW+LI2WMKh3TgF3US5ACTw?=
 =?us-ascii?Q?3tvhajM5r/9vu6IbQa1rsKUrVZVK8HQIEMJcRoN9N9qWuzLF+rkSYfk5FWr5?=
 =?us-ascii?Q?d/eETlfAr/MQhslfqidAN45X0u3t9ZABtFmIjl9rrlyZxxHFAruWsw9e/tpl?=
 =?us-ascii?Q?gc+jAnATqYpCgPlWOMeutVLGNOMgZMJCRoC69QJbJECFYaxma8iQoIsQEiFJ?=
 =?us-ascii?Q?UyeVgaj3OoG8s9ozaXkMzdEVlrpg8phZ1X8XoBcdMRbKbcKczihY2Sb38JzA?=
 =?us-ascii?Q?JU5DJBHLZAcmYbwAOyVjq9p/ftMfUZn9PiOQ5fKrWlw7EW+hJoadBen0hQ/s?=
 =?us-ascii?Q?taTVp0+1vqQvWPEGPqjCinE8rS2VqHfmvEqzKJbZ5kdTpecUm1xESEOpvWcv?=
 =?us-ascii?Q?lRYe6n8fiZXwJM9HwV9M56ZN4CYVJHFvSiM31ujTeLUcXBdRalC6CBzn0RSp?=
 =?us-ascii?Q?2AgjFH+dYE+FOHjyX7Tjx8LsnfErGI9GfaMypzJeyvzUZjIZK/cYzYfmKFjK?=
 =?us-ascii?Q?PxjUIu8bRPjU/6zXkfh4bGJjtZqqGd4mbNUiDrtVQ7DHBl3ZZtQiJYGeC6jw?=
 =?us-ascii?Q?FuQ3qe+5KnsU4rBjXrmdFc1uUMyLYTpjzaaXWau+fUG4mtfMcWEogZTDjYv3?=
 =?us-ascii?Q?U3XuE3Az2zMUQgdKqlLgg9tkWHgaSUDU4Xs3qU13yZY1FjR6CgAuUGcg2gdQ?=
 =?us-ascii?Q?qULbV7vUOQgiKfLiQF1ccU8GiGQAYXzlHgdXgVsPNxzbr9drsI/Dp8e7rzP/?=
 =?us-ascii?Q?Ma1TP+1uMpgKVdHWdC84UhkEUp4UGKWRBdjK1e9+neuE0+xFXYJrNb1/Yqt8?=
 =?us-ascii?Q?U+TV1kMHZxbrX/2AKJSiDRoQ7Hja1THI8HXtHtwi2FziY2BbMrosNwwTv5r4?=
 =?us-ascii?Q?SjPZ6ZEKIPNVRhFDOjLDZnakSbq9qq6GxmUiPtVkm2P0NE8Kgo6M9y2DU6e5?=
 =?us-ascii?Q?8wv5cP15dlwDmtwNGnrrT28FvsXYrWUqhHpBzG7KiLVDIulDUgMWAy4n+snd?=
 =?us-ascii?Q?sdDVpq24BwommEFwDnc9PsyQPQgNUAzfhPKyE1Ca3+qEnhvmPwClbPq0dda/?=
 =?us-ascii?Q?QK/rMQcjXQuUWBuLkakvesh0wRLnXfrEYKdHR/674BOr++tBsMDolY8cJYnY?=
 =?us-ascii?Q?ZUlcij9+GiH9vOexxIQA9F0POA1jiLtaq/DINgC/SFFYF9XVNVacRt6pbqlH?=
 =?us-ascii?Q?nkKiHBoUtOqtQ72XHoGbE6nXios/gzSyzPTfSAKMXcr6GU28SWkgU3CfO6Fs?=
 =?us-ascii?Q?P6d+S9mlbulPShxKIytdAT9yW5zi97SNVRBq8spciXvlnCIIEtQmwfmQgTJp?=
 =?us-ascii?Q?br7b9TSqrcmqQ8Wc5lCwn+etUBQ7CMZTz3zY65Z7RklzqNWd3yIf0+eP8Unv?=
 =?us-ascii?Q?kwVtsxl395R2gtValyuUrHv78yuyIXYoXiZu3K+GFk0feHPPt0eJNfki90nT?=
 =?us-ascii?Q?22Z0dV+dazbMyCAI/8qb7LyrGSsitBKuPLQRSBN0PU+Q4xWkMqRswlUMmlEs?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bba0e0-6b41-4371-4586-08dc334634f1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 01:33:01.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiP5LqZ+Ym0Cd3KN1vBvaTkSDeVP13YPateJ+Evq+YQ6hOT6E68IuxyksE5pBlSPNYgP2Lz0Emp6L9hhzUT4Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5570
X-OriginatorOrg: intel.com

hi, Jan Kara,

On Wed, Feb 21, 2024 at 12:14:25PM +0100, Jan Kara wrote:
> On Tue 20-02-24 16:25:37, kernel test robot wrote:
> > Hello,
> > 
> > kernel test robot noticed a -21.4% regression of vm-scalability.throughput on:
> > 
> > 
> > commit: ab4443fe3ca6298663a55c4a70efc6c3ce913ca6 ("readahead: avoid multiple marked readahead pages")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > testcase: vm-scalability
> > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> > parameters:
> > 
> > 	runtime: 300s
> > 	test: lru-file-readtwice
> > 	cpufreq_governor: performance
> 
> JFYI I had a look into this. What the test seems to do is that it creates
> image files on tmpfs, loopmounts XFS there, and does reads over file on
> XFS. But I was not able to find what lru-file-readtwice exactly does,
> neither I was able to reproduce it because I got stuck on some missing Ruby
> dependencies on my test system yesterday.

what's your OS?

> 
> Given the workload is over tmpfs, I'm not very concerned about what
> readahead does and how it performs but still I'd like to investigate where
> the regression is coming from because it is unexpected.

Thanks a lot for information!
it was hard to me to determine the connection, so I rebuilt and rerun tests more
which still showed stable data.

if you have any patch want us to try, please let us know.
it's always our great pleasure to supply supports :)

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

