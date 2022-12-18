Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AA650588
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 00:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiLRXXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 18:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiLRXW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 18:22:59 -0500
Received: from ms11p00im-qufo17281301.me.com (ms11p00im-qufo17281301.me.com [17.58.38.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D68BC9E
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Dec 2022 15:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671405776;
        bh=rgdJQ00HlDR3n1V78o02Qz8Qw2vR4vsNwWkDiooEv3U=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=0IC6x3I7tC2dhIsfNw+doBy2YcsYehrUaei/sIqDeCjO0aY1eSPUCVdQHTqklamq3
         EaAWOhfBDjtgxE8MlZahSA1x6LmQ6gDZlirhMxcJlaCWBOGgFG27ZFYfK8M2y4Fjfr
         S81VQRwtjuP6kSdI2jqP4u5l/uSiQPUqg/J3gqo6kzLbL+BuWfr29zfmvVAjLW11+h
         w2patQyiwA61qJUhyIS1x9I+3zSQWzXgRxAsc4O8qYMsgl9xSAa8lM4F3NbRNnxIhA
         n3SPbShWko1bv/MXvOKQlJmjru5Hf5mehxM3ZSEihwt1BG2VQYMITdOniQxOpQ9q1V
         a3CzYHs9QthFg==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17281301.me.com (Postfix) with ESMTPSA id C5C46CC036F;
        Sun, 18 Dec 2022 23:22:55 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH v2 01/10] Adjust maximum MSIZE to account for p9 header
Date:   Sun, 18 Dec 2022 23:22:09 +0000
Message-Id: <20221218232217.1713283-2-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221218232217.1713283-1-evanhensbergen@icloud.com>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Mws2nVIwpl5zapwvrA8abhdMpb2AhyYp
X-Proofpoint-GUID: Mws2nVIwpl5zapwvrA8abhdMpb2AhyYp
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=610 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212180222
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add maximum p9 header size to MSIZE to make sure we can
have page aligned data.

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
---
 net/9p/client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index fef6516a0639..f982d36b55b8 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -28,7 +28,11 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/9p.h>
 
-#define DEFAULT_MSIZE (128 * 1024)
+/* DEFAULT MSIZE = 32 pages worth of payload + P9_HDRSZ +
+ * room for write (16 extra) or read (11 extra) operands.
+ */
+
+#define DEFAULT_MSIZE ((128 * 1024) + P9_IOHDRSZ)
 
 /* Client Option Parsing (code inspired by NFS code)
  *  - a little lazy - parse all client options

base-commit: b7b275e60bcd5f89771e865a8239325f86d9927d
prerequisite-patch-id: 031bd397a760838e416ddba75243269ce906c368
prerequisite-patch-id: cf70b974aff8376ea1bbb41d2606ec93609eecf0
prerequisite-patch-id: 91046bd699f2be9a4c9c9bf317693039a4374fbe
prerequisite-patch-id: 28c9dc76bc302670a661fef2c4807d77038ca054
prerequisite-patch-id: 9e6a0ffb4d37f179b3ef3b920d883a464c5c3083
prerequisite-patch-id: f1ef66e1bee57cf76948e8d7d6eca9ef5c335b0e
prerequisite-patch-id: a8342a621d33c26f9347d46c52f076d41d61a946
prerequisite-patch-id: 9117d73d5265a507d68acce493d7f7e623f7a6b0
-- 
2.37.2

