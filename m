Return-Path: <linux-fsdevel+bounces-19409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E78C4DE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 10:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCCC282803
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDEF1D54B;
	Tue, 14 May 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbMA0SC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1117BB9;
	Tue, 14 May 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676322; cv=fail; b=HZcJj50+zBpS1T5zCS4XlDz3RRkoA2MCWaGUPqoTkBzYJoAwz/dYRIoYYjrDrN81IrsbtLdcIF+mtonC4lgLP5OT8vEgMO5eAlMJEmX4yXjhAfjaK8SmqfHMW5EerOmY50m0LoWWaDuVyEBv5tBe4isXmNx+CrGi95wJER7imj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676322; c=relaxed/simple;
	bh=eEmLzLIdk7iK3J9257p81YYGDYNL7oATyakMKV1AnLY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xuh7Yrrg6BMf1nuPQwGxDCBu5E01yXwXaRtxNV7qNqpstJ4sUh3HE52E8svEjvjiS7KjUBtz4T68M81zBfUqFABHRNcENdZSh0rymOw3uy+MreXHHdU4Sc+bZqIT/AbK/tGJeZMzpqXLgeH2GrPkyLwekynQnVlR8MYZt+zkOko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbMA0SC4; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715676321; x=1747212321;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eEmLzLIdk7iK3J9257p81YYGDYNL7oATyakMKV1AnLY=;
  b=LbMA0SC4Dtn/aI24CUW1oDWv8f5ggH7dP6ps4+wIWrJcBVLaixPvJSvN
   gb5azE6vL+3BcBPZfj7A/Tsbzcown3FtiC26XSu89MwfOdusmXHx3DN2C
   wIW59GALqmCLneaPYOJESXecpPxTp5L1NHgbZWJkpQwdAR3GQ5+gaqKjX
   X8+G0m1coU5yGHMDmXdZoaDEh4W3SNsgFAiQlJodEPtRnJF03nuquTw8/
   eELsRgtwEVqb7WDv1adiTM331r0Q8xeJDrht3bxJtVFtSWAI67rqLFBlt
   eJgC08coNJ9JYZ3P1Qd1DHhFMe1ILaAiN5P2iADv+qgM8nf4eYmYT4eW2
   w==;
X-CSE-ConnectionGUID: aYzqqNmmS1+nGbgnc9hhiQ==
X-CSE-MsgGUID: ZLNdhLdDRWaFRL306jTolw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11478064"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11478064"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 01:45:20 -0700
X-CSE-ConnectionGUID: VbJKqR/ARqW9UQAWD4byCQ==
X-CSE-MsgGUID: Aimvc/HRQDu+ZGO6ovyZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35376052"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 01:45:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:45:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:45:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:45:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:45:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+CGflI+vUoxdOTx8lNnDfta8inJGz1hAoynjZl/WrmQ9HDRrLwA1rqD37niV4FAEIxfRF6KsHiyYvTj9IMDWDETQwnmyUQefrqrc9/ZjtIXLjO1aiuYgcebYbvPZPWC5bDdWGA86wZQZuyvlOgTa3Yq5lLQRf9MnAJ1k+6bLLCc7u2ZJawScOVykIaiQvkZZT7DZxC2fNqCZdVhoMsJmNg82EdEyAhoL2qqHS/Vgjp1nC2qK+sGyBA3pSMrP7Ibxh4y8XvdwUm/vnd/UzvFEc/Zp1EhGaTA2YELFB+ytFh8P/ZNa8HwH9qRsf5ZrpFeGwYzQxRxt5guZeFKBk9WVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5Nl58k5eV1j302WOqLq9U6O3/bgyoqV3Lz5iJNY8mc=;
 b=S44iHw8AzVgPedSvO/EqkyWhwI8C5ou8YQhNaABYiobbry870gOndlz2/XtD967NhWy9inONntFpVAZv3NxReqsJCi2eTUfZjDz68nVN1BLT4TkHbL4Nv8jOJ95Fqb7YP/qMYL2BJJuDoJLu178Hdm1/CcIXUqvxHsvUzE//LcCPqnCv7QwE7wTTN+dGXMFlhzbqcTdMC15lBsfggkr7u9MVwNSpFVGgmmWN1vQFC8VZninvB25bdZWm31F84R28VdYe/7QKGmjWZFoEoGDOzxnyq6qZ2FHeOiEv15zHEX4cY8Qw0NXgWhwahkw6tomDtyr6ZpUJSP/kn7kmEuDCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:45:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:45:16 +0000
Date: Tue, 14 May 2024 16:45:07 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steve French
	<sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, "Rohith
 Surabattula" <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: Re: [dhowells-fs:cifs-netfs] [cifs] b4834f12a4:
 WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio
Message-ID: <ZkMkkxyGjc+R9i1e@xsang-OptiPlex-9020>
References: <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020>
 <202404161031.468b84f-oliver.sang@intel.com>
 <164954.1713356321@warthog.procyon.org.uk>
 <2146614.1714124561@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2146614.1714124561@warthog.procyon.org.uk>
X-ClientProxiedBy: KL1PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf6aef3-2b4d-4e00-112c-08dc73f22da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eUjUrZYFdDNHItf74wjeJfFzuuxCfqW8up2L+f9803WmbkUgOOXfi7gragpl?=
 =?us-ascii?Q?qA9gBRkCbolkriOcuM8lAjz+e4RudWmn0YHKc9lJKzaOaEUJV1NB0RryHUD0?=
 =?us-ascii?Q?p54iIdXBzFIeZDCHGDbn2YwqiJdyJPFrSFw8VRlmrqRgmB34gwNIf9a92W2Y?=
 =?us-ascii?Q?a9PrwiqNgv/U3RTKL5TF1C0lDz+O5+3N4P2K/PD5Zh1Ro5i25YNo4DiodaPI?=
 =?us-ascii?Q?cJRozEkcNVACnJHR4I2rxfyzB1f7x5tnVgN2jULp7+/KF5cryUrZjJbXi7w+?=
 =?us-ascii?Q?CJlB1tZHle2H+uyCrV1WIQrxC8Ne1zF96PUMNvXJQGUqRqwlFUKGg1lxavHO?=
 =?us-ascii?Q?h1blajZ5XA47rIcoiYXe76o6dtihMlpOkoRuybtBs2Yt/WAGITgATN3sRPmw?=
 =?us-ascii?Q?DgwwgTlu8VB8dULzIdJGTEsZVawGmUNjIAvU98DA+Z3N9G4L+R+TjJGsZRN8?=
 =?us-ascii?Q?ZRlY71NKjiHAyxI4H2591zmbPijISdALTiWK3ctRAAODZFdaLd3Y3Oz6TuCO?=
 =?us-ascii?Q?cBci/hqrQaDPujAgNI3vpLDNKNGy6AILMQ6V4by9+13bAwnhzlQlcARshtid?=
 =?us-ascii?Q?D+Mo/bWYx9+xha/SKN8oPeKUgsFScq28QhsM/1J2iohsa/JBACqVojhvaSgA?=
 =?us-ascii?Q?6UPCSARSGjWz0MfFkKlBEEqiIeIO6p92peRVoclaeRCd0qlVIFY0ttDU5b1T?=
 =?us-ascii?Q?Gt7UKLNPoUKPOQDHFIxIHSFrQrbCEcDPl74Pn9PVpPgeCpdDbBSqo78NizwV?=
 =?us-ascii?Q?WDgVaw6+9JN+33daxgAox/xldGTHWMXYoyzsAqlyB1UEmhpWhlpmZ8dSni8i?=
 =?us-ascii?Q?fqjjxEWKnD/4shHsLgLClukKjzi09kKjTTGA/gfkW1THzgCtB82MZ642W31J?=
 =?us-ascii?Q?eztWoRG1x90EShXon05wKL+Ue+RW9qiUGm2LcIGSJ+S5ubvF/vuDeZGLPBFD?=
 =?us-ascii?Q?kc/u2cosxt498LksWK0EFWBKgn11Ff/mat2jTNE+bfIV0mgnAK8Bh3yBx2Wn?=
 =?us-ascii?Q?WIx8V8BuU5cEs0gqM1le2ILFnH9PZauIzW1BJZvVtt3OcVQFmPTGS4uJXk9k?=
 =?us-ascii?Q?ZRHXxGuFuYbvHAq4rNhB4660Askkb7ou4wnfPQXQQpFIAayOAHZ9ldfiFj5P?=
 =?us-ascii?Q?Qn6MkYidH75XNpx5rB3wWXYm0u+yqn0nLi8rr4p4HNDF/VgJq5/f2crTOHsU?=
 =?us-ascii?Q?8BBTZ+/6c7rfnn5R94umbdDkv/whlBYkOmZeCLwyduwSlCa9Un7K141jjJs?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ma73qUpqJVLVRZJxVuIldnszY/ujlwsfMC7LVJCm2ZSy+BMy7kyNov9xI58?=
 =?us-ascii?Q?pacwFAh10FY0qF7ap3tNKhMztpLhrxJIHiQc414TrWOXZyGeW2HJvcNE8+a5?=
 =?us-ascii?Q?54VEjBmCagK1wM0wK9HGBcRxFyQsnEsXd/mfd9B6Pz6bu62jkA25YbpH8r01?=
 =?us-ascii?Q?IFJrtqquTJb41bIW4s7Mi9s2GXNP2jPBhG7Do/ZpCm0gpiTg0cGkmiJz64f8?=
 =?us-ascii?Q?TrWOojNRnzyWBpyTU5FbGw8BOBc8WaEFi+WvX55WCciQQJ4PbQ5gKI/RV9jE?=
 =?us-ascii?Q?3+4zbq/2/kMnx38Ids5Nlqa5hYADSXV1BV+U9AE6fdV763a4ZSBbe1GqmLJT?=
 =?us-ascii?Q?unsLYRVWJchAElNADCINb/+dy6qa0Yr2ffpofjMqWH8cRWCy9QCiDJMMrlM3?=
 =?us-ascii?Q?LAKFrGEufvIFf80nwJECGUIiuCLoi1ZXzs4cvwqbO//t3mqmSm7oxBSbctXJ?=
 =?us-ascii?Q?1xrXVOzWTctBCGbUEcPDEYy1/RVz5P49KzWU+be1tFSULLmwRj3lsoeSt4b9?=
 =?us-ascii?Q?Bt6aQZJctFSYzrtRXuPwe0CHBRrqqQWUvhw6SBmBluLmX00XEtlJhnIyucJ2?=
 =?us-ascii?Q?viLTZvfho90WEjEYRJph9bwK4RYlJ66eBQmHzRb4M0mpVJHClpkMiOfIVes/?=
 =?us-ascii?Q?YulXwX2TZBktiZTM4LutxRa2ZPKcRu/yN2TpMrglzaGIj8qrjhfIH5N2TECV?=
 =?us-ascii?Q?jesn7M4OLO8BmNMzWhSNnb/29qJKKal+FMCXQEIU7DejKpDp8/QpMz4pJEml?=
 =?us-ascii?Q?m6+j6Q6D64k/ZvM6MKMhrbMRBFmPS/dtmJ/E1cszFbq8UNelflc8lLCZGRXs?=
 =?us-ascii?Q?oTpaGH/8ir6EVesr+gvgriGDb/KEBpf+k4gp7+jo7YwTqxM+cfDlYEenSE6N?=
 =?us-ascii?Q?qr1gX1Z2nZCvg2f2Ze7h9Gsnw4WupbdM/7mvlw5hJYeI6lbwH0jFGJgAcB/J?=
 =?us-ascii?Q?3zFLd0OqZWX3lietYDfjuEfRJk4VuVdhoad/HF+qoOnLtN9E5K4d0J0US6MW?=
 =?us-ascii?Q?1S+fSo1Tmsdq8ixX26YU0wrHRjB+EHGE7hhrCMKGA9zUbStD1tMjgpqMVVUs?=
 =?us-ascii?Q?0HlKnHZbLGJfLjFYM+FyfhVcNFZS0HZM26YtAE68NVfookMSryLdKxLMjYjg?=
 =?us-ascii?Q?kOCl+CwvqVMU7ygHZyTuacAc9KyIUtFcieXp4S3GJHXdiT3FE7qxtdHUQeDX?=
 =?us-ascii?Q?M1ohId4m+Yv5n6mW9yhBf0w2wp1TZW7N6mihK75pkWAjmgln/DLZtxE9M191?=
 =?us-ascii?Q?8b8r/CcVXoTv7jOYKGkp8bwR2p+mrqXoWO06cuGZoNAb1fS3AvqQxG8fLMI7?=
 =?us-ascii?Q?Fcshw2O/2apc1oR9+q2cD2u4cs7iWt8QnMmjMjC/4uS4CC9xEzDplUbQ/Q3i?=
 =?us-ascii?Q?y5mZS9R9nPVHdU+SS5WaERtc3+fZo5nnD+neguO6Q8plw+EQvbNMtOotzzLA?=
 =?us-ascii?Q?7bThyZXk6PtqMjTh/DE3i9RxIF0U0DM6MLA6McyYTpB1/cngIMMkdT9iUMvW?=
 =?us-ascii?Q?oBlepIQkp0nHJ1iSlkhcMILMGwb8tF+cAmE2l2Z43SpuTHdxkyX34ErkJnSl?=
 =?us-ascii?Q?68cfEmOY6KsLAesEDGJOuyD9+BgONraOo0D450ByeSCFPS5Rlkwdp4ONvjho?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf6aef3-2b4d-4e00-112c-08dc73f22da0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:45:16.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ywhmr0DpFNQAJgngBb0rhx2k7xDRJZiRGtospB8OdmxGfdZiHjWncdcsf5SqS57PHSBlisPVePaE1zM+2vXnYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4882
X-OriginatorOrg: intel.com

hi, David,

we actually hope to seek your help as below.

On Fri, Apr 26, 2024 at 10:42:41AM +0100, David Howells wrote:
> Trying to do "lkp run job.yaml" doesn't work:
> 
> /root/lkp-tests/filters/need_kconfig.rb:20:in `read_kernel_kconfigs': .config doesn't exist: /pkg/linux/x86_64-rhel-8.3/gcc-13/b4834f12a4df607aaedc627fa9b93f3b18f664ba/.config (Job::ParamError)
>         from /root/lkp-tests/filters/need_kconfig.rb:176:in `block in expand_expression'
>         from /root/lkp-tests/lib/erb.rb:51:in `eval'
>         from /root/lkp-tests/lib/erb.rb:51:in `expand_expression'
>         from /root/lkp-tests/lib/job.rb:646:in `evaluate_param'
>         from /root/lkp-tests/lib/job.rb:694:in `block in expand_params'
>         from /root/lkp-tests/lib/job.rb:79:in `block in for_each_in'
>         from /root/lkp-tests/lib/job.rb:78:in `each'
>         from /root/lkp-tests/lib/job.rb:78:in `for_each_in'
>         from /root/lkp-tests/lib/job.rb:691:in `expand_params'
>         from /root/lkp-tests/bin/run-local:138:in `<main>'
> 
> I tried to run the filebench directly, but that only wants to hammer on
> /tmp/bigfileset/ and also wants a file for SHM precreating in /tmp.  I was
> able to get it to work with cifs by:
> 
> touch /tmp/filebench-shm-IF6uX8
> truncate -s 184975240 /tmp/filebench-shm-IF6uX8
> mkdir /tmp/bigfileset
> mount //myserver/test /tmp/bigfileset/ -o user=shares,pass=...,cache=loose
> 
> /root/lkp-tests/programs/filebench/pkg/filebench-lkp/lkp/benchmarks/filebench/bin/filebench -f /lkp/benchmarks/filebench/share/filebench/workloads/filemicro_seqwriterandvargam.f
> 
> It tries to remove /tmp/bigfileset/, can't because it's mounted, and then
> continues anyway.
> 
> It should be easier than this ;-)

really sorry about so many troubles.

we made some clean and fix recently, then the reproducer can run quite well on
debian now.

however, same process still blocks on fedora-39 side, while

mount -t cifs -o user=root,password=pass //localhost/fs/sda3 /cifs/sda3

seems give us a right result:

//localhost/fs/sda3 on /cifs/sda3 type cifs (rw,relatime,vers=3.1.1,cache=strict,username=root,uid=0,noforceuid,gid=0,noforcegid,addr=0000:0000:0000:0000:0000:0000:0000:0001,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1,closetimeo=1)

the following steps directly cause core dump (which runs well on debian)

2024-05-14 00:40:11 sync
2024-05-14 00:40:11 echo 3 > /proc/sys/vm/drop_caches
/home/sdp/lkp-tests/lib/job.sh: line 229: 41437 Bus error               (core dumped) "$@"
...


we are still checking now. just was wondering if you would have some quick
guidance about cifs mount to us what could cause this?


BTW, we noticed you sent a patch for this report:
https://lore.kernel.org/lkml/2150448.1714130115@warthog.procyon.org.uk/

and we also noticed this patch is already merged into latest
  branch: dhowells-fs/cifs-netfs

by our tests, the WARNING in this report disappeared in latest branch, however
we noticed some other issues which we still check if our bisect is correct.


> 
> David
> 

