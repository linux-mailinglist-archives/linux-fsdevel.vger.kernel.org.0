Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E4489F95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 19:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242476AbiAJSvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 13:51:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43822 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242432AbiAJSvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:51:16 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AGcBJG024767;
        Mon, 10 Jan 2022 18:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=V/2GGaBTZ1c7p3laThIUnq01Gf+Z9U2NvjfsLnj48/g=;
 b=PSWn8R3CZrHci9YLzg9QnwOneJuDtn/AgXIfyamszeVz1MfgA879YuXJD+Sfxsx/6jF8
 iiUCH9kUtZlSgW9chTi4P5DeyVh7YZOnOOvjDDwTBNF11rH98yPaRCCHTx47NoKoqr0z
 K8xU33DyYuOdAeT+JCo5DFSrZkeicozcLC+N1kJseJ0oWdlL+Q9Ct78ld7KR1x35NWDg
 T0l0CwoCCLdwjCXj2l9i7Z+HVExypzO9/Vj0bqUcJe8tlLQcoMPfwu9TuRDFkdn3DZ1x
 5lBwbir60G1Jlq8olN3OIHXTb+EhoK6eQ6a2uZwi1abrDrNxN7P6qswrMT0sPj80LSxF 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7ngufm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 18:51:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AIk6W6115739;
        Mon, 10 Jan 2022 18:51:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3deyqvubdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 18:51:11 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20AIpBuk140178;
        Mon, 10 Jan 2022 18:51:11 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by userp3030.oracle.com with ESMTP id 3deyqvubcm-1;
        Mon, 10 Jan 2022 18:51:11 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v9 0/2] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Mon, 10 Jan 2022 10:50:51 -0800
Message-Id: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: ckLgXZ_HgK3Iwd5ohoVDUTi7MKOP3JO5
X-Proofpoint-ORIG-GUID: ckLgXZ_HgK3Iwd5ohoVDUTi7MKOP3JO5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bruce, Chuck

This series of patches implement the NFSv4 Courteous Server.

A server which does not immediately expunge the state on lease expiration
is known as a Courteous Server.  A Courteous Server continues to recognize
previously generated state tokens as valid until conflict arises between
the expired state and the requests from another client, or the server
reboots.

The v2 patch includes the following:

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
  the courtesy client re-connects, causing the client to keep sending
  BCTS requests to server.

The v3 patch includes the following:

. modified posix_test_lock to check and resolve conflict locks
  to handle NLM TEST and NFSv4 LOCKT requests.

. separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.

The v4 patch includes:

. rework nfsd_check_courtesy to avoid dead lock of fl_lock and client_lock
  by asking the laudromat thread to destroy the courtesy client.

. handle NFSv4 share reservation conflicts with courtesy client. This
  includes conflicts between access mode and deny mode and vice versa.

. drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.

The v5 patch includes:

. fix recursive locking of file_rwsem from posix_lock_file. 

. retest with LOCKDEP enabled.

The v6 patch includes:

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

The v7 patch includes:

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

The v8 patch includes:

. Fix warning in nfsd4_fl_expire_lock reported by test robot.

The V9 patch include:

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
  re-connects before the laundromat finishes expiring the client.

  For v4.1 client, the detection is done in the processing of the
  SEQUENCE op and returns NFS4ERR_BAD_SESSION to force the client
  to re-establish new clientid and session.
  For v4.0 client, the detection is done in the processing of the
  RENEW and state-related ops and return NFS4ERR_EXPIRE to force
  the client to re-establish new clientid.

