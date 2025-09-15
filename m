Return-Path: <linux-fsdevel+bounces-61420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB66B57ECF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12B9485E00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CA531D730;
	Mon, 15 Sep 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AEBLF7Ec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB53313286;
	Mon, 15 Sep 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946133; cv=none; b=QEEcxIXd7+QWJceUq2evcwPTaffEZ7bVH+Xcp3B7H+RvlZcIdmF1F6DyRYPZ3W4eqbl/dkLjv6ATAyG6M7ESQi/G5r6nZDAJHFlGHwtG1Pq7K5IZBlOAaaxFpIbHKDtVxnmTi85KnoyWU9zLdWuDpEb09WC/EG24o0vVfQEuVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946133; c=relaxed/simple;
	bh=8e2rwF9xa32s2A/IPmhcfKf2E3H7CcXsXou+j46YMcY=;
	h=Content-Type:Mime-Version:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:Subject; b=a4hxvAdE+edn6KxCxkEVKtqOTFptmHjKXJwsqyR3y6SoEcu0f2dqpxEpPQjM5VDtE8Nma7gnRCwj6aNijCO20CMkkLYcrjLsWACaIzqpN4u0ltsuFEXRdKN4yFabH3EQl7DrAUiDYWR4OE1h+hk0oFHj5s5jshaKAJst9TYF5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AEBLF7Ec; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9FKmK005541;
	Mon, 15 Sep 2025 14:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eK3Voq
	lsnUKtSGWfPlBsEurRbj4QmPWoLz0vCh4mEDo=; b=AEBLF7EcuW5kdBCrIi8G0i
	iHP0EnisAfJr6appzb2DnUdFrSCl0ZunNG6zH9YWQ8dkO7o4UNuzqNksfAeUw9Ex
	qw4CYpe3C7QT/2vkDHjZhJylvZUEZbMAvgO8vbVScsFRoHGXKNbbiWSuDeWh83de
	z4g/RZgGkTBUMc5BnPpO/lmprEGjsvCwQHgq0+BT54X2cLmnn+uIscxrWdbW7UWL
	lLvh3tBFbKySzGw13SnDpYW0AUhauvDEbm3uU9XPvrQPdNsoBJMcvR+bYNtE75Ag
	c+8GapGQpuxC0r9VV6RAfYGRoOtLb4XgO4STG4viqK1jBk4GfJ7gWIoRNC5esGOA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49509y37wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 14:19:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FDnG8n010238;
	Mon, 15 Sep 2025 14:19:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49509y37w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 14:19:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCNdJt018649;
	Mon, 15 Sep 2025 14:19:48 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5m6mvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 14:19:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FEJlxX24445690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 14:19:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16C9158053;
	Mon, 15 Sep 2025 14:19:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D94358043;
	Mon, 15 Sep 2025 14:19:40 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.248.92])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Sep 2025 14:19:40 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <CAHSKhteHC26yXVFtjgdanfM7+vsOVZ+HHWnBYD01A4eiRHibVQ@mail.gmail.com>
Date: Mon, 15 Sep 2025 19:49:26 +0530
Cc: tj@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org,
        songmuchun@bytedance.com, shakeelb@google.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mhocko@suse.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, riteshh@linux.ibm.com,
        ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-mm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <240A7968-D530-4135-856A-CE90D269D5E6@linux.ibm.com>
References: <8957c526-d05c-4c0d-bfed-0eb6e6d2476c@linux.ibm.com>
 <BAEAC2F7-7D7F-49E4-AB21-10FC0E4BF5F3@linux.ibm.com>
 <CAHSKhteHC26yXVFtjgdanfM7+vsOVZ+HHWnBYD01A4eiRHibVQ@mail.gmail.com>
To: Julian Sun <sunjunchao@bytedance.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMCBTYWx0ZWRfX8nEnGFnQGO2S
 2KvQy+oBrLtydGF+g+uGAZMDEV7p9/S75CXh3roA4PabnqUNQ7TQDHWzTQ4HA/r3XFE4w17OUKS
 VkYlk06K//l46EkCntzwPC46F9WRApv8/dI2s3N2IYDAH0/qm4+y4mRUn77y4/tjrRcJ2scHpxd
 Wl8EO+jKADRVtgCpQ4uKtLVI09YVe77li8SI/fG7ayx1ACAXiWj8G+fITlfQdDTaWl6crIk0po9
 L6x/dU1p1w/6BHK3zbGzFbZTjstmaofS92nTy6VhMwrHqudh2gpUJJTX7g5NuO1G5tMeU/8sRes
 Yd9NUL4gtiSIwkd575P6+EgEOYlmDW2FM0fhZI2Vg32oEx1TN6k2yX9BWueuORyze4qu+tQCLG1
 8injHZYK
X-Authority-Analysis: v=2.4 cv=OPYn3TaB c=1 sm=1 tr=0 ts=68c82086 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=968KyxNXAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8 a=1XWaLZrsAAAA:8
 a=Z4Rwk6OoAAAA:8 a=grZxPVYt9K8c2I_ib-wA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=ZmIg1sZ3JBWsdXgziEIF:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: Wbi9MPnK_uTy7jSOkCyhn5OOwjM9tdHc
X-Proofpoint-ORIG-GUID: MuE6Rqsyr0-KhcOO75JQMGQVC9JNv0NO
Subject: Re:  [linux-next20250911]Kernel OOPs while running generic/256 on
 Pmem device
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130020



> On 13 Sep 2025, at 8:18=E2=80=AFAM, Julian Sun =
<sunjunchao@bytedance.com> wrote:
>=20
> Hi,
>=20
> Does this fix make sense to you?
>=20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d0dfaa0ccaba..ed24dcece56a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3945,9 +3945,10 @@ static void mem_cgroup_css_free(struct
> cgroup_subsys_state *css)
>                 * Not necessary to wait for wb completion which might
> cause task hung,
>                 * only used to free resources. See
> memcg_cgwb_waitq_callback_fn().
>                 */
> -               __add_wait_queue_entry_tail(wait->done.waitq, =
&wait->wq_entry);
>                if (atomic_dec_and_test(&wait->done.cnt))
> -                       wake_up_all(wait->done.waitq);
> +                       kfree(wait);
> +               else
> +                       __add_wait_queue_entry_tail(wait->done.waitq,
> &wait->wq_entry);;
>        }
> #endif
>        if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && =
!cgroup_memory_nosocket)

Hello,

Thanks for the fix. This is fixing the reported issue.

While sending out the patch please add below tag as well.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.
>=20
> On Fri, Sep 12, 2025 at 8:33=E2=80=AFPM Venkat =
<venkat88@linux.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 12 Sep 2025, at 10:51=E2=80=AFAM, Venkat Rao Bagalkote =
<venkat88@linux.ibm.com> wrote:
>>>=20
>>> Greetings!!!
>>>=20
>>>=20
>>> IBM CI has reported a kernel crash, while running generic/256 test =
case on pmem device from xfstests suite on linux-next20250911 kernel.
>>>=20
>>>=20
>>> xfstests: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>>>=20
>>> local.config:
>>>=20
>>> [xfs_dax]
>>> export RECREATE_TEST_DEV=3Dtrue
>>> export TEST_DEV=3D/dev/pmem0
>>> export TEST_DIR=3D/mnt/test_pmem
>>> export SCRATCH_DEV=3D/dev/pmem0.1
>>> export SCRATCH_MNT=3D/mnt/scratch_pmem
>>> export MKFS_OPTIONS=3D"-m reflink=3D0 -b size=3D65536 -s size=3D512"
>>> export FSTYP=3Dxfs
>>> export MOUNT_OPTIONS=3D"-o dax"
>>>=20
>>>=20
>>> Test case: generic/256
>>>=20
>>>=20
>>> Traces:
>>>=20
>>>=20
>>> [  163.371929] ------------[ cut here ]------------
>>> [  163.371936] kernel BUG at lib/list_debug.c:29!
>>> [  163.371946] Oops: Exception in kernel mode, sig: 5 [#1]
>>> [  163.371954] LE PAGE_SIZE=3D64K MMU=3DRadix  SMP NR_CPUS=3D8192 =
NUMA pSeries
>>> [  163.371965] Modules linked in: xfs nft_fib_inet nft_fib_ipv4 =
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 =
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack bonding tls =
nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink sunrpc =
pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2 nd_pmem =
papr_scm sd_mod libnvdimm sg ibmvscsi ibmveth scsi_transport_srp =
pseries_wdt
>>> [  163.372127] CPU: 22 UID: 0 PID: 130 Comm: kworker/22:0 Kdump: =
loaded Not tainted 6.17.0-rc5-next-20250911 #1 VOLUNTARY
>>> [  163.372142] Hardware name: IBM,9080-HEX Power11 (architected) =
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>>> [  163.372155] Workqueue: cgroup_free css_free_rwork_fn
>>> [  163.372169] NIP:  c000000000d051d4 LR: c000000000d051d0 CTR: =
0000000000000000
>>> [  163.372176] REGS: c00000000ba079b0 TRAP: 0700   Not tainted =
(6.17.0-rc5-next-20250911)
>>> [  163.372183] MSR:  800000000282b033 =
<SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28000000  XER: 00000006
>>> [  163.372214] CFAR: c0000000002bae9c IRQMASK: 0
>>> [  163.372214] GPR00: c000000000d051d0 c00000000ba07c50 =
c00000000230a600 0000000000000075
>>> [  163.372214] GPR04: 0000000000000004 0000000000000001 =
c000000000507e2c 0000000000000001
>>> [  163.372214] GPR08: c000000d0cb87d13 0000000000000000 =
0000000000000000 a80e000000000000
>>> [  163.372214] GPR12: c00e0001a1970fa2 c000000d0ddec700 =
c000000000208e58 c000000107b5e190
>>> [  163.372214] GPR16: c00000000d3e5d08 c00000000b71cf78 =
c00000000d3e5d05 c00000000b71cf30
>>> [  163.372214] GPR20: c00000000b71cf08 c00000000b71cf10 =
c000000019f58588 c000000004704bc8
>>> [  163.372214] GPR24: c000000107b5e100 c000000004704bd0 =
0000000000000003 c000000004704bd0
>>> [  163.372214] GPR28: c000000004704bc8 c000000019f585a8 =
c000000019f53da8 c000000004704bc8
>>> [  163.372315] NIP [c000000000d051d4] =
__list_add_valid_or_report+0x124/0x188
>>> [  163.372326] LR [c000000000d051d0] =
__list_add_valid_or_report+0x120/0x188
>>> [  163.372335] Call Trace:
>>> [  163.372339] [c00000000ba07c50] [c000000000d051d0] =
__list_add_valid_or_report+0x120/0x188 (unreliable)
>>> [  163.372352] [c00000000ba07ce0] [c000000000834280] =
mem_cgroup_css_free+0xa0/0x27c
>>> [  163.372363] [c00000000ba07d50] [c0000000003ba198] =
css_free_rwork_fn+0xd0/0x59c
>>> [  163.372374] [c00000000ba07da0] [c0000000001f5d60] =
process_one_work+0x41c/0x89c
>>> [  163.372385] [c00000000ba07eb0] [c0000000001f76c0] =
worker_thread+0x558/0x848
>>> [  163.372394] [c00000000ba07f80] [c000000000209038] =
kthread+0x1e8/0x230
>>> [  163.372406] [c00000000ba07fe0] [c00000000000ded8] =
start_kernel_thread+0x14/0x18
>>> [  163.372416] Code: 4b9b1099 60000000 7f63db78 4bae8245 60000000 =
e8bf0008 3c62ff88 7fe6fb78 7fc4f378 38637d40 4b5b5c89 60000000 =
<0fe00000> 60000000 60000000 7f83e378
>>> [  163.372453] ---[ end trace 0000000000000000 ]---
>>> [  163.380581] pstore: backend (nvram) writing error (-1)
>>> [  163.380593]
>>>=20
>>>=20
>>> If you happen to fix this issue, please add below tag.
>>>=20
>>>=20
>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>=20
>>>=20
>>>=20
>>> Regards,
>>>=20
>>> Venkat.
>>>=20
>>>=20
>>=20
>> After reverting the below commit, issue is not seen.
>>=20
>> commit 61bbf51e75df1a94cf6736e311cb96aeb79826a8
>> Author: Julian Sun <sunjunchao@bytedance.com>
>> Date:   Thu Aug 28 04:45:57 2025 +0800
>>=20
>>    memcg: don't wait writeback completion when release memcg
>>         Recently, we encountered the following hung task:
>>         INFO: task kworker/4:1:1334558 blocked for more than 1720 =
seconds.
>>    [Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy =
css_free_rwork_fn
>>    [Wed Jul 30 17:47:45 2025] Call Trace:
>>    [Wed Jul 30 17:47:45 2025]  __schedule+0x934/0xe10
>>    [Wed Jul 30 17:47:45 2025]  ? complete+0x3b/0x50
>>    [Wed Jul 30 17:47:45 2025]  ? _cond_resched+0x15/0x30
>>    [Wed Jul 30 17:47:45 2025]  schedule+0x40/0xb0
>>    [Wed Jul 30 17:47:45 2025]  wb_wait_for_completion+0x52/0x80
>>    [Wed Jul 30 17:47:45 2025]  ? finish_wait+0x80/0x80
>>    [Wed Jul 30 17:47:45 2025]  mem_cgroup_css_free+0x22/0x1b0
>>    [Wed Jul 30 17:47:45 2025]  css_free_rwork_fn+0x42/0x380
>>    [Wed Jul 30 17:47:45 2025]  process_one_work+0x1a2/0x360
>>    [Wed Jul 30 17:47:45 2025]  worker_thread+0x30/0x390
>>    [Wed Jul 30 17:47:45 2025]  ? create_worker+0x1a0/0x1a0
>>    [Wed Jul 30 17:47:45 2025]  kthread+0x110/0x130
>>    [Wed Jul 30 17:47:45 2025]  ? __kthread_cancel_work+0x40/0x40
>>    [Wed Jul 30 17:47:45 2025]  ret_from_fork+0x1f/0x30
>>         The direct cause is that memcg spends a long time waiting for =
dirty page
>>    writeback of foreign memcgs during release.
>>         The root causes are:
>>        a. The wb may have multiple writeback tasks, containing =
millions
>>           of dirty pages, as shown below:
>>>>> for work in list_for_each_entry("struct wb_writeback_work", \
>>                                        wb.work_list.address_of_(), =
"list"):
>>    ...     print(work.nr_pages, work.reason, hex(work))
>>    ...
>>    900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
>>    1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
>>    1275228 WB_REASON_FOREIGN_FLUSH 0xffff969d9b444bc0
>>    1099673 WB_REASON_FOREIGN_FLUSH 0xffff969f0954d6c0
>>    1351522 WB_REASON_FOREIGN_FLUSH 0xffff969e76713340
>>    2567437 WB_REASON_FOREIGN_FLUSH 0xffff9694ae208400
>>    2954033 WB_REASON_FOREIGN_FLUSH 0xffff96a22d62cbc0
>>    3008860 WB_REASON_FOREIGN_FLUSH 0xffff969eee8ce3c0
>>    3337932 WB_REASON_FOREIGN_FLUSH 0xffff9695b45156c0
>>    3348916 WB_REASON_FOREIGN_FLUSH 0xffff96a22c7a4f40
>>    3345363 WB_REASON_FOREIGN_FLUSH 0xffff969e5d872800
>>    3333581 WB_REASON_FOREIGN_FLUSH 0xffff969efd0f4600
>>    3382225 WB_REASON_FOREIGN_FLUSH 0xffff969e770edcc0
>>    3418770 WB_REASON_FOREIGN_FLUSH 0xffff96a252ceea40
>>    3387648 WB_REASON_FOREIGN_FLUSH 0xffff96a3bda86340
>>    3385420 WB_REASON_FOREIGN_FLUSH 0xffff969efc6eb280
>>    3418730 WB_REASON_FOREIGN_FLUSH 0xffff96a348ab1040
>>    3426155 WB_REASON_FOREIGN_FLUSH 0xffff969d90beac00
>>    3397995 WB_REASON_FOREIGN_FLUSH 0xffff96a2d7288800
>>    3293095 WB_REASON_FOREIGN_FLUSH 0xffff969dab423240
>>    3293595 WB_REASON_FOREIGN_FLUSH 0xffff969c765ff400
>>    3199511 WB_REASON_FOREIGN_FLUSH 0xffff969a72d5e680
>>    3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
>>    3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00
>>             b. The writeback might severely throttled by wbt, with a =
speed
>>           possibly less than 100kb/s, leading to a very long =
writeback time.
>>>>> wb.write_bandwidth
>>    (unsigned long)24
>>>>> wb.write_bandwidth
>>    (unsigned long)13
>>         The wb_wait_for_completion() here is probably only used to =
prevent
>>    use-after-free.  Therefore, we manage 'done' separately and =
automatically
>>    free it.
>>         This allows us to remove wb_wait_for_completion() while =
preventing the
>>    use-after-free issue.
>>     com
>>    Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty =
flushing")
>>    Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>>    Acked-by: Tejun Heo <tj@kernel.org>
>>    Cc: Michal Hocko <mhocko@suse.com>
>>    Cc: Roman Gushchin <roman.gushchin@linux.dev>
>>    Cc: Johannes Weiner <hannes@cmpxchg.org>
>>    Cc: Shakeel Butt <shakeelb@google.com>
>>    Cc: Muchun Song <songmuchun@bytedance.com>
>>    Cc: <stable@vger.kernel.org>
>>    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>=20
>> Regards,
>> Venkat.
>>=20
>>>=20
>>=20
>=20
>=20
> --=20
> Julian Sun <sunjunchao@bytedance.com>


