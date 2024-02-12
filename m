Return-Path: <linux-fsdevel+bounces-11252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12885223F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 00:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2C11C22995
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FBE4F88A;
	Mon, 12 Feb 2024 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diHl/pGS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759B4D5A2;
	Mon, 12 Feb 2024 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779000; cv=fail; b=phStMLV1WYIbm51qvX8HTHsr/yzmNcdvR2beK/WzTfEw/vusSdM/o1v/Olk2524cDBULrqe9b1jQslo9HjkpoIoVc/mI/6hsnJp+hKvpreiFk9yyqzvaM/gGs/TwuKEwJ+JtEa+xpwwsOXAoEPmqSOAT2el64lb8k9ZlG4AayEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779000; c=relaxed/simple;
	bh=+j6E9WLGn2b/XOGOSHOQWx8TNJMcrZqjNgDK2uVXwjw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gP0IDkrdwzHzRfBYgQ6uitkz5WJsa+MzC7mMcP9OSIaQZWhwDuV1NQ+ize9BucnASpysVOXeNTVbR91xBso4Gk1JJEuRRayYM9gNPY6G1CXooUjTB4jlwe8b4CtSPLf1ZpWbA+jZOyaObk/VFEkC/uHpu7mPZDVoF+LtZTedn5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diHl/pGS; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707778998; x=1739314998;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+j6E9WLGn2b/XOGOSHOQWx8TNJMcrZqjNgDK2uVXwjw=;
  b=diHl/pGS5oHVqUwGRemwwhk/sYi8zgPxoTU/rBvKkvPfh+JFeyOk5jBf
   5Ss4rNb2a4XcVuZXhHcsSTb/DTLgVk1WdpZ4YA1emtXqbE9knPi/E3WGr
   HSvtskdPttclOT/4xYPTAaIfalLxmokY7eMsQYOD/6nWbRPM/XqIXVz9C
   x3a+KcE/ugMzFOuTVZV5fHNX/B074MndWHzI719/c0d5XcjyxqVHVl0Ny
   kUCz1U+uQ9//jipfJ7vqiFxzvohxPYF4/I/DlUVlWlbBI3VCKkW2hdeQ4
   +pvsf6Kf2Nj4r5xAtn2GycKTKYsEcExAlikw/tTeP1ZA6wCpqTCJQ+SAp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1916108"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1916108"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 15:02:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="3064004"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 15:02:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 15:02:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 15:02:52 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 15:02:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLrB53sWsg52LV9Ce1Y+gb8DTvrWl4hiwv9dd1X3tZGoXjIt1fJ9P0izBfWfCQTqlQL7k/l674GGONtQYfSn7C+c5tc+dxllVuFvCZ2tWCjwlW3bF84KwBv7grbdv7yTE1j3IdR4PwnpHTgAZYf4rAo0oYwddxKWoX5cvipDVTk9zLo0yCtfbI5nOsiXbxDG/mIIO8oEXWBHiOCmPFgE55dh4IMush5C2aoqKC0pFtlz2eGUxg+wumez7JzSGvJSJ72W5KgEGfNu5/LnCwZudSR09HCeOcRxTjRa53utyo2U26ZuYe/kym4XVKTMfGkNIZ9wMLnUdTOPsQaNcKSIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbu1yZgDWQjZLiwY7ZhIuS9kSieyOhAgd0CWg7mjeLY=;
 b=gMxnfzFY0ZVmKFyihU+rtMmOdJiYfJwyKczc1u+v4DEY/idosgfE3kV01cV5GLu23EQvWpR6+IHBdYv3qsLL8M7GN7nDYDZHFR+oGOB1/O4Mz+lIdXnXSxIv2aYdjHddvzKmA5STxtqtoOwRhWkU4uhSGGyU+z2SbZH4rAO5xIYxKtzinjMlTLKS+6qPutPeHvXRkpYrKZXO0ycGl9E6UprlZiVUSot7rD38tpyCEeE+wLgxRa4FdEHAxQK2cnp0eQqPLW2cuf0e8b9eD5ji7mGgVU8bngSOBe6K6Iev846ArTv7dBGw6YiQvDvR1s243H2p+W8dcBC8xeAa10sM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6293.namprd11.prod.outlook.com (2603:10b6:8:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 23:02:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 23:02:49 +0000
Date: Mon, 12 Feb 2024 15:02:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
	<arnd@arndb.de>, Dave Chinner <david@fromorbit.com>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
	<linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <linux-s390@vger.kernel.org>, Alasdair Kergon
	<agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, <lukas@wunner.de>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Message-ID: <65caa3966caa_5a7f294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
 <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0306.namprd04.prod.outlook.com
 (2603:10b6:303:82::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 037317e4-9f9d-4571-7b70-08dc2c1ebbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Hg1eJ4t5Q7+UVHNBpCYLNFoScGNS7E4Jpc6r8IAL2MmMkJwTuiajE245tQAKY6wd5WCwPi76B6lshSAx3DmxergXUqzbz/VEyP1B+lfDcL2h4u5rgrG6yb/l4dYgE6WDIXf/zt0IPUe6lWvd3hvm9G/UQvuoFBjO4jJbswzNH4A/KMLnhcUifyNnQviJ7Z36yHzq47D0kOZB6whilJVNaOBrDwWyqkbpPn79w/ofT+qUu3Wv2mwxia4iZdNHOKcxDte5KK5YMtqHx8W+e46x2dLnp2UBZqJ0JSsotPfrP+FgKhxX9VqkrzgdUh7oecxmLnY35UVHrBnuwKU1eOxRHBhjVfE1SNsvc2WSKtRea6SuNUh0KrWB1PXVGfvlYAjfC3wD4Kv892NdqJvsziF3Tm4KocGg3BqcjXCzfAFs0ADWjfDm4aw7W/NGGu5/NyUSVGXH3yW0agBNGT5plg/Sn6AJqVmdhM09atMC7bylQovOHLehidr9Wcha1QYQCq095sxWVUj2q2zzTaN4m2FrJ17xach9kC+yY39kSOU8as=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(38100700002)(5660300002)(82960400001)(7416002)(86362001)(6666004)(26005)(6512007)(9686003)(6506007)(110136005)(316002)(66476007)(478600001)(54906003)(4326008)(66556008)(8676002)(6486002)(966005)(8936002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6PvYMpR4fB5LSnp2a4B1qjnyRVhrUuIL6waIb3bKxQpZneqH6TeNuHEF9Q0A?=
 =?us-ascii?Q?iHE0PGhNqCIVqJY0X8BWFKGUBnB3783nxFP4T8HfifxXymjfz/FF9rWc4F1z?=
 =?us-ascii?Q?on91kstKu8PHq8P2e5cY58/slYziN3+l9ZAG+N7yDTSkb8f72EV4ZFSCl+e3?=
 =?us-ascii?Q?+5M+JuRSaGYUJMRF8clmIkaD6snobTCzfu/nPk2J/iDYXBA+DLn5CPlZKvkV?=
 =?us-ascii?Q?9txwUcyuwwBomKyz8mMsf3Zzl0ntMUu2o9jfvWMSwpS7HdFATHndTGIuYnEP?=
 =?us-ascii?Q?wh/JweFAa0lDHIMX7rg8TUITf9EWigJFkK1tuaJOSxtUnp/1cqQhzX6C+0lu?=
 =?us-ascii?Q?n5iyP1Hu1RrSNCJdAwwwut1mRGvipyEgCWxntB+9lm6ECStymLtb+ZNOyH2E?=
 =?us-ascii?Q?aShEX0hcxkApUP5zUw4vc3LPdut1casr2uyOKGi4NmxHbcnVkvI06etGMGE4?=
 =?us-ascii?Q?5+ulFSfc2P0UvbX1j6G+YywVNA8KwEHOYC+brRPMCdhP6TeDTvMtqJy1daHm?=
 =?us-ascii?Q?K0cqUruEnRue99AScg5VMdYkcFkz79OxD0dqJ1pPspUGyf8vdSKkM6jVY5ah?=
 =?us-ascii?Q?LztKHE72/u1LmniRsIPkcpzgRuoYpJMV6eNdzhtGxRVs6A1RhCSUa+DweJjm?=
 =?us-ascii?Q?WoJ4AJOLOxKC/kdUR3QkmmWbEAoRGBhNAx2v5TTOnCRzL/WEjd4j0l/Paefs?=
 =?us-ascii?Q?1mJgs95noPPxM+GA5ulqaeBa6Pe2CJz+vqp80uZ+BUtoQ7Cwfd7zlUse31XG?=
 =?us-ascii?Q?erZCdw40nFWa96qrJ5qCmN4ZEMiA/E3p4Coz79VUQPV8GnE4OJH5BymAoKOl?=
 =?us-ascii?Q?nSHrMf3ybGMdUbebXrATtEbzUKa8NAjSqCgRRw9SB/uE3gQduz96eZEYgLZt?=
 =?us-ascii?Q?WWIjXMFjDeTCqxPtqXy/V1NTaH0miRsq7hbQZZduXd/2HyJeakML9pWTqCen?=
 =?us-ascii?Q?sxWoM7nsZ8WSMm1hVmxqwMA0rkf0vRcBHKwYsUF0I6u9NJIj/8MD8quF5lBt?=
 =?us-ascii?Q?1342x0RpZq7u8JU57kdrb+UbcfGM3mb5lrWjMST26acGySruOTjPw5MqIVZv?=
 =?us-ascii?Q?9QFz2DLmb1rI4rakx+/BMO0Pqte8xHsF5MbSdAVHZJfP/dri2pNGRDCpyWVA?=
 =?us-ascii?Q?olAoUPVaD+yUrpZl7Jxkzycsordc4pWOqA+J11ZVYTUewrF6jixX+BjDBftp?=
 =?us-ascii?Q?yMxIXbkL7lIYOMf+w0d6mkggvmPMt8jPMmc5f9um8A/MqDdqlCaTo9VCiyZW?=
 =?us-ascii?Q?GFDbO1bzbNxkwJAoFgOUdm+oly3Use4aEH0AaEQmOcKw63LEPx/uJgXeMn8Q?=
 =?us-ascii?Q?jaRooegDH/rVucog7Fo2WMU3W76j2zGhFBExJkNUt/V4WMV5/swLT0K2ZhtK?=
 =?us-ascii?Q?ntRxGU5ZNcwb+nVkMs3t4edEzujwXYoU2LINiaR6eSieFLnu8w2Dt218EG21?=
 =?us-ascii?Q?wD6vXlwBCtYaIq88jTq8VQ507scIrZBjq9LsQv10i8eEM6F3H9PhGtUE8lLG?=
 =?us-ascii?Q?99x2ABjyJxeJfJh4fboa+nVxMlgRIiuf5bx3p5fpFmRtl72uGfpPeuoPz7Qe?=
 =?us-ascii?Q?X3tgnodhqrz5yjfmp/D4WtnknLGGb6T7++x0MWFhtTsxJ1zmRTH9ehx4R5IX?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 037317e4-9f9d-4571-7b70-08dc2c1ebbce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 23:02:49.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIhD1EByiOH8Y0YtK6g5ovC/SxzZUzGmrYsO1AcUpsh97rG/cjcfcAMzSCB1ijHxVeSagOq46xybzBme1ob/oUM2B3e14C817bll7TMDSFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6293
X-OriginatorOrg: intel.com

[ add Lukas ]

Linus Torvalds wrote:
> On Mon, 12 Feb 2024 at 14:04, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > This works because the internals of virtio_fs_cleanup_dax(), "kill_dax()
> > and put_dax()", know how to handle a NULL @dax_dev. It is still early
> > days with the "cleanup" helpers, but I wonder if anyone else cares that
> > the DEFINE_FREE() above does not check for NULL?
> 
> Well, the main reason for DEFINE_FREE() to check for NULL is not
> correctness, but code generation. See the comment about kfree() in
> <linux/cleanup.h>:
> 
>  * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though
>  * kfree() is fine to be called with a NULL value. This is on purpose. This way
>  * the compiler sees the end of our alloc_obj() function as [...]
> 
> with the full explanation there.
> 
> Now, whether the code wants to actually use the cleanup() helpers for
> a single use-case is debatable.
> 
> But yes, if it does, I suspect it should use !IS_ERR_OR_NULL(ptr).o

I am trying to arrive at a common recommendation given Lukas found that
IS_ERR_OR_NULL() resulted in unwanted NULL checks emitted in the
assembly [1].

He is doing something similar:

http://lore.kernel.org/r/4143b15418c4ecf87ddeceb36813943c3ede17aa.1707734526.git.lukas@wunner.de

...and introduced an assume() helper.

However, Lukas, I think Linus is right, your DEFINE_FREE() should use
IS_ERR_OR_NULL(). I.e. the problem is trying to use
__free(x509_free_certificate) in x509_cert_parse().

> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -60,24 +60,24 @@ void x509_free_certificate(struct x509_certificate *cert)
>   */
>  struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
>  {
> -       struct x509_certificate *cert;
> -       struct x509_parse_context *ctx;
> +       struct x509_certificate *cert __free(x509_free_certificate);

...make this:

    struct x509_certificate *cert __free(kfree);

...and Mathieu, this should be IS_ERR_OR_NULL() to skip an unnecessary
call to virtio_fs_cleanup_dax() at function exit that the compiler
should elide.

