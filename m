Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27837368AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjFTKD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjFTKDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:03:02 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 03:02:14 PDT
Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A9F1707;
        Tue, 20 Jun 2023 03:02:13 -0700 (PDT)
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by forward202a.mail.yandex.net (Yandex) with ESMTP id C02DB494FC;
        Tue, 20 Jun 2023 12:56:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 3E99F46D20;
        Tue, 20 Jun 2023 12:55:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Utd7jIuDca60-1Wx2nAVR;
        Tue, 20 Jun 2023 12:55:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687254951;
        bh=G9Y9dMrT6FQOwfuA3r+IFC4b4bwCTthKlJeujdIJm70=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=PywmBlbr/auoIhmihGCTALiqPbeNVDX47HbGdTQz2kcwFNI9qdjQUtsQOwZ41xlDp
         iMx5cWAXXgslcT0ETY8F+nu9XmzyTPXXiMrHXoSQ+Xm6/+IBFSixtk39mwvpkNEceO
         i7sTeRVDWP1vCoPVtbwqRotHm0Zm1Ztirjs8DTpw=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Date:   Tue, 20 Jun 2023 14:55:06 +0500
Message-Id: <20230620095507.2677463-3-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620095507.2677463-1-stsp2@yandex.ru>
References: <20230620095507.2677463-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently F_OFD_GETLK sets the pid of the lock owner to -1.
Remove such behavior to allow getting the proper owner's pid.
This may be helpful when you want to send some message (like SIGKILL)
to the offending locker.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org

---
 fs/locks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 210766007e63..ee265e166542 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2158,8 +2158,6 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 	pid_t vnr;
 	struct pid *pid;
 
-	if (IS_OFDLCK(fl))
-		return -1;
 	if (IS_REMOTELCK(fl))
 		return fl->fl_pid;
 	/*
-- 
2.39.2

