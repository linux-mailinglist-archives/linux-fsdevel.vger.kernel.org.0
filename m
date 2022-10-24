Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1892160B596
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 20:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiJXScq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiJXScU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:32:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CAF963BB;
        Mon, 24 Oct 2022 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666631646; x=1698167646;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Qb/sh+xlEv67TjVaiznmLTT35XGmhexKbxcktYvTufo=;
  b=RmsWpq4VIe9IicxLm5Sz3KqE+DnKzb3P1v4e0mG5pNz/WsGTiRHptY7a
   n6ZTtAungR3ORT1Lke8SK03IRBiqJIff1e74PDYz68kFrn++x59YEjlZv
   PlPl1k7OHgXbi27eyUhhIEP18nbPw635PwN7kECqbsbAzczlZvU/sSicu
   psC/gM5jG5gfJKZ+Ick3dV5RI9sk/pOq4Nu6USXx0N+p8dD28FDuy/7Sy
   4ROJNnV80uL3XURlqrefXsIw+5cS7bn6ATL4YrmGdxIX6bF7IpABcBSMS
   a0TQh3sr9N4ZHpqWdWaWKK0DsvLvmamqn5sQgIH6piqIGlNPIEtLXYdMQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287874526"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287874526"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 10:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631334609"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="631334609"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 24 Oct 2022 10:12:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 10:12:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 10:12:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 10:12:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 10:12:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOckXaz6FjAr5m59MrFesSyl2tnoR9P1WPdJFGGBFVBG7rInfVGl5vhr4vFJTrodmwFnek8GwCfhdH3PFz5CB8PTC9upkSC7gXzvXalHEmyjS0aFNQ0Pcc1ZsRbQJ8EcqCoQxl/P/qY2lw+vEVDdiIUJHO7TAFXC+m5B6TbSM2P67wfL7fAR3F/1yKIJ2BL6I4XyB+TSOS6rhRD5UKE6CW127Hsb8wkZkcODmoKFLV33uz+sxY6aejiDi3h8PET95Me5uzyCrGV4GDunOcnvnV+z4iTmq/006elzX6PWTbQFRs2dl4sow0W2NL0yFyObUP73igtRD4jNyMFLqo8ceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOxmK+WkawsXo/gpS/owv3vCWGq/Bg7dFboWT07aGUs=;
 b=VdUR40zmrmBGTqnUbaTtajI5KQ+6lNyc8mYSnyE37KIIvEh8dTPeA9Y/TT9PliAdeXM2rScqW9o6GjkzCeR+tUra9FSecWhrBpYZkEBYfJ5GPQLpmGTWP4lDlOOKVuXJeFAhyUALab4ABV1yn2kENBKnTdi+WnwjetmbNnCAQM/lnMfgIQczB6txwOm0d1NUJh2bmwCOB5cAGjeHthq3mKodirLsqvX9eaNuY0uW9O8OpAYfAV3n4v2yLOiRrD0fZiYlznoggTx90ygZbxLd35DlgiVd/ObP6OjL5nxWAhq/FbW1PmgVp9ZP+e1hJlfmN7tVk/AwtjY12kjzpSxP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4582.namprd11.prod.outlook.com
 (2603:10b6:208:265::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 17:12:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 17:12:39 +0000
Date:   Mon, 24 Oct 2022 10:12:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>,
        =?utf-8?B?R290b3UsIFlhc3Vub3JpL+S6lOWztiDlurfmloc=?= 
        <y-goto@fujitsu.com>, Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        =?utf-8?B?UnVhbiwgU2hpeWFuZy/pmK4g5LiW6Ziz?= 
        <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        <zwisler@kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
        <dm-devel@redhat.com>, <toshi.kani@hpe.com>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <6356c783c1813_1d2129457@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <a6e7f4eb-0664-bbe8-98d2-f8386b226113@fujitsu.com>
 <e3d51a6b-12e9-2a19-1280-5fd9dd64117c@fujitsu.com>
 <deb54a77-90d3-df44-1880-61cce6e3f670@fujitsu.com>
 <1444b9b5-363a-163c-0513-55d1ea951799@fujitsu.com>
 <Yzt6eWLuX/RTjmjj@magnolia>
 <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
 <Yzx64zGt2kTiDYaP@magnolia>
 <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
 <Y1NRNtToQTjs0Dbd@magnolia>
 <20221023220018.GX3600936@dread.disaster.area>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221023220018.GX3600936@dread.disaster.area>
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN2PR11MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: c6002ab9-5bde-4c3c-91df-08dab5e2f43c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mcT66fr236kFCHPbBb+SJuvS+oYBijY1HIxmlu0iYTPNunIELqTpd75syFM/qW94/8QSQE3hscwnUcXoAp/5C8nJgywExvWxq1H3zuJU83oYIXOEP+x4Uol5wd2fvgEoffaTvLCVn2SEnxGvriPTbAI91lK5KoYrKb+RYvBl6xpIjYSHu+EiyQ901emPJrZgAYU5ZAsD3kQ32x21jAA2ecqBcVWPvHx9RsQOhWONHfkPDWkmpiF4NVAjbNJBO00HSju21mcHLVv0mSTCtKTNcrxGV9aNcdh9D1qcKRDi2eK5xPKsZclKZJjZeFxNad5Gm1HHJuYpbHpbTd9wwAgS9IOkF6F1GzH32gMdG1Y1i18AndpafR9JeXKuDykY37KWZKdl5XujF14o7e9dn/6lH6g2yRkVyRaQsFixX9I5ebkJmb+12/bsCod6j8Fsyy6XhwaKjVVuLSi89Wr6uLxlsPgZRvgBsC/O14H3XxWnUO1E04OQ+qfOXhpDnBl2N41tuhYcWUYSVEGlo6FP2zicgdNXSixAwg1saNUjjMxeiaXIzsbe3TmPnYwP2jZjFq5tQ8AUB6iTJfrmhW6eQxzDI/G666gmzADlc7zP1MOj7NDDuEa+AP6kFr5kDq4+Rg3NZ2+EB0sI2wi6P55oYnL8NLQvdWcY7Q4PZhF35ktpLeBPn8iGBznDtkU1XUAJMr2yOasf8Svs09LWgIGymnoPpZLbvenh80fs8bt6H0EO2tXEwjX2MzCMVGEiWUhUov5Uk3+RCXY64kcw1IGGYP//g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(66899015)(2906002)(83380400001)(41300700001)(4326008)(110136005)(8676002)(66556008)(66946007)(66476007)(86362001)(8936002)(7416002)(5660300002)(316002)(54906003)(45080400002)(186003)(6512007)(9686003)(26005)(6486002)(966005)(6506007)(478600001)(82960400001)(6666004)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVY5VjVsZzRiSy9yQ05IUDhzMGFhUFlhUHBZS2ZPZUF5d1hRWGV4cXpjUWlk?=
 =?utf-8?B?WEJ2V0lnZmNWSTVJQ1ZTZXZ6Z0IvT2tjQWFjS2ROeGJXZ3EzMnorWDh6bHYv?=
 =?utf-8?B?N3ZVb21IMGR5aVc3SHB0WjQ4Q0RXdEc2OFAwMjlCa2dlQ01rK0pLeHpDRFRp?=
 =?utf-8?B?TnErSHFBbFNmNWxNRjNMSUIvOHpRZnlEemhsSzM3WWtsTzZVTGVqTTNzVGNr?=
 =?utf-8?B?YngyVUhQVEhEbTYvT2ZabzFiZDk0WEhWMzkzakJVamxPb1JCcXQ5dlJHYWt6?=
 =?utf-8?B?c0pPRkVzQ0RWOXlLSncrWTJ2bWVNZVBrazgyRkpoOHdLeklxM1pWbmE0NW1V?=
 =?utf-8?B?R28yUjJYdHdNZFV2SWhzQ091b00vSzhXMjlaa21VQjJ1VnlwdEJTK25oUk1P?=
 =?utf-8?B?bWpKVHpDWU40bW93d2FxejVtTkFEckZEbDZZdlp5N0NSSk9tR0lMemZlVE1D?=
 =?utf-8?B?ZkkxQXZtZDFhd0diOFdMMENUQUZHMFU2a0lLajQzS0M2ZHpYM0FYMExacEN2?=
 =?utf-8?B?eENRYjhSSDY3V052VW5BbGFCeU8vSFZJTmFmRzk3SmFoQXdwMFdoSHR3VEVL?=
 =?utf-8?B?anVuUXB5TmdqaHhzZGkrbU9TbEtnTUEvZDNBQlpJUWRvTDF3STVVMEV6MnpV?=
 =?utf-8?B?c0gxcGR2aE5zc2oxVHZQd1dENXFGMURxS3FiZWl6SjN1L1FUd3JXWWRkL0RY?=
 =?utf-8?B?MTQ0Qm11VGNaelQ1cmlSOWgvRDN4Z1V2M1p1blFWaFZPZ1lqQWRLajdBMEZj?=
 =?utf-8?B?Z0hxT3NMd2hwUyt1VjlvQWFEUnBYaWVLZllhenUzRC9rbFhrWEhZRG5RYXVH?=
 =?utf-8?B?NTljVndjdUpmOURJN3FhNm5CZFcvV1U5clNIT2ZTYnJqVnRiU1JDREtzamhU?=
 =?utf-8?B?WVNaZ1dENkdEK0pOeUpKcUFOaWp6Ui9GQVlwMDNlMWFsL3VsNFpvRnI5UXg0?=
 =?utf-8?B?RkZ6akVKUDA4MDFEVnJaLzJCaHRFZUpncHVSamk0NnZuN3JPTkcxbGNMd0d0?=
 =?utf-8?B?bzdidnM4clRmSy81dUsxMG5lSkdORXMvMHJmdjlJMDZNUFhab0hudGJkOTJz?=
 =?utf-8?B?dFErbHUyeENMdGRPSUw3TW9jNCs1Vm8ycWJjMVVaaFkzUHJSTTBReDRzUkh0?=
 =?utf-8?B?cVZnbXVJOXJabXlybnBqRWFna3daZGRWcWFwTXRUdktWYTJiKythcFU5MTVw?=
 =?utf-8?B?Ykx4M0RCcExiL2lsVVNDYWlBZEFZcEo2MlB0STVrRVNGbS9SU3dPZDdEczg3?=
 =?utf-8?B?WlZBNmZRbHo5VFdBOEZIUkZPYk5QQk84a1VUNVptS2EvZURrTk1MVVBKTEsx?=
 =?utf-8?B?SWVJN0xWTjNMZkVYUDd5OUdhT1ZweWRoVmNCT050bUhmWTVWeXk3YjU0RG5M?=
 =?utf-8?B?L3VtVWZTTGUyYmZKdzd0TExrS2pIeDdyQ256MUk5Y1hxZkpnUk9QSnJpNnRp?=
 =?utf-8?B?UHJzU1hreXplbkYvcGxPankvL0FBM3preWtNRS83YnE5eHVkVUZ4c1FjWWtV?=
 =?utf-8?B?elZxWkJ1Skkva1p3VCtlTXNhYkRKdVZJS2E3MS9Obm80K0hkWDhaWjRTVDd4?=
 =?utf-8?B?U3RDTkdrQVVrQ1hWZkFhUmdGMXBNeWljZGVteEZrd2lKRzhZeTB4dkw4eFd4?=
 =?utf-8?B?cC9KS29vc2pLVE1BZUU1Y3BjT3VMeEpiQnFjc1kxQVJHMEYvdlN4aXZ4azVQ?=
 =?utf-8?B?TEswdXVKeFVSbjR2MGVSVStVSTNCSldZTTJTRFFLVVhETld2ZGRVWTdmMTJh?=
 =?utf-8?B?amVvdnpVOGJnMlJITS9GWjc3RG92TDV3ZlV2THJWTHgwY0hZeXVRWUdtUDNF?=
 =?utf-8?B?T21FN1MwWm1uMFk0ay9IdEhNd0Vld21TRnBYQmcxK2R4aE43WkNWMm9XeE1j?=
 =?utf-8?B?RmFnd1RrRXF2Y0lFZnM5MlN6azNVaVVKZVdlU2NtMHlFU1lYU1MyS0tRQjA3?=
 =?utf-8?B?U0JjTnRBczR6WVhRWmtEaTg3WENQUDRMbVFXK25lWEF1eE9vaUZsYlhwQVFS?=
 =?utf-8?B?dzFFazEzMDY3d2ltNUhrSHdtQXV5Vy8rK1F5NVV2NkNyTFlvOVFwaUJIdTlK?=
 =?utf-8?B?cHU0ZTRUc2JBbmswbFlnWW1TcTdLTVZLRVhJaU90MjNZTzh4WkZBcWcxRURT?=
 =?utf-8?B?WTJrL29ZZ0ZQSlY2anRaQ1pMVUVoSXdIMjBWS3dDWC9HdVM0RkZNYUdHamNG?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6002ab9-5bde-4c3c-91df-08dab5e2f43c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:12:39.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UljFVLLSrf42kQ93wkN2mXp/yaLzSaKXdCm4xOfzNsbLwn/brLFiN3teIXRRdRQm1jccnwt8tBAWRA+gc2vT6QYIpzjM5dj9cfBdVzbl1fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4582
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner wrote:
> On Fri, Oct 21, 2022 at 07:11:02PM -0700, Darrick J. Wong wrote:
> > On Thu, Oct 20, 2022 at 10:17:45PM +0800, Yang, Xiao/杨 晓 wrote:
> > > In addition, I don't like your idea about the test change because it will
> > > make generic/470 become the special test for XFS. Do you know if we can fix
> > > the issue by changing the test in another way? blkdiscard -z can fix the
> > > issue because it does zero-fill rather than discard on the block device.
> > > However, blkdiscard -z will take a lot of time when the block device is
> > > large.
> > 
> > Well we /could/ just do that too, but that will suck if you have 2TB of
> > pmem. ;)
> > 
> > Maybe as an alternative path we could just create a very small
> > filesystem on the pmem and then blkdiscard -z it?
> > 
> > That said -- does persistent memory actually have a future?  Intel
> > scuttled the entire Optane product, cxl.mem sounds like expansion
> > chassis full of DRAM, and fsdax is horribly broken in 6.0 (weird kernel
> > asserts everywhere) and 6.1 (every time I run fstests now I see massive
> > data corruption).
> 
> Yup, I see the same thing. fsdax was a train wreck in 6.0 - broken
> on both ext4 and XFS. Now that I run a quick check on 6.1-rc1, I
> don't think that has changed at all - I still see lots of kernel
> warnings, data corruption and "XFS_IOC_CLONE_RANGE: Invalid
> argument" errors.
> 
> If I turn off reflink, then instead of data corruption I get kernel
> warnings like this from fsx and fsstress workloads:
> 
> [415478.558426] ------------[ cut here ]------------
> [415478.560548] WARNING: CPU: 12 PID: 1515260 at fs/dax.c:380 dax_insert_entry+0x2a5/0x320
> [415478.564028] Modules linked in:
> [415478.565488] CPU: 12 PID: 1515260 Comm: fsx Tainted: G        W 6.1.0-rc1-dgc+ #1615
> [415478.569221] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [415478.572876] RIP: 0010:dax_insert_entry+0x2a5/0x320
> [415478.574980] Code: 08 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 58 20 48 8d 53 01 e9 65 ff ff ff 48 8b 58 20 48 8d 53 01 e9 50 ff ff ff <0f> 0b e9 70 ff ff ff 31 f6 4c 89 e7 e8 da ee a7 00 eb a4 48 81 e6
> [415478.582740] RSP: 0000:ffffc90002867b70 EFLAGS: 00010002
> [415478.584730] RAX: ffffea000f0d0800 RBX: 0000000000000001 RCX: 0000000000000001
> [415478.587487] RDX: ffffea0000000000 RSI: 000000000000003a RDI: ffffea000f0d0840
> [415478.590122] RBP: 0000000000000011 R08: 0000000000000000 R09: 0000000000000000
> [415478.592380] R10: ffff888800dc9c18 R11: 0000000000000001 R12: ffffc90002867c58
> [415478.594865] R13: ffff888800dc9c18 R14: ffffc90002867e18 R15: 0000000000000000
> [415478.596983] FS:  00007fd719fa2b80(0000) GS:ffff88883ec00000(0000) knlGS:0000000000000000
> [415478.599364] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [415478.600905] CR2: 00007fd71a1ad640 CR3: 00000005cf241006 CR4: 0000000000060ee0
> [415478.602883] Call Trace:
> [415478.603598]  <TASK>
> [415478.604229]  dax_fault_iter+0x240/0x600
> [415478.605410]  dax_iomap_pte_fault+0x19c/0x3d0
> [415478.606706]  __xfs_filemap_fault+0x1dd/0x2b0
> [415478.607744]  __do_fault+0x2e/0x1d0
> [415478.608587]  __handle_mm_fault+0xcec/0x17b0
> [415478.609593]  handle_mm_fault+0xd0/0x2a0
> [415478.610517]  exc_page_fault+0x1d9/0x810
> [415478.611398]  asm_exc_page_fault+0x22/0x30
> [415478.612311] RIP: 0033:0x7fd71a04b9ba
> [415478.613168] Code: 4d 29 c1 4c 29 c2 48 3b 15 db 95 11 00 0f 87 af 00 00 00 0f 10 01 0f 10 49 f0 0f 10 51 e0 0f 10 59 d0 48 83 e9 40 48 83 ea 40 <41> 0f 29 01 41 0f 29 49 f0 41 0f 29 51 e0 41 0f 29 59 d0 49 83 e9
> [415478.617083] RSP: 002b:00007ffcf277be18 EFLAGS: 00010206
> [415478.618213] RAX: 00007fd71a1a3fc5 RBX: 0000000000000fc5 RCX: 00007fd719f5a610
> [415478.619854] RDX: 000000000000964b RSI: 00007fd719f50fd5 RDI: 00007fd71a1a3fc5
> [415478.621286] RBP: 0000000000030fc5 R08: 000000000000000e R09: 00007fd71a1ad640
> [415478.622730] R10: 0000000000000001 R11: 00007fd71a1ad64e R12: 0000000000009699
> [415478.624164] R13: 000000000000a65e R14: 00007fd71a1a3000 R15: 0000000000000001
> [415478.625600]  </TASK>
> [415478.626087] ---[ end trace 0000000000000000 ]---
> 
> Even generic/247 is generating a warning like this from xfs_io,
> which is a mmap vs DIO racer. Given that DIO doesn't exist for
> fsdax, this test turns into just a normal write() vs mmap() racer.
> 
> Given these are the same fsdax infrastructure failures that I
> reported for 6.0, it is also likely that ext4 is still throwing
> them. IOWs, whatever got broke in the 6.0 cycle wasn't fixed in the
> 6.1 cycle.
> 
> > Frankly at this point I'm tempted just to turn of fsdax support for XFS
> > for the 6.1 LTS because I don't have time to fix it.
> 
> /me shrugs
> 
> Backporting fixes (whenever they come along) is a problem for the
> LTS kernel maintainer to deal with, not the upstream maintainer.
> 
> IMO, the issue right now is that the DAX maintainers seem to have
> little interest in ensuring that the FSDAX infrastructure actually
> works correctly. If anything, they seem to want to make things
> harder for block based filesystems to use pmem devices and hence
> FSDAX. e.g. the direction of the DAX core away from block interfaces
> that filesystems need for their userspace tools to manage the
> storage.
> 
> At what point do we simply say "the experiment failed, FSDAX is
> dead" and remove it from XFS altogether?

A fair question, given the regressions made it all the way into
v6.0-final. In retrospect I made the wrong priority call to focus on dax
page reference counting these past weeks.

When I fired up the dax unit tests on v6.0-rc1 I found basic problems
with the notify failure patches that concerned me that they had never
been tested after the final version was merged [1]. Then the rest of the
development cycle was spent fixing dax reference counting [2]. That was
a longstanding wishlist item from gup and folio developers, but, as I
said, that seems the wrong priority given the lingering regressions. I
will take a look the current dax-xfstests regression backlog. That may
find a need to consider reverting the problematic commits depending on
what is still broken if the fixes are trending towards being invasive.

[1]: https://lore.kernel.org/all/166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com/

[2]: https://lore.kernel.org/all/166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com/
