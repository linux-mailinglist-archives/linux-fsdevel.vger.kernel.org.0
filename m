Return-Path: <linux-fsdevel+bounces-46638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B59A925C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29387B4C1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF06259C9F;
	Thu, 17 Apr 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUhEcBsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A092571BD;
	Thu, 17 Apr 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912940; cv=fail; b=lR64KF5LIQTDtPLfw16bH3Q8jKQNDf+Cae/NlHBoSWo3Jlw9Yr04BcWUv7vNpZjhep2nPbA8MJGvqkxhY0Uvv+9jozovZX/OL7nRn7TEPoa1yE460zflf9/V7Hwtr4XMx84txx90kYw+UZ3bB9WqI93u+01DZKhf4UfXuRFz9uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912940; c=relaxed/simple;
	bh=zhNaWddMm9xpa+hkAllmaUoFQt3EK0+6jq/4j5b5L+M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=StmIzyrhA5WTn5R79RGtKGcoUkhfc5Y39+9g5+OGwlJcTehrUDq4hnTvdiQc3mYZ+pgTuiwImRAkBg6AK5yGOiitc8qqHHoJUBdDq7oJT8Qt+dlSJQV943jAfww6nTh7/Y9NFg4/Di8U0pS9Ce1pSuQFfauQkqCQv/dVBAlVZXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUhEcBsm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744912939; x=1776448939;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zhNaWddMm9xpa+hkAllmaUoFQt3EK0+6jq/4j5b5L+M=;
  b=jUhEcBsmrV5xNko+oQk/2j+mLOLqcQHp8EUsfink9WvvpSDWZMeH5ODQ
   o8djZemOph69bzkfFMSBGObk4MM5R1CyGF+WnMJSn0GSfqyZP3vvycJvQ
   gnWcqoadXqcvvl9fvyOFLrpSQBjJhkV928ycN2YtOY2GGjGJjM/8MjaLo
   TjNeXH1wTqt5xbM+pZZ0B9vIMzXSCIvbz5kitEM/Uvyv9H7iY7J/IFzQL
   cMGd2kcwJcD7IQ8mS+BUBbF3edzt2U+Xbl5CiMEZK3bMjLcg1JD9Sie14
   F5023OCegvnrxpX1erW22c1n6z3tWClGBPJ1BNgz/k0abK8lQpePWNrJY
   A==;
X-CSE-ConnectionGUID: GCytVDP9Sperx5Qde9ImhA==
X-CSE-MsgGUID: pf+ySMe4Rgm6NIv1U7AbtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="69024760"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="69024760"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 11:02:18 -0700
X-CSE-ConnectionGUID: G35VfcwhTuO/3k/Y/hIXvw==
X-CSE-MsgGUID: SLk4LCadSGmYHusmv0ZfVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="131194137"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 11:02:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 11:02:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 11:02:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 11:02:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuwqVyssEiQKqLKCb60XdTRL8vbV/fFTnAjLMNECECz7WoNAp4i0u4271g9bx687DG+1gBtQeTxErJJjZ3jFciQ//oidJQpIPfbuhj9yvZW6zswaAosJZbBUk90t/QJgPl2t9bhTg+LWUO5eOVqJKKqxflOIGqr9x7H265/d9sl/AMRt9wVlx++WKIJjVESseVkuwSDYwcnsapmfFke7ozysqrXqBz9F7NGhegNZ0bhE8zJRb0iv4BR1C/5blnvADC2ommmpy1RA9lAHoXlY3AU3RI2pHs0NinW9xSgRLV+p7NYZOriLScHwwOcBVuG5uRthT0HsT68kSZ3aQsQTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoVWgLbWKgxGdg4lbkYBKlxf0qDlagZbxkBGcRi7lTk=;
 b=VGIELAcGFDomA8rD4Pjg/q95/Re0rIfQSytEh5MR4ycMtETDUZpCEiAYwBOAhY8HgqnayySnfJg0ewnoo66xEUDs1XsrrxONayMbJ7jZfSu5922pKpL18IEgatvMpoDSldp1owwpqrXPuirzX7HoADjFHRLsiGeBmdl4u7MvjQOujBOio5Lmw+v29MFHYujyTmafEJx2r0gJbNnfrYo9BELIV3h0Tvv0zwEBSGpT/NYky3QihxGRGZAC+tTvk4eVV7Zu4PL4lfVwUijJJfcsTBbCTrb7R5JbCFtP1co4LnTArENCBtph1dhpdozZu8KJuf+AiToIl6TchtsftB1j2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6380.namprd11.prod.outlook.com (2603:10b6:510:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 18:01:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:01:57 +0000
Date: Thu, 17 Apr 2025 11:01:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, ", Darrick J. Wong"
	<djwong@kernel.org>, Alison Schofield <alison.schofield@intel.com>
CC: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Dan
 Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
	"Alistair Popple" <apopple@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] fs/dax: fix folio splitting issue by resetting old
 folio order + _nr_pages
Message-ID: <680142129141c_130fd294f7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250410091020.119116-1-david@redhat.com>
 <Z_gYIU7Nq-YDYnc7@aschofie-mobl2.lan>
 <20250417034406.GF25659@frogsfrogsfrogs>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417034406.GF25659@frogsfrogsfrogs>
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f048be8-4332-4505-5648-08dd7dd9f1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4AuS5dNKJ9r4bUWyY3SZX0VqaYw55pn6FZfRuBx6ONVlCJQzU+TCUER9ou4C?=
 =?us-ascii?Q?ipSEZLInyQniseBg37RryZg0zm2VryKrueXkQWv2ciTHnJLZni5CpoGNKPkz?=
 =?us-ascii?Q?cyFZkXnRfE36XifyXVF2jXA3unr6IAeEBPvRKShmv8FhFt9LhZMNFOTMsGzU?=
 =?us-ascii?Q?yfrM9QIuB6uvG7A022tZVlAbe8v4VCZoVv/8waLIZtIVS/DQTJyIe6ddLSPV?=
 =?us-ascii?Q?xoHj6/1laBt9m7VzKzBDicQGDqS3Pd66qMmg17zix1zjcXHRD8UNT2GZ8Owy?=
 =?us-ascii?Q?s4Urdk06BjQxI/nVPWDkrzgchCErz85pFgx/ULuXKrRVjIvuSciTzCv7HNgw?=
 =?us-ascii?Q?hRf/X6GRpWYnCKZXFtrKcNX0rCI5eIHVh8/JMRDVTlmYbO8NyHR2exLc1A0E?=
 =?us-ascii?Q?8/dE+2Wbmj3c4Hss0e13T1OiROGQSdVOASNfJDV+N3UibGRfl5EVuPVxH5pp?=
 =?us-ascii?Q?97TzNesukWlFKq+EEEPiXRgk9bWiregCwla2iT7DhjeUPmtr+fdok7QvgP9v?=
 =?us-ascii?Q?YmdEQaEl+CWE74iJKrwrngsWNSoGhMZ3i2zKu0wv4KR64kby0On7ghabH1L3?=
 =?us-ascii?Q?oK63bv20o9sqj4fSc0qzF6h9+dV/py6edmHKwQfkoiFBWGgNxIOXiYlPubUF?=
 =?us-ascii?Q?unptBSEXWgbx2gc4GUzckOGnSiqKvjmk8mTWZMUgiIoighjbj8S2pZ4x3LtX?=
 =?us-ascii?Q?qcfBPb5O8KRM3G/0Lbz58kKCyauLxwd3E5Rv565y/X0ln7k/dD8/50xxkIkM?=
 =?us-ascii?Q?nCRQrCwkhFw5UYVOHqGxxRBy+bhXjoXf2osJ+/FdBmoi/F89B6b6beRKd5u6?=
 =?us-ascii?Q?2xS2E/eM4ROMIqurnvN92QHDaS6t8KiYy59usqkqY6nqrkQq7bf5R0UJK30B?=
 =?us-ascii?Q?Ue8tZxfD2X0LnW1DuT7rxdjrZMb/vqmFHYJQJE5EsEmoxIv8iBUnFqaImC66?=
 =?us-ascii?Q?gV0GAuDMy2OFEq7ynP1EHcfPSQeJPV25AyTJv27qrtAtUOubslwVgpkBR/Ul?=
 =?us-ascii?Q?+/8ZQL3eszLWkfFiqFYieXlA29VbDB19cS8FOddvRz/EOUmRWVOIs17hJG9G?=
 =?us-ascii?Q?sKrLS3EFtf36lr74ARDTQPcVOcHAY5WCAtxemDkJmxrqOQxIpdQRzvoRpxUZ?=
 =?us-ascii?Q?pYBBvRv3UicwqYOg6Zp//eXvhLSqDr/jz3KHLVU+JRJCMkzBWLJnevW5zcLV?=
 =?us-ascii?Q?VxBSUV4Zqvchfd6Ez3f67jS2Fthq2AXAaIh+d0JCwtbD4J1dxGgNUiA1xstw?=
 =?us-ascii?Q?MorJbGSPIpXmssCnKVG01TuwZ8k/sn5KlrNa8eiMzbNVmpArI8tqJxNJ7Kot?=
 =?us-ascii?Q?LTOrlDVk38c9tRZWneZE3AY7Ghyg95qivu28wrM1LlMr31pbcr1XgmbgS5O2?=
 =?us-ascii?Q?tTQkOqUhYtH/PD6RNvW0xUvyMOSZSPoU/86vJhWsKvcaV4PKdIMXvGaVh3+W?=
 =?us-ascii?Q?7MI+7bTUlIc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vuGQXLYF5R08E+fUkGDPS4LqmmKN1gW+XoIotaVkqFk4sJGVJ/OgyD6q2pV6?=
 =?us-ascii?Q?kwUQxdvYhrCAmDzK9fzwRDitOSNSBxI9UMrz40nRjS7rA04F5SBDkBZqraTC?=
 =?us-ascii?Q?qogQ7M3m3NAIY9WBUqNUhMcflop4O7fT874Fb5vnJbBB7FX77ngK1G1I5ddi?=
 =?us-ascii?Q?cO89n/Sd9gMtTj/Pr3RXc1l9ApVBiR81JKjXpkzZNTC58Dvb6XJIjKK3uKZR?=
 =?us-ascii?Q?NpsaJj1pkdmOs6mo15Losy6z4dfX/+HJF81dqZaKhJ+amPl1DxRdeoP0aD17?=
 =?us-ascii?Q?+XwWjVpB51YPKkN2oSq0L2BP+GHyli9Ibd2GroAmHKKtj8VHBNG+yVXX3d+k?=
 =?us-ascii?Q?rDJIcgIlCiHp3CG5I21b0N0tJx/8ezuPsopQJnUL0I9rv8Zlbs1kSEfLVP+F?=
 =?us-ascii?Q?BdrVR1NY2Rh9nsXp0v30hxSgWCjaXtQoX49ygBYXtjlGRP7NwxGbrpvpNUEN?=
 =?us-ascii?Q?B3rxwoUE22jD/rILPw8oBHx9rQ3CGRMUG7dENr/jB/PBWJkinPVYy3BaWa43?=
 =?us-ascii?Q?gnaJklPAINT4Dk4rm3voj0D786CggjKgEtSrJaH5WINOwUDYb/BMewt71xup?=
 =?us-ascii?Q?v9nDbd50IL2cQbVSTKo5cTVOmtk2aarq2XLpI0UmIOlSsQLXu4eRAQ+Teurh?=
 =?us-ascii?Q?kU1G2YW+9kGQPN7ghFHueqPLnRtl+OCWc7TU4e6/lavPClAhZLJ14TM4hLle?=
 =?us-ascii?Q?WdPSpHC7bbkppAQG+u0Y6nNONlYHBtTmx2Q1pwdhZ2z5e2c+bRfbxW7/xiuI?=
 =?us-ascii?Q?ek3tVUHLW6fb7/5Zlt8MgJbTyULJSfNz82QCecvLX0Gm/XCWFJb8HvBSBlGl?=
 =?us-ascii?Q?MSpor/1kWKYE4bGNtCmuEVUqEgaIVHfV7f6okEvpuZQZJ97gKLBQychxbYWA?=
 =?us-ascii?Q?qvEIVXbSgLGojOu+LzuxIW4cuqK9FEmftdSPK90H0uNobgIdcOVN0LJNZQDb?=
 =?us-ascii?Q?1FAQ8oVHRv1PrGqMinIbsDqX1N1OiUO6VD91zzyORmxkUb5xSmHCxgqxvN2T?=
 =?us-ascii?Q?/Pl+piHUBPwloB933wTaX4OBNgIX4cXMjvEWGUiTQOQBgV6GLuA60JhxSijn?=
 =?us-ascii?Q?Um7QbcQQfctszI0aLe9/j+8u8Q/NhzwADLYVrAQuwkgEoz9RkvnwndUq+8iO?=
 =?us-ascii?Q?XKZhYJCcqwJ+W/8hCrLB9xV5PpdwPO3fNafyAiwbzssVeAKMpG5ub3lsnVCx?=
 =?us-ascii?Q?Xt6tWYNCgAO5cF2t3/JUEyTeEDPZjvV90xjj11AohS2pcQLfVl7xYOUBoNSI?=
 =?us-ascii?Q?Q/dx03LHkeFwwduvDnyXoOxPFbPYrXRb+xJVQTGm0S+L0aXrY315ISCcPNYs?=
 =?us-ascii?Q?fNmewXoR0EtRMhro6j0x//GWk/bJN6t9SmjUv6xNgDn9F6Mh1y8nbmYHd7/a?=
 =?us-ascii?Q?vA7mv7lBZ7tFhZ2CzTtAHLkLUZEzU905JJZqclcA2Z1Z3/73RQOe6QEsivJz?=
 =?us-ascii?Q?O1MvoaUSBQBUrxIQ455cwSQuGd1xtkAYwQjh4V7t+vQ2K63s2svw8f4+tTQq?=
 =?us-ascii?Q?wcfSp4IY5Tpm38wAdPkIVXyAAmKaZ+vS46FUlSaGixOi3vMdY4SWC9qajF0X?=
 =?us-ascii?Q?bBeZvki1MDM1fu789R0j9olvgwtKFt/FqQVyojV1iLqUzP0iSwucL5yZfieq?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f048be8-4332-4505-5648-08dd7dd9f1cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:01:57.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oC5OCUvwkoYDnvdwNUl/HgjTzeQnle5HwYQEN6yzuQBaxZFBOE6oU5WV3fkEMCDDFFsfQSHCtQo/gtCZXdryLWAmFfpqegC3fh5+MLdKgPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6380
X-OriginatorOrg: intel.com

Darrick J. Wong wrote:
> On Thu, Apr 10, 2025 at 12:12:33PM -0700, Alison Schofield wrote:
> > On Thu, Apr 10, 2025 at 11:10:20AM +0200, David Hildenbrand wrote:
> > > Alison reports an issue with fsdax when large extends end up using
> > > large ZONE_DEVICE folios:
> > >
> > 
> > Passes the ndctl/dax unit tests.
> > 
> > Tested-by: Alison Schofield <alison.schofield@intel.com>
> 
> This fixes the crash I complained about here:
> https://lore.kernel.org/linux-fsdevel/20250417030143.GO25675@frogsfrogsfrogs/T/
> 
> Can we get a fix queued up for -rc3 if it hasn't been already, please?
> 
> Tested-by: "Darrick J. Wong" <djwong@kernel.org>

Andrew, please pick this up, I have nothing else pending in the dax
area.

