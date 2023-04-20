Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3836E93A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjDTMGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjDTMGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:06:14 -0400
X-Greylist: delayed 105 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 05:06:11 PDT
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:df01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD0A19AF;
        Thu, 20 Apr 2023 05:06:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:7f29:0:640:9a2b:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 4AFA56082B;
        Thu, 20 Apr 2023 15:04:23 +0300 (MSK)
Received: from vsementsov-nix.yandex.net (unknown [2a02:6b8:b081:b58f::1:1d])
        by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id C4dVdH1Or4Y0-LN2mPFV8;
        Thu, 20 Apr 2023 15:04:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1681992262; bh=+Up1ucyvwcaXiWbgdfd9BwoNS2gW3y73aYKQDaLXdUM=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=sSrVGXUTVayl51clBd2Sjz72jObckMVdj0XrzZxAuNIxFN6h0cThC+qs0g85A/PMk
         N12Mam6BMTYc8avDLPkibyYQtcKyNHYfo07zAjY+eUa5qs2d75K2At7XDU6I/DNSLi
         Pv0bKfWdZ7LH+QmO9nOOVQS6A6R5CakFMPZ5Rrn0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     vsementsov@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of O_RDWR
Date:   Thu, 20 Apr 2023 15:04:09 +0300
Message-Id: <20230420120409.602576-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This makes it possible to make stricter apparmor profile and don't
allow the program to read any coredump in the system.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5df1e6e1eb2b..8f263a389175 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -646,7 +646,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	} else {
 		struct mnt_idmap *idmap;
 		struct inode *inode;
-		int open_flags = O_CREAT | O_RDWR | O_NOFOLLOW |
+		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
 				 O_LARGEFILE | O_EXCL;
 
 		if (cprm.limit < binfmt->min_coredump)
-- 
2.34.1

