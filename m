Return-Path: <linux-fsdevel+bounces-9726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E8E844AD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004AA1C2612F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB16739FE4;
	Wed, 31 Jan 2024 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WA+6lcwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422039AF6;
	Wed, 31 Jan 2024 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739493; cv=fail; b=azAjxlrYtB2kfi/8PoJee+wJgIwsUDsQXAxK2N/TD2/1lMX/S0TCxl2PEexR3RFac96SpbtYLLRhau2oO8z22C0oVUzE27s58U/+MuCwLN1GAZbBbUPAZmNOJYu8+m3c+uojLYsXzMqYDDDVKZTRuCTDdUxkeLYyFN5AokzeE0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739493; c=relaxed/simple;
	bh=USRaBffgPeqnDNrIn6txtH9hkV6FYYB+QVuxMQ6k1LU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WSY6GCZRyvKKkRQ9huwfO9aKR0gf7zAa3d6N0+QBXOmSMwTYsFcF+jVp+CDhkR78UnjuhKFwUOA61Fg6bEKY/bIpDD5gNLT6AHbtNcwmQXVtNjexsLIRPEWQ/UdIhlHDc42npK4aFL0z7GG5TYxoUoeNX7aQbaDqPxtH4Ii0IIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WA+6lcwU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706739491; x=1738275491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=USRaBffgPeqnDNrIn6txtH9hkV6FYYB+QVuxMQ6k1LU=;
  b=WA+6lcwU0JBgqxD2T3MFkXh5hAzbujO6/qLyHq6eW5sfINnCS9TKjG2p
   d+7PRjDkj0B8SM6p+R/L/MzMwwgNK3SjhaCXpY1JKqWkqBeoU9TTYqmgI
   YO9lI34OQfQsGATwkj+kbfYswhlpWgFTorfWnItD0EcV39fNWdJd0C/HV
   cjitjBTznB8hdgxx3oPpyBseEkb6P4Mtc7jp9DqWgb1QF+geyG7usufHI
   KwTIDUPR/vFlahOlECQlW2pLYbVHWx6RzagRikX/F7OBw8m1EV+Y3FkIJ
   P2jIFtc3oVHbdEdpZ1jwyIgYFS9tUwFREGLK+6y8Be2oUwmyfVKz6AGY7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10377645"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10377645"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 14:18:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822731682"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="822731682"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 14:18:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 14:18:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 14:18:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 14:18:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 14:18:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHvtR3iihjouZEnxNoILeZwb1XYdUC7E6ZKxVxQjtB9dTcbIERCW0RqOkyh2m/cB44vNwjPagXoXAwV05TVf3mzfm36SLFL/Y0ttx4HF5h2xE79IU1AyqkcTdXsbfPAzSOBc9CZWkyiybeMIBiUoZZksqsIIOq52IVKSmg++oCbCxmuE8LXXUgUYhYKebmiD7ITRBQznLhqt29UiVvPLWN3Ij/BQWZcRg9abH0LVj4dWBixDO3BEjsgp8pmldKkwD/jE6wGN2C14x0Lm1i/TnkafjiX5/3UkSfhrH0qX78pVqjgha18TzyICuHeDcxXYSeuDoFKZnHxtZaGRZ3/6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9obXNdC5gV2QDYEOS6jLGF6bsxk7kqkjBWvJxoW8iA=;
 b=izNzQRdDy2IysDrNGCRDUFyNOeXFzO0BxWda9rcWB1gGIsiiEjmk5XcYWTUAJ9WWoebhf9UXeeYO2XoQTgHfRxve4Oo0/hCdVWXjTOFfKrake9JuwkD0Rw2WkQP/gSeBhxtD3dyh15F10Eg9ngAZerJJQ6HCyQNXhC48mmlMALUoWjUH6Qa3zsUFIwwEplPIlW1CtMvF8ylHIjjsXBQ1LTfe/WxBizQeXn8Joq8FrimGndxxHAunaGkQ+fi90V5yLSoSrGKN6ugWj5nmGvCm+72IDs5xZj02JkDBKhQkf14V5TKL3FE3Ctk9vkoBaRZBkiBGk30YCXKDFGQIsqiltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Wed, 31 Jan
 2024 22:18:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 22:18:05 +0000
Date: Wed, 31 Jan 2024 14:18:02 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-arch@vger.kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, "Russell
 King" <linux@armlinux.org.uk>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<dm-devel@lists.linux.dev>
Subject: Re: [RFC PATCH v3 2/4] dax: Check for data cache aliasing at runtime
Message-ID: <65bac71a9659b_37ad29428@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
 <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
 <0a38176b-c453-4be0-be83-f3e1bb897973@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0a38176b-c453-4be0-be83-f3e1bb897973@efficios.com>
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 16607945-ed0c-4da7-9bbf-08dc22aa7f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uu8hbMoBxFuihGSn7uLry6e8wUXmUWiKfgkJTJRK8zeUo1HyTI39O/QWn3T8hhhtlMFsu1Kl3UPI3CUk+xBZQARi63FeaM96RlWkVxFUY1vU2yFG8YjQMmsb7A92Pok2sTSYTBZj8RjQDSQXPUiATJasgb7REMdgCKtUjupGbaPxFsDyDFhju5sisriONPJmjhwYPSZebD9LyvNkBtdBdpPt9wBViHDflQgcAtpb4toPT6xZ1Udfvm1Jw8v89E/xnYdBC2J7q5CVaOVfgJnZb1SFJjEfNVk6t1rlgt0l6jPfOaamElb8gKe5IHQUU3gwf4X+qcvnOj1DE+vISidT7LSzeQH9Ka3QuGxXJ3hxHRJOz+g/EaBQC+D2XGi9UtXinofQHa7yl4bLo8K45jdHOx9FTtpE0Q0rGx5MQqQkES1Si0agfu7J0uurTqk/gxiavOKFygjMKYI5mnleQ54pmg8S0XgBFgQQKDzEXdhbYG3fPLfjJIU0RQ8hUepO8BZf6p2TzzMWM61lYtN4Pe/dcNrBCjgSPzc5msNVjtyj3mMDD8su0rfu8KoMn0p1Mf4M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(8936002)(4326008)(110136005)(8676002)(5660300002)(7416002)(54906003)(86362001)(2906002)(316002)(66476007)(66946007)(66556008)(38100700002)(82960400001)(53546011)(6506007)(6512007)(9686003)(478600001)(6666004)(83380400001)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BloBaanuO4qsgN4n6m2PjArWrvJKg0ChGs1MfLpShd2l0XhBUsGR2hAfK2T4?=
 =?us-ascii?Q?+VJ5+k1NJYW+0KvDkATizAd1/buZUNirzuiVWbm3I/o2WK8xMfO8VmcCBvY2?=
 =?us-ascii?Q?nY6ImC8NxT1nn+RHsKMfkPJqJD6OcVy+DT0/ZrnvtGU/RVUGmlTT5dYBUCeU?=
 =?us-ascii?Q?hLwaE5NfZeoEnx487Zmw4ELZHLruW34ALUsWIUMos6JmIQCoL8Ih1D+BpsZm?=
 =?us-ascii?Q?GiHvByC9U7xYGc8MQByjQI4mNstQHqUH2/4Rh281qzxOI2Sn9NzYKhn2SXis?=
 =?us-ascii?Q?IdrsbMKjmhihVS2QN3r1wd/aGvNovskR9taD7iFqc5swpYC2+eRRqhdPDk+S?=
 =?us-ascii?Q?GSRPT1958Qj5OQRkkHBTr6ARd4RZOMCu3GHnZ5UZYe3FAEXlU6+s2Ny1i1Ab?=
 =?us-ascii?Q?JtW/AKO9lFmZwl3CzEl0tAg6ojEOhpd15N+SDiPRQ6yErVrpKxyfcRoj476n?=
 =?us-ascii?Q?d4QQbeSSx7LLts/KhEztmmtMRdtI9pG6DekEHPtakMZl1vBO+cb3nIYWZkQG?=
 =?us-ascii?Q?1jLjxI63KuQ5lNs0KnOxEZUg2TRTlxRpKxslbxdUuUp987tAfoCoqa9q8ITz?=
 =?us-ascii?Q?f8FKqW9lexx8W9+hgVDM3f0TVY+4NBx4uw4OY5Lc90N6zmm/So1K/w+r7HH2?=
 =?us-ascii?Q?L8jEuuMTS/RSi7S2KTQsk8EoRwquFQ35MJOSzGjJOyNbA/ljK2PTnhgJpdO2?=
 =?us-ascii?Q?k8RwK++haR32eF+KkT/HDkxuvrQUSy6osENqUl3rsvqhCwCPT5XQY/VjZN0u?=
 =?us-ascii?Q?pJQe3UrB00CwjNYQOOpEtyF/Q95Je4ucw5An1Ak6gYwmKjnJLcMtNZecCVX8?=
 =?us-ascii?Q?+xncJ0UliPH5azBfdM5VSRvntT86fTd8wC1xvXyUX8dYDm5z3iXYU7W2t69J?=
 =?us-ascii?Q?f87g0iP9d64NVciPBdIgc5aDTQvtpgxwcgAAGkCHL0Pl4tDplOVhT/JFzXSz?=
 =?us-ascii?Q?bkf0yLLwT/2xVNeAFvqjcu4Rhh/TYzAy0U5QVGCGalhLN4Ba9+Q3nigvPIHa?=
 =?us-ascii?Q?ieyhoJzprTPWpWpmKOFYzJFFtcfF4hQB3sUL8hDcInYKkwErkJadPSRiluh5?=
 =?us-ascii?Q?9g+g9WCF3wBucdQh8HfSKADL7cjcFiaW70MJQ8ZnrIYswTHbgNzjXEuNRYtV?=
 =?us-ascii?Q?gR3r3BAap7sn8H9ZQE+4UAspHIxrW7lyJMhn05HR/rFi8ccu5x09H3djxO7C?=
 =?us-ascii?Q?jHz94VWt8t6/VGSOrOx9cJUplyoRDbC6LhBdkQd35f9DGsRoirB9G5cuK4ks?=
 =?us-ascii?Q?UVA8VjUUff4xCuAYzsWJVY7M9aS1K8Wg/FVQ4vHuXKZ8SXcAyOEa+r5eV8wH?=
 =?us-ascii?Q?fVFLowtEoajltrAaRXalk+sItaKAHmGjKUyXLOcENi2Q6+J8v5y8QU4Tt/b2?=
 =?us-ascii?Q?3NkkjiP4hVmN6Ap5QD/1SGq6nelQdHeiNRQRKgL/y/oGuXp73hBp9aJ2B8Ea?=
 =?us-ascii?Q?Y1MJMfkU8s3UBWdz9H5qNlWECurDvxO5A0hzPrQXTVR4eU7VCP3GGWly52pR?=
 =?us-ascii?Q?LkCmvZK0R2M5kMmhzw+58T9IZFD1GKRqbIs6PzFrtCS00HRGKE86DI/xOlZb?=
 =?us-ascii?Q?jn/DjCm5MXS9Cvcjku/84EN8YSGDqAdeKgmLHMcudpMEutd4mvJYBAbkxJHh?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16607945-ed0c-4da7-9bbf-08dc22aa7f40
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 22:18:05.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJbrUCk6PabsxaM4q6FqLtOZtVVfGSkrEecsHcs4WQZc1AW5cKruSBCHBY7DT9LjIyftGBAE5sIFf0A7QbW0n1nr/TEJ+k0pNePI0WuLQ4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> On 2024-01-31 16:02, Dan Williams wrote:
> > Mathieu Desnoyers wrote:
> >> Replace the following fs/Kconfig:FS_DAX dependency:
> >>
> >>    depends on !(ARM || MIPS || SPARC)
> >>
> >> By a runtime check within alloc_dax().
> >>
> >> This is done in preparation for its use by each filesystem supporting
> >> the "dax" mount option to validate whether DAX is indeed supported.
> >>
> >> This is done in preparation for using cpu_dcache_is_aliasing() in a
> >> following change which will properly support architectures which detect
> >> data cache aliasing at runtime.
> >>
> >> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> >> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >> Cc: linux-mm@kvack.org
> >> Cc: linux-arch@vger.kernel.org
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Vishal Verma <vishal.l.verma@intel.com>
> >> Cc: Dave Jiang <dave.jiang@intel.com>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Russell King <linux@armlinux.org.uk>
> >> Cc: nvdimm@lists.linux.dev
> >> Cc: linux-cxl@vger.kernel.org
> >> Cc: linux-fsdevel@vger.kernel.org
> >> Cc: dm-devel@lists.linux.dev
> >> ---
> >>   drivers/dax/super.c | 6 ++++++
> >>   fs/Kconfig          | 1 -
> >>   2 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> >> index 0da9232ea175..e9f397b8a5a3 100644
> >> --- a/drivers/dax/super.c
> >> +++ b/drivers/dax/super.c
> >> @@ -445,6 +445,12 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
> >>   	dev_t devt;
> >>   	int minor;
> >>   
> >> +	/* Unavailable on architectures with virtually aliased data caches. */
> >> +	if (IS_ENABLED(CONFIG_ARM) ||
> >> +	    IS_ENABLED(CONFIG_MIPS) ||
> >> +	    IS_ENABLED(CONFIG_SPARC))
> >> +		return NULL;
> > 
> > This function returns ERR_PTR(), not NULL on failure.
> 
> Except that it returns NULL in the CONFIG_DAX=n case as you
> noticed below.
> 
> > 
> > ...and I notice this mistake is also made in include/linux/dax.h in the
> > CONFIG_DAX=n case. That function also mentions:
> > 
> >      static inline struct dax_device *alloc_dax(void *private,
> >                      const struct dax_operations *ops)
> >      {
> >              /*
> >               * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
> >               * NULL is an error or expected.
> >               */
> >              return NULL;
> >      }
> > 
> > ...and none of the callers validate the result, but now runtime
> > validation is necessary. I.e. it is not enough to check
> > IS_ENABLED(CONFIG_DAX) it also needs to check cpu_dcache_is_aliasing().
> 
> If the callers select DAX in their Kconfig, then they don't have to
> explicitly check for IS_ENABLED(CONFIG_DAX). Things change for the
> introduced runtime check though.
> 
> > 
> > With that, there are a few more fixup places needed, pmem_attach_disk(),
> > dcssblk_add_store(), and virtio_fs_setup_dax().
> 
> Which approach should we take then ? Should we:
> 
> A) Keep returning NULL from alloc_dax() for both
>     cpu_dcache_is_aliasing() and CONFIG_DAX=n, and use IS_ERR_OR_NULL()
>     in the caller. If we do this, then the callers need to somehow
>     translate this NULL into a negative error value, or
> 
> B) Replace this NULL return value in both cases by a ERR_PTR() (which
>     error value should we return ?).
> 
> I would favor approach B) which appears more robust and introduces
> fewer changes. If we go for that approach do we still need to change
> the callers ?

I agree approach B is the way to go, but that still requires these
fixups, feel free to steal these hunks and split them into patches:

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

...but note they are compile-tested only. They assume that alloc_dax()
returns ERR_PTR(-EOPNOTSUPP) when the arch support is missing, and I
wrote them quickly so I might have missed something.

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index f4b635526345..254d3b1e420e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -322,7 +322,7 @@ EXPORT_SYMBOL_GPL(dax_alive);
  */
 void kill_dax(struct dax_device *dax_dev)
 {
-	if (!dax_dev)
+	if (IS_ERR_OR_NULL(dax_dev))
 		return;
 
 	if (dax_dev->holder_data != NULL)
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4e8fdcb3f1c8..b69c9e442cf4 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -560,17 +560,19 @@ static int pmem_attach_disk(struct device *dev,
 	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
 	if (IS_ERR(dax_dev)) {
 		rc = PTR_ERR(dax_dev);
-		goto out;
+		if (rc != -EOPNOTSUPP)
+			goto out;
+	} else {
+		set_dax_nocache(dax_dev);
+		set_dax_nomc(dax_dev);
+		if (is_nvdimm_sync(nd_region))
+			set_dax_synchronous(dax_dev);
+		rc = dax_add_host(dax_dev, disk);
+		if (rc)
+			goto out_cleanup_dax;
+		dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
+		pmem->dax_dev = dax_dev;
 	}
-	set_dax_nocache(dax_dev);
-	set_dax_nomc(dax_dev);
-	if (is_nvdimm_sync(nd_region))
-		set_dax_synchronous(dax_dev);
-	rc = dax_add_host(dax_dev, disk);
-	if (rc)
-		goto out_cleanup_dax;
-	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
-	pmem->dax_dev = dax_dev;
 
 	rc = device_add_disk(dev, disk, pmem_attribute_groups);
 	if (rc)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 4b7ecd4fd431..f911e58a24dd 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -681,12 +681,14 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	if (IS_ERR(dev_info->dax_dev)) {
 		rc = PTR_ERR(dev_info->dax_dev);
 		dev_info->dax_dev = NULL;
-		goto put_dev;
+		if (rc != -EOPNOTSUPP)
+			goto put_dev;
+	} else {
+		set_dax_synchronous(dev_info->dax_dev);
+		rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
+		if (rc)
+			goto out_dax;
 	}
-	set_dax_synchronous(dev_info->dax_dev);
-	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
-	if (rc)
-		goto out_dax;
 
 	get_device(&dev_info->dev);
 	rc = device_add_disk(&dev_info->dev, dev_info->gd, NULL);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..11053a70f5ab 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -16,6 +16,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/highmem.h>
+#include <linux/cleanup.h>
 #include <linux/uio.h>
 #include "fuse_i.h"
 
@@ -795,8 +796,11 @@ static void virtio_fs_cleanup_dax(void *data)
 	put_dax(dax_dev);
 }
 
+DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))
+
 static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 {
+	struct dax_device *dax_dev __free(cleanup_dax) = NULL;
 	struct virtio_shm_region cache_reg;
 	struct dev_pagemap *pgmap;
 	bool have_cache;
@@ -804,6 +808,15 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	if (!IS_ENABLED(CONFIG_FUSE_DAX))
 		return 0;
 
+	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
+	if (IS_ERR(dax_dev)) {
+		int rc = PTR_ERR(dax_dev);
+
+		if (rc == -EOPNOTSUPP)
+			return 0;
+		return rc;
+	}
+
 	/* Get cache region */
 	have_cache = virtio_get_shm_region(vdev, &cache_reg,
 					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
@@ -849,10 +862,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len 0x%llx\n",
 		__func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
 
-	fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
-	if (IS_ERR(fs->dax_dev))
-		return PTR_ERR(fs->dax_dev);
-
+	fs->dax_dev = no_free_ptr(dax_dev);
 	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
 					fs->dax_dev);
 }

