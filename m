Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038B1471EBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 00:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhLLX0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 18:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLLX0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:26:10 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41061C06173F;
        Sun, 12 Dec 2021 15:26:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so11410314pjb.1;
        Sun, 12 Dec 2021 15:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VPgJ1ZBLaK/SiagUA6D9HAxFkvBdjZ231S8nVD4HBTw=;
        b=is57SjJ9xqNBarx0n4Vk534QOYj8BHnKZF73nSjXe9GbI7dvwch167JJVmmWbuEuf3
         deXtGrRUy7AHKKbHEydBkqST2P6OVr+s+9kdPTfw8OKsP2ki1xG/1WFV3rKiwQ8rQWKt
         Zk4fUp3qFUQx2+75NxeFPKqmDMXUqNQOyhdeAbyA29UP8hTEebU1OJLm2FI6A8C/93IC
         i3c/Wha599TbznIQkwVFn24RHcYe9aSS92LlQQXIyColBfE3BfwXzvY/eAWMKzRghwVo
         HXV0nFmagUxpk7weP3FLPA+fj4aEMRDpSYI/9gO7ApLLc8CNIp4BvGsvOPrLcIF13dxT
         K4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPgJ1ZBLaK/SiagUA6D9HAxFkvBdjZ231S8nVD4HBTw=;
        b=4XAWVNVDJO1DFp6Wz69oIDVbwiuWJ9PfRzG5dG+wo/Hj4mfot0dh/ZNs4XrmtoJbF/
         MLHy5Mu5w5XaiqsfjPoplfC9W4Iw0mfSOsR2e/iPGmjTxeHOXfeK8PbZcSsumCLt0OLd
         JPPddP7FcVuUmx6vJkR97oCUAMN+PB8R+nr+sg4bRg37EmhClZsI7ApijKGI6nfYi2AU
         PRhy7JEc8wLOzzIqSEIdzl/b9DT3ngKK5CiW8ZFnyLfJW5Fo94q3h2KUFhzZypdfz49F
         t0voLwhfgYCH8663WcSwY4yMsUjQNSMU9TM8hrnQIsBrmog17bKGH2yd8xzJYXCCmnLb
         azmA==
X-Gm-Message-State: AOAM533Ts04H+I4wtqvgQkoxF8GoWlPiNTBiii80hFzYzSoIYBOf2nsB
        i7NaeLscPcj1Fa1AdYYxuOY=
X-Google-Smtp-Source: ABdhPJwmr/72M7D6BGWLOVaz9yexRjS/+7GPdZFZVtvw73f3q6iLs0O6FlEeAO1wbWydGVhLVbQiCg==
X-Received: by 2002:a17:902:64c2:b0:141:c171:b99b with SMTP id y2-20020a17090264c200b00141c171b99bmr91121139pli.55.1639351569799;
        Sun, 12 Dec 2021 15:26:09 -0800 (PST)
Received: from hibiki.localdomain ([2400:2410:93a3:bc00:c35d:e29e:99a3:5fd9])
        by smtp.googlemail.com with ESMTPSA id j7sm5281813pjf.41.2021.12.12.15.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 15:26:09 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] fs/binfmt_elf: Refactor load_elf_binary function
Date:   Mon, 13 Dec 2021 08:24:12 +0900
Message-Id: <20211212232414.1402199-3-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211212232414.1402199-1-akirakawata1@gmail.com>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I delete load_addr because it is not used anymore. And I rename
load_addr_set to first_pt_load because it is used only to capture the
first iteration of the loop.

Signed-off-by: Akira Kawata <akirakawata1@gmail.com>
---
 fs/binfmt_elf.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 828e88841cb4..48206fd1a20e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -822,8 +822,8 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 static int load_elf_binary(struct linux_binprm *bprm)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
-	unsigned long load_addr, load_bias = 0, phdr_addr = 0;
-	int load_addr_set = 0;
+	unsigned long load_bias = 0, phdr_addr = 0;
+	int first_pt_load = 1;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
@@ -1073,12 +1073,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		vaddr = elf_ppnt->p_vaddr;
 		/*
-		 * The first time through the loop, load_addr_set is false:
+		 * The first time through the loop, first_pt_load is true:
 		 * layout will be calculated. Once set, use MAP_FIXED since
 		 * we know we've already safely mapped the entire region with
 		 * MAP_FIXED_NOREPLACE in the once-per-binary logic following.
 		 */
-		if (load_addr_set) {
+		if (!first_pt_load) {
 			elf_flags |= MAP_FIXED;
 		} else if (elf_ex->e_type == ET_EXEC) {
 			/*
@@ -1138,10 +1138,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		/*
 		 * Calculate the entire size of the ELF mapping (total_size).
-		 * (Note that load_addr_set is set to true later once the
+		 * (Note that first_pt_load is set to false later once the
 		 * initial mapping is performed.)
 		 */
-		if (!load_addr_set) {
+		if (first_pt_load) {
 			total_size = total_mapping_size(elf_phdata,
 							elf_ex->e_phnum);
 			if (!total_size) {
@@ -1158,13 +1158,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			goto out_free_dentry;
 		}
 
-		if (!load_addr_set) {
-			load_addr_set = 1;
-			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
+		if (first_pt_load) {
+			first_pt_load = 0;
 			if (elf_ex->e_type == ET_DYN) {
 				load_bias += error -
 				             ELF_PAGESTART(load_bias + vaddr);
-				load_addr += load_bias;
 				reloc_func_desc = load_bias;
 			}
 		}
-- 
2.34.1

