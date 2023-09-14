Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7B7A09EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbjINP7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjINP7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:59:42 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B3B1BDD;
        Thu, 14 Sep 2023 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694707175;
        bh=Xy4oeT6FjD8v9CNOFPDcyJo8MblgPr/wtL46w5RATVs=;
        h=From:Date:Subject:To:Cc:From;
        b=g2rkURrGUFg0K+EhUVCYp685HNlgScL0D2NzEVczWqYwfzzi/rc6T5Vn9Yby0Xy7r
         DwYlgXlIhIgLE/VU0l/udDlI59wIy+ytT6mnHylWjJAEBk4lzAjWvAfXxcnoQq13ow
         CIw5EuBzT+MCNAHJuV7B1xBVr7WC/I4Xz7WsulX0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 14 Sep 2023 17:59:21 +0200
Subject: [PATCH RFC] binfmt_elf: fully allocate bss pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANgtA2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0MT3aTiYt3EnJz8ZN00UyPjtEQzQ3NDi2QloPqCotS0zAqwWdFKQW7
 OSrG1tQBPM4vQYAAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sebastian Ott <sebott@redhat.com>,
        stable@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707174; l=2558;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Xy4oeT6FjD8v9CNOFPDcyJo8MblgPr/wtL46w5RATVs=;
 b=dTmJBTY1kUzVp+M5Za8hnGEaOf2h8wZGp7RZPk+6qvGpvWNyDehekRbLjiD5C3wwkK8yAX1ss
 O3djcKTCYWTBg81Hxaq4IjMd6XfZUwlec4bCQ7Bj9DnYzPrJupLCwi8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When allocating the pages for bss the start address needs to be rounded
down instead of up.
Otherwise the start of the bss segment may be unmapped.

The was reported to happen on Aarch64:

Memory allocated by set_brk():
Before: start=0x420000 end=0x420000
After:  start=0x41f000 end=0x420000

The triggering binary looks like this:

    Elf file type is EXEC (Executable file)
    Entry point 0x400144
    There are 4 program headers, starting at offset 64

    Program Headers:
      Type           Offset             VirtAddr           PhysAddr
                     FileSiz            MemSiz              Flags  Align
      LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
                     0x0000000000000178 0x0000000000000178  R E    0x10000
      LOAD           0x000000000000ffe8 0x000000000041ffe8 0x000000000041ffe8
                     0x0000000000000000 0x0000000000000008  RW     0x10000
      NOTE           0x0000000000000120 0x0000000000400120 0x0000000000400120
                     0x0000000000000024 0x0000000000000024  R      0x4
      GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                     0x0000000000000000 0x0000000000000000  RW     0x10

     Section to Segment mapping:
      Segment Sections...
       00     .note.gnu.build-id .text .eh_frame
       01     .bss
       02     .note.gnu.build-id
       03

Reported-by: Sebastian Ott <sebott@redhat.com>
Closes: https://lore.kernel.org/lkml/5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

I'm not really familiar with the ELF loading process, so putting this
out as RFC.

A example binary compiled with aarch64-linux-gnu-gcc 13.2.0 is available
at https://test.t-8ch.de/binfmt-bss-repro.bin
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7b3d2d491407..4008a57d388b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -112,7 +112,7 @@ static struct linux_binfmt elf_format = {
 
 static int set_brk(unsigned long start, unsigned long end, int prot)
 {
-	start = ELF_PAGEALIGN(start);
+	start = ELF_PAGESTART(start);
 	end = ELF_PAGEALIGN(end);
 	if (end > start) {
 		/*

---
base-commit: aed8aee11130a954356200afa3f1b8753e8a9482
change-id: 20230914-bss-alloc-f523fa61718c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

