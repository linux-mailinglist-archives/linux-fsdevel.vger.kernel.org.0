Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2865059E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 00:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiLRXY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 18:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiLRXYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 18:24:20 -0500
Received: from ms11p00im-qufo17281301.me.com (ms11p00im-qufo17281301.me.com [17.58.38.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7065ABE14
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Dec 2022 15:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671405854;
        bh=oDXYKkCov4vc1fbNoQpiyUCSmJFNPo7qTEDD6t0cO18=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=QToQWNFbYsWTWFfxE5Wy351p/X9UwtN+orRm+H0ebOqVlA5vJ0RRWN6qB4ifVfTMr
         xWsrmhy43epqryCarcl6OhCuTtjdXAAq5lAqg6QYxIPsWGtuHDF8GoySlqyIHL5OM7
         yYE81TCiU0o4BHlJd0/fBTtVnFUftT4WoK1Y9xsXiPTQFwBOOMjWTkQKxFCEbW07WS
         OPzMmYT20smEJeE7Do6WjgOstd/FLkLM9xb3egbQCRLUHmX7uPSB4Z3UrPcl+VB78v
         uPgGLUJOUubWfP15la5DJ4c6pHp/6GD9aF4XIq8BefI5NON7d/qER9XGxTjyywAXQ6
         r9vRhjnMRWVBw==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17281301.me.com (Postfix) with ESMTPSA id DB3EBCC036F;
        Sun, 18 Dec 2022 23:24:13 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH v2 07/10] Add additional debug flags and open modes
Date:   Sun, 18 Dec 2022 23:22:21 +0000
Message-Id: <20221218232217.1713283-8-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221218232217.1713283-1-evanhensbergen@icloud.com>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dzmLWAsZB3CFFZNJGNkOrzDsXxIHhK7j
X-Proofpoint-GUID: dzmLWAsZB3CFFZNJGNkOrzDsXxIHhK7j
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=595 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212180222
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some additional debug flags to assist with debugging
cache changes.  Also add some additional open modes so we
can track cache state in fids more directly.

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
---
 include/net/9p/9p.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index 429adf6be29c..61c20b89becd 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -42,6 +42,8 @@ enum p9_debug_flags {
 	P9_DEBUG_PKT =		(1<<10),
 	P9_DEBUG_FSC =		(1<<11),
 	P9_DEBUG_VPKT =		(1<<12),
+	P9_DEBUG_CACHE =	(1<<13),
+	P9_DEBUG_MMAP =		(1<<14),
 };
 
 #ifdef CONFIG_NET_9P_DEBUG
@@ -213,6 +215,9 @@ enum p9_open_mode_t {
 	P9_ORCLOSE = 0x40,
 	P9_OAPPEND = 0x80,
 	P9_OEXCL = 0x1000,
+	P9L_DIRECT = 0x2000, /* cache disabled */
+	P9L_NOWRITECACHE = 0x4000, /* no write caching  */
+	P9L_LOOSE = 0x8000, /* loose cache */
 };
 
 /**
-- 
2.37.2

