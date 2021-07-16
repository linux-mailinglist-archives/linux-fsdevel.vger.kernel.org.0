Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6FB3CBD88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhGPUNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 16:13:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4494 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbhGPUNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 16:13:40 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GK5XX2000433
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 13:10:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=y7LpQF5Jy+LuLZQk4XIdiU7P3m7mkQN7iFw0B1cps5o=;
 b=EhLfvyK2z5z0RbvrzqIbt5ZpEw4TVA+cnNZwIRFccQFldZqk8TfJ0V0HbwgO+eHV82DP
 mm1PXmwz0C8sVKHRaErH4XumAjeg7vh3O+hBhMbwKEDMx5LaX+Qk7e7ZFZbl2K+9iB3R
 NJuxf03tgHnMhJXIHgtp0KaiFhvq3l+A+MY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39tw3bp9dj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 13:10:45 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 13:10:42 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 3A42F97E3BFB; Fri, 16 Jul 2021 13:10:41 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Boyang Xue <bxue@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH] writeback, cgroup: remove wb from offline list before releasing refcnt
Date:   Fri, 16 Jul 2021 13:10:39 -0700
Message-ID: <20210716201039.3762203-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cc7Xl_FTW3lE2Zc993VreHzvjUGSdc9Z
X-Proofpoint-GUID: cc7Xl_FTW3lE2Zc993VreHzvjUGSdc9Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_09:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 mlxlogscore=665 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107160126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Boyang reported that the commit c22d70a162d3 ("writeback, cgroup:
release dying cgwbs by switching attached inodes") causes the kernel
to crash while running xfstests generic/256 on ext4 on aarch64 and
ppc64le.

  [ 4366.380974] run fstests generic/256 at 2021-07-12 05:41:40
  [ 4368.337078] EXT4-fs (vda3): mounted filesystem with ordered data
  mode. Opts: . Quota mode: none.
  [ 4371.275986] Unable to handle kernel NULL pointer dereference at
  virtual address 0000000000000000
  [ 4371.278210] Mem abort info:
  [ 4371.278880]   ESR =3D 0x96000005
  [ 4371.279603]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  [ 4371.280878]   SET =3D 0, FnV =3D 0
  [ 4371.281621]   EA =3D 0, S1PTW =3D 0
  [ 4371.282396]   FSC =3D 0x05: level 1 translation fault
  [ 4371.283635] Data abort info:
  [ 4371.284333]   ISV =3D 0, ISS =3D 0x00000005
  [ 4371.285246]   CM =3D 0, WnR =3D 0
  [ 4371.285975] user pgtable: 64k pages, 48-bit VAs, pgdp=3D00000000b050=
2000
  [ 4371.287640] [0000000000000000] pgd=3D0000000000000000,
  p4d=3D0000000000000000, pud=3D0000000000000000
  [ 4371.290016] Internal error: Oops: 96000005 [#1] SMP
  [ 4371.291251] Modules linked in: dm_flakey dm_snapshot dm_bufio
  dm_zero dm_mod loop tls rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver
  nfs lockd grace fscache netfs rfkill sunrpc ext4 vfat fat mbcache jbd2
  drm fuse xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64
  sha1_ce virtio_blk virtio_net net_failover virtio_console failover
  virtio_mmio aes_neon_bs [last unloaded: scsi_debug]
  [ 4371.300059] CPU: 0 PID: 408468 Comm: kworker/u8:5 Tainted: G
         X --------- ---  5.14.0-0.rc1.15.bx.el9.aarch64 #1
  [ 4371.303009] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/0=
6/2015
  [ 4371.304685] Workqueue: events_unbound cleanup_offline_cgwbs_workfn
  [ 4371.306329] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO BTYPE=3D--)
  [ 4371.307867] pc : cleanup_offline_cgwbs_workfn+0x320/0x394
  [ 4371.309254] lr : cleanup_offline_cgwbs_workfn+0xe0/0x394
  [ 4371.310597] sp : ffff80001554fd10
  [ 4371.311443] x29: ffff80001554fd10 x28: 0000000000000000 x27: 0000000=
000000001
  [ 4371.313320] x26: 0000000000000000 x25: 00000000000000e0 x24: ffffd2a=
2fbe671a8
  [ 4371.315159] x23: ffff80001554fd88 x22: ffffd2a2fbe67198 x21: ffffd2a=
2fc25a730
  [ 4371.316945] x20: ffff210412bc3000 x19: ffff210412bc3280 x18: 0000000=
000000000
  [ 4371.318690] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000=
000000000
  [ 4371.320437] x14: 0000000000000000 x13: 0000000000000030 x12: 0000000=
000000040
  [ 4371.322444] x11: ffff210481572238 x10: ffff21048157223a x9 : ffffd2a=
2fa276c60
  [ 4371.324243] x8 : ffff210484106b60 x7 : 0000000000000000 x6 : 0000000=
00007d18a
  [ 4371.326049] x5 : ffff210416a86400 x4 : ffff210412bc0280 x3 : 0000000=
000000000
  [ 4371.327898] x2 : ffff80001554fd88 x1 : ffff210412bc0280 x0 : 0000000=
000000003
  [ 4371.329748] Call trace:
  [ 4371.330372]  cleanup_offline_cgwbs_workfn+0x320/0x394
  [ 4371.331694]  process_one_work+0x1f4/0x4b0
  [ 4371.332767]  worker_thread+0x184/0x540
  [ 4371.333732]  kthread+0x114/0x120
  [ 4371.334535]  ret_from_fork+0x10/0x18
  [ 4371.335440] Code: d63f0020 97f99963 17ffffa6 f8588263 (f9400061)
  [ 4371.337174] ---[ end trace e250fe289272792a ]---
  [ 4371.338365] Kernel panic - not syncing: Oops: Fatal exception
  [ 4371.339884] SMP: stopping secondary CPUs
  [ 4372.424137] SMP: failed to stop secondary CPUs 0-2
  [ 4372.436894] Kernel Offset: 0x52a2e9fa0000 from 0xffff800010000000
  [ 4372.438408] PHYS_OFFSET: 0xfff0defca0000000
  [ 4372.439496] CPU features: 0x00200251,23200840
  [ 4372.440603] Memory Limit: none
  [ 4372.441374] ---[ end Kernel panic - not syncing: Oops: Fatal excepti=
on ]---

The problem happens when cgwb_release_workfn() races with
cleanup_offline_cgwbs_workfn(): wb_tryget() in
cleanup_offline_cgwbs_workfn() can be called after percpu_ref_exit()
is cgwb_release_workfn(), which is basically a use-after-free error.

Fix the problem by making removing the writeback structure from the
offline list before releasing the percpu reference counter. It will
guarantee that cleanup_offline_cgwbs_workfn() will not see and not
access writeback structures which are about to be released.

Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching=
 attached inodes")
Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Boyang Xue <bxue@redhat.com>
Suggested-by: Jan Kara <jack@suse.cz>
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 271f2ca862c8..f5561ea7d90a 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -398,12 +398,12 @@ static void cgwb_release_workfn(struct work_struct =
*work)
 	blkcg_unpin_online(blkcg);
=20
 	fprop_local_destroy_percpu(&wb->memcg_completions);
-	percpu_ref_exit(&wb->refcnt);
=20
 	spin_lock_irq(&cgwb_lock);
 	list_del(&wb->offline_node);
 	spin_unlock_irq(&cgwb_lock);
=20
+	percpu_ref_exit(&wb->refcnt);
 	wb_exit(wb);
 	WARN_ON_ONCE(!list_empty(&wb->b_attached));
 	kfree_rcu(wb, rcu);
--=20
2.31.1

