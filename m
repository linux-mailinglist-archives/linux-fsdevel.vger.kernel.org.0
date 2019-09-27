Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845ADBFE46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfI0Ew5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 00:52:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbfI0Ew5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 00:52:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8R4ppcm093204
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2019 00:52:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v98cyw1qy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2019 00:52:55 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 27 Sep 2019 05:52:54 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Sep 2019 05:52:52 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8R4qpD828508254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 04:52:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B1ECA4053;
        Fri, 27 Sep 2019 04:52:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4CBFA404D;
        Fri, 27 Sep 2019 04:52:49 +0000 (GMT)
Received: from dhcp-9-199-159-6.in.ibm.com (unknown [9.199.159.6])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 04:52:49 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jlayton@kernel.org, riteshh@linux.ibm.com
Subject: [PATCH 1/1] direct-io: Change is_async member of struct dio from int to bool
Date:   Fri, 27 Sep 2019 10:22:47 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092704-0012-0000-0000-000003512E24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092704-0013-0000-0000-0000218BC7F6
Message-Id: <20190927045247.23937-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=495 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270047
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change is_async member of struct dio from int to bool.
Found this during code review.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index ae196784f487..b139876653ef 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -128,7 +128,7 @@ struct dio {
 	/* BIO completion state */
 	spinlock_t bio_lock;		/* protects BIO fields below */
 	int page_errors;		/* errno from get_user_pages() */
-	int is_async;			/* is IO async ? */
+	bool is_async;			/* is IO async ? */
 	bool defer_completion;		/* defer AIO completion to workqueue? */
 	bool should_dirty;		/* if pages should be dirtied */
 	int io_error;			/* IO error in completion path */
-- 
2.21.0

