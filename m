Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87F1F5D79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgFJVGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 17:06:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49062 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJVGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:06:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AKqwwk026201;
        Wed, 10 Jun 2020 21:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=4jHlZNGKPDJuq84IQpwI4b6fk3uvTWnzD8amLxzwC+s=;
 b=ih0N4anNjUr1Uy2oYdoVXYKI+qmu09mbV6maDasAJJFwRNNdJhSyb0nn9nV+FrXhakf3
 tAGcaJ+ZP4aFidyt1xL4AoPar0CFxbdwmDBshS+403bZ8sqnJKHSItOvAqdFxz/a1QCY
 ZnhzMXo9FIc1x3UAD/ACB0qrufbSgsCAH29vsnbfsB9usAq8CQXqnIDyMrDHPFSFfWUc
 XNJUMFSQ0OVPfhoBs/TeyHoyRhhTVY3iC35fzbC2IUhVFO1ivMHb7F3AaFVjD4exEDX+
 phoM1xO9EcXDtnXlQ6SsCwm+CeqTJIMHkD5JIgWz7ytvigaxTzeqqLEKWhzELXLhQcWU IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31jepnxff0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 21:05:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AKiRQv132314;
        Wed, 10 Jun 2020 21:05:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 31gmwtve3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 21:05:51 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05AL5o8a021995;
        Wed, 10 Jun 2020 21:05:50 GMT
Received: from localhost.localdomain (dhcp-10-65-148-96.vpn.oracle.com [10.65.148.96])
        by userp3020.oracle.com with ESMTP id 31gmwtve2s-1;
        Wed, 10 Jun 2020 21:05:50 +0000
From:   Tom Hromatka <tom.hromatka@oracle.com>
To:     tom.hromatka@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        adobriyan@gmail.com
Subject: [PATCH 0/2] iowait and idle fixes in /proc/stat
Date:   Wed, 10 Jun 2020 15:05:47 -0600
Message-Id: <20200610210549.61193-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A customer is using /proc/stat to track cpu usage in a VM and noted
that the iowait and idle times behave strangely when a cpu goes
offline and comes back online.

This patchset addresses two issues that can cause iowait and idle
to fluctuate up and down.  With these changes, cpu iowait and idle
now only monotonically increase.

Tom Hromatka (2):
  tick-sched: Do not clear the iowait and idle times
  /proc/stat: Simplify iowait and idle calculations when cpu is offline

 fs/proc/stat.c           | 24 ++++++------------------
 kernel/time/tick-sched.c |  9 +++++++++
 2 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.25.3

