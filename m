Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC68B546A6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346537AbiFJQdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 12:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345920AbiFJQc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:32:56 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10118.outbound.protection.outlook.com [40.107.1.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3680956B16;
        Fri, 10 Jun 2022 09:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PulJZIJpKadWKOHsKRPodYs+c8lk+onJpdSO6Ey6Tpxw3l91D9vHV/LrqRaOiszZU5ZHzxviE2ttRV9IIHhCHPVnd2w47Kb8jBO4zObtJ7PVlvDdMMSp3+cMQHkfcahRdG8ZN3AvBCpG/CmVTHyjANKBd5eHOy01uzV/0DUiEf6J6veziuUbENt3wlWeKNbZHLWXWV+6RKVzi6zt/czWkCOD2Sj9zNeCt0hCW83iRNGb8f+q8GSGMzd8mAM3WKNwJietAkYT1B8cfo7L8rl5IJ6m4Mpw2ORf5dKxsK9wJf3jjTnpKa9O9OOq+hwiB98X2DEx+koPpE256BRiMgEnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxcAlfX9/qBnWuu1nzSxHGGALefsm8vElrEaRyz2d+8=;
 b=j/R3VYBlifjbK4immnZwJjGXRR7ri6ZXuZqtKce6aonK2zAJivaXZnxYVqcI5anlfij6s/n1seb7d7R9lnM5R9zE58+FtkrWjUTCevK7kEMjuf3vJyS6AZsCSpIjziegc/LWNzu94YoOCXww2gVETNML/GB9hPKJnjEwVexy4IFmfAVHa/sND6gdy5ZibXIJ2ySTmkDIc1gmN/oCnHwkAM5AR/G2H6zJZi+cok2fMHWSSm9TvJkgxK+EjzUqIu4gPjc9Isdbg5MEXcf+uYpInkTMylBoOWKcGQQdIcfD5jUEQmTrTTSaBbtSn5AbV1DTevt/Tepczd7TTAHOSak19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxcAlfX9/qBnWuu1nzSxHGGALefsm8vElrEaRyz2d+8=;
 b=IkbYUiEHMRMWhx0R195N9DwIuopgQePTfIjvqmTrHuvZhm66ClMJErfPiPeLgqJA68Mee5LJ0Q/IVa1UF4cvy0gEAxZ8RYMDi8JySgcddb3bAfSkV8ldvXaVh7pQLuAszuz4Svl6UKxJ01B5U3VSXvWjCbcKGtkIDSMYL4+VyIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AM9PR08MB6180.eurprd08.prod.outlook.com (2603:10a6:20b:2d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 16:32:52 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 16:32:52 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
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
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Introduce CABA helper process tree
Date:   Fri, 10 Jun 2022 19:32:12 +0300
Message-Id: <20220610163214.49974-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::24) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45803fd5-6d0e-4604-188c-08da4afedd81
X-MS-TrafficTypeDiagnostic: AM9PR08MB6180:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB6180D179AD5853C100EAD248B7A69@AM9PR08MB6180.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXTUJ0CB+WjMBFfEIp9LjgSkDuQubvdCknzdKvzyzGuwteUXA9xI9WuPSOUJEJ4LtCcSP8idqiXcF6D2K4ThGb/5qiE2hY8EutbKFIqUwV/hRxvolj6bKiw7difQJo6JfiTiVqyRszednU/PSTzrqQw0Xxdj6jnunqg/Da7+Oy3hybjp1vE4A2uk1xw246Z8GsUTqT1aXWvQLLJz7ond7Rzr3tXToBqoHxMuBfY5KH9n5eWwpdXzR9Eamx6FViFqV/wNp9DL0sY5tQHrkGb60KxrhLvOsesP65AaNJW5GLr2gVBXUOpgbPdd9sNsRiExheggPAYdSgC+vqMRZhaoy+t6dxFOcVNJ1i3hh9W51XRF+Qmzm6Rd10G9bx86PM354amGpLzxhEWGAMEdbFSjw8zr4yws0Dn8J8iP9d8eWR/5McJwPo4dA0FgZG3Iqt/pM3Fqc+UReXMe+dGkIhZOA2UmCR0UxiAdmGPUmqVOt4piXSl/efIv+HzmryHNQPoFl/1EZA8NShtA1n69me/Pxlkt2duQEyfSfBJMvxM3Sos9PCAu1fvTwLa2PrLuQBG8SBUGu2W3Tt7SCetbsM4+/d9cAIY85tqY/VWgk5e1qugWcCDGw2LGEtlJ2Gee25A5T9ejfpw/ilxTxwXfd1FT1nuatAKHEQQNn2tvsmQlM8E34plEYtT0R7qG/aVNq2en+xXdhUi9Wh9albBCUzKN2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6916009)(54906003)(38350700002)(38100700002)(8936002)(4326008)(2906002)(5660300002)(66946007)(7416002)(66556008)(66476007)(8676002)(83380400001)(52116002)(6666004)(1076003)(6506007)(186003)(6512007)(26005)(6486002)(508600001)(36756003)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/U8SOwr8KKF31ySEhEYzojP1JBd5Si7SVLewoDNtZ1fprZb/i/3GJRYBHvI?=
 =?us-ascii?Q?V0JVB3JI41euEaDmmtRTpC+ff1MUQv4ilUItnKu6rMnvRAgP04BsNy67poo4?=
 =?us-ascii?Q?QxvP5qHH8I4rjYPCDPqlHqyY/CUuo+cWSGHsWrxIfS/pdPVnFXEd4w45NFIs?=
 =?us-ascii?Q?QXYZp+tqsEeioMQ2bnUg7vvZ28B/rlI4p0ESPY2v51jSdbREX9Vg6aMt2Q4R?=
 =?us-ascii?Q?HoZWSfJVH0VmshUTdKfAR/xuQPB679Dc1X36neoW6Qw0t+2LHeaOeErcWwD/?=
 =?us-ascii?Q?CLZjyCpjTBtwvI704Ed/C5G8BluQYyM4tXUhLsHt5+woKZf53TXavKEuhvbA?=
 =?us-ascii?Q?Lt+J6g3oUVgdEQr7Wj7fBQpZzjP3odGnh+dvZgcHxLW/5RK0U695bbXSwP4b?=
 =?us-ascii?Q?kG4pI//rFAKnITw7B3dKscN8wc8gOiia9Dci2El/0slbc4sfuk+BVKfg4e3A?=
 =?us-ascii?Q?n9Dw6oPinkUvW4t6GzGk11Xzp0EXNXcPMvhIWCzTA5OLYeeBpZQrQyG0RVL0?=
 =?us-ascii?Q?fqYXAoNW0Oe+Jg9AOQ1EWmqPUOYIPEVJLdTrP7bZ7e3ROThXdy2QU0r8IRwA?=
 =?us-ascii?Q?eO6VO4KxKHE7cz5tc6RBzeK2ypuPoSG9dBnzi4Fdf+R2x8B6Ch14xGvj2iwE?=
 =?us-ascii?Q?8idj9vNIKXatwYiBLpdJp0HdygRh/h1+utXOyUs6RU9uRkhcnHxmT62XEjVG?=
 =?us-ascii?Q?kwuZxH3pL7jtq//g3s+sFaHBYgyWB3krk65uDs9k2vyEc0MbRZ7rTQ/4W3K4?=
 =?us-ascii?Q?MaaYC3WRNvwvpHj2XD9Dm9Ey+vOP2TRA+k8aWMJ2l1YI3sDoaeSxq90zfvj5?=
 =?us-ascii?Q?aXLLoZLbR4rlTpE/zV4hlpx0Ed+T5StQRxIgtC9WezqP3IwxdtfJ5fqiNSDh?=
 =?us-ascii?Q?8QCx9+SpzmCtlgryijIOxa9i1sijQd91+OiFYrOsB/EOfc2RE6DDGOU6yViH?=
 =?us-ascii?Q?8J+OrO+J5vyIEZk71gxLBvl+bE944ksx8/V28+KQhiS9aYx0XYdUMX6IHyMl?=
 =?us-ascii?Q?0OAxwNP8K2cKo4h/N0xT8o2VxMGzsUrvmW2Pcg1cYzTmFfHqQloDDmhv/SWZ?=
 =?us-ascii?Q?nhSRLaLjzJxEfsDr1KpskW22sdDjDydmvQs1s790itOrwEQFUv0/GfLOcIc4?=
 =?us-ascii?Q?29DawT3hc6ZttMoa2HzaHgbnf+8OZQ2+RbIh/MozXu/bLWTaG3Im8AoL1X7Q?=
 =?us-ascii?Q?I3ySUH7jBHNzYRM9vevvRn3JovGgOFEMYKuq5/w1yUzD1IK8huEa7p6Qrpz/?=
 =?us-ascii?Q?2hHI0ZV5by6xp5WYUMsJzK/0g1PTFcfKtea5tONxy8TO18rH2cdm1gZrqjrm?=
 =?us-ascii?Q?fD3nbVj7WIPjYL2r4wUFDhPeGOnF6k9CS/J7PzeUT8InubvkjVyGeNtynOLG?=
 =?us-ascii?Q?zpRnqcQYFPwy44L/M03BN6OGH6x5MEWYFw8d8hDn06lnrV1flo10ZxxBOIxV?=
 =?us-ascii?Q?xNI+B0aIkQ9Qubev8shCY/IVrV8YHBsW9W3xXPEGvSW8nTDtD4OwSXmXEBuK?=
 =?us-ascii?Q?lK0XCUXE/v8NrQo/b8CJxJf9Is+7uqe1YZZwrbGytrIgSyaCds0cmTmMXMSg?=
 =?us-ascii?Q?+o7nanSO7jN1w2y1ApCqUAHiEtuwim2fG/pM9Tzs29au5HSkVIatLryxKwsj?=
 =?us-ascii?Q?qfWSVcqmAWQV1cHimadUBgKvg0m5+Zwk1ZX90YRouYaxKeqcpipaeQntuhL/?=
 =?us-ascii?Q?/2qWd79M1Oj3RhiHPsKJZwhNsuz76zmcSiAjcBp39Ifg6+vh2foh3ZScUfSy?=
 =?us-ascii?Q?J7hM2PMynNy1LVDCaTvvmWwxrE/XknQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45803fd5-6d0e-4604-188c-08da4afedd81
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:32:52.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X81MfxWNQ1lK9S5U7bbZRSGdfv3NKWSGQRYZ2LHbg4hEvQU1F1g9XQ9/fi+Uv2TO0CTU7eG9kFJg1pDdodNHaQJtcXWN+JPHA5JexUQ5VVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Pavel Tikhomirov (2):
  Add CABA tree to task_struct
  tests: Add CABA selftest

 arch/ia64/kernel/mca.c                   |   3 +
 fs/exec.c                                |   1 +
 fs/proc/array.c                          |  18 +
 include/linux/sched.h                    |   7 +
 init/init_task.c                         |   3 +
 kernel/exit.c                            |  50 ++-
 kernel/fork.c                            |   4 +
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/caba/.gitignore  |   1 +
 tools/testing/selftests/caba/Makefile    |   7 +
 tools/testing/selftests/caba/caba_test.c | 501 +++++++++++++++++++++++
 tools/testing/selftests/caba/config      |   1 +
 12 files changed, 591 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/caba/.gitignore
 create mode 100644 tools/testing/selftests/caba/Makefile
 create mode 100644 tools/testing/selftests/caba/caba_test.c
 create mode 100644 tools/testing/selftests/caba/config

-- 
2.35.3

