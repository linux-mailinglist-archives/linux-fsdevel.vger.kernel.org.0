Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3547B3922AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhEZW1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 18:27:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58202 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233535AbhEZW1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 18:27:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QMF7gu019599
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 15:26:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=m2Usb8pBnaJ5JSG5ZmqsO2PX6YX/Fcc3JtrbDbrn2J0=;
 b=KdozIGjxtdV16VDlebccLJllHB/zniP9jY3DhAld5mU9GLWGdhf3kZaoO5kOGPJRY8kh
 jNbnoEJrtEhRXaPGxoMaan0dLQiIpnFSPcI6Lfh/2PqW+J4sKIdSBlGt9OfUtcsKDWoA
 aSqcZSNH0A4aJQB/Vdp+AG/T94NDmp7SzKY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38shgsmygb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 15:26:04 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 15:26:03 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id A2E5A7B6ABB3; Wed, 26 May 2021 15:25:58 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v5 0/2] cgroup, blkcg: prevent dirty inodes to pin dying memory cgroups
Date:   Wed, 26 May 2021 15:25:55 -0700
Message-ID: <20210526222557.3118114-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pnE_48lbiGrgoJMQMhMXA1i7bGTi2mT7
X-Proofpoint-ORIG-GUID: pnE_48lbiGrgoJMQMhMXA1i7bGTi2mT7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_12:2021-05-26,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=528 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260151
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
To make it less noticeable to a user, the scanning is performed from a
work context.

Big thanks to Jan Kara and Dennis Zhou for their ideas and
contribution to the previous iterations of this patch.

v5:
  - switch inodes to bdi->wb instead of zeroing inode->i_wb
  - split the single patch into two
  - only cgwbs maintain lists of attached inodes
  - added cond_resched()
  - fixed !CONFIG_CGROUP_WRITEBACK handling
  - extended list of prohibited inodes flag
  - other small fixes


Roman Gushchin (2):
  writeback, cgroup: keep list of inodes attached to bdi_writeback
  writeback, cgroup: release dying cgwbs by switching attached inodes

 fs/fs-writeback.c                | 101 +++++++++++++++++++++++++------
 include/linux/backing-dev-defs.h |   2 +
 include/linux/backing-dev.h      |   7 +++
 include/linux/writeback.h        |   2 +
 mm/backing-dev.c                 |  63 ++++++++++++++++++-
 5 files changed, 156 insertions(+), 19 deletions(-)

--=20
2.31.1

