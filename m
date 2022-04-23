Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307650CCF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 20:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiDWSri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiDWSrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:47:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F551A1768;
        Sat, 23 Apr 2022 11:44:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23NH4Kua025669;
        Sat, 23 Apr 2022 18:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=Au+Rc42yTMSMyM/1VqIpGNBaHjgTYMelMdvdcBVf0co=;
 b=L09Bx6HO7FSoyuAuEugNdy+t3LgCBVOh/tvLiqORxzVLWyxaRPE7FJgg7msGdHujEvnQ
 XdaZ5+PejrARZl9twaunRxNCXbU5OTJ4HmYTgdBd4HMspRu8pbGMdHNTjWQWwTH0you2
 pU9V7QCckB7r48BAUcHhp8j4c+OKdSQO+BedNWS8TqRGnLAa/35xOqDN6kvs4mPSpNxh
 LXM6vCb+lL/NKy9WsVw9KuGmELXQE8hQIerV7zI4Zo5MYITXxY+XXevitEBZdRXTouGx
 bpjuSnTPf64zWk6sOtvDFZjNGSV3f9k1JkjxPv2mlK9FrpHh3c7KzJTepnIw2KhJBJa3 Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mgnqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 18:44:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23NIawOf010450;
        Sat, 23 Apr 2022 18:44:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w14sh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 18:44:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23NIgigk016659;
        Sat, 23 Apr 2022 18:44:17 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w14sh1-1;
        Sat, 23 Apr 2022 18:44:17 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v21 0/7] NFSD: Initial implementation of NFSv4 Courteous Server
Date:   Sat, 23 Apr 2022 11:44:08 -0700
Message-Id: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: Q9dbgMlUDyiv4QVRFPaOLOnE1WdHsRHf
X-Proofpoint-ORIG-GUID: Q9dbgMlUDyiv4QVRFPaOLOnE1WdHsRHf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chuck, Bruce

This series of patches implement the NFSv4 Courteous Server.

A server which does not immediately expunge the state on lease expiration
is known as a Courteous Server.  A Courteous Server continues to recognize
previously generated state tokens as valid until conflict arises between
the expired state and the requests from another client, or the server
reboots.

v2:

. add new callback, lm_expire_lock, to lock_manager_operations to
  allow the lock manager to take appropriate action with conflict lock.

. handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.

. expire courtesy client after 24hr if client has not reconnected.

. do not allow expired client to become courtesy client if there are
  waiters for client's locks.

. modify client_info_show to show courtesy client and seconds from
  last renew.

. fix a problem with NFSv4.1 server where the it keeps returning
  SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
  the courtesy client reconnects, causing the client to keep sending
  BCTS requests to server.

v3:

. modified posix_test_lock to check and resolve conflict locks
  to handle NLM TEST and NFSv4 LOCKT requests.

. separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.

v4:

. rework nfsd_check_courtesy to avoid dead lock of fl_lock and client_lock
  by asking the laudromat thread to destroy the courtesy client.

. handle NFSv4 share reservation conflicts with courtesy client. This
  includes conflicts between access mode and deny mode and vice versa.

. drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.

v5:

. fix recursive locking of file_rwsem from posix_lock_file. 

. retest with LOCKDEP enabled.

v6:

. merge witn 5.15-rc7

. fix a bug in nfs4_check_deny_bmap that did not check for matched
  nfs4_file before checking for access/deny conflict. This bug causes
  pynfs OPEN18 to fail since the server taking too long to release
  lots of un-conflict clients' state.

. enhance share reservation conflict handler to handle case where
  a large number of conflict courtesy clients need to be expired.
  The 1st 100 clients are expired synchronously and the rest are
  expired in the background by the laundromat and NFS4ERR_DELAY
  is returned to the NFS client. This is needed to prevent the
  NFS client from timing out waiting got the reply.

v7:

. Fix race condition in posix_test_lock and posix_lock_inode after
  dropping spinlock.

. Enhance nfsd4_fl_expire_lock to work with with new lm_expire_lock
  callback

. Always resolve share reservation conflicts asynchrously.

. Fix bug in nfs4_laundromat where spinlock is not used when
  scanning cl_ownerstr_hashtbl.

. Fix bug in nfs4_laundromat where idr_get_next was called
  with incorrect 'id'. 

. Merge nfs4_destroy_courtesy_client into nfsd4_fl_expire_lock.

v8:

. Fix warning in nfsd4_fl_expire_lock reported by test robot.

v9:

. Simplify lm_expire_lock API by (1) remove the 'testonly' flag
  and (2) specifying return value as true/false to indicate
  whether conflict was succesfully resolved.

. Rework nfsd4_fl_expire_lock to mark client with
  NFSD4_DESTROY_COURTESY_CLIENT then tell the laundromat to expire
  the client in the background.

. Add a spinlock in nfs4_client to synchronize access to the
  NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT flag to
  handle race conditions when resolving lock and share reservation
  conflict.

. Courtesy client that was marked as NFSD4_DESTROY_COURTESY_CLIENT
  are now consisdered 'dead', waiting for the laundromat to expire
  it. This client is no longer allowed to use its states if it
  reconnects before the laundromat finishes expiring the client.

  For v4.1 client, the detection is done in the processing of the
  SEQUENCE op and returns NFS4ERR_BAD_SESSION to force the client
  to re-establish new clientid and session.
  For v4.0 client, the detection is done in the processing of the
  RENEW and state-related ops and return NFS4ERR_EXPIRE to force
  the client to re-establish new clientid.

v10:

  Resolve deadlock in v9 by avoiding getting cl_client and
  cl_cs_lock together. The laundromat needs to determine whether
  the expired client has any state and also has no blockers on
  its locks. Both of these conditions are allowed to change after
  the laundromat transits an expired client to courtesy client.
  When this happens, the laundromat will detect it on the next
  run and and expire the courtesy client.

  Remove client persistent record before marking it as COURTESY_CLIENT
  and add client persistent record before clearing the COURTESY_CLIENT
  flag to allow the courtesy client to transist to normal client to
  continue to use its state.

  Lock/delegation/share reversation conflict with courtesy client is
  resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
  effectively disable it, then allow the current request to proceed
  immediately.
  
  Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed
  to reconnect to reuse itsstate. It is expired by the laundromat
  asynchronously in the background.

  Move processing of expired clients from nfs4_laudromat to a
  separate function, nfs4_get_client_reaplist, that creates the
  reaplist and also to process courtesy clients.

  Update Documentation/filesystems/locking.rst to include new
  lm_lock_conflict call.

  Modify leases_conflict to call lm_breaker_owns_lease only if
  there is real conflict.  This is to allow the lock manager to
  resolve the delegation conflict if possible.

v11:

  Add comment for lm_lock_conflict callback.

  Replace static const courtesy_client_expiry with macro.

  Remove courtesy_clnt argument from find_in_sessionid_hashtbl.
  Callers use nfs4_client->cl_cs_client boolean to determined if
  it's the courtesy client and take appropriate actions.

  Rename NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT
  with NFSD4_CLIENT_COURTESY and NFSD4_CLIENT_DESTROY_COURTESY.

v12:

  Remove unnecessary comment in nfs4_get_client_reaplist.

  Replace nfs4_client->cl_cs_client boolean with
  NFSD4_CLIENT_COURTESY_CLNT flag.

  Remove courtesy_clnt argument from find_client_in_id_table and
  find_clp_in_name_tree. Callers use NFSD4_CLIENT_COURTESY_CLNT to
  determined if it's the courtesy client and take appropriate actions.

v13:

  Merge with 5.17-rc3.

  Cleanup Documentation/filesystems/locking.rst: replace i_lock
  with flc_lock, update API's that use flc_lock.

  Rename lm_lock_conflict to lm_lock_expired().

  Remove comment of lm_lock_expired API in lock_manager_operations.
  Same information is in patch description.

  Update commit messages of 4/4.

  Add some comment for NFSD4_CLIENT_COURTESY_CLNT.

  Add nfsd4_discard_courtesy_clnt() to eliminate duplicate code of
  discarding courtesy client; setting NFSD4_DESTROY_COURTESY_CLIENT.

v14:

. merge with Chuck's public for-next branch.

. remove courtesy_client_expiry, use client's last renew time.

. simplify comment of nfs4_check_access_deny_bmap.

. add comment about race condition in nfs4_get_client_reaplist.

. add list_del when walking cslist in nfs4_get_client_reaplist.

. remove duplicate INIT_LIST_HEAD(&reaplist) from nfs4_laundromat

. Modify find_confirmed_client and find_confirmed_client_by_name
  to detect courtesy client and destroy it.

. refactor lookup_clientid to use find_client_in_id_table
  directly instead of find_confirmed_client.

. refactor nfsd4_setclientid to call find_clp_in_name_tree
  directly instead of find_confirmed_client_by_name.

. remove comment of NFSD4_CLIENT_COURTESY.

. replace NFSD4_CLIENT_DESTROY_COURTESY with NFSD4_CLIENT_EXPIRED.

. replace NFSD4_CLIENT_COURTESY_CLNT with NFSD4_CLIENT_RECONNECTED.

v15:

. add helper locks_has_blockers_locked in fs.h to check for
  lock blockers

. rename nfs4_conflict_clients to nfs4_resolve_deny_conflicts_locked

. update nfs4_upgrade_open() to handle courtesy clients.

. add helper nfs4_check_and_expire_courtesy_client and
  nfs4_is_courtesy_client_expired to deduplicate some code.

. update nfs4_anylock_blocker:
   . replace list_for_each_entry_safe with list_for_each_entry
   . break nfs4_anylock_blocker into 2 smaller functions.

. update nfs4_get_client_reaplist:
   . remove unnecessary commets
   . acquire cl_cs_lock before setting NFSD4_CLIENT_COURTESY flag

. update client_info_show to show 'time since last renew: 00:00:38'
  instead of 'seconds from last renew: 38'.

v16:

. update client_info_show to display 'status' as
  'confirmed/unconfirmed/courtesy'

. replace helper locks_has_blockers_locked in fs.h in v15 with new
  locks_owner_has_blockers call in fs/locks.c

. update nfs4_lockowner_has_blockers to use locks_owner_has_blockers

. move nfs4_check_and_expire_courtesy_client from 5/11 to 4/11

. remove unnecessary check for NULL clp in find_in_sessionid_hashtb

. fix typo in commit messages

v17:

. replace flags used for courtesy client with enum courtesy_client_state

. add state table in nfsd/state.h

. make nfsd4_expire_courtesy_clnt, nfsd4_discard_courtesy_clnt and
  nfsd4_courtesy_clnt_expired as static inline.

. update nfsd_breaker_owns_lease to use dl->dl_stid.sc_client directly

. fix kernel test robot warning when CONFIG_FILE_LOCKING not defined.

v18:

. modify 0005-NFSD-Update-nfs4_get_vfs_file-to-handle-courtesy-cli.patch to:

    . remove nfs4_check_access_deny_bmap, fold this functionality
      into nfs4_resolve_deny_conflicts_locked by making use of
      bmap_to_share_mode.

    . move nfs4_resolve_deny_conflicts_locked into nfs4_file_get_access
      and nfs4_file_check_deny. 

v19:

. modify 0002-NFSD-Add-courtesy-client-state-macro-and-spinlock-to.patch to

    . add NFSD4_CLIENT_ACTIVE

    . redo Courtesy client state table

. modify 0007-NFSD-Update-find_in_sessionid_hashtbl-to-handle-cour.patch and
  0008-NFSD-Update-find_client_in_id_table-to-handle-courte.patch to:

    . set cl_cs_client_stare to NFSD4_CLIENT_ACTIVE when reactive
      courtesy client  

v20:

. modify 0006-NFSD-Update-find_clp_in_name_tree-to-handle-courtesy.patch to:
	. add nfsd4_discard_reconnect_clnt
	. replace call to nfsd4_discard_courtesy_clnt with
	  nfsd4_discard_reconnect_clnt

. modify 0007-NFSD-Update-find_in_sessionid_hashtbl-to-handle-cour.patch to:
	. replace call to nfsd4_discard_courtesy_clnt with
	  nfsd4_discard_reconnect_clnt
          
. modify 0008-NFSD-Update-find_client_in_id_table-to-handle-courte.patch
	. replace call to nfsd4_discard_courtesy_clnt with
	  nfsd4_discard_reconnect_clnt

v21:

. merged with 5.18.0-rc3

. Redo based on Bruce's suggestion by breaking the patches into functionality
  and also don't remove client record of courtesy client until the client is
  actually expired.

  0001: courteous server framework with support for client with delegation only.
        This patch also handles COURTESY and EXPIRABLE reconnect.
        Conflict is resolved by set the courtesy client to EXPIRABLE, let the
        laundromat expires the client on next run and return NFS4ERR_DELAY
        OPEN request.

  0002: add support for opens/share reservation to courteous server
        Conflict is resolved by set the courtesy client to EXPIRABLE, let the
        laundromat expires the client on next run and return NFS4ERR_DELAY
        OPEN request.

  0003: mv creation/destroying laundromat workqueue from nfs4_state_start and
        and nfs4_state_shutdown_net to init_nfsd and exit_nfsd.

  0004: fs/lock: add locks_owner_has_blockers helper
  
  0005: add 2 callbacks to lock_manager_operations for resolving lock conflict
  
  0006: add support for locks to courteous server, making use of 0004 and 0005
        Conflict is resolved by set the courtesy client to EXPIRABLE, run the
        laundromat immediately and wait for it to complete before returning to
        fs/lock code to recheck the lock list from the beginning.

        NOTE: I could not get queue_work/queue_delay_work and flush_workqueue
        to work as expected, I have to use mod_delayed_work and flush_workqueue
        to get the laundromat to run immediately.

        When we check for blockers in nfs4_anylock_blockers, we do not check
        for client with delegation conflict. This is because we already hold
        the client_lock and to check for delegation conflict we need the state_lock
        and scanning the del_recall_lru list each time. So to avoid this overhead
        and potential deadlock (not sure about lock of ordering of these locks)
        we check and set the COURTESY client with delegation being recalled to
        EXPIRABLE later in nfs4_laundromat.

  0007: show state of courtesy client in client info.
