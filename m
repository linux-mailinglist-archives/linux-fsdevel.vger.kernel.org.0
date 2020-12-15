Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57AD2DA6F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 04:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLODrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 22:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgLODrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:47:25 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC423C06179C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 19:46:44 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z9so13648244qtn.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 19:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYojc7vmSWu8GGbZzz8wSzFwi9UD9yKVFssMaSFOz4E=;
        b=cxNYjJg+7NdMB14Z5XtqPZXDK0od69p7qRpGSar5CDZ4xRFqrvT9q/JwvFWV0DfIlQ
         vwwEK4brInRkmfIZfVveyRgV8eilKm1nXctMpFDiqG5YYHS8tKGqfppFBnrkCbkZBQlk
         f+z/pf/k82MvH5iFJvM68J3yNIIsBmhmzdLLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYojc7vmSWu8GGbZzz8wSzFwi9UD9yKVFssMaSFOz4E=;
        b=aHSm+B2SZosPgWBzMXT4akXrg7UlPhs6Jz75jAyH+Y8nH6Km08fM8TgaKLQw2vDHfC
         4UfNH6zSRxkLMX8sigD5sJ8IBUC5tHxABw9EWV1LzrB0NGByFjW7cVKjd1ffxl65a3Tq
         wxOjxW8W6yOLS+caGPTzgzvcOH7F8zWv5qI6olV1ToJMo4L39NJMYEbop70AQdu+MoF8
         hiQnU/zeXUzDlSEiwE31y64KfVw7pNv3Um2l7Yk8oNMoEKiyR/96pL1BEKgLR/0LxK1B
         Nw5xwB8NC2mcYWTxYb1IE7kU4ogv2fu+BIV7WQzVWbOiUOzUn3qq5LmH9IIDea4ESMVi
         EmpQ==
X-Gm-Message-State: AOAM533ZL2DShNSn7vWdRlgm/B9JmmfWPYrdBKFp4lSCTyOPAcHibhDC
        87zzaudyAklgfp1pinH8gwOTAw==
X-Google-Smtp-Source: ABdhPJxPf19Kdr4KFMfSV7jHvy20v0SozN5vkifuDIFXKJf6B5W/YIDAhY7HdABYJ4kBx1+oDz7xEA==
X-Received: by 2002:ac8:4553:: with SMTP id z19mr15025033qtn.278.1608004003819;
        Mon, 14 Dec 2020 19:46:43 -0800 (PST)
Received: from yamaha.cs.unc.edu (yamaha.cs.unc.edu. [152.2.129.229])
        by smtp.gmail.com with ESMTPSA id v128sm16199511qkc.126.2020.12.14.19.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 19:46:43 -0800 (PST)
From:   Joshua Bakita <jbakita@cs.unc.edu>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joshua Bakita <jbakita@cs.unc.edu>
Subject: [RESEND,PATCH] fs/binfmt_elf: Fix regression limiting ELF program header size
Date:   Mon, 14 Dec 2020 22:46:24 -0500
Message-Id: <20201215034624.1887447-1-jbakita@cs.unc.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to a
function") merged load_elf_binary and load_elf_interp into
load_elf_phdrs. This change imposed a limit that the program headers of
all ELF binaries are smaller than ELF_MIN_ALIGN. This is a mistake for
two reasons:
1. load_elf_binary previously had no such constraint, meaning that
   previously valid ELF program headers are now rejected by the kernel as
   oversize and invalid.
2. The ELF interpreter's program headers should never have been limited to
   ELF_MIN_ALIGN (and previously PAGE_SIZE) in the first place. Commit
   057f54fbba73 ("Import 1.1.54") introduced this limit to the ELF
   interpreter alongside the initial ELF parsing support without any
   explanation.
This patch removes the ELF_MIN_ALIGN size constraint in favor of only
relying on an earlier check that the allocation will be less than 64KiB.
(It's worth mentioning that the 64KiB limit is also unnecessarily strict,
but that's not addressed here for simplicity. The ELF manpage says that
the program header size is supposed to have at most 64 thousand entries,
not less than 64 thousand bytes.)

Fixes: 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to a function")
Signed-off-by: Joshua Bakita <jbakita@cs.unc.edu>
---
 fs/binfmt_elf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 2472af2798c7..55162056590f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -412,15 +412,11 @@ static struct elf_phdr *load_elf_phdrs(struct elfhdr *elf_ex,
 	/* Sanity check the number of program headers... */
 	if (elf_ex->e_phnum < 1 ||
 		elf_ex->e_phnum > 65536U / sizeof(struct elf_phdr))
 		goto out;
 
-	/* ...and their total size. */
 	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
-	if (size > ELF_MIN_ALIGN)
-		goto out;
-
 	elf_phdata = kmalloc(size, GFP_KERNEL);
 	if (!elf_phdata)
 		goto out;
 
 	/* Read in the program headers */
-- 
2.25.1

