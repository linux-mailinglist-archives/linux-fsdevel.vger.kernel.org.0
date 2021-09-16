Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0565C40E9C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352754AbhIPSYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 14:24:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45518 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349804AbhIPSXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:23:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GHv6BO010806;
        Thu, 16 Sep 2021 18:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=+1BhvZuj2k+LhkeEelp7WS13FPHvfBLuLqOdQyXt6Vk=;
 b=pQC0lNkvZ5nRCKbjV/DCmZyCnwiw6rA4n1DEbS3oJsksiJKUeJUVBxb7hAyuhoGXLo8E
 n8UdGoies9EGXpA8NPm8GZFDBfwtLPca2WJJQ1kkhsn7QxUGlXR6EuG8xqMJhv9kUcEz
 T2KgBvBCT5Nmd8wzfiWLtPicu3SAmOCqJiJnTnPjFt3wPzguGWyjuuBM4C09iVX+Geuw
 zTwVKDWr9cU8UW0i1l33GJhEhUT9OBXhHIJp7uHi30sga8i4e9+prJDjlAOTrA+rDYol
 oP7YOGbMh/V3cEgMpIrbNfT1Clne2VVAS53GmrbZMKQI6KKAs68ZfxNK2Kxg6AfzRh7l JA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=+1BhvZuj2k+LhkeEelp7WS13FPHvfBLuLqOdQyXt6Vk=;
 b=Lgi/p+LYJdJJ3R9BZpjGRhq95mGY18W2Gc059Bpg5oYZWPC3EeXBX8/NAdctAFJL4lCn
 koCF1NIfhCce2FSQ6Vk0G/m9t237muBUQvzRhJ0UM/wp7q2NIH839TYplWPG2jk4WqYY
 jKUcv1+vuXoGe1wuaj5rybss/nmW6R0pMO7FWu3GdSLlTsKCDzzWc9wYmn8ykfukDCLV
 ZN9lU1vSAvxeip1067RXL83yg81Loxi6AFdb/8xkBsI2dFIF5SjGVNfeTrJPBypczsmH
 YJzQqnXX0bUyZegdVdSEbGU0f6g0NRHlu/OnAyZfD5CGfJsqBZFjlDzow4bwtxo9UA+W pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3tnhuf9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 18:22:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GIAWGg149794;
        Thu, 16 Sep 2021 18:22:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3b0m99rpf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 18:22:19 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 18GIK46a182960;
        Thu, 16 Sep 2021 18:22:18 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 3b0m99rpeg-1;
        Thu, 16 Sep 2021 18:22:18 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v3 0/2] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Thu, 16 Sep 2021 14:22:09 -0400
Message-Id: <20210916182212.81608-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EyOpPCQjn4lstRCryXgPEs9phCwSgqqj
X-Proofpoint-ORIG-GUID: EyOpPCQjn4lstRCryXgPEs9phCwSgqqj
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

. modify posix_test_lock to check and resolve conflict locks
  for handling of NLM TEST and NFSv4 LOCKT requests.

. separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.

. merge with 5.15-rc1


