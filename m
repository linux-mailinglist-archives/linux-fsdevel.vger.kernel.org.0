Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4425F7E5CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 00:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbfHAWjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 18:39:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730344AbfHAWjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:39:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Mb5Fg098587;
        Thu, 1 Aug 2019 18:39:05 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u45u86vx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:39:05 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MZIQ8026850;
        Thu, 1 Aug 2019 22:39:04 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 2u0e85w6nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:39:04 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71Md3M359244856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:39:04 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAF22787A1;
        Thu,  1 Aug 2019 22:39:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D51C8787A2;
        Thu,  1 Aug 2019 22:39:02 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.147])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:39:02 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/1] fs/splice.c: Fix old documentation about moving pages
Date:   Thu,  1 Aug 2019 19:38:52 -0300
Message-Id: <20190801223852.16042-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010238
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 485ddb4b9741 ("1/2 splice: dont steal")' (2007),
the SPLICE_F_MOVE support was removed (became a no-op according
to man pages), and thus disabling steal operation that would make
moving pages possible.

This fixes the comment, making clear pages are not moved.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 fs/splice.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 14cb602d9a2f..0ba151c40cef 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -671,8 +671,7 @@ ssize_t splice_from_pipe(struct pipe_inode_info *pipe, struct file *out,
  * @flags:	splice modifier flags
  *
  * Description:
- *    Will either move or copy pages (determined by @flags options) from
- *    the given pipe inode to the given file.
+ *    Will copy pages from the given pipe inode to the given file.
  *    This one is ->write_iter-based.
  *
  */
-- 
2.20.1

