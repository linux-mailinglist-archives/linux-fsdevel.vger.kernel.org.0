Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F111B6EDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 09:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDXHWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 03:22:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbgDXHWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:22:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O71u71004375
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 03:22:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmv2vj03-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 03:22:34 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 24 Apr 2020 08:21:54 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Apr 2020 08:21:51 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03O7MRk81507790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 07:22:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F9EFA4064;
        Fri, 24 Apr 2020 07:22:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC87A405B;
        Fri, 24 Apr 2020 07:22:25 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.185.245])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Apr 2020 07:22:25 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/2] fibmap: Warn and return an error in case of block > INT_MAX
Date:   Fri, 24 Apr 2020 12:52:17 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1587670914.git.riteshh@linux.ibm.com>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042407-0008-0000-0000-000003766B7B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042407-0009-0000-0000-00004A983B20
Message-Id: <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_02:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240048
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We better warn the fibmap user and not return a truncated and therefore
an incorrect block map address if the bmap() returned block address
is greater than INT_MAX (since user supplied integer pointer).

It's better to WARN all user of ioctl_fibmap() and return a proper error
code rather than silently letting a FS corruption happen if the user tries
to fiddle around with the returned block map address.

We fix this by returning an error code of -ERANGE and returning 0 as the
block mapping address in case if it is > INT_MAX.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index f1d93263186c..3489f3a12c1d 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -71,6 +71,11 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 	block = ur_block;
 	error = bmap(inode, &block);
 
+	if (block > INT_MAX) {
+		error = -ERANGE;
+		WARN(1, "would truncate fibmap result\n");
+	}
+
 	if (error)
 		ur_block = 0;
 	else
-- 
2.21.0

