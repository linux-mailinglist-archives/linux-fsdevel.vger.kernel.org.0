Return-Path: <linux-fsdevel+bounces-25049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736FC9485C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 01:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F16F1C2199A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 23:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0458014A088;
	Mon,  5 Aug 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4aGDhtY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57914136330;
	Mon,  5 Aug 2024 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722899187; cv=fail; b=S/h5XmOcSqO30u8EI448JNOWUG37Te1OUDvMB/iBEVJuXk6HAorX76DZLKLHICd4xAg+K3ai84nbO+3T9RAmjvq/NapTLcll3x/07Sr7TxWktJEw7ipjQVj07OMfJiAE/9L8TGmwOwyPa7fKBOdYVyCq9mlQvKhi/bgpPZoO5iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722899187; c=relaxed/simple;
	bh=EPJYxciTKQ0KzFTVNk9lEMcCOhV4R6ZsGVJ4nrmcS3E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Br45A/q8I5B36XhaL2OvzIWxWoznnpNZK7ffHyrdmNdxin0lVxN3fpOFg2VyR/nXuIWjY0wXm47tXDxD+qVEkxb8AfnRQRee+rQdWbmoaZpO3hIlwRkAbiYX4Wi7Ft+h8moemkPVbwXB4OmYef0lRATo/WvaRguR0eiv3GQvUDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4aGDhtY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722899186; x=1754435186;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EPJYxciTKQ0KzFTVNk9lEMcCOhV4R6ZsGVJ4nrmcS3E=;
  b=n4aGDhtY+lFkuVePcayPrnu0hWtnXK/B6KrQAHFnqDbH7x5u9uR1rXo4
   vL5zqv2HkqXtDGlierPjkCmi1Bf/gycp6t0kvZqC2rvOjc1xyDXkXPXkE
   +1WH9tksjOpOj/mpewf9q1S1oxCxiFXyeeDBzPfMY/c8Gbs8JJ9fQaapW
   nGoPFhi7p50L8fvdp0frvqEavSj5Vg6ge9Iy64MNsrqubTIWujFuqRKl9
   d+1km4yFsead9b1dMTsVo3M0cxmlQXiaQ7byd1BILOF5KEJJHwtsYx8Pe
   ZWRBwWF2FMCPWIpAg4Xos5rndhxuU+UL9hq/BaS72pePJJ/g7jIQ3dMOo
   g==;
X-CSE-ConnectionGUID: nkXxODn6Q8GIJqgjt5nMTw==
X-CSE-MsgGUID: zZfRHb7VSk2BxYVLUJ+o8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20705236"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20705236"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 16:06:16 -0700
X-CSE-ConnectionGUID: mzCDVfM2SCG4ylNV2d8/5A==
X-CSE-MsgGUID: zjGahIBWRNGuO4YNPRVYpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56249755"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 16:06:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 16:06:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 16:06:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 16:06:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 16:06:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5TuUpSHm5PA8QCo9W4mTWA6bqtdAfvKPJFPMy2+3X0xQPzs/FfG2wmNV9+Sy1a4BXfIVNFazJ95ry38ue8q7N/Uhw99xBLsf+K4zJ5mtjfl03BGr7DKc3+dWm69HOaZI7L0XrnJE3u5s+MZMJq8ecy4fi2c7D1b8Q3JaJI902T6majSDwEjc0b10uZMNgIm3B1VGN2VKp/dDqRfHTQy4fix7Bi3nqyo7LSIpWslgEbGwlmNEKOzZg6ZJ69TdrKdwK1ghKGWnuJrPbqnETT8Y9ccdfQjc87IKVcpVWKfrYxuWNHmE10a2bvbqDZTSkKcL58xuLsbTSf1zaM4Vh4dYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksDYI1D6Zs2KUhyThF0DuHUAuvQbx9MjqVzULJNdJ6A=;
 b=y2svc2qqTvyi5Q7Sir1QNitQHT0AjkRmy+4IoAv1SIuQ5d9iKt/DL31qrE4ulMa4UvUp8w84pqCeJeLUekcorSYllBUliqSZGKBZEP5XmD4nFoS7iTvXCkyR+xP8SKRk88d7tzWojvu6OnIa+VMUDTN6tonOtIQSlZ2sPaXDSWhix4a4AA489FQQ9RECouuD/CYvBcyZxalWhBFM03LpnZW/KKnY7/ZgaoZjYbUQ++Edv+41SkZLPR2Ca1y13YeOI6vx+oVLLXBHZaZIxTS+Svl7Wkn7VkR//X7dW4a5yYUR/QtIyGVQ93jO1s5MMBDEJ9aK5KpGfUna9w7nCGz2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8439.namprd11.prod.outlook.com (2603:10b6:303:23e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 5 Aug
 2024 23:06:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Mon, 5 Aug 2024
 23:06:10 +0000
Date: Mon, 5 Aug 2024 16:06:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: Sourav Panda <souravpanda@google.com>, <corbet@lwn.net>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <rppt@kernel.org>, <david@redhat.com>,
	<rdunlap@infradead.org>, <chenlinxuan@uniontech.com>,
	<yang.yang29@zte.com.cn>, <tomas.mudrunka@gmail.com>, <bhelgaas@google.com>,
	<ivan@cloudflare.com>, <yosryahmed@google.com>, <hannes@cmpxchg.org>,
	<shakeelb@google.com>, <kirill.shutemov@linux.intel.com>,
	<wangkefeng.wang@huawei.com>, <adobriyan@gmail.com>, <vbabka@suse.cz>,
	<Liam.Howlett@oracle.com>, <surenb@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>, <willy@infradead.org>,
	<weixugc@google.com>, David Rientjes <rientjes@google.com>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>, <yi.zhang@redhat.com>
Subject: Re: [PATCH v13] mm: report per-page metadata information
Message-ID: <66b15addf1a80_c144829473@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240605222751.1406125-1-souravpanda@google.com>
 <Zq0tPd2h6alFz8XF@aschofie-mobl2>
 <CA+CK2bAfgamzFos1M-6AtozEDwRPJzARJOmccfZ=uzKyJ7w=kQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+CK2bAfgamzFos1M-6AtozEDwRPJzARJOmccfZ=uzKyJ7w=kQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:303:6b::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d3ce30-64dd-41cc-20c0-08dcb5a331fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?otFHbr6qn2Izkg7NZYePjSSyLMSkovAW3EkImYbA13+bwtERQHavZU/qLAt3?=
 =?us-ascii?Q?UFtqc+syG3Y3uZQoHUauOxX6aJtnOaV/mpCZhMXLgdZFgjuJ4GpsDn0q1urV?=
 =?us-ascii?Q?nF3rTCISsmJa94bVTSXflGmkd9xFDwTTxz6pfvrMIsRZSv1YS+WqAyonGLQM?=
 =?us-ascii?Q?9xtF6hFhEgYwZFbHsfu1SKbk3oMI8vjWB3F/sy6OpMA/rIx/HJ3Ycr8+5DvA?=
 =?us-ascii?Q?LLUCPJfwy5HJOKUoU0wO6+hEZki7AsgroqkAZl3JM7hMG4MtkMmo9OiZt87Z?=
 =?us-ascii?Q?+EbzFvp/cPZaJaaiVi87gMfb0htvCc/6l2ZyJzeAOpNgcJZHDVBtyZ/EF+JC?=
 =?us-ascii?Q?V64+qx3RLpNSzx7n/bnYxAG3Y3rURZoCoJGBuMxiUZzgghh2YDsJIc1VNROZ?=
 =?us-ascii?Q?VPAZh7u+1SD8IpudRfK4XF85pLb0hRZvqQrtf66RqGAp5x5ry3UHGrgcHUJn?=
 =?us-ascii?Q?uJAJ3iPIz5QDfKyvgQnQdOfoIdM37yKBMJlsnUZbk8rWtrkS3+AqARtP31Zy?=
 =?us-ascii?Q?iLDnVi/f7u0bUMrJlMI4lj01Vc6pN62CPjZorGJiBqpLGl9i/DwB4DOFtCMs?=
 =?us-ascii?Q?rR71Ymd2pMS92jp5FXlDQhbDP82REZ4p79Y3NpEE8UlWEngFr2RUpN0UyeCL?=
 =?us-ascii?Q?gPEDPzPo85OAeO/7j5B8zLMKju/lTsXCwZibzQfk7G0eJl1AHKW2ZRNusyAu?=
 =?us-ascii?Q?EzfUK0TbWPtLxejgSCo9iheuVE1Q14b5ZePp8ibswLXQDa6uNHDWjY9KtYAJ?=
 =?us-ascii?Q?3J5MY3aNZk37nTU6W82D7/0IsY/Cfi1iSDlOymC3V0zUatXYIXGo/CNMGcSS?=
 =?us-ascii?Q?LvHMuT4B7DJrRZ1XyR+UKytj5sN/iVR2wTKjN07EgHb70UPZzrzT779P+qbZ?=
 =?us-ascii?Q?ThoPdD2Ak+vUFy7GqufEjRUOOeryaItk0HDdCIUjamdYdORnMlp4uqAQX1lv?=
 =?us-ascii?Q?WFfn64QRny1uCkNwgIeN6YKeN0DdH7H9vZOUyWihQunlXs0Qb9q+SIVVMtPZ?=
 =?us-ascii?Q?IWwfKkJQo9ozqCzLLjr0LvfNP4QL5Cf9Box/e25Yn97M+IDECp2e4CZuwmE0?=
 =?us-ascii?Q?KfR/VI1U3qAgaErK2tFF5gH5HtWZErse5ElMePQFfdXCGgfBpp9egjx9ikRh?=
 =?us-ascii?Q?waFHP7r39yI5om+HPQj+NZ/LVrGsYa1VI0mPDSSqvUj5XB7DOV5nBepPbkoR?=
 =?us-ascii?Q?fdl9nw3dqmsDkEgRcXg1PC+f3/e+wk65Ub1tEMfR/FS2BZRKdO/8zdB0e3+e?=
 =?us-ascii?Q?kErref9ukHPutX+VqdwmS3vNMp6DnNULCsG32uoEt9H9NAwlwC6bVkP5NAuc?=
 =?us-ascii?Q?buQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SRFbNGtKedDrZeSiUkbBTk3XXWeBft8/n5220psJZ7NErdk+RvwaJovvgteF?=
 =?us-ascii?Q?JBkP07SSz224F4W989GGVed2vmKvmAKsAXI0MHStmqLPF1TjM4FluL3Wv+xI?=
 =?us-ascii?Q?p4dVQjn22CogKYU4IQNCF2aVT42gbgPSd4epUJgAQ3dFFRHrcPRtJpfKmn9f?=
 =?us-ascii?Q?NCpUqNvtJ3zoV5prnLhZy8Z/1szigohcH/vVQDxpWOqClpkU/jY9opcPcnmN?=
 =?us-ascii?Q?X9irIrh/U9iXpt2hXuvsTAf5SWlDYFHVHUM2NifZrC6EEXSt88BWSdad5lQO?=
 =?us-ascii?Q?mv0uX2LwNis2A09DGmT70ucEAdN+H9W7s9260wOx4TfKRyyCGD6c77Q/5BxF?=
 =?us-ascii?Q?J9md9ua0bFH9YY6+3nce33W62ZqRcIamjhanYfCuvd1Ke2e3+DdC6irIkF7h?=
 =?us-ascii?Q?Iw6gJDRugqSWRmVPZtUcPnWaNwPLtkyWWt7rhTyxSXWiam+M4q3BQ01Rny/0?=
 =?us-ascii?Q?I8k0ww7XCeOknv4RNSe1usUN7PcyAQ+Ldwuryk/TIYPgE014RPm/5V71ZPxC?=
 =?us-ascii?Q?bOAe/TxHy7BvXhPG3S436GMHrQhsK0LOy5JkXQDN/TLk5Ez/d8Yq1YzvJTnA?=
 =?us-ascii?Q?+5k3UHz6RzIVgKqJbLKgoc65HEJUf852nt1zvYvSMl/bi8yCTvE1z9Y/Rh7r?=
 =?us-ascii?Q?TifrwHaoVYeRq1kZzUTugNBI+PqHMbzU6RfHMJiCgB6Yfs/vBHHH4bno44Rk?=
 =?us-ascii?Q?nl8T8g1C4/PHoVrkEbmFcwuf26dT8l+lPt6B02ElD/M44ABXm+xX+oBMg/yj?=
 =?us-ascii?Q?GqkawTayDP3Lib8nSHztod8HRZyCqPV8hk3FQ60hez3sVQc7ofBd4aVcvWGB?=
 =?us-ascii?Q?9c4fd3CDHdLtXgyYs8pvF5xBy4SkYcuw2P6zIVitkQ+zBTmjXKsXVW9cwT80?=
 =?us-ascii?Q?zWHHRzzaWrXrP5y+d5p3372Xgu58zvBsFGM3uhAIYnGvDqLl4CWOGSq8kciD?=
 =?us-ascii?Q?Te9R2AgQ5c5oSuiWCHqlAf6PiauNxDggHQ+s7n5MmDaGxiWLHDBxpFlf1nz7?=
 =?us-ascii?Q?xADHhzeRMEFWzcnMNAlZMZEooZgrUdC9SR2ucVcyrO1I8YVd2Vw77pttYJZe?=
 =?us-ascii?Q?n6pHY5tV4ww6mlFUdApxUhHBaB4z6KAVZOniJO0iIXH4UvQr82MNjXTQU0lc?=
 =?us-ascii?Q?pdKtYiha7DSQmZ7fLCcnzcz/QwRNCbnisxN4Ysy1SrgsSlUOziU9uZrBKNc2?=
 =?us-ascii?Q?xIbz1jKt+eYBmYx1nkarYn9Dwck88lVI0yHPpaLr3Yvr0NKR6LshfpGGv97R?=
 =?us-ascii?Q?6QYQo1Eg9oZ0yFqX8/At2Q0glgAMXBORRW1CY/TY1Hxj5J+SsG6m+p0eukGv?=
 =?us-ascii?Q?rTr+zxbn8Pbe6RQWTIbp4VBa5B/iLdvggV4SvOCWItMooTfImdjWPfeM8tDy?=
 =?us-ascii?Q?IZFlaC1OCJp9nXk/ePPKkKTsAT8FeHeREAw+LNS8EoihR+ishs+etk7vrWsJ?=
 =?us-ascii?Q?DCX10YzfUvQVn9nAI9WCo1Vg+FslX7j26aO4oyMeMC06Cm/373WSp3lJ00gU?=
 =?us-ascii?Q?uHFY4w4Lgb38OyDvlaZ1PBF13terC6+AQPURO7vWuZBgIUwUUeoue9LGxWYL?=
 =?us-ascii?Q?8YzHLoJgLeqbEjR5Pe3b4C+vCKg6WUKY6VciVAIC+C+ttCzZI1TV4rIjEq8Y?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d3ce30-64dd-41cc-20c0-08dcb5a331fa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 23:06:10.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bkjI9us4hggLaoTVxVcI7fSSwCE3YpLncAjqSsC/mNSnSoco3DPXTRozF5mssrGtS+ejIYJU96+BRX5cTcm+kr5/dz04RivSwMxLjxr91M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8439
X-OriginatorOrg: intel.com

Pasha Tatashin wrote:
[..]
> Thank you for the heads up. Can you please attach a full config file,
> also was anyone able to reproduce this problem in qemu with emulated
> nvdimm?

Yes, I can reproduce the crash just by trying to reconfigure the mode of
a pmem namespace:

# ndctl create-namespace -m raw -f -e namespace0.0

...where namespace0.0 results from:

    memmap=4G!4G

...passed on the kernel command line.

Kernel config here:

https://gist.github.com/djbw/143705077103d43a735c179395d4f69a

