Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91345E560C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 00:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIUWHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 18:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIUWHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:07:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002E6A0241;
        Wed, 21 Sep 2022 15:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCyZ9YgGpUlN1JYELMBvrSiABD964kctwYRV7VNjdN+O5NTP/P3xCL0gKVWnFCuOAgLDIyK6AKx4jb47efz5eqtSO2x17blNYelyM8DtU6jTaWhQBR6fXokyofC974QLL7Sa8KRfo/SAf+yS/LmWfKLsbZEwpiap5Mcm20HOKdgGXUXkhZMw8/hJ0MNrK4AGDJTV83baRcgGZTHJ9d7u7pbxUXDr/HCMlcfKS8Xx+SjqM8x9pu1yQfzZRficHs3TUMoPMPmjywj7e824nH0Br1iQVukIqXPeM6Jmx4JMqADOuhExdhP0SvnzgUbf4eLThZ4lkYZZb1pmFJME/ggVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVOJS//aiGkg4y9NQlE62b7ZX+vOg3EvNXdwhy58ZVw=;
 b=WQCabIWLLXu8Ra6HdzeeqS8dfLuBpJ1w0EfSMTU4dBU/tyqmBRDtzKTSC2bn+V1NmsIJMZO1vH7r0r8t7AYQcB9MmntxQhZjZfg7YwcYVYMUkdZYq4Luj3v/MhANV+7E/dYv99uccH5k/mMtYZkFrvLBOkv/ZNb10UaI2gkhGP02QJihSbZ+mPrt7h1s40/3odeFHNrQWginV1gVblAKjLIoz2tICzWIpocSfME2QVbXLUDkkxd87DvnA6IxitR90ky5UdCm+/dVkQ1hvhqgvGSAXJYIxLo3DxLaIB5+wHyzHDtKD2skHARvtHzL0IHubdvpvIj3fHxUuYOVVMvZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVOJS//aiGkg4y9NQlE62b7ZX+vOg3EvNXdwhy58ZVw=;
 b=l/vuaXiBsH2/qydFB0oY+NClkWK2Wdbkmwi5auCmOBY84Nj3L7ccw3xoVsGzi6AzdtLDZmuBb3rFvrReRyYrsRLyF4fIsF7vackCc2Oc4tqOSsKyXcsgSWKZF2k/8ZGSIWwd5O70CVkivpu0ddLgkB/wfjVw6TdsajQSleA9WC9HAv35qX4lbrMTiIaeLZnuqG0n3I0wCeD5JBq+hxELVVS3lNcJ+Aid8pVb88bT3oiGKhLFKjhuHsqkcdbxVm8UoLTFxhH+sgZKOf7jAGtSf2HAWjO95Pohse8pmL+6kguLaV1A65hbY/LS9Mi3Bp5hL0s3WPBASBdipfcCSjIGEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 22:07:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 22:07:44 +0000
Date:   Wed, 21 Sep 2022 19:07:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <YyuLLsindwo0prz4@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
 <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 510ee144-a869-409f-8203-08da9c1db527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xktZEL3+qjhXzntPWJHoUx6kIwB5sGLcMPU++zMtHNUXXsa7c7dpPDNTN76B706gyCQ9mT6Qqx0mrmV4dHpS5jw0LVfiweCX5GjpfeVuPzq8NIQGfD3JKFw8UHzKv18fvgA7AIDgFoqKUG/1HqIW9RiCR0CAB2gckrH8z19mn3vfAvMVUo9hvF9nsiXmCc1uygEmivRaRtiwgH2R+u9S4hdqNmMBU2HO+Je7KC5cyh6xztmFdT+mgW2CUHnqaUE/jWMxnRoQW9Dvn2IEmV7kAAPrpsKLvHOYiYLprtfD8U44cVwtSH5hpJ/AY0soavMEwZMf++I0ufw3QHfo/l84DNYLBQEkPJVEjpVDqi8ELxCbAd8vPJmbenLXnnLniz558JZPLcOUvVoEYdhk0aydxaDfpN6e4h1GQCpCbpeUgT9UUhdf7TDjbSCNn1wQTs3g4ULl+rJCfYOy75QgkxUcDOX7KyrssN2UYUr/w40ws0Xz1Q51QH5FwuKo6G9zbXmmkjMrH7lxABTP2oUcdyk6WY65OOcXELW/TKWL7RYya4CwX42p9vGqG6RmgIS+UiRHHiWTkkvEi9vcgvTp/oTMGTbCregZ3b8Hg4cQ6D07G+nQcw0Fk0WS33OHRhAj39pIpK6ldJs+Bbl4PqWz2VRJfBhGRHLhZl8j+X60metRkdoTe1eyBnQa08LsuFqwO5zlYVQGfp1HLNjkAcTX/8q0zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(66556008)(66946007)(186003)(66476007)(2616005)(4326008)(5660300002)(7416002)(316002)(6916009)(83380400001)(8676002)(8936002)(86362001)(41300700001)(478600001)(38100700002)(6486002)(2906002)(54906003)(36756003)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iKpRWZu5F0LSgFKZITcMNmEsHulkHkwDryKeLeBKupgXcekg123Cu3rszRc?=
 =?us-ascii?Q?Z3JcjDvvlk6y4woQL26WQOhHuw2fbsdwDBX1NeJ05TQ5Hl4KvXeCuJ++5dtm?=
 =?us-ascii?Q?/XONT/726wdIlhUCUndIR9UoVigkpFDAgFnpFichLmn86O2jNXqQzNYzrU84?=
 =?us-ascii?Q?V+Mm3H68xvI+nr04v8sqpvdNJ7NQPgd1o9HG0YSHvQp7DIeutpHovi8YJMfE?=
 =?us-ascii?Q?vB9ofIOU4PCkrall+PGAx0FYNkngoTnpqIZv41IXexGBRnEyQ7kEKfl2ZsVD?=
 =?us-ascii?Q?X/5MgqwKhoWL8Vv5hVWmH0DCyUO1FUiTCIz94xzwgKqzITb4r43bNZiKM3MH?=
 =?us-ascii?Q?K41SaYPy57rC9tOJztdRqt/InXj1nkFxI8beSa5FHh2m4RSajrysSQEwIdbk?=
 =?us-ascii?Q?Kos0DAytSW7hF0/9P6hKlKjNi238uK6Sgunrk3P2eGXP8lVNRDWhIJmgTQRe?=
 =?us-ascii?Q?7kM8SHBn4EFTMUc56mFiEd66o3RfqL+t7fkbsgjm9NJpM+sEP3r4QtlPxtjf?=
 =?us-ascii?Q?HZ4g6LZkBVrcp7HL7j3/ozwkma8jWZndKdPPDfo6Kd0TVnNhqDcOPIiQkHcR?=
 =?us-ascii?Q?FMv5jgife45AprAcIAl/hLAuJHuplx8AChm3uP9M1wy1oTMghXJGx01jfPLO?=
 =?us-ascii?Q?pojyE15ilZ24eq5h5YgDB12JVrTDjWsHyajRfByYgavqnYDL8J2z3JqdQrum?=
 =?us-ascii?Q?qJn0t2oaM3k3KfQSdpa/dmHEcV7NZiPlOoYQzrL9cEcjNmbpKAbbOlkLtw5i?=
 =?us-ascii?Q?qVfYED7i3KOWsyPbA9jKoeZSGNTcHp9VlR5niPUrklOPSs31psKrQ0Q5F77P?=
 =?us-ascii?Q?QZEGRMuy2cb6mw7ndccN8ZuH436kN5q69+JAqyZcHMIdzisaB5jUGMSoTQ3y?=
 =?us-ascii?Q?iXHvH811zVPw3164OkK5twBLpEcGlBUMWa4LRTOkuTC1oNc5xklqDs6KmpkF?=
 =?us-ascii?Q?0+jU1WVlk4hU/M01r5zFhY6f5BYRdMAAroCGIGx8eYtSO2dpyEbxXj3OciQZ?=
 =?us-ascii?Q?fNMSrLDPVHFT6/zwmcwlcI4udjE1yUc5vOJGwU4DNz+fW8jE4aLPCv8t7g+w?=
 =?us-ascii?Q?gIQzGjRxhhnjRBekrF36p55HQDt3xoXIXcyo2/9PTMC691oVMXCkxN7fObzI?=
 =?us-ascii?Q?+WUXHmdpauAxM6lkwwCoa5GTbMxKsUnupt1Sc09wpmpxxABIZ/VS1fRoD+xX?=
 =?us-ascii?Q?1r+fSB094nM9Hw5B36jBI0x4qsINC+1OThE+XYjT7YGfCEKTnWWu0K8/y3l9?=
 =?us-ascii?Q?8MpHSSS3q3MAdIidZXUrkhUiIqCy/MVXe8MJhwGEDetZZWo71zhI/FuiKzIM?=
 =?us-ascii?Q?3WArsEILThfofbfYcCyO+CtDiPIStOeGjbTF3KQZKLp+Ip1Ou/tsBFlUwah8?=
 =?us-ascii?Q?T0B7IrsABkMT1G1VRq4Fp1o9ZIsQ6npDVYVYM4yMiKAvwzxuOycSJAt/+UON?=
 =?us-ascii?Q?GjZD7QrhYYSHZMmK8vdICJQnys6pOZLrlYMTYg79IZZ8/UVOojcJwB2WsX5h?=
 =?us-ascii?Q?Al1OrjpFNFSaPYSiml1mNzSfUi2/tqLR6+MkQRakTmArISSOaQS3yE2S9lGf?=
 =?us-ascii?Q?Hb2aGMqDUOSejshXVIS7+4fCMFRQupBWijlRz7AN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510ee144-a869-409f-8203-08da9c1db527
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 22:07:44.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikAD7mAdOet/69i+l/M+b+TpmYWFpBKY3MDS12PVJqhLVKe0zNlQvbfeYRaSJeD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 02:38:56PM -0700, Dan Williams wrote:
> Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > > On Thu, Sep 15, 2022 at 08:36:07PM -0700, Dan Williams wrote:
> > > > The percpu_ref in 'struct dev_pagemap' is used to coordinate active
> > > > mappings of device-memory with the device-removal / unbind path. It
> > > > enables the semantic that initiating device-removal (or
> > > > device-driver-unbind) blocks new mapping and DMA attempts, and waits for
> > > > mapping revocation or inflight DMA to complete.
> > > 
> > > This seems strange to me
> > > 
> > > The pagemap should be ref'd as long as the filesystem is mounted over
> > > the dax. The ref should be incrd when the filesystem is mounted and
> > > decrd when it is unmounted.
> > > 
> > > When the filesystem unmounts it should zap all the mappings (actually
> > > I don't think you can even unmount a filesystem while mappings are
> > > open) and wait for all page references to go to zero, then put the
> > > final pagemap back.
> > > 
> > > The rule is nothing can touch page->pgmap while page->refcount == 0,
> > > and if page->refcount != 0 then page->pgmap must be valid, without any
> > > refcounting on the page map itself.
> > > 
> > > So, why do we need pgmap refcounting all over the place? It seems like
> > > it only existed before because of the abuse of the page->refcount?
> > 
> > Recall that this percpu_ref is mirroring the same function as
> > blk_queue_enter() whereby every new request is checking to make sure the
> > device is still alive, or whether it has started exiting.
> > 
> > So pgmap 'live' reference taking in fs/dax.c allows the core to start
> > failing fault requests once device teardown has started. It is a 'block
> > new, and drain old' semantic.

It is weird this email never arrived for me..

I think that is all fine, but it would be much more logically
expressed as a simple 'is pgmap alive' call before doing a new mapping
than mucking with the refcount logic. Such a test could simply
READ_ONCE a bool value in the pgmap struct.

Indeed, you could reasonably put such a liveness test at the moment
every driver takes a 0 refcount struct page and turns it into a 1
refcount struct page.

Jason
