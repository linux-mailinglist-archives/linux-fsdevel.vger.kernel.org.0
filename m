Return-Path: <linux-fsdevel+bounces-52286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B28CAE10DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 04:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02AE189668D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 02:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9A85336D;
	Fri, 20 Jun 2025 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTRf/xlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22757A50;
	Fri, 20 Jun 2025 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750384874; cv=fail; b=BCJn0CjFxGyrNyAbuqwIB7kmVYmt6bQ6DZ5exR/ax80lyKmC1m2sQIid0Q6Uo/lYloTwHUg4nsGeAIc1lRWYBurnqGT7SLgexSbqpnXNBVR3l3fP+fA6CxNdTt+EBd6w9wCDPTrst74Je5wtjkHGyXrMp/wb177VXPsSG8+m04g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750384874; c=relaxed/simple;
	bh=IXIpvZk3fhiwXBlxP+2tzN3k02JsEfsk3caUi9NbaHs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U1tMYlwFm1PlTxn0kF6jxJUbWc+6acEKlATDO/sdzOm0HfEgPpSECy60lAwTQRD8qtyHD0ty6cwYKC99jEQ3TF31UcBIE96GCfPeG6LefEGIhVXQUxidEctnJSy+oe6xn9w1rX7U5CLzSmqgQ+jrt6pTVUVC/qIxBy4/LZLygpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTRf/xlE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750384873; x=1781920873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IXIpvZk3fhiwXBlxP+2tzN3k02JsEfsk3caUi9NbaHs=;
  b=XTRf/xlEWtLav5GFW5kGUcVmemFTgzoSEEezYH522SiC/V5LcPPNlsaL
   TtZjT9/hbVW+JcdEoP3IOlPS3d8kX7cn12f2Niv1jaZkMbuvgKXSivcyD
   161VbjRd9nXNoJ8a159QewQbZcMOQUA6hm+DVrLW64KSG+vPQlPOozKFp
   xJZzX8svHpb23mMFScyKOsbH9TvJla/i6z7bp0p/T8oTR6JQuV9ClQjp3
   BClaNGNTcffN2OCDtUCU2Nsd51FXONu0IuNUmuuhPjM5LNTu19/vnga/t
   wE6h0nDNB+1KJ83m18jw8Lgo5KsENzIXg6b8rQ8M3rHPM6kOcnOLITOc5
   g==;
X-CSE-ConnectionGUID: Wsn72bzRQ+q+TxeB/PvZPg==
X-CSE-MsgGUID: e5/0GN5GSnGEET2DlmxlHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63995561"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="63995561"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 19:01:11 -0700
X-CSE-ConnectionGUID: slYfNjD4T1uWed4SW0q7nw==
X-CSE-MsgGUID: bRnX3nETRDKtPU7OXMaNPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="155156673"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 19:01:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 19:01:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 19:01:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.77)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 19:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyQIBNc8cQp4fIA6bYm81NAycOGSXzBExsSd4yBVfOBl4Fomd2T2xg3OkcMTlxj26+X34tiFrXAChkCZWoWqpUGK6BQYNdyfa01mk2oM+oNVS3rzxkzHY3lO/h3YZ94Tm/E77kQ6nSX3W4qC8VM7LsornorYpAXxcxQbc+VjCHTZmQ7Mn+rBHke1x9mRdGeVFAkqROLb3tR8yQ88u4fR1Rzv7SXRN4L6opH2E9UitsthIkehP2GGlGxpRv3dHHxJtE/6s1UP4mknSKxaN/cZs6/VddyXImLxya9HHaNiRuGhX15wI5PYBQuyZvX0szHW3QVsNHi+hiI3hbwtvyl6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Px7fHdKnwQFXRotkimnI+e+eXCDews1753V9QR5NknY=;
 b=JoKzouVDV/+Fh37f1n5uixJFlHjyIukXhoVgpfOh1fm36N0vgotuj9uzSdfJ3dnJuy21JowseI/jDBpyyV8n6UQPZ6YyjVtBOVPxXmvvh5pNNiiZYJ5Aue3hqoL85NCRKKd14sRGh+3+0oxPRFbuzqcsFt206jA03q0ZlmyAali1/vIS78sl0HoRxi72AvdoS7ftpDMI3QjZgTIWdDq3tOUNGBNQCb9H9muHXtfUIvUwXmNyL9it6kL1+442nbYOJkcc0ZLSx1oFydYgAuBUk1p4Y2M3p6w2WhXSjAgtzNbOlM9oPubQbRPxgCV51/fRclxE8WvrJnEDYF0yTsF/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6262.namprd11.prod.outlook.com (2603:10b6:8:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 20 Jun
 2025 02:01:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Fri, 20 Jun 2025
 02:01:06 +0000
Date: Fri, 20 Jun 2025 10:00:56 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [brauner-vfs:work.pidfs.xattr] [pidfs]  e3bfecb731:
 WARNING:possible_irq_lock_inversion_dependency_detected
Message-ID: <aFTA2F1ubYQX4sLA@xsang-OptiPlex-9020>
References: <202506191555.448b188b-lkp@intel.com>
 <20250619-rennpferd-annexion-f24c89ba6088@brauner>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619-rennpferd-annexion-f24c89ba6088@brauner>
X-ClientProxiedBy: KU1PR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:802:18::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1779c949-a953-4b5b-9b41-08ddaf9e5130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d8gPWhbbjwSjAdcRnpgm0KKBVhmC95G2Xvua/L3SVARuBo2rn4by0IVRq6kV?=
 =?us-ascii?Q?Wu+KpH1HyiPJH5nKoXVC2EIi5ADQVkHtMD7h2Q/qgOCIA1gPI2ao1narCc3y?=
 =?us-ascii?Q?BqFHsYFoN5r9QkWtZVMLcr0Jg7M+nYOWFHmjeNFfyuD1/FdylpDt0eaLaJ1h?=
 =?us-ascii?Q?e0uDfvV4cJms7n+C+0IbJEH5qilAF2eACdvznOmmpn41axWJKPWDQ73yRZKU?=
 =?us-ascii?Q?qLr58xwssvEwpz0O9W5ZT6ge0hEzq+eSqDuPuMzz9WiA0mMpn8yW3Iqa1kE2?=
 =?us-ascii?Q?W3JGeNNBF+KWfacZZQ7iS8vbvp9hT8hYwiToD/FC/2FiBK9CfE0m3rmzpLip?=
 =?us-ascii?Q?p8Iz/om6q+YnqwuHiSW88TH27tlbnw7tbpdb6BztkDM0FhzPe9C33MxhU6ly?=
 =?us-ascii?Q?Te/jTaUurGXELneL6IxD52vqX9bjqmhdUP93kaaJddt6R3a/rDiCn0vXebwk?=
 =?us-ascii?Q?JXAnwhf4D1UE2sMm7ipQF0+Rkna3V8R0IxBPUtePn2yPM9y85Jo3YbmCAj4+?=
 =?us-ascii?Q?bk5BIXUZlgg74BnskTBkjFiI1rkE0LB3d/zlTmzg0GHUDMOjQEZgX9B0rikd?=
 =?us-ascii?Q?uMao6QIyxA6+xEaS1bbNgAAK9udALRDkv6qWHNOoJVxrfoIP6OraXKvp4shm?=
 =?us-ascii?Q?ThkxXji1ijVrBr3CO5bkZiLadYzKWOpaNqqG4NfeP5e3bUp495T71lm2MFVb?=
 =?us-ascii?Q?6ZF/zKe+gcf+9po26Xq+En6S3TZHgo1/3pP99NMrEy5QBO6RsEhAgAZP3lpo?=
 =?us-ascii?Q?I/Gz2f8LGUvK74cG5s32cYPjVxPF4Po0VrLjRZrNb0ouafM3HPC/3Rx+OOov?=
 =?us-ascii?Q?bwuEA+MlKXdzSUUBa2I1oU7XnGBDuvcBH7GdGElgepKeTi5ligIzQ83nZcWO?=
 =?us-ascii?Q?UsIKjsnFPKLP2SMQ9Ima3RAQUvghee+edFfHotSWeF7xEM++Zvk4rA89ureN?=
 =?us-ascii?Q?Whgoly5NP1DRW6wwdZ66D4h/jjL+fBVugY13hGg7LZAXjysU++uG98qariFE?=
 =?us-ascii?Q?s0leXH/XcIWAqxPrPD/RaMs53IT9X1f4EoNtDf5NCiiXxzkSjzzNlB7sS6jB?=
 =?us-ascii?Q?zw/2Ie2ikFkj9YvkJIJh7r1HqtS/FRW1nXBVbCKKLILVcrBJV02pap0tr22G?=
 =?us-ascii?Q?nuPLgiMmqDJ5ko78jA0JGTNEK6ICTBsXnFwRThZr87PWHplwM8jJXkvZ3Tme?=
 =?us-ascii?Q?p1pbAwzhsF/cbSd5nJ15kqJ6bMeq1ypy+V4q+W1sPf3QYlABFLqu38+M3ST9?=
 =?us-ascii?Q?laL1DrRabfN3boRbrU/F2qVqZPkwfSDAv0FIGDeejPKRcVG6NuOminppCWP8?=
 =?us-ascii?Q?7bP3EV+G8fi588cFjHl2E6Bq+VTutM9zH/lMjdFCn6Puqg4IK2Ekxx3i9upA?=
 =?us-ascii?Q?UqhBdzGiDafdS96U+xMZf3POSTduaZmn8AO7V5RoZCywX9X99nuYlDpJY8/x?=
 =?us-ascii?Q?Atze3SQ8MAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LapWxgRan0hOqQH6VzTIuKl4niBHZIeh0s59ETYPc592AhQsegpCkkUJ+KAS?=
 =?us-ascii?Q?emBF6JQwhLtkp0/WnLhLsL3W9oDgbqfzh1ry+WZeoU6FEX2HjRAR0Dd+ALYP?=
 =?us-ascii?Q?Qj/65bX2NLCfY+BU5VI6bB8SMxfL3aVZ8krewMKI9Wl6MwikmgM/WnXjhYiy?=
 =?us-ascii?Q?JhN4iT1XLMQDJw9FKZ3h0O4nvyfo7LJYFfjnTbiB2+g9c+zYuHG6Ul8McMfM?=
 =?us-ascii?Q?zwLgsyArRXV6YZwDyfE/DLeb6NkOc5r7u64YcbAQ9o40vzg3Z8prpwYLUQ1w?=
 =?us-ascii?Q?hq57LLFJGVT2SYzuTSR87q2nrQPHstWYTCJ0kBdiA5q69JVVK4x30uPAlkVz?=
 =?us-ascii?Q?GyCfAWJHo95/mAEHFDYAFUGxIVFxu+XTU0725T2QpGzBAeWH5mAFM0r5A15S?=
 =?us-ascii?Q?3w52MVbYSDT9dhIBWPUWbSs5oO3oYuE6lwDpo0kxeocxxI/ZgCFdfkTw++tN?=
 =?us-ascii?Q?JTX6QRZpmWnhXm8g2l1b1lArVR5tbUNH6fuapipopAQ+WbH7p4l8Ckrux2Gu?=
 =?us-ascii?Q?qTfDIq/7a6TBmspudE4zwQHBb3M8AmVwJONU1wWditnJGOPoD0yx5u1srcCF?=
 =?us-ascii?Q?qLCqzzb18Vf9sIbph7D8bsyEXVnn+erHIl+0j/hxgwGjFlPU6NKIEn/kgODr?=
 =?us-ascii?Q?tLmasrEF2hmtD0uCjRle5f4AxwXYWsIcRyraAXq8TGQtnZy5l6wO0tO5py/1?=
 =?us-ascii?Q?Ah60+4I/cqCtsbHwsFf1J19AGi6CZiCCypss53RSKLLZau8VJdAWieBKGy9d?=
 =?us-ascii?Q?5LXTHaFBa0lNeTzEmUP1bBLsyMdFOpYC8JPRgMJuHk1TYUxR0PlZuoeetbt5?=
 =?us-ascii?Q?z9Nby1wV8ojS5YZON6FQnem0PUrnVHLPmULuDeh4lWjQ3ficDhNzShN1/T0J?=
 =?us-ascii?Q?Id1At3uGV9OszVslryCJIafjFYbRPcbvJhc/A9N5Oa7cyFYXF/D7o5di7G01?=
 =?us-ascii?Q?XYUufUxX0gThpsGjk0gnD8bGjESnrReEm6CHsT3B1/tp3mx9qSiGOhgwEVAk?=
 =?us-ascii?Q?uOjvniVuv0/BJiEbVCvXVqgw1aqyTe9h9ffhwz1JQxmmNYk2TYJ2NcRh8MWH?=
 =?us-ascii?Q?LR3aOGsIGZ1WpW1KcoF7Ff5bBwDmTZSBZcmBrA3Em67OqfsJDmMa6F5W0sYr?=
 =?us-ascii?Q?w4fV+pbBY5HZ4r/BitBKJ8C1Cv3e6zCnSmHm9ZoI2u02B17R5hRiWkC6tgC8?=
 =?us-ascii?Q?ayuv7RpxhOJUQySGvt/kav1Cbf/9pOnV04WQfwUpIQMnhrVU0+bGHZHBfQq+?=
 =?us-ascii?Q?IB+22Gn6h86oCGU/WuOszYuyTJ35rgmtlabO0sNvSpoT6rX/0Cu0TAWfCsFF?=
 =?us-ascii?Q?Opj7AxVZxp2f0B/dQgMxt1jZVpSBFA4TTZvGNaXX6nKhk4tcWvIm0HmPnl/s?=
 =?us-ascii?Q?APK5VAeroYXoqBBFPY/11lNWIjuklufkactiA5YPAPruzUPiQUFNldVfLrX+?=
 =?us-ascii?Q?/No8EAD73ePgxqEXGFhPlGhLm6Qh1K6T99tJuK9sfOiI4mUfqH1eBDvUXyLM?=
 =?us-ascii?Q?0RhQKBwgwIxE3sYag3oOJIOo0av60qEhZbQPhlKcpY3s4qX2XfvWYe1o2uVB?=
 =?us-ascii?Q?cex1Pgnd1pbwXIMRqXGmFqbZbbMQFIpUOjRfkwvthhWSvU+50Kesfw9vZ8b7?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1779c949-a953-4b5b-9b41-08ddaf9e5130
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 02:01:06.0005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7Z0czteBGnuNpzMo1Hkwu1dkL5/TAuolkjdKN63G+ud5etPn5uB6pfjDbd9bqriETazDXKyRUSwNJ+/lS/P0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6262
X-OriginatorOrg: intel.com

hi, Christian Brauner,

On Thu, Jun 19, 2025 at 10:43:53AM +0200, Christian Brauner wrote:
> On Thu, Jun 19, 2025 at 03:27:28PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:possible_irq_lock_inversion_dependency_detected" on:
> > 
> > commit: e3bfecb7310ade68457392f0e7d4c4ec22d0a401 ("pidfs: keep pidfs dentry stashed once created")
> > https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.pidfs.xattr
> > 
> > in testcase: boot
> > 
> > config: x86_64-randconfig-078-20250618
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> The branch is irrelevant. I can delete it so it doesn't trigger kbuild.

thanks a lot for information!

