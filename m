Return-Path: <linux-fsdevel+bounces-17271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F258AA6F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 04:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724181F2207B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 02:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B57944E;
	Fri, 19 Apr 2024 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5K+SdU1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D7443D;
	Fri, 19 Apr 2024 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493802; cv=fail; b=Ih9vtMrlojZZCScpaICH9RegMiRF/Y2wJ9i+YBRTVgsaeVlu7m/nlVDGLvZxv70VgPy/s+4H5we/gsdNVxeS4GaT3Yc9dZJYqhwPj7yXPmxxwHK5SPE6kKpPNuqtXT501Yx5XGI93RfbgKdVyQPxoY5tVeVI1RJqF8wB10bJwzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493802; c=relaxed/simple;
	bh=21dJcY1sG7oWqC3P4+vD7BgQWa7jfrau5WXsIFrsqKU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YpgOMSZ4PRV/KKC/aULR0UPAac82vMQPeNd5mqKMd8eLZnH6jcZSb0E5qmU2PSPy6ZKGHGLyozjBfKUkgHsZYpKg0mLwpSHn4C0F42UKfwhd/nR8h+/avywW/fAlg0DXQGlpYaHyVyrd16HVkYD9VEDS0W97qoHELuNUYsLBMPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5K+SdU1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713493801; x=1745029801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=21dJcY1sG7oWqC3P4+vD7BgQWa7jfrau5WXsIFrsqKU=;
  b=E5K+SdU12YkrorQZyhtb6gotsimnbErsiBWKOaazxv29SG1zPqv+9i9i
   51QruJ3uOqSvZ8+8RUjCsnjjLoDjS9oaS9DLiRDeoDJKw2NlnXSN6/IDd
   yP8euNzU+jA6oK1TaH+uWXXuknGi2Rr0eH20kdzYFdQUoOhmUaWdR9KBH
   jmnDzT+DgaGR2iCa7/vlxAPkAWpDzZj6mfgQmR05jmk5ct99vK/ujOcPG
   vYx6nb+r+PwJxjdjpFeB4okA/LouqNWzb7mGgNJzCA7Fv0DydSTVUWXP+
   fMo6mAjz1NypQ2hUExpYxvPL5cHKLdv6908cJlbT5uNPn5l6KPgZ9dMVq
   A==;
X-CSE-ConnectionGUID: 7AUa4Q6aSXqpY2p4Hpc1gA==
X-CSE-MsgGUID: U+mB6YdsS++zFyDDM6ELQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8918106"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8918106"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 19:30:00 -0700
X-CSE-ConnectionGUID: 1G1jLH1PQHeGnXEmFiEm5g==
X-CSE-MsgGUID: tGHiWs16SGicEgMeAN7GCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23207587"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 19:30:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 19:29:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 19:29:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 19:29:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 19:29:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN4iW5cgAyd99NrmqUMfU1NNyhWtf10FBQI11nGd5PN9CxYIapHJvT3+DHlJ+VELASIkEjj1+YN9IJf9Ne1SHOTMePlypzPmn1xZ6x/IdNWgzk6Mht/6hyY7thWbJEb7Qq7Zz/JEqRR0rLN2gzJ0EfrOWJi6ycEohgOtnspwfLyYsMMj/FvGcsP1YDdfMSjoO34p/Hv3O7pB4BQzAp6VhqSFIJTBE34suIYlI72cJq2HDn5ylfbwhRjBfHeWLXNoZGrbwWNuF3xSB5Ox6SkqYU2Jk5ze6O9sbnswb1yVHc5L1/E+buwDOsG8WQRmGWE0UrzQTB6ik5rOZoFCOSr3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUftD060Ygd/52uNwIBKfU+NOJh2//4hcTEfMnWd5ww=;
 b=TovyNT4pK8Hg8wBYAPVv6AA0zHxzuwJPFlrO/OfFPHcxgMYSRCJM/c3EILXPFC42kzQ2bNpiqfqGMIhR6rPYjva4UEwRWdIuuSNccgllBsXRKF1+sOxhCdm5Q2FM0mguMw1s7k3iZ6GdbpaRy3nxPERPgJIjTPYaWwA6YWWCmVNMrqQVh3MHgrDcgWunI0WKCC/uUhrryCGZq3U4wLwNXOUOBZMa2OFNEvHl4dQIoC8oyE54DyTPf5U9OfN8PEtRSvPd3rGSql5wAeAZp3ZRfFeR20G+qOeZEC4ou3f50FxFt8Ivhwjl49fAX9sOTjnbLjqRLN6b0tWz40QWun+w4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Fri, 19 Apr
 2024 02:29:57 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::ef38:e929:a729:2089]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::ef38:e929:a729:2089%7]) with mapi id 15.20.7452.019; Fri, 19 Apr 2024
 02:29:57 +0000
Message-ID: <b05cdac2-84f2-4727-af6c-3b666e6add14@intel.com>
Date: Fri, 19 Apr 2024 10:29:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/18] mm: improve folio_likely_mapped_shared() using
 the mapcount of large folios
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Peter Xu <peterx@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Yang Shi <shy828301@gmail.com>, Zi Yan
	<ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins
	<hughd@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
	<dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, "Muchun
 Song" <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <naoya.horiguchi@nec.com>, Richard Chang <richardycc@google.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-6-david@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20240409192301.907377-6-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|CH3PR11MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: b058591c-ae7d-4946-34a4-08dc60189a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzFBSWl6elRiRVNveTVsL1BoZU9Xa01rQ2M5RTFINVVmeVVRQ3lEbytKcXNJ?=
 =?utf-8?B?MzEzekVBZjB3cjU4VHBJaFlsMTJpRThWUzdvSlZodG9SMGt5cWJLZ2xPMWtS?=
 =?utf-8?B?T1NkMTR1UGtZZVBKRnNSNW5nYkNEdEdGUTRuWEg4dTE1aDJXZVBacjdFaUJX?=
 =?utf-8?B?aWRnbHJJRDUxb3N0djNBSmNTOG9RVmN0NERzOVpoblYxeklRQS9KMVgxSDlZ?=
 =?utf-8?B?VGlXekVKZk1SNE5kbWlyanBFUkxjOEJ3YlV3NGZMM3pKUmJpZWZaQXl2eGhp?=
 =?utf-8?B?SlVLbGhqSmVvUWI5MlYydnA5aEVYNkkxYWJVWmVJMms5a0RWUjlLb1gzZG1W?=
 =?utf-8?B?czBZNWpKOHhSY3loZExUTVRiQjNsc3lMTWthNm94ZktYRVIrdmdTNU5kdm9s?=
 =?utf-8?B?Z0xJSUNsbVQ4MnAvTWRQbE9xa01XdWpjV1U5UWdRS0hGeFpVOS8zSHZib0hJ?=
 =?utf-8?B?cFBmNTR3RDNLajJjZUZoUHJmc1oxTVhoY2RtM0RjVUNuYldFd0xLMWJ5S1VW?=
 =?utf-8?B?Vnl0WFRzbkJDdTRMYTJRaVQzQlUwL1FvaUtydmhldVJIdjFaU1hPSC9FT0Y4?=
 =?utf-8?B?UGV0MFI5OC8vMW5YUFFISFpHUVVtNTdRR3NVN0MvSXhjWHdqSW5iTkoyaFZo?=
 =?utf-8?B?VmJtN21oaXdEZ2pDcE9xb3pIWE5lYnphNWZFemRPc2tDYUY2RitWU0h3ZHBy?=
 =?utf-8?B?eVNaQkVVUk9wOUFqSTR4WjZtbVNXWXd6b3NKdFpib0Y2Yk56a1lzVDNpcWlE?=
 =?utf-8?B?aXFXdy9TRkU0ZFh0RnhnV0YyY2hXN0NJYkxkSU0wMExFSGlOd21VUUNNYU5l?=
 =?utf-8?B?WXY0SW1VdENxTEhHU0ZITEtFY1BKbnEvYWxBSVNDcFhhaGlxbW5GR0lrNkIw?=
 =?utf-8?B?WGF2SnRvYWVxWkJQS1EzaEl3UEtPdjRZT3F1YjNJbkc2UHBZdnFIM3ExQWtV?=
 =?utf-8?B?a1RVN1RIV3FzTEVBTDBCcWF4NE43YndJZG1lUUMzUm96UUkzMkNNNjErRGQ1?=
 =?utf-8?B?bTBGYXdUVkdmSHl3RE9LUW5UYkxna3ppUjd0eXIrbnlOc2xYVjFLVXdmNy83?=
 =?utf-8?B?V0gwMHJCUVkrenVvdEhDdUVvRGRXTFVxMkM1L3VkQS9YNmJ0cnBGYUdNRFhk?=
 =?utf-8?B?eG5zQnhsM3MzV05LNmg3VGpXcW9ianJWYlZVTkpldFBVRDBRN0t6ZnM1SmVH?=
 =?utf-8?B?MWRQcVc1WU9xQ2EvYkRraFF6RmJGandXN0FDZEV2STlkQnovQWlnK1Fpc3Uz?=
 =?utf-8?B?cFhoVHNFNmZZbTJUUDZEM2s3aHhFNTVpUTJYOENwbUV3UHl6OVMzZGZKY2N0?=
 =?utf-8?B?S2xqNURRUUgzVjFCVFI4NnduSTBsLzJ4RFpQU1JDTzh5NHZYcUtad3RlQjBR?=
 =?utf-8?B?TDJLTTZ6QXhqa3dWVFBZdWxtaE95bityRnR0YjQ1RDBzbHBHb09kaFpPSzgr?=
 =?utf-8?B?WWo2dStpUVRldW9nQnEreGh1QXJTMnk3UDBFdVdUbjZTZ0srWjJ6VkxhM0ty?=
 =?utf-8?B?T0RudVJ6cW1YUTF5Uy8zcTVaSkV2SmJqL2h5VjZSOThDeklOTlRKKzlpVWRu?=
 =?utf-8?B?U3o5VDVzSVpWTGdtRHFia3BHVkwzend6cTlVc1JwRHNQUUowS0p1OUhTZUNn?=
 =?utf-8?B?QXlBVjdTUVpKMVg2RHFtbDhvVUxKdTdBZlZqeTRGNFBDNGgxNUNDQk1jSEZ4?=
 =?utf-8?B?eW5kL1MwZjd2akR2bGpuU2VFZGVpSUVYZHlMbnk1UW1MUDVhczBxMlp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDF3OVJzOURXNHpvcHpiTmVhamxLNnpWU1lMTjNSdXg5cXpPcWlMaktpWk03?=
 =?utf-8?B?VUhYUllkNWw5UVVyd3d6UnNmMjBpNFk0WllWZ2tWU1YvTUkvejFwU0N0ODAy?=
 =?utf-8?B?VFBKblFDdUlIclh0V0I5QllwaCsxMm9ySUFKcDVpZjJEMXMwS0xYdVQva0xh?=
 =?utf-8?B?SVVtMjJPZlMxMmtVYnhoYjJOZU1JSm5kQzE0WHhJL2VicjJ2Q3gxUzRBbklF?=
 =?utf-8?B?dDRaMG1WTmtSMzFJL3dZM2dQMGNrVW9YTVRucXJxakJNYjI3MXo2ZnFQRjYy?=
 =?utf-8?B?YldlaEp0OWRFdHVURHRWOUNia1phWDNkZm9nUmVJREFteTFqdmxETFZiUkNJ?=
 =?utf-8?B?djNNSEFLMzRuTkVNMHZjTVFiMWRnZm1Zb1lKciszZm5CQWtlOUI4MmZGSE9s?=
 =?utf-8?B?Vjh4czFFanJBTzdqeklDOXhqU1NsaE5sSFE0OWcvQm8yVG5zZEJnZUk1M3M4?=
 =?utf-8?B?ZHhxZml0dDEwelA3byt3eXArc0phRU11NFNJcldRbS82ZmdYSUk5SlZTNmlH?=
 =?utf-8?B?cUZhOUZ4dXV0cWlzVkNhb1g2R2hxa2doalBDR3pGWEN5NUNLZnAvUFgxMW1T?=
 =?utf-8?B?a1JqWFJCSWMzdXNDVVdIaEdqTngwdnVZY0lZdDgyZGNWUzBMdjRWRis4VEhU?=
 =?utf-8?B?bHFGT21DdlEwMFhVYzFVL0VxajNwR1JLRzdFa2hYcC9sL0ZKTVBnV2tlZ1Jn?=
 =?utf-8?B?eGVQQUZJUUwrQjZYczVZQlBML2JLL3NvRlM5cU44MTBVbkhRYVZtbWl0VFk3?=
 =?utf-8?B?MFQ2ZEVsNklmbWlKTVNCTnI4TGZaYjJsQ3FtVVlrbkJ4b1YwNGJrdnN6S29N?=
 =?utf-8?B?VU94cGRvcWx6ZVQ2NjdzY1MrQ1hLMjdKaGhYamZ5RWRtYzN0TlpjMGxxNCtN?=
 =?utf-8?B?SWh6VFZLZ3RFYmdkMTVBRkJBc0R1SkpISzA5Nk94Q3BRQ2w0azY4UnNHdmMw?=
 =?utf-8?B?REEvcFNoQUZRTFErdW05OXUydGdVY2JRNytoQ0NwT2ZiZU5nYlllQ0FoMCtt?=
 =?utf-8?B?M1JYR2lFWDQ2bG1aS2ZPZEtFdFRBRnJ4WUJGdmE5L3NhV3FEekZaNVB3MWsr?=
 =?utf-8?B?dGxoN2lzS2c5aDh5RUlneFphTVgva2c0TFMzZmtHK3c5NjRJbnNIbXg2UnIy?=
 =?utf-8?B?cm81Z2pPZ2hkRWFFWXZ2RSt2ano5d0FVZVNLY1dJWDYybHAvU1ArWWZTMmhZ?=
 =?utf-8?B?bkkyU0FGNnZhVmV0alJWaHcrbDZKWlJZdmdFRld3cGdTOWtPMEtsSDhUYWps?=
 =?utf-8?B?TWdwOGp2TmQ2U0hnOGhvQUdzQWZLRnNUMC9xT1g5Nis3UGRZeFUzWjRWK2tz?=
 =?utf-8?B?R1NXMmRHRFFDc0dRQlBzM2dXYmpMWnBiOEhTdU44NWJRNmxxWnQvMFYvOTYw?=
 =?utf-8?B?SlYwb201Ky9pUGdkMkxoR2R2UEIxU1ZqSG55K0poR2ZOUE1VR3N6OS9PYVNz?=
 =?utf-8?B?M2N2K3FpTkFuLzRtVnI5WGtiZmE2cUhocWdWeVc1dWl1d0oxN2JXb2w4NDE3?=
 =?utf-8?B?cDFDNTZzbFR5Zk9HWGNJL1BHVTJFV0cvdTM1SDVKTGNqSzNXYzRlT0FsaVIv?=
 =?utf-8?B?MEVOUzB6YTUvaER0UFJLS3hRdWdkZmZrZExRanA0eDFsSnRITzd1MzdmM3d1?=
 =?utf-8?B?RFNpOHBwS0lKK3JzRWM0cGVTWFBCT1E3VEZFSkhuM3gvSVk2N0NCN2RnemFo?=
 =?utf-8?B?ZXlJSnFnRDlxempYMk5nVUdVQndYNEJjOVJ6T0NXT0M4aEs2eE82c1FsK0ps?=
 =?utf-8?B?RVUzSjB0M2xUanUwVkQ5YXJKM0lzOU44TzBYT2VUeFJUamxmZmpwcFNDcXNX?=
 =?utf-8?B?YTFMUGNUbEp4bFZydDZ0SzBCdGRGVGp0Vk1uZyt4NlA3b0ltYXF0clc1cWc3?=
 =?utf-8?B?SDYzRW9sZ3RLS25kRTBVV05sc3NaZDJ2VFI2K3VLUHdxWXlRNEd1Zi8zeU5Z?=
 =?utf-8?B?MTZSMHpHRCtpd1dlNGlabTdzbk5pVXVOVDNPYkswTFZKZ2lZa1c4L2RqaWVj?=
 =?utf-8?B?UGNpSlFBOUNvUjZBTSsvUXFLcFRISTVyNGFRRlRIZGk5aVJkcUVvQnlLL0JQ?=
 =?utf-8?B?QjdNeVVlbnIvNHBnQ1NoWlFzcXRlcm1NYUc2T3Zqam9Wd0UvSURFeUZJbWtz?=
 =?utf-8?B?aDl3RHk2SitxQ0JEZG1ySlh6QkZFTGF4NzVuSnpLdFpDaFVsaDNHNkJkQU1P?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b058591c-ae7d-4946-34a4-08dc60189a9c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 02:29:57.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /joS9ywHRkmfJFvVwa0NveN8yyVJDvkRtA6DWn4aaTy1+RFYrG0JMBlWNaxKK4uncT/M2xZkd8IbEyyMQ2e7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com



On 4/10/2024 3:22 AM, David Hildenbrand wrote:
> @@ -2200,7 +2200,22 @@ static inline size_t folio_size(struct folio *folio)
>    */
>   static inline bool folio_likely_mapped_shared(struct folio *folio)
>   {
> -	return page_mapcount(folio_page(folio, 0)) > 1;
> +	int mapcount = folio_mapcount(folio);
> +
> +	/* Only partially-mappable folios require more care. */
> +	if (!folio_test_large(folio) || unlikely(folio_test_hugetlb(folio)))
> +		return mapcount > 1;
My understanding is that mapcount > folio_nr_pages(folio) can cover
order 0 folio. And also folio_entire_mapcount() can cover hugetlb (I am
not 100% sure for this one).  I am wondering whether we can drop above
two lines? Thanks.


Regards
Yin, Fengwei

> +
> +	/* A single mapping implies "mapped exclusively". */
> +	if (mapcount <= 1)
> +		return false;
> +
> +	/* If any page is mapped more than once we treat it "mapped shared". */
> +	if (folio_entire_mapcount(folio) || mapcount > folio_nr_pages(folio))
> +		return true;
> +
> +	/* Let's guess based on the first subpage. */
> +	return atomic_read(&folio->_mapcount) > 0;
>   }


