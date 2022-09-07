Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D625B0CA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 20:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIGSoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 14:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIGSoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:44:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE19AA3DF
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662576238; x=1694112238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y5BCQhzcXilKuXQm5c+lYn/vhPRBXaMgDwBEFu1zZuo=;
  b=MQvt+dm+Nxyxz7bjmC4PUvyjOYcpVGBla5r5KR6vswLl38TUTgcc3sxH
   OR1YXTfYvHxgM5RNNKbXZyqpBhEXGILklWyzVKQE6SfYXV8RSWhC7jza1
   hHzmvXPcnPR5eljBt8/qKZpeLQrT1aQoFSGFg+nO9ii9/nQ5vdvd6jEws
   ZmuyKIh/l7FQ9YOAF88DqzNx+lrwhE3nlR5E/QMr0leNxwqyt1NsVyxh6
   c4/ZW8Dy3BVMmh1h8oEzx61OdVQtvNBOnLjKchEPKdyG4knVCfwgpeyBS
   96TOgsG6553M9VWHzNlb39TNkYh4n6Y5tFNJ8i3ORiuuNmrBFy6OJTYnC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297772293"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="297772293"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 11:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="790154181"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 07 Sep 2022 11:43:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 11:43:57 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 11:43:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 11:43:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 11:43:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdhd7vR0yawHx1RHcCp33nAsOX93+McYo+qJOz59M1MG1h6ZlIWXrZvL20amLbi6iBBv5mCtg28VsAzVQMGYQU46zeudEO1M4NwMPm6B/0/drd2g52+1M0Mq0jmr+3GtSbcrZseSugnRrQLmZpNgWHTY08iWaOOg03fisp8z4e1xgBRD6UgIWHrthszZH5SpW7hERv5xfaaSOodKUreZuXd7DGLA/xwim746P3g6hDnckRVX0mRlmhVJoYRsKKz7Ydjs8Ag5XCxhuUW2RlSVRSBELRX+0b06rNrVbieP69Fk8UlTZZ3Gvrsd53FS/SiUImAAjcHOpCeQkGVwCE4oJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txcLiD/Po5AaTUtb9T+5ix3AFwyjNPj6wFS75Swtxb8=;
 b=NzRKwghPPgso0LlwDBzFaUckXb2H5DLsoNSnvsHg4t8ND9B2vnoVF4NRKrgJVZio6JU3tDH7wjj7BtuJO8zpBLqAMH9EevIvRH4KWseoVGuGrhJNsiatQ0QTiOeSyAJOzlQFZERRcwB67hT2DpqEmgVEQdivo5q7NflB6nxtZU+Yp7c6/xIw1MIv4Zu8u65NG7H11/mHjs1qTAXFUekM6ELc+lGgr+nAb9wAjO3BSUZn4ian13mGEylQ0Uxv6rn3fyajijT9+kOp/Jb25OCY3dwz2cqfUHg1MT4g+9iHGMPIlQntbEFMd/eVyq/QKNkPCyY2k9IdVozji8Ybc6gS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW3PR11MB4762.namprd11.prod.outlook.com
 (2603:10b6:303:5d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 18:43:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 18:43:55 +0000
Date:   Wed, 7 Sep 2022 11:43:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <6318e66861c87_166f294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <YxdFmXi/Zdr8Zi3q@nvidia.com>
 <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeDjTq526iS15Re@nvidia.com>
 <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeWQIxPZF0QJ/FL@nvidia.com>
 <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
 <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
 <YxiVfn8+fR4I76ED@nvidia.com>
 <6318d07fa17e7_166f29495@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6318d07fa17e7_166f29495@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb873f1f-e806-42c2-7bd6-08da9100ea9a
X-MS-TrafficTypeDiagnostic: MW3PR11MB4762:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcgojRmNYcgOg7zXSAvDXqvYWr/vdAM7QcWIIt4ZG5Z1kmpaq2NR4OK5i1vUomCcbekrQsbRM4LNn4smLRRTKVYj3NQc5wqnOca5SUrd4yFheQzl2s4G2fwjzlrMSE7bJzTDpR6DrEdWYbzVmnB4J9LgmNlfuI6ZZlir7XjrxJq9LtVRuClrSCSgREQZ20btpvNja36B9jH+r9lX8CurswUCT+A1oOgX978evrkAuLzsl6IdZ9lUNTjFS352sGhk8oV12XLQj8Skaxv84zoc59p6Wb4AzUljzFYQ82ds0k/2lmbQl110LWkbvHjahsQkdbYoUGq1TPlutu+VfbjF1yplgW98pPxkpomGSQJBCQKfGXNgsHq2yqQwfcOWpgBRyTnjjRtjSRCoPS7gc9d9urcg+bVmHfog9bm7spCfxu87FZzPMgWLJh4k7Wr6uN/XsBlr8MiHFgzKfVbw6NC08fx1Ihah7trE56lV7tkmxXqKjDc0hi6I4eF5eXFv/dhPWugb+txdSI4guFwLZADG3Bt1K17PTNPWF54pjNuI6Ex7DhYWGcomiPkiMs8abqDdowCm1mGCM687lCcvCIQslze9ulcAUQIP3YOSv1AnZdZbg3WDb8OXLVKgV0sRoUaLh5rzr+rV+P6efluegUezj8OkuGBH9d/+lsaC8mr0DJv8lTpYoOhRkd1DIbjnoWCQA4i3OwkYxw9MFJIFBxUBuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(376002)(39860400002)(136003)(8676002)(186003)(86362001)(6486002)(26005)(6666004)(478600001)(41300700001)(9686003)(6512007)(82960400001)(6506007)(38100700002)(5660300002)(83380400001)(2906002)(110136005)(66946007)(4326008)(316002)(8936002)(54906003)(66556008)(66476007)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IaQNQCAoez/n+0ktheRhXxLn9IzJkGRpmqJPfWK8aEkYMEFbMD1V8v/i3p/K?=
 =?us-ascii?Q?5SYFOmObvMJjTcSi0Ri5LeBjyo8EJ3CXpI5wAkw3OQW5hNEgLwxL4dno7sl6?=
 =?us-ascii?Q?l7tujuPuDWf17Giqw8/I2U3pDxuw65y03W+y1Y+jc1cQD/kDMIz3CEffbdBd?=
 =?us-ascii?Q?w0ivCG6AxUJKvTCNYmJ7osTt1YXCav0BDJk7xNw/BDpd7KYfqNIPENQ1rdpo?=
 =?us-ascii?Q?Q1VcBWz62BRbrc0fJMPlL73QqSAM67CLVorP1222xMXWztfu1QhGgVTSbJ6s?=
 =?us-ascii?Q?Pcl+gxhJuiKa4iVLNrNeGZiaaWttUDKt/uoM2XrwjpJ1zbAeKCF5/6R51DdL?=
 =?us-ascii?Q?CxqT3HZbyJQx7cSnBfn6x2M6T3aORrhfyGKogh/QaCGR6/lpocbArlk9jhfY?=
 =?us-ascii?Q?UHghtZiTnMbYbzapUdM2/2X+4qM9TQNO0XuzQp2PA/hdX8sUdLqzOaCmq9ti?=
 =?us-ascii?Q?DH8bTlaOTqNRcYhObliOn3uRhbSvm18ATgVMhQHLO67kxeL+MQaz+9bo4jF8?=
 =?us-ascii?Q?9hdZzBtg79Oo9HGNmWpsdGfMR31AZ5Phzo7wdMTXrmgUSbanrigMPdhFzrNS?=
 =?us-ascii?Q?oXEI6Ulfe+D3QglvbOE+4Z4FXjw4IJPQhHjjcN1UFb4KCItYSMpjdieHLZj9?=
 =?us-ascii?Q?Sz6mUiRrn0Tp4XVhzvWLNrv1IylZ6W+fxZsoi15tY+QtckjlGDUJ950eKwQv?=
 =?us-ascii?Q?cfKmqKkPbI7yVB2J3L0OkSn+sW/C8BxEJkOA0ebflcJ2J7/iITZWqDgIyKSA?=
 =?us-ascii?Q?u71vjsVfTkDzc7xoovIQ8s7IOdiqTWxebulcwJpzsKNrVnVB81foatQYIGpc?=
 =?us-ascii?Q?xX1YDX3++/z2d99Zq5hGvdt1qQUx5ip/iLkk20CK1955qUmHRyegU1wFoygF?=
 =?us-ascii?Q?08Ffsmgm9tvWKPmQTfdYvZWr5chBwEdl6TSrtHcPH/Mt2cR0Yg+YGQaJIzPZ?=
 =?us-ascii?Q?UydM+uSXCN/qbk7w4trGmMOMX3uiR9+KrCqM0VbTiu4qPpan6J8Fr4x+dBp5?=
 =?us-ascii?Q?RjnLvfcbz7OZ3D9FflQuxUk3TH1ouOIr6FLe3IAI4lE888gaUg1L6PmEpPH+?=
 =?us-ascii?Q?gyjVi0tH6lT7ZNVINPlFeESagE7UnaKWTHzIL7D0OCKE7lCk+6FcA3LnOpzJ?=
 =?us-ascii?Q?eHg6x4XDhAd4IzPuGGcWCzUfE+Wd6tp/g2/M0XYm073+cdmnRtz8d5O5Z4Ka?=
 =?us-ascii?Q?wFxDZg2nP94L5hiPVtMGd4SH1DmA4JQG995DEQ6kDA7XxAnH8jgwO9FEmoRL?=
 =?us-ascii?Q?mMG02uHX5n4PFMmS+9qWTv804y5oRWvvDcF0lVTsK84nDiZKL8HgCVrpLzpK?=
 =?us-ascii?Q?y2p9Sx/qbN4Goo6PzmWRrfSx+BYlsgUH218lrgUjGr/vqAsgS9XALejADPsx?=
 =?us-ascii?Q?aBRTIyY52XHQ77/FEvki7yMqiNGeO5jZS17uOtkf2hXGFOtIBr/d9ah63N+4?=
 =?us-ascii?Q?kkyivWWvxlL6ZmjLfQvvAxl4nF4k2ui4DRTznM5nFRujj/uYv6thlmmqGvF2?=
 =?us-ascii?Q?11T8uDRY6iniL1JNMfXqNVsIqsbYUDUXefKD/i6eAnzRkc3JhXvbCTuDX4PP?=
 =?us-ascii?Q?mdtc33K6KdjCBhRkhgdgupyrIMQrqzpwV4nWg7+L+2PR4WGoOByOZCZsr7nz?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb873f1f-e806-42c2-7bd6-08da9100ea9a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:43:55.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUMkp1ZsKXf/xEvS3jxo3s4XfFvVj+Lut3J829bw5E+Y5f1ii6PukxCqdJl9pQfxx+5qdHy2yMtb5Y/aFq+bKT9qiO3YO0W6c2veFUu3814=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Tue, Sep 06, 2022 at 05:54:54PM -0700, Dan Williams wrote:
> > > Dan Williams wrote:
> > > > Jason Gunthorpe wrote:
> > > > > On Tue, Sep 06, 2022 at 11:37:36AM -0700, Dan Williams wrote:
> > > > > > Jason Gunthorpe wrote:
> > > > > > > On Tue, Sep 06, 2022 at 10:23:41AM -0700, Dan Williams wrote:
> > > > > > > 
> > > > > > > > > Can we continue to have the weird page->refcount behavior and still
> > > > > > > > > change the other things?
> > > > > > > > 
> > > > > > > > No at a minimum the pgmap vs page->refcount problem needs to be solved
> > > > > > > > first.
> > > > > > > 
> > > > > > > So who will do the put page after the PTE/PMD's are cleared out? In
> > > > > > > the normal case the tlb flusher does it integrated into zap..
> > > > > > 
> > > > > > AFAICS the zap manages the _mapcount not _refcount. Are you talking
> > > > > > about page_remove_rmap() or some other reference count drop?
> > > > > 
> > > > > No, page refcount.
> > > > > 
> > > > > __tlb_remove_page() eventually causes a put_page() via
> > > > > tlb_batch_pages_flush() calling free_pages_and_swap_cache()
> > > > > 
> > > > > Eg:
> > > > > 
> > > > >  *  MMU_GATHER_NO_GATHER
> > > > >  *
> > > > >  *  If the option is set the mmu_gather will not track individual pages for
> > > > >  *  delayed page free anymore. A platform that enables the option needs to
> > > > >  *  provide its own implementation of the __tlb_remove_page_size() function to
> > > > >  *  free pages.
> > > > 
> > > > Ok, yes, that is a vm_normal_page() mechanism which I was going to defer
> > > > since it is incremental to the _refcount handling fix and maintain that
> > > > DAX pages are still !vm_normal_page() in this set.
> > > > 
> > > > > > > Can we safely have the put page in the fsdax side after the zap?
> > > > > > 
> > > > > > The _refcount is managed from the lifetime insert_page() to
> > > > > > truncate_inode_pages(), where for DAX those are managed from
> > > > > > dax_insert_dentry() to dax_delete_mapping_entry().
> > > > > 
> > > > > As long as we all understand the page doesn't become re-allocatable
> > > > > until the refcount reaches 0 and the free op is called it may be OK!
> > > > 
> > > > Yes, but this does mean that page_maybe_dma_pinned() is not sufficient for
> > > > when the filesystem can safely reuse the page, it really needs to wait
> > > > for the reference count to drop to 0 similar to how it waits for the
> > > > page-idle condition today.
> > > 
> > > This gets tricky with break_layouts(). For example xfs_break_layouts()
> > > wants to ensure that the page is gup idle while holding the mmap lock.
> > > If the page is not gup idle it needs to drop locks and retry. It is
> > > possible the path to drop a page reference also needs to acquire
> > > filesystem locs. Consider odd cases like DMA from one offset to another
> > > in the same file. So waiting with filesystem locks held is off the
> > > table, which also means that deferring the wait until
> > > dax_delete_mapping_entry() time is also off the table.
> > > 
> > > That means that even after the conversion to make DAX page references
> > > 0-based it will still be the case that filesystem code will be waiting
> > > for the 2 -> 1 transition to indicate "mapped DAX page has no more
> > > external references".
> > 
> > Why?
> > 
> > If you are doing the break layouts wouldn't you first zap the ptes,
> > which will bring the reference to 0 if there are not other users.
> 
> The internals of break layouts does zap the ptes, but it does not remove
> the mapping entries. So, I was limiting my thinking to that constraint,
> but now that I push on it, the need to keep the entry around until the
> final truncate_setsize() event seems soft. It should be ok to upgrade
> break layouts to delete mapping entries, wait for _refcount to drop to
> zero, and then re-evaluate that nothing installed a new entry after
> acquiring the filesystem locks again.

It is still the case that while waiting for the page to go idle it is
associated with its given file / inode. It is possible that
memory-failure, or some other event that requires looking up the page's
association, fires in that time span.

If that happens the page's association to the file needs to be kept in
tact. So it is still the case that while waiting for the final put the
page count needs to remain elevated to maintain the page's association
to the file until break layouts can be sure it is doing the final put
under filesystem locks. I.e. break layouts is "make it safe to do the
truncate", not "do the truncate up front".

The truncate will still move from being done while the _refcount is 1 to
being done while the _refcount is 0, but the condition for break layouts
to signal it is safe to proceed is when it can observe _refcount == 0,
or the 1 -> 0 transition.
