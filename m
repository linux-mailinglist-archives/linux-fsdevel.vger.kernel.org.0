Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBA0619F6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 19:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKDSDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKDSD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:03:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722772AE26
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 11:03:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QENa79S4lhbmr9mpyOmXcVTBzL+oYj6WZqUGn0FZbvfyFL7PSYFxS07wG3FK/q6AFCM7Ytjyh+keO4xXIsj9T/e227QRZ0ITszET49UyGuy8MXq/qxuHhB0iAszJ5xddXVNhx73Y428cMkTiu2zHgXe53CYPbBJ9CgXByA5sUYBMXEHPWJTPOd2WWHs4z4TixKXbfrLMo9+k/uj4juraClz+yfd5TjEQr5fMpL6gsnjq0cSnvcTycgqu9IMGvtbvY99Ro5dseFDrgYc4aeqscVY3jzdm1epYCG23OIO0hwE/9wXLY2oXh9FaXsxxa3NJ+D/8rwnn6xl9MAyZRRvwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5DlKrBdtjWjFfyERNeXSExmeu/Kfr3Iao9mjBhs1h0=;
 b=hO3bsYGkF9WfX/SyjPhY5NVpehyGSx3sFCfgqh/e8og8sd6agz9qTRxNWK0qxoS0lMy2u/ICPVQlzesLOXw35SbNvaxotgSjG2WglIzxo59NW1GTtuJb2YVtIvw1F54bO8UeNqQ5jxgX1m/s6Fg/lLz1DWl17Hwd79ufga7UeSFRm00p56qHOo0R1CoMznI+sfOcPhzS/Ab6gAgAxhfy8xAQng4jVKfZpQg1w3V35J+k9eBrHR2ykN+0rzRRXJ2xSvTDPOqIlQy/x9PYVBJNSnn2kvWVlACGw6+n4WU//AYx5BCFjbLwZqv/cHTxHPWZ1YvvcQN8OfJDrcTu8BwBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5DlKrBdtjWjFfyERNeXSExmeu/Kfr3Iao9mjBhs1h0=;
 b=XpVXWJftp0OLEWXXfgCmwFKJlOjYNb362FDYzCFSCrrDtpkeWHUs4GNDWhLOfdzkWjAgO9EPC88ITEtecftP61kyj5tB9vopgBu5qsr1rlvUo5hvvjkmgPNbDWE2MKiZlXODrzRdCMgaRmmoVvSkRKO/O5QBrNPlkV5WjV8Trg6bwi632/D6lW+OrRu3eByOsm/MvHIqF2GtM9JS2KDFD98oVshDV+glJe32dllle0GYHPC+9LHxul6e1smkHkG5QhXZvyrblk7LizAwEpaAfUwSNs4YjlSHJRFb7PyZ6EVmGlBP+815RvNEpowJVVh1/1oc9F0a3jhEVUiPxkV5qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 4 Nov
 2022 18:03:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 18:03:22 +0000
Date:   Fri, 4 Nov 2022 15:03:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: xarray, fault injection and syzkaller
Message-ID: <Y2VT6b/AgwddWxYj@nvidia.com>
References: <Y2QR0EDvq7p9i1xw@nvidia.com>
 <Y2Qd2dBqpOXuJm22@casper.infradead.org>
 <Y2QfkszbNaI297nl@nvidia.com>
 <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
 <Y2RbCUdEY2syxRLW@nvidia.com>
 <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
X-ClientProxiedBy: BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e0dd10-561d-4397-e2e5-08dabe8edca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFTFOmeyRmPOsAzOHNtscFj+zqRmHZyIX1ywVbit3zEOC0/WEz+AKH1vJgUppXYnHk/yPWUQ//odwCBiRPAgGKmCtI8uX3U5LVBonWE8ZBn1zRjDmbnvHJ+73T/8rYjrJKjuMWq8ilqV80QMGTVVD9nrqo6FXGQ/cwQYg6q758QEHQ3pSlKzAoVFGNWgtEZWv9/IKzwAqG9V3AuQ4M9TihcTihuqWusMzvaqzd3xtTMyzK31v1s+IMorJmSMkNIPu2Fa5tLkeIjdX8el8SFiRb9b33u8ipSkBLmj4QKSwEygKt8gB3iRvTP/+RfUcaKu3ojgAOvEs/D4amJFu8IOb5ixXK8irtVDXXqHNlmmFHN0Laqh7P358SFJB2Gl3oPxK0lDLp0BrlPAW5kayUggzmZx+fVf6AqtPiA9mDeFQ00j8deAipy52DJ4yHpcnkf8mJZXiJjOzx7mOyLHbCvIQqGzx6hp31ImYptmJysT3Q/IepwLbYDoQPWu6I3nCPolsKL1w/nJnLvq/+XShYVl0NeTYUteC4+CsOBUU8E3D5kFW92jBsLe6R7cw4lRUm+TW3BvsHM0HLrVKbUo8ZMX+h1HAfSX9XS4nutsXGkHTrrSFjWrn4Sz6C8uPldydZOjPVuYFVqGOFLrv1HY7lXpnl+UVhx0/aV45uPaH8CVluMq7w4kWKmXUl5tHdsLnnB6Bey55yQLI97ZgfeFgZ1csKrZgxf6hUJBegc7xzVQD29dc5j4e+4r42XPaFt/kpj+wfmiJpD6ppH3+F7oBsc2dUd3gvesmG1Flvq8qeodhPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(2616005)(66556008)(38100700002)(83380400001)(36756003)(478600001)(966005)(6512007)(86362001)(6916009)(6486002)(26005)(54906003)(316002)(6506007)(186003)(4326008)(5660300002)(2906002)(41300700001)(66476007)(8936002)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WKRI7CcXfvw8QqygdfX4j9n+vrHfmqfxuuiCaNMZpGi5ICrCvPFOhK0vkzdZ?=
 =?us-ascii?Q?EuPvptzy+8vQ4PzgjoAAEo8CVT0qtZwsXhgtFmL43ezPlgcK6yqKxhrmz+7I?=
 =?us-ascii?Q?y6hCtJ5IQDgMyXPR5tGObneIkFnuRSxFCDosUCcJeyb4C/VHI4/HGyWbbQQh?=
 =?us-ascii?Q?47aCEJEFunuXuUqfU1kiW2l2NTLCKhxG0xO0Rsc0/rlY4gHrYe2ukRk03Bz8?=
 =?us-ascii?Q?x9zz/E6JjyYJvwTPMOzjI7FyQr5NkmRDx6y9CA0QiYCQgNjFAxGn9yjsJTib?=
 =?us-ascii?Q?sqeBHiljP+tGns/6fPH+9sR6dVYQG4H4P03d22ML1iXHdfTV4a7ss3hc2wQd?=
 =?us-ascii?Q?y53puTKJomxDonP5+wXCDNmfYvXKvoFpqCmeILrzmNUkRhWNEOfsXbmMZTz8?=
 =?us-ascii?Q?NYTW6smQzvC37ssvE3kXs32+t6oY5Uhsz190e9t7SZXtbhlxT39+YcaxFuwM?=
 =?us-ascii?Q?WIUqkLW2yBD4UIwVHocP9L+nFIcDmWyLNQKjZOzEaFub7EUyq1dsw0Bmseuj?=
 =?us-ascii?Q?hP9qY/LNzGt9AiYOAb+nII5wtsLLSmm6mr7UXD1GnHee983Qy2mJKdRoRDei?=
 =?us-ascii?Q?fJuvdD8pxsMFLT5Zo8KvsRyI4fj43d/OmZAtiGjZfBZRRTm25EZhNuy7P8cV?=
 =?us-ascii?Q?qnRi22ZgL/k305ztLcHgaGXZuAEqmo3jmI7rE/ab/boWjB4nv8bacIQrnIkk?=
 =?us-ascii?Q?MuZTkjSAhXhxsXBcMi1j35amNixArm2Uf9V6WQ11uOo1qECQF8nO3QU91BB+?=
 =?us-ascii?Q?nvEQjaq4kL+qjGcBGncLCxeLoE56Jm0VBP4js3tfq4Yy0ingNB4uDbg2BZyi?=
 =?us-ascii?Q?lrTWXlp/LF0JNsJaBPosCvzLWf5bzxffUtepFM4vetcJrNR7VJ2reGAoJC8/?=
 =?us-ascii?Q?p3mPanXv0h2rmIc54QDdZOvNWwk1shGr/zPFQun10zMxy/WIzjZtxtOjrkbn?=
 =?us-ascii?Q?TnRVuyHdFM9NwFCvI1BogQXkPbfofIzmLj1Bz8HxVyu5NZ0l1hHVWtAGt5JG?=
 =?us-ascii?Q?2BJUnKxXdVUAycw3iiy5LHrdmKvUgOkHkiqfQ0tB486QZ6EayJ1lFX9xHHZ0?=
 =?us-ascii?Q?hl3BGCP7/ei77/ng/lRF1kM6YR81oX389VZtHuO3amA5foYbNWYTBht/e+NN?=
 =?us-ascii?Q?jwrAgNNAGjgDKTz3zs0c9WONU/zsOZpnnN3Q8WIEuO878RTjWtFTibnQKmxh?=
 =?us-ascii?Q?UcoOqahS2+xXdR61lA17iywlEUTjYVMPZX0gSJw648XxkXRyPwWimrRLo5aQ?=
 =?us-ascii?Q?TqW4NoJEy9KL9FvqLMdlNUGKGTJYKW3XyVx4B2MN7UX5Q2xF0L2rSOXcMtOl?=
 =?us-ascii?Q?hj9Ca7dldEV4PGegR7dp/oPw2GrMnbpSRBu5mjL532e6j1ypz38rdYHrGydt?=
 =?us-ascii?Q?OJLJ/vPuca1JLINo+NiGT5qAxVS6dhQLz6rWSnCxFRg3dXGhZuEuQzDojydM?=
 =?us-ascii?Q?1ZmhQN3uGpY+naYFCOA3ZYPH1fZP19gTiuBXioPe4KsJsFyjI6mWu3VG7qYO?=
 =?us-ascii?Q?ji8HjQTqzSUY4MzpnvxIJ7BMC/Ee6Y2mdvvPChR7Z5OIJXZ29AOSuWPlPClv?=
 =?us-ascii?Q?sodh1JyESSeMsZhkrNU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e0dd10-561d-4397-e2e5-08dabe8edca9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 18:03:22.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIgAhiefXsTNJhtK7I2LO0UvAxkqzSEgmYVDpcu/TlZiyrN2dmK/xiqdYV8zRJcH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:47:17AM -0700, Dmitry Vyukov wrote:
> > > Do we know how common/useful such an allocation pattern is?
> >
> > I have coded something like this a few times, in my cases it is
> > usually something like: try to allocate a big chunk of memory hoping
> > for a huge page, then fall back to a smaller allocation
> >
> > Most likely the key consideration is that the callsites are using
> > GFP_NOWARN, so perhaps we can just avoid decrementing the nth on a
> > NOWARN case assuming that another allocation attempt will closely
> > follow?
> 
> GFP_NOWARN is also extensively used for allocations with
> user-controlled size, e.g.:
> https://elixir.bootlin.com/linux/v6.1-rc3/source/net/unix/af_unix.c#L3451
> 
> That's different and these allocations are usually not repeated.
> So looking at GFP_NOWARN does not look like the right thing to do.

This may be the best option then, arguably perhaps even more
"realistic" than normal fail_nth as in a real system if this stuff
starts failing there is a good chance things from then on will fail
too during the error cleanup.

> > However, this would also have to fix the obnoxious behavior of fail
> > nth where it fails its own copy_from_user on its write system call -
> > meaning there would be no way to turn it off.
> 
> Oh, interesting. We added failing of copy_from/to_user later and did
> not consider such interaction.
> Filed https://bugzilla.kernel.org/show_bug.cgi?id=216660 for this.

Oh, I will tell you the other two bugish things I noticed

__should_failslab() has this:

	if (gfpflags & __GFP_NOWARN)
		failslab.attr.no_warn = true;

	return should_fail(&failslab.attr, s->object_size);

Which always permanently turns off no_warn for slab during early
boot. This is why syzkaller reports are so confusing. They trigger a
slab fault injection, which in all other cases gives a notification
backtrace, but in slab cases there is no hint about the fault
injection in the log.

Once that is fixed we can quickly explain why the socketpair() example
in the docs shows success ret codes in the middle of the sweep when
run on syzkaller kernels

fail_nth interacts badly with other kernel features typically enabled
in syzkaller kernels. Eg it fails in hidden kmemleak instrumentation:

[   18.499559] FAULT_INJECTION: forcing a failure.
[   18.499559] name failslab, interval 1, probability 0, space 0, times 0
[   18.499720] CPU: 10 PID: 386 Comm: iommufd_fail_nt Not tainted 6.1.0-rc3+ #34
[   18.499826] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   18.499971] Call Trace:
[   18.500010]  <TASK>
[   18.500048]  show_stack+0x3d/0x3f
[   18.500114]  dump_stack_lvl+0x92/0xbd
[   18.500171]  dump_stack+0x15/0x17
[   18.500232]  should_fail.cold+0x5/0xa
[   18.500291]  __should_failslab+0xb6/0x100
[   18.500349]  should_failslab+0x9/0x20
[   18.500416]  kmem_cache_alloc+0x64/0x4e0
[   18.500477]  ? __create_object+0x40/0xc50
[   18.500539]  __create_object+0x40/0xc50
[   18.500620]  ? kasan_poison+0x3a/0x50
[   18.500690]  ? kasan_unpoison+0x28/0x50
[***18.500753]  kmemleak_alloc+0x24/0x30 
[   18.500816]  __kmem_cache_alloc_node+0x1de/0x400
[   18.500900]  ? iopt_alloc_area_pages+0x95/0x560 [iommufd]
[   18.500993]  kmalloc_trace+0x26/0x110
[   18.501059]  iopt_alloc_area_pages+0x95/0x560 [iommufd]

Which has the consequence of syzkaller wasting half its fail_nth
effort because it is triggering failures in hidden instrumentation
that has no impact on the main code path.

Maybe a kmem_cache_alloc_no_fault_inject() would be helpful for a few
cases.

Jason
