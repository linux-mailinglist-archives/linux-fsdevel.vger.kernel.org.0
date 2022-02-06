Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716E04AB25B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 22:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbiBFVb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 16:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiBFVbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:31:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8AC06173B;
        Sun,  6 Feb 2022 13:31:24 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216LMY7n021140;
        Sun, 6 Feb 2022 21:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=/Gxt5Ja8zWkcJzkPdTJ8ZRGglSVaHNMYC82SOXfKT+U=;
 b=z1lcBJB78nhEs6TK4BJI0J0ixJ3JzELIsaMb3UJefe9/BWTKp0gdpFD/BZzNXM8GUKUS
 8xevqyVLvhxSArNbWicWMIYrygTObDn9Dp7avz6DZwQU+ROKrpE5QxBLmdY8s++U2sHL
 4qFUfe6JLdziBMQbSa7x58a7I6UoJ1f3yMCGCoRoTpvGIInmwzN6IeVqkEBS8tEAjL6z
 86V/MDu61hiaGXlaL32x/6enqp0SZqN9RN4oXhb11tWy+EIUGX03sE2Y7QjMxVepMDWb
 hYLv3tDrc209ZcNe/Ho/dYHrHRrZ8+mTBKUU+9v2ltRfDSpKPCOhxJIiVGyk82EV7Rs6 SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1fndbyaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 21:31:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 216LG0ob076415;
        Sun, 6 Feb 2022 21:31:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3e1f9ch3y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 21:31:20 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 216LVJOi103536;
        Sun, 6 Feb 2022 21:31:19 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3e1f9ch3xt-1;
        Sun, 06 Feb 2022 21:31:19 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v11 0/3] nfsd: Initial implementation of NFSv4 Courteous Server (resend v11)
Date:   Sun,  6 Feb 2022 13:31:14 -0800
Message-Id: <1644183077-2663-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: 7U-p6ORDCZFKLO7K8s605iKX7AtvhORA
X-Proofpoint-ORIG-GUID: 7U-p6ORDCZFKLO7K8s605iKX7AtvhORA
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

v2 patch includes:

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

v3 patch includes:

. modified posix_test_lock to check and resolve conflict locks
  to handle NLM TEST and NFSv4 LOCKT requests.

. separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.

v4 patch includes:

. rework nfsd_check_courtesy to avoid dead lock of fl_lock and client_lock
  by asking the laudromat thread to destroy the courtesy client.

. handle NFSv4 share reservation conflicts with courtesy client. This
  includes conflicts between access mode and deny mode and vice versa.

. drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.

v5 patch includes:

. fix recursive locking of file_rwsem from posix_lock_file. 

. retest with LOCKDEP enabled.

v6 patch includes:

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

v7 patch includes:

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

v8 patch includes:

. Fix warning in nfsd4_fl_expire_lock reported by test robot.

v9 patch includes:

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

v10 patch includes:

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

v11 patch includes:

  Add comment for lm_lock_conflict callback.

  Replace static const courtesy_client_expiry with macro.

  Remove courtesy_clnt argument from find_in_sessionid_hashtbl.
  Caller uses nfs4_client->cl_cs_client boolean to determined if
  it's the courtesy client and takes appropriate actions.

  Rename NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT
  with NFSD4_CLIENT_COURTESY and NFSD4_CLIENT_DESTROY_COURTESY.
