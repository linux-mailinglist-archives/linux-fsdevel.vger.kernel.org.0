Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127F4675909
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 16:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjATPtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 10:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjATPtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:49:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDFF40D6;
        Fri, 20 Jan 2023 07:49:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbTP+nQEvaohSf7T03l2sf9+ZbF92BgNcJ6pKPdlBSz+DxZgaOygB69vXMLjM54VGBBnrnFKsjPw7Q9XClWhjE5CdFg0o/cZ4PVMPhDI/+kKUuIwwZ0ipBYg7vNUXapOTLmwm0z4MyYzlowKzahzTyRm4J9lt5UUJk+8w/uF56rrVBeZDiavj4njDqOZI9dOcPin5HNlq2VxHxREJrD+HhDMq6/O1jDh9Xz4H/YQt7KRLSQVXN0+yZspVz7NfbVkU3y0eFw8t3wraF0Src2me+SGythSq9bva7P/aqXyJoS5fZpzmKYlC7HqBngrzfMBwMUYTLQ7KUmD71874NPsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox5gPNccYTVX9688LOm3UjXMY74Vb3bUldiB4iGpee0=;
 b=OeOpckFdioslmlE9E5vawFjUJJfOt/Nj8XIQuvqV1g6VkLT/BFfSKAsQm+qoLcuTLjABoGyu4xd3HunkdiSz/1CI9Ol6/FOT29Rd/MQvwAWPaeWeYS5WZqF9KWlUpIeQ7agRu1A2OXXLAiYCLdzbTyZjYMf5fzcczJTIt3fTQ3dwQhErkY1qLvEeSAzUBJBlxnFp/8AB6V4DJ3T5zcBmVjLzauDO3otd1FGNvbw/pqtwx5SD8j8ExBcXv7h6TylAXa3Ha3ETIVsvqpOxFVRfhM7ElQ3eOCIaISls24TsKx/MXh88QPnFmjlBGbpmKtf6/Y2qW/zZ+HGHvrkqCpeJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox5gPNccYTVX9688LOm3UjXMY74Vb3bUldiB4iGpee0=;
 b=fbRnovgeZiP9OsTjzq+PTAXb8RR/QsWJGbQ+lSBk8poOOmn2CWl+zdaNUFgNhXnmMJwbpE5oJ+9/hdlm4q385e2UEMPtiMh8a0XJ0gdkMJBvax71ZfV4JOtBNaSC8rqkbwUisKIcX47iJnNbuGfJPTsKQkZ7YwL1ZgbTAC0mrC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH7PR17MB6471.namprd17.prod.outlook.com (2603:10b6:510:2a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Fri, 20 Jan
 2023 15:49:16 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 15:49:16 +0000
Date:   Fri, 20 Jan 2023 10:49:10 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v3 1/3] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
Message-ID: <Y8q3B2dadHwEHthv@memverge.com>
References: <20230120144356.40717-1-gregory.price@memverge.com>
 <20230120144356.40717-2-gregory.price@memverge.com>
 <20230120152250.GA9801@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120152250.GA9801@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:332::17) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH7PR17MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fff7b5-1be4-4cf2-5afd-08dafafde255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDMJnenGg4QjGA2g5cmgYnLibMWJVm2siLw4g7wxNPrLpDHYh0OhVsBF8S0nH42DVEO8YFITxT/FkhFpDleaxsnJ7Vu8ayDkhfB5RRDz7rFLiPQ35X9IA6obBwbok5lhRrpxcB9Iq6ffXzVcvb9q3PMW5LiGDziekELmiYug//AA6ksNOBr+qyS3JdrND0LYqA2RKH5dANchefHhsA1dXdeSJc0h5HDwdspA0WR/AKCpxyk1Jv4uya1UgOSsCbfzS/7Zt05qW+HThfIxdxI8TN27Gx47qoEmZ22SqQ8R7XsdczBV9TlZIyPpYXtuND2I3LQLf1G9aovHE5D+wLRPp6fSb3BScNZWjDdCZhm7WRasV1zQ4i2KdA1U/JjdmAwDbU8ulZV1pA/0IqKYkK6PwODG8YqopHKPjTvkgwBK5cuQ0R+V8rSbKTX7JtEbNTN5LSzge8WwVRFDbkSM5SjSfWoNnOW4Xck2Lj99hMvHjoi3WghpGP/eDnbbPEe2iwGEfBYE8lOzNzU0GuTj2lf4yUh7vxrSsLC3V+936O/vIWMK0cZZby5iHM7+R3mUFVd4/1RHN0cM3ooBwdj0rnlKKuzKYRiqpyo1xsyfYgeqQ6YJ1vWVhAOusTJERD028eKj8fORPCTLih3n0kBVQ9UKetTBRTvofQzDwDgntEq4Mr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39840400004)(376002)(346002)(451199015)(186003)(38100700002)(316002)(8936002)(36756003)(83380400001)(5660300002)(66556008)(66946007)(66476007)(7416002)(2616005)(4326008)(8676002)(6916009)(44832011)(86362001)(26005)(6512007)(6486002)(2906002)(966005)(6666004)(478600001)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFi+bOHUM1N6Eeyk6peYRaG16yLfTS6lmgHUoLoweJoQ27j0Lrk2D8dT6jMQ?=
 =?us-ascii?Q?sOLMVvQ9aEZ4UubFjNI1UQz9rBp/xuOzSOEYfsX34V3bUSs3NNEzn2FV4jhj?=
 =?us-ascii?Q?jgUoKVu7uAL4MAwhgdAgDTscwQ9DjDtC4drS7EkPGBsOB2huZyKsZYbq8WxX?=
 =?us-ascii?Q?o0r9kUH8bN+GnvwODtZ6nV4hXpQY9wIyFBKH4cCLV8t64UFh/IRAKW/ckG3u?=
 =?us-ascii?Q?Y3s6Kf9GY8tU5RRc9YYScWPRzjM602dTUj8LgX/y3XOA84BMLzwx2s+XZFHd?=
 =?us-ascii?Q?RcLBF42zGIguTRVYSyVqoVjUDO09YeMnepSdOxIQn8luqEXe27jTRYX0fTNl?=
 =?us-ascii?Q?5B2dN9kYc9vrJ1JeST6l7FWrDG1rtkJ4SJtstNBe3SmLH0KBOy5ZfT9Y8+OX?=
 =?us-ascii?Q?YbbSAfDWohPCvIM3DVMegJlu6IdAsL4OXS1jKjc2rBb5CqbU7wJADvhOAeWq?=
 =?us-ascii?Q?pfN1vC6lzlOUXF7LTVQwTqg2QjGS4ke659Hi6kj1EG2lqVwWAy3LxQ94xLxk?=
 =?us-ascii?Q?bOuA0YJHYLtLeOWvGOIKY1yJ0l1CPkmbisl3p6wL4sTPBixn34IQUV/gf0pv?=
 =?us-ascii?Q?lWipWY0QT4YpuKkWLIG0UUJjb+5O+GMakrn4cJ66FWX2oZKXphsypdOx1Hhx?=
 =?us-ascii?Q?435ykYVrkLq4QYmEbsELLus5MtTwRaTuzlH3ZRE7PE6OTPZ0N/q5shYgU16Y?=
 =?us-ascii?Q?/eoslMvBdHcjt6B3G4wCSc8VWGMFJnqJD5BEiqJ4CT/5Dkx7q/8pnSHQRvJU?=
 =?us-ascii?Q?av0oyE2jCcsLz8vq5kCWdmrQ37H3qIANd5w8N69pS168Z1Ab2lLjt4tgx6xX?=
 =?us-ascii?Q?IPIqDk9vcekIVQ6VX2RdJCnymTJE1YAASO185aFw+eDpp0B6SFZNbCxfVxAZ?=
 =?us-ascii?Q?AU34gsG75thEQiNxKqykXfqtj0RvIQNj8urr7V3qeEooW7qwGc2lo4N57Q3A?=
 =?us-ascii?Q?udgoWmRBBVzTpldzEQh3levLF44uzcGwS5yK7qUQM4IOGq10wSeCzJ/SFvuW?=
 =?us-ascii?Q?QVoHok/hWjU+gE4rp8quGjMV8XtuY8ilgKycglTgUWzDVNvQPiqofsETato0?=
 =?us-ascii?Q?zKzIEa4yR2oJucN+THoUCjMwFTm7IqELgEB/u1FEzuZisDegsCzIxtXyViLx?=
 =?us-ascii?Q?gH7WEl7qYIToWPdvxScA12m/AD8GpxEchsapnIVj2llYXlkjDin24T1nqkfd?=
 =?us-ascii?Q?d3pHKor1UTJHsZGauyhRuyT3lkMr+xk8FXpqvLqb8ToAbTQmAQKSWMDna7TJ?=
 =?us-ascii?Q?KyhwqPNGa8qd6y++3Nbp9F394N2umEXjVlV3TdutpbB0OfEjnVYkx/C3a6sC?=
 =?us-ascii?Q?lNm9qtusqQWPsevyESkprHUMKrk/+mpaUadYVkh9dXr5GW5yRQSzvtQGex52?=
 =?us-ascii?Q?coeeZv588FlXAlrMr3RZ8xeNBqVshrFH6VhOpvx5z3dmwjVlxAdOvjHd4VcQ?=
 =?us-ascii?Q?HIiprqTWj6kuDeEPdd0lfVB682dS0ZVDWYOfOrTW5Qk6f/UWenhrrBIQa4ii?=
 =?us-ascii?Q?P4JUdZ06o569rroKAQXOp25iF24ylj0cZpUnwWbAFnimHf1YtwqNs+2WFBOL?=
 =?us-ascii?Q?IRFeYnLvIROR7fqhWb79ReIVtagvbQAkZx3ErqYQtJAKSNziECqMb6L4mJD8?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fff7b5-1be4-4cf2-5afd-08dafafde255
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 15:49:15.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We+Lkp8svK5hfZxiPH39NYq9TiJL9k20SJceucH/JiBoy/ykpsa9Z63UcTuBVFjVZe2ffTCRAK3/w4+2gnLpsQac3+Q5Wj3JoYWDkaFn9/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB6471
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 04:22:51PM +0100, Oleg Nesterov wrote:
> Hi Gregory,
> 
> I'll try to read this series next Monday, I need to recall what does
> syscall-user-dispatch actually do ;)
> 
> just one question for now,
> 
> On 01/20, Gregory Price wrote:
> >
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -370,6 +370,10 @@ static int check_ptrace_options(unsigned long data)
> >  	if (data & ~(unsigned long)PTRACE_O_MASK)
> >  		return -EINVAL;
> >  
> > +	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH) &&
> > +	    (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART)))
> > +			return -EINVAL;
> 
> Hmm? git grep CHECKPOINT_RESTART shows nothing.
> 
> Oleg.
>

TIL the mailing lists don't like responses from proxy addresses.
Resending response to it goes out to everyone


Good catch, I always mixup RESTART/RESTORE.  This should be RESTORE
Adjusted patch below, will send a v4 tomorrow so as not to spam the
lists.  Attached an updated patch for the time being.



(brief syscall user dispatch overview)

syscall-user-dispatch is relatively simple, the goal is to implement
syscall interposition for foreign syscalls (windows, non-posix,
whatever).  Since the ABI of these syscalls can't be trusted to be
anything like linux, syscall dispatch produces a SIGSYS before anything
else can do things like check register values.

How to use

1) User registers a SIGSYS signal handler
2) User does
   prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON,
	       <address>, <length>, char* selector)

3) All 'syscall' instructions *outside* the virtual address range
   (address, address+length) now produce a SIGSYS on the thread that
	 executed the syscall.

   <selector> can be set to SYSCALL_DISPATCH_FILTER_ALLOW or 
	 SYSCALL_DISPATCH_FILTER_BLOCK to enable/disable this signal
	 production from userland without having to make kernel calls.

docs: https://docs.kernel.org/admin-guide/syscall-user-dispatch.html


Updated patch


diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index eaaef3ffec22..461ae5c99d57 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -45,6 +45,8 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,

 #define PT_EXITKILL            (PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
 #define PT_SUSPEND_SECCOMP     (PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
+#define PT_SUSPEND_SYSCALL_USER_DISPATCH \
+       (PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH << PT_OPT_FLAG_SHIFT)

 extern long arch_ptrace(struct task_struct *child, long request,
                        unsigned long addr, unsigned long data);
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..ba9e3f19a22c 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -146,9 +146,13 @@ struct ptrace_rseq_configuration {
 /* eventless options */
 #define PTRACE_O_EXITKILL              (1 << 20)
 #define PTRACE_O_SUSPEND_SECCOMP       (1 << 21)
+#define PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH (1 << 22)

 #define PTRACE_O_MASK          (\
-       0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
+       0x000000ff | \
+       PTRACE_O_EXITKILL | \
+       PTRACE_O_SUSPEND_SECCOMP | \
+       PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)

 #include <asm/ptrace.h>

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..b5ec75164805 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/signal.h>
 #include <linux/elf.h>
+#include <linux/ptrace.h>

 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
@@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
        struct syscall_user_dispatch *sd = &current->syscall_dispatch;
        char state;

+       if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
+           unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
+               return false;
+
        if (likely(instruction_pointer(regs) - sd->offset < sd->len))
                return false;

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..a348b68d07a2 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -370,6 +370,10 @@ static int check_ptrace_options(unsigned long data)
        if (data & ~(unsigned long)PTRACE_O_MASK)
                return -EINVAL;

+       if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH) &&
+           (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE)))
+                       return -EINVAL;
+
        if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
                if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
                    !IS_ENABLED(CONFIG_SECCOMP))
