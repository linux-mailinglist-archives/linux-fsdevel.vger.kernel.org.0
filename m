Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF24B04A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 05:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiBJEwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 23:52:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiBJEwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:52:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C832C1B2;
        Wed,  9 Feb 2022 20:52:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21A4SvsY020151;
        Thu, 10 Feb 2022 04:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=O5GZcFi0IIiquyYsl+XQYXWmvPZcYmYFvrVrCg3GjEk=;
 b=npD9qJEl6kCx8gPEI8qmrCrgRBXNi7vJpe7soonjqzF0s7Na6+V5H1e88DJgGIfdiJeL
 j6Ryoj66x4/bQ8QvaZlN31gLK+GLEcCkQvNzw+8oqjw98qyra5DTlVnDSnYW8S4Wxgi5
 OCZaQD+LGBZZZxcvklxAROhv17wmN49NMcw+BlEnpw47T539DzAqQCDYcVfKbj+P24is
 fRcSnb3G9DItbabVTelBH+6oOAaoMqhntI9QXRKyNwIKTBloeQeAwl1U0+Ja1MKOylTt
 iC+7//kk9HTaKGxEqwxwCkRwnKk+cBPuy1Xt0W0Sz0Wro/5XBk2e4tOJeTihOafL2Gw8 bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366x024e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 04:52:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21A4oCTA015420;
        Thu, 10 Feb 2022 04:52:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3e1f9jk1yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 04:52:13 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21A4qC5M020851;
        Thu, 10 Feb 2022 04:52:12 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3e1f9jk1y6-1;
        Thu, 10 Feb 2022 04:52:12 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v12 0/3] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Wed,  9 Feb 2022 20:52:06 -0800
Message-Id: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: iFKX4ARG2cZ1g4m-1XKW32QFuqT6GwUD
X-Proofpoint-ORIG-GUID: iFKX4ARG2cZ1g4m-1XKW32QFuqT6GwUD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
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
  Callers use nfs4_client->cl_cs_client boolean to determined if
  it's the courtesy client and take appropriate actions.

  Rename NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT
  with NFSD4_CLIENT_COURTESY and NFSD4_CLIENT_DESTROY_COURTESY.

v12 patch includes:

  Remove unnecessary comment in nfs4_get_client_reaplist.

  Replace nfs4_client->cl_cs_client boolean with
  NFSD4_CLIENT_COURTESY_CLNT flag.

  Remove courtesy_clnt argument from find_client_in_id_table and
  find_clp_in_name_tree. Callers use NFSD4_CLIENT_COURTESY_CLNT to
  determined if it's the courtesy client and take appropriate actions.

