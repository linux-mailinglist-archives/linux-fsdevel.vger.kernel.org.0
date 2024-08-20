Return-Path: <linux-fsdevel+bounces-26333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7AC957B64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 04:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9081C23A53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 02:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B56C25757;
	Tue, 20 Aug 2024 02:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3WMAh23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE717FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120570; cv=fail; b=meodWnS75DjrC9Wy0zaDpAmOQa3XR9UqGFvHzQ/c6P+C/htq7KVoBkOByQkqMRrtAc0FZRYFj0fGVwIYvzrfpIO6TeV6h74qTjqkwpl7wCV4zCnxj4bEKKQPz23/A/kYMD4gUKepT/I/fjfWqGdp4iyS/2budMFuCu/22b5YFnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120570; c=relaxed/simple;
	bh=fH2VAZy9MoeJi8XCgalaBq1dkXIFBSX33odd2IhEa2k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IukNC4OzX1jQgxb7/1/SpdwFgX1RDGdkf8pPcM+2oxsD4nkBP81crTDt6Uu6Vkb1Oyffisd4OpU2jkVpI+5qXpM0O8WjiMBJCrKxKyaK/aZYPG+RWtnvolD5yMwB0ycF+PjQS75yDJrWQ69eontJcoHJRqOviKm+tyq2/4rBtRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3WMAh23; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724120569; x=1755656569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fH2VAZy9MoeJi8XCgalaBq1dkXIFBSX33odd2IhEa2k=;
  b=c3WMAh23LtuayakdJMqrUQsrGIkq88u67a0sM9lIWzdPiMBAp5tq4+yV
   aiYrsUUgfWC/Fp3/LbfIC3g419Ubnf+n/Z14p0IRpSvmc3vL6CC0+fZRG
   Re0snzBYwtwNHmau46wHZIAum9uPLNswpdYV9/99ipa1H1sF2WtHOcq9b
   J8WQEMRe1vd70TisFbVzsTZ9XYqzgTupd7OwmRIqlTXBZljuYlsKvy2O6
   9S9Dyb8MGLuJNVwGS8e7gPQIBR1VaH/5Kyg1w4dzIAGRVd2Rr1xSkDN+I
   tf0wrmpsSIo55PFjjUfLY3Ks+wXBqW1qPZWqA8FjvVuO5vgHxmDhlEjQ6
   g==;
X-CSE-ConnectionGUID: 9fWA0P3zRpmUerNo5hXIZA==
X-CSE-MsgGUID: vgNlA0G/RQOapywNdl0vyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26193893"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="26193893"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 19:22:48 -0700
X-CSE-ConnectionGUID: s3G90X18T3674rgqUyxLlw==
X-CSE-MsgGUID: 2XkaGQ1YQj+gU4QyyGb8mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60896188"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 19:22:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 19:22:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 19:22:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 19:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EA1zwJF026ilnz+VGUqjF4C9X8+daiOJ64ujzQx8GAzq4llbG70qwpX/F9qdueec7QEsg7F7M5Rd8VgUgPIsxOiz/jCRKUY2esZIB6zwDJMb2c/iqtr8kWwv6kNVtXsOaogZf/JS3h3oFfoYPh9iebnikTnLfsAAjXPhH6b5Dx0nphhJw0HsBN6gj5yU8OZZk/QcacrWd7aZYdJnRwUDvwZ0sYx5ngchanVO1Q0R0qhaSIhRIFAyBfLIXXWPBxeN6J+VunnhH+ubHOMz1CFjfkQReRyRMR/BOnLMkTOAdzqcngi52VLO2Cy5IxqlSDsKEh72FM91e2VMpKjBxmOFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JriHIG7LjG/13Ss+tL/crVspdXpVL/nUM1p47rfmoEU=;
 b=Uzcf7Wtw0cADWIr64RAByHZ2DZNWUGz5SjbIZ89JWM0PnEcD2LAaR4eE5EzbvfoUzoMafh07GeaV0olzvn24WmtwDfBFlBNn+TccZBBDkhLBCH410XQrW18fJrwFDHd+TCA4OCN05yvcSYfeBlfAZ/qAUngsDFUXOIFItPC8wHl5aGrMFT3/PmpqQvmZUUtyuXpnaR/0rmZzVYTe+YbOUUwa9WP2saQVroQhjQLu+yX21fTL2l5hhvZBt0pOCRQPmNDS2SSRUc0ZHf3lwXyMrmwWwbZZWD0QwI9matCy7fV+mIW8PbdymKFB49vcrPJ+hQsaEJwihnHNG2YawP+RlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB7487.namprd11.prod.outlook.com (2603:10b6:806:317::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 02:22:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 02:22:45 +0000
Date: Tue, 20 Aug 2024 10:22:36 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [brauner-vfs:vfs.misc.jeff] [[DRAFT UNTESTED] fs] 6a0f6c435f:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <ZsP97JFBdih5eAIw@xsang-OptiPlex-9020>
References: <202408191554.44eda558-lkp@intel.com>
 <7d6d44078a6f7e5216a0c61f3c38e4e7cecd25ed.camel@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d6d44078a6f7e5216a0c61f3c38e4e7cecd25ed.camel@kernel.org>
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f85a997-563f-452a-be4e-08dcc0befa05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HetrTy7EgS9My733vmkzAdG9wfvfg3Wm/k8I2jbFq3vQYo25x4MbCADcrC7n?=
 =?us-ascii?Q?goB1bX8HTzH1LaFMtnCOTdyecwtIKvyjVYzB3NptSAAXoVegZVYIiGyw44gh?=
 =?us-ascii?Q?VtSLkYQUFnQVoh4xY0iWaPdA5z9eJ6/2GGFWfUgphblPSAj8lws6lWqetk2P?=
 =?us-ascii?Q?mvsZPOk4XochbicRiTP8lrbHeyq6ZAMDzwrRXw8igRIQG+NGQgzOqzsJZm7a?=
 =?us-ascii?Q?yMZ2WIkZ/Ib24aK4msXOlqJgnW1HSwW3nbkRxR9G/nMBM/SBYK/xlFz4yl/k?=
 =?us-ascii?Q?x0yEcH4gmuOvZ0NmL5xv1UbjygJxUzdQU9y6MS4557q37xBIo1iyi19Q/G9G?=
 =?us-ascii?Q?sMKS6GsIAGU6zOoFxiX4rhlVTznLZqFNHW0MXnUS8aBGoeafKDCcbg8iMrl4?=
 =?us-ascii?Q?WQdF808WeQdurHxJynBPTqV2IY+OybDIFNVuES2FTbXZynaN01Swf0Att7J5?=
 =?us-ascii?Q?XNyGgINbO1fArCSGeBrpzipashbDszP83Zd4VSAFpOn1lmr/z9f4XlJxFQTh?=
 =?us-ascii?Q?L1GEWTxyeAY08eleLabTyKuPqj5IolmjuMZ+dMmGDvRS67wH7KJkdMDkDNJR?=
 =?us-ascii?Q?T+WFZBL8GgH8nrP5cBpzHzKjc53XM8rszDWzANK5mr2NcIAVvTdHVzmuHh68?=
 =?us-ascii?Q?acNNQbycUA/Hg1CdU5HLn22Vcq0/3SpvoU6r7PBndDu7gB+GfRNbn9Yjouax?=
 =?us-ascii?Q?XpvspmCi6v8aGonjNZpIq1aGdMYIKwc5Xq9ElEo6cslMqZ55gybuR2qc07D4?=
 =?us-ascii?Q?HgjOxQHlC2d4qxjvCuvwGjXcNq10gEyNKNW3NO44ddYOgAXakIs+D/j+YH2X?=
 =?us-ascii?Q?5a9gbj9UYDxWL0ldytDF6Bsx/F9tUcPQz9JCIy0fU7iHOWql2MIX9EU3oy4s?=
 =?us-ascii?Q?HVIl0s5hLTLpDdRfGeJRpB/8QkhkulPVLbPZw/8JbGkskEhXWaDn2mLvejKU?=
 =?us-ascii?Q?3EO4uppUqoS6nQ4A8jr5LhdZM1VrcxiqGYuno08sTw3E2Yb1CxbEUpH+iUEt?=
 =?us-ascii?Q?qVNiAIa/2KHYX+DHzj3OvqeR0PCUGoFicZZibINkVMvKyFntq7NhAeWhnVoZ?=
 =?us-ascii?Q?bkt+k9+T04QZKtso1lVMYYJwCei3WDYaFPvVlUiAXKPMWjobtT5r+1ZQSPYn?=
 =?us-ascii?Q?EvjCI37EYdkQ3qhwNIOlkg/ny6gCoU1gAZfYXtIN6Osv1+drTazKMdSzg+QG?=
 =?us-ascii?Q?g7QmXeRy3WtV/9XSdFwo4+vVsWPO+s5jZ69aBApukvgSyM4vE06/eP5xuO59?=
 =?us-ascii?Q?h2nMFfmeWzbxhiBOpB0t7Kx9coe+OcsOAdU0Ufg+eUhl6cQ+Fh4d90IEP7d8?=
 =?us-ascii?Q?rCxYrnLqeLBTuuqy6DlWTOM15xIvS0tOYkl6zO+d1tmr/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GjD5WBJLsd78YeJPVBFMZ0Go5fZx4RiX+rlsDO/E3abwvZcAweASIx1LsN89?=
 =?us-ascii?Q?J+sRzcOv5l1AN+kTE2rUI/N0iEe+20hp0cGO37/GRH5+eCjnoNh2vIMQE4H7?=
 =?us-ascii?Q?r/rFSbwzePP+V09+OhYEuhcuoMm+otgJzAK1ySVDs4NfHYb83qqhsjrJkN7r?=
 =?us-ascii?Q?KgzW64BTIJ4Gr6fpx+R64JeDhuGHyaE9EEaK3PBg7dmdCY7P0SkCHtZYV6t4?=
 =?us-ascii?Q?mfJg5BKJZTbrhZ6v+i97/JYoJFgQHAU26fomqaw2RJ6Qj1P/J7LHt/5r0C6A?=
 =?us-ascii?Q?GF2ks5tcNx++VfoKRxDW6m0gotlaH/kVEmXWSqouW2HgG+LGQ0JjFBv7cTrY?=
 =?us-ascii?Q?+aZhUhywKdUQtRQ9Cg+b0uzupLbYMHDJXe9xbVXJFn762lZtUQj6Bfw7bH4F?=
 =?us-ascii?Q?u0elVZn3qPQHl4a6/M3kKI773Hbxxkk9ESLLsg5tPh7PrHsmxIGqZuGGds9/?=
 =?us-ascii?Q?v+df5YQVVv0GhWo8hxKw59cIkwyzHd5bOFJdFNQgpq/Gz4fKBQlK8z5clk3U?=
 =?us-ascii?Q?hD0wSOTM/FFkn7Ph1ByfCzyre2N0C06cHb57LlshvCWBLb6xr9p8b2yASw0z?=
 =?us-ascii?Q?Xta0haPDF3mKVaxbbchqYDoPfTlHvh5vN2jrY5pp8/wy07ZrcgHKZZzNmOE0?=
 =?us-ascii?Q?J61cVL/i5rA52ZYhUrS7pG113mUbX1UztgNYtZxWZVv0R5LkRfe9vw8DsHEx?=
 =?us-ascii?Q?BuHcPo9Jju3bKwERxZip76zwuwhMaVk3PfAq3q4hsIj86d/HJrLCLyWDrHAa?=
 =?us-ascii?Q?MuZgrcAy6XieIq6TmiXzH99VxgQCXVu7XormZL1lhZ8i9ohCenmITAyYoqqA?=
 =?us-ascii?Q?thalwK4iNsq2u7rEhhkU0AeX99sG0MMQIzIojvFcPJS6G7i4CvkVwtxzXutp?=
 =?us-ascii?Q?1rgzbXwIvF3ihM7CjP45c4mXzq+yg1JNMigSezBqxJJI1ociDmQRNeSyVBl5?=
 =?us-ascii?Q?yBznvzCMKS72C5lsyhovxTQpSoElkALdUF8Lc2QdjzjNIPSdQuBoIVsJR1Zu?=
 =?us-ascii?Q?ocbvKtz0x4EUqc6M5HjQXn64j2jXKxiHTlqh9UgkTeLqbDy5ekrzUiiWL5Iw?=
 =?us-ascii?Q?eakkfRtbKPumsrcLA+NaIU2MoxhYXEY0bJiC2jfVHFgHTTaQqeIKyi6touH7?=
 =?us-ascii?Q?NK213twxZLyWhj7Z0XWnGJxToqHSQG2xJMPrhGpVXZGJTaH1Ajz5dfwnre1b?=
 =?us-ascii?Q?/dgDSw4KM9Nt7EnVoz4y6w5Ye2kZH5ji95YlA42SsBWF0P/O3RfCu4yIjtiW?=
 =?us-ascii?Q?ubNktjL9EWZcfWsQsQfYrfZF35BRY9oJvf1RBvT6mKIGcwrt3LBwmf5sPkU0?=
 =?us-ascii?Q?/ULKDIDmaxKZkJuEWtBztJyxrKy1E/psKb639U/0ipgn09zIyOoIpaKPeZcQ?=
 =?us-ascii?Q?Vp84wbmCbElJCZBvmXyoWhWsW/oj+FXv/+hL+8bd88s3SoGiklUiLgerk+0v?=
 =?us-ascii?Q?kIrCtSasP2TesZ8q5REEJYrUVU+JE41oNPaoe8vwB9LjVTi6TUC6e1neJwev?=
 =?us-ascii?Q?ZPvWqGEH0W96j/TntoFE/a+jQ4rVkPOtEMAkud+L8xbWNCADvwqYOsoHNgQx?=
 =?us-ascii?Q?SSHJuUB+/3TIjaKHswVGb+dE0VQzykbhT+G1TPqW44SkBqVZgrw7Ps+0TjLL?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f85a997-563f-452a-be4e-08dcc0befa05
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 02:22:45.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVHdVArK8WGqVH4AKwxzp8N1wSlV4rn0fa8UzPHKYl7YXZwEREM65QX9eQhjq9BT3SkCIvL6SzhwH/2veNUS3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7487
X-OriginatorOrg: intel.com

hi, Jeff Layton,

On Mon, Aug 19, 2024 at 06:04:14AM -0400, Jeff Layton wrote:
> On Mon, 2024-08-19 at 16:23 +0800, kernel test robot wrote:
> > 
> > Hello,
> > 
> > we noticed this is a "[DRAFT UNTESTED]" patch, below report just FYI what we
> > observed in our tests.
> > 
> > 
> > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > 
> > commit: 6a0f6c435fb1bbc61b7319146c520b872bb3d86d ("[DRAFT UNTESTED] fs: try an opportunistic lookup for O_CREAT opens too")
> > https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.misc.jeff
> > 
> 
> This is an earlier version of this patch. It had a bug in it where it
> didn't properly check for IS_ERR returns from lookup_fast. The current
> version fixes this, so I think we can disregard this report.

got it. thanks a lot for information.


