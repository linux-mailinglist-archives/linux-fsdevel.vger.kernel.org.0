Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA765B200C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 16:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiIHODu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiIHODf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:03:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70130.outbound.protection.outlook.com [40.107.7.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEBC857F5;
        Thu,  8 Sep 2022 07:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVYBNmw4x0wRgHNBMesDhoqqXQlbu3FQmsvLo8sCukRQwDtu7q3jFk/2yZ+ifb0+l7D8okGBxBgMMF/Qe7qTmEvHpYw0gdwTFIQleakxpkWV5BtkMRcZUORGfzK4QnrCHYx+jygjs9ODnO6xD+sfP0jFETy6q1TuSDsS3oCP3c5wep8Akug+5JKSOp0V68rBdH6GwzI7crwmAa1CYY0URiJvSuJp/bCXdNqRzhFp8ZYSSvQvgYfC8AAIdJ3MOITL6fQJtg2EE7TF2fSiQ4I8ayVyvv8JwhP5xrUvH0+WKFVV4xNY/ys+ZbnssXyq+r2Nq3VBZlKSZBIbFV5zNfYkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHNKEX9SO15w1stMY26I5m5MROfOLUK7FxlQ3SMfqlA=;
 b=Ml/jNVo3x/FM84zbkGfgmku507h/yCne3hbXcw1kX8hR+rVZS0yvHNlCZldQsThubKfOfrmxzFppqPVO1lMR+6y3kKxmr+2yGUsMOtjKNM8Jl+6ibzhR7bjUXGyCzW0Qq4OQLwlMXykNkp6PqBn3VPszQrCShLfC+cA61Jhxr4fJaACthDI838PZtQBxwYqGzO+v26KRtpOWrGS00ui7A/batTAknvqTDIVvgzecccHDMp1/k7FKVd+tgVkTnVQurJyvQTov6A/V9kPvAMw4egDOiAkGIXYzMKBLDVS2y3D43qa6E6BzcWjiTNI0GadogBv//cyrsG6Md7jcGFJa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHNKEX9SO15w1stMY26I5m5MROfOLUK7FxlQ3SMfqlA=;
 b=bPZM3guxB61T7G82/IvI613g8KEzNRK35era89wBLhlkE0XOrArT9FQqTfyFvULQuuYr0eVZ9oGeKU4VnHsjn+2mK8bEjMdZ2XG947vhVtDeXAWu6Yl+XXQMVuAZZhLM/G+UEUV5zC4peLoKoESSIUogqLT647Brr37cWX3iC+DNvWr4MIFDMxTLgH9BgYxMF240QBxerPdJzyZ5IxdWzpNrO6jsixPW458pTgoqNZR8H+kgT/GBnGQK0wHj1qWK6FdcLWSYkm39fgyLYu+oHyTvmdWOjh53hxNOmrT7UBNeuc38hrEiQDgz6abSlh6ApASLVgeRfgDlZ3LQY4LhPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by PAXPR08MB7671.eurprd08.prod.outlook.com (2603:10a6:102:245::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 14:03:27 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 14:03:27 +0000
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
Subject: [PATCH v3 1/2] Add CABA tree to task_struct
Date:   Thu,  8 Sep 2022 17:03:12 +0300
Message-Id: <20220908140313.313020-2-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908140313.313020-1-ptikhomirov@virtuozzo.com>
References: <20220908140313.313020-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|PAXPR08MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 292a19b7-76c9-4c6d-b4e6-08da91a2e6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUEpBsSmPmN+6ZKes41lruI6Xcwu7wEsD9aBHNRD4MLAEe/EXaaQmN2LylgvE0chcOnOhWno2iM2tGOY/Tg2zOvog1bmiPOVGLuHV48ogTh+up116dG6XPee7YnweqXo5dLtRZ62pvxLEZHndihsGrAI2DFtrT/fnOsv7Q8Ve4Wf4JsQVf6f6Pa+UhvvgH6eE1Ahmk3quDfiV2qqVrUrrLH/1y15hOMEer81Sx8e5IwRpozO9dpiKkiZFLYe5vtpzu1WpFbf+aSwd4hYk08sPgoKvpK1LYcS32dsHS/Vv+ro5Ru1HIRDzAvvql19cVZRafW/QGapxufxysALqGOGXYT4SmPxO9L0fy/wzVl+9ssoVZdoKTJ+w0chnmwTBgJt2esJsLofssVQW7l54FkczJk/H+UZFBHlfL4+2PImlqX0fUOvqwvBjB5ax3mS2v0LcGS5CRRklKlhPZoShvWWzAGN7u3qHmUTffthpcCmW/6yaxBLpHVQN6WjXYecixDe8yo4xiMwmNGlCqHdrxYpX0QYLOkvZSgQQ4fEKG+9GYE1F6+a01n7fwLT6u8eEosogVURdEpUFtXmxOA41jsXu9t7vvM0OSaH6WQdjH4jAsClU4oAB4andqgXUOyipLQRqv/juMezNfFg1os3t3FPT1sPN0ID3uGW7Y8tjbdFaj1EupE6Fm8tBw4e25Tt+DsRorrJmQ9uJQNBHDWKBoX15oKBy9y4YduxyumIVBdFSQs4t0RuVuH0HPaeIX6uKrSn/WimPmhYCNLFTY3ZeklnqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39850400004)(136003)(346002)(376002)(83380400001)(38100700002)(38350700002)(86362001)(54906003)(66476007)(4326008)(66556008)(316002)(8676002)(2906002)(66946007)(52116002)(110136005)(26005)(7416002)(8936002)(5660300002)(478600001)(6512007)(2616005)(186003)(1076003)(6666004)(6486002)(107886003)(41300700001)(6506007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mb1oPO2MpmpTG0HMBkDUFAw24DgqFYRTtDf1AJYkZ5XpkiueMxHQuD+hxFk+?=
 =?us-ascii?Q?7zHPdv+XEyXBxvyITv07WCwR03nQbJFjC10usqjHrhpI1u0me1ACjWMbpe+Z?=
 =?us-ascii?Q?L8KgOj9SWje/gh1M/wSIx4aZ0q+E8HSeTuSfM5rIfYC1ALdiVzV59LG1UPNd?=
 =?us-ascii?Q?gXfmvh3nAnxGAf2va4FIhaIPYziKgHNR1QdfMRArUy7HoeGG9ogJcxXRi9XX?=
 =?us-ascii?Q?FSKIo+5H0nwZPYpNnvGUS8Tm+QwmGwTr7gpUvtILdWu48NPmD2Wpd7dgG0Fe?=
 =?us-ascii?Q?Doq9lUVIc3TsFY4PIuR4fEaEaxGMO+XrIAGiV8D5EGQu+zOiCVvCZ+v0uypf?=
 =?us-ascii?Q?iGJgdaS7higLhBilOqJj/+syglpQ2DyNR2naYYuCjJlh+RWSup0jWC+3DJoa?=
 =?us-ascii?Q?omI8i+0TJA3TCIOwElx5GRoqcsOXGLp5GAqhBZPdHIUWMWNw28ccDSJDOy2h?=
 =?us-ascii?Q?CZikP7L4SiE4wv2GzEWQt1h5IxulLHIqg3K/dBf1cPR//cSpBr6fWZ8pYdg/?=
 =?us-ascii?Q?RfwSG3vxWYoMYOcz9w/88nvNmBcMGVdnFhGOV0pERmr5+fFBfgbngiRWERsE?=
 =?us-ascii?Q?AquB+r8wrARFYgCHHUUM06tSMB51GeJIayhGeSiT9RoPAPG/1/S0eowfTIEY?=
 =?us-ascii?Q?15KvnTpXykD4y2CkBW9zWWLxskqmih0KiouBS2jeIwk0y1+b2eseRqbB10aS?=
 =?us-ascii?Q?74C+Nce68sOUM5mFOX3QVllDge6xosqSaZEjGzghsNzN6UP+hOQyDYACWIqD?=
 =?us-ascii?Q?UyvHTlsTrjNTJlPwE0nCgL4wZvU+5rGXAAtcxw8Iws5XkJLB3xUubijsyebz?=
 =?us-ascii?Q?v8IYT4Offq9y2yFkoZCdFNJXKtzoTcHTGyhzgbtG7wpR92G6+DN44W9fOKt8?=
 =?us-ascii?Q?pLfzRhsjZaYqeOR2OLeqySXdnICSpftwZyszIPat7lw4gLz1OZ6K35XEoJZs?=
 =?us-ascii?Q?SfvlrfJSLaJCW1tNAssMssNbgVer+DfuOMV8Q5iHOe2E2E879Kq38h9iQZGN?=
 =?us-ascii?Q?6QHyeYEDjfdSNDgUgvP5QlHYGF85asS8iw7R8Hvw44kquYgEduLiI4nuGz8X?=
 =?us-ascii?Q?Y4uv8mCMjo4M/InykKASoSnMXfE7xoMxTCfqs94TLV+mlowgHySiOvVU5kB1?=
 =?us-ascii?Q?WDPglnvq6gJUrhrvoKoCay4IgtCfl4Ia+eiQAkSOKpRZSU5BK5hBn2ydhLqU?=
 =?us-ascii?Q?OCo4mokVmNZY0pf3NEOQxRu4qyPA4F3M8Q6WPFHek6Ok3SK9ZWz29d9/15Tt?=
 =?us-ascii?Q?4Ql/2OspeD7AF5rhNDjkpfAsmefnl6mksAudRMx3kaY4+HzyohpVG3Et76CA?=
 =?us-ascii?Q?Ian0x5wK9PKPsCxLZm4Q5JtwVLRuFje6mt6sH2fZsntUvxs4y/u5aCT5tbwm?=
 =?us-ascii?Q?jCIg3y3BRMTz0y3LIV7DbpROnvE0qW13jHApdHVWUKGLq9OYjdS70BtqfJVm?=
 =?us-ascii?Q?s3lsizKawt0AQAf7O0YZQm3HQPqOonvFBv/K8gDr5SGvxPcRgPKEeAJjLSvd?=
 =?us-ascii?Q?WQcf7EYmVJOz5y/3niYlSzBniVQDg9Jfrlolt1+fLSbDdSuBYc06yflZ7use?=
 =?us-ascii?Q?JRB27uTOLhBGWDcEzk1E2y+lXpW3NaJeCI1puZ3FA90QS8+puXbO/PzhYFbN?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292a19b7-76c9-4c6d-b4e6-08da91a2e6cf
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 14:03:27.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cWJb83IXCR0UVL4fVPmpqv3SiXFD01TOjdbxc8M7hHH5vMN4+PXaa3pWcKdEnxgzB+zHyY82gkAE2Gd1AzM8EljiHjX81vRpTTcf/vv9PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7671
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
providing a new information to CRIU so that we can understand from where
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
CC: kernel@openvz.org

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

--
v2: fix unused variables reported-by: kernel test robot <lkp@intel.com>
v3: - on fork set caba to current, so that caba is always a process
      which had initiated our creation, even for CLONE_PARENT case
    - move caba update to a later stage (to __unhash_process), so that
      zombies can be somebodies caba until fully released
---
 arch/ia64/kernel/mca.c |  3 +++
 fs/exec.c              |  1 +
 fs/proc/array.c        | 20 ++++++++++++++++++++
 include/linux/sched.h  |  7 +++++++
 init/init_task.c       |  3 +++
 kernel/exit.c          | 21 +++++++++++++++++++++
 kernel/fork.c          |  4 ++++
 7 files changed, 59 insertions(+)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index c62a66710ad6..5e561994cff7 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1793,6 +1793,9 @@ format_mca_init_stack(void *mca_data, unsigned long offset,
 	p->parent = p->real_parent = p->group_leader = p;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
+	p->caba = p;
+	INIT_LIST_HEAD(&p->cabds);
+	INIT_LIST_HEAD(&p->cabd);
 	strncpy(p->comm, type, sizeof(p->comm)-1);
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 9a5ca7b82bfc..8caaa03739ab 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1139,6 +1139,7 @@ static int de_thread(struct task_struct *tsk)
 
 		list_replace_rcu(&leader->tasks, &tsk->tasks);
 		list_replace_init(&leader->sibling, &tsk->sibling);
+		list_replace_init(&leader->cabd, &tsk->cabd);
 
 		tsk->group_leader = tsk;
 		leader->group_leader = tsk;
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 99fcbfda8e25..5fd70aebd52d 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -154,11 +154,28 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 	const struct cred *cred;
 	pid_t ppid, tpid = 0, tgid, ngid;
 	unsigned int max_fds = 0;
+#ifdef CONFIG_PID_NS
+	struct task_struct *caba;
+	struct pid *caba_pid;
+	int caba_level = 0;
+	pid_t caba_pids[MAX_PID_NS_LEVEL] = {};
+#endif
 
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
@@ -217,6 +234,9 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
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
index e7b2f8a5c711..b30a2ccf1180 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -975,6 +975,13 @@ struct task_struct {
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
index ff6c4b9bfe6b..439da3b04dde 100644
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
index 84021b24f79e..32e4a380861d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,9 +71,29 @@
 #include <asm/unistd.h>
 #include <asm/mmu_context.h>
 
+static void forget_caba(struct task_struct *caba)
+{
+	struct task_struct *p, *t, *new_caba;
+
+	if (list_empty(&caba->cabds))
+		return;
+
+	if (!thread_group_leader(caba))
+		new_caba = caba->group_leader;
+	else
+		new_caba = caba->caba;
+
+	list_for_each_entry(p, &caba->cabds, cabd) {
+		for_each_thread(p, t)
+			RCU_INIT_POINTER(t->caba, new_caba);
+	}
+	list_splice_tail_init(&caba->cabds, &new_caba->cabds);
+}
+
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
 	nr_threads--;
+	forget_caba(p);
 	detach_pid(p, PIDTYPE_PID);
 	if (group_dead) {
 		detach_pid(p, PIDTYPE_TGID);
@@ -82,6 +102,7 @@ static void __unhash_process(struct task_struct *p, bool group_dead)
 
 		list_del_rcu(&p->tasks);
 		list_del_init(&p->sibling);
+		list_del_init(&p->cabd);
 		__this_cpu_dec(process_counts);
 	}
 	list_del_rcu(&p->thread_group);
diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..a14ee9f1acb1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2139,6 +2139,8 @@ static __latent_entropy struct task_struct *copy_process(
 	p->flags |= PF_FORKNOEXEC;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
+	INIT_LIST_HEAD(&p->cabds);
+	INIT_LIST_HEAD(&p->cabd);
 	rcu_copy_process(p);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
@@ -2402,6 +2404,7 @@ static __latent_entropy struct task_struct *copy_process(
 		p->parent_exec_id = current->self_exec_id;
 		p->exit_signal = args->exit_signal;
 	}
+	p->caba = current;
 
 	klp_copy_process(p);
 
@@ -2455,6 +2458,7 @@ static __latent_entropy struct task_struct *copy_process(
 			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
 							 p->real_parent->signal->is_child_subreaper;
 			list_add_tail(&p->sibling, &p->real_parent->children);
+			list_add_tail(&p->cabd, &p->caba->cabds);
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
 			attach_pid(p, PIDTYPE_PGID);
-- 
2.37.1

