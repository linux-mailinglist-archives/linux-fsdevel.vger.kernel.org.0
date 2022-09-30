Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E205F11C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiI3Sqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 14:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiI3Squ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:46:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E71BE7BE;
        Fri, 30 Sep 2022 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664563608; x=1696099608;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2UTXuPihkHpM0k2dkJ7HQUjFlwJPR+YWRB7DXB57748=;
  b=TO+SNg/bqlNLSzTkr9RQYR05aVKoC5LKVPyU5lJjdKz36396oCKAqBYj
   UgDl10oCNzOlLxojt471MyqcATK75C8qh7wg3XyVJjwH4495foOGRXXIo
   yEwsGT7LZ0BpmE5twGRq3bmPSqeojrUBlUW2TvjWLFO1PMp9tJYefMzgd
   mo/KsroljSWdu6fWSt3qpG1dHAr/Do4SWZ2WzEpsi44AEFd+D/fGzj2Bn
   nlkPozBBKk1sckWcNhlN4upZCVIjtgGGlj5H91kbx1XuZ1j9DPNeqmQms
   uDY/I0MpUs7S40w0Nd31fV2nFKRf7U1dVeW6LKIZJ4apfvt/04AwytcZF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="328648685"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="328648685"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 11:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="867909139"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="867909139"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 30 Sep 2022 11:46:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 11:46:41 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 11:46:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 11:46:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 11:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHqxDeB+y2IVVUCsWRMXAR1XMtqTjpL3l1ue5wMTXk3AjzbFhDR1gfen1VjUx8qQE1IbJDnt2oqmwh9sxaJOmNL5CClA28m+vkUj5l9gp8lMbNCB48Dhzp98/5m47RBfn5FW5+TA/ugEID1RDfW1IUNVAMOtRzrYiRw3S8Id52Xurx4IWMrv8I+G+wXq+/k8MNWtgIYefG/ugetX9X3zA5posfODx/UpCw0c2LwbWOCCfT3O2mrwSDMlBuSQqTfPaw1DftevF4D/c5Dk+eeVLhdK+5+kKErDBou1HLd4OZvXaNVpA626VID3RhYn74tUSokUQfk2tKu58PgMRpJhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXMZ5+9t13LO7QRrL7JQY5tupNv/XrkErvE2vB0rgCs=;
 b=iPrKbGfEy7TP2PHBJGq4tY7UEBtXAgSH8fsD5gxdDpBnfCN6gdOXi9C7x1U+r0l1gpxiQbh2Jzva5tbiPDKOiv50SlaIuitHsWcJiORIQFlSTgTKu82MNT/d4DB+g3/a/v3bWLZ+uLjFOby/UISWuV441FS1vxyaoidQfzYFa7eTB+7yrBBis1h+jaJs3h2G4jc+29g3NwMXPb2cTP4iDsdRLAmSvLj/DSH0opx8g8aSTuYmdrF41uksNFSyoaf+U4rcW3eD24h9YMsEHIAKkyMANEWp/tG3rN4KHnbRQeqL4ixqiz6CKppIr32Qeg0Onfaz8ZJ5NPQaGZZr1muX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5401.namprd11.prod.outlook.com
 (2603:10b6:408:11a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 18:46:34 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5676.023; Fri, 30 Sep
 2022 18:46:34 +0000
Date:   Fri, 30 Sep 2022 11:46:31 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <633739872f981_795a629425@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <20220923093803.nroajmvn7twuptez@quack3>
 <20220925235407.GA3600936@dread.disaster.area>
 <20220926141055.sdlm3hkfepa7azf2@quack3>
 <63362b4781294_795a6294f0@dwillia2-xfh.jf.intel.com.notmuch>
 <20220930134144.pd67rbgahzcb62mf@quack3>
 <63372dcbc7f13_739029490@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <YzcwN67+QOqXpvfg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YzcwN67+QOqXpvfg@nvidia.com>
X-ClientProxiedBy: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BN9PR11MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a14e92-5805-440a-3f51-08daa31418e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4V9SeyEeDV7pq4A3yi+pynW2jAUQRv5RQRJOUeVVoh0Vw+wvz3yEyxcvP/WbXHlTF+RTyGpicQ7/aBsDHJFujtWsShXi4ESQufJYsI5KEzzgRp+ow9yg19stsjtVH2708kdAItfWU1zha1z7BsvFxjKnAO8DN21SJe6Bb5tEzV6HMg7klu4MP0hQapJFkzqQRhZd2xf72N80TzHIw7zH9dOE4dMHQ8qrR+MNlWuD28F+rtsDKH/Zn8BQKtPeMilT9fGCSQQAlIpdBSmVLyZncaNIt/fvKVLyGmQ0wIEEopWAhtE7FUOs8ctQrSeFHH64zxl3VGoUZESpSUl5l3vhWv6qVRcqbJ27JcxHnQilnLWI9HSM06wA7NYH2GW3Hh3JFOxG2c1uTysEEa+lU4Sjj1gXyzzFzcOeOJJfmX4+6aCtDht4huoIMXbdxHQRGkN9N6kG+Hr8/gJAKKDhbI7NK138lu7Ar+B9bVAIqhiMnsWqLovjj3ayWBv6rRN59I3ukkwj7DhmZ+MFdpC95opCvZ5wbmrBq5k12xj1Jfr+C6kTi9ZpYaLBw6Vm8+USodxjxjEzEMEdoEa6Bf2CssoxttvAvNYT14wVl51hnYeCbmZKGsyHT6l9Nz6+6u3v5IIJrotWan2kd4/8QHdV8B9Uw82ec5h8t7TYV/JwCdCAoSbXuMDzOdWBJcoQ39fykY4ktcktPje5WdzjSBtVPId6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(6506007)(8676002)(316002)(6666004)(86362001)(478600001)(66899015)(4326008)(6486002)(2906002)(54906003)(110136005)(41300700001)(8936002)(38100700002)(82960400001)(7416002)(5660300002)(186003)(9686003)(6512007)(26005)(66556008)(66476007)(66946007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GxL4siko6LY9k89ybLj7P1jbIjgLlJtlv+rO6fH9YrUd0ITXAQmAIqLoGUiI?=
 =?us-ascii?Q?2aqxZxuVRm92MsCV/tfbrZek/+8c3dKd5Pq2V/kGhTYDsSwj8SZ6JnW3wFNV?=
 =?us-ascii?Q?vgY3QmAFEAFAmrgL16YwRrIEy1cfyYrEqfMNV866vcoxGbmu2V7JK6VVZMOM?=
 =?us-ascii?Q?1C1S65sXxiBKjoSRK2x6ZGA/jY9ZXqs4bCGf8JYpUFUqG/Pp1OHPt+FUDV7S?=
 =?us-ascii?Q?XzIZ4D7sTfJA4rcCAzpdBE+SlpMnYgsktTUF+fzLemiHuPtHxsCog0MY1zJO?=
 =?us-ascii?Q?QV7j5DmXiZ0F4ZxveiUI22uDsrdAtnjlbQ5L+X46Y1fKUPFB3+KdW9LsARsU?=
 =?us-ascii?Q?STy6mecpKOPcun4f+HQNe+wJAsfL8MEc8XqadXFDmjGdggU2TDX6zOCM4XgA?=
 =?us-ascii?Q?rqQMw+cLhXebqYoLiIrHtOP3pO4vKmUYRq/9D0F9xt0Bbd4myZE6hQPucLPq?=
 =?us-ascii?Q?kHRgKQ0/0RemrsAH23CfFrqcuTyZ4XrGKDxwyCbpQ9OAwOO5rhYpVDMjYYle?=
 =?us-ascii?Q?JvdT3BBM692sHEPnEHy8UJF5RH10tgu5t0Urh7VnOlZF/1Zw+XvJwBQ2vau9?=
 =?us-ascii?Q?/xHOEd5cX0MCyZ0uMH1l3VOqU1qlREPi1zWJImncVK8I0s+HvRogHP5ccn1Y?=
 =?us-ascii?Q?2w+JceTVQeIWDhhlCOotlHhjCnPgEdirkGBco9eLW7vrM3lBFS2pynb1Mlhd?=
 =?us-ascii?Q?RWKd/ePzyLi1cdEj8lb4S2WHASIsej3kfpaTF+zcXHUHJK4ygfIHUzwoay7U?=
 =?us-ascii?Q?GhMaL1r3NKS4GfGHktCOUnnDitfQkvv55Ee7NC6LNMvAt/AJk7DqgHWNAosF?=
 =?us-ascii?Q?JcVja/Mp40KshFxdqTedHNoC+1DEq/gjGNShAKsT9+nwH8t7pi+ArjvCG9Jv?=
 =?us-ascii?Q?CkWBAw1dVsqPiQJB/cEcx5ruw2n7f/DJcv0SzhC3BUlWz8P4a2vxzP1EHb3f?=
 =?us-ascii?Q?+tezwD6yXjhJPa6zBAuT7iBgf8JBZVa08zO0KlCKBb2SvgTae22/G4Mb2k3X?=
 =?us-ascii?Q?DJQVyFGdCdfkaH6vfLEUg1h3BFH5+vG6ZBxEhwU81KyHLi/xTgCREo669BYu?=
 =?us-ascii?Q?i6O2tLEd+mUeHxGfd0qT3acaTAsXax/s4opvbt2YcxEuXQXn+OHUyKiy1gnQ?=
 =?us-ascii?Q?5AQL66X94HHS5fb0aU33alDO2NNHtY6o0jpC82Tm/ONjEWlZW2cHnxoIEhCi?=
 =?us-ascii?Q?zxNI/wWZcM1endBycjV0nPbtaAnKDJUcEIUfQdWimYxhbmN9sSvlVbftWJGz?=
 =?us-ascii?Q?czMK1cqHOPFyXK7lvtpmsg/d1sTQStw6UVwpPhFCHZl5Gd0YzLCdzF0kRcfG?=
 =?us-ascii?Q?+rHuNlWt7c6aZOXSq2Ye9+2YbGTfsaExCMV4PDZo4VBgAvXdH0FZJ09hhQkq?=
 =?us-ascii?Q?0J5LIatKYN3PKf58WoVhGkGbbuDFJdbWsmUJEH7nXAtB+szPt6mZG2Q8iCc9?=
 =?us-ascii?Q?rdhNKuNAfd4NVCRSH02LpAzZQmroXU6W2JbyI5fqTnKyVh4JjGTkeXoCE+2W?=
 =?us-ascii?Q?cAG42FJXUmWLzBQ/+glXSQejHHWPFlRi0TRooNiFRZvCp78AxwiBWFmXW6PI?=
 =?us-ascii?Q?JFDHJ64Vw/QkgfpPc6lJIaCEzz8fQxzNEy/hiJ5Mjof+vIMV7BXuAHUJRVt8?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a14e92-5805-440a-3f51-08daa31418e6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 18:46:33.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdOskhCBNoU36pZVbCgSgtoaI1S0EjJ8sm9mqFkjCVbKUr5f09iuoU9FYge52Bz3NCa04b11gUFY0QUOxjPAibAK/BWlxArwoTh1e2JyBuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5401
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Fri, Sep 30, 2022 at 10:56:27AM -0700, Dan Williams wrote:
> > Jan Kara wrote:
> > [..]
> > > I agree this is doable but there's the nasty sideeffect that inode reclaim
> > > may block for abitrary time waiting for page pinning. If the application
> > > that has pinned the page requires __GFP_FS memory allocation to get to a
> > > point where it releases the page, we even have a deadlock possibility.
> > > So it's better than the UAF issue but still not ideal.
> > 
> > I expect VMA pinning would have similar deadlock exposure if pinning a
> > VMA keeps the inode allocated. Anything that puts a page-pin release
> > dependency in the inode freeing path can potentially deadlock a reclaim
> > event that depends on that inode being freed.
> 
> I think the desire would be to go from the VMA to an inode_get and
> hold the inode reference for the from the pin_user_pages() to the
> unpin_user_page(), ie prevent it from being freed in the first place.
> 
> It is a fine idea, the trouble is just the high complexity to get
> there.
> 
> However, I wonder if the trucate/hole punch paths have the same
> deadlock problem?

If the deadlock is waiting for inode reclaim to complete then I can see
why the VMA pin proposal and the current truncate paths do not trigger
that deadlock because the inode is kept out of the reclaim path.

> I agree with you though, given the limited options we should convert
> the UAF into an unlikely deadlock.

I think this approach makes the implementation incrementally better, and
that the need to plumb VMA pinning can await evidence that a driver
actually does this *and* the driver can not be fixed.
