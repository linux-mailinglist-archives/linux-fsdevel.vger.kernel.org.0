Return-Path: <linux-fsdevel+bounces-35226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82F9D2D03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D09282BD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625051D278C;
	Tue, 19 Nov 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LMKnGSWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012031.outbound.protection.outlook.com [52.103.32.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE71D1E6C;
	Tue, 19 Nov 2024 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038680; cv=fail; b=blfZdSQOXwAcoWOTp+WnQ3M3icWHEoFi0Heoqmuz2NKYZUhY9TGskcJHhk9gOYay0sMk1qbHbniPpfmBVULQEXzCXhUW5YCGhGWEiT9yjJT7iYrBOcT7rrObvmsrs3yvoYZM6qX/bgFCZQkMa2DJiJgmCUSLp+LQk5TqOOZ6LOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038680; c=relaxed/simple;
	bh=khZPLwlauvaIHiZQHN/ih7z8+9Rw+vuB/2nKKfwZBKM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u/CRpQTZevmXBC1UBfdIE4ZuGwhLrONTtLSB0SwQ9PwLejqLpPEk6zesuRBa4CMB+le3XEHZyNWz62FE+4Yg/psDDlPk2m1oVU4AFLYZl++gAJ+/6dwCy00A8YL3f2bB02AIuEE5QTxhTKuhSl5LG/klCAZ/0Tnc7vfjXN6nQyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LMKnGSWP; arc=fail smtp.client-ip=52.103.32.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTy/BH39J5s+QxTv4VJ8KT+96shl4iWNzQU9ZDT8Nraj9GjVFPLjVSzp1q7fTy+VcgS8l0bL6sLxhieQFzHfpYuQuMDEsTwt99Gbhrv+k9SDKAIg3eqJ+5kKYce6dnr0O1u+wBjkPmn6UjYHd5j9eH11kW1w9s0gh3db+TG2ajMG0vz8v+IPmdWKobyRBEr90prJLBSSRC02EasV2B79ClDxdt03hIJg/2xXDoaQg6a5uYZATO0pSg5fawbI2OrkpSPw36f8CJVtoF0TDbfoFWlJ9z7BBVr2H2MznLp84BvxvkBPXqPA8/ntXywXUSzZTiHBfVos3EtOIk6iqQxSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU0dzO9BL0TYevVS71awQ42x1KX7RB3Gin9aG0Y/Po0=;
 b=unUOcG+SiAEnntrBIIK1NC8aahAwSprHJtqTiFAzzRGwSlewzz6+MM5uqBkANMCeJmE0s57Ozx4wnyIx2YNLA80N+vRUBsdoU8xHcAHPNJladm4Og8iOPF12H7iVVMnDO6T1jy65TO+Qmm4AoRbpGKG8oJg2Ip7z0aacjMpRCN1msAeqUihLhWfI56aP0QcekBFb/FcfdIu0/HWImGeIBHQvpI5WSlC7tCcSlpDWUAzWGpRccjjXw7+vUpHP+78O+jep5Cb5rdkj6oZtMBBdBi/cpKAcKGmW+aIHE/h5x9sE8vqsh9l6K5I4dA9o7D5dAz4FC3SVpHlecbobT65/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU0dzO9BL0TYevVS71awQ42x1KX7RB3Gin9aG0Y/Po0=;
 b=LMKnGSWPgU2vpTyHYCcMcMY4RSh6G1w/NSBXVIt4uF0k05wJ+tBDDNu4GdOPV8tWtFymqKyC/VRQnaa++k7oEik4igFgisPZR8g+rnjYFHOK2b9XejfOK1CLDv8irPKPkXgs5x4U82AYJcbQru3mQ4Dqi52iiv0FSZAhWiY/MI1IWpz0sCI5B8vpjG0PGzzhDe6n/HidwT2d5A1bCNrWlISbGsNa5khYYP4kj7/oxqz0lMWfVBcgyi2bY8Hkivfa6Io0rW3o/DT7BS+8LyZ96GNnqtnFK5VM24dneaVGxxO93cbzVBQRM/LgFBujXzidyEZOcsIScPlhkBHHdrEByA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB8PR03MB6170.eurprd03.prod.outlook.com (2603:10a6:10:141::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 17:51:15 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 17:51:15 +0000
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
Subject: [PATCH bpf-next v4 0/5] bpf: Add open-coded style process file iterator and bpf_fget_task() kfunc
Date: Tue, 19 Nov 2024 17:49:38 +0000
Message-ID:
 <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241119174938.51519-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB8PR03MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d96cfed-c08b-4b4b-35a9-08dd08c2c3b6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|8060799006|5072599009|5062599005|461199028|4302099013|3412199025|440099028|1602099012|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?roxlTWjMjoUwH/p2r9sltrvEdVJUdSifkgymkrcXfNikGsBCDR4jzYpkOTF3?=
 =?us-ascii?Q?nmHVvtd9YCyZzAGiSBKDEB0jdftbaREft3uK8zzM7nahyQ3V3+jY+A2SYrjU?=
 =?us-ascii?Q?yv2FanKZ+BpZUXJvvSt4Ic6gNYhHO6SvvXRuLb7g5uq0hf5O5TmYzlA7yHlg?=
 =?us-ascii?Q?4zybQCdE/CdMcmLF97IxB7hRj0/IkXROB+47TfdRciIlafYGeKal4rfJeqUo?=
 =?us-ascii?Q?OpZtoxo1bIpEnL5rsIqsqhuluOV56lTuHC0rdFCib0aF7xCQj+YCoAMPrIxa?=
 =?us-ascii?Q?7wxDyYFjWO/HKqCGOXpBKCaHTl98qQvWPgRmqi1jPKELCq6OHpLWlUf99oPf?=
 =?us-ascii?Q?+MYTfEE7jkJ8gniXbzK4yvCdTmHPhguYcFdkqeGxqtmJH780nG1levPey7xO?=
 =?us-ascii?Q?g5d2Kytb/5nH44xovLgT27RyZPLm7i3KbZbkHe/eEsB7s67pa9qSzD1MOU40?=
 =?us-ascii?Q?QFrzutvtZFUP67iZFvLJHk4yFyikyhoHatfrVP8Lcr2oU8cAdM2d5dELcWgM?=
 =?us-ascii?Q?QXHJQa9zHOElNtAgKtUtDD3kmGO4tbJBYfCk4O13rduPznB+QPSf7HGjORGr?=
 =?us-ascii?Q?VL1TmVDoo8AiEdsiZTsfnfYsLOPHJZpSNFtA9ugWLTQiCvn4a7TzyIPkMRcd?=
 =?us-ascii?Q?o8aVPpWNEWuytBj83v+DKsn75RNon+Ck/gAfjrEfnw+YDIaUnkZXn3auUknz?=
 =?us-ascii?Q?8D3oqnbZ17AErY61SNnp6rBOpdkyN30feR0deKdYnY9eNQsk6HIlpQE1W7r2?=
 =?us-ascii?Q?D2O/vnkaYMAYLprxY93eR/gC8y2iq1RmELtXZcahCf7y7Me2tTNoaHr1viLN?=
 =?us-ascii?Q?GHXyse+DmCgcvB7fLqobzWOp/W8DJXqkO6VTvWi+gFINvynHyzQ7uTVFVJC1?=
 =?us-ascii?Q?GRMj5nbJCODmprI+/Zyq791i8VfI1lGDQbEu45NKTZu05ncMIKvASQkrv6Xf?=
 =?us-ascii?Q?3nazNmerVw9uWgLLWrEi2qSok//RGEc5KmcbayYSRf8rURdrUq8aKGEmDM41?=
 =?us-ascii?Q?BpCDBdgpizlCE7ooJB5nN/k5wb8ci2CsUsx7lxrmu5pQPzbZ7r/OBDCOQ3VB?=
 =?us-ascii?Q?luYlHiE/9hRXkePWRLjzAkjDz6GgZoDPun1UkdkduscMQQqOeu4ZoJx7DEII?=
 =?us-ascii?Q?g8lkyoMw9Izun+kcVFpESvorM6qGE+4V92Q9Hkul98/bkrO9BSk0bADWJUVk?=
 =?us-ascii?Q?xXfN7aHbECueWWaNJmb7/mgVRYoAXr9J8xoelg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1epblx1j8wBZ5s0O7JtuYQqIZ4HCNPVI8HgxQ4cPwScoEhVbY8lZcdii6gYq?=
 =?us-ascii?Q?/e2e48NTQB9PQo/W7k2RgwJhgb9EOW4WbJM7v7EKCoUkNWoucxd2u7vKJdsK?=
 =?us-ascii?Q?vXR/BdSCctOvbmm52bazDVUxeIpo6CUzpTVnmG+Nd8T5lr7FqrtslnKNRwbp?=
 =?us-ascii?Q?uIGs4+skaoGwFNw2wKnst7fHRy7l8sfjJF6TdG1UsBNc/qDEWYgW692kOatA?=
 =?us-ascii?Q?vnJFeFplbs1Ln3S86wjRLLlnKcR0IVp9CPJt4djety5rFdVicRxHxdL1HS/2?=
 =?us-ascii?Q?Ev3t235uJzKyIxq3KwDAoe0Z9y83BJ839MMIeUQJzAHwGuNh3eks+PSpOUjM?=
 =?us-ascii?Q?zMNDuM7sliS6k66ct+TssWpoHGG62ysAwVGvKyD75KgJ/A1c4yf47HCvsARL?=
 =?us-ascii?Q?Ht3jIfswOXc9sqkhy3I/ibTWf/9WasAXUfwC75TbkLjGYZXx4r1k5cX7+Sfb?=
 =?us-ascii?Q?vcVMg4WNrL2NtubKq2t7jbEtOUz10sccVPDp3OeE2enaN0j6W/XeCiVsY59y?=
 =?us-ascii?Q?rF1LjIte664L0NlyaNekPRe/7kWAG2khwMDvoc0cBmIPhyxwjSn4qqjwhiP1?=
 =?us-ascii?Q?0zVI6zYso2frP9AmsS4Tmlp0nStelGb8jBD3HbL8vfs2zEQ50yKSU/yp+lxN?=
 =?us-ascii?Q?yhCTmQOLLigZkkTXdA3jBK9nBoBiQizbjHEfUyIDJjuHdeERo4Yk7JxaOeub?=
 =?us-ascii?Q?PLJLmhO/Ul7QB1CNl/9rd/yfGVSjQpukX1uQ1kO6rKGVDFw9K7hU4R826BR6?=
 =?us-ascii?Q?c9xUroYt0Up8NC2YiXnz8I7Gajimo9R+3KIHXLNihUP1Z9mYyO7/hKubkU0X?=
 =?us-ascii?Q?q84gJH1iRGkHPifvY9XtMVITQnMizquaTJM5QSWmMJ/RVbzPQoflOpouih4y?=
 =?us-ascii?Q?cyOGjyuV2WwGSHlfQrxv/eXSfMsUfGBe1BPI1//nN2wk/8s2Ur72u/7Bcxl6?=
 =?us-ascii?Q?WasCMsputOQqllUpa02sE5XSj0kVIqhQT+4Aq6KudrhP5RCwcjF6W9DNHdL6?=
 =?us-ascii?Q?gtnNJUH8TR7uzVZAA36OnXK5xPSFfteMryFMw2QJ0XsqQGfGdx9jvZS4GLks?=
 =?us-ascii?Q?Cx4RrNG3QjqbgeJz7QmHp2TwowdkCyWb/g08MgHEvDArrs/SWz7jtjYbCT3Q?=
 =?us-ascii?Q?r4sSkHoEN5Conmbvag7mni5hQEpMdvGcDfuwF87buEmiZTaGif82Q0AXOuPI?=
 =?us-ascii?Q?66fppgOutXn3QRDcW4C8zzs4rXo6fkxppbplNRo3LGYPvEH0sV9oLl/wwnMl?=
 =?us-ascii?Q?ZjZrdL1qmsfqMiwE8cZs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d96cfed-c08b-4b4b-35a9-08dd08c2c3b6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:51:15.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6170

This patch series adds open-coded style process file iterator
bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
selftests test cases.

In addition, since fs kfuncs is generic and useful for scenarios
other than LSM, this patch makes fs kfuncs available for SYSCALL
and TRACING program types [0].

[0]: https://lore.kernel.org/bpf/CAPhsuW6ud21v2xz8iSXf=CiDL+R_zpQ+p8isSTMTw=EiJQtRSw@mail.gmail.com/

Known future merge conflict: In linux-next task_lookup_next_fdget_rcu()
has been removed and replaced with fget_task_next() [1], but that has
not happened yet in bpf-next, so I still
use task_lookup_next_fdget_rcu() in bpf_iter_task_file_next().

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8fd3395ec9051a52828fcca2328cb50a69dea8ef

Although iter/task_file already exists, for CRIB we still need the
open-coded iterator style process file iterator, and the same is true
for other bpf iterators such as iter/tcp, iter/udp, etc.

The traditional bpf iterator is more like a bpf version of procfs, but
similar to procfs, it is not suitable for CRIB scenarios that need to
obtain large amounts of complex, multi-level in-kernel information.

The following is from previous discussions [2].

[2]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/

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

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v3 -> v4:
* Make all kfuncs generic, not CRIB specific.

* Move bpf_fget_task to fs/bpf_fs_kfuncs.c.

* Remove bpf_iter_task_file_get_fd and bpf_get_file_ops_type.

* Use struct bpf_iter_task_file_item * as the return value of
  bpf_iter_task_file_next.

* Change fd to unsigned int type and add next_fd.

* Add KF_RCU_PROTECTED to bpf_iter_task_file_new.

* Make fs kfuncs available to SYSCALL and TRACING program types.

* Update all relevant test cases.

* Remove the discussion section from cover letter.

v2 -> v3:
* Move task_file open-coded iterator to kernel/bpf/helpers.c.

* Fix duplicate error code 7 in test_bpf_iter_task_file().

* Add comment for case when bpf_iter_task_file_get_fd() returns -1.

* Add future plans in commit message of "Add struct file related
  CRIB kfuncs".

* Add Discussion section to cover letter.

v1 -> v2:
* Fix a type definition error in the fd parameter of
  bpf_fget_task() at crib_common.h.

Juntong Deng (5):
  bpf: Introduce task_file open-coded iterator kfuncs
  selftests/bpf: Add tests for open-coded style process file iterator
  bpf: Add bpf_fget_task() kfunc
  bpf: Make fs kfuncs available for SYSCALL and TRACING program types
  selftests/bpf: Add tests for bpf_fget_task() kfunc

 fs/bpf_fs_kfuncs.c                            |  42 ++++---
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/task_iter.c                        |  92 ++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  15 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      |  46 +++++++
 .../testing/selftests/bpf/prog_tests/iters.c  | 105 ++++++++++++++++
 .../selftests/bpf/progs/fs_kfuncs_failure.c   |  33 +++++
 .../selftests/bpf/progs/iters_task_file.c     |  71 +++++++++++
 .../bpf/progs/iters_task_file_failure.c       | 114 ++++++++++++++++++
 .../selftests/bpf/progs/test_fget_task.c      |  49 ++++++++
 10 files changed, 554 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c

-- 
2.39.5


