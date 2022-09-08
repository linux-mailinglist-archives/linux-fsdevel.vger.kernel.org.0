Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5E5B2010
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiIHODz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 10:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiIHODe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:03:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80092.outbound.protection.outlook.com [40.107.8.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2221838B;
        Thu,  8 Sep 2022 07:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSaHqSsCgNkv9j23PYPNOnq/zPscKKIvpTU0r+Cn31YGsx4rLVlJc+P6/AGofnslEUGwtJprJClZjZxO2RKit3ooyuAmmlaw6pc5oLqGdhKQqTqVeTZ1d9jSxXt4zp6tNrwqgO6twPyS0vn1VU6P4QFJJ+U0a7P0D8BEM5xJm9qUja8H1BDX8gpdBqGgWty1YVKNs55Oe0LmHjqM+HNcnGyEVz/PzaoJPKyZORn32ZwORIcS+had1CXpoqxNrx8344XxZ33GTOZncOJeRkxtiY9f7WG20pB2FY7Hqg/5tBgPkHICa35kdWYq0xsKvl1u26LkVQJl1eRw2NTSlj2lFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDah6bUSEtLU5j2CBLB2EvDLlFSFZCrHDvlGvHVIXqY=;
 b=RLVtV6umqN7qlOFGpwySIbdaoswCvmQGkCBYKE6iPmgPJMB52KSfhpBj8bMZnM9R6+Bcz7HNSU4bM8JF7RmZ2cQcUgRAOJLABHBImhh3WSsDFgN2qAM40oOgS2+5kwjY5Mhdw+8pX2cr5QN/uJfUiYLufGdJCp5Hq0lmCclCDzA5cFZNRD4lcMgg+FpePgx9EyCCe1eTSlG+9DXweRX0NcBIhE0PnuUx4Xj/CfWgzIGVKnK2hp46Af5GgSTVmzbZyWQz9utCZF7M0nyf6zvXppTl3SGFEeXV8gsGj2N2MWdnswS4UfwsBRwxi7/uyEWMoeyxbJZVQ0LHnb/OY1wjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDah6bUSEtLU5j2CBLB2EvDLlFSFZCrHDvlGvHVIXqY=;
 b=NFE24JpH2B5Rk61K1eDGn0OoYE3ik7JEKAJ6CLvUUiDFZqcBdkEjwMdtC+K1LVBE6GClq3OReqkG2tjtM4xlZ2CI5ssUcKhE2W7tn5+nCUJJP9qyABEHkamrjNREjH8Vb+Oec5rwAVVkV8RO6ZXwqMx0KQbAqY+pBDsBQpx84sSCo+HLO95f3njKUpl9Vs1PG2NW9zwbeqhQ/IZG+l/wL0h08df41SFpH3C8zDkINdiegKPJRrDFwhak5EoMsqPNxPQ3qI+GUhfaFWWOgtO08rf+CGIRHk2/xuZU+A7njBRSpGReONVW5ajIzIJvnREVsP8v7B6Umbhwe8zrcHCWgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 14:03:25 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 14:03:25 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kernel@openvz.org
Subject: [PATCH v3 0/2] Introduce CABA helper process tree
Date:   Thu,  8 Sep 2022 17:03:11 +0300
Message-Id: <20220908140313.313020-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|AS8PR08MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab4ca98-3cb5-4756-c8ed-08da91a2e599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0691gsT5ld7VOzffepxDDgRE8gJ5qQe4jeuT7TpqbgGz2Wgwo60vMxq6Uf8n+SwNFFnrAHpPM1KfhwWfuoEYUAyK7UAv+BmObPls38hxG+W+5PbDb7VtwhLASRAN/PJUaR19XSFT2RO/8/rR5wjsljKVGeQBwLOFyw7mVuf5EXLS6/lyC6WfUl73TsMGDrYYs2lfwgEt5cwCWb4Se6CQ/BdqoCGV5wyxeuqtjRj2SIQlvj6d+xpW/1uxUmmXX8+4nEJQyTTNISXWZT4BJuZQQ5jTrDvXqHqXNSHTb0dKqYPTrLoOj2OoASsO87Z1Gqp6tsGEJe+mKlYwe7knziLdc0dXoUjF7Tz/sI3ENOYAkLGybK8LhC0tdMHe9PDi3ypIl4xrDis83+gSapOwtcDB0wEykh4Zw06ES/lAPubbwWfh8tCqBhKZ/i6gTANRzwVRLZCAJFAbdMxqdNgN22bF5AMOwi8EMBI8mNplDRE25dvpWAGC76toY0iMreL0VPj9UrAa8SxGhuLmG2e52OOrZMzopmjjFJz+wjrk3KqdRgI2tPFq4kByoJ0SB+E1A2WjlO5f29k+H96bnvc6t9ZWPBkJuEPagvDAvVJv/I6QycgCncUg7nUYClMnuhEPbp1h0hhHRJ7t/iObafKfDprTGkTkLFr2sNYyxsSZ3mL78y4/c0a7QNyqOFWVtEnuz8m93UN73MqCTnRbQlufG8KCZuRqLWj1B2bcp+2Bs4YRjvnNX4tdVpN/A2xOo6VrYkPxFRQbsOhqL8nPXiR+J85HfYF8w8yIsah/Ga4JpccPzaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39850400004)(346002)(396003)(376002)(366004)(54906003)(110136005)(316002)(4326008)(66476007)(5660300002)(8676002)(66556008)(2906002)(8936002)(66946007)(7416002)(36756003)(966005)(478600001)(6486002)(6512007)(41300700001)(186003)(6506007)(2616005)(1076003)(86362001)(107886003)(83380400001)(26005)(52116002)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e1OCNj7MUKBWOoXxfsYzzQpLQN+wuYOKewP8RFM99LENET74hXnKm1QmjH2E?=
 =?us-ascii?Q?dc1z2HG8Kqk/qnYNqlP2PUM4ETYqe4wPqNb1eQbs9Kb9VO4fv5J4ifvNAiYK?=
 =?us-ascii?Q?08UuQ3UqpNC6dRvLnjsYAyYaw9pBxYOYUfGsra+1GtG739GAwo0RE/BxkM42?=
 =?us-ascii?Q?KO5UwK/Rr8Q5BP5NF7c2DDCgIVKigi68BMdSPWx30EjDaVtICVMeSrm6NdcX?=
 =?us-ascii?Q?1AeVoMPLB6aV7ka9jDAXmJEW5suD4w3wugtUVIh1Dv1II5g8shRrg+MYGiI3?=
 =?us-ascii?Q?3z+RkAdBs8BuPSbsfzd3JmoRbPJg1YhanrO2qJ0qfRCReJ/UTuLHxh614655?=
 =?us-ascii?Q?8uWk56Oz9B19MUUbRo5z3j2nkU2YMVCQyiuxW+MQyhwPXlNqtg51y7sFszyD?=
 =?us-ascii?Q?JiV8NZqjdIYBuQSPg20xwRN0EbmchdWamAexQNNLtzHzWFneokM7o5RKfbGl?=
 =?us-ascii?Q?InAbx4Ry8Mk0Bm50u+FDIwAGJ6mBLbd8N3YC9KKrPFE+yuHu9e58INlPdEmM?=
 =?us-ascii?Q?PB+cz7pV5f9lYYQN76vbFX4IoXFRIB8/r++0rhaHTiqHpixG7jI0Zo+ym6Zu?=
 =?us-ascii?Q?5kNBdgmsRxebYizMgMPZjoJvV2mBy+1/E2QIUMniPTSFqY7lSN7Q30Dx4LnU?=
 =?us-ascii?Q?KQS6nWic4qIYNx/RmDPTKR20fDjum6r1JUJ7LkCNZ9orpspHl/HZZ706F+zA?=
 =?us-ascii?Q?lEkUj+mDOjgItmeu9HzI3Lm9vj4+KRf4yK0dSy3p/ZaNPB/LbrtzBJDVyKXO?=
 =?us-ascii?Q?wJgUtcCBd/Z8Jv/prc3vpHmSCURDo3eVJ2BCaZojF/2MfbLgl/9Wgjy8oQqE?=
 =?us-ascii?Q?UzA1jpYO8yFuLDPhWck1N9a8L6UQpHxn8vPrLqiKmml9o42kEig0390U4Vu0?=
 =?us-ascii?Q?hhhuMi+1T0U6hHwUHuqatvcqKxHaWmlWW08J9Au6P9l97+FSzaiDb8byrsuP?=
 =?us-ascii?Q?8QV0EEeEelz0jp66LNc9fBaoMlr8n25+/9qoeLKQofvGSfuPUZd8p3nJAZpg?=
 =?us-ascii?Q?QcwKPFK3j3gNUYVC+erqeAWO0rATbTzcvAJ5MYRh6RDcI4wfcZy3rZPNS1t3?=
 =?us-ascii?Q?KfNHRcAJrdjxIDuHXdEZg3VU6x79obcJ+395NNlaOz5iYdjzmV/Ve8ON/RtD?=
 =?us-ascii?Q?+vSWkBnCF87aDDzcwJSdhEsetNL5StsvXh2S1H3Yv+B0FlN5gI6XxiByAnLj?=
 =?us-ascii?Q?PVJNwfrZAgaSYpPSi5lSp6k1YTx8zgTa7FoM0xnErwr9RvlIv61ZLVmIYiIG?=
 =?us-ascii?Q?9rnol0iPhS1+TWaXzKcHdfaGY9lCKNH50bHIY8R15CdjXC/JY2xI4ruYARXU?=
 =?us-ascii?Q?uSPzGKm8s3NAP2XnT4wWNZrXqorlmjcllmFoiqMKVBXPzuspfKSocio58FdR?=
 =?us-ascii?Q?6VKlhVAz1nNq2rT0R/U9YARbHwsfZDrPWxyZ7EkUE+SONLCvY6IVdCx3pwXk?=
 =?us-ascii?Q?CYA2vFGNP4CV+n5shMJTzgM29c4jaIf0jUwfShqyBLQ/qwlypurLGVqnkg0o?=
 =?us-ascii?Q?UQWkEOga6LCCworQ2kM0Am+ppyD/MVooV9E9OZetlXsnrqbN0do3nul7/FN6?=
 =?us-ascii?Q?p28jdrJui5mY4nv6Z+qBAmq2KNxPi69vvfyfn3Y5/Pms23muX9kOQmGmxv8b?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab4ca98-3cb5-4756-c8ed-08da91a2e599
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 14:03:25.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2UqQLgKWLmow9x2ClCYvAGhceUMKP3+p+PFlCkRh0Q++moS8yR5fnYPsPNEr7BdDMqiHQ4ZlWEMzmzWRpuudhcMfxV0eykUBo4VpYB0fW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CABA = Closest Alive Born Ancestor

In Linux process tree we reparent children of a dying process to the
reaper, thus loosing information in which subtree the child was
originally born. This information can be useful to CRIU to restore
process trees right.

The idea of CABA tree is to keep reference to the closest "born"
ancestor in the process tree. In simple case if our "born" parent dies
(completely unhashed) CABA would then point to its "born" parent - our
"born" grand-parent. So CABA is always referencing closest "born"
(grand-)*parent in available processes.

Please see "Add CABA tree to task_struct" for deeper explanation, and
"tests: Add CABA selftest" for a small test and an actual example for
which we might need CABA.

Probably the original problem of restoring process tree with complex
sessions can be resolved by allowing sessions copying, like we do for
process group, but I'm not sure if that would be too secure to do it,
and if there would not be another similar resource in future. So I
prefere CABA.

Also we can use CABA not only for CRIU for restoring processes, but in
normal life when processes detach CABA will help to understand from
which place in process tree they were originally started from sshd/crond
or something else.

Hope my idea is not completely insane =)

I plan to have a talk on LPC 2022 about it https://lpc.events/event/16/contributions/1241/

CC: Eric Biederman <ebiederm@xmission.com>
CC: Kees Cook <keescook@chromium.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>
CC: Valentin Schneider <vschneid@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-mm@kvack.org
CC: linux-fsdevel@vger.kernel.org
CC: kernel@openvz.org

Pavel Tikhomirov (2):
  Add CABA tree to task_struct
  tests: Add CABA selftest

 arch/ia64/kernel/mca.c                   |   3 +
 fs/exec.c                                |   1 +
 fs/proc/array.c                          |  20 +
 include/linux/sched.h                    |   7 +
 init/init_task.c                         |   3 +
 kernel/exit.c                            |  21 +
 kernel/fork.c                            |   4 +
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/caba/.gitignore  |   1 +
 tools/testing/selftests/caba/Makefile    |   7 +
 tools/testing/selftests/caba/caba_test.c | 509 +++++++++++++++++++++++
 tools/testing/selftests/caba/config      |   1 +
 12 files changed, 578 insertions(+)
 create mode 100644 tools/testing/selftests/caba/.gitignore
 create mode 100644 tools/testing/selftests/caba/Makefile
 create mode 100644 tools/testing/selftests/caba/caba_test.c
 create mode 100644 tools/testing/selftests/caba/config

-- 
2.37.1

