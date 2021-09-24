Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F437417C93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345722AbhIXUzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 16:55:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9576 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232123AbhIXUzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:55:00 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OKYBP1030096;
        Fri, 24 Sep 2021 20:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=79H3y/qZlJhAtvutq+xu50k0GeyhKSmUxHTFpikS/ws=;
 b=0TQpnH9yAvLKQ2H0FZiEMwgalsNgZyhVNEQUWbS+CzpaiOeLqPvJnP5fWudic2ycpBLC
 D9Lf/8MJQkXndUM+4EjEiC0+JaMsbnmjX4ouJfXW7ZhtNdGC0Ca0tAA05wzc60jXL3xS
 zNR3+0jaacAPZ5zEijhdoR86+CFxlQSHaTZBmgEEQmxq3YsE3PLvxQ4TmyP5HS8+8Iv6
 bPhm/BDuEiQJ5o4y8xqSOQRl2EWDPAFfkbTqJLGMUzF+ygYd23qDKdXJbtluPZn6d/VE
 PzSzHQnHU+uMXPCowYVGCM7GoMvggzEgZGIfuts3n89AIN5qvbHAMXaEBYc46TUft4Jn KQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b93eq5q64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 20:53:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18OKowGv158395;
        Fri, 24 Sep 2021 20:53:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3b93fr897g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 20:53:24 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 18OKrNkR167020;
        Fri, 24 Sep 2021 20:53:23 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 3b93fr8971-1;
        Fri, 24 Sep 2021 20:53:23 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v4 0/2] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Fri, 24 Sep 2021 16:52:50 -0400
Message-Id: <20210924205252.82502-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GwzyUkwke25AVoAxYlI7D8ol9sQLX1OR
X-Proofpoint-ORIG-GUID: GwzyUkwke25AVoAxYlI7D8ol9sQLX1OR
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

NOTE: I will submit pynfs tests for courteous server including tests
for share reservation conflicts in a separate patch.


