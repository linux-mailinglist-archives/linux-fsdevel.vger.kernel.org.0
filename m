Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3E749738A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jan 2022 18:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiAWRX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 12:23:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239232AbiAWRXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:23:53 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20NGZf3f017012;
        Sun, 23 Jan 2022 17:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=nCosy33ecX0J91f+yZWExbEBXcKQBNxF3tyBSG1yb1U=;
 b=DE9d6TunlVAbvvwGAs2BAiZjOtxZIzeEAIEvxNhnthi6YQW8fMX44NR9mfSltvy5XikS
 rPC3mVK1YqndjtYLEjJgisOFe3wYfLcjzcjQDVgNBRldaXrE5h7DGO3espap3in57fiD
 hHqE1v1ph1anoc18nGPMaA05cLUie2K2ernAqegzctIzZRDQ3z6u8fyxpiDQlwyol/99
 CHr/dJP9phsba5zTxuErxnS2XK/pjeybtPSkFTJZQ5AxV9nel9n+NGzgXjDREY9F3qd4
 MFJ/n88g4qmvVM3l5tU5ReVApBqN35VgTnweFmDy5YAfk3jlV6lpWLz5C7pz4sJunG1m nA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ds872a7e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jan 2022 17:23:46 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20NHCxls032256;
        Sun, 23 Jan 2022 17:23:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3dr9j8p6b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jan 2022 17:23:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20NHNg1445416838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jan 2022 17:23:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04912A4054;
        Sun, 23 Jan 2022 17:23:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03871A405F;
        Sun, 23 Jan 2022 17:23:41 +0000 (GMT)
Received: from localhost (unknown [9.43.59.179])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 23 Jan 2022 17:23:39 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: [PATCHv1 1/2] jbd2: Kill t_handle_lock transaction spinlock
Date:   Sun, 23 Jan 2022 22:53:27 +0530
Message-Id: <089b38635884e95cfd858c003630bdc8bd7f22b0.1642953021.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642953021.git.riteshh@linux.ibm.com>
References: <cover.1642953021.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TAaMZ_L3fL3mTwTHHhdClEZ_F5t2OUVd
X-Proofpoint-ORIG-GUID: TAaMZ_L3fL3mTwTHHhdClEZ_F5t2OUVd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-23_05,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=711 malwarescore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201230132
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch kills t_handle_lock transaction spinlock completely from
jbd2.
To explain the reasoning, currently there were three sites at which this
spinlock was used.
1. jbd2_journal_wait_updates()
   a. Based on careful code review it can be seen that, we don't need this
      lock here. This is since we wait for any currently ongoing updates
      based on a atomic variable t_updates. And we anyway don't take any
      t_handle_lock while in stop_this_handle().
      i.e.

	write_lock(&journal->j_state_lock()
	jbd2_journal_wait_updates() 			stop_this_handle()
		while (atomic_read(txn->t_updates) { 		|
		DEFINE_WAIT(wait); 				|
		prepare_to_wait(); 				|
		if (atomic_read(txn->t_updates) 		if (atomic_dec_and_test(txn->t_updates))
			write_unlock(&journal->j_state_lock);
			schedule();					wake_up()
			write_lock(&journal->j_state_lock);
		finish_wait();
	   }
	txn->t_state = T_COMMIT
	write_unlock(&journal->j_state_lock);

   b.  Also note that between atomic_inc(&txn->t_updates) in
       start_this_handle() and jbd2_journal_wait_updates(), the
       synchronization happens via read_lock(journal->j_state_lock) in
       start_this_handle();

2. jbd2_journal_extend()
   a. jbd2_journal_extend() is called with the handle of each process from
      task_struct. So no lock required in updating member fields of handle_t

   b. For member fields of h_transaction, all updates happens only via
      atomic APIs (which is also within read_lock()).
      So, no need of this transaction spinlock.

3. update_t_max_wait()
   Based on Jan suggestion, this can be carefully removed using atomic
   cmpxchg API.
   Note that there can be several processes which are waiting for a new
   transaction to be allocated and started. For doing this only one
   process will succeed in taking write_lock() and allocating a new txn.
   After that all of the process will be updating the t_max_wait (max
   transaction wait time). This can be done via below method w/o taking
   any locks using atomic cmpxchg.
   For more details refer [1]

	   new = get_new_val();
	   old = READ_ONCE(ptr->max_val);
	   while (old < new)
		old = cmpxchg(&ptr->max_val, old, new);

[1]: https://lwn.net/Articles/849237/
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/jbd2/transaction.c | 29 +++++++++--------------------
 include/linux/jbd2.h  |  3 ---
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 8e2f8275a253..68dd7de49aff 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -107,7 +107,6 @@ static void jbd2_get_transaction(journal_t *journal,
 	transaction->t_start_time = ktime_get();
 	transaction->t_tid = journal->j_transaction_sequence++;
 	transaction->t_expires = jiffies + journal->j_commit_interval;
-	spin_lock_init(&transaction->t_handle_lock);
 	atomic_set(&transaction->t_updates, 0);
 	atomic_set(&transaction->t_outstanding_credits,
 		   jbd2_descriptor_blocks_per_trans(journal) +
@@ -139,24 +138,21 @@ static void jbd2_get_transaction(journal_t *journal,
 /*
  * Update transaction's maximum wait time, if debugging is enabled.
  *
- * In order for t_max_wait to be reliable, it must be protected by a
- * lock.  But doing so will mean that start_this_handle() can not be
- * run in parallel on SMP systems, which limits our scalability.  So
- * unless debugging is enabled, we no longer update t_max_wait, which
- * means that maximum wait time reported by the jbd2_run_stats
- * tracepoint will always be zero.
+ * t_max_wait is carefully updated here with use of atomic compare exchange.
+ * Note that there could be multiplre threads trying to do this simultaneously
+ * hence using cmpxchg to avoid any use of locks in this case.
  */
 static inline void update_t_max_wait(transaction_t *transaction,
 				     unsigned long ts)
 {
 #ifdef CONFIG_JBD2_DEBUG
+	unsigned long oldts, newts;
 	if (jbd2_journal_enable_debug &&
 	    time_after(transaction->t_start, ts)) {
-		ts = jbd2_time_diff(ts, transaction->t_start);
-		spin_lock(&transaction->t_handle_lock);
-		if (ts > transaction->t_max_wait)
-			transaction->t_max_wait = ts;
-		spin_unlock(&transaction->t_handle_lock);
+		newts = jbd2_time_diff(ts, transaction->t_start);
+		oldts = READ_ONCE(transaction->t_max_wait);
+		while (oldts < newts)
+			oldts = cmpxchg(&transaction->t_max_wait, oldts, newts);
 	}
 #endif
 }
@@ -690,7 +686,6 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 		DIV_ROUND_UP(
 			handle->h_revoke_credits_requested,
 			journal->j_revoke_records_per_block);
-	spin_lock(&transaction->t_handle_lock);
 	wanted = atomic_add_return(nblocks,
 				   &transaction->t_outstanding_credits);

@@ -698,7 +693,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 		jbd_debug(3, "denied handle %p %d blocks: "
 			  "transaction too large\n", handle, nblocks);
 		atomic_sub(nblocks, &transaction->t_outstanding_credits);
-		goto unlock;
+		goto error_out;
 	}

 	trace_jbd2_handle_extend(journal->j_fs_dev->bd_dev,
@@ -714,8 +709,6 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
 	result = 0;

 	jbd_debug(3, "extended handle %p by %d\n", handle, nblocks);
-unlock:
-	spin_unlock(&transaction->t_handle_lock);
 error_out:
 	read_unlock(&journal->j_state_lock);
 	return result;
@@ -847,22 +840,18 @@ void jbd2_journal_wait_updates(journal_t *journal)
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

 /**
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 575c3057a98a..500a95f8c914 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -554,9 +554,6 @@ struct transaction_chp_stats_s {
  *    ->j_list_lock
  *
  *    j_state_lock
- *    ->t_handle_lock
- *
- *    j_state_lock
  *    ->j_list_lock			(journal_unmap_buffer)
  *
  */
--
2.31.1

