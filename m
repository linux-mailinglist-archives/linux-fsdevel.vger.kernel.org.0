Return-Path: <linux-fsdevel+bounces-11228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296558520E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4121C21F0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D444D5B4;
	Mon, 12 Feb 2024 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJZH1Wov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D5481D7;
	Mon, 12 Feb 2024 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775452; cv=fail; b=HRmzqdF+08ntsRRtQSKEe+XI5O4TisiCrs6Jnly5uiMmXXO7m7JoB935bvcpCwXl8c44pFzho9O3bvqvpCOPA2YmM1BrhbFMj3VKLu27xaG7yu2zvG4gCtQV3tFAD9SmwTnhl2CbkQ62NFeDOi2luYu5ibz7vPMuTbDCDfHkulM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775452; c=relaxed/simple;
	bh=J0O1SnAA2+qtyjA+UxGvsUFFSxIsq3NF44M1F8/x6Vg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RxPeC5xjcCPHkhzwaqedQNFgYOzHEGWPAZFfMpjpgMQNZ95LboLIxHgZ2qo1E+5bX5EG/igqtCArLGklK8SqeX44ZS8K0s5DBiptpuhII82zYuse2yUj3QbDhbRo7b71A5Ym3M/cRw8zuuhXip+/eDUgCK7VAHmye9QtorO47HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJZH1Wov; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707775451; x=1739311451;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J0O1SnAA2+qtyjA+UxGvsUFFSxIsq3NF44M1F8/x6Vg=;
  b=aJZH1WovFymmIqA2D8i/bk2bM4JqoWqblcr1H1J7HdCWZayVInqZpDNJ
   GOLIwVngKVVB5WCP/hEYOmPvvDuCh6q+lqINWrw+bhbVmtOeLaIpXNNjX
   Vu0Qs2Eyxoj20cGFGRTh8jnzc7H7Cx5UkhIi5ievSeE+t5WsLZ62IC+go
   ct4ksdG5AiojgAFjnKflSwJc/Qk+wiThYFclfrJZFD8jQ843GcPUh87dG
   o0LyhSkErOZL6B7y12tRXsLEYDdOb5lKQ4WcLqz5DVOjMsAoCs0Zx9SgD
   2Im6uqoPA+F8+buPtNRI0QbIYkZG7tDt/6NsdcjWwjM9QDHRRVU47ja/q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1649417"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1649417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 14:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911612578"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="911612578"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 14:04:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 14:04:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 14:04:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 14:04:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlFbrXfx6OGoSqCeLdGbGJJtZ5KpM5K6j16gNKWbgFL191Uaaz9zEJRG33Btbjc/+S+W/bzBqGGnJLxITa/wn0WnB1PKmolnwgRJ0vx8NETRcJC9YU9U9heDUhT6Ajg1/dPjKbj3ofNsIDdIorXjtHHepBKBjHfJv2zn/ctli+GIEJ1MGBjqcHAKC9K9ZSecg9kJbHVpBfu5FnYivghhyTWWV+OXOIsFiXM9ohOkRfUYNtXAyZF9Yb++N2bX9MWeCaVLYahhPohRCJJlODU1thk4O57NBCIs+i6ke80mRSrMs9jcxEZtG3ca08wQOH6vu9TFclt4pPWNo/Zu8eP4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHR8kZFDkaC8y1fxiiDOovfwwZswgXp35nQtQhl94jk=;
 b=lrG4CHIvpMrTSQYDKYHJcbcIm0WoIPncjLdY+Wy8ErUICJNDLHVA2w+DNFecUzYHsuNKCyIwDlZPOw/B4nKMS4Q3ci8cN+6GW27unfcfgMO5PJVk8igtRN2VYjvVUmR3LAT6MMlPCUQUMwqywKiNafqK8Hejya8Cwz8ek2ZEvB2NOt5Jha8GOGmWBrAmCA9y2CAMo6OeBB/BQLPbIcScqF967CkA3lHUTYLoVseWH0y4ysaquqTC9pZsSioTO0WI7YyqeIcpvD3Qfne1MedHhhNknybpriJ0Gsh7M1SalaZMt8pyNhYo0hxYSenQZpFpKwhwOVty+hia4JhWaBw6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5281.namprd11.prod.outlook.com (2603:10b6:610:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 22:04:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 22:04:04 +0000
Date: Mon, 12 Feb 2024 14:04:00 -0800
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
Subject: RE: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Message-ID: <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be25b9f-3e83-411c-42d7-08dc2c16866e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ax3Yd6waeLI1u9x9dLzioJ4QloRlwWwbvRs1yZogLGAxQ582xvPeBlVIW+sNxK9NK3IrzYaOGRGdEBRWLaURfTHvrHSGVtlXbEGuranLgA9mF45u8coNIpxj0Gvhor6Qh0HHy1ts2/vyDTrW9nI+0nl4QJ1rmE9BHe1DsDzqsxB2apG6vcZJKpIo2+01JVruekiDYWWLsQYwlBV2ATRfK/e8pYywKYbP9EZtvOBY8ev/p9vmjlGuEnnoY7Fdjhb40zxeEGd1IFtowEMM0J9s05enj2JK6r/oVNBV31jdTLl1Ba+pcX6AbfKbDjb7mbnmrDa0tqhsN8whbWP176LdgPTl6hFjKggDqzJ9NRU2ZTrcvthBwGeBvNrnM8rf3hwzljR+1R2uGle34xS7eQGqJui39MtG6q5D55QLwjDmlmRE8S9XpVDgZP0DetpMfPuYZNHD096pxQaNsjGCWfSOcrAI0HNvDU7dPrHWxQxCPuaWmEMn8wCFLbvo+/ycYpnwv/MFXOe3tF53Y1Lr5/2X1QilHyW8IFfvkZtDgyv1NFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(5660300002)(7416002)(41300700001)(26005)(83380400001)(8676002)(4326008)(8936002)(66556008)(66476007)(9686003)(66946007)(6512007)(6506007)(6666004)(54906003)(6486002)(316002)(966005)(110136005)(82960400001)(478600001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ddJQdIs12P07B519/NThz9BKHR9mzL0yDu22aewE/zFuaoBDF/z3WPUU8ve?=
 =?us-ascii?Q?NZoJtWJP9DfE9oERDeyOtT9oeyjxLyB/MSxOx1eyA6QJcyy+mHmEM8cfkpT3?=
 =?us-ascii?Q?C+RCkz6rVLl0V7a4J+IIBJo+OpwQjb7l5Y9LWDdIkZ769tEidrfngY7vBvYf?=
 =?us-ascii?Q?XoaR/jFqHV8dBSzrCK/tXRCsZt79IlYOWoNr4EzZQ/j1M4FVIeJrBfZckVed?=
 =?us-ascii?Q?6N3L90XqCq4IJnuA4Q0G1srJfhbYLhD2RvXtyl5irwlAf1l/ZNH6NpeIGbEq?=
 =?us-ascii?Q?zr8hTOnPRmwV40wLKz/8uPPLbA9L5xoQaj8UqQ7jA7RUNYfG0gGe4sWUcDUY?=
 =?us-ascii?Q?giNpyzEDtPGCyv9K8/QXCe1dJwp4Jx5zwpdhEz1pxe7mCz75QtX7UeMsmbCx?=
 =?us-ascii?Q?DKXY9TiSPw/hOSoSWnmBDFwvIYxOwbFsvtxsuYC/ztzHYDutcBgMED6bNa6g?=
 =?us-ascii?Q?fi0dhFSr8zE0pFeoPqw0BHfq1HXkBANAGkbqHVysz5ndb9W4mJbjNdPG7ulL?=
 =?us-ascii?Q?DY3zhMwITtYIvRBW9BrMimCEs1z7zi2kLNfyiUfW8555ZB9HuXme7BG7MTnD?=
 =?us-ascii?Q?Kxwqz6c4cDJq89bt5pS25QdNzVjN3z++lp2kx2HrhMkblWE6BrzOrY0k/GRH?=
 =?us-ascii?Q?judI61JTqV5j7hga/jnePGM1hD8J8KYZH+mHxe9VRlqo+7RZFTpexN72f9q7?=
 =?us-ascii?Q?iyns0UJRig71f+vfmlM6T9t2SPgkEnSQaClwjpQWYpDfbCTjtWViMtxb75XD?=
 =?us-ascii?Q?LxKlQhCDT9Ag/uJ8q2DYNkYMa3TSCjwBPR0ZqI8y7U1ctlk3Aq/6TOPOytR3?=
 =?us-ascii?Q?H2DlutvuTONC/STw/0iPLw3AXftFE6VDFMDh5ulp+blj7/VwhdPz0e8zqK1C?=
 =?us-ascii?Q?4TIfGNhj9hrWbVso7SeevmHpnWSjM34nrvHFl5YMCuQeAYbXlHOeXrvNwLbH?=
 =?us-ascii?Q?8cU8MCXnZY5MgBI2aUIZO5mgn76RhxTS8QSvDqZDy21kj70pQKVWiZveG8Qs?=
 =?us-ascii?Q?dB7sal68osCLlMgB0daJb/OXmhQqCyfD3pbrCt8maNAcL2NtX1K9rD7vp/jj?=
 =?us-ascii?Q?Y8RsDsNr/LpTOTh2qfIatMkeTBKDAcbSLhDkLvzzh0ItW659R0EtHN+RC6HC?=
 =?us-ascii?Q?HZdbqYvx4p26nutTaqruiDx2aWbf2gWaUtLMbf03pvenaCtm8fdgYhOD0WPp?=
 =?us-ascii?Q?3O98VgeriU5JsIxL9rAWuhcZB0dgLqE04k94fBczlXXITqRBcSS0wnm/msPE?=
 =?us-ascii?Q?jKgAsDF/xCXUA8r3Rcjjm+lX4cRNTVjvh5Z4VjsZp4ezwBvb6TE1EMV0/CFy?=
 =?us-ascii?Q?FSte+17P+35ZhPToRvr7uyZdENa4TlkDy2zMz9jOjAwdG/d6gSvQzXiFV/FJ?=
 =?us-ascii?Q?fPvPLPtJpsH+qh8VOeqvBOqNin6dT5AWjUaNi6VfyjdFuZ+m/6Af54cbH8gz?=
 =?us-ascii?Q?LOHQpz4aGJEO7fet852tAJeXZg1KeMZMeO6tgVJf3jqjr43n3YQjGh4u7ST8?=
 =?us-ascii?Q?9xfsLLqX1U753vxhYJba+1hKs2dbKaMnuL8VhtQOnX9VPjFi/216poBpLufj?=
 =?us-ascii?Q?9c66MJVUiAIqXymbetU46Innj96cDy3tqoF+4rvLVehatXqNuGz8gw1jkhv3?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be25b9f-3e83-411c-42d7-08dc2c16866e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 22:04:03.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSwCuhc300UhzBpkpV+yuW+BiADZHXHaDs766jYvZnwxnoljLYbv2wNVkZXc8Nhd+b4Jx1RyL9wrUASRBaBhP4JtWrVb+L37EIyoWtHdMk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5281
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> In preparation for checking whether the architecture has data cache
> aliasing within alloc_dax(), modify the error handling of virtio
> virtio_fs_setup_dax() to treat alloc_dax() -EOPNOTSUPP failure as
> non-fatal.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
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
> ---
>  fs/fuse/virtio_fs.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 5f1be1da92ce..f9acd9972af2 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -16,6 +16,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  #include <linux/highmem.h>
> +#include <linux/cleanup.h>
>  #include <linux/uio.h>
>  #include "fuse_i.h"
>  
> @@ -795,8 +796,11 @@ static void virtio_fs_cleanup_dax(void *data)
>  	put_dax(dax_dev);
>  }
>  
> +DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR(_T)) virtio_fs_cleanup_dax(_T))
> +
>  static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>  {
> +	struct dax_device *dax_dev __free(cleanup_dax) = ERR_PTR(-EOPNOTSUPP);
>  	struct virtio_shm_region cache_reg;
>  	struct dev_pagemap *pgmap;
>  	bool have_cache;
> @@ -804,6 +808,12 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>  	if (!IS_ENABLED(CONFIG_FUSE_DAX))
>  		return 0;
>  
> +	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
> +	if (IS_ERR(dax_dev)) {
> +		int rc = PTR_ERR(dax_dev);
> +		return rc == -EOPNOTSUPP ? 0 : rc;
> +	}
> +
>  	/* Get cache region */
>  	have_cache = virtio_get_shm_region(vdev, &cache_reg,
>  					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
> @@ -849,10 +859,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>  	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len 0x%llx\n",
>  		__func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
>  
> -	fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
> -	if (IS_ERR(fs->dax_dev))
> -		return PTR_ERR(fs->dax_dev);
> -
> +	fs->dax_dev = no_free_ptr(dax_dev);

This works because the internals of virtio_fs_cleanup_dax(), "kill_dax()
and put_dax()", know how to handle a NULL @dax_dev. It is still early
days with the "cleanup" helpers, but I wonder if anyone else cares that
the DEFINE_FREE() above does not check for NULL?

I think it is ok, but wanted to point that out for the virtiofs folks
and wonder what the style should be for things like this going forward.

Other growing pains with "cleanup.h" and ERR_PTR is happening over here:

http://lore.kernel.org/r/65ca861e14779_5a7f2949e@dwillia2-xfh.jf.intel.com.notmuch

...and that arrived at a similar style as is being used in this patch.
In both cases the cleanup function is called on exit with a NULL
argument.

