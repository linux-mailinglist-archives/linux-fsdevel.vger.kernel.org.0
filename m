Return-Path: <linux-fsdevel+bounces-18797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F09298BC643
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45E5B20BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D042073;
	Mon,  6 May 2024 03:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmOtrrJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A81C3D
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714966852; cv=fail; b=BngFrpWa6HmwFh8MYUOJMD1iaj+Znc1t1IQ20KsQdrhLkcDLKA2E92v/2eBrtQ8uPXL9fSfPQrZT+JBRCKDp8OoL68F4P7Y2LfqrZM9s+sgryLLaUyIISaCwQG9pAQ1dIcVW+R7vqSI9LcgMTsUrs21PvP4Y9vVYbtzoMODxBh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714966852; c=relaxed/simple;
	bh=0R66LESrMEcwtBO3/5k0UVmw6Kef7uW1cht0shUkz24=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rwjQycd0O1ktTgbRWKUXwB5HzKLeS5/MVDqbuefdNVf1DlEiabV08J4/OInYLPv6edIB4ISJ/HuooeD7MuBUoGv0iGTX06bT2FxpLrtWdziuaL3WzUrVXLkEjs5tlHp107lQRTGpjAf9GcN4thu9DNEnzYx7TVk5cc8wS9ICstQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmOtrrJg; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714966851; x=1746502851;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0R66LESrMEcwtBO3/5k0UVmw6Kef7uW1cht0shUkz24=;
  b=hmOtrrJgwg3Lad33IpRM6Nwlzd7QRfvtdf+un/wNcA58qVzg6KUFbCbC
   8j9CBxJoB+szZABl25rub/V4LvfICfXyDQEaSvrLYnLPN/bQiJnUn0x4b
   ljzJwfn+Opiyhtl8G12p0E3tJiA6JScm10f8iDlqvyVS8hQEnYD/cQOvs
   onov+5ko0CFOSUDcoRCXR7Fv59K4d5GXM1QYLaI86Kgt+nGdWeOiyRkYv
   QoyF793ZLfk2ubfCdJ9OfNuhIuPKS8+OpCCLEFImWTBXRMu0lseUCN2fr
   ZdQ2IsA/keXTMPzLCgsqHYFE+/yhl9sBwjBYHKDYVJEVr/I2rwGf8+3n5
   A==;
X-CSE-ConnectionGUID: EwHdGlQ8SdWFTBP9xYomwg==
X-CSE-MsgGUID: 5xnigEDfSCWxi9KWSh3Ngw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14482168"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="14482168"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 20:40:47 -0700
X-CSE-ConnectionGUID: 4UQ+5ZzySQqZlufprgEtjA==
X-CSE-MsgGUID: V41RRFW8Qea6Qz5bO0RQQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32840503"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 May 2024 20:40:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 20:40:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 20:40:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 20:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJa3oicHNjmrZNlwYl0KZzIZK69k22JDq4/NMbC6QmtEEsA4Wlpjg2AGGNMnF2MRehr5RT1B4/l45ILLwTJPHdUFq4gfZeCErM3RHsnLMTorJBY3OqpYLxOscX7XDEO83ljgwmuh1nVJ5pseHdtIc8Op6nx3q1lOk6tgV6SIBkqcQsMVTfdAVWF/Peh+4gf0XQKA5hEACRYKT+pUNuwwUE73naHJAEVNIWUMjVxvVMyJULMOBKKSPof3DTBmpaC5+7BZ2UB0pbgHaeNz1nnPs3wYzvh7ibWJ4OPoZu6/wKHKnwfvEi4yLRcJMI26V4YrLGgeiMubWnRP4Jni4YC5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJkaUhmaPQ9Nhh1sp8QpyzHnsDC1fyfN3EtyW55jGjc=;
 b=Gk/T8Q3PFsltb6zWDtwrviv8fgrlnrbCqqPfK0OuQFEtRD6KVLDHdZ8hJPP/7Melf/0wbBxV+gjx23hUiKh5amMM607f8zQ3ZF52r6N2BGKX2IvDZwqoLiuukrqOyQRs2PEnxfQLbrZqQMFM5wDKBucUVw/5oMrB2O3ARGGNC6IbvWL97ehPM/pdtV1KBBdj0yCt9ps+VCm2dGewPY4uRa1b78acXNihdv65u73vQ32BgHsqLFsDjScdKv/Qr+BhFFqabXAmg/2AWaajczOqIYPc0OErKBOgQ02aXAerr/BNL3Q3zAV1YbLl5wtOFiPeYo413g9CeZBi6kEhtjGLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6548.namprd11.prod.outlook.com (2603:10b6:510:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 03:40:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 03:40:34 +0000
Date: Sun, 5 May 2024 20:40:31 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Julia Lawall <julia.lawall@inria.fr>, Matthew Wilcox <willy@infradead.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>, Julia Lawall
	<julia.lawall@inria.fr>, "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Ira Weiny <ira.weiny@intel.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
	Andrew Morton <akpm@linux-foundation.org>, Bart Van Assche
	<bvanassche@acm.org>, Kees Cook <keescook@chromium.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: kmap + memmove
Message-ID: <6638512f36503_25842129471@iweiny-mobl.notmuch>
References: <Zjd61vTCQoDN9tUJ@casper.infradead.org>
 <alpine.DEB.2.22.394.2405051500030.3397@hadrien>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2405051500030.3397@hadrien>
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: db6c4065-4552-4acf-1e76-08dc6d7e4926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AW/oOeZNvd9wF3DV4yQVaDlkxGNvQY60KqAULqXVJjHZi04MvxdZyJvcQ+pW?=
 =?us-ascii?Q?eRTLGt49VDyAo1ILzOxPZBstSWezlxFIZomjMBG3HENTltU0zv650Kjeg96r?=
 =?us-ascii?Q?Wv1HsXhojRti5x1JayACEUDL1uCWal8LUamKBj5gkSsqqWZtihcJnlYD2PtX?=
 =?us-ascii?Q?Jeguf6dP3BF+Ntn9qWHW+TB6RBINPHQKVERUIksxYsOaw4yjAfvRC0HE0g9/?=
 =?us-ascii?Q?wCNCFbZWqHOP6HPW2WS9JlmWUC3sRb7HkWBau5N3J9qHwIwu/Tq+NZgKz7kU?=
 =?us-ascii?Q?ZMUpZxuEhUvrHABD6txbyTKZG8Xq1+XHdxtrZldPHLc4GGaICszeo+g6oOT2?=
 =?us-ascii?Q?iuXnPwwg15LV6b/YWveQFgeVrhcQ0F5KslzbrpAsin/Ycdf4hmvr4ervmi1f?=
 =?us-ascii?Q?Z5S4trUTW8o/APukJXJL7LLMh2BO2iQaR5ZmYRT5KaKlzvmZcH5R2WxAiKK0?=
 =?us-ascii?Q?sdDFWSf9z8/EMjh7/MKAIymeM8f2W6wl9aaJGtIbiglubhA2LHlrxXIymnk4?=
 =?us-ascii?Q?V/feOAsW/hmraA8kTDvFt+Gg9drH9D4plUm4qzA8Peg3gC/5EgOxM+24Yeo8?=
 =?us-ascii?Q?8eseKaSEKu18LK1EoARzPzjPoWcOMHtPwfv/9CXVFcFp6zXaXPxuVf5wQaN5?=
 =?us-ascii?Q?80MuggARGPfbyqVsj29QCJUEpoyardeScYGuxLnVPGvu7MhfyCZeriviDLFT?=
 =?us-ascii?Q?EnCclciWrrg3Jbtq/6S2Fcq3dyZ/6gZ4nB+OHIWMERkjTAT9LixCry9rtHJN?=
 =?us-ascii?Q?D4ShqR8YyrEvZZhfDZ9Tt6d2BEomiD6gBaNUG5Xqe2d0iDN+keftRbnpY+Hs?=
 =?us-ascii?Q?FiwgNHg2hvkQSrZAgDlx69ljYr/KcnddFIJ+XNVBVbwxKy5TRQY4stEjK3CV?=
 =?us-ascii?Q?YCSUgyi4JPCilRrCoFjFewvkNVLz1CQr5CnvrGuBT8rhPEzj+RiGuA/Y30AQ?=
 =?us-ascii?Q?Ovfe7Wa40LMUVWtb/pN2vepjBT/07AExqAaTCHGBx2NO2l4zn6Sjr3Do2Ivp?=
 =?us-ascii?Q?vvIkz344rc2cRagdG4mZp5aTPgCk18qAEbED/cWW2BLxZelpZeV9CnxAN1k8?=
 =?us-ascii?Q?VLHBWJlmpzdC9KRTeAFMPSkTdvfpp9tY6nwJPjXAy/bDgipU7PzGgAVby0nS?=
 =?us-ascii?Q?18AX0PI9hTNExY2xYolFwSoyNFmoyZcamPJA98mN2zvmQ07/2bkQgxav1KNO?=
 =?us-ascii?Q?IJdyDm2hjgbqc7qblzd2muo0QBNVWEPJ4hDaMdU31GUUD4CmnDc5/1BCLjn7?=
 =?us-ascii?Q?be60QLSlkr50TIrwqyeyYqdn/PUam/KbG/+oZyPOuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/n/bPTqcG7xKKCMYbpLbVpGZf3HDZRMuErJ1VHeuGdhIVm2l70QBOHSn7oRG?=
 =?us-ascii?Q?TLfNm5WpSO9rdpLTNiYTpl8InH6zDr5upWmv8sSk119VzMiA+icq3wxWCB+J?=
 =?us-ascii?Q?ujBs16rHoFmJDaROyfA4b7KizZhMzS30pq9Gh8WB5oNfGj9DuYjxXkuV8XJQ?=
 =?us-ascii?Q?0idhdj0Ljx103JC9YnAP2FfOt/3mTwnSNnMz+8sKW7sCeK2F88ERJ1AgYwmF?=
 =?us-ascii?Q?Wfi5JivExiiNvf5AUSF6kAtV6sgxZYKmFDX28ie9v1oPQx/3xmHxXY1T0dfU?=
 =?us-ascii?Q?TDybpcVv/WQGq4GUC2s9QyeKiJUl6mAThO78MkezviZUwapK++OTnbniz3lL?=
 =?us-ascii?Q?IF6k2GeCbjPxN4PHSIF1YgX7XTYdcpuy8R3nenszr/fZZwgwEDLCw7piFVvf?=
 =?us-ascii?Q?dpvy7/iLZLz4knAEVe6q5btWPnNf40PwV769CCHazL8iaX9gq4Z/dr8jGWck?=
 =?us-ascii?Q?nZaUh8btHMwAWNvB2UsdywndE19IiA1Ja9NFqRJKRlBvO3xNLrFDZHtAyb3y?=
 =?us-ascii?Q?mNXLKUwWG5Rz22ZHGeEqbnMFuzNfPpABRVW3JF9d1SXXMPwCjy6YoSXb3OuD?=
 =?us-ascii?Q?snuHY3vOdJr9zlibshpFm8VW/KMyCoW0mQ1ZE4xLORu9pkljVqZ0AeBFUIk8?=
 =?us-ascii?Q?AoGdVzplqo+eQvmILKqPvar/qRJBOfarT8z9cIbkpMEdHCLokM+Y9vVMzS5g?=
 =?us-ascii?Q?UeOEjCkwQ80dFzOuJBLtuuTLIhLaHn9zcS3MNAEcM1jhl0kQJkASec5LDM7V?=
 =?us-ascii?Q?a+G5QvNl0t2h0DX3dXAMvhBTbhYnPm+MTxGKtpN0S2m3CYQXkW134nwNK0gO?=
 =?us-ascii?Q?mcevTGEwYK0rGy0BMuhqfQSP9ohe+6vp+ueIE67oEPO0gxTFhM929RRd1HmJ?=
 =?us-ascii?Q?9wipwHc34Qlfk6biBHVWY55vWNYeKqZQUqL7gWbkNxn4WyAsrC7l3Sisxgu1?=
 =?us-ascii?Q?1sHzDQRzURvXjrMEfFDkq5b8+GfXqfx44bOmVkcqJM6Bt1eSJsAplPzv8NK9?=
 =?us-ascii?Q?woWkFoEqEa0CkY4FE0ddIUppojlpJ1+209WRApy2LXEeL+T2viQRqiZKLOr2?=
 =?us-ascii?Q?/4FRxHFScdcb9gE5bqDWJneLTYLpsjv8YE/nYOIBw4Cli4feBBz+XAlW32de?=
 =?us-ascii?Q?6D8uxinawCwJ9je8mKj5IdDcwA8v8AEcGdeGRYdpGvJo+Eaw9OHfjFUbf8LM?=
 =?us-ascii?Q?rPryR6Wmrgj1u83OLTHbAg7bd3S91EldX3eGd5WxLUZ/+Ej7yy4bqZiuU9+k?=
 =?us-ascii?Q?yNGK8uaXuMVqbt51sQiRwW0EWxhB3tFtaqSyRA312mNd7s9cA/74TfisHqLA?=
 =?us-ascii?Q?lVBWKD1CtMkLlKb1u8KuBY0pf7613NZUZ4Z1Kvn0v4mOtCkMdx5pdB2Ak+pe?=
 =?us-ascii?Q?IUNCT336WNPvLcxlDPTrFKTtTxmHhg56cRlHlLrNwzOfaC6iABM3uarVLEc3?=
 =?us-ascii?Q?aGYrIbcXkkh1RQ2yh+6DJ/NtbtCsj2Nlyitm2NW0ww+TUzOuUAaDpEPgC/Sj?=
 =?us-ascii?Q?zcAQpHSgYQ2JJfoMxB/Y1/M+qjN6xPLVdF62ZbkGrxA7ew0hFp0XLY/GSg31?=
 =?us-ascii?Q?L2ddHhond2CtQeN0590SYpxfl0uCqgO4MGLB1/zX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db6c4065-4552-4acf-1e76-08dc6d7e4926
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:40:34.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRqUQT9AJIacKTgverlFAe2vBQJEWAItZcD8QcJdu8j+O78xx9cOey638ccWOcZJg/5mDGFeQsh6hGo/MlIAyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6548
X-OriginatorOrg: intel.com

Julia Lawall wrote:
> 
> 
> On Sun, 5 May 2024, Matthew Wilcox wrote:
> 
> > Here's a fun bug that's not obvious:
> >
> > hfs_bnode_move:
> >                                 dst_ptr = kmap_local_page(*dst_page);
> >                                 src_ptr = kmap_local_page(*src_page);
> >                                 memmove(dst_ptr, src_ptr, src);
> >
> > If both of the pointers are guaranteed to come from diffeerent calls to
> > kmap_local(), memmove() is probably not going to do what you want.
> > Worth a smatch or coccinelle rule?
> >
> > The only time that memmove() is going to do something different from
> > memcpy() is when src and dst overlap.  But if src and dst both come
> > from kmap_local(), they're guaranteed to not overlap.  Even if dst_page
> > and src_page were the same.
> >
> > Which means the conversion in 6c3014a67a44 was buggy.  Calling kmap()
> > for the same page twice gives you the same address.  Calling kmap_local()
> > for the same page twice gives you two different addresses.
> >
> > Fabio, how many other times did you create this same bug?  Ira, I'm
> > surprised you didn't catch this one; you created the same bug in
> > memmove_page() which I got Fabio to delete in 9384d79249d0.
> >
> 
> I tried the following rule:
> 
> @@
> expression dst_ptr, src_ptr, dst_page, src_page, src;
> @@
> 
> *                                dst_ptr = kmap_local_page(dst_page);
> 				... when any
> *                                src_ptr = kmap_local_page(src_page);
> 				... when any
> *                                memmove(dst_ptr, src_ptr, src);
> 
> That is, basically what you wrote, but with anything in between the lines,
> and the various variables being any expression.
> 
> I only got the following results, which I guess are what you are already
> looking at:
> 
> @@ -193,9 +193,6 @@ void hfs_bnode_move(struct hfs_bnode *no
> 
>  		if (src == dst) {
>  			while (src < len) {
> -				dst_ptr = kmap_local_page(*dst_page);
> -				src_ptr = kmap_local_page(*src_page);
> -				memmove(dst_ptr, src_ptr, src);
>  				kunmap_local(src_ptr);
>  				set_page_dirty(*dst_page);
>  				kunmap_local(dst_ptr);
>

I'm no expert but this did not catch all theplaces there might be a
problem.

hfsplus/bnode.c: hfs_bnode_move() also does:

216                                 dst_ptr = kmap_local_page(*dst_page) + dst;
217                                 src_ptr = kmap_local_page(*src_page) + src;
...
228                                 memmove(dst_ptr - l, src_ptr - l, l);

...

247                         dst_ptr = kmap_local_page(*dst_page) + src;
248                         src_ptr = kmap_local_page(*src_page) + src;
249                         memmove(dst_ptr, src_ptr, l);

...

265                                 dst_ptr = kmap_local_page(*dst_page) + dst;
266                                 src_ptr = kmap_local_page(*src_page) + src;

...

278                                 memmove(dst_ptr, src_ptr, l);

Can you wildcard the pointer arithmetic?

Ira


> @@ -253,9 +250,6 @@ void hfs_bnode_move(struct hfs_bnode *no
> 
>  			while ((len -= l) != 0) {
>  				l = min_t(int, len, PAGE_SIZE);
> -				dst_ptr = kmap_local_page(*++dst_page);
> -				src_ptr = kmap_local_page(*++src_page);
> -				memmove(dst_ptr, src_ptr, l);
>  				kunmap_local(src_ptr);
>  				set_page_dirty(*dst_page);
>  				kunmap_local(dst_ptr);
> 
> julia



