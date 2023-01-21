Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F0167635A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 04:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjAUD1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 22:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUD1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:27:21 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824B1B541;
        Fri, 20 Jan 2023 19:27:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDdH3tkLSqkrLKA2MTLojaAqjRy6y8CbiolI8qlwESmdpZStBkPzYQ2bF5r6vOtH2McVs4ZsmaUI3E/Riwp4sGzTnhVtY/OHqH8C8pQQSSHgPEjYbPMX3AxD+9NPPZ9Gz4lJA61zBbswbK/z2yQbh32SXsLQXbYCEtQc1TkEeQdiVin3R/dxblTuYfHValU2qZKP2qzWo5Mia9Gw/9D500CqnbkYiRiz8XxZllrpXAob71Bf8WfS14ch52P57kbXwkZJ4z1bNS76b7HBOrOt+ilkxE4WBn4iX0q+/zYtC2HvgsseGQaT8myG9AyMmk85hwHGCDNIP42n4GGZGEnBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBgeGfn5mAfqmfSvzmRlgN7H6tUWWIJCcEONlOXDIgk=;
 b=TzUBVB450XHG62eYvuNriRVbILrofGv6diXYtdQUvsoOWV5nyx1UKWI9wg1LPN81xirshCatmG2CWlc4BAvWLgFZV0f2rkep3nCFx+OAg5EUXTiYftRJz6kz6T6KQFAooAIwEvyzH0Qqb8KlIbLXYLMQjjWq+JLuESAeR+hM7meVC2LO/kbbp4Rs2FjD4s4zxIJMyF7SWlL8/bzCTcGxRdR/hAOCqLA0NRQrTokSJ2h8UKlATBd6gH+ILuIVz/yYntW4SxPAG440XjZAk2/M4sA46w9tzbggqgaLm81KMVbXG76Wpip3lM3Rm3XD21qmrn1z+Lp4CZXalHps25Gzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBgeGfn5mAfqmfSvzmRlgN7H6tUWWIJCcEONlOXDIgk=;
 b=teG3t4iYOC4iS7FHq5Qe83tXniQ8FODDUZfu7EVGVLy/vkF7WXpuVRrxc9I1vw0nmvvQ3qxIpCB6qrXlbebyD9GxqqRtJNDjM5FFcU1fawlhdxH3tBs+Qr0wHzTjffCa37qu45gSMOzmWlEkWnNC0QkgnCbP6fzw03MSX//S01I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DM4PR17MB5948.namprd17.prod.outlook.com (2603:10b6:8:53::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Sat, 21 Jan
 2023 03:27:17 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 03:27:17 +0000
Date:   Fri, 20 Jan 2023 22:27:14 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v3 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <Y8tbks5q6hL3B3pI@memverge.com>
References: <20230120144356.40717-1-gregory.price@memverge.com>
 <20230120144356.40717-4-gregory.price@memverge.com>
 <CANaxB-zet4+S4saBHgYPP6feppBVHkCRJxTkL8R-OyXa_gXG3Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-zet4+S4saBHgYPP6feppBVHkCRJxTkL8R-OyXa_gXG3Q@mail.gmail.com>
X-ClientProxiedBy: MN2PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:208:e8::18) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DM4PR17MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: a5bbcf58-e2e6-41dc-7cd3-08dafb5f656c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XIL0krENnKtUfzKAztwrZBZPuORXABty9grp1AfW/uL/wmR3WSy6TvEBuvh7QiNJEqjfoEi8G8Tx404eyqLtjDm+LIQQ4rC9H3yRI2Gv9Mq9n7umr7AfJIPUmn2B94iwQ9fSmQq0t6/xd77+e35UtZFC9eTxo2DlgmAEAGwAvcxu/9gd1j+43CYDU/4EShf1hBXoLAuggqTkGWoJQ4V5wmTWI7DlQyXGRhhAEeplz/FpE5t8FY/U8zHMdG7KyWW2wJDKxe/s7CV76lyNm/p3Ii56uy2JWfS9WYdl2M6ZqxGo2fjs56JVi9QL8h2rwyiLii0HuGOk9uP5qHEzgSsXQtcdDnLHwUEMu7CFaCOlJTaRlS8nyo8SQJOAgclpbCSF8Wq4ZTeYHbPYzjPptzp9VAmB8r2CiK/SZ4ViBscjYpcBMWlKxzRLMvqVDxlRQp3TvFL8vSuw+aK321o7wMG8u/4o8lRRSSb/bbyR6KxPqN3W7RoW9VoeaWaQLQ3ygD5XFaxS7Og3Hnpl9uR+NHYpcR5TQ5fP9vaEds9JD4QfRo4evrYxc1EpkF4cvP59YRyycOp3sVcn7d6a6UVAyl2c8ZJUR73IqMfuxHP6zQtoDCPJ5nw/0QPSRFYnzawEtFBlLtGSn4bzO7xloi6yPS2xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39840400004)(396003)(376002)(136003)(346002)(451199015)(38100700002)(4326008)(66556008)(2906002)(478600001)(66476007)(86362001)(8936002)(66946007)(5660300002)(44832011)(7416002)(8676002)(6512007)(2616005)(186003)(26005)(83380400001)(6666004)(316002)(6486002)(6506007)(53546011)(36756003)(6916009)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0InV0gR8SHKGTRR65Ti5Z/grM7DDYVB8M/axCAUU0rBQy0R+mMvcQoukXm+?=
 =?us-ascii?Q?1gS7k+V2OAEYcBBmtoHEc7vNaLZnuYO1mwKXYNvcQ9ygO4bE4KqMrrtSrcxi?=
 =?us-ascii?Q?14msJD1aTSLGiCN64tM2vj3gifAslr9BdGIxnnYuPkF2ewBql2KBWp3P+Dgf?=
 =?us-ascii?Q?2UBmX7zsnhw+qsWvvMvkLrp0NuuEVIpFI9CJNI027kQ+HzNxx513Svvdvk5d?=
 =?us-ascii?Q?KLC0Cfxpx+UZiddNtASLv2/66JkH5MgkZDvjkIm9IpBgQt1Wm+AxVs80A3Xs?=
 =?us-ascii?Q?HyhxJsRZOP+2lB7f5oO+wkyOdr0q7lsiG45uLChwW2K5TOa9Pio5vkqQriSi?=
 =?us-ascii?Q?t1JVqMBSzHppX2UmjLWwUaC8nUc3svAB6eokZCMVbTAdZ7d+LOcsjnIbwiok?=
 =?us-ascii?Q?H7nknv5yPv705kPYW6d9g6RjGvvm8uR2gH4GhKB+dESTXg2yS81ldGDyIAPy?=
 =?us-ascii?Q?+0FvqliG+68L9qkGWvPJ9YCENwYD5lZBFaHltbuAyujbE0b8fN2TzoEiHqlA?=
 =?us-ascii?Q?93zozwW73h2A2s6LIjk+dMiTYKUGwMHkTA7ditFCr/Yri9Amkdyz3/vehJHN?=
 =?us-ascii?Q?2BvYOsjnJ0FnCmSFY2paLuaUyC3oM8DliLXOMBuhTvwBlV0f404/qc3m7a3R?=
 =?us-ascii?Q?6OLOhpNNzH6pujtoF0LUZnDgXVcxS9IU8rPMCPTTP40SijSoWiPa68KEdFMe?=
 =?us-ascii?Q?3i34GV7Vz3oNAQx65/jsP+ovCCGliQjFOC4PGCfK/mDHliyWpWWYqrBpXYmf?=
 =?us-ascii?Q?JIvRxuaztDp8AoIhm3wXTC1oEx3isOdbgGXG+KRsxPKJCuXOC42WTfu77cGa?=
 =?us-ascii?Q?JEs6qplPmxSxvefO+DyN3FsLMytaLLPweFdnXceYU+CUJjqn6LSZhOm48BJu?=
 =?us-ascii?Q?uKI5KME6VLx0Of5pqklcnN7QyS7FPlBxPiGVD1h0VXhRDM3zD4pW7ffQ21I7?=
 =?us-ascii?Q?wDOO6fohnDVGRCgdp+33s18NZ8nlHGGkTW8Yj2XAJ77hqPke93kD4N2jTCrj?=
 =?us-ascii?Q?kHv08H83magLDynOCk6UAVI9smM2qNna1leJ6Hn6LHJY4OlpbwyGMiY446w6?=
 =?us-ascii?Q?nAIqhS7BBgsRy8F4kqhsntt0OtxljrG4Am4lqRhYXmarNCmajYKPo7FFeDed?=
 =?us-ascii?Q?I7Kqp6AIB6aJaQel8Ta7PTV6W3EqXwuRWZNYenHXypxmUF8Pn4UQmjJbPTAh?=
 =?us-ascii?Q?lN9RBiKIDg3iLhUcuQkrCkj7WAGvm1U1QuM8HUNrytD/Ntj/FGQav8J0SJdt?=
 =?us-ascii?Q?oReJwpoexUhiw0DD5S7Rdne3UPzBWXbgnd6AYVeF80HIN2/1D2d2+Nh6zg4D?=
 =?us-ascii?Q?ndD3qg/U2+5ybqctPhACPO7qy75i7hhtMyqpeLSK4b2xrYEJYrMlLxYuzEXS?=
 =?us-ascii?Q?96HpY2YbB8HmavJ9rGstl6xxMDZuDzoE6mac79SKP1c6egD/RaWZmTavprq9?=
 =?us-ascii?Q?pCOKCieK+2SaD6rnKx7eOU8rPFatkPt4tahs2vr+Cu1yMA8OeWJXx98qLIA+?=
 =?us-ascii?Q?/Ssbq20zYuFUJUVVY2YJHSsBqYVxHi6EU165y14lDfH+HVejv1hqgQlXXx3v?=
 =?us-ascii?Q?Z4l/uZLyklJGTRhZDanmJyzYEDMA2i2xdUBD9N/CF688h4y8zGpm21cSRo++?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bbcf58-e2e6-41dc-7cd3-08dafb5f656c
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 03:27:17.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHuty7KCxBbyo2uP4xkvkfDnPHYwCCGgkO+6P8r6wx31RmvZ1t6tGZdwVukBuQ+yJUjVwpqlDt4lI/+x2Ker0bCCU7r022INFUsH0kZcx3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB5948
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 07:18:49PM -0800, Andrei Vagin wrote:
> On Fri, Jan 20, 2023 at 7:05 AM Gregory Price <gourry.memverge@gmail.com> wrote:
> >
> > Implement ptrace getter/setter interface for syscall user dispatch.
> >
> > Presently, these settings are write-only via prctl, making it impossible
> > to implement transparent checkpoint (coordination with the software is
> > required).
> >
> > This is modeled after a similar interface for SECCOMP, which can have
> > its configuration dumped by ptrace for software like CRIU.
> >
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > ---
> >  .../admin-guide/syscall-user-dispatch.rst     |  5 +-
> >  include/linux/syscall_user_dispatch.h         | 19 +++++++
> >  include/uapi/linux/ptrace.h                   | 10 ++++
> >  kernel/entry/syscall_user_dispatch.c          | 49 +++++++++++++++++++
> >  kernel/ptrace.c                               |  9 ++++
> >  5 files changed, 91 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
> > index 60314953c728..a23ae21a1d5b 100644
> > --- a/Documentation/admin-guide/syscall-user-dispatch.rst
> > +++ b/Documentation/admin-guide/syscall-user-dispatch.rst
> 
> <snip>
> 
> > +
> > +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> > +               void __user *data)
> > +{
> > +       struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> > +       struct syscall_user_dispatch_config config;
> > +
> > +       if (size != sizeof(struct syscall_user_dispatch_config))
> > +               return -EINVAL;
> > +
> > +       if (sd->selector) {
> > +               config.mode = PR_SYS_DISPATCH_ON;
> > +               config.offset = sd->offset;
> > +               config.len = sd->len;
> > +               config.selector = sd->selector;
> > +               config.on_dispatch = sd->on_dispatch;
> > +       } else {
> 
> This doesn't look right for me. selector is optional and if it is 0,
> it doesn't mean that
> mode is PR_SYS_DISPATCH_OFF, does it?
> 
> > +               config.mode = PR_SYS_DISPATCH_OFF;
> > +               config.offset = 0;
> > +               config.len = 0;
> > +               config.selector = NULL;
> > +               config.on_dispatch = false;
> > +       }
> > +       if (copy_to_user(data, &config, sizeof(config)))
> > +               return -EFAULT;
> > +
> > +       return 0;
> > +}
> > +

Hm.  Right you are.  I suppose I should change this to checking offset
instead.  Will need to validate the fields are correctly cleared on
disable and on task allocate (i presume this is true).

Otherwise it might behoove us to actually add a state field.

Thank you, i'll push an update tomorrow.

I also need change patch 2/3 as well.
