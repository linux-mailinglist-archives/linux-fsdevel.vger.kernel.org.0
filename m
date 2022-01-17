Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD349086B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 13:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiAQMMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 07:12:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239715AbiAQMMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:12:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HAQjI7022313;
        Mon, 17 Jan 2022 12:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Nf4XZ6FKgoYu38/KEV2k3IOReGxq5vMJVd3JJhk9trM=;
 b=iVCg5UgEGnehp3ozGeQ29Xg0q2DeQJ34QxjnsOVUVGJeBrY1pJhwanA9ZdAqDWOIM5hQ
 zQTMBZK2k/hISJ6U6uPgWwV67+OHHaKWBFRKH5uiQaoXSNBfzjYUu5wLZsRIMe1mVPTq
 nTKXI6uWaeHYrpfRHyMCsfBsaM/gyJsi3VhibyH+tpmqKkSDg9I564RkvpT7irAe6HF9
 cmtWRkQ64Bq4SU7Q5Rc9soeM2HY023BfOsUoBd+WcQUVaLKZXHXYOv5Okoj1fH8zuZfw
 Sw53lc4OFG1vIbuy4JisguAE2l2X1P29Tx/YaRt8Iu39NMIUxHX6WcDtJzDmMdrzaZL+ fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn6q8t8b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:12 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20HBbvkt018044;
        Mon, 17 Jan 2022 12:12:11 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn6q8t8aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HC71im008699;
        Mon, 17 Jan 2022 12:12:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3dknw8uqnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HCC7VP46268828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 12:12:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4A742045;
        Mon, 17 Jan 2022 12:12:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B07AA42042;
        Mon, 17 Jan 2022 12:12:06 +0000 (GMT)
Received: from localhost (unknown [9.43.45.117])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jan 2022 12:12:06 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: [PATCHv2 5/5] jbd2: Refactor wait logic for transaction updates into a common function
Date:   Mon, 17 Jan 2022 17:41:51 +0530
Message-Id: <8c564f70f4b2591171677a2a74fccb22a7b6c3a4.1642416995.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642416995.git.riteshh@linux.ibm.com>
References: <cover.1642416995.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KJvi_aySvYEfpCA40chBrQLPKXJzpvy8
X-Proofpoint-GUID: Bjbbq_qDlske0bPnMvtU2e5Ti4reNMCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_05,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=888
 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170077
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No functionality change as such in this patch. This only refactors the
common piece of code which waits for t_updates to finish into a common
function named as jbd2_journal_wait_updates(journal_t *)

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/commit.c      | 19 +++-------------
 fs/jbd2/transaction.c | 53 ++++++++++++++++++++++++++-----------------
 include/linux/jbd2.h  |  4 +++-
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 3cc4ab2ba7f4..428364f107be 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -484,22 +484,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	stats.run.rs_running = jbd2_time_diff(commit_transaction->t_start,
 					      stats.run.rs_locked);
 
-	spin_lock(&commit_transaction->t_handle_lock);
-	while (atomic_read(&commit_transaction->t_updates)) {
-		DEFINE_WAIT(wait);
+	// waits for any t_updates to finish
+	jbd2_journal_wait_updates(journal);
 
-		prepare_to_wait(&journal->j_wait_updates, &wait,
-					TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&commit_transaction->t_updates)) {
-			spin_unlock(&commit_transaction->t_handle_lock);
-			write_unlock(&journal->j_state_lock);
-			schedule();
-			write_lock(&journal->j_state_lock);
-			spin_lock(&commit_transaction->t_handle_lock);
-		}
-		finish_wait(&journal->j_wait_updates, &wait);
-	}
-	spin_unlock(&commit_transaction->t_handle_lock);
 	commit_transaction->t_state = T_SWITCH;
 	write_unlock(&journal->j_state_lock);
 
@@ -817,7 +804,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	commit_transaction->t_state = T_COMMIT_DFLUSH;
 	write_unlock(&journal->j_state_lock);
 
-	/* 
+	/*
 	 * If the journal is not located on the file system device,
 	 * then we must flush the file system device before we issue
 	 * the commit record
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 6a3caedd2285..8e2f8275a253 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -449,7 +449,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	}
 
 	/* OK, account for the buffers that this operation expects to
-	 * use and add the handle to the running transaction. 
+	 * use and add the handle to the running transaction.
 	 */
 	update_t_max_wait(transaction, ts);
 	handle->h_transaction = transaction;
@@ -836,6 +836,35 @@ int jbd2_journal_restart(handle_t *handle, int nblocks)
 }
 EXPORT_SYMBOL(jbd2_journal_restart);
 
+/*
+ * Waits for any outstanding t_updates to finish.
+ * This is called with write j_state_lock held.
+ */
+void jbd2_journal_wait_updates(journal_t *journal)
+{
+	transaction_t *commit_transaction = journal->j_running_transaction;
+
+	if (!commit_transaction)
+		return;
+
+	spin_lock(&commit_transaction->t_handle_lock);
+	while (atomic_read(&commit_transaction->t_updates)) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_wait_updates, &wait,
+					TASK_UNINTERRUPTIBLE);
+		if (atomic_read(&commit_transaction->t_updates)) {
+			spin_unlock(&commit_transaction->t_handle_lock);
+			write_unlock(&journal->j_state_lock);
+			schedule();
+			write_lock(&journal->j_state_lock);
+			spin_lock(&commit_transaction->t_handle_lock);
+		}
+		finish_wait(&journal->j_wait_updates, &wait);
+	}
+	spin_unlock(&commit_transaction->t_handle_lock);
+}
+
 /**
  * jbd2_journal_lock_updates () - establish a transaction barrier.
  * @journal:  Journal to establish a barrier on.
@@ -863,27 +892,9 @@ void jbd2_journal_lock_updates(journal_t *journal)
 		write_lock(&journal->j_state_lock);
 	}
 
-	/* Wait until there are no running updates */
-	while (1) {
-		transaction_t *transaction = journal->j_running_transaction;
-
-		if (!transaction)
-			break;
+	/* Wait until there are no running t_updates */
+	jbd2_journal_wait_updates(journal);
 
-		spin_lock(&transaction->t_handle_lock);
-		prepare_to_wait(&journal->j_wait_updates, &wait,
-				TASK_UNINTERRUPTIBLE);
-		if (!atomic_read(&transaction->t_updates)) {
-			spin_unlock(&transaction->t_handle_lock);
-			finish_wait(&journal->j_wait_updates, &wait);
-			break;
-		}
-		spin_unlock(&transaction->t_handle_lock);
-		write_unlock(&journal->j_state_lock);
-		schedule();
-		finish_wait(&journal->j_wait_updates, &wait);
-		write_lock(&journal->j_state_lock);
-	}
 	write_unlock(&journal->j_state_lock);
 
 	/*
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f76598265896..575c3057a98a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -594,7 +594,7 @@ struct transaction_s
 	 */
 	unsigned long		t_log_start;
 
-	/* 
+	/*
 	 * Number of buffers on the t_buffers list [j_list_lock, no locks
 	 * needed for jbd2 thread]
 	 */
@@ -1538,6 +1538,8 @@ extern int	 jbd2_journal_flush(journal_t *journal, unsigned int flags);
 extern void	 jbd2_journal_lock_updates (journal_t *);
 extern void	 jbd2_journal_unlock_updates (journal_t *);
 
+void jbd2_journal_wait_updates(journal_t *);
+
 extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
 				struct block_device *fs_dev,
 				unsigned long long start, int len, int bsize);
-- 
2.31.1

