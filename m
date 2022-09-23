Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D737A5E70C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 02:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIWAlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 20:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIWAlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:41:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E410809F;
        Thu, 22 Sep 2022 17:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663893676; x=1695429676;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aU4ZP06IU/1HDPOnq7u5dk0yNQ4F4YOLndy8O9xY3oc=;
  b=l+bOZwPWwz6LEYt6uBn+XX1tj45zlIB6jGu5r0zZMKtxnaNNUYHZL3dq
   sednHHatSBxSXLI5zB1xA/9bvFhlONqweJy/par8p7P7UciGDoIRcqxdf
   /RqaABPiixgN0ID7dNgecMMl+jAWnzAIpmFnJYHNVhCbyQ+Sx+q224aYw
   P6KvNJGUebyZaw3qUKxXL5lE5UPRGhuNEfQG1l71XUa2xRYRSKobgUqKD
   Tj8+V6PHFvKL6nuhD3iBkyKwABWhhvleCiQ6MnhqzCEUz5yttAUb9ptrs
   akT3H6XFrdMlSkpKzu3s9ABI/K0sM6eh6m6j/BZ647I9I+8zrngcviOhS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283566758"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283566758"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:41:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="620023837"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2022 17:41:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 17:41:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 17:41:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 17:41:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 17:41:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPYPHEyw4hm9id5Begv4GlnfRugV+89SLIUD7q7+DWiVLTLTXrx/zAxUpU+gamtFXqsMnoBv2x8cV9Stqhctp8+Tz1HSztbrVnKpuGNtm+RZBbYyV1mOZ9f9I6w2EKfDNMsg6ZXXfjD28iAoqL5JMqp36MbTt3J38cUgQunIuLcJkNhQ53qZ/fwxmLA+g4uIXewuZJ05F4pMZtNoft14HaQSvPjUDw94sM9jRpJk0pQV3YHVr+k1yBB+qA/ZKiRgE8UZPxDwDv5aO0yaZx6Fxswz+CdJ/WzUBwvbiiJOB0RjlIphu/8Oq25QJNYbRViAMTeZNVTRPB7ITdL/2ejFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XflN0Hp/URuVhTKrxjinxniEL3BoWmH0T0hpjdDAjfs=;
 b=f0yYmt3+FC1X9wbjFi4mCfLVNZo3W6vdRvB6xJ2Bqd946HJtXliJQOWOWy0OShal3pzUE0TJafkMbQ9sAFyUTOEGh4c26Exq9ZFL0wonQdASFc7kXyAfs3MnG/kGo4DE3G9/FEkP52p85h4opAZc4Rsq52p2cZvtDbvzZAh/3XBpzJfkm2YDu5idv7IwdGENrESq8/BXkET9XS7dxC0Y/x0PHPcQbEx6SgR4NXKeqAJR7ccxj12Xx1B6w2k0siF4rWHE409wnWS2UY5CyXJyCgF4VhUENcW21UpCmJn+98OZB3t0HvaH2UPAyZhVU5giiwaLgDXELe+yNJCrszemcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS0PR11MB6472.namprd11.prod.outlook.com
 (2603:10b6:8:c0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 23 Sep
 2022 00:41:12 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Fri, 23 Sep 2022
 00:41:12 +0000
Date:   Thu, 22 Sep 2022 17:41:08 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220923001846.GX3600936@dread.disaster.area>
X-ClientProxiedBy: BYAPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:a03:117::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fbaecb-b50e-4f22-85f4-08da9cfc505d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRXX+3AljMLjs7O9HHZrEXcnjFtWw4+QmIDcLarlRM9YxlT1NojOuzTjgqLxXA53WToxpfbbUJA+RjP6JdFizeO3VgTVDUKKxWuvBbve6WjQHBEaj01lDQ5baaTryESucPWblcu/xOkk5z9uMH3jwde0BLmADuTc/JEonR35D47byMBVzZ+KdAyJfVs45KzXfolAHqbnv/aPPxnap24b8uYgT/VNgJzsuMOXR7cpVvAeZvi3psyqe6el4LWTdSWqDmwnOpYBxVfj+5jwYdmxFII3stpXwubrxVsHJtYkcNqLHxg0aFX9jtupjBeDH1T4K3RiqR2oNoD1DW1XI7IGKJsTFh201Z/vs/ylsrv9JTVIGRGQxEfR55ZQrjgrq+kwMoc8y9uQO6S90p6CNK4k9wuEtDzFmWtPZ/zT75griw9szS0wTO5xotU3MGy1rNwH7ldQdOv6WeqJRtPGXG9YukdL6Pk+IrYdXXSX73qoRXj+zx42Mh0Aph+Om/XqS5AsESGNFen7dwWrUU0PT5JEz06v+kKhR8O7a2kr2ez0rdXb7tz8udSHfC1jttFB71uYthRDIdI4A5VfK2Ux9wdzK5x7ZSNqGCS3QgHx56ebhUqmibRoAto7z46648EDo0UNpsjFhxykmQOXEdViNLKyjBkyoxocfcFglx2pA2NYzOPtSKmzFKbxxpct6IhDKcP7Kk2KwKe1lQyoTF00bcx+/GBPd6APzbSw7kv8it8rWXAwLKjJzIrW3Y6pex6XeTqd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(966005)(66946007)(38100700002)(8936002)(8676002)(66476007)(4326008)(82960400001)(478600001)(26005)(5660300002)(41300700001)(7416002)(6666004)(9686003)(186003)(6506007)(316002)(110136005)(54906003)(6512007)(2906002)(6486002)(66556008)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8KJho5nTh6dtabWTn7bMg8ms0+FxM4pRWPlxz5vEf+3U0R3YRtJS7EGuHwYl?=
 =?us-ascii?Q?5f5SrC04lihJmq8pMTxD/Uj2GoXv6suYk326SLAJeRk4E2L1Fz92iaP83u0r?=
 =?us-ascii?Q?4P+nqJeidgwwKRZyP8a8n945s8FpslQN91v7UQ95WsPpSsvWcpkoqzcGWlB7?=
 =?us-ascii?Q?P4sh/1EqB5PNMWXThCoTR7dhleFNYBQGs2fUnEf2NmYKBbCCpkeR4sKb0tJR?=
 =?us-ascii?Q?O4TQW1V1cRUHFBRF0/LK0DcZfy074BNaknbnpSuKvajzG31QDSncJcOJP/tc?=
 =?us-ascii?Q?ASTDsGnUixyUQelK2i66rnXnM3vhwCsSTQwEF/HNltTs9lZ5akTtdSoGPUeP?=
 =?us-ascii?Q?7RN86mFdXuxTz8q6JFgmJ75yrBrexahXL3iK+QtAg5ZaeMCNPF+Ey+oYXS96?=
 =?us-ascii?Q?96+8qJZBy7dLgTOcHJInxMuBduKE9fuvrO/Jx9bkRg3yXM6XRjeFgE0Um65p?=
 =?us-ascii?Q?vcNPraT/uRdWkvVWMzFbuky5ZcL/lJZ6S4MEdyg+DXxJmoNJvufVaypldVNj?=
 =?us-ascii?Q?UiHaQ6LnVli/0fCId2UtSzc+D2P5aGTeJfq4hTWrJoqBxleEJDV8oIk2Kpw9?=
 =?us-ascii?Q?2nf6HVmjJNe8q6QoS4Mtx52ioAczBDvJaQK1nnbziEoRJ0AI+fZoWLQ8/dhh?=
 =?us-ascii?Q?aZ5ymrUtfXyrgXEnozGgjDUYWTLMWrO916b7QiCKgvb+SaBLNTy2FVdrbSHa?=
 =?us-ascii?Q?/VdOx9x9NrNYY8yT40+F78y/mR5UcMHPuTXdZkafEYYu1IVLfVXiE7WCJZ11?=
 =?us-ascii?Q?7iyTCBjDw79xwBNBhFEAdl8Kj7bJzO8ZSRiaJQcVYdixAOE7zrYSMmHkRD/w?=
 =?us-ascii?Q?HJbHULcV6/OCvR06sBslGYuEZ3phDZDsf7s3/MbHLOk5hUa/vRkgkiPrGX5e?=
 =?us-ascii?Q?23YrTOxxk6vIpdRSQx/Q+VZaKGFRPGEkO5ShFEhWf9llUN0wp3K38RS3TmG2?=
 =?us-ascii?Q?shOWjx1RQJuSVo92Qwy5f1LG09V55DgNNiCvwWbfCuMCi20eES0Tgoj/642x?=
 =?us-ascii?Q?0Uy6MeE6OYoUg0fFTKL4NUgAa2EvZRHCnc5eiNshTdAmhjdZv4LjKat1rnEU?=
 =?us-ascii?Q?3tPsbrloCCKcFun6zyA/UnYHdWRvOxF75RnVK1xrj8w21soREBUOdR6Y7Gj4?=
 =?us-ascii?Q?0I61U5vs0ipvXkXtBmwE0fYujXIRU8WUVtMLusAZFII48PYmex+7RQVxkNnr?=
 =?us-ascii?Q?ef37Ks6JarpPhE6gk3zB6ZQXlX3XZMYt2oD8mV1/UkCzKGeE8kohdjUadk2O?=
 =?us-ascii?Q?jkhgnQ5Nbpa3eufjOVF4u0Wig4a8jYqF66l0aJkNSdLA/l6kKnLdCSnna2cG?=
 =?us-ascii?Q?uM7WYaUtFau7imu//97IA6YdTgt7MdxlTGjNzMRDwBgsngGKRFQkCew1Bh82?=
 =?us-ascii?Q?pEJNYB6rIcoRRG7K10YBvU4hjFIk7kq8z79eXedIAJnRdEJASwUJdS9NV2xs?=
 =?us-ascii?Q?WdNHnr/9xj1uiK6F063MFKpZdeYyFiOI4i5wNR8yxYY1nOaN3ZcgRV5ND4nB?=
 =?us-ascii?Q?OZk1q1fSEsWSWXRCF4s9EwlChT5Cinxde/0GDTjXYI2JJpqLR2U4XEqT9ZRM?=
 =?us-ascii?Q?5BV0FStyle6wLDTlZYRdA4XIHKqME6Hu4vB2X00JtQAtOHjW+01VZIGZmtw2?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fbaecb-b50e-4f22-85f4-08da9cfc505d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 00:41:12.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: as8ido6b9zpye3yWOM1vHEkLAylK2NQG7fvmweuK+V0UiePHB0+rH33waX2ofEP/OS5KWppu+UbPKkjXsjBHLK/3GbRiy/kMGLwd0V2/vr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner wrote:
> On Wed, Sep 21, 2022 at 07:28:51PM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 22, 2022 at 08:14:16AM +1000, Dave Chinner wrote:
> > 
> > > Where are these DAX page pins that don't require the pin holder to
> > > also hold active references to the filesystem objects coming from?
> > 
> > O_DIRECT and things like it.
> 
> O_DIRECT IO to a file holds a reference to a struct file which holds
> an active reference to the struct inode. Hence you can't reclaim an
> inode while an O_DIRECT IO is in progress to it. 
> 
> Similarly, file-backed pages pinned from user vmas have the inode
> pinned by the VMA having a reference to the struct file passed to
> them when they are instantiated. Hence anything using mmap() to pin
> file-backed pages (i.e. applications using FSDAX access from
> userspace) should also have a reference to the inode that prevents
> the inode from being reclaimed.
> 
> So I'm at a loss to understand what "things like it" might actually
> mean. Can you actually describe a situation where we actually permit
> (even temporarily) these use-after-free scenarios?

Jason mentioned a scenario here:

https://lore.kernel.org/all/YyuoE8BgImRXVkkO@nvidia.com/

Multi-thread process where thread1 does open(O_DIRECT)+mmap()+read() and
thread2 does memunmap()+close() while the read() is inflight.

Sounds plausible to me, but I have not tried to trigger it with a focus
test.
