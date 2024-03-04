Return-Path: <linux-fsdevel+bounces-13425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ECC86F99D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 06:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7241F21046
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 05:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869B9BA31;
	Mon,  4 Mar 2024 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JTjF6SoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656E53A6;
	Mon,  4 Mar 2024 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709530525; cv=fail; b=IX+wP+CaELlRNG11jht2IPnfpJG93G0PnA5xkugvKFdf1hW+/i5KGtPDRBCEwr+J+XpRnldukVIHDuVy0XHBcw+7SZYiM8FmHMjUPDWSb57EKZJStduZx3ADo0qJd3jhtHat8DsmlRibmRAx+g32YKCd6kpmXLqE+9lH8fPgqXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709530525; c=relaxed/simple;
	bh=J8YV3ir412lIXpzS3abVoHSSgnnLgfW8/hycuHzInfQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dE54PKjL7SUhupE9sez6I33430HgnIUD73otSeQyP2vs6E+hHdKccUw81Qu5gZXTA/Lqn38SrMgUwf1pUqKsydTjgHT/fMfZ1Oj8HTnQBX1ZaCP7okuQ/1MSnyPrPW3nlNpJeAgDTfHnDofCPDBf8fPjSpAPMSndF2JWOOKeGSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JTjF6SoH; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709530523; x=1741066523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J8YV3ir412lIXpzS3abVoHSSgnnLgfW8/hycuHzInfQ=;
  b=JTjF6SoH/ed+5Nd6nq5mzNyRC4OweCYQ3xToipWWWpGZIYvUSJjGRvns
   xpuZcUU4xHWuTVfwgtwbqpqD0ai83sIFWFwWXPARlDXN0HDbXDSusWYAC
   Ey04t+amJjydng4uqJvFAzHOYfOpkbDWgC0Xt10mCMTl7IzQ0I2GtuvzI
   QPDfky5SIiamZvhDeQ2L7nl4bNbygb54ldbEX3UP8rmDZbhU4GjuAFOWo
   WPNJqJ+/5U4p2ctuv0MBp7azSxZu8LO0hpFWigVI1pVEXsiebpiQA9rGf
   SKhT+IrUEGhHw5GFIte09uYU18CSkpRK2IznJk6z06Qqe/i81Z1oEYNwx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4130392"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4130392"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="32037315"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 21:35:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 21:35:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 21:35:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 21:35:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhBPO4PNXF98/7FQSOFgcJK81YRuz64/eegBr6fgLU4ug2fneED7Ic5kHtqxh2kdoB65oTNIfut0WRp7z/Bj3htk53SxohTU+tyZGoCTynREmK9j4S8/NUr7GhVuXuzGMPsdIwboGvukqSpILRguHjkXPtQOgOfY5G7qM7lhsqsokX923Y9xxYxdmG7APo9sGYE2NsRnhjIKB10Am470kRFW3r0G3F/cRL+g+6KfzQLdQf9PpHFi7PufwlVQXRUTJSqqK5uc9Su7aY3m41d5WV6bVQlxMyxd2gdKXzRvP7YfwzLGLIhzaXP9v/7NXuswG/woX1XS6C6GDyqhHJHGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRL5YxpgzRlUDp0BPNQ+RBS1Qdki9DlLlMQVU5rAn5E=;
 b=NPpoaQWRPkVAUMrLcAjojjELuksRHj/GsNTtWfm1tG0t/YuA52YgjQZESoPjFuPCzOvrwuo7cRCcZaZKfLtgNpcTFpMZ2XWl45NL1FIKpjvrz2hoJ5q+VxAII0JJvvW57tF6JhUBXz8YSJ2w//Tdjjnh5tQcPnM+CBHlOJOlPvR4KmAP5bYhAxvMGHcWnUVbJyqQbEwc1v5e/LiWd/V6CdFj5+ylQ4uqYGurXH3Q+vr0vwwaFqI80XTIV1XJFJnoK3JYy1CuSQ0WeaL4lP/rIQ6yVx8Fqq6WFenztfaq3UjUDXGCPOF4nT313KC/A9URh4EuAFwOFRkNBKDM2mdK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB7524.namprd11.prod.outlook.com (2603:10b6:510:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Mon, 4 Mar
 2024 05:35:18 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 05:35:18 +0000
Message-ID: <dee823ca-7100-4289-8670-95047463c09d@intel.com>
Date: Mon, 4 Mar 2024 13:35:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [readahead] ab4443fe3c: vm-scalability.throughput
 -21.4% regression
Content-Language: en-US
To: Yujie Liu <yujie.liu@intel.com>, Jan Kara <jack@suse.cz>
CC: Oliver Sang <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Guo Xuenan
	<guoxuenan@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
 <20240222115032.u5h2phfxpn77lu5a@quack3>
 <20240222183756.td7avnk2srg4tydu@quack3> <ZeVVN75kh9Ey4M4G@yujie-X299>
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZeVVN75kh9Ey4M4G@yujie-X299>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb34912-7087-47f3-baa8-08dc3c0ce05e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vl0ijupso+f9LbiasbtGvarBm2Z75IdvNxHxy6ztho06tG0HNuWzOdFPYZFzgf12882+c9Y61flw3VkuKU1UtqVl+ZmnmYWZEisXtGebVxI9kqRZVSMQtwSMJnu1u9iurTFzQ0AgclCFvMv4bVj3Pf1ZuUGwcGhnmrwlF3HK+l8KjaoezVKnJNSrv629MagBYHcWpGptS04PDLkD8DI2AUr53l+fWK8+fcCWEEeiJyls7tlCoNStkcoXda5Q4hu4fw4LGc3E6oFCyflqBd0JEBUfLoYyE1CRzC7RZF8j2lVYRROQmYZ4zhnJQVPM8MgrH5Q/08FC5HLMlt5M16brp2m0ifnDfu3T8TFH7DJoCbxriQglfYHWhuQwDygCCEJGMU024LUengB9iNrKiIL4CD72T8PvDRu2IEJGOZzCyDPMM3W6MYvm2wBje7Q9QFhiIT8tEBmBliHmzV6hy3J2XwaQo6qiy+JcFl7Q/Vew5L9khZVp4GapX+xfQ9hJtCcgNtBgjBc8jp59Hop6WTAXlT9ZCDNsMZnswk95eHcLkjq8IjuFMykxylnOEql6OTJL+cjHMv/RsPl60EfMBkHYv8WiQ0HaZWk89JGjwaioBTzvqVlqtjnb9AbIDl7F1FgG5n9aFJow+OhP8fSiWfVY/xPHFcoAF2dhHVx70bJf5Gc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNvZyt1dEc1MnFBY1YyamJPUTU2dHEyS0VWYUVMWG0wNnc3aWpxZUt2V214?=
 =?utf-8?B?U0hKaEZLdVJJY1lQanFuUlN5YW13SXdaSjFHYmJUcjBxSFNQV2R1QjgwdDhl?=
 =?utf-8?B?UGlNKy9QR2lKWVlxUFdWTmlnRlNDUU5ya3ZiVE5nQWhYWFNWZEtLZmVsbGdv?=
 =?utf-8?B?UG1FbVAwL3E3WEh3NytrLy9DbFMyamwvRDFMYjNMeEI2Nm9ubExqV2Fsd0Zs?=
 =?utf-8?B?RStPcFNoaVVTaXcxaS83OCtKalZjOEpVMTV6QnVDdklLUEJjdmZaSDhXYWhp?=
 =?utf-8?B?Skpaams2TFhLVTNpWThNUzhEZDBOdVI1VWpNWG5sTG1VRlJiZUwwcWs3UUtL?=
 =?utf-8?B?VDNTajlpejlZYUcyVHJ5WmVUZ0FMcVByLzJ0YkI2TjBCUW9KSW1mcVJSOUI0?=
 =?utf-8?B?NFdQZXp4OXFxT1oxYkR6aklMa0F0ZHdOaW5iT2lBQld4VkYyU0E2YTQvSUVX?=
 =?utf-8?B?cnRNNWorOXliU1dzdXBuTUxTVTRKeDc0clVtMjlWd1pNWFk2SWNxQzAreFNv?=
 =?utf-8?B?MmJKOUVJekRsbzVjMW13VG83RGpvQS91dDUvUlJVcGloLzhSak54c1FrOTAr?=
 =?utf-8?B?b2VYYjNEZUY3L3dZQjZxK0RkYkhIYkNFUjkxMDAvUDZnN1I5cU9HZ1MzNjJl?=
 =?utf-8?B?WDBHVFBobTEvY0RnenNISE9jc3pRUkNON2dDQ1ptWHRmQ0l1NWwrZ1pVTDFa?=
 =?utf-8?B?Q2NDL0tNVW5mOGJJNUY5anN3RlcxNTNjTmV1UzZJdm56Umd0cm1TU2cybGR6?=
 =?utf-8?B?elNMN0I3YnFVMG5KaVhVMUtBeFJjeG0wbHBzT3d2QWRINm8xOTYyUXBHbnpJ?=
 =?utf-8?B?M1ozTlAvUTE5UEVWeitRVnVoR1djcks4RmpsM2NTNExzMXdsU2dPL0QyRmZ0?=
 =?utf-8?B?Rk54T3BBbzlHZU05NllQM0U5TEl1UVhJUU82RWxoMzJ0SmNVSGltb2V4Zisz?=
 =?utf-8?B?K3RaS2dRczhyRmJBV1Q2bmt2b3ZveW1KWTBKZjdJcDBBMThVSzZ2ZWpPNEdS?=
 =?utf-8?B?OXhuVmloUFNzQVYrd2NrOS9uQVlIZlVXWHExUERvd251WXh3RWRBeWpYV1Yz?=
 =?utf-8?B?Uldqa1FRUVA4bkJ3bFhzaVk4NHNmbFdTcjVrVGl3SEYwR0FkVFArZ0pYa3BE?=
 =?utf-8?B?ZURyZVFmMHFrdnlJdVI4b09tMnhGMmllUU5NckpESVpSZVlhbDBUOGo1V09L?=
 =?utf-8?B?MDBSWmZLT0llaksxZy9UaUtxQVAyUWppdDFUTDZzSEc0UDRsZ1EzbzNVT05t?=
 =?utf-8?B?VEpRWGQ3RlFnV25aeE5wdjVMYkYrblRFNHl1T3dxaWtQTUZrUkhLQko3eG9K?=
 =?utf-8?B?RmhaQXc2UjZUM3hNK1lTUEgrWGs4QXdUc0pQdjd1QTd5aks0em1RWStveE5I?=
 =?utf-8?B?cWtoVSsvNTd6QllPVk5Mc3FoQXhpVWZqMy8xbVR4MEp2eU5yZWZyWlo5eWpL?=
 =?utf-8?B?SUpLdCs2amgyT0NTV3ljVlhvcUN3WjhFZ3Y5TERkN0Z1b2xzZjFxaU9FdHds?=
 =?utf-8?B?RjlVbjhEQ1F0T2xHakZwQW93UmJmYm00YTlDbEZwOXkyekJwUTJ2NjFZU0la?=
 =?utf-8?B?K29XUG1kYi9vWjV1SW41MTJhVkl0R1BhMExOMk81S0wvS1h1SjExUlFpbnRQ?=
 =?utf-8?B?eGszMXMwNU5IZy9UWGZFSHVrOGtoMHMxdTMrQkQrVzQrbklvWW1xamx3T0J1?=
 =?utf-8?B?b2Y4UFFwTldHUXR5TGJrM0xVenBNZHhLMk1SMHRJNm5Hb0RMSUp6b1RER3JT?=
 =?utf-8?B?YWdraUV6M0xsb2JuMm5mYkgyeGE2VlA3UDBiNFpZaSs0dFB0STZWVnpob2kr?=
 =?utf-8?B?WXVUZVZPR2FSUFZRd0VWZ2hvUFhoR2tSSmJEUU9NeksxT3FHVXVHNXFsMWZV?=
 =?utf-8?B?VjJTeXVRZU85am5rb2ZQQ0huTGcxd0FYclpSWncvNHZnMVNvSERmNW16TGdq?=
 =?utf-8?B?dE1PUVFDMEFIbjEzOFN6MEhHNDROVUMxanA2c1NWSHdQWTVZa1RUa01tTlg1?=
 =?utf-8?B?ZTZvUXZpU2p6QTd5TkhKdkQ3YitNdTJqZStkc3lEc3FuMHRRTEQ3WTlkVm9y?=
 =?utf-8?B?TytaNjRvaE83QzZlSHJVblpMT1NrOFZaNmFqTzJoaitXalhJdk1IL2dzeWJZ?=
 =?utf-8?Q?Jk60Qw/iesSYNp+Q96upl00E8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb34912-7087-47f3-baa8-08dc3c0ce05e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 05:35:18.4197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M90CKyU6siWdcZWcWOaZCoPAnDwL5YCHvweEvPxH723fwNAbUDyUYj1QQ9xfvT4twk5hfRudR8P84scb4u3X0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7524
X-OriginatorOrg: intel.com

Hi Jan,

On 3/4/2024 12:59 PM, Yujie Liu wrote:
>  From the perf profile, we can see that the contention of folio lru lock
> becomes more intense. We also did a simple one-file "dd" test. Looks
> like it is more likely that low-order folios are allocated after commit
> ab4443fe3c (Fengwei will help provide the data soon). Therefore, the
> average folio size decreases while the total folio amount increases,
> which leads to touching lru lock more often.

I did following testing:
   With a xfs image in tmpfs + mount it to /mnt and create 12G test file
   (sparse-file), use one process to read it on a Ice Lake machine with
   256G system memory. So we could make sure we are doing a sequential
   file read with no page reclaim triggered.

   At the same time, profiling the distribution of order parameter of
   filemap_alloc_folio() call to understand how the large folio order
   for page cache is generated.

Here is what we got:

- Commit f0b7a0d1d46625db:
$ dd bs=4k if=/mnt/sparse-file of=/dev/null
3145728+0 records in
3145728+0 records out
12884901888 bytes (13 GB, 12 GiB) copied, 2.52208 s, 5.01 GB/s

filemap_alloc_folio
      page order    : count     distribution
         0          : 57       |                                        |
         1          : 0        |                                        |
         2          : 20       |                                        |
         3          : 2        |                                        |
         4          : 4        |                                        |
         5          : 98300    |****************************************|

- Commit ab4443fe3ca6:
$ dd bs=4k if=/mnt/sparse-file of=/dev/null
3145728+0 records in
3145728+0 records out
12884901888 bytes (13 GB, 12 GiB) copied, 2.51469 s, 5.1 GB/s

filemap_alloc_folio
      page order    : count     distribution
         0          : 21       |                                        |
         1          : 0        |                                        |
         2          : 196615   |****************************************|
         3          : 98303    |*******************                     |
         4          : 98303    |*******************                     |


Even the file read throughput is almost same. But the distribution of
order looks like a regression with ab4443fe3ca6 (more smaller order
page cache is generated than parent commit). Thanks.


Regards
Yin, Fengwei

