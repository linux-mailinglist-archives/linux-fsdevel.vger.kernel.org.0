Return-Path: <linux-fsdevel+bounces-8615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA798397B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A551F22183
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FACE823B0;
	Tue, 23 Jan 2024 18:30:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2011.outbound.protection.outlook.com [40.92.75.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C377F7E3;
	Tue, 23 Jan 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034600; cv=fail; b=uc1f/4c5xHzVF7NmIwuLmRjPqLVeej9ifhFkkTr3JTz7yiCPOdnDEA6HMWKyxk+BBvF3WQZIbq5weLLTg8rJjJWJsw6ijGie6L/llXIacG5Y0s5ccHM3EK96l3tFfI5TAiaWrEzfUrptyAElfDNYaewdPELelUgCDmNO7t8yXqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034600; c=relaxed/simple;
	bh=OIOQ1ucG9Jg0bt9051xhIY2wVvuZETgCm75Z6eAeqf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ku/y7kfbxLMRiolkMR7y7VowqTzZSdkbBSLXjHdFXVbjGL+S38w0nhYingIOK4wOQt9064q8o9R6NubJ9U43WaKeubmb49NfEj5zLw/1RvBjee5MdehPPdhMkhk3tBSYBy0ZxxcbWjCV8TJO4OZC8s0nqtaM0D/Av6HAyZt0lBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.75.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwwoKl6ZTJHVAqfpRYhpiK+vebLZXOb3PJIGQPqZ2HDWiF3h22V9LQd2XHOO5CFks0awEGJRTEdynDScyyF+LR675EQfsFAvMDnBNe2u/bEY3Qbt3Z146ehsUdvv1STObbg2GPKUc7CngHGsKSvP6v15w98ZWX2HTFSE0bODn5JVJn+9uj86Z+NugdgMvnk3CRUq4H/aY+vCuw0hywnj9t0+UcMw6psDH0d816PT3ukIVGNedpXhUvp3E1y7jqFjfZq3gaX+Mjgp+Ebc1vrlL1kXFQKuuFXvf1RgG3FazgFhwIqc4qgD60Y2cZyh2uiDD6P+1D5s7sxCO3vkfY/CKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDbj6KmZ5ESwnYdMCT68YR/dQwRuKGdvO6l07LuUBj8=;
 b=M6xbBbt4iXdzRHSm4FLITrv2ZokH7Oi/PmBPkA5r9S6f8NmPJKHn/e5CX3x3R+YiXfXuGX5v9ywTD7iE6eIZFK9cVaQU3RYSOGsJM4/nR1DIex39zllEtdlumR0fTbSdgJnY3sj51RJiSieoGq4KMepM+VSY+kzhszNzILfDIUQsGp/Q1Kcl9ezszHcCfsQQfbCSEiNFVZ535sB4JguzlfnqhPAIBtKB62FgLi46R3v9WCZMwO7SC8P3wyAyGuSY1xmcW33dHq8KNFt8jVYEJV2qnWu2L9DQlCojvKMfBwKR/NQ3ikHYD63SwPQqHIDC9Wi3lTYYgRfg4S4jtseqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by GV1P193MB2420.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 18:29:53 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 18:29:53 +0000
Message-ID:
 <AS8P193MB1285110CC784C4BB30DAC0CAE4742@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Tue, 23 Jan 2024 19:30:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] exec: Fix dead-lock in de_thread with ptrace_attach
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Christian Brauner <brauner@kernel.org>,
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
 Elena Reshetova <elena.reshetova@intel.com>,
 David Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <20240116152210.GA12342@redhat.com>
 <AS8P193MB128538BC3833E654F56DA801E4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <20240117163739.GA32526@redhat.com>
 <AS8P193MB1285FDD902CC57C781AF2770E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <202401221328.5E7A82C32@keescook>
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <202401221328.5E7A82C32@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [CYKsCZ28C9PzbhUtTikJvX1isSx/7E7Ab95dzr3eRnM+pWz+vFLYoWHTL4A/s7VY]
X-ClientProxiedBy: FR0P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::7) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <a93e94d5-4d2b-4fb5-80ef-f5d4789b0370@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|GV1P193MB2420:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dd4fe0-ba4e-4a1c-bdb7-08dc1c414a66
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GrJaGJZNJBYtPEfwIej/hiB2SloSrNUaljEnO0vTxg4oqCYLXTV5zJdI1jt7Hl6HCZE1ldbIWO/dwfsT7dWGppM0Z3c7sPSQVmXP3L/7b/kHvP7In6do6ZKClkF4dGezEns/q+yGKDoM8c33aHblXrIwzSh5IyU+NoMtiEQURMT4EuVUmJXnCBFTn7E/Xq4WaxeL/Wbc0d8rewbLA/nBxp4q4P8mRkYVGVq9gj/CoCSe6DN28fJZt85+7ou/qN4hkMCmRKcRceyGPeofpQJuVT2atFw+uY//EAQ7eDh5r0MpoYhfGiWkEuRbBT1NF0BJqSG4ajBfl4En00AkoP1tdf+YuufLGCZjgveUUQws3SaaNXmztbOgwOzIWrK/U+wq4cZrZXKDddzjP65OJ2k7p8g7Y2Lma+a4g/hMduLaO9YOdymWsPCyV80S/BuSaD97A9S7cuLSb2Je0Stu4oj0ca/4wveJkq9gKA57evZFYiS+Qp6LD7liHzr64oLOUdc+C0Z/iZ7uSE9ahewlTtPOJ8J5X/9mEQGU/Ef4ryIwmAnpB94iqdzO3Bij/IDfd6Kh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkdUUDQzRERGT1M5b09kVklNS2ozOXRZbUcyajBiRlZvQzkxNEpmV1BLUjhE?=
 =?utf-8?B?Z2NqeHRycGsxTFdqQ2trSDdaTTNUc2RodHFweWU0TUpuWkRQb0hzdndXOFVo?=
 =?utf-8?B?M0dTYU9OeHFldUFnZHZWSmFTRHd6M0hpR281dG9kMlFya2tYdWxSaHltc2Mz?=
 =?utf-8?B?ME1DTGQydTlyeXV5NXc3VERPTWhCeDlmK2ovYnlXK01aV1dtY2JkYnJ0cmFl?=
 =?utf-8?B?aGNnTzVzMmRlTFo4K2dwSkVlcmU1REFTb0ovSkI3cmtXaGtxQUZtdWlnU2xE?=
 =?utf-8?B?QlpmSVI3Y2NwbGV0MVhIVzBJNWVHUEZyMlJ5ZmhDOE1rajFVd1V2bzRuRkl3?=
 =?utf-8?B?ZXQ3d0d0ai8vcVo1WkY2dURkRXNpNFA3Y2ZhSXVaTEJYMEhkUFNCTTUrdEVE?=
 =?utf-8?B?S0hYd2l0QUo4NFlKdjBpRE1PWTVTYkJVZTVaREc3eU10VDEvTXN5TFNZR3d3?=
 =?utf-8?B?YkRKNmxlVCtLK0YxRlRTU3ZpVDFVQ3lSK2t1TFhzQWRzdGFucWlRcndES2F5?=
 =?utf-8?B?NWlBTlRHOERXelkyN2dmMzNzSTNSbGhQSTRXREJ0Mk4yMk5NQXZuNi9EQmRH?=
 =?utf-8?B?Qzc3V0JFSzd0WHdFTFE1bjl5UE5FbUpmN0c0Y25iMmRsbDN0MllGamsyQ0Na?=
 =?utf-8?B?YWRzRkZxOGthZzY4MnZ1Z1ZwN0N4ZTJ6RnhvZmdxSjlYUUpXVW9iSGRvTGJ4?=
 =?utf-8?B?L0tYWms0bVViTFRnY0F3R2lzYjA2RVdSU0I5c1YzUHVNWitIQWo2cDBVeHRV?=
 =?utf-8?B?WUl3d2gweUZPSEY2M1Rtb0JXWE1Cb3NKTkpDOEE5cUJCdjVRWVB0S2tGNngw?=
 =?utf-8?B?NFJ4SFRHUHQwRTVNRXFnbXNxam1sV3NFOWZFMlNKM05udEMwM2hRMDBuSkFo?=
 =?utf-8?B?NnR3RCtPYVFjR1VnNzRmclRtc3h3U3Q3Znh5bWZETUJWZFFlWi9Kb3h2OHJR?=
 =?utf-8?B?WE5ieUFxVzg5SFNld0hWTzNGMjM4U3QwNzJVTWxSOWIzcUtzRWVWVXdXL0ZG?=
 =?utf-8?B?cXh2eE9Pc0lnekozTG9YUWg3WTl2aVowcUpnYWlwNjNyTDNJN0pMQkkxSTdp?=
 =?utf-8?B?T2xxenNGTWdYWElaMm9mdGJEazJaRTZFZkxlT2RwRW1FQmQxOUpjbzFZZEpo?=
 =?utf-8?B?OTNUM3d3djFjT3JpNWdQUWRLb3Zrc2xGRmkvYTZpOXBKU1kzZFBhKytmTHVj?=
 =?utf-8?B?bFRoODd4Y0h6TkEyaFAvQjJETm1QdytEZzlITVBQa1JFMWpzOEg1d2RZclhF?=
 =?utf-8?B?S0d1YnFYZ0J5TzdpSjFOL1NCQ3ZnVmIwSjl4bUFzTFJkTk9YRFhQQlhaK2pm?=
 =?utf-8?B?YW4xTjJvWmdZN0NuTDhuUEZjMEo5bi9TWXBLaDlhRVc1MndzVVBlQUF3c1lt?=
 =?utf-8?B?QXpVNlFCVnNKMTBXNGdKMml5YjVBZXBJZXZpekNjZVRYK0NzU0lIQnFQdnVh?=
 =?utf-8?B?V3JRbEN4Zmh3Yk96ZDNYdzFIeHpkNFVFb0RLTGZwRTdVSWxPUXUxYUpwcHVX?=
 =?utf-8?B?UVNhSUtheW5RQ3NiMzBHQ2NpWE4yOVFGRWNKRlh6VkNGQThBMkNwT2N6UXJZ?=
 =?utf-8?B?THExbDF5U3JHUkh4c0FtbDFHRS9udzVyUEJRWHVOVHVZRzY0N2RoYzZ0Rm5q?=
 =?utf-8?B?bEs1UDEvT016Wnl4MEFUaG9pY0s2dWdlZXVta24wU05DSlFQSlRybU1tOXJN?=
 =?utf-8?B?ODVXMXNHSTgxc25GYlh2Vm9tQTZEcDVvbWppRDVma0MvUXVoUXpSa3hXeGY3?=
 =?utf-8?Q?fjL4PEstBUgYo6UNyk=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dd4fe0-ba4e-4a1c-bdb7-08dc1c414a66
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 18:29:53.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2420

On 1/22/24 22:30, Kees Cook wrote:
> On Mon, Jan 22, 2024 at 02:24:37PM +0100, Bernd Edlinger wrote:
>> The main concern was when a set-suid program is executed by execve.
>> Then it makes a difference if the current thread is traced before the
>> execve or not.  That means if the current thread is already traced,
>> the decision, which credentials will be used is different than otherwise.
>>
>> So currently there are two possbilities, either the trace happens
>> before the execve, and the suid-bit will be ignored, or the trace
>> happens after the execve, but it is checked that the now potentially
>> more privileged credentials allow the tracer to proceed.
>>
>> With this patch we will have a third prossibility, that is in order
>> to avoid the possible dead-lock we allow the suid-bit to take effect,
>> but only if the tracer's privileges allow both to attach the current
>> credentials and the new credentials.  But I would only do that as
>> a last resort, to avoid the possible dead-lock, and not unless a dead-lock
>> is really expected to happen.
> 
> Instead of doing this special cred check (which I am worried could
> become fragile -- I'd prefer all privilege checks happen in the same
> place and in the same way...), could we just fail the ptrace_attach of
> the execve?
> 

Hmm, yes.  That is also possible, and that was actually my first approach,
but I think the current patch is superior.  I have nevertheless tried it
again, to get a better picture of the differences between those two approaches.

See below for how that alternative approach would look like:
+ the advantage of that would be simplicity.
+ it avoids the dead-lock in the tracer.
- it is an API change, which we normally try to avoid.
- the adjusted test case(s) show that the tracer cannot successfully
attach to the resulting process before the execve'd process starts up.
So although there is no suid process involved in my test cases,
the traced program simply escapes out of the tracer's control.

The advantage of the current approach would be:
+ it avoids the dead-lock in the tracer
+ it avoids a potentially breaking API change.
+ the tracer is normally able to successfully attach to the
resulting process after the execve completes, before it starts
to execute.
+ the debug experience is just better.
- worst case that can happen, is that the security policy denies the
tracer the access to the new process after the execve.  In that case
the PTRACE_ATTACH will fail each time it is attempted, in a similar way
as the the alternate approach.  But the overall result is still correct.
The privileged process escapes, and that is okay in that case.
- it is theoretically possible that the security engine gets confused by
the additional call to security_ptrace_access_check, but that will be
something that can be fixed, when it happens.

However my main motivation, why I started this work was the security implication.

I assume the tracer is a privileged process, like an anti virus program,
that supervises all processes and if it detects some anomaly it can
ptrace attach to the target, check what it does and prevent it from doing
bad things.

- Currently a non-privileged program can potentially send such a privileged
tracer into a deadlock.
- With the alternative patch below that non-privileged can no longer send the
tracer into a deadlock, but it can still quickly escape out of the tracer's
control.
- But with my latest patch a sufficiently privileged tracer can neither be
sent into a deadlock nor can the attached process escape.  Mission completed.


Thanks
Bernd.


Here is the alternative patch for reference:
diff --git a/fs/exec.c b/fs/exec.c
index e88249a1ce07..0a948f5821b7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1045,6 +1045,8 @@ static int de_thread(struct task_struct *tsk)
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *t;
+	bool unsafe_execve_in_progress = false;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -1067,6 +1069,18 @@ static int de_thread(struct task_struct *tsk)
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
 
+	for_other_threads(tsk, t) {
+		if (unlikely(t->ptrace)
+		    && (t != tsk->group_leader || !t->exit_state))
+			unsafe_execve_in_progress = true;
+	}
+
+	if (unlikely(unsafe_execve_in_progress)) {
+		spin_unlock_irq(lock);
+		mutex_unlock(&sig->cred_guard_mutex);
+		spin_lock_irq(lock);
+	}
+
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
@@ -1157,6 +1171,9 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
+	if (unlikely(unsafe_execve_in_progress))
+		mutex_lock(&sig->cred_guard_mutex);
+
 	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
@@ -1168,6 +1185,9 @@ static int de_thread(struct task_struct *tsk)
 	return 0;
 
 killed:
+	if (unlikely(unsafe_execve_in_progress))
+		mutex_lock(&sig->cred_guard_mutex);
+
 	/* protects against exit_notify() and __exit_signal() */
 	read_lock(&tasklist_lock);
 	sig->group_exec_task = NULL;
@@ -1479,6 +1499,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
 		return -ERESTARTNOINTR;
 
+	if (unlikely(current->signal->group_exec_task)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
 		return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 98a031ac2648..55816320c103 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2785,6 +2785,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
+	if (unlikely(current->signal->group_exec_task)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		rv = -ERESTARTNOINTR;
+		goto out_free;
+	}
+
 	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2fabd497d659..162e4c8f7b08 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -444,6 +444,9 @@ static int ptrace_attach(struct task_struct *task, long request,
 	scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
 			   &task->signal->cred_guard_mutex) {
 
+		if (unlikely(task->signal->group_exec_task))
+			return -EAGAIN;
+
 		scoped_guard (task_lock, task) {
 			retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
 			if (retval)
@@ -491,6 +494,14 @@ static int ptrace_traceme(void)
 {
 	int ret = -EPERM;
 
+	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
+		return -ERESTARTNOINTR;
+
+	if (unlikely(current->signal->group_exec_task)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		return -ERESTARTNOINTR;
+	}
+
 	write_lock_irq(&tasklist_lock);
 	/* Are we already being traced? */
 	if (!current->ptrace) {
@@ -506,6 +517,7 @@ static int ptrace_traceme(void)
 		}
 	}
 	write_unlock_irq(&tasklist_lock);
+	mutex_unlock(&current->signal->cred_guard_mutex);
 
 	return ret;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index aca7b437882e..6a136d6ddf7c 100644
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
+		if (unlikely(current->signal->group_exec_task)) {
+			mutex_unlock(&current->signal->cred_guard_mutex);
+			goto out_put_fd;
+		}
+	}
 
 	spin_lock_irq(&current->sighand->siglock);
 
diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
index 4db327b44586..7a51a350a068 100644
--- a/tools/testing/selftests/ptrace/vmaccess.c
+++ b/tools/testing/selftests/ptrace/vmaccess.c
@@ -14,6 +14,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include <sys/ptrace.h>
+#include <sys/syscall.h>
 
 static void *thread(void *arg)
 {
@@ -23,7 +24,7 @@ static void *thread(void *arg)
 
 TEST(vmaccess)
 {
-	int f, pid = fork();
+	int s, f, pid = fork();
 	char mm[64];
 
 	if (!pid) {
@@ -31,19 +32,42 @@ TEST(vmaccess)
 
 		pthread_create(&pt, NULL, thread, NULL);
 		pthread_join(pt, NULL);
-		execlp("true", "true", NULL);
+		execlp("false", "false", NULL);
+		return;
 	}
 
 	sleep(1);
 	sprintf(mm, "/proc/%d/mem", pid);
+	/* deadlock did happen here */
 	f = open(mm, O_RDONLY);
 	ASSERT_GE(f, 0);
 	close(f);
-	f = kill(pid, SIGCONT);
-	ASSERT_EQ(f, 0);
+	f = waitpid(-1, &s, WNOHANG);
+	ASSERT_NE(f, -1);
+	ASSERT_NE(f, 0);
+	ASSERT_NE(f, pid);
+	ASSERT_EQ(WIFEXITED(s), 1);
+	ASSERT_EQ(WEXITSTATUS(s), 0);
+	f = waitpid(-1, &s, 0);
+	ASSERT_EQ(f, pid);
+	ASSERT_EQ(WIFEXITED(s), 1);
+	ASSERT_EQ(WEXITSTATUS(s), 1);
+	f = waitpid(-1, NULL, 0);
+	ASSERT_EQ(f, -1);
+	ASSERT_EQ(errno, ECHILD);
 }
 
-TEST(attach)
+/*
+ * Same test as previous, except that
+ * we try to ptrace the group leader,
+ * which is about to call execve,
+ * when the other thread is already ptraced.
+ * This exercises the code in de_thread
+ * where it is waiting inside the
+ * while (sig->notify_count) {
+ * loop.
+ */
+TEST(attach1)
 {
 	int s, k, pid = fork();
 
@@ -52,19 +76,67 @@ TEST(attach)
 
 		pthread_create(&pt, NULL, thread, NULL);
 		pthread_join(pt, NULL);
-		execlp("sleep", "sleep", "2", NULL);
+		execlp("false", "false", NULL);
+		return;
 	}
 
 	sleep(1);
+	/* deadlock may happen here */
 	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
-	ASSERT_EQ(errno, EAGAIN);
 	ASSERT_EQ(k, -1);
+	ASSERT_EQ(errno, EAGAIN);
 	k = waitpid(-1, &s, WNOHANG);
 	ASSERT_NE(k, -1);
 	ASSERT_NE(k, 0);
 	ASSERT_NE(k, pid);
 	ASSERT_EQ(WIFEXITED(s), 1);
 	ASSERT_EQ(WEXITSTATUS(s), 0);
+	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
+	ASSERT_EQ(k, -1);
+	ASSERT_EQ(errno, EAGAIN);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFEXITED(s), 1);
+	ASSERT_EQ(WEXITSTATUS(s), 1);
+	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
+	ASSERT_EQ(k, -1);
+	ASSERT_EQ(errno, ESRCH);
+	k = waitpid(-1, NULL, 0);
+	ASSERT_EQ(k, -1);
+	ASSERT_EQ(errno, ECHILD);
+}
+
+/*
+ * Same test as previous, except that
+ * the group leader is ptraced first,
+ * but this time with PTRACE_O_TRACEEXIT,
+ * and the thread that does execve is
+ * not yet ptraced.  This exercises the
+ * code block in de_thread where the
+ * if (!thread_group_leader(tsk)) {
+ * is executed and enters a wait state.
+ */
+static long thread2_tid;
+static void *thread2(void *arg)
+{
+	thread2_tid = syscall(__NR_gettid);
+	sleep(2);
+	execlp("false", "false", NULL);
+	return NULL;
+}
+
+TEST(attach2)
+{
+	int s, k, pid = fork();
+
+	if (!pid) {
+		pthread_t pt;
+
+		pthread_create(&pt, NULL, thread2, NULL);
+		pthread_join(pt, NULL);
+		return;
+	}
+
 	sleep(1);
 	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
@@ -72,12 +144,40 @@ TEST(attach)
 	ASSERT_EQ(k, pid);
 	ASSERT_EQ(WIFSTOPPED(s), 1);
 	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
-	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
+	k = ptrace(PTRACE_SETOPTIONS, pid, 0L, PTRACE_O_TRACEEXIT);
+	ASSERT_EQ(k, 0);
+	thread2_tid = ptrace(PTRACE_PEEKDATA, pid, &thread2_tid, 0L);
+	ASSERT_NE(thread2_tid, -1);
+	ASSERT_NE(thread2_tid, 0);
+	ASSERT_NE(thread2_tid, pid);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	sleep(2);
+	/* deadlock may happen here */
+	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
+	ASSERT_EQ(k, -1);
+	ASSERT_EQ(errno, EAGAIN);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
+	ASSERT_EQ(k, -1);
+	ASSERT_EQ(errno, EAGAIN);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
+	ASSERT_EQ(k, -1);
+	ASSERT_EQ(errno, EAGAIN);
 	k = waitpid(-1, &s, 0);
 	ASSERT_EQ(k, pid);
 	ASSERT_EQ(WIFEXITED(s), 1);
-	ASSERT_EQ(WEXITSTATUS(s), 0);
+	ASSERT_EQ(WEXITSTATUS(s), 1);
+	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
+	ASSERT_EQ(k, -1);
+	ASSERT_EQ(errno, ESRCH);
 	k = waitpid(-1, NULL, 0);
 	ASSERT_EQ(k, -1);
 	ASSERT_EQ(errno, ECHILD);


