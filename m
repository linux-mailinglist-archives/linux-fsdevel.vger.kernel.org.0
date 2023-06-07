Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7E72678E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjFGRjV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 13:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFGRjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:39:20 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7CF19BF;
        Wed,  7 Jun 2023 10:39:19 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1686159557;
        bh=5rDKXRphCm5hSfMg9E8EiHD7LdAzDPAqz+JpNaExDw4=;
        h=From:Date:Subject:To:Cc:From;
        b=mFHce8rx1V8uP6l1qFTVenfj+CTczcwBtCpvW70GtF4Af+paLIRNu2aqEWbSnQGGK
         DfkQ1jf4jrgfw4QegZ7L4ZV9r1Mzk04lSSG9tAAblwegNvFcknwLLeHuR6YH/WEQDi
         qzVNK6hLY9KrlHnjKpwZt9zqAPWfu3Sh5Jmj99Lc=
Date:   Wed, 07 Jun 2023 19:39:09 +0200
Subject: [PATCH v2] fs: avoid empty option when generating legacy mount
 string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230607-fs-empty-option-v2-1-ffd0cba3bddb@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALzAgGQC/3WNQQ6CMBBFr0K6dkxbtBhX3MOwoGWwTbCQTkEJ4
 e6O7F2+n//yNkGYApK4F5tIuAQKY2TQp0I438YnQuiYhZa6lEZW0BPga8orjFPmL2hzNVqXleK
 DYMu2hGBTG51nL87DwOOUsA+fI/NomH2gPKb1qC7qt/4PLAoUaOlune0vplK2fmMgIudnf46YR
 bPv+xdCAgQ7yAAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzag@redhat.com>, stable@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686159556; l=1435;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5rDKXRphCm5hSfMg9E8EiHD7LdAzDPAqz+JpNaExDw4=;
 b=oUJfE7kshkS/8Wb6safwZYMONGGPt/Ujmta4e4tMx9loVGy9BsmaNub0Ov05930vOSSL3xSae
 xKlmNP8i6/2AUp3wEoyVOHZqA7Po6WyW1JsRyxMY+xRIxpfTOuGVzfO
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

As each option string fragment is always prepended with a comma it would
happen that the whole string always starts with a comma.
This could be interpreted by filesystem drivers as an empty option and
may produce errors.

For example the NTFS driver from ntfs.ko behaves like this and fails when
mounted via the new API.

Link: https://github.com/util-linux/util-linux/issues/2298
Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Mention Cc stable@ in sign-off area
- Link to v1: https://lore.kernel.org/r/20230607-fs-empty-option-v1-1-20c8dbf4671b@weissschuh.net
---
 fs/fs_context.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 24ce12f0db32..851214d1d013 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -561,7 +561,8 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -ENOMEM;
 	}
 
-	ctx->legacy_data[size++] = ',';
+	if (size)
+		ctx->legacy_data[size++] = ',';
 	len = strlen(param->key);
 	memcpy(ctx->legacy_data + size, param->key, len);
 	size += len;

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230607-fs-empty-option-265622371023

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

