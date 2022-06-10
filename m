Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884E8546A6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 18:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbiFJQdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349626AbiFJQc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:32:58 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10118.outbound.protection.outlook.com [40.107.1.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6077456B24;
        Fri, 10 Jun 2022 09:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoEoJaHORmd7fjRxvAC9qfwjze2XR7cwiY/sT2XFPo3VD6pA7k+MZBUOiu9LqhV1otLfp98yh5K91nw63ECbjvOVXL7cjUXlU1Ca5/MvdeEB+GF8+nSQ9F/rOEkwOZuw6VceFXijp000sgPFsMnirjPkOuH0uVoUWxXp19InE/ga5L/CZ7AtixSSRWzir/DyygKlZTHgwhM1yLICEPfnOce/byvU+uSL80/xwxst9MyCaS+B22EQ4T6sgQAYkplS0btQ/XQxp3ixJI55NXOLyUyzWjStUveHkGSL59y2W/jYzjjVWVB2w3Jez+coBM7iYMzP5Xeio63P8qbJdg+6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccP8ySTgYcnYKFmrzWFNxo2BbWxBhfssPAtW7lXENsc=;
 b=UcF64axvGpE70EjNBtnqJs1g5HLldrlXa2W4Zr5rsaTLjQiqpcWqD4dDcckNEzIDYbJSm2pAuR/enO+hJJTKY9FmcgyohLH5cZ93LUxXTGE7kz+WJ8ny0eUbucVw9HzGaf+PZm72H8fjKye4XchsThowyBEnSpGIM9iVa+vU2tyjolE7U5KmeMQI4W1UgDczU+hN+AEQKYrh4B44YUeXRGi/yN8NTimdBbvqMeR4v67GiBZ5/hItqrgDY8i5KGjbzzNkZgRZV/EQ9wwLOpMsW9UHwNq2l8XdMMpb9PAtqAXxulufCVk/cwwHs06dl3LamCVEHwT3ocVQQr0+U1Tobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccP8ySTgYcnYKFmrzWFNxo2BbWxBhfssPAtW7lXENsc=;
 b=V1NtDjZyrTtMbCezWEVFHYSnk6xGIOlC17w6x9ukHp5gYtKC/bawnUpiiNDDhS1No75jFVkUAcVlEQnC5GdlVdJCL1zQ77Y7L+t9RROG6sU4mLWy8aZymcqsYsgHe4YT9Lm+dx4dbluYoGXIX4fDP+/TELR4gte/4e9hZV7feWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AM9PR08MB6180.eurprd08.prod.outlook.com (2603:10a6:20b:2d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 16:32:54 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 16:32:54 +0000
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
Subject: [PATCH 1/2] Add CABA tree to task_struct
Date:   Fri, 10 Jun 2022 19:32:13 +0300
Message-Id: <20220610163214.49974-2-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220610163214.49974-1-ptikhomirov@virtuozzo.com>
References: <20220610163214.49974-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::24) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cc50d03-47c2-4723-16fd-08da4afedeca
X-MS-TrafficTypeDiagnostic: AM9PR08MB6180:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB6180B92E6D9D5D47A8B8D101B7A69@AM9PR08MB6180.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5+8FYE2zt6G0t7h8sbT00zTKGNxDHB+sga06bl+g0DjvHnXbnF7k4kXF8Ej9H7VKvbyxRVsucP54m55WbQbmi6+wWsYwtGGjo0Kon31KT5YOzhCGBMPc+njWQfOtRf82wpdd8l/7ivP9NQ8ceTU+pjmGxbifJnPdbLgu4EPemwXZ5p9ZLB7ztaTYoQC7obfLPCobTg+/L6HSsJFb6G+XeqxIlBSGHo1i9Q++lqjBwY8e+sWIPqnBx4NoKCGlVjWHxCfgfig9YR7a+GzUDBlY9j2Q6QGuGu/a+eWHfDeK014k1vP5m8PFI9hLrVyo/nIpLt7P9dTwtkcOzicyF9lgKY86Vvlhd4KQkBO4roJjk3taDqd0GjHK1dpGqYb3tPaYs+k4tvRoF37OV9lTIEYuw3gQbSdjJ5PxXLozP241eXwDzr77Niv2sbgNh5mTo1ocCCAiQpfQ3MFgQ6+O3Id9dTsuyzQoBYTtp22K6/XbvKNBcUgrCDSu+lVENPS4VHhOf4x3gPt4LDFwECyv4Ef4NXjPHMz87Ydjg/X4eDaS2ThawgkoUbOgDUcVaiW7xibAo6FTkHOVlE03KS8/qBFomRrg/1y6nIdqwDJ2FdF3SJqly75pihrjhbsXjzEcegebc3vK1Cu2NA8wormmrko/ggmsk7HyuFm/wCF7YQiFqT4ck8H/9bMGTIQLZygt/q9n5/SjsDuH0zowDGdVswkrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6916009)(54906003)(38350700002)(38100700002)(8936002)(4326008)(2906002)(5660300002)(66946007)(7416002)(66556008)(66476007)(8676002)(83380400001)(52116002)(6666004)(1076003)(6506007)(186003)(6512007)(26005)(6486002)(508600001)(36756003)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMc2MSRjYkso4yvvhSBs7TisSc2wJGdgfm+WAQDhhN3sJmDF7eWHRr0HH8in?=
 =?us-ascii?Q?Mqpm088j69K8/YpyVoSpct4pRdSRJeYkED5OC9/Mn4DbLBPoYJ4Mz6lUci+k?=
 =?us-ascii?Q?DlbVS/piDgCMbxcreafvkN8mGQ7vZx622fqDQtf87yyDpDSKGi76F0QuNAAH?=
 =?us-ascii?Q?LCK7V8A9pB029MgtvBCR2cOZM3KGs9YpYlayfDR0rjJSu9y7Q3qZbsBi28L9?=
 =?us-ascii?Q?YNv0ZMp209g8xoydZYt9PHkP46SnyoXegQ149b8RJ4beJE7kYJsfxzp36n0x?=
 =?us-ascii?Q?KcRvD5uYPMsL2R6lNlF2m7STbwCp0L+J+GHuKvHVUhQD5lMwNdrfEgc5Qfis?=
 =?us-ascii?Q?rxqI+T9VNeZzxSppRjYNRwKi8AS8NSCReju1+/GoOgoD6nxmOoB0obGJWAVY?=
 =?us-ascii?Q?LBA4IRoZfIoP1zLnhDel+uTVowzxvpAJXznu1QCmKOM17Ws3UXsxLWVtTvnx?=
 =?us-ascii?Q?OcbouAkKGnRC+uS4xEIAZeSYdXAGCVh1hRPxZZYfvjxvvWX4X49E9yy/w5cb?=
 =?us-ascii?Q?VUL27a3NdDERlrS25kIlLLPIkyZFqGuWgXpwEHVHlvxg39LR/G6S1X5eoBca?=
 =?us-ascii?Q?zpuelM8mIEYrL6Aipbw3jTRgRBHRV1jMREXfSXwWKrPJNmRFqfIbFTI/osh8?=
 =?us-ascii?Q?UgrSzapPwTSuiYZMkJUk/aL4eMcO3jrPaAQ5yUUyfUd/8FrgOzoLBuvbN0Ax?=
 =?us-ascii?Q?pAFFiQrsFgIY7rE+NF9xpPSPcdog2FaD4fwZCkxRp6BR7e4zm5e5UQdAmcIP?=
 =?us-ascii?Q?bQzbZ9hgHMvjXhFbwGdbLG+D/4wpwgw/99SNld5RAJN/T9HMe6WAQdywWX8u?=
 =?us-ascii?Q?LNhIm5xKNjWI9CV8GrjNfYp9XFlyhOp4ZqTq8akgQrcdpXfjniwMzI9YjrSe?=
 =?us-ascii?Q?hTr+UgDUS1Z5P9/WZOn9yvS+bDNbRgEfjnmuOt05qYo1vZhK/Yiyl8s4sBtd?=
 =?us-ascii?Q?0FKMdaVDgXddExdiLi7wSZ8j+UNOWROpjKmyP9b5NpOQTc2sHYNJYcItODwO?=
 =?us-ascii?Q?AF3DpY62gvvBjegqI08/mAExH5Yudx3++gltaKbwReW7uU7ePW9StOynlvOO?=
 =?us-ascii?Q?3uIU0BmZK6WGlgXJu46vQBGCWROnrRkFQZP73Xqpm/2Kl3dWisUq1q6YHQZm?=
 =?us-ascii?Q?XzEiEI+OXX3OFjRiV+0r01vor18+ejK29yakcBPErUhEV2lqlf6jOWNvMgZf?=
 =?us-ascii?Q?nmvVNYJOHAOXW76krguvHTx2LWklR2zWmCp7r+ww7GoC+nwN8aQsD8DKeUOb?=
 =?us-ascii?Q?uAbirYtqoOzZvbZBKgt2o4enYHrJZRq/8E+UlaIJUPmWaUtbALkwpkJMK387?=
 =?us-ascii?Q?+T4FRgERxk+lI2q4xlBrxTzs6aevW6n7Bo+ja9Dc4H91L++8T1Wk1bVdJgDM?=
 =?us-ascii?Q?Q+Z68PztH1SGHssJIvFFPZQtFWKpYB6ApPB76Z/m5G0yYAOuuAmvaYzWogyE?=
 =?us-ascii?Q?lV4kYdLZYaEXp/GJr+p2Y647c2F2ocdE8ZhQ9ZK+3V6lwa/cDC4F7uZCTKO4?=
 =?us-ascii?Q?Em9jO3b9GSn1+OTb6gjOEeZDmj5wqi6RDqBYDjEsRS2q14w0JY4bMd1dJc+f?=
 =?us-ascii?Q?pnhXWq6ncKakhgArHrwp4Xr51isxJCoEaVQZlqZUBjQQLTgIJokPnchNbYqH?=
 =?us-ascii?Q?5d/rC29ZNaUq/c3F+6trMdTiy1TxWTG7HfU2CcVH40BfeOQoL+27FNco+tbM?=
 =?us-ascii?Q?Nr8NWIObPKzQUd+eS5HCAcHEt+jXZ/l/NEoYJpK+Yw/vBMtNY3Cg67f2mfYh?=
 =?us-ascii?Q?sp9UCl2SOGrs5y1T1jPjpIZRVfTDSlE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc50d03-47c2-4723-16fd-08da4afedeca
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:32:54.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ccd95lvbRx8yF8gnHjL1e+DdqrOTFTJVjOtS+wMyD0/0yh4LAMp07fdLlgxARzvYKNdY+zbQ6Axbshr0OUZDzIa1Lvj9ycD4x6N6Ip20Xhg=
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

In linux after parent (father) process dies, children processes are
moved (reparented) to a reaper process. Roughly speaking:

1) If father has other yet alive thread, this thread would be a reaper.

2) Else if there is father's ancestor (with no pidns level change in the
middle), which has PR_SET_CHILD_SUBREAPER set, this ancestor would be a
reaper.

3) Else father's pidns init would be a reaper for fathers children.

The problem with this for CRIU is that when CRIU comes to dump processes
it does not know the order in which processes and their resources were
created. And processes can have resources which a) can only be inherited
when we clone processes, b) can only be created by specific processes
and c) are shared between several processes (the example of such a
resource is process session). For such resources CRIU restore would need
to re-invent such order of process creation which at the same time
creates the desired process tree topology and allows to inherit all
resources right.

When process reparenting involves child-sub-reapers one can drastically
mix processes in process tree so that it is not obvious how to restore
everything right.

So this is what we came up with to help CRIU to overcome this problem:

CABA = Closest Alive Born Ancestor
CABD = Closest Alive Born Descendant

We want to put processes in one more tree - CABA tree. This tree is not
affecting reparenting or process creation in any way except for
providing a new information to CRIU so that it can understand from where
the reparented child had reparented, though original father is already
dead and probably a fathers father too, we can still have information
about the process which is still alive and was originally a parent of
process sequence (of already dead processes) which lead to us - CABA.

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

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 arch/ia64/kernel/mca.c |  3 +++
 fs/exec.c              |  1 +
 fs/proc/array.c        | 18 +++++++++++++++
 include/linux/sched.h  |  7 ++++++
 init/init_task.c       |  3 +++
 kernel/exit.c          | 50 +++++++++++++++++++++++++++++++++++++-----
 kernel/fork.c          |  4 ++++
 7 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index c62a66710ad6..74bf75fef9df 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1793,6 +1793,9 @@ format_mca_init_stack(void *mca_data, unsigned long offset,
 	p->parent = p->real_parent = p->group_leader = p;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
+	p->caba = p->real_parent;
+	INIT_LIST_HEAD(&p->cabds);
+	INIT_LIST_HEAD(&p->cabd);
 	strncpy(p->comm, type, sizeof(p->comm)-1);
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 0989fb8472a1..23e48db6c5b1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1136,6 +1136,7 @@ static int de_thread(struct task_struct *tsk)
 
 		list_replace_rcu(&leader->tasks, &tsk->tasks);
 		list_replace_init(&leader->sibling, &tsk->sibling);
+		list_replace_init(&leader->cabd, &tsk->cabd);
 
 		tsk->group_leader = tsk;
 		leader->group_leader = tsk;
diff --git a/fs/proc/array.c b/fs/proc/array.c
index eb815759842c..6c43a8d64f65 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -151,11 +151,26 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 	const struct cred *cred;
 	pid_t ppid, tpid = 0, tgid, ngid;
 	unsigned int max_fds = 0;
+	struct task_struct *caba;
+	struct pid *caba_pid;
+	int caba_level = 0;
+	pid_t caba_pids[MAX_PID_NS_LEVEL] = {};
 
 	rcu_read_lock();
 	ppid = pid_alive(p) ?
 		task_tgid_nr_ns(rcu_dereference(p->real_parent), ns) : 0;
 
+#ifdef CONFIG_PID_NS
+	caba = rcu_dereference(p->caba);
+	caba_pid = get_task_pid(caba, PIDTYPE_PID);
+	if (caba_pid) {
+		caba_level = caba_pid->level;
+		for (g = ns->level; g <= caba_level; g++)
+			caba_pids[g] = task_pid_nr_ns(caba, caba_pid->numbers[g].ns);
+		put_pid(caba_pid);
+	}
+#endif
+
 	tracer = ptrace_parent(p);
 	if (tracer)
 		tpid = task_pid_nr_ns(tracer, ns);
@@ -214,6 +229,9 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 	seq_puts(m, "\nNSsid:");
 	for (g = ns->level; g <= pid->level; g++)
 		seq_put_decimal_ull(m, "\t", task_session_nr_ns(p, pid->numbers[g].ns));
+	seq_puts(m, "\nNScaba:");
+	for (g = ns->level; g <= caba_level; g++)
+		seq_put_decimal_ull(m, "\t", caba_pids[g]);
 #endif
 	seq_putc(m, '\n');
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758..358af0cf8f73 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -973,6 +973,13 @@ struct task_struct {
 	struct list_head		sibling;
 	struct task_struct		*group_leader;
 
+	/* Closest Alive Born Ancestor process: */
+	struct task_struct __rcu	*caba;
+
+	/* Closest Alive Born Descendants list: */
+	struct list_head		cabds;
+	struct list_head		cabd;
+
 	/*
 	 * 'ptraced' is the list of tasks this task is using ptrace() on.
 	 *
diff --git a/init/init_task.c b/init/init_task.c
index 73cc8f03511a..a0b206dd74ef 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -109,6 +109,9 @@ struct task_struct init_task
 	.children	= LIST_HEAD_INIT(init_task.children),
 	.sibling	= LIST_HEAD_INIT(init_task.sibling),
 	.group_leader	= &init_task,
+	.caba		= &init_task,
+	.cabds		= LIST_HEAD_INIT(init_task.cabds),
+	.cabd		= LIST_HEAD_INIT(init_task.cabd),
 	RCU_POINTER_INITIALIZER(real_cred, &init_cred),
 	RCU_POINTER_INITIALIZER(cred, &init_cred),
 	.comm		= INIT_TASK_COMM,
diff --git a/kernel/exit.c b/kernel/exit.c
index f072959fcab7..5eae2ff93576 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -82,6 +82,7 @@ static void __unhash_process(struct task_struct *p, bool group_dead)
 
 		list_del_rcu(&p->tasks);
 		list_del_init(&p->sibling);
+		list_del_init(&p->cabd);
 		__this_cpu_dec(process_counts);
 	}
 	list_del_rcu(&p->thread_group);
@@ -562,11 +563,11 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
  * 3. give it to the init process (PID 1) in our pid namespace
  */
 static struct task_struct *find_new_reaper(struct task_struct *father,
-					   struct task_struct *child_reaper)
+					   struct task_struct *child_reaper,
+					   struct task_struct *thread)
 {
-	struct task_struct *thread, *reaper;
+	struct task_struct *reaper;
 
-	thread = find_alive_thread(father);
 	if (thread)
 		return thread;
 
@@ -620,6 +621,31 @@ static void reparent_leader(struct task_struct *father, struct task_struct *p,
 	kill_orphaned_pgrp(p, father);
 }
 
+static struct task_struct *find_new_caba(struct task_struct *father,
+					 struct task_struct *thread)
+{
+	struct task_struct *caba;
+
+	if (thread)
+		return thread;
+
+	caba = father->caba;
+	while (1) {
+		if (caba == &init_task)
+			break;
+		if (WARN_ON_ONCE(caba->caba == caba))
+			break;
+
+		thread = find_alive_thread(caba);
+		if (thread)
+			return thread;
+
+		caba = caba->caba;
+	}
+
+	return caba;
+}
+
 /*
  * This does two things:
  *
@@ -631,17 +657,19 @@ static void reparent_leader(struct task_struct *father, struct task_struct *p,
 static void forget_original_parent(struct task_struct *father,
 					struct list_head *dead)
 {
-	struct task_struct *p, *t, *reaper;
+	struct task_struct *p, *t, *reaper, *thread, *caba;
 
 	if (unlikely(!list_empty(&father->ptraced)))
 		exit_ptrace(father, dead);
 
 	/* Can drop and reacquire tasklist_lock */
 	reaper = find_child_reaper(father, dead);
+	thread = find_alive_thread(father);
+
 	if (list_empty(&father->children))
-		return;
+		goto caba;
 
-	reaper = find_new_reaper(father, reaper);
+	reaper = find_new_reaper(father, reaper, thread);
 	list_for_each_entry(p, &father->children, sibling) {
 		for_each_thread(p, t) {
 			RCU_INIT_POINTER(t->real_parent, reaper);
@@ -661,6 +689,16 @@ static void forget_original_parent(struct task_struct *father,
 			reparent_leader(father, p, dead);
 	}
 	list_splice_tail_init(&father->children, &reaper->children);
+caba:
+	if (list_empty(&father->cabds))
+		return;
+
+	caba = find_new_caba(father, thread);
+	list_for_each_entry(p, &father->cabds, cabd) {
+		for_each_thread(p, t)
+			RCU_INIT_POINTER(t->caba, caba);
+	}
+	list_splice_tail_init(&father->cabds, &caba->cabds);
 }
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..e397122721ff 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2123,6 +2123,8 @@ static __latent_entropy struct task_struct *copy_process(
 	p->flags |= PF_FORKNOEXEC;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
+	INIT_LIST_HEAD(&p->cabds);
+	INIT_LIST_HEAD(&p->cabd);
 	rcu_copy_process(p);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
@@ -2386,6 +2388,7 @@ static __latent_entropy struct task_struct *copy_process(
 		p->parent_exec_id = current->self_exec_id;
 		p->exit_signal = args->exit_signal;
 	}
+	p->caba = p->real_parent;
 
 	klp_copy_process(p);
 
@@ -2437,6 +2440,7 @@ static __latent_entropy struct task_struct *copy_process(
 			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
 							 p->real_parent->signal->is_child_subreaper;
 			list_add_tail(&p->sibling, &p->real_parent->children);
+			list_add_tail(&p->cabd, &p->caba->cabds);
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
 			attach_pid(p, PIDTYPE_PGID);
-- 
2.35.3

