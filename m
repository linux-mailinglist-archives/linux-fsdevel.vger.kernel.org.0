Return-Path: <linux-fsdevel+bounces-31444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA0996DEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBDC1F219FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B711A0B0E;
	Wed,  9 Oct 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDs8TxD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480318EAD;
	Wed,  9 Oct 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484306; cv=fail; b=Q8LF+D7yvNq+/xomLphSVgV1/BV07wk8sqdFskQWAAMNgWD9hPKPI1ECwOkqfo1I96VA5gFFggUamGkH2bcpL+zII7qXInHZYIFzOhMDlz7eq/DgA5z8larDOvNNdRu6owzAesCqFqajqlZwZ2iXsklLjiXf14wp28AeCtNdAv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484306; c=relaxed/simple;
	bh=730jVH0FodWnhgtAC+I7xNcaUM0aFn252aonbqoKOr0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qxMLqvfcyERnkhwcPR2AMi9jkuNAxOvhquKCjG5gtcx5kTNRqhHrE8s94z1V6WlmflaC8bdCBJk55be1fKqnCIZeleK5fzL6OZMlPC1kS0v3qx+Tf5tXBs5CkG4/kigFpCopmj3sOXM/DfuSAsmlQMNl62FLOm4u8Te2nzppn+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDs8TxD7; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728484304; x=1760020304;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=730jVH0FodWnhgtAC+I7xNcaUM0aFn252aonbqoKOr0=;
  b=WDs8TxD7ALlrJFjgiJc6cxYi+DHIstbE1f7Io1jUY/mJIq0cS93TdjVd
   UNSZJcqC3TybMn6GaH4OQbCKy9HvrA8ZtuLjHGuLdG94uRUC7DHRFoYQK
   rdjBcX0AiJdOh71Wkvqjs7qbPi6PL3ylXL8QsoIz96/IoOUDymr71gx2d
   8O/yMSBm7gxWREstH2B8D/hjoDWZKq0noiqaeZt6IIBelFy1rUHh2RhCm
   wY3p4KISZQCc8VMLLP1dkFx2N9BW7qne9vZXsS+35GZP0yZkjZgugpc/q
   ewJSwwlaLsTJslPsA0CxGoyOG3eCn7r3wZLNCsjyEaEFIqeuQ6GJsj8hH
   Q==;
X-CSE-ConnectionGUID: 1FkjY+vVTHyi3mH66mvZ4w==
X-CSE-MsgGUID: coK6WZ1GT+CqDhvw6iHUpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27263747"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27263747"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:31:42 -0700
X-CSE-ConnectionGUID: pS2rXekfTRa/XC6JsYqW9A==
X-CSE-MsgGUID: bwgJjIGmR7eTJN3UxI1VmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81078523"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 07:31:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 07:31:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 07:31:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 07:31:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 07:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz9sOVHO3/rf0uMHsP24jijwtxQc93rHFfCFZTm7vwqPTGwGJIOAbmTGTSzYbF8eNta1JXBgobRL4IyygWpAx8rD1Oma8zj/7BD7vS+IFcHRJkm5FufEvo+nKIFTjGTdFfbZkKurV+zaJgxxaaV6oUW/62QFx08aHqLMVi/wCU4arm4+C/xYIzlJOfrvx4Pzr5xkPPglVY95RIx8D7iFda0svRD4LrB1zuhaaXVuyeQSqQGW3cKlAk8/sCYoWjvrZLQEesXNe8C+A3voD6V5/bt2k60OCm82dZESEMBlj16sh/hUMlpisu1pbDkQsV/FP8Gnk8/z276WHcn7z2W44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVP8qtqOLzWI4/OVu186y7hDM2J8kWGfew1kTzmQW8E=;
 b=olIfbGLI1Kqyn20GIcL/BDsy2+qYCsgZ4MdYifgXw7x6WuzE2g1fADkEGcqdDZsnp+qke62rDSM0nsCbi3/1cK8ALcNcS5ZQbO4ene9FVL/hBurMkwICNHlM2AGGvTd9DJxEvw0SkbzsMUyQGepuVZ95l5Ykc6eUHmlH1KGErBIghA4lMWEpuMlRXRjGZ+I7WL/up6gBFMnfcXL9XdfbCt8NkBJpp9Xi8w9sK63mXw3Qnq9GS9ogxWIm9hJDT8wWRytY05PEnhsVXPuQ/INUGXfuBd1/O5YYOBpUA06ToE+etQbLvaivRr8NoMIjraerwW6JZHb8T9+JE3dazs7PWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7936.namprd11.prod.outlook.com (2603:10b6:208:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:31:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 14:31:37 +0000
Date: Wed, 9 Oct 2024 22:31:26 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-fsdevel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<audit@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [viro-vfs:work.xattr2] [fs/xattr]  64d47e878a:
 xfstests.xfs.046.fail
Message-ID: <ZwaTvubyvE0cAj6P@xsang-OptiPlex-9020>
References: <202410062250.ee92fca7-oliver.sang@intel.com>
 <20241006145904.GE4017910@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241006145904.GE4017910@ZenIV>
X-ClientProxiedBy: TYAPR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdcaee0-bb50-4f80-c782-08dce86f14d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QP8HWs6BBKsX38DaGg+Oamx5IQ27gS3a8dQVHJTLj3jFGJyv9rtJiohyqoMt?=
 =?us-ascii?Q?WOV80dPPfcwjTeIJa97DMA4WMQn7tPEdC3wf4v7QK7xXCMM/rqEfzkxP/sbi?=
 =?us-ascii?Q?u/FMSsE7zXhqCoc6S0YFAu9MKBltKWwyFbUpsQLQYKEyMlJOaANsT/GhzjbH?=
 =?us-ascii?Q?ONpmfM10u2oXUVrKweLIIlhGENc3U+qfKy2EWagpm9oKYzCddL1w+fdAM9+i?=
 =?us-ascii?Q?hrpBRxCSUph2nI3csHJhPztPwZuyv1EOykwFxzpsgLO6yCh9fB+uzC8L3I6x?=
 =?us-ascii?Q?DjRF+ks9Qp0ipNWghKMRJSkQ5OqTjDwCOfIaLu3t5O3a13O0DX9tsFUP8QKn?=
 =?us-ascii?Q?BnC25o7HiX3W8uyGjZPgDtU/t/TZXTC07IkvhbrUinBoJcBgD3TFd+ZYQpE/?=
 =?us-ascii?Q?PnnjsnsHruq34/lagRFlsjdQYuWJ7nETC9eGvsFW0GDqVsiLwcxONYSJdI7v?=
 =?us-ascii?Q?Wz3wwVS7UXK5lKkcMsxYD8ILxfHkxrwWEmfbHT4k2AtMH5bv1JzyCdqiF6OM?=
 =?us-ascii?Q?0kjX4AwA/mIITxqq+mKw8mBmdmcqWjXAMbYjicw7hhxUsDA0i/DqxyND+MuT?=
 =?us-ascii?Q?OJHiDStI9T5mGdC7QI8xjb/wB6+tSDdGDzYaoXKsrfZm8jH5V+C/CryVWatc?=
 =?us-ascii?Q?QrJPNv/dxh2r8utTHO8NFc+7Md+kU+f5N7R4gSfTGq51EF7jrxwrnjWL38oM?=
 =?us-ascii?Q?IfDQl3pisow2ybdr7/DrIoCucaCTJTCByWLWeR63Hz9D3itT/HkgigSlZmDs?=
 =?us-ascii?Q?d26SHsAssRQoXoWDybXxspLZOYxcEigtdj9fayLgxlWMNs2BnamMfrXOmkOB?=
 =?us-ascii?Q?e2jgpmPO90OpMOSYaF4VgDNWdvxfIRdzORYXaAdthdch29MzE9vh80Nj0zMi?=
 =?us-ascii?Q?hnoTRCD79MoA6XVD3wbN767k06jm6PWmiZpKOeycsx4T+IPHkZ+0oYhau9dl?=
 =?us-ascii?Q?4xdFoo9muVTqNYADlcVmGmpleL1aNLO4yhToIil6WeYm4ydb9feAVW0/+404?=
 =?us-ascii?Q?ZDUPQZ/VgPOXKi9Hdje2Zk40DYBF0sUxWmAXU7heDU1TU+ZEk8K1irW5Zd3i?=
 =?us-ascii?Q?Ju7Om5C2nHJUQpgXaWSLEF10APnhYxK6gveKUCUpgtSz/vbmHx2XCf3a8xOq?=
 =?us-ascii?Q?5/U86/DzaGxIvnx4HgKw7NqCVnMPDziwHHFOZFtLV4Dvwey0uq2QUeXREGwd?=
 =?us-ascii?Q?To+Bd4lRhj3EfsAMMRwNU34YS3Wq33KJDQVRBQjj/fETkb4Tl8HZkp5oVenz?=
 =?us-ascii?Q?HVPhFfWo8H6hPIA7IsjQ+/DjojNDmAoEnIVBxGq4dA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Gdg3gmvIcJDkVwt4VGChBY17dRgJG9eV3nqH+c2YtZbKegB2fSfTK/6P8BU?=
 =?us-ascii?Q?qzVjD7QZUyeFRjmim8w/Ees7O69CIniCF8k9Kngoae7W+Nk4vrHMwa7/0OTh?=
 =?us-ascii?Q?iRMQ8fn9c4n7G9OkD/Y96MUo6LFroZF5jOPU1UckMXe4LfPk7HfB7HsJeXWQ?=
 =?us-ascii?Q?Gsb/QekSz0PIEWCHWVhsUGzPKW+7Sgk+13dQ5SMDWNGoKNoVaa4hMWBA1B6B?=
 =?us-ascii?Q?784JsHS7t/0zyVeuSpYVDcLNlQTu/tzGwfBd8bAm4X0j/yUORoHr207Rygny?=
 =?us-ascii?Q?D8lhF34z/CXra5RW+05tBywqYkjvs6qU7Icz5pruox7XlRuGCLhQ3amLxOUA?=
 =?us-ascii?Q?nEFbPJNFOyMjnXdYA4PnrBlSkXHmy8kSDwo7Nk00lTaKEvKYVbpeTmzNeKzX?=
 =?us-ascii?Q?EsG7iSo9zrQRbaopa6VKLmWKCfkF4uuVTz+GCzquMFk1ZnH9o2JLQ0u3c2g+?=
 =?us-ascii?Q?VS/sulF18X7WBA5+caqrc0PCVwhpfcafRSd5jfri7EIDhdU5jACRzb9Kn3E6?=
 =?us-ascii?Q?6pkOeK7Iutlfr3SaAyT72y/C2hRslTv3no9GBOKwnhj29ZrWlD+6Hl/PHThH?=
 =?us-ascii?Q?7e5dN2Vq334rJlwjGxV/R2sWrnMRRQtvjw5LJeDUXHsEXZSf9UZV4uv29XV5?=
 =?us-ascii?Q?SufBvB+nVmdH9Ar8zKRhqKi+AqnL8TDBQNM8mIkZhGPtcjXxCB0EuOIotpiP?=
 =?us-ascii?Q?aTLvfvHsuNo7wcMJW/PzWwBf/lWfPV9JDtnZo+9sNy9RrIcw8kFWcoJqPxPy?=
 =?us-ascii?Q?0NT1aBIIwALFJIOQSeiMP5A/vt38rhkarIV00YjchoUBkLNIZC4V8YSsiXZi?=
 =?us-ascii?Q?knTMw1qE7EeLUei603WB0UZ6UirFH6tXwn+TZNe4qr+KLARFW2k1K4BQ1H/y?=
 =?us-ascii?Q?4CDgStglvHfdGyjQybCchY79w77HEJ6Tg4P2O2rqCO21O7U2R0PbyiJ3cL26?=
 =?us-ascii?Q?N8Hrtra2Gfn6P6QBSSIT41LAKfzzI//WqkfGnsaYYOB85kdyGB/st6Nr9Dmu?=
 =?us-ascii?Q?3gScbzusgqPBud4boLxD/wn7QBZmLlhNOGzCkbO9A6mq7GZAh6fkFGFZ7VO0?=
 =?us-ascii?Q?Z1hHfQJIz8jgUrLI235MRBq8m/Zud/KeZEDNWaqpOWemaiG7zBKfpClscX1W?=
 =?us-ascii?Q?JQioOuh5e5ob0xaCYFQ6iGU5R7XyWnb8V6hgvw7OjNEzWRAgiQvNjDkP0ZOy?=
 =?us-ascii?Q?VUj0PgnBgldJYPqsaGKw6PsFsUE+tvz4Y+8qQ8g3GoymY3zK4addfPiZ/bWN?=
 =?us-ascii?Q?I2sVIW8TfIvgFXesSFPJQCfC13AVjyfb82juwq6KD3dogAEymYglZaaHQwZo?=
 =?us-ascii?Q?03QK13Ng42YTwXFVByL1gFBry4Lz2vH/uhLVFxGtil2DX/PV7BqRARPlD6N9?=
 =?us-ascii?Q?Dha1xPvfrzcwrEw+Vp/XTBv5rPK2FM1pnj6Nn9ULq9fRY4ygWDxPNuSqdVnn?=
 =?us-ascii?Q?BFJd5hRN/wZanxRuRaOb+9A2WtfE0G/ioU4MMlVV5BpU1tYEQIXkOSrzou3o?=
 =?us-ascii?Q?19rp5Rh8d2FUl6mW1TinBB/IR76B9yNgfTIRks9wt3C8klBl20Z/1lMEk1IE?=
 =?us-ascii?Q?oGfxlLTfDa1/areKov7L3xb0PH5y3/PIkEhlKWsWQHqX/ETWGbRKQe+o0D3W?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdcaee0-bb50-4f80-c782-08dce86f14d9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:31:37.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDNAVVXMC6o11plRdKKBUrf6yi0dwmLvdpxLduCr+pXoYxxnpKhHRyUkoTSYFFjimUSrPYlI210H7Vwmblmkjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7936
X-OriginatorOrg: intel.com

hi, Al Viro,

On Sun, Oct 06, 2024 at 03:59:04PM +0100, Al Viro wrote:
> On Sun, Oct 06, 2024 at 10:20:57PM +0800, kernel test robot wrote:
> 
> > xfs/046       - output mismatch (see /lkp/benchmarks/xfstests/results//xfs/046.out.bad)
> >     --- tests/xfs/046.out	2024-09-30 21:13:44.000000000 +0000
> >     +++ /lkp/benchmarks/xfstests/results//xfs/046.out.bad	2024-10-06 05:31:50.379495110 +0000
> >     @@ -34,4 +34,8 @@
> >      xfsrestore: restore complete: SECS seconds elapsed
> >      xfsrestore: Restore Status: SUCCESS
> >      Comparing listing of dump directory with restore directory
> >     +ls: /fs/scratch/dumpdir/sub/a-link: No such file or directory
> >     +ls: /fs/scratch/dumpdir/sub/b-link: No such file or directory
> >     +ls: /fs/scratch/restoredir/dumpdir/sub/a-link: No such file or directory
> >     +ls: /fs/scratch/restoredir/dumpdir/sub/b-link: No such file or directory
> >     ...
> >     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/046.out /lkp/benchmarks/xfstests/results//xfs/046.out.bad'  to see the entire diff)
> > Ran: xfs/046
> > Failures: xfs/046
> > Failed 1 of 1 tests
> 
> *stares*
> 
> D'oh...  Inverted sense for AT_SYMLINK_NOFOLLOW => LOOKUP_FLAGS...
> 
> Try this:

we confirm below patch can fix the issue

Tested-by: kernel test robot <oliver.sang@intel.com>

=========================================================================================
compiler/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/4HDD/xfs/x86_64-rhel-8.3-func/debian-12-x86_64-20240206.cgz/lkp-skl-d06/xfs-046/xfstests

commit:
  4b7d06e4b7a1c ("new helpers: file_removexattr(), filename_removexattr()")
  64d47e878a819 ("fs/xattr: add *at family syscalls")
  6f4ccbcfda377  <--- your patch

4b7d06e4b7a1c647 64d47e878a8196f374879bfdd0e 6f4ccbcfda377af1167d1b7fd48
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :6          100%           6:6            0%            :10    xfstests.xfs.046.fail


> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 0b506b6565b7..b96cca3f4bf8 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -721,7 +721,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
>  	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
>  		return -EINVAL;
>  
> -	if (at_flags & AT_SYMLINK_NOFOLLOW)
> +	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
>  		lookup_flags = LOOKUP_FOLLOW;
>  
>  	error = setxattr_copy(name, &ctx);
> @@ -880,7 +880,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
>  		return file_getxattr(fd_file(f), &ctx);
>  	} else {
>  		int lookup_flags = 0;
> -		if (at_flags & AT_SYMLINK_NOFOLLOW)
> +		if (!(at_flags & AT_SYMLINK_NOFOLLOW))
>  			lookup_flags = LOOKUP_FOLLOW;
>  		return filename_getxattr(dfd, filename, lookup_flags, &ctx);
>  	}

