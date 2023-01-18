Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AA76728BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 20:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjARTtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 14:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARTtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:49:42 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF9589B6;
        Wed, 18 Jan 2023 11:49:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnvtqwsugXT1xK3v2lrpNkwY6w5DWx+xnOz5KxCo294VI8R7SDRWycrTknYJzLus+bbq3T5kVP1nQHgPfLvhxGMP9DWTqBTY3bwr5ipAdHgqre9qVUc4qS39p5kaaUX0OUf+OiiMkwWaCNwh9TLHuMYRE5eucw698pYtp+pZ23VCspPitbEa5erYbcEaEJwV6QwihR6uDwMZIpBOjGUCsozjLRpMwDXLdrBBgeFYTtVr8p7p6TLynjBRjuBaeCkRDYqA/f/OqtIC7sNPZ4RclmebutJ/yHvfoOcrSZ7fWXhiUFG2JR4j+fqxfhvHeOA6IgdvdCC/E9u9xgHyRHn93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GR7kaDUtecz2CnVtQpUfau8LwlRk9NTmbTmidaEDrQ=;
 b=B2uP1UDeAYx+XTcNFgdxoRCitfww7NjsmiFKBQKiucTlsUbnrWEk2r3oV/ICqFmRO32Xguh7ua+6XjS9jArZ6aGQvmZiuV+wr3UlxXF+d4LWkFNpw07/S7xJ74JutxMraTqIsPL0wORKAUFN1YVZcjiDBhX23AAYBqe7eIFiYCb7aFRbdPy485gb00Kiyg4oKWPuD2onIQO3Im+e6Jz4HuBaHbN8k2Y89RzdgtyvIEYXhrnCaQWQzdCdiCE1rOMAV2gOP8UViVOvz5eun1cjg/dIzOOj8RFLjmqZf0m/HdgFatX28Z3t70UzScVjVZc8lTdu8QFo7ELyjeSp9Q/VdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GR7kaDUtecz2CnVtQpUfau8LwlRk9NTmbTmidaEDrQ=;
 b=VX6cEAE4ugvkg0UKKR1H04lJQdI5AW7oWOKlBP8ziIAjcX5a6bemep+eJXmSHaZNpMqilDp/TjHX1/9Uer4KcMM9slDF/SAloSNLAvdKXVZvx1plK/s6j5e9svXd64OLWciOV6UfKsuLnX7yjbD/iL0uXmazo6siNO3v69m3ow0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB5072.namprd17.prod.outlook.com (2603:10b6:a03:3ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 19:49:38 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 19:49:38 +0000
Date:   Wed, 18 Jan 2023 14:49:31 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        adobriyan@gmail.com, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall User
 Dispatch Suspension
Message-ID: <Y8hNS4aCkkOLv1M/@memverge.com>
References: <20230109153348.5625-1-gregory.price@memverge.com>
 <20230109153348.5625-2-gregory.price@memverge.com>
 <Y8gpZ+T/re7mEDjB@hirez.programming.kicks-ass.net>
 <CAD3UvdSpOMAOUm1CYJ5vOyEsiVZCQdiWaTmXjq1vWVFq1DhQ0w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD3UvdSpOMAOUm1CYJ5vOyEsiVZCQdiWaTmXjq1vWVFq1DhQ0w@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::29) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: e04d6dea-a9b6-485d-ced0-08daf98d21b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEPWeLocyCSHsak4UsJt3577E2Tx071P2d94CQ5HTeKcvosGJUtffD7ZaWZ7KYXE7KjGc2dNqjmP2BokrxY7qo9gxqeC4lIkvpXEZ8NBLiQ1CbBq2CX+qcZyPT0iribN/1Pbnt9XSGMYo7O3mArzYuQk8RA0TrqPwG6R7U5tJ/JEPPUyzG7qU9XVKDWTIDdKxqc9//++kh3FynzLxHbaM280tO5py8Gx0QtM4d5S9Fcr07GmfwbxmWy1wgVCYwNFxGuDt+Or5P6RIfhCIis7MMkLb2PhLgSRuLlEkMrtQ1hql1YStXyIeqI58M/hf1UrACghkAnIdcIcF9lEwdcn/t+I/gMg3wY6ym47hmiX/L5JfF9Dbu/LAzOTy6cEkikFU86Odk7QaI22gcoD/KBhc/Pqy0M1AEkFFTKtKDDG9Pa+/XDsABh1nVDzgzga0bY6K3cA9K2+6bacGhLZSYw7EemGLB+VMCt40pBzrV4VEhJEJ+eyNU+Enest6A4xp5KkhKdHd+Knb/lcn3KxHI8AN7FkuzSDrmdmUcyRl1AipPVfTwPPZ+amKc4RStTJ06D1ukg7ZHLZeexxBnN1Z3AYBGpASC92NgRy34I1a+6RAJh9JCS4/c91NtM0XG2nuD0EIi0JYdPVDOO+e5QiNXia0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39840400004)(376002)(366004)(451199015)(2616005)(38100700002)(107886003)(6666004)(26005)(186003)(6512007)(478600001)(86362001)(6486002)(36756003)(83380400001)(41300700001)(5660300002)(53546011)(7416002)(6506007)(8936002)(6916009)(66476007)(8676002)(4326008)(66946007)(66556008)(44832011)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fqd3G1W7E41plgrC+CMghmTANMYzs3kWsUwvYis5lBhiEcREEVDt/2yprzuc?=
 =?us-ascii?Q?BOn9PpDPqRVCz52Kuv/JvKq0LjvHLM6YTtwbqNrexYmBwi4RJlT2pi9vLoj9?=
 =?us-ascii?Q?LkljVGdLifnBpeYLT0LhN39BAYHGDuzci/dw55sOeSZcWZh+PyumyRgzwUzh?=
 =?us-ascii?Q?5UDMRATmEXUdKf4FUiBqG3ml8kYO85Qu0aM7fw2BXSbzVANTN05qrACe+8mx?=
 =?us-ascii?Q?K2QKGFV1AuuOaHcJPEdQzf4h5r5F49q5U35bO9EqaqG+YNKSMVqf+xAbLs7j?=
 =?us-ascii?Q?bCmpcC3D9p1S44zAjVehydVOpOonUJ7mdQKwzZ1hAvV1+jlWUenJLdAwUzQy?=
 =?us-ascii?Q?3GjhgDewVbfuto6L5HHcz+QOm2ZOdM8yl70X2vzguS7WZ5vAF2/xo5ZlSzIi?=
 =?us-ascii?Q?ipgRzKARcgNP9PSfm/xnG0Alik6kZJVWMxogJ6wPaPeWp3Jxm13BbX7YnnqU?=
 =?us-ascii?Q?RvzKF4lLUlnTlWqBe90WcBiOwX+TT69A4opokymYTwPjfGdE3MbTYJPu39PS?=
 =?us-ascii?Q?/Do93mld4CXnFPNd0Ck5+lyh7W65W0mE93zfhBm00T+drdnEZgH6P3Ckp9Es?=
 =?us-ascii?Q?DbsIxYOhYTUSDWvUiKdxZcGFxg4BmcceRF2ZlTCaRCZ4XEFDu3tmsSJzn4Ry?=
 =?us-ascii?Q?VrYcD9hyljIB6QO/IcmxHX4Lf9YPA6I/whN/Q1Lm2iug/l4TBQvkizjtUT7b?=
 =?us-ascii?Q?aISYVOlbFUmKcdYCoHPBbbsowFGQXnYCxXRd8+uO9nCV8q6YojmYphS+CuA2?=
 =?us-ascii?Q?NCQpzCerz+EE7q2T98TA3TPFwqmqE9ao05sqV42sS+9KTCco/9jBEC/SDO7y?=
 =?us-ascii?Q?B59djeUA5yQEwh2iH+YDYOrtlgHKWhwOd5ZqDfNeq8HLMLyWZrUuku9UNkzz?=
 =?us-ascii?Q?JADFkK48qtaVrXi1EaQAYW4P8ygFGGQY23CqVthxcNQYdD4lghlqomuXNrTr?=
 =?us-ascii?Q?g+MrpfzBuHcFtnRqeMFLjTc4gQg72E5rM0p5a7hcFAxzvrwg5jCE4OPuPI8A?=
 =?us-ascii?Q?Omz2pxDKniCEGuQtb4BUdJCQ/IAGzDPpahOVpK8ZG2KFUfQTlrAQyoYBx+0r?=
 =?us-ascii?Q?JoNKHUG7v4c+Lz3DlF2kHnI6Io7uKSURhUkdVdvUOCYxyDDWZiPyev3svxrp?=
 =?us-ascii?Q?75IzHegukFhh1VDKVcFhM7uPLfTRjwkUkdqXDKOALsy1gNimIDjAFL+8F5R1?=
 =?us-ascii?Q?530d96K5TiX5Puy8GKBcSLXScVUDqMwuPIxDwpY5uPFBqdlUyxYku7Ave2T5?=
 =?us-ascii?Q?tJb/Rbfnb2W7BNsXQsBVUAp0RAqMBbBVmicTwA2ZK5Vb+VcmYGIw3gi5d1nW?=
 =?us-ascii?Q?IklMqSylw7DRGx4Sjx/ZqUDRNSvO4cnDXOXL/7Na1Mq6Di0LCm8f/uLC2E4n?=
 =?us-ascii?Q?scQOmp9NhYQAtKDw9GiLybtk5BmOu6JM2OTOnpEWdGXKsWkNUBHUk1j12EJO?=
 =?us-ascii?Q?gm/mIdorTT/TXx0+1VAzjLIV+MSlQLtAVxmBHDlwc71IsuVMGO9Miz01jIEZ?=
 =?us-ascii?Q?YaQVQCzNx/YBN+scXNotaHNzjMbsucLF7poXwxkSbV2CQ4ZG2Dh2EibD0Q1o?=
 =?us-ascii?Q?blB+SZLTAEDHhG5s5kwMz7pKcYewcBiZ17afx1RLl/++b1zSMVPxKthS57aS?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04d6dea-a9b6-485d-ced0-08daf98d21b7
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 19:49:37.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYG87N1XREfPv9hzkkoIrso5AF5LvSYyO5c9nlkHZOlC0gJpfQIagcovlkAZ3zG6ZYHJjOVCHjnFy0N93Hush3gh0NU8RzXfOJT+BbCFKCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5072
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:41:00PM -0500, Gregory Price wrote:
> ---------- Forwarded message ---------
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed, Jan 18, 2023 at 12:16 PM
> Subject: Re: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall
> User Dispatch Suspension
> To: Gregory Price <gourry.memverge@gmail.com>
> 
> 
> On Mon, Jan 09, 2023 at 10:33:46AM -0500, Gregory Price wrote:
> > @@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
> >       struct syscall_user_dispatch *sd = &current->syscall_dispatch;
> >       char state;
> >
> > +     if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
> > +                     unlikely(current->ptrace &
> PT_SUSPEND_SYSCALL_USER_DISPATCH))
> > +             return false;
> > +
> >       if (likely(instruction_pointer(regs) - sd->offset < sd->len))
> >               return false;
> >
> 
> So by making syscall_user_dispatch() return false, we'll make
> syscall_trace_enter() continue to handle things, and supposedly you want
> to land in ptrace_report_syscall_entry(), right?
>
> ... snip ...
> 
> Should setting this then not also depend on having
> SYSCALL_WORK_SYSCALL_TRACE set? Because without that, you get 'funny'
> things.

Hm, this is an interesting question.  My thoughts are that I want the
process to handle the syscall as-if syscall user dispatch was not
present at all, regardless of SYSCALL_TRACE.

This is because some software, like CRIU, actually injects syscalls to
run in the context of the software in an effort to collect resources.

So I actually *want* those 'funny' things to occur, because they're most
likely intentional.  I don't necessarily want to intercept system calls
that subsequently occur (although i might).

So if this feature required SYSCALL_TRACE, you would no longer be able
to inject system calls ala CRIU.

That's also my understanding of the SECCOMP_SUSPEND feature as well,
it's intended specifically to allow *otherwise disallowed* syscalls to
be injected into the process and SECCOMP bypassed. (in this case,
SECCOMP_SUSPEND requires root for exactly this reason).
