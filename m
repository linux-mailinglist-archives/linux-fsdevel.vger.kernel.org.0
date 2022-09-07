Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB935B0485
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIGM7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIGM6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:58:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A29796771
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 05:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0jRIb8PBTv3Ge/HKUg7PQjyYY64UwofPGZb1v3CTOBBvJMNpWUcd6gAVglqtCABFY8j6Qq3WhfXRVrvBoCtsC/fuZ3UQaAUciT9GfvppTHd3bAA/UPqdsnMYm11dBTDGJMpsAiDnldQOQrGocCxDtA9+f92cnNkVQ3tk59mS/8hrCP3ZTZ3DG+AD1kDl2ldj7NuMRtBrWf2gDOi+++FolzDaRDqZKvRINgOKYJRqNS7mOFjdfZS9p70w1nVDL9utIEtx7nZyYeMGGpuz/36LtlhkzNG7GljPja/NxrqQvpAu0lDcGZB+ug5st2g83qKdQ3JTLrfwTWl90bt0iR38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A64zjVI/Qc1+3+1Il8Q8EYEWR1+0QqwkfrzIMDtezw=;
 b=d/+U3Di+DtJA97Byooeve9fqpbr3woq7Pd3b19cxgKqT10db7lVZtSzfMYBjd7b6IOPAJI3HczDMQmSocNT40xint0OW3BF2Xsw57rtz9StFUbZJKp622AZ9Oh8B6RXd0BCS9V6ttAJ6gpzWc5wFW+P5nN5+lLsNgkewXbug54tvPo+33RwksdSL4Z/hGDOArttVzOZW8nXasE0dShIqsEy19a7g+TQIO1QTwfv4T5qMjwIb5gsgyZsfYlo0ywT+vi+43qjVVT+cHgdTDs0mGOaT9rFkf5KJIGr24wWiIFb0ouy2oP+L2kJQw9i8u1Gnkf7g0AEhdLSVAiuqVE31DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A64zjVI/Qc1+3+1Il8Q8EYEWR1+0QqwkfrzIMDtezw=;
 b=Qx2vzO7kDbYFXiQudGSfrGL5EbOUIQbovTs2o1p8ZzuBZIAEPEEFI0FwMIh2SvX6BPgMOsro3oNiFFaucY3fSGzjCGfDFTTGIrXO+JirjHs/XN8xApzgVKseqlxE8aDCDtGZJNzgN9CQmxzXCg3Tf9EQlfeTs1HSGIypqQVnewrd88oLMIn2eL9FNWzVL/DCibQfkWrBOZ7qQD+XlOn3ur/wZurb8PJdRd0SIxaIpV1H51bN2L5jbphUUQUIr0ZH7GDYl6jPPL9C0hbcxr0hk2K/1TN4FKxqo2xpanLweDZOxHniyKh7lJD1q8ZpcTyOXSb7Q4K57IWPJLwac2ECMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 12:58:39 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 12:58:39 +0000
Date:   Wed, 7 Sep 2022 09:58:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <YxiVfn8+fR4I76ED@nvidia.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <YxdFmXi/Zdr8Zi3q@nvidia.com>
 <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeDjTq526iS15Re@nvidia.com>
 <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeWQIxPZF0QJ/FL@nvidia.com>
 <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
 <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:23a::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9beab951-35d7-44ca-a8e4-08da90d0af31
X-MS-TrafficTypeDiagnostic: PH7PR12MB5879:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7D8X8xZxYe3dRQi0+5itozc62x5OzAnHB3vNuaDzxN9zEUNKH0QQicKiZYZFnNYTujml2eeZjZcnyj0DfUPlMg2RSsdguMhJAGMRH5a6Fn9KW9eOF+Sq5JbpvSMR59paVSu9pwO4hYGYpakQlV/i4850RFvsXQRZAQNZw3EO4vsZaIG+Mb+ZA1aLJ9qSk3XdTozPHJQ5H8N9ONGPZ6WJZaewl/Be/NSGEJGvP4M16IXy5MeWGcmIZHie/2EXae0WdYDWbDdNnj13Ne0BvAhWvdJPIHpY0Cc1O80pTI4cZGnWPk16mQZZ4zw7YrIs3C5w7XOhKQCxQY0egxpZGKWWAHnmrbIkVVehuEcLvcw0kdcmhOskvYVW+Hh3IYspAtCmQsnI1oLMc8hWHmF2euRTNJpWGHzoLbfwXQk2RB3M94j5zPCV4u/3AK4RNB9qDYpOdRBXmLEXQoyjdPhrQU1+9bXy4YVfNeaOqr+irz9wMlfPuerIx7ZdOOThYZ7ACjahaU8Bi257re9o3t9KquPold+r6859JtyUdhlFrmRnzspYfR1EItzDS7JHPcSwQ2q1LMSE20Exp0MX0iIoyXCqmQ3Ka7Pwu8Nj1BVNxQ0A4/ygyAu7PjukoIDoMCs5RS2UzvYCFWtbE9QVQLZ3o1s9WR6GbwR2Hb3TSegT/klEsfnxAZjMNdScqv8VrIU/f5U/zrQs4yOUKrn6h75M2nVJecYZBcYtA2sNhmL+Mm41NI7/wzQ2ulDMntRYQNLz2qn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(66476007)(8676002)(8936002)(478600001)(6486002)(54906003)(66556008)(316002)(66946007)(4326008)(6916009)(38100700002)(2906002)(5660300002)(36756003)(83380400001)(26005)(6512007)(41300700001)(2616005)(186003)(6506007)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DAtSOEn6lGZg7YH/3RTearwO5nMqK5MaVXR+qnNhB+EPzgTPosIyGxkEiopJ?=
 =?us-ascii?Q?8lxiP5dr0aTTIH+aZAhdQNm+c0wMIxg/hL1R64RkxfIWUZmLuKHY45fg+1lk?=
 =?us-ascii?Q?+AfU9qIGMvXCYYVl9Iv7hyr+WhPjwbfjN9L6NevO9qzHtk82CpbmltuF7VY/?=
 =?us-ascii?Q?J/DyWVFWPo/GAxJ55BvklXZq82v3H1fNM795+N1FymonsKaKl6Sno2qN5+Dl?=
 =?us-ascii?Q?/T99D9V771iKV/2lQ4eud6U6T8N0qxuEDFmkOFknOAMGOBf9jd+MDUnzneUj?=
 =?us-ascii?Q?NSD6iAoqVtEGqhPf/Qg263ITKzmK0gGaiWRNRu+Z+qcuTrQFAymG/PiZd9Co?=
 =?us-ascii?Q?Ewr/7NXKY7nBcW3qu7sVAcIHU+yWzTCmju5EpyA4K6F03DKa9vsxgDrm9Egu?=
 =?us-ascii?Q?W6cOtwrrFnUAmlIfBofs8BK+Wq42Z2vodGLPHvKzKjqknBSDJ2duAZvY4S93?=
 =?us-ascii?Q?Aua9+aeNwI10MbNSmKSDYfLZGrQK5HidpEUNHrZauVcizBNK266s3U4PsXfi?=
 =?us-ascii?Q?rtUmar6HDAVsMN68esGewiUVFZf9pQCL+rWQ+X8HGENAcXaM8Wkmn7gvoYcE?=
 =?us-ascii?Q?yvepbYjP+NGWrkaf9ibem7e99AjK6myMp0Cwqbzhyd65XJpFvxLuG8PlfUue?=
 =?us-ascii?Q?vrBkG2DwgHGhIZwRXd9cVZbG1QH9+2IoXqeIe0xlmjgC9V4yoHpzz81iFQjU?=
 =?us-ascii?Q?hAzoLHkPgOrWLvzRlR7lE3W7QQ2UQCdY69gRkQshx+VAnIgTecnYRPqCfhi4?=
 =?us-ascii?Q?pSHQeDHSjgw9Oh8iIhktvoCy1FAEsjfgopPn842WiQrKsTfIzjdUh4FKc6BH?=
 =?us-ascii?Q?RRVkE102qS+56dFbiH1HWA+KyFnoQTZokPBQ6GBDG2w17KvLQyAzRSookHFm?=
 =?us-ascii?Q?vFPZ/k+gkh8aIQMh7/NJBnDq+xpsIFZKJprh/XxQaCP1Zumdl0VQJSv7o9uj?=
 =?us-ascii?Q?x5ZAZKJ3DI3OgMKKx9vf1dfysd4upiuXNLe2Rn1nypd7iT4idsvv+ZzbHYxp?=
 =?us-ascii?Q?I7Jzf7cr6s5gJw2BSyJBYUkpahgI5RT26K3BQy1O28b0orxjekQy5TLItITd?=
 =?us-ascii?Q?kEiq/tnr/1hpqhyFkM3Km6OOEwLRMPVGQCfQt3zwxZ7T+pVBXp7Jz/tEiVeM?=
 =?us-ascii?Q?x6oltxhcgUPkbvSJtj/1YIpmibagffI8WcT7EEfq2jGRhiNMyBmpGbTgLc+8?=
 =?us-ascii?Q?rstwF/nYuIyuYgBFyNhYrrfQIH+cGLXbiY3GwoiIimiRWn7bltWWLUnBTMk/?=
 =?us-ascii?Q?UWwCXk3cnZ6g4wbPShrNobljMzL9tJludQF+MbCcOF1ZanbnGHapBJuOlW0D?=
 =?us-ascii?Q?hxXhLKPI/xlqJMC721ScZ5VmeAnLVs01h8PRagHg957b5chpZV9W1Ee+cFDM?=
 =?us-ascii?Q?4VDhAEoc/W4/g+IZgFUcePwrdqfv39R6SVQ1uyFttNjt/WgHEdCj9CmR3tBR?=
 =?us-ascii?Q?jO5P1s4DN20hxJlugnsTRx6iI9rNTM3fQFoT3FCn37VAKiuh2rrImHPwy9MF?=
 =?us-ascii?Q?XdsNPiOolyU3kLs1jkYh6o3GdmFFchB0p/A9N7maNUqd1XH6mco6SLWiFGgT?=
 =?us-ascii?Q?xRtrmp/u+0L7toIt0Vp/f0brJyn99dS/Aw7ApNpi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9beab951-35d7-44ca-a8e4-08da90d0af31
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 12:58:39.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbY0pEvCu7b2Gu+qAxSBMAT0acgaBz+nc/VWmxX9U6r/9R6gu559ey3nceEvXUBn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:54:54PM -0700, Dan Williams wrote:
> Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > > On Tue, Sep 06, 2022 at 11:37:36AM -0700, Dan Williams wrote:
> > > > Jason Gunthorpe wrote:
> > > > > On Tue, Sep 06, 2022 at 10:23:41AM -0700, Dan Williams wrote:
> > > > > 
> > > > > > > Can we continue to have the weird page->refcount behavior and still
> > > > > > > change the other things?
> > > > > > 
> > > > > > No at a minimum the pgmap vs page->refcount problem needs to be solved
> > > > > > first.
> > > > > 
> > > > > So who will do the put page after the PTE/PMD's are cleared out? In
> > > > > the normal case the tlb flusher does it integrated into zap..
> > > > 
> > > > AFAICS the zap manages the _mapcount not _refcount. Are you talking
> > > > about page_remove_rmap() or some other reference count drop?
> > > 
> > > No, page refcount.
> > > 
> > > __tlb_remove_page() eventually causes a put_page() via
> > > tlb_batch_pages_flush() calling free_pages_and_swap_cache()
> > > 
> > > Eg:
> > > 
> > >  *  MMU_GATHER_NO_GATHER
> > >  *
> > >  *  If the option is set the mmu_gather will not track individual pages for
> > >  *  delayed page free anymore. A platform that enables the option needs to
> > >  *  provide its own implementation of the __tlb_remove_page_size() function to
> > >  *  free pages.
> > 
> > Ok, yes, that is a vm_normal_page() mechanism which I was going to defer
> > since it is incremental to the _refcount handling fix and maintain that
> > DAX pages are still !vm_normal_page() in this set.
> > 
> > > > > Can we safely have the put page in the fsdax side after the zap?
> > > > 
> > > > The _refcount is managed from the lifetime insert_page() to
> > > > truncate_inode_pages(), where for DAX those are managed from
> > > > dax_insert_dentry() to dax_delete_mapping_entry().
> > > 
> > > As long as we all understand the page doesn't become re-allocatable
> > > until the refcount reaches 0 and the free op is called it may be OK!
> > 
> > Yes, but this does mean that page_maybe_dma_pinned() is not sufficient for
> > when the filesystem can safely reuse the page, it really needs to wait
> > for the reference count to drop to 0 similar to how it waits for the
> > page-idle condition today.
> 
> This gets tricky with break_layouts(). For example xfs_break_layouts()
> wants to ensure that the page is gup idle while holding the mmap lock.
> If the page is not gup idle it needs to drop locks and retry. It is
> possible the path to drop a page reference also needs to acquire
> filesystem locs. Consider odd cases like DMA from one offset to another
> in the same file. So waiting with filesystem locks held is off the
> table, which also means that deferring the wait until
> dax_delete_mapping_entry() time is also off the table.
> 
> That means that even after the conversion to make DAX page references
> 0-based it will still be the case that filesystem code will be waiting
> for the 2 -> 1 transition to indicate "mapped DAX page has no more
> external references".

Why?

If you are doing the break layouts wouldn't you first zap the ptes,
which will bring the reference to 0 if there are not other users.

If the reference did not become 0 then you have to drop all locks,
sleep until it reaches zero, and retry?

How does adding 2->1 help anything?

Jason
