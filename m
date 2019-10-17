Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7EAFDB250
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393276AbfJQQ1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 12:27:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392968AbfJQQ1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:27:50 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9HGKevP077690;
        Thu, 17 Oct 2019 12:27:47 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vpsagq9gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 12:27:47 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9HGPmxt023889;
        Thu, 17 Oct 2019 16:27:46 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 2vk6f834gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 16:27:46 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9HGRjQX36635000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 16:27:45 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44F3FAE062;
        Thu, 17 Oct 2019 16:27:45 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41675AE05C;
        Thu, 17 Oct 2019 16:27:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Oct 2019 16:27:45 +0000 (GMT)
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: A bug in fuse/cuse causing crashes
Message-ID: <3cad83ae-7e47-75d9-8288-000ed0be6372@linux.ibm.com>
Date:   Thu, 17 Oct 2019 12:27:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=952 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170146
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!


   I found the following bug in recent kernels 
(https://bugzilla.redhat.com/show_bug.cgi?id=1762795). I tested with 
5.3.0 as the most recent version and it crashes there as well.


[   78.781357] fuse: init (API version 7.31)
[   78.904882] BUG: unable to handle page fault for address: 
0000000000370700
[   78.904936] #PF: supervisor write access in kernel mode
[   78.904966] #PF: error_code(0x0002) - not-present page
[   78.904995] PGD 0 P4D 0
[   78.905015] Oops: 0002 [#1] SMP PTI
[   78.905038] CPU: 12 PID: 2996 Comm: swtpm_ioctl Tainted: G          
I       5.3.5-200.fc30.x86_64 #1
[   78.905087] Hardware name: IBM BladeCenter HS22 -[7870AC1]-/59Y5682, 
BIOS -[P9E165BUS-1.29]- 06/07/2018
[   78.905146] RIP: 0010:queued_spin_lock_slowpath+0x13e/0x1d0
[   78.905179] Code: 02 89 c6 c1 e6 10 0f 84 93 00 00 00 c1 ee 12 83 e0 
03 83 ee 01 48 c1 e0 04 48 63 f6 48 05 40 91 02 00 48 03 04 f5 00 79 20 
b9 <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 02
[   78.905276] RSP: 0018:ffff9b68821ffd98 EFLAGS: 00010206
[   78.905307] RAX: 0000000000370700 RBX: ffff8c42909db980 RCX: 
0000000000340000
[   78.905344] RDX: ffff8c4297b29140 RSI: 00000000000023fe RDI: 
ffff8c4288d02ca8
[   78.905383] RBP: ffff8c42553490d8 R08: 0000000000340000 R09: 
0000000000000000
[   78.905422] R10: ffff8c4288d029b0 R11: ffff8c4254a5b210 R12: 
0000000000000012
[   78.905460] R13: 0000000000008002 R14: ffff8c4279f07010 R15: 
ffff8c42553491b8
[   78.905500] FS:  0000000000000000(0000) GS:ffff8c4297b00000(0000) 
knlGS:0000000000000000
[   78.905543] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.905548] CR2: 0000000000370700 CR3: 00000007fb40a000 CR4: 
00000000000006e0
[   78.905548] Call Trace:
[   78.905548]  fuse_prepare_release+0x42/0x100 [fuse]
[   78.905548]  fuse_sync_release+0x2e/0x50 [fuse]
[   78.905548]  cuse_release+0x1b/0x30 [cuse]
[   78.905548]  __fput+0xc1/0x250
[   78.905548]  task_work_run+0x87/0xa0
[   78.905548]  do_exit+0x2e9/0xb80
[   78.905548]  ? do_user_addr_fault+0x1e4/0x440
[   78.905548]  do_group_exit+0x3a/0xa0
[   78.905548]  __x64_sys_exit_group+0x14/0x20
[   78.905548]  do_syscall_64+0x5f/0x1a0
[   78.905548]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   78.905548] RIP: 0033:0x7f9f944f7e86
[   78.905548] Code: Bad RIP value.
[   78.905548] RSP: 002b:00007ffc0e42a5f8 EFLAGS: 00000246 ORIG_RAX: 
00000000000000e7
[   78.905548] RAX: ffffffffffffffda RBX: 00007f9f945eb740 RCX: 
00007f9f944f7e86
[   78.905548] RDX: 0000000000000000 RSI: 000000000000003c RDI: 
0000000000000000
[   78.905548] RBP: 0000000000000000 R08: 00000000000000e7 R09: 
ffffffffffffff80
[   78.905548] R10: 0000000000000002 R11: 0000000000000246 R12: 
00007f9f945eb740
[   78.905548] R13: 0000000000000001 R14: 00007f9f945f4408 R15: 
0000000000000000
[   78.905548] Modules linked in: cuse fuse tpm_vtpm_proxy xt_CHECKSUM 
xt_MASQUERADE tun bridge stp llc ip6t_rpfilter ip6t_REJECT 
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat 
ebtable_broute ip6table_nat ip6table_mangle ip6table_raw 
ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw 
iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set 
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables 
iptable_filter ip_tables sunrpc vfat fat cdc_ether usbnet mii 
intel_powerclamp ipmi_ssif joydev coretemp iTCO_wdt kvm_intel ioatdma 
iTCO_vendor_support gpio_ich kvm i5500_temp acpi_cpufreq dca irqbypass 
ipmi_si ipmi_devintf ipmi_msghandler intel_cstate i2c_i801 intel_uncore 
lpc_ich i7core_edac xfs libcrc32c mgag200 i2c_algo_bit drm_vram_helper 
ttm drm_kms_helper drm crc32c_intel mptsas scsi_transport_sas mptscsih 
bnx2 mptbase
[   78.905548] CR2: 0000000000370700
[   78.905548] ---[ end trace e5332d54bb0c7d48 ]---
[   78.905548] RIP: 0010:queued_spin_lock_slowpath+0x13e/0x1d0
[   78.905548] Code: 02 89 c6 c1 e6 10 0f 84 93 00 00 00 c1 ee 12 83 e0 
03 83 ee 01 48 c1 e0 04 48 63 f6 48 05 40 91 02 00 48 03 04 f5 00 79 20 
b9 <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 02
[   78.916751] general protection fault: 0000 [#2] SMP PTI
[   78.905548] RSP: 0018:ffff9b68821ffd98 EFLAGS: 00010206
[   78.918905] CPU: 2 PID: 2993 Comm: swtpm_ioctl Tainted: G D   I       
5.3.5-200.fc30.x86_64 #1
[   78.905548] RAX: 0000000000370700 RBX: ffff8c42909db980 RCX: 
0000000000340000
[   78.921473] Hardware name: IBM BladeCenter HS22 -[7870AC1]-/59Y5682, 
BIOS -[P9E165BUS-1.29]- 06/07/2018
[   78.924802] RDX: ffff8c4297b29140 RSI: 00000000000023fe RDI: 
ffff8c4288d02ca8
[   78.921473] RIP: 0010:queued_spin_lock_slowpath+0x13e/0x1d0
[   78.927565] RBP: ffff8c42553490d8 R08: 0000000000340000 R09: 
0000000000000000
[   78.921473] Code: 02 89 c6 c1 e6 10 0f 84 93 00 00 00 c1 ee 12 83 e0 
03 83 ee 01 48 c1 e0 04 48 63 f6 48 05 40 91 02 00 48 03 04 f5 00 79 20 
b9 <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 02
[   78.930575] R10: ffff8c4288d029b0 R11: ffff8c4254a5b210 R12: 
0000000000000012
[   78.921473] RSP: 0018:ffff9b6881a27d98 EFLAGS: 00010286
[   78.930575] R13: 0000000000008002 R14: ffff8c4279f07010 R15: 
ffff8c42553491b8
[   78.921473] RAX: ff4df4f2ff5085f9 RBX: ffff8c4263562300 RCX: 
00000000000c0000
[   78.930575] FS:  0000000000000000(0000) GS:ffff8c4297b00000(0000) 
knlGS:0000000000000000
[   78.921473] RDX: ffff8c42978a9140 RSI: 00000000000021b5 RDI: 
ffff8c4288d034e8
[   78.930575] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.921473] RBP: ffff8c428ad4e648 R08: 00000000000c0000 R09: 
0000000000000000
[   78.921473] R10: ffff8c4288d031f0 R11: ffff8c4255f86a10 R12: 
0000000000000012
[   78.930575] CR2: 00007f9f944f7e5c CR3: 00000007fb40a000 CR4: 
00000000000006e0
[   78.921473] R13: 0000000000008002 R14: ffff8c428e8f4810 R15: 
ffff8c428ad4e728
[   78.921473] FS:  0000000000000000(0000) GS:ffff8c4297880000(0000) 
knlGS:0000000000000000
[   78.930575] Fixing recursive fault but reboot is needed!


Regards,

Stefan

