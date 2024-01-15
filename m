Return-Path: <linux-fsdevel+bounces-7996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8A82E097
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28EDFB21780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F9118C08;
	Mon, 15 Jan 2024 19:21:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2047.outbound.protection.outlook.com [40.92.89.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045718E08;
	Mon, 15 Jan 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSZigkXvBmhPoMRjW2s+LCFvmaZ5Vc8m260hzc87rlhDLfA2pGtFFHcfmHU+7Rihctpm9vJgLHBo8q7fjCc3Lx4VBiU+uITHlbENKvNvTLNtQxRlPkW7KlMBFSuEs3DN76U7eS+TbsIWZqtE0vdtV5id5GOwyC3+8Qdxd3oGADTZerBnkb42eLWvr8u3Hwby/LwgZpWvFqVMGzppLdEusk9NcR1tkFSIFfL2Iv2aXSWVg1IFwO3tpOS9pAEA/reQm0vOh9pk+sEkguVt6HMU2Saz0jKDjRSG3taEO0gHghkPjpxe32KkvKXsxGBBI1AhHRqwjHcT4+XW7xd9cWe96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIX4vE3hSEcCkyBbrMWuCzGw0KZY3qkncd3yvXta8vM=;
 b=D6rWqtLQ9gUqHv8CE59RS6qLomAE4zYzFgN3YK0eckId5sD2Ya48y/amO7psFNWy7oZb71zo/xDfGVIMFeJCD99sptnNAJRTmPz5fjYVdNsWnSt9PIt4shZoDzMgByU4Nb0U3SmdGsVgFU9tFtwutEWbrh7o8Cuuh+O+BMGvrW050cUXSmL06PFaqqKvbdZW7T2NLF+6zpsxiOSoHq6PBngSk1U7BKV+cPsiCblNvrx0ch0FmmvK9gV/9TMzjJa3VYDhge1sh1Hdygje4fAlbvsn0bkRAHE8wf5axP2GQbsf1H8yBQpF3FAIYWgkCKf9r/XvQwmYqbxLFpEq1u+u4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AM0P193MB0769.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:16d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 19:21:25 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 19:21:24 +0000
Message-ID:
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 15 Jan 2024 20:22:19 +0100
User-Agent: Mozilla Thunderbird
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH v14] exec: Fix dead-lock in de_thread with ptrace_attach
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Christian Brauner <brauner@kernel.org>,
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
 Shuah Khan <shuah@kernel.org>, Zheng Yejian <zhengyejian1@huawei.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Paul Moore <paul@paul-moore.com>, Elena Reshetova
 <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>,
 Mateusz Guzik <mjguzik@gmail.com>, YueHaibing <yuehaibing@huawei.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>, tiozhang <tiozhang@didiglobal.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [qPgpiNw4aTVk08czLSgjxjV3rZs+jr4OtE5nm5xzNtCiQ0nRDn88asflsy1Ba3tb]
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <61ad3ab4-398e-47f7-9f0d-bfaeed82c3f5@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AM0P193MB0769:EE_
X-MS-Office365-Filtering-Correlation-Id: ed83c9cb-790c-4083-1b3b-08dc15ff2987
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YWKr2sPCnNFt8y72rAn9WZdvOnV1WfwTCfiImQucVPGcyCnvb6ol9Uquhnilv+iGmk1JFuA1LeQI1uxk/gCqWqF3+xQQDpgPAWks+ja8g47LMUxr+oHZl+HxHW2NoVNjEuz0xcUDs5RE+RY0rkgzwjz9Hh9CR7g5lwK9lIHJAOiO09pTmOyN1Qdz39w3HRc2d58F0mqRkl4oJwEfM4iocd0+QUHzbHfqSzwAfkl3yEZOWVOYzBVtmvVVWq8YAh8kEQnPsOae7IzK5U6fHRt1wfRsFPwo5j/Lo8eQtsNzCJ8iBI5vTADv82RNSS6VyBKMJb+PmFJAFnMzSlYPdMNKA+ocwF9tJiGyvRYPmu2OF9XgN0Dl55brNnuhGFsMq8ECz1FBN2s8luAZINNdy/DoNmPGnqrQUwg3wrOEfRnN0plBBpDqS4iC/tvrNuOOpORUoKwFa6a4M1CZIXj2hM9A+dT0na1AvrBX9euaAhhumQPl5uFXlrIsbpe7meoUQxybxzyZGYyYaZVzqc1Z8a/6oqnHfm/5+ACox56OWOUGeC4AxJm6IueH6a7KF6oh1Yr10RKIeMNfA2wTm3Y+3RMo+qN83vb8MOJALuFxbEXs1UY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di91Y2VrVExOeGp5VnZnalhhbUpsc1BwREdiNUlITFZsc0NyTXBOZStTUDVX?=
 =?utf-8?B?SklTbXdPaTV5YnNwS1dTN2dHbGZtTFFMUHdReEVOOXVQdVVvRTkrTlNmTG5s?=
 =?utf-8?B?WUxFdnFXSjJTS0owWmxSTXJnVkZsbUFPbjhGSWIvaVk1UU1kME51TXdSZ3I2?=
 =?utf-8?B?OWdZbjlac3pNM3p2bThNeVJGdUs1cHVHSmZuWlgvc3M4YmlSWEF4elQrbWQ0?=
 =?utf-8?B?ZmNLV2tyaTJmR2ZkTUkvRUtxRG1kZ2p2ZWorVk5rSVQvTzBPdm05T0pHMVBn?=
 =?utf-8?B?SDhYZ1gycDMxZ3J3VHFzcGZkRWRLYWNEbzJLZE9rcERlKytJNllZTXNibWRV?=
 =?utf-8?B?LzJrcUE1cDJ4K0dKM1Y1dW1oM0NuOHBKYmtnZy9oN3BxRXdvS29zcFRnNU9l?=
 =?utf-8?B?cUp1Y3BkUjhVMUtzM29Wa0d4TW5YQUp4QmozTnIwdGhpUDR1cXNWUWRkYW94?=
 =?utf-8?B?RkpTQ251TlJxZDhEM0pGTXh2M0xMekx3UkdocjBSWVUwZG5iVHFGL3E4dGVt?=
 =?utf-8?B?Rk5yYmV2UU5MVy9WUExrMjAydnR1Z2NvMjBrNHZKbDN6T1ZFOXF2K2dxMVpw?=
 =?utf-8?B?TW04Mjg1cnRKV29zUkRKeFB1cS9aWjBwMHAwd1NQdnNDdmFyRG1qWHRSVmNW?=
 =?utf-8?B?VDA2eXE5cU9wZWk2Z282Rm5iWDQrckNmWm5kWWZXVnF2dGJnMkZwM3NOa1li?=
 =?utf-8?B?MzRjc2pxU3EzTVo2dHdzTHpkT3Y3Zm1yQjRmTkgxVVhSNUFxQ2NvL09HbnBL?=
 =?utf-8?B?ZXRoU056NVp1eHp2RDNCYzBhUy9BejVSRW5oOWw5SWl2RnZRTjNkWjBSb3pj?=
 =?utf-8?B?aHk5RzhZam1YSGJERTRLak1yZGw1WURhMWIzV3E1ZmFwbnA0cTlRR3h2b214?=
 =?utf-8?B?L1JqQkU1bEE4S2JNTVhxa0NOT2dUd1pCdzV5MkxmSWNEenJBeG96SEd6ZGZ6?=
 =?utf-8?B?Uk02YXdMNE5IZXpsQkRxeDNmZmloSGpWSmRzVEE1ZDdCVW9QR0JXd1NHVDJD?=
 =?utf-8?B?SERuUjhRQWh1YWtMMjN1VFo3eDJSbWRQcUJNZzFJTDVhTnREQlJDeGluU1A1?=
 =?utf-8?B?dFlCTVRxbnFVVndXOEJYajNrVHFyQllJdnREYllsOW9FZ2swQkpqZTZ3WEZH?=
 =?utf-8?B?VU91SHd0VTJVcWZJUXFtWElQa2NhcDRiVTBiWEY3RXJnVTg1NWRGRWVCcU55?=
 =?utf-8?B?cThQd2V5dEx3VVlRQ3FFaXNaUSsyWHJORUE4VjVQRmUzV0FEb0pva3ltSGJT?=
 =?utf-8?B?SU9la0hoYXBVZTBBZkJlbWlFbTBRbHd6N2VtYk1rdHVIMEMxUVpRc0V3RnJQ?=
 =?utf-8?B?QlZDTHRvZCtvbHFlbHlJT1BDSFhoR1d1ZWdRMC80Zm9VWUZDemd5SzNLY3ZE?=
 =?utf-8?B?b2VzcERNTkVwK1UzRFF6VTc2WGc3cko4QlBYNDhsQmdLSExickEyZ2pONzJx?=
 =?utf-8?B?Sm5OOFROUUJPcTVDbWU5aHdBbFA3dm5saXl3Tlp1SUVqMUtRblVxMlRZYUFz?=
 =?utf-8?B?N2JtU2lwWEswZzNsRnRYSTkvdi9RdisxU2hnclhkcVJVbTNaR0x1YXJoMUJO?=
 =?utf-8?B?SUhDaWJpUmY2c1hySU5PdzZLKzErd25rMVdBT0NhSWMxZ0UrSkRRTWd4cHVT?=
 =?utf-8?B?eHZmSGJHK3BHMFRET3piZHh2aDN6ejBmWTBaWTBrTWNDUURPekJJVmYyUDFr?=
 =?utf-8?B?S3pldmxjMmlOSHQxeGhQSldEM0U5TVM5aFRncXQ1VWNlNy9GL2VBZDlUNHVp?=
 =?utf-8?Q?1sQkcZu5P4tQxXeLoQ=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ed83c9cb-790c-4083-1b3b-08dc15ff2987
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 19:21:24.0892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0769

This introduces signal->exec_bprm, which is used to
fix the case when at least one of the sibling threads
is traced, and therefore the trace process may dead-lock
in ptrace_attach, but de_thread will need to wait for the
tracer to continue execution.

The problem happens when a tracer tries to ptrace_attach
to a multi-threaded process, that does an execve in one of
the threads at the same time, without doing that in a forked
sub-process.  That means: There is a race condition, when one
or more of the threads are already ptraced, but the thread
that invoked the execve is not yet traced.  Now in this
case the execve locks the cred_guard_mutex and waits for
de_thread to complete.  But that waits for the traced
sibling threads to exit, and those have to wait for the
tracer to receive the exit signal, but the tracer cannot
call wait right now, because it is waiting for the ptrace
call to complete, and this never does not happen.
The traced process and the tracer are now in a deadlock
situation, and can only be killed by a fatal signal.

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
return -EAGAIN, instead of execve return -ERESTARTSYS.
Added some lessions learned to the description.

v11: Check old and new credentials in PTRACE_ATTACH again without
changing the API.

Note: I got actually one response from an automatic checker to the v11 patch,

https://lore.kernel.org/lkml/202107121344.wu68hEPF-lkp@intel.com/

which is complaining about:

>> >> kernel/ptrace.c:425:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *real_cred @@

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

v14: rebased to v6.7, refreshed and retested.
And added a more detailed description of the actual bug.


Thanks
Bernd.

diff --git a/fs/exec.c b/fs/exec.c
index 6d9ed2d765ef..f2cf7c58fe16 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1039,11 +1039,13 @@ static int exec_mmap(struct mm_struct *mm)
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
@@ -1066,6 +1068,19 @@ static int de_thread(struct task_struct *tsk)
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
@@ -1156,6 +1171,11 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
+	if (unlikely(unsafe_execve_in_progress)) {
+		mutex_lock(&sig->cred_guard_mutex);
+		sig->exec_bprm = NULL;
+	}
+
 	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
@@ -1167,6 +1187,11 @@ static int de_thread(struct task_struct *tsk)
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
@@ -1251,6 +1276,24 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1259,7 +1302,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	/*
 	 * Make this the only thread in the thread group.
 	 */
-	retval = de_thread(me);
+	retval = de_thread(me, bprm);
 	if (retval)
 		goto out;
 
@@ -1282,11 +1325,6 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1348,18 +1386,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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
 
@@ -1478,6 +1504,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
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
index dd31e3b6bf77..99ff3420138b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2784,6 +2784,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
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
index 2976f534a7a3..a1a1ac38f749 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -153,6 +153,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
 extern struct cred *cred_alloc_blank(void);
 extern struct cred *prepare_creds(void);
 extern struct cred *prepare_exec_creds(void);
+extern bool is_dumpability_changed(const struct cred *, const struct cred *);
 extern int commit_creds(struct cred *);
 extern void abort_creds(struct cred *);
 extern const struct cred *override_creds(const struct cred *);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3499c1a8b929..85d8f8f2f44f 100644
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
index c033a201c808..72aadde3f10c 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -375,6 +375,28 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
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
@@ -403,11 +425,7 @@ int commit_creds(struct cred *new)
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
index d8b5e13a2229..578bc02eea27 100644
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

