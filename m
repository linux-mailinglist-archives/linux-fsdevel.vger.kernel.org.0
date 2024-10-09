Return-Path: <linux-fsdevel+bounces-31409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30548995DEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965CE2850EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 02:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907C013B58D;
	Wed,  9 Oct 2024 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CO4pqgmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76B20B0F
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442411; cv=fail; b=HMWh8PJFQE7uubcrEnZOYN7KrB8pcvF8H+fEunzzqEMZ/sAoJLIXfvCKJHaD2g73z7uDHD3h9LUJHCTrjkZxAAUHC1gfJHOmA2Uue8bHqkt83D3R8yJ3VgUnQvReaHWKmCR/OC7uqXqmcY4m5uEyAN6/GQB4laz+L9apvL7fxec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442411; c=relaxed/simple;
	bh=LlBO5P10CQRIjqNiV9xfsbgjbwuUdoF7+y+bqlt50zs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iD/OQ5Vgcyd7+HNMk40gO7AC79WWR73ByfJNq7f2v7s06ru2UCH0ippudA/C1yYSW8QXU7w0sfCj2scNk+LDt4UmLPqd21KHdctiYXWWCIOJIocKD3rqAfJZNCNHCTu+euV74jAJFe7/cJFFXKNVz7wNSV4NYpffTvd/xvF82hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CO4pqgmG; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728442409; x=1759978409;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=LlBO5P10CQRIjqNiV9xfsbgjbwuUdoF7+y+bqlt50zs=;
  b=CO4pqgmGK9iB4YuBGJ8ALdzfHQu7WOCqryoyGUS17tHBgSK5c5ntG3PK
   W7qvzKiu/0tWFrJDmiSzWM302JXuIuM4D53Eo3Dm3VnhzXdTBS/0XtTku
   k4/Y2OBgO1Qsk0tOA8gG8EdhMXYUjRACHARGoOZPYMRDPuRB4v2j67+Us
   PegQa+WJ1aHSG3j54AHiP3hErHm78CYBg9lp/zqiNO7vuEAOvaGpsdbRR
   9PhGB/eOXQVFmYilLNfNJMwuGuv/vp4fV97Wdjre+CDLgSg61Bjk/21Og
   ML78z2zlMs+BGXdL/jXiqiB9sTEKoniNdy0f/uAFIkSk1I5b7Ere/bFOf
   g==;
X-CSE-ConnectionGUID: b8CozvIdQi+k2TpgBlFyGw==
X-CSE-MsgGUID: IGRdJIZvQPKUK03AvaKysA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27197229"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27197229"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 19:53:28 -0700
X-CSE-ConnectionGUID: 2K/G6CEhRrSMAT/I02Vxig==
X-CSE-MsgGUID: /CKjNyG1Qy+K1jQ1tL6Ctg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="76528286"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 19:53:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 19:53:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 19:53:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 19:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcgeTSXoE7vaLiB9D4h3h3sLoQi5kyB1J3G+jqLqECbb7hM48W7P9PkFJeCGQvdaMWHCDihBinkrypsZtcWOIKlf+Dw5+ESLDShqhoEpxrcuQ+kIver55K4AbNRLr9iMbCOS4Z08OvoClJhYPE4PTbG5Cxlbx1Kta3GxSTPYUvbAWKor20mITfmgowpbTXyA+ImcajmHbnDcDwXZFlMk3jDo8l+puQHhtMGz+6vfEWoIOurXZAcT8l20/komd0cb5y38LCnkdn3QfBvWJrhSeOJkV80xXCYSj9/uLDbhgbw/EmPJ+uSdy6rjkt1JTu+LDdqg9Vqvi2k/A8xCNbVy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4S1OjWTB4sZdIQB95yq6ce4aShzDo7Lz6kck5R76HA=;
 b=EaXa/JSazvphbQggipCw5fcqDFBY/aNKGLEbdgcPfLucGeexaVx7JbXnJUJjXhSO70fHH50urSXRt+ATsUNMhYnhQSePd6QJHo6u1JCMUrVJOQxKhMHAH/rSqEZmrjksZ5tQe2qimowF9BUhkBl2y3BocXYBafRdLBWqG00ww0XcT0RcFAr2L0dpBkilnhBsxgalJVb4fDLKOGQIKztKubqn41/xsLgD3Kc7O2f8iCezpvw11SsFYobsuWvW+4HHa7r7uX1XFU6lylRsoUm9DILHC/Z7A8VDiJKuAHwJqmqYGRyMt/tjg7H7V1XiaZWQNo4eKogjWNpNvwkUVnyeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 02:53:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 02:53:18 +0000
Date: Wed, 9 Oct 2024 10:53:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, "Darrick J.
 Wong" <djwong@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jan Kara
	<jack@suse.cz>, <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  2e4c6e78f4:  will-it-scale.per_thread_ops
 -5.7% regression
Message-ID: <202410091041.6f5d221e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 81198b5f-5021-41ec-d979-08dce80d874a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?rvXMhuD+tgEeB89L2CdlAYSBmLm5sNurIazwpH2PrxmVcbUzX7dsFrk1WL?=
 =?iso-8859-1?Q?Bb20OP24UePrYk+Q3F1t/aJ+/3M9RbJ2Qbb2oWK+xxW/Of31RuTe66/zNr?=
 =?iso-8859-1?Q?lFSxyg+AMP9bAfLVWueh0Pgh/wWHpDzhwVi5943aIRb5OZqePTlwkdhOF0?=
 =?iso-8859-1?Q?lo0f+/Gav0nN6Ez/SWlHvhPUMzTwiGJaOfGynLMrJkX5SSpC9TiBnnqYXL?=
 =?iso-8859-1?Q?Dv8094LxzNx1wEl2l2RM5HTVcFFbT3gbBgXBV+aQTNGoIiE4AvEOn59K53?=
 =?iso-8859-1?Q?0Mf/r875aOyVs87CqEp+XXxFNV5elHH3c38wGZ7/2hMDQ/QptHW9/hZpx0?=
 =?iso-8859-1?Q?jXV5jNh3ysa9oLrbO/dFbikYb54nXyHjRhNVUR1Q62JVX61O3j3/e/lKK8?=
 =?iso-8859-1?Q?0AFil3SB4tkk0bL6eDGLuDuJ1NVIToK6v2iplivnRF5Zk399/hKbW58O0c?=
 =?iso-8859-1?Q?Ad2g5nzj6uzkG5GF5EgGN/odnyBvxsW5aBXQ28SdewAU+/fWHw2tbUB6rm?=
 =?iso-8859-1?Q?87ebzNBA/oERoYn0AZXJyzm9uSEbYBcQsa31XGcjbqcl43xt78vExAP1dd?=
 =?iso-8859-1?Q?CeGmMHzFC++/KGY7jOGGQ8Zs4tN7H41bm4FZ3fnKuCQHtaUAzYIOzWTc21?=
 =?iso-8859-1?Q?NJsD/XSMgjzDHddTg6CoevkYBU6CfUDXfUqEFzUDlOO/PTrEB4SO1AcYvP?=
 =?iso-8859-1?Q?HRwUyVLm5rhhgAV1nG32Grw1zZV5RTNm/rUo1zL1jWQhQMFk0hd2du1lD6?=
 =?iso-8859-1?Q?MGoW+3t/Orvxsy+PgLwBTEGuYzfM28BDwSgF1CeS8V7iZN0JWA5eYaXCUf?=
 =?iso-8859-1?Q?KK+WciLUg4iMEpCpYKcDELrsSRWqN0Ck4ZVek7uB0eGWbshXqPhCJ7uNXq?=
 =?iso-8859-1?Q?tb+ddHcr+f3iiHJOu186H/66UXUIJUBJ3kUXdvACtr5DzTdCNEdikIqvhJ?=
 =?iso-8859-1?Q?3y1OecJlGvjR8WGE5DIZPP97OIoMWWZlQClHCCsGPVCC7+FZVZhuznBAiN?=
 =?iso-8859-1?Q?H9kwIAtRnMahwfwAFbHMczAKEnkHevaHlRQfBnp1CQoHsJP3eHfL5w+h/v?=
 =?iso-8859-1?Q?40sUBcZQj1kRWhOd1ASS9Mq8aZGxeQQUhp5wdhzL0Rl3RqtJbd/Ek0XLIZ?=
 =?iso-8859-1?Q?6B4XV2Z1bgYYWqvdWOx4eKTot8aPJ9rkRPjUmhLYHFgVlA6Q6f8hPnKmvf?=
 =?iso-8859-1?Q?Bh5iry0GxqIHn0mLSsDCCM05wUphy12RVLQodLHaQlfM2T8B6oivFC2emx?=
 =?iso-8859-1?Q?z2GC0U4YVIqLEWRrGrG8kU5RRhgVWgdLUROpMKjAiw6YNLSv33tPXqi1Hh?=
 =?iso-8859-1?Q?w3FSd2UqqG/ZFGRyHDnY9akUky9icsttBkpYirRjsxbV/cQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nTJ3qf/UqsaE0PnJOzh23Mwrp986BT1DNlnHJsNlKk09v09/eTv9zZykUA?=
 =?iso-8859-1?Q?+TIrq0Qu6m2uag0FD1AjMBGy/MbJGNGRGb4T2Q7m8QO9WXnRcIuerZOXqd?=
 =?iso-8859-1?Q?EpdHHvH3ALYknFPV+HSZ0oJY27Sm5NoTMd9f+sVwanHwwS3C1YxyO51VjE?=
 =?iso-8859-1?Q?Jsbo4ewGJnjRsh0l6iDpz2k262sQ9ZpDEEfQxec762sT9QoRYKBCEbHTOg?=
 =?iso-8859-1?Q?a5hIazAnypPUnSFuLeEqgQl5OpGKJiCYxV+humgI2/U6jwalfLBjc7EIqV?=
 =?iso-8859-1?Q?TtHRiXHhOxw6FPmnQeE2BS7duPbblzbYZ3PZg9lhnQLKy+UHvc9Fkbroex?=
 =?iso-8859-1?Q?m+HGRvCdR32ce4Lnoeh6eeQLnU8Ur72Uv1xZ5K6W4tcjfK7Ny7KoWLO/iy?=
 =?iso-8859-1?Q?1PjiTMjMZwi+5YtxSESBWpWburmPrzJu5xbsFZFfQZIlVVhJ1H0y1whAMi?=
 =?iso-8859-1?Q?wDGT8eoud9TpW2d8EgziMTpWr+1a04UruawnQMTSPXw3f2IQuvo/kWWjbE?=
 =?iso-8859-1?Q?FZvnHzrp4GSd0Nyugg9IXvYERJUBBdZtzh8ahmnl7yPljPx8gATwml1426?=
 =?iso-8859-1?Q?pkVMxA4DvQwXlLBIIYi0lCboG5Sw/u4C24todNh10D9oI7XXGE3G+4rwq+?=
 =?iso-8859-1?Q?aw8iwLO3hrdpvsrnza1COOYEQU+5tnBVYkmQIgQnZyG5VRZwybL7Ip9OZX?=
 =?iso-8859-1?Q?9giLnU5OVB25WDIjRYtyHcht3vANN/bXoVpHj0uO0Qks+KjM9zrN0gKITQ?=
 =?iso-8859-1?Q?6mrnLi5vNcwXKJXt6pAx4t6OMPgpcR1EFT3gDjInrbkaKloGA+bLLNxqYD?=
 =?iso-8859-1?Q?S5hfjMwCYV7RiOoGwNMiglSWOXkrHNinO54CXXp4tR6DBwUs0SJ5iws2sl?=
 =?iso-8859-1?Q?0ms9OjSf7e3wag1m1ZVpzCEBWSmAntN29DU+oKSnjFT4Z+y4zchzuISzSM?=
 =?iso-8859-1?Q?cfEX0iFsu+IgfQfJeTBSxc+feBHpr9r0jMzLE+s8cjNDLB8WhHyPyCJ5/A?=
 =?iso-8859-1?Q?vc0i8XUO/xuiKYjHxYpBdRvfA9QfJoXtdYOWxnSDC0HPgLgDDN8uGJH8IZ?=
 =?iso-8859-1?Q?IE/8BqD8PVU8TUsd2mmvco4XDAZpQ82Tqs7i7t0Rb4n9VWxpA4owyIB4ci?=
 =?iso-8859-1?Q?XHNnfCRnc3096DvZNmdV6jOfkhDFJwB18GeZLvt9XFHLMDPfHcAFBnKeb/?=
 =?iso-8859-1?Q?38KiUUZZla6GqTqk/pYzkUWvu3rw5MC/MAEe5CiMAa1bSsUD9EFkA/UYhg?=
 =?iso-8859-1?Q?4L8BZ1MT0q+buZccEphycIiylg7n0bjtYjGREy/EqoaoZKJABT6GwQZZgS?=
 =?iso-8859-1?Q?9NFZ2p6L787mzzaWI+g6dmB382N1SXbbYgfu0ILeT5pfu1fSYX2xq8tgnS?=
 =?iso-8859-1?Q?0znHQjJBHkJOW2XkwbZqiMtktfGQlbsnN4945oZkIgXKp4Uh/dEjvJLrkM?=
 =?iso-8859-1?Q?OOgXAaKx7UovYBVCRVTFrLzdyeczUdUwaiECcFFcPcHh9rY+noo9JLHLjB?=
 =?iso-8859-1?Q?lk8PlckT79m372VCo23IzBBCnMrBWKZRvB89TcDmzTGUkQDaNH1uoDTmwh?=
 =?iso-8859-1?Q?n7et1w/LLxOkaxdSkmswYJv+Wmtjl8LfTIN47UgRqPr6TYprUFoUufqksq?=
 =?iso-8859-1?Q?O+JyWIkgDzW1S203zg78UvUJVmDwUR/xnx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81198b5f-5021-41ec-d979-08dce80d874a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 02:53:18.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdGakDNw7ObHtOhEZyJLdW0tM6uop5qxEZJVUsqeWtSNzsGZKZi2De0wMDD98dfymY0ZDE2vUixAmHTCoVETFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com


hi, Jeff Layton,

we reported
"[brauner-vfs:vfs.mgtime] [fs]  a037d5e7f8: will-it-scale.per_thread_ops -5.5% regression"
for this commit about one month ago.

we also saw you sent out patch for it.

now we noticed the commit is merged into linux-next/master now. besides
will-it-scale, we also captured a hackbench regression. so we report this again
FYI what we observed in our tests. thanks



Hello,

kernel test robot noticed a -5.7% regression of will-it-scale.per_thread_ops on:


commit: 2e4c6e78f41afefb7a2b825b7aa4d90070720992 ("fs: add infrastructure for multigrain timestamps")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: will-it-scale
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: pipe1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput -4.5% regression                                           |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                               |
|                  | ipc=pipe                                                                                   |
|                  | iterations=4                                                                               |
|                  | mode=threads                                                                               |
|                  | nr_threads=800%                                                                            |
+------------------+--------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -2.0% regression                              |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                           |
| test parameters  | cpufreq_governor=performance                                                               |
|                  | mode=process                                                                               |
|                  | nr_task=100%                                                                               |
|                  | test=pipe1                                                                                 |
+------------------+--------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410091041.6f5d221e-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241009/202410091041.6f5d221e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-20240206.cgz/lkp-cpl-4sp2/pipe1/will-it-scale

commit: 
  v6.12-rc1
  2e4c6e78f4 ("fs: add infrastructure for multigrain timestamps")

       v6.12-rc1 2e4c6e78f41afefb7a2b825b7aa 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    806865 ± 12%    +127.6%    1836795 ± 68%  numa-meminfo.node3.FilePages
     32494 ±  7%     +39.2%      45235 ± 25%  numa-meminfo.node3.Mapped
    201722 ± 12%    +127.7%     459227 ± 68%  numa-vmstat.node3.nr_file_pages
      8032 ±  7%     +38.6%      11136 ± 26%  numa-vmstat.node3.nr_mapped
   2657388 ± 13%     -28.2%    1907049 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
   2657388 ± 13%     -28.2%    1907049 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
 2.921e+08            -5.7%  2.754e+08        will-it-scale.224.threads
   1303879            -5.7%    1229301        will-it-scale.per_thread_ops
 2.921e+08            -5.7%  2.754e+08        will-it-scale.workload
    210109            +1.5%     213268        proc-vmstat.nr_active_anon
    222111            +1.5%     225492        proc-vmstat.nr_shmem
    210109            +1.5%     213268        proc-vmstat.nr_zone_active_anon
    164529            +1.6%     167080        proc-vmstat.pgactivate
      1.52 ± 82%     -78.7%       0.32 ± 18%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      3.03 ± 82%     -78.7%       0.65 ± 18%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     28.66 ± 95%     -75.5%       7.01 ±  5%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.52 ± 82%     -78.7%       0.32 ± 18%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     27.97 ± 98%     -76.0%       6.72 ±  5%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
 1.971e+08 ±  4%     +13.2%  2.231e+08 ±  2%  perf-stat.i.branch-misses
      1.11            -2.3%       1.09        perf-stat.i.cpi
 6.697e+11            +2.2%  6.842e+11        perf-stat.i.instructions
      0.90            +2.3%       0.92        perf-stat.i.ipc
      0.00 ±141%    +162.1%       0.01 ± 38%  perf-stat.i.major-faults
      0.12 ±  4%      +0.0        0.14 ±  2%  perf-stat.overall.branch-miss-rate%
      1.11            -2.2%       1.09        perf-stat.overall.cpi
      0.90            +2.3%       0.92        perf-stat.overall.ipc
    695559            +8.3%     753229        perf-stat.overall.path-length
 1.964e+08 ±  4%     +13.2%  2.223e+08 ±  2%  perf-stat.ps.branch-misses
 6.676e+11            +2.2%   6.82e+11        perf-stat.ps.instructions
      0.00 ±141%    +167.2%       0.01 ± 41%  perf-stat.ps.major-faults
 2.032e+14            +2.1%  2.074e+14        perf-stat.total.instructions
      7.01            -0.4        6.62        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      7.02            -0.4        6.66        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      5.52            -0.4        5.17        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      5.47            -0.3        5.15        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      5.47            -0.3        5.16        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      4.27            -0.2        4.02        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.87            -0.2        3.64 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      3.16            -0.2        3.00        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
     53.32            -0.1       53.18        perf-profile.calltrace.cycles-pp.write
      2.12            -0.1        1.98        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.59            -0.1        1.48        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
      1.12            -0.1        1.03        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.97            -0.1        0.89        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.72            -0.1        1.64        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.67            -0.1        1.60        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.18            -0.1        1.11        perf-profile.calltrace.cycles-pp.fput.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.98            -0.1        0.90        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.17            -0.1        1.10 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.98            -0.1        0.92        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.98            -0.1        0.92        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.97            -0.1        0.92        perf-profile.calltrace.cycles-pp.fput.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.63 ±  3%      -0.1        0.58        perf-profile.calltrace.cycles-pp.testcase
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.timestamp_truncate.current_time.inode_needs_update_time.file_update_time.pipe_write
      0.00            +0.5        0.55 ±  5%  perf-profile.calltrace.cycles-pp.timestamp_truncate.current_time.atime_needs_update.touch_atime.pipe_read
      0.00            +0.7        0.68 ± 11%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_ts64.coarse_ctime.current_time.atime_needs_update.touch_atime
     35.70            +0.9       36.58        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     34.80            +0.9       35.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     32.06            +1.0       33.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     31.16            +1.1       32.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +1.1        1.10 ± 16%  perf-profile.calltrace.cycles-pp.coarse_ctime.current_time.inode_needs_update_time.file_update_time.pipe_write
     30.51            +1.2       31.73        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.27            +1.3       26.57        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.06            +1.4       28.44        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     22.04            +1.5       23.51        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +1.5        1.48 ±  3%  perf-profile.calltrace.cycles-pp.coarse_ctime.current_time.atime_needs_update.touch_atime.pipe_read
     17.63            +1.8       19.44        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.70            +2.0       16.71        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.15            +2.3        6.50        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.79            +2.4        4.15        perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
      3.76            +2.4        6.13        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      2.04 ± 12%      +2.5        4.53 ±  5%  perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.76 ± 14%      +2.5        4.26 ±  5%  perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
      0.00            +3.5        3.46 ±  6%  perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.pipe_write.vfs_write
     14.13            -0.8       13.36        perf-profile.children.cycles-pp.clear_bhb_loop
      7.00            -0.4        6.60        perf-profile.children.cycles-pp.entry_SYSCALL_64
      5.64            -0.4        5.28        perf-profile.children.cycles-pp.copy_page_from_iter
      4.19            -0.3        3.94        perf-profile.children.cycles-pp._copy_from_iter
      4.34            -0.2        4.08        perf-profile.children.cycles-pp.copy_page_to_iter
      4.12            -0.2        3.88        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.42            -0.2        3.25        perf-profile.children.cycles-pp._copy_to_iter
      3.51            -0.2        3.35        perf-profile.children.cycles-pp.mutex_lock
      2.15            -0.2        1.99        perf-profile.children.cycles-pp.x64_sys_call
     53.53            -0.2       53.38        perf-profile.children.cycles-pp.write
      2.41            -0.2        2.26        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.21            -0.1        2.07        perf-profile.children.cycles-pp.__wake_up_sync_key
      2.16            -0.1        2.02        perf-profile.children.cycles-pp.fput
      2.03            -0.1        1.90        perf-profile.children.cycles-pp.mutex_unlock
      1.60            -0.1        1.50        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.73 ±  4%      -0.1        0.67        perf-profile.children.cycles-pp.testcase
      0.64 ±  4%      -0.0        0.60 ±  2%  perf-profile.children.cycles-pp.aa_file_perm
      0.77            -0.0        0.74        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.38            -0.0        0.35        perf-profile.children.cycles-pp.__x64_sys_read
      0.40            -0.0        0.38        perf-profile.children.cycles-pp.__x64_sys_write
      0.32            -0.0        0.30        perf-profile.children.cycles-pp.kill_fasync
      0.16 ±  3%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.make_vfsgid
      0.30            -0.0        0.29        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.4        0.41 ± 26%  perf-profile.children.cycles-pp.set_normalized_timespec64
      0.43 ± 13%      +0.7        1.14 ±  4%  perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +1.0        0.95 ±  4%  perf-profile.children.cycles-pp.ktime_get_coarse_with_offset
      0.00            +1.1        1.06        perf-profile.children.cycles-pp.ns_to_timespec64
      0.00            +1.2        1.17 ±  3%  perf-profile.children.cycles-pp.ktime_get_coarse_ts64
     30.76            +1.2       31.97        perf-profile.children.cycles-pp.ksys_write
     25.47            +1.3       26.75        perf-profile.children.cycles-pp.vfs_write
     27.19            +1.4       28.55        perf-profile.children.cycles-pp.ksys_read
     22.13            +1.4       23.57        perf-profile.children.cycles-pp.vfs_read
     17.81            +1.8       19.60        perf-profile.children.cycles-pp.pipe_write
     68.06            +1.9       69.94        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     15.02            +2.0       17.01        perf-profile.children.cycles-pp.pipe_read
     66.19            +2.0       68.19        perf-profile.children.cycles-pp.do_syscall_64
      4.24            +2.3        6.58        perf-profile.children.cycles-pp.touch_atime
      3.86            +2.4        6.23        perf-profile.children.cycles-pp.atime_needs_update
      1.88 ± 13%      +2.5        4.34 ±  5%  perf-profile.children.cycles-pp.inode_needs_update_time
      2.11 ± 12%      +2.5        4.60 ±  5%  perf-profile.children.cycles-pp.file_update_time
      0.00            +2.7        2.66 ±  6%  perf-profile.children.cycles-pp.coarse_ctime
      1.82            +6.2        8.04 ±  2%  perf-profile.children.cycles-pp.current_time
     14.05            -0.8       13.28        perf-profile.self.cycles-pp.clear_bhb_loop
      1.06 ±  8%      -0.4        0.67        perf-profile.self.cycles-pp.inode_needs_update_time
      5.00 ±  3%      -0.3        4.67 ±  3%  perf-profile.self.cycles-pp.vfs_write
      4.10 ±  3%      -0.3        3.78 ±  3%  perf-profile.self.cycles-pp.vfs_read
      3.71            -0.2        3.48 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      3.98            -0.2        3.75        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.89            -0.2        2.68        perf-profile.self.cycles-pp.do_syscall_64
      3.38            -0.2        3.17        perf-profile.self.cycles-pp.read
      2.91            -0.2        2.71 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      3.48            -0.2        3.28        perf-profile.self.cycles-pp.write
      3.06            -0.2        2.88        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.76            -0.2        1.60        perf-profile.self.cycles-pp.atime_needs_update
      2.03            -0.2        1.88        perf-profile.self.cycles-pp.x64_sys_call
      1.90            -0.1        1.78        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.18            -0.1        2.07        perf-profile.self.cycles-pp.mutex_lock
      1.93            -0.1        1.82        perf-profile.self.cycles-pp.mutex_unlock
      1.92            -0.1        1.81        perf-profile.self.cycles-pp.fput
      1.46            -0.1        1.36        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.54            -0.1        1.45        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.06            -0.1        0.98        perf-profile.self.cycles-pp.ksys_read
      1.19            -0.1        1.11        perf-profile.self.cycles-pp.ksys_write
      0.58 ±  4%      -0.1        0.53        perf-profile.self.cycles-pp.testcase
      0.77            -0.0        0.74        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.38            -0.0        0.36 ±  2%  perf-profile.self.cycles-pp.touch_atime
      0.30            -0.0        0.28        perf-profile.self.cycles-pp.__x64_sys_write
      0.35            -0.0        0.33        perf-profile.self.cycles-pp.__wake_up_sync_key
      0.28            -0.0        0.26        perf-profile.self.cycles-pp.__x64_sys_read
      0.25            -0.0        0.24        perf-profile.self.cycles-pp.kill_fasync
      0.26            +0.0        0.29        perf-profile.self.cycles-pp.file_update_time
      0.00            +0.4        0.40 ± 25%  perf-profile.self.cycles-pp.set_normalized_timespec64
      0.40 ± 11%      +0.7        1.06 ±  4%  perf-profile.self.cycles-pp.timestamp_truncate
      0.00            +0.9        0.89        perf-profile.self.cycles-pp.ns_to_timespec64
      0.00            +0.9        0.91 ±  4%  perf-profile.self.cycles-pp.ktime_get_coarse_with_offset
      0.00            +1.1        1.10 ±  5%  perf-profile.self.cycles-pp.coarse_ctime
      0.00            +1.1        1.11 ±  3%  perf-profile.self.cycles-pp.ktime_get_coarse_ts64
      1.06 ±  5%      +1.4        2.44 ±  2%  perf-profile.self.cycles-pp.current_time


***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/pipe/4/x86_64-rhel-8.3/threads/800%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/hackbench

commit: 
  v6.12-rc1
  2e4c6e78f4 ("fs: add infrastructure for multigrain timestamps")

       v6.12-rc1 2e4c6e78f41afefb7a2b825b7aa 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    561190 ± 49%     -33.6%     372781 ± 77%  numa-meminfo.node0.SUnreclaim
    137108 ± 48%     -35.9%      87915 ± 74%  numa-vmstat.node0.nr_slab_unreclaimable
 2.263e+08 ±  3%     -13.7%  1.954e+08 ±  7%  perf-stat.i.cache-misses
 7.636e+08 ±  5%     -14.5%  6.531e+08 ±  9%  perf-stat.i.cache-references
     18.89 ± 18%     -31.6%      12.92 ± 21%  perf-stat.i.metric.K/sec
    246747            -3.4%     238348        proc-vmstat.nr_anon_pages
    383468 ± 36%     -19.0%     310490 ±  2%  proc-vmstat.nr_inactive_anon
      2246 ±  3%      -4.9%       2135 ±  2%  proc-vmstat.nr_page_table_pages
    383468 ± 36%     -19.0%     310490 ±  2%  proc-vmstat.nr_zone_inactive_anon
   1231417            -4.5%    1175946        hackbench.throughput
   1179456            -3.7%    1136004        hackbench.throughput_avg
   1231417            -4.5%    1175946        hackbench.throughput_best
      5279            +4.8%       5530        hackbench.time.system_time
    954.46            -0.8%     946.55        hackbench.time.user_time
      0.12 ±  8%     -36.0%       0.08 ± 23%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.33 ±  4%     -21.5%       0.26 ± 11%  sched_debug.cfs_rq:/.h_nr_running.stddev
     77.21 ± 38%     -50.7%      38.06 ± 60%  sched_debug.cfs_rq:/.load_avg.avg
      1421 ± 27%     -49.9%     712.70 ± 26%  sched_debug.cfs_rq:/.load_avg.max
    251.26 ± 25%     -45.5%     137.06 ± 44%  sched_debug.cfs_rq:/.load_avg.stddev
      0.12 ±  8%     -36.0%       0.08 ± 23%  sched_debug.cfs_rq:/.nr_running.avg
      0.33 ±  4%     -21.5%       0.26 ± 11%  sched_debug.cfs_rq:/.nr_running.stddev
    221.71 ± 26%     -49.9%     111.18 ± 60%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    253.34 ±  7%     -37.5%     158.42 ± 28%  sched_debug.cfs_rq:/.runnable_avg.avg
    297.62 ±  4%     -20.9%     235.28 ± 11%  sched_debug.cfs_rq:/.runnable_avg.stddev
    252.17 ±  7%     -37.6%     157.31 ± 28%  sched_debug.cfs_rq:/.util_avg.avg
    297.28 ±  4%     -21.0%     234.70 ± 11%  sched_debug.cfs_rq:/.util_avg.stddev
    335.27 ± 11%     -33.2%     224.09 ± 23%  sched_debug.cpu.curr->pid.avg
    941.56 ±  4%     -10.3%     844.57 ±  6%  sched_debug.cpu.curr->pid.stddev
      0.11 ± 12%     -35.9%       0.07 ± 25%  sched_debug.cpu.nr_running.avg
      0.32 ±  6%     -21.6%       0.25 ± 12%  sched_debug.cpu.nr_running.stddev
    131.67 ±  4%    +1e+05%     134061 ± 52%  sched_debug.cpu.nr_switches.min
      0.01 ± 28%     -64.0%       0.00 ± 33%  sched_debug.cpu.nr_uninterruptible.avg
     12.54 ± 84%     -12.5        0.00        perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
     12.54 ± 84%     -12.5        0.00        perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.54 ± 84%     -12.5        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
     12.66 ± 83%     -12.4        0.29 ±129%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     12.66 ± 83%     -12.4        0.29 ±129%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     12.66 ± 83%     -12.4        0.29 ±129%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     12.66 ± 83%     -12.4        0.29 ±129%  perf-profile.calltrace.cycles-pp.write
     11.78 ± 84%     -11.8        0.00        perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
     11.78 ± 84%     -11.8        0.00        perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
     11.10 ± 84%     -11.1        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      7.42 ± 61%      -5.0        2.40 ± 83%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      0.30 ±150%      +1.1        1.43 ± 43%  perf-profile.calltrace.cycles-pp.number.vsnprintf.seq_printf.show_interrupts.seq_read_iter
      8.40 ± 41%      +5.9       14.30 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      8.36 ± 42%      +5.9       14.30 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      8.60 ± 40%      +5.9       14.54 ± 16%  perf-profile.calltrace.cycles-pp.read
      8.23 ± 41%      +6.1       14.30 ± 15%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      8.10 ± 41%      +6.1       14.18 ± 14%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     12.54 ± 84%     -12.5        0.00        perf-profile.children.cycles-pp.devkmsg_emit
     12.54 ± 84%     -12.5        0.00        perf-profile.children.cycles-pp.devkmsg_write
      9.02 ± 58%      -6.3        2.74 ± 83%  perf-profile.children.cycles-pp.io_serial_in
      1.49 ± 35%      -0.7        0.77 ± 39%  perf-profile.children.cycles-pp.d_alloc_parallel
      1.20 ± 30%      -0.6        0.57 ± 26%  perf-profile.children.cycles-pp.d_alloc
      7.51 ±101%      -0.5        7.04 ±123%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.70 ± 38%      -0.4        0.30 ± 72%  perf-profile.children.cycles-pp.lookup_open
      3.15 ±104%      -0.4        2.79 ±127%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      6.78 ±103%      -0.0        6.75 ±122%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.11 ±119%      +0.3        0.41 ± 34%  perf-profile.children.cycles-pp.free_unref_page
      0.54 ± 35%      +0.9        1.39 ± 48%  perf-profile.children.cycles-pp.__dentry_kill
      0.70 ± 47%      +1.1        1.81 ± 36%  perf-profile.children.cycles-pp.dput
      7.71 ± 43%      +5.8       13.46 ± 11%  perf-profile.children.cycles-pp.seq_read_iter
      8.60 ± 40%      +5.9       14.54 ± 16%  perf-profile.children.cycles-pp.read
      8.29 ± 40%      +6.0       14.30 ± 15%  perf-profile.children.cycles-pp.ksys_read
      8.15 ± 40%      +6.1       14.23 ± 13%  perf-profile.children.cycles-pp.vfs_read
     10.49 ± 58%     +11.5       21.94 ± 29%  perf-profile.children.cycles-pp.__cmd_record
      9.02 ± 58%      -6.3        2.74 ± 83%  perf-profile.self.cycles-pp.io_serial_in
      0.15 ±107%      +1.0        1.19 ± 53%  perf-profile.self.cycles-pp.show_interrupts
      0.01 ±169%    +635.4%       0.05 ± 46%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    506.03 ±223%   +1038.0%       5758 ± 92%  perf-sched.sch_delay.avg.ms.__cond_resched.switch_task_namespaces.do_exit.__x64_sys_exit.x64_sys_call
      2527 ± 37%     +34.6%       3402 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      5433 ± 62%    +111.9%      11512 ±  8%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      8727 ± 28%     +41.7%      12368 ±  6%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.16 ±221%   +1222.8%       2.11 ±101%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1543 ±223%    +338.6%       6770 ± 82%  perf-sched.sch_delay.max.ms.__cond_resched.switch_task_namespaces.do_exit.__x64_sys_exit.x64_sys_call
      8967 ± 26%     +36.1%      12200 ±  7%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     65.76 ± 67%   +3435.0%       2324 ±184%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      9232 ± 26%     +36.5%      12600 ±  6%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      9419 ± 25%     +33.7%      12597 ±  5%  perf-sched.sch_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      8740 ± 27%     +43.0%      12498 ±  4%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      8472 ± 39%     +48.9%      12613 ±  5%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
      9034 ± 27%     +40.2%      12667 ±  4%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      9461 ± 25%     +36.4%      12905 ±  4%  perf-sched.total_sch_delay.max.ms
     18705 ± 25%     +37.6%      25730 ±  5%  perf-sched.total_wait_and_delay.max.ms
      9525 ± 23%     +38.6%      13204 ±  7%  perf-sched.total_wait_time.max.ms
     17493 ± 28%     +41.3%      24713 ±  6%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
     17105 ± 27%     +42.1%      24316 ±  8%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     17952 ± 26%     +39.7%      25074 ±  6%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     18587 ± 25%     +36.2%      25322 ±  5%  perf-sched.wait_and_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
     17333 ± 29%     +44.3%      25016 ±  4%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
     16951 ± 39%     +48.4%      25149 ±  5%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
     17996 ± 27%     +40.2%      25232 ±  5%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    163.71 ±203%    +576.0%       1106 ± 90%  perf-sched.wait_time.avg.ms.__cond_resched.pipe_write.vfs_write.ksys_write.do_syscall_64
     18.58 ±223%    +986.5%     201.88 ± 64%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1478 ±223%    +391.5%       7267 ± 71%  perf-sched.wait_time.avg.ms.__cond_resched.switch_task_namespaces.do_exit.__x64_sys_exit.x64_sys_call
      0.15 ±223%   +2351.7%       3.74 ± 70%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
      2619 ± 27%     +29.9%       3402 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1593 ±223%    +360.5%       7337 ± 81%  perf-sched.wait_time.max.ms.__cond_resched.mmput.exit_mm.do_exit.__x64_sys_exit
      7248 ± 40%     +60.1%      11605 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      8913 ± 27%     +41.0%      12567 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      1658 ±217%    +301.5%       6658 ± 81%  perf-sched.wait_time.max.ms.__cond_resched.pipe_write.vfs_write.ksys_write.do_syscall_64
      1671 ±223%    +498.0%       9998 ± 50%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1581 ±223%    +473.2%       9064 ± 50%  perf-sched.wait_time.max.ms.__cond_resched.switch_task_namespaces.do_exit.__x64_sys_exit.x64_sys_call
      8915 ± 25%     +39.1%      12405 ±  7%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      9200 ± 26%     +40.4%      12920 ±  7%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      9433 ± 23%     +36.3%      12857 ±  7%  perf-sched.wait_time.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
      8838 ± 28%     +42.4%      12582 ±  4%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
      8520 ± 39%     +48.5%      12654 ±  5%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
      8819 ± 26%     +45.3%      12815 ±  7%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      9176 ± 26%     +39.6%      12813 ±  7%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      8699 ± 25%     +48.7%      12937 ±  8%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm



***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/pipe1/will-it-scale

commit: 
  v6.12-rc1
  2e4c6e78f4 ("fs: add infrastructure for multigrain timestamps")

       v6.12-rc1 2e4c6e78f41afefb7a2b825b7aa 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    816.00 ±  6%     -11.4%     722.72 ±  5%  sched_debug.cfs_rq:/.util_est.max
  33816990            -2.0%   33148227        will-it-scale.104.processes
    325162            -2.0%     318732        will-it-scale.per_process_ops
  33816990            -2.0%   33148227        will-it-scale.workload
      0.70 ± 63%     +68.4%       1.18 ±  4%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    506.90 ± 11%     -14.5%     433.43 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    281.17 ± 50%     -51.7%     135.83 ± 19%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1000           -79.4%     206.38 ±171%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.27 ± 52%  +18623.0%     424.45 ±117%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    506.20 ± 11%     -14.6%     432.25 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    999.76           -80.5%     195.04 ±183%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
   1.3e+10            +8.0%  1.404e+10        perf-stat.i.branch-instructions
      1.10            -0.1        1.00        perf-stat.i.branch-miss-rate%
      4.14            -6.8%       3.86        perf-stat.i.cpi
    425295            -5.1%     403763        perf-stat.i.cycles-between-cache-misses
  6.96e+10            +7.2%  7.461e+10        perf-stat.i.instructions
      0.24            +7.0%       0.26        perf-stat.i.ipc
      0.01 ±  2%      -7.0%       0.01 ±  5%  perf-stat.overall.MPKI
      1.09            -0.1        0.99        perf-stat.overall.branch-miss-rate%
      4.15            -6.8%       3.87        perf-stat.overall.cpi
      0.24            +7.3%       0.26        perf-stat.overall.ipc
    622217            +9.4%     680897        perf-stat.overall.path-length
 1.296e+10            +8.0%    1.4e+10        perf-stat.ps.branch-instructions
 6.937e+10            +7.2%  7.436e+10        perf-stat.ps.instructions
 2.104e+13            +7.3%  2.257e+13        perf-stat.total.instructions
      1.62            -0.5        1.15        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     11.67            -0.3       11.34        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
     11.68            -0.1       11.56        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      8.36            -0.1        8.25        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.write
      4.06            -0.1        3.95        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      1.46            -0.1        1.37        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.02            -0.1        3.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      0.73            +0.0        0.75        perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
      0.65            +0.0        0.68        perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_write.ksys_write
      0.80            +0.0        0.84        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.92            +0.0        0.97        perf-profile.calltrace.cycles-pp.fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.87 ±  2%      +0.2        1.02 ±  2%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.66 ±  2%      +0.2        1.85 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.22 ±  2%      +0.3        1.50 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
     21.79            +0.4       22.14        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.39 ±  2%      +0.5        1.86        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      1.92            +0.5        2.40        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
     14.97            +0.5       15.47        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     22.36            +0.6       22.90        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      7.84            +0.6        8.43        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.59 ±  4%  perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read
      0.00            +0.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write
      1.69            +0.7        2.41        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.40            +0.8        2.16        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
     10.52            +0.8       11.29        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.56            +0.8        1.34        perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
      0.52            +0.8        1.34        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
     15.50            +0.8       16.31        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.65            +0.9        1.56        perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
     12.82            +0.9       13.74        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     12.00            +0.9       12.92        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +1.0        1.02        perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.pipe_write.vfs_write
     11.10            +1.1       12.18        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.12            +1.3        9.39        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.13            -0.6        2.56        perf-profile.children.cycles-pp.mutex_lock
      1.40            -0.5        0.90 ±  2%  perf-profile.children.cycles-pp.__cond_resched
     23.52            -0.5       23.07        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.35 ±  3%      -0.3        1.01        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.88 ±  3%      -0.3        0.54 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.66 ±  6%      -0.2        0.41 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      8.92            -0.2        8.68        perf-profile.children.cycles-pp.entry_SYSCALL_64
     17.87            -0.2       17.63        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.set_normalized_timespec64
      0.15 ±  2%      +0.1        0.28 ± 12%  perf-profile.children.cycles-pp.timestamp_truncate
      1.68 ±  2%      +0.2        1.87 ±  2%  perf-profile.children.cycles-pp.copy_page_to_iter
      1.80            +0.2        2.00        perf-profile.children.cycles-pp.fdget_pos
      1.32            +0.3        1.59 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      0.00            +0.3        0.28        perf-profile.children.cycles-pp.ktime_get_coarse_with_offset
      0.00            +0.3        0.32        perf-profile.children.cycles-pp.ktime_get_coarse_ts64
      0.00            +0.3        0.35 ±  2%  perf-profile.children.cycles-pp.ns_to_timespec64
      1.95            +0.5        2.42        perf-profile.children.cycles-pp.copy_page_from_iter
      1.49 ±  2%      +0.5        1.98        perf-profile.children.cycles-pp._copy_from_iter
      0.65            +0.6        1.22 ±  2%  perf-profile.children.cycles-pp.rep_movs_alternative
      7.98            +0.6        8.56        perf-profile.children.cycles-pp.pipe_read
      1.72            +0.7        2.43        perf-profile.children.cycles-pp.touch_atime
      0.00            +0.7        0.74        perf-profile.children.cycles-pp.coarse_ctime
      1.44            +0.8        2.20        perf-profile.children.cycles-pp.atime_needs_update
     10.55            +0.8       11.32        perf-profile.children.cycles-pp.vfs_read
      0.56            +0.8        1.37        perf-profile.children.cycles-pp.inode_needs_update_time
     44.44            +0.9       45.34        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.67            +0.9        1.58        perf-profile.children.cycles-pp.file_update_time
     12.86            +0.9       13.77        perf-profile.children.cycles-pp.ksys_write
     12.02            +0.9       12.94        perf-profile.children.cycles-pp.ksys_read
     11.16            +1.1       12.24        perf-profile.children.cycles-pp.vfs_write
      8.18            +1.3        9.43        perf-profile.children.cycles-pp.pipe_write
     30.60            +1.3       31.91        perf-profile.children.cycles-pp.do_syscall_64
      0.57            +1.9        2.51        perf-profile.children.cycles-pp.current_time
     23.47            -0.5       23.01        perf-profile.self.cycles-pp.syscall_return_via_sysret
     14.02            -0.4       13.60        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.84 ±  3%      -0.3        0.50 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.82 ±  4%      -0.3        0.50 ±  2%  perf-profile.self.cycles-pp.ksys_write
     17.70            -0.2       17.46        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.61 ±  6%      -0.2        0.38 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      7.83            -0.2        7.61        perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.15            -0.2        1.94        perf-profile.self.cycles-pp.vfs_write
      1.88 ±  2%      -0.2        1.70        perf-profile.self.cycles-pp.pipe_read
      0.52 ±  3%      -0.2        0.37 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.69            -0.1        0.58 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.35 ±  3%      -0.1        0.27        perf-profile.self.cycles-pp.copy_page_to_iter
      0.80            -0.1        0.72        perf-profile.self.cycles-pp.atime_needs_update
      0.34 ±  2%      -0.1        0.28        perf-profile.self.cycles-pp.inode_needs_update_time
      0.26 ±  2%      -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.touch_atime
      0.46            -0.0        0.45        perf-profile.self.cycles-pp.copy_page_from_iter
      0.10 ±  4%      +0.1        0.20        perf-profile.self.cycles-pp.file_update_time
      0.54 ±  2%      +0.1        0.64 ±  3%  perf-profile.self.cycles-pp.ksys_read
      0.00            +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.set_normalized_timespec64
      0.14 ±  3%      +0.1        0.26 ± 14%  perf-profile.self.cycles-pp.timestamp_truncate
      1.28 ±  2%      +0.2        1.45        perf-profile.self.cycles-pp._copy_from_iter
      1.48            +0.2        1.67 ±  2%  perf-profile.self.cycles-pp.vfs_read
      1.80            +0.2        1.99        perf-profile.self.cycles-pp.fdget_pos
      0.00            +0.3        0.26        perf-profile.self.cycles-pp.ktime_get_coarse_with_offset
      0.00            +0.3        0.26        perf-profile.self.cycles-pp.ns_to_timespec64
      0.00            +0.3        0.30        perf-profile.self.cycles-pp.ktime_get_coarse_ts64
      0.00            +0.3        0.33        perf-profile.self.cycles-pp.coarse_ctime
      2.29 ±  2%      +0.4        2.72        perf-profile.self.cycles-pp.pipe_write
      0.48            +0.6        1.04 ±  3%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.33            +0.6        0.95 ±  5%  perf-profile.self.cycles-pp.current_time





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


