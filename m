Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5849354CDCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbiFOQIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiFOQIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:08:38 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20102.outbound.protection.outlook.com [40.107.2.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E61634B81;
        Wed, 15 Jun 2022 09:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If9M7/RhuWklr4vjuEkFAnwTkRDmCowtGQ2FkZ8yH6lUPMaVHKIB1Gnf7DIsOmoqe4+HeoLrHCDMaHypE7dhNXI+krGM5EmGT9j34MooF6RUvGPpGOdFMed5vntuWBxfiZZLeyVc8iHR+TjNnxePAbOXxnlDJ04yP1OKwFfVwBXsyusOqyPPMmANq3IU7y0kxNk+nsjwlmR3e7KTZaS5fSTruY1C6Ez/CpUBeXZDAlGUh367u5qyGV8zBHtBawM55ov3vb+kKFnrvx5r56Xqgcgd+N4/zxIA4TAYsdZrCdGq8vc1gUy2csAPBE9UnVW8rsRmt4M+cIi+scoW29nl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys0NpRN2knSTCyH29bEUxqDCa1J3tm0RcRiLNFgpY3I=;
 b=Hj3yunYgMqsOL6abJp30CrX01A5D2CNmqgiOPnyUY3WJg7T50BKVV+3Gr2E3p5NxA1iQmF98dGK5t3evdgXwN/uwEJxwMj4mEjO+E3DlUcvJzXIZMQlYIJyAIqEE0iGISyNDFCApJcD45pdfuDS/9kJEJDE64j+nmmZ0IRxMhO3R6WpkPyBK+P7735Lp2t5qQQJGCW2C01/LfxHItTallYoL4ibaHmHObNqBMnh0Pm49B5+73UPpmYAjjcMFm+VfRKKJdbgv6JNLcuLMZQLr4DDAq/kGGBzBthyDyS1o/7KinmZUorDjWlLzUTDJq5raqgx3XPI2YefnGouVgbENYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys0NpRN2knSTCyH29bEUxqDCa1J3tm0RcRiLNFgpY3I=;
 b=SbkG9pIaO6RQfzUR+0NsNU+g0Wndm4MbYl6g+FxuB5BrT86Q0QPReHY3GpW1R2giUeNbk3cbLNYf5uyEUnDvayL7Yp9+7U2ESPTn4DmIVWfzCNizQCbNuSoSP1X8LSDlaOL9hC/zk+Lsc3rLK2DiSYOmpKJwKyFnKrSud9ebVpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AM0PR08MB4340.eurprd08.prod.outlook.com (2603:10a6:208:139::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 16:08:30 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169%6]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 16:08:29 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: [PATCH v2 0/2] Introduce CABA helper process tree
Date:   Wed, 15 Jun 2022 19:08:17 +0300
Message-Id: <20220615160819.242520-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::45) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50ccedb2-774b-4da0-391d-08da4ee949a4
X-MS-TrafficTypeDiagnostic: AM0PR08MB4340:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB4340B1FBDC1A791EA9356B4AB7AD9@AM0PR08MB4340.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJ3tM9AG20OoGrX7GAqEqo/lAl4uN5/1ZBILAI7KwrRDIiVpMZ8tQ2RSfN0vvm+0z4ALlUlYSb0JJ30depFtgsgXgjmhmNe/qtR9ihDnFDicOuBIkGYQOoeegpY6XdD2pFPatgcbYlhML5EM3AGJOw098WW46I/QEEtMkzUH4ulMVpsBWJsQqCAM9U+Ah8FaZlRBGMWL0Ve+msSkwk3rhqCgNK17ewq1Rr0lQFWO68an76smg14GHMiZzawD3/v7jqWrBXlQ/UApQbH4UfF2mhFaygNgX/RM/GEisijyUh4G45uMc2dEODPDg+A/Uc6JNdUxd8zcnSXP8U5DABi85otTsDo7pplzIwoqUSOJkbdChQEadJNYRJc0NkvtY/SvV+H5NHUzqdne4dsAJ2jXES6jFntv3XOUcZfijsNP4t7chEV9a6CAQQEcXlvJByH9J8T/IvkgW3wmdPY5VjMkL4zxHZd228dDJ6PQVQirbYQwP3qKYXQXnw3lDLsuzJnE/K/uHd9MwQWP7zMqTIQNQf1LCijdgqNJKSz71feHn8bi1fycfgaiWqRHKBpGifMYAKosyw0Vqx3wzEx2gtFf3O6CqEStGfH+kcJeOBq/er3ywrfsrJPBbz9qsByihfHtRwfzpQ47ZACb50ePfOhL10QMn3btTGQhAtCvU1T/xV9nT7gUdj/qWdtj7HTnFvD8RcviDwwE7SORSZ21fqwGhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(83380400001)(38350700002)(186003)(2906002)(107886003)(1076003)(2616005)(66476007)(36756003)(38100700002)(8676002)(86362001)(66946007)(66556008)(6916009)(26005)(5660300002)(7416002)(316002)(6512007)(52116002)(6486002)(508600001)(6666004)(54906003)(4326008)(6506007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rV3wMYwX3Sd5dNlpzFzadGGzfUXjCGt9YJloXjiLY/qflKDF7ZW55GAAuKlO?=
 =?us-ascii?Q?6CgUEIog6fP78eKR7RFrwZ0vovheGx9jZ95lUBbgVAQVoskYA6EEbBOjg8mG?=
 =?us-ascii?Q?ZYCtOvLo/L0xzEfJxn4RmTdPKGberwVMB6g1J2IAkdlV8YRDtCRKCky0bq/W?=
 =?us-ascii?Q?+G0zjSlK7/GKvwI522vVCYqbOqVuse6ajvYPDDQPyRLDZQHTrHX/8c+4u9O9?=
 =?us-ascii?Q?L5ZXYz97+KnJgQM///aXgOAkrgrFaorDNdiVO3gOi12veoSmOlOBYAKNQJYJ?=
 =?us-ascii?Q?77kpN0GNaJb0VKLmSbgxIoMKKh0to3xLn7B7txRTiHKaHAz6GuKhhZWeSej4?=
 =?us-ascii?Q?tKNEA6DeyWsVtKeVpDSgnb1zEF9Yt1lzLbFLi5O/voV1nvpTH5hpDhKVyaBQ?=
 =?us-ascii?Q?PS3bYVx8O0JYIX8amPI5fqs8VwYT+Zt+xK3te4bbwiI9aPYF1plesU8isS5n?=
 =?us-ascii?Q?brVM1OlRbEA6ZU85ArGPTKQzDWZ/41ITOM2jYKeR3FcFGVzixakA+ZgC8MxF?=
 =?us-ascii?Q?Dpnr3vI/YXMb7P6xjrDltPxGp7eZyveUKA2+yNWmIEwehndlzrJmE5TC1ty8?=
 =?us-ascii?Q?ki7fRZgBQzK7EztHtxfQuG4GlfLEGrP2SHyb/Nho/HY6N0ohhdmb8w3YBGa1?=
 =?us-ascii?Q?dXoT7S2kM1J1BqfhEls8XKtrhqw4D/kl0L8dVp2j+ZrFrXccJzF9u6bRHcRg?=
 =?us-ascii?Q?4O32VTVEPjBLkGE2K+9aKkkHg8YUJ5ClWpNlaf8pyaI6FupbgJm7K1izFzAw?=
 =?us-ascii?Q?jP8HhRW5UGbnGKqvdh7gLyy2Po81RYHdO22tnlFJ4o059LZuW5/DMeOyi3Hp?=
 =?us-ascii?Q?JoiySiO5ddebo/09jFb03ySX2lYpi1CGa/TqghC+72zCNgVflQYPTesALW9v?=
 =?us-ascii?Q?7jRt7EFhpVXl651xq8KkiBLn9q2k18K/vaSND1b0CLQQSsyVOkLEyJ/jEYDC?=
 =?us-ascii?Q?F6w8R5Z3gI2m0gm4xpSnw1m+JjMubBP+XHq59i+Tilku3AYUzv6tnKp1YgGV?=
 =?us-ascii?Q?EmtQnzwTTrXkKXUIYJTjltWnBhys1OoNQX20GY7AAAyb8HKvqC69ybgxRFZR?=
 =?us-ascii?Q?SWIQFNaAlhplA09wygMjK7EWmKOXmF4PkQRE8h7UjxlUEbY2CxErqq+qQwPM?=
 =?us-ascii?Q?mvlg1pzHFfU0TFBvRbf6ZObhtzuf5Z/GdZmj/svmLwcwDxRLd0CMDJbGvP3J?=
 =?us-ascii?Q?FPBXffy/0dp+5tXVV5nRpZfFiEDEdFTu1YpE+1rZxf4mEepe0CXsNvQuymy9?=
 =?us-ascii?Q?oHnE7YEcig/3uF8EIIrLk9+64ah15je/LqGPwCeJGoozxWgp9R0eL/6tz94i?=
 =?us-ascii?Q?xvJWdMpF2MG6cTWneNRj5hC6C487k3o4CpD3rmeyVrGPRv5GE4Pb5D0X6Gfu?=
 =?us-ascii?Q?PZqgSbYQSPHZ8/az1BhhmP+2xvx0pft3lSOmlDNmXWtLwa+RDLqhWvty1Y+D?=
 =?us-ascii?Q?iRRUrt3SRnGvNFfm9qRdEpBJQaw9F+kMs7jisv7hq066bGXWGlSx7VI8y/85?=
 =?us-ascii?Q?F1VTPCln9CBPPfhx7efOB+3KK1md9zktYBK8qG7BJkCMgMwXNmmHJdwLSkle?=
 =?us-ascii?Q?qwIsMX4dk4Fu1igI5VLniYovkVYjSuvT0tC9cxwHJz80IxMpKjkGvQdeUc78?=
 =?us-ascii?Q?M6iafKhQ2+zAvc6c9kwl/trjEwEHGC50FGbkT6vo9KjR8WBUCkhx6iBZW59l?=
 =?us-ascii?Q?RJRKMLzK6IOUfP1oGo5DAW6Ram9KmX/aR1axgOCS2HAFafGzVRtlE/DckqF/?=
 =?us-ascii?Q?egaNtjJf9KFvf2cGy2OtCxePKIa2q5g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ccedb2-774b-4da0-391d-08da4ee949a4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 16:08:29.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsUkCU2yu68aQd7WvDroe3nOnN3MzTcz0+ndNK7vHMBIIDyWZg/79hM+6W2ohd26DkbDGF6rXxZsob4uxFT5Sm2rvJY92CQ1YlZkcDOO7mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please see "Add CABA tree to task_struct" for deeper explanation, and
"tests: Add CABA selftest" for a small test and an actual case for which
we might need CABA.

Probably the original problem of restoring process tree with complex
sessions can be resolved by allowing sessions copying, like we do for
process group, but I'm not sure if that would be too secure to do it,
and if there would not be another similar resource in future.

We can use CABA not only for CRIU for restoring processes, in normal
life when processes detach CABA will help to understand from which place
in process tree they were originally started from sshd/crond or
something else.

Hope my idea is not completely insane =)

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
 kernel/exit.c                            |  50 ++-
 kernel/fork.c                            |   4 +
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/caba/.gitignore  |   1 +
 tools/testing/selftests/caba/Makefile    |   7 +
 tools/testing/selftests/caba/caba_test.c | 501 +++++++++++++++++++++++
 tools/testing/selftests/caba/config      |   1 +
 12 files changed, 593 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/caba/.gitignore
 create mode 100644 tools/testing/selftests/caba/Makefile
 create mode 100644 tools/testing/selftests/caba/caba_test.c
 create mode 100644 tools/testing/selftests/caba/config

-- 
2.35.3

