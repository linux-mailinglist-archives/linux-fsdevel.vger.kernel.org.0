Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF4364131D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Dec 2022 03:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiLCCIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 21:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiLCCIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:08:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F9A4C25D;
        Fri,  2 Dec 2022 18:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670033283; x=1701569283;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qivEj+/lZrlDfLdBvQ/+V0v2g6tFfVVC62VQkIxdPi8=;
  b=JOWlp+0nr7UZ8z4o6POz3rzZ9NoI3ZYwPG9SYZRug/qJemC1CJ9fd63L
   Sq2Qee1hmcnqaCAPXPKZldEeGeVJLqZ0ciJ+hVuj6+d+sJnfSqWb0PoTz
   yOa5qius+9Rfu7OYKQTYtNPdswX8LA7vH9wVnhQrYTMBbwydj9rTWiMqX
   qHkAmw6+suQmohChT6Hh7aA0HsQvZcR5n7eM/s0EXWGKiFMusO+w2yR3a
   ePqAsw4TgF2mphZCLXgu5invlGkvs35N311SbPYT+Ha+xv3VCBnyjxRzV
   Q2s7EBJml56ihb3oinM9mZe26GvlDRBxQFPcL9l+c2eHrGEpyJ3B1edcu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="380377686"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="380377686"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 18:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="622901795"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="622901795"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2022 18:08:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 18:08:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 18:08:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 18:08:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 18:08:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etpSh7XZSxf1+7vqXsoBNH7Kf4BULXOMJg1MdtD2dhos2JlHtaphZAslLhvOkSeFGCC19tZrvGsajI/7GcaIFzNzTejde+1q6cof0LkEAEekXmsDq+6rEZyggKwh15oS/drWoTo1rYY2E/iLDU9vRHQVLYJhK99juDZwBu+HFqLZg68mLM/DURByhfZamSgrTF9S43iA6lDZOCUNQ/BiO7JQOdajQ1AS5t21Og5HPEhe5Y7yqklOhrnxVweGfP9Z2/qwYXDeCsiVkGFdHVcNlZ2NBCydCbP1XW/l274CDdq6bqxW1E0DNJaUXYqeJqMp03aBSms03DxKF6T8NEtcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhzZMfsk8g56jHyEnO0OaXHYdCn4tUUCeZdFdPdp+ms=;
 b=nSxD2mytN2/HXvcr1dXGqBv09X4EGrMOtJL+k/ZXEP2Uut0k8eedCD1jRz1auI3Zvsgipc11w9YDYcZADfxRAaEi4e1+gla7/P6DKhf6QcLNAW1UoyPybVsSq9pEdG2j83NeU5sgYsv/+Y8OfN88K/2DpjqqR6uPzingm0LefqcKS3VtDUakBsL3NLeQ9ElpXch0QitB3uxFyY9O1AU/m9jXxVDi2x5lG65HxMsnPE3g8VXh5Xp41JLdgjgcP33fwm/HU0cZFD1LK5zzMkKPbu0nXdQeUVZtcrJ+GN4QcOgZ3J8K9xEdzk6QXWs5tzDrkBz3cyFiCztSgFcbGepW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6292.namprd11.prod.outlook.com
 (2603:10b6:208:3e4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Sat, 3 Dec
 2022 02:07:59 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Sat, 3 Dec 2022
 02:07:59 +0000
Date:   Fri, 2 Dec 2022 18:07:46 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: RE: [PATCH v2.1 1/8] fsdax: introduce page->share for fsdax in
 reflink mode
Message-ID: <638aaf72cba2a_3cbe029479@dwillia2-xfh.jf.intel.com.notmuch>
References: <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
 <1669972991-246-1-git-send-email-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1669972991-246-1-git-send-email-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e5fce3-a7aa-4135-f670-08dad4d32d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okkFIiKUTLfUs99mvdsDTuvbD9H/QWSB0F4vLO6AuFIhl8s02ZJvkZ2v8Tg9wVRW8AuZk/NjUUYcOfO3GCyZES6Lq3avrvn8Z4k+Fwk+SZZHPmWYA6Ph3gt7u59MB54RlirLFTdTYjuFzFkMfYrsUd9qxEK7EhFZB4PcPwSwEbtazJhDjOhE12y9woTVZtR0wPgzfEOzNmMai21Wti0cqnibz5OOSCou49TCxvy9ScfJ8wLrR/+nC78+TVXTTbb33q1pIHoKtiYvibK+xeFF0xq8fXR/4xPtw7GOIxOxCSCW6LW7Y2/ChT27joEbBKBkVhBhPxY+tHb7Vt08hA1IDjVkvjKQtOBE58N+6W6UZhnpCUqVORj/mfGfu7+ildgjv6xmz2bzowUu8mCcBMcOhAy8Vcxrei8LGcMIoxQpJiNUtmTXlBZhwqCks5EIyXJZ6f1ecszlk/gboCSrhXWDBsBoL+GqjRv1+5Wl9bopb6ux2L1p8eN+wug+wszBCkuXQo8Mh2tiHawU/VrwnjMHpree3ufwWJ7pFERRxMJrNQrUVSa0sz33eyQ9qqVBNnA5S1NrNeXEqy62IJoD4HExQ0dd+iF/ABAIIRtAkPcLKSnofyKyETli6GQO8MnS8R9NZs21YeGDy+j0x0R3GQeRjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(6486002)(316002)(86362001)(6506007)(38100700002)(83380400001)(6512007)(5660300002)(186003)(6666004)(2906002)(9686003)(26005)(8936002)(82960400001)(478600001)(66476007)(66946007)(41300700001)(8676002)(66556008)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVLuutlAXswYBuieaP0E5rHrPJZNnBwu4La/YXntk8jcbjZxbvQuH2scT8p4?=
 =?us-ascii?Q?Me0UWhaAISCBv5jJS03x97fGd3InUJ0UMA43QThlykLYmDuL3T6XXoLv3E1c?=
 =?us-ascii?Q?uNHHEHH/UicDwq0hWiK8Eo3clFuRAepcwxkzCzXbST7a2D0wb7VeBzCtzb49?=
 =?us-ascii?Q?XAazVQlq59WVp0Q7yxZVbrDqcjWlHR0DhzFjvdDMMNBk49XL8aIVH83gszL0?=
 =?us-ascii?Q?FAz47P25J8W2LWwvyRH8if42X/++Ef7j5ydHwcwxcZTouy2AiZkD6U1VLTWy?=
 =?us-ascii?Q?E83Xl12q0Y0r1nDIj/NESvOMqL72JDN+Lzu/FAuC8ReCnCE7FW9eBcqXDsk6?=
 =?us-ascii?Q?BOMtDGNwEwqcVKAkXxd1gczeCEtSyoZAoC3fzkD5M+einLrz5mUQEXf4BkKI?=
 =?us-ascii?Q?tr4CheT2KcsGmPCto2mrJLnB/tkQJxyeYP1CmLMWfTp21/k9cjLA1/iQEqj4?=
 =?us-ascii?Q?0e0oibi1fMfzvcc2/BJ+n6/CD4gWqQZlPHYkdHhhf/bjhL/AJJYNtkL5TI2r?=
 =?us-ascii?Q?xLofcr38hTXYQtm5ZwHA4BqTmR1mudvyJSy4Qy23L9rasnBH5UdDLf0uE9uM?=
 =?us-ascii?Q?mHl3Eto91A9UfGvroBr48HCv0mgT/T4p8MMIKlgzRzHg8CjdCZ3FByR04JVE?=
 =?us-ascii?Q?2LzitVo1tjD0mvZJwhszzw62SB8VD2foOQRNe26xe8A6V0vUbP77MKW+Mfj/?=
 =?us-ascii?Q?jXnU5HdptOOtgHaQbbzgHuUa/9O2qZZDcBnJht54/QnxnnBue5c1+Y+Drh8d?=
 =?us-ascii?Q?5JU4hBh87IeBPu0iwI1sAHr88uo6N+Kk64BzBTT0tXtj1Ye9QWDIgKlNfVus?=
 =?us-ascii?Q?1lc96MtffPl+fY+Fx4tFKOY87DlHGh9SZwi6sUBGc6UJQIhVMbEJC1C75jAK?=
 =?us-ascii?Q?Jb9p8ygCPGkyBntXIQ+YjJgmMsESTknLH8zimijJRWSrKaD1ScxFZipww8tu?=
 =?us-ascii?Q?aPijolJeGxaFGe2Dbw1u3ieEz9Gm6qgkXdpZZv5I48DfOxPTA5eUDkSiIepJ?=
 =?us-ascii?Q?RELlLYGjKkE/EC2tFgMscSVjCTFdxIyaeT/FnBDvA1UCZ2LbmLHwM1zGt9MJ?=
 =?us-ascii?Q?JKF4pwtR7MUxvWzvrjmw+eunFvWLu2IT5HNu++a/FuospukgWcMvezsrjO5L?=
 =?us-ascii?Q?zT/lBjLMwh1KHRqiqAs947g8gedtL6LMCFBYBZUmduQN6Ah3xP1BwTI2ux4h?=
 =?us-ascii?Q?Q3fFYrMNCW84frbhsH35d+VHTMZpI6/z5rXnU6Vc9rJschKSgzWSpAyClhXC?=
 =?us-ascii?Q?fs+w4d39RAiNpGh05bJBcbpncZHdt/h4zscXbWQTlIYzAE8WMoSTjKOYBJ6w?=
 =?us-ascii?Q?RoRZMkGfj23zcEfpD+WJA7D59ICfnaeY8PvxkDwus6DjR02PWMHY3ynE16Ue?=
 =?us-ascii?Q?jA5k1UZl0qJVFF9A5QeoQ/2rfFy9FjIa91QYmqptmmqlfGBxfnJGHi9qjrRw?=
 =?us-ascii?Q?dX2SQKVca1iI/SMg/GzwIqwA4pPc5HbkpLwmymJ6mng+3p3Os4cviwavylHy?=
 =?us-ascii?Q?pu/KiIarQlrFIL6ToeZgwxNydLaP73uY4i7IsHS7v28p/yBAJNkUkJ/hPNjz?=
 =?us-ascii?Q?cqSgGJfWtBPgmsHe8sPmqS0gRXQkHVws5AJKUBIeNGh2jf6mwWE7/z/jmpzQ?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e5fce3-a7aa-4135-f670-08dad4d32d2e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 02:07:59.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PYUqbSQorVLaHj2SdnBgKqQWi83x/+XsRztGjapVx4hHt/EBiE7AK1rOMQVauzMS5fmRykwjD5+7LndPynQQhbLL9T9EKnr0g2MH8IUY0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shiyang Ruan wrote:
> fsdax page is used not only when CoW, but also mapread. To make the it
> easily understood, use 'share' to indicate that the dax page is shared
> by more than one extent.  And add helper functions to use it.
> 
> Also, the flag needs to be renamed to PAGE_MAPPING_DAX_SHARED.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c                   | 38 ++++++++++++++++++++++----------------
>  include/linux/mm_types.h   |  5 ++++-
>  include/linux/page-flags.h |  2 +-
>  3 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 1c6867810cbd..edbacb273ab5 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -334,35 +334,41 @@ static unsigned long dax_end_pfn(void *entry)
>  	for (pfn = dax_to_pfn(entry); \
>  			pfn < dax_end_pfn(entry); pfn++)
>  
> -static inline bool dax_mapping_is_cow(struct address_space *mapping)
> +static inline bool dax_page_is_shared(struct page *page)
>  {
> -	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
> +	return (unsigned long)page->mapping == PAGE_MAPPING_DAX_SHARED;
>  }
>  
>  /*
> - * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
> + * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
> + * refcount.
>   */
> -static inline void dax_mapping_set_cow(struct page *page)
> +static inline void dax_page_bump_sharing(struct page *page)

Similar to page_ref naming I would call this page_share_get() and the
corresponding function page_share_put().

>  {
> -	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
> +	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_SHARED) {
>  		/*
>  		 * Reset the index if the page was already mapped
>  		 * regularly before.
>  		 */
>  		if (page->mapping)
> -			page->index = 1;
> -		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
> +			page->share = 1;
> +		page->mapping = (void *)PAGE_MAPPING_DAX_SHARED;

Small nit, You could save a cast here by defining
PAGE_MAPPING_DAX_SHARED as "((void *) 1)".

>  	}
> -	page->index++;
> +	page->share++;
> +}
> +
> +static inline unsigned long dax_page_drop_sharing(struct page *page)
> +{
> +	return --page->share;
>  }
>  
>  /*
> - * When it is called in dax_insert_entry(), the cow flag will indicate that
> + * When it is called in dax_insert_entry(), the shared flag will indicate that
>   * whether this entry is shared by multiple files.  If so, set the page->mapping
> - * FS_DAX_MAPPING_COW, and use page->index as refcount.
> + * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
>   */
>  static void dax_associate_entry(void *entry, struct address_space *mapping,
> -		struct vm_area_struct *vma, unsigned long address, bool cow)
> +		struct vm_area_struct *vma, unsigned long address, bool shared)
>  {
>  	unsigned long size = dax_entry_size(entry), pfn, index;
>  	int i = 0;
> @@ -374,8 +380,8 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		if (cow) {
> -			dax_mapping_set_cow(page);
> +		if (shared) {
> +			dax_page_bump_sharing(page);
>  		} else {
>  			WARN_ON_ONCE(page->mapping);
>  			page->mapping = mapping;
> @@ -396,9 +402,9 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  		struct page *page = pfn_to_page(pfn);
>  
>  		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> -		if (dax_mapping_is_cow(page->mapping)) {
> -			/* keep the CoW flag if this page is still shared */
> -			if (page->index-- > 0)
> +		if (dax_page_is_shared(page)) {
> +			/* keep the shared flag if this page is still shared */
> +			if (dax_page_drop_sharing(page) > 0)
>  				continue;

I think part of what makes this hard to read is trying to preserve the
same code paths for shared pages and typical pages.

page_share_put() should, in addition to decrementing the share, clear
out page->mapping value.

>  		} else
>  			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 500e536796ca..f46cac3657ad 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -103,7 +103,10 @@ struct page {
>  			};
>  			/* See page-flags.h for PAGE_MAPPING_FLAGS */
>  			struct address_space *mapping;
> -			pgoff_t index;		/* Our offset within mapping. */
> +			union {
> +				pgoff_t index;		/* Our offset within mapping. */
> +				unsigned long share;	/* share count for fsdax */
> +			};
>  			/**
>  			 * @private: Mapping-private opaque data.
>  			 * Usually used for buffer_heads if PagePrivate.
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0b0ae5084e60..c8a3aa02278d 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -641,7 +641,7 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>   * Different with flags above, this flag is used only for fsdax mode.  It
>   * indicates that this page->mapping is now under reflink case.
>   */
> -#define PAGE_MAPPING_DAX_COW	0x1
> +#define PAGE_MAPPING_DAX_SHARED	0x1
>  
>  static __always_inline bool folio_mapping_flags(struct folio *folio)
>  {
> -- 
> 2.38.1
> 


