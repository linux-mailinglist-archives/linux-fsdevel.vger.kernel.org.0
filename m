Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37509263625
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIISh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 14:37:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33374 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIISh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:37:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089Ee08v072586;
        Wed, 9 Sep 2020 14:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=ya+QMUymLQUNC5iL3dsPaQ1FPjA+xSOY9snK3tbq+SE=;
 b=E8z5TGHtsMn0+9RDsXZg3uoJKM8luetu3D1+64GWHDAxIFc27pb+CS+9A2ABl7sF0dDd
 DVrpshAl3ymsXLxw4oIUKYai6cW7k+85wRZbevS3DURpmU6P5XhyQ52nVKqMIXKIKBUp
 MlfytnjQr45ijN5uWdNwrRhDYJjgjgO95reLj0b8JkIzognwuc+GHUwZStLLkT4tZaFU
 FoMypWAjp83rRVvob3Up0nslE7QLEemreUBdqOA1GlJG/3JeLlwokJXs5xxKu5S9mlgV
 IoOmOT4O0P6e2tT98CaPqXujQlHndpwV21khUHrlplfwah6ZceAQMuf7pGxIzCypGJhc Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33c3an24mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 14:41:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089Ef4Ll033004;
        Wed, 9 Sep 2020 14:41:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 33cmk6prv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 14:41:31 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089EfUC4034192;
        Wed, 9 Sep 2020 14:41:30 GMT
Received: from localhost.localdomain (dhcp-10-65-175-55.vpn.oracle.com [10.65.175.55])
        by aserp3020.oracle.com with ESMTP id 33cmk6pru6-1;
        Wed, 09 Sep 2020 14:41:30 +0000
From:   Tom Hromatka <tom.hromatka@oracle.com>
To:     tom.hromatka@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, adobriyan@gmail.com
Subject: [RESEND PATCH 0/2] iowait and idle fixes in /proc/stat
Date:   Wed,  9 Sep 2020 08:41:20 -0600
Message-Id: <20200909144122.77210-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090132
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
2.25.4

