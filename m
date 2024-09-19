Return-Path: <linux-fsdevel+bounces-29674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A9097C2D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 04:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7E28282E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 02:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A241746;
	Thu, 19 Sep 2024 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKyJlFYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F204381BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726712649; cv=fail; b=jPYz36dyFl5Ny5aHSs1dd/G9Y1X4wwWSfB/Qt3sUfbAc4HUMgZQZqpC3XPQn25OMEH9a6kCkQDKDP+bLnlnACmsloqRvxptLlbcK5odA8L1MedBSEtGp8vVklu9f9nuwWvvKwjmZw1lc419bmzFVrNyYda1Si382AiTsBdLrxsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726712649; c=relaxed/simple;
	bh=KKyGGKyv154C7X34EiTR8qD884F+ps+QcTuIMAsImOY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RcyBFtZ5JfEexP/tXr0ZxGVpIpPcYIcThdrIzW4wLiM6IKkUx29+vb+gQoS4UCZmZ3kr60mx1Mf98pi+RqzqCA7gkKJ78Yovty7SarWEhDPFX/g9jFkhftsSFWSEKTunAvs4/VIza5+N0EPB73Jj6NGhW1T++wFgGzfI1fNX7Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKyJlFYf; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726712648; x=1758248648;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KKyGGKyv154C7X34EiTR8qD884F+ps+QcTuIMAsImOY=;
  b=XKyJlFYfyDhUfK7KJLNJmbp5l5me1rMc/aaY9xGENItym9oXwrcWPhUl
   R5BpKo2SJZZVM4ElKugVCpj/Wyx5AvDNuWSzPRXW+Mna3WRT2JjgGGlE2
   Ditlo00XnTZvn9B86H0a7nSmCkfgeiEm4dmQyK2CCXtyJKPch8yzrsenB
   kR7HkPtSVNZlfuKlfNQ2kzihxuz9GkhuYEAnRY1kYCx2NRnH3ghYFHaHJ
   PyZAFQl9F1Ygpw09+L/ikArcz5/0NZq9oviap7OrfVeufh2etwjKjlWtX
   +nMyhDiuCg05QiJ4XXmzpHwSQLtQcmeh6DyKTYEPLT0kpEeim0C+oQtCZ
   g==;
X-CSE-ConnectionGUID: RJMPLVp8R4uD3b93yPPb1Q==
X-CSE-MsgGUID: qJ48oACXTZSv/3bUSDhYhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="36225594"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="full'?scan'208";a="36225594"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 19:24:03 -0700
X-CSE-ConnectionGUID: sNSsZ3q3TqaNhlauZ1IY0Q==
X-CSE-MsgGUID: LTB7D4NXS4+9BEwts6fwZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="full'?scan'208";a="74313816"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2024 19:24:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 19:24:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 19:24:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 18 Sep 2024 19:24:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 19:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIMW/OILIIU6xlc88veYSz7xVbPar9wqobP3Ti0Gh2LyftQ07R2Z02Hp2BGJPdnBfNI3sTLK+qjTNGipWJW8wvu/R0iDW7wkE3g+gDSZ4s0+rJdgbnOxC1+mg89ZyMSMBcTpR7eUEr35DNyexXVSzkkPzWmS2T746PlfubLVnQltNATij11sOnsxSXbcNWdjGtkIyq6GR3IRAPrkxnnDBw2i2AjuTIzM4mqPTRkT2tYn/6c/SYSkEiadSJj2K4GUPwm0Vvlamm0/5a/66wrdNIw/Y4LfcxhM0q9P0eyGzE78RWAArHFjmrBJ2A5rwSpEYfEhPxYorjQpahjuB8xR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RRN0R9uu+JJlN5rk+vltOHVS0Fc6MramHrNNnyVanQ=;
 b=wwrKfzMcloGIH3RcgfxjxHcF44stxnwRQYvKtsM4nzboeXYZg3GX+Y+iBKhRQvhbBPwjglfSy34nye53KdUnVOl7fHGRPx19c7QNqGgML1MyCRCUUs3fulQx0ogtE2HXevoWqirABZlLBntvb+KorCBlBhm8k9+wd51Uyll1q/zUSDyYuO+IiYwaYZ2tMkemIDJRc7GOAwqTfeiFQPq8Gl0Z/XWlsjV1mv7AQzPcdCBlVOlQ+ZbU1XzA3pEOd8dpty2IBDoFimjS/ybxGLJRdPfhTpk4L6b58egbm1Tbi2cIzVi8TBN3DuGLWfjsxPC5/WUOjfizLHyMJ+6GUrY8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 02:23:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 02:23:52 +0000
Date: Thu, 19 Sep 2024 10:23:42 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, Steve French <sfrench@samba.org>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [netfs] a05b682d49:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <ZuuLLrurWiPSXt7X@xsang-OptiPlex-9020>
References: <2362635.1726655653@warthog.procyon.org.uk>
 <Zuo50UCuM1F7EVLk@xsang-OptiPlex-9020>
 <202409131438.3f225fbf-oliver.sang@intel.com>
 <1263138.1726214359@warthog.procyon.org.uk>
 <20240913-felsen-nervig-7ea082a2702c@brauner>
 <2364479.1726658868@warthog.procyon.org.uk>
Content-Type: multipart/mixed; boundary="Z1R7QJjUZmGtrREj"
Content-Disposition: inline
In-Reply-To: <2364479.1726658868@warthog.procyon.org.uk>
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: b68e0f9f-e36f-4467-0168-08dcd8521a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?35cjcLm1GKRP+q9vM1x2HLtJz2vO5cd0yx2YDAzcbWITenNPIYp+PW0b54sX?=
 =?us-ascii?Q?JmIkIMjQ/2kUVjXvJ9TUbWlkMQWn6UsjaP9+dYcudX3hQnA268dXkULLi0Hr?=
 =?us-ascii?Q?7aRR7l7gEBuGhjhhUdOTGGMzLlQMATWxkS1pRIP+vKg8SetYktk3UpFcNTzf?=
 =?us-ascii?Q?9AfqKcmmnDuTY6ICZcQKSze6L8ESFpohrJR3E5Tc+pdaPGgB4jxEk3myXAW9?=
 =?us-ascii?Q?9v4AJULUhUxsBK4jhCFZLe8CEB2Gl2pCrGA3CrtexXuPxCC+gBCkYvDpYZQq?=
 =?us-ascii?Q?HaXMuudjRmVxBIOo2EbcOHQdV4wkzxEjlZzwNqcC2jBiRXF6Kt9aVxVChRPZ?=
 =?us-ascii?Q?FOQd3ck0EiDi8arzSeGbrX7XUe5jmqEEYpDMJrWh2R8nMgCoTR2k7M5YwT8T?=
 =?us-ascii?Q?Dh6WqlPZUC9m9vsQ0IwmlChgICPn9lD2+PnHEHAUHk1El8bW6W6ax9psNxXL?=
 =?us-ascii?Q?eMbotu0Npn3Dtr54xpVfVaeAOQo9AKtSpUCb+P6FLQ9qQDgNyDhC4QJ0zDRo?=
 =?us-ascii?Q?gfDfS/wQjNw1Q+xziL0ps4f9bQjIwn6S+RTwKckghAV1dxki7EZ7396roDwe?=
 =?us-ascii?Q?7qSjy6QstebywQoSLhfwsbbMhWpq/bXyuKT8uSWQHEBbvFZpoh9BCM3zkMUS?=
 =?us-ascii?Q?oo98cOLicfDoV8g3Iztv1TdhRBJSELuMrzsjeG/CB/6GkbyfnVFzRisqpwPH?=
 =?us-ascii?Q?Cb32wj9hEEIlFgBl9vXx9gYziaidgdlYHiJCRVVDC3GfGA2Js/xBMjAM8Yqz?=
 =?us-ascii?Q?0HBEKldhn+6+PLDWxNaf70+txYxcIEGfb+m9ext3Lu2WoEmKOVkrk0B8Gwl3?=
 =?us-ascii?Q?dfkSbM5PBLVtU4Z/Eg5TYQ0Fc4uqHZP+1kbEzYH8E06fYZ/uOp698W7rUML8?=
 =?us-ascii?Q?zzzSzNJTC4hCVv1ZeMXHQpcuYirnEvX9A/a4TowXK+oyd50GU61lUsEdJ9QR?=
 =?us-ascii?Q?+c1CGOO6U3fFBRAP8tvlzgpPiO18xGOyJPSyey6Ol6rr33eq3JoFL9hyW1Mi?=
 =?us-ascii?Q?uDp0yBB4owtF/N8ZadhAKDyVQpdLcpzanB+h0P7StCoFI0/Wdcf3JOlgSogQ?=
 =?us-ascii?Q?DUshuD2TwV+rLzSl3zsFytK9tLZnRoqZxGKxmVbf1Pff3H86jM6RXQFJdpjD?=
 =?us-ascii?Q?6IMPmpeTSCUAeq/m09RVFdKM8b2j0fX1Ce418Wo3k0WHi1nLFMExVBx1cT07?=
 =?us-ascii?Q?Y4dYqoADwrc3I6IR6iQE/u7sFeFOXo2rYs5gdMaIT1Pid43H4n/ZydDvoVr5?=
 =?us-ascii?Q?6xGQAmnCY18w5ZkEydp4FRN4j7f8quwiMt05J7ZW12CBwvd/cBzR8HjKbjes?=
 =?us-ascii?Q?ZkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PGlqcXN7upVZOKoKUAZb/zPw8usNfEZOTm4jbyWKy113uqGOTSDGEifMLGh2?=
 =?us-ascii?Q?Cwx4YMtXaEDTduitdaEtoPaoZBUW/cKL55m/XkuqBk5B1EGHQLppVT3wlZp/?=
 =?us-ascii?Q?RJjgk+ZljMLW1eQysq+xJ7zwaiTrlc1IMVnqGfOnTjhnqwT9Ozoc+i1sJZzr?=
 =?us-ascii?Q?9iguZK09IgBvs4b2eA8ymv/O70cSPFU4n6sndU1oqf2dMTQNiPfaUNVFrA6b?=
 =?us-ascii?Q?cKRa3Sq2x+W6sdFFbJm6ErJy6UlkmHjneZwc5Yhhsz9etTSIC0TqEYesQ5w3?=
 =?us-ascii?Q?TY2hk5bc+MFfvYhRz9IYb4irZH7LgWny6tJRC9Em0QiXgMQOacaeeDq9ZEUu?=
 =?us-ascii?Q?lPrvC2jWFcUzmu/lCmFpStSF5V07BLV8M9lIFGrs3DjaKU5UXT5j2442BkCS?=
 =?us-ascii?Q?ghsRuxPaopVnPBERe58+/5ncgp3uw6jgIiNuo1vt1vZ6+DqxwgnL6mfJhYnx?=
 =?us-ascii?Q?1r7eoYHDVVE/MHIY0dbMk+OlQ/Dy02dfW8v2jdtFInr++lpwustUi755K2hm?=
 =?us-ascii?Q?8crwGp+ukOEcJvnpUNzh5iOBU4PFSQnBbOCmG4S7bVSPY9jz+zhgUVyxiNpo?=
 =?us-ascii?Q?Je2elm/lhDSnvPjQa7V5GlbKhAND6YEuQnoPvFfqSom9RrkJ5OwqN78gHbjP?=
 =?us-ascii?Q?reuw8D1RYOTXb0oMsRyyRoJ595dWfY9FIl4TnpAbGe0VxwHS2twaMQ1zPVvJ?=
 =?us-ascii?Q?lR1zNXAHn39ei3nHn3HlI9WXpJYAULJw/11FpYrlhI3zFSD/IyLb07wSvCYL?=
 =?us-ascii?Q?8nlut+OhZrKOlEvFGbiTKKVzn8XbW+Qi9BdxVchGtSkpZzg70nQDsBwCIG+o?=
 =?us-ascii?Q?VuPojg+ChgOukxzhAV6j34S32WHSAHL8DSLX2ct4mHtaQQnDQB+YfGPFQk0s?=
 =?us-ascii?Q?uSj9Mx7+qsYDPO/pbmCxg/KpBK1Cohw1I6CJjs9CeS8FnYVbRWNTX7jyuEuK?=
 =?us-ascii?Q?thfvGFMYADRnmkPAsf/ZXm0tGab3Jk9D807r7bFLZYICNse4hUrLw2Kz01Pn?=
 =?us-ascii?Q?MWZbwO3RZRX4mIeOO9JEycF0ZC3GC5YMoUgHMMkk/FyDWpXAmK/6o1EK13b6?=
 =?us-ascii?Q?o77hHaeY+/RxlnyX1f8UkanR6tkSZ1daBm8Sg6naN7xtBCLLFvofLuALCQuD?=
 =?us-ascii?Q?0hZwZjUerYnYdCq4aRDNHfc7kUXhK1x/QCNd3ogDdqQcqwmzyLjVewgeNoAu?=
 =?us-ascii?Q?FZUV6nEfKU3cQdq6JBZuJML1WHtRrPp+Jaxq/YXfzoNt5yreJfuId3HXjg7B?=
 =?us-ascii?Q?nEdzdWaaRu7pNrvxt6xP4B2Asl+Jx6OtWkjvpzVW+YO6TmLHQezWt5tEWfEK?=
 =?us-ascii?Q?AL5WXQ0eefaxFm85DY4OfCpOmuOfva6/5lBy8xJZqoSCavcvDL81OC9iSYhX?=
 =?us-ascii?Q?mszriwtNCSrnyQ2HlRjHhTWclKDnt24ULjynXQ6ornbFMEgT7yqdOCzMBCss?=
 =?us-ascii?Q?fKjsRHEytmJv2uljeUYiwv4oF8JPieOPje23O6PK1+bh4vE2ZlAblOqOLi+3?=
 =?us-ascii?Q?QWVsb4HDDJPVZ+n5UmnLp7ITdXjhtSnrmpOqj94+Y/nkqy5F2LoXes4H8am/?=
 =?us-ascii?Q?bmRXLC6iDzYN/ETOG6k1fqAIgABHg/hFzaWZEqtOAJkrpopqgvzgS0/qKSyt?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b68e0f9f-e36f-4467-0168-08dcd8521a45
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:23:52.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4azzV6bKgSH+3SV9ruNc66hjFogLUkAvJmwX0jKLPg4Y0XqsguZ18o5GnFm8wU1MzSsePXMs0WPzAXzGAp5HbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
X-OriginatorOrg: intel.com

--Z1R7QJjUZmGtrREj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, David,

On Wed, Sep 18, 2024 at 12:27:48PM +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > Does this:
> > 
> > https://lore.kernel.org/linux-fsdevel/2280667.1726594254@warthog.procyon.org.uk/T/#u
> > 
> > 	[PATCH] cifs: Fix reversion of the iter in cifs_readv_receive()
> > 
> > help?
> 
> Actually, it probably won't.  The issue seems to be one I'm already trying to
> reproduce that Steve has flagged.
> 
> Can you tell me SMB server you're using?  Samba, ksmbd, Windows, Azure?  I'm
> guessing one of the first two.

we actually use local mount to simulate smb. I attached an output for details.

2024-09-11 23:30:58 mkdir -p /cifs/sda1
2024-09-11 23:30:58 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda1 /cifs/sda1
mount cifs success
2024-09-11 23:30:58 mkdir -p /cifs/sda2
2024-09-11 23:30:58 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda2 /cifs/sda2
mount cifs success
2024-09-11 23:30:59 mkdir -p /cifs/sda3
2024-09-11 23:30:59 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda3 /cifs/sda3
mount cifs success
2024-09-11 23:30:59 mkdir -p /cifs/sda4
2024-09-11 23:30:59 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda4 /cifs/sda4
mount cifs success


2024-09-11 23:31:00 mount /dev/sda1 /fs/sda1
2024-09-11 23:31:01 mkdir -p /smbv2//cifs/sda1
2024-09-11 23:31:01 export FSTYP=cifs
2024-09-11 23:31:01 export TEST_DEV=//localhost/fs/sda1
2024-09-11 23:31:01 export TEST_DIR=/smbv2//cifs/sda1
2024-09-11 23:31:01 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=2.0,mfsymlinks,actimeo=0
2024-09-11 23:31:01 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-07
2024-09-11 23:31:01 ./check -E tests/cifs/exclude.incompatible-smb2.txt -E tests/cifs/exclude.very-slow.txt generic/071 generic/072 generic/074 generic/075 generic/076 generic/078 generic/079


> 
> Also, will your reproducer really clobber four arbitrary partitions on sdb?

yeah, we setup dedicated hdd for tests on each test machine, e.g. for the
lkp-skl-d05 used in the test, it has:

nr_hdd_partitions: 4
hdd_partitions: /dev/disk/by-id/wwn-0x5000c50091e544de-part*

then in this 4HDD-ext4-smbv2-generic-group-07 test, also as in attached output

2024-09-11 23:26:17 wipefs -a --force /dev/sda1
/dev/sda1: 2 bytes were erased at offset 0x00000438 (ext4): 53 ef
2024-09-11 23:26:17 wipefs -a --force /dev/sda2
2024-09-11 23:26:17 wipefs -a --force /dev/sda3
2024-09-11 23:26:17 wipefs -a --force /dev/sda4
2024-09-11 23:26:17 mkfs -t ext4 -q -E lazy_itable_init=0,lazy_journal_init=0 -F /dev/sda1
2024-09-11 23:26:17 mkfs -t ext4 -q -E lazy_itable_init=0,lazy_journal_init=0 -F /dev/sda3
2024-09-11 23:26:17 mkfs -t ext4 -q -E lazy_itable_init=0,lazy_journal_init=0 -F /dev/sda2
2024-09-11 23:26:17 mkfs -t ext4 -q -E lazy_itable_init=0,lazy_journal_init=0 -F /dev/sda4


I also attached 074.full. KASAN issue occurs while this 074 test
in generic-group-07.

> 
> David
> 

--Z1R7QJjUZmGtrREj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="output"

==> /tmp/stdout <==

==> /tmp/stderr <==

==> /tmp/stdout <==
RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv2-generic-group-07/lkp-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3-func/gcc-12/a05b682d498a81ca12f1dd964f06f3aec48af595/0
job=/lkp/jobs/scheduled/lkp-skl-d05/xfstests-4HDD-ext4-smbv2-generic-group-07-debian-12-x86_64-20240206.cgz-a05b682d498a-20240912-365474-1kx9t2n-0.yaml
result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/xfstests/4HDD-ext4-smbv2-generic-group-07/lkp-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3-func/gcc-12/a05b682d498a81ca12f1dd964f06f3aec48af595/0, TMP_RESULT_ROOT: /tmp/lkp/result
run-job /lkp/jobs/scheduled/lkp-skl-d05/xfstests-4HDD-ext4-smbv2-generic-group-07-debian-12-x86_64-20240206.cgz-a05b682d498a-20240912-365474-1kx9t2n-0.yaml
/usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-skl-d05/xfstests-4HDD-ext4-smbv2-generic-group-07-debian-12-x86_64-20240206.cgz-a05b682d498a-20240912-365474-1kx9t2n-0.yaml&job_state=running -O /dev/null
target ucode: 0xf0
LKP: stdout: 1226: current_version: f0, target_version: f0
2024-09-11 23:26:16 dmsetup remove_all
2024-09-11 23:26:17 wipefs -a --force /dev/sda1
/dev/sda1: 2 bytes were erased at offset 0x00000438 (ext4): 53 ef
2024-09-11 23:26:17 wipefs -a --force /dev/sda2
2024-09-11 23:26:17 wipefs -a --force /dev/sda3
2024-09-11 23:26:17 wipefs -a --force /dev/sda4
2024-09-11 23:26:17 mkfs -t ext4 -q -E lazy_itable_init=0,lazy_journal_init=0 -F /dev/sda1
2024-09-11 23:26:17 mkfs -t ext4 -q -E lazy_itable_init=0,lazy_journal_init=0 -F /dev/sda3
2024-09-11 23:26:17 mkfs -t ext4 -q -E lazy_itable_init=0,lazy_journal_init=0 -F /dev/sda2
2024-09-11 23:26:17 mkfs -t ext4 -q -E lazy_itable_init=0,lazy_journal_init=0 -F /dev/sda4
2024-09-11 23:30:56 mkdir -p /fs/sda1
	ext4
2024-09-11 23:30:56 mount -t ext4 /dev/sda1 /fs/sda1
2024-09-11 23:30:56 mkdir -p /fs/sda2
	ext4
2024-09-11 23:30:56 mount -t ext4 /dev/sda2 /fs/sda2
2024-09-11 23:30:57 mkdir -p /fs/sda3
	ext4
2024-09-11 23:30:57 mount -t ext4 /dev/sda3 /fs/sda3
2024-09-11 23:30:57 mkdir -p /fs/sda4
	ext4
2024-09-11 23:30:57 mount -t ext4 /dev/sda4 /fs/sda4
Added user root.
2024-09-11 23:30:58 mkdir -p /cifs/sda1
2024-09-11 23:30:58 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda1 /cifs/sda1
mount cifs success
2024-09-11 23:30:58 mkdir -p /cifs/sda2
2024-09-11 23:30:58 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda2 /cifs/sda2
mount cifs success
2024-09-11 23:30:59 mkdir -p /cifs/sda3
2024-09-11 23:30:59 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda3 /cifs/sda3
mount cifs success
2024-09-11 23:30:59 mkdir -p /cifs/sda4
2024-09-11 23:30:59 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda4 /cifs/sda4
mount cifs success
check_nr_cpu
CPU(s):                               4
On-line CPU(s) list:                  0-3
Model name:                           Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
BIOS Model name:                      Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz  CPU @ 3.2GHz
Thread(s) per core:                   1
Core(s) per socket:                   4
Socket(s):                            1
CPU(s) scaling MHz:                   94%
NUMA node(s):                         1
NUMA node0 CPU(s):                    0-3

==> /tmp/stderr <==
512+0 records in
512+0 records out
262144 bytes (262 kB, 256 KiB) copied, 0.013281 s, 19.7 MB/s
512+0 records in
512+0 records out
262144 bytes (262 kB, 256 KiB) copied, 0.090282 s, 2.9 MB/s
512+0 records in
512+0 records out
262144 bytes (262 kB, 256 KiB) copied, 0.0451926 s, 5.8 MB/s

==> /tmp/stdout <==
2024-09-11 23:31:00 mount /dev/sda1 /fs/sda1
2024-09-11 23:31:01 mkdir -p /smbv2//cifs/sda1
2024-09-11 23:31:01 export FSTYP=cifs
2024-09-11 23:31:01 export TEST_DEV=//localhost/fs/sda1
2024-09-11 23:31:01 export TEST_DIR=/smbv2//cifs/sda1
2024-09-11 23:31:01 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=2.0,mfsymlinks,actimeo=0
2024-09-11 23:31:01 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-07
2024-09-11 23:31:01 ./check -E tests/cifs/exclude.incompatible-smb2.txt -E tests/cifs/exclude.very-slow.txt generic/071 generic/072 generic/074 generic/075 generic/076 generic/078 generic/079
IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
FSTYP         -- cifs
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.11.0-rc6-00065-ga05b682d498a #1 SMP PREEMPT_DYNAMIC Thu Sep 12 06:26:04 CST 2024

generic/071       [not run] this test requires a valid $SCRATCH_DEV
generic/072       [not run] xfs_io fcollapse  failed (old kernel/wrong fs?)
generic/074       _check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//generic/074.dmesg)

generic/075        95s
generic/076       [not run] this test requires a valid $SCRATCH_DEV
generic/078       [not run] kernel doesn't support renameat2 syscall
generic/079       [not run] file system doesn't support chattr +ia
Ran: generic/071 generic/072 generic/074 generic/075 generic/076 generic/078 generic/079
Not run: generic/071 generic/072 generic/076 generic/078 generic/079
Failures: generic/074
Failed 1 of 7 tests


--Z1R7QJjUZmGtrREj
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="074.full"

Params are for Linux SMP
Params: n = 3 l = 10 f = 5
num_children=1 file_size=1048576 num_files=1 loop_count=10 block_size=1024
mmap=0 sync=0 prealloc=0
Total data size 1.0 Mbyte
Child 0 loop 0
Child 0 loop 1
Child 0 loop 2
Child 0 loop 3
Child 0 loop 4
Child 0 loop 5
Child 0 loop 6
Child 0 loop 7
Child 0 loop 8
Child 0 loop 9
Child 0 cleaning up /smbv2/cifs/sda1/fstest.0/child0
num_children=1 file_size=1048576 num_files=1 loop_count=10 block_size=1024
mmap=0 sync=0 prealloc=0
Total data size 1.0 Mbyte
num_children=1 file_size=10485760 num_files=1 loop_count=10 block_size=8192
mmap=1 sync=0 prealloc=0
Total data size 10.5 Mbyte
Child 0 loop 0
Child 0 loop 1
Child 0 loop 2
Child 0 loop 3
Child 0 loop 4
Child 0 loop 5
Child 0 loop 6
Child 0 loop 7
Child 0 loop 8
Child 0 loop 9
Child 0 cleaning up /smbv2/cifs/sda1/fstest.1/child0
num_children=1 file_size=10485760 num_files=1 loop_count=10 block_size=8192
mmap=1 sync=0 prealloc=0
Total data size 10.5 Mbyte
num_children=3 file_size=31457280 num_files=5 loop_count=10 block_size=512
mmap=0 sync=0 prealloc=0
Total data size 471.9 Mbyte
Child 0 loop 0
Child 0 loop 1
Child 0 loop 2
Child 0 loop 3
Child 0 loop 4
Child 0 loop 5
Child 0 loop 6
Child 0 loop 7
Child 0 loop 8
Child 0 loop 9
Child 0 cleaning up /smbv2/cifs/sda1/fstest.2/child0
num_children=3 file_size=31457280 num_files=5 loop_count=10 block_size=512
mmap=0 sync=0 prealloc=0
Total data size 471.9 Mbyte
Child 1 loop 0
Child 1 loop 1
Child 1 loop 2
Child 1 loop 3
Child 1 loop 4
Child 1 loop 5
Child 1 loop 6
Child 1 loop 7
Child 1 loop 8
Child 1 loop 9
Child 1 cleaning up /smbv2/cifs/sda1/fstest.2/child1
num_children=3 file_size=31457280 num_files=5 loop_count=10 block_size=512
mmap=0 sync=0 prealloc=0
Total data size 471.9 Mbyte
Child 2 loop 0
Child 2 loop 1
Child 2 loop 2
Child 2 loop 3
Child 2 loop 4
Child 2 loop 5
Child 2 loop 6
Child 2 loop 7
Child 2 loop 8
Child 2 loop 9
Child 2 cleaning up /smbv2/cifs/sda1/fstest.2/child2
num_children=3 file_size=31457280 num_files=5 loop_count=10 block_size=512
mmap=0 sync=0 prealloc=0
Total data size 471.9 Mbyte
num_children=3 file_size=31457280 num_files=5 loop_count=10 block_size=512
mmap=1 sync=0 prealloc=0
Total data size 471.9 Mbyte
Child 0 loop 0
Child 0 loop 1
Child 0 loop 2
Child 0 loop 3
Child 0 loop 4
Child 0 loop 5
Child 0 loop 6
Child 0 loop 7
Child 0 loop 8
Child 0 loop 9
Child 0 cleaning up /smbv2/cifs/sda1/fstest.3/child0
num_children=3 file_size=31457280 num_files=5 loop_count=10 block_size=512
mmap=1 sync=0 prealloc=0
Total data size 471.9 Mbyte
Child 2 loop 0
Child 2 loop 1
Child 2 loop 2
Child 2 loop 3
Child 2 loop 4
Child 2 loop 5
Child 2 loop 6
Child 2 loop 7
Child 2 loop 8
Child 2 loop 9
Child 2 cleaning up /smbv2/cifs/sda1/fstest.3/child2
num_children=3 file_size=31457280 num_files=5 loop_count=10 block_size=512
mmap=1 sync=0 prealloc=0
Total data size 471.9 Mbyte
Child 1 loop 0
Child 1 loop 1
Child 1 loop 2
Child 1 loop 3
Child 1 loop 4
Child 1 loop 5
Child 1 loop 6
Child 1 loop 7
Child 1 loop 8
Child 1 loop 9
Child 1 cleaning up /smbv2/cifs/sda1/fstest.3/child1
num_children=3 file_size=31457280 num_files=5 loop_count=10 block_size=512
mmap=1 sync=0 prealloc=0
Total data size 471.9 Mbyte
num_children=3 file_size=10485760 num_files=5 loop_count=10 block_size=512
mmap=1 sync=1 prealloc=0
Total data size 157.3 Mbyte
Child 2 loop 0
Child 2 loop 1
Child 2 loop 2
Child 2 loop 3
Child 2 loop 4
Child 2 loop 5
Child 2 loop 6
Child 2 loop 7
Child 2 loop 8
Child 2 loop 9
Child 2 cleaning up /smbv2/cifs/sda1/fstest.4/child2
num_children=3 file_size=10485760 num_files=5 loop_count=10 block_size=512
mmap=1 sync=1 prealloc=0
Total data size 157.3 Mbyte
Child 0 loop 0
Child 0 loop 1
Child 0 loop 2
Child 0 loop 3
Child 0 loop 4
Child 0 loop 5
Child 0 loop 6
Child 0 loop 7
Child 0 loop 8
Child 0 loop 9
Child 0 cleaning up /smbv2/cifs/sda1/fstest.4/child0
num_children=3 file_size=10485760 num_files=5 loop_count=10 block_size=512
mmap=1 sync=1 prealloc=0
Total data size 157.3 Mbyte
Child 1 loop 0
Child 1 loop 1
Child 1 loop 2
Child 1 loop 3
Child 1 loop 4
Child 1 loop 5
Child 1 loop 6
Child 1 loop 7
Child 1 loop 8
Child 1 loop 9
Child 1 cleaning up /smbv2/cifs/sda1/fstest.4/child1
num_children=3 file_size=10485760 num_files=5 loop_count=10 block_size=512
mmap=1 sync=1 prealloc=0
Total data size 157.3 Mbyte

--Z1R7QJjUZmGtrREj--

