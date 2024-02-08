Return-Path: <linux-fsdevel+bounces-10844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4D84EABA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50481F257D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF314F5EF;
	Thu,  8 Feb 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdHQKh/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C74F1E5;
	Thu,  8 Feb 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428380; cv=fail; b=Mp9Ecpwij0861qfTWXFSLYfdwh0ogesY2IbZWtgzsp/O1l3WdawXA7Kyo0cN54OLxpcAiw300yJhowQzIPT/wS8+a+0sXNgEDxM2B4ITAfu8Rpk3bZBAJdh+0k09lH8ML+Ikvs5m9qmo2tJCyuzoc69FSPr0PNrKgC4vAl+bsKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428380; c=relaxed/simple;
	bh=e04vik2XqVDUwq+ZVznSpbUkVkadqQKF2/NPHzsc9V8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Im8S7TqlJM+lWqyVb0tUpGdFd6Y+dRQiFxDekIn7l2AzOgrZiBuKX24cI51YtjoKHF5+zza1Ucc8HgnPHgpJa1gEBvmCKdNM36qRAGzxJVN2soKQ89IROE/5EEMJLxbJZx21ZJpYevWH2LMQ4fdbGkK21VZcAignd0PrnzCWrj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdHQKh/Y; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707428378; x=1738964378;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e04vik2XqVDUwq+ZVznSpbUkVkadqQKF2/NPHzsc9V8=;
  b=bdHQKh/Y1JNxe7nQxb90vkaMEo1MelevCO9vGNrzuSrvY1bMka6D3W7g
   kpj6oOepCm1bCDOFNmKVzeG217Lg/YFYVyVZ0ALGenvPZzNHLmDWkOBqv
   Ujp+oScm9W2sO5pfUxFQjssiBTOBgXSZmlAGe6na4tE66kE8p1k/Dg2Vj
   IojeVYob2hn/5WRueWO9Yr3MibAW5dmX8/1SXRhU8YX6c3yTMdVg4YfAJ
   YKlmrO2IYEho47uown+A15aVFC8HJ9lnkvG57fiP7tDr8h7LtqwzS8eIS
   1C8/JPq2/RVCbwPHo8qWqzUwexfSKxqp3lwTrwg3b6tpzLuIAViaOphYW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1621021"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1621021"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6387886"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:39:37 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:39:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:39:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:39:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNkEwXFcMAiyclflwRqOwhhTCsq09YraE3mfSReZGG/Q7aH3uwmpqjYuj4+lnDgUzRW2liDdhq+5FhOZtvCIjmnASV7OypqwIUOEXpFuUTgiBieXkvvOOiwhIzwqOnTthNKMkAWQ8gKbQUIQpQDXOyUT4dwGuSYI8jl8RxhAEFsH/2A9qD0aO6QjaXnUoc16K+NAfcGnL8YwZDXBIYAkiLTSJX8OEqJugYlOk1m3SWaSRMwqi9LrRuKQbcKi2ZnuxKIfQx3r5uJs33xNphveqUmb2c8jPSHkhsC4G76KQ+IHW6CfcAYgOqdaVeOM4VGP+DtWna+YiMtxpmwkwoT3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb4h9sk4QF3KdKLljsUvxoh6rex3+4NAruHk1lpeETM=;
 b=RrUUvbC0IxdDcz5BKMAIwoSPOfOmHnPmgOE6jX9BfY1Eb75/+lCgWonmAq5KrRHwuHOk2t0V/IYwAZVgcZB5P+eiTu8O1EciAHckFXMjn4VGiwFHfrg5/i68Pkrd5Rn2zCsR2LS+rR3UEoiPBdda2CMO2JwoS8I/1/TyvljlVuRNRHyo+IaRZmaFAoh75oChCR1VLpUul+5AiThOF9zTOSeE2K2qfLE3vBNEnCjBAEVMjiSP5vmPaWCPpF5ec3hqCVP8EjTzi+S3DCbC7VF5NFLU8w6pNMmRsVwUlZdVlc/xUjai5TtjEnq91JJNZ78dRMUSkhaOghNAYKvIUKZZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 21:39:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 21:39:34 +0000
Date: Thu, 8 Feb 2024 13:39:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
	<linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <linux-s390@vger.kernel.org>
Subject: RE: [PATCH v4 06/12] dax: Check for data cache aliasing at runtime
Message-ID: <65c54a13c52e_afa429444@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-7-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208184913.484340-7-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:303:87::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 9037cc41-42d8-4aaf-e585-08dc28ee70c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1hH1Eubwb79/MmqcAI0sZX5HrUVHqn7nGhkrEviqUMb3j4xMAkOiCsO1b4vpTfS48DoW0AuVhDUrOEYsnLr9kQKbBROhDbV2dQ2Uq4nYMJCNzNTWoADmz/a8fizsNPrDD63P2VyXD642QxAkhQH3UBYRw0jGJzKu09UdtDtmxzJPS29wI6/ERis3yw6oJfwiDxciX0PJ9t5iCjMif4Lx1+hC2Tal1hwKxgClPgGOrRhG6TFtfHH1Ht1SZ6EML5dT5dEOcK1fUzD/xxTy5RKFL9rPcBOtqiv5JBPt47JnUp0dqX3hS9yi2SjrSKrt/dsOXoUvEsuql0VhtgSCbgXZkdwnO3fifE/zfn3R6Bl9cNspYucNAt2/dxvHmpctYWj6Slw3GkK0BGc4OAbB+ZjOZFt7aNBrKLmzgdtYyzJD5K4HKgtGw72NJ1Ta8DuXtgoERI3n65yfZcDZ8xsbYKrZl/T2AzETTk7NOYD5fsf5N6SClQtSSQF9GrFzb63ZrGBd0i+8lPD4QHDjDyCYlhG2UAQBMNyBgd0+ebNgqMVguyNv0lbaptvQWTJT6wmW5Ua
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6486002)(478600001)(9686003)(6512007)(26005)(2906002)(66946007)(5660300002)(7416002)(110136005)(66556008)(54906003)(83380400001)(66476007)(8676002)(8936002)(316002)(86362001)(4326008)(82960400001)(38100700002)(6666004)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/nRGhgD8evUSN1FoSZfuUnDJiVdVczMg7t9uKrzlEjGyarUprsEkzpeaCGcl?=
 =?us-ascii?Q?68nMWvD9wpjS22R/a+mKlMWw8Vn49/YZMMQQu84kS+PmKjZ5xkLPdVu+jfOh?=
 =?us-ascii?Q?FYOJ0iH/3OaxRXgBs+uY3vAshMzKFYRvYSUolI2SB/2L5USB3X1N/nNFr/to?=
 =?us-ascii?Q?iw6Yn37uYzWTbOAapUvk00vKlYqDCTY0AL1bCIf726ILInEYoGJYgLzJvS8w?=
 =?us-ascii?Q?+/fD7FE1gXmuL7ZK0Wfirtg/0PLdBB+IDN9MZQK8IV/2gim/Xuwmwu+bkeou?=
 =?us-ascii?Q?DHq5dr9t9Gm3MF/usgqjbOFxpd7YLH0mkS7ZC27mMv5Ke0do+89DBe4GSkfa?=
 =?us-ascii?Q?0UmFGhfT6vY/ShUfrPjsJgW83lKQtsCwRIa7+yPqtUTBAGUoK+Uj0eUUfnvf?=
 =?us-ascii?Q?bUeLgE9JehOQ6jdrImDDaEn8JMv5yVzxgnJefB55SDV5id9kg41m7H1aZBA5?=
 =?us-ascii?Q?YWIHPamuvMgww88XzCYmjgsdgFdY2gk7w2ZnmzuFsqwtMvvbTtdrnGl3iy0D?=
 =?us-ascii?Q?20UdUHb0SWsPOzqlL5ppnpCuCIifguKszT7NUKy1raQ2QGK211r5WZSo1FDP?=
 =?us-ascii?Q?hFNyohjQx2TtxlTSbeEBoCz3dQ+zti/i5pCJvAKU2/+ANQXLKqF3ayzqewj2?=
 =?us-ascii?Q?mwm7ZvVYp47/13uxDr6ZaE0pNNIgBDwXcTt0Naa+3f6fXdQpGZfWaLkSYuQV?=
 =?us-ascii?Q?YoZKsgDQFzJDCHYyNnPu9oLq22m3RNayz16b1C6lxxblBRMeS5UHQiUnnpfa?=
 =?us-ascii?Q?BsFEnvkKk7cMoSPPq+5dME0lDhdFf2KfuvolYfIQGls318+xYsWlxbdlssJK?=
 =?us-ascii?Q?gQgk+WOCBfn876mY4nPQNJALVLB0+xAw814JT70CnXo3K3OijAX11PW7v/WP?=
 =?us-ascii?Q?OwFeVTHTjTdrgq9eia79YpDueEkNPubXtouh3gN3r97tlyVCTwnonU7cIJqR?=
 =?us-ascii?Q?jnHuCzehDHR/6LzOpW6SxW4ZYSGUVB5/V3Y64AJ2Y0jebk5UYQt/PgCZazrb?=
 =?us-ascii?Q?ko2jUf+QEnLxYrnQRZAYtryQg/IiQyWfMF7D0dxLbEWJUFj4kuufHE/XZM6M?=
 =?us-ascii?Q?0gAmm46QK8iEmSF8GdD4XYuKeWKHDSDT4iTzVR2xkuiZR0Eo6uNNSdCOQrhz?=
 =?us-ascii?Q?mCwFkT4hwSq9puqi9k1DvYTxCQ3MpAtwJk/w/QvQxFaCBiJAy0t+9RsPeWo5?=
 =?us-ascii?Q?1CmRyVl/DMg/gY8oI4TxKtUlKOYaVZD/vC14DymPpWy0ctddEOO8YCMAqSaB?=
 =?us-ascii?Q?G1uI/LSBvR/v+Qgs/ea2rlROm5ExXjmod/QJpuG9pOQpmpawLJhKX4EVgaBY?=
 =?us-ascii?Q?scDQ4mOjeUQ0lKTvcWlHCPkADiJojTF/hFX5D+QBqK3/lGeNmmmzTrX90pvS?=
 =?us-ascii?Q?a2uSc30Z/eG+cNl1g++6CDpLZJKwAJHbMG/T1kKnZL8AtfaWCIK/Z4tkHhi6?=
 =?us-ascii?Q?aWeO+dd+C+mHMdWjJXmFVTmrwTxUH6XBvzPSA4zsKGlwFRl7TA96gw36vTU1?=
 =?us-ascii?Q?TzAhriBthmuF+KrnIB+ZUDjEC2W/VWTnb6waJMeXm2WTHeG+WA0r1Ac94nwe?=
 =?us-ascii?Q?x2r9StQ06DGG4yFIeFnq6HuV/WX4Aw0cwNQ8+dkIpxqmaxme7BTEHA+nAlVV?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9037cc41-42d8-4aaf-e585-08dc28ee70c0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:39:33.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahbSPHZ7bAH6pFyze9pjnNVjJSSLfzhTS7kaAu6gQY/I+mU1HXK8OWTZesPelOHtxx7/97417q1uM/whzsick3BnNS0fpviokC8IMd03eBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> Replace the following fs/Kconfig:FS_DAX dependency:
> 
>   depends on !(ARM || MIPS || SPARC)
> 
> By a runtime check within alloc_dax(). This runtime check returns
> ERR_PTR(-EOPNOTSUPP) if the @ops parameter is non-NULL (which means
> the kernel is using an aliased mapping) on an architecture which
> has data cache aliasing.
> 
> Change the return value from NULL to PTR_ERR(-EOPNOTSUPP) for
> CONFIG_DAX=n for consistency.
> 
> This is done in preparation for using cpu_dcache_is_aliasing() in a
> following change which will properly support architectures which detect
> data cache aliasing at runtime.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-xfs@vger.kernel.org
> Cc: dm-devel@lists.linux.dev
> Cc: nvdimm@lists.linux.dev
> ---
>  drivers/dax/super.c | 15 +++++++++++++++
>  fs/Kconfig          |  1 -
>  include/linux/dax.h |  6 +-----
>  3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0da9232ea175..ce5bffa86bba 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -319,6 +319,11 @@ EXPORT_SYMBOL_GPL(dax_alive);
>   * that any fault handlers or operations that might have seen
>   * dax_alive(), have completed.  Any operations that start after
>   * synchronize_srcu() has run will abort upon seeing !dax_alive().
> + *
> + * Note, because alloc_dax() returns an ERR_PTR() on error, callers
> + * typically store its result into a local variable in order to check
> + * the result. Therefore, care must be taken to populate the struct
> + * device dax_dev field make sure the dax_dev is not leaked.
>   */
>  void kill_dax(struct dax_device *dax_dev)
>  {
> @@ -445,6 +450,16 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
>  	dev_t devt;
>  	int minor;
>  
> +	/*
> +	 * Unavailable on architectures with virtually aliased data caches,
> +	 * except for device-dax (NULL operations pointer), which does
> +	 * not use aliased mappings from the kernel.
> +	 */
> +	if (ops && (IS_ENABLED(CONFIG_ARM) ||
> +	    IS_ENABLED(CONFIG_MIPS) ||
> +	    IS_ENABLED(CONFIG_SPARC)))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	if (WARN_ON_ONCE(ops && !ops->zero_page_range))
>  		return ERR_PTR(-EINVAL);
>  
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 42837617a55b..e5efdb3b276b 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -56,7 +56,6 @@ endif # BLOCK
>  config FS_DAX
>  	bool "File system based Direct Access (DAX) support"
>  	depends on MMU
> -	depends on !(ARM || MIPS || SPARC)
>  	depends on ZONE_DEVICE || FS_DAX_LIMITED
>  	select FS_IOMAP
>  	select DAX
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b463502b16e1..df2d52b8a245 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -86,11 +86,7 @@ static inline void *dax_holder(struct dax_device *dax_dev)
>  static inline struct dax_device *alloc_dax(void *private,
>  		const struct dax_operations *ops)
>  {
> -	/*
> -	 * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
> -	 * NULL is an error or expected.
> -	 */
> -	return NULL;
> +	return ERR_PTR(-EOPNOTSUPP);
>  }

So per other feedback on earlier patches, I think this hunk deserves to
be moved to its own patch earlier in the series as a standalone fixup.

Rest of this patch looks good to me.

