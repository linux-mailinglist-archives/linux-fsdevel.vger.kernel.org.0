Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884B85EA8C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiIZOnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiIZOmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:42:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED395E094;
        Mon, 26 Sep 2022 06:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoC7HkvJ0exoTiJcXbr2+ElQzVNusEehjar/yhtdelC9JCoqTt+o4O6SsDg5MK2f9tdRm8V4rhs1ViInJz/9Dss6979AIirM8g3QavOiaI6s8CPm9bKcxaeCMhKyZFaSvZs7rhoYayd/p2zWL9MpPTvZ0D7AzTjJwNvZAjZjts+hK3fkWTzU5ORO1S54b/14Yi24ZMur6qgNeRPeRw2Z9OS2jA60sustZyryejYpxd+cqkXQR6h8sAO7tMiVD9xqlHYk872lrEnOha8LhGtc7EoRBt5KviquIxTCvwTLrX4poC8AdECkCHNq/OJvqEjlA+CbDQab9Eh5QmMFH8DXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jByy82CZvmD3fQwIONP/yYPDjOSS094TCQc9FI6DTkk=;
 b=bysbuFoVKbY/nMpzIvChJvoGTghAM4Sp4bGy4uMyL2sJuQDxw8PEtrvDFc8iwsxyhOpnEyE28WJtn7OtMB+bDL9EgaOfsGZZWX4Etu5O9sKEA1jdjDtxBj32cY+sLpO3m3xUbxl7vPnuZOVYa/Tm+zsVE32AKbLQfyeFdRn9ZKtPcmLP0HPiIkN5q6335kUrsGjgCKp2q82GdsmI7DZza1L4A7CQrVN/5dbF3TkvpAUJC06rX7Gbwq66iJVpSfBauBvuOsZmP2wENHWqYjyBMlG5rf/N7OQSW9kxslJMuLMIe0wNR/Kq4AQhtgNZsD0OBMFkBEamnJLoov8vLs2iOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jByy82CZvmD3fQwIONP/yYPDjOSS094TCQc9FI6DTkk=;
 b=bnrOd1MXrauda92TNBci2VK04NSTM6+HanwMhOypQ+BnnR4+NJx/SUSIu02ykPdbw8ZtdDVdJDgeyUG2cjEqLNC0A5EnTdts6ouGJdxt7GBq6L+kp3xFfGjrWgIxVy6QeJ8wLphapjfk08Ry/PTF+GJJofv5621QXIt18LeY52tQVOUyijR8cA3C+nuKq3nf1KV4oMnaxPBnrtbxqEJQDvwA1/ShJcX/8s7mVvwQhgOj0KCwh2bZPwtXJfcArM8qITxKc6NWh304NnFpcB1DtZkk0P02G5987LQrYeA6YuN90kiendCWKDndbLSAHNuEzhiGpfSOMTUs3IB7tPtQyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 13:04:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 13:04:34 +0000
Date:   Mon, 26 Sep 2022 10:04:33 -0300
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
Message-ID: <YzGjYZGFBBWBfUbK@nvidia.com>
References: <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <Yy2pC/upZNEkVmc5@nvidia.com>
 <20220926003430.GB3600936@dread.disaster.area>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926003430.GB3600936@dread.disaster.area>
X-ClientProxiedBy: BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH2PR12MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f66eb4-808a-4fc0-41be-08da9fbfa8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cPyffG5EPmGUMIbiisGHk79xQ05ur+1RUgaakC9MZ8ZggOVS9+PHQP3K6M8baWvNlxKw8v70NRZOdIUIRSYgLqTGsbLrVXS7xSyRUzSoQ1ArdC1r8oR1Vu8UznnChS+GA8JRUFA+nypxdSfKUZYOMI+hubSAycrcGh2djxoKnARsi+jpWkH6OpVd9qYeV0SLCP8BfAzm7EdLeHvSquU3qzlcqLD3VxKtMYL7d4KShK1qnMI3y/G/HSUb7Mt8oE7yYHg/cTBhjrd5NN/tAHonQbjTLWb/UvBWPPsZWZZU1zNSgYl2CXRipHIvFPuxgczS6JxJsmMeI2+IslQJvVkNr357rCZGIPvF66STwRgzCcUMG59jL2UyWYWmZ6M/coYNWw5QxlQHCpAExZiHzV0LROfOKVdQ6Zg1w5UY/PmM5FfyE0ubxucXmarPoT6Yb6NZSSI4NiWA6BGfNlWBkoukY78SLgBV976EaxsJ6iV9EbdVgIoBucgS7DAA1DmT7rK40DEh4edrTeIrNs74mhm0bD3NafT8NlGhDJm4bZiLOr7xsRrr/hvO1NOeGeyzhOUQwiVJa/woCawMNd2HVzIm5LQENtzWV0VE2ZuHRdgP9Nz/9oTi7vXGU3lKEAA/BtMBvKP/1o53jlWWNWPm7Z/FCDnkfTHyt2IvWisg39YxYGtJZkJvdIvDKrCUoN2YQJa1ZenZPWEji8u90OjMkyYOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(316002)(6486002)(478600001)(8676002)(4326008)(66946007)(66476007)(66556008)(5660300002)(26005)(6512007)(7416002)(8936002)(6506007)(186003)(2616005)(36756003)(2906002)(41300700001)(38100700002)(54906003)(6916009)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MXde3lf9tv8ekvWqoykQN7bpPVQ2LxQqAnxXU5xCbO6Dw9EDFvxJmumCraZz?=
 =?us-ascii?Q?KyvOGn2R5lnFjI4rDvwHnudUQvUYwmpUBoNbktKqHbnIDQiZSwaJFW3tStT1?=
 =?us-ascii?Q?6LIYX4iDyG6rGVHWMgd1jt/5kaWLd4gnZOTxDNKksu498LSU8R4fcPNwdb3R?=
 =?us-ascii?Q?QjS6cxEk04az0Dn1WSNxjJztie9Gu26Cof9az1Q2WpsvUYvX/zknZfp4MYDk?=
 =?us-ascii?Q?C4rurqSX2ZCdyC77mXAFPckqYGZlvz2wVabBAmiZhhv8S44ccAmW4RDdWAwU?=
 =?us-ascii?Q?X1STIztxLTUsTVgAnFKAr3W1hL5wNlvzHLEJekBjhinUPRluOSO+Rrzjx6t/?=
 =?us-ascii?Q?wVITO1GJ7JfmdobRMb3HVy2k+pxQem0dGTGpo1Sm1e0BD0nvdXQ7wN4c7Zry?=
 =?us-ascii?Q?ghe47YOpG6LmW2vlKsIQVcTCCCrqhX20ZhBe6xHTQujGilwReU+loatCvWzo?=
 =?us-ascii?Q?e8Jl+SsX9olAqGJ5/6cUjIqILP9w0dpaPnoFbvxzj90r/5LhSSj0hoPTZqPM?=
 =?us-ascii?Q?D61CGlvdLzP/fQnBvQ5eZ6nFuEd43pFi5fkVRUsHPtwvolLdv3+rGOm1OUvh?=
 =?us-ascii?Q?ZwMMwCcAT+JvTKuJgsGtkr4yqF3riN3Tmm09H7XdnzQCpMzUhlDXKIM/J4wb?=
 =?us-ascii?Q?N1TQU1QTPYpWCv7D38mUgm8ldKb9wxw8f/g+dF4RZOsgzvy8UzjlKrnekhCw?=
 =?us-ascii?Q?ahPrR8B9SYzh1HeXFaipsjIyX4cU0SYXYgo8jI8QRhtwxyIlITAmC/Bn1wUg?=
 =?us-ascii?Q?gcC7VwjGPqnVG5tJDATsb+6fyuskQa75IrYg4TwArEBqyUwKSQc8tnpVGZnw?=
 =?us-ascii?Q?z6TEtN9tQH2A9NAeObkppL48QeALXPXORBWmPgDdi3vXHOcRwb+JF75r79L6?=
 =?us-ascii?Q?UGRm3wkxqEe19fv3DoCBtrr+IkDxzU9TiwGyqDp1nH0cpOfG7zPfFixi73zG?=
 =?us-ascii?Q?izKWBM+BKWU9RE4FjxpPPXLFwbQAK2n0gRVrjGy7xab9Mwni3Fc1Q9qYNsQw?=
 =?us-ascii?Q?FiVpe0JpeXAWJ5oY8GuPYNVd0EcWx7d5RXplPP4mPoMm3ClEMhlORvM/ClNq?=
 =?us-ascii?Q?4lPDkc43G04+K4/hsH0t8MiQ8e8uRmsGfV3zbaK6YDMhApUrNQPAd5jHPZZg?=
 =?us-ascii?Q?cEBDmXkwuXgvawuy4p4iEEwtTjjYH4sjrvdZddwW8hfF922Am8vgfu3qotMX?=
 =?us-ascii?Q?BdmDCjC5T8U6Bwp5Aewz175b7Xd978x6B2Vmdm5+40fPqbTa4DpqQwkPU96t?=
 =?us-ascii?Q?N5FlJIfVSJAbZiSv8qsWgdy3wLP9TXBl63xg7MgDfzhdQoXIgriOcSgOht18?=
 =?us-ascii?Q?RqtnKe86ONnQ5D3FQWVHOKNzH+t8oFw9t0f0GTsfWlwuXhSyoQdXQ3n2Jhk2?=
 =?us-ascii?Q?fGuhacVagqAu55OHuQiLSXK/hpMb103f1ytRV3Y1XedraKNz4ll0ITDGhbBw?=
 =?us-ascii?Q?eSOJwZnY4zT4lB03Lilo/FTOcczYDnQf/DbzWyfxhcBnVehIG07+0zFjZV9F?=
 =?us-ascii?Q?Q25bFXKq7FSJlKt0+ru0h9C5c6Wvoizl0KPOrDCpPpYL2nd8AxXP9aNTcsDN?=
 =?us-ascii?Q?kzJmoQ8Oe7FWaAuRp+I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f66eb4-808a-4fc0-41be-08da9fbfa8e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 13:04:34.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81WnVfNDspiAMNnRAPtRNiICqR1zrjAAfrjTXptWgPijdoxfDYoz5w+dipZ2r+aA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:34:30AM +1000, Dave Chinner wrote:

> > It is not about sane applications, it is about kernel security against
> > hostile userspace.
> 
> Turning this into a UAF doesn't provide any security at all. It
> makes this measurable worse from a security POV as it provides a
> channel for data leakage (read() case) or system unstability or
> compromise (the write() case).

You asked what the concern is, I think you get it, you explained it to
Jan in another email.

We have this issue where if we are not careful we can create a UAF bug
through GUP. It is not something a real application will hit, this is
kernel self-protection against hostile user space trying to trigger a
UAF. The issue arises from both the FS and the MM having their own
lifecycle models for the same memory page.

I'm still not clear on exactly what the current state of affairs is,
Dan?

The DAX/FSDAX stuff currently has a wait on the struct page - does
that wait protect against these UAFs? It looks to me like that is what
it is suppposed to do?

If so, that wait simply needs to be transformed into a wait for the
refcount to be 0 when you rework the refcounting. 

This is not the same FOLL_LONGTERM discussion rehashed, all the
FOLL_LONGTERM discussions were predicated on the idea that GUP
actually worked and doesn't have UAF bugs.

> The *storage media* must not be reused until the filesystem says it
> can be reused. And for that to work, nothing is allowed to keep an
> anonymous, non-filesystem reference to the storage media. It has
> nothing to do with struct page reference counts, and everything to
> do with ensuring that filesystem objects are correctly referenced
> while the storage media is in direct use by an application.

The trouble is we have *two* things that think they own the media -
the mm through pgmap clearly is the owner of the struct page and has
its own well defined lifecycle model for it.

And the FS has its model. We have to ensure the two models are tied
together, a page in the media cannot be considered free until both
lifecycle models agree it is free.

This is a side effect of using the struct pages in the first place,
currently the FS can't use struct page but opt out of the mm's
lifecycle model for struct page!

If we want the FS to own everything exclusively we should purge the
struct pages completely and give up all the features that come with
them (like GUP)

Jason
