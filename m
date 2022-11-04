Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB01B618D29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKDAVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 20:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKDAVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:21:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53D62252F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 17:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBiCpv0Ns7QT5jh5NjFESQthjEXzevlJcLaqVMtfdBOl1k/qdwQ54NeS5/ye37F4fLYcKB6h9LvgtFNp6oQigFdk9iKoCTv27XWYSubOS46cSueo44vkfIg6a01RMcdizkY69oR/cFT2hn0kMj3OjPqLkO3FrZCNwLcxcqZtPboWgXPExiR8kgzXIKmswVOLiwv2Q8Md1E1cf/zHk7WC8M0VgR77fct9XFYBfCZ9nVyGCoaEZE7vVzoD6LPPacDoLfHH8C51HIHqohZbhI5WayvGAAoQ4aC9UkBZL3KPUJ+OaimHg84C/chOkacnd4RL2ifPFkcINDv6wDKTbcmiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idhn8FzeJOQiCDOPY3TKCZSyS0iPdSYBqwnPiJ6Cuc4=;
 b=KK7E7VTAbd6V9sU3pSTFRMowX3N1EqT3uadCTol35VI02k6CSz368ukpgLpkiBaKgJQAeI0mx29F4EqK97DXnTioYViN5MmP1miLfQBWQHYQycpJWWkT0WUmba0da1SgGVqxqCfI3GUlzlvIeglEsdgpBJswgMky2ttjxBDGutA94bxO05YAxoNV/DZnY4ywapql1Z2JMPaM1pD3Tbr/z/O3aI0ttNcVapss89JBU2eAb+Y2/4EYArowIjal8g0i0anP2qJYyQfxSN2eP8KKnUMPB3rUhssxpZ92jEq1Kz/7xGWd1Bwfn/pwwzzrgSljCShwQPJ5piQob5iBtFkP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idhn8FzeJOQiCDOPY3TKCZSyS0iPdSYBqwnPiJ6Cuc4=;
 b=h7NybRVqWZ6SUX67IQPuAr7pBq9tc+EgRbh7vuU2A/tbqAaUER3catyFHQ0gPdCBPgi0kmAO8ew6l4kLu8M3/hQ28DXM9uQQ/Zvi2GYw2H0b4zjBRnYCrQEdvZLvjVANM/TIAYYNkdHSvuDmHTdhaDdhQnb4L+rhxigOgqWxRv/5AWG/ea6Oyyk+lbwY6n4/yjkbXBccmDgzrr0IfMHKLfEyv0wO86W1jOu1okML9nboMxoLVWXJl7dhx+Ct/hoddv5L2Z0NU3auXrr9hdV/ExgIG6A45yORBnLLnX5CcuGykvDq8MA60qlaUJKD7NdvNDLl5IuD1Ys5Nw+92wTIOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Fri, 4 Nov
 2022 00:21:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 00:21:30 +0000
Date:   Thu, 3 Nov 2022 21:21:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: xarray, fault injection and syzkaller
Message-ID: <Y2RbCUdEY2syxRLW@nvidia.com>
References: <Y2QR0EDvq7p9i1xw@nvidia.com>
 <Y2Qd2dBqpOXuJm22@casper.infradead.org>
 <Y2QfkszbNaI297nl@nvidia.com>
 <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
X-ClientProxiedBy: MN2PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:208:238::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7521c2-e511-44a9-0afc-08dabdfa852a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1MrKX6FdFqVua2ZaY+4MxRPT5MUaMUQd4x6utu2mcFr5b6bL/w4xcDg/q7SDiDgHmxUbzxB00crjZtu6PTf4bH3WfCF4zmWdtO1hO08CWhl1c/wtKM5MuxR5HRSJ3ZjFlVyZjuVu4b+c5+XbhUt02xFf7lDC9JaOaRRw13fNAMbDXHZkaFgKESqoIkn+n3Z3dmrW8LYvnP6sdyGSs5KbYrzwQhWtwANVa+EIV/8I6nJ0tCOb6jYT6aB867ejJ0GhfO57lcR8NU+rCfJ6xuHbbcvTM+8JPFNgUOvRTf28MpSLIramije8aNPWjmwkQ62uUrSiIiTzxQTg51RXiVvvFq7xKAGOknJbwqNSJQqrQ917iMiyUYDWaFscsPaD12wR+gPlzLJ1eEN5oU0wP+mZpPtYPt6fyUfnpLRUL16cwlaQC1A57HLBJs8GAqi4sLfBPh2vK/teW3uYAPazB7QML7hQekTB1lg2jgn+KTR9wBwZdxXzXDxYQeeceLY5FUOgaf1EgzOGJ8QOQD+oNMkfbtkGR0yXmIpG8hg+wVY0cq7zByehMOJRnTu9SxJIhWybvnlEUqqwDbAebxFulzFYVvloRGff2CQadc/ZhmX8T0iCbcAwQEMqG8qcURYj37kw/iDK7qsF+k5GpafIWnd/l5jTjJ4fjlyw2YXf81FRXa/0IKqdMiIR3o0h8fwgt9gyhFCnO9AAxfrAS+hC4EhqZ5FcrFQWahTf3coQSWyWf2Xbt57VYt++v1sAlUe7h8W8x/0c5+H/vT4CHIIUYOuTYCdV5kUk3DEHBcgwgdP6L4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(4326008)(66946007)(54906003)(66476007)(66556008)(2906002)(41300700001)(8936002)(5660300002)(6916009)(316002)(6506007)(2616005)(6512007)(26005)(6486002)(8676002)(83380400001)(478600001)(966005)(186003)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jm2qhEJjNpTvO4FgtLR+WZ3IJyM/ITvWE8aVxU5akv564MJzcFNGilWwjoZS?=
 =?us-ascii?Q?TNfWOPD46a6dgJfEj8yIuwY6yfjijBHIAzEnBgeV7cto53t4wb6bfs62Zjs8?=
 =?us-ascii?Q?E9aLoANcMkRDud3zmygjdC0W7oRWVQZMIBCCZEfnjsEfjG/eOn5W5WqAvhvp?=
 =?us-ascii?Q?RcUAm/gkx1Q9N+mxm5tOigXMl3KJfWIjdFFGg7AJ5+7Dv62pNt5z2DO2fVKu?=
 =?us-ascii?Q?TDagaZwRoahMkoKVUXwkyYvdv8b5oMdgIa4IOacOsL9S2qOaQ/6JWr/gTG6j?=
 =?us-ascii?Q?K8XKv4Vkkk9+iPO5C5iLwqcLMBWacJbMmiOmeyrkZYm7EYhiDvaME48bvv1P?=
 =?us-ascii?Q?dP12gbxnzOISpTFoCXP0MGSEddT0cvwf6QCSHMhXsQg6RkSJmpoHvnVLbBbI?=
 =?us-ascii?Q?05orvGpK9kqmoKjIjgwNzPpd9I0L+5cO/3GENijjWPS5AD2IuyCajecUypAW?=
 =?us-ascii?Q?9mxMcE3q4KHmx5vTF6h7OjysboCcUcMNyiCWdCJ4DlX2t3Dtn4KmaX/2kCVk?=
 =?us-ascii?Q?ee/GRKA7T0H36oCSDU9cBEZGxJjvXzMmfF/NauWnn6s13kbfx95tHbE8PaSx?=
 =?us-ascii?Q?7cb+9tGKpJ7PVao/jth5VF4LUemAyDIyVtHiOO+zJb+nAEsuc2SUwGTohlkL?=
 =?us-ascii?Q?u+ZxBt/HuG/96C29PJAPGwPqGlKDJb618mYSuDsbKOXIinHMO7lY5lvL7Nf5?=
 =?us-ascii?Q?PtiOVKHwUOwKAFIHNk6pdX8VKu8tRABXvjHASH7wXDezDW25ZWa0lSZLArcn?=
 =?us-ascii?Q?Yr6CjIZwTEZ1aBuPwuMc9UTDvayhDNP9EVrJkUfdxJj3IsHGf24N0P9O3GJ5?=
 =?us-ascii?Q?5TJaa/6WkAOZAGTfZqkgacBxoOCJy4jnyWziah/DpkY0ojKnuNqHtg/4Nf3q?=
 =?us-ascii?Q?zrI+sdwYwxZkQv+ngEpmR0R6sZ/r2kdihXbAUeAEoGCZO4PwmUW2gIDBhX58?=
 =?us-ascii?Q?mIzlxYaNi1Sax/Tu6cijFNd3Tt+aXjofy6OStrREzlYHcOTX0gMrMf8Np+GC?=
 =?us-ascii?Q?3ok1vIa9QgCpjtMLiiIEX35H4pn8TmJNuPpI3+VYJlPHM0g8Q1jNjArumc/v?=
 =?us-ascii?Q?v0f/D0coTMftUSKchEL8kuMjh3dtiszzdAVdphMZ9gXwbNtgLN0en3ZKYfwC?=
 =?us-ascii?Q?aGCollpF0ODGHpYDWSQ2YtzQrciOvoIp6ZAFT5s7mhJkh5iFT6sAb9XFo2r1?=
 =?us-ascii?Q?mrgC36LpnAVXceTJkrnRwZVRpHKVH9RJOaimhbxfskDsNHzvALgVvYk4PoyD?=
 =?us-ascii?Q?f885mMhFszOXkU/zaEuFWvPq0OOACSGsgZew/lw8lxWwhn642IN6oxrx/kGi?=
 =?us-ascii?Q?2TQqmvR8Uf9pPyWaaqhugOyH4xKjC20mu1hM15WdrRtgPDD590gosPDIro45?=
 =?us-ascii?Q?hkn+c6DGjMdVmm7qndReKUytWqOAXc3S2+vPPFRtlWM8qD2jU4zkShi9yK8S?=
 =?us-ascii?Q?mtx43xGT+AhCIYqAggYx7iXeMjz2E28/bcuPJkmNxep3nwnAiJO5EiY17aFO?=
 =?us-ascii?Q?R4RbwZxNFj9iMkD3f15yQAFjzscxcVde5ZgsApJKAtsZuTasgT87YFZk8aQu?=
 =?us-ascii?Q?goViUiZEN5fXiYTDLlE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7521c2-e511-44a9-0afc-08dabdfa852a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 00:21:30.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97Ph3oaLzzRFaFa+Auq8TNnEq9KbH+SIT01hSuK2tLkJrV8KBhYFtcEQ3v+0gNQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:11:04PM -0700, Dmitry Vyukov wrote:
> On Thu, 3 Nov 2022 at 13:07, 'Jason Gunthorpe' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Thu, Nov 03, 2022 at 08:00:25PM +0000, Matthew Wilcox wrote:
> > > On Thu, Nov 03, 2022 at 04:09:04PM -0300, Jason Gunthorpe wrote:
> > > > Hi All,
> > > >
> > > > I wonder if anyone has some thoughts on this - I have spent some time
> > > > setting up syzkaller for a new subsystem and I've noticed that nth
> > > > fault injection does not reliably cause things like xa_store() to
> > > > fail.
> 
> Hi Jason, Matthew,
> 
> Interesting. Where exactly is that kmalloc sequence? xa_store() itself
> does not have any allocations:
> https://elixir.bootlin.com/linux/v6.1-rc3/source/lib/xarray.c#L1577

The first effort is this call chain

__xa_store()
  xas_store()
    xas_create()
     xas_alloc()
      kmem_cache_alloc_lru(GFP_NOWAIT | __GFP_NOWARN)

If that fails then __xa_store() will do:

__xa_store()
  __xas_nomem()
      xas_unlock_type(xas, lock_type);
      kmem_cache_alloc_lru(GFP_KERNEL);
      xas_lock_type(xas, lock_type);

They key point being that the retry is structured in a way that allows
dropping the spinlocks that are forcing the first allocation to be
atomic.

> Do we know how common/useful such an allocation pattern is?

I have coded something like this a few times, in my cases it is
usually something like: try to allocate a big chunk of memory hoping
for a huge page, then fall back to a smaller allocation

Most likely the key consideration is that the callsites are using
GFP_NOWARN, so perhaps we can just avoid decrementing the nth on a
NOWARN case assuming that another allocation attempt will closely
follow?

> If it's common/useful, then it can be turned into a single kmalloc()
> with some special flag that will try both allocation modes at once.

A single call doesn't really suit the use cases..

> Potentially fail-nth interface can be extended to accept a set of
> sites, e.g. "5,7" or, "5-100".

For my purposes this is possibly Ok, you'd just set N->large and step
N to naively cover the error paths.

However, this would also have to fix the obnoxious behavior of fail
nth where it fails its own copy_from_user on its write system call -
meaning there would be no way to turn it off.

> > > Hahaha.  I didn't intentionally set out to thwart memory allocation
> > > fault injection.  Realistically, do we want it to fail though?
> > > GFP_KERNEL allocations of small sizes are supposed to never fail.
> > > (for those not aware, node allocations are 576 bytes; typically the slab
> > > allocator bundles 28 of them into an order-2 allocation).
> 
> I hear this statement periodically. But I can't understand its
> status. We discussed it recently here:

I was thinking about this after, and at least for what I am doing it
doesn't apply. All the allocations here are GFP_KERNEL_ACCOUNT and the
cgroup can definitely reject any allocation at any time even if it is
"small"

So I can't ignore allocation failures as something that is unlikely. A
hostile userspace contained in a cgroup sandbox can reliably trigger
them at will.

Jason
