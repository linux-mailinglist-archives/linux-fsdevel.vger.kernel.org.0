Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B08664FC60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 22:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLQVJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 16:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiLQVJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 16:09:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D61156;
        Sat, 17 Dec 2022 13:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671311341; x=1702847341;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dgtx/CX3T7J7wIOTm1h0hsUaAGsN9FOjFPXuQGLgHgQ=;
  b=WvVKeBo+HUwuOtwnQ1u9oBECbki5ogu5JRQgnnXtXjfpgqMkw+9BrEmr
   0phG1Bru4OCwwZl0pbDCy6GlEm9RxPQHAoM9SoSSKJuYf4VNKVamcGhJ0
   mode+0XIndC4HVmex0hTG/MP1b0q/TZEl+eJ4B49+QglFNxBUY6K3nIgZ
   3kXFTF8SW66aYzIY669OtE1cvbF82kYXhm7KW/Fwq5X9FYSqws8tTF4vB
   szPdEy8OzP1h86+B9gIOiko9o8ok3o/+b46nupvjRVSkXSIWnlXuH+ztv
   BX/XrD/zDgyyHCyG13Pkk1d+cWzHECOos7iM9x7nFnHjiE/CgAkS+nbg7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="316795502"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="316795502"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 13:09:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="718710786"
X-IronPort-AV: E=Sophos;i="5.96,253,1665471600"; 
   d="scan'208";a="718710786"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2022 13:09:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 13:09:00 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 17 Dec 2022 13:09:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 17 Dec 2022 13:09:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 17 Dec 2022 13:09:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S54yilcOi8aR8t5S4GHJ20tK5o/lwsWEw83b98tXgDKIFNc5ArYo/vsR78Ycj+eV8RSueakfNU/SK+5ZAKneGcdZijcS0Qst0r5nw7OpGnpEyKGVSSY4wDHAPX9Q/KB4GKA+IuKbIyD/ksDtOixtcQdzJ6WoGFb6lVk1bDD9YdgsEoEFde+e9yKdbNFKgEZ/vISoFQqRyKNNcY9YXdTOQyxqrmS9d+cuA7s7wDgg/EMcwZKQSrLmY279z2z9P5agUAniRO13A0VeyBpJYk4a/VG+K/JQLZSEJQ3hc1Rrbh3wgNZp+ujZMbfjaAvB6ZSq9hFQ+ZW1S8DfjwtKIdwgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsso2KyAqi9fBf/2Z6pPboJbyGXEMzFsOCK93pkxkFQ=;
 b=T7BZIkHyNTpvwrjuJt1t8ysgE6bKC41TwXNz45Xll1sT0sqRMPLVPUYHwoo/Rx879oWPUpAqHJwsb0qixWNpHRfEF1b/pf/rQ8uJeIR9RGLs7P0KZL8dQIXFScbvEI9YFKCAMO2aNDDZUT+/dqLJF7hExoRSkyaiQexYbvoMbsZt4GSUn/UehUKkcby8U2kg32gnudjhE8ujyqGfcN5q9CVWtb9gPdeepGMC4sHfbZPjpnYarclkgJEFsV8397YRuVHchan5Gq/DLUHQ9FSPAN9kedzbVa9TSfpV7WneCCV5NOOHMZBuAVn90RkmaSH9ViDOcFGdW4EgHy9TtMQDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5347.namprd11.prod.outlook.com (2603:10b6:610:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 17 Dec
 2022 21:08:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 21:08:53 +0000
Date:   Sat, 17 Dec 2022 13:08:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <reiserfs-devel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 3/8] reiserfs: Convert direct2indirect() to call
 folio_zero_range()
Message-ID: <Y54v4TYAT/nGd8WA@iweiny-mobl>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-4-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216205348.3781217-4-willy@infradead.org>
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: eede990a-e1ca-4f94-1919-08dae072e729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHc+1FyDksCyvAk3d9mHzdQIeBdlOrC8tvbqA5EuVyUhmicwkcCztS1PI1CgzkAq93WiX8Fe8PiC0dk9mqr0CBZXe3jDNT61PqaP0QgDujfeQyGWJc1essykt54XcTSYKblsC+TrP5V0vT85rdmmBvuoZAM97LzH3nWLjSyDj9hBSUZPlgrPgpAO3GS8c5/fn6GrUuz+zHfGAacva9+18WtLnszTmQyy77tnhDsUvIA0htMJ+byucbtxerUhswxOu0ytRJXHvG4mln+U2DRHz+r6P0KMzlInJWwc7XHHosr8itlv5sgIyLomeUE8/195tCI8g22ZfxIROHMZhDNAHeuZHeotQ6i40x2r8eqW49ooN2zaa27vTI5Jd97Rwa0sgZREbQgKyKKzd3GNxNnC0WW4oj9h4/NzNsaXd3YpPgBseBMjx0pvKh2WNVGUaQWlifIWtVBMhT8ku3dU1/TxWevGhyrxhXp2CDlXERZ9JrrRKuY0yIV9sLUcdoqgPlw44Zxm/gR3SG1Jc3UQFgYZ6Lbhc4BSF6sxUNjMs1Dg1pkg8yqmrhuBSCms3NVDiKKvTbQAnpN6T1tVQit8vbilS0J+M25TIWajMwhq5+jZFExvcSJlvIPwLUF2Lk6MzOzwtR/DfReNwih3Jpq9YMBdxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(6512007)(38100700002)(478600001)(83380400001)(26005)(186003)(6486002)(5660300002)(33716001)(41300700001)(9686003)(8936002)(6666004)(8676002)(6916009)(66946007)(4326008)(66556008)(86362001)(6506007)(316002)(66476007)(54906003)(44832011)(2906002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DEccmsP66fLWQCIB9ukbGB2JAP3cjSeASzZR5HpY9eaNP88KoB+c/JlNxtNH?=
 =?us-ascii?Q?hDZBGx2Z2zz50Zr5pvHVm1OQV74QduEl5WXW7TAJ1pRYVAo12BxNkxe3bonJ?=
 =?us-ascii?Q?ScvrzD1usBsdHWNDs6ACOfSBuuD2giBVNbDy4a0nI/iHi9tVkmnxznnrT8Yw?=
 =?us-ascii?Q?ExRYJdOy3kRkg84q7tWLm3mYxtMrek/V1Eh7NLjbbqRJxs7eSm2K7mDPY/Ju?=
 =?us-ascii?Q?ARrgGiE25S3lbQ6/0dS6AhOlZusVUWDM8oXIey7TAMUqFkbi326Ln1ambxsz?=
 =?us-ascii?Q?7PK6AJodVT1/joN0VPEcquqirdAzeFEmMLnrwKdMY9tFxGXEKGUKvnrGMxN3?=
 =?us-ascii?Q?yUf+SMAs9cDV23iK2ePiw7cYzuQmHPFJcERT9DlPAHWo1w6+WJyPWREWHeQj?=
 =?us-ascii?Q?nbzi2D+z4wgHqsheTNor1QYucPECQe7w8AWWxj+aJtB3AKdfmgi9oeI2WYAD?=
 =?us-ascii?Q?KqvbyBljbZnkY9QtjbYqE3vAATqMQK3/rq8menviTrfCvVjU/cxVZEo5VRiw?=
 =?us-ascii?Q?O+Y0iRYdp5rFBZOf5ExA9/6Ihdl/MSqPGlfqaPf4vuV7SZmt53nFjS9hAW+A?=
 =?us-ascii?Q?0u/ByjK0UzE7iTqjoBXU6JbMiziwMwN1l2yyxLeG4MtwNp+aMMSTf7TEuiP+?=
 =?us-ascii?Q?JlSFEdt8CsiS2/+wk981Ew+HGX8olC3pmYvVxoNdd+qVUEtXCpTIBBovP5/t?=
 =?us-ascii?Q?9Dj4y9wAAjHNQy1Jbvk2Lee6hpGxXM3Y+arJrab7+SSRSKtjR2Os54Y1gv0k?=
 =?us-ascii?Q?WgvUS8L+qLuZu5MMFa7WkTTV5NZuFb19dqt10yFE/XlwYjqdtuTDTHdbNgGB?=
 =?us-ascii?Q?WLviPqzVLqf/dlpC3tssdA7kBv19Ne2ceRRT4aKMfZI+QCErK0rtsQGXaosA?=
 =?us-ascii?Q?xD8m17ptEio7xe2rEJK6wdoQy1e6YdB7306F/9yfEsyig4db7ixTQ8Y/NOTB?=
 =?us-ascii?Q?Ue4g1baRcmNsavbSZJ59BDcntXqGBR72Xu8QjsvftMqQ6EkfNR2/wwGwbDX3?=
 =?us-ascii?Q?xW59JOenaumGM5evdoF230BQeXx2G1eXV2q8ONPZCZfquxOfeTZvAVFl0w6j?=
 =?us-ascii?Q?0VPaYe5r2ZY/PoKDju/1KLC8w3TfPf/jbtxI+nWrgOcxWtdlovm424dFKTyp?=
 =?us-ascii?Q?o5V8YNOeziD6avnkPzOABh2RRQQryrrupU00Te+3jTG4blQbO9aaqrZBE+dZ?=
 =?us-ascii?Q?w9YO4nqeizQGL1d0b+j1TTKpl/dm16s+cLg/zdQdAToafX2i6Rah9L2lL+a6?=
 =?us-ascii?Q?lzDFE07ICECECTsJ9nPO2BxcRnrFJXbUXnj5MBc6xWrdiHGx2ypWKuQATDo9?=
 =?us-ascii?Q?xXyQC4Ec22X18AS3Ma8+39Qb97zNvdqmcWufSm/uhGvfVxQ2KySqw3kKhIzw?=
 =?us-ascii?Q?JuzsIsBMfgGrIhbGzd8uEZ1hVy1AGwYWQjh3tekvgSMyIhA7+/1Bld8xZ0J1?=
 =?us-ascii?Q?O1VaoISJqSIAOjj37Hefh7W4Y4fAiCGCR02sPh66X8l2swM5QMfSVJkbyzxx?=
 =?us-ascii?Q?pon62Y4ECDnk+sfB1i62/ZyfjtzeS8AJnlTRCJlTFUaRURo4d0Pf0Ki4hwPQ?=
 =?us-ascii?Q?n/X2DZYmsHkg2Rfr6h/MTAf3j9Mn5LJ4j0e3Eoco?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eede990a-e1ca-4f94-1919-08dae072e729
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 21:08:53.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYWRvRCojhcsMlfjeEnKOyAMe/po2F1YM4T/VOKq0xAqVtfAQCCVrfXlw4FbAvc8s+TceBNot+9kSFmnRndFzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5347
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 08:53:42PM +0000, Matthew Wilcox (Oracle) wrote:
> Remove this open-coded call to kmap()/memset()/kunmap() with the
> higher-level abstraction folio_zero_range().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  fs/reiserfs/tail_conversion.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
> index a61bca73c45f..ca36bb88b8b0 100644
> --- a/fs/reiserfs/tail_conversion.c
> +++ b/fs/reiserfs/tail_conversion.c
> @@ -151,11 +151,11 @@ int direct2indirect(struct reiserfs_transaction_handle *th, struct inode *inode,
>  	 * out the unused part of the block (it was not up to date before)
>  	 */
>  	if (up_to_date_bh) {
> -		unsigned pgoff =
> -		    (tail_offset + total_tail - 1) & (PAGE_SIZE - 1);
> -		char *kaddr = kmap_atomic(up_to_date_bh->b_page);
> -		memset(kaddr + pgoff, 0, blk_size - total_tail);
> -		kunmap_atomic(kaddr);
> +		size_t start = offset_in_folio(up_to_date_bh->b_folio,
> +					(tail_offset + total_tail - 1));
> +
> +		folio_zero_range(up_to_date_bh->b_folio, start,
> +				blk_size - total_tail);
>  	}
>  
>  	REISERFS_I(inode)->i_first_direct_byte = U32_MAX;
> -- 
> 2.35.1
> 
