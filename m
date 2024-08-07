Return-Path: <linux-fsdevel+bounces-25217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46F949E8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360471F26380
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 03:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA7B15D5AB;
	Wed,  7 Aug 2024 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FniBSVEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427651392;
	Wed,  7 Aug 2024 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002315; cv=fail; b=ZR28ZSdKnLT1tEuE+hBvuMfL9gcNzowMhdp7fkhd+Yd2LuaOxQKr2rBLsnTn5tHpoHE8eDig+5iw0APdxnCCTPAhSj5iPzc2K3aU5zYs6jBheGux1SoRoyhPnEe3ri4U70fAYabNrIaYc5wJbFmb8skB/A+bBIrPsxssFngqoSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002315; c=relaxed/simple;
	bh=eyVFaUZG5QJTi8mn36P8IzGqRECxN+ZoIPkgXCnot2Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cjcEVMiZ0mupQLpBllxrEiuJJJ5BofJwFftY+UitlN4ka0WZisdBIJ7ITaK8WufAq0Lx2iUZkgSnWI+g+kFH/Zc3gJWseIC+wxVGwZsQINRN5KjYyrq5tKJ82WY+U8PM6MMJMOIssVAC3CSkUrWs0p+lOX6WMne2Hmoaj9e1pT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FniBSVEc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723002312; x=1754538312;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eyVFaUZG5QJTi8mn36P8IzGqRECxN+ZoIPkgXCnot2Q=;
  b=FniBSVEcbYDtKCDNxJ+WELsb+lX099yuJZezzvy54w1tjNVRMuEcKZlb
   z/U3hqOOA925CAqUoLQMWP9DBCDbxQX29bErfOcSGzX+ckpMTyAjm5fnM
   iUUwRh7+dOZS/iOb0AH5a7aUG9a1tPjE7teLEQWSOuwj3BUB7vISgJa7L
   wUkk8ztDaNG71cvxnzrfEz7ifWLkIRG2Iie54hxZkGUcIf+EccOfnXggG
   HT0xuTAQ9mZ/vN0aT3qoF1Rw0zpL/DRkynUfKu2kwgtSYW8xq+mF8VYyr
   KU1xPR4G19UoEa4arssApy+BcK/VTIr71txcevHYu0Ki8XTWw0af9YZVO
   A==;
X-CSE-ConnectionGUID: f5xXbMC2RYauffkh7/FnLw==
X-CSE-MsgGUID: YZWHchkATaSosBIRgEUamA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21175718"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21175718"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:45:11 -0700
X-CSE-ConnectionGUID: lUVvTo1XSuKxTEfx5lm8KA==
X-CSE-MsgGUID: drzkEl6qTT+nXcwkWzsVDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61363117"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 20:45:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 20:45:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 20:45:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 20:45:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 20:45:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RijCONw5dsBaT2N/t9rAG6M4fN0Ix74C7SCcwgwcAJrVayKQdUTOqj3xT+iJ1t7CjEOcyk8jiUXlxLal1Mb7FIuwakAAoKv6yFIkR8p8c0Oy3lHo+6bmFQVuBj50D4LhXEFbMRkS36Lng2s4DdUKAEqsZVfv0x+tWYyRVksREy6p0U1JCVlktxbEHvbVjyWYdscF3DXjruo1t571fh7mNNadHaIWrlI2kD4hhelSFzingUTRzaTfHaSdaKx5b68GBi+eoeDUoRuy7bNz6MUoPn4yM2ghPRzzr2sPYVec3yEunk72aUtEw1rOQckvmRiP5ZqX8g4iCLA/mzWYP82t5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFe6yUKMx2ET56xa8uDEljrKOJGZrut17U3IymlhswA=;
 b=WOvU/5mRJigmOnsFZohwWOCWvlEyay1OwjN6BnUC53pTTLAn7amhRDKx8p9MplOk5IbYElTVW4sGzRPs9qmqcG6Cd10L5sGQh47AE3g2HKPBgiJ9qF5UFc04Na0lWXaNbLYfyvbyMkvHNSjE2hzwSQdd2M9IPE8Srb/yuq6Krr+VyffIgLKkIwQ7iJt2c/vxCgc4V69KhPBQJviJ07vIXIuQd0L0hREJSpR6SdzMN/FDenCcVLOgsMFyMxcV6JXKdveYokum9xJv+eqAO7YcepYAkrPcgv7jFCErFdsKU321Gh7S98lFE3e2PVd4uUVRc+U1UZr4JMSOYhWDrxI+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 7 Aug
 2024 03:45:07 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 03:45:07 +0000
Date: Wed, 7 Aug 2024 11:45:56 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Kees Cook
	<kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>, SeongJae Park
	<sj@kernel.org>, Shuah Khan <shuah@kernel.org>, Brendan Higgins
	<brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar
	<rmoar@google.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH v4 1/7] userfaultfd: move core VMA manipulation logic to
 mm/userfaultfd.c
Message-ID: <ZrLt9HIxV9QiZotn@xpf.sh.intel.com>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
 <50c3ed995fd81c45876c86304c8a00bf3e396cfd.1722251717.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <50c3ed995fd81c45876c86304c8a00bf3e396cfd.1722251717.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH0PR11MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: c4269283-ce77-4a08-42f0-08dcb6935448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hl5ta/1fG0GdgBhl8hbXaogDey6cp4wTXKEp7ePbWe/7/WynIvgPEO4g1t6m?=
 =?us-ascii?Q?uOGETOVZ1vPvpKXXDU3U6QtqEm7diHkNc1V1oHXhtLgbHiGxYUcEIS8geVK+?=
 =?us-ascii?Q?aYH8Z/IvWxMdUKEd8fWsBKqHRsPqQxGT47ZxKk1BjzBNKfxkNcx7Q3NU4bBh?=
 =?us-ascii?Q?4traPn65PNqjFfAHKXfFHC7gw6iypj2wz6zd4rEqkCOFG57//Yxm3B5Nm263?=
 =?us-ascii?Q?g7wdY4mWXBdtLR/QDhKRX5B8RIeol1N9H0XQ8e/bDaO6TsukbFS9HNFzoFDC?=
 =?us-ascii?Q?f386HVUgSGA1x6aOffRXwiIpCpDNS3Y2+eksRMqVWDGgacFB6SaU6qRF+CoX?=
 =?us-ascii?Q?VXpiPt1DTQ7HeXgT9hbrfiKDux7/BZ6Zvv/ZNt64fjM2cKg0M9gj3ARBq4V4?=
 =?us-ascii?Q?MYeiFu7/YKNCxrwhHUujxPU4BM7Rul4dgknvDJ/r/rY4FYuWKf1tyzYkgHIG?=
 =?us-ascii?Q?0V7/DFY0hxxYo7HwszIwuQYZxejMoTStpoxlMlZ2WW49CcGra8MF2jc16XcG?=
 =?us-ascii?Q?QrYL+hVtHeHPZX+nk9XJQOE7pDb8DXJv9Hz07MEqKFpFGF9LdIZ3R1iATWP6?=
 =?us-ascii?Q?y9r5SDfqozY0QXWYMpYxvUjGRadiS91Jr0nk3NhBE2DojJqRFb566H4sCtog?=
 =?us-ascii?Q?v+DW+HbmPz3gkbDx/G5PsKO6bcLcaRnBq7UYjHJeN2am1OBy0+q5MznUV9Rs?=
 =?us-ascii?Q?Eujbgx0MSzUrMFUnIF0jCIPffPmB8r2nEWDfl0qGChkLZ07y/ZBc3OIRL9IG?=
 =?us-ascii?Q?SMP6rPcO0p9LKp3EKuUMeTFhHOaxGDwmLnJoRPR2lXqhhBbUhj8eRFov5Rry?=
 =?us-ascii?Q?SaHhA+ztqRqOcQuBIWon9kRFYDmYarTGsQlLmi8JWxBks7bPudo+tC2X4ncZ?=
 =?us-ascii?Q?5y7E50XEd9OLATujLx1hvMK2R8pDK3tVhgxgQjQXE5E4OLTb0bIX7dI5yIpM?=
 =?us-ascii?Q?JlGTrBNciSXNFbyAh7/ohshCunQCw6ZL6bxjShXlwyYQ+JlugLjXWqhZihKO?=
 =?us-ascii?Q?UgkifTiqOi/LVtj2nUbrWkO47dJpRsnievRxJGJeXnZx93EDgoVKsgnKRS7I?=
 =?us-ascii?Q?7kNNmQb6gtOQ05lorm/BXhi6lJem+5S6t77UTM0u8uw0qUHDvsnqDKjfR9NB?=
 =?us-ascii?Q?d5FuGGC0Q1YoYt2KUa9hb9X0zxHxA4lPhmU8NBrwKT/OI8kYHeZZa2Y8OqV/?=
 =?us-ascii?Q?4fdOaOgLOgO5c32uvz0VE5hCRFIeipU5DbTYuS+xgX2qaGOYyfl1NKwr8HCf?=
 =?us-ascii?Q?BfqElRns7Blhq9DgNSw1/rioWCAPNskCdPFesedaBM7LEnTKq8iaSOCMxfPf?=
 =?us-ascii?Q?mXE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x93d2dM0YA5+wd5etYYpCLIbPTmJs8N07kqSt33QPf8GHJcFsBNx67+cKWWb?=
 =?us-ascii?Q?1Y0o3xtzxaHyQOnFMDkmwEVkHdkpVGpI15VMfefRCuWWKNElni9L7U/2QdEV?=
 =?us-ascii?Q?x1iVGNqtaJjcUuDIgoU1rjLTn558Md4s3eh4WIRWj6d/ixX3Py8waBDYyH6L?=
 =?us-ascii?Q?xTH6ieRUAPPGlocRiJVE10mxVXF6idMpn2J/pz9jmI7POnbz2akDG0H6IMWY?=
 =?us-ascii?Q?lXKxSpyaw7rG0K7lhYfuF6k53UOdXqYU1LteOq+CHSb5wrKCtd9D5EOxAct0?=
 =?us-ascii?Q?Xa6HR4/+phTr5bBvtJiaj5DEqoa+ack44JSPM4MWw/jPx6ph+XVzzFU2kXmX?=
 =?us-ascii?Q?k5qdcETOZ2jISUmAQ0EknmIn+mKvqNQM8aIHfFpxP7a9vrNL0DMJi30IRu2c?=
 =?us-ascii?Q?t0Sz5T1RbzE3W33GXQV1YMCuxJqC/0wE5aNnrITI+ptM/8inPcE8NW9+l/aH?=
 =?us-ascii?Q?VhLcfwrguA7ZAWXdX3Ir/mmmXsPPfejKAH2/k9S9ESl5rCmr9kck55/yGfGo?=
 =?us-ascii?Q?g6oyrNQh12ex0vzce0WvVi0BeC7nHs5yfJ3dRIrIp7bH8SD0GP5u5TRaEXz/?=
 =?us-ascii?Q?1aMrfy4/DBoYKrOV0IKjp8y8C+S5KG9GGPQzqbySRsQUEjveUmj+YSOyF6hx?=
 =?us-ascii?Q?CZIZNUggA0JtlsP9+GXkk0PMRNYQ3LdoXlFzZ5ulz1eT0mYATSopPNwHlRh4?=
 =?us-ascii?Q?NteUik1Cxn1YBeT95YBjGx2Z04pQTPCR+nBLRTzpBCNKB8yt8XmVstTQ3sgd?=
 =?us-ascii?Q?+khuoAPQFfXrq9OZepwiUwfvqZZZ94R0eInM2Swc2uwdhaVzTaQZpIYmVBZ+?=
 =?us-ascii?Q?a/q6VyV4r15ocjlnsAPfycHf+0J0n+Vva8wjC7uQ7ET8y6aldGMwlV2LZVJr?=
 =?us-ascii?Q?Q+cjwhX9SFzTK7RbmbGZ0AwnRccU2kni80ZYEZpSm1Chk8gStr/N/NNTtPdb?=
 =?us-ascii?Q?KKBDYDrf8BQcehMGueSHQnk4djy6s1dsZaFwsCPuFPEdAKl6IbbdueAmpMfz?=
 =?us-ascii?Q?ilG20fGiMOB1lNiwgMr84s/UKDkEF0HngQOffOwqdry45zbzTeYHYDv5nZ9q?=
 =?us-ascii?Q?rJgaVNW8EHbA5t+bCCyIGFIkpyLI0Oj7CKryFABQQyG7HlhEx+fiQoJjKnay?=
 =?us-ascii?Q?bRVPw4Nwi8h/TZ4fWGq6zO2sNqetr7UVEIr63RrQVXWIoOpBPL5DLrXZ/1VL?=
 =?us-ascii?Q?hrY908mHKbM/vsLU1jvyo7+o3cQ4zEDfWXeFCQs84Wj4ctSNkAVWB8pK83qB?=
 =?us-ascii?Q?zsAC9rDjz+EcUBkiYNyEXIl+nOzyHJUvWGJVW7QrffHfDlIWuZjD3yhuo/yt?=
 =?us-ascii?Q?lZIr0xe24MWhD/RVor3RkwbfcMMRj3gUiTQGC4eY0HXRW3l77Zeo1Dnb40GR?=
 =?us-ascii?Q?aFPcUU3iu9M6xtXO9s+sU7vJs/pGEMwNm3Mjmc2zOSwdc4mTjE3J1wMfl1zY?=
 =?us-ascii?Q?4BLIJ4egU9/NfWaUG15+sQqm20tv4WUuCBmWUIkBWzCyNihF0wTA/WdhluNx?=
 =?us-ascii?Q?ysci4VXfwy+3cjn004BkXuAEJwxoONm+MH1vps+1Cl3NnyeY41okpENclj+1?=
 =?us-ascii?Q?BcH+hLBKKR7bJ9RjMhOal/3VEjLQbm3bxQn3mbM6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4269283-ce77-4a08-42f0-08dcb6935448
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 03:45:07.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hxg9wpnZMVod3f24Ueueyp2W8ELnZP6+SBTPZ/T2mSsndDD7ITXpW4Ja0XJ/ZdqLhlgy8pWGyUg8ILjaNKfASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-OriginatorOrg: intel.com

Hi Lorenzo Stoakes,

Greetings!

I used syzkaller and found
KASAN: slab-use-after-free Read in userfaultfd_set_ctx in next-20240805.

Bisected the first bad commit:
4651ba8201cf userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240806_122723_userfaultfd_set_ctx
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/repro.prog
Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/bisect_info.log
Dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/d6dbc9f56c3a70e915625b6f1887882c23dc5c91_dmesg.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240806_122723_userfaultfd_set_ctx/bzImage_d6dbc9f56c3a70e915625b6f1887882c23dc5c91.tar.gz

"
[   29.675551] ==================================================================
[   29.676133] BUG: KASAN: slab-use-after-free in userfaultfd_set_ctx+0x31c/0x360
[   29.676716] Read of size 8 at addr ffff888027c5f100 by task repro/1498
[   29.677218] 
[   29.677358] CPU: 0 UID: 0 PID: 1498 Comm: repro Not tainted 6.11.0-rc2-next-20240805-d6dbc9f56c3a #1
[   29.678053] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   29.678910] Call Trace:
[   29.679117]  <TASK>
[   29.679296]  dump_stack_lvl+0xea/0x150
[   29.679622]  print_report+0xce/0x610
[   29.679924]  ? userfaultfd_set_ctx+0x31c/0x360
[   29.680289]  ? kasan_complete_mode_report_info+0x80/0x200
[   29.680716]  ? userfaultfd_set_ctx+0x31c/0x360
[   29.681077]  kasan_report+0xcc/0x110
[   29.681372]  ? userfaultfd_set_ctx+0x31c/0x360
[   29.681729]  __asan_report_load8_noabort+0x18/0x20
[   29.682118]  userfaultfd_set_ctx+0x31c/0x360
[   29.682465]  userfaultfd_clear_vma+0x104/0x190
[   29.682826]  userfaultfd_release_all+0x294/0x4a0
[   29.683201]  ? __pfx_userfaultfd_release_all+0x10/0x10
[   29.683615]  ? __this_cpu_preempt_check+0x21/0x30
[   29.684003]  ? __pfx_userfaultfd_release+0x10/0x10
[   29.684389]  userfaultfd_release+0x112/0x1e0
[   29.684735]  ? __pfx_userfaultfd_release+0x10/0x10
[   29.685114]  ? evm_file_release+0x193/0x1f0
[   29.685454]  __fput+0x426/0xbc0
[   29.685719]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[   29.686153]  __fput_sync+0x58/0x70
[   29.686435]  __x64_sys_close+0x93/0x120
[   29.686744]  x64_sys_call+0x189a/0x20d0
[   29.687066]  do_syscall_64+0x6d/0x140
[   29.687371]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   29.687779] RIP: 0033:0x7f3b67b3f247
[   29.688078] Code: ff e8 cd e3 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 c3 c9 f5 ff
[   29.689519] RSP: 002b:00007ffd1f0ac7d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   29.690140] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3b67b3f247
[   29.690717] RDX: 0000000020000100 RSI: 000000008010aa01 RDI: 0000000000000003
[   29.691270] RBP: 00007ffd1f0ac7f0 R08: 00007ffd1f0ac7f0 R09: 00007ffd1f0ac7f0
[   29.691822] R10: 00007ffd1f0ac7f0 R11: 0000000000000246 R12: 00007ffd1f0ac968
[   29.692375] R13: 0000000000401bf9 R14: 0000000000403e08 R15: 00007f3b67c72000
[   29.692939]  </TASK>
[   29.693124] 
[   29.693258] Allocated by task 1498:
[   29.693545]  kasan_save_stack+0x2c/0x60
[   29.693875]  kasan_save_track+0x18/0x40
[   29.694205]  kasan_save_alloc_info+0x3c/0x50
[   29.694576]  __kasan_slab_alloc+0x62/0x80
[   29.694921]  kmem_cache_alloc_noprof+0x114/0x370
[   29.695319]  vm_area_dup+0x2a/0x1b0
[   29.695630]  __split_vma+0x188/0x1020
[   29.695952]  vma_modify+0x1fc/0x390
[   29.696250]  userfaultfd_clear_vma+0xd4/0x190
[   29.696609]  userfaultfd_ioctl+0x3c0b/0x4560
[   29.696964]  __x64_sys_ioctl+0x1b9/0x230
[   29.697295]  x64_sys_call+0x1209/0x20d0
[   29.697620]  do_syscall_64+0x6d/0x140
[   29.697937]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   29.698364] 
[   29.698508] Freed by task 1505:
[   29.698779]  kasan_save_stack+0x2c/0x60
[   29.699110]  kasan_save_track+0x18/0x40
[   29.699441]  kasan_save_free_info+0x3f/0x60
[   29.699797]  __kasan_slab_free+0x47/0x60
[   29.700137]  kmem_cache_free+0x2f2/0x4b0
[   29.700471]  vm_area_free_rcu_cb+0x7f/0xa0
[   29.700819]  rcu_core+0x877/0x18f0
[   29.701123]  rcu_core_si+0x12/0x20
[   29.701421]  handle_softirqs+0x1c7/0x870
[   29.701760]  __irq_exit_rcu+0xa9/0x120
[   29.702082]  irq_exit_rcu+0x12/0x30
[   29.702386]  sysvec_apic_timer_interrupt+0xa5/0xc0
[   29.702802]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   29.703237] 
[   29.703377] Last potentially related work creation:
[   29.703782]  kasan_save_stack+0x2c/0x60
[   29.704114]  __kasan_record_aux_stack+0x93/0xb0
[   29.704503]  kasan_record_aux_stack_noalloc+0xf/0x20
[   29.704923]  __call_rcu_common.constprop.0+0x72/0x6b0
[   29.705349]  call_rcu+0x12/0x20
[   29.705625]  vm_area_free+0x26/0x30
[   29.705928]  vma_complete+0x57e/0xf60
[   29.706245]  vma_merge+0x166b/0x3540
[   29.706555]  vma_modify+0x9f/0x390
[   29.706853]  userfaultfd_clear_vma+0xd4/0x190
[   29.707227]  userfaultfd_release_all+0x294/0x4a0
[   29.707621]  userfaultfd_release+0x112/0x1e0
[   29.707991]  __fput+0x426/0xbc0
[   29.708267]  __fput_sync+0x58/0x70
[   29.708563]  __x64_sys_close+0x93/0x120
[   29.708891]  x64_sys_call+0x189a/0x20d0
[   29.709220]  do_syscall_64+0x6d/0x140
[   29.709538]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   29.709965] 
[   29.710105] The buggy address belongs to the object at ffff888027c5f0f0
[   29.710105]  which belongs to the cache vm_area_struct of size 176
[   29.711130] The buggy address is located 16 bytes inside of
[   29.711130]  freed 176-byte region [ffff888027c5f0f0, ffff888027c5f1a0)
[   29.712104] 
[   29.712245] The buggy address belongs to the physical page:
[   29.712703] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27c5f
[   29.713349] memcg:ffff8880198eaa01
[   29.713639] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[   29.714173] page_type: 0xfdffffff(slab)
[   29.714507] raw: 000fffffc0000000 ffff88800d319dc0 dead000000000122 0000000000000000
[   29.715137] raw: 0000000000000000 0000000000110011 00000001fdffffff ffff8880198eaa01
[   29.715765] page dumped because: kasan: bad access detected
[   29.716220] 
[   29.716360] Memory state around the buggy address:
[   29.716756]  ffff888027c5f000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   29.717349]  ffff888027c5f080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fa fb
[   29.717940] >ffff888027c5f100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   29.718521]                    ^
[   29.718796]  ffff888027c5f180: fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00
[   29.719388]  ffff888027c5f200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   29.720025] ==================================================================
[   29.720671] Disabling lock debugging due to kernel taint
"

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!


On 2024-07-29 at 12:50:35 +0100, Lorenzo Stoakes wrote:
> This patch forms part of a patch series intending to separate out VMA logic
> and render it testable from userspace, which requires that core
> manipulation functions be exposed in an mm/-internal header file.
> 
> In order to do this, we must abstract APIs we wish to test, in this
> instance functions which ultimately invoke vma_modify().
> 
> This patch therefore moves all logic which ultimately invokes vma_modify()
> to mm/userfaultfd.c, trying to transfer code at a functional granularity
> where possible.
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/userfaultfd.c              | 160 +++-----------------------------
>  include/linux/userfaultfd_k.h |  19 ++++
>  mm/userfaultfd.c              | 168 ++++++++++++++++++++++++++++++++++
>  3 files changed, 198 insertions(+), 149 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 27a3e9285fbf..b3ed7207df7e 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -104,21 +104,6 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
>  	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
>  }
>  
> -static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
> -				     vm_flags_t flags)
> -{
> -	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
> -
> -	vm_flags_reset(vma, flags);
> -	/*
> -	 * For shared mappings, we want to enable writenotify while
> -	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
> -	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
> -	 */
> -	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
> -		vma_set_page_prot(vma);
> -}
> -
>  static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
>  				     int wake_flags, void *key)
>  {
> @@ -615,22 +600,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
>  	spin_unlock_irq(&ctx->event_wqh.lock);
>  
>  	if (release_new_ctx) {
> -		struct vm_area_struct *vma;
> -		struct mm_struct *mm = release_new_ctx->mm;
> -		VMA_ITERATOR(vmi, mm, 0);
> -
> -		/* the various vma->vm_userfaultfd_ctx still points to it */
> -		mmap_write_lock(mm);
> -		for_each_vma(vmi, vma) {
> -			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
> -				vma_start_write(vma);
> -				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -				userfaultfd_set_vm_flags(vma,
> -							 vma->vm_flags & ~__VM_UFFD_FLAGS);
> -			}
> -		}
> -		mmap_write_unlock(mm);
> -
> +		userfaultfd_release_new(release_new_ctx);
>  		userfaultfd_ctx_put(release_new_ctx);
>  	}
>  
> @@ -662,9 +632,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>  		return 0;
>  
>  	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
> -		vma_start_write(vma);
> -		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
> +		userfaultfd_reset_ctx(vma);
>  		return 0;
>  	}
>  
> @@ -749,9 +717,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>  		up_write(&ctx->map_changing_lock);
>  	} else {
>  		/* Drop uffd context if remap feature not enabled */
> -		vma_start_write(vma);
> -		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
> +		userfaultfd_reset_ctx(vma);
>  	}
>  }
>  
> @@ -870,53 +836,13 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>  {
>  	struct userfaultfd_ctx *ctx = file->private_data;
>  	struct mm_struct *mm = ctx->mm;
> -	struct vm_area_struct *vma, *prev;
>  	/* len == 0 means wake all */
>  	struct userfaultfd_wake_range range = { .len = 0, };
> -	unsigned long new_flags;
> -	VMA_ITERATOR(vmi, mm, 0);
>  
>  	WRITE_ONCE(ctx->released, true);
>  
> -	if (!mmget_not_zero(mm))
> -		goto wakeup;
> -
> -	/*
> -	 * Flush page faults out of all CPUs. NOTE: all page faults
> -	 * must be retried without returning VM_FAULT_SIGBUS if
> -	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
> -	 * changes while handle_userfault released the mmap_lock. So
> -	 * it's critical that released is set to true (above), before
> -	 * taking the mmap_lock for writing.
> -	 */
> -	mmap_write_lock(mm);
> -	prev = NULL;
> -	for_each_vma(vmi, vma) {
> -		cond_resched();
> -		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> -		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
> -		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
> -			prev = vma;
> -			continue;
> -		}
> -		/* Reset ptes for the whole vma range if wr-protected */
> -		if (userfaultfd_wp(vma))
> -			uffd_wp_range(vma, vma->vm_start,
> -				      vma->vm_end - vma->vm_start, false);
> -		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> -		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
> -					    vma->vm_end, new_flags,
> -					    NULL_VM_UFFD_CTX);
> -
> -		vma_start_write(vma);
> -		userfaultfd_set_vm_flags(vma, new_flags);
> -		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> +	userfaultfd_release_all(mm, ctx);
>  
> -		prev = vma;
> -	}
> -	mmap_write_unlock(mm);
> -	mmput(mm);
> -wakeup:
>  	/*
>  	 * After no new page faults can wait on this fault_*wqh, flush
>  	 * the last page faults that may have been already waiting on
> @@ -1293,14 +1219,14 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  				unsigned long arg)
>  {
>  	struct mm_struct *mm = ctx->mm;
> -	struct vm_area_struct *vma, *prev, *cur;
> +	struct vm_area_struct *vma, *cur;
>  	int ret;
>  	struct uffdio_register uffdio_register;
>  	struct uffdio_register __user *user_uffdio_register;
> -	unsigned long vm_flags, new_flags;
> +	unsigned long vm_flags;
>  	bool found;
>  	bool basic_ioctls;
> -	unsigned long start, end, vma_end;
> +	unsigned long start, end;
>  	struct vma_iterator vmi;
>  	bool wp_async = userfaultfd_wp_async_ctx(ctx);
>  
> @@ -1428,57 +1354,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	} for_each_vma_range(vmi, cur, end);
>  	BUG_ON(!found);
>  
> -	vma_iter_set(&vmi, start);
> -	prev = vma_prev(&vmi);
> -	if (vma->vm_start < start)
> -		prev = vma;
> -
> -	ret = 0;
> -	for_each_vma_range(vmi, vma, end) {
> -		cond_resched();
> -
> -		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
> -		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> -		       vma->vm_userfaultfd_ctx.ctx != ctx);
> -		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> -
> -		/*
> -		 * Nothing to do: this vma is already registered into this
> -		 * userfaultfd and with the right tracking mode too.
> -		 */
> -		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
> -		    (vma->vm_flags & vm_flags) == vm_flags)
> -			goto skip;
> -
> -		if (vma->vm_start > start)
> -			start = vma->vm_start;
> -		vma_end = min(end, vma->vm_end);
> -
> -		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> -		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> -					    new_flags,
> -					    (struct vm_userfaultfd_ctx){ctx});
> -		if (IS_ERR(vma)) {
> -			ret = PTR_ERR(vma);
> -			break;
> -		}
> -
> -		/*
> -		 * In the vma_merge() successful mprotect-like case 8:
> -		 * the next vma was merged into the current one and
> -		 * the current one has not been updated yet.
> -		 */
> -		vma_start_write(vma);
> -		userfaultfd_set_vm_flags(vma, new_flags);
> -		vma->vm_userfaultfd_ctx.ctx = ctx;
> -
> -		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> -			hugetlb_unshare_all_pmds(vma);
> -
> -	skip:
> -		prev = vma;
> -		start = vma->vm_end;
> -	}
> +	ret = userfaultfd_register_range(ctx, vma, vm_flags, start, end,
> +					 wp_async);
>  
>  out_unlock:
>  	mmap_write_unlock(mm);
> @@ -1519,7 +1396,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	struct vm_area_struct *vma, *prev, *cur;
>  	int ret;
>  	struct uffdio_range uffdio_unregister;
> -	unsigned long new_flags;
>  	bool found;
>  	unsigned long start, end, vma_end;
>  	const void __user *buf = (void __user *)arg;
> @@ -1622,27 +1498,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
>  		}
>  
> -		/* Reset ptes for the whole vma range if wr-protected */
> -		if (userfaultfd_wp(vma))
> -			uffd_wp_range(vma, start, vma_end - start, false);
> -
> -		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> -		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> -					    new_flags, NULL_VM_UFFD_CTX);
> +		vma = userfaultfd_clear_vma(&vmi, prev, vma,
> +					    start, vma_end);
>  		if (IS_ERR(vma)) {
>  			ret = PTR_ERR(vma);
>  			break;
>  		}
>  
> -		/*
> -		 * In the vma_merge() successful mprotect-like case 8:
> -		 * the next vma was merged into the current one and
> -		 * the current one has not been updated yet.
> -		 */
> -		vma_start_write(vma);
> -		userfaultfd_set_vm_flags(vma, new_flags);
> -		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -
>  	skip:
>  		prev = vma;
>  		start = vma->vm_end;
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index a12bcf042551..9fc6ce15c499 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -267,6 +267,25 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
>  extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
>  extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
>  
> +void userfaultfd_reset_ctx(struct vm_area_struct *vma);
> +
> +struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
> +					     struct vm_area_struct *prev,
> +					     struct vm_area_struct *vma,
> +					     unsigned long start,
> +					     unsigned long end);
> +
> +int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
> +			       struct vm_area_struct *vma,
> +			       unsigned long vm_flags,
> +			       unsigned long start, unsigned long end,
> +			       bool wp_async);
> +
> +void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
> +
> +void userfaultfd_release_all(struct mm_struct *mm,
> +			     struct userfaultfd_ctx *ctx);
> +
>  #else /* CONFIG_USERFAULTFD */
>  
>  /* mm helpers */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e54e5c8907fa..3b7715ecf292 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1760,3 +1760,171 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  	VM_WARN_ON(!moved && !err);
>  	return moved ? moved : err;
>  }
> +
> +static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
> +				     vm_flags_t flags)
> +{
> +	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
> +
> +	vm_flags_reset(vma, flags);
> +	/*
> +	 * For shared mappings, we want to enable writenotify while
> +	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
> +	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
> +	 */
> +	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
> +		vma_set_page_prot(vma);
> +}
> +
> +static void userfaultfd_set_ctx(struct vm_area_struct *vma,
> +				struct userfaultfd_ctx *ctx,
> +				unsigned long flags)
> +{
> +	vma_start_write(vma);
> +	vma->vm_userfaultfd_ctx = (struct vm_userfaultfd_ctx){ctx};
> +	userfaultfd_set_vm_flags(vma,
> +				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | flags);
> +}
> +
> +void userfaultfd_reset_ctx(struct vm_area_struct *vma)
> +{
> +	userfaultfd_set_ctx(vma, NULL, 0);
> +}
> +
> +struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
> +					     struct vm_area_struct *prev,
> +					     struct vm_area_struct *vma,
> +					     unsigned long start,
> +					     unsigned long end)
> +{
> +	struct vm_area_struct *ret;
> +
> +	/* Reset ptes for the whole vma range if wr-protected */
> +	if (userfaultfd_wp(vma))
> +		uffd_wp_range(vma, start, end - start, false);
> +
> +	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
> +				    vma->vm_flags & ~__VM_UFFD_FLAGS,
> +				    NULL_VM_UFFD_CTX);
> +
> +	/*
> +	 * In the vma_merge() successful mprotect-like case 8:
> +	 * the next vma was merged into the current one and
> +	 * the current one has not been updated yet.
> +	 */
> +	if (!IS_ERR(ret))
> +		userfaultfd_reset_ctx(vma);
> +
> +	return ret;
> +}
> +
> +/* Assumes mmap write lock taken, and mm_struct pinned. */
> +int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
> +			       struct vm_area_struct *vma,
> +			       unsigned long vm_flags,
> +			       unsigned long start, unsigned long end,
> +			       bool wp_async)
> +{
> +	VMA_ITERATOR(vmi, ctx->mm, start);
> +	struct vm_area_struct *prev = vma_prev(&vmi);
> +	unsigned long vma_end;
> +	unsigned long new_flags;
> +
> +	if (vma->vm_start < start)
> +		prev = vma;
> +
> +	for_each_vma_range(vmi, vma, end) {
> +		cond_resched();
> +
> +		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
> +		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> +		       vma->vm_userfaultfd_ctx.ctx != ctx);
> +		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> +
> +		/*
> +		 * Nothing to do: this vma is already registered into this
> +		 * userfaultfd and with the right tracking mode too.
> +		 */
> +		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
> +		    (vma->vm_flags & vm_flags) == vm_flags)
> +			goto skip;
> +
> +		if (vma->vm_start > start)
> +			start = vma->vm_start;
> +		vma_end = min(end, vma->vm_end);
> +
> +		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> +		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> +					    new_flags,
> +					    (struct vm_userfaultfd_ctx){ctx});
> +		if (IS_ERR(vma))
> +			return PTR_ERR(vma);
> +
> +		/*
> +		 * In the vma_merge() successful mprotect-like case 8:
> +		 * the next vma was merged into the current one and
> +		 * the current one has not been updated yet.
> +		 */
> +		userfaultfd_set_ctx(vma, ctx, vm_flags);
> +
> +		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> +			hugetlb_unshare_all_pmds(vma);
> +
> +skip:
> +		prev = vma;
> +		start = vma->vm_end;
> +	}
> +
> +	return 0;
> +}
> +
> +void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
> +{
> +	struct mm_struct *mm = ctx->mm;
> +	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, mm, 0);
> +
> +	/* the various vma->vm_userfaultfd_ctx still points to it */
> +	mmap_write_lock(mm);
> +	for_each_vma(vmi, vma) {
> +		if (vma->vm_userfaultfd_ctx.ctx == ctx)
> +			userfaultfd_reset_ctx(vma);
> +	}
> +	mmap_write_unlock(mm);
> +}
> +
> +void userfaultfd_release_all(struct mm_struct *mm,
> +			     struct userfaultfd_ctx *ctx)
> +{
> +	struct vm_area_struct *vma, *prev;
> +	VMA_ITERATOR(vmi, mm, 0);
> +
> +	if (!mmget_not_zero(mm))
> +		return;
> +
> +	/*
> +	 * Flush page faults out of all CPUs. NOTE: all page faults
> +	 * must be retried without returning VM_FAULT_SIGBUS if
> +	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
> +	 * changes while handle_userfault released the mmap_lock. So
> +	 * it's critical that released is set to true (above), before
> +	 * taking the mmap_lock for writing.
> +	 */
> +	mmap_write_lock(mm);
> +	prev = NULL;
> +	for_each_vma(vmi, vma) {
> +		cond_resched();
> +		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> +		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
> +		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
> +			prev = vma;
> +			continue;
> +		}
> +
> +		vma = userfaultfd_clear_vma(&vmi, prev, vma,
> +					    vma->vm_start, vma->vm_end);
> +		prev = vma;
> +	}
> +	mmap_write_unlock(mm);
> +	mmput(mm);
> +}
> -- 
> 2.45.2
> 

