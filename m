Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D74E6593EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 01:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiL3Auw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 19:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiL3Aut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 19:50:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C61BD4;
        Thu, 29 Dec 2022 16:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672361444; x=1703897444;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nQDCmtWnCwH6kqjwThhVrOat77aER3JgxHJRnrXpHyE=;
  b=Yhd/IAYS8NXjC9D5CU1Y5OWQznMw9tG0kpoKW1fVaaLLP19gVAGAESnG
   sWuUxytWoZAZm6fIjw3wvZXzern/TOXQysfWpYiMc0oPqX4M4VZ+KmIZp
   mQz/3D0Eu+qli7IkFc0tffgQzSsdS6CVXpTysB+k8tQAWXnj2G7p+8xfP
   5aEpYJgbDCZ4hpvo2FvMd8iE0lzKj0jVFDsxZ43Z8u6p+x29JuuvsHREu
   Nq84+qreukIp6o6dsAzG4oT7n9fAj+GJn/2DnwLDgQhz5Icuh4+vE35cU
   1xyMgHkxW3Ocg2oGwexReDXDAZOcTOWIXTh65VSgd0Z5RQU4F8MLc65K/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="348347286"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="348347286"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 16:50:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="717047220"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="717047220"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 29 Dec 2022 16:50:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 16:50:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 16:50:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 29 Dec 2022 16:50:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 29 Dec 2022 16:50:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKFxtUdiBukce1reVbCMd7jwICm+VBupXDB+dg5Gj7NYzR1nxFwBYkApQScwztLyml4o5VthxvyTVBYbR3II/SaT7hU9k75JcEL8xbaK/j4yHZVvjlx8WMOtBlf2/TlHYcolFTninekqHer9tGs5sf8AXU2nmpMiMF8cczxVKAXQrbY400IflxpSMir93BcXDjDVgz/71c7r2aCi6fbgTwttIQ6fVO6reVItzUJDIlhUGl96JKG2dKQwBm7CIWWX7jlmUVBpSRzzlZpmWVNAUEsrkBHDLK5hCZMqkQJmjJrPc/5WIlNVkHnqWML5O8KetQsjiwtqdqWKA9k4ZVCvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNr4yUq57Z9Csi+aOBUAVXiq5rT9QwUMCa8fhKX20T4=;
 b=geCHHvy34qBLBXx29Hod7HqUSPXc9tsm3lW41lezD7zrrZtlTCd9rIR7GlnZhHMl3EjR6qKl+o1ICgvdJl68T1tM84VvI9oZV+OJHo5+RJyukZOvTXTcbLwMNfsekuCB1Moly0yDACtAl/siIe68f/DemVBMbaRfmAjLHBQAx8BC5HZQDxc85iJz9dobHODTy82sGzfB690wnrFl7dpSDD8kClBcB/XgfAzHeOMuWFq0GlZfsuqhWDNL46wEgr4m4IWxCgGFhd3DpPReE9hS7k/ziQ5UZwzjk7YlqakfGb8p9nztaz8B6fHAig5V+tt8GZxevlnoCCezEBYbPk8Uzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6911.namprd11.prod.outlook.com (2603:10b6:303:22d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 30 Dec
 2022 00:50:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 00:50:38 +0000
Date:   Thu, 29 Dec 2022 16:50:34 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <Y6412msL6ta19+pP@iweiny-desk3>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com>
 <20221229225100.22141-5-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221229225100.22141-5-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 64263887-501d-463e-225c-08dae9ffde59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6S46A5kqbt3e80MjuBaKwvmsRCwM6lsqmmTnTEk48FibfD4uUSJXajjNJScspN1dP205ODCOXoi/biMGmmNyxqkn1mmg8QbP42tWP9UChLjHezZkA+QpfmfuJ4UMniwKxGzSFXMdvmeLTfBZFTiCDubUV/H8q9yMkhSE9gOzpVAHp8EraPRd8IRgrReAie6ge9Rce2bdn0zUsqJUdPct6+uehGksogEAoWdOBeW6hqm3Q5Eus2GPeL8YaFsgWtuW2gP+cdoZaf4SVXUN+BmW6kueoAzWH6mXytmuj+BsSuB873QzLjIro+xYk6m/LBlhUM5/yBKbXNeN/CA2uXeghZAGH5+nEHR762c666tE3DuTe0XvN/OZWOToU2yQlDDXfZ50yJfYYfSyDCGxplfiewGHhyI/jsRUwtgPmb7tJgfl9/WFSuqXsDFKaF+LpQ+CIH69MoPPG/brnznGz6BlsBtgbV+aecrBffPakPkYbOWt7acgMmZ6slzB8BPUSyknBBISGYqQUjfaHmkOAagBRZgBRdOtHlIXndnkjUX7V2iZF+jNSuS7PgfnmynCUchRLhq3N8HT9DXMcgQpPKsPXDKLTvqVo967W+lKg5wtV0tmaWSR0ZkEKFWPsJJmS4aZEN1crgz13EskG7XMTfpX9MX/8a/83Bf/CT7ibEEGilOmBei/VaZAHDj7m+xYTob
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(26005)(186003)(9686003)(6512007)(478600001)(6486002)(316002)(6916009)(54906003)(6506007)(6666004)(66476007)(4326008)(66556008)(8676002)(66946007)(8936002)(5660300002)(44832011)(2906002)(83380400001)(30864003)(41300700001)(38100700002)(82960400001)(33716001)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUQ5Y2JJSzNhL2M4bnpqbmgzOFhTakd1Z29sRFRzZXBZUUZ4UWJaZlNFSVVI?=
 =?utf-8?B?MVNCRVdkR2VwTnI5NTVERGlmRDVaT2lqb29yenRQY21Sb096UlI1VUowKzRn?=
 =?utf-8?B?Mlo4QmtnVG0xVjhnY2ZrRTBlRmd3R1hXQ1diUUI1MVZERk9ad2p6dXJFVDBJ?=
 =?utf-8?B?UHVOMks0eFVWczczOTNRQjl5ZEppQW5DQStkRTZQZzQyTzVPLyt2Z3JsS1Zy?=
 =?utf-8?B?UkxpdjJ1RnNxVmp0dFJSbkY0QkM5c1hpelhQWnBYUjdtZ282ZFdSSE1HQStM?=
 =?utf-8?B?MmVzd1RpTElnM1FOdCt6VUFFaFVJQVQ2UmdLaXpLZkFPR0ZpejlMZmZlTnF3?=
 =?utf-8?B?L2dhdWZtOGpnWkpQSHdMbDhqczhTWmVaWWQxTjd1Q2pMbFhBMEVhNi9CTHYz?=
 =?utf-8?B?amRkWExvaisrclpEYS8waDNReG5UcEkxeGEwRkJaVGpjcll0dXJ4MWNZNXJI?=
 =?utf-8?B?MFZtb3ljM1BoYmwvV2xudzYyRmRnOUMveUpCSFhiRWlwNGNVUmtqUWVGb3Js?=
 =?utf-8?B?M2tEUzFKLzZvL1B6QXk4RHNPSEwzaFNJWGVXbVVRcDBjZlI1T2kvKzhSVjI1?=
 =?utf-8?B?N0k1YS9iNmJrcXdoU0JpM1A1Y3JENHRBZlRIMHczTVVFRHBXQkVZK2g4aURM?=
 =?utf-8?B?S0tRNVJXMHBFVXhpSDZOREs3RkYwVy9JN0k4bkMzMG4vWXNyVzE1S2ZVQzk1?=
 =?utf-8?B?TWNpY2lqamNnQ2RzN0NxaHk1eC9RUFB0KzNCNFNUdDhiSUNBT0hKNGtsTGRM?=
 =?utf-8?B?K3ora0d2MmlGcVlxckxnc0FyQVJBVE0xVkFrR0dIV05nZ2pvM2lGUmNUQVJo?=
 =?utf-8?B?aVBRS3c3MzJCNHcvK2lSQmZXOUlEOHFjd0NrU2tBY1pWUERnUUJXcDQrM1lU?=
 =?utf-8?B?NjVkdlQ0bFdSUms1T0RlVko2M0Q4ZW1ZUnNIVVlmRlg0bjZJYTBXWUtCck1K?=
 =?utf-8?B?RXpyOTdWb3RkSjY5RzVTYndaYStIcTc2ZGtNb3R1RWZ3L2sxS2t3LzhCMkJm?=
 =?utf-8?B?TmFKWXVEZjFrVlBPdzNaOXN6WCsrN0ZrLzg1LzJSQm1VT1A4VEFMMXBGb2ZM?=
 =?utf-8?B?NVZoMHRWL1hyMjA1L2NHdmVkS2xNNkQwS0ZFVStRLzNCSmRwcGlMWVRyazdq?=
 =?utf-8?B?SC9aZWtsNmFWR0dWZmJXeFJKVDd0K0Y5UURBbVUyMDVJbi9VakJ3OEE2Ukdu?=
 =?utf-8?B?eXZTcFYzNlRsNEM5ZmxrcEVWU3ZFQWIvaTdHZG1VWGJUeFEwVkFwVEd2MTlT?=
 =?utf-8?B?TFc3d1hsd3VSN0V6Q0djMzJrajI2T2N0TE1yUm1OZjZRWS8vSWp4TUp4clJq?=
 =?utf-8?B?dzhGN0loTHdrL1FwM2tOWmZ2VHdQYkphRHBLTkd5RlBKY3JwWEhaQS83SUJE?=
 =?utf-8?B?SW5nbVZzcE9kUWdOYTRkSnZudG1sTWhSR2tFRlJ5bno4TWNHamRmMnU0VjZ2?=
 =?utf-8?B?eWM3SWRDTWwzSXp6S242NTltQ2FhVmlyQmRGaEVlWm5uVU40ekE2ZVV4RGhR?=
 =?utf-8?B?Q1IyY2FJS0IzRlJtT1AvWmc5b0czcmFhYXpPUm84MUlvT0NGU3hwRnZBVzkr?=
 =?utf-8?B?WURwSWVpT056T2ZZa2djTTRnczBCK2phY1plSnlsUUo5bzl0b3MraGZ5Zmpv?=
 =?utf-8?B?TXQwbnBtcGFzQmRKWGxtWURoMlF3WTYrc1hGRFZYZ0FYVkdoVmYvVXB2ajBv?=
 =?utf-8?B?TkozbjBldnNnM3pxeFkyb2wwbEdURVhQR1g1amt6eWZyYWgzTm1CRGE1NFk3?=
 =?utf-8?B?MHhUazNMbmtlTUYxQnFGR1Irak4vMGVDM3ZSTVJkNG00Rmp5NU1pTXA2bUNF?=
 =?utf-8?B?RjBwaFVPWG5PbU5RbGZ5bko0SDNKVGhPWGdNVisxRWJEbVBkTzIyM0FCS3VX?=
 =?utf-8?B?eGNFOTdTVXdtVCtxeGR5emMvYjVYZmR5T2hGYmRMdjZ2dThZMEg4V1BqVkwv?=
 =?utf-8?B?MVRaSDBzVU1Ic2ZZcmtkTVE1QUl3a05kQ3g3T0JhR1pnZ0trcFJBSFR3WUo2?=
 =?utf-8?B?UEtTWTZjbUhzQjJDSkE5QXA4dnJ0WFJxWHc1aXc0QzNndy8xa3UvWGwzNmVC?=
 =?utf-8?B?M1FIWitwY08vNmYvV3RBMVY0RnhCZ1N2Q3B5ZTh5RDhmRFQ0ejNNanNXZTJO?=
 =?utf-8?Q?SE3sLvQ1v9nv7tYa4PFnSOibQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64263887-501d-463e-225c-08dae9ffde59
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 00:50:38.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgz9sKVdaBsLjiSMeGHpBnhuDGCa0hNrqBbcMjSUJ4p+M5843Shuj2wrGVwpXbmDFXr98CqGc/5FLdM/aFX9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6911
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 29, 2022 at 11:51:00PM +0100, Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> The use of kmap_local_page() in fs/ufs is "safe" because (1) the kernel
> virtual addresses are exclusively re-used by the thread which
> established the mappings (i.e., thread locality is never violated) and (2)
> the nestings of mappings and un-mappings are always stack based (LIFO).
> 
> Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
> requires the mapping address, so return that address from ufs_get_page()
> and use it as parameter for the second argument of ufs_put_page().
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ufs/dir.c   | 72 +++++++++++++++++++++++++++++++++-----------------
>  fs/ufs/namei.c |  8 +++---
>  fs/ufs/ufs.h   |  2 +-
>  3 files changed, 53 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 0bfd563ab0c2..8676a144e589 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
>  	return err;
>  }
>  
> -inline void ufs_put_page(struct page *page)
> +inline void ufs_put_page(struct page *page, void *page_addr)
>  {
> -	kunmap(page);
> +	kunmap_local(page_addr);
>  	put_page(page);
>  }
>  
> @@ -76,7 +76,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
>  	de = ufs_find_entry(dir, qstr, &page);
>  	if (de) {
>  		res = fs32_to_cpu(dir->i_sb, de->d_ino);
> -		ufs_put_page(page);
> +		ufs_put_page(page, de);
>  	}
>  	return res;
>  }
> @@ -99,18 +99,17 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
>  	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
>  
>  	err = ufs_commit_chunk(page, pos, len);
> -	ufs_put_page(page);
> +	ufs_put_page(page, de);
>  	if (update_times)
>  		dir->i_mtime = dir->i_ctime = current_time(dir);
>  	mark_inode_dirty(dir);
>  }
>  
>  
> -static bool ufs_check_page(struct page *page)
> +static bool ufs_check_page(struct page *page, char *kaddr)
>  {
>  	struct inode *dir = page->mapping->host;
>  	struct super_block *sb = dir->i_sb;
> -	char *kaddr = page_address(page);
>  	unsigned offs, rec_len;
>  	unsigned limit = PAGE_SIZE;
>  	const unsigned chunk_mask = UFS_SB(sb)->s_uspi->s_dirblksize - 1;
> @@ -185,23 +184,32 @@ static bool ufs_check_page(struct page *page)
>  	return false;
>  }
>  
> +/*
> + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> + * rules documented in kmap_local_page()/kunmap_local().
> + *
> + * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
> + * and must be treated accordingly for nesting purposes.
> + */
>  static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **p)
>  {
> +	char *kaddr;
> +
>  	struct address_space *mapping = dir->i_mapping;
>  	struct page *page = read_mapping_page(mapping, n, NULL);
>  	if (!IS_ERR(page)) {
> -		kmap(page);
> +		kaddr = kmap_local_page(page);
>  		if (unlikely(!PageChecked(page))) {
> -			if (!ufs_check_page(page))
> +			if (!ufs_check_page(page, kaddr))
>  				goto fail;
>  		}
>  		*p = page;
> -		return page_address(page);
> +		return kaddr;
>  	}
>  	return ERR_CAST(page);
>  
>  fail:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	return ERR_PTR(-EIO);
>  }
>  
> @@ -227,6 +235,13 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
>  					fs16_to_cpu(sb, p->d_reclen));
>  }
>  
> +/*
> + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> + * rules documented in kmap_local_page()/kunmap_local().
> + *
> + * ufs_dotdot() acts as a call to ufs_get_page() and must be treated
> + * accordingly for nesting purposes.
> + */
>  struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
>  {
>  	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
> @@ -244,6 +259,11 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
>   * returns the page in which the entry was found, and the entry itself
>   * (as a parameter - res_dir). Page is returned mapped and unlocked.
>   * Entry is guaranteed to be valid.
> + *
> + * On Success ufs_put_page() should be called on *res_page.
> + *
> + * ufs_find_entry() acts as a call to ufs_get_page() and must be treated
> + * accordingly for nesting purposes.
>   */
>  struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  				     struct page **res_page)
> @@ -282,7 +302,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  					goto found;
>  				de = ufs_next_entry(sb, de);
>  			}
> -			ufs_put_page(page);
> +			ufs_put_page(page, kaddr);
>  		}
>  		if (++n >= npages)
>  			n = 0;
> @@ -360,7 +380,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
>  		}
>  		unlock_page(page);
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	BUG();
>  	return -EINVAL;
> @@ -390,7 +410,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	mark_inode_dirty(dir);
>  	/* OFFSET_CACHE */
>  out_put:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	return err;
>  out_unlock:
>  	unlock_page(page);
> @@ -468,13 +488,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  					       ufs_get_de_namlen(sb, de),
>  					       fs32_to_cpu(sb, de->d_ino),
>  					       d_type)) {
> -					ufs_put_page(page);
> +					ufs_put_page(page, kaddr);
>  					return 0;
>  				}
>  			}
>  			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
>  		}
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	return 0;
>  }
> @@ -485,10 +505,15 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>   * previous entry.
>   */
>  int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
> -		     struct page * page)
> +		     struct page *page)
>  {
>  	struct super_block *sb = inode->i_sb;
> -	char *kaddr = page_address(page);
> +	/*
> +	 * The "dir" dentry points somewhere in the same page whose we need the
> +	 * address of; therefore, we can simply get the base address "kaddr" by
> +	 * masking the previous with PAGE_MASK.
> +	 */
> +	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
>  	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
>  	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
>  	loff_t pos;
> @@ -527,7 +552,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
>  	inode->i_ctime = inode->i_mtime = current_time(inode);
>  	mark_inode_dirty(inode);
>  out:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	UFSD("EXIT\n");
>  	return err;
>  }
> @@ -551,8 +576,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
>  		goto fail;
>  	}
>  
> -	kmap(page);
> -	base = (char*)page_address(page);
> +	base = kmap_local_page(page);
>  	memset(base, 0, PAGE_SIZE);
>  
>  	de = (struct ufs_dir_entry *) base;
> @@ -569,7 +593,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
>  	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
>  	ufs_set_de_namlen(sb, de, 2);
>  	strcpy (de->d_name, "..");
> -	kunmap(page);
> +	kunmap_local(base);
>  
>  	err = ufs_commit_chunk(page, 0, chunk_size);
>  fail:
> @@ -585,9 +609,9 @@ int ufs_empty_dir(struct inode * inode)
>  	struct super_block *sb = inode->i_sb;
>  	struct page *page = NULL;
>  	unsigned long i, npages = dir_pages(inode);
> +	char *kaddr;
>  
>  	for (i = 0; i < npages; i++) {
> -		char *kaddr;
>  		struct ufs_dir_entry *de;
>  
>  		kaddr = ufs_get_page(inode, i, &page);
> @@ -620,12 +644,12 @@ int ufs_empty_dir(struct inode * inode)
>  			}
>  			de = ufs_next_entry(sb, de);
>  		}
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	return 1;
>  
>  not_empty:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	return 0;
>  }
>  
> diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
> index 486b0f2e8b7a..7175d45e704c 100644
> --- a/fs/ufs/namei.c
> +++ b/fs/ufs/namei.c
> @@ -250,7 +250,7 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  	struct inode *old_inode = d_inode(old_dentry);
>  	struct inode *new_inode = d_inode(new_dentry);
>  	struct page *dir_page = NULL;
> -	struct ufs_dir_entry * dir_de = NULL;
> +	struct ufs_dir_entry *dir_de = NULL;
>  	struct page *old_page;
>  	struct ufs_dir_entry *old_de;
>  	int err = -ENOENT;
> @@ -307,7 +307,7 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		if (old_dir != new_dir)
>  			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
>  		else {
> -			ufs_put_page(dir_page);
> +			ufs_put_page(dir_page, dir_de);
>  		}
>  		inode_dec_link_count(old_dir);
>  	}
> @@ -316,10 +316,10 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  
>  out_dir:
>  	if (dir_de) {
> -		ufs_put_page(dir_page);
> +		ufs_put_page(dir_page, dir_de);
>  	}
>  out_old:
> -	ufs_put_page(old_page);
> +	ufs_put_page(old_page, old_de);
>  out:
>  	return err;
>  }
> diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
> index f7ba8df25d03..942639e9a817 100644
> --- a/fs/ufs/ufs.h
> +++ b/fs/ufs/ufs.h
> @@ -98,7 +98,7 @@ extern struct ufs_cg_private_info * ufs_load_cylinder (struct super_block *, uns
>  extern void ufs_put_cylinder (struct super_block *, unsigned);
>  
>  /* dir.c */
> -extern void ufs_put_page(struct page *page);
> +extern void ufs_put_page(struct page *page, void *vaddr);
>  extern const struct inode_operations ufs_dir_inode_operations;
>  extern int ufs_add_link (struct dentry *, struct inode *);
>  extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
> -- 
> 2.39.0
> 
