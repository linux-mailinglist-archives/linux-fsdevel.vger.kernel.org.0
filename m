Return-Path: <linux-fsdevel+bounces-32078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5EB9A04B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0421C21900
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F9156665;
	Wed, 16 Oct 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Le4r0eGv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6652036FD;
	Wed, 16 Oct 2024 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068689; cv=fail; b=NUZB/eTJ/9hs4+fRoeAllw3JiO7xCq5OW/eXIOtRxWR8PvHhJ4rmkvEYp1BOtLqgBv+mef2e3iUWI19A9opzb2CaTo0/y+AfltEiPtg0q+Zbz/DrpfXFWu6xzAxm2P1Szf5b0x+64Roy1JY8c7rjtv7IVQ7qiOq5SYdce68nF0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068689; c=relaxed/simple;
	bh=Kud+v9QRowbu4p/jKs9aHBajRT10ugy4zJNSmL8trpo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pWmzc7TTzMemtioHwGauGQN7FAtBU44QJIxDwi3rAEHI4/roLXQ3Aqgj4x5bow9yDoC5exEuXhgli/Zo7uQ5N9tFFSRyPkI+x0AT8Ss8WgE9IFWsYGqgS19E7chP0wTiwJp+vijyffFN3WFGGi6vwU4hNf/le0s+KcqcH8TqoZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Le4r0eGv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729068687; x=1760604687;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Kud+v9QRowbu4p/jKs9aHBajRT10ugy4zJNSmL8trpo=;
  b=Le4r0eGvzRsk74AXl0bW6v7Pz5dTFSKagYXDW3Ob4wCLviYNF8nH4v7p
   hx/J1i6JKkTwUdKHtsCvUqf4Rl1Wx9+LaTSl14WHux1h8UOAGffis97LO
   yxiQKgtBQbL5EjJhEmFyiNWiesFh1jPPOlF82igbHQuZfe5ciS6ALO2SV
   jchC9WuJLTC2x6s5U5BJqP4N6np8hMCkvoKMta3dBXjprqlKydnSKli2V
   GavxQlNeJ+t5uGs0VZQLi8boc+2FU07sFUkXhwQpT07UerOlm7Lq2/x27
   zV2Klta6Nf5qSO6U/iN69Ywn5fNYVV2XGBJ6tBBD8jt9hROuww8ge+AbV
   g==;
X-CSE-ConnectionGUID: 6rt1MMTrQJOSOXOb0qVyGg==
X-CSE-MsgGUID: k1V4TcxLSNmkKzT24UDeAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39136990"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="39136990"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 01:51:17 -0700
X-CSE-ConnectionGUID: TiOThD1HTqSvknmkqJQlFg==
X-CSE-MsgGUID: uIaJ5dr0RT6n3qr29McSRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="77781669"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 01:51:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:51:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 01:51:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 01:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctNvWTKnmZr/eYVO9kh/Y7Oo0PGj+azJodX67RjdkaznW+s9VDRlfCUvlJXX0xpqEtCHiLnHqLEslqpX1SjSJ152pvdxMY+/kONB5qxXzvxjWOqQ83EyG3iZdBTgn8ol+weVYCNgRuacgYXfKuP5UQbTFYgWFJjyeerLaOi9naP+zrBgAmVsT0y7hn0/sGq/Xs5X5pOdVtLW1mJv7Z/G3Dbjy7hLcCxMo8Zt/xBeqHspuwEpyk9Cp9sSDpUZuoEQ1BdJmvbFSoSM4yBntA+JVq2IUULJisr9gfbkan2RUIiz9s6Ni3s6Pvyxwp84juHM1e+uaZ8CSVS+PzuPmfi/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGMCOg/kAzicvGRWIrs+nhArkorTd+Nd59rumJAdVMk=;
 b=AH+0QBaDO3yfZ83ne9IyMlzE4kgTduh6rjN7JcDZOadD+p2Rhj3y7PWudD0LPEjaqs5bdO2obSDCDmVe7ffTnDmFaRui8WNdHgtcX17l9XFQiHcy+QDTfFN4PPVaEegqJeL5KbvL/Xgy3PIPPmphGNWzR//rFpkTFz6k10xJCYGNhhrV7vV2v5TYJd+MAqa73wQMOCilrnR7zW9yfuz6tYFYemAgwX4X9707j5c8pmvLucBmhqMvebt3Jg8CQ6DReDbMGO2gM0o3mJwNCw4MpRwMoqa9gAuy8/92wOqllzQCeY8QjXS3KtQgDG2MkOMrbLepW2PFhxL3X4zpqr9iYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.28; Wed, 16 Oct
 2024 08:51:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 08:51:08 +0000
Date: Wed, 16 Oct 2024 16:50:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan
	<surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	<pedro.falcato@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate
 pid lookup
Message-ID: <202410161634.abca3854-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfda883-593a-4648-6ba6-08dcedbfad6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hHmHV0DErkHWM98aurRtFoCGweGJdegtTNJtaRjAHLtU2MEnPOLe6FdIwwtn?=
 =?us-ascii?Q?KwgcjjNa3f/pTftkOcIkUfCFYMSKPeIsIN7pOhBSx61XbwbdZFkiC5XN98Al?=
 =?us-ascii?Q?g9qX7m3cyPwOlqX046XvCGiuJ9WIY3uoSJLWCU/tWm03nA2DWdZuEfbVuyJr?=
 =?us-ascii?Q?+Y2mmAUexCIJ1E4UII2mf6oXlwJib24A0Rfb9O3HsaXFreMJJksZNyb3Eghy?=
 =?us-ascii?Q?LiLdzZL4M+1p4RDJnhF5h7bfDqd4hqlqYk/H6paoikDvjlqsEU7q508GDp+n?=
 =?us-ascii?Q?aLoY6BkmwgzpTd0pBAuqFseNjxShVAIg6upLFVYkiPv8a5Bg+RrYEZ1G2pKy?=
 =?us-ascii?Q?0Nx4fAr8riYJjB7sxKpnl3sV0Gl9fwbCo/S8iISxRskpoy1KzRbgtQbrbsaR?=
 =?us-ascii?Q?y6MZgu8i4LQHBi3D9uXUTiXcBi06GMCiYrqqlpWtWkXIV210IT4/HaFCQSOn?=
 =?us-ascii?Q?dygELsPGz/OKO1lTMtp8ziUFz50K7pqXs3qrE+WMoKDxi+1lxlt3+nWDE0Jh?=
 =?us-ascii?Q?wwg+kuNBRjLgWSFuDHrdBBfDrVEdpPNHDVInzAIeZLSV7tuPpB1vyr7VDQUB?=
 =?us-ascii?Q?kGAMyi/vou7CeQndjf7yFnczMen85+tjBnBgk1XWSS4sIevRtl2Rw2EJWPOj?=
 =?us-ascii?Q?GfJ95d6OTgRodFbQXbbflQiMVMfhZA0Md8Tni78XhiAKAzmlIA+xx1mPjzor?=
 =?us-ascii?Q?9eW2FhTacDgqpx6MhM6v2jrzfM4EaabFjvhXxVS8tv0Rc9kbZT/CI63i12gV?=
 =?us-ascii?Q?7S92c3PvVC5dY9l+sahELPdImBtGlxOD3PjPx8oB0ybs2y86RTE64r+2c0mS?=
 =?us-ascii?Q?wsLyG1a1QlCcQaslAY9aYtkDDvzOZkAPNZgv6sYXoU6tKMPtM08y8MXdRwcP?=
 =?us-ascii?Q?xJq6t6K4U/GHb6k5Ca+GQWsu0BLSOshjXB7zVnVQ440YXV9KJ7rnLEKOeLD8?=
 =?us-ascii?Q?wn3LZXT5mFL9Dh9kWc62f+IxVVyk5h16wo/QaS++MKypuT42G9uyORidAtHX?=
 =?us-ascii?Q?znxPa0rutQt5XqFCqlImCnj73Mx/WJ4qa2EqEYi5D2FzOt0F9SdeI4ciyp9C?=
 =?us-ascii?Q?sYEM5kS5LsF6JiFN4+BCenXOrs6YqgBUpX/z32a0DdrG0qpu0Qpbs6T8KC/i?=
 =?us-ascii?Q?aPiBSEh6NgSPMQFo9PLGMzxCVQSwFwgeNgOjg+EDSbSwTPi4lvwdd5MYHA3+?=
 =?us-ascii?Q?f6SjWOJKBA1d1gZNxsVfrX4038DhZGC/X8unhjpM4ECMuY8T37dmcH9T6CY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KD66rkdHXszFBDHmPu8HCrlzTyphkLYaPQJb+UMeiS/Xq2vy5/X72LjZXe2P?=
 =?us-ascii?Q?HuIM+k+rPMcP0R1k44vBTVv6ikJowyjUveQ79LaKiizj6V4yKIcEp+8rUw02?=
 =?us-ascii?Q?7zF4q+Xjr/pNW/VGcE0N5RhWivl7Yj+UgDj57f4u40xlr3ki2AIdwUF54V61?=
 =?us-ascii?Q?FdomwVo6WSmKFQcxDxrKushVpjBdwcd80pI5LZ4G4wESbKoyzbC7uhjnNVBe?=
 =?us-ascii?Q?fu7NG/epAvasaDjOQLSRnwdM8plIozipIXux/7PrxMsuEF6V1ec/Cw07wyPY?=
 =?us-ascii?Q?S1bevClvjz9/ULonn2LFI5wgOv/fHqqxRSoKsDxHNRfYEEpRh7by+z+pos4P?=
 =?us-ascii?Q?bEdGTormadhkDcAiNaKzOxv88iYbMRCXgRLs5WjwnS59njdch2qqqfgNVX8Z?=
 =?us-ascii?Q?3F2urs9crq55jcLUGUkq42AZIByRFhNkzI2g+JR3iNb4a5c0D6gLbsFwtSZY?=
 =?us-ascii?Q?vYAy0lRD9x2nF/QmM1SzIEQHZPN30HephTVKY5H99XwwlyApU8XkB/WVK44k?=
 =?us-ascii?Q?xgJsG54xdjK2Lj8s+sLFw0AgwGeI2EXRwQGLVcOLDumFS5AC47NOsG04j/cF?=
 =?us-ascii?Q?2pD4dT6IaJflmMA6R2Tx5akRtbgWfho8Bt8vBQC/FN9euNVNJpyZ2Y+w4/Xc?=
 =?us-ascii?Q?q2r00TqzppUML1OzkWDCOWsLsj58z9HI8ILAg9R5NtyVebiMoJQhn749MKTZ?=
 =?us-ascii?Q?OeC6juvM/eILrhnWqS+CXyr2ivRjPyAoHoZ27HRhB5wpNHcjZUHi6Bd49HvU?=
 =?us-ascii?Q?3pqSxWHhGhGnMTrzWHVIe1A77hwAEZj71Jna+f9eyUZdqG02/ukSK+kKYNg0?=
 =?us-ascii?Q?ynMkIkH6P6JvU+/yEqvJ6gGTNU2QPQ9W75+0ANuOSIUmk2A8GdNIdU4ROK1r?=
 =?us-ascii?Q?Po9qQ23R0pUfNGEakiNpHJ1ooTF3ivhIT0dudFtKKNq5rwCp34KWIMLnmiH2?=
 =?us-ascii?Q?QURrmrBuDHdGYZrkATRtYOwVhrh49j/hgh6K4eWkidIRbHweNMGhMQu4nbW2?=
 =?us-ascii?Q?NY0CF8si6oXGHsNAVau/Y+embgbnuMD08xjS/8V0x6gQK+hGNW5eOvnLGbgu?=
 =?us-ascii?Q?O+0UE43YloY7x+hqbbMdzLRFk9FCUD193Euz+dsMosCcy7ktKewZtr44Trdv?=
 =?us-ascii?Q?XfqW3ZSNuKz1PpIc2CkCTGOLgoemrY9Wri9adqNKYhQ079vRw4JFHTtfTb2t?=
 =?us-ascii?Q?xnvGoHTTsGj4T8Yld5VTkSio29Q8ZqDVA3HTVE3oA6Xw2mh3WPEENIkEf3Yj?=
 =?us-ascii?Q?kW5V0HYyo/eW26bDyu7FxqnXwlXTpFFAOofphFFigv96huJ558fAs3aac6Ng?=
 =?us-ascii?Q?xvFzYUfhHAogWgXREmouhDIJzpm38szJK0a2Uyi7EBEIAxZ7DnfLxMioAbIK?=
 =?us-ascii?Q?Oyr4x4AUUJyMpaKFhfjQK8bqmbbgIazpx0LypAa5I1/g/EF8YA507nTleP33?=
 =?us-ascii?Q?xNptG+vnLBNptccv8BmAT4jxY3XREN3DvvaiWfWk3425G0lhUkyu/FYlGjWN?=
 =?us-ascii?Q?uaVZyB6AMQsQlfoH3DB31aHJRJquyxlu1p5+AvfT7knX3LmOccSP5GOoIJTQ?=
 =?us-ascii?Q?ZzBxdXnWdSHQN1Mm7flyoCPGJuqN7tORRbSIeWYUfjA0u7MPcaiqOGkb1iVS?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfda883-593a-4648-6ba6-08dcedbfad6d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 08:51:08.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uiierz6v/+/20IXFVVEGGVgE/bIvczL7feFFvTcUNad8pGjEvbV6TeBXYqMDu0Mx9U32mTUcG67EaoQLE4x8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: e65dbb5c9051a4da2305787fd558e1d60de2275a ("[PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup")
url: https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/pidfd-extend-pidfd_get_pid-and-de-duplicate-pid-lookup/20241011-191241
base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
patch link: https://lore.kernel.org/all/8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com/
patch subject: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s



config: x86_64-randconfig-072-20241015
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410161634.abca3854-lkp@intel.com


[  416.054386][ T1959] BUG: unable to handle page fault for address: ffffffff8fed9474
[  416.055651][ T1959] #PF: supervisor write access in kernel mode
[  416.056550][ T1959] #PF: error_code(0x0003) - permissions violation
[  416.057502][ T1959] PGD 3e90f5067 P4D 3e90f5067 PUD 3e90f6063 PMD 3e50001a1
[  416.058587][ T1959] Oops: Oops: 0003 [#1] PREEMPT SMP KASAN
[  416.059414][ T1959] CPU: 1 UID: 65534 PID: 1959 Comm: trinity-c3 Not tainted 6.12.0-rc1-00004-ge65dbb5c9051 #1 d7a38916ac9252f968706afc2c77f70fbdabe689
[  416.061328][ T1959] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 416.062850][ T1959] RIP: 0010:fput (arch/x86/include/asm/atomic64_64.h:61 include/linux/atomic/atomic-arch-fallback.h:4404 include/linux/atomic/atomic-long.h:1571 include/linux/atomic/atomic-instrumented.h:4540 fs/file_table.c:482) 
[ 416.063578][ T1959] Code: ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55 48 89 e5 41 55 41 54 53 48 89 fb be 08 00 00 00 e8 96 c6 f7 ff <f0> 48 ff 0b 0f 85 dd 00 00 00 65 4c 8b 25 04 ff 0e 70 4c 8d 6b 48
All code
========
   0:	ff                   	(bad)
   1:	ff 66 66             	jmp    *0x66(%rsi)
   4:	2e 0f 1f 84 00 00 00 	cs nopl 0x0(%rax,%rax,1)
   b:	00 00 
   d:	0f 1f 00             	nopl   (%rax)
  10:	f3 0f 1e fa          	endbr64
  14:	55                   	push   %rbp
  15:	48 89 e5             	mov    %rsp,%rbp
  18:	41 55                	push   %r13
  1a:	41 54                	push   %r12
  1c:	53                   	push   %rbx
  1d:	48 89 fb             	mov    %rdi,%rbx
  20:	be 08 00 00 00       	mov    $0x8,%esi
  25:	e8 96 c6 f7 ff       	call   0xfffffffffff7c6c0
  2a:*	f0 48 ff 0b          	lock decq (%rbx)		<-- trapping instruction
  2e:	0f 85 dd 00 00 00    	jne    0x111
  34:	65 4c 8b 25 04 ff 0e 	mov    %gs:0x700eff04(%rip),%r12        # 0x700eff40
  3b:	70 
  3c:	4c 8d 6b 48          	lea    0x48(%rbx),%r13

Code starting with the faulting instruction
===========================================
   0:	f0 48 ff 0b          	lock decq (%rbx)
   4:	0f 85 dd 00 00 00    	jne    0xe7
   a:	65 4c 8b 25 04 ff 0e 	mov    %gs:0x700eff04(%rip),%r12        # 0x700eff16
  11:	70 
  12:	4c 8d 6b 48          	lea    0x48(%rbx),%r13
[  416.066250][ T1959] RSP: 0018:ffffc9000299fa70 EFLAGS: 00010246
[  416.067156][ T1959] RAX: 0000000000000001 RBX: ffffffff8fed9474 RCX: 0000000000000000
[  416.068377][ T1959] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  416.069091][ T1980] module: module-autoload: duplicate request for module net-pf-12
[  416.069532][ T1959] RBP: ffffc9000299fa88 R08: 0000000000000000 R09: 0000000000000000
[  416.069538][ T1959] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  416.069541][ T1959] R13: fffffffffffffff7 R14: ffffc9000299fb70 R15: dffffc0000000000
[  416.078460][ T1959] FS:  0000000000000000(0000) GS:ffff8883a8500000(0063) knlGS:00000000f7ef8280
[  416.079775][ T1959] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  416.080740][ T1959] CR2: ffffffff8fed9474 CR3: 0000000120fe6000 CR4: 00000000000406f0
[  416.081938][ T1959] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  416.083156][ T1959] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  416.084359][ T1959] Call Trace:
[  416.084939][ T1959]  <TASK>
[ 416.085461][ T1959] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[  416.088241][ T1964] module: module-autoload: duplicate request for module net-pf-32
[ 416.089149][ T1959] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 416.089165][ T1959] ? __kasan_check_read (mm/kasan/shadow.c:31) 
[ 416.089175][ T1959] ? page_fault_oops (arch/x86/mm/fault.c:710) 
[ 416.092872][ T1959] ? fput (arch/x86/include/asm/atomic64_64.h:61 include/linux/atomic/atomic-arch-fallback.h:4404 include/linux/atomic/atomic-long.h:1571 include/linux/atomic/atomic-instrumented.h:4540 fs/file_table.c:482) 
[ 416.093516][ T1959] ? show_fault_oops (arch/x86/mm/fault.c:643) 
[ 416.094304][ T1959] ? fput (arch/x86/include/asm/atomic64_64.h:61 include/linux/atomic/atomic-arch-fallback.h:4404 include/linux/atomic/atomic-long.h:1571 include/linux/atomic/atomic-instrumented.h:4540 fs/file_table.c:482) 
[ 416.094957][ T1959] ? search_exception_tables (kernel/extable.c:64) 
[ 416.095760][ T1959] ? fixup_exception (arch/x86/mm/extable.c:320) 
[ 416.096496][ T1959] ? validate_chain (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:3816 kernel/locking/lockdep.c:3872) 
[ 416.097269][ T1959] ? __kasan_check_read (mm/kasan/shadow.c:31) 
[ 416.098069][ T1959] ? kernelmode_fixup_or_oops+0x84/0xb0 
[ 416.099036][ T1959] ? __kasan_check_read (mm/kasan/shadow.c:31) 
[ 416.099822][ T1959] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:828) 
[ 416.100680][ T1959] ? __kasan_check_read (mm/kasan/shadow.c:32) 
[ 416.101464][ T1959] ? check_prev_add (kernel/locking/lockdep.c:3860) 
[ 416.102255][ T1959] ? __kasan_check_read (mm/kasan/shadow.c:31) 
[ 416.103036][ T1959] ? __kasan_check_read (mm/kasan/shadow.c:31) 
[ 416.103805][ T1959] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835) 
[ 416.104574][ T1959] ? do_kern_addr_fault (arch/x86/mm/fault.c:862 arch/x86/mm/fault.c:881) 
[ 416.105445][ T1959] ? __kasan_check_read (mm/kasan/shadow.c:31) 
[ 416.106242][ T1959] ? do_kern_addr_fault (arch/x86/mm/fault.c:1199) 
[ 416.107023][ T1959] ? exc_page_fault (arch/x86/mm/fault.c:1479 arch/x86/mm/fault.c:1539) 
[ 416.107781][ T1959] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 416.108538][ T1959] ? __kasan_check_read (mm/kasan/shadow.c:31) 
[ 416.109332][ T1959] ? fput (arch/x86/include/asm/atomic64_64.h:61 include/linux/atomic/atomic-arch-fallback.h:4404 include/linux/atomic/atomic-long.h:1571 include/linux/atomic/atomic-instrumented.h:4540 fs/file_table.c:482) 
[ 416.110003][ T1959] __do_sys_pidfd_send_signal (kernel/signal.c:3968) 
[ 416.110881][ T1959] ? copy_siginfo_from_user32 (kernel/signal.c:3898) 
[ 416.111737][ T1959] ? __kasan_check_read (mm/kasan/shadow.c:32) 
[ 416.112533][ T1959] ? check_prev_add (kernel/locking/lockdep.c:3860) 
[ 416.113327][ T1959] __ia32_sys_pidfd_send_signal (kernel/signal.c:3896) 
[ 416.115877][ T1959] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63 (discriminator 22)) 
[ 416.116669][ T1959] ia32_sys_call (arch/x86/entry/syscall_32.c:44) 
[ 416.117417][ T1959] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:386) 
[ 416.118224][ T1959] ? __lock_acquire (kernel/locking/lockdep.c:5202) 
[ 416.119009][ T1959] ? __task_pid_nr_ns (include/linux/rcupdate.h:337 include/linux/rcupdate.h:849 kernel/pid.c:511) 
[ 416.119778][ T1959] ? lock_acquire (include/trace/events/lock.h:24 kernel/locking/lockdep.c:5796) 
[ 416.120563][ T1959] ? __task_pid_nr_ns (include/linux/rcupdate.h:337 include/linux/rcupdate.h:849 kernel/pid.c:511) 
[ 416.121348][ T1959] ? find_held_lock (kernel/locking/lockdep.c:5315) 
[ 416.122114][ T1959] ? __lock_release+0x100/0x530 
[ 416.122949][ T1959] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:515) 
[ 416.123737][ T1959] ? reacquire_held_locks (kernel/locking/lockdep.c:5476) 
[ 416.124570][ T1959] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:515) 
[ 416.125359][ T1959] ? syscall_exit_to_user_mode (include/linux/entry-common.h:321 kernel/entry/common.c:207 kernel/entry/common.c:218) 
[ 416.126234][ T1959] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 416.127090][ T1959] ? __do_fast_syscall_32 (arch/x86/entry/common.c:390) 
[ 416.127922][ T1959] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 416.128760][ T1959] ? __do_fast_syscall_32 (arch/x86/entry/common.c:390) 
[ 416.129599][ T1959] ? __do_fast_syscall_32 (arch/x86/entry/common.c:390) 
[ 416.130419][ T1959] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 416.131158][ T1959] do_SYSENTER_32 (arch/x86/entry/common.c:450) 
[ 416.131840][ T1959] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[  416.132788][ T1959] RIP: 0023:0xf7efd579
[ 416.133446][ T1959] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241016/202410161634.abca3854-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


