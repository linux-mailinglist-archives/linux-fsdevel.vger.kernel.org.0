Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0F12DE8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2020 11:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAAKxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jan 2020 05:53:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgAAKxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jan 2020 05:53:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 001ApcJK025227
        for <linux-fsdevel@vger.kernel.org>; Wed, 1 Jan 2020 05:52:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x87mq3xkq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jan 2020 05:52:58 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 1 Jan 2020 10:52:57 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Jan 2020 10:52:53 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 001AqqXU48103666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jan 2020 10:52:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 680755204F;
        Wed,  1 Jan 2020 10:52:52 +0000 (GMT)
Received: from dhcp-9-199-159-72.in.ibm.com (unknown [9.199.159.72])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3A8C952054;
        Wed,  1 Jan 2020 10:52:49 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     willy@infradead.org, jlayton@kernel.org,
        ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, dsterba@suse.cz,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RESEND PATCH 0/1] Use inode_lock/unlock class of provided APIs in filesystems
Date:   Wed,  1 Jan 2020 16:22:47 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010110-0012-0000-0000-00000379A8D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010110-0013-0000-0000-000021B5B68A
Message-Id: <20200101105248.25304-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-01_03:2019-12-30,2020-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=384 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001010101
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al, any comments?
Resending this after adding Reviewed-by/Acked-by tags.


From previous version:-
Matthew Wilcox in [1] suggested that it will be a good idea
to define some missing API instead of directly using i_rwsem in
filesystems drivers for lock/unlock/downgrade purposes.

This patch does that work. No functionality change in this patch.

After this there are only lockdep class of APIs at certain places
in filesystems which are directly using i_rwsem and second is XFS,
but it seems to be anyway defining it's own xfs_ilock/iunlock set
of APIs and 'iolock' naming convention for this lock.

[1]: https://www.spinics.net/lists/linux-ext4/msg68689.html

Ritesh Harjani (1):
  fs: Use inode_lock/unlock class of provided APIs in filesystems

 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/ioctl.c         |  4 ++--
 fs/ceph/io.c             | 24 ++++++++++++------------
 fs/nfs/io.c              | 24 ++++++++++++------------
 fs/orangefs/file.c       |  4 ++--
 fs/overlayfs/readdir.c   |  2 +-
 fs/readdir.c             |  4 ++--
 include/linux/fs.h       | 21 +++++++++++++++++++++
 8 files changed, 53 insertions(+), 32 deletions(-)

-- 
2.21.0

