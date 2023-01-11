Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A719C6660DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 17:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjAKQnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 11:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjAKQmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:42:42 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC6164B4;
        Wed, 11 Jan 2023 08:42:13 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673455331;
        bh=oPHeqffJWnugBEy5BfA0S5pz/LFEC+mvhbSZ1LgHT58=;
        h=From:Date:Subject:To:Cc:From;
        b=uC9H5QXx7fmv+zhsei6EGCF/6P/ONA27ENwGoqmlOvXE491AVx4VG+fYsmyTxdToD
         smpW96FSWIu3Ql0VweMOclcGL4zNUzBfeQ2rqr1rtqPm+hlwsNk1PIvX15W0QT3a7W
         rwA3pQ0yLvFXXhGlvdBvGtCP5Ixol6EzzqdQC1mo=
Date:   Wed, 11 Jan 2023 16:42:07 +0000
Subject: [PATCH RESEND] nsfs: add compat ioctl handler
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221214-nsfs-ioctl-compat-v1-1-3180bf297a02@weissschuh.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrey Vagin <avagin@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>
Cc:     Karel Zak <kzak@redhat.com>,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673455329; l=1998;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=oPHeqffJWnugBEy5BfA0S5pz/LFEC+mvhbSZ1LgHT58=;
 b=tzvA9e99k86pJFluK36zg2SRWMLBn1EeQhsLRb6yMGnq59eSxNS8B/XA0kkQdc3HO7R7O5l+XtQA
 b3I2140ODuPWNtO7N2RYz5akkOlebbCFDv3vLRnsBcIZVTaCd2Wu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As all parameters and return values of the ioctls have the same
representation on both 32bit and 64bit we can reuse the normal ioctl
handler for the compat handler.

All nsfs ioctls return a plain "int" filedescriptor which is a signed
4-byte integer type on both 32bit and 64bit.
The only parameter taken is by NS_GET_OWNER_UID and is a pointer to a
"uid_t" which is a 4-byte unsigned integer type on both 32bit and 64bit.

Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")
Reported-By: Karel Zak <kzak@redhat.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
As all parameters and return values of the ioctls have the same
representation on both 32bit and 64bit we can reuse the normal ioctl
handler for the compat handler.

All nsfs ioctls return a plain "int" filedescriptor which is a signed
4-byte integer type on both 32bit and 64bit.
The only parameter taken is by NS_GET_OWNER_UID and is a pointer to a
"uid_t" which is a 4-byte unsigned integer type on both 32bit and 64bit.
---
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Andrey Vagin <avagin@openvz.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
To: Serge Hallyn <serge@hallyn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 3506f6074288..4d2644507364 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -21,6 +21,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 static const struct file_operations ns_file_operations = {
 	.llseek		= no_llseek,
 	.unlocked_ioctl = ns_ioctl,
+	.compat_ioctl   = ns_ioctl,
 };
 
 static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)

---
base-commit: f9ff5644bcc04221bae56f922122f2b7f5d24d62
change-id: 20221214-nsfs-ioctl-compat-1548bf6581a7

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
