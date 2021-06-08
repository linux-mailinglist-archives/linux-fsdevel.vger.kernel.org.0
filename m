Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571D63A0769
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 01:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhFHXGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 19:06:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61504 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235225AbhFHXGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:06:53 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158N4vOM005727
        for <linux-fsdevel@vger.kernel.org>; Tue, 8 Jun 2021 16:04:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=qki3pZl3RIKUB1JDzSgs8HkX9NGihJFWZRYkhd2+u2Q=;
 b=Hc0Dkg4jpkgzm/4vwtWpor5mtobuNNRnkWJPEY9s/Y6WNXKNXJyhRzGdMnATE8TacFzC
 4ZIOiXdRTdm4U7QAK9sxHwhG/9hr91Svm+GMcdIzuW/5N3qyM3nbsYIxz9eF5tv/A+/w
 0UhK2+e0PjXY/rdrEYkEIbCLBjxhMqI60RM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3929n4bkmp-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 16:04:59 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:04:51 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 2E69C82542C5; Tue,  8 Jun 2021 16:02:28 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v9 0/8] cgroup, blkcg: prevent dirty inodes to pin dying memory cgroups
Date:   Tue, 8 Jun 2021 16:02:17 -0700
Message-ID: <20210608230225.2078447-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ioJwJbNNTZkyPFu_tBgO0_vauE7wmp6v
X-Proofpoint-ORIG-GUID: ioJwJbNNTZkyPFu_tBgO0_vauE7wmp6v
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=239 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106080146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When an inode is getting dirty for the first time it's associated
with a wb structure (see __inode_attach_wb()). It can later be
switched to another wb (if e.g. some other cgroup is writing a lot of
data to the same inode), but otherwise stays attached to the original
wb until being reclaimed.

The problem is that the wb structure holds a reference to the original
memory and blkcg cgroups. So if an inode has been dirty once and later
is actively used in read-only mode, it has a good chance to pin down
the original memory and blkcg cgroups forewer. This is often the case wit=
h
services bringing data for other services, e.g. updating some rpm
packages.

In the real life it becomes a problem due to a large size of the memcg
structure, which can easily be 1000x larger than an inode. Also a
really large number of dying cgroups can raise different scalability
issues, e.g. making the memory reclaim costly and less effective.

To solve the problem inodes should be eventually detached from the
corresponding writeback structure. It's inefficient to do it after
every writeback completion. Instead it can be done whenever the
original memory cgroup is offlined and writeback structure is getting
killed. Scanning over a (potentially long) list of inodes and detach
them from the writeback structure can take quite some time. To avoid
scanning all inodes, attached inodes are kept on a new list (b_attached).
To make it less noticeable to a user, the scanning and switching is perfo=
rmed
from a work context.

Big thanks to Jan Kara, Dennis Zhou, Hillf Danton and Tejun Heo for their=
 ideas
and contribution to this patchset.

v9:
  - wb_get_lookup() replaced with wb_get_create()
  - minor formatting fix

v8:
  - switch inodes to a nearest living ancestor wb instead of root wb
  - added two inodes switching fixes suggested by Jan Kara

v7:
  - shared locking for multiple inode switching
  - introduced inode_prepare_wbs_switch() helper
  - extended the pre-switch inode check for I_WILL_FREE
  - added comments here and there

v6:
  - extended and reused wbs switching functionality to switch inodes
    on cgwb cleanup
  - fixed offline_list handling
  - switched to the unbound_wq
  - other minor fixes

v5:
  - switch inodes to bdi->wb instead of zeroing inode->i_wb
  - split the single patch into two
  - only cgwbs maintain lists of attached inodes
  - added cond_resched()
  - fixed !CONFIG_CGROUP_WRITEBACK handling
  - extended list of prohibited inodes flag
  - other small fixes


Roman Gushchin (8):
  writeback, cgroup: do not switch inodes with I_WILL_FREE flag
  writeback, cgroup: add smp_mb() to cgroup_writeback_umount()
  writeback, cgroup: increment isw_nr_in_flight before grabbing an inode
  writeback, cgroup: switch to rcu_work API in inode_switch_wbs()
  writeback, cgroup: keep list of inodes attached to bdi_writeback
  writeback, cgroup: split out the functional part of
    inode_switch_wbs_work_fn()
  writeback, cgroup: support switching multiple inodes at once
  writeback, cgroup: release dying cgwbs by switching attached inodes

 fs/fs-writeback.c                | 323 +++++++++++++++++++++----------
 include/linux/backing-dev-defs.h |  20 +-
 include/linux/writeback.h        |   1 +
 mm/backing-dev.c                 |  69 ++++++-
 4 files changed, 312 insertions(+), 101 deletions(-)

--=20
2.31.1

