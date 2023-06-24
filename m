Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2F73CA74
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjFXKbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jun 2023 06:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjFXKbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jun 2023 06:31:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C4D10F7;
        Sat, 24 Jun 2023 03:31:05 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1687602663;
        bh=WAQxIZy8y/wxN8eDcQ6zJJABtAxVwhMmcahqLn9v8OM=;
        h=From:Subject:Date:To:Cc:From;
        b=FKEt8muf/8qMIDO4vrjsWnxx2qqbDzBd6VMsGMYRJ9ESvOTKoOs5oS9kLva2GR1wq
         bXCK014zVe8yVpqTRGpHj71Xs9wnCWCMNqIH3XNBIr4aSefRmwVG+Tzc8WJgrqzOvP
         dFyAdHZjGDRZ0bQey0nXAzseBcjYIt65GqbWGU0w=
Subject: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Date:   Sat, 24 Jun 2023 12:30:45 +0200
Message-Id: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANXFlmQC/x2N0QqDMAwAf0XyvEDXbSL7lbGHtKYzIFHSOgbiv
 y/4eAfH7VDZhCs8ux2Mv1JlUYfrpYM8kX4YZXSGGOIt9PGOqy0ZlRtWbtSa4VAC9WngFMsDPEt
 UGZOR5slD3ebZ5Wpc5Hd+Xu/j+APEn6XrdwAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687602663; l=1198;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WAQxIZy8y/wxN8eDcQ6zJJABtAxVwhMmcahqLn9v8OM=;
 b=UbMcSrK5SnNWXGQAzqQMKF99lxxGYIZv3CqZ9Nf0TkWhbguoT1+BXcBrY4mcu2+RbBptDeM2a
 ervAB0i4iHBBdMQmh9ujn6K87D+8dzgD1kgmdDWOs2lDLsenDBBBz41
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

/proc/$PID/net currently allows the setting of file attributes,
in contrast to other /proc/$PID/ files and directories.

This would break the nolibc testsuite so the first patch in the series
removes the offending testcase.
The "fix" for nolibc-test is intentionally kept trivial as the series
will most likely go through the filesystem tree and if conflicts arise,
it is obvious on how to resolve them.

Technically this can lead to breakage of nolibc-test if an old
nolibc-test is used with a newer kernel containing the fix.

Note:

Except for /proc itself this is the only "struct inode_operations" in
fs/proc/ that is missing an implementation of setattr().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      selftests/nolibc: drop test chmod_net
      proc: use generic setattr() for /proc/$PID/net

 fs/proc/proc_net.c                           | 1 +
 tools/testing/selftests/nolibc/nolibc-test.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
---
base-commit: a92b7d26c743b9dc06d520f863d624e94978a1d9
change-id: 20230624-proc-net-setattr-8f0a6b8eb2f5

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

