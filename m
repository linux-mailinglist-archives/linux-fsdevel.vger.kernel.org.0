Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89D5B26AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 21:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiIHT1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 15:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiIHT1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:27:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA66ABF13
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662665233; x=1694201233;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vCJcMLdnU3CL1cmcqh2nqNf1VDj89bppulgDf8cZIGY=;
  b=CSCnvGloT1NXwAZgPJKyZB3CDKMg/LzlxD/gB+UiwJbf8QX80Tl8L2j2
   PEKmEnZwHMF/OwkYF/3N6lvHI76kyQ73IQ4pldoDkCoxYl843MTW0H4/0
   Z10ID9DqLXc0CFttWLMMKMu7y0Ow+M6xXc05XaQxxZ46uq6dgf8HWmNaq
   QKLD/0LzaJi5p+96X2kJGWr/GG3okp1aUk5erpX4ZcE/VjM2TwkCehhYO
   bfU+QUrsPWeo9nB25lFFdkbFax6L5O78lksYfDRPz7bLswVD+WnS918TJ
   2N/ZEEs0MMLiXcaxyKRiOizvIy47u1iP3Gh8fnKckbLkWQNhTv2b71Onb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="296036738"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="296036738"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 12:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="683357366"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2022 12:27:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 12:27:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 12:27:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 12:27:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 12:27:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPQgGdLo2QMLBDeRD9fdMItWsxXoEOHbPzSpV13xkAU/gzx+z9fZ+zArPeKHRSOmWX3pTKrfhKYc47u56IqWAWTkVF+Yqv5LRgdd4HuulD7BbmIuzt0vCj5SecI2WKqWfn/+RiYwL5sPebK40WxWBKqgfcK5MzUMzhRVEhzGIxKcP3vtqckGN+Sty/q9bQfQR40DHke6Bx2gKVhVN5lWzeJpDB+OF/x4++eYHdYcwcir4lRuRd1lJr6NIiLSTskN6LVNDqJM1ukfFxxOjrDQyOXv/ZdbXBNmciDv25YyY4cx+uDOPKCDI5FT80ulDSxGcen+y8p5r2iE1711wht2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2fYUjoB9YJqJvl9xAq1/TL2kYahJLp2FZCNHp+apws=;
 b=aGugWv6POTATk0AQKW0pPX7z5rjalRdfW0JaVP66HqZq2AzkQkQkCXVktg6Nf6CbiRsz35M6pQcmldMobxe/pg3SWMPVO8MtlVeDOu3GIRsGoWfa8u1GNMZA/AwsuLXU6HObQOLYMZ95naLeTYf+If+aKiAe/K5+C0OUFC2xB9bqEtd/Sw+u7ZNDOZAsoaEdCE807geOPvGTy1cCwkKlPHz1nnmrgE9Sos9zX5GAMrZxxTqS4MgYoqurrXK9w8K+Nk3o5CT7fzQ5A+SPMc/e79uboPSoINqUNIzpcuJU6Cv+UvykOFfS8Fb7XAoskqIJDZdHkCqkqRtZhuXabG2XUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM5PR11MB1994.namprd11.prod.outlook.com
 (2603:10b6:3:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 19:27:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 19:27:09 +0000
Date:   Thu, 8 Sep 2022 12:27:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <631a420ad2f28_166f29423@dwillia2-xfh.jf.intel.com.notmuch>
References: <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeWQIxPZF0QJ/FL@nvidia.com>
 <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
 <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
 <YxiVfn8+fR4I76ED@nvidia.com>
 <6318d07fa17e7_166f29495@dwillia2-xfh.jf.intel.com.notmuch>
 <6318e66861c87_166f294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <YxjxUPS6pwHwQhRh@nvidia.com>
 <631902ef5591a_166f2941c@dwillia2-xfh.jf.intel.com.notmuch>
 <Yxo5NMoEgk+xKyBj@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yxo5NMoEgk+xKyBj@nvidia.com>
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ed68066-00f0-4c59-9bac-08da91d01f60
X-MS-TrafficTypeDiagnostic: DM5PR11MB1994:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBLSdEsiCBvlr7dRLtiMNBcThNqynN2BSAfHb8bcBukYgnohgdK6vn/GqUFi+WcGW/2eylDwG7LJx9ydz+I1GZOKCnRjQr2EjlT/tTf2iCQwSjhVFiw2zIjgDNV5miy/CE7yi9S6fxewMZtn6SxdqzLs1K39wRa506tJEnfSMBCLbvdUkGkHvWGahhbg+4A6s2ZIWP91RP5vOiKeSxaQ9oQn7kK4IKvX4ekYbRPZJLR3OC3RD9XNZbam3BL4yDZRzHkrFph/hm6DdclttR97BadbYxWIXFUY7cQVSqsCTRBGTwX9RPfWUZp00hTxtqZqJXkIUH1NhEfBkvPZkKID0FH6lMoAdrWYWmVN1l0nq4WDDly1ODtjgdrg1ZXij0+fRZ0VcTWzYo0HASbs8izvf3mmgqm1+4GRxj5HHvjXSq4Itzh7riEuajbgOVKBTb+0FYnF3UBCkqi0e4tBUXpEYnbjkthPjzCQxqofC02rHcIORF7AL+473OI7hnNs4LunitJLVSf3ad/BdQ0kYzsm3wEPH2IhXswu+QC7NjgmJW/0RYRNPj2mx2doQ0loVkuEZTKd/KTsdZIK1ibbYRwMEysEYSgTReeKMR+JiE/277I7WPQ1HMkZF2/QPmMpsVZe69Ei8dMeY3+O9Xrtl8EBfN6yjD6aU5HWbu4MgYDVHieGz7/kuBHxGjhQhvJFCvKVi49ZtG2AeVI18TePR4b8Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(39860400002)(396003)(366004)(6486002)(38100700002)(8936002)(2906002)(186003)(7416002)(5660300002)(478600001)(82960400001)(83380400001)(6506007)(66556008)(66476007)(8676002)(6666004)(4326008)(66946007)(9686003)(86362001)(54906003)(6512007)(26005)(41300700001)(110136005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ShyqEVsiymtX9rk5nMtrbCIY2tVUbr+jlhiR/MUmNo8SayN/OePZfthUEvB?=
 =?us-ascii?Q?oaBDDnVNoh5JY/3poasP7eq+t366a/SvXMw31jcQ9PgRh9/CCnAE5SAvRumT?=
 =?us-ascii?Q?vOSYhLemnTqss716PvEmdm4KPo6dGZWyCKpnl6AZ2N0zSDwioTzU4Aw21jLl?=
 =?us-ascii?Q?NRyhnbRr5vmP/RXHDiXfuU6YW1J7MuB5nqVYNNS6lO56DKfsKoPPtY6BEXUg?=
 =?us-ascii?Q?OKjrynPqqQkXkWEB8QELL9zMv/kqhhH8yWjAQSPBgXq3ADsVInsVCE7EsXIx?=
 =?us-ascii?Q?nGyKNolmZLhRwKZQs474CRZ0zsb36UfDcetYIMnDy1oJP6m+S4mF9Lsi6cNQ?=
 =?us-ascii?Q?Fvg4GUx4930ey/so5tg/dx5jtmwrXptbD7JpT3AUW9gn99IDXh8Zm7IqnD6c?=
 =?us-ascii?Q?5is6zv66RaTu560R1x4MWCqDnG7ChTHVeslWScPz3aF+KEEoYSw+DLZH1f1r?=
 =?us-ascii?Q?l07htsPeVaRkaeTu2XeVc8P1rrEvE9iYpDZqTve/N/3TjVelsoaek0XpT3OO?=
 =?us-ascii?Q?X69WKXAVsS+fZHP3wVK2Xk9dgaIOsnJ/swH/PS6UnUpnjWo14vnYI0EqwdWc?=
 =?us-ascii?Q?YfDks3bHW0pFVTSU9PujB/RjTuS1uOjpk2qRm3UzeJozs+R3TJhH/Ei2fsaW?=
 =?us-ascii?Q?eN6LDGhR/RjehPoqwWfKFARaFgLrvLDjMgyVBsrOskWhneOZEFRqvugfNfZW?=
 =?us-ascii?Q?MQpkkPMTzZ9gsPGAl3I3htdNUaTWZPUdWJYkcRq8f7gNHPfSmlWSgfLgsVfZ?=
 =?us-ascii?Q?1/LFsbD4tWsMPxs9iTy0wmKElJt3P2kTO8jINSWNpof5W6pSq/e2Sl5j9viQ?=
 =?us-ascii?Q?O4MWCQbuoSO96RMKGH7bWkam0YOEJECJACL/XzPcPg2FrsUbxcZ7zGsGlu4p?=
 =?us-ascii?Q?67Zfk+z6XoLQzpt7g1K3tvF9HOtpdkRz6tj40wANKn9gD1ffXiBY+1LQfzsI?=
 =?us-ascii?Q?wBX43yIHPVoMOPi1rkbd46eIqj/c7w1DaWWqRxTc9X51yQLwF/ASjyUh2qKw?=
 =?us-ascii?Q?WaXUMD5V2BEbvF2nG9XHt+UvcFMn+mF5VRCxXumf5/Is/ia15At9x4gGe8Jr?=
 =?us-ascii?Q?47/oGSPpv7hcr/sJPR702ehvkxEzW7mo2tp4H4p3opbHnd1Ht6P5gmqQAkAd?=
 =?us-ascii?Q?rtSWbkLCdjsDL52W104mPwEznS4SUbEsdFgQ3xAjJddRfvJMpgdl25Od+riR?=
 =?us-ascii?Q?A6eEztedKerarn9axfRDnuzmvvp61VA/dbY/2mZlHqHzaPL8oXQwkFuh6g8h?=
 =?us-ascii?Q?2qRKb3ABF0HbUxXUBhZ6DxWwbQnTNtrvvx44P/4uG/bld8bEs3jzxaoCYlku?=
 =?us-ascii?Q?XusWqIYuBh99Ad4Dx+/4ghQ/Wp4PSbwWrUjZ4/5q8EV1ASpZaPn15Tu0kRE3?=
 =?us-ascii?Q?ab/iA0D5EvSY0/7a7/Gwz+o1tEflYP6/7ARc7DqrIc5/dzMeTEQz4q9ptnth?=
 =?us-ascii?Q?EVTNXAYoD1WVfjH894ngiAmcYaZPZ3+Cki4CBTQQa0nb/3GpGfCdDjbDCt9K?=
 =?us-ascii?Q?evxNNQb9keUtuv8YS/qPgjx54z4tNlrFk4OBBG8i7NaUwksfYGyfpP3Sht/+?=
 =?us-ascii?Q?kcoPFjH/mU+fHI4WkuDaexXXtbqubHZ2mn2rOOWhozrcUJGZ9GFARC9CiWt8?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed68066-00f0-4c59-9bac-08da91d01f60
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:27:09.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONh62I4nVDnjQHTzeO7qTsMjLBqjAJgW6gvQShv4wpTX3xVYw72ddwbiBqk/iFHtIdHeZYPYCE7crXWlqXlFrVrlrTuy0Ay9tNC/igYuypE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 01:45:35PM -0700, Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > > On Wed, Sep 07, 2022 at 11:43:52AM -0700, Dan Williams wrote:
> > > 
> > > > It is still the case that while waiting for the page to go idle it is
> > > > associated with its given file / inode. It is possible that
> > > > memory-failure, or some other event that requires looking up the page's
> > > > association, fires in that time span.
> > > 
> > > Can't the page->mapping can remain set to the address space even if it is
> > > not installed into any PTEs? Zap should only remove the PTEs, not
> > > clear the page->mapping.
> > > 
> > > Or, said another way, page->mapping should only change while the page
> > > refcount is 0 and thus the filesystem is completely in control of when
> > > it changes, and can do so under its own locks
> > > 
> > > If the refcount is 0 then memory failure should not happen - it would
> > > require someone accessed the page without referencing it. The only
> > > thing that could do that is the kernel, and if the kernel is
> > > referencing a 0 refcount page (eg it got converted to meta-data or
> > > something), it is probably not linked to an address space anymore
> > > anyhow?
> > 
> > First, thank you for helping me think through this, I am going to need
> > this thread in 6 months when I revisit this code.
> > 
> > I agree with the observation that page->mapping should only change while
> > the reference count is zero, but my problem is catching the 1 -> 0 in
> > its natural location in free_zone_device_page(). That and the fact that
> > the entry needs to be maintained until the page is actually disconnected
> > from the file to me means that break layouts holds off truncate until it
> > can observe the 0 refcount condition while holding filesystem locks, and
> > then the final truncate deletes the mapping entry which is already at 0.
> 
> Okay, that makes sense to me.. but what is "entry need to be
> maintained" mean?

I am talking about keeping an entry in the address_space until that page
is truncated out of the file, and I think the "zapped but not truncated"
state needs a new Xarray-value flag (DAX_ZAP) to track it. So the
life-cycle of a DAX page that is truncated becomes:

0/ devm_memremap_pages() to instantiate the page with _refcount==0

1/ dax_insert_entry() and vmf_insert_mixed() add an entry to the
address_space and install a pte for the page. _refcount==1.

2/ gup elevates _refcount to 2

3/ truncate or punch hole attempts to free the DAX page

4/ break layouts zaps the ptes, drops the reference from 1/, and waits
   for _refcount to drop to zero while holding fs locks.

5/ at the 1 -> 0 transition the address_space entry is tagged with a new
   flag DAX_ZAP to track that this page is unreferenced, but still
   associated with the mapping until the final truncate. I.e. the DAX_ZAP
   flag lets the fsdax core track when it has already dropped a page
   reference, but still has use for things like memory-failure to
   opportunistically use page->mapping on a 0-reference page.

I think this could be done without the DAX_ZAP flag, but I want to have
some safety to catch programming errors where the truncate path finds
entries already at a zero reference count without having first been
zapped.

> > I.e. break layouts waits until _refcount reaches 0, but entry removal
> > still needs one more dax_delete_mapping_entry() event to transitition to
> > the _refcount == 0 plus no address_space entry condition. Effectively
> > simulating _mapcount with address_space tracking until DAX pages can
> > become vm_normal_page().
> 
> This I don't follow.. Who will do the one more
> dax_delete_mapping_entry()?

The core of dax_delete_mapping_entry() is __dax_invalidate_entry(). I am
thinking something like __dax_invalidate_entry(mapping, index, ZAP) is
called for break layouts and __dax_invalidate_entry(mapping, index,
TRUNC) is called for finally disconnecting that page from its mapping.

> 
> I'm not sure what it has to do with normal_page?
> 

This thread is mainly about DAX slowly reinventing _mapcount that gets
managed in all the right places for a normal_page. Longer term I think
we either need to get back to the page-less DAX experiment and find a
way to unwind some of this page usage creep, or cut over to finally
making DAX-pages be normal pages and delete most of the special case
handling in fs/dax.c. I am open to discussing the former, but I think
the latter is more likely.
