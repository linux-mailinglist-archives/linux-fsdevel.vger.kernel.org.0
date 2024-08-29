Return-Path: <linux-fsdevel+bounces-27798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40459964240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E78284D84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5623618FC68;
	Thu, 29 Aug 2024 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mc7Hr06e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928027E59A;
	Thu, 29 Aug 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928744; cv=none; b=dH2nbO9Nl6aNLx3k2ZuqPvGQLR0i45MLRnoPnBK8LpIxTC8MjjfhCGmFDIFxnzh3iWSfdn16pR9HgPlIH05YJ20yTFOyOjjvC52rq1o+W/kpcyBtzDjN1nzL+Qwh5OQcBqCPkMqOm4dqW9FbYleBeAmRvow9ewWbeekRRK33HKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928744; c=relaxed/simple;
	bh=zpPVtYuB9DrL9/jh8DS8DKJOq8AJxMegCXbtHWAlVxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=jNefc97OmA669N7CrBjKnvyMalzTIM6ZgnMSSGLFr/Fagco7V/JtyBRYKn3ShB6KXq0Yh39PcpOnvP/nhWkbFsGqL72oT7HAujFMjdeBkTVg6zNJwF1BUc9CQr5pCFh/EeA61vbL1qdr0tkXzaE6j//xw9iOaguXqSz7ST1MtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mc7Hr06e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SN9IxN011867;
	Thu, 29 Aug 2024 10:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=pp1; bh=tZ2m6cGbssb2eQQxLLr4pHVO8a
	FtJWY9zGD9aFKJ+40=; b=mc7Hr06et4TSHDvOJVR5+HxC8tqhAWgLD2WVAH4+YH
	PQa7gjRHCcb+rRJt8aIZCGvDd1AHxzzjCIW66Oshl6+1rD+t17vQgXXZR8PFtLH/
	tCns0c6NxBzX4CPNIGXd5QCBXh68NESDALPB6YTKmS7yOWBBUc9xYKXjRkVBVugx
	85nhxky6Megy/evWNdkh5mCdj/hdx+DHgGUbEcWrfbHEHTM1FYbkiAdPOqMNT3Up
	QW5askDzs303YoBHvtdN+pgBaklYrIffm+G1RNYAcJkf0aAcqF00GmOejcqh8o1y
	2pdJrGw/4QXeSFwImYE0CbcxvBJBYLNXcA7O9KJY+auQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8nys9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 10:51:30 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47TApTYp022391;
	Thu, 29 Aug 2024 10:51:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8nys98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 10:51:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47T7dKkm024604;
	Thu, 29 Aug 2024 10:51:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 417vj3kyk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 10:51:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47TApQsh57344330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 10:51:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6EF22004B;
	Thu, 29 Aug 2024 10:51:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2133C20043;
	Thu, 29 Aug 2024 10:51:26 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 29 Aug 2024 10:51:26 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
        gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
        david@fromorbit.com, Zi Yan
 <ziy@nvidia.com>,
        yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
        cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
        ryan.roberts@arm.com, David
 Howells <dhowells@redhat.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
In-Reply-To: <20240822135018.1931258-5-kernel@pankajraghav.com> (Pankaj
	Raghav's message of "Thu, 22 Aug 2024 15:50:12 +0200")
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
	<20240822135018.1931258-5-kernel@pankajraghav.com>
Date: Thu, 29 Aug 2024 12:51:25 +0200
Message-ID: <yt9dttf3r49e.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ehVx0YOFUOxlgx-cd_uCO2KSV4ZsDkMy
X-Proofpoint-ORIG-GUID: s5_o5-fSOlfuvzo-R9J6nU0ZVke-kGcX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=954
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290076

Hi,

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

> From: Luis Chamberlain <mcgrof@kernel.org>
>
> split_folio() and split_folio_to_list() assume order 0, to support
> minorder for non-anonymous folios, we must expand these to check the
> folio mapping order and use that.
>
> Set new_order to be at least minimum folio order if it is set in
> split_huge_page_to_list() so that we can maintain minimum folio order
> requirement in the page cache.
>
> Update the debugfs write files used for testing to ensure the order
> is respected as well. We simply enforce the min order when a file
> mapping is used.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Tested-by: David Howells <dhowells@redhat.com>

This causes the following warning on s390 with linux-next starting from
next-20240827:

[  112.690518] BUG: Bad page map in process ksm01  pte:a5801317 pmd:99054000
[  112.690531] page: refcount:0 mapcount:-1 mapping:0000000000000000 index:0x3ff86102 pfn:0xa5801
[  112.690536] flags: 0x3ffff00000000004(referenced|node=0|zone=1|lastcpupid=0x1ffff)
[  112.690543] raw: 3ffff00000000004 0000001d47439e30 0000001d47439e30 0000000000000000
[  112.690546] raw: 000000003ff86102 0000000000000000 fffffffe00000000 0000000000000000
[  112.690548] page dumped because: bad pte
[  112.690549] addr:000003ff86102000 vm_flags:88100073 anon_vma:000000008c8e46e8 mapping:0000000000000000 index:3ff86102
[  112.690553] file:(null) fault:0x0 mmap:0x0 read_folio:0x0
[  112.690561] CPU: 1 UID: 0 PID: 604 Comm: ksm01 Not tainted 6.11.0-rc5-next-20240827-dirty #1441
[  112.690565] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
[  112.690568] Call Trace:
[  112.690571]  [<000003ffe0eb77fe>] dump_stack_lvl+0x76/0xa0
[  112.690579]  [<000003ffe03f4a90>] print_bad_pte+0x280/0x2d0
[  112.690584]  [<000003ffe03f7654>] zap_present_ptes.isra.0+0x5c4/0x870
[  112.690598]  [<000003ffe03f7a46>] zap_pte_range+0x146/0x3d0
[  112.690601]  [<000003ffe03f7f1c>] zap_p4d_range+0x24c/0x4b0
[  112.690603]  [<000003ffe03f84ea>] unmap_page_range+0xea/0x2c0
[  112.690605]  [<000003ffe03f8754>] unmap_single_vma.isra.0+0x94/0xf0
[  112.690607]  [<000003ffe03f8866>] unmap_vmas+0xb6/0x1a0
[  112.690609]  [<000003ffe0405724>] exit_mmap+0xc4/0x3e0
[  112.690613]  [<000003ffe0154aa2>] mmput+0x72/0x170
[  112.690616]  [<000003ffe015e2c6>] exit_mm+0xd6/0x150
[  112.690618]  [<000003ffe015e52c>] do_exit+0x1ec/0x490
[  112.690620]  [<000003ffe015e9a4>] do_group_exit+0x44/0xc0
[  112.690621]  [<000003ffe016f000>] get_signal+0x7f0/0x800
[  112.690624]  [<000003ffe0108614>] arch_do_signal_or_restart+0x74/0x320
[  112.690628]  [<000003ffe020c876>] syscall_exit_to_user_mode_work+0xe6/0x170
[  112.690632]  [<000003ffe0eb7c04>] __do_syscall+0xd4/0x1c0
[  112.690634]  [<000003ffe0ec303c>] system_call+0x74/0x98
[  112.690638] Disabling lock debugging due to kernel taint

To reproduce, running the ksm01 testsuite from ltp seems to be
enough. The splat is always triggered immediately. The output from ksm01
is:

tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1809: TINFO: LTP version: 20240524-208-g6c3293c6f
tst_test.c:1813: TINFO: Tested kernel: 6.11.0-rc5-next-20240827 #1440 SMP Thu Aug 29 12:13:28 CEST 2024 s390x
tst_test.c:1652: TINFO: Timeout per run is 0h 00m 30s
mem.c:422: TINFO: wait for all children to stop.
mem.c:388: TINFO: child 0 stops.
mem.c:388: TINFO: child 1 stops.
mem.c:388: TINFO: child 2 stops.
mem.c:495: TINFO: KSM merging...
mem.c:434: TINFO: resume all children.
mem.c:422: TINFO: wait for all children to stop.
mem.c:344: TINFO: child 0 continues...
mem.c:347: TINFO: child 0 allocates 128 MB filled with 'c'
mem.c:344: TINFO: child 1 continues...
mem.c:347: TINFO: child 1 allocates 128 MB filled with 'a'
mem.c:344: TINFO: child 2 continues...
mem.c:347: TINFO: child 2 allocates 128 MB filled with 'a'
mem.c:400: TINFO: child 1 stops.
mem.c:400: TINFO: child 2 stops.
mem.c:400: TINFO: child 0 stops.
Test timeouted, sending SIGKILL!
tst_test.c:1700: TINFO: Killed the leftover descendant processes
tst_test.c:1706: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1708: TBROK: Test killed! (timeout?)

Thanks
Sven

