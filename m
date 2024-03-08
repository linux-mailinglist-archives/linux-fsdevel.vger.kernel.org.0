Return-Path: <linux-fsdevel+bounces-13984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA20B875FFD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 09:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60101284F1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 08:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67E452F75;
	Fri,  8 Mar 2024 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dP29Mz6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E822EF8;
	Fri,  8 Mar 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887480; cv=fail; b=XJZk2k9RrKdCdwvvkbvxiCr86lWY2KqaIf1AqD7ioxk1r92WxMGwYIOJQ39QHfpzhI4c4CbFWIPbePNNhKPy4rQuptyc5siEjZBqloR4PX2zXt6s6Sg1xBdQNNlf6B2h3DUc2KI/Usza1LUakjgkvsEORWKo9e6ozzinY2lmAL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887480; c=relaxed/simple;
	bh=Pzvy7NfSrvRuG22wn1jN1FAojhrbKh8BjR1xsKn4+jY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGS0YgVZQ4pM+nCFMkRnAyedMn8LM2dM+BuscL28uB8DvCdqig6G9aIQcPEMDSsbYH8QqYhTTpHnnAYvmGk+HJDfSAlkUL9BduOEifrnZzKvREmfpgPksJOXE/2IKgoMqvitAxUVTaHMGqmR1X4oUIPPsiROHH/2ReF6Dj2YLpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dP29Mz6G; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709887476; x=1741423476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pzvy7NfSrvRuG22wn1jN1FAojhrbKh8BjR1xsKn4+jY=;
  b=dP29Mz6G+hp1AgCpMiTyVgriTfdm83mhkfyDBimZIjt1/TFfZrEaXdfQ
   CDSPzU5nKf/v9DqjAGMfBDdyD1RE0HzJx6pKmnx8j0SOY6NnOoYZ2PHgD
   cVqR1V2HGAXJUvMFl5wxkx2THf+qwkH5IRZEsV4mkI/w/tyLwPwwVZ9sR
   1dRiP/dquugL39PNXaqoDLECk13UPdr85vAcPTM0568t0PjDadn+VZX6k
   U9NboeekFm057czYHIHsEBGWjmUcr1HFmCx6ESyQX6fJ4Q8MBSHD3Q4Xm
   oI+MYUi7vKrMDjwsbCf1VvkgScRfADL5eRaOq6BZTECqe6MspOvFLusAR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8417380"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="8417380"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10294265"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 00:44:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 00:44:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 00:44:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 00:44:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 00:44:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isza9rKHZqAfrtrogW7Io7KE7yKIwwR6g23GIoX6nV6R6BLWniDN7qnexZof3jF8MNGj3tGt9F0yNlEqWzRAZ7M/sm1MN4miora/YTKomH6BT9PGnXIkgn/KDgNo55F8uWinBYNwoCIl4QSbAM+pA3nWwK4nlOYX1Y8lhnnCYJoFZ52JYnDsVrtqY/boCza6eztTpM2N8XJnQ8T5AvRpS8IxKcUFJprEXyhagO40Hbgy6PQq9/j5IHrmRiIYUAFlKWFMKUYtYKShzScyAX3hWvwM1WM0wXrBxrj3SZE0NkuScG/AVbN8cPq9xenCjarWOSgaOeC4m/6+WBCAm0YLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRIidVmaI9df6uMZdmYvO42TUAmLEmA/ktsACHnHRuc=;
 b=JpbSlXS+RJHKbrAHNwOJaMlJ01DezYChuMCxTUmNl/3RMdaVzswybOZQfxojcLsof6ROhN1XKif7tjKidiMqwfAss87WfF+qzb4lgxXVfZDjYnEVZdUmfV7swqaVhv9w4/Da50k8vXkYigT0HoEw0I1DzNO3kqCbEmi7cZbfYtBQaaE8lKcJIs++Wg6fTQVMBIkPYsSmbxTxHJc8TI6xNiCv8IxW3RekNxgX2lIVXv28fljKoCt+7jbVqdG42ufMg8dOr+on/AsTIq004dYdPOqDScWttLpGBttL9Y9yxkMYrwaSXMcZug3SCbPHnWwIS1vtGzgZG/Ry8XmndAgPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 08:44:27 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 08:44:27 +0000
Date: Fri, 8 Mar 2024 16:37:37 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Jan Kara <jack@suse.cz>, "Yin, Fengwei" <fengwei.yin@intel.com>, "Oliver
 Sang" <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Guo Xuenan <guoxuenan@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>
Subject: Re: [linus:master] [readahead] ab4443fe3c: vm-scalability.throughput
 -21.4% regression
Message-ID: <ZerOUSJap4kAuHX8@yujie-X299>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
 <20240222115032.u5h2phfxpn77lu5a@quack3>
 <20240222183756.td7avnk2srg4tydu@quack3>
 <ZeVVN75kh9Ey4M4G@yujie-X299>
 <dee823ca-7100-4289-8670-95047463c09d@intel.com>
 <20240307092308.u54fjngivmx23ty3@quack3>
 <ZeoFQnVYLLBLNL6J@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZeoFQnVYLLBLNL6J@casper.infradead.org>
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8ba78e-1b78-4400-e159-08dc3f4bf681
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOF3oOFb4U0vmYYkvkuXewFYwqeS9Gg8Mx9c7D4M9XMfpi1Xypl61HIpgQ7nnwJfhJvaoVw6iWmsgWrDudjf512CU36Jx4geE/ucjzLxcgLi21KtPNik6x5NIJSIKiTXpHAenyPL9pGY+XxJsZyljaiSbfFpIcxKIhK9SjKzJmSWsNxaB8SnleOzS7iDZs0wQwaPdj+BPg3TghbU5m5MDDbZT1E+ChHZl3CG1uU6zSLK+F5Tj+3oWmyaBTYlq81KL5wzklHMTGWsT2BuQzid88yjOwDfcbOUZsNt6DJEscf6OMkQZHm3xTvRtUch0rlC4uiUTEiDMMddxac6dgchvpGZT9/oL2jaGU+foh2GqJuS954U48dtb8OsM+9Zbwshl8woHih9bBbm6oP94rciuDFJx8QWTk2H2rFM6gFZtx21RxLZOfeYFGyUr+c2tk9bAuWrSKbUut0uw9OczWBzgYySAF3UAZq/ok8KVDBPe46UQuEzmsGTby4N/Dagx7lnH0qFv4aL6+V+C8aVJeFuDMpPa7/SrNHGOeqtVyfCAp0WMXDq5e6h3shzFewiE4ImiLCjHXk5QZJRuh3Nv7PXlQhovuBNymqKzdimf4o+kLdga7j00QSO5mLL1qo2x/1RH5NNP3ORtVX9JnJ4Pfuq7VefXN6HqhhYtkXintsknek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IHHb2STvUkyj5/SSEvuDRfSqt5jOdB8wRlKUDAd8WE7ENJsOP6GcRBvrPRa3?=
 =?us-ascii?Q?Snk6sfbcaukbWCnM0PLJVZxmgFvsdBpYOjEsm9NqABApNRv+b3baA+cudBdJ?=
 =?us-ascii?Q?Rorb3Cgkc4b5xzDhKaRddgebQV5rLiFoc5p6g+at90U/BCDOQ/wTHQk9Ud4i?=
 =?us-ascii?Q?JQOi4+IAxC7SAPJ3bJfa57CT7baj02kduMCxS4bdn6t7Hcz+uqaOtcYkGDkv?=
 =?us-ascii?Q?ICeQZVhFSOYzBE48MzbXYfBKe3/bTPls0kPWybUms7nSGBuxLY+T0WFf/pkp?=
 =?us-ascii?Q?JwLbljnj2btmMj2MhJ/qfwDqQgB2buduxlsWVca3UnZLTpM4SiVOF9d+SYUo?=
 =?us-ascii?Q?bY37xDx4/ybBL5QVXR28enabd8v+j4PEbS7LgvmO6EthllQdZ/gBe1tXPHkI?=
 =?us-ascii?Q?wgqrxpy+xvdUa34gya9p1zvD/mJWqdMLe6G2KfSsGa6JRZm3ZAeOOB5yP7X9?=
 =?us-ascii?Q?b8bKj77Q4kPurzJG3v2Gnv/SMhQyalJRNRAjaB4vWJrIPR0iqZpVAsDUyTp6?=
 =?us-ascii?Q?WG6DElAXl+T9FMju2Ni4B45Qx1s8GzlzYTxcPmRDPJqM9VUeObDJdukveu0M?=
 =?us-ascii?Q?ycSJG2jSFrBJwtpHyGxm7seEgcr2RAibI0GOPj3CQL9uJWaQzqkkFuSf1qx4?=
 =?us-ascii?Q?TD84RxvvKdxFZT7KJYn403Nqa0VOXm4rsPa9NnJEGZzL8aq3IBUwcoWuD/3q?=
 =?us-ascii?Q?3RWhAmtEMWkwvvbjNXs5+TfGzzN3opXBPs1MIwFSrOTpGsOW0Z3la7/iiK2j?=
 =?us-ascii?Q?1Zk98TDusmEB4MLvXdZcxWJz1rhyWtBn+Tmoy+1rqnv60MpfZbczu7T1smQ6?=
 =?us-ascii?Q?8E1MW6nX8xNUh7lasOZPGvus3fD3Dlhciuta30e73Og2eQ2/sklSTxPq3ypf?=
 =?us-ascii?Q?YjgwOq2ymFofl2hhXKuDA1W8DVzy1+qTs7RYAwi90gdUJZ5weiwlIyGagW8t?=
 =?us-ascii?Q?rGAqMLka5s2DtTZ40jVDOtyL1ac/fpvc0MmIO+8zb8wwTNGWeHlRnf8paSZi?=
 =?us-ascii?Q?wvmyPR3DKePSTl1gz9X4QwNPKsxbxvgp4l2VL3pCLIuJpjp+7ZFaUz4h0F7Q?=
 =?us-ascii?Q?n2GiYkM4m8ZeEOf74eE/nW9kUSc9Mkhr7NoXUAvSQezFtzNyFLRrZztlLTrz?=
 =?us-ascii?Q?1QtYGwfrLgMwd/n96l3JDkvRtjx7PVPLQhEZ3UkRRv9L22ilqK49KkzMaEA1?=
 =?us-ascii?Q?Wk00KEwqgDaBImGHW0FCVnBuTOfKsVGdu1UTmxpNs2rRc/nUSVOdv8ASbppN?=
 =?us-ascii?Q?3n4YFYFcdmGhG0sMO+O5yxUPGcDo4q9JwIa6zESRLYZzdBQEYmr5pnF/I+3I?=
 =?us-ascii?Q?vrYSpHnnb2TDSAd4ca6t/b04GdhKzjnAzBrZSvQ0+ipx44A6w7xPmyA+0xLW?=
 =?us-ascii?Q?PfSV5FMVsrWD3X9zdz204Pg998YRyn1vVIzRqXSV5vJ+F+jpccarN6D7Zbe4?=
 =?us-ascii?Q?7ZGdK422upHu7uW8OP6VQU8mdIlhF3GKDfiBIO1xksi2Zj+GiB5GrQIt8ZdT?=
 =?us-ascii?Q?OutjkD/HwASaaSltqX3BVhkVmPD3SNAQk7E1HuCdR2Hm/110qAzXa903FncT?=
 =?us-ascii?Q?chrmn7hAaXw/osVcYOJ5BIVnTuyv2+pp54Uzzd9/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8ba78e-1b78-4400-e159-08dc3f4bf681
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:44:27.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcf4Zn0oZRche6FPU4LimvkRJCxkWl/mOZ1XR6yxNog33nzFbdq+LNIZLy5siVHj7XduG5xptIyvLl/+jsyT2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com

On Thu, Mar 07, 2024 at 06:19:46PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 07, 2024 at 10:23:08AM +0100, Jan Kara wrote:
> > Thanks for testing! This is an interesting result and certainly unexpected
> > for me. The readahead code allocates naturally aligned pages so based on
> > the distribution of allocations it seems that before commit ab4443fe3ca6
> > readahead window was at least 32 pages (128KB) aligned and so we allocated
> > order 5 pages. After the commit, the readahead window somehow ended up only
> > aligned to 20 modulo 32. To follow natural alignment and fill 128KB
> > readahead window we allocated order 2 page (got us to offset 24 modulo 32),
> > then order 3 page (got us to offset 0 modulo 32), order 4 page (larger
> > would not fit in 128KB readahead window now), and order 2 page to finish
> > filling the readahead window.
> > 
> > Now I'm not 100% sure why the readahead window alignment changed with
> > different rounding when placing readahead mark - probably that's some
> > artifact when readahead window is tiny in the beginning before we scale it
> > up (I'll verify by tracing whether everything ends up looking correctly
> > with the current code). So I don't expect this is a problem in ab4443fe3ca6
> > as such but it exposes the issue that readahead page insertion code should
> > perhaps strive to achieve better readahead window alignment with logical
> > file offset even at the cost of occasionally performing somewhat shorter
> > readahead. I'll look into this once I dig out of the huge heap of email
> > after vacation...
> 
> I was surprised by what you said here, so I went and re-read the code
> and it doesn't work the way I thought it did.  So I had a good long think
> about how it _should_ work, and I looked for some more corner conditions,
> and this is what I came up with.
> 
> The first thing I've done is separate out the two limits.  The EOF is
> a hard limit; we will not allocate pages beyond EOF.  The ra->size is
> a soft limit; we will allocate pages beyond ra->size, but not too far.
> 
> The second thing I noticed is that index + ra_size could wrap.  So add
> a check for that, and set it to ULONG_MAX.  index + ra_size - async_size
> could also wrap, but this is harmless.  We certainly don't want to kick
> off any more readahead in this circumstance, so leaving 'mark' outside
> the range [index..ULONG_MAX] is just fine.
> 
> The third thing is that we could allocate a folio which contains a page
> at ULONG_MAX.  We don't really want that in the page cache; it makes
> filesystems more complicated if they have to check for that, and we
> don't allow an order-0 folio at ULONG_MAX, so there's no need for it.
> This _should_ already be prohibited by the "Don't allocate pages past EOF"
> check, but let's explicitly prohibit it.
> 
> Compile tested only.

We applied the diff on top of commit ab4443fe3ca6 but got a kernel panic
when running the dd test:

[ 109.259674][ C46] watchdog: BUG: soft lockup - CPU#46 stuck for 22s! [ dd:8616]
[ 109.268946][ C46] Modules linked in: xfs loop intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp btrfs blake2b_generic kvm_intel xor kvm irqbypass crct10dif_pclmul crc32_pclmul sd_mod raid6_pq ghash_clmulni_intel libcrc32c crc32c_intel sg sha512_ssse3 i915 nvme rapl drm_buddy nvme_core intel_gtt ahci t10_pi drm_display_helper ast intel_cstate libahci ipmi_ssif ttm drm_shmem_helper mei_me i2c_i801 crc64_rocksoft_generic video crc64_rocksoft acpi_ipmi intel_uncore megaraid_sas mei drm_kms_helper joydev libata i2c_ismt i2c_smbus dax_hmem crc64 wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter drm fuse ip_tables
[ 109.336216][ C46] CPU: 46 PID: 8616 Comm: dd Tainted: G          I        6.8.0-rc1-00005-g6c6de6e42e46 #1
[ 109.347892][ C46] Hardware name: NULL NULL/NULL, BIOS 05.02.01 05/12/2023
[ 109.356324][ C46] RIP: 0010:page_cache_ra_order (mm/readahead.c:521)
[ 109.363394][ C46] Code: cf 48 89 e8 4c 89 fa 48 d3 e0 48 01 c2 75 09 83 e9 01 48 89 e8 48 d3 e0 49 8d 77 ff 48 01 f0 49 39 c6 73 11 83 e9 01 48 89 e8 <48> d3 e0 48 01 f0 49 39 c6 72 ef 31 c0 83 f9 01 8b 3c 24 0f 44 c8
All code
========
   0:   cf                      iret
   1:   48 89 e8                mov    %rbp,%rax
   4:   4c 89 fa                mov    %r15,%rdx
   7:   48 d3 e0                shl    %cl,%rax
   a:   48 01 c2                add    %rax,%rdx
   d:   75 09                   jne    0x18
   f:   83 e9 01                sub    $0x1,%ecx
  12:   48 89 e8                mov    %rbp,%rax
  15:   48 d3 e0                shl    %cl,%rax
  18:   49 8d 77 ff             lea    -0x1(%r15),%rsi
  1c:   48 01 f0                add    %rsi,%rax
  1f:   49 39 c6                cmp    %rax,%r14
  22:   73 11                   jae    0x35
  24:   83 e9 01                sub    $0x1,%ecx
  27:   48 89 e8                mov    %rbp,%rax
  2a:*  48 d3 e0                shl    %cl,%rax         <-- trapping instruction
  2d:   48 01 f0                add    %rsi,%rax
  30:   49 39 c6                cmp    %rax,%r14
  33:   72 ef                   jb     0x24
  35:   31 c0                   xor    %eax,%eax
  37:   83 f9 01                cmp    $0x1,%ecx
  3a:   8b 3c 24                mov    (%rsp),%edi
  3d:   0f 44 c8                cmove  %eax,%ecx

Code starting with the faulting instruction
===========================================
   0:   48 d3 e0                shl    %cl,%rax
   3:   48 01 f0                add    %rsi,%rax
   6:   49 39 c6                cmp    %rax,%r14
   9:   72 ef                   jb     0xfffffffffffffffa
   b:   31 c0                   xor    %eax,%eax
   d:   83 f9 01                cmp    $0x1,%ecx
  10:   8b 3c 24                mov    (%rsp),%edi
  13:   0f 44 c8                cmove  %eax,%ecx
[ 109.385897][ C46] RSP: 0018:ffa0000012837c00 EFLAGS: 00000206
[ 109.393176][ C46] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000020159674
[ 109.402607][ C46] RDX: 000000000004924c RSI: 0000000000049249 RDI: ff11003f6f3ae7c0
[ 109.412038][ C46] RBP: 0000000000000001 R08: 0000000000038700 R09: 0000000000000013
[ 109.421447][ C46] R10: 0000000000022c04 R11: 0000000000000001 R12: ffa0000012837cb0
[ 109.430868][ C46] R13: ffd400004fee4b40 R14: 0000000000049249 R15: 000000000004924a
[ 109.440270][ C46] FS:  00007f777e884640(0000) GS:ff11003f6f380000(0000) knlGS:0000000000000000
[ 109.450756][ C46] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 109.458603][ C46] CR2: 00007f2d4d425020 CR3: 00000001b4f84005 CR4: 0000000000f71ef0
[ 109.468003][ C46] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 109.477392][ C46] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 109.486794][ C46] PKRU: 55555554
[ 109.491197][ C46] Call Trace:
[ 109.495300][ C46]  <IRQ>
[ 109.498922][ C46] ? watchdog_timer_fn (kernel/watchdog.c:548)
[ 109.505074][ C46] ? __pfx_watchdog_timer_fn (kernel/watchdog.c:466)
[ 109.511620][ C46] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752)
[ 109.518059][ C46] ? hrtimer_interrupt (kernel/time/hrtimer.c:1817)
[ 109.524088][ C46] ? __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1065 arch/x86/kernel/apic/apic.c:1082)
[ 109.531286][ C46] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 14))
[ 109.538190][ C46]  </IRQ>
[ 109.541867][ C46]  <TASK>
[ 109.545545][ C46] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:649)
[ 109.552832][ C46] ? page_cache_ra_order (mm/readahead.c:521)
[ 109.559122][ C46] filemap_get_pages (mm/filemap.c:2500)
[ 109.564935][ C46] filemap_read (mm/filemap.c:2594)
[ 109.570241][ C46] xfs_file_buffered_read (fs/xfs/xfs_file.c:315) xfs
[ 109.577202][ C46] xfs_file_read_iter (fs/xfs/xfs_file.c:341) xfs
[ 109.583749][ C46] vfs_read (include/linux/fs.h:2079 fs/read_write.c:395 fs/read_write.c:476)
[ 109.588762][ C46] ksys_read (fs/read_write.c:619)
[ 109.593660][ C46] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 109.599038][ C46] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
[ 109.605982][ C46] RIP: 0033:0x7f777e78d3ce
[ 109.611255][ C46] Code: c0 e9 b6 fe ff ff 50 48 8d 3d 6e 08 0b 00 e8 69 01 02 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
All code
========
   0:   c0 e9 b6                shr    $0xb6,%cl
   3:   fe                      (bad)
   4:   ff                      (bad)
   5:   ff 50 48                call   *0x48(%rax)
   8:   8d 3d 6e 08 0b 00       lea    0xb086e(%rip),%edi        # 0xb087c
   e:   e8 69 01 02 00          call   0x2017c
  13:   66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
  1a:   00 00
  1c:   64 8b 04 25 18 00 00    mov    %fs:0x18,%eax
  23:   00
  24:   85 c0                   test   %eax,%eax
  26:   75 14                   jne    0x3c
  28:   0f 05                   syscall
  2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax         <-- trapping instruction
  30:   77 5a                   ja     0x8c
  32:   c3                      ret
  33:   66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
  3a:   00 00
  3c:   48 83 ec 28             sub    $0x28,%rsp

Code starting with the faulting instruction
===========================================
   0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
   6:   77 5a                   ja     0x62
   8:   c3                      ret
   9:   66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
  10:   00 00
  12:   48 83 ec 28             sub    $0x28,%rsp
[ 109.633619][ C46] RSP: 002b:00007ffc78ab2778 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 109.643392][ C46] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f777e78d3ce
[ 109.652686][ C46] RDX: 0000000000001000 RSI: 00005629c0f7c000 RDI: 0000000000000000
[ 109.661976][ C46] RBP: 00005629c0f7c000 R08: 00005629c0f7bd30 R09: 00007f777e870be0
[ 109.671251][ C46] R10: 00005629c0f7c000 R11: 0000000000000246 R12: 0000000000000000
[ 109.680528][ C46] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffffffffff
[ 109.689808][ C46]  </TASK>
[ 109.693512][ C46] Kernel panic - not syncing: softlockup: hung tasks


# mm/readahead.c

486 void page_cache_ra_order(struct readahead_control *ractl,
487                 struct file_ra_state *ra, unsigned int new_order)
488 {
489         struct address_space *mapping = ractl->mapping;
490         pgoff_t index = readahead_index(ractl);
491         pgoff_t last = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
492         pgoff_t limit = index + ra->size;
493         pgoff_t mark = index + ra->size - ra->async_size;
494         int err = 0;
495         gfp_t gfp = readahead_gfp_mask(mapping);
496
497         if (!mapping_large_folio_support(mapping) || ra->size < 4)
498                 goto fallback;
499
500         if (new_order < MAX_PAGECACHE_ORDER) {
501                 new_order += 2;
502                 if (new_order > MAX_PAGECACHE_ORDER)
503                         new_order = MAX_PAGECACHE_ORDER;
504                 while ((1 << new_order) > ra->size)
505                         new_order--;
506         }
507
508         if (limit < index)
509                 limit = ULONG_MAX;
510
511         filemap_invalidate_lock_shared(mapping);
512         while (index < limit) {
513                 unsigned int order = new_order;
514
515                 /* Align with smaller pages if needed */
516                 if (index & ((1UL << order) - 1))
517                         order = __ffs(index);
518                 if (index + (1UL << order) == 0)
519                         order--;
520                 /* Don't allocate pages past EOF */
521                 while (index + (1UL << order) - 1 > last)
522                         order--;
523                 /* THP machinery does not support order-1 */
524                 if (order == 1)
525                         order = 0;
526                 err = ra_alloc_folio(ractl, index, mark, order, gfp);
527                 if (err)
528                         break;
529                 index += 1UL << order;
530         }
531
532         if (index > limit) {
533                 ra->size += index - limit - 1;
534                 ra->async_size += index - limit - 1;
535         }
536
537         read_pages(ractl);
538         filemap_invalidate_unlock_shared(mapping);
539
540         /*
541          * If there were already pages in the page cache, then we may have
542          * left some gaps.  Let the regular readahead code take care of this
543          * situation.
544          */
545         if (!err)
546                 return;
547 fallback:
548         do_page_cache_ra(ractl, ra->size, ra->async_size);
549 }


Regards,
Yujie

> diff --git a/mm/readahead.c b/mm/readahead.c
> index 130c0e7df99f..742e1f39035b 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -488,7 +488,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  {
>  	struct address_space *mapping = ractl->mapping;
>  	pgoff_t index = readahead_index(ractl);
> -	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
> +	pgoff_t last = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
> +	pgoff_t limit = index + ra->size;
>  	pgoff_t mark = index + ra->size - ra->async_size;
>  	int err = 0;
>  	gfp_t gfp = readahead_gfp_mask(mapping);
> @@ -496,23 +497,26 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	if (!mapping_large_folio_support(mapping) || ra->size < 4)
>  		goto fallback;
>  
> -	limit = min(limit, index + ra->size - 1);
> -
>  	if (new_order < MAX_PAGECACHE_ORDER) {
>  		new_order += 2;
>  		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
>  		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  	}
>  
> +	if (limit < index)
> +		limit = ULONG_MAX;
>  	filemap_invalidate_lock_shared(mapping);
> -	while (index <= limit) {
> +	while (index < limit) {
>  		unsigned int order = new_order;
>  
>  		/* Align with smaller pages if needed */
>  		if (index & ((1UL << order) - 1))
>  			order = __ffs(index);
> +		/* Avoid wrap */
> +		if (index + (1UL << order) == 0)
> +			order--;
>  		/* Don't allocate pages past EOF */
> -		while (index + (1UL << order) - 1 > limit)
> +		while (index + (1UL << order) - 1 > last)
>  			order--;
>  		err = ra_alloc_folio(ractl, index, mark, order, gfp);
>  		if (err)

