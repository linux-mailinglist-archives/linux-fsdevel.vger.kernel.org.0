Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF473CA77
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 12:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjFXKbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jun 2023 06:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjFXKbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jun 2023 06:31:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71F51BC1;
        Sat, 24 Jun 2023 03:31:05 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1687602663;
        bh=Hv07IQfpUi17QmNQC9s2OoEvXVUFS7E+TFWplvGmRyw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PLpwolsw7ZlHoPEmIDUplUBmlSCa8ZaqedGFxQZIe0KHkvGBuIEYCQ8fghPvWEHzT
         SKEHwbl8Fn4kDf3E4tFrHvu9hHBDkBN4yeBxd0MteqcfvTu6IpSN0ofP8O6i0eeDPm
         ILi84B1HpjuS8Gb3Jcx1a0ZocYvInkSZ5kH1WKmI=
Date:   Sat, 24 Jun 2023 12:30:47 +0200
Subject: [PATCH 2/2] proc: use generic setattr() for /proc/$PID/net
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230624-proc-net-setattr-v1-2-73176812adee@weissschuh.net>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
In-Reply-To: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687602663; l=1087;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Hv07IQfpUi17QmNQC9s2OoEvXVUFS7E+TFWplvGmRyw=;
 b=sydRcATQix4hEhnx962ZvNEbCLjg3XbDnJu/cS4rm0AFbOauHU1aZOpDDZuLyUmH8xsoEiR6s
 ZKxXc2ZQni9DLO1vq0PQMim7IYCgXab/zowgtqGT8vwCFxon9fdZPdW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All other files in /proc/$PID/ use proc_setattr().

Not using it allows the usage of chmod() on /proc/$PID/net, even on
other processes owned by the same user.
The same would probably also be true for other attributes to be changed.

As this technically represents an ABI change it is not marked for
stable so any unlikely regressions are caught during a full release cycle.

Fixes: e9720acd728a ("[NET]: Make /proc/net a symlink on /proc/self/net (v3)")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index a0c0419872e3..78f9e6b469c0 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -321,6 +321,7 @@ static int proc_tgid_net_getattr(struct mnt_idmap *idmap,
 const struct inode_operations proc_net_inode_operations = {
 	.lookup		= proc_tgid_net_lookup,
 	.getattr	= proc_tgid_net_getattr,
+	.setattr        = proc_setattr,
 };
 
 static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)

-- 
2.41.0

