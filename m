Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0EA64934E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 10:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiLKJ2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 04:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiLKJ2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 04:28:44 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA794DFE1;
        Sun, 11 Dec 2022 01:28:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670750905; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=cQkedRHhiBcjvDmL5SSj3EN64o2w3Gdj4WQMOf5RefBfQMjq/+8+W3nedGE85dJreENyBpyyy6iC+XXF3/SDAC9xPJ9gtr/CoF5lM9hvftcJmTm/jQ6AxJyDO5OkK58+fUo9m5lalB1JrBySAs8sKfAAhQrEpIKVilEFcLSR2fc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1670750905; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Xkq9oi0Kqa5o104HB6937If/FFeLhwwTtuDxZaE+Zqc=; 
        b=BmvVCaLPZNXJPRRR8p8V21FhXHRjWLtxnX1kvMyxp67EI9JohzrjT6viQohiV0vLPJEizk59EokjXMnZ/BsQkjYFS9tsi077ahmtbcgizXDM6K/DmvVTWqTWZcYZYMxNgV3XAAM2jJU4U8WE2TU0CjTohBZs60HrGWgpw+VQy5w=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670750905;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Xkq9oi0Kqa5o104HB6937If/FFeLhwwTtuDxZaE+Zqc=;
        b=JaFqXGITxG+8CXPDWBNTgz3m6SybcsAHvkQOzRwpwLfpjAZI6lGKfCwH6hIlbdAR
        YyKYElShH/6sH2X1xmvZe5hyjtFmSYfcSY/C2fjGTOr4lx2S8TMV05mwBpvP1BjNcON
        l6ZLI5y4f+pF6Wj+3mZuV2EVcggZE12q6iZd+VEU=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1670750904303896.6418334535564; Sun, 11 Dec 2022 14:58:24 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftests <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20221211092820.85527-1-code@siddh.me>
Subject: [PATCH] selftests/mount_setattr: Remove redefinition of struct mount_attr
Date:   Sun, 11 Dec 2022 14:58:20 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is already included via sys/mount.h on line 10.

GCC error reproducible by: make kselftest TARGETS=3D"mount_setattr"

mount_setattr_test.c:107:8: error: redefinition of =E2=80=98struct mount_at=
tr=E2=80=99
  107 | struct mount_attr {
      |        ^~~~~~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/mount.h:32,
                 from mount_setattr_test.c:10:
../../../../usr/include/linux/mount.h:129:8: note: originally defined here
  129 | struct mount_attr {
      |        ^~~~~~~~~~

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/t=
ools/testing/selftests/mount_setattr/mount_setattr_test.c
index 8c5fea68ae67..582669ca38e9 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -103,13 +103,6 @@
 =09#else
 =09=09#define __NR_mount_setattr 442
 =09#endif
-
-struct mount_attr {
-=09__u64 attr_set;
-=09__u64 attr_clr;
-=09__u64 propagation;
-=09__u64 userns_fd;
-};
 #endif
=20
 #ifndef __NR_open_tree
--=20
2.35.1


