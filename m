Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926A06660EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 17:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAKQqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 11:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjAKQqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:46:36 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F358AE014;
        Wed, 11 Jan 2023 08:46:34 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673455592;
        bh=LXP8YNxMczzf+pLAFEBraHS71TcH5D0s/f2HVc8xxo4=;
        h=From:Date:Subject:To:Cc:From;
        b=Yc7Axi0+ryvHb7W5TZEecULFxIr2/k+ULGBcJLv9MmdtQxO+I2KUWWZhT+VjMwDhh
         AuhOjhBzWEPa37T9RGGPkGImtbwdT0GKR92tM6q+85o807NPlBRqR5TU2Xa3osqSOC
         IEFMfTOd6P1rWxkPurgdnJC4vi+5VxrlFP3enSU8=
Date:   Wed, 11 Jan 2023 16:46:30 +0000
Subject: [PATCH RESEND v3] nsfs: add compat ioctl handler
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221214-nsfs-ioctl-compat-v3-1-dce2d26e1fec@weissschuh.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrey Vagin <avagin@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673455590; l=1768;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LXP8YNxMczzf+pLAFEBraHS71TcH5D0s/f2HVc8xxo4=;
 b=ZgToiTDahdoWp0LhjVZMSRvT+AAWvdKPw60kow4YX/v6R6SPspt8FjTS/3efh5vLpJ83nXZvASoX
 nyhNP5wUAJRM+BuYiO+2gubO1tKh+erPxDYgV+xtmNS40ENURsj3
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
handler for the compat handler via compat_ptr_ioctl().

All nsfs ioctls return a plain "int" filedescriptor which is a signed
4-byte integer type on both 32bit and 64bit.
The only parameter taken is by NS_GET_OWNER_UID and is a pointer to a
"uid_t" which is a 4-byte unsigned integer type on both 32bit and 64bit.

Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")
Reported-by: Karel Zak <kzak@redhat.com>
Link: https://github.com/util-linux/util-linux/pull/1924#issuecomment-1344133656
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Resend without changes
  v1 and v2 did not reach the mailing lists due to an issue in my mail setup
- Link to v2: https://lore.kernel.org/r/20221214-nsfs-ioctl-compat-v2-0-b295bb3913f6@weissschuh.net

Changes in v2:
- Use compat_ptr_ioctl()
- Link to v1: https://lore.kernel.org/r/20221214-nsfs-ioctl-compat-v1-0-b169796000b2@weissschuh.net
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 3506f6074288..c28f69edef97 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -21,6 +21,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 static const struct file_operations ns_file_operations = {
 	.llseek		= no_llseek,
 	.unlocked_ioctl = ns_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
 };
 
 static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)

---
base-commit: f9ff5644bcc04221bae56f922122f2b7f5d24d62
change-id: 20221214-nsfs-ioctl-compat-1548bf6581a7

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
