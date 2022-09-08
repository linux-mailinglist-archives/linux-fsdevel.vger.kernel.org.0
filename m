Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB135B2910
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 00:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIHWKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 18:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiIHWKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:10:47 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150097.outbound.protection.outlook.com [40.107.15.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA8E3D48;
        Thu,  8 Sep 2022 15:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hs2I6X5FA7p8h7PyPdjJh/SUPi2RMZgsnP2f6ug6bGUQVgrubQQ1TUi3xHg6h5Hp6tUTKaOe5pmzaRvKtYue642r9wWnWcj2UvR7IUcHseODtNQZ2hEoZLKV4+JXhyBCHc/YRwnLamPQSvEJOILuLSPo0gPvf1HUpK007xYQ631xDlY3YCwYX7MYENTavZKc2OE8Gr6hfO21n2ZQkWJs7BH59O8CPUjMs6l2Dm/+s5RyxNrHhjKwno6KnqzX3stbi7tK8QvuqXO16RHmCOmJXfCyo0tYRL4AGrAcrliCCOVGs1pm52M297wRuLHot3aJcFbtZxMygJFnaZ2440Bdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rL8NRg8Is9iXuMLLAObja4QYwVm8vlI6TMMWNQAaso=;
 b=e95qjL6szhaDDQObDYqCnzTvQKyXKEoHTNfzrEuao+bJ2c7wK3HUASMvKMmf/cCSKx7oKzw6XPULSo2T34BNMGyX0ya8nuR/fbcXp//wcZIsgoYsFINgWXLHV0CA6bcHvVwG1dNR2MwBzGGlkWNWQBx4w3PljGI/cpxeGoEfFDWwBjEhB/hamntRJINEQsQ5qr4jsPldDtFHRo9qXvL0w4A7QUgBCZHbDSNzhwjYWHb/jf0PfFwGMCGw7SLw9RPvNwre5GaPG0UjSq5oqdSjk0MuajXKSsBKTamZPrE1k26jFsY4LVlhglJj06mSXnKLkSxbmtUc1AlP6rP8+mS7Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rL8NRg8Is9iXuMLLAObja4QYwVm8vlI6TMMWNQAaso=;
 b=HIj9bCEL/b/Zi0HCWAjpmGJxpCmQSAD6H3Zgf+RY2GAt+ju/LKXF5TLUvPjsNTfXBbjX4BOgnRYBpMMN7oVXQ8RJOmEovtvx9IojWwB9KEW7yj3X7/dkutUy8750bFsczI0LLfFmclRKPqaVHXXTaFVl1W5W8N1mNUXn7cLy1xMzK5zqm/XAM+/sB1DOAcGzar+FXMQjfrLE7tBLCASm8lORXhde1LOB9gBKo3iY1c9epQ4+fQSz2d+HJgYFnpMJowAmj4FVb/z8ecZFj62BIw42UfjBak8grSe5EEnemnpOWU7XF7XH+NWVxPCAJ6HZBUDNz+/pgl6xllrvImuYzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by DU0PR08MB8812.eurprd08.prod.outlook.com (2603:10a6:10:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 22:10:44 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 22:10:43 +0000
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
        linux-fsdevel@vger.kernel.org, kernel@openvz.org,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Subject: [PATCH v4 1/2] Add CABA tree to task_struct
Date:   Fri,  9 Sep 2022 01:09:44 +0300
Message-Id: <20220908220944.822942-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908140313.313020-2-ptikhomirov@virtuozzo.com>
References: <20220908140313.313020-2-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:206:1::14) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|DU0PR08MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: fd94d63f-ac7e-4fe0-b4c8-08da91e6f936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OkS9eBrBDIGZUanmYCFgVxboZeIQqrc8pQg9GxcpzoNNou+To7lQFRdjrzfhb96kpcnk6+BSCJJaogoVVP2+8EcShwZTa3/ZNfb/FacQBRcW8YHfi+A2wnPVMaTC+97ITmDeVBV0x0cSB3rzDoJERmGFGLsQLabCRStrHX4K3+4WPLzRelT7qL2OAKD79aopntPDwja+eF4/MKc+IiXteDB9phfKM+9UCHGe3lyLjfGq2sCGzT1rv/QEVd+kR+RfU+wmZPcDVg4T32X7QEPOYJQygjDFMaC1X0RSdabH5qc2SpCTNC7puTss6XDxF7vsTFXNpITJnqmc8wu20IqF+Mj+A4SOBO0pRetrE7jIkVOUunDYwXrfRv5NDm2hcTNLAz1hvPkDnK7sISrisdKfZho3Ird0wwKVmWGit2E+8umdfpExPVl/nM31dhhM9wnOS2SLy07Ft2FOR0Lzt0KZH4euIBt8xMgtYhywRoA1iaPq1ownIoRGECKdz14LEmrhX5DfpwywIT5bOPRmoLNZL6kqWofv1qJiCwOsyIUkYR21cZY0Bro1PUiX3xiJEjY7Q0zt2N7V34DmF+46asjhU/IZggcGVljDSKeXGeZToxfHsnEZyNd9R/9jwnexjq3vmHtL9azCeALVNIz+yzhOkdohJR1UE3Q19/GUVBMi2DRVSJ5WPs1PmjQcZk96uiLRGE5flAFQb05N1VnWKWlBrLzD75MjcTG665SjAERsRUfSy27lP5I5yg6pkcDHnumQjjpp3RhjiI3xapXI37RfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(6512007)(66556008)(38350700002)(38100700002)(316002)(110136005)(4326008)(478600001)(54906003)(66946007)(6486002)(66476007)(36756003)(83380400001)(8676002)(8936002)(107886003)(1076003)(41300700001)(86362001)(186003)(5660300002)(6506007)(52116002)(7416002)(2616005)(2906002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cJvLi/T3ruajEZqOioYZMqt7vMrGUHtyvKiExDjBvgSiDIxkdnZKynGT2SpI?=
 =?us-ascii?Q?7nTbSdI90gsljS2BxY8AiL4OH9zn9/pF94OqXhCIaOvXzGGi+5ipd7HUz+0q?=
 =?us-ascii?Q?r4b8ueKLYNRCypPhZDIG+AScl33m8aHR4i7qvwouqtGqY1JX+CYkU41kOKKx?=
 =?us-ascii?Q?g0YjGa2HYCNXhtldyUAPEzT9iDMPiQ0aws4lQ2hS1P6dhcVl8weAtSSQ/AQU?=
 =?us-ascii?Q?LWxEfY1urrE4laXZLxmvbHlBwHKkUXsmeY0N5KKKC1T7H6Go9AQMQhdU29mo?=
 =?us-ascii?Q?Kacj/XYpp+BLyEj/uWIQOKEjecwPgCFHpSEH+rGvBKrXsOn0Z4fBNAIw/GbG?=
 =?us-ascii?Q?MKSDGtkmwVOOqMlw5CCmtAQCdfZbFMmgqs+5ecjYyJ/MIBB/zMMD1oovb1W0?=
 =?us-ascii?Q?422A5wfelsm0AZMldaTQwAMW8A6uPkZUTjX/37/cyfoXAf0Or54QcOPL+g44?=
 =?us-ascii?Q?Ox16Xbowwe+djwa8qWuUnke4JVTfdoLP9Oyu9BzEvCDNUoct0FxDPvsm3sBs?=
 =?us-ascii?Q?+n6j1sKvjERgPNg1leQUUsmmcgxy/AabUAVAD7t816VswAKq3PkuDzXKrrTp?=
 =?us-ascii?Q?/8lbXvZtC4gqHRPn7m9ly8GSaVj9ZP+/LIw6o/XvfM2kIvI6btG6mJvtlJu6?=
 =?us-ascii?Q?RtwIAhuSoVa4aJf1du2pUIEM2JBqBaJ47pcAUQhGi99T1s2WaS1CX8ywemT8?=
 =?us-ascii?Q?E1pcopTg/mj0dKhql2k2ZengzXVt3CQlGQFSd685uX0ANVVTHFXunWYwzNiI?=
 =?us-ascii?Q?cHquYkI1g4qmIF0/sf4m9n2ISRhpUlbSINhAidHAGd0G/3kmLK8WhXAmaX+W?=
 =?us-ascii?Q?/pTpgqlh1G2U+J/qkNbiw4A9uLWG6B/VhbudTbBiEU/x7JRuBYd8Etr1TOht?=
 =?us-ascii?Q?jqN91A3Mx99YTfvZeQ+1p63bFdekCIFo/cnkyRwGH40w5FmzFUYQK06RCLbf?=
 =?us-ascii?Q?I3pjL2DVqR9Cx00p+XEXd3j0FJUN/tUtrn9yZojc1o5KeMeKOogGzHgO/2g/?=
 =?us-ascii?Q?8kWGVoK11UnIcwFJfwCnY97I6Ksh1V2ACePLL8817PFTNVC0AdWR/ikylLPC?=
 =?us-ascii?Q?hmZ1EJGF+PZxNEhaGDndNo3Qz8ttYh256nKznMosZdmnkFtG4Zc7ZSVVkoyr?=
 =?us-ascii?Q?Z7lkAK0mmFiX7VlCUQIDwG0aI1NpGHjYnCUetRGuTYcyrTY+jZUDXAmOjdOJ?=
 =?us-ascii?Q?R8vOURvvFhYFxJOhXHU+qE9UKXhU2qc5yrX+FLH0ZuSIcMKvcPDcYmg+8KfK?=
 =?us-ascii?Q?Smlzqx1scxzKkIDlpBW/ZH/9fegfux8IXHDXX89qXpjwjrCGfxzcS6VGk+s7?=
 =?us-ascii?Q?w9AM6nkcngzN1HK2GLPRnj0nXJ80IRg8pSysO+sUlW9PstP9MI5maJDZyTC6?=
 =?us-ascii?Q?b9gt281W6834Jk1S8EigS8rZMtJhiJtRMq4VEjAiJOaf7WhMFLgOS75AMfLi?=
 =?us-ascii?Q?Z5IodIepmVa0DV0IN169yQb2GjK82npuMb6D7bfBm55g4ghypTe+KQ1hmMog?=
 =?us-ascii?Q?C3np96YyNilR1MuZ7RXXFKMSnAuqsaYpncrmDipjyYv4szuEDxiIZr6rBh4X?=
 =?us-ascii?Q?Mp57Ejxi0Df45GU4inT2ZsNSdZ1YMQwmpl36iXZyBNX7GeO5ArjUbN2rBSHp?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd94d63f-ac7e-4fe0-b4c8-08da91e6f936
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 22:10:43.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLz3lG8W93ruMR8rxYRQc4ee8kDIrjpn59n1OSrZJ6vakDxdEQVNe4cQ/zaGmr06PMPnmLTomSEIu4wi7SCHMyIxHy5R3xkb+d707X6AvZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8812
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
CC: Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

--
v2: fix unused variables reported-by: kernel test robot <lkp@intel.com>
v3: - on fork set caba to current, so that caba is always a process
      which had initiated our creation, even for CLONE_PARENT case
    - move caba update to a later stage (to __unhash_process), so that
      zombies can be somebodies caba until fully released
v4: fix accidentally setting caba to thread leader when creating threads
---
 arch/ia64/kernel/mca.c |  3 +++
 fs/exec.c              |  1 +
 fs/proc/array.c        | 20 ++++++++++++++++++++
 include/linux/sched.h  |  7 +++++++
 init/init_task.c       |  3 +++
 kernel/exit.c          | 21 +++++++++++++++++++++
 kernel/fork.c          | 11 +++++++++--
 7 files changed, 64 insertions(+), 2 deletions(-)

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
index 90c85b17bf69..1bd3d815d77f 100644
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
@@ -2393,14 +2395,18 @@ static __latent_entropy struct task_struct *copy_process(
 	if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
 		p->real_parent = current->real_parent;
 		p->parent_exec_id = current->parent_exec_id;
-		if (clone_flags & CLONE_THREAD)
+		if (clone_flags & CLONE_THREAD) {
 			p->exit_signal = -1;
-		else
+			p->caba = p->real_parent;
+		} else {
 			p->exit_signal = current->group_leader->exit_signal;
+			p->caba = current;
+		}
 	} else {
 		p->real_parent = current;
 		p->parent_exec_id = current->self_exec_id;
 		p->exit_signal = args->exit_signal;
+		p->caba = p->real_parent;
 	}
 
 	klp_copy_process(p);
@@ -2455,6 +2461,7 @@ static __latent_entropy struct task_struct *copy_process(
 			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
 							 p->real_parent->signal->is_child_subreaper;
 			list_add_tail(&p->sibling, &p->real_parent->children);
+			list_add_tail(&p->cabd, &p->caba->cabds);
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
 			attach_pid(p, PIDTYPE_PGID);
-- 
2.37.1

