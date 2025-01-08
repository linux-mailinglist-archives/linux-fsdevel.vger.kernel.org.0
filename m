Return-Path: <linux-fsdevel+bounces-38683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6312A06849
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 23:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631B518871C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 22:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9F2046B4;
	Wed,  8 Jan 2025 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iM0zvFX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495F1A01C6;
	Wed,  8 Jan 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375445; cv=fail; b=q2xrhuqkUxZfmwZXFC40pcNoCOoR5ldmXnKMYsa3bZZzs0BydXDSty3XTArL4e9RugH5kYsI0QpiaWxKmNAMh/AdQOQMxNSJ6e4oaYAT1F0A/RBSwlX9yyISEnT/6tsQS2M14LoodvJEfmQ5Shg93dOpMOM+46GoH9aXKmM8h0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375445; c=relaxed/simple;
	bh=aHQnTe84JFR6oZp9hU+QpGxeaw/PYiqXZ2FmrWnqA6o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cLzioe6fXJgNwDAKoTtYQmHWpbzhe+73UsLMe4lVL/VP75fY8ah/ogLqkseWFNWZuIFv5TuMbnYfDywCir8jYpjkMpka7p2jlrs1cK5lxDLFApoWRFFnTBmOc7hhQLoFcfNX1GlOc9SaLt04sFrRMwYM9qy14gqo6dpax2Vcv7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iM0zvFX7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736375444; x=1767911444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aHQnTe84JFR6oZp9hU+QpGxeaw/PYiqXZ2FmrWnqA6o=;
  b=iM0zvFX7dkl3tu9WqwnQOXmaiWN1JuiGKm87Aw+IQjwvY05a0LUKoeoQ
   TL2O0hWZb+TARzT9R1lmldVDSOyWUdCaKD6AOIfDMBHDBmM3odlQCc/4d
   4yjFCSrTb587DRStbrcXr4PtlmyZcdPttlEeUdF+LuNEywgnfCcmCkm4l
   c2pgbSzK1MKCStppLrElUxDvcgnf39ikVFoxOSzNX8MELzcT4kJ/XHQ5/
   K6EKqOGzQ5SQga0/Z5QKxberMhHv2ud62bbsAjGSpSc8f7vqB6+BOo3tg
   i2ND4NMRJvoSwICYGMWKdbpV1XpnTXf9XtyZxClgCuqoWqq3Tn63qKUjg
   w==;
X-CSE-ConnectionGUID: vTJXMYvkTt2qlK5V89Mvyw==
X-CSE-MsgGUID: LQK6S2UHQvayH7vCCYQWVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40300356"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40300356"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:30:43 -0800
X-CSE-ConnectionGUID: 5X6oa+mkRIaQmI64WVqIaQ==
X-CSE-MsgGUID: Uj4C2n0ET6+Mr7aVXAIM9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107268706"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 14:30:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 14:30:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 14:30:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 14:30:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yx7YXyGCcdxcX1cblNhA1RKtw6xJlCvdCpFeqelJ2E8oVIBVEncQXrRet6GNAU4rzOdskSN0D+zn4c9RYIr+z3bXAYaNoSe3nT3HYVwcTjVWjCJaGfUB/Jm5etT7jJ9U22g3P4NIv8Qd1qBq21XK6HSx7rAIiorDKTMcPAHLe/6lGLeo0dWePAB4utN1b47dM0diTs6Oqmu/nvy+jU0X3q2LrnFr8vC87GFQFvCvEo5wS6rwlbxvxIS+xF7GF/u8fEu6dUUh17fWLO6qtpHcQQq0/MCtEsUEJ/KCH3Au3zrR1KOr2f6dEF9h7hq6OoK/THpxFFIRh+ouibqj5EsnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykbBEGif4XNRDhG36JaAk+Vmea7aHk59vZUxCFqzNI4=;
 b=vPnQHM6YQMC1jmjLoWlo3bsw8prvRawBlQNwiqrjHRacyJUz1Q03MAgk8WO+bQy0oniGXfAHGLMD1m/i/9wAA+ugrI8ZhdhNqLHnvBuMFVZ/8/lCaxcMLC1fHOOHnfvGOUI0F+HFRhOXU03yqH+GZTy3Nr/HPxEFqEydHQrJ86Cmx+tJjeQjDFmPR2JO2lFrAqj7o4/ZFG17VpTj4qRj3ms3tm5uGE8JBTds16jJDyZWpxEjeM6Judr6D9K9b0E2syRFqONjzFGUy3NHDJjxixwQ2T27WCO8zrww2PAmGLsAWAdiCq5BMLUb/UTNSdjuNiLHFk6tKVi/TU9T3HO0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 22:30:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 22:30:28 +0000
Date: Wed, 8 Jan 2025 14:30:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <lina@asahilina.net>,
	<zhang.lyra@gmail.com>, <gerald.schaefer@linux.ibm.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
	<bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<david@fromorbit.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 01/25] fuse: Fix dax truncate/punch_hole fault path
Message-ID: <677efc80b6fcd_f58f2943@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
 <f20cc2603bd33ee05ec4bc4cc7327cec61119796.1736221254.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f20cc2603bd33ee05ec4bc4cc7327cec61119796.1736221254.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:303:dc::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ff0cda-5c21-4626-b66d-08dd30340ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rrljhjsUxLjzj4KWSbEbkQLiccfve+AQymkydoNzBI0QwfqNlkKmNJw2TBO7?=
 =?us-ascii?Q?YDFBnAQxMVBsyigzG47Q5j5mwjrtt8cXlkBnqM9Eq2qJKGwVF1m1lbtCaga+?=
 =?us-ascii?Q?dtwxClhRT2xH42VG5BJ0zBCNjM0zyAk+2rxDNi0bEe1SvS0fRW1W3Rl9Rwxg?=
 =?us-ascii?Q?pDwyfd66gTv5T+bb9nj7QJ9M4ecLAYsf064aMt/MfhrlC5Xn62VQJtgL2FH1?=
 =?us-ascii?Q?N2YzsBrPH8siikCGa9eCK7D3wcvM9Q08jUsKr00fCwkGfdtPAR1I4+WDtEDt?=
 =?us-ascii?Q?p+Zd7+WGo90PQ769Z9T6xS4AXZdVnHK37a21hqXxBoXu9HTpa6VT+zt1Q/zG?=
 =?us-ascii?Q?htTx72Yt172RrMapx335QXSDRmtZ1tVZWmUk95jApBqHzkbbkMK51iczcaIK?=
 =?us-ascii?Q?hWFQ3Jvdy0vgZtLy/nE0qV3syJv0kIQTCjSwhWSWLDQdlgfGdQxKlCC5jMig?=
 =?us-ascii?Q?9/PLeizF0scssDywqYoip7WUURZC4ipD3P31/iGZvseXknsT/onKWLsKLuPn?=
 =?us-ascii?Q?q0G+AqxPiDo5uutCji8xxOuLo6SC5FZi8wi3v6pQ+nJkoZ+Kc/YlIKkx+Zd6?=
 =?us-ascii?Q?gvX1VthdrFBihE6KNBXlZqi/9dsRCWMEA5BX5Kq24BtILwrhmK6w6MLVIBe7?=
 =?us-ascii?Q?S0wNQQPwPUhhrakvnaXMPZpg0TGiat8OVbDY78cam+mFa7YTNQwKDmF3/PcE?=
 =?us-ascii?Q?wekfLc0QpBKqyS3I34ARiHF9ibRvXMc97imLpEydCkAaybHNkN4n2CwD6nL8?=
 =?us-ascii?Q?B+fqpLiLRhULXgpBooAdS6VvPJymLXwfi1dMJtmrzTbd+ejqKmW8I6fFR1La?=
 =?us-ascii?Q?OMPkVCGYNH1HuwxGl8SCS0JEZYUa8b2pQHBUhIs8/8z0Zq2pxvPdoc7uBK2k?=
 =?us-ascii?Q?wlLbwYmxFfsvFmN1cGmLZ2bgA+y+2oS0liJrGCHxvxxvE/7KSbaCs5ueyXqe?=
 =?us-ascii?Q?nzoHwBwHAMVUKwcB2teVypx9G5GGnTK8MH5qvj7HJmlcwgQ/7L0ob6ckKzw5?=
 =?us-ascii?Q?Wk+NEIGUR+wRj62XcCJUMxLEk1BxZo9T6uABDZedBMB0PxuKlCCQbNhQS+ec?=
 =?us-ascii?Q?Vm1LYxkHTUhkIr7VMnlshOgjhpoo39BS2htt0qIDp/7eslTY0ZPWbXKWOaiO?=
 =?us-ascii?Q?gyfHH4vi3sfOz36B7ko2Uyvm3EMouXEllhQHUw6WHWZ3EJtn6i9h2t37wdes?=
 =?us-ascii?Q?Yro/hSoQKuPuQa7XDbSjMfPqu+Al2db38SBkF4QHVokgiqepbSssAwM6aCTq?=
 =?us-ascii?Q?sDU1WdFzDU0j2yNjfnTTusKz/Jjskm3NSdkZRtAia8kMIr9cyqEIRGeoBT3C?=
 =?us-ascii?Q?eDxKkGlQ8SLSMVhygXXYnRJRSXehc+pW8FNKHufSS3HY3kUE+nuk13pz4WA2?=
 =?us-ascii?Q?9R69AkPVlbNfvVCj6XRVAC64ZfFT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tGta5OLXNlbNl50woCwhOcXDX2iNsQkX3YmX9Hm92VPmiZvsYfI5XuKnabg?=
 =?us-ascii?Q?vYLrs+yRzPNPNBWen7qVv82Leh8rgcT/WFMnLBnh/7lCPjkvig0rnazCuNBS?=
 =?us-ascii?Q?yZlVbYTM2tqqX05CfVosbtvuibNjXQMui8qek5HwKQVj91D14UVP9AbOakxk?=
 =?us-ascii?Q?ZAMLjlqXNFXNg4EkLSf256lDDPRRikF4ssFCNS63/m5fgMJy1yPQG7w402l5?=
 =?us-ascii?Q?5Nu7ABu2T5zclbMgc/zYDK+ixJmWv2pLcxESHcbndJLHHfWK/xiN3gEsfN22?=
 =?us-ascii?Q?xZ1Bfeby5j3likcqkiUM2pPNDxmdfWK6Dw8tgGZMrIS8/xPYkIrjPkQ9Io0t?=
 =?us-ascii?Q?AsToB9Z6P+jydyKFs9XmwbraRD1ohNX9YZwkOvb+YSnVwlZSa6m5pZWsQU5y?=
 =?us-ascii?Q?kqeEPfDHmpaHR96TvyiSXqEtNkilUUQy7Fyl1TFIgIzY9SaN7fCdhoxkjZEF?=
 =?us-ascii?Q?4TZhUe7xZle8DkfXhVoSLJscWaRmpQHCQ7AyAfxCMytdi4DDPFLuvYckoS7N?=
 =?us-ascii?Q?3bO5J57Vol7/4blZEMKT40bv1JRzSbE1SRmSjQru8IoihMudmLHc1pnKaXln?=
 =?us-ascii?Q?kXVv9vkqWahKmg7sM427VkVtIC+CRSc9WmDCWidnUo6uvmPe3Hiwsj6pYyI0?=
 =?us-ascii?Q?hg54s6fokLRhvFM0NI7QPb7zdl5Wm8YjiXInbEidK7QszmDImCbZBCEXyS6Y?=
 =?us-ascii?Q?NXnWkEZFh2hwA5AQnogl+WlezYhlCQmrr8yzxgaX9wWm0Gmk1fd108PJXMvq?=
 =?us-ascii?Q?PUXkLjGUipJzIXj3dQOmDamlwPQq58FKvuxkJWCMOZaQ1Mna1o7ARO+trugs?=
 =?us-ascii?Q?dDehAfMHMVHJjCVWXqgXjlF6kItfkUvNVDZMSYNZqCMZVd/LTzbIERXqZsgR?=
 =?us-ascii?Q?Xjl7eJ0Ds5KhQ8IabuqEah6fghYIyAQgc4PjlC0sO02MW07cR1uZtkcCjy6m?=
 =?us-ascii?Q?JQjHnXLgeJdWsxpj/xwGqqG7HGeCtTydVNXyHyNkkFoDkCTed+FJzffzWt73?=
 =?us-ascii?Q?HK4FEhAcDMLgR7c3JLciOlUyJdqJJ7NxvHF6PEHFlq+CNd8IW/kXrz09swPn?=
 =?us-ascii?Q?1gEMbDrBmChpUTnW29mhswa+uY7wmf1x+ycBNNTLt9pc8VyZnqc4QnCCB5tH?=
 =?us-ascii?Q?/XIatV9hdjUUp+Rhbu/Po68oeDqOxaVc7GaSlzG5QO4IVzWNXXsppp+D1SYo?=
 =?us-ascii?Q?KmyBKLG+63fKJ5ryw6qYnj5c3DHaZ9te7rzmV9CDky6yyVVMxxKZU9cbx8zE?=
 =?us-ascii?Q?NvlS/WzaBujQYmisuOvHuzFMqbU30MdYZCfwEUf4vHmyqarV4226zXR9z34V?=
 =?us-ascii?Q?rLNo97mqRrNq99YgLiQGX6Mnud66tUWEokJfq+rOxux6325Fh/iFPUUmEtJm?=
 =?us-ascii?Q?g5QofYaA2B69SKfsWzaJkrqpXcQZOMMosaPvxB65MI+TAqwZzzV8dgJ+CfQJ?=
 =?us-ascii?Q?JNd4yPNpVmcyzq1t3Qf9Ckv6VC0LKEm3f4ayahS6ve6wUU0gFhUcERQZ7XUr?=
 =?us-ascii?Q?YCghrU3f1y2ObkdOpmGj3h3CeSCW/kOmwqjW7XM72e9hs93ka68Zf+/OtT7I?=
 =?us-ascii?Q?OGaxK16T1M63xWdaSqx/i59sI7z3bqnG8h0N52zZILO8gfOzHvdo+xSroqvR?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ff0cda-5c21-4626-b66d-08dd30340ded
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:30:28.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXBrvEC26o3punw0zuXc9hlZo6someai3quhvrBBab3FtfppVB9ajG6Xp5k89RrIfhrm+p3eAkZOq1Mi5T1U6b3vEWmdBhCXT+PhVLdS5us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> FS DAX requires file systems to call into the DAX layout prior to
> unlinking inodes to ensure there is no ongoing DMA or other remote
> access to the direct mapped page. The fuse file system implements
> fuse_dax_break_layouts() to do this which includes a comment
> indicating that passing dmap_end == 0 leads to unmapping of the whole
> file.
> 
> However this is not true - passing dmap_end == 0 will not unmap
> anything before dmap_start, and further more
> dax_layout_busy_page_range() will not scan any of the range to see if
> there maybe ongoing DMA access to the range.

It would be useful to clarify that this is bug was found by inspection
and that there are no known end user reports of trouble but that the
failure more would look like random fs corruption. The window is hard to
hit because a block needs to be truncated, reallocated to
a file, and written to before stale DMA could corrupt it. So that may
contribute to the fact that fuse-dax users have not reported an issue
since v5.10.

> Fix this by checking for dmap_end == 0 in fuse_dax_break_layouts() and
> pass the entire file range to dax_layout_busy_page_range().

That's not what this patch does, maybe a rebase error that pushed the
@dmap_end fixup after the call to dax_layout_busy_page_range?

However, I don't think this is quite the right fix, more below...

> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
> Cc: Vivek Goyal <vgoyal@redhat.com>
> 
> ---
> 
> I am not at all familiar with the fuse file system driver so I have no
> idea if the comment is relevant or not and whether the documented
> behaviour for dmap_end == 0 is ever relied upon. However this seemed
> like the safest fix unless someone more familiar with fuse can confirm
> that dmap_end == 0 is never used.

It is used in several places and has been wrong since day one. I believe
the original commit simply misunderstood that
dax_layout_busy_page_range() semantics are analogous to
invalidate_inode_pages2_range() semantics in terms of what @start and
@end mean.

You can add:

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

...if you end up doing a resend, or I will add it on applying to
nvdimm.git if the rebase does not end up being too prickly.

-- 8< --
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index c5d1feaa239c..455c4a16080b 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -681,7 +681,6 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 			0, 0, fuse_wait_dax_page(inode));
 }
 
-/* dmap_end == 0 leads to unmapping of whole file */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
@@ -693,10 +692,6 @@ int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
 					       dmap_end);
 	} while (ret == 0 && retry);
-	if (!dmap_end) {
-		dmap_start = 0;
-		dmap_end = LLONG_MAX;
-	}
 
 	return ret;
 }
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0b2f8567ca30..bc6c8936c529 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1936,7 +1936,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err) {
 			filemap_invalidate_unlock(mapping);
 			return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 082ee374f694..cef7a8f75821 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -253,7 +253,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 
 	if (dax_truncate) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out_inode_unlock;
 	}
@@ -2890,7 +2890,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	inode_lock(inode);
 	if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out;
 	}

