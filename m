Return-Path: <linux-fsdevel+bounces-8432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BB3836465
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 14:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2811C20E46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0943CF6F;
	Mon, 22 Jan 2024 13:23:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2064.outbound.protection.outlook.com [40.92.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84DC3CF51;
	Mon, 22 Jan 2024 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929824; cv=fail; b=SagXiIk+J+SpQvbTWkYxZOOE2CU6E23G295X4BvhT+qwDpGNaf8ZJgumYbT9PBy/rd4sGUZPTsZ4DY3wXpGnKCEEyHaBKD0neRAfiSreHMmwCD9pfKu/4r9ENtNlAVgR1qv+TA1JFUcEblStC1cubx8KweKAjgVlDahcgpv1qPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929824; c=relaxed/simple;
	bh=guTh9eJRxPURfwOrSEZGAdNBWHuDsJvDxUVr+pFaqTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qu4MmA9hzuFH6jjqOHcN9CcK0gkyz//tGZ46aaHiMZbZfAFI6sMfMd/e83GHqD17fUojMgmMneXtFsaCEQsnlY/usu2On+l6OGnmg6ZxX66Z+R0dqBBLdjr+SX8iKb8co6Llvv98Q1HJJicaznGXMy06a6rCkr+lxWD+aU3korg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.75.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ccni7z/hVkQefIbYLWmn8H8lMJ+3V0i408XfVKwSCucrf2qJ+pSAtYD3takmD/2Vr5t5bJXCm25gML8P6IKDhkjSHuICowTVQjzzTC4Oq9miqFOmdwdMW3FkgQLvraKc3wp9mvdFROKPIrwefpVRGRhclh7HFf4fBlbVZurM7+IzMcn8D62eC0eYNLk7P/YnZiXtJ58SzjJGNvM7m1J3Nvx61R/FlH1o6S5JBew6z0qNxWJjaQ6aWSlH+eG0XMxc+87LPo1Ih+LGiLOY+6+kaQtrZnvJinhyjyDCUPUqNJLp05J4qBf6wYSIWQMMBDvaWi1Iy0AL02RskcDL06Sp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhAe68J7trE63Ec4Km19qda3S2G/DtuSIaQB1FWgPn4=;
 b=axigSwgdBshCXOA0nwCXV/WYWzM/UgVe23V+WQnhNj4oq7vPU1QKCzvMkyEdDyROdgVqF1aTQSWvKRc4sxxoaHFQ38upRFeQLzzD9J8TmEthNUcmyUUBvrnVtx3WCAaRO06eLzwJPYtrPvNsDetONgmmKKNZG0pqjqUQzG0CVTCA5+oYURiNoRgz6A0qvGdf2kb+e9Ar4FWtYzcBfUiCLafICuv2uTDuW7RXpSdMmPVGs/WmB0XWvAuLtFQ6fLKRutCoN/lv5iUXTWrl24m9g6aRVgf1jtzfJztFdCS32tHaHlhMa1S93TG/ur0KgTEARTFGiD102Pv4KDaofnRGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AM0P193MB0756.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 13:23:39 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 13:23:39 +0000
Message-ID:
 <AS8P193MB1285FDD902CC57C781AF2770E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 22 Jan 2024 14:24:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] exec: Fix dead-lock in de_thread with ptrace_attach
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <keescook@chromium.org>,
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
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <20240117163739.GA32526@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [6KfVaCqtDqhmoMuIAB8RmSMgfXoV1P5pcGw7hYfHIBhhW2KV1F5DY2rw3KsBcOBM]
X-ClientProxiedBy: BE1P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::13) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <75543873-e269-4581-b0a3-bcf8e11765b9@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AM0P193MB0756:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c05d91-2c4b-4f6e-cb3d-08dc1b4d5894
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IzGBGYIacXMAuQJWH/+vthSQTHV0MT+0Uv6OY0ffeO1fbwO2L/FmKBdYdyJ82BbY7ykreuPbRj4M+DpCjnOE/ER2jOq81NhwTAz7OMRpl03H+9XKkjyRkhN7QIlEj2gyb5CTzyrxsDYChUB9RR85Z4+6mQTsNZuM9blOXLimy8hWM3eZLvrv/yvh0AKn/ON5sK3jZt9IlC1PRKEMeg2VqHsnA22n315liw/Lh1Vxh5D/r7HqIEXCn7P2Eo+HFn3YRgWNOKPZiwj/QlqCrQx1NlDjjY9znGQTLEuqkKmsG/kxIVABMJKsAA9Lhl2XgVdnyQYg5742a50SNBY55vxEEcNEXgKS8ewLwRzgV8MS6Fh1FNdGDtKod1e2vlS2gLpeyw1XFAO2tpes84sZyFpzKtDg18cqaAqkzeunn4w4yy4jtwvqic5RpMcZqizD+af8oacP75nziCaA0kwhpxer23Sg5wJfA6xgyM7Mz7zChg8hAh4MbIF0KNeeUkFiUFeClDMv1qXnd3obIW4Vy2Kmys60jZBLYcSO0pPDquYyBVS2KGbuWsFo6/O+wxy1OcAu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aThsNVR1Mkw2UGlDMm80U0JKT3A4c1kyZEl2OEhnL0ptMmowNU1wZExwbHBE?=
 =?utf-8?B?S2tUN2tXTHFBNENmU1h5aXAxUnRYN014WnkvYTVvTlpPaytKM1JuM0VyNjlJ?=
 =?utf-8?B?ZUE5dUhKcHYxTGpoeFZQMENjU3hXRlZjS2lDYS9pd21BbzNlNWJxQkdUUndz?=
 =?utf-8?B?aGxqWXRBbzQxYlpZSy9qTGsrNmtDWmxoNlN2SlBzZDhROGJpcXdDWG1BS1d2?=
 =?utf-8?B?Mm84S1R4aWhXNTlTTkZ3aXZuZDlIWU5xUjhQaWdaaVlnb0lEZG5YOW9JcjF3?=
 =?utf-8?B?TXY1R05adHA2NStWSGVNL1JSMzJnOW41UCs3bnlaZFd0dnQvcnhhRldjOHpt?=
 =?utf-8?B?dGgwNEM5SVdiVUJ0RXVVT080WTB5YStTMlpxbHhYRjUvemJOSDB4eHowNDhY?=
 =?utf-8?B?VmQ3SXU4MnYzNmwvczJGY0QwdTlRei8zeGhEV2UwcWpQdlMwWGgrYWlSTlRr?=
 =?utf-8?B?WU1OZWdVQjZ0RTNoWFNaekxKdHpoWGNWVmlyMXlwWGE3OWNNY2plbmk5M3gy?=
 =?utf-8?B?U01XV0p1MVRPSkRFK3dpMEhWaVgyUkJwUGlFemlCaWc3YmQ2Z1pUU05CcE4x?=
 =?utf-8?B?cmU2cm5UbTJWcXFhTy9ZeDRkM2lRdFkxbFAzUUJ4M0U0TTBNQklidHFPQ1Vl?=
 =?utf-8?B?OWphaWpINmpPYzZFOTcyc3RxVUdabENxa1UrWlBQTjR2eGRiZWhFcG9OcHRH?=
 =?utf-8?B?eEY3VGY4WUI1bjAwWGZMdnhLWkZoZzc3VTAzMHNNZzV3c2pxemI5YkRGWUt0?=
 =?utf-8?B?SU9OWjhJaWxMeXl4TU1ockQ0N2syTjYrUlpaK1FhVk55ZmtvNGlCdXJyWXY1?=
 =?utf-8?B?K3M4SHR0Q0NRQWZnalNaVUN4MDdOUzJyRnhTR25PNmJmeHZQQlJDZmJzcXNs?=
 =?utf-8?B?RTlwbnhPTEV0aHEzT1hEbkh4TkFJdVRseVBkYzhMVmNwYy9vODdhUUNFYS8v?=
 =?utf-8?B?TE1iVDBjTldqUVpWaW5KbElrOHROQ3pDb0tIamZjVWx2aTFVU3E1MHVWaEhY?=
 =?utf-8?B?ZzhDLzRLZ3NjTTA2Vm13NTFDcHVHb1ZhQWVxcEk4clQ4ZW83MHRBbXFQeGxV?=
 =?utf-8?B?TUd6akUxZnkvckl2N3hMTG8xUHp4c3lqTEQ1Y3Vnc2JaMWN0Wko4c0t3VVBr?=
 =?utf-8?B?NUgyWTRhQmgyWkZaU3djMTVia1lrL3FiZzUwMmkwLzFpMWNsOTBub3Z5L2Zv?=
 =?utf-8?B?SWliV3RBZTlWYVVrNHoxcEd6c1NLWC9wd21ZOE01Y09RN2VvQysxc3pXeEhZ?=
 =?utf-8?B?ZVExaTB2d2dzaW11S3FwdmNNeDhzRzB4TElxS0toOXMxMy9CRmFvcElxa2NI?=
 =?utf-8?B?cnVnUUNkWm05S01rWW1yY2w0eC9CTEcxeU5KdVk0bGlsTmZEWE1NcDRNNzhu?=
 =?utf-8?B?Q0xtV0o0K1EwcHhPc255aTZZVGhvY205dm5Zc0krUkxMWjhXUzdkd0tjQVlu?=
 =?utf-8?B?dFVGZ3FndFMvYXhXNFZHYXV0UTRnekxJbTd2SmxaN3VXZ0g4Y0tjdlVqWmhX?=
 =?utf-8?B?V0RFaW5Ya0NZNXVPemMwcWZDSkJZTHhBZmc5THpaSFY1eXhjVFBUd01ScmZ2?=
 =?utf-8?B?OGVCU2RncjFiaDVzaWpMSlBUdGJRNVlTWnA1WjZqYVh6OXRiaE5hbTRVYVcv?=
 =?utf-8?B?M1dRclZRNWh4UjU2NWZjMCtkRzJhNWY4UUwxbzBTVG5DbFBhbHpxWHhORHF2?=
 =?utf-8?B?NHlyTFJ5T3hTRU1vaXdKdm1Nbi8rbGJyc3BCSlFQN2lyZmFzbkVVVk1WNm94?=
 =?utf-8?Q?wXlepSTWUtmDVsJCH0=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c05d91-2c4b-4f6e-cb3d-08dc1b4d5894
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 13:23:39.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0756

On 1/17/24 17:38, Oleg Nesterov wrote:
> On 01/17, Bernd Edlinger wrote:
>> Yes. but the tracer has to do its job, and that is ptrace_attach the
>> remaining treads, it does not know that it would avoid a dead-lock
>> when it calls wait(), instead of ptrace_attach.  It does not know
>> that the tracee has just called execve in one of the not yet traced
>> threads.
> 
> Hmm. I don't understand you.

Certainly I am willing to rephrase this until it is understandable.
Probably I have just not yet found the proper way to describe the issue
here, and your help in resolving that documentation issue is very important
to me.

> 
> I agree we have a problem which should be fixed. Just the changelog
> looks confusing to me, imo it doesn't explain the race/problem clearly.
> 

I am trying here to summarize what the test case "attach" in
./tools/testing/selftests/ptrace/vmaccess.c does.

I think it models the use case of a tracer that is trying to attach
to a multi-threaded process that is executing execve in a not-yet
traced thread while a different sub-thread is already traced,
it is not relevant that the test case uses PTRACE_TRACEME, to make
the sub-thead traced, the same would happen if the tracer uses
some out-of-band mechanism like /proc/pid/task to learn the thread_id
of the sub-threads and uses ptrace_attach to each of them.

The test case hits the dead-lock because there is a race condition
between before the PTRACE_ATTACH, and it cannot know that the
exit event from the sub-thread is already pending before the
PTRACE_ATTACH.  Of course a real tracer will not sleep a whole
second before a PTRACE_ATTACH, but even if it does a
waitpid(-1, &s, WNOHANG) immediately before the PTRACE_ATTACH
there is a tiny chance that the execve is entered just immediately
after waitpid has indicated that there is currently not
event pending.

>>>> +		if (unlikely(t->ptrace)
>>>> +		    && (t != tsk->group_leader || !t->exit_state))
>>>> +			unsafe_execve_in_progress = true;
>>>
>>> The !t->exit_state is not right... This sub-thread can already be a zombie
>>> with ->exit_state != 0 but see above, it won't be reaped until the debugger
>>> does wait().
>>>
>>
>> I dont think so.
>> de_thread() handles the group_leader different than normal threads.
> 
> I don't follow...
> 
> I didn't say that t is a group leader. I said it can be a zombie sub-thread
> with ->exit_state != 0.
> 

the condition here is 

(t != tsk->group_leader || !t->exit_state)

so in other words, if t is a sub-thread, i.e. t != tsk->group_leader
then the t->exit_state does not count, and the deadlock is possible.

But if t it is a group leader, then t == tsk->group_leader, but a
deadlock is only possible when t->exit_state == 0 at this time.
The most likely reason for this is PTRACE_O_TRACEEXIT.

I will add a new test case that demonstrates this in the next iteration
of this patch.  Here is a preview of what I have right now:

/*
 * Same test as previous, except that
 * the group leader is ptraced first,
 * but this time with PTRACE_O_TRACEEXIT,
 * and the thread that does execve is
 * not yet ptraced.  This exercises the
 * code block in de_thread where the
 * if (!thread_group_leader(tsk)) {
 * is executed and enters a wait state.
 */
static long thread2_tid;
static void *thread2(void *arg)
{
	thread2_tid = syscall(__NR_gettid);
	sleep(2);
	execlp("false", "false", NULL);
	return NULL;
}

TEST(attach2)
{
	int s, k, pid = fork();

	if (!pid) {
		pthread_t pt;

		pthread_create(&pt, NULL, thread2, NULL);
		pthread_join(pt, NULL);
		return;
	}

	sleep(1);
	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
	ASSERT_EQ(k, 0);
	k = waitpid(-1, &s, 0);
	ASSERT_EQ(k, pid);
	ASSERT_EQ(WIFSTOPPED(s), 1);
	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
	k = ptrace(PTRACE_SETOPTIONS, pid, 0L, PTRACE_O_TRACEEXIT);
	ASSERT_EQ(k, 0);
	thread2_tid = ptrace(PTRACE_PEEKDATA, pid, &thread2_tid, 0L);
	ASSERT_NE(thread2_tid, -1);
	ASSERT_NE(thread2_tid, 0);
	ASSERT_NE(thread2_tid, pid);
	k = waitpid(-1, &s, WNOHANG);
	ASSERT_EQ(k, 0);
	sleep(2);
	/* deadlock may happen here */
	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
	ASSERT_EQ(k, 0);
	k = waitpid(-1, &s, WNOHANG);
	ASSERT_EQ(k, pid);
	ASSERT_EQ(WIFSTOPPED(s), 1);
	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
	k = waitpid(-1, &s, WNOHANG);
	ASSERT_EQ(k, 0);
	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
	ASSERT_EQ(k, 0);
	k = waitpid(-1, &s, 0);
	ASSERT_EQ(k, pid);
	ASSERT_EQ(WIFSTOPPED(s), 1);
	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
	k = waitpid(-1, &s, WNOHANG);
	ASSERT_EQ(k, 0);
	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
	ASSERT_EQ(k, 0);
	k = waitpid(-1, &s, 0);
	ASSERT_EQ(k, pid);
	ASSERT_EQ(WIFSTOPPED(s), 1);
	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
	k = waitpid(-1, &s, WNOHANG);
	ASSERT_EQ(k, 0);
	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
	ASSERT_EQ(k, 0);
	k = waitpid(-1, &s, 0);
	ASSERT_EQ(k, pid);
	ASSERT_EQ(WIFEXITED(s), 1);
	ASSERT_EQ(WEXITSTATUS(s), 1);
	k = waitpid(-1, NULL, 0);
	ASSERT_EQ(k, -1);
	ASSERT_EQ(errno, ECHILD);
}

So the traced process does the execve in the sub-thread,
and the tracer attaches the thread leader first, and when
the next PTRACE_ATTACH happens, the thread leader is stopped
because of the PTRACE_O_TACEEXIT.  So at that time,
the t->exit_state == 0, and we receive the following:

	k = waitpid(-1, &s, WNOHANG);
	ASSERT_EQ(k, pid);
	ASSERT_EQ(WIFSTOPPED(s), 1);
	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);

yet the de_thread is not finished now, but only when

	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
	ASSERT_EQ(k, 0);

happens.

The only thing, that is admittedly pretty confusing here, is
the fact that the thread2_tid morphs into group leader's pid,
at this time, and is therefore never heard of again.

So pid refers to the former thread2_tid from now on, and the
former group leader does not enter the usual zombie state here,
because the sub-thread takes over it's role.


>>>> +	if (unlikely(unsafe_execve_in_progress)) {
>>>> +		spin_unlock_irq(lock);
>>>> +		sig->exec_bprm = bprm;
>>>> +		mutex_unlock(&sig->cred_guard_mutex);
>>>> +		spin_lock_irq(lock);
>>>
>>> I don't understand why do we need to unlock and lock siglock here...
>>
>> That is just a precaution because I did want to release the
>> mutexes exactly in the reverse order as they were acquired.
> 
> To me this adds the unnecessary complication.
> 

Well, the proposed change creates this sequence

mutex_lock(&sig_cred_guard_mutex);
spin_lock_irq(lock);
mutex_unlock(&sig_cred_guard_mutex);
spin_unlock_irq(lock);

I wanted to avoid that, because in a usual real-time os,
I'd expect the mutex_unlock to schedule another waiting
task, regardless of the spin lock state.

Are you saying that doing this is safe to do in linux,
because the scheduling does not happen except when
explicitly asked for e.g. by calling schedule() ?
And would that also be safe for real time linux port ?

>>> But my main question is why do we need the unsafe_execve_in_progress boolean.
>>> If this patch is correct and de_thread() can drop and re-acquire cread_guard_mutex
>>> when one of the threads is traced, then why can't we do this unconditionally ?
>>>
>>
>> I just wanted to keep the impact of the change as small as possible,
> 
> But the unsafe_execve_in_progress logic increases the impact and complicates
> the patch.
> 
> I think the fix should be as simple as possible. (to be honest, right now
> I don't think this is a right approach).
> 

The main concern was when a set-suid program is executed by execve.
Then it makes a difference if the current thread is traced before the
execve or not.  That means if the current thread is already traced,
the decision, which credentials will be used is different than otherwise.

So currently there are two possbilities, either the trace happens
before the execve, and the suid-bit will be ignored, or the trace
happens after the execve, but it is checked that the now potentially
more privileged credentials allow the tracer to proceed.

With this patch we will have a third prossibility, that is in order
to avoid the possible dead-lock we allow the suid-bit to take effect,
but only if the tracer's privileges allow both to attach the current
credentials and the new credentials.  But I would only do that as
a last resort, to avoid the possible dead-lock, and not unless a dead-lock
is really expected to happen.


Thanks
Bernd.

