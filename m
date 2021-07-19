Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5C3CE813
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352114AbhGSQhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 12:37:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352538AbhGSQdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:33:23 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JHAGZS001041
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 10:14:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=FFXXpPy+b2KsSMD00iCifAXCcNS5nJJ6e2fpWpLQVYk=;
 b=gxgmAPN4Ndo/A1Sfe9KbkAkOlAcU28ZW2lnlTIIMBWatL5/ugbxayN9sFio/F5aCKvGj
 IQzdX0TtTN/qiC3zGpdRZtm3OVOm8GkmmlDc5Iodhnm7zgLKdyk7zybX8F2DRK1OUrBl
 Vf25OAoVBnqCl5IkHFotz/9WEura7jiG/io= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39vytc459p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 10:14:02 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 10:14:00 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 780349993B80; Mon, 19 Jul 2021 10:13:51 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        Roman Gushchin <guro@fb.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] writeback, cgroup: do not reparent dax inodes
Date:   Mon, 19 Jul 2021 10:13:50 -0700
Message-ID: <20210719171350.3876830-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: n82ssd9LtPDcK6BY_RsrOQPNtarvmLck
X-Proofpoint-ORIG-GUID: n82ssd9LtPDcK6BY_RsrOQPNtarvmLck
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_09:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015 mlxlogscore=905
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode switching code is not suited for dax inodes. An attempt
to switch a dax inode to a parent writeback structure (as a part
of a writeback cleanup procedure) results in a panic like this:

  [  987.071651] run fstests generic/270 at 2021-07-15 05:54:02
  [  988.704940] XFS (pmem0p2): EXPERIMENTAL big timestamp feature in
  use.  Use at your own risk!
  [  988.746847] XFS (pmem0p2): DAX enabled. Warning: EXPERIMENTAL, use
  at your own risk
  [  988.786070] XFS (pmem0p2): EXPERIMENTAL inode btree counters
  feature in use. Use at your own risk!
  [  988.828639] XFS (pmem0p2): Mounting V5 Filesystem
  [  988.854019] XFS (pmem0p2): Ending clean mount
  [  988.874550] XFS (pmem0p2): Quotacheck needed: Please wait.
  [  988.900618] XFS (pmem0p2): Quotacheck: Done.
  [  989.090783] XFS (pmem0p2): xlog_verify_grant_tail: space > BBTOB(tai=
l_blocks)
  [  989.092751] XFS (pmem0p2): xlog_verify_grant_tail: space > BBTOB(tai=
l_blocks)
  [  989.092962] XFS (pmem0p2): xlog_verify_grant_tail: space > BBTOB(tai=
l_blocks)
  [ 1010.105586] BUG: unable to handle page fault for address: 0000000005=
b0f669
  [ 1010.141817] #PF: supervisor read access in kernel mode
  [ 1010.167824] #PF: error_code(0x0000) - not-present page
  [ 1010.191499] PGD 0 P4D 0
  [ 1010.203346] Oops: 0000 [#1] SMP PTI
  [ 1010.219596] CPU: 13 PID: 10479 Comm: kworker/13:16 Not tainted
  5.14.0-rc1-master-8096acd7442e+ #8
  [ 1010.260441] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
  Gen9, BIOS P89 09/13/2016
  [ 1010.297792] Workqueue: inode_switch_wbs inode_switch_wbs_work_fn
  [ 1010.324832] RIP: 0010:inode_do_switch_wbs+0xaf/0x470
  [ 1010.347261] Code: 00 30 0f 85 c1 03 00 00 0f 1f 44 00 00 31 d2 48
  c7 c6 ff ff ff ff 48 8d 7c 24 08 e8 eb 49 1a 00 48 85 c0 74 4a bb ff
  ff ff ff <48> 8b 50 08 48 8d 4a ff 83 e2 01 48 0f 45 c1 48 8b 00 a8 08
  0f 85
  [ 1010.434307] RSP: 0018:ffff9c66691abdc8 EFLAGS: 00010002
  [ 1010.457795] RAX: 0000000005b0f661 RBX: 00000000ffffffff RCX: ffff89e=
6a21382b0
  [ 1010.489922] RDX: 0000000000000001 RSI: ffff89e350230248 RDI: fffffff=
fffffffff
  [ 1010.522085] RBP: ffff89e681d19400 R08: 0000000000000000 R09: 0000000=
000000228
  [ 1010.554234] R10: ffffffffffffffff R11: ffffffffffffffc0 R12: ffff89e=
6a2138130
  [ 1010.586414] R13: ffff89e316af7400 R14: ffff89e316af6e78 R15: ffff89e=
6a21382b0
  [ 1010.619394] FS:  0000000000000000(0000) GS:ffff89ee5fb40000(0000)
  knlGS:0000000000000000
  [ 1010.658874] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 1010.688085] CR2: 0000000005b0f669 CR3: 0000000cb2410004 CR4: 0000000=
0001706e0
  [ 1010.722129] Call Trace:
  [ 1010.733132]  inode_switch_wbs_work_fn+0xb6/0x2a0
  [ 1010.754121]  process_one_work+0x1e6/0x380
  [ 1010.772512]  worker_thread+0x53/0x3d0
  [ 1010.789221]  ? process_one_work+0x380/0x380
  [ 1010.807964]  kthread+0x10f/0x130
  [ 1010.822043]  ? set_kthread_struct+0x40/0x40
  [ 1010.840818]  ret_from_fork+0x22/0x30
  [ 1010.856851] Modules linked in: xt_CHECKSUM xt_MASQUERADE
  xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat
  nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables
  nfnetlink bridge stp llc rfkill sunrpc intel_rapl_msr
  intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
  coretemp kvm_intel ipmi_ssif kvm mgag200 i2c_algo_bit iTCO_wdt
  irqbypass drm_kms_helper iTCO_vendor_support acpi_ipmi rapl
  syscopyarea sysfillrect intel_cstate ipmi_si sysimgblt ioatdma
  dax_pmem_compat fb_sys_fops ipmi_devintf device_dax i2c_i801 pcspkr
  intel_uncore hpilo nd_pmem cec dax_pmem_core dca i2c_smbus acpi_tad
  lpc_ich ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c sd_mod
  t10_pi crct10dif_pclmul crc32_pclmul crc32c_intel tg3
  ghash_clmulni_intel serio_raw hpsa hpwdt scsi_transport_sas wmi
  dm_mirror dm_region_hash dm_log dm_mod
  [ 1011.200864] CR2: 0000000005b0f669
  [ 1011.215700] ---[ end trace ed2105faff8384f3 ]---
  [ 1011.241727] RIP: 0010:inode_do_switch_wbs+0xaf/0x470
  [ 1011.264306] Code: 00 30 0f 85 c1 03 00 00 0f 1f 44 00 00 31 d2 48
  c7 c6 ff ff ff ff 48 8d 7c 24 08 e8 eb 49 1a 00 48 85 c0 74 4a bb ff
  ff ff ff <48> 8b 50 08 48 8d 4a ff 83 e2 01 48 0f 45 c1 48 8b 00 a8 08
  0f 85
  [ 1011.348821] RSP: 0018:ffff9c66691abdc8 EFLAGS: 00010002
  [ 1011.372734] RAX: 0000000005b0f661 RBX: 00000000ffffffff RCX: ffff89e=
6a21382b0
  [ 1011.405826] RDX: 0000000000000001 RSI: ffff89e350230248 RDI: fffffff=
fffffffff
  [ 1011.437852] RBP: ffff89e681d19400 R08: 0000000000000000 R09: 0000000=
000000228
  [ 1011.469926] R10: ffffffffffffffff R11: ffffffffffffffc0 R12: ffff89e=
6a2138130
  [ 1011.502179] R13: ffff89e316af7400 R14: ffff89e316af6e78 R15: ffff89e=
6a21382b0
  [ 1011.534233] FS:  0000000000000000(0000) GS:ffff89ee5fb40000(0000)
  knlGS:0000000000000000
  [ 1011.571247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 1011.597063] CR2: 0000000005b0f669 CR3: 0000000cb2410004 CR4: 0000000=
0001706e0
  [ 1011.629160] Kernel panic - not syncing: Fatal exception
  [ 1011.653802] Kernel Offset: 0x15200000 from 0xffffffff81000000
  (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
  [ 1011.713723] ---[ end Kernel panic - not syncing: Fatal exception ]--=
-

The crash happens on an attempt to iterate over attached pagecache
pages and check the dirty flag: a dax inode's xarray contains pfn's
instead of generic struct page pointers.

Fix the problem by bailing out (with the false return value) of
inode_prepare_sbs_switch() if a dax inode is passed.

Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching=
 attached inodes")
Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Reported-by: Darrick J. Wong <djwong@kernel.org>
Tested-by: Murphy Zhou <jencce.kernel@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 fs/fs-writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 06d04a74ab6c..4c3370548982 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -521,6 +521,9 @@ static bool inode_prepare_wbs_switch(struct inode *in=
ode,
 	 */
 	smp_mb();
=20
+	if (IS_DAX(inode))
+		return false;
+
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
--=20
2.31.1

