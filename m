Return-Path: <linux-fsdevel+bounces-45314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E09A75EB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 08:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF213A6C1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF21624CC;
	Mon, 31 Mar 2025 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llVCYjKJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC52033A;
	Mon, 31 Mar 2025 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743400885; cv=fail; b=MkmSiVspgbJatw4ZI4+G5jd/atzG4FOXEqqSvObVibCxHTsPbMYtQJAsQ7MNzSpMJBNvH8CjGn3+oGIl6IcUsb72U012NlGtj/NU/B4mTXQaLwvbK/WyR+gKffRtRzgl/VBTqp2ZpuMLVIY9LgZY5ndxaIeiAOVHbaskWq2HoqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743400885; c=relaxed/simple;
	bh=jwGHTNZOdseYixo678oYdhRk6gM8PKJMakCgOxw1Z2A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=L2a9XvZwGXv+4rlQcC8aubywiEzDajHPWRxAcL1G2X+HkD/qQn6eTUxhk/bm4bUz63Oa94cFDMcLqFJkuYwIisY68moeQW+AIa89MGBFmn4xi3QXkEB89RZ5i9i7ye4lwUZZGasQ+mJOOItHgGjwUIM8J2Bg7dFuq656a0M6muY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llVCYjKJ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743400883; x=1774936883;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=jwGHTNZOdseYixo678oYdhRk6gM8PKJMakCgOxw1Z2A=;
  b=llVCYjKJtaU8waWAlcqfvoWCJwARGpVlnJb6xchdRDXx4hS5173i42ii
   nNPCPhzlfs0lQ+qLJJOLsBcLA/FwXvUABdYBW/XguTU7fAsR8OHNKZ+gz
   3Kkgp0Zw7knt1XGVnguXunKBmUi91juXYp2mhLIaKK1gky7rwQKV3Hsek
   xiKR1+eLtdgfFGAMa3OYkvYF97UacTkJCogfrp2tEawFmiFfiqVfjGlEg
   K2DYT1oSHVSUWAyzwRc+kavPbQyjJ9OfuxtAAkOGq47jRE4HYUfqHHCKi
   5q1b/39VERCbiT24F9twbNPH1vqH0K1d8RfzBGtLkVUgcW/Y7zR9RbXBa
   w==;
X-CSE-ConnectionGUID: SXwTP0LXRbqK5SANt28TQQ==
X-CSE-MsgGUID: 7ABRhz3kTYGTI/mo33wjEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44561507"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44561507"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 23:01:13 -0700
X-CSE-ConnectionGUID: 9vIxhMwATlCziMWFRjE4pw==
X-CSE-MsgGUID: 6FnavmfERayx7QKmV5/eRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="126908734"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Mar 2025 23:01:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 30 Mar 2025 23:01:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 30 Mar 2025 23:01:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 30 Mar 2025 23:01:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vepa7FsXhLVjmMG2v2aJF/4a4CDYtMmSglAVTHudtJanHAchVVKP+5udNOldrlwpY4xHbVcoGs406lUttLNFQvPM6ChYDLWMcNZcKmqeD+80Vw2IBEjypEB7H6VviZhQCyzmnUPwzcVIaCL0DIW5LhwcXCQ5w7IAK+uzeDD2L8uQdT+w0CJ6uZbvhITDpmZx59NdmaoMb6wdcuwnB4ahL3frF9gz7gox7kfsJ4kBsYIWmVBXRdDf0QqVnRF0I26WFK21IbZEjhbxX2Ng61vXYWBUdPbQ8m4dzrnlhPdKKb4LONGXHyAfobY9eEFeE/EQyRGC+r/SL7zZjjl+lies6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLW6EgA96kGVZCgw1eKXT2N6oumXJnVeM3V8HsVDp2Q=;
 b=kyHgLkVFp4RYQgAlyEOIizZRx5AczY49IOwi1Or+z03daN0VZQP6tk0kwsMZSw95ZLADnMEQBcLVgrHuYFbEiE2NzJNITyMcHrOiz6+XDLLS37MuDMdHj5l8Mx2thT6Obp8SG/S5KAUzqmmF0I5zJQ6C847vaIFAVDZj5kDZ5mAyOZGgFRaIc8coBpEgFZZu4+IWZoS1FVGfp4yn409cszIO5RChQPEdJVZq6/krSgQzhtr/YKIlCEpVCAEZZiGeQK9nqiATP3IGFphS2+zg+mEd83MFMlBwuUzp3MjKzF9xtEc4kdEYXXrFubAKqEdd15J5n6hK0bgvpE9DuEpoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8034.namprd11.prod.outlook.com (2603:10b6:510:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.48; Mon, 31 Mar
 2025 06:00:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 06:00:41 +0000
Date: Mon, 31 Mar 2025 14:00:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ted Ts'o <tytso@mit.edu>, "Matthew
 Wilcox" <willy@infradead.org>, Mateusz Guzik <mjguzik@gmail.com>, Dave
 Chinner <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [filemap]  665575cff0:  will-it-scale.per_thread_ops
 3.6% improvement
Message-ID: <202503311302.a2bb29e1-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: e18d2d85-4835-437f-0b49-08dd70195e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?dJiTEw0E805M7a0vQbdf3CWlODP42BeH8gSL6kZDaWPUdtp/PStGUEVdDv?=
 =?iso-8859-1?Q?GJuKjHLov7zfnErP/zXXhratU1kZO6oFmIcbfCyi2KI7QWuJZIq+rbJVJa?=
 =?iso-8859-1?Q?D+4BK8cIz62uhbi1nJTPY5NS4ZrDDsAQYV54nRfTBFZbhJPjkWyrPRQg3z?=
 =?iso-8859-1?Q?r2AupIsRB9QgIOYJTKLgijqROr7kVNIvx6ejjRLbLOUNID72N1RJySDzS8?=
 =?iso-8859-1?Q?FJ+V4tHmlzo/7JhvpfgKy3mrPvf20iEhG1g3pPz3wnGdzvcXRYChqs+nuf?=
 =?iso-8859-1?Q?p6kNmv7Gxf9/7smxwpV9VEWUevqUX0Aw5HoaDTWtVIEiZU+w7Aw1rbs5JG?=
 =?iso-8859-1?Q?SujOq5PkyCwKa3ISqLsdbKhICRplws5WdXfX4ZqpfYn/qE0bOJaKc/EiGn?=
 =?iso-8859-1?Q?F29WUPFKSNsdfwzH2v+iyPCgyov5VnW7pVpw3M1iNNRFa30Y5rEiMTb/e7?=
 =?iso-8859-1?Q?SY8qd88qe27kdw2JIqEy0f86z5zZhmQNmR8MF7mD667giBJe5tmDTs8OuD?=
 =?iso-8859-1?Q?mARwRwYfL1jyXRoy0xgYQGYZMqVOQaeg53zSiTQU476LmcPUPDjMnkrzbb?=
 =?iso-8859-1?Q?0S9ShkzUHK0WJud+jaVlYsCOS5Nbvo0HU8ImxD0rjunDkbk58OJ5VetMLj?=
 =?iso-8859-1?Q?IJ+Jko2Fe6xKio3Sja1QrBXcyEJcW9h5VBi8I5gJ7Qii2xlVjUu/R5v7Yw?=
 =?iso-8859-1?Q?EiJkd5XUjmgg/xbWfvwybY2ZQDlXkE2kEJPZ2L8pxEuD/Wg5QP0KRpulPk?=
 =?iso-8859-1?Q?CYVbKsV2yJlJ5xEnzizyX3wu1JY3YdHNhR06Eoba/wSO1YkU9PpeKCbKhE?=
 =?iso-8859-1?Q?U5w1Uo6tlV6ng7D0I6upthXmFGpMp4mINEHSatNlop2hA0qCWxaBAca/AV?=
 =?iso-8859-1?Q?B5zaFV6SdQ3XKCpMg8cr21IPyatbkhiClLdgKn2e6Bj0XFbZ6G/hx0LwY8?=
 =?iso-8859-1?Q?6MIsJXlEJuROKpwu1MzcBaZF430RF5QHDAdRKJkl3933xzb2vJc9zSDFHI?=
 =?iso-8859-1?Q?fORfJO1rCnZsQa0EpBOhIPrDa+wra9v1jxCx7bNVHcLojE/WXVRyDttkHI?=
 =?iso-8859-1?Q?kkzFfXEE74oL+jbl2r4Yw9xP9F2TMso8MH8oimjKVwXbLQ62FIE2wD+kCG?=
 =?iso-8859-1?Q?dNywvAdDm8mBEm44gjD3QhLKXkdaCU7Xm+L/UJfMiS9KKCFvAecDlnMzqT?=
 =?iso-8859-1?Q?l1L3FA9gdJJGyQ2gLilUDMxg9Py53nLxz4SEfvJt3XDWNdfBESq4QMPkiM?=
 =?iso-8859-1?Q?zqQWfA3I+NRw+ZQLFFW98fG6zzf2n4BJDbz5oILqmyNHpZ8L7FeNkMVkjp?=
 =?iso-8859-1?Q?wrHi9WRXlMAkVoMBRdlpn8PKOslNI+jh1vFEcYEUm85x+NiUyK4fVsMsma?=
 =?iso-8859-1?Q?YIq0OpxUS6vYGNGAC/DQOnfqeWbpXq0ZdAkT2AVTAoagYz+XQAklaKc3R0?=
 =?iso-8859-1?Q?VI1nNAOqxu//cPFS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?O608zDcJU5Br/RgFsu2mhBBkC/OHrK1+HJ/5Rc93LEw2EcFaCQbdqa8yJi?=
 =?iso-8859-1?Q?nggTFIAfoj5Wzm9jzWx1Kx7a15JV0Fx3mIDeSMqOsidSct72gw+KHFyiIi?=
 =?iso-8859-1?Q?8pK8AzgN5v6RVRoz3Yj5droFi85xiH5xXDQB87IG1dkglUSW63CZlI15Nk?=
 =?iso-8859-1?Q?XBut8WN+h36GNzHIqkE2ZvovZYf2JbmuNgm07Srqy869pRnV7a59yJdVG8?=
 =?iso-8859-1?Q?J8Jz2SniQwGAu0jjLfnx89ng9ZLzT1LKBKtjrunGtwKtdUp1LLmP/xfMCD?=
 =?iso-8859-1?Q?Tz9Ly2vc5csv1H9QuS/Wk3PAl2aTy6UcAZWouATsOphLRBUG9U2g2bxCtg?=
 =?iso-8859-1?Q?JhzN+m1FlzfrfxHX4WtoWWSR9x1okdylKhtGqGB+6MMwhJGqgYINLIR5f4?=
 =?iso-8859-1?Q?K6gMm6eRiOisrMYmaH0oZWvgoQzpuKGWFd/K7Xcm+Lt9MArCIqGCgPlWUB?=
 =?iso-8859-1?Q?g7/A5sjqvIvGiMSg2LRVtrEywrDvPTjwiJEGMEdgXmYu5lvRLJF+vsRQDJ?=
 =?iso-8859-1?Q?XzxLdUnm0v834dXEdh4VMZcrcFaMNADI7pcJHpi9HBomHrMruKW9wY7kcp?=
 =?iso-8859-1?Q?Jglx0uq3WP0ioEI/i3gP2tDsyufU9OPk7Hy3SMOgaGt3OCUxXQ8tmP6KMT?=
 =?iso-8859-1?Q?BjpjiD+JQLiJq65zq9CAnaJkQ0UbWNobKrJJ6P7pO5xIrRq97ZNoaF3bIW?=
 =?iso-8859-1?Q?LI0Dj/cM0MW8NlP8MOGBuiRm1sxEyQ1byo8hjCoiar57hn+McUTEnzgbTS?=
 =?iso-8859-1?Q?JZDYip3aorWeZtd4bdP6TJSqG8tNvQUYUk+fCaPD8FzRou/q+nYwV7N+A0?=
 =?iso-8859-1?Q?isut7KrFXcfwzoRjQZfbGNfYOMf3hFaicnGcJdnIfnrY3LA2vxyQ7KZcia?=
 =?iso-8859-1?Q?S5mXKKM25pfHgMS30qZ2MDJhnNvAOkYelCLbGT4Vh7m68n1/DWx3vNxA4S?=
 =?iso-8859-1?Q?3/amds9IGHFMBuc2xTVe6kDUpKMgAxVwNwhjNOoOmHdvdhXrXtarMAoEP1?=
 =?iso-8859-1?Q?9SNNt07Fe289LNsFhuAOlLf3e7p/fj/HRBdQ2yH69V4FY+P0GHgb2k34pD?=
 =?iso-8859-1?Q?5CuKZ6fSH2wIy31n+1f8gUKMsE9MyggsJUsfzqZsX9OWv2CU1MYhT7rNpB?=
 =?iso-8859-1?Q?RZm7DVThjThLdUM1CoWFh2OTbQK/5JnU7ZKCG2s1vtBYkix0LoHRfk7RD5?=
 =?iso-8859-1?Q?RqWxAvkQ1E+z8j76KDawAHJopklsq37UIWhH+fjhjKwXkF5doZTbYrgKCl?=
 =?iso-8859-1?Q?psswQ4Xlv/Fa3XPqyR35Wpf7hbamKVYWkbHL+nNjdlnkOjYlhxGxkTzp78?=
 =?iso-8859-1?Q?TQQcp+34tg+saVcn9uo9Gqzj0Y+AKFkc/7zshoz7RvugAW8E4WHHI0peTX?=
 =?iso-8859-1?Q?/+qoHU+azGdivxw27fvnpfp0gRRci223sFTDGhP0Vs3+6VQhXdBzZqmsRd?=
 =?iso-8859-1?Q?qlylCWdTViBOURDM58hQEQ4jgH2/lb1gxIbWOscGA1kuSJAx+x/GPjzkM4?=
 =?iso-8859-1?Q?lRO97P6vSG3L1Hv8ei0PC328Wl79veEjEJgC/hsTokIJZ1oRGuZIcgUA4v?=
 =?iso-8859-1?Q?W2ckwUE/or8+brFrryG9z1p8WJzfCRmwWY8aT0KoOAYssnTEYhSjE0WRn/?=
 =?iso-8859-1?Q?SrYcQ29nXpuGAihaCmPLgNeOJd9jqdws6hEAmwhHKvm2yDa9gu4dmFMQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e18d2d85-4835-437f-0b49-08dd70195e06
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 06:00:41.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iySUyyDXqBZqoOI2wPBMnCUmZUYc4MwxUmXphMv/7ZNuwlnpDt1lpUuJSzr7QbMTDPP1uaCEDYRBsvTBrR7KKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8034
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.6% improvement of will-it-scale.per_thread_ops on:


commit: 665575cff098b696995ddaddf4646a4099941f5e ("filemap: move prefaulting out of hot write path")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_task: 100%
	mode: thread
	test: writeseek1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput 4.6% improvement                                          |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_task=100%                                                                              |
|                  | runtime=300s                                                                              |
|                  | test=fsbuffer-w                                                                           |
+------------------+-------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250331/202503311302.a2bb29e1-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/writeseek1/will-it-scale

commit: 
  654b33ada4 ("proc: fix UAF in proc_get_inode()")
  665575cff0 ("filemap: move prefaulting out of hot write path")

654b33ada4ab5e92 665575cff098b696995ddaddf46 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.171e+08 ± 11%     +30.4%  1.526e+08 ± 18%  cpuidle..time
     96.67 ± 15%     -38.6%      59.33 ± 15%  perf-c2c.HITM.local
     91.33 ± 22%     -37.8%      56.83 ± 18%  perf-c2c.HITM.remote
  77338762            +3.6%   80146917        will-it-scale.64.threads
   1208417            +3.6%    1252295        will-it-scale.per_thread_ops
  77338762            +3.6%   80146917        will-it-scale.workload
      0.02 ±  3%      +0.0        0.03 ± 19%  perf-stat.i.branch-miss-rate%
   9721738 ±  4%      +8.9%   10586240 ±  5%  perf-stat.i.branch-misses
      0.02 ±  3%      +0.0        0.02 ±  5%  perf-stat.overall.branch-miss-rate%
    683007            -3.3%     660149        perf-stat.overall.path-length
   9685250 ±  4%      +8.9%   10545947 ±  5%  perf-stat.ps.branch-misses
     31.54            -2.4       29.18        perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
     40.31            -1.9       38.39        perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.03            -1.9       44.17        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     53.97            -1.7       52.30        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     58.43            -1.4       56.98        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     59.33            -1.4       57.92        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     74.17            -0.8       73.38        perf-profile.calltrace.cycles-pp.write
      0.55            +0.0        0.57        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.97            +0.0        1.01        perf-profile.calltrace.cycles-pp.folio_unlock.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write
      0.57 ±  3%      +0.0        0.60        perf-profile.calltrace.cycles-pp.file_remove_privs_flags.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      1.01            +0.0        1.04        perf-profile.calltrace.cycles-pp.fput.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.08            +0.0        1.12        perf-profile.calltrace.cycles-pp.up_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.54            +0.0        0.59        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.llseek
      0.99            +0.0        1.04        perf-profile.calltrace.cycles-pp.mutex_unlock.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.60            +0.1        1.67        perf-profile.calltrace.cycles-pp.down_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.68 ±  2%      +0.1        0.75 ±  3%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64_mg.current_time.inode_needs_update_time.file_update_time.shmem_file_write_iter
      1.61            +0.1        1.69        perf-profile.calltrace.cycles-pp.mutex_lock.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.94            +0.1        1.02        perf-profile.calltrace.cycles-pp.folio_mark_accessed.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      3.19            +0.1        3.27        perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.87            +0.1        0.96        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.23            +0.1        2.32        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      2.21            +0.1        2.31        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.57            +0.2        1.72        perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.shmem_file_write_iter.vfs_write
      4.90            +0.2        5.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      0.60 ±  3%      +0.2        0.80 ±  5%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      6.44            +0.2        6.66        perf-profile.calltrace.cycles-pp.clear_bhb_loop.llseek
      2.30            +0.2        2.52        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.shmem_file_write_iter.vfs_write.ksys_write
      2.24            +0.2        2.48        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      6.06            +0.2        6.30        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      2.82            +0.3        3.09        perf-profile.calltrace.cycles-pp.file_update_time.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      4.78            +0.3        5.06        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.llseek
      5.77            +0.5        6.26        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.shmem_file_llseek.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      6.65            +0.5        7.20        perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     14.05            +0.8       14.81        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     28.53            +0.9       29.47        perf-profile.calltrace.cycles-pp.llseek
     32.10            -2.4       29.69        perf-profile.children.cycles-pp.generic_perform_write
     40.86            -1.9       38.96        perf-profile.children.cycles-pp.shmem_file_write_iter
     46.47            -1.8       44.64        perf-profile.children.cycles-pp.vfs_write
     54.38            -1.6       52.74        perf-profile.children.cycles-pp.ksys_write
     72.02            -1.1       70.92        perf-profile.children.cycles-pp.do_syscall_64
     73.76            -1.1       72.66        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     74.63            -0.7       73.89        perf-profile.children.cycles-pp.write
      0.59 ±  2%      -0.0        0.54        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.20            +0.0        0.21        perf-profile.children.cycles-pp.file_remove_privs
      0.33            +0.0        0.35        perf-profile.children.cycles-pp.__f_unlock_pos
      0.53            +0.0        0.54        perf-profile.children.cycles-pp.generic_file_llseek_size
      0.89            +0.0        0.92        perf-profile.children.cycles-pp.testcase
      2.29            +0.0        2.32        perf-profile.children.cycles-pp.fput
      0.68 ±  2%      +0.0        0.71        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.38            +0.0        0.42 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.42            +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.write@plt
      1.17            +0.0        1.21        perf-profile.children.cycles-pp.x64_sys_call
      1.04            +0.0        1.08        perf-profile.children.cycles-pp.folio_unlock
      1.14            +0.0        1.19        perf-profile.children.cycles-pp.up_write
      0.63 ±  2%      +0.0        0.67        perf-profile.children.cycles-pp.file_remove_privs_flags
      0.53 ±  2%      +0.0        0.58        perf-profile.children.cycles-pp.shmem_file_llseek
      1.59            +0.1        1.65        perf-profile.children.cycles-pp.rcu_all_qs
      2.19            +0.1        2.26        perf-profile.children.cycles-pp.mutex_unlock
      0.75            +0.1        0.82 ±  3%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.22 ±  3%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.inode_to_bdi
      0.44 ±  2%      +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.xas_start
      1.73            +0.1        1.80        perf-profile.children.cycles-pp.down_write
      3.40            +0.1        3.48        perf-profile.children.cycles-pp.shmem_write_end
      1.00            +0.1        1.08        perf-profile.children.cycles-pp.folio_mark_accessed
      3.53            +0.1        3.62        perf-profile.children.cycles-pp.mutex_lock
      0.65            +0.1        0.75        perf-profile.children.cycles-pp.xas_load
      1.00            +0.1        1.10        perf-profile.children.cycles-pp.rw_verify_area
      1.48 ±  3%      +0.1        1.59 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.58            +0.2        3.74        perf-profile.children.cycles-pp.__cond_resched
      1.71            +0.2        1.86        perf-profile.children.cycles-pp.current_time
      4.70            +0.2        4.90        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      4.36            +0.2        4.57        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.74 ±  2%      +0.2        0.95 ±  4%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      2.43            +0.2        2.66        perf-profile.children.cycles-pp.inode_needs_update_time
      2.38            +0.2        2.62        perf-profile.children.cycles-pp.filemap_get_entry
      5.53            +0.3        5.78        perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.96            +0.3        3.23        perf-profile.children.cycles-pp.file_update_time
     12.62            +0.5       13.10        perf-profile.children.cycles-pp.clear_bhb_loop
      6.04            +0.5        6.54        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      6.79            +0.6        7.35        perf-profile.children.cycles-pp.shmem_write_begin
     14.14            +0.8       14.90        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
     28.74            +0.9       29.66        perf-profile.children.cycles-pp.llseek
      0.58 ±  3%      -0.0        0.54        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.13            +0.0        0.14        perf-profile.self.cycles-pp.__f_unlock_pos
      0.47            +0.0        0.48        perf-profile.self.cycles-pp.generic_file_llseek_size
      0.36            +0.0        0.38        perf-profile.self.cycles-pp.folio_mark_dirty
      0.27 ±  2%      +0.0        0.29        perf-profile.self.cycles-pp.xas_load
      1.56            +0.0        1.58        perf-profile.self.cycles-pp.shmem_write_end
      1.14            +0.0        1.17        perf-profile.self.cycles-pp.down_write
      0.31            +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.security_file_permission
      0.54 ±  3%      +0.0        0.58        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      1.02            +0.0        1.06        perf-profile.self.cycles-pp.x64_sys_call
      0.56 ±  2%      +0.0        0.60        perf-profile.self.cycles-pp.file_remove_privs_flags
      0.52            +0.0        0.56 ±  2%  perf-profile.self.cycles-pp.file_update_time
      0.41 ±  2%      +0.0        0.45        perf-profile.self.cycles-pp.shmem_file_llseek
      0.96            +0.0        1.00        perf-profile.self.cycles-pp.folio_unlock
      1.07            +0.0        1.12        perf-profile.self.cycles-pp.up_write
      1.36            +0.0        1.41        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.80            +0.0        0.85        perf-profile.self.cycles-pp.ksys_lseek
      0.86 ±  2%      +0.0        0.91        perf-profile.self.cycles-pp.generic_write_checks
      1.20            +0.0        1.24        perf-profile.self.cycles-pp.rcu_all_qs
      0.75            +0.1        0.80 ±  2%  perf-profile.self.cycles-pp.shmem_write_begin
      0.16 ±  4%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.inode_to_bdi
      2.05            +0.1        2.11        perf-profile.self.cycles-pp.mutex_unlock
      0.62 ±  2%      +0.1        0.69        perf-profile.self.cycles-pp.rw_verify_area
      0.69 ±  2%      +0.1        0.75 ±  3%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.72            +0.1        0.79        perf-profile.self.cycles-pp.inode_needs_update_time
      0.31 ±  2%      +0.1        0.38 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.93            +0.1        1.01        perf-profile.self.cycles-pp.folio_mark_accessed
      1.98            +0.1        2.07        perf-profile.self.cycles-pp.__cond_resched
      2.34            +0.1        2.43        perf-profile.self.cycles-pp.llseek
      0.94            +0.1        1.04        perf-profile.self.cycles-pp.current_time
      1.48 ±  3%      +0.1        1.59 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.50            +0.1        2.62        perf-profile.self.cycles-pp.do_syscall_64
      0.52 ±  4%      +0.1        0.66 ±  7%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      1.72            +0.1        1.87        perf-profile.self.cycles-pp.filemap_get_entry
      4.03            +0.2        4.19        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      2.97            +0.2        3.15        perf-profile.self.cycles-pp.write
      2.14            +0.2        2.33        perf-profile.self.cycles-pp.shmem_get_folio_gfp
      4.22            +0.2        4.42        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
     12.49            +0.5       12.96        perf-profile.self.cycles-pp.clear_bhb_loop
     13.95            +0.7       14.70        perf-profile.self.cycles-pp.copy_page_from_iter_atomic


***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/fsbuffer-w/unixbench

commit: 
  654b33ada4 ("proc: fix UAF in proc_get_inode()")
  665575cff0 ("filemap: move prefaulting out of hot write path")

654b33ada4ab5e92 665575cff098b696995ddaddf46 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  32471117            +4.6%   33974569        unixbench.throughput
      1819            +4.0%       1892        unixbench.time.user_time
 1.201e+10            +4.8%  1.259e+10        unixbench.workload
      0.33 ±  2%      +3.1%       0.34        perf-stat.i.MPKI
 4.577e+10            +1.4%   4.64e+10        perf-stat.i.branch-instructions
      0.02            -0.0        0.02        perf-stat.overall.branch-miss-rate%
      6053            -4.0%       5808        perf-stat.overall.path-length
 4.566e+10            +1.4%  4.629e+10        perf-stat.ps.branch-instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


