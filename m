Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C34B8204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiBPHrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:47:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiBPHrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:47:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DCD60DB4;
        Tue, 15 Feb 2022 23:46:45 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G6kjIv025924;
        Wed, 16 Feb 2022 07:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=inteSJlknkXKBSjFJQ+IEkHvQgvhQhiiy5wLkiYdZrg=;
 b=lEuo5lzKHmSeVm3c5vjjOJ24oyRIack36fAyHFhgvPEi2riI8LJgn9c6ocBY/eilpvER
 fFMQA/GzIvxLUV/Q252r5Vw19Uu6fQoQs29jCYEK+xKqdX+IGSngeHLEMCOqVdm/ZQ/4
 QUzUgS8wuB9TIY1DVARi4OIeFiZXH9ThFUvQR0YO2VKRoNc3DJemDczAAdoYrv8jSErM
 3CPTl2Abh01MuZ+VEGLbp9HAJZFt99/cFmwpJxqGDHB5hjqWsTqmne2VzsBZI6gGi19I
 5XKdjSWSATjtBJmn5fUwFMKwnnUPfcwE2OanW3NVCy+MwEvtTnMdtDgJB8zVVGOw+Jkm dQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e8va4g794-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:00:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G6qiJd023406;
        Wed, 16 Feb 2022 07:00:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64ha5gts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:00:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G70nGG30867810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:00:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABAD911C04A;
        Wed, 16 Feb 2022 07:00:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CE4611C052;
        Wed, 16 Feb 2022 07:00:49 +0000 (GMT)
Received: from localhost (unknown [9.43.85.173])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 07:00:49 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 REBASED 1/2] jbd2: Kill t_handle_lock transaction spinlock
Date:   Wed, 16 Feb 2022 12:30:35 +0530
Message-Id: <d89e599658b4a1f3893a48c6feded200073037fc.1644992076.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644992076.git.riteshh@linux.ibm.com>
References: <cover.1644992076.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g7vYbYUHddNw4G2k2InW_TU_jvo-D-oQ
X-Proofpoint-ORIG-GUID: g7vYbYUHddNw4G2k2InW_TU_jvo-D-oQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_02,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=790 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 28 +++++++++-------------------
 include/linux/jbd2.h  |  3 ---
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 259e00046a8b..83801a8be078 100644
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
@@ -860,15 +853,12 @@ void jbd2_journal_wait_updates(journal_t *journal)
 		if (!transaction)
 			break;
 
-		spin_lock(&transaction->t_handle_lock);
 		prepare_to_wait(&journal->j_wait_updates, &wait,
 				TASK_UNINTERRUPTIBLE);
 		if (!atomic_read(&transaction->t_updates)) {
-			spin_unlock(&transaction->t_handle_lock);
 			finish_wait(&journal->j_wait_updates, &wait);
 			break;
 		}
-		spin_unlock(&transaction->t_handle_lock);
 		write_unlock(&journal->j_state_lock);
 		schedule();
 		finish_wait(&journal->j_wait_updates, &wait);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 9c3ada74ffb1..a787872e1e86 100644
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

