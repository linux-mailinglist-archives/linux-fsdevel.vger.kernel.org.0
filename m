Return-Path: <linux-fsdevel+bounces-33817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6063B9BF758
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C471C21DE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3577D20BB27;
	Wed,  6 Nov 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VVbLVXtQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2100.outbound.protection.outlook.com [40.92.89.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9320968E;
	Wed,  6 Nov 2024 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921737; cv=fail; b=VKAYNo+ddlaZJj/XBpPakzqpkmEqY7OD/pABTLZKbpy9hSW0htguSeFtcg4izHdZInttN9PPvw883cpGhqgrrMwvkJC/cGsqmKDeT7DnVAh+CJ6ev7WJCBNH1f2uXAUSzMQodJI3W/6XMqD3HFfxufPc/fz81O+zba0ALPlYELo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921737; c=relaxed/simple;
	bh=j3tuWgy9wMlXrVKZrpbol7zEr38O6ReSHWojpfcpcJI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jI4eD3YIP5eDHxYmVnW4joTusyYJLMH6LgumO6XTxKYiexEk5wSaMP1ztmw5JMtFve9IHwvS3BMNn9D7rlQj2p6DwsWvpuLTM/dPpv2hr4DQBVfyw/jJdvqWoSlyzv9OOll7KYhtmHoKv8xTxdmzmM+BzWoaZJK10T0NhWi5QLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VVbLVXtQ; arc=fail smtp.client-ip=40.92.89.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+uV+UFEWNvkrpUjuvdNY1xjNYPWEwMDfsAo0YQ5PFba3pwhKYax049PQk70AMFcpjHHD6xQ1n0JXZAYh7JR4tJGxdT/75VkUhitZ8STDFS+i+PtC40HXFLsgsI9XRbXVzi4y4tJuxzsCu/ZuYzL5i4X05dA1v1yLQ+59k0dKwZNNxS8ek7We3vB4MQFlaxCTlYoFv7XplMLk3H3IiYjAet3ojzOJ717mGkgkVhNI3kgB9SQ2jX2hgRsfHtoYkxndpAc8DhchGkHo53UjGwubehHW1UXWZeaKuvuo0n6fqQxmd6gILVx2F1SQvQj/5zUuwpZ9V4Uo2ih5NZBYGg+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hHJyZqGGxmCf9sw7HTlWRvmB1aVAVmb801VvA9oCCs=;
 b=KqZc0fD9j717ZK5gjuPXmlSQhcuHznKbRvcAWcg1ZUziHfuna2cSd5c1u1+gKcNvE3XP+Uz3xEYnquS61Z3UI96cact5lRPq5qEYNfuGHK+YrJ12Donz9hRIwY1bvHzy/fyyoXkmjoScmNTcAyT2Kd1zWIFYGFsDyZZjoD9bQ8N9+DmfhHdbDFO0GjaMZtSj09vVLeB+qSsdIl4T35sW8JOOujU97l0SDNgVTirMsKDLPbYF2FQbihnvBsGKBSnO+05gjPTecIAzI9EZTqbcAYhRFB+NPb3xNmY0E9LMDw7eOuqiUVSIWUw5D1q9UiiK/2pWuOESfDdb7amvAyo0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hHJyZqGGxmCf9sw7HTlWRvmB1aVAVmb801VvA9oCCs=;
 b=VVbLVXtQKIEH081ZNT5R+pmMax1tFTwORyTnn9JHETD45HlZic7tTLD8qH7yIGZnqCBf9zcXj56d53f6xV3xieYasj/l7iYyRrVnbc7P32GTh+IQ7L+QPf45gS575M6ffb2AQiD6AkXzdVM1OleelCCmswiawCexO9mdUCdiRwt+uQH9oJ4GWsJ3+7UPURz17NJ+oONCDPwZdKJXBALSKCPx66PmXV+cT0JndytDBw/ULTlVXJ0WjVB5b7XVbON3QhoD62hBXHZeOQfWhPZMVqo9p5UPEm/m5plP8ndmI8TgshUFoXUiC4S56lUwyGDli3HiwLSMCgt0/onlAlLHBg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GVXPR03MB8331.eurprd03.prod.outlook.com (2603:10a6:150:6e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 19:35:32 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 19:35:32 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com,
	brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/4] bpf/crib: Add open-coded style process file iterator and file related CRIB kfuncs
Date: Wed,  6 Nov 2024 19:31:06 +0000
Message-ID:
 <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::16) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241106193106.159562-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GVXPR03MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: ce58d83e-af40-4273-c614-08dcfe9a2d69
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5062599005|8060799006|19110799003|5072599009|15080799006|440099028|4302099013|3412199025|10035399004|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eE6IpfHNrXCE1l0IQ3+RvfTmo2lEiNhFo5RCLN9u1eby+OsrwOSlQmkGzgpD?=
 =?us-ascii?Q?BXBh8QQqpZfL2GKlppxzOFz0XIjYaQHDhBLhD0TgaWVcU/fToeI7s0WfF4DU?=
 =?us-ascii?Q?oaPx6DgyJHWUpnZE8560/eIA1+agN56nKHMHlv9o00pd+YK0z56DwIpJ34SX?=
 =?us-ascii?Q?oBdNjZ6c4ZBnOkV9O36e+fPnhYSn0YWuhuyTuKPsxkTTgesSvrDRLk9aRqUs?=
 =?us-ascii?Q?blj/l69Vn64Ogq6ZL6hkafn5V81yXzPCXjbfOaqdds1fwj2UvttZ+haNqP3+?=
 =?us-ascii?Q?H+uABY9bYyEgZxVfUp7+HK8q0bxfTu2dP3WW/Iy80MjoHWHv5al/JQwZBGiC?=
 =?us-ascii?Q?tquHfXSQoJi4T0YDrnvFgshIIKexe5HCep6GveJZEOUC+KgdThXR4VgZBXlk?=
 =?us-ascii?Q?CDmoCReF8ptId+ye7bAgDN4P4TSVeDf13WvoZtX6Ata1ULoQDZPLF2hp/scg?=
 =?us-ascii?Q?+SG2CE61y8bTZVVR+y5MQEJzkrVXaW441wIjcyUgUsccITxSuygZi0TnQUNq?=
 =?us-ascii?Q?wNgB6u5kX9eZQh01lxXBbIJClKqs6Vz/5xVxBoQfUXeqdox8n/gPBilTnouN?=
 =?us-ascii?Q?Yk5xpddcKE7IjpE1gq3tXrPP7M3usBmwS2lh1HEYaPlzY5UUijCAxDLjsgde?=
 =?us-ascii?Q?qPUT6jdPjqnHDFYqqQccz0huZjWQLI9JQ4YqJXjF9YWxrGAvQ36Qy/bpHt+R?=
 =?us-ascii?Q?IrK4odxww1Om+oNoetE2t7rROqYB8PIBj7ggvR5cWS7L05l3kCI9fIDQcFb5?=
 =?us-ascii?Q?GJE7hxF+NcugCeVDjudHsYVE3DM2ZiyP5iFIILZQFcXlpsL9xeqxfolYFZ29?=
 =?us-ascii?Q?F3AmlzbQpWHTx3djCJZw/dvYMmeq1aZbqbQCSOd6X4R4BWRBomlF8A8YdqhT?=
 =?us-ascii?Q?kCXoaLs6Ey1Av7CVXkTqQL9jhrk77FoBvstE1oZbBXc5tgiknANwRVGpw3pQ?=
 =?us-ascii?Q?aRgL2Aagk9UwGh+DoY1oFhjmPAs28XxZi/T8c0t1RhvPrqwuCzCzoc+rUfmo?=
 =?us-ascii?Q?5AcXJNUHL3QFNwUSKM5K7xmJZpCr5p2pbuuqRw3SWCp8GUWS6dEQbFN1jFvI?=
 =?us-ascii?Q?Gc+/K432Jgq1d9WiS/pMDrnZ0uXzMdzqUcC0r2T1wCFESsLwuSmvdBy1/0JK?=
 =?us-ascii?Q?2O4s4FMSCltMYzDP2+Cw3qoXX+DWlhx3XTH+tKbS/SNf8usrt5zfVJOw9RU2?=
 =?us-ascii?Q?qBgD5ym098m8ANhF2Do2dTiE9hEspPJePo3LAw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hzapaWA8ZgneybEqdD4bkYnzwo+oSojfcr1WQwQJaeqozD7A+/qdmfR4fgbz?=
 =?us-ascii?Q?JthNxIPkvhyeme+f7SiBp0gCO9yBRto8/oE4ilnrv3T4U0jfYKrpYf6sVge9?=
 =?us-ascii?Q?R8w9oHRvIYdfEJ8XJXJGzTYuV/GQcwoJQ7QXZSsSLI+iqZRV7LVGW3N4oTMs?=
 =?us-ascii?Q?7XNw7J1k4/FjtSD7SEtnydJFNsM21y15oRb9q9xJ5M/y+tptTZbZzCc6rchP?=
 =?us-ascii?Q?cj/7mTCYVtuMZ4C9mPDPKs9MOCKmSkvblN9O3zaMgEG6tYvMuiIYadGGhYOf?=
 =?us-ascii?Q?65XlnXLe9abZeiRoyoNpWbbc0DyYxErlF3cpGyMvRx07iBroXT0dDxiYVpPn?=
 =?us-ascii?Q?YtLNAnYTdgofXfzweyJ2rz0HMqRkpwTjTqdXtjcOv034OGBWI5SzP6FU3Bqm?=
 =?us-ascii?Q?8h1mPR6bCjuQkv9Ic/Xq0u/pymX3o40eVlJph7EQs+Fjztt8CBYH47oxsXFU?=
 =?us-ascii?Q?qMrKGkMC5Boiv+M3tQPbU0x2ZZicr2o4zCRW0PWOLoQ2KTSBTgugAcfFHx74?=
 =?us-ascii?Q?vF+aioz0mBDT8RG1FzmJ90SoviNTo+MmBqbrq1N46QCFlPGnbNXDk34/8CGL?=
 =?us-ascii?Q?jTuJ1Tz6G/Nlt4SAC8Wed4yiz+MJvLo9d/fSwNa8ecywsYmckesWHT6teM+i?=
 =?us-ascii?Q?XFJQUmIvIAvXN6heDGUH8igZvijxnJeNEZrpUWXnInOwBQ5K/WrGcLyYMofx?=
 =?us-ascii?Q?Qq8lMDF56C0Nxdu0zeFvO4Jws4TYVNufB31SBMZelNTDtF+QjWAm1LgZWJiH?=
 =?us-ascii?Q?z03CoCGznKEsDeYo6anBFdT8ZJh0TnYhofKXkQtgKBo7g4LPlbmlg9hd+x+V?=
 =?us-ascii?Q?2yQGMjIbUKUnRs+tX14O20sU5JOhzDvJadDqwcAaEHSLmPKzYq7USyTHGYpl?=
 =?us-ascii?Q?RqEQTtBff7ijNhkApr9gMm1zZ79sZyRXHUaqfNZVZKRgyHfPYYac1tpsdikf?=
 =?us-ascii?Q?gaASEquV22ozVs0zkbY5+cIkoIGu6rO+ar9BKvjauHaHOuwmqo7AzERZILyJ?=
 =?us-ascii?Q?rb49JUnj2dKmOWdSO3QaDyXLDkD8vnsAAWe1WBgBrhNoTZmlSsg21XCZgpb3?=
 =?us-ascii?Q?50sYyFasJNUfDWSMdfU0zCj0xqrCkBX8KmqWVSBWsDHI1KKDtiybB4CAS9J6?=
 =?us-ascii?Q?dPghPDWC5ENQhpXccxpNkhRsyF7fGz+2fpNw9mhna5xZFFMMv8a/d6f/eTQw?=
 =?us-ascii?Q?LtCiHbC0f5jAOCv3fEeqYBKW6TgPVdMz4tYu+o3J0a+19Kc04zzDqx0BK4+0?=
 =?us-ascii?Q?YHLO2Ok4/RUA9IoTfVTO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce58d83e-af40-4273-c614-08dcfe9a2d69
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:35:32.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8331

This patch series adds open-coded style process file iterator
bpf_iter_task_file and file related kfuncs bpf_fget_task(),
bpf_get_file_ops_type(), and corresponding selftests test cases.

Known future merge conflict: In linux-next task_lookup_next_fdget_rcu()
has been removed and replaced with fget_task_next() [0], but that has
not happened yet in bpf-next, so I still
use task_lookup_next_fdget_rcu() in bpf_iter_task_file_next().

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8fd3395ec9051a52828fcca2328cb50a69dea8ef

Although iter/task_file already exists, for CRIB we still need the
open-coded iterator style process file iterator, and the same is true
for other bpf iterators such as iter/tcp, iter/udp, etc.

The traditional bpf iterator is more like a bpf version of procfs, but
similar to procfs, it is not suitable for CRIB scenarios that need to
obtain large amounts of complex, multi-level in-kernel information.

The following is from previous discussions [1].

[1]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/

This is because the context of bpf iterators is fixed and bpf iterators
cannot be nested. This means that a bpf iterator program can only
complete a specific small iterative dump task, and cannot dump
multi-level data.

An example, when we need to dump all the sockets of a process, we need
to iterate over all the files (sockets) of the process, and iterate over
the all packets in the queue of each socket, and iterate over all data
in each packet.

If we use bpf iterator, since the iterator can not be nested, we need to
use socket iterator program to get all the basic information of all
sockets (pass pid as filter), and then use packet iterator program to
get the basic information of all packets of a specific socket (pass pid,
fd as filter), and then use packet data iterator program to get all the
data of a specific packet (pass pid, fd, packet index as filter).

This would be complicated and require a lot of (each iteration)
bpf program startup and exit (leading to poor performance).

By comparison, open coded iterator is much more flexible, we can iterate
in any context, at any time, and iteration can be nested, so we can
achieve more flexible and more elegant dumping through open coded
iterators.

With open coded iterators, all of the above can be done in a single
bpf program, and with nested iterators, everything becomes compact
and simple.

Also, bpf iterators transmit data to user space through seq_file,
which involves a lot of open (bpf_iter_create), read, close syscalls,
context switching, memory copying, and cannot achieve the performance
of using ringbuf.

Discussion
----------

1. Do we need bpf_iter_task_file_get_fd()?

Andrii suggested that next() should return a pointer to
a bpf_iter_task_file_item, which contains *file and fd.

This is feasible, but it might compromise iterator encapsulation?

More detailed discussion can be found at [3] [4]

[3]: https://lore.kernel.org/bpf/CAEf4Bzbt0kh53xYZL57Nc9AWcYUKga_NQ6uUrTeU4bj8qyTLng@mail.gmail.com/
[4]: https://lore.kernel.org/bpf/AM6PR03MB584814D93FE3680635DE61A199562@AM6PR03MB5848.eurprd03.prod.outlook.com/

What should we do? Maybe more discussion is needed?

2. Where should we put CRIB related kfuncs?

I totally agree that most of the CRIB related kfuncs are not
CRIB specific.

The goal of CRIB is to collect all relevant information about a process,
which means we need to add kfuncs involving several different kernel
subsystems (though these kfuncs are not complex and many just help the
bpf program reach a certain data structure).

But here is a question, where should these CRIB kfuncs be placed?
There doesn't seem to be a suitable file to put them in.

My current idea is to create a crib folder and then create new files for
the relevant subsystems, e.g. crib/files.c, crib/socket.c, crib/mount.c
etc. Putting them in the same folder makes it easier to maintain
them centrally.

If anyone else wants to use CRIB kfuncs, welcome to use them.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v2 -> v3:
1. Move task_file open-coded iterator to kernel/bpf/helpers.c.

2. Fix duplicate error code 7 in test_bpf_iter_task_file().

3. Add comment for case when bpf_iter_task_file_get_fd() returns -1.

4. Add future plans in commit message of "Add struct file related
CRIB kfuncs".

5. Add Discussion section to cover letter.

v1 -> v2:
Fix a type definition error in the fd parameter of
bpf_fget_task() at crib_common.h.

Juntong Deng (4):
  bpf/crib: Introduce task_file open-coded iterator kfuncs
  selftests/bpf: Add tests for open-coded style process file iterator
  bpf/crib: Add struct file related CRIB kfuncs
  selftests/bpf: Add tests for struct file related CRIB kfuncs

 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/crib/Makefile                      |   3 +
 kernel/bpf/crib/crib.c                        |  28 ++++
 kernel/bpf/crib/files.c                       |  54 ++++++++
 kernel/bpf/helpers.c                          |   4 +
 kernel/bpf/task_iter.c                        |  96 +++++++++++++
 tools/testing/selftests/bpf/prog_tests/crib.c | 126 ++++++++++++++++++
 .../testing/selftests/bpf/progs/crib_common.h |  25 ++++
 .../selftests/bpf/progs/crib_files_failure.c  | 108 +++++++++++++++
 .../selftests/bpf/progs/crib_files_success.c  | 119 +++++++++++++++++
 10 files changed, 564 insertions(+)
 create mode 100644 kernel/bpf/crib/Makefile
 create mode 100644 kernel/bpf/crib/crib.c
 create mode 100644 kernel/bpf/crib/files.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crib.c
 create mode 100644 tools/testing/selftests/bpf/progs/crib_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crib_files_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/crib_files_success.c

-- 
2.39.5


