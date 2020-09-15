Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7523F26ADB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 21:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgIOTgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 15:36:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59268 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgIOTgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:36:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FJTsaD158182;
        Tue, 15 Sep 2020 19:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=Rw8w59HV0BmwfC+sx5W0JlX3hGNyIvv/X1bdX0rbjng=;
 b=DGJ1vKHTIHDrm5+aQToYDEvxpkhAwVYQkiJprKb6yk+t/mY+pXN9C1prKJmv0dj6hGBU
 fgrBy4U+jZCMETKibKE1KBf7VU5HzS+iyqVs0RPoGaYpjVALw8Xi/2W6wYWFraaDW8Ma
 OBeetR8i1KmsYo/k2zjqxvMwi3fMquakNBVVFt6MMnnhytXozQB0LIsbn9+L4VLY40rQ
 1eadCoL28efDA0zs9F15Xc3o99YnuvDUw8svbKiAcToID2uXgu2u8cYLllw1JzOM1F3R
 wP/xJus/XnXWWr6hQ3gCg4fWs2oCRZV0KMHhiThcA/Fscbj8OHvHTjVEvptSyD4M3hZv Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 33gnrqy89e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 19:36:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FJTwWl172821;
        Tue, 15 Sep 2020 19:36:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 33h7wpn39x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 19:36:29 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FJZuSN187206;
        Tue, 15 Sep 2020 19:36:29 GMT
Received: from localhost.localdomain (dhcp-10-65-133-238.vpn.oracle.com [10.65.133.238])
        by aserp3030.oracle.com with ESMTP id 33h7wpn39m-1;
        Tue, 15 Sep 2020 19:36:29 +0000
From:   Tom Hromatka <tom.hromatka@oracle.com>
To:     tom.hromatka@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, adobriyan@gmail.com
Subject: [PATCH v2 0/2] iowait and idle fixes in /proc/stat
Date:   Tue, 15 Sep 2020 13:36:25 -0600
Message-Id: <20200915193627.85423-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150152
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A customer is using /proc/stat to track cpu usage in a VM and noted
that the iowait and idle times behave strangely when a cpu goes
offline and comes back online.

This patchset addresses two issues that can cause iowait and idle
to fluctuate up and down.  With these changes, cpu iowait and idle
now only increase.

Changes from v1 to v2:
* Cleaned up commit messages
* Clarified code comments
* Further optimized the logic in fs/proc/stat.c

Tom Hromatka (2):
  tick-sched: Do not clear the iowait and idle times
  /proc/stat: Simplify iowait and idle calculations when cpu is offline

 fs/proc/stat.c           | 26 ++------------------------
 kernel/time/tick-sched.c |  9 +++++++++
 2 files changed, 11 insertions(+), 24 deletions(-)

-- 
2.25.4

