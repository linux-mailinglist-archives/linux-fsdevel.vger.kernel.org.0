Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787E465B9F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 05:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjACEUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 23:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACEUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:20:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F16B1FA;
        Mon,  2 Jan 2023 20:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672719619; x=1704255619;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jJEcVWckPaVfl0wM8QmcplSAXUtIrt60uXSvTaE9APA=;
  b=Niy3qEDSXDrLfYGBzNkVegYLz7zLq2/HqRw25s5/eThE7qbxaP9H7Uin
   O7SvKqVPbrPRI7ZsyHwXZVICbaI0c1jQY9z9PJmjvG23rrYHQZGdTEGWt
   UCBgh5fzdFz0w3ASvUdGp/f9MJZwiBRC8MjqIGXQiOWCMC6feX/A/vCur
   FpInpZ3Z+xtDa0mSfzeI76p5O6OkDQRJWPnVOayzNnxXyaOcyEDC58gQT
   XKv08BUBmjuJHNP/3+Jm4Hsmt3wdhj2LJDFLVsEDGe5s6nqjjkGRYuYAP
   6vk47Mm86gGAOZOwCdP+Pw0LUXB0D+YW6GDwAyrwQ5znea2oqZSCmRrdA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="319284193"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="319284193"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 20:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="900032447"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="900032447"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jan 2023 20:20:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 20:20:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 20:20:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 2 Jan 2023 20:20:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 2 Jan 2023 20:20:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux4ZD7CQO/Nz9jc3mIHmLVSwK9Et6lCkIy3DP2pBnyoNth5AyKoy+aZSpaYeQOzcrdR0ofzElPm+7w5gzUoTht541eyFuRKEiQRsPRoY84lQZ3RsiIeiaqzB6sC8vEYnuqUQMAx9Pn+iAwDkkkuI/9t93sGwnaBq8jBCYvHI3e+cg4Fo3009hpiK9xhvahDYPYX5AFxQ/PF74Negojzom6krwNqrSt1k2hG/SrEeMMOPjgcpz71rLCzhvWNANvlas2LkaWNDPjIy506GIFP2pPnS/kojW5bld/3e33jpZ7xWdzujQWuapywHy3Lcj3uFaAmfb/9qDJSZoEexsryS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSBdaqHuzJLd8UMohk8vOXK7AWmdhsTXykLoKKgzUiE=;
 b=Jrfdyu9QOP7WjNagjp5Q6DklsfPtf/a/KS1XgytlyJOsHufHq9ASLecD4IWdbmTHIf6F2digcKJbTsZzTYL7tPzsly4J2ckQvOownMLY+xU7KLuxkVQ/VRBhBZITFaMF7zoFzN7p1oKuFIkDu9u/BDvQ3NMHImCdyAG2uqEqLs3kz4OgLMq9KsHfe4dA9TYJOHJE2rw9stqjyX4xgH/Ru15Cd2TDx0y8oBkHb/fm73ZfRex1ZKJMycSVSiKJpPEFOrVFhMhExT828t1TpqqtnPe0y3Q+FWq5lwBzOHKQ3hae5T0VDCZgD0JCrJqKofSQVdeffOY5vdbjN4COpJmqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5458.namprd11.prod.outlook.com (2603:10b6:610:d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 04:20:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 04:20:16 +0000
Date:   Mon, 2 Jan 2023 20:20:11 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jan Kara <jack@suse.com>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/ext2: Replace kmap_atomic() with kmap_local_page()
Message-ID: <Y7Os+9kkU9Scnfss@iweiny-mobl>
References: <20221231174205.8492-1-fmdefrancesco@gmail.com>
 <20230102123411.a7xgfocrbr56qruh@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230102123411.a7xgfocrbr56qruh@quack3>
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: f17e4b48-6999-4ac0-a071-08daed41d0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDcSPDWGuyfJt3zi0FFbCP/lafjUJ6HxB9pU1pPzrdJ9w8k80vyBUsJibtum0+jFqcKLyMiYlIDG9znJ/FSiVkDNfHE9B3qKHIpg2SGJkl0kZkSSuavnr70xvQvi8J6qhozkFk0lsAEzibGhU+nBtVK7R4KmFVxi7F1PEcBGOa/xyty13jQbgvEO+QpUSAg36oq+094gj870Ch0g4FlkKziWknFG5OaErdNZSRZk3Uk1wS7I3H6rdMA+X8Jalxnc3cn9oh3ojkXdKbGd8inOP89Grk7JgmkJLPU1uOPB+zer0kxVhEe3pJ1NChEXmRgadqD6eTwsTOHsI5t5VxJlHwQnpZ7EwfQ/v2uQVQX9GCvqwCG557kYphZayKr4Mxqwe5xGt1YbyCjmGjXo8at3unkMpfaydJH1LT1UHRs31UfGPWp8WFFcvRb0EK3QVMY0v4cgZJGrnAIWiJ6AMKOPTKefmTfMLcR0LUt40YiA7o9mzGiG51KaHBeS/doAwVmcZgoFVW5jvLCmkaErPz+H4xjvTTlm37iZQxLIoKvNOxSlug2EIjg/R69jehBAgJLDCcmeszrlSmh1m8yw7pj91FHeSoD0eshr11Z1cQK6vPpy1E64w59WUDxnQDW/rZALCE9f9HoBTfXhOEJ1PsSdgcKTaXiT/QJAFbUQmhiaCJorFkkTfXLHfT+vhUobHvTzpiuCWXPXbiXMp/BYmqtBiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199015)(66556008)(66946007)(4326008)(66476007)(8676002)(41300700001)(54906003)(6916009)(5660300002)(44832011)(8936002)(316002)(2906002)(6506007)(6666004)(478600001)(186003)(26005)(6512007)(9686003)(6486002)(83380400001)(82960400001)(33716001)(86362001)(38100700002)(22166006)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fUXl0dWyw4Go2GEhi557PBaGnRZY1YH0BBWtt/E9RPyqQUXFC/oqOlGGPJZq?=
 =?us-ascii?Q?ljxy6cYZJ8HIXKWxBU+nCwAQBHbrYbEiG35bnxN/W38i5SQf9HYTpxdemPpd?=
 =?us-ascii?Q?a4bUpAThjwBTGzrsaVPuSazxugTOczBYSaKEDF1b2wMs6TaRPFRAcjTdq7+G?=
 =?us-ascii?Q?wTnQtC8n67EDWEgkpIojNZI7wlIwphqdSp+wp5z/kJB3TPAp/c5oYfo3ptmb?=
 =?us-ascii?Q?9+TCxn8sr2Z7PvdUzv+Uuj87ovqtFRFC0Y0X2BQ2Qsptj2U9qXC0qXKvnXUm?=
 =?us-ascii?Q?CKCQmyAD47uTA8jlqplJ8xcOoETkdY4wuYo4oZv4BJd3qG5OlLjHscbr+jEv?=
 =?us-ascii?Q?1Oef3veK72xSWckIGMbJDx7UVBMQeyT1yirmvfz31budgPrUSVmzdBfUYzda?=
 =?us-ascii?Q?M/3VnE8pu5Kr/nMgzeaZCK/YfPYjc3IaWynSi6otmvaQwtBbdKYNxd9bhbDc?=
 =?us-ascii?Q?JcwjJXbtNYWNUKsW6x7QSEKtHR3i30NfslbxSluShIV6k8LVyUD/vWj5yN07?=
 =?us-ascii?Q?hykBkfUJ2ZKw0bL76V27pan9flUekdwPRm2Q5Kp29FSrNGSAjRDm8h4bp69L?=
 =?us-ascii?Q?8oAI3btupdGCA95U1iu0E/6KzMGkghqHA6mc28gpa+ZBVPohZ8tXfNAHRb4M?=
 =?us-ascii?Q?uRB6G+ycb5TYpaokYp7fu2GRK42hRYTyYdMRZg+RbT/fa3KGSxlKb08NcMHm?=
 =?us-ascii?Q?F/bxBXWmmHGEPwOfoFwzOTTXxvkc0Bno9ARcjtq6EEzts/QDb6DZhJ4NGpjD?=
 =?us-ascii?Q?aB9pV35+S6g23ESsLZZXdSrwEX4GhF/aDh1/77piN7vlCG8LZfCI4lGUNvmx?=
 =?us-ascii?Q?hQ/bXwINCMp8TaMwQ6v6PzX/SOoilRkzCYvXTQ3MFQ3EZTT7QhL3tRukVqIu?=
 =?us-ascii?Q?EP2NmphZ8xrsj5NdU+FTqKQczYWsRbINOm9hpOcL/BNrnTu/kUUNxx1oevAG?=
 =?us-ascii?Q?KA7DXO/yV+C0sqRl91J05XzDNUcNRVq+wzUj+wRLAUxTVkb+jdzoxKlWNcHC?=
 =?us-ascii?Q?r1qvnrJUSxCk2YMJKG1B9E55yNrmVIKiF1nyRHrRh6jqAOIOfOe3yZeJpFxk?=
 =?us-ascii?Q?f+7JPAADTvTlSe/xGJxyO7LAke3mRqYt7nGILS1IuNpIu6QbEbita/KIj6bk?=
 =?us-ascii?Q?S6njveb034JKKpy6c68Ux2uGa/3yj6lVqvsfSSm8tm9o2KIyuXNLYFbB4wZi?=
 =?us-ascii?Q?+R0utRnYoNykk7huMCZ4zgxGGGm6WD0LjWCPku7xk2ZTOpUUOAIgF2EoEggx?=
 =?us-ascii?Q?jq895OnOrhN0YdqQsyNrt/w/DKj4HkzvG4OvE/Hc+118XLVks9KADce2yuex?=
 =?us-ascii?Q?6kLqaWEe3kM15AzEuPqWR5JOIghcOSnlQrapFwz65kzk9Itp/wA66/kbHH0A?=
 =?us-ascii?Q?8FOXgTlHqtaBo5NKi7cgKbL3Z3A/Yb0gGjtADRRNF5dclqVdMX2+i7LBKE8v?=
 =?us-ascii?Q?b2ve4tHQH7U2owpKqXKaBFiKrkE+KBic1cav/tknUi7ehKPFCJd+zfjzjYQk?=
 =?us-ascii?Q?BRWo33AFU+B7gCoIXdqxLMKPOM1dTrWqfwY3eBUEWYv8ZaDyVXzTxJl1Xs3x?=
 =?us-ascii?Q?sGaeBzWm0FAZDCq3tA7Ib1W7Nndwyi0T/T7rT3yF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f17e4b48-6999-4ac0-a071-08daed41d0ca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 04:20:16.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hjbLoScCBNp8uADsXRl76eDk9X5wX4mMXPJghgmPHjPHctH/lUtaFlSeYg1HB78P2W4VbaqMtKqsqEyGSW89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5458
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 02, 2023 at 01:34:11PM +0100, Jan Kara wrote:
> On Sat 31-12-22 18:42:05, Fabio M. De Francesco wrote:
> > kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
> > replace kmap_atomic() with kmap_local_page().
> > 
> > kmap_atomic() is implemented like a kmap_local_page() which also disables
> > page-faults and preemption (the latter only for !PREEMPT_RT kernels).
> > 
> > However, the code within the mapping and un-mapping in ext2_make_empty()
> > does not depend on the above-mentioned side effects.
> > 
> > Therefore, a mere replacement of the old API with the new one is all it
> > is required (i.e., there is no need to explicitly add any calls to
> > pagefault_disable() and/or preempt_disable()).
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Thanks, the patch looks good and I'll queue it in my tree. I'm not sure why
> it got missed during the initial conversion by Ira :).
> 

I could claim something smart like I was focused on kmap() calls only.  But
let's just call it laziness.  ;-)

LGTM

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 								Honza
> 
> 
> > ---
> > 
> > I tried my best to understand the code within mapping and un-mapping.
> > However, I'm not an expert. Therefore, although I'm pretty confident, I
> > cannot be 100% sure that the code between the mapping and the un-mapping
> > does not depend on pagefault_disable() and/or preempt_disable().
> > 
> > Unfortunately, I cannot currently test this changes to check the
> > above-mentioned assumptions. However, if I'm required to do the tests
> > with (x)fstests, I have no problems with doing them in the next days.
> > 
> > If so, I'll test in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> > HIGHMEM64GB enabled.
> > 
> > I'd like to hear whether or not the maintainers require these tests
> > and/or other tests.
> > 
> >  fs/ext2/dir.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> > index e5cbc27ba459..0f144c5c7861 100644
> > --- a/fs/ext2/dir.c
> > +++ b/fs/ext2/dir.c
> > @@ -646,7 +646,7 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
> >  		unlock_page(page);
> >  		goto fail;
> >  	}
> > -	kaddr = kmap_atomic(page);
> > +	kaddr = kmap_local_page(page);
> >  	memset(kaddr, 0, chunk_size);
> >  	de = (struct ext2_dir_entry_2 *)kaddr;
> >  	de->name_len = 1;
> > @@ -661,7 +661,7 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
> >  	de->inode = cpu_to_le32(parent->i_ino);
> >  	memcpy (de->name, "..\0", 4);
> >  	ext2_set_de_type (de, inode);
> > -	kunmap_atomic(kaddr);
> > +	kunmap_local(kaddr);
> >  	ext2_commit_chunk(page, 0, chunk_size);
> >  	err = ext2_handle_dirsync(inode);
> >  fail:
> > -- 
> > 2.39.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
