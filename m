Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE648D29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfFQS6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 14:58:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45321 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfFQS6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:58:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so11117660wre.12;
        Mon, 17 Jun 2019 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mCDxrhP7EqkmdhHH46Pj5TcEQUpB+h4rCRcvORanpUY=;
        b=DBAb4YEmM+jz1n+QtH0wYLE97fKfOTmZcSIV+NaQJTmlVLmGbUnc2+soL6YHenDjiX
         jUt5g69A7nVhfi+Zhgr82w2VlOIzewv7cOKO5+709vhUv6TqREu+JriPgYLSkHlmXGh8
         zWwV+yHbW0Z9MZTvPxxiT2U3AaXHwQ1VEBIdHRsCfMWNtIrckFBiNYaA1NN/2gGx4S7v
         L9kmlQ/gCPHuPudN8jp5LhXk9j106vx1jguHhysvmQX0ty4y7z4FcGaA8M9G+caJHyMM
         FGLkjdXMJO6UrEBcMkaS30B635w1HzUxF01qHb0aTM1k6vxTAeAeuYTjCeDBSNZ/f8dS
         dW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mCDxrhP7EqkmdhHH46Pj5TcEQUpB+h4rCRcvORanpUY=;
        b=oF4j9m1fyJz8aSwG3rclaKjE5MuVYHREkt/ydw4v6cVSB/W+Nh5hilKpeoF/cReBXk
         QS9n6+cJJgfaX6YFO074ZXME2i8HPQjYjyXgu9A5+3KXiBB3+Ev//NFWVnkwobDcbdKg
         AV6+wpNnHzNV4++pRmeGWmJAJBRgCTbGuGu3JmAt3eOZ3C8QXGZuJCxkdvNvmn4RrfI5
         EpvlKnc2YszjnJfvgVsKbHC8jh/lqdK33FI/9v1YHg55tJ8pRA/GG46BHYtiyBqEHi4M
         rTGZrVLV4ci84U/R0ggfz+oRv+Az8gDRU8FveSr5vO5r39eWsfqfufc1DF0I6/PyHemy
         xkmQ==
X-Gm-Message-State: APjAAAWKN0U1YD9lzSvSftIfmSUZvQBSVo1zlAAwAzC0cavaEMLylUcc
        imhuJMPcWf1NiytAf/j0oOvN8syVOZQ=
X-Google-Smtp-Source: APXvYqwLjHcv9HZhEUzFhT+iONX1MSkr9RNwDLKgrXDrhfXv9O/B7RTsplVZg8ytzJsOaSJjYvh3Rw==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr61009115wrw.73.1560797918826;
        Mon, 17 Jun 2019 11:58:38 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-219-150.red.bezeqint.net. [79.178.219.150])
        by smtp.gmail.com with ESMTPSA id a7sm11159391wrs.94.2019.06.17.11.58.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:58:37 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     viro@zeniv.linux.org.uk, carmeli.tamir@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/binfmt: Changed order of elf and misc to prevent privilege escalation
Date:   Mon, 17 Jun 2019 14:58:15 -0400
Message-Id: <20190617185815.3949-1-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The misc format handler is configured to work in many boards
and distributions, exposing a  volnurability that enables an 
attacker with a temporary root access to configure the system
to gain a hidden persistent root acces. This can be easily 
demonstrated using https://github.com/toffan/binfmt_misc .

According to binfmt_misc documentation 
(https://lwn.net/Articles/679310/), the handler is used
to execute more binary formats, e.g. execs compiled
for different architectures. After this patch, every 
mentioned example in the documentation shall work.

I tested this patch using a "positive example" - running
and ARM executable on an x86 machine using a qemu-arm misc 
handler, and a "negative example" of running the demostration 
by toffan I mention above. Before the patch both examples 
work, and after the patch only the positive example work
where the volnurability is prevented.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 fs/binfmt_elf.c  | 2 +-
 fs/binfmt_misc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d4e11b2e04f6..3a2afe84943c 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2411,7 +2411,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 static int __init init_elf_binfmt(void)
 {
-	register_binfmt(&elf_format);
+	insert_binfmt(&elf_format);
 	return 0;
 }
 
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index b8e145552ec7..f4a9e1154cae 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -859,7 +859,7 @@ static int __init init_misc_binfmt(void)
 {
 	int err = register_filesystem(&bm_fs_type);
 	if (!err)
-		insert_binfmt(&misc_format);
+		register_binfmt(&misc_format);
 	return err;
 }
 
-- 
2.21.0

