Return-Path: <linux-fsdevel+bounces-31122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC9991ED5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60204282548
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E4882485;
	Sun,  6 Oct 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4wNIQbH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17D6CDBA;
	Sun,  6 Oct 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728224478; cv=fail; b=rb8QAu2fGaKzd0lhtPpaSfTWjbLYZohj3QyajkoqKzc6/VgM11NbvmoEMnqPtns4oY/L/l0Gjyz3putvSMId/yxSrRER7uE6BXPCbTlu/DiHx/0VTrmC7tXKM9RLpFGY4JkKh00DwL62fiS4i2KPdkIpVUlzj/EUbO7EWKNt94o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728224478; c=relaxed/simple;
	bh=tmdMo9V3KlqDxOyv/jg6ESjZ5Mh8Fyx9bGMRPvOe+Bk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=opySMidT2BJG7G88+KGwrbEN4g88bOrNFooGi7evEjkGYayF/gL5Pi7onNKBNHmThf6B2bJdROzGaAmbEsgfMQjLsIduVlzI4rFOO1hen5Mq3TZlTmJShPVeME9eBJTWOICENl+puSilc+6htXl3df1ZIPzYmjbu3hqZvWnxVy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4wNIQbH; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728224476; x=1759760476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tmdMo9V3KlqDxOyv/jg6ESjZ5Mh8Fyx9bGMRPvOe+Bk=;
  b=m4wNIQbH7CxQsIFp6D4smFJwOfkwRqQ+62Ml0YYIoifm1SdGTfw9c1qD
   uRW35nO3M91oei3tkRgkLugM5teE4d4qlvQzaI/yyqIozE/hbmjr3R69J
   CrjSq0UORaSemAqfsI1FIh/IRjml1fCtUFmjbXOj97qHCQrJRK5iGUaEq
   3Xa3FlHqN2XdG6ZJ8Ln3IO7x6K0LdPSNV4nb+Z04cEccXqBchvzw/eS+K
   7CweF0yZ/fI5N1U/bU46fo7B2no3AFGSiYGctWXqI85B2WjROhaac6UJI
   poIaD6pZcA74ouX0NMadbXwh/oSbbixBwCuEmGcTPvRaYMBT4NZYWNBrz
   g==;
X-CSE-ConnectionGUID: DuKQhhq/S7qwgCn678dPSQ==
X-CSE-MsgGUID: dvt0fQzMS+CrFp1cJASPfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="31266720"
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="31266720"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 07:21:15 -0700
X-CSE-ConnectionGUID: 1R24fO1sSRO3dY7VYNT+0Q==
X-CSE-MsgGUID: uTAaJ6nbRSCGnrcNXIVL/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,182,1725346800"; 
   d="scan'208";a="75350880"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2024 07:21:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 6 Oct 2024 07:21:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 6 Oct 2024 07:21:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 6 Oct 2024 07:21:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPNl/kzLVbb/Chu/p+yhLpXnyoLIc5fy2Fz91GYiyu0v4UKIcrAsMPBkttWJRTX5dtC6pm+HPijMokEGqaPuYx5wpe4tQ3vlLrYOZBKKZh1v79q0zznLKSSM1ubrk3zjC3lQnyJTTz89W93G47jID022mMs10bXd1apXA1Ijz5NNYo0izbZ8wMZet4c2YBW7TroPkJSJTlDQEdXpYKM0K4zJyX6RPj0N8ws/r0pkQg+5GFi9e/szObkt8uHoBhdztw0lfm/5uFbPF133p2b9ChM1ioPAM97Jk0BcXzVdKpJmqsiBd/gNldPaSUNxlwdJYLrfbol9lk6rka30BDKwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV/3QnsmaDt0l9Vg5dkDZIzRKaD5Bn6ivGdxG02HEic=;
 b=h5yOFqRK9jTEXM8ds3d0iXc66Bq4jnuUxjZH1vz+u6W/t3ZCTkPi6dfpNWTOnHMVLj5cnQ7PrAno29eRkNkAVC3D2GjF4plr4fvWhm61gDoCwVFwa+IJdhGeh8V6Q2VkdGzlcuQBwyMAX6p8pmzCzPWo5SVB7h1PGGmTfWVD9gkBMR48SiLcssT3DrMX9p2n++BOo4BcevP2g6zlMqyDpkrNUljGjxuL0TadOkBoaagI1OglMGaQsfXgtTkM0JzTWsX7/ApjiSftps4/uTSCYmB46NwxY73BRvOUL6KDO23tAhoq2vCImRGuRD7mpdHyoEHnkT0R8gOd+rIrMlSvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 14:21:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 14:21:11 +0000
Date: Sun, 6 Oct 2024 22:20:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, "Arnd
 Bergmann" <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<audit@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [viro-vfs:work.xattr2] [fs/xattr]  64d47e878a: xfstests.xfs.046.fail
Message-ID: <202410062250.ee92fca7-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: 959bd4b4-161f-4424-691f-08dce612209b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KYJ0sKGr619NQPAiECQeHXSRnpKja7h3eRzYSPCjHssGN+HGQa9AgAPC55LA?=
 =?us-ascii?Q?9erZCNNCRnMzY5nkmEV1B/bPS2u8cIttLOkxkgTB5oZ201+CQ3qLMlymV04i?=
 =?us-ascii?Q?QOWftRYIyAy+1CYFyASHesNDDMPbWa+8rv1aBjQ/zZMdD8GRuqxEKJOBiEBX?=
 =?us-ascii?Q?hSdRAD9kL38TG/Ups3fsr3ffBhguw3Rlpe8I8yG63YSd6rJKVeIQHAQlM2YL?=
 =?us-ascii?Q?VLnSqFUBdcdvPwoZufPTbfJ4lHRJTl9d6vANq7PZcQMpZUkl6lRaYzRXnre0?=
 =?us-ascii?Q?qWn1KbqpCV06iCfgBi4cqzIunUlSPlY76xa8y4E+Gqvz1e2z3ofq06uOwc8B?=
 =?us-ascii?Q?eA8hwYqdGB5byH2j60ngOFjIDe33Zw4TTcC3xnuRX/RyjO63hpVm71sQ65Vl?=
 =?us-ascii?Q?uVCSWEWWZL3lsN5U+Ac2H99KfL2T6jqvXcUmLLV25hujGqjrDKeeDK22qJhK?=
 =?us-ascii?Q?W9suW9mABMbV93ENfwJJ5D3JEEKODAaOD3Q0KeFG95zbbIxn2vlFOoX6FRy3?=
 =?us-ascii?Q?ageqRMepBdnLlH+ANIWLT2b3YLs3Pat62FC0YUmwilU/cTzU0KidVPUCk0L8?=
 =?us-ascii?Q?3XosGGJsdCzSAz7JIotJHjkLRp91bigRPv8c5WerrHu/h1QVoy4+r81mqJsE?=
 =?us-ascii?Q?xota0dnAPsI0IyaF35CDL8q8RyRXOVTL/n/rb34vb58X+icc+uGTc/0vSfQw?=
 =?us-ascii?Q?zsmnx7h6iyu+EcanzDy7B8GhlftbwhjUMtJ5p5qt+dtZAhtVSxKe5oK2RAVq?=
 =?us-ascii?Q?oZ/5d/X+fALlnOTxlTjctFtsPKmDVUI0RLNaXeryFvcwJboMRB34xuTIul4C?=
 =?us-ascii?Q?88++JILnvDBZwXeGGRahC8nTa4l0DnypmaMfVuY3/Dx2hxWy0xV9ubMcT0Rf?=
 =?us-ascii?Q?Rk6BCvNolGLM5h8xr4gwKViiZ3jD1GvRA7mWaMl9F+Muhi6/GWf3e974HSPZ?=
 =?us-ascii?Q?m3sowrneabpAGwJEFPpVjYIY7xWFPp2UXD7TiF++RW7kwQp6wi2loWA8Ia8O?=
 =?us-ascii?Q?DMUFyfpzjJDW/tAEuDZXrM5kssShOmz7yvLBEnENK6aXEdSBHkaP95SCDNXV?=
 =?us-ascii?Q?ZmDeJRxPIY6lDfFbYLPyxYqJ4EYnsKt2jCW54KHbJ38AoxTY3ie6l2T68gh0?=
 =?us-ascii?Q?WT7Y9gPIH0E0ok933e6ntvYx0+mRxxZTZTm2lI/IeydzLkJDe1y3mVZt9Y3C?=
 =?us-ascii?Q?xEOkLwXHZ3UTY4z0usL83d2wnJwqRK+psuo4Gll3dC8MCYY5DkIRuZXbteIR?=
 =?us-ascii?Q?yh8B+Zt6eWHeVxBdVJN/ptNqiyzw8hhsGhQXDuiPbj7ShKHNpyIjrNcuR+I0?=
 =?us-ascii?Q?PMM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJRulrdKhnUWM7HpnWq5Ub4cKva+2DCeBnKf5eR+A8XZKQmC1Tj5q70zB0u1?=
 =?us-ascii?Q?z5ddOdMkPXtuA8TevlS/HFVeEaXaWfX/4dPE4proW7diKdPEwyeeGx2X6uYF?=
 =?us-ascii?Q?GPZ/oP85zX7fWMPtUTs7nUAQSWJuBTCnPEseRHYJnAbL9UR4Tm1uFg8dDPjV?=
 =?us-ascii?Q?FU4KOTbTaKUovcizIzbEUO9x/TsxNjEacz6mScMeDwk59NLPaTOTT/+wdZfb?=
 =?us-ascii?Q?Pku1fQSkatP/yayTTvFW6FDworUd0XG9Rny6U0BWKhJdBixbPRq4kGCGc2CW?=
 =?us-ascii?Q?mOJiZACZnRixvB42z3GUcItgGZQzNfYL3LEuVM0gL14igb2+shGYgrw9qEWk?=
 =?us-ascii?Q?ilQttqnZDUmTA1tumo0YIRFZ9LXMWlpwY1JCk7Q0eQjDJSVzX9zEwZMi81id?=
 =?us-ascii?Q?8UsuPrY0ETXKtoYv4PG/2kPHNiCQyKqGMV2DoYrvcsO5AMSZLOPepg/SO7Lr?=
 =?us-ascii?Q?kwNhVMiHpET5Uza1VvadgqgUXk1uEHqhmObdHqhvDz4IrG78XJ5VOHdUOWez?=
 =?us-ascii?Q?D2DmYtccZc0LS8iAzYwUV3x+obYIrhHec99TQjyfaN6XWtCX6eICvI93rPSD?=
 =?us-ascii?Q?wOipktwVXkHc9zhUbCkQ9syqbqhocqQVxNqKgSUoWwre8KNPvBbNe9GjJ7/L?=
 =?us-ascii?Q?E+VNjm3Fjly+kBGiV4hcjXpvGJjBpt1g2mWQbjKPWqOFVgmaEgdYADSpI5n5?=
 =?us-ascii?Q?PwWY9AWpZ1nELMdfM9k1geU4w/sxYYFowcDqa7HTbyot5ES0ml/CklMcdtl9?=
 =?us-ascii?Q?ea7zJ4Eq3bE21mMIy4SXQGrcweoamkivSdfmBJkE8gjy/sMOBbIkiRyxrpRj?=
 =?us-ascii?Q?OPyw+Q1FfLAG6LHGMdiPp4Xky+okmrb11NYRJTVPBCbUDldaZh5TBEzeg2FH?=
 =?us-ascii?Q?9jLhbP37viA6gWfrSXjh3BX1pqoYZgsVUlM/6Ha2+pmzat7+g3p1PT09g25y?=
 =?us-ascii?Q?3bcSQD+XiC5eAkAa/65h70882yiX457h4NgO+BLf57dvq/0I2ng5Sq27vDSZ?=
 =?us-ascii?Q?rZklQMioXPB3uYlz3+Z1NgHIcevKgIPICuIsacd0oLc5zNb9594NMqU+ZAmN?=
 =?us-ascii?Q?Pi5mNeI+QNPeDeNp4Ibjcbo9YmP9vD0AUusq4DrCoAXRGan/RTUp/hBZ46hw?=
 =?us-ascii?Q?1gPHSKonzXGkdB0HQJv5OzSpw4oS5uNuAwxX5f0FpxSch5u1QcKldPUbJkFd?=
 =?us-ascii?Q?//vWcR2bfGczEZSY6j8b0Az2O7PiGTaWy9815SKXYU1Kq9AOp9TU/Cjkn+dQ?=
 =?us-ascii?Q?IlXhczX8aO4j4Wgqz2DsJA2pN8NFDHGwCeSBqcQ8MboAI5vbrFAh2oCvdOtF?=
 =?us-ascii?Q?EAAkqrar08lvCtrAoCWlWXBG9/EGUjbHLl5Y1bHlJgDcNHHXLEC0ZykKe3nA?=
 =?us-ascii?Q?LXHo+iH9gjrtMhpRRorVQ4nmy8cVq+4lwr2qVObBdbglrF+/muwMPmeqZHVj?=
 =?us-ascii?Q?xS9szyNAhl5NVnXT1jzZmIsDcj3WIp9jA+lvxmq5jkU034gv1wFNzqboZBJ9?=
 =?us-ascii?Q?+dUrb1SnukEPy7T5/YMjRzrCNX8bOxl5AWHUsi1ri8VLIoHf0Dody3mXdMkv?=
 =?us-ascii?Q?11GYNBmqwlGtqbQ1HgkcfbXQUPIALj1x7PHitCMYQpSfukzamaNotD5hhFm5?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 959bd4b4-161f-4424-691f-08dce612209b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 14:21:11.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr+V7q7MwKWeUB9QR+vo9HGqBnbgOhuXdX3nrOjLrtvH0fJaoEfdPDXTbKr/ZGiYeCYyKWtHnEZsFpm9mpCChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.xfs.046.fail" on:

commit: 64d47e878a8196f374879bfdd0ea754ba77682d1 ("fs/xattr: add *at family syscalls")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git work.xattr2

in testcase: xfstests
version: xfstests-x86_64-f71228e3-1_20240930
with following parameters:

	disk: 4HDD
	fs: xfs
	test: xfs-046



compiler: gcc-12
test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410062250.ee92fca7-oliver.sang@intel.com

2024-10-06 05:31:34 export TEST_DIR=/fs/sda1
2024-10-06 05:31:34 export TEST_DEV=/dev/sda1
2024-10-06 05:31:34 export FSTYP=xfs
2024-10-06 05:31:34 export SCRATCH_MNT=/fs/scratch
2024-10-06 05:31:34 mkdir /fs/scratch -p
2024-10-06 05:31:34 export SCRATCH_DEV=/dev/sda4
2024-10-06 05:31:34 export SCRATCH_LOGDEV=/dev/sda2
2024-10-06 05:31:34 export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
2024-10-06 05:31:34 export SCRATCH_XFS_LIST_FUZZ_VERBS=random
2024-10-06 05:31:34 echo xfs/046
2024-10-06 05:31:34 ./check xfs/046
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 lkp-skl-d06 6.12.0-rc1-00009-g64d47e878a81 #1 SMP PREEMPT_DYNAMIC Sun Oct  6 12:37:17 CST 2024
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /fs/scratch

xfs/046       - output mismatch (see /lkp/benchmarks/xfstests/results//xfs/046.out.bad)
    --- tests/xfs/046.out	2024-09-30 21:13:44.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//xfs/046.out.bad	2024-10-06 05:31:50.379495110 +0000
    @@ -34,4 +34,8 @@
     xfsrestore: restore complete: SECS seconds elapsed
     xfsrestore: Restore Status: SUCCESS
     Comparing listing of dump directory with restore directory
    +ls: /fs/scratch/dumpdir/sub/a-link: No such file or directory
    +ls: /fs/scratch/dumpdir/sub/b-link: No such file or directory
    +ls: /fs/scratch/restoredir/dumpdir/sub/a-link: No such file or directory
    +ls: /fs/scratch/restoredir/dumpdir/sub/b-link: No such file or directory
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/046.out /lkp/benchmarks/xfstests/results//xfs/046.out.bad'  to see the entire diff)
Ran: xfs/046
Failures: xfs/046
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241006/202410062250.ee92fca7-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


