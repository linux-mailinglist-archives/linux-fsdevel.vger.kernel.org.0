Return-Path: <linux-fsdevel+bounces-11934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2A08593F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 03:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FAA1C20A0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 02:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEAB15D0;
	Sun, 18 Feb 2024 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RB9E8le1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0ED1368;
	Sun, 18 Feb 2024 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708221778; cv=fail; b=B+DNNYkA80tZlkMeHJYNtC7ZAcPqdaQDC77d4BvE8ogE+abOhMqUfgqJHTAg8p7Ov8hZx5Q+grwMjzSVToRxsLVEZKmHPnx/st74vdhD3lPh9XGNeD1DMH3tmUu+kH4olSxdhmDtjoaI08dtMqicWNc1cYTHcOHgYaFrFwUIc44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708221778; c=relaxed/simple;
	bh=OnCLg1A8pAezY/5Y3gHV00oQ4X2SMk2p3foxOoLUybk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IKesfQxbGtNGzMCZOI8COseNL61tq33t2TXWNq2tt5CzvB3xDfcGSZReYQZ/ysDU4qWUTePnlMLil6hJAL/CUKlu1jv6ayW5vVMkHcaOAMFQRVTTRn8i5BqgoV19nt6+9eUt9/fSL5Zdaq5ytgqet2tBG3Wp/66p+qMEWIoftVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RB9E8le1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708221773; x=1739757773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OnCLg1A8pAezY/5Y3gHV00oQ4X2SMk2p3foxOoLUybk=;
  b=RB9E8le1HxPD1AlCXdJtyjUlnNAL1amLw5yTw00mSEI+Pj+wGpB18QCE
   6vhPdbHMYZ/mGJR8rdbFAdRuNCN23WwIfwY8Q2w/U+eoelpTm1Bm3Y7Ez
   qf5rK3ofXBvcFKc1V76bAc+qXKTM3J4nMqpr6URPMf2Ba6kadpBXREGvI
   kErg0V6IStB9pB7TErXdEgR94MpRtVYLubKyY9g7IW7cKydCwxheGceN0
   G8Jdxcf4TO2pUMErbok7fzW3inwtn3h50WHJv6su6145jL138RgBIyG3I
   ADfMyaJAaAHbf1Mhucjq/cU6yAV4k50RD5Lj8iJsQJsUu/hgnFfQ7WHgK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="24788287"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="24788287"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 18:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="8846765"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2024 18:02:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 18:02:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 18:02:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 17 Feb 2024 18:02:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 17 Feb 2024 18:02:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsuTcrg3wCNKcfqAbgguQi0qXo0qMAhtVP1Y5JME7uyPwIl9GlF4mgLQvsHItRXMuxIpCGM5Rb8qaWyXscKJUXu6cEPQxeUvQ2f95ohYRdNr0UVQGl+0qaVgbMTtnUvVN6l4apSqP5GkhmyokwCQSDFgpQ4ESnpN5vz7zsxrdOm8Duh4zYmgZpBjKXnCmcqCrygHfJWdGyQVio/wpEfudVluGkj8s/z0NQwph0q9ZXoo0R+s4EGoTIJPAQIUEvcPJhByIQYfd0RwHxs4wqZ6fvzGFJO0mrprazPiH1NHb+bQaRNQDv+5uR7r+jkiyl/byj7Z4DSb4KzteVdQW8GJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX1Y2TliWNgWg/AnRUCOjeDu8sfQuTqTzQ07IF+lRP4=;
 b=CYJKLB9WAQj5d2QsyLLwNpjBiIH6ZPJ2o+rWEkQwOFaM3oxaVCNntb/0oEJP8e9Ha+D/hR8UBCGrNxTuwYai08UWOXep2AHmszEyHfDj6bm+hDnNghS+wYZXoZ73S09083YjQvb9ob4zQQMl8NA0pquUPqMTner2chm+C8Ilzr6WUkotyCPofdqD7rmxrFtW0/2R2L4KsAJsiBMaHbl2ISW0bVrVzwTUYpRAhGwZ2VQyWkzGCGiqNt/tNYAL5YVGd5iiCELL21ppvJAI9EENorSVXFa+Abj2NVjXvP94K2eJiYLIlOBCUOViqPDuJ/UyTfI1Fu3o4SI9sKq+GO4Paw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sun, 18 Feb
 2024 02:02:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 02:02:47 +0000
Date: Sun, 18 Feb 2024 10:02:37 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <hughd@google.com>,
	<akpm@linux-foundation.org>, <Liam.Howlett@oracle.com>,
	<feng.tang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
	<linux-mm@kvack.org>, <lkp@intel.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH RFC 6/7] libfs: Convert simple directory offsets to use a
 Maple Tree
Message-ID: <ZdFlPbvexMir0WZO@xsang-OptiPlex-9020>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028128.11135.4581426129369576567.stgit@91.116.238.104.host.secureserver.net>
 <20240215130601.vmafdab57mqbaxrf@quack3>
 <Zc4VfZ4/ejBEOt6s@tissot.1015granger.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zc4VfZ4/ejBEOt6s@tissot.1015granger.net>
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c6e8db-c5f2-4de1-84a6-08dc3025b401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kxf97+XNl+tb3LCofsTIamF/OjRZnI/CMrwt8G9S+PcnhJkaJY7n3BFHzNUT++0+9C+u/LmLY0LeigXSVFEvMr+3Ugyv6q0N+ZMnuWsUhS/qGir/MsVDmq1IfSNTbteNbUtCntwJzvHmhd9QQ44l9/BnSzEr3iZZgspuEwZtvhm/cUtPsBkFo1MRHxp42tJkuP3TglSBQuqS+kGg1cSSmXqzL7AvfaUxwBjrXXABfBW4IkWf2nDZr5I3MKMqNZjPn7Enx56jXXJSfqgpdSyvTJN0zuZDvkdR7m+dR/TLEBJ19PnqMiQBi+rs/UG+SllVXLjpOq3A2daRPB/N4PBkrdbgw+dkdsd18vQ/DtgAZH+Ch3YP3piRtLED+we089awa8txJ9RO8Z13O8XmoGkS0rNEwWj4D9XLzUeiJjmS5LttVfZyyD+wx0QFE+2qUWULm8C8jMrpD252Cc/A12yc2bvDaiA8DUKrup5ky0SI+THtvP/TiqTbqo4+ATf1szBJ4kY9SxLgA1ZPtfCnlSElnf4Zc/PilNPi24FA0MSWrF5eZj9YMdgEIJqG8Oq5/ubjSKgFnsO/fJFjv/PUgpQo0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(107886003)(41300700001)(83380400001)(8936002)(66476007)(66946007)(4326008)(6916009)(66556008)(316002)(8676002)(9686003)(478600001)(54906003)(966005)(6486002)(6506007)(6512007)(6666004)(82960400001)(86362001)(38100700002)(5660300002)(33716001)(2906002)(44832011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uncXpx3V+8XWrw2agoqEp8ULKq8A47SzIFKkir6JeonS2Gu0b1i4gbB1sVaS?=
 =?us-ascii?Q?1sJ69khxInbqIQdzW61JsNw1Z8csbahb5xYV+NO345Cmp7Ur8Qw2XzI956jf?=
 =?us-ascii?Q?Y01lTfWxxsWaEEzVWhaVsbV1FPRn7bN/XQ1Q6HSdWkcWg+ChjzCmEP4u0Obq?=
 =?us-ascii?Q?wK+PeLF9wvPYOyRPH8k3PXlL7FWgTrP8XJOEsl94E2RxCPAg92pmFaF1+trx?=
 =?us-ascii?Q?veWKM1AcBXJKM3XuLXdsyS5uVCd36BYEwxBE61996qm+FB8mBwRpH1mMtePB?=
 =?us-ascii?Q?V1rDRDLxRF23uRklcIrERoAVc71eOU06PIz6PoenkZDonXO7gLNQ3LW7iLO1?=
 =?us-ascii?Q?JrRvIEvOMauHY2o9EFyzfwdbLh1NzjO2iWCZuZuOATz17EqhO8KzAzMedRKV?=
 =?us-ascii?Q?maCTYywS5OwPT99I0Z0YPLXaMUZSVSIdcB6O0eX2OMLFmaraSoaocX+DKNcA?=
 =?us-ascii?Q?MFd4xfjJ1/1Cxoph0WqrS/4bS/DjwmpUIrS35vcboVMzpN/YYQdffBDULsj/?=
 =?us-ascii?Q?bkMahSjd6EkmVCqD1WyzW04RhghlEwAsUMWrdbnV0PPe0qHHFjlpvu6UPl0d?=
 =?us-ascii?Q?Y2IJS5PgQ9nUayC5BA6vspw6+CLosUcDyoZelTomFe4ZvyiCC7xEGvCaZQ1J?=
 =?us-ascii?Q?+vyg63N0fZcL2deALIOOlbd7X+vua9Vf0wLMVB3RMBKRhoZeHSJey7OW08cO?=
 =?us-ascii?Q?yTIDAU+MuU7C8LKBz0FOlls44eZP1aKsKOsWsF5ANYVm3zAD2nWEpO5c/W/L?=
 =?us-ascii?Q?q+V2ux7igYoljeKf85xNRJuxa56uCs3AeLnrYWWgIBXpnnfxXrCLxSAIfVp9?=
 =?us-ascii?Q?sFuXlZhYAMLfEEHtB/GZdpycNWfDKK7g4+G9ERNttqe5QgCm8pydBhqhyRki?=
 =?us-ascii?Q?pNbQUgmJhIP3chKiZmwXpeqdVpnh+uWiSTfd0BjMv/t13t05yEjKE9Oov5kc?=
 =?us-ascii?Q?beRW3E/RVpopzW7ZiWEjBm4DLfBi1tFWcPK7k+sJE/W8C3vN/u4BdsBcnN0Q?=
 =?us-ascii?Q?zGSDZvuSQmlbOBA+fEEBBO28hY5xIYnJSC5dPfhZq7ZTB+Fcq0yIJTl230t4?=
 =?us-ascii?Q?oT7ksjyRrLcxyPO/bdis0xiSBaxPBVIqSst0DkGkDZ72abhAPiNoNAGGv54j?=
 =?us-ascii?Q?5zxBRcGJdwH23mK2D0PVIq1fXUJn6QEHn4BkcQXmeavLLxeP79wTIK5QU551?=
 =?us-ascii?Q?OX//AzMdv9kO5OEx4jUHtTggUm/mb1keRVS+9ur/xOfpIuJ21gJxlhvpvStz?=
 =?us-ascii?Q?H+DHNa5UHKTN7l3S8mi2lFGukurnpP0qcQOuw7Fbp/vTi3EAxx1j7afh3oex?=
 =?us-ascii?Q?XS8p97veJPDN9uwWf+LGtQHn67FdrnpEUJ4jdWY/T50GM4BuWPNyEQfariUW?=
 =?us-ascii?Q?zZDnic4EpZbSn2+zozbe8/FjxNwGKBHlvGrQSQ3IWPKpSvErYHP7mBxItHrK?=
 =?us-ascii?Q?FRSiT0LqqfuBIq1mE8HOglq3HucmWEC4KGm8ksJ81WpwNeBQzVgzq01zd2Sz?=
 =?us-ascii?Q?n+duzoRMmnSmas6e2a0/cf4DGz65Kr8jY1RYSYqJosmLgk324f+2r4nx1pO3?=
 =?us-ascii?Q?Z2aWBuKbYkTayUrWR15CQarAFWUzCvZCIwdLhjICY1EdrrkAhSTbkpbVSTmP?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c6e8db-c5f2-4de1-84a6-08dc3025b401
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 02:02:47.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTVMbvyCQ0gHkXMtnVK05PZB8edGvWsedjGrIX+fG4Vs0Pa8LisRSNC4URNZisuZ8/u5dteM4XZ8f/VX7GfO7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
X-OriginatorOrg: intel.com

hi, Chuck Lever,

On Thu, Feb 15, 2024 at 08:45:33AM -0500, Chuck Lever wrote:
> On Thu, Feb 15, 2024 at 02:06:01PM +0100, Jan Kara wrote:
> > On Tue 13-02-24 16:38:01, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > Test robot reports:
> > > > kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> > > >
> > > > commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > Feng Tang further clarifies that:
> > > > ... the new simple_offset_add()
> > > > called by shmem_mknod() brings extra cost related with slab,
> > > > specifically the 'radix_tree_node', which cause the regression.
> > > 
> > > Willy's analysis is that, over time, the test workload causes
> > > xa_alloc_cyclic() to fragment the underlying SLAB cache.
> > > 
> > > This patch replaces the offset_ctx's xarray with a Maple Tree in the
> > > hope that Maple Tree's dense node mode will handle this scenario
> > > more scalably.
> > > 
> > > In addition, we can widen the directory offset to an unsigned long
> > > everywhere.
> > > 
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > OK, but this will need the performance numbers.
> 
> Yes, I totally concur. The point of this posting was to get some
> early review and start the ball rolling.
> 
> Actually we expect roughly the same performance numbers now. "Dense
> node" support in Maple Tree is supposed to be the real win, but
> I'm not sure it's ready yet.
> 
> 
> > Otherwise we have no idea
> > whether this is worth it or not. Maybe you can ask Oliver Sang? Usually
> > 0-day guys are quite helpful.
> 
> Oliver and Feng were copied on this series.

we are in holidays last week, now we are back.

I noticed there is v2 for this patch set
https://lore.kernel.org/all/170820145616.6328.12620992971699079156.stgit@91.116.238.104.host.secureserver.net/

and you also put it in a branch:
https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
"simple-offset-maple" branch.

we will test aim9 performance based on this branch. Thanks

> 
> 
> > > @@ -330,9 +329,9 @@ int simple_offset_empty(struct dentry *dentry)
> > >  	if (!inode || !S_ISDIR(inode->i_mode))
> > >  		return ret;
> > >  
> > > -	index = 2;
> > > +	index = DIR_OFFSET_MIN;
> > 
> > This bit should go into the simple_offset_empty() patch...
> > 
> > > @@ -434,15 +433,15 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> > >  
> > >  	/* In this case, ->private_data is protected by f_pos_lock */
> > >  	file->private_data = NULL;
> > > -	return vfs_setpos(file, offset, U32_MAX);
> > > +	return vfs_setpos(file, offset, MAX_LFS_FILESIZE);
> > 					^^^
> > Why this? It is ULONG_MAX << PAGE_SHIFT on 32-bit so that doesn't seem
> > quite right? Why not use ULONG_MAX here directly?
> 
> I initially changed U32_MAX to ULONG_MAX, but for some reason, the
> length checking in vfs_setpos() fails. There is probably a sign
> extension thing happening here that I don't understand.
> 
> 
> > Otherwise the patch looks good to me.
> 
> As always, thank you for your review.
> 
> 
> -- 
> Chuck Lever

