Return-Path: <linux-fsdevel+bounces-26868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E095C408
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 06:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B49CB23930
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 04:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA63BB25;
	Fri, 23 Aug 2024 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaasuD+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246B3B29D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724385990; cv=fail; b=S7aqLPHxsEItZ2UpVniill2XPhbFBD1H2E8cZxLTnD+4EiolPGR13Yd3cPBLS8GSmiZN5wou7r07qA1EQJeAaCdi+j1rb6Q+Vl4f28jWgnjVIuODkLFwWQdxd3/tE7CxIQ1yRQWivW6bFLkyRAPIzWJzpx2q4HkQkxx/uhtrqFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724385990; c=relaxed/simple;
	bh=U6Ul6ukKDeLme8RzdkfubOwFgPE8hkbVB2DN/YmlhBI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eFwI30ESzstId0/Hf3fZuwZ6DJ3jIuyIAyNZgg+Z0OwEzQVoDrWI43UOEvL33TApnX+vlmL6n2/CZD23fJyoT/XfC/F6n5QbJmoSZJgVqjRtQ+bLm2uhuk7jm2xlbVdKq+IvSUIqO1kZoGGNUGWmZrkmfIp38t6bYpF1CBAZQU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaasuD+K; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724385989; x=1755921989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U6Ul6ukKDeLme8RzdkfubOwFgPE8hkbVB2DN/YmlhBI=;
  b=iaasuD+K1Mo7trcRnoH9oMJhIj5QcO+vmi4eSxgK/WQNMeqwdJh18dAE
   vRDdvYZuHN3npd8cj4YOIp1zAP0nhIeXXzDpo+DidDgSVq/bbc3fDCsQ8
   iGVoEMOdh2RxPclWROD2D2nJtIrtxO+eqbt89mp5TJ7Vw/eZ6qckuCJpR
   rXEDDZbePD17ljJLha2S/f+DxLtMneBq4qGg+cM8Ad1s30yt2/bOlZYpk
   MsCSJm2ej8bO0ObRadIJ5NKoYTYYQveFEn+iM/FQq+q2cN9MjvDjte0SB
   hpph1A1ETycQtFvb12dUfHdqtU/29M5x4VLeKjWSBuz6JAdes6dIIWFE2
   g==;
X-CSE-ConnectionGUID: 7tWfK+XURbiiwgxiQCTWRA==
X-CSE-MsgGUID: ohNHzDJJS7SVzm5z8DCT0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34255701"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="34255701"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 21:06:28 -0700
X-CSE-ConnectionGUID: jyxdqgewRBO4aq2zTlLK7g==
X-CSE-MsgGUID: XHiA+urdSZq7MvDGnqoYGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61377413"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 21:06:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 21:06:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 21:06:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 21:06:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 21:06:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdwE63KtfuC67R7PaLgiH3sLJpDyOYuZrJWuHg3gxTgpOPnVA6k0k1xkppo8LqIOwoGjwYo2BHGY8b5www2dsDtgNO82Qdgi0GEhkZEfU77qXwBSW3YjwJ+7tB42aNxdPtlKPR3CHnRmnD0TEyLgJdxcFpAcAFJvTmQd4yml/Lm7Tt8S/eoFWUsPsZZcE7KVwGydSZu6p8tdlX84pEQZVLXErhyCj6GjynhX/T7fr8y8c4rqcW2KtI9ktacB7ceYCBTgvdJZLtTHzV/+EI+dXkt1iSrS3lMKoK2knPJmVZjCDlpw/cg9bcaqA/+tff51bosHmGko0sJsGMY1Fs84hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOFQkGrQ5ayUSebedLljmsaq+qJuDxx5ZicGlqa1OOU=;
 b=KBtCkR6S5VCOajXB0BjQGoqA32VTy3wxlBnk+oP6trwMS55/C2uHDyvB0obPFBW8bQLUXR/7mN68DA9OjuS5TpbEF/gcf8Vs4uzHpvx0uFUMZde7de+JzWSrlsHPu2p+pW/3h4LPAV6ybhtxqqJ7FsKTPPZY04X8b5bkkaesdSnWqeeDV0SdmCxTGIg1dDu+hVhQLAkFOVPJxuIaKtoRVKNRKWBgyOTeLxJDciFDkKjCwdLZ+LC4tz8a030TEA7utlw0oFowOCH1OnI9rW8oiGx+wxl1uBLyKuN3283i0+T4i80nz+3vaT/qRyBvkdmY+xBALdw/mg89g9Y19tKK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 04:06:25 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 04:06:24 +0000
Date: Fri, 23 Aug 2024 12:06:17 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
Subject: [viro-vfs:work.headers.unaligned 2/2]
 util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:10: fatal error:
 'linux/unaligned.h' file not found
Message-ID: <ZsgKudBxLxfMvlCU@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SJ0PR11MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a90d34c-5297-4195-af97-08dcc328f470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AVsj4vZzBSfLnIbSvZ24953zRkx2/OjUINnPheOlqGHKarYEwoB16Xok85/A?=
 =?us-ascii?Q?rlUqGr74S7P6RDtipg2VRuI7z2waatLUTiQhbufuVhy4JS1Zd8uI/15gAVX9?=
 =?us-ascii?Q?d++IfR4QqBmD8hOnMdeSku8ZgrEDgmscbLDltQFh4pp7kZNe3az/S6sRzjA9?=
 =?us-ascii?Q?XPWVtUUuZxAqv6doeBrxh2UVI1NmzGQCqcLK4zhFam/tiRikjUQ9D3U4vXNl?=
 =?us-ascii?Q?O4DHw2ccq2NdMiOcHhBv8ASuWezjNFRJIk7YgGDr0PxmSpDT+F9Joy9rM3k0?=
 =?us-ascii?Q?4+0y3JF2PrfSL4tTW2N2GnxSr2dnhKAA9qe75G4Htv7/73cvahcb1FvB7geV?=
 =?us-ascii?Q?pwXjR8r1rNMjFVgZsIEZgwrgsLP833R1RHjyc8rlxaF45RE6dFGN9SeVb36t?=
 =?us-ascii?Q?yQG4ExHn3n3D+gKl+ziXN39wm3CLMtywxtTevkaJPQ7fPGiSw5itNfY5oipg?=
 =?us-ascii?Q?aBWLncstFYGasl5QFVhH4c2gaM4ggapfrZbaklE/beVEXkSxT8If+9hnjyAz?=
 =?us-ascii?Q?KVbz3CHPYfeoj1FhX8fE65AOaFrtcNmSxP7RG6Kx4WoTK1A4NwHPPfpjl8a5?=
 =?us-ascii?Q?i/snqOfMVb7tNUTqFRrr4nRVRDQ1S4RMyebwz+O933xnzoxIJ4ECKk5amg5/?=
 =?us-ascii?Q?tm1ewbDL4jl1HSh24siTggOJGfdlPgq8R12Ek4ao0pSBg0Xhb3y7zMM+yV9L?=
 =?us-ascii?Q?tFkSxCdlViHqYlURajK5tVng0GpPWfPBtIuouVDLYmb9vik9+9nxp9lCMSTx?=
 =?us-ascii?Q?zYNHEnSE0WcpF9DfJS/Sgyf0XS54h7EBbIOUmoOPtnbTbsdNQA1fn7oqOEFU?=
 =?us-ascii?Q?j/GjACEwGCHd3yIo7K56ogw1mu+eYxPIqm65xOlcFjIJrBaHeWdE3eNHYx/q?=
 =?us-ascii?Q?szqI0pD8ML+d4jUNC7SjK+l/0aFPC58Jcifm+ucjF96KKF+rWQD0yIkKutfP?=
 =?us-ascii?Q?uIBa8x80wGk047cIvAmRmwAGOUJVu+Pt2SYwlFT/+bQFIAlh70ebO1lzYhSL?=
 =?us-ascii?Q?BJT4d2B9eC2LL3rW52Mr1rZF3VjcaIaXprwTl22T8t/+p5iO0gsIQDI1ojxY?=
 =?us-ascii?Q?uhw8AaYjsg8Sk4JH6doYdRwRA5w5iQtZ4ut9UG8CrteEObTKYAGlVWfmk7UF?=
 =?us-ascii?Q?Vtwu4UAhn2MAOAW/IAjFT1RYb/Uz4YXnapjNIg32VvLa4P0HejndRIOZoAKw?=
 =?us-ascii?Q?wFclgADnZXRDi7uWc/4lJ3mICy5HL/k2EOTit/G1bXdoqVmbu9fxB13UWYm8?=
 =?us-ascii?Q?DjzcMvjfvKczklyNg7fQ4ioQaw8RuHaxpgP0QlUBjSpT2F9RThQKwHmPvHNa?=
 =?us-ascii?Q?McrCjYbKZ+zxFBd/6DHjNi6S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z5IJJHV4evw71TsiiwCmneI5vv4YqDOObTvTLKplratJcRZ1eBaytPxpPsja?=
 =?us-ascii?Q?9iyADbiqzIzIZxs0gdgkm9GnARRl+LFexU1y0t9UmQwYCZ5MOMMi+G1hRwrb?=
 =?us-ascii?Q?bZM6+daMAR0idAJSqVwJXj4tUqT/1icxv1q+gpiz6CD4YkfoRCm0VxR8+fgU?=
 =?us-ascii?Q?+V1TZFY2vqWGPm6y2HzEzMJtS09uV4rnZEa08mQlIEDbNe7XVSmxzaMc76m9?=
 =?us-ascii?Q?+VaecULkUa6VqCM/U5gpq3JiqO4UXFkhLrxkQ3TGdcHThydF3aMBA1wC8g77?=
 =?us-ascii?Q?tx2N2VZ3jzlmOtBkepl8VizYM4Yq5vlDgS5SfEt1jXIGtTJTMWRisG7enDM+?=
 =?us-ascii?Q?Wl6f/gW9/HrmdnQZclQ5louETXh5UBCliUU8iM6GBGE7MbeeGMtHac9jMKF+?=
 =?us-ascii?Q?+LroAbx7eGmLPTUdMhT9AddMwvdwWD5N/09zr3o7MPZOzlvPALXYw4ffEOvc?=
 =?us-ascii?Q?NAtZGB49ECSTqyqNVMkWWXs47k9l0BD7pfd4tFOuZsZqWZ94pvHycpOlSKFs?=
 =?us-ascii?Q?gZyn2hKXYvQbP/8RIDpWbPD9J7uqVl9rv1PchcXwFtAsR/aI34xOjkRhg3FQ?=
 =?us-ascii?Q?aBhX9j4sFT3cbAx+WMKUBQx3xuvt8JXnqVl28tCv7VuQJxRzadEoFkKMc1Oc?=
 =?us-ascii?Q?CSpzsCUxbZzLooVoxISr4rv1/hMSdo+cJHg4mbtdo7buVr7jPkJCb8MLvhwI?=
 =?us-ascii?Q?JtsoBrVrgwg/DC8yt/WYkSwKZ9Cm/yt1b4MbWccEqVxIYhnTNMawItVW3xa1?=
 =?us-ascii?Q?SA4ZmcVCQ1/QnfkeioLyTlMww5/i/tiACFagZ2dTFwbjT6zYmEL5nyf2hk+g?=
 =?us-ascii?Q?VxFJyUaS+E+EGKW0BaYGTT1zJUDTQusIFf9iyaQdNVoDONVbrtYorPvGwsBm?=
 =?us-ascii?Q?CwGHGio7ajWTu16PIf1RwPxbFUqY2qTNID0EN4LLmgr3UZMnRUgCc+mt48Nj?=
 =?us-ascii?Q?dzFNzxwGQAaSIwgQ+XaPYWapAH+n2BiwRdPvJD2d85PVUOK0iQDxUbXLz6wb?=
 =?us-ascii?Q?i9MbaCm3eb2Lq6U9UvDbVGBeWmQUhf4VmCEunT2FWZGBffMUuzRttP5fE9yP?=
 =?us-ascii?Q?v7/JicBM0mHTAicLChKCTnujSwYSk78bSKo1ObF79XkBPKYiVUbGf7EMt86I?=
 =?us-ascii?Q?YtSXsXb26Sj0xj/yS1Sv3midQNyPndRqGJRHFmkGmJVP0GtXWGmuAZax0DD4?=
 =?us-ascii?Q?YwZ4YhqSRlyiIjn/Xz4ROq+fREaJmjhWyeHUz66zFyAfMq5vV50/VSUhbdkT?=
 =?us-ascii?Q?0gX8oeDzC3/oOxZi2JVhZiR9kHREUY/d8q2LQ38kpfZdQV8vBhQuJYMf3TkM?=
 =?us-ascii?Q?llDq/kO6tmVmbnhAuW4h249ER6yktonb3LqkQqML+28oJzbtwJMJqJKy7zXL?=
 =?us-ascii?Q?YduuVkmW18AE48SsvD7XcvQcBJ1CdmmWdmXTTYoR23VPaE3JEN7qUxdxi+rK?=
 =?us-ascii?Q?7J8X168NwOCdUXddE+Slt2mCZuZqYGDey81BgTfpggvIQKTzjTP73/GOZR4s?=
 =?us-ascii?Q?y2etl83Sed5YFZE1h4IVTqi9b7oLlPcn+RAsWxPfuvDUQkB9fkeYNfTxTTkU?=
 =?us-ascii?Q?lnaENEt2Q+kHaekpEPXb4snLi5AF0GA6aFxauawX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a90d34c-5297-4195-af97-08dcc328f470
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 04:06:24.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sg31JjE3Dw5jwnMWbB0pEL/mDaWV0FWKnw757ag1L6ff9mbQtgyYxY1P23L/tuf48sBpe+hJWdZ4gxzl32/D7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

Hi Al,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.headers.unaligned
head:   5adcdf60b29da8386cab7bb157927fec96a46c42
commit: 5adcdf60b29da8386cab7bb157927fec96a46c42 [2/2] move asm/unaligned.h to linux/unaligned.h
:::::: branch date: 23 hours ago
:::::: commit date: 23 hours ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408190146.7jadYUKv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202408190146.7jadYUKv-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:656: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
     PERF_VERSION = 6.11.rc1.g5adcdf60b29d
>> util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:10: fatal error: 'linux/unaligned.h' file not found
      14 | #include <linux/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[8]: *** [tools/build/Makefile.build:106: tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.o] Error 1
   make[8]: *** Waiting for unfinished jobs....
>> util/intel-pt-decoder/intel-pt-pkt-decoder.c:13:10: fatal error: 'linux/unaligned.h' file not found
      13 | #include <linux/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~~~
   In file included from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
   util/intel-pt-decoder/../../../arch/x86/lib/insn.c:16:10: fatal error: '../include/linux/unaligned.h' file not found
      16 | #include "../include/linux/unaligned.h" /* __ignore_sync_check__ */
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[8]: *** [tools/build/Makefile.build:106: tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o] Error 1
   make[8]: *** Waiting for unfinished jobs....
   1 error generated.
   make[8]: *** [util/intel-pt-decoder/Build:14: tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o] Error 1
   make[7]: *** [tools/build/Makefile.build:158: arm-spe-decoder] Error 2
   make[7]: *** Waiting for unfinished jobs....
   make[7]: *** [tools/build/Makefile.build:158: intel-pt-decoder] Error 2
   make[6]: *** [tools/build/Makefile.build:158: util] Error 2
   make[5]: *** [Makefile.perf:762: tools/perf/perf-util-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:265: sub-make] Error 2
   make[3]: *** [Makefile:70: all] Error 2
--
>> diff: tools/include/linux/unaligned.h: No such file or directory
     diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
     diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
     diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
     diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
     diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h
     diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
     diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
     diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
     diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
     diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
     diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
     diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
     diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
     diff -u tools/include/linux/unaligned.h include/linux/unaligned.h
     diff -u tools/lib/list_sort.c lib/list_sort.c
     diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
     diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
     diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
     diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h
     diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h
     diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h
     diff -u tools/perf/trace/beauty/include/uapi/linux/stat.h include/uapi/linux/stat.h
     diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h


vim +14 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c

5adcdf60b29da8 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c Al Viro      2023-12-05 @14  #include <linux/unaligned.h>
ffd3d18c20b8df tools/perf/util/arm-spe-pkt-decoder.c                 Kim Phillips 2018-01-14  15  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


