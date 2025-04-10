Return-Path: <linux-fsdevel+bounces-46229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897FAA84DFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 22:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C0A9A2438
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D039E28EA78;
	Thu, 10 Apr 2025 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcV1HLNa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305AC1E503D;
	Thu, 10 Apr 2025 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316145; cv=fail; b=K0BI6SAWfNBU/mYciuijsDHlzyMqCE3aso9B9EXbGFZ3iJDM+Zxj8kr0FdJ6ePsVvU/bYkHXx9fUkOd7TJxthrXB3GPv3yQFI2bdwgBkrFT8eNGFyC2EQ0HLrj448PU7DgWQ+8HKHoSWb3Az87r1fbuoKLrMXRSheGmJDKRPjKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316145; c=relaxed/simple;
	bh=dt/sRvtDmDkI9JfCBCvTWqpgITFMyb4Yoj72Q94txzE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ePEoePpF7D0WqtlIxqAMVBZNOmFh+MplPT6E5u0lOP7fg0vtYhIXpV+MHNPeTFOCmsb8te+tzQh+3EeeHqq7NvTlfIzzg/3ucDqET39j1b8pSQG6TElYdYc9PW7ubadFD2UXZBYXzfCiI/+5M4yyeA/MqssSSNtvqLHARRtzC6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcV1HLNa; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744316143; x=1775852143;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dt/sRvtDmDkI9JfCBCvTWqpgITFMyb4Yoj72Q94txzE=;
  b=lcV1HLNagSbFWL/4/4wBR0FCkhCYUzwTsI+mxO9kyC1vxFUA3ABpzFOS
   HJw+zaVHUK2EW8sPB8q5K1Q/whI26+ZSfmYLXV+U1TiJpIcBW0LRuVhwj
   zjzXu4R7Ye1uxwIKtkpO0z1ugkQEffXJNAUsDcayCSj6Sb2stJfToJeb8
   FnA0TFNf7C9eEvZ2hRkyvgnncylhI/F9xx3cnR0loy6m519URcudu3bNn
   AhIj07x00xz+MSLut88zzh6QYr1bAYfMH5mFnTtpnjJGmHZNCx+YMBiqg
   a6+j4CEx/pKc/NhmKa0A91oqbMPDiMYVSD+5AvmoAEHyaWXryOgJPOXAG
   g==;
X-CSE-ConnectionGUID: 6P+1bSCORpKs+c5NTC2MZQ==
X-CSE-MsgGUID: l9QDfhRgTOKtpniOW2RiMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="71245656"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="71245656"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 13:15:42 -0700
X-CSE-ConnectionGUID: ojnrPtPKRMub2bigS4mddw==
X-CSE-MsgGUID: OIJ717ljSxahibtHp9QV0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129548061"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 13:15:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 13:15:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 13:15:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 13:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1f+7YYGJ4iEPziFujhH5Smld7wmDohSydz121BwKFRyqkexO6UK1M3Wb66MMJrZ75EFAMoMvekbzKv1xhp5A2spQyLQ/qr7PHLsYN7Aj8ZS1dO8NnMLdmvhSYXtHLbT4yd5SEbMwqnV56dOEtKVXUwWE6Ejf5jgy2vTTfsah9X/3rifAZ6PdrdJT1f/sQ4Ph8IjLZCFjbxN2xiaEtKlPkQcYTELZZrLY5nrTWmuRbq1Xght3F48IVGdGY4x3PJ/5iT9viFbrYP/zfHbb2Oqn2I/YGFRB25qK0ad8ntvBADTLZ2s1GfGptkiV/4LKLiwdvbLLLgP+XgaPGEcN5DdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsgGlvm8UFIgQJPz6tOd5Fw+RqGpvi10UkBiK3NdJ2I=;
 b=zT/NhSqbGQUgxdtYNKpyZ7dFg84LjxSH5XUpwwuZXTctabnweKXxMdzuhq0Wogs0Od9hu4ND2AqEEHyVpngqfERojZ+ZMDTjGB2LOG3/oZfUSU6UEintwtAMz2Rz5lsaULcPau6X7bLS7wtMwz4GgjMRmwj+tb9Hu29sUlBqx5WjtWmJzdabTxyRBKUpsEkSKvDdG9PpO0BKWo+6grAAgKlLqJzaJcIIQ6z40C0Bmj6B45baRxU8jIXf9ksJB9KtAMLQq5u5RkFNXAjsIL1ZR1oVjHEZ/Rs0pzt/cGzRWfLQ/7OmVEEyqnkYCRbmOfMiQFl0flAE9Y6kvj5OnGd+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 20:15:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 20:15:10 +0000
Date: Thu, 10 Apr 2025 13:15:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, David Hildenbrand <david@redhat.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Alistair
 Popple" <apopple@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] fs/dax: fix folio splitting issue by resetting old
 folio order + _nr_pages
Message-ID: <67f826cbd874f_72052944e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250410091020.119116-1-david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250410091020.119116-1-david@redhat.com>
X-ClientProxiedBy: MW4PR04CA0353.namprd04.prod.outlook.com
 (2603:10b6:303:8a::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 7856e86a-17c4-43c6-c69f-08dd786c651b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+GanyhC79R2eo7uTpvx0lj7+uNXtRAN6pxXsRNYUKU0JaRGoWO9X2RqOQsYz?=
 =?us-ascii?Q?8LX8ebxwBXkdriCoTBe8nGm6x1QuXu47JkUNUaKkjTOX2o79FJ7CKy03YMwR?=
 =?us-ascii?Q?LV2kuvgJthyZgvSBMc5tnNd8DNtiVIzWgPRBqXcZbImLKVtQOe3JNX18I6VM?=
 =?us-ascii?Q?t95vtZbNQR779mTczkMX4Gtfi3oMqCLx3+ZJfMUsbltMqD9Vyh+5fMhwOkLJ?=
 =?us-ascii?Q?0tqvoy9X37Jw+H/f0mtHaO7qbbA52cJI+1zJrngRe5N73P7btYAiVu/JYpcL?=
 =?us-ascii?Q?euB/AoI2tVQswjbEZ3xnqu2yGUV1SMOYooFSw46P/J9CC5vjGuRjSBZb0pLy?=
 =?us-ascii?Q?R0sSO2jYWPQhxHsrDLzhknMGYqSays64XochKgkFWWmnNBvDqaYP+AGVDtNe?=
 =?us-ascii?Q?0mJzRqDv3Be5Q5J4Rw+7Z4bXHIg7DBLSmVLsi645gYqHsM8uBsOqMdd+lbA0?=
 =?us-ascii?Q?SW91WKec87suHxLJfDIctPwZ2r/1VzMsAOis7Adi2Qq+fSYHREZ2rjgRZgP8?=
 =?us-ascii?Q?ICUf3LBNyAOJMs55QjfgJ0/dLbV+9XRHhD/QRPYh8sV5Xe6qmnFAspkNdWNM?=
 =?us-ascii?Q?MaYvfKdjzPm0130UH5WO/XuYHH//g1QMyO3dZ/FPgHieaq8BiXt6F1eCQfgV?=
 =?us-ascii?Q?Fx6X5PiSiHNCyQrBV9r0Arv1cwT3lj7PNugtf5cTb4vx6GVg2k8QfCsDf/Gr?=
 =?us-ascii?Q?eQo2HroiJNZae5bkNu0tmbzo6gjcnrnQbdJEGeVRRprgCObivJZclAwuOAmg?=
 =?us-ascii?Q?AWJhaIs1/O2uzLNr6N2fO6c5dLExy3AXZpstLTZY7H7ghG02OK59i1vlyU4k?=
 =?us-ascii?Q?cXE2xJibq+1FzTuAtdOdBstS3gPeziYgon3C2WQVTxahYn090b4l3Uz9ffW5?=
 =?us-ascii?Q?PMoslrPvhvZbrnPLMDBBgDbAFaozDp/d+lf7WLZNFkTO4l5pWrujlnA7pArW?=
 =?us-ascii?Q?b6gkhai4GYcVworbU+3xCpMg9eUVtSmJRLeQmtBj5/DO3FzikZU8Hsu6qFPo?=
 =?us-ascii?Q?6puBjYesd7kg+s0X++x9s5I1vs+Na9nkbHExbtUmRWRgqAcOX8wsWWfEv5oq?=
 =?us-ascii?Q?ssb/DDbhDw7NV8rPHzo3pCTbBTzlB+LvfnEwCPW+mvNVuor90Cd7GQRG0jEP?=
 =?us-ascii?Q?QKj056/ngoB2DHnP98pA5xffPSmwQqsY6HN/v0y4hOep9W643FG6sg75CLTD?=
 =?us-ascii?Q?iCZb8XoCZcUAZTT7OPdfeLeboPJA9XUsnrrb/7Pcfss/vTSCOpY1JvJegdSB?=
 =?us-ascii?Q?HT1yB4601WbXAklLUGoseSZGm+NFMizN/EQnvaUmbwupmYOn9L3XotCjkFCE?=
 =?us-ascii?Q?O5RVh1WIDQxn61OE5Vhkr4prAqglQl7tfzXSFJFffk/7xnKdceMBd2PwKxqM?=
 =?us-ascii?Q?1IUSkVpuItKdXdtwSQRz/SgrWkUt0qsx+X17rS7XcnM1sGeFG7iE32TxfiHr?=
 =?us-ascii?Q?lHvOKeWsT+A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W09nguFTmapVycsVExQX2q8Va++MShmtwRTaprZfnMOzLprjufZCPnWL0poS?=
 =?us-ascii?Q?ubxa2vxmwHJ4/9+TFi0J0S9+ZoJqfEfy7u+TNz0S8blWox5nADKQErvCTtw3?=
 =?us-ascii?Q?RxjP5q+7INDYBQqlZRqjApf9ssl56XeGva9z/Lnm7o2l71qReitzZZ8PNu6C?=
 =?us-ascii?Q?ZjQcyCkzyr2Lbn0LbeRcn7w/lfqwdTJK2FQjf1W2SjBo4WtNDKoapt8jDvHI?=
 =?us-ascii?Q?gS7VyloKCRccRxCNWykKKdRDyrsU9vUNrR89P3DFuhcTGPmuTfbQi64m63+X?=
 =?us-ascii?Q?dkZobYck1ZtFnMu0RUnbSoRIK3cjVeJRMTdgCzgrulhGFhWc5tpIIQPaktMd?=
 =?us-ascii?Q?vwgG/BEBZWhxQfCvKuAv7NaU/xYTULwAI/gzL90qj1is001vGbSYHPEkci9a?=
 =?us-ascii?Q?9kzMRGiXQYd3QlQ5NZLL2PFMWRs5/Xp3HsFoigAjBnvwvOChBz3agyfvxUvJ?=
 =?us-ascii?Q?c4sPP3XKcWJxcP7CZI+NKVU6eTzWvhCj/ah1gNtVX8Uxxx8jD5pJqf6Qka6J?=
 =?us-ascii?Q?yo18ySV19hRguX7h98ZOtsPKGQORXAnDhwrMzx4BNVMypxOy6Ww6JrCZSqyw?=
 =?us-ascii?Q?h0edXbr61CcVsl4xhLwIrTMPfxZqGFWY0tu9dDSVSSrm/8vz0ZoV9NA/anKx?=
 =?us-ascii?Q?OX4dRJRJv8GN6wYiLh9jddvdUnOW3meHk8c0AsfD7QKjnwFaogAbnipvAznk?=
 =?us-ascii?Q?WnCTAP1+755TV7yElzyziFxFnKkCOHrBwjb04QkPi48hcZ8S/03RkVIolJhu?=
 =?us-ascii?Q?RqTrVIcc+iHxOc0wUs4Uy+KMFJxiTL7b+HaJSWGHVY5UpSzwOn9LfwTcH7Ek?=
 =?us-ascii?Q?ZivHT0cFHpQzz/AiL+9yi6cLxgdrwJK4Wyl3qbd3121oPYahu8W3jlGYWxh5?=
 =?us-ascii?Q?5BSW1EMDIW0bIQSkTsDhYO5x0chfOSDOTsSheIjwQYoxWmVo+zIXwW6ITfvl?=
 =?us-ascii?Q?RfMPOGQLhY4b8InoH/0dPWheZ/y2IVMR2lOb4h5Xv7dUpm2WcoYeUtbcP+2w?=
 =?us-ascii?Q?wI9lMfzoM/yna3wSSarrMM8MvCUTZlAzqblNacUPCBa6sKh5ygvmHGb7kXPF?=
 =?us-ascii?Q?W5BQzFqBZ+smugX05YwWwsokd68ARZCBUpOmvLKBnaDf83C222AJW2MaPcpG?=
 =?us-ascii?Q?QE+D5+Dcj4QDSa9+Xud1p5kvsw/+pXkYOnJIeizLf8IbC3OqZenGxE4rxfSP?=
 =?us-ascii?Q?2ObHWLTtlXhsdMq5ZsBSZEyuuiKvGk/ojJ9g3Oey3H47BmAvZkWUYpYOL0pW?=
 =?us-ascii?Q?FFRqUyH/lsMSJ1eJ1HLEf9wMGMHN4JIgeNutE+XAaH4d4vyKIDkqKb77NXKi?=
 =?us-ascii?Q?2rJEVT+x5kLgeu4tQNO/QvmSfSf8hNzGLd5aUXuhlhReaz+7OVMael8rnA/o?=
 =?us-ascii?Q?at7U5Yyl4Rs5CwLBWUga1fHYSJDFrDax+Tuw+iyzWWLh7XGUJzM6TBbuS5La?=
 =?us-ascii?Q?pMzz4nlF41bD8muhFc0RuvQitR2pkc/hxwkLJzACjUW63G17DLwYp7s1CUH5?=
 =?us-ascii?Q?XZclHGLRDP+hL4/CFixjGmYk+T482ay3OyZihyHXwSmV3JRMXSwmu5hJ+AyX?=
 =?us-ascii?Q?G2xhSbwIpNze2c+936IbLOzI2hXXmQivxj8twFFWorm2fqXRbGp9nDBtYD6v?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7856e86a-17c4-43c6-c69f-08dd786c651b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 20:15:10.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvLK5b9LUwjKe59uyNfyET/vxuUP0yEsj5v7pd7BmKpmVjYpEd0tgrNO3iEArQturVdCrWRytdry0QD+eNSrCtCFIFQrvJFe3q0uerzGSzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com

David Hildenbrand wrote:
> Alison reports an issue with fsdax when large extends end up using
> large ZONE_DEVICE folios:
> 
> [  417.796271] BUG: kernel NULL pointer dereference, address: 0000000000000b00
> [  417.796982] #PF: supervisor read access in kernel mode
> [  417.797540] #PF: error_code(0x0000) - not-present page
> [  417.798123] PGD 2a5c5067 P4D 2a5c5067 PUD 2a5c6067 PMD 0
> [  417.798690] Oops: Oops: 0000 [#1] SMP NOPTI
> [  417.799178] CPU: 5 UID: 0 PID: 1515 Comm: mmap Tainted: ...
> [  417.800150] Tainted: [O]=OOT_MODULE
> [  417.800583] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [  417.801358] RIP: 0010:__lruvec_stat_mod_folio+0x7e/0x250
> [  417.801948] Code: ...
> [  417.803662] RSP: 0000:ffffc90002be3a08 EFLAGS: 00010206
> [  417.804234] RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000002
> [  417.804984] RDX: ffffffff815652d7 RSI: 0000000000000000 RDI: ffffffff82a2beae
> [  417.805689] RBP: ffffc90002be3a28 R08: 0000000000000000 R09: 0000000000000000
> [  417.806384] R10: ffffea0007000040 R11: ffff888376ffe000 R12: 0000000000000001
> [  417.807099] R13: 0000000000000012 R14: ffff88807fe4ab40 R15: ffff888029210580
> [  417.807801] FS:  00007f339fa7a740(0000) GS:ffff8881fa9b9000(0000) knlGS:0000000000000000
> [  417.808570] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  417.809193] CR2: 0000000000000b00 CR3: 000000002a4f0004 CR4: 0000000000370ef0
> [  417.809925] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  417.810622] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  417.811353] Call Trace:
> [  417.811709]  <TASK>
> [  417.812038]  folio_add_file_rmap_ptes+0x143/0x230
> [  417.812566]  insert_page_into_pte_locked+0x1ee/0x3c0
> [  417.813132]  insert_page+0x78/0xf0
> [  417.813558]  vmf_insert_page_mkwrite+0x55/0xa0
> [  417.814088]  dax_fault_iter+0x484/0x7b0
> [  417.814542]  dax_iomap_pte_fault+0x1ca/0x620
> [  417.815055]  dax_iomap_fault+0x39/0x40
> [  417.815499]  __xfs_write_fault+0x139/0x380
> [  417.815995]  ? __handle_mm_fault+0x5e5/0x1a60
> [  417.816483]  xfs_write_fault+0x41/0x50
> [  417.816966]  xfs_filemap_fault+0x3b/0xe0
> [  417.817424]  __do_fault+0x31/0x180
> [  417.817859]  __handle_mm_fault+0xee1/0x1a60
> [  417.818325]  ? debug_smp_processor_id+0x17/0x20
> [  417.818844]  handle_mm_fault+0xe1/0x2b0
> [...]
> 
> The issue is that when we split a large ZONE_DEVICE folio to order-0
> ones, we don't reset the order/_nr_pages. As folio->_nr_pages overlays
> page[1]->memcg_data, once page[1] is a folio, it suddenly looks like it
> has folio->memcg_data set. And we never manually initialize
> folio->memcg_data in fsdax code, because we never expect it to be set at
> all.
> 
> When __lruvec_stat_mod_folio() then stumbles over such a folio, it tries to
> use folio->memcg_data (because it's non-NULL) but it does not actually
> point at a memcg, resulting in the problem.
> 
> Alison also observed that these folios sometimes have "locked"
> set, which is rather concerning (folios locked from the beginning ...).
> The reason is that the order for large folios is stored in page[1]->flags,
> which become the folio->flags of a new small folio.
> 
> Let's fix it by adding a folio helper to clear order/_nr_pages for
> splitting purposes.
> 
> Maybe we should reinitialize other large folio flags / folio members as
> well when splitting, because they might similarly cause harm once
> page[1] becomes a folio? At least other flags in PAGE_FLAGS_SECOND should
> not be set for fsdax, so at least page[1]->flags might be as expected with
> this fix.
> 
> From a quick glimpse, initializing ->mapping, ->pgmap and ->share should
> re-initialize most things from a previous page[1] used by large folios
> that fsdax cares about. For example folio->private might not get
> reinitialized, but maybe that's not relevant -- no traces of it's use in
> fsdax code. Needs a closer look.
> 
> Another thing that should be considered in the future is performing similar
> checks as we perform in free_tail_page_prepare() -- checking pincount etc.
> -- when freeing a large fsdax folio.
> 
> Fixes: 4996fc547f5b ("mm: let _folio_nr_pages overlay memcg_data in first tail page")
> Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Closes: https://lkml.kernel.org/r/Z_W9Oeg-D9FhImf3@aschofie-mobl2.lan
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/dax.c           |  1 +
>  include/linux/mm.h | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)

Explanation excellent, folio_reset_order() looks correct to me and the
callsite in fsdax looks correct.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

For consistency and clarity what about this incremental change, to make
the __split_folio_to_order() path reuse folio_reset_order(), and use
typical bitfield helpers for manipulating _flags_1?


diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf55206935c4..5b614d31f4f6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/cacheinfo.h>
 #include <linux/rcuwait.h>
+#include <linux/bitfield.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -1171,7 +1172,7 @@ extern void prep_compound_page(struct page *page, unsigned int order);
 
 static inline unsigned int folio_large_order(const struct folio *folio)
 {
-	return folio->_flags_1 & 0xff;
+	return FIELD_GET(FOLIO_ORDER_MASK, folio->_flags_1);
 }
 
 #ifdef NR_PAGES_IN_LARGE_FOLIO
@@ -1229,7 +1230,8 @@ static inline void folio_reset_order(struct folio *folio)
 {
 	if (WARN_ON_ONCE(!folio_test_large(folio)))
 		return;
-	folio->_flags_1 &= ~0xffUL;
+	ClearPageCompound(&folio->page);
+	folio->_flags_1 &= ~FOLIO_ORDER_MASK;
 #ifdef NR_PAGES_IN_LARGE_FOLIO
 	folio->_nr_pages = 0;
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 56d07edd01f9..3dc2d98fde24 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -483,6 +483,8 @@ struct folio {
 	};
 };
 
+#define FOLIO_ORDER_MASK GENMASK(7, 0)
+
 #define FOLIO_MATCH(pg, fl)						\
 	static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
 FOLIO_MATCH(flags, flags);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a47682d1ab7..301ca9459122 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3404,7 +3404,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 	if (new_order)
 		folio_set_order(folio, new_order);
 	else
-		ClearPageCompound(&folio->page);
+		folio_reset_order(folio);
 }
 
 /*
diff --git a/mm/internal.h b/mm/internal.h
index 50c2f590b2d0..41a4d2b66405 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -727,7 +727,8 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
 		return;
 
-	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
+	folio->_flags_1 &= ~FOLIO_ORDER_MASK;
+	folio->_flags_1 |= FIELD_PREP(FOLIO_ORDER_MASK, order);
 #ifdef NR_PAGES_IN_LARGE_FOLIO
 	folio->_nr_pages = 1U << order;
 #endif

