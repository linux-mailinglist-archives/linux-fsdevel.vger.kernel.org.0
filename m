Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3577BEF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 19:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHNR32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjHNR2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:28:54 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F10133
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:53 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51d8823eb01so2981347a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034131; x=1692638931;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I4DS/YlxNmOox1c27eCaqLGJBbviyQCQLdr4ik+75g=;
        b=dn6wV5cPvNZKX03rb32KhTDsukig7Bms7xNRGpjVXK09qtjB9MLIwQAdVOb52dKz9E
         sTFa9TPwVfy7egxQlmB8ROefEjQvaIDYbvNYcnhRjXt9Z5tiRkj4gTp3vMnuGXlUzeKn
         caiE+w5v30zU5gExpyRoXm5suCwuwnrH+e2r+mZGWh4Y+CdPRW64RJJfdWF1ULWBAIvu
         drhod+vEQx4TC5L/Mn0sltYeCzWqclPfx5ALdlgnF5jnBb6ClqTCbzzakUK5d5PUSYzc
         /mJ0t1Zsj3TL3St4T3I2iaA0TRapoU8i6dsNsHsx+mb+v3oYcU04CVs29LtHhJu3bjhk
         K92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034131; x=1692638931;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8I4DS/YlxNmOox1c27eCaqLGJBbviyQCQLdr4ik+75g=;
        b=Jzmf14ZquqR5A8ogXVCUirVfmkXBhDWkdwB9UNKSpdCFosFdkvHKxZPoLmg5O2Lu99
         T4rR5c02h5JqglDykqMbq3vKJx2euOT3+JieaT3cBRZlL4A0WzuVpV020ZsoK5DqJGK3
         OKHUDh+iH3nBLsvy3NzscLRnjVbVTXlyaETyKwRVPeBBWPwWm8Qj8HoAjtg/YnyBf2g3
         H9GK6WcR6N1lE5Rtz94Sxq56nPwT6MzogNFpN8pCMEfFIH58o5K0563v4GU8iVIiT/wY
         lWjTKDCQCQ/WVTQlFSYEQzmc6Gx103ofZUoJ0+MeiNfiKMQ+iDThaZMfVX7RmS8NKVgH
         MJIA==
X-Gm-Message-State: AOJu0YziDbYo3HYb8OR26d9HAZLzf2/hcY5LzcfW9r4hPAaIVqwyWepJ
        rQErabOGsmxU45v+salKjkFDmnGFF8Y=
X-Google-Smtp-Source: AGHT+IE9tbEGtqoeewRDiaw2yxih9oE5UnmOdWjA0xrpCULVju6BtbNNMGtN5Jc4P3qVHy8VaS2QkrbRKXU=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9ca9:bbb1:765a:e929])
 (user=gnoack job=sendgmr) by 2002:a50:d49d:0:b0:51b:ee9e:aad1 with SMTP id
 s29-20020a50d49d000000b0051bee9eaad1mr68391edi.2.1692034131560; Mon, 14 Aug
 2023 10:28:51 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:28:15 +0200
In-Reply-To: <20230814172816.3907299-1-gnoack@google.com>
Message-Id: <20230814172816.3907299-5-gnoack@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Subject: [PATCH v3 4/5] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add ioctl support to the Landlock sample tool.

The ioctl right is grouped with the read-write rights in the sample
tool, as some ioctl requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e2056c8b902c..c70d96d15c70 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -77,7 +77,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
@@ -162,11 +163,12 @@ static int populate_ruleset(const char *const env_var=
, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
-#define LANDLOCK_ABI_LAST 3
+#define LANDLOCK_ABI_LAST 4
=20
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -255,6 +257,10 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 	case 2:
 		/* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
 		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_TRUNCATE;
+		__attribute__((fallthrough));
+	case 3:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 4 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
=20
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
--=20
2.41.0.694.ge786442a9b-goog

