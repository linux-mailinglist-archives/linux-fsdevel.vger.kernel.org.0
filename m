Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA5F4AA94F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 15:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380093AbiBEOKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 09:10:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380085AbiBEOKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:10:35 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215BBDed006736;
        Sat, 5 Feb 2022 14:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WW7lsfdrs88dftZzeg99wNOJWcVbwVtQHeVUtn1iB8s=;
 b=pXXcJfIB6ZooJt74iHmWmGnbwfrJ6/sTO6RO+xgWbsbKXdG8lwGwS7rhA6HI2b5eo+Ai
 wggqn0Mcfup3GwM0obe33wpWwC2/9qemROIcqaw5U+zr3F+ZyK/2HAK7TwGN+/ehgJ7y
 9ZpncPgv++HNkoQHo39u7Scd7lxwp9lqPfYiq8pNrfzkK/oh7wZutEnxLWwU210X/uLJ
 hQjzwQ+Knum402jSNSHnz8qt8i5f2IuSmGq/Ug8VZegRSki9cKU+34v2qALzZn5F5paY
 XU3PbR1WG+ZbQZ6pNqxNzqR3UoDYEWzfHe2JzxPPC9gv/FeWFgDejYbEasFecXsm7pZE aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hvby3n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:30 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215E5i7H005533;
        Sat, 5 Feb 2022 14:10:30 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1hvby3mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:30 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215E2qbR026669;
        Sat, 5 Feb 2022 14:10:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3e1gv8t0te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215EAPbj46858606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:10:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBA20A4051;
        Sat,  5 Feb 2022 14:10:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 810FCA4040;
        Sat,  5 Feb 2022 14:10:24 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:10:23 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 4/9] ext4: Use in_range() for range checking in ext4_fc_replay_check_excluded
Date:   Sat,  5 Feb 2022 19:39:53 +0530
Message-Id: <928e45728f7fe285d32bb3c2d5469aeabd8859b8.1644062450.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644062450.git.riteshh@linux.ibm.com>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nf84sj-olZZz94kfYBWGIEj3rML9P5DC
X-Proofpoint-ORIG-GUID: q-NUv91FnPJd9Oo77aE4Gt5UKyPeh8NY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=862 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of open coding it, use in_range() function instead.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 7964ee34e322..3c5baca38767 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1875,8 +1875,8 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t blk)
 		if (state->fc_regions[i].ino == 0 ||
 			state->fc_regions[i].len == 0)
 			continue;
-		if (blk >= state->fc_regions[i].pblk &&
-		    blk < state->fc_regions[i].pblk + state->fc_regions[i].len)
+		if (in_range(blk, state->fc_regions[i].pblk,
+					state->fc_regions[i].len))
 			return true;
 	}
 	return false;
-- 
2.31.1

