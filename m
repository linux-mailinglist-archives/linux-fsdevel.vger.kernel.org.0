Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B39554CDD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 18:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346087AbiFOQIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbiFOQIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:08:39 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20102.outbound.protection.outlook.com [40.107.2.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B311434B95;
        Wed, 15 Jun 2022 09:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Swv7PZ+d0TT0PvBm+4FzHhajSNr10P0TH7QG+rW1uOysISiuVq+FUOlyPnlgGzlAplkhqEHI0LxEUbZrFIe3HZcGXJyJk+KPvDppmYsXk3vgmA2jetw/0oapJSQ7rdAWerkwmrDdITG23kvmCOjLKLF5cD/DTNc9XAxb0bYxZsW0BLhVjDRML4v8+ltCmC4uPwdksTvaQLakoK5Gx6ZwLMRSlryHfTYbg+8psEQ2AR9EAjFxSP+XpmKZ7/RE5n2odBSNnjI1teXFqWPzCP7VKN1/I6V64rBGNnHBF8Vdf0Y0CnzBoS+Hjv3Zc8pS3MqdrOPQ1bImURWaGN1027cioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxFlOzKaZMkOMWRYj5G/4Rc8F8nQufMKG+oFyo18nKk=;
 b=cJ6VKxGwHULqlvnVRvoDN4FISmyLNlLd3b3vSGEwzvw5q8tJLRt1vyRKQlrYXOCcv7QeWuU8sco8CGfMhRONf/NSCVDxNQRZ4W2Xm5P7p7IC9PZQexhtmUYapCws2tSepfryA/6PIPKdpSXVL066troSBfHlgsysLlbHGhPCgnrbGOoKv3aQvwm21MK5cyRDLHS4IpKRGhwO9j0AFD3UILaPlyPMw1n1zvgSiO8rkxcwwEimudFJ8zS4FjIOE7w+XQoAVFhQH+PIeL/erYn9CQRaDtSo0oqB+cBQWAPpiFZ9pzEALpa5EqpKfJ4UUKqCNe/Rsf2J4apaLShu3rqLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxFlOzKaZMkOMWRYj5G/4Rc8F8nQufMKG+oFyo18nKk=;
 b=gNHuW04VL9trFH9wWZWGO9Wy5TiQL3SQNHpMoIpeqo55BSlIZKannUufODHDpPzmH3MLosurYyviXvuoBjAqOIiQpZCcEGOd33tSjMBvJKzr8O0fm4QvxDkaK5160ytEm0IOl75A2r5paluwt+U/4Y6LbswnW0npMMn4UyvyQDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AM0PR08MB4340.eurprd08.prod.outlook.com (2603:10a6:208:139::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 16:08:32 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169%6]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 16:08:32 +0000
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
Subject: [PATCH v2 1/2] Add CABA tree to task_struct
Date:   Wed, 15 Jun 2022 19:08:18 +0300
Message-Id: <20220615160819.242520-2-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615160819.242520-1-ptikhomirov@virtuozzo.com>
References: <20220615160819.242520-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::45) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 478a292a-f559-425c-2112-08da4ee94b18
X-MS-TrafficTypeDiagnostic: AM0PR08MB4340:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB4340F9B3F32A430FA24F753DB7AD9@AM0PR08MB4340.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsB8PVc8lCWeCKqVYGm4CiC7iluUHQvTt3gVDRBJZN9w091Q+scS1iNgRgQg2y48AnWe8pK3+v5dbwEhFwCGUksMlhb5HgfdbWr8SKu/Bo8sksTbD5K5XuthZOZRjK8yXv+EeaV99fqN8pE1L8PUi3wxfcckoBUV6jhzFNBpb8NSAXsGcEVDAczCRApUT2SDN8lP2A5FBMLnR3Uelk3NU7mmxieNZHVEnxkfCKXUibY3z4Yt0Ig+WdQ/rekPd0bh2ZScW4P8A1VyCn+JunoT6tVW0CrTBHCyep2G/pqPyvgVtYyBcyXCL8zlb3Ec77W6J6FA4UPrFgQHjWmtEXKdikRdWgEu+xcjO6zZ9aDPenFlzicooT5wxDcHWEK/YO93ML11ZtAa72dvbxzOF4buPdERcPSY+pF3ccbMqgpGA9IO4w6cu7+ezsBvVqGG/NPiiSCJ32xDoj56a3c3k7y9u5DXvq7xRdc3CzVjSx40IpK2L8kiqpgfU2t3PmSCpb+iPfeZm6BF4Dal8iqM70Ltv3iMW9FLEyIEK+URqBUlqsN/kwioUuIQRJCmqTtEOl914rAHI+t6S7lOTcrvh2Md0leFKeeDDyRySxyqZcMqd42QSqcWdfYq5NRs/5zm5cTTOUj38xtVKEBwzvBppAA4XZ0a2rgGa5k/5jBdqf5sgmYhtH8IYzSOQ+/6gNkG9xrHmf8LEMVmhXAlNKlxDPFLjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(83380400001)(38350700002)(186003)(2906002)(107886003)(1076003)(2616005)(66476007)(36756003)(38100700002)(8676002)(86362001)(66946007)(66556008)(6916009)(26005)(5660300002)(7416002)(316002)(6512007)(52116002)(6486002)(508600001)(6666004)(54906003)(4326008)(6506007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7I+LCB0oz98nPCJg42Dm8PiNRrvpjmFODnsUK8FYI5Kw58a0kBAoD9cSMjTA?=
 =?us-ascii?Q?9Muvan4e6M7OXjA/EyzUYunujQRWP0j33JkBT+zhAjVcUuiFmN25n+m8bk4t?=
 =?us-ascii?Q?69wBd5D5+tfIrRMiZKW4kTc8qlP+BTBblMD9YTurdP0DQ6zaKGpr9Nbuuiu0?=
 =?us-ascii?Q?3TXR+KIL6FloARwhfZaPF7IzkyoxuOQGeA/C0LrAphlqxLmI+c77HbdmD83T?=
 =?us-ascii?Q?G/VE8IiCteYqpqru4Ec+nWwgA2epGaKwB85O84J4AUrBO9H7dWHg49QVZQoq?=
 =?us-ascii?Q?+zaC1AQhusd+auISTzMVSZTeU4wdhsMqFCZN7r1oTw+jrz9TMAcuxaTbVnKg?=
 =?us-ascii?Q?wtPTWhaZkfekNWPzNHFhjmaHVY5UL2y5Prj4MhLqN2P80XOWMKUQYPht3Bvd?=
 =?us-ascii?Q?kDimcq1dOOPtoTdiB7bSew5nWTuPc3vBIljmw9qI1BJ4se5XhH+4HN80QaMk?=
 =?us-ascii?Q?bivGK4G7RX1obztk/dY8hVZO5nqARB1SzkfsQksorVJC+SlpbjcbpvJTqN6Y?=
 =?us-ascii?Q?J0qMi2+OJ2KK2pURJL76Q0mB2CSfVPRNx+j7y2URO7Hq+MRfa3aw0h47fsb7?=
 =?us-ascii?Q?ZxTKdzVaelU8nIPBH0vruyFXq3gUOneYVaom14p1h3vsNprU9wZDXRNTEj6s?=
 =?us-ascii?Q?1MTG0oxhLN2xpwsra2hSTlq6AKUKIENt6mvY12I9R8QeLC1WHoTZ2YP00YC3?=
 =?us-ascii?Q?uQcH0gvicJGCAc8rUlk4HhakUn+BHfhJVXwyeY2u1GH0oa9H8AqmAb9/5aHM?=
 =?us-ascii?Q?TFLKorCsuCADzdiA+QlZAj74FsYMZGWA4p7u3+5ftjjJ7oJb80oHvM4ge0WH?=
 =?us-ascii?Q?aeP7PkMTsPgcgM0hPqAhVi7JyarmT2UdmutFfDgMNM394WE5V/WJ4S6KrDpa?=
 =?us-ascii?Q?ePlVBJbvCRJBUbfVGFPtF09wFUFljubvi0FjMtcLNb9Ufk8ZvXWOVNbmnmRv?=
 =?us-ascii?Q?n0H8bY+XfCnqnklWByeIdLc4CSxNaq6sNAuaQT+OHIPE0vq5FYhTNCnEiTs6?=
 =?us-ascii?Q?KWIEisq3EoF304zsaGGvTCEUq5zOVn1eyN7xQ7G/9Gspx3pVZRzC/+xUixBt?=
 =?us-ascii?Q?utWG2a0KbbmYyGsJ7u0Bpn8ugZqCarByWe/9D9Qfa+dNHFuDW6KAZqKmkUY+?=
 =?us-ascii?Q?fZEna+AMPgVscpmZAaTTWRJDs1eJW0FKECChi5ZbAhu0tzY6qL016axEioPl?=
 =?us-ascii?Q?133mj+sb2ULiT4n+90Q0cBrEsKhZZusoubN34Mo/n8yG9g/Y4Dy8Nan0Qblj?=
 =?us-ascii?Q?VPAFQuLv0VdNTlC/anKhDi5xz9KZ0A9O0zJeAvOV80eaJQRD7Do+8BQbuj/F?=
 =?us-ascii?Q?lkfwqnpejT955YbSCaAMVVmNscpqWjWGLxrffm387cmSZ/ogTLmpy6Hjo5Oh?=
 =?us-ascii?Q?h5zEVRY9/iS3JgiZ1TmW1EPnmVc9zrjLKtQNJmN6ATWxr9I9ZvyfKZhpoLoi?=
 =?us-ascii?Q?zNF3raVDqWwU2WiQswlVEt3nUFFHMd5JEMJ3fQHlBi2gZC5lbN6q6l5fTkuA?=
 =?us-ascii?Q?SolE/5GH2W1ZZ+/M6BV5MqlxfvPrb2TBKHKHiv/tksRQ3qL1yG0DQqcxQ3Vl?=
 =?us-ascii?Q?ONYUnMWJ8PN3yxphEg1Gh5zbF1GG+eyLI55bAtaWF8vAiEN0Yyhg0Esf0Xn/?=
 =?us-ascii?Q?88w4iVA23RnNOTfPD4dbdf/JbdrtkeKFxBKVFjaE5jYCZa9KS4zjQkXoElJa?=
 =?us-ascii?Q?MNYdu46neASC28G/KoL7n4fhQPY+orPLWsYadBifiuyST52IebUDSAJYDU8N?=
 =?us-ascii?Q?tK9Gjj/hoITc0M4AdSDxJjHxVyQIrLg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478a292a-f559-425c-2112-08da4ee94b18
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 16:08:32.2909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJVWFphUBva1WUbb7e30Ulv6ZTzw0sPM4MvnDl6if2XfHEfocLazDfx5egVSW12yZPkwhSiAHZfMFZk7VOH438yyHtaOGp7a+a1jvDPpw+o=
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
CC: kernel@openvz.org

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

--
v2: fix unused variables reported-by: kernel test robot <lkp@intel.com>
---
 arch/ia64/kernel/mca.c |  3 +++
 fs/exec.c              |  1 +
 fs/proc/array.c        | 20 +++++++++++++++++
 include/linux/sched.h  |  7 ++++++
 init/init_task.c       |  3 +++
 kernel/exit.c          | 50 +++++++++++++++++++++++++++++++++++++-----
 kernel/fork.c          |  4 ++++
 7 files changed, 82 insertions(+), 6 deletions(-)

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
index eb815759842c..c0233c7a6881 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -151,11 +151,28 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
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
@@ -214,6 +231,9 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
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

