Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE964FD0B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 00:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiLQXdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 18:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLQXdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 18:33:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B7E02D;
        Sat, 17 Dec 2022 15:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671319992; x=1702855992;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zP2djP5sk3/PWieX8Vflq//qGwxRyh/AMBWAVcHRBQI=;
  b=IiORlZOr7hkFl/NLA7ofL0/i6mE08xNAWt3WaLL1Lvm40tPeu9VJL2FQ
   bkIeztaSPkD4HBDCD5QcaMfuSTBe0wdCcxx17mjWYrm7/Lr3pctqXkEAb
   zCQVmhR/5BBDXM76blGq5+5QyTAT6S+q6nmATtj2oRi6YEh6kEoxYAtWD
   4m3B889ouo65HrO0WvclXcIYfLn++g20OxwpgF/hIxI93yXlXuOjkfuJG
   zy8uwIJb2soSyo1daLgHmeDeTnGC7aJUYWx5mZRsXu70ZzU+1dlsLDBHU
   UlYhmg9OpeCZ3XUMUh8VKmU1fHI+e7GN81RvJC6A/OZCxX5okjMnWGWBb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="298837424"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="298837424"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 15:33:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="713629474"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="713629474"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2022 15:33:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 15:33:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 15:33:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 17 Dec 2022 15:33:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 17 Dec 2022 15:33:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBR10VjQwZ34yJUFylbNQe+J6l2KISVvxaXrg4ZKz82eISzeMmNRGjvS0oaEgC4q+JK5yifW1Bhqe/dMPf6998JG5oQ9lgjGgRk48Wha95MP4WtzuIjni0HunrvxwPoBZ5YoOFO/O/8sqO47mPbCFsFBWOF2+5k1WRbvieH6c9iHmoisOFslRclWfCdFzZFseIpQBvMaBL+nIBpMVRYehVGatBu23Wue8MX1IU1n305c2vo1lbV/NS2cCrjno9cC1L/AGJwJM2FfMibOaVROWYClAfDXx0tAUyAB28+SzdOxlrqT46U8uiBB3vTrp2/Q3SAd3gM2amf/580Dttz/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI6C50bEHgqvEl0QCHUV6PrhwUqDSKyUXIwvJoQZVO4=;
 b=Ngzg/ymYHWqpjUVJZZ9M7ZzePzDUe81Cbevq5+qmUmoWWvjIaRaCHQPv5Pb3orTSrIZsrb0E1yTKUiBnL3nH3xtUdYaJ91RWW8rHLkjPyRbDTAYZcO5P2SLeoPMyuSLMq5XCX2FSCzo77OIEiHr7AfQEs9LDqDrcwaJlGXKKW7vR/Mvk4neaX0CuRZzjYctNTXxm/N/aemtfLMgsBFVXOUInJrRulXGGeJfTyalz1w7aQ46kW2GvpqBcY6vIBuen2wzh/MiQ9yyQc2ApL3cdag6F5EcxcNFjr9AE9rq+LBam/swE8u44BkckZbBiLUrafsDGkw86qaYonp6pxD2U/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Sat, 17 Dec
 2022 23:33:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 23:33:08 +0000
Date:   Sat, 17 Dec 2022 15:33:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <reiserfs-devel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 2/8] reiserfs: use kmap_local_folio() in
 _get_block_create_0()
Message-ID: <Y55RsbPJDZQi1BeC@iweiny-mobl>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-3-willy@infradead.org>
 <Y5343RPkHRdIkR9a@iweiny-mobl>
 <Y54TYOqbPuKlfiHk@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y54TYOqbPuKlfiHk@casper.infradead.org>
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc4ce50-714f-492a-e380-08dae0870e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wL9sGsVWNpai87pFOBPqBgu4b/rvRL6JpD0kkMhXGQzE3GBgyqnuIuVVUdT7zZXUzI3CkQQ9MYMIkRD+nYVxYTK7MBQ8I1RRILlxm5ITZPLYt3bl2Lq6/U/WDjhoGc0Ajh8jj+6nIxwjUgBX+vso2hVmTpPbmJFrWVJc5+fBCHyAJ8AH/JmVI0Al4pGDC+ppgn6BbwNICUiudOXQCsffqut1HcaOAq3E0SddMJ3Rip1k9GEMu1p6DtSjL10sH2xdMQPzqVaY2hmpN+Ol9gSbaPPTXRO2HO3fpJiQoYURiojGMgZIxj3pDAaLxgk9CJLgAyRUeUVLgSQio7fZ4J5dyzJ3uYSjvqVWrk6xGJmrVmi9VVRq5t6/5LbacRj8kHAHeizmDMoNTJnAEtvdedl4vj8Ywx7012L+Z3t8j4T0JtBhzlxKAPJRTwII76uap4iX45DSFfkP9H0+V0GUsVuXTW4VjsMUGyHjvFStrypDrxJXc/ZYBrTcCZtSeJW7O5mvdwoBcVQWFwOEduXH1m0eQkKDSVq4u9L4RX0VQTPJCRLh7SPUBiGRALagR198jzIp0oQQriUuWAJOjd2MamHBc84Afakh3l0MycZ1wHNtl8pPRTQ53qivTe7Egxq4MqEmZOXFJ2RoQpF6fQD9lRW75Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(33716001)(86362001)(82960400001)(41300700001)(316002)(6916009)(38100700002)(66556008)(66476007)(4326008)(66946007)(8676002)(54906003)(8936002)(44832011)(6506007)(6512007)(9686003)(26005)(83380400001)(6486002)(186003)(478600001)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Ldup3PYKLjpP2KlGgyIY9wCdreTB7PWG4RnhQ8Kph4cjwUaCtP+7p4yebyG?=
 =?us-ascii?Q?9riO/rVBUVJTMpajnPc8qlRyX7Z5IVEArNzRIrVrsk+9RsYTZMHTAUuAXpJh?=
 =?us-ascii?Q?MQJWV1youKH03aDEK4u4kZTRByfqvtJmkpFgL1Q7kEAkXjXNow5TTnG4ulrg?=
 =?us-ascii?Q?KsdMZUEywPb8jTD0Yc9w3So5bmks5jjhdf8Ec4LDUXEChUbvTFxbOll3jzEQ?=
 =?us-ascii?Q?kMm9XUgVmk+kn12WQb//AeAuhLT2+ZgTqSkCLwiRpxOMs2ke4aniXf4tf784?=
 =?us-ascii?Q?L9uYc8WyKGv8mz5R8GMg/lym2trT4/3ihhpwSuJvPvm4IGCvV3il/pCtumrR?=
 =?us-ascii?Q?mNqEmFi51+pC8qKAXiQFjkzqA4kZ1XRsL1BK/PGIfj6xIHN072T1eGo7usSc?=
 =?us-ascii?Q?tHXBk0f4c2PIj6iHSaQcce3eP7lj492GQmhTflFBI7sotnJKFcCQFIBZ66kw?=
 =?us-ascii?Q?OTMnBAGLT9pLby3zz+tZWBt/Tdt+N7NGJTl82DZ/9S+Bw8I7V6OUnBDSG21s?=
 =?us-ascii?Q?SjxAJT1kojIQccPiR0UYp7tDJ+TA6JIU02HqiLOvstL21fJA1Tko1ISzz5Vx?=
 =?us-ascii?Q?SvKsbCq2ES6nHcTGkwRTaePMX8wfP9/tgWjh00cAIXQZorW6Xu/z+y8Z8Z3y?=
 =?us-ascii?Q?XrIEhAntEllqNcWFDPdwWQrNc9GDVkDlXo6dxoi7r0ZvvLtF+KpMH80ritO9?=
 =?us-ascii?Q?D8fjC4gWNlOAEzhH3fZtw3F13XgYRRDzFygeAM2DXr40lu6NwqYekeFGOZep?=
 =?us-ascii?Q?f77LXbZjSno9ytx2/j+/AqDz7n8ZZSc7nohM5XWaxxsdrBxu1Lw/ypw7qZs7?=
 =?us-ascii?Q?GuTEMmt3a/83scpWbbWe5RewCx00QZWCIttf8+cNz58LTHriD3ydNZsD3NIv?=
 =?us-ascii?Q?KmzHcFOeG4SGO1rRPRkSOoBJF3F2gSb+4VGG+mObsq9QFRVR9dnjU160IK/m?=
 =?us-ascii?Q?/pgCFHnvOP11Hw7mKa0Cek9ju2czCWdXJsEWlPlO0aGk1YIQx/LacltevqeR?=
 =?us-ascii?Q?iYTwfog31BnOX23iTW86U4crwR5SuDGyPj/3V7iykYUreAVfS4Ed9y+0O369?=
 =?us-ascii?Q?txhZsMhR7yaF5+Xi5U15jgNfrUUx8F/g4mSURm7AUlKYnfqUk1HgoQoeNFaY?=
 =?us-ascii?Q?QyFht2VMWFpfRUa8eXsHFIyr8tlQBld0H9fzC1x0o2QCGVv6wmk6NZLVUUzw?=
 =?us-ascii?Q?5cGLnoq/yVT7RuZgv6BayGjazAWcaYJFmiSeWElrYID8Kd7v+AzL1xTTpDsQ?=
 =?us-ascii?Q?Ju3g+mRoh+/VecCwdJbAIMmqS+KstmhSxId32mbmxFqJvDZRhGD+Q99isCIF?=
 =?us-ascii?Q?FcBBqB+ZAAdTr8KQTAc5UI+d24HHr7yeyJryu+yVy1grcJpbasESOlYSxcyx?=
 =?us-ascii?Q?DakrG9xtvULRNGWjQ6akLqT/M7u9+1MpauNNCiYNrWIcbvpCkubaufyaz5lg?=
 =?us-ascii?Q?TxWw9L+rdJG8TsYx+HcFQiB0BFqaLXmCpd/PqbB18bOkH0EvphPeakEUiwCA?=
 =?us-ascii?Q?TooqvibxERhK1B1WwFg4i3oow+eIJfK5Wu8atesYqGoM1q5QJETL+GDzXwOS?=
 =?us-ascii?Q?eYdMW7y8Xc/KgPaso17AdXqjxkVK66GzeUAsXl74?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc4ce50-714f-492a-e380-08dae0870e0a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 23:33:08.8553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMghAWZfqXu756cpgQbY/eko4565JxPlrtcBJigTy/i5wG+XKbRW5dprH1Qg3OKtZA42TCvfsG/UTW/riThVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 17, 2022 at 07:07:12PM +0000, Matthew Wilcox wrote:
> On Sat, Dec 17, 2022 at 09:14:05AM -0800, Ira Weiny wrote:
> > On Fri, Dec 16, 2022 at 08:53:41PM +0000, Matthew Wilcox (Oracle) wrote:
> > > Switch from the deprecated kmap() to kmap_local_folio().  For the
> > > kunmap_local(), I subtract off 'chars' to prevent the possibility that
> > > p has wrapped into the next page.
> > 
> > Thanks for tackling this one.  I think the conversion is mostly safe because I
> > don't see any reason the mapping is passed to another thread.
> > 
> > But comments like this make me leary:
> > 
> >          "But, this means the item might move if kmap schedules"
> > 
> > What does that mean?  That seems to imply there is something wrong with the
> > base code separate from the kmapping.
> 
> I should probably have deleted that comment.  I'm pretty sure what it
> refers to is that we don't hold a lock that prevents the item from
> moving.  When ReiserFS was written, we didn't have CONFIG_PREEMPT, so 
> if kmap() scheduled, that was a point at which the item could move.
> I don't think I introduced any additional brokenness by converting
> from kmap() to kmap_local().

Agreed.  I only said mostly safe because of the question about chars below.

> Maybe I'm wrong and somebody who
> understands ReiserFS can explain.

Yep.

> 
> > To the patch, I think subtracting chars might be an issue.  If chars > offset
> > and the loop takes the first 'if (done) break;' path then p will end up
> > pointing at the previous page wouldn't it?
> 
> I thought about that and managed to convince myself that chars was
> always < offset.  But now I'm not sure again.  Easiest way to fix
> this is actually to move the p += chars before the if (done) break;.

I thought about that too.  So yea that is fine.

> 
> I also need to rev this patch because it assumes that b_folio is a
> single page.
> 
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index 008855ddb365..be13ce7a38e1 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -295,7 +295,6 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  	int ret;
>  	int result;
>  	int done = 0;
> -	unsigned long offset;
>  
>  	/* prepare the key to look for the 'block'-th block of file */
>  	make_cpu_key(&key, inode,
> @@ -380,17 +379,16 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  		set_buffer_uptodate(bh_result);
>  		goto finished;
>  	}
> -	/* read file tail into part of page */
> -	offset = (cpu_key_k_offset(&key) - 1) & (PAGE_SIZE - 1);
>  	copy_item_head(&tmp_ih, ih);
>  
>  	/*
>  	 * we only want to kmap if we are reading the tail into the page.
>  	 * this is not the common case, so we don't kmap until we are
> -	 * sure we need to.  But, this means the item might move if
> -	 * kmap schedules
> +	 * sure we need to.
>  	 */
> -	p = kmap_local_folio(bh_result->b_folio, offset);
> +	p = kmap_local_folio(bh_result->b_folio,
> +			offset_in_folio(bh_result->b_folio,
> +					cpu_key_k_offset(&key) - 1));

Yes good addition.

With these changes:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  	memset(p, 0, inode->i_sb->s_blocksize);
>  	do {
>  		if (!is_direct_le_ih(ih)) {
> @@ -413,12 +411,11 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
>  			chars = ih_item_len(ih) - path.pos_in_item;
>  		}
>  		memcpy(p, ih_item_body(bh, ih) + path.pos_in_item, chars);
> +		p += chars;
>  
>  		if (done)
>  			break;
>  
> -		p += chars;
> -
>  		/*
>  		 * we done, if read direct item is not the last item of
>  		 * node FIXME: we could try to check right delimiting key
