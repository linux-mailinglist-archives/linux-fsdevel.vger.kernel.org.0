Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDBE471EBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 00:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhLLX0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 18:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhLLX0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:26:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C49C061751;
        Sun, 12 Dec 2021 15:26:13 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso11911851pjl.3;
        Sun, 12 Dec 2021 15:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctOJj8vJSmnF76Xt+fHesBQwdRI5nVKPOOT2SR7P/UM=;
        b=jo+24lFJcxt3qqQNc8+NeBsLXAsIyX16cXHSxlMHuqtNj3VT4ZsmrHwqYOny1oS6xB
         JKwIe7V0HifhYcrEizhSQivE3t2QilCbT63FJ5pNcb+vnMVoccPmBXt+2poQyn8dGFvU
         pA9J6AGUeoKEhvLTyQ/YwuVXILhcBRM65P+N2qk3T2WUqNEtxckr94Un99ERpZDQNHuv
         jSFpJADdh4+BudAcP3IiVeExGMHRekM/0ZLpyjd0YCPyGRx7Aq0ys6GKYQRNDp7t4GPQ
         ow1gOk4uzRe4+sGe/cMwHoBQ0j7KMy4ChPnv9YI0wlE6NcHrGi4fvA+d+vT0rIgtCK5B
         eRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctOJj8vJSmnF76Xt+fHesBQwdRI5nVKPOOT2SR7P/UM=;
        b=hCywlKjaNeUiJ0ThaPkoouH4/d3nbXdAGxQv09wAwEmuOZZqaEhQkirocJeHJiZz/I
         9fqqZCqWGdiyU2qclmb2hH4Gk+w7c5sutSgbyAlTB2Z9dRoMfIEoIsZ0L2VfsEAyJKLK
         MX3Smfy55uxyZPIRAko8l+uLM+fouzULntqye5i6Xo+XJ/diAH+uO0pndOX5SRAFdrs7
         alXqb4EkS71Ndxr31BexgT9mGB3xGYPRyHvdSg7Wq75WnkrAbv8SX6mJ7btaH2lIKNS2
         yFsqlNT6U9UafFEeZFtZitlEK5HuFnKPQ//kCgZuRjqXTCJ2OHvIOQJowuzshwQY/K/L
         aTIw==
X-Gm-Message-State: AOAM5334Ew7tPC6HNA95E0grLnb+Eg/B4jq6pwSzIgOU/zIeKO27pk+l
        3sIqq1G0yxMxpuHbYL7bW64=
X-Google-Smtp-Source: ABdhPJzrqF/gEj2i1ezXqTVMLlMrUMDjZNj+Te5nF/SKd0akmFwBfGSYvDiD6aiQC6reOC6n/tlFmA==
X-Received: by 2002:a17:902:e293:b0:146:953c:e0ca with SMTP id o19-20020a170902e29300b00146953ce0camr40613581plc.40.1639351572518;
        Sun, 12 Dec 2021 15:26:12 -0800 (PST)
Received: from hibiki.localdomain ([2400:2410:93a3:bc00:c35d:e29e:99a3:5fd9])
        by smtp.googlemail.com with ESMTPSA id j7sm5281813pjf.41.2021.12.12.15.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 15:26:12 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] [PATCH v4 0/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Mon, 13 Dec 2021 08:24:13 +0900
Message-Id: <20211212232414.1402199-4-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211212232414.1402199-1-akirakawata1@gmail.com>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 These patches fix a bug in AT_PHDR calculation. 
 
 We cannot calculate AT_PHDR as the sum of load_addr and exec->e_phoff.
 This is because exec->e_phoff is the offset of PHDRs in the file and the
 address of PHDRs in the memory may differ from it. These patches fix the
 bug by calculating the address of program headers from PT_LOADs
 directly.
 
 Sorry for my latency.
 
 Changes in v4
 - Reflecting comments from Lukas, add a refactoring commit.
 
 Changes in v3:
 - Fix a reported bug from kernel test robot.
 
 Changes in v2:
 - Remove unused load_addr from create_elf_tables.
 - Improve the commit message.

Akira Kawata (2):
  fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
  fs/binfmt_elf: Refactor load_elf_binary function

 fs/binfmt_elf.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)


base-commit: 4eee8d0b64ecc3231040fa68ba750317ffca5c52
-- 
2.34.1

