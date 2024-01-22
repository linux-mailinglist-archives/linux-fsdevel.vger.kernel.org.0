Return-Path: <linux-fsdevel+bounces-8469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4982283716A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1484288DAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6808A4F8B4;
	Mon, 22 Jan 2024 18:30:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2020.outbound.protection.outlook.com [40.92.89.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9B2E3EC;
	Mon, 22 Jan 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948253; cv=fail; b=KsNdHIqQHNJx8VKnYk2J/ocxWTH9Z8in1T++zUNMXrK1JIFBA68nMPVzZubPwh0D9f2n85GaSSr6U8ADjusU3ddxUqfwBkDrrjhUYPn8K0ig94Sz30moyPRazYjJddB8YD+h4igdhn4lPCpJPEPvHESbIUh5cZ+pO8oLO7C9Xkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948253; c=relaxed/simple;
	bh=gs4Z4wFGvSRpGyXuM+j7aDUNgbpzjbvEW5IV6jb7yQg=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vbxc+uP8yra8XgpTjpuouzHFKlD8cePuvzLyCz73/BFAalFTarq2n+ydmJbkAa+jVh0Jn0EzERiDV30s8qfjMqM1lCl/Otx8tyZAAVBBGh7KyN3IS+yN5k7+dBHgOFgB3krpK6BLYOcbNyvCIQAJwSF6Ps+UQYyC8zrFW9TJ9sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.89.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMwRi4d5BEMbM47o1BJ1QqbJMD9KJOlKz4MKAuI2TVM1b4N3U/OhDP6vVcdbn/EhSNyvzssuy12UfQ4Yxk/aUZIULYPENgQAIJX9CR154XB3HFIUnM6Ax50pMCm0DiHNoqcqTuCXee7dTFxr406dYBcJATKd0x+dKS48Ze7g1tyBrtMkOA03LXau4y49xSAe98ryjFe8eK3Q8EdnI+/Xd0uNt4tFhpuwh72JNYDnGjNehBWx5coI/E7Wh2yhdShQtE0ih0f4agR+i+gOP6mB8uavMYufkeyy4vdJ3yBeF5QOl47dN8p/yRFqeJ86Vfyusmk0SdO1Oamkujdvmghbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfsriY3BNJYD8GabU3OzcEa2HqAPZ47l5FoiwkeLaWQ=;
 b=K1exv2sb8780UOBj8xOcGIjK9hXMIwbkyRar46jQYrQ4gkBT/skuy2nyoQDMyeeNzzVq3AAFrhD3Lh+3EeVz2fHXhd22+J7n9w6gNpu1aXlV0+AQGndgyNRG1sPO9LJsF/5FX2iCu5Qbyt2vNiu+KkDrKTdqBbvpBIO6aAvOzfeqHWKBW8Ikadg+D3uclrpG/pt73ekbgC3KoYEabcZSYbxbaKRxGENjzWqiUwGciGhc4DGiDRkabclLX3Z4sKkZ49v/ePJMdmZFdHbxkdNNw1LYgSatfMH1AKvUYsiwHnAVBcuQGaOMl+LwU6qXWCUc2lhEZ6T7S7+Bj/bZablERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AS8P193MB2111.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:44d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 18:30:47 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 18:30:47 +0000
Message-ID:
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 22 Jan 2024 19:31:45 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v15] exec: Fix dead-lock in de_thread with ptrace_attach
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
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
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [hHczbpd9wlu4EUXJ8GccTORY1SabNnRZGaFPEPvlh/a6zNsuDseIu79ITMeaKMPg]
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <e0671c8e-d589-4b02-9677-b21edf11a0d1@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AS8P193MB2111:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf2c013-a003-45f4-2423-08dc1b784057
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fAMiGjpUnS5sYPasc2Ca9sVA8qIO4C9Ers3OCEU6C9fpd6EUHBxYNJqwJquN4FEk0PzpU5fhAlo6TloDx4hQ75NILWNSL7ElZ5kOHNNiP1UU3tIHxUJRq4maww9J9TayYuHZuaYGBu5uydWh7zvc0Dhp24nKKfdFcaw8Yw/N0LwBr+3ygtg6GcdzUAewB3TCmeHsyNGXqTJWvjuop+hB82PY2vCiKmuavdKCDxqzV0C4YC7ocWbq2kSK2BHvFwM35wNLM64AKMHB/VZgBIf+NkQNIAm2EMbQ5Q2GnEmSNFXIYyFUuh9OHGkH1bjYelK93cxu1Q6eVP4/fvZwzPc14bK5JBPtRnsgI+Y02k8eQvaLksniFkZt40EAbpSdljkmxeBMrnQsTjfu/SpQpRV2PlacK+ju+3ShTOHUcFA1EqsV4H89yJKBZ2Pb1KbKo9EZXmBWory3kt5XaW5QSjlRCCnvM7NmK3vtE+HHg8EksNOXaKKeVK9CgqpBGSvhymZjJ7m6lDaXvqpKSPgMeoW9J8Y72OfSFdU8buVpn78X+txA4CZiw3RJJf8RmIIKtFB0lv5UV29ze6HC9zwvgUyaA4m1Jy0DZntgO/DiyNNcNdo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXlBWlVmTTNsNmlBMDN5dE1rcGkyV3JTV3JsdHg5ZFZuVVZKaW0rN3hyZ3Yw?=
 =?utf-8?B?YzNsMUs3WmoxUE5MN2hSZ0RybnFJcVNIVHRDa1JGcEF2Lzc0M3pES0t2aGVn?=
 =?utf-8?B?ekpPWC9Bd0NUVnk5K21iYlpxdUYyU3ZKZlJhNDBvcTFIcEY3WmdDUE1JNitl?=
 =?utf-8?B?Vmw1VnJ0YVNnRlVBaG9UL0lKbURFZ2dpQlQ3NmJKK0hGbG9aVE1ZQmtoUkI1?=
 =?utf-8?B?VjFzcnVoYldBQk4rOVZKTUlzSkY5V3hqMFJqcnVPNGVKK1JidS9KN1NRVklz?=
 =?utf-8?B?TDFNOW9ySkhYS1NjOTV0RERPVExBME1wQjAxTHVEbnh0cVIxdU9zVmkxcnk3?=
 =?utf-8?B?SjN3dGRvVUppcEY0Uk1MelhlREZ3cVJieVpVWFhhYWIwd2NDajhLUFZwMmVE?=
 =?utf-8?B?aFMwcmlvb2RZS2ZFS0hrY1orTEUyWmgyTkUrUlpZMDQvZ1B5OUNqcXdlazRV?=
 =?utf-8?B?NDJabmpSSitMMitMUWFHMU90M3JGbWpLSDFLSmg3eTMrMmZjbFRKRDNFN3Yr?=
 =?utf-8?B?THJGNENMU1VXYUw3bmtwek90czkyNktYTWpJZWo2Q0w1Vi9Qa1FsRzZLd2Q2?=
 =?utf-8?B?Mkd2QzA1ZHpzMVBIajBZelY1MUZxTURYVUhhSlR0WmhxQzBsTDJ0MHdVTzZQ?=
 =?utf-8?B?S09PUExuekU2UUJLc2h4MHdTZzBLS2R2VkVyaFJUY2V4RXVJWEZZRmpLWU8r?=
 =?utf-8?B?U1oyaW50L0Z1Qm9xMlVCMHJNZkpqYU5IOXJyK0dYRXFvLzF2OExKTmJiVHZh?=
 =?utf-8?B?WWVBZkpQc29JcThOS0E0NXZPYXNCWFFNbnVUOVZKckpJOFJNMWdwcTZ5cFFZ?=
 =?utf-8?B?cm1DRWFQcVRiZE4ya2duMUttdXJDcm8reGZLc2o5VUt3S3ZqN0MrQVU1azFw?=
 =?utf-8?B?T21ZS1M3TjZVUlBmakJ5SklaMUQ0LzlFL2I1ek1MMHBOTCt4Tnh6cEM1dmdD?=
 =?utf-8?B?Q21iWEorbSsxanZ2d1VVZXBFRFZIbDhUUTdndDFGb2lOSXBpZ0VGUEZKUWJs?=
 =?utf-8?B?VGg1eE1JeHFobitoaUpHK1F4TkxDOVdocDRLTEU3Q3VXcHgxcVBLRXdoMUIw?=
 =?utf-8?B?V0FrajYrU2c4Rmk4eUpFZmU4Qjc4T3FMb2Q1c1ZaTEtXUENVSnNiMHBGUFpo?=
 =?utf-8?B?QWFsSkV6akhsKzdTUm55bGpwcjNpeENYRy96dURUcjJWZlNyTXowZ0lPcWNS?=
 =?utf-8?B?OUovSmNGUlovUDR0RFpzUWR6dElDTWtIc0VFYlN6NXU2MVNmeDJGZjZla1Av?=
 =?utf-8?B?MGhLYUFWVmN2TGVXQlZ0UDRNWmtQSXJFSy9HT2ZGNndjWkVrYlJvcU96TFly?=
 =?utf-8?B?c29vclBiOG9OeGpWdzFid2lMd1pXUlFKZ3NhUTlGT2FoQXY2Y2tPU3NtR20w?=
 =?utf-8?B?SEp3U2ZIQlU2Smh1NkozNXFEdjVrUjE1YzFwUmt5bHI4T2c0eDNYMFN1elR1?=
 =?utf-8?B?SkJoWkhWZGZBREptWjZHY213UXdpZkV0LzYrY2U0ajRUTmZjbGxhNDlUUXVp?=
 =?utf-8?B?L1ZuSjAyRGx5QjBGZ2NPelZDVm1sNGk1bGxuVFFzOE9qMndqU3lObWI5ZDli?=
 =?utf-8?B?ZmMybG8xdlFwQ3NtZU1QelhiN0VMQUpyRlR4eHJ5Y0hTeTY0a3BaL2tNSlIv?=
 =?utf-8?B?UHRub1ZJNzY4M095RWsxaWVtTUdHNGUxdDJ3U0UzNm41aURoWWtxazFGZmlj?=
 =?utf-8?B?L1BuZnFLcG4yQ3ZWRStJUS9PV0VlL2ZoZnZKMjNFaXRHcUlxYjVFTk4yRXpV?=
 =?utf-8?Q?Kd/aTBOSxX8A5lfkIY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf2c013-a003-45f4-2423-08dc1b784057
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 18:30:47.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2111

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
 fs/exec.c                                 |  69 ++++++++---
 fs/proc/base.c                            |   6 +
 include/linux/cred.h                      |   1 +
 include/linux/sched/signal.h              |  18 +++
 kernel/cred.c                             |  30 ++++-
 kernel/ptrace.c                           |  31 +++++
 kernel/seccomp.c                          |  12 +-
 tools/testing/selftests/ptrace/vmaccess.c | 135 ++++++++++++++++++++--
 8 files changed, 265 insertions(+), 37 deletions(-)

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

v15: rebased to v6.8-rc1, addressed some review comments.
Split the test case vmaccess into vmaccess1 and vmaccess2
to improve overall test coverage.


Thanks
Bernd.

diff --git a/fs/exec.c b/fs/exec.c
index e88249a1ce07..499380d74899 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1040,11 +1040,13 @@ static int exec_mmap(struct mm_struct *mm)
 	return 0;
 }
 
-static int de_thread(struct task_struct *tsk)
+static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
 {
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *t;
+	bool unsafe_execve_in_progress = false;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -1067,6 +1069,19 @@ static int de_thread(struct task_struct *tsk)
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
+		sig->exec_bprm = bprm;
+		mutex_unlock(&sig->cred_guard_mutex);
+		spin_lock_irq(lock);
+	}
+
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
@@ -1157,6 +1172,11 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
+	if (unlikely(unsafe_execve_in_progress)) {
+		mutex_lock(&sig->cred_guard_mutex);
+		sig->exec_bprm = NULL;
+	}
+
 	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
@@ -1168,6 +1188,11 @@ static int de_thread(struct task_struct *tsk)
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
@@ -1252,6 +1277,24 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1260,7 +1303,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	/*
 	 * Make this the only thread in the thread group.
 	 */
-	retval = de_thread(me);
+	retval = de_thread(me, bprm);
 	if (retval)
 		goto out;
 
@@ -1283,11 +1326,6 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1349,18 +1387,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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
 
@@ -1479,6 +1505,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
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
index 98a031ac2648..eab3461e4da7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2785,6 +2785,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
+	if (unlikely(current->signal->exec_bprm)) {
+		mutex_unlock(&current->signal->cred_guard_mutex);
+		rv = -ERESTARTNOINTR;
+		goto out_free;
+	}
+
 	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
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
index 4b7664c56208..6364e115e9e9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -235,9 +235,27 @@ struct signal_struct {
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
index c033a201c808..0066b5b0f052 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -375,6 +375,30 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
 	return false;
 }
 
+/**
+ * is_dumpability_changed - Will changing creds affect dumpability?
+ * @old: The old credentials.
+ * @new: The new credentials.
+ *
+ * If the @new credentials have no elevated privileges compared to the
+ * @old credentials, the task may remain dumpable.  Otherwise we have
+ * to mark the task as undumpable to avoid information leaks from higher
+ * to lower privilege domains.
+ *
+ * Return: True if the task will become undumpable.
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
@@ -403,11 +427,7 @@ int commit_creds(struct cred *new)
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
index 2fabd497d659..4b9a951b38f1 100644
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
@@ -450,6 +451,27 @@ static int ptrace_attach(struct task_struct *task, long request,
 				return retval;
 		}
 
+		if (unlikely(task->in_execve)) {
+			retval = down_write_killable(&task->signal->exec_update_lock);
+			if (retval)
+				return retval;
+
+			scoped_guard (task_lock, task) {
+				struct linux_binprm *bprm = task->signal->exec_bprm;
+				const struct cred __rcu *old_cred = task->real_cred;
+				struct mm_struct *old_mm = task->mm;
+				rcu_assign_pointer(task->real_cred, bprm->cred);
+				task->mm = bprm->mm;
+				retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+				rcu_assign_pointer(task->real_cred, old_cred);
+				task->mm = old_mm;
+			}
+
+			up_write(&task->signal->exec_update_lock);
+			if (retval)
+				return retval;
+		}
+
 		scoped_guard (write_lock_irq, &tasklist_lock) {
 			if (unlikely(task->exit_state))
 				return -EPERM;
@@ -491,6 +513,14 @@ static int ptrace_traceme(void)
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
@@ -506,6 +536,7 @@ static int ptrace_traceme(void)
 		}
 	}
 	write_unlock_irq(&tasklist_lock);
+	mutex_unlock(&current->signal->cred_guard_mutex);
 
 	return ret;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index aca7b437882e..32ed0da5939a 100644
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
index 4db327b44586..5d4a65eb5a8d 100644
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
 
@@ -52,19 +76,76 @@ TEST(attach)
 
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
-	ASSERT_EQ(k, -1);
+	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, WNOHANG);
 	ASSERT_NE(k, -1);
 	ASSERT_NE(k, 0);
 	ASSERT_NE(k, pid);
 	ASSERT_EQ(WIFEXITED(s), 1);
 	ASSERT_EQ(WEXITSTATUS(s), 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFEXITED(s), 1);
+	ASSERT_EQ(WEXITSTATUS(s), 1);
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
@@ -72,12 +153,46 @@ TEST(attach)
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
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
+	ASSERT_EQ(k, 0);
+	k = waitpid(-1, &s, 0);
+	ASSERT_EQ(k, pid);
+	ASSERT_EQ(WIFSTOPPED(s), 1);
+	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
+	k = waitpid(-1, &s, WNOHANG);
+	ASSERT_EQ(k, 0);
+	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
 	ASSERT_EQ(k, 0);
 	k = waitpid(-1, &s, 0);
 	ASSERT_EQ(k, pid);
 	ASSERT_EQ(WIFEXITED(s), 1);
-	ASSERT_EQ(WEXITSTATUS(s), 0);
+	ASSERT_EQ(WEXITSTATUS(s), 1);
 	k = waitpid(-1, NULL, 0);
 	ASSERT_EQ(k, -1);
 	ASSERT_EQ(errno, ECHILD);
-- 
2.39.2

