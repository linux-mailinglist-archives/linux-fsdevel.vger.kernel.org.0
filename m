Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31145C00FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiIUPTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiIUPTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:19:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000F963FF;
        Wed, 21 Sep 2022 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663773576; x=1695309576;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J2Cwwxwd7LzQD3/ltDQY293MabI5MvkYlXgjPeQXQcY=;
  b=WzCDVnpKKyk1E/y4XNMtt42I5NUy3MqPhDv2Qdjjzknrl1gjp078lstz
   0KZiVm/YL+ci5IPgaDM17JvHAwUcZUmPQXjohuvxoUC09vR1dj0gu1Cen
   b8fvx3sP4hLESvDeFTcxgLZTNPVWy055K8F5NjqH2PgkIPqn9gS7hEA9H
   DhNJg0EJ2kAYGIOd/IIUnYKphKsByhPZwW6jPdq/G/dJKp+R8ofKnXsQa
   3jc3xPht4eSBhy7a1cDEtvIl+uBhp/5ayQ2E2x+LjCvi77hLSDyKb9wwK
   lUGdX81cGdo3PQZvNieGHOcwR4Zh+EWdc6MBxYu7t2UqHu8ElwiWqGNEq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279756836"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="279756836"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:19:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="745003180"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 21 Sep 2022 08:19:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 08:19:17 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 08:19:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 08:19:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 08:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM4Q/n9BjnIMoXCJReyPQ8q0fg4gdM+DVG9slClz1wsyO9PputPK4vLa6FjwQG+T5XZ/6FfNrJlt8S/XU/KYxl2U6A++wStLKlQOxeKua8BFZaV6f4AJOQhHWr88LNXnzmXY9OmDO1FKY1Wf4eN+Z8Rd68W2ld5iCttefC3PXub+Alj5Bs+4frs2N9adFs5vrT+psoweNN/xw9DP6uX7poMtvOochrQeKLQk3D+8tq/IDe/MrzNn5dbMZFDKxNLLVru+Y8McbmyHJmbUcSo6JkD+oIUklndD3tMWiXW828NbZeGsEM0zAn4mqKKib/9gs/WITHPOdmKImR9EQxkDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJagw3CUCBUN4i4aEZ+IZueQsJn3sXk1BkRxzZQt7U8=;
 b=D9hWUWDxHsyNKGsb5OWpkWA/imLK0B68YZT3SIdBkTdFgcjUUKV7JLKcNibkhF/ciRXoNE3x1GzWagxStDW4rLeoJIU24rrTx7FjWAvJZTgl9kGElzGzV7IQK2a1ZfzUCkskaYUCHXARAFtD1GBJq2Ra0m85v+4pMB/m9hyyeFONGE4/7XBYOuxY/Ri9MyQ/pv9sgPQtXGG99yM9WZLK8xurqgYuRQeHKn/VhS/RjQx0zFW53qkfxuUb1qp31Z4qqM0+KTide0G5iH79wwW5WYJF+HtiwA77/XQZga6Axa92TIK7THRmi/3cexTVOYP7zW4YHwEdhMdUZxbLNtJmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB7350.namprd11.prod.outlook.com
 (2603:10b6:8:105::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 15:19:14 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 15:19:14 +0000
Date:   Wed, 21 Sep 2022 08:19:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 13/18] dax: Prep mapping helpers for compound pages
Message-ID: <632b2b6f6548c_66d1a29430@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329938508.2786261.5544204703263725154.stgit@dwillia2-xfh.jf.intel.com>
 <YysaS5LIW1YYKSKd@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YysaS5LIW1YYKSKd@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM4PR11MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5466b2-1774-451f-a9a8-08da9be4a464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioWXoY8l051VBt8ui91a4iGpQAF1UXQak/h8YitGZONh2ML2/Btlvklb5O0YvFeXf1s4hgvBRgxl+mlwqJMssDRzFTkZJU2mo1KCf64qyHCbuuLNShHnA5qBq1sc5CDEnGVuHjG9QzfXGauzsdPFX+PeYyeeNlu0J4hClH03eGeWUj9ksRdJPwydUP+SFuRlg9TPE8B9/heTdcOiZzCblQ0E5vykqZMf3CUGTurIO8lyA5ZT42vTwyh1qiU5LGpIc8XxApjaE2qHSrFnfReS1V6K3OvLr3DnkyvCBgOM7vds3ocQ5Gr13d9SJWJsqxPfcOyuMPQjNzq59CpFugX1mNTmb+5RqyjfMmIFrRCfORBSk3aZgwttgDEgw4hkoWW++0XiBOK7SqV4hCiSu6fdd5V1gaD1QtMO49Q4biDk1HvERo7cOyl+N5FLkg97fUfF4Eq89YGCHNGD9fODasLIgZvHXsBl7KWOulPbMi+Q2KaEwb5gsovr0/GA0j6YxXc2syUpXQSd8t17OjjZmUT8k5RmStJvQHRXE+XpknqmCPiGbvX2vwJcOWLrvaMEduafysnMPtDPvfiaJG0d+btCR8WvMPMSGPVV1ulKe3avRkxDvw+xESsRkCFwOhQfwycopFCYldwSGhMAFP4cvL6K1E6ZLV0RWx+2dA1BDh31Yk3zirOlzWS7v2pqH0YdUKtc4bqBdyriSOWoV0FAfMobOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(4326008)(83380400001)(82960400001)(186003)(41300700001)(38100700002)(26005)(6512007)(5660300002)(7416002)(9686003)(6486002)(478600001)(6666004)(6506007)(8936002)(66946007)(86362001)(8676002)(66556008)(66476007)(54906003)(110136005)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0oopoKcjENNG590uE1vk59bAYZjIeDX2MRqT2Cg5UZzqM0DBMoQ/vI7qTrRa?=
 =?us-ascii?Q?1+0volYAIH/PQM2T65nGrRlUouqxz8pvHdT4b9XN8eMD9gxg/y3k/FqKvGwY?=
 =?us-ascii?Q?nlDsmcnhW76O0hGDXOQm8iIL3J8nlPwm+vsxedjdhwq57blKJNbfDv5Jr0jM?=
 =?us-ascii?Q?Jf2aGmlNvsgSXbk1myFatCZhKlqTc0JRd8trxqyAdHZqrsKTnrkNFg5gRHur?=
 =?us-ascii?Q?ud0Va5hjHuN+IvJF0ywzW8nZy5YEM0W4bcPpPqt5pGggmMRKURBYLQamUu4N?=
 =?us-ascii?Q?qbhnz/Mj4f/chJ8o/H/fjcx4RWrHQX6+dCOhQ8RigwXF583Tv9HElNrtMZoy?=
 =?us-ascii?Q?wxoeDNHt6Y9KUJQCWq3/U7HghrzJLGi7wEoPd8U143Ajz7Cmt+Ujvm23vHcR?=
 =?us-ascii?Q?0GYEo0G5xNt7AP+fg3iPJ6D/uuX570NtCi8zhbjPaQPUxXlFEpUog1JjsVNn?=
 =?us-ascii?Q?SmmE1OMgV1jCsbJ89PCjvRsmKHKL+sQHKymHugP96KQiMOi+ehTrORpzoOlD?=
 =?us-ascii?Q?1sPc7bAvLq9XzTo7sTfwP3tVanap84iS1t7oXrXC5fKuKa4ZE6kzSrA5R7sJ?=
 =?us-ascii?Q?3D7rrsFqSmkWhxSAZk3qB6pM/vYeCOfax95cc5hZmGs8P5mA/SoesRVJQQq3?=
 =?us-ascii?Q?3+5tTmoQZXx90JtEYwpbwjgDqXQMVcakJ8yfyboqET1IYL2XZyjCqUhU1U6l?=
 =?us-ascii?Q?U/b2cOqbVhqkiB0TmwBgyr8Ay5thsvMj8Iorv3COcyQ7zs8V8hlChxnJjvc1?=
 =?us-ascii?Q?ZbVkwOwcjeHUL1uUygg7rqCPtdteo6BQPb8Bw3FeQrknohpZtkFhoKIS8np6?=
 =?us-ascii?Q?/6waExnChTOg7IAewKbRW0tVgJuIxnNtDpczOGNw2UuZs7iEVMxRkXj9p+G/?=
 =?us-ascii?Q?P/M7/ItIsU/RWbcYIzZfeAcbvPSUuOAgQAvfZuKcW9/FTxzsnhfCe+GJH6k+?=
 =?us-ascii?Q?+UAibZauwbcEDjlgqf8o2VYDgMOVrtOwtS/UalPo+R/90+nW8Se4odzi6U9r?=
 =?us-ascii?Q?WkDmNIlmxp4lZJdDEwwT8QkLxx93VdT1qzGkeAEhuRZMXrWtk5URElVvolik?=
 =?us-ascii?Q?6wYvtRXN1vHMDg34fxXCMYShETf8XszJuh5nua1NxFf0ib+9780EGA4NWk9J?=
 =?us-ascii?Q?M1Drnds1JkKfQrNmv8FIoNkMDHNIcIF46eHhOL3QrNq0IW1cqGzFGACtRoz1?=
 =?us-ascii?Q?crpA46kIvJZmHSbGpnrgdDcG8q1rCFXN29D7QJ1P8U2iQU/EzyDOfZlbK89Z?=
 =?us-ascii?Q?S1zT9CYsA5g4dhoMBqJug7D+nGiOIb17tNDy0r9MRmAicyIMDmkSWPIUwHY/?=
 =?us-ascii?Q?9jf2wJehUXdTEfKSHZcn0HaTblb2pzkfLC1ntFVIQVonTE29ahFQIRyqSZq8?=
 =?us-ascii?Q?vp1KskPPeVT6kuiib8OQSUuCzlrXecAHB9lBdrWBCFxahF/qrkWOs0K4/2eB?=
 =?us-ascii?Q?8U5rZjDfS407/eV5prs4SkbZ30r7O6ZjrSm0TwPCc4rrc5l9JcT1+EcXpjCB?=
 =?us-ascii?Q?G8PflNcaKBQmddYkcVeDioWOJjpOe4sDtmGJM00KD7hI71U02dCvriFa+ECx?=
 =?us-ascii?Q?XFVgPoOdYJ8rLBVaIjwIOfgUN8SGD2WKbLn82XSHCxLQeJrxkasnE+8sK+/Z?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5466b2-1774-451f-a9a8-08da9be4a464
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 15:19:14.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhHIgagDEk59meiD9UsTpgMnlhGvMp1nh92n9da0+O+mxwxQIxnyZqLqCbfLcgM1yKAX74PwLxMudSYzwd0n+j86bHCfxHOmPp81RL4/vT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7350
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Thu, Sep 15, 2022 at 08:36:25PM -0700, Dan Williams wrote:
> > In preparation for device-dax to use the same mapping machinery as
> > fsdax, add support for device-dax compound pages.
> > 
> > Presently this is handled by dax_set_mapping() which is careful to only
> > update page->mapping for head pages. However, it does that by looking at
> > properties in the 'struct dev_dax' instance associated with the page.
> > Switch to just checking PageHead() directly in the functions that
> > iterate over pages in a large mapping.
> > 
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/Kconfig   |    1 +
> >  drivers/dax/mapping.c |   16 ++++++++++++++++
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> > index 205e9dda8928..2eddd32c51f4 100644
> > --- a/drivers/dax/Kconfig
> > +++ b/drivers/dax/Kconfig
> > @@ -9,6 +9,7 @@ if DAX
> >  config DEV_DAX
> >  	tristate "Device DAX: direct access mapping device"
> >  	depends on TRANSPARENT_HUGEPAGE
> > +	depends on !FS_DAX_LIMITED
> >  	help
> >  	  Support raw access to differentiated (persistence, bandwidth,
> >  	  latency...) memory via an mmap(2) capable character
> > diff --git a/drivers/dax/mapping.c b/drivers/dax/mapping.c
> > index 70576aa02148..5d4b9601f183 100644
> > --- a/drivers/dax/mapping.c
> > +++ b/drivers/dax/mapping.c
> > @@ -345,6 +345,8 @@ static vm_fault_t dax_associate_entry(void *entry,
> >  	for_each_mapped_pfn(entry, pfn) {
> >  		struct page *page = pfn_to_page(pfn);
> >  
> > +		page = compound_head(page);
> 
> I feel like the word folio is need here.. pfn_to_folio() or something?
> 
> At the very least we should have a struct folio after doing the
> compound_head, right?

True, I can move this to the folio helpers.
