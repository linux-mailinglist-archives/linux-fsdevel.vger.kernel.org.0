Return-Path: <linux-fsdevel+bounces-16824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD78A349D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436D6281CF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C7714D428;
	Fri, 12 Apr 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJ4IgyJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE8B14BF8B;
	Fri, 12 Apr 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942484; cv=fail; b=aZ31KoXB61eOMtyPPaLt7CkvpQOve0F+Ka1N5mhoUaPjW/2/FbTWJRWkG9pVin10xHSKslzNWqcTqwnoU0cTn2vaSc6wOPM0il6psWzgtNw6MzazgDBxBKjU7a2l3+Ae0l/WiKS3L6l/5qNkeY/+DFqZf6xwY4D6g/brr9LI/o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942484; c=relaxed/simple;
	bh=L2WyTDRGYpcd+oHQ9ExJTLxPrX9sTYfycf09VRkq+/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pNC7Ac6+0mAUMO1Ir6cAToYkUTH1BFOhddsVhqRLlAAaZ6HdWOpvRbN75Ud1iFDftUcJVk2theePj6JPHDrcI5cLuCSsmS0Qvf4cxPkViFAkarNt6PGE4phs55y3uRWigKafMk3RnAk2Mv9nb6Pc1Zz5E3u9I0DnoISrWG4UtmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJ4IgyJZ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712942483; x=1744478483;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L2WyTDRGYpcd+oHQ9ExJTLxPrX9sTYfycf09VRkq+/A=;
  b=ZJ4IgyJZd3TLCkUlK1aZDIFUJ+byRJX+m9YArHWCSTYCxlUrDCbldRRd
   WIzKXgvgccMdItQApuwZi4pzcASwqosFXPLTyp2Ww2omtkeEAS7wlZ6Lp
   fCfLA7aarWHDybBkmelUpAFwFAsfiA4LodwFskJi1uEB+LzhNwbuegJ//
   qr7rzECEGj5SyJVyfgl6kWiWC8pVGLnS0DP5r85T7BLUtUQutxiydEFEk
   amu+xQ97NqcM2UReBBRkOleEkZBaYtzZfHjTGILLn96GDkbC/YCqx5i+V
   OR13VI/mY6Ao+2rCmXhZtUCaOttx3rqXUgdolc99MIrVJ7Tls1JH5jUO7
   Q==;
X-CSE-ConnectionGUID: EdjWxxfETX+oWlMcPEu5SA==
X-CSE-MsgGUID: poVyKwXXQxCsWX92/Oap6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="11364775"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="11364775"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:21:17 -0700
X-CSE-ConnectionGUID: Pb6zgj+HTgeOW/nIt+zZXQ==
X-CSE-MsgGUID: 1+vaz158T5eRSmdcQdJCVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21779502"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 10:21:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 10:21:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 10:21:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:21:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cys6GgPxWibjvxRuQwX4+kDZBYpXE9Ka4hhT9s47FreE0DoMwQUD89NLi9sw2p9bGSSRl0B0gGhWTOkzhrKopiiozV7D0cg52qXlqjXan8bph78BxltsVrzYCBLpBRTEo9kF4Hqr7MFiJ+X5X5ugbOhvr34L29hOpHfPIqZ+sm2ZDegVhsVXkVYTcLLQLxAEItHaW7/1VIF66eymzl1kqtMOLr/t1JNlPvqoiVk/oT+JIwjbZ21QfWMm0Pe3q/SyNAUCyfeH5cI0ylRvl/6OTJUVyOMt5WCKQyvicGfcY9ghJiUit/h2bo8H5x4cNmsVEI5zopMIElo8HuUgOum9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m/D3OOmBTC7hhZf42KUQ/BTUQR706oYGXI8BZpcI5A=;
 b=enAHFw1qeLrAgTLdceWrjqeBx5i54OWOAUnLo8nH4I8KwGfcscZ3iNk5rrDzQfGloN2LO7GZWOtmCfDTP81+g2XPQuNgLgqdUUNbox5pQ35tUmNEAgqTj7A8bSHFt5RYL9bBMbCzsA2ur6nh90zpb1UbPFezoXJm2BmBnyjCZ8Aj4r+e8TGcrDrSHaLvwCllimoza/PRdHxzcjRlpYMNUes6X44uiSL4CphnjICZeGZpn718NHwO3Sao7xL4/PTQGS1R8tJOpVoq6SgYRhCEQ3A8T/oW/P8xnsjzKfE7HLmmUnZ8R1ziENCdzbEKJWCj6LX8UrYVLuy2UC5UpUF9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 17:21:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Fri, 12 Apr 2024
 17:21:12 +0000
Date: Fri, 12 Apr 2024 10:21:10 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>
CC: <david@fromorbit.com>, <dan.j.williams@intel.com>, <jhubbard@nvidia.com>,
	<rcampbell@nvidia.com>, <willy@infradead.org>, <jgg@nvidia.com>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>, <djwong@kernel.org>,
	<hch@lst.de>, <david@redhat.com>, <ruansy.fnst@fujitsu.com>,
	<nvdimm@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <jglisse@redhat.com>, Alistair Popple
	<apopple@nvidia.com>
Subject: RE: [RFC 04/10] fs/dax: Don't track page mapping/index
Message-ID: <66196d85f3a16_36222e29490@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:303:8f::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f02e8e-c505-41e5-2e36-08dc5b14f3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5IARUgMpa5ONfMIB6ZSiBY+sblZMpiqgK773pLtLCjJqZFDAD+IumUuQo6EX+AI/NHOxxeVJTYK+0LcWG+noCPDO3CXvfUWGvk9VMGIZuVKFaKA+LPRrWxFAi0AgxE4TeNTHhDY2JWOdbLNgXJNus5MHhGdMzeFJMtfeRGxUqLG7on5rAJYhH/dERiZxQ1smLTNE/tru4Pxic6GbH5Y4TubrDOMuqwAnnmTGhhgL6uDP+zmZaPSmYHvVqKI1kEI9fPwtqUcijeDiTGRxPSqoafptSohpf5FvsHlhfTinCP5kkCeJ8uZbNgUNJ1Pmpe12YoJUKxFzYO7I2s88opXILujy3wKJ63QYEciJdyoyFwDmddffRzgczhhLIh1jY6n7Hwt4tkVvCa45/N0P+eIiBst5B+T056JaqJjI2ymW1iep+J1IOoU8TqBCu93YBgUu6IZ6sNRuDJ4/fgZDbfbMSHWiIyOYiYyeGTE46uAlFHvwjLMZvSDBcTvS7cNJ+HOmgcK5p5p771ZYqDkSkQjDYzjl+WwFjVI79FZmVnuigE3H4iQ9Tvjt8tntgHxkYMtwDMwS0/f6ndRfbwtyKcMqIw1Eg1NeJz4P+4nt2ih1OWC86M8c2b9voq4TvlS09ajUEBJ5RX4CXmKJ78Gw0bDRpQGWPRURSlXccgDoZJt3bg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHyIUdm6GatV1dSXltO0sj60PO1sLSmX4ESqNrruGARhdu5UFUHU2PLwWS/3?=
 =?us-ascii?Q?cmElsGoLdmGqOjIjXY8OZDdiaogvIbnYa6Cgq5OwGrFhN9T0Msq8++Mhbn7i?=
 =?us-ascii?Q?Rpslv5AIzgW/FAGcDl+dfGccgud0/lHnq6jTah0gSKwzQ/t10oMxg3yM1nWn?=
 =?us-ascii?Q?/LbLeORaBDeAD5v6yhZZyA2FcZGLia9M/7MOcU62g0NO5OFzhwUwYUO+PE+Q?=
 =?us-ascii?Q?1zkJI0vBE6MeU/TM4M1r62r1slRpYzYbsPhaw6TE0rLqlBbXOCGJjrssOm9X?=
 =?us-ascii?Q?6G+OBA6Wd9DafKLymDsB9q743GN+rWFD3CJjc+Ql1qUxzrMK8mCFDuuFjgKQ?=
 =?us-ascii?Q?9Ikc8cgM03vRPgGyZsi0LRDdQx2qgsy2ifR2y1H+iUbZqJ+ki9b5nfkgU949?=
 =?us-ascii?Q?JFRbbA3OloIJuxQOdH1gBSUM5hn+Bf5yylmkUzk8gS0zZjfF4KfNzZ1lioro?=
 =?us-ascii?Q?zdGljAvoPtDYO1OwSzrrPwxQ5bht9mmtEeLIdgU3D/dK/QOh0SNkC6gHbd2u?=
 =?us-ascii?Q?OwRCHBIaSriHn07FSAK5G0h3EWm+wbUnJoLP69KTEGUZb1FdsWD0cjytovIM?=
 =?us-ascii?Q?KWT+N4cUE/rnBbdU1Dr2A/tXHNXZTAjf1llApEs140f1jK198QbkmAKTB65r?=
 =?us-ascii?Q?FIui6qLlBNvkz80ZtK51sXwo1X2yGfSu8FT6I4UHGcYecQGG3CCq4TPqI82P?=
 =?us-ascii?Q?bnimyBzBsIWe7WOp0S7Ss9eLpR8eXPZMddeICHAsZTbILL2kfLYQTX3JblXt?=
 =?us-ascii?Q?1kDMbwwKctWHt93OXd/osHA1Y3Zbcn1aPqjWKAoXNpT8DTAdqVU9RiyF4Vuv?=
 =?us-ascii?Q?Zg713hBqJbQU4MYspTj7hGFgau+Eme9H1/1MVnFhyD+Hi180cKg8waOCxZot?=
 =?us-ascii?Q?D6hZ4Uyf0snfCSB1bPHiaf0f9IDufUz+S3Jyi/Y/TyAQdBrxEKRURRP1B3pu?=
 =?us-ascii?Q?vPBif+JrWOU3mUb+fkxI1fcYa5YVkiBC9tDs1JroZiTy2j9/E7MvBVvlr65U?=
 =?us-ascii?Q?4DhuDQdFI/Vp5JvGPibAGOWq0El1Gr+qqJD1sGZutrI3Mme6iZSkurwFPerR?=
 =?us-ascii?Q?Cysn8uFb9Sm+1dy8EBOvkXTVF+fmZfWFVayiBwnh15SEopn6wNlm8S3TSWGK?=
 =?us-ascii?Q?vhfwO6j/qBKiJ1kLcGDxRLqwJVAc/pK7y4jZ8l2rqdjFKrTed0FQFdGpLE+j?=
 =?us-ascii?Q?XjnkYNl9OG77ol1UmIYoI9UMnnx55aKS08dMyfchoUP0bd2u2ftRjHKSDGM5?=
 =?us-ascii?Q?GSV/jgZU9ZzDJ0Vl7yDb+mNJAWaWnLZZR/PiRi4tqf+e+SHGPuKwNAG8ZbIk?=
 =?us-ascii?Q?Yvt2oyzOTL31hA880Izw4KiDbXE4chPZOwZ3GF1NXcuNoWnmGgTCKh1pOOuE?=
 =?us-ascii?Q?J7HWnDAb5OHO2+2tvQJBNxXwO/puSnTTzvqnT7yUwMjiRy/zNXsUKlu+F/PS?=
 =?us-ascii?Q?IUl+ygrqJR4Cx3tqwWVxojWIS3xI1Tf7McochpxeNA9PKrJvdBqayY2heN8h?=
 =?us-ascii?Q?GM0lzzxqwhHnONhUpHOyvkDoJ/y33F7z6u0gsSlnUfY2/CRcdcJuO294HATl?=
 =?us-ascii?Q?x2USrHcopXmnxPftusYrXouyFdNjkYJU64RGXY7HHBOdKqoPUXZuCGbMDjTL?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f02e8e-c505-41e5-2e36-08dc5b14f3a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:21:12.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGGSDJPQ+qVmRfibAfaSjkmRzL3l41Ei3lFAzovgK/4IM9qXVKliPeBq09D7i/PIzF7GcLjoRRQLGdGnoz2uW0zj2649lXWPXGUdrLpP/IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> The page->mapping and page->index fields are normally used by the
> pagecache and rmap for looking up virtual mappings of pages. FS DAX
> implements it's own kind of page cache and rmap look ups so these
> fields are unnecessary. They are currently only used to detect
> error/warning conditions which should never occur.
> 
> A future change will change the way shared mappings are detected by
> doing normal page reference counting instead, so remove the
> unnecessary checks.

Ignore my comment on patch3, I fumble fingered the reply, it was meant
to for this patch. I.e. that "future change" should just be present
before removing old logic.

