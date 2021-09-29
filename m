Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED06F41BBF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 02:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbhI2A62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 20:58:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41800 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243534AbhI2A62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 20:58:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T0pros027720;
        Wed, 29 Sep 2021 00:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=eZyACg3VHJcyuF9mNtb0Z1ng/pWO3eXGqlVeXrGKqmk=;
 b=eIn6WIh5gEcucuEuaGDWSK2eooxPTZx3e6+RJPKUyEc5eYUF8WiFswcMo52LEi3o/4p+
 e9f8c9i+lP03eCVSaWezGe33m9Dh7CbjUtCHn+Of9JFkMYr+wM1YyTW0q/NrVSZ6VhK2
 3JVRsEs0Ytz1y0Z09zTTE4n/W9BGWGlQPIJa5Btmd/FzG5zk7Qxzma/9XHh2bF2A/aHl
 fReRrZ3N8h7D4yfVSDh2qa2ncqTpM4z+tfIoG/Ywr9hW6NLZf7SzRrk7OqQ0Q2AtorWK
 SU/7pXA/Hs3gfDzHMJegz9gNjGLHfSDBARbWHjQvAn5Pva/taHP1XkCVW3KZXYQ+4YI2 /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbj90t611-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 00:56:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18T0uQH8052462;
        Wed, 29 Sep 2021 00:56:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3bc3bj5mbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 00:56:45 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 18T0ujKT053426;
        Wed, 29 Sep 2021 00:56:45 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 3bc3bj5mau-1;
        Wed, 29 Sep 2021 00:56:45 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Tue, 28 Sep 2021 20:56:39 -0400
Message-Id: <20210929005641.60861-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HlBOcDbteyLklao1zXXMMmrOCxb0-f8j
X-Proofpoint-ORIG-GUID: HlBOcDbteyLklao1zXXMMmrOCxb0-f8j
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Bruce,

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

NOTE: I will submit pynfs tests for courteous server including tests
for share reservation conflicts in a separate patch.


