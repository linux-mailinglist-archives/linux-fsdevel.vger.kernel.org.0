Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E1178359D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjHUW0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 18:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjHUW0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:26:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D91E4;
        Mon, 21 Aug 2023 15:26:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxTQS009095;
        Mon, 21 Aug 2023 22:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=1WE5SxgXRoabNi7SSgVg1YYIkLBNbg4icRMUng8fDsM=;
 b=uLR62BR2kiUwlSneBarZ3eLwhUNu5YKVeJ9hTJ9QkeADo96iPR5NgJM9K4lYOqUTA6Hj
 om5I5kynsdoEEEJp3uzdEL6bSt4WuM7mNqV3dcW8CZMkFOHmg8SQUIQYeH5OvYthmxw9
 KDoTIOH+cDFTXfla+xPKYby1dGHchJuJduXoekbgV926haae7SxAyVg5QYApqaU7wC4N
 PJZj49BAKwCKlH4lcy5fKfdrDNc33O9AUZKx4OLiHz5AC9zF0YP7/an87AgCOa2ad93b
 cgEePWrWRUsFxcpeO74LSfGH9Q+ekSqyx49JyIx+AY+/6kJA5z3ZdmJgZq/GAbHKEP9o aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjm5dv2ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:26:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LL10bB026729;
        Mon, 21 Aug 2023 22:26:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm64a69h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:26:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LMQ8Fv025089;
        Mon, 21 Aug 2023 22:26:08 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sjm64a694-1;
        Mon, 21 Aug 2023 22:26:08 +0000
From:   Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To:     stable@vger.kernel.org
Cc:     saeed.mirzamohammadi@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5.4 0/1] mm: allow a controlled amount of unfairness in the page lock
Date:   Mon, 21 Aug 2023 15:25:45 -0700
Message-ID: <20230821222547.483583-1-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210206
X-Proofpoint-ORIG-GUID: XsLDHr2elfALR3wElZA8LU0QXRxRKPcp
X-Proofpoint-GUID: XsLDHr2elfALR3wElZA8LU0QXRxRKPcp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We observed a 35% of regression running phoronix pts/ramspeed and also 16%
with unixbench. Regression is caused by the following commit:
dd0f194cfeb5 | mm: rewrite wait_on_page_bit_common() logic

Backporting this fixes the regression (this is already in 5.9+):
- 5ef64cc8987a mm: allow a controlled amount of unfairness in the page lock

Linus Torvalds (1):
  mm: allow a controlled amount of unfairness in the page lock

 include/linux/mm.h   |   2 +
 include/linux/wait.h |   2 +
 kernel/sysctl.c      |   8 +++
 mm/filemap.c         | 160 ++++++++++++++++++++++++++++++++++---------
 4 files changed, 141 insertions(+), 31 deletions(-)

-- 
2.41.0

