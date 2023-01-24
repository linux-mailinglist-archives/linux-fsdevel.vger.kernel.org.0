Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40C678EFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 04:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjAXDam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 22:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAXDal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:30:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD589FF33;
        Mon, 23 Jan 2023 19:30:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLsnbjNk8xz/dAYCEF5VXHwkXOD+r57jLxiKgd/VlcG3LMsaL/6klLHVenDxPiywR1g4OuPdVCumYa/19p/h7BCI76KXwXL0Y5hr1MumGaG8mD5Ac/aHlUud0DtyY8HrX++0+GjVkxqTRntrJvnNMQlGLXfz4pVWyHl4ebuXc0+pmgsZvwdPfDhlt8R+vHEpwGVXbY3JChV03A2miNOlO4byyv2Yv6wzfAUEamh1YWHrLfY54uji/hsAJDfJA6o4VitmidRSPwwALv5j7wVfsNpHW85IaS96BwY34PRWsxtI1ISXG30JylEgxvJ98QBcVO48DK2Y+PasldA85qXfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py44O1dIjQX1Q5cW35SCpuNj9fY3eqz/cu9617ixJSE=;
 b=CwBDNoFlSPx+C/bDq5Fh3kn+iEbmVBX2TlekSNPOXJzNgFM0C8umpFA1oU0NoJgpNdmAnCMLCfWQUsuJWsbbRU8RpeOSSqDSepN2WyUfOjiqTaKg2VmLv6X+kpTJrdo7QBwe3r2axSS0YYFpyNq6Vvzxxiz3+clIG1eWgf/F32d+DboPxJC3xVtxjXBQdgfh+pjXdVhCY9QtMU1D3b63yHSs7kIx3Ypk/H5aGSWnQwHNJ4MITFAYEJ8Kb51D00u5xWSR0CDJqR4GTT/CoekafaCXYiizBoseqv4n/JmyIdfu9HI3UOE7gM4CbZQYeL7/77t32B8Smh7QfvfEXamfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py44O1dIjQX1Q5cW35SCpuNj9fY3eqz/cu9617ixJSE=;
 b=e7NAitc3GjG9ISlz3ap0DxZWgU25Wnj9onUefn0LYWCF8xrjLmXKb1S+xCGwklvu8K801NhUPPy4vllHZ7CukerRHqnynOmED+kAy7IhKXOq18wGb46Hc1QZ15xu9F5dwt1ryhiJeYQGAjKPHuy7WG+eb6BLfurenEcyDNfUjm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by IA1PR17MB6239.namprd17.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 03:30:37 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 03:30:36 +0000
Date:   Mon, 23 Jan 2023 22:30:30 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <Y89Q1ikj4RQCbH+T@memverge.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
 <20230123032942.18263-4-gregory.price@memverge.com>
 <CANaxB-x86NUAYG1F2+-uOj676weVOdy9aKnmxjaHTuNxek28gg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-x86NUAYG1F2+-uOj676weVOdy9aKnmxjaHTuNxek28gg@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:a03:60::14) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|IA1PR17MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 61176214-2eb7-4a5c-f616-08dafdbb5b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GT9cHvFfhKttyjQYrqFZeYuZkv1WWcDuYz0ZMLST+nyItlW1S4THI79bj9Rng5voz17cJa4XFj3D7CB5qxUKAFP5/WaV3HooUxcFeMkmIrvcHtwsqkKa28fsnJGiGeSuu7nlcBU6SF2HYvyt4KB1m0S1s+SBM4TxciSAWEfhNJTtMVvku5GEZKUI/VsdH75/HxJRxSd4eGyIphU4hYiaU13x09RI9tRqKFAgIq5m0xtlVu8YkBNtGIrE96WzXtqMKQ5TaKDRDcwl4FzVEsSVMvzJJRl9JIJujwBjIs5042RNHJYWMQShg2gzXMfouKcN6JkFX5OOonZ6p8H/PApAbLqXbRY1ZhQMTVzMrPtBb7xIdlWt2tS1qQh57nqGrxsDsBySMUOCLTAxpHTjpjfmHkDq2r+Q0XUH3d5xM0UIVjFPzYw5m2mTEzcvJxU1Mv1iP92uBmJUPWd6DXjUq64cwj2J7w8Qtem4rCgtsQDnTypCauTy+P1Zn0b7bntazQ6omgSBaaQfcmzQDGmHYOehTyXMK0xcJk1R3saaM0dheI5NZLio9BgzaleXNVtHwqFLl0GmkVbDIup1aIAxm1sLPwIjuwLADYTGjr3l7VjjFIrn1d0KlqeE5H0Giq+Mg67Wz+ML5tsKejnZELfApjMoM57OCS1lIhrPi/2xzBKWFJHi1yGL/D9KFC3krctLEwuG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(346002)(396003)(136003)(366004)(376002)(451199015)(53546011)(6916009)(66946007)(66556008)(4326008)(6486002)(66476007)(8676002)(2616005)(6512007)(44832011)(83380400001)(6666004)(5660300002)(8936002)(7416002)(26005)(186003)(41300700001)(2906002)(6506007)(38100700002)(316002)(478600001)(86362001)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgl7i9wJICa7Z/MgIaGPhEe21a7NfmPm6GN32tst5iuJQdhhfWgzzZekbYZ5?=
 =?us-ascii?Q?wuYpQPd/1hpiCNpPlsgxgNgfyXWlSgSiqIoxqgDwdswmqE6bvDS3Aorek4DA?=
 =?us-ascii?Q?+ExEDtDa33jrWZXGTNASJ/gGDBin5nWpYNbwtiPrRv9HYX5NnCvJk/VGz3Qp?=
 =?us-ascii?Q?J9zPJPDQVYhkqxgwQW6uyBkOIMHqxAPMw1pQPrSAIfqa+qPBQLlxmm8j1agW?=
 =?us-ascii?Q?bVvBimqoe3yzznxwG29ektoXScbWmLkVUlFiznZ3GdLrdZIJ8jerwJig5rSC?=
 =?us-ascii?Q?az8cCiCOZ1S+I1Cg+d+gz76tGPv/LWAVMXmDxwKUrPNoZZRggl6NCGccUw0D?=
 =?us-ascii?Q?EpRFWf1KHKttH/rbgTLfEDXmYoXQo4z10dAFDk0WefnuYcdcsZj3a1hy9WZV?=
 =?us-ascii?Q?f9AHqAYI4qS1dUc8pRyH6gIbD6H1pTx1onb6katClZyKFfKqS+bO1nhNSoOY?=
 =?us-ascii?Q?+b3W+rBvb5dj6L7kmMMaBAawI/P9mioFVens494kEfbugFjMOHJJCa95MqxB?=
 =?us-ascii?Q?GrwjTycp3LjqszJelcMDL+SDqqP+cB9GJrBTeSjsgyRGwH4mmbpQ8UrH65Xc?=
 =?us-ascii?Q?mE8wY/FOD8F6Lkk0Mq28Dgdxif/lEGp/8dLEFqE7QWkU0F62PQzkRQfjo+9K?=
 =?us-ascii?Q?GTXfrrB9tFFVoV2wHwZl2MpElWoEtBaMgWp5Z3nKa+5J2Q606sKPgoIr+12o?=
 =?us-ascii?Q?zOicbZ7MCkL6iohZ3atepEJdT13FnuX8asrHbIihQgAPegFt+1HakvCeXVh0?=
 =?us-ascii?Q?6M/XeSPwzV6Yncni7wh+Jo77tEeHCp4ecHEKZngsky+eq6hcozmuRzcJ8N+R?=
 =?us-ascii?Q?k22ftCwCbPs0/BXSL/ehjVEb0mj4aCNqUsPuWiqHuoJt44GNW+09xMDmKSOp?=
 =?us-ascii?Q?RyM6D4GD2o7V4VyUe8KePoD7ZqfsaGf+fnUN67GdZKUvu5c56mbWIxWa/c4o?=
 =?us-ascii?Q?DY90ZylJmy0zF6eWZ9Syf/fjkgZirOQBbDjrbOrHkmmNlpVOaN+Z25OHjiR/?=
 =?us-ascii?Q?hwaDt/1wV2Dpaeh+b15wb4Yc9SLYE7kLKqWLdKpd11BzFTDK5ijOM+7p6eY4?=
 =?us-ascii?Q?G/kKLal8L2+Mj984GKkj4ijN5HjU7fFz6fPfVXVH/IqF5vvRbxFliqBSHIwM?=
 =?us-ascii?Q?wheN3dezwyMk7AgeDgSQw560pYHRmCdNO8XcIFw5B0Cgaobmyi4be26nFjEk?=
 =?us-ascii?Q?G5/Y1kUAp3Su0eql7i2ETOInyc5knr10/n6dJrVSG9+MQaV50DerhXlEIZLM?=
 =?us-ascii?Q?PklniXslMoBGUPMF91PcH2F0Y6lYs1dVEiG5LXSh0iWBzZpmzHsVK3W5Mh9k?=
 =?us-ascii?Q?Bt8fHofPu8W2YGtSr/PeBsSoOi971KpTLGZF/Etfgmrd4YHkn3353V0gpDxZ?=
 =?us-ascii?Q?Z5xLeTNe+2L+/uyTst4DhT2H2s9cIthW/CXu8dxSjMAWSIiOg5Gw8mdl3U8I?=
 =?us-ascii?Q?p944KeEC0CsrOVCMuzwz3RNW9b34yHXEcOakD0qQCLq/u9QNh78dHB/eToEq?=
 =?us-ascii?Q?jwf3FjnNcws6M//4RtlsxcF+uGQDH7DfuR+JBBiRon46sD+kQMjsMYglk3Cz?=
 =?us-ascii?Q?QXPOOknJ5SvEiwdf3KmXMVxJw7NaKhDYrVXzhy79HGKZf/4pADaPFNQhGwQL?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61176214-2eb7-4a5c-f616-08dafdbb5b90
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 03:30:36.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WemQZvt8resj/XyV8MFpkzRh3PeyB7jy2+zY+OyPmiu7vD3bn560aofYNpVeasPMFG8SFEZ7a4BE/086SnuMF6VXrZmuBlkF9Q0VIzZq/0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 06:51:07PM -0800, Andrei Vagin wrote:
> On Sun, Jan 22, 2023 at 8:22 PM Gregory Price <gourry.memverge@gmail.com> wrote:
> <snip>
> >
> > +#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
> > +#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
> > +struct syscall_user_dispatch_config {
> > +       __u64 mode;
> > +       __s8 *selector;
> > +       __u64 offset;
> > +       __u64 len;
> > +       __u8 on_dispatch;
> 
> Sorry, I didn't notice this in the previous version. on_dispatch looks
> like an internal
> property and I don't see how we can stop a process with ptrace when on_dispatch
> is set to a non-zero value. I am not sure that we need to expose it to
> user-space.
> 
> Other than that, the patch looks good to me.
> 
> Thanks,
> Andrei

I tried tracing down the exit routes, but wasn't sure if there was a
no-return somewhere in the stack i hadn't accounted for, so i left it in
just in case.

I'll take one more look then i'll drop it before shipping out a v6.

May I add your Reviewed-by?

Thanks
~Gregory
