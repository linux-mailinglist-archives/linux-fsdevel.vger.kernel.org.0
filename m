Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36064FC04
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiLQTHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 14:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLQTGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 14:06:31 -0500
Received: from ms11p00im-qufo17291601.me.com (ms11p00im-qufo17291601.me.com [17.58.38.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D5F25C5A
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Dec 2022 11:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671303167;
        bh=VW1TWLbK9ZK24OXnnpvpdNHI7c97JNThnJ7wV1/ZKgI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=VMV2AiGcYTjsTSsq/4VjnkUKgqW/tkUn5SWP902HNfcwghcCXBvsc82aFkB/e5kX9
         mZ2f1HNtzNqZRwoZ/yllnlc4LYBxPM1S4ZQBbJ/y70cj6SqTtcfowNWv32DNAPUaC4
         J1sRFX7rK8sQzX162XYesCJ2M/59PPqEPKxqkeVXx8U77829ZKqsBs/JK1rVDQLZK4
         Yv+xJG5dfTgQOSUIvnb+6eGcN2Fs8iDmtO7j9VeqxgbNiljtf1l95sYtQ7MBHLwTeC
         1xsA+JwbloOWPKPPRn/Mw2udUE0h9eqgeirnO2Lm8E+BrlwtSfWMbjGQZqKKW2qCUJ
         n38/6w737CR9w==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17291601.me.com (Postfix) with ESMTPSA id DEBE83A0553;
        Sat, 17 Dec 2022 18:52:46 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH 1/6] Adjust maximum MSIZE to account for p9 header
Date:   Sat, 17 Dec 2022 18:52:05 +0000
Message-Id: <20221217185210.1431478-2-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221217185210.1431478-1-evanhensbergen@icloud.com>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yBhRS4Bm-FgZwNToO7g-aye-4DzSZ79_
X-Proofpoint-ORIG-GUID: yBhRS4Bm-FgZwNToO7g-aye-4DzSZ79_
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 mlxlogscore=805 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212170174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add maximum p9 header size to MSIZE to make sure we can
have page aligned data.

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
---
 net/9p/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index fef6516a0639..416baf2f1edf 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -28,7 +28,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/9p.h>
 
-#define DEFAULT_MSIZE (128 * 1024)
+#define DEFAULT_MSIZE ((128 * 1024) + P9_HDRSZ)
 
 /* Client Option Parsing (code inspired by NFS code)
  *  - a little lazy - parse all client options
-- 
2.37.2

