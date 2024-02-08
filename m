Return-Path: <linux-fsdevel+bounces-10841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C9184EA9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD132876EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8164F612;
	Thu,  8 Feb 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vptk8Qt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3C4EB4F;
	Thu,  8 Feb 2024 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428086; cv=fail; b=KG2rGu6OS5alLlGpBzhFLIasuHBE39nz4oxCoJnF4B/LkMCw3CxCMxoU/N/kgDFFSu6bFW0U1e/C8Q9zeKlG1D1534bEJXYuZ9yUUilijZ2ktNOv+3fXv3Z3a0haDmSwuWgsIivBW6yLybQzuRxPnca2vqCw1qlp+tOV0qXF7EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428086; c=relaxed/simple;
	bh=HVWHTwFPts5x39bVHT2Wa5fIibzIfl1Z06fK2EQFQWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mkOcvk403lru2XGSeP/ZML9xchylyVPKkzbXFXJv6TAt4vCaakJxsOvE1fYYQ0bj4p6p4Imm6OHnV1kr3PP61QfUMOKOU3wN3bP8bqQBq6cr9enzmdTyMxVDIh1ykyIG11ObL20u+LkblmtWATogHDfKw5bm84LSN5ttu8CxEeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vptk8Qt2; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707428083; x=1738964083;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HVWHTwFPts5x39bVHT2Wa5fIibzIfl1Z06fK2EQFQWU=;
  b=Vptk8Qt20awaojesuThUYsWUFc4oUmLa7eqgYyuI6dqdD+2Pz/LoxcI/
   zteMI4gnAFuutwdOCmKLzSn46W6ocA0fWPhhvEIJQ9dQekksfbti0Yapu
   1FANI3ayjmrbWffb4PxyEMzYbnLqD73hAPD0xxvW0Ct6OLXxcBNe2WsXL
   xOiyUHteRNUcR70fDaY/Tx+v1kzeUZthBbTrBytykPRvMntRSi2wkeY82
   lcPNi0OnO57P9A/uFZ88Ace37/79TSiBOYmDn3iZKANvrhBbcsftI36tg
   C1l62t7BOeT5v4h/ikKK0mNV0RodVHe4Omkjezyv6xjDQaKobNhAkEEal
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11971017"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11971017"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:34:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="32843414"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:34:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:34:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:34:39 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:34:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm4op3j4Cc5aPwH9GFxSuPrqqaryuDTdrHiOuRxFD2V6VR1TutCbX1+sXEOqJ83DpN9FpMbO3PaIOoJm0Uh5epHDZjrtRo8n6g3rzGO4y8g05rXrWyAjGSS56NVIuHUGW5nso3PpwwfKybla05y8HCUQLEghw1DV5oD6T8T3wtC7cre3b5vehclFofRw8YFVAWijj+4fG8xuzpE57AI/68eow0qK6PjpEwvQE16OnC1E89AdHsXvu6YPp2t5pbdeXq3wtdOUJaNuY8P05xSwRn2EnEdqmkKuTrqvEm95a73ij5cP5yqUz3p+yfVlXyT2bnBRUwdUrXGlK5buNeG4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg7xvE10hOpm5jxuCmhhZ3KScVtNQtple7NJ07FXD/E=;
 b=g9DRrEW7sXhczlfQjigl67SkH+W6YCqle5MCP6KiQLUM/1e+w1jgS5Y1dxqgqfA+S3eYRZCHADVrlvLMgKfJaOuBlmH8EtjB0MJ23WKXMF1tugajKijhCFtaaeorxXXK2oH6HgCnQdfYp5q//tOsXSCHr+6sx2kawpbPKCeu3LFIBLahoWiB842rJyNn65lMUzRu0rYPuaQ03omSnprO/j7eN63Z7lZomBQ+FTgqTLebsDIBA64ksiE3WFKgzgguZFpaSO0ppK7ZA7KAQXOjoDycm/2vzXbiD63spKXd8V5n2kgMoW3t1dsk8hchqvPZT+0AgyNHU3cqO5ji+iTBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 21:34:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 21:34:37 +0000
Date: Thu, 8 Feb 2024 13:34:34 -0800
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
Subject: RE: [PATCH v4 03/12] dm: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Message-ID: <65c548ea54127_afa429463@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-4-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208184913.484340-4-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d273cd-7dbd-4d16-ad30-08dc28edc00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcuW32EsjhY50Vf2OxkT1STdZzOuk2tBt7FmNCh3rQLmSM++/fxe9T1nIlY6sQ2Z5MMdjVVhMlCRAiDzVUgzt9v95LGgXWka97ti09sBOd53TbRnq2yajopMzW4PqDHlyheHlJ8xk8GRA/YKmHp/3qJaSao/6kJ4pFGJK84sByiC9CyR+27gHfXNRhyjOv3esL8ygAGzoepCBWQjSCK3QotJgZaNiuckKzuPnC7/Kx2uOycd/kj+C549zqYzatx10ekdvaTsCwhmeq+3dHpEkYpMUL5ROr5VFcSl1j5thMKsgE8PcRe4g04m9vsYfiGfip0zt+midRQ2MeaGofxeomFgQa67ZBS5VP7yV91g7fv1JvgxvNvb4U2GBnijgqY5te1tsrI1W1C2ZHTlIkBC7rRDmLqul46rDEVMsjy0IHIaKBlKuRurGnJsG+nn2fQwzJo0X93E2RbUIWRuCyuCIQyx1EuvvstEObENypXvegW+AI1514tyJro+UK2kjVTzB6xPATfYXh/NaVAAMEkDKjuujeNmDu+bzUHhniROMM9vnXJL2JrGgoZAoS3BkSTT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(83380400001)(38100700002)(82960400001)(41300700001)(316002)(26005)(66946007)(54906003)(110136005)(66556008)(66476007)(7416002)(4326008)(8936002)(8676002)(86362001)(6512007)(9686003)(6506007)(6666004)(5660300002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/IGLDEBbUqiRFg5sojodJg6kcpIWtN+jc+Jbbn44hd7DbsLBNqgvPs672zDJ?=
 =?us-ascii?Q?LpauYE6hOltKRlpGgkQLVbK9dZXGvjbB5ACx2GAJ4uiBQMX/CvTt4aXfrzST?=
 =?us-ascii?Q?MWlf9FDLxnj6b7PiiZeUf3qYcR8u0sBezVDqfNVuldkoVcvN7uCl5UBk4N7b?=
 =?us-ascii?Q?2M/754zBaX/2YPQNQxxPo6z0mXS3ij9FZUjxuoZubj7xzmQjPJQiD6ZgHGRC?=
 =?us-ascii?Q?569Tq8hNKN03//ATOU0WCeXKnQ3hY+bpm4QzK5tUEECoUocH0LdcftjQ/rkw?=
 =?us-ascii?Q?6nUU/ohVjVtTwTTRSGyshEs1bJQd87KiTJQNWhKNHCadUUu9WcJj89Kf5N6R?=
 =?us-ascii?Q?kdeDsKW8poh9HIiYuW1BPkegIyxUsJHM8ZLyRkO3DQrdjfLX1s1v6M8T3B2f?=
 =?us-ascii?Q?Khamgzsb23Wf6U7TjthF/5UG/0lxXwYsoXv/FdYiFcG2jdCGbXXNJA4cxfmB?=
 =?us-ascii?Q?RaeAC475xi0sLomc62OM3H4B7BrFk2EAi4H4J48zT8ueKDPwC+tCo4aoja/Z?=
 =?us-ascii?Q?tkpld/Bf6jX3+4+3emsKgsAkTXcSarcOpKy+IV1bgPwZlLHh1nj5iYrZ2yKQ?=
 =?us-ascii?Q?1hSv06JUfu4J+fKMaCVMj2Y+HoNcR52klgLWtVudRa9Dd0dBMaKwxDd4Ej2U?=
 =?us-ascii?Q?amrle7clPgxY8QlcIUqoT8k7zxELEky+WTSXul4ZJ3yac8pKFBEOy2eJtBUd?=
 =?us-ascii?Q?Qj8B2qw4fE86D+CbZP80UoOpIpVJo2vFW4FVucKcSCMU3831fPhVfC00JElC?=
 =?us-ascii?Q?asTzm47HCHHlkW3czZuDAaoKySeng07QOxQW7cDCVwuWQwY9H0vgHCd3N3ZG?=
 =?us-ascii?Q?mhkcl+BKdfowP65g3Ek8Kgj0QeTOKtfhPRtrHGtoj/Q99CUQits1awsZZVsp?=
 =?us-ascii?Q?IRZ9bDWy4qVxE4rvb7Lwc3gcDSNIvKmtsTl/gRqxUfOGGjuQSapa7BDh+wNU?=
 =?us-ascii?Q?NemKbWUStXjgFZpUxCi8H47fATYzvG1cothVMTvh+xO9KuTT9VR/VFw9rNZT?=
 =?us-ascii?Q?WOVI3z/59+3qH4sKYb8TzNHxEqGF2wgLeXwyfYfkfIjNbM3OwK43DH0YSaB5?=
 =?us-ascii?Q?V/qoXZj9TWP/dO/ihwsdqidredFh8n2Le8sSt6/xBzhUhl9CWdMQ8BMoqP8i?=
 =?us-ascii?Q?70abZkCE0wA1oBUVo0aLbEIujDqkIzM7RFhmEFtSkUdcmDug+BF/mnx3zdgz?=
 =?us-ascii?Q?6jZLju1UnKJJbCzjS3esfBKJQewFJcoQvVXLJh9alEyei5LusV8fpO2HFoUs?=
 =?us-ascii?Q?iSHCWtdH6lzlxxsSw+QUEZ+4RTDzGeWaBHeAAcBxF7WpaVCuhV4RCHTmBRdz?=
 =?us-ascii?Q?fpbnGizGGOlR8OCUz0rdxJbBXkBNf2OVnwPdO8SKhMsj1iwgy6sd2TRFV1wU?=
 =?us-ascii?Q?qo/Bf2Xawd2rL+XqV79C8vnPAxC5yBZiIXTlBhizJBUT3DRIPi8Av/u69zOa?=
 =?us-ascii?Q?J5xav9GBbWsGmqs7Ub8Hj/2OQVULsu7lTvglUoGViNj7HYqsADyahgAMXgBC?=
 =?us-ascii?Q?kBS2DjGyaZ8ddvB/u/lMjbK3nUmVeVBm+WeUcKnC1LlNcZmXnU1WiLLII+KY?=
 =?us-ascii?Q?JQPLSJ5hPTTGvXeRkqJu8h+8E/2zdcjE0p7JZq33+D2lqLLNS0IZePhkfAJZ?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d273cd-7dbd-4d16-ad30-08dc28edc00d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:34:37.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYXHX08hjFVII3EKOEySlTQXyLvfCnphNr5FXwUu9M2TiyyoEasLMWqJ+Sui9nYEYR9+NhSjOw/EHf9sYz0eQkRhtTpnzZ+hUoAdqD+/Pic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> In preparation for checking whether the architecture has data cache
> aliasing within alloc_dax(), modify the error handling of dm alloc_dev()
> to treat alloc_dax() -EOPNOTSUPP failure as non-fatal.
> 
> For the transition, consider that alloc_dax() returning NULL is the
> same as returning -EOPNOTSUPP.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
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
> ---
>  drivers/md/dm.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 23c32cd1f1d8..2fc22cae9089 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2054,6 +2054,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  static struct mapped_device *alloc_dev(int minor)
>  {
>  	int r, numa_node_id = dm_get_numa_node();
> +	struct dax_device *dax_dev;
>  	struct mapped_device *md;
>  	void *old_md;
>  
> @@ -2122,15 +2123,15 @@ static struct mapped_device *alloc_dev(int minor)
>  	md->disk->private_data = md;
>  	sprintf(md->disk->disk_name, "dm-%d", minor);
>  
> -	if (IS_ENABLED(CONFIG_FS_DAX)) {
> -		md->dax_dev = alloc_dax(md, &dm_dax_ops);
> -		if (IS_ERR(md->dax_dev)) {
> -			md->dax_dev = NULL;
> +	dax_dev = alloc_dax(md, &dm_dax_ops);
> +	if (IS_ERR_OR_NULL(dax_dev)) {

Similar feedback as the pmem change, lets not propagate the mistake that
alloc_dax() could return NULL, none of the callers of alloc_dax()
properly handled NULL and it was just luck that none of the use cases
tried to use alloc_dax() in the CONFIG_DAX=n case.

