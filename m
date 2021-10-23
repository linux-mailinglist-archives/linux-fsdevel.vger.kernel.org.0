Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6C4383AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 14:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhJWMmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 08:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhJWMmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 08:42:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22778C061764
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Oct 2021 05:39:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d3so5519614wrh.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Oct 2021 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6m9KMXq10sd0LgKyQ7VCVBdgivuTw6mgEkLsiybFb+g=;
        b=DEcMcleHgzLfWdqhsNUx21U/VVvU57lS+9/N9zxvQ9ENS4oma1B3gUzr6wpXYtoPSP
         pNZStak3pqrX0yHKR7PIniClbOAbjg5znaY4YiFfYLzp952Ohx3gnoSqkN4dmSOySRxV
         807YlpZRzD1uMiIMZ+D94EGW3GIgE6JwXxepB5dUlv2cxscYuPNlRhvi8yvk2wm8PWIC
         MX9ElopRj9izIgyN2aY/2QaOANQ+EFvObIHp048yQ0iOOP5kknCMzSvQIVli8VIavGsO
         TsF8chb2rvkGKuCrgJQzCq5ZKiitTZavn2KBdXWuM5MtzkxrqWokk6N47lFzOV/5XjXA
         /feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6m9KMXq10sd0LgKyQ7VCVBdgivuTw6mgEkLsiybFb+g=;
        b=yHbim3jIRNDQaJRrJXY+AIpN/c/kPrEr6CBFsMqrmoY8HQ8hBnY7dLCRfObzfT1qJh
         6BO7Juk45663WtkkDa7CiQD2pEMfbr5B8gifmjWoYamxeUvYaH3YTW/Kqv1ChTrVZZKd
         O1bVVYbkbcD0DLFq0K1U/r+cd3vOuWwl+OikFSmVPYxXsEWEW3668MOraQoDFTpTOtyp
         a4XSVgyuA6KPgaPcTx0d+ZBYSiMc2mEevozcDU01vO6eVQpkYLBZeoQk+gcKJucSPpSj
         cZpZlKPZkLXPWXi8byHlFq++LfURjZqPM1QK2EwVwKHZRRNpfxbxqUMi3dEc4LrmdC2V
         UD7w==
X-Gm-Message-State: AOAM530p+qzb8t5QiYM2ZvPSSuvtYnkzfDk07ymri9hl/OEc5yn/8fow
        FaRg+/wAKn4flGd4TA8BnrWGO2nRNA==
X-Google-Smtp-Source: ABdhPJylI+ulHp2inuQ8WdZbZqc2rVq5JXwcKwGTwlrdlsAbAXtr51hDOWf92CFXztrhGLy15WMCng==
X-Received: by 2002:adf:d1c3:: with SMTP id b3mr7560640wrd.237.1634992794307;
        Sat, 23 Oct 2021 05:39:54 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.50])
        by smtp.gmail.com with ESMTPSA id x21sm13559905wmc.14.2021.10.23.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 05:39:54 -0700 (PDT)
Date:   Sat, 23 Oct 2021 15:39:52 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] dup: delete error write to stack variable on common path
Message-ID: <YXQCmPai9Sn0qF0T@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/file.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/file.c
+++ b/fs/file.c
@@ -291,10 +291,11 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 	unsigned int open_files, i;
 	struct fdtable *old_fdt, *new_fdt;
 
-	*errorp = -ENOMEM;
 	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
-	if (!newf)
+	if (!newf) {
+		*errorp = -ENOMEM;
 		goto out;
+	}
 
 	atomic_set(&newf->count, 1);
 
