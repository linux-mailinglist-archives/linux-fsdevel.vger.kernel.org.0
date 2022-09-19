Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16995BD1ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiISQL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiISQL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:11:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FCF24BD8;
        Mon, 19 Sep 2022 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663603914; x=1695139914;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VN0E0H5V3LgM+cMDZKfSfUqI54GPl39S5DCoHTJfYUA=;
  b=cCJvVmvPELlSBjSI9jdm4AcXRH8he7sIYhLpHYOIkk6qbcO7GmSuDiYc
   CwqqpRFARHWCjb7WoFu+bPwPdTHcXSXynpQVUvOmnlE+NNkKHWQH1IXLz
   xSpXWkdH5Pqjv77EAdFwzRNojjsUdsxJ1JYnO0bhlpXdeuGP0dHOEyUb+
   zQBawjtl9UEAL1aZIg9AhPZhDJdzXJqYJ+6bz31DPUmvquRGXII3BJIE7
   4EycTBqC98+m5z0xkThKmxtwQ6F+1DvA+EN1jjetVHf75i5+hgR63cfQ9
   n+ixrx2NBR7nMkV4sVqfEVNiyl8koyVHp4LECDSHXUVtvJ/aePIZJpauS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325735972"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="325735972"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="620908317"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2022 09:11:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 09:11:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 09:11:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 09:11:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 09:11:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrnQReM7ch1Qp2y8X/GpK3zZ910uFasvTHS7xUyOv1nslWaIluB7T+QPOxFlFZ7pL/59QiVKzc4QG0Xnz7aHSOjD4O6DZCHrLce3Jut8SV2d2sSTHe2MZ/T6ZvWri4KxOZcqiDB+K4KHHPPREUYHxuCyCQIfQiVOtNM4r/nIWHBRQv0JRBOSG2Za0/3fvVmWbZrBUdIRu17bA3cDREkRWJnoNJvD3tsFfH65DwX1SLPMKg9ni+d+ZoI8iG6hQSEFlBhPtJqd9L7FjFeDBMlNoZPaj/SBABoXBisOiX2Pgh0fhJnyeQboPs5zVl7u/LBZa6Opt81nD4nk7IjD26sElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPcGIQmAaOH1CraeAEBL8KL2/8nG8ph3hbnGDKlHHMU=;
 b=E/tdjWZ8m8xaB6tmwCoJo/TR4EpjX/iKzAmOVeauxlw3ALstS1m3azzuV1pNQMtuZBQEftb2Q9XcFfOIfAeKcesdmSqrKN3edXFGMcQQgahkwpaAemttWbfkJ1AhcCPkP05vthvCOfFFGNgbnEejev5jrmeReFmd13Vt5aMQyx8jU6Y8e0bMwZUQ703odEoqczsi3j9BMU+GbuZ4cT/ezGub4SwGurkkraTqkOeTiBuKul4v+IkOTDwx92gZWkRuykxdqlVwgZgIfm0xFkoZQnHNFU9DNX4nUy4WE7CYYioBj/M8BYbwT3F3XwOjWHL7g/ENprc2TZOD6g6YfAEwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5465.namprd11.prod.outlook.com
 (2603:10b6:408:11e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 16:11:51 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 16:11:51 +0000
Date:   Mon, 19 Sep 2022 09:11:48 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220918225731.GG3600936@dread.disaster.area>
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BN9PR11MB5465:EE_
X-MS-Office365-Filtering-Correlation-Id: 915436a7-b58a-4fc5-ab16-08da9a59a989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7J85kc01GbZYesk64ywtUxCaKywDjU9MMqop+mHGSDiRx+kglENiE3/kM63H4wzC/+vZ7wRZU4qjFOuHkTAthgcAgWIuz+EEmXZXfm/7SqiT7T8zqkvJdnmTq4lMVv6GBVkitPnGDoKvWlIPEs/g/DWju6mH8c2dCd8Y6ZDL+X6O1GVwHaTrDj8WkY2cLwApz19I5cokXrdLhBRqSTzYcHAuL2rHpk/gG9yoGbT4ta6aVLY5uO+vcm310j4/rHuTwGlD5sboVIvL9mrHji2KGJ2ybdkahCcX1YEWfkAjRD3YcRqG505RDBozD+5WD3Su2NM1R0sbMEoc9q7gzAopfEIdUqlMXaChsQk/fiEo74yj0mhsmza/bf+5Rd+NR4TUylR96hlRyzvddlID7IOrR2Ca6GjnQW0M5r/K7/lRsDXaZIY/x9d51n49hPE3VcH+ffsxWS2qVzGniqegXM+VW7MF7r8Q+RuKj/KnP4PiLW32XK0YWtAAGn8czeLyLtKgU5pcnwA5qHzvgGP4QtWttXFobE0Lgxfpov1B1DAazRsyrURGsAao9O4tuCTBnCgI0z+abmd5EwminM0yFAQHveJwdhcwNZpmiQZHtyXLVS7OUajgB3sxxqHQ8IYS3qu0Iq2YOupLKyRJc4sRIjlvPc0tp+fAS8rg+rm4yK4rVxAKu4+2SqAEdwOsobvVIOgGavHsb6r92tJRiTNZffwDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(6506007)(4326008)(2906002)(86362001)(38100700002)(8936002)(6512007)(9686003)(6486002)(26005)(66476007)(8676002)(66946007)(41300700001)(6666004)(478600001)(82960400001)(110136005)(83380400001)(66556008)(186003)(5660300002)(54906003)(316002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WHErHPzxFLpKovVGulo33I3Uj1UqsTYPR9mts+7cAEVm2AJ7Bk5GGt44MsNu?=
 =?us-ascii?Q?CXz3gyx1OQX+CECh48YqX3xlDAiCKKBxxsDuEp6xKqPvS9k0ZRiK5xjVQbxJ?=
 =?us-ascii?Q?XkX8O8hIV+2eEUym5wYM/7cEntbicv2GA2QivBVE6RCnFdbl3dw69t+vOhjM?=
 =?us-ascii?Q?BsD/8hT3/4zmzCWopq0qnRPNJerSrFj6rhYP2tuGJUkf0i6n6SPPljg/9uXj?=
 =?us-ascii?Q?ueTUOOQRGNpef4gup+nJJsSz4IFXAn36dv95sXH1PSkceLR8tvTSPb9zldtQ?=
 =?us-ascii?Q?vqF4bXq1CguRsgcYL7cnn0J5DG1Y0wr9m+o4W3JsE/+sxz2TkEOzAaPJ3acP?=
 =?us-ascii?Q?s2gKd26wy2g50tj7bXx+t6wq2WHg95c0JvFtWocpKyKdXrbXpct9cazkwOO6?=
 =?us-ascii?Q?c03TCS1GwjeH1Q8hivW2TAZk0vLqcegtN58WkeOfg4Xz9l21hiA/D2kAdzls?=
 =?us-ascii?Q?71wEpQOgIqxdlt4+TN0zR5UQzAc8JhtSDxWYduZXkcrJcliRpWuQjBeoC/gB?=
 =?us-ascii?Q?r5gD+Seiy7MnK1P+jlcouZ6ACTiMEUAOuCLYJdaAHj11cplxlkYOtLC9ayoi?=
 =?us-ascii?Q?pwYu9x7wPD73+7ZjCtxqOoRc2g1KYsD+qxpBVC4WVWeEOX1EIvsNObHPMhcI?=
 =?us-ascii?Q?2QtukTP7HiE0aw56X1ytS2qPW/eGirSGTnUZ/V5hXmT2pFHbC05MJ49KdEuM?=
 =?us-ascii?Q?IU5wD/dR+LwC1/72W90QSXj6mM14XBY/0N0qsWOrcltnz2e2jz2w4UfXzBG5?=
 =?us-ascii?Q?uxBEX2Ioem0dGeS+MBu5S3/SmV+jIOpy1QfD9Jr3j8z7IvuAWKz+s4G0PBtm?=
 =?us-ascii?Q?ysYl8DM9U35y9DEauq+Durn8q2M7QjwkmccFmeEgUyZPfCi1/ayLkb7/Dotq?=
 =?us-ascii?Q?5u3P+vQmNRtDytmrQUz4AOKnKOeTKdQAlfFipUCNr3PeslVed81CgEespWxY?=
 =?us-ascii?Q?xQKsERR1kuK0qjK9ScvIC392dmDVS07mKRL5D3GtvrYUDWMXHdMXu1/3I1nW?=
 =?us-ascii?Q?R4b9VOvZbQ5kF+f65GzmSN0jZTHKPNbP3IIle6KRkkouTbmJvQsfYE1IGHch?=
 =?us-ascii?Q?V4svDoJhykAWbIYc07oCQ4rJfk7pqJWKgIcabjKkp6VOUN1G3ZOf29B0SbGW?=
 =?us-ascii?Q?elFms3R5vA4E2PgfnApD3phrlCIVqrhZXGh5AaE9UobLFl40mOA2g8n/TheM?=
 =?us-ascii?Q?CYd6OIJgMnOum/PD9bxUJSN5oKZBklX09qbgagttG6k2uey1y0saSPTIrt0b?=
 =?us-ascii?Q?fwlfpm8DEj0TWmuRORBwRxc6U3mrb+mAXgPRmv2xhPwJeF/W1ZK8ZNYv1yXQ?=
 =?us-ascii?Q?JVMLoeVFNKq+it5SHN6HAgbZTMjbGap9AcGEkzIRaZq6jsXAOmxyuXZE2jZw?=
 =?us-ascii?Q?ItZ1MNB0p3eTymeCOOgJ7e6KIQbquQwDfort66/mtZdZPouV8HF2XRnWMs8c?=
 =?us-ascii?Q?pi9fFmHJj50e0QqwA5Rit5tGTxPfyZjldkveJZCPcA54hQ4cCb4CV6wnwcrQ?=
 =?us-ascii?Q?/rD/hI9OvmxuCvOT6qsu9e3dNcIRix27sP1qXcoa3yyUU8iVfgxurBnV4Hrl?=
 =?us-ascii?Q?Zf5Xy31dT6hMSEa1ahl9tBtNz66R9Pyaw//7cf2GLJglhWvaidgUX9Sy0Wy5?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 915436a7-b58a-4fc5-ab16-08da9a59a989
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 16:11:51.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JezHI4rgMyDoSGRnr8WK/A1KuAknPtjwfKN4hK+hX+bYSMY4gIqD9izjko0TTliZYOmyLPpAhdRF63uGaqO/tL3QM6MSVr1RLcPY8CE7CUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5465
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

Dave Chinner wrote:
> On Thu, Sep 15, 2022 at 08:35:38PM -0700, Dan Williams wrote:
> > In preparation for moving DAX pages to be 0-based rather than 1-based
> > for the idle refcount, the fsdax core wants to have all mappings in a
> > "zapped" state before truncate. For typical pages this happens naturally
> > via unmap_mapping_range(), for DAX pages some help is needed to record
> > this state in the 'struct address_space' of the inode(s) where the page
> > is mapped.
> > 
> > That "zapped" state is recorded in DAX entries as a side effect of
> > xfs_break_layouts(). Arrange for it to be called before all truncation
> > events which already happens for truncate() and PUNCH_HOLE, but not
> > truncate_inode_pages_final(). Arrange for xfs_break_layouts() before
> > truncate_inode_pages_final().
> 
> Ugh. That's nasty and awful.
> 
> 
> 
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  fs/xfs/xfs_file.c  |   13 +++++++++----
> >  fs/xfs/xfs_inode.c |    3 ++-
> >  fs/xfs/xfs_inode.h |    6 ++++--
> >  fs/xfs/xfs_super.c |   22 ++++++++++++++++++++++
> >  4 files changed, 37 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 556e28d06788..d3ff692d5546 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -816,7 +816,8 @@ xfs_wait_dax_page(
> >  int
> >  xfs_break_dax_layouts(
> >  	struct inode		*inode,
> > -	bool			*retry)
> > +	bool			*retry,
> > +	int			state)
> >  {
> >  	struct page		*page;
> >  
> > @@ -827,8 +828,8 @@ xfs_break_dax_layouts(
> >  		return 0;
> >  
> >  	*retry = true;
> > -	return ___wait_var_event(page, dax_page_idle(page), TASK_INTERRUPTIBLE,
> > -				 0, 0, xfs_wait_dax_page(inode));
> > +	return ___wait_var_event(page, dax_page_idle(page), state, 0, 0,
> > +				 xfs_wait_dax_page(inode));
> >  }
> >  
> >  int
> > @@ -839,14 +840,18 @@ xfs_break_layouts(
> >  {
> >  	bool			retry;
> >  	int			error;
> > +	int			state = TASK_INTERRUPTIBLE;
> >  
> >  	ASSERT(xfs_isilocked(XFS_I(inode), XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL));
> >  
> >  	do {
> >  		retry = false;
> >  		switch (reason) {
> > +		case BREAK_UNMAP_FINAL:
> > +			state = TASK_UNINTERRUPTIBLE;
> > +			fallthrough;
> >  		case BREAK_UNMAP:
> > -			error = xfs_break_dax_layouts(inode, &retry);
> > +			error = xfs_break_dax_layouts(inode, &retry, state);
> >  			if (error || retry)
> >  				break;
> >  			fallthrough;
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 28493c8e9bb2..72ce1cb72736 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -3452,6 +3452,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
> >  	struct xfs_inode	*ip1,
> >  	struct xfs_inode	*ip2)
> >  {
> > +	int			state = TASK_INTERRUPTIBLE;
> >  	int			error;
> >  	bool			retry;
> >  	struct page		*page;
> > @@ -3463,7 +3464,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
> >  	retry = false;
> >  	/* Lock the first inode */
> >  	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
> > -	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
> > +	error = xfs_break_dax_layouts(VFS_I(ip1), &retry, state);
> >  	if (error || retry) {
> >  		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> >  		if (error == 0 && retry)
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index fa780f08dc89..e4994eb6e521 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -454,11 +454,13 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
> >   * layout-holder has a consistent view of the file's extent map. While
> >   * BREAK_WRITE breaks can be satisfied by recalling FL_LAYOUT leases,
> >   * BREAK_UNMAP breaks additionally require waiting for busy dax-pages to
> > - * go idle.
> > + * go idle. BREAK_UNMAP_FINAL is an uninterruptible version of
> > + * BREAK_UNMAP.
> >   */
> >  enum layout_break_reason {
> >          BREAK_WRITE,
> >          BREAK_UNMAP,
> > +        BREAK_UNMAP_FINAL,
> >  };
> >  
> >  /*
> > @@ -531,7 +533,7 @@ xfs_itruncate_extents(
> >  }
> >  
> >  /* from xfs_file.c */
> > -int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
> > +int	xfs_break_dax_layouts(struct inode *inode, bool *retry, int state);
> >  int	xfs_break_layouts(struct inode *inode, uint *iolock,
> >  		enum layout_break_reason reason);
> >  
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 9ac59814bbb6..ebb4a6eba3fc 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -725,6 +725,27 @@ xfs_fs_drop_inode(
> >  	return generic_drop_inode(inode);
> >  }
> >  
> > +STATIC void
> > +xfs_fs_evict_inode(
> > +	struct inode		*inode)
> > +{
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> > +	long			error;
> > +
> > +	xfs_ilock(ip, iolock);
> 
> I'm guessing you never ran this through lockdep.

I always run with lockdep enabled in my development kernels, but maybe my
testing was insufficient? Somewhat moot with your concerns below...

> The general rule is that XFS should not take inode locks directly in
> the inode eviction path because lockdep tends to throw all manner of
> memory reclaim related false positives when we do this. We most
> definitely don't want to be doing this for anything other than
> regular files that are DAX enabled, yes?

Guilty. I sought to satisfy the locking expectations of the
break_layouts internals rather than drop the unnecessary locking.

> 
> We also don't want to arbitrarily block memory reclaim for long
> periods of time waiting on an inode lock.  People seem to get very
> upset when we introduce unbound latencies into the memory reclaim
> path...
> 
> Indeed, what are you actually trying to serialise against here?
> Nothing should have a reference to the inode, nor should anything be
> able to find and take a new reference to the inode while it is being
> evicted....

Ok.

> 
> > +	error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP_FINAL);
> > +
> > +	/* The final layout break is uninterruptible */
> > +	ASSERT_ALWAYS(!error);
> 
> We don't do error handling with BUG(). If xfs_break_layouts() truly
> can't fail (what happens if the fs is shut down and some internal
> call path now detects that and returns -EFSCORRUPTED?), theni
> WARN_ON_ONCE() and continuing to tear down the inode so the system
> is not immediately compromised is the appropriate action here.
> 
> > +
> > +	truncate_inode_pages_final(&inode->i_data);
> > +	clear_inode(inode);
> > +
> > +	xfs_iunlock(ip, iolock);
> > +}
> 
> That all said, this really looks like a bit of a band-aid.

It definitely is since DAX is in this transitory state between doing
some activities page-less and others with page metadata. If DAX was
fully committed to behaving like a typical page then
unmap_mapping_range() would have already satisfied this reference
counting situation.

> I can't work out why would we we ever have an actual layout lease
> here that needs breaking given they are file based and active files
> hold a reference to the inode. If we ever break that, then I suspect
> this change will cause major problems for anyone using pNFS with XFS
> as xfs_break_layouts() can end up waiting for NFS delegation
> revocation. This is something we should never be doing in inode
> eviction/memory reclaim.
> 
> Hence I have to ask why this lease break is being done
> unconditionally for all inodes, instead of only calling
> xfs_break_dax_layouts() directly on DAX enabled regular files?  I
> also wonder what exciting new system deadlocks this will create
> because BREAK_UNMAP_FINAL can essentially block forever waiting on
> dax mappings going away. If that DAX mapping reclaim requires memory
> allocations.....

There should be no memory allocations in the DAX mapping reclaim path.
Also, the page pins it waits for are precluded from being GUP_LONGTERM.

> 
> /me looks deeper into the dax_layout_busy_page() stuff and realises
> that both ext4 and XFS implementations of ext4_break_layouts() and
> xfs_break_dax_layouts() are actually identical.
> 
> That is, filemap_invalidate_unlock() and xfs_iunlock(ip,
> XFS_MMAPLOCK_EXCL) operate on exactly the same
> inode->i_mapping->invalidate_lock. Hence the implementations in ext4
> and XFS are both functionally identical.

I assume you mean for the purposes of this "final" break since
xfs_file_allocate() holds XFS_IOLOCK_EXCL over xfs_break_layouts().

> Further, when the inode is
> in the eviction path there is no reason for needing to take that
> mapping->invalidation_lock to invalidate remaining stale DAX
> mappings before truncate blasts them away.
> 
> IOWs, I don't see why fixing this problem needs to add new code to
> XFS or ext4 at all. The DAX mapping invalidation and waiting can be
> done enitrely within truncate_inode_pages_final() (conditional on
> IS_DAX()) after mapping_set_exiting() has been set with generic code
> and it should not require locking at all. I also think that
> ext4_break_layouts() and xfs_break_dax_layouts() should be merged
> into a generic dax infrastructure function so the filesystems don't
> need to care about the internal details of DAX mappings at all...

Yes, I think I can make that happen. Thanks Dave.
