Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1256848D0ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 04:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiAMD1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 22:27:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40884 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232102AbiAMD07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:26:59 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D2v4vg023436;
        Thu, 13 Jan 2022 03:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u+QEUF6JxPZC6iA8/iTQbNfD/0f/cIFBsSvuzS4gYXg=;
 b=XtQE/4T8M4KjLAx/4OxsOfawtJVZyVaD0WxBKQMezj8PQAavGWMJQxUkReiNXt56sLii
 PfeT7/JXOVwf9xUMNnBdhPhe+bNJgz0xzEFeshdKCnijHkrumqGKlPtYxUTgXPjBGx6Z
 gBZK5he/wr8W50biRFwdFSHMZBgijgmlwKl8UuIO2If4In6yyWYVMJ1aMKpcYF1uM0ks
 i0RCilQlDCtNzesTep/QXDiSinUvLHJ8YM/m85B08Wo+vDI3rhATar0GsrbAU5PyWhv1
 MAFCauquB7LPo3PKt2hqJMqQjqR2BFbrLVa6Jcl47TUIdbHieSO1VbxoYtSW7p+JLh+y qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djbrd0du2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:54 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20D3KYZ7030896;
        Thu, 13 Jan 2022 03:26:53 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djbrd0dtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:53 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20D3D3dU015847;
        Thu, 13 Jan 2022 03:26:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3df289gnhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20D3QneS38928886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 03:26:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1BAC4C040;
        Thu, 13 Jan 2022 03:26:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E144C046;
        Thu, 13 Jan 2022 03:26:49 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 03:26:49 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 6/6] jbd2: No need to use t_handle_lock in jbd2_journal_wait_updates
Date:   Thu, 13 Jan 2022 08:56:29 +0530
Message-Id: <e7e0f8c54306591a3a9c8fead1e0e54358052ab6.1642044249.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642044249.git.riteshh@linux.ibm.com>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vDTacn3arfhFYTN4g9wigMBgqbRm2c7o
X-Proofpoint-GUID: GG_NpRVXjvDE-FV8jb9gZ-oUeUi6fQo1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_01,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=776 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130013
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since jbd2_journal_wait_updates() uses waitq based on t_updates atomic_t
variable. So from code review it looks like we don't need to use
t_handle_lock spinlock for checking t_updates value.
Hence this patch gets rid of the spinlock protection in
jbd2_journal_wait_updates()

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 include/linux/jbd2.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 34b051aa9009..9bef47622b9d 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1768,22 +1768,18 @@ static inline void jbd2_journal_wait_updates(journal_t *journal)
 	if (!commit_transaction)
 		return;
 
-	spin_lock(&commit_transaction->t_handle_lock);
 	while (atomic_read(&commit_transaction->t_updates)) {
 		DEFINE_WAIT(wait);
 
 		prepare_to_wait(&journal->j_wait_updates, &wait,
 					TASK_UNINTERRUPTIBLE);
 		if (atomic_read(&commit_transaction->t_updates)) {
-			spin_unlock(&commit_transaction->t_handle_lock);
 			write_unlock(&journal->j_state_lock);
 			schedule();
 			write_lock(&journal->j_state_lock);
-			spin_lock(&commit_transaction->t_handle_lock);
 		}
 		finish_wait(&journal->j_wait_updates, &wait);
 	}
-	spin_unlock(&commit_transaction->t_handle_lock);
 }
 
 /*
-- 
2.31.1

