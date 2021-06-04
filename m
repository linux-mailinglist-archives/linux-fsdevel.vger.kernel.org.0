Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01A039AFC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFDBdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:33:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59030 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230138AbhFDBdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:33:50 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1541Ub8Z031530
        for <linux-fsdevel@vger.kernel.org>; Thu, 3 Jun 2021 18:32:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=YHgCz8/Wp4qf1Lp/L94M00O6Hct482XZKKgJPV6casw=;
 b=fPFV8q1lba2+3rVtOXL/aMOvNuFHsHskeGYSz3Mr1wrHwwqwsdtuJKwXhhMZjBXEUyz3
 g77KFw3CQJCjpfTxFkr41q3G0uBeC94hh4Lw7fU+2/I9U/2gKqpH1OTp47zsJZNnl02j
 4aRc8RgjHt1LB8rWPnMN0lk7iM9ncp+GAIE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xj5kg1tk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 18:32:04 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 18:32:03 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 705327FA36D0; Thu,  3 Jun 2021 18:32:00 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v7 0/6] cgroup, blkcg: prevent dirty inodes to pin dying memory cgroups
Date:   Thu, 3 Jun 2021 18:31:53 -0700
Message-ID: <20210604013159.3126180-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: poV1GTQ5buKK0sDhSa_NLMH9F7XfhTRc
X-Proofpoint-ORIG-GUID: poV1GTQ5buKK0sDhSa_NLMH9F7XfhTRc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_01:2021-06-04,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=347 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040009
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

Big thanks to Jan Kara, Dennis Zhou and Hillf Danton for their ideas and
contribution to this patchset.

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


Roman Gushchin (6):
  writeback, cgroup: do not switch inodes with I_WILL_FREE flag
  writeback, cgroup: switch to rcu_work API in inode_switch_wbs()
  writeback, cgroup: keep list of inodes attached to bdi_writeback
  writeback, cgroup: split out the functional part of
    inode_switch_wbs_work_fn()
  writeback, cgroup: support switching multiple inodes at once
  writeback, cgroup: release dying cgwbs by switching attached inodes

 fs/fs-writeback.c                | 302 +++++++++++++++++++++----------
 include/linux/backing-dev-defs.h |  20 +-
 include/linux/writeback.h        |   1 +
 mm/backing-dev.c                 |  69 ++++++-
 4 files changed, 293 insertions(+), 99 deletions(-)

--=20
2.31.1

