Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D784A4A45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348929AbiAaPRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:17:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243534AbiAaPRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:17:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VE5gIP029266;
        Mon, 31 Jan 2022 15:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yG+ttgsCNS7vhL369EEagpTzB6tD6DG8kexKYeT8gJU=;
 b=kAUFlA1ZAkuj4/ovrjHal2KqY8C4RSP+3U/+DXU+hkHkd62ACmPAFwO7bCSSCoxl9kip
 wDDQr+MSzXFPyFo8+wW5g7yNjRHjPofmVcn9Dl/D3NN2f4nu77O2VdvOH6KbEAV01O85
 ljizl1sj8HlY9HoyNtYwjIGPALlJeg2+MA/5lYwEXTt94GxFGFONSKUXNt3tworZxWt2
 iU3eAfRxAImxmYXHzXhwL3Ljg6LMl6Rt+DNWKEQmvAH3eBrWMhuLx/NZjIIqdnECasuE
 XIwlT5JZBXXFnoTiDPEG9jhPqABd4ZcALHldqq1HE+agZrpfaL72K04yrXFn7rC+OIAb Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxh7rspt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:15 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VF0pKQ029532;
        Mon, 31 Jan 2022 15:17:15 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxh7rspsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:15 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VFCcvr007658;
        Mon, 31 Jan 2022 15:17:13 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3dvw79csn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VFHBSQ44302652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 15:17:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35E3952069;
        Mon, 31 Jan 2022 15:17:11 +0000 (GMT)
Received: from localhost (unknown [9.43.5.245])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B222F52052;
        Mon, 31 Jan 2022 15:17:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 3/6] ext4: Use in_range() for range checking in ext4_fc_replay_check_excluded
Date:   Mon, 31 Jan 2022 20:46:52 +0530
Message-Id: <54467b596f803bbaa9e76ed028011a36a522fe70.1643642105.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643642105.git.riteshh@linux.ibm.com>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MtFflQrBrgW_LSS4ttbD-C6nV1kSMYjP
X-Proofpoint-GUID: 7WgaySspY-Q_9yNEJ5tjZDOqTIicd03T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_06,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=933 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of open coding it, use in_range() function instead.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fast_commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5934c23e153e..bd6a47d18716 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1874,8 +1874,8 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t blk)
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

