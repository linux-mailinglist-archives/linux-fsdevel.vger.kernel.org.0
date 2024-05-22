Return-Path: <linux-fsdevel+bounces-19991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39DE8CBD3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA1A1F22C4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3E8005B;
	Wed, 22 May 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SC4OD+w0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66B7710B;
	Wed, 22 May 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367878; cv=fail; b=Lsdb8IhCMgV13OlHLL8v6GY9PNtBXWJY79SBVmGKVUZwc/ony9CZCIkPC8wPljI/0XjvZYeReUwpoXlUROhS6InO+d9nOGX9Aklmgonaf5lNqlEJ/TSC+sZUec6FcpndryF/krir/CuPrBn4jHlZet+w8/QmEGGVfIXFNNThLRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367878; c=relaxed/simple;
	bh=oG4MDLcVs3PE5HNbpuvP1lipieSnpOUl9CrxM848piE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YDHqRvS8bGgzLy46nEhylT4z3WWMt+wCuc99NFJdA5kWOJdeqqJWLhwXjchHBCDJPZbA6FXK8fL0YzTDg2lwB72ldfwKZS304F+301/icBWLxiPFuqimpjmg7ot9B37e9VM15Hzpy7y04IbE92Ja3FULBCb4dGvWkcQFaqOg5ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SC4OD+w0; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716367876; x=1747903876;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oG4MDLcVs3PE5HNbpuvP1lipieSnpOUl9CrxM848piE=;
  b=SC4OD+w0lq7HnFLV6ARaHiOeMGDRWfACksdvr9kcN/xjcDh8evM6fyhH
   ARUS1ASk6kVZLLzUINBdvLUwa9IgfTsrWmUI3eS7PhgnSEbhZEsbLcJA8
   +m4CFLuu4/V7bcu5vrN7DZFBb0924ZSK4gsBkrxvQYSTASpjz30hgEU4m
   HeA6sLcgzoi6sCADArQ9Zd7qtpuNX9Hr0IyqV6XTic78igUUrsUfRwl5P
   vORS5ScH/qdQm9RUtayjzM9aznfG3RHrP98me7NI74aTIq1oH08L/GiR4
   8FAtyn3pFFa4arCa9OWvcoaagVVQEeNzMg4dfiXcjAixrEl+ahcU9O/MC
   A==;
X-CSE-ConnectionGUID: AI37MSuxTge263ZQ3BMPig==
X-CSE-MsgGUID: z2PpzXyzSz6eqx9cvxovCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16442854"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="16442854"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 01:51:15 -0700
X-CSE-ConnectionGUID: pe7fOxq/TDe9gOyLjF8G8Q==
X-CSE-MsgGUID: idvRprinTfaeE6Xjd34i7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="64053048"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 01:51:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 01:51:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 01:51:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 01:51:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsqy2ibJ9oz9uOqyhre7+nIwcy6VqLFzDY3rr+0fbxHY4nhXhCLE7PDNOFPSOwFALRnls6IW4TQ9OE1rPb0Pv/9ZPvQSA83/P0aPNbb7jFuMPUOdoRrwIHOA+OvnXWtlnDyuAR4Z8gaysBi7lGBpxjKF1E/GuZOI4+7OgFrWXotiPlHqM+9AkPeniwSlu8E4dXKHNgRPQbp3nFMNpigiNXwPJxu8EtrjusmaqrrYytUDdoVTbvz8uK3nz7VeOFQx6IP6adgodV4A3eZoprAyaUtZoI29sMAq8UM5HgSw6nzgPc53eU3ZnCKK9u2d8vx3DPXFKzCiAVi6h/JQ082Uzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmFMJaN6kwUoabucjyOHjqruh8uS/z8GcGcnwG4qSkU=;
 b=UX6GsI3pIZOkT9kdd6zfxAIggNMsP3rChcUfXEZ+8Hl8OabXljB81sKlJj4+dFwTq5cFZYIsvZsqZTdwNVQJXQWYwirrAtQOcmwK6yK3CAL1yb1Ey0q4DD+fq08pRO6cGIv7srmAmcxbw3eU/QhGtBPUtZxgn16nuOgMRVJ+eTp9M2Of8EC9ro+BluvPXNRX69Xh2rtAvBgj6OevU/bc5LMZyhv6xk2+I+9PiHCPlrao2SGDBlndk/9mk6e71NfySccZeOJTv9JzqhmUkLBjD2Q4+mDUNh4nDY3AUjiyHlCcaY1bcdreWlPV4mvN/C9+UeFGjFNk5ApMXB8RuVj9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by SJ0PR11MB6743.namprd11.prod.outlook.com (2603:10b6:a03:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 08:51:12 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 08:51:12 +0000
Date: Wed, 22 May 2024 16:51:05 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Yafang Shao <laoar.shao@gmail.com>, <brauner@kernel.org>, <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <longman@redhat.com>,
	<viro@zeniv.linux.org.uk>, <walters@verbum.org>, <wangkai86@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <philip.li@intel.com>, <yujie.liu@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
Message-ID: <Zk2x+WmxndbwjxQ4@xsang-OptiPlex-9020>
References: <CAHk-=whHsCLoBsCdv2TiaQB+2TUR+wm2EPkaPHxF=g9Ofki7AQ@mail.gmail.com>
 <20240515091727.22034-1-laoar.shao@gmail.com>
 <CAHk-=wgcnsjRvJ3d_Pm6HZ+0Pf_er4Zt2T04E1TSCDywECSJJQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgcnsjRvJ3d_Pm6HZ+0Pf_er4Zt2T04E1TSCDywECSJJQ@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0371.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::7) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|SJ0PR11MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 087d5b59-c62b-438c-3275-08dc7a3c5509
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LS9H5peiOLE2sWuGSAvgH0jrZ0gaS0mqZNIJUpKbj6UUszOcLU+UtRprCx?=
 =?iso-8859-1?Q?aIOI4I29MVaT/0PtccpN+eWOj5IX9fGCAJMhCOcRvTj8++bsPZAMuOxj0n?=
 =?iso-8859-1?Q?yXQVK7GyNUw1kAxlWMN4e7M89HscBYWvF7813PkaJPFunjVgs3Uj1BMTIL?=
 =?iso-8859-1?Q?3MThO5iitxFfm0Z6+97xe3+Smmf/0l+asvBfm6nr43c0gbdLnYzzdW+csU?=
 =?iso-8859-1?Q?NbVDMrMJBv8yg5grPC2mYwOHnMuz2e2+ghXvKCYjVqCtBOGjCJ/CYCNCnP?=
 =?iso-8859-1?Q?8IR9i7+apie+onLnBO1xU5Yy24aZ+7a3zdsDPNpoM/nb0Poi7WISEAuF2V?=
 =?iso-8859-1?Q?XYCi0rDv5e4SOvU8OrnJMAfuRMUUBOdcHWfWo9W3zCpHxpHKxLGgNdRRY/?=
 =?iso-8859-1?Q?4ol8FItnL/rtCmwHrwYCgQ/0+FAOTOqT/XAFX1h8nnPRIdBB2WsjefWmCm?=
 =?iso-8859-1?Q?g2LbB79BgeHDAX3aehKZXjdnBrsreUbjfLZqGcJbZwjxwYzoKu7ICicM3I?=
 =?iso-8859-1?Q?LiALoWPrXVi+BhzBTxvQWzKdoMUiLdGlgXlzdbnDJFjce9Zi6GllfZqAZP?=
 =?iso-8859-1?Q?08MVkkSs8U4xBHZgThMPtu0aHRYzzh1d8CJRLmNO4w08+JlokxwwBlJsIs?=
 =?iso-8859-1?Q?zr9o7TenW7eBVP+nC5Fo8MchNtAPtb5hpGCJ5aqVCWVsQo62OvmjyT5QAG?=
 =?iso-8859-1?Q?t/C+g5ZXJKtHHwpbDHtSKophNyWJ5iHTEdnS40LGi+H5uHLU7WuI8mGdst?=
 =?iso-8859-1?Q?nbkaz4yFoJxd2ATqixi8zzvenwA0YwmOJEcXD4grHRLq9SUYBpUPF7Nfem?=
 =?iso-8859-1?Q?DePxwEKVl3Vdvlp7IM1YJL+/JdErDxiWk9Yy2lUmhkbCTcivvzkzgAGI9P?=
 =?iso-8859-1?Q?wC0nVQqImT+tNlQMJr91wFWObXay3Ib99sxNyv/447dXQJjAv7mhdraCK6?=
 =?iso-8859-1?Q?+w2aTrKWtptnpYP2GCo8HhvkFAhZgH880by2kY0klFjRvoqk0g2W/vk6Qf?=
 =?iso-8859-1?Q?5AfwUvUbSW8HebStzsbJ3pLdPkS2RE8u13m5HbSRvU5lV/ENTmRBvRrNm+?=
 =?iso-8859-1?Q?B4nk9xd+P4QpdyI4Z0dGu6LSLvjDKYwidUPnSzVzotdXqJFmY1stnKTBZg?=
 =?iso-8859-1?Q?FBnATnZfWG2mgTO6TWjZDphUaIXkRtyYFJ/iNCVpeh8wBHMOPMGdCqcz2m?=
 =?iso-8859-1?Q?c3a4jXCIKjr98WerjYIJIcN6PzAZf2ny6ujPgzkUR89+kDbvJY42xNEyzu?=
 =?iso-8859-1?Q?rii9PESghVYZwAA8MiGyoZYPrdU9gXl/j33ueFteY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uYfUTntFa30Gx5AoL0lE3x9pD2xEIL2VZ8nJBXGEhSBADAkOU31E8XlViI?=
 =?iso-8859-1?Q?uPDE15/aa8jQHjmjjljhTA7J5Gp513nWAFOkMrXT7yKsSsH5RayW1z83Bu?=
 =?iso-8859-1?Q?CiXFQYHgcFz9EUPqPr3TiIR+0l2LaNgM0QD1/bxuhU9fswK5PnCilqggfs?=
 =?iso-8859-1?Q?7zcha1z5/DCKkqexrKLOK5wAT4ZJGKNkZwTxDPK/GjEKLHQ8gPEm7hPw1v?=
 =?iso-8859-1?Q?8T8c9BlkN8vS1TEc3PU1TXT/NliY7rjBhZqWbC6i/sjXPiIFZ4XYQkcz1+?=
 =?iso-8859-1?Q?nB/yAKUtZ9ICdiI+x3v0wfViNnyNMqE8gcu2hJYf+yRdbCG9LarlZY7NRf?=
 =?iso-8859-1?Q?CfzY2J8Wh4kA+0TgHgoRVh/bP81W5Ne3HvJXwdIBeZcTVMXGUXJr5N8O5Q?=
 =?iso-8859-1?Q?PgB6QTLyysYxquDkZpkzZOHWoO9KzpQcFd3eC2RRcQROKeXWH9VylONl17?=
 =?iso-8859-1?Q?zQH0nNiZoM0TxauuOIfeDolvr7EJEjePkAMZaCaNYEP2BQPRkFFjxmYadv?=
 =?iso-8859-1?Q?V3z6cpFO4nwtsWb+U/GqoSbjRUze1r08NFR60KoXNeGpBcKQrShdZXUxhI?=
 =?iso-8859-1?Q?G+Y93jG7sWYi1yBx4I4jsLqfIE5auo4S3GSU3b1Sj3bFpZNyLXwAiOM3uD?=
 =?iso-8859-1?Q?9G0mh9OCDyXLXxsWWbVcOcW1nK976N5xGSo3LGylV02G+GynX7fPqqz0kd?=
 =?iso-8859-1?Q?xlDmzEP3u/OugsCMUFut/i+qZO2MWU1e0HJ/G87ml1qq0iwyzTD4J2Uv/B?=
 =?iso-8859-1?Q?Yan9/O1sICjpHASZEltjmyIz2k80Zq7f1s3oR7KxYlcFlWnBC24zVpwcAy?=
 =?iso-8859-1?Q?qvGpSCFp1M60SRAQCbWSsLRAM64KsGlp4lSjQxGCpsCqKiY+GzK9bnuxWg?=
 =?iso-8859-1?Q?PypO2NVAiQ+ASgVQGv3eKNC6ADUYuKSM3+GxiA6nZOZP4kG9PGXCYorqpm?=
 =?iso-8859-1?Q?psn8PYs3rwMZeSsuLtpBMjojZfhA2Ry+kyOqdFqf6MlGZJ2slcydi7ImD1?=
 =?iso-8859-1?Q?xczGVH8tuf3fT0T/irZvAA8HnnZTe4SrRiOp48eFT8Zb2FwYWGBLFCbiQ5?=
 =?iso-8859-1?Q?zB8tzUDK7a9UX5aCJi4/DZHTLQu32jBigaJDU9duOD671e5q3Uu51qGH6n?=
 =?iso-8859-1?Q?baJANJOa7St+LZpe1fBFo3gM1nhmvZXPw6QvyUfnWqSmuL1iWW2b0KExxP?=
 =?iso-8859-1?Q?V8vzl5REU/fZ/ZY/03+bqAIDm5JDPL/v1qnXdQ/8hdHkIRuTcVjhFZWyOt?=
 =?iso-8859-1?Q?CvBQl4Bs5Jf7ljJz9keQzS2KPeseysKQ9COU4XBL2PO1iesvR1TVAGlehS?=
 =?iso-8859-1?Q?kQ9H3FrU8/VjXUBT8Bi0I73j6d97c/jvKR5HxriWoKU4mtWsHnGdPeqn4M?=
 =?iso-8859-1?Q?bk9+Oh0B+3GFy8gKJORPVAdfNgkEBiv5pfZW09rV9LNx3el5V96A/sQKcg?=
 =?iso-8859-1?Q?nVMo+1ZrhZa2kdQuwcyMSpwziXl8mGitUWLju8mkXvR+OTUnCunbFjfGeh?=
 =?iso-8859-1?Q?DMS99ervJV0AhIvklSQtBNbyfJC2/h+GPGbtKvTnGSgOGEdhp3DJiiRlkr?=
 =?iso-8859-1?Q?slpOOIaFfSy3J9rPnPUMLH/GQorEJA/XaW3dKTMkEo+ul52M3FxvqVDJfq?=
 =?iso-8859-1?Q?GQ5OFfHdXZcsLtVXgbyGT71LDjBQWuhNmOWmyTVoP9kuY5Txb38mf0MA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 087d5b59-c62b-438c-3275-08dc7a3c5509
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 08:51:12.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMG7+7lEyhmPkAHYZKPWB5YmqMcuTBpZ5L+YQMYfXWn1c30Oyb+dChzKtzBWRX0Ed+NLrgnwEockz8jF/CMdJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6743
X-OriginatorOrg: intel.com


hi, Linus, hi, Yafang Shao,


On Wed, May 15, 2024 at 09:05:24AM -0700, Linus Torvalds wrote:
> Oliver,
>  is there any chance you could run this through the test robot
> performance suite? The original full patch at
> 
>     https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail.com/
> 
> and it would be interesting if the test robot could see if the patch
> makes any difference on any other loads?
> 

we just reported a stress-ng performance improvement by this patch [1]

test robot applied this patch upon
  3c999d1ae3 ("Merge tag 'wq-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq")

filesystem is not our team's major domain, so we just made some limited review
of the results, and decided to send out the report FYI.

at first stage, we decided to check below catagories of tests as priority:

stress-ng filesystem
filebench mailserver
reaim fileserver

we also pick sysbench-fileio, blogbench into coverage.

here is a summary.

for stress-ng, besided [1] which was reported, we got below data that are
about this patch comparing to 3c999d1ae3.

either there is no significant performance change, or the change is smaller
than the noise which will make test robot's bisect fail, so these information
is just FYI. and if you have any doubt about any subtests, could you let us know
then we could check further?

(also included some net test results)

      12.87 ±  6%      -0.6%      12.79        stress-ng.xattr.ops_per_sec
       6721 ±  5%      +7.5%       7224 ± 27%  stress-ng.rawdev.ops_per_sec
       9002 ±  7%      -8.7%       8217        stress-ng.dirmany.ops_per_sec
    8594743 ±  4%      -3.0%    8337417        stress-ng.rawsock.ops_per_sec
       2056 ±  3%      +2.9%       2116        stress-ng.dirdeep.ops_per_sec
       4307 ± 21%      -6.9%       4009        stress-ng.dir.ops_per_sec
     137946 ± 18%      +5.8%     145942        stress-ng.fiemap.ops_per_sec
   22413006 ±  2%      +2.5%   22982512 ±  2%  stress-ng.sockdiag.ops_per_sec
     286714 ±  2%      -3.8%     275876 ±  5%  stress-ng.udp-flood.ops_per_sec
      82904 ± 46%     -31.6%      56716        stress-ng.sctp.ops_per_sec
    9853408            -0.3%    9826387        stress-ng.ping-sock.ops_per_sec
      84667 ± 12%     -26.7%      62050 ± 17%  stress-ng.dccp.ops_per_sec
      61750 ± 25%     -24.2%      46821 ± 38%  stress-ng.open.ops_per_sec
     583443 ±  3%      -3.4%     563822        stress-ng.file-ioctl.ops_per_sec
      11919 ± 28%     -34.3%       7833        stress-ng.dentry.ops_per_sec
      18.59 ± 12%     -23.9%      14.15 ± 27%  stress-ng.swap.ops_per_sec
     246.37 ±  2%     +15.9%     285.58 ± 12%  stress-ng.aiol.ops_per_sec
       7.45            -4.8%       7.10 ±  7%  stress-ng.fallocate.ops_per_sec
     207.97 ±  7%      +5.2%     218.70        stress-ng.copy-file.ops_per_sec
      69.87 ±  7%      +5.8%      73.93 ±  5%  stress-ng.fpunch.ops_per_sec
       0.25 ± 21%     +24.0%       0.31        stress-ng.inode-flags.ops_per_sec
     849.35 ±  6%      +1.4%     861.51        stress-ng.mknod.ops_per_sec
     926144 ±  4%      -5.2%     877558        stress-ng.lease.ops_per_sec
      82924            -2.1%      81220        stress-ng.fcntl.ops_per_sec
       6.19 ±124%     -50.7%       3.05        stress-ng.chattr.ops_per_sec
     676.90 ±  4%      -1.9%     663.94 ±  5%  stress-ng.iomix.ops_per_sec
       0.93 ±  6%      +5.6%       0.98 ±  7%  stress-ng.symlink.ops_per_sec
    1703608            -3.8%    1639057 ±  3%  stress-ng.eventfd.ops_per_sec
    1735861            -0.6%    1726072        stress-ng.sockpair.ops_per_sec
      85440            -2.0%      83705        stress-ng.rawudp.ops_per_sec
       6198            +0.6%       6236        stress-ng.sockabuse.ops_per_sec
      39226            +0.0%      39234        stress-ng.sock.ops_per_sec
       1358            +0.3%       1363        stress-ng.tun.ops_per_sec
    9794021            -1.7%    9623340        stress-ng.icmp-flood.ops_per_sec
    1324728            +0.3%    1328244        stress-ng.epoll.ops_per_sec
     146150            -2.0%     143231        stress-ng.rawpkt.ops_per_sec
    6381112            -0.4%    6352696        stress-ng.udp.ops_per_sec
    1234258            +0.2%    1236738        stress-ng.sockfd.ops_per_sec
      23954            -0.1%      23932        stress-ng.sockmany.ops_per_sec
     257030            -0.1%     256860        stress-ng.netdev.ops_per_sec
    6337097            +0.1%    6341130        stress-ng.flock.ops_per_sec
     173212            -0.3%     172728        stress-ng.rename.ops_per_sec
     199.69            +0.6%     200.82        stress-ng.sync-file.ops_per_sec
     606.57            +0.8%     611.53        stress-ng.chown.ops_per_sec
     183549            -0.9%     181975        stress-ng.handle.ops_per_sec
       1299            +0.0%       1299        stress-ng.hdd.ops_per_sec
   98371066            +0.2%   98571113        stress-ng.lockofd.ops_per_sec
      25.49            -4.3%      24.39        stress-ng.ioprio.ops_per_sec
   96745191            -1.5%   95333632        stress-ng.locka.ops_per_sec
     582.35            +0.1%     582.86        stress-ng.chmod.ops_per_sec
    2075897            -2.2%    2029552        stress-ng.getdent.ops_per_sec
      60.47            -1.9%      59.34        stress-ng.metamix.ops_per_sec
      14161            -0.3%      14123        stress-ng.io.ops_per_sec
      23.98            -1.5%      23.61        stress-ng.link.ops_per_sec
      27514            +0.0%      27528        stress-ng.filename.ops_per_sec
      44955            +1.6%      45678        stress-ng.dnotify.ops_per_sec
     160.94            +0.4%     161.51        stress-ng.inotify.ops_per_sec
    2452224            +4.0%    2549607        stress-ng.lockf.ops_per_sec
       6761            +0.3%       6779        stress-ng.fsize.ops_per_sec
     775083            -1.5%     763487        stress-ng.fanotify.ops_per_sec
     309124            -4.2%     296285        stress-ng.utime.ops_per_sec
      25567            -0.1%      25530        stress-ng.dup.ops_per_sec
       1858            +0.9%       1876        stress-ng.procfs.ops_per_sec
     105804            -3.9%     101658        stress-ng.access.ops_per_sec
       1.04            -1.9%       1.02        stress-ng.chdir.ops_per_sec
      82753            -0.3%      82480        stress-ng.fstat.ops_per_sec
     681128            +3.7%     706375        stress-ng.acl.ops_per_sec
      11892            -0.1%      11875        stress-ng.bind-mount.ops_per_sec


for filebench, similar results, but data is less unstable than stress-ng, which
means for most of them, we regarded them as that they should not be impacted by
this patch.

for reaim/sysbench-fileio/blogbench, the data are quite stable, and we didn't
notice any significant performance changes. we even doubt whether they go
through the code path changed by this patch.

so for these, we don't list full results here.

BTW, besides filesystem tests, this patch is also piped into other performance
test categories such like net, scheduler, mm and others, and since it also goes
into our so-called hourly kernels, it could run by full other performance test
suites which test robot supports. so in following 2-3 weeks, it's still possible
for us to report other results including regression.

thanks

[1] https://lore.kernel.org/all/202405221518.ecea2810-oliver.sang@intel.com/


> Thanks,
>                      Linus
> 
> On Wed, 15 May 2024 at 02:17, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > Our applications, built on Elasticsearch[0], frequently create and delete
> > files. These applications operate within containers, some with a memory
> > limit exceeding 100GB. Over prolonged periods, the accumulation of negative
> > dentries within these containers can amount to tens of gigabytes.
> >
> > Upon container exit, directories are deleted. However, due to the numerous
> > associated dentries, this process can be time-consuming. Our users have
> > expressed frustration with this prolonged exit duration, which constitutes
> > our first issue.

