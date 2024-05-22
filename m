Return-Path: <linux-fsdevel+bounces-19987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735BE8CBCB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 10:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298462821C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309F7F470;
	Wed, 22 May 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1p3mCHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1D7E56B;
	Wed, 22 May 2024 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365529; cv=fail; b=ry5Op0PiPACEOL5UUyxYv/tII8npawOLohflKNbASFX7MUz2mElIGjdruM8dg/f9LWgcbSXwKsMjC7ckVFXc3iqOjrfReSac9aCRv9jjZUB36cBj4yj09Vp7QgJYENqzRGrudIvRW4Kqrs6ErNJoCW8IUxQbb1ePEVBV1bkPStk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365529; c=relaxed/simple;
	bh=o3jn4BOFb2ppmGRImBiBMSQNTzGMVafFQ221sFcYWxw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MZjiWBvoWG/HJG3z9lJA259kr6Es9OLTdhv+mxLYr4hBQqMPpahMMrj58e7mo3tZSRGCiKnjLKy2usz7Cx8Ync8n/7aKt50JlZQP4DNu0EQSANQN4MUeG06n/X+u39QotNKOEFB/93Foc7bRYrI6u7VaVNdioVb/urocpmBV87Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1p3mCHB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716365527; x=1747901527;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=o3jn4BOFb2ppmGRImBiBMSQNTzGMVafFQ221sFcYWxw=;
  b=i1p3mCHB+4op+Jh4uNFqN3cXVopzCjVCWgvp0UeSBP5adxVT8pSJelK8
   URB8xZ1KCsB/S+P3v49RqBs26Y86P8DwdOPVXF51C9KBnzvIpic4h0W/x
   Vg+ymtQsn8WB0eEkiBeGKF95kF5GiWPdaqBMEzWHDYrGRbPR2ok1GavVg
   ffI39vtL2BJMLOkOwudNNI/BMXKeFElTmEL0NGdUtzo9Qr1kn1HKFOiPi
   ij5ckJk0w0ZzkTStxZZcG08wcnfbnx6plR3MwDk79ETVnUoXtYmg2mGQy
   SacAHqAQhQny3UdbbN/9+Lq+Jg1/Xh7VQLU3qup5caCBFZA7196iJ+ygt
   w==;
X-CSE-ConnectionGUID: MsnWGIevSxSqAYYKvHYLuQ==
X-CSE-MsgGUID: /xs9gcijT+OKu3r+t8kB2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37984158"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37984158"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 01:12:06 -0700
X-CSE-ConnectionGUID: epcn/5DxSd6+vs6hmEZ5jw==
X-CSE-MsgGUID: FEzxvYCeTgWxT54uaRJyTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="38160668"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 01:12:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 01:12:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 01:12:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 01:12:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 01:12:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLeZiXXw29io09B7Mikd4RNgCGEsuu0ARIg9Fo7kG3mdH4BCzmeGkiJl8IAywfkvjuNhnpLyXs7UgAwB6CJT/Zd+RvthEmmbD7nAVQ3peRK1uUfSgYxuoKUKjITwxblky6cTI7dGsS42257wrV0T1OWTG/bOjofu8bpoVKu9Dl35+yKYmHjDDoDH+nK4o6XP7d+WR7S9Tl1ydobb99TcOgrlfaeefOzMi3j726/lzjLkV+rzzLg6AHFhmtTRmkudm2BauJ+J2YvrtDSVYMvtKaiiCGKGpoe/pR03TSm0PHuRwq6FCz3h+BlZ4J4H1df67Jb0NM+4F/uXTNa433p86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyHE2Z9myg3emat7OqaA4TJO0M/HyBISxYNMs6qNIBY=;
 b=SDzUBfqxZ0puL6mWmFVJcBkPpVxn9FtXI6rrLwBfQASOK792cB8U74RQ+6dUpWxQ8euMr9kX65Kkxc2p1l6VqWGbtEsyZdxJKe0vbIiGL8beh0WCdFg8ixoppeV8ir8Vp2eWUdgaM/4Vi/Bdx9rr7d+AE6jZtfGLQ/yUsR1WieJi8xcFrys9bpYFgEhkLSl67gDb20ynayXRyB38yj1a2+/kj681zrRHdSIQtuIpfpU8xRLD9tHCyKfieVqFgc2/vTfNspMN9MXgkb/X85I16nD30Fwm4iPHI0y/IO1inInxvTjl6apCgy4+mv/P7trAJ89X5gDaKoeaqX3ONaonyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.19; Wed, 22 May 2024 08:12:01 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 08:12:00 +0000
Date: Wed, 22 May 2024 16:11:51 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Waiman Long"
	<longman@redhat.com>, Matthew Wilcox <willy@infradead.org>, Wangkai
	<wangkai86@huawei.com>, Colin Walters <walters@verbum.org>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <laoar.shao@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
Message-ID: <202405221518.ecea2810-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515091727.22034-1-laoar.shao@gmail.com>
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6009962c-0ee3-4101-60a7-08dc7a36db20
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lS786U/R9rbRawmvygjRoGfMaDh5/81NROTku4kYqsrzCwu8cqtkrHT6/n?=
 =?iso-8859-1?Q?5Cju/xgTL4K8CNEqfxxb8FsgjoX0mPRcBYEWTQjyeCMW8R7xRzhHGcrb4o?=
 =?iso-8859-1?Q?wbqHXUNsa4VPgCfk3syNOJnnkzc61Sbcfxs3/xf6IQ4ljt3E7bKzArpSrp?=
 =?iso-8859-1?Q?klTbcvcSERn2zC5I8+16KgFB+vJGF4YW9iHp5gvt8Tv5Rj+cKTY2qJL2zh?=
 =?iso-8859-1?Q?xBC8jRXRno9EKtlZ857rND8PZASalB0kZ9fckT6sGbglWmjCFdC2m1/Chi?=
 =?iso-8859-1?Q?efXVyZSp8SockinKOB44+QtdocXJdqYPLxNbZ2QKS3gGi9CoxkUhorWnsJ?=
 =?iso-8859-1?Q?e9okQX5nZWBrE9gP9me07UCBtJaz/uxcXqZau9h0hvubseRGHIBT9dNPMK?=
 =?iso-8859-1?Q?Pp8Y0FP8RCf3/ku2xTYfDSiMdlLWgtPaRC74E1N8Z9AXIlqpoRQPj8EJ4J?=
 =?iso-8859-1?Q?6KdlgjYyjc3LrP5ZA7aM/sGOpC91JWygrYmsWoHMQ0EAPsMul1TRHNjwNA?=
 =?iso-8859-1?Q?1TG/BvTWTHOPDnaHmOWMk6cUuBml7eNFzG8amr3MyTRbKYABQa2OE5fRSx?=
 =?iso-8859-1?Q?FelS7K13hFb7IxYb4gfAS+kYgmYDvA2msc0oofEt3t3Z94MSalbQH2CJT2?=
 =?iso-8859-1?Q?teZvFTEwhzuerpTlojZTTrnHDNXSrkIOnT9OFkuXUtqliXhm8wPJ5j07AT?=
 =?iso-8859-1?Q?rhjZ3wZ+d6x6FwqjndSynE0Arcm7u2i9kGddorVzmS9FjX8aIPFj/r4bnT?=
 =?iso-8859-1?Q?Os2UQB9JWAPPNm4y8M/8MqcSgQjqcKu1FvM6VgCx2n4cI1YZFqVeNm1Sq3?=
 =?iso-8859-1?Q?hq+tu+cwoHgaSYJemay+aAr1YkFtzCfkXg/EGX9D00abKRW5V0NOSNl1BV?=
 =?iso-8859-1?Q?jkCUb+PXfmf7+tyIhYXeqGCbEFKSdEw+MmExG61iDfWAIbmIRa2C3iCEXF?=
 =?iso-8859-1?Q?iUtEKoKRiZtzA+Bf54bZBZxC9EoRu3n20q+nLNDgVLwHsesfSI59G6LpWa?=
 =?iso-8859-1?Q?KdMAzH6thAabv20kLF4VPY3nC/r7yvdT2D++rnJcmTXviysQS+HNGnO+2o?=
 =?iso-8859-1?Q?aK/b9IB2APxskGzaR8ikPg4NyIe5UjYMpyGJTNAAudrQO9j0pu8rYL3kdt?=
 =?iso-8859-1?Q?cN8Wi3du1pHzH91Or6QYCWcX90pjE6G7A39w+qRHGjgw2iHldbunBCFcQE?=
 =?iso-8859-1?Q?pq8ghzee5mCM7pdpysBUXBa45M4W1IHCyCqvPglA2N7KLHzRz0essDd76d?=
 =?iso-8859-1?Q?7jOL61Sw2iVyZfBgBjQPgjjo3oHNBzpGtJQ3J2zdA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9xVmzwjnuADpu/zbd/hfylfbcooqCYjijVCpwm6RtVfcfwU0SEbZKQySjW?=
 =?iso-8859-1?Q?iEG3FR8f1BRrwtGE9iqxdx+3497SdzeuLjiUVl4QShRAuuzwXsTccKxCMO?=
 =?iso-8859-1?Q?VXzqzCJA3a7OllKPbKaYkXqS+nbInserwdWsuF9vXXmtxmFpKyDHXDzgvt?=
 =?iso-8859-1?Q?oohlzV0wiOKE9npZnVziBvK8f46RIWO64D7JOYTq0bkiUiM3nr+7Q9j65J?=
 =?iso-8859-1?Q?V/FW3LjrasOGDFAhlbgR3R3GKNpYP1xL+m/tU2VY2X//DqU8BzCKSlnSIB?=
 =?iso-8859-1?Q?tz472PIut9t1Ir5HUJp3mEKryhSWDrypUhh4ZQOCYZEcBpXvXE/ZBl9agA?=
 =?iso-8859-1?Q?8C/Ncpnj6GDuNM9O27ilnYN+BoOAyC5FUDCbDupDrW2oXHQu5syVE6jwoS?=
 =?iso-8859-1?Q?pQn2D+pGYXZ7AlHk4zUY2y6mboFUT82I2+7RwXWxE/NeQqraEbJhQmSZeC?=
 =?iso-8859-1?Q?wEThH25AHmMNSIT/5/kERBJfnTA8bT/DogCHDGfNy0sacjXmTTH8/DccKB?=
 =?iso-8859-1?Q?jrS/Ut9gxQvWZgu2FZUMk30Rczoik3e5H0Kv+H2NLprxq74SaorsBx0vNF?=
 =?iso-8859-1?Q?HZ4x8Laaw33FLMTGWPr3GCeR+oA+eqe01/q47rdlusSMkppXHaOTGUP1Jj?=
 =?iso-8859-1?Q?7t2XqNeJyiztajWKvqTZlipEGjrWIWyGxNLLSxThouK1Wx0EiutS8B7vXC?=
 =?iso-8859-1?Q?M6U5d2js1ke8t5UFZUkqyWYkYnYmbK8BNl+kexytzDATuKSygdNP1qtCLx?=
 =?iso-8859-1?Q?Ygze34BPQxwvGELDb2Ne/udlB7GkcLPu00aMIFoOQTzGRgQ4qO+w/ySa1F?=
 =?iso-8859-1?Q?lB9bDAkLFQfl3QDTIYyaBRkfeyhT1rwAlDSZEO9OTZTSvKTIN261bfN10I?=
 =?iso-8859-1?Q?GxmVK0MfAuKz7TrOUcSGpjzGBI7ALanWSRsoRor3ZHFHJRXTYL0acyO/ox?=
 =?iso-8859-1?Q?yAcKAQt+9QjLHy+hVEmPffqTjquGVyYhPpfu7mnu/DAkRWJzH1YKzcWwl/?=
 =?iso-8859-1?Q?wybpOjDP6cocKSZ493IQu9DDH2E8tkpe3tmIfWAWpSA3KpxNOso4qglCNS?=
 =?iso-8859-1?Q?lLiLEMi216EQDeL1d3Ys2IOXFNyJbVohl4PeyS8e0GgxXKRt0k1m121vi5?=
 =?iso-8859-1?Q?uLnn9zgBQoAOaMMMGbFYv3vS0lS8yTN4O8ekiMV57aGVSrh/3o71EmNSk4?=
 =?iso-8859-1?Q?CkIGQuVyaB0AqvDuXBdwcEyRJ5dVfTsh55NJV0CZEIHoyRNQDC5ngP+Aqc?=
 =?iso-8859-1?Q?osurLKHODMszX4KZoZcP4tWplKDF2xTJ+YFI5HOk392NO55jFrSrWR4EnF?=
 =?iso-8859-1?Q?DOOkAnKskU3TO2f+YAl/C8pIZ4Lt8acM8Iaiw79HI8Ejd8AQNz6DK6tgUl?=
 =?iso-8859-1?Q?WRujGFdJ8qcWBH/alrpl2KpI67xn62uZZuOc370Q1qYdzkTETOvxfIYkJT?=
 =?iso-8859-1?Q?3vmqigpJ1p1An2qn8HknUE6/luZ/GMvnqWsQYHt+OKteBC/bkjgjrFA5BT?=
 =?iso-8859-1?Q?H5sa98dNmSaQ8wgfGRUTuGHaiYDNuAAXMayEm3N/H/cW/qlU7gjkdwfRDE?=
 =?iso-8859-1?Q?YS5KlZnaspaJUQwm01k2xCCAb37EiH2kA0jDmvucDcf2OGhuVGM/aPRTQ1?=
 =?iso-8859-1?Q?cyPHsVQRKkjkvmGXTDEHjSRII0S9W1LfCiuQdG/gJhRU+DuWsHSZPVMA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6009962c-0ee3-4101-60a7-08dc7a36db20
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 08:12:00.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMQi8Y8A0FMqHVZ5n4KInYroN0Slfop2WW0IUjt464QdArqiS3hlB5ntK8y3tUPKT0HnwG8IhIB8+o5s6plNIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed a 6.7% improvement of stress-ng.touch.ops_per_sec on:


commit: 3681ce364442ce2ec7c7fbe90ad0aca651db475b ("[PATCH] vfs: Delete the associated dentry when deleting a file")
url: https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/vfs-Delete-the-associated-dentry-when-deleting-a-file/20240516-144340
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
patch link: https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail.com/
patch subject: [PATCH] vfs: Delete the associated dentry when deleting a file

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	test: touch
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240522/202405221518.ecea2810-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/touch/stress-ng/60s

commit: 
  3c999d1ae3 ("Merge tag 'wq-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq")
  3681ce3644 ("vfs: Delete the associated dentry when deleting a file")

3c999d1ae3c75991 3681ce364442ce2ec7c7fbe90ad 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 9.884e+08           -49.1%  5.027e+08 ±  4%  cpuidle..time
     23.46 ±  2%     -38.3%      14.47 ±  5%  iostat.cpu.idle
     75.71           +11.7%      84.60        iostat.cpu.system
    620100 ±  5%     -24.0%     471157 ±  6%  numa-numastat.node0.local_node
    650333 ±  3%     -22.3%     505122 ±  5%  numa-numastat.node0.numa_hit
    736690 ±  3%     -21.7%     577182 ±  4%  numa-numastat.node1.local_node
    772759 ±  3%     -21.1%     609537 ±  3%  numa-numastat.node1.numa_hit
     23.42           -38.1%      14.50 ±  5%  vmstat.cpu.id
     54.39 ±  3%     +13.4%      61.67 ±  2%  vmstat.procs.r
     75507 ±  6%     +24.6%      94113 ±  5%  vmstat.system.cs
    177863           +14.2%     203176        vmstat.system.in
     21.30 ±  2%      -9.5       11.76 ±  7%  mpstat.cpu.all.idle%
      0.37 ±  2%      +0.1        0.42 ±  2%  mpstat.cpu.all.irq%
      0.14            -0.0        0.11 ±  2%  mpstat.cpu.all.soft%
     77.37            +9.4       86.79        mpstat.cpu.all.sys%
      0.81            +0.1        0.92 ±  2%  mpstat.cpu.all.usr%
     68.24           -11.5%      60.40        stress-ng.time.elapsed_time
     68.24           -11.5%      60.40        stress-ng.time.elapsed_time.max
    175478            +5.3%     184765        stress-ng.time.involuntary_context_switches
      5038           +12.4%       5663        stress-ng.time.percent_of_cpu_this_job_got
    259551 ±  2%      +6.7%     277010        stress-ng.touch.ops_per_sec
    454143 ±  2%      -9.2%     412504 ±  2%  meminfo.Active
    445748 ±  2%      -9.3%     404154 ±  2%  meminfo.Active(anon)
   1714332 ±  2%     -92.8%     123761 ±  2%  meminfo.KReclaimable
   7111721           -23.7%    5423125        meminfo.Memused
   1714332 ±  2%     -92.8%     123761 ±  2%  meminfo.SReclaimable
    291963           -35.6%     188122        meminfo.SUnreclaim
   2006296           -84.5%     311883        meminfo.Slab
   7289014           -24.0%    5539852        meminfo.max_used_kB
    875347 ±  3%     -91.3%      75880 ± 30%  numa-meminfo.node0.KReclaimable
    875347 ±  3%     -91.3%      75880 ± 30%  numa-meminfo.node0.SReclaimable
    161663 ±  7%     -31.3%     111087 ± 12%  numa-meminfo.node0.SUnreclaim
   1037010 ±  3%     -82.0%     186968 ± 16%  numa-meminfo.node0.Slab
    838678 ±  3%     -94.3%      48016 ± 50%  numa-meminfo.node1.KReclaimable
    838678 ±  3%     -94.3%      48016 ± 50%  numa-meminfo.node1.SReclaimable
    130259 ±  8%     -40.8%      77055 ± 18%  numa-meminfo.node1.SUnreclaim
    968937 ±  3%     -87.1%     125072 ± 25%  numa-meminfo.node1.Slab
    218872 ±  3%     -91.3%      18961 ± 31%  numa-vmstat.node0.nr_slab_reclaimable
     40425 ±  7%     -31.3%      27772 ± 12%  numa-vmstat.node0.nr_slab_unreclaimable
    649973 ±  3%     -22.3%     504715 ±  5%  numa-vmstat.node0.numa_hit
    619740 ±  5%     -24.0%     470750 ±  6%  numa-vmstat.node0.numa_local
    209697 ±  3%     -94.3%      12019 ± 50%  numa-vmstat.node1.nr_slab_reclaimable
     32567 ±  8%     -40.8%      19264 ± 18%  numa-vmstat.node1.nr_slab_unreclaimable
    771696 ±  3%     -21.1%     608506 ±  3%  numa-vmstat.node1.numa_hit
    735626 ±  3%     -21.7%     576154 ±  4%  numa-vmstat.node1.numa_local
    111469 ±  2%      -9.3%     101103 ±  2%  proc-vmstat.nr_active_anon
    446.10           -36.6%     283.05        proc-vmstat.nr_dirtied
     18812            +2.5%      19287        proc-vmstat.nr_kernel_stack
    428165 ±  2%     -92.8%      30970 ±  2%  proc-vmstat.nr_slab_reclaimable
     72954           -35.5%      47032        proc-vmstat.nr_slab_unreclaimable
    111469 ±  2%      -9.3%     101103 ±  2%  proc-vmstat.nr_zone_active_anon
   1424982           -21.7%    1116423        proc-vmstat.numa_hit
   1358679           -22.7%    1050103 ±  2%  proc-vmstat.numa_local
   4261989 ±  3%     -14.9%    3625822 ±  3%  proc-vmstat.pgalloc_normal
    399826            -4.6%     381396        proc-vmstat.pgfault
   3996977 ±  3%     -15.9%    3359964 ±  3%  proc-vmstat.pgfree
     13500            -5.9%      12708        proc-vmstat.pgpgout
      0.13 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.d_lookup
      0.12 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.__d_lookup
      0.11 ±  2%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.06 ±  7%      +0.0        0.09 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.02 ±100%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.07 ±  7%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.09 ±  5%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.18 ±  3%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.10 ±  7%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.kthread
      0.10 ±  7%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
      0.10 ±  7%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.14 ±  4%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.15 ±  3%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.rcu_core
      0.18 ±  3%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.handle_softirqs
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.list_lru_del
      0.82 ±  2%      +0.1        0.89 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.01 ±238%      +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__call_rcu_common
      0.00            +0.1        0.08 ±  3%  perf-profile.children.cycles-pp.d_lru_del
      0.00            +0.2        0.17 ±  3%  perf-profile.children.cycles-pp.__dentry_kill
      0.33 ± 11%      +0.2        0.50 ±  6%  perf-profile.children.cycles-pp.dput
      0.09 ±  4%      -0.0        0.05 ± 22%  perf-profile.self.cycles-pp.__d_lookup
      0.06 ±  5%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.74 ±  2%      +0.1        0.79        perf-profile.self.cycles-pp._raw_spin_lock
      2.55 ±  4%     -40.6%       1.51 ±  5%  perf-stat.i.MPKI
 1.219e+10           +12.8%  1.376e+10        perf-stat.i.branch-instructions
      0.27 ±  2%      -0.1        0.21 ±  2%  perf-stat.i.branch-miss-rate%
  22693772           +14.3%   25941855        perf-stat.i.branch-misses
     39.43            -4.6       34.83        perf-stat.i.cache-miss-rate%
  95834044 ±  3%     +10.9%  1.063e+08 ±  4%  perf-stat.i.cache-misses
 2.658e+08 ±  2%     +14.8%  3.051e+08 ±  4%  perf-stat.i.cache-references
     77622 ±  6%     +25.5%      97395 ±  5%  perf-stat.i.context-switches
      2.82            +3.3%       2.91        perf-stat.i.cpi
 1.821e+11           +12.5%  2.049e+11        perf-stat.i.cpu-cycles
      9159 ±  3%     +22.9%      11257 ±  3%  perf-stat.i.cpu-migrations
 6.223e+10           +12.8%  7.019e+10        perf-stat.i.instructions
      0.36            -4.8%       0.34        perf-stat.i.ipc
      1.19 ±  9%     +27.6%       1.51 ±  5%  perf-stat.i.metric.K/sec
      4716            +6.3%       5011        perf-stat.i.minor-faults
      4716            +6.3%       5011        perf-stat.i.page-faults
     35.93            -1.2       34.77        perf-stat.overall.cache-miss-rate%
 1.214e+10           +11.5%  1.353e+10        perf-stat.ps.branch-instructions
  22276184           +13.3%   25240906        perf-stat.ps.branch-misses
  95133798 ±  3%      +9.8%  1.045e+08 ±  4%  perf-stat.ps.cache-misses
 2.648e+08 ±  2%     +13.5%  3.004e+08 ±  4%  perf-stat.ps.cache-references
     77612 ±  6%     +23.8%      96101 ±  5%  perf-stat.ps.context-switches
 1.813e+11           +11.1%  2.015e+11        perf-stat.ps.cpu-cycles
      9093 ±  3%     +21.5%      11047 ±  2%  perf-stat.ps.cpu-migrations
 6.192e+10           +11.5%  6.901e+10        perf-stat.ps.instructions
      4639            +5.6%       4899        perf-stat.ps.minor-faults
      4640            +5.6%       4899        perf-stat.ps.page-faults




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


