Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADD4471EB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 00:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhLLX0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 18:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLLX0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:26:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E6C06173F;
        Sun, 12 Dec 2021 15:26:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id np3so10627507pjb.4;
        Sun, 12 Dec 2021 15:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctOJj8vJSmnF76Xt+fHesBQwdRI5nVKPOOT2SR7P/UM=;
        b=GgSWkvd4FpN4nbu4R29EPGAFY7CTibo7886UnPAuEw1Q5jTTXV2sxhQMXeeE3JKMKF
         Gj7U0HNiTBYV8oVRPGDTaF1YJsMRbIfA702iEhBmPn3JPTeoDHk0iHoW+Hj661s+myPS
         oCNy670TVe2Bnimacg39fQ0bECckRySCOwx35eXu7K9ckvg931y8SPwY9nXMH/ZlW5k2
         HM0RJjV6URZiq0Lg34GUbrwMkjuGgbC71o9b0Qsc6SHzFxoNGxqBfGYSL4nkXcXMyWdX
         2MesXH6XvyeJuu7ygxd7q25BBWOjXJgc0Dq3Nf6/b22Os3U4JTi8Kmk5WqDVxykReGHv
         ONpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctOJj8vJSmnF76Xt+fHesBQwdRI5nVKPOOT2SR7P/UM=;
        b=d6/1f6+Wc/jaY+4dbu/s9BG1qZ7ipMOwPhyX8Jki1Udpdznt1pLLkONqVtpKyw0yoR
         2MZ5sCZpEf34U0mF2+QJqO2rvC7qE5lmyV6JvEeBMOAgg4HsYys10svlrMsLYpqkACPI
         sgR2b2n/eLH2cRfCMbpQ7CbsBQlPoa7C87JX2KBOYlkyBcVrahXHxOIX8loZJAM0he2D
         VvWkELhAH/yAezttd9cTqeeq9kOuLO9/GSo9V6B+fUVgyydSyf54wyWiVsaojXEmitRU
         uAvqk9TTyHkvbPgbXbAnckskeg5aBJFEnEVzizI+vbk0Ye3z3UQl3S5fbyteiepREtKe
         1emQ==
X-Gm-Message-State: AOAM532hO5PeKSZxpF+kAgWVMQHTk9CgnuJGY6nlmavCKU1zu6XyOIbM
        LkheUgvXkd6Q155mNDde95Y=
X-Google-Smtp-Source: ABdhPJyxGJjbdiqAXgsTy5dRoaDxViHSM1EU+RoMH+oCBw3/Gkep6S45mmYFhZOOElbZmuUNnLuWIQ==
X-Received: by 2002:a17:902:cecf:b0:141:e15d:4a2a with SMTP id d15-20020a170902cecf00b00141e15d4a2amr91205431plg.66.1639351564167;
        Sun, 12 Dec 2021 15:26:04 -0800 (PST)
Received: from hibiki.localdomain ([2400:2410:93a3:bc00:c35d:e29e:99a3:5fd9])
        by smtp.googlemail.com with ESMTPSA id j7sm5281813pjf.41.2021.12.12.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 15:26:03 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] [PATCH v4 0/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Mon, 13 Dec 2021 08:24:10 +0900
Message-Id: <20211212232414.1402199-1-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.34.1
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

