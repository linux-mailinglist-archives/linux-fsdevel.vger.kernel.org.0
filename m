Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EAD72631A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjFGOmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 10:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbjFGOmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:42:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CCA1BFB;
        Wed,  7 Jun 2023 07:42:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30ae141785bso7298823f8f.3;
        Wed, 07 Jun 2023 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686148951; x=1688740951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bhU8rJcA/NcmdBFZbG66fI16dsKgmepn+1tYIFC8M3Y=;
        b=bXFeImhQdmhi+fiXTrYziTug2rbzZLXJhrXLvGxWuoZ2j7UukUjIt8sAoeX/RF7xv1
         UIJtUOm842Gd3oYnQ4uc1hb6B6+MA/hfg9r4H3Hd6U/vNOPgejThO0dav7DufAtYCl6M
         OXksAOKE/B4XZh3jUtATnWfvmYd1VDBw/RG6ydD8TjwOGxCr0qRJpccgdXxC4PzOkW82
         C172foUptIBBIPMcXeHlpmSncRBj4r7KkYtmXktu4geGFPXgytJEs/WoCzv66A8gl82e
         cAzEr8z+geaUgs3Dh6Jpsl6ZP5g8P1kUAtcjHd9ee+vbQVvkFS3oh0pIi4d0mkaXUPkR
         tPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686148951; x=1688740951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhU8rJcA/NcmdBFZbG66fI16dsKgmepn+1tYIFC8M3Y=;
        b=crtewVQk8Z8j86s3wql2vppzG2uJfC5QkicP7TLrPlOFkeQgX9qCOGX47zn5R+pbrE
         M6r9XS76MUOpQ2GR5bLD8PsWbJXyIJ1NPuCQo54y+4BPinACkZzOZ/xZe3NcapolcvLx
         OL76W8b/4n+PDLJAPCgH3etDlUmqmBz5XLTVXYdY+mP6v0GLRDWY+3xD2K0IgtoidJAS
         weoy9V5Y+HXRwRNJF6MA4S3/V17IYvgZ81WD1JsftUSW0/0SH8c/tNJqIm6K5dXVGUib
         ujN7OKRjXQWjlY1xgyIdly1oCflS5VN/iPcMRyORCqI2eZQC8eAqP+rk50x3yqqHUh9B
         XmtQ==
X-Gm-Message-State: AC+VfDxYHoPt/b5QbjZZjz41TOl42rfbuEaT/ZjV5rgJKaWPSNqMwGMK
        aM1Z5t8w05I9OhZtwaW2e5dTEpNg7Ls=
X-Google-Smtp-Source: ACHHUZ7FmpM3xOpynYg+M/k9K8xzWpLPv+zJIL90yhFnNkyAYSdt5QSHjwTQLv7gvto2a7w0M12KrQ==
X-Received: by 2002:a5d:408f:0:b0:309:4368:a8a0 with SMTP id o15-20020a5d408f000000b003094368a8a0mr4476903wrp.68.1686148950971;
        Wed, 07 Jun 2023 07:42:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id z12-20020a5d4d0c000000b003068f5cca8csm15731342wrt.94.2023.06.07.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:42:30 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] binfmt_elf: dynamically allocate note.data in parse_elf_properties
Date:   Wed,  7 Jun 2023 16:42:27 +0200
Message-Id: <20230607144227.8956-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dynamically allocate note.data in parse_elf_properties to fix
compilation warning on some arch.

On some arch note.data exceed the stack limit for a single function and
this cause the following compilation warning:
fs/binfmt_elf.c: In function 'parse_elf_properties.isra':
fs/binfmt_elf.c:821:1: error: the frame size of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  821 | }
      | ^
cc1: all warnings being treated as errors

Fix this by dynamically allocating the array.
Update the sizeof of the union to the biggest element allocated.

Fixes: 00e19ceec80b ("ELF: Add ELF program property parsing support")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org # v5.8+
---
 fs/binfmt_elf.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 44b4c42ab8e8..90daa623ca13 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -768,7 +768,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 {
 	union {
 		struct elf_note nhdr;
-		char data[NOTE_DATA_SZ];
+		char *data;
 	} note;
 	loff_t pos;
 	ssize_t n;
@@ -785,29 +785,41 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 		return -ENOEXEC;
 
 	/* If the properties are crazy large, that's too bad (for now): */
-	if (phdr->p_filesz > sizeof(note))
+	if (phdr->p_filesz > sizeof(*note.data) * NOTE_DATA_SZ)
 		return -ENOEXEC;
 
+	note.data = kcalloc(NOTE_DATA_SZ, sizeof(*note.data), GFP_KERNEL);
+	if (!note.data)
+		return -ENOMEM;
+
 	pos = phdr->p_offset;
 	n = kernel_read(f, &note, phdr->p_filesz, &pos);
 
-	BUILD_BUG_ON(sizeof(note) < sizeof(note.nhdr) + NOTE_NAME_SZ);
-	if (n < 0 || n < sizeof(note.nhdr) + NOTE_NAME_SZ)
-		return -EIO;
+	BUILD_BUG_ON(sizeof(*note.data) * NOTE_DATA_SZ < sizeof(note.nhdr) + NOTE_NAME_SZ);
+	if (n < 0 || n < sizeof(note.nhdr) + NOTE_NAME_SZ) {
+		ret = -EIO;
+		goto exit;
+	}
 
 	if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
 	    note.nhdr.n_namesz != NOTE_NAME_SZ ||
 	    strncmp(note.data + sizeof(note.nhdr),
-		    GNU_PROPERTY_TYPE_0_NAME, n - sizeof(note.nhdr)))
-		return -ENOEXEC;
+		    GNU_PROPERTY_TYPE_0_NAME, n - sizeof(note.nhdr))) {
+		ret = -ENOEXEC;
+		goto exit;
+	}
 
 	off = round_up(sizeof(note.nhdr) + NOTE_NAME_SZ,
 		       ELF_GNU_PROPERTY_ALIGN);
-	if (off > n)
-		return -ENOEXEC;
+	if (off > n) {
+		ret = -ENOEXEC;
+		goto exit;
+	}
 
-	if (note.nhdr.n_descsz > n - off)
-		return -ENOEXEC;
+	if (note.nhdr.n_descsz > n - off) {
+		ret = -ENOEXEC;
+		goto exit;
+	}
 	datasz = off + note.nhdr.n_descsz;
 
 	have_prev_type = false;
@@ -817,6 +829,8 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 		have_prev_type = true;
 	} while (!ret);
 
+exit:
+	kfree(note.data);
 	return ret == -ENOENT ? 0 : ret;
 }
 
-- 
2.39.2

