Return-Path: <linux-fsdevel+bounces-53059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8090BAE9610
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACD94A4D40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 06:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7A32264C6;
	Thu, 26 Jun 2025 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M2WqySIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7E84D08;
	Thu, 26 Jun 2025 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918950; cv=none; b=hfv/xOaZr4duHbRLXbhV0OE56A9ari6exGNv3q582p3A++ocDeVy1U2nB3zlBPA02cmSIOIfu+blqDw07V/eSemFd11y5/BPbkQOO5ihOY3mC11sABhXsd9bi8hTkRp77aVoPX2N3zi/hL2+QDE3NYXHuh7GKYogyJNxWocCNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918950; c=relaxed/simple;
	bh=WkPZPo3daUaXRErnYhHy9ValI38EN3AVQHNhMtFZnbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Um3tAI4YrKIzrhhKIlo+SCRaVKFf6zAcEhaXvLv6zt/8qCsqldGXmTPy+RAf8K2msEUMMzhl/I0OVmKmQR7oTbsYEqPjMFd9bNsma56QXTeRE+9pjMIldM33d9O/Cttm/PoITZE7vXgDiujTjXoQL0wNOaNnFssHezCvOVOcsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M2WqySIx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4B5bm031140;
	Thu, 26 Jun 2025 06:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wdfnoc
	0htXViaYtOXgTxlOPt/zSW2VKAxS55sMD+Oc8=; b=M2WqySIxQCyN+8AM1iOsir
	rmiQYCH+MBdOD0lQmIiNwope5LukSXncFje/ej0GeL2TWK+QkG7Ajh9dZVnikJSF
	D06iSH5jZiYjUEfB9RYIckGEWdY9VfiuTIvc2zYOxrihlNNFM3XXIyWHl6S3cDYq
	0Iw1mBbXcq3vX2Mf7D5mQ+xQ2eKwbQjxkaQ2fw1Mi5IOE0VQP6e/AnFs/62hPZpS
	DQzIhUUIeORWKPN7lSj6IepB9nkkKD4zXnFQ5UxSfuP1Wp6HTcVmRW9eICuCDCWW
	D2p8PAJw3VakiBCnu2A8cuPERpyUrUPilixWQGIA+lO6GARcIRWD9FA1SL7YK8hg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk6446ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:22:15 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55Q6LDOm025786;
	Thu, 26 Jun 2025 06:22:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk6446pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:22:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q3Z0v2014988;
	Thu, 26 Jun 2025 06:22:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72twpc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:22:14 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55Q6MD5Q29360894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 06:22:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E76935820B;
	Thu, 26 Jun 2025 06:22:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1360F581FE;
	Thu, 26 Jun 2025 06:22:09 +0000 (GMT)
Received: from [9.204.205.94] (unknown [9.204.205.94])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 06:22:08 +0000 (GMT)
Message-ID: <cb93bc0a-5412-46fd-8fe1-3e13b5b08cca@linux.ibm.com>
Date: Thu, 26 Jun 2025 11:52:07 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coredump: reduce stack usage in vfs_coredump()
Content-Language: en-GB
To: Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski
 <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roman Kisel <romank@linux.microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620112105.3396149-1-arnd@kernel.org>
 <404dfe9a-1f4f-4776-863a-d8bbe08335e2@samsung.com>
 <CGME20250625115426eucas1p17398cfcd215befcd3eafe0cac44b33a7@eucas1p1.samsung.com>
 <8f080dc3-ef13-4d9a-8964-0c2b3395072e@samsung.com>
 <cb0c926f-15be-4400-a9b9-0122a6238fea@app.fastmail.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <cb0c926f-15be-4400-a9b9-0122a6238fea@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0OSBTYWx0ZWRfX2FZfc54LZBce 4XnnaQHK19tgKjD6W6SVblrKemCIEZN4C5gp0h4TfntSUxD2Tq9H2Bnt95BNvpUiKvQ+ycdfyVZ yO/ro61tqytKs1ZOHVKBe0xadcrUxQWlNj8WzlP4LCmybY7PJ7WTAHpZ40yeAGye9kQUbtZMGsR
 QIxurCSs3rF2bq13qK1JSuNtrGg2agQp3Pjs+0AOJfi+cUo6CysJaQ0lAVZIggmftwTTg6f42Fn x6jAWu3BbS2Jb9gpfGjQyX/Mg5/olqxF4mSU5rNFRj/aspJMlE8nCccqo6+cao3ZSuttSAZiUw/ FL8Z6/Y/1XU8hxwx7KoXcqLr5SAavoiuNYHUEwkDWkyvSLcxsKs+0zzg4ecNsUD39QVHFDTI1kY
 YWWOiTRA2hhuT6Daf9bFxGPnU/QExJJzvy+tNjc2Y3aTs3nNI4sykPSHK1T9vVW9koglkEWN
X-Proofpoint-ORIG-GUID: bUcB70Q8gqodglWC38c8gomlNFJWYJrW
X-Proofpoint-GUID: t9d9wTEmMFnHZVLxTPySLD3U5-kjZE5u
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685ce717 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=oBfdlqT_uavYyDoXnq8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=585 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260049


On 25/06/25 6:59 pm, Arnd Bergmann wrote:
> On Wed, Jun 25, 2025, at 13:54, Marek Szyprowski wrote:
>> On 25.06.2025 13:41, Marek Szyprowski wrote:
>>> This change appears in today's linux-next (next-20250625) as commit
>>> fb82645d3f72 ("coredump: reduce stack usage in vfs_coredump()"). In my
>>> tests I found that it causes a kernel oops on some of my ARM 32bit
>>> Exynos based boards. This is really strange, because I don't see any
>>> obvious problem in this patch. Reverting $subject on top of linux-next
>>> hides/fixes the oops. I suspect some kind of use-after-free issue, but
>>> I cannot point anything related. Here is the kernel log from one of
>>> the affected boards (I've intentionally kept the register and stack
>>> dumps):
>> I've just checked once again and found the source of the issue.
>> vfs_coredump() calls coredump_cleanup(), which calls coredump_finish(),
>> which performs the following dereference:
>>
>> next = current->signal->core_state->dumper.next
>>
>> of the core_state assigned in zap_threads() called from coredump_wait().
>> It looks that core_state cannot be moved into coredump_wait() without
>> refactoring/cleaning this first.


IBM CI has also reported the similar crash, while running ./check 
tests/generic/228 from xfstests. This issue is observed on both xfs and 
ext4.


Traces:


[28956.438544] run fstests generic/228 at 2025-06-26 01:02:28
[28956.806452] coredump: 4746(sysctl): Unsafe core_pattern used with 
fs.suid_dumpable=2: pipe handler or fully qualified core dump path 
required. Set kernel.core_pattern before fs.suid_dumpable.
[28956.809279] BUG: Unable to handle kernel data access at 
0x3437342e65727d2f
[28956.809287] Faulting instruction address: 0xc0000000010fe718
[28956.809292] Oops: Kernel access of bad area, sig: 11 [#1]
[28956.809297] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=8192 NUMA pSeries
[28956.809303] Modules linked in: loop nft_fib_inet nft_fib_ipv4 
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
nft_reject nft_ct nft_chain_nat nf_nat bonding nf_conntrack 
nf_defrag_ipv6 tls nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink 
pseries_rng vmx_crypto xfs sr_mod cdrom sd_mod sg ibmvscsi ibmveth 
scsi_transport_srp fuse
[28956.809347] CPU: 25 UID: 0 PID: 4748 Comm: xfs_io Kdump: loaded Not 
tainted 6.16.0-rc3-next-20250625 #1 VOLUNTARY
[28956.809355] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[28956.809360] NIP:  c0000000010fe718 LR: c0000000001d0d20 CTR: 
0000000000000000
[28956.809365] REGS: c00000009a80f720 TRAP: 0380   Not tainted 
(6.16.0-rc3-next-20250625)
[28956.809370] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 88008844  XER: 20040000
[28956.809385] CFAR: c0000000001d0d1c IRQMASK: 1
[28956.809385] GPR00: c0000000001d0d20 c00000009a80f9c0 c000000001648100 
3437342e65727d2f
[28956.809385] GPR04: 0000000000000003 0000000000000000 0000000000000000 
fffffffffffe0000
[28956.809385] GPR08: c0000000c97baa00 0000000000000033 c0000000b9039000 
0000000000008000
[28956.809385] GPR12: c0000000001dd158 c000000017f91300 0000000000000000 
0000000000000000
[28956.809385] GPR16: 0000000000000000 0000000000000018 c0000000b9039000 
c0000000b9039d60
[28956.809385] GPR20: c0000000b9039080 c0000000b9039d48 0000000000040100 
0000000000000001
[28956.809385] GPR24: 0000000008430000 c00000009a80fd30 c0000000c97baa00 
c000000002baf820
[28956.809385] GPR28: 3437342e65727d2f 0000000000000000 0000000000000003 
0000000000000000
[28956.809444] NIP [c0000000010fe718] _raw_spin_lock_irqsave+0x34/0xb0
[28956.809452] LR [c0000000001d0d20] try_to_wake_up+0x6c/0x828
[28956.809459] Call Trace:
[28956.809462] [c00000009a80f9c0] [c00000009a80fa10] 0xc00000009a80fa10 
(unreliable)
[28956.809469] [c00000009a80f9f0] [0000000000000000] 0x0
[28956.809474] [c00000009a80fa80] [c0000000006f1958] 
vfs_coredump+0x254/0x5c8
[28956.809481] [c00000009a80fbf0] [c00000000018cf3c] get_signal+0x454/0xb64
[28956.809488] [c00000009a80fcf0] [c00000000002188c] do_signal+0x7c/0x324
[28956.809496] [c00000009a80fd90] [c000000000022a00] 
do_notify_resume+0xb0/0x13c
[28956.809502] [c00000009a80fdc0] [c000000000032508] 
interrupt_exit_user_prepare_main+0x1ac/0x264
[28956.809510] [c00000009a80fe20] [c000000000032710] 
syscall_exit_prepare+0x150/0x178
[28956.809516] [c00000009a80fe50] [c00000000000d068] 
system_call_vectored_common+0x168/0x2ec
[28956.809525] ---- interrupt: 3000 at 0x7fff82b24bf4
[28956.809529] NIP:  00007fff82b24bf4 LR: 00007fff82b24bf4 CTR: 
0000000000000000
[28956.809534] REGS: c00000009a80fe80 TRAP: 3000   Not tainted 
(6.16.0-rc3-next-20250625)
[28956.809538] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48004802  XER: 00000000
[28956.809554] IRQMASK: 0
[28956.809554] GPR00: 0000000000000135 00007ffffe2ecf50 00007fff82c37200 
ffffffffffffffe5
[28956.809554] GPR04: 0000000000000000 0000000000000000 0000000006500000 
00007fff82e3e120
[28956.809554] GPR08: 00007fff82e369e8 0000000000000000 0000000000000000 
0000000000000000
[28956.809554] GPR12: 0000000000000000 00007fff82e3e120 0000000000000000 
0000000000000000
[28956.809554] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[28956.809554] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000001
[28956.809554] GPR24: 0000010009812f10 0000000000000000 0000000000000001 
0000000123099fe8
[28956.809554] GPR28: 0000000000000000 0000000000000003 0000000000000000 
0000000006500000
[28956.809610] NIP [00007fff82b24bf4] 0x7fff82b24bf4
[28956.809614] LR [00007fff82b24bf4] 0x7fff82b24bf4
[28956.809618] ---- interrupt: 3000
[28956.809621] Code: 38429a1c 7c0802a6 60000000 fbe1fff8 f821ffd1 
8bed0932 63e90001 992d0932 a12d0008 3ce0fffe 5529083c 61290001 
<7d001829> 7d063879 40c20018 7d063838
[28956.809641] ---[ end trace 0000000000000000 ]---
[28956.812734] pstore: backend (nvram) writing error (-1)


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

> Thanks for the analysis, I agree that this can't work and my patch
> just needs to be dropped. The 'noinline_for_stack' change on
> its own is probably sufficient to avoid the warning, and I can
> respin a new version after more build testing.
>
>       Arnd
>

