Return-Path: <linux-fsdevel+bounces-2040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC467E1A4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 07:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3C8281015
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 06:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B44436;
	Mon,  6 Nov 2023 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0B642
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 06:41:21 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2036.outbound.protection.outlook.com [40.92.75.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9C4100;
	Sun,  5 Nov 2023 22:41:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rpct1UekjIKqpMlEb5rTdAbAeFeGlWmsGmUcXYn3ikRVGEaypU7zV6TFwNx7Kvb6AbtTnkB+8kRUlI9P+Vp9sTkeQ4z0kW/6HirPbjp4Gl+nsdUD+dfGC9obnu1SOY/h15j/iDUeI/vh771X4R/DtgZY/JQnhMebWPZXCAnn6KKrrKor4R5S2l1YrO4bA9fK7b9MiOFA8I6exBNAQzCYFZtF2mFMVW5pCvKfkv2QArBvjffFVWIpNKvj3QVIFDmst8a2sy7T9pJJ6c050Vpj6TpD801velRHFioQmqhwSnpFUgL+wbotWoxYCm9kjhrErXepWSBgldnBHCP9c9zsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PPxTL5n7UVLVIbLtmo22EhAcBnb2iqOTpf3Ygq1wA8=;
 b=eGK7WpzCf0yW1FLQfxkZeYKMofLjWH475hvG6ZMgLkwGRJT8gi2yNcJSa7WdVESLZJLYfR8M/9o1ASf2fxqVe9zaK9+V7XFsyY2fEhFQm/FQH83tn0aQdEFgU9sYIPJB4uJywQn7aX1QcIIbnQj9QUJKnqmnbfpVhMsaVIo0XAXOCN6gOYaoyov52YnVZCMWxTWcj+o/HrwSihry2mj/DX7YcaUnkSTges+Jsiw2jMP82gBWIwb2b+fQ3LMULPhUVwY/l9FxvXXrt/BQUx7bLk3yAX45dQuXjYPod0IFpT78ub5y1kxc49fYBMigEmtj9sQTiz6+RdZF56zMOyuxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AS8P193MB2127.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 06:41:14 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 06:41:14 +0000
Message-ID:
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 6 Nov 2023 07:41:28 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v13] exec: Fix dead-lock in de_thread with ptrace_attach
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>,
 Christian Brauner <christian.brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Serge Hallyn <serge@hallyn.com>, James Morris
 <jamorris@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Helge Deller <deller@gmx.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
 Adrian Reber <areber@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 tiozhang <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Frederic Weisbecker <frederic@kernel.org>, YueHaibing
 <yuehaibing@huawei.com>, Paul Moore <paul@paul-moore.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Stefan Roesch <shr@devkernel.io>,
 Chao Yu <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>,
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <dchinner@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Zheng Yejian <zhengyejian1@huawei.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [kZtRcjYreHl9NUx5duaTrdw7vAxwIsIYmnYZLThPxhf5o8u8oKyyjw8qI1RyNLBG]
X-ClientProxiedBy: BE0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::16) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <f44d3bac-d5df-4315-8301-d96c80c2b793@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AS8P193MB2127:EE_
X-MS-Office365-Filtering-Correlation-Id: 3391394e-122c-4a2b-c2d5-08dbde935efa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kC/BTSPGzT7D8/mP0F1puBPejArIpT9m/JCzDIajdWDGkT2/dFWP/MdPUnA/ngg9cSvPAKV62jhRw5PROpxfgKIHkIv+xTwBs6l2IGo2VY2aMp2lwCdEubUdzBxReOPiU+LiYwB6soZDCcePLG44Fggl2tmy8oIZ8ZmTJjm53bp1MJpt+8bGpcH0b2hRR+Trl+q+20utZ4XsY0hgpwKYa3nbIlD68jg6DBj3c7lKRGhb72I4eQZYDcO2wgpddxSs/C2zmu3ldfYtFZPJmBwos2SGQPFA2Kr042reJBXWqi3TufSL2AxeoQk38pfwMOuzrE5BHwmUOXLeyurr99MDMZNR6y5M9vixoIcsb5r5soWRlFqZAl4zXuCZvC+b4feoggqu4LqgC/PT8r9vTGJus6fe6019LEVzfScoBR+ApqPPAe4RncCu5oaA9k/KoiwlNmbICDikjH3uY7gluBpoRtPiMCHU1jO+pa4kTttL4GZs6qyexHBGVIfAkW3e8Z7QDGlWSdyCrrul1gAN6jTfTlhi3ILrrR/Hn8G3dfe3gCuYoeCKcsOCpqXoY/+bSE6kwSaXbr0UzyJvBGMYoAOHAWf9nzCH8mHDufzLDuy3Kl8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUluY3pMS2FXNnAvNzRLRy9pR0U3VE4rL3prajJNSGErZjVYRitrZVo5d29E?=
 =?utf-8?B?WENzTGJxQXBVYnZnWm8vUCsvL2o2UkI3dEFvMTBPYVpZMWh4QXprSEk2Mm0z?=
 =?utf-8?B?MkhCK2RqRWZqa0M3YmZYcTkzdHdRdGpmNkJPQ0ZBL0grc3FYaTAwM2gvRURC?=
 =?utf-8?B?aWNqcFViOG1UbkJvREY1Qk52Wk5CWEpUMVczeGpMa2dMbEszN0p1NmdMWVF2?=
 =?utf-8?B?ekJidktrNnNwNU9TSW5aK1BMSjFWQTd2RWxQQ0FyR0VseHBzblpPRW9XV1ky?=
 =?utf-8?B?amlxS0FEQUFXY2lrMFcrWlY2WlpJRzUzRHNzSUtQWnBHUlJTb1lMajRvdm5v?=
 =?utf-8?B?ZHNsMDdqS1VYNm51eGRLMVFVRUhXYkFjNjdSQW5aZVpCSGNXdkh0YkJna2di?=
 =?utf-8?B?MWxsNEgrcUJyTktXWlNqclR1SEJQSUdGMzlFRCtNVC9pSVo2a1BGMFQ2d010?=
 =?utf-8?B?K3RMZlVZNnVKNmNQKzhzMlJLeVFVVi9QRDRsZSsxMDZmRGhReEtDSXlGeTlO?=
 =?utf-8?B?N21VT2RTQUZWSTJYQzFRT0dJNy9YVDlvNUNJbGU2OUVQcTNLejZwSDdZK01t?=
 =?utf-8?B?OGxRVlB1c29lUE5ZYXpnQjVCLzYweElxdXBiaHJQVmlITFNkcjN3YVNiOTc2?=
 =?utf-8?B?VTVvTEJpLzBSVzQ4Z2JtRHJUMW9iclp5a3U4RFZXODFVUmhyblNaSk0wOUdP?=
 =?utf-8?B?MzJ4QXEvMEZhcUs0aU9seFFkclhDdzlnMEpkWU4wT2ZIYnBZcTQ4OWRSM3lM?=
 =?utf-8?B?UHY2VSswbzk1c01nejR2Ym1peVRPa2RCT2xXaFBLWmVoM1Y0cTJPbWRzSDF0?=
 =?utf-8?B?QncxTnJuVFZVNFlNOC9VZHU3NHFCTmJNMTgvanNNeFpHNFNWRk02Zkg4eFdn?=
 =?utf-8?B?Q29uRVJkOU94ZDR2YkdBdG8vdlJ0YU5wVTVJMnBPMkhXSEJPWUZhR1ZVaHFz?=
 =?utf-8?B?L1ZVT29FWGlCd2gxY05tdStoT2pUcldVdG9Xd0lvTk0rcWJHVHRWb0xxZno3?=
 =?utf-8?B?UGw1blYvb2VJcUtOQSt1dEdPa0FlL2RJSzRHRE1zNzhERGVxQTJ3VFdxdnhk?=
 =?utf-8?B?ZDhuL3BvL0FVejhPVW1yajZXNGYzWGI1QzVKak8xa2xvU2Q3cGJ0T3kxKzli?=
 =?utf-8?B?RHhrOENaRDZ1MWpOM3VWQkdmd2pOcDhUUGdsYVFwWElPSFZZZkFabWdJWi9W?=
 =?utf-8?B?cFozRDhySXZHbG1VVzkyNTJYZUZOQk55Z2JiS3IxNVRtTFJzVjdmZDhSUWlv?=
 =?utf-8?B?RlIwZE9ObGRxNkZKc2trK3dtam9xYXlEVENpOHhibWRHSS9DZVhDQ2hRdUdm?=
 =?utf-8?B?UXN5dlhkWTBSOFliNVVINkU5YjEwQjNWaGM2WWpaUEN2YmhvK2tTR21aWnZN?=
 =?utf-8?B?ZnVQWGVVYUNZWGJtWE90SDc5VlFkVDVIOENrL29TSVVkd2pJUldDOG9EWk9C?=
 =?utf-8?B?bmV0aFNMN3orS0FqNC9WRCtYTkhwYWxwT0QrRFhwcmVkc3YxUE5xUFowdjBk?=
 =?utf-8?B?b1hhem5QWjM1aWZKb2hBbmszWE9uVCtBRDFOak00d1RwdHJJOUxwTmRCWTl0?=
 =?utf-8?B?MzZ0cDRyL0ZHdDYzSTl2NlhGUW9NbnZWcTFjRlNwZE0xdFpaNnYvMCs4bHlx?=
 =?utf-8?B?eDFDMHJwY1pwL0FYbWV5RWhrOU0rRkp2R3pGMnhock03ajNNaHQrM0U3R2Nr?=
 =?utf-8?B?Vnd0dTFDWWhKMVE3dUVxWG95S01jTUdVVVlod1B1UkNGTXdsQ05RMmpPR21E?=
 =?utf-8?Q?BCVZyD4eksmUzoq1e4=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3391394e-122c-4a2b-c2d5-08dbde935efa
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 06:41:14.6657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2127

This introduces signal->exec_bprm, which is used to
fix the case when at least one of the sibling threads
is traced, and therefore the trace process may dead-lock
in ptrace_attach, but de_thread will need to wait for the
tracer to continue execution.

The solution is to detect this situation and allow
ptrace_attach to continue by temporarily releasing the
cred_guard_mutex, while de_thread() is still waiting for
traced zombies to be eventually released by the tracer.
In the case of the thread group leader we only have to wait
for the thread to become a zombie, which may also need
co-operation from the tracer due to PTRACE_O_TRACEEXIT.

When a tracer wants to ptrace_attach a task that already
is in execve, we simply retry the ptrace_may_access
check while temporarily installing the new credentials
and dumpability which are about to be used after execve
completes.  If the ptrace_attach happens on a thread that
is a sibling-thread of the thread doing execve, it is
sufficient to check against the old credentials, as this
thread will be waited for, before the new credentials are
installed.

Other threads die quickly since the cred_guard_mutex is
released, but a deadly signal is already pending.  In case
the mutex_lock_killable misses the signal, the non-zero
current->signal->exec_bprm makes sure they release the
mutex immediately and return with -ERESTARTNOINTR.

This means there is no API change, unlike the previous
version of this patch which was discussed here:

https://lore.kernel.org/lkml/b6537ae6-31b1-5c50-f32b-8b8332ace882@hotmail.de/

See tools/testing/selftests/ptrace/vmaccess.c
for a test case that gets fixed by this change.

Note that since the test case was originally designed to
test the ptrace_attach returning an error in this situation,
the test expectation needed to be adjusted, to allow the
API to succeed at the first attempt.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 fs/exec.c                                 | 69 ++++++++++++++++-------
 fs/proc/base.c                            |  6 ++
 include/linux/cred.h                      |  1 +
 include/linux/sched/signal.h              | 18 ++++++
 kernel/cred.c                             | 28 +++++++--
 kernel/ptrace.c                           | 32 +++++++++++
 kernel/seccomp.c                          | 12 +++-
 tools/testing/selftests/ptrace/vmaccess.c | 23 +++++---
 8 files changed, 155 insertions(+), 34 deletions(-)

v10: Changes to previous version, make the PTRACE_ATTACH
retun -EAGAIN, instead of execve return -ERESTARTSYS.
Added some lessions learned to the description.

v11: Check old and new credentials in PTRACE_ATTACH again without
changing the API.

Note: I got actually one response from an automatic checker to the v11 patch,

https://lore.kernel.org/lkml/202107121344.wu68hEPF-lkp@intel.com/

which is complaining about:

>> kernel/ptrace.c:425:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *real_cred @@

   417			struct linux_binprm *bprm = task->signal->exec_bprm;
   418			const struct cred *old_cred;
   419			struct mm_struct *old_mm;
   420	
   421			retval = down_write_killable(&task->signal->exec_update_lock);
   422			if (retval)
   423				goto unlock_creds;
   424			task_lock(task);
 > 425			old_cred = task->real_cred;

v12: Essentially identical to v11.

- Fixed a minor merge conflict in linux v5.17, and fixed the
above mentioned nit by adding __rcu to the declaration.

- re-tested the patch with all linux versions from v5.11 to v6.6

v10 was an alternative approach which did imply an API change.
But I would prefer to avoid such an API change.

The difficult part is getting the right dumpability flags assigned
before de_thread starts, hope you like this version.
If not, the v10 is of course also acceptable.

v13: Fixed duplicated Return section in function header of
is_dumpability_changed which was reported by the kernel test robot


Thanks
Bernd.

diff --git a/fs/exec.c b/fs/exec.c
index 2f2b0acec4f0..902d3b230485 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1041,11 +1041,13 @@ static int exec_mmap(struct mm_struct *mm)
 	return 0;
 }
 
-static int de_thread(struct task_struct *tsk)
+static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
 {
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *t = tsk;
+	bool unsafe_execve_in_progress = false;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -1068,6 +1070,19 @@ static int de_thread(struct task_struct *tsk)
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
 
+	while_each_thread(tsk, t) {
+		if (unlikely(t->ptrace)
+		    && (t != tsk->group_leader || !t->exit_state))
+			unsafe_execve_in_progress = true;
+	}
+
+	if (unlikely(unsafe_execve_in_progress)) {
+		spin_unlock_irq(lock);
+		sig->exec_bprm = bprm;
+		mutex_unlock(&sig->cred_guard_mutex);
+		spin_lock_irq(lock);
+	}
+
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
@@ -1158,6 +1173,11 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
+	if (unlikely(unsafe_execve_in_progress)) {
+		mutex_lock(&sig->cred_guard_mutex);
+		sig->exec_bprm = NULL;
+	}
+
 	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
@@ -1169,6 +1189,11 @@ static int de_thread(struct task_struct *tsk)
 	return 0;
 
 killed:
+	if (unlikely(unsafe_execve_in_progress)) {
+		mutex_lock(&sig->cred_guard_mutex);
+		sig->exec_bprm = NULL;
+	}
+
 	/* protects against exit_notify() and __exit_signal() */
 	read_lock(&tasklist_lock);
 	sig->group_exec_task = NULL;
@@ -1253,6 +1278,24 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		return retval;
 
+	/* If the binary is not readable then enforce mm->dumpable=0 */
+	would_dump(bprm, bprm->file);
+	if (bprm->have_execfd)
+		would_dump(bprm, bprm->executable);
+
+	/*
+	 * Figure out dumpability. Note that this checking only of current
+	 * is wrong, but userspace depends on it. This should be testing
+	 * bprm->secureexec instead.
+	 */
+	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
+	    is_dumpability_changed(current_cred(), bprm->cred) ||
+	    !(uid_eq(current_euid(), current_uid()) &&
+	      gid_eq(current_egid(), current_gid())))
+		set_dumpable(bprm->mm, suid_dumpable);
+	else
+		set_dumpable(bprm->mm, SUID_DUMP_USER);
+
 	/*
 	 * Ensure all future errors are fatal.
 	 */
@@ -1261,7 +1304,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	/*
 	 * Make this the only thread in the thread group.
 	 */
-	retval = de_thread(me);
+	retval = de_thread(me, bprm);
 	if (retval)
 		goto out;
 
@@ -1284,11 +1327,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
-	/* If the binary is not readable then enforce mm->dumpable=0 */
-	would_dump(bprm, bprm->file);
-	if (bprm->have_execfd)
-		would_dump(bprm, bprm->executable);
-
 	/*
 	 * Release all of the old mmap stuff
 	 */
@@ -1350,18 +1388,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	me->sas_ss_sp = me->sas_ss_size = 0;
 
-	/*
-	 * Figure out dumpability. Note that this checking only of current
-	 * is wrong, but userspace depends on it. This should be testing
-	 * bprm->secureexec instead.
-	 */
-	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
-	    !(uid_eq(current_euid(), current_uid()) &&
-	      gid_eq(current_egid(), current_gid())))
-		set_dumpable(current->mm, suid_dumpable);
-	else
-		set_dumpable(current->mm, SUID_DUMP_USER);
-
 	perf_event_exec();
 	__set_task_comm(me, kbasename(bprm->filename), true);
 
@@ -1480,6 +1506,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
 		return -ERESTARTNOINTR;
 
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
 		return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ffd54617c354..0da9adfadb48 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2788,6 +2788,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		rv = -ERESTARTNOINTR;
+		goto out_free;
+	}
+
 	rv = security_setprocattr(PROC_I(inode)->op.lsm,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
diff --git a/include/linux/cred.h b/include/linux/cred.h
index f923528d5cc4..b01e309f5686 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -159,6 +159,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
 extern struct cred *cred_alloc_blank(void);
 extern struct cred *prepare_creds(void);
 extern struct cred *prepare_exec_creds(void);
+extern bool is_dumpability_changed(const struct cred *, const struct cred *);
 extern int commit_creds(struct cred *);
 extern void abort_creds(struct cred *);
 extern const struct cred *override_creds(const struct cred *);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0014d3adaf84..14df7073a0a8 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -234,9 +234,27 @@ struct signal_struct {
 	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
 					 * killed by the oom killer */
 
+	struct linux_binprm *exec_bprm;	/* Used to check ptrace_may_access
+					 * against new credentials while
+					 * de_thread is waiting for other
+					 * traced threads to terminate.
+					 * Set while de_thread is executing.
+					 * The cred_guard_mutex is released
+					 * after de_thread() has called
+					 * zap_other_threads(), therefore
+					 * a fatal signal is guaranteed to be
+					 * already pending in the unlikely
+					 * event, that
+					 * current->signal->exec_bprm happens
+					 * to be non-zero after the
+					 * cred_guard_mutex was acquired.
+					 */
+
 	struct mutex cred_guard_mutex;	/* guard against foreign influences on
 					 * credential calculations
 					 * (notably. ptrace)
+					 * Held while execve runs, except when
+					 * a sibling thread is being traced.
 					 * Deprecated do not use in new code.
 					 * Use exec_update_lock instead.
 					 */
diff --git a/kernel/cred.c b/kernel/cred.c
index 98cb4eca23fb..586cb6c7cf6b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -433,6 +433,28 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
 	return false;
 }
 
+/**
+ * is_dumpability_changed - Will changing creds from old to new
+ * affect the dumpability in commit_creds?
+ *
+ * Return: false - dumpability will not be changed in commit_creds.
+ *         true  - dumpability will be changed to non-dumpable.
+ *
+ * @old: The old credentials
+ * @new: The new credentials
+ */
+bool is_dumpability_changed(const struct cred *old, const struct cred *new)
+{
+	if (!uid_eq(old->euid, new->euid) ||
+	    !gid_eq(old->egid, new->egid) ||
+	    !uid_eq(old->fsuid, new->fsuid) ||
+	    !gid_eq(old->fsgid, new->fsgid) ||
+	    !cred_cap_issubset(old, new))
+		return true;
+
+	return false;
+}
+
 /**
  * commit_creds - Install new credentials upon the current task
  * @new: The credentials to be assigned
@@ -467,11 +489,7 @@ int commit_creds(struct cred *new)
 	get_cred(new); /* we will require a ref for the subj creds too */
 
 	/* dumpability changes */
-	if (!uid_eq(old->euid, new->euid) ||
-	    !gid_eq(old->egid, new->egid) ||
-	    !uid_eq(old->fsuid, new->fsuid) ||
-	    !gid_eq(old->fsgid, new->fsgid) ||
-	    !cred_cap_issubset(old, new)) {
+	if (is_dumpability_changed(old, new)) {
 		if (task->mm)
 			set_dumpable(task->mm, suid_dumpable);
 		task->pdeath_signal = 0;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 443057bee87c..eb1c450bb7d7 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -20,6 +20,7 @@
 #include <linux/pagemap.h>
 #include <linux/ptrace.h>
 #include <linux/security.h>
+#include <linux/binfmts.h>
 #include <linux/signal.h>
 #include <linux/uio.h>
 #include <linux/audit.h>
@@ -435,6 +436,28 @@ static int ptrace_attach(struct task_struct *task, long request,
 	if (retval)
 		goto unlock_creds;
 
+	if (unlikely(task->in_execve)) {
+		struct linux_binprm *bprm = task->signal->exec_bprm;
+		const struct cred __rcu *old_cred;
+		struct mm_struct *old_mm;
+
+		retval = down_write_killable(&task->signal->exec_update_lock);
+		if (retval)
+			goto unlock_creds;
+		task_lock(task);
+		old_cred = task->real_cred;
+		old_mm = task->mm;
+		rcu_assign_pointer(task->real_cred, bprm->cred);
+		task->mm = bprm->mm;
+		retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+		rcu_assign_pointer(task->real_cred, old_cred);
+		task->mm = old_mm;
+		task_unlock(task);
+		up_write(&task->signal->exec_update_lock);
+		if (retval)
+			goto unlock_creds;
+	}
+
 	write_lock_irq(&tasklist_lock);
 	retval = -EPERM;
 	if (unlikely(task->exit_state))
@@ -508,6 +531,14 @@ static int ptrace_traceme(void)
 {
 	int ret = -EPERM;
 
+	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
+		return -ERESTARTNOINTR;
+
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	write_lock_irq(&tasklist_lock);
 	/* Are we already being traced? */
 	if (!current->ptrace) {
@@ -523,6 +554,7 @@ static int ptrace_traceme(void)
 		}
 	}
 	write_unlock_irq(&tasklist_lock);
+	mutex_unlock(&current->signal->cred_guard_mutex);
 
 	return ret;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..b29bbfa0b044 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1955,9 +1955,15 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	 * Make sure we cannot change seccomp or nnp state via TSYNC
 	 * while another thread is in the middle of calling exec.
 	 */
-	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
-	    mutex_lock_killable(&current->signal->cred_guard_mutex))
-		goto out_put_fd;
+	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
+		if (mutex_lock_killable(&current->signal->cred_guard_mutex))
+			goto out_put_fd;
+
+		if (unlikely(current->signal->exec_bprm)) {
+			mutex_unlock(&current->signal->cred_guard_mutex);
+			goto out_put_fd;
+		}
+	}
 
 	spin_lock_irq(&current->sighand->siglock);
 
diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
index 4db327b44586..3b7d81fb99bb 100644
--- a/tools/testing/selftests/ptrace/vmaccess.c
+++ b/tools/testing/selftests/ptrace/vmaccess.c
@@ -39,8 +39,15 @@ TEST(vmaccess)
 	f = open(mm, O_RDONLY);
 	ASSERT_GE(f, 0);
 	close(f);
-	f = kill(pid, SIGCONT);
-	ASSERT_EQ(f, 0);
+	f = waitpid(-1, NULL, 0);
+	ASSERT_NE(f, -1);
+	ASSERT_NE(f, 0);
+	ASSERT_NE(f, pid);
+	f = waitpid(-1, NULL, 0);
+	ASSERT_EQ(f, pid);
+	f = waitpid(-1, NULL, 0);
+	ASSERT_EQ(f, -1);
+	ASSERT_EQ(errno, ECHILD);
 }
 
 TEST(attach)
@@ -57,22 +64,24 @@ TEST(attach)
 
 	sleep(1);
 	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
-	ASSERT_EQ(errno, EAGAIN);
-	ASSERT_EQ(k, -1);
+	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, WNOHANG);
 	ASSERT_NE(k, -1);
 	ASSERT_NE(k, 0);
 	ASSERT_NE(k, pid);
 	ASSERT_EQ(WIFEXITED(s), 1);
 	ASSERT_EQ(WEXITSTATUS(s), 0);
-	sleep(1);
-	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, 0);
 	ASSERT_EQ(k, pid);
 	ASSERT_EQ(WIFSTOPPED(s), 1);
 	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
-	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, 0);
 	ASSERT_EQ(k, pid);
-- 
2.39.2


