Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D825E7AFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiIWMj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 08:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiIWMjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:39:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6D113F18;
        Fri, 23 Sep 2022 05:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdWXj9r1FnWBNJ2G2MYBY1d8sXNybERBau5qQMJXrPIL3Yv1NQ9eQOaia9+nH7nSvekZebE2KZ3JSmw6kRYOA+JWScy5+mKkpVAK/Z7dZRA+CxoHWC4s+9bmAJcwd6vOACSRvbLt+xZAsYDEnQpybRYAHoNlGTm+alDG9xWghpY9Zh84r6PHHvp0SNGXgACtOihG4qxZJ6cU7WzqZ2RIS12o6rS4o1o0P307OPXP3ii5bJvf6D1gdajCm5YdYGfdmFmyxtcyA4fb2CU3Ge8vrl4jY+b4X02/FmHKHYSCK5y6HZ3YCiBSPS1Bgw/8PFRlOe8NtiyBodSzpZtH6/a2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TgOC+/PwU0TA/x2GdR45VOe/wXJQe7SoKmotRJl7tU=;
 b=aJwEC5xmZ6MXBLuajvqi8iJrH7kYvm9XJj6VBkrWSWp0lQdYRaGk5npGLoyI7jv+a/oIDpgw722sWM9w8KkrlO3a5bmtUFCxo0BnLw5UsqCHD8LC2Ih+kowvlogkxm4Kw2i/c45Bj0zlc1E39fOAyD97eMP++v8zQ9WP9Cq62JAdLKwygEqT3xsVzeAyrqVaX2N+82bIUrRh1ZZ8Te/VXYtPfKA+l+Inu0llAUnxo5fMOdWMOkZ/dn9xBtVzllSEiUIlfX/pSHYBqLvrKuw4j1maVICOTC2wRlB/OZFCJDmOG9jfRw6vQgpBZRmL8TX9yP0H2p0Lk0oXutSGaVINDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TgOC+/PwU0TA/x2GdR45VOe/wXJQe7SoKmotRJl7tU=;
 b=TJCa5uqrAYJdUVv5n9RoyBCOB2qwtBUYFDJcp9u2w/WisBm6/o+jlp2Kpx8zpib5s/o5xwUNpQ/RHY5ycf44jXIDbYiBoTHAG9/GWxrCfZAA/5OwqRACw9JkeT1fwiLerJcpRPwwYhBfWL+4K9gOGrWpjItKLGC9ruBEMMLRixQhKX52cEUxAPCOq2FYWHiQjFsX8lQzcc8seBZMgsqEe7Zggy31ewRbnYzAOlvJc1vWxhRcYVSwS8Dg1Xakx0i7c6DTzd3byrWHVAXUD/IFDSqM9JzIDedI2HgZp5Zj/kpVgym6MryQv3WSVzy1a5ZZNwfDf/gdfDY5cIF+7sTfqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Fri, 23 Sep
 2022 12:39:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 12:39:46 +0000
Date:   Fri, 23 Sep 2022 09:39:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <Yy2pC/upZNEkVmc5@nvidia.com>
References: <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923021012.GZ3600936@dread.disaster.area>
X-ClientProxiedBy: BL1PR13CA0446.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6690a8-e45d-4ee6-67c7-08da9d60b279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtyqKfE27USt9r3a59Hkt8C2ZrlQotnhLVdrgiMDklW73Lvw/biuh4MErBFQ1bJoVCpj/lE8FhYFiKdKVYRJTaFfHiOlJ81qqXPMV2/47DSS0X1KO4/uITK8lu2MERseoJ/6lQbMhjoqIEJsxpOogAqcQ14V+wldjEDbWCn73OE9pOJCLY+oWaO5Yc4EZRqeaLju1PXzQ1JFCkqp284K86n8NXfFDsKypuSOxnXnlSGu+OJmsSzc8RpQ7/+1tFa+Zhy+1Hl8FEXl4ybmF0z/4o+ZUeOmELXO9hW22N6Y5Jv20Dc6r07iJg9+9v18V20YE9zNeXXLuRE++ed8Lbv/qFfk5p+oUBh4OQV8F/xJOLUBSWXhUHq7ngCNHUGqJ6kA13PINRRa82T/jW5Wo8phIQBWH4BECmFqOFh3A+PcYCXbgICzW8DOtd4evfEl7GEQPulLKoegYqke9YI0uKq6OXc8VKuo1V7EkpaSCnb75XLuWd0dNCusxELvbv2nzFmC8fZ0NxQO2XdmXvaSVat0h0HQZa4ng3xi4r6FFHWRRm2gDo0na2J2qLWwDojUU01g/ipHE2+6Z884S6TOeuzHBMC1iJlOoZgiU9i1TdcWKanw1WddTQuh61Otp15tES8swu5qlHmXO+g8DvXAK/I50mFPsis7MkYAfM90bKjHdVq/Ji6bCG2tKS/frYAAlgPXZf5JSNo1xow6J41hb496afU/WXH/jy/mPHmB7T1zWTJyCNd4IXCUvgl947SqnFgClAmGOWKx8/OGNE1VEa409kKHTgztBeacJoaieMS3VSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199015)(2906002)(38100700002)(6512007)(6506007)(26005)(6666004)(4326008)(2616005)(6916009)(54906003)(316002)(86362001)(66476007)(41300700001)(478600001)(5660300002)(8936002)(966005)(8676002)(7416002)(66556008)(186003)(6486002)(83380400001)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?35fN8T/k5Y3o5sq7mvnk0dP1iGGnEhPPPWVB8/NMM+d/EFC4f5ZLgfcsy/U1?=
 =?us-ascii?Q?VtGuAgVyIvnDHjrxRWiNpPFr8S9FIxt0uPJhl51qAC2jzZvuvQ+Y7HSVaLAV?=
 =?us-ascii?Q?ypbJpFpU3GsHxNm8SZG6qtZY2jgbvAhYRhuCjTw3sOKkZfjw+Hpq043Woy7T?=
 =?us-ascii?Q?HRdqq/ooeG4zlgXsVqreVJmCeuH2+8OiM8ZtaeMNfxPdkCTVU300T8VKN40s?=
 =?us-ascii?Q?Wvr6NtbeDQLfU7mXW6L2gXM/lIq5b6a0obprb/59mq9ABN+BO9ezHlzXPPuc?=
 =?us-ascii?Q?8mG4JDRQU2k0rEMskeFKU8UFHmMFKpbhSAxFHe9kYXta8Sht/OeNWmsGoVtM?=
 =?us-ascii?Q?O+Oc6J/KRHaXN1j/hksRG66PpmT3SY/5c7RufA0YIsTuO8kLiDXdvVzWUHDD?=
 =?us-ascii?Q?YkiWeB0wNkprTxr0B8S+BTHQKwubweesvA2YDhlvbUmGYzZZCk1xAffRjjV8?=
 =?us-ascii?Q?HviDNH3hXYXvqznk+2y/aA6XsgxYeM4fiX1XskDOJ4edYPZq5jBtibcCF70C?=
 =?us-ascii?Q?SRDK1uCPh3/KSQa1ltkcUYVQFk9EImkZGOp/0XIzLuF5gVQ5ki9WLJNyRrYc?=
 =?us-ascii?Q?YUvQrwRNuj1w6QVDZXv9IetdDzbWaOQaBIx1PpZ+JSjAnqJsoazKUYDsCVre?=
 =?us-ascii?Q?RVbl0CpU34EmJ6Av5ZU0mHBAa1qr4xhMz+XLyFx8cvqgbm/priREpeGJ93IR?=
 =?us-ascii?Q?LLiI3p9kVtnJeEKCbYCStjk174IZ2p/NuyIX1Bj1ZhbodNWBACf96OxjYopk?=
 =?us-ascii?Q?gzfNUnER9/nXi/6L1HBSVZ9VyhiMPVb6G4J+yQyrWTo0vajtq3Ny0yjScgu7?=
 =?us-ascii?Q?pDNMyiIYWFFDcx0KkWbEG1w9I1HwOi76Iq3m1kDnxAvZpThQYdvUjIkDiuEK?=
 =?us-ascii?Q?w9xjBVWoVEz0Drg5lxNdFNK23+25GAE0bI1fUjjENibJ/WKkqEeTqZt4oetP?=
 =?us-ascii?Q?74xI/aLacHbDTmJ1dxt7TdoQzU0iuK6Nxrt8PJEb7bugK79iAZbv8LRJIrVu?=
 =?us-ascii?Q?+p8mJ1Y9cgYTV5Fep9RuldR7+tOyygxN7ogP+8YsFM9PQh/SsTnj6TBEOyj3?=
 =?us-ascii?Q?z8MwMXFC9ewNzNfcAWqxHd/x8+8wPqH/NB28Chnmmm1O1yb9CltjdlLP2Bdk?=
 =?us-ascii?Q?I/5eK22My6BAE2K2R71J9DdwIRjlKhhs3+ykASMSfhktPebyEYb5Km0AJ6xf?=
 =?us-ascii?Q?IBAlAJQTa5mIu5uIInVAGoO1lwXziJWwClflknLw2l+sBaa5J/6DG3/s0CMC?=
 =?us-ascii?Q?/AYHdRzRP0MI9k96BtRtC/CREJ3DD7RotPNqmHxofRji/iYM498KAAZOEbbs?=
 =?us-ascii?Q?BtVJfDlXPQHNa5IWEB5CexgJ1cqt0vbHxpoklrrWgtLUggutvO8DRwM4qfmx?=
 =?us-ascii?Q?fpsubyArVgZrMU43Dy5mg9JGk1hSm2O3ghAdR6g8yikUy3pLy99m4Y1Fu2Ox?=
 =?us-ascii?Q?5edbKbr6pmFBni8VbAnojIXppeIRnpSqJCncimgAhp11pOBFWxJCE2mJMApv?=
 =?us-ascii?Q?dAMOQmPUJ9qrI2FKzKgdTcHHbN09iOs9epwwKFOGJKk/C1EkkD3RRdMyK9ZC?=
 =?us-ascii?Q?2833AszuUro2NRGDqy/xPFnKqNedArIOntl20Yi1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6690a8-e45d-4ee6-67c7-08da9d60b279
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 12:39:46.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90q0ZUzVI3GS7GaB7BSUrqvZUR7OMJ0qqyEnsKp2DsX8oZ6Dqji3SnBZOzhH0fgm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:10:12PM +1000, Dave Chinner wrote:

> > Jason mentioned a scenario here:
> > 
> > https://lore.kernel.org/all/YyuoE8BgImRXVkkO@nvidia.com/
> > 
> > Multi-thread process where thread1 does open(O_DIRECT)+mmap()+read() and
> > thread2 does memunmap()+close() while the read() is inflight.
> 
> And, ah, what production application does this and expects to be
> able to process the result of the read() operation without getting a
> SEGV?

The read() will do GUP and get a pined page, next the memunmap()/close
will release the inode the VMA was holding open. The read() FD is NOT
a DAX FD.

We are now UAFing the DAX storage. There is no SEGV.

It is not about sane applications, it is about kernel security against
hostile userspace.

> i.e. The underlying problem here is that memunmap() frees the VMA
> while there are still active task-based references to the pages in
> that VMA. IOWs, the VMA should not be torn down until the O_DIRECT
> read has released all the references to the pages mapped into the
> task address space.

This is Jan's suggestion, I think we are still far from being able to
do that for O_DIRECT paths.

Even if you fix the close() this way, doesn't truncate still have the
same problem?

At the end of the day the rule is a DAX page must not be re-used until
its refcount is 0. At some point the FS should wait for.

Jason
