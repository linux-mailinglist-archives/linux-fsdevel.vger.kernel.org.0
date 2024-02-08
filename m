Return-Path: <linux-fsdevel+bounces-10842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1447384EAB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5193FB218D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB74F5F1;
	Thu,  8 Feb 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Crzk9hBY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824E4EB4F;
	Thu,  8 Feb 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428168; cv=fail; b=E384EbkGVDAVU0RW4/rvs+mDoJRtyA+K6dvdnW2VHr7paVKZG7TDeHcM6iGecN9szUh+Rhp7dv9eLJ2PietzokfOKn5tjby1E89td/wOd0zFpMbp5WhHQZ806bsewx0ZR0BrbBJmYpxM6tQInXfi2c0REMEroXIAJB00JEyhuhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428168; c=relaxed/simple;
	bh=DFmytCnBFHFCIj6YSkU13qCWBcICT7PMLoFtpfu3zs8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ls4Y0NBHCTuJV1mP0ONIJJ9LLErObnGrmuF5DopZCQL39BuGMbFf517OBqr/Le290EjDFgjzCx68ub/ycHALaHcbuau0zF0F2xPVr9EAeaZ310AZCmjOR50g1XV9pL1EXmAVunbZuchNkoJd0B1VfzGxcHBAcFcv5QnCGDijIns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Crzk9hBY; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707428167; x=1738964167;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DFmytCnBFHFCIj6YSkU13qCWBcICT7PMLoFtpfu3zs8=;
  b=Crzk9hBYBV9eStk0z/m0OEc+7IvwST7wguAefAmkbrfAPhP0ehVKWwSA
   jqplhpnqPxoE99ni5IsyiSjiWTzF/kmrZyRwmTsc6IaIwcu6JnjKoR64d
   SZiKOKFX/B31sY1BG6Gquy6xtqxPixazjZXlyMa0RvH4J1zCmB0lKohVo
   06gGaV7qoix+nfuFtikzJfmDdzqGM37LdPQepmHjYecAO1RjXmb41q6D8
   qJtXytKf7KA+q7ayybZMbNJDyy5NEpGbRqnWHEXEPHk/8kll08lDt2ayd
   UCa3xbhGSCqPVfW9FNpbxKl+6EqLF5h2xNlpRUj1GsMzIxggKQzfKTtQF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1226927"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1226927"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:36:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6399440"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:36:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:36:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:36:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:36:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:36:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsXkfFqzDGtAZt0PE2FWcSTkxVANTpcmUu5mIw+nESEyoxDpUtTK0mgDS/DGpODRQQr4BbgtEVGj/M6GrtwVta30va8SjMwxl2VpDaqpeB+tjfscsp2ohNMJK0yl7lwuU0Z6dk2tRdvfv0kwtKVZ6GYJADaVgXwMqbUSYPFSmNdPOfDJgNnaoPjn8rxvAgckroTkslqBiiy27tyL01uOXmEUwFbIBQm5TtUSrANDrrh9PpLc6nl5Sbl9lgKqtbIN8eAcm6N9+zlS8Fvv0uRf2zuD+PYCe/FekuQE5PTOy8JGAqRwmxv32uJwBksOACnS66bg0T0VDc/Cz9CtwOYQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhFlyvDQAxrsl/YsH3fiMiywNdAOoaUFumezsh3ODZ8=;
 b=GL6t4t9bQ4jnmXk9OqRdlVrMf/5KEbBXhrb0WAUdaTpFGnwQy4V1VITmb+d70CT2Eh6nGrcZDx1n3iAiMtGtVQDDZswxebkr88XB7R8JX1oevdmXHdkgqKJL65aqrXurw9QY25Q3S6ITCzEoBcPZvcnyvEcAFNlEHfsldmaVlMLy79gnQkUp4SaUTaq3j6LlKVfNrWmb3n+1OI2O71vCbAtrazQN5W5DiQhJBq0buG4smcxnlynE/K8K6gfopr8Qk3SScHqUmCCkBnLM+CYAah2ap8hyDgpCy30cg231faiZfl2OooH7+gkmIA8Q3brQkAUGlhBut4YxmLoR4nwvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 21:36:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 21:36:03 +0000
Date: Thu, 8 Feb 2024 13:36:00 -0800
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
	<nvdimm@lists.linux.dev>, <linux-s390@vger.kernel.org>, Alasdair Kergon
	<agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>
Subject: RE: [PATCH v4 04/12] dcssblk: Handle alloc_dax() -EOPNOTSUPP failure
Message-ID: <65c549405cee8_afa429495@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-5-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208184913.484340-5-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:303:b6::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: b4875fa7-f08d-4ddd-5349-08dc28edf320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvhC/iXdcWNMy3BN5p6HVxvNtvyJxRWhLk+zaKORWSwu7ndBD3+nCnYdNmyvvz5a27oq602Rq7/AUV75vdQ/muoC/H3W2uN4B5RyKPr+g4KY+8OnG1PNMXRDmeHwzmQh55Wb68/ZuiHYEBhxexL/zzbPz9YRFZlRfvXFK4V9hNP/8oIZzwo6o3R93KLrGUoWGNp5lGt66Xutb0dGTPYHCc65DxAlq8Qxo0ujfdpt7jDeRy6yL9Ua64IqEOvoarh1YZbCfLRQ8LIt92zBeOh9OquMgYdNBdEto4sKr62SsEEOtdtA0H+0NzPYHex4/UBdEDYgonMWx58xCC68XqE0gKS2dhTikh4fEef5X1fztA22MzsIA0xTbzJ2le+g8gaHqowchmOMBfrqBib8lSSKyfnJASBvg4mSA8I4I+aFPFs18vNWubu0PCVBWS7gGJXcsuaWc1af4mDn1QabrAXaD4HbVz4niqpHZB+KbTxLqeY47Dv0ZMSyJ6JectnwmSICeMv3ZEiPb0u/KWbQCRKh5BUGkg+zLWdijghW50drQrw0EnFGPUFSKkvhUoxBhqkU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6486002)(478600001)(9686003)(6512007)(26005)(2906002)(66946007)(5660300002)(7416002)(110136005)(66556008)(54906003)(83380400001)(66476007)(8676002)(8936002)(316002)(86362001)(4326008)(82960400001)(38100700002)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LQorjk9IE1YsjmQUrOHbVGIZ3JZfna5XFZ4592qhOr3Obrx6L02ucKAHT8KT?=
 =?us-ascii?Q?TU8Oheip/+SJ8RR8/doi08RjXI1oh+hu/D9yi5dBUKE4HQLY59enYFE1kVsc?=
 =?us-ascii?Q?Jd7qgim6jRk9wt/q4DHx/uftsVHt80UqHzwtdf6vDprHIpx1lwsFL45RTWgB?=
 =?us-ascii?Q?2CojNLQiL+zJNL39F7PMf0GnQ0xBpmfQXgSSwrafrWq696Jn80BvK5VIY/HJ?=
 =?us-ascii?Q?kS5UCly5FQZoogqnQaikehM/A4yqLzEedX5zEkPtafZbhS/TJGupuJmWfSFl?=
 =?us-ascii?Q?lRzurbWTqpLzjr9Fm+9MkPGgt7IzFBV9JWJV9csT+XbOCXLma5SGQSlOULQj?=
 =?us-ascii?Q?5CfCwj9TxLD10Qq/WwY7EqtLwEeRVQ38B2kC7KDhvkDwBuMQr9nmRN4p9+wG?=
 =?us-ascii?Q?9FQLaOHTq+N6pnDCR43N1XrRpxzMjTzhx07o/DK9iQoIvJyaZHVhkLNQlmRq?=
 =?us-ascii?Q?E5X52wM6yVlhG0OzK6Cu/PGwyRWneWegl7fqPLR9rYgVmvN1WpABzw9HhZ8h?=
 =?us-ascii?Q?gBU9cKf8kZcGUnXmPpZy1JVAtMbxajqwX2jdCjEuZLq1D8+bPb2kLx9vI04J?=
 =?us-ascii?Q?5Kta9PmoSQ6X1RDC74Vel6VQamn0MjNVyopHKdstRZuDQ8NXMiUXvh0DtOcH?=
 =?us-ascii?Q?mtl26DH3MrSgMj5gXHQaKdWCsX4nIAtEnvBYLsrmdPouL8IVkOcYvITPFk0s?=
 =?us-ascii?Q?fcxUDUQOKOv7D4BqubyU/9euy+xF2UkkAY7f4N++lM8lWcfSDA+QD/DTv/uS?=
 =?us-ascii?Q?YlJJK8t6ALg37CsGVi0VcBKy+ElA4pn9m8Ntvzp5/cmxs0UWOJjBUjA+OcQc?=
 =?us-ascii?Q?n0h2cRcfuISuVzegtzy7X/vCMGO3wgF3wqmsVKDHteqJK3bxBvV0v1DnRKv5?=
 =?us-ascii?Q?hUfiDIq7d9zewOQpfPPkx4zmwpkBEWrWMUO3UNaBVGNtLzfquDf9o4fXvBwo?=
 =?us-ascii?Q?K4YJuCIq3PHKQdub11a2puavfx9iZvo/+ptnXIpedk+q9iMZeYv1J2d1c3uD?=
 =?us-ascii?Q?LQGOgdgASJpjTxufKExU7iC/alfLamtr/3f6N7t47hr0Z0nJ/GdBbLCk8YEZ?=
 =?us-ascii?Q?9oCSDzrnRpP0PFiF+bRpYqC80tOCmu8Y18P2AYExQMhGluDJ/MEcwfYJdjw4?=
 =?us-ascii?Q?S67xqXjhEVNeZrAENarHqnnwZ6bSygy10D5ximtWW0VOy1DUJ7KE6Juz45xO?=
 =?us-ascii?Q?qYE+sWuCtCwaIjjuDY9yJwiDv4bxiZDPB88xxipGAdrKqOxznvPLsNpWRIxZ?=
 =?us-ascii?Q?nooKEvVSEYsDyFJ4O7M7pXsHjYOSTBYoV20bsH8rNmOBlIcwAm5qMbFEpECT?=
 =?us-ascii?Q?ymRWs3JIry/c/NtbYLfH5mvGlRJ5v8wmQjqfTHsL1KBZdX1f1JXR6GYNRlWG?=
 =?us-ascii?Q?LMGn+Qg1dgsskMzfkYh0bOKZON0urQ1RPm6zp9QanbsgiqdqppAq8PLNq9cQ?=
 =?us-ascii?Q?vkmHmbE+RDWA1PCLa+wwRJJGtzcuZ1O9Vo8lHuYE027Nw/2lQAXK14o02oUw?=
 =?us-ascii?Q?cjHBz/820qV2RxUJJEzLS3A96HhxtsVvJ5Qbikb2gY7wb28t16hiZktBM+Hq?=
 =?us-ascii?Q?p3PzqpIo7umRm1mDA88aXsft7fSmBlWHqQAwJnT7pvojpveLBF5j+Qc0U3yR?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4875fa7-f08d-4ddd-5349-08dc28edf320
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:36:03.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoEXWC8XeIBYHEjI6MTHEBluru665ThSH6AmdRy2aVt2ZK2Wo/K/0JoOIIy+IQsmlkXORmFiq2Qc7/yrzUaAdwlKEAOX6p6n+iEFfqPB2+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> In preparation for checking whether the architecture has data cache
> aliasing within alloc_dax(), modify the error handling of dcssblk
> dcssblk_add_store() to handle alloc_dax() -EOPNOTSUPP failures.
> 
> Considering that s390 is not a data cache aliasing architecture,
> and considering that DCSSBLK selects DAX, a return value of -EOPNOTSUPP
> from alloc_dax() should make dcssblk_add_store() fail.
> 
> For the transition, consider that alloc_dax() returning NULL is the
> same as returning -EOPNOTSUPP.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
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
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/s390/block/dcssblk.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 4b7ecd4fd431..a3010849bfed 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -549,6 +549,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>  	int rc, i, j, num_of_segments;
>  	struct dcssblk_dev_info *dev_info;
>  	struct segment_info *seg_info, *temp;
> +	struct dax_device *dax_dev;
>  	char *local_buf;
>  	unsigned long seg_byte_size;
>  
> @@ -677,13 +678,13 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>  	if (rc)
>  		goto put_dev;
>  
> -	dev_info->dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
> -	if (IS_ERR(dev_info->dax_dev)) {
> -		rc = PTR_ERR(dev_info->dax_dev);
> -		dev_info->dax_dev = NULL;
> +	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
> +	if (IS_ERR_OR_NULL(dax_dev)) {
> +		rc = IS_ERR(dax_dev) ? PTR_ERR(dax_dev) : -EOPNOTSUPP;

Just another "ditto" on alloc_dax() returning NULL so that the ternary
can be removed, but otherwise this looks good.

